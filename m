Return-Path: <linux-kselftest+bounces-26825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 627D3A3920F
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 05:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F416975A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 04:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31A198823;
	Tue, 18 Feb 2025 04:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IKYM2iG5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A1712CDA5;
	Tue, 18 Feb 2025 04:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739851964; cv=none; b=NczzKbe06OUqnxvwXiqDMUopk/5uVF7763+/8SARRXjbLLl2/sGD3dWYK99GJQzVQbn/hWTXZiykE9zSOla1JvgLwnZlqQQKodnymD6gYOLmUWCm9vvoMakVhZ1W2OTRuEbc4o7FeCIY6RKwR0/FYHCLifUoYadQvyBKWfp4bVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739851964; c=relaxed/simple;
	bh=38jLuNaSVk5HK1+pU/7A9uz3NtGUBWLI+P5FDcwIGjs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sSZJUBMhzecOfq8dCF38oqUeoyVoqYyinWA8kA1ZFqlv1kF3bxwP8w2Keh9YDZ1LWrJKkBMD3mukGoaolmo/d/5f6A0VbXbNtBeHhqLXa9G1kzwwArg4BjeN8MgMsPMUFNlPscqd7ScbngCwdTZY2zHLwgnJ2KV8YoH1mYsw0zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IKYM2iG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A2AC4CEED;
	Tue, 18 Feb 2025 04:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1739851963;
	bh=38jLuNaSVk5HK1+pU/7A9uz3NtGUBWLI+P5FDcwIGjs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IKYM2iG53ABjPYcjmuZLGGnEdggr4qTg4SHRnRDgi5WqVRCe9Ml8ufMn9icQVZ9oV
	 pRrA/2wdw2WoD6FyFGDIjA9yhuUhkcByNayHQSgFkEU1wxW+ueedoEdoCB6NSvFFvr
	 A9UzG3JQcqpg1UWwZfQ26qLzRkhfcP0fLV1E7GP0=
Date: Mon, 17 Feb 2025 20:12:42 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Kirill A . Shutemov"
 <kirill.shutemov@linux.intel.com>, David Hildenbrand <david@redhat.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, Yang Shi
 <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, Kefeng
 Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, John
 Hubbard <jhubbard@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/8] mm/huge_memory: add buddy allocator like
 (non-uniform) folio_split()
Message-Id: <20250217201242.798583040111ddc019f68438@linux-foundation.org>
In-Reply-To: <A6E3A545-D2CD-46B6-A532-64BBBED42914@nvidia.com>
References: <20250211155034.268962-1-ziy@nvidia.com>
	<20250211155034.268962-5-ziy@nvidia.com>
	<f1198e22-3358-4f82-8227-49b0e779302f@redhat.com>
	<4483B46A-FEAF-46D9-AFF4-F0DF34864633@nvidia.com>
	<A6E3A545-D2CD-46B6-A532-64BBBED42914@nvidia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Feb 2025 10:22:44 -0500 Zi Yan <ziy@nvidia.com> wrote:

> >
> > Thanks. The patch below should fix it.
> >
> > I am going to send V8, since
> > 1. there have been 4 fixes so far for V7, a new series would help people
> > review;
> >
> > 2.  based on the discussion with you in THP cabal meeting, to
> > convert split_huge_page*() to use __folio_split(), the current
> > __folio_split() interface becomes awkward. Two changes are needed:
> >    a) use in folio offset instead of struct page, since even in
> >      truncate_inode_partial_folio() I needed to convert in folio offset
> >      struct page to use my current interface;
> >    b) split_huge_page*()'s caller might hold the page lock at a non-head
> >      page, so an additional keep_lock_at_in_folio_offset is needed
> >      to indicate which after-split folio should be kept locked after
> >      split is done.
> >
> 
> Hi Andrew,
> 
> I am planing to send V8 to collect all fixup patches I have so far plus
> the one below and change folio_split() interface and some of the code.
> What is your preferred method?
> 
> 1. you can pick up the fixup below and I send a new set of patches to
> change folio_split();
> 
> 2. I collect a new V8 with all fixup patches and folio_split() change.
> 
> For 1, the commit history might be messy due to my new folio_split()
> change. For 2, Minimize xa_node allocation during xarry split [1]
> patchset depends on patch 1 of this series, which adds some extra work
> for you to collect V8 (alternatively, I can send V8 without patch 1).

We're only at -rc3, so I'll remove both series from mm.git.  Please
fully resend both series against mm-unstable?

