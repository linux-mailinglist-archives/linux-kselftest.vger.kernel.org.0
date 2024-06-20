Return-Path: <linux-kselftest+bounces-12303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C396A90FE62
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 10:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 417801F2552A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 08:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325B4172BAB;
	Thu, 20 Jun 2024 08:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OLCyjK0x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBB74EB2B;
	Thu, 20 Jun 2024 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718871119; cv=none; b=A558tGMywhpL+gscHhkIPIgm8cz57hheA/SSqcM2suaJ3nG0HqrJDf6B0o398Dpz+wv2QZUFleE85MHeWiDepdaMr4EAwMVYpMv1/+TksmvML6z35MGIYrySmTR+FA6EuMI2kqpZSUjVWsgc8nam2GHulQ6n/T1D86fgiuqxZug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718871119; c=relaxed/simple;
	bh=3yUKoKbxG78UUS/Y1BdohjokN08IEIEhwGueBvpQv3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GS3vmVYXPylLA0kXzuSJG5ZrwVyIUZEaGgrySnkgCZb4Qdp3Z0bE1ZtyMNIF8CBPQAVtTE/rRHQJnAT7fCp5sKOU2DKgKJMJlHcsw+xsu+5efkl49RS2pEkFRE2waOezduv1Z/ZZ8VlO2O6VBHh1LdGWGAULvdUcv+AG+p1mmXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OLCyjK0x; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-80d68861bf9so200912241.2;
        Thu, 20 Jun 2024 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718871116; x=1719475916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEIKPJ7y1kdYdRTFvvJFjgXvRRvjBJEQNe3nEPL5kxU=;
        b=OLCyjK0xdGwyt9TbgNkdLh8Vi8mVUDrKvK9H0iiNF53TlD6o+GAEBfJtaP4DjA0KcH
         Fd+op9HqCFtCiiQJjEpCHSQwhTkTcFeUnPkieY90aZyXHOpt2AlznHyxI6pVZb85ENuQ
         u09iWneog4kJT0gssb9C+yfWxRt5kenJrM08gRu4X7yQcE+8YNUWn76dfo8BWd8ywQWW
         FhkI/IHlwY8SSGOrBRv0MXUP+VhCHtqlXes8M+GMoCBGLXDwyEVpsJyyljAHbdqUcvm3
         16l4sdYTiM3glyCd1kdhkJKzdpDglgurPeAqOkFASeN525my7nu/AoD7XsR0L+kVQJKi
         BUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718871116; x=1719475916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEIKPJ7y1kdYdRTFvvJFjgXvRRvjBJEQNe3nEPL5kxU=;
        b=qSGB7OvPaajxTivaNcXwvs8ux2JM9tz/N4Aw8vjOVTEmR7S1bp80gvA0mDQxUKdd8F
         aETJ6EQ3op5Lu1J3S4GVEFICB8xn42GnG4o3q/7MrLT/Zb5JExajnDo1mChmrD5D6y9Y
         E5lx3KahAZrun3FAnBGvs8aovbpg81JtX5zHFdN1v38UGmvd+audKpidDw0tv1fhF5bv
         x61KOf2n3YjD5wUzBKiYEp1PqV98lLlGCfirrfISzwJ8yG363BpMCtr0TJVb4tlADLNx
         T1w/YBg+Biy26EcClhNCHWmmBn0+vGNDyurJZuLpWwMSkiFnzgl/CdGClFcxeOLsOD0n
         Dtcw==
X-Forwarded-Encrypted: i=1; AJvYcCXssRs07lLWhR4IjDbI3Jb9QPq3tTshq6YdVWVtIuCTeZPan4R63fwwjH0C54X6rOplrcJ/M08UjsAIyoyqYWE5d8/In3f5wysOreb+mGVNjGcEdi0MU0QZKi+Safd5eO4XO+8yaWLyBOQOT+2T
X-Gm-Message-State: AOJu0YxWdk1raCzFUm6rUr23srGKU6I56A9orGlnFAuE9caYbKz5bfYO
	NKu6wEc9SudWPkeqtpxvW9nLQHnfH7+vpxF9TTheIaRlRFbA0sXNb7QNAOxcZQVw3kSAWB44yvr
	0N9RFQsauZUBLV6DK8nJyY8z0LWo=
X-Google-Smtp-Source: AGHT+IGFz2JW+MJ4O4T4oexOss5rbUQz/KoCHxu1G/pbPZxJenuIrpS4L8GCy02dj9/kC7RZ4RU2rgWGkiGiKKYf8Ok=
X-Received: by 2002:a05:6102:3a43:b0:48d:9d02:81f3 with SMTP id
 ada2fe7eead31-48f130595efmr5106260137.11.1718871116059; Thu, 20 Jun 2024
 01:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com> <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
 <87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
 <87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4ynitJ098KyMQ2rDo3XCFKLCs=xZXfSqdcJ_kFNC02t7g@mail.gmail.com>
 <877cek2gf9.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <877cek2gf9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 20:11:44 +1200
