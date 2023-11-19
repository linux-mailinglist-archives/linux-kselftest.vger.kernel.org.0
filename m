Return-Path: <linux-kselftest+bounces-275-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2F7F04D7
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 09:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B5B0280CEC
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 Nov 2023 08:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDA720E4;
	Sun, 19 Nov 2023 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug45zPft"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABCC6523B
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 08:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C952C43395
	for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 08:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700383824;
	bh=HdzVGxJYk15Gjgr+wFA/oMVK8W+8pHYTJVcgIb7UjyM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ug45zPftG3vaVau2D0BjDzfacgJX6KCZQW0pOoBmmcFATf8yQwUjQebzLKe9A7YRe
	 9nK0DcnjsQPE40jU4Ias3rkIL89VndNA9OCZAPdEPsKf/GIg1W5RC6/GgPbfBr4aYw
	 HeYv7ckdMPN8P5vkWgglvsXN5ngxta858a2MmPEs+A+PMXoNxZWFnEpMRQWkmKkU0h
	 S/DCpWYZWQ9Clj4Ko9efl3sYWU2sTRKKxo9s9rUrBagEed7OP7ea6EsYoVUHDCOs9u
	 qT46kuphwFDS8qg3iNm23oeJtfpUqO/a7IfT3SEGuH+0ilyUkE4wP4wlH78AgSzE6C
	 d1vM/TPpsYm3A==
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2630085a12.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Nov 2023 00:50:24 -0800 (PST)
X-Gm-Message-State: AOJu0YxfLzl/10KH+Njp4vKa4kxhreM/+vm5ZtMDxd8/h4hfQI1j1Ac4
	yapEccz9TLjzqDu/wAyQwUYGEzMMkrjhE5wlA+i9Vw==
X-Google-Smtp-Source: AGHT+IEAJ3AMtVkJ9rRb2qpIkz0E/5/q4lZMJnZLcsbiX1vTfPLQmeoZEoV9XD219E2vj0V6fSQrr67FzD50bpplp3Y=
X-Received: by 2002:a05:6a21:1c8f:b0:186:7842:ad0c with SMTP id
 sf15-20020a056a211c8f00b001867842ad0cmr5299912pzb.35.1700383823740; Sun, 19
 Nov 2023 00:50:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106183159.3562879-1-nphamcs@gmail.com> <CAF8kJuMsXUm9=kiL8qPNVfYPzfyq-JWYSH3KraZadjF+myW-2A@mail.gmail.com>
 <CAKEwX=MNKY0UHbxi6Zfwf0KkepYavFaZo8F6LGe5GyyE3U35Jg@mail.gmail.com>
 <CAF8kJuMx4KT9z2RPy8z+snhM6YUtK=kZ1+BdHjKua2jhwFo-XQ@mail.gmail.com>
 <CAKEwX=OpQZhDmCr-a+O0=c8LfPoO0r8y=abpQoKXWcOP+V6yYg@mail.gmail.com>
 <CAF8kJuNnM_0jDCaAueseiNA1264-MtA0QiQtfjEN1E6aY56MKQ@mail.gmail.com>
 <CAF8kJuN5fBBmpOzmR72B5NBmjPNCNk4DALqz=+PKBwQrjvHH2w@mail.gmail.com> <CAKEwX=P343G80Bfbf1R+FfSxty763Bo3WCo_Pu0GOuZSJjnxRw@mail.gmail.com>
In-Reply-To: <CAKEwX=P343G80Bfbf1R+FfSxty763Bo3WCo_Pu0GOuZSJjnxRw@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 19 Nov 2023 00:50:12 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOJyiCM7WyW3Jn2Km3WH06OtrQ3hA911jrv2gPG4iqY0Q@mail.gmail.com>
Message-ID: <CAF8kJuOJyiCM7WyW3Jn2Km3WH06OtrQ3hA911jrv2gPG4iqY0Q@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] workload-specific and memory pressure-driven zswap writeback
To: Nhat Pham <nphamcs@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeelb@google.com>, 
	Muchun Song <muchun.song@linux.dev>, linux-mm <linux-mm@kvack.org>, kernel-team@meta.com, 
	LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, shuah@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 8:23=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Thu, Nov 16, 2023 at 4:57=E2=80=AFPM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > Hi Nhat,
> >
> > I want want to share the high level feedback we discussed here in the
> > mailing list as well.
> >
> > It is my observation that each memcg LRU list can't compare the page
> > time order with other memcg.
> > It works great when the leaf level memcg hits the memory limit and you
> > want to reclaim from that memcg.
> > It works less well on the global memory pressure you need to reclaim
> > from all memcg. You kind of have to
> > scan each all child memcg to find out the best page to shrink from. It
> > is less effective to get to the most desirable page quickly.
> >
> > This can benefit from a design similar to MGLRU. This idea is
> > suggested by Yu Zhao, credit goes to him not me.
> > In other words, the current patch is similar to the memcg page list
> > pre MGLRU world. We can have a MRLRU
> > like per memcg zswap shrink list.
>
> I was gonna summarize the points myself :P But thanks for doing this.
> It's your idea so you're more qualified to explain this anyway ;)

The MGLRU like shrinker was Zhao Yu's idea. I just observe the problem.

>
> I absolutely agree that having a generation-aware cgroup-aware
> NUMA-aware LRU is the future way to go. Currently, IIUC, the reclaim logi=
c
> selects cgroups in a round-robin-ish manner. It's "fair" in this perspect=
ive,
> but I also think it's not ideal. As we have discussed, the current list_l=
ru
> infrastructure only take into account intra-cgroup relative recency, not
> inter-cgroup relative recency. The recently proposed time-based zswap
> reclaim mechanism will provide us with a source of information, but the
> overhead of using this might be too high - and it's very zswap-specific.

I don't mind it is zswap-specific, as long as it is effective.
The overhead has two folds:
1) memory overhead on storing timestamps on per compressed page.
2) cpu overhead for reading timestamps.
Using MGLRU likely have advantage over time stamps on both memory and
cpu. The generation can use fewer bits and doesn't require reading
time on every page.

> Maybe after this, we should improve zswap reclaim (and perhaps all
> list_lru users) by adding generations to list_lru then take generations
> into account in the vmscan code. This patch series could be merged

One high level idea is that we can get the page generation in the
MGLRU before it gets into zswap. Just retain the generation into the
zpool LRU somehow.

> as-is, and once we make list_lru generation-aware, zswap shrinker
> will automagically be improved (along with all other list_lru/shrinker
> users).

I don't think it will automatically improve, you will need to rewrite
a lot of code in the shrinker as well to best use MGLRU zpool.

>
> I don't know enough about the current design of MGLRU to comment
> too much further, but let me know if this makes sense, and if you have
> objections/other ideas.

Taking the step by step approach is fine by me as long as we are
making steady progress towards the better end goal.

>
> And if you have other documentations for MGLRU than its code, could
> you please let me know? I'm struggling to find more details about this.

I would need to learn MGLRU myself. We can share and compare notes
when we get to it.

Chris

