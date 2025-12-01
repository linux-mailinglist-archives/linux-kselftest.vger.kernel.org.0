Return-Path: <linux-kselftest+bounces-46834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 92360C98937
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751994E1893
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B753C338593;
	Mon,  1 Dec 2025 17:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XANyEFlY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4830C336EF2
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611116; cv=none; b=SxaPPLY0ei8YOJ4ZzSPC1atLmhXqcrei3bqM22XKUaViukQXv6bgSLv0KOi/vup8Lk1F71fuV8qm2OYKMZlysYmcrzazr08LJ4xfgeas8usrHRgW3aL6oaLD/C8oUVgYqhBhrxkUKPnTDW/ZVD+YGYcCp7UKsuzDxAHaOzHnc1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611116; c=relaxed/simple;
	bh=2oFoS00h8Jyangue980FS+6uIoC6XuRRZCT7gXnnnQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFN/MGp//4/bKoiCAviVgNCN2ToY22ydUshxYS/ZBcNgF6G5ai0qaXjqbaqChnc2zY+Gruh0QxGHiNcovkij+m9DIKWll3P8AmSb9HRpLQ7DuZSDCrvwoB3cu9BJrg9ySWUs2+EyzDp7BeJH1stnguPT+CQA49Lzr7Xstb2WSEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=XANyEFlY; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6419aaced59so6811561a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 09:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764611112; x=1765215912; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifw2XWNardwHWp440aHEx/NX6Kvr0n1g+7KK1qjZEiE=;
        b=XANyEFlYXhYxhx+3VxRH49VHjTq8+Ccrq7BD+Ihw4nYrOZZxcTHbKujKbbXDps/aJV
         42nIthJgTNxrItmp6Y3cUi7d7LQaD58zRpdaLJ+J5lzhMaDWEFgKeb4mDzf01hbSZYo4
         cUhAYdbcb04Y2WDAiw8Zx7msu/7ytJLMs77VicjDrx3DZl1tpbKzz6nel44grhlCBnYI
         SbkPM1zNEG9szxNVe0NeSKH3+3aWkyPhWb+PV9NoiRJbtS5we1M5wvifKEnuFoiEaTSN
         VaHCtRECHgpylneV4/JCijYsjaRUjDtEr8dnbcKdNQHtt8r4AuB99953j0+TbjvPm/bL
         k0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611112; x=1765215912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifw2XWNardwHWp440aHEx/NX6Kvr0n1g+7KK1qjZEiE=;
        b=NOKvGnjuah6hJVu559VQVV/lR9Ob7RuXqLruP1QZ7Pfxd5sxn20fvYvH4FfyVZ34ze
         CIYJeeb+J1MJHHyd5KWO8S2Ep6TVqN50+gQiDkZmU5h0p4HY156vKtW0u4YFOHHpeNDQ
         l8Gng5G4LMJJM1o7sR682I4lf/3dxRYgAz7s1YL2SBqIZbDV8BDMPRpZNxEJ+9qWoLLm
         cTMhLj36VQ7pRwhbfogUWKNL2ZRD901zP5p6akIuqmm7L5DDT8ApXyFTCiRzg4j+ZdRw
         I5j1tCTkSUEVNNiCw5KiAM/TB2sguDAv0yCOf/d5AHm7ZM+XVf4Kh0FOI419iChyzNYl
         0CNg==
X-Forwarded-Encrypted: i=1; AJvYcCWwB8Upezg7q4sMLzrFQMd8xjRi1Ws9P4YHAbPSGfSKDc73SZK09jynTRddGPXcHqHvy4oDAEjrJHjyw31PY0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcyOf2tkVWAD3hJ66y3WKZn4XW6vmwobXYgKDxd0wMedV+ddXk
	bJGP12sXRFME1djVV9E1DcMJRJBb5HLEx1erPp55mHh/P7AwNO9QoTifZUvPTxTBnPqK+TZLn4Q
	DOpj9Lb934ytNHwU+SLL10vIl3s0bCkcq9rW6yGrsiQ==
