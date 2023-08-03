Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC576DEDD
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjHCDSL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjHCDR5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:17:57 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7764EC3;
        Wed,  2 Aug 2023 20:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691032676; x=1722568676;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ITxwVfuZT01y5Gp5DbNNV01Z7VFQOHZEB0FHXaK6+N8=;
  b=I++uUxpRFQ+O61FO7/rfiQzCxW9VQdffBPriL9J4V2yiJFgI4XJPAKxM
   b5izoPHlbNmg8yszihIOBZ+9juUeu3wUp+J7ZYGr7dPDoY9LOVXekfYJz
   xLU/EZReKCN2UROPRLIFTeirh9MsXYK8za8vmTr5cAabct927UwKzALdD
   oR/okDLwVFt+l6OdbOAUlpW9vezCNwmuiySoxSZ/ayDop5FPja4zQqJbC
   TGxotghMd5XH5xdPoIkcrkuL3vKMIGEJqL2zk5EeuDkcYcKA1HSNSSLg2
   LMwEk2ekVKjaZQK8fVCHYWZ8JAIhmLJWKMpx2p22C2IMaTWhrHsN3Q3O+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433597611"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="433597611"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:17:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843387044"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="843387044"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:17:50 -0700
Message-ID: <f673c178-b52d-29cc-b337-0d0aa761f101@linux.intel.com>
Date:   Thu, 3 Aug 2023 11:17:49 +0800
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v4 06/12] iommu/vt-d: Set the nested domain to a device
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-7-yi.l.liu@intel.com>
 <BN9PR11MB527652A8EB70FF1FEB0E74308C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527652A8EB70FF1FEB0E74308C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/8/2 15:22, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, July 24, 2023 7:13 PM
>> +
>> +static int intel_nested_attach_dev(struct iommu_domain *domain,
>> +				   struct device *dev)
>> +{
>> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
>> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>> +	struct intel_iommu *iommu = info->iommu;
>> +	unsigned long flags;
>> +	int ret = 0;
>> +
>> +	if (info->domain)
>> +		device_block_translation(dev);
>> +
>> +	if (iommu->agaw < dmar_domain->s2_domain->agaw) {
>> +		dev_err_ratelimited(dev, "Adjusted guest address width not
>> compatible\n");
>> +		return -ENODEV;
>> +	}
> 
> this is the check duplicated with patch04.

Ack. No need for a check here.

> 
>> +
>> +	ret = domain_attach_iommu(dmar_domain, iommu);
>> +	if (ret) {
>> +		dev_err_ratelimited(dev, "Failed to attach domain to
>> iommu\n");
>> +		return ret;
>> +	}
>> +
> 
> [...]
> 
>> +	domain_update_iommu_cap(dmar_domain);
> 
> iommu_cap is already updated in domain_attach_iommu().

Ack. We will eventually remove this helper when every domain is
allocated for a specific device.

>>
>>   static const struct iommu_domain_ops intel_nested_domain_ops = {
>> +	.attach_dev		= intel_nested_attach_dev,
>>   	.free			= intel_nested_domain_free,
>> +	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
> 
> this is not required. enforce_cache_coherency() will be called on parent
> hwpt when it's being created. patch04 should check parent's force_snooping
> to set pgsnp in the pasid entry.
> 
> As Jason explained it should be done only for kernel owned page table.

Ack and thanks!

Best regards,
baolu
