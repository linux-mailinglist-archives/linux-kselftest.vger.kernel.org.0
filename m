Return-Path: <linux-kselftest+bounces-46855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6DC99407
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 22:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A153A2313
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9C62773EE;
	Mon,  1 Dec 2025 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xA0UhSNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE321420B
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764625769; cv=none; b=EaOpKJp6WTOeW7vFfWby2Jmr9iVZeqWTryzLzN+3ZK8/7UT5ZwW+SSJwqGo5tD9YLZvPZBNzOD7yzWiFLiXGkgk2AJUmjeiVcYRrEQJ1kwXWVjXQhv3y0AWLp2DvJzOUostG40XKz6AA8I2wpw9+IbqlZEKRw9UL39M+rFP5AMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764625769; c=relaxed/simple;
	bh=I79LLbzwvzzuby7VBAf1qPZp81xUw/2eARy4myVH+Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyuZ/UUhe2Ig/FTvQ/JbGSMmLbJdetp/4IdwNnSQu6DXC8m7PQ32J9nD6QcyQwCxsJ9L9SwRyZCJDSm32KSUF//b/Ak2177N7Vv1GDBwdqswbWDp9Z2+ZifjwU0iRJLntFS7w4dbA86HCKYpliB+lKg1vlvlYjATgAVmbj3NK6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xA0UhSNP; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-595825c8eb3so4435373e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 13:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764625766; x=1765230566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fIDoyTY/2QHZAsWX2JGHHy8SWM8tRoN5++vfi6/smHM=;
        b=xA0UhSNP6+3TNmO/f73FpW9KbRZQMJ6aefOiTABTE4QEChDyi0vSHWtLCdkhkfxFOW
         2FqgGEZeB+rsh5f2kKrZ4ysmwwwHm24ABJNvC/sPg9xM15zK9QXvQqTRbOzlU3rk4HrQ
         kI6Wq04srOr2fqqr4eHkCcnZwSXnKJWKpTDSXXRK9O27ji0KEwOO9p+5A/QwRtqBNa86
         sgLAQWaAdyEsLBcks+4CtYUCIWyUy9M24321gpoMLRQQOcZ1eutU8zbXwLMbqAC9/A66
         s/GPpafzuENoxGd3XzUm2atPJGCDqdJ+jqRTYJPJG9TgT/25Mti1tbKh5CMhlKwpvwIq
         ddpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764625766; x=1765230566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fIDoyTY/2QHZAsWX2JGHHy8SWM8tRoN5++vfi6/smHM=;
        b=lXiwGMm3/efplNrBpZxLpropRHt06EoTD81hQouLwliDFBDHlcLWKd/0VxxVbYlUmw
         tY1Dwy+N5ok12FHBlLKxmfjDCOMgEsNBL/AE1GevlR8BOoWYw/tt5FTGQSYtrek++kMs
         bs5DmlW/P3gDfHXNINKXtkb3/BvpZSBk8Su6G5OHtaTcr8bB5rgoSUCKFA8YJOtMjIU1
         iulkn4KkeEduMs1axrxsjfElp9f9x9uvyxgGueUSQqTjgVKwxyxIZaovJKM8NaiamuOG
         5hOglsnQSzNVu+RQhQ2Zzs9NOgSdlhc+v7FEsU8jsz3X90yRYP4s0j7jxgenktDMNEsv
         DXTw==
X-Forwarded-Encrypted: i=1; AJvYcCVaG0Rxic8Loc4u3leKkb+INvMq0RsNQWdouSGOAwdSprKHQeVR0uIxjOFCL2ch4tFhsKuJDIFuBLY2cKFiVBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/78aRq7rYBfksF2bIsqU8nMXYTzkOCm2du1ysVDzj2DwpFEL
	Ugz0PqYmcq9PYF2886jem8W1Wm/LLRjz+OfxCraMX+ZUb90GL1mZXzTQ6rYAhuN9Sc0W2GfS9l/
	fuz/DUqNe7jdvc+9y1O4R7x/dQT8QzgCYewLArMM+
