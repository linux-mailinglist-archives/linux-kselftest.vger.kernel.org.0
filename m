Return-Path: <linux-kselftest+bounces-905-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C354F7FFBF4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 21:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59EFE1F20F4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BAB53E10;
	Thu, 30 Nov 2023 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLAfUB5Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E91810F8;
	Thu, 30 Nov 2023 12:07:53 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b34ec3e44fso38157139f.3;
        Thu, 30 Nov 2023 12:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701374872; x=1701979672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8JkjsLram/ejernmiCZTwmtwfg8aQ1F8JO+U2W+Xm0=;
        b=CLAfUB5QSdKWH/Oc/3KQivo4dQmljeCGVFvMlqlgbggvJBCNH2mfvaJFy2hgzf7s0X
         TXqKPkftGLUjoVbHrpgce85Db8MtQJI4bpB8uE5AYbAGV8DDoeOvJcpDW4n3/A6w1rZ3
         P+fAb/sn6LjeKFy/u8QXQ5kP55dscZEsaPtRL75Y9LmLFWkH/N2haIK/tZrRGUvddYOL
         aqgHiRl1b+WFUoGY27aHBSIbJJOQkqzK9nTCZxPWg+EHYiWd/dGb6pvM1uxZ0M0FiDBz
         ENoEJ8JF+Jo2o6bFhQt+a1ZJX69QeqMiucX7agh/U/z2XiM17F5wBPbCCdsaxPXs/Dtq
         a7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701374872; x=1701979672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8JkjsLram/ejernmiCZTwmtwfg8aQ1F8JO+U2W+Xm0=;
        b=XGro2ZgtM86hlwFnzXks140OPk1IOgGaOcl9XVd9xwqJneoerOH9NmPOc4BgS/785u
         HIYg/sMOtLh3EYBYC3kaeBe6etEFVQ4k3T4tWm1ayCUzFPp5AuRPNXuV6MMbvx4e60mP
         QBCYYIhmBSqGxXHKwF9SIQOaKH4fRTt6hShAJUjS8OuIBV88sCRiBIJMe976MMbKY4gH
         IXMX5uXpqNVKrEt4J2XxHxVJcx0ipuCeERuLDWxJpN4VwC5Aacmd9+PnoN8DmQl28fDE
         3Wt6/3uZozHY1q8cCMfJySb/Aqvlnw8KBvBDFZ69vbtoU4Ux3dzhBG4s/F6qQ0mrb/x6
         XFLg==
X-Gm-Message-State: AOJu0YxdA0iJBcWHWXeOmKisv+MVT2LxkxT62wE0RxiwNo+1JYM8VIea
	+h/R3UxLkbwf4fBFRCKcwnNFtbvYj1iuNlxOn+z0/CAbiRc=
X-Google-Smtp-Source: AGHT+IHXvm1W++vVVPTk19ktbPl5ee74KU9mfyX1arK6KzKt6r5RD2ae1t2pmohDXRTROGj0LXeigfu6GOv6j0VuqSk=
X-Received: by 2002:a6b:7506:0:b0:7b3:f55c:49a7 with SMTP id
 l6-20020a6b7506000000b007b3f55c49a7mr5185613ioh.3.1701374872357; Thu, 30 Nov
 2023 12:07:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-2-nphamcs@gmail.com>
 <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
In-Reply-To: <ZWjpNr3ZzvU4TDC8@casper.infradead.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 30 Nov 2023 12:07:41 -0800
Message-ID: <CAKEwX=MV-F50i_=sZ0unfbgjrdxSTio00c4xTM19113BAN3-wA@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] list_lru: allows explicit memcg and NUMA node selection
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, chrisl@kernel.org, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 11:57=E2=80=AFAM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Nov 30, 2023 at 11:40:18AM -0800, Nhat Pham wrote:
> > This patch changes list_lru interface so that the caller must explicitl=
y
> > specify numa node and memcg when adding and removing objects. The old
> > list_lru_add() and list_lru_del() are renamed to list_lru_add_obj() and
> > list_lru_del_obj(), respectively.
>
> Wouldn't it be better to add list_lru_add_memcg() and
> list_lru_del_memcg() and have:
>
> +bool list_lru_del(struct list_lru *lru, struct list_head *item)
> +{
> +       int nid =3D page_to_nid(virt_to_page(item));
> +       struct mem_cgroup *memcg =3D list_lru_memcg_aware(lru) ?
> +               mem_cgroup_from_slab_obj(item) : NULL;
> +
> +       return list_lru_del_memcg(lru, item, nid, memcg);
> +}
>
> Seems like _most_ callers will want the original versions and only
> a few will want the explicit memcg/nid versions.  No?
>

I actually did something along that line in earlier iterations of this
patch series (albeit with poorer naming - __list_lru_add() instead of
list_lru_add_memcg()). The consensus after some back and forth was
that the original list_lru_add() was not a very good design (the
better one was this new version that allows for explicit numa/memcg
selection). So I agreed to fix it everywhere as a prep patch.

I don't have strong opinions here to be completely honest, but I do
think this new API makes more sense (at the cost of quite a bit of
elbow grease to fix every callsites and extra reviewing).

