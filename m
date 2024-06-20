Return-Path: <linux-kselftest+bounces-12302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A65A90FE25
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 10:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961A9282068
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904F1BC39;
	Thu, 20 Jun 2024 08:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmLKIuQf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1431B2139D7;
	Thu, 20 Jun 2024 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718870479; cv=none; b=jzpZ2I2ViLuiVtGojaMSs6Hpsu/3Kq1QTtUweUzdtW++2aRjju3xP7s6oy3aMAuEDQeaQcy5NPd3uOAdU2ARaxPRCAbnoeTQ4ARcnwXjkozTAvV7ES6bztqSNW6KpqEmcU04EojEAZlWTkW09OCuGAYQnjXv7ZorWUksD4lJNYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718870479; c=relaxed/simple;
	bh=Xuniev/UTWVnpZpSCS2qMdUe2He2S/AtJnKfOEwmtwk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D7uy+LSx6o1+H/SfYmdYOknkERZrtW14MBhRlQOhYE05N4fxHcaemZFTG/EKEObhEBmmVX9CMYgc127cutKpMTBUDE25GVadhoAQnt0/5Nbc40bvi1jz5B/4LoiQG6JOdAft8JhuOhyGTiIM3nyXhDyNiHXobBCZWpGMVAv//wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmLKIuQf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718870477; x=1750406477;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Xuniev/UTWVnpZpSCS2qMdUe2He2S/AtJnKfOEwmtwk=;
  b=VmLKIuQfHDX2cE1Nne/7p9hIpDpc2sjVP+eia3HuH71CQHYUd9iVfydA
   zijkX7CZ6SPrmTteuGaRenojKZO4NfoJ0kwFjEM5xqrJsjx64x1MVSbZ1
   0H9sXY4jWp+/zJNbE5IHK4ayLydfvUHZu2uvFwPo5gImWQMHHnGsRxfIP
   g1ya8IZhQmnEBNRIoN47LlFO5Ir1ZrdokVpZjsvrZZLv3iHGFWm254Kf9
   wj7Ew2w/K8+CcD8CBzT62t3lxpqltBvZs7u6Y/4BziaDf2tpwa41mxcVN
   rOVvvMrMUalh8VoS+CRf41qOFWpTPMGsKunITRNsTy9/lE2K2qVOJZdfU
   Q==;
