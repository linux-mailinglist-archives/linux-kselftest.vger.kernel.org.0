Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFA9A38CC3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 19:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234356AbhEURg5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 13:36:57 -0400
Received: from mout.gmx.net ([212.227.15.15]:48553 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233220AbhEURg4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 13:36:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621618477;
        bh=jYd+DBUq5/+hoWltaHEIKEySfVzGVUxKtuTlWhtWnNU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Kx8aLe9AKZkFlHBFzKJQ/0wO5CcwPquXKmR8TTit7BChbVKbSqFooAblS8Rf2ryz/
         rem1qyVFe5OlpYpwOF7Op7yahmHVvWV0DF4yriyBrQICZBlEvZluGaW1rxMkC4ACeF
         ZbpwL+OavEkNMn3DVwawfQnaDwrNffx+jtc3qgfg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MPGW7-1m6u3c2AHd-00PaoO; Fri, 21 May 2021 19:34:37 +0200
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>, Andi Kleen <ak@linux.intel.com>,
        valdis.kletnieks@vt.edu,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v7 1/7] security: Add LSM hook at the point where a task gets a fatal signal
Date:   Fri, 21 May 2021 19:24:08 +0200
Message-Id: <20210521172414.69456-2-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521172414.69456-1-john.wood@gmx.com>
References: <20210521172414.69456-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bd6lib84LVlkJT8jNqZAPUjNinmei+Xet/u0DD1+cHkiKEm3feF
 HT9bCqV7iIbCFUzz/JKgZCFWJOJMWDiXaJlKsCIUC2k7end9vd+XP1uID+wLCkVzUwFhr3+
 y+v3JS+c2GJC76pLYtnMrj7kZuxHwGgbttcFMRFUIpuNjaUpqH29kG7NGc4ZZ7OlrjLEP2R
 vHsgogfOcVJBKVmcoBkTQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:6IzlPLp9f6s=:mRCsH7AFbIQl1g7NxLFy2S
 RL3o1/lFuK9b4P0IYPqitza5mnxG0OhhsvQaeBsmwlhRDQo8uuYJ9Ag2sTZilVX4aMwiqkZKV
 7UMoe4qaCcWKByzEk5LMdt/K2wS1P82N1MEJOKeONkrwQpXX1EUsLASFlmF0D39p9DpidEkna
 xEKYNdtU8pDVUWfidjveb5cFVlQk4qZq7MjnXfUkSCsNAC570amFjHEn3Nt6OLIUZgu/nOcoN
 kHcU3m10GpTHZhMz1tV7YVmb+yUS07ItIUJJkb01F+AFI3b+T1+WCbBOsXwklBZ882GuKccCD
 jOp66XHdJp7r/A3D6eoVqscOtQ3g/3bjtmSFtC4vUwfwtnKSprS7IeJ3kBS+5DrGL8EYRdGPy
 FMpUNTomkI+frPzJpZGhFzA+EghsWzinnk/7yg8y0O0xRQq7GtRNyeSiSfuchH+2bhl73rW5o
 ddlbm+jTdO06FpRiz44lOl8AxVI+CzisvNSgP9JSc5bfN4gkldOt3EisIjVElbl2Wg3Emmwiy
 OH3uqW55FfrIN2xawGSyF8feR/0ZRDG653I3R1+gkgI24NO7imkyMoHX7KUeXzbtzGjGFaSYL
 T1txig1UyxtAoAA4PZDr02bv+yRMOCWyPU2eGn0o8552XIggIDelLtp3OwWPr9Xdb7XX9Qtd/
 +59rwgB8cHWLeqiWC1/JjrE8HuLHeroUswRaSgbdA9TN0gMjT28fs2LJyixM/zVjJr3hSD8cA
 92MxppbEOkiBA7m9gd1roANZ9z4UU2s4bMFcaUMucc2cSrXgKb9woSGT3PJfMH+VL+1nMHNWw
 bUbkZB8mNO1y1B5oe4k5X9DT7YB0C/gYeadDtY3kMUKCbfV/JrUbwD6N3pFkapfrxWiGspnWn
 me+rNqShm2CHXkzEpS+sKguOFLpQ2hZVXMVoMN46zZfZgfABx7E2QCUY1hnjt4MjUsdifT+9y
 4HIyw/uyCZLCXun7J6Al3257WGQcMCkXhJg02qkrc1efWfd7SKOYzsZN8tZv8O5QFdxddV/Ag
 sM/b744VAcGw3oNEsDGLatxlxMfibejfCFQwGmEtA5ivPc3/iUogkT+HKa6l/sXLfDDcPQats
 zFvgx2bD9eQqxjlz5+xAJ7g1gdauvaF9EECxUmckN5umXE5j+Q+G03dIBswKFxR9EiS5mOYdN
 iGJW7jRzXHgB+wjp0BT89AxY6aDhp+eLQWsGteid+QEzBgLFF6aWsvY06kSq879vhyY/w=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a security hook that allows a LSM to be notified when a task gets a
fatal signal. This patch is a previous step on the way to compute the
task crash period by the "brute" LSM (linux security module to detect
and mitigate fork brute force attack against vulnerable userspace
processes).

Signed-off-by: John Wood <john.wood@gmx.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
=2D--
 include/linux/lsm_hook_defs.h | 1 +
 include/linux/lsm_hooks.h     | 4 ++++
 include/linux/security.h      | 4 ++++
 kernel/signal.c               | 1 +
 security/security.c           | 5 +++++
 5 files changed, 15 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 04c01794de83..e28468e84300 100644
=2D-- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -225,6 +225,7 @@ LSM_HOOK(int, -ENOSYS, task_prctl, int option, unsigne=
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
index 5c4c5c0602cb..fc8bef0f15d9 100644
=2D-- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -799,6 +799,10 @@
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
index 06f7c50ce77f..609c76c6c764 100644
=2D-- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -433,6 +433,7 @@ int security_task_kill(struct task_struct *p, struct k=
ernel_siginfo *info,
 int security_task_prctl(int option, unsigned long arg2, unsigned long arg=
3,
 			unsigned long arg4, unsigned long arg5);
 void security_task_to_inode(struct task_struct *p, struct inode *inode);
+void security_task_fatal_signal(const kernel_siginfo_t *siginfo);
 int security_ipc_permission(struct kern_ipc_perm *ipcp, short flag);
 void security_ipc_getsecid(struct kern_ipc_perm *ipcp, u32 *secid);
 int security_msg_msg_alloc(struct msg_msg *msg);
@@ -1183,6 +1184,9 @@ static inline int security_task_prctl(int option, un=
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
index 66e88649cf74..62625ad98b14 100644
=2D-- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2787,6 +2787,7 @@ bool get_signal(struct ksignal *ksig)
 		/*
 		 * Anything else is fatal, maybe with a core dump.
 		 */
+		security_task_fatal_signal(&ksig->info);
 		current->flags |=3D PF_SIGNALED;

 		if (sig_kernel_coredump(signr)) {
diff --git a/security/security.c b/security/security.c
index b38155b2de83..208e3e7d4284 100644
=2D-- a/security/security.c
+++ b/security/security.c
@@ -1891,6 +1891,11 @@ void security_task_to_inode(struct task_struct *p, =
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

