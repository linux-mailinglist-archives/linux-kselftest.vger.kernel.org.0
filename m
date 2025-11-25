Return-Path: <linux-kselftest+bounces-46456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 58893C863E7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 18:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 422A34EA5B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Nov 2025 17:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F32E18FDBE;
	Tue, 25 Nov 2025 17:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvWH/Y6a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7035F32A3E1
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092267; cv=none; b=NeC2pIKbhRHiaPvyJ9muDs8B+ULfzaJgMd6U7z3DsMQTXiPyj4YOqOAJz63qwq64iNhOoCfo4IlNyszjveB8o0/xFs0sRDItZVJRQ3RhONZNUqXdXiF78znBS+aCXm1mj0JRMDkEirX5tfR5IHgtGSbLEtprK+kw8ADLTzzJvDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092267; c=relaxed/simple;
	bh=Ejku2oAgTG0MLuTVF5tg29vzUgVV+nOFGngep+HFdYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lkKL1CWzCgF406jgarQovIsgtjkmo9w9z6NLU33zyRAysYrQaGLrGpJ/fsqKuLy5bh2ZH9y2VtGABxpiEo2BGBArq5WkboLdNbdkXnZM/vTf1o+1ijXHSXdRKyFusmx2XOWuPVVNaBxqwOxLmRNAU1vsP/tb1PXHl++I7tBGznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvWH/Y6a; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5959da48139so6195759e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Nov 2025 09:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764092264; x=1764697064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okuVuEMd31Qt38di8puew2SNgGFFbYVoFM6SMy0UZTM=;
        b=mvWH/Y6a0gOX72i6jbzraxSdj+3VNfQ3NTamm8f38en5UJzj3HO74sPtezSQPCyYY8
         eddkgtKG2BGrE2tOcrznnH8jUlQvClIjuB5I3xR+r+Hn9+ei1pUe8bl5rTzS18ZQZG+D
         zXjfoaRLkMq0QfjFdS8YOS5dTJA0tC0K5fc38nWDOzafYEKcK1BkaVAhvocVzqfjxfaN
         CXssgDARPE82kPMBkl76AZWSQnz387BsvSC6E9FG2w7wn4RpUVrkxZakntsagcMNSWuC
         EF5YTI3pvOqAUikxBpBVuI42k7HF26gwVvg7jMQPyr/+YQRNsdW1ORAMNCQ87t7TM5lo
         Yz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764092264; x=1764697064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=okuVuEMd31Qt38di8puew2SNgGFFbYVoFM6SMy0UZTM=;
        b=nrjFeoDfMBSmdhGS1Br7nQlhK5poBPkElhLsBuLQI3x6mMiSgKZzFFHtdxIEeAeTx2
         r+FtiIJT3D6JQ/HXhIuOmXrR1ROR0nss65RyTAqZMM3iG97WMWh1ywAI4LOcaKqRjpZk
         JkznbqaZeqD2llG+AUieiVKF254+D3F0kvIa3UmbgrROfFDXwLzfcHV32yjj2uoOZV59
         4lkxNxQuq9qYEc8DtLEJFYXKyaBKIIpEn+rTxVeZauEEBqHuWITErugVP4l5yUKvamIl
         i8RepUluyNAfygi4Q/qdBsc1XKAadXDYt2f4N6rmZT2F9OQ9Os0JdnYC37swfT6bahy0
         w98w==
X-Forwarded-Encrypted: i=1; AJvYcCWrJL8gslZUU9RFu2lSkRgl2kD6lFlDpiQpDLitEKvNx7w3uQd3nAWA6k/YkhFpT3VvIdqi8b8rgNF2Hl46AC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyb8atMlcexCDNFU0YVJxuG7C1bFce8WjigX+Oa4uSwEkV8Yob
	2t8mO/9jfjxHfkEMxrQvQcGI09c3kRYaiamXhUtwGgaI4oo6US64TaYSW/dFiz+DZe8sInc+dxJ
	WV0NiOLvg71017Da7tmJNbAxnc3YIruzPTpFssDu4
