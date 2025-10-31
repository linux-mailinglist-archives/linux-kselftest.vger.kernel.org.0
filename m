Return-Path: <linux-kselftest+bounces-44560-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F867C272B8
	for <lists+linux-kselftest@lfdr.de>; Sat, 01 Nov 2025 00:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 741E11B26865
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 23:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852A032AAD5;
	Fri, 31 Oct 2025 23:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEU749Yw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65522329E52
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 23:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761952402; cv=none; b=qKs5vIRex13jx1t8tNennI0xc1ZD1880YBP/YDu38cGtdsTxoH1L2+KDQxxBfj+dSLeJ+/boXKbvk/o/MgsWdZy/oHk5OXtDfpYoUP9zWa2KfdRWpVYJQ/4VqTxUoFY5f98Fi8rIGShuRyXhAQivG1DdH4pAHPQR15G8g88RohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761952402; c=relaxed/simple;
	bh=XWZsqJRZo0jc8TEwczUrIZCZrP8vjp3+VpCSsodHNDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fIjutscQeCpnFBq42vgGPaG0V9mdwINoLAO7B4bsO/YJ+9m1p17SMomMvPTn17Ehn+GOjMvG6S99/b+hXxU4FZF49XzbbppWy7LS48XBRjSM8d9Zd/KjAWdxQaxb143MYiJA/YdXTe5sN4Q6X5XdEVfw8UW21+f01vGY0nc78EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEU749Yw; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-378cfd75fb0so32701701fa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761952398; x=1762557198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CduKhDs2d95anLLqO+pCgedfe9nkoQuIaYxFtLlvMAI=;
        b=kEU749Yw2luBSyqqeosBP2aguvxblfCIFQy0dCF+uFwUIPWuLzDHY8m+vc9S+svxtF
         ON96JnjkHmcJj+jr4y+TcnyxRPUnBSVGk9Kb8YQfquWuYdZZMzwhR+4ep+EmnGYbW1OZ
         wjGzSmDhQTlDpNMjqpgCXwC9lVCnmteiIS5C3r5CY+O/o7zgevmNkhAdcjW3lJ4m6RU1
         Y4U9LMudrBMj2kwmQItNr19AVN/P3f2Ux4Tk/4qbbs9bY1o4pjH0Xb87GC/PwQbGmYqD
         iE4DIdLAcsusXamwxNMXhe7bigmA+ElXLYDjkqf3dchNEL5sskAz32eeFZS7icmliiWr
         gVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761952398; x=1762557198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CduKhDs2d95anLLqO+pCgedfe9nkoQuIaYxFtLlvMAI=;
        b=ZEpaKKQJg0Ljgm604Ig9t8pJKG7O8c5Z5OAAlZhL0oHA2+pXYthbupII75VTXy3oFo
         HI57UJ5loTEFdZZypG6JXKvexX487afTyuTT13FDY4lpf5jdbZ+XFlQ9bnzeVbPkSKvS
         1Q1UxRJ/rDQbaxOFotl5egRbjdaTv/vrZ6xpyrctrWOn6nvQYJsoOfqBMyfHl/KlwDz3
         P+ARFj8UaBmfWcQQrHAMv0J5dfBPI9cmsUnw+yLuxbiodj9BSOef7hUMwzQkG5guNOie
         RGoQw6mNJyK/mgskkvf4agRHyInPkkUonaUcSwsSJDriZy8wOBwkN8oHqvxiREK46WXw
         McUw==
X-Forwarded-Encrypted: i=1; AJvYcCVhDW+tRF39vnm5UmiP+jD7dJjrzIet9ufrmOtEvFy8K4Ksg0bfzfA4/W8MABgHyB77HIdvc+xYD9Qbt7GomgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8gYnQZhUkSPha29xEWlK9hfLfRQ+pvrCH/0S+xEHx2CD9h95z
	qTgUBYiufe8y/QulqvgL5EO14AwVgfgphPqTAXyepOYrBz0SZ9+RJ53vQaAJFy46tvnDWcwV0fg
	Wdp8J9pPOZbvhQvVb+0R7mvT0TSkm9230siTI6/nq
X-Gm-Gg: ASbGncvioaQJbgn+yuQ8v/MGl7POq9XewoZ1L/T4NCOXc+TwnM+poShc8TGBZrWh0Yt
	kgh6axTiwggAkTvFoY15kqPdKj7+2pF/jhLY+iEIKiLAX1kCoYpl5vy+vxmcGsqIP8KYRKppmmE
	KWMiGRliEsq7JLSWy86oTyTilsOWxaVjRy/x0Jbm/PB7ZQZHG60PzbhUuXP+cEMiiOfWLLOxQwv
	jD7nCT2P2xksVRHt6X+4jOV/65sU4YKv4ams6wGX7LmZIxIswjUBvhGI3r6
X-Google-Smtp-Source: AGHT+IExErcOO2EIgmDaicMDUbGTWKxNreSKo2RDOW0/ULZPVApKfmIWoVK+h3uJ79oZ73j1I9/Rf0OSA92b1W105fQ=
X-Received: by 2002:a05:6512:3c92:b0:591:c8de:467b with SMTP id
 2adb3069b0e04-5941d542679mr1891506e87.40.1761952398324; Fri, 31 Oct 2025
 16:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-9-vipinsh@google.com>
In-Reply-To: <20251018000713.677779-9-vipinsh@google.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 16:12:50 -0700
X-Gm-Features: AWmQ_bkA4phyOyQRm4wqvCBQ3eNh3dDXKfq4mZi3gYwoRKx7jeTWqc2Xmhrpb1M
Message-ID: <CALzav=c9yw2B=1Y6kK2ZuxdBCnwuTHyOyA4VGT8_rLv2Wg5r4A@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] vfio/pci: Retrieve preserved VFIO device for
 Live Update Orechestrator
To: Vipin Sharma <vipinsh@google.com>
Cc: bhelgaas@google.com, alex.williamson@redhat.com, pasha.tatashin@soleen.com, 
	jgg@ziepe.ca, graf@amazon.com, pratyush@kernel.org, 
	gregkh@linuxfoundation.org, chrisl@kernel.org, rppt@kernel.org, 
	skhawaja@google.com, parav@nvidia.com, saeedm@nvidia.com, 
	kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:07=E2=80=AFPM Vipin Sharma <vipinsh@google.com> w=
rote:
>  static int vfio_pci_liveupdate_retrieve(struct liveupdate_file_handler *=
handler,
>                                         u64 data, struct file **file)
>  {
...
> +       filep =3D anon_inode_getfile_fmode("[vfio-cdev]", &vfio_device_fo=
ps, df,
> +                                        O_RDWR, FMODE_PREAD | FMODE_PWRI=
TE);

It's a little weird that we have to use an anonymous inode when
restoring cdev file descriptors. Do we care not about the association
between VFIO cdev files and their inodes?

If we wanted to have the cdev inode we could have the user pass a file
path to ioctl(LIVEUPDATE_SESSION_RESTORE_FD)? File handlers can use
that to find the inode to use when creating a struct file. This would
avoid the anonymous inode and also ensure that restoring the fd obeys
the same filesystem permissions as opening a new fd (I think?).

Pasha this would be a uAPI change to LUO. What do you think?

Sami, Jason, what are you planning to do for iommufd?

> +       if (IS_ERR(filep)) {
> +               err =3D PTR_ERR(filep);
> +               goto err_anon_inode;
> +       }
> +
> +       /* Paired with the put in vfio_device_fops_release() */
> +       if (!vfio_device_try_get_registration(device)) {
> +               err =3D -ENODEV;
> +               goto err_get_registration;
> +       }
> +
> +       put_device(&device->device);
> +
> +       /*
> +        * Use the pseudo fs inode on the device to link all mmaps
> +        * to the same address space, allowing us to unmap all vmas
> +        * associated to this device using unmap_mapping_range().
> +        */
> +       filep->f_mapping =3D device->inode->i_mapping;

Most of this code already exists in vfio_device_fops_cdev_open(). I'll
work on sharing the code in the next version.