Message-ID: <CAGsJ_4yps0YZiuC=fxs-nwe1U3q5sYhn8EruuaGeMH3rmX4jAg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 8:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Jun 20, 2024 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >
> >> >> >> > Both Ryan and Chris have been utilizing the small test program=
 to aid
> >> >> >> > in debugging and identifying issues with swap entry allocation=
. While
> >> >> >> > a real or intricate workload might be more suitable for assess=
ing the
> >> >> >> > correctness and effectiveness of the swap allocation policy, a=
 small
> >> >> >> > test program presents a simpler means of understanding the pro=
blem and
> >> >> >> > initially verifying the improvements being made.
> >> >> >> >
> >> >> >> > Let's endeavor to integrate it into the self-test suite. Altho=
ugh it
> >> >> >> > presently only accommodates 64KB and 4KB, I'm optimistic that =
we can
> >> >> >> > expand its capabilities to support multiple sizes and simulate=
 more
> >> >> >> > complex systems in the future as required.
> >> >> >>
> >> >> >> IIUC, this is a performance test program instead of functionalit=
y test
> >> >> >> program.  Does it match the purpose of the kernel selftest?
> >> >> >
> >> >> > I have a differing perspective. I maintain that the functionality=
 is
> >> >> > not functioning
> >> >> > as expected. Despite having all the necessary resources for alloc=
ation, failure
> >> >> > persists, indicating a lack of functionality.
> >> >>
> >> >> Is there any user visual functionality issue?
> >> >
> >> > Definitely not. If a plane can't take off, taking a train and preten=
ding
> >> > there's no functionality issue isn't a solution.
> >>
> >> I always think that performance optimization is great work.  However, =
it
> >> is not functionality work.
> >>
> >> > I have never assigned blame for any mistakes here. On the contrary,
> >> > I have 100% appreciation for Ryan's work in at least initiating mTHP
> >> > swapout w/o being split.
> >> >
> >> > It took countless experiments for humans to make airplanes commercia=
lly
> >> > viable, but the person who created the first flying airplane remains=
 the
> >> > greatest. Similarly, Ryan's efforts, combined with your review of hi=
s patch,
> >> > have enabled us to achieve a better goal here. Without your work, we=
 can't
