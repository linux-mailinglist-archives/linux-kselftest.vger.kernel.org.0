Return-Path: <linux-kselftest+bounces-15771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8D5958778
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BA9B2239D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 13:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498AC18CBE8;
	Tue, 20 Aug 2024 13:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="laO+dyCv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3FE15749C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724158855; cv=none; b=S9cQkMo4Nm3KcZyUOKoOQ+Kybxtp8bL6AjyBcEG0geB9HAqVkI9zSqezIh9qlSuC+z4G1WXLy+L0rFNxlt4hDwldKIHRmMoT1i0+YgRafaqSWAgHDfVhlJ23ukbeQt0daAjm695dxj0meOr/TFzsPZ2ruUXw4ga3lCW1PywEGvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724158855; c=relaxed/simple;
	bh=zhEVvf/8ae7zkCvJwHGZWYWO5HMcGw4uFVnrq5d2+M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rjdo4q6oWBZH4xUAqBJbbQExvxBUAjZEH0uJc7Os54qjVKg/ICcu63P1MkdUuULS7VEVvoeP+Voh6r/3cmU7FhYIxL9uZiEh+WlbmjXQ4lRNXSKfofoGktjO70u/9HwYlG/dVNEW+Ve48wh2dZJ5SZjpoYBlbi/ud7N5w7lc06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=laO+dyCv; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-44fdde0c8dcso30120261cf.0
        for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1724158852; x=1724763652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j52XYJE2ICKQlINPQl+zW5CQKy5fCOrlHtppgGWQcXM=;
        b=laO+dyCv6CulVMqm4hlnC3CImpsfr6Tf9kaCF1hrQTwCMNCLQtTXPKK2/u3bACv3wb
         2TFoKq4niLCq0V+0NNO44uZxFafCFhG890T3QOPOF5lQKLHWkcxzix2srJMaU48VsUxm
         oSxl2WO5FwOV1UInXtjTYTyQTizgNrUO6QfVuviwGxGlMA0xOCr9KagPSTCRjw93c3EM
         quLM2ijwxfXbt5fT12gaGgCLbQV3Y5LJJPykBOguVbOrMtkJWWthL+KwDcCe8LjsAzgL
         zpCjrNo38Qo4d2Cy66+fc0frhw6uHBKkMFWxu/BPc2sgVM9skPUf81UH/x4RFDUea6Yb
         Mq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724158852; x=1724763652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j52XYJE2ICKQlINPQl+zW5CQKy5fCOrlHtppgGWQcXM=;
        b=YnE+Pj05RAJgaRP9so5kdK9+kE8ZRHPJyjqo5UBnnppGVMkEAOWEMdV16xrtsbUqzd
         TYzYMOsoFhvhgLHteuwFq+yK7rj9MRhhHXmyjMakQ/7X8UEdNKG/LgROYtNgz9KsH5rk
         eqNAFk1/GVgm5ZY2RUw1CPYAHiodXeG07Q9yeqswE3WspBk3RFZ7ZH8nBQkkAjlkqqYX
         v3q4Sah7xywdksLg1LYamKnN7tmDLcmgcadqD0HnTAVwGE9QkfXgqJwuRmECo2ZFrFeN
         q1mCCMxcV8vRdsdMzOm5weEW1TXxQO+o2Pa7rzvK4OMjHSuMbTKiEzwOt1EK75N7Fsv2
         uoUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi/IyITAwtr0sFSsH7m4cSK0snClNE6+jJyGjMwl2ubsLiB4vDhZN9LVim9H0AErMTaRlBjphmKmv8a41y2zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMiOKot7QQlMxPntASApeV2mLRUeiKfJMBzxdcVA6/LN6Dq/6v
	O/xpEdFoNtzUx90p/0SBS2wmIDYrDrwj5LV6D8/GIRIB8ZZlFBZmstVS8QcNNms=
