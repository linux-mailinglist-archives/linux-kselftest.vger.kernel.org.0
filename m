Return-Path: <linux-kselftest+bounces-44112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7101C0F62F
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87B419A01D2
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 16:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069C313545;
	Mon, 27 Oct 2025 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dv8t+j1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FD1314A7A
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761583040; cv=none; b=bRzN37p0nQA1wC6QymvJPGRplsD1SCFiOc800c0SQjm46eNeoOjg5cxRGGHIeEaWueusccqP8pJn8LzDFwvGstW6b4OXIm7q0yuFZFTVmgiVFFNTiyHAOehOtzjxiZm5Gt3nlhHCB9MA4oWVMrLv34nEvGwBnVXAcKyf7z9CDyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761583040; c=relaxed/simple;
	bh=Oi6PnYKu8At7mn2r8bJbw6fE2P/LefHPpppgZI9YhB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bsV+v7SExjVuczVTCKfa+r7GRU8331oJpp2rSwTsx9pJrp/nyhAFI0HszyYq8CyIbccMcTvB5/VHz0FabbVZFl+zYGYJSu8jNIC/xwiv4kEnPvHGZGbRhWBATXpF7cEtojKfBDfbWr40LgNGcCSQ+zVO++Jv0l26yyFpibvlLTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dv8t+j1D; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ecfd66059eso2741cf.0
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761583036; x=1762187836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOy3iiebbAqjF3YwXd91msbbmKaBEHmD6+luJVRUSx4=;
        b=Dv8t+j1DH+aTBSQiYByDPRXsAZaLbYLuMTom5PppY0HeDJIoNCBNZxZbHz87wxEOkS
         hVBD0vhn9N8kLj6vB1zCswpsD6fEpbGowp2vltd+N4Z3wqu6iFEhbthX+htqm8GCzLEg
         s6ZZH6hx/6o8cSoG3AW4ta4S+d/cnzicPuKDEfuqokeKZGi5AO5JhzCI0IxDDm8IRnKV
         3a6QihF7ILWkV/KMSFbySpB5QnUNZ+HQrWn8ZT32pm2oBj7uCjlnBJvdw4242TwdzUQi
         zNV8c8FcwvgTYRVP7uCJVhEZ+vfbnmyW2iOYzBU3dHQ+fnrS/jkZciWT8vfWZDcyFclR
         yblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761583036; x=1762187836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOy3iiebbAqjF3YwXd91msbbmKaBEHmD6+luJVRUSx4=;
        b=qz0QxglqF3pcTwDPxIFzxSKzbnZE7OLqk8IG97zKsKB0t/0uJLuPTxNW3vvWh54M6T
         u5MjuS7ufwUj94ZFS1uvc7Hj+9jhYV/Hx4z4/QMXM/dtN0rS4+ulyevlYbQ49syxdbhR
         Nd61QhupWmRi121CgqsDprV9v00/0TLwgVoFkspxC02nJTJ4i2K7/iCnzZRMP6VzqM7u
         F/WLx6v5dgIYdGRpy/regKFpEekhSt/fJOOA+cEwIdbCX0mFTvcNOjXBG7QhgVmUEPiB
         ZAA9bsG5WBF+hyS17y6VIe4fvhmYQY3oY+JX6jv0Bl9tuHwDMqfoxZP5fJGqRsbt0Z9+
         mIXg==
X-Forwarded-Encrypted: i=1; AJvYcCV8AOoJTtZtBv00/0GZhFx9iSsh6iPnZC+y/0wrO3HwBNKIirUDmgKhcqM9m4YVPbYwmlqe3WFA5TeQT1Ey1pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3lvbfjzG9frNUEiPZGtCAugUogJaRK2CjcuaT8G0ZwxDavz/R
	4mcfWaYVbggtWJXHM9q2mI/1pwcg0nYMkqZsb4HatQvz0feOphSOMMUna9d+2xSosNiPh0w/2tl
	qtRh4lqX8DNRWpG6zID08KAPeOkmkLFRt8WLoz9IgmIcb2Aq1JrBsOStpUP7JxA==
