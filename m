Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF73727996
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jun 2023 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjFHIHt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFHIHs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 04:07:48 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA7198B;
        Thu,  8 Jun 2023 01:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211667; x=1717747667;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dSAQH3qaMfODUo4p93PDtwLS0FxoeEOyJbm4yEGJPzE=;
  b=UxfRQO9lj140d8Nz8e5TGHhIJBu8n+R9szh7rWE09AvEBdf+YB5zLCfN
   qQiVCyQu4by5Pai4BXLHRvRAjZsuadu4n2DhSxlUWNEUV43lV64lK1fRK
   TgLf/xK65gLePGaP4h8UA+qZJEyZiFHZMPGNKn5QurCnmmGnSZmaFZ2Us
   +G4485g5aB83JGnIza1NHfdBjUUzUHB6/BqabbCM+Z7ux82bL1fV4SknB
   nWI/2Ay5HFHmwl0laYn04EF4mKdzybBbO35yreyG5CU/V6Dg0tbpxMIBW
   6BvhXiCFxTeK5pfhXzORFKb80Cycx4uUdg8OLFLwlh0oVElw5/4OcIdQ4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="356097232"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="356097232"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="687295041"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="687295041"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.210.30]) ([10.254.210.30])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:07:36 -0700
Message-ID: <097a2abf-e817-99ca-1f31-dbd439aaade8@linux.intel.com>
Date:   Thu, 8 Jun 2023 16:07:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
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
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 07/10] iommu/vt-d: Add iotlb flush for nested domain
To:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <20230511145110.27707-8-yi.l.liu@intel.com>
 <BN9PR11MB52768C95F6E9B943066F39218C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DS0PR11MB752919431F624E8E3EFE1C38C350A@DS0PR11MB7529.namprd11.prod.outlook.com>
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

On 2023/6/8 15:14, Liu, Yi L wrote:
>>> + *                                              stage-1 page table cache
>>> + *                                              invalidation
>>> + * @IOMMU_VTD_QI_FLAGS_LEAF: The LEAF flag indicates whether only the
>>> + *                           leaf PTE caching needs to be invalidated
>>> + *                           and other paging structure caches can be
>>> + *                           preserved.
>>> + */
>> what about "Drain Reads" and "Drain Writes"? Is the user allowed/required
>> to provide those hints?
> All other comments got. For these two hints, the two flags are from the IOTLB
> Invalidation descriptor. Per below description, the hardware that supports nested
> should support drain and does not require software to ask for it. So it appears no
> need to define them in uapi.
> 
> "Hardware implementation with Major Version 2 or higher (VER_REG),
> always performs required drain without software explicitly requesting
> a drain in IOTLB invalidation. This field is deprecated and hardware
> will always report it as 1 to maintain backward compatibility with
> software"

Make sense. Perhaps we can also remove below code in
__iommu_flush_iotlb():

         /* Note: set drain read/write */
#if 0
         /*
          * This is probably to be super secure.. Looks like we can
          * ignore it without any impact.
          */
         if (cap_read_drain(iommu->cap))
                 val |= DMA_TLB_READ_DRAIN;
#endif

Best regards,
baolu
