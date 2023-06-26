Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F273D626
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Jun 2023 05:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjFZDLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 23:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZDLu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 23:11:50 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1434E10F;
        Sun, 25 Jun 2023 20:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687749109; x=1719285109;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5YoipUYft7QUMlguglJAyMKmrjX7z/rO5ECyxekdJdY=;
  b=IuCSS/wD5D8zpM3mPmI3CyOOuK0JwguXtJMP32mBuko0Cyat7QcF/TSw
   DUPYaU0Y88zPzl78vo/z6YRLIqHxMxnjNyiG/SVEZEZp5QxrazxA1Dq0m
   oX9wKgHdJd5kjKsvVFo1pQ+Wi8hWc+GTCzs2HQMnqhwstXq8GryfO32TY
   Ld10iJ95Y3rCclDAQEuTCs4EawMrezodMfk0YIlohQx7Lm8KbKVE5SHTV
   vP8Im1DI/N4Ogc50cwMDoMZ5KijN9X/0Q1oy8wSrw7wfF7WBwQVLO4jNX
   mW95gHdQkPeixKQBXFvTnVFsasz7QpsTaHGI5EdGEmleusW27kAer/hKx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="361196957"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="361196957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2023 20:11:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10752"; a="666139337"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="666139337"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 25 Jun 2023 20:11:44 -0700
Message-ID: <e374e0be-3e29-3128-b3df-6183a7a0e98e@linux.intel.com>
Date:   Mon, 26 Jun 2023 11:10:22 +0800
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
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJiTuO/9Bs4hMAiC@Asurada-Nvidia>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZJiTuO/9Bs4hMAiC@Asurada-Nvidia>
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

On 6/26/23 3:21 AM, Nicolin Chen wrote:
> On Sun, Jun 25, 2023 at 02:30:46PM +0800, Baolu Lu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On 2023/5/31 2:50, Nicolin Chen wrote:
>>> Hi Baolu,
>>>
>>> On Tue, May 30, 2023 at 01:37:07PM +0800, Lu Baolu wrote:
>>>
>>>> This series implements the functionality of delivering IO page faults to
>>>> user space through the IOMMUFD framework. The use case is nested
>>>> translation, where modern IOMMU hardware supports two-stage translation
>>>> tables. The second-stage translation table is managed by the host VMM
>>>> while the first-stage translation table is owned by the user space.
>>>> Hence, any IO page fault that occurs on the first-stage page table
>>>> should be delivered to the user space and handled there. The user space
>>>> should respond the page fault handling result to the device top-down
>>>> through the IOMMUFD response uAPI.
>>>>
>>>> User space indicates its capablity of handling IO page faults by setting
>>>> a user HWPT allocation flag IOMMU_HWPT_ALLOC_FLAGS_IOPF_CAPABLE. IOMMUFD
>>>> will then setup its infrastructure for page fault delivery. Together
>>>> with the iopf-capable flag, user space should also provide an eventfd
>>>> where it will listen on any down-top page fault messages.
>>>>
>>>> On a successful return of the allocation of iopf-capable HWPT, a fault
>>>> fd will be returned. User space can open and read fault messages from it
>>>> once the eventfd is signaled.
>>> I think that, whether the guest has an IOPF capability or not,
>>> the host should always forward any stage-1 fault/error back to
>>> the guest. Yet, the implementation of this series builds with
>>> the IOPF framework that doesn't report IOMMU_FAULT_DMA_UNRECOV.
>>>
>>> And I have my doubt at the using the IOPF framework with that
>>> IOMMU_PAGE_RESP_ASYNC flag: using the IOPF framework is for
>>> its bottom half workqueue, because a page response could take
>>> a long cycle. But adding that flag feels like we don't really
>>> need the bottom half workqueue, i.e. losing the point of using
>>> the IOPF framework, IMHO.
>>>
>>> Combining the two facts above, I wonder if we really need to
>>> go through the IOPF framework; can't we just register a user
>>> fault handler in the iommufd directly upon a valid event_fd?
>> Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
>> could go ahead with below code? It will be registered to device with
>> iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
>> path. Un-registering in the disable path of cause.
> Well, for a virtualization use case, I still think it's should
> be registered in iommufd.

Emm.. you suggest iommufd calls iommu_register_device_fault_handler() to
register its own page fault handler, right?

I have a different opinion, iommu_register_device_fault_handler() is
called to register a fault handler for a device. It should be called
or initiated by a device driver. The iommufd only needs to install a
per-domain io page fault handler.

I am considering a use case on Intel platform. Perhaps it's similar
on other platforms. An SIOV-capable device can support host SVA and
assigning mediated devices to user space at the same time. Both host
SVA and mediated devices require IOPF. So there will be multiple places
where a page fault handler needs to be registered.

> Having a device without an IOPF/PRI
> capability, a guest OS should receive some faults too, if that
> device causes a translation failure.

Yes. DMA faults are also a consideration. But I would like to have it
supported in a separated series. As I explained in the previous reply,
we also need to consider the software nested translation case.

> 
> And for a vSVA use case, the IOMMU_DEV_FEAT_IOPF feature only
> gets enabled in the guest VM right? How could the host enable
> the IOMMU_DEV_FEAT_IOPF to trigger this handler?

As mentioned above, this should be initiated by the kernel device
driver, vfio or possible mediated device driver.

Best regards,
baolu
