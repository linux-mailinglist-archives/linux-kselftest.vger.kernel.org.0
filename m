Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 373C6456C0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhKSJGe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 04:06:34 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53980 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbhKSJGb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 04:06:31 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF96921637;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637312608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37oDjltHx1iDdukyCIaYT3+MO3HlBauFF/E+7rA0K9Y=;
        b=ZuFF3kFTYndokknLUM+/OWKLYmo+GN8O/QFQ4EA/XAhT2dORmzb+Jij3P8HGQnteUu2Q02
        2SjO5N65Qz3F3RZ1nBC/F53PHmneirQgsTZN3Yvufv3XeHUI9petzDN5aaNztdEgcIzB2u
        QH4HVvha0CwcjrhFpFMHAzkYu1+vTJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637312608;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=37oDjltHx1iDdukyCIaYT3+MO3HlBauFF/E+7rA0K9Y=;
        b=UdgU843KQuTzzhlG1tDQKNyhU1/RDXmCitHG/V+f8yT1hNKPk8e+Ga3lRjqe7Th9iVvHke
        eD5n6TphzFw2Q8Dw==
Received: from san.suse.cz (san.suse.cz [10.100.12.79])
        by relay2.suse.de (Postfix) with ESMTP id B84BDA3B84;
        Fri, 19 Nov 2021 09:03:28 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 2/3] livepatch: Allow user to specify functions to search for on a stack
Date:   Fri, 19 Nov 2021 10:03:26 +0100
Message-Id: <20211119090327.12811-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211119090327.12811-1-mbenes@suse.cz>
References: <20211119090327.12811-1-mbenes@suse.cz>
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
patch, which would otherwise require additional touches to achieve the
consistency, or it can be used to overcome deficiencies the stack
checking inherently has. For example, GCC may optimize a function so
that a part of it is moved to a different section and the function would
jump to it. This child function would not be found on a stack in this
case, but it may be important to search for it so that, again, the
consistency is achieved.

Allow the user to specify such functions on klp_object level.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 include/linux/livepatch.h     | 11 +++++++++++
 kernel/livepatch/core.c       | 16 ++++++++++++++++
 kernel/livepatch/transition.c | 21 ++++++++++++++++-----
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
index 2614247a9781..89df578af8c3 100644
--- a/include/linux/livepatch.h
+++ b/include/linux/livepatch.h
@@ -106,9 +106,11 @@ struct klp_callbacks {
  * struct klp_object - kernel object structure for live patching
  * @name:	module name (or NULL for vmlinux)
  * @funcs:	function entries for functions to be patched in the object
+ * @funcs_stack:	function entries for functions to be stack checked
  * @callbacks:	functions to be executed pre/post (un)patching
  * @kobj:	kobject for sysfs resources
  * @func_list:	dynamic list of the function entries
+ * @func_stack_list:	dynamic list of the function entries for stack checking
  * @node:	list node for klp_patch obj_list
  * @mod:	kernel module associated with the patched object
  *		(NULL for vmlinux)
@@ -119,11 +121,13 @@ struct klp_object {
 	/* external */
 	const char *name;
 	struct klp_func *funcs;
+	struct klp_func *funcs_stack;
 	struct klp_callbacks callbacks;
 
 	/* internal */
 	struct kobject kobj;
 	struct list_head func_list;
+	struct list_head func_stack_list;
 	struct list_head node;
 	struct module *mod;
 	bool dynamic;
@@ -187,12 +191,19 @@ struct klp_patch {
 	     func->old_name || func->new_func || func->old_sympos; \
 	     func++)
 
+#define klp_for_each_func_stack_static(obj, func) \
+	for (func = obj->funcs_stack; \
+	     func && (func->old_name || func->old_sympos); func++)
+
 #define klp_for_each_func_safe(obj, func, tmp_func)			\
 	list_for_each_entry_safe(func, tmp_func, &obj->func_list, node)
 
 #define klp_for_each_func(obj, func)	\
 	list_for_each_entry(func, &obj->func_list, node)
 
+#define klp_for_each_func_stack(obj, func)	\
+	list_for_each_entry(func, &obj->func_stack_list, node)
+
 int klp_enable_patch(struct klp_patch *);
 
 /* Called from the module loader during module coming/going states */
diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
index 3d8e3caf9f92..86fc73a06844 100644
--- a/kernel/livepatch/core.c
+++ b/kernel/livepatch/core.c
@@ -825,6 +825,12 @@ static int klp_init_object_loaded(struct klp_patch *patch,
 		}
 	}
 
+	klp_for_each_func_stack(obj, func) {
+		ret = klp_init_old_func(obj, func);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -853,6 +859,11 @@ static int klp_init_object(struct klp_patch *patch, struct klp_object *obj)
 			return ret;
 	}
 
+	klp_for_each_func_stack(obj, func) {
+		if (strlen(func->old_name) >= KSYM_NAME_LEN)
+			return -EINVAL;
+	}
+
 	if (klp_is_object_loaded(obj))
 		ret = klp_init_object_loaded(patch, obj);
 
@@ -870,6 +881,7 @@ static void klp_init_object_early(struct klp_patch *patch,
 				  struct klp_object *obj)
 {
 	INIT_LIST_HEAD(&obj->func_list);
+	INIT_LIST_HEAD(&obj->func_stack_list);
 	kobject_init(&obj->kobj, &klp_ktype_object);
 	list_add_tail(&obj->node, &patch->obj_list);
 }
@@ -899,6 +911,10 @@ static int klp_init_patch_early(struct klp_patch *patch)
 		klp_for_each_func_static(obj, func) {
 			klp_init_func_early(obj, func);
 		}
+
+		klp_for_each_func_stack_static(obj, func) {
+			list_add_tail(&func->node, &obj->func_stack_list);
+		}
 	}
 
 	if (!try_module_get(patch->mod))
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 5683ac0d2566..be7afc5dc275 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -200,7 +200,10 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
 	for (i = 0; i < nr_entries; i++) {
 		address = entries[i];
 
-		if (klp_target_state == KLP_UNPATCHED) {
+		if (!func->new_func) {
+			func_addr = (unsigned long)func->old_func;
+			func_size = func->old_size;
+		} else if (klp_target_state == KLP_UNPATCHED) {
 			 /*
 			  * Check for the to-be-unpatched function
 			  * (the func itself).
@@ -256,14 +259,22 @@ static int klp_check_stack(struct task_struct *task, const char **oldname)
 			continue;
 		klp_for_each_func(obj, func) {
 			ret = klp_check_stack_func(func, entries, nr_entries);
-			if (ret) {
-				*oldname = func->old_name;
-				return -EADDRINUSE;
-			}
+			if (ret)
+				goto err;
+		}
+
+		klp_for_each_func_stack(obj, func) {
+			ret = klp_check_stack_func(func, entries, nr_entries);
+			if (ret)
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	*oldname = func->old_name;
+	return -EADDRINUSE;
 }
 
 static int klp_check_and_switch_task(struct task_struct *task, void *arg)
-- 
2.33.1

