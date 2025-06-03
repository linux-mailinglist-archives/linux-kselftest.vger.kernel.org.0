Return-Path: <linux-kselftest+bounces-34229-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6456DACCC23
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 19:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74D7A7A3CCA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED771B4257;
	Tue,  3 Jun 2025 17:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p5k8Cnx/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A999D1A314F
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748971763; cv=none; b=Qy0EU0U8uRWXju9f+ya9FFDKJN1yMAH0dEi0omz+MxJNACxDwysj+At/rkwLjUsXyqT7tcvCCyoHv/Bgsd1glqM3lrCM6gDMYgvnDdAzjKjM94yhzYNFItAHAVPHha8x5l0k4/09jVeZ+jPAVEvUxisf4yj0KjJxmQDKoha2L3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748971763; c=relaxed/simple;
	bh=BzVU9cw4jV/GgGbMTgN+bXrxNjkI6xzUWrMaOD/etqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpv8/cuyk53TYzo09jRNnl7UrkRCpb51Q0s7dRiRiJ3FThQ6eT/zwwNYa3iJE/s4QciYxYSTAz6JoWkKmCnDSw/RP6ksrFSu8bCC/VspTabwCnHHWYxz2bJzefLQ6RJbRgJDYCnBit+D0UWO90lkAp0VqnYdARljMGdmAb9h3IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p5k8Cnx/; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55342bca34eso3688935e87.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 10:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748971760; x=1749576560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=huXAQA1P5rPnCpAmYNj7AvZER2xRzSKLzdclBOWoi18=;
        b=p5k8Cnx/D1twCcs69tyTrOQNhY71xMOUA/LAIpl0Clo/XhlVKgrbzavf0Kkj7oZeOv
         UDFee/lbPCC1rHPNrY0y5qUtI9biHEiLhiqYUw6LqiNleUf99gK8Gw4vJKCJKVJpThcZ
         mV6Ql6uNqTghUtV2sMXCovLGM0PUR3ODoNNyk6M/ECCzBKHDFHnCIjypZNTNFBuVjUXK
         /JV7uMNuGX0o8XvfxYlIy99LoTX5O3W27g+WnC0qQFjNMFqVTZWLkXeHJkbIUPp9rXOt
         32KyUgFzKGDtzaqm6idZCuf7PX/fZSK8Qk0SRB3OmDmx2XUGiiDdDqNCDyor+zUVNqcC
         aCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748971760; x=1749576560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huXAQA1P5rPnCpAmYNj7AvZER2xRzSKLzdclBOWoi18=;
        b=g28M7j8wAQDETc/tMljQ5nNlyB4iL6AF+xBCMeCBb4eHrd2tzSWe1CR2jXyQkCfJpl
         KHHvfYnZFnWDFG3QBSoaTTHZAuCDXrkWcpB3zCLoLDvhEg+yHJTPIWTTX5ZSdM8WTJQH
         s2y5ofGrQu/LriiWnzK1Nqn6Odyr63OQzQ/JLcnn0O63tSPsAjv5S7icx0BLi+JTYRVc
         dxF63gE00tF8yIk+t1HG4f3uhZahwlUS27xjnAbxygtwTu4td6j0e0qRKCO737q/rhTQ
         xClIdjJ6NJ6o5cj5HHrC4MNizBdAcDEWxpkqgh2jehyPOb+rl9ZZJdzDSmw3GUFOz2z2
         jW/w==
X-Forwarded-Encrypted: i=1; AJvYcCXbiULVNjZf1TUVlsq81fq98uGXWTND+q7eF3GQo5ibk/Ys58RAbNYXc40of3+Ohi7GZypJHW0Ply/9APDsMRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWDEVpgF6H/vP4iEM1Y9zDEkn/pb8uQrqS5nezI54CGAcxDlzt
	RRbSwbWkskiAgyCXvHkotymnYGPF0F3j1tPGWeaeCnesTIM66KpX1vE8th1i5W2bC8Gi90PFxxy
	fU3vIyWe1jzdNETC5VYhb6MESNyxvte2g6JubHrNS
X-Gm-Gg: ASbGncvIKpLf/9WVhNhiSzK96C9VAA5xH1rWnGRhl20i6lDxKBDn3yAo9CDeBF4V5QP
	1cipjNdMe8UZwyqMJWpIkgSEBEMdGshENfUVMUD0Dtx0KztvCLFjoCJ78iP62cqqq8gMS49cfPM
	ig7fcgSYX6OBzxxovqfrMcydeQltjo287WfWb2+6xZ/6Q=
X-Google-Smtp-Source: AGHT+IGH3xRK088/aGigCzG6ro1R+tMI5O1QCI2j6QZ8uV/q0xILNZe1bTWLqDqpB/rS3XuRDvlkcRG0BXDsR/Pd4VU=
X-Received: by 2002:a05:6512:1053:b0:553:2a0f:d3d4 with SMTP id
 2adb3069b0e04-55343183e56mr3825964e87.49.1748971759242; Tue, 03 Jun 2025
 10:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-9-dmatlack@google.com>
 <CALzav=fJS69JeKa-t6ze8Sx0Nwp+y8zRMfFu0RUaCoCcZR3jYQ@mail.gmail.com>
 <aDtT7hrpxz7-3sh-@smile.fi.intel.com> <2025060148-sandpit-snore-a49c@gregkh>
In-Reply-To: <2025060148-sandpit-snore-a49c@gregkh>
From: David Matlack <dmatlack@google.com>
Date: Tue, 3 Jun 2025 10:28:52 -0700
X-Gm-Features: AX0GCFujP0e-16QvFa09xgWOmwEsXqq15-Ga6gz1ZV_Fc6rP2pMRmUKFI1xR7Uw
Message-ID: <CALzav=cJbUJaE_wHHx1YBwDd48P=4sW96mEvWv_PxPSH+viyjQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/33] vfio: selftests: Validate 2M/1G HugeTLB are
 mapped as 2M/1G in IOMMU
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Alex Williamson <alex.williamson@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Adhemerval Zanella <adhemerval.zanella@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Wei Yang <richard.weiyang@gmail.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Takashi Iwai <tiwai@suse.de>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
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

On Sun, Jun 1, 2025 at 12:45=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 31, 2025 at 10:09:34PM +0300, Andy Shevchenko wrote:
> > On Fri, May 30, 2025 at 02:12:36PM -0700, David Matlack wrote:
> > > On Fri, May 23, 2025 at 4:30=E2=80=AFPM David Matlack <dmatlack@googl=
e.com> wrote:
> >
> > ...
> >
> > > > +       if (access("/sys/kernel/debug/iommu/intel", F_OK))
> > > > +               return intel_iommu_mapping_get(bdf, iova, mapping);
> > > > +
> > >
> > > Oops, this should be !access(...).
> >
> > Hmm... Generally speaking that code is a hack. Is there any guarantee t=
hat
> > debugfs mount point is fixed to /sys/kernel/debug ?
>
> No, userspace can mount it anywhere :)
>
> But the kernel does create the mount point at /sys/kernel/debug/ by
> default, so hopefully it does end up there if it is present in the
> system, so you should be able to rely on it for testing.

I'll leave the hard-coded path in there for now then. If/when someone
wants to run these tests on a system where debugfs is mounted
somewhere else, we can change the code to find the debugfs mount point
instead. In the meantime, the test will still work on such a system,
it will just skip the mapping level assertions.

