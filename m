Return-Path: <linux-kselftest+bounces-23776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD4A9FD152
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 08:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C613188308A
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Dec 2024 07:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208E514B06A;
	Fri, 27 Dec 2024 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlHZ25qy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00781474CF;
	Fri, 27 Dec 2024 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735284598; cv=none; b=r9GaTFZUsCw3ULemTBr/mPq/mIf1epb2eiJcTj/aONXxbY+b4ypsb5uPaKEH6wuhMwBvrXDviUf0jsjuKJA8zke/G2uH/cKaHTdZkm/Uyi6BVQ4xKCVTRph/SVvROfKyDv4/N+WTrOyM+zXey8iXGl9bhM2kUb1VZfMTGFVgQgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735284598; c=relaxed/simple;
	bh=5WcbMLleT0o3eKZQNgsMEVrIOTvbPCyMPrwQ3+fNd90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0zxIyaekDT6FecPYEMLRMQe0/Gv7KWGRiDVF08aVmSoIQd4c/y48BWujF+HVjkXEzKTrtj6m7TQbrRKtq+eSjIQt+oNSokVu9azRxtwFLigLtVcYjLlgAm3Ng663fcMFAG5x+2aPVNCc8dveah+m4FF44WMCJsW/efwsW+0dVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlHZ25qy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C23AC4CED0;
	Fri, 27 Dec 2024 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735284597;
	bh=5WcbMLleT0o3eKZQNgsMEVrIOTvbPCyMPrwQ3+fNd90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jlHZ25qygTt2Ury+pMoPvV9Zb4oYhrjJ1pPQEZOmimuBXD2abMRyso+nUxYobpNXE
	 7IZ+RpDwLXV373hHtGSUHhafE5yyIZHU6AXF2ugv8SuxdeXc05KlarEYcclHxwsLgy
	 5A6mLy74SK1LE9Z9/DVwj9MlNxf1L6vuYFvd+v3q6dEosXPPY3xbIFi7b2XZYw87v8
	 HXggWgrf7JMrndHd1XWZIagsSMrCbwXyeBlAYfSa04XnkV36FWqvmctblC7mKkyN0S
	 DMmszSaB9IjjzP+B/X9Kd16zVeqUpFyFjjd5RM0dCTb3JiHDOF1Kbir97dYE06jenS
	 2UbAijkL5QYTw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Daniel Gomez <da.gomez@samsung.com>,
	Daniel Thompson <danielt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Gow <davidgow@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jason Wessel <jason.wessel@windriver.com>,
	Jiri Kosina <jikos@kernel.org>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Miroslav Benes <mbenes@suse.cz>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Rae Moar <rmoar@google.com>,
	Richard Weinberger <richard@nod.at>,
	Sami Tolvanen <samitolvanen@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kgdb-bugreport@lists.sourceforge.net,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	live-patching@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 7/8] Revert "x86/module: prepare module loading for ROX allocations of text"
Date: Fri, 27 Dec 2024 09:28:24 +0200
Message-ID: <20241227072825.1288491-8-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241227072825.1288491-1-rppt@kernel.org>
References: <20241227072825.1288491-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

The module code does not create a writable copy of the executable memory
anymore so there is no need to handle it in module relocation and
alternatives patching.

This reverts commit 9bfc4824fd4836c16bb44f922bfaffba5da3e4f3.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/um/kernel/um_arch.c           |  11 +-
 arch/x86/entry/vdso/vma.c          |   3 +-
 arch/x86/include/asm/alternative.h |  14 +--
 arch/x86/kernel/alternative.c      | 181 ++++++++++++-----------------
 arch/x86/kernel/ftrace.c           |  30 +++--
 arch/x86/kernel/module.c           |  45 +++----
 6 files changed, 117 insertions(+), 167 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8037a967225d..d2cc2c69a8c4 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -440,25 +440,24 @@ void __init arch_cpu_finalize_init(void)
 	os_check_bugs();
 }
 
-void apply_seal_endbr(s32 *start, s32 *end, struct module *mod)
+void apply_seal_endbr(s32 *start, s32 *end)
 {
 }
 
