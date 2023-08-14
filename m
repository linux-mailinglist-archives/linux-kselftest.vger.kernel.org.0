Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3421E77B470
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjHNImX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjHNIlx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:53 -0400
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968FE129;
        Mon, 14 Aug 2023 01:41:50 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4RPSYl1sPZz9sSk;
        Mon, 14 Aug 2023 10:41:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYw3VsM//wPuCzVBeDBi0yiXj1DgwyxLCg5CNbEnouM=;
        b=FW4pAGCjQrxS9kPO8UYvY2wfmvyzfNE3ar8tAhYT8AGZbuNMo3b1ODPydY1aGAH/x6LhX4
        6jB1DEBjKA9mW8gjTHmKZDuQjEFV1Ld0MeCYsSdvcJ5jDvlZahmyqXlYJu+bB1cHTZjR3R
        1RB+CQPRho3REB3s13nRV+Dh2sR6yKNBKA++UGvK3B+kN/Jju9zriOkLqiO9YUDU6qE3tV
        oZrb9a3lSzcun2V7BNPrWtpVzjfmlnHrx7smaVNTSHPWfJsG/9UNHSkf9XPZATyTsyurvc
        ST1H8jrxOmhNk3e4vW0vdgILUT3YKEsLxGdZIOKw0kJ23wcPum1m1VfCLeoF/g==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Mon, 14 Aug 2023 18:41:00 +1000
Subject: [PATCH v2 4/5] memfd: replace ratcheting feature from
 vm.memfd_noexec with hierarchy
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-4-7ff9e3e10ba6@cyphar.com>
References: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
In-Reply-To: <20230814-memfd-vm-noexec-uapi-fixes-v2-0-7ff9e3e10ba6@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        stable@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10124; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=U7ufwXeR3BywMTVYzMKLH+ocS470Rxhe9PUxTLcsuDk=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLEmXWFyS8qGo5za91//3FAcP4OVm1d+JpNYzjUHD
 eYH+xjiOkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBE/s5g+Gch39W/f80Jq8Qd
 K2Jb0u73q+yUWZJ6uXjCllft3Ze4gkQZGX49jo+etthCvmLRglfvPhh+Ot27+ojTmuMTlKqaKsz
 tfvMCAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4RPSYl1sPZz9sSk
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This sysctl has the very unusual behaviour of not allowing any user (even
CAP_SYS_ADMIN) to reduce the restriction setting, meaning that if you
were to set this sysctl to a more restrictive option in the host pidns
you would need to reboot your machine in order to reset it.

The justification given in [1] is that this is a security feature and
thus it should not be possible to disable. Aside from the fact that we
have plenty of security-related sysctls that can be disabled after being
enabled (fs.protected_symlinks for instance), the protection provided by
the sysctl is to stop users from being able to create a binary and then
execute it. A user with CAP_SYS_ADMIN can trivially do this without
memfd_create(2):

  % cat mount-memfd.c
  #include <fcntl.h>
  #include <string.h>
  #include <stdio.h>
  #include <stdlib.h>
  #include <unistd.h>
  #include <linux/mount.h>

  #define SHELLCODE "#!/bin/echo this file was executed from this totally private tmpfs:"

  int main(void)
  {
  	int fsfd = fsopen("tmpfs", FSOPEN_CLOEXEC);
  	assert(fsfd >= 0);
  	assert(!fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 2));

  	int dfd = fsmount(fsfd, FSMOUNT_CLOEXEC, 0);
  	assert(dfd >= 0);

  	int execfd = openat(dfd, "exe", O_CREAT | O_RDWR | O_CLOEXEC, 0782);
  	assert(execfd >= 0);
  	assert(write(execfd, SHELLCODE, strlen(SHELLCODE)) == strlen(SHELLCODE));
  	assert(!close(execfd));

  	char *execpath = NULL;
  	char *argv[] = { "bad-exe", NULL }, *envp[] = { NULL };
  	execfd = openat(dfd, "exe", O_PATH | O_CLOEXEC);
  	assert(execfd >= 0);
  	assert(asprintf(&execpath, "/proc/self/fd/%d", execfd) > 0);
  	assert(!execve(execpath, argv, envp));
  }
  % ./mount-memfd
  this file was executed from this totally private tmpfs: /proc/self/fd/5
  %

