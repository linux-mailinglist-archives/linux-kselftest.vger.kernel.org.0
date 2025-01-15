Return-Path: <linux-kselftest+bounces-24598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77AFA12CF1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 21:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFD716505F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5971D90BC;
	Wed, 15 Jan 2025 20:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhwgdOKz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402261DA103
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736974066; cv=none; b=HO94bRP9bILFmA56+uCBCfjWHgpLRVzHAV0eEs1SuNlna0hvE+x59sdthO4OOz1vsbyMRtkVv4qnOdzMVZ+fDFO1lJwxqzD3JATS2pvz83MAPIuqVQLzUq1nhgCTrPIbE4PFshrll3svRzvQNxwmpZH/82AgBzREiw9iU6dl6hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736974066; c=relaxed/simple;
	bh=YENfUkzbzqD2fmVIpk7p4rPO7OFBiLGKNUYYsR1XbeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkln7jdecreLzkzv/ZUah5kzx2QHRnK8ShxcueJRy359g3NPb0Pn27yjOpSjyYlBsIuloe9/4ejuVHCR2Uq4vJ4JiKamhu4RzR0Vw/4jB5zQLHrZuGu9Ck9HZKFHsEyTHu/bMAOjLwJiFYHbs1FXfVqcCA1deLZx/cR7OmhS4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AhwgdOKz; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2a890f85cb1so2771fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Jan 2025 12:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736974061; x=1737578861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvVBQjaZLw0Wy2oH/j71QStboTFh2zLn+D266xrEsvg=;
        b=AhwgdOKzNS74raZMsGfeburSN7ixzWu72fNQDYds2tnuGmSgz+Pg/N/Pvx6zkUZ+0Q
         UXDN3df/fyE3dcWzhO6L2j2+BPwWnA8v8acm+qywI/uo2LplRO9bpwpyyaws1DpJzuPC
         o3fdCdB7UtgpOIQkes/IzyZuqXLob227tN7co=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736974061; x=1737578861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XvVBQjaZLw0Wy2oH/j71QStboTFh2zLn+D266xrEsvg=;
        b=vi0+dQkN/ryw0/lhhqqkkGJbD7cXXWWdJulTd9NK/cttQiVfnv78lTr1pBN9pzaZDD
         XMQ1kzDJ5BR5GxvuBKPP51Pak5qAxl62wVQdlImr0exLj5UXfKk2SZgNq3FiR7CPEWu8
         eBxsDbsBUzP73UlkKaIu3M9iHKHgOvGFez+WSi+LcBupnld7iG6ZHgXvrwbYTWe0T52L
         xurZAb7csYc+cjjYV3xet8YPdLMXrWKZ/GLumQ2FB+pz5ac9lb7/7pxQsdfSUQ7UCmUR
         CzpE/MFpVS+oRae0DrrG5bNja7LM6YyFAb+fd2raffTIG0ixd1IrOpEocfrNxXrYzz3h
         JXyg==
X-Forwarded-Encrypted: i=1; AJvYcCXi8EClxTogmfK3MHNYQAqgwAwp5O0dcNlEGxla+mgS1UnDJJ7CaZNIpJt4Wb1Aa2IKuRfzgXRgPvOAbXXpVxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZi8SoH8ebopxvxkJsyqywIL81KkXZyV5SFODisb4EC05tqS5C
	0u5wxf4yRC1DSQ9rWzymY/VzLZm30K2L5bqaF1UVFmdpg4+s10cQ07dtytUKWAnbCZecdMuD6YW
	N9qAHYOhXedizCVcFsChElokEns9A0FRiBrNJ
X-Gm-Gg: ASbGncsiCspzs5Kc6UHxQpb4CFYTTPjrfafW/eRvtB5Vk3QnyP4jcMWCy92O50zofMs
	C9Pt7utqkskOvwuao8qPwJA5S5stosE7IYyk66w==
X-Google-Smtp-Source: AGHT+IFqZQVR5t6x++9jzFdlM+EB7r+ptS9ZY4gNv6QzpwKvn69g3tFZEk1VSK5JKyEoxH+9k/SrEuj3i6irPd/1NfM=
X-Received: by 2002:a05:6870:1602:b0:29e:3d1c:24cb with SMTP id
 586e51a60fabf-2aa068f27f0mr6187756fac.11.1736974060889; Wed, 15 Jan 2025
 12:47:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211053311.245636-1-jeffxu@google.com> <20241211053311.245636-2-jeffxu@google.com>
 <e81dba68-ee9b-42ea-911a-4eca907c8f6a@lucifer.local>
