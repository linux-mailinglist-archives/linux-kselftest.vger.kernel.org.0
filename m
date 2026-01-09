Return-Path: <linux-kselftest+bounces-48626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6032FD0B7E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 18:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 095733023535
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 17:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9E3644A6;
	Fri,  9 Jan 2026 17:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2M2r0SvV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01E623B604
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Jan 2026 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767978304; cv=none; b=MB4uIPrjrNZKuMCJUkAuAtsyAbmuV9m6CUIAisY3M/IujQyz7vZPvnQ1uNl75f4qA2YtNb7UtjCS7/qadHrAzXxPbckx2OkrMwTMYXFWSsiN8K14U8og8OdVrViNkYjTZYcO5bH1aCrpzOs/vpfZX+G3T7YIgQ6SWobgiduKFm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767978304; c=relaxed/simple;
	bh=lWvqKO0fJJBroe9AWAqol2OjERp0X7J2dN38mXAq4hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCGqM/+OMSjcUnDMcP6KhfulK9jK+yaU5mKKHSTOlF5hgTxYundge1KOWGKyhfQWIFSSlB/szimOSLdikvTl/U2zp5iYJRDtKW+XgPeumUil7Rug/dWRZKAnRHbR96Ygto2u7rU/aEIdVukewE/XiubutfSLKpcxz4dCIxGRYU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2M2r0SvV; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-93f5910b06cso1969544241.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jan 2026 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767978301; x=1768583101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iaEI0xs28SJgawQSAoXQmdI4y+9qg+NrJ13ubq6mphA=;
        b=2M2r0SvVKd7yEcenKMnZSSPJ3kLU2UO+8HyCzasN70b6AUx38LFvw0bB7qg3Pt/wA/
         5NQKpt6kiVyhJ7IDKvxNdKYI/UwywzCIQDr9jSR4taKMSh88Ydf/mkHWxIh7x1ezII9w
         QwgE7Cb+xrXkJytIFw5mM4QBB6l1YJIEOK+phejVO42m3TKNdFfJrlRckasRkni0GTFS
         rlZ9/GAQEB4p1F7LiTREixy8MLRYwTZLiPRPfBKga0bJODYpGjdaHakDZPYnbu2ZPyo5
         hzLzcSShpo3STF9NmmoCfFvj3v0Z3KJeBIpJ0+iYmLoqKs1fZ7jP9wgZiNIKz4//vYn2
         D6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767978301; x=1768583101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iaEI0xs28SJgawQSAoXQmdI4y+9qg+NrJ13ubq6mphA=;
        b=FKMsWrBu8wrvkI7C60Ep+wQiwLz26/9+plAadq4kRX6HJSEaCtGSGKkTBc8X9K3+mj
         PDfNJIwPkGLBAnHU8++GkPAjmRzY59J73CZ8vZynlZTvMTk/y+tmrEOqJKpAWPrhPShp
         MjtUkFEOTSZ/fQOINKm0du4LxGuOQVaYNs2vX/rHZyh9247zg2yl1HY2iZt9C0oc7CQL
         nuRo7+51o5bFq3x8Ww1bP5Uubjj+8ARu3/KcdS1LybyK7sqF7PyyE2+tmwHXEH+VT0fG
         xgF2d3u5M46vDsre4h+j0/8oa73M7pr4PcsQE3GRt7ubTknhoNm9q1GcbaLZ2+Oi2XzW
         rUWA==
X-Forwarded-Encrypted: i=1; AJvYcCXdw6LakKtR5gPQZYHbLexEIQa7oFSMbI9KrQ0albtZrmCQzyioyGv1I81X0Od7S+cHjEKE2O1jgLhEXqgF5Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BFV43Q5uKMsogsCw8aBVZNdKHFXoKmxBWDEa4vlMCLSGK+K0
	oXu8DtVZpIq9s3ll0ne1f8LI5g8TLQPl1gcgO81sKDjrHvCyuqfiJWMJMnPaEaVAcLOm0Z2uBmm
	P9QTAp5FbtbXEENW6GRFStM0SSuJxKdMhqCdur4vU
X-Gm-Gg: AY/fxX7K4DynMr+8sX8SLaNGoCKji5N4RcHn9yUt9jgIKEYlAYwsuQbe6uxa1UA5/K5
	B0wuG8yoULxXPW2ZefSvPP/8XX584Y79PMydrUULdO7Nadqv3YeB63Erf3+obp39VO0DNRzX9Hd
	s5hE+xgAvI7tDRTKg7BSjQrQIZtowFrSsWsbRXUq8veQRo9z6PlQKmX2stKrQOikTbdjzzoR4wj
	YmWytXx0nsvhZuPHJp3gsV7RLlIzDNWUGWecmqWwPB8PvV++5zAIl59wXFnF1ckE/WrFV7S
X-Google-Smtp-Source: AGHT+IHHNOzmGq3S4WztxxQNhzJ1I7UiChOzASqA+Z5xYHsfOj5WYv1FSHKXAH8Y4qK216a4vGNQeLYbRr9II3U/M3k=
X-Received: by 2002:a05:6122:4588:b0:55b:7494:383c with SMTP id
 71dfb90a1353d-5634639a886mr4263826e0c.7.1767978299781; Fri, 09 Jan 2026
 09:04:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aV7yIchrL3mzNyFO@google.com> <20260108005406.GA545276@ziepe.ca>
 <aV8ZRoDjKzjZaw5r@devgpu015.cco6.facebook.com> <20260108141044.GC545276@ziepe.ca>
 <20260108084514.1d5e3ee3@shazbot.org> <CALzav=eRa49+2wSqrDL1gSw8MpMwXVxb9bx4hvGU0x_bOXypuw@mail.gmail.com>
 <20260108183339.GF545276@ziepe.ca> <aWAhuSgEQzr_hzv9@google.com>
 <20260109003621.GG545276@ziepe.ca> <aWBPNHOsaP1sNvze@google.com> <20260109005440.GH545276@ziepe.ca>
