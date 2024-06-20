Return-Path: <linux-kselftest+bounces-12292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA0390FB29
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 04:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9042B1C21028
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 02:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018EA14A8F;
	Thu, 20 Jun 2024 02:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckXixJUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCE41BDD0;
	Thu, 20 Jun 2024 02:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849057; cv=none; b=kpkw+7TqC7Kf+/w5GXZXkHGLKe1QzGD9/G+VXVeieTqGKCw0S9uQPMoK/gXOxbbLJckrCIDGOt3kuy8yen8Mu7XrU+VvJvCuYIhyCsrmV5z1ymXXjTW3M7BmK9wnXp5amdGeDsusqIaHNDIWwx/R3EMB1HcTGZ6RWZ3pE8iN8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849057; c=relaxed/simple;
	bh=W95vJRsdR9kjIHZqmPeoWP9lomjKv6MGJ35IR8aW08E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mbu0hLEjua6JcySlXXKO3pph3Tf/eFEePF2ZyHB795GWu5xFz/GODIn5jOgJybo5iF/YaANJ3WrtA438CFH4zI28L5Ec05Ueh0koJ9LUvu91NDi8hUMNG1TMFoEBV8FfEFIF8I+dYydFa+TgAoOrPeovFwQLS38oePiWh0U6Ehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ckXixJUK; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-80b755c6c06so118097241.2;
        Wed, 19 Jun 2024 19:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718849055; x=1719453855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhmMCJlWLT6P0x0JEVsA2CFzvtPsQuWVwbgag5ghfwE=;
        b=ckXixJUKGyQ9bZ7gG0Kymq2ChiZ+UAzvHJhq1tqBNeA+Yeyjc0zE21mPXHEh4RPnpc
         e11/LnuayRc/OtBZRbMPVwmGXfxVwWlYWeb9HA5PQVVB6IRY+5QIJSCdSGaU+hEynpjO
         G8buXu6d6F8BtAwgdR5UVrFAYCcWwwvw3HUIkR97pazP3QFXGT9E6d6ERvfNi7+FOQNt
         8KH1HUxLsNvSFqT5AJCInxlxo/w+vs3J8zgYvA8yrETuOsmmVkDxwCDkdIZ57K8PIz2M
         eRAemKoI4zq5CKvOaoENsZxJWKix0dnsBsOehbtxTfkJi+ABfD6bKiw0hmELeSnZFiTp
         9IWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718849055; x=1719453855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhmMCJlWLT6P0x0JEVsA2CFzvtPsQuWVwbgag5ghfwE=;
        b=w3Vpozk8xwURHsU0cbVCFmVlH6RGGF2sdOvW4LJ54kTV8hmO/QAeE3UTq+gj9Wffp7
         eZ2isQL/riC+eR5VKtJ/frgEb7lG/NlqfwrOTNWa6dURdzal2N8x1iKOMk86UF2S2hU6
         S/pKepDmScrsXVyRFiZbZVMc0oBGO2iqcJLe9UKqobG45UR3nS9VHArg/tj9IWGYcxSR
         dVOsycUFJlvQ4QfAy7Hw9+uBO60aeJlfCY9ZWM+JkZYvGGlmZomil+BrqKpXkrA2Bm/r
         0s+ioUOO7Ab8mm7YQ7PofKJ148gSuT8npzUmY5ajNcnfrnKd02OnwAAqKTKbzDhL5TAz
         Nd0A==
X-Forwarded-Encrypted: i=1; AJvYcCXk3DjLFFoLs1r+2mSDCSEt5WKZ2h6ZT4U3o5uly0mYxxIggFkVkqjB/RrUOXDPUgWN5R6EXVe6GKcJrTOquHBN9rVqjqYpY0zcTSJnTfOjnhEV13bUlUnklvYvYssl2sxUqcBReSA+M7kSbpDU
X-Gm-Message-State: AOJu0Yw5Sa48zRCELnFVAgsfSdyhsyYYjZf6ICXtRh5tg/5nP8mmJu71
	Kt1NHMv9N9fhje/BynO04pI+n8IiMw7uvBkZUlqK85rXC2t4+ksomxFGlZR1UsBFTA+u5rMC6co
	L9Xsz6iUTTcwXAznrPLRTugRJ6Qw=
X-Google-Smtp-Source: AGHT+IGWMX6GIQMKhSTglWLeOPg1r0KL1VIJVatQqACDfbph/Dm/svF8qriPsm3BUQO0wRsDfIBQ+vY4BH5McdG6U1A=
X-Received: by 2002:a05:6102:4c46:b0:48f:1d57:9b with SMTP id
 ada2fe7eead31-48f1d5700f5mr2656379137.26.1718849054960; Wed, 19 Jun 2024
 19:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 14:04:03 +1200
