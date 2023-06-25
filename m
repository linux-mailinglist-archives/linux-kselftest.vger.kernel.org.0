Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEAA973CEB2
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 08:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFYGa4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 02:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjFYGaz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 02:30:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EF9E46;
        Sat, 24 Jun 2023 23:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687674654; x=1719210654;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R7Yhr42fK7gKhO8erEf7BeGzaAEEpOtaMIIdcwtYeU4=;
  b=ZQDJuTZGtlvftcSznqEa5dfamtLWgc8aQwMsg5sL+qlzCl8oES7Z+vjT
   YK0gSfB75r4y3V4+HqzPnq0a0M+sMVkBxLblo3T7WRzXVVhIQRQc9ytPU
   xMEihkwGPkAdHsb6mhZNhFfHlaFc31KIYmdA7aDriGxRatKcW1k2KXavk
   IcaIemXCAFDD/MOC1FsPtD7XznHOwBnnq1qBekufND2KqfaRSjw13jQlS
   vSmSPbYeZpO1zGm6uM46Fr9XTrk0O7kvQgoUWIIIh0LCq0vfqEjPyChDF
   5c3AsoUGmqw8uY0Xmm3VGRySF4T2dJXum/09IFOaGerGQeT2y98t6JRA9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="424708490"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="424708490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 23:30:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10751"; a="889912917"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="889912917"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.26]) ([10.254.208.26])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 23:30:48 -0700
Message-ID: <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
Date:   Sun, 25 Jun 2023 14:30:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Yi Liu <yi.l.liu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCHES 00/17] IOMMUFD: Deliver IO page faults to user space
To:     Nicolin Chen <nicolinc@nvidia.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/5/31 2:50, Nicolin Chen wrote:
> Hi Baolu,
> 
> On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
>   
>> This series implements the functionality of delivering IO page faults to
>> user space through the IOMMUFD framework. The use case is nested
>> translation, where modern IOMMU hardware supports two-stage translation
>> tables. The second-stage translation table is managed by the host VMM
>> while the first-stage translation table is owned by the user space.
>> Hence, any IO page fault that occurs on the first-stage page table
>> should be delivered to the user space and handled there. The user space
>> should respond the page fault handling result to the device top-down
>> through the IOMMUFD response uAPI.
>>
>> User space indicates its capablity of handling IO page faults by setting
>> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
>> will then setup its infrastructure for page fault delivery. Together
>> with the iopf-capable flag, user space should also provide an eventfd
>> where it will listen on any down-top page fault messages.
>>
>> On a successful return of the allocation of iopf-capable HWPT, a fault
>> fd will be returned. User space can open and read fault messages from it
>> once the eventfd is signaled.
> 
> I think that, whether the guest has an IOPF capability or not,
> the host should always forward any stage-1 fault/error back to
> the guest. Yet, the implementation of this series builds with
> the IOPF framework that doesn't report IOMMU_FAULT_DMA_UNRECOV.
> 
> And I have my doubt at the using the IOPF framework with that
> IOMMU_PAGE_RESP_ASYNC flag: using the IOPF framework is for
> its bottom half workqueue, because a page response could take
> a long cycle. But adding that flag feels like we don't really
> need the bottom half workqueue, i.e. losing the point of using
> the IOPF framework, IMHO.
> 
> Combining the two facts above, I wonder if we really need to
> go through the IOPF framework; can't we just register a user
> fault handler in the iommufd directly upon a valid event_fd?

Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
could go ahead with below code? It will be registered to device with
iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
path. Un-registering in the disable path of cause.

static int io_pgfault_handler(struct iommu_fault *fault, void *cookie)
{
         ioasid_t pasid = fault->prm.pasid;
         struct device *dev = cookie;
         struct iommu_domain *domain;

         if (fault->type != IOMMU_FAULT_PAGE_REQ)
                 return -EOPNOTSUPP;

         if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
                 domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
         else
                 domain = iommu_get_domain_for_dev(dev);

         if (!domain || !domain->iopf_handler)
                 return -ENODEV;

         if (domain->type == IOMMU_DOMAIN_SVA)
                 return iommu_queue_iopf(fault, cookie);

         return domain->iopf_handler(fault, dev, domain->fault_data);
}

Best regards,
baolu
