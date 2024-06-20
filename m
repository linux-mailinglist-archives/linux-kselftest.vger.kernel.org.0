Return-Path: <linux-kselftest+bounces-12297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399B190FC89
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 08:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABBE1C2102E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 06:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9610E38FA1;
	Thu, 20 Jun 2024 06:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7ElAwPm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B839A3B2A2;
	Thu, 20 Jun 2024 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863800; cv=none; b=O+yWnw/a8NsBxnwfTHVXhqjAdiRxQA2uoQ/qw11VOzf6gbNiHofMTRr8bDf9Rm1wSAvRzlyXShQqs+Iw6abKeWCt50wXGzPhFyiV66YcIJEN+z/GH8X1/ay0xckyQnFaJAvIfIGYg9bg8DLbZ9juoSOFwffCrWliGhiTInQPWyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863800; c=relaxed/simple;
	bh=jvdDHSh+QlBsrwjVDzinVNHSevWI4mKn4YS9yn+dfRM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IjV7knm0bchQeSB91OEc1fdnRwPp07dpitEpNejxpGw9nld+8SSkZEa6s5Hpg45Yl5/DwEooVxg7SN+2V48Q7vl7Zd4TGFFqmGhQzpsKnfo3U4Zl3qaS8p77gmu9ijMreDFSA165aitdDlpleOzqZesU1DTrVVaGX2U8sWq7epE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7ElAwPm; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80f65707b31so158037241.3;
        Wed, 19 Jun 2024 23:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718863797; x=1719468597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiyEdcAwGphYqKJNGYhaFEYFCGSaKvPUv7A1+7DkOss=;
        b=H7ElAwPm12PIOuJP3o7QbVaXdI5O1NHBy88wdmXb99Xxz4omWlvq/DDdiJHVg8RlHm
         SFuF8UPk/tQt6WtXSYFRd4fIGubUt8+gQ9dQhrMaiSqW9VEu/ledMjw7Zq+HpDfp3cTY
         CfIfPnU5cwOlTvZ2zh8uHFPxsD6omKrjfMI+Ycwg9LurdhRYAojhFTmC4NK31IOi+/eR
         gtunlVOLFUu0bXzxC0XeKCVDnwj4xPkUnQCTSamyvXPh4+px5oeo9bBA54Y8zA6tsfly
         O4rDeJd+gCH+wVDRkqDMsDBoZ6QKZUa+WVTsqSzTlaAdzsY2SAhi60MAxDbk3pWkaBCU
         dFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718863797; x=1719468597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tiyEdcAwGphYqKJNGYhaFEYFCGSaKvPUv7A1+7DkOss=;
        b=wXg0wcvfi7VmTB7UCdMlEzJprnnf/wUP4swFkJtv6BnlDJwKNfK/04UmFob+ZN5Vsq
         eDfIK6O33YWddY/D35WdwPShP1fgB5kQwYvh2ZLtMnpg7dfLr4bux5fuHySg31DgQIVp
         jGslSRKhfN3ZqlWcFqe/cSlRHw39R2P88HlSNnXjfJ+jbCGnjzMTppWh7+ZVjZT40uZr
         Zq+1RUUz9gIEZhLcgJCBo+0ODSrDs3sn+teCxbEhpeVRM+nels1ofOqgOwOTFDqnXrHw
         0A/B5DNpVMmYbatA3J2hfYdBsnRsAM1JkMS1Ke1wuUD54pCfjtFIW2PR8lIMKe6yuD8w
         cxmw==
X-Forwarded-Encrypted: i=1; AJvYcCXaHom1hb4FT5fooIzBa2Z8NM5nTwfDhR4U1Lj+KRo94S64kuz8+xwEUWBUC9ZwMLPnH43dbwW47k7511KH4ZyANbPMj3r5Rp4WL86yA0am7LIcCjg1VIp46nZJpsfwKJV1o9HO/FxG/qEM52wv
X-Gm-Message-State: AOJu0YyaA3E44l3aN7c49a0HGQ4V9N9rlacXPny7xAb7zM7XV3Mei3Ix
	SE7D59+Lzhw0U7zKvBPpIt9RYF37b8Zq6u2/qY1vu3xZxtsSQ0fB6S9cxS4oPIlsSUyms/VYeB1
	xNXjp2lskjYZ53lVBZfGMhaFvis4p9ALp
X-Google-Smtp-Source: AGHT+IGloYsi00Kp4ETdPxBpujFzbP6slTVUhvShKapWBEYIWQ15VyO1o1NUI0/26ubjeeHjwdOYiNovs5KGiKKhXxA=
X-Received: by 2002:a67:ea97:0:b0:48d:b646:a4fd with SMTP id
 ada2fe7eead31-48f130e001bmr4435000137.29.1718863797410; Wed, 19 Jun 2024
 23:09:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com> <87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 18:09:45 +1200
Message-ID: <CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >
> >> > Both Ryan and Chris have been utilizing the small test program to ai=
d
> >> > in debugging and identifying issues with swap entry allocation. Whil=
e
> >> > a real or intricate workload might be more suitable for assessing th=
e
> >> > correctness and effectiveness of the swap allocation policy, a small
> >> > test program presents a simpler means of understanding the problem a=
nd
> >> > initially verifying the improvements being made.
> >> >
> >> > Let's endeavor to integrate it into the self-test suite. Although it
> >> > presently only accommodates 64KB and 4KB, I'm optimistic that we can
> >> > expand its capabilities to support multiple sizes and simulate more
> >> > complex systems in the future as required.
> >>
> >> IIUC, this is a performance test program instead of functionality test
> >> program.  Does it match the purpose of the kernel selftest?
> >
> > I have a differing perspective. I maintain that the functionality is
> > not functioning
> > as expected. Despite having all the necessary resources for allocation,=
 failure
