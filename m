Return-Path: <linux-kselftest+bounces-34226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8F8ACCAA4
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 320E6188868C
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200723E324;
	Tue,  3 Jun 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N/sStnC0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BFA23D2A5
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 15:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748966062; cv=none; b=P860SEHc5on/3tfkIFEA8YYWJP9slt7YeYV0MK5hDG1HUzWi4m7agwNMhSGUWmq+bdXa9PYRSspKRxIJZMWJwa/X9EIjEfi08zBepYsO503Lb8LTYCVEB867LCcqizqQHjwaYgRJvLWRiin9k3fOJIJdzO6Geud8iPqXu8scr5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748966062; c=relaxed/simple;
	bh=qFqprFvAKfB/OKMTmvNTxYccsPSFdh5FzV8/GVSqpUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmktGcLOcpc3tT+0kI4tH4IcDpQq57K9uXeJiBCXBbJ0PgzY/cgadGxi/P81rEbr4wdkQ+8DhWpJGaYL+uF6WF3bLFOWjMMzSA7fhHqMTW9X9TCbCuDb6p2t3m6NPwNeRL7WtkSSQBypDQMIeqe0Ef+gyPhc9Mx4HifZkfnU5A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N/sStnC0; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5534f3722caso2297142e87.0
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 08:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748966059; x=1749570859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvOEkCm3v+LAEGTcWi2djmfPGG6iSEXp+wGe+oeXEzo=;
        b=N/sStnC0IHtrTK/ZDmXCzwJqqk4nu3Xi/YODY/G9qlhj6+FijIunQkN89LYWE9UKsP
         /LcHk0uD+AcRXQU8Og9VGTdj7aQ4i/L3zDmogZoBBCGTbFfYt06Mmf7IyFBx4G6+1dpF
         pjUb8Z8YXDyx8+bPA3zudrFPk6j+cUAx8KSMgYeDexOVIL5tMAFNzr5Ub43Nsk6o8ad6
         xy1bR8YzsZdTMskRzwraOeZnJHRUa8KzxQSGKUFf/dDWVZes8zL77CE2Ya+5p48op6TP
         Wz028FPYlzaF1FRcOrVvgp4xFtfS5eoFXDRzcCo5N2O+9C4Nk8/vjueb0BaYmsD1zq2L
         T/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748966059; x=1749570859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QvOEkCm3v+LAEGTcWi2djmfPGG6iSEXp+wGe+oeXEzo=;
        b=gmefXG5vRFK7eZkNXTfYTSZPHsRCbLIzOt1UlM3xx+VdJ4QjceAKbcHpCnBy4ezkgB
         I1JBN3ql8mgkz8sdaa+R77o97VwLkAnOAewxMfkBudcO+EDVOiUSP4iwbIx3jEe1fmUK
         ZlZRpLqvHUYKTHOcwRPWYPKTLHz4q8kHyirkcVGCw4rGtbrkKn7fYcIR2klCIXdqtDEs
         pYDk74KYy+GCtmgkMDW5/HAvIZrBVct+jxVjjsda7XL/tfnedPvmGaMUz4W32Hqps+3t
         ubYiz85e2dhg31MzecqwiDXSfBbcU3WHrnrWhvVVLxtiG1hp8INY+IIQGqSVz4sKv9WZ
         P72Q==
X-Forwarded-Encrypted: i=1; AJvYcCXcgtl3wGHKSOHO1wI/seuCkiA90uVMAHpV8yrHNo6Rd7WeaA5UKfKlLn4Na3NrcQGJZjI6TE0xiLLh5S3/IT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7xbQTyJkLKnorX8lY5zsPvn4EuLbCssKnbPXdKvQ1/6w8He5+
	38DGlsPAsYPvUaGJ3vHNYZZkUZ9DvDVX1B9BqAA1hLVtcAbufHa7scfgFMYpFKZ3Uhlp00m443D
	hR762c5TQOPkOwlwSTd6oER/XybIVzAjBCBMuKNOX
X-Gm-Gg: ASbGncvDr2ysC7tIWI0bCMw4SkqL9s2kLkfnyAEGwohOmMHGdIvnD8LbyJm7/e9rrcG
	bQCYHTMFmHzxqb66qdy0MUyT4vVhN/OxSlqiMR5xkHFFdlj7e8x2XbXGDbCVPiHNP6af5j7/pQe
	/qKL9+A44urf88F2fh4FcVvO8bz2ilII4exyQAvUQ4Hsw=
X-Google-Smtp-Source: AGHT+IEcwJYEAUWD09Yo0OuV1+RJiGZ1saPwpSYKdVT3gzIP7Lf/cIwTKSYvYRwzLtaPSJ4jt7ofzlMJ3EZ1CeH19yE=
X-Received: by 2002:a05:6512:6082:b0:553:2868:6358 with SMTP id
 2adb3069b0e04-55342f931cbmr3618117e87.35.1748966058809; Tue, 03 Jun 2025
 08:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523233018.1702151-1-dmatlack@google.com> <20250523233018.1702151-5-dmatlack@google.com>
 <20250602170839.4fe2a914.alex.williamson@redhat.com>
In-Reply-To: <20250602170839.4fe2a914.alex.williamson@redhat.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 3 Jun 2025 08:53:51 -0700
X-Gm-Features: AX0GCFvBjyqDrnSF5q6u_nhoxQExxlMuYYL8C4x8fVDpC5F07VxheF08Pu0HP1w
Message-ID: <CALzav=c2yBuUwsqDaAQPG1FkG+XWNrn2PfRKGJ-wk=Ddgnsa=w@mail.gmail.com>
Subject: Re: [RFC PATCH 04/33] vfio: selftests: Test basic VFIO and IOMMUFD integration
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Vinod Koul <vkoul@kernel.org>, 
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

On Mon, Jun 2, 2025 at 4:08=E2=80=AFPM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Fri, 23 May 2025 23:29:49 +0000
> David Matlack <dmatlack@google.com> wrote:
> > +int main(int argc, char *argv[])
> > +{
> > +     char *bdf;
> > +
> > +     if (argc !=3D 2) {
> > +             printf("Usage: %s bus:device:function\n", argv[0]);
>
> segment:bus:device.function?

Oops, yes. Will fix in the next version.

>
> > +             return 1;
>
> 1 or KSFT_FAIL?

Yeah KSFT_FAIL is probably the better option.

Thanks.

