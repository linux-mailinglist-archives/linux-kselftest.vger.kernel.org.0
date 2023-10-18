Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82D7CEB97
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Oct 2023 01:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJRXKH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 19:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJRXKG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 19:10:06 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8570B113;
        Wed, 18 Oct 2023 16:10:04 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7a67c3d62a3so31569239f.1;
        Wed, 18 Oct 2023 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697670604; x=1698275404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8McjuiFNA6jdHsfKeW1oFcl0LpsURXZqw4FI0RQ3ZaE=;
        b=XuEg19AZAhaZm95uCK13RqTKE8MuxeL3EnDDerjDANRqu1Pa7fd+V2eZZf74DN7EVJ
         x0ZwFFBQVjsPdRly6OzfWpbaevAk5QtdyfLHaiVDN694VGnAyYqZgtE6M5v4O1Ec8uRh
         Z4Qu8PdgHZy7dEjnqeTfkHE8WziQa5mjoCaSLyTXBTesklDt44EnZPx0c6DKJbLCvonR
         RN/PbVkviO3yBoUdH1Obqd+46zTQ2EOmDNx8QtdhIDG0zLIsmKib1T/wLRYc95FKgqHB
         R9ijcErqqBKTYrXPoRDnpuvHykehPRVNV3Yet6ueJKehCWegm50iRLscnEO475Hw4E8x
         2ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697670604; x=1698275404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8McjuiFNA6jdHsfKeW1oFcl0LpsURXZqw4FI0RQ3ZaE=;
        b=G5ndnFAluOZKFyQ5r0KPkvTwghsw+Rfd/Mlb6VbgQJdIt0nSZeYUxnqq0rTkYXrlKY
         ASRR63kFf6DegOHo++638tpUJVJ8O2CEvSePE/rwIVCwOn7altwQ/bC1gAmROF62Nu/g
         CS1pwj2QBaV0yG7OIlj17kueGurRHSqRrqo/JUleO0MCm1BNQwdedFAAcvFFk0WGlvz7
         FxRlcKbzrAmkOQxNUMVClK8K0C1rJBKlwe/mPwqHkDkNFcf8LfUCXftXj5PJHpMRn2SG
         BNJJn0y5/rxgvJzboZqzweSm4utKmz1S1C62sSDEO/Fov39anDfNQ7uOXVwh/kXVp4VK
         4xPg==
X-Gm-Message-State: AOJu0YykkXvA1sLP0KsBN79ESY371Tg6lldICkiYaw8HCSVExsE92Ohb
        Nz8d0lrZdUAVctjWAZ+w4yaWie4BaGusMGMesUM=
X-Google-Smtp-Source: AGHT+IEQHrimXJZOwXCVe5Ii3Vc+DmyggwesQy3nZiSx1Am8rvJVcqAHV1ddgqSc0LphtbQDB0TclId1caWQ0WEyxlE=
X-Received: by 2002:a05:6602:2b14:b0:798:312a:5403 with SMTP id
 p20-20020a0566022b1400b00798312a5403mr727882iov.19.1697670603757; Wed, 18 Oct
 2023 16:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20231017232152.2605440-1-nphamcs@gmail.com> <20231017232152.2605440-2-nphamcs@gmail.com>
 <CAJD7tkYAvi_WfzPb_zaq174FB+-kftmcqtUrHirTeB2NMhFcbA@mail.gmail.com>
In-Reply-To: <CAJD7tkYAvi_WfzPb_zaq174FB+-kftmcqtUrHirTeB2NMhFcbA@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Wed, 18 Oct 2023 16:09:52 -0700
Message-ID: <CAKEwX=PYdAj8hhkBQFUkuh=PMmVPXOoF9uyf5LZ0uJiPcFBHqg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: list_lru: allow external numa node and cgroup tracking
To:     Yosry Ahmed <yosryahmed@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 18, 2023 at 3:27=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Oct 17, 2023 at 4:21=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > The interface of list_lru is based on the assumption that objects are
> > allocated on the correct node/memcg, with this change it is introduced =
the
> > possibility to explicitly specify numa node and memcgroup when adding a=
nd
> > removing objects. This is so that users of list_lru can track node/memc=
g
> > of the items outside of the list_lru, like in zswap, where the allocati=
ons
> > can be made by kswapd for data that's charged to a different cgroup.
> >
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> I prefer what Johannes suggested, making list_lru_add() and friends
> take in the memcg and nid, and add list_lru_add_obj() (or similar) and
> friends that assume the object is on the right node and memcg. This is
> clearer and more explicit imo. I am not very familiar with list_lrus
> though, so I'll leave this to folks who actually are.

