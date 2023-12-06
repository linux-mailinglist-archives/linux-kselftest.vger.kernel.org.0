Return-Path: <linux-kselftest+bounces-1219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C620380634B
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 01:16:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55884B2115C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 00:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073A719E;
	Wed,  6 Dec 2023 00:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cUXTiceL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC1D624
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D211C433CB
	for <linux-kselftest@vger.kernel.org>; Wed,  6 Dec 2023 00:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701821807;
	bh=KB2h573VWm7p5NE2V/A12yXhGDfVWtxxezLZetMV8EM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cUXTiceLGbO5lenVZeMmlWo7vqYqauEDVukhkO+OIlX+n3D42i2bqWUcnBqozO6XU
	 7IYf1+ps/u/H1NiaE1OiWxZClyIV0+4Mjt2tGYpp7HDv7XaISi5Bb5HawwLkSr+9oR
	 mACXKjaqBM/BVenr6cTyV8yRm2/huC+WqGIPZ+tw18vxO00rGeYH+AkfNAMJgghTOP
	 XVDhFG1NZcX6nmt2DMcc6llm9CyDnGxUxOXs8WKNXyppSxGNsnm+iu5FM9oXPv61SD
	 JeLXq5kDsXM+mFp7IOElJukd2Lp8AO81UTP/jHUaJxxPa2I9tdKWdf7Ur4JWAC1Dcz
	 SXhHQ+u/HinLA==
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5be30d543c4so2756011a12.2
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Dec 2023 16:16:47 -0800 (PST)
X-Gm-Message-State: AOJu0Yxo9dJJg1oejeAob36/cOFoYkdoTtp3m/1+QTl3oDAPXOgtuAMf
	Wm1MsbnPO9lsa57WWkFOg3lyAwfDUQ8zlV/2CCmzng==
X-Google-Smtp-Source: AGHT+IHu5BtCSU0pVaHo7hstQQoCt4LP6AEcx7PGgCpGRGvVdybIR+82gCeElLUDiOxMjsGNu7AQ9eX7JuRo5PsoG5A=
X-Received: by 2002:a17:90a:19d6:b0:286:f166:679f with SMTP id
 22-20020a17090a19d600b00286f166679fmr91628pjj.49.1701821806793; Tue, 05 Dec
 2023 16:16:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-3-nphamcs@gmail.com>
 <CAF8kJuOsaX15w3gF7eUN8u7LAKhC7m2we91simoPH7S=MZJZCg@mail.gmail.com> <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com>
In-Reply-To: <CAKEwX=PX0bR5orAsgYtXfOSarRobf1xnkSyXx+z6g_VHFVonQw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 5 Dec 2023 16:16:35 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
Message-ID: <CAF8kJuO8xmhxpCSzof9cDAqOheZgpz5Z-xyCHUQUGenCmzmdhA@mail.gmail.com>
Subject: Re: [PATCH v8 2/6] memcontrol: implement mem_cgroup_tryget_online()
To: Nhat Pham <nphamcs@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, cerasuolodomenico@gmail.com, 
	yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org, 
	vitaly.wool@konsulko.com, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeelb@google.com, muchun.song@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 4, 2023 at 5:39=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> > > memcg as a candidate for the global limit reclaim.
> >
> > Very minor nitpick. This patch can fold with the later patch that uses
> > it. That makes the review easier, no need to cross reference different
> > patches. It will also make it harder to introduce API that nobody
> > uses.
>
> I don't have a strong preference one way or the other :) Probably not
> worth the churn tho.

Squashing a patch is very easy. If you are refreshing a new series, it
is worthwhile to do it. I notice on the other thread Yosry pointed out
you did  not use the function "mem_cgroup_tryget_online" in patch 3,
that is exactly the situation my suggestion is trying to prevent.

If you don't have a strong preference, it sounds like you should squash it.

Chris

>
> >
> > Chris
> >
> > >
> > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > ---
> > >  include/linux/memcontrol.h | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index 7bdcf3020d7a..2bd7d14ace78 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -821,6 +821,11 @@ static inline bool mem_cgroup_tryget(struct mem_=
cgroup *memcg)
> > >         return !memcg || css_tryget(&memcg->css);
> > >  }
> > >
> > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg=
)
> > > +{
> > > +       return !memcg || css_tryget_online(&memcg->css);
> > > +}
> > > +
> > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > >  {
> > >         if (memcg)
> > > @@ -1349,6 +1354,11 @@ static inline bool mem_cgroup_tryget(struct me=
m_cgroup *memcg)
> > >         return true;
> > >  }
> > >
> > > +static inline bool mem_cgroup_tryget_online(struct mem_cgroup *memcg=
)
> > > +{
> > > +       return true;
> > > +}
> > > +
> > >  static inline void mem_cgroup_put(struct mem_cgroup *memcg)
> > >  {
> > >  }
> > > --
> > > 2.34.1
> > >
>

