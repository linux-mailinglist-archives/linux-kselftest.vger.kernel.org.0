Return-Path: <linux-kselftest+bounces-40019-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAB4B375C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 02:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CC81B67385
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Aug 2025 00:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1C7DF59;
	Wed, 27 Aug 2025 00:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zU3fHBFx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054F84C6C;
	Wed, 27 Aug 2025 00:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756253023; cv=none; b=nKacrsRRQJTuh1lxHI2BnI59ve6wxiPk3S74liFHo1FR21SsOZAiK85tKQ8PYxK7mN74wQQYpGLPPt4aDm992t0JUf/8/zupg8XzmZYOGLLSdKNm67l8hGTYCCX4rRmi74Nbo2OnxzCAsAssPafokAUSoD2EFkVhGsgvhE9gc0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756253023; c=relaxed/simple;
	bh=I8oPMo3mvwS3Bjjxb0BZcps4wLguxYSEV5nbVXUhU/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rCQCu5+D45sg2bpAMBexYLsDtmvx08xHB7vCkquL0dfVTyxOmr6VzsVoUU54imNjtn6pAmukwvfHQDYKUg9dIdrLHmvDbwTPvMJdrbUGFl08txqWIQUfqwTtVlt2hjH1sf+exa6pyzpPDNCwa2RDwV7oTxchBiGqS9vta7Z2jHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zU3fHBFx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Uk4pOKm9w1DFf3d0P5bL4B0MQh3SUsa1t5AwYgg9Fyw=; b=zU3fHBFx6AEsYZv+UoxMnHxjLP
	hXnNntqpg8T2xkglr2er4K6A2mC3xfuHqDZE14q4wyRICdMYjK2lFezTyJ5PdpddodxgA1csOBd5J
	i3OdSG2JTwgB7BARHbe9+CkvesWVYrZ5JxJG+a8DKL70CB/zEdI4QQwRxauq5ffiCh9GMEQJOh9V9
	2QxlQS2AXBBSrdL8fzMPop1IyKgUIy9RH12JPkGsHTcJ2gMrL4eCT0pelksjD4TPOFoaGCngUqIvC
	yL7y9dPIpMSLle+mqDh9sccw3RvCdLXBfjzkQfBzjbYFpPBChibTWm5Vs1EvWjw6n/dJNURcQF9lh
	XdfeMZpA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ur3dc-0000000DOXO-1EJx;
	Wed, 27 Aug 2025 00:03:40 +0000
Message-ID: <cfeead98-4344-47e6-ac62-08eaa5f5b318@infradead.org>
Date: Tue, 26 Aug 2025 17:03:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] iommupt: Add the AMD IOMMU v1 page table format
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
References: <4-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 10:18 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index c35ddc7c827e92..1867e8d74b4be9 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -29,4 +29,16 @@ config IOMMU_PT
>  	  IOMMU_PT provides an implementation of the page table operations
>  	  related struct iommu_domain using GENERIC_PT to abstract the page
>  	  table format.
> +
> +if IOMMU_PT
> +config IOMMU_PT_AMDV1
> +	tristate "IOMMU page table for 64 bit AMD IOMMU v1"

	                               64-bit

> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	help
> +	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
> +	  "host" page table. It supports granular page sizes of almost every
> +	  power of 2 and decodes an full 64 bit IOVA space.

	                                 64-bit

> +
> +	  Selected automatically by an IOMMU driver that uses this format.
> +endif

-- 
~Randy


