Return-Path: <linux-kselftest+bounces-35689-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F369BAE6555
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 14:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E84C0E7D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 12:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A896E227EA7;
	Tue, 24 Jun 2025 12:46:35 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64129295DBC;
	Tue, 24 Jun 2025 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769195; cv=none; b=k0YOeq2HnLAQCRn0bthzd8fmuGN0WECVhx2T1ZSqdjYSi3QnJEAYZLgkjFW3mePnCyT+D9hAGzDof3bhUuEHAeMfUzTEOJdgQGssJVQ5GRfkM+t7+qBdZawQ+cuf0x+tEUH370bqxXdizEJqVk4IdBpUkTubN6YpUE9XVq3utvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769195; c=relaxed/simple;
	bh=H4mTTc4/8GpuQjUEkKvxReEA9Vc1UvXXxM/gOCikNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IIDs8gGyG9sOIwq75MB3BKxfelLje/vVz3sYtrcn3z1B/O4hIUTnfqTCmtyI3MISJsExBKQzIed9YAcNnUjHd40QnXjkxYKc8l0IeQQaYGlADYjPyjDqj3DJZZ8/t1sHIPTG9sK9N2aPCQbCftjCExBq9ekjjbsYnR1GXGAtBZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F850439F8;
	Tue, 24 Jun 2025 12:46:23 +0000 (UTC)
Message-ID: <6b69dc3b-7c48-4079-827a-f6eacfe5829c@ghiti.fr>
Date: Tue, 24 Jun 2025 14:46:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests: riscv: add misaligned access testing
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>
References: <20250522125103.4127219-1-cleger@rivosinc.com>
 <1aaeb582-8619-42b2-9390-84d288c6d2fd@rivosinc.com>
Content-Language: en-US
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <1aaeb582-8619-42b2-9390-84d288c6d2fd@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduleelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeetlhgvgigrnhgurhgvucfihhhithhiuceorghlvgigsehghhhithhirdhfrheqnecuggftrfgrthhtvghrnhepkeekffdtuefhudegfffghfeuudeutddtkeekffeukeefvdejhfelieegheeiieejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghomhhmohhnrdhssgdpfhhpuhdrshgsnecukfhppedvtddtudemkeeiudemfeefkedvmegvfheltdemfegrsgdtmedujegvtdemhegshegsmeefiedtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvtddtudemkeeiudemfeefkedvmegvfheltdemfegrsgdtmedujegvtdemhegshegsmeefiedtiedphhgvlhhopeglkffrggeimedvtddtudemkeeiudemfeefkedvmegvfheltdemfegrsgdtmedujegvtdemhegshegsmeefiedtiegnpdhmrghilhhfrhhomheprghlvgigsehghhhithhirdhfrhdpnhgspghrtghpthhtohepjedprhgtphhtthhopegtlhgvghgvrhesrhhivhhoshhinhgtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvr
 hdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhrihhstghvsehlihhsthhsrdhinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepphgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiesshhifhhivhgvrdgtohhmpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-GND-Sasl: alex@ghiti.fr

On 6/24/25 14:34, Clément Léger wrote:
> Gentle ping.


I put it back again on my for-next branch.

Thanks,

Alex