-void apply_retpolines(s32 *start, s32 *end, struct module *mod)
+void apply_retpolines(s32 *start, s32 *end)
 {
 }
 
-void apply_returns(s32 *start, s32 *end, struct module *mod)
+void apply_returns(s32 *start, s32 *end)
 {
 }
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-		   s32 *start_cfi, s32 *end_cfi, struct module *mod)
+		   s32 *start_cfi, s32 *end_cfi)
 {
 }
 
-void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
-			struct module *mod)
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
 
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 39e6efc1a9ca..bfc7cabf4017 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -48,8 +48,7 @@ int __init init_vdso_image(const struct vdso_image *image)
 
 	apply_alternatives((struct alt_instr *)(image->data + image->alt),
 			   (struct alt_instr *)(image->data + image->alt +
-						image->alt_len),
-			   NULL);
+						image->alt_len));
 
 	return 0;
 }
diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index dc03a647776d..ca9ae606aab9 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -96,16 +96,16 @@ extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
  * instructions were patched in already:
  */
 extern int alternatives_patched;
-struct module;
 
 extern void alternative_instructions(void);
-extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
-			       struct module *mod);
-extern void apply_retpolines(s32 *start, s32 *end, struct module *mod);
-extern void apply_returns(s32 *start, s32 *end, struct module *mod);
-extern void apply_seal_endbr(s32 *start, s32 *end, struct module *mod);
+extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+extern void apply_retpolines(s32 *start, s32 *end);
+extern void apply_returns(s32 *start, s32 *end);
+extern void apply_seal_endbr(s32 *start, s32 *end);
 extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
