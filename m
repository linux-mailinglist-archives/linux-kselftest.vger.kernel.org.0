Return-Path: <linux-kselftest+bounces-31890-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A6AAA0A8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 13:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 115F13BC13C
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 11:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14022C374F;
	Tue, 29 Apr 2025 11:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ePyWxp2E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EE2C17BB
	for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 11:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745927071; cv=none; b=sZ4Umh/ufSdv3lUXrkq+hMdhMOCQvKhXMdtANDOoPSGHc8HOTa2ULEznuiljUQDcqjjN4xF0RYdVpELat2M1StvDEmh2bC8cnlUt7sZ0NQV6WeoalY0CICxNsgpBGmDpnBsIAxhyYdaEyCLzZ06OWaP0uiJC9qeNoVkmgYx1dgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745927071; c=relaxed/simple;
	bh=MiBm/TEsURc0r8+YW+tVb4bkIWql1PqxsDPXAuoZdmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzMgMfO4pGKIpdrjEfAnkIHqCLgVa5+z6/18ZO4bcPfKhOpA75eoocAQIvYuONi8GCOERJ4f7X2JL2bBo52OnMW/hEDpjAGTmv6Z96XOgsUvq74rMCHkWZCldsr8NjqtYR+4QdxCnWNVetogbM/zVJIwMw5C/eOEWmXC3dfWAlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ePyWxp2E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745927067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tuANjP98UfL1jj4dJePfTwHISt9kiag/v6edYCwLo6k=;
	b=ePyWxp2ET5hEBK48Hioq5ybi3m8mDmCSMAAS599wawIp9nA67DEG1R6dRDuIuS5/fRp5Q7
	fWtDqYNgPEcf+TE801hd3SEII/o3tz/VQTvasfdOufPnO7U3sXEqNcndwPVQrGKXbHSdkL
	9tDZaXNKfVO7NNWQ0Ne2neK/J+O++rg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-wX4I6pchM5-NTYwoxo-_cA-1; Tue,
 29 Apr 2025 07:44:25 -0400
X-MC-Unique: wX4I6pchM5-NTYwoxo-_cA-1
X-Mimecast-MFC-AGG-ID: wX4I6pchM5-NTYwoxo-_cA_1745927061
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ABB418001CA;
	Tue, 29 Apr 2025 11:44:21 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.45.225.102])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16D0019560AF;
	Tue, 29 Apr 2025 11:43:51 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Sean Christopherson <seanjc@google.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.amakhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jason Baron <jbaron@akamai.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	Naveen N Rao <naveen@kernel.org>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Kees Cook <kees@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Rong Xu <xur@google.com>,
	Rafael Aquini <aquini@redhat.com>,
	Song Liu <song@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Brian Gerst <brgerst@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Benjamin Berg <benjamin.berg@intel.com>,
	Vishal Annapurve <vannapurve@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Stultz <jstultz@google.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: [PATCH v5 21/25] objtool: Add noinstr validation for static branches/calls
Date: Tue, 29 Apr 2025 13:32:38 +0200
Message-ID: <20250429113242.998312-22-vschneid@redhat.com>
In-Reply-To: <20250429113242.998312-1-vschneid@redhat.com>
References: <20250429113242.998312-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: Josh Poimboeuf <jpoimboe@kernel.org>

Warn about static branches/calls in noinstr regions, unless the
corresponding key is RO-after-init or has been manually whitelisted with
DEFINE_STATIC_KEY_*_NOINSTR(().

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
[Added NULL check for insn_call_dest() return value]
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 include/linux/jump_label.h              | 17 +++--
 include/linux/objtool.h                 |  7 ++
 include/linux/static_call.h             |  3 +
 tools/objtool/Documentation/objtool.txt | 34 +++++++++
 tools/objtool/check.c                   | 92 ++++++++++++++++++++++---
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/elf.h     |  1 +
 tools/objtool/include/objtool/special.h |  1 +
 tools/objtool/special.c                 | 15 +++-
 9 files changed, 155 insertions(+), 16 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index c4f6240ff4d95..0ea203ebbc493 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -76,6 +76,7 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/cleanup.h>
+#include <linux/objtool.h>
 
 extern bool static_key_initialized;
 
@@ -376,8 +377,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_TRUE(name)	\
 	struct static_key_true name = STATIC_KEY_TRUE_INIT
 
-#define DEFINE_STATIC_KEY_TRUE_RO(name)	\
-	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT
+#define DEFINE_STATIC_KEY_TRUE_RO(name)						\
+	struct static_key_true name __ro_after_init = STATIC_KEY_TRUE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_TRUE(name)	\
 	extern struct static_key_true name
@@ -385,8 +387,9 @@ struct static_key_false {
 #define DEFINE_STATIC_KEY_FALSE(name)	\
 	struct static_key_false name = STATIC_KEY_FALSE_INIT
 
-#define DEFINE_STATIC_KEY_FALSE_RO(name)	\
-	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT
+#define DEFINE_STATIC_KEY_FALSE_RO(name)					\
+	struct static_key_false name __ro_after_init = STATIC_KEY_FALSE_INIT;	\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 /*
  * The _NOINSTR variants are used to tell objtool the static key is allowed to
@@ -400,10 +403,12 @@ struct static_key_false {
  * definition with the rationale.
  */
 #define DEFINE_STATIC_KEY_TRUE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_TRUE(name)
+	DEFINE_STATIC_KEY_TRUE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DEFINE_STATIC_KEY_FALSE_NOINSTR(name)					\
-	DEFINE_STATIC_KEY_FALSE(name)
+	DEFINE_STATIC_KEY_FALSE(name);						\
+	ANNOTATE_NOINSTR_ALLOWED(name)
 
 #define DECLARE_STATIC_KEY_FALSE(name)	\
 	extern struct static_key_false name
diff --git a/include/linux/objtool.h b/include/linux/objtool.h
index 366ad004d794b..2d3661de4cf95 100644
--- a/include/linux/objtool.h
+++ b/include/linux/objtool.h
@@ -34,6 +34,12 @@
 	static void __used __section(".discard.func_stack_frame_non_standard") \
 		*__func_stack_frame_non_standard_##func = func
 
+#define __ANNOTATE_NOINSTR_ALLOWED(key) \
+	static void __used __section(".discard.noinstr_allowed") \
+		*__annotate_noinstr_allowed_##key = &key
+
+#define ANNOTATE_NOINSTR_ALLOWED(key) __ANNOTATE_NOINSTR_ALLOWED(key)
+
 /*
  * STACK_FRAME_NON_STANDARD_FP() is a frame-pointer-specific function ignore
  * for the case where a function is intentionally missing frame pointer setup,
@@ -130,6 +136,7 @@
 #define STACK_FRAME_NON_STANDARD_FP(func)
 #define __ASM_ANNOTATE(label, type) ""
 #define ASM_ANNOTATE(type)
+#define ANNOTATE_NOINSTR_ALLOWED(key)
 #else
 .macro UNWIND_HINT type:req sp_reg=0 sp_offset=0 signal=0
 .endm
diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index ea6ca57e2a829..0d4b16d348501 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -133,6 +133,7 @@
 
 #include <linux/types.h>
 #include <linux/cpu.h>
+#include <linux/objtool.h>
 #include <linux/static_call_types.h>
 
 #ifdef CONFIG_HAVE_STATIC_CALL
@@ -198,6 +199,7 @@ extern long __static_call_return0(void);
 		.func = _func,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_TRAMP(name, _func)
 
 #define DEFINE_STATIC_CALL_NULL(name, _func)				\
@@ -214,6 +216,7 @@ extern long __static_call_return0(void);
 		.func = NULL,						\
 		.type = 1,						\
 	};								\
+	ANNOTATE_NOINSTR_ALLOWED(STATIC_CALL_TRAMP(name));		\
 	ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)
 
 #define DEFINE_STATIC_CALL_RET0(name, _func)				\
diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 9e97fc25b2d8a..991e085e10d95 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -456,6 +456,40 @@ the objtool maintainers.
     these special names and does not use module_init() / module_exit()
     macros to create them.
 
+13. file.o: warning: func()+0x2a: key: non-RO static key usage in noinstr code
+    file.o: warning: func()+0x2a: key: non-RO static call usage in noinstr code
+
+  This means that noinstr function func() uses a static key or
+  static call named 'key' which can be modified at runtime.  This is
+  discouraged because it prevents code patching IPIs from being
+  deferred.
+
+  You have the following options:
+
+  1) Check whether the static key/call in question is only modified
+     during init.  If so, define it as read-only-after-init with
+     DEFINE_STATIC_KEY_*_RO() or DEFINE_STATIC_CALL_RO().
+
+  2) Avoid the runtime patching.  For static keys this can be done by
+     using static_key_enabled() or by getting rid of the static key
+     altogether if performance is not a concern.
+
+     For static calls, something like the following could be done:
+
+       target = static_call_query(foo);
+       if (target == func1)
+	       func1();
+	else if (target == func2)
+		func2();
+	...
+
+  3) Silence the warning by defining the static key/call with
+     DEFINE_STATIC_*_NOINSTR().  This decision should not
+     be taken lightly as it may result in code patching IPIs getting
+     sent to isolated NOHZ_FULL CPUs running in pure userspace.  A
+     comment should be added above the definition explaining the
+     rationale for the decision.
+
 
 If the error doesn't seem to make sense, it could be a bug in objtool.
 Feel free to ask objtool maintainers for help.
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 08e73765059fc..85f50777d7219 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -978,6 +978,45 @@ static int create_direct_call_sections(struct objtool_file *file)
 	return 0;
 }
 
+static int read_noinstr_allowed(struct objtool_file *file)
+{
+	struct section *rsec;
+	struct symbol *sym;
+	struct reloc *reloc;
+
+	rsec = find_section_by_name(file->elf, ".rela.discard.noinstr_allowed");
+	if (!rsec)
+		return 0;
+
+	for_each_reloc(rsec, reloc) {
+		switch (reloc->sym->type) {
+		case STT_OBJECT:
+		case STT_FUNC:
+			sym = reloc->sym;
+			break;
+
+		case STT_SECTION:
+			sym = find_symbol_by_offset(reloc->sym->sec,
+						    reloc_addend(reloc));
+			if (!sym) {
+				WARN_FUNC(reloc->sym->sec, reloc_addend(reloc),
+					  "can't find static key/call symbol");
+				return -1;
+			}
+			break;
+
+		default:
+			WARN("unexpected relocation symbol type in %s: %d",
+			     rsec->name, reloc->sym->type);
+			return -1;
+		}
+
+		sym->noinstr_allowed = 1;
+	}
+
+	return 0;
+}
+
 /*
  * Warnings shouldn't be reported for ignored functions.
  */
@@ -1864,6 +1903,8 @@ static int handle_jump_alt(struct objtool_file *file,
 		return -1;
 	}
 
+	orig_insn->key = special_alt->key;
+
 	if (opts.hack_jump_label && special_alt->key_addend & 2) {
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
@@ -2596,6 +2637,10 @@ static int decode_sections(struct objtool_file *file)
 	if (ret)
 		return ret;
 
+	ret = read_noinstr_allowed(file);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -3365,9 +3410,9 @@ static bool pv_call_dest(struct objtool_file *file, struct instruction *insn)
 	return file->pv_ops[idx].clean;
 }
 
-static inline bool noinstr_call_dest(struct objtool_file *file,
-				     struct instruction *insn,
-				     struct symbol *func)
+static inline bool noinstr_call_allowed(struct objtool_file *file,
+					struct instruction *insn,
+					struct symbol *func)
 {
 	/*
 	 * We can't deal with indirect function calls at present;
@@ -3387,10 +3432,10 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 		return true;
 
 	/*
-	 * If the symbol is a static_call trampoline, we can't tell.
+	 * Only DEFINE_STATIC_CALL_*_RO allowed.
 	 */
 	if (func->static_call_tramp)
-		return true;
+		return func->noinstr_allowed;
 
 	/*
 	 * The __ubsan_handle_*() calls are like WARN(), they only happen when
@@ -3403,14 +3448,29 @@ static inline bool noinstr_call_dest(struct objtool_file *file,
 	return false;
 }
 
+static char *static_call_name(struct symbol *func)
+{
+	return func->name + strlen("__SCT__");
+}
+
 static int validate_call(struct objtool_file *file,
 			 struct instruction *insn,
 			 struct insn_state *state)
 {
-	if (state->noinstr && state->instr <= 0 &&
-	    !noinstr_call_dest(file, insn, insn_call_dest(insn))) {
-		WARN_INSN(insn, "call to %s() leaves .noinstr.text section", call_dest_name(file, insn));
-		return 1;
+	if (state->noinstr && state->instr <= 0) {
+		struct symbol *dest = insn_call_dest(insn);
+
+		if (dest && dest->static_call_tramp) {
+			if (!dest->noinstr_allowed) {
+				WARN_INSN(insn, "%s: non-RO static call usage in noinstr",
+					  static_call_name(dest));
+			}
+
+		} else if (dest && !noinstr_call_allowed(file, insn, dest)) {
+			WARN_INSN(insn, "call to %s() leaves .noinstr.text section",
+				  call_dest_name(file, insn));
+			return 1;
+		}
 	}
 
 	if (state->uaccess && !func_uaccess_safe(insn_call_dest(insn))) {
@@ -3475,6 +3535,17 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static int validate_static_key(struct instruction *insn, struct insn_state *state)
+{
+	if (state->noinstr && state->instr <= 0 && !insn->key->noinstr_allowed) {
+		WARN_INSN(insn, "%s: non-RO static key usage in noinstr",
+			  insn->key->name);
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct instruction *next_insn_to_validate(struct objtool_file *file,
 						 struct instruction *insn)
 {
@@ -3662,6 +3733,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
+		if (insn->key)
+			validate_static_key(insn, &state);
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index 00fb745e72339..d79b08f55bcbc 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -81,6 +81,7 @@ struct instruction {
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
+	struct symbol *key;
 };
 
 static inline struct symbol *insn_func(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index c7c4e87ebe882..b3c11869931fd 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -70,6 +70,7 @@ struct symbol {
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
 	u8 ignore	     : 1;
+	u8 noinstr_allowed   : 1;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 72d09c0adf1a1..e84d704f3f20e 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -18,6 +18,7 @@ struct special_alt {
 	bool group;
 	bool jump_or_nop;
 	u8 key_addend;
+	struct symbol *key;
 
 	struct section *orig_sec;
 	unsigned long orig_off;
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index c80fed8a840ee..d77f3fa4bbbc9 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -110,13 +110,26 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 
 	if (entry->key) {
 		struct reloc *key_reloc;
+		struct symbol *key;
+		s64 key_addend;
 
 		key_reloc = find_reloc_by_dest(elf, sec, offset + entry->key);
 		if (!key_reloc) {
 			ERROR_FUNC(sec, offset + entry->key, "can't find key reloc");
 			return -1;
 		}
-		alt->key_addend = reloc_addend(key_reloc);
+
+		key = key_reloc->sym;
+		key_addend = reloc_addend(key_reloc);
+
+		if (key->type == STT_SECTION)
+			key = find_symbol_by_offset(key->sec, key_addend & ~3);
+
+		/* embedded keys not supported */
+		if (key) {
+			alt->key = key;
+			alt->key_addend = key_addend;
+		}
 	}
 
 	return 0;
-- 
2.49.0