In-Reply-To: <e81dba68-ee9b-42ea-911a-4eca907c8f6a@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 15 Jan 2025 12:47:27 -0800
X-Gm-Features: AbW1kvYyyJCXrPXnWuYMfz2GGufl0qkJqlL8U8yiLRAfZfv9b9Ss0wzeynbHVnk
Message-ID: <CABi2SkXKW2EGPE9BV9j+c5tzxj8a1t2iXy7ckZTCNW_ZniC-hw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] selftest/mm: refactor mseal_test
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Kees Cook <keescook@chromium.org>, 
	Pedro Falcato <pedro.falcato@gmail.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jann Horn <jannh@google.com>, Jeff Xu <jeffxu@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

On Thu, Jan 2, 2025 at 9:30=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Sorry for delay, was super busy leading up to xmas break, then had ~2.5
> weeks off.
>
Thanks for reviewing.  There are lots of comments, so it takes some
time to go through comments and experiment with some of the suggested
changes. Please see below.

> And happy new year! :)
>
Happy new year !

> On Wed, Dec 11, 2024 at 05:33:11AM +0000, jeffxu@chromium.org wrote:
> > From: Jeff Xu <jeffxu@chromium.org>
> >
> > This change creates the initial version of memorysealing.c.
> >
> > The introduction of memorysealing.c, which replaces mseal_test.c and
>
> I mean I don't want to be a pain but I would kinda prefer to have 'mseal'
> everywhere mseal is to avoid confusion vs. memfd seals.
>
As I tried to explain, the memorysealing.c will eventually replace
mseal_test.c, after all the tests are moved to use kselftest_karness.
How about mseal_test_new.c ? I'm open to new names if you have one.

> Of course we in the kernel absolutely _love_ to overload the meaning of t=
erms
> but some traditions are worth breaking :)
>
> > uses the kselftest_harness, aims to initiate a discussion on using the
> > selftest harness for memory sealing tests. Upon approval of this
> > approach, the migration of tests from mseal_test.c to memorysealing.c
> > can be implemented in a step-by-step manner.
>
> Well, I for one like this approach so (unsurprisingly) :) but perhaps
> sensible to do it iteratively so we can also tweak things as we go.
>
Yes, that is the idea.

> >
> > This tests addresses following feedback from previous reviews:
> >
> > 1> Use kselftest_harness instead of custom macro, such as EXPECT_XX,
> > ASSERT_XX, etc.  (Lorenzo Stoakes, Mark Brown) [1]
> >
> > 2> Use MAP_FAILED to check the return of mmap (Lorenzo Stoakes).
>
> Thanks!
>
> >
> > 3>  Adding a check for vma size and prot bits. The discussion for
> >     this can be found in [2] [3], here is a brief summary:
> >     This is to follow up on Pedro=E2=80=99s in-loop change (from
> >     can_modify_mm to can_modify_vma). When mseal_test is initially
> >     created, they have a common pattern:  setup memory layout,
> >     seal the memory, perform a few mm-api steps, verify return code
> >     (not zero).  Because of the nature of out-of-loop,  it is sufficien=
t
> >     to just verify the error code in a few cases.
> >
> >     With Pedro's in-loop change, the sealing check happens later in the
> >     stack, thus there are more things and scenarios to verify. And ther=
e
> >     was feedbacks to me that mseal_test should be extensive enough to
> >     discover all regressions. Hence I'm adding check for vma size and p=
rot
> >     bits.
> >
> > In this change: we created two fixtures:
> >
> > Fixture basic:   This creates a single VMA, the VMA has a
> > PROT_NONE page at each end to prevent auto-merging.
> >
> > Fixture wo_vma: Two VMAs back to end, a PROT_NONE page at each
> > end to prevent auto-merging.
> >
> > In addition, I add one test (mprotec) in each fixture to demo the tests=
.
> >
> > [1] https://lore.kernel.org/all/20240830180237.1220027-5-jeffxu@chromiu=
m.org/
> > [2] https://lore.kernel.org/all/CABi2SkUgDZtJtRJe+J9UNdtZn=3DEQzZcbMB68=
5P=3D1rR7DUhg=3D6Q@mail.gmail.com/
> > [3] https://lore.kernel.org/all/2qywbjb5ebtgwkh354w3lj3vhaothvubjokxq5f=
hyri5jeeton@duqngzo3swjz/
> >
> > Signed-off-by: Jeff Xu <jeffxu@chromium.org>
> > ---
> >  tools/testing/selftests/mm/.gitignore      |   1 +
> >  tools/testing/selftests/mm/Makefile        |   1 +
> >  tools/testing/selftests/mm/memorysealing.c | 182 +++++++++++++++++++++
> >  tools/testing/selftests/mm/memorysealing.h | 116 +++++++++++++
> >  tools/testing/selftests/mm/mseal_test.c    |  67 +-------
> >  5 files changed, 301 insertions(+), 66 deletions(-)
> >  create mode 100644 tools/testing/selftests/mm/memorysealing.c
> >  create mode 100644 tools/testing/selftests/mm/memorysealing.h
> >
> > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/self=
tests/mm/.gitignore
> > index a51a947b2d1d..982234a99f20 100644
> > --- a/tools/testing/selftests/mm/.gitignore
> > +++ b/tools/testing/selftests/mm/.gitignore
> > @@ -57,3 +57,4 @@ hugetlb_dio
> >  pkey_sighandler_tests_32
> >  pkey_sighandler_tests_64
> >  guard-pages
> > +memorysealing
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index 93a46ac633df..08876624f46d 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -67,6 +67,7 @@ TEST_GEN_FILES +=3D map_populate
> >  ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
> >  TEST_GEN_FILES +=3D memfd_secret
> >  endif
> > +TEST_GEN_FILES +=3D memorysealing
> >  TEST_GEN_FILES +=3D migration
> >  TEST_GEN_FILES +=3D mkdirty
> >  TEST_GEN_FILES +=3D mlock-random-test
> > diff --git a/tools/testing/selftests/mm/memorysealing.c b/tools/testing=
/selftests/mm/memorysealing.c
> > new file mode 100644
> > index 000000000000..e10032528b64
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/memorysealing.c
> > @@ -0,0 +1,182 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +#define _GNU_SOURCE
> > +#include "../kselftest_harness.h"
> > +#include <asm-generic/unistd.h>
> > +#include <errno.h>
> > +#include <syscall.h>
> > +#include "memorysealing.h"
> > +
> > +/*
> > + * To avoid auto-merging, create a VMA with PROT_NONE pages at each en=
d.
> > + * If unsuccessful, return MAP_FAILED.
> > + */
> > +static void *setup_single_address(int size, int prot)
>
> Nitty, but size should really be an unsigned long.
>
sure, thanks

> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
>
> Trivial, but we store page size in self->page_size so why not pass it as =
a
> parameter instead of looking up?
>
sure.

> > +
> > +     ptr =3D mmap(NULL, size + 2 * page_size, prot,
> > +             MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
> > +
> > +     if (ptr =3D=3D MAP_FAILED)
> > +             return MAP_FAILED;
> > +
> > +     /* To avoid auto-merging, change to PROT_NONE at each end. */
> > +     ret =3D sys_mprotect(ptr, page_size, PROT_NONE);
> > +     if (ret !=3D 0)
> > +             return MAP_FAILED;
> > +
> > +     ret =3D sys_mprotect(ptr + size + page_size, page_size, PROT_NONE=
);
> > +     if (ret !=3D 0)
> > +             return MAP_FAILED;
> > +
> > +     return ptr + page_size;
> > +}
>
> This could be done more easily with a single PROT_NONE, like:
>
>         static void *setup_single_address(unsigned long size, int prot,
>                         unsigned long page_size)
>         {
>                 void *ptr;
>
>                 /* Ensure we only merge what we intend to. */
>                 ptr =3D mmap(NULL, size + 2 * page_size, PROT_NONE,
>                            MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>                 if (ptr =3D=3D MAP_FAILED)
>                         return MAP_FAILED;
>
>                 return mmap(&ptr[page_size], size, prot,
>                             MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>         }
>
sure, create PROT_NONE mapping first, then use mprotect to change the
middle part.

> It's probably worth having an equivalent freeing function to avoid leaks:
>
>         static int free_single_address(void *ptr, unsigned long size,
>                         unsigned long page_size)
>         {
>                 /* Also free the PROT_NONE sentinels. */
>                 return munmap(ptr - page_size, size + 2 * page_size);

[resp 1] could you clarify? I think we won't need freeing because
mapping will be sealed. You might recall, mseal() blocks munmap(), and
munmap() is atomic,  so the above line that you suggested will result
in no-action during FIXTURE_TEARDOWN. There will be separate test
cases to test munmap under sealing. In addition, the virtual address
space is big enough for this test complete without worry about the
out-of-memory situation. Do I miss anything ?

>         }
>
> > +
> > +FIXTURE(basic)
> > +{
> > +     unsigned long page_size;
> > +     unsigned long size;
> > +     void *ptr;
> > +};
> > +
> > +/*
> > + * Setup for basic:
> > + * Single VMA with 4 pages, prot =3D (PROT_READ | PROT_WRITE).
> > + */
> > +FIXTURE_SETUP(basic)
> > +{
> > +     int prot;
> > +
> > +     self->page_size =3D getpagesize();
> > +
> > +     if (!mseal_supported())
> > +             SKIP(return, "mseal is not supported");
> > +
> > +     /* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRI=
TE. */
> > +     self->size =3D self->page_size * 4;
> > +     self->ptr =3D setup_single_address(self->size, PROT_READ | PROT_W=
RITE);
> > +     EXPECT_NE(self->ptr, MAP_FAILED);
> > +
> > +     EXPECT_EQ(self->size, get_vma_size(self->ptr, &prot));
>
> I mean fine but this check seems a bit overkill here, we don't need to
> check to ensure that PROT_NONE works.
>
[resp 2] Those checks are there,  for the same reason that test cases
usually check the return value of mmap(), mprotect() in the
FIXTURE_SETUP. You are right that those calls are unlikely to fail,
however, test cases generally do those  "housekeeping tasks"  to make
sure everything is OK before  the actual test. If you don't want to
keep those, what is the downside of keeping them ?

> > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
>
> Nitty, but this seems a bit 'Yoda style', that is placing the expectation
> prior to the value whose expectation we are assessing, that is perhaps it=
'd
> be clearer as:
>
>         EXPECT_EQ(prot, PROT_READ | PROT_WRITE);
>
[resp 3] Both styles are used in self tests and I believe it is
equally clear,  I can accommodate this request for this patch.

> And again, I think this is really overkill here, if the kernel is unable =
to
> do an ordinary mapping correctly we have bigger problems than an mseal bu=
g!
>
please see [resp 2]

> > +};
> > +
> > +FIXTURE_TEARDOWN(basic)
> > +{
>
> Probably worth adding munmap() teardown here.
>
please see [resp 1]

> > +}
> > +
> > +FIXTURE(two_vma)
> > +{
> > +     unsigned long page_size;
> > +     unsigned long size;
> > +     void *ptr;
> > +};
> > +
> > +/*
> > + * Setup for two_vma:
> > + * Two consecutive VMAs, each with 2 pages.
> > + * The first VMA:  prot =3D PROT_READ.
> > + * The second VMA: prot =3D (PROT_READ | PROT_WRITE).
> > + */
> > +FIXTURE_SETUP(two_vma)
> > +{
> > +     int prot;
> > +     int ret;
> > +
> > +     self->page_size =3D getpagesize();
> > +
> > +     if (!mseal_supported())
> > +             SKIP(return, "mseal is not supported");
> > +
> > +     /* Create a single VMA with 4 pages, prot as PROT_READ | PROT_WRI=
TE. */
> > +     self->size =3D getpagesize() * 4;
> > +     self->ptr =3D setup_single_address(self->size, PROT_READ | PROT_W=
RITE);
> > +     EXPECT_NE(self->ptr, MAP_FAILED);
> > +
> > +     /* Use mprotect to split as two VMA. */
> > +     ret =3D sys_mprotect(self->ptr, self->page_size * 2, PROT_READ);
> > +     ASSERT_EQ(ret, 0);
> > +
>
> > +     /* Verify the first VMA is 2 pages and prot bits */
> > +     EXPECT_EQ(self->page_size * 2, get_vma_size(self->ptr, &prot));
> > +     EXPECT_EQ(PROT_READ, prot);
> > +
> > +     /* Verify the second VMA is 2 pages and prot bits */
> > +     EXPECT_EQ(self->page_size * 2,
> > +             get_vma_size(self->ptr + self->page_size * 2, &prot));
> > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
>
> Again, as with the prior fixture, it seems a bit overkill, as this is
> essentially testing 'does mmap() and mprotect()' work. We should hope so =
:)
Please see [resp 2]

> > +};
> > +
> > +FIXTURE_TEARDOWN(two_vma)
> > +{
>
> Same comment as for the basic fixture - let's clean up after ourselves.
>
please see [resp 1]

> > +}
> > +
> > +/*
> > + * Verify mprotect is blocked.
> > + */
> > +TEST_F(basic, mprotect_basic)
> > +{
> > +     int ret;
> > +     unsigned long size;
> > +     int prot;
> > +
> > +     /* Seal the mapping. */
> > +     ret =3D sys_mseal(self->ptr, self->size, 0);
> > +     ASSERT_EQ(ret, 0);
> > +
> > +     /* Verify mprotect is blocked. */
> > +     ret =3D sys_mprotect(self->ptr, self->size, PROT_READ);
> > +     EXPECT_GT(0, ret);
>
> Yeah this one is kinda egregious, this is genuinely hard to read. Wouldn'=
t
> this be better as:
>
>         EXPECT_NE(ret, 0);
>
> As it explicitly says 'not equal to a success case'. Rather than 'wait 0 =
is
> _greater than_ the result which means the result is _less than_ 0 which
> means an error but let me check the man page can it be positive, oh ok it=
's
> -1 on error, 0 on success', which was the Lorenzo thought process... :)
>
[resp 4] The man page says: "On success, mprotect() and
pkey_mprotect() return zero.  On error, these system calls return -1,
and errno is set to indicate the error."

I wll switch EXPECT_EQ(ret, -1) which is precisely what the man page says.

> > +     EXPECT_EQ(EPERM, errno);
>
> Let's invert these, Yoda style isn't really useful here and is a little
> harder to read, e.g. we should do:
>
>         EXPECT_EQ(errno, EPERM);
>
please see [resp 3]

> > +
> > +     /* Verify the VMA (sealed) isn't changed */
> > +     size =3D get_vma_size(self->ptr, &prot);
> > +     EXPECT_EQ(self->size, size);
> > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
>
> Again, no to Yoda :)
>
please see [resp 3]

> I also wonder how useful this is - I guess belts + braces, and linux _can=
_
> do partial failures, but is that something we would care about in practic=
e?
>
[resp 5]
Those checks will help to detect regression, such as  when Pedro
Falcato implemented in-loop change [1]. Liam R. Howlett also commented
that mseal_test should be extensive enough to check for size and prot
to avoid future regression [2]

For your question about partial failure, there will be additional
tests for partial-sealed-address range, and those will check the
sealed mapping only.

> > +}
> > +
> > +/*
> > + * Seal both VMAs in one mseal call.
> > + * Verify mprotect is blocked on both VMAs in various cases.
> > + */
> > +TEST_F(two_vma, mprotect)
>
> I'm guessing you aren't necessarily covering _all_ mprotect cases here
> (though perhaps you intend to later, iteratively?)
>
Yes.

