<template>
  <div id="app">
    <navbar></navbar>
    <router-view></router-view>
    <p class="footer">© 2020 cocoa-engineer</p>
  </div>
</template>

<script>
import Vue from "vue";
import VueRouter from "vue-router";

import Header from "header.vue";
import Search from "search.vue";
import Index from "index.vue";

const router = new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/searches",
      name: "Search",
      component: Search
    },
    {
      path: "/",
      name: "Index",
      component: Index
    }
  ]
});

Vue.use(VueRouter);

export default {
  router,
  components: {
    navbar: Header
  }
};
</script>

<style scoped>
.footer {
  text-align: center;
}

#app {
  font-family: "Nico Moji";
}
</style>
