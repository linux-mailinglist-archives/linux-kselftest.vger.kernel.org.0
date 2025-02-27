Return-Path: <linux-kselftest+bounces-27735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F59A47C1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 12:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AA6318950BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 11:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7132022D7AB;
	Thu, 27 Feb 2025 11:21:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A87C22D4E3;
	Thu, 27 Feb 2025 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655295; cv=none; b=iVGozsxSxcgUrqZ+ELqcobZjss2pbSItJ2TSQJNO+nFGT4NVrE0u0GtNlPbo6o0cIufs91rTsXfUrDAwpiDqwCcCfbjI9TgHVpbrQzgF9qMbDZ5e7OGNYA05pfiKpffMe6qi1bPobVFFboiKSw5KN7lbqVbGyZwQqZizZCzvy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655295; c=relaxed/simple;
	bh=n5A5jWSgLUSSadyEt6s8yXZl0yYcRoLAG1jkS7dW07E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UrzXNXhCrJJv384iRl5joVFwZ5ZcWK5S+a73pKCHzIlJ4CU7wxru1UszPHBxk8+dlbqNe/mz7XtqmP9lOcq41QpCtwAvqtvJ1XwVQp1wn2JLDf3CjilAlYMVL03MhVZ6GyTWG3yEx8//CTFXtOQAdxEyPVRrskiyLW7/y5ra60A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6302BCC;
	Thu, 27 Feb 2025 03:21:48 -0800 (PST)
Received: from [10.57.36.150] (unknown [10.57.36.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD2583F6A8;
	Thu, 27 Feb 2025 03:21:29 -0800 (PST)
Message-ID: <634c60ea-fec3-43ad-923a-cf9ba5e76065@arm.com>
Date: Thu, 27 Feb 2025 11:21:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] iommu: Make iommu_dma_prepare_msi() into a generic
 operation
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
 tglx@linutronix.de, maz@kernel.org, joro@8bytes.org, will@kernel.org,
 shuah@kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, baolu.lu@linux.intel.com, yi.l.liu@intel.com,
 yury.norov@gmail.com, jacob.pan@linux.microsoft.com, patches@lists.linux.dev
References: <cover.1740014950.git.nicolinc@nvidia.com>
 <4ca696150d2baee03af27c4ddefdb7b0b0280e7b.1740014950.git.nicolinc@nvidia.com>
 <5b9e15e1-8081-46ef-b9db-3872e98a6f35@arm.com>
 <20250221164400.GN50639@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250221164400.GN50639@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-02-21 4:44 pm, Jason Gunthorpe wrote:
> On Fri, Feb 21, 2025 at 03:39:45PM +0000, Robin Murphy wrote:
>> Yuck. Realistically we are going to have no more than two different
>> implementations of this; a fiddly callback interface seems overkill. All we
>> should need in the domain is a simple indicator of *which* MSI translation
>> scheme is in use (if it can't be squeezed into the domain type itself), then
>> iommu_dma_prepare_msi() can simply dispatch between iommu-dma and IOMMUFD
>> based on that, and then it's easy to solve all the other fragility issues
>> too.
> 
> That would make module dependency problems, we have so far avoided
> having the core kernel hard depend on iommufd.

It wouldn't need a hard dependency, it's easy to have a trivial built-in 
stub function which becomes valid once the module loads - you literally 
have the iommufd_driver infrastructure for precisely that sort of thing 
already. All I'm saying is to hide the callback detail in the IOMMUFD 
code because being IOMMUFD modular is unique to IOMMUFD and not the rest 
of the core code's problem.

And frankly otherwise, what even is the benefit of moving the 
iova_cookie pointer into the union if we have to replace it with another 
whole pointer to make it work? This is just adding more code and more 
complexity in in order to make struct iommu_domain... the same size it 
already is :/

Thanks,
Robin.

