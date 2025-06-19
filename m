Return-Path: <linux-kselftest+bounces-35359-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F43EAE0338
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A654D7ADF5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Jun 2025 11:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ADC22686B;
	Thu, 19 Jun 2025 11:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekOQ/lB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F9E222577
	for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 11:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750331771; cv=none; b=u+C0cJMfM7LSOJDMWqkjJegXtYN+5Sy7a9nrFFd04luOuD6ESlKcwz5aiSwYW29WWBVbttOpNzBGQYqXOkoqKxrCG9ByWpS1lTvZmlOE9c8HM1zDYicdLbgaWlZN/Lk06cWGBlOy+2pywPD0hgFSPy99TI8xorKLuNE8jYIwiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750331771; c=relaxed/simple;
	bh=JNzJ+ikVlKEZOEeS2Nkj64WAcOodHqRpXfrd0eO7bg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXUPcQ4+4DJxV/FhahfMFqxRs+tllvV1BMr8NwJHIYoYA2lDlwE4KXvIp2Eb0BNSKhqqSmehRyH41LKhz0EEQ6zMrCXs1NsH9MAINTZwW1Wmc5/Gi3/zOJT5cG3twd1O6HcfFmCSl0k8rqLSoVrnNBB/ZesWzyVn5hGYvfpIQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekOQ/lB5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-235e389599fso173695ad.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Jun 2025 04:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750331769; x=1750936569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J0K5kka6ny6/IX+friUQkiPa7P6oG70XusQAK8iDSEg=;
        b=ekOQ/lB5aTNETw/+LHIvFJamb1ZaoMp+VOW+YpUzL1s1Xv4ey/CNv6QS+B0DjVMXwM
         43QnSNw1q8bWovEx8N0BcKx3/YiiBVvUsQ4vSOQEUwqlmg0roUV8G5gnHuUq5tRsAkiH
         JGjMLt6xNvGKjlwarrrFpWQg4eo+rRVnEplZt7rvPE3lca5rA2o0uE3jQN4VdprtpNh7
         OHSzRosGd+6BP8FJQYgo1Qd936e59S3h4dlOmQ81NzIap7HRf0o6wRVHdJ/wYB5xdp2s
         JjQBKfoSML9i68IX4JcwnPOkpl2aUx0YLM9x2Vvqntaa7X4f3vW5G8ON60q0lyoAbLE6
         DbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750331769; x=1750936569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0K5kka6ny6/IX+friUQkiPa7P6oG70XusQAK8iDSEg=;
        b=U/oVQ2nfvSxnUO+7sz5X0k1UkmY9xr2miTlfkfQHb6H0MgcQpVNJiq2CuCJNPQxLJg
         SPML63S0btQAF/8+dWHwA5td8S0VAiofgvvJ8bYW0Tuu9hm9CgIgU1o5ZxkstoXen65V
         9bdDyAMa9rYKkW1PoQNrgw1vWYhDUD/qTyPX+ZOQ9zXSessHHgcAvlZW+zysnrKtPruB
         SlMN6m6Pl5QDdFx2Nhh643tgigGRV0h0RTSBmDHy/coPEqIOa2Q3k4dHaJIUrY65zRvz
         YUrw5YY/ewiLBtlKypGuesQU6QMsyUDzCfQcboC+l4D3/zobx6hAve/yxP/6wzzARjAC
         Lpdg==
X-Forwarded-Encrypted: i=1; AJvYcCUb8Gv2VRaNs5CiHdnYI4UVgbR98uTaoljQh9W2DXfmNGQiGyUZvgfUAUBkvZY3pHF6xKxXPJ7D1l28nh2l3L4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/AcezQfBwQGv/zBuUXEXERRSc7np/Nw27Qp9wvJeSu9O845bS
	pR2QoGNGCFfX+Xqm4h+q8A/duX9xnfRMNnUee9hJYj6yQbanB1zwp+kEKU3rK9vvRg==
