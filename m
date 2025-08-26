Return-Path: <linux-kselftest+bounces-40016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C42B3759C
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 01:38:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192E23A690C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 23:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF763090F4;
	Tue, 26 Aug 2025 23:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFLiktwH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2B5301004;
	Tue, 26 Aug 2025 23:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756251525; cv=none; b=MY5fbvdKwtZGqwEMj0sYo3kXHswZ4uHlKsuXnC8sqR5aowBNrQmr9lGoVUzVhFpk8bwAzTGfzGxiqmYhyPkuAKCRm5YThP6KSWoK+w1s1J/KC8FzK2lAPBcOZoyeydBbIW8HmvPFOXB31mF1PgFp4IZGSp2MSrzHYs8jCe4stS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756251525; c=relaxed/simple;
	bh=8UR3B0CuSxPS348YqJdjWzCjeKMvHvYhVYO+yfZsIJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb6F3n41ntRU+jVX7MMllZNTX+MtxWRus+CJCjD4E0xslc7Af+PBOxFOHR3ITuEE3gdkfkH0iaEC+FUSJnBAkymoP2wVf5RS9/7ZJNsqR3cqOoNFuVMV0SBwRTgujD0i6b9wqEBlaEg4KawSJJc1k2ez0SMFEyMxucKTQ8SP4GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EFLiktwH; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=F3WrV83lywZCsqisVifMLjYiGEt1ohM+PRdmLgso4ig=; b=EFLiktwHQtoOiXlrcWx5gUkr+L
	AqEN4m1ZGNClo5E99GpTTwCv8XU7tSqBRAdueD5W1zSevun/jL4mr9vzeXTqeupeX5Wlk7VpyoytD
	YpaS5sZeTN9cN+nBpN2kg3iNXtCAujnfEA4MlRTRuOJpxlTYpXB+AeTcevPYvvEM50vUt8Uti25/N
	AfDico4izN/nIIrUokNvhPozmQlUpWTMttybMo2jb5YnpUqS41I+ZvyoPzwKh4nRNKcRjqVbwOH79
	nV/jLnEFAOYxpPN/YHfijJBTIInSC8456Y/KoIckN5Tg4ydZyL6883uYQ8MZKJYbJdfawlCZBSMlW
	52L7B2Fg==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur3FS-0000000DMbt-3ewP;
	Tue, 26 Aug 2025 23:38:42 +0000
Message-ID: <adf12245-08c2-4a14-bac9-2cf7a1bf8107@infradead.org>
Date: Tue, 26 Aug 2025 16:38:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] iommupt: Add the x86 64 bit page table format
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
References: <12-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <12-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index 57dc81060f9f0d..8665a1d4299b7a 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -41,10 +41,21 @@ config IOMMU_PT_AMDV1
>  
>  	  Selected automatically by an IOMMU driver that uses this format.
>  
> +config IOMMU_PT_X86_64
> +       tristate "IOMMU page table for x86 64 bit, 4/5 levels"

	                                     64-bit,
and use tab to indent, not spaces.

> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	help
> +	  iommu_domain implementation for the x86 64 bit 4/5 level page table.

	                                          64-bit

> +	  It supports 4K/2M/1G page sizes and can decode a sign extended

	                                                   sign-extended

> +	  portion of the 64 bit IOVA space.

	                 64-bit

> +
> +	  Selected automatically by an IOMMU driver that uses this format.
> +

-- 
~Randy


