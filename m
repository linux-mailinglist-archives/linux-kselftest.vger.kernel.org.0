Return-Path: <linux-kselftest+bounces-1592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D970D80D4EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 19:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FA16281793
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 18:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D984F210;
	Mon, 11 Dec 2023 18:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSU5SpAb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FED0
	for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 10:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702317857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MaxmWb0gmmOa2NNadHjgN+9H3pLxhDx5JIlGNJciyGA=;
	b=QSU5SpAb/ohdiMiUKqYB5L0TpTBSDbCdHb1WKQ1A/ptQBxHXoSqjOgrKT6dErEUos9rOE5
	1kb4p9QZIXLhdB8P6KZBkMHIULVOCEVs9ozBlm80yoUCaTm4mWDMaqyTZ6qicxIMb8pPeH
	KntTSs8Rz72lrqZTMUcbul/+LIXY9OE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-oC0Az6iSMb6KlqrVvSdgHQ-1; Mon, 11 Dec 2023 13:03:57 -0500
X-MC-Unique: oC0Az6iSMb6KlqrVvSdgHQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6d9d5072a0eso7360790a34.1
        for <linux-kselftest@vger.kernel.org>; Mon, 11 Dec 2023 10:03:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317829; x=1702922629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MaxmWb0gmmOa2NNadHjgN+9H3pLxhDx5JIlGNJciyGA=;
        b=Xxb8TgNVrsbqQKH58axs0tbI++JoWaqDlpX+OmQbGhSV4uqH23mksdiTqPvuCgtnVZ
         e5JWdlzGDQjV4ahLj3+6D3eK6AuIYskWwQeGmj00lBPnTL7SuAQnWmf/9/y+AxpHgmb1
         SgyFLp2avksNYZ1Mn+08YV8Rj14I1OBJYrTNKJQmvCjdA/0eppMOfGFU7dL1eooq5I64
         lWpk3uz/1ZK05kKSgJBF+GW7O5U6l/V5wdxWO79Xj8VfqtMjn8FUEyYO5i2egQcqNwJH
         tajPt5gUapxacsy9RJxZA7nDRrSOJPCOdhJ6dp8xhgv6KsZkM0tZpJFDRTWrTAloAxdG
         PNWA==
X-Gm-Message-State: AOJu0YyjjaFy3ijZhbP4uC9ZTqCQlK7jw5sg/9szCA8EC+6wDdMwfkBa
	S2/4LdP6Jf0K6AZowrMrYSUZC5XI2LDMa8S9UGBl1WwOY3p6x7wxj1EwoPIFLHQ8kraY2tAo2MZ
	XceEGmEuNHek71YF4G6/CwXqBcj1g
X-Received: by 2002:a9d:4e8f:0:b0:6d8:8053:af56 with SMTP id v15-20020a9d4e8f000000b006d88053af56mr5256034otk.39.1702317829727;
        Mon, 11 Dec 2023 10:03:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSgJpcgGM/uc3eXwfGlIeFBE+F5c01rkGI5ZWrgUL/mGmyGdintBKaoq0B478Ka1tOjndr+w==
X-Received: by 2002:a9d:4e8f:0:b0:6d8:8053:af56 with SMTP id v15-20020a9d4e8f000000b006d88053af56mr5256002otk.39.1702317829439;
        Mon, 11 Dec 2023 10:03:49 -0800 (PST)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d6859000000b006d9a7a7048asm1827521oto.49.2023.12.11.10.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:03:48 -0800 (PST)
Date: Mon, 11 Dec 2023 11:03:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
 robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
 eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
 mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
 yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
 shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
 suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 zhenzhong.duan@intel.com, joao.m.martins@oracle.com, xin.zeng@intel.com,
 yan.y.zhao@intel.com
Subject: Re: [PATCH 3/3] vfio: Report PASID capability via
 VFIO_DEVICE_FEATURE ioctl
Message-ID: <20231211110345.1b4526c6.alex.williamson@redhat.com>
In-Reply-To: <20231127063909.129153-4-yi.l.liu@intel.com>
References: <20231127063909.129153-1-yi.l.liu@intel.com>
	<20231127063909.129153-4-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Nov 2023 22:39:09 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> This reports the PASID capability data to userspace via VFIO_DEVICE_FEATURE,
> hence userspace could probe PASID capability by it. This is a bit different
> with other capabilities which are reported to userspace when the user reads
> the device's PCI configuration space. There are two reasons for this.
> 
>  - First, Qemu by default exposes all available PCI capabilities in vfio-pci
>    config space to the guest as read-only, so adding PASID capability in the
>    vfio-pci config space will make it exposed to the guest automatically while
>    an old Qemu doesn't really support it.

