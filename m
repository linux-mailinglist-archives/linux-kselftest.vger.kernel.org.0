Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A16B09B8
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 14:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjCHNrF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 08:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjCHNqq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 08:46:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4493D3C09;
        Wed,  8 Mar 2023 05:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678283192; x=1709819192;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cLzqhxsSIHp6ZP19aTukTvTx2N71d5JAOG3jNV7+GK4=;
  b=itCTDGRAA7b0/7DeTpeB3sVXohFtaXzcUkLafIpFiL9Oy4/bBLxKEm2U
   2iGJX0MlwSFt49sXSMYHehwJ/cnHijnny/8SX8f4xwevxjyIeMUmsQ0iZ
   bBWfI2f7WhoxqLP90GnYPhLkFVM0Jh2jZLwJITt6VKS3LeL6AkyC/W5M3
   uPO4k8nqsI1WExlUyp3T5bkfRGzv3yqC/7kSJNV1eRmo/JMpWPAnJb9Ry
   qAjkzsbxuKTs+aqMV5seUIjlcyh3hDyk9fAp71Ci6bUjzsUnaUvZ5FbsF
   GaW8gfYH7H601djUjDUVzzo8p5nk0+fwkPN54p7Kh/DubIoFttYGuikwO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="422423425"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="422423425"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:46:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="800751524"
X-IronPort-AV: E=Sophos;i="5.98,244,1673942400"; 
   d="scan'208";a="800751524"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.254.208.136]) ([10.254.208.136])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 05:46:29 -0800
Message-ID: <61a79971-6dc5-fb03-3fe8-eef1030b5dfb@linux.intel.com>
Date:   Wed, 8 Mar 2023 21:46:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Cc:     baolu.lu@linux.intel.com, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 10/17] iommufd: Reorganize iommufd_device_attach into
 iommufd_device_change_pt
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
        Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
References: <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <10-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
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
> The code flow for first time attaching a PT and replacing a PT is very
> similar except for the lowest do_attach step.
> 
> Reorganize this so that the do_attach step is a function pointer.
> 
> Replace requires destroying the old HWPT once it is replaced. This
> destruction cannot be done under all the locks that are held in the
> function pointer, so the signature allows returning a HWPT which will be
> destroyed by the caller after everything is unlocked.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