X-Gm-Gg: ASbGncuCuRN5HQu5Jrw0KdG9lBeH6PKQyKnsLb2jxRLsp4GAm5JmVa5caMr+Uou3Anq
	E8bUryNNaZOx6qdyhhAIa65O8UkwB5h7kEiq+CRoTB1mcD/4H7cf9g6eY6UC/un4c/jFh5L+txL
	P/ChVWZk7/6yfCrx4BuMwBbOVinO9fljC4ljBMNkk93+IS4sIHTskQonfgr99XNGNdaohncoJw5
	LdxrwP3jD0HAKnOtiaXxMwJrTq2j2KlDRJPMNMpH0xAZymk2N/iMFWzo1tAmjHTwysM5tlnB5hv
	PzpeJZJIxds1McXx1ZU5iuNnBw==
X-Google-Smtp-Source: AGHT+IFaxIw83VYwbbIh7Erx5pfEMAgBcg1pYjNg+FGawbKps6jMbAo+rgY9Q7yMQi2Hw2U4lkBfkLGAUfTgx/d+46w=
X-Received: by 2002:a05:622a:5a97:b0:4b7:9b06:ca9f with SMTP id
 d75a77b69052e-4eba2194b2bmr16376531cf.2.1761583035660; Mon, 27 Oct 2025
 09:37:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com> <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
In-Reply-To: <2-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
From: Samiullah Khawaja <skhawaja@google.com>
Date: Mon, 27 Oct 2025 09:37:03 -0700
X-Gm-Features: AWmQ_bkrPoVQcTl-93AGiukk8qPqil6Um8n3WCq157c9AX6034wo8PiXupkuk_E
Message-ID: <CAAywjhSMnmAaS2vTcHDPfRxbSMSwmQuAUL-bgRNt+wEXi0SAZw@mail.gmail.com>
Subject: Re: [PATCH v7 02/15] genpt: Add Documentation/ files
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
	Michael Roth <michael.roth@amd.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 11:21=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> w=
rote:
>
> Add some general description and pull in the kdoc comments from the sourc=
e
> file to index most of the useful functions.
>
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  Documentation/driver-api/generic_pt.rst | 142 ++++++++++++++++++++++++
>  Documentation/driver-api/index.rst      |   1 +
>  2 files changed, 143 insertions(+)
>  create mode 100644 Documentation/driver-api/generic_pt.rst
>
> diff --git a/Documentation/driver-api/generic_pt.rst b/Documentation/driv=
er-api/generic_pt.rst
> new file mode 100644
> index 00000000000000..210d1229aa1c1f
> --- /dev/null
> +++ b/Documentation/driver-api/generic_pt.rst
> @@ -0,0 +1,142 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Generic Radix Page Table
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. kernel-doc:: include/linux/generic_pt/common.h
> +       :doc: Generic Radix Page Table
> +
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_defs.h
> +       :doc: Generic Page Table Language
> +
> +-----
> +Usage
> +-----
> +
> +Generic PT is structured as a multi-compilation system. Since each forma=
t
> +provides an API using a common set of names there can be only one format=
 active
> +within a compilation unit. This design avoids function pointers around t=
he low
> +level API.
> +
> +Instead the function pointers can end up at the higher level API (i.e.
> +map/unmap, etc.) and the per-format code can be directly inlined into th=
e
> +per-format compilation unit. For something like IOMMU each format will b=
e
> +compiled into a per-format IOMMU operations kernel module.
> +
> +For this to work the .c file for each compilation unit will include both=
 the
> +format headers and the generic code for the implementation. For instance=
 in an
> +implementation compilation unit the headers would normally be included a=
s
> +follows::
> +
> +generic_pt/fmt/iommu_amdv1.c::
> +
> +       #include <linux/generic_pt/common.h>
> +       #include "defs_amdv1.h"
> +       #include "../pt_defs.h"
> +       #include "amdv1.h"
> +       #include "../pt_common.h"
> +       #include "../pt_iter.h"
> +       #include "../iommu_pt.h"  /* The IOMMU implementation */
> +
> +iommu_pt.h includes definitions that will generate the operations functi=
ons for
> +map/unmap/etc. using the definitions provided by AMDv1. The resulting mo=
dule
> +will have exported symbols named like pt_iommu_amdv1_init().
> +
> +Refer to drivers/iommu/generic_pt/fmt/iommu_template.h for an example of=
 how the
> +IOMMU implementation uses multi-compilation to generate per-format ops s=
tructs
> +pointers.
> +
> +The format code is written so that the common names arise from #defines =
to
> +distinct format specific names. This is intended to aid debuggability by
> +avoiding symbol clashes across all the different formats.
> +
> +Exported symbols and other global names are mangled using a per-format s=
tring
> +via the NS() helper macro.
> +
> +The format uses struct pt_common as the top-level struct for the table,
> +and each format will have its own struct pt_xxx which embeds it to store
> +format-specific information.
> +
> +The implementation will further wrap struct pt_common in its own top-lev=
el
> +struct, such as struct pt_iommu_amdv1.
> +
> +----------------------------------------------
> +Format functions at the struct pt_common level
> +----------------------------------------------
> +
> +.. kernel-doc:: include/linux/generic_pt/common.h
> +       :identifiers:
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_common.h
> +
> +-----------------
> +Iteration Helpers
> +-----------------
> +
> +.. kernel-doc:: drivers/iommu/generic_pt/pt_iter.h
> +
> +----------------
> +Writing a Format
> +----------------
> +
> +It is best to start from a simple format that is similar to the target. =
x86_64
> +is usually a good reference for something simple, and AMDv1 is something=
 fairly
> +complete.
> +
> +The required inline functions need to be implemented in the format heade=
r.
> +These should all follow the standard pattern of::
> +
> + static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
> + {
> +       [..]
> + }
> + #define pt_entry_oa amdv1pt_entry_oa
> +
> +where a uniquely named per-format inline function provides the implement=
ation
> +and a define maps it to the generic name. This is intended to make debug=
 symbols
> +work better. inline functions should always be used as the prototypes in
> +pt_common.h will cause the compiler to validate the function signature t=
o
> +prevent errors.
> +
> +Review pt_fmt_defaults.h to understand some of the optional inlines.
> +
> +Once the format compiles then it should be run through the generic page =
table
> +kunit test in kunit_generic_pt.h using kunit. For example::
> +
> +   $ tools/testing/kunit/kunit.py run --build_dir build_kunit_x86_64 --a=
rch x86_64 --kunitconfig ./drivers/iommu/generic_pt/.kunitconfig amdv1_fmt_=
test.*
> +   [...]
> +   [11:15:08] Testing complete. Ran 9 tests: passed: 9
> +   [11:15:09] Elapsed time: 3.137s total, 0.001s configuring, 2.368s bui=
lding, 0.311s running
> +
> +The generic tests are intended to prove out the format functions and giv=
e
> +clearer failures to speed up finding the problems. Once those pass then =
the
> +entire kunit suite should be run.
> +
> +---------------------------
> +IOMMU Invalidation Features
> +---------------------------
> +
> +Invalidation is how the page table algorithms synchronize with a HW cach=
e of the
> +page table memory, typically called the TLB (or IOTLB for IOMMU cases).
> +
> +The TLB can store present PTEs, non-present PTEs and table pointers, dep=
ending
> +on its design. Every HW has its own approach on how to describe what has=
 changed
> +to have changed items removed from the TLB.
> +
> +PT_FEAT_FLUSH_RANGE
> +-------------------
> +
> +PT_FEAT_FLUSH_RANGE is the easiest scheme to understand. It tries to gen=
erate a
> +single range invalidation for each operation, over-invalidating if there=
 are
> +gaps of VA that don't need invalidation. This trades off impacted VA for=
 number
> +of invalidation operations. It does not keep track of what is being inva=
lidated;
> +however, if pages have to be freed then page table pointers have to be c=
leaned
> +from the walk cache. The range can start/end at any page boundary.
> +
> +PT_FEAT_FLUSH_RANGE_NO_GAPS
> +---------------------------
> +
> +PT_FEAT_FLUSH_RANGE_NO_GAPS is similar to PT_FEAT_FLUSH_RANGE; however, =
it tries
> +to minimize the amount of impacted VA by issuing extra flush operations.=
 This is
> +useful if the cost of processing VA is very high, for instance because a
> +hypervisor is processing the page table with a shadowing algorithm.
> diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-ap=
i/index.rst
> index 3e2a270bd82826..baff96b5cf0ba4 100644
> --- a/Documentation/driver-api/index.rst
> +++ b/Documentation/driver-api/index.rst
> @@ -93,6 +93,7 @@ Subsystem-specific APIs
>     frame-buffer
>     aperture
>     generic-counter
> +   generic_pt
>     gpio/index
>     hsi
>     hte/index
> --
> 2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