X-Gm-Gg: ASbGncuXNzlZIP2bbQgr3o0FshnoVzIYTCznEA6pdN6xNtKx68PjhCyyS0wSYt05qbx
	lDO45QnN3cxlN/lOrHtAFTzWJli0aQEabkeRM4JwEIbFlE4jtiB4YdVQTrhQAaiduSCg5TWBLC0
	rAJ78v0xvMBi+GSRnjgXKsA984onhikk+cn0Gx1UHNf5Jhgze64d8DksgyLpT9seqGeGgb7AivD
	MWF5r20HspUkANlxLGWSsQH81MhBUzTAeI+KDQEMNvXf7nI9fVzxEyrM1yRj/YNe960
X-Google-Smtp-Source: AGHT+IEBT6fkdYoVQqThFKacqEPzVXrve/Dt1KzduNhsJrTPLwP7M8SBcqZ56v8B1varTLh2pMvp4jShL7wytvAHgYE=
X-Received: by 2002:a05:6402:1e8a:b0:63c:690d:6a46 with SMTP id
 4fb4d7f45d1cf-6455445989cmr36452673a12.13.1764611112295; Mon, 01 Dec 2025
 09:45:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev> <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
 <4998497c-87e8-4849-8442-b7281c627884@linux.dev> <aS3RF6ROa7uZsviv@google.com>
 <aS3SJxAjVT-ZH1YT@google.com>
In-Reply-To: <aS3SJxAjVT-ZH1YT@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 1 Dec 2025 12:44:36 -0500
X-Gm-Features: AWmQ_bmraf7kuluuI8Gcr38abAy-KAqYDXvYrRjXR0Zi-LcjegjZel4DYVYojA4
Message-ID: <CA+CK2bDQh6jG53mbksYW7WjukSKy6egCfKs8+mmAcNKSQ9m4mQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: David Matlack <dmatlack@google.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Alex Williamson <alex@shazbot.org>, 
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

