Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C544ABF9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 14:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiBGN1l (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 08:27:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445598AbiBGMmS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 07:42:18 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0BBE033DB0;
        Mon,  7 Feb 2022 04:33:57 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BBE201F386;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644236292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LOAZl+X1cH+/PE8PnJNA97WZ/FEmmtdAOX5J155V/GY=;
        b=R8vHFitE3/0c2+aGokRHHqIecoBd082bURHw791MAgCrpS+qdVLAID/ocEGvCoGhMecpAz
        8vZtgPllVDkkTehtIMbSCysfFSrc9ShUVS4/eJouxWbDJ06PWi1EEGxlqdAAHmc6Siwwl3
        6vp3aC0jiKvBudbRtwu0d5OAVauMN5M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 97D9113BBC;
        Mon,  7 Feb 2022 12:18:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KeSJAQOAWLMegAAMHmgww
        (envelope-from <mkoutny@suse.com>); Mon, 07 Feb 2022 12:18:12 +0000
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     Eric Biederman <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Solar Designer <solar@openwall.com>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: [RFC PATCH 2/6] set*uid: Check RLIMIT_PROC against new credentials
Date:   Mon,  7 Feb 2022 13:17:56 +0100
Message-Id: <20220207121800.5079-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207121800.5079-1-mkoutny@suse.com>
References: <20220207121800.5079-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The generic idea is that not even root or capable user can force an
unprivileged user's limit breach. (For historical and security reasons
this check is postponed from set*uid to execve.) During the switch the
resource consumption of target the user has to be checked. The commits
905ae01c4ae2 ("Add a reference to ucounts for each cred") and
21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts") made the
check in set_user() look at the old user's consumption.

This version of the fix simply moves the check to the place where the
actual switch of the accounting structure happens -- set_cred_ucounts().

The other callers are kept without the check but with the per-userns
accounting they may be newly subject to the check too.
The set_cred_ucounts() becomes inconsistent since task->flags are
passed by the caller but task_rlimit() is implicitly `current`'s, this
patch is meant to illustrate the issue, nicer implementation is
possible.

Fixes: 21d1c5e386bc ("Reimplement RLIMIT_NPROC on top of ucounts")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 fs/exec.c               |  2 +-
 include/linux/cred.h    |  2 +-
 kernel/cred.c           | 24 +++++++++++++++++++++---
 kernel/fork.c           |  2 +-
 kernel/sys.c            | 21 +++------------------
 kernel/user_namespace.c |  2 +-
 6 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index fc598c2652b2..e759e42c61da 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1363,7 +1363,7 @@ int begin_new_exec(struct linux_binprm * bprm)
 	WRITE_ONCE(me->self_exec_id, me->self_exec_id + 1);
 	flush_signal_handlers(me, 0);
 
-	retval = set_cred_ucounts(bprm->cred);
+	retval = set_cred_ucounts(bprm->cred, NULL);
 	if (retval < 0)
 		goto out_unlock;
 
diff --git a/include/linux/cred.h b/include/linux/cred.h
index fcbc6885cc09..455525ab380d 100644
--- a/include/linux/cred.h
+++ b/include/linux/cred.h
@@ -170,7 +170,7 @@ extern int set_security_override_from_ctx(struct cred *, const char *);
 extern int set_create_files_as(struct cred *, struct inode *);
 extern int cred_fscmp(const struct cred *, const struct cred *);
 extern void __init cred_init(void);
-extern int set_cred_ucounts(struct cred *);
+extern int set_cred_ucounts(struct cred *, unsigned int *);
 
 /*
  * check for validity of credentials
diff --git a/kernel/cred.c b/kernel/cred.c
index 473d17c431f3..791cab70b764 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -370,7 +370,7 @@ int copy_creds(struct task_struct *p, unsigned long clone_flags)
 		ret = create_user_ns(new);
 		if (ret < 0)
 			goto error_put;
-		ret = set_cred_ucounts(new);
+		ret = set_cred_ucounts(new, NULL);
 		if (ret < 0)
 			goto error_put;
 	}
@@ -492,7 +492,7 @@ int commit_creds(struct cred *new)
 
 	/* do it
 	 * RLIMIT_NPROC limits on user->processes have already been checked
-	 * in set_user().
+	 * in set_cred_ucounts().
 	 */
 	alter_cred_subscribers(new, 2);
 	if (new->user != old->user || new->user_ns != old->user_ns)
