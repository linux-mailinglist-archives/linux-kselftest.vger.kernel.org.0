Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CB2749818
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjGFJRp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGFJRo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:17:44 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57881725;
        Thu,  6 Jul 2023 02:17:41 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id E21D72000A;
        Thu,  6 Jul 2023 09:17:34 +0000 (UTC)
Message-ID: <b63134b3-f7dd-b880-1f2a-027d681b64ce@ghiti.fr>
Date:   Thu, 6 Jul 2023 11:17:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v3 2/2] RISC-V: mm: Update documentation and
 include test
Content-Language: en-US
To:     Charlie Jenkins <charlie@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     conor@kernel.org, paul.walmsley@sifive.com, palmer@rivosinc.com,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        mick@ics.forth.gr, jrtc27@jrtc27.com
References: <20230705190002.384799-1-charlie@rivosinc.com>
 <20230705190002.384799-3-charlie@rivosinc.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230705190002.384799-3-charlie@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 05/07/2023 20:59, Charlie Jenkins wrote:
> Add documentation explaining the behavior of mmap. Include
> a simple test that ensures that mmap returns an address less
> than the hint address while there are still addresses available.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>   Documentation/riscv/vm-layout.rst             | 22 +++++++++
>   arch/riscv/include/asm/pgtable.h              |  8 +--
>   tools/testing/selftests/riscv/Makefile        |  2 +-
>   tools/testing/selftests/riscv/mm/.gitignore   |  1 +
>   tools/testing/selftests/riscv/mm/Makefile     | 21 ++++++++
>   .../selftests/riscv/mm/testcases/mmap.c       | 49 +++++++++++++++++++
>   6 files changed, 99 insertions(+), 4 deletions(-)
>   create mode 100644 tools/testing/selftests/riscv/mm/.gitignore
>   create mode 100644 tools/testing/selftests/riscv/mm/Makefile
>   create mode 100644 tools/testing/selftests/riscv/mm/testcases/mmap.c
>
> diff --git a/Documentation/riscv/vm-layout.rst b/Documentation/riscv/vm-layout.rst
> index 5462c84f4723..a610c68c9f3f 100644
> --- a/Documentation/riscv/vm-layout.rst
> +++ b/Documentation/riscv/vm-layout.rst
> @@ -133,3 +133,25 @@ RISC-V Linux Kernel SV57
>      ffffffff00000000 |  -4     GB | ffffffff7fffffff |    2 GB | modules, BPF
>      ffffffff80000000 |  -2     GB | ffffffffffffffff |    2 GB | kernel
>     __________________|____________|__________________|_________|____________________________________________________________
> +
> +
> +Userspace VAs
> +--------------------
> +To maintain compatibility with software that relies on the VA space
> +with a maximum of 39-bits, the kernel will, by default, return virtual
> +return virtual addresses to userspace from a 48-bit range (sv48).


Hmmm weird, you say that applications that requires 38-bit address space 
will be given a 47-bit address by default?


>   This
> +default behavior is achieved by passing 0 into the hint address parameter
> +of mmap.
> +
> +Software can "opt-in" to receiving VAs from other VA space by providing
> +a hint address to mmap. A call to mmap is guaranteed to return an address
> +that will not override the unset left-aligned bits in the hint address,
> +unless there is no space left in the address space. If there is no space
> +available in the requested address space, an address in the next smallest
> +available address space will be returned.
> +
> +For example, in order to obtain 48-bit VA space, a hint address greater than
> +:code:`1 << 38` must be provided. Note that this is 38 due to sv39 userspace
> +ending at :code:`1 << 38` with the addresses beyond this and up to :code:`1 << 39`


Not "up to" since actually the MSB will all be set for the kernel 
address space, so that would be up to (1 << 64) - 1.


> +being reserved for the kernel. Similarly, to obtain 57-bit VA space addresses, a
> +hint address greater than or equal to :code:`1 << 47` must be provided.
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 752e210c7547..5ac973193fab 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -841,14 +841,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>    * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>    * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>    * Task size is:
> - * -     0x9fc00000 (~2.5GB) for RV32.
> - * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
> - * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
> + * -        0x9fc00000	(~2.5GB) for RV32.
> + * -      0x4000000000	( 256GB) for RV64 using SV39 mmu
> + * -    0x800000000000	( 128TB) for RV64 using SV48 mmu
> + * - 0x100000000000000	(  64PB) for RV64 using SV57 mmu
>    *
>    * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
>    * Instruction Set Manual Volume II: Privileged Architecture" states that
>    * "load and store effective addresses, which are 64bits, must have bits
>    * 63–48 all equal to bit 47, or else a page-fault exception will occur."
> + * Similarly for SV57, bits 63–57 must be equal to bit 56.


