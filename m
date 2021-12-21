Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC37947C562
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Dec 2021 18:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240616AbhLURuL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Dec 2021 12:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234138AbhLURuK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Dec 2021 12:50:10 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B6C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 09:50:10 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id c3so18761805iob.6
        for <linux-kselftest@vger.kernel.org>; Tue, 21 Dec 2021 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5lXOKcGo+L3AUDTNVpqIXoLnPpW9EixY2S8119Spaps=;
        b=MUaNcLgMV3gKLgtgl9ze4XB8KHqBO8eYrFhpnUNQpDiR80eGYJVvYbKORVHz/Gz7v5
         hlWl4xGxIqu5eB2PzrS+QQqyx0R6n9io9dMPdGkiFRrDbFXAphqBukW9FrlsKXQE6OgU
         cpOYgv1zOIOOq2yHWImE3Z5stVHBSsaVIkf+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5lXOKcGo+L3AUDTNVpqIXoLnPpW9EixY2S8119Spaps=;
        b=U3MwSGnyqRWzMp+tmegXnkP1v5D64msbXk4EvKKLL5J/9o/rT8pG1FmHkKfdAgTgxu
         4BVtOLLWLUVOkSF1x/D5uSqIjMfMI7BKP2HYq+DLRp7h9to5AKbO5JtbTNjERhoPl62a
         Nfk6+ss706TPByYMNt0nWUCaEcW9oKK34Zs+hZN8nUHdiDHF3wMk46CCR39t+MXa77W7
         84JFjZnzag8r4XaPCLBfKzvw6x95jkCjUK/hyNRuIrEnMKTENq0z/EQH/9XI8lmu4P/S
         QW7xjrcWmsikn66muO4lquRRs9MlYq7Ydnwx6RE9DxmSwHKVlDF+GA1pM08QsqoahC3W
         uFwA==
X-Gm-Message-State: AOAM533LIqvLa2Nqv9HnuVp1+r97oj6gjhKJe2/kElwL7SpjsC3fug8G
        w1IAzs2wdKt3EQZ/sBhMA0oBAg==
X-Google-Smtp-Source: ABdhPJyBHmhuMl0X2a7m4jJe327PoMNPrzNy4jifh/kIooioUc1IMerFIEWmdEvLjsOKebgn1rdJRw==
X-Received: by 2002:a02:864b:: with SMTP id e69mr2819224jai.9.1640109009806;
        Tue, 21 Dec 2021 09:50:09 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v16sm8079366ilm.49.2021.12.21.09.50.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Dec 2021 09:50:09 -0800 (PST)
Subject: Re: [RFC PATCH v6 1/2] selftests/x86: add xsave test related to
 nested signal handling
To:     Pengfei Xu <pengfei.xu@intel.com>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Heng Su <heng.su@intel.com>, Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1640052713.git.pengfei.xu@intel.com>
 <af2a5428898388ac501a814d2a2bc5414c7cf76d.1640052713.git.pengfei.xu@intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <8f4c0260-e82a-9d5f-8b9f-2641d8c05e71@linuxfoundation.org>
