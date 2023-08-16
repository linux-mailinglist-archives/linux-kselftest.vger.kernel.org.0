Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFFE77D71A
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Aug 2023 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236511AbjHPAfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240783AbjHPAfJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 20:35:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D546CE6B;
        Tue, 15 Aug 2023 17:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692146108; x=1723682108;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8f2iATa2xEdHMvk63Q2DKkqtOyMKfE9XSsgVimDXLjw=;
  b=l5mAKEN9Vd1We5pBI/8+CLUs1NtUDQShseXKcGVEMIor5he0Yo+sqls/
   88UUg+tEse86z4TYl93ierEybkmfncK164AqsMK/W9fpnaw5tOyeYELZV
   Ls32ruiKTtDyScrKxV322wQcvH952hwPjfSFBY80VxeP4FDlLxOZ9uArp
   L7pc5ODwaCDJFoCwf9fKSIT8pwamvJ83oHkJ0mr+WbkmoDvNIj59KglMt
   9cOCU78IsEuj/ffg4cgjqH05NrZzCGyRfG1F8nWNpbPDizATbVMw8dNb9
   uyL8MB3LGmeSMCgx06LmrheXAKE+4x3Lwq8LX/AarrAH8hpqiWMpc9FOZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="438753898"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="438753898"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="824042590"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="824042590"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.212.45]) ([10.254.212.45])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 17:35:02 -0700
Message-ID: <c6c6a390-d1d1-a5f7-cbdb-2120043eceec@linux.intel.com>
Date:   Wed, 16 Aug 2023 08:35:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Cc:     baolu.lu@linux.intel.com, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
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
To:     Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com> <ZNuoWRH/HthxsLMd@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <ZNuoWRH/HthxsLMd@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/16 0:31, Jason Gunthorpe wrote:
> On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
>> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>>   include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>>   2 files changed, 42 insertions(+)
> I would like to pick this patch out of this series to go with the main
> get_info stuff so that we have drivers implementing what is merged. I
> made the trivial fixup.
> 
> Lu are you OK?

Yes.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