In-Reply-To: <20260109005440.GH545276@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Fri, 9 Jan 2026 09:04:30 -0800
X-Gm-Features: AZwV_QhVWGYhqQIfTUYUXRtLURmLyOAP6VuLvXPKfyNrm-0dlJR4DLC4lN4ZLio
Message-ID: <CALzav=cBGkhbbyggkfaYh3wfqodxRHZKXTNdnmjoXOgwMouBuA@mail.gmail.com>
Subject: Re: [PATCH] vfio: selftests: Add vfio_dma_mapping_mmio_test
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Williamson <alex@shazbot.org>, Alex Mastro <amastro@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 4:54=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Fri, Jan 09, 2026 at 12:43:32AM +0000, David Matlack wrote:
> > On 2026-01-08 08:36 PM, Jason Gunthorpe wrote:
> > > On Thu, Jan 08, 2026 at 09:29:29PM +0000, David Matlack wrote:
> > > > On 2026-01-08 02:33 PM, Jason Gunthorpe wrote:
> > > > > On Thu, Jan 08, 2026 at 10:24:19AM -0800, David Matlack wrote:
> > > > > > > > Oh, I was thinking about a compatability only flow only in =
the type 1
> > > > > > > > emulation that internally magically converts a VMA to a dma=
buf, but I
> > > > > > > > haven't written anything.. It is a bit tricky and the type =
1 emulation
> > > > > > > > has not been as popular as I expected??
> > > > > > >
> > > > > > > In part because of this gap, I'd guess.  Thanks,
> > > > > >
> > > > > > Lack of huge mappings in the IOMMU when using VFIO_TYPE1_IOMMU =
is
> > > > > > another gap I'm aware of.
> > > > > > vfio_dma_mapping_test.vfio_type1_iommu_anonymous_hugetlb_1gb.dm=
a_map_unmap
> > > > > > fails when IOMMUFD_VFIO_CONTAINER is enabled.
> > > > >
> > > > > What is this? I'm not aware of it..
> > > >
> > > > It's one of the test cases within
> > > > tools/testing/selftests/vfio/vfio_dma_mapping_test.c.
> > > >
> > > > Here's the output when running with CONFIG_IOMMUFD_VFIO_CONTAINER=
=3Dy:
> > > >
> > > >   #  RUN           vfio_dma_mapping_test.vfio_type1_iommu_anonymous=
_hugetlb_1gb.dma_map_unmap ...
> > > >   Mapped HVA 0x7f0480000000 (size 0x40000000) at IOVA 0x0
> > > >   Searching for IOVA 0x0 in /sys/kernel/debug/iommu/intel/0000:6a:0=
1.0/domain_translation_struct
> > > >   Found IOMMU mappings for IOVA 0x0:
> > > >   PGD: 0x0000000203475027
> > > >   P4D: 0x0000000203476027
> > > >   PUD: 0x0000000203477027
> > > >   PMD: 0x00000001e7562027
> > > >   PTE: 0x00000041c0000067
> > > >   # tools/testing/selftests/vfio/vfio_dma_mapping_test.c:188:dma_ma=
p_unmap:Expected 0 (0) =3D=3D mapping.pte (282394099815)
> > > >   # dma_map_unmap: Test terminated by assertion
> > > >   #          FAIL  vfio_dma_mapping_test.vfio_type1_iommu_anonymous=
_hugetlb_1gb.dma_map_unmap
> > >
> > > I can't think of any reason this would fail, I think your tests have
> > > found a real bug?? Can you check into it, what kernel call fails and
> > > where does the kernel code come from?
> >
> > Oh I thought it was by design. This code in iommufd_vfio_set_iommu():
> >
> >       /*
> >        * The difference between TYPE1 and TYPE1v2 is the ability to unm=
ap in
> >        * the middle of mapped ranges. This is complicated by huge page =
support
> >        * which creates single large IOPTEs that cannot be split by the =
iommu
> >        * driver. TYPE1 is very old at this point and likely nothing use=
s it,
> >        * however it is simple enough to emulate by simply disabling the
> >        * problematic large IOPTEs. Then we can safely unmap within any =
range.
> >        */
> >       if (type =3D=3D VFIO_TYPE1_IOMMU)
> >               rc =3D iopt_disable_large_pages(&ioas->iopt);
> >
> > git-blame says some guy named Jason Gunthorpe wrote it :P
>
> Er, maybe I mis understood the output then?
>
> This is not a "failure" though, the map succeeded and gave a small
> page mapping.
>
> This is not reflecting a bug in iommufd but a bug in the TYPE1 support
> in VFIO itself because it definitely cannot maintain the required
> unmap anywhere semantic if it mapped in a 1G huge page like this.
>
> Basically, if you are mapping with TYPE1 mode then this should be trigger=
ed:
>
>         if (!strcmp(variant->iommu_mode, "iommufd_compat_type1"))
>                 mapping_size =3D SZ_4K;
>
> And VFIO should be the one to fail, not iommufd.
>
> If you really want to test TYPE1 you need to test what makes it
> unique, which is that you can map any VMA and then unmap any slice of
> it. Including within what should otherwise be a 1G page.
>
> But I doubt anyone cares enough to fix this, so just exclude
> VFIO_TYPE1_IOMMU from this test?

Ah, ok, thanks for the explanation. So VFIO_TYPE1_IOMMU should always
use 4K mappings regardless of backend (VFIO or iommufd) so that unmap
can work as intended.

I think excluding VFIO_TYPE1_IOMMU from this assertion makes sense if
we don't care about fixing it.

