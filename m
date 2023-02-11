Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E25692D8F
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 04:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBKDQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 22:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjBKDQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 22:16:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485965D1EF;
        Fri, 10 Feb 2023 19:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676085380; x=1707621380;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=baRNMwBAPh/BuSmPIF/k5pXMeSErRmwR427dgjs/qvg=;
  b=mkn2Hx5mENTIqyOPEMhAjpeQ0t99emxuBd8sm4RxKF/uRUf2OqeS0eft
   55GQrVCTX00zohDOABARqturE8//7w0CLTmXXShsoC0r4za+xGwX1l0uQ
   9TWdc8A8Y5Jnt2kIoau8HZY7wEcRxcIfss0fUHmVnQcMUVk+SrMhWUmy/
   jCTu4vHJgcJmMQZX3oTxJUO0yiAHA0iH4K0SqRruA3u+IC3c2BfZGJIxG
   8yUQz/0WGDcq/nMulTGCM4QD32RTDkYWz8+Qy88mgP+eaqDT92rBNeQca
   vEqDq7ICyhz7IBOozTFwiCfKuTE/uXgx5K8Sjyk2fe4HXUbEim2c97QXt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="330586588"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="330586588"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:16:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="645830380"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="645830380"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.168.175]) ([10.249.168.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 19:16:14 -0800
Message-ID: <115a6f87-11e5-5af8-eba2-60305177e554@linux.intel.com>
Date:   Sat, 11 Feb 2023 11:16:12 +0800
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
Subject: Re: [PATCH 01/17] iommu: Add new iommu op to create domains owned by
 userspace
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-2-yi.l.liu@intel.com>
 <BN9PR11MB527618D7F1D260E7A90EDE658CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527618D7F1D260E7A90EDE658CDE9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2023/2/10 16:24, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Thursday, February 9, 2023 12:32 PM
>>
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>
>> Introduce a new iommu_domain op to create domains owned by userspace,
>> e.g. through iommufd. These domains have a few different properties
>> compares to kernel owned domains:
>>
>>   - They may be MANAGED domains, but created with special parameters.
>>     For instance aperture size changes/number of levels, different
>>     IOPTE formats, or other things necessary to make a vIOMMU work
>>
> 
> what is *MANAGED* domain?
> 
> today we only have the separation between DMA domain and
> UNMANAGED domain.
> 
> soon with Jason's cleanup all domains are called UNMANAGED.

It should be UNMANAGED domain.

Best regards,
baolu
