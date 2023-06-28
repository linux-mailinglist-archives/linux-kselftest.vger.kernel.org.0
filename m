Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0CB740805
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 04:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjF1CBP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 22:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF1CBO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 22:01:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7092D72;
        Tue, 27 Jun 2023 19:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687917663; x=1719453663;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Afn3yy/9SE/0j1yHY5f7D7/VKnZeVp+lwaI9bNljNsk=;
  b=RYLjV4HkjMp08v+YdskhqCzAt9/GDRZVhO15PGAaJ8fsc+WDGuFOpIIC
   6UGcSj94RSHHD3t/hZG1P4stGFi3Zzda6nQEaEA+6Y3U3S2104Fhi/ioH
   2lkaRjTI8MXVc3umxEIzPcZ3B+UyRca/HewrZ1NI6FPMQ18IhmQ+hL9O7
   mh/gI+hRQgXVsrvD+P5B0du/tvvtPKZC4a3xfDD1GiZkppff0QADYGEXf
   5HVAscWtsSH2R1ATzv/8n7VDDRgTJ1t78mQgj5QnOlaIPQM9WE5e3TBm7
   r5tBhxU/uGXTH2lYwhxeiNtYzYVxyvNIOjDpia/FhhQFMmfjuvQKS3JRO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="365182908"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="365182908"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="710860419"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="710860419"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.175.150]) ([10.249.175.150])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2023 19:00:58 -0700
Message-ID: <26b97776-7ce5-51f6-77b7-0ce837aa7cca@linux.intel.com>
Date:   Wed, 28 Jun 2023 10:00:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Cc:     baolu.lu@linux.intel.com, Nicolin Chen <nicolinc@nvidia.com>,
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
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <20230530053724.232765-1-baolu.lu@linux.intel.com>
 <ZHZFi28jRxeZMKK3@Asurada-Nvidia>
 <a8ccbac8-c456-d116-24a2-7503ccbb720c@linux.intel.com>
 <ZJnZ7bEIZHsqmyAG@ziepe.ca>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZJnZ7bEIZHsqmyAG@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/6/27 2:33, Jason Gunthorpe wrote:
> On Sun, Jun 25, 2023 at 02:30:46PM +0800, Baolu Lu wrote:
> 
>> Agreed. We should avoid workqueue in sva iopf framework. Perhaps we
>> could go ahead with below code? It will be registered to device with
>> iommu_register_device_fault_handler() in IOMMU_DEV_FEAT_IOPF enabling
>> path. Un-registering in the disable path of cause.
> 
> This maze needs to be undone as well.
> 
> It makes no sense that all the drivers are calling
> 
>   iommu_register_device_fault_handler(dev, iommu_queue_iopf, dev);
> 
> The driver should RX a PRI fault and deliver it to some core code
> function, this looks like a good start:
> 
>> static int io_pgfault_handler(struct iommu_fault *fault, void *cookie)
>> {
>>          ioasid_t pasid = fault->prm.pasid;
>>          struct device *dev = cookie;
>>          struct iommu_domain *domain;
>>
>>          if (fault->type != IOMMU_FAULT_PAGE_REQ)
>>                  return -EOPNOTSUPP;
>>
>>          if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID)
>>                  domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
>>          else
>>                  domain = iommu_get_domain_for_dev(dev);
>>
>>          if (!domain || !domain->iopf_handler)
>>                  return -ENODEV;
>>
>>          if (domain->type == IOMMU_DOMAIN_SVA)
>>                  return iommu_queue_iopf(fault, cookie);
>>
>>          return domain->iopf_handler(fault, dev, domain->fault_data);
> 
> Then we find the domain that owns the translation and invoke its
> domain->ops->iopf_handler()

Agreed. The iommu_register_device_fault_handler() could only be called
by the device drivers who want to handle the DMA faults and IO page
faults by themselves in any special ways.

By default, the faults should be dispatched to domain->iopf_handler in a
generic core code.

> 
> If the driver created a SVA domain then the op should point to some
> generic 'handle sva fault' function. There shouldn't be weird SVA
> stuff in the core code.
> 
> The weird SVA stuff is really just a generic per-device workqueue
> dispatcher, so if we think that is valuable then it should be
> integrated into the iommu_domain (domain->ops->use_iopf_workqueue =
> true for instance). Then it could route the fault through the
> workqueue and still invoke domain->ops->iopf_handler.
> 
> The word "SVA" should not appear in any of this.

Yes. We should make it generic. The domain->use_iopf_workqueue flag
denotes that the page faults of a fault group should be put together and
then be handled and responded in a workqueue. Otherwise, the page fault
is dispatched to domain->iopf_handler directly.

> 
> Not sure what iommu_register_device_fault_handler() has to do with all
> of this.. Setting up the dev_iommu stuff to allow for the workqueue
> should happen dynamically during domain attach, ideally in the core
> code before calling to the driver.

There are two pointers under struct dev_iommu for fault handling.

/**
  * struct dev_iommu - Collection of per-device IOMMU data
  *
  * @fault_param: IOMMU detected device fault reporting data
  * @iopf_param:  I/O Page Fault queue and data

[...]

struct dev_iommu {
         struct mutex lock;
         struct iommu_fault_param        *fault_param;
         struct iopf_device_param        *iopf_param;

My understanding is that @fault_param is a place holder for generic
things, while @iopf_param is workqueue specific. Perhaps we could make
@fault_param static and initialize it during iommu device_probe, as
IOMMU fault is generic on every device managed by an IOMMU.

@iopf_param could be allocated on demand. (perhaps renaming it to a more
meaningful one?) It happens before a domain with use_iopf_workqueue flag
set attaches to a device. iopf_param keeps alive until device_release.

> 
> Also, I can understand there is a need to turn on PRI support really
> early, and it can make sense to have some IOMMU_DEV_FEAT_IOPF/SVA to
> ask to turn it on.. But that should really only be needed if the HW
> cannot turn it on dynamically during domain attach of a PRI enabled
> domain.
> 
> It needs cleaning up..

Yes. I can put this and other cleanup things that we've discussed in a
preparation series and send it out for review after the next rc1 is
released.

> 
> Jason

Best regards,
baolu