Date:   Tue, 21 Dec 2021 10:50:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <af2a5428898388ac501a814d2a2bc5414c7cf76d.1640052713.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/20/21 8:22 PM, Pengfei Xu wrote:
> In order to ensure that content of FPU, SSE(XMM), AVX2(YMM), AVX512 opmask and
> PKRU xstates in the same process is not affected by signal handling, this case
> tests that:
> 1. In nested signal processing, the signal handling will use each signal's
>     own xstates, and the xstates of the signal handling under test should
>     not be changed after previous nested signal handling is completed;
> 2. The xstates content of the process should not change after the entire
>     nested signal handling.
> 
> Process will change above mentioned xstates before signal handling test to
> ensure that these xstates have been tested.
> 
> Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> Reported-by: kernel test robot <lkp@intel.com> # compile issues during review
> ---
>   tools/testing/selftests/x86/Makefile          |   3 +-
>   tools/testing/selftests/x86/xsave_common.h    | 380 ++++++++++++++++++
>   .../selftests/x86/xsave_signal_handle.c       | 151 +++++++
>   3 files changed, 533 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/x86/xsave_common.h
>   create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c
> 
> diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
> index 8a1f62ab3c8e..a9e452b65ba2 100644
> --- a/tools/testing/selftests/x86/Makefile
> +++ b/tools/testing/selftests/x86/Makefile
> @@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
>   			test_FCMOV test_FCOMI test_FISTTP \
>   			vdso_restorer
>   TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
> -			corrupt_xstate_header amx
> +			corrupt_xstate_header amx xsave_signal_handle
>   # Some selftests require 32bit support enabled also on 64bit systems
>   TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
>   
> @@ -105,3 +105,4 @@ $(OUTPUT)/test_syscall_vdso_32: thunks_32.S
>   # state.
>   $(OUTPUT)/check_initial_reg_state_32: CFLAGS += -Wl,-ereal_start -static
>   $(OUTPUT)/check_initial_reg_state_64: CFLAGS += -Wl,-ereal_start -static
> +$(OUTPUT)/xsave_signal_handle_64: CFLAGS += -mno-sse -mno-mmx -mno-sse2 -mno-avx -mno-pku
> diff --git a/tools/testing/selftests/x86/xsave_common.h b/tools/testing/selftests/x86/xsave_common.h
> new file mode 100644
> index 000000000000..5b1226d3feae
> --- /dev/null
> +++ b/tools/testing/selftests/x86/xsave_common.h
> @@ -0,0 +1,380 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <cpuid.h>
> +
> +#define XSAVE_MASK_FP (1 << XFEATURE_FP)
> +#define XSAVE_MASK_XMM (1 << XFEATURE_SSE)
> +#define XSAVE_MASK_YMM (1 << XFEATURE_YMM)
> +#define XSAVE_MASK_OPMASK (1 << XFEATURE_OPMASK)
> +#define XSAVE_MASK_PKRU (1 << XFEATURE_PKRU)
> +#define XSAVE_TEST_MASK (XSAVE_MASK_FP | XSAVE_MASK_XMM | XSAVE_MASK_YMM \
> +			| XSAVE_MASK_OPMASK | XSAVE_MASK_PKRU)
> +#define RESULT_PASS 0
> +#define RESULT_FAIL 1
> +#define RESULT_ERROR 3
> +#define CHANGE 10
> +#define NO_CHANGE 11
> +
> +/* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
> +#define X86_FEATURE_AVX2		(1U << 5) /* AVX2 instructions */
> +#define X86_FEATURE_AVX512F		(1U << 16) /* AVX-512 Foundation */
> +
> +/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
> +#define X86_FEATURE_PKU        (1U << 3) /* Protection Keys for Userspace */
> +#define X86_FEATURE_OSPKE      (1U << 4) /* OS Protection Keys Enable */
> +
> +#define XSTATE_CPUID           (0xd)

Match the define in arch/x86/include/asm/fpu/xstate.h
and add a comment that this also defined in the above
include.

Same comment for any other duplicate defines in this file.