Given that it is possible for CAP_SYS_ADMIN users to create executable
binaries without memfd_create(2) and without touching the host
filesystem (not to mention the many other things a CAP_SYS_ADMIN process
would be able to do that would be equivalent or worse), it seems strange
to cause a fair amount of headache to admins when there doesn't appear
to be an actual security benefit to blocking this. There appear to be
concerns about confused-deputy-esque attacks[2] but a confused deputy that
can write to arbitrary sysctls is a bigger security issue than
executable memfds.

/* New API */

The primary requirement from the original author appears to be more
based on the need to be able to restrict an entire system in a
hierarchical manner[3], such that child namespaces cannot re-enable
executable memfds.

So, implement that behaviour explicitly -- the vm.memfd_noexec scope is
evaluated up the pidns tree to &init_pid_ns and you have the most
restrictive value applied to you. The new lower limit you can set
vm.memfd_noexec is whatever limit applies to your parent.

Note that a pidns will inherit a copy of the parent pidns's effective
vm.memfd_noexec setting at unshare() time. This matches the existing
behaviour, and it also ensures that a pidns will never have its
vm.memfd_noexec setting *lowered* behind its back (but it will be raised
if the parent raises theirs).

/* Backwards Compatibility */

As the previous version of the sysctl didn't allow you to lower the
setting at all, there are no backwards compatibility issues with this
aspect of the change.

However it should be noted that now that the setting is completely
hierarchical. Previously, a cloned pidns would just copy the current
pidns setting, meaning that if the parent's vm.memfd_noexec was changed
it wouldn't propoagate to existing pid namespaces. Now, the restriction
applies recursively. This is a uAPI change, however:

 * The sysctl is very new, having been merged in 6.3.
 * Several aspects of the sysctl were broken up until this patchset and
   the other patchset by Jeff Xu last month.

And thus it seems incredibly unlikely that any real users would run into
this issue. In the worst case, if this causes userspace isues we could
make it so that modifying the setting follows the hierarchical rules but
the restriction checking uses the cached copy.

[1]: https://lore.kernel.org/CABi2SkWnAgHK1i6iqSqPMYuNEhtHBkO8jUuCvmG3RmUB5TKHJw@mail.gmail.com/
[2]: https://lore.kernel.org/CALmYWFs_dNCzw_pW1yRAo4bGCPEtykroEQaowNULp7svwMLjOg@mail.gmail.com/
[3]: https://lore.kernel.org/CALmYWFuahdUF7cT4cm7_TGLqPanuHXJ-hVSfZt7vpTnc18DPrw@mail.gmail.com/

Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org # v6.3+
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h | 23 ++++++++++++++++++++++-
 kernel/pid.c                  |  3 +++
 kernel/pid_namespace.c        |  6 +++---
 kernel/pid_sysctl.h           | 28 ++++++++++++----------------
 mm/memfd.c                    |  3 ++-
 5 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 53974d79d98e..f9f9931e02d6 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -39,7 +39,6 @@ struct pid_namespace {
 	int reboot;	/* group exit code if this pidns was rebooted */
 	struct ns_common ns;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
-	/* sysctl for vm.memfd_noexec */
 	int memfd_noexec_scope;
 #endif
 } __randomize_layout;
@@ -56,6 +55,23 @@ static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 	return ns;
 }
 
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
+{
+	int scope = MEMFD_NOEXEC_SCOPE_EXEC;
+
+	for (; ns; ns = ns->parent)
+		scope = max(scope, READ_ONCE(ns->memfd_noexec_scope));
+
+	return scope;
+}
+#else
+static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
+{
+	return 0;
+}
+#endif
+
 extern struct pid_namespace *copy_pid_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct pid_namespace *ns);
 extern void zap_pid_ns_processes(struct pid_namespace *pid_ns);
@@ -70,6 +86,11 @@ static inline struct pid_namespace *get_pid_ns(struct pid_namespace *ns)
 	return ns;
 }
 
