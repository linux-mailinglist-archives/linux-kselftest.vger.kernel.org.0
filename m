Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2836BC91D
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Mar 2023 09:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjCPIah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Mar 2023 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCPIag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Mar 2023 04:30:36 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1396862B45;
        Thu, 16 Mar 2023 01:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678955435; x=1710491435;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Mchnrg8Hxt/NFHcjv1NUznHa6A+fBfEdiQuXPmIfO/I=;
  b=i/OLik3IUDnydM/chT6ldA2vxSg4zUCfWCVnriyH3ZorVdbKt1HN4l/E
   bupS7T+FaBV1AiIDlkesJK88n84RHyztZRoxDGSUF0uwA7mdJYzq9fr7m
   D8nVzkV50w5vOmW6AKBmQHhn2yxR3czfX050/QMN+h1zbxLHuHTlJnObj
   +bOptOLnKVMOK18HdEzCuo5r0g14sxHrMml0OqH4txotMDLXfJ7g/11NU
   qYUFBiXQc7/BPA/4U9UmZq/WSSudplJproyWRAWBPncOc613P5KAMY7t4
   fToBAAFQ3Gj8GsxPjMtSEJAhKMfp/aj6rwnOWN9qsL04UyxwsYaqcV1le
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="317575389"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="317575389"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:30:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10650"; a="673056316"
X-IronPort-AV: E=Sophos;i="5.98,265,1673942400"; 
   d="scan'208";a="673056316"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.173]) ([10.249.173.173])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2023 01:30:29 -0700
Message-ID: <7b588f1e-ddd0-d7e7-984b-29e8be8f19ec@linux.intel.com>
Date:   Thu, 16 Mar 2023 16:30:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] iommu: Add new iommu op to get iommu hardware
 information
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-3-yi.l.liu@intel.com>
 <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C6A0F26954A42B8C23498CBC9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/16 16:16, Tian, Kevin wrote:
>> + *           allocated in the IOMMU driver and the caller should free it
>> + *           after use. Return the data buffer if success, or ERR_PTR on
>> + *           failure.
>>    * @domain_alloc: allocate iommu domain
>>    * @probe_device: Add device to iommu driver handling
>>    * @release_device: Remove device from iommu driver handling
>> @@ -246,11 +252,17 @@ struct iommu_iotlb_gather {
>>    * @remove_dev_pasid: Remove any translation configurations of a specific
>>    *                    pasid, so that any DMA transactions with this pasid
>>    *                    will be blocked by the hardware.
>> + * @driver_type: One of enum iommu_hw_info_type. This is used in the
>> hw_info
>> + *               reporting path. For the drivers that supports it, a unique
>> + *               type should be defined. For the driver that does not support
>> + *               it, this field is the IOMMU_HW_INFO_TYPE_DEFAULT that is 0.
>> + *               Hence, such drivers do not need to care this field.
> The meaning of "driver_type" is much broader than reporting hw_info.
> 
> let's be accurate to call it as "hw_info_type". and while we have two
> separate fields for one feature where is the check enforced on whether
> both are provided?
> 
> Is it simpler to return the type directly in @hw_info?

If I remember correctly, the vendor iommu type and hardware info are
reported to user space separately.

Best regards,
baolu
