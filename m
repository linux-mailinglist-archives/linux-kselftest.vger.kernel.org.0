Return-Path: <linux-kselftest+bounces-12298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E55D90FCCB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 08:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD13F2860C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4338FA5;
	Thu, 20 Jun 2024 06:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KhTxATZR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07471946F;
	Thu, 20 Jun 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718865386; cv=none; b=lpnVt7GgeFD+XGEkAIRbiXAqr1ovG+fEjhe0B5bfTG6/953K3zQcRl4eUwXW5L09s5gPJ0NBIARRKxFRrAXKIh9a6cFMvOzkdJ9leWcNTYP5PwxTiJVRCu6zRjkxdOdfHrVcyUaEXyd6n0GZCQYsFSspD1roYJ2L6ZqI0ftJhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718865386; c=relaxed/simple;
	bh=hY2avXCXYFOostNL+nFhiyWysCtGuzYiMdq09ZbZeVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BQy8TXXNzFWFYh1H/hUaj2WJ2O7oL9XfccYwuvTn3d+Fo9pUC10It+K3PlDhoHNwS4gaqyeQ7TrncbiZwjXvOxO8jHFkazarfrmCoIeWTTCDxL6Jut2Feu9oo7S6UK0PYlV6z2HsZSAFHydQWMHE2jtGo0acq/7090QLQjWnNm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KhTxATZR; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718865385; x=1750401385;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=hY2avXCXYFOostNL+nFhiyWysCtGuzYiMdq09ZbZeVg=;
  b=KhTxATZR6tD22UPL1Y2CSo3zMgewcQB2bOeRTP2mTaa8IA5UP7fMoKxU
   eQ3YQLuSpD/Zrz/qArud++18SG7QnPFHkiyWhVgtDynb6Keod7mYfZXH9
   Cqlcm5y66EQ2UBiu1szU7+ya/b3/KeVQwgY3LoW3v0NnzZOVVAda9K/7G
   Fy7q7M9jqVGAhevE/o/QIGm0lG5dB1vpd5moRo1Ape7LsyY+GoE94kUpP
   gVTfjOxQ3W5nt9zE/7DPehBW9LXhHfKY1MT1C9eLcbyMDJPN2fz5kK3ye
   2sMcyp/Q3tiTPJI3bERqg8UgEW1RVsGMAPx4lRL9ccdgNpVu9hayf9+H+
   w==;
