<template>
  <div>
    <div v-if="errors.length" class="error-box">
      <span v-for="error in errors" class="errors-list">{{ error }}</span>
    </div>
    <div>
      <div class="row justify-content-center">
        <div class="col-offset-2 col-sm-8 col-offset-2">
          <form @submit.prevent="exec">
            <input
              v-model="keyword"
              class="form-control text-center search-box"
              placeholder="キーワード検索"
            />
            <div class="text-center">
              <a v-on:click="exec" class="btn btn-border-shadow btn-border-shadow--color2">検索</a>
              <router-link to="/" class="keyword-search">
                <a class="btn btn-border-shadow btn-border-shadow--color2">戻る</a>
              </router-link>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="text-center" v-if="orderTerm">
      <div v-on:click="viewCount">
        <a class="btn btn-border-shadow btn-border-shadow--color2">再生回数ランキング</a>
      </div>
      <div v-on:click="date">
        <a class="btn btn-border-shadow btn-border-shadow--color2">最新動画</a>
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
      keyword: "",
      orderTerm: false
    };
  },
  methods: {
    exec: function() {
      this.errors.length = 0;
      if (!this.keyword) {
        this.errors.push("検索キーワードを入力してください");
      }
      if (this.errors.length) {
        for (let i = 0; i < alert.length; i++) {
          alert[i].style.display = "block";
        }
        setTimeout(function() {
          for (let i = 0; i < alert.length; i++) {
            alert[i].style.display = "none";
          }
        }, 2000);
        return;
      }

      axios
        .get("/api/v1/searches", {
          params: {
            keyword: this.keyword,
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
              this.errors.push("キーワードに関する動画が存在しません");
              setTimeout(function() {
                for (let i = 0; i < alert.length; i++) {
                  alert[i].style.display = "none";
                }
              }, 2000);
            }
            for (let i = 0; i < response.data.length; i++) {
              this.items.push(response.data[i]);
              this.orderTerm = true;
            }
          },
          error => {
            console.log(error);
          }
        );
    },
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
              this.errors.push("キーワードに関する動画が存在しません");
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
              this.errors.push("キーワードに関する動画が存在しません");
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
.search-box {
  margin-top: 70px;
  margin-bottom: 30px;
}

.item-list {
  margin: 15px;
}

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
body {
  padding: 30px;
}

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

.keyword-search {
  text-decoration: none;
  color: #888888;
}

@media screen and (max-width: 480px) {
  /* 480px以下に適用されるCSS（スマホ用） */
  .btn,
  a.btn,
  button.btn {
    font-size: 1rem;
  }

  .error-box {
    font-size: 1rem;
  }
}
</style>
