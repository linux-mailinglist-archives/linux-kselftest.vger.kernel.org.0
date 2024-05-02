Return-Path: <linux-kselftest+bounces-9293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C3E8BA35E
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 00:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D501F21D75
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 22:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AB61B27D;
	Thu,  2 May 2024 22:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bv/a7IfM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269D8DDA1
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689570; cv=none; b=MOEm7OcfosYW6YthQ1qTD9gwdoHUUbyGHBHKAwn+aKyrrACxBlpIq84A2gh9FD6kYwZsSVA3Ob+gExOkeCv69OjRAcrJZ7y4IrCmMUAzR9ubPY2b9BxdLJYZ4u+Cb7lLTRaBc+8UN3b5+PlHjyCjX940mJpX6LhqHuXRtCXUM9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689570; c=relaxed/simple;
	bh=6kgJA6OklOrNUE2Q8TmR1v5wqycP1UenmSnwgIFFV3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SMMb7SyJIoXi/g2Eo09XqGivxghotb+rtL5A7Rwptxoi8W7xaBJPt5hx2ZM3JgiaToBPaRgULiAgs80vdxmvx20xem2jEt+O62tLxNLrbLHCyXPlYdq0qAydGnk1ZVh6JK23UBStRNnRPLNHoDqkzn8URsfTZGlT11Odv4xCaIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bv/a7IfM; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-233e41de0caso4363193fac.0
        for <linux-kselftest@vger.kernel.org>; Thu, 02 May 2024 15:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689567; x=1715294367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfrJLkNktZfuMB+SoJQ7DumtzHrpuMfMLiSMpOw3O3Y=;
        b=bv/a7IfMG/7RvZBf/kMwemhEE84GuBdI2TIfn4A57kihfsP7z5aVw059TZB8JGcGqD
         809i/VUAvaawEZgD6qh3OKcAl4pAoE2foIsDeBRD5/1K+ZuGNWcwF47ciiqz9+bFIHhd
         PSj1bYMlSKXFVz65LyZrcJLA1QAEPahLK/3wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689567; x=1715294367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qfrJLkNktZfuMB+SoJQ7DumtzHrpuMfMLiSMpOw3O3Y=;
        b=H6c0gmhDCbdjwE1JUltBEJkkrKsnX9mxmCsMAYYWWt8UQ+zkhe6sAFKtXOKtnGsTfi
         p8V7owxs5FJkiIJ3ptFOhX/evd9r4mTynBFU3wIdsZx+0APSX3RxLqQEQdMoOqcEYeFo
         dqJoU/CRaj8258hdkbMJT+OxIHJ79k6DfoqmCjXV1nU3PdY3pkK4E7B9o66n4UJasbex
         S+BWDBr77YRiaxR8x2lppPXjiDXitaIMnAWc/QsLnqJUaH61D74zzopmVyI7fPn02zP7
         ZjhbnfY/OKaRS8iuNflcs+ElJPDpuivdNK1zuQlEFpjU9Dp+nrRN5ht5UzERF7Q2CBS9
         Ashg==
X-Forwarded-Encrypted: i=1; AJvYcCWE78z1eK3A2OpphfDICivE5NXhFtt08Yy3CqF4+yEYCDzVe/NjzXK5S/RWY4CGGtsxVsRSM4Z2A2Zl91tWyviFQ3peorhn1p4RhFnVP4Vr
X-Gm-Message-State: AOJu0YwVq5YHQgQf0B0vZywM4V18bII9s+G5ap12t9g7Alchn4GwIbQk
	g2pi9tHI2Kg8kwcXQaOBK2FzWyt3NdREomIYKDbCUDVyKaxbhHWWfuJrMOM5NQhcKlunGxPMgyh
	icBSU2fmamXHZsmR+aZU4XU0p0RfIR7NWgTg6
