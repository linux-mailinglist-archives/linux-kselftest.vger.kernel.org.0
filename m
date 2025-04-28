Return-Path: <linux-kselftest+bounces-31749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD52A9E65B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE967A815F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 02:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D881417B418;
	Mon, 28 Apr 2025 02:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dDZBpQq/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECB278F51;
	Mon, 28 Apr 2025 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745808891; cv=none; b=dl8Pz+6UDdHCQxjdwG7ajsYUZWnrVSsGCOyLz9r6O3cdpgqW8oGkGGKRHyxBV1WsbSvwheFbSYzaN9FMmR5Rbh///5fZSdGlcAaK3AsljgNgSCr0arcOE8tJLmnGQvJYauuvM0eURHsj6fl///rRECp10bVjf7glqO8YnLLF9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745808891; c=relaxed/simple;
	bh=8UmPPcYF02m42D0X2SqZC95wLkwf70+0LBSPOHRvYHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AX/vaOchfY77SrTZW0bveZ9nkKhEZ4vCztdO+ZoPRsIYekO3WS1CZhG9VBAqXQIHyLycBOEbbyTU1wAzBDcMIH5e0VPfVsfsOKQ4CvQ1DtlVNbcjKZ8a0R0IHkelMlEI6mKFP8s/NtHBkgG9vN66wvxUhoFAqGDJHa8ddSXtyOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dDZBpQq/; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745808889; x=1777344889;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8UmPPcYF02m42D0X2SqZC95wLkwf70+0LBSPOHRvYHs=;
  b=dDZBpQq/PKKneUvivkfpooKtszHrCBTMZ6+xEBzNeOs4QV25b2GJiimP
   Xy2VmrvHu1imxey68SY5xpZe3Ltp1ufqHJ59URIstSi/+gCsQnGf8Z5Ea
   sU4SMzzBMSvsThPwFwxiB9HUPuGeFOhHgyLp/HNjACwA3exG4MLOow1k1
   TvflDmpoxQ/VjpcFbjvhCLKtG1ot2nIKSQ/LhPtVI46i9SIEUnN4EGs8K
   HWLbpu+q5seRwfuBS1TyqvNBSboOJXIItg2ygXEXb1aUOzDR10kQ5G7fR
   odmQoIA+8cW+OnZvDvJ/J08v2as/8N0L6PcaeMxYL3ezXai6NujyvIGMS
   A==;
X-CSE-ConnectionGUID: k6P2DSigSySBOPgdkZc/Vg==
X-CSE-MsgGUID: f9E9fVfGSfmCesjsD6/LgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="51191806"
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="51191806"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 19:54:49 -0700
X-CSE-ConnectionGUID: +mY80rqWTlmDXdkEN10FGw==
X-CSE-MsgGUID: I+oqtZWeS3+OR7W5/JQ1Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,245,1739865600"; 
   d="scan'208";a="133277233"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2025 19:54:42 -0700
Message-ID: <c4d03b52-422e-41ab-845b-1d2eda7ca9e2@linux.intel.com>
Date: Mon, 28 Apr 2025 10:50:32 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/26/25 13:58, Nicolin Chen wrote:
> For vIOMMU passing through HW resources to user space (VMs), add an mmap
> infrastructure to map a region of hardware MMIO pages.
> 
> Maintain an mt_mmap per ictx for validations. To allow IOMMU drivers to
> add and delete mmappable regions to/from the mt_mmap, add a pair of new
> helpers: iommufd_ctx_alloc_mmap() and iommufd_ctx_free_mmap().

I am wondering why the dma_buf mechanism isn't used here, considering
that this also involves an export and import pattern.

> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/iommufd_private.h |  8 +++++
>   include/linux/iommufd.h                 | 15 ++++++++++
>   drivers/iommu/iommufd/driver.c          | 39 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/main.c            | 39 +++++++++++++++++++++++++
>   4 files changed, 101 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index b974c207ae8a..db5b62ec4abb 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -7,6 +7,7 @@
>   #include <linux/iommu.h>
>   #include <linux/iommufd.h>
>   #include <linux/iova_bitmap.h>
> +#include <linux/maple_tree.h>
>   #include <linux/rwsem.h>
>   #include <linux/uaccess.h>
>   #include <linux/xarray.h>
> @@ -44,6 +45,7 @@ struct iommufd_ctx {
>   	struct xarray groups;
>   	wait_queue_head_t destroy_wait;
>   	struct rw_semaphore ioas_creation_lock;
> +	struct maple_tree mt_mmap;
>   
>   	struct mutex sw_msi_lock;
>   	struct list_head sw_msi_list;
> @@ -55,6 +57,12 @@ struct iommufd_ctx {
>   	struct iommufd_ioas *vfio_ioas;
>   };
>   
> +/* Entry for iommufd_ctx::mt_mmap */
> +struct iommufd_mmap {
> +	unsigned long pfn_start;
> +	unsigned long pfn_end;
> +};

This structure is introduced to represent a mappable/mapped region,
right? It would be better to add comments specifying whether the start
and end are inclusive or exclusive.

> +
>   /*
>    * The IOVA to PFN map. The map automatically copies the PFNs into multiple
>    * domains and permits sharing of PFNs between io_pagetable instances. This
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 5dff154e8ce1..d63e2d91be0d 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -236,6 +236,9 @@ int iommufd_object_depend(struct iommufd_object *obj_dependent,
>   			  struct iommufd_object *obj_depended);
>   void iommufd_object_undepend(struct iommufd_object *obj_dependent,
>   			     struct iommufd_object *obj_depended);
> +int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
> +			   size_t size, unsigned long *immap_id);
> +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id);
>   struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>   				       unsigned long vdev_id);
>   int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> @@ -262,11 +265,23 @@ static inline int iommufd_object_depend(struct iommufd_object *obj_dependent,
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx,
> +					 phys_addr_t base, size_t size,
> +					 unsigned long *immap_id)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline void iommufd_object_undepend(struct iommufd_object *obj_dependent,
>   					   struct iommufd_object *obj_depended)
>   {
>   }
>   
> +static inline void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx,
> +					 unsigned long immap_id)
> +{
> +}
> +
>   static inline struct device *
>   iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
>   {
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index fb7f8fe40f95..c55336c580dc 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -78,6 +78,45 @@ void iommufd_object_undepend(struct iommufd_object *obj_dependent,
>   }
>   EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
>   
> +/* Driver should report the output @immap_id to user space for mmap() syscall */
> +int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
> +			   size_t size, unsigned long *immap_id)
> +{
> +	struct iommufd_mmap *immap;
> +	int rc;
> +
> +	if (WARN_ON_ONCE(!immap_id))
> +		return -EINVAL;
> +	if (base & ~PAGE_MASK)
> +		return -EINVAL;

Is it equal to PAGE_ALIGNED()?

> +	if (!size || size & ~PAGE_MASK)
> +		return -EINVAL;
> +
> +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> +	if (!immap)
> +		return -ENOMEM;
> +	immap->pfn_start = base >> PAGE_SHIFT;
> +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> +
> +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> +			       0, LONG_MAX >> PAGE_SHIFT, GFP_KERNEL);
> +	if (rc < 0) {
> +		kfree(immap);
> +		return rc;
> +	}
> +
> +	/* mmap() syscall will right-shift the immap_id to vma->vm_pgoff */
> +	*immap_id <<= PAGE_SHIFT;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_alloc_mmap, "IOMMUFD");
> +
> +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> +{
> +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));

MMIO lifecycle question: what happens if a region is removed from the
maple tree (and is therefore no longer mappable), but is still mapped
and in use by userspace?

> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_free_mmap, "IOMMUFD");
> +
>   /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
>   struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>   				       unsigned long vdev_id)

Thanks,
baolu

