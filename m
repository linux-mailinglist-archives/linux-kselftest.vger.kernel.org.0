Return-Path: <linux-kselftest+bounces-4377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F03084EEE7
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 03:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D9C1F27F77
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Feb 2024 02:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B753394;
	Fri,  9 Feb 2024 02:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nztmOa5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED62617FF;
	Fri,  9 Feb 2024 02:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707446418; cv=none; b=hnanu/6q1uJubYFA3/HRQiTFVss8UfVQmoVbN3orLbWad/+2WN3WnFnFhy5y4iyE6TIlf5yJyZ7oXstOdUFBU4Y9C11uY8rD8QzVeT1WuYPQ8ob1a8X/WmPaiGhVHejr0GaxY12ikH8HGN1PYjtPTtkIfyT+JDuRPaA8/A0szRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707446418; c=relaxed/simple;
	bh=YZDhCIFPXKcT25aeuggls+0rWNxO4AGLXeMC9qcXN2M=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lgnJ++/bhZIuOf02PlhMcG/hHQf4AGMbnIYRdHSQzOP3/ex/fFSQR4Qvd+2q7AIHPd6U5r+3RzQMybpwcFQJNXrK2qqS/RCUw8ZVpab+wipHOHaSQMBrO/zOrZDdZGrhHNHYrBdi3nb9uUXhb6/eaKc1SumbOe2RF8ejz6NkAec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nztmOa5r; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707446417; x=1738982417;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YZDhCIFPXKcT25aeuggls+0rWNxO4AGLXeMC9qcXN2M=;
  b=nztmOa5rkcJuE2/Fx8XI5LP1mkvObUTfDtqrJldX24FmRmGMzNxnSeTL
   QfX4iHMy4thHygcJUIe1YGurKild099YAnvT7oe8EelOLKfwmEII5dqvP
   pXqGPw29tpVsCF4JN4QlqNm+1LT92otNCpADGSgkAbJiqu4143CaHh8r6
   YAvsPJKndOcsDA/j+50b7aJ/LjVrD3UVCyJvtXrgXDOLGNE4uyAywaPeu
   C7g0++Qrh7m67pSKBhGmwMAj3yA+RwaC6EzluJm0Bg5nj/x9o5gMO7159
   pri+gKWLRcXd6NfGTm+U6qtM4O/AKqMm6Dg10YtapvlseCF0KdOhillAD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="436494544"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="436494544"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:40:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6488655"
Received: from lshui-mobl1.ccr.corp.intel.com (HELO [10.249.170.42]) ([10.249.170.42])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:40:12 -0800
Message-ID: <2b665c89-db75-4d5e-98d8-3c113684f532@linux.intel.com>
Date: Fri, 9 Feb 2024 10:40:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH rc 3/8] iommu/vt-d: Add missing iotlb flush for parent
 domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "jgg@nvidia.com" <jgg@nvidia.com>
Cc: baolu.lu@linux.intel.com,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
References: <20240208082307.15759-1-yi.l.liu@intel.com>
 <20240208082307.15759-4-yi.l.liu@intel.com>
 <BN9PR11MB5276446E0F03C1F3EC6B2E298C442@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <BN9PR11MB5276446E0F03C1F3EC6B2E298C442@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/2/8 16:38, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Thursday, February 8, 2024 4:23 PM
>>
>> +/*
>> + * Flush the relevant caches in nested translation if the domain
>> + * also serves as a parent
>> + */
>> +static void parent_domain_flush(struct dmar_domain *domain,
>> +				unsigned long pfn,
>> +				unsigned long pages, int ih)
>> +{
>> +	struct dmar_domain *s1_domain;
>> +
>> +	spin_lock(&domain->s1_lock);
>> +	list_for_each_entry(s1_domain, &domain->s1_domains, s2_link) {
>> +		struct iommu_domain_info *info;
>> +		unsigned long i;
>> +
>> +		xa_for_each(&s1_domain->iommu_array, i, info)
>> +			__iommu_flush_iotlb_psi(info->iommu, info->did,
>> +						pfn, pages, ih);
>> +	}
> As Jason suggested before this xarray lacks of proper locking.
> 
> but given it's rc fix I'm fine with it. @Baolu we do need fix it soon so
> this problem won't further expand like here.

Yes. I planned to fix the locking issue in a separated series.

Best regards,
baolu