X-CSE-ConnectionGUID: qKqQKylRRaCvmS7FdMfqWQ==
X-CSE-MsgGUID: UTA8JDFYTsyL5CdDGdApuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15660553"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15660553"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:01:17 -0700
X-CSE-ConnectionGUID: Bw4EeqRxR7yCci33PUvx8w==
X-CSE-MsgGUID: 5y+DO701QcyYYzrBZvn/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="47108146"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 01:01:13 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <CAGsJ_4ynitJ098KyMQ2rDo3XCFKLCs=xZXfSqdcJ_kFNC02t7g@mail.gmail.com>
	(Barry Song's message of "Thu, 20 Jun 2024 19:25:42 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
	<87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
	<87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4ynitJ098KyMQ2rDo3XCFKLCs=xZXfSqdcJ_kFNC02t7g@mail.gmail.com>
Date: Thu, 20 Jun 2024 15:59:22 +0800
Message-ID: <877cek2gf9.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jun 20, 2024 at 6:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@int=
el.com> wrote:
>> >> >>
>> >> >> Barry Song <21cnbao@gmail.com> writes:
>> >> >>
>> >> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >> >
>> >> >> > Both Ryan and Chris have been utilizing the small test program t=
o aid
>> >> >> > in debugging and identifying issues with swap entry allocation. =
While
>> >> >> > a real or intricate workload might be more suitable for assessin=
g the
>> >> >> > correctness and effectiveness of the swap allocation policy, a s=
mall
>> >> >> > test program presents a simpler means of understanding the probl=
em and
>> >> >> > initially verifying the improvements being made.
>> >> >> >
>> >> >> > Let's endeavor to integrate it into the self-test suite. Althoug=
h it
>> >> >> > presently only accommodates 64KB and 4KB, I'm optimistic that we=
 can
>> >> >> > expand its capabilities to support multiple sizes and simulate m=
ore
>> >> >> > complex systems in the future as required.
>> >> >>
>> >> >> IIUC, this is a performance test program instead of functionality =
test
>> >> >> program.  Does it match the purpose of the kernel selftest?
>> >> >
>> >> > I have a differing perspective. I maintain that the functionality is
>> >> > not functioning
>> >> > as expected. Despite having all the necessary resources for allocat=
ion, failure
>> >> > persists, indicating a lack of functionality.
>> >>
>> >> Is there any user visual functionality issue?
>> >
>> > Definitely not. If a plane can't take off, taking a train and pretendi=
ng
>> > there's no functionality issue isn't a solution.
>>
>> I always think that performance optimization is great work.  However, it
>> is not functionality work.
>>
>> > I have never assigned blame for any mistakes here. On the contrary,
>> > I have 100% appreciation for Ryan's work in at least initiating mTHP
>> > swapout w/o being split.
>> >
>> > It took countless experiments for humans to make airplanes commercially
>> > viable, but the person who created the first flying airplane remains t=
he
>> > greatest. Similarly, Ryan's efforts, combined with your review of his =
patch,
>> > have enabled us to achieve a better goal here. Without your work, we c=
an't
>> > get here at all.
>>
>> Thanks!
>>
>> > However, this is never a reason to refuse to acknowledge that this fea=
ture
>> > is not actually working.
>>
>> It just works for some workloads, not for some others.
>>
>> >>
>> >> >>
>> >> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> >> > ---
>> >> >> >  tools/testing/selftests/mm/Makefile           |   1 +
>> >> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 +++++++++++=
+++++++
>> >> >> >  2 files changed, 193 insertions(+)
>> >> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocato=
r_test.c
>> >> >> >
>> >> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing=
/selftests/mm/Makefile
>> >> >> > index e1aa09ddaa3d..64164ad66835 100644
>> >> >> > --- a/tools/testing/selftests/mm/Makefile
>> >> >> > +++ b/tools/testing/selftests/mm/Makefile
>> >> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
>> >> >> >  TEST_GEN_FILES +=3D seal_elf
>> >> >> >  TEST_GEN_FILES +=3D on-fault-limit
>> >> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
>> >> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
>> >> >> >  TEST_GEN_FILES +=3D thuge-gen
>> >> >> >  TEST_GEN_FILES +=3D transhuge-stress
>> >> >> >  TEST_GEN_FILES +=3D uffd-stress
>> >> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.=
c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> >> > new file mode 100644
>> >> >> > index 000000000000..4443a906d0f8
>> >> >> > --- /dev/null
>> >> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> >> > @@ -0,0 +1,192 @@
>> >> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> >> >> > +/*
>> >> >> > + * thp_swap_allocator_test
>> >> >> > + *
>> >> >> > + * The purpose of this test program is helping check if THP swp=
out
>> >> >> > + * can correctly get swap slots to swap out as a whole instead =
of
>> >> >> > + * being split. It randomly releases swap entries through madvi=
se
>> >> >> > + * DONTNEED and do swapout on two memory areas: a memory area f=
or
>> >> >> > + * 64KB THP and the other area for small folios. The second mem=
ory
>> >> >> > + * can be enabled by "-s".
>> >> >> > + * Before running the program, we need to setup a zRAM or simil=
ar
>> >> >> > + * swap device by:
>> >> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
>> >> >> > + *  echo 64M > /sys/block/zram0/disksize
>> >> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-=
2048kB/enabled
>> >> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages=
-64kB/enabled
>> >> >> > + *  mkswap /dev/zram0
>> >> >> > + *  swapon /dev/zram0
>> >> >> > + * The expected result should be 0% anon swpout fallback ratio =
w/ or
>> >> >> > + * w/o "-s".
>> >> >> > + *
>> >> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
>> >> >> > + */
>> >> >> > +
>> >> >> > +#define _GNU_SOURCE
>> >> >> > +#include <stdio.h>
>> >> >> > +#include <stdlib.h>
>> >> >> > +#include <unistd.h>
>> >> >> > +#include <string.h>
>> >> >> > +#include <sys/mman.h>
>> >> >> > +#include <errno.h>
>> >> >> > +#include <time.h>
>> >> >> > +
>> >> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
>> >> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
>> >> >> > +#define ALIGNMENT_MTHP (64 * 1024)
>> >> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
>> >> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
>> >> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
>> >> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
>> >> >> > +
>> >> >> > +#define SWPOUT_PATH \
>> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/=
swpout"
>> >> >> > +#define SWPOUT_FALLBACK_PATH \
>> >> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/=
swpout_fallback"
>> >> >> > +
>> >> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
>> >> >> > +{
>> >> >> > +     void *mem =3D NULL;
>> >> >> > +
>> >> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
>> >> >> > +             perror("posix_memalign");
>> >> >> > +             return NULL;
>> >> >> > +     }
>> >> >> > +     return mem;
>> >> >> > +}
>> >> >> > +
>> >> >> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
>> >> >> > +             size_t align_size, size_t total_dontneed_size)
>> >> >> > +{
>> >> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
>> >> >> > +     size_t i;
>> >> >> > +     size_t offset;
>> >> >> > +     void *addr;
>> >> >> > +
>> >> >> > +     for (i =3D 0; i < num_pages; ++i) {
>> >> >> > +             offset =3D (rand() % (mem_size / align_size)) * al=
ign_size;
>> >> >> > +             addr =3D (char *)mem + offset;
>> >> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D =
0)
>> >> >> > +                     perror("madvise dontneed");
>> >> >>
>> >> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That is=
, it
>> >> >> simulate the effect of large size swap-in when it's not available =
in
>> >> >> kernel.  If we have large size swap-in in kernel in the future, th=
is
>> >> >> becomes unnecessary.
>> >> >>
>> >> >> Additionally, we have not reached the consensus that we should alw=
ays
>> >> >> swap-in with swapped-out size.  So, I suspect that this test may n=
ot
>> >> >> reflect real situation in the future.  Although it doesn't reflect
>> >> >> current situation too.
>> >> >
>> >> > Disagree again. releasing the whole mTHP swaps is the best case. Ev=
en in
>> >> > the best-case scenario, if we fail, it raises concerns for handling=
 potentially
>> >> > more challenging situations.
>> >>
>> >> Repeating sequential anonymous pages writing is the best case.
>> >
>> > I define the best case as the scenario with the least chance of creati=
ng
>> > fragments within swapfiles for mTHP to swap out. There is no real
>> > difference whether this is done through swapin or madv_dontneed.
>>
>> IMO, swapin is much more important than madv_dontneed.  Because most
>> users use swapin automatically, but few use madv_dontneed by hand.  So,
>> I think swapin/swapout test is much more important than madv_dontneed.
>> I don't like this test case because madv_dontneed isn't typical or
>> basic.
>
> Disliking DONTNEED isn't a sufficient reason to reject this test program =
because
> no single small program can report swapout counters, swapout fallback cou=
nters,
> and fallback ratios within several minutes for 100 iterations. That's
> precisely why
> we need it, at least initially. We can enhance it further if it lacks
> certain functionalities
> that people desire.
>
> The entire purpose of MADV_DONTNEED is to simulate a scenario where all
> slots are released as a whole, preventing the creation of fragments, whic=
h is
> most favorable for swap allocation. I believe there is no difference betw=
een
> using MADV_DONTNEED or swapin for this purpose. But I am perfectly fine
> with switching to swapin to replace MADV_DONTNEED in v2.

Great!  Thanks for doing this!

And even better, can we not make swap-in address aligned and size
aligned?  It's too unrealistic.  It's good to consider some level of
spatial locality, for example, swap-in random number of pages
sequentially at some random addresses.  That could be a good general
test program.  We can use it to evaluate further swap optimizations, for
example, to evaluate the memory wastage of some swap-in size policy.

And, we don't need PAGEOUT too, just use large virtual address space in
test programs.  We can trigger swapout in more common way.

[snip]

--
Best Regards,
Huang, Ying

