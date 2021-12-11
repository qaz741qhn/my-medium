import { Controller } from "stimulus";
import axios from 'axios'

export default class extends Controller {
  static targets = ["clapCount"];

  addClap(event) {
    event.preventDefault()
    let slug = event.currentTarget.dataset.slug
    let target = this.clapCountTarget
    axios.post(`/stories/${slug}/clap`)
          .then(function(response) {
            let status = response.data.status
            switch (status) {
              case 'sign_in_first':
                alert('請先登入')
                break;
              default:
                target.innerHTML = status
            }
            console.log(response.data)
          })
          .catch(function(error) {
            console.error(error.response.data);
          })
    // this.clapCountTarget.innerHTML = "Clapped"
  }
}