X-Gm-Gg: ASbGncuNB5pWmSThaaRmBdIR6k57sz/crm+zOHRwWZTAHQTYRqPeCz5rlNVuTTfXQpM
	NxYkGGR1TFPuJGUuh5z+CVHHZXyVA4O5A/RE8Zvj8w9cA10F/UJsqk8XIQnjk0nzdJbpYaurtNs
	HCFCrXjskx4uN59NuxJWbiXIcawq4sRdg1Ez9jiSbUDFjZ8PDFkWQwG73UKZOClrhUw2OUIulRT
	1cJ8aTR8DjdJ91+nyhnK8qYGC85U4CjQiskZehw2vpoilHAVlycQbFvMZ19AEd0RPNrpfHa
X-Google-Smtp-Source: AGHT+IFsd005OV4yF2rkZa0WY1vICfOifJ1KM2CMs6i6kJWm0llwxrVAWf5qS+028cp4uyvLXTADFkJ9f/Io9w8GqSQ=
X-Received: by 2002:a05:6512:308a:b0:592:f818:9bde with SMTP id
 2adb3069b0e04-596b50598aamr9977563e87.1.1764625765366; Mon, 01 Dec 2025
 13:49:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev> <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
 <4998497c-87e8-4849-8442-b7281c627884@linux.dev> <aS3RF6ROa7uZsviv@google.com>
 <aS3SJxAjVT-ZH1YT@google.com> <CA+CK2bDQh6jG53mbksYW7WjukSKy6egCfKs8+mmAcNKSQ9m4mQ@mail.gmail.com>
 <3aa3a726-147d-4573-ae50-eef94a910640@linux.dev>
In-Reply-To: <3aa3a726-147d-4573-ae50-eef94a910640@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 1 Dec 2025 13:48:58 -0800
X-Gm-Features: AWmQ_bnPKYO28T4Dbl6mgYeVA8ryDMTfa2QGDsG39sxo9pG92ND0f6BbC-VSkEs
Message-ID: <CALzav=fCjZnU5jqHTwFziAcssUys+XqWX1GkM7_PGufBnVyPmQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 1:46=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
>
>
> On 12/1/25 9:44 AM, Pasha Tatashin wrote:
> > On Mon, Dec 1, 2025 at 12:36=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> >> On 2025-12-01 05:32 PM, David Matlack wrote:
> >>> On 2025-12-01 09:16 AM, Zhu Yanjun wrote:
> >>>> =E5=9C=A8 2025/12/1 9:10, David Matlack =E5=86=99=E9=81=93:
> >>>>> On Mon, Dec 1, 2025 at 7:49=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux=
.dev> wrote:
> >>>>>> =E5=9C=A8 2025/11/27 20:56, Zhu Yanjun =E5=86=99=E9=81=93:
> >>>>>>> Hi, David
> >>>>>>>
> >>>>>>> ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/=
pci/
> >>>>>>> vfio-pci-core.ko] undefined!
> >>>>>>>
> >>>>>>> ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko=
]
> >>>>>>> undefined!
> >>>>>>> ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-c=
ore.ko]
> >>>>>>> undefined!
> >>>>>>> ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfi=
o/pci/
> >>>>>>> vfio-pci-core.ko] undefined!
> >>>>>>> ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-cor=
e.ko]
> >>>>>>> undefined!
> >>>>>>> ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfi=
o-pci-
> >>>>>>> core.ko] undefined!
> >>>>>>> ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio=
-
> >>>>>>> pci.ko] undefined!
> >>>>>>> ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/v=
fio-
> >>>>>>> pci.ko] undefined!
> >>>>>>> make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error=
 1
> >>>>>>> make[3]: *** [Makefile:1960: modpost] Error 2
> >>>>>>>
> >>>>>>> After I git clone the source code from the link https://github.co=
m/
> >>>>>>> dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> >>>>>>>
> >>>>>>> I found the above errors when I built the source code.
> >>>>>>>
> >>>>>>> Perhaps the above errors can be solved by EXPORT_SYMBOL.
> >>>>>>>
> >>>>>>> But I am not sure if a better solution can solve the above proble=
ms or not.
> >>>>>> I reviewed this patch series in detail. If I=E2=80=99m understandi=
ng it
> >>>>>> correctly, there appears to be a cyclic dependency issue. Specific=
ally,
> >>>>>> some functions in kernel module A depend on kernel module B, while=
 at
