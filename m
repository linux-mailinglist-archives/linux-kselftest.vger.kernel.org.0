Return-Path: <linux-kselftest+bounces-40005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7422B373F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 22:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF3FE1BA499F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 20:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6822F60D6;
	Tue, 26 Aug 2025 20:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZCcsEOlv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D23430CD81;
	Tue, 26 Aug 2025 20:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241054; cv=none; b=IG0yvZ/9EIA+AVf7aoNkf3GweY9gbL+ZPRQb5L8tZuo1KBxuZ2F7YRTM3cVD94xz1biXdRsTGHlOmdXY19VPIFCshN/sr89DBnlgBMWPDFtLTjiHjiFSm4QqWnBeY52xeOM2gEJ4vmTVYS76ZSoCzjpH9SVPcbt/sVAIHCQv87k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241054; c=relaxed/simple;
	bh=tUr7YfLfSkqF792HrLXXg5iorzazaISzXMuWcLvRst4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=helyNYIV4mZR/1qvoHWVmuOXrp2zpzMeTsgjBRDdlq7Q95sH5BVQ0nOe1kCp/gb1sr6mRpn1wO6HBk4xPcG/RZcv4icdyh+mt8JWKQNk7/usfOhr+zpsj5mEueD0BtRpAnsTAn7HhauRI7PPGtolW/BfTnxSz+h1XO+ZNp2QyeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZCcsEOlv; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=FZ9HxEh5E9NV2SJ1puHz/9cexjmxNy2BECtL3MgCeZU=; b=ZCcsEOlvAE4CLFp53XDu9sS1C6
	o7i1zwbptCwec2mIgwF0BIGijWYVJ1cgQYBWQTkMR6dbIBcAHjROJGWDAeceYuwfpgsre73f/7PyE
	+51ugBjxifh6wPxJrKoB61gcn1JRWMaSAO++RE8mNF3wWr0zQUdpIJjecA7wmDzNU4Cm39GD22CHd
	6R0klrvMltr+R2yNLy3hTAeeQUJFuFjGxU2acUfbX+rawMObg4hKQVtMFL1R7kw0PCV6Bjw1FrOMv
	16w/qaehyh+t90paPezWQZUmTdLjRszHIOZ6Rm8fdMd5OIaCjjKkPvNRP33sYGrdJ9H2YT2mIoYyS
	wtKEpkkA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur0WY-0000000D7u0-3Acj;
	Tue, 26 Aug 2025 20:44:10 +0000
Message-ID: <d1150889-e693-4f37-896e-54a871cf4863@infradead.org>
Date: Tue, 26 Aug 2025 13:44:09 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] iommupt: Add unmap_pages op
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <6-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <6-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 155 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  10 +-
>  2 files changed, 163 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/generic_pt/iommu_pt.h b/drivers/iommu/generic_pt/iommu_pt.h
> index 9413f868a65bfa..53901a4a977935 100644
> --- a/drivers/iommu/generic_pt/iommu_pt.h
> +++ b/drivers/iommu/generic_pt/iommu_pt.h
> @@ -14,6 +14,29 @@
>  #include <linux/iommu.h>
>  #include "../iommu-pages.h"
>  #include <linux/export.h>
> +#include <linux/cleanup.h>
> +#include <linux/dma-mapping.h>
> +
> +static void gather_range_pages(struct iommu_iotlb_gather *iotlb_gather,
> +			       struct pt_iommu *iommu_table, pt_vaddr_t iova,
> +			       pt_vaddr_t len,
> +			       struct iommu_pages_list *free_list)
> +{
> +	struct pt_common *common = common_from_iommu(iommu_table);
> +
> +	if (pt_feature(common, PT_FEAT_FLUSH_RANGE_NO_GAPS) &&
> +	    iommu_iotlb_gather_is_disjoint(iotlb_gather, iova, len)) {
> +		iommu_iotlb_sync(&iommu_table->domain, iotlb_gather);
> +		/*
> +		 * Note that the sync frees the gather's free list, so we must
> +		 * not have any pages on that list that are covered by iova/len
> +		 */
> +	} else if (pt_feature(common, PT_FEAT_FLUSH_RANGE)) {
> +		iommu_iotlb_gather_add_range(iotlb_gather, iova, len);
> +	}
> +
> +	iommu_pages_list_splice(free_list, &iotlb_gather->freelist);
> +}
>  
>  #define DOMAIN_NS(op) CONCATENATE(CONCATENATE(pt_iommu_, PTPFX), op)
>  
> @@ -167,6 +190,138 @@ static inline struct pt_table_p *table_alloc_top(struct pt_common *common,
>  		log2_to_int(pt_top_memsize_lg2(common, top_of_table)));
>  }
>  

[snip]

> +
> +/**
> + * unmap_pages() - Make a range of IOVA empty/not present
> + * @iommu_table: Table to manipulate
> + * @iova: IO virtual address to start
> + * @pgsize: Length of each page
> + * @pgcount: Length of the range in pgsize units starting from @iova
> + * @gather: Gather struct that must be flushed on return

Eh, 2 of these @params don't match the function's arguments (names).

> + *
> + * unmap_pages() will remove a translation created by map_pages(). It cannot
> + * subdivide a mapping created by map_pages(), so it should be called with IOVA
> + * ranges that match those passed to map_pages(). The IOVA range can aggregate
> + * contiguous map_pages() calls so long as no individual range is split.
> + *
> + * Context: The caller must hold a write range lock that includes
> + * the whole range.
> + *
> + * Returns: Number of bytes of VA unmapped. iova + res will be the point
> + * unmapping stopped.
> + */
> +size_t DOMAIN_NS(unmap_pages)(struct iommu_domain *domain, unsigned long iova,
> +			      size_t pgsize, size_t pgcount,
> +			      struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	struct pt_iommu *iommu_table =
> +		container_of(domain, struct pt_iommu, domain);
> +	struct pt_unmap_args unmap = { .free_list = IOMMU_PAGES_LIST_INIT(
> +					       unmap.free_list) };
> +	pt_vaddr_t len = pgsize * pgcount;
> +	struct pt_range range;
> +	int ret;
> +
> +	ret = make_range(common_from_iommu(iommu_table), &range, iova, len);
> +	if (ret)
> +		return 0;
> +
> +	pt_walk_range(&range, __unmap_range, &unmap);
> +
> +	gather_range_pages(iotlb_gather, iommu_table, iova, len,
> +			   &unmap.free_list);
> +
> +	return unmap.unmapped;
> +}
> +EXPORT_SYMBOL_NS_GPL(DOMAIN_NS(unmap_pages), "GENERIC_PT_IOMMU");
-- 
~Randy


