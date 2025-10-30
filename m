Return-Path: <linux-kselftest+bounces-44461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7043BC22A83
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 347024E21AC
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 23:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49FD33BBA1;
	Thu, 30 Oct 2025 23:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="veMub3IL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749433B955
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 23:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761865810; cv=none; b=K4z/KYQt4syYZGmovYxm05xT0oAnBrO0nYKde3IB2IGMmdLS4ocM5Srr1+Wqz2vs9zck2ADbltgeN3tXSOLW3Umi7NJeikKoY1Xd3yjSUCNSEi49YW1SI0VG71rnSqbs4Bc5hMFaZsaOzoIxSHp/Orv/GLdCmeqn1beX8S7cCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761865810; c=relaxed/simple;
	bh=3c8fubCSOMv120xOPHfvgzA84Hedn11zJ/B3Ut3CdEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzRZq5hRpk4HKSej5dwWkUJqqAeO0Qvc/7NfIRzfiIueaNlpCtkly+FfwPR5mi41++BxO8b7wJWZmiARXPBc+mb9YkhCLCy4XaFo7AqkR5kWCP7csjf46+Na8utlOZh1Gou9evHgRuN2dI5SnSdp/ls2FTJTNtCuUfLxgN3HhIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=veMub3IL; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso1364747a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 16:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761865808; x=1762470608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=veMub3IL6/IzVwVBTVxovKgfQ48ftr9Zb1gFb2xlhnmYqV7gs5wTh/Qkpgd1/MAJqp
         CinbTODC4ksv2ffWtVGxWpWRYjXJhKlaQuXYSa+VgYzFVcJMV3KSISioCzjfHjbQt6p3
         nUcb2R3dQfSMN+FzOlPIzs6w1bBknLxmJPlgp4FZhVvhe2ezsYk5fXwNZikM5Nsdkj/9
         Hss/oy10N/xNwt+RPSKw5XZ6s+JyWVuCfktuU84bx5PJBY6+scLUo7V5XqGy7s7OXZlh
         CC5xj5s96JqHbCRc4aiHVVQm4jbMXEazmypQrf8CIq9XAFZahwQKpE45ENATZYcBgHL3
         d+lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761865808; x=1762470608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVrBZIo4jViBqFI34xTRu6DdRHmaa8XjkF8JPCjoQvA=;
        b=d+Ux13CIMOgYGD4irw7p6ng4bG45ompyjOd9DbYZijYwtYpC11AcQH+2bEyU/fWwIV
         w0qqV4RI5zQbDA47iQjrdJng3+ggzViZdlGjrcDgN0nXbxAaPUtEUhKFLV2VGkYUILgy
         TOCmFs6uo63lp1JGPPF9J5FzxiCT2M5AL7Nkcpt4avxzsYksxhnPasUpfmHaupALF0nT
         KIvsX/8zpS9jbtSEnb3JUswes2QErO6crXQY/J9GXkqUhtUn+RpGvk85h5nq82H7FXWp
         c4XYJSQE0/koHSVH5jV33HbWCVjbk5se+VWxvgMXDZX/u9d4lu0lNjdQE8m0PWhkM3Qi
         QW6A==
X-Forwarded-Encrypted: i=1; AJvYcCUSlO4MPI9sM3Qf4aNsazsh4BoZjnoQWxedgxt1dUTln0pChj7R3V/isPDCU0RIv+LP1xnUQ4h6U3xGe5of5c4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHvOkBGZXcv3LXdrcRUSotevFbOhMtOIUFRUa6JSD2C83Nl3Xk
	y78mkX70XJV9u2xHqTPX7yx+ypBbwLvjCakBysjus4BstxkGTeMF21na9W9dJoRK5A==
