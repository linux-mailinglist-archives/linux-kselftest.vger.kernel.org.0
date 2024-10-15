Return-Path: <linux-kselftest+bounces-19750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F8899F298
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0724C1F21BFF
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C921DD0C1;
	Tue, 15 Oct 2024 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iu5rv6Sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AF71714BE
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 16:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009345; cv=none; b=ZKZDj6FxbwYsZaUwJ6ErfxpSmw7RPdVLHb+/+7SQOopg+4AFMnbZ6TG7P4B+CYxCcEU5ErwqXrZIYgN/V3S5rcViDIK7FdwYZbOGNc9wGTgHTC/nLbyb8sGnxAgNeEipC/seR52Wqi6sN1Brd+tQuYS8IdWySYlRDLVjGNKnWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009345; c=relaxed/simple;
	bh=pjhtjFni5E0oYauVMFJxw2/cRKimK2at950HXSmnLU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndWZESKauHU0gTgQ2W9NTqBmYnTI259s1yZacljfvo5Ue8ZFUp7SeXTcy3QRLihIOZ7Zb8tiK3DnTE5d/TbCClec7i/Uh+XhCEBSji43cLzMcbRny8GE0URlObyvkenzxO0ZnfQb5MMvMFyBX7zEwTRr5ShI5hK4V8CeYunYAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iu5rv6Sr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729009342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D0ogSl2e+pzxm9DQxkr5ZhkXB5GDU2MP8w9r7SynvqI=;
	b=Iu5rv6Sr44cddDEdEJ434fNMhr2tRTnySPwxN0cZD6gv9SB9RqIaXx7hdW6meUOIIbo32N
	vYBl0JStoBG6AmjulB8pzJLvcchDTBZaTLUzq1LFelXDc5qt8/fF5KtB5qadcRZ6kVkw8Q
	BgftHozrUgSWPlSlhRRXCJthnt44QQM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-27DOY5NmMG24_CeUl3O-WA-1; Tue, 15 Oct 2024 12:22:21 -0400
X-MC-Unique: 27DOY5NmMG24_CeUl3O-WA-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-834a9a3223aso59825139f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 09:22:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729009340; x=1729614140;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D0ogSl2e+pzxm9DQxkr5ZhkXB5GDU2MP8w9r7SynvqI=;
        b=SHFdb2vMs7NUcNRXv2p6miEAKo4ogB7/nos4Z4oOEyb1oU1IJj7zPk8QQr2WAaDZZF
         Ow0sWVRcQrciHQ3Jah8d5u/U++mO90k2VP8ahJZOooZJtVRGbM7zY/p8U+3h2hqZLoSB
         ZakGpFrw0x+fOwv4lLgtOWcgH4z5u+s8h/6pa+UUiNOp5nNvXPn5z3Phzs11PZERvFBh
         J5q0NUhxrkPpD2L36RK/3FQ6hN93EoFwT0l0Gr4aQQTT0kYQnseZubMhAS9eWcOdjuAD
         VwT1NSBAm3DLoxO7a2IGlNMUCiD+Q9hHN+KjGPJ2tCoL4FC6JAqCXjIS20pR+6SwF7lN
         rGtw==
X-Forwarded-Encrypted: i=1; AJvYcCWTkOQ+woJYsECimOQl8EahtIzZKAHsxQgAsc09V9y5Ja76Ej3wDF6uf/P+UdBMVCDMuy7/qSR9UuMtDbj++YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDnnWGa2bsqpmGRkW0nJEzYtISGRCIM+FHDVXj7OsJf3d4wvrj
	c5TC15oAsPIgE+bbcAlZw+1DxOJrZc/zukfcCZfEyi3a38B/9idWvtsvx8cwnuWiLWq1aBsI4rJ
	KF1udIt0tL6TDFomkdydFJyZFj7IIbiFTvToCiiNMnE56WWPePbvb4mHCXkmzO9NPag==
