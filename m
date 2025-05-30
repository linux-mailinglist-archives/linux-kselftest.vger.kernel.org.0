Return-Path: <linux-kselftest+bounces-34086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B077AAC9536
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 19:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BCA1C237E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37CB227585F;
	Fri, 30 May 2025 17:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hilJ88Sl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D526E173;
	Fri, 30 May 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627331; cv=none; b=KiWA/KrzIQZm6qC0NYTLP3lkQHDRXUDJ8ho1lb0dydrkYxktLzzEq904rblgcAnQHebb3NFq5hoCE6YAAOZi5Oi6jP1tc5JT0UercrXhGAR/OS6rkS9gvQwnzK4gYlPkoiLrGuBvWkFSMb2oCKRJvecRtdejnRc+e0tNQrmWzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627331; c=relaxed/simple;
	bh=9UEdvQyq4ZTEQpaSat+UrDb2/pIf0CsFRPtHS3TheEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hbq2zEkOhKGMWG5nQSYo1OA4xGtid2mbfpVLgKA6YSt9+YpGodxsX1T7FQu5UVwpgSQ+d8iwalj8FDfb9oyWb2abClkuF1yDMDd+4fnCCaPFs7OLRq7WDxhoWNgnSKDMnYK1sO7Eu4ryabhShBAGdV3ePZzRzZIDwb48R+QMIFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hilJ88Sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 690EDC4CEEB;
	Fri, 30 May 2025 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748627330;
	bh=9UEdvQyq4ZTEQpaSat+UrDb2/pIf0CsFRPtHS3TheEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hilJ88Sl8cYkkClu8F9Fu3Hy/7R+Ln+lFb+OAXtJNt2F0Jo7J8DOqGvkQJ+wpF6yQ
	 Q5aDhRBD3hR++F/I5fWa1JdXW5Ae5161bb/oe1NJlI/aWzLIFzRT2DeLmRnswIap0W
	 q6010CDaTnNRpETEMcvIjUDJOmjBwdoSUtdKUtkWmGgze2UnQ9sHA3ns2S5hjxbpAd
	 mCmTh94NAtvqG5oIUKdAACM5USMpdGBBnJTBZUAv6Zgjla+HJCs1cQt0PzDyw/uluT
	 caxLzuICpwYN1WCvX+FtJddbsQRAxEg2YSlKRUtNOiWWhJhai8o++8RrM7up0dBiTP
	 TUgBroGoMx+1w==
Date: Fri, 30 May 2025 10:48:47 -0700
From: Kees Cook <kees@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alessandro Carminati <acarmina@redhat.com>,
	linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v5 1/5] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <202505301037.D816A49@keescook>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530140140.GE21197@noisy.programming.kicks-ass.net>

On Fri, May 30, 2025 at 04:01:40PM +0200, Peter Zijlstra wrote:
> I'm not really concerned with performance here, but more with the size
> of the code emitted by WARN_ONCE(). There are a *ton* of WARN sites,
> while only one report_bug() and printk().
> 
> The really offensive thing is that this is for a feature most nobody
> will ever need :/

Well, it won't be enabled often -- this reminds me of ftrace: it needs
to work, but it'll be off most of the time.

> The below results in:
> 
> 03dc  7ac:      48 c7 c0 00 00 00 00    mov    $0x0,%rax        7af: R_X86_64_32S       .rodata.str1.1+0x223
> 03e3  7b3:      ba 2a 00 00 00          mov    $0x2a,%edx
> 03e8  7b8:      48 0f b9 d0             ud1    %rax,%rdx
> 
> And it even works :-)
> 
> Hmm... I should try and stick the format string into the __bug_table,
> its const after all. Then I can get 2 arguments covered.

I like the patch! Can you add a _little_ documentation, though? e.g.
explaining that BUG_WARN ... BUG_WARN_END is for format string args,
etc.

But yes, I *love* that this moves the printk into the handler! Like you,
I have been bothered by this for a long time and could not find a good
way to do it. This is nice.

