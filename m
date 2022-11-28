Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87FD63ACF5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 16:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiK1PuN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 10:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbiK1PuL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 10:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0E3634E
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 07:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669650545;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u5ZfUzZZc2FyojyjTgLqS30nPeorAL7IAXyWwmpu3eM=;
        b=EO7mcPF0B6sfJ2rynEdWWshtluRXsoXUWGQ7O/bH6bsPNFWynF0aaOXIfdR9z35FmMRXMl
        Js1V+Yde0g+d236aJc7bELnaqYrnupqz5QYZQOrqVY/fbyl6ThbvBE2phXVhPWBkaSzQzC
        7G4c5TxSCb53pN9GNH1jToHl8tPxh6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-568-PBJOFMOZPi2XYfX1ov3Ggw-1; Mon, 28 Nov 2022 10:49:04 -0500
X-MC-Unique: PBJOFMOZPi2XYfX1ov3Ggw-1
Received: by mail-wr1-f72.google.com with SMTP id r23-20020adfa157000000b00241bcae980cso2079384wrr.7
        for <linux-kselftest@vger.kernel.org>; Mon, 28 Nov 2022 07:49:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5ZfUzZZc2FyojyjTgLqS30nPeorAL7IAXyWwmpu3eM=;
        b=DGctTeXBEvK6U0zWk1FyCGIoI4wwyU+wv5b9YfPD0P4kTEdxzA0EB52qW/nyFD7Mcs
         Pez8OAk9dfL08gRYSRHBvUCs3yfZrMRpy6avvYhK09u7h3KApZLXzMkEgInkO12kmVkh
         CqmAFmaAH9KbAB1ynOB+ngsPwdPFGHai/1tr5h00YQyJStt2K1S/S8g2GZBl3Ko25TMa
         R/4ufvN6hlUwfz1TZGFnSiGviTpWHnSokFQzHvVtvTwVlbbS0fom6UAS5IggAvH2Jl3D
         Z94g20ojc2emnwH4VPb3YgARxGasM5jQtU57+kctn8wQOOHgBID6bwbDuwtOx9ItswyK
         8/Og==
X-Gm-Message-State: ANoB5plUNgYI0+a6hxbAjMB1J8uJwHhMOAyrswWVE5QJiTFkWD348Fia
        Y/o+BwA6pZnFGkkdBKagy4KoA0qt7AYvszumuQUIDTyzoHjwdOj2nU/KsxUo09oj3iC+Xaqu0Ac
        voMhbCrxVkA9uwE11ljoGMYsRfGCW
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr31930188wru.475.1669650543131;
        Mon, 28 Nov 2022 07:49:03 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6OfcZs6sT9fX61XTqe3FiVtwJd0KXxNgBBmSYQp6FBWUHsIHrqBOLBwttYYDAFpHwjTJ8yXg==
X-Received: by 2002:a5d:6503:0:b0:22e:35e8:382d with SMTP id x3-20020a5d6503000000b0022e35e8382dmr31930142wru.475.1669650542735;
        Mon, 28 Nov 2022 07:49:02 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002421db5f279sm1049471wrm.78.2022.11.28.07.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 07:49:02 -0800 (PST)
