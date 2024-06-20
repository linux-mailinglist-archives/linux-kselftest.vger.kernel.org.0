Return-Path: <linux-kselftest+bounces-12309-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3800C90FFEC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 11:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A9FAB26285
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EC119B3D1;
	Thu, 20 Jun 2024 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2VSzx3i"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F6833CC4;
	Thu, 20 Jun 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874478; cv=none; b=j3zShMM8yZAmrdmX1yoYyqHU1ldse0ilMMLKQ2FsntXDA7YA4NVx8rM46NyNKr2NkFv5fT7L8wg9bFf4fhKXCfsRjZOW4GmeWKRW2Xv/i+EVpkF7yQVpv4WKtCB9lOp6JoCRRRk83WCtkwWtNqjgHPDZrgAFS8W20XTUnRrNZgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874478; c=relaxed/simple;
	bh=nn6DuTQHArNT0O3UjOULdLpWVsrBwI2AdE1Bbnhaq2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mxfPlUbPkLcRON74XTO+Q4G53J99GaBKGwRztwVyRNZ+HB0fKtZmmI5RD9OjViLlI7tQavfqobba34ipgztCdtSyXnMgBv4RFasoPgmRJpNy6j3L6IFpErOWQnYa4cQDq0aUl2L2uhCwIhbPtfdLQTg4Fn1afnngfxRxlwvuc0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2VSzx3i; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b501a4344bso3439006d6.3;
        Thu, 20 Jun 2024 02:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718874476; x=1719479276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GXkSpyAxHVXjooFkN6SNvji1ikpv4kKnA6SYohOUIA=;
        b=j2VSzx3i28IFYXPrS+FCccrCeyXMdqblHwJFs0ooXd9gVv1yE+hoDnJQDKYF/CE/+L
         MW8rXGI066AiXhUBYjlIsO7WvhTCKUU/KBG1ouWmCLO8fw0rZ1x3KQQPMXdoX7V08Ewj
         dgd83J/RhI1yRukKatuM2usah8LMu/L1362bPzk5zqbc5m0XZJ2myt9bIDSzyoTy1A0I
         iRxLHfDJCvJ2ARiYK+m+3zph3ZjzdyEUkW+yoT/QhEZ3JkWqA9h4MENhvKoSKyl9DfGW
         OmuqMTA9/hKGq1pJTFhEGXtjBd+sNxg83KccPoIju7LxdnapcdjVEaxXNKolNyTen4kh
         NZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874476; x=1719479276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GXkSpyAxHVXjooFkN6SNvji1ikpv4kKnA6SYohOUIA=;
        b=rhk5NdfScRG7h0ngmosPX/Y5mWfn1st+I2Rcdgx4S6wRr4017sBFt1m8WCFg09m4YW
         n/2FKXTNhMV8Dg8HTM7YKxH1ydZxTC4Eu+ydTNZ/g3LxWTd/zcbAZR//jzs1DPYJ+zcQ
         iAZ/aS5ueLLdxYCkftIe8Hm1U6UMOR+3J2ZDvACOpMWvFU66tyBHgJRrBl/Eh8FuUrhc
         jIoT08gllqlaacDGrQCrQNFhs7AJjXd8S50GRuUfT5qIQUXAQP/YOD57wYscsZNV0ABB
         N8gn2rvXnYvcbCCuVCWP30HAj0x1feaNn3MfoGWlws4vcFEeDuc72XlonvuIvgoY6qgy
         JNSA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jE25SIKVTb9QijwiDE3qn2ODgfhzBe3XuHhvmQS9wt+PnXcX9sRYumj8LxH02MRxQftK6yRhkuG+n48d73+4EGIf9QAKry6ZdEKQAExQIqWH7rSelvHlrfsT99TxJ7fpb+M9fBzwL2FVuR4f
X-Gm-Message-State: AOJu0YwJx0Avy0/2hs36ACo+0YAhuyErcjKyAEPkZRq34051F9Q7gmX4
	dt0R+gsDdxFGuyKjKUKIIPNJI4Bv4Ed0xbVJ+JvqEX+SLbI8VJBD9I7BFypALROiPZE1bOxKTda
	Q3MPGDJLFkWnO4JKQPzAK5yX6VjlHK3kU
