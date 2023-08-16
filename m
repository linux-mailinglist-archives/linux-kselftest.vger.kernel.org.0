Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1335977E0C7
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 13:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244760AbjHPLt3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Aug 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244765AbjHPLs7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Aug 2023 07:48:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E701FC3;
        Wed, 16 Aug 2023 04:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692186538; x=1723722538;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vP7dzVfwzQJ0W/VkN5o/STGMfQUDig133TyWYBekv58=;
  b=ToAHC2DKMCGwazcVF1daPSWHJXOO/QX240iUmSK1RMBbttcf5Q5QNNz4
   sVtdHUK91PQwrxI+xIX1WbL/4LgjzB3jDvGPfPoeV8qLw7d9SQOox8T5a
   ollvqXo1tvmraJqqJuVlevGJx7yErqKLnrlj55LOldvTt8YKwM+WE/a15
   8w7ZdE9bk9biQp1HJV+kcbyhJvQSgMtjgCVcV2e3yEpMTTaCb6Yb8vV+X
   ZYcFZCaGAE9SfPvKOUSCDjhs89f3sbxgRCGms2yhwcpd4Ile6pDz9lxRf
   gJ4Ym6Y07l7JmslfngdO+1ffr5fU9oolu6iMXBH6cQr/vhp7UEVK/2Zhw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="371419593"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="371419593"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="711089189"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="711089189"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.209.88]) ([10.254.209.88])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 04:48:52 -0700
Message-ID: <faa5a247-c42f-8399-0f70-79d0459773b5@linux.intel.com>
Date:   Wed, 16 Aug 2023 19:48:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, Yi Liu <yi.l.liu@intel.com>,
        joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com> <ZNuoWRH/HthxsLMd@nvidia.com>
 <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
 <ZNy2/4D9AqjtUAnF@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNy2/4D9AqjtUAnF@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/16 19:46, Jason Gunthorpe wrote:
> On Wed, Aug 16, 2023 at 08:35:00AM +0800, Baolu Lu wrote:
>> On 2023/8/16 0:31, Jason Gunthorpe wrote:
>>> On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
>>>> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>>>>
>>>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>>>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>>>> ---
>>>>    drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>>>>    include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>>>>    2 files changed, 42 insertions(+)
>>> I would like to pick this patch out of this series to go with the main
>>> get_info stuff so that we have drivers implementing what is merged. I
>>> made the trivial fixup.
>>>
>>> Lu are you OK?
>> Yes.
>>
>> Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> I changed this to an acked-by since you helpd write the patch 😄

Okay, fine to me.

Best regards,
baolu
