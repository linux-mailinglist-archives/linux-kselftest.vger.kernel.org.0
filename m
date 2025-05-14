Return-Path: <linux-kselftest+bounces-32929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A5CAB6485
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C3F860E5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 07:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5C41F37D4;
	Wed, 14 May 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nThc2meP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663C418C933
	for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208105; cv=none; b=vBPCTWlL3H3WnO39Y+nwXstyPtaGJISc815KQG7JP31aDIhAcy4ELeFYN1YfcQ6oI3BcbbYCy9KR0v3dtvTH7jUII50+JSE0ocxfxsvp0sqyQnV8TjoPf81j9Hqft2oVqqxFYVbWHTmaPxRAndY6Y78fkUnLCL65fRxNdTDivIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208105; c=relaxed/simple;
	bh=hVcNZv7h5qzT8fOeJcct28SsqpogLe3Ej7l1e34Qsxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERAM0g6us5/W4LI9SZuRhXpTxig7HltFYyvIQu7ExiDkmAriEE1g+R9AP37K/5lEUwBbO+GpA+Oy8d/G6HJQ9h1UjtY8z3s0VUe87gCCoDA8TfAPzqZqR2ZihfJzm2BxEeUdVMi94vqhl3L5k49gWd+wbJBlEoloD/QPNK/oGGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nThc2meP; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43ede096d73so44637535e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 00:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747208101; x=1747812901; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gU2hq19BRpY5AwKFYmqI0bkuya+VnLY9XBuYEL8Vvds=;
        b=nThc2mePsdnUMEf1lyW8Z5g15yOzq5TunmFB3Qxt6mabnUPga+srrIU6Zn8pxFd/hr
         qrZUbsojpJ6lPq9+cV23sL1kZuSQnR49H7rvzaWZnIaJf5qFBISsMlPn3GFAI/D9HYCx
         jByBTaU/uxaekL+3GOJAhaW6GliGxiLdCYERBDBjF7P8KBiiuRrrkd6zltCmpeITeSBP
         MJ9qfEGyWWnDj5XByWOT02klahqEvgJPc3dsM7f6RngVUg6d724Rqa/SGa/CW9PgeRWm
         W868hF/GBH552PfMPH8aA5nDl9cxMP9m9MIuC0a/5Y8Uj0ePCHRnsoRyTR5CHZzTmcKu
         x3NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747208101; x=1747812901;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gU2hq19BRpY5AwKFYmqI0bkuya+VnLY9XBuYEL8Vvds=;
        b=AvV3tO3exlYSZfRwVHuvkHCzDOKAPDm7QEGv1q3eXQKbPa31iIXC9sOjdP+QCcVXY4
         TGUWIqeju5Y5+PlkiIRymM7cx9lG1kbiLRjXzpBJU8ARIZsfT86uxjarrMqSxt8QpsQn
         X60KPoGUwIKyWzXX1aU7BLl04tHctfF+M6YCq88E366PQOEnQeu1kWwp+diWS+G9gCM8
         MzywQFv6M7LE19+rQ9k63//9x89zLXgWLdOAtVHrwVYr0xMc5ddBf22Za6rXGTcky27h
         DjOY3jSXwsoDpisT9sQ/Ycp0CAkrEI153yHVQH3qlYbTXE1FN/RT7XCcNUFe1jK6Gp0j
         PWUA==
X-Forwarded-Encrypted: i=1; AJvYcCXPH01iB9C4j6gbxTZ8MLghZfx36H5mgyuxS+YjgtonmqwDzuZDkP5xj3HpJ9P229suhVxEI7cDWloOY5GlzMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhQhcuSfZWRACdxTdTfZF/78Fv6mXZJL6JBkhHTnL8tAgJ7WP
	j3PeTanYrBhtE9dw8S0jzganV6WH3wPVIfW97TPFEYTOSB5yU4PjuwBAg1AoZlc=