X-Google-Smtp-Source: AGHT+IEb38tAo1sA/ja0PtXWy2Qpdz/CYU4eKd/153tUBxJT/fECGQpUyIekCxfR6EYh8mj/WrWrQS9Vecr6W3zq71c=
X-Received: by 2002:a0c:e14c:0:b0:6b5:420:bffc with SMTP id
 6a1803df08f44-6b50420c082mr38186496d6.29.1718874475620; Thu, 20 Jun 2024
 02:07:55 -0700 (PDT)
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
 <877cek2gf9.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4yps0YZiuC=fxs-nwe1U3q5sYhn8EruuaGeMH3rmX4jAg@mail.gmail.com>
 <8734p82f61.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <8734p82f61.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 21:07:44 +1200
Message-ID: <CAGsJ_4w0htr6q6fZ=pBnNQX9YKG5mtZEe2Vj5tBBDyhFJkreYg@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: "Huang, Ying" <ying.huang@intel.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, chrisl@kernel.org, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 8:28=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Thu, Jun 20, 2024 at 8:01=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> Barry Song <21cnbao@gmail.com> writes:
> >>
> >> > On Thu, Jun 20, 2024 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> >> >>
> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >>
> >> >> > On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@i=
ntel.com> wrote:
> >> >> >>
> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >>
> >> >> >> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huan=
g@intel.com> wrote:
> >> >> >> >>
> >> >> >> >> Barry Song <21cnbao@gmail.com> writes:
> >> >> >> >>
> >> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> >
> >> >> >> >> > Both Ryan and Chris have been utilizing the small test prog=
ram to aid
> >> >> >> >> > in debugging and identifying issues with swap entry allocat=
ion. While
> >> >> >> >> > a real or intricate workload might be more suitable for ass=
essing the
> >> >> >> >> > correctness and effectiveness of the swap allocation policy=
, a small
> >> >> >> >> > test program presents a simpler means of understanding the =
problem and
> >> >> >> >> > initially verifying the improvements being made.
> >> >> >> >> >
> >> >> >> >> > Let's endeavor to integrate it into the self-test suite. Al=
though it
> >> >> >> >> > presently only accommodates 64KB and 4KB, I'm optimistic th=
at we can
> >> >> >> >> > expand its capabilities to support multiple sizes and simul=
ate more
> >> >> >> >> > complex systems in the future as required.
> >> >> >> >>
> >> >> >> >> IIUC, this is a performance test program instead of functiona=
lity test
> >> >> >> >> program.  Does it match the purpose of the kernel selftest?
> >> >> >> >
> >> >> >> > I have a differing perspective. I maintain that the functional=
ity is
> >> >> >> > not functioning
> >> >> >> > as expected. Despite having all the necessary resources for al=
location, failure
> >> >> >> > persists, indicating a lack of functionality.
> >> >> >>
> >> >> >> Is there any user visual functionality issue?
> >> >> >
> >> >> > Definitely not. If a plane can't take off, taking a train and pre=
tending
> >> >> > there's no functionality issue isn't a solution.
> >> >>
> >> >> I always think that performance optimization is great work.  Howeve=
r, it
> >> >> is not functionality work.
> >> >>
> >> >> > I have never assigned blame for any mistakes here. On the contrar=
y,
> >> >> > I have 100% appreciation for Ryan's work in at least initiating m=
THP
> >> >> > swapout w/o being split.
> >> >> >
> >> >> > It took countless experiments for humans to make airplanes commer=
cially
> >> >> > viable, but the person who created the first flying airplane rema=
ins the
> >> >> > greatest. Similarly, Ryan's efforts, combined with your review of=
 his patch,
> >> >> > have enabled us to achieve a better goal here. Without your work,=
 we can't
