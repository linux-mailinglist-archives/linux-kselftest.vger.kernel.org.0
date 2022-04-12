Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBDD4FE359
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Apr 2022 16:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiDLOFk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 10:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbiDLOFj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 10:05:39 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79F05DA4F;
        Tue, 12 Apr 2022 07:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649772201; x=1681308201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=z6pE9a5B/XmIXjP2jsVmYq/xw+V7DDQ3FpYYZD2HjYQ=;
  b=JYdivysBBsmBHa0unjpVC4iq/Z+PqDpypotq1v9PjBE7ko9hfIFAgeGS
   3EmWtWYZvMPjx1+EAQkvWyQNGO1JAe8EPR5XP44f00ANvCEeoRPawtuvB
   DTimAgoJDL+6RWAady/Om9PikAHzT/hOAx6PuGQIzKL0KorquSr+URM2s
   wh4ciHslLwA4zj/HjXOsel5otVZFtD35XctGR4vo4JMrw+UPHggFNVABI
   0QnTzVS48Q+E2Bfxsk38MdB5oH8VHgCrqJ0JYwc2Av5RULvytVmnjRpTS
   RJDHHHd0560UOHHsJrakCh5h2oQ523+UH6Q7ydxcJ38DCp40l3/JLPGnM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348818794"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="348818794"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="572775538"
Received: from xpf.sh.intel.com ([10.239.182.112])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2022 07:03:15 -0700
Date:   Tue, 12 Apr 2022 22:01:54 +0800
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
Message-ID: <YlWGUvdSPd/zboC6@xpf.sh.intel.com>
References: <cover.1646999762.git.pengfei.xu@intel.com>
 <4268a0203fd6e42a31bde3254ee50dd93fd233ea.1646999762.git.pengfei.xu@intel.com>
 <441dd314-3a82-cf53-8e2c-badedfe22d8c@intel.com>
 <YlP/gvE4qzPj8sWF@xpf.sh.intel.com>
 <c9f881fb-460e-de44-a6f8-0faf05dda9b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9f881fb-460e-de44-a6f8-0faf05dda9b7@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2022-04-11 at 07:42:53 -0700, Dave Hansen wrote:
> On 4/11/22 03:14, Pengfei Xu wrote:
> > On 2022-04-08 at 09:58:50 -0700, Dave Hansen wrote:
> >> On 3/16/22 05:40, Pengfei Xu wrote:
> >>> +#ifndef __cpuid_count
> >>> +#define __cpuid_count(level, count, a, b, c, d) ({	\
> >>> +	__asm__ __volatile__ ("cpuid\n\t"	\
> >>> +			: "=a" (a), "=b" (b), "=c" (c), "=d" (d)	\
> >>> +			: "0" (level), "2" (count));	\
> >>> +})
> >>> +#endif
> >>
> >>
> >> By the time you post the next revision, I hope these are merged:
> >>
> >>> https://lore.kernel.org/all/cover.1647360971.git.reinette.chatre@intel.com/
> >>
> >> Could you rebase on top of those to avoid duplication, please?
> >>
> >   Yes, thanks for remind. I would like to use the helper __cpuid_count() based
> >   on above fixed patch.
> >   And I have a concern with stdlib.h with "-mno-sse" issue, it's a GCC bug,
> >   and it will be fixed in GCC11. And I could not use kselftest.h, because
> >   kselftest.h used stdlib.h also...
> 
> Ugh.  What a mess.
> 
  I found the solution you mentioned as follow. I will try to fix it. Thanks!

