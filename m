Return-Path: <linux-kselftest+bounces-40338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF84B3C2FE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 21:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5338CA2708A
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 19:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34161238D54;
	Fri, 29 Aug 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AW24KjK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F78219D093;
	Fri, 29 Aug 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495553; cv=none; b=WGaOMhYP5iDwV4SRRJAQ9YMPCK6jhWz4M/Rq/xQ9Y67tFMLBsYCTU9X+5AmVeu4f2R8HV2pIZrprqXW55DPjEnPY4sgvdziQwr/oOhWYIR3wu7/ARmDvB+cUAFMsKRtaLkSQ5/eB6v+YN37hNx/2cdqA9wVfJT87OrD0Z8WCpwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495553; c=relaxed/simple;
	bh=a9mSVQZmlCnYOlXRN9hu74V5HM43dzS1XETewOLSHvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O0X8IOPMwqRkQWIcpna4QntOhdYmGjJ+O+avQDSdyKR5TOM8Zz2wHcqLFrvA6i04ShQ/8oJPhMJybA3qkOZ2EFEHpWvilt/P/gPEgSQtSjqst7koZcc2NCCzB8+rvJ4NDlj5waomwEvEdLMF1pLHRiORLeZJ/Sxrcf273O41YJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AW24KjK/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=nrewlIfI5HYuExosQFWxaOrY0sOFa4SouydTE7avaMQ=; b=AW24KjK/k0nRSKibXqrpo+lClC
	AfXHILSwbyTl2bUGZC5jv5LiNhHQDEFz6Om7IBZse+6Sn/75y9JT5o8Soil9NSGkipni3pE71ZwCf
	Ebpuqh+Zgp5UfiiJAXke9QRIRdB8kLpwPW2aQAkxokWic97jQ+z54eMamuVweoyg8Uja9xLhavdmO
	3e+Hd1XQb/s9ul2MW73fJRoC1e8ZsqTzgx8HjW7pOfro2NES4JGU70MwQXiMGyM3kPI7/AMztyDTG
	g26s7HVDM50zEOUvhfASWf+wq8hd1mY90BC0oqOm2X3+8cYRgc/c5YD/wLVNDSQ2aRgML7htiqa7Y
	FGHvOfsA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1us4jL-00000006k1Q-2IUX;
	Fri, 29 Aug 2025 19:25:47 +0000
Message-ID: <6df45a4f-023c-4490-90e6-b00762e9ef05@infradead.org>
Date: Fri, 29 Aug 2025 12:25:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/15] iommupt: Add the basic structure of the iommu
 implementation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <3-v4-0d6a6726a372+18959-iommu_pt_jgg@nvidia.com>
 <cc96baee-2be5-433f-9902-a160765e2fae@infradead.org>
 <20250829190525.GG79520@nvidia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250829190525.GG79520@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/29/25 12:05 PM, Jason Gunthorpe wrote:
>>> +	/*
>>> +	 * The aperture is limited to what the API can do after considering all
>>> +	 * the different types dma_addr_t/unsigned long/pt_vaddr_t that are used
>>> +	 * to store a VA. Set the aperture to something that is valid for all
>>> +	 * cases. Saturate instead of truncate the end if the types are smaller
>>> +	 * than the top range. aperture_end is a last.
>> Does "is a last" have something to do with terminating loop iteration?
>> Is it inclusive or exclusive?
> It is intended to refer back to the definitions:
> 
>  *  start/end
>  *     An half-open range, e.g. [0,0) refers to no VA.
>  *  start/last
>  *     An inclusive closed range, e.g. [0,0] refers to the VA 0
> 

I see.

> Where aperture_start/aperture_end doesn't follow that standard.

oops

> 
> 	 * cases. Saturate instead of truncate the end if the types are smaller
> 	 * than the top range. aperture_end should be called aperture_last.
> 	 */
> 
> Maybe?

Yes, that's helpful.Thanks.
-- 
~Randy


