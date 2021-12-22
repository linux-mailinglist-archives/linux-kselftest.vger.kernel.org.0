Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3480247CD11
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Dec 2021 07:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbhLVGq4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Dec 2021 01:46:56 -0500
Received: from mga09.intel.com ([134.134.136.24]:14105 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233215AbhLVGqy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Dec 2021 01:46:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640155614; x=1671691614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fjp6dMJADt2KS4vbS+2BlmA2F5GP/IkoJv3Tz6lKWr8=;
  b=Fnp/+oB9zK9e8CHzz5HNxjCGy1oJRtrqBqtLGBavRHDGyOkFjPwMy5BA
   fU/pzj64aw8u9GJefWSIE48RevPK6eLCmozaIhiu3uVppQ6JKiBCg+nb9
   FzAzEMPic9UijFC7jV9DBJ11r8vSZ9aKxxTddBG5kJXpVmbVGHkT8rzAT
   4xeAkf/0Sf9FnbCax1Fv2+BrVFpWcQshUsoSK46jDBg8S/OkqvNI2WYDW
   C/rXbfQbkP5tE5TnF98S1659CCkqhMpL1tYfVLK8DdMr6SBbeDuvSCmKK
   +q/pV7xpKCueK0x5q6BvtLnwHVnzXq7HBy1+IHsj1hq2boK+Tz2XFP3ov
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240364535"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="240364535"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 22:46:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; 
   d="scan'208";a="468065919"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga006.jf.intel.com with ESMTP; 21 Dec 2021 22:46:36 -0800
Date:   Wed, 22 Dec 2021 14:47:34 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>,
        Hansen Dave <dave.hansen@intel.com>,
        Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RFC PATCH v6 1/2] selftests/x86: add xsave test related to
 nested signal handling
Message-ID: <YcLKBtyFjIWqTtjQ@xpf.sh.intel.com>
References: <cover.1640052713.git.pengfei.xu@intel.com>
 <af2a5428898388ac501a814d2a2bc5414c7cf76d.1640052713.git.pengfei.xu@intel.com>
 <8f4c0260-e82a-9d5f-8b9f-2641d8c05e71@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4c0260-e82a-9d5f-8b9f-2641d8c05e71@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2021-12-21 at 10:50:08 -0700, Shuah Khan wrote:
> On 12/20/21 8:22 PM, Pengfei Xu wrote:
> > In order to ensure that content of FPU, SSE(XMM), AVX2(YMM), AVX512 opmask and
> > PKRU xstates in the same process is not affected by signal handling, this case
> > tests that:
> > 1. In nested signal processing, the signal handling will use each signal's
> >     own xstates, and the xstates of the signal handling under test should
> >     not be changed after previous nested signal handling is completed;
> > 2. The xstates content of the process should not change after the entire
> >     nested signal handling.
> > 
> > Process will change above mentioned xstates before signal handling test to
> > ensure that these xstates have been tested.
> > 
> > Signed-off-by: Pengfei Xu <pengfei.xu@intel.com>
> > Reported-by: kernel test robot <lkp@intel.com> # compile issues during review
> > ---
> >   tools/testing/selftests/x86/Makefile          |   3 +-
> >   tools/testing/selftests/x86/xsave_common.h    | 380 ++++++++++++++++++
> >   .../selftests/x86/xsave_signal_handle.c       | 151 +++++++
> >   3 files changed, 533 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/testing/selftests/x86/xsave_common.h
> >   create mode 100644 tools/testing/selftests/x86/xsave_signal_handle.c
> > 
> > +#include <unistd.h>
> > +#include <cpuid.h>
> > +
> > +#define XSAVE_MASK_FP (1 << XFEATURE_FP)
> > +#define XSAVE_MASK_XMM (1 << XFEATURE_SSE)
> > +#define XSAVE_MASK_YMM (1 << XFEATURE_YMM)
> > +#define XSAVE_MASK_OPMASK (1 << XFEATURE_OPMASK)
> > +#define XSAVE_MASK_PKRU (1 << XFEATURE_PKRU)
> > +#define XSAVE_TEST_MASK (XSAVE_MASK_FP | XSAVE_MASK_XMM | XSAVE_MASK_YMM \
> > +			| XSAVE_MASK_OPMASK | XSAVE_MASK_PKRU)
> > +#define RESULT_PASS 0
> > +#define RESULT_FAIL 1
> > +#define RESULT_ERROR 3
> > +#define CHANGE 10
> > +#define NO_CHANGE 11
> > +
> > +/* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
> > +#define X86_FEATURE_AVX2		(1U << 5) /* AVX2 instructions */
> > +#define X86_FEATURE_AVX512F		(1U << 16) /* AVX-512 Foundation */
> > +
> > +/* Intel-defined CPU features, CPUID level 0x00000007:0 (ecx) */
> > +#define X86_FEATURE_PKU        (1U << 3) /* Protection Keys for Userspace */
> > +#define X86_FEATURE_OSPKE      (1U << 4) /* OS Protection Keys Enable */
> > +
> > +#define XSTATE_CPUID           (0xd)
> 
> Match the define in arch/x86/include/asm/fpu/xstate.h
> and add a comment that this also defined in the above
> include.
> 
> Same comment for any other duplicate defines in this file.
> 
  Thanks a lot for taking a look. I will add comments in next version.

