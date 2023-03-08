Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4676AFD51
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 04:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCHDTN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 22:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjCHDTM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 22:19:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2092E99C0E;
        Tue,  7 Mar 2023 19:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678245551; x=1709781551;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HnUh6zuWuK6/JGibCICoiHRkUWu1XWxkLwlxoYZmjKs=;
  b=U37iBepvz6Ipvz3YcTLnbXiMYinJ3XJLXqU+XUqo0jdV69We7+XM4RLn
   AAYIskgsFPOdppD6RuT4lwDTEvSGO1j8T6WIBRxDWQUySR8Rr+QoKy83J
   wT3UQ4Ch+EGcVCd5N/z9skAHK8HBDg87OSw8wjtwpAXxrCKNhojq83yMe
   QxSvZ0FNz205jsfISlJSXLMbAXKcinsS+XbVs1mxUeuOvM8z70MQMVKz6
   mrb0OGfP9a4Z9hv7ur7MHQ3XhGzCcoxgyg5hjXc2eIB0xBPxKMzJIsOPH
   YNmXGma64wL7rYI3pOhJozrWDDGiVmOG1BASZ7fTQk5kGGcFgfFD0m+2/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="315700887"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="315700887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 19:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="1006145193"
X-IronPort-AV: E=Sophos;i="5.98,242,1673942400"; 
   d="scan'208";a="1006145193"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga005.fm.intel.com with ESMTP; 07 Mar 2023 19:19:09 -0800
Message-ID: <3469063c-7ed4-3fda-0280-2cc6b4e6fd98@linux.intel.com>
Date:   Wed, 8 Mar 2023 11:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 02/17] iommufd: Add iommufd_group
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <2-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/8/23 8:35 AM, Jason Gunthorpe wrote:
> When the hwpt to device attachment is fairly static we could get
> away with the simple approach of keeping track of the groups via a
> device list. But with replace this is infeasible.
> 
> Add an automatically managed struct that is 1:1 with the iommu_group
> per-ictx so we can store the necessary tracking information there.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

The iommufd_get_group() helper looks long. I went through it carefully
and didn't find any problems. However, is it possible to add a mutex in
ictx to protect the group array? Can it be simpler?

either way,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
