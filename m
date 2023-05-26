Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF39711E2B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjEZC5B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 22:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjEZC5A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 22:57:00 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9839C;
        Thu, 25 May 2023 19:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685069815; x=1716605815;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=87EFoqFdDwJwUK3kXoChDagOZZNSvNb2HRBfvOhjr+Y=;
  b=OysxxycIB4SU8nmFxUFsG7sMLIEBE0f5He41f0/SGIG/uePfLsiGdy/i
   N8ohQ1DHwyF5a8UY+ml7wGQSzbkGqGgGXFv4GiZ4DTI7DRZ/l7JGV95Kb
   ig3gLTFrfymVljjlTIvV6usZhbGyLmQFqAZm7U3iKbvUN8a0WqKFHiUua
   /HJVTdiAFOZSLcgFOmuRAAIW8hjxGwDaj25MYNaTmuHPrr0KJFc5qSQNd
   MnXfi7wh+sxEE030Ul+VsK8wAm0mzgjZSl5AjDFAXwDoZosNr5b2j7ntJ
   JHwoK5s6AT9+xEJ61ULTpHiGBlCUdmpqaRlkyJLggbiWy+x8c2Dmbobmu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="419852574"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="419852574"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 19:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="738089478"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="738089478"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2023 19:56:49 -0700
Message-ID: <8a47d13c-a555-d88a-8aba-adf11d925446@linux.intel.com>
Date:   Fri, 26 May 2023 10:56:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
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
Subject: Re: [PATCH v3 02/10] iommu/vt-d: Extend dmar_domain to support nested
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-3-yi.l.liu@intel.com>
 <BN9PR11MB5276AC0968EE3A5DBAD0E5018C419@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276AC0968EE3A5DBAD0E5018C419@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 5/24/23 3:02 PM, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Thursday, May 11, 2023 10:51 PM
>>
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>
>> The nested domain fields are exclusive to those that used for a DMA
>> remapping domain. Use union to avoid memory waste.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/intel/iommu.h | 35 +++++++++++++++++++++++++++++------
>>   1 file changed, 29 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
>> index 1c5e1d88862b..e818520f4068 100644
>> --- a/drivers/iommu/intel/iommu.h
>> +++ b/drivers/iommu/intel/iommu.h
>> @@ -596,15 +596,38 @@ struct dmar_domain {
>>   	spinlock_t lock;		/* Protect device tracking lists */
>>   	struct list_head devices;	/* all devices' list */
>>
>> -	struct dma_pte	*pgd;		/* virtual address */
>> -	int		gaw;		/* max guest address width */
>> -
>> -	/* adjusted guest address width, 0 is level 2 30-bit */
>> -	int		agaw;
>>   	int		iommu_superpage;/* Level of superpages supported:
>>   					   0 == 4KiB (no superpages), 1 ==
>> 2MiB,
>>   					   2 == 1GiB, 3 == 512GiB, 4 == 1TiB */
>> -	u64		max_addr;	/* maximum mapped address */
>> +	union {
>> +		/* DMA remapping domain */
>> +		struct {
>> +			/* virtual address */
>> +			struct dma_pte	*pgd;
>> +			/* max guest address width */
>> +			int		gaw;
>> +			/*
>> +			 * adjusted guest address width:
>> +			 *   0: level 2 30-bit
>> +			 *   1: level 3 39-bit
>> +			 *   2: level 4 48-bit
>> +			 *   3: level 5 57-bit
>> +			 */
>> +			int		agaw;
>> +			/* maximum mapped address */
>> +			u64		max_addr;
>> +		};
> what about 'nid'?


"nid" represents which NUMA node should we allocate pages from for this
domain. It's updated every time when a domain is attached/detached
to/from a device or pasid.

Generally speaking, "nid" is common for all types of domain. But in this
case, only a DMA remapping domain has a need to allocate pages. I intend
to keep it as it for now. There's more cleanup rooms if we limit it only
for DMA remapping domain.

Best regards,
baolu