> 
> ---
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index f0e9acf72547..88b305d49f35 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -5,6 +5,7 @@
>  #include <linux/stringify.h>
>  #include <linux/instrumentation.h>
>  #include <linux/objtool.h>
> +#include <linux/args.h>
>  
>  /*
>   * Despite that some emulators terminate on UD2, we use it for WARN().
> @@ -28,50 +29,44 @@
>  #define BUG_UD1_UBSAN		0xfffc
>  #define BUG_EA			0xffea
>  #define BUG_LOCK		0xfff0
> +#define BUG_WARN		0xfe00
> +#define BUG_WARN_END		0xfeff
>  
>  #ifdef CONFIG_GENERIC_BUG
>  
>  #ifdef CONFIG_X86_32
> -# define __BUG_REL(val)	".long " __stringify(val)
> +#define ASM_BUG_REL(val)	.long val
>  #else
> -# define __BUG_REL(val)	".long " __stringify(val) " - ."
> +#define ASM_BUG_REL(val)	.long val - .
>  #endif
>  
>  #ifdef CONFIG_DEBUG_BUGVERBOSE
> +#define ASM_BUGTABLE_VERBOSE(file, line)				\
> +	ASM_BUG_REL(file) ;						\
> +	.word line
> +#define ASM_BUGTABLE_VERBOSE_SIZE	6
> +#else
> +#define ASM_BUGTABLE_VERBOSE(file, line)
> +#define ASM_BUGTABLE_VERBOSE_SIZE	0
> +#endif
>  
> -#define _BUG_FLAGS(ins, flags, extra)					\
> -do {									\
> -	asm_inline volatile("1:\t" ins "\n"				\
> -		     ".pushsection __bug_table,\"aw\"\n"		\
> -		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
> -		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
> -		     "\t.word %c1"        "\t# bug_entry::line\n"	\
> -		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
> -		     "\t.org 2b+%c3\n"					\
> -		     ".popsection\n"					\
> -		     extra						\
> -		     : : "i" (__FILE__), "i" (__LINE__),		\
> -			 "i" (flags),					\
> -			 "i" (sizeof(struct bug_entry)));		\
> -} while (0)
> -
> -#else /* !CONFIG_DEBUG_BUGVERBOSE */
> +#define ASM_BUGTABLE_FLAGS(at, file, line, flags)			\
> +	.pushsection __bug_table, "aw" ;				\
> +	123:	ASM_BUG_REL(at) ;					\
> +	ASM_BUGTABLE_VERBOSE(file, line) ;				\
> +	.word	flags ;							\
> +	.org 123b + 6 + ASM_BUGTABLE_VERBOSE_SIZE ;			\
> +	.popsection
>  
> -#define _BUG_FLAGS(ins, flags, extra)					\
> +#define _BUG_FLAGS(ins, flags, extra, extra_args...)			\
>  do {									\
>  	asm_inline volatile("1:\t" ins "\n"				\
> -		     ".pushsection __bug_table,\"aw\"\n"		\
> -		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
> -		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
> -		     "\t.org 2b+%c1\n"					\
> -		     ".popsection\n"					\
> -		     extra						\
> -		     : : "i" (flags),					\
> -			 "i" (sizeof(struct bug_entry)));		\
> +	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
> +			    extra					\
> +		     : : "i" (__FILE__), "i" (__LINE__),		\
> +			 "i" (flags), ## extra_args);			\
>  } while (0)
>  
> -#endif /* CONFIG_DEBUG_BUGVERBOSE */
> -
>  #else
>  
>  #define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
> @@ -100,6 +95,40 @@ do {								\
>  	instrumentation_end();					\
>  } while (0)
>  
> +#define __WARN_printf_1(taint, format)				\
> +do { \
> +	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint); \
> +	unsigned long dummy = 0; \
> +	instrumentation_begin(); \
> +	asm_inline volatile("1: ud1 %[fmt], %[arg]\n"			\
> +	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
> +		     : : "i" (__FILE__), "i" (__LINE__),		\
> +			 "i" (__flags), [fmt] "r" (format), [arg] "r" (dummy));		\
> +	instrumentation_end(); \
> +} while (0)
> +
> +#define __WARN_printf_2(taint, format, _arg)				\
> +do { \
> +	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint); \
> +	instrumentation_begin(); \
> +	asm_inline volatile("1: ud1 %[fmt], %[arg]\n"			\
> +	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
> +		     : : "i" (__FILE__), "i" (__LINE__),		\
> +			 "i" (__flags), [fmt] "r" (format), [arg] "r" ((unsigned long)(_arg)));		\
> +	instrumentation_end(); \
> +} while (0)
> +
> +#define __WARN_printf_n(taint, fmt, arg...) do {			\
> +		instrumentation_begin();				\
> +		__warn_printk(fmt, arg);				\
> +		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
> +		instrumentation_end();					\
> +	} while (0)
> +
> +#define WARN_ARGS(X...) __COUNT_ARGS(, ##X, n, n, n, n, n, n, n, n, n, n, n, n, n, 2, 1, 0)
> +
> +#define __WARN_printf(taint, arg...) CONCATENATE(__WARN_printf_, WARN_ARGS(arg))(taint, arg)

This needs docs too. I think this is collapsing 1 and 2 argument WARNs
into the ud1, and anything larger is explicitly calling __warn_printk +
__WARN_FLAGS? If only 1 and 2 args can be collapsed, why reserve 0xfe00
through 0xfeff? I feel like I'm missing something here...

