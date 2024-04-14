import express from "express";
import axios from "axios";
import dotenv from "dotenv";
import morgan from "morgan";
import cors from "cors";
dotenv.config();
const { CLIENT_ID, CLIENT_SECRET } = process.env;

const app = express();

app.use(cors());
app.use(morgan("dev"));
app.use(express.json());

app.use(async (req, res, next) => {
  // separate into its own middleware
  const payload = {
    client_id: CLIENT_ID,
    client_secret: CLIENT_SECRET,
    grant_type: "client_credentials",
  };
  const { data } = await axios.post(
    "https://id.twitch.tv/oauth2/token",
    payload,
    {
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      },
    },
  );
  req.accessToken = data.access_token;
  next();
});

app.get("/get-clips", async (req, res, next) => {
  try {
    const { data } = await axios.get("https://api.twitch.tv/helix/clips", {
      params: {
        broadcaster_id: "71092938",
        started_at: "2023-07-03T00:00:00Z",
      },
      headers: {
        Authorization: `Bearer ${req.accessToken}`,
        "Client-Id": CLIENT_ID,
      },
    });
    res.send(data);
  } catch (error) {
    next(error);
  }
});

app.get("/api/oauth/twitch/redirect", () => {
  res.send("this is working");
});

const { PORT = 8080 } = process.env;
app.listen(PORT, () => {
  console.log(`listening on PORT:${PORT}`);
});