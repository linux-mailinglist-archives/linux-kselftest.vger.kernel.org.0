Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC90977B458
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Aug 2023 10:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjHNIlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Aug 2023 04:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbjHNIlq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Aug 2023 04:41:46 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590BA12E;
        Mon, 14 Aug 2023 01:41:40 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4RPSYX6LYkz9sV8;
        Mon, 14 Aug 2023 10:41:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
        t=1692002496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8KHnXfVFe2HzozOZ++k3K0yZYQRi3T1iqdVW5ddEXr8=;
        b=mkHgS1T1saMuQar2+hLvU869NXgYOqmVxqGItOAqDywdCYkf+YWmIvZvqXQ1SBOXWxGuri
        z93zrsoK0Cj8bIXSlfhGixvtUc41ZaUdmQ33jWm5GX/PhRIaYPBM2xOKWAjWjt7iKXOuSp
        cdkg+J36AMISU9xvCR/ymXcYfbqrBKjjqMe8CS/6BSKryd1PeDjLHqrqfxgJXnS6mOnuw7
        VGa+VOLZHVdVZw4pftsvVsKbgEGQR2sKNlxkvQqUF2QLN7UEW+vpJ5ZLh6Mheo+OAE8yR3
        MzgG0xTPbS5PMTklW09fnxmgJhThTcR47109IlAv79ze0UER9zp0IlFsBGOBmA==
From:   Aleksa Sarai <cyphar@cyphar.com>
Date:   Mon, 14 Aug 2023 18:40:58 +1000
Subject: [PATCH v2 2/5] memfd: do not -EACCES old memfd_create() users with
 vm.memfd_noexec=2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230814-memfd-vm-noexec-uapi-fixes-v2-2-7ff9e3e10ba6@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6045; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Oi08rzV4zlV5QA1O8wafoqXVIjsJnVHyeP4wDfF54wA=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaTcfLFS1FRjkR3j8lvbuN47TmXl+1bCoFiVbf3R3WTBC
 n3tA5dMO0pZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEbt9l+O/W9O/Pzh2L/Hdf
 l+5+En+Lk4cleX5P3688r/3Mkb/X56oz/Ga9VZCQltttufi1/uNLe312cCSlnN3yuVogwfjKV9F
 34WwA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Given the difficulty of auditing all of userspace to figure out whether
every memfd_create() user has switched to passing MFD_EXEC and
MFD_NOEXEC_SEAL flags, it seems far less distruptive to make it possible
for older programs that don't make use of executable memfds to run under
vm.memfd_noexec=2. Otherwise, a small dependency change can result in
spurious errors. For programs that don't use executable memfds, passing
MFD_NOEXEC_SEAL is functionally a no-op and thus having the same

In addition, every failure under vm.memfd_noexec=2 needs to print to the
kernel log so that userspace can figure out where the error came from.
The concerns about pr_warn_ratelimited() spam that caused the switch to
pr_warn_once()[1,2] do not apply to the vm.memfd_noexec=2 case.

This is a user-visible API change, but as it allows programs to do
something that would be blocked before, and the sysctl itself was broken
and recently released, it seems unlikely this will cause any issues.

[1]: https://lore.kernel.org/Y5yS8wCnuYGLHMj4@x1n/
[2]: https://lore.kernel.org/202212161233.85C9783FB@keescook/

Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: stable@vger.kernel.org # v6.3+
Fixes: 105ff5339f49 ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h              | 16 ++++------------
 mm/memfd.c                                 | 30 +++++++++++-------------------
 tools/testing/selftests/memfd/memfd_test.c | 22 +++++++++++++++++-----
 3 files changed, 32 insertions(+), 36 deletions(-)

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
index 0bdbd2335af7..d65485c762de 100644
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
+		pr_err_ratelimited(
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
@@ -325,12 +316,13 @@ SYSCALL_DEFINE2(memfd_create,
 
 	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
 		pr_warn_once(
-			"memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL, pid=%d '%s'\n",
-			task_pid_nr(current), get_task_comm(comm, current));
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
index 8eb49204f9ea..8b7390ad81d1 100644
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