X-CSE-ConnectionGUID: nE06UBU6T1KLyPcEqGhCRA==
X-CSE-MsgGUID: s4j0+OhXSBWez22q/uQqPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="27244569"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="27244569"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:36:25 -0700
X-CSE-ConnectionGUID: YtQPmDoGTgG7OeOdBE2loA==
X-CSE-MsgGUID: vvJhtmAvSjORieukM9FRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="41960778"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 23:36:21 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
	(Barry Song's message of "Thu, 20 Jun 2024 18:09:45 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
	<87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4zz7FdEubG4DhcCvEfyC2Z-yp8QReh9OYopvhudrZF+6A@mail.gmail.com>
Date: Thu, 20 Jun 2024 14:34:29 +0800
Message-ID: <87jzik2kcq.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jun 20, 2024 at 5:22=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
>> >>
>> >> Barry Song <21cnbao@gmail.com> writes:
>> >>
>> >> > From: Barry Song <v-songbaohua@oppo.com>
>> >> >
>> >> > Both Ryan and Chris have been utilizing the small test program to a=
id
>> >> > in debugging and identifying issues with swap entry allocation. Whi=
le
>> >> > a real or intricate workload might be more suitable for assessing t=
he
>> >> > correctness and effectiveness of the swap allocation policy, a small
>> >> > test program presents a simpler means of understanding the problem =
and
>> >> > initially verifying the improvements being made.
>> >> >
>> >> > Let's endeavor to integrate it into the self-test suite. Although it
>> >> > presently only accommodates 64KB and 4KB, I'm optimistic that we can
>> >> > expand its capabilities to support multiple sizes and simulate more
>> >> > complex systems in the future as required.
>> >>
>> >> IIUC, this is a performance test program instead of functionality test
>> >> program.  Does it match the purpose of the kernel selftest?
>> >
>> > I have a differing perspective. I maintain that the functionality is
>> > not functioning
>> > as expected. Despite having all the necessary resources for allocation=
, failure
>> > persists, indicating a lack of functionality.
>>
>> Is there any user visual functionality issue?
>
> Definitely not. If a plane can't take off, taking a train and pretending
> there's no functionality issue isn't a solution.

I always think that performance optimization is great work.  However, it
is not functionality work.

> I have never assigned blame for any mistakes here. On the contrary,
> I have 100% appreciation for Ryan's work in at least initiating mTHP
> swapout w/o being split.
>
> It took countless experiments for humans to make airplanes commercially
> viable, but the person who created the first flying airplane remains the
> greatest. Similarly, Ryan's efforts, combined with your review of his pat=
ch,
> have enabled us to achieve a better goal here. Without your work, we can't
> get here at all.

Thanks!

> However, this is never a reason to refuse to acknowledge that this feature
> is not actually working.

It just works for some workloads, not for some others.

>>
>> >>
>> >> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> >> > ---
>> >> >  tools/testing/selftests/mm/Makefile           |   1 +
>> >> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++=
++++
>> >> >  2 files changed, 193 insertions(+)
>> >> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_t=
est.c
>> >> >
>> >> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/se=
lftests/mm/Makefile
>> >> > index e1aa09ddaa3d..64164ad66835 100644
>> >> > --- a/tools/testing/selftests/mm/Makefile
>> >> > +++ b/tools/testing/selftests/mm/Makefile
>> >> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
>> >> >  TEST_GEN_FILES +=3D seal_elf
>> >> >  TEST_GEN_FILES +=3D on-fault-limit
>> >> >  TEST_GEN_FILES +=3D pagemap_ioctl
>> >> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
>> >> >  TEST_GEN_FILES +=3D thuge-gen
>> >> >  TEST_GEN_FILES +=3D transhuge-stress
>> >> >  TEST_GEN_FILES +=3D uffd-stress
>> >> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b=
/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> > new file mode 100644
>> >> > index 000000000000..4443a906d0f8
>> >> > --- /dev/null
>> >> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> >> > @@ -0,0 +1,192 @@
>> >> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> >> > +/*
>> >> > + * thp_swap_allocator_test
>> >> > + *
>> >> > + * The purpose of this test program is helping check if THP swpout
>> >> > + * can correctly get swap slots to swap out as a whole instead of
>> >> > + * being split. It randomly releases swap entries through madvise
>> >> > + * DONTNEED and do swapout on two memory areas: a memory area for
>> >> > + * 64KB THP and the other area for small folios. The second memory
>> >> > + * can be enabled by "-s".
>> >> > + * Before running the program, we need to setup a zRAM or similar
>> >> > + * swap device by:
>> >> > + *  echo lzo > /sys/block/zram0/comp_algorithm
>> >> > + *  echo 64M > /sys/block/zram0/disksize
>> >> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-204=
8kB/enabled
>> >> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64=
kB/enabled
>> >> > + *  mkswap /dev/zram0
>> >> > + *  swapon /dev/zram0
>> >> > + * The expected result should be 0% anon swpout fallback ratio w/ =
or
>> >> > + * w/o "-s".
>> >> > + *
>> >> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
>> >> > + */
>> >> > +
>> >> > +#define _GNU_SOURCE
>> >> > +#include <stdio.h>
>> >> > +#include <stdlib.h>
>> >> > +#include <unistd.h>
>> >> > +#include <string.h>
>> >> > +#include <sys/mman.h>
>> >> > +#include <errno.h>
>> >> > +#include <time.h>
>> >> > +
>> >> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
>> >> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
>> >> > +#define ALIGNMENT_MTHP (64 * 1024)
>> >> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
>> >> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
>> >> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
>> >> > +#define MTHP_FOLIO_SIZE (64 * 1024)
>> >> > +
>> >> > +#define SWPOUT_PATH \
>> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swp=
out"
>> >> > +#define SWPOUT_FALLBACK_PATH \
>> >> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swp=
out_fallback"
>> >> > +
>> >> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
>> >> > +{
>> >> > +     void *mem =3D NULL;
>> >> > +
>> >> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
>> >> > +             perror("posix_memalign");
>> >> > +             return NULL;
>> >> > +     }
>> >> > +     return mem;
>> >> > +}
>> >> > +
>> >> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
>> >> > +             size_t align_size, size_t total_dontneed_size)
>> >> > +{
>> >> > +     size_t num_pages =3D total_dontneed_size / align_size;
>> >> > +     size_t i;
>> >> > +     size_t offset;
>> >> > +     void *addr;
>> >> > +
>> >> > +     for (i =3D 0; i < num_pages; ++i) {
>> >> > +             offset =3D (rand() % (mem_size / align_size)) * align=
_size;
>> >> > +             addr =3D (char *)mem + offset;
>> >> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0)
>> >> > +                     perror("madvise dontneed");
>> >>
>> >> IIUC, this simulates align_size (generally 64KB) swap-in.  That is, it
>> >> simulate the effect of large size swap-in when it's not available in
>> >> kernel.  If we have large size swap-in in kernel in the future, this
>> >> becomes unnecessary.
>> >>
>> >> Additionally, we have not reached the consensus that we should always
>> >> swap-in with swapped-out size.  So, I suspect that this test may not
>> >> reflect real situation in the future.  Although it doesn't reflect
>> >> current situation too.
>> >
>> > Disagree again. releasing the whole mTHP swaps is the best case. Even =
in
>> > the best-case scenario, if we fail, it raises concerns for handling po=
tentially
>> > more challenging situations.
>>
>> Repeating sequential anonymous pages writing is the best case.
>
> I define the best case as the scenario with the least chance of creating
> fragments within swapfiles for mTHP to swap out. There is no real
> difference whether this is done through swapin or madv_dontneed.

IMO, swapin is much more important than madv_dontneed.  Because most
users use swapin automatically, but few use madv_dontneed by hand.  So,
I think swapin/swapout test is much more important than madv_dontneed.
I don't like this test case because madv_dontneed isn't typical or
basic.

>>
>> > I don't find it hard to incorporate additional features into this test
>> > program to simulate more intricate scenarios.
>>
>> IMHO, we don't really need this special purpose test.  We can have some
>> more general basic tests, for example, sequential anonymous pages
>> writing/reading, random anonymous pages writing/reading, and combination
>> of them.
>
> I understand that not all things will be loved by all people. However, be=
fore
> I sent this patch, Chris mentioned that it has been very helpful for him =
and
> strongly suggested that I contribute it to the self-test suite.
>
> By the way, adding sequential and random anonymous pages for
> read/write operations is definitely in my plan. The absence of this featu=
re
> isn't a convincing reason to disregard it.
>

[snip]

--
Best Regards,
Huang, Ying

