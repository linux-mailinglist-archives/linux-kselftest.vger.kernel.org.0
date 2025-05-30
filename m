Return-Path: <linux-kselftest+bounces-34070-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66316AC93EB
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 18:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99D9AA436A4
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32151218EBA;
	Fri, 30 May 2025 16:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q6PDeIiW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E711DC9B5
	for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 16:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748623855; cv=none; b=qQh29Yv1Wqloy73bhHIXvpv8Po+T95D4pTU3rArxr/yxnniCtMWB9NhCJMWHdhgZHjIb/Vu9mjXYfMYjvHoDA36i7EMn9gvb6y9yMQ/dU3EFqpXp1ae97x3BPvmjYNbJFuGrWXfi7hXam1PRuGb8UPpAp0mCPgp2ND0AwyvQrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748623855; c=relaxed/simple;
	bh=2+cjl77WXCZ4p6bxVEQbI5IcDMznMf/N4VmdR3nvii8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKC8cdc7djjylC1Ue32McTeGkb+ND/xcse1KyjNNQUUHG5kcaEbaNauaDlTNF6pXYazWxxL2rFNIcw6wvLVH9b8c1gGUuYoU2EVyiQD9UTdo9E2eTq1dG2efjpTtodeAdqBqkPiIAx7ykDG/sAvM9fuAursHwACHiXsbkHNc0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q6PDeIiW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5532f6d184eso3030121e87.0
        for <linux-kselftest@vger.kernel.org>; Fri, 30 May 2025 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748623851; x=1749228651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+cjl77WXCZ4p6bxVEQbI5IcDMznMf/N4VmdR3nvii8=;
        b=Q6PDeIiW044/XckxXHZRDiz26lWUfLfvbJWGvZhiXaTL9T7VnKUrzlUUNRJXw0dobn
         5irg77QFVkadbeUNtwFNERDtPG5dlS0zzL1iw+22mQGg6Sv6V3kl5j2WiHdk8e//2Uac
         pIU8XAlge36aGph39ubOPf/KCQ4rhsNwEZk5yzv08Nfd2tx/9B+99jo9Z16YHONCu2ux
         NQYhQCnKG+hA+tbKNAJrSCA8tYcBhUwiYAXK6OTWX6YL8Wyx7jc4S2Ep4P6RouDAravB
         MBFRGCGlJx9IDsmbg/2ORjpUnbsxfQp/9i+5S0j17AbuUMy7YcHXoXnpKH3eGnZMepVq
         ztBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748623851; x=1749228651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2+cjl77WXCZ4p6bxVEQbI5IcDMznMf/N4VmdR3nvii8=;
        b=Zd+1rK9dEC6AqBgf5yjVXeu9qguDHyHyg98F74d/P8EF1s5QUI41e6YU9GZGj7dLHJ
         FXY45qubISrlXDj0w6aCRjKFu0st32Ytgq16jiYApHkF/+mC6cNhXrmjAShEYTgAtozZ
         54XJ4burtXCTKv8Dme28R6/ex73Mqooh7F/9KAbA/AZZrhKbXrFkT5P10yyIpvtBihFb
         q9tRG0CjSIvCvkFjTesfXXFXZI8+I255Sb17yCHu5tyEdyWjA4C0fpj4HmSVcP6+gkpD
         U2YFah1ypg0eU+TP5/WMcPOhq8il0xC7OwCbisab/9pvSZJ6FufbhUM4ZlV01lFzc8xo
         EPZw==
X-Forwarded-Encrypted: i=1; AJvYcCVSs6L1p1m4cn60TJsWTgytO+9+1KuY+dX3OGF2t0idssadporiE4u+a+6ic5peGjtav3u3qNWMeWl0foXePOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoY7ud9Y66MdFWUyfYhe9mXRiy+jlVX0HuGCnI5TU47B0t86S
	RjgPzHmEeyvAZoq/oLnXIYTgOn7jaHW/fxdsLAMGL8p39e5XqYbpXHI6mNMa237HV0vZZEPN8xX
	aU+zQkDd9A4skKVKQg5D/6r2sSslO++e+rsIYCPid
X-Gm-Gg: ASbGncs8LEDSW6nIcO7odqjRRDLpQqU4Ol/uYemJmTWcE9wZ4uT0mj+SHzZoHpnGIzN
	KGnRNagEFCDQGCMWYLqIRIW/EKX/vHV71ULs9+Yxp0yZOgSWPchW+EE3NutRBEFFbx/Yn9SK8A/
	FTld7Bx9NxejOwDBaGyHc8092brYk+H2lopvOCWfCZoBM=
X-Google-Smtp-Source: AGHT+IHimJ4jcNAnxaHaH7vQUd+BjyeBByThX68wANK7ddQ0p2woqDaT91hjePjY9eAS39Ve41QvnefVlzjP98/IXk0=
X-Received: by 2002:a05:6512:3ba3:b0:553:2034:802b with SMTP id
 2adb3069b0e04-5533b8e0985mr1411650e87.1.1748623851132; Fri, 30 May 2025
 09:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-8-dmatlack@google.com>
 <20250526171501.GE61950@nvidia.com>
In-Reply-To: <20250526171501.GE61950@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Fri, 30 May 2025 09:50:22 -0700
X-Gm-Features: AX0GCFsDqdkJqWWyN7GBVzNghKThUWF60JxiIEesPEIzPKPt0qvOZkfVyPO5fo0
Message-ID: <CALzav=fxvZNY=nBhDKZP=MGEDx5iGqCi-noDRo3q7eENJ5XBWw@mail.gmail.com>
Subject: Re: [RFC PATCH 07/33] vfio: selftests: Use command line to set
 hugepage size for DMA mapping test
To: Jason Gunthorpe <jgg@nvidia.com>
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
	Kevin Tian <kevin.tian@intel.com>, Vipin Sharma <vipinsh@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 10:15=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Fri, May 23, 2025 at 11:29:52PM +0000, David Matlack wrote:
> > From: Josh Hilke <jrhilke@google.com>
> >
> > Add a command line arg to vfio_dma_mapping_test to choose the size of
> > page which is mapped in VFIO.
>
> This doesn't seem right..
>
> Tests should run automously, test all possible sizes using a fixture.

This test uses a fixture already. I assume you're referring to
FIXTURE_VARIANT()?

I'll explore doing this. For a single dimension this looks possible.
But for multiple dimensions (e.g. cross product of iommu_mode and
backing_src) I don't see a clear way to do it. But that's just after a
cursory look.

For context, the pattern of passing in test configuration via flags
rather than automatically testing all combinations is something
inherited from KVM selftests. That's the common pattern there. There's
some work happening there to encode configurations at a higher level
using testcase files and a runner [1].

There are also some challenges with making VFIO selftests (or any
selftest that uses tools/testing/selftests/vfio/lib) truly autonomous:

 - The library needs to know which device to use. In this RFC that
works by the user passing in BDF as a positional argument to each
test.
 - For tests that use HugeTLB (like this one), the test requires the
user to have already allocated HugeTLB memory for it to use.

One idea would be to have tests test all possible iommu_modes by
default (with the ability to override and pick a specific mode) and
then let everything else be driven by flags.

[1] https://lore.kernel.org/kvm/20250222005943.3348627-1-vipinsh@google.com=
/

