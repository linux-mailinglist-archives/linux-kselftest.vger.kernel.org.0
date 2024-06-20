Return-Path: <linux-kselftest+bounces-12382-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE2C9116E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 01:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80727B22531
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7C2143737;
	Thu, 20 Jun 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FP2d6cSB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7784378C67
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 23:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926470; cv=none; b=BBkb1eErOjiowlzAWCZCabe6js0XbBafiEq0rsZNM4Der4kSoqXNYeMPCyeFQCeWEOykO8CXBatNdkf0KAlMGW0mto6P+9gbPimvjfmAfWtm+C5Ti9lAWFKMZUGmDT9ECQEe/0wwXGhclfC5iOviGT+c7/sQnV7TkfZE8rs9MHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926470; c=relaxed/simple;
	bh=h+moqWorq8WvFStIQy5VbHeBGz2hkRvmvutoj2g9ghU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSeP8HbbhmNb2aI6zvKcws7ZpsFYN8Em7+xwkLxVOFgHhDw/KmUloR4upsHn0DmVeXvM37c5BBLscmLBUt+IhHEl5DBUonXY65efq/wC1xXj1rcH/ZPMbN7VpkBYtsmIkQfXTrP9pbLkEB3+EmZpKRvulliKh2fCkulXtj/UDR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FP2d6cSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F52C4AF0F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 23:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926470;
	bh=h+moqWorq8WvFStIQy5VbHeBGz2hkRvmvutoj2g9ghU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FP2d6cSBCNJ2FYG31gdCxnZm8ZYdLIF6LM+Vewbqpac1vi8/lk+SB/ZQDd6gVqUO9
	 fJtYZAPRH9KKKe1qckyUI30J8O77/CaafAm5CFL/iG/Gt0zyGkqis0XaHpOVTvl/0H
	 VF5oX9UALiYzom/gTeo9+Jebqf0Aw1ZFm1AdOi1QmlhzJxMRC954FfMshLrMIO3uWJ
	 FY5S9fB6N9c/bNbw1us+qlMKLFkZgRfvxkeKFQF/TSIHE/ZDMxZbdmK7vN9jo77UTI
	 XYgVuM0sb/aCI0l/rLnPoGBWyqCm0W/aIYHm2XxQpJa2XL9hxgXMCeaRDD/E0CtZoT
	 Zjut9ESCHxqkA==
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-375fb45f465so4899765ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 16:34:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHiUeTwJlt4usKv7gsVsY2si+X7bTAZEVpnOxMecvcsTg1qPM8/yXnWih/BVbi7qrUkx9mUzurByypqNo0ujl6Kr4zNFKBhLQ6Xknm54ma
X-Gm-Message-State: AOJu0YxMV7OQA8oQcfl3VVgdR7zPJW9juwX0qiAopjHzFlwHumZvxx0K
	gX5N22W+gb0RDgTHjcbw/RMjR/RIhMP5yuI8Vv7i6rfE5ZXG39qtqTTtPnJ6X2zrsS8cQWmdJKw
	Av67SNE/XiSLdLl80hxv9nRg9C8pskdjWFall
X-Google-Smtp-Source: AGHT+IHkE6H7TRF7ZbXgZtSv58+TsNMbdTF2zyStl9uhMjCL1hM2Me4FJ+Y4JrGQFubTLf9mxa3mCd4FS8rNzUWdgTE=
X-Received: by 2002:a92:ca0c:0:b0:375:a8a8:8e7 with SMTP id
 e9e14a558f8ab-3761d6b359cmr75324335ab.8.1718926469153; Thu, 20 Jun 2024
 16:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620002648.75204-1-21cnbao@gmail.com>
In-Reply-To: <20240620002648.75204-1-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 20 Jun 2024 16:34:16 -0700
X-Gmail-Original-Message-ID: <CAF8kJuOserGkULxghiMFP=UhC_DdVaYVXZhqu6RY=SHT3mszpQ@mail.gmail.com>
Message-ID: <CAF8kJuOserGkULxghiMFP=UhC_DdVaYVXZhqu6RY=SHT3mszpQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/mm: Introduce a test program to assess swap
 entry allocation for thp_swapout
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, shuah@kernel.org, linux-mm@kvack.org, 
	ryan.roberts@arm.com, david@redhat.com, hughd@google.com, 
	kaleshsingh@google.com, kasong@tencent.com, linux-kernel@vger.kernel.org, 
	ying.huang@intel.com, linux-kselftest@vger.kernel.org, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Barry,

