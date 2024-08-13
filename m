Return-Path: <linux-kselftest+bounces-15260-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7579A950C59
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 20:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ECF1F260B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45F61A01BD;
	Tue, 13 Aug 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="16hU/NNH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7D11CA89;
	Tue, 13 Aug 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723573995; cv=none; b=lv/GF5B/PF4s+NX1/e55fDZCQICJKzz7TJDMRViARy5ZcxZdUIZh4eP2hKQVsPE2lTbbVNcKpPToznKNCRp00NaSgPsGDOgYOmtSgtqQVvJ9a8UL5W+whc8MyPHbYreifcaoag9cKYl2u9hFblSN1PPae289NH+3SQg89GhNQRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723573995; c=relaxed/simple;
	bh=KWDKWjxE1E/s3QH15Hq35qO4ScPFX3+4IcVvJdtREl0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UvNYOrnHNMFzb75WWQffl+tuIP/VD27EDQ+I0M/YL77NLBvBzTHKljKgufBsdVP5EutCCQs313aq5bZLcjy/FOZrZJQaLF0zXMs07krl42tuw5aotx6UECXsea4B6Ya1bR550b2L8lUwcsa3mK4dd0NFZlKY5YfIJBGJzI1knFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=16hU/NNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23CDC32782;
	Tue, 13 Aug 2024 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723573995;
	bh=KWDKWjxE1E/s3QH15Hq35qO4ScPFX3+4IcVvJdtREl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=16hU/NNHYwuhJAbfzotkgWfso/3cOiglyCcrwFjNI38PqvFno4xiVLWbcohboe1RH
	 q8mKXD992a9LedQWWQ4oa/2ix0CehYUTOrAziOs3gNvf5hwENzAmrOnUG9TOcowVBR
	 t/zBC9UVG286GNOHG6GisP2ZCZhPgLVomUZWyBM0=
Date: Tue, 13 Aug 2024 11:33:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yuanchu Xie <yuanchu@google.com>
Cc: David Hildenbrand <david@redhat.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.ibm.com>, Khalid Aziz <khalid.aziz@oracle.com>, Henry
 Huang <henry.hj@antgroup.com>, Yu Zhao <yuzhao@google.com>, Dan Williams
 <dan.j.williams@intel.com>, Gregory Price <gregory.price@memverge.com>,
 Huang Ying <ying.huang@intel.com>, Lance Yang <ioworker0@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Muhammad Usama Anjum
 <usama.anjum@collabora.com>, Kalesh Singh <kaleshsingh@google.com>, Wei Xu
 <weixugc@google.com>, David Rientjes <rientjes@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko
 <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song
 <muchun.song@linux.dev>, Shuah Khan <shuah@kernel.org>, Yosry Ahmed
 <yosryahmed@google.com>, Matthew Wilcox <willy@infradead.org>, Sudarshan
 Rajagopalan <quic_sudaraja@quicinc.com>, Kairui Song <kasong@tencent.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Vasily Averin
 <vasily.averin@linux.dev>, Nhat Pham <nphamcs@gmail.com>, Miaohe Lin
 <linmiaohe@huawei.com>, Qi Zheng <zhengqi.arch@bytedance.com>, Abel Wu
 <wuyun.abel@bytedance.com>, "Vishal Moola (Oracle)"
 <vishal.moola@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, cgroups@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 0/7] mm: workingset reporting
Message-Id: <20240813113313.1af3a5d7db7134a354a4cda3@linux-foundation.org>
In-Reply-To: <20240813165619.748102-1-yuanchu@google.com>
References: <20240813165619.748102-1-yuanchu@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 09:56:11 -0700 Yuanchu Xie <yuanchu@google.com> wrote:

> This patch series provides workingset reporting of user pages in
> lruvecs, of which coldness can be tracked by accessed bits and fd
> references.

Very little reviewer interest.  I wonder why.  Will Google be the only
organization which finds this useful?

> Benchmarks
> ==========
> Ghait Ouled Amar Ben Cheikh has implemented a simple "reclaim everything
> colder than 10 seconds every 40 seconds" policy and ran Linux compile
> and redis from the phoronix test suite. The results are in his repo:
> https://github.com/miloudi98/WMO

I'd suggest at least summarizing these results here in the [0/N].  The
Linux kernel will probably outlive that URL!

