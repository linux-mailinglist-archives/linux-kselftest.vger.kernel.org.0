Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FF17CEB2D
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 00:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbjJRW1X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 18:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjJRW1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 18:27:21 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935A120
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 15:27:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9b95622c620so1263903966b.0
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Oct 2023 15:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697668035; x=1698272835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKT0DhFzK/7HUpXkHzrCihZCJECXU9c5i5HWV8bW/EM=;
        b=NN9SmvU2TJg1k06b6OhM/X5iwrPshR8TgLX6IJE3eX0j3o+09mvNILuymNT79an4W8
         P9ydNx9uyvbwNLcxsxn3g6y0PIuEu3eBntnwumN/LCjLn2l9TkMM1NmYKmhFjrgV+sBV
         Fff59sWtx76MOYelgYUQ3k1pJQaHhMtRSsTGfbO+hBURUS/spU54kcswDZfBX3ARL27L
         bSo+TfB7IyONgQihkJjJoTyM8wA4iUkgo5MQH5PlMwB6zrBkZnAjujrfx554nQSvmeln
         DMUrGHv3uxd2v7VCtqc4t0QH1bOn39Jeu4pkdFH8JwdwNDyBd4N06WalJ2OeY7zafjwM
         QZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697668035; x=1698272835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKT0DhFzK/7HUpXkHzrCihZCJECXU9c5i5HWV8bW/EM=;
        b=TJgpLZx4mjvr8NRFjCvowVWEFvXEpzeTtG6RA/1ZI7pnsgueQqUALBJl+VpLuDWFsc
         UxXduAs36hHsjMxtWtwtQUb0HwIUE7b19n9A/1C2xL5I1PEgXJjd6GvrNDOevQgrWyvX
         KPKwUw/6tMlpMOWz3set/A/vx3YaBywMHSGVPBuN+cnMoqxewuSdzgK8D+o1snyp9xC6
         1Dym2Yz6vqKn6+rtzVa2RmZhCiOM6LVRBjwnT27oaM84LPusEhLCLtHbKlinUIrfTL6h
         zbP5aPuMb2jSzytM2LmqyzcjewT0BRjHyzCD+DFW9eTj6LaL4DPhL5Mv4SD5J+HJEC+m
         8rVA==
X-Gm-Message-State: AOJu0YxaMIWY1B5VXVrfGL7TyxrVNbexNRm61c7kfnH5OgOU6QeNTSpl
        7uyNERuehrYA30rap83BjWWK0OiBuzTQy8Bkk8RwXQ==
X-Google-Smtp-Source: AGHT+IHKpl2ijlZQSO51cM+Z8COTkTH4QpJBSq+LXSmEO/uccV7vxTLmHx/TF2yPMZHolRigJcKqb7McemsGrQI829g=
X-Received: by 2002:a17:907:3f13:b0:9ae:69b8:322b with SMTP id
 hq19-20020a1709073f1300b009ae69b8322bmr426010ejc.60.1697668034993; Wed, 18
 Oct 2023 15:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-2-nphamcs@gmail.com>
In-Reply-To: <20231017232152.2605440-2-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 18 Oct 2023 15:26:36 -0700
Message-ID: <CAJD7tkYAvi_WfzPb_zaq174FB+-kftmcqtUrHirTeB2NMhFcbA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: list_lru: allow external numa node and cgroup tracking
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> The interface of list_lru is based on the assumption that objects are
> allocated on the correct node/memcg, with this change it is introduced th=
e
> possibility to explicitly specify numa node and memcgroup when adding and
> removing objects. This is so that users of list_lru can track node/memcg
> of the items outside of the list_lru, like in zswap, where the allocation=
s
> can be made by kswapd for data that's charged to a different cgroup.
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

I prefer what Johannes suggested, making list_lru_add() and friends
take in the memcg and nid, and add list_lru_add_obj() (or similar) and
friends that assume the object is on the right node and memcg. This is
clearer and more explicit imo. I am not very familiar with list_lrus
though, so I'll leave this to folks who actually are.