> > +
> > +static int err_num, case_num, pass_num;
> > +
> > +/*
> > + * List of XSAVE features Linux knows about:
> > + */
> > +enum xfeature {
> > +	XFEATURE_FP,
> > +	XFEATURE_SSE,
> > +	/*
> > +	 * Values above here are "legacy states".
> > +	 * Those below are "extended states".
> > +	 */
> > +	XFEATURE_YMM,
> > +	XFEATURE_BNDREGS,
> > +	XFEATURE_BNDCSR,
> > +	XFEATURE_OPMASK,
> > +	XFEATURE_ZMM_Hi256,
> > +	XFEATURE_Hi16_ZMM,
> > +	XFEATURE_PT_UNIMPLEMENTED_SO_FAR,
> > +	XFEATURE_PKRU,
> > +	XFEATURE_PASID,
> > +	XFEATURE_RSRVD_COMP_11,
> > +	XFEATURE_RSRVD_COMP_12,
> > +	XFEATURE_RSRVD_COMP_13,
> > +	XFEATURE_RSRVD_COMP_14,
> > +	XFEATURE_LBR,
> > +
> 
> Remove the black line.
> 
  Thanks, will fix it.

> > +	XFEATURE_MAX,
> > +};
> > +
> > +
..
> > +int compare_xsave_buf(unsigned char *buf0, unsigned char *buf1,
> > +	int size, const char *test_name, int change)
> > +{
> > +	int result_buf = RESULT_ERROR, result_resv_header = RESULT_ERROR;
> > +
> > +	switch (change) {
> > +	case CHANGE:
> > +		if (show_buf_diff(buf0, buf1, size) == CHANGE)
> > +			result_buf = RESULT_PASS;
> > +		else {
> > +			printf("%s FAIL: xsave content was same\n", test_name);
> > +			result_buf = RESULT_FAIL;
> > +		}
> > +		break;
> > +	case NO_CHANGE:
> > +		if (show_buf_diff(buf0, buf1, size) == CHANGE) {
> > +			printf("%s FAIL: xsave content changed\n", test_name);
> > +			show_buf_diff(buf0, buf1, size);
> > +			result_buf = RESULT_FAIL;
> > +		} else
> > +			result_buf = RESULT_PASS;
> > +		break;
> > +	default:
> > +		printf("%s ERROR: invalid change:%d\n", test_name,
> > +			change);
> > +		break;
> > +	}
> > +
> > +	result_resv_header = check_xsave_reserved_header(buf0, buf1, size,
> > +		test_name);
> > +
> > +	return (result_buf || result_resv_header);
> > +}
> > +
> 
> Please explain why all these 3 routines are needed?
> compare_xsave_buf(), show_buf_diff() and show_part_buf()
> 
  compare_xsave_buf() will compare xstate buf1 and buf2 difference, and check
  both buf1 and buf2 xstate reserved header 63:16 should be all 00.
  SDM mentioned that:
  "Software should ensure that bytes 63:16 of the XSAVE header are 0"

  If there is difference between buf1 and buf2,  show_buf_diff() will be called
  by compare_xsave_buf(), and find the offsets in all the different places.
  show_part_buf() called by show_buf_diff() will print all the different
  places between buf1 and buf2.

  For example, change ymm0 and ymm1 xstates:
"
	uint32_t ui32=0xf1f2;
	xsave(xsave_buf0, XSAVE_TEST_MASK);
	asm volatile ("vbroadcastss %0, %%ymm0" : : "m" (ui32));
	asm volatile ("vbroadcastss %0, %%ymm1" : : "m" (ui32));
	xsave(xsave_buf1, XSAVE_TEST_MASK);
	compare_xsave_buf(xsave_buf0, xsave_buf1, xsave_size,
		test_name1, NO_CHANGE);
