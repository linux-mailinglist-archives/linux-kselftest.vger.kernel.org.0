Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1111CD8FA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 13:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391122AbfJPLdV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 07:33:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:35606 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728617AbfJPLdU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 07:33:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D7C8EB1A3;
        Wed, 16 Oct 2019 11:33:18 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v3 1/3] ftrace: Introduce PERMANENT ftrace_ops flag
Date:   Wed, 16 Oct 2019 13:33:13 +0200
Message-Id: <20191016113316.13415-2-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016113316.13415-1-mbenes@suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Livepatch uses ftrace for redirection to new patched functions. It means
that if ftrace is disabled, all live patched functions are disabled as
well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
It is not a problem per se, because only administrator can set sysctl
values, but it still may be surprising.

Introduce PERMANENT ftrace_ops flag to amend this. If the
FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
disabled by disabling ftrace_enabled. Equally, a callback with the flag
set cannot be registered if ftrace_enabled is disabled.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
---
 Documentation/trace/ftrace-uses.rst |  8 ++++++++
 Documentation/trace/ftrace.rst      |  4 +++-
 include/linux/ftrace.h              |  3 +++
 kernel/livepatch/patch.c            |  3 ++-
 kernel/trace/ftrace.c               | 23 +++++++++++++++++++++--
 5 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index 1fbc69894eed..740bd0224d35 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -170,6 +170,14 @@ FTRACE_OPS_FL_RCU
 	a callback may be executed and RCU synchronization will not protect
 	it.
 
+FTRACE_OPS_FL_PERMANENT
+        If this is set on any ftrace ops, then the tracing cannot disabled by
+        writing 0 to the proc sysctl ftrace_enabled. Equally, a callback with
+        the flag set cannot be registered if ftrace_enabled is 0.
+
+        Livepatch uses it not to lose the function redirection, so the system
+        stays protected.
+
 
 Filtering which functions to trace
 ==================================
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index e3060eedb22d..d2b5657ed33e 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -2976,7 +2976,9 @@ Note, the proc sysctl ftrace_enable is a big on/off switch for the
 function tracer. By default it is enabled (when function tracing is
 enabled in the kernel). If it is disabled, all function tracing is
 disabled. This includes not only the function tracers for ftrace, but
-also for any other uses (perf, kprobes, stack tracing, profiling, etc).
+also for any other uses (perf, kprobes, stack tracing, profiling, etc). It
+cannot be disabled if there is a callback with FTRACE_OPS_FL_PERMANENT set
+registered.
 
 Please disable this with care.
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8a8cb3c401b2..8385cafe4f9f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -142,6 +142,8 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  * PID     - Is affected by set_ftrace_pid (allows filtering on those pids)
  * RCU     - Set when the ops can only be called when RCU is watching.
  * TRACE_ARRAY - The ops->private points to a trace_array descriptor.
+ * PERMANENT - Set when the ops is permanent and should not be affected by
+ *             ftrace_enabled.
  */
 enum {
 	FTRACE_OPS_FL_ENABLED			= 1 << 0,
@@ -160,6 +162,7 @@ enum {
 	FTRACE_OPS_FL_PID			= 1 << 13,
 	FTRACE_OPS_FL_RCU			= 1 << 14,
 	FTRACE_OPS_FL_TRACE_ARRAY		= 1 << 15,
+	FTRACE_OPS_FL_PERMANENT                 = 1 << 16,
 };
 
 #ifdef CONFIG_DYNAMIC_FTRACE
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index bd43537702bd..b552cf2d85f8 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -196,7 +196,8 @@ static int klp_patch_func(struct klp_func *func)
 		ops->fops.func = klp_ftrace_handler;
 		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
 				  FTRACE_OPS_FL_DYNAMIC |
-				  FTRACE_OPS_FL_IPMODIFY;
+				  FTRACE_OPS_FL_IPMODIFY |
+				  FTRACE_OPS_FL_PERMANENT;
 
 		list_add(&ops->node, &klp_ops);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 62a50bf399d6..5c8ad14f313a 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -325,6 +325,8 @@ int __register_ftrace_function(struct ftrace_ops *ops)
 	if (ops->flags & FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED)
 		ops->flags |= FTRACE_OPS_FL_SAVE_REGS;
 #endif
+	if (!ftrace_enabled && (ops->flags & FTRACE_OPS_FL_PERMANENT))
+		return -EBUSY;
 
 	if (!core_kernel_data((unsigned long)ops))
 		ops->flags |= FTRACE_OPS_FL_DYNAMIC;
@@ -6723,6 +6725,18 @@ int unregister_ftrace_function(struct ftrace_ops *ops)
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_function);
 
+static bool is_permanent_ops_registered(void)
+{
+	struct ftrace_ops *op;
+
+	do_for_each_ftrace_op(op, ftrace_ops_list) {
+		if (op->flags & FTRACE_OPS_FL_PERMANENT)
+			return true;
+	} while_for_each_ftrace_op(op);
+
+	return false;
+}
+
 int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void __user *buffer, size_t *lenp,
@@ -6740,8 +6754,6 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
 		goto out;
 
-	last_ftrace_enabled = !!ftrace_enabled;
-
 	if (ftrace_enabled) {
 
 		/* we are starting ftrace again */
@@ -6752,12 +6764,19 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 		ftrace_startup_sysctl();
 
 	} else {
+		if (is_permanent_ops_registered()) {
+			ftrace_enabled = true;
+			ret = -EBUSY;
+			goto out;
+		}
+
 		/* stopping ftrace calls (just send to ftrace_stub) */
 		ftrace_trace_function = ftrace_stub;
 
 		ftrace_shutdown_sysctl();
 	}
 
+	last_ftrace_enabled = !!ftrace_enabled;
  out:
 	mutex_unlock(&ftrace_lock);
 	return ret;
-- 
2.23.0

