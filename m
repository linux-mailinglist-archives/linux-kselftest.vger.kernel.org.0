Return-Path: <linux-kselftest+bounces-46739-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E183C94A15
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 02:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3AC3A608F
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Nov 2025 01:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D451B1F428C;
	Sun, 30 Nov 2025 01:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VqWJ3r3O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF611C84DE
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Nov 2025 01:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764465674; cv=none; b=W1WIS2vUBnyW73MEO4fYcKH5Qo1fCzrh/iXn+QlQK+ofZB45uz27hSi2JpM3IB8b1ePw9oI8y20fwlPzXCkLGLqfH6498xdh6p2cgs7IdkUmf2FfmhF2prdTEHj3jxtyM8gaAFRIAs1AbqHRDXa5036izUXbCuscU9RvRlt/ZDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764465674; c=relaxed/simple;
	bh=jAhYjdaKuYSZjBr3rUm2bCg6GZ1D33HJLbxkB+qPEuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gR45Mukot/F/BKweqsNH8L56d6YrdSo4deLkqp5HW2SUjhw2PIPE3L0/U2HQXM0TMOsNhgdnjr91r9iYnaflGbq0uJd25GhUyU4045U96OyxeAGG7xnkb1kqzD7GTkcEhMC0yRcIqbKEgLnpFA1EkaMMgOHXa93S3mav85bJiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VqWJ3r3O; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so5473341a12.1
        for <linux-kselftest@vger.kernel.org>; Sat, 29 Nov 2025 17:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1764465671; x=1765070471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7E6fYjyrHrj8FHDr7BSv9EzmTP9fSPz38dXVeQSmbss=;
        b=VqWJ3r3OV199kgmWWd4B68VywP+BhnnLiCdocCvjXG/gnMFSD1bFiG9jS8tN2BbW9h
         THrqDBGcJM9nMdqoLNvq93kNR2dLFXodP7TjzVU8p9fTvWnnirrJVk5/UWwwFNNr8NNV
         FUvsTCSuTi4WvObu+0T60al3CGnp72BoAcH7r75sxqYhYkcp9CDj59Avb9B/j6NqiZXv
         H4igEIDZGOK55pCcFF5DdXe0ZzGKZov9SnCru8TRent00f++6DyDBB/IYwgFc6lYispX
         cacaasgXhnR1GkCFZpWbC8w/YItucwEw3qeYBtel1nsAxs2h1mZbiMb3KB7hov90GvHL
         sdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764465671; x=1765070471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7E6fYjyrHrj8FHDr7BSv9EzmTP9fSPz38dXVeQSmbss=;
        b=X6fZrNIvAK8qd6QmwOrJHFM3rc1AO8cZw/ReQlK3ckDlcKU/pNZdpsZhiMjJ5PCeSb
         9vygYOQ+87wBnsf4TXipBfBE9TjfcHLPDictQSRlo1KVikPcZ65CqIVjkHqajXMrnqHU
         VugCmkwGnKrZx8yC+HICcNf6hGi8ElBpilJ602Z1Knh9UOpPQGxLBrCwGvX/pvPhGSbH
         H3mIyEu45xXJc4VIq3DiyvSanfM+LA8lde7WICxRWJblyoKQsXKnKjvaWgazHds/VNeg
         UdS+BaVrGsp5LTDjxmf6LoD//lYrsVBHPFQuFKqlUbB2zIca8Ovkr1/799PtCYKPKgLM
         D5uw==
X-Forwarded-Encrypted: i=1; AJvYcCXhcsINvhRu96O8suPMbjOShbhOslFu3Y8OHD0iGWUfphxSr1jQoSrDCJcvUYA5/7pc3Wh+wpK5XcjqXBjZr4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ2xM+Zv0rJN49XN8YExGQXFFetyatgQA1WyslqOkVXf/BQPU5
	T7mU44kgujpI/brl2kqPkXDc50cYm5jXTk2KCs67WtgnnwUCRbwGRo/dE5QJPwMGBe882HjdpK5
	r5sm3TFyDOKroZIh2g+dnPPcLNXnAdwHi84er7dWerg==