X-Gm-Gg: ASbGncuBfqMZ+MSdgymI1/vpSbLqKTS4sJdxx1+Sr8gbd4KBAmU8reXrYmoFT7OKRJj
	BGhwXJ3sbVkyWTjXifSDP4K4gJ/QqnV27BTmtaWXt4EfE5JgMLb2k9mXJfyFxXpbbZZQyi0GgTp
	/NMSLkvN5BpN8aGw1yPHqobXvpIJR9mbzRtAO7sTod+tobbAYwSz3n2OxqS5U5pEOSLm+U1GGUg
	eDt97RtXvUQs4sv8svHXPsPwPKMomCYSAeYurugNeMZ7Coi3dkJehIX/95g7kXuxKjdJ4TIhL4A
	hhQgI/ZJmxTs2LBOpCBFbe43xP4u+cJ/xiBNKl3YS6JVPFWDINR7c6GQWfnjZrk+CkNr9bMy3cc
	luWMPnFEDNmVcFUWXBw3naUNdfaqrc2tcZCLtYIiOOs+in279RrIn/bAv5zn/QBaN2SnZiO8bex
	emcBphOu796UcovQxqtgcTetqiQMEQU0u1gWspN43DUKrOD94BhEej
X-Google-Smtp-Source: AGHT+IEM9Vd0HVjov8boWovrq63avSdAuwijp306wSVuatfQyJg281aFDD9T6kwljFFF6SpZOGU8uQ==
X-Received: by 2002:a17:902:d505:b0:290:c0ed:de42 with SMTP id d9443c01a7336-2951a4dfc4fmr19563065ad.36.1761865807920;
        Thu, 30 Oct 2025 16:10:07 -0700 (PDT)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b791sm833815ad.75.2025.10.30.16.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 16:10:06 -0700 (PDT)
Date: Thu, 30 Oct 2025 23:10:02 +0000
From: David Matlack <dmatlack@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Vipin Sharma <vipinsh@google.com>, bhelgaas@google.com,
	alex.williamson@redhat.com, pasha.tatashin@soleen.com, jgg@ziepe.ca,
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org,
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com,
	parav@nvidia.com, saeedm@nvidia.com, kevin.tian@intel.com,
	jrhilke@google.com, david@redhat.com, jgowans@amazon.com,
	dwmw2@infradead.org, epetron@amazon.de, junaids@google.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
Message-ID: <aQPwSltoH7rRsnV9@google.com>
References: <20251018000713.677779-1-vipinsh@google.com>
 <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027134430.00007e46@linux.microsoft.com>

On 2025-10-27 01:44 PM, Jacob Pan wrote:
> On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> wrote:
> >  static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, u64 data, struct file **file)
> >  {
> > @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> > liveupdate_file_handler *handler, static bool
> > vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> > *handler, struct file *file) {
> > -	return -EOPNOTSUPP;
> > +	struct vfio_device *device = vfio_device_from_file(file);
> > +
> > +	if (!device)
> > +		return false;
> > +
> > +	guard(mutex)(&device->dev_set->lock);
> > +	return vfio_device_cdev_opened(device);
>
> IIUC, vfio_device_cdev_opened(device) will only return true after
> vfio_df_ioctl_bind_iommufd(). Where it does:
> 	device->cdev_opened = true;
> 
> Does this imply that devices not bound to an iommufd cannot be
> preserved?

Event if being bound to an iommufd is required, it seems wrong to check
it in can_preserve(), as the device can just be unbound from the iommufd
before preserve().

I think can_preserve() just needs to check if this is a VFIO cdev file,
i.e. vfio_device_from_file() returns non-NULL.

> 
> If so, I am confused about your cover letter step #15
> > 15. It makes usual bind iommufd and attach page table calls.
> 
> Does it mean after restoration, we have to bind iommufd again?

This is still being discussed. These are the two options currently:

 - When userspace retrieves the iommufd from LUO after kexec, the kernel
   will internally restore all VFIO cdevs and bind them to the iommufd
   in a single step.

 - Userspace will retrieve the iommufd and cdevs from LUO separately,
   and then bind each cdev to the iommufd like they were before kexec.

