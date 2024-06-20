Return-Path: <linux-kselftest+bounces-12296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E36C90FC2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 07:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E738A1F21D17
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 05:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8962745D;
	Thu, 20 Jun 2024 05:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpWDPkRU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7D1CD2F;
	Thu, 20 Jun 2024 05:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718860952; cv=none; b=Yp51/JT4s31l2MqoJjyB5eERFLRTcM1Pe+P5PJZQZX8qZ98HbhkKb89ukbmvDQSzviK0zFdfwynAN6cT1k2XLxEiUMINks9PJC13S49rr2HFTrpKH6XuDOCULLaA3Rb0OwmgpXSusQYJMYM7eMECmkAdNcKC7uXxqQbv/jTRu7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718860952; c=relaxed/simple;
	bh=2Q18pMNL3crb1mTBx9dsuEwBMtm1FtCsIi46LVeh/98=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bnsiVXJway37GIgMoA853X/8xkBziJJv5Rx2a+yQh7Jntn+RvVs6BUn5pwmq2Nj7ZFxixlYJaCSbTRFu3YhnNNXnm+c4rR7BZ7rF56uE9Gb21l9zfXuLXNF7Swtr2p8Es01wu785c+Uj9v6XOcIAlpl4z0zHMdnAAn4cBzrCi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpWDPkRU; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718860950; x=1750396950;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=2Q18pMNL3crb1mTBx9dsuEwBMtm1FtCsIi46LVeh/98=;
  b=SpWDPkRUDCG4niHrxTpZpiXkCa2kh0g4zfBgVHvHR9YmtsYqc8GW0j5X
   6uskNfbgp05p1m0FWjcb8bmm6vzMoHWg1i363HsPLkWx0dvNXUonwpVgv
   /tG4U8ihOvBeiW95hq3eXqrMBdXXKI0J0MHlHc/NNAfkTdsg/YGkvlBIX
   /YZ4VWKulmJHJg7SgAgUD+ddUZNOtATIuZvAamEhjvM4gLwGSAYidl9pY
   Q766xdEF/Y7LImBCf5ZNRQoINZKzKG5yGVbgSMdXy6GWYU5RvcLE9AuIJ
   JZB5oos5kvFUwUFBSnPhptpy5CaMqmRoAfEQGhwn1HejVMI+DPIAOwZog
   Q==;
