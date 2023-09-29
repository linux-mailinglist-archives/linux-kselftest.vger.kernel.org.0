Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1697B2A9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 05:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2DhA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 23:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjI2Dg7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 23:36:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104AC19C;
        Thu, 28 Sep 2023 20:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695958617; x=1727494617;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xjoLJw3bXTsWO1tn8Vf7R8FlDJcSY5uHYNKpTGwJjiI=;
  b=WBqgc4zVpi274pGnb0QpXk8x5eq+40MsoWhh18ShelTD6IuR7XcxC8fy
   1ihtr9UomMa/z7iIxBIe7YaR61NGKvDr9hFps6av6nqf6mx36FN/Z6Jdz
   Gcj128erNRcmseyDohSio3RoBJPEPOl7nqnlbT577I8MFTXTATl9BqD40
   xlfLcmEbFHsLGzBKNWho/ruxhWMDz/oVWf6UIoQnzBzTaWUng2LqFOx8/
   ganvDqqqnHzaJ5T9LCxXCcqWDDwXQckg+MyWt/yxn4QOA9L2jqMdkiJ/3
   gl5L0/yeQ6JAJqhmbjlPjxwYvnWrHgqqsxG1qjxbqJoSYN+A76O8G7Q+U
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="361602551"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="361602551"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 20:36:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="893279800"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="893279800"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2023 20:35:39 -0700
Message-ID: <8faa388d-fe64-aa73-fe12-a402d24888a7@linux.intel.com>
Date:   Fri, 29 Sep 2023 11:33:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v2 3/6] iommufd/hw_pagetable: Accepts user flags for
 domain allocation
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230928071528.26258-1-yi.l.liu@intel.com>
 <20230928071528.26258-4-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230928071528.26258-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/28/23 3:15 PM, Yi Liu wrote:
> This extends iommufd_hw_pagetable_alloc() to accepts user flags.
> 
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> Signed-off-by: Yi Liu<yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/device.c          | 2 +-
>   drivers/iommu/iommufd/hw_pagetable.c    | 9 ++++++---
>   drivers/iommu/iommufd/iommufd_private.h | 3 ++-
>   3 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
