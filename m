Return-Path: <linux-kselftest+bounces-2838-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3BF582A813
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 08:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A07A1F2453D
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jan 2024 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DBBC8C4;
	Thu, 11 Jan 2024 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PsxFlqiM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AA8DDAD;
	Thu, 11 Jan 2024 07:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704957264; x=1736493264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TwjCUuzwUOMo/dYEA4GwmnKF1gt7VZ+tjYe5DJBJoEM=;
  b=PsxFlqiM25EHVaiQabPdmwbPVsYzFdepEUQIHN7hWX9FyX3YRFBTkXPs
   y3j3T7impGSkxmopEmFzYP/9UwwT3ivW7USqw9Hd/23aUJeBIUTOJ70Ny
   tHJpxPP29fJJBV5ftKyfFV2AP0wg8J71EYDTJOBXIAnI2YpHmtGpGAcew
   VyDdHlv0AcHp9vcmPtkWN7LMIfre8ZtIdegGKjYrF752KCyshIhH8wUdD
   V39xWHoA64c+XYvWGXKiuMu3xARI4tfWn2TNF8A2NpolNHAIgBFit8xfZ
   h+/71UebPhobW0vAlstTdfkphgYpkz/g7yG/Swt3J5sEEj0auv5dOkb64
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="395910247"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="395910247"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="732116839"
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="732116839"
Received: from zhaohaif-mobl.ccr.corp.intel.com (HELO [10.93.8.238]) ([10.93.8.238])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 23:14:15 -0800
Message-ID: <4d50c00a-9718-4ec5-bdef-ea14c7727ff4@linux.intel.com>
Date: Thu, 11 Jan 2024 15:14:12 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
 "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "j.granados@samsung.com" <j.granados@samsung.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-8-yi.l.liu@intel.com>
 <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <50098edc-2bbb-4c8f-9360-6990f0f5d88a@linux.intel.com>
From: Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <50098edc-2bbb-4c8f-9360-6990f0f5d88a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/1/2024 11:34 AM, Baolu Lu wrote:
> On 12/28/23 2:17 PM, Tian, Kevin wrote:
>>> raw_spin_lock_irqsave(&qi->q_lock, flags);
>>>       /*
>>> @@ -1430,7 +1439,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
>>> struct qi_desc *desc,
>>>            * a deadlock where the interrupt context can wait
>>> indefinitely
>>>            * for free slots in the queue.
>>>            */
>>> -        rc = qi_check_fault(iommu, index, wait_index);
>>> +        rc = qi_check_fault(iommu, index, wait_index, fault);
>>>           if (rc)
>>>               break;
>> and as replied in another thread let's change qi_check_fault to return
>> -ETIMEDOUT to break the restart loop when fault pointer is valid.
>
> It's fine to break the retry loop when fault happens and the fault
> pointer is valid. Please don't forget to add an explanation comment
> around the code. Something like:
>
> /*
>  * The caller is able to handle the fault by itself. The IOMMU driver
>  * should not attempt to retry this request.
>  */

If caller could pass desc with mixed iotlb & devtlb invalidation request,

it would be problematic/difficult for caller or qi_submit_sync() to do

error handling, imagine a case like,

1. call qi_submit_sync() with iotlb & devltb.

2. qi_submit_sync() detects the target device is dead.

3.  break the loop, or will block other invalidation submitter / hang.

4. it is hard for qi_submit_sync() to extract those iotlb invalidation 
to retry.

5. it is also difficult for caller to retry the iotlb invalidation, or

     leave iotlb out-of-sync. ---there is no sync at all, device is gone.

and if only ITE fault hit, but target device is there && configuration

space reading okay, the ITE is probably left by previous request for

other device, not triggered by this batch, the question is we couldn't

identify the ITE device is just the same as current target ? if the same,

then breaking out is reasonable, or just leave the problem to caller,

something in the request batch is bad, some requests someone request

befoere is bad, but the request is not from the same caller.


Thanks,

Ethan


>
> Best regards,
> baolu
>

