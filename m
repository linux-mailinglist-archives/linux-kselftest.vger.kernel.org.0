Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408E475253E
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 16:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjGMOes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjGMOeq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 10:34:46 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF52738;
        Thu, 13 Jul 2023 07:34:43 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4R1xvf1qtFz9srM;
        Thu, 13 Jul 2023 16:34:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1689258878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7odY7HDZPKzVimeFHgPRDdKv16odgPLE3AW6I05q6w=;
        b=HjK2VS5QGszcVCpAQswe06oAYmkCH8W+Y4jvTjcKvszbcPG7PeM8Uz/9Cnqa1kBhueLd67
        98f++zez56dcGzXdqWNg31IH6sMr8WVFEiRRDTD34NdjtZzMuKftA4OLu6iNQjCBKD/cTZ
        7ZcXVhM7cTnhK7g4w7J6VH1Of3KF0sh1yrk/sB+9yM8hnr+N7so3IizQqEQGd+EUUhohlm
        4cquNE32lwbjdHoo7ExC5r39ZHLRYZXu/X5+fCG09tNzlU1fXoslMPH2zC6FiJJwVWCnjv
        txxDC2rVCGXe4b1AtJO6uoCAUzwhWt80tTnMdooOSUBpodZOgvhJcOwU3BRMzQ==
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jeff Xu <jeffxu@google.com>,
        Daniel Verkamp <dverkamp@chromium.org>
Cc:     linux-mm@kvack.org, Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 1/3] memfd: cleanups for vm.memfd_noexec handling
Date:   Fri, 14 Jul 2023 00:33:46 +1000
Message-ID: <20230713143406.14342-2-cyphar@cyphar.com>
In-Reply-To: <20230713143406.14342-1-cyphar@cyphar.com>
References: <20230713143406.14342-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The previous implementation of vm.memfd_noexec=2 did not actually
enforce the usage of MFD_NOEXEC_SEAL, as any program that set MFD_EXEC
would not be affected by the "enforcement" mechanism. This was fixed in
in Andrew's tree recently, but there were still some things that could
be cleaned up.

On the topic of older programs, it seems far less disruptive to have
vm.memfd_noexec=2 have the same behaviour as vm.memfd_noexec=1 (default
to MFD_NOEXEC_SEAL if unspecified) to avoid breaking older programs that
didn't actually care about the exec bits -- which includes the vast
majority of programs that use memfd_create(2), thus allowing users to be
able to enable this sysctl without all older programs needlessly
breaking. Otherwise vm.memfd_noexec=2 would be unusable on most
general-purpose systems as it would require an audit of all of
userspace.

While we're at it, fix the warnings emitted by memfd_create() to use
pr_warn_ratelimited(). If the intention of the warning is to get
developers to switch to explicitly specifying if they want exec bits or
not, you need to warn them whenever they use it. The systemd version on
my box doesn't pass MFD_EXEC, making the warning useless for most
userspace developers because it was already emitted during boot. Commit
105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC") mentions
that this was switched to pr_warn_once "as per review" but I couldn't
find the discussion anywhere, and the obvious issue (the ability for
unprivileged userspace to spam the kernel log) should be handled by
pr_warn_ratelimited. If the issue is that this is too spammy, we could
tie it to using vm.memfd_noexec=1 or higher.

