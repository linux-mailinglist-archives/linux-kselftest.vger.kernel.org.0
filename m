Return-Path: <linux-kselftest+bounces-32223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2FAAA79E4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C9021B60461
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 19:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B48E1F3FF1;
	Fri,  2 May 2025 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpAiqDc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AD1EFFBB;
	Fri,  2 May 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746212493; cv=none; b=V91foM+EZhbjhMvbXLZJ+lHdwsA3cRlu5ObgNBohd7g+IIdZidAziJNOECPjMmF3spf4T4ALacG4UWBF6DIfVOO8wtG50slmzSczqak/P4S2V7L5Ph3sL6KvM4xM/rx3lorMwltmnEUjh2WW+veEe5UsGmMhuYAc0ffKN8+dWcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746212493; c=relaxed/simple;
	bh=7I88xKKl+S/SbyjDaiSTE40W0kyqkp1EQfua5U78PZ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fuApzooI67U76fYItzmy6FKrKMWY7oNEi/RkjoGy+haw9WLjHaBB0n4QXTwmIS3be/0QXWEGqriw24kINpSTFuPiVfkaNa1iu26apCW7Uw6kgJnTJLtwUhCwYYpwjzO69S3POcrc0osT8Ebvg195cgk1HlTwM2Rwk0tgRv/RuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpAiqDc3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2C9C4CEEF;
	Fri,  2 May 2025 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746212492;
	bh=7I88xKKl+S/SbyjDaiSTE40W0kyqkp1EQfua5U78PZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpAiqDc3tN2wz5gL0XhWvH9BhHOk8PlRUiQxsejlwiafhFIMup221KJ9xATko0X4t
	 eG1kDW0pGjSva8BZwPg1wVuEeubb2FYwIBLKC1sAq/F7KtDfyDV1HvWsQx1WSJbCYf
	 rlFxzzE3oHeS/ZOuuEUCYkGe2cAo9VlkLFsTATnQzrXFKg+a9eiJNvRVgYBp+N3giv
	 G1VgCUMLwdzHB1v5Dhi0V5duqw6kCaPv2YsKHx54/fEGVX8Yfw8U9qcjU+budjNSB+
	 yOfVPTOZi+kv+bMAioZmtpZHn0mF9zTg6d/bX+b5mBp17wAF3+40fbfABDvO/MdK8R
	 Xu2rzZbL0ocGA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	kasan-dev@googlegroups.com,
	llvm@lists.linux.dev
Subject: [PATCH RFC 2/4] stackleak: Rename stackleak_track_stack to __sanitizer_cov_stack_depth
Date: Fri,  2 May 2025 12:01:25 -0700
Message-Id: <20250502190129.246328-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502185834.work.560-kees@kernel.org>
References: <20250502185834.work.560-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=11391; i=kees@kernel.org; h=from:subject; bh=7I88xKKl+S/SbyjDaiSTE40W0kyqkp1EQfua5U78PZ8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmiYm3LV8zvdj55z/bzfna/NTLWi0wylt38Istd8Ccjx WujAoNIRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwESKGxgZWl8H6zjqMR5u7rnb /EicLWWtTtqCp97Nm2tT7NnPfpsXwcjwv71pxusd83ilnU+cCroW4lY/3dfWScUoxH/xd3dX9Tv 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The Clang stack depth tracking implementation has a fixed name for the
stack depth tracking callback, "__sanitizer_cov_stack_depth", so rename
the GCC plugin function to match.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-hardening@vger.kernel.org>
---
 include/linux/stackleak.h              |  2 +-
 kernel/stackleak.c                     |  4 +-
 scripts/gcc-plugins/stackleak_plugin.c | 52 +++++++++++++-------------
 security/Kconfig.hardening             |  4 +-
 tools/objtool/check.c                  |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/linux/stackleak.h b/include/linux/stackleak.h
index 71e8242fd8f2..a669574a3562 100644
--- a/include/linux/stackleak.h
+++ b/include/linux/stackleak.h
@@ -80,7 +80,7 @@ static inline void stackleak_task_init(struct task_struct *t)
 asmlinkage void noinstr stackleak_erase(void);
 asmlinkage void noinstr stackleak_erase_on_task_stack(void);
 asmlinkage void noinstr stackleak_erase_off_task_stack(void);
-void __no_caller_saved_registers noinstr stackleak_track_stack(void);
+void __no_caller_saved_registers noinstr __sanitizer_cov_stack_depth(void);
 
 #else /* !CONFIG_STACKLEAK */
 static inline void stackleak_task_init(struct task_struct *t) { }
diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index bb65321761b4..5158468968e2 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -156,7 +156,7 @@ asmlinkage void noinstr stackleak_erase_off_task_stack(void)
 	__stackleak_erase(false);
 }
 
-void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
+void __used __no_caller_saved_registers noinstr __sanitizer_cov_stack_depth(void)
 {
 	unsigned long sp = current_stack_pointer;
 
@@ -174,4 +174,4 @@ void __used __no_caller_saved_registers noinstr stackleak_track_stack(void)
 		current->lowest_stack = sp;
 	}
 }
-EXPORT_SYMBOL(stackleak_track_stack);
+EXPORT_SYMBOL(__sanitizer_cov_stack_depth);
diff --git a/scripts/gcc-plugins/stackleak_plugin.c b/scripts/gcc-plugins/stackleak_plugin.c
index d20c47d21ad8..e486488c867d 100644
--- a/scripts/gcc-plugins/stackleak_plugin.c
+++ b/scripts/gcc-plugins/stackleak_plugin.c
@@ -9,7 +9,7 @@
  * any of the gcc libraries
  *
  * This gcc plugin is needed for tracking the lowest border of the kernel stack.
- * It instruments the kernel code inserting stackleak_track_stack() calls:
+ * It instruments the kernel code inserting __sanitizer_cov_stack_depth() calls:
  *  - after alloca();
  *  - for the functions with a stack frame size greater than or equal
  *     to the "track-min-size" plugin parameter.
@@ -33,7 +33,7 @@ __visible int plugin_is_GPL_compatible;
 
 static int track_frame_size = -1;
 static bool build_for_x86 = false;
-static const char track_function[] = "stackleak_track_stack";
+static const char track_function[] = "__sanitizer_cov_stack_depth";
 static bool disable = false;
 static bool verbose = false;
 
@@ -58,7 +58,7 @@ static void add_stack_tracking_gcall(gimple_stmt_iterator *gsi, bool after)
 	cgraph_node_ptr node;
 	basic_block bb;
 
-	/* Insert calling stackleak_track_stack() */
+	/* Insert calling __sanitizer_cov_stack_depth() */
 	stmt = gimple_build_call(track_function_decl, 0);
 	gimple_call = as_a_gcall(stmt);
 	if (after)
@@ -120,12 +120,12 @@ static void add_stack_tracking_gasm(gimple_stmt_iterator *gsi, bool after)
 	gcc_assert(build_for_x86);
 
 	/*
-	 * Insert calling stackleak_track_stack() in asm:
-	 *   asm volatile("call stackleak_track_stack"
+	 * Insert calling __sanitizer_cov_stack_depth() in asm:
+	 *   asm volatile("call __sanitizer_cov_stack_depth"
 	 *		  :: "r" (current_stack_pointer))
 	 * Use ASM_CALL_CONSTRAINT trick from arch/x86/include/asm/asm.h.
 	 * This constraint is taken into account during gcc shrink-wrapping
-	 * optimization. It is needed to be sure that stackleak_track_stack()
+	 * optimization. It is needed to be sure that __sanitizer_cov_stack_depth()
 	 * call is inserted after the prologue of the containing function,
 	 * when the stack frame is prepared.
 	 */
@@ -137,7 +137,7 @@ static void add_stack_tracking_gasm(gimple_stmt_iterator *gsi, bool after)
 	input = build_tree_list(NULL_TREE, build_const_char_string(2, "r"));
 	input = chainon(NULL_TREE, build_tree_list(input, sp_decl));
 	vec_safe_push(inputs, input);
-	asm_call = gimple_build_asm_vec("call stackleak_track_stack",
+	asm_call = gimple_build_asm_vec("call __sanitizer_cov_stack_depth",
 					inputs, NULL, NULL, NULL);
 	gimple_asm_set_volatile(asm_call, true);
 	if (after)
@@ -151,11 +151,11 @@ static void add_stack_tracking(gimple_stmt_iterator *gsi, bool after)
 {
 	/*
 	 * The 'no_caller_saved_registers' attribute is used for
-	 * stackleak_track_stack(). If the compiler supports this attribute for
-	 * the target arch, we can add calling stackleak_track_stack() in asm.
+	 * __sanitizer_cov_stack_depth(). If the compiler supports this attribute for
+	 * the target arch, we can add calling __sanitizer_cov_stack_depth() in asm.
 	 * That improves performance: we avoid useless operations with the
 	 * caller-saved registers in the functions from which we will remove
-	 * stackleak_track_stack() call during the stackleak_cleanup pass.
+	 * __sanitizer_cov_stack_depth() call during the stackleak_cleanup pass.
 	 */
 	if (lookup_attribute_spec(get_identifier("no_caller_saved_registers")))
 		add_stack_tracking_gasm(gsi, after);
@@ -165,7 +165,7 @@ static void add_stack_tracking(gimple_stmt_iterator *gsi, bool after)
 
 /*
  * Work with the GIMPLE representation of the code. Insert the
- * stackleak_track_stack() call after alloca() and into the beginning
+ * __sanitizer_cov_stack_depth() call after alloca() and into the beginning
  * of the function if it is not instrumented.
  */
 static unsigned int stackleak_instrument_execute(void)
@@ -205,7 +205,7 @@ static unsigned int stackleak_instrument_execute(void)
 					DECL_NAME_POINTER(current_function_decl));
 			}
 
-			/* Insert stackleak_track_stack() call after alloca() */
+			/* Insert __sanitizer_cov_stack_depth() call after alloca() */
 			add_stack_tracking(&gsi, true);
 			if (bb == entry_bb)
 				prologue_instrumented = true;
@@ -241,7 +241,7 @@ static unsigned int stackleak_instrument_execute(void)
 		return 0;
 	}
 
-	/* Insert stackleak_track_stack() call at the function beginning */
+	/* Insert __sanitizer_cov_stack_depth() call at the function beginning */
 	bb = entry_bb;
 	if (!single_pred_p(bb)) {
 		/* gcc_assert(bb_loop_depth(bb) ||
@@ -270,15 +270,15 @@ static void remove_stack_tracking_gcall(void)
 	rtx_insn *insn, *next;
 
 	/*
-	 * Find stackleak_track_stack() calls. Loop through the chain of insns,
+	 * Find __sanitizer_cov_stack_depth() calls. Loop through the chain of insns,
 	 * which is an RTL representation of the code for a function.
 	 *
 	 * The example of a matching insn:
-	 *  (call_insn 8 4 10 2 (call (mem (symbol_ref ("stackleak_track_stack")
-	 *  [flags 0x41] <function_decl 0x7f7cd3302a80 stackleak_track_stack>)
-	 *  [0 stackleak_track_stack S1 A8]) (0)) 675 {*call} (expr_list
-	 *  (symbol_ref ("stackleak_track_stack") [flags 0x41] <function_decl
-	 *  0x7f7cd3302a80 stackleak_track_stack>) (expr_list (0) (nil))) (nil))
+	 *  (call_insn 8 4 10 2 (call (mem (symbol_ref ("__sanitizer_cov_stack_depth")
+	 *  [flags 0x41] <function_decl 0x7f7cd3302a80 __sanitizer_cov_stack_depth>)
+	 *  [0 __sanitizer_cov_stack_depth S1 A8]) (0)) 675 {*call} (expr_list
+	 *  (symbol_ref ("__sanitizer_cov_stack_depth") [flags 0x41] <function_decl
+	 *  0x7f7cd3302a80 __sanitizer_cov_stack_depth>) (expr_list (0) (nil))) (nil))
 	 */
 	for (insn = get_insns(); insn; insn = next) {
 		rtx body;
@@ -318,7 +318,7 @@ static void remove_stack_tracking_gcall(void)
 		if (SYMBOL_REF_DECL(body) != track_function_decl)
 			continue;
 
-		/* Delete the stackleak_track_stack() call */
+		/* Delete the __sanitizer_cov_stack_depth() call */
 		delete_insn_and_edges(insn);
 #if BUILDING_GCC_VERSION < 8000
 		if (GET_CODE(next) == NOTE &&
@@ -340,12 +340,12 @@ static bool remove_stack_tracking_gasm(void)
 	gcc_assert(build_for_x86);
 
 	/*
-	 * Find stackleak_track_stack() asm calls. Loop through the chain of
+	 * Find __sanitizer_cov_stack_depth() asm calls. Loop through the chain of
 	 * insns, which is an RTL representation of the code for a function.
 	 *
 	 * The example of a matching insn:
 	 *  (insn 11 5 12 2 (parallel [ (asm_operands/v
-	 *  ("call stackleak_track_stack") ("") 0
+	 *  ("call __sanitizer_cov_stack_depth") ("") 0
 	 *  [ (reg/v:DI 7 sp [ current_stack_pointer ]) ]
 	 *  [ (asm_input:DI ("r")) ] [])
 	 *  (clobber (reg:CC 17 flags)) ]) -1 (nil))
@@ -375,7 +375,7 @@ static bool remove_stack_tracking_gasm(void)
 			continue;
 
 		if (strcmp(ASM_OPERANDS_TEMPLATE(body),
-						"call stackleak_track_stack")) {
+						"call __sanitizer_cov_stack_depth")) {
 			continue;
 		}
 
@@ -389,7 +389,7 @@ static bool remove_stack_tracking_gasm(void)
 
 /*
  * Work with the RTL representation of the code.
- * Remove the unneeded stackleak_track_stack() calls from the functions
+ * Remove the unneeded __sanitizer_cov_stack_depth() calls from the functions
  * which don't call alloca() and don't have a large enough stack frame size.
  */
 static unsigned int stackleak_cleanup_execute(void)
@@ -474,13 +474,13 @@ static bool stackleak_gate(void)
 	return track_frame_size >= 0;
 }
 
-/* Build the function declaration for stackleak_track_stack() */
+/* Build the function declaration for __sanitizer_cov_stack_depth() */
 static void stackleak_start_unit(void *gcc_data __unused,
 				 void *user_data __unused)
 {
 	tree fntype;
 
-	/* void stackleak_track_stack(void) */
+	/* void __sanitizer_cov_stack_depth(void) */
 	fntype = build_function_type_list(void_type_node, NULL_TREE);
 	track_function_decl = build_fn_decl(track_function, fntype);
 	DECL_ASSEMBLER_NAME(track_function_decl); /* for LTO */
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 8aa5c1d4794d..edcc489a6805 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -205,8 +205,8 @@ config STACKLEAK_TRACK_MIN_SIZE
 	help
 	  The STACKLEAK options instruments the kernel code for tracking
 	  the lowest border of the kernel stack (and for some other purposes).
-	  It inserts the stackleak_track_stack() call for the functions with
-	  a stack frame size greater than or equal to this parameter.
+	  It inserts the __sanitizer_cov_stack_depth() call for the functions
+	  with a stack frame size greater than or equal to this parameter.
 	  If unsure, leave the default value 100.
 
 config STACKLEAK_METRICS
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3a411064fa34..05d0095c1384 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1191,7 +1191,7 @@ static const char *uaccess_safe_builtin[] = {
 	"__ubsan_handle_shift_out_of_bounds",
 	"__ubsan_handle_load_invalid_value",
 	/* STACKLEAK */
-	"stackleak_track_stack",
+	"__sanitizer_cov_stack_depth",
 	/* TRACE_BRANCH_PROFILING */
 	"ftrace_likely_update",
 	/* STACKPROTECTOR */
-- 
2.34.1


