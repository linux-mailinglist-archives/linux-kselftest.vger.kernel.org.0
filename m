Return-Path: <linux-kselftest+bounces-12304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D417290FECB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB831F2116D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 08:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC97B19580F;
	Thu, 20 Jun 2024 08:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZIxKY+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940B3CF65;
	Thu, 20 Jun 2024 08:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872107; cv=none; b=XRnWQy0aSQveemt8dMUAmVpfcch3fOpZ7WSiUliHo7m7tE97SulLj3jFwGK+7Ab7QXupSDLrGhj09hzxeiQKb2LmsurFdyp33EnnYNc8ajMv3PeAYREXeW6uRplUEk9NMv90Shlp1WYD2nGwMlBOVGIBT/rgSDZc7hDUyXa2rPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872107; c=relaxed/simple;
	bh=eXDHLMT4loxK5+Z+2y8OrG2bpnMK6lwhPIoMBY6hP10=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcjzuLcM1kOqVSv7CQXwrslUQYE9JO3nbVkcDSWcujp4mMA6/1q/ac7yMY87sGq7nTspRIzn+2m6zM4SHu+N7mbvmz9RwQmw2x9yZLxoo1FMv79Rm6KVQlLqdEWefKIa1PaqtaaBFDKPLFXKskF9cP8GeNLn6S3ZFwwMxo+trV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZIxKY+z; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718872106; x=1750408106;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=eXDHLMT4loxK5+Z+2y8OrG2bpnMK6lwhPIoMBY6hP10=;
  b=RZIxKY+zumlgSXD+3j3GJZqpKKtI182ywx6PRECHlo1EBUMjZotj46zc
   IuzWzDH4CgxpmL9pkpeIaYVcXGZBlgEwfAiL0iDZMJx8PSYgBgSMiTSQk
   y341EyAQKckehdllNOG51UHN7pLyrK+3+P4XAmkyVJLbOEI3xAfb4c/X+
   x5okBBsLV3a5akck5gn7lJe7ZAnvwFPDmBZ1qwQbHpLkaqoUlbQZdfurR
   BjCEE02DYZHJ62OMtKF2hvjqv/DIeRZ/HJx19zh6grY7Scg3wxk1sVLO1
   o/xgW6abnMB6EuJZMVHLkRZ2lwOCyGV/YQxP7JPY/y9WbWllEMNhN30Jy
   w==;