> >> >> > get here at all.
> >> >>
> >> >> Thanks!
> >> >>
> >> >> > However, this is never a reason to refuse to acknowledge that thi=
s feature
> >> >> > is not actually working.
> >> >>
> >> >> It just works for some workloads, not for some others.
> >> >>
> >> >> >>
> >> >> >> >>
> >> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> > ---
> >> >> >> >> >  tools/testing/selftests/mm/Makefile           |   1 +
> >> >> >> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++=
++++++++++++
> >> >> >> >> >  2 files changed, 193 insertions(+)
> >> >> >> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_all=
ocator_test.c
> >> >> >> >> >
> >> >> >> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/te=
sting/selftests/mm/Makefile
> >> >> >> >> > index e1aa09ddaa3d..64164ad66835 100644
> >> >> >> >> > --- a/tools/testing/selftests/mm/Makefile
> >> >> >> >> > +++ b/tools/testing/selftests/mm/Makefile
> >> >> >> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
> >> >> >> >> >  TEST_GEN_FILES +=3D seal_elf
> >> >> >> >> >  TEST_GEN_FILES +=3D on-fault-limit
> >> >> >> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
> >> >> >> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
> >> >> >> >> >  TEST_GEN_FILES +=3D thuge-gen
> >> >> >> >> >  TEST_GEN_FILES +=3D transhuge-stress
> >> >> >> >> >  TEST_GEN_FILES +=3D uffd-stress
> >> >> >> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_=
test.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> >> >> > new file mode 100644
> >> >> >> >> > index 000000000000..4443a906d0f8
> >> >> >> >> > --- /dev/null
> >> >> >> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> >> >> >> >> > @@ -0,0 +1,192 @@
> >> >> >> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >> >> >> >> > +/*
> >> >> >> >> > + * thp_swap_allocator_test
> >> >> >> >> > + *
> >> >> >> >> > + * The purpose of this test program is helping check if TH=
P swpout
> >> >> >> >> > + * can correctly get swap slots to swap out as a whole ins=
tead of
> >> >> >> >> > + * being split. It randomly releases swap entries through =
madvise
> >> >> >> >> > + * DONTNEED and do swapout on two memory areas: a memory a=
rea for
> >> >> >> >> > + * 64KB THP and the other area for small folios. The secon=
d memory
> >> >> >> >> > + * can be enabled by "-s".
> >> >> >> >> > + * Before running the program, we need to setup a zRAM or =
similar
> >> >> >> >> > + * swap device by:
> >> >> >> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
> >> >> >> >> > + *  echo 64M > /sys/block/zram0/disksize
> >> >> >> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugep=
ages-2048kB/enabled
> >> >> >> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/huge=
pages-64kB/enabled
> >> >> >> >> > + *  mkswap /dev/zram0
> >> >> >> >> > + *  swapon /dev/zram0
> >> >> >> >> > + * The expected result should be 0% anon swpout fallback r=
atio w/ or
> >> >> >> >> > + * w/o "-s".
> >> >> >> >> > + *
> >> >> >> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
> >> >> >> >> > + */
> >> >> >> >> > +
> >> >> >> >> > +#define _GNU_SOURCE
> >> >> >> >> > +#include <stdio.h>
> >> >> >> >> > +#include <stdlib.h>
> >> >> >> >> > +#include <unistd.h>
> >> >> >> >> > +#include <string.h>
> >> >> >> >> > +#include <sys/mman.h>
> >> >> >> >> > +#include <errno.h>
> >> >> >> >> > +#include <time.h>
> >> >> >> >> > +
> >> >> >> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> >> >> >> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> >> >> >> >> > +#define ALIGNMENT_MTHP (64 * 1024)
> >> >> >> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> >> >> >> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> >> >> >> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> >> >> >> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
> >> >> >> >> > +
> >> >> >> >> > +#define SWPOUT_PATH \
> >> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/s=
tats/swpout"
> >> >> >> >> > +#define SWPOUT_FALLBACK_PATH \
> >> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/s=
tats/swpout_fallback"
> >> >> >> >> > +
> >> >> >> >> > +static void *aligned_alloc_mem(size_t size, size_t alignme=
nt)
> >> >> >> >> > +{
> >> >> >> >> > +     void *mem =3D NULL;
> >> >> >> >> > +
> >> >> >> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
> >> >> >> >> > +             perror("posix_memalign");
> >> >> >> >> > +             return NULL;
> >> >> >> >> > +     }
> >> >> >> >> > +     return mem;
> >> >> >> >> > +}
> >> >> >> >> > +
> >> >> >> >> > +static void random_madvise_dontneed(void *mem, size_t mem_=
size,
> >> >> >> >> > +             size_t align_size, size_t total_dontneed_size=
)
> >> >> >> >> > +{
> >> >> >> >> > +     size_t num_pages =3D total_dontneed_size / align_size=
;
> >> >> >> >> > +     size_t i;
> >> >> >> >> > +     size_t offset;
> >> >> >> >> > +     void *addr;
> >> >> >> >> > +
> >> >> >> >> > +     for (i =3D 0; i < num_pages; ++i) {
> >> >> >> >> > +             offset =3D (rand() % (mem_size / align_size))=
 * align_size;
> >> >> >> >> > +             addr =3D (char *)mem + offset;
> >> >> >> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) =
!=3D 0)
> >> >> >> >> > +                     perror("madvise dontneed");
> >> >> >> >>
> >> >> >> >> IIUC, this simulates align_size (generally 64KB) swap-in.  Th=
at is, it
> >> >> >> >> simulate the effect of large size swap-in when it's not avail=
able in
> >> >> >> >> kernel.  If we have large size swap-in in kernel in the futur=
e, this
> >> >> >> >> becomes unnecessary.
> >> >> >> >>
> >> >> >> >> Additionally, we have not reached the consensus that we shoul=
d always
> >> >> >> >> swap-in with swapped-out size.  So, I suspect that this test =
may not
> >> >> >> >> reflect real situation in the future.  Although it doesn't re=
flect
> >> >> >> >> current situation too.
> >> >> >> >
> >> >> >> > Disagree again. releasing the whole mTHP swaps is the best cas=
e. Even in
> >> >> >> > the best-case scenario, if we fail, it raises concerns for han=
dling potentially
> >> >> >> > more challenging situations.
> >> >> >>
> >> >> >> Repeating sequential anonymous pages writing is the best case.
> >> >> >
> >> >> > I define the best case as the scenario with the least chance of c=
reating
> >> >> > fragments within swapfiles for mTHP to swap out. There is no real
> >> >> > difference whether this is done through swapin or madv_dontneed.
> >> >>
> >> >> IMO, swapin is much more important than madv_dontneed.  Because mos=
t
> >> >> users use swapin automatically, but few use madv_dontneed by hand. =
 So,
