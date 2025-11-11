Return-Path: <linux-kselftest+bounces-45336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21AC4F327
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E253D34CF70
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42623559ED;
	Tue, 11 Nov 2025 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="VkCQ1/aD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkRKd9HB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8632826C;
	Tue, 11 Nov 2025 17:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881064; cv=none; b=D1fXeduflyc6kHTT96cIiXzAUgVEaQh0Xr6cmilYSbbZl+Erufv28SYyth9993P/YMiabayDUcxM6MwHIYe/elTZiPckdjZGBzszBYXRVF/9rifGHtO3XLKcUT4nlN20sOms56WH3Q5H+Vx64huFDa7zjErXLLw6HCnC9+KAhvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881064; c=relaxed/simple;
	bh=NcwSQKsZZpCba9IxZtpRyejPYP4vPwPXYtCJSvTUJRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBlDJnRJdtH5frvB4FGkRYADAtoQSmL3KTt6iKG7S8LlrDNgHB+f8zfcQURaAwM/BGFK653ejf0d/b/1+BTwyI9dXFAkbJgtp0eXwV8cU5CHb4S4JxBRo0uyPNOMqNSrf/jwaLo1OI577VGlJvKkz/bw68yKz2lY7BH2sAHtEC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=VkCQ1/aD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkRKd9HB; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.phl.internal (Postfix) with ESMTP id 67F45138083D;
	Tue, 11 Nov 2025 12:11:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 11 Nov 2025 12:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762881060;
	 x=1762888260; bh=CbFWadyECdlIFP3T4yr5pfGRr5O3w+0RGvNtkYsu5t0=; b=
	VkCQ1/aDuS9nIwSQKdnug3G/hq3a3eGjepBEFsLJs0VWOFBCRnXWkWnFPy6qxmnk
	YZrp0RvGrSMngP6mH0r/uaSvoDTOzElp8Adi+3ODmXnBf9vj3+0AjP2F35EfR+8J
	5z0zqTuXfbJqcZS/shdYU5NHKqo6Vsx2Y8BIzA0FgwfuuDHRJeWYUcwQur/AfTky
	iB+mN3fMfHGm3vvn1L1S8C1B7xJEwoPb2FjKAJe1xH0cpqFVpEgv8jK97sFi/tWB
	B2iViWw6HVGqa9ml0GW8ZttYinIUB8S6O8k6b7eanoQ063Kpk67c+aAUwozU3Y72
	HJ0dSwxT3PF2SP4AxfxLpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762881060; x=
	1762888260; bh=CbFWadyECdlIFP3T4yr5pfGRr5O3w+0RGvNtkYsu5t0=; b=K
	kRKd9HBFw4V9q8+TuU8WyhvH7YP78BMQmzpoCP6537ccsMFSEfwF+uWGIHY5pL4j
	w7rfY8tFlogK/h65OsdD7UFlmXAr6ioLhz3kgkOWIwLtAzXyNo6xgm/pVXJk6oU9
	+7lKF/zLgjPeFAnpSqLdFfPQQDBJrj/wMjjObYsiaXPmhFrCLGE2QhQjBvcKZ0zq
	m0+f7KqljXYzefnsTf2KkEnrauo0oXGme/hXtot2m8z8k9fSHPTr6eNSaBMBQQx2
	rP0HHVY0bW1xQeTcGYxQp/X13woBYDq4jqSu0VDhdtNrp0X1b4DTIGvtDJ3dKyQs
	5kfx3nh3iQZJOtiN/eUKg==
X-ME-Sender: <xms:JG4TaZoEmx4_D7MVQU8q-NePEKIrCt_9TjgxhFlYUZkzaU4QQDXwGA>
    <xme:JG4TaVuxaGphk0V-oxDjw65aiXYOCHZNdWA04Ji6dmCNf9yM_cnUDHISFlCSkjg9A
    kFIVANdxWJz3-vXkUKexgU8M7UTkepQkV8QKIPEr_BfO99VCO07Ttc>