X-Google-Smtp-Source: AGHT+IFogz/OKodC6xvuV+JQ0O1UMwu8nhnZCifjPnotmW7jOJBTqcnoRS5m2elNnoCh4kakCFzN+Q==
X-Received: by 2002:a05:622a:6186:b0:453:6cb2:c8d1 with SMTP id d75a77b69052e-45374310eaemr144853771cf.37.1724158852033;
        Tue, 20 Aug 2024 06:00:52 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (ip-185-104-139-70.ptr.icomera.net. [185.104.139.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd716csm50159141cf.4.2024.08.20.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 06:00:51 -0700 (PDT)
Date: Tue, 20 Aug 2024 09:00:37 -0400
From: Gregory Price <gourry@gourry.net>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Khalid Aziz <khalid.aziz@oracle.com>,
	Henry Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Gregory Price <gregory.price@memverge.com>,
	Huang Ying <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Kalesh Singh <kaleshsingh@google.com>, Wei Xu <weixugc@google.com>,
	David Rientjes <rientjes@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
	Kairui Song <kasong@tencent.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Vasily Averin <vasily.averin@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mm: workingset reporting
Message-ID: <ZsSTdY5hsv05jcj-@PC2K9PVX.TheFacebook.com>
References: <20240813165619.748102-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>

On Tue, Aug 13, 2024 at 09:56:11AM -0700, Yuanchu Xie wrote:
> This patch series provides workingset reporting of user pages in
> lruvecs, of which coldness can be tracked by accessed bits and fd
> references. However, the concept of workingset applies generically to
> all types of memory, which could be kernel slab caches, discardable
> userspace caches (databases), or CXL.mem. Therefore, data sources might
> come from slab shrinkers, device drivers, or the userspace. IMO, the
> kernel should provide a set of workingset interfaces that should be
> generic enough to accommodate the various use cases, and be extensible
> to potential future use cases. The current proposed interfaces are not
> sufficient in that regard, but I would like to start somewhere, solicit
> feedback, and iterate.
>
... snip ... 
> Use cases
> ==========
> Promotion/Demotion
> If different mechanisms are used for promition and demotion, workingset
> information can help connect the two and avoid pages being migrated back
> and forth.
> For example, given a promotion hot page threshold defined in reaccess
> distance of N seconds (promote pages accessed more often than every N
> seconds). The threshold N should be set so that ~80% (e.g.) of pages on
> the fast memory node passes the threshold. This calculation can be done
> with workingset reports.
> To be directly useful for promotion policies, the workingset report
> interfaces need to be extended to report hotness and gather hotness
> information from the devices[1].
> 
> [1]
> https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1
> 
> Sysfs and Cgroup Interfaces
> ==========
> The interfaces are detailed in the patches that introduce them. The main
> idea here is we break down the workingset per-node per-memcg into time
> intervals (ms), e.g.
> 
> 1000 anon=137368 file=24530
> 20000 anon=34342 file=0
> 30000 anon=353232 file=333608
> 40000 anon=407198 file=206052
> 9223372036854775807 anon=4925624 file=892892
> 
> I realize this does not generalize well to hotness information, but I
> lack the intuition for an abstraction that presents hotness in a useful
> way. Based on a recent proposal for move_phys_pages[2], it seems like
> userspace tiering software would like to move specific physical pages,
> instead of informing the kernel "move x number of hot pages to y
> device". Please advise.
> 
> [2]
> https://lore.kernel.org/lkml/20240319172609.332900-1-gregory.price@memverge.com/
> 

Just as a note on this work, this is really a testing interface.  The
end-goal is not to merge such an interface that is user-facing like
move_phys_pages, but instead to have something like a triggered kernel
task that has a directive of "Promote X pages from Device A".

This work is more of an open collaboration for prototyping such that we
don't have to plumb it through the kernel from the start and assess the
usefulness of the hardware hotness collection mechanism.

---

More generally on promotion, I have been considering recently a problem
with promoting unmapped pagecache pages - since they are not subject to
NUMA hint faults.  I started looking at PG_accessed and PG_workingset as
a potential mechanism to trigger promotion - but i'm starting to see a
pattern of competing priorities between reclaim (LRU/MGLRU) logic and
promotion logic.

Reclaim is triggered largely under memory pressure - which means co-opting
reclaim logic for promotion is at best logically confusing, and at worst
likely to introduce regressions.  The LRU/MGLRU logic is written largely
for reclaim, not promotion.  This makes hacking promotion in after the
fact rather dubious - the design choices don't match.

One example: if a page moves from inactive->active (or old->young), we
could treat this as a page "becoming hot" and mark it for promotion, but
this potentially punishes pages on the "active/younger" lists which are
themselves hotter.

I'm starting to think separate demotion/reclaim and promotion components
are warranted. This could take the form of a separate kernel worker that
occasionally gets scheduled to manage a promotion list, or even the
addition of a PG_promote flag to decouple reclaim and promotion logic
completely.  Separating the structures entirely would be good to allow
both demotion/reclaim and promotion to occur concurrently (although this
seems problematic under memory pressure).

Would like to know your thoughts here.  If we can decide to segregate
promotion and demotion logic, it might go a long way to simplify the
existing interfaces and formalize transactions between the two.

(also if you're going to LPC, might be worth a chat in person)

~Gregory