X-CSE-ConnectionGUID: Fqwl8q8ZT3+lCOT5Uegh2g==
X-CSE-MsgGUID: byVo5GZQToial/wix94ceg==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="15956905"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="15956905"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 22:22:29 -0700
X-CSE-ConnectionGUID: 8hAzRxWHTF2wL5X3ZI7FgA==
X-CSE-MsgGUID: /uCbXq20TxO+zRpuAh9NiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46648444"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 22:22:26 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
	(Barry Song's message of "Thu, 20 Jun 2024 14:04:03 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
	<87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAGsJ_4wS1PbGpfi5oWw4qRgs49kcdyTb42PA+35vBC1oA8Jsbg@mail.gmail.com>
Date: Thu, 20 Jun 2024 13:20:35 +0800
Message-ID: <87o77w2nrw.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> On Thu, Jun 20, 2024 at 1:55=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Barry Song <21cnbao@gmail.com> writes:
>>
>> > From: Barry Song <v-songbaohua@oppo.com>
>> >
>> > Both Ryan and Chris have been utilizing the small test program to aid
>> > in debugging and identifying issues with swap entry allocation. While
>> > a real or intricate workload might be more suitable for assessing the
>> > correctness and effectiveness of the swap allocation policy, a small
>> > test program presents a simpler means of understanding the problem and
>> > initially verifying the improvements being made.
>> >
>> > Let's endeavor to integrate it into the self-test suite. Although it
>> > presently only accommodates 64KB and 4KB, I'm optimistic that we can
>> > expand its capabilities to support multiple sizes and simulate more
>> > complex systems in the future as required.
>>
>> IIUC, this is a performance test program instead of functionality test
>> program.  Does it match the purpose of the kernel selftest?
>
> I have a differing perspective. I maintain that the functionality is
> not functioning
> as expected. Despite having all the necessary resources for allocation, f=
ailure
> persists, indicating a lack of functionality.

Is there any user visual functionality issue?

>>
>> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>> > ---
>> >  tools/testing/selftests/mm/Makefile           |   1 +
>> >  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
>> >  2 files changed, 193 insertions(+)
>> >  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test=
.c
>> >
>> > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selft=
ests/mm/Makefile
>> > index e1aa09ddaa3d..64164ad66835 100644
>> > --- a/tools/testing/selftests/mm/Makefile
>> > +++ b/tools/testing/selftests/mm/Makefile
>> > @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
>> >  TEST_GEN_FILES +=3D seal_elf
>> >  TEST_GEN_FILES +=3D on-fault-limit
>> >  TEST_GEN_FILES +=3D pagemap_ioctl
>> > +TEST_GEN_FILES +=3D thp_swap_allocator_test
>> >  TEST_GEN_FILES +=3D thuge-gen
>> >  TEST_GEN_FILES +=3D transhuge-stress
>> >  TEST_GEN_FILES +=3D uffd-stress
>> > diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/to=
ols/testing/selftests/mm/thp_swap_allocator_test.c
>> > new file mode 100644
>> > index 000000000000..4443a906d0f8
>> > --- /dev/null
>> > +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
>> > @@ -0,0 +1,192 @@
>> > +// SPDX-License-Identifier: GPL-2.0-or-later
>> > +/*
>> > + * thp_swap_allocator_test
>> > + *
>> > + * The purpose of this test program is helping check if THP swpout
>> > + * can correctly get swap slots to swap out as a whole instead of
>> > + * being split. It randomly releases swap entries through madvise
>> > + * DONTNEED and do swapout on two memory areas: a memory area for
>> > + * 64KB THP and the other area for small folios. The second memory
>> > + * can be enabled by "-s".
>> > + * Before running the program, we need to setup a zRAM or similar
>> > + * swap device by:
>> > + *  echo lzo > /sys/block/zram0/comp_algorithm
>> > + *  echo 64M > /sys/block/zram0/disksize
>> > + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB=
/enabled
>> > + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/=
enabled
>> > + *  mkswap /dev/zram0
>> > + *  swapon /dev/zram0
>> > + * The expected result should be 0% anon swpout fallback ratio w/ or
>> > + * w/o "-s".
>> > + *
>> > + * Author(s): Barry Song <v-songbaohua@oppo.com>
>> > + */
>> > +
>> > +#define _GNU_SOURCE
>> > +#include <stdio.h>
>> > +#include <stdlib.h>
>> > +#include <unistd.h>
>> > +#include <string.h>
>> > +#include <sys/mman.h>
>> > +#include <errno.h>
>> > +#include <time.h>
>> > +
>> > +#define MEMSIZE_MTHP (60 * 1024 * 1024)
>> > +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
>> > +#define ALIGNMENT_MTHP (64 * 1024)
>> > +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
>> > +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
>> > +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
>> > +#define MTHP_FOLIO_SIZE (64 * 1024)
>> > +
>> > +#define SWPOUT_PATH \
>> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
>> > +#define SWPOUT_FALLBACK_PATH \
>> > +     "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout=
_fallback"
>> > +
>> > +static void *aligned_alloc_mem(size_t size, size_t alignment)
>> > +{
>> > +     void *mem =3D NULL;
>> > +
>> > +     if (posix_memalign(&mem, alignment, size) !=3D 0) {
>> > +             perror("posix_memalign");
>> > +             return NULL;
>> > +     }
>> > +     return mem;
>> > +}
>> > +
>> > +static void random_madvise_dontneed(void *mem, size_t mem_size,
>> > +             size_t align_size, size_t total_dontneed_size)
>> > +{
>> > +     size_t num_pages =3D total_dontneed_size / align_size;
>> > +     size_t i;
>> > +     size_t offset;
>> > +     void *addr;
>> > +
>> > +     for (i =3D 0; i < num_pages; ++i) {
>> > +             offset =3D (rand() % (mem_size / align_size)) * align_si=
ze;
>> > +             addr =3D (char *)mem + offset;
>> > +             if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0)
>> > +                     perror("madvise dontneed");
>>
>> IIUC, this simulates align_size (generally 64KB) swap-in.  That is, it
>> simulate the effect of large size swap-in when it's not available in
>> kernel.  If we have large size swap-in in kernel in the future, this
>> becomes unnecessary.
>>
>> Additionally, we have not reached the consensus that we should always
>> swap-in with swapped-out size.  So, I suspect that this test may not
>> reflect real situation in the future.  Although it doesn't reflect
>> current situation too.
>
> Disagree again. releasing the whole mTHP swaps is the best case. Even in
> the best-case scenario, if we fail, it raises concerns for handling poten=
tially
> more challenging situations.

Repeating sequential anonymous pages writing is the best case.

> I don't find it hard to incorporate additional features into this test
> program to simulate more intricate scenarios.

IMHO, we don't really need this special purpose test.  We can have some
more general basic tests, for example, sequential anonymous pages
writing/reading, random anonymous pages writing/reading, and combination
of them.

--
Best Regards,
Huang, Ying

>>
>> > +
>> > +             memset(addr, 0x11, align_size);
>> > +     }
>> > +}
>> > +
>>
>> [snip]
>>
>> --
>> Best Regards,
>> Huang, Ying
>
> Thanks
> Barry