> > +{
> > +     int ret;
> > +     int prot;
> > +     unsigned long size;
>
> I think 'size' is a bit confusing as it refers to the size ascertained fr=
om
> the get_vma_size() later on. Perhaps call it actual_size?
>
To help  readability, I will change size to vma_size, which
corresponds to the return of get_vma_size().

> Maybe worth adding:
>
>         void *ptr =3D self->ptr;
>         unsigned long size =3D self->size;
>         unsigned long page_size =3D self->page_size;
>
> For convenience?
>
> This is totally optional though, maybe more effort than it's worth.
>
I don't think it is worth it.

> > +
> > +     /* Seal both VMAs in one mseal call. */
> > +     ret =3D sys_mseal(self->ptr, self->size, 0);
> > +     ASSERT_EQ(ret, 0);
> > +
> > +     /* Verify mprotect is rejected on the first VMA. */
> > +     ret =3D sys_mprotect(self->ptr, self->page_size * 2,
> > +             PROT_READ | PROT_EXEC);
>
> Why PROT_READ | PROT_EXEC? Is this arbitrary? To be thorough shouldn't yo=
u
> loop through all of the prot flags that you think should fail? And perhap=
s
> check what happens if you mprotect() the VMA to set it to what it already
> is?
>
[resp 6]
Not arbitrary. As commented in FIXTURE_SETUP, the first VMA is
PROT_READ, and the second VMA is PROT_READ | PROT_WRITE.   The test
wants to use mprotect to change the proc bit to a different set.

For your question about mprotect() the sealed vma to what it already
is (doesn't change any attribute), I don't want to solidify the
current behavior (which is to block). It should be successful instead.
With in-loop check and partial update behavior,  there is no reason to
block it, i.e. no security benefit. I already plan to address this.

> > +     EXPECT_GT(0, ret);
>
> Please convert to EXPECT_NE(ret, 0)
>
please see [resp 4]

> > +     EXPECT_EQ(EPERM, errno);
>
> Please invert to EXPECT_EQ(errno, EPERM)
>
please see [resp 3]

> > +
> > +     /* Verify mprotect is rejected on the second VMA. */
> > +     ret =3D sys_mprotect(self->ptr, self->page_size * 2,
> > +             PROT_READ | PROT_EXEC);
>
> Hang on, isn't this just a repeat of the first test? Shouldn't this be:
>
>         ret =3D sys_mprotect(&self->ptr[self->page_size * 2],
>                 self->page_size * 2, PROT_READ | PROT_EXEC);
>
[resp 7] Not the same, this test has two VMA, and  the mseal() covers
both VMAs in one call. In the first test, i.e. basic, mprotect_basic,
mseal is called on single VMA.

> > +     EXPECT_GT(0, ret);
> > +     EXPECT_EQ(EPERM, errno);
>
> Same comment as above re: ordering.
>
please see [resp 3]

> > +
> > +     /* Attempt of mprotect two VMAs at the same call is blocked */
> > +     ret =3D sys_mprotect(self->ptr, self->size,
> > +             PROT_READ | PROT_EXEC);
>
> Same comment about iterating through prot flags that should fail as above=
.
>
please see [resp 7]

> > +     EXPECT_GT(0, ret);
> > +     EXPECT_EQ(EPERM, errno);
>
> Same comment as above re: ordering.
>
please see [resp 3]

> > +
> > +     /* Verify both VMAs aren't changed. */
> > +     size =3D get_vma_size(self->ptr, &prot);
> > +     EXPECT_EQ(self->page_size * 2, size);
> > +     EXPECT_EQ(PROT_READ, prot);
>
> Same comment as above re: ordering.
>
please see [resp 3]

> > +
> > +     size =3D get_vma_size(self->ptr + self->page_size * 2, &prot);
> > +     EXPECT_EQ(self->page_size * 2, size);
> > +     EXPECT_EQ(PROT_READ | PROT_WRITE, prot);
>
> Same comment as above re: ordering.
>
please see [resp 3]

> > +}
> > +
> > +TEST_HARNESS_MAIN
> > diff --git a/tools/testing/selftests/mm/memorysealing.h b/tools/testing=
/selftests/mm/memorysealing.h
> > new file mode 100644
> > index 000000000000..aee6e6700028
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/memorysealing.h
> > @@ -0,0 +1,116 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <syscall.h>
> > +
> > +/*
> > + * Define sys_xyx to call syscall directly.
> > + * This is needed because we want to avoid calling glibc and
> > + * test syscall directly.
>
> I do wonder if this is worth it, but I mean, I guess it's not too egregio=
us
> if it's wrapped like this. Same comment for other wrappers.
>
The self-test should directly test the kernel syscall without any
intermediate layer. selftest is not a libc test. It is practical too,
glibc's behavior can change across versions which result inconsistent,
and Padro Falcato reported one of this and fixed in [3]

> > + * The only exception is mmap, which _NR_mmap2 is not defined for
> > + * some ARM architecture.
> > + */
> > +static inline int sys_mseal(void *start, size_t len, unsigned long fla=
gs)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
>
> Why are we setting this to 0? Same comment for all sys_XXX() wrappers.
>
The test is only interested in the latest error associated with the
failed syscall, and I'm not sure the kernel clears the errno for each
system call. Note, there is no glibc layer here.

> > +     sret =3D syscall(__NR_mseal, start, len, flags);
> > +     return sret;
>
> Nit, but this seems a bit redundant, why not just drop the sret assignmen=
t,
> and simply:
>
>         return syscall(__NR_mseal, start, len, flags);
>
> Same comment for all sys_XXX() wrappers.
>
[resp 6] I think this is a different taste in coding style. For the
test, I prefer to have local variables so it is easy to show them in
the debugger, when needed.

> > +}
> > +
> > +static inline int sys_mprotect(void *ptr, size_t size, unsigned long p=
rot)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_mprotect, ptr, size, prot);
> > +     return sret;
> > +}
> > +
>
> The wrappers below don't seem to be used yet, could we delay putting them
> in until they are actually used?
>
Sure, I will remove sys_mprotect_pkey for this patch.