+static inline int pidns_memfd_noexec_scope(struct pid_namespace *ns)
+{
+	return 0;
+}
+
 static inline struct pid_namespace *copy_pid_ns(unsigned long flags,
 	struct user_namespace *user_ns, struct pid_namespace *ns)
 {
diff --git a/kernel/pid.c b/kernel/pid.c
index 6a1d23a11026..fee14a4486a3 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -83,6 +83,9 @@ struct pid_namespace init_pid_ns = {
 #ifdef CONFIG_PID_NS
 	.ns.ops = &pidns_operations,
 #endif
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	.memfd_noexec_scope = MEMFD_NOEXEC_SCOPE_EXEC,
+#endif
 };
 EXPORT_SYMBOL_GPL(init_pid_ns);
 
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 0bf44afe04dd..619972c78774 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -110,9 +110,9 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 	ns->user_ns = get_user_ns(user_ns);
 	ns->ucounts = ucounts;
 	ns->pid_allocated = PIDNS_ADDING;
-
-	initialize_memfd_noexec_scope(ns);
-
+#if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
+	ns->memfd_noexec_scope = pidns_memfd_noexec_scope(parent_pid_ns);
+#endif
 	return ns;
 
 out_free_idr:
diff --git a/kernel/pid_sysctl.h b/kernel/pid_sysctl.h
index b26e027fc9cd..2ee41a3a1dfd 100644
--- a/kernel/pid_sysctl.h
+++ b/kernel/pid_sysctl.h
@@ -5,33 +5,30 @@
 #include <linux/pid_namespace.h>
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
-static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns)
-{
-	ns->memfd_noexec_scope =
-		task_active_pid_ns(current)->memfd_noexec_scope;
-}
-
 static int pid_mfd_noexec_dointvec_minmax(struct ctl_table *table,
 	int write, void *buf, size_t *lenp, loff_t *ppos)
 {
 	struct pid_namespace *ns = task_active_pid_ns(current);
 	struct ctl_table table_copy;
+	int err, scope, parent_scope;
 
 	if (write && !ns_capable(ns->user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	table_copy = *table;
-	if (ns != &init_pid_ns)
-		table_copy.data = &ns->memfd_noexec_scope;
 
-	/*
-	 * set minimum to current value, the effect is only bigger
-	 * value is accepted.
-	 */
-	if (*(int *)table_copy.data > *(int *)table_copy.extra1)
-		table_copy.extra1 = table_copy.data;
+	/* You cannot set a lower enforcement value than your parent. */
+	parent_scope = pidns_memfd_noexec_scope(ns->parent);
+	/* Equivalent to pidns_memfd_noexec_scope(ns). */
+	scope = max(READ_ONCE(ns->memfd_noexec_scope), parent_scope);
+
+	table_copy.data = &scope;
+	table_copy.extra1 = &parent_scope;
 
-	return proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
+	err = proc_dointvec_minmax(&table_copy, write, buf, lenp, ppos);
+	if (!err && write)
+		WRITE_ONCE(ns->memfd_noexec_scope, scope);
+	return err;
 }
 
 static struct ctl_table pid_ns_ctl_table_vm[] = {
@@ -51,7 +48,6 @@ static inline void register_pid_ns_sysctl_table_vm(void)
 	register_sysctl("vm", pid_ns_ctl_table_vm);
 }
 #else
-static inline void initialize_memfd_noexec_scope(struct pid_namespace *ns) {}
 static inline void register_pid_ns_sysctl_table_vm(void) {}
 #endif
 
diff --git a/mm/memfd.c b/mm/memfd.c
index aa46521057ab..1cad1904fc26 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -271,7 +271,8 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
 #ifdef CONFIG_SYSCTL
-	int sysctl = task_active_pid_ns(current)->memfd_noexec_scope;
+	struct pid_namespace *ns = task_active_pid_ns(current);
+	int sysctl = pidns_memfd_noexec_scope(ns);
 
 	if (!(*flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
 		if (sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)

-- 
2.41.0

