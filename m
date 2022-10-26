Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445A860E150
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 14:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiJZM65 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Oct 2022 08:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiJZM6y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Oct 2022 08:58:54 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69903F7090;
        Wed, 26 Oct 2022 05:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666789133; x=1698325133;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=/IWbRFH6kjjYn7+cTo0TyKj63A0ZKGpnYCe92d1aOOI=;
  b=aN0qVSvQKN8WLTTRDM7A9Fs5V8fA1cpinwBQ//B1+m/3IyydNzfj7a8e
   mqte6HkF1Bnr6g3bMlXaUP+pjRzNX/oWFigKCXLv2X4vpFk2VRxBQ26yZ
   YnUtCJZEUn+DX9pNgmkulIOrsQApcV/1DK/eAn5g14p8T9mP9ZQFxLTbz
   Z/fqHhb5IGhTmre+WA5ROY/HRb1P315yXhbKTcCR8fWlR1u/Vkri6aAFj
   h1ATVPeqjk9X8+hjayov7xqWjRUAshEXv4VP7rNEf3TcWChHuWYSAsho8
   y8KcaHnZifgPxUf2sDx/PFnLTDygXvZIBKpN7BeyvTPxOL8mJcVlbhzcD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="307931295"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="307931295"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:58:33 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="695352917"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="695352917"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.188]) ([10.254.213.188])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 05:58:25 -0700
Message-ID: <9a837538-6333-0973-c6f4-229064026330@linux.intel.com>
Date:   Wed, 26 Oct 2022 20:58:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Cc:     baolu.lu@linux.intel.com,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
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
References: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v3 05/15] iommufd: File descriptor, context, kconfig and
 makefiles
In-Reply-To: <5-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

Some nits below.

On 2022/10/26 2:12, Jason Gunthorpe wrote:
> This is the basic infrastructure of a new miscdevice to hold the iommufd
> IOCTL API.
> 
> It provides:
>   - A miscdevice to create file descriptors to run the IOCTL interface over
> 
>   - A table based ioctl dispatch and centralized extendable pre-validation
>     step
> 
>   - An xarray mapping userspace ID's to kernel objects. The design has
>     multiple inter-related objects held within in a single IOMMUFD fd
> 
>   - A simple usage count to build a graph of object relations and protect
>     against hostile userspace racing ioctls
> 
> The only IOCTL provided in this patch is the generic 'destroy any object
> by handle' operation.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---

[---8<---]

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
> +static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {

How about making the ops "static const"?

> +	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct iommu_destroy, id),
> +};
> +
> +static long iommufd_fops_ioctl(struct file *filp, unsigned int cmd,
> +			       unsigned long arg)
> +{
> +	struct iommufd_ucmd ucmd = {};
> +	struct iommufd_ioctl_op *op;
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
> +		return -EOPNOTSUPP;
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

[---8<---]

> +
> +static int __init iommufd_init(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&iommu_misc_dev);
> +	if (ret) {
> +		pr_err("Failed to register misc device\n");
> +		return ret;
> +	}
> +
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

Could above be "GPL v2"?

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
> index 00000000000000..b77b7eb0aeb13c
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
> + * The ioctl mechanims follows a general format to allow for extensibility. Each
                 ^^^^^^^^^ mechanism?

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

Best regards,
baolu
