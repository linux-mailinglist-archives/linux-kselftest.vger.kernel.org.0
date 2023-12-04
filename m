Return-Path: <linux-kselftest+bounces-1074-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2F9803BF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B79C2810FE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Dec 2023 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158F62E85C;
	Mon,  4 Dec 2023 17:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzqq2MCm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD22125;
	Mon,  4 Dec 2023 09:49:04 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-7b06844971dso145861439f.2;
        Mon, 04 Dec 2023 09:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701712144; x=1702316944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q67gi0sVaKsqnMZLHzOOPDUWGyW46YeGeCa+WMG6ae8=;
        b=lzqq2MCmo16dQevrm3H5gbkgCmsNMRLuNKrKgeZWktFoT5H6Sh4goh2QbdR8mdz94K
         74V4a52TE+zxhUDb3KEK35uqOtWM8/xr6jWySHq2lAC3Sq8ObwQO0l3jnT2goSEVvuPh
         gIFSq3LW5uak0ewh2gAa78Vm9xSUDWqyea0qr7UJMuQ4jP0QRzg6xip5Jkpvbs9COV/v
         IVDkpmHL4/cl4WCgqoJjrpG6tkpoFcDiP8eOO8RYxUxeaMYPIoU19kVgbWWZCEh80E7I
         +/OVXyQs3oUO5iNL7oy2Ca9nQY9CVgrC6RnFiCCeNA6w6tdfeItApyAjr6jVAQK4ehm8
         ZG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701712144; x=1702316944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q67gi0sVaKsqnMZLHzOOPDUWGyW46YeGeCa+WMG6ae8=;
        b=wV/sGW9vt5qfoozMvRzPsMBQq4V517YKqE5GmtkxDANWRDitCZTuxernCW4NtJzw1g
         lkIQro6/oHFoASCY4nxoBZw+aiVdlfKnuqvKf6APtZXlDKIfLWOKieYMWk7l8wAfT2zA
         eHtapq5qjCQEBq6MjC/PPgrby2EEeT4700xIKJ7rKiGZn3qrwht/bLPabGg6aMwh0/1v
         QgQTiBe7O96bqcC4XXRDqWw4UuQlGj0sfbuypl/BDIZ1uwHSjTHbPv6CEO+MXHuoTE0E
         QJoK17ED0a01V1+UonfaUWunlLCeU8prG2qXaELjcdjuStWV7q6maXrvNSEfyGbo862K
         VcaA==
X-Gm-Message-State: AOJu0YxDvHv6EscVSQYbDdgIv5lxqdZdeXXIFgLYxn9eDZfwHLQRhJVB
	a0c65yIWVDRjtCWVPQxMhBw7xYSn8f6is0byjow=
X-Google-Smtp-Source: AGHT+IFt8GSzYZxVi1Z4SafwJMjDfy5IZvFf41ASLqOjmQPOc+b/WfHB3rutmq2iGSn8FSt0XVivG4D4QRvU+UeeVQg=
X-Received: by 2002:a6b:c408:0:b0:7b4:2af4:479e with SMTP id
 y8-20020a6bc408000000b007b42af4479emr2378483ioa.24.1701712143938; Mon, 04 Dec
 2023 09:49:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org> <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
 <20231130203522.GC543908@cmpxchg.org> <e3e319f5-9bcd-4c35-92e6-6fdb33eaa080@linux.dev>
In-Reply-To: <e3e319f5-9bcd-4c35-92e6-6fdb33eaa080@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 4 Dec 2023 09:48:52 -0800
Message-ID: <CAKEwX=OBHe12R6fTbRn_dNGrz+T4ekE4MSo5w+7i_NNoprmnkw@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node selection
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	cerasuolodomenico@gmail.com, yosryahmed@google.com, sjenning@redhat.com, 
	ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org, 
	roman.gushchin@linux.dev, shakeelb@google.com, muchun.song@linux.dev, 
	chrisl@kernel.org, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 12:30=E2=80=AFAM Chengming Zhou <chengming.zhou@linu=
