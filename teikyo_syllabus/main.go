package main
 
import (
	"fmt"
	"log"
	"net/http"
 
	"github.com/PuerkitoBio/goquery"
)
 
const url = "https://www.e-campus.gr.jp/syllabus/kanri/hachioji/public/syllabus/2021"

func main() {
	res, err := http.Get(url)
	if err != nil {
		log.Println(err)
	}
	defer res.Body.Close()

	doc, _ := goquery.NewDocumentFromReader(res.Body)
	doc.Find(".all-button > .btn").Each(func(i int, s *goquery.Selection) {
		href, _ := s.Attr("href")
		var next_url string = "https://www.e-campus.gr.jp" + href
		fmt.Println(next_url)
	})
}