> >> >> I think swapin/swapout test is much more important than madv_dontne=
ed.
> >> >> I don't like this test case because madv_dontneed isn't typical or
> >> >> basic.
> >> >
> >> > Disliking DONTNEED isn't a sufficient reason to reject this test pro=
gram because
> >> > no single small program can report swapout counters, swapout fallbac=
k counters,
> >> > and fallback ratios within several minutes for 100 iterations. That'=
s
> >> > precisely why
> >> > we need it, at least initially. We can enhance it further if it lack=
s
> >> > certain functionalities
> >> > that people desire.
> >> >
> >> > The entire purpose of MADV_DONTNEED is to simulate a scenario where =
all
> >> > slots are released as a whole, preventing the creation of fragments,=
 which is
> >> > most favorable for swap allocation. I believe there is no difference=
 between
> >> > using MADV_DONTNEED or swapin for this purpose. But I am perfectly f=
ine
> >> > with switching to swapin to replace MADV_DONTNEED in v2.
> >>
> >> Great!  Thanks for doing this!
> >>
> >> And even better, can we not make swap-in address aligned and size
> >> aligned?  It's too unrealistic.  It's good to consider some level of
> >> spatial locality, for example, swap-in random number of pages
> >> sequentially at some random addresses.  That could be a good general
> >> test program.  We can use it to evaluate further swap optimizations, f=
or
> >> example, to evaluate the memory wastage of some swap-in size policy.
> >
> > I wholeheartedly agree with everything mentioned above; these are
> > actually part of my plan as incremental patches. This initial commit
> > serves as the first step of the three I proposed in the last email.
>
> It will be a small test program to implement all these.  Don't need to
> use 3 steps.  IMHO, it's not good to optimize for a unrealistic test
> case with address aligned and size aligned swap-in.  It's trivial to
> remove the alignment requirements.

I'll preserve alignment as an option for Chris and Ryan to compare
aligned cases with unaligned ones, rather than removing the alignment
code altogether. Additionally, it can aid us in understanding the potential
outcomes when dealing with large folio swap-ins.

>
> >> And, we don't need PAGEOUT too, just use large virtual address space i=
n
> >> test programs.  We can trigger swapout in more common way.
> >
> > I'm not particularly enthusiastic about this idea, as I expect the test=
 program
> > to run quickly. A large virtual address space would result in long wait=
ing times
> > for the test results, as it relies on vmscan. Therefore, I hope we can =
use real
> > workloads to achieve this instead.
>
> I have use test program with large virtual address space (in
> vm-scalability) to do swap test before.  It runs really fast.  Please
> give it a try.

I'm not so optimistic. Having worked on both server and embedded systems,
I understand the disparity in resources between rich server environments an=
d
resource-constrained embedded systems.
I'm constantly frustrated by how slow my tests run and deploy.

>
> --
> Best Regards,
> Huang, Ying

Thanks
Barry

