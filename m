Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCF163B0CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 19:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbiK1SKp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 13:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbiK1SK1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 13:10:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695302FC14
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 09:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669658000;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+jPMepWJrmCQgm33DaLLsw9PGYFq62gz+peGxCiDEoA=;
        b=YGyrLJnRpTujEIkWmewBfmOQng3iu6gp3QtQSQHT8WZoGdhhOoMTiM48m0Nl+J2Q9eqoF/
        sYbAHihgc7xCfs6SofE7ukSpWzWiUa3IgMWDoJE6N6/Oj54MfJb1vPvHk9XJRuBzngQVxH
        0ufm7myHoSxyp7Y8ciQefC4HR5MFYTQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-NdG6s1s8PDaZqyzdmVFAyQ-1; Mon, 28 Nov 2022 12:53:18 -0500
X-MC-Unique: NdG6s1s8PDaZqyzdmVFAyQ-1
Received: by mail-wr1-f72.google.com with SMTP id r17-20020adfb1d1000000b002421ae7fd46so838009wra.10
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 09:53:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jPMepWJrmCQgm33DaLLsw9PGYFq62gz+peGxCiDEoA=;
        b=YF+okbPef7RVQ+FpT0D1WxiVhBl6L+ZMwywt715teE0IZ2SkP6sAI4wOQvpR32KjpP
         0qnnPxk30wdSJXpS1iTyDuN7ze88AAn884xbQP5Mi2ck2jahVTtGjS92yTxjYrrPrusM
         yb0ctGZXvD5ftc2n5csfwmEMCaUfPLrf4PDAyoS/MyQ1ArEohgWfqCU28O7GAqkogcjr
         edfRGz6fMhP0dNWe14p7SdBZ0fmylo9GjNegPGAq9ZJ2qnzl9zT1twQfFI1GknC36W7/
         OZvA9hgBLPAQUmVu8BzHsYkWu2mgNnyxSOo69KydJo2UUSVXAuPIdgqcwF4NENhYjTYF
         SgRg==
X-Gm-Message-State: ANoB5pmuJPEiVx4hsHHZyxsSHmRS+4I7jirlwJAjFVdGUG+iHl+D6r8y
        FdRxvCk53PQ40P9tturhCRIs5vooZ0ZRP8XwIi5um/zakhanOr3U3EKkJ9c/PH9uTCVqauoExBd
        jIuJ7XSsRl4K6Ux5n0VmzRZCIRJeJ
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr27823084wmp.63.1669657996917;
        Mon, 28 Nov 2022 09:53:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf41FpMeP4Ok9FL0zc9+FO0qUGjRtlMf3LagsM7iAaG0ltFNIZUEvW1KlzMFyGy7ofsQjFAe6g==
X-Received: by 2002:a05:600c:4916:b0:3cf:85e7:7b40 with SMTP id f22-20020a05600c491600b003cf85e77b40mr27823055wmp.63.1669657996497;
        Mon, 28 Nov 2022 09:53:16 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id hg27-20020a05600c539b00b003a3170a7af9sm16226785wmb.4.2022.11.28.09.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 09:53:15 -0800 (PST)
