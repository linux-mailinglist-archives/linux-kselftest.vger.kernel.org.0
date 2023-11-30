Return-Path: <linux-kselftest+bounces-861-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E28A7FE7C3
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 04:44:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCE9CB20E09
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Nov 2023 03:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358D5134B9;
	Thu, 30 Nov 2023 03:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JpQXb5oQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519D510F5;
	Wed, 29 Nov 2023 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701315857; x=1732851857;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WZZMnWGpd1y0ccfThg5B81AdxxPkKMFT8brLpoZWyyM=;
  b=JpQXb5oQFg/znCF9eSnr3+/ahKTjZe5l5bX/0UNeu0eWmTwqbBKVlXU/
   snUdiI6PhX6PEIHmUYQFEUvmLjFoNGYq1CT72EfOZK16czwcXSu9pHsy1
   EPAdxKs8NDE1ZMuAoCFGNEf1PXqHPmXJ0XEVTvCC4XafLUVgENFXKupCz
   3nrcnr9XXB6ZxrkbRqpKvKK9kdL5PTwzJQzZnYKtC/ypL9vatERoGUAOu
   H/uYAkNrWDoo9BPknRFTjKZZfLHAFBe/7Qv/SJXeSLSOaBGppdRz/fYkQ
   IUcNRfCyKj/gjTXR4+z68gMc89Kukw/+HI8lkvoM87huaIraNJ/Z5zJ/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="246698"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="246698"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016499582"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016499582"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.171.155]) ([10.249.171.155])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:44:12 -0800
Message-ID: <61736bbd-1e8f-4dce-9c31-c1a6f10ae344@linux.intel.com>
Date: Thu, 30 Nov 2023 11:44:10 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
 Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20231026024930.382898-1-baolu.lu@linux.intel.com>
 <55ed1ac0f2024c429b396cb751773d62@huawei.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <55ed1ac0f2024c429b396cb751773d62@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/11/29 17:08, Shameerali Kolothum Thodi wrote:
> 
> 
>> -----Original Message-----
>> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
>> Sent: 26 October 2023 03:49
>> To: Jason Gunthorpe <jgg@ziepe.ca>; Kevin Tian <kevin.tian@intel.com>;
>> Joerg Roedel <joro@8bytes.org>; Will Deacon <will@kernel.org>; Robin
>> Murphy <robin.murphy@arm.com>; Jean-Philippe Brucker
>> <jean-philippe@linaro.org>; Nicolin Chen <nicolinc@nvidia.com>; Yi Liu
>> <yi.l.liu@intel.com>; Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: iommu@lists.linux.dev; linux-kselftest@vger.kernel.org;
>> virtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; Lu
>> Baolu <baolu.lu@linux.intel.com>
>> Subject: [PATCH v2 0/6] IOMMUFD: Deliver IO page faults to user space
>>
>> Hi folks,
>>
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework for nested translation. Nested
>> translation is a hardware feature that supports two-stage translation
>> tables for IOMMU. The second-stage translation table is managed by the
>> host VMM, while the first-stage translation table is owned by user
>> space. This allows user space to control the IOMMU mappings for its
>> devices.
>>
>> When an IO page fault occurs on the first-stage translation table, the
>> IOMMU hardware can deliver the page fault to user space through the
>> IOMMUFD framework. User space can then handle the page fault and
>> respond
>> to the device top-down through the IOMMUFD. This allows user space to
>> implement its own IO page fault handling policies.
>>
>> User space indicates its capability of handling IO page faults by
>> setting the IOMMU_HWPT_ALLOC_IOPF_CAPABLE flag when allocating a
>> hardware page table (HWPT). IOMMUFD will then set up its infrastructure
>> for page fault delivery. On a successful return of HWPT allocation, the
>> user can retrieve and respond to page faults by reading and writing to
>> the file descriptor (FD) returned in out_fault_fd.
>>
>> The iommu selftest framework has been updated to test the IO page fault
>> delivery and response functionality.
>>
>> This series is based on the latest implementation of nested translation
>> under discussion [1] and the page fault handling framework refactoring in
>> the IOMMU core [2].
>>
>> The series and related patches are available on GitHub: [3]
>>
>> [1]
>> https://lore.kernel.org/linux-iommu/20230921075138.124099-1-yi.l.liu@int
>> el.com/
>> [2]
>> https://lore.kernel.org/linux-iommu/20230928042734.16134-1-baolu.lu@li
>> nux.intel.com/
>> [3]
>> https://github.com/LuBaolu/intel-iommu/commits/iommufd-io-pgfault-deliv
>> ery-v2
> 
> Hi Baolu,

Hi Shameer,

> 
> Do you have a corresponding Qemu git to share? I could give it a spin on our ARM
> platform. Please let me know.

This version of the series is tested by the iommufd selftest. We are in
process of developing the QEMU code. I will provide the repo link after
we complete it.

Best regards,
baolu

