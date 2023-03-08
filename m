Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070CF6B09C7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 14:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbjCHNso (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjCHNsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 08:48:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695C419B5;
        Wed,  8 Mar 2023 05:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678283309; x=1709819309;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sML0Jp0ngAS0AophUFs7GWR5Tb8f53bTkEbS39Vp9L0=;
  b=molrG+6tL67tPHNUDJKdFybWoTC+NjtoF2dLW7TU0ay5iFTHdWeFu0XK
   yApWmck506WYKmMZ76+wRZDgjmz0Qi6dDVmb/cI5ao+z0C8XP7YJdAiKB
   UTKvGAqWJcO88/Yr/513hyTlt3Dm60UcVKVk5PIYXrcjGwvNohK5Nip9Y
   V3x1eJJT7oazYLphYoKjY+W0pENbRQ8g/wLHI7Wouggyd67RR1pzSm+W2
   Ecx4XV6tO3XO9MDfTsIGG+U2ANRK2z7gtgN6VXFZeyioABNBntkEhrPSN
   ZJccs5Nl7TRc++g6iEZeV7xz05EGtyqvb57F351R+6DCKZ3Waozf78/18
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422423687"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422423687"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:48:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="851089149"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="851089149"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:48:12 -0800
Message-ID: <74bdf564-cdfe-8416-6b20-b4f18d461799@linux.intel.com>
Date:   Wed, 8 Mar 2023 21:48:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 11/17] iommu: Introduce a new
 iommu_group_replace_domain() API
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <11-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <11-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2023/3/8 8:35, Jason Gunthorpe wrote:
> From: Nicolin Chen<nicolinc@nvidia.com>
> 
> qemu has a need to replace the translations associated with a domain
> when the guest does large-scale operations like switching between an
> IDENTITY domain and, say, dma-iommu.c.
> 
> Currently, it does this by replacing all the mappings in a single
> domain, but this is very inefficient and means that domains have to be
> per-device rather than per-translation.
> 
> Provide a high-level API to allow replacements of one domain with
> another. This is similar to a detach/attach cycle except it doesn't
> force the group to go to the blocking domain in-between.
> 
> By removing this forced blocking domain the iommu driver has the
> opportunity to implement a non-disruptive replacement of the domain to the
> greatest extent its hardware allows. This allows the qemu emulation of the
> vIOMMU to be more complete, as real hardware often has a non-distruptive
> replacement capability.
> 
> It could be possible to address this by simply removing the protection
> from the iommu_attach_group(), but it is not so clear if that is safe for
> the few users. Thus, add a new API to serve this new purpose.
> 
> All drivers are already required to support changing between active
> UNMANAGED domains when using their attach_dev ops.
> 
> This API is expected to be used only by IOMMUFD, so add to the iommu-priv
> header and mark it as IOMMUFD_INTERNAL.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
