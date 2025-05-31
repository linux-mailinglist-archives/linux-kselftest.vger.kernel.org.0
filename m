Return-Path: <linux-kselftest+bounces-34106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71ACCAC9A86
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 12:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2968A4A37B6
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD4238C25;
	Sat, 31 May 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMd38nGz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE4741760;
	Sat, 31 May 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748687021; cv=none; b=U02L6G7IjbO0y2N8G40CD9yk4/l56s6eJzlwAgvx9GT0lfWtHrfOnKSauCBzXhArmHiMFM9BmONKRetDDk5wZoL04UBVrggRX+lQdhGd/V0rq8fx+qMcpJH6hdzas+35oA9jeezzjrHy0w6rZXWTqxdEwjPPD4E0iHaUDl4lg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748687021; c=relaxed/simple;
	bh=2AUZl1dxP5gms+0vwRI99b6G9DX6qOkXRh+TDthf3bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msWHxloaghBrpelm4E73hm9NMyfToRqFeMis9C4wR/9R9tq5VsWl+t+i8RXQJNZdqn9VULMIv7GQIRJ3ZQXR3b1KTiniQ0NNHTQEaMD2izNHkbaT0n0m9L7i2TKqFdDbTwNHfRFJYuVbAXPSnWmCK0t+XImXpgOA/SofXOrGPvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IMd38nGz; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zwMGUk+AbsVsmvDS23RbOZVDKaCTtLFw2JW5GjAg6Y0=; b=IMd38nGzOi3FLNYNHSNJy6Jh/N
	mL8dl83XmHIVmx7sbnFLqcU4D6q67zjCSi/DNf8gjMV1sezz7HmywRNjr5QNf1cNHWK+JB9+Vf1xB
	oyqMP3JW0wF6FdeeNQ9UEv13TuqpJdptncl/hxgX9Uqx+hFXCMwjYM60hxmncHuMq7ZA7hL5xvumr
	oIa+FyPwUoJjjCmaCCfv+pBkJGCG7WDgqtCkFsiCsjf5BWZRzbZfCpqaQc13506mnPUOba9zXNy3p
	JOe6+lRfhbXXE/3bcQK9d2rmTe25U7BOKjQLIK1H/KMjxWOVIjPB+u1LxVZjmkXh8oNCJ++HKa1VL
	NIQ1e+9g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLJMo-00000000LgD-0ufz;
	Sat, 31 May 2025 10:23:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 11B18300787; Sat, 31 May 2025 12:23:05 +0200 (CEST)
Date: Sat, 31 May 2025 12:23:04 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Kees Cook <kees@kernel.org>
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
Message-ID: <20250531102304.GF21197@noisy.programming.kicks-ass.net>
References: <20250526132755.166150-1-acarmina@redhat.com>
 <20250526132755.166150-2-acarmina@redhat.com>
 <20250529090129.GZ24938@noisy.programming.kicks-ass.net>
 <CAGegRW76X8Fk_5qqOBw_aqBwAkQTsc8kXKHEuu9ECeXzdJwMSw@mail.gmail.com>
 <20250530140140.GE21197@noisy.programming.kicks-ass.net>
 <202505301037.D816A49@keescook>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505301037.D816A49@keescook>

On Fri, May 30, 2025 at 10:48:47AM -0700, Kees Cook wrote:
> On Fri, May 30, 2025 at 04:01:40PM +0200, Peter Zijlstra wrote:
> > I'm not really concerned with performance here, but more with the size
> > of the code emitted by WARN_ONCE(). There are a *ton* of WARN sites,
> > while only one report_bug() and printk().
> > 
> > The really offensive thing is that this is for a feature most nobody
> > will ever need :/
> 
> Well, it won't be enabled often -- this reminds me of ftrace: it needs
> to work, but it'll be off most of the time.

Well, ftrace is useful, but when would I *ever* care about this stuff? I
can't operate kunit, don't give a crap about kunit, and if I were to
magically run it, I would be more than capable of ignoring WARNs.


