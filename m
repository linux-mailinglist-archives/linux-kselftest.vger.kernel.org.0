Return-Path: <linux-kselftest+bounces-25187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 060E9A1C6D0
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 08:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81C2018831C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 26 Jan 2025 07:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B12145A03;
	Sun, 26 Jan 2025 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3CR+WgX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408313D53B;
	Sun, 26 Jan 2025 07:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737877734; cv=none; b=R/NqTcFChbJWl9dMgZShGMjT1vA45f8Zt4CjECyDek9JSEpXLdeeZv2hBur3nkoRYIF4JBWQhBogJ8E9ivNMZcnKViYvbBYJxOusnSBWrby51zTruqm7ApRwlVAu13O3mQQ9CNgTQjY42qmw4CTZm/7FJTMT0/vq4zkwGHQQnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737877734; c=relaxed/simple;
	bh=xwDxvyvlbxvJeVZzj9KMpy3H3vAeFVvQXS+rKT0mI/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C+pmOClwswQE8yjr3N10Tg7cFeavQhwR3BtkxGdoYM3wHtQgSiSOPfGI3xCid7MprsNukrJC7MXjqx8q0E/9I2hsf61LIunpM2meNvRD4THkVrQv44tymkH+uIxI6M5OnJoHwjte/tcP4QWd2qPCBLNYgMf1p+0nI4NzuYCGYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3CR+WgX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6C1C4CED3;
	Sun, 26 Jan 2025 07:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737877733;
	bh=xwDxvyvlbxvJeVZzj9KMpy3H3vAeFVvQXS+rKT0mI/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3CR+WgXKXNwHo6aho9r7aFhu/902ehjGLuyyhJ2IJ4YicSiuQmg8Aa/cYOcI8k66
	 4rkN37YvOcCebfKeVcMHlpqLg2FCT7Ee01RqHUM0QscEx5tRiwXhjcrphJQyVRyn0y
	 TDOIugWfdaExO9pNoI/3ND43Iac9UzNr4haiUbRc0gqXt/EvIL7c0eUpT2jT4RluwW
	 HPOqbIrhDyptBfsVw0Vm6veEfta+nNcZJWsu+BfPkK4VUo0Pgw/1QdNj6r9jf1gpYD
	 WozkmdxsLheJRZRyXUBIi8cEgOfa2Ev0U0PF4HwQZ8ILrNnoRjYgJuZC5tqHsEKwB2
	 ZVU4+OVsF7D8g==
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
Subject: [PATCH v3 6/9] module: switch to execmem API for remapping as RW and restoring ROX
Date: Sun, 26 Jan 2025 09:47:30 +0200
Message-ID: <20250126074733.1384926-7-rppt@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250126074733.1384926-1-rppt@kernel.org>
References: <20250126074733.1384926-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Instead of using writable copy for module text sections, temporarily remap
the memory allocated from execmem's ROX cache as writable and restore its
ROX permissions after the module is formed.

This will allow removing nasty games with writable copy in alternatives
patching on x86.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/module.h       |  8 +---
 include/linux/moduleloader.h |  4 --
 kernel/module/main.c         | 78 ++++++++++--------------------------
 kernel/module/strict_rwx.c   |  9 +++--
 4 files changed, 27 insertions(+), 72 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b3a643435357..6a24e9395cb2 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -367,7 +367,6 @@ enum mod_mem_type {
 
 struct module_memory {
 	void *base;
-	void *rw_copy;
 	bool is_rox;
 	unsigned int size;
 
@@ -769,14 +768,9 @@ static inline bool is_livepatch_module(struct module *mod)
 
 void set_module_sig_enforced(void);
 
-void *__module_writable_address(struct module *mod, void *loc);
-
 static inline void *module_writable_address(struct module *mod, void *loc)
 {
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_EXECMEM_ROX) || !mod ||
-	    mod->state != MODULE_STATE_UNFORMED)
-		return loc;
-	return __module_writable_address(mod, loc);
+	return loc;
 }
 
 #else /* !CONFIG_MODULES... */
diff --git a/include/linux/moduleloader.h b/include/linux/moduleloader.h
index 1f5507ba5a12..e395461d59e5 100644
--- a/include/linux/moduleloader.h
+++ b/include/linux/moduleloader.h
@@ -108,10 +108,6 @@ int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *mod);
 
-int module_post_finalize(const Elf_Ehdr *hdr,
-			 const Elf_Shdr *sechdrs,
-			 struct module *mod);
-
 #ifdef CONFIG_MODULES
 void flush_module_init_free_work(void);
 #else
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cb..4a02503836d7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -1221,18 +1221,6 @@ void __weak module_arch_freeing_init(struct module *mod)
 {
 }
 
