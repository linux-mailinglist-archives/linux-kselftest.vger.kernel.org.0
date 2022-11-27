Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAA639B82
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Nov 2022 16:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiK0PNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Nov 2022 10:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiK0PNb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Nov 2022 10:13:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84DCDC
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Nov 2022 07:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669561949;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0wiRNFjSfwxayhwReKk2HhCdJf+ke5EttJUm2mT+i4=;
        b=fJNTJoQ4fr+fiKR3qmZEAr1vomap6CnYUs1kpLYufldgcxTvXjU2wzxk59iNl5xpk9KXhW
        LS9rUrFgwdazsMRbz2RDSoDZm+xB4lVp0NQEgq1eLpR76KVYOrYZT1uCl9CWdcmDPdyISq
        s03fA4BNzf2QCrUWCS5ZF9VRXaKNroM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-101-Pz4e--WVNVmV-ZUlawCv3w-1; Sun, 27 Nov 2022 10:12:20 -0500
X-MC-Unique: Pz4e--WVNVmV-ZUlawCv3w-1
Received: by mail-qk1-f200.google.com with SMTP id br8-20020a05620a460800b006fbf8866293so14055519qkb.2
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Nov 2022 07:12:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0wiRNFjSfwxayhwReKk2HhCdJf+ke5EttJUm2mT+i4=;
        b=5prhRaeiu87OURIwmc3FF0L5z3sickzoxi+WQcn57Ze1IpB0YmEy7gFP3f7SfRe+3t
         YsUSIX4kwM73gGc8OucN+uqyTtgEhdsmQxyUAI7e+8WXZAn+l0kF05Fsu3V4u2Pu3CQA
         U397qunCH/bXVG4P/mVQunvf0Ri+ARCWdHCoNu9GdQLMs5/RwVxDLcTY1MARAU3GBcqp
         +HYXF9bQxgtx2RMK5TwU2p4hXAm8C8B6v/UPA6PgkWyxlFW0PdoFIAyF4MfYN920iBgS
         do2vpB1+1y2U/VZkhO0gEFnxvCPBFXydaIhSbrgvqtcKKHwLydf4uJEZ3YV+UjMjDJST
         ir+g==
X-Gm-Message-State: ANoB5pkTeAxqTBueeKMl22xBJHjWHpSouWSeeia5tjVpl3K5XggAP8O8
        sXXbGG9mhfUeAZMTpLzdYxzWDiYgmqVc8C83uQ0OLfV58keTWgwGYrGdiA+rNLfblM0pxXXOnhz
        5AyG8EQrwMabLGQo5nqoSsAIeUKg4
X-Received: by 2002:ac8:41ca:0:b0:3a5:6d50:7f39 with SMTP id o10-20020ac841ca000000b003a56d507f39mr43685447qtm.520.1669561940381;
        Sun, 27 Nov 2022 07:12:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FIGBQMs4mdaEfvQ4YaXsydmwTyqPu/CYEBG9rDFeez+Q924zAUFLRipm1jW/U1yXVCME7aQ==
X-Received: by 2002:ac8:41ca:0:b0:3a5:6d50:7f39 with SMTP id o10-20020ac841ca000000b003a56d507f39mr43685406qtm.520.1669561940087;
        Sun, 27 Nov 2022 07:12:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id w30-20020a05620a0e9e00b006faaf6dc55asm6458946qkm.22.2022.11.27.07.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 07:12:18 -0800 (PST)
Message-ID: <84c2c942-055b-b500-f209-5f8839113ef0@redhat.com>
Date:   Sun, 27 Nov 2022 16:12:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 12/19] iommufd: Add a HW pagetable object
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
References: <12-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <12-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
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

Hi Jason,

