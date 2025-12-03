Return-Path: <linux-kselftest+bounces-46944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F03C9FA34
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 16:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4313E30004F4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 15:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77982318157;
	Wed,  3 Dec 2025 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RPuBiTOs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03F3148DA
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Dec 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764776799; cv=none; b=EUA8cOqi2awvd2kKSUusdTJhYylW40qWlqloPWN+gZsGr2rxDSTHe6fblc5eWfBTV2ZRrbMThiJgUSWRZf1XwrXkuYrx1I8AX6jlTjgWC2dIGf95Y9/p/xDz5cxoFU7PWsar3ZI2uc+0ABRevOaLdIm3sqMCD4JH8R2v6ngs2YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764776799; c=relaxed/simple;
	bh=9uir/666rpQjmBYhCBNN8Z50ojDfoysJShMBhMIvQsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sO5ba8w/+epAN6V83f5g/HZCMbI3yLP7ONz3AOi7cCZoNr+dMueKO1E7jmQMw3rfNoxBvnNMrfW1Azln0j30DzIxIgVmrr3+B2cMIWOBMvZozrrkaSo+tfe02bFfeYt62rBstsBUVaivslKAfnBkzLSzyIAfhvfMZ4QJqK23XBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=RPuBiTOs; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so12068367a12.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Dec 2025 07:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764776795; x=1765381595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9+8lbWW7UfBnkxY4lDzkEZXob5kb6NM+epeeBGpeEM=;
        b=RPuBiTOs7KpiqRqrubW5HNI3+bOkiKAnnuJpRV3yNivcQTEdTmVhe6fJg0QZfny5zX
         9qp9LYCMEPxmeju79QkWQmUakbmG3IS3sGH/lVW6L5xRF30gugTy+lnhbUkOvk3Rzb6F
         IGcZOZEOrR/yRkSpUSqh0C++3bdYvXnfu7AXPrrpmTXxysi1kKuO/tLtf653xnH1x43Y
         jcLQda1JQewqC3+vTGyU0Uc2FXoiPStx5Q7849+LvARff60NxnmpNq8t5uLCsRAO5Jsy
         /QXENCbg2YloU2FcYk/sKGqNb9A5yrrLuBZ3DVc0YArIUC0+xrbor0jH34nN2hPKM4UE
         gfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764776796; x=1765381596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9+8lbWW7UfBnkxY4lDzkEZXob5kb6NM+epeeBGpeEM=;
        b=SO4MFruV9y+MjOlvBarDbxGaUGDJoF86/fYypkffpddJgukwR+xLRwJal9r0YItWXr
         x7p/71vfr5z0xNJm7GsLuXtwAN6fQstipf3pSpoKcqd5lONwqXnAFP4D2UtF5XzvbPc0
         nUseZMtxc+gZ98NSDcTUhZES4Ck6sv9nkWDVaN4t8NhM0nYRZGRhbTb5p9Uam6cBSQfb
         PBGujbMHIB2qtcSy46suUgWw2N28vv5O2ZfRspSvYsetjqHa17RS6bGvGFe8xcM8gJhm
         Jfuuwt+9VE51BKwkld6DoNBa9zHM1q50HxA6U917ry4hopLuPNuH7igeqZBjQfM9glJ2
         vZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCVVyaK3e04EFIF0CXPXL5ZP8XfqDeTyVX1PLLYE1DpjAKPMezkahNSjMuoBpy72umPV4d7x8xflYf4xyy47yIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgp53CAouZSZM13xVaPJ1nr8IMPaJK8Aus2LfoFsaM5gJm48gO
	pBtMfmFlWzl0y1eHKUXw33HivAOlYWR1blFm2Hy/fkJJkvfTo0MKlmvq60SRUPy2UMh8q6UI+mT
	ZIoL9MiFvr0sTrekY8wNcw3hMSBZz5ueySJtKt8XRYg==
X-Gm-Gg: ASbGncvbMDgtIb1qp5ypvAXHPfEEDbZeiS5hkRq3Cb8xkjZUM6zXBEoBBccbmJT6GKi
	BOTdi8m/w7PKzuup2wZgKRz8ma48aDiJ+04Q5AGUTn+aMPlzg4SADQVDNlM48/pzUziOJHXr/ia
	gnDVf0RWu+Ts0eu8IDh/683UnBJqWpqwugV3MfPqdDgtETPC7JsuuxsMsYImO4LBsmZ+h4TAmdi
	txEBNlsailHl+CaK+F7z1QR5K4xyiueV0PXHQG+TB5f2Cvvi/00pifTpxEMFbtD7Pd8b4IJhdqb
	5mo=
