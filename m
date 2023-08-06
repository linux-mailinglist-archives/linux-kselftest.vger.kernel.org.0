Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F066F77144F
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 12:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjHFKG7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 06:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjHFKG6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 06:06:58 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DE311D;
        Sun,  6 Aug 2023 03:06:55 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 991BEC0004;
        Sun,  6 Aug 2023 10:06:49 +0000 (UTC)
Message-ID: <a96afa52-14aa-28f8-d4e5-34bbd3e400ef@ghiti.fr>
Date:   Sun, 6 Aug 2023 12:06:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 2/4] RISC-V: mm: Add tests for RISC-V mm
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com, rdunlap@infradead.org,
        alexghiti@rivosinc.com
References: <20230727212647.4182407-1-charlie@rivosinc.com>
 <20230727212647.4182407-3-charlie@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230727212647.4182407-3-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 27/07/2023 23:26, Charlie Jenkins wrote:
> Add tests that enforce mmap hint address behavior. mmap should default
> to sv48. mmap will provide an address at the highest address space that
> can fit into the hint address, unless the hint address is less than sv39
> and not 0, then it will return a sv39 address.
>
> These tests are split into two files: mmap_default.c and mmap_bottomup.c
> because a new process must be exec'd in order to change the mmap layout.
> The run_mmap.sh script sets the stack to be unlimited for the
> mmap_bottomup.c test which triggers a bottomup layout.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   tools/testing/selftests/riscv/Makefile        |  2 +-
>   tools/testing/selftests/riscv/mm/.gitignore   |  2 +
>   tools/testing/selftests/riscv/mm/Makefile     | 15 +++++
>   .../riscv/mm/testcases/mmap_bottomup.c        | 35 ++++++++++
>   .../riscv/mm/testcases/mmap_default.c         | 35 ++++++++++
>   .../selftests/riscv/mm/testcases/mmap_test.h  | 64 +++++++++++++++++++
>   .../selftests/riscv/mm/testcases/run_mmap.sh  | 12 ++++
>   7 files changed, 164 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
>   create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>   create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
>   create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_default.c
>   create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap_test.h
>   create mode 100755 tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
>
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index f4b3d5c9af5b..4a9ff515a3a0 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>   
>   ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe vector
> +RISCV_SUBTARGETS ?= hwprobe vector mm
>   else
>   RISCV_SUBTARGETS :=
>   endif
> diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/selftests/riscv/mm/.gitignore
> new file mode 100644
> index 000000000000..5c2c57cb950c
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/.gitignore
> @@ -0,0 +1,2 @@
> +mmap_bottomup
> +mmap_default
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> new file mode 100644
> index 000000000000..11e0f0568923
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +
> +TEST_GEN_FILES := testcases/mmap_default testcases/mmap_bottomup
> +
> +TEST_PROGS := testcases/run_mmap.sh
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/mm: testcases/mmap_default.c testcases/mmap_bottomup.c testcases/mmap_tests.h
> +	$(CC) -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c b/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
> new file mode 100644
> index 000000000000..b29379f7e478
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/mmap_bottomup.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/mman.h>
> +#include <testcases/mmap_test.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +TEST(infinite_rlimit)
> +{
> +// Only works on 64 bit
> +#if __riscv_xlen == 64
> +	struct addresses mmap_addresses;
> +
> +	EXPECT_EQ(BOTTOM_UP, memory_layout());
> +
> +	do_mmaps(&mmap_addresses);
> +
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
> +
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);


This test ^ will only work on sv48+ systems, if launched on a sv39 
system, it will fail


> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
> +	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
> +#endif
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_default.c b/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
> new file mode 100644
> index 000000000000..d1accb91b726
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/mmap_default.c
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/mman.h>
> +#include <testcases/mmap_test.h>
> +
> +#include "../../kselftest_harness.h"
> +
> +TEST(default_rlimit)
> +{
> +// Only works on 64 bit
> +#if __riscv_xlen == 64
> +	struct addresses mmap_addresses;
> +
> +	EXPECT_EQ(TOP_DOWN, memory_layout());
> +
> +	do_mmaps(&mmap_addresses);
> +
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.no_hint);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_37_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_38_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_46_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_47_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_55_addr);
> +	EXPECT_NE(MAP_FAILED, mmap_addresses.on_56_addr);
> +
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.no_hint);
> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_37_addr);
> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_38_addr);
> +	EXPECT_GT(1UL << 38, (unsigned long)mmap_addresses.on_46_addr);
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_47_addr);
> +	EXPECT_GT(1UL << 47, (unsigned long)mmap_addresses.on_55_addr);
> +	EXPECT_GT(1UL << 56, (unsigned long)mmap_addresses.on_56_addr);
> +#endif
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap_test.h b/tools/testing/selftests/riscv/mm/testcases/mmap_test.h
> new file mode 100644
> index 000000000000..98a892de5d19
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/mmap_test.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _TESTCASES_MMAP_TEST_H
> +#define _TESTCASES_MMAP_TEST_H
> +#include <sys/mman.h>
> +#include <sys/resource.h>
> +#include <stddef.h>
> +
> +#define TOP_DOWN 0
> +#define BOTTOM_UP 1
> +
> +struct addresses {
> +	int *no_hint;
> +	int *on_37_addr;
> +	int *on_38_addr;
> +	int *on_46_addr;
> +	int *on_47_addr;
> +	int *on_55_addr;
> +	int *on_56_addr;
> +};
> +
> +void do_mmaps(struct addresses *mmap_addresses)


I would static inline this function definition since you are in a header 
file.


> +{
> +	/*
> +	 * Place all of the hint addresses on the boundaries of mmap
> +	 * sv39, sv48, sv57
> +	 * User addresses end at 1<<38, 1<<47, 1<<56 respectively
> +	 */
> +	void *on_37_bits = (void *)(1UL << 37);
> +	void *on_38_bits = (void *)(1UL << 38);
> +	void *on_46_bits = (void *)(1UL << 46);
> +	void *on_47_bits = (void *)(1UL << 47);
> +	void *on_55_bits = (void *)(1UL << 55);
> +	void *on_56_bits = (void *)(1UL << 56);
> +
> +	int prot = PROT_READ | PROT_WRITE;
> +	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> +
> +	mmap_addresses->no_hint =
> +		mmap(NULL, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_37_addr =
> +		mmap(on_37_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_38_addr =
> +		mmap(on_38_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_46_addr =
> +		mmap(on_46_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_47_addr =
> +		mmap(on_47_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_55_addr =
> +		mmap(on_55_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +	mmap_addresses->on_56_addr =
> +		mmap(on_56_bits, 5 * sizeof(int), prot, flags, 0, 0);
> +}
> +
> +int memory_layout(void)
> +{
> +	int prot = PROT_READ | PROT_WRITE;
> +	int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> +
> +	void *value1 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
> +	void *value2 = mmap(NULL, sizeof(int), prot, flags, 0, 0);
> +
> +	return value2 > value1;
> +}
> +#endif /* _TESTCASES_MMAP_TEST_H */
> diff --git a/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh b/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
> new file mode 100755
> index 000000000000..ca5ad7c48bad
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/run_mmap.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +
> +original_stack_limit=$(ulimit -s)
> +
> +./mmap_default
> +
> +# Force mmap_bottomup to be ran with bottomup memory due to
> +# the unlimited stack
> +ulimit -s unlimited
> +./mmap_bottomup
> +ulimit -s $original_stack_limit
