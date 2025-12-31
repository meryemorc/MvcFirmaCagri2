using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Text;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace MvcFirmaCagri.Services
{
    public class OpenAIService
    {
        private readonly string _apiKey = "YOUR_API_KEY_HERE";
        private readonly HttpClient _httpClient;

        public OpenAIService()
        {
            _httpClient = new HttpClient();
            _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {_apiKey}");
        }

        // Çağrı Analizi
        public CagriAnaliz CagriAnalizYap(string konu, string aciklama)
        {
            try
            {
                var prompt = $@"
Aşağıdaki müşteri destek çağrısını analiz et:

Konu: {konu}
Açıklama: {aciklama}

Şunları belirle ve JSON formatında döndür:
1. aciliyet_seviyesi: 'Acil', 'Yüksek', 'Normal', veya 'Düşük'
2. oncelik_puani: 0-100 arası sayı
3. kategori: Hangi teknik kategori (örn: 'Veritabanı', 'Frontend', 'Backend', 'Network', 'Mobile', 'UI/UX', 'DevOps')
4. tahmini_sure: Tahmini çözüm süresi (örn: '1-2 saat', '2-3 saat')
5. onerilen_personel_id: En uygun personel ID'leri (1-10 arası, virgülle ayır, örn: '2,1,3')

Sadece JSON döndür, başka açıklama yapma.

Örnek format:
{{
  ""aciliyet_seviyesi"": ""Acil"",
  ""oncelik_puani"": 95,
  ""kategori"": ""Veritabanı - SQL Raporlama"",
  ""tahmini_sure"": ""1-2 saat"",
  ""onerilen_personel_id"": ""2,1,3""
}}";

                var result = CallOpenAI(prompt);

                // JSON parse et
                var analiz = JsonConvert.DeserializeObject<CagriAnaliz>(result);
                return analiz;
            }
            catch (Exception ex)
            {
                // Hata durumunda default değerler
                return new CagriAnaliz
                {
                    aciliyet_seviyesi = "Normal",
                    oncelik_puani = 50,
                    kategori = "Genel",
                    tahmini_sure = "2-3 saat",
                    onerilen_personel_id = "1"
                };
            }
        }

        // Personel Önerisi (detaylı)
        public PersonelOneri PersonelOner(string kategori, string aciklama, List<PersonelBilgi> personelListesi)
        {
            try
            {
                var personellerJson = JsonConvert.SerializeObject(personelListesi);

                var prompt = $@"
Çağrı Kategorisi: {kategori}
Açıklama: {aciklama}

Mevcut Personeller:
{personellerJson}

Bu çağrı için en uygun 3 personeli seç ve JSON formatında döndür:
{{
  ""personel_1"": {{
    ""id"": 2,
    ""uygunluk_yuzdesi"": 98,
    ""sebep"": ""Veritabanı uzmanı, benzer 23 sorun çözdü""
  }},
  ""personel_2"": {{
    ""id"": 1,
    ""uygunluk_yuzdesi"": 87,
    ""sebep"": ""DevOps deneyimi var""
  }},
  ""personel_3"": {{
    ""id"": 3,
    ""uygunluk_yuzdesi"": 65,
    ""sebep"": ""Backend genel bilgisi""
  }}
}}";

                var result = CallOpenAI(prompt);
                var oneri = JsonConvert.DeserializeObject<PersonelOneri>(result);
                return oneri;
            }
            catch
            {
                return null;
            }
        }

        private string CallOpenAI(string prompt)
        {
            try
            {
                var requestBody = new
                {
                    model = "gpt-4o-mini",
                    messages = new[]
                    {
                new { role = "system", content = "Sen bir teknik destek sistemi için analiz yapan asistansın. Sadece JSON formatında yanıt ver." },
                new { role = "user", content = prompt }
            },
                    temperature = 0.3,
                    max_tokens = 500
                };

                var json = JsonConvert.SerializeObject(requestBody);
                var content = new StringContent(json, Encoding.UTF8, "application/json");

                var response = _httpClient.PostAsync("https://api.openai.com/v1/chat/completions", content).Result;
                var responseString = response.Content.ReadAsStringAsync().Result;

                // HATA KONTROLÜ - RESPONSE STATUS
                if (!response.IsSuccessStatusCode)
                {
                    throw new Exception($"API Error: {response.StatusCode} - {responseString}");
                }

                var responseObj = JsonConvert.DeserializeObject<OpenAIResponse>(responseString);

                if (responseObj?.choices != null && responseObj.choices.Length > 0)
                {
                    var aiResponse = responseObj.choices[0].message.content.Trim();

                    // JSON temizleme
                    aiResponse = aiResponse.Replace("```json", string.Empty)
                                           .Replace("```", string.Empty)
                                           .Trim();

                    return aiResponse;
                }

                throw new Exception("API yanıtında 'choices' bulunamadı: " + responseString);
            }
            catch (Exception ex)
            {
                // DETAYLI HATA MESAJI
                throw new Exception("OpenAI API hatası: " + ex.Message + " | InnerException: " + ex.InnerException?.Message);
            }
        }
    }

    // Model sınıfları
    public class CagriAnaliz
    {
        public string aciliyet_seviyesi { get; set; }
        public int oncelik_puani { get; set; }
        public string kategori { get; set; }
        public string tahmini_sure { get; set; }
        public string onerilen_personel_id { get; set; }
    }

    public class PersonelOneri
    {
        public PersonelDetay personel_1 { get; set; }
        public PersonelDetay personel_2 { get; set; }
        public PersonelDetay personel_3 { get; set; }
    }

    public class PersonelDetay
    {
        public int id { get; set; }
        public int uygunluk_yuzdesi { get; set; }
        public string sebep { get; set; }
    }

    public class PersonelBilgi
    {
        public int ID { get; set; }
        public string AdSoyad { get; set; }
        public string Pozisyon { get; set; }
        public string UzmanlikAlani { get; set; }
        public int ToplamGorev { get; set; }
        public decimal BasariOrani { get; set; }
    }

    // OpenAI Response Models
    public class OpenAIResponse
    {
        public Choice[] choices { get; set; }
    }

    public class Choice
    {
        public Message message { get; set; }
    }

    public class Message
    {
        public string content { get; set; }
    }
}