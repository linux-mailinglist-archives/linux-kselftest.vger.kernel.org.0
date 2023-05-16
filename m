Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1157043C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 May 2023 05:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEPDA5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 23:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEPDA4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 23:00:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E73A8C;
        Mon, 15 May 2023 20:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684206054; x=1715742054;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=utRQjcKthufdYW48GrQXIXbMoZ4rXaRkOhdYI6E/87c=;
  b=MmQOdqGHYqrpXm9xQfRWgi+UA1ecTEVOBjTl9Gv0PVZ/KwpBhsjTrmHl
   qwAQxKD8Zu9dj1FpS1608HHZzpTLG+YdGwOU8zhPB+UVzVzBsuB9HIdGS
   OW6pgoe03hlw2jzOo4yvIJD9GqTGwVeGtDBBpwh7b3Zd/dECndNQdMPLX
   bWjHxEXQ5QrmrqgxI4rLnyq4AQhx+Ho7Q3z7cqiLQKAM28vREbu/WqCYT
   cGKpzcTtX7Q73bB+e+mXjdZKMomogbE3lepqTswfWEgazXIa4ntaonCVo
   zx2ZRE/maIKBG/4j4NhgGB+rwOWB8H94A5dD+LTjGUN54ikO0JR86Z5SI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="350203795"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="350203795"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2023 20:00:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="695269167"
X-IronPort-AV: E=Sophos;i="5.99,277,1677571200"; 
   d="scan'208";a="695269167"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga007.jf.intel.com with ESMTP; 15 May 2023 20:00:52 -0700
Message-ID: <569b959e-a702-fc19-3d67-0dde4e77251a@linux.intel.com>
Date:   Tue, 16 May 2023 11:00:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        kvm@vger.kernel.org, Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v7 03/19] iommufd: Replace the hwpt->devices list with
 iommufd_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        linux-kselftest@vger.kernel.org
References: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 10:00 PM, Jason Gunthorpe wrote:
> The devices list was used as a simple way to avoid having per-group
> information. Now that this seems to be unavoidable, just commit to
> per-group information fully and remove the devices list from the HWPT.
> 
> The iommufd_group stores the currently assigned HWPT for the entire group
> and we can manage the per-device attach/detach with a list in the
> iommufd_group.

I am preparing the patches to route I/O page faults to user space
through iommufd. The iommufd page fault handler knows the hwpt and the
device pointer, but it needs to convert the device pointer into its
iommufd object id and pass the id to user space.

It's fine that we remove the hwpt->devices here, but perhaps I need to
add the context pointer in ioas later,

struct iommufd_ioas {
         struct io_pagetable iopt;
         struct mutex mutex;
         struct list_head hwpt_list;
+       struct iommufd_ctx *ictx;
  };

and, use below helper to look up the device id.

+u32 iommufd_get_device_id(struct iommufd_ctx *ictx, struct device *dev)
+{
+       struct iommu_group *group = iommu_group_get(dev);
+       u32 dev_id = IOMMUFD_INVALID_OBJ_ID;
+       struct iommufd_group *igroup;
+       struct iommufd_device *cur;
+       unsigned int id;
+
+       if (!group)
+               return IOMMUFD_INVALID_OBJ_ID;
+
+       id = iommu_group_id(group);
+       xa_lock(&ictx->groups);
+       igroup = xa_load(&ictx->groups, id);
+       if (!iommufd_group_try_get(igroup, group)) {
+               xa_unlock(&ictx->groups);
+               iommu_group_put(group);
+               return IOMMUFD_INVALID_OBJ_ID;
+        }
+        xa_unlock(&ictx->groups);
+
+       mutex_lock(&igroup->lock);
+       list_for_each_entry(cur, &igroup->device_list, group_item) {
+               if (cur->dev == dev) {
+                       dev_id = cur->obj.id;
+                       break;
+               }
+       }
+       mutex_unlock(&igroup->lock);
+
+       iommufd_put_group(igroup);
+       iommu_group_put(group);
+
+       return dev_id;
+}

and, use it like this in the fault handler:

        dev_id = iommufd_get_device_id(hwpt->ioas->ictx, dev);
+       if (dev_id == IOMMUFD_INVALID_OBJ_ID)
+               return IOMMU_PAGE_RESP_FAILURE;

Will this look good to you?

> For destruction the flow is organized to make the following patches
> easier, the actual call to iommufd_object_destroy_user() is done at the
> top of the call chain without holding any locks. The HWPT to be destroyed
> is returned out from the locked region to make this possible. Later
> patches create locking that requires this.
> 
> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          | 100 +++++++++++-------------
>   drivers/iommu/iommufd/hw_pagetable.c    |  22 +-----
>   drivers/iommu/iommufd/iommufd_private.h |  13 ++-
>   3 files changed, 54 insertions(+), 81 deletions(-)

Best regards,
baolu