> I like the patch! Can you add a _little_ documentation, though? e.g.
> explaining that BUG_WARN ... BUG_WARN_END is for format string args,
> etc.

Cleaned it up a little bit... I'll add some comments on later :-)

I also need to go fix WARN_ONCE(), at least for the n<=2 cases that can
use BUGFLAG_ONCE now.

---
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f0e9acf72547..3aecedf46d0c 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -5,6 +5,7 @@
 #include <linux/stringify.h>
 #include <linux/instrumentation.h>
 #include <linux/objtool.h>
+#include <linux/args.h>
 
 /*
  * Despite that some emulators terminate on UD2, we use it for WARN().
@@ -26,52 +27,52 @@
 #define BUG_UD2			0xfffe
 #define BUG_UD1			0xfffd
 #define BUG_UD1_UBSAN		0xfffc
+#define BUG_UD1_WARN		0xfffb
 #define BUG_EA			0xffea
 #define BUG_LOCK		0xfff0
 
 #ifdef CONFIG_GENERIC_BUG
 
+#define BUG_HAS_FORMAT
+
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
+#define ASM_BUGTABLE_FORMAT(format)					\
+	ASM_BUG_REL(format)
 
-#else /* !CONFIG_DEBUG_BUGVERBOSE */
+#define ASM_BUGTABLE_FLAGS(at, format, file, line, flags)		\
+	.pushsection __bug_table, "aw" ;				\
+	123:	ASM_BUG_REL(at) ;					\
+	ASM_BUGTABLE_FORMAT(format) ;					\
+	ASM_BUGTABLE_VERBOSE(file, line) ;				\
+	.word	flags ;							\
+	.org 123b + 6 + 4 + ASM_BUGTABLE_VERBOSE_SIZE ;			\
+	.popsection
 
 #define _BUG_FLAGS(ins, flags, extra)					\
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
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c[fmt], %c[file], %c[line], %c[fl])) "\n"	\
+			    extra					\
+		     : : [fmt] "i" (NULL), [file] "i" (__FILE__),	\
+			 [line] "i" (__LINE__),				\
+			 [fl] "i" (flags));				\
 } while (0)
 
-#endif /* CONFIG_DEBUG_BUGVERBOSE */
-
 #else
 
 #define _BUG_FLAGS(ins, flags, extra)  asm volatile(ins)
@@ -100,6 +101,62 @@ do {								\
 	instrumentation_end();					\
 } while (0)
 
