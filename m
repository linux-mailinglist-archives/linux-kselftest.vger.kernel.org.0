Return-Path: <linux-kselftest+bounces-44037-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E105BC0927A
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 17:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619C73B36DE
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 15:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1430216B;
	Sat, 25 Oct 2025 15:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="WTB3GKBe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6F302168
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761405249; cv=none; b=e7gAG6GpYFsSmX7RSX5ZtXBdc9OMmLHtLy7JI2oEejAUYJFp+4n+JV3pY/7Ecz1arrDpos2GVs2+FKCwVIlrQXhubVqOGfdxebAz8PWDdPfj6jzzCK2tarzTPAvr3w+ceFVRsRuahi4qBY9jSXzekxUgSWiAePqTBOaRs3oi3uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761405249; c=relaxed/simple;
	bh=CL675AwnhszTvchkoKww0pB3s+a1NTfUgwGopybj9qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z8nX9amndPSIEAU4LSWhVWFYkGsZaVraLF/g35JEBF2P4HNItlU4TK2TVWVae1sP9sjjuAJBoUlnKRB2r19YegYdoPA6/Ydt4+sRkwdyyxnzpFA/w/CcoxOxqboggAfJL/Iq0HatYe2HzzwGCvE9nN9q7EKTBe+Ma22zqiyhKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=WTB3GKBe; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b4539dddd99so644492966b.1
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 08:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761405245; x=1762010045; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r6ZApRvRb7vW0G2zoc1eEE/W2po0au9F5FmCvI0sheY=;
        b=WTB3GKBeQ0XMTvoXW/0ZAG0fhKeXR/FCky3f915ORuCAEXsWSYsbjVSo5fNn3E63gl
         MDPMsMmGkN9SidSbG1Nr/a7APAuzkX8XfLaLWgzbCZeW9W0tWyJw4P9p0zOfMWzb/R+I
         kLAVaqXYBqy0iB9jtAcWEEeLqS33c70MAP5Ah0mE/r0ZPKjgGkPW7xvInM4enInFCC6g
         B8dcvkmW9Emah5gnmFwtHHO6JVY7nb7EG5DIwH8Ij8Fcfg40k+c1/H1LsoIirInOhMs/
         cQaIi4x0OJvw4H1HCxYL/Loi+eLVXx7VsU4cgUJudSqFX+oEss5dWRFhPYtHS7Ou4oAW
         qkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761405245; x=1762010045;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r6ZApRvRb7vW0G2zoc1eEE/W2po0au9F5FmCvI0sheY=;
        b=DxumTUms6ZNpKx2kYorPXisE8HSlBkRCYXuxGeQ42jSKCOAtKUB0mOFk3c4/xLJk9b
         KjrLivW8fv1ugD0CEUSRsv1q3PSY8XAhr6vQ+ZvvYY/8fv0j1MdCXkiRuuuCsnBf1HPO
         f7TNHWw6PjMj5F3/opDqkyPcIoxYAAbr3hqJTjVUi25KZj/7vPgid8ghY0MxCiquBBwV
         K/oFUZDDmMisRT9PhcXZagpogTtFkbY8qMTaEGljEGDn7VZ0ofyhAwzfDR2mlSH8G02k
         iqs3uvRX1vOIL3EbOAPKyI0Xj3WLL1q72mkGJrTgxDbHMyXkGPIf0dmXF9T1/+Jf4f7L
         acmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwS+RyP0q4NHAmd8hN12dVfdVZ9t2Cv7pMQUmHi9iT2QHRSe6UKsI95Gr+PQTeulYTAmEv0QyeiITXSoak/j0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpEhR9tP+/OCM3asnrOCxbT1E2bUKXt2FoVQAd/MpEHPNguEFE
	TtKkrXAXavBVn4gSso9BDL+wSgKFTtr6wD5x2CuFxTWmOb0WeB9hLXvV1CQxZZIaw3TM5xLnZez
	qz0zS5qfT4YpH4UiWIbUQENZxNcB136Cc4PL9wVAz4w==