> >   Thanks for the link! From above "id=27600"link, Lu Hongjiu mentioned that:
> >   It's a "GCC bug: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99652"
> >   And id=99652 shows that it's fixed in GCC 11.
> >   I tried "-mgeneral-regs-only"(it includes "-mno-sse"), it also gcc failed
> >   with same error as "-mno-sse":
> >   "
> > /usr/include/bits/stdlib-float.h: In function ‘atof’:
> > /usr/include/bits/stdlib-float.h:26:1: error: SSE register return with SSE disabled
> >   "
> >   And the error shows that: it's related to "stdlib-float.h", seems I didn't
> >   use stdlib-float.h related function.
> > 
> >   In order for this test code to support GCC versions before GCC11, such as
> >   GCC8, etc., I used this workaround "avoid stdlib.h" for GCC bug, and add
> >   *aligned_alloc() declaration above.
> > 
> >   Because kselftest.h uses stdlib.h also, so I could not use kselftest.h with
> >   "-mno-see" special GCC requirement, and seems I could not use __cpuid_count()
> >   patch in kselftest.h from Reinette Chatre.
> >   Thanks!
> 
> Can you break this test up into two pieces which are spread across two
> .c files?  One that *just* does the sequences that need XSAVE and to
> preserve FPU state with -mno-sse, and then a separate one that uses
> stdlib.h and also the kselftest infrastructure?
> 
> For instance, all of the detection and enumeration can be in the nornal
> .c file.
> 
  Thanks a lot for suggestion!
  I will put normal function in "prepare_xstate.c", and there is a
  "prepare_xstate.h" also. Only keep _xsave, _xrstor, key test function
  in xstate.c.
  gcc -xx(some other parm) -c prepare_xstate.c
  gcc -xx -mno-sse xstate.c prepare_xstate.o

