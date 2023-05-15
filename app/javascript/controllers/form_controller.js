import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // this.element.textContent = "Hello World!"
    console.log('Form controller connected');
  }

  textClick(){
    console.log('Text Clicked');
  }
}
