Return-Path: <linux-kselftest+bounces-397-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3D57F3BCF
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 03:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA8E1C20FD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Nov 2023 02:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20BC747E;
	Wed, 22 Nov 2023 02:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DaEkRuTS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98242195;
	Tue, 21 Nov 2023 18:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700620604; x=1732156604;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XpeZeMNRKx6fjfNcJza/391hB0gfEObFGgA1WhB5A6k=;
  b=DaEkRuTSS80XQxpWLqayarWDCR1gJwvwKfQGR5aTwKLm01QDG3baPoID
   CWZ5zyU77eT5/DnZMCsyyez9DtKAAq+YyUJCOxEo2iheaUFW0CNfQkaI2
   iAnujYSmWlgs3dpJfpkQQbQLr6FSs+mI22BN0Aq9kYskNx2y2Ov8ho/kg
   VUQnucWC1I6L/Bjg4tH6JB8xqa/0/twgpovdLMq/v9VBWhmUcGEustbv7
   ky/jEk7JzJd4AjA4bFLzTbPI3B9Hx/tbagG5zR1+x42zBOSmcct9Ic2lK
   r1SlTJvuWiMKuioZJVnEI19i1AsTJFusr1NlQKnq2H+mYEfTIQJ58LTTs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="394804919"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="394804919"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:36:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="8289961"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmviesa002.fm.intel.com with ESMTP; 21 Nov 2023 18:36:38 -0800
Message-ID: <f5b27724-7c86-4823-ae86-76c92a2760b4@linux.intel.com>
Date: Wed, 22 Nov 2023 10:32:18 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
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
 "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v7 1/3] iommufd: Add data structure for Intel VT-d stage-1
 cache invalidation
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>
References: <20231117131816.24359-1-yi.l.liu@intel.com>
 <20231117131816.24359-2-yi.l.liu@intel.com>
 <BN9PR11MB52761D7A88BB2F655355A7728CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231120230451.GD6083@nvidia.com>
 <BN9PR11MB5276EF10FCE9C96F593696E18CBBA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20231121121704.GE6083@nvidia.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231121121704.GE6083@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/23 8:17 PM, Jason Gunthorpe wrote:
> On Tue, Nov 21, 2023 at 02:54:15AM +0000, Tian, Kevin wrote:
>>> From: Jason Gunthorpe <jgg@nvidia.com>
>>> Sent: Tuesday, November 21, 2023 7:05 AM
>>>
>>> On Mon, Nov 20, 2023 at 08:26:31AM +0000, Tian, Kevin wrote:
>>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>>> Sent: Friday, November 17, 2023 9:18 PM
>>>>>
>>>>> This adds the data structure for flushing iotlb for the nested domain
>>>>> allocated with IOMMU_HWPT_DATA_VTD_S1 type.
>>>>>
>>>>> This only supports invalidating IOTLB, but no for device-TLB as device-TLB
>>>>> invalidation will be covered automatically in the IOTLB invalidation if the
>>>>> underlying IOMMU driver has enabled ATS for the affected device.
>>>>
>>>> "no for device-TLB" is misleading. Here just say that cache invalidation
>>>> request applies to both IOTLB and device TLB (if ATS is enabled ...)
>>>
>>> I think we should forward the ATS invalidation from the guest too?
>>> That is what ARM and AMD will have to do, can we keep them all
>>> consistent?
>>>
>>> I understand Intel keeps track of enough stuff to know what the RIDs
>>> are, but is it necessary to make it different?
>>
>> probably ask the other way. Now intel-iommu driver always flushes
>> iotlb and device tlb together then is it necessary to separate them
>> in uAPI for no good (except doubled syscalls)? :)
> 
> I wish I knew more about Intel CC design to be able to answer that :|
> 
> Doesn't the VM issue the ATC flush command regardless? How does it
> know it has a working ATC but does not need to flush it?
> 

The Intel VT-d spec doesn't require the driver to flush iotlb and device
tlb together. Therefore, the current approach of relying on caching mode
to determine whether device TLB invalidation is necessary appears to be
a performance optimization rather than an architectural requirement.

The vIOMMU driver assumes that it is running within a VM guest when
caching mode is enabled. This assumption leads to an omission of device
TLB invalidation, relying on the hypervisor to perform a combined flush
of the IOLB and device TLB.

While this optimization aims to reduce VMEXIT overhead, it introduces
potential issues:

- When a Linux guest running on a hypervisor other than KVM/QEMU, the
   assumption of combined IOLB and device TLB flushing by the hypervisor
   may be incorrect, potentially leading to missed device TLB
   invalidation.

- The caching mode doesn't apply to first-stage translation. Therefore,
   if the driver uses first-stage translation and still relies on caching
   mode to determine device TLB invalidation, the optimization fails.

A more reasonable optimization would be to allocate a bit in the iommu
capability registers. The vIOMMU driver could then leverage this bit to
determine whether it could eliminate a device invalidation request.

Best regards,
baolu

