<template>
  <div>
    <div v-if="!keyword">
      <div class="container text-center">
        <div class="btn" @click="music">
          <a class="btn btn-border-shadow btn-border-shadow--color2">音楽</a>
        </div>
        <div class="btn" @click="sports">
          <a class="btn btn-border-shadow btn-border-shadow--color2">スポーツ</a>
        </div>
        <div class="btn" @click="funny">
          <a class="btn btn-border-shadow btn-border-shadow--color2">お笑い</a>
        </div>
        <div class="btn" @click="anime">
          <a class="btn btn-border-shadow btn-border-shadow--color2">アニメ</a>
        </div>
        <div class="btn" @click="game">
          <a class="btn btn-border-shadow btn-border-shadow--color2">ゲーム</a>
        </div>
        <div class="btn" @click="news">
          <a class="btn btn-border-shadow btn-border-shadow--color2">ニュース</a>
        </div>
        <div class="btn covid-pc" @click="covid">
          <a class="btn btn-border-shadow btn-border-shadow--color2">コロナ関連</a>
        </div>
        <div class="btn covid-phone" @click="covid">
          <a class="btn btn-border-shadow btn-border-shadow--color2 covid-phone">コロナ</a>
        </div>
        <div class="container text-center">
          <router-link to="/searches" class="keyword-search">
            <div class="btn search-pc" @click="music">
              <a class="btn btn-border-shadow btn-border-shadow--color2">キーワード検索</a>
            </div>
            <div class="btn search-phone" @click="music">
              <a class="btn btn-border-shadow btn-border-shadow--color2">検索</a>
            </div>
          </router-link>
        </div>
      </div>
    </div>
    <div class="text-center" v-if="keyword">
      <div class="keyword font-weight-bold">{{ keyword }}</div>
      <div class="container">
        <a class="btn btn-border-shadow btn-border-shadow--color2" @click="viewCount">再生回数ランキング</a>
        <a class="btn btn-border-shadow btn-border-shadow--color2" @click="date">最新動画</a>
      </div>
      <div class="container">
        <a class="btn btn-border-shadow btn-border-shadow--color2" @click="resetKeyword">戻る</a>
      </div>
    </div>
    <div>
      <div v-for="item in items" v-if="items" v-bind:id="item.id.videoId">
        <div class="item-list">
          <a v-bind:href="'https://www.youtube.com/watch?v=' + item.id.videoId" target="_blank">
            <img :src="item.snippet.thumbnails.medium.url" />
            {{ item.snippet.title }}
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
let alert = document.getElementsByClassName("errors-list");
let alert_box = document.getElementsByClassName("error-box");

import axios from "axios";

export default {
  data: function() {
    return {
      errors: [],
      items: [],
      keyword: ""
    };
  },
  methods: {
    music() {
      this.keyword = "音楽";
      this.relevance(this.keyword);
    },
    sports() {
      this.keyword = "スポーツ";
      this.relevance(this.keyword);
    },
    funny() {
      this.keyword = "お笑い";
      this.relevance(this.keyword);
    },
    anime() {
      this.keyword = "アニメ";
      this.relevance(this.keyword);
    },
    game() {
      this.keyword = "ゲーム";
      this.relevance(this.keyword);
    },
    news() {
      this.keyword = "ニュース";
      this.relevance(this.keyword);
    },
    covid() {
      this.keyword = "コロナ";
      this.relevance(this.keyword);
    },
    resetKeyword() {
      this.keyword = "";
      this.items = [];
    },
    // デフォルト検索
    relevance(payload) {
      axios
        .get("/api/v1/searches", {
          params: {
            keyword: payload,
            order: "relevance"
          }
        })
        .then(
          response => {
            this.items.length = 0;
            if (!response.data.length) {
              for (let i = 0; i < alert.length; i++) {
                alert[i].style.display = "block";
              }
              this.errors.push("指定されたジャンルの動画が存在しません");
              setTimeout(function() {
                for (let i = 0; i < alert.length; i++) {
                  alert[i].style.display = "none";
                }
              }, 2000);
            }
            for (let i = 0; i < response.data.length; i++) {
              this.items.push(response.data[i]);
            }
          },
          error => {
            console.log(error);
          }
        );
    },
    // 再生回数ランキング
    viewCount() {
      axios
        .get("/api/v1/searches", {
          params: {
            keyword: this.keyword,
            order: "viewCount"
          }
        })
        .then(
          response => {
            this.items.length = 0;
            if (!response.data.length) {
              for (let i = 0; i < alert.length; i++) {
                alert[i].style.display = "block";
              }
              this.errors.push("指定されたジャンルの動画が存在しません");
              setTimeout(function() {
                for (let i = 0; i < alert.length; i++) {
                  alert[i].style.display = "none";
                }
              }, 2000);
            }
            for (let i = 0; i < response.data.length; i++) {
              this.items.push(response.data[i]);
            }
          },
          error => {
            console.log(error);
          }
        );
    },
    // 最新動画
    date() {
      axios
        .get("/api/v1/searches", {
          params: {
            keyword: this.keyword,
            order: "date"
          }
        })
        .then(
          response => {
            this.items.length = 0;
            if (!response.data.length) {
              for (let i = 0; i < alert.length; i++) {
                alert[i].style.display = "block";
              }
              this.errors.push("指定されたジャンルの動画が存在しません");
              setTimeout(function() {
                for (let i = 0; i < alert.length; i++) {
                  alert[i].style.display = "none";
                }
              }, 2000);
            }
            for (let i = 0; i < response.data.length; i++) {
              this.items.push(response.data[i]);
            }
          },
          error => {
            console.log(error);
          }
        );
    }
  }
};
</script>