+#ifndef __ASSEMBLER__
+struct pt_regs;
+extern void __warn_printf(const char *fmt, struct pt_regs *regs);
+#define __warn_printf __warn_printf
+#endif
+
+#define __WARN_printf_0(taint, format)					\
+do {									\
+	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_FORMAT | BUGFLAG_TAINT(taint); \
+	instrumentation_begin();					\
+	asm_inline volatile("1: ud2\n"					\
+			    ANNOTATE_REACHABLE(1b)			\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c[fmt], %c[file], %c[line], %c[fl])) "\n" \
+		     : : [file] "i" (__FILE__), [line] "i" (__LINE__),	\
+			 [fl] "i" (__flags), [fmt] "i" (format));	\
+	instrumentation_end();						\
+} while (0)
+
+#define __WARN_printf_1(taint, format, arg1)				\
+do {									\
+	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_FORMAT | BUGFLAG_TAINT(taint); \
+	instrumentation_begin();					\
+	asm_inline volatile("1: ud1 (%%rcx), %[a1]\n"			\
+			    ANNOTATE_REACHABLE(1b)			\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c[fmt], %c[file], %c[line], %c[fl])) "\n" \
+		     : : [file] "i" (__FILE__), [line] "i" (__LINE__),	\
+			 [fl] "i" (__flags), [fmt] "i" (format),	\
+			 [a1] "r" ((unsigned long)(arg1)));		\
+	instrumentation_end();						\
+} while (0)
+
+#define __WARN_printf_2(taint, format, arg1, arg2)			\
+do {									\
+	__auto_type __flags = BUGFLAG_WARNING | BUGFLAG_FORMAT | BUGFLAG_TAINT(taint); \
+	instrumentation_begin();					\
+	asm_inline volatile("1: ud1 %[a2], %[a1]\n"			\
+			    ANNOTATE_REACHABLE(1b)			\
+	    __stringify(ASM_BUGTABLE_FLAGS(1b, %c[fmt], %c[file], %c[line], %c[fl])) "\n" \
+		     : : [file] "i" (__FILE__), [line] "i" (__LINE__),	\
+			 [fl] "i" (__flags), [fmt] "i" (format),	\
+			 [a1] "r" ((unsigned long)(arg1)),		\
+			 [a2] "r" ((unsigned long)(arg2)));		\
+	instrumentation_end();						\
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
+#define __WARN_printf(taint, fmt, arg...) CONCATENATE(__WARN_printf_, WARN_ARGS(arg))(taint, fmt, ## arg)
+
 #include <asm-generic/bug.h>
 
 #endif /* _ASM_X86_BUG_H */
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 94c0236963c6..bb9193fd3d2d 100644
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
@@ -103,24 +91,39 @@ __always_inline int is_valid_bugaddr(unsigned long addr)
  * UBSan{10}:    67 0f b9 40 10          ud1    0x10(%eax),%eax
  * static_call:  0f b9 cc                ud1    %esp,%ecx
  *
- * Notably UBSAN uses EAX, static_call uses ECX.
+ * WARN_printf_0:                        ud2
+ * WARN_printf_1:                        ud1    (%ecx),%reg
+ * WARN_printf_2:                        ud1    %reg,%reg
+ *
+ * Notably UBSAN uses (%eax), static_call does not get a bug_entry.
  */
-__always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
+__always_inline int decode_bug(unsigned long addr, u32 *regs, s32 *imm, int *len)
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
@@ -141,6 +144,9 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 		return BUG_NONE;
 	}
 
+	*regs = 0;
+	*imm = 0;
+
 	v = *(u8 *)(addr++);
 	if (v == SECOND_BYTE_OPCODE_UD2) {
 		*len = addr - start;
@@ -150,16 +156,22 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 	if (v != SECOND_BYTE_OPCODE_UD1)
 		return BUG_NONE;
 
-	*imm = 0;
 	v = *(u8 *)(addr++);		/* ModRM */
-
 	if (X86_MODRM_MOD(v) != 3 && X86_MODRM_RM(v) == 4)
 		addr++;			/* SIB */
 
+	reg = X86_MODRM_REG(v) + 8*!!X86_REX_R(rex);
+	rm  = X86_MODRM_RM(v)  + 8*!!X86_REX_B(rex);
+	*regs = (rm << 4) | reg;
+
 	/* Decode immediate, if present */
 	switch (X86_MODRM_MOD(v)) {
 	case 0: if (X86_MODRM_RM(v) == 5)
-			addr += 4; /* RIP + disp32 */
+			addr += 4;	/* RIP + disp32 */
+		if (rm == 1) {		/* CX */
+			type = BUG_UD1_WARN;
+			*regs |= 0x100;
+		}
 		break;
 
 	case 1: *imm = *(s8 *)addr;
@@ -170,18 +182,37 @@ __always_inline int decode_bug(unsigned long addr, s32 *imm, int *len)
 		addr += 4;
 		break;
 
-	case 3: break;
+	case 3: type = BUG_UD1_WARN;
+		*regs |= 0x300;
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
+	u32 ud_regs;
+	s32 ud_imm;
+
+	if (addr < TASK_SIZE_MAX)
+		return 0;
+
+	/*
+	 * We got #UD, if the text isn't readable we'd have gotten
+	 * a different exception.
+	 */
+	ud_type = decode_bug(addr, &ud_regs, &ud_imm, &ud_len);
+
+	return ud_type == BUG_UD2 || ud_type == BUG_UD1_WARN;
+}
 
 static nokprobe_inline int
 do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
@@ -305,14 +336,42 @@ static inline void handle_invalid_op(struct pt_regs *regs)
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
+void __warn_printf(const char *fmt, struct pt_regs *regs)
+{
+	u32 r = regs->orig_ax;
+	unsigned long a1 = pt_regs_val(regs, (r >> 0) & 0xf);
+	unsigned long a2 = pt_regs_val(regs, (r >> 4) & 0xf);
+
+	switch ((r >> 8) & 0x3) {
+	case 0:
+		printk(fmt);
+		return;
+	case 1:
+		printk(fmt, a1);
+		return;
+	case 3:
+		printk(fmt, a1, a2);
+		return;
+	}
+}
+
 static noinstr bool handle_bug(struct pt_regs *regs)
 {
 	unsigned long addr = regs->ip;
 	bool handled = false;
 	int ud_type, ud_len;
+	u32 ud_regs;
 	s32 ud_imm;
 
-	ud_type = decode_bug(addr, &ud_imm, &ud_len);
+	ud_type = decode_bug(addr, &ud_regs, &ud_imm, &ud_len);
 	if (ud_type == BUG_NONE)
 		return handled;
 
@@ -334,7 +393,9 @@ static noinstr bool handle_bug(struct pt_regs *regs)
 		raw_local_irq_enable();
 
 	switch (ud_type) {
+	case BUG_UD1_WARN:
 	case BUG_UD2:
+		regs->orig_ax = ud_regs;
 		if (report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
 			handled = true;
 			break;
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..b8336259f81d 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -13,6 +13,7 @@
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
 #define BUGFLAG_NO_CUT_HERE	(1 << 3)	/* CUT_HERE already sent */
+#define BUGFLAG_FORMAT		(1 << 4)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
@@ -36,6 +37,13 @@ struct bug_entry {
 #else
 	signed int	bug_addr_disp;
 #endif
+#ifdef BUG_HAS_FORMAT
+#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	const char	*format;
+#else
+	signed int	format_disp;
+#endif
+#endif
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 	const char	*file;
@@ -101,12 +109,16 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
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
@@ -114,6 +126,7 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
+
 #endif
 
 /* used internally by panic.c */
@@ -148,8 +161,10 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 	DO_ONCE_LITE_IF(condition, WARN_ON, 1)
 #endif
 
+#ifndef WARN_ONCE
 #define WARN_ONCE(condition, format...)				\
 	DO_ONCE_LITE_IF(condition, WARN, 1, format)
+#endif
 
 #define WARN_TAINT_ONCE(condition, taint, format...)		\
 	DO_ONCE_LITE_IF(condition, WARN_TAINT, 1, taint, format)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 62b3416f5e43..4f7bc0e500ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8703,6 +8703,10 @@ void __init sched_init(void)
 	preempt_dynamic_init();
 
 	scheduler_running = 1;
+
+	WARN(true, "Ultimate answer: %d\n", 42);
+	WARN(true, "XXX2 %d %d\n", 43, 44);
+	WARN(true, "XXX3 %d %d %d\n", 45, 46, 47);
 }
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
diff --git a/lib/bug.c b/lib/bug.c
index b1f07459c2ee..085889e9c096 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -139,6 +139,17 @@ void bug_get_file_line(struct bug_entry *bug, const char **file,
 #endif
 }
 
+static const char *bug_get_format(struct bug_entry *bug)
+{
+	const char *format = NULL;
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	format = (const char *)&bug->format_disp + bug->format_disp;
+#else
+	format = bug->format;
+#endif
+	return format;
+}
+
 struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	struct bug_entry *bug;
@@ -150,6 +161,14 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
 
+#ifndef __warn_printf
+static void __warn_printf(const char *fmt, struct pt_regs *regs)
+{
+	printk(fmt);
+}
+#define __warn_printf __warn_printf
+#endif
+
 static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	struct bug_entry *bug;
@@ -190,6 +209,9 @@ static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *re
 	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
 		printk(KERN_DEFAULT CUT_HERE);
 
+	if (bug->flags & BUGFLAG_FORMAT)
+		__warn_printf(bug_get_format(bug), regs);
+
 	if (warning) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */
 		__warn(file, line, (void *)bugaddr, BUG_GET_TAINT(bug), regs,

