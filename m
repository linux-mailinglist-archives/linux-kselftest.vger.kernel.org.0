Return-Path: <linux-kselftest+bounces-46830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C90C986F5
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 18:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96CF94E3070
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 17:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5C03358CD;
	Mon,  1 Dec 2025 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnoZzKPj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EA3191D3
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Dec 2025 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609049; cv=none; b=hJab++P/KSXO0j3aOdu4V2BCkNKikfHZWF1AEBozZqiE34xZj1QMjuJkuM8WZf9yCP233WhQo1l/T6NNKAykDEHTqjiz+BE1k5s2NFvGc36EsVQwrvJ/ac4zx701HKi3+U6DI40e7g/tBSD5nexfh2mlpOdAEV6wZC2Cm3wJp4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609049; c=relaxed/simple;
	bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa7Migdnm/R9xmCNTwP+5n2O2uN6cskc2F24Qc3CiXuy3euvsLRI5C5+5RJIHeOp4+FJ2VwoMEn4gnlqFrTRmZCmrS5Tmn3xPg6l1Et63Lkmrus/05OLdUDpcnp1xK6rFJKg1rYjXcsvueLM9yObPTJZYjooXTj0LtxeNjktlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lnoZzKPj; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5dfd2148bf2so2506604137.2
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Dec 2025 09:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764609047; x=1765213847; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
        b=lnoZzKPjOWT2YU+iQDtB3Q2aOzlOYek0jKBkXIEzY7jH0rW4vY7obrU6MAxwqyjqSA
         ZV87B+sY6ToDMnXMxf53HDyBH5qwpMHxjzsD7e643nzT9BESMfrUDWmt9v07bCunSKkn
         KoNIHBBWRHx6ZXBkvt/A5u/si5Vn7tFZksk3vMx1NZrXyJ+SAm09KRL421PP7T8apeIt
         qR9qKmiMm2k0kTofe6JUXhFZKkz06x+4I98+xmYZkiOCO+8D5uRcOk1j+giYl/RTb9jn
         vZukjvpLDiVrAqGuj5FbKGWDLS3ppuwoFSN3DC2oxn67Fa+DkJ+6+MlbZWDoMESGvwKg
         ByNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764609047; x=1765213847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=opo4qLlgw2cd/qjtmYKz2q5Ux6G/Ok85dlUrX0eizA8=;
        b=YPdBvIkSqyBiHsns2jpd4h/uStSzExMAR3nj9Vc4iMVSRlqQmgJp2UPnboW/9MRaYb
         J1q+xnyE/r2KY/OQZBjwfk7+NHJifs5uzLcx8OrOCU7ItcidkXWB6KyUzyjjs2J0siOU
         UYTJjV1efSEKGNmYnxu5HZSEUB8P8lzfA417qmW+4pioJLbA95dXP1qEr738f7gZQmrz
         nfJ3GGqLrZh89LjWaI2TdqoaYP31dKJstGYgqUdNgEXMgMjEBcK5vUQzQJOnBGTugb4F
         2apcKDkUWJCsXPct3f4o797IaHCCR4YHTA8Li0p6Aidu3RvB3rePm+RbBXlRjN/cCi58
         +Omw==
X-Forwarded-Encrypted: i=1; AJvYcCXv28obmv7PtjGXqXnUYu2dYMMBiPZQORvNJ0jmle5VJYVw7AR8dsxEVGqPcwSH/Y6L9kZdWCTwtkX65iR6pC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzylRtpyh75r/LQm0we1gJieDMYcGlj5VOezd3u1XzT7L+aq8nl
	3cjRL7YM8nDJNwLzyRCUoA6MJbn4lIrUHPWbkUgPXqd/JrG1b6WuhlH7kGDPiidR8wRmgAE+C5b
	LdEZvp1Z5BxM7WmjGXYCO8Eq63W1tM7D8qW0qJ8c5