> >>>>>> the same time certain functions in module B depend on module A.
> >>>>>>
> >>>>>> I=E2=80=99m not entirely sure whether this constitutes a real prob=
lem or if it=E2=80=99s
> >>>>>> intentional design.
> >>>>> Thanks for your report. Can you share the .config file you used to
> >>>>> generate these errors?
> >>>>
> >>>> IIRC, I used FC 42 default config. Perhaps you can make tests with i=
t. If
> >>>> this problem can not be reproduced, I will share my config with you.
> >>>>
> >>> What does "FC 42 default config" mean?
> >>>
> >>> Either way I was able to reproduce the errors you posted above by
> >>> changing CONFIG_VFIO_PCI{_CORE} from "y" to "m".
> >>>
> >>> To unblock building and testing this series you can change these conf=
igs
> >>> from "m" to "y", or the following patch (which fixed things for me):
> >> Oops, sorry, something went wrong when I posted that diff. Here's the
> >> correct diff:
> >>
> >> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> >> index 929df22c079b..c2cca16e99a8 100644
> >> --- a/drivers/vfio/pci/Makefile
> >> +++ b/drivers/vfio/pci/Makefile
> >> @@ -2,11 +2,11 @@
> >>
> >>   vfio-pci-core-y :=3D vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.=
o vfio_pci_config.o
> >>   vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) +=3D vfio_pci_zdev.o
> >> -vfio-pci-core-$(CONFIG_LIVEUPDATE) +=3D vfio_pci_liveupdate.o
> >>   obj-$(CONFIG_VFIO_PCI_CORE) +=3D vfio-pci-core.o
> >>
> >>   vfio-pci-y :=3D vfio_pci.o
> >>   vfio-pci-$(CONFIG_VFIO_PCI_IGD) +=3D vfio_pci_igd.o
> >> +vfio-pci-$(CONFIG_LIVEUPDATE) +=3D vfio_pci_liveupdate.o
> >>   obj-$(CONFIG_VFIO_PCI) +=3D vfio-pci.o
> >>
> >>   obj-$(CONFIG_MLX5_VFIO_PCI)           +=3D mlx5/
> >> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> >> index c5b5eb509474..b9805861763a 100644
> >> --- a/drivers/vfio/vfio_main.c
> >> +++ b/drivers/vfio/vfio_main.c
> >> @@ -1386,6 +1386,7 @@ const struct file_operations vfio_device_fops =
=3D {
> >>          .show_fdinfo    =3D vfio_device_show_fdinfo,
> >>   #endif
> >>   };
> >> +EXPORT_SYMBOL_GPL(vfio_device_fops);
> >>
> >>   /**
> >>    * vfio_file_is_valid - True if the file is valid vfio file
> >> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core=
.c
> >> index 69298d82f404..c7a0c9c3b6a8 100644
> >> --- a/kernel/liveupdate/luo_core.c
> >> +++ b/kernel/liveupdate/luo_core.c
> >> @@ -256,6 +256,7 @@ bool liveupdate_enabled(void)
> >>   {
> >>          return luo_global.enabled;
> >>   }
> >> +EXPORT_SYMBOL_GPL(liveupdate_enabled);
> >>
> >>   /**
> >>    * DOC: LUO ioctl Interface
> >> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file=
.c
> >> index fca3806dae28..9baa88966f04 100644
> >> --- a/kernel/liveupdate/luo_file.c
> >> +++ b/kernel/liveupdate/luo_file.c
> >> @@ -868,6 +868,7 @@ int liveupdate_register_file_handler(struct liveup=
date_file_handler *fh)
> >>          luo_session_resume();
> >>          return err;
> >>   }
> >> +EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
> >>
> >>   /**
> >>    * liveupdate_unregister_file_handler - Unregister a liveupdate file=
 handler
> >> @@ -913,3 +914,4 @@ int liveupdate_unregister_file_handler(struct live=
update_file_handler *fh)
> >>          liveupdate_test_register(fh);
> >>          return err;
> >>   }
> >> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);
>
>
> Sure. Exactly. The above is the same with my solution. But after that
> EXPORT_SYMBOL_GPL, a cyclic dependency issue will occur.

Did see the change to drivers/vfio/pci/Makefile? That fixes the
circular dependency between vfio-pci and vfio-pci-core that I created
in this series.