X-Gm-Gg: ASbGncsr2ts6ICxiAsqdU2EFy9o5HcNxaWmqG92fCwSn8tte3AxYTYJFrVj/HoalScE
	vcRgd4tufT3WKPaoYDwtf0mOqdpx8uYArS9fKG7AwvuJdDw8fuzRKBZrsyxTEU9CCbQB8j7uTp2
	NWfvWK9G1kMGpHNf3yrySAFR3zhYg5rSBq82SfkQ/D5RYjH0f6yfZdKocyxxbtbL7ttTGaoaiSz
	H23VrT2deLjo9wUxAPB0opJ30lEup64NcWKxRvXY9mUVYXQy/y26gtUiQO58QLMp+VODKPObhhX
	kYZYJGV2iigqByvY5JFgHH1C05pkZcJdTldFPxOccY+v9S9xipZF6aaE4oMnAa3VwuytoTq1mNB
	IhUWJ3xRjdW3MmpD/n/Js
X-Google-Smtp-Source: AGHT+IGLBsKU5Xvykqrr05mmuSSE5AlVTYBeY0JsehoP0OVQHYRUJcJLrjggBr4O05auamlyHYplKw==
X-Received: by 2002:a17:903:1b64:b0:234:b2bf:e676 with SMTP id d9443c01a7336-237ce039494mr2004475ad.11.1750331769012;
        Thu, 19 Jun 2025 04:16:09 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a3188a3sm1912852a91.36.2025.06.19.04.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 04:16:08 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:15:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
	peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
	zhangzekun11@huawei.com, iommu@lists.linux.dev,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com
Subject: Re: [PATCH v6 13/25] iommufd: Add mmap interface
Message-ID: <aFPxbfDJZzG2EqxQ@google.com>
References: <cover.1749884998.git.nicolinc@nvidia.com>
 <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9929e0c9ec6f3f6348cd0c399d6fdfa9f35f973.1749884998.git.nicolinc@nvidia.com>

On Sat, Jun 14, 2025 at 12:14:38AM -0700, Nicolin Chen wrote:
> For vIOMMU passing through HW resources to user space (VMs), allowing a VM
> to control the passed through HW directly by accessing hardware registers,
> add an mmap infrastructure to map the physical MMIO pages to user space.
> 
> Maintain a maple tree per ictx as a translation table managing mmappable
> regions, from an allocated for-user mmap offset to an iommufd_mmap struct,
> where it stores the real PFN range for an io_remap_pfn_range call.
> 
> Keep track of the lifecycle of the mmappable region by taking refcount of
> its owner, so as to enforce user space to unmap the region first before it
> can destroy its owner object.
> 
> To allow an IOMMU driver to add and delete mmappable regions onto/from the
> maple tree, add iommufd_viommu_alloc/destroy_mmap helpers.
>

The usage of mtree seems fine now, storing pfns ranges as compared to
pointers in v3. Input validation checks, vma checks and destroy op look
good.

Reviewed-by: Pranjal Shrivastava <praan@google.com>

> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h | 14 ++++++
>  include/linux/iommufd.h                 | 42 ++++++++++++++++
>  drivers/iommu/iommufd/driver.c          | 51 ++++++++++++++++++++
>  drivers/iommu/iommufd/main.c            | 64 +++++++++++++++++++++++++
>  4 files changed, 171 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 1bb1c0764bc2..e8192f79fe42 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -7,6 +7,7 @@
>  #include <linux/iommu.h>
>  #include <linux/iommufd.h>
>  #include <linux/iova_bitmap.h>
> +#include <linux/maple_tree.h>
>  #include <linux/rwsem.h>
>  #include <linux/uaccess.h>
>  #include <linux/xarray.h>
> @@ -44,6 +45,7 @@ struct iommufd_ctx {
>  	struct xarray groups;
>  	wait_queue_head_t destroy_wait;
>  	struct rw_semaphore ioas_creation_lock;
> +	struct maple_tree mt_mmap;
>  
>  	struct mutex sw_msi_lock;
>  	struct list_head sw_msi_list;
> @@ -55,6 +57,18 @@ struct iommufd_ctx {
>  	struct iommufd_ioas *vfio_ioas;
>  };
>  
> +/* Entry for iommufd_ctx::mt_mmap */
> +struct iommufd_mmap {
> +	struct iommufd_object *owner;
> +
> +	/* Allocated start position in mt_mmap tree */
> +	unsigned long startp;
> +
> +	/* Physical range for io_remap_pfn_range() */
> +	unsigned long mmio_pfn;
> +	unsigned long num_pfns;
> +};
> +
>  /*
>   * The IOVA to PFN map. The map automatically copies the PFNs into multiple
>   * domains and permits sharing of PFNs between io_pagetable instances. This
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index acf0e8f0c630..0da9bc8f94f3 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -251,6 +251,11 @@ int _iommufd_object_depend(struct iommufd_object *obj_dependent,
>  			   struct iommufd_object *obj_depended);
>  void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
>  			      struct iommufd_object *obj_depended);
> +int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
> +			phys_addr_t mmio_addr, size_t length,
> +			unsigned long *offset);
> +void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
> +			   struct iommufd_object *owner, unsigned long offset);
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id);
>  int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> @@ -271,6 +276,20 @@ _iommufd_object_undepend(struct iommufd_object *obj_dependent,
>  {
>  }
>  
> +static inline int _iommufd_alloc_mmap(struct iommufd_ctx *ictx,
> +				      struct iommufd_object *owner,
> +				      phys_addr_t mmio_addr, size_t length,
> +				      unsigned long *offset)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
> +					 struct iommufd_object *owner,
> +					 unsigned long offset)
> +{
> +}
> +
>  static inline struct device *
>  iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
>  {
> @@ -338,4 +357,27 @@ static inline int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
>  		_iommufd_object_undepend(&dependent->member.obj,               \
>  					 &depended->member.obj);               \
>  	})
> +
> +/*
> + * Helpers for IOMMU driver to alloc/destroy an mmapable area for a structure.
> + *
> + * To support an mmappable MMIO region, kernel driver must first register it to
> + * iommufd core to allocate an @offset, during a driver-structure initialization
> + * (e.g. viommu_init op). Then, it should report to user space this @offset and
> + * the @length of the MMIO region for mmap syscall.
> + */
> +static inline int iommufd_viommu_alloc_mmap(struct iommufd_viommu *viommu,
> +					    phys_addr_t mmio_addr,
> +					    size_t length,
> +					    unsigned long *offset)
> +{
> +	return _iommufd_alloc_mmap(viommu->ictx, &viommu->obj, mmio_addr,
> +				   length, offset);
> +}
> +
> +static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
> +					       unsigned long offset)
> +{
> +	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
> +}
>  #endif
> diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> index 70b7917da0cb..8220b61d8c8d 100644
> --- a/drivers/iommu/iommufd/driver.c
> +++ b/drivers/iommu/iommufd/driver.c
> @@ -31,6 +31,57 @@ void _iommufd_object_undepend(struct iommufd_object *obj_dependent,
>  }
>  EXPORT_SYMBOL_NS_GPL(_iommufd_object_undepend, "IOMMUFD");
>  
> +/*
> + * Allocate an @offset to return to user space to use for an mmap() syscall
> + *
> + * Driver should use a per-structure helper in include/linux/iommufd.h
> + */
> +int _iommufd_alloc_mmap(struct iommufd_ctx *ictx, struct iommufd_object *owner,
> +			phys_addr_t mmio_addr, size_t length,
> +			unsigned long *offset)
> +{
> +	struct iommufd_mmap *immap;
> +	unsigned long startp;
> +	int rc;
> +
> +	if (!PAGE_ALIGNED(mmio_addr))
> +		return -EINVAL;
> +	if (!length || !PAGE_ALIGNED(length))
> +		return -EINVAL;
> +
> +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> +	if (!immap)
> +		return -ENOMEM;
> +	immap->owner = owner;
> +	immap->num_pfns = length >> PAGE_SHIFT;
> +	immap->mmio_pfn = mmio_addr >> PAGE_SHIFT;
> +
> +	rc = mtree_alloc_range(&ictx->mt_mmap, &startp, immap, immap->num_pfns,
> +			       0, U32_MAX >> PAGE_SHIFT, GFP_KERNEL);
> +	if (rc < 0) {
> +		kfree(immap);
> +		return rc;
> +	}
> +
> +	immap->startp = startp;
> +	/* mmap() syscall will right-shift the offset in vma->vm_pgoff */
> +	*offset = startp << PAGE_SHIFT;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(_iommufd_alloc_mmap, "IOMMUFD");
> +
> +/* Driver should use a per-structure helper in include/linux/iommufd.h */
> +void _iommufd_destroy_mmap(struct iommufd_ctx *ictx,
> +			   struct iommufd_object *owner, unsigned long offset)
> +{
> +	struct iommufd_mmap *immap;
> +
> +	immap = mtree_erase(&ictx->mt_mmap, offset >> PAGE_SHIFT);
> +	WARN_ON_ONCE(!immap || immap->owner != owner);
> +	kfree(immap);
> +}
> +EXPORT_SYMBOL_NS_GPL(_iommufd_destroy_mmap, "IOMMUFD");
> +
>  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
>  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
>  				       unsigned long vdev_id)
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 4e8dbbfac890..339a269ebbc8 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -275,6 +275,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
>  	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
>  	xa_init(&ictx->groups);
>  	ictx->file = filp;
> +	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
>  	init_waitqueue_head(&ictx->destroy_wait);
>  	mutex_init(&ictx->sw_msi_lock);
>  	INIT_LIST_HEAD(&ictx->sw_msi_list);
> @@ -479,11 +480,74 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
>  	return ret;
>  }
>  
> +static void iommufd_fops_vma_open(struct vm_area_struct *vma)
> +{
> +	struct iommufd_mmap *immap = vma->vm_private_data;
> +
> +	refcount_inc(&immap->owner->users);
> +}
> +
> +static void iommufd_fops_vma_close(struct vm_area_struct *vma)
> +{
> +	struct iommufd_mmap *immap = vma->vm_private_data;
> +
> +	refcount_dec(&immap->owner->users);
> +}
> +
> +static const struct vm_operations_struct iommufd_vma_ops = {
> +	.open = iommufd_fops_vma_open,
> +	.close = iommufd_fops_vma_close,
> +};
> +
> +/* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
> +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct iommufd_ctx *ictx = filp->private_data;
> +	size_t length = vma->vm_end - vma->vm_start;
> +	struct iommufd_mmap *immap;
> +	int rc;
> +
> +	if (!PAGE_ALIGNED(length))
> +		return -EINVAL;
> +	if (!(vma->vm_flags & VM_SHARED))
> +		return -EINVAL;
> +	if (vma->vm_flags & VM_EXEC)
> +		return -EPERM;
> +
> +	/* vma->vm_pgoff carries an index to an mtree entry (immap) */
> +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> +	if (!immap)
> +		return -ENXIO;
> +	/*
> +	 * mtree_load() returns the immap for any contained pgoff, only allow
> +	 * the immap thing to be mapped
> +	 */
> +	if (vma->vm_pgoff != immap->startp)
> +		return -ENXIO;
> +	if (length != immap->num_pfns << PAGE_SHIFT)
> +		return -ENXIO;
> +
> +	vma->vm_pgoff = 0;
> +	vma->vm_private_data = immap;
> +	vma->vm_ops = &iommufd_vma_ops;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +
> +	rc = io_remap_pfn_range(vma, vma->vm_start, immap->mmio_pfn, length,
> +				vma->vm_page_prot);
> +	if (rc)
> +		return rc;
> +
> +	/* vm_ops.open won't be called for mmap itself. */
> +	refcount_inc(&immap->owner->users);
> +	return rc;
> +}
> +
>  static const struct file_operations iommufd_fops = {
>  	.owner = THIS_MODULE,
>  	.open = iommufd_fops_open,
>  	.release = iommufd_fops_release,
>  	.unlocked_ioctl = iommufd_fops_ioctl,
> +	.mmap = iommufd_fops_mmap,
>  };
>  
>  /**
> -- 
> 2.43.0
> 