On 11/16/22 22:00, Jason Gunthorpe wrote:
> The hw_pagetable object exposes the internal struct iommu_domain's to
> userspace. An iommu_domain is required when any DMA device attaches to an
> IOAS to control the io page table through the iommu driver.
>
> For compatibility with VFIO the hw_pagetable is automatically created when
> a DMA device is attached to the IOAS. If a compatible iommu_domain already
> exists then the hw_pagetable associated with it is used for the
> attachment.
>
> In the initial series there is no iommufd uAPI for the hw_pagetable
> object. The next patch provides driver facing APIs for IO page table
> attachment that allows drivers to accept either an IOAS or a hw_pagetable
> ID and for the driver to return the hw_pagetable ID that was auto-selected
> from an IOAS. The expectation is the driver will provide uAPI through its
> own FD for attaching its device to iommufd. This allows userspace to learn
> the mapping of devices to iommu_domains and to override the automatic
> attachment.
>
> The future HW specific interface will allow userspace to create
> hw_pagetable objects using iommu_domains with IOMMU driver specific
> parameters. This infrastructure will allow linking those domains to IOAS's
> and devices.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  1 +
>  drivers/iommu/iommufd/hw_pagetable.c    | 57 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/ioas.c            |  3 ++
>  drivers/iommu/iommufd/iommufd_private.h | 33 ++++++++++++++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  5 files changed, 97 insertions(+)
>  create mode 100644 drivers/iommu/iommufd/hw_pagetable.c
>
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 2b4f36f1b72f9d..e13e971aa28c60 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iommufd-y := \
> +	hw_pagetable.o \
>  	io_pagetable.o \
>  	ioas.o \
>  	main.o \
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> new file mode 100644
> index 00000000000000..43d473989a0667
> --- /dev/null
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -0,0 +1,57 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommu.h>
> +
> +#include "iommufd_private.h"
> +
> +void iommufd_hw_pagetable_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_hw_pagetable *hwpt =
> +		container_of(obj, struct iommufd_hw_pagetable, obj);
> +
> +	WARN_ON(!list_empty(&hwpt->devices));
> +
> +	iommu_domain_free(hwpt->domain);
> +	refcount_dec(&hwpt->ioas->obj.users);
> +	mutex_destroy(&hwpt->devices_lock);
> +}
> +
> +/**
> + * iommufd_hw_pagetable_alloc() - Get an iommu_domain for a device
> + * @ictx: iommufd context
> + * @ioas: IOAS to associate the domain with
> + * @dev: Device to get an iommu_domain for
> + *
> + * Allocate a new iommu_domain and return it as a hw_pagetable.
> + */
> +struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> +			   struct device *dev)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	hwpt = iommufd_object_alloc(ictx, hwpt, IOMMUFD_OBJ_HW_PAGETABLE);
> +	if (IS_ERR(hwpt))
> +		return hwpt;
> +
> +	hwpt->domain = iommu_domain_alloc(dev->bus);
> +	if (!hwpt->domain) {
> +		rc = -ENOMEM;
> +		goto out_abort;
> +	}
> +
> +	INIT_LIST_HEAD(&hwpt->devices);
> +	INIT_LIST_HEAD(&hwpt->hwpt_item);
> +	mutex_init(&hwpt->devices_lock);
> +	/* Pairs with iommufd_hw_pagetable_destroy() */
> +	refcount_inc(&ioas->obj.users);
> +	hwpt->ioas = ioas;
> +	return hwpt;
> +
> +out_abort:
> +	iommufd_object_abort(ictx, &hwpt->obj);
> +	return ERR_PTR(rc);
> +}
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index 7671456e86413a..64e6d0f73e39aa 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -17,6 +17,7 @@ void iommufd_ioas_destroy(struct iommufd_object *obj)
>  	rc = iopt_unmap_all(&ioas->iopt, NULL);
>  	WARN_ON(rc && rc != -ENOENT);
>  	iopt_destroy_table(&ioas->iopt);
> +	mutex_destroy(&ioas->mutex);
>  }
>  
>  struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
> @@ -28,6 +29,8 @@ struct iommufd_ioas *iommufd_ioas_alloc(struct iommufd_ctx *ictx)
>  		return ioas;
>  
>  	iopt_init_table(&ioas->iopt);
> +	INIT_LIST_HEAD(&ioas->hwpt_list);
> +	mutex_init(&ioas->mutex);
>  	return ioas;
>  }
>  
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6721332dbbba03..bb5cbd8f4e5991 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -103,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
>  enum iommufd_object_type {
>  	IOMMUFD_OBJ_NONE,
>  	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_HW_PAGETABLE,
>  	IOMMUFD_OBJ_IOAS,
>  };
>  
> @@ -181,10 +182,20 @@ struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>   * io_pagetable object. It is a user controlled mapping of IOVA -> PFNs. The
>   * mapping is copied into all of the associated domains and made available to
>   * in-kernel users.
> + *
> + * Every iommu_domain that is created is wrapped in a iommufd_hw_pagetable
> + * object. When we go to attach a device to an IOAS we need to get an
> + * iommu_domain and wrapping iommufd_hw_pagetable for it.
> + *
> + * An iommu_domain & iommfd_hw_pagetable will be automatically selected
> + * for a device based on the hwpt_list. If no suitable iommu_domain
> + * is found a new iommu_domain will be created.
>   */
>  struct iommufd_ioas {
>  	struct iommufd_object obj;
>  	struct io_pagetable iopt;
> +	struct mutex mutex;+	struct list_head hwpt_list;
>  };
>  
>  static inline struct iommufd_ioas *iommufd_get_ioas(struct iommufd_ucmd *ucmd,
> @@ -207,6 +218,28 @@ int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>  int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>  			       struct iommufd_ctx *ictx);
>  
> +/*
> + * A HW pagetable is called an iommu_domain inside the kernel. This user object
> + * allows directly creating and inspecting the domains. Domains that have kernel
> + * owned page tables will be associated with an iommufd_ioas that provides the
> + * IOVA to PFN map.
> + */
> +struct iommufd_hw_pagetable {
> +	struct iommufd_object obj;
> +	struct iommufd_ioas *ioas;
> +	struct iommu_domain *domain;
> +	bool auto_domain : 1;
> +	/* Head at iommufd_ioas::hwpt_list */
> +	struct list_head hwpt_item;
> +	struct mutex devices_lock;
> +	struct list_head devices;
> +};
> +
> +struct iommufd_hw_pagetable *
> +iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> +			   struct device *dev);
> +void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
> +
>  struct iommufd_access {
>  	unsigned long iova_alignment;
>  	u32 iopt_access_list_id;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 266109045537ed..3eab714b8e12a3 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -355,6 +355,9 @@ static const struct iommufd_object_ops iommufd_object_ops[] = {
>  	[IOMMUFD_OBJ_IOAS] = {
>  		.destroy = iommufd_ioas_destroy,
>  	},
> +	[IOMMUFD_OBJ_HW_PAGETABLE] = {
> +		.destroy = iommufd_hw_pagetable_destroy,
> +	},
>  };
>  
>  static struct miscdevice iommu_misc_dev = {


Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

