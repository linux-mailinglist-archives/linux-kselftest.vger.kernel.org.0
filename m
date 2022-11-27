Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030FD639D2D
	for <lists+linux-kselftest@lfdr.de>; Sun, 27 Nov 2022 22:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiK0VPF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 27 Nov 2022 16:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiK0VPE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 27 Nov 2022 16:15:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49389BCAB
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Nov 2022 13:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669583646;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fwHdMOhgpstrFbXaSBg5O1UOHJMFYkpZCAOqe3coWHQ=;
        b=BGTmNatM+hd3KBWqFar3p/vqWzh9h1EKivKbAA/wSb1LO1unq2mT2TpBqO75dKrAJmDWYU
        pmwZbUjg+g4/xgAd2EvlJrRH2EXCsaCYsVwJ1xqyoCv4K1p6ws9U4NiCL2I8kqR17zesrv
        UomC6aZ/UtjILG3RhXWCWIReiFtR6kI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-532-IZ4IXlE9MySJCL5_pL1BfQ-1; Sun, 27 Nov 2022 16:14:05 -0500
X-MC-Unique: IZ4IXlE9MySJCL5_pL1BfQ-1
Received: by mail-qk1-f197.google.com with SMTP id br8-20020a05620a460800b006fbf8866293so15525576qkb.2
        for <linux-kselftest@vger.kernel.org>; Sun, 27 Nov 2022 13:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fwHdMOhgpstrFbXaSBg5O1UOHJMFYkpZCAOqe3coWHQ=;
        b=o+aN8GoE/+lNlLxKKp66aIqjeCHalrVEEWtixvEUJDjwYDwfAbg6LK4Mv06r6+F161
         IazILZD/5ErGmcLVSqeqXVcTn8rjRvQsOgJanq0ra7w9/B/7QrKR3AVNQQg560aGHRJq
         jZYh+bJbu4cVbKM+5jeRGw7IG5F0wBk+lI3VQkll6Goj38GJgtz9FuL8+vYB5x6jOgXi
         eDVmcynbov4YI2ZkDv8x3OSEwth7kYsPsxcfabUom0J02DiY44VaeK6bGzavP+tczfq3
         tjoyIxg1N+znzI6si/FF+sh4ugoVS49Wy2BS3U/TIuj90AzDp9SQ+lCjqchhLoar7jDN
         TlMw==
X-Gm-Message-State: ANoB5plxiUbvAf3d0454YM57zw5HzcgvslNjZGe7N7wVPDJpKiEVaZKf
        xRaq5XhjwMbuu1iNeAS2nHgddDUxAoZfXxQZGuiAIPmIlenqBZfeBGXwfiQm+dZDYVCLBIdzE04
        fQDXSI2A6ejvlcbk45VT2eRyzLBop
X-Received: by 2002:ac8:5ece:0:b0:3a5:6f39:4bd8 with SMTP id s14-20020ac85ece000000b003a56f394bd8mr45629537qtx.228.1669583644382;
        Sun, 27 Nov 2022 13:14:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/FfZ+2iJt6LS6WXc0FH8xBWqOf6iKFlr58RsPnBjaNS7MA0xQPKHlGLZOSp1uvcoQYmmMeg==
X-Received: by 2002:ac8:5ece:0:b0:3a5:6f39:4bd8 with SMTP id s14-20020ac85ece000000b003a56f394bd8mr45629480qtx.228.1669583643884;
        Sun, 27 Nov 2022 13:14:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8464e000000b003a5612c3f28sm5793726qto.56.2022.11.27.13.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 13:14:02 -0800 (PST)
Message-ID: <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
Date:   Sun, 27 Nov 2022 22:13:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
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
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Jason,