-			  s32 *start_cfi, s32 *end_cfi, struct module *mod);
+			  s32 *start_cfi, s32 *end_cfi);
+
+struct module;
 
 struct callthunk_sites {
 	s32				*call_start, *call_end;
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 243843e44e89..d17518ca19b8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -392,10 +392,8 @@ EXPORT_SYMBOL(BUG_func);
  * Rewrite the "call BUG_func" replacement to point to the target of the
  * indirect pv_ops call "call *disp(%ip)".
  */
-static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a,
-			    struct module *mod)
+static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a)
 {
-	u8 *wr_instr = module_writable_address(mod, instr);
 	void *target, *bug = &BUG_func;
 	s32 disp;
 
@@ -405,14 +403,14 @@ static int alt_replace_call(u8 *instr, u8 *insn_buff, struct alt_instr *a,
 	}
 
 	if (a->instrlen != 6 ||
-	    wr_instr[0] != CALL_RIP_REL_OPCODE ||
-	    wr_instr[1] != CALL_RIP_REL_MODRM) {
+	    instr[0] != CALL_RIP_REL_OPCODE ||
+	    instr[1] != CALL_RIP_REL_MODRM) {
 		pr_err("ALT_FLAG_DIRECT_CALL set for unrecognized indirect call\n");
 		BUG();
 	}
 
 	/* Skip CALL_RIP_REL_OPCODE and CALL_RIP_REL_MODRM */
-	disp = *(s32 *)(wr_instr + 2);
+	disp = *(s32 *)(instr + 2);
 #ifdef CONFIG_X86_64
 	/* ff 15 00 00 00 00   call   *0x0(%rip) */
 	/* target address is stored at "next instruction + disp". */
@@ -450,8 +448,7 @@ static inline u8 * instr_va(struct alt_instr *i)
  * to refetch changed I$ lines.
  */
 void __init_or_module noinline apply_alternatives(struct alt_instr *start,
-						  struct alt_instr *end,
-						  struct module *mod)
+						  struct alt_instr *end)
 {
 	u8 insn_buff[MAX_PATCH_LEN];
 	u8 *instr, *replacement;
@@ -480,7 +477,6 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 	 */
 	for (a = start; a < end; a++) {
 		int insn_buff_sz = 0;
-		u8 *wr_instr, *wr_replacement;
 
 		/*
 		 * In case of nested ALTERNATIVE()s the outer alternative might
@@ -494,11 +490,7 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		}
 
 		instr = instr_va(a);
-		wr_instr = module_writable_address(mod, instr);
-
 		replacement = (u8 *)&a->repl_offset + a->repl_offset;
-		wr_replacement = module_writable_address(mod, replacement);
-
 		BUG_ON(a->instrlen > sizeof(insn_buff));
 		BUG_ON(a->cpuid >= (NCAPINTS + NBUGINTS) * 32);
 
@@ -509,9 +501,9 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 		 *   patch if feature is *NOT* present.
 		 */
 		if (!boot_cpu_has(a->cpuid) == !(a->flags & ALT_FLAG_NOT)) {
-			memcpy(insn_buff, wr_instr, a->instrlen);
+			memcpy(insn_buff, instr, a->instrlen);
 			optimize_nops(instr, insn_buff, a->instrlen);
-			text_poke_early(wr_instr, insn_buff, a->instrlen);
+			text_poke_early(instr, insn_buff, a->instrlen);
 			continue;
 		}
 
@@ -521,12 +513,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 			instr, instr, a->instrlen,
 			replacement, a->replacementlen, a->flags);
 
-		memcpy(insn_buff, wr_replacement, a->replacementlen);
+		memcpy(insn_buff, replacement, a->replacementlen);
 		insn_buff_sz = a->replacementlen;
 
 		if (a->flags & ALT_FLAG_DIRECT_CALL) {
-			insn_buff_sz = alt_replace_call(instr, insn_buff, a,
-							mod);
+			insn_buff_sz = alt_replace_call(instr, insn_buff, a);
 			if (insn_buff_sz < 0)
 				continue;
 		}
@@ -536,11 +527,11 @@ void __init_or_module noinline apply_alternatives(struct alt_instr *start,
 
 		apply_relocation(insn_buff, instr, a->instrlen, replacement, a->replacementlen);
 
-		DUMP_BYTES(ALT, wr_instr, a->instrlen, "%px:   old_insn: ", instr);
+		DUMP_BYTES(ALT, instr, a->instrlen, "%px:   old_insn: ", instr);
 		DUMP_BYTES(ALT, replacement, a->replacementlen, "%px:   rpl_insn: ", replacement);
 		DUMP_BYTES(ALT, insn_buff, insn_buff_sz, "%px: final_insn: ", instr);
 
-		text_poke_early(wr_instr, insn_buff, insn_buff_sz);
+		text_poke_early(instr, insn_buff, insn_buff_sz);
 	}
 
 	kasan_enable_current();
@@ -731,20 +722,18 @@ static int patch_retpoline(void *addr, struct insn *insn, u8 *bytes)
 /*
  * Generated by 'objtool --retpoline'.
  */
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end,
-						struct module *mod)
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 		struct insn insn;
 		int len, ret;
 		u8 bytes[16];
 		u8 op1, op2;
 
