Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4215C76DEFC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 05:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjHCD2I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Aug 2023 23:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjHCD1g (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Aug 2023 23:27:36 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57E420B;
        Wed,  2 Aug 2023 20:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691033230; x=1722569230;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QmXtopTlfod2q44aI/cG9ypI7xSvby98JB+fVs0/xVI=;
  b=ZlGQeNen83frkSPFBy0wBOztIYz0ZIXn5BUAl0A2/fwaTTxr3atKTrYr
   vsPE1AvFxE3SZNlh516JL6wFRbBNPRfpSCks0KHmDypGlcGExs6BGAtsg
   NwHitkjrcNdfAlUj6YWOmPm0mhmYqK1AWaSSnAGmT/KvZsJvxwfiXtXPC
   islc2DGbiWZyUP1VHSpyS+q+ncWuQlq0SU7JsGiwP10mB9F49fX9bAnuz
   74JNeNQj3PmcwnHoJ9yb9t4m2T7UHoFKALxXSzb/4vCFwcKhhghEFsECW
   AI7yEnXsxeHM3QN86ZiJSaG9YSjqbq6CJfDtb9G+Yf5b/AmbqA1HhdmHh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359797827"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="359797827"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:27:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819464846"
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="scan'208";a="819464846"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.255.31.34]) ([10.255.31.34])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 20:27:03 -0700
Message-ID: <b099a333-65b1-de9e-742d-d12f4fb58f67@linux.intel.com>
Date:   Thu, 3 Aug 2023 11:27:01 +0800
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
Subject: Re: [PATCH v4 12/12] iommu/vt-d: Disallow nesting on domains with
 read-only mappings
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-13-yi.l.liu@intel.com>
 <BN9PR11MB52767DF0C8F25AB893B38B678C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52767DF0C8F25AB893B38B678C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/8/2 15:59, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, July 24, 2023 7:14 PM
>>
>> @@ -2147,6 +2148,18 @@ __domain_mapping(struct dmar_domain
>> *domain, unsigned long iov_pfn,
>>   	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
>>   		return -EINVAL;
>>
>> +	if (!(prot & DMA_PTE_WRITE) && !domain->read_only_mapped) {
>> +		spin_lock_irqsave(&domain->lock, flags);
>> +		if (domain->set_nested) {
>> +			pr_err_ratelimited("No read-only mapping
>> permitted\n");
> 
> "Read-only mapping is disallowed on the domain which serves as the
> parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)"

Ack.

> 
>> +	u8 read_only_mapped:1;		/* domain has mappings with
>> read-only
>> +					 * permission.
>> +					 */
>> +	u8 set_nested:1;		/* has other domains nested on it */
> 
> what about "is_parent"?

"is_parent" is still a bit generic. How about "is_nested_parent"?

> 
>>
>> +	spin_lock_irqsave(&s2_dmar_domain->lock, flags);
>> +	if (s2_dmar_domain->read_only_mapped) {
>> +		spin_unlock_irqrestore(&s2_dmar_domain->lock, flags);
>> +		pr_err_ratelimited("S2 domain has read-only mappings\n");
> 
> "Nested configuration is disallowed when the stage-2 domain already
> has read-only mappings, due to HW errata (ERRATA_772415_SPR17)"

Ack.

Best regards,
baolu