> > persists, indicating a lack of functionality.
>
> Is there any user visual functionality issue?

Definitely not. If a plane can't take off, taking a train and pretending
there's no functionality issue isn't a solution.

I have never assigned blame for any mistakes here. On the contrary,
I have 100% appreciation for Ryan's work in at least initiating mTHP
swapout w/o being split.

It took countless experiments for humans to make airplanes commercially
viable, but the person who created the first flying airplane remains the
greatest. Similarly, Ryan's efforts, combined with your review of his patch=
,
have enabled us to achieve a better goal here. Without your work, we can't
get here at all.

However, this is never a reason to refuse to acknowledge that this feature
is not actually working.

>
> >>
> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> > ---
> >> >  tools/testing/selftests/mm/Makefile           |   1 +
> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 +++++++++++++++=
+++
> >> >  2 files changed, 193 insertions(+)
> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_te=
st.c
> >> >
> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/sel=
ftests/mm/Makefile
> >> > index e1aa09ddaa3d..64164ad66835 100644
> >> > --- a/tools/testing/selftests/mm/Makefile
> >> > +++ b/tools/testing/selftests/mm/Makefile
> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
> >> >  TEST_GEN_FILES +=3D seal_elf
> >> >  TEST_GEN_FILES +=3D on-fault-limit
> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
> >> >  TEST_GEN_FILES +=3D thuge-gen
> >> >  TEST_GEN_FILES +=3D transhuge-stress
> >> >  TEST_GEN_FILES +=3D uffd-stress
> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/=
tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> > new file mode 100644
> >> > index 000000000000..4443a906d0f8
> >> > --- /dev/null
> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> > @@ -0,0 +1,192 @@
> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >> > +/*
> >> > + * thp_swap_allocator_test
> >> > + *
> >> > + * The purpose of this test program is helping check if THP swpout
> >> > + * can correctly get swap slots to swap out as a whole instead of
> >> > + * being split. It randomly releases swap entries through madvise
> >> > + * DONTNEED and do swapout on two memory areas: a memory area for
> >> > + * 64KB THP and the other area for small folios. The second memory
> >> > + * can be enabled by "-s".
> >> > + * Before running the program, we need to setup a zRAM or similar
> >> > + * swap device by:
> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> >> > + *  echo 64M > /sys/block/zram0/disksize
> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048=
kB/enabled
> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64k=
B/enabled
> >> > + *  mkswap /dev/zram0
> >> > + *  swapon /dev/zram0
> >> > + * The expected result should be 0% anon swpout fallback ratio w/ o=
r
> >> > + * w/o "-s".
> >> > + *
> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> >> > + */
> >> > +
> >> > +#define _GNU_SOURCE
> >> > +#include <stdio.h>
> >> > +#include <stdlib.h>
> >> > +#include <unistd.h>
> >> > +#include <string.h>
> >> > +#include <sys/mman.h>
> >> > +#include <errno.h>
> >> > +#include <time.h>
> >> > +
> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> >> > +#define ALIGNMENT_MTHP (64 * 1024)
> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
> >> > +
> >> > +#define SWPOUT_PATH \
> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpo=
ut"
> >> > +#define SWPOUT_FALLBACK_PATH \
> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpo=
ut_fallback"
> >> > +
> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
> >> > +{
> >> > +     void *mem =3D NULL;
> >> > +
> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> >> > +             perror("posix_memalign");
> >> > +             return NULL;
> >> > +     }
> >> > +     return mem;
> >> > +}
> >> > +
> >> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
> >> > +             size_t align_size, size_t total_dontneed_size)
> >> > +{
> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
> >> > +     size_t i;
> >> > +     size_t offset;
> >> > +     void *addr;
> >> > +
> >> > +     for (i =3D 0; i < num_pages; ++i) {
> >> > +             offset =3D (rand() % (mem_size / align_size)) * align_=
size;
> >> > +             addr =3D (char *)mem + offset;
> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0)
> >> > +                     perror("madvise dontneed");
> >>
> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That is, it
> >> simulate the effect of large size swap-in when it's not available in
> >> kernel.  If we have large size swap-in in kernel in the future, this
> >> becomes unnecessary.
> >>
> >> Additionally, we have not reached the consensus that we should always
> >> swap-in with swapped-out size.  So, I suspect that this test may not
> >> reflect real situation in the future.  Although it doesn't reflect
> >> current situation too.
> >
> > Disagree again. releasing the whole mTHP swaps is the best case. Even i=
n
> > the best-case scenario, if we fail, it raises concerns for handling pot=
entially
> > more challenging situations.
>
> Repeating sequential anonymous pages writing is the best case.

I define the best case as the scenario with the least chance of creating
fragments within swapfiles for mTHP to swap out. There is no real
difference whether this is done through swapin or madv_dontneed.

>
> > I don't find it hard to incorporate additional features into this test
> > program to simulate more intricate scenarios.
>
> IMHO, we don't really need this special purpose test.  We can have some
> more general basic tests, for example, sequential anonymous pages
> writing/reading, random anonymous pages writing/reading, and combination
> of them.

I understand that not all things will be loved by all people. However, befo=
re
I sent this patch, Chris mentioned that it has been very helpful for him an=
d
strongly suggested that I contribute it to the self-test suite.

By the way, adding sequential and random anonymous pages for
read/write operations is definitely in my plan. The absence of this feature
isn't a convincing reason to disregard it.

>
> --
> Best Regards,
> Huang, Ying
>
> >>
> >> > +
> >> > +             memset(addr, 0x11, align_size);
> >> > +     }
> >> > +}
> >> > +
> >>
> >> [snip]
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying

Thanks
Barry