@@ -663,7 +663,7 @@ int cred_fscmp(const struct cred *a, const struct cred *b)
 }
 EXPORT_SYMBOL(cred_fscmp);
 
-int set_cred_ucounts(struct cred *new)
+int set_cred_ucounts(struct cred *new, unsigned int *nproc_flags)
 {
 	struct task_struct *task = current;
 	const struct cred *old = task->real_cred;
@@ -685,6 +685,24 @@ int set_cred_ucounts(struct cred *new)
 	new->ucounts = new_ucounts;
 	put_ucounts(old_ucounts);
 
+	if (!nproc_flags)
+		return 0;
+
+	/*
+	 * We don't fail in case of NPROC limit excess here because too many
+	 * poorly written programs don't check set*uid() return code, assuming
+	 * it never fails if called by root.  We may still enforce NPROC limit
+	 * for programs doing set*uid()+execve() by harmlessly deferring the
+	 * failure to the execve() stage.
+	 */
+	if (ucounts_limit_cmp(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0 &&
+			new->user != INIT_USER &&
+			!security_capable(new, &init_user_ns, CAP_SYS_RESOURCE, CAP_OPT_NONE) &&
+			!security_capable(new, &init_user_ns, CAP_SYS_ADMIN, CAP_OPT_NONE))
+		*nproc_flags |= PF_NPROC_EXCEEDED;
+	else
+		*nproc_flags &= ~PF_NPROC_EXCEEDED;
+
 	return 0;
 }
 
diff --git a/kernel/fork.c b/kernel/fork.c
index 7cb21a70737d..a4005c679d29 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -3051,7 +3051,7 @@ int ksys_unshare(unsigned long unshare_flags)
 		goto bad_unshare_cleanup_cred;
 
 	if (new_cred) {
-		err = set_cred_ucounts(new_cred);
+		err = set_cred_ucounts(new_cred, NULL);
 		if (err)
 			goto bad_unshare_cleanup_cred;
 	}
diff --git a/kernel/sys.c b/kernel/sys.c
index 48c90dcceff3..4e4eea30e235 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -472,21 +472,6 @@ static int set_user(struct cred *new)
 	if (!new_user)
 		return -EAGAIN;
 
-	/*
-	 * We don't fail in case of NPROC limit excess here because too many
-	 * poorly written programs don't check set*uid() return code, assuming
-	 * it never fails if called by root.  We may still enforce NPROC limit
-	 * for programs doing set*uid()+execve() by harmlessly deferring the
-	 * failure to the execve() stage.
-	 */
-	if (ucounts_limit_cmp(new->ucounts, UCOUNT_RLIMIT_NPROC, rlimit(RLIMIT_NPROC)) >= 0 &&
-			new_user != INIT_USER &&
-			!security_capable(new, &init_user_ns, CAP_SYS_RESOURCE, CAP_OPT_NONE) &&
-			!security_capable(new, &init_user_ns, CAP_SYS_ADMIN, CAP_OPT_NONE))
-		current->flags |= PF_NPROC_EXCEEDED;
-	else
-		current->flags &= ~PF_NPROC_EXCEEDED;
-
 	free_uid(new->user);
 	new->user = new_user;
 	return 0;
@@ -560,7 +545,7 @@ long __sys_setreuid(uid_t ruid, uid_t euid)
 	if (retval < 0)
 		goto error;
 
-	retval = set_cred_ucounts(new);
+	retval = set_cred_ucounts(new, &current->flags);
 	if (retval < 0)
 		goto error;
 
@@ -622,7 +607,7 @@ long __sys_setuid(uid_t uid)
 	if (retval < 0)
 		goto error;
 
-	retval = set_cred_ucounts(new);
+	retval = set_cred_ucounts(new, &current->flags);
 	if (retval < 0)
 		goto error;
 
@@ -701,7 +686,7 @@ long __sys_setresuid(uid_t ruid, uid_t euid, uid_t suid)
 	if (retval < 0)
 		goto error;
 
-	retval = set_cred_ucounts(new);
+	retval = set_cred_ucounts(new, &current->flags);
 	if (retval < 0)
 		goto error;
 
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..f7eec0b0233b 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1344,7 +1344,7 @@ static int userns_install(struct nsset *nsset, struct ns_common *ns)
 	put_user_ns(cred->user_ns);
 	set_cred_user_ns(cred, get_user_ns(user_ns));
 
-	if (set_cred_ucounts(cred) < 0)
+	if (set_cred_ucounts(cred, NULL) < 0)
 		return -EINVAL;
 
 	return 0;
-- 
2.34.1

