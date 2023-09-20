Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C37A71C3
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 07:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjITFIf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 01:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjITFIf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 01:08:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94468AB;
        Tue, 19 Sep 2023 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695186509; x=1726722509;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1+jAS6yHwzuVm+ydois1vVDLifWQ2vZ5OOkmlSpSb0I=;
  b=WP3BDN/6fuxDUPw55b/SOI0Qw++nHZ7za2U5hNWWgn2A2b4CT48PhgwG
   O89mFVIyGUqSt8EokOEPpXs5urck0Wt1VrPNMjtE8OCqIirYX2/uo4GX9
   1RelsLBN8o6tZDE9nnkYxQixOrimJkwxlkFMW1bMDZFnG7FQuFqm9kNcE
   PlSBM9jybRCjzqBIF50vsE2eMUni/VVCUDf0bh5IaOuc4/irebxWd9hRc
   zYw620G5ffSDm62ZxvHLQECZKlIkMtzbbCe6ybyaEXflMiL8/KIpLLovK
   teG86QZ5C63rwNcfAZYPEgGLBbG1Y9xV1L+DQ94oVE2yv/J7G9bxIdmmV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="377434407"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="377434407"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 22:08:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10838"; a="781556740"
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="scan'208";a="781556740"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga001.jf.intel.com with ESMTP; 19 Sep 2023 22:08:22 -0700
Message-ID: <7d07bea9-02a5-7113-8cc1-f7aed073cf96@linux.intel.com>
Date:   Wed, 20 Sep 2023 13:05:15 +0800
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
Subject: Re: [PATCH 4/6] iommufd/hw_pagetable: Support allocating nested
 parent domain
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20230919092523.39286-1-yi.l.liu@intel.com>
 <20230919092523.39286-5-yi.l.liu@intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230919092523.39286-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/19/23 5:25 PM, Yi Liu wrote:
> This extends IOMMU_HWPT_ALLOC to allocate domains used as parent (stage-2)
> in nested translation.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/iommufd/hw_pagetable.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index 5be7a31cbd9c..26a8a818ffa3 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -83,6 +83,9 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>   
>   	lockdep_assert_held(&ioas->mutex);
>   
> +	if ((flags & IOMMU_HWPT_ALLOC_NEST_PARENT) && !ops->domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>   	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
>   	if (IS_ERR(hwpt))
>   		return hwpt;
> @@ -154,7 +157,7 @@ int iommufd_hwpt_alloc(struct iommufd_ucmd *ucmd)
>   	struct iommufd_ioas *ioas;
>   	int rc;
>   
> -	if (cmd->flags || cmd->__reserved)
> +	if (cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT || cmd->__reserved)
>   		return -EOPNOTSUPP;

Need a parenthesis here, otherwise the compiler will interpret it as a
different condition.

	if ((cmd->flags & ~IOMMU_HWPT_ALLOC_NEST_PARENT) || cmd->__reserved)
		return -EOPNOTSUPP;

Best regards,
baolu