> +
> +static int err_num, case_num, pass_num;
> +
> +/*
> + * List of XSAVE features Linux knows about:
> + */
> +enum xfeature {
> +	XFEATURE_FP,
> +	XFEATURE_SSE,
> +	/*
> +	 * Values above here are "legacy states".
> +	 * Those below are "extended states".
> +	 */
> +	XFEATURE_YMM,
> +	XFEATURE_BNDREGS,
> +	XFEATURE_BNDCSR,
> +	XFEATURE_OPMASK,
> +	XFEATURE_ZMM_Hi256,
> +	XFEATURE_Hi16_ZMM,
> +	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
> +	XFEATURE_PKRU,
> +	XFEATURE_PASID,
> +	XFEATURE_RSRVD_COMP_11,
> +	XFEATURE_RSRVD_COMP_12,
> +	XFEATURE_RSRVD_COMP_13,
> +	XFEATURE_RSRVD_COMP_14,
> +	XFEATURE_LBR,
> +

Remove the black line.

> +	XFEATURE_MAX,
> +};
> +
> +/*
> + * Could not use buildin xsave64 in libc without sse, added the function
> + * to save xstates in buf
> + */
> +static void xsave(unsigned char *buf, unsigned long mask)
> +{
> +	uint32_t hmask = (uint32_t)(mask >> 32);
> +	uint32_t lmask = (uint32_t)(mask & 0xffffffff);
> +
> +	asm volatile ("movl %0, %%edx" : : "r" (hmask));
> +	asm volatile ("movl %0, %%eax" : : "r" (lmask));
> +	asm volatile ("xsave64 %0" : : "m" (*buf));
> +}
> +
> +/* Check whether cpu has avx2(Advanced Vector Extensions-2) */
> +static inline int cpu_has_avx2(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* It is a macro-defining function and will not affect xstates */
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +
> +	return (ebx & X86_FEATURE_AVX2);
> +}
> +
> +/* Check whether cpu has avx512f(Advanced Vector Extensions-512 Foundation) */
> +static inline int cpu_has_avx512f(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +
> +	return (ebx & X86_FEATURE_AVX512F);
> +}
> +
> +/* Check whether cpu has PKRU(protection keys for user-mode pages) */
> +static inline int cpu_has_pkeys(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +
> +	if (!(ecx & X86_FEATURE_PKU))
> +		return 0;
> +
> +	if (!(ecx & X86_FEATURE_OSPKE))
> +		return 0;
> +
> +	return 1;
> +}
> +
> +int execution_failed(char *reason, ...)
> +{
> +	printf("FAIL:%s", reason);
> +	err_num++;
> +
> +	return 1;
> +}
> +
> +int get_xsave_size(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	__cpuid_count(0xd, 0, eax, ebx, ecx, edx);
> +
> +	return (int)ecx;
> +}
> +
> +void dump_buffer(unsigned char *buf, int size)
> +{
> +	int i, j;
> +
> +	printf("xsave size = %d (%03xh)\n", size, size);
> +
> +	for (i = 0; i < size; i += 16) {
> +		printf("%04x: ", i);
> +
> +		for (j = i; ((j < i + 16) && (j < size)); j++)
> +			printf("%02x ", buf[j]);
> +		printf("\n");
> +	}
> +}
> +
> +void show_part_buf(unsigned char *buf0, unsigned char *buf1, int start,
> +		int size)
> +{
> +	int c;
> +
> +	printf("%04x: ", start);
> +	for (c = start; ((c < start + 16) && (c < size)); c++)
> +		printf("%02x ", buf0[c]);
> +	printf(" ->  ");
> +	for (c = start; ((c < start + 16) && (c < size)); c++)
> +		printf("%02x ", buf1[c]);
> +	printf("\n");
> +}
> +
> +int show_buf_diff(unsigned char *buf0, unsigned char *buf1, int size)
> +{
> +	int a, b, result_buf = NO_CHANGE;
> +
> +	for (a = 0; a < size; a += 16) {
> +		for (b = a; ((b < a + 16) && (b < size)); b++) {
> +			if (buf0[b] != buf1[b]) {
> +				show_part_buf(buf0, buf1, a, size);
> +				result_buf = CHANGE;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return result_buf;
> +}
> +
> +int check_xsave_reserved_header(unsigned char *buf0,
> +			unsigned char *buf1, int size, const char *test_name)
> +{
> +	int a, b, result_resv_header = RESULT_PASS;
> +
> +	/* SDM: Software should ensure that bytes 63:16 of the XSAVE header are 0 */
> +	for (a = 528; a < 576 ; a += 16) {
> +		for (b = a; ((b < a + 16) && (b < size)); b++) {
> +			if ((buf0[b] != 0) || (buf1[b] != 0)) {
> +				printf("%s FAIL: buf0[%d]:%d or buf1[%d]:%d not 0\n",
> +					test_name, b, buf0[b], b, buf1[b]);
> +				show_part_buf(buf0, buf1, a, size);
> +				result_resv_header = RESULT_FAIL;
> +				break;
> +			}
> +		}
> +	}
> +
> +	return result_resv_header;
> +}
> +
> +int compare_xsave_buf(unsigned char *buf0, unsigned char *buf1,
> +	int size, const char *test_name, int change)
> +{
> +	int result_buf = RESULT_ERROR, result_resv_header = RESULT_ERROR;
> +
> +	switch (change) {
> +	case CHANGE:
> +		if (show_buf_diff(buf0, buf1, size) == CHANGE)
> +			result_buf = RESULT_PASS;
> +		else {
> +			printf("%s FAIL: xsave content was same\n", test_name);
> +			result_buf = RESULT_FAIL;
> +		}
> +		break;
> +	case NO_CHANGE:
> +		if (show_buf_diff(buf0, buf1, size) == CHANGE) {
> +			printf("%s FAIL: xsave content changed\n", test_name);
> +			show_buf_diff(buf0, buf1, size);
> +			result_buf = RESULT_FAIL;
> +		} else
> +			result_buf = RESULT_PASS;
> +		break;
> +	default:
> +		printf("%s ERROR: invalid change:%d\n", test_name,
> +			change);
> +		break;
> +	}
> +
> +	result_resv_header = check_xsave_reserved_header(buf0, buf1, size,
> +		test_name);
> +
> +	return (result_buf || result_resv_header);
> +}
> +

Please explain why all these 3 routines are needed?
compare_xsave_buf(), show_buf_diff() and show_part_buf()

> +void check_result(int result, const char *test_name)
> +{
> +	switch (result) {
> +	case RESULT_PASS:
> +		printf("[PASS]:%s\n", test_name);
> +		pass_num++;
> +		break;
> +	case RESULT_FAIL:
> +		printf("[FAIL]:%s\n", test_name);
> +		break;
> +	case RESULT_ERROR:
> +		printf("[ERROR]:%s\n", test_name);
> +		err_num++;
> +		break;
> +	default:
> +		printf("[ERROR]:%s:invalid result:%c\n",
> +			test_name, result);
> +		err_num++;
> +		break;
> +	}
> +}
> +
> +/* Populate YMM with ui32_ymm */
> +static void set_avx2_ymm(uint32_t ui32_ymm)
> +{
> +	if (cpu_has_avx2()) {
> +		asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm1" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm2" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm3" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm4" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm5" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm6" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm7" : : "m" (ui32_ymm));
> +		#ifndef __i386__
> +		asm volatile ("vbroadcastss %0, %%ymm8" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm9" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm10" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm11" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm12" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm13" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm14" : : "m" (ui32_ymm));
> +		asm volatile ("vbroadcastss %0, %%ymm15" : : "m" (ui32_ymm));
> +		#endif
> +	}
> +}
> +
> +static void set_pkru_xstate(uint32_t pkey_reg)
> +{
> +	unsigned int ecx = 0, edx = 0;
> +
> +	if (cpu_has_pkeys())
> +		asm volatile(".byte 0x0f, 0x01, 0xef\n\t"
> +		     : : "a" (pkey_reg), "c" (ecx), "d" (edx));
> +}
> +
> +/* Populate avx512 opmask k0 to k7 with ffffffffffffffff */
> +static void set_avx512_opmask(void)
> +{
> +	if (cpu_has_avx512f()) {
> +		asm volatile("kxnorq %%k0, %%k0, %%k0;" : : : "rcx");
> +		asm volatile("kxnorq %%k1, %%k1, %%k1;" : : : "rcx");
> +		asm volatile("kxnorq %%k2, %%k2, %%k2;" : : : "rcx");
> +		asm volatile("kxnorq %%k3, %%k3, %%k3;" : : : "rcx");
> +		asm volatile("kxnorq %%k4, %%k4, %%k4;" : : : "rcx");
> +		asm volatile("kxnorq %%k5, %%k5, %%k5;" : : : "rcx");
> +		asm volatile("kxnorq %%k6, %%k6, %%k6;" : : : "rcx");
> +		asm volatile("kxnorq %%k7, %%k7, %%k7;" : : : "rcx");
> +	}
> +}
> +
> +/* Initialize FPU and push different values onto FPU register stack */
> +static void set_fpu_reg(void)
> +{
> +	uint32_t ui32;
> +	uint64_t ui64;
> +	float a = 0.12, b = 0.23;
> +
> +	ui32 = 1;
> +	ui64 = 0xBAB00500FAB7;
> +

Just intialze at the time of define up above. Also add
some commeng indicating what 0xBAB00500FAB7 is for.

> +	asm volatile("finit");
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	asm volatile("flds %0" : : "m" (ui32));
> +	ui64 += 0x93ABE13;
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	ui64 += 0x93;
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	asm volatile("flds %0" : : "m" (ui32));
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	ui64 -= 0x21;
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	asm volatile("flds %0" : : "m" (ui32));
> +	asm volatile("fldl %0" : : "m" (ui64));
> +	a = a * b;
> +}
> +
> +void change_xstate(uint32_t ui32)
> +{
> +	uint32_t pkey_change = 0xffffff00, ecx = 0, edx = 0;

What does thsi value of pkey_change mean? What are you testing for?

> +
> +	/* Push value onto FP stack */
> +	asm volatile("flds %0" : : "m" (ui32));
> +
> +	/* change ymm0 to ymm15 with ui32 in 64bit kernel */
> +	if (cpu_has_avx2())
> +		set_avx2_ymm(ui32);
> +
> +	/* change avx512 opmask k0 to k7 with ff */
> +	if (cpu_has_avx512f()) {
> +		asm volatile("kxnorb %%k0, %%k0, %%k0;" : : : "rcx");
> +		asm volatile("kxnorb %%k1, %%k1, %%k1;" : : : "rcx");
> +		asm volatile("kxnorb %%k2, %%k2, %%k2;" : : : "rcx");
> +		asm volatile("kxnorb %%k3, %%k3, %%k3;" : : : "rcx");
> +		asm volatile("kxnorb %%k4, %%k4, %%k4;" : : : "rcx");
> +		asm volatile("kxnorb %%k5, %%k5, %%k5;" : : : "rcx");
> +		asm volatile("kxnorb %%k6, %%k6, %%k6;" : : : "rcx");
> +		asm volatile("kxnorb %%k7, %%k7, %%k7;" : : : "rcx");
> +	}
> +
> +	/*  Change PKRU xstate */
> +	if (cpu_has_pkeys())
> +		asm volatile(".byte 0x0f,0x01,0xef\n\t"
> +		     : : "a" (pkey_change), "c" (ecx), "d" (edx));
> +}
> +
> +void check_cpu_capability(void)
> +{
> +	if (!cpu_has_avx2())
> +		printf("[SKIP] No avx2 capability, skip avx2 part xstate.\n");
> +
> +	if (!cpu_has_avx512f())
> +		printf("[SKIP] No avx512f capability, skip avx512f part xstate.\n");
> +
> +	if (!cpu_has_pkeys())
> +		printf("[SKIP] No pkeys capability, skip pkru part xstate.\n");
> +}
> +
> +void populate_xstate_regs(void)
> +{
> +	uint32_t ui32_ymm_value = 0x1F2F3F4F, pkey = 0xfffffffc;

Same comment here. What does this test do?

> +
> +	set_fpu_reg();
> +	set_avx2_ymm(ui32_ymm_value);
> +	set_avx512_opmask();
> +	set_pkru_xstate(pkey);
> +}
> diff --git a/tools/testing/selftests/x86/xsave_signal_handle.c b/tools/testing/selftests/x86/xsave_signal_handle.c
> new file mode 100644
> index 000000000000..e1754b279d00
> --- /dev/null
> +++ b/tools/testing/selftests/x86/xsave_signal_handle.c
> @@ -0,0 +1,151 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * It's used for XSAVE test with signal handling.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <string.h>
> +#include <signal.h>
> +#include <unistd.h>
> +#include <sched.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +
> +#include "xsave_common.h"
> +
> +void *aligned_alloc(size_t alignment, size_t size);
> +static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2, *xsave_buf3;
> +static int result[2], xsave_size;
> +
> +static void usr1_handler(int signum, siginfo_t *info, void *__ctxp)
> +{
> +	uint32_t ui32;
> +	const char *usr1_name = "USR1 signal xstates should same after USR2 signal";
> +
> +	/* Xstate change in signal handling USR1 will not affect process xstates */
> +	ui32 = 0x1f2fffff;
> +	if (signum == SIGUSR1) {
> +		printf("SIGUSR1:0x%x changed fld & ymm0-15:0x%x\n",
> +			SIGUSR1, ui32);
> +		change_xstate(ui32);
> +	}
> +	/*
> +	 * SIGUSR1 handler has independent XSAVE content, which is not affected by
> +	 * the SIGUSR2 handler
> +	 */
> +	xsave(xsave_buf2, XSAVE_TEST_MASK);
> +	kill(getpid(), SIGUSR2);
> +	xsave(xsave_buf3, XSAVE_TEST_MASK);
> +	result[0] = compare_xsave_buf(xsave_buf2, xsave_buf3, xsave_size, usr1_name,
> +		NO_CHANGE);
> +}
> +
> +static void usr2_handler(int signum, siginfo_t *info, void *__ctxp)
> +{
> +	uint32_t ui32;
> +
> +	ui32 = 0x3f4fffff;

Same here.

> +	if (signum == SIGUSR2) {
> +		printf("SIGUSR2:0x%x changed fld & ymm0-15:0x%x\n",
> +			SIGUSR2, ui32);
> +		change_xstate(ui32);
> +	}
> +}
> +
> +static void set_signal_handle(void)
> +{
> +	struct sigaction sigact;
> +
> +	memset(&sigact, 0, sizeof(sigact));
> +	if (sigemptyset(&sigact.sa_mask))
> +		execution_failed("sigemptyset error\n");
> +
> +	sigact.sa_flags = SA_SIGINFO;
> +
> +	sigact.sa_sigaction = usr1_handler;
> +	if (sigaction(SIGUSR1, &sigact, NULL))
> +		execution_failed("SIGUSR1 handling failed\n");
> +
> +	sigact.sa_sigaction = usr2_handler;
> +	if (sigaction(SIGUSR2, &sigact, NULL))
> +		execution_failed("SIGUSR2 handling failed\n");
> +}
> +
> +void prepare_environment(void)
> +{
> +	set_signal_handle();
> +	xsave_size = get_xsave_size();
> +	printf("XSAVE_TEST_MASK:0x%x, xstate size:0x%x\n",
> +		XSAVE_TEST_MASK, xsave_size);
> +	check_cpu_capability();
> +
> +	/* SDM XSAVE: misalignment to a 64-byte boundary will result in #GP */
> +	xsave_buf0 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf0)
> +		execution_failed("aligned_alloc xsave_buf0 failed\n");
> +	xsave_buf1 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf1)
> +		execution_failed("aligned_alloc xsave_buf1 failed\n");
> +	xsave_buf2 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf2)
> +		execution_failed("aligned_alloc xsave_buf2 failed\n");
> +	xsave_buf3 = aligned_alloc(64, xsave_size);
> +	if (!xsave_buf3)
> +		execution_failed("aligned_alloc xsave_buf3 failed\n");
> +}
> +
> +static int test_xsave_sig_handle(void)
> +{
> +	const char *test_name0 = "Signal xstate was same after previous signal handling";
> +	const char *test_name1 = "Child xstate was same after signal handling";
> +	pid_t child;
> +	int status;
> +
> +	/* Use child process testing to avoid abnormal blocking the next test */
> +	child = syscall(SYS_fork);
> +	if (child < 0)
> +		execution_failed("Create child pid failed\n");
> +	else if	(child == 0) {
> +		populate_xstate_regs();
> +		xsave(xsave_buf0, XSAVE_TEST_MASK);
> +		/* Dump buffer to show the tested xstates */
> +		dump_buffer(xsave_buf0, xsave_size);
> +
> +		/*
> +		 * Because printf in dump will change or clean xstates, populate xstates
> +		 * again to fill the xstates we need to test for next test case
> +		 */
> +		populate_xstate_regs();
> +		xsave(xsave_buf0, XSAVE_TEST_MASK);
> +		kill(getpid(), SIGUSR1);
> +		xsave(xsave_buf1, XSAVE_TEST_MASK);
> +		result[1] = compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
> +			test_name1, NO_CHANGE);
> +		check_result(result[0], test_name0);
> +		check_result(result[1], test_name1);
> +		printf("Xstate in signal hanlding test pass[%d/%d], err_num:%d\n",
> +			pass_num, case_num, err_num);
> +
> +		return 0;
> +	}
> +
> +	if (child) {
> +		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
> +			execution_failed("Child quit unexpectedly\n");
> +	}
> +
> +	return 0;
> +}
> +
> +int main(void)
> +{
> +	case_num = 2;
> +
> +	prepare_environment();
> +	test_xsave_sig_handle();
> +
> +	return 0;
> +}
> 

Please add information on what these tests are doing?

thanks,
-- Shuah