Shouldn't we also be working on hiding the PASID capability in QEMU
ASAP?  This feature only allows QEMU to know PASID control is actually
available, not the guest.  Maybe we're hoping this is really only used
by VFs where there's no capability currently exposed to the guest?

>  - Second, PASID capability does not exit on VFs (instead shares the cap of

s/exit/exist/

>    the PF). Creating a virtual PASID capability in vfio-pci config space needs
>    to find a hole to place it, but doing so may require device specific
>    knowledge to avoid potential conflict with device specific registers like
>    hiden bits in VF config space. It's simpler by moving this burden to the
>    VMM instead of maintaining a quirk system in the kernel.

This feels a bit like an incomplete solution though and we might
already posses device specific knowledge in the form of a variant
driver.  Should this feature structure include a flag + field that
could serve to generically indicate to the VMM a location for
implementing the PASID capability?  The default core implementation
might fill this only for PFs where clearly an emualted PASID capability
can overlap the physical capability.  Thanks,

Alex

> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci_core.c | 47 ++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h        | 13 +++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> index 1929103ee59a..8038aa45500e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1495,6 +1495,51 @@ static int vfio_pci_core_feature_token(struct vfio_device *device, u32 flags,
>  	return 0;
>  }
>  
> +static int vfio_pci_core_feature_pasid(struct vfio_device *device, u32 flags,
> +				       struct vfio_device_feature_pasid __user *arg,
> +				       size_t argsz)
> +{
> +	struct vfio_pci_core_device *vdev =
> +		container_of(device, struct vfio_pci_core_device, vdev);
> +	struct vfio_device_feature_pasid pasid = { 0 };
> +	struct pci_dev *pdev = vdev->pdev;
> +	u32 capabilities = 0;
> +	int ret;
> +
> +	/* We do not support SET of the PASID capability */
> +	ret = vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(pasid));
> +	if (ret != 1)
> +		return ret;
> +
> +	/*
> +	 * Needs go to PF if the device is VF as VF shares its PF's
> +	 * PASID Capability.
> +	 */
> +	if (pdev->is_virtfn)
> +		pdev = pci_physfn(pdev);
> +
> +	if (!pdev->pasid_enabled)
> +		goto out;
> +
> +#ifdef CONFIG_PCI_PASID
> +	pci_read_config_dword(pdev, pdev->pasid_cap + PCI_PASID_CAP,
> +			      &capabilities);
> +#endif
> +
> +	if (capabilities & PCI_PASID_CAP_EXEC)
> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_EXEC;
> +	if (capabilities & PCI_PASID_CAP_PRIV)
> +		pasid.capabilities |= VFIO_DEVICE_PASID_CAP_PRIV;
> +
> +	pasid.width = (capabilities >> 8) & 0x1f;
> +
> +out:
> +	if (copy_to_user(arg, &pasid, sizeof(pasid)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  				void __user *arg, size_t argsz)
>  {
> @@ -1508,6 +1553,8 @@ int vfio_pci_core_ioctl_feature(struct vfio_device *device, u32 flags,
>  		return vfio_pci_core_pm_exit(device, flags, arg, argsz);
>  	case VFIO_DEVICE_FEATURE_PCI_VF_TOKEN:
>  		return vfio_pci_core_feature_token(device, flags, arg, argsz);
> +	case VFIO_DEVICE_FEATURE_PASID:
> +		return vfio_pci_core_feature_pasid(device, flags, arg, argsz);
>  	default:
>  		return -ENOTTY;
>  	}
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 495193629029..8326faf8622b 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -1512,6 +1512,19 @@ struct vfio_device_feature_bus_master {
>  };
>  #define VFIO_DEVICE_FEATURE_BUS_MASTER 10
>  
> +/**
> + * Upon VFIO_DEVICE_FEATURE_GET, return the PASID capability for the device.
> + * Zero width means no support for PASID.
> + */
> +struct vfio_device_feature_pasid {
> +	__u16 capabilities;
> +#define VFIO_DEVICE_PASID_CAP_EXEC	(1 << 0)
> +#define VFIO_DEVICE_PASID_CAP_PRIV	(1 << 1)
> +	__u8 width;
> +	__u8 __reserved;
> +};
> +#define VFIO_DEVICE_FEATURE_PASID 11
> +
>  /* -------- API for Type1 VFIO IOMMU -------- */
>  
>  /**


