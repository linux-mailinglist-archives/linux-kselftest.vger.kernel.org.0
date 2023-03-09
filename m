Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87466B1904
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Mar 2023 03:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCICGS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 21:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCICGS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 21:06:18 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674D19EF44;
        Wed,  8 Mar 2023 18:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678327577; x=1709863577;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vF2nj2/OYe2VSDrJh0vBQhjBrkwi0KFxwuhhKdnK85E=;
  b=BRKx/i8Gmo8p+0ySYYr0bsBjLInMUNrihzlo0qSb8OpXJJhX4cnll5mJ
   d5Me3a97oHkEakDoVh0bc/05vldV26hU8MnGj5V+kl8/ROZH2J0JyCKQn
   d34DqsRztT4dPFFDk+2s+dmm+wXO26jh2BBNiYJmOXHVb/8yR3zR/4Grb
   Dl6Yg4znCwqJE63YYRl5nZGFXy0YoPyzj5LVIl1Oru6sLZUWlVDimTS6+
   mFGRM1PN/CIXjDLKO1uETNktX0NUJOeumO/HP8CS6DUQLt5z8iBaVWdeu
   0F9/kGvyPt7WzrgeCSFJbF0uUTePDAkcDdg4V2vpTAdGtsZDtKMKjkHn7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="363967266"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="363967266"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 18:06:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="679565192"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="679565192"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga007.fm.intel.com with ESMTP; 08 Mar 2023 18:06:15 -0800
Message-ID: <e0c93191-7cb8-29f2-add6-5e145e767243@linux.intel.com>
Date:   Thu, 9 Mar 2023 10:05:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 09/17] iommufd: Add enforced_cache_coherency to
 iommufd_hw_pagetable_alloc()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> Logically the HWPT should have the coherency set properly for the device
> that it is being created for when it is created.
> 
> This was happening implicitly if the immediate_attach was set because
> iommufd_hw_pagetable_attach() does it as the first thing.
> 
> Do it unconditionally so !immediate_attach works properly.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
