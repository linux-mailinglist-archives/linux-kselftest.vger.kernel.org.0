Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3557C7275D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 05:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjFHDiN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 23:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjFHDiM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 23:38:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A5F26A1;
        Wed,  7 Jun 2023 20:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686195491; x=1717731491;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5qPHntbywk3JpKVN534ugygboJcvwxaIHXdHw6nEyFI=;
  b=n44dVgTnzyFlx9Ch8/XktQe94CnfaN+v3IXlNRj2yUlOA2w6uZDypwt4
   v3r1k5ZcvboLXpw9VpyKmv8Ij0iPgD/t5IC7TLQ/ECZ9fgR/PJ66IFgqn
   9W3zklz4U7FI84FtbN+j+4T7EgTY0WYd+0Bk9H+DknIyMq07sl+FuhD1y
   7jlUeiQz7MgJ2DC1jV0CMMVLZGas8XcfdctFmzEgka7CPZL8hNIdaCcMG
   9UwJuDJVLGR0JwB+96De4hru2AdPa5WGgOsX4I+PrL2rvsBM1DbOCI+9e
   6ive0TgMKMAyaEd/qZXUtrMqG2P1BHZyxKaH35p894gafjTVQQSUt2BbQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="341846144"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="341846144"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 20:38:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="779710455"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="779710455"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga004.fm.intel.com with ESMTP; 07 Jun 2023 20:38:05 -0700
Message-ID: <d29829f2-8102-7d53-379b-6f54ac03735c@linux.intel.com>
Date:   Thu, 8 Jun 2023 11:37:05 +0800
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
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-5-yi.l.liu@intel.com>
 <BN9PR11MB5276A52907EDD2155D42B3C08C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <6fbf021b-5f53-0290-d565-f9e765b51f88@linux.intel.com>
 <DS0PR11MB752906AEC0AF9081454A2FFAC350A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752906AEC0AF9081454A2FFAC350A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/8/23 11:35 AM, Liu, Yi L wrote:
>> From: Baolu Lu<baolu.lu@linux.intel.com>
>> Sent: Friday, May 26, 2023 12:16 PM
>> On 5/24/23 3:16 PM, Tian, Kevin wrote:
>>>> From: Yi Liu<yi.l.liu@intel.com>
>>>> Sent: Thursday, May 11, 2023 10:51 PM
>>>>
>>>> +	/*
>>>> +	 * Memory type is only applicable to devices inside processor
>>>> coherent
>>>> +	 * domain. Will add MTS support once coherent devices are available.
>>>> +	 */
>>>> +	if (s1_cfg->flags & IOMMU_VTD_PGTBL_MTS_MASK) {
>>>> +		pr_warn_ratelimited("No memory type support %s\n",
>>>> +				    iommu->name);
>>>> +		return -EINVAL;
>>>> +	}
>>> If it's unsupported why exposing them in the uAPI at this point?
>> Agreed. We can remove this flag for now.
> So we shall remove the below flags in uapi as well, is it?
> 
> +#define IOMMU_VTD_PGTBL_MTS_MASK	(IOMMU_VTD_PGTBL_CD | \
> +					 IOMMU_VTD_PGTBL_EMTE | \
> +					 IOMMU_VTD_PGTBL_PCD | \
> +					 IOMMU_VTD_PGTBL_PWT)

I suppose so.

Best regards,
baolu
