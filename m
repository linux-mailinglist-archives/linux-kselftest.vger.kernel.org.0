Return-Path: <linux-kselftest+bounces-12291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9519090FB11
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 03:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096361F219CA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 01:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BBE1173F;
	Thu, 20 Jun 2024 01:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPMSPr+o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD68E13ACC;
	Thu, 20 Jun 2024 01:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718848550; cv=none; b=FOVzzk5AtOgqGIg7L2cefJIFKaQuKtriwwwrLbS2fUDA2+0XUM+HQRuhMAtsFHpZOcAq9glzoqdtpRRnn2psyw+p7cbWia3RkYl7bjUGdVLoTdJOTQ0s/rwpNeBxhF9ZW80Nv5ejsBt5rw7FEbdJv+W8aNCEN3YvYHdMoKlcMKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718848550; c=relaxed/simple;
	bh=oYiCbiHBTA6hmiZiPSlVupDRi4CFIhK9ABCT+BZpfDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QaAkDzXcCNZOu2egk50/CcTPj1jG+BSFnSy4jqdXD3n1K+8mPtrR8ApLTR1cR8j7lpD4840vrCYpb7ov92zg4fVuLfZWxXxUzBR28xkJAd4AatomvvxMX8SWG66EUpVjN4E1PSJz0D7Iiz1H18zFPwfvfTp5de/SYxVdxFA3Lag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPMSPr+o; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718848549; x=1750384549;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=oYiCbiHBTA6hmiZiPSlVupDRi4CFIhK9ABCT+BZpfDE=;
  b=WPMSPr+ouY0dKzEvA1qSTXoUIIUzjTnl8bYX4wKNgyi9Sa67lUuovxeF
   FPlOj1s5v27M9o/2wXYKPswjaGgb+izk9GJFRFgeYDgKqkLqxWy160Ma6
   LMALxp8EDf6Glvbgg+/fRzskuDo5ZHhSi4vOQY+DNlX4WAD3FegzR4xxy
   65qDiFWOXfL/ta1K2Nf+lyA3/GyoLQpRaKivD8sybZ7MlFnGfMU19Up5Y
   EZo9FOMpR0uGmpzk6bErsJw+3Wt0EKylwETCXdFlaaLH/okJdjnkw7Jop
   M845p8051DG/oVnx3cYSOiynxs9yhM5InxHYHepMOPmgX+Oy9JhUKMFmh
   A==;
X-CSE-ConnectionGUID: 5HiTOYZ2QI+v9AB2cxZLJg==
X-CSE-MsgGUID: Dwfn185xR16JnwcoSJQVUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11108"; a="38318192"
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="38318192"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:55:47 -0700
X-CSE-ConnectionGUID: bvHPT9LURfCgiupFdU7bWg==
X-CSE-MsgGUID: J9K3wdFHT++zEai5EBrbtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="scan'208";a="46454253"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 18:55:44 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org,  shuah@kernel.org,  linux-mm@kvack.org,
  ryan.roberts@arm.com,  chrisl@kernel.org,  david@redhat.com,
  hughd@google.com,  kaleshsingh@google.com,  kasong@tencent.com,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org,  Barry
 Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
In-Reply-To: <20240620002648.75204-1-21cnbao@gmail.com> (Barry Song's message
	of "Thu, 20 Jun 2024 12:26:48 +1200")
References: <20240620002648.75204-1-21cnbao@gmail.com>
Date: Thu, 20 Jun 2024 09:53:53 +0800
Message-ID: <87zfrg2xce.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Barry Song <21cnbao@gmail.com> writes:

> From: Barry Song <v-songbaohua@oppo.com>
>
> Both Ryan and Chris have been utilizing the small test program to aid
> in debugging and identifying issues with swap entry allocation. While
> a real or intricate workload might be more suitable for assessing the
> correctness and effectiveness of the swap allocation policy, a small
> test program presents a simpler means of understanding the problem and
> initially verifying the improvements being made.
>
> Let's endeavor to integrate it into the self-test suite. Although it
> presently only accommodates 64KB and 4KB, I'm optimistic that we can
> expand its capabilities to support multiple sizes and simulate more
> complex systems in the future as required.