> > +static inline int sys_mprotect_pkey(void *ptr, size_t size,
> > +     unsigned long orig_prot, unsigned long pkey)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_pkey_mprotect, ptr, size, orig_prot, pkey);
> > +     return sret;
> > +}
> > +
> > +static inline int sys_munmap(void *ptr, size_t size)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_munmap, ptr, size);
> > +     return sret;
> > +}
> > +
> > +static inline int sys_madvise(void *start, size_t len, int types)
> > +{
> > +     int sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D syscall(__NR_madvise, start, len, types);
> > +     return sret;
> > +}
> > +
> > +static inline void *sys_mremap(void *addr, size_t old_len, size_t new_=
len,
> > +     unsigned long flags, void *new_addr)
> > +{
> > +     void *sret;
> > +
> > +     errno =3D 0;
> > +     sret =3D (void *) syscall(__NR_mremap, addr, old_len, new_len, fl=
ags, new_addr);
> > +     return sret;
> > +}
> > +
> > +/*
> > + * Parsing /proc/self/maps to get VMA's size and prot bit.
> > + */
> > +static unsigned long get_vma_size(void *addr, int *prot)
> > +{
> > +     FILE *maps;
> > +     char line[256];
> > +     int size =3D 0;
> > +     uintptr_t  addr_start, addr_end;
>
> Why not add a:
>
>         uintptr_t addr_val =3D (uintptr_t)addr;
>
> To avoid having to constantly cast below?
>
sure.

> > +     char protstr[5];
> > +     *prot =3D 0;
>
> Nit but not sure there's much point in setting this to 0 even in failure
> cases?
>
> With an error code return you can avoid having to do this.
>
[resp 8]
I don't think the error code return is worth the effort, it currently
returns 0 size in case of error or not-found. For easy debug parsing
errors, I can add logs.  Notes, the parsing should always be
successful.

> > +
> > +     maps =3D fopen("/proc/self/maps", "r");
> > +     if (!maps)
> > +             return 0;
>
> Might it be better to return an error code or something so we can identif=
y
> this case? I guess any sensible call will fail on a 0 but you're sort of
> just implicitly hoping for this.
>
[resp 9] we could add logging in case of error.

> > +
> > +     while (fgets(line, sizeof(line), maps)) {
> > +             if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, p=
rotstr) =3D=3D 3) {
> > +                     if (addr_start =3D=3D (uintptr_t) addr) {
>
> This is a Yoda comparison again, let's put what we're comparing first, an=
d
> the thing we're comparing to afterwards, e.g.
>
>         if ((uintptr_t)addr =3D=3D addr_start) ...
>
addr is the expected value from input and  addr_start changes after
parsing each line. The expected value (addr) is in second position,
why is this yoda syntax ? IMO, introducing the yoda syntax concept for
"=3D=3D"  is more confusing than useful, A=3D=3DB is as clear as B=3D=3DA.

> Also I don't think a space after the (type) cast is necesary.
>
sure

> > +                             size =3D addr_end - addr_start;
> > +                             if (protstr[0] =3D=3D 'r')
> > +                                     *prot |=3D PROT_READ;
> > +                             if (protstr[1] =3D=3D 'w')
> > +                                     *prot |=3D PROT_WRITE;
> > +                             if (protstr[2] =3D=3D 'x')
> > +                                     *prot |=3D PROT_EXEC;
> > +                             break;
> > +                     }
> > +             }
> > +     }
>
> On the impl: This would be neater if you used guard clauses:
>
>         while (fgets(line, sizeof(line), maps)) {
>                 if (sscanf(line, "%lx-%lx %4s", &addr_start, &addr_end, p=
rotstr) !=3D 3)
>                         continue;
>
>                 if (addr_val !=3D addr_start)
>                         continue;
>
>                 size =3D addr_end - addr_start;
>                 if (protstr[0] =3D=3D 'r')
>                         *prot |=3D PROT_READ;
>                 if (protstr[1] =3D=3D 'w')
>                         *prot |=3D PROT_WRITE;
>                 if (protstr[2] =3D=3D 'x')
>                         *prot |=3D PROT_EXEC;
>                 break;
>         }
>
> This is a lot more readable?
>
sure.