X-Gm-Gg: ASbGncuEUtPYTptKP5yJqvchKb+hO2zwViYVxC+ZvgzOFWb4dkPkXXZXAIobms/twa8
	rL0JZSBux0II2JuAsHfPLJOpq4jUxdhMGYztOmawRjdq9104EGaIRZu1xL1gioOsjvjVrRgjscY
	KMfyUbOddU8d/xlPmcsRmHvGBI10gBXWitlQCJ+Q16ZVTPc6L7HYQ3683zsPtbRYm4zaS4OzRUE
	VGoICMilc03sUa6tJiCtcmIdsIAFD9Nzt0j8Gi71gzpxlE4Fws2WouSP0mWTHHpTb4XBdVQj6DL
	9wM2kus/4WiCdl8fc0KnM4NmIM9Wqhi785H7hglBqqilWGN4ewrI1nNEbR6x6yHU
X-Google-Smtp-Source: AGHT+IHy2CFi0mSDVYmwf/8G67y18LajjdS0MegInQoG7w9E8s9NBTjuNqUm9XyIbiS7Kct5lUedoQ==
X-Received: by 2002:a5d:64c6:0:b0:39e:cbca:7156 with SMTP id ffacd0b85a97d-3a3496957d9mr1961455f8f.1.1747208100281;
        Wed, 14 May 2025 00:35:00 -0700 (PDT)
