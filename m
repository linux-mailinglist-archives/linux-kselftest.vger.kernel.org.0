Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21234FB93B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Apr 2022 12:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242735AbiDKKSU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Apr 2022 06:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345338AbiDKKSH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Apr 2022 06:18:07 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD834E78;
        Mon, 11 Apr 2022 03:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649672152; x=1681208152;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k8IGwDhGiKuK3natjK8J+qrQPyOWJSFSs6/Fi8rhPXk=;
  b=fYWX8IliP2Lctf2d6EGOl5xD6k0QG4lLdI8ikG30uZjlTRoD1C+z4ynt
   w8jrwroS+ffPtDt4RuHVOQMSq7EJsxUEPZSZMHAndb7cwrMEyj8oE+Xs+
   BrE6HQ27vpbf93pugUAuuDbLwNdXu+ImMhwVlxdkYmrKfIagDz68JJW6i
   AZTO6FuRZM9Wgn0TcTnC7wRrz1ZCt5M+TkwaXwO5LwojXxuw/rom1ChtN
   4NhSN/1gV8tfvbtD524Yiwp3A1naUR8OJOB0wvlYToplOjt+7JG26CVkW
   cm6/jKdueDQKmMMvpyUn/8KcR5alDEZd47JqasaETH3x2g+TEXkaWkMDt
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="242669576"
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="242669576"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 03:15:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,251,1643702400"; 
   d="scan'208";a="525923775"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga006.jf.intel.com with ESMTP; 11 Apr 2022 03:15:48 -0700
Date:   Mon, 11 Apr 2022 18:14:26 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Heng Su <heng.su@intel.com>, Luck Tony <tony.luck@intel.com>,
        Mehta Sohil <sohil.mehta@intel.com>,
        Chen Yu C <yu.c.chen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bae Chang Seok <chang.seok.bae@intel.com>
Subject: Re: [PATCH v8 1/1] selftests/x86/xstate: Add xstate test cases for
 XSAVE feature
Message-ID: <YlP/gvE4qzPj8sWF@xpf.sh.intel.com>
References: <cover.1646999762.git.pengfei.xu@intel.com>
 <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
 <441dd314-3a82-cf53-8e2c-badedfe22d8c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <441dd314-3a82-cf53-8e2c-badedfe22d8c@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-04-08 at 09:58:50 -0700, Dave Hansen wrote:
> On 3/16/22 05:40, Pengfei Xu wrote:
> > +#ifndef __cpuid_count
> > +#define __cpuid_count(level, count, a, b, c, d) ({	\
> > +	__asm__ __volatile__ ("cpuid\n\t"	\
> > +			: "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> > +			: "0" (level), "2" (count));	\
> > +})
> > +#endif
> 
> 
> By the time you post the next revision, I hope these are merged:
> 
> > https://lore.kernel.org/all/cover.1647360971.git.reinette.chatre@intel.com/
> 
> Could you rebase on top of those to avoid duplication, please?
> 
  Yes, thanks for remind. I would like to use the helper __cpuid_count() based
  on above fixed patch.
  And I have a concern with stdlib.h with "-mno-sse" issue, it's a GCC bug,
  and it will be fixed in GCC11. And I could not use kselftest.h, because
  kselftest.h used stdlib.h also...

> > +/*
> > + * While this function prototype is in the stdlib.h, the header file cannot be
> > + * included with the -mno-sse option.
> > + */
> > +void *aligned_alloc(size_t alignment, size_t size);
> 
> That is worrisome.  I would serioulsy suspect that if the header can't
> be included that the code that it references has issues as well.
> 
> Or, is this just working around a compiler bug?  Just googling:
> 
> 	https://www.google.com/search?q=stdlib.h+no-sse
> 
> points to this:
> 
> 	https://sourceware.org/bugzilla/show_bug.cgi?id=27600
> 
  Thanks for the link! From above "id=27600"link, Lu Hongjiu mentioned that:
  It's a "GCC bug: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652"
  And id=99652 shows that it's fixed in GCC 11.
  I tried "-mgeneral-regs-only"(it includes "-mno-sse"), it also gcc failed
  with same error as "-mno-sse":
  "
/usr/include/bits/stdlib-float.h: In function ‘atof’:
/usr/include/bits/stdlib-float.h:26:1: error: SSE register return with SSE disabled
  "
  And the error shows that: it's related to "stdlib-float.h", seems I didn't
  use stdlib-float.h related function.

  In order for this test code to support GCC versions before GCC11, such as
  GCC8, etc., I used this workaround "avoid stdlib.h" for GCC bug, and add
  *aligned_alloc() declaration above.

  Because kselftest.h uses stdlib.h also, so I could not use kselftest.h with
  "-mno-see" special GCC requirement, and seems I could not use __cpuid_count()
  patch in kselftest.h from Reinette Chatre.
  Thanks!

> > +enum supportability {
> > +	NOT_SUPPORT,
> > +	SUPPORT,
> > +};
> > +
> > +/* It's from arch/x86/kernel/fpu/xstate.c. */
> > +static const char * const xfeature_names[] = {
> > +	"x87 floating point registers",
> > +	"SSE registers",
> > +	"AVX registers",
> > +	"MPX bounds registers",
> > +	"MPX CSR",
> > +	"AVX-512 opmask",
> > +	"AVX-512 Hi256",
> > +	"AVX-512 ZMM_Hi256",
> > +	"Processor Trace (unused)",
> > +	"Protection Keys User registers",
> > +	"PASID state",
> > +	"unknown xstate feature",
> > +	"unknown xstate feature",
> > +	"unknown xstate feature",
> > +	"unknown xstate feature",
> > +	"unknown xstate feature",
> > +	"unknown xstate feature",
> > +	"AMX Tile config",
> > +	"AMX Tile data",
> > +	"unknown xstate feature",
> > +};
> > +
> > +/* List of XSAVE features Linux knows about. */
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
> > +	XFEATURE_RSRVD_COMP_16,
> > +	XFEATURE_XTILE_CFG,
> > +	XFEATURE_XTILE_DATA,
> > +	XFEATURE_MAX,
> > +};
> > +
> > +struct xsave_buffer {
> > +	union {
> > +		struct {
> > +			char legacy[XSAVE_HDR_OFFSET];
> > +			char header[XSAVE_HDR_SIZE];
> > +			char extended[0];
> > +		};
> > +		char bytes[0];
> > +	};
> > +};
> > +
> > +static struct {
> > +	uint64_t mask;
> > +	uint32_t size[XFEATURE_MAX];
> > +	uint32_t offset[XFEATURE_MAX];
> > +} xstate_info;
> > +
> > +static inline void check_cpuid_xsave_availability(void)
> > +{
> > +	uint32_t eax, ebx, ecx, edx;
> > +
> > +	/*
> > +	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
> > +	 * support for the XSAVE feature set, including
> > +	 * XGETBV.
> > +	 */
> > +	__cpuid_count(1, 0, eax, ebx, ecx, edx);
> > +	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
> > +		fatal_error("cpuid: no CPU xsave support");
> > +	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
> > +		fatal_error("cpuid: no OS xsave support");
> > +}
> 
> Could you please use the standard selftest macros for these fatal
> errors?  Also, do these indicate that the test failed, or that it just
> was not able to run?
> 
  Due to above reason, I could not use kselftest.h and ksft_exit(condition) in
  kselftest.h.
  Yes, my bad, it should not fatal error here, it should skip print because
  it was not able to run and exit here. Thanks!

> > +static inline bool xstate_tested(int xfeature_num)
> > +{
> > +	return !!(xstate_info.mask & (1 << xfeature_num));
> > +}
> > +
> > +static inline int cpu_has_avx2(void)
> > +{
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	/* CPUID.7.0:EBX.AVX2[bit 5]: the support for AVX2 instructions */
> > +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> > +
> > +	return !!(ebx & CPUID_LEAF7_EBX_AVX2_MASK);
> > +}
> > +
> > +static inline int cpu_has_avx512f(void)
> > +{
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	/* CPUID.7.0:EBX.AVX512F[bit 16]: the support for AVX512F instructions */
> > +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> > +
> > +	return !!(ebx & CPUID_LEAF7_EBX_AVX512F_MASK);
> > +}
> > +
> > +static inline int cpu_has_pkeys(void)
> > +{
> > +	unsigned int eax, ebx, ecx, edx;
> > +
> > +	/* CPUID.7.0:ECX.PKU[bit 3]: the support for PKRU instructions */
> > +	__cpuid_count(7, 0, eax, ebx, ecx, edx);
> > +	if (!(ecx & CPUID_LEAF7_ECX_PKU_MASK))
> > +		return NOT_SUPPORT;
> > +	/* CPUID.7.0:ECX.OSPKE[bit 4]: the support for OS set CR4.PKE */
> > +	if (!(ecx & CPUID_LEAF7_ECX_OSPKE_MASK))
> > +		return NOT_SUPPORT;
> > +
> > +	return SUPPORT;
> > +}
> 
> You don't need that CPUID_LEAF7_ECX_PKU_MASK check.  The OSPKE one is
> sufficient.
> 
  Thanks for suggestion, it make sense, I will fix it in next version.

> > +static uint32_t get_xstate_size(void)
> > +{
> > +	uint32_t eax, ebx, ecx, edx;
> > +
> > +	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER, eax, ebx,
> > +		      ecx, edx);
> > +	/*
> > +	 * EBX enumerates the size (in bytes) required by the XSAVE
> > +	 * instruction for an XSAVE area containing all the user state
> > +	 * components corresponding to bits currently set in XCR0.
> > +	 */
> > +	return ebx;
> > +}
> > +
> > +static struct xsave_buffer *alloc_xbuf(uint32_t buf_size)
> > +{
> > +	struct xsave_buffer *xbuf;
> > +
> > +	/* XSAVE buffer should be 64B-aligned. */
> > +	xbuf = aligned_alloc(64, buf_size);
> > +	if (!xbuf)
> > +		fatal_error("aligned_alloc()");
> > +
> > +	return xbuf;
> > +}
> > +
> > +static inline void __xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
> > +{
> > +	uint32_t rfbm_lo = rfbm;
> > +	uint32_t rfbm_hi = rfbm >> 32;
> > +
> > +	asm volatile("xsave (%%rdi)"
> > +		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi)
> > +		     : "memory");
> > +}
> > +
> > +static inline void __xrstor(struct xsave_buffer *xbuf, uint64_t rfbm)
> > +{
> > +	uint32_t rfbm_lo = rfbm;
> > +	uint32_t rfbm_hi = rfbm >> 32;
> > +
> > +	asm volatile("xrstor (%%rdi)"
> > +		     : : "D" (xbuf), "a" (rfbm_lo), "d" (rfbm_hi));
> > +}
> 
> Could you please move all of these generic functions into a common
> header?  Maybe the same one with __cpuid()?
> 
  Yes, it looks better, I will move these generic functions to xstate.h.
  Thanks!

> > +static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
> > +		       int flags)
> > +{
> > +	struct sigaction sa;
> > +
> > +	memset(&sa, 0, sizeof(sa));
> > +	sa.sa_sigaction = handler;
> > +	sa.sa_flags = SA_SIGINFO | flags;
> > +	sigemptyset(&sa.sa_mask);
> > +	if (sigaction(sig, &sa, 0))
> > +		fatal_error("sigaction");
> > +}
> > +
> > +static void clearhandler(int sig)
> > +{
> > +	struct sigaction sa;
> > +
> > +	memset(&sa, 0, sizeof(sa));
> > +	sa.sa_handler = SIG_DFL;
> > +	sigemptyset(&sa.sa_mask);
> > +	if (sigaction(sig, &sa, 0))
> > +		fatal_error("sigaction");
> > +}
> > +
> > +/* Retrieve the offset and size of a specific xstate. */
> > +static void retrieve_xstate_size_and_offset(uint32_t xfeature_num)
> > +{
> > +	uint32_t eax, ebx, ecx, edx;
> > +
> > +	__cpuid_count(CPUID_LEAF_XSTATE, xfeature_num, eax, ebx, ecx, edx);
> > +	/*
> > +	 * CPUID.(EAX=0xd, ECX=xfeature_num), and output is as follow:
> > +	 * eax: xfeature num state component size
> > +	 * ebx: xfeature num state component offset in user buffer
> > +	 */
> > +	xstate_info.size[xfeature_num] = eax;
> > +	xstate_info.offset[xfeature_num] = ebx;
> > +}
> > +
> > +static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
> > +{
> > +	/* XSTATE_BV is at the beginning of xstate header. */
> > +	*(uint64_t *)(&buffer->header) = bv;
> > +}
> > +
> > +static void check_cpuid_xstate_info(void)
> > +{
> > +	/* CPUs that support XSAVE could support FP and SSE by default. */
> > +	xstate_info.mask = XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
> > +
> > +	xstate_size = get_xstate_size();
> > +	if (cpu_has_avx2()) {
> > +		xstate_info.mask |= XFEATURE_MASK_YMM;
> > +		retrieve_xstate_size_and_offset(XFEATURE_YMM);
> > +	}
> > +
> > +	if (cpu_has_avx512f()) {
> > +		xstate_info.mask |= XFEATURE_MASK_OPMASK | XFEATURE_MASK_ZMM_Hi256 |
> > +				    XFEATURE_MASK_Hi16_ZMM;
> > +		retrieve_xstate_size_and_offset(XFEATURE_OPMASK);
> > +		retrieve_xstate_size_and_offset(XFEATURE_ZMM_Hi256);
> > +		retrieve_xstate_size_and_offset(XFEATURE_Hi16_ZMM);
> > +	}
> > +
> > +	if (cpu_has_pkeys()) {
> > +		xstate_info.mask |= XFEATURE_MASK_PKRU;
> > +		retrieve_xstate_size_and_offset(XFEATURE_PKRU);
> > +	}
> > +}
> > +
> > +static void fill_xstate_buf(uint8_t test_byte, unsigned char *buf,
> > +			    int xfeature_num)
> > +{
> > +	uint32_t i;
> > +
> > +	for (i = 0; i < xstate_info.size[xfeature_num]; i++)
> > +		buf[xstate_info.offset[xfeature_num] + i] = test_byte;
> > +}
> > +
> > +/* Fill FP/XMM/YMM/OPMASK and PKRU xstates into buffer. */
> > +static void fill_xstates_buf(struct xsave_buffer *buf, uint32_t xsave_mask)
> > +{
> > +	uint32_t i;
> > +	/* The data of FP x87 state are as follows. */
> 
> OK, but what *is* this?  Random data?  Or did you put some data in that
> means something?
> 
I learned from filling the fp data by follow functions: fill FPU xstate
by fldl instructions, push the source operand onto the FPU register stack
 and recorded the fp xstate, then used buffer filling way
to fill the fpu xstates:
Some fp data could be set as random value under the "FP in SDM rules".
Shall I add the comment for the fpu data filling like as follow:
"
/*
 * The data of FP x87 state has the same effect as pushing source operand
 * 0x1f2f3f4f1f2f3f4f onto the FPU stack ST0-7.
 */
unsigned char fp_data[160] = {...
"

As follow is the pushing source operand 0x1f2f3f4f1f2f3f4f onto the FPU stack
ST0-7:
"
static inline void prepare_fp_buf(uint64_t ui64_fp)
{
	/* Populate ui64_fp value onto FP registers stack ST0-7. */
	asm volatile("finit");
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
	asm volatile("fldl %0" : : "m" (ui64_fp));
}
...
prepare_fp_buf(0x1f2f3f4f);
__xsave(buf, xstate_info.mask);
"

The code to set fp data and display xstate is as follow:
https://github.com/xupengfe/xstate_show/blob/0411_fp/x86/xstate.c

I found there were 2 different:
> > +	unsigned char fp_data[160] = {
> > +		0x7f, 0x03, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00,
> > +		0xf0, 0x19, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
            ^Above function shows "0xff, 0x12" not "0xf0, 0x19" in 0x8/0x9
offset bytes:
Bytes 11:8 are used for bits 31:0 of the x87 FPU Instruction Pointer
Offset(FIP). It could be impacted if I added "vzeroall" and so on instructions,
in order to match with above fpu function result, will change to "0xff, 0x12".

> > +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
            ^Above function shows "0x80, 0x1f" not "0x00, 0x00" in offset
0x18/0x19 bytes:
Bytes 27:24 are used for the MXCSR register. XRSTOR and XRSTORS generate
general-protection faults (#GP) in response to attempts to set any of the
reserved bits of the MXCSR register.
It could be set as "0x00, 0x00", in order to match with result of above
function, will fill as "0x80, 0x1f".

> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> > +		0x00, 0x78, 0xfa, 0x79, 0xf9, 0x78, 0xfa, 0xf9,
> > +		0xf2, 0x3d, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
> > +
> > +	/* Clean the buffer with all 0 first. */
> > +	memset(buf, 0, xstate_size);
> > +
> > +	/* Fill fp x87 state: MXCSR and MXCSR_MASK data(0-159 bytes) into buffer. */
> > +	memcpy(buf, fp_data, FP_SIZE);
> > +
> > +	/*
> > +	 * Fill test byte value into XMM xstate buffer(160-415 bytes).
> > +	 * xstate 416-511 bytes are reserved as 0.
> > +	 */
> > +	for (i = 0; i < XMM_SIZE; i++)
> > +		*((unsigned char *)buf + XMM_OFFSET + i) = XSTATE_TESTBYTE;
> 
> Isn't this just memset()?
> 
  Yes, it's better, thanks! I will fix it as follow:
memset((unsigned char *)buf + XMM_OFFSET, XSTATE_TESTBYTE, XMM_SIZE);
  And fix same issue in fill_xstate_buf();

> > +	/*
> > +	 * Fill xstate-component bitmap(512-519 bytes) into xstate header.
> > +	 * xstate header range is 512-575 bytes.
> > +	 */
> > +	set_xstatebv(buf, xsave_mask);
> > +
> > +	/* Fill test byte value into YMM xstate buffer(YMM offset/size). */
> > +	if (xstate_tested(XFEATURE_YMM))
> > +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf, XFEATURE_YMM);
> > +
> > +	/*
> > +	 * Fill test byte value into AVX512 OPMASK/ZMM xstates buffer
> > +	 * (AVX512_OPMASK/ZMM_Hi256/Hi16_ZMM offset/size).
> > +	 */
> > +	if (xstate_tested(XFEATURE_OPMASK))
> > +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf, XFEATURE_OPMASK);
> > +	if (xstate_tested(XFEATURE_ZMM_Hi256)) {
> > +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf,
> > +				XFEATURE_ZMM_Hi256);
> > +	}
> > +	if (xstate_tested(XFEATURE_Hi16_ZMM)) {
> > +		fill_xstate_buf(XSTATE_TESTBYTE, (unsigned char *)buf,
> > +				XFEATURE_Hi16_ZMM);
> > +	}
> > +
> > +	if (xstate_tested(XFEATURE_PKRU)) {
> > +		/* Only 0-3 bytes of pkru xstates are allowed to be written. */
> > +		memset((unsigned char *)buf + xstate_info.offset[XFEATURE_PKRU],
> > +			PKRU_TESTBYTE, sizeof(uint32_t));
> > +	}
> > +}
> 
> I have to wonder if we can do this in a bit more structured way:
> 
> struct xstate_test
> {
> 	bool (*init)(void);
> 	bool (*fill_state)(struct xsave_buffer *buf);
> 	...
> }
> 
> Yes, that means indirect function calls, but that's OK since we know it
> will all be compiled with the "no-sse" flag (and friends).
> 
> Then fill_xstates_buf() just becomes a loop over an xstate_tests[] array.
> 
  Yes, it's much better to fill the buf in a loop! Thanks!
  Because it's special for pkru filling, so I will improve it like as follow:
"
	uint32_t xfeature_num;
...

	/* Fill test byte value into each tested xstate buffer(offset/size). */
	for (xfeature_num = XFEATURE_YMM; xfeature_num < XFEATURE_MAX;
			xfeature_num++) {
		if (xstate_tested(xfeature_num)) {
			if (xfeature_num == XFEATURE_PKRU) {
				/* Only 0-3 bytes of pkru xstates are allowed to be written. */
				memset((unsigned char *)buf + xstate_info.offset[XFEATURE_PKRU],
					PKRU_TESTBYTE, sizeof(uint32_t));
				continue;
			}

			memset((unsigned char *)buf + xstate_info.offset[xfeature_num],
				XSTATE_TESTBYTE, xstate_info.size[xfeature_num]);
		}
	}
"

> > +/*
> > + * Because xstate like XMM, YMM registers are not preserved across function
> > + * calls, so use inline function with assembly code only for fork syscall.
> > + */
> > +static inline long long __fork(void)
> > +{
> > +	long long ret, nr = SYS_fork;
> 
> Are those the right types?  'long long' is 64-bit on 32-bit systems, iirc.
> 
  Thnaks for suggestion, it should be long. Long type is 64bit in 64bit system,
and 32bit for 32bit system.

> > +	asm volatile("syscall"
> > +		 : "=a" (ret)
> > +		 : "a" (nr), "b" (nr)
> > +		 : "rcx", "r11", "memory", "cc");
> > +
> > +	return ret;
> > +}
> >
> > +/*
> > + * Because xstate like XMM, YMM registers are not preserved across function
> > + * calls, so use inline function with assembly code only to raise signal.
> > + */
> > +static inline long long __raise(long long pid_num, long long sig_num)
> > +{
> > +	long long ret, nr = SYS_kill;
> > +
> > +	register long long arg1 asm("rdi") = pid_num;
> > +	register long long arg2 asm("rsi") = sig_num;
> 
> I really don't like register variables.  They're very fragile.  Imagine
> if someone put a printf() right here.  Why don't you just do this with
> inline assembly directives?
> 
  It seems that adding printf() to an inline function is not good.
  I'm not sure if I understand correctly: should I use inline assembly to
  assign variables to rdi, rsi and then syscall?
  It it's right, I will think about how to implement it by inline assembly way
  and fix it.
  Thanks!

> > +	asm volatile("syscall"
> > +		 : "=a" (ret)
> > +		 : "a" (nr), "b" (nr), "r" (arg1), "r" (arg2)
> > +		 : "rcx", "r11", "memory", "cc");
> > +
> > +	return ret;
> > +}
> > +
> > +static void sigusr1_handler(int signum, siginfo_t *info, void *__ctxp)
> > +{
> > +	sigusr1_done = true;
> > +}
> > +
> > +static void test_xstate_sig_handle(void)
> > +{
> > +	pid_t process_pid;
> > +
> > +	sethandler(SIGUSR1, sigusr1_handler, 0);
> > +	printf("[RUN]\tCheck xstate around signal handling test.\n");
> > +	process_pid = getpid();
> > +
> > +	/*
> > +	 * Xrstor the valid_xbuf and call syscall assembly instruction, then
> > +	 * save the xstate to compared_xbuf after signal handling for comparison.
> > +	 */
> > +	__xrstor(valid_xbuf, xstate_info.mask);
> > +	__raise(process_pid, SIGUSR1);
> > +	__xsave(compared_xbuf, xstate_info.mask);
> > +	if (sigusr1_done == true)
> > +		printf("[NOTE]\tSIGUSR1 handling is done.\n");
> > +	else
> > +		fatal_error("Didn't access SIGUSR1 handling after raised SIGUSR1");
> > +
> > +	if (memcmp(&valid_xbuf->bytes[0], &compared_xbuf->bytes[0], xstate_size))
> > +		printf("[FAIL]\tProcess xstate is not same after signal handling\n");
> > +	else
> > +		printf("[PASS]\tProcess xstate is same after signal handling.\n");
> > +
> > +	clearhandler(SIGUSR1);
> > +}
> > +
> > +static void test_xstate_fork(void)
> > +{
> > +	pid_t child;
> > +	int status;
> > +
> > +	printf("[RUN]\tParent pid:%d check xstate around fork test.\n", getpid());
> > +	memset(compared_xbuf, 0, xstate_size);
> > +
> > +	/*
> > +	 * Xrstor the valid_xbuf and call syscall assembly instruction, then
> > +	 * save the xstate to compared_xbuf in child process for comparison.
> > +	 */
> > +	__xrstor(valid_xbuf, xstate_info.mask);
> > +	child = __fork();
> > +	if (child < 0) {
> > +		/* Fork syscall failed */
> > +		fatal_error("fork failed");
> > +	} else if (child == 0) {
> > +		/* Fork syscall succeeded, now in the child. */
> > +		__xsave(compared_xbuf, xstate_info.mask);
> > +		if (memcmp(&valid_xbuf->bytes[0], &compared_xbuf->bytes[0],
> > +			xstate_size)) {
> > +			printf("[FAIL]\tXstate of child process:%d is not same as xstate of parent\n",
> > +				getpid());
> > +		} else {
> > +			printf("[PASS]\tXstate of child process:%d is same as xstate of parent.\n",
> > +				getpid());
> > +		}
> > +	} else {
> > +		if (waitpid(child, &status, 0) != child || !WIFEXITED(status))
> > +			fatal_error("Child exit with error status");
> 
> It also couldn't hurt to check the XSAVE state in the parent.
Thanks for suggestion!
I will add the check point back.

Thanks!
--Pengfei
