Return-Path: <linux-kselftest+bounces-45334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFA5C4F315
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D98C734B6ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0D4393DD1;
	Tue, 11 Nov 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="hD8YEHr8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flW8iM92"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41389377EB2;
	Tue, 11 Nov 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880984; cv=none; b=iXBf2YUFj/mKW5kVVSnXZr96qjJdhXT7R1o/eCY4rOFhJJbOWR3kA2gDdsRgLz3+zEDVnuFedCijG2/Dni9OgdETA61gcqxl1BLdWeEY0xG+y6PEsvQ84NCg0Gox/tQ/paDuAxWgfvxsB/YNtbGHOdm7pcrw1Gpq0BGiOhT98yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880984; c=relaxed/simple;
	bh=60vl0iDgrCdfu+aHUjEEbOXEEqKsUbq7uIzx1ZL58HU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRT3+8hxzk6H3pOYDbD4tz9CWBsOf6ThWADvfndjdhgmN4qrixJ7ldxLROsrABErF09hgFdOB6svKLBYefcI+MLXeDhOVYltRET5W5s4WCfWGaXSkalTsn5w6G6oQdFO7q/BiMJQrTyJHBI0ryfcyF0JhFn1BIYKTtQwCinA1a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=hD8YEHr8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flW8iM92; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 25AD2140024F;
	Tue, 11 Nov 2025 12:09:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 11 Nov 2025 12:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762880981;
	 x=1762967381; bh=oelfZn+6Mq6PqWbH7TshwX1xtNUg/MbLDOSurZvE/ck=; b=
	hD8YEHr8IfMwWDNsbohU+LwnlTv+LbzOw8lNRwxSipLfPTJwU0H7ANo/xgRxZ2in
	axqXky0Au4VWe0No4JTqbamgeAiHLBOGhS3HcsFYRa1B47+AunHGPI/ZJxDIrGAH
	CPzw+CjPzzD0px7DySprdQUJMCweQj0QNzTbnSoal1ZbY0TGSKgBylYrsYZWanho
	XkXhP9V/XZCa0V3pDqmtZX5BplA1mUW+nXF8vBDYSZps+o6awSE+8yh3MmLSVsUw
	qmfj1AUlPxdhY6vPi4X3iwCFmq4PLF1QJlTiPgCc5ERpivxGXyokpfhyTnjPem0G
	Hg0Yv40oZY1NOlf3jhpBng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762880981; x=
	1762967381; bh=oelfZn+6Mq6PqWbH7TshwX1xtNUg/MbLDOSurZvE/ck=; b=f
	lW8iM92UvL0SU+6a5HdLBbOCidhNhk45dt2oLYTYxDFdkK276Wz68tFFTMSyM7lH
	pexoqHP+k5Mj/hEhBqvM6wZjWEhIHukN1iojYQs4j8C9p+j6GasvYMIKqPyRcsre
	24SWZ3Fc1JmPLLTJxRmihqefGvZglj9ZQbhYIz1Bn2kpSRTBtdjMKHDgUQYhxBKn
	pE65srjhfAW2oYKzOurgC/zD4ZGlfIA/UXqFbMB4ZiiEVl+xkwlKr1gLNAnEJfC4
	U/4Tg3OUzI0WZl3XZXXEmrp6gtHen6aNiGXUsVmGvuAXY1KqacvhZatsMpHs2ye1
	wWyX6x0afzQFUiNkqwGkQ==
X-ME-Sender: <xms:1G0TafyIFmXDplB7mI_cOne8FJSwE2-wrZL4SeLPK7t-Bvs81E_3Yg>
    <xme:1G0TaRUbSGxa2FHJVrQDWnHskj1mGx_bTHcAx0Gn4ZoZjxbRS-cXXOk8bn91g-XyV
    fO29foVizcSqDS0MuHKXrfrLdXbc6Rnw5m22j6UtgV4DWsuG2ac>
X-ME-Received: <xmr:1G0TaZPBPoQ6us26UQTsAbTNu6DQ0wtf0msI2eGX0H0g30JNAXFN9WJC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtddujeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
    gumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggrpdhrtghpthhtoh
    epkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhk
    shgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1G0TabB4jyyh1N--Gt3dN5mQlrIYGuptGVrQUo92dPM-n7y8UYBx7g>
    <xmx:1G0TaedAUVVHFWlv48PNvKM3il7CNXneFXlxfj5SLnJjU_mGcdc3RQ>
    <xmx:1G0TaSNKxe9FXh9WgHHy6QoMC2uiiOd0Y71KPqJbkTfwXIIoHlbLYA>
    <xmx:1G0TaWKRHjLUjMaL2OE7zPN07rSPauK-L_Q7kC1mAezTinCyfb7Jnw>
    <xmx:1W0TaXk6LT6NEp3lVc-sSyFsy5xSXwnjppetkHpJ8W_88fnlRVLWslPD>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 12:09:39 -0500 (EST)
Date: Tue, 11 Nov 2025 10:09:37 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, <kvm@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] vfio: selftests: replace iova=vaddr with
 allocated iovas
Message-ID: <20251111100937.4706a54e.alex@shazbot.org>
In-Reply-To: <20251111-iova-ranges-v2-4-0fa267ff9b78@fb.com>
References: <20251111-iova-ranges-v2-0-0fa267ff9b78@fb.com>
	<20251111-iova-ranges-v2-4-0fa267ff9b78@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 06:52:05 -0800
Alex Mastro <amastro@fb.com> wrote:

> vfio_dma_mapping_test and vfio_pci_driver_test currently use iova=vaddr
> as part of DMA mapping operations. The assumption that these IOVAs
> are legal has held up on all the hardware we've tested so far, but is
> not guaranteed. Make the tests more robust by using iova_allocator to
> vend IOVAs, which queries legally accessible IOVAs from the underlying
> IOMMUFD or VFIO container.

I've reported hardware that it doesn't work on, QEMU emulates such
hardware.  The commit message suggests this is more of a theoretical
problem.  Thanks,

Alex

