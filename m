Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F45D7E2E7C
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Nov 2023 21:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjKFU6Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 15:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjKFU6Y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 15:58:24 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DA19E
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Nov 2023 12:58:21 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9de7a43bd1aso347151766b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Nov 2023 12:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699304300; x=1699909100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKl8aQiZoT5/Gc1O1HhE3ZzebbwHEfVwbiUJglhZ9UY=;
        b=HopfvrxUiCnKmh2fP7nl/m5Qjja2uu99EeINNRlzIMJd6oD0+P/rwjX7Zlx/gt7up0
         mV/2blsThcByk50uDc1/Uzr1zSaih7FS66WBE2OZvMIeuGJXdRMW0vjBVfv9UDQxzhnv
         229//6BJatA6JpTCoWIFm1J7iJ3Ulh/ArZwAumKpJCxK4lswmJwnEOC5hMq9u6zKsJrw
         02n7qfpy5nrVkzjPr1Dyy5aGOYp8+wPin0RpxLEIGx+1eBsHpJMOE52N7DQl2gyUQRUY
         PSPIUsizmdyVQCf4tmpwch7+fovEdo3v9xWqqMFWmqQcLC4LRuX+54wEbhajGxF5tHV+
         9omg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699304300; x=1699909100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZKl8aQiZoT5/Gc1O1HhE3ZzebbwHEfVwbiUJglhZ9UY=;
        b=BAv/MCKVYdfMFPPLICcMrF1d8wqa45ahxwt+W6UklMP85nXpOohODGBANewraExz1v
         v51cCkE3/F2eyFmFENl5PRwzNEoj4/9r9vzkuYA3u0y3gUcWNh493HU95yOeU1ElMh/7
         e9SEVUIhr7DegmX1dobIVcvUI7V5t4wKHvpk5hvUX9UiG2Q175fgHIIxiYxuzVGFfAb5
         ZWpkLAMNGe1FLPgAGJINTIsl1JGjrJBagV9dxXYhFVc/QCL8/XQhH5H0EqFOQiwE3yky
         bXr17akH9NMtDqrvl3B3LYcNQiS9E/N3FPTqWKveedKqXrCIaoIg7XWaTJN/8KFDfDrg
         J1Pw==
X-Gm-Message-State: AOJu0YzKOA1DbHL3y3wNpF40wjZr2phl0my3+vPdLX+0vOViChobaswr
        FudFovHal9vxbf9I0542uJ4KrExuHPG7bux7tarm3g==
X-Google-Smtp-Source: AGHT+IFrCXffedtA3mNIcSD9CL5cZrq9gg6yV7X2n90hA137Lzb005Ix2ogp4oXgiw+o+Nq7W19r1UCfCcsA5LCR+3Y=
X-Received: by 2002:a17:906:da87:b0:9b7:37de:601a with SMTP id
 xh7-20020a170906da8700b009b737de601amr15301903ejb.49.1699304299984; Mon, 06
 Nov 2023 12:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <20231106183159.3562879-4-nphamcs@gmail.com>
 <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com> <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com>
In-Reply-To: <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 6 Nov 2023 12:57:44 -0800
Message-ID: <CAJD7tkY+qdYytVKUjdgPypZthWA57gVKuEtjowuVPMpcOmpdLQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] zswap: make shrinking memcg-aware
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

> >
> > This lock is only needed to synchronize updating pool->next_shrink,
> > right? Can we just use atomic operations instead? (e.g. cmpxchg()).
>
> I'm not entirely sure. I think in the pool destroy path, we have to also
> put the next_shrink memcg, so there's that.

We can use xchg() to replace it with NULL, then put the memcg ref, no?

We can also just hold zswap_pools_lock while shrinking the memcg
perhaps? It's not a contended lock anyway. It just feels weird to add
a spinlock to protect one pointer.

>
> >
> > > +               if (pool->next_shrink == memcg)
> > > +                       pool->next_shrink =
> > > +                               mem_cgroup_iter(NULL, pool->next_shrink, NULL, true);
> > > +               spin_unlock(&pool->next_shrink_lock);
> > > +       }
> > > +       spin_unlock(&zswap_pools_lock);
> > > +}
> > > +
> > >  /*********************************
> > >  * zswap entry functions
> > >  **********************************/
> > >  static struct kmem_cache *zswap_entry_cache;
> > >
> > > -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> > > +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int nid)
> > >  {
> > >         struct zswap_entry *entry;
> > > -       entry = kmem_cache_alloc(zswap_entry_cache, gfp);
> > > +       entry = kmem_cache_alloc_node(zswap_entry_cache, gfp, nid);
> > >         if (!entry)
> > >                 return NULL;
> > >         entry->refcount = 1;
> > [..]
> > > @@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
> > >                 zswap_invalidate_entry(tree, dupentry);
> > >         }
> > >         spin_unlock(&tree->lock);
> > > -
> > > -       /*
> > > -        * XXX: zswap reclaim does not work with cgroups yet. Without a
> > > -        * cgroup-aware entry LRU, we will push out entries system-wide based on
> > > -        * local cgroup limits.
> > > -        */
> > >         objcg = get_obj_cgroup_from_folio(folio);
> > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > -               goto reject;
> > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > +               memcg = get_mem_cgroup_from_objcg(objcg);
> > > +               if (shrink_memcg(memcg)) {
> > > +                       mem_cgroup_put(memcg);
> > > +                       goto reject;
> > > +               }
> > > +               mem_cgroup_put(memcg);
> >
> > Can we just use RCU here as well? (same around memcg_list_lru_alloc()
> > call below).
>
> For memcg_list_lru_alloc(): there's potentially sleeping in that piece of
> code I believe? I believe at the very least we'll have to use this gfp_t
> flag for it to be rcu-safe:
>
> GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
> not sure the
>
> Same go for this particular place IIRC - there's some sleeping done
> in zswap_writeback_entry(), correct?

Ah right, I missed this. My bad.
