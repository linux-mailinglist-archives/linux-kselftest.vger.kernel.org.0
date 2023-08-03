Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E652D76DEBF
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjHCDNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjHCDNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:13:24 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C11FD6;
        Wed,  2 Aug 2023 20:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691032403; x=1722568403;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yPbevtCcZpOeTAiAA2lNuyEOiqfa6vas4KxoyVt3mTA=;
  b=l5RMvK6L4EaKVttyVzlCDzc6hv+TSMEJ4huwnIYIjuIWpR+PxYx7iMHm
   zxyQnOR3TzmJ1SffRFpfdrnzQVbcGWtPTtEE+wCZ5iCO+5YYl8ZlrL0C5
   Ufj8jgKDLD9+2O/kNEkyZsl+3WIEn3QhhmfWDZSh7Ui3zH65iqH6zzp8O
   tSMytMw0IEn85BsDz18oDI8AKcKGaisKjX2/hBsPuCkNe+7OeDw2y3AUt
   btQk/I8cMr6fFJ7EpnUiVPh1BHgTux/dR4LB/0bGD1Xgu8Xh9gG8wsvLL
   9v0GawJqnJxPapFuAqrajLAcyswn5ht4eM7QS9wPx2j/l9MoEIk06ptWB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="433597060"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="433597060"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="843385818"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="843385818"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:13:16 -0700
Message-ID: <d57dc99c-4970-fe0f-53f9-ea6f926910ca@linux.intel.com>
Date:   Thu, 3 Aug 2023 11:13:14 +0800
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
Subject: Re: [PATCH v4 04/12] iommu/vt-d: Add helper to setup pasid nested
 translation
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
 <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/8/2 15:10, Tian, Kevin wrote:
>> From: Liu, Yi L<yi.l.liu@intel.com>
>> Sent: Monday, July 24, 2023 7:13 PM
>>   }
>> +
>> +/**
>> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
>> + * This could be used for nested translation based vIOMMU. e.g. guest IOVA
> s/could be/is/

Ack.

> 
>> + * and guest shared virtual address. In this case, the first level page
>> + * tables are used for GVA/GIOVA-GPA translation in the guest, second level
>> + * page tables are used for GPA-HPA translation.
> let's be consistent on using stage-1/stage-2
> 
> btw the convention is to have 1-line summary, then the list of
> parameters followed by detail explanation of the function.
> 

This patch just follows the existing code style in this file. Need a
separated patch to cleanup this.

>> + *
>> + * @iommu:      IOMMU which the device belong to
>> + * @dev:        Device to be set up for translation
>> + * @pasid:      PASID to be programmed in the device PASID table
>> + * @domain:     User stage-1 domain nested on a s2 domain
>> + */
>> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
>> *dev,
>> +			     u32 pasid, struct dmar_domain *domain)
>> +{
>> +	struct iommu_hwpt_vtd_s1 *s1_cfg = &domain->s1_cfg;
>> +	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
>> +	struct dmar_domain *s2_domain = domain->s2_domain;
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	struct dma_pte *pgd = s2_domain->pgd;
>> +	struct pasid_entry *pte;
>> +
>> +	if (!ecap_nest(iommu->ecap)) {
>> +		pr_err_ratelimited("%s: No nested translation support\n",
>> +				   iommu->name);
>> +		return -ENODEV;
>> +	}
> -EINVAL

This is in the attach domain path. -EINVAL has the special meaning of
"this domain is not compatible with iommu for the device".

So here, I still think we should return -ENODEV and the caller doesn't
need to retry anymore.

> 
>> +
>> +	if (s2_domain->agaw > iommu->agaw) {
>> +		pr_err_ratelimited("Incompatible agaw %s\n", iommu-
>>> name);
>> +		return -EINVAL;
>> +	}
> there is a duplicated check in intel_nested_attach_dev().
> 

Yeah, should be removed.

Best regards,
baolu

