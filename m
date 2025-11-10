Return-Path: <linux-kselftest+bounces-45258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E03C49682
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EE86D4E406F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2093632D0C4;
	Mon, 10 Nov 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NNZUxSkp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC+hhKOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D02FE59A;
	Mon, 10 Nov 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810327; cv=none; b=L897Py4ADtM/PDYeHOUl/uTLZ3ifvhIhi4oM/YECcxx6b2Ow9SaVcC9yzIcojiVJBJaAn36GMjRfgyvEZ22g5G9C9ivemCf295DDRVX+k2qfAdZay/jhD6+sZwTdcGxnpfJdYQcRcTVhf7eXxYMJxvfRoSLkCpO8QqxOb3cFtTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810327; c=relaxed/simple;
	bh=udhFd8bnikNF4U1Q3cHYKYq3qZpVN84Y40g+EqnzB8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kA3vE8w/KywTv4FNzGCqapyVGfeN3jgZ3qS+BB1O38/tkb2+ROMdKiPttnQLlMhfndVTiu5Uau/wSyGLZelZLVO3fo93H6gY7ImxXvzUPCzNqvb8ABzwowMw7FXlikym1qf15TiGE7Jpw1qFm/XpcdMVDutHj7j67gYYR00FAs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NNZUxSkp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC+hhKOs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E9A1E1D000FA;
	Mon, 10 Nov 2025 16:32:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 10 Nov 2025 16:32:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762810322;
	 x=1762896722; bh=1E6u0oaZlVkxhpwKTBr/EX/G0FGOFEVQY7LANLUpoZs=; b=
	NNZUxSkp4vSHsvtawj3MmM5O7dy3qY9bntMq8OuTqO++p2fYhiOkdok+33VJqcS9
	cEvJGaGe8hTF71YdT3h/S692SSyzPIO4eIf+xdz3fzRV6YIdnQdtArcwTY9ABr6z
	Wh98Qe4aiK6/krnpBw0KDwwxmXCyBC5V0H2tpu6dEphRhIBuuqJUAcGmLBZ/MjWS
	4QJ0mHfPQjulprrbggohfqHikUlyEVaAutSQ18jsxFoxmcdqsOcWQ3/JN5jAhUz1
	dfouo4jRMymqEI6OnmZybqXLrBQEliAe4+pMzGWDODIP5e4UIRWyanKxq1gX3lNW
	WX5wGQgAt9gQYEBGkCOwiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810322; x=
	1762896722; bh=1E6u0oaZlVkxhpwKTBr/EX/G0FGOFEVQY7LANLUpoZs=; b=g
	C+hhKOs60Kxp+dFbsStjHPeHdZRye5P+azAqGWDe0JGJNhZNsFBxMlWtbRoCy1e+
	qt8UXzwGn2bYtz/R06vS5iY/7JmXq4IJfvEiwWkHNqKC4IWfJPz4eO/dEmo44c0J
	ONrRlC2W55/OjdzhYxtk08s9S0A+DaTnRDbrUrjdnHwSiEhPODm3TMytnm6/vDHx
	/x71mpdZhjuukxNQS8nW06lG40qMtllMBIWqBPx28Y+AE/2Mmn1aepm4DZRJokmY
	VtbDgTD2jGOCOYPvxdmDijul/wZBCj7UnDmkkSElRMGDxJoUPA6fm7jSnNpZ2DnJ
	EAOieCEq7fanyAF89/7Kg==
X-ME-Sender: <xms:0lkSaYMYKflndtOLT5UTxb7Mx7z3CS3TZ6zKOqMfVLj27LvmWes1Dw>
    <xme:0lkSaZCBlofumg-jurvHDXAIRX1Ou01o0s0YMhAmNp_2j3mHa2impIYOWSKVfAxEq
    S2NBaQZ1Pj3osoda4kNLmzR5xaC1uAmOYIKzhFU-yWeKVdyRwd0Fw>
