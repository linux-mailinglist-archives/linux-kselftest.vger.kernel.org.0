Return-Path: <linux-kselftest+bounces-45423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC855C535FD
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F037A56698B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE803161B3;
	Wed, 12 Nov 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="K7oK3++D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKiWXRvT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8442C1593;
	Wed, 12 Nov 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961413; cv=none; b=QksUi8G4sNjoofFhL2M/FzQV1LJ1JkzT1fbywhKXoRwbhyzd5ceZ4mKjqUI2XsKXZNM7ZZqh/VHGEL4AL9yS8NmLCRu57H2GNu4YmDmNyHwef/YkxoSDrexCgeNx1kF/d5uhxAcSgWNsnpNCLwZDYRuOb9DYxYCXNb7ZhjH06Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961413; c=relaxed/simple;
	bh=001wyCEKrO3mqSIGETLIkf6QND/1jgkqpT40N1/GwCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaIhvJby/VcUwHl6dN19tNiuw4vOK0+MwTiRVdlQMBoBVXcqd1LZfJe8Keltm488f9rdT7FYieGZng6LAowP7IlGR9M9NdV2VwOzQ24oahUL2h/m3HsVw3/i3Vn2JdMqoM9Jw+RqWVXYQwXvKkFaBCK2OAWQCWsBhURp1tDt8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=K7oK3++D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kKiWXRvT; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 7391C1300CAD;
	Wed, 12 Nov 2025 10:30:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 12 Nov 2025 10:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762961408;
	 x=1762968608; bh=uArHWjw+8HGdLtfQCvoLqxfM9tZpffpVJb80hFO/JPY=; b=
	K7oK3++Diz89tOqK4vLR34LtpL4guiH4VYfUr2+FOAlIXPpXTu52xGjdCMr7+t+U
	MjiMotHHCBsFTLiMcqOQ9axpjzdodCxKkUWvzggFDy+/89yZQ89V/1wLg3GqHOIr
	+Jl30tNJ/8f/QjG4nrk2qfE42bimaAzGqOFdbc2FOUNzHuyrqb9o2Tva+vLSbjeB
	GJcmaK4fEoj7X63vBQoeO//hXZheR9nWToGm6BQRjvK3m76KTqGML6Bd0U50VaN+
	eRY3RjYcoHE08XPl1TWM8cSeN3AruR+k/1NnMpqlaWGG4Su8jn7ZP3pqrwYbev5L
	7Mjz0hvxpfOYCegPSYOY1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762961408; x=
	1762968608; bh=uArHWjw+8HGdLtfQCvoLqxfM9tZpffpVJb80hFO/JPY=; b=k
	KiWXRvTXj4iBFjd5BF+dLoJdwhsiiifYfF9IHuIzMZ889HrKN0swoL9BhCHsjCJ3
	35l2Hy/MoSMrgGVJjNd1h7OrZBMMPXcupz7iA0rFBnrfYpuC9ntI6z6WUA5h7FIj
	BU2vAcYGZhwmkhevyU0cd9L59bdTHs0oCnqB1knBOmmCKTjREjoR+r8bYx+W76od
	wNxnVArchTkgkhuIVYYwQP9iauH6ikxAq1N07qG4eGtSa1fEaqhwt0I1uEMbsUUl
	vJH0GwGC9ZHLs2ZFJ1CkiNEhgSpqd6NqzK9oC5Lq2B4tr5GkEReOmxLQf+OE3aAy
	cRAevJwc+kw0G64Agk8SQ==
X-ME-Sender: <xms:_6cUaSWYGo_-gHTbAw8mGrukwNYtHyVRVZ5xhQclMkJdk3YXSU0u1A>
    <xme:_6cUaYplbX1atmIhLxyVP-uOv4Jd-pY9661ZK9Djaq-M_vYjzAfUwP6weErWEN0SY
    aTFeI_D60UHNfXqrVnCOfZo1uxmdajjG-TciH36gF3kBUd3OLbA>
X-ME-Received: <xmr:_6cUaWST4GsfR4lCo6DjP8CUeYiMVLJrIVrDOGqzK7Tb7p1TyTmy37rb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeggeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:_6cUaa2Uo9m4B140EgKN0QSmdo1sM7m4pFAbPsmqhUyTjxx4fZ9n6Q>
    <xmx:_6cUaaB5QksbqJfc8OMTw2VYkHX75peXOe1C73ZYYZO_wkdwJXR1MQ>
    <xmx:_6cUaeim_BiZZLF29jHdpni83Fj1yloWMIPwDMyKUdE_dUpHCB8reA>
    <xmx:_6cUaUMPptfUksNmez_0H1PHfG1pFpCvK4nZOGZUdCBDgByJ3BIoOg>
    <xmx:AKgUaRlJBH8Emgdm1l8wsI3hfP68KV44G-IiKaYLpIuoOZhRV6Jwo7Dl>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 10:30:07 -0500 (EST)
Date: Wed, 12 Nov 2025 08:30:05 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
 queried IOVA ranges
Message-ID: <20251112083005.542e0b7f.alex@shazbot.org>
In-Reply-To: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
References: <20251111-iova-ranges-v3-0-7960244642c5@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 10:48:23 -0800
Alex Mastro <amastro@fb.com> wrote:

> Not all IOMMUs support the same virtual address width as the processor,
> for instance older Intel consumer platforms only support 39-bits of
> IOMMU address space. On such platforms, using the virtual address as the
> IOVA and mappings at the top of the address space both fail.
> 
> VFIO and IOMMUFD have facilities for retrieving valid IOVA ranges,
> VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE and IOMMU_IOAS_IOVA_RANGES,
> respectively. These provide compatible arrays of ranges from which we
> can construct a simple allocator.
> 
> Use this new allocator in place of reusing the virtual address, and
> incorporate the maximum supported IOVA into the limit testing.  This
> latter change doesn't test quite the same absolute end-of-address space
> behavior but still seems to have some value.
> 
> This series is based on Alex Williamson's "Incorporate IOVA range info"
> [1] along with feedback from the discussion in David Matlack's "Skip
> vfio_dma_map_limit_test if mapping returns -EINVAL" [2].
> 
> Given David's plans to split IOMMU concerns from devices as described
> in [3], this series' home for `struct iova_allocator` and IOVA
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
> Changes in v3:
> - Update capability chain cycle detection
> - Clarify the iova=vaddr commit message
> - Link to v2: https://lore.kernel.org/r/20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com

Applied to vfio for-linus branch for v6.18.  Thanks for the quick
resolution on this!

Alex

