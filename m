Return-Path: <linux-kselftest+bounces-33901-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8394BAC5D9D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 01:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B2DC171217
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 23:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A8C1F4C96;
	Tue, 27 May 2025 23:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmBEXbMm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFB10FD
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 23:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748387123; cv=none; b=DCSdnTwldRpWf3QfPuOTH1tjkNHf4YwzGIR5hFd9z+oC5kr1RAqmMHrJv0lA5V3w/m2ERYfkFJjTjlur4R5ehH39qTwIIsk1EzbGKQwY89vo/LbTx7EncOSEfMXI5UVM01xqV5UbgoKNcm60NEpDJXAQg16nPXwvgRT9w+NG84Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748387123; c=relaxed/simple;
	bh=XBTb+b+ldsUTYlGfsh2AecYSih2/2OJk4HBDSA25zYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACgUA+nS6noulVJ5Dk77DqkHtovwIywUMJwvq8lspRRL0Eds1yb2T68xei8GQueg0S5+5/EsQHpeLLwo3XEMRr3/RpP8gKHZK+5kORwzKdajUZeAYl3ntmd8o8ybzNls5J/k91IBVRwP53GNz94KlplHX2J8LnbCu6Q5sCbooQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SmBEXbMm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54d6f933152so6397273e87.1
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 16:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748387119; x=1748991919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuHJor9+bQ607wqyxrjYZBMYzKvn8dtESweSPu5Q+fM=;
        b=SmBEXbMmnnVxmKcw+1+EA2VjDE98sw9C7+CjdtK1DwLPI5CiGf3yAkMJwksqFet82o
         5skG5DKAUIWIpEldGYjC5JIIZctjsqvbcfz8Mq47q2MItTNJU/7O3Ls5ba5ZpM7QYvAK
         LusZknIb0rkrzDP6EusXfjmzfEJaOqRirKqelZWnUX6WuGdSEgMktIhbjYphqxpSAJ6c
         /qdGnJoty/eWpL2o3v6SI8kjVkyRvlILV5CaRNv4bivz5yTguFvDoUsOGGuQ6n5JNuZJ
         TdhzPe3YXN/yAU9O/3oV3titT4w7k1u0KEPnIK+Gi5aWTOodEhV+Bc41ZRycJNrtj475
         wNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748387119; x=1748991919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuHJor9+bQ607wqyxrjYZBMYzKvn8dtESweSPu5Q+fM=;
        b=mBm/U/VpIwOAd2L0Q1U1at27ngrxP24K/FYq+Ui9LSF1+GXEkh7xJRMCG7PytMxEVk
         rUyWEOrLBmQ9ttub157c+zlAkQfAYMwE+Kw51HdkZJH9vwdZfMqmLhO5ZBAKKH6kEnWc
         ivcjyEDc81KoDAWxYmpC0SqUNBCQqDK54NaPDTxY9fFWKADGUvlQ41Jr8PlPET8LE/A+
         HgT3kjEd2uHFuqCu3VACYPW9HTcZFzEba3ko3kPpE7rwDMrbj5KMFMu4Noq6n49bNWFv
         0Y+41FT8oC3psnClwP/85vo0cr705CYx/KiaOmFTOVyO0FkSCsu8pAjFKHI5RxlBoQDf
         mZPw==
X-Forwarded-Encrypted: i=1; AJvYcCWc1k00gdHIE0iwINk2pbS/X8KoAYWhbXJySmoBja1TjELjYZMrv5vLjLxcLY5XehfnyeZdBlAKGtrK2J1UEL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUyh66SLs1DsEMpPN30/fFUHc3guW7VMGUIKdVxYp/iUx/lHwQ
	M1JhrcWcUO4GAQd2JbG6/dkak0tZwCxvmhekJC7qaJl6+NNCOLGY/ZOPGM7Op2+kRFwyVKqLPsC
	WlXcThRsHAz31YGM6APrpbWGiXUhrKUL3p6pMX9m3
X-Gm-Gg: ASbGncu+Y16rq46QfFQUxHtt8XYEJca9yRA3LXf7FrAwymKAH5X9EovM+IAzrhFXvT1
	sSZ0gciXUnEnc1lkttfV8MOIJCNF3CUJaeMzSlZQ9YKMJaFGsskgfOsWdrdD0/+Bb4U3uKoRZ2C
	5sWD8dukfk/Nv9+nzTd+Aiuh1k24cN6bsC7Kh+Q2ftPdE=
X-Google-Smtp-Source: AGHT+IGg9ccBEPW/d2OzGTiBOwTcGsKM3NfeE7zC0N6Vbkc6ZP/+f/3gAXRuC5OI0O2p9ds9Q535uewDSijkUqngi+Y=
X-Received: by 2002:a05:6512:3a94:b0:553:252f:adf3 with SMTP id
 2adb3069b0e04-553252faf51mr2393892e87.16.1748387119176; Tue, 27 May 2025
 16:05:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-9-dmatlack@google.com>
 <20250526171625.GF61950@nvidia.com>
In-Reply-To: <20250526171625.GF61950@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 May 2025 16:04:51 -0700
X-Gm-Features: AX0GCFtqlx310ZBq_KZXeMWwJ8mS2pCKacGCt2_kuJm07qFDJCZPZO8cRWVe5Zg
Message-ID: <CALzav=ewSn9c3aWTFjvLSenkhwS=fMndLDoF9=L5Bv6kJ+6tLw@mail.gmail.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
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

On Mon, May 26, 2025 at 10:16=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> On Fri, May 23, 2025 at 11:29:53PM +0000, David Matlack wrote:
> > From: Josh Hilke <jrhilke@google.com>
> >
> > Update vfio dma mapping test to verify that the IOMMU uses 2M and 1G
> > mappings when 2M and 1G HugeTLB pages are mapped into a device
> > respectively.
> >
> > This validation is done by inspecting the contents of the I/O page
> > tables via /sys/kernel/debug/iommu/intel/. This validation is skipped i=
f
> > that directory is not available (i.e. non-Intel IOMMUs).
> >
> > Signed-off-by: Josh Hilke <jrhilke@google.com>
> > [reword commit message, refactor code]
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > ---
> >  .../selftests/vfio/vfio_dma_mapping_test.c    | 126 +++++++++++++++++-
> >  1 file changed, 119 insertions(+), 7 deletions(-)
>
> FWIW, I'm thinking to add an iommufd ioctl to report back on the # of
> PTEs of each page size within a range. This would be after we get the
> new page table stuff merged.

Thanks for the heads up. We are using Intel DebugFS because it's
available and better than nothing, but a generic way to validate
mappings sizes would be way better.

