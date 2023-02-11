Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8374692E0E
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 04:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBKDpx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 22:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKDpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 22:45:52 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8F560E46;
        Fri, 10 Feb 2023 19:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676087151; x=1707623151;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XBQR7irgij7HZnD6IBcFSJDQiO8ghGhLDVlW05U2Zw4=;
  b=UIE3/dzMCo4OwJnXK2k67bSpC5ITbh1oH28KTBrantES/k1mNkxZGvgz
   uvuK400yOmzKjfEwb8vGSVdG4z3Q3Pi6T2q8kCz167hwbVb1qBI+jU1NN
   s1xlPLGsfB0Vr8a24b60isoCNrMlvzAB6KNaMf65TCgbkc5QXkqLBrohk
   2Ut3KCjnIxUyL6em4SLGgVz0AbECBfCStKtzV7SYQoAngYJAxlC5L6W+V
   uWSvZmqWvlidS0p1sNC3NXT6IhR9s1UyYwp4wNdsYkM6SbFYexZAOkNJd
   3T/E9qD76HBA5OIgyWrOhjtMAtjfi1PPZD1tvivJDYdtSyDC3Fmzjj+mq
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="329209882"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="329209882"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:45:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="756989518"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="756989518"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:45:46 -0800
Message-ID: <0d24b2c6-1bd4-818c-ce71-ab3bd83ffe3f@linux.intel.com>
Date:   Sat, 11 Feb 2023 11:45:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
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
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
 <BN9PR11MB52763CA91E0D9C0D26000E328CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763CA91E0D9C0D26000E328CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/2/10 15:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:17 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> To support nested translation in the userspace, it should check the
>> underlying hardware information for the capabilities.
> 
> remove this sentence. that belongs to next patch.
> 
>> +
>> +/**
>> + * struct iommu_device_info_vtd - Intel VT-d device info
>> + *
>> + * @flags: Must be set to 0
>> + * @__reserved: Must be 0
>> + * @cap_reg: Value of Intel VT-d capability register defined in chapter
>> + *	     11.4.2 of Intel VT-d spec.
>> + * @ecap_reg: Value of Intel VT-d capability register defined in chapter
>> + *	     11.4.3 of Intel VT-d spec.
> 
> let's be specific with section name e.g. "11.4.2 Capability Register" so if
> the chapter index is changed later people can still know where to look
> at.
> 
>> + *
>> + * Intel hardware iommu capability.
> 
> duplicated with the first line "Intel VT-d device info"

Above all agreed.

Best regards,
baolu