X-Received: by 2002:a05:6602:3352:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-83792419c98mr345227339f.2.1729009340184;
        Tue, 15 Oct 2024 09:22:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSkc6Y2bSMoTB4zwDROjEeyJ5tTGduXy6mtiXimE0HBSzkJTAanaRw2GITeakEsvwM2yiPPA==
X-Received: by 2002:a05:6602:3352:b0:81f:86e1:5a84 with SMTP id ca18e2360f4ac-83792419c98mr345226239f.2.1729009339749;
        Tue, 15 Oct 2024 09:22:19 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83a8b50d10dsm36606439f.40.2024.10.15.09.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 09:22:19 -0700 (PDT)
Date: Tue, 15 Oct 2024 10:22:15 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "joro@8bytes.org" <joro@8bytes.org>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "chao.p.peng@linux.intel.com"
 <chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "vasant.hegde@amd.com" <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 3/4] vfio: Add
 VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20241015102215.05cd16c7.alex.williamson@redhat.com>
In-Reply-To: <2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
	<20240912131729.14951-4-yi.l.liu@intel.com>
	<BN9PR11MB5276D2D0EEAC2904EDB60B048C762@BN9PR11MB5276.namprd11.prod.outlook.com>
	<20241001121126.GC1365916@nvidia.com>
	<a435de20-2c25-46f5-a883-f10d425ef37e@intel.com>
	<20241014094911.46fba20e.alex.williamson@redhat.com>
	<2e5733a2-560e-4e8f-b547-ed75618afca5@intel.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 19:07:52 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 2024/10/14 23:49, Alex Williamson wrote:
> > On Sat, 12 Oct 2024 21:49:05 +0800
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> >> On 2024/10/1 20:11, Jason Gunthorpe wrote:  
> >>> On Mon, Sep 30, 2024 at 07:55:08AM +0000, Tian, Kevin wrote:
> >>>      
> >>>>> +struct vfio_device_pasid_attach_iommufd_pt {
> >>>>> +	__u32	argsz;
> >>>>> +	__u32	flags;
> >>>>> +	__u32	pasid;
> >>>>> +	__u32	pt_id;
> >>>>> +};
> >>>>> +
> >>>>> +#define VFIO_DEVICE_PASID_ATTACH_IOMMUFD_PT	_IO(VFIO_TYPE,
> >>>>> VFIO_BASE + 21)  
> >>>>
> >>>> Not sure whether this was discussed before. Does it make sense
> >>>> to reuse the existing VFIO_DEVICE_ATTACH_IOMMUFD_PT
> >>>> by introducing a new pasid field and a new flag bit?  
> >>>
> >>> Maybe? I don't have a strong feeling either way.
> >>>
> >>> There is somewhat less code if you reuse the ioctl at least  
> >>
> >> I had a rough memory that I was suggested to add a separate ioctl for
> >> PASID. Let's see Alex's opinion.  
> > 
> > I don't recall any previous arguments for separate ioctls, but it seems
> > to make a lot of sense to me to extend the existing ioctls with a flag
> > to indicate pasid cscope and id.  Thanks,  
> 
> thanks for the confirmation. How about the below?
> 
> diff --git a/drivers/vfio/device_cdev.c b/drivers/vfio/device_cdev.c
> index bb1817bd4ff3..c78533bce3c6 100644
> --- a/drivers/vfio/device_cdev.c
> +++ b/drivers/vfio/device_cdev.c
> @@ -162,21 +162,34 @@ void vfio_df_unbind_iommufd(struct vfio_device_file *df)
>   int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>   			    struct vfio_device_attach_iommufd_pt __user *arg)
>   {
> -	struct vfio_device *device = df->device;
> +	unsigned long minsz = offsetofend(
> +			struct vfio_device_attach_iommufd_pt, pt_id);
>   	struct vfio_device_attach_iommufd_pt attach;
> -	unsigned long minsz;
> +	struct vfio_device *device = df->device;
> +	u32 user_size;
>   	int ret;
> 
> -	minsz = offsetofend(struct vfio_device_attach_iommufd_pt, pt_id);
> +	ret = get_user(user_size, (u32 __user *)arg);
> +	if (ret)
> +		return ret;
> 
> -	if (copy_from_user(&attach, arg, minsz))
> -		return -EFAULT;
> +	ret = copy_struct_from_user(&attach, sizeof(attach), arg, user_size);
> +	if (ret)
> +		return ret;

I think this could break current users.  For better or worse, we don't
currently have any requirements for the remainder of the user buffer,
whereas copy_struct_from_user() returns an error for non-zero trailing
bytes.  I think we need to monotonically increase the structure size,
but maybe something more like below, using flags.  The expectation
would be that if we add another flag that extends the structure, we'd
test that flag after PASID and clobber xend to a new value further into
the new structure.  We'd also add that flag to the flags mask, but we'd
share the copy code.

	if (attach.argsz < minsz)
		return -EINVAL;

	if (attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
		return -EINVAL;

	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
		xend = offsetofend(struct vfio_device_attach_iommufd_pt, pasid);

	if (xend) {
		if (attach.argsz < xend)
			return -EINVAL;
	
		if (copy_from_user((void *)&attach + minsz,
				    (void __user *)arg + minsz, xend - minsz))
			return -EFAULT;
	}

Maybe there are still more elegant options available.

We also generally try to label flags with FLAGS in the name, but it
does get rather unwieldy, so I'm open to suggestions.  Thanks,

Alex

> 
> -	if (attach.argsz < minsz || attach.flags)
> +	if (attach.argsz < minsz || attach.flags & (~VFIO_DEVICE_ATTACH_PASID))
>   		return -EINVAL;
> 
> +	if ((attach.flags & VFIO_DEVICE_ATTACH_PASID) &&
> +	    !device->ops->pasid_attach_ioas)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&device->dev_set->lock);
> -	ret = device->ops->attach_ioas(device, &attach.pt_id);
> +	if (attach.flags & VFIO_DEVICE_ATTACH_PASID)
> +		ret = device->ops->pasid_attach_ioas(device, attach.pasid,
> +						     &attach.pt_id);
> +	else
> +		ret = device->ops->attach_ioas(device, &attach.pt_id);
>   	if (ret)
>   		goto out_unlock;
> 
> @@ -198,20 +211,33 @@ int vfio_df_ioctl_attach_pt(struct vfio_device_file *df,
>   int vfio_df_ioctl_detach_pt(struct vfio_device_file *df,
>   			    struct vfio_device_detach_iommufd_pt __user *arg)
>   {
> -	struct vfio_device *device = df->device;
> +	unsigned long minsz =
> +		offsetofend(struct vfio_device_detach_iommufd_pt, flags);
>   	struct vfio_device_detach_iommufd_pt detach;
> -	unsigned long minsz;
> +	struct vfio_device *device = df->device;
> +	u32 user_size;
> +	int ret;
> 
> -	minsz = offsetofend(struct vfio_device_detach_iommufd_pt, flags);
> +	ret = get_user(user_size, (u32 __user *)arg);
> +	if (ret)
> +		return ret;
> 
> -	if (copy_from_user(&detach, arg, minsz))
> -		return -EFAULT;
> +	ret = copy_struct_from_user(&detach, sizeof(detach), arg, user_size);
> +	if (ret)
> +		return ret;
> 
> -	if (detach.argsz < minsz || detach.flags)
> +	if (detach.argsz < minsz || detach.flags & (~VFIO_DEVICE_DETACH_PASID))
>   		return -EINVAL;
> 
> +	if ((detach.flags & VFIO_DEVICE_DETACH_PASID) &&
> +	    !device->ops->pasid_detach_ioas)
> +		return -EOPNOTSUPP;
> +
>   	mutex_lock(&device->dev_set->lock);
> -	device->ops->detach_ioas(device);
> +	if (detach.flags & VFIO_DEVICE_DETACH_PASID)
> +		device->ops->pasid_detach_ioas(device, detach.pasid);
> +	else
> +		device->ops->detach_ioas(device);
>   	mutex_unlock(&device->dev_set->lock);
> 
>   	return 0;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 2b68e6cdf190..40b414e642f5 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -931,29 +931,34 @@ struct vfio_device_bind_iommufd {
>    * VFIO_DEVICE_ATTACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 19,
>    *					struct vfio_device_attach_iommufd_pt)
>    * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for attach.
>    * @pt_id:	Input the target id which can represent an ioas or a hwpt
>    *		allocated via iommufd subsystem.
>    *		Output the input ioas id or the attached hwpt id which could
>    *		be the specified hwpt itself or a hwpt automatically created
>    *		for the specified ioas by kernel during the attachment.
> + * @pasid:	The pasid to be attached, only meaningful when
> + *		VFIO_DEVICE_ATTACH_PASID is set in @flags
>    *
>    * Associate the device with an address space within the bound iommufd.
>    * Undo by VFIO_DEVICE_DETACH_IOMMUFD_PT or device fd close.  This is only
>    * allowed on cdev fds.
>    *
> - * If a vfio device is currently attached to a valid hw_pagetable, without 
> doing
> - * a VFIO_DEVICE_DETACH_IOMMUFD_PT, a second VFIO_DEVICE_ATTACH_IOMMUFD_PT 
> ioctl
> - * passing in another hw_pagetable (hwpt) id is allowed. This action, also 
> known
> - * as a hw_pagetable replacement, will replace the device's currently attached
> - * hw_pagetable with a new hw_pagetable corresponding to the given pt_id.
> + * If a vfio device or a pasid of this device is currently attached to a valid
> + * hw_pagetable (hwpt), without doing a VFIO_DEVICE_DETACH_IOMMUFD_PT, a 
> second
> + * VFIO_DEVICE_ATTACH_IOMMUFD_PT ioctl passing in another hwpt id is allowed.
> + * This action, also known as a hw_pagetable replacement, will replace the
> + * currently attached hwpt of the device or the pasid of this device with 
> a new
> + * hwpt corresponding to the given pt_id.
>    *
>    * Return: 0 on success, -errno on failure.
>    */
>   struct vfio_device_attach_iommufd_pt {
>   	__u32	argsz;
>   	__u32	flags;
> +#define VFIO_DEVICE_ATTACH_PASID	(1 << 0)
>   	__u32	pt_id;
> +	__u32	pasid;
>   };
> 
>   #define VFIO_DEVICE_ATTACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 19)
> @@ -962,17 +967,21 @@ struct vfio_device_attach_iommufd_pt {
>    * VFIO_DEVICE_DETACH_IOMMUFD_PT - _IOW(VFIO_TYPE, VFIO_BASE + 20,
>    *					struct vfio_device_detach_iommufd_pt)
>    * @argsz:	User filled size of this data.
> - * @flags:	Must be 0.
> + * @flags:	Flags for detach.
> + * @pasid:	The pasid to be detached, only meaningful when
> + *		VFIO_DEVICE_DETACH_PASID is set in @flags
>    *
> - * Remove the association of the device and its current associated address
> - * space.  After it, the device should be in a blocking DMA state.  This 
> is only
> - * allowed on cdev fds.
> + * Remove the association of the device or a pasid of the device and its 
> current
> + * associated address space.  After it, the device or the pasid should be in a
> + * blocking DMA state.  This is only allowed on cdev fds.
>    *
>    * Return: 0 on success, -errno on failure.
>    */
>   struct vfio_device_detach_iommufd_pt {
>   	__u32	argsz;
>   	__u32	flags;
> +#define VFIO_DEVICE_DETACH_PASID	(1 << 0)
> +	__u32	pasid;
>   };
> 
>   #define VFIO_DEVICE_DETACH_IOMMUFD_PT		_IO(VFIO_TYPE, VFIO_BASE + 20)


