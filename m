Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B640320BB0
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Feb 2021 17:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhBUQZV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 11:25:21 -0500
Received: from mout.gmx.net ([212.227.17.21]:38469 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhBUQZU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 11:25:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613924601;
        bh=Mig8mLw6txPp64eklWsPmtDq+qJ7Ux3BOxxRc/jYndU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=HplHLhejOO3vcTUhTyHaFtyxF3k8LaTeI5sM3tlux0xQfT70pqiwVrWT1U/joJbA6
         XSofeh0uUMWrVIUeMKDGsSka9kzMJyjV7bl0lK+C0+MUanz2ogJn9/Z0aY+zFatYuc
         yQ4shj+QhmaBFf4u6hqaFBWTOdlZ5hFdBaqMO504=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MVN6t-1lNb3u0kqN-00SOz1; Sun, 21 Feb 2021 17:23:21 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 1/8] security: Add LSM hook at the point where a task gets a fatal signal
Date:   Sun, 21 Feb 2021 16:49:12 +0100
Message-Id: <20210221154919.68050-2-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221154919.68050-1-john.wood@gmx.com>
References: <20210221154919.68050-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mk8QK57R80ANwQs60TNWIOOGi7oZIl0vZSBtlU2wG9EQTvfcyUN
 Ypqj7CRTNjXwl032tG5aHovn1oS8TsU0YzyLyyONXYyaIUVd8SoNxQNL30wpSF8+sszPqiK
 eo7FPfJnUSFxCg0ve5ZOyEUCDtTUuTRLa3lraiBV/83zihO9+ry56SLBvWngiAoEcghfZ9Y
 d10x7SVYQccjY8XDHAIsg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PLP7KhJEMYw=:I0hZ3CUHTLIKbo8z3JwUiy
 czCfT7CKWPXnhyNrztr0MmnxVl5HQtibEObi6Q5zNhTragbUB6I933/g5zLCxqvkfbwBMRjLR
 c6g02r2bBHgxgBCiBETUj4Shg5F5YGgH/bUj3y6NnHtWV0QGtzmB2j4nnWLMXf5aA6Gck6bFN
 o6GGOdzD7RqpjX+ZrDPScV5LxGmEF/j31eIkLInSHjBrDHHMtMVwaBNcMpksZv4FOdK4LwQfW
 eOLC1IItJx2baHWC67Efw9s/OeSP1KpmhV/vXwDbu8liwDshc//1y+c3Yltn9dVezpjemwoaN
 JFTDzlNGclEmRyw1m8r37DNGH3+3AvZRaS1gTteUeiWLi8fuTSxit+Z1TnjxO9Vx2tY4h4JOi
 oRpQr7EP7y6PkQxnJrIaSHVQT6x9NLtvjkBNzEOIGBXaElKsh3M7Q9ghsXQKj8b9zi5cW3aa/
 B+XTchNaFqVgXT0yobrXHHcORuk3W+ex7FQJIxThtCbhTm9reecY2oIv2Ai3MDUbGY4R8PqSy
 RyMOoLBRmQTJ7M/egc3W2Wm4Bs/Tl3HvNrTaBE4SPVaaeM7TaFQIklppyLwm89dXrP3Jt1UI9
 LhWCs3COYHO5U9ILUplhqJeGfBrnAzgJtW0zlR7JoX5StEIxnnwLpqilYwlVW9eG+vZpdsHbM
 iEUplBp/jHXjYY5N8qaZpvmfGJ2KAKdeCPCpY4acZ0MeCRlAGQZ4m8U24NLIV2qRBpidG+hdW
 qjBKMCl6rwIad1h+iWWxXRnfKUgLZszBNcCH1TplBKNz+w69TZwPKN5TclHQqFLmCnOjNfAJU
 0QXdf4gOBgrFKtbxA/adjkVQ3xiMFHjUG/Gk/UO6F3NZ3p3i8uhLsPiIBmcBLLCJvxTtjb9cM
 UWuwG9B96Hk7sU6UD/xA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a security hook that allows a LSM to be notified when a task gets a
fatal signal. This patch is a previous step on the way to compute the
task crash period by the "brute" LSM (linux security module to detect
and mitigate fork brute force attack against vulnerable userspace
processes).

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 4 ++++
 kernel/signal.c               | 1 +
 security/security.c           | 5 +++++
 5 files changed, 15 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 7aaa753b8608..fa9bfa9676f3 100644
=2D-- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -215,6 +215,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigne=
d long arg2,
 	 unsigned long arg3, unsigned long arg4, unsigned long arg5)
 LSM_HOOK(void, LSM_RET_VOID, task_to_inode, struct task_struct *p,
 	 struct inode *inode)
+LSM_HOOK(void, LSM_RET_VOID, task_fatal_signal, const kernel_siginfo_t *s=
iginfo)
 LSM_HOOK(int, 0, ipc_permission, struct kern_ipc_perm *ipcp, short flag)
 LSM_HOOK(void, LSM_RET_VOID, ipc_getsecid, struct kern_ipc_perm *ipcp,
 	 u32 *secid)
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a19adef1f088..1ec253e557a4 100644
=2D-- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -774,6 +774,10 @@
  *	security attributes, e.g. for /proc/pid inodes.
  *	@p contains the task_struct for the task.
  *	@inode contains the inode structure for the inode.
+ * @task_fatal_signal:
+ *	This hook allows security modules to be notified when a task gets a
+ *	fatal signal.
+ *	@siginfo contains the signal information.
  *
  * Security hooks for Netlink messaging.
  *
diff --git a/include/linux/security.h b/include/linux/security.h
index c35ea0ffccd9..0663db6fca7e 100644
=2D-- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -419,6 +419,7 @@ int security_task_kill(struct task_struct *p, struct k=
ernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg=
3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+void security_task_fatal_signal(const kernel_siginfo_t *siginfo);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1141,6 +1142,9 @@ static inline int security_task_prctl(int option, un=
signed long arg2,
 static inline void security_task_to_inode(struct task_struct *p, struct i=
node *inode)
 { }

+static inline void security_task_fatal_signal(const kernel_siginfo_t *sig=
info)
+{ }
+
 static inline int security_ipc_permission(struct kern_ipc_perm *ipcp,
 					  short flag)
 {
diff --git a/kernel/signal.c b/kernel/signal.c
index 5ad8566534e7..893c07a77c76 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2750,6 +2750,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Anything else is fatal, maybe with a core dump.
 		 */
+		security_task_fatal_signal(&ksig->info);
 		current->flags |=3D PF_SIGNALED;

 		if (sig_kernel_coredump(signr)) {
diff --git a/security/security.c b/security/security.c
index 7b09cfbae94f..96731d0428f9 100644
=2D-- a/security/security.c
+++ b/security/security.c
@@ -1827,6 +1827,11 @@ void security_task_to_inode(struct task_struct *p, =
struct inode *inode)
 	call_void_hook(task_to_inode, p, inode);
 }

+void security_task_fatal_signal(const kernel_siginfo_t *siginfo)
+{
+	call_void_hook(task_fatal_signal, siginfo);
+}
+
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag)
 {
 	return call_int_hook(ipc_permission, 0, ipcp, flag);
=2D-
2.25.1