X-ME-Received: <xmr:0lkSafLlFriDV9qwFzXBwyxGABnqEQNSAOQkWEKr70KZlPCS6S6_oV-K>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrmhgrshhtrhhosehfsgdrtghomhdprhgtphhtthhope
    gumhgrthhlrggtkhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhhvmhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepjhhgghesiihivghpvgdrtggr
X-ME-Proxy: <xmx:0lkSaSNP2Fk_ea79MSC3qO7cKQG5RsnV9twBB9KBEMIvDDsVbsPwjg>
    <xmx:0lkSad7hA3rvpA9XNWFrH0NUmLSTobmXjmolU19kRmLBBAG4TNFsZw>
    <xmx:0lkSaU69JaJC_ts2dKjVNfUaaygeLcACiYZGuiNIX-k51mE-nCiH1g>
    <xmx:0lkSabE8TEJshgzkWIBRxe8puvwbgbhcBnqYqSlAGW2baQ2vhG9LLA>
    <xmx:0lkSaTQiBjX4FnlosHQBX0GrYTfHIO580pnh2ytiFUOHuHsBsVD8yTgL>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 16:32:01 -0500 (EST)
Date: Mon, 10 Nov 2025 14:31:52 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 2/4] vfio: selftests: fix map limit tests to use last
 available iova
Message-ID: <20251110143152.5af498f4.alex@shazbot.org>
In-Reply-To: <20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
	<20251110-iova-ranges-v1-2-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:10:42 -0800
Alex Mastro <amastro@fb.com> wrote:

> Use the newly available vfio_pci_iova_ranges() to determine the last
> legal IOVA, and use this as the basis for vfio_dma_map_limit_test tests.
> 
> Fixes: de8d1f2fd5a5 ("vfio: selftests: add end of address space DMA map/unmap tests")
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  tools/testing/selftests/vfio/vfio_dma_mapping_test.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> index 4f1ea79a200c..37c2a342df8d 100644
> --- a/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> +++ b/tools/testing/selftests/vfio/vfio_dma_mapping_test.c
> @@ -3,6 +3,8 @@
>  #include <sys/mman.h>
>  #include <unistd.h>
>  
> +#include <uapi/linux/types.h>
> +#include <linux/iommufd.h>
>  #include <linux/limits.h>
>  #include <linux/mman.h>
>  #include <linux/sizes.h>
> @@ -219,7 +221,10 @@ FIXTURE_VARIANT_ADD_ALL_IOMMU_MODES();
>  FIXTURE_SETUP(vfio_dma_map_limit_test)
>  {
>  	struct vfio_dma_region *region = &self->region;
> +	struct iommu_iova_range *ranges;
>  	u64 region_size = getpagesize();
> +	iova_t last_iova;
> +	size_t nranges;
>  
>  	/*
>  	 * Over-allocate mmap by double the size to provide enough backing vaddr
> @@ -232,8 +237,13 @@ FIXTURE_SETUP(vfio_dma_map_limit_test)
>  			     MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>  	ASSERT_NE(region->vaddr, MAP_FAILED);
>  
> -	/* One page prior to the end of address space */
> -	region->iova = ~(iova_t)0 & ~(region_size - 1);
> +	ranges = vfio_pci_iova_ranges(self->device, &nranges);
> +	VFIO_ASSERT_NOT_NULL(ranges);
> +	last_iova = ranges[nranges - 1].last;


Building on the imposed requirement of ordered ranges.  Thanks,

Alex


> +	free(ranges);
> +
> +	/* One page prior to the last iova */
> +	region->iova = last_iova & ~(region_size - 1);
>  	region->size = region_size;
>  }
>  
> @@ -276,6 +286,9 @@ TEST_F(vfio_dma_map_limit_test, overflow)
>  	struct vfio_dma_region *region = &self->region;
>  	int rc;
>  
> +	if (region->iova != (~(iova_t)0 & ~(region->size - 1)))
> +		SKIP(return, "IOMMU address space insufficient for overflow test");
> +
>  	region->size = self->mmap_size;
>  
>  	rc = __vfio_pci_dma_map(self->device, region);
> 


