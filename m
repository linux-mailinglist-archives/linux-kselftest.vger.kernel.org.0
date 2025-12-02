Return-Path: <linux-kselftest+bounces-46917-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF83C9D16A
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 22:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 58EBB4E3C57
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 21:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EC12FB095;
	Tue,  2 Dec 2025 21:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eDCY9dk+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02395248896
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764711010; cv=none; b=NXniUwImIvSltf5/JeaMcQRtOUEUyL4GVX1K6YpQ4sNx36F0oe/ODWN+a3zbAygh/MIGrhu4wPEwBplwUKezEDP/F3r4T+HGnUs5GHMHy02Pn70u/NFIIRpwEA1nAux6VJghDEJb8sRZ+4XihJwWq2VpA2xxgGYrx+7sLsOMdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764711010; c=relaxed/simple;
	bh=4mAECnBT0GLqaUGCbUVvv1BgD9slq+DDHc3MT4Qfhgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TALXKkXSorGunQm3qFF7KiB6Dh+FsZTFyVSH4m640Jua70tE9R/ow5KImXwoTpO1qQZ0ZgiKNHbLCMeQWiInD0B7f2jnve1qpKiZWkfav4cIN9rzIfZpJMAOw0a3M7Sw4STjIJvH9DmuCzXSimJR/LhCRXea671TLLbfARuYluo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eDCY9dk+; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-55b0d4b560aso191988e0c.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 13:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764711008; x=1765315808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7su52te45M2cD5cYZfeIyUKvZtz5ws178yIllLdY38=;
        b=eDCY9dk+UrTrNFiPL9Tw7iHuECH4xsdBYH0Bo6nNQbhVRNUlqsuqbT1d1uIRNTcyVL
         K/HNWhtfH4QwW739L6ZKQovkAt74CZOmtFURhqZSdrkkLFYADsL+K2txOrKIn1i2VPLV
         hmQuFFU9Rex7+xO73an1u2Z3NjsvS09WTd9UTETZ5cRbwWKvCzWVsC0HM0c/696dNHzy
         qDBBJbOFUdc6p2+ZBVCvfls+bx8g7hrob5Y08XDyI/l2wbO3NWD+2LoRnDoMTlT2wu9H
         naytxoPca8rhopYB+1NfFx4EV8ttCz9FjVk8Mz+nsCBSRr9jmCTxmQoRkPN8tEnMX9p8
         b0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764711008; x=1765315808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H7su52te45M2cD5cYZfeIyUKvZtz5ws178yIllLdY38=;
        b=Qax3LLrInbEtuZx7rNFMyaWNgReJBz5Eu9wpQMhpcbxIdQDlXjx9T9JloCEcEjB4Pa
         l05egtx9h6sOxpVCZdfy0wbyk9lpI/ZCsZk9vhus16FGjJpNvaubYNngNlFI/sCagPrl
         XC29C20jlk+jYvgZTwfew8JjGTmxNOaLS+MCjLZlN6Xp5r3YITGtjyHQrcc3bYGIvVGH
         nSTDf+e3mLZsKQXBFKJUB4x17yTEWm8kZOry1x1ZBXzdQSi1+h+QnOTfF6kf2nDXKN1Z
         05fEy0tkBuXgiQxmcNTIGUeOyh0kJBgOrwqsRsq7IHl26G7Qc7KQnIqtvmPLidI7+vS6
         vwCA==
X-Forwarded-Encrypted: i=1; AJvYcCUECJrInWY3Jpbbh5cRwW9Z7lwUR75WDnqhfXcS8u3MKmPDF61RPBlsYfg4sO7T6Vjr0PrZjQNGiLp/3uNxM/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHGnWwWCcs3V+foQHjiO0m/bIjjXUAoC8UMMc8hUxAFE/01x4o
	ZzpmRNp9kC12MrTH5g4bwxFA0NT3TDHg2OjQe1vS2UUklqKMsE0sEMxLDoZ9LIGWnGEB/aThoBb
	VCswXyv5PDJYheEI8ypzVJLJcCJHPm7MVs1xxsEcl
