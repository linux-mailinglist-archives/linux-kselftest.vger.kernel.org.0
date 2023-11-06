Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17307E3163
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Nov 2023 00:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjKFX2U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Nov 2023 18:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjKFX2H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Nov 2023 18:28:07 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A54468D;
        Mon,  6 Nov 2023 15:25:16 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-7ad501764f4so65940939f.3;
        Mon, 06 Nov 2023 15:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699313116; x=1699917916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFohItga9X0xPgYLEfr2XqF9MUnkolAn3ELAIha/bdg=;
        b=nX5c+gTlHMYV21PjHlvnvYaZFgZYyzDBFJIqd4monilmsST+GssoWBQVzdj/pF9DH7
         YTxxMbUmLQ8XiJg3D9EhKkq1uvFtYzcfNZlYeepw3yKW+laVZh71fX4OmS7ttY4K9UIc
         l/0fOQPcSJYFs2A7d27k9wEOkHhVYQ7vdvxJN/uOj4tmbWzq2oCQoNxNCIGeXaDiZTjU
         uN3XrxPXaMgi1hpKZ2dbkeuTKZZYc7Q1ar06JMt7l1H2sQPFQGQQX5X/ZweowuVLMjD0
         fNt3C2WaK/ElpG/+HCvZHdt9Lu94RfAv/TPUgn04dbPIOw4rOVMaY5a0iNn/UzfRXtp4
         6Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699313116; x=1699917916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFohItga9X0xPgYLEfr2XqF9MUnkolAn3ELAIha/bdg=;
        b=KcX4VSuIgr0wrkLccqMrymRLpFnwjJVxfuUD5tG3lHcn3bZ2g+dhfUAHrrW7uqndAE
         bWCHhpwGC53+5WJEY+oiitHoZMJOWZXSfzUtoZda1C7V0LulfmEa4gMzfLIz5bM2rE9j
         BqaKcozJQnryN62rovO9MvI27XwAtODffkjHuJ8uZK7lfc9be4ykSjqIyuD/xXP063Ih
         YcJd+mBYeuc1frYtoMudGbT5/SuPLqQahA5Sch0GJ6QsNF8eZLw++G/SUEdJSWx6IIzt
         fMYNK9nwDC2sW6YPcjfyan80CdmTS3JlByQldTja/XzbDKLq5g1PiTQp1LVlz+01LYlB
         w1Lw==
X-Gm-Message-State: AOJu0Yx66tM6fQyUvTYWlYq5PAwYu4/WmWek4UVzpsXpCxGArKbKgSDi
        TAyISlrlK/cBCVeaKjVDV+z8M9VkDz71p2aosVM=
X-Google-Smtp-Source: AGHT+IGV4V0e5c01c8hD3mfdr+jQQ1UjrMZTmWDKErBTA6rVC/kSi+zmq1aFfKbKyQjXxH2oaq8dispeOxZwGbnP91E=
X-Received: by 2002:a05:6602:2b91:b0:79f:d4e6:5175 with SMTP id
 r17-20020a0566022b9100b0079fd4e65175mr41047243iov.16.1699313116030; Mon, 06
 Nov 2023 15:25:16 -0800 (PST)
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <20231106183159.3562879-4-nphamcs@gmail.com>
 <CAJD7tkYcEc03d+6kwkXu8M_fd9ZDzh6B5G+VjmFXx+H09mhfmg@mail.gmail.com>
 <CAKEwX=PU3z7CseAZHE6v-q_yKQn0PtZqtfsfyKy5KOJpnNiE9Q@mail.gmail.com> <CAJD7tkY+qdYytVKUjdgPypZthWA57gVKuEtjowuVPMpcOmpdLQ@mail.gmail.com>
In-Reply-To: <CAJD7tkY+qdYytVKUjdgPypZthWA57gVKuEtjowuVPMpcOmpdLQ@mail.gmail.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 6 Nov 2023 15:25:05 -0800
Message-ID: <CAKEwX=Outf_hz_4UrzqKTbxxQD7y-Wm1cv9tOWC5J3V1ZmSiaA@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] zswap: make shrinking memcg-aware
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 6, 2023 at 12:58=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> > >
> > > This lock is only needed to synchronize updating pool->next_shrink,
> > > right? Can we just use atomic operations instead? (e.g. cmpxchg()).
> >
> > I'm not entirely sure. I think in the pool destroy path, we have to als=
o
> > put the next_shrink memcg, so there's that.
>
> We can use xchg() to replace it with NULL, then put the memcg ref, no?
>
> We can also just hold zswap_pools_lock while shrinking the memcg
> perhaps? It's not a contended lock anyway. It just feels weird to add
> a spinlock to protect one pointer.

Ah this sounds good to me I guess. I'm not opposed to this simplification
of the concurrency scheme.

>
> >
> > >
> > > > +               if (pool->next_shrink =3D=3D memcg)
> > > > +                       pool->next_shrink =3D
> > > > +                               mem_cgroup_iter(NULL, pool->next_sh=
rink, NULL, true);
> > > > +               spin_unlock(&pool->next_shrink_lock);
> > > > +       }
> > > > +       spin_unlock(&zswap_pools_lock);
> > > > +}
> > > > +
> > > >  /*********************************
> > > >  * zswap entry functions
> > > >  **********************************/
> > > >  static struct kmem_cache *zswap_entry_cache;
> > > >
> > > > -static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp)
> > > > +static struct zswap_entry *zswap_entry_cache_alloc(gfp_t gfp, int =
nid)
> > > >  {
> > > >         struct zswap_entry *entry;
> > > > -       entry =3D kmem_cache_alloc(zswap_entry_cache, gfp);
> > > > +       entry =3D kmem_cache_alloc_node(zswap_entry_cache, gfp, nid=
);
> > > >         if (!entry)
> > > >                 return NULL;
> > > >         entry->refcount =3D 1;
> > > [..]
> > > > @@ -1233,15 +1369,15 @@ bool zswap_store(struct folio *folio)
> > > >                 zswap_invalidate_entry(tree, dupentry);
> > > >         }
> > > >         spin_unlock(&tree->lock);
> > > > -
> > > > -       /*
> > > > -        * XXX: zswap reclaim does not work with cgroups yet. Witho=
ut a
> > > > -        * cgroup-aware entry LRU, we will push out entries system-=
wide based on
> > > > -        * local cgroup limits.
> > > > -        */
> > > >         objcg =3D get_obj_cgroup_from_folio(folio);
> > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > -               goto reject;
> > > > +       if (objcg && !obj_cgroup_may_zswap(objcg)) {
> > > > +               memcg =3D get_mem_cgroup_from_objcg(objcg);
> > > > +               if (shrink_memcg(memcg)) {
> > > > +                       mem_cgroup_put(memcg);
> > > > +                       goto reject;
> > > > +               }
> > > > +               mem_cgroup_put(memcg);
> > >
> > > Can we just use RCU here as well? (same around memcg_list_lru_alloc()
> > > call below).
> >
> > For memcg_list_lru_alloc(): there's potentially sleeping in that piece =
of
> > code I believe? I believe at the very least we'll have to use this gfp_=
t
> > flag for it to be rcu-safe:
> >
> > GFP_KERNEL | __GFP_NORETRY | __GFP_NOMEMALLOC | __GFP_NOWARN
> > not sure the
> >
> > Same go for this particular place IIRC - there's some sleeping done
> > in zswap_writeback_entry(), correct?
>
> Ah right, I missed this. My bad.
