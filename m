Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA157D363A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Oct 2023 14:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjJWMSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Oct 2023 08:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWMST (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Oct 2023 08:18:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96DFD;
        Mon, 23 Oct 2023 05:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698063497; x=1729599497;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ER/XKUMDi6yIOgyLhD9h2AQXUmEiCID1DQSal1iAvEQ=;
  b=G6H3/aChEXL/Pxf7m+vpobEZxpDhZtQdkTlffHkKPj8KbvZjafEJBshT
   qOs/1S2BhwVLg9IakokaoIhKFnpNZDlk0wxO6ZYfy0rQ/HgFH+lJik2w8
   HyjAebYBRBty5f1jJz46fUayBA6+FaqaG1VUy1HtcuLx+MQ/kycPmBkiI
   o1bVHCfvTswL0VMuAtnPaOlir31kHkVPMIIItmS9nrIO4DMilIqlWNOix
   UHmw/bSE/XhHS28YbcJWWBgdUhy4wNGCK9QqK++r1+/NR70Ragowr5fyC
   LQ4fNrX2wMWRnyBAxFPdTq+KHmOhJALFIwG/VDFRHtdXoKL4GpH71aEOW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="473040356"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="473040356"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:18:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734649672"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="734649672"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.211.100]) ([10.254.211.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 05:18:10 -0700
Message-ID: <f041d424-ade2-4959-a677-01e3d7dd699b@linux.intel.com>
Date:   Mon, 23 Oct 2023 20:18:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
        "Zeng, Xin" <xin.zeng@intel.com>
Subject: Re: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-9-yi.l.liu@intel.com>
 <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
 <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752977275A0791296C115FE6C3D8A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/10/23 19:15, Liu, Yi L wrote:
>> I would also prefer to introduce is_nested_parent_domain to the user
>> domain allocation patch (patch 7/8). This field should be checked when
>> allocating a nested user domain.
> A ctually, no need. This should be a common check, so iommufd core already
> has the check. So the parent should be a nest parent domain, otherwise already
> returned in iommufd.
> 
> +	if (!parent->nest_parent)
> +		return ERR_PTR(-EINVAL);

I know this will not cause errors in the code. But since you are
introducing is_parent property in the vt-d driver. The integrity of the
property should be ensured. In this way, it will make the code more
readable and maintainable.

Best regards,
baolu
