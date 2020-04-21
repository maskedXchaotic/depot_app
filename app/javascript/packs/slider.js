class SlideShow {
  constructor(options) {
    this.slideshowElements = options.slideshowElements;
    this.duration = options.duration;
  }

  init() {
    this.slideshowElements.hide();
    this.setSlideshowAnimation();
  }
  
  // Optional method for slideshow
  /* setSlideshowAnimation() {
    setInterval(() => {
      this.slideshowElements.each((idx, obj) => {
        setTimeout(() => {
          let slideshowObj = $(obj);
          this.slideshowElements.not(slideshowObj.fadeIn("slow")).hide();
        }, this.duration * idx)
      })
    }, this.slideshowElements.length * this.duration)
  } */

  sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }

  async setSlideshowAnimation() {
    for(let element of $.makeArray(this.slideshowElements)) {
      let slideshowElement = $(element)
      slideshowElement.fadeIn("slow")
      await this.sleep(this.duration)
      slideshowElement.hide()
    }
    this.setSlideshowAnimation()
  }
}

$(document).ready(function() {
  let options = {
    slideshowElements: $('[data-slideshow="true"]'),
    duration: 1000
  }

  let slideshowObject = new SlideShow(options);
  slideshowObject.init();
})  