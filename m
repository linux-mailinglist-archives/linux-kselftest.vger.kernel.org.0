Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F234F9B2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Apr 2022 18:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234556AbiDHRAy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Apr 2022 13:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiDHRAx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Apr 2022 13:00:53 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E5B3B38DE;
        Fri,  8 Apr 2022 09:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649437128; x=1680973128;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XW05VijnM1goFr4Uwl/M420MVZnLV3XgnpOCISplybw=;
  b=J6fvstiSBySxC+zhjouUx8rLrb3TCEE6rmwFBfpd7OJ/77aqs8dA8D2V
   NNxumB4MgBWXvNnQmO+6cqhl1MYPbcEDBEHCQ/SfScjCE7soki6odOhrg
   z4ZsVs6M97YwyQCoPuUjZgD3FirMYATrF6UBFqeJ/Ydw2tzHGHqJvo34B
   QfVo9fdoLQ8O0AU0Dt5hthmqV3r+3k49u5vOquKVpi7ylxVpsrIvu/ChX
   pYxOlx9p4AChPCieQpzsS45tt5ZKgkdVGa3YM8CSJhy8O1bh+TyPj9gN6
   u38fDyXUICP7QnNG/vVL3wb0jd/S/TB3Si9ck8oiNwEqIyZvCp+22KhJK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="322331100"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="322331100"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 09:58:47 -0700
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="525447468"
Received: from tsungtae-mobl.amr.corp.intel.com (HELO [10.134.43.198]) ([10.134.43.198])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 09:58:46 -0700
Message-ID: <441dd314-3a82-cf53-8e2c-badedfe22d8c@intel.com>
Date:   Fri, 8 Apr 2022 09:58:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Heng Su <heng.su@intel.com>, Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>
References: <cover.1646999762.git.pengfei.xu@intel.com>
 <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v8 1/1] selftests/x86/xstate: Add xstate test cases for
 XSAVE feature
In-Reply-To: <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/16/22 05:40, Pengfei Xu wrote:
> +#ifndef __cpuid_count
> +#define __cpuid_count(level, count, a, b, c, d) ({	\
> +	__asm__ __volatile__ ("cpuid\n\t"	\
> +			: "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> +			: "0" (level), "2" (count));	\
> +})
> +#endif


By the time you post the next revision, I hope these are merged:

> https://lore.kernel.org/all/cover.1647360971.git.reinette.chatre@intel.com/

Could you rebase on top of those to avoid duplication, please?

> +/*
> + * While this function prototype is in the stdlib.h, the header file cannot be
> + * included with the -mno-sse option.
> + */
> +void *aligned_alloc(size_t alignment, size_t size);

That is worrisome.  I would serioulsy suspect that if the header can't
be included that the code that it references has issues as well.

Or, is this just working around a compiler bug?  Just googling:

	https://www.google.com/search?q=stdlib.h+no-sse

points to this:

	https://sourceware.org/bugzilla/show_bug.cgi?id=27600

> +enum supportability {
> +	NOT_SUPPORT,
> +	SUPPORT,
> +};
> +
> +/* It's from arch/x86/kernel/fpu/xstate.c. */
> +static const char * const xfeature_names[] = {
> +	"x87 floating point registers",
> +	"SSE registers",
> +	"AVX registers",
> +	"MPX bounds registers",
> +	"MPX CSR",
> +	"AVX-512 opmask",
> +	"AVX-512 Hi256",
> +	"AVX-512 ZMM_Hi256",
> +	"Processor Trace (unused)",
> +	"Protection Keys User registers",
> +	"PASID state",
> +	"unknown xstate feature",
> +	"unknown xstate feature",
> +	"unknown xstate feature",
> +	"unknown xstate feature",
> +	"unknown xstate feature",
> +	"unknown xstate feature",
> +	"AMX Tile config",
> +	"AMX Tile data",
> +	"unknown xstate feature",
> +};
> +
> +/* List of XSAVE features Linux knows about. */
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
> +	XFEATURE_RSRVD_COMP_16,
> +	XFEATURE_XTILE_CFG,
> +	XFEATURE_XTILE_DATA,
> +	XFEATURE_MAX,
> +};
> +
> +struct xsave_buffer {
> +	union {
> +		struct {
> +			char legacy[XSAVE_HDR_OFFSET];
> +			char header[XSAVE_HDR_SIZE];
> +			char extended[0];
> +		};
> +		char bytes[0];
> +	};
> +};
> +
> +static struct {
> +	uint64_t mask;
> +	uint32_t size[XFEATURE_MAX];
> +	uint32_t offset[XFEATURE_MAX];
> +} xstate_info;
> +
> +static inline void check_cpuid_xsave_availability(void)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +
> +	/*
> +	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> +	 * support for the XSAVE feature set, including
> +	 * XGETBV.
> +	 */
> +	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> +	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> +		fatal_error("cpuid: no CPU xsave support");
> +	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> +		fatal_error("cpuid: no OS xsave support");
> +}