X-CSE-ConnectionGUID: eJ1TyU8qTUWdkjKa8zFaRQ==
X-CSE-MsgGUID: s3SCvOe/Qea0iEYyJxu56w==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="19647916"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="19647916"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:28:25 -0700
X-CSE-ConnectionGUID: Uq6jFZ83RQ+nll5RgG9C/w==
X-CSE-MsgGUID: K2ru+cEISvCP9gfw+h/S1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="42831041"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:28:22 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <CAGsJ_4yps0YZiuC=fxs-nwe1U3q5sYhn8EruuaGeMH3rmX4jAg@mail.gmail.com>
	(Barry Song's message of "Thu, 20 Jun 2024 20:11:44 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
	<87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
	<87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4ynitJ098KyMQ2rDo3XCFKLCs=xZXfSqdcJ_kFNC02t7g@mail.gmail.com>
	<877cek2gf9.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4yps0YZiuC=fxs-nwe1U3q5sYhn8EruuaGeMH3rmX4jAg@mail.gmail.com>
Date: Thu, 20 Jun 2024 16:26:30 +0800
Message-ID: <8734p82f61.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Thu, Jun 20, 2024 at 8:01=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Thu, Jun 20, 2024 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@=
intel.com> wrote:
>> >> >> >>
>> >> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >> >>
>> >> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> >
>> >> >> >> > Both Ryan and Chris have been utilizing the small test progra=
m to aid
>> >> >> >> > in debugging and identifying issues with swap entry allocatio=
n. While
>> >> >> >> > a real or intricate workload might be more suitable for asses=
sing the
>> >> >> >> > correctness and effectiveness of the swap allocation policy, =
a small
>> >> >> >> > test program presents a simpler means of understanding the pr=
oblem and
>> >> >> >> > initially verifying the improvements being made.
>> >> >> >> >
>> >> >> >> > Let's endeavor to integrate it into the self-test suite. Alth=
ough it
>> >> >> >> > presently only accommodates 64KB and 4KB, I'm optimistic that=
 we can
>> >> >> >> > expand its capabilities to support multiple sizes and simulat=
e more
>> >> >> >> > complex systems in the future as required.
>> >> >> >>
>> >> >> >> IIUC, this is a performance test program instead of functionali=
ty test
>> >> >> >> program.  Does it match the purpose of the kernel selftest?
>> >> >> >
>> >> >> > I have a differing perspective. I maintain that the functionalit=
y is
>> >> >> > not functioning
>> >> >> > as expected. Despite having all the necessary resources for allo=
cation, failure
>> >> >> > persists, indicating a lack of functionality.
>> >> >>
>> >> >> Is there any user visual functionality issue?
>> >> >
>> >> > Definitely not. If a plane can't take off, taking a train and prete=
nding
>> >> > there's no functionality issue isn't a solution.
>> >>
>> >> I always think that performance optimization is great work.  However,=
 it
>> >> is not functionality work.
>> >>
>> >> > I have never assigned blame for any mistakes here. On the contrary,
>> >> > I have 100% appreciation for Ryan's work in at least initiating mTHP
>> >> > swapout w/o being split.
>> >> >
>> >> > It took countless experiments for humans to make airplanes commerci=
ally
>> >> > viable, but the person who created the first flying airplane remain=
s the
>> >> > greatest. Similarly, Ryan's efforts, combined with your review of h=
is patch,
>> >> > have enabled us to achieve a better goal here. Without your work, w=
e can't
>> >> > get here at all.
>> >>
>> >> Thanks!
>> >>
>> >> > However, this is never a reason to refuse to acknowledge that this =
feature
>> >> > is not actually working.
>> >>
>> >> It just works for some workloads, not for some others.
>> >>
>> >> >>
>> >> >> >>
>> >> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> >> > ---
>> >> >> >> >  tools/testing/selftests/mm/Makefile           |   1 +
>> >> >> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++=
++++++++++
>> >> >> >> >  2 files changed, 193 insertions(+)
>> >> >> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_alloc=
ator_test.c
>> >> >> >> >
>> >> >> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/test=
ing/selftests/mm/Makefile
>> >> >> >> > index e1aa09ddaa3d..64164ad66835 100644
>> >> >> >> > --- a/tools/testing/selftests/mm/Makefile
>> >> >> >> > +++ b/tools/testing/selftests/mm/Makefile
>> >> >> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
>> >> >> >> >  TEST_GEN_FILES +=3D seal_elf
>> >> >> >> >  TEST_GEN_FILES +=3D on-fault-limit
>> >> >> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
>> >> >> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
>> >> >> >> >  TEST_GEN_FILES +=3D thuge-gen
>> >> >> >> >  TEST_GEN_FILES +=3D transhuge-stress
>> >> >> >> >  TEST_GEN_FILES +=3D uffd-stress
>> >> >> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_te=
st.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> >> >> > new file mode 100644
>> >> >> >> > index 000000000000..4443a906d0f8
>> >> >> >> > --- /dev/null
>> >> >> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> >> >> > @@ -0,0 +1,192 @@
>> >> >> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> >> >> >> > +/*
>> >> >> >> > + * thp_swap_allocator_test
>> >> >> >> > + *
>> >> >> >> > + * The purpose of this test program is helping check if THP =
swpout
>> >> >> >> > + * can correctly get swap slots to swap out as a whole inste=
ad of
>> >> >> >> > + * being split. It randomly releases swap entries through ma=
dvise
>> >> >> >> > + * DONTNEED and do swapout on two memory areas: a memory are=
a for
>> >> >> >> > + * 64KB THP and the other area for small folios. The second =
memory
>> >> >> >> > + * can be enabled by "-s".
>> >> >> >> > + * Before running the program, we need to setup a zRAM or si=
milar
>> >> >> >> > + * swap device by:
>> >> >> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
>> >> >> >> > + *  echo 64M > /sys/block/zram0/disksize
>> >> >> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepag=
es-2048kB/enabled
>> >> >> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepa=
ges-64kB/enabled
>> >> >> >> > + *  mkswap /dev/zram0
>> >> >> >> > + *  swapon /dev/zram0
>> >> >> >> > + * The expected result should be 0% anon swpout fallback rat=
io w/ or
>> >> >> >> > + * w/o "-s".
>> >> >> >> > + *
>> >> >> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
>> >> >> >> > + */
>> >> >> >> > +
>> >> >> >> > +#define _GNU_SOURCE
>> >> >> >> > +#include <stdio.h>
>> >> >> >> > +#include <stdlib.h>
>> >> >> >> > +#include <unistd.h>
>> >> >> >> > +#include <string.h>
>> >> >> >> > +#include <sys/mman.h>
>> >> >> >> > +#include <errno.h>
>> >> >> >> > +#include <time.h>
>> >> >> >> > +
>> >> >> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
>> >> >> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
>> >> >> >> > +#define ALIGNMENT_MTHP (64 * 1024)
>> >> >> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
>> >> >> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
>> >> >> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
>> >> >> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
>> >> >> >> > +
>> >> >> >> > +#define SWPOUT_PATH \
>> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/sta=
ts/swpout"
>> >> >> >> > +#define SWPOUT_FALLBACK_PATH \
>> >> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/sta=
ts/swpout_fallback"
>> >> >> >> > +
>> >> >> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
>> >> >> >> > +{
>> >> >> >> > +     void *mem =3D NULL;
>> >> >> >> > +
>> >> >> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
>> >> >> >> > +             perror("posix_memalign");
>> >> >> >> > +             return NULL;
>> >> >> >> > +     }
>> >> >> >> > +     return mem;
>> >> >> >> > +}
>> >> >> >> > +
>> >> >> >> > +static void random_madvise_dontneed(void *mem, size_t mem_si=
ze,
>> >> >> >> > +             size_t align_size, size_t total_dontneed_size)
>> >> >> >> > +{
>> >> >> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
>> >> >> >> > +     size_t i;
>> >> >> >> > +     size_t offset;
>> >> >> >> > +     void *addr;
>> >> >> >> > +
>> >> >> >> > +     for (i =3D 0; i < num_pages; ++i) {
>> >> >> >> > +             offset =3D (rand() % (mem_size / align_size)) *=
 align_size;
>> >> >> >> > +             addr =3D (char *)mem + offset;
>> >> >> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=
=3D 0)
>> >> >> >> > +                     perror("madvise dontneed");
>> >> >> >>
>> >> >> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That=
 is, it
>> >> >> >> simulate the effect of large size swap-in when it's not availab=
le in
>> >> >> >> kernel.  If we have large size swap-in in kernel in the future,=
 this
>> >> >> >> becomes unnecessary.
>> >> >> >>
>> >> >> >> Additionally, we have not reached the consensus that we should =
always
>> >> >> >> swap-in with swapped-out size.  So, I suspect that this test ma=
y not
>> >> >> >> reflect real situation in the future.  Although it doesn't refl=
ect
>> >> >> >> current situation too.
>> >> >> >
>> >> >> > Disagree again. releasing the whole mTHP swaps is the best case.=
 Even in
>> >> >> > the best-case scenario, if we fail, it raises concerns for handl=
ing potentially
>> >> >> > more challenging situations.
>> >> >>
>> >> >> Repeating sequential anonymous pages writing is the best case.
>> >> >
>> >> > I define the best case as the scenario with the least chance of cre=
ating
>> >> > fragments within swapfiles for mTHP to swap out. There is no real
>> >> > difference whether this is done through swapin or madv_dontneed.
>> >>
>> >> IMO, swapin is much more important than madv_dontneed.  Because most
>> >> users use swapin automatically, but few use madv_dontneed by hand.  S=
o,
>> >> I think swapin/swapout test is much more important than madv_dontneed.
>> >> I don't like this test case because madv_dontneed isn't typical or
>> >> basic.
>> >
>> > Disliking DONTNEED isn't a sufficient reason to reject this test progr=
am because
>> > no single small program can report swapout counters, swapout fallback =
counters,
>> > and fallback ratios within several minutes for 100 iterations. That's
>> > precisely why
>> > we need it, at least initially. We can enhance it further if it lacks
>> > certain functionalities
>> > that people desire.
>> >
>> > The entire purpose of MADV_DONTNEED is to simulate a scenario where all
>> > slots are released as a whole, preventing the creation of fragments, w=
hich is
>> > most favorable for swap allocation. I believe there is no difference b=
etween
>> > using MADV_DONTNEED or swapin for this purpose. But I am perfectly fine
>> > with switching to swapin to replace MADV_DONTNEED in v2.
>>
>> Great!  Thanks for doing this!
>>
>> And even better, can we not make swap-in address aligned and size
>> aligned?  It's too unrealistic.  It's good to consider some level of
>> spatial locality, for example, swap-in random number of pages
>> sequentially at some random addresses.  That could be a good general
>> test program.  We can use it to evaluate further swap optimizations, for
>> example, to evaluate the memory wastage of some swap-in size policy.
>
> I wholeheartedly agree with everything mentioned above; these are
> actually part of my plan as incremental patches. This initial commit
> serves as the first step of the three I proposed in the last email.

It will be a small test program to implement all these.  Don't need to
use 3 steps.  IMHO, it's not good to optimize for a unrealistic test
case with address aligned and size aligned swap-in.  It's trivial to
remove the alignment requirements.

>> And, we don't need PAGEOUT too, just use large virtual address space in
>> test programs.  We can trigger swapout in more common way.
>
> I'm not particularly enthusiastic about this idea, as I expect the test p=
rogram
> to run quickly. A large virtual address space would result in long waitin=
g times
> for the test results, as it relies on vmscan. Therefore, I hope we can us=
e real
> workloads to achieve this instead.

I have use test program with large virtual address space (in
vm-scalability) to do swap test before.  It runs really fast.  Please
give it a try.

--
Best Regards,
Huang, Ying