"
It will only show different places as below:
00a0: 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f  ->  f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 
00b0: 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f  ->  f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 
0240: 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f  ->  f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 
0250: 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f 4f 3f 2f 1f  ->  f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 f2 f1 00 00 

> > +void check_result(int result, const char *test_name)
> > +{
> > +	switch (result) {
> > +	case RESULT_PASS:
> > +		printf("[PASS]:%s\n", test_name);
> > +		pass_num++;
> > +		break;
> > +	case RESULT_FAIL:
> > +		printf("[FAIL]:%s\n", test_name);
> > +		break;
> > +	case RESULT_ERROR:
> > +		printf("[ERROR]:%s\n", test_name);
> > +		err_num++;
> > +		break;
> > +	default:
> > +		printf("[ERROR]:%s:invalid result:%c\n",
> > +			test_name, result);
> > +		err_num++;
> > +		break;
> > +	}
> > +}
> > +
...
> > +
> > +/* Initialize FPU and push different values onto FPU register stack */
> > +static void set_fpu_reg(void)
> > +{
> > +	uint32_t ui32;
> > +	uint64_t ui64;
> > +	float a = 0.12, b = 0.23;
> > +
> > +	ui32 = 1;
> > +	ui64 = 0xBAB00500FAB7;
> > +
> 
> Just intialze at the time of define up above. Also add
> some commeng indicating what 0xBAB00500FAB7 is for.
> 
  Thanks for suggestion, yes, I will add comments for it.
  It will fill 0xBAB00500FAB7 and some different values into FP xstate ST0/MM0-
  ST7/MM7.

> > +	asm volatile("finit");
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	asm volatile("flds %0" : : "m" (ui32));
> > +	ui64 += 0x93ABE13;
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	ui64 += 0x93;
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	asm volatile("flds %0" : : "m" (ui32));
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	ui64 -= 0x21;
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	asm volatile("flds %0" : : "m" (ui32));
> > +	asm volatile("fldl %0" : : "m" (ui64));
> > +	a = a * b;
> > +}
> > +
> > +void change_xstate(uint32_t ui32)
> > +{
> > +	uint32_t pkey_change = 0xffffff00, ecx = 0, edx = 0;
> 
> What does thsi value of pkey_change mean? What are you testing for?
> 
  pkey_change means PKRU(Memory Protection Keys Register for Userspace) xstate
  will change to 0x00000000ffffff00.

  At beginning  of test, populate_xstate_regs() -> set_pkru_xstate(pkey) will
  set PKRU xstate to 0x00000000fffffffc.

  When signal handling test, signal handling function will use it's xstate,
  and it changes PKRU xstate to 0x00000000ffffff00. After signal handling is
  finished, process xstate should be resumed by xsaves/xrstors kernel schedule,
  process xstate should be 0x00000000fffffffc, it's same as
  populate_xstate_regs() -> set_pkru_xstate(pkey) pkru xstate.

> > +
> > +	/* Push value onto FP stack */
> > +	asm volatile("flds %0" : : "m" (ui32));
> > +
> > +	/* change ymm0 to ymm15 with ui32 in 64bit kernel */
> > +	if (cpu_has_avx2())
> > +		set_avx2_ymm(ui32);
> > +
> > +	/* change avx512 opmask k0 to k7 with ff */
> > +	if (cpu_has_avx512f()) {
> > +		asm volatile("kxnorb %%k0, %%k0, %%k0;" : : : "rcx");
> > +		asm volatile("kxnorb %%k1, %%k1, %%k1;" : : : "rcx");
> > +		asm volatile("kxnorb %%k2, %%k2, %%k2;" : : : "rcx");
> > +		asm volatile("kxnorb %%k3, %%k3, %%k3;" : : : "rcx");
> > +		asm volatile("kxnorb %%k4, %%k4, %%k4;" : : : "rcx");
> > +		asm volatile("kxnorb %%k5, %%k5, %%k5;" : : : "rcx");
> > +		asm volatile("kxnorb %%k6, %%k6, %%k6;" : : : "rcx");
> > +		asm volatile("kxnorb %%k7, %%k7, %%k7;" : : : "rcx");
> > +	}
> > +
> > +	/*  Change PKRU xstate */
> > +	if (cpu_has_pkeys())
> > +		asm volatile(".byte 0x0f,0x01,0xef\n\t"
> > +		     : : "a" (pkey_change), "c" (ecx), "d" (edx));
> > +}
> > +
> > +void check_cpu_capability(void)
> > +{
> > +	if (!cpu_has_avx2())
> > +		printf("[SKIP] No avx2 capability, skip avx2 part xstate.\n");
> > +
> > +	if (!cpu_has_avx512f())
> > +		printf("[SKIP] No avx512f capability, skip avx512f part xstate.\n");
> > +
> > +	if (!cpu_has_pkeys())
> > +		printf("[SKIP] No pkeys capability, skip pkru part xstate.\n");
> > +}
> > +
> > +void populate_xstate_regs(void)
> > +{
> > +	uint32_t ui32_ymm_value = 0x1F2F3F4F, pkey = 0xfffffffc;
> 
> Same comment here. What does this test do?
> 
  populate_xstate_regs() will populate FP, XMM(SSE), YMM(AVX2), AVX512_opmask
  and PKRU xstates with values at the begining of the test. If there are all 00
  in above xstates, we could not confirm kernel xsaves and xrstors the xstates
  works well after signal handling and process switching.

> > +
> > +	set_fpu_reg();
> > +	set_avx2_ymm(ui32_ymm_value);
> > +	set_avx512_opmask();
> > +	set_pkru_xstate(pkey);
> > +}
> > diff --git a/tools/testing/selftests/x86/xsave_signal_handle.c b/tools/testing/selftests/x86/xsave_signal_handle.c
> > new file mode 100644
> > index 000000000000..e1754b279d00
> > --- /dev/null
> > +++ b/tools/testing/selftests/x86/xsave_signal_handle.c
> > @@ -0,0 +1,151 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * It's used for XSAVE test with signal handling.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <stdio.h>
> > +#include <stdint.h>
> > +#include <string.h>
> > +#include <signal.h>
> > +#include <unistd.h>
> > +#include <sched.h>
> > +#include <sys/wait.h>
> > +#include <sys/syscall.h>
> > +
> > +#include "xsave_common.h"
> > +
> > +void *aligned_alloc(size_t alignment, size_t size);
> > +static unsigned char *xsave_buf0, *xsave_buf1, *xsave_buf2, *xsave_buf3;
> > +static int result[2], xsave_size;
> > +
> > +static void usr1_handler(int signum, siginfo_t *info, void *__ctxp)
> > +{
> > +	uint32_t ui32;
> > +	const char *usr1_name = "USR1 signal xstates should same after USR2 signal";
> > +
> > +	/* Xstate change in signal handling USR1 will not affect process xstates */
> > +	ui32 = 0x1f2fffff;
> > +	if (signum == SIGUSR1) {
> > +		printf("SIGUSR1:0x%x changed fld & ymm0-15:0x%x\n",
> > +			SIGUSR1, ui32);
> > +		change_xstate(ui32);
> > +	}
> > +	/*
> > +	 * SIGUSR1 handler has independent XSAVE content, which is not affected by
> > +	 * the SIGUSR2 handler
> > +	 */
> > +	xsave(xsave_buf2, XSAVE_TEST_MASK);
> > +	kill(getpid(), SIGUSR2);
> > +	xsave(xsave_buf3, XSAVE_TEST_MASK);
> > +	result[0] = compare_xsave_buf(xsave_buf2, xsave_buf3, xsave_size, usr1_name,
> > +		NO_CHANGE);
> > +}
> > +
> > +static void usr2_handler(int signum, siginfo_t *info, void *__ctxp)
> > +{
> > +	uint32_t ui32;
> > +
> > +	ui32 = 0x3f4fffff;
> 
> Same here.
> 
  In nested signal handling for SIGUSR2, it changes signal handling own ymm0-15
  xstates to 0x3f4fffff.
  Process has set ymm0-15 to 0x1F2F3F4F at begining of test
  populate_xstate_regs().
  Process ymm xstate should not change after signal handling test.

> > +	if (signum == SIGUSR2) {
> > +		printf("SIGUSR2:0x%x changed fld & ymm0-15:0x%x\n",
> > +			SIGUSR2, ui32);
> > +		change_xstate(ui32);
> > +	}
> > +}
> > +
...
> > +
> > +int main(void)
> > +{
> > +	case_num = 2;
> > +
> > +	prepare_environment();
> > +	test_xsave_sig_handle();
> > +
> > +	return 0;
> > +}
> > 
> 
> Please add information on what these tests are doing?
> 
  Thanks, yes, I will add test information to the head comments of the test
  code in next version.

  Thanks very much!
  BR.

> thanks,
> -- Shuah
> 
