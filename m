Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4876DF45
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 06:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjHCEFq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 00:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjHCEFp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 00:05:45 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E8E1AA;
        Wed,  2 Aug 2023 21:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691035544; x=1722571544;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WgVb4J59RLF3p1cq5nNgzuJOUGR0j/yT9TP7r6Wj8Zg=;
  b=bM3NNTvHuQWsxu4zpBJgc2EtYdAsoPdo6J9ItsDcMbF/ZWPsODo65WY6
   DBVgDLTbkXEhextcFSc4KHq901jXlMxVGn+51JZAEUdiKyfuQAx0WcmFM
   U26qatCkvFh+Pd0L07p5OSwyqlI5DxniyBI1tLkLaWsqydnrdEhONPYCU
   1o0866hPub/fd2a2R8wJusLpgSIsjtaS4E6XMkkeg2ZIK8jITzVgUE/Lu
   YkA+Mf8TUtMyPJb0RhvOxQwARDUFc++tEcU16UreQl3yFuM3ryW5rBSJl
   8YhQy2LPvkIU5FeqX41UFO9PJhtWPC926E6WqkDXrROwebIjy/UJH+fhR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="349360922"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="349360922"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:05:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872767507"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 21:05:41 -0700
Message-ID: <40d9b0fa-4a36-c3b7-53bb-4333ff89dc45@linux.intel.com>
Date:   Thu, 3 Aug 2023 12:05:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Cc:     baolu.lu@linux.intel.com, "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 09/12] iommu/vt-d: Add iotlb flush for nested domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-10-yi.l.liu@intel.com>
 <BN9PR11MB527690EBAA872A16AE8926F88C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <58ae9095-28f2-a44a-b0e5-be82e1eae9d9@linux.intel.com>
 <BN9PR11MB52764994FB32B2B1CD9C95068C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52764994FB32B2B1CD9C95068C08A@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/8/3 12:00, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Thursday, August 3, 2023 11:25 AM
>>
>> On 2023/8/2 15:46, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Monday, July 24, 2023 7:14 PM
>>>>
>>>> +
>>>> +		spin_lock_irqsave(&dmar_domain->lock, flags);
>>>> +		list_for_each_entry(info, &dmar_domain->devices, link)
>>>> +			intel_nested_invalidate(info->dev, dmar_domain,
>>>> +						req->addr, req->npages);
>>>> +		spin_unlock_irqrestore(&dmar_domain->lock, flags);
>>>
>>> Disabling interrupt while invalidating iotlb is certainly unacceptable.
>>>
>>> Actually there is no need to walk devices. Under dmar_domain there
>>> is already a list of attached iommu's.
>>
>> Walking device is only necessary when invalidating device TLB. For iotlb
>> invalidation, it only needs to know the iommu's.
>>
> 
> even for device tlb we may think whether there is any better way
> to avoid disabling interrupt. It's a slow path, especially in a guest.

I ever tried this. But some device drivers call iommu_unmap() in the
interrupt critical path. :-( So we have a long way to go.

Best regards,
baolu