This change should go in its own patch. And you should split this patch 
into the documentation update and the addition of the test, both are 
independent.


>    */
>   #ifdef CONFIG_64BIT
>   #define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
> index 32a72902d045..0fee58f990ae 100644
> --- a/tools/testing/selftests/riscv/Makefile
> +++ b/tools/testing/selftests/riscv/Makefile
> @@ -5,7 +5,7 @@
>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>   
>   ifneq (,$(filter $(ARCH),riscv))
> -RISCV_SUBTARGETS ?= hwprobe
> +RISCV_SUBTARGETS ?= hwprobe mm
>   else
>   RISCV_SUBTARGETS :=
>   endif
> diff --git a/tools/testing/selftests/riscv/mm/.gitignore b/tools/testing/selftests/riscv/mm/.gitignore
> new file mode 100644
> index 000000000000..022ea0a3f7df
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/.gitignore
> @@ -0,0 +1 @@
> +mmap
> \ No newline at end of file
> diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
> new file mode 100644
> index 000000000000..d41a0b3d2ca2
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/Makefile
> @@ -0,0 +1,21 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Originally tools/testing/selftests/arm64/signal
> +
> +# Additional include paths needed by kselftest.h and local headers
> +CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
> +
> +SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
> +PROGS := $(patsubst %.c,%,$(SRCS))
> +
> +# Generated binaries to be installed by top KSFT script
> +TEST_GEN_PROGS := $(notdir $(PROGS))
> +
> +# Get Kernel headers installed and use them.
> +
> +# Including KSFT lib.mk here will also mangle the TEST_GEN_PROGS list
> +# to account for any OUTPUT target-dirs optionally provided by
> +# the toplevel makefile
> +include ../../lib.mk
> +
> +$(TEST_GEN_PROGS): $(PROGS)
> +	cp $(PROGS) $(OUTPUT)/
> \ No newline at end of file
> diff --git a/tools/testing/selftests/riscv/mm/testcases/mmap.c b/tools/testing/selftests/riscv/mm/testcases/mmap.c
> new file mode 100644
> index 000000000000..781576f4c14b
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/mm/testcases/mmap.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <sys/mman.h>
> +#include "../../kselftest_harness.h"
> +
> +TEST(sv57_test)
> +{
> +		// Only works on 64 bit
> +		#if __riscv_xlen == 64
> +		// Place all of the hint addresses on the boundaries of mmap
> +		// sv39, sv48, sv57
> +		// User addresses end at 1<<38, 1<<47, 1<<56 respectively
> +		void *on_37_bits = (void *) (1UL << 37);
> +		void *on_38_bits = (void *) (1UL << 38);
> +		void *on_46_bits = (void *) (1UL << 46);
> +		void *on_47_bits = (void *) (1UL << 47);
> +		void *on_55_bits = (void *) (1UL << 55);
> +		void *on_56_bits = (void *) (1UL << 56);
> +
> +		int prot = PROT_READ | PROT_WRITE;
> +		int flags = MAP_PRIVATE | MAP_ANONYMOUS;
> +
> +		int *no_hint = mmap(NULL, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_37_addr = mmap(on_37_bits, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_38_addr = mmap(on_38_bits, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_46_addr = mmap(on_46_bits, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_47_addr = mmap(on_47_bits, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_55_addr = mmap(on_55_bits, 5*sizeof(int), prot, flags, 0, 0);
> +		int *on_56_addr = mmap(on_56_bits, 5*sizeof(int), prot, flags, 0, 0);
> +
> +		EXPECT_NE(no_hint, MAP_FAILED);
> +		EXPECT_NE(on_37_addr, MAP_FAILED);
> +		EXPECT_NE(on_38_addr, MAP_FAILED);
> +		EXPECT_NE(on_46_addr, MAP_FAILED);
> +		EXPECT_NE(on_47_addr, MAP_FAILED);
> +		EXPECT_NE(on_55_addr, MAP_FAILED);
> +		EXPECT_NE(on_56_addr, MAP_FAILED);
> +
> +		EXPECT_LT((unsigned long) no_hint, 1UL << 47);
> +		EXPECT_LT((unsigned long) on_37_addr, 1UL << 38);
> +		EXPECT_LT((unsigned long) on_38_addr, 1UL << 38);
> +		EXPECT_LT((unsigned long) on_46_addr, 1UL << 38);
> +		EXPECT_LT((unsigned long) on_47_addr, 1UL << 47);
> +		EXPECT_LT((unsigned long) on_55_addr, 1UL << 47);
> +		EXPECT_LT((unsigned long) on_56_addr, 1UL << 57);
> +		#else
> +		#endif
> +}
> +
> +TEST_HARNESS_MAIN
