Return-Path: <linux-kselftest+bounces-48236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E738CF6118
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 01:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A95753053809
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 00:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33562194C96;
	Tue,  6 Jan 2026 00:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZMkMUcv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AA4503B
	for <linux-kselftest@vger.kernel.org>; Tue,  6 Jan 2026 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767658828; cv=none; b=BDsdTcmH4IbshcaFLi9VPaRyJZY4fUYR9o12in2Y4lFI37r1yN0u4ZuGJoFhfn7JxSvUdCG/rZpasjOqC+GZCrryaKj/wi79p0PfKA7dPIZuBznH/9Prc89GssQRnFOon7JPjd0qn0YA8xUD860gLECCHXaZw83BPwRyshPiUuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767658828; c=relaxed/simple;
	bh=MRUlSzIlu0yCi9v9X+L6K/SPUeN5X4HBatQrXbmsoNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSQ0D/roPvrxPISzVu/9Ipwf+3eCo+WLtSssD0iiHi4MjQIWLZDHrYH2ncya8ZjQr/L1/NIwbqfqeXEeOsiwkK3d8zleZ6YJ8infloLhCjg/HjKFciZ2absBZ7EZRyfpk2XhObYXVuYiWSolwDpS3Q/GdYwRjYTGRFqbCTPZ/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LZMkMUcv; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37b983fbd45so3723871fa.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Jan 2026 16:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767658823; x=1768263623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ao9G2tm5rq8JriKrggBN6pUBzceguMNi3YbflNISZIM=;
        b=LZMkMUcvAvgHKQNzUZ7Fbj0z3lKIKmf4Gxb/rPbw1+ZvJxY8x0YMB6NaxPha3fKCvy
         lnpwLxqxHhI6H26s/0qtuYMfYrurs3a4fcFM2p9+LeM0PngYRAP7Q0lsDgwvsLo+nrBw
         ZZaGR5rNLWbmm9bD+0aOGxTc4mfVO7iR6ZXh8GmjNkCk82m47GGi6mZPJJfOe5gUvShF
         rtOFQQeh80W9UmJ42awq/OY3pSIqnSLe0hCgpOv/pyFzgZjYtPTX0vICcPXb5TDDaXQc
         mjjuyvfhSIgzxRPxsOvTnOu+EsZFxWUbfkHEKoDhUNcKjoaM9luxleYL85JQBIDLXmgG
         Thhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767658823; x=1768263623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ao9G2tm5rq8JriKrggBN6pUBzceguMNi3YbflNISZIM=;
        b=Vnv/47IQ8aIwA+xzm0PaJ3Wm5+8CXXwq4CAW6yv3wYmYQJ2Udz61b/IimB01BCUYd0
         jEXvu8I3D/i6VBH2TIy8pHEdBeEiOLLEXz+TDPqsQ23wh3FxM/sB958dEGVHvh/erp25
         lE+wOXYmMp1uHYRPVo1pPBY57Pc2sZEU0FPNbPxYXmGXv/SXFh/Zu03HBvdE9wpB164g
         Ir22Rsf51JsmZisST00Nl1b7fep/AkNuK3FcrTY4telb1imeKGt6Ee2pAtxMnEhaUShR
         KekCaP44B/WcTxmkVCaF2Nht1aQrBYxH5Yly6gjc1CpuYxKE7jS04Yp41q4SM72T6U61
         gKhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsFw6hdJOdmcmipBpUNGUUwneiww8jDAcWMe/XJxQ7NAyp/wmM9RdJClFROBytm+naNfmj1gbzqhWr+YU8FlA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx888ZLI21O6+AEHFzdnamsrcxcSzQtD6xEHWsycWVT6hjmu2wS
	hmiUhiqUMAZCn21lY7rR4ucYbLf4/sTxdF4dW3SMIIr0hv23XcsCe//wBIrg3jSTa2tgza5b0Um
	kEI5SHpMBTMAFDb45q5lWlTJUvb0QOeTd4MkvT+jf
X-Gm-Gg: AY/fxX6UOQ8B6RqbTtsFXKakV/Q+Cei0oa6SHD+8P3mIE3FwpsgNRX8KpqzB7ikS8B6
	vNaBRalWxUW45CP09kKHl+TuPirqk+/JqB1ppebW5FQlH1jcGxjWHTy2S9B/MJy4X5hAWt9ASgz
	18ZHj0rbfBZtbEG8idACTHPwmmlZzPzOLHi/XnqS/0uf5WthHHfEtBTjMYimuMr9zlkyewqj/01
	Kbdt2LTUn+j6C2EsRHr8/+gHygYhxZZq0tufdmetXAy0gyLkPsj4tmieG90W/z6Jwo/bAr2
