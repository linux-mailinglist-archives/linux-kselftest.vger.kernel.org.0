Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4389D711EB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 May 2023 06:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjEZERT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 May 2023 00:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEZERS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 May 2023 00:17:18 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E6C13D;
        Thu, 25 May 2023 21:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685074636; x=1716610636;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KTmg2I4nPEC6foToIemOJIAAg3gx3UcD2Tt+b4elk9M=;
  b=cvJ+g1VcpXu8THlrxq8uLIahT97LKxeg0sFtb/f/Noei5aeRJ9bwq7CI
   4abvwxjof7ZAxhPstRjagjwI7lH71+lPVA3NQYVslFKhPhvG16C6WzWgl
   FGp/XZGF153ky2KdwNALFT4QSyneCsg6RaSU8AQyDIDQJGKdyeO+XZKnn
   HedJCYmLbgO7SRwtxlBM+g3ePVuTKXTdxW85nYQjfLYQ+DOlPdOq9GAHr
   iQ9sbAEgL5sxxx9FL+L7o6E/BYTkm1QHeFYkhT+hDtXrh2xC3vgV/cCXx
   Lk4ghRF2IMqdrlI5tln5SYLYKgC/ruKEJodAwzBeW5wRHBNfu+AnybF3l
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="351621968"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="351621968"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 21:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="951736116"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; 
   d="scan'208";a="951736116"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga006.fm.intel.com with ESMTP; 25 May 2023 21:17:11 -0700
Message-ID: <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
Date:   Fri, 26 May 2023 12:16:24 +0800
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v3 04/10] iommu/vt-d: Add helper to setup pasid nested
 translation
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
 <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/24/23 3:16 PM, Tian, Kevin wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>> Sent: Thursday, May 11, 2023 10:51 PM
>>
>> +
>> +/**
>> + * intel_pasid_setup_nested() - Set up PASID entry for nested translation.
>> + * This could be used for guest shared virtual address. In this case, the
>> + * first level page tables are used for GVA-GPA translation in the guest,
>> + * second level page tables are used for GPA-HPA translation.
> 
> it's not just for guest SVA. Actually in this series it's RID_PASID nested
> translation.

Yes.

>> + *
>> + * @iommu:      IOMMU which the device belong to
>> + * @dev:        Device to be set up for translation
>> + * @pasid:      PASID to be programmed in the device PASID table
>> + * @domain:     User domain nested on a s2 domain
> 
> "User stage-1 domain"

Yes.

>> + */
>> +int intel_pasid_setup_nested(struct intel_iommu *iommu, struct device
>> *dev,
>> +			     u32 pasid, struct dmar_domain *domain)
>> +{
>> +	struct iommu_hwpt_intel_vtd *s1_cfg = &domain->s1_cfg;
>> +	pgd_t *s1_gpgd = (pgd_t *)(uintptr_t)domain->s1_pgtbl;
>> +	struct dmar_domain *s2_domain = domain->s2_domain;
>> +	u16 did = domain_id_iommu(domain, iommu);
>> +	struct dma_pte *pgd = s2_domain->pgd;
>> +	struct pasid_entry *pte;
>> +	int agaw;
>> +
>> +	if (!ecap_nest(iommu->ecap)) {
>> +		pr_err_ratelimited("%s: No nested translation support\n",
>> +				   iommu->name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	/*
>> +	 * Sanity checking performed by caller to make sure address width
> 
> "by caller"? it's checked in this function.

This comment need to be updated.

>> +	 * matching in two dimensions: CPU vs. IOMMU, guest vs. host.
>> +	 */
>> +	switch (s1_cfg->addr_width) {
>> +	case ADDR_WIDTH_4LEVEL:
>> +		break;
>> +#ifdef CONFIG_X86
>> +	case ADDR_WIDTH_5LEVEL:
>> +		if (!cpu_feature_enabled(X86_FEATURE_LA57) ||
>> +		    !cap_fl5lp_support(iommu->cap)) {
>> +			dev_err_ratelimited(dev,
>> +					    "5-level paging not supported\n");
>> +			return -EINVAL;
>> +		}
>> +		break;
>> +#endif
>> +	default:
>> +		dev_err_ratelimited(dev, "Invalid guest address width %d\n",
>> +				    s1_cfg->addr_width);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_SRE) && !ecap_srs(iommu-
>>> ecap)) {
>> +		pr_err_ratelimited("No supervisor request support on %s\n",
>> +				   iommu->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if ((s1_cfg->flags & IOMMU_VTD_PGTBL_EAFE)
>> && !ecap_eafs(iommu->ecap)) {
>> +		pr_err_ratelimited("No extended access flag support
>> on %s\n",
>> +				   iommu->name);
>> +		return -EINVAL;
>> +	}
>> +
>> +	/*
>> +	 * Memory type is only applicable to devices inside processor
>> coherent
>> +	 * domain. Will add MTS support once coherent devices are available.
>> +	 */
>> +	if (s1_cfg->flags & IOMMU_VTD_PGTBL_MTS_MASK) {
>> +		pr_warn_ratelimited("No memory type support %s\n",
>> +				    iommu->name);
>> +		return -EINVAL;
>> +	}
> 
> If it's unsupported why exposing them in the uAPI at this point?

Agreed. We can remove this flag for now.

>> +
>> +	agaw = iommu_skip_agaw(s2_domain, iommu, &pgd);
>> +	if (agaw < 0) {
>> +		dev_err_ratelimited(dev, "Invalid domain page table\n");
>> +		return -EINVAL;
>> +	}
> 
> this looks problematic.
> 
> static inline int iommu_skip_agaw(struct dmar_domain *domain,
>                                    struct intel_iommu *iommu,
>                                    struct dma_pte **pgd)
> {
> 	int agaw;
> 
> 	for (agaw = domain->agaw; agaw > iommu->agaw; agaw--) {
> 		*pgd = phys_to_virt(dma_pte_addr(*pgd));
> 		if (!dma_pte_present(*pgd))
> 			return -EINVAL;
> 	}
> 
> 	return agaw;
> }
> 
> why is it safe to change pgd level of s2 domain when it's used as
> the parent? this s2 pgtbl might be used by other devices behind
> other iommus which already maps GPAs in a level which this
> iommu doesn't support...
> 
> shouldn't we simply fail it as another incompatible condition?

You are right. We can change it to this:

	if (domain->agaw > iommu->agaw)
		return -EINVAL;

> 
>> +
>> +	/* First level PGD (in GPA) must be supported by the second level. */
>> +	if ((uintptr_t)s1_gpgd > (1ULL << s2_domain->gaw)) {
>> +		dev_err_ratelimited(dev,
>> +				    "Guest PGD %lx not supported,
>> max %llx\n",
>> +				    (uintptr_t)s1_gpgd, s2_domain-
>>> max_addr);
>> +		return -EINVAL;
>> +	}
> 
> I'm not sure how useful this check is. Even if the pgd is sane the
> lower level PTEs could include unsupported GPA's. If a guest really
> doesn't want to follow the GPA restriction which vIOMMU reports,
> it can easily cause IOMMU fault in many ways.

You are right.

> Then why treating pgd specially?

I have no memory about this check for now. Yi, any thought?

Best regards,
baolu
