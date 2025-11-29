Return-Path: <linux-kselftest+bounces-46735-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D93B2C947A2
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 21:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5D8B7343F99
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Nov 2025 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E162253B59;
	Sat, 29 Nov 2025 20:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="U2Balel9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156AC221F12
	for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764447072; cv=none; b=bEsNLAzszasaqozUIuedId+3MOldVaXg+ua1mKq4k8El5WgkoD/KQX2z4CEEAuEATI+EQfRen4HEHhYXdsIPgnYjewfSs5eTi65czyRNdGF6UteelSOcjJsFB3TlwpREJmQiELEJmxVoCqd+c9bJXN4KQtxCvPdSyl+ejV+gpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764447072; c=relaxed/simple;
	bh=t/8ojYtN43APFVXUgeZtgjQpo6ZQD7a+4YqnemHNdKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/QTcWohKhTvn1/daaisvnbpBCWJXmSola2eGNBjrhMonN2MZCENHFyIdKAETbK4CFiyIdEXJnwueGLtGz0Lh/RdE3sQ3xYc8TBy8RatPAXM+kGx81ZQM6xaKy8VToxP/3dn39jXOnGS7l9n/jma9N4vhd1ga6DWkv1/0OOYzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=U2Balel9; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-641677916b5so5379766a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764447069; x=1765051869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DZa6k0PKfgjuZ8pfDrzuD9zGRDxJ6a2EfWlnw/BZUSM=;
        b=U2Balel9CourAs+rrT7WpCbeqL7ZFiZTTVA1VmSXhkeTe1Z0sSrWbnvdPlwGbdIBq4
         Nr5f0aEQ1owkTw/Wou3ywznBpWmZkQHcOI0Y9B+uWvVldh4oO5KLoMBlurnePhb+ZPZR
         UUw5amttv0UBzVeBNI6nB7CrYL0clfbF0tnpg6eFieAjVCHT+fO7pbXFHR/fwalt9urm
         aEqLniQqytdDltjkO9x3/3UX02hVAWuCiN819ZMcIVS6dHjebqvth8gNP/VR3308yWri
         qR+WQWPfaMAjP+RUFbo2S4WC9kprXypLUMt0TIoWJY/8yHvMiywGEeGQ0GE6mAFpqK1v
         65qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764447069; x=1765051869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DZa6k0PKfgjuZ8pfDrzuD9zGRDxJ6a2EfWlnw/BZUSM=;
        b=E7ZisFDf6cePWh4w0gwgN7d5wZMNWi0zEY5dOoX6vawJe60Z/GZ5bju4qFUM/tADqK
         wYAC4s2RzVA/6xqB75sYRg/ews9i8h9pZq4OrB/+tdbrPTz2R4+g59LqFrfVSJ+Tnh2m
         n2FAfF2GxJaI4vG5nm4X+WBr6wllVNlArmQWpoYFIrltzXAOCzDAAu3qH15+2xqi3DPI
         4p/ztgKC4VXV7EPk1q5zhPseUfAgI/6BTcezTF/AUBUlvn5jBCAnDPDjk5xaQLCJ6art
         NxBlZDadoRWcPalrh8Kbz2t0nDHVTb1uRS7d0gTp0Zc502XAV+VnbyZa8AWmwmlDY//2
         M4kA==
X-Forwarded-Encrypted: i=1; AJvYcCX1QH4jduOStWYdeul4dBuBANo6XdUM+jpCMkHNbogDPX/JvkOmUjj9P8TIArMT5poa7AEM45iGJTfWVQ548C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YykK8WW+nRXX/vc5J2dRVwL+LZOjiq/QWPrev4h8DTWW5+rGl2g
	7j18nHkjlQvl4Rbikp/TW/dKtxEuWeRQc53HvIkJNQQUmg44fzaAi6seQOHvvm31FEk+KTs2sxH
	XGFN3loyJO2cZdnyhcn2AbEqbxJl+hLN+PhIj73QKTA==
