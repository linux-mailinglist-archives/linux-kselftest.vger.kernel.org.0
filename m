Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889B876C806
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 10:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjHBIJn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 04:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjHBIJm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 04:09:42 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABF7F7;
        Wed,  2 Aug 2023 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690963780; x=1722499780;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ki0hcyOchnwZdsu/iCxnKTRMwPrBS92kVd7zfRstuOg=;
  b=cxVOMlp5lw7wiIhi+l2TsXcQLUvpAXL1LIyHIUO2iv+/NDaH74C/Ty6q
   PlZQdQgtTZfdk5KHECDC7jaBWZ4f3tWZhSt1KzDH5RudWyxJ9Fwkg7uWS
   8C5HTtSlYOasoF/GtFqOyb5skzaHLYKnwh6LjRZMY4xc0lI0HPlEFk4NP
   631e9GON1d3KITkuX2EnZrcavN1CthNJcx+Lp/X4h25vrAY4KBTGNEyaU
   Yfs4GrVyVC5Y+m2mn/rwOOHNVo90XHJt6ESq5Vdzoa7P7fqQy22skqxq9
   c7RBvMwUIliQqsiM3Fv64aFtzuXGCXR4LXxWC4e9x23BhU1No/IEgN9PD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359557964"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359557964"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678978681"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="678978681"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.213.137]) ([10.254.213.137])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 01:09:34 -0700
Message-ID: <17e403c0-f2f8-c3d4-9dd0-3a812be79b4a@linux.intel.com>
Date:   Wed, 2 Aug 2023 16:09:32 +0800
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
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-5-yi.l.liu@intel.com>
 <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276C84A20C48B4041BE07B78C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/2 15:10, Tian, Kevin wrote:
>> +
>> +	pasid_set_slptr(pte, virt_to_phys(pgd));
>> +	pasid_set_fault_enable(pte);
>> +	pasid_set_domain_id(pte, did);
>> +	pasid_set_address_width(pte, s2_domain->agaw);
>> +	pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>> +	pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>> +	pasid_set_present(pte);
>> +	spin_unlock(&iommu->lock);
>> +
> this lacks of handling of force_snooping

If stage-2 domain has force_snooping attribute set, then we should set
the bit field in the pasid entry, right?

How about below additional change?

diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index 19ac4084913b..86db81ec91f1 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -827,6 +827,9 @@ int intel_pasid_setup_nested(struct intel_iommu 
*iommu, struct device *dev,
         if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
                 pasid_set_eafe(pte);

+       if (s2_domain>force_snooping)
+               pasid_set_pgsnp(pte);
+
         pasid_set_slptr(pte, virt_to_phys(pgd));
         pasid_set_fault_enable(pte);
         pasid_set_domain_id(pte, did);

Best regards,
baolu
