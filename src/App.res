type file

type headers = {
  "Content-Type": string,
  "Prediction-Key": string
}

type fetchParams = {
  method: string,
  body: file,
  headers
}

@bs.scope("Math") @bs.val external round: float => float = "round"
@bs.scope("URL") @bs.val external createObjectUrl: {..} => string = "createObjectURL"
@bs.val external fetch: (string, fetchParams) => Js.Promise.t<'a> = "fetch"
@bs.val external alert: (string) => () = "alert"

let url = "https://trainedcorgiorbread.cognitiveservices.azure.com/customvision/v3.0/Prediction/bf9fe12a-3250-455a-9394-e0663e408f07/classify/iterations/Iteration1/image"
let key = "b33287da19da4498b77e4b93e4411480"
let contentType = "application/octet-stream"

let processResponse = %raw(`
  async function(response, process) {
    try {
      const responseValue = await response
      const json = await responseValue.json()
      process(json)
    } catch (err) {
      console.error("Whoops!", err)
    }
  }
`)

let displayPrediction = (prediction: {..}) => {
  let probability = prediction["probability"]
  let tagName = prediction["tagName"]
  alert(`${Belt.Float.toString(round(probability *. 10000.0) /. 100.0)}% sure it's a ${tagName}`)  
} 

let processJson = (json: {..}) => {
  let predictions = json["predictions"]
  predictions->Belt.Array.forEach(displayPrediction)
}

@react.component
let make = () => {
  let (image, setImage) = React.useState(_ => None)

  let onChange = (event) => {
    let newFile = ReactEvent.Form.target(event)["files"]["0"]
    setImage(_ => Some(newFile))

    let response = fetch(url, {
      method: "POST",
      body: newFile,
      headers: {
        "Content-Type": contentType,
        "Prediction-Key": key
        }
    })

    processResponse(response, processJson)

    Js.log("Processing...")
  }

  let displayedImage = switch image {
    | Some(imageToDisplay) => createObjectUrl(imageToDisplay)
    | None => ""
  }

  <div className=Stylez.mainBg>
    <img className=Stylez.previewImage src=displayedImage />
    <form>
      <input className=Stylez.fileInput onChange type_="file" />
    </form>
  </div>
}