Message-ID: <CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > Both Ryan and Chris have been utilizing the small test program to aid
> > in debugging and identifying issues with swap entry allocation. While
> > a real or intricate workload might be more suitable for assessing the
> > correctness and effectiveness of the swap allocation policy, a small
> > test program presents a simpler means of understanding the problem and
> > initially verifying the improvements being made.
> >
> > Let's endeavor to integrate it into the self-test suite. Although it
> > presently only accommodates 64KB and 4KB, I'm optimistic that we can
> > expand its capabilities to support multiple sizes and simulate more
> > complex systems in the future as required.
>
> IIUC, this is a performance test program instead of functionality test
> program.  Does it match the purpose of the kernel selftest?

I have a differing perspective. I maintain that the functionality is
not functioning
as expected. Despite having all the necessary resources for allocation, fai=
lure
persists, indicating a lack of functionality.

>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  tools/testing/selftests/mm/Makefile           |   1 +
> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
> >  2 files changed, 193 insertions(+)
> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test.=
c
> >
> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selfte=
sts/mm/Makefile
> > index e1aa09ddaa3d..64164ad66835 100644
> > --- a/tools/testing/selftests/mm/Makefile
> > +++ b/tools/testing/selftests/mm/Makefile
> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
> >  TEST_GEN_FILES +=3D seal_elf
> >  TEST_GEN_FILES +=3D on-fault-limit
> >  TEST_GEN_FILES +=3D pagemap_ioctl
> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
> >  TEST_GEN_FILES +=3D thuge-gen
> >  TEST_GEN_FILES +=3D transhuge-stress
> >  TEST_GEN_FILES +=3D uffd-stress
> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/too=
ls/testing/selftests/mm/thp_swap_allocator_test.c
> > new file mode 100644
> > index 000000000000..4443a906d0f8
> > --- /dev/null
> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> > @@ -0,0 +1,192 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * thp_swap_allocator_test
> > + *
> > + * The purpose of this test program is helping check if THP swpout
> > + * can correctly get swap slots to swap out as a whole instead of
> > + * being split. It randomly releases swap entries through madvise
> > + * DONTNEED and do swapout on two memory areas: a memory area for
> > + * 64KB THP and the other area for small folios. The second memory
> > + * can be enabled by "-s".
> > + * Before running the program, we need to setup a zRAM or similar
> > + * swap device by:
> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> > + *  echo 64M > /sys/block/zram0/disksize
> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/=
enabled
> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/e=
nabled
> > + *  mkswap /dev/zram0
> > + *  swapon /dev/zram0
> > + * The expected result should be 0% anon swpout fallback ratio w/ or
> > + * w/o "-s".
> > + *
> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <stdio.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <string.h>
> > +#include <sys/mman.h>
> > +#include <errno.h>
> > +#include <time.h>
> > +
> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> > +#define ALIGNMENT_MTHP (64 * 1024)
> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> > +#define MTHP_FOLIO_SIZE (64 * 1024)
> > +
> > +#define SWPOUT_PATH \
> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> > +#define SWPOUT_FALLBACK_PATH \
> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_=
fallback"
> > +
> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
> > +{
> > +     void *mem =3D NULL;
> > +
> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> > +             perror("posix_memalign");
> > +             return NULL;
> > +     }
> > +     return mem;
> > +}
> > +
> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
> > +             size_t align_size, size_t total_dontneed_size)
> > +{
> > +     size_t num_pages =3D total_dontneed_size / align_size;
> > +     size_t i;
> > +     size_t offset;
> > +     void *addr;
> > +
> > +     for (i =3D 0; i < num_pages; ++i) {
> > +             offset =3D (rand() % (mem_size / align_size)) * align_siz=
e;
> > +             addr =3D (char *)mem + offset;
> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0)
> > +                     perror("madvise dontneed");
>
> IIUC, this simulates align_size (generally 64KB) swap-in.  That is, it
> simulate the effect of large size swap-in when it's not available in
> kernel.  If we have large size swap-in in kernel in the future, this
> becomes unnecessary.
>
> Additionally, we have not reached the consensus that we should always
> swap-in with swapped-out size.  So, I suspect that this test may not
> reflect real situation in the future.  Although it doesn't reflect
> current situation too.

Disagree again. releasing the whole mTHP swaps is the best case. Even in
the best-case scenario, if we fail, it raises concerns for handling potenti=
ally
more challenging situations.

I don't find it hard to incorporate additional features into this test
program to simulate more intricate scenarios.

>
> > +
> > +             memset(addr, 0x11, align_size);
> > +     }
> > +}
> > +
>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