Thanks for the wonderful test program.

I have also used other swap test programs as well. A lot of those
tests are harder to setup up and run.

This test is very quick and simple to run. It can test some hard to
hit corner cases for me.

I am able to reproduce the warning and the kernel oops with this test progr=
am.
So for me, I am using it as a functional test that my allocator did
not produce a crash.
In that regard, it definitely provides value as a function test.

Having a fall percentage output is fine, as long as we don't fail the
test based on performance number.

I am also fine with moving the test to under tools/mm etc. I see good
value to include the test in the tree one way or the other.


On Wed, Jun 19, 2024 at 5:27=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
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
>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../selftests/mm/thp_swap_allocator_test.c    | 192 ++++++++++++++++++
>  2 files changed, 193 insertions(+)

Assume we want to keep it as selftest.
You did not add your test in run_vmtests.sh.

You might need something like this:

--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -418,6 +418,14 @@ CATEGORY=3D"thp" run_test ./khugepaged -s 2

 CATEGORY=3D"thp" run_test ./transhuge-stress -d 20

+# config and swapon zram here.
+
+CATEGORY=3D"thp" run_test ./thp_swap_allocator_test
+
+CATEGORY=3D"thp" run_test ./thp_swap_allocator_test -s
+
+# swapoff zram here.
+
 # Try to create XFS if not provided
 if [ -z "${SPLIT_HUGE_PAGE_TEST_XFS_PATH}" ]; then
     if test_selected "thp"; then


You can use the following XFS test as an example of how to setup the zram s=
wap.
XFS uses file system mount, you use swapon.

Also you need to update the usage string in run_vmtests.sh.

BTW, here is how I invoke the test runs:

kselftest_override_timeout=3D500 make -C tools/testing/selftests
TARGETS=3Dmm run_tests

The time out is not for this test, it is for some other test before
the thp_swap which exit run_vmtests.sh before hitting thp_swap. I am
running in a VM so it is slower than native machine.

>  create mode 100644 tools/testing/selftests/mm/thp_swap_allocator_test.c
>
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftest=
s/mm/Makefile
> index e1aa09ddaa3d..64164ad66835 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -65,6 +65,7 @@ TEST_GEN_FILES +=3D mseal_test
>  TEST_GEN_FILES +=3D seal_elf
>  TEST_GEN_FILES +=3D on-fault-limit
>  TEST_GEN_FILES +=3D pagemap_ioctl
> +TEST_GEN_FILES +=3D thp_swap_allocator_test
>  TEST_GEN_FILES +=3D thuge-gen
>  TEST_GEN_FILES +=3D transhuge-stress
>  TEST_GEN_FILES +=3D uffd-stress
> diff --git a/tools/testing/selftests/mm/thp_swap_allocator_test.c b/tools=
/testing/selftests/mm/thp_swap_allocator_test.c
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
> + *  echo never > /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/en=
abled
> + *  echo always > /sys/kernel/mm/transparent_hugepage/hugepages-64kB/ena=
bled
> + *  mkswap /dev/zram0
> + *  swapon /dev/zram0

This setup needs to go into run_vmtest.sh as well.

Also tear it down after the test.