-void *__module_writable_address(struct module *mod, void *loc)
-{
-	for_class_mod_mem_type(type, text) {
-		struct module_memory *mem = &mod->mem[type];
-
-		if (loc >= mem->base && loc < mem->base + mem->size)
-			return loc + (mem->rw_copy - mem->base);
-	}
-
-	return loc;
-}
-
 static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 {
 	unsigned int size = PAGE_ALIGN(mod->mem[type].size);
@@ -1250,21 +1238,15 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	if (!ptr)
 		return -ENOMEM;
 
-	mod->mem[type].base = ptr;
-
 	if (execmem_is_rox(execmem_type)) {
-		ptr = vzalloc(size);
+		int err = execmem_make_temp_rw(ptr, size);
 
-		if (!ptr) {
-			execmem_free(mod->mem[type].base);
+		if (err) {
+			execmem_free(ptr);
 			return -ENOMEM;
 		}
 
-		mod->mem[type].rw_copy = ptr;
 		mod->mem[type].is_rox = true;
-	} else {
-		mod->mem[type].rw_copy = mod->mem[type].base;
-		memset(mod->mem[type].base, 0, size);
 	}
 
 	/*
@@ -1280,16 +1262,26 @@ static int module_memory_alloc(struct module *mod, enum mod_mem_type type)
 	 */
 	kmemleak_not_leak(ptr);
 
+	memset(ptr, 0, size);
+	mod->mem[type].base = ptr;
+
 	return 0;
 }
 
+static void module_memory_restore_rox(struct module *mod)
+{
+	for_class_mod_mem_type(type, text) {
+		struct module_memory *mem = &mod->mem[type];
+
+		if (mem->is_rox)
+			execmem_restore_rox(mem->base, mem->size);
+	}
+}
+
 static void module_memory_free(struct module *mod, enum mod_mem_type type)
 {
 	struct module_memory *mem = &mod->mem[type];
 
-	if (mem->is_rox)
-		vfree(mem->rw_copy);
-
 	execmem_free(mem->base);
 }
 
@@ -2561,7 +2553,6 @@ static int move_module(struct module *mod, struct load_info *info)
 	for_each_mod_mem_type(type) {
 		if (!mod->mem[type].size) {
 			mod->mem[type].base = NULL;
-			mod->mem[type].rw_copy = NULL;
 			continue;
 		}
 
@@ -2578,7 +2569,6 @@ static int move_module(struct module *mod, struct load_info *info)
 		void *dest;
 		Elf_Shdr *shdr = &info->sechdrs[i];
 		const char *sname;
-		unsigned long addr;
 
 		if (!(shdr->sh_flags & SHF_ALLOC))
 			continue;
@@ -2599,14 +2589,12 @@ static int move_module(struct module *mod, struct load_info *info)
 				ret = PTR_ERR(dest);
 				goto out_err;
 			}
-			addr = (unsigned long)dest;
 			codetag_section_found = true;
 		} else {
 			enum mod_mem_type type = shdr->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
 			unsigned long offset = shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK;
 
-			addr = (unsigned long)mod->mem[type].base + offset;
-			dest = mod->mem[type].rw_copy + offset;
+			dest = mod->mem[type].base + offset;
 		}
 
 		if (shdr->sh_type != SHT_NOBITS) {
@@ -2629,13 +2617,14 @@ static int move_module(struct module *mod, struct load_info *info)
 		 * users of info can keep taking advantage and using the newly
 		 * minted official memory area.
 		 */
-		shdr->sh_addr = addr;
+		shdr->sh_addr = (unsigned long)dest;
 		pr_debug("\t0x%lx 0x%.8lx %s\n", (long)shdr->sh_addr,
 			 (long)shdr->sh_size, info->secstrings + shdr->sh_name);
 	}
 
 	return 0;
 out_err:
+	module_memory_restore_rox(mod);
 	for (t--; t >= 0; t--)
 		module_memory_free(mod, t);
 	if (codetag_section_found)
@@ -2782,17 +2771,8 @@ int __weak module_finalize(const Elf_Ehdr *hdr,
 	return 0;
 }
 
-int __weak module_post_finalize(const Elf_Ehdr *hdr,
-				const Elf_Shdr *sechdrs,
-				struct module *me)
-{
-	return 0;
-}
-
 static int post_relocation(struct module *mod, const struct load_info *info)
 {
-	int ret;
-
 	/* Sort exception table now relocations are done. */
 	sort_extable(mod->extable, mod->extable + mod->num_exentries);
 
@@ -2804,24 +2784,7 @@ static int post_relocation(struct module *mod, const struct load_info *info)
 	add_kallsyms(mod, info);
 
 	/* Arch-specific module finalizing. */
-	ret = module_finalize(info->hdr, info->sechdrs, mod);
-	if (ret)
-		return ret;
-
-	for_each_mod_mem_type(type) {
-		struct module_memory *mem = &mod->mem[type];
-
-		if (mem->is_rox) {
-			if (!execmem_update_copy(mem->base, mem->rw_copy,
-						 mem->size))
-				return -ENOMEM;
-
-			vfree(mem->rw_copy);
-			mem->rw_copy = NULL;
-		}
-	}
-
-	return module_post_finalize(info->hdr, info->sechdrs, mod);
+	return module_finalize(info->hdr, info->sechdrs, mod);
 }
 
 /* Call module constructors. */
@@ -3417,6 +3380,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 				       mod->mem[type].size);
 	}
 
+	module_memory_restore_rox(mod);
 	module_deallocate(mod, info);
  free_copy:
 	/*
diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
index 239e5013359d..ce47b6346f27 100644
--- a/kernel/module/strict_rwx.c
+++ b/kernel/module/strict_rwx.c
@@ -9,6 +9,7 @@
 #include <linux/mm.h>
 #include <linux/vmalloc.h>
 #include <linux/set_memory.h>
+#include <linux/execmem.h>
 #include "internal.h"
 
 static int module_set_memory(const struct module *mod, enum mod_mem_type type,
@@ -32,12 +33,12 @@ static int module_set_memory(const struct module *mod, enum mod_mem_type type,
 int module_enable_text_rox(const struct module *mod)
 {
 	for_class_mod_mem_type(type, text) {
+		const struct module_memory *mem = &mod->mem[type];
 		int ret;
 
-		if (mod->mem[type].is_rox)
-			continue;
-
-		if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
+		if (mem->is_rox)
+			ret = execmem_restore_rox(mem->base, mem->size);
+		else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
 			ret = module_set_memory(mod, type, set_memory_rox);
 		else
 			ret = module_set_memory(mod, type, set_memory_x);
-- 
2.45.2