<style scoped>
.errors-list {
  animation: fadeOut 2s;
  animation-fill-mode: both;
}

.error-box {
  text-align: center;
  margin-top: 40px;
  color: red;
  font-size: 1.2rem;
}

@keyframes fadeOut {
  0% {
    opacity: 1;
  }
  100% {
    opacity: 0;
  }
}

.keyword {
  font-size: 22px;
  margin: 30px;
  position: relative;
  padding: 1rem 2rem calc(1rem + 10px);
  background: #ffff77;
}

.keyword:before {
  position: absolute;
  top: -7px;
  left: -7px;
  width: 100%;
  height: 100%;
  content: "";
  border: 4px solid #000;
}

.keyword-search {
  text-decoration: none;
  color: #888888;
}

*:before,
*:after {
  -webkit-box-sizing: inherit;
  box-sizing: inherit;
}

html {
  -webkit-box-sizing: border-box;
  box-sizing: border-box;
  font-size: 62.5%;
}

/* 背景用*/
.btn,
a.btn,
button.btn {
  font-size: 1.6rem;
  font-weight: 700;
  line-height: 1.5;
  position: relative;
  display: inline-block;
  padding: 1rem 4rem;
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  -ms-user-select: none;
  user-select: none;
  -webkit-transition: all 0.3s;
  transition: all 0.3s;
  text-align: center;
  vertical-align: middle;
  text-decoration: none;
  letter-spacing: 0.1em;
  color: #212529;
  border-radius: 0.5rem;
  margin: 10px;
}

.covid-pc {
  display: block;
}

.covid-phone {
  display: none;
}

.search-pc {
  display: block;
}

.search-phone {
  display: none;
}

a.btn-border-shadow {
  padding: calc(1.5rem - 12px) 3rem 1.5rem;

  background: #fff;
}

a.btn-border-shadow:before {
  position: absolute;
  top: -6px;
  left: -6px;

  width: 100%;
  height: 100%;

  content: "";
  -webkit-transition: all 0.3s ease;
  transition: all 0.3s ease;

  border: 3px solid #000;
  border-radius: 0.5rem;
}

a.btn-border-shadow:hover {
  padding: calc(1.5rem - 6px) 3rem;
}

a.btn-border-shadow:hover:before {
  top: 0;
  left: 0;
}

a.btn-border-shadow--color2 {
  border-radius: 100vh;
}

a.btn-border-shadow--color2:before {
  border-radius: 100vh;
  -webkit-box-shadow: 3px 3px 0 #78e5e5;
  box-shadow: 3px 3px 0 #78e5e5;
}

@media screen and (max-width: 480px) {
  /* 480px以下に適用されるCSS（スマホ用） */
  .btn,
  a.btn,
  button.btn {
    font-size: 1rem;
  }

  .covid-pc {
    display: none;
  }

  .covid-phone {
    display: block;
  }

  .search-pc {
    display: none;
  }

  .search-phone {
    display: block;
  }

  .error-box {
    font-size: 1rem;
  }
}
</style>
