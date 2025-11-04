Return-Path: <linux-kselftest+bounces-44748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB76FC32B4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 19:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546EF18C4B7E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 18:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9001E3376BC;
	Tue,  4 Nov 2025 18:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ko6RLb8y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097E2CCC5;
	Tue,  4 Nov 2025 18:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762282323; cv=none; b=Rx9BdgJYJIgLWSmwiks8XGoH77XwsJtbY3GVtIot2tj+0hqwzeM+jaK45FysQHSt+MkhqXuu/y5vAsZZHEbgI75XF69jJB305QZCHVfluherNdJiuiNuG5Zcgu5AMFVwv3b2WIw2OekMcGu/IoiMGxuQ0Nw5CPEwUXKGo9WD7ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762282323; c=relaxed/simple;
	bh=1xsDy3CZq77wu986Dc+b1hJamxaey3FGk7jDXCOigiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SoaEKx8HuOlx5yohANG2dpRKNO9k6WlJEMEnIjeDj2Msnf1onTfLAyeUIkJIJA5srufjc6RyhbweiZGuBGEShyvicxuVTrxgk2ZF/Hnc1WnhyXKKZ0w66gjW8peYgSmP2YG8ybHKgVdWe2enusQHz80FVMEAkvKK8f67KOdUO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ko6RLb8y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=oanjx6/hmAejRWiag/zsJfndQQOFRDEkA/Am+kiuH5U=; b=ko6RLb8yuC0crboN+f0heVHvjU
	1Ox/MQF9cdRt+gEPF2fox/XF1iFhZSEGfCqVH2aHqSMQ6p92Jyp0vQhF0BjPXnYFWVb2ahKW/jNDA
	RIK739Re0WfIFDwEXwoZ9/lZJZTF57B2klVasJp9Pn4N+w/9niDJH3/BuP102k/9g4qjSSF7DvRm6
	ADLue6FvfeSL0JR/3XfeB2vGu4XjvMuJzSIb0dbuqpK9GVQVgOxK6xuTsOSQ4u6G+eDw4GK17LP5O
	zcn6hIfH5owYbOC8TrhFcuuQnDbhnpxDD3yXJofiqvGNAq7wRfI5rXfxG8G/180r3C+J9pPEwT1xt
	FNHfUqsg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGM8L-0000000CRWY-1kO9;
	Tue, 04 Nov 2025 18:51:57 +0000
Message-ID: <7112b077-d19d-4b85-b2e0-8700dd2951e9@infradead.org>
Date: Tue, 4 Nov 2025 10:51:56 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] iommupt: Add the AMD IOMMU v1 page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
 Samiullah Khawaja <skhawaja@google.com>, Vasant Hegde <vasant.hegde@amd.com>
References: <4-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4-v8-d50aeee4481d+55efb-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:30 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index a81dfdd72ca016..cbdad222923b26 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -30,4 +30,16 @@ config IOMMU_PT
>  	  related to struct iommu_domain using GENERIC_PT. It provides a single
>  	  implementation of the page table operations that can be shared by
>  	  multiple drivers.
> +
> +if IOMMU_PT
> +config IOMMU_PT_AMDV1
> +	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	help
> +	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
> +	  "host" page table. It supports granular page sizes of almost every
> +	  power of 2 and decodes an full 64-bit IOVA space.

	                         a full
or

	                         the full

> +
> +	  Selected automatically by an IOMMU driver that uses this format.
> +endif


-- 
~Randy


