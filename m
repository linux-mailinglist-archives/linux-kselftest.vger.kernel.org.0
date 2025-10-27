Return-Path: <linux-kselftest+bounces-44142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CB7C116DF
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 21:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8075A565C1E
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 20:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A856A31B812;
	Mon, 27 Oct 2025 20:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SkM+8bQ6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201112D739D;
	Mon, 27 Oct 2025 20:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597874; cv=none; b=EOWrnBoB7GkZN8bzKvxjlJf7cud0TpLrU0q0mauc5Fo7JGA2w7zSxvWbYlPnwiR5t9t6g9SCYlSjyiQfjQveCGwpA9FMWk8p/G//zaVjwYsEIWS3hpTI80RySgX+37Lb+SqyrK8xbRRlHhFgCze9RWUIGhmcQEbeyXt+uzK7IP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597874; c=relaxed/simple;
	bh=qlgYcDP3wPNQcYNQoPgAxQlQpIKroMyhIMV31tcTFB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qk9Oynw2wudLMot2lvcIWQcdxgPFOAImo30JgurfT7cJs8V7C59wsm9IEz/am5+Pq24yIso1EkyDdb37Vpg27TWM4nzFZIsBSsxcYggWpfYYqPi9BZMDo9eS24gF08WM8UO5c5OFshw3BuVW6FJ6tQjfd0hxOA0c2yRV8DqW0Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SkM+8bQ6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6625E200FE48;
	Mon, 27 Oct 2025 13:44:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6625E200FE48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1761597872;
	bh=O55qdQEOty0YMJyCMjA7a55Zsy7WOextVLJ/m8n7aNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SkM+8bQ6HvDK3JCyAa3H5XwZhgsBqyi2+LZ6YFbx7CCgLp7y7ik+goeWx+YNH0OE0
	 Y84Iuea7wlo7sdzrMRzH/9NOZopwGxxQ6Sfdcx3HS9sGE5kHt4+oAu70GqW/PyaftN
	 z/yZVMGkRGY/+t7ME6Jzffzb4DhwJ1iCVs5H8U80=
Date: Mon, 27 Oct 2025 13:44:30 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com,
 pasha.tatashin@soleen.com, dmatlack@google.com, jgg@ziepe.ca,
 graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
 chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com,
 saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com,
 david@redhat.com, jgowans@amazon.com, dwmw2@infradead.org,
 epetron@amazon.de, junaids@google.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Jacob Pan <jacob.pan@linux.microsoft.com>
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <20251027134430.00007e46@linux.microsoft.com>
In-Reply-To: <20251018000713.677779-7-vipinsh@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
	<20251018000713.677779-7-vipinsh@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Oct 2025 17:06:58 -0700
Vipin Sharma <vipinsh@google.com> wrote:

> Return true in can_preserve() callback of live update file handler, if
> VFIO can preserve the passed VFIO cdev file. Return -EOPNOTSUPP from
> prepare() callback for now to fail any attempt to preserve VFIO cdev
> in live update.
>=20
> The VFIO cdev opened check ensures that the file is actually used for
> VFIO cdev and not for VFIO device FD which can be obtained from the
> VFIO group.
>=20
> Returning true from can_preserve() tells Live Update Orchestrator that
> VFIO can try to preserve the given file during live update. Actual
> preservation logic will be added in future patches, therefore, for
> now, prepare call will fail.
>=20
> Signed-off-by: Vipin Sharma <vipinsh@google.com>
> ---
>  drivers/vfio/pci/vfio_pci_liveupdate.c | 16 +++++++++++++++-
>  drivers/vfio/vfio_main.c               |  3 ++-
>  include/linux/vfio.h                   |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci_liveupdate.c
> b/drivers/vfio/pci/vfio_pci_liveupdate.c index
> 088f7698a72c..2ce2c11cb51c 100644 ---
> a/drivers/vfio/pci/vfio_pci_liveupdate.c +++
> b/drivers/vfio/pci/vfio_pci_liveupdate.c @@ -8,10 +8,17 @@
>   */
> =20
>  #include <linux/liveupdate.h>
> +#include <linux/vfio.h>
>  #include <linux/errno.h>
> =20
>  #include "vfio_pci_priv.h"
> =20
> +static int vfio_pci_liveupdate_prepare(struct
> liveupdate_file_handler *handler,
> +				       struct file *file, u64 *data)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static int vfio_pci_liveupdate_retrieve(struct
> liveupdate_file_handler *handler, u64 data, struct file **file)
>  {
> @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> liveupdate_file_handler *handler, static bool
> vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> *handler, struct file *file) {
> -	return -EOPNOTSUPP;
> +	struct vfio_device *device =3D vfio_device_from_file(file);
> +
> +	if (!device)
> +		return false;
> +
> +	guard(mutex)(&device->dev_set->lock);
> +	return vfio_device_cdev_opened(device);
IIUC, vfio_device_cdev_opened(device) will only return true after
vfio_df_ioctl_bind_iommufd(). Where it does:
	device->cdev_opened =3D true;

Does this imply that devices not bound to an iommufd cannot be
preserved?

If so, I am confused about your cover letter step #15
> 15. It makes usual bind iommufd and attach page table calls.

Does it mean after restoration, we have to bind iommufd again?

I have a separate question regarding noiommu devices. I=E2=80=99m currently
working on adding noiommu mode support for VFIO cdev under iommufd.
=46rom my understanding, these devices should naturally be included in
your patchset, provided that I ensure the noiommu cdev follows the same
open/bind process. Is that correct?

>  }
> =20
>  static const struct liveupdate_file_ops vfio_pci_luo_fops =3D {
> +	.prepare =3D vfio_pci_liveupdate_prepare,
>  	.retrieve =3D vfio_pci_liveupdate_retrieve,
>  	.can_preserve =3D vfio_pci_liveupdate_can_preserve,
>  	.owner =3D THIS_MODULE,
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 38c8e9350a60..4cb47c1564f4 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1386,7 +1386,7 @@ const struct file_operations vfio_device_fops =3D
> { #endif
>  };
> =20
> -static struct vfio_device *vfio_device_from_file(struct file *file)
> +struct vfio_device *vfio_device_from_file(struct file *file)
>  {
>  	struct vfio_device_file *df =3D file->private_data;
> =20
> @@ -1394,6 +1394,7 @@ static struct vfio_device
> *vfio_device_from_file(struct file *file) return NULL;
>  	return df->device;
>  }
> +EXPORT_SYMBOL_GPL(vfio_device_from_file);
> =20
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index eb563f538dee..2443d24aa237 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -385,4 +385,6 @@ int vfio_virqfd_enable(void *opaque, int
> (*handler)(void *, void *), void vfio_virqfd_disable(struct virqfd
> **pvirqfd); void vfio_virqfd_flush_thread(struct virqfd **pvirqfd);
> =20
> +struct vfio_device *vfio_device_from_file(struct file *file);
> +
>  #endif /* VFIO_H */


