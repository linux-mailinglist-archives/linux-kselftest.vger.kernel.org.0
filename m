Return-Path: <linux-kselftest+bounces-33966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B72EAC7308
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 23:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA82318958D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 21:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A6B21FF32;
	Wed, 28 May 2025 21:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1zkKyjhC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F29A63B9
	for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 21:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748469206; cv=none; b=kA1xFqireLn+2v7GTHDCNI24LLXRDvPKAFM/o+l3aFIV+jZwW/RgG2Q9m3BjJqCgp5FQiaMTgb0Txd5tuYiM/fCKyGzcwiqhgc1GFZGQdldf3dG+iY7hfJ5x8yT6ZB6iFoyqAz+FqqAPb3nKmvuv1w/Te6IebyDmqU7YPXwv1bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748469206; c=relaxed/simple;
	bh=dE2naAwQ+nEe3fk06JoC1XB+hpjLPW4DBoK7fhvH22c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVm7ia9hatHAqty2nbuE5Ot2NOjDjBqnxYRFEhkCLOTx11ro4Flsin8kDQCpv2yFp/Zcj2DxRzD9LgsBUtZjxoIA2pyoh6EsRhk2E7CkWj51nZSdJ7EsawfbXTIUcTNeFYK8Noev8XJ4hQobyhqM8L+IIFxVNdsPG60xORMpP2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1zkKyjhC; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54b09cb06b0so271339e87.1
        for <linux-kselftest@vger.kernel.org>; Wed, 28 May 2025 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748469202; x=1749074002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dE2naAwQ+nEe3fk06JoC1XB+hpjLPW4DBoK7fhvH22c=;
        b=1zkKyjhCcVobB3tpGp6FcxhdBzpzXEiCxlOT/RBXbKDz1g4uboCgya9r9+S+OItg+w
         ZOl4k5if6xxsDHSxkO7FBgAschn4fCfYdbaS2nb0UdncH77acT+enrV3sF6oMnCjephS
         eDiKDssJ6jZLbp81lSA1JTf+xtsEIwMB0nLQs11MVPAPq8o7Z0Qmo24Jy7+3P800htjE
         KA78iQ7uCGFS2HTwvTU2qzqFdpAoL4N8K4/KWkUhBOWB810j8liQ3p/lcnrnUXYyMNsS
         0zy9eT3P5Smg/klLicKqDGjzp/6ACZmBfrYuUOKbO9d5f747OJion5Xt9jz3fbzt4IVt
         9uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748469202; x=1749074002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dE2naAwQ+nEe3fk06JoC1XB+hpjLPW4DBoK7fhvH22c=;
        b=F0RJ7J8adHQ51gO8x/DEZaD+FECFc7NKNGXsVPTTYhroluQnBnPGKHZQb6J3TMJ+a6
         nOrgnK1MPsCt9p3ip+LJQpjTCksUl71wzfcvinCTIeR/RKeboi7R48Du5fHGje5COTUh
         MHAi3DILSIcOtQq25BZ3ngcJWvQa5nzeTlPrNu2pB364KY+UWMJL4AdN4PX9KGyZbGIx
         zDabfeogel3MAr2k5wT3nIZWA3omCmtxx9561DSyQufzXDbfuPzsXxy0h+zZxkPBemrn
         7IqElPVPSzPrBYCtXPpYOufGFkjppCtQKju5wwAde0tBwP0+ROEmdvz2eNTWKeen2mnY
         vD1A==
X-Forwarded-Encrypted: i=1; AJvYcCWu1ot1DLnDaSGBi6xyJbR+2FcFgpiA4y9AWAR5JCkRW5EXUvfIviXQrXFC4RgA0NAPZ+8S/qcqYTB0PgL7Itc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjgUuzXlctX8Kt8quK5V5nKrxb+99rJIVMNtxmvwoUs0LG83iR
	xQBVNZAugPzKo2ew0jkcdml3kqQ+krCRClx9EtSEg8WwqRIozVGCt0sowtfNupEYswEIadr2C3B
	0IgGIT5llZRJ0n2EFdvnv0FWvlnpvaLiVB9ydREaa