X-Google-Smtp-Source: AGHT+IGyn0ZoI8pnyfMT3Hgwa/ZmVlJuxPqhedn0kEIs7IARp51p1LPogEX5qh/GHEMfhaPEnDrEDUE80IOGohrR3b4=
X-Received: by 2002:a05:6402:35d4:b0:647:7bfe:da8f with SMTP id
 4fb4d7f45d1cf-6479c2fdc7cmr2790012a12.0.1764776795508; Wed, 03 Dec 2025
 07:46:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-7-dmatlack@google.com>
 <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
In-Reply-To: <aTAzMUa7Gcm+7j9D@devgpu015.cco6.facebook.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 3 Dec 2025 10:45:58 -0500
X-Gm-Features: AWmQ_blDyRfBySet4UyQnBKlT3DfSfdMfA_YKiXzQts7qaw09jP9-UbQNlazg68
Message-ID: <CA+CK2bDbOQ=aGPZVP4L-eYobUyR0bQA0Ro6Q7pwQ_84UxVHnEw@mail.gmail.com>
Subject: Re: [PATCH 06/21] vfio/pci: Retrieve preserved device files after
 Live Update
To: Alex Mastro <amastro@fb.com>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 3, 2025 at 7:55=E2=80=AFAM Alex Mastro <amastro@fb.com> wrote:
>
> On Wed, Nov 26, 2025 at 07:35:53PM +0000, David Matlack wrote:
> > From: Vipin Sharma <vipinsh@google.com>
> >  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_op_args=
 *args)
> >  {
> > -     return -EOPNOTSUPP;
> > +     struct vfio_pci_core_device_ser *ser;
> > +     struct vfio_device *device;
> > +     struct folio *folio;
> > +     struct file *file;
> > +     int ret;
> > +
> > +     folio =3D kho_restore_folio(args->serialized_data);
> > +     if (!folio)
> > +             return -ENOENT;
>
> Should this be consistent with the behavior of pci_flb_retrieve() which p=
anics
> on failure? The short circuit failure paths which follow leak the folio,
> which seems like a hygiene issue, but the practical significance is moot =
if
> vfio_pci_liveupdate_retrieve() failure is catastrophic anyways?

pci_flb_retrieve() is used during boot. If it fails, we risk DMA
corrupting any memory region, so a panic makes sense. In contrast,
this retrieval happens once we are already in userspace, allowing the
user to decide how to handle the failure to recover the preserved
cdev.

Pasha

>
> > +
> > +     ser =3D folio_address(folio);
> > +
> > +     device =3D vfio_find_device(ser, match_device);
> > +     if (!device)
> > +             return -ENODEV;
> > +
> > +     /*
> > +      * During a Live Update userspace retrieves preserved VFIO cdev f=
iles by
> > +      * issuing an ioctl on /dev/liveupdate rather than by opening VFI=
O
> > +      * character devices.
> > +      *
> > +      * To handle that scenario, this routine simulates opening the VF=
IO
> > +      * character device for userspace with an anonymous inode. The re=
turned
> > +      * file has the same properties as a cdev file (e.g. operations a=
re
> > +      * blocked until BIND_IOMMUFD is called), aside from the inode
> > +      * association.
> > +      */
> > +     file =3D anon_inode_getfile_fmode("[vfio-device-liveupdate]",
> > +                                     &vfio_device_fops, NULL,
> > +                                     O_RDWR, FMODE_PREAD | FMODE_PWRIT=
E);
> > +
> > +     if (IS_ERR(file)) {
> > +             ret =3D PTR_ERR(file);
> > +             goto out;
> > +     }
> > +
> > +     ret =3D __vfio_device_fops_cdev_open(device, file);
> > +     if (ret) {
> > +             fput(file);
> > +             goto out;
> > +     }
> > +
> > +     args->file =3D file;
> > +
> > +out:
> > +     /* Drop the reference from vfio_find_device() */
> > +     put_device(&device->device);
> > +
> > +     return ret;
> > +}