X-Gm-Gg: ASbGncvaS4AYhu95mHKwW1RiX495fCBMLEfAwLIF8mXQg9w+pNVZQbpX3n/JYu2BTQD
	bmxV6Jg54HyzaUc88RE945JdHj8IOaRh9dzVoy8gAtCpfuTxUVQwIHCcNN6uaU7HgPofnmh/A3e
	tJQdU43LCJyqaYLkFRyDPw4Wb00mBVdlJy8zGE5bhzlg64eEdpW9tgifHh1LxlPv17F1tLZSTXT
	lkLSOeJqEJ/yJVYbBoT16m3nPNoVZaEZjs5oILyyEHgN54ScjJhM688QpoexSRYOss8cZNNiTsF
	2V4=
X-Google-Smtp-Source: AGHT+IHmGvqMVyl4rj98MA1twPtvmDHtcpowzE6HXyAxrQtASfb0JCVB7nMu8XDRMWnr6peumysO83SbSCcH9ytUjKw=
X-Received: by 2002:a05:6402:4619:20b0:647:5214:bfce with SMTP id
 4fb4d7f45d1cf-6475214c067mr9741525a12.15.1764447069176; Sat, 29 Nov 2025
 12:11:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de>
In-Reply-To: <aSrMSRd8RJn2IKF4@wunner.de>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 29 Nov 2025 15:10:32 -0500
X-Gm-Features: AWmQ_bnWje606xogMzP8vkRzY53oeIh6Saq4e_wxmZyuQtFXjbPOM9XHqy2umYQ
Message-ID: <CA+CK2bDm5bpEgtw5U_ENkAsh28QJ+hQC+YF95zKKV0+ugTVMOQ@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Lukas Wunner <lukas@wunner.de>
Cc: David Matlack <dmatlack@google.com>, Alex Williamson <alex@shazbot.org>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Josh Hilke <jrhilke@google.com>, 
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
	Leon Romanovsky <leonro@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-pci@vger.kernel.org, 
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Philipp Stanner <pstanner@redhat.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 29, 2025 at 5:34=E2=80=AFAM Lukas Wunner <lukas@wunner.de> wrot=
e:
>
> On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > Add an API to enable the PCI subsystem to track all devices that are
> > preserved across a Live Update, including both incoming devices (passed
> > from the previous kernel) and outgoing devices (passed to the next
> > kernel).
> >
> > Use PCI segment number and BDF to keep track of devices across Live
> > Update. This means the kernel must keep both identifiers constant acros=
s
> > a Live Update for any preserved device.
>
> While bus numbers will *usually* stay the same across next and previous
> kernel, there are exceptions.  E.g. if "pci=3Dassign-busses" is specified
> on the command line, the kernel will re-assign bus numbers on every boot.
>
> The most portable way to identify PCI devices across kernels is to
> store their path from the root down the hierarchy.  Because the bus
> number might change but the device/function number on each bus stays
> the same.
>
> This is what EFI does with device paths:
> https://uefi.org/specs/UEFI/2.10/10_Protocols_Device_Path_Protocol.html
>
> Example:
> Acpi(PNP0A03,0)/Pci(1E|0)/Pci(0|0)
>
> Source:
> https://raw.githubusercontent.com/tianocore-docs/edk2-UefiDriverWritersGu=
ide/main/3_foundation/39_uefi_device_paths/README.9.md
>
> We've got a device path *parser* in drivers/firmware/efi/dev-path-parser.=
c,
> but we don't have a *generator* for device paths in the kernel yet.

Hi Lukas,

Thanks for the input.

You are right that bus numbers can change in standard boot scenarios.
However, for Live Update, we skip firmware, and we would likely list
pci=3Dassign-busses as an unsupported parameter. So, BDF should be
sufficient.

That said, if there is a better method using a stable hierarchical
path, and more importantly, if that method can be extended to other
bus types, we are open to considering it. The main hurdle is that we
would need a way to generate this stable path in the kernel and also
parse it during early boot.

Thanks,
Pasha