On Mon, Dec 1, 2025 at 12:36=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2025-12-01 05:32 PM, David Matlack wrote:
> > On 2025-12-01 09:16 AM, Zhu Yanjun wrote:
> > >
> > > =E5=9C=A8 2025/12/1 9:10, David Matlack =E5=86=99=E9=81=93:
> > > > On Mon, Dec 1, 2025 at 7:49=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux=
.dev> wrote:
> > > > > =E5=9C=A8 2025/11/27 20:56, Zhu Yanjun =E5=86=99=E9=81=93:
> > > > > > Hi, David
> > > > > >
> > > > > > ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfi=
o/pci/
> > > > > > vfio-pci-core.ko] undefined!
> > > > > >
> > > > > > ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.=
ko]
> > > > > > undefined!
> > > > > > ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci=
-core.ko]
> > > > > > undefined!
> > > > > > ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/v=
fio/pci/
> > > > > > vfio-pci-core.ko] undefined!
> > > > > > ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-c=
ore.ko]
> > > > > > undefined!
> > > > > > ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/v=
fio-pci-
> > > > > > core.ko] undefined!
> > > > > > ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vf=
io-
> > > > > > pci.ko] undefined!
> > > > > > ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci=
/vfio-
> > > > > > pci.ko] undefined!
> > > > > > make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Err=
or 1
> > > > > > make[3]: *** [Makefile:1960: modpost] Error 2
> > > > > >
> > > > > > After I git clone the source code from the link https://github.=
com/
> > > > > > dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> > > > > >
> > > > > > I found the above errors when I built the source code.
> > > > > >
> > > > > > Perhaps the above errors can be solved by EXPORT_SYMBOL.
> > > > > >
> > > > > > But I am not sure if a better solution can solve the above prob=
lems or not.
> > > > > I reviewed this patch series in detail. If I=E2=80=99m understand=
ing it
> > > > > correctly, there appears to be a cyclic dependency issue. Specifi=
cally,
> > > > > some functions in kernel module A depend on kernel module B, whil=
e at
> > > > > the same time certain functions in module B depend on module A.
> > > > >
> > > > > I=E2=80=99m not entirely sure whether this constitutes a real pro=
blem or if it=E2=80=99s
> > > > > intentional design.
> > > > Thanks for your report. Can you share the .config file you used to
> > > > generate these errors?
> > >
> > >
> > > IIRC, I used FC 42 default config. Perhaps you can make tests with it=
. If
> > > this problem can not be reproduced, I will share my config with you.
> > >
> >
> > What does "FC 42 default config" mean?
> >
> > Either way I was able to reproduce the errors you posted above by
> > changing CONFIG_VFIO_PCI{_CORE} from "y" to "m".
> >
> > To unblock building and testing this series you can change these config=
s
> > from "m" to "y", or the following patch (which fixed things for me):
>
> Oops, sorry, something went wrong when I posted that diff. Here's the
> correct diff:
>
> diff --git a/drivers/vfio/pci/Makefile b/drivers/vfio/pci/Makefile
> index 929df22c079b..c2cca16e99a8 100644
> --- a/drivers/vfio/pci/Makefile
> +++ b/drivers/vfio/pci/Makefile
> @@ -2,11 +2,11 @@
>
>  vfio-pci-core-y :=3D vfio_pci_core.o vfio_pci_intrs.o vfio_pci_rdwr.o vf=
io_pci_config.o
>  vfio-pci-core-$(CONFIG_VFIO_PCI_ZDEV_KVM) +=3D vfio_pci_zdev.o
> -vfio-pci-core-$(CONFIG_LIVEUPDATE) +=3D vfio_pci_liveupdate.o
>  obj-$(CONFIG_VFIO_PCI_CORE) +=3D vfio-pci-core.o
>
>  vfio-pci-y :=3D vfio_pci.o
>  vfio-pci-$(CONFIG_VFIO_PCI_IGD) +=3D vfio_pci_igd.o
> +vfio-pci-$(CONFIG_LIVEUPDATE) +=3D vfio_pci_liveupdate.o
>  obj-$(CONFIG_VFIO_PCI) +=3D vfio-pci.o
>
>  obj-$(CONFIG_MLX5_VFIO_PCI)           +=3D mlx5/
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index c5b5eb509474..b9805861763a 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1386,6 +1386,7 @@ const struct file_operations vfio_device_fops =3D {
>         .show_fdinfo    =3D vfio_device_show_fdinfo,
>  #endif
>  };
> +EXPORT_SYMBOL_GPL(vfio_device_fops);
>
>  /**
>   * vfio_file_is_valid - True if the file is valid vfio file
> diff --git a/kernel/liveupdate/luo_core.c b/kernel/liveupdate/luo_core.c
> index 69298d82f404..c7a0c9c3b6a8 100644
> --- a/kernel/liveupdate/luo_core.c
> +++ b/kernel/liveupdate/luo_core.c
> @@ -256,6 +256,7 @@ bool liveupdate_enabled(void)
>  {
>         return luo_global.enabled;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_enabled);
>
>  /**
>   * DOC: LUO ioctl Interface
> diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_file.c
> index fca3806dae28..9baa88966f04 100644
> --- a/kernel/liveupdate/luo_file.c
> +++ b/kernel/liveupdate/luo_file.c
> @@ -868,6 +868,7 @@ int liveupdate_register_file_handler(struct liveupdat=
e_file_handler *fh)
>         luo_session_resume();
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_register_file_handler);
>
>  /**
>   * liveupdate_unregister_file_handler - Unregister a liveupdate file han=
dler
> @@ -913,3 +914,4 @@ int liveupdate_unregister_file_handler(struct liveupd=
ate_file_handler *fh)
>         liveupdate_test_register(fh);
>         return err;
>  }
> +EXPORT_SYMBOL_GPL(liveupdate_unregister_file_handler);

Please add the EXPORT_SYMBOL_GPL() to the public LUO API as needed, I
was asked to stay conservative and not export until it is actually
needed by modules.