On 11/16/22 22:00, Jason Gunthorpe wrote:
> Add the four functions external drivers need to connect physical DMA to
> the IOMMUFD:
>
> iommufd_device_bind() / iommufd_device_unbind()
>   Register the device with iommufd and establish security isolation.
>
> iommufd_device_attach() / iommufd_device_detach()
>   Connect a bound device to a page table
>
> Binding a device creates a device object ID in the uAPI, however the
> generic API provides no IOCTLs to manipulate them.
(yet)
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/Makefile          |   1 +
>  drivers/iommu/iommufd/device.c          | 417 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |   5 +
>  drivers/iommu/iommufd/main.c            |   3 +
>  include/linux/iommufd.h                 |  13 +
>  5 files changed, 439 insertions(+)
>  create mode 100644 drivers/iommu/iommufd/device.c
>
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index e13e971aa28c60..ca28a135b9675f 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  iommufd-y := \
> +	device.o \
>  	hw_pagetable.o \
>  	io_pagetable.o \
>  	ioas.o \
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> new file mode 100644
> index 00000000000000..a71f5740773f84
> --- /dev/null
> +++ b/drivers/iommu/iommufd/device.c
> @@ -0,0 +1,417 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommufd.h>
> +#include <linux/slab.h>
> +#include <linux/iommu.h>
> +#include <linux/irqdomain.h>
> +
> +#include "iommufd_private.h"
> +
> +/*
> + * A iommufd_device object represents the binding relationship between a
> + * consuming driver and the iommufd. These objects are created/destroyed by
> + * external drivers, not by userspace.
> + */
> +struct iommufd_device {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_hw_pagetable *hwpt;
> +	/* Head at iommufd_hw_pagetable::devices */
> +	struct list_head devices_item;
> +	/* always the physical device */
> +	struct device *dev;
> +	struct iommu_group *group;
> +	bool enforce_cache_coherency;
> +};
> +
> +void iommufd_device_destroy(struct iommufd_object *obj)
> +{
> +	struct iommufd_device *idev =
> +		container_of(obj, struct iommufd_device, obj);
> +
> +	iommu_device_release_dma_owner(idev->dev);
> +	iommu_group_put(idev->group);
> +	iommufd_ctx_put(idev->ictx);
> +}
> +
> +/**
> + * iommufd_device_bind - Bind a physical device to an iommu fd
> + * @ictx: iommufd file descriptor
> + * @dev: Pointer to a physical PCI device struct
not a PCI dev anymore
> + * @id: Output ID number to return to userspace for this device
> + *
> + * A successful bind establishes an ownership over the device and returns
> + * struct iommufd_device pointer, otherwise returns error pointer.
> + *
> + * A driver using this API must set driver_managed_dma and must not touch
> + * the device until this routine succeeds and establishes ownership.
> + *
> + * Binding a PCI device places the entire RID under iommufd control.
> + *
> + * The caller must undo this with iommufd_device_unbind()
> + */
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id)
> +{
> +	struct iommufd_device *idev;
> +	struct iommu_group *group;
> +	int rc;
> +
> +	/*
> +	 * iommufd always sets IOMMU_CACHE because we offer no way for userspace
> +	 * to restore cache coherency.
> +	 */
> +	if (!device_iommu_capable(dev, IOMMU_CAP_CACHE_COHERENCY))
> +		return ERR_PTR(-EINVAL);
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return ERR_PTR(-ENODEV);
> +
> +	rc = iommu_device_claim_dma_owner(dev, ictx);
> +	if (rc)
> +		goto out_group_put;
> +
> +	idev = iommufd_object_alloc(ictx, idev, IOMMUFD_OBJ_DEVICE);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_release_owner;
> +	}
> +	idev->ictx = ictx;
> +	iommufd_ctx_get(ictx);
> +	idev->dev = dev;
> +	idev->enforce_cache_coherency =
> +		device_iommu_capable(dev, IOMMU_CAP_ENFORCE_CACHE_COHERENCY);
> +	/* The calling driver is a user until iommufd_device_unbind() */
> +	refcount_inc(&idev->obj.users);
> +	/* group refcount moves into iommufd_device */
> +	idev->group = group;
> +
> +	/*
> +	 * If the caller fails after this success it must call
> +	 * iommufd_unbind_device() which is safe since we hold this refcount.
> +	 * This also means the device is a leaf in the graph and no other object
> +	 * can take a reference on it.
> +	 */
> +	iommufd_object_finalize(ictx, &idev->obj);
> +	*id = idev->obj.id;
> +	return idev;
> +
> +out_release_owner:
> +	iommu_device_release_dma_owner(dev);
> +out_group_put:
> +	iommu_group_put(group);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_bind, IOMMUFD);
> +
> +/**
> + * iommufd_device_unbind - Undo iommufd_device_bind()
> + * @idev: Device returned by iommufd_device_bind()
> + *
> + * Release the device from iommufd control. The DMA ownership will return back
> + * to unowned with DMA controlled by the DMA API. This invalidates the
> + * iommufd_device pointer, other APIs that consume it must not be called
> + * concurrently.
> + */
> +void iommufd_device_unbind(struct iommufd_device *idev)
> +{
> +	bool was_destroyed;
> +
> +	was_destroyed = iommufd_object_destroy_user(idev->ictx, &idev->obj);
> +	WARN_ON(!was_destroyed);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_unbind, IOMMUFD);
> +
> +static int iommufd_device_setup_msi(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt,
> +				    phys_addr_t sw_msi_start,
> +				    unsigned int flags)
> +{
> +	int rc;
> +
> +	/*
> +	 * IOMMU_CAP_INTR_REMAP means that the platform is isolating MSI, and it
rather means that the *IOMMU* implements IRQ remapping.

irq_domain_check_msi_remap() instead means the MSI controller implements that functionality (a given device id is able to trigger MSI #n and this #n gets translated into actual MSI #m)
So what you want is to prevent an assigned device from being able to DMA into an MSI doorbell that is not protected by either the IOMMU or the MSI controller. If this happens this means the DMA can generate any kind of MSI traffic that can jeopardize the host or other VMs

To me this is independent on the the fact that the IOMMU translates MSI write requests (targetting the @ where the MSI message is written), so independent on the fact a SW MSI reserved region is exposed. 

That's why in the vfio_iommu_type.c the msi_recap capability is first checked:

        msi_remap = irq_domain_check_msi_remap() ||
                    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
                                             vfio_iommu_device_capable);

        if (!vfio_allow_unsafe_interrupts && !msi_remap) {
                pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
                       __func__);
                ret = -EPERM;
                goto out_detach;
        }


and afterwards resv_msi is checked to see if we need to create the so-called msi cookie.
This msi cookie tells the MSI writes are translated by the IOMMU and somebody must create a mapping for those transactions.

> +	 * creates the MSI window by default in the iommu domain. Nothing
> +	 * further to do.
> +	 */
> +	if (device_iommu_capable(idev->dev, IOMMU_CAP_INTR_REMAP))
> +		return 0;
> +
> +	/*
> +	 * On ARM systems that set the global IRQ_DOMAIN_FLAG_MSI_REMAP every
> +	 * allocated iommu_domain will block interrupts by default and this
It sounds there is a confusion between IRQ remapping and the fact MSI
writes are not bypassed by the IOMMU.
> +	 * special flow is needed to turn them back on. iommu_dma_prepare_msi()
> +	 * will install pages into our domain after request_irq() to make this
> +	 * work.
> +	 *
> +	 * FIXME: This is conceptually broken for iommufd since we want to allow
> +	 * userspace to change the domains, eg switch from an identity IOAS to a
> +	 * DMA IOAS. There is currently no way to create a MSI window that
> +	 * matches what the IRQ layer actually expects in a newly created
> +	 * domain.
> +	 */
> +	if (irq_domain_check_msi_remap()) {
> +		if (WARN_ON(!sw_msi_start))
> +			return -EPERM;
> +		/*
> +		 * iommu_get_msi_cookie() can only be called once per domain,
> +		 * it returns -EBUSY on later calls.
> +		 */
> +		if (hwpt->msi_cookie)
> +			return 0;
> +		rc = iommu_get_msi_cookie(hwpt->domain, sw_msi_start);
> +		if (rc)
> +			return rc;
> +		hwpt->msi_cookie = true;
> +		return 0;
> +	}
> +
> +	/*
> +	 * Otherwise the platform has a MSI window that is not isolated. For
> +	 * historical compat with VFIO allow a module parameter to ignore the
> +	 * insecurity.
> +	 */
> +	if (!(flags & IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT))
> +		return -EPERM;
> +
> +	dev_warn(
> +		idev->dev,
> +		"Device interrupts cannot be isolated by the IOMMU, this platform in insecure. Use an \"allow_unsafe_interrupts\" module parameter to override\n");
> +	return 0;
> +}
> +
> +static bool iommufd_hw_pagetable_has_group(struct iommufd_hw_pagetable *hwpt,
> +					   struct iommu_group *group)
> +{
> +	struct iommufd_device *cur_dev;
> +
> +	list_for_each_entry(cur_dev, &hwpt->devices, devices_item)
> +		if (cur_dev->group == group)
> +			return true;
> +	return false;
> +}
> +
> +static int iommufd_device_do_attach(struct iommufd_device *idev,
> +				    struct iommufd_hw_pagetable *hwpt,
> +				    unsigned int flags)
> +{
> +	phys_addr_t sw_msi_start = 0;
> +	int rc;
> +
> +	mutex_lock(&hwpt->devices_lock);
> +
> +	/*
> +	 * Try to upgrade the domain we have, it is an iommu driver bug to
> +	 * report IOMMU_CAP_ENFORCE_CACHE_COHERENCY but fail
> +	 * enforce_cache_coherency when there are no devices attached to the
> +	 * domain.
> +	 */
> +	if (idev->enforce_cache_coherency && !hwpt->enforce_cache_coherency) {
> +		if (hwpt->domain->ops->enforce_cache_coherency)
> +			hwpt->enforce_cache_coherency =
> +				hwpt->domain->ops->enforce_cache_coherency(
> +					hwpt->domain);
> +		if (!hwpt->enforce_cache_coherency) {
> +			WARN_ON(list_empty(&hwpt->devices));
> +			rc = -EINVAL;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	rc = iopt_table_enforce_group_resv_regions(&hwpt->ioas->iopt, idev->dev,
> +						   idev->group, &sw_msi_start);
> +	if (rc)
> +		goto out_unlock;
> +
so in the case of any IOMMU_RESV_MSI, iommufd_device_setup_msi() will be
called with *sw_msi_start = 0 which will return -EPERM?
I don't think this is what we want. In that case I think we want the
RESV_MSI region to be taken into account as a RESV region but we don't
need the MSI cookie.
> +	rc = iommufd_device_setup_msi(idev, hwpt, sw_msi_start, flags);
> +	if (rc)
> +		goto out_iova;
> +
> +	/*
> +	 * FIXME: Hack around missing a device-centric iommu api, only attach to
> +	 * the group once for the first device that is in the group.
> +	 */
> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		rc = iommu_attach_group(hwpt->domain, idev->group);
> +		if (rc)
> +			goto out_iova;
> +
> +		if (list_empty(&hwpt->devices)) {
> +			rc = iopt_table_add_domain(&hwpt->ioas->iopt,
> +						   hwpt->domain);
> +			if (rc)
> +				goto out_detach;
> +		}
> +	}
> +
> +	idev->hwpt = hwpt;
> +	refcount_inc(&hwpt->obj.users);
> +	list_add(&idev->devices_item, &hwpt->devices);
> +	mutex_unlock(&hwpt->devices_lock);
> +	return 0;
> +
> +out_detach:
> +	iommu_detach_group(hwpt->domain, idev->group);
> +out_iova:
> +	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
> +out_unlock:
> +	mutex_unlock(&hwpt->devices_lock);
> +	return rc;
> +}
> +
> +/*
> + * When automatically managing the domains we search for a compatible domain in
> + * the iopt and if one is found use it, otherwise create a new domain.
> + * Automatic domain selection will never pick a manually created domain.
> + */
> +static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
> +					  struct iommufd_ioas *ioas,
> +					  unsigned int flags)
> +{
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	/*
> +	 * There is no differentiation when domains are allocated, so any domain
> +	 * that is willing to attach to the device is interchangeable with any
> +	 * other.
> +	 */
> +	mutex_lock(&ioas->mutex);
> +	list_for_each_entry(hwpt, &ioas->hwpt_list, hwpt_item) {
> +		if (!hwpt->auto_domain)
> +			continue;
> +
> +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> +
> +		/*
> +		 * -EINVAL means the domain is incompatible with the device.
> +		 * Other error codes should propagate to userspace as failure.
> +		 * Success means the domain is attached.
> +		 */
> +		if (rc == -EINVAL)
> +			continue;
> +		goto out_unlock;
> +	}
> +
> +	hwpt = iommufd_hw_pagetable_alloc(idev->ictx, ioas, idev->dev);
> +	if (IS_ERR(hwpt)) {
> +		rc = PTR_ERR(hwpt);
> +		goto out_unlock;
> +	}
> +	hwpt->auto_domain = true;
> +
> +	rc = iommufd_device_do_attach(idev, hwpt, flags);
> +	if (rc)
> +		goto out_abort;
> +	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
> +
> +	mutex_unlock(&ioas->mutex);
> +	iommufd_object_finalize(idev->ictx, &hwpt->obj);
> +	return 0;
> +
> +out_abort:
> +	iommufd_object_abort_and_destroy(idev->ictx, &hwpt->obj);
> +out_unlock:
> +	mutex_unlock(&ioas->mutex);
> +	return rc;
> +}
> +
> +/**
> + * iommufd_device_attach - Connect a device to an iommu_domain
> + * @idev: device to attach
> + * @pt_id: Input a IOMMUFD_OBJ_IOAS, or IOMMUFD_OBJ_HW_PAGETABLE
> + *         Output the IOMMUFD_OBJ_HW_PAGETABLE ID
> + * @flags: Optional flags
> + *
> + * This connects the device to an iommu_domain, either automatically or manually
> + * selected. Once this completes the device could do DMA.
> + *
> + * The caller should return the resulting pt_id back to userspace.
> + * This function is undone by calling iommufd_device_detach().
> + */
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
> +			  unsigned int flags)
> +{
> +	struct iommufd_object *pt_obj;
> +	int rc;
> +
> +	pt_obj = iommufd_get_object(idev->ictx, *pt_id, IOMMUFD_OBJ_ANY);
> +	if (IS_ERR(pt_obj))
> +		return PTR_ERR(pt_obj);
> +
> +	switch (pt_obj->type) {
> +	case IOMMUFD_OBJ_HW_PAGETABLE: {
> +		struct iommufd_hw_pagetable *hwpt =
> +			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> +
> +		rc = iommufd_device_do_attach(idev, hwpt, flags);
> +		if (rc)
> +			goto out_put_pt_obj;
> +
> +		mutex_lock(&hwpt->ioas->mutex);
> +		list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
> +		mutex_unlock(&hwpt->ioas->mutex);
> +		break;
> +	}
> +	case IOMMUFD_OBJ_IOAS: {
> +		struct iommufd_ioas *ioas =
> +			container_of(pt_obj, struct iommufd_ioas, obj);
> +
> +		rc = iommufd_device_auto_get_domain(idev, ioas, flags);
> +		if (rc)
> +			goto out_put_pt_obj;
> +		break;
> +	}
> +	default:
> +		rc = -EINVAL;
> +		goto out_put_pt_obj;
> +	}
> +
> +	refcount_inc(&idev->obj.users);
> +	*pt_id = idev->hwpt->obj.id;
> +	rc = 0;
> +
> +out_put_pt_obj:
> +	iommufd_put_object(pt_obj);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_attach, IOMMUFD);
> +
> +/**
> + * iommufd_device_detach - Disconnect a device to an iommu_domain
from
> + * @idev: device to detach
> + *
> + * Undo iommufd_device_attach(). This disconnects the idev from the previously
> + * attached pt_id. The device returns back to a blocked DMA translation.
> + */
> +void iommufd_device_detach(struct iommufd_device *idev)
> +{
> +	struct iommufd_hw_pagetable *hwpt = idev->hwpt;
> +
> +	mutex_lock(&hwpt->ioas->mutex);
> +	mutex_lock(&hwpt->devices_lock);
> +	list_del(&idev->devices_item);
> +	if (!iommufd_hw_pagetable_has_group(hwpt, idev->group)) {
> +		if (list_empty(&hwpt->devices)) {
> +			iopt_table_remove_domain(&hwpt->ioas->iopt,
> +						 hwpt->domain);
> +			list_del(&hwpt->hwpt_item);
> +		}
> +		iommu_detach_group(hwpt->domain, idev->group);
> +	}
> +	iopt_remove_reserved_iova(&hwpt->ioas->iopt, idev->dev);
> +	mutex_unlock(&hwpt->devices_lock);
> +	mutex_unlock(&hwpt->ioas->mutex);
> +
> +	if (hwpt->auto_domain)
> +		iommufd_object_destroy_user(idev->ictx, &hwpt->obj);
> +	else
> +		refcount_dec(&hwpt->obj.users);
> +
> +	idev->hwpt = NULL;
> +
> +	refcount_dec(&idev->obj.users);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index bb5cbd8f4e5991..73345886d969e5 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -103,6 +103,7 @@ static inline int iommufd_ucmd_respond(struct iommufd_ucmd *ucmd,
>  enum iommufd_object_type {
>  	IOMMUFD_OBJ_NONE,
>  	IOMMUFD_OBJ_ANY = IOMMUFD_OBJ_NONE,
> +	IOMMUFD_OBJ_DEVICE,
>  	IOMMUFD_OBJ_HW_PAGETABLE,
>  	IOMMUFD_OBJ_IOAS,
>  };
> @@ -229,6 +230,8 @@ struct iommufd_hw_pagetable {
>  	struct iommufd_ioas *ioas;
>  	struct iommu_domain *domain;
>  	bool auto_domain : 1;
> +	bool enforce_cache_coherency : 1;
> +	bool msi_cookie : 1;
>  	/* Head at iommufd_ioas::hwpt_list */
>  	struct list_head hwpt_item;
>  	struct mutex devices_lock;
> @@ -240,6 +243,8 @@ iommufd_hw_pagetable_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  			   struct device *dev);
>  void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
>  
> +void iommufd_device_destroy(struct iommufd_object *obj);
> +
>  struct iommufd_access {
>  	unsigned long iova_alignment;
>  	u32 iopt_access_list_id;
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 3eab714b8e12a3..8a114ddbdfcde2 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
>  EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
>  
>  static const struct iommufd_object_ops iommufd_object_ops[] = {
> +	[IOMMUFD_OBJ_DEVICE] = {
> +		.destroy = iommufd_device_destroy,
> +	},
>  	[IOMMUFD_OBJ_IOAS] = {
>  		.destroy = iommufd_ioas_destroy,
>  	},
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 26e09d539737bb..31efacd8a46cce 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -9,10 +9,23 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> +#include <linux/device.h>
>  
> +struct iommufd_device;
>  struct iommufd_ctx;
>  struct file;
>  
> +struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> +					   struct device *dev, u32 *id);
> +void iommufd_device_unbind(struct iommufd_device *idev);
> +
> +enum {
> +	IOMMUFD_ATTACH_FLAGS_ALLOW_UNSAFE_INTERRUPT = 1 << 0,
> +};
> +int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
> +			  unsigned int flags);
> +void iommufd_device_detach(struct iommufd_device *idev);
> +
>  enum {
>  	IOMMUFD_ACCESS_RW_READ = 0,
>  	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
Thanks

Eric