X-Google-Smtp-Source: AGHT+IHb+AObIa8Xpi5KrmBllTV6a796WAN4T+3NWWccFiSvRWXKvYgmkKUjKvZYKPMGu7V/b+Y+kIuARsuoKdYKTCo=
X-Received: by 2002:a05:6512:b90:b0:59b:1d24:7dcd with SMTP id
 2adb3069b0e04-59b6521549emr381820e87.12.1767658822753; Mon, 05 Jan 2026
 16:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-20-dmatlack@google.com>
 <f0439348-dca7-4f1b-9d96-b5a596c9407d@linux.dev> <CALzav=duUuUaFLmTnRR41ZiWZKxbRAcb9LGvA5S8g2b5_Liv4g@mail.gmail.com>
 <2779d6a2-d734-4334-befc-99f958e1d1ef@linux.dev>
In-Reply-To: <2779d6a2-d734-4334-befc-99f958e1d1ef@linux.dev>
From: David Matlack <dmatlack@google.com>
Date: Mon, 5 Jan 2026 16:19:55 -0800
X-Gm-Features: AQt7F2ooQV8QHcMMN8oMqlI2XNP9S0NGm7FbnT15j4rY2pjwAwVxgbJOfVYkhMc
Message-ID: <CALzav=dbvQ67Mb=ayjPmgTtL9GQvusRe=PzBjcLMJrh4sii-0Q@mail.gmail.com>
Subject: Re: [PATCH 19/21] vfio: selftests: Expose low-level helper routines
 for setting up struct vfio_pci_device
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
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

On Mon, Jan 5, 2026 at 4:08=E2=80=AFPM Yanjun.Zhu <yanjun.zhu@linux.dev> wr=
ote:
>
>
> On 1/5/26 9:54 AM, David Matlack wrote:
> > On Sat, Dec 27, 2025 at 8:04=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.de=
v> wrote:
> >> =E5=9C=A8 2025/11/26 11:36, David Matlack =E5=86=99=E9=81=93:
> >>> @@ -349,9 +351,20 @@ struct vfio_pci_device *__vfio_pci_device_init(c=
onst char *bdf,
> >>>        device->bdf =3D bdf;
> >>>        device->iommu =3D iommu;
> >>>
> >>> +     return device;
> >>> +}
> >>> +
> >> In the latest kernel, this part changes too much.
> > Can you clarify what you mean by "changes too much"? What is the issue?
>
> I tried to apply this commit to the linux and linux-next repositories
> and run tests.
>
> However, I=E2=80=99m unable to apply [PATCH 19/21] vfio: selftests: Expos=
e
> low-level helper routines for setting up struct vfio_pci_device, because
> the related source code has changed significantly in both linux and
> linux-next.

Ahhh. This series depends on several in-flight series, so I'm not
surprised it doesn't apply cleanly. There is this blurb in the cover
letter:
---
This series was constructed on top of several in-flight series and on
top of mm-nonmm-unstable [2].

  +-- This series
  |
  +-- [PATCH v2 00/18] vfio: selftests: Support for multi-device tests
  |    https://lore.kernel.org/kvm/20251112192232.442761-1-dmatlack@google.=
com/
  |
  +-- [PATCH v3 0/4] vfio: selftests: update DMA mapping tests to use
queried IOVA ranges
  |   https://lore.kernel.org/kvm/20251111-iova-ranges-v3-0-7960244642c5@fb=
.com/
  |
  +-- [PATCH v8 0/2] Live Update: File-Lifecycle-Bound (FLB) State
  |   https://lore.kernel.org/linux-mm/20251125225006.3722394-1-pasha.tatas=
hin@soleen.com/
  |
  +-- [PATCH v8 00/18] Live Update Orchestrator
  |   https://lore.kernel.org/linux-mm/20251125165850.3389713-1-pasha.tatas=
hin@soleen.com/
  |

To simplify checking out the code, this series can be found on GitHub:

  https://github.com/dmatlack/linux/tree/liveupdate/vfio/cdev/v1
---

Cloning the GitHub repo is probably your simplest option if you want
to check out the code and run some tests.

>
> If you plan to resend this patch series based on the latest linux or
> linux-next, please feel free to ignore this comment.
>
> I look forward to testing the updated patch series once it is available.

I will send out an updated patch set hopefully within the next 2 weeks.

Thanks for taking a look!