X-Gm-Gg: ASbGncuuUoE/u+PHvTXbUqpvofekGqCJlo6P3dqMsDPkI9DC6+LqVC808QqtrGURLV7
	ovccdONKxBsUUa2P0MxJlMiVs2KQ4Vrr+FVRWYtztZ697jaGZjcXhks66arToOaw0hXrCtaLKAj
	i+VyC8mA9J1mEalbrjpI0LzXQo6dn5q0cDgBz6MRJImH1U4BACcwl50Tvxu4X7maJW6FOEQB+pA
	VxjaE+m0jDdNphU/IfEu/A979zFLsm1Z3gbAcF/69mvtbNEensb9EvjoxnThel2WWbRbDg=
X-Google-Smtp-Source: AGHT+IEvpHau791IAO0dltg1a3e0hjW7a5btTqdQz225JT89zGJmvQWbORKrFwH0dVFgXeulmu9pimYSiYV6QIzPdaM=
X-Received: by 2002:a05:6512:12c7:b0:594:cb92:b377 with SMTP id
 2adb3069b0e04-596b52909b2mr1546440e87.42.1764092263437; Tue, 25 Nov 2025
 09:37:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121181429.1421717-1-dmatlack@google.com> <20251121181429.1421717-7-dmatlack@google.com>
 <CAJHc60zW+FzOfUQzZYCStmFJ_d8Gr2mi-nN297b=gU+26mt1BQ@mail.gmail.com>
In-Reply-To: <CAJHc60zW+FzOfUQzZYCStmFJ_d8Gr2mi-nN297b=gU+26mt1BQ@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 25 Nov 2025 09:37:15 -0800
X-Gm-Features: AWmQ_blXo2R832vAXskZpPadEWRx5jQ3IoP9HQvzSngDu_3AkgqN5_Y8TmlJRuQ
Message-ID: <CALzav=fseMCyQEvBsJa+J+_V=1S3MX_7sArEksGYUQAey==70g@mail.gmail.com>
Subject: Re: [PATCH v3 06/18] vfio: selftests: Support multiple devices in the
 same container/iommufd
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 3:17=E2=80=AFAM Raghavendra Rao Ananta
<rananta@google.com> wrote:
> On Fri, Nov 21, 2025 at 11:44=E2=80=AFPM David Matlack <dmatlack@google.c=
om> wrote:
> > +struct vfio_pci_device *vfio_pci_device_init(const char *bdf, struct i=
ommu *iommu)
> >  {
> >         struct vfio_pci_device *device;
> >
> >         device =3D calloc(1, sizeof(*device));
> >         VFIO_ASSERT_NOT_NULL(device);
> >
> > -       device->iommu =3D calloc(1, sizeof(*device->iommu));
> > -       VFIO_ASSERT_NOT_NULL(device->iommu);
> > -
> > -       INIT_LIST_HEAD(&device->iommu->dma_regions);
> > -
> > -       device->iommu->mode =3D lookup_iommu_mode(iommu_mode);
> > +       device->iommu =3D iommu;
> nit: Since we now depend on the caller to follow the right order,
> should we have a VFIO_ASSERT_NOT_NULL(iommu), or something along the
> lines of 'Is iommu initialized?" before this function starts using it,
> and fail with an appropriate error message?

I think the compiler and type system largely enforce the order now.
The compiler will complain if a user passes in an uninitialized struct
iommu *. And the only way to initialize it is with iommu_init(). I
guess someone could pass in NULL, so having an explicit assert for
non-null would be easier to debug than a SIGSEGV. I'll add that in v4.

>
> >
> >         if (device->iommu->mode->container_path)
> minor nit: if there's a v4, simply use iommu->mode->container_path.

Yes, thanks, will do!

