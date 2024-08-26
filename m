Return-Path: <linux-kselftest+bounces-16351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A974995FDD1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 01:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73131C21742
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 23:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4056019B59F;
	Mon, 26 Aug 2024 23:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2jobZu2O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8369C19A29A
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724715797; cv=none; b=nXn8n3b9VHU04bMD/XoUTdpxRearGKSkKm550ImXpPSRYZbfusVkryHa6yRhptvpClqgDPcZErxHwk0ylBg8IpF5e403bniOR2l8jdkNwWKK/S9JcKA6a8h4Lu4PwHgd23ycTBc0m1+pm7dX2BLG2ta3wujEHQe2rBtA89nll44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724715797; c=relaxed/simple;
	bh=aLKvXwCQ8CpZX8jumViMtPWTpxywDphZ6fLhEFAOD9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UTqzRzLVmUaVKBVxwdnXjNK5e8wHB8xQOFKKdJ2An+J/aYZ7lv7BPX5MERACl0cXOycyWs2AqBseJRvJaliH+KkGwlgnzNYto5p0hXhFs39ol0uFJ8RHquVy5d8itGWwzXVFYuIYMHa9PsnDupboSN6UUUEY1aj4dOMIDKmrlS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2jobZu2O; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39d41b61178so37905ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724715794; x=1725320594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dnincskxIZjFY36curyurg9fJCPd6cnHUMKQnuVVoFk=;
        b=2jobZu2OZCmcjuR6xeSEPHogVnKQb6uUhW7xz2CpqQrA5LChdZ5h6HcX0uaQjiVgbn
         MDiCK5/sv74DYnY7ykBZTpamu1x5zEmWQp/fhtxrnUo5nGYFn6WO2A4bt883/4rrlo9T
         XgmoDnl/nVqD61siUHUoOAvBrtkqLWKu5T+1iWsRXPwjDPuvMbjhMhaKdUt8EFZN3qqF
         SkvBTMtVA5oN5mqhbtdkpXvx9cKcf03u27YPY1/WLpC9Rh0s7u1v3RRZOvBpkUWYP5QI
         O2lNfTISv8Sg15fXfL5Ot223AC57B8NWfE+Q5aUHkPUsUb7rj7kefbGBzNO3aV5npbP7
         v7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724715794; x=1725320594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dnincskxIZjFY36curyurg9fJCPd6cnHUMKQnuVVoFk=;
        b=K7GXjd9qMG7HrJqWkF4L9ikjoAayE7Bs1iwc4DHZDJxAVhExN0Dd6TxGpP1b7mhbL0
         NxdLahNk6NtQM5NBuM/CmK7H7vqqXvrRgY/VozFLAlUJ3Ny7WsnYxPT9PRUA1xdiA1ZD
         DDQPY733FbxaibltPci7su11qQASkeHvS6FE79wnO1QOtUghmpdNf85LoiDnAD6JjlYZ
         nej6Vf4moUPE9Q9qYiXjKSlMHiQHzp3AFdZYxb+lWJP/uLVAl3dbfz94asbl12DHLUp0
         YnEN6k4ztvznlaZR7SfSAOOz3tD9bmyHXC0P5ArlONDPbILItLoMxJ4lIhhNP6vjjwkF
         dVYA==
X-Forwarded-Encrypted: i=1; AJvYcCXvTOcBV7l1u4b5ceKXRQUS+P2IP5hh1WInSUZ0am29pZgqrri9lvsf6YkRTunPLLfTUMbaCbOcV1H/AREZOX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcI7GHzA/qDjBoGBsSUKgyWC7DA5gxX+YM1K+B1ArElGJqQdy/
	HqH6CwzJgCQu5ObDC97EzOw7Z06X9D4khkcQ9evIg4GgAIe2D/L8CnONFahGAK3XpFG7tlRrAC9
	HC6w3K7k3rEIjloZrGj/uQURloM7Zyu/b+koN
X-Google-Smtp-Source: AGHT+IFE60KjWQ+LhatMhLcNn4ylcp/3BX1PMZw7JB2CKalx7ld2SR1EOoZ3z8exQZ8pHnycdnnra1ayimhJIxisGrc=
X-Received: by 2002:a05:6e02:18c7:b0:381:24d7:7cc6 with SMTP id
 e9e14a558f8ab-39e65ea0ae0mr778165ab.3.1724715794374; Mon, 26 Aug 2024
 16:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813165619.748102-1-yuanchu@google.com> <ZsSTdY5hsv05jcj-@PC2K9PVX.TheFacebook.com>
In-Reply-To: <ZsSTdY5hsv05jcj-@PC2K9PVX.TheFacebook.com>
From: Yuanchu Xie <yuanchu@google.com>
Date: Mon, 26 Aug 2024 16:43:01 -0700
Message-ID: <CAJj2-QGtvvrhjH_h1wL3FCg4HgZU27rqxSCDZzPws81yPK_DvQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] mm: workingset reporting
To: gourry@gourry.net
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
	Khalid Aziz <khalid.aziz@oracle.com>, Henry Huang <henry.hj@antgroup.com>, 
	Yu Zhao <yuzhao@google.com>, Dan Williams <dan.j.williams@intel.com>, 
	Gregory Price <gregory.price@memverge.com>, Huang Ying <ying.huang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>, 
	David Rientjes <rientjes@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>, 
	Kairui Song <kasong@tencent.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Vasily Averin <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Abel Wu <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 6:00=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Tue, Aug 13, 2024 at 09:56:11AM -0700, Yuanchu Xie wrote:
