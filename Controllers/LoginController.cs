using MvcFirmaCagri.Models.Entity;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;

namespace MvcFirmaCagri.Controllers
{
    public class LoginController : Controller
    {
        // GET: Login
        DbisTakipEntities1 db = new DbisTakipEntities1();
        public ActionResult Index()
        {
            return View();
        }
        [HttpPost]
        public ActionResult Index(TblFirmalar p)
        {
            // DEBUG için ekleyin - sonra silebilirsiniz
            if (string.IsNullOrEmpty(p.Mail) || string.IsNullOrEmpty(p.Sifre))
            {
                ViewBag.Hata = "Mail veya şifre boş!";
                return View();
            }

            var bilgiler = db.TblFirmalar.FirstOrDefault(x => x.Mail == p.Mail && x.Sifre == p.Sifre);
            if (bilgiler != null)
            {
                FormsAuthentication.SetAuthCookie(bilgiler.Mail, false);
                Session["Mail"] = bilgiler.Mail.ToString();
                return RedirectToAction("AktifCagrilar", "Default");
            }
            else
            {
                ViewBag.Hata = "Kullanıcı bulunamadı!";
                return View();
            }
        }
    }
}