import { Controller } from "stimulus";
import axios from "axios";

export default class extends Controller {
  static targets = ["followButton", "bookMark"];

  follow(event) {
    event.preventDefault();
    let user = this.followButtonTarget.dataset.user;
    let button = this.followButtonTarget
    axios.post(`/api/users/${user}/follow`)
          .then(function(response) {
            let status = response.data.status
            switch (status) {
              case "sign_in_first":
                alert("請先登入")
                break
              default:
                button.innerHTML = status
            }
              console.log(response.data)
            }
          )
          .catch(function(error) {
            console.error(error.response.data)
          })
  }

  bookmark(event) {
    event.preventDefault()
    let button = this.bookMarkTarget;
    let slug = event.currentTarget.dataset.slug;
    axios
      .post(`/api/stories/${slug}/bookmark`)
      .then(function (response) {
        let status = response.data.status;
        switch (status) {
          case "sign_in_first":
            alert("請先登入")
            break;
          case "Bookmarked":
            document.getElementById("bookmark").classList.add("fas")
            document.getElementById("bookmark").classList.remove("far")
            break;
          case "Unbookmarked":
            document.getElementById("bookmark").classList.add("far")
            document.getElementById("bookmark").classList.remove("fas")
            break;
        }
        console.log(response.data);
      })
      .catch(function (error) {
        console.error(error.response.data);
      });
  }
}