Return-Path: <linux-kselftest+bounces-34061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB05AC90F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 16:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7F7D1C04BB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49E223705;
	Fri, 30 May 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AgBaHGyI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31111C683;
	Fri, 30 May 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613755; cv=none; b=nAWmTyoBiF+uj07UDPSs+cHwJ2XIg19tK0EdqWBimOmXUVYPeORssjPbdGAGLyIp4w5stLJfCpOj1GWkRWxj8NeckeyFWlxKJzF9WLLGp//Xx5NzwYg0GPmKp7IjOjvYEcCugqQ/Yas8Hvn1XV4NRH08BmBOqGSvbzyjp9qLd0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613755; c=relaxed/simple;
	bh=Fum/TRVThwGX58ougliYEQ3GV8bxa2jyVjaMx/4Cojw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+svjirWfRqAQKkixJCO339KCe2dxaQcCWQVCPk74uwLt4qieE1kJ+L03FXewSg7Khl3Qfd7yajQ6U64pVsgDwITiWZsLk+8Ffe87kwQFmJFTW00sFgoqdcWbpBDpP/tszMy7nakatJ4MDKi3uDfEKJ/Sm4h0B2QGEpzMpr0aZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AgBaHGyI; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=ciHFY0VgOd5QIMYfzEsxxrFpF1H8WdgMxl2q6NzkMcQ=; b=AgBaHGyIlmAW/v8GWs/OGq2Eqr
	yZFFmsHTkVFvnufBUGKi5lrsKHweHy7rsvU7AKLJJOUM2Wg3rh7CwDrS4pQQ+0L2q/kiYFT8DfHPI
	45gYqEujDh3vsR6tqOsHUlXGnogpqFP8bIqYnafqB2aEaKpJc2ZV9o/bqEPLcvfZuWBDL81whZQqu
	UDs9DW8dVQlVwKH+SAeebNs9B/1Sqp+odrGrqg4Xkd5XejCWqUABqkRqxQLUNt0q5PG7wGACXd1u8
	ttUskYnu6/kJo7+A2bn3W6lfZzW0kh0s/wBq2XsNUNmbXRFQQTn4wHva/qQChsPNHZbIFH0oeeOSE
	TzyIMu2Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uL0Is-00000000Fcx-41gu;
	Fri, 30 May 2025 14:01:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8E1F330066A; Fri, 30 May 2025 16:01:40 +0200 (CEST)
Date: Fri, 30 May 2025 16:01:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: linux-kselftest@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Kees Cook <keescook@chromium.org>,
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
Message-ID: <20250530140140.GE21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>


+Mark because he loves a hack :-)

On Thu, May 29, 2025 at 12:36:55PM +0200, Alessandro Carminati wrote:

> > Like I said before; you need to do this on the report_bug() size of
> > things.
> >
> I fully understand your concerns, and I truly appreciate both yours
> and Josh’s feedback on this matter.
> Please rest assured that I took your suggestions seriously and
> carefully evaluated the possibility of consolidating all related logic
> within the exception handler.
> After a thorough investigation, however, I encountered several
> limitations that led me to maintain the check in the macro.
> I’d like to share the rationale behind this decision:

> * In the case of WARN() messages, part of the output, the
> user-specified content, is emitted directly by the macro, prior to
> reaching the exception handler [1].
>   Moving the check solely to the exception handler would not prevent
> this early output.

Yeah, this has been really annoying me for a long while. WARN() code gen
is often horrible crap because of that.

Everything I've tried so far is worse though :/ So in the end I try to
never use WARN(), its just not worth it.

... /me goes down the rabbit-hole again, because well, you can't let
something simple like this defeat you ;-)

Results of today's hackery below. It might actually be worth cleaning
up.

> * Unless we change the user-facing interface that allows suppression
> based on function names, we still need to work with those names at
> runtime.

I'm not sure I understand this. What interface and what names? This is a
new feature, so how can there be an interface that needs to be
preserved?

