Return-Path: <linux-kselftest+bounces-45259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D476CC49684
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 22:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F46B188BE44
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Nov 2025 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003A32ED20;
	Mon, 10 Nov 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="NPe51RGA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0I7YgvCP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2E2BFC73;
	Mon, 10 Nov 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810327; cv=none; b=VOg7Annqf29zkupQK/OQeZxPuZV35f2XneYlqvErtV8rg6G+w9vbA1FZOKdt5ovQ6IiVm3TaXMIvbYuUhjbg+Ai9mMCWDIYX18IMvQaihWUOvyzE/Evt5jHpL4kZ2HbjWtgkS+Fr55uehvC42Uk5YRlQ4S8vwgj3excKQa7IT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810327; c=relaxed/simple;
	bh=FiFzuN3td0ZW+I+77rN9OGFN9YFjAznR2RMkiWmt8VQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tAf8MWCpcBPqDMpIH+keRiLRBxFaepOCu6z5LN0DZRYGzSrkhXZmOYlrLO6ubhXVR7a5gkE2sMzXf3W2/xJBOzsSjYp33VSXrJM3FSZ06SCm34CH4sdEzMPSBLr/CLB+XVcYSgMa26pcQ+0L13XevFoU0V7ayafc3FE3M0IcU+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=NPe51RGA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0I7YgvCP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AD5497A00CC;
	Mon, 10 Nov 2025 16:32:04 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 10 Nov 2025 16:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762810324;
	 x=1762896724; bh=VHtnDqllUYwlSha0vfVZNUtiMI4Z2TOYXVyInyROHzY=; b=
	NPe51RGAeg7kIl2IWscHi7pT8Nbbuv6l2Dw5febmah4nUD9wgp/n4od+eVwCMwQh
	ragHG4zInloXgD6eZnKiCHXiTnI+UpUha5W9ylnEzzz0aDodAzTE5MDC70E90lfo
	6xA27s2ZACKrzU6AxVJVwPwnn3vZpUjH7twLyTaK5OQluibOA7Z4zZNJ/AbdA6GW
	/K7pooOBrDBF7NejoNjhPkx2lmWtDWxUHW9awvdXtA9Q6CA0T/NyJr5kzQa+Tgc8
	qh5kYV++5YsBqGPY+OBWgUa67uBEkB+YjTm5cCtqxe3UWXX1ryqNvGL6W3YtrErS
	YhbRDFP5tKiH6m6DGgkBCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762810324; x=
	1762896724; bh=VHtnDqllUYwlSha0vfVZNUtiMI4Z2TOYXVyInyROHzY=; b=0
	I7YgvCPrakAT3e7WW7P9ThlrIPW4tAydiRdcXSx6pOt9biWvMOwTwvU8ezGeXqga
	hPHRZD8P931TKRIXKov0asmZFHrOXg4zOF/0Y969AbZ+gobvFO5+EuDys9Lb/MS9
	CIzUntAUTECADHQ/Eb1SNcOO4J6T/PgeEDf9831Vyi2z430dtXyiLdFPFqt5v3p4
	VUP0zNitZGQzyxmZIJ2pwCAuQjOkD1v3sxRiykUGBMB/M2yJSHk3D/wKW/PN5Uf4
	eTb0QdmHDCtWVQ9GLhydnQqct3hwB4K70V8ZR0UOljEiWlUZxwzT/DwzPrG1EUhL
	AY6KJNhoBZUfi7iEDbMvQ==
X-ME-Sender: <xms:1FkSaQfnZS3Zzq1COs0wsjSOnF_rzhoNF9BEcc9eqLcL3b4RkdvdGw>
    <xme:1FkSacQHtUAHAloOSSrxwXdpvLn0oDC6isQAgEGPOEh6Fogwd2NlxdIuNCpntHO62
    cqWNKuQzkYZjhTFiIjBEzEnq3jwSsEipoFYZqUZuza4RwdJKBLo>
X-ME-Received: <xmr:1FkSaRbCmMYJCQ9Xf4qyqGsan4iYzdEn5SxfzSMWcPpmh8zmBKn8W7Qt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleelgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhephedvtdeuveejudffjeefudfhueefjedvtefgffdtieeiudfhjeejhffhfeeu
    vedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhgvgiesshhhrgiisghothdrohhrghdp
    nhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprghmrg
    hsthhrohesfhgsrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hkvhhmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhs
    vghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuh
    igqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjghhg
    seiiihgvphgvrdgtrg
X-ME-Proxy: <xmx:1FkSaXdiG1yxpuzAL15ndbFPqNpkqalZpZ45mv01GwQcU8UgmJiXKw>
    <xmx:1FkSaaKUYF0zQA5YUex-gKm2COYlzzjqW-3RlzjIBuzn7sPJO4aZmA>
    <xmx:1FkSacLy6X1fHfNW-fN43DwwmlJh-CkBj4FIi_WVs4bqvOv4yXaq9w>
    <xmx:1FkSaRU3zfv19b4rCIveaR4ZwA41hJF_ooUsNZ5Qy0Sy1Wn12CGUxg>
    <xmx:1FkSaWibPh5DLDyJZfoKMPFOchJYt-Q6EIQhR7yLBePeM3DskmRQwRU->
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 16:32:03 -0500 (EST)
Date: Mon, 10 Nov 2025 14:31:54 -0700
From: Alex Williamson <alex@shazbot.org>
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Shuah Khan <shuah@kernel.org>,
 <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 3/4] vfio: selftests: add iova allocator
Message-ID: <20251110143154.3ff4aa09.alex@shazbot.org>
In-Reply-To: <20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
References: <20251110-iova-ranges-v1-0-4d441cf5bf6d@fb.com>
	<20251110-iova-ranges-v1-3-4d441cf5bf6d@fb.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Nov 2025 13:10:43 -0800