Received: from [192.168.6.2] ([91.197.138.148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2ab2sm18496180f8f.46.2025.05.14.00.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 00:34:59 -0700 (PDT)
Message-ID: <f2606ce0-b1b5-4601-9dfc-200ec807efd8@rivosinc.com>
Date: Wed, 14 May 2025 09:34:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: riscv: add misaligned access testing
To: Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Shuah Khan <shuah@kernel.org>
References: <20250512084650.985894-1-cleger@rivosinc.com>
 <9e89bd41-db3c-46e8-86bd-4cca5d798a56@ghiti.fr>
Content-Language: en-US
From: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <9e89bd41-db3c-46e8-86bd-4cca5d798a56@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 13/05/2025 13:44, Alexandre Ghiti wrote:
> Hi Clément,
> 
> On 12/05/2025 10:46, Clément Léger wrote:
>> This selftest tests all the currently emulated instruction (except for
>> the RV32 compressed ones which are left as a future exercise for a RV32
>> user). For the FPU instructions, all the FPU registers are tested.
>> This commit can be tested using
> 
> 
> I guess something went wrong here. And the documentation patch
> disappeared too. Can you add a changelog to the next version please?

The documentation change was left out since I felt it was easier to have
two separate patches (not directly related). I'll sent it sepratately.
However, I did messed up the commit description :)

I'll resend it.

Thanks,

Clément

> 
> Thanks,
> 
> Alex
> 
> 
>> Signed-off-by: Clément Léger <cleger@rivosinc.com>
>>
>> ---
>>
>> Note: this test can be executed with the FWFT series [1] or using an SBI
>> firmware that delegates misaligned traps by default. If using QEMU,
>> you will need the patches mentionned at [2] so that misaligned accesses
>> will generate a trap.
>>
>> Link: https://lore.kernel.org/all/20250424173204.1948385-1-
>> cleger@rivosinc.com/ [1]
>> Link: https://lore.kernel.org/all/20241211211933.198792-1-
>> fkonrad@amd.com/ [2]
>>
>>
>>   tools/testing/selftests/riscv/Makefile        |   2 +-
>>   .../selftests/riscv/misaligned/.gitignore     |   1 +
>>   .../selftests/riscv/misaligned/Makefile       |  12 +
>>   .../selftests/riscv/misaligned/common.S       |  33 +++
>>   .../testing/selftests/riscv/misaligned/fpu.S  | 180 +++++++++++++
>>   tools/testing/selftests/riscv/misaligned/gp.S | 103 +++++++
>>   .../selftests/riscv/misaligned/misaligned.c   | 254 ++++++++++++++++++
>>   7 files changed, 584 insertions(+), 1 deletion(-)
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/.gitignore
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/Makefile
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/common.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/fpu.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/gp.S
>>   create mode 100644 tools/testing/selftests/riscv/misaligned/
>> misaligned.c
>>
>> diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/
>> selftests/riscv/Makefile
>> index 099b8c1f46f8..95a98ceeb3b3 100644
>> --- a/tools/testing/selftests/riscv/Makefile
>> +++ b/tools/testing/selftests/riscv/Makefile
>> @@ -5,7 +5,7 @@
>>   ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>>     ifneq (,$(filter $(ARCH),riscv))
>> -RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector
>> +RISCV_SUBTARGETS ?= abi hwprobe mm sigreturn vector misaligned
>>   else
>>   RISCV_SUBTARGETS :=
>>   endif
>> diff --git a/tools/testing/selftests/riscv/misaligned/.gitignore b/
>> tools/testing/selftests/riscv/misaligned/.gitignore
>> new file mode 100644
>> index 000000000000..5eff15a1f981
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/.gitignore
>> @@ -0,0 +1 @@
>> +misaligned
>> diff --git a/tools/testing/selftests/riscv/misaligned/Makefile b/
>> tools/testing/selftests/riscv/misaligned/Makefile
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
>> +    $(CC) -g3 -static -o$@ -march=rv64imafdc $(CFLAGS) $(LDFLAGS) $^
>> diff --git a/tools/testing/selftests/riscv/misaligned/common.S b/
>> tools/testing/selftests/riscv/misaligned/common.S
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
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +.macro lb_sb temp, offset, src, dst
>> +    lb \temp, \offset(\src)
>> +    sb \temp, \offset(\dst)
>> +.endm
>> +
>> +.macro copy_long_to temp, src, dst
>> +    lb_sb \temp, 0, \src, \dst,
>> +    lb_sb \temp, 1, \src, \dst,
>> +    lb_sb \temp, 2, \src, \dst,
>> +    lb_sb \temp, 3, \src, \dst,
>> +    lb_sb \temp, 4, \src, \dst,
>> +    lb_sb \temp, 5, \src, \dst,
>> +    lb_sb \temp, 6, \src, \dst,
>> +    lb_sb \temp, 7, \src, \dst,
>> +.endm
>> +
>> +.macro sp_stack_prologue offset
>> +    addi sp, sp, -8
>> +    sub sp, sp, \offset
>> +.endm
>> +
>> +.macro sp_stack_epilogue offset
>> +    add sp, sp, \offset
>> +    addi sp, sp, 8
>> +.endm
>> diff --git a/tools/testing/selftests/riscv/misaligned/fpu.S b/tools/
>> testing/selftests/riscv/misaligned/fpu.S
>> new file mode 100644
>> index 000000000000..d008bff58310
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/fpu.S
>> @@ -0,0 +1,180 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +#include "common.S"
>> +
>> +#define CASE_ALIGN        4
>> +
>> +.macro fpu_load_inst fpreg, inst, precision, load_reg
>> +.align CASE_ALIGN
>> +    \inst \fpreg, 0(\load_reg)
>> +    fmv.\precision fa0, \fpreg
>> +    j 2f
>> +.endm
>> +
>> +#define flw(__fpreg) fpu_load_inst __fpreg, flw, s, s1
>> +#define fld(__fpreg) fpu_load_inst __fpreg, fld, d, s1
>> +#define c_flw(__fpreg) fpu_load_inst __fpreg, c.flw, s, s1
>> +#define c_fld(__fpreg) fpu_load_inst __fpreg, c.fld, d, s1
>> +#define c_fldsp(__fpreg) fpu_load_inst __fpreg, c.fldsp, d, sp
>> +
>> +.macro fpu_store_inst fpreg, inst, precision, store_reg
>> +.align CASE_ALIGN
>> +    fmv.\precision \fpreg, fa0
>> +    \inst \fpreg, 0(\store_reg)
>> +    j 2f
>> +.endm
>> +
>> +#define fsw(__fpreg) fpu_store_inst __fpreg, fsw, s, s1
>> +#define fsd(__fpreg) fpu_store_inst __fpreg, fsd, d, s1
>> +#define c_fsw(__fpreg) fpu_store_inst __fpreg, c.fsw, s, s1
>> +#define c_fsd(__fpreg) fpu_store_inst __fpreg, c.fsd, d, s1
>> +#define c_fsdsp(__fpreg) fpu_store_inst __fpreg, c.fsdsp, d, sp
>> +
>> +.macro fp_test_prologue
>> +    move s1, a1
>> +    /*
>> +     * Compute jump offset to store the correct FP register since we
>> don't
>> +     * have indirect FP register access (or at least we don't use this
>> +     * extension so that works on all archs)
>> +     */
>> +    sll t0, a0, CASE_ALIGN
>> +    la t2, 1f
>> +    add t0, t0, t2
>> +    jr t0
>> +.align    CASE_ALIGN
>> +1:
>> +.endm
>> +
>> +.macro fp_test_prologue_compressed
>> +    /* FP registers for compressed instructions starts from 8 to 16 */
>> +    addi a0, a0, -8
>> +    fp_test_prologue
>> +.endm
>> +
>> +#define fp_test_body_compressed(__inst_func) \
>> +    __inst_func(f8); \
>> +    __inst_func(f9); \
>> +    __inst_func(f10); \
>> +    __inst_func(f11); \
>> +    __inst_func(f12); \
>> +    __inst_func(f13); \
>> +    __inst_func(f14); \
>> +    __inst_func(f15); \
>> +2:
>> +
>> +#define fp_test_body(__inst_func) \
>> +    __inst_func(f0); \
>> +    __inst_func(f1); \
>> +    __inst_func(f2); \
>> +    __inst_func(f3); \
>> +    __inst_func(f4); \
>> +    __inst_func(f5); \
>> +    __inst_func(f6); \
>> +    __inst_func(f7); \
>> +    __inst_func(f8); \
>> +    __inst_func(f9); \
>> +    __inst_func(f10); \
>> +    __inst_func(f11); \
>> +    __inst_func(f12); \
>> +    __inst_func(f13); \
>> +    __inst_func(f14); \
>> +    __inst_func(f15); \
>> +    __inst_func(f16); \
>> +    __inst_func(f17); \
>> +    __inst_func(f18); \
>> +    __inst_func(f19); \
>> +    __inst_func(f20); \
>> +    __inst_func(f21); \
>> +    __inst_func(f22); \
>> +    __inst_func(f23); \
>> +    __inst_func(f24); \
>> +    __inst_func(f25); \
>> +    __inst_func(f26); \
>> +    __inst_func(f27); \
>> +    __inst_func(f28); \
>> +    __inst_func(f29); \
>> +    __inst_func(f30); \
>> +    __inst_func(f31); \
>> +2:
>> +.text
>> +
>> +#define __gen_test_inst(__inst, __suffix) \
>> +.global test_ ## __inst; \
>> +test_ ## __inst:; \
>> +    fp_test_prologue ## __suffix; \
>> +    fp_test_body ## __suffix(__inst); \
>> +    ret
>> +
>> +#define gen_test_inst_compressed(__inst) \
>> +    .option arch,+c; \
>> +    __gen_test_inst(c_ ## __inst, _compressed)
>> +
>> +#define gen_test_inst(__inst) \
>> +    .balign 16; \
>> +    .option push; \
>> +    .option arch,-c; \
>> +    __gen_test_inst(__inst, ); \
>> +    .option pop
>> +
>> +.macro fp_test_prologue_load_compressed_sp
>> +    copy_long_to t0, a1, sp
>> +.endm
>> +
>> +.macro fp_test_epilogue_load_compressed_sp
>> +.endm
>> +
>> +.macro fp_test_prologue_store_compressed_sp
>> +.endm
>> +
>> +.macro fp_test_epilogue_store_compressed_sp
>> +    copy_long_to t0, sp, a1
>> +.endm
>> +
>> +#define gen_inst_compressed_sp(__inst, __type) \
>> +    .global test_c_ ## __inst ## sp; \
>> +    test_c_ ## __inst ## sp:; \
>> +        sp_stack_prologue a2; \
>> +        fp_test_prologue_## __type ## _compressed_sp; \
>> +        fp_test_prologue_compressed; \
>> +        fp_test_body_compressed(c_ ## __inst ## sp); \
>> +        fp_test_epilogue_## __type ## _compressed_sp; \
>> +        sp_stack_epilogue a2; \
>> +        ret
>> +
>> +#define gen_test_load_compressed_sp(__inst)
>> gen_inst_compressed_sp(__inst, load)
>> +#define gen_test_store_compressed_sp(__inst)
>> gen_inst_compressed_sp(__inst, store)
>> +
>> +/*
>> + * float_fsw_reg - Set a FP register from a register containing the
>> value
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
>> diff --git a/tools/testing/selftests/riscv/misaligned/gp.S b/tools/
>> testing/selftests/riscv/misaligned/gp.S
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
>> + *     Clément Léger <cleger@rivosinc.com>
>> + */
>> +
>> +#include "common.S"
>> +
>> +.text
>> +
>> +.macro __gen_test_inst inst, src_reg
>> +    \inst a2, 0(\src_reg)
>> +    move a0, a2
>> +.endm
>> +
>> +.macro gen_func_header func_name, rvc
>> +    .option arch,\rvc
>> +    .global test_\func_name
>> +    test_\func_name:
>> +.endm
>> +
>> +.macro gen_test_inst inst
>> +    .option push
>> +    gen_func_header \inst, -c
>> +    __gen_test_inst \inst, a0
>> +    .option pop
>> +    ret
>> +.endm
>> +
>> +.macro __gen_test_inst_c name, src_reg
>> +    .option push
>> +    gen_func_header c_\name, +c
>> +     __gen_test_inst c.\name, \src_reg
>> +    .option pop
>> +    ret
>> +.endm
>> +
>> +.macro gen_test_inst_c name
>> +     __gen_test_inst_c \name, a0
>> +.endm
>> +
>> +
>> +.macro gen_test_inst_load_c_sp name
>> +    .option push
>> +    gen_func_header c_\name\()sp, +c
>> +    sp_stack_prologue a1
>> +    copy_long_to t0, a0, sp
>> +    c.ldsp a0, 0(sp)
>> +    sp_stack_epilogue a1
>> +    .option pop
>> +    ret
>> +.endm
>> +
>> +.macro lb_sp_sb_a0 reg, offset
>> +    lb_sb \reg, \offset, sp, a0
>> +.endm
>> +
>> +.macro gen_test_inst_store_c_sp inst_name
>> +    .option push
>> +    gen_func_header c_\inst_name\()sp, +c
>> +    /* Misalign stack pointer */
>> +    sp_stack_prologue a1
>> +    /* Misalign access */
>> +    c.sdsp a2, 0(sp)
>> +    copy_long_to t0, sp, a0
>> +    sp_stack_epilogue a1
>> +    .option pop
>> +    ret
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
>> diff --git a/tools/testing/selftests/riscv/misaligned/misaligned.c b/
>> tools/testing/selftests/riscv/misaligned/misaligned.c
>> new file mode 100644
>> index 000000000000..8fa5ad1a93d1
>> --- /dev/null
>> +++ b/tools/testing/selftests/riscv/misaligned/misaligned.c
>> @@ -0,0 +1,254 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (c) 2025 Rivos Inc.
>> + *
>> + * Authors:
>> + *     Clément Léger <cleger@rivosinc.com>
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
>> +#define VAL16    0x1234
>> +#define VAL32    0xDEADBEEF
>> +#define VAL64    0x45674321D00DF789
>> +
>> +#define VAL_float    78951.234375
>> +#define VAL_double    567890.512396965789589290
>> +
>> +static bool float_equal(float a, float b)
>> +{
>> +    float scaled_epsilon;
>> +    float difference = fabsf(a - b);
>> +
>> +    // Scale to the largest value.
>> +    a = fabsf(a);
>> +    b = fabsf(b);
>> +    if (a > b)
>> +        scaled_epsilon = FLT_EPSILON * a;
>> +    else
>> +        scaled_epsilon = FLT_EPSILON * b;
>> +
>> +    return difference <= scaled_epsilon;
>> +}
>> +
>> +static bool double_equal(double a, double b)
>> +{
>> +    double scaled_epsilon;
>> +    double difference = fabsf(a - b);
>> +
>> +    // Scale to the largest value.
>> +    a = fabs(a);
>> +    b = fabs(b);
>> +    if (a > b)
>> +        scaled_epsilon = DBL_EPSILON * a;
>> +    else
>> +        scaled_epsilon = DBL_EPSILON * b;
>> +
>> +    return difference <= scaled_epsilon;
>> +}
>> +
>> +#define fpu_load_proto(__inst, __type) \
>> +extern __type test_ ## __inst(unsigned long fp_reg, void *addr,
>> unsigned long offset, __type value)
>> +
>> +fpu_load_proto(flw, float);
>> +fpu_load_proto(fld, double);
>> +fpu_load_proto(c_flw, float);
>> +fpu_load_proto(c_fld, double);
>> +fpu_load_proto(c_fldsp, double);
>> +
>> +#define fpu_store_proto(__inst, __type) \
>> +extern void test_ ## __inst(unsigned long fp_reg, void *addr,
>> unsigned long offset, __type value)
>> +
>> +fpu_store_proto(fsw, float);
>> +fpu_store_proto(fsd, double);
>> +fpu_store_proto(c_fsw, float);
>> +fpu_store_proto(c_fsd, double);
>> +fpu_store_proto(c_fsdsp, double);
>> +
>> +#define gp_load_proto(__inst, __type) \
>> +extern __type test_ ## __inst(void *addr, unsigned long offset,
>> __type value)
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
>> +extern void test_ ## __inst(void *addr, unsigned long offset, __type
>> value)
>> +
>> +gp_store_proto(sh, uint16_t);
>> +gp_store_proto(sw, uint32_t);
>> +gp_store_proto(sd, uint64_t);
>> +gp_store_proto(c_sw, uint32_t);
>> +gp_store_proto(c_sd, uint64_t);
>> +gp_store_proto(c_sdsp, uint64_t);
>> +
>> +#define TEST_GP_LOAD(__inst, __type_size)                    \
>> +TEST(gp_load_ ## __inst)                            \
>> +{                                        \
>> +    int offset, ret;                            \
>> +    uint8_t buf[16] __attribute__((aligned(16)));                \
>> +                                        \
>> +    ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);            \
>> +    ASSERT_EQ(ret, 0);                            \
>> +                                        \
>> +    for (offset = 1; offset < __type_size / 8; offset++) {            \
>> +        uint ## __type_size ## _t val = VAL ## __type_size;        \
>> +        uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t
>> *) (buf + offset); \
>> +        memcpy(ptr, &val, sizeof(val));                    \
>> +        val = test_ ## __inst(ptr, offset, val);            \
>> +        EXPECT_EQ(VAL ## __type_size, val);                \
>> +    }                                    \
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
>> +#define TEST_GP_STORE(__inst, __type_size)                    \
>> +TEST(gp_load_ ## __inst)                            \
>> +{                                        \
>> +    int offset, ret;                            \
>> +    uint8_t buf[16] __attribute__((aligned(16)));                \
>> +                                        \
>> +    ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);            \
>> +    ASSERT_EQ(ret, 0);                            \
>> +                                        \
>> +    for (offset = 1; offset < __type_size / 8; offset++) {            \
>> +        uint ## __type_size ## _t val = VAL ## __type_size;        \
>> +        uint ## __type_size ## _t *ptr = (uint ## __type_size ## _t
>> *) (buf + offset); \
>> +        memset(ptr, 0, sizeof(val));                    \
>> +        test_ ## __inst(ptr, offset, val);                \
>> +        memcpy(&val, ptr, sizeof(val));                    \
>> +        EXPECT_EQ(VAL ## __type_size, val);                \
>> +    }                                    \
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
>> +#define __TEST_FPU_LOAD(__type, __inst, __reg_start,
>> __reg_end)            \
>> +TEST(fpu_load_ ## __inst)                            \
>> +{                                        \
>> +    int ret, offset, fp_reg;                        \
>> +    uint8_t buf[16] __attribute__((aligned(16)));                \
>> +                                        \
>> +    ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);            \
>> +    ASSERT_EQ(ret, 0);                            \
>> +                                        \
>> +    for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {        \
>> +        for (offset = 1; offset < 4; offset++) {            \
>> +            void *load_addr = (buf + offset);            \
>> +            __type val = VAL_ ## __type ;                \
>> +                                        \
>> +            memcpy(load_addr, &val, sizeof(val));            \
>> +            val = test_ ## __inst(fp_reg, load_addr, offset, val);    \
>> +            EXPECT_TRUE(__type ##_equal(val, VAL_## __type));    \
>> +        }                                \
>> +    }                                    \
>> +}
>> +#define TEST_FPU_LOAD(__type, __inst) \
>> +    __TEST_FPU_LOAD(__type, __inst, 0, 32)
>> +#define TEST_FPU_LOAD_COMPRESSED(__type, __inst) \
>> +    __TEST_FPU_LOAD(__type, __inst, 8, 16)
>> +
>> +TEST_FPU_LOAD(float, flw)
>> +TEST_FPU_LOAD(double, fld)
>> +#ifdef __riscv_compressed
>> +TEST_FPU_LOAD_COMPRESSED(double, c_fld)
>> +TEST_FPU_LOAD_COMPRESSED(double, c_fldsp)
>> +#endif
>> +
>> +#define __TEST_FPU_STORE(__type, __inst, __reg_start,
>> __reg_end)        \
>> +TEST(fpu_store_ ## __inst)                            \
>> +{                                        \
>> +    int ret, offset, fp_reg;                        \
>> +    uint8_t buf[16] __attribute__((aligned(16)));                \
>> +                                        \
>> +    ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_NOPRINT);            \
>> +    ASSERT_EQ(ret, 0);                            \
>> +                                        \
>> +    for (fp_reg = __reg_start; fp_reg < __reg_end; fp_reg++) {        \
>> +        for (offset = 1; offset < 4; offset++) {            \
>> +                                        \
>> +            void *store_addr = (buf + offset);            \
>> +            __type val = VAL_ ## __type ;                \
>> +                                        \
>> +            test_ ## __inst(fp_reg, store_addr, offset, val);    \
>> +            memcpy(&val, store_addr, sizeof(val));            \
>> +            EXPECT_TRUE(__type ## _equal(val, VAL_## __type));    \
>> +        }                                \
>> +    }                                    \
>> +}
>> +#define TEST_FPU_STORE(__type, __inst) \
>> +    __TEST_FPU_STORE(__type, __inst, 0, 32)
>> +#define TEST_FPU_STORE_COMPRESSED(__type, __inst) \
>> +    __TEST_FPU_STORE(__type, __inst, 8, 16)
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
>> +    uint32_t *ptr;
>> +    uint8_t buf[16] __attribute__((aligned(16)));
>> +    int ret;
>> +
>> +    ret = prctl(PR_SET_UNALIGN, PR_UNALIGN_SIGBUS);
>> +    ASSERT_EQ(ret, 0);
>> +
>> +    ptr = (uint32_t *)(buf + 1);
>> +    *ptr = 0xDEADBEEFULL;
>> +}
>> +
>> +int main(int argc, char **argv)
>> +{
>> +    int ret, val;
>> +
>> +    ret = prctl(PR_GET_UNALIGN, &val);
>> +    if (ret == -1 && errno == EINVAL)
>> +        ksft_exit_skip("SKIP GET_UNALIGN_CTL not supported\n");
>> +
>> +    exit(test_harness_run(argc, argv));
>> +}