X-ME-Received: <xmr:JG4TaWGhqTtLg7cR_WVEqhh-eS8geiFdDDw5ilOnsBqqhCxfmYAT2rv->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucfrhhhishhhihhnghdqkffkrfgprhhtucdliedtjedmne
    cujfgurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgig
    ucghihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrf
    grthhtvghrnhephedvtdeuveejudffjeefudfhueefjedvtefgffdtieeiudfhjeejhffh
    feeuvedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhr
    ghdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprg
    hmrghsthhrohesfhgsrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjghhgseiiihgvphgvrdgtrgdprhgtphhtthhopehkvhhmsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghr
    rdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:JG4TaWbXC0AcQGxTWvv7BTHkAayGZLVh9GEbtzq0gpf1lfNvkVXnAQ>
    <xmx:JG4TaWUYJYIr-E8v7BWt9ZnJpHJ4kyucgPxOrywXRbQpHIkMcKbGtQ>
    <xmx:JG4Tack-u0Xcm-1o69lPY59LvHW9wwUpPwLFblY_nPt9aAfY8dHyOw>
    <xmx:JG4TaRDgrEICmLG42t55vxxm1ZYZj7b0DMbF9fuCceJcAyxv7nvszQ>
    <xmx:JG4TaQb2XzmNw9ptKzLA8H7AdrOxajdAlty9Xkycmu97h6UJ9Qq-tjSX>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:10:59 -0500 (EST)
Date: Tue, 11 Nov 2025 10:10:57 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <20251111101057.24c837ec.alex@shazbot.org>
In-Reply-To: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 06:52:01 -0800
Alex Mastro <amastro@fb.com> wrote:

> Not all IOMMUs support the same virtual address width as the processor,
> for instance older Intel consumer platforms only support 39-bits of
> IOMMU address space.  On such platforms, using the virtual address as
> the IOVA and mappings at the top of the address space both fail.
> 
> VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> respectively.  These provide compatible arrays of ranges from which
> we can construct a simple allocator and record the maximum supported
> IOVA address.
> 
> Use this new allocator in place of reusing the virtual address, and
> incorporate the maximum supported IOVA into the limit testing.  This
> latter change doesn't test quite the same absolute end-of-address space
> behavior but still seems to have some value.  Testing for overflow is
> skipped when a reduced address space is supported as the desired errno
> is not generated.
> 
> This series is based on Alex Williamson's "Incorporate IOVA range info"
> [1] along with feedback from the discussion in David Matlack's "Skip
> vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
> 
> Given David's plans to split IOMMU concerns from devices as described in
> [3], this series' home for `struct iova_allocator` and IOVA
> range helpers are likely to be short lived, since they reside in
> vfio_pci_device.c. I assume that the rework can move this functionality
> to a more appropriate location next to other IOMMU-focused code, once
> such a place exists.
> 
> [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/#t
> [2] https://lore.kernel.org/all/20251107222058.2009244-1-dmatlack@google.com/
> [3] https://lore.kernel.org/all/aRIoKJk0uwLD-yGr@google.com/
> 
> To: Alex Williamson <alex@shazbot.org>
> To: David Matlack <dmatlack@google.com>
> To: Shuah Khan <shuah@kernel.org>
> To: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: kvm@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alex Mastro <amastro@fb.com>
> 
> Changes in v2:
> - Fix various nits
> - calloc() where appropriate
> - Update overflow test to run regardless of iova range constraints
> - Change iova_allocator_init() to return an allocated struct
> - Unfold iova_allocator_alloc()
> - Fix iova allocator initial state bug
> - Update vfio_pci_driver_test to use iova allocator
> - Link to v1: https://lore.kernel.org/r/20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com

Minor comments, but otherwise LGTM and passes testing on a Kaby Lake
system with limited IOMMU address width.  Thanks,

Alex