> >> > get here at all.
> >>
> >> Thanks!
> >>
> >> > However, this is never a reason to refuse to acknowledge that this f=
eature
> >> > is not actually working.
> >>
> >> It just works for some workloads, not for some others.
> >>
> >> >>
> >> >> >>
> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> > ---
> >> >> >> >  tools/testing/selftests/mm/Makefile           |   1 +
> >> >> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 +++++++++=
+++++++++
> >> >> >> >  2 files changed, 193 insertions(+)
> >> >> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_alloca=
tor_test.c
> >> >> >> >
> >> >> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testi=
ng/selftests/mm/Makefile
> >> >> >> > index e1aa09ddaa3d..64164ad66835 100644
> >> >> >> > --- a/tools/testing/selftests/mm/Makefile
> >> >> >> > +++ b/tools/testing/selftests/mm/Makefile
> >> >> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
> >> >> >> >  TEST_GEN_FILES +=3D seal_elf
> >> >> >> >  TEST_GEN_FILES +=3D on-fault-limit
> >> >> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >> >> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
> >> >> >> >  TEST_GEN_FILES +=3D thuge-gen
> >> >> >> >  TEST_GEN_FILES +=3D transhuge-stress
> >> >> >> >  TEST_GEN_FILES +=3D uffd-stress
> >> >> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_tes=
t.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> >> > new file mode 100644
> >> >> >> > index 000000000000..4443a906d0f8
> >> >> >> > --- /dev/null
> >> >> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> >> > @@ -0,0 +1,192 @@
> >> >> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >> >> >> > +/*
> >> >> >> > + * thp_swap_allocator_test
> >> >> >> > + *
> >> >> >> > + * The purpose of this test program is helping check if THP s=
wpout
> >> >> >> > + * can correctly get swap slots to swap out as a whole instea=
d of
> >> >> >> > + * being split. It randomly releases swap entries through mad=
vise
> >> >> >> > + * DONTNEED and do swapout on two memory areas: a memory area=
 for
> >> >> >> > + * 64KB THP and the other area for small folios. The second m=
emory
> >> >> >> > + * can be enabled by "-s".
> >> >> >> > + * Before running the program, we need to setup a zRAM or sim=
ilar
> >> >> >> > + * swap device by:
> >> >> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> >> >> >> > + *  echo 64M > /sys/block/zram0/disksize
> >> >> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepage=
s-2048kB/enabled
> >> >> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepag=
es-64kB/enabled
> >> >> >> > + *  mkswap /dev/zram0
> >> >> >> > + *  swapon /dev/zram0
> >> >> >> > + * The expected result should be 0% anon swpout fallback rati=
o w/ or
> >> >> >> > + * w/o "-s".
> >> >> >> > + *
> >> >> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> >> >> >> > + */
> >> >> >> > +
> >> >> >> > +#define _GNU_SOURCE
> >> >> >> > +#include <stdio.h>
> >> >> >> > +#include <stdlib.h>
> >> >> >> > +#include <unistd.h>
> >> >> >> > +#include <string.h>
> >> >> >> > +#include <sys/mman.h>
> >> >> >> > +#include <errno.h>
> >> >> >> > +#include <time.h>
> >> >> >> > +
> >> >> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> >> >> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> >> >> >> > +#define ALIGNMENT_MTHP (64 * 1024)
> >> >> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> >> >> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> >> >> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> >> >> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
> >> >> >> > +
> >> >> >> > +#define SWPOUT_PATH \
> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stat=
s/swpout"
> >> >> >> > +#define SWPOUT_FALLBACK_PATH \
> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stat=
s/swpout_fallback"
> >> >> >> > +
> >> >> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
> >> >> >> > +{
> >> >> >> > +     void *mem =3D NULL;
> >> >> >> > +
> >> >> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> >> >> >> > +             perror("posix_memalign");
> >> >> >> > +             return NULL;
> >> >> >> > +     }
> >> >> >> > +     return mem;
> >> >> >> > +}
> >> >> >> > +
> >> >> >> > +static void random_madvise_dontneed(void *mem, size_t mem_siz=
e,
> >> >> >> > +             size_t align_size, size_t total_dontneed_size)
> >> >> >> > +{
> >> >> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
> >> >> >> > +     size_t i;
> >> >> >> > +     size_t offset;
> >> >> >> > +     void *addr;
> >> >> >> > +
> >> >> >> > +     for (i =3D 0; i < num_pages; ++i) {
> >> >> >> > +             offset =3D (rand() % (mem_size / align_size)) * =
align_size;
> >> >> >> > +             addr =3D (char *)mem + offset;
> >> >> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=
=3D 0)
> >> >> >> > +                     perror("madvise dontneed");
> >> >> >>
> >> >> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That =
is, it
> >> >> >> simulate the effect of large size swap-in when it's not availabl=
e in
> >> >> >> kernel.  If we have large size swap-in in kernel in the future, =
this
> >> >> >> becomes unnecessary.
> >> >> >>
> >> >> >> Additionally, we have not reached the consensus that we should a=
lways
> >> >> >> swap-in with swapped-out size.  So, I suspect that this test may=
 not
> >> >> >> reflect real situation in the future.  Although it doesn't refle=
ct
> >> >> >> current situation too.
> >> >> >
> >> >> > Disagree again. releasing the whole mTHP swaps is the best case. =
Even in
> >> >> > the best-case scenario, if we fail, it raises concerns for handli=
ng potentially
> >> >> > more challenging situations.
> >> >>
> >> >> Repeating sequential anonymous pages writing is the best case.
> >> >
> >> > I define the best case as the scenario with the least chance of crea=
ting
> >> > fragments within swapfiles for mTHP to swap out. There is no real
> >> > difference whether this is done through swapin or madv_dontneed.
> >>
> >> IMO, swapin is much more important than madv_dontneed.  Because most
> >> users use swapin automatically, but few use madv_dontneed by hand.  So=
,
> >> I think swapin/swapout test is much more important than madv_dontneed.
> >> I don't like this test case because madv_dontneed isn't typical or
> >> basic.
> >
> > Disliking DONTNEED isn't a sufficient reason to reject this test progra=
m because
> > no single small program can report swapout counters, swapout fallback c=
ounters,
> > and fallback ratios within several minutes for 100 iterations. That's
> > precisely why
> > we need it, at least initially. We can enhance it further if it lacks
> > certain functionalities
> > that people desire.
> >
> > The entire purpose of MADV_DONTNEED is to simulate a scenario where all
> > slots are released as a whole, preventing the creation of fragments, wh=
ich is
> > most favorable for swap allocation. I believe there is no difference be=
tween
> > using MADV_DONTNEED or swapin for this purpose. But I am perfectly fine
> > with switching to swapin to replace MADV_DONTNEED in v2.
>
> Great!  Thanks for doing this!
>
> And even better, can we not make swap-in address aligned and size
> aligned?  It's too unrealistic.  It's good to consider some level of
> spatial locality, for example, swap-in random number of pages
> sequentially at some random addresses.  That could be a good general
> test program.  We can use it to evaluate further swap optimizations, for
> example, to evaluate the memory wastage of some swap-in size policy.

I wholeheartedly agree with everything mentioned above; these are
actually part of my plan as incremental patches. This initial commit
serves as the first step of the three I proposed in the last email.

>
> And, we don't need PAGEOUT too, just use large virtual address space in
> test programs.  We can trigger swapout in more common way.

I'm not particularly enthusiastic about this idea, as I expect the test pro=
gram
to run quickly. A large virtual address space would result in long waiting =
times
for the test results, as it relies on vmscan. Therefore, I hope we can use =
real
workloads to achieve this instead.

>
> [snip]
>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