X-Gm-Gg: ASbGncvOb86t9DGuu0+WDeS57a+T562w+sWrZ9wnjqBLG7xBQz/rPcPPvh5s2hPrPXX
	DoJ6H4x30eZDkGHfZH2xcFlE2Rb+wOjXmpY5creBpkDQnADtDsgyyx4cS2W+69re24R9CWz2731
	Ev2ZcMu4nYhJPsOhW67nL5ZAkeA5PnfnfLcIeLfWy78H4=
X-Google-Smtp-Source: AGHT+IF0IOnstNefATVPO7zdAb9WfmxFCxy7ZlLSsaOo6r/VQ030eWw6hYz7T3B72tn3wPt6Wdt2okeo16V8Yx0kvEU=
X-Received: by 2002:a05:6512:6404:b0:553:27cb:a0f with SMTP id
 2adb3069b0e04-55327cb0b4fmr2344728e87.57.1748469202021; Wed, 28 May 2025
 14:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250526170951.GD61950@nvidia.com>
 <CALzav=f_12DE4iJ4XxU+jsaEcP2LZioVfuVwGMnK8a=JJbA0JA@mail.gmail.com> <20250528001103.GP61950@nvidia.com>
In-Reply-To: <20250528001103.GP61950@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 May 2025 14:52:53 -0700
X-Gm-Features: AX0GCFuqnqY6O-kioyenpdkhVNaSef52QxbcsQW99CUsQ8JBu8SV_o1TY3dA1AQ
Message-ID: <CALzav=c5Xvzw+A_yWipzc1RyFwjP3TyAwtey7HOOOiepKf7dow@mail.gmail.com>
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Joel Granados <joel.granados@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, WangYuli <wangyuli@uniontech.com>, 
	Sean Christopherson <seanjc@google.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>, 
	Josh Hilke <jrhilke@google.com>, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 5:11=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Tue, May 27, 2025 at 04:01:52PM -0700, David Matlack wrote:
> > > A reusable mini-driver framework that can trigger DMA is a huge leap
> > > forward.
> >
> > How broad do you think the reusability should go?
> >
> > I structured the library (which includes the driver framework and
> > drivers) so that it is reusable across other selftests (i.e. not just
> > in tools/testing/selftests/vfio). The last 3 patches in this series
> > show it being used in KVM selftests for example. IOMMU-focused tests
> > in tools/testing/selftests/iommu could also use it.
>
> I think having it as a usable library within selftests is a good place
> to start at least. It shows it has a clean API boundary at least.
>
> > But it's not reusable outside of selftests, or outside of the kernel
> > source tree. My intuition is the former wouldn't be too hard to
> > support, but the latter would be challenging.
>
> And then we can see if there is interest to move it outside.

Sounds good to me.

> > I was also thinking of using NVMe for this (cheap, broadly available),
> > but I'm a little worried someone might accidentally corrupt their boot
> > disk if they accidentally pass in the wrong BDF :)
>
> Yeah, you can't do memcpy on NVMe without being destructive.
>
> You'd want an alternative stimulus API that was more like 'DMA write
> something random to X", then you could DMA READ from the media and use
> that as a non-destructive test.

Yeah we would need a different driver API. Intel DSA supports a Memory
Fill operation, which would be similar. But the nice thing about
memcpy is you can validate that the contents of memory are "correct"
after the DMA. With NVMe we wouldn't be able to have any guarantees
about what exactly would get written.

If mlx5 HW is truly cheap and broadly available then maybe we just
align on that for baremetal tests and not worry about NVMe. That way
we can keep the memcpy API and be able to validate the contents of
DMAs.

For running these tests in VMs, Joel's pci-ats-testdev [1] looks like
a good option.

[1] https://github.com/Joelgranados/qemu/blob/pcie-testdev/hw/misc/pcie-ats=
-testdev.c

>
> > Do you think mlx5 HW could support the current driver API?
>
> I think it can do memcpy. It would require copying a lot of code but
> it is "straightforward" to setup a loopback QP and then issue RDMA
> WRITE operations to memcpy data. It would act almost the same as IDXD.
>
> There are examples doing this in the kernel, and we have examples in
> rdma-core how to boot the device under VFIO.

Good to know. I'd need some help from someone from Nvidia to write the
driver though, or it might take a while.