x.dev> wrote:
>
> On 2023/12/1 04:35, Johannes Weiner wrote:
> > On Thu, Nov 30, 2023 at 12:07:41PM -0800, Nhat Pham wrote:
> >> On Thu, Nov 30, 2023 at 11:57=E2=80=AFAM Matthew Wilcox <willy@infrade=
ad.org> wrote:
> >>>
> >>> On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> >>>> This patch changes list_lru interface so that the caller must explic=
itly
> >>>> specify numa node and memcg when adding and removing objects. The ol=
d
> >>>> list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() =
and
> >>>> list_lru_del_obj(), respectively.
> >>>
> >>> Wouldn't it be better to add list_lru_add_memcg() and
> >>> list_lru_del_memcg() and have:
> >>>
> >>> +bool list_lru_del(struct list_lru *lru, struct list_head *item)
> >>> +{
> >>> +       int nid =3D page_to_nid(virt_to_page(item));
> >>> +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> >>> +               mem_cgroup_from_slab_obj(item) : NULL;
> >>> +
> >>> +       return list_lru_del_memcg(lru, item, nid, memcg);
> >>> +}
> >>>
> >>> Seems like _most_ callers will want the original versions and only
> >>> a few will want the explicit memcg/nid versions.  No?
> >>>
> >>
> >> I actually did something along that line in earlier iterations of this
> >> patch series (albeit with poorer naming - __list_lru_add() instead of
> >> list_lru_add_memcg()). The consensus after some back and forth was
> >> that the original list_lru_add() was not a very good design (the
> >> better one was this new version that allows for explicit numa/memcg
> >> selection). So I agreed to fix it everywhere as a prep patch.
> >>
> >> I don't have strong opinions here to be completely honest, but I do
> >> think this new API makes more sense (at the cost of quite a bit of
> >> elbow grease to fix every callsites and extra reviewing).
> >
> > Maybe I can shed some light since I was pushing for doing it this way.
> >
> > The quiet assumption that 'struct list_head *item' is (embedded in) a
> > slab object that is also charged to a cgroup is a bit much, given that
> > nothing in the name or documentation of the function points to that.
> >
> > It bit us in the THP shrinker where that list head is embedded in a
> > tailpage (virt_to_page(page) is fun to debug). And it caused some
> > confusion in this case as well, where the zswap entry is a slab object
> > but not charged (the entry descriptor is not attractive for cgroup
> > accounting, only the backing memory it points to.)
>
> Hi,
>
> I have a question, maybe I missed something since I haven't read all
> the earlier versions.
>
> IIUC, the problem here is that "zswap_entry" has different memcg and node
> than the "page", so I wonder if we can just charge "zswap_entry" to the
> same memcg of the "page".
>
> Like we can do these when allocating the "zswap_entry":
>
>         old_memcg =3D set_active_memcg(memcg)
>         kmem_cache_alloc_lru(zswap_entry_cache, lru, gfp)
>         set_active_memcg(old_memcg)
>
> The good points are:
>
> 1. "zswap_entry" is charged to the memcg of "page", which is more sensibl=
e?
>
> 2. We can reuse the kmem_cache_alloc_lru() interface, which makes code si=
mpler
>    since we don't need to manage list_lru_memcg by ourselves.
>
> 3. Maybe the new list_lru_add() and list_lru_del() are not needed anymore=
?
>    Since the "zswap_entry" is of the same memcg and node with the "page".
>    But don't know if THP shrinker still need it.
>
> Thanks!

That idea was considered in earlier iterations/discussions of the
patch series as well. Charging things is not free - there is an
overhead associated with it, which is why we are usually selective
about whether to charge something. We were not super keen to do this
for zswap_entry just to plumb around the list_lru's restriction. Might
as well pay the price of extending the list_lru interface now.

If in the future, not charging the zswap entry causes a separate
isolation issue, we could revisit this decision and charge it.
Otherwise, IMHO we should just stick with this for now.

>
> >
> > Yes, for most users - at least right now - the current assumption is
> > accurate. The thinking was just that if we do have to differentiate
> > callers now anyway, we might as well make the interface a bit more
> > self-documenting and harder to misuse going forward, even if it's a
> > bit more churn now.
> >
> >

