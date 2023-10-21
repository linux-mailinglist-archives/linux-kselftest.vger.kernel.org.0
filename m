Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488637D1AA4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Oct 2023 05:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJUDdp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 23:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUDdo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 23:33:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB46D76;
        Fri, 20 Oct 2023 20:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697859220; x=1729395220;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zcdqHYQWFyvsNVnfPxTOb64x44qJuCf6D3wSldjPzF8=;
  b=gctITkrv6fcDNd7ZKsXbL8tIukkHIJsqAPgmHlvTg5QK87VLvRrhKGpv
   xQXaUaV+MCXFMtZSpCkmIdrht6w483OaAye2TcYRCPBj3dzThA0jiQK/j
   fKZ8c6YcogUHwltDdHKr4Vc9+uWG0XmJBTis6tgVvT5p9dNZADCsUz7oe
   ObStl3vm8/36zKLYhJqqFYnT4T7Ah4wk02vDIlyiVKVOEhZ5/R0a53xzI
   o3PApw73Yf9arIm9Td9bpOpiM2RK/foOVcKqn4mrndU8mJeCp6WN+cptT
   DdZy4SqPR1EkgHfYFWSlamerfeRIfoQzle+PLS2XkMtRH7pGcF56wii6D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="8165903"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="8165903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:33:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="848267523"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="848267523"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Oct 2023 20:33:33 -0700
Message-ID: <2b2fce1f-d44b-4988-a214-5d368a85b336@linux.intel.com>
Date:   Sat, 21 Oct 2023 11:29:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     baolu.lu@linux.intel.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com,
        xin.zeng@intel.com
Subject: Re: [PATCH v6 2/3] iommu/vt-d: Make iotlb flush helpers to be extern
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20231020093719.18725-1-yi.l.liu@intel.com>
 <20231020093719.18725-3-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231020093719.18725-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/23 5:37 PM, Yi Liu wrote:
> This makes the helpers visible to nested.c.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c | 10 +++++-----
>   drivers/iommu/intel/iommu.h |  6 ++++++
>   2 files changed, 11 insertions(+), 5 deletions(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
