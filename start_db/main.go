package main
 
import (
	"fmt"
	"log"
	"net/http"
 
	"github.com/PuerkitoBio/goquery"
)

func main() {
	// getCatgoryUrls()
	getComUrlByList()
}

func getCatgoryUrls()  {
	res, err := http.Get("https://startup-db.com/tags")
	if err != nil {
		log.Println(err)
	}
	defer res.Body.Close()

	doc, _ := goquery.NewDocumentFromReader(res.Body)
	doc.Find(".tag-children-ul > li > a").Each(func(i int, s *goquery.Selection) {
		href, _ := s.Attr("href")
		var next_url string = `"https://startup-db.com` + href + `",`
		fmt.Println(next_url)
	})
}

func getComUrlByList()  {
	res, err := http.Get("https://startup-db.com/tags/cloud-funding")
	if err != nil {
		log.Println(err)
	}
	defer res.Body.Close()

	doc, _ := goquery.NewDocumentFromReader(res.Body)
	doc.Find(".CompanyCard > a").Each(func(i int, s *goquery.Selection) {
		href, _ := s.Attr("href")
		var next_url string = `"https://startup-db.com` + href + `",`
		fmt.Println(next_url)
	})
}