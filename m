Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292967C860F
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Oct 2023 14:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjJMMse (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 13 Oct 2023 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMMsd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 13 Oct 2023 08:48:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4403EBD;
        Fri, 13 Oct 2023 05:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697201312; x=1728737312;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6iMpv2UTySZaEAYqtKN2xhPIH1oWxAEbKNCY7/VQAbU=;
  b=WNQi1vR6MPq/QtYAWVbC4+8731puk+NTl5hPI30g6DfjuvPCAu6Ypn6+
   363rKuN2iHMAOjcYFvm/aL6h3Z3UEWqmgjXLZVY55H1eF5ejf6KabQitr
   36J+tMIYdmwjVo+lEPksZINurU9LDHRUcJWmhf2MeX7KT4XsxIXeIRhNe
   mDY0WOV+5jLM8MvXL+5KPDPUY+Cf0EtVcoYavbhcdZRsK8/jzAyuBFTsM
   RH0EMSz8W1IX/tei86EQ4igzwv/JPC0lcp6gc3EYHpNh1Agn+dfZiLX9c
   lUB0z/B/I21pwUgRiteTigcmKP0Ms4lYnEPHow6915ZIYE68W1qSQtIsn
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="385012422"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="385012422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="820620478"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="820620478"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.170.232]) ([10.249.170.232])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 05:48:22 -0700
Message-ID: <a4c2402f-fc81-ff54-7c5b-606fa14405e2@linux.intel.com>
Date:   Fri, 13 Oct 2023 20:48:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
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
        "Martins, Joao" <joao.m.martins@oracle.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v5 04/11] iommu/vt-d: Add helper to setup pasid nested
 translation
To:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230921075431.125239-1-yi.l.liu@intel.com>
 <20230921075431.125239-5-yi.l.liu@intel.com>
 <BN9PR11MB5276DD2D6E5690F8FC7B18378CC2A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8974035d-9f9c-e209-79d6-8e3c6402e516@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8974035d-9f9c-e209-79d6-8e3c6402e516@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/13 20:40, Yi Liu wrote:
>>
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if ((s1_cfg->flags & IOMMU_VTD_S1_SRE) && !ecap_srs(iommu-
>>>> ecap)) {
>>> +        pr_err_ratelimited("No supervisor request support on %s\n",
>>> +                   iommu->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    if ((s1_cfg->flags & IOMMU_VTD_S1_EAFE) && !ecap_eafs(iommu-
>>>> ecap)) {
>>> +        pr_err_ratelimited("No extended access flag support
>>> on %s\n",
>>> +                   iommu->name);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    spin_lock(&iommu->lock);
>>> +    pte = intel_pasid_get_entry(dev, pasid);
>>> +    if (!pte) {
>>> +        spin_unlock(&iommu->lock);
>>> +        return -ENODEV;
>>> +    }
>>> +    if (pasid_pte_is_present(pte)) {
>>> +        spin_unlock(&iommu->lock);
>>> +        return -EBUSY;
>>> +    }
>>> +
>>> +    pasid_clear_entry(pte);
>>> +
>>> +    if (s1_cfg->addr_width == ADDR_WIDTH_5LEVEL)
>>> +        pasid_set_flpm(pte, 1);
>>> +
>>> +    pasid_set_flptr(pte, (uintptr_t)s1_gpgd);
>>> +
>>> +    if (s1_cfg->flags & IOMMU_VTD_S1_SRE) {
>>> +        pasid_set_sre(pte);
>>> +        if (s1_cfg->flags & IOMMU_VTD_S1_WPE)
>>> +            pasid_set_wpe(pte);
>>> +    }
>>> +
>>> +    if (s1_cfg->flags & IOMMU_VTD_S1_EAFE)
>>> +        pasid_set_eafe(pte);
>>> +
>>> +    if (s2_domain->force_snooping)
>>> +        pasid_set_pgsnp(pte);
>>> +
>>> +    pasid_set_slptr(pte, virt_to_phys(pgd));
>>> +    pasid_set_fault_enable(pte);
>>> +    pasid_set_domain_id(pte, did);
>>> +    pasid_set_address_width(pte, s2_domain->agaw);
>>> +    pasid_set_page_snoop(pte, !!ecap_smpwc(iommu->ecap));
>>> +    pasid_set_translation_type(pte, PASID_ENTRY_PGTT_NESTED);
>>> +    pasid_set_present(pte);
>>> +    spin_unlock(&iommu->lock);
>>
>> All changes within iommu->lock are specific to the device specific
>> PASID entry. Probably this is one potential cleanup TODO to
>> use a per-device lock instead.
> 
> yeah, a separate cleanup. is it, @Baolu?

Sure. I'd like to take some time to consider this further. Please keep
it as-is for the time being.

Best regards,
baolu