X-Google-Smtp-Source: AGHT+IHVn2dULm2YcxryFkg3yP+dujD1r9smiX0/7F5nF1Oe1nfBMPF+wKK2fs/ZwboCl3pUBrUnaTcaSpGYjnGam7o=
X-Received: by 2002:a05:6870:911e:b0:23c:a6f8:9362 with SMTP id
 o30-20020a056870911e00b0023ca6f89362mr1552432oae.13.1714689567324; Thu, 02
 May 2024 15:39:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415163527.626541-1-jeffxu@chromium.org> <20240415163527.626541-4-jeffxu@chromium.org>
 <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
In-Reply-To: <f797fbde-ffb7-44b0-8af6-4ed2ec47eac1@arm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 2 May 2024 15:39:15 -0700
Message-ID: <CABi2SkXmGR41o8LwM=oD-PCZWvcc5zOie65wvuk5zsAQPymmRA@mail.gmail.com>
Subject: Re: [PATCH v10 3/5] selftest mm/mseal memory sealing
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	sroettger@google.com, willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, corbet@lwn.net, 
	Liam.Howlett@oracle.com, surenb@google.com, merimus@google.com, 
	rdunlap@infradead.org, jeffxu@google.com, jorgelo@chromium.org, 
	groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 4:24=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> On 15/04/2024 17:35, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > selftest for memory sealing change in mmap() and mseal().
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/.gitignore   |    1 +
> >  tools/testing/selftests/mm/Makefile     |    1 +
> >  tools/testing/selftests/mm/mseal_test.c | 1836 +++++++++++++++++++++++
> >  3 files changed, 1838 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/mseal_test.c
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index d26e962f2ac4..98eaa4590f11 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -47,3 +47,4 @@ mkdirty
> >  va_high_addr_switch
> >  hugetlb_fault_after_madv
> >  hugetlb_madv_vs_map
> > +mseal_test
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index eb5f39a2668b..95d10fe1b3c1 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -59,6 +59,7 @@ TEST_GEN_FILES +=3D mlock2-tests
> >  TEST_GEN_FILES +=3D mrelease_test
> >  TEST_GEN_FILES +=3D mremap_dontunmap
> >  TEST_GEN_FILES +=3D mremap_test
> > +TEST_GEN_FILES +=3D mseal_test
> >  TEST_GEN_FILES +=3D on-fault-limit
> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >  TEST_GEN_FILES +=3D thuge-gen
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > new file mode 100644
> > index 000000000000..06c780d1d8e5
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -0,0 +1,1836 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#define _GNU_SOURCE
> > +#include <sys/mman.h>
>
> I'm afraid this is causing a build error on our CI, and as a result we ar=
e not
> running any mm selftests currently.
>
> The error is here:
>
>   CC       mseal_test
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap=E2=80=
=99:
> mseal_test.c:1469:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1469 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP, 0);
>       |                                                  ^~~~~~~~~~~~~~~~
> mseal_test.c:1469:50: note: each undeclared identifier is reported only o=
nce for
> each function it appears in
> mseal_test.c: In function =E2=80=98test_seal_mremap_move_dontunmap_anyadd=
r=E2=80=99:
> mseal_test.c:1501:50: error: =E2=80=98MREMAP_DONTUNMAP=E2=80=99 undeclare=
d (first use in this
> function)
>  1501 |  ret2 =3D mremap(ptr, size, size, MREMAP_MAYMOVE | MREMAP_DONTUNM=
AP,
>       |                                                  ^~~~~~~~~~~~~~~~
>
>
> And I think the reason is due to our CI's toolchain's sys/mman.h not incl=
uding
> linux/mman.h where MREMAP_DONTUNMAP is defined.
>
> I think the fix is to explicitly #include <linux/mman.h>, as a number of =
other
> mm selftests do.
>
When I tried to build with aarch64-linux-gnu-gcc, this passed.

aarch64-linux-gnu-gcc -I ../../../../usr/include   -DDEBUG -O3
-DDEBUG -O3 mseal_test.c -o  mseal_test -lm -Wall

I don't have the exact environment to repro the issue and verify the fix.
I will send a patch with  the linux/mman.h.

I will probably need some help to verify the fix on arm build, Ryan,
could you help with this ?

Thanks
-Jeff

