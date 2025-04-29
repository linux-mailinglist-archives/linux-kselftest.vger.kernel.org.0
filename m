Return-Path: <linux-kselftest+bounces-31933-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A046AA1C3F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 710353A885C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E2C264609;
	Tue, 29 Apr 2025 20:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp7HR1Jc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6142625F963
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 20:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745958910; cv=none; b=udxYtuQkXjJ9trYomT5KDcAKfA07OATh/Ne6b1XCuIp4+MTLJiGae27AlzzRl80h7m8lWYUoI+ilmttNOB+mPSIiiquqW0emnN4NGHZCu3mtudG0+OAqSfDxVLZEmyEDKh54hPnF7Ds6uLooK5JJcIfYJYje51UdnDDemgw/f5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745958910; c=relaxed/simple;
	bh=KUcsGFH8M9398sN33tZC6JP6D9lKkag3O+2cOTOCQ0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DpUDKAbtV8PWdPGgivF+iF/bqKWz5rTxgQCyfKMFlmTtHClGCYcLbh7PJWVm0d1zw9VJTwRk4oo+FpMAL5dqvrGcPWutWQvXADbdf/hopAG1bEURanjGW3Ahht+rIWcZDwXDuGUVxGPatv5B/WTR0JqIjhV6tTVTVE0stDpSAvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp7HR1Jc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso71085ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 13:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745958908; x=1746563708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+vD+SO2JAT8G1MZey1yCSiJUKQmZMj4na64WTuCtC9c=;
        b=Zp7HR1Jc3D5K7pCbL0iu07hwmpWMkgd7GSWO/1ny8dhVU58aqcRfFX1MYZ+SW4gLS/
         NMns+NwjyM8rhgKQQLxmuYkmIFH4jC0MBH4aHO1nd3WyH5/oZOO1+QNkHb5gWFZlbGZn
         yIkA1fhdRtvGIEJ7JIGm5LHwBoJz056Pm2/NZ/QqzuFse6Uyk5VYYC0jz2pprxWVJFrv
         cPHj1kPawuuhKoqdGbqw6GAaMm+xaonht6O69gJ0NtvMSqOsCz/EuFQ3i9/N6AynDbQw
         YJIgsb+SObPHrie6/6Eu1cqWhVtK56vkAjctGEv+qeq2wa78cSv37moEo5jN8U5ER41g
         mXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745958908; x=1746563708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+vD+SO2JAT8G1MZey1yCSiJUKQmZMj4na64WTuCtC9c=;
        b=ixQG1DWgtmNF5HGhwC7d4+L2THu7gzjE1WLhKGxxgR7gKqoGFHtkwbVwZ4d9h7gPN6
         09GQKIUB04kdb86ZIl1kGsWfDNGT19CXL39r7K7DMolqOPBKYZNKePeZDDyOLkONyNyM
         lLo/zRV2GRPvsI/k8sWTi2zDE2oLORSnnkO845TBMfd3DbGkTSxbhnXiAVtTV6st9wF3
         XdmY1tYasMh31r01J78W0KSdNhYQ6yH7eNp7vKfTxDYEv3sdLXUFEMXaSSTOJ7i2z0tk
         fvo8EXLrBqO2RDgWIdFSyUeDysovU67svHh7xUH17xGsn0cNVMntT1zwb13vOW3EANBQ
         KKYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2DLTp2E5yrLvueP1NiMseXI2Wp28n5Q3gIwz6s0FZsCd+csJFMD921nEJAIkDBfQ0PNiM7MwSSZbZvs4P1eE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyApVcFOIphM5BFR5dUCvOPxviDeMEjg+y3efulexffvjhufG55
	GsaiDaYmBnRHud0RBSzwWL5WLVXO3nXKD/40UEwKEa5pEtaUzJhl28UE21WiVQ==
X-Gm-Gg: ASbGncv5kpTIVMTBSOabX/xL+goLwKjMSVz3BWgb/C0E+XyK1plfeu1Mz7enqtwtALg
	QvTTrBmCT1/gz5aEeqff317iA6nU5+wn9TDBO7QR0p+ZVPy6lGU5eUahbx0M5rjXoiao9wm4IDb
	mLwgU8JVahlBA+XbvNKGM011w15I559LFw3l9jWVS6hsveSzAJ8e6gBE7ictRe09s2DkAqBMGLl
	NCnJVMHGEBqOeVUSEkmT4VKsLJfL94ktM4iB7G2xKCFFd9Nx8iij9DrzpRyAAlGCtaouqbOWScD
	HTkcloEAMsOY2kZCBZEa3SvCGvcj1KCwwI6gNkWRGCjZcGxOCC4W+dZzwxA6N/e00OjPDxlI