> ---
>  include/linux/list_lru.h | 38 +++++++++++++++++++++++++++++++++++
>  mm/list_lru.c            | 43 +++++++++++++++++++++++++++++++++++-----
>  2 files changed, 76 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index b35968ee9fb5..0f5f39cacbbb 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -89,6 +89,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *memcg=
, struct mem_cgroup *paren
>   */
>  bool list_lru_add(struct list_lru *lru, struct list_head *item);
>
> +/**
> + * __list_lru_add: add an element to a specific sublist.
> + * @list_lru: the lru pointer
> + * @item: the item to be added.
> + * @memcg: the cgroup of the sublist to add the item to.
> + * @nid: the node id of the sublist to add the item to.
> + *
> + * This function is similar to list_lru_add(), but it allows the caller =
to
> + * specify the sublist to which the item should be added. This can be us=
eful
> + * when the list_head node is not necessarily in the same cgroup and NUM=
A node
> + * as the data it represents, such as zswap, where the list_head node co=
uld be
> + * from kswapd and the data from a different cgroup altogether.
> + *
> + * Return value: true if the list was updated, false otherwise
> + */
> +bool __list_lru_add(struct list_lru *lru, struct list_head *item, int ni=
d,
> +                   struct mem_cgroup *memcg);
> +
>  /**
>   * list_lru_del: delete an element to the lru list
>   * @list_lru: the lru pointer
> @@ -102,6 +120,18 @@ bool list_lru_add(struct list_lru *lru, struct list_=
head *item);
>   */
>  bool list_lru_del(struct list_lru *lru, struct list_head *item);
>
> +/**
> + * __list_lru_del: delete an element from a specific sublist.
> + * @list_lru: the lru pointer
> + * @item: the item to be deleted.
> + * @memcg: the cgroup of the sublist to delete the item from.
> + * @nid: the node id of the sublist to delete the item from.
> + *
> + * Return value: true if the list was updated, false otherwise.
> + */
> +bool __list_lru_del(struct list_lru *lru, struct list_head *item, int ni=
d,
> +                   struct mem_cgroup *memcg);
> +
>  /**
>   * list_lru_count_one: return the number of objects currently held by @l=
ru
>   * @lru: the lru pointer.
> @@ -136,6 +166,14 @@ static inline unsigned long list_lru_count(struct li=
st_lru *lru)
>  void list_lru_isolate(struct list_lru_one *list, struct list_head *item)=
;
>  void list_lru_isolate_move(struct list_lru_one *list, struct list_head *=
item,
>                            struct list_head *head);
> +/*
> + * list_lru_putback: undo list_lru_isolate.
> + *
> + * Since we might have dropped the LRU lock in between, recompute list_l=
ru_one
> + * from the node's id and memcg.
> + */
> +void list_lru_putback(struct list_lru *lru, struct list_head *item, int =
nid,
> +                     struct mem_cgroup *memcg);
>
>  typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
>                 struct list_lru_one *list, spinlock_t *lock, void *cb_arg=
);
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index a05e5bef3b40..63b75163c6ad 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -119,13 +119,22 @@ list_lru_from_kmem(struct list_lru *lru, int nid, v=
oid *ptr,
>  bool list_lru_add(struct list_lru *lru, struct list_head *item)
>  {
>         int nid =3D page_to_nid(virt_to_page(item));
> +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> +               mem_cgroup_from_slab_obj(item) : NULL;
> +
> +       return __list_lru_add(lru, item, nid, memcg);
> +}
> +EXPORT_SYMBOL_GPL(list_lru_add);
> +
> +bool __list_lru_add(struct list_lru *lru, struct list_head *item, int ni=
d,
> +                   struct mem_cgroup *memcg)
> +{
>         struct list_lru_node *nlru =3D &lru->node[nid];
> -       struct mem_cgroup *memcg;
>         struct list_lru_one *l;
>
>         spin_lock(&nlru->lock);
>         if (list_empty(item)) {
> -               l =3D list_lru_from_kmem(lru, nid, item, &memcg);
> +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(mem=
cg));
>                 list_add_tail(item, &l->list);
>                 /* Set shrinker bit if the first element was added */
>                 if (!l->nr_items++)
> @@ -138,17 +147,27 @@ bool list_lru_add(struct list_lru *lru, struct list=
_head *item)
>         spin_unlock(&nlru->lock);
>         return false;
>  }
> -EXPORT_SYMBOL_GPL(list_lru_add);
> +EXPORT_SYMBOL_GPL(__list_lru_add);
>
>  bool list_lru_del(struct list_lru *lru, struct list_head *item)
>  {
>         int nid =3D page_to_nid(virt_to_page(item));
> +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> +               mem_cgroup_from_slab_obj(item) : NULL;
> +
> +       return __list_lru_del(lru, item, nid, memcg);
> +}
> +EXPORT_SYMBOL_GPL(list_lru_del);
> +
> +bool __list_lru_del(struct list_lru *lru, struct list_head *item, int ni=
d,
> +                   struct mem_cgroup *memcg)
> +{
>         struct list_lru_node *nlru =3D &lru->node[nid];
>         struct list_lru_one *l;
>
>         spin_lock(&nlru->lock);
>         if (!list_empty(item)) {
> -               l =3D list_lru_from_kmem(lru, nid, item, NULL);
> +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(mem=
cg));
>                 list_del_init(item);
>                 l->nr_items--;
>                 nlru->nr_items--;
> @@ -158,7 +177,7 @@ bool list_lru_del(struct list_lru *lru, struct list_h=
ead *item)
>         spin_unlock(&nlru->lock);
>         return false;
>  }
> -EXPORT_SYMBOL_GPL(list_lru_del);
> +EXPORT_SYMBOL_GPL(__list_lru_del);
>
>  void list_lru_isolate(struct list_lru_one *list, struct list_head *item)
>  {
> @@ -175,6 +194,20 @@ void list_lru_isolate_move(struct list_lru_one *list=
, struct list_head *item,
>  }
>  EXPORT_SYMBOL_GPL(list_lru_isolate_move);
>
> +void list_lru_putback(struct list_lru *lru, struct list_head *item, int =
nid,
> +                     struct mem_cgroup *memcg)
> +{
> +       struct list_lru_one *list =3D
> +               list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> +
> +       if (list_empty(item)) {
> +               list_add_tail(item, &list->list);
> +               if (!list->nr_items++)
> +                       set_shrinker_bit(memcg, nid, lru_shrinker_id(lru)=
);
> +       }
> +}
> +EXPORT_SYMBOL_GPL(list_lru_putback);
> +
>  unsigned long list_lru_count_one(struct list_lru *lru,
>                                  int nid, struct mem_cgroup *memcg)
>  {
> --
> 2.34.1