> ...
> >>> +/* Fill FP/XMM/YMM/OPMASK and PKRU xstates into buffer. */
> >>> +static void fill_xstates_buf(struct xsave_buffer *buf, uint32_t xsave_mask)
> >>> +{
> >>> +	uint32_t i;
> >>> +	/* The data of FP x87 state are as follows. */
> >>
> >> OK, but what *is* this?  Random data?  Or did you put some data in that
> >> means something?
> >>
> > I learned from filling the fp data by follow functions: fill FPU xstate
> > by fldl instructions, push the source operand onto the FPU register stack
> >  and recorded the fp xstate, then used buffer filling way
> > to fill the fpu xstates:
> > Some fp data could be set as random value under the "FP in SDM rules".
> > Shall I add the comment for the fpu data filling like as follow:
> > "
> > /*
> >  * The data of FP x87 state has the same effect as pushing source operand
> >  * 0x1f2f3f4f1f2f3f4f onto the FPU stack ST0-7.
> >  */
> > unsigned char fp_data[160] = {...
> > "
> 
> No, that's hideous.  If you generated the fp state with code, let's
> include the *code*.
> 
  Thanks for suggestion. Yes, I could use fp instructions back and xsave inline
  function to xsave fp xstate into buf. I will think about it. Thanks!

> > As follow is the pushing source operand 0x1f2f3f4f1f2f3f4f onto the FPU stack
> > ST0-7:
> > "
> > static inline void prepare_fp_buf(uint64_t ui64_fp)
> > {
> > 	/* Populate ui64_fp value onto FP registers stack ST0-7. */
> > 	asm volatile("finit");
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > 	asm volatile("fldl %0" : : "m" (ui64_fp));
> > }
> > ...
> > prepare_fp_buf(0x1f2f3f4f);
> > __xsave(buf, xstate_info.mask);
> > "
> > 
> > The code to set fp data and display xstate is as follow:
> > https://github.com/xupengfe/xstate_show/blob/0411_fp/x86/xstate.c
> > 
> > I found there were 2 different:
> >>> +	unsigned char fp_data[160] = {
> >>> +		0x7f, 0x03, 0x00, 0x00, 0xff, 0x00, 0x00, 0x00,
> >>> +		0xf0, 0x19, 0x40, 0x00, 0x00, 0x00, 0x00, 0x00,
> >             ^Above function shows "0xff, 0x12" not "0xf0, 0x19" in 0x8/0x9
> > offset bytes:
> > Bytes 11:8 are used for bits 31:0 of the x87 FPU Instruction Pointer
> > Offset(FIP). It could be impacted if I added "vzeroall" and so on instructions,
> > in order to match with above fpu function result, will change to "0xff, 0x12".
> > 
> >>> +		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> >>> +		0x00, 0x00, 0x00, 0x00, 0xff, 0xff, 0x00, 0x00,
> >             ^Above function shows "0x80, 0x1f" not "0x00, 0x00" in offset
> > 0x18/0x19 bytes:
> > Bytes 27:24 are used for the MXCSR register. XRSTOR and XRSTORS generate
> > general-protection faults (#GP) in response to attempts to set any of the
> > reserved bits of the MXCSR register.
> > It could be set as "0x00, 0x00", in order to match with result of above
> > function, will fill as "0x80, 0x1f".
> 
> I'm totally lost with what you are trying to say here.
> 
  I used above "finit, fldl" instructions way to populate fp xstates as before.
  Sorry for unclear description.

> ...
> >> I have to wonder if we can do this in a bit more structured way:
> >>
> >> struct xstate_test
> >> {
> >> 	bool (*init)(void);
> >> 	bool (*fill_state)(struct xsave_buffer *buf);
> >> 	...
> >> }
> >>
> >> Yes, that means indirect function calls, but that's OK since we know it
> >> will all be compiled with the "no-sse" flag (and friends).
> >>
> >> Then fill_xstates_buf() just becomes a loop over an xstate_tests[] array.
> >>
> >   Yes, it's much better to fill the buf in a loop! Thanks!
> >   Because it's special for pkru filling, so I will improve it like as follow:
> > "
> > 	uint32_t xfeature_num;
> > ...
> > 
> > 	/* Fill test byte value into each tested xstate buffer(offset/size). */
> > 	for (xfeature_num = XFEATURE_YMM; xfeature_num < XFEATURE_MAX;
> > 			xfeature_num++) {
> > 		if (xstate_tested(xfeature_num)) {
> > 			if (xfeature_num == XFEATURE_PKRU) {
> > 				/* Only 0-3 bytes of pkru xstates are allowed to be written. */
> > 				memset((unsigned char *)buf + xstate_info.offset[XFEATURE_PKRU],
> > 					PKRU_TESTBYTE, sizeof(uint32_t));
> > 				continue;
> > 			}
> > 
> > 			memset((unsigned char *)buf + xstate_info.offset[xfeature_num],
> > 				XSTATE_TESTBYTE, xstate_info.size[xfeature_num]);
> > 		}
> > 	}
> > "
> 
> I'm not sure that's an improvement.
> 
  Ok. Except FP and xstate_bv, this loop will fill each tested value into
  xstate buffer. Thanks!

> >>> +/*
> >>> + * Because xstate like XMM, YMM registers are not preserved across function
> >>> + * calls, so use inline function with assembly code only to raise signal.
> >>> + */
> >>> +static inline long long __raise(long long pid_num, long long sig_num)
> >>> +{
> >>> +	long long ret, nr = SYS_kill;
> >>> +
> >>> +	register long long arg1 asm("rdi") = pid_num;
> >>> +	register long long arg2 asm("rsi") = sig_num;
> >>
> >> I really don't like register variables.  They're very fragile.  Imagine
> >> if someone put a printf() right here.  Why don't you just do this with
> >> inline assembly directives?
> >>
> >   It seems that adding printf() to an inline function is not good.
> >   I'm not sure if I understand correctly: should I use inline assembly to
> >   assign variables to rdi, rsi and then syscall?
> >   It it's right, I will think about how to implement it by inline assembly way
> >   and fix it.
> 
> Yes, do it with inline assembly.
> 
  I will move value into rdi rsi register as inline assembly like follow:
	asm volatile("movq %0, %%rdi" : : "r"(pid_num) : "%rdi");

 Thanks!
 --Pengfei
