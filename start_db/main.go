package main
 
import (
	"fmt"
	"log"
	"net/http"
 
	"github.com/PuerkitoBio/goquery"
)
 
const url = "https://startup-db.com/tags"

func main() {
	res, err := http.Get(url)
	if err != nil {
		log.Println(err)
	}
	defer res.Body.Close()

	doc, _ := goquery.NewDocumentFromReader(res.Body)
	doc.Find(".tag-children-ul > li > a").Each(func(i int, s *goquery.Selection) {
		href, _ := s.Attr("href")
		var next_url string = `"https://startup-db.com` + href + `,"`
		fmt.Println(next_url)
	})
}