Could you please use the standard selftest macros for these fatal
errors?  Also, do these indicate that the test failed, or that it just
was not able to run?

> +static inline bool xstate_tested(int xfeature_num)
> +{
> +	return !!(xstate_info.mask & (1 << xfeature_num));
> +}
> +
> +static inline int cpu_has_avx2(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* CPUID.7.0:EBX.AVX2[bit 5]: the support for AVX2 instructions */
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +
> +	return !!(ebx & CPUID_LEAF7_EBX_AVX2_MASK);
> +}
> +
> +static inline int cpu_has_avx512f(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* CPUID.7.0:EBX.AVX512F[bit 16]: the support for AVX512F instructions */
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +
> +	return !!(ebx & CPUID_LEAF7_EBX_AVX512F_MASK);
> +}
> +
> +static inline int cpu_has_pkeys(void)
> +{
> +	unsigned int eax, ebx, ecx, edx;
> +
> +	/* CPUID.7.0:ECX.PKU[bit 3]: the support for PKRU instructions */
> +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> +	if (!(ecx & CPUID_LEAF7_ECX_PKU_MASK))
> +		return NOT_SUPPORT;
> +	/* CPUID.7.0:ECX.OSPKE[bit 4]: the support for OS set CR4.PKE */
> +	if (!(ecx & CPUID_LEAF7_ECX_OSPKE_MASK))
> +		return NOT_SUPPORT;
> +
> +	return SUPPORT;
> +}

You don't need that CPUID_LEAF7_ECX_PKU_MASK check.  The OSPKE one is
sufficient.

> +static uint32_t get_xstate_size(void)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +
> +	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER, eax, ebx,
> +		      ecx, edx);
> +	/*
> +	 * EBX enumerates the size (in bytes) required by the XSAVE
> +	 * instruction for an XSAVE area containing all the user state
> +	 * components corresponding to bits currently set in XCR0.
> +	 */
> +	return ebx;
> +}
> +
> +static struct xsave_buffer *alloc_xbuf(uint32_t buf_size)
> +{
> +	struct xsave_buffer *xbuf;
> +
> +	/* XSAVE buffer should be 64B-aligned. */
> +	xbuf = aligned_alloc(64, buf_size);
> +	if (!xbuf)
> +		fatal_error("aligned_alloc()");
> +
> +	return xbuf;
> +}
> +
> +static inline void __xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
> +{
> +	uint32_t rfbm_lo = rfbm;
> +	uint32_t rfbm_hi = rfbm >> 32;
> +
> +	asm volatile("xsave (%%rdi)"
> +		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
> +		     : "memory");
> +}
> +
> +static inline void __xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
> +{
> +	uint32_t rfbm_lo = rfbm;
> +	uint32_t rfbm_hi = rfbm >> 32;
> +
> +	asm volatile("xrstor (%%rdi)"
> +		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
> +}

Could you please move all of these generic functions into a common
header?  Maybe the same one with __cpuid()?

> +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> +		       int flags)
> +{
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_sigaction = handler;
> +	sa.sa_flags = SA_SIGINFO | flags;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(sig, &sa, 0))
> +		fatal_error("sigaction");
> +}
> +
> +static void clearhandler(int sig)
> +{
> +	struct sigaction sa;
> +
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_handler = SIG_DFL;
> +	sigemptyset(&sa.sa_mask);
> +	if (sigaction(sig, &sa, 0))
> +		fatal_error("sigaction");
> +}
> +
> +/* Retrieve the offset and size of a specific xstate. */
> +static void retrieve_xstate_size_and_offset(uint32_t xfeature_num)
> +{
> +	uint32_t eax, ebx, ecx, edx;
> +
> +	__cpuid_count(CPUID_LEAF_XSTATE, xfeature_num, eax, ebx, ecx, edx);
> +	/*
> +	 * CPUID.(EAX=0xd, ECX=xfeature_num), and output is as follow:
> +	 * eax: xfeature num state component size
> +	 * ebx: xfeature num state component offset in user buffer
> +	 */
> +	xstate_info.size[xfeature_num] = eax;
> +	xstate_info.offset[xfeature_num] = ebx;
> +}
> +
> +static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
> +{
> +	/* XSTATE_BV is at the beginning of xstate header. */
> +	*(uint64_t *)(&buffer->header) = bv;
> +}
> +
> +static void check_cpuid_xstate_info(void)
> +{
> +	/* CPUs that support XSAVE could support FP and SSE by default. */
> +	xstate_info.mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
> +
> +	xstate_size = get_xstate_size();
> +	if (cpu_has_avx2()) {
> +		xstate_info.mask |= XFEATURE_MASK_YMM;
> +		retrieve_xstate_size_and_offset(XFEATURE_YMM);
> +	}
> +
> +	if (cpu_has_avx512f()) {
> +		xstate_info.mask |= XFEATURE_MASK_OPMASK | XFEATURE_MASK_ZMM_Hi256 |
> +				    XFEATURE_MASK_Hi16_ZMM;
> +		retrieve_xstate_size_and_offset(XFEATURE_OPMASK);
> +		retrieve_xstate_size_and_offset(XFEATURE_ZMM_Hi256);
> +		retrieve_xstate_size_and_offset(XFEATURE_Hi16_ZMM);
> +	}
> +
> +	if (cpu_has_pkeys()) {
> +		xstate_info.mask |= XFEATURE_MASK_PKRU;
> +		retrieve_xstate_size_and_offset(XFEATURE_PKRU);
> +	}
> +}
> +
> +static void fill_xstate_buf(uint8_t test_byte, unsigned char *buf,
> +			    int xfeature_num)
> +{
> +	uint32_t i;
> +
> +	for (i = 0; i < xstate_info.size[xfeature_num]; i++)
> +		buf[xstate_info.offset[xfeature_num] + i] = test_byte;
> +}
> +
> +/* Fill FP/XMM/YMM/OPMASK and PKRU xstates into buffer. */
> +static void fill_xstates_buf(struct xsave_buffer *buf, uint32_t xsave_mask)
> +{
> +	uint32_t i;
> +	/* The data of FP x87 state are as follows. */

OK, but what *is* this?  Random data?  Or did you put some data in that
means something?

> +	unsigned char fp_data[160] = {
> +		0x7f, 0x03, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00,
> +		0xf0, 0x19, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> +
> +	/* Clean the buffer with all 0 first. */
> +	memset(buf, 0, xstate_size);
> +
> +	/* Fill fp x87 state: MXCSR and MXCSR_MASK data(0-159 bytes) into buffer. */
> +	memcpy(buf, fp_data, FP_SIZE);
> +
> +	/*
> +	 * Fill test byte value into XMM xstate buffer(160-415 bytes).
> +	 * xstate 416-511 bytes are reserved as 0.
> +	 */
> +	for (i = 0; i < XMM_SIZE; i++)
> +		*((unsigned char *)buf + XMM_OFFSET + i) = XSTATE_TESTBYTE;

Isn't this just memset()?

> +	/*
> +	 * Fill xstate-component bitmap(512-519 bytes) into xstate header.
> +	 * xstate header range is 512-575 bytes.
> +	 */
> +	set_xstatebv(buf, xsave_mask);
> +
> +	/* Fill test byte value into YMM xstate buffer(YMM offset/size). */
> +	if (xstate_tested(XFEATURE_YMM))
> +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf, XFEATURE_YMM);
> +
> +	/*
> +	 * Fill test byte value into AVX512 OPMASK/ZMM xstates buffer
> +	 * (AVX512_OPMASK/ZMM_Hi256/Hi16_ZMM offset/size).
> +	 */
> +	if (xstate_tested(XFEATURE_OPMASK))
> +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf, XFEATURE_OPMASK);
> +	if (xstate_tested(XFEATURE_ZMM_Hi256)) {
> +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf,
> +				XFEATURE_ZMM_Hi256);
> +	}
> +	if (xstate_tested(XFEATURE_Hi16_ZMM)) {
> +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf,
> +				XFEATURE_Hi16_ZMM);
> +	}
> +
> +	if (xstate_tested(XFEATURE_PKRU)) {
> +		/* Only 0-3 bytes of pkru xstates are allowed to be written. */
> +		memset((unsigned char *)buf + xstate_info.offset[XFEATURE_PKRU],
> +			PKRU_TESTBYTE, sizeof(uint32_t));
> +	}
> +}

