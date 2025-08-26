Return-Path: <linux-kselftest+bounces-40006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DB0B37407
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 22:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C6027C663D
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77C6253F12;
	Tue, 26 Aug 2025 20:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="drIAP/GK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3925E2AE8D;
	Tue, 26 Aug 2025 20:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241230; cv=none; b=e17Q+lMnQ9KYC8nhkb2C1skSLqDDYvlu2RJ7J61Jfl7WITH4hUuLhppwk3Y4HqLelkPDGXaZCJul4ku011wuRAKeLSMljdntVGIm0uns+h+DrSRhwjgozDz+unMSJmmhrjnXJ+j8uMdA+QavWbWf8n80G8IiyIcCv5dVCOWneKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241230; c=relaxed/simple;
	bh=i5YhQfiG/kxVzXvIr3BfqNM1nS7xEEp8AvpkqFuX6sE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=llQKM5H2bxn3n4CWMeAVoBOkybp/jAiRH+dnUfImH3I0t+65IOZOGRxveRcL4MCI+mXx+B5eovkPFuNkH2BrCqFRrjEdMc+xvm7Tmo9JA2HTWf2soExNvW1SsX75Q1PI5CP5iValZVDP0bD+WEFTHv1rVuyjcqgnzMJpX0PtjDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=drIAP/GK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=sT4ev/FdTzZETUvUN8PEvig3jztSVIJQJ9RfnYabzfY=; b=drIAP/GKbJZ0YgUU7Obiak6QbN
	wTob9zUqx/u0rk/OFNruOWUAXyC75cS9mVAyX5UTAz30Za16gI2OETdtppSmS5Musm1WmxtZ5rG+G
	GWwLGcePfk27Z668rSh2xON4afqpi1JLndDCx5Ij17X1XbjjiDvJCgri9M1VHyFJgBhc0BDwK5Qet
	fJrC67Jx75NACE++OCX/FPrNuG5IJR/QO3p/hrBRE63UhngsUrGwPnawNmhwntA9aHR/1faJW16V3
	OhbW0TuLSy7VavxdJUHAsUmnt1MjzJ+ap1F7ydzYyeYuuvkR+Uf36z57hc2B77ge5Bul4j5r437wp
	kcslENlw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur0ZQ-0000000D8Jw-1Drk;
	Tue, 26 Aug 2025 20:47:08 +0000
Message-ID: <5ffaaba9-9890-4198-9ea8-03edba6e0725@infradead.org>
Date: Tue, 26 Aug 2025 13:47:07 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/15] iommupt: Add read_and_clear_dirty op
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
References: <8-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <8-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> +/**
> + * read_and_clear_dirty() - Manipulate the HW set write dirty state
> + * @iommu_table: Table to manipulate
> + * @iova: IO virtual address to start
> + * @size: Length of the IOVA
> + * @flags: A bitmap of IOMMU_DIRTY_NO_CLEAR
> + *

Mismatch between @params above and function arguments, both in names
and one argument (@dirty:) is missing above.

> + * Iterate over all the entries in the mapped range and record their write dirty
> + * status in iommu_dirty_bitmap. If IOMMU_DIRTY_NO_CLEAR is not specified then
> + * the entries will be left dirty, otherwise they are returned to being not
> + * write dirty.
> + *
> + * Context: The caller must hold a read range lock that includes @iova.
> + *
> + * Returns: -ERRNO on failure, 0 on success.
> + */
> +int DOMAIN_NS(read_and_clear_dirty)(struct iommu_domain *domain,
> +				    unsigned long iova, size_t size,
> +				    unsigned long flags,
> +				    struct iommu_dirty_bitmap *dirty)
> +{


-- 
~Randy