X-Gm-Gg: ASbGncsooBm5yZfkzwGOVwP0e3LhUKNYAgvqW0r5kUkX8vAAdTAe4WJUVAQ/UNnDhOa
	8Lw88mUitwOM3Sd8M+3yEW+FEGHfFNkoBKbtiqs2WakPV9lQNMi53GUuUUarwVGcHzPr4cRZmkY
	bHVntqIbf680ZEzlaSUG7XHFf0ZBDpcDL8vPgWyyJ3J2HySNVAFebXngftW65p055zuBc1CpiXG
	nTnQw3bYMyRblzk5rRrbKbQRGZdV2HevFN0jUZloXX70gQ9Hgioua3lcamQt44PmZzYZzRq
X-Google-Smtp-Source: AGHT+IGFiOVRHpVtJg9de3U4NUDUwYt8a2SWwlK1RQVEQJYikxaSGrWA23uPIDLSWQ7bG1vfGanH0O9/XxW9Q0wDVag=
X-Received: by 2002:a05:6102:50a3:b0:5dd:b2a1:e9a5 with SMTP id
 ada2fe7eead31-5e22424060amr10237999137.5.1764609044530; Mon, 01 Dec 2025
 09:10:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <dadaeeb9-4008-4450-8b61-e147a2af38b2@linux.dev>
 <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
In-Reply-To: <46bbdad1-486d-4cb1-915f-577b00de827f@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 1 Dec 2025 09:10:14 -0800
X-Gm-Features: AWmQ_bmDimn0Dqk7l1xtbjMVwD_y8nzSoh4S7ZJEc0qhkhUQGkqBsopla8gxr6s
Message-ID: <CALzav=eigAYdw5-hzk1MAHWBU29yJK4_WWTd0dyoBN91bnRoZQ@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alex Mastro <amastro@fb.com>, Alistair Popple <apopple@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Chris Li <chrisl@kernel.org>, David Rientjes <rientjes@google.com>, 
	Jacob Pan <jacob.pan@linux.microsoft.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, 
	kvm@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Philipp Stanner <pstanner@redhat.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 7:49=E2=80=AFAM Zhu Yanjun <yanjun.zhu@linux.dev> wr=
ote:
> =E5=9C=A8 2025/11/27 20:56, Zhu Yanjun =E5=86=99=E9=81=93:
> > Hi, David
> >
> > ERROR: modpost: "liveupdate_register_file_handler" [drivers/vfio/pci/
> > vfio-pci-core.ko] undefined!
> >
> > ERROR: modpost: "vfio_pci_ops" [drivers/vfio/pci/vfio-pci-core.ko]
> > undefined!
> > ERROR: modpost: "liveupdate_enabled" [drivers/vfio/pci/vfio-pci-core.ko=
]
> > undefined!
> > ERROR: modpost: "liveupdate_unregister_file_handler" [drivers/vfio/pci/
> > vfio-pci-core.ko] undefined!
> > ERROR: modpost: "vfio_device_fops" [drivers/vfio/pci/vfio-pci-core.ko]
> > undefined!
> > ERROR: modpost: "vfio_pci_is_intel_display" [drivers/vfio/pci/vfio-pci-
> > core.ko] undefined!
> > ERROR: modpost: "vfio_pci_liveupdate_init" [drivers/vfio/pci/vfio-
> > pci.ko] undefined!
> > ERROR: modpost: "vfio_pci_liveupdate_cleanup" [drivers/vfio/pci/vfio-
> > pci.ko] undefined!
> > make[4]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[3]: *** [Makefile:1960: modpost] Error 2
> >
> > After I git clone the source code from the link https://github.com/
> > dmatlack/linux/tree/liveupdate/vfio/cdev/v1,
> >
> > I found the above errors when I built the source code.
> >
> > Perhaps the above errors can be solved by EXPORT_SYMBOL.
> >
> > But I am not sure if a better solution can solve the above problems or =
not.
>
> I reviewed this patch series in detail. If I=E2=80=99m understanding it
> correctly, there appears to be a cyclic dependency issue. Specifically,
> some functions in kernel module A depend on kernel module B, while at
> the same time certain functions in module B depend on module A.
>
> I=E2=80=99m not entirely sure whether this constitutes a real problem or =
if it=E2=80=99s
> intentional design.

Thanks for your report. Can you share the .config file you used to
generate these errors?