Yeah the original naming is... most unfortunate, to say the least :)

I create a new function to avoid renaming list_lru_add's usage
everywhere, but if the consensus is that everyone prefers
list_lru_add() to be the one taking memcg + nid (and the original
renamed to list_lru_add_obj()), I can go around fixing all of it :)

Seems like a separate endeavour though.

>
> > ---
> >  include/linux/list_lru.h | 38 +++++++++++++++++++++++++++++++++++
> >  mm/list_lru.c            | 43 +++++++++++++++++++++++++++++++++++-----
> >  2 files changed, 76 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> > index b35968ee9fb5..0f5f39cacbbb 100644
> > --- a/include/linux/list_lru.h
> > +++ b/include/linux/list_lru.h
> > @@ -89,6 +89,24 @@ void memcg_reparent_list_lrus(struct mem_cgroup *mem=
cg, struct mem_cgroup *paren
> >   */
> >  bool list_lru_add(struct list_lru *lru, struct list_head *item);
> >
> > +/**
> > + * __list_lru_add: add an element to a specific sublist.
> > + * @list_lru: the lru pointer
> > + * @item: the item to be added.
> > + * @memcg: the cgroup of the sublist to add the item to.
> > + * @nid: the node id of the sublist to add the item to.
> > + *
> > + * This function is similar to list_lru_add(), but it allows the calle=
r to
> > + * specify the sublist to which the item should be added. This can be =
useful
> > + * when the list_head node is not necessarily in the same cgroup and N=
UMA node
> > + * as the data it represents, such as zswap, where the list_head node =
could be
> > + * from kswapd and the data from a different cgroup altogether.
> > + *
> > + * Return value: true if the list was updated, false otherwise
> > + */
> > +bool __list_lru_add(struct list_lru *lru, struct list_head *item, int =
nid,
> > +                   struct mem_cgroup *memcg);
> > +
> >  /**
> >   * list_lru_del: delete an element to the lru list
> >   * @list_lru: the lru pointer
> > @@ -102,6 +120,18 @@ bool list_lru_add(struct list_lru *lru, struct lis=
t_head *item);
> >   */
> >  bool list_lru_del(struct list_lru *lru, struct list_head *item);
> >
> > +/**
> > + * __list_lru_del: delete an element from a specific sublist.
> > + * @list_lru: the lru pointer
> > + * @item: the item to be deleted.
> > + * @memcg: the cgroup of the sublist to delete the item from.
> > + * @nid: the node id of the sublist to delete the item from.
> > + *
> > + * Return value: true if the list was updated, false otherwise.
> > + */
> > +bool __list_lru_del(struct list_lru *lru, struct list_head *item, int =
nid,
> > +                   struct mem_cgroup *memcg);
> > +
> >  /**
> >   * list_lru_count_one: return the number of objects currently held by =
@lru
> >   * @lru: the lru pointer.
> > @@ -136,6 +166,14 @@ static inline unsigned long list_lru_count(struct =
list_lru *lru)
> >  void list_lru_isolate(struct list_lru_one *list, struct list_head *ite=
m);
> >  void list_lru_isolate_move(struct list_lru_one *list, struct list_head=
 *item,
> >                            struct list_head *head);
> > +/*
> > + * list_lru_putback: undo list_lru_isolate.
> > + *
> > + * Since we might have dropped the LRU lock in between, recompute list=
_lru_one
> > + * from the node's id and memcg.
> > + */
> > +void list_lru_putback(struct list_lru *lru, struct list_head *item, in=
t nid,
> > +                     struct mem_cgroup *memcg);
> >
> >  typedef enum lru_status (*list_lru_walk_cb)(struct list_head *item,
> >                 struct list_lru_one *list, spinlock_t *lock, void *cb_a=
rg);
> > diff --git a/mm/list_lru.c b/mm/list_lru.c
> > index a05e5bef3b40..63b75163c6ad 100644
> > --- a/mm/list_lru.c
> > +++ b/mm/list_lru.c
> > @@ -119,13 +119,22 @@ list_lru_from_kmem(struct list_lru *lru, int nid,=
 void *ptr,
> >  bool list_lru_add(struct list_lru *lru, struct list_head *item)
> >  {
> >         int nid =3D page_to_nid(virt_to_page(item));
> > +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> > +               mem_cgroup_from_slab_obj(item) : NULL;
> > +
> > +       return __list_lru_add(lru, item, nid, memcg);
> > +}
> > +EXPORT_SYMBOL_GPL(list_lru_add);
> > +
> > +bool __list_lru_add(struct list_lru *lru, struct list_head *item, int =
nid,
> > +                   struct mem_cgroup *memcg)
> > +{
> >         struct list_lru_node *nlru =3D &lru->node[nid];
> > -       struct mem_cgroup *memcg;
> >         struct list_lru_one *l;
> >
> >         spin_lock(&nlru->lock);
> >         if (list_empty(item)) {
> > -               l =3D list_lru_from_kmem(lru, nid, item, &memcg);
> > +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(m=
emcg));
> >                 list_add_tail(item, &l->list);
> >                 /* Set shrinker bit if the first element was added */
> >                 if (!l->nr_items++)
> > @@ -138,17 +147,27 @@ bool list_lru_add(struct list_lru *lru, struct li=
st_head *item)
> >         spin_unlock(&nlru->lock);
> >         return false;
> >  }
> > -EXPORT_SYMBOL_GPL(list_lru_add);
> > +EXPORT_SYMBOL_GPL(__list_lru_add);
> >
> >  bool list_lru_del(struct list_lru *lru, struct list_head *item)
> >  {
> >         int nid =3D page_to_nid(virt_to_page(item));
> > +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> > +               mem_cgroup_from_slab_obj(item) : NULL;
> > +
> > +       return __list_lru_del(lru, item, nid, memcg);
> > +}
> > +EXPORT_SYMBOL_GPL(list_lru_del);
> > +
> > +bool __list_lru_del(struct list_lru *lru, struct list_head *item, int =
nid,
> > +                   struct mem_cgroup *memcg)
> > +{
> >         struct list_lru_node *nlru =3D &lru->node[nid];
> >         struct list_lru_one *l;
> >
> >         spin_lock(&nlru->lock);
> >         if (!list_empty(item)) {
> > -               l =3D list_lru_from_kmem(lru, nid, item, NULL);
> > +               l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(m=
emcg));
> >                 list_del_init(item);
> >                 l->nr_items--;
> >                 nlru->nr_items--;
> > @@ -158,7 +177,7 @@ bool list_lru_del(struct list_lru *lru, struct list=
_head *item)
> >         spin_unlock(&nlru->lock);
> >         return false;
> >  }
> > -EXPORT_SYMBOL_GPL(list_lru_del);
> > +EXPORT_SYMBOL_GPL(__list_lru_del);
> >
> >  void list_lru_isolate(struct list_lru_one *list, struct list_head *ite=
m)
> >  {
> > @@ -175,6 +194,20 @@ void list_lru_isolate_move(struct list_lru_one *li=
st, struct list_head *item,
> >  }
> >  EXPORT_SYMBOL_GPL(list_lru_isolate_move);
> >
> > +void list_lru_putback(struct list_lru *lru, struct list_head *item, in=
t nid,
> > +                     struct mem_cgroup *memcg)
> > +{
> > +       struct list_lru_one *list =3D
> > +               list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg))=
;
> > +
> > +       if (list_empty(item)) {
> > +               list_add_tail(item, &list->list);
> > +               if (!list->nr_items++)
> > +                       set_shrinker_bit(memcg, nid, lru_shrinker_id(lr=
u));
> > +       }
> > +}
> > +EXPORT_SYMBOL_GPL(list_lru_putback);
> > +
> >  unsigned long list_lru_count_one(struct list_lru *lru,
> >                                  int nid, struct mem_cgroup *memcg)
> >  {
> > --
> > 2.34.1