> On doing this at all - it feels a bit crazy to check this, but I guess it
> might be the only way to assert things about merge/split.
>
> I'm not sure it's _really useful_ to do that though - merges/splits are
> internal implementation details in effect (modulo mremap single VMA
> requirements), and mseal is an external interface, really the check shoul=
d
> be around 'can forbidden operations be performed on sealed mappings'.
>
This is related to resp [5].
This test not only verifies the size, but also verifies the prot bits.
The argument that VMA is an internal behavior is questionable, the
/proc/pid/maps is user-facing and applications can read it and parse
it.

> However, if you do really want to do this, I think it would be much bette=
r
> to use the new ioctl interface for this [0] which should avoid having to =
do
> unpleasant text wrangling :)
>
> [0]:https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.or=
g/
>
I could try this. This is a new feature though, I do think this
selftest should be self-standing and has as minimal dependency as
possible.  Is there harm of using /proc/pid/maps ? parsing
/proc/pid/maps already used by selftest in lots of places (see below),
I would prefer testing to use well-established patterns than relying
on a newly developed feature.

filesystems/overlayfs/dev_in_maps.c
mm/mlock2-tests.c
mm/mremap_test.c
mm/virtual_address_range.c
mm/split_huge_page_test.c
filesystems/overlayfs/dev_in_maps.c
exec/load_address.c
bpf/trace_helpers.c

