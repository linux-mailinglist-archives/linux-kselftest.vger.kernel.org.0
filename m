Return-Path: <linux-kselftest+bounces-44556-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B91BC27108
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 22:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC804400B0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 21:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5233128B1;
	Fri, 31 Oct 2025 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBc/56BT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FA41DDC37
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761946904; cv=none; b=fA+baeYbf8qUBZsJd9xhJKxoDjJ7C6EHLhtB/MuGTQXf4tY8ysqgd5n0jqXPYGJ+uoQd8FzBNQUDLViL5/GFHyUppKZf7YyIXpJoJlSMyztfyK89kFh4+eJSf85qxhcAoTFfQmFT1heKyaSYSkfaORzVatmcx7fgXawnh0cwjzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761946904; c=relaxed/simple;
	bh=eLQIYWaVPW49aK17HBWd1NWzjca/Qm0rfLEwUldyuNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL+AhZClhh/8IqaQWcHUj3KwjjmymEmSubHJ7TEEmeV9ulMrtNDWvnhjhzB+YOc6maaLdJezwvkODJlZ1NKw9MuV5toJ/i8UIGbTWR8l9Lbm+k5n3MDrzSJgn0GfaPY87gwpalPcteQExnoziU2IT/Kyx1VxOmnWlQjIDfznFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBc/56BT; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9310a7b2668so988892241.3
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Oct 2025 14:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761946902; x=1762551702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgDmmhPmt8GWeeRC0I/+oZ9vobNYjk5v0/zKbM027nU=;
        b=KBc/56BTegzCNHDAOB+1xs8j34IyNk/qcQe5fPQsUkoo+GOM3lpQNVq4mW9UP7hycf
         q2UR3OT8M814DZaL3HzFVkOWaj9grlX5HvEWgpP6SSAibqoDH8OATtfSjNQpuuJ7CRAE
         9wrWJMYKx3oQLrd3NU4iQfP7vK7sDFxzUOAzWERz/G5C19igImnOCvHf/r+NRvbyEZER
         +FkHaMyrgHL5MQLPJr0UspXMuWJqf0ZtXES7m6LMH39erHXBpE0TH/IEY6mvEMtHzTuE
         BZWoc8dIeKHFZABpqALwHV1mKKREO0RANklUkX6d4Yuqn9cQIbYU+dFMYe/SBOJDB5gs
         Soyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761946902; x=1762551702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RgDmmhPmt8GWeeRC0I/+oZ9vobNYjk5v0/zKbM027nU=;
        b=jZby5vS6TP7uaRkYXKuu+tjsfjqnwx77Pb2E9DNS9QJP7+weVn0cmkafMkH0mJymT8
         eNdWs9R/yudm2SYV80dAHRMeXfp0hYp7O/E7d2EKEWQ0KfS1IkeRoDNaxmOPpwO+fVsu
         ZtTB19TIArqAmOjBr9X6LWgQ4dPPQMXJp5YPC8NpM6sU6KY019iv5mGUz9cPS0mSmpWp
         ZmSxSqaJUV8fxz1LTXr9jv4UGDckibVX+4vWeazabrkt37JJBJHVBifJHkoriTi67Ntp
         7y8NmmuVQTwvYOuF1N5bu2GS7sHX9m8/Kr5be0NBY5an3+nNiVfcroxpPQTjDCUakSDL
         47Iw==
X-Forwarded-Encrypted: i=1; AJvYcCU0ANftTBBx1ThgjY6tbzPv9+XFyLZEyNbftJohNwc4opjgDUWiqa6PwOtQ0MnCXKvZJMIhIBpI8ljKU1/Ya3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKCfFjmOQW/96tq9gyVnObzMJIm6driOKVdq4e0Aka1Em+Otnv
	5i7XLk+iQoyiQuFIDMlGubYiGWVaTKShiws9yIni6sqHwps3eitX33prcZKI+9rs+XTLNehI71Y
	GuIWzU/oFamBHmnyfe8LkMnbBGR60QD8Z3j2rqgny
