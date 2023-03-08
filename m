Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A47C6B0672
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 12:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCHL4i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 06:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCHL4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 06:56:21 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3251E5F523;
        Wed,  8 Mar 2023 03:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678276576; x=1709812576;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UBfvujX3Iv1nkdf7mtzG3zRFRnM9X/VsZJIweX1gv7k=;
  b=ep0Q6si5JKEfsZew5VY1268wARFarjOYol6juPJFUIMvALcr7nDZKAP5
   LV7pYaVkaT06CZVute837lnbfz287ge8QT+dYdYRF7ENe2NpTi0rz+oBh
   PmAGhHuR8dsy8SqqTan0uN4oz60EseICtcITvdt3yNDDMbiK8NA9QOJJK
   ykFFFKqi/Z2LnnyS7W6EEJAan0udlK2CXRZK6/M4XmZMoDuFTwlPN98cr
   yZgvWj23OBE59dC2deXSntXL4jKqhSaksDvnwkAWX/WeWormH5842oCMv
   No7wrXWQsLzdpCvvumBpaJWd3hspSJARDd82eg0RV+Jo2U0it9zYxTJIt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422403763"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="422403763"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 03:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="820186565"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="820186565"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 03:56:14 -0800
Message-ID: <cdf987df-87b5-0d03-7099-2d8569dcb8cc@linux.intel.com>
Date:   Wed, 8 Mar 2023 19:56:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
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
> The devices list was used as a simple way to avoid having per-group
> information. Now that this seems to be unavoidable, just commit to
> per-group information fully and remove the devices list from the HWPT.
> 
> The iommufd_group stores the currently assigned HWPT for the entire group
> and we can manage the per-device attach/detach with a list in the
> iommufd_group.
> 
> For destruction the flow is organized to make the following patches
> easier, the actual call to iommufd_object_destroy_user() is done at the
> top of the call chain without holding any locks. The HWPT to be destroyed
> is returned out from the locked region to make this possible. Later
> patches create locking that requires this.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
