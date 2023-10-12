import reactLogo from './assets/react.svg'
import './App.css'
import { useState } from 'react'
import { useLayoutEffect } from 'react'

function App() {

  const [messages, setMessages] = useState<string[]>([])

  useLayoutEffect(() => {
    // @ts-ignore
    window.receiveMessageFromSwift = function (message) {
      setMessages((messages) => [...messages, message])
    }
  }, [])

  return (
    <>
      <div>
        <a href="https://react.dev" target="_blank">
          <img src={reactLogo} className="logo react" alt="React logo" />
        </a>
      </div>
      {messages.length > 0 && (<ul>
        {messages.map((message, index) => <li key={index}>{message}</li>)}
      </ul>)}
      <button onClick={() => {
        // @ts-ignore
        window.webkit.messageHandlers.fromJS.postMessage("Hello from React!")
      }}>Send message</button>
    </>
  )
}

export default App