X-Gm-Gg: ASbGncsJSbtKQY1y8Y9iMndxrigGONd0lvBttD9D6fqEIUCTRYWx6LS5g2uuf7eZCmg
	oZMxn2obEfzoDtxHISU0Tdk00PmXsk7ZMdYBUjuHBwSs5ZCqs/zXlf6Xvudwl4zpfEkBBXOyblz
	lsoiwgsExNoSv4oqUPRc/n7U4wX+9gOMfRtZcPplLN88TVQOYUUD2VB8DhT3estzbh/BL5YF6Hf
	5An5ZWVnz8VXuq7F7ZJm6v8J+UR6uCZZJlxlTp7kiBhOfHvwLRTg9dvU7SSyvMNUWP/rQk=
X-Google-Smtp-Source: AGHT+IFnL59KMQOmHhDnr7StsLJBnGLpWS8+HKPSaf+PGPTng/MnXyN3J3hLa7MWF1XMOBaYdatCX/yrEEtPHOOkEjI=
X-Received: by 2002:a05:6102:38cc:b0:5db:3935:1636 with SMTP id
 ada2fe7eead31-5dbb12ee641mr1575830137.26.1761946901748; Fri, 31 Oct 2025
 14:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251018000713.677779-1-vipinsh@google.com> <20251018000713.677779-7-vipinsh@google.com>
 <20251027134430.00007e46@linux.microsoft.com> <aQPwSltoH7rRsnV9@google.com> <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
In-Reply-To: <CA+CK2bD-E0HKsuE0SPpZqEoJyEK4=KJCBw-h1WFP7O1KEoKuNQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 31 Oct 2025 14:41:13 -0700
X-Gm-Features: AWmQ_bktJi7f0hZJNBg0hayd2_71DzRkKbUhfBoiRXCBpPspKaQtLxcKUO1Amvo
Message-ID: <CALzav=dd3eAgqiWM-MKhu77xq0iWRMrESkDaT9KgzNgSvcjeVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 06/21] vfio/pci: Accept live update preservation
 request for VFIO cdev
To: Pasha Tatashin <pasha.tatashin@soleen.com>
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

On Thu, Oct 30, 2025 at 5:19=E2=80=AFPM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
> On Thu, Oct 30, 2025 at 7:10=E2=80=AFPM David Matlack <dmatlack@google.co=
m> wrote:
> > On 2025-10-27 01:44 PM, Jacob Pan wrote:
> > > On Fri, 17 Oct 2025 17:06:58 -0700 Vipin Sharma <vipinsh@google.com> =
wrote:
> > > > +   guard(mutex)(&device->dev_set->lock);
> > > > +   return vfio_device_cdev_opened(device);
> > >
> > > IIUC, vfio_device_cdev_opened(device) will only return true after
> > > vfio_df_ioctl_bind_iommufd(). Where it does:
> > >       device->cdev_opened =3D true;
> > >
> > > Does this imply that devices not bound to an iommufd cannot be
> > > preserved?
> >
> > Event if being bound to an iommufd is required, it seems wrong to check
> > it in can_preserve(), as the device can just be unbound from the iommuf=
d
> > before preserve().
> >
> > I think can_preserve() just needs to check if this is a VFIO cdev file,
> > i.e. vfio_device_from_file() returns non-NULL.
>
> +1, can_preserve() must be fast, as it might be called on every single
> FD that is being preserved, to check if type is correct.
> So, simply check if "struct file" is cdev via ops check perhaps via
> and thats it. It should be a very simple operation

Small correction, vfio_device_from_file() checks if file->fops are
&vfio_device_fops. But device files acquired via group FDs use the
same ops. So I think we actually need to check "device &&
!device->group" here to identify VFIO cdev files, and then check
device->ops =3D=3D &vfio_pci_ops to make sure this is a vfio-pci device.

