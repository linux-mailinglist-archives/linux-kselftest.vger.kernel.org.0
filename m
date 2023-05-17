Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64656705E9F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 06:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbjEQEPu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 00:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjEQEPo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 00:15:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559352709;
        Tue, 16 May 2023 21:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684296943; x=1715832943;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CvaZjUgWMTQ97N2rgQJXbGWdUafF/wgFVPg6D8BroBg=;
  b=Wwl8ciNvnIeNgroRNcMdpfJtRMi5YxPCJ671x9He9quzfwCQO1Z5LGew
   BflvACf47RwRsGlhkCjZ5bwREU9aBdhvceNgAPpoh5q99cXYjpmkW5KtC
   9RpbVbbuJh4FQHZhcuillG0Ji+Moz1/SjbUsqYRI5Hv44qfFFaH4b0tsX
   Ie2wX8Sy+navaCBhl8xrcxYaqhDn0eyPIcG144l2lZqIIPwJEMKCHwmx6
   ialthRMadkQ8fZ78IFEnkiDWMwWps9baMyhmQgAiDgKUWnLSS0PChBIU/
   Hwpn4gRqE6j6rPeO3qESaSFYNGSikHx1IRKX8NX4eds7eLwuQkUSS7Qft
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="438004384"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="438004384"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 21:15:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="652079725"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="652079725"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2023 21:15:39 -0700
Message-ID: <852e85b3-9fd2-bfc2-6080-82cea7ab6abd@linux.intel.com>
Date:   Wed, 17 May 2023 12:15:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org, Kevin Tian <kevin.tian@intel.com>,
        kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
 <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
 <ZGN2yvhpIvrvu74r@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZGN2yvhpIvrvu74r@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/16/23 8:27 PM, Jason Gunthorpe wrote:
> On Tue, May 16, 2023 at 11:00:16AM +0800, Baolu Lu wrote:
>> On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
>>> The devices list was used as a simple way to avoid having per-group
>>> information. Now that this seems to be unavoidable, just commit to
>>> per-group information fully and remove the devices list from the HWPT.
>>>
>>> The iommufd_group stores the currently assigned HWPT for the entire group
>>> and we can manage the per-device attach/detach with a list in the
>>> iommufd_group.
>>
>> I am preparing the patches to route I/O page faults to user space
>> through iommufd. The iommufd page fault handler knows the hwpt and the
>> device pointer, but it needs to convert the device pointer into its
>> iommufd object id and pass the id to user space.
>>
>> It's fine that we remove the hwpt->devices here, but perhaps I need to
>> add the context pointer in ioas later,
>>
>> struct iommufd_ioas {
>>          struct io_pagetable iopt;
>>          struct mutex mutex;
>>          struct list_head hwpt_list;
>> +       struct iommufd_ctx *ictx;
>>   };
>>
>> and, use below helper to look up the device id.
>>
>> +u32 iommufd_get_device_id(struct iommufd_ctx *ictx, struct device *dev)
>> +{
>> +       struct iommu_group *group = iommu_group_get(dev);
>> +       u32 dev_id = IOMMUFD_INVALID_OBJ_ID;
>> +       struct iommufd_group *igroup;
>> +       struct iommufd_device *cur;
>> +       unsigned int id;
>> +
>> +       if (!group)
>> +               return IOMMUFD_INVALID_OBJ_ID;
>> +
>> +       id = iommu_group_id(group);
>> +       xa_lock(&ictx->groups);
>> +       igroup = xa_load(&ictx->groups, id);
>> +       if (!iommufd_group_try_get(igroup, group)) {
>> +               xa_unlock(&ictx->groups);
>> +               iommu_group_put(group);
>> +               return IOMMUFD_INVALID_OBJ_ID;
>> +        }
>> +        xa_unlock(&ictx->groups);
>> +
>> +       mutex_lock(&igroup->lock);
>> +       list_for_each_entry(cur, &igroup->device_list, group_item) {
>> +               if (cur->dev == dev) {
>> +                       dev_id = cur->obj.id;
>> +                       break;
>> +               }
>> +       }
> 
> I dislike how slow this is on something resembling a fastish path :\

Yes, agreed.

> Maybe we should stash something in the dev_iommu instead?
> 
> Or can the PRI stuff provide a cookie per-device?

We already have a per-device fault cookie:

/**
  * struct iommu_fault_param - per-device IOMMU fault data
  * @handler: Callback function to handle IOMMU faults at device level
  * @data: handler private data
  * @faults: holds the pending faults which needs response
  * @lock: protect pending faults list
  */
struct iommu_fault_param {
         iommu_dev_fault_handler_t handler;
         void *data;
         struct list_head faults;
         struct mutex lock;
};

Perhaps we can add a @dev_id memory here?

> 
> But it will work like this
> 
>>         dev_id = iommufd_get_device_id(hwpt->ioas->ictx, dev);
> 
> Where did the hwpt come from?

It is installed when setting up the iopf handler for the hwpt.

+	iommu_domain_set_iopf_handler(hwpt->domain,
+                                     iommufd_hw_pagetable_iopf_handler,
+                                     hwpt);

Best regards,
baolu
