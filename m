Return-Path: <linux-kselftest+bounces-24839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5CCA17ACB
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 10:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E63841889766
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 09:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0301EE02F;
	Tue, 21 Jan 2025 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/cyZC/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD01E7C16;
	Tue, 21 Jan 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737453539; cv=none; b=h5kPCP3jLBCcx55xcJ/8RpBsduNJDga21ZEgRGnUwuqmwofP8RsvTgeZ0XeyxMgmn50yCE/4DW412hHxYzik3CuAoNsD8fjg+XvePiRO0r1jCQ8I7LiA25khFsL8L3DzSt+f6wxpvQolIJAMUattL0vCitblFSI5q2+P4kskEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737453539; c=relaxed/simple;
	bh=KoOp2bBaEgNdkErfcjUVf9WpGIAQRLrTvLS33Bc8NoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0OunLNjnWg2xdtsNAuwyrEY0F+ASP/J4CWYuQHGn0Y8l2yQrN2AS6mf6cAfgR8pgIWRaX5sMDyfGr701h0nXMMWvJ+6Ev2ASkY5m6rHj6CSRQcdoiU5gbpVF9jh2eABgTspm1pu612WjBFVJ6P07mO0l2KplSt71PO4rMZCTIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/cyZC/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9CC4CEE3;
	Tue, 21 Jan 2025 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737453538;
	bh=KoOp2bBaEgNdkErfcjUVf9WpGIAQRLrTvLS33Bc8NoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s/cyZC/2+b5qlN46eSer1ImrHb9ZvKawbx0SCNqyc80TrZ8glanv9A7kNWdwEr5Wv
	 cilfUKrKcLj7pV0iJOxfKg0uCBgGQ+dSZfau1xxcqqREPdq8QanuA6rkhZwJ1DK+6x
	 jwimt+tv+qCRZ1SfmxmNTdyLbo96UJCTzycvEkvyVmqSMV8u9ei9kRMiybBa196KWi
	 3ihKXb9mZgCM9ThnLH/sDFxiQNcRUbkGOXTrdy4MRkhZWJ2YSVCqPL2XJGmCPCsgy1
	 KaCLpZ65i+w/Eqd7w7BhkQ4Nb08JUKhwvmZFasDG4sVdJvybj0GS+bKvIJvjDUgNq/
	 TtuScPHhkmPkQ==
From: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
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
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
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
	live-patching@vger.kernel.org
Subject: [PATCH v2 06/10] module: introduce MODULE_STATE_GONE
Date: Tue, 21 Jan 2025 11:57:35 +0200
Message-ID: <20250121095739.986006-7-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250121095739.986006-1-rppt@kernel.org>
References: <20250121095739.986006-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

In order to use execmem's API for temporal remapping of the memory
allocated from ROX cache as writable, there is a need to distinguish
between the state when the module is being formed and the state when it is
deconstructed and freed so that when module_memory_free() is called from
error paths during module loading it could restore ROX mappings.

Replace open coded checks for MODULE_STATE_UNFORMED with a helper
function module_is_formed() and add a new MODULE_STATE_GONE that will be
set when the module is deconstructed and freed.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 include/linux/module.h                        |  6 ++++++
 kernel/module/kallsyms.c                      |  8 ++++----
 kernel/module/kdb.c                           |  2 +-
 kernel/module/main.c                          | 19 +++++++++----------
 kernel/module/procfs.c                        |  2 +-
 kernel/tracepoint.c                           |  2 ++
 lib/kunit/test.c                              |  2 ++
 samples/livepatch/livepatch-callbacks-demo.c  |  1 +
 .../test_modules/test_klp_callbacks_demo.c    |  1 +
 .../test_modules/test_klp_callbacks_demo2.c   |  1 +
 .../livepatch/test_modules/test_klp_state.c   |  1 +
 .../livepatch/test_modules/test_klp_state2.c  |  1 +
 12 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b3a643435357..624a5317d5a5 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -320,6 +320,7 @@ enum module_state {
 	MODULE_STATE_COMING,	/* Full formed, running module_init. */
 	MODULE_STATE_GOING,	/* Going away. */
 	MODULE_STATE_UNFORMED,	/* Still setting it up. */
+	MODULE_STATE_GONE,	/* Deconstructing and freeing. */
 };
 
 struct mod_tree_node {
@@ -620,6 +621,11 @@ static inline bool module_is_coming(struct module *mod)
         return mod->state == MODULE_STATE_COMING;
 }
 
+static inline bool module_is_formed(struct module *mod)
+{
+	return mod->state < MODULE_STATE_UNFORMED;
+}
+
 struct module *__module_text_address(unsigned long addr);
 struct module *__module_address(unsigned long addr);
 bool is_module_address(unsigned long addr);
diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
index bf65e0c3c86f..daf9a9b3740f 100644
--- a/kernel/module/kallsyms.c
+++ b/kernel/module/kallsyms.c
@@ -361,7 +361,7 @@ int lookup_module_symbol_name(unsigned long addr, char *symname)
 
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		if (within_module(addr, mod)) {
 			const char *sym;
@@ -389,7 +389,7 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
 	list_for_each_entry_rcu(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		kallsyms = rcu_dereference_sched(mod->kallsyms);
 		if (symnum < kallsyms->num_symtab) {
@@ -441,7 +441,7 @@ static unsigned long __module_kallsyms_lookup_name(const char *name)
 	list_for_each_entry_rcu(mod, &modules, list) {
 		unsigned long ret;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		ret = __find_kallsyms_symbol_value(mod, name);
 		if (ret)
@@ -484,7 +484,7 @@ int module_kallsyms_on_each_symbol(const char *modname,
 	list_for_each_entry(mod, &modules, list) {
 		struct mod_kallsyms *kallsyms;
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		if (modname && strcmp(modname, mod->name))
diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
index 995c32d3698f..14f14700ffc2 100644
--- a/kernel/module/kdb.c
+++ b/kernel/module/kdb.c
@@ -23,7 +23,7 @@ int kdb_lsmod(int argc, const char **argv)
 
 	kdb_printf("Module                  Size  modstruct     Used by\n");
 	list_for_each_entry(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		kdb_printf("%-20s%8u", mod->name, mod->mem[MOD_TEXT].size);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..ad8ef20c120f 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -153,7 +153,7 @@ EXPORT_SYMBOL(unregister_module_notifier);
  */
 static inline int strong_try_module_get(struct module *mod)
 {
-	BUG_ON(mod && mod->state == MODULE_STATE_UNFORMED);
+	BUG_ON(mod && !module_is_formed(mod));
 	if (mod && mod->state == MODULE_STATE_COMING)
 		return -EBUSY;
 	if (try_module_get(mod))
@@ -361,7 +361,7 @@ bool find_symbol(struct find_symbol_arg *fsa)
 			  GPL_ONLY },
 		};
 
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 
 		for (i = 0; i < ARRAY_SIZE(arr); i++)
@@ -386,7 +386,7 @@ struct module *find_module_all(const char *name, size_t len,
 
 	list_for_each_entry_rcu(mod, &modules, list,
 				lockdep_is_held(&module_mutex)) {
-		if (!even_unformed && mod->state == MODULE_STATE_UNFORMED)
+		if (!even_unformed && !module_is_formed(mod))
 			continue;
 		if (strlen(mod->name) == len && !memcmp(mod->name, name, len))
 			return mod;
@@ -457,7 +457,7 @@ bool __is_module_percpu_address(unsigned long addr, unsigned long *can_addr)
 	preempt_disable();
 
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		if (!mod->percpu_size)
 			continue;
@@ -1326,7 +1326,7 @@ static void free_module(struct module *mod)
 	 * that noone uses it while it's being deconstructed.
 	 */
 	mutex_lock(&module_mutex);
-	mod->state = MODULE_STATE_UNFORMED;
+	mod->state = MODULE_STATE_GONE;
 	mutex_unlock(&module_mutex);
 
 	/* Arch-specific cleanup. */
@@ -3048,8 +3048,7 @@ static int module_patient_check_exists(const char *name,
 	if (old == NULL)
 		return 0;
 
-	if (old->state == MODULE_STATE_COMING ||
-	    old->state == MODULE_STATE_UNFORMED) {
+	if (old->state == MODULE_STATE_COMING || !module_is_formed(old)) {
 		/* Wait in case it fails to load. */
 		mutex_unlock(&module_mutex);
 		err = wait_event_interruptible(module_wq,
@@ -3608,7 +3607,7 @@ char *module_flags(struct module *mod, char *buf, bool show_state)
 {
 	int bx = 0;
 
-	BUG_ON(mod->state == MODULE_STATE_UNFORMED);
+	BUG_ON(!module_is_formed(mod));
 	if (!mod->taints && !show_state)
 		goto out;
 	if (mod->taints ||
@@ -3702,7 +3701,7 @@ struct module *__module_address(unsigned long addr)
 	mod = mod_find(addr, &mod_tree);
 	if (mod) {
 		BUG_ON(!within_module(addr, mod));
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			mod = NULL;
 	}
 	return mod;
@@ -3756,7 +3755,7 @@ void print_modules(void)
 	/* Most callers should already have preempt disabled, but make sure */
 	preempt_disable();
 	list_for_each_entry_rcu(mod, &modules, list) {
-		if (mod->state == MODULE_STATE_UNFORMED)
+		if (!module_is_formed(mod))
 			continue;
 		pr_cont(" %s%s", mod->name, module_flags(mod, buf, true));
 	}
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88adb..2c617e6f8bc0 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -79,7 +79,7 @@ static int m_show(struct seq_file *m, void *p)
 	unsigned int size;
 
 	/* We always ignore unformed modules. */
-	if (mod->state == MODULE_STATE_UNFORMED)
+	if (!module_is_formed(mod))
 		return 0;
 
 	size = module_total_size(mod);
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 1848ce7e2976..e94247afb2c6 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -668,6 +668,8 @@ static int tracepoint_module_notify(struct notifier_block *self,
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;
+	case MODULE_STATE_GONE:
+		break;
 	}
 	return notifier_from_errno(ret);
 }
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 089c832e3cdb..54eaed92a2d3 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -836,6 +836,8 @@ static int kunit_module_notify(struct notifier_block *nb, unsigned long val,
 		break;
 	case MODULE_STATE_UNFORMED:
 		break;
+	case MODULE_STATE_GONE:
+		break;
 	}
 
 	return 0;
diff --git a/samples/livepatch/livepatch-callbacks-demo.c b/samples/livepatch/livepatch-callbacks-demo.c
index 11c3f4357812..324bddaef9a6 100644
--- a/samples/livepatch/livepatch-callbacks-demo.c
+++ b/samples/livepatch/livepatch-callbacks-demo.c
@@ -93,6 +93,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
index 3fd8fe1cd1cc..8435e3254f85 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
@@ -16,6 +16,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
index 5417573e80af..78c1fff5d977 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
@@ -16,6 +16,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
index 57a4253acb01..bdebf1d24c98 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
@@ -18,6 +18,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
diff --git a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
index c978ea4d5e67..1a55f84a8eb3 100644
--- a/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
+++ b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
@@ -18,6 +18,7 @@ static const char *const module_state[] = {
 	[MODULE_STATE_COMING]	= "[MODULE_STATE_COMING] Full formed, running module_init",
 	[MODULE_STATE_GOING]	= "[MODULE_STATE_GOING] Going away",
 	[MODULE_STATE_UNFORMED]	= "[MODULE_STATE_UNFORMED] Still setting it up",
+	[MODULE_STATE_GONE]	= "[MODULE_STATE_GONE] Deconstructing and freeing",
 };
 
 static void callback_info(const char *callback, struct klp_object *obj)
-- 
2.45.2