> * This leaves us with two main strategies: converting function names
> to pointers (e.g., via kallsyms) or continuing to work with names.
>   The former requires name resolution at suppression time and pointer
> comparison in the handler, but function names are often altered by the
> compiler due to inlining or other optimizations[2].
>   Some WARN() sites are even marked __always_inline[3], making it
> difficult to prevent inlining altogether.

Arguably __func__ should be the function name of the function you get
inlined into. C inlining does not preserve the sequence point, so there
is absolutely no point in trying to preserve the inline name.

I'm again confused though; [2] does not use __func__ at all.

Anyway, when I do something like:

void __attribute__((__always_inline__)) foo(void)
{
	puts(__func__);
}

void bar(void)
{
	foo();
}

it uses a "foo" string, which IMO is just plain wrong. Anyway, do both
compilers guarantee it will always be foo? I don't think I've seen the
GCC manual be explicit about this case.

> * An alternative is to embed function names in the __bug_table.
>   While potentially workable, this increases the size of the table and
> requires attention to handle position-independent builds
> (-fPIC/-fPIE), such as using offsets relative to __start_rodata.
> 
> However, the central challenge remains: any logic that aims to
> suppress WARN() output must either move the entire message emission
> into the exception handler or accept that user-specified parts of the
> message will still be printed.

Well, we can set suppress_printk and then all is quiet :-) Why isn't
this good enough?

> As a secondary point, there are also less common architectures where
> it's unclear whether suppressing these warnings is a priority, which
> might influence how broadly the effort is applied.
> I hoped to have addressed the concern of having faster runtime, by
> exposing a counter that could skip the logic.
> Kess suggested using static branching that would make things even better.
> Could Kess' suggestion mitigate your concern on this strategy?
> I’m absolutely open to any further thoughts or suggestions you may
> have, and I appreciate your continued guidance.

I'm not really concerned with performance here, but more with the size
of the code emitted by WARN_ONCE(). There are a *ton* of WARN sites,
while only one report_bug() and printk().

The really offensive thing is that this is for a feature most nobody
will ever need :/



The below results in:

03dc  7ac:      48 c7 c0 00 00 00 00    mov    $0x0,%rax        7af: R_X86_64_32S       .rodata.str1.1+0x223
03e3  7b3:      ba 2a 00 00 00          mov    $0x2a,%edx
03e8  7b8:      48 0f b9 d0             ud1    %rax,%rdx

And it even works :-)

Hmm... I should try and stick the format string into the __bug_table,
its const after all. Then I can get 2 arguments covered.

---
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f0e9acf72547..88b305d49f35 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,6 +5,7 @@
 #include <linux/stringify.h>
 #include <linux/instrumentation.h>
 #include <linux/objtool.h>
+#include <linux/args.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
@@ -28,50 +29,44 @@
 #define BUG_UD1_UBSAN		0xfffc
 #define BUG_EA			0xffea
 #define BUG_LOCK		0xfff0
+#define BUG_WARN		0xfe00
+#define BUG_WARN_END		0xfeff
 
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " __stringify(val)
+#define ASM_BUG_REL(val)	.long val
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - ."
+#define ASM_BUG_REL(val)	.long val - .
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
+#define ASM_BUGTABLE_VERBOSE(file, line)				\
+	ASM_BUG_REL(file) ;						\
+	.word line
+#define ASM_BUGTABLE_VERBOSE_SIZE	6
+#else
+#define ASM_BUGTABLE_VERBOSE(file, line)
+#define ASM_BUGTABLE_VERBOSE_SIZE	0
+#endif
 
-#define _BUG_FLAGS(ins, flags, extra)					\
-do {									\
-	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t"  __BUG_REL(%c0) "\t# bug_entry::file\n"	\
-		     "\t.word %c1"        "\t# bug_entry::line\n"	\
-		     "\t.word %c2"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c3\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (__FILE__), "i" (__LINE__),		\
-			 "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
-} while (0)
-
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
+#define ASM_BUGTABLE_FLAGS(at, file, line, flags)			\
+	.pushsection __bug_table, "aw" ;				\
+	123:	ASM_BUG_REL(at) ;					\
+	ASM_BUGTABLE_VERBOSE(file, line) ;				\
+	.word	flags ;							\
+	.org 123b + 6 + ASM_BUGTABLE_VERBOSE_SIZE ;			\
+	.popsection
 
-#define _BUG_FLAGS(ins, flags, extra)					\
+#define _BUG_FLAGS(ins, flags, extra, extra_args...)			\
 do {									\
 	asm_inline volatile("1:\t" ins "\n"				\
-		     ".pushsection __bug_table,\"aw\"\n"		\
-		     "2:\t" __BUG_REL(1b) "\t# bug_entry::bug_addr\n"	\
-		     "\t.word %c0"        "\t# bug_entry::flags\n"	\
-		     "\t.org 2b+%c1\n"					\
-		     ".popsection\n"					\
-		     extra						\
-		     : : "i" (flags),					\
-			 "i" (sizeof(struct bug_entry)));		\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
+			    extra					\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (flags), ## extra_args);			\
 } while (0)
 
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
 #else
 
 #define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
@@ -100,6 +95,40 @@ do {								\
 	instrumentation_end();					\
 } while (0)
 
+#define __WARN_printf_1(taint, format)				\
+do { \
+	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint); \
+	unsigned long dummy = 0; \
+	instrumentation_begin(); \
+	asm_inline volatile("1: ud1 %[fmt], %[arg]\n"			\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (__flags), [fmt] "r" (format), [arg] "r" (dummy));		\
+	instrumentation_end(); \
+} while (0)
+
+#define __WARN_printf_2(taint, format, _arg)				\
+do { \
+	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint); \
+	instrumentation_begin(); \
+	asm_inline volatile("1: ud1 %[fmt], %[arg]\n"			\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c0, %c1, %c2)) "\n"	\
+		     : : "i" (__FILE__), "i" (__LINE__),		\
+			 "i" (__flags), [fmt] "r" (format), [arg] "r" ((unsigned long)(_arg)));		\
+	instrumentation_end(); \
+} while (0)
+
+#define __WARN_printf_n(taint, fmt, arg...) do {			\
+		instrumentation_begin();				\
+		__warn_printk(fmt, arg);				\
+		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		instrumentation_end();					\
+	} while (0)
+
+#define WARN_ARGS(X...) __COUNT_ARGS(, ##X, n, n, n, n, n, n, n, n, n, n, n, n, n, 2, 1, 0)
+
+#define __WARN_printf(taint, arg...) CONCATENATE(__WARN_printf_, WARN_ARGS(arg))(taint, arg)
+
 #include <asm-generic/bug.h>
 
 #endif /* _ASM_X86_BUG_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 94c0236963c6..b7f69f4addf4 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -81,18 +81,6 @@
 
 DECLARE_BITMAP(system_vectors, NR_VECTORS);
 
-__always_inline int is_valid_bugaddr(unsigned long addr)
-{
-	if (addr < TASK_SIZE_MAX)
-		return 0;
-
-	/*
-	 * We got #UD, if the text isn't readable we'd have gotten
-	 * a different exception.
-	 */
-	return *(unsigned short *)addr == INSN_UD2;
-}
-
 /*
  * Check for UD1 or UD2, accounting for Address Size Override Prefixes.
  * If it's a UD1, further decode to determine its use:
@@ -102,25 +90,37 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
  * UBSan{0}:     67 0f b9 00             ud1    (%eax),%eax
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
+ * WARN_printf:                          ud1    %reg,%reg
  *
- * Notably UBSAN uses EAX, static_call uses ECX.
+ * Notably UBSAN uses (%eax), static_call uses %esp,%ecx
  */
 __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 {
 	unsigned long start = addr;
+	u8 v, rex = 0, reg, rm;
 	bool lock = false;
-	u8 v;
+	int type = BUG_UD1;
 
 	if (addr < TASK_SIZE_MAX)
 		return BUG_NONE;
 
-	v = *(u8 *)(addr++);
-	if (v == INSN_ASOP)
+	for (;;) {
 		v = *(u8 *)(addr++);
 
-	if (v == INSN_LOCK) {
-		lock = true;
-		v = *(u8 *)(addr++);
+		if (v == INSN_ASOP)
+			continue;
+
+		if (v == INSN_LOCK) {
+			lock = true;
+			continue;
+		}
+
+		if ((v & 0xf0) == 0x40) {
+			rex = v;
+			continue;
+		}
+
+		break;
 	}
 
 	switch (v) {
@@ -156,9 +156,13 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
 		addr++;			/* SIB */
 
+	reg = X86_MODRM_REG(v) + 8*!!X86_REX_R(rex);
+	rm  = X86_MODRM_RM(v)  + 8*!!X86_REX_B(rex);
+
 	/* Decode immediate, if present */
 	switch (X86_MODRM_MOD(v)) {
-	case 0: if (X86_MODRM_RM(v) == 5)
+	case 0: *imm = 0;
+		if (X86_MODRM_RM(v) == 5)
 			addr += 4; /* RIP + disp32 */
 		break;
 
@@ -170,18 +174,37 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 		addr += 4;
 		break;
 
-	case 3: break;
+	case 3: if (rm != 4) /* %esp */
+			type = BUG_WARN | (rm << 4) | reg;
+		break;
 	}
 
 	/* record instruction length */
 	*len = addr - start;
 
-	if (X86_MODRM_REG(v) == 0)	/* EAX */
+	if (!rm && X86_MODRM_MOD(v) != 3)	/* (%eax) */
 		return BUG_UD1_UBSAN;
 
-	return BUG_UD1;
+	return type;
 }
 
+int is_valid_bugaddr(unsigned long addr)
+{
+	int ud_type, ud_len;
+	u32 ud_imm;
+
+	if (addr < TASK_SIZE_MAX)
+		return 0;
+
+	/*
+	 * We got #UD, if the text isn't readable we'd have gotten
+	 * a different exception.
+	 */
+	ud_type = decode_bug(addr, &ud_imm, &ud_len);
+
+	return ud_type == BUG_UD2 ||
+		(ud_type >= BUG_WARN && ud_type <= BUG_WARN_END);
+}
 
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
@@ -305,6 +328,14 @@ static inline void handle_invalid_op(struct pt_regs *regs)
 		      ILL_ILLOPN, error_get_trap_addr(regs));
 }
 
+static inline unsigned long pt_regs_val(struct pt_regs *regs, int nr)
+{
+	int offset = pt_regs_offset(regs, nr);
+	if (WARN_ON_ONCE(offset < -0))
+		return 0;
+	return *((unsigned long *)((void *)regs + offset));
+}
+
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	unsigned long addr = regs->ip;
@@ -334,6 +365,14 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		raw_local_irq_enable();
 
 	switch (ud_type) {
+	case BUG_WARN ... BUG_WARN_END:
+		int ud_reg = ud_type & 0xf;
+		int ud_rm  = (ud_type >> 4) & 0xf;
+
+		__warn_printk((const char *)(pt_regs_val(regs, ud_rm)),
+			      pt_regs_val(regs, ud_reg));
+		fallthrough;
+
 	case BUG_UD2:
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..a5960c92d70a 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -101,12 +101,16 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 	} while (0)
 #else
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
+
+#ifndef __WARN_printf
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
 		__warn_printk(arg);					\
 		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 		instrumentation_end();					\
 	} while (0)
+#endif
+
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 62b3416f5e43..564513f605ac 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8703,6 +8703,8 @@ void __init sched_init(void)
 	preempt_dynamic_init();
 
 	scheduler_running = 1;
+
+	WARN(true, "Ultimate answer: %d\n", 42);
 }
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP

