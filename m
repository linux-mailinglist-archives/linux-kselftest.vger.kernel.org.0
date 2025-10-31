Return-Path: <linux-kselftest+bounces-44468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B3B9C22C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 01:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23C95424474
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 00:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806E61A08A3;
	Fri, 31 Oct 2025 00:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WR8lxUAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B449443
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 00:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761869975; cv=none; b=sWFphFahDGTCveWBGyZX8qnQGham7tkYBjs2z0q7vqVJYIT3B2ZD3plCDDDk1VlUCyUDn9UJwZkkK62A61IM4BCavHfdN4s+1lRkNbAxD6nCbDP7W587bsXYMdkxQamV/AtJUvsUD6KWGaZ6ZKJVAI0E3CG0+28jZURWUgQc0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761869975; c=relaxed/simple;
	bh=8rHUYkXKPL5IW43a+4rQNutLuyHqHIoW5Z0VxJSm0u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jWhUqKagdy26shUWFT4BKrkUowsAec/m+HPnD+LxPOJbmkVY/hBymIPee1T69xWPNbzHb+U/aFz65XApz0KnWqmxGn82vSn6li1q/HPwjzcA1HoV2I0tXGdXP+BuTLWLSTAo8SUOUQTEf8DQigqpn7lWsY50gwt//dj1grIMFw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WR8lxUAx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-63c523864caso3399379a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Oct 2025 17:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761869971; x=1762474771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv3Ljvf1heM/ChX+5Kbnk959i79o/ym9ON91SVXdVic=;
        b=WR8lxUAxQmD+DWLD1tgzmINQnPnyk6Vm976ZZpfc/IITPpAPs+kxbXZbaybX0nFwbv
         NP62A1PqWLovWAkXh9DGcUrXuzEEQQpxKJ3JorgCVpURG+3TKFcJ9nQy3vy+SWPmR3NS
         X8PTqprIfWt1r8qoyEIY8+qr8MTuKr8btlRjGZ2k1dZ7zM41eNj7VKyWMl1RNHRk6Zav
         0IxobgQB8mmDp07zCyQVT5Jn4zr7J1GWVIvCUjPxfK9x782d6AEE0y2XdGOLZJ5OPbNx
         xq4vRUKVwBDN8go1aAmpL3GcFErz41o/O7lOstO8c67Lob+4CzOstfEduiGJ6TAwzc5Q
         O/DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761869971; x=1762474771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cv3Ljvf1heM/ChX+5Kbnk959i79o/ym9ON91SVXdVic=;
        b=KW7DlERtK3VzuPAuI/MaNfzbJGxusBlj1BNpHpt0QrcOIYb5KflZJuSBiixZb+yBNA
         UZz+nDv/CDCqy7LSZ0ekh7Y85r5TX1rT9XWVuQ056yStviIYlprL7nfQdcrtDcsUC4ii
         KbPYv+QIE6oud2lsbGw7oLRRzrlLKoErSqzSeo7iXbsXrMbpwkFAm19WN/9c47/ZgWOj
         Ji6gDPC5uGKcrdQSv0BP4LCqJv+Z/Gs+oPtdgruKlxVemG/fPfZouTKEEyQ26rsutiiV
         NZvz/G3hv1AmGkuX2hnoQ73Wt38FF51x4wUFVrL4/TuxPdlyRJD51ZzTgxVbI3D9ogg2
         myUA==
X-Forwarded-Encrypted: i=1; AJvYcCWG7hG3OqJEhndlkqHuSg4kLozGW2dkCiEIWcwyjKXHEgPujA9jthvNa/3VJvxzbJn9qHCBuuWqGdKe43a/SNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY9N4tEZtV9roNXcXKUzSwn8QGuTdWq2HxGa5yw6Tpt06DPguF
	C3NarYdbHyXHcKFZllF11C3gAaqA5/IyoGsEBuvtM1Z7R4AP9y/SgqvXEHcwfwz6Ihe8Mum7qzO
	F8s8jyv+wElglvPvzw2Y0i9OT93zEO+eOCSJRtl/qJg==
X-Gm-Gg: ASbGnctYjcb8EGm/s9+o8yB8PKmmu0u27yhfiTCI0RAagwwbnp7SoRJdy06pF3WyTGM
	JrSKs9FAmhAlSZzHZbciWVLAaXRRmiSxFRTNFVM7K2xk/TRA4iPRYG5p50uyqyR98TkdIGsHkiE
	wSMNsTMFIQbLwvgN2hpv58uzRJ3Ixifc4MsoXOJ8eC47dF8nTL28t0wGgdQTmc0KGuhD6RmFxkW
	Lh2Y1d64x8ZKuiZMIgL4T6DeTenjQ63mETqjutZPNkZMEWhtC25efPw8wVKCSI1M8un
X-Google-Smtp-Source: AGHT+IHAmJ5aHdM6JoD2TOJsB7BThxEoT5eo1YrDOCS0gC6NmplAKbJLD+yZsTcgPKK2dj5Dhi5gMIE8RdzNHN72sus=
X-Received: by 2002:a05:6402:13cb:b0:640:6a18:2931 with SMTP id
 4fb4d7f45d1cf-6407702dcd1mr1160377a12.29.1761869971150; Thu, 30 Oct 2025
 17:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com> <aQPwSltoH7rRsnV9@google.com>
In-Reply-To: <aQPwSltoH7rRsnV9@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Thu, 30 Oct 2025 20:18:54 -0400
X-Gm-Features: AWmQ_bmaQn5U2r87lGmHMokOwG7--caG9FTwwPKr2aHRFfrExiLwJYx42aUNdvg
Message-ID: <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
To: David Matlack <dmatlack@google.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, Vipin Sharma <vipinsh@google.com>, 
	bhelgaas@google.com, alex.williamson@redhat.com, jgg@ziepe.ca, 
	graf@amazon.com, pratyush@kernel.org, gregkh@linuxfoundation.org, 
	chrisl@kernel.org, rppt@kernel.org, skhawaja@google.com, parav@nvidia.com, 
	saeedm@nvidia.com, kevin.tian@intel.com, jrhilke@google.com, david@redhat.com, 
	jgowans@amazon.com, dwmw2@infradead.org, epetron@amazon.de, 
	junaids@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 7:10=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-10-27 01:44 PM, Jacob Pan wrote:
> > On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> wr=
ote:
> > >  static int vfio_pci_liveupdate_retrieve(struct
> > > liveupdate_file_handler *handler, u64 data, struct file **file)
> > >  {
> > > @@ -21,10 +28,17 @@ static int vfio_pci_liveupdate_retrieve(struct
> > > liveupdate_file_handler *handler, static bool
> > > vfio_pci_liveupdate_can_preserve(struct liveupdate_file_handler
> > > *handler, struct file *file) {
> > > -   return -EOPNOTSUPP;
> > > +   struct vfio_device *device =3D vfio_device_from_file(file);
> > > +
> > > +   if (!device)
> > > +           return false;
> > > +
> > > +   guard(mutex)(&device->dev_set->lock);
> > > +   return vfio_device_cdev_opened(device);
> >
> > IIUC, vfio_device_cdev_opened(device) will only return true after
> > vfio_df_ioctl_bind_iommufd(). Where it does:
> >       device->cdev_opened =3D true;
> >
> > Does this imply that devices not bound to an iommufd cannot be
> > preserved?
>
> Event if being bound to an iommufd is required, it seems wrong to check
> it in can_preserve(), as the device can just be unbound from the iommufd
> before preserve().
>
> I think can_preserve() just needs to check if this is a VFIO cdev file,
> i.e. vfio_device_from_file() returns non-NULL.

+1, can_preserve() must be fast, as it might be called on every single
FD that is being preserved, to check if type is correct.
So, simply check if "struct file" is cdev via ops check perhaps via
and thats it. It should be a very simple operation

>
> >
> > If so, I am confused about your cover letter step #15
> > > 15. It makes usual bind iommufd and attach page table calls.
> >
> > Does it mean after restoration, we have to bind iommufd again?
>
> This is still being discussed. These are the two options currently:
>
>  - When userspace retrieves the iommufd from LUO after kexec, the kernel
>    will internally restore all VFIO cdevs and bind them to the iommufd
>    in a single step.
>
>  - Userspace will retrieve the iommufd and cdevs from LUO separately,
>    and then bind each cdev to the iommufd like they were before kexec.

