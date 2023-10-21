Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD357D1A9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Oct 2023 05:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjJUD2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Oct 2023 23:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjJUD2L (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Oct 2023 23:28:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D5FD45;
        Fri, 20 Oct 2023 20:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697858885; x=1729394885;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=32+EtMbvgLk9UvTkvk0WlxyRXuH/uvwRvppuv6oh9D8=;
  b=iQ1Lv/BRInrUe/TpYdafg2fyIi9HxuacNXNH1JTBevOkb/KxOxuPG7xQ
   Qw+bvi02QuLkoGp31/zlrX21qC9siJriKqeaUuD9+oIgUlBO8gnHv31LI
   Ke8fBf6H9JGdG0Auss54R2j3PPCWkMI74XLhGxzKMOFb6XGjwTiBWDJpa
   sqG89g39wZTnR/l27cnJN6f3sXqc7CP1jIPhLl3+uehRMiWb0o2czMydZ
   VF2+Gc0V6o4vopYwnC7zubHuZpQJznbrU3zySkzQacmZ/FkALINjkvvvc
   gtDKthLNTW+Ergq/tLBev9V3HmO4r+emHRcrZiKs4ZNvDgj1QOiG93ptU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="5224570"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="5224570"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:28:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="901302865"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="901302865"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga001.fm.intel.com with ESMTP; 20 Oct 2023 20:25:48 -0700
Message-ID: <23133231-c6d7-469e-8f55-2e7667acb097@linux.intel.com>
Date:   Sat, 21 Oct 2023 11:24:15 +0800
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
Subject: Re: [PATCH v6 8/8] iommu/vt-d: Disallow read-only mappings to nest
 parent domain
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com
References: <20231020093246.17015-1-yi.l.liu@intel.com>
 <20231020093246.17015-9-yi.l.liu@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20231020093246.17015-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 10/20/23 5:32 PM, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> When remapping hardware is configured by system software in scalable mode
> as Nested (PGTT=011b) and with PWSNP field Set in the PASID-table-entry,
> it may Set Accessed bit and Dirty bit (and Extended Access bit if enabled)
> in first-stage page-table entries even when second-stage mappings indicate
> that corresponding first-stage page-table is Read-Only.
> 
> As the result, contents of pages designated by VMM as Read-Only can be
> modified by IOMMU via PML5E (PML4E for 4-level tables) access as part of
> address translation process due to DMAs issued by Guest.
> 
> This disallows read-only mappings in the domain that is supposed to be used
> as nested parent. Reference from Sapphire Rapids Specification Update [1],
> errata details, SPR17. Userspace should know this limitation by checking
> the IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 flag reported in the IOMMU_GET_HW_INFO
> ioctl.
> 
> [1] https://www.intel.com/content/www/us/en/content-details/772415/content-details.html
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>   drivers/iommu/intel/iommu.c  |  9 +++++++++
>   drivers/iommu/intel/iommu.h  |  1 +
>   include/uapi/linux/iommufd.h | 12 +++++++++++-
>   3 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c7704e7efd4a..a0341a069fbf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2193,6 +2193,11 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   	if ((prot & (DMA_PTE_READ|DMA_PTE_WRITE)) == 0)
>   		return -EINVAL;
>   
> +	if (!(prot & DMA_PTE_WRITE) && domain->is_nested_parent) {
> +		pr_err_ratelimited("Read-only mapping is disallowed on the domain which serves as the parent in a nested configuration, due to HW errata (ERRATA_772415_SPR17)\n");
> +		return -EINVAL;
> +	}
> +
>   	attr = prot & (DMA_PTE_READ | DMA_PTE_WRITE | DMA_PTE_SNP);
>   	attr |= DMA_FL_PTE_PRESENT;
>   	if (domain->use_first_level) {
> @@ -4101,6 +4106,9 @@ intel_iommu_domain_alloc_user(struct device *dev, u32 flags,
>   		domain = iommu_domain_alloc(dev->bus);
>   		if (!domain)
>   			return ERR_PTR(-ENOMEM);
> +		container_of(domain,
> +			     struct dmar_domain,
> +			     domain)->is_nested_parent = request_nest_parent;

How about
		to_dmar_domain(domain)->is_nested_parent = ...;
?

I would also prefer to introduce is_nested_parent_domain to the user
domain allocation patch (patch 7/8). This field should be checked when
allocating a nested user domain.

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 8f81a5c9fcc0..d3f6bc1f6590 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4121,6 +4121,8 @@ intel_iommu_domain_alloc_user(struct device *dev, 
u32 flags,
                 return ERR_PTR(-EINVAL);
         if (request_nest_parent)
                 return ERR_PTR(-EINVAL);
+       if (!to_dmar_domain(parent)->is_nested_parent)
+               return ERR_PTR(-EINVAL);

         return intel_nested_domain_alloc(parent, user_data);
  }

Best regards,
baolu