Alex Mastro <amastro@fb.com> wrote:

> Add struct iova_allocator, which gives tests a convenient way to generate
> legally-accessible IOVAs to map.
> 
> This is based on Alex Williamson's patch series for adding an IOVA
> allocator [1].
> 
> [1] https://lore.kernel.org/all/20251108212954.26477-1-alex@shazbot.org/
> 
> Signed-off-by: Alex Mastro <amastro@fb.com>
> ---
>  .../testing/selftests/vfio/lib/include/vfio_util.h | 14 +++++
>  tools/testing/selftests/vfio/lib/vfio_pci_device.c | 65 +++++++++++++++++++++-
>  2 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vfio/lib/include/vfio_util.h b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> index fb5efec52316..bb1e7d39dfb9 100644
> --- a/tools/testing/selftests/vfio/lib/include/vfio_util.h
> +++ b/tools/testing/selftests/vfio/lib/include/vfio_util.h
> @@ -13,6 +13,8 @@
>  
>  #include "../../../kselftest.h"
>  
> +#define ALIGN(x, a)	(((x) + (a - 1)) & (~((a) - 1)))
> +
>  #define VFIO_LOG_AND_EXIT(...) do {		\
>  	fprintf(stderr, "  " __VA_ARGS__);	\
>  	fprintf(stderr, "\n");			\
> @@ -188,6 +190,13 @@ struct vfio_pci_device {
>  	struct vfio_pci_driver driver;
>  };
>  
> +struct iova_allocator {
> +	struct iommu_iova_range *ranges;
> +	size_t nranges;
> +	size_t range_idx;
> +	iova_t iova_next;
> +};
> +
>  /*
>   * Return the BDF string of the device that the test should use.
>   *
> @@ -212,6 +221,11 @@ void vfio_pci_device_reset(struct vfio_pci_device *device);
>  struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
>  					      size_t *nranges);
>  
> +int iova_allocator_init(struct vfio_pci_device *device,
> +			    struct iova_allocator *allocator);
> +void iova_allocator_deinit(struct iova_allocator *allocator);
> +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size);
> +
>  int __vfio_pci_dma_map(struct vfio_pci_device *device,
>  		       struct vfio_dma_region *region);
>  int __vfio_pci_dma_unmap(struct vfio_pci_device *device,
> diff --git a/tools/testing/selftests/vfio/lib/vfio_pci_device.c b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> index 6bedbe65f0a1..a634feb1d378 100644
> --- a/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> +++ b/tools/testing/selftests/vfio/lib/vfio_pci_device.c
> @@ -12,11 +12,12 @@
>  #include <sys/mman.h>
>  
>  #include <uapi/linux/types.h>
> +#include <linux/iommufd.h>
>  #include <linux/limits.h>
>  #include <linux/mman.h>
> +#include <linux/overflow.h>
>  #include <linux/types.h>
>  #include <linux/vfio.h>
> -#include <linux/iommufd.h>
>  
>  #include "../../../kselftest.h"
>  #include <vfio_util.h>
> @@ -190,6 +191,68 @@ struct iommu_iova_range *vfio_pci_iova_ranges(struct vfio_pci_device *device,
>  	return ranges;
>  }
>  
> +int iova_allocator_init(struct vfio_pci_device *device,
> +			struct iova_allocator *allocator)
> +{
> +	struct iommu_iova_range *ranges;
> +	size_t nranges;
> +
> +	memset(allocator, 0, sizeof(*allocator));
> +
> +	ranges = vfio_pci_iova_ranges(device, &nranges);
> +	if (!ranges)
> +		return -ENOENT;
> +
> +	*allocator = (struct iova_allocator){
> +		.ranges = ranges,
> +		.nranges = nranges,
> +		.range_idx = 0,
> +		.iova_next = 0,

iova_next needs to be initialized from ranges[0].start.  Thanks,

Alex

> +	};
> +
> +	return 0;
> +}
> +
> +void iova_allocator_deinit(struct iova_allocator *allocator)
> +{
> +	free(allocator->ranges);
> +}
> +
> +iova_t iova_allocator_alloc(struct iova_allocator *allocator, size_t size)
> +{
> +	int idx = allocator->range_idx;
> +	struct iommu_iova_range *range = &allocator->ranges[idx];
> +
> +	VFIO_ASSERT_LT(idx, allocator->nranges, "IOVA allocator out of space\n");
> +	VFIO_ASSERT_GT(size, 0, "Invalid size arg, zero\n");
> +	VFIO_ASSERT_EQ(size & (size - 1), 0, "Invalid size arg, non-power-of-2\n");
> +
> +	for (;;) {
> +		iova_t iova, last;
> +
> +		iova = ALIGN(allocator->iova_next, size);
> +
> +		if (iova < allocator->iova_next || iova > range->last ||
> +		    check_add_overflow(iova, size - 1, &last) ||
> +		    last > range->last) {
> +			allocator->range_idx = ++idx;
> +			VFIO_ASSERT_LT(idx, allocator->nranges,
> +				       "Out of ranges for allocation\n");
> +			allocator->iova_next = (++range)->start;
> +			continue;
> +		}
> +
> +		if (check_add_overflow(last, (iova_t)1, &allocator->iova_next) ||
> +		    allocator->iova_next > range->last) {
> +			allocator->range_idx = ++idx;
> +			if (idx < allocator->nranges)
> +				allocator->iova_next = (++range)->start;
> +		}
> +
> +		return iova;
> +	}
> +}
> +
>  iova_t __to_iova(struct vfio_pci_device *device, void *vaddr)
>  {
>  	struct vfio_dma_region *region;
> 