>
> > +     fclose(maps);
> > +     return size;
>
> If we don't find the line we don't seem to be indicating this, again wort=
h
> being able to pass back an error?
>
It can be normal that we don't find a line, i.e. tests want to verify
that a VMA does not exist at address, return 0 size is correct in this
case. If a parsing error ever happened, the test would have failed at
FIXTURE_SETUP to begin with.

> > +}
> > +
> > +static inline bool mseal_supported(void)
> > +{
> > +     int ret;
> > +     void *ptr;
> > +     unsigned long page_size =3D getpagesize();
> > +
> > +     ptr =3D mmap(NULL, page_size, PROT_READ, MAP_ANONYMOUS | MAP_PRIV=
ATE, -1, 0);
> > +     if (ptr =3D=3D MAP_FAILED)
> > +             return false;
> > +
> > +     ret =3D sys_mseal(ptr, page_size, 0);
> > +     if (ret < 0)
> > +             return false;
>
> This is kind of cute, I mean it speaks to the need I think for us to be
> able to expose 'is X available?' programmatically. But I digress.
>
> I guess this is ok, as this is something that should never fail.
>
You might recall that mseal is not available on the 32 bits kernel,
automation might run the mseal_test on a 32 bit build.
mseal_supported() detects this so tests can be skipped.

> But we should definitely clean up after ourselves here whether this
> succeeds or fails.
>
please see resp [1].

Thanks!
-Jeff
[1] https://lore.kernel.org/all/CAKbZUD31EK2ah=3DvWJ46y4nL9OygzAa6ZxPnPHmWY=
O-sop5t+5Q@mail.gmail.com/
[2] https://lore.kernel.org/all/ko3pjllsgufbz33hqvwdpdsyxvgrgzqiodxexnpcng3=
mssffeh@dfgfkqlg46xa/
[3] https://lore.kernel.org/all/20240807153544.2754247-1-jeffxu@chromium.or=
g/







> > +
> > +     return true;
> > +}
> > diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/se=
lftests/mm/mseal_test.c
> > index ad17005521a8..8dd20341de3d 100644
> > --- a/tools/testing/selftests/mm/mseal_test.c
> > +++ b/tools/testing/selftests/mm/mseal_test.c
> > @@ -517,30 +517,6 @@ static void test_seal_twice(void)
> >       REPORT_TEST_PASS();
> >  }
> >
> > -static void test_seal_mprotect(bool seal)
> > -{
> > -     void *ptr;
> > -     unsigned long page_size =3D getpagesize();
> > -     unsigned long size =3D 4 * page_size;
> > -     int ret;
> > -
> > -     setup_single_address(size, &ptr);
> > -     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > -
> > -     if (seal) {
> > -             ret =3D seal_single_address(ptr, size);
> > -             FAIL_TEST_IF_FALSE(!ret);
> > -     }
> > -
> > -     ret =3D sys_mprotect(ptr, size, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > -             FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > -             FAIL_TEST_IF_FALSE(!ret);
> > -
> > -     REPORT_TEST_PASS();
> > -}
> > -
> >  static void test_seal_start_mprotect(bool seal)
> >  {
> >       void *ptr;
> > @@ -658,41 +634,6 @@ static void test_seal_mprotect_unalign_len_variant=
_2(bool seal)
> >       REPORT_TEST_PASS();
> >  }
> >
> > -static void test_seal_mprotect_two_vma(bool seal)
> > -{
> > -     void *ptr;
> > -     unsigned long page_size =3D getpagesize();
> > -     unsigned long size =3D 4 * page_size;
> > -     int ret;
> > -
> > -     setup_single_address(size, &ptr);
> > -     FAIL_TEST_IF_FALSE(ptr !=3D (void *)-1);
> > -
> > -     /* use mprotect to split */
> > -     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > -     FAIL_TEST_IF_FALSE(!ret);
> > -
> > -     if (seal) {
> > -             ret =3D seal_single_address(ptr, page_size * 4);
> > -             FAIL_TEST_IF_FALSE(!ret);
> > -     }
> > -
> > -     ret =3D sys_mprotect(ptr, page_size * 2, PROT_READ | PROT_WRITE);
> > -     if (seal)
> > -             FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > -             FAIL_TEST_IF_FALSE(!ret);
> > -
> > -     ret =3D sys_mprotect(ptr + page_size * 2, page_size * 2,
> > -                     PROT_READ | PROT_WRITE);
> > -     if (seal)
> > -             FAIL_TEST_IF_FALSE(ret < 0);
> > -     else
> > -             FAIL_TEST_IF_FALSE(!ret);
> > -
> > -     REPORT_TEST_PASS();
> > -}
> > -
> >  static void test_seal_mprotect_two_vma_with_split(bool seal)
> >  {
> >       void *ptr;
> > @@ -1876,7 +1817,7 @@ int main(void)
> >       if (!pkey_supported())
> >               ksft_print_msg("PKEY not supported\n");
> >
> > -     ksft_set_plan(88);
> > +     ksft_set_plan(84);
> >
> >       test_seal_addseal();
> >       test_seal_unmapped_start();
> > @@ -1889,9 +1830,6 @@ int main(void)
> >       test_seal_zero_length();
> >       test_seal_twice();
> >
> > -     test_seal_mprotect(false);
> > -     test_seal_mprotect(true);
> > -
> >       test_seal_start_mprotect(false);
> >       test_seal_start_mprotect(true);
> >
> > @@ -1904,9 +1842,6 @@ int main(void)
> >       test_seal_mprotect_unalign_len_variant_2(false);
> >       test_seal_mprotect_unalign_len_variant_2(true);
> >
> > -     test_seal_mprotect_two_vma(false);
> > -     test_seal_mprotect_two_vma(true);
> > -
> >       test_seal_mprotect_two_vma_with_split(false);
> >       test_seal_mprotect_two_vma_with_split(true);
> >
> > --
> > 2.47.1.613.gc27f4b7a9f-goog
> >

