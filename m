Return-Path: <linux-kselftest+bounces-33885-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB186AC56EE
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F031883A75
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 17:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B5D27FD69;
	Tue, 27 May 2025 17:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZ9EiBdn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE6726F449
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366814; cv=none; b=EGIo/Tok936DAOnsuLhPyP73m+Jh3lFhBc/DJVSiws1vum4fiHnpjFQKZFHdokI3a0CjsGAI19beXjRFBQEJXxt5zpKUWaEEKQj3u3RKXuP3/yZzHGk6IGwHw6YTwFk5S24wOayXmMyekrptOKdKxq4+zM3X/FYsl3whqdz5UgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366814; c=relaxed/simple;
	bh=OwFNtM5RYwIt2cO5YB7MinCYHeC0TqnuHl7oHp5frJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eapBlJ4tX2b+UODJBeORC9TwfRkOO1jr0E9lvez6IIrFF3c8pymch1R68mrKLKb0vaTWrjq+07kJF64llfFDDjiStFbFMGP3wLyf2bQvZSqp5OAAXuKxEETqyKxj+x3oAIWVgFuyCtgfdlfh7MbsHQnj7UWZTNvZ68kga7jtJ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZ9EiBdn; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-54998f865b8so4220182e87.3
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 10:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748366811; x=1748971611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge83cQZDvnwGXmNV4VWDL33n4ztMUCoEodBwwkHhulY=;
        b=uZ9EiBdnz1wue5oxSdbWB+IOdlX5I/p5lLB7eY4O/+Gkvb1qv0UbNU5DaPAq9MrC1M
         DGfDh1Ap1hviEeuLAWExD/4OlaFexpcXw//jEmqqAiDg4GtfoFz4vCJJA9SNoAFIBO4/
         Cog3cHmdpmYVulzq/cq4AnODFkICfg4htn12Xp9ePmTKuf05v2TByid/MP4Y7/IXOsfV
         CPXBh1cA9DgvVUExHhEUQJGtaAB3CeWhwX7ZH344CdCpLLvgFgUaW6rQkKnk6UpIBclV
         oyHMmHoVupjfD3132w1GUpxuyL1fGJWmAAfE5MXirq1XalcBkiSAlnhDIvftnL3itoDh
         b8Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748366811; x=1748971611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge83cQZDvnwGXmNV4VWDL33n4ztMUCoEodBwwkHhulY=;
        b=g9uMfDwvIOisiRildI4hSP9Pl3MRf0RH/xqbFfKRclECnal3IPHs8BA4I9A1N5vYaX
         uq4CbqtycQZUyiwzVBCoC/jKFBomGbHj/j6freU3bUla+rm0ZNWsDV6b1FQZKR6OHjNs
         7koFnfGX+mdYeSeDxagTOSxzR0PGOTn4ATX4Z++TqZhCY/GZJa55WPQZIZCDX8rnG2HW
         oJukhrsgJHOD6B+qHAA9Fv0n2HeWjOGritf+TJpOFrcqZdLrM0CugaO+xp0AO/BBrmhb
         nq50AWu18CtZXB3h1uw3tGoc4wtrBntS/lzmfWEf/yGlmXKBV6eMRd9W+pM2E15c4RsH
         i/ng==
X-Forwarded-Encrypted: i=1; AJvYcCVqXtALfqIM3FZgUaIJ4tt41/5rnQ/b6yV5UiRtc5Vi3BDcLB+OrX5oJqndfYTSisWxCqzrYwNSHMZ9pWrvGxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIxylLAGXHX243VgIwz99FaMhxf0SCZAbljGviiigW2IOPGJ4
	rvMU6gCoUWjNlJjS9AxIYVBKkAHu5fZ9GFdEE9iwuHIkuG9UERhNV/wIJU8gDruO8RdKjT0py0q
	3tFe7XMAkZofQ7vu0/kL/wPvwH3AWYPJMw4Cd22dM
X-Gm-Gg: ASbGnculqZViKjr2rVG2iOz53qlmZh1KByGmVfspXVepkh0iCyX5zikWCVLRcFyPe0F
	EGkp3PkrYXqM7ibUa9TaCjlOxwmaGK0OOcziEFaHdqC7i9W+kFdPSI+Hp/Sn/u5dqB08woqmyQ9
	JOfrmfiQRBr90QOnn6A+VXqIrNYon9Ei8bQO4JKKBBYn4=
X-Google-Smtp-Source: AGHT+IHQDkOSTVRIROJ+g7i1WPwyUVIKFbvtifpyRiMYJgBZVGOkUtWOB91Yxj7Taj/VjxKKSP5XcOpwZzb1xtZE/Xw=
X-Received: by 2002:a05:6512:3d07:b0:550:e4a2:e0e0 with SMTP id
 2adb3069b0e04-5521cbaec9cmr4595357e87.44.1748366810298; Tue, 27 May 2025
 10:26:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <a2149117-7b52-4d18-8eb0-baf14e80ee06@intel.com>
In-Reply-To: <a2149117-7b52-4d18-8eb0-baf14e80ee06@intel.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 May 2025 10:26:23 -0700
X-Gm-Features: AX0GCFs7UkeAuRIPrTUv7pRJieaZK5xiuzysfdv4dchrDmafqztZf4XeVmWqJik
Message-ID: <CALzav=dY53+zTrjwe3-XGHCDbU6i1e7RyoAfOsPuQMsDzczeGA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/33] vfio: Introduce selftests for VFIO
To: Yi Liu <yi.l.liu@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
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
	Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 2:07=E2=80=AFAM Yi Liu <yi.l.liu@intel.com> wrote:
>
> On 2025/5/24 07:29, David Matlack wrote:
> > This series introduces VFIO selftests, located in
> > tools/testing/selftests/vfio/.
> >
> > VFIO selftests aim to enable kernel developers to write and run tests
> > that take the form of userspace programs that interact with VFIO and
> > IOMMUFD uAPIs. VFIO selftests can be used to write functional tests for
> > new features, regression tests for bugs, and performance tests for
> > optimizations.
> >
> > These tests are designed to interact with real PCI devices, i.e. they d=
o
> > not rely on mocking out or faking any behavior in the kernel. This
> > allows the tests to exercise not only VFIO but also IOMMUFD, the IOMMU
> > driver, interrupt remapping, IRQ handling, etc.
> >
> > We chose selftests to host these tests primarily to enable integration
> > with the existing KVM selftests. As explained in the next section,
> > enabling KVM developers to test the interaction between VFIO and KVM is
> > one of the motivators of this series.
>
> interesting. Two quick questions:
> 1) does this selftest support all the vfio iommu drivers (typ1 and
> spapr_tce)? Maybe also the iommufd vfio_compat as well.

This series supports the following IOMMU drivers [1]:
  - VFIO Type1 IOMMU
  - VFIO Type1v2 IOMMU
  - IOMMUFD compat-mode with Type1
  - IOMMUFD compat-mode with Type1v2
  - IOMMUFD

I have not lookied at spapr_tce or any other modes, but I implemented
the code in such a way that other modes could be added in the future.

[1] https://github.com/dmatlack/linux/blob/9832935d7a44aab725ff627c6acf22b8=
a17d407f/tools/testing/selftests/vfio/lib/vfio_pci_device.c#L409

> 2) I know Alex has a test suit as the below. Has this series referred
>     it?
>
> https://github.com/awilliam/tests/commits/for-clg/

I was not aware of these tests, thanks for sharing the link.

If we think the approach taken in this series makes sense, we could
presumably port those tests to tools/testing/selftests/vfio/. I would
be happy to help with that.

