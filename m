Return-Path: <linux-kselftest+bounces-2545-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C1A8212E8
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 04:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E110282A23
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jan 2024 03:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E330881F;
	Mon,  1 Jan 2024 03:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kTZTylDt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A164A52;
	Mon,  1 Jan 2024 03:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704080394; x=1735616394;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TGBXTbeX8tde9ouDg3XSWCKQoZCnrld95jzC7rtlJzQ=;
  b=kTZTylDtci4r9lxihY/c8bL5EONzJB7/jQJjnW5XZ0ShUTVpJjRp3fvS
   7+KESNa29noghU2Br+MaPjnFt45fO2lFrf3wt1yfXU1rO16xSGUeIsSGi
   Md1N5v1Dy+FKoRsd2U3wCG6iLRpXLMHqXFKlooSxZx0E801eqnoHB7X+w
   78x+d5/lLIoGIChkS4aOI8Lg1oTubKQt2K6g8D4PzNVDqR7VHAZuAUqrN
   lCC3dXaRjJ9YmpTrDOMi05rF+nKBCWLkLo+AqtTi9upJhiI9+8vCi6Jbm
   w6XaMYlFkX5etbvdVUNL0l2OPa5wtYWMj1/LX7w8SxZSvb5orZA98f9nw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="15412198"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="15412198"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2023 19:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="902785434"
X-IronPort-AV: E=Sophos;i="6.04,321,1695711600"; 
   d="scan'208";a="902785434"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga004.jf.intel.com with ESMTP; 31 Dec 2023 19:39:47 -0800
Message-ID: <50098edc-2bbb-4c8f-9360-6990f0f5d88a@linux.intel.com>
Date: Mon, 1 Jan 2024 11:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
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
Subject: Re: [PATCH v8 07/10] iommu/vt-d: Allow qi_submit_sync() to return the
 QI faults
To: "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20231227161354.67701-1-yi.l.liu@intel.com>
 <20231227161354.67701-8-yi.l.liu@intel.com>
 <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276429906ED56258BB433068C9EA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/28/23 2:17 PM, Tian, Kevin wrote:
>>   	raw_spin_lock_irqsave(&qi->q_lock, flags);
>>   	/*
>> @@ -1430,7 +1439,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
>> struct qi_desc *desc,
>>   		 * a deadlock where the interrupt context can wait
>> indefinitely
>>   		 * for free slots in the queue.
>>   		 */
>> -		rc = qi_check_fault(iommu, index, wait_index);
>> +		rc = qi_check_fault(iommu, index, wait_index, fault);
>>   		if (rc)
>>   			break;
> and as replied in another thread let's change qi_check_fault to return
> -ETIMEDOUT to break the restart loop when fault pointer is valid.

It's fine to break the retry loop when fault happens and the fault
pointer is valid. Please don't forget to add an explanation comment
around the code. Something like:

/*
  * The caller is able to handle the fault by itself. The IOMMU driver
  * should not attempt to retry this request.
  */

Best regards,
baolu

