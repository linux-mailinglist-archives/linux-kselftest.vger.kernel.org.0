Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD97F62FA3A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 17:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235285AbiKRQ2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 11:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235232AbiKRQ2l (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 11:28:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B7093713
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Nov 2022 08:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668788867;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JfLP1pnNvTbaCSPJQGDRFPlEFD/SLE7R6FU5v+Vliw=;
        b=cKW9C7zHfQgplbJl2IFmSlk1liuEHpP81aodVU/z3xpz6jgBYs3WFOU1gkzrGyd9AjCkIG
        vicwRJ460z9DknYkChh8IEU3hG3tzcL8dEi1aePteq0pbU6lzkSz96LmTmRjoGYywAsLW0
        ORZFRAEC8BGLNP8BOAGuC/Xa8OJVhCs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-573-cYd_HNJYNrqAyRkZlH8MJg-1; Fri, 18 Nov 2022 11:27:44 -0500
X-MC-Unique: cYd_HNJYNrqAyRkZlH8MJg-1
Received: by mail-wm1-f70.google.com with SMTP id j2-20020a05600c1c0200b003cf7397fc9bso2475878wms.5
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Nov 2022 08:27:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9JfLP1pnNvTbaCSPJQGDRFPlEFD/SLE7R6FU5v+Vliw=;
        b=lHmDXPxDPWfHf/ZXJxNfE3MQGgqVThbnMrXGm8SfXBWjBPASjSjk2Ae/J4VrBKMaJu
         dzRBQuyUFDFQ+fL4qvWb/kYwyYe+ghiUEynj2pKzo/2tj6xr5xwALrAguf5KeBYacAmM
         /ubHhOMMPHgjJ3aq2SDKcimBXw69pxTDWvZLmSJF89Awdrj9Vdf0PA05r+AwkkIOWt5L
         ar3dAL5aUEy30mNnKeicrcRQuDf0SGYsUjO7TEfh3ZvOZEvJuQkj2MRFPo16tqzqr/Sj
         Z3EjoUSRoJ/HDt6X+UB7vcaIXGXRI4hOHYgIJzyyMGMACbzf9MlpIWj/NfBnuh10RNtE
         qqrw==
X-Gm-Message-State: ANoB5pll4Q9TiaBBtmcHt0TkxCv5q6jafAUT9Pj7j9lkdlF9QJU3aSpI
        6xKyV20hlF29tegNf5pGs7ycK1qsJkxmFcWKErk0QcBMx6YFz2dFpNLdnfZYQ8uiGbBFHgWC/Xv
        F0U4QIQdgTP7mWvnyLD1TmOtP3emw
X-Received: by 2002:adf:ecc6:0:b0:236:791e:cedb with SMTP id s6-20020adfecc6000000b00236791ecedbmr4785552wro.64.1668788860041;
        Fri, 18 Nov 2022 08:27:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5XgqhP/FhF/Mne9Is+9GrJvV6Kh/FvnE/n/SKRpMIQ/H/rWbWRwUriEZIbjsb9AUMHYJLfMg==
X-Received: by 2002:adf:ecc6:0:b0:236:791e:cedb with SMTP id s6-20020adfecc6000000b00236791ecedbmr4785500wro.64.1668788859568;
        Fri, 18 Nov 2022 08:27:39 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id j15-20020adfe50f000000b002366d1cc198sm3883105wrm.41.2022.11.18.08.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 08:27:38 -0800 (PST)
Message-ID: <0c6ba292-4e65-9a9f-b498-2409482a06b8@redhat.com>
Date:   Fri, 18 Nov 2022 17:27:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 06/19] iommufd: File descriptor, context, kconfig and
 makefiles
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
References: <6-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <6-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,
On 11/16/22 22:00, Jason Gunthorpe wrote:
> This is the basic infrastructure of a new miscdevice to hold the iommufd
> IOCTL API.
>
> It provides:
>  - A miscdevice to create file descriptors to run the IOCTL interface over
>
>  - A table based ioctl dispatch and centralized extendable pre-validation
>    step
>
>  - An xarray mapping userspace ID's to kernel objects. The design has
>    multiple inter-related objects held within in a single IOMMUFD fd
>
>  - A simple usage count to build a graph of object relations and protect
>    against hostile userspace racing ioctls
>
> The only IOCTL provided in this patch is the generic 'destroy any object
> by handle' operation.
>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  MAINTAINERS                                   |  12 +
>  drivers/iommu/Kconfig                         |   1 +
>  drivers/iommu/Makefile                        |   2 +-
>  drivers/iommu/iommufd/Kconfig                 |  12 +
>  drivers/iommu/iommufd/Makefile                |   5 +
>  drivers/iommu/iommufd/iommufd_private.h       | 109 ++++++
>  drivers/iommu/iommufd/main.c                  | 342 ++++++++++++++++++
>  include/linux/iommufd.h                       |  31 ++
>  include/uapi/linux/iommufd.h                  |  55 +++
>  10 files changed, 569 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/iommufd/Kconfig
>  create mode 100644 drivers/iommu/iommufd/Makefile
>  create mode 100644 drivers/iommu/iommufd/iommufd_private.h
>  create mode 100644 drivers/iommu/iommufd/main.c
>  create mode 100644 include/linux/iommufd.h
>  create mode 100644 include/uapi/linux/iommufd.h
>
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 5f81e2a24a5c04..eb045fc495a4e3 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -105,6 +105,7 @@ Code  Seq#    Include File                                           Comments
>  '8'   all                                                            SNP8023 advanced NIC card
>                                                                       <mailto:mcr@solidum.com>
>  ';'   64-7F  linux/vfio.h
> +';'   80-FF  linux/iommufd.h
>  '='   00-3f  uapi/linux/ptp_clock.h                                  <mailto:richardcochran@gmail.com>
>  '@'   00-0F  linux/radeonfb.h                                        conflict!
>  '@'   00-0F  drivers/video/aty/aty128fb.c                            conflict!
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 379945f82a6438..c0a93779731d7e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10717,6 +10717,18 @@ F:	drivers/iommu/dma-iommu.h
>  F:	drivers/iommu/iova.c
>  F:	include/linux/iova.h
>  
> +IOMMUFD
> +M:	Jason Gunthorpe <jgg@nvidia.com>
> +M:	Kevin Tian <kevin.tian@intel.com>
> +L:	iommu@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git
> +F:	Documentation/userspace-api/iommufd.rst
> +F:	drivers/iommu/iommufd/
> +F:	include/linux/iommufd.h
> +F:	include/uapi/linux/iommufd.h
> +F:	tools/testing/selftests/iommu/
> +
>  IOMMU SUBSYSTEM
>  M:	Joerg Roedel <joro@8bytes.org>
>  M:	Will Deacon <will@kernel.org>
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index dc5f7a156ff5ec..319966cde5cf6c 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -188,6 +188,7 @@ config MSM_IOMMU
>  
>  source "drivers/iommu/amd/Kconfig"
>  source "drivers/iommu/intel/Kconfig"
> +source "drivers/iommu/iommufd/Kconfig"
>  
>  config IRQ_REMAP
>  	bool "Support for Interrupt Remapping"
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 7fbf6a3376620e..f461d065138564 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y += amd/ intel/ arm/
> +obj-y += amd/ intel/ arm/ iommufd/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
>  obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
> diff --git a/drivers/iommu/iommufd/Kconfig b/drivers/iommu/iommufd/Kconfig
> new file mode 100644
> index 00000000000000..6d65d0f06f169f
> --- /dev/null
> +++ b/drivers/iommu/iommufd/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config IOMMUFD
> +	tristate "IOMMU Userspace API"
> +	select INTERVAL_TREE
> +	select INTERVAL_TREE_SPAN_ITER
> +	select IOMMU_API
> +	default n
> +	help
> +	  Provides /dev/iommu the user API to control the IOMMU subsystem as
> +	  it relates to managing IO page tables that point at user space memory.
nit: missing ',' after /dev/iommu or Provides /dev/iommu user API
> +
> +	  If you don't know what to do here, say N.
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> new file mode 100644
> index 00000000000000..a07a8cffe937c6
> --- /dev/null
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +iommufd-y := \
> +	main.o
> +
> +obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> new file mode 100644
> index 00000000000000..d523e7967b1440
> --- /dev/null
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __IOMMUFD_PRIVATE_H
> +#define __IOMMUFD_PRIVATE_H
> +
> +#include <linux/rwsem.h>
> +#include <linux/xarray.h>
> +#include <linux/refcount.h>
> +#include <linux/uaccess.h>
> +
> +struct iommufd_ctx {
> +	struct file *file;
> +	struct xarray objects;
> +};
> +
> +struct iommufd_ucmd {
> +	struct iommufd_ctx *ictx;
> +	void __user *ubuffer;
> +	u32 user_size;
> +	void *cmd;
> +};
> +
> +/* Copy the response in ucmd->cmd back to userspace. */
> +static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
> +				       size_t cmd_len)
> +{
> +	if (copy_to_user(ucmd->ubuffer, ucmd->cmd,
> +			 min_t(size_t, ucmd->user_size, cmd_len)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
> +enum iommufd_object_type {
> +	IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> +};
> +
> +/* Base struct for all objects with a userspace ID handle. */
> +struct iommufd_object {
> +	struct rw_semaphore destroy_rwsem;
> +	refcount_t users;
> +	enum iommufd_object_type type;
> +	unsigned int id;
> +};
> +
> +static inline bool iommufd_lock_obj(struct iommufd_object *obj)
> +{
> +	if (!down_read_trylock(&obj->destroy_rwsem))
> +		return false;
> +	if (!refcount_inc_not_zero(&obj->users)) {
> +		up_read(&obj->destroy_rwsem);
> +		return false;
> +	}
> +	return true;
> +}
> +
> +struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
> +					  enum iommufd_object_type type);
> +static inline void iommufd_put_object(struct iommufd_object *obj)
> +{
> +	refcount_dec(&obj->users);
> +	up_read(&obj->destroy_rwsem);
> +}
> +
> +/**
> + * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
> + *        protection
> + * @obj - Object to release
> + *
> + * Objects have two refcount protections (destroy_rwsem and the refcount_t
> + * users). Holding either of these will prevent the object from being destroyed.
> + *
> + * Depending on the use case, one protection or the other is appropriate.  In
> + * most cases references are being protected by the destroy_rwsem. This allows
> + * orderly destruction of the object because iommufd_object_destroy_user() will
> + * wait for it to become unlocked. However, as a rwsem, it cannot be held across
> + * a system call return. So cases that have longer term needs must switch
> + * to the weaker users refcount_t.
> + *
> + * With users protection iommufd_object_destroy_user() will return -EBUSY to

iommufd_object_destroy_user() returns false and iommufd_destroy
 retruns -EBUSY.

> + * userspace and refuse to destroy the object.
> + */
> +static inline void iommufd_ref_to_users(struct iommufd_object *obj)
> +{
> +	up_read(&obj->destroy_rwsem);
> +	/* iommufd_lock_obj() obtains users as well */
Do you have a way to check that put() is done in accordance, ie. we are
not going to try up_read() the rwsem if this latter is not used anymore?
> +}
> +void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj);
> +void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
> +				      struct iommufd_object *obj);
> +void iommufd_object_finalize(struct iommufd_ctx *ictx,
> +			     struct iommufd_object *obj);
> +bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
> +				 struct iommufd_object *obj);
> +struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> +					     size_t size,
> +					     enum iommufd_object_type type);
> +
> +#define iommufd_object_alloc(ictx, ptr, type)                                  \
> +	container_of(_iommufd_object_alloc(                                    \
> +			     ictx,                                             \
> +			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
> +						      offsetof(typeof(*(ptr)), \
> +							       obj) != 0),     \
> +			     type),                                            \
> +		     typeof(*(ptr)), obj)
> +
> +#endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> new file mode 100644
> index 00000000000000..3a705cadb85020
> --- /dev/null
> +++ b/drivers/iommu/iommufd/main.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2021 Intel Corporation
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + *
> + * iommufd provides control over the IOMMU HW objects created by IOMMU kernel
> + * drivers. IOMMU HW objects revolve around IO page tables that map incoming DMA
> + * addresses (IOVA) to CPU addresses.
> + */
> +#define pr_fmt(fmt) "iommufd: " fmt
> +
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mutex.h>
> +#include <linux/bug.h>
> +#include <uapi/linux/iommufd.h>
> +#include <linux/iommufd.h>
> +
> +#include "iommufd_private.h"
> +
> +struct iommufd_object_ops {
> +	void (*destroy)(struct iommufd_object *obj);
> +};
> +static const struct iommufd_object_ops iommufd_object_ops[];
> +
> +struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
> +					     size_t size,
> +					     enum iommufd_object_type type)
> +{
> +	struct iommufd_object *obj;
> +	int rc;
> +
> +	obj = kzalloc(size, GFP_KERNEL_ACCOUNT);
> +	if (!obj)
> +		return ERR_PTR(-ENOMEM);
> +	obj->type = type;
> +	init_rwsem(&obj->destroy_rwsem);
> +	refcount_set(&obj->users, 1);
> +
> +	/*
> +	 * Reserve an ID in the xarray but do not publish the pointer yet since
> +	 * the caller hasn't initialized it yet. Once the pointer is published
> +	 * in the xarray and visible to other threads we can't reliably destroy
> +	 * it anymore, so the caller must complete all errorable operations
> +	 * before calling iommufd_object_finalize().
> +	 */
> +	rc = xa_alloc(&ictx->objects, &obj->id, XA_ZERO_ENTRY,
> +		      xa_limit_32b, GFP_KERNEL_ACCOUNT);
> +	if (rc)
> +		goto out_free;
> +	return obj;
> +out_free:
> +	kfree(obj);
> +	return ERR_PTR(rc);
> +}
> +
> +/*
> + * Allow concurrent access to the object.
> + *
> + * Once another thread can see the object pointer it can prevent object
> + * destruction. Expect for special kernel-only objects there is no in-kernel way
> + * to reliably destroy a single object. Thus all APIs that are creating objects
> + * must use iommufd_object_abort() to handle their errors and only call
> + * iommufd_object_finalize() once object creation cannot fail.
> + */
> +void iommufd_object_finalize(struct iommufd_ctx *ictx,
> +			     struct iommufd_object *obj)
> +{
> +	void *old;
> +
> +	old = xa_store(&ictx->objects, obj->id, obj, GFP_KERNEL);
> +	/* obj->id was returned from xa_alloc() so the xa_store() cannot fail */
> +	WARN_ON(old);
> +}
> +
> +/* Undo _iommufd_object_alloc() if iommufd_object_finalize() was not called */
> +void iommufd_object_abort(struct iommufd_ctx *ictx, struct iommufd_object *obj)
> +{
> +	void *old;
> +
> +	old = xa_erase(&ictx->objects, obj->id);
> +	WARN_ON(old);
> +	kfree(obj);
> +}
> +
> +/*
> + * Abort an object that has been fully initialized and needs destroy, but has
> + * not been finalized.
> + */
> +void iommufd_object_abort_and_destroy(struct iommufd_ctx *ictx,
> +				      struct iommufd_object *obj)
> +{
> +	iommufd_object_ops[obj->type].destroy(obj);
> +	iommufd_object_abort(ictx, obj);
> +}
> +
> +struct iommufd_object *iommufd_get_object(struct iommufd_ctx *ictx, u32 id,
> +					  enum iommufd_object_type type)
> +{
> +	struct iommufd_object *obj;
> +
> +	xa_lock(&ictx->objects);
> +	obj = xa_load(&ictx->objects, id);
> +	if (!obj || (type != IOMMUFD_OBJ_ANY && obj->type != type) ||
> +	    !iommufd_lock_obj(obj))
> +		obj = ERR_PTR(-ENOENT);
> +	xa_unlock(&ictx->objects);
> +	return obj;
> +}
> +
> +/*
> + * The caller holds a users refcount and wants to destroy the object. Returns
> + * true if the object was destroyed. In all cases the caller no longer has a
> + * reference on obj.
> + */
> +bool iommufd_object_destroy_user(struct iommufd_ctx *ictx,
> +				 struct iommufd_object *obj)
> +{
> +	/*
> +	 * The purpose of the destroy_rwsem is to ensure deterministic
> +	 * destruction of objects used by external drivers and destroyed by this
> +	 * function. Any temporary increment of the refcount must hold the read
> +	 * side of this, such as during ioctl execution.
> +	 */
> +	down_write(&obj->destroy_rwsem);
> +	xa_lock(&ictx->objects);
> +	refcount_dec(&obj->users);
> +	if (!refcount_dec_if_one(&obj->users)) {
> +		xa_unlock(&ictx->objects);
> +		up_write(&obj->destroy_rwsem);
> +		return false;
> +	}
> +	__xa_erase(&ictx->objects, obj->id);
> +	xa_unlock(&ictx->objects);
> +	up_write(&obj->destroy_rwsem);
> +
> +	iommufd_object_ops[obj->type].destroy(obj);
> +	kfree(obj);
> +	return true;
> +}
> +
> +static int iommufd_destroy(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_destroy *cmd = ucmd->cmd;
> +	struct iommufd_object *obj;
> +
> +	obj = iommufd_get_object(ucmd->ictx, cmd->id, IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(obj))
> +		return PTR_ERR(obj);
> +	iommufd_ref_to_users(obj);
> +	/* See iommufd_ref_to_users() */
> +	if (!iommufd_object_destroy_user(ucmd->ictx, obj))
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static int iommufd_fops_open(struct inode *inode, struct file *filp)
> +{
> +	struct iommufd_ctx *ictx;
> +
> +	ictx = kzalloc(sizeof(*ictx), GFP_KERNEL_ACCOUNT);
> +	if (!ictx)
> +		return -ENOMEM;
> +
> +	xa_init_flags(&ictx->objects, XA_FLAGS_ALLOC1 | XA_FLAGS_ACCOUNT);
> +	ictx->file = filp;
> +	filp->private_data = ictx;
> +	return 0;
> +}
> +
> +static int iommufd_fops_release(struct inode *inode, struct file *filp)
> +{
> +	struct iommufd_ctx *ictx = filp->private_data;
> +	struct iommufd_object *obj;
> +
> +	/* Destroy the graph from depth first */
I would suggest: destroy the leaf objects first thanks to the
hierarchical user ref counting? or something alike
> +	while (!xa_empty(&ictx->objects)) {
> +		unsigned int destroyed = 0;
> +		unsigned long index;
> +
> +		xa_for_each(&ictx->objects, index, obj) {
> +			/*
> +			 * Since we are in release elevated users must come from
> +			 * other objects holding the users. We will eventually
the sentense sounds a bit cryptic to me.
> +			 * destroy the object that holds this one and the next
> +			 * pass will progress it.
> +			 */
> +			if (!refcount_dec_if_one(&obj->users))
> +				continue;
> +			destroyed++;
> +			xa_erase(&ictx->objects, index);
> +			iommufd_object_ops[obj->type].destroy(obj);
> +			kfree(obj);

Use iommufd_object_abort_and_destroy(obj) instead of the above 3 lines?

> +		}
> +		/* Bug related to users refcount */
> +		if (WARN_ON(!destroyed))
> +			break;
> +	}
> +	kfree(ictx);
> +	return 0;
> +}
> +
> +union ucmd_buffer {
> +	struct iommu_destroy destroy;
> +};
> +
> +struct iommufd_ioctl_op {
> +	unsigned int size;
> +	unsigned int min_size;
> +	unsigned int ioctl_num;
> +	int (*execute)(struct iommufd_ucmd *ucmd);
> +};
> +
> +#define IOCTL_OP(_ioctl, _fn, _struct, _last)                                  \
> +	[_IOC_NR(_ioctl) - IOMMUFD_CMD_BASE] = {                               \
> +		.size = sizeof(_struct) +                                      \
> +			BUILD_BUG_ON_ZERO(sizeof(union ucmd_buffer) <          \
> +					  sizeof(_struct)),                    \
> +		.min_size = offsetofend(_struct, _last),                       \
> +		.ioctl_num = _ioctl,                                           \
> +		.execute = _fn,                                                \
> +	}
> +static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
> +	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
> +};
> +
> +static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	const struct iommufd_ioctl_op *op;
> +	struct iommufd_ucmd ucmd = {};
> +	union ucmd_buffer buf;
> +	unsigned int nr;
> +	int ret;
> +
> +	ucmd.ictx = filp->private_data;
> +	ucmd.ubuffer = (void __user *)arg;
> +	ret = get_user(ucmd.user_size, (u32 __user *)ucmd.ubuffer);
> +	if (ret)
> +		return ret;
> +
> +	nr = _IOC_NR(cmd);
> +	if (nr < IOMMUFD_CMD_BASE ||
> +	    (nr - IOMMUFD_CMD_BASE) >= ARRAY_SIZE(iommufd_ioctl_ops))
> +		return -ENOIOCTLCMD;
> +	op = &iommufd_ioctl_ops[nr - IOMMUFD_CMD_BASE];
> +	if (op->ioctl_num != cmd)
> +		return -ENOIOCTLCMD;
> +	if (ucmd.user_size < op->min_size)
> +		return -EINVAL;
> +
> +	ucmd.cmd = &buf;
> +	ret = copy_struct_from_user(ucmd.cmd, op->size, ucmd.ubuffer,
> +				    ucmd.user_size);
> +	if (ret)
> +		return ret;
> +	ret = op->execute(&ucmd);
> +	return ret;
> +}
> +
> +static const struct file_operations iommufd_fops = {
> +	.owner = THIS_MODULE,
> +	.open = iommufd_fops_open,
> +	.release = iommufd_fops_release,
> +	.unlocked_ioctl = iommufd_fops_ioctl,
> +};
> +
> +/**
> + * iommufd_ctx_get - Get a context reference
> + * @ictx: Context to get
> + *
> + * The caller must already hold a valid reference to ictx.
> + */
> +void iommufd_ctx_get(struct iommufd_ctx *ictx)
> +{
> +	get_file(ictx->file);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_get, IOMMUFD);
> +
> +/**
> + * iommufd_ctx_from_file - Acquires a reference to the iommufd context
> + * @file: File to obtain the reference from
> + *
> + * Returns a pointer to the iommufd_ctx, otherwise ERR_PTR. The struct file
> + * remains owned by the caller and the caller must still do fput. On success
> + * the caller is responsible to call iommufd_ctx_put().
> + */
> +struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
> +{
> +	struct iommufd_ctx *ictx;
> +
> +	if (file->f_op != &iommufd_fops)
> +		return ERR_PTR(-EBADFD);
> +	ictx = file->private_data;
> +	iommufd_ctx_get(ictx);
> +	return ictx;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_from_file, IOMMUFD);
> +
> +/**
> + * iommufd_ctx_put - Put back a reference
> + * @ictx: Context to put back
> + */
> +void iommufd_ctx_put(struct iommufd_ctx *ictx)
> +{
> +	fput(ictx->file);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
> +
> +static const struct iommufd_object_ops iommufd_object_ops[] = {
> +};
> +
> +static struct miscdevice iommu_misc_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "iommu",
> +	.fops = &iommufd_fops,
> +	.nodename = "iommu",
> +	.mode = 0660,
> +};
> +
> +static int __init iommufd_init(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&iommu_misc_dev);
> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static void __exit iommufd_exit(void)
> +{
> +	misc_deregister(&iommu_misc_dev);
> +}
> +
> +module_init(iommufd_init);
> +module_exit(iommufd_exit);
> +
> +MODULE_DESCRIPTION("I/O Address Space Management for passthrough devices");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> new file mode 100644
> index 00000000000000..d1817472c27373
> --- /dev/null
> +++ b/include/linux/iommufd.h
> @@ -0,0 +1,31 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2021 Intel Corporation
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#ifndef __LINUX_IOMMUFD_H
> +#define __LINUX_IOMMUFD_H
> +
> +#include <linux/types.h>
> +#include <linux/errno.h>
> +#include <linux/err.h>
> +
> +struct iommufd_ctx;
> +struct file;
> +
> +void iommufd_ctx_get(struct iommufd_ctx *ictx);
> +
> +#if IS_ENABLED(CONFIG_IOMMUFD)
> +struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
> +void iommufd_ctx_put(struct iommufd_ctx *ictx);
> +#else /* !CONFIG_IOMMUFD */
> +static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
> +{
> +}
> +#endif /* CONFIG_IOMMUFD */
> +#endif
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> new file mode 100644
> index 00000000000000..2ad06b27a35fe5
> --- /dev/null
> +++ b/include/uapi/linux/iommufd.h
> @@ -0,0 +1,55 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES.
> + */
> +#ifndef _UAPI_IOMMUFD_H
> +#define _UAPI_IOMMUFD_H
> +
> +#include <linux/types.h>
> +#include <linux/ioctl.h>
> +
> +#define IOMMUFD_TYPE (';')
> +
> +/**
> + * DOC: General ioctl format
> + *
> + * The ioctl interface follows a general format to allow for extensibility. Each
> + * ioctl is passed in a structure pointer as the argument providing the size of
> + * the structure in the first u32. The kernel checks that any structure space
> + * beyond what it understands is 0. This allows userspace to use the backward
> + * compatible portion while consistently using the newer, larger, structures.
> + *
> + * ioctls use a standard meaning for common errnos:
> + *
> + *  - ENOTTY: The IOCTL number itself is not supported at all
> + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> + *    non-zero in a part the kernel does not understand.
> + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> + *    understood, however a known field has a value the kernel does not
> + *    understand or support.
> + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> + *    correct.
> + *  - ENOENT: An ID or IOVA provided does not exist.
> + *  - ENOMEM: Out of memory.
> + *  - EOVERFLOW: Mathematics oveflowed.
overflowed
> + *
> + * As well as additional errnos, within specific ioctls.
> + */
> +enum {
> +	IOMMUFD_CMD_BASE = 0x80,
> +	IOMMUFD_CMD_DESTROY = IOMMUFD_CMD_BASE,
> +};
> +
> +/**
> + * struct iommu_destroy - ioctl(IOMMU_DESTROY)
> + * @size: sizeof(struct iommu_destroy)
> + * @id: iommufd object ID to destroy. Can by any destroyable object type.
> + *
> + * Destroy any object held within iommufd.
> + */
> +struct iommu_destroy {
> +	__u32 size;
> +	__u32 id;
> +};
> +#define IOMMU_DESTROY _IO(IOMMUFD_TYPE, IOMMUFD_CMD_DESTROY)
> +
> +#endif
Thanks

Eric

