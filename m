Return-Path: <linux-kselftest+bounces-29894-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCF3A751E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 22:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D00168CB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Mar 2025 21:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65501EB5FB;
	Fri, 28 Mar 2025 21:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geX4sRzp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0031BE86E;
	Fri, 28 Mar 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196166; cv=none; b=CRP8QTN/o0scrVFIncv1DgUGX/fA9L4ckFoGTVCw3CYuS4WdNjF7zYUB4t2xkP49puiixyWC0qd00rOjJZGVWzLy1tvFUkDG5CV/E4Za5CP7i0G0mkO/dJl7XYK+ruvsnRZdDtg6DVVRfW/JG2FF5DVecwDOauqvAHTi65sgr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196166; c=relaxed/simple;
	bh=LboS8TQ6QkgeY6sglCIVCClzvsM5P58IqfwxTUiDJv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbMlN58SrpBiaia70GKNK9N+KvoGEwWsfmVxvn6ze9gUefZdhp5P2tR82OO2OVB7b5THPDRnpXk7NqcXkNQLnjh46CvzGX6R1Mlyy6+KA0VT2EU+f0oVqYM29ap8lutEekqZP2jolxTGAanofG+jDIU6MGAB97e7UMRweSjPvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geX4sRzp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22409077c06so79777705ad.1;
        Fri, 28 Mar 2025 14:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743196164; x=1743800964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwl4NdWNLA+WiZCnf70iMDLkFwdpvil0W/uJAOBiirY=;
        b=geX4sRzpEDdszyAsaG1bRpY5qEHZfU+wZNBj6IMHNfRxD3nKgx20WcAZt74dgbQNwt
         5zfm2bT8ZwrOY3JyEaeJSZCZ0ApsNHELI0rIJWJNSZ5kflqfK6gEHzPqX/Y6t5OOxaRm
         t8P7v/bx51taN+YBpnSP5ciDeI52qN8nnIuk13XOVhWq88oEineO6YisZmy+ZiXzZEs7
         LxufmHHDqtUefA5mvUjUEcjjE1OOVk9foDUkrY9UGTKZVpW0iZe3MuxzEr5cKj/RAIX/
         ltClcQfpNUrrdclWk8ghd9LUu2+pBfH32mUE2WXr9ecKIsq5ZzGzIoPVMymMF7Jbod3D
         GBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743196164; x=1743800964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwl4NdWNLA+WiZCnf70iMDLkFwdpvil0W/uJAOBiirY=;
        b=SID62Pq0QOEWdsfTS+ZBje4n22u0TMIJQDBGz0QlMAJ5hKFBbOqRqanM5hSo7UtPp6
         i0hcpjaSLn9Zvu7zUeRMHiu+y6yRjj1oL6Rm9OZbaZZr61Gc8QjmhuMY+UVuBcfJ4Zwu
         CShSCLpOSpji/Ub2bkLBbiDb3VXiLP18ghVorR2uddvjAJZ77hV8sPRySzvg4o+p9Z7g
         ej8INeOxzGyZ37+UPla48m6Lj5ZFx6fFeBEXOWUYotxLxPIaoGi6n+ETsOhnew6Y8o6F
         Dl4pamPMMvJD7wN4LuzP90UWboTpjHG+Wsq4grl8pt0J8bjS34STs8CqZ/Q046cb2Jhf
         sMSg==
X-Forwarded-Encrypted: i=1; AJvYcCVAzjawwQdAiN9BjfmkXzBr/c1ORRpyqwUW491tXefanqVx+IcMEDAYfVsGTLbb81EgmT0weITNk0OvFPoZOGQL@vger.kernel.org, AJvYcCVxGGKJG3IQE01ZQa5yIf6KEht5G5+OCbq5fjLVRjvTZR5cLPDwCTK4ha1fgEHGZupGvxQf4A069agkmLs=@vger.kernel.org, AJvYcCW2sbP+RCglBXFOkH6AUbeb2g2BEn1x7BfL87K3VvrvQSGGbZlDaPPNnXbqUGbC+tMC6bhK+kYZu00r570=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpDBt/OU/YEZblq/L82uXm7++TyNAxCODtukkFmTdXzRDfKPtx
	ncHM0g9yMk2cBlRA8s0SmL5Xabv/H+Yqz4uCe/qbKsFrLOoWVHlI
X-Gm-Gg: ASbGnctC90RbJ3Uv2G4kvF8qibiK9MydutHBiZsiHS8TR9dN7mT/aOuplGMKhENz214
	BEEKRaoBAA1UbqBbXUS2oKej1ahSxNIXHWUnAGnjWsPOi0UgAqxNAGf8tb4358dVf50a0qiUmM/
	ppsufGnQlXcwovS0Ab6XpTmsvZYjYmR0jD45eUs8ABcbOGUKED0WQXQEu1n+uMcH384xelq3H7A
	atX9wIt43Bh2P3kzn4XHDy89zFGORdnNF+PhhvDMEZYv46xLR4pbxZP0csbnlWmXxxRbzgZcCGZ
	oMb85BdtAwftjxc08+c+963h40CcZninqWN3YJJi3jZIXmvrPnI2k3JEWj9FCq+XXKZDoLCJf/m
	Y
