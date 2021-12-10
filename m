Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD34700EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 13:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241272AbhLJMs1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 07:48:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238062AbhLJMs0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 07:48:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C48072110A;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1639140290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqnoMnVsPEgCTF//f9XvmItbCN7gB9B+oyMmydji6CA=;
        b=gxwRcWfN4xyDOnufvTNJQFacfP3wNCT1GiTeZD09D98C37UQkfvGIW7VCh5cTX3p95olGD
        4gWbE22fJvHzHx0knctvC3AXt6QUlGEzs4nve1IlXMTLkJjx1I6PS4rOG8UtGUjEh0vr19
        zWFoMw0+yybsglKdsxhaJPfuPxZYSRo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1639140290;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JqnoMnVsPEgCTF//f9XvmItbCN7gB9B+oyMmydji6CA=;
        b=S8RpakyiJW02J4NkMNRksNMM3JpPPNJkDYg4hg2jKQCJCz+Xj1tdJTHD+Shhn9WqTj4Tgu
        IyumEnAgnn3qOTDg==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id AB8D5A3B85;
        Fri, 10 Dec 2021 12:44:50 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 1/2] livepatch: Allow user to specify functions to search for on a stack
Date:   Fri, 10 Dec 2021 13:44:48 +0100
Message-Id: <20211210124449.21537-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211210124449.21537-1-mbenes@suse.cz>
References: <20211210124449.21537-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

livepatch's consistency model requires that no live patched function
must be found on any task's stack during a transition process after a
live patch is applied. It is achieved by walking through stacks of all
blocked tasks.

The user might also want to define more functions to search for without
them being patched at all. It may either help with preparing a live
patch, which would otherwise require adding more functions just to
achieve the consistency, or it can be used to overcome deficiencies the
stack checking inherently has.

Consider the following example, in which GCC may optimize function
parent() so that a part of it is moved to a different section
(child.cold()) and parent() jumps to it. If both parent() and child2()
are to patching targets, things can break easily if a task sleeps in
child.cold() and new patched child2() changes ABI. parent() is not found
on the stack, child.cold() jumps back to parent() eventually and new
child2() is called.

  parent():		/* to-be-patched */
    ...
    jmp child.cold()	/* cannot be patched */
      ...
      schedule()
      ...
      jmp <back>
    ...
    call child2()	/* to-be-patched */
    ...

Allow the user to specify such functions (parent() in the example) using
stack_only member of struct klp_func.

The functions are still shown in sysfs directory. Nop objects are not
created for them.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 include/linux/livepatch.h     |  3 +++
 kernel/livepatch/core.c       | 28 +++++++++++++++++++++++++++-
 kernel/livepatch/patch.c      |  6 ++++++
 kernel/livepatch/transition.c |  5 ++++-
 4 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 2614247a9781..d09f89fe7921 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -29,6 +29,8 @@
  * @new_func:	pointer to the patched function code
  * @old_sympos: a hint indicating which symbol position the old function
  *		can be found (optional)
+ * @stack_only:	only search for the function (specified by old_name) on any
+ * 		task's stack
  * @old_func:	pointer to the function being patched
  * @kobj:	kobject for sysfs resources
  * @node:	list node for klp_object func_list
@@ -66,6 +68,7 @@ struct klp_func {
 	 * in kallsyms for the given object is used.
 	 */
 	unsigned long old_sympos;
+	bool stack_only;
 
 	/* internal */
 	void *old_func;
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 335d988bd811..62ff4180dc9b 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -89,6 +89,10 @@ static struct klp_func *klp_find_func(struct klp_object *obj,
 	struct klp_func *func;
 
 	klp_for_each_func(obj, func) {
+		/* Do not create nop klp_func for stack_only function */
+		if (func->stack_only)
+			return func;
+
 		if ((strcmp(old_func->old_name, func->old_name) == 0) &&
 		    (old_func->old_sympos == func->old_sympos)) {
 			return func;
@@ -499,6 +503,17 @@ static struct klp_func *klp_alloc_func_nop(struct klp_func *old_func,
 	return func;
 }
 
+static bool klp_is_object_stack_only(struct klp_object *old_obj)
+{
+	struct klp_func *old_func;
+
+	klp_for_each_func(old_obj, old_func)
+		if (!old_func->stack_only)
+			return false;
+
+	return true;
+}
+
 static int klp_add_object_nops(struct klp_patch *patch,
 			       struct klp_object *old_obj)
 {
@@ -508,6 +523,13 @@ static int klp_add_object_nops(struct klp_patch *patch,
 	obj = klp_find_object(patch, old_obj);
 
 	if (!obj) {
+		/*
+		 * Do not create nop klp_object for old_obj which contains
+		 * stack_only functions only.
+		 */
+		if (klp_is_object_stack_only(old_obj))
+			return 0;
+
 		obj = klp_alloc_object_dynamic(old_obj->name, patch);
 		if (!obj)
 			return -ENOMEM;
@@ -723,8 +745,9 @@ static int klp_init_func(struct klp_object *obj, struct klp_func *func)
 	/*
 	 * NOPs get the address later. The patched module must be loaded,
 	 * see klp_init_object_loaded().
+	 * stack_only functions do not get new_func addresses at all.
 	 */
-	if (!func->new_func && !func->nop)
+	if (!func->new_func && !func->nop && !func->stack_only)
 		return -EINVAL;
 
 	if (strlen(func->old_name) >= KSYM_NAME_LEN)
@@ -804,6 +827,9 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		if (func->nop)
 			func->new_func = func->old_func;
 
+		if (func->stack_only)
+			continue;
+
 		ret = kallsyms_lookup_size_offset((unsigned long)func->new_func,
 						  &func->new_size, NULL);
 		if (!ret) {
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index fe316c021d73..221ed691cc7f 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -250,6 +250,9 @@ static void __klp_unpatch_object(struct klp_object *obj, bool nops_only)
 		if (nops_only && !func->nop)
 			continue;
 
+		if (func->stack_only)
+			continue;
+
 		if (func->patched)
 			klp_unpatch_func(func);
 	}
@@ -273,6 +276,9 @@ int klp_patch_object(struct klp_object *obj)
 		return -EINVAL;
 
 	klp_for_each_func(obj, func) {
+		if (func->stack_only)
+			continue;
+
 		ret = klp_patch_func(func);
 		if (ret) {
 			klp_unpatch_object(obj);
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5683ac0d2566..fa0630fcab1a 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 	for (i = 0; i < nr_entries; i++) {
 		address = entries[i];
 
-		if (klp_target_state == KLP_UNPATCHED) {
+		if (func->stack_only) {
+			func_addr = (unsigned long)func->old_func;
+			func_size = func->old_size;
+		} else if (klp_target_state == KLP_UNPATCHED) {
 			 /*
 			  * Check for the to-be-unpatched function
 			  * (the func itself).
-- 
2.34.1