>
> Thanks,
>
> Clément
>
> On 22/05/2025 14:51, Clément Léger wrote:
>> This selftest tests all the currently emulated instructions (except for
>> the RV32 compressed ones which are left as a future exercise for a RV32
>> user). For the FPU instructions, all the FPU registers are tested.
>>
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>
>> Note: This test can be executed with the FWFT series [1] or using an SBI
>> firmware that delegates misaligned traps by default. If using QEMU,
>> you will need the patches mentioned at [2] so that misaligned accesses
>> will generate a trap.
>>
>> Note: This commit was part of a series [3] that was partially merged.
>>
>> Note: the remaining checkpatch errors are not applicable to this tests
>> which is a user-space one and does not use the kernel headers. Macros
>> with complex values can not be enclosed in do while loop since they are
>> generating functions.
>>
>> Link: https://lore.kernel.org/all/20250424173204.1948385-1-cleger@rivosinc.com/ [1]
>> Link: https://lore.kernel.org/all/20241211211933.198792-1-fkonrad@amd.com/ [2]
>> Link: https://lore.kernel.org/linux-riscv/20250422162324.956065-1-cleger@rivosinc.com/ [3]
>>
>> V3:
>>   - Fixed a segfault and a sign extension error found when compiling with
>>    -O<x>, x != 0 (Alex)
>>   - Use inline assembly to generate the sigbus and avoid GCC
>>     optimizations
>>
>> V2:
>>   - Fix commit description
>>   - Fix a few errors reported by checkpatch.pl
>>
>>   tools/testing/selftests/riscv/Makefile        |   2 +-
>>   .../selftests/riscv/misaligned/.gitignore     |   1 +
>>   .../selftests/riscv/misaligned/Makefile       |  12 +
>>   .../selftests/riscv/misaligned/common.S       |  33 +++
>>   .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
>>   tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
>>   .../selftests/riscv/misaligned/misaligned.c   | 253 ++++++++++++++++++
>>   7 files changed, 583 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/misaligned.c
>>
>> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
>> index 099b8c1f46f8..95a98ceeb3b3 100644
>> --- a/tools/testing/selftests/riscv/Makefile
>> +++ b/tools/testing/selftests/riscv/Makefile
>> @@ -5,7 +5,7 @@
>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>   
>>   ifneq (,$(filter $(ARCH),riscv))
>> -RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
>> +RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector misaligned
>>   else
>>   RISCV_SUBTARGETS :=
>>   endif
>> diff --git a/tools/testing/selftests/riscv/misaligned/.gitignore b/tools/testing/selftests/riscv/misaligned/.gitignore
>> new file mode 100644
>> index 000000000000..5eff15a1f981
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/.gitignore
>> @@ -0,0 +1 @@
>> +misaligned
>> diff --git a/tools/testing/selftests/riscv/misaligned/Makefile b/tools/testing/selftests/riscv/misaligned/Makefile
>> new file mode 100644
>> index 000000000000..1aa40110c50d
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/Makefile
>> @@ -0,0 +1,12 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (C) 2021 ARM Limited
>> +# Originally tools/testing/arm64/abi/Makefile
>> +
>> +CFLAGS += -I$(top_srcdir)/tools/include
>> +
>> +TEST_GEN_PROGS := misaligned
>> +
>> +include ../../lib.mk
>> +
>> +$(OUTPUT)/misaligned: misaligned.c fpu.S gp.S
>> +	$(CC) -g3 -static -o$@ -march=rv64imafdc $(CFLAGS) $(LDFLAGS) $^
>> diff --git a/tools/testing/selftests/riscv/misaligned/common.S b/tools/testing/selftests/riscv/misaligned/common.S
>> new file mode 100644
>> index 000000000000..8fa00035bd5d
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/common.S
>> @@ -0,0 +1,33 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +.macro lb_sb temp, offset, src, dst
>> +	lb \temp, \offset(\src)
>> +	sb \temp, \offset(\dst)
>> +.endm
>> +
>> +.macro copy_long_to temp, src, dst
>> +	lb_sb \temp, 0, \src, \dst,
>> +	lb_sb \temp, 1, \src, \dst,
>> +	lb_sb \temp, 2, \src, \dst,
>> +	lb_sb \temp, 3, \src, \dst,
>> +	lb_sb \temp, 4, \src, \dst,
>> +	lb_sb \temp, 5, \src, \dst,
>> +	lb_sb \temp, 6, \src, \dst,
>> +	lb_sb \temp, 7, \src, \dst,
>> +.endm
>> +
>> +.macro sp_stack_prologue offset
>> +	addi sp, sp, -8
>> +	sub sp, sp, \offset
>> +.endm
>> +
>> +.macro sp_stack_epilogue offset
>> +	add sp, sp, \offset
>> +	addi sp, sp, 8
>> +.endm
>> diff --git a/tools/testing/selftests/riscv/misaligned/fpu.S b/tools/testing/selftests/riscv/misaligned/fpu.S
>> new file mode 100644
>> index 000000000000..a7ad4430a424
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/fpu.S
>> @@ -0,0 +1,180 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +#include "common.S"
>> +
>> +#define CASE_ALIGN		4
>> +
>> +.macro fpu_load_inst fpreg, inst, precision, load_reg
>> +.align CASE_ALIGN
>> +	\inst \fpreg, 0(\load_reg)
>> +	fmv.\precision fa0, \fpreg
>> +	j 2f
>> +.endm
>> +
>> +#define flw(__fpreg) fpu_load_inst __fpreg, flw, s, a4
>> +#define fld(__fpreg) fpu_load_inst __fpreg, fld, d, a4
>> +#define c_flw(__fpreg) fpu_load_inst __fpreg, c.flw, s, a4
>> +#define c_fld(__fpreg) fpu_load_inst __fpreg, c.fld, d, a4
>> +#define c_fldsp(__fpreg) fpu_load_inst __fpreg, c.fldsp, d, sp
>> +
>> +.macro fpu_store_inst fpreg, inst, precision, store_reg
>> +.align CASE_ALIGN
>> +	fmv.\precision \fpreg, fa0
>> +	\inst \fpreg, 0(\store_reg)
>> +	j 2f
>> +.endm
>> +
>> +#define fsw(__fpreg) fpu_store_inst __fpreg, fsw, s, a4
>> +#define fsd(__fpreg) fpu_store_inst __fpreg, fsd, d, a4
>> +#define c_fsw(__fpreg) fpu_store_inst __fpreg, c.fsw, s, a4
>> +#define c_fsd(__fpreg) fpu_store_inst __fpreg, c.fsd, d, a4
>> +#define c_fsdsp(__fpreg) fpu_store_inst __fpreg, c.fsdsp, d, sp
>> +
>> +.macro fp_test_prologue
>> +	move a4, a1
>> +	/*
>> +	 * Compute jump offset to store the correct FP register since we don't
>> +	 * have indirect FP register access (or at least we don't use this
>> +	 * extension so that works on all archs)
>> +	 */
>> +	sll t0, a0, CASE_ALIGN
>> +	la t2, 1f
>> +	add t0, t0, t2
>> +	jr t0
>> +.align	CASE_ALIGN
>> +1:
>> +.endm
>> +
>> +.macro fp_test_prologue_compressed
>> +	/* FP registers for compressed instructions starts from 8 to 16 */
>> +	addi a0, a0, -8
>> +	fp_test_prologue
>> +.endm
>> +
>> +#define fp_test_body_compressed(__inst_func) \
>> +	__inst_func(f8); \
>> +	__inst_func(f9); \
>> +	__inst_func(f10); \
>> +	__inst_func(f11); \
>> +	__inst_func(f12); \
>> +	__inst_func(f13); \
>> +	__inst_func(f14); \
>> +	__inst_func(f15); \
>> +2:
>> +
>> +#define fp_test_body(__inst_func) \
>> +	__inst_func(f0); \
>> +	__inst_func(f1); \
>> +	__inst_func(f2); \
>> +	__inst_func(f3); \
>> +	__inst_func(f4); \
>> +	__inst_func(f5); \
>> +	__inst_func(f6); \
>> +	__inst_func(f7); \
>> +	__inst_func(f8); \
>> +	__inst_func(f9); \
>> +	__inst_func(f10); \
>> +	__inst_func(f11); \
>> +	__inst_func(f12); \
>> +	__inst_func(f13); \
>> +	__inst_func(f14); \
>> +	__inst_func(f15); \
>> +	__inst_func(f16); \
>> +	__inst_func(f17); \
>> +	__inst_func(f18); \
>> +	__inst_func(f19); \
>> +	__inst_func(f20); \
>> +	__inst_func(f21); \
>> +	__inst_func(f22); \
>> +	__inst_func(f23); \
>> +	__inst_func(f24); \
>> +	__inst_func(f25); \
>> +	__inst_func(f26); \
>> +	__inst_func(f27); \
>> +	__inst_func(f28); \
>> +	__inst_func(f29); \
>> +	__inst_func(f30); \
>> +	__inst_func(f31); \
>> +2:
>> +.text
>> +
>> +#define __gen_test_inst(__inst, __suffix) \
>> +.global test_ ## __inst; \
>> +test_ ## __inst:; \
>> +	fp_test_prologue ## __suffix; \
>> +	fp_test_body ## __suffix(__inst); \
>> +	ret
>> +
>> +#define gen_test_inst_compressed(__inst) \
>> +	.option arch,+c; \
>> +	__gen_test_inst(c_ ## __inst, _compressed)
>> +
>> +#define gen_test_inst(__inst) \
>> +	.balign 16; \
>> +	.option push; \
>> +	.option arch,-c; \
>> +	__gen_test_inst(__inst, ); \
>> +	.option pop
>> +
>> +.macro fp_test_prologue_load_compressed_sp
>> +	copy_long_to t0, a1, sp
>> +.endm
>> +
>> +.macro fp_test_epilogue_load_compressed_sp
>> +.endm
>> +
>> +.macro fp_test_prologue_store_compressed_sp
>> +.endm
>> +
>> +.macro fp_test_epilogue_store_compressed_sp
>> +	copy_long_to t0, sp, a1
>> +.endm
>> +
>> +#define gen_inst_compressed_sp(__inst, __type) \
>> +	.global test_c_ ## __inst ## sp; \
>> +	test_c_ ## __inst ## sp:; \
>> +		sp_stack_prologue a2; \
>> +		fp_test_prologue_## __type ## _compressed_sp; \
>> +		fp_test_prologue_compressed; \
>> +		fp_test_body_compressed(c_ ## __inst ## sp); \
>> +		fp_test_epilogue_## __type ## _compressed_sp; \
>> +		sp_stack_epilogue a2; \
>> +		ret
>> +
>> +#define gen_test_load_compressed_sp(__inst) gen_inst_compressed_sp(__inst, load)
>> +#define gen_test_store_compressed_sp(__inst) gen_inst_compressed_sp(__inst, store)
>> +
>> +/*
>> + * float_fsw_reg - Set a FP register from a register containing the value
>> + * a0 = FP register index to be set
>> + * a1 = addr where to store register value
>> + * a2 = address offset
>> + * a3 = value to be store
>> + */
>> +gen_test_inst(fsw)
>> +
>> +/*
>> + * float_flw_reg - Get a FP register value and return it
>> + * a0 = FP register index to be retrieved
>> + * a1 = addr to load register from
>> + * a2 = address offset
>> + */
>> +gen_test_inst(flw)
>> +
>> +gen_test_inst(fsd)
>> +#ifdef __riscv_compressed
>> +gen_test_inst_compressed(fsd)
>> +gen_test_store_compressed_sp(fsd)
>> +#endif
>> +
>> +gen_test_inst(fld)
>> +#ifdef __riscv_compressed
>> +gen_test_inst_compressed(fld)
>> +gen_test_load_compressed_sp(fld)
>> +#endif
>> diff --git a/tools/testing/selftests/riscv/misaligned/gp.S b/tools/testing/selftests/riscv/misaligned/gp.S
>> new file mode 100644
>> index 000000000000..f53f4c6d81dd
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/gp.S
>> @@ -0,0 +1,103 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +#include "common.S"
>> +
>> +.text
>> +
>> +.macro __gen_test_inst inst, src_reg
>> +	\inst a2, 0(\src_reg)
>> +	move a0, a2
>> +.endm
>> +
>> +.macro gen_func_header func_name, rvc
>> +	.option arch,\rvc
>> +	.global test_\func_name
>> +	test_\func_name:
>> +.endm
>> +
>> +.macro gen_test_inst inst
>> +	.option push
>> +	gen_func_header \inst, -c
>> +	__gen_test_inst \inst, a0
>> +	.option pop
>> +	ret
>> +.endm
>> +
>> +.macro __gen_test_inst_c name, src_reg
>> +	.option push
>> +	gen_func_header c_\name, +c
>> +	 __gen_test_inst c.\name, \src_reg
>> +	.option pop
>> +	ret
>> +.endm
>> +
>> +.macro gen_test_inst_c name
>> + 	__gen_test_inst_c \name, a0
>> +.endm
>> +
>> +
>> +.macro gen_test_inst_load_c_sp name
>> +	.option push
>> +	gen_func_header c_\name\()sp, +c
>> +	sp_stack_prologue a1
>> +	copy_long_to t0, a0, sp
>> +	c.ldsp a0, 0(sp)
>> +	sp_stack_epilogue a1
>> +	.option pop
>> +	ret
>> +.endm
>> +
>> +.macro lb_sp_sb_a0 reg, offset
>> +	lb_sb \reg, \offset, sp, a0
>> +.endm
>> +
>> +.macro gen_test_inst_store_c_sp inst_name
>> +	.option push
>> +	gen_func_header c_\inst_name\()sp, +c
>> +	/* Misalign stack pointer */
>> +	sp_stack_prologue a1
>> +	/* Misalign access */
>> +	c.sdsp a2, 0(sp)
>> +	copy_long_to t0, sp, a0
>> +	sp_stack_epilogue a1
>> +	.option pop
>> +	ret
>> +.endm
>> +
>> +
>> + /*
>> + * a0 = addr to load from
>> + * a1 = address offset
>> + * a2 = value to be loaded
>> + */
>> +gen_test_inst lh
>> +gen_test_inst lhu
>> +gen_test_inst lw
>> +gen_test_inst lwu
>> +gen_test_inst ld
>> +#ifdef __riscv_compressed
>> +gen_test_inst_c lw
>> +gen_test_inst_c ld
>> +gen_test_inst_load_c_sp ld
>> +#endif
>> +
>> +/*
>> + * a0 = addr where to store value
>> + * a1 = address offset
>> + * a2 = value to be stored
>> + */
>> +gen_test_inst sh
>> +gen_test_inst sw
>> +gen_test_inst sd
>> +#ifdef __riscv_compressed
>> +gen_test_inst_c sw
>> +gen_test_inst_c sd
>> +gen_test_inst_store_c_sp sd
>> +#endif
>> +
>> diff --git a/tools/testing/selftests/riscv/misaligned/misaligned.c b/tools/testing/selftests/riscv/misaligned/misaligned.c
>> new file mode 100644
>> index 000000000000..50cd8f5ece94
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/misaligned.c
>> @@ -0,0 +1,253 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +#include <signal.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <linux/ptrace.h>
>> +#include "../../kselftest_harness.h"
>> +
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <stdint.h>
>> +#include <float.h>
>> +#include <errno.h>
>> +#include <math.h>
>> +#include <string.h>
>> +#include <signal.h>
>> +#include <stdbool.h>
>> +#include <unistd.h>
>> +#include <inttypes.h>
>> +#include <ucontext.h>
>> +
>> +#include <sys/prctl.h>
>> +
>> +#define stringify(s) __stringify(s)
>> +#define __stringify(s) #s
>> +
>> +#define VAL16	0x1234U
>> +#define VAL32	0x5EADBEEFUL
>> +#define VAL64	0x45674321D00DF789ULL
>> +
>> +#define VAL_float	78951.234375
>> +#define VAL_double	567890.512396965789589290
>> +
>> +static bool float_equal(float a, float b)
>> +{
>> +	float scaled_epsilon;
>> +	float difference = fabsf(a - b);
>> +
>> +	// Scale to the largest value.
>> +	a = fabsf(a);
>> +	b = fabsf(b);
>> +	if (a > b)
>> +		scaled_epsilon = FLT_EPSILON * a;
>> +	else
>> +		scaled_epsilon = FLT_EPSILON * b;
>> +
>> +	return difference <= scaled_epsilon;
>> +}
>> +
>> +static bool double_equal(double a, double b)
>> +{
>> +	double scaled_epsilon;
>> +	double difference = fabsl(a - b);
>> +
>> +	// Scale to the largest value.
>> +	a = fabs(a);
>> +	b = fabs(b);
>> +	if (a > b)
>> +		scaled_epsilon = DBL_EPSILON * a;
>> +	else
>> +		scaled_epsilon = DBL_EPSILON * b;
>> +
>> +	return difference <= scaled_epsilon;
>> +}
>> +
>> +#define fpu_load_proto(__inst, __type) \
>> +extern __type test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
>> +
>> +fpu_load_proto(flw, float);
>> +fpu_load_proto(fld, double);
>> +fpu_load_proto(c_flw, float);
>> +fpu_load_proto(c_fld, double);
>> +fpu_load_proto(c_fldsp, double);
>> +
>> +#define fpu_store_proto(__inst, __type) \
>> +extern void test_ ## __inst(unsigned long fp_reg, void *addr, unsigned long offset, __type value)
>> +
>> +fpu_store_proto(fsw, float);
>> +fpu_store_proto(fsd, double);
>> +fpu_store_proto(c_fsw, float);
>> +fpu_store_proto(c_fsd, double);
>> +fpu_store_proto(c_fsdsp, double);
>> +
>> +#define gp_load_proto(__inst, __type) \
>> +extern __type test_ ## __inst(void *addr, unsigned long offset, __type value)
>> +
>> +gp_load_proto(lh, uint16_t);
>> +gp_load_proto(lhu, uint16_t);
>> +gp_load_proto(lw, uint32_t);
>> +gp_load_proto(lwu, uint32_t);
>> +gp_load_proto(ld, uint64_t);
>> +gp_load_proto(c_lw, uint32_t);
>> +gp_load_proto(c_ld, uint64_t);
>> +gp_load_proto(c_ldsp, uint64_t);
>> +
>> +#define gp_store_proto(__inst, __type) \
>> +extern void test_ ## __inst(void *addr, unsigned long offset, __type value)
>> +
>> +gp_store_proto(sh, uint16_t);
>> +gp_store_proto(sw, uint32_t);
>> +gp_store_proto(sd, uint64_t);
>> +gp_store_proto(c_sw, uint32_t);
>> +gp_store_proto(c_sd, uint64_t);
>> +gp_store_proto(c_sdsp, uint64_t);
>> +
>> +#define TEST_GP_LOAD(__inst, __type_size)					\
>> +TEST(gp_load_ ## __inst)							\
>> +{										\
>> +	int offset, ret;							\
>> +	uint8_t buf[16] __attribute__((aligned(16)));				\
>> +										\
>> +	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
>> +	ASSERT_EQ(ret, 0);							\
>> +										\
>> +	for (offset = 1; offset < (__type_size) / 8; offset++) {		\
>> +		uint ## __type_size ## _t val = VAL ## __type_size;		\
>> +		uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t *)(buf + offset); \
>> +		memcpy(ptr, &val, sizeof(val));					\
>> +		val = test_ ## __inst(ptr, offset, val);			\
>> +		EXPECT_EQ(VAL ## __type_size, val);				\
>> +	}									\
>> +}
>> +
>> +TEST_GP_LOAD(lh, 16);
>> +TEST_GP_LOAD(lhu, 16);
>> +TEST_GP_LOAD(lw, 32);
>> +TEST_GP_LOAD(lwu, 32);
>> +TEST_GP_LOAD(ld, 64);
>> +#ifdef __riscv_compressed
>> +TEST_GP_LOAD(c_lw, 32);
>> +TEST_GP_LOAD(c_ld, 64);
>> +TEST_GP_LOAD(c_ldsp, 64);
>> +#endif
>> +
>> +#define TEST_GP_STORE(__inst, __type_size)					\
>> +TEST(gp_load_ ## __inst)							\
>> +{										\
>> +	int offset, ret;							\
>> +	uint8_t buf[16] __attribute__((aligned(16)));				\
>> +										\
>> +	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
>> +	ASSERT_EQ(ret, 0);							\
>> +										\
>> +	for (offset = 1; offset < (__type_size) / 8; offset++) {		\
>> +		uint ## __type_size ## _t val = VAL ## __type_size;		\
>> +		uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t *)(buf + offset); \
>> +		memset(ptr, 0, sizeof(val));					\
>> +		test_ ## __inst(ptr, offset, val);				\
>> +		memcpy(&val, ptr, sizeof(val));					\
>> +		EXPECT_EQ(VAL ## __type_size, val);				\
>> +	}									\
>> +}
>> +TEST_GP_STORE(sh, 16);
>> +TEST_GP_STORE(sw, 32);
>> +TEST_GP_STORE(sd, 64);
>> +#ifdef __riscv_compressed
>> +TEST_GP_STORE(c_sw, 32);
>> +TEST_GP_STORE(c_sd, 64);
>> +TEST_GP_STORE(c_sdsp, 64);
>> +#endif
>> +
>> +#define __TEST_FPU_LOAD(__type, __inst, __reg_start, __reg_end)			\
>> +TEST(fpu_load_ ## __inst)							\
>> +{										\
>> +	int ret, offset, fp_reg;						\
>> +	uint8_t buf[16] __attribute__((aligned(16)));				\
>> +										\
>> +	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
>> +	ASSERT_EQ(ret, 0);							\
>> +										\
>> +	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {		\
>> +		for (offset = 1; offset < 4; offset++) {			\
>> +			void *load_addr = (buf + offset);			\
>> +			__type val = VAL_ ## __type ;				\
>> +										\
>> +			memcpy(load_addr, &val, sizeof(val));			\
>> +			val = test_ ## __inst(fp_reg, load_addr, offset, val);	\
>> +			EXPECT_TRUE(__type ##_equal(val, VAL_## __type));	\
>> +		}								\
>> +	}									\
>> +}
>> +#define TEST_FPU_LOAD(__type, __inst) \
>> +	__TEST_FPU_LOAD(__type, __inst, 0, 32)
>> +#define TEST_FPU_LOAD_COMPRESSED(__type, __inst) \
>> +	__TEST_FPU_LOAD(__type, __inst, 8, 16)
>> +
>> +TEST_FPU_LOAD(float, flw)
>> +TEST_FPU_LOAD(double, fld)
>> +#ifdef __riscv_compressed
>> +TEST_FPU_LOAD_COMPRESSED(double, c_fld)
>> +TEST_FPU_LOAD_COMPRESSED(double, c_fldsp)
>> +#endif
>> +
>> +#define __TEST_FPU_STORE(__type, __inst, __reg_start, __reg_end)		\
>> +TEST(fpu_store_ ## __inst)							\
>> +{										\
>> +	int ret, offset, fp_reg;						\
>> +	uint8_t buf[16] __attribute__((aligned(16)));				\
>> +										\
>> +	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);			\
>> +	ASSERT_EQ(ret, 0);							\
>> +										\
>> +	for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {		\
>> +		for (offset = 1; offset < 4; offset++) {			\
>> +										\
>> +			void *store_addr = (buf + offset);			\
>> +			__type val = VAL_ ## __type ;				\
>> +										\
>> +			test_ ## __inst(fp_reg, store_addr, offset, val);	\
>> +			memcpy(&val, store_addr, sizeof(val));			\
>> +			EXPECT_TRUE(__type ## _equal(val, VAL_## __type));	\
>> +		}								\
>> +	}									\
>> +}
>> +#define TEST_FPU_STORE(__type, __inst) \
>> +	__TEST_FPU_STORE(__type, __inst, 0, 32)
>> +#define TEST_FPU_STORE_COMPRESSED(__type, __inst) \
>> +	__TEST_FPU_STORE(__type, __inst, 8, 16)
>> +
>> +TEST_FPU_STORE(float, fsw)
>> +TEST_FPU_STORE(double, fsd)
>> +#ifdef __riscv_compressed
>> +TEST_FPU_STORE_COMPRESSED(double, c_fsd)
>> +TEST_FPU_STORE_COMPRESSED(double, c_fsdsp)
>> +#endif
>> +
>> +TEST_SIGNAL(gen_sigbus, SIGBUS)
>> +{
>> +	uint32_t val = VAL32;
>> +	uint8_t buf[16] __attribute__((aligned(16)));
>> +	int ret;
>> +
>> +	ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_SIGBUS);
>> +	ASSERT_EQ(ret, 0);
>> +
>> +	asm volatile("sw %0, 1(%1)" : : "r"(val), "r"(buf) : "memory");
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	int ret, val;
>> +
>> +	ret = prctl(PR_GET_UNALIGN, &val);
>> +	if (ret == -1 && errno == EINVAL)
>> +		ksft_exit_skip("SKIP GET_UNALIGN_CTL not supported\n");
>> +
>> +	exit(test_harness_run(argc, argv));
>> +}

