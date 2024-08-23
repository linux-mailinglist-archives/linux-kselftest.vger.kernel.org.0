Return-Path: <linux-kselftest+bounces-16164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DAA95D311
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 18:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4AC1C2387E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Aug 2024 16:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4882E18BBB3;
	Fri, 23 Aug 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl4Ccear"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAF18B48B;
	Fri, 23 Aug 2024 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724429927; cv=none; b=nCAZTRDYSlrz+OEiz+IPO6GsvHcgCXJhrL30Eixuh8/53HZPN/pK2ASoSagL6FodO5wRSL5c/0AiLqv43uZS0ncpFKsMYRkGcvuNpb0OUK9ARwE3LPX8OwM5PngEBBVuu1XOMITNwGD8hrPbo02jP5R+Mvvbxx6K4/8TVsB1hvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724429927; c=relaxed/simple;
	bh=V7w6aGTup4dZWLJ3lbkIBCj/3TjsCtqRiayesmQ4l9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IxQvWl+bHPTmNoIwYynyXDxkv49RbQZOijC/gjBELi346zqXKKNFsyYc16uFw8MfyMglPBz4dNCGg4LxVaPek2FQge0aBT7eZ4bsvnd1SuU4dAaXCEqKUGhGhHzqM6n2d/LAujg9/LtogGSqGZ7sKRi1kuAE/P2tePM6YM1ko58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl4Ccear; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3579C32786;
	Fri, 23 Aug 2024 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724429926;
	bh=V7w6aGTup4dZWLJ3lbkIBCj/3TjsCtqRiayesmQ4l9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hl4CcearRTaFkPghMd1rFPfpULG941By0O8p+4GbLxtwSgRZju5BERuyx7kUKUIwE
	 RCnTGkOJX3UOPMBlRjlUw+hSgL809L/ZmqWHs4Ht8JPskNBE+Tecg7UDTawg4w6gT3
	 p24apZM9ndAGKQA6dTed7iO82mq5Def0LjCAExXd1WQcv8kRfs6St4A05HgXfjI1KD
	 XjpRZdVaZDM2Ba+C8kRc4dmGKtikWqdYa4JBCP1WxBKyxUDfkWE9M3NvSx2bL+bn7z
	 SVpzakj6Xrn7dJypEOFkC7WBgFibHO14/6U0QOUHUmJjy2aPG9+4cUcJx6jJSFi88s
	 Dt6GeRk7EZPLQ==
Date: Fri, 23 Aug 2024 17:18:39 +0100
From: Will Deacon <will@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Janne Grunau <j@jannau.net>,
	Joerg Roedel <jroedel@suse.de>, Kevin Tian <kevin.tian@intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Lixiao Yang <lixiao.yang@intel.com>,
	Hector Martin <marcan@marcan.st>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Sven Peter <sven@svenpeter.dev>, Will Deacon <will.deacon@arm.com>,
	Yi Liu <yi.l.liu@intel.com>, Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH rc 2/2] iommu: Do not return 0 from map_pages if it
 doesn't do anything
Message-ID: <20240823161839.GC851@willie-the-truck>
References: <0-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
 <2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v1-1211e1294c27+4b1-iommu_no_prot_jgg@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Aug 22, 2024 at 11:45:55AM -0300, Jason Gunthorpe wrote:
> These three implementations of map_pages() all succeed if a mapping is
> requested with no read or write. Since they return back to __iommu_map()
> leaving the mapped output as 0 it triggers an infinite loop. Therefore
> nothing is using no-access protection bits.
> 
> Further, VFIO and iommufd rely on iommu_iova_to_phys() to get back PFNs
> stored by map, if iommu_map() succeeds but iommu_iova_to_phys() fails that
> will create serious bugs.
> 
> Thus remove this never used "nothing to do" concept and just fail map
> immediately.
> 
> Fixes: e5fc9753b1a8 ("iommu/io-pgtable: Add ARMv7 short descriptor support")
> Fixes: e1d3c0fd701d ("iommu: add ARM LPAE page table allocator")
> Fixes: 745ef1092bcf ("iommu/io-pgtable: Move Apple DART support to its own file")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/io-pgtable-arm-v7s.c | 3 +--
>  drivers/iommu/io-pgtable-arm.c     | 3 +--
>  drivers/iommu/io-pgtable-dart.c    | 3 +--
>  3 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 75f244a3e12df6..06ffc683b28fee 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -552,9 +552,8 @@ static int arm_v7s_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  		    paddr >= (1ULL << data->iop.cfg.oas)))
>  		return -ERANGE;
>  
> -	/* If no access, then nothing to do */
>  	if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> +		return -EINVAL;
>  
>  	while (pgcount--) {
>  		ret = __arm_v7s_map(data, iova, paddr, pgsize, prot, 1, data->pgd,
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5d9fd1f45bf49..ff4149ae1751d4 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -515,9 +515,8 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  	if (WARN_ON(iaext || paddr >> cfg->oas))
>  		return -ERANGE;
>  
> -	/* If no access, then nothing to do */
>  	if (!(iommu_prot & (IOMMU_READ | IOMMU_WRITE)))
> -		return 0;
> +		return -EINVAL;

I think just removing this hunk altogether would get us the right semantics
for stage-2 mappings, but it's esoteric and not used so -EINVAL is probably
better:

Acked-by: Will Deacon <will@kernel.org>

Will