X-Gm-Gg: ASbGncs+XZUOMn3eSHLMvvTiOJEZRW/zrBZmOSc6nVBV5+gMzD/xv8rtpEu6pxF+c0L
	BWcb6nLkBcQTjjX9iu4Za348h0nQMZorfci0y0XrD3NNPtG857zSMCeM+icpt49bh2g3gSowiuK
	PaM93E1SnO5zB8RALfTa8BV4i8bj+UYJXt/BqAKf/C2TbilmYTq0i0jfxAng+rIbyXBTW8y9GfL
	jLy1fefbYIPuHkpT8BrlWWZSDcWJMCMFWBHx9AFcbNFF8q2MbecXhj0UTdVvZKyB357FZDCzACp
	8ngazGOz0qHfi/b+LWJuxxFSGYSB
X-Google-Smtp-Source: AGHT+IHaV1ZPy0NcxBjvZpBvRmdUs/H93j26P98BKr5SgBmvXnyMy41VvCYN1RoSAKCw4YXmnyQMwoR6KSlG6St14Q0=
X-Received: by 2002:a17:907:86a0:b0:b3f:f822:2db2 with SMTP id
 a640c23a62f3a-b6d51aeff2amr1161620066b.11.1761405244508; Sat, 25 Oct 2025
 08:14:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <1-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <1-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Sat, 25 Oct 2025 11:13:28 -0400
X-Gm-Features: AWmQ_bnwA61ouglJ0muhK3QYt2JBH2l0zMaAEi3nbw0px0nYabPLbrggddVDt6k
Message-ID: <CA+CK2bB8JTN8qcSumb_tmY2gzmbahoDCeWS88W-Fh7P68pDhjg@mail.gmail.com>
Subject: Re: [PATCH v7 01/15] genpt: Generic Page Table base API
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Anup Patel <anup@brainfault.org>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	llvm@lists.linux.dev, Bill Wendling <morbo@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>, 
	Alexey Kardashevskiy <aik@amd.com>, Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>, 
	Michael Roth <michael.roth@amd.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 2:21=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> The generic API is intended to be separated from the implementation of
> page table algorithms. It contains only accessors for walking and
> manipulating the table and helpers that are useful for building an
> implementation. Memory management is not in the generic API, but part of
> the implementation.
>
> Using a multi-compilation approach the implementation module would includ=
e
> headers in this order:
>
>   common.h
>   defs_FMT.h
>   pt_defs.h
>   FMT.h
>   pt_common.h
>   IMPLEMENTATION.h
>
> Where each compilation unit would have a combination of FMT and
> IMPLEMENTATION to produce a per-format per-implementation module.
>
> The API is designed so that the format headers have minimal logic, and
> default implementations are provided if the format doesn't include one.
>
> Generally formats provide their code via an inline function using the
> pattern:
>
>   static inline FMTpt_XX(..) {}
>   #define pt_XX FMTpt_XX
>
> The common code then enforces a function signature so that there is no
> drift in function arguments, or accidental polymorphic functions (as has
> been slightly troublesome in mm). Use of function-like #defines are
> avoided in the format even though many of the functions are small enough.
>
> Provide kdocs for the API surface.
>
> This is enough to implement the 8 initial format variations with all of
> their features:
>  * Entries comprised of contiguous blocks of IO PTEs for larger page
>    sizes (AMDv1, ARMv8)
>  * Multi-level tables, up to 6 levels. Runtime selected top level
>  * The size of the top table level can be selected at runtime (ARM's
>    concatenated tables)
>  * The number of levels in the table can optionally increase dynamically
>    during map (AMDv1)
>  * Optional leaf entries at any level
>  * 32 bit/64 bit virtual and output addresses, using every bit
>  * Sign extended addressing (x86)
>  * Dirty tracking
>
> A basic simple format takes about 200 lines to declare the require inline
> functions.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

