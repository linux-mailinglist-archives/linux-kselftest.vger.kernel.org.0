Return-Path: <linux-kselftest+bounces-2458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18DB81EDD1
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 10:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 472DA1F21CB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Dec 2023 09:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF036286B5;
	Wed, 27 Dec 2023 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BLrEpCUT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565C24B2F;
	Wed, 27 Dec 2023 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703669609; x=1735205609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3CwEmwqiSM/5uNYBcO71GZOk9/yCzWjcQzVF5esvjeA=;
  b=BLrEpCUTBn2+CoRUSMkPafkJlegDc0Ky7my9pbJ9POg+3SIn6XPd8VlD
   JcClBoAs0dvRNWkdFOjP3W4aiUKyzHj6SDyNt8+9yDFgHnuHiVxw07hOn
   6tnU3ag1KZmd9k830Jde5nllm8E3XxVEJomKEUUFHd+x6lvB9GZ85H3Zp
   k2Y7iGHDw9H6iQQLEiHzhnjn18wYQ63E4fqTjxe6RYfg8B2a2n1iaMCIE
   4TBJgFQQIJuh2ZvcYcE5Sk5gyBmYPDi6Q/v2q2Y58SVfiRTiPsV7cjdc+
   cEXSILTsdgYkMv/HIFxHklS2dwwwepBFLjDgcbyGpQ2+V48AWnJ8s6fTV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="399215571"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="399215571"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 01:33:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="812482117"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="812482117"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.255.28.66]) ([10.255.28.66])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 01:33:14 -0800
Message-ID: <ccdace4d-73a2-41c4-aa15-2d7b54e1d30e@linux.intel.com>
Date: Wed, 27 Dec 2023 17:33:11 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Cc: "cohuck@redhat.com" <cohuck@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231221153948.119007-1-yi.l.liu@intel.com>
 <20231221153948.119007-8-yi.l.liu@intel.com>
 <BN9PR11MB5276468811C5113427D4CA6F8C94A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <e1cf94ba-aaf7-448b-a87b-95d8a2442b20@intel.com>
 <BN9PR11MB527663D97345FC8CD9683AB28C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <72ce37d6-69bc-4580-a795-7a6638eae0ee@intel.com>
 <dec6b647-5ff2-4c57-8b10-b2d5c544566a@intel.com>
 <SJ0PR11MB67444BD4606F7A4014801B16929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <SJ0PR11MB67444BD4606F7A4014801B16929FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 12/27/2023 5:06 PM, Duan, Zhenzhong wrote:
>
>> -----Original Message-----
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Tuesday, December 26, 2023 4:44 PM
>> Subject: Re: [PATCH v7 7/9] iommu/vt-d: Allow qi_submit_sync() to return
>> the QI faults
>>
>> On 2023/12/26 14:15, Yi Liu wrote:
>>>
>>> On 2023/12/26 12:13, Tian, Kevin wrote:
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Tuesday, December 26, 2023 12:03 PM
>>>>>
>>>>> On 2023/12/22 12:23, Tian, Kevin wrote:
>>>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>>>> Sent: Thursday, December 21, 2023 11:40 PM
>>>>>>>
>>>>>>> +    fault &= DMA_FSTS_IQE | DMA_FSTS_ITE | DMA_FSTS_ICE;
>>>>>>> +    if (fault) {
>>>>>>> +        if (fsts)
>>>>>>> +            *fsts |= fault;
>>>>>> do we expect the fault to be accumulated? otherwise it's clearer to
>>>>>> just do direct assignment instead of asking for the caller to clear
>>>>>> the variable before invocation.
>>>>> not quite get. do you mean the fault should not be cleared in the caller
>>>>> side?
>>>>>
>>>> I meant:
>>>>
>>>>      if (fsts)
>>>>          *fsts = fault;
>>>>
>>>> unless there is a reason to *OR* the original value.
>>> I guess no such a reason. :) let me modify it.
>> hmmm, replied too soon. The qi_check_fault() would be called multiple
>> times in one invalidation circle as qi_submit_sync() needs to see if any
>> fault happened before the hw writes back QI_DONE to the wait descriptor.
>> There can be ICE which may eventually result in ITE. So caller of
>> qi_check_fault()
>> would continue to wait for QI_DONE. So qi_check_fault() returns 0 to let
>> qi_submit_sync() go on though ICE detected. If we use '*fsts = fault;',
>> then ICE would be missed since the input fsts pointer is the same in
>> one qi_submit_sync() call.
> Is it necessary to return fault to user if qi_check_fault() return -EAGAIN and
> a restart run succeeds?

Issue a device-TLB invalidation to no response device there is possibility

will be trapped there loop for ITE , never get return.

Thanks,

Ethan

> Thanks
> Zhenzhong