I have to wonder if we can do this in a bit more structured way:

struct xstate_test
{
	bool (*init)(void);
	bool (*fill_state)(struct xsave_buffer *buf);
	...
}

Yes, that means indirect function calls, but that's OK since we know it
will all be compiled with the "no-sse" flag (and friends).

Then fill_xstates_buf() just becomes a loop over an xstate_tests[] array.

> +/*
> + * Because xstate like XMM, YMM registers are not preserved across function
> + * calls, so use inline function with assembly code only for fork syscall.
> + */
> +static inline long long __fork(void)
> +{
> +	long long ret, nr = SYS_fork;

Are those the right types?  'long long' is 64-bit on 32-bit systems, iirc.

> +	asm volatile("syscall"
> +		 : "=a" (ret)
> +		 : "a" (nr), "b" (nr)
> +		 : "rcx", "r11", "memory", "cc");
> +
> +	return ret;
> +}
>
> +/*
> + * Because xstate like XMM, YMM registers are not preserved across function
> + * calls, so use inline function with assembly code only to raise signal.
> + */
> +static inline long long __raise(long long pid_num, long long sig_num)
> +{
> +	long long ret, nr = SYS_kill;
> +
> +	register long long arg1 asm("rdi") = pid_num;
> +	register long long arg2 asm("rsi") = sig_num;

I really don't like register variables.  They're very fragile.  Imagine
if someone put a printf() right here.  Why don't you just do this with
inline assembly directives?

> +	asm volatile("syscall"
> +		 : "=a" (ret)
> +		 : "a" (nr), "b" (nr), "r" (arg1), "r" (arg2)
> +		 : "rcx", "r11", "memory", "cc");
> +
> +	return ret;
> +}
> +
> +static void sigusr1_handler(int signum, siginfo_t *info, void *__ctxp)
> +{
> +	sigusr1_done = true;
> +}
> +
> +static void test_xstate_sig_handle(void)
> +{
> +	pid_t process_pid;
> +
> +	sethandler(SIGUSR1, sigusr1_handler, 0);
> +	printf("[RUN]\tCheck xstate around signal handling test.\n");
> +	process_pid = getpid();
> +
> +	/*
> +	 * Xrstor the valid_xbuf and call syscall assembly instruction, then
> +	 * save the xstate to compared_xbuf after signal handling for comparison.
> +	 */
> +	__xrstor(valid_xbuf, xstate_info.mask);
> +	__raise(process_pid, SIGUSR1);
> +	__xsave(compared_xbuf, xstate_info.mask);
> +	if (sigusr1_done == true)
> +		printf("[NOTE]\tSIGUSR1 handling is done.\n");
> +	else
> +		fatal_error("Didn't access SIGUSR1 handling after raised SIGUSR1");
> +
> +	if (memcmp(&valid_xbuf->bytes[0], &compared_xbuf->bytes[0], xstate_size))
> +		printf("[FAIL]\tProcess xstate is not same after signal handling\n");
> +	else
> +		printf("[PASS]\tProcess xstate is same after signal handling.\n");
> +
> +	clearhandler(SIGUSR1);
> +}
> +
> +static void test_xstate_fork(void)
> +{
> +	pid_t child;
> +	int status;
> +
> +	printf("[RUN]\tParent pid:%d check xstate around fork test.\n", getpid());
> +	memset(compared_xbuf, 0, xstate_size);
> +
> +	/*
> +	 * Xrstor the valid_xbuf and call syscall assembly instruction, then
> +	 * save the xstate to compared_xbuf in child process for comparison.
> +	 */
> +	__xrstor(valid_xbuf, xstate_info.mask);
> +	child = __fork();
> +	if (child < 0) {
> +		/* Fork syscall failed */
> +		fatal_error("fork failed");
> +	} else if (child == 0) {
> +		/* Fork syscall succeeded, now in the child. */
> +		__xsave(compared_xbuf, xstate_info.mask);
> +		if (memcmp(&valid_xbuf->bytes[0], &compared_xbuf->bytes[0],
> +			xstate_size)) {
> +			printf("[FAIL]\tXstate of child process:%d is not same as xstate of parent\n",
> +				getpid());
> +		} else {
> +			printf("[PASS]\tXstate of child process:%d is same as xstate of parent.\n",
> +				getpid());
> +		}
> +	} else {
> +		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
> +			fatal_error("Child exit with error status");

It also couldn't hurt to check the XSAVE state in the parent.