> > This patch series provides workingset reporting of user pages in
> > lruvecs, of which coldness can be tracked by accessed bits and fd
> > references. However, the concept of workingset applies generically to
> > all types of memory, which could be kernel slab caches, discardable
> > userspace caches (databases), or CXL.mem. Therefore, data sources might
> > come from slab shrinkers, device drivers, or the userspace. IMO, the
> > kernel should provide a set of workingset interfaces that should be
> > generic enough to accommodate the various use cases, and be extensible
> > to potential future use cases. The current proposed interfaces are not
> > sufficient in that regard, but I would like to start somewhere, solicit
> > feedback, and iterate.
> >
> ... snip ...
> > Use cases
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Promotion/Demotion
> > If different mechanisms are used for promition and demotion, workingset
> > information can help connect the two and avoid pages being migrated bac=
k
> > and forth.
> > For example, given a promotion hot page threshold defined in reaccess
> > distance of N seconds (promote pages accessed more often than every N
> > seconds). The threshold N should be set so that ~80% (e.g.) of pages on
> > the fast memory node passes the threshold. This calculation can be done
> > with workingset reports.
> > To be directly useful for promotion policies, the workingset report
> > interfaces need to be extended to report hotness and gather hotness
> > information from the devices[1].
> >
> > [1]
> > https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirem=
ents-white-paper-pdf-1
> >
> > Sysfs and Cgroup Interfaces
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The interfaces are detailed in the patches that introduce them. The mai=
n
> > idea here is we break down the workingset per-node per-memcg into time
> > intervals (ms), e.g.
> >
> > 1000 anon=3D137368 file=3D24530
> > 20000 anon=3D34342 file=3D0
> > 30000 anon=3D353232 file=3D333608
> > 40000 anon=3D407198 file=3D206052
> > 9223372036854775807 anon=3D4925624 file=3D892892
> >
> > I realize this does not generalize well to hotness information, but I
> > lack the intuition for an abstraction that presents hotness in a useful
> > way. Based on a recent proposal for move_phys_pages[2], it seems like
> > userspace tiering software would like to move specific physical pages,
> > instead of informing the kernel "move x number of hot pages to y
> > device". Please advise.
> >
> > [2]
> > https://lore.kernel.org/lkml/20240319172609.332900-1-gregory.price@memv=
erge.com/
> >
>
> Just as a note on this work, this is really a testing interface.  The
> end-goal is not to merge such an interface that is user-facing like
> move_phys_pages, but instead to have something like a triggered kernel
> task that has a directive of "Promote X pages from Device A".
>
> This work is more of an open collaboration for prototyping such that we
> don't have to plumb it through the kernel from the start and assess the
> usefulness of the hardware hotness collection mechanism.

Understood. I think we previously had this exchange and I forgot to
remove the mentions from the cover letter.

>
> ---
>
> More generally on promotion, I have been considering recently a problem
> with promoting unmapped pagecache pages - since they are not subject to
> NUMA hint faults.  I started looking at PG_accessed and PG_workingset as
> a potential mechanism to trigger promotion - but i'm starting to see a
> pattern of competing priorities between reclaim (LRU/MGLRU) logic and
> promotion logic.

In this case, IMO hardware support would be good as it could provide
the kernel with exactly what pages are hot, and it would not care
whether a page is mapped or not. I recall there being some CXL
proposal on this, but I'm not sure whether it has settled into a
standard yet.

>
> Reclaim is triggered largely under memory pressure - which means co-optin=
g
> reclaim logic for promotion is at best logically confusing, and at worst
> likely to introduce regressions.  The LRU/MGLRU logic is written largely
> for reclaim, not promotion.  This makes hacking promotion in after the
> fact rather dubious - the design choices don't match.
>
> One example: if a page moves from inactive->active (or old->young), we
> could treat this as a page "becoming hot" and mark it for promotion, but
> this potentially punishes pages on the "active/younger" lists which are
> themselves hotter.

To avoid punishing pages on the "young" list, one could insert the
page into a "less young" generation, but it would be difficult to have
a fixed policy for this in the kernel, so it may be best for this to
be configurable via BPF. One could insert the page in the middle of
the active/inactive list, but that would in effect create multiple
generations.

>
> I'm starting to think separate demotion/reclaim and promotion components
> are warranted. This could take the form of a separate kernel worker that
> occasionally gets scheduled to manage a promotion list, or even the
> addition of a PG_promote flag to decouple reclaim and promotion logic
> completely.  Separating the structures entirely would be good to allow
> both demotion/reclaim and promotion to occur concurrently (although this
> seems problematic under memory pressure).
>
> Would like to know your thoughts here.  If we can decide to segregate
> promotion and demotion logic, it might go a long way to simplify the
> existing interfaces and formalize transactions between the two.

The two systems still have to interact, so separating the two would
essentially create a new policy that decides whether the
demotion/reclaim or the promotion policy is in effect. If promotion
could figure out where to insert the page in terms of generations,
wouldn't that be simpler?

>
> (also if you're going to LPC, might be worth a chat in person)

I cannot make it to LPC. :( Sadness

Yuanchu

