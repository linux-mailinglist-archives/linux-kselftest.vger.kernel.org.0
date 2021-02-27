Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43951326DAA
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 16:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhB0PyZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 10:54:25 -0500
Received: from mout.gmx.net ([212.227.17.22]:39567 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0PyW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 10:54:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614441132;
        bh=YWreVLLKL40OXFfM6Vh2X6o+9yjmPKeKGxGRCJ+tTcM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YTH6+oXXtnjzRt2ifVDOdXAPOtd7cS+1hC2j+9O7WvVFIqWrp3ilDG85Ze8Ir46gC
         bJgfMOcLzV/XbwRfnVuCzniHPE53H4a17QUg/9VhYBzR3DzM4TvLHndqzQ8qp9c/vq
         SZ1ACVo1yJTtAMD+6bCRGaRa6fFtJIC9FGjxfDfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MNsw4-1lQy8K1yYq-00OKZN; Sat, 27 Feb 2021 16:52:12 +0100
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
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v5 1/8] security: Add LSM hook at the point where a task gets a fatal signal
Date:   Sat, 27 Feb 2021 16:30:06 +0100
Message-Id: <20210227153013.6747-2-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oqPwKi4cpNgVj1U4aZr0gS9GMV3mQ2GvGUc7iSPfXAUiUUX5isG
 Og7piVvVklJ/2nIG66Xgf0M3Te1IJhJ9DVZRkcSe6mpTf5RR/VAp52U/+IAm5tY1Y7RxZDq
 j9I0mZ4pQdTYlyziJL50/wvIMQg2gh4aVY66Q3ZA4XzYOiyffEc9lf2z8HMVikxI5yTVg0g
 8nk4SvX00rixAdy/cFQpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:DF2H8+kXXY0=:lT+736czDiHP54NRVq7tC5
 mTdxO5AmFvCV+VImRCREZiMo95tC6rTShhlBVGZDTts8rM/1YFu//mOBxh/XQEUZw3D4m40zX
 VrWN6QM8cic3LoXxFSE2XqvcSGjXqJ6qQOQFKYtl/3sASAxen/Wk5FTgjonvvGsVkh39AmYYW
 GaA0p+DbKsJXdr+PYAef0s0yaj63GZ2sczu2I2n/ASKaBJEMS3Iz4DJP+NQ7d0T+YDwrRbrgt
 dNo+BRupD/4X1o/Zb/w1k8UbKqJ4FXB3TpBjpaK+DYHuYKRCNnCg2BKpeeCoX8vX5PBp8JEu2
 QIjsEj8IJiOe00tUjj3b8pH8KqZ4FPJ+h3TSGA4HfBk/xl8CElLdRlJ2q8wUU299vmgVZPu3c
 EJSOCzzVkJ5uW+A84mpArmSlCoprHtK5dIgBOKRGGL04SPcMxfDSHDc9Ibu8tEfGp5S71jT1T
 hiFJsE79gFxfroi0ihxT7Pu6CDDwZu3d98c/8GDjOa3zd9tvLFIFxJDDvGsBKjJmEZxwFQM9A
 zQ5ZW9qlCQFj5qi+E5ylTdtyyXqhkZv0ZhnIJ5zQ4QcAPfRp2Fto3rMCP00gqwUkwOXVX8N4+
 0S2bMWAjQ8wAHYQbHgilqKgcs93EbPnSpqKD+BKOMNIxeVM7/7N1i2I37CD7sx8y/WRFxGJlb
 2kWZubqLOmxITjzAfD6RIIXzF4XZ5f/prxfw0qTldkt1It7zrQYq6mChVac2J1f0q+H+WvPEm
 1hO9iGzjRWEBSuhiLU0WcBMH/walJO1L45Wt8UGiUFagEG7ykiwN3W8Yakwpdpo9HCQqx+J8t
 DhHDghvUeHCduQdsOW7HRpt7XeO5/eEQoxbZNNmKv0arfEBTJ1IAb6kjIi1B5SzjGI7aELwR7
 t490zCttHAA6VMelIMGw==
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
index 477a597db013..0208df0955fa 100644
=2D-- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -220,6 +220,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigne=
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
index fb7f3193753d..beedaa6ee745 100644
=2D-- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -784,6 +784,10 @@
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
index 8aeebd6646dc..e4025a13630f 100644
=2D-- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -430,6 +430,7 @@ int security_task_kill(struct task_struct *p, struct k=
ernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg=
3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+void security_task_fatal_signal(const kernel_siginfo_t *siginfo);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1165,6 +1166,9 @@ static inline int security_task_prctl(int option, un=
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
index 5ac96b16f8fa..d9cf653a4e70 100644
=2D-- a/security/security.c
+++ b/security/security.c
@@ -1840,6 +1840,11 @@ void security_task_to_inode(struct task_struct *p, =
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