X-Google-Smtp-Source: AGHT+IFKPPlpxna3qRGix+Jw6uZGa6gOYQsO5q0W0Jg8s6IionXDPPsNCjS7Wm3OZ9MyZ/QobcGPBw==
X-Received: by 2002:a17:903:1c7:b0:215:42a3:e844 with SMTP id d9443c01a7336-22df545d640mr62955ad.17.1745958907341;
        Tue, 29 Apr 2025 13:35:07 -0700 (PDT)
Received: from google.com (2.210.143.34.bc.googleusercontent.com. [34.143.210.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dbc0c6sm107319265ad.81.2025.04.29.13.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 13:35:06 -0700 (PDT)
Date: Tue, 29 Apr 2025 20:34:56 +0000
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
	mochs@nvidia.com, alok.a.tiwari@oracle.com, vasant.hegde@amd.com
Subject: Re: [PATCH v2 13/22] iommufd: Add mmap interface
Message-ID: <aBE38GwvGBnpRNLc@google.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7be26560c604b0cbc2fd218997b97a47e4ed11ff.1745646960.git.nicolinc@nvidia.com>
 <aBE1gUz9y415EuBQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBE1gUz9y415EuBQ@google.com>

On Tue, Apr 29, 2025 at 08:24:33PM +0000, Pranjal Shrivastava wrote:
> On Fri, Apr 25, 2025 at 10:58:08PM -0700, Nicolin Chen wrote:
> > For vIOMMU passing through HW resources to user space (VMs), add an mmap
> > infrastructure to map a region of hardware MMIO pages.
> > 
> > Maintain an mt_mmap per ictx for validations. To allow IOMMU drivers to
> > add and delete mmappable regions to/from the mt_mmap, add a pair of new
> > helpers: iommufd_ctx_alloc_mmap() and iommufd_ctx_free_mmap().
> > 
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/iommufd_private.h |  8 +++++
> >  include/linux/iommufd.h                 | 15 ++++++++++
> >  drivers/iommu/iommufd/driver.c          | 39 +++++++++++++++++++++++++
> >  drivers/iommu/iommufd/main.c            | 39 +++++++++++++++++++++++++
> >  4 files changed, 101 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > index b974c207ae8a..db5b62ec4abb 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -7,6 +7,7 @@
> >  #include <linux/iommu.h>
> >  #include <linux/iommufd.h>
> >  #include <linux/iova_bitmap.h>
> > +#include <linux/maple_tree.h>
> >  #include <linux/rwsem.h>
> >  #include <linux/uaccess.h>
> >  #include <linux/xarray.h>
> > @@ -44,6 +45,7 @@ struct iommufd_ctx {
> >  	struct xarray groups;
> >  	wait_queue_head_t destroy_wait;
> >  	struct rw_semaphore ioas_creation_lock;
> > +	struct maple_tree mt_mmap;
> >  
> >  	struct mutex sw_msi_lock;
> >  	struct list_head sw_msi_list;
> > @@ -55,6 +57,12 @@ struct iommufd_ctx {
> >  	struct iommufd_ioas *vfio_ioas;
> >  };
> >  
> > +/* Entry for iommufd_ctx::mt_mmap */
> > +struct iommufd_mmap {
> > +	unsigned long pfn_start;
> > +	unsigned long pfn_end;
> > +};
> > +
> >  /*
> >   * The IOVA to PFN map. The map automatically copies the PFNs into multiple
> >   * domains and permits sharing of PFNs between io_pagetable instances. This
> > diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> > index 5dff154e8ce1..d63e2d91be0d 100644
> > --- a/include/linux/iommufd.h
> > +++ b/include/linux/iommufd.h
> > @@ -236,6 +236,9 @@ int iommufd_object_depend(struct iommufd_object *obj_dependent,
> >  			  struct iommufd_object *obj_depended);
> >  void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> >  			     struct iommufd_object *obj_depended);
> > +int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
> > +			   size_t size, unsigned long *immap_id);
> > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id);
> >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> >  				       unsigned long vdev_id);
> >  int iommufd_viommu_get_vdev_id(struct iommufd_viommu *viommu,
> > @@ -262,11 +265,23 @@ static inline int iommufd_object_depend(struct iommufd_object *obj_dependent,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static inline int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx,
> > +					 phys_addr_t base, size_t size,
> > +					 unsigned long *immap_id)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +
> >  static inline void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> >  					   struct iommufd_object *obj_depended)
> >  {
> >  }
> >  
> > +static inline void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx,
> > +					 unsigned long immap_id)
> > +{
> > +}
> > +
> >  static inline struct device *
> >  iommufd_viommu_find_dev(struct iommufd_viommu *viommu, unsigned long vdev_id)
> >  {
> > diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
> > index fb7f8fe40f95..c55336c580dc 100644
> > --- a/drivers/iommu/iommufd/driver.c
> > +++ b/drivers/iommu/iommufd/driver.c
> > @@ -78,6 +78,45 @@ void iommufd_object_undepend(struct iommufd_object *obj_dependent,
> >  }
> >  EXPORT_SYMBOL_NS_GPL(iommufd_object_undepend, "IOMMUFD");
> >  
> > +/* Driver should report the output @immap_id to user space for mmap() syscall */
> > +int iommufd_ctx_alloc_mmap(struct iommufd_ctx *ictx, phys_addr_t base,
> > +			   size_t size, unsigned long *immap_id)
> > +{
> > +	struct iommufd_mmap *immap;
> > +	int rc;
> > +
> > +	if (WARN_ON_ONCE(!immap_id))
> > +		return -EINVAL;
> > +	if (base & ~PAGE_MASK)
> > +		return -EINVAL;
> > +	if (!size || size & ~PAGE_MASK)
> > +		return -EINVAL;
> > +
> > +	immap = kzalloc(sizeof(*immap), GFP_KERNEL);
> > +	if (!immap)
> > +		return -ENOMEM;
> > +	immap->pfn_start = base >> PAGE_SHIFT;
> > +	immap->pfn_end = immap->pfn_start + (size >> PAGE_SHIFT) - 1;
> > +
> > +	rc = mtree_alloc_range(&ictx->mt_mmap, immap_id, immap, sizeof(immap),
> 
> I believe this should be sizeof(*immap) ?

Ugh, Sorry, shouldn't this be size >> PAGE_SHIFT (num_indices to alloc) ?

> 
> > +			       0, LONG_MAX >> PAGE_SHIFT, GFP_KERNEL);
> > +	if (rc < 0) {
> > +		kfree(immap);
> > +		return rc;
> > +	}
> > +
> > +	/* mmap() syscall will right-shift the immap_id to vma->vm_pgoff */
> > +	*immap_id <<= PAGE_SHIFT;
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_alloc_mmap, "IOMMUFD");
> > +
> > +void iommufd_ctx_free_mmap(struct iommufd_ctx *ictx, unsigned long immap_id)
> > +{
> > +	kfree(mtree_erase(&ictx->mt_mmap, immap_id >> PAGE_SHIFT));
> > +}
> > +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_free_mmap, "IOMMUFD");
> > +
> >  /* Caller should xa_lock(&viommu->vdevs) to protect the return value */
> >  struct device *iommufd_viommu_find_dev(struct iommufd_viommu *viommu,
> >  				       unsigned long vdev_id)
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> > index ac51d5cfaa61..4b46ea47164d 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -213,6 +213,7 @@ static int iommufd_fops_open(struct inode *inode, struct file *filp)
> >  	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
> >  	xa_init(&ictx->groups);
> >  	ictx->file = filp;
> > +	mt_init_flags(&ictx->mt_mmap, MT_FLAGS_ALLOC_RANGE);
> >  	init_waitqueue_head(&ictx->destroy_wait);
> >  	mutex_init(&ictx->sw_msi_lock);
> >  	INIT_LIST_HEAD(&ictx->sw_msi_list);
> > @@ -410,11 +411,49 @@ static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
> >  	return ret;
> >  }
> >  
> > +/*
> > + * Kernel driver must first do iommufd_ctx_alloc_mmap() to register an mmappable
> > + * MMIO region to the iommufd core to receive an "immap_id". Then, driver should
> > + * report to user space this immap_id and the size of the registered MMIO region
> > + * for @vm_pgoff and @size of an mmap() call, via an IOMMU_VIOMMU_ALLOC ioctl in
> > + * the output fields of its driver-type data structure.
> > + *
> > + * Note the @size is allowed to be smaller than the registered size as a partial
> > + * mmap starting from the registered base address.
> > + */
> > +static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
> > +{
> > +	struct iommufd_ctx *ictx = filp->private_data;
> > +	size_t size = vma->vm_end - vma->vm_start;
> > +	struct iommufd_mmap *immap;
> > +
> > +	if (size & ~PAGE_MASK)
> > +		return -EINVAL;
> > +	if (!(vma->vm_flags & VM_SHARED))
> > +		return -EINVAL;
> > +	if (vma->vm_flags & VM_EXEC)
> > +		return -EPERM;
> > +
> > +	/* vm_pgoff carries an index (immap_id) to an mtree entry (immap) */
> > +	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff);
> > +	if (!immap)
> > +		return -ENXIO;
> > +	if (size >> PAGE_SHIFT > immap->pfn_end - immap->pfn_start + 1)
> > +		return -ENXIO;
> > +
> > +	vma->vm_pgoff = 0;
> > +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP | VM_IO);
> > +	return remap_pfn_range(vma, vma->vm_start, immap->pfn_start, size,
> > +			       vma->vm_page_prot);
> > +}
> > +
> >  static const struct file_operations iommufd_fops = {
> >  	.owner = THIS_MODULE,
> >  	.open = iommufd_fops_open,
> >  	.release = iommufd_fops_release,
> >  	.unlocked_ioctl = iommufd_fops_ioctl,
> > +	.mmap = iommufd_fops_mmap,
> >  };
> >  
> >  /**
> 
> Thanks,
> Praan
> 
> > -- 
> > 2.43.0
> > 