This is a user-visible API change, but as it allows programs to do
something that would be blocked before, and the sysctl itself was broken
and recently released, it seems unlikely this will cause any issues.

Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org # v6.3+
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h              | 16 +++--------
 mm/memfd.c                                 | 32 ++++++++--------------
 tools/testing/selftests/memfd/memfd_test.c | 22 +++++++++++----
 3 files changed, 33 insertions(+), 37 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index c758809d5bcf..53974d79d98e 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -17,18 +17,10 @@
 struct fs_pin;
 
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
-/*
- * sysctl for vm.memfd_noexec
- * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
- *	acts like MFD_EXEC was set.
- * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
- *	acts like MFD_NOEXEC_SEAL was set.
- * 2: memfd_create() without MFD_NOEXEC_SEAL will be
- *	rejected.
- */
-#define MEMFD_NOEXEC_SCOPE_EXEC			0
-#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1
-#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2
+/* modes for vm.memfd_noexec sysctl */
+#define MEMFD_NOEXEC_SCOPE_EXEC			0 /* MFD_EXEC implied if unset */
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL		1 /* MFD_NOEXEC_SEAL implied if unset */
+#define MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED	2 /* same as 1, except MFD_EXEC rejected */
 #endif
 
 struct pid_namespace {
diff --git a/mm/memfd.c b/mm/memfd.c
index 0bdbd2335af7..4f1f841ae39d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -271,30 +271,22 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 static int check_sysctl_memfd_noexec(unsigned int *flags)
 {
 #ifdef CONFIG_SYSCTL
-	char comm[TASK_COMM_LEN];
-	int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
-	struct pid_namespace *ns;
-
-	ns = task_active_pid_ns(current);
-	if (ns)
-		sysctl = ns->memfd_noexec_scope;
+	int sysctl = task_active_pid_ns(current)->memfd_noexec_scope;
 
 	if (!(*flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		if (sysctl == MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
+		if (sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL)
 			*flags |= MFD_NOEXEC_SEAL;
 		else
 			*flags |= MFD_EXEC;
 	}
 
-	if (*flags & MFD_EXEC && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
-		pr_warn_once(
-			"memfd_create(): MFD_NOEXEC_SEAL is enforced, pid=%d '%s'\n",
-			task_pid_nr(current), get_task_comm(comm, current));
-
+	if (!(*flags & MFD_NOEXEC_SEAL) && sysctl >= MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED) {
+		pr_warn_ratelimited(
+			"%s[%d]: memfd_create() requires MFD_NOEXEC_SEAL with vm.memfd_noexec=%d\n",
+			current->comm, task_pid_nr(current), sysctl);
 		return -EACCES;
 	}
 #endif
-
 	return 0;
 }
 
@@ -302,7 +294,6 @@ SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
 		unsigned int, flags)
 {
-	char comm[TASK_COMM_LEN];
 	unsigned int *file_seals;
 	struct file *file;
 	int fd, error;
@@ -324,13 +315,14 @@ SYSCALL_DEFINE2(memfd_create,
 		return -EINVAL;
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
-		pr_warn_once(
-			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
-			task_pid_nr(current), get_task_comm(comm, current));
+		pr_warn_ratelimited(
+			"%s[%d]: memfd_create() called without MFD_EXEC or MFD_NOEXEC_SEAL set\n",
+			current->comm, task_pid_nr(current));
 	}
 
-	if (check_sysctl_memfd_noexec(&flags) < 0)
-		return -EACCES;
+	error = check_sysctl_memfd_noexec(&flags);
+	if (error < 0)
+		return error;
 
 	/* length includes terminating zero */
 	len = strnlen_user(uname, MFD_NAME_MAX_LEN + 1);
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index dbdd9ec5e397..d8342989c547 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1145,11 +1145,23 @@ static void test_sysctl_child(void)
 
 	printf("%s sysctl 2\n", memfd_str);
 	sysctl_assert_write("2");
-	mfd_fail_new("kern_memfd_sysctl_2",
-		MFD_CLOEXEC | MFD_ALLOW_SEALING);
-	mfd_fail_new("kern_memfd_sysctl_2_MFD_EXEC",
-		MFD_CLOEXEC | MFD_EXEC);
-	fd = mfd_assert_new("", 0, MFD_NOEXEC_SEAL);
+	mfd_fail_new("kern_memfd_sysctl_2_exec",
+		     MFD_EXEC | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_dfl",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec_seal",
+			    mfd_def_size,
+			    MFD_NOEXEC_SEAL | MFD_CLOEXEC | MFD_ALLOW_SEALING);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_fail_chmod(fd, 0777);
 	close(fd);
 
 	sysctl_fail_write("0");
-- 
2.41.0