> +
>  #include <asm-generic/bug.h>
>  
>  #endif /* _ASM_X86_BUG_H */
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 94c0236963c6..b7f69f4addf4 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -81,18 +81,6 @@
>  
>  DECLARE_BITMAP(system_vectors, NR_VECTORS);
>  
> -__always_inline int is_valid_bugaddr(unsigned long addr)
> -{
> -	if (addr < TASK_SIZE_MAX)
> -		return 0;
> -
> -	/*
> -	 * We got #UD, if the text isn't readable we'd have gotten
> -	 * a different exception.
> -	 */
> -	return *(unsigned short *)addr == INSN_UD2;
> -}
> -
>  /*
>   * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
>   * If it's a UD1, further decode to determine its use:
> @@ -102,25 +90,37 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
>   * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
>   * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
>   * static_call:  0f b9 cc                ud1    %esp,%ecx
> + * WARN_printf:                          ud1    %reg,%reg
>   *
> - * Notably UBSAN uses EAX, static_call uses ECX.
> + * Notably UBSAN uses (%eax), static_call uses %esp,%ecx
>   */
>  __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
>  {
>  	unsigned long start = addr;
> +	u8 v, rex = 0, reg, rm;
>  	bool lock = false;
> -	u8 v;
> +	int type = BUG_UD1;
>  
>  	if (addr < TASK_SIZE_MAX)
>  		return BUG_NONE;
>  
> -	v = *(u8 *)(addr++);
> -	if (v == INSN_ASOP)
> +	for (;;) {
>  		v = *(u8 *)(addr++);
>  
> -	if (v == INSN_LOCK) {
> -		lock = true;
> -		v = *(u8 *)(addr++);
> +		if (v == INSN_ASOP)
> +			continue;
> +
> +		if (v == INSN_LOCK) {
> +			lock = true;
> +			continue;
> +		}
> +
> +		if ((v & 0xf0) == 0x40) {
> +			rex = v;
> +			continue;
> +		}
> +
> +		break;
>  	}
>  
>  	switch (v) {
> @@ -156,9 +156,13 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
>  	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
>  		addr++;			/* SIB */
>  
> +	reg = X86_MODRM_REG(v) + 8*!!X86_REX_R(rex);
> +	rm  = X86_MODRM_RM(v)  + 8*!!X86_REX_B(rex);
> +
>  	/* Decode immediate, if present */
>  	switch (X86_MODRM_MOD(v)) {
> -	case 0: if (X86_MODRM_RM(v) == 5)
> +	case 0: *imm = 0;
> +		if (X86_MODRM_RM(v) == 5)
>  			addr += 4; /* RIP + disp32 */
>  		break;
>  
> @@ -170,18 +174,37 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
>  		addr += 4;
>  		break;
>  
> -	case 3: break;
> +	case 3: if (rm != 4) /* %esp */
> +			type = BUG_WARN | (rm << 4) | reg;
> +		break;
>  	}
>  
>  	/* record instruction length */
>  	*len = addr - start;
>  
> -	if (X86_MODRM_REG(v) == 0)	/* EAX */
> +	if (!rm && X86_MODRM_MOD(v) != 3)	/* (%eax) */
>  		return BUG_UD1_UBSAN;
>  
> -	return BUG_UD1;
> +	return type;
>  }
>  
> +int is_valid_bugaddr(unsigned long addr)
> +{
> +	int ud_type, ud_len;
> +	u32 ud_imm;
> +
> +	if (addr < TASK_SIZE_MAX)
> +		return 0;
> +
> +	/*
> +	 * We got #UD, if the text isn't readable we'd have gotten
> +	 * a different exception.
> +	 */
> +	ud_type = decode_bug(addr, &ud_imm, &ud_len);
> +
> +	return ud_type == BUG_UD2 ||
> +		(ud_type >= BUG_WARN && ud_type <= BUG_WARN_END);
> +}
>  
>  static nokprobe_inline int
>  do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
> @@ -305,6 +328,14 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>  		      ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>  
> +static inline unsigned long pt_regs_val(struct pt_regs *regs, int nr)
> +{
> +	int offset = pt_regs_offset(regs, nr);
> +	if (WARN_ON_ONCE(offset < -0))
> +		return 0;
> +	return *((unsigned long *)((void *)regs + offset));
> +}
> +
>  static noinstr bool handle_bug(struct pt_regs *regs)
>  {
>  	unsigned long addr = regs->ip;
> @@ -334,6 +365,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
>  		raw_local_irq_enable();
>  
>  	switch (ud_type) {
> +	case BUG_WARN ... BUG_WARN_END:
> +		int ud_reg = ud_type & 0xf;
> +		int ud_rm  = (ud_type >> 4) & 0xf;
> +
> +		__warn_printk((const char *)(pt_regs_val(regs, ud_rm)),
> +			      pt_regs_val(regs, ud_reg));
> +		fallthrough;

Yay, internal printk. :):)

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 62b3416f5e43..564513f605ac 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -8703,6 +8703,8 @@ void __init sched_init(void)
>  	preempt_dynamic_init();
>  
>  	scheduler_running = 1;
> +
> +	WARN(true, "Ultimate answer: %d\n", 42);
>  }
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP

If any code would emit The Answer, it would be the scheduler. :)

-- 
Kees Cook