Message-ID: <44ea1bad-500c-b4a5-c2a5-e7bc79de2394@redhat.com>
Date:   Mon, 28 Nov 2022 16:48:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v5 14/19] iommufd: Add kAPI toward external drivers for
 kernel access
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
References: <14-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
From:   Eric Auger <eric.auger@redhat.com>
In-Reply-To: <14-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
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
> Kernel access is the mode that VFIO "mdevs" use. In this case there is no
> struct device and no IOMMU connection. iommufd acts as a record keeper for
> accesses and returns the actual struct pages back to the caller to use
> however they need. eg with kmap or the DMA API.
>
> Each caller must create a struct iommufd_access with
> iommufd_access_create(), similar to how iommufd_device_bind() works. Using
> this struct the caller can access blocks of IOVA using
> iommufd_access_pin_pages() or iommufd_access_rw().
>
> Callers must provide a callback that immediately unpins any IOVA being
> used within a range. This happens if userspace unmaps the IOVA under the
> pin.
>
> The implementation forwards the access requests directly to the iopt
> infrastructure that manages the iopt_pages_access.
>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Tested-by: Yi Liu <yi.l.liu@intel.com>
> Tested-by: Lixiao Yang <lixiao.yang@intel.com>
> Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c          | 314 ++++++++++++++++++++++++
>  drivers/iommu/iommufd/io_pagetable.c    |   8 +-
>  drivers/iommu/iommufd/iommufd_private.h |  10 +
>  drivers/iommu/iommufd/main.c            |   3 +
>  include/linux/iommufd.h                 |  43 +++-
>  5 files changed, 375 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index a71f5740773f84..522469ae7b5770 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -6,6 +6,7 @@
>  #include <linux/iommu.h>
>  #include <linux/irqdomain.h>
>  
> +#include "io_pagetable.h"
>  #include "iommufd_private.h"
>  
>  /*
> @@ -415,3 +416,316 @@ void iommufd_device_detach(struct iommufd_device *idev)
>  	refcount_dec(&idev->obj.users);
>  }
>  EXPORT_SYMBOL_NS_GPL(iommufd_device_detach, IOMMUFD);
> +
> +void iommufd_access_destroy_object(struct iommufd_object *obj)
> +{
> +	struct iommufd_access *access =
> +		container_of(obj, struct iommufd_access, obj);
> +
> +	iopt_remove_access(&access->ioas->iopt, access);
> +	iommufd_ctx_put(access->ictx);
> +	refcount_dec(&access->ioas->obj.users);
> +}
> +
> +/**
> + * iommufd_access_create - Create an iommufd_access
> + * @ictx: iommufd file descriptor
> + * @ioas_id: ID for a IOMMUFD_OBJ_IOAS
> + * @ops: Driver's ops to associate with the access
> + * @data: Opaque data to pass into ops functions
> + *
> + * An iommufd_access allows a driver to read/write to the IOAS without using
> + * DMA. The underlying CPU memory can be accessed using the
> + * iommufd_access_pin_pages() or iommufd_access_rw() functions.
> + *
> + * The provided ops are required to use iommufd_access_pin_pages().
> + */
> +struct iommufd_access *
> +iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
> +		      const struct iommufd_access_ops *ops, void *data)
> +{
> +	struct iommufd_access *access;
> +	struct iommufd_object *obj;
> +	int rc;
> +
> +	/*
> +	 * There is no uAPI for the access object, but to keep things symmetric
> +	 * use the object infrastructure anyhow.
> +	 */
> +	access = iommufd_object_alloc(ictx, access, IOMMUFD_OBJ_ACCESS);
> +	if (IS_ERR(access))
> +		return access;
> +
> +	access->data = data;
> +	access->ops = ops;
> +
> +	obj = iommufd_get_object(ictx, ioas_id, IOMMUFD_OBJ_IOAS);
> +	if (IS_ERR(obj)) {
> +		rc = PTR_ERR(obj);
> +		goto out_abort;
> +	}
> +	access->ioas = container_of(obj, struct iommufd_ioas, obj);
> +	iommufd_ref_to_users(obj);
> +
> +	if (ops->needs_pin_pages)
> +		access->iova_alignment = PAGE_SIZE;
> +	else
> +		access->iova_alignment = 1;
> +	rc = iopt_add_access(&access->ioas->iopt, access);
> +	if (rc)
> +		goto out_put_ioas;
> +
> +	/* The calling driver is a user until iommufd_access_destroy() */
> +	refcount_inc(&access->obj.users);
> +	access->ictx = ictx;
> +	iommufd_ctx_get(ictx);
> +	iommufd_object_finalize(ictx, &access->obj);
> +	return access;
> +out_put_ioas:
> +	refcount_dec(&access->ioas->obj.users);
> +out_abort:
> +	iommufd_object_abort(ictx, &access->obj);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_create, IOMMUFD);
> +
> +/**
> + * iommufd_access_destroy - Destroy an iommufd_access
> + * @access: The access to destroy
> + *
> + * The caller must stop using the access before destroying it.
> + */
> +void iommufd_access_destroy(struct iommufd_access *access)
> +{
> +	bool was_destroyed;
> +
> +	was_destroyed = iommufd_object_destroy_user(access->ictx, &access->obj);
> +	WARN_ON(!was_destroyed);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_destroy, IOMMUFD);
> +
> +/**
> + * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
> + * @iopt: iopt to work on
> + * @iova: Starting iova in the iopt
> + * @length: Number of bytes
> + *
> + * After this function returns there should be no users attached to the pages
> + * linked to this iopt that intersect with iova,length. Anyone that has attached
> + * a user through iopt_access_pages() needs to detatch it through
detach
> + * iommufd_access_unpin_pages() before this function returns.
> + *
> + * The unmap callback may not call or wait for a iommufd_access_destroy() to
> + * complete. Once iommufd_access_destroy() returns no ops are running and no
> + * future ops will be called.
I don't understand the above sentence. Is that related to the

+		if (!iommufd_lock_obj(&access->obj))
+			continue;

where is the unmap() called in that case?

> + */
> +void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
> +				 unsigned long length)
> +{
> +	struct iommufd_ioas *ioas =
> +		container_of(iopt, struct iommufd_ioas, iopt);
> +	struct iommufd_access *access;
> +	unsigned long index;
> +
> +	xa_lock(&ioas->iopt.access_list);
> +	xa_for_each(&ioas->iopt.access_list, index, access) {
> +		if (!iommufd_lock_obj(&access->obj))
> +			continue;
> +		xa_unlock(&ioas->iopt.access_list);
> +
> +		access->ops->unmap(access->data, iova, length);
> +
> +		iommufd_put_object(&access->obj);
> +		xa_lock(&ioas->iopt.access_list);
> +	}
> +	xa_unlock(&ioas->iopt.access_list);
> +}
> +
> +/**
> + * iommufd_access_unpin_pages() - Undo iommufd_access_pin_pages
> + * @access: IOAS access to act on
> + * @iova: Starting IOVA
> + * @length:- Number of bytes to access
s/-//
> + *
> + * Return the struct page's. The caller must stop accessing them before calling
> + * this. The iova/length must exactly match the one provided to access_pages.
> + */
> +void iommufd_access_unpin_pages(struct iommufd_access *access,
> +				unsigned long iova, unsigned long length)
> +{
> +	struct io_pagetable *iopt = &access->ioas->iopt;
> +	struct iopt_area_contig_iter iter;
> +	unsigned long last_iova;
> +	struct iopt_area *area;
> +
> +	if (WARN_ON(!length) ||
> +	    WARN_ON(check_add_overflow(iova, length - 1, &last_iova)))
> +		return;
> +
> +	down_read(&iopt->iova_rwsem);
> +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
> +		iopt_area_remove_access(
> +			area, iopt_area_iova_to_index(area, iter.cur_iova),
> +			iopt_area_iova_to_index(
> +				area,
> +				min(last_iova, iopt_area_last_iova(area))));
> +	up_read(&iopt->iova_rwsem);
> +	WARN_ON(!iopt_area_contig_done(&iter));
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_unpin_pages, IOMMUFD);
> +
> +static bool iopt_area_contig_is_aligned(struct iopt_area_contig_iter *iter)
> +{
> +	if (iopt_area_start_byte(iter->area, iter->cur_iova) % PAGE_SIZE)
> +		return false;
> +
> +	if (!iopt_area_contig_done(iter) &&
> +	    (iopt_area_start_byte(iter->area, iopt_area_last_iova(iter->area)) %
> +	     PAGE_SIZE) != (PAGE_SIZE - 1))
> +		return false;
> +	return true;
> +}
> +
> +static bool check_area_prot(struct iopt_area *area, unsigned int flags)
> +{
> +	if (flags & IOMMUFD_ACCESS_RW_WRITE)
> +		return area->iommu_prot & IOMMU_WRITE;
> +	return area->iommu_prot & IOMMU_READ;
> +}
> +
> +/**
> + * iommufd_access_pin_pages() - Return a list of pages under the iova
> + * @access: IOAS access to act on
> + * @iova: Starting IOVA
> + * @length: Number of bytes to access
> + * @out_pages: Output page list
> + * @flags: IOPMMUFD_ACCESS_RW_* flags
> + *
> + * Reads @length bytes starting at iova and returns the struct page * pointers.
> + * These can be kmap'd by the caller for CPU access.
> + *
> + * The caller must perform iopt_unaccess_pages() when done to balance this.
this function does not exist
> + *
> + * This API always requires a page aligned iova. This happens naturally if the
> + * ioas alignment is >= PAGE_SIZE and the iova is PAGE_SIZE aligned. However
> + * smaller alignments have corner cases where this API can fail on otherwise
> + * aligned iova.
> + */
> +int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
> +			     unsigned long length, struct page **out_pages,
> +			     unsigned int flags)
> +{
> +	struct io_pagetable *iopt = &access->ioas->iopt;
> +	struct iopt_area_contig_iter iter;
> +	unsigned long last_iova;
> +	struct iopt_area *area;
> +	int rc;
> +
> +	if (!length)
> +		return -EINVAL;
> +	if (check_add_overflow(iova, length - 1, &last_iova))
> +		return -EOVERFLOW;
> +
> +	down_read(&iopt->iova_rwsem);
> +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
> +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> +		unsigned long last_index = iopt_area_iova_to_index(area, last);
> +		unsigned long index =
> +			iopt_area_iova_to_index(area, iter.cur_iova);
> +
> +		if (area->prevent_access ||
> +		    !iopt_area_contig_is_aligned(&iter)) {
> +			rc = -EINVAL;
> +			goto err_remove;
> +		}
> +
> +		if (!check_area_prot(area, flags)) {
> +			rc = -EPERM;
> +			goto err_remove;
> +		}
> +
> +		rc = iopt_area_add_access(area, index, last_index, out_pages,
> +					  flags);
> +		if (rc)
> +			goto err_remove;
> +		out_pages += last_index - index + 1;
> +	}
> +	if (!iopt_area_contig_done(&iter)) {
> +		rc = -ENOENT;
> +		goto err_remove;
> +	}
> +
> +	up_read(&iopt->iova_rwsem);
> +	return 0;
> +
> +err_remove:
> +	if (iova < iter.cur_iova) {
> +		last_iova = iter.cur_iova - 1;
> +		iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova)
> +			iopt_area_remove_access(
> +				area,
> +				iopt_area_iova_to_index(area, iter.cur_iova),
> +				iopt_area_iova_to_index(
> +					area, min(last_iova,
> +						  iopt_area_last_iova(area))));
> +	}
> +	up_read(&iopt->iova_rwsem);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_pin_pages, IOMMUFD);
> +
> +/**
> + * iommufd_access_rw - Read or write data under the iova
> + * @access: IOAS access to act on
> + * @iova: Starting IOVA
> + * @data: Kernel buffer to copy to/from
> + * @length: Number of bytes to access
> + * @flags: IOMMUFD_ACCESS_RW_* flags
> + *
> + * Copy kernel to/from data into the range given by IOVA/length. If flags
> + * indicates IOMMUFD_ACCESS_RW_KTHREAD then a large copy can be optimized
> + * by changing it into copy_to/from_user().
> + */
> +int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
> +		      void *data, size_t length, unsigned int flags)
> +{
> +	struct io_pagetable *iopt = &access->ioas->iopt;
> +	struct iopt_area_contig_iter iter;
> +	struct iopt_area *area;
> +	unsigned long last_iova;
> +	int rc;
> +
> +	if (!length)
> +		return -EINVAL;
> +	if (check_add_overflow(iova, length - 1, &last_iova))
> +		return -EOVERFLOW;
> +
> +	down_read(&iopt->iova_rwsem);
> +	iopt_for_each_contig_area(&iter, area, iopt, iova, last_iova) {
> +		unsigned long last = min(last_iova, iopt_area_last_iova(area));
> +		unsigned long bytes = (last - iter.cur_iova) + 1;
> +
> +		if (area->prevent_access) {
> +			rc = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		if (!check_area_prot(area, flags)) {
> +			rc = -EPERM;
> +			goto err_out;
> +		}
> +
> +		rc = iopt_pages_rw_access(
> +			area->pages, iopt_area_start_byte(area, iter.cur_iova),
> +			data, bytes, flags);
> +		if (rc)
> +			goto err_out;
> +		data += bytes;
> +	}
> +	if (!iopt_area_contig_done(&iter))
> +		rc = -ENOENT;
> +err_out:
> +	up_read(&iopt->iova_rwsem);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_access_rw, IOMMUFD);
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 756d347948f0ec..4f4a9d9aac570e 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -458,6 +458,7 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  	 * is NULL. This prevents domain attach/detatch from running
>  	 * concurrently with cleaning up the area.
>  	 */
> +again:
>  	down_read(&iopt->domains_rwsem);
>  	down_write(&iopt->iova_rwsem);
>  	while ((area = iopt_area_iter_first(iopt, start, last))) {
> @@ -486,8 +487,11 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
>  			area->prevent_access = true;
>  			up_write(&iopt->iova_rwsem);
>  			up_read(&iopt->domains_rwsem);
> -			/* Later patch calls back to drivers to unmap */
> -			return -EBUSY;
> +			iommufd_access_notify_unmap(iopt, area_first,
> +						    iopt_area_length(area));
> +			if (WARN_ON(READ_ONCE(area->num_accesses)))
> +				return -EDEADLOCK;
> +			goto again;
>  		}
>  
>  		pages = area->pages;
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 73345886d969e5..e1653b2276dac9 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -65,6 +65,8 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>  		    unsigned long length, unsigned long *unmapped);
>  int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
>  
> +void iommufd_access_notify_unmap(struct io_pagetable *iopt, unsigned long iova,
> +				 unsigned long length);
>  int iopt_table_add_domain(struct io_pagetable *iopt,
>  			  struct iommu_domain *domain);
>  void iopt_table_remove_domain(struct io_pagetable *iopt,
> @@ -106,6 +108,7 @@ enum iommufd_object_type {
>  	IOMMUFD_OBJ_DEVICE,
>  	IOMMUFD_OBJ_HW_PAGETABLE,
>  	IOMMUFD_OBJ_IOAS,
> +	IOMMUFD_OBJ_ACCESS,
>  };
>  
>  /* Base struct for all objects with a userspace ID handle. */
> @@ -246,6 +249,11 @@ void iommufd_hw_pagetable_destroy(struct iommufd_object *obj);
>  void iommufd_device_destroy(struct iommufd_object *obj);
>  
>  struct iommufd_access {
> +	struct iommufd_object obj;
> +	struct iommufd_ctx *ictx;
> +	struct iommufd_ioas *ioas;
> +	const struct iommufd_access_ops *ops;
> +	void *data;
>  	unsigned long iova_alignment;
>  	u32 iopt_access_list_id;
>  };
> @@ -253,4 +261,6 @@ struct iommufd_access {
>  int iopt_add_access(struct io_pagetable *iopt, struct iommufd_access *access);
>  void iopt_remove_access(struct io_pagetable *iopt,
>  			struct iommufd_access *access);
> +void iommufd_access_destroy_object(struct iommufd_object *obj);
> +
>  #endif
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8a114ddbdfcde2..c8cc0953dea13a 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -352,6 +352,9 @@ void iommufd_ctx_put(struct iommufd_ctx *ictx)
>  EXPORT_SYMBOL_NS_GPL(iommufd_ctx_put, IOMMUFD);
>  
>  static const struct iommufd_object_ops iommufd_object_ops[] = {
> +	[IOMMUFD_OBJ_ACCESS] = {
> +		.destroy = iommufd_access_destroy_object,
> +	},
>  	[IOMMUFD_OBJ_DEVICE] = {
>  		.destroy = iommufd_device_destroy,
>  	},
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 31efacd8a46cce..fb9a4c275cca86 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -9,10 +9,12 @@
>  #include <linux/types.h>
>  #include <linux/errno.h>
>  #include <linux/err.h>
> -#include <linux/device.h>
>  
> +struct device;
>  struct iommufd_device;
> +struct page;
>  struct iommufd_ctx;
> +struct iommufd_access;
>  struct file;
>  
>  struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
> @@ -26,6 +28,11 @@ int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id,
>  			  unsigned int flags);
>  void iommufd_device_detach(struct iommufd_device *idev);
>  
> +struct iommufd_access_ops {
> +	u8 needs_pin_pages : 1;
> +	void (*unmap)(void *data, unsigned long iova, unsigned long length);
> +};
> +
>  enum {
>  	IOMMUFD_ACCESS_RW_READ = 0,
>  	IOMMUFD_ACCESS_RW_WRITE = 1 << 0,
> @@ -33,11 +40,24 @@ enum {
>  	IOMMUFD_ACCESS_RW_KTHREAD = 1 << 1,
>  };
>  
> +struct iommufd_access *
> +iommufd_access_create(struct iommufd_ctx *ictx, u32 ioas_id,
> +		      const struct iommufd_access_ops *ops, void *data);
> +void iommufd_access_destroy(struct iommufd_access *access);
> +
>  void iommufd_ctx_get(struct iommufd_ctx *ictx);
>  
>  #if IS_ENABLED(CONFIG_IOMMUFD)
>  struct iommufd_ctx *iommufd_ctx_from_file(struct file *file);
>  void iommufd_ctx_put(struct iommufd_ctx *ictx);
> +
> +int iommufd_access_pin_pages(struct iommufd_access *access, unsigned long iova,
> +			     unsigned long length, struct page **out_pages,
> +			     unsigned int flags);
> +void iommufd_access_unpin_pages(struct iommufd_access *access,
> +				unsigned long iova, unsigned long length);
> +int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
> +		      void *data, size_t len, unsigned int flags);
>  #else /* !CONFIG_IOMMUFD */
>  static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
>  {
> @@ -47,5 +67,26 @@ static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
>  static inline void iommufd_ctx_put(struct iommufd_ctx *ictx)
>  {
>  }
> +
> +static inline int iommufd_access_pin_pages(struct iommufd_access *access,
> +					   unsigned long iova,
> +					   unsigned long length,
> +					   struct page **out_pages,
> +					   unsigned int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommufd_access_unpin_pages(struct iommufd_access *access,
> +					      unsigned long iova,
> +					      unsigned long length)
> +{
> +}
> +
> +static inline int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
> +		      void *data, size_t len, unsigned int flags)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif /* CONFIG_IOMMUFD */
>  #endif
Eric