X-Gm-Gg: ASbGnct37waRUInRF4pLX1MKEQGuFnqwECoCGd5IK7KykvA3zB4oIRrWW/+9GQojE5E
	mbmGx6Qfg4NMmLNGq7i8MCC4mu/8YZMbAgnWIM6GG2RK1lmU1N6//kJgJcgEF+WPwS99jV+QKLs
	3Upah4BcNVkm+YVkTa5yaIekQzo9XrDRqiNf99zP12jyA0rxKTtzJ5O3IFtE1qa1mydS9z9FcVi
	He901+MJDrnBnDa30Yj5gxXm6ptog03feJOBdE2pvW2yluaXAUIe5Gz6yUEZtg3FCuO
X-Google-Smtp-Source: AGHT+IEVrWVW0MSDEofN7HKOGJ5FYge7stDIhKBoTb11CcnSv0VSQnPuBhKj+NsQY8Xozbru60feKYwF32lJK34nCfo=
X-Received: by 2002:a05:6402:1ed6:b0:640:9aed:6ab6 with SMTP id
 4fb4d7f45d1cf-6455468d38amr27395965a12.24.1764465671412; Sat, 29 Nov 2025
 17:21:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126193608.2678510-1-dmatlack@google.com> <20251126193608.2678510-3-dmatlack@google.com>
 <aSrMSRd8RJn2IKF4@wunner.de> <20251130005113.GB760268@nvidia.com>
In-Reply-To: <20251130005113.GB760268@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 29 Nov 2025 20:20:34 -0500
X-Gm-Features: AWmQ_bn87weFbkyc-Mkm1TN7PwvGfMaEQTTGstPfXUIJUeSyXtPiICJqz9kg5cs
Message-ID: <CA+CK2bB0V9jdmrcNjgsmWHmSFQpSpxdVahf1pb3Bz2WA3rKcng@mail.gmail.com>
Subject: Re: [PATCH 02/21] PCI: Add API to track PCI devices preserved across
 Live Update
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Lukas Wunner <lukas@wunner.de>, David Matlack <dmatlack@google.com>, 
	Alex Williamson <alex@shazbot.org>, Adithya Jayachandran <ajayachandra@nvidia.com>, Alex Mastro <amastro@fb.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Josh Hilke <jrhilke@google.com>, Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org, 
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

On Sat, Nov 29, 2025 at 7:51=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Sat, Nov 29, 2025 at 11:34:49AM +0100, Lukas Wunner wrote:
> > On Wed, Nov 26, 2025 at 07:35:49PM +0000, David Matlack wrote:
> > > Add an API to enable the PCI subsystem to track all devices that are
> > > preserved across a Live Update, including both incoming devices (pass=
ed
> > > from the previous kernel) and outgoing devices (passed to the next
> > > kernel).
> > >
> > > Use PCI segment number and BDF to keep track of devices across Live
> > > Update. This means the kernel must keep both identifiers constant acr=
oss
> > > a Live Update for any preserved device.
> >
> > While bus numbers will *usually* stay the same across next and previous
> > kernel, there are exceptions.  E.g. if "pci=3Dassign-busses" is specifi=
ed
> > on the command line, the kernel will re-assign bus numbers on every boo=
t.
>
> Stuff like this has to be disabled for this live update stuff, if the
> bus numbers are changed it will break the active use of the iommu
> across the kexec.
>
> So while what you say is all technically true, I'm not sure this is
> necessary.

I agree. However, Lukas's comment made me wonder about the future: if
we eventually need to preserve non-PCI devices (like a TPM), should we
be designing a common identification mechanism for all buses now? Or
should we settle on BDF for PCI and invent stable identifiers for
other bus types as they become necessary?

Pasha

>
> Jason