IIUC, this is a performance test program instead of functionality test
program.  Does it match the purpose of the kernel selftest?

> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)
>  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index e1aa09ddaa3d..64164ad66835 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -65,6 +65,7 @@ TEST_GEN_FILES += mseal_test
>  TEST_GEN_FILES += seal_elf
>  TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
> +TEST_GEN_FILES += thp_swap_allocator_test
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> new file mode 100644
> index 000000000000..4443a906d0f8
> --- /dev/null
> +++ b/tools/testing/selftests/mm/thp_swap_allocator_test.c
> @@ -0,0 +1,192 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * thp_swap_allocator_test
> + *
> + * The purpose of this test program is helping check if THP swpout
> + * can correctly get swap slots to swap out as a whole instead of
> + * being split. It randomly releases swap entries through madvise
> + * DONTNEED and do swapout on two memory areas: a memory area for
> + * 64KB THP and the other area for small folios. The second memory
> + * can be enabled by "-s".
> + * Before running the program, we need to setup a zRAM or similar
> + * swap device by:
> + *  echo lzo > /sys/block/zram0/comp_algorithm
> + *  echo 64M > /sys/block/zram0/disksize
> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/enabled
> + *  mkswap /dev/zram0
> + *  swapon /dev/zram0
> + * The expected result should be 0% anon swpout fallback ratio w/ or
> + * w/o "-s".
> + *
> + * Author(s): Barry Song <v-songbaohua@oppo.com>
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <errno.h>
> +#include <time.h>
> +
> +#define MEMSIZE_MTHP (60 * 1024 * 1024)
> +#define MEMSIZE_SMALLFOLIO (1 * 1024 * 1024)
> +#define ALIGNMENT_MTHP (64 * 1024)
> +#define ALIGNMENT_SMALLFOLIO (4 * 1024)
> +#define TOTAL_DONTNEED_MTHP (16 * 1024 * 1024)
> +#define TOTAL_DONTNEED_SMALLFOLIO (768 * 1024)
> +#define MTHP_FOLIO_SIZE (64 * 1024)
> +
> +#define SWPOUT_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> +#define SWPOUT_FALLBACK_PATH \
> +	"/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_fallback"
> +
> +static void *aligned_alloc_mem(size_t size, size_t alignment)
> +{
> +	void *mem = NULL;
> +
> +	if (posix_memalign(&mem, alignment, size) != 0) {
> +		perror("posix_memalign");
> +		return NULL;
> +	}
> +	return mem;
> +}
> +
> +static void random_madvise_dontneed(void *mem, size_t mem_size,
> +		size_t align_size, size_t total_dontneed_size)
> +{
> +	size_t num_pages = total_dontneed_size / align_size;
> +	size_t i;
> +	size_t offset;
> +	void *addr;
> +
> +	for (i = 0; i < num_pages; ++i) {
> +		offset = (rand() % (mem_size / align_size)) * align_size;
> +		addr = (char *)mem + offset;
> +		if (madvise(addr, align_size, MADV_DONTNEED) != 0)
> +			perror("madvise dontneed");

IIUC, this simulates align_size (generally 64KB) swap-in.  That is, it
simulate the effect of large size swap-in when it's not available in
kernel.  If we have large size swap-in in kernel in the future, this
becomes unnecessary.

Additionally, we have not reached the consensus that we should always
swap-in with swapped-out size.  So, I suspect that this test may not
reflect real situation in the future.  Although it doesn't reflect
current situation too.

> +
> +		memset(addr, 0x11, align_size);
> +	}
> +}
> +

[snip]

--
Best Regards,
Huang, Ying