X-Gm-Gg: ASbGnctsvVIPwIE/fXUQLNCw/hvJAuHEs3+rmskalYNzSRgu4m5XojjofJRN/McoxT/
	uB+jyJL8+bQnlthhY2Ir8zQSuQQaDfKkeeiIXxUWCl+MCa4rtQtWSIksEY8w0/a2DEdBbI31VA4
	IMJrvSpTXZH7Qsn7dRJRe7RTuTdPjjxC/YsnZS/xvcAA6aOkK703pvICAh3c7CUvdT2eOt6TKux
	xmoGJzEzcPLsV/RxUNgAIgtCo5BASikM55s0mX1Y9zZA+GHAC1dQ7u/T7JnrRADkVnutTe6
X-Google-Smtp-Source: AGHT+IFpYAAsGy3oNM7Mb+lKNTvoCoDd5AD7g1adQp/M5NYzyZ+Sr2dWktsn4qG6B1Xs7hMA84tqYi0d1fCvoV1bfCE=
X-Received: by 2002:a05:6102:80a6:b0:5dd:37a3:c389 with SMTP id
 ada2fe7eead31-5e40c731398mr2852845137.2.1764711007486; Tue, 02 Dec 2025
 13:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <CA+CK2bC3EgL5r7myENVgJ9Hq2P9Gz0axnNqy3e6E_YKVRM=-ng@mail.gmail.com>
 <86bjkhm0tp.fsf@kernel.org>
In-Reply-To: <86bjkhm0tp.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Tue, 2 Dec 2025 13:29:34 -0800
X-Gm-Features: AWmQ_bknnx7BOEcQ6Zd5SqbqHsbQAiPXPlN7KmTjA9pACVrivKKqlwCOGHKn8aM
Message-ID: <CALzav=es=RKMsRUdpX03m+2Eq4SVxPZSZuy1fLXV+dv=rhDhaw@mail.gmail.com>
Subject: Re: [PATCH 00/21] vfio/pci: Base support to preserve a VFIO device
 file across Live Update
To: Pratyush Yadav <pratyush@kernel.org>
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
	Philipp Stanner <pstanner@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Shuah Khan <shuah@kernel.org>, 
	Tomita Moeko <tomitamoeko@gmail.com>, Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>, Yunxiang Li <Yunxiang.Li@amd.com>, 
	Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 6:10=E2=80=AFAM Pratyush Yadav <pratyush@kernel.org>=
 wrote:
>
> On Mon, Dec 01 2025, Pasha Tatashin wrote:
>
> > On Wed, Nov 26, 2025 at 2:36=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> [...]
> >> FLB Locking
> >>
> >>   I don't see a way to properly synchronize pci_flb_finish() with
> >>   pci_liveupdate_incoming_is_preserved() since the incoming FLB mutex =
is
> >>   dropped by liveupdate_flb_get_incoming() when it returns the pointer
> >>   to the object, and taking pci_flb_incoming_lock in pci_flb_finish()
> >>   could result in a deadlock due to reversing the lock ordering.
>
> My mental model for FLB is that it is a dependency for files, so it
> should always be created (aka prepare) before _any_ of the files, and
> always destroyed (aka finish) after _all_ of the files.
>
> By the time the FLB is being finished, all the files for that FLB should
> also be finished, so there should no longer be a user of the FLB.
>
> Once all of the files are finished, it should be LUO's responsibility to
> make sure liveupdate_flb_get_incoming() returns an error _before_ it
> starts doing the FLB finish. And in FLB finish you should not be needing
> to take any locks.
>
> Why do you want to use the FLB when it is being finished?

The next patch looks at the PCI FLB anytime a device is probed, which
could could race with the last device file getting finished causing
the FLB to be freed.

However, it looks like I am going to drop that patch. But the PCI FLB
is still used in PATCH 08 [1] whenever userspace opens a VFIO cdev or
issues the VFIO_GROUP_GET_DEVICE_FD ioctl to check of the underlying
PCI device was preserved. Offline Jason suggested decoupling those
checks from the FLB, so I'll look into doing that in the next version.

[1]https://lore.kernel.org/kvm/20251126193608.2678510-9-dmatlack@google.com=
/

>
> >
> > I will re-introduce _lock/_unlock API to solve this issue.
> >
> >>
> >> FLB Retrieving
> >>
> >>   The first patch of this series includes a fix to prevent an FLB from
> >>   being retrieved again it is finished. I am wondering if this is the
> >>   right approach or if subsystems are expected to stop calling
> >>   liveupdate_flb_get_incoming() after an FLB is finished.
>
> IMO once the FLB is finished, LUO should make sure it cannot be
> retrieved, mainly so subsystem code is simpler and less bug-prone.

+1, and I think Pasha is going to do that in the next version of FLB.