Chris

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
> +       "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout"
> +#define SWPOUT_FALLBACK_PATH \
> +       "/sys/kernel/mm/transparent_hugepage/hugepages-64kB/stats/swpout_=
fallback"
> +
> +static void *aligned_alloc_mem(size_t size, size_t alignment)
> +{
> +       void *mem =3D NULL;
> +
> +       if (posix_memalign(&mem, alignment, size) !=3D 0) {
> +               perror("posix_memalign");
> +               return NULL;
> +       }
> +       return mem;
> +}
> +
> +static void random_madvise_dontneed(void *mem, size_t mem_size,
> +               size_t align_size, size_t total_dontneed_size)
> +{
> +       size_t num_pages =3D total_dontneed_size / align_size;
> +       size_t i;
> +       size_t offset;
> +       void *addr;
> +
> +       for (i =3D 0; i < num_pages; ++i) {
> +               offset =3D (rand() % (mem_size / align_size)) * align_siz=
e;
> +               addr =3D (char *)mem + offset;
> +               if (madvise(addr, align_size, MADV_DONTNEED) !=3D 0)
> +                       perror("madvise dontneed");
> +
> +               memset(addr, 0x11, align_size);
> +       }
> +}
> +
> +static unsigned long read_stat(const char *path)
> +{
> +       FILE *file;
> +       unsigned long value;
> +
> +       file =3D fopen(path, "r");
> +       if (!file) {
> +               perror("fopen");
> +               return 0;
> +       }
> +
> +       if (fscanf(file, "%lu", &value) !=3D 1) {
> +               perror("fscanf");
> +               fclose(file);
> +               return 0;
> +       }
> +
> +       fclose(file);
> +       return value;
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +       int use_small_folio =3D 0;
> +       int i;
> +       void *mem1 =3D aligned_alloc_mem(MEMSIZE_MTHP, ALIGNMENT_MTHP);
> +       void *mem2 =3D NULL;
> +
> +       if (mem1 =3D=3D NULL) {
> +               fprintf(stderr, "Failed to allocate 60MB memory\n");
> +               return EXIT_FAILURE;
> +       }
> +
> +       if (madvise(mem1, MEMSIZE_MTHP, MADV_HUGEPAGE) !=3D 0) {
> +               perror("madvise hugepage for mem1");
> +               free(mem1);
> +               return EXIT_FAILURE;
> +       }
> +
> +       for (i =3D 1; i < argc; ++i) {
> +               if (strcmp(argv[i], "-s") =3D=3D 0)
> +                       use_small_folio =3D 1;
> +       }
> +
> +       if (use_small_folio) {
> +               mem2 =3D aligned_alloc_mem(MEMSIZE_SMALLFOLIO, ALIGNMENT_=
MTHP);
> +               if (mem2 =3D=3D NULL) {
> +                       fprintf(stderr, "Failed to allocate 1MB memory\n"=
);
> +                       free(mem1);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_NOHUGEPAGE) !=
=3D 0) {
> +                       perror("madvise nohugepage for mem2");
> +                       free(mem1);
> +                       free(mem2);
> +                       return EXIT_FAILURE;
> +               }
> +       }
> +
> +       for (i =3D 0; i < 100; ++i) {
> +               unsigned long initial_swpout;
> +               unsigned long initial_swpout_fallback;
> +               unsigned long final_swpout;
> +               unsigned long final_swpout_fallback;
> +               unsigned long swpout_inc;
> +               unsigned long swpout_fallback_inc;
> +               double fallback_percentage;
> +
> +               initial_swpout =3D read_stat(SWPOUT_PATH);
> +               initial_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PAT=
H);
> +
> +               random_madvise_dontneed(mem1, MEMSIZE_MTHP, ALIGNMENT_MTH=
P,
> +                               TOTAL_DONTNEED_MTHP);
> +
> +               if (use_small_folio) {
> +                       random_madvise_dontneed(mem2, MEMSIZE_SMALLFOLIO,
> +                                       ALIGNMENT_SMALLFOLIO,
> +                                       TOTAL_DONTNEED_SMALLFOLIO);
> +               }
> +
> +               if (madvise(mem1, MEMSIZE_MTHP, MADV_PAGEOUT) !=3D 0) {
> +                       perror("madvise pageout for mem1");
> +                       free(mem1);
> +                       if (mem2 !=3D NULL)
> +                               free(mem2);
> +                       return EXIT_FAILURE;
> +               }
> +
> +               if (use_small_folio) {
> +                       if (madvise(mem2, MEMSIZE_SMALLFOLIO, MADV_PAGEOU=
T) !=3D 0) {
> +                               perror("madvise pageout for mem2");
> +                               free(mem1);
> +                               free(mem2);
> +                               return EXIT_FAILURE;
> +                       }
> +               }
> +
> +               final_swpout =3D read_stat(SWPOUT_PATH);
> +               final_swpout_fallback =3D read_stat(SWPOUT_FALLBACK_PATH)=
;
> +
> +               swpout_inc =3D final_swpout - initial_swpout;
> +               swpout_fallback_inc =3D final_swpout_fallback - initial_s=
wpout_fallback;
> +
> +               fallback_percentage =3D (double)swpout_fallback_inc /
> +                       (swpout_fallback_inc + swpout_inc) * 100;
> +
> +               printf("Iteration %d: swpout inc: %lu, swpout fallback in=
c: %lu, Fallback percentage: %.2f%%\n",
> +                               i + 1, swpout_inc, swpout_fallback_inc, f=
allback_percentage);


Chris

> +       }
> +
> +       free(mem1);
> +       if (mem2 !=3D NULL)
> +               free(mem2);
> +
> +       return EXIT_SUCCESS;
> +}
> --
> 2.34.1
>
>