Message-ID: <81f898b6-e40f-be72-78d4-b5d836981d8f@redhat.com>
Date:   Mon, 28 Nov 2022 18:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
References: <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On 11/16/22 22:00, Jason Gunthorpe wrote:
> iommufd can directly implement the /dev/vfio/vfio container IOCTLs by
> mapping them into io_pagetable operations.
>
> A userspace application can test against iommufd and confirm compatibility
> then simply make a small change to open /dev/iommu instead of
> /dev/vfio/vfio.
>
> For testing purposes /dev/vfio/vfio can be symlinked to /dev/iommu and
> then all applications will use the compatibility path with no code
> changes. A later series allows /dev/vfio/vfio to be directly provided by
> iommufd, which allows the rlimit mode to work the same as well.
>
> This series just provides the iommufd side of compatibility. Actually
> linking this to VFIO_SET_CONTAINER is a followup series, with a link in
> the cover letter.
>
> Internally the compatibility API uses a normal IOAS object that, like
> vfio, is automatically allocated when the first device is
> attached.
>
> Userspace can also query or set this IOAS object directly using the
> IOMMU_VFIO_IOAS ioctl. This allows mixing and matching new iommufd only
> features while still using the VFIO style map/unmap ioctls.
>
> While this is enough to operate qemu, it has a few differences:
>
>  - Resource limits rely on memory cgroups to bound what userspace can do
>    instead of the module parameter dma_entry_limit.
>
>  - VFIO P2P is not implemented. The DMABUF patches for vfio are a start at
>    a solution where iommufd would import a special DMABUF. This is to avoid
>    further propogating the follow_pfn() security problem.
>
>  - A full audit for pedantic compatibility details (eg errnos, etc) has
>    not yet been done
>
>  - powerpc SPAPR is left out, as it is not connected to the iommu_domain
>    framework. It seems interest in SPAPR is minimal as it is currently
>    non-working in v6.1-rc1. They will have to convert to the iommu
>    subsystem framework to enjoy iommfd.
>
> The following are not going to be implemented and we expect to remove them
> from VFIO type1:
>
>  - SW access 'dirty tracking'. As discussed in the cover letter this will
>    be done in VFIO.
>
>  - VFIO_TYPE1_NESTING_IOMMU
>     https://lore.kernel.org/all/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/
>
>  - VFIO_DMA_MAP_FLAG_VADDR
>     https://lore.kernel.org/all/Yz777bJZjTyLrHEQ@nvidia.com/
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |   3 +-
>  drivers/iommu/iommufd/iommufd_private.h |   6 +
>  drivers/iommu/iommufd/main.c            |  16 +-
>  drivers/iommu/iommufd/vfio_compat.c     | 458 ++++++++++++++++++++++++
>  include/linux/iommufd.h                 |   7 +
>  include/uapi/linux/iommufd.h            |  36 ++
>  6 files changed, 520 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/vfio_compat.c
>
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index ca28a135b9675f..2fdff04000b326 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -5,6 +5,7 @@ iommufd-y := \
>  	io_pagetable.o \
>  	ioas.o \
>  	main.o \
> -	pages.o
> +	pages.o \
> +	vfio_compat.o
>  
>  obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index e1653b2276dac9..f1d462f40ac7b7 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -18,6 +18,7 @@ struct iommufd_ctx {
>  	struct xarray objects;
>  
>  	u8 account_mode;
> +	struct iommufd_ioas *vfio_ioas;
>  };
>  
>  /*
> @@ -92,6 +93,9 @@ struct iommufd_ucmd {
>  	void *cmd;
>  };
>  
> +int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
> +		       unsigned long arg);
> +
>  /* Copy the response in ucmd->cmd back to userspace. */
>  static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
>  				       size_t cmd_len)
> @@ -222,6 +226,8 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>  int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>  			       struct iommufd_ctx *ictx);
>  
> +int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd);
> +
>  /*
>   * A HW pagetable is called an iommu_domain inside the kernel. This user object
>   * allows directly creating and inspecting the domains. Domains that have kernel
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index c8cc0953dea13a..f76b2c8dcde8e5 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -133,6 +133,8 @@ bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
>  		return false;
>  	}
>  	__xa_erase(&ictx->objects, obj->id);
> +	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
> +		ictx->vfio_ioas = NULL;
>  	xa_unlock(&ictx->objects);
>  	up_write(&obj->destroy_rwsem);
>  
> @@ -266,27 +268,31 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 length),
>  	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
>  		 val64),
> +	IOCTL_OP(IOMMU_VFIO_IOAS, iommufd_vfio_ioas, struct iommu_vfio_ioas,
> +		 __reserved),
>  };
>  
>  static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
>  			       unsigned long arg)
>  {
> +	struct iommufd_ctx *ictx = filp->private_data;
>  	const struct iommufd_ioctl_op *op;
>  	struct iommufd_ucmd ucmd = {};
>  	union ucmd_buffer buf;
>  	unsigned int nr;
>  	int ret;
>  
> -	ucmd.ictx = filp->private_data;
> +	nr = _IOC_NR(cmd);
> +	if (nr < IOMMUFD_CMD_BASE ||
> +	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
> +		return iommufd_vfio_ioctl(ictx, cmd, arg);
> +
> +	ucmd.ictx = ictx;
>  	ucmd.ubuffer = (void __user *)arg;
>  	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
>  	if (ret)
>  		return ret;
>  
> -	nr = _IOC_NR(cmd);
> -	if (nr < IOMMUFD_CMD_BASE ||
> -	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
> -		return -ENOIOCTLCMD;
>  	op = &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
>  	if (op->ioctl_num != cmd)
>  		return -ENOIOCTLCMD;
> diff --git a/drivers/iommu/iommufd/vfio_compat.c b/drivers/iommu/iommufd/vfio_compat.c
> new file mode 100644
> index 00000000000000..c993269ebb5119
> --- /dev/null
> +++ b/drivers/iommu/iommufd/vfio_compat.c
> @@ -0,0 +1,458 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/file.h>
> +#include <linux/interval_tree.h>
> +#include <linux/iommu.h>
> +#include <linux/iommufd.h>
> +#include <linux/slab.h>
> +#include <linux/vfio.h>
> +#include <uapi/linux/vfio.h>
> +#include <uapi/linux/iommufd.h>
> +
> +#include "iommufd_private.h"
> +
> +static struct iommufd_ioas *get_compat_ioas(struct iommufd_ctx *ictx)
> +{
> +	struct iommufd_ioas *ioas = ERR_PTR(-ENODEV);
> +
> +	xa_lock(&ictx->objects);
> +	if (!ictx->vfio_ioas || !iommufd_lock_obj(&ictx->vfio_ioas->obj))
> +		goto out_unlock;
> +	ioas = ictx->vfio_ioas;
> +out_unlock:
> +	xa_unlock(&ictx->objects);
> +	return ioas;
> +}
> +
> +/**
> + * iommufd_vfio_compat_ioas_id - Return the IOAS ID that vfio should use
> + * @ictx: Context to operate on
> + * @out_ioas_id: The ioas_id the caller should use
> + *
> + * The compatibility IOAS is the IOAS that the vfio compatibility ioctls operate
> + * on since they do not have an IOAS ID input in their ABI. Only attaching a
> + * group should cause a default creation of the internal ioas, this returns the
> + * existing ioas if it has already been assigned somehow.
> + */
> +int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32 *out_ioas_id)
> +{
> +	struct iommufd_ioas *ioas = NULL;
> +	struct iommufd_ioas *out_ioas;
> +
> +	ioas = iommufd_ioas_alloc(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	xa_lock(&ictx->objects);
> +	if (ictx->vfio_ioas && iommufd_lock_obj(&ictx->vfio_ioas->obj))
> +		out_ioas = ictx->vfio_ioas;
> +	else {
> +		out_ioas = ioas;
> +		ictx->vfio_ioas = ioas;
> +	}
> +	xa_unlock(&ictx->objects);
> +
> +	*out_ioas_id = out_ioas->obj.id;
> +	if (out_ioas != ioas) {
> +		iommufd_put_object(&out_ioas->obj);
> +		iommufd_object_abort(ictx, &ioas->obj);
> +		return 0;
> +	}
> +	/*
> +	 * An automatically created compat IOAS is treated as a userspace
> +	 * created object. Userspace can learn the ID via IOMMU_VFIO_IOAS_GET,
> +	 * and if not manually destroyed it will be destroyed automatically
> +	 * at iommufd release.
> +	 */
> +	iommufd_object_finalize(ictx, &ioas->obj);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_vfio_compat_ioas_id, IOMMUFD_VFIO);
> +
> +int iommufd_vfio_ioas(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_vfio_ioas *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +
> +	if (cmd->__reserved)
> +		return -EOPNOTSUPP;
> +	switch (cmd->op) {
> +	case IOMMU_VFIO_IOAS_GET:
> +		ioas = get_compat_ioas(ucmd->ictx);
> +		if (IS_ERR(ioas))
> +			return PTR_ERR(ioas);
> +		cmd->ioas_id = ioas->obj.id;
> +		iommufd_put_object(&ioas->obj);
> +		return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +
> +	case IOMMU_VFIO_IOAS_SET:
> +		ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> +		if (IS_ERR(ioas))
> +			return PTR_ERR(ioas);
> +		xa_lock(&ucmd->ictx->objects);
> +		ucmd->ictx->vfio_ioas = ioas;
> +		xa_unlock(&ucmd->ictx->objects);
> +		iommufd_put_object(&ioas->obj);
> +		return 0;
> +
> +	case IOMMU_VFIO_IOAS_CLEAR:
> +		xa_lock(&ucmd->ictx->objects);
> +		ucmd->ictx->vfio_ioas = NULL;
> +		xa_unlock(&ucmd->ictx->objects);
> +		return 0;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
> +static int iommufd_vfio_map_dma(struct iommufd_ctx *ictx, unsigned int cmd,
> +				void __user *arg)
> +{
> +	u32 supported_flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
> +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> +	struct vfio_iommu_type1_dma_map map;
> +	int iommu_prot = IOMMU_CACHE;
> +	struct iommufd_ioas *ioas;
> +	unsigned long iova;
> +	int rc;
> +
> +	if (copy_from_user(&map, arg, minsz))
> +		return -EFAULT;
> +
> +	if (map.argsz < minsz || map.flags & ~supported_flags)
> +		return -EINVAL;
> +
> +	if (map.flags & VFIO_DMA_MAP_FLAG_READ)
> +		iommu_prot |= IOMMU_READ;
> +	if (map.flags & VFIO_DMA_MAP_FLAG_WRITE)
> +		iommu_prot |= IOMMU_WRITE;
> +
> +	ioas = get_compat_ioas(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	/*
> +	 * Maps created through the legacy interface always use VFIO compatible
> +	 * rlimit accounting. If the user wishes to use the faster user based
> +	 * rlimit accounting then they must use the new interface.
s/they/he
> +	 */
> +	iova = map.iova;
> +	rc = iopt_map_user_pages(ictx, &ioas->iopt, &iova, u64_to_user_ptr(map.vaddr),
> +				 map.size, iommu_prot, 0);
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
> +
> +static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
> +				  void __user *arg)
> +{
> +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> +	/*
> +	 * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
> +	 * dirty tracking direction:
> +	 *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
> +	 *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
> +	 */
> +	u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
> +	struct vfio_iommu_type1_dma_unmap unmap;
> +	unsigned long unmapped = 0;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (copy_from_user(&unmap, arg, minsz))
> +		return -EFAULT;
> +
> +	if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
> +		return -EINVAL;
> +
> +	ioas = get_compat_ioas(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> +		if (unmap.iova != 0 || unmap.size != 0) {
> +			rc = -EINVAL;
> +			goto err_put;
> +		}
> +		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
> +	} else {
> +		if (READ_ONCE(ioas->iopt.disable_large_pages)) {
> +			unsigned long iovas[] = { unmap.iova + unmap.size - 1,
> +						  unmap.iova - 1 };
> +
> +			rc = iopt_cut_iova(&ioas->iopt, iovas,
> +					   unmap.iova ? 2 : 1);
please can you add a comment to explain what this is supposed to do?
> +			if (rc)
> +				goto err_put;
> +		}
> +		rc = iopt_unmap_iova(&ioas->iopt, unmap.iova, unmap.size,
> +				     &unmapped);
> +	}
> +	unmap.size = unmapped;
> +	if (copy_to_user(arg, &unmap, minsz))
> +		rc = -EFAULT;
> +
> +err_put:
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
> +
> +static int iommufd_vfio_cc_iommu(struct iommufd_ctx *ictx)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_ioas *ioas;
> +	int rc = 1;
> +
> +	ioas = get_compat_ioas(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	mutex_lock(&ioas->mutex);
> +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> +		if (!hwpt->enforce_cache_coherency) {
> +			rc = 0;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ioas->mutex);
> +
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
> +
> +static int iommufd_vfio_check_extension(struct iommufd_ctx *ictx,
> +					unsigned long type)
> +{
> +	switch (type) {
> +	case VFIO_TYPE1_IOMMU:
> +	case VFIO_TYPE1v2_IOMMU:
> +	case VFIO_UNMAP_ALL:
> +		return 1;
> +
> +	case VFIO_DMA_CC_IOMMU:
> +		return iommufd_vfio_cc_iommu(ictx);
> +
> +	/*
> +	 * This is obsolete, and to be removed from VFIO. It was an incomplete
> +	 * idea that got merged.
> +	 * https://lore.kernel.org/kvm/0-v1-0093c9b0e345+19-vfio_no_nesting_jgg@nvidia.com/
> +	 */
> +	case VFIO_TYPE1_NESTING_IOMMU:
> +		return 0;
> +
> +	/*
> +	 * VFIO_DMA_MAP_FLAG_VADDR
> +	 * https://lore.kernel.org/kvm/1611939252-7240-1-git-send-email-steven.sistare@oracle.com/
> +	 * https://lore.kernel.org/all/Yz777bJZjTyLrHEQ@nvidia.com/
> +	 *
> +	 * It is hard to see how this could be implemented safely.
> +	 */
> +	case VFIO_UPDATE_VADDR:
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static int iommufd_vfio_set_iommu(struct iommufd_ctx *ictx, unsigned long type)
> +{
> +	struct iommufd_ioas *ioas = NULL;
> +	int rc = 0;
> +
> +	if (type != VFIO_TYPE1_IOMMU && type != VFIO_TYPE1v2_IOMMU)
> +		return -EINVAL;
> +
> +	/* VFIO fails the set_iommu if there is no group */
> +	ioas = get_compat_ioas(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +	if (type == VFIO_TYPE1_IOMMU)
> +		rc = iopt_disable_large_pages(&ioas->iopt);
please can you document/explain this setting?
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
> +
> +static unsigned long iommufd_get_pagesizes(struct iommufd_ioas *ioas)
> +{
> +	struct io_pagetable *iopt = &ioas->iopt;
> +	unsigned long pgsize_bitmap = ULONG_MAX;
> +	struct iommu_domain *domain;
> +	unsigned long index;
> +
> +	down_read(&iopt->domains_rwsem);
> +	xa_for_each(&iopt->domains, index, domain)
> +		pgsize_bitmap &= domain->pgsize_bitmap;
> +
> +	/* See vfio_update_pgsize_bitmap() */
> +	if (pgsize_bitmap & ~PAGE_MASK) {
> +		pgsize_bitmap &= PAGE_MASK;
> +		pgsize_bitmap |= PAGE_SIZE;
> +	}
> +	pgsize_bitmap = max(pgsize_bitmap, ioas->iopt.iova_alignment);
> +	up_read(&iopt->domains_rwsem);
> +	return pgsize_bitmap;
> +}
> +
> +static int iommufd_fill_cap_iova(struct iommufd_ioas *ioas,
> +				 struct vfio_info_cap_header __user *cur,
> +				 size_t avail)
> +{
> +	struct vfio_iommu_type1_info_cap_iova_range __user *ucap_iovas =
> +		container_of(cur,
> +			     struct vfio_iommu_type1_info_cap_iova_range __user,
> +			     header);
> +	struct vfio_iommu_type1_info_cap_iova_range cap_iovas = {
> +		.header = {
> +			.id = VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE,
> +			.version = 1,
> +		},
> +	};
> +	struct interval_tree_span_iter span;
> +
> +	interval_tree_for_each_span(&span, &ioas->iopt.reserved_itree, 0,
> +				    ULONG_MAX) {
> +		struct vfio_iova_range range;
> +
> +		if (!span.is_hole)
> +			continue;
> +		range.start = span.start_hole;
> +		range.end = span.last_hole;
> +		if (avail >= struct_size(&cap_iovas, iova_ranges,
> +					 cap_iovas.nr_iovas + 1) &&
> +		    copy_to_user(&ucap_iovas->iova_ranges[cap_iovas.nr_iovas],
> +				 &range, sizeof(range)))
> +			return -EFAULT;
> +		cap_iovas.nr_iovas++;
> +	}
> +	if (avail >= struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas) &&
> +	    copy_to_user(ucap_iovas, &cap_iovas, sizeof(cap_iovas)))
> +		return -EFAULT;
> +	return struct_size(&cap_iovas, iova_ranges, cap_iovas.nr_iovas);
> +}
> +
> +static int iommufd_fill_cap_dma_avail(struct iommufd_ioas *ioas,
> +				      struct vfio_info_cap_header __user *cur,
> +				      size_t avail)
> +{
> +	struct vfio_iommu_type1_info_dma_avail cap_dma = {
> +		.header = {
> +			.id = VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL,
> +			.version = 1,
> +		},
> +		/*
> +		 * iommufd's limit is based on the cgroup's memory limit.
> +		 * Normally vfio would return U16_MAX here, and provide a module
> +		 * parameter to adjust it. Since S390 qemu userspace actually
> +		 * pays attention and needs a value bigger than U16_MAX return
> +		 * U32_MAX.
> +		 */
> +		.avail = U32_MAX,
> +	};
> +
> +	if (avail >= sizeof(cap_dma) &&
> +	    copy_to_user(cur, &cap_dma, sizeof(cap_dma)))
> +		return -EFAULT;
> +	return sizeof(cap_dma);
> +}
> +
> +static int iommufd_vfio_iommu_get_info(struct iommufd_ctx *ictx,
> +				       void __user *arg)
> +{
> +	typedef int (*fill_cap_fn)(struct iommufd_ioas *ioas,
> +				   struct vfio_info_cap_header __user *cur,
> +				   size_t avail);
> +	static const fill_cap_fn fill_fns[] = {
> +		iommufd_fill_cap_dma_avail,
> +		iommufd_fill_cap_iova,
> +	};
> +	size_t minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
> +	struct vfio_info_cap_header __user *last_cap = NULL;
> +	struct vfio_iommu_type1_info info;
> +	struct iommufd_ioas *ioas;
> +	size_t total_cap_size;
> +	int rc;
> +	int i;
> +
> +	if (copy_from_user(&info, arg, minsz))
> +		return -EFAULT;
> +
> +	if (info.argsz < minsz)
> +		return -EINVAL;
> +	minsz = min_t(size_t, info.argsz, sizeof(info));
> +
> +	ioas = get_compat_ioas(ictx);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	info.flags = VFIO_IOMMU_INFO_PGSIZES;
> +	info.iova_pgsizes = iommufd_get_pagesizes(ioas);
> +	info.cap_offset = 0;
> +
> +	down_read(&ioas->iopt.iova_rwsem);
> +	total_cap_size = sizeof(info);
> +	for (i = 0; i != ARRAY_SIZE(fill_fns); i++) {
> +		int cap_size;
> +
> +		if (info.argsz > total_cap_size)
> +			cap_size = fill_fns[i](ioas, arg + total_cap_size,
> +					       info.argsz - total_cap_size);
> +		else
> +			cap_size = fill_fns[i](ioas, NULL, 0);
> +		if (cap_size < 0) {
> +			rc = cap_size;
> +			goto out_put;
> +		}
> +		if (last_cap && info.argsz >= total_cap_size &&
> +		    put_user(total_cap_size, &last_cap->next)) {
> +			rc = -EFAULT;
> +			goto out_put;
> +		}
> +		last_cap = arg + total_cap_size;
> +		total_cap_size += cap_size;
> +	}
> +
> +	/*
> +	 * If the user did not provide enough space then only some caps are
> +	 * returned and the argsz will be updated to the correct amount to get
> +	 * all caps.
> +	 */
> +	if (info.argsz >= total_cap_size)
> +		info.cap_offset = sizeof(info);
> +	info.argsz = total_cap_size;
> +	info.flags |= VFIO_IOMMU_INFO_CAPS;
> +	if (copy_to_user(arg, &info, minsz)) {
> +		rc = -EFAULT;
> +		goto out_put;
> +	}
> +	rc = 0;
> +
> +out_put:
> +	up_read(&ioas->iopt.iova_rwsem);
> +	iommufd_put_object(&ioas->obj);
> +	return rc;
> +}
> +
> +int iommufd_vfio_ioctl(struct iommufd_ctx *ictx, unsigned int cmd,
> +		       unsigned long arg)
> +{
> +	void __user *uarg = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case VFIO_GET_API_VERSION:
> +		return VFIO_API_VERSION;
> +	case VFIO_SET_IOMMU:
> +		return iommufd_vfio_set_iommu(ictx, arg);
> +	case VFIO_CHECK_EXTENSION:
> +		return iommufd_vfio_check_extension(ictx, arg);
> +	case VFIO_IOMMU_GET_INFO:
> +		return iommufd_vfio_iommu_get_info(ictx, uarg);
> +	case VFIO_IOMMU_MAP_DMA:
> +		return iommufd_vfio_map_dma(ictx, cmd, uarg);
> +	case VFIO_IOMMU_UNMAP_DMA:
> +		return iommufd_vfio_unmap_dma(ictx, cmd, uarg);
> +	case VFIO_IOMMU_DIRTY_PAGES:
> +	default:
> +		return -ENOIOCTLCMD;
> +	}
> +	return -ENOIOCTLCMD;
> +}
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index fb9a4c275cca86..d57b044acca4cb 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -58,6 +58,7 @@ void iommufd_access_unpin_pages(struct iommufd_access *access,
>  				unsigned long iova, unsigned long length);
>  int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
>  		      void *data, size_t len, unsigned int flags);
> +int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
>  #else /* !CONFIG_IOMMUFD */
>  static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
>  {
> @@ -88,5 +89,11 @@ static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx,
> +					      u32 *out_ioas_id)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_IOMMUFD */
>  #endif
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 9e9250dfc4fb1b..24100494aa90b8 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -44,6 +44,7 @@ enum {
>  	IOMMUFD_CMD_IOAS_MAP,
>  	IOMMUFD_CMD_IOAS_UNMAP,
>  	IOMMUFD_CMD_OPTION,
> +	IOMMUFD_CMD_VFIO_IOAS,
>  };
>  
>  /**
> @@ -296,4 +297,39 @@ struct iommu_option {
>  	__aligned_u64 val64;
>  };
>  #define IOMMU_OPTION _IO(IOMMUFD_TYPE, IOMMUFD_CMD_OPTION)
> +
> +/**
> + * enum iommufd_vfio_ioas_op - IOMMU_VFIO_IOAS_* ioctls
> + * @IOMMU_VFIO_IOAS_GET: Get the current compatibility IOAS
> + * @IOMMU_VFIO_IOAS_SET: Change the current compatibility IOAS
> + * @IOMMU_VFIO_IOAS_CLEAR: Disable VFIO compatibility
> + */
> +enum iommufd_vfio_ioas_op {
> +	IOMMU_VFIO_IOAS_GET = 0,
> +	IOMMU_VFIO_IOAS_SET = 1,
> +	IOMMU_VFIO_IOAS_CLEAR = 2,
> +};
> +
> +/**
> + * struct iommu_vfio_ioas - ioctl(IOMMU_VFIO_IOAS)
> + * @size: sizeof(struct iommu_vfio_ioas)
> + * @ioas_id: For IOMMU_VFIO_IOAS_SET the input IOAS ID to set
> + *           For IOMMU_VFIO_IOAS_GET will output the IOAS ID
> + * @op: One of enum iommufd_vfio_ioas_op
> + * @__reserved: Must be 0
> + *
> + * The VFIO compatibility support uses a single ioas because VFIO APIs do not
> + * support the ID field. Set or Get the IOAS that VFIO compatibility will use.
> + * When VFIO_GROUP_SET_CONTAINER is used on an iommufd it will get the
> + * compatibility ioas, either by taking what is already set, or auto creating
> + * one. From then on VFIO will continue to use that ioas and is not effected by
> + * this ioctl. SET or CLEAR does not destroy any auto-created IOAS.
> + */
> +struct iommu_vfio_ioas {
> +	__u32 size;
> +	__u32 ioas_id;
> +	__u16 op;
> +	__u16 __reserved;
> +};
> +#define IOMMU_VFIO_IOAS _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VFIO_IOAS)
>  #endif

Thanks

Eric