X-Google-Smtp-Source: AGHT+IHd9fQtVFVVgph9WnMxD+yvA2cH9ftmKIA/aV/HJRnRVCXLI90/TItx7A2zuPaJnIRPAtH+Uw==
X-Received: by 2002:a17:903:2ce:b0:220:e5be:29c7 with SMTP id d9443c01a7336-2292f9f64fbmr10191425ad.39.1743196164150;
        Fri, 28 Mar 2025 14:09:24 -0700 (PDT)
Received: from fedora (c-67-164-59-41.hsd1.ca.comcast.net. [67.164.59.41])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eee22a2sm23351755ad.81.2025.03.28.14.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 14:09:23 -0700 (PDT)
Date: Fri, 28 Mar 2025 14:09:20 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: Huan Yang <link@vivo.com>
Cc: bingbu.cao@linux.intel.com, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@lst.de>, Gerd Hoffmann <kraxel@redhat.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [RFC PATCH 0/6] Deep talk about folio vmap
Message-ID: <Z-cQAIsh3dAhaT6s@fedora>
References: <20250327092922.536-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327092922.536-1-link@vivo.com>

On Thu, Mar 27, 2025 at 05:28:27PM +0800, Huan Yang wrote:
> Bingbu reported an issue in [1] that udmabuf vmap failed and in [2], we
> discussed the scenario of folio vmap due to the misuse of vmap_pfn
> in udmabuf.
> 
> We reached the conclusion that vmap_pfn prohibits the use of page-based
> PFNs:
> Christoph Hellwig : 'No, vmap_pfn is entirely for memory not backed by
> pages or folios, i.e. PCIe BARs and similar memory.  This must not be
> mixed with proper folio backed memory.'
> 
> But udmabuf still need consider HVO based folio's vmap, and need fix
> vmap issue. This RFC code want to show the two point that I mentioned
> in [2], and more deep talk it:
> 
> Point1. simple copy vmap_pfn code, don't bother common vmap_pfn, use by
> itself and remove pfn_valid check.
> 
> Point2. implement folio array based vmap(vmap_folios), which can given a
> range of each folio(offset, nr_pages), so can suit HVO folio's vmap.
> 
> Patch 1-2 implement point1, and add a test simple set in udmabuf driver.
> Patch 3-5 implement point2, also can test it.
> 
> Kasireddy also show that 'another option is to just limit udmabuf's vmap()
> to only shmem folios'(This I guess folio_test_hugetlb_vmemmap_optimized
> can help.)
> 
> But I prefer point2 to solution this issue, and IMO, folio based vmap still
> need.
> 
> Compare to page based vmap(or pfn based), we need split each large folio
> into single page struct, this need more large array struct and more longer
> iter. If each tail page struct not exist(like HVO), can only use pfn vmap,
> but there are no common api to do this.
> 
> In [2], we talked that udmabuf can use hugetlb as the memory
> provider, and can give a range use. So if HVO used in hugetlb, each folio's
> tail page may freed, so we can't use page based vmap, only can use pfn
> based, which show in point1.
> 
> Further more, Folio based vmap only need record each folio(and offset,
> nr_pages if range need). For 20MB vmap, page based need 5120 pages(40KB),
> 2MB folios only need 10 folio(80Byte).
> 
> Matthew show that Vishal also offered a folio based vmap - vmap_file[3].
> This RFC patch want a range based folio, not only a full folio's map(like
> file's folio), to resolve some problem like HVO's range folio vmap.

Hmmm, I should've been more communicative, sorry about that. V1 was
poorly implemented, and I've had a V2 sitting around that does Exactly
what you want.

I'll send V2 to the mailing list and you can take a look at it;
preferrably you integrate that into this patchset instead (it would
make both the udma and vmalloc code much neater).

> Please give me more suggestion.
> 
> Test case:
> //enable/disable HVO
> 1. echo [1|0] > /proc/sys/vm/hugetlb_optimize_vmemmap
> //prepare HUGETLB
> 2. echo 10 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> 3. ./udmabuf_vmap
> 4. check output, and dmesg if any warn.
> 
> [1] https://lore.kernel.org/all/9172a601-c360-0d5b-ba1b-33deba430455@linux.intel.com/
> [2] https://lore.kernel.org/lkml/20250312061513.1126496-1-link@vivo.com/
> [3] https://lore.kernel.org/linux-mm/20250131001806.92349-1-vishal.moola@gmail.com/
> 
> Huan Yang (6):
>   udmabuf: try fix udmabuf vmap
>   udmabuf: try udmabuf vmap test
>   mm/vmalloc: try add vmap folios range
>   udmabuf: use vmap_range_folios
>   udmabuf: vmap test suit for pages and pfns compare
>   udmabuf: remove no need code
> 
>  drivers/dma-buf/udmabuf.c | 29 +++++++++-----------
>  include/linux/vmalloc.h   | 57 +++++++++++++++++++++++++++++++++++++++
>  mm/vmalloc.c              | 47 ++++++++++++++++++++++++++++++++
>  3 files changed, 117 insertions(+), 16 deletions(-)
> 
> --
> 2.48.1
> 