-		ret = insn_decode_kernel(&insn, wr_addr);
+		ret = insn_decode_kernel(&insn, addr);
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
@@ -772,9 +761,9 @@ void __init_or_module noinline apply_retpolines(s32 *start, s32 *end,
 		len = patch_retpoline(addr, &insn, bytes);
 		if (len == insn.length) {
 			optimize_nops(addr, bytes, len);
-			DUMP_BYTES(RETPOLINE, ((u8*)wr_addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RETPOLINE, ((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RETPOLINE, ((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(wr_addr, bytes, len);
+			text_poke_early(addr, bytes, len);
 		}
 	}
 }
@@ -810,8 +799,7 @@ static int patch_return(void *addr, struct insn *insn, u8 *bytes)
 	return i;
 }
 
-void __init_or_module noinline apply_returns(s32 *start, s32 *end,
-					     struct module *mod)
+void __init_or_module noinline apply_returns(s32 *start, s32 *end)
 {
 	s32 *s;
 
@@ -820,13 +808,12 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end,
 
 	for (s = start; s < end; s++) {
 		void *dest = NULL, *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 		struct insn insn;
 		int len, ret;
 		u8 bytes[16];
 		u8 op;
 
-		ret = insn_decode_kernel(&insn, wr_addr);
+		ret = insn_decode_kernel(&insn, addr);
 		if (WARN_ON_ONCE(ret < 0))
 			continue;
 
@@ -846,35 +833,32 @@ void __init_or_module noinline apply_returns(s32 *start, s32 *end,
 
 		len = patch_return(addr, &insn, bytes);
 		if (len == insn.length) {
-			DUMP_BYTES(RET, ((u8*)wr_addr),  len, "%px: orig: ", addr);
+			DUMP_BYTES(RET, ((u8*)addr),  len, "%px: orig: ", addr);
 			DUMP_BYTES(RET, ((u8*)bytes), len, "%px: repl: ", addr);
-			text_poke_early(wr_addr, bytes, len);
+			text_poke_early(addr, bytes, len);
 		}
 	}
 }
 #else
-void __init_or_module noinline apply_returns(s32 *start, s32 *end,
-					     struct module *mod) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 #endif /* CONFIG_MITIGATION_RETHUNK */
 
 #else /* !CONFIG_MITIGATION_RETPOLINE || !CONFIG_OBJTOOL */
 
-void __init_or_module noinline apply_retpolines(s32 *start, s32 *end,
-						struct module *mod) { }
-void __init_or_module noinline apply_returns(s32 *start, s32 *end,
-					     struct module *mod) { }
+void __init_or_module noinline apply_retpolines(s32 *start, s32 *end) { }
+void __init_or_module noinline apply_returns(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_MITIGATION_RETPOLINE && CONFIG_OBJTOOL */
 
 #ifdef CONFIG_X86_KERNEL_IBT
 
-static void poison_cfi(void *addr, void *wr_addr);
+static void poison_cfi(void *addr);
 
-static void __init_or_module poison_endbr(void *addr, void *wr_addr, bool warn)
+static void __init_or_module poison_endbr(void *addr, bool warn)
 {
 	u32 endbr, poison = gen_endbr_poison();
 
-	if (WARN_ON_ONCE(get_kernel_nofault(endbr, wr_addr)))
+	if (WARN_ON_ONCE(get_kernel_nofault(endbr, addr)))
 		return;
 
 	if (!is_endbr(endbr)) {
@@ -889,7 +873,7 @@ static void __init_or_module poison_endbr(void *addr, void *wr_addr, bool warn)
 	 */
 	DUMP_BYTES(ENDBR, ((u8*)addr), 4, "%px: orig: ", addr);
 	DUMP_BYTES(ENDBR, ((u8*)&poison), 4, "%px: repl: ", addr);
-	text_poke_early(wr_addr, &poison, 4);
+	text_poke_early(addr, &poison, 4);
 }
 
 /*
@@ -898,23 +882,22 @@ static void __init_or_module poison_endbr(void *addr, void *wr_addr, bool warn)
  * Seal the functions for indirect calls by clobbering the ENDBR instructions
  * and the kCFI hash value.
  */
-void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end, struct module *mod)
+void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 
-		poison_endbr(addr, wr_addr, true);
+		poison_endbr(addr, true);
 		if (IS_ENABLED(CONFIG_FINEIBT))
-			poison_cfi(addr - 16, wr_addr - 16);
+			poison_cfi(addr - 16);
 	}
 }
 
 #else
 
-void __init_or_module apply_seal_endbr(s32 *start, s32 *end, struct module *mod) { }
+void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
@@ -1136,7 +1119,7 @@ static u32 decode_caller_hash(void *addr)
 }
 
 /* .retpoline_sites */
-static int cfi_disable_callers(s32 *start, s32 *end, struct module *mod)
+static int cfi_disable_callers(s32 *start, s32 *end)
 {
 	/*
 	 * Disable kCFI by patching in a JMP.d8, this leaves the hash immediate
@@ -1148,23 +1131,20 @@ static int cfi_disable_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		wr_addr = module_writable_address(mod, addr);
-		hash = decode_caller_hash(wr_addr);
-
+		hash = decode_caller_hash(addr);
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(wr_addr, jmp, 2);
+		text_poke_early(addr, jmp, 2);
 	}
 
 	return 0;
 }
 
-static int cfi_enable_callers(s32 *start, s32 *end, struct module *mod)
+static int cfi_enable_callers(s32 *start, s32 *end)
 {
 	/*
 	 * Re-enable kCFI, undo what cfi_disable_callers() did.
@@ -1174,115 +1154,106 @@ static int cfi_enable_callers(s32 *start, s32 *end, struct module *mod)
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		wr_addr = module_writable_address(mod, addr);
-		hash = decode_caller_hash(wr_addr);
+		hash = decode_caller_hash(addr);
 		if (!hash) /* nocfi callers */
 			continue;
 
-		text_poke_early(wr_addr, mov, 2);
+		text_poke_early(addr, mov, 2);
 	}
 
 	return 0;
 }
 
 /* .cfi_sites */
-static int cfi_rand_preamble(s32 *start, s32 *end, struct module *mod)
+static int cfi_rand_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 		u32 hash;
 
-		hash = decode_preamble_hash(wr_addr);
+		hash = decode_preamble_hash(addr);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
 		hash = cfi_rehash(hash);
-		text_poke_early(wr_addr + 1, &hash, 4);
+		text_poke_early(addr + 1, &hash, 4);
 	}
 
 	return 0;
 }
 
-static int cfi_rewrite_preamble(s32 *start, s32 *end, struct module *mod)
+static int cfi_rewrite_preamble(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 		u32 hash;
 
-		hash = decode_preamble_hash(wr_addr);
+		hash = decode_preamble_hash(addr);
 		if (WARN(!hash, "no CFI hash found at: %pS %px %*ph\n",
 			 addr, addr, 5, addr))
 			return -EINVAL;
 
-		text_poke_early(wr_addr, fineibt_preamble_start, fineibt_preamble_size);
-		WARN_ON(*(u32 *)(wr_addr + fineibt_preamble_hash) != 0x12345678);
-		text_poke_early(wr_addr + fineibt_preamble_hash, &hash, 4);
+		text_poke_early(addr, fineibt_preamble_start, fineibt_preamble_size);
+		WARN_ON(*(u32 *)(addr + fineibt_preamble_hash) != 0x12345678);
+		text_poke_early(addr + fineibt_preamble_hash, &hash, 4);
 	}
 
 	return 0;
 }
 
-static void cfi_rewrite_endbr(s32 *start, s32 *end, struct module *mod)
+static void cfi_rewrite_endbr(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr = module_writable_address(mod, addr);
 
-		poison_endbr(addr + 16, wr_addr + 16, false);
+		poison_endbr(addr+16, false);
 	}
 }
 
 /* .retpoline_sites */
-static int cfi_rand_callers(s32 *start, s32 *end, struct module *mod)
+static int cfi_rand_callers(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		wr_addr = module_writable_address(mod, addr);
-		hash = decode_caller_hash(wr_addr);
+		hash = decode_caller_hash(addr);
 		if (hash) {
 			hash = -cfi_rehash(hash);
-			text_poke_early(wr_addr + 2, &hash, 4);
+			text_poke_early(addr + 2, &hash, 4);
 		}
 	}
 
 	return 0;
 }
 
-static int cfi_rewrite_callers(s32 *start, s32 *end, struct module *mod)
+static int cfi_rewrite_callers(s32 *start, s32 *end)
 {
 	s32 *s;
 
 	for (s = start; s < end; s++) {
 		void *addr = (void *)s + *s;
-		void *wr_addr;
 		u32 hash;
 
 		addr -= fineibt_caller_size;
-		wr_addr = module_writable_address(mod, addr);
-		hash = decode_caller_hash(wr_addr);
+		hash = decode_caller_hash(addr);
 		if (hash) {
-			text_poke_early(wr_addr, fineibt_caller_start, fineibt_caller_size);
-			WARN_ON(*(u32 *)(wr_addr + fineibt_caller_hash) != 0x12345678);
-			text_poke_early(wr_addr + fineibt_caller_hash, &hash, 4);
+			text_poke_early(addr, fineibt_caller_start, fineibt_caller_size);
+			WARN_ON(*(u32 *)(addr + fineibt_caller_hash) != 0x12345678);
+			text_poke_early(addr + fineibt_caller_hash, &hash, 4);
 		}
 		/* rely on apply_retpolines() */
 	}
@@ -1291,9 +1262,8 @@ static int cfi_rewrite_callers(s32 *start, s32 *end, struct module *mod)
 }
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-			    s32 *start_cfi, s32 *end_cfi, struct module *mod)
+			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
-	bool builtin = mod ? false : true;
 	int ret;
 
 	if (WARN_ONCE(fineibt_preamble_size != 16,
@@ -1311,7 +1281,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 	 * rewrite them. This disables all CFI. If this succeeds but any of the
 	 * later stages fails, we're without CFI.
 	 */
-	ret = cfi_disable_callers(start_retpoline, end_retpoline, mod);
+	ret = cfi_disable_callers(start_retpoline, end_retpoline);
 	if (ret)
 		goto err;
 
@@ -1322,11 +1292,11 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 			cfi_bpf_subprog_hash = cfi_rehash(cfi_bpf_subprog_hash);
 		}
 
-		ret = cfi_rand_preamble(start_cfi, end_cfi, mod);
+		ret = cfi_rand_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
-		ret = cfi_rand_callers(start_retpoline, end_retpoline, mod);
+		ret = cfi_rand_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 	}
@@ -1338,7 +1308,7 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 		return;
 
 	case CFI_KCFI:
-		ret = cfi_enable_callers(start_retpoline, end_retpoline, mod);
+		ret = cfi_enable_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 
@@ -1348,17 +1318,17 @@ static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
 
 	case CFI_FINEIBT:
 		/* place the FineIBT preamble at func()-16 */
-		ret = cfi_rewrite_preamble(start_cfi, end_cfi, mod);
+		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
 		/* rewrite the callers to target func()-16 */
-		ret = cfi_rewrite_callers(start_retpoline, end_retpoline, mod);
+		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 
 		/* now that nobody targets func()+0, remove ENDBR there */
-		cfi_rewrite_endbr(start_cfi, end_cfi, mod);
+		cfi_rewrite_endbr(start_cfi, end_cfi);
 
 		if (builtin)
 			pr_info("Using FineIBT CFI\n");
@@ -1377,7 +1347,7 @@ static inline void poison_hash(void *addr)
 	*(u32 *)addr = 0;
 }
 
-static void poison_cfi(void *addr, void *wr_addr)
+static void poison_cfi(void *addr)
 {
 	switch (cfi_mode) {
 	case CFI_FINEIBT:
@@ -1389,8 +1359,8 @@ static void poison_cfi(void *addr, void *wr_addr)
 		 *	ud2
 		 * 1:	nop
 		 */
-		poison_endbr(addr, wr_addr, false);
-		poison_hash(wr_addr + fineibt_preamble_hash);
+		poison_endbr(addr, false);
+		poison_hash(addr + fineibt_preamble_hash);
 		break;
 
 	case CFI_KCFI:
@@ -1399,7 +1369,7 @@ static void poison_cfi(void *addr, void *wr_addr)
 		 *	movl	$0, %eax
 		 *	.skip	11, 0x90
 		 */
-		poison_hash(wr_addr + 1);
+		poison_hash(addr + 1);
 		break;
 
 	default:
@@ -1410,21 +1380,22 @@ static void poison_cfi(void *addr, void *wr_addr)
 #else
 
 static void __apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-			    s32 *start_cfi, s32 *end_cfi, struct module *mod)
+			    s32 *start_cfi, s32 *end_cfi, bool builtin)
 {
 }
 
 #ifdef CONFIG_X86_KERNEL_IBT
-static void poison_cfi(void *addr, void *wr_addr) { }
+static void poison_cfi(void *addr) { }
 #endif
 
 #endif
 
 void apply_fineibt(s32 *start_retpoline, s32 *end_retpoline,
-		   s32 *start_cfi, s32 *end_cfi, struct module *mod)
+		   s32 *start_cfi, s32 *end_cfi)
 {
 	return __apply_fineibt(start_retpoline, end_retpoline,
-			       start_cfi, end_cfi, mod);
+			       start_cfi, end_cfi,
+			       /* .builtin = */ false);
 }
 
 #ifdef CONFIG_SMP
@@ -1721,16 +1692,16 @@ void __init alternative_instructions(void)
 	paravirt_set_cap();
 
 	__apply_fineibt(__retpoline_sites, __retpoline_sites_end,
-			__cfi_sites, __cfi_sites_end, NULL);
+			__cfi_sites, __cfi_sites_end, true);
 
 	/*
 	 * Rewrite the retpolines, must be done before alternatives since
 	 * those can rewrite the retpoline thunks.
 	 */
-	apply_retpolines(__retpoline_sites, __retpoline_sites_end, NULL);
-	apply_returns(__return_sites, __return_sites_end, NULL);
+	apply_retpolines(__retpoline_sites, __retpoline_sites_end);
+	apply_returns(__return_sites, __return_sites_end);
 
-	apply_alternatives(__alt_instructions, __alt_instructions_end, NULL);
+	apply_alternatives(__alt_instructions, __alt_instructions_end);
 
 	/*
 	 * Now all calls are established. Apply the call thunks if
@@ -1741,7 +1712,7 @@ void __init alternative_instructions(void)
 	/*
 	 * Seal all functions that do not have their address taken.
 	 */
-	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end, NULL);
+	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
 
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 4dd0ad6c94d6..adb09f78edb2 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -118,13 +118,10 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
 		return ret;
 
 	/* replace the text with the new text */
-	if (ftrace_poke_late) {
+	if (ftrace_poke_late)
 		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
-	} else {
-		mutex_lock(&text_mutex);
-		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
-		mutex_unlock(&text_mutex);
-	}
+	else
+		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
 	return 0;
 }
 
@@ -321,7 +318,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	unsigned const char op_ref[] = { 0x48, 0x8b, 0x15 };
 	unsigned const char retq[] = { RET_INSN_OPCODE, INT3_INSN_OPCODE };
 	union ftrace_op_code_union op_ptr;
-	void *ret;
+	int ret;
 
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
 		start_offset = (unsigned long)ftrace_regs_caller;
@@ -352,15 +349,15 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	npages = DIV_ROUND_UP(*tramp_size, PAGE_SIZE);
 
 	/* Copy ftrace_caller onto the trampoline memory */
-	ret = text_poke_copy(trampoline, (void *)start_offset, size);
-	if (WARN_ON(!ret))
+	ret = copy_from_kernel_nofault(trampoline, (void *)start_offset, size);
+	if (WARN_ON(ret < 0))
 		goto fail;
 
 	ip = trampoline + size;
 	if (cpu_feature_enabled(X86_FEATURE_RETHUNK))
 		__text_gen_insn(ip, JMP32_INSN_OPCODE, ip, x86_return_thunk, JMP32_INSN_SIZE);
 	else
-		text_poke_copy(ip, retq, sizeof(retq));
+		memcpy(ip, retq, sizeof(retq));
 
 	/* No need to test direct calls on created trampolines */
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS) {
@@ -368,7 +365,8 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 		ip = trampoline + (jmp_offset - start_offset);
 		if (WARN_ON(*(char *)ip != 0x75))
 			goto fail;
-		if (!text_poke_copy(ip, x86_nops[2], 2))
+		ret = copy_from_kernel_nofault(ip, x86_nops[2], 2);
+		if (ret < 0)
 			goto fail;
 	}
 
@@ -381,7 +379,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 */
 
 	ptr = (unsigned long *)(trampoline + size + RET_SIZE);
-	text_poke_copy(ptr, &ops, sizeof(unsigned long));
+	*ptr = (unsigned long)ops;
 
 	op_offset -= start_offset;
 	memcpy(&op_ptr, trampoline + op_offset, OP_REF_SIZE);
@@ -397,7 +395,7 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	op_ptr.offset = offset;
 
 	/* put in the new offset to the ftrace_ops */
-	text_poke_copy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
+	memcpy(trampoline + op_offset, &op_ptr, OP_REF_SIZE);
 
 	/* put in the call to the function */
 	mutex_lock(&text_mutex);
@@ -407,9 +405,9 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 	 * the depth accounting before the call already.
 	 */
 	dest = ftrace_ops_get_func(ops);
-	text_poke_copy_locked(trampoline + call_offset,
-	      text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
-	      CALL_INSN_SIZE, false);
+	memcpy(trampoline + call_offset,
+	       text_gen_insn(CALL_INSN_OPCODE, trampoline + call_offset, dest),
+	       CALL_INSN_SIZE);
 	mutex_unlock(&text_mutex);
 
 	/* ALLOC_TRAMP flags lets us know we created it */
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index 8984abd91c00..837450b6e882 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -146,21 +146,18 @@ static int __write_relocate_add(Elf64_Shdr *sechdrs,
 		}
 
 		if (apply) {
-			void *wr_loc = module_writable_address(me, loc);
-
-			if (memcmp(wr_loc, &zero, size)) {
+			if (memcmp(loc, &zero, size)) {
 				pr_err("x86/modules: Invalid relocation target, existing value is nonzero for type %d, loc %p, val %Lx\n",
 				       (int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
-			write(wr_loc, &val, size);
+			write(loc, &val, size);
 		} else {
 			if (memcmp(loc, &val, size)) {
 				pr_warn("x86/modules: Invalid relocation target, existing value does not match expected value for type %d, loc %p, val %Lx\n",
 					(int)ELF64_R_TYPE(rel[i].r_info), loc, val);
 				return -ENOEXEC;
 			}
-			/* FIXME: needs care for ROX module allocations */
 			write(loc, &zero, size);
 		}
 	}
@@ -227,7 +224,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s, *alt = NULL,
+	const Elf_Shdr *s, *alt = NULL, *locks = NULL,
 		*orc = NULL, *orc_ip = NULL,
 		*retpolines = NULL, *returns = NULL, *ibt_endbr = NULL,
 		*calls = NULL, *cfi = NULL;
@@ -236,6 +233,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
 		if (!strcmp(".altinstructions", secstrings + s->sh_name))
 			alt = s;
+		if (!strcmp(".smp_locks", secstrings + s->sh_name))
+			locks = s;
 		if (!strcmp(".orc_unwind", secstrings + s->sh_name))
 			orc = s;
 		if (!strcmp(".orc_unwind_ip", secstrings + s->sh_name))
@@ -266,20 +265,20 @@ int module_finalize(const Elf_Ehdr *hdr,
 			csize = cfi->sh_size;
 		}
 
-		apply_fineibt(rseg, rseg + rsize, cseg, cseg + csize, me);
+		apply_fineibt(rseg, rseg + rsize, cseg, cseg + csize);
 	}
 	if (retpolines) {
 		void *rseg = (void *)retpolines->sh_addr;
-		apply_retpolines(rseg, rseg + retpolines->sh_size, me);
+		apply_retpolines(rseg, rseg + retpolines->sh_size);
 	}
 	if (returns) {
 		void *rseg = (void *)returns->sh_addr;
-		apply_returns(rseg, rseg + returns->sh_size, me);
+		apply_returns(rseg, rseg + returns->sh_size);
 	}
 	if (alt) {
 		/* patch .altinstructions */
 		void *aseg = (void *)alt->sh_addr;
-		apply_alternatives(aseg, aseg + alt->sh_size, me);
+		apply_alternatives(aseg, aseg + alt->sh_size);
 	}
 	if (calls || alt) {
 		struct callthunk_sites cs = {};
@@ -298,28 +297,8 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
-		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size, me);
+		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
-
-	if (orc && orc_ip)
-		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
-				   (void *)orc->sh_addr, orc->sh_size);
-
-	return 0;
-}
-
-int module_post_finalize(const Elf_Ehdr *hdr,
-			 const Elf_Shdr *sechdrs,
-			 struct module *me)
-{
-	const Elf_Shdr *s, *locks = NULL;
-	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
-
-	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) {
-		if (!strcmp(".smp_locks", secstrings + s->sh_name))
-			locks = s;
-	}
-
 	if (locks) {
 		void *lseg = (void *)locks->sh_addr;
 		void *text = me->mem[MOD_TEXT].base;
@@ -329,6 +308,10 @@ int module_post_finalize(const Elf_Ehdr *hdr,
 					    text, text_end);
 	}
 
+	if (orc && orc_ip)
+		unwind_module_init(me, (void *)orc_ip->sh_addr, orc_ip->sh_size,
+				   (void *)orc->sh_addr, orc->sh_size);
+
 	return 0;
 }
 
-- 
2.45.2


