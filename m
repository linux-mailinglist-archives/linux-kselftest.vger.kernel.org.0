Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D68A5D92E1
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 15:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfJPNs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 09:48:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726689AbfJPNs6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 09:48:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE2AE20663;
        Wed, 16 Oct 2019 13:48:55 +0000 (UTC)
Date:   Wed, 16 Oct 2019 09:48:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     mingo@redhat.com, jpoimboe@redhat.com, jikos@kernel.org,
        pmladek@suse.com, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/3] ftrace: Introduce PERMANENT ftrace_ops flag
Message-ID: <20191016094853.3913f5ae@gandalf.local.home>
In-Reply-To: <20191016113316.13415-2-mbenes@suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
        <20191016113316.13415-2-mbenes@suse.cz>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 16 Oct 2019 13:33:13 +0200
Miroslav Benes <mbenes@suse.cz> wrote:

> Livepatch uses ftrace for redirection to new patched functions. It means
> that if ftrace is disabled, all live patched functions are disabled as
> well. Toggling global 'ftrace_enabled' sysctl thus affect it directly.
> It is not a problem per se, because only administrator can set sysctl
> values, but it still may be surprising.
> 
> Introduce PERMANENT ftrace_ops flag to amend this. If the
> FTRACE_OPS_FL_PERMANENT is set on any ftrace ops, the tracing cannot be
> disabled by disabling ftrace_enabled. Equally, a callback with the flag
> set cannot be registered if ftrace_enabled is disabled.
> 
> Signed-off-by: Miroslav Benes <mbenes@suse.cz>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
> ---
>

I pulled in this patch as is, but then I realized we have a race. This
race has been there before this patch series, and actually, been there
since the dawn of ftrace.

I realized that the user can modify ftrace_enabled out of lock context.
That is, the ftrace_enabled is modified directly from the sysctl code,
without taking the ftrace_lock mutex. Which means if the user was
starting and stopping function tracing while playing with the
ftrace_enabled switch, it could potentially cause an accounting failure.

I'm going to apply this patch on top of yours. It reverses the role of
how ftrace_enabled is set in the sysctl handler. Instead of having it
directly modify ftrace_enabled, I have it modify a new variable called
sysctl_ftrace_enabled. I no longer need the last_ftrace_enabled. This
way we only need to set or disable ftrace_enabled on a change and if
all conditions are met.

Thoughts?

-- Steve

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8385cafe4f9f..aa2e2c7cef9e 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -79,6 +79,7 @@ static inline int ftrace_mod_get_kallsym(unsigned int symnum, unsigned long *val
 #ifdef CONFIG_FUNCTION_TRACER
 
 extern int ftrace_enabled;
+extern int sysctl_ftrace_enabled;
 extern int
 ftrace_enable_sysctl(struct ctl_table *table, int write,
 		     void __user *buffer, size_t *lenp,
@@ -638,6 +639,7 @@ static inline void tracer_disable(void)
 {
 #ifdef CONFIG_FUNCTION_TRACER
 	ftrace_enabled = 0;
+	sysctl_ftrace_enabled = 0;
 #endif
 }
 
@@ -651,6 +653,7 @@ static inline int __ftrace_enabled_save(void)
 #ifdef CONFIG_FUNCTION_TRACER
 	int saved_ftrace_enabled = ftrace_enabled;
 	ftrace_enabled = 0;
+	sysctl_ftrace_enabled = 0;
 	return saved_ftrace_enabled;
 #else
 	return 0;
@@ -661,6 +664,7 @@ static inline void __ftrace_enabled_restore(int enabled)
 {
 #ifdef CONFIG_FUNCTION_TRACER
 	ftrace_enabled = enabled;
+	sysctl_ftrace_enabled = enabled;
 #endif
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 00fcea236eba..773fdfc6c645 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -648,7 +648,7 @@ static struct ctl_table kern_table[] = {
 #ifdef CONFIG_FUNCTION_TRACER
 	{
 		.procname	= "ftrace_enabled",
-		.data		= &ftrace_enabled,
+		.data		= &sysctl_ftrace_enabled,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
 		.proc_handler	= ftrace_enable_sysctl,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index dacb8b50a263..b55c9a4e2b5b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -88,7 +88,7 @@ struct ftrace_ops ftrace_list_end __read_mostly = {
 
 /* ftrace_enabled is a method to turn ftrace on or off */
 int ftrace_enabled __read_mostly;
-static int last_ftrace_enabled;
+int sysctl_ftrace_enabled __read_mostly;
 
 /* Current function tracing op */
 struct ftrace_ops *function_trace_op __read_mostly = &ftrace_list_end;
@@ -6221,7 +6221,7 @@ void __init ftrace_init(void)
 	pr_info("ftrace: allocating %ld entries in %ld pages\n",
 		count, count / ENTRIES_PER_PAGE + 1);
 
-	last_ftrace_enabled = ftrace_enabled = 1;
+	sysctl_ftrace_enabled = ftrace_enabled = 1;
 
 	ret = ftrace_process_locs(NULL,
 				  __start_mcount_loc,
@@ -6265,6 +6265,7 @@ struct ftrace_ops global_ops = {
 static int __init ftrace_nodyn_init(void)
 {
 	ftrace_enabled = 1;
+	sysctl_ftrace_enabled = 1;
 	return 0;
 }
 core_initcall(ftrace_nodyn_init);
@@ -6714,6 +6715,7 @@ void ftrace_kill(void)
 {
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
+	sysctl_ftrace_enabled = 0;
 	ftrace_trace_function = ftrace_stub;
 }
 
@@ -6796,10 +6798,12 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
 
-	if (ret || !write || (last_ftrace_enabled == !!ftrace_enabled))
+	if (ret || !write || (ftrace_enabled == !!sysctl_ftrace_enabled))
 		goto out;
 
-	if (ftrace_enabled) {
+	if (sysctl_ftrace_enabled) {
+
+		ftrace_enabled = true;
 
 		/* we are starting ftrace again */
 		if (rcu_dereference_protected(ftrace_ops_list,
@@ -6810,19 +6814,21 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 	} else {
 		if (is_permanent_ops_registered()) {
-			ftrace_enabled = true;
 			ret = -EBUSY;
 			goto out;
 		}
 
+		ftrace_enabled = false;
+
 		/* stopping ftrace calls (just send to ftrace_stub) */
 		ftrace_trace_function = ftrace_stub;
 
 		ftrace_shutdown_sysctl();
 	}
 
-	last_ftrace_enabled = !!ftrace_enabled;
  out:
+	sysctl_ftrace_enabled = ftrace_enabled;
+
 	mutex_unlock(&ftrace_lock);
 	return ret;
 }
