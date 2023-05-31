Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4984F717388
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 04:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjEaCLR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 22:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjEaCLQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 22:11:16 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFED11F;
        Tue, 30 May 2023 19:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685499074; x=1717035074;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=g2gT8/k6n0r5Xqt7LtizrMmloP8awjFUudd28EEp1gc=;
  b=O9fGka58XHIHChz37ZYWTghQgyeAtxa9qwYoT+lg7Kz/OerpHqpgb7Se
   H9ZWrIN0e9h7NDUQKDbNVbA1mN/rJvSvf++2IFGkfkyY/Dtu/o0Q12M1u
   39qo0aa4veM0abtMdnxmQqXVyA9uCKYoAnx2oaoYmUtixbo8qw+cHjM/M
   CcMpMcMvT88O5an6l5uSQAGVsMWZq1tALrAW+MiX8occlsaIO8RmVfsL9
   GrJo7fp7KP5tjz/LW+ENa3Cz7+6qEQVIK9UfcgJZjOk/4m/J70kKl+9MB
   +1KMbxd+Mbhc5tKjPKL1Xo4vvDPv2fqA9zlMf8FPyZK+ovvi3KQAUkgPq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353952171"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353952171"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 19:11:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="684213418"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="684213418"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga006.jf.intel.com with ESMTP; 30 May 2023 19:11:09 -0700
Message-ID: <ac924372-210c-155e-9aeb-36218d35444e@linux.intel.com>
Date:   Wed, 31 May 2023 10:10:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
Content-Language: en-US
To:     Nicolin Chen <nicolinc@nvidia.com>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/31/23 2:50 AM, Nicolin Chen wrote:
> Hi Baolu,

Hi Nicolin,

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

I agree with you that DMA unrecoverable faults on stage-1 hwpt should
also be reported to user space. However, I have some concerns about how
this will be implemented.

In the shadow page table case, we don't report DMA unrecoverable faults.
This could lead to confusion for users, as they may expect to receive
DMA unrecoverable faults regardless of whether hardware nested
translation is used.

I would suggest that we report DMA unrecoverable faults in all cases,
regardless of whether hardware nested translation is used. This would
make it easier for users to understand the behavior of their systems.

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

I agree with you that the existing IOPF framework is not ideal for
IOMMUFD. The adding ASYNC flag conflicts with the IOPF workqueue.
This could lead to performance issues.

I can improve the IOPF framework to make it more friendly to IOMMUFD.
One way to do this would be not use workqueue for the IOMMUFD case.

Have I covered all your concerns?

Best regards,
baolu
