Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE850320C66
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Feb 2021 19:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhBUSFd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Feb 2021 13:05:33 -0500
Received: from mout.gmx.net ([212.227.17.21]:40431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhBUSFc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Feb 2021 13:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613930616;
        bh=g4HJDy+WXxT0QISwG1+uT8doXnVuhV9SQ3naNPLG790=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=CV8zAN63O/p6OuI6JkmhLL662KUco7UuDJmV1slLxEe22AlJUy2lXJWNLZtUBI0a+
         DEIwd6EwQ9klVtgCC5OmFoBWNFQMzGXW3QiU3foQ4q9Ls2zcroKQ13m7xGx1hBl9l+
         NqUoWv2zmJkz/H2iJi/OF2eyCN0/WLpgDzMyHpd4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MKbkC-1lYrq810ou-00L0YC; Sun, 21 Feb 2021 19:03:36 +0100
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
Subject: [PATCH v3 4/8] security/brute: Fine tuning the attack detection
Date:   Sun, 21 Feb 2021 16:49:15 +0100
Message-Id: <20210221154919.68050-5-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210221154919.68050-1-john.wood@gmx.com>
References: <20210221154919.68050-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rkNIKAEZwyV/bGfKjZkxQz4xaYgQW1TaIzaUwxyrYEzhH6Sefn2
 seT1xzz616pi5f0ymMmYLx2P3NZ9vjTJOtELxqdxYmicTxNfz7lrY675CbwAyJllCsKYbG6
 XniKI6DEtR49Qo1EP8Rvblu5/1dxzqbPyY/uDpurHz1ZG4HCsv+9hCDFl94n85qvviO9UNd
 ZQ1mEEEBPDehF3deuxqvA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9ouCnryJP/4=:rv7CZb2nDQgvl6EB5ihYev
 FsDPcM5e5ZJRQbvUlPJ9RkiBw4m2dyM+us85cCx8Is0XLgAZ6O6rQ+kGF0Y9+fMGydfgEnYK4
 DeZUQq5QAjPWJ2ECzA0Jya6axhkm8eaXZCtzuaEJChklYbuZpKwhv+N02I8RiJ8uzLp0NK/Ip
 wW+uofOIpC4GPQr5/JuTAScskdZkkwJ5Euzj9CxIjwPTFfkw+9j55DBKYzVi4DHhNF82hnI7i
 DsozO82JLZb3yspoFfggZCelP5gfW3GMeW/iM9TpRwUSMDVU5KftAGMzkXnHdlrkzYhbZBmva
 IuOyIjEzZApn/06PLshG6tGsI7Sz1PaL2FRNPR/Ib+OHmhgjG2m9Zg/ouqOKFwfGhOkVw7qqh
 zzIbrqF+cdzUFQyjyA/6P/ZNljP11ywTyfK7pUV1SydwdafN+ADwfMs777rJh7KxGlzpd2KKG
 G1aY8bkynfx2rIdMWWRth8K0LfqIXSO/WkMhAe9MF2hiWRqTkh7yQJM3gozrr8yyrsn/Nh2fC
 0tNwn/b77ldhTdWvh++MxO37JV/AjuBkI3km7VBpJXCNqsqjvMJLhyMBI/FgH0JkuZK36CKTA
 K6IjTEeeWkFqjftnJT1GMobWcolu3wKQyKRjy6y0+6ngpw3rYEV/IRgyHadivCzPVNtbrEEQZ
 LpHyT0eFUGSe8dTgijz+EbZMJJoiJu2TEvphtOCExdylwRnHINX65qdCwmkZ/WXYr5Wf8B0Bm
 t/DKxrbWZ0KIX6+XnUK7o5mCLIWt/V5XRANILb/Df9tBMbWGmOvWIZ4qvZdmtIa8Fj7FS6lq6
 YAnDT8DwjEMiRmzSRWFWJO9rVitwFvU+AHPNXwv9rKSSQMCy3Nhlg6NkKsbw6ek0n9a1nPwSX
 FAOQTHlRfWm7qONaum8A==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid false positives during the attack detection it is necessary to
narrow the possible cases. Only the following scenarios are taken into
account:

1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
    desirable memory layout is got (e.g. Stack Clash).
2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly
    until a desirable memory layout is got (e.g. what CTFs do for simple
    network service).
3.- Launching processes without exec() (e.g. Android Zygote) and exposing
    state to attack a sibling.
4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly unti=
l
    the previously shared memory layout of all the other children is
    exposed (e.g. kind of related to HeartBleed).

In each case, a privilege boundary has been crossed:

Case 1: setuid/setgid process
Case 2: network to local
Case 3: privilege changes
Case 4: network to local

So, this patch checks if any of these privilege boundaries have been
crossed before to compute the application crash period.

Also, in every fatal crash only the signals delivered by the kernel are
taken into account with the exception of the SIGABRT signal since the
latter is used by glibc for stack canary, malloc, etc failures, which may
indicate that a mitigation has been triggered.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 293 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 280 insertions(+), 13 deletions(-)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index 645bd6e02638..8d03ea0ecac5 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -3,15 +3,25 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <asm/current.h>
+#include <asm/rwonce.h>
+#include <asm/siginfo.h>
+#include <asm/signal.h>
+#include <linux/binfmts.h>
 #include <linux/bug.h>
 #include <linux/compiler.h>
+#include <linux/cred.h>
+#include <linux/dcache.h>
 #include <linux/errno.h>
+#include <linux/fs.h>
 #include <linux/gfp.h>
+#include <linux/if.h>
 #include <linux/init.h>
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/lsm_hooks.h>
 #include <linux/math64.h>
+#include <linux/netdevice.h>
+#include <linux/path.h>
 #include <linux/printk.h>
 #include <linux/refcount.h>
 #include <linux/rwlock.h>
@@ -19,9 +29,35 @@
 #include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/task.h>
+#include <linux/signal.h>
+#include <linux/skbuff.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/stat.h>
 #include <linux/types.h>
+#include <linux/uidgid.h>
+
+/**
+ * struct brute_cred - Saved credentials.
+ * @uid: Real UID of the task.
+ * @gid: Real GID of the task.
+ * @suid: Saved UID of the task.
+ * @sgid: Saved GID of the task.
+ * @euid: Effective UID of the task.
+ * @egid: Effective GID of the task.
+ * @fsuid: UID for VFS ops.
+ * @fsgid: GID for VFS ops.
+ */
+struct brute_cred {
+	kuid_t uid;
+	kgid_t gid;
+	kuid_t suid;
+	kgid_t sgid;
+	kuid_t euid;
+	kgid_t egid;
+	kuid_t fsuid;
+	kgid_t fsgid;
+};

 /**
  * struct brute_stats - Fork brute force attack statistics.
@@ -30,6 +66,9 @@
  * @faults: Number of crashes.
  * @jiffies: Last crash timestamp.
  * @period: Crash period's moving average.
+ * @saved_cred: Saved credentials.
+ * @network: Network activity flag.
+ * @bounds_crossed: Privilege bounds crossed flag.
  *
  * This structure holds the statistical data shared by all the fork hiera=
rchy
  * processes.
@@ -40,6 +79,9 @@ struct brute_stats {
 	unsigned char faults;
 	u64 jiffies;
 	u64 period;
+	struct brute_cred saved_cred;
+	unsigned char network : 1;
+	unsigned char bounds_crossed : 1;
 };

 /**
@@ -71,18 +113,25 @@ static inline struct brute_stats **brute_stats_ptr(st=
ruct task_struct *task)

 /**
  * brute_new_stats() - Allocate a new statistics structure.
+ * @network_to_local: Network activity followed by a fork or execve syste=
m call.
+ * @is_setid: The executable file has the setid flags set.
  *
  * If the allocation is successful the reference counter is set to one to
  * indicate that there will be one task that points to this structure. Al=
so, the
  * last crash timestamp is set to now. This way, it is possible to comput=
e the
  * application crash period at the first fault.
  *
+ * Moreover, the credentials of the current task are saved. Also, the net=
work
+ * and bounds_crossed flags are set based on the network_to_local and is_=
setid
+ * parameters.
+ *
  * Return: NULL if the allocation fails. A pointer to the new allocated
  *         statistics structure if it success.
  */
-static struct brute_stats *brute_new_stats(void)
+static struct brute_stats *brute_new_stats(bool network_to_local, bool is=
_setid)
 {
 	struct brute_stats *stats;
+	const struct cred *cred =3D current_cred();

 	stats =3D kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);
 	if (!stats)
@@ -93,6 +142,16 @@ static struct brute_stats *brute_new_stats(void)
 	stats->faults =3D 0;
 	stats->jiffies =3D get_jiffies_64();
 	stats->period =3D 0;
+	stats->saved_cred.uid =3D cred->uid;
+	stats->saved_cred.gid =3D cred->gid;
+	stats->saved_cred.suid =3D cred->suid;
+	stats->saved_cred.sgid =3D cred->sgid;
+	stats->saved_cred.euid =3D cred->euid;
+	stats->saved_cred.egid =3D cred->egid;
+	stats->saved_cred.fsuid =3D cred->fsuid;
+	stats->saved_cred.fsgid =3D cred->fsgid;
+	stats->network =3D network_to_local;
+	stats->bounds_crossed =3D network_to_local || is_setid;

 	return stats;
 }
@@ -137,6 +196,10 @@ static void brute_share_stats(struct brute_stats *src=
,
  * this task and the new one being allocated. Otherwise, share the statis=
tics
  * that the current task already has.
  *
+ * Also, if the shared statistics indicate a previous network activity, t=
he
+ * bounds_crossed flag must be set to show that a network-to-local privil=
ege
+ * boundary has been crossed.
+ *
  * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
  * and brute_stats::lock since the task_free hook can be called from an I=
RQ
  * context during the execution of the task_alloc hook.
@@ -155,11 +218,14 @@ static int brute_task_alloc(struct task_struct *task=
, unsigned long clone_flags)

 	if (likely(*p_stats)) {
 		brute_share_stats(*p_stats, stats);
+		spin_lock(&(*stats)->lock);
+		(*stats)->bounds_crossed |=3D (*stats)->network;
+		spin_unlock(&(*stats)->lock);
 		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return 0;
 	}

-	*stats =3D brute_new_stats();
+	*stats =3D brute_new_stats(false, false);
 	if (!*stats) {
 		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return -ENOMEM;
@@ -170,6 +236,61 @@ static int brute_task_alloc(struct task_struct *task,=
 unsigned long clone_flags)
 	return 0;
 }

+/**
+ * brute_is_setid() - Test if the executable file has the setid flags set=
.
+ * @bprm: Points to the linux_binprm structure.
+ *
+ * Return: True if the executable file has the setid flags set. False oth=
erwise.
+ */
+static bool brute_is_setid(const struct linux_binprm *bprm)
+{
+	struct file *file =3D bprm->file;
+	struct inode *inode;
+	umode_t mode;
+
+	if (!file)
+		return false;
+
+	inode =3D file->f_path.dentry->d_inode;
+	mode =3D inode->i_mode;
+
+	return !!(mode & (S_ISUID | S_ISGID));
+}
+
+/**
+ * brute_reset_stats() - Reset the statistical data.
+ * @stats: Statistics to be reset.
+ * @is_setid: The executable file has the setid flags set.
+ *
+ * Reset the faults and period and set the last crash timestamp to now. T=
his
+ * way, it is possible to compute the application crash period at the nex=
t
+ * fault. Also, save the credentials of the current task and update the
+ * bounds_crossed flag based on a previous network activity and the is_se=
tid
+ * parameter.
+ *
+ * The statistics to be reset cannot be NULL.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          and brute_stats::lock held.
+ */
+static void brute_reset_stats(struct brute_stats *stats, bool is_setid)
+{
+	const struct cred *cred =3D current_cred();
+
+	stats->faults =3D 0;
+	stats->jiffies =3D get_jiffies_64();
+	stats->period =3D 0;
+	stats->saved_cred.uid =3D cred->uid;
+	stats->saved_cred.gid =3D cred->gid;
+	stats->saved_cred.suid =3D cred->suid;
+	stats->saved_cred.sgid =3D cred->sgid;
+	stats->saved_cred.euid =3D cred->euid;
+	stats->saved_cred.egid =3D cred->egid;
+	stats->saved_cred.fsuid =3D cred->fsuid;
+	stats->saved_cred.fsgid =3D cred->fsgid;
+	stats->bounds_crossed =3D stats->network || is_setid;
+}
+
 /**
  * brute_task_execve() - Target for the bprm_committing_creds hook.
  * @bprm: Points to the linux_binprm structure.
@@ -188,6 +309,11 @@ static int brute_task_alloc(struct task_struct *task,=
 unsigned long clone_flags)
  * only one task (the task that calls the execve function) points to the =
data.
  * In this case, the previous allocation is used but the statistics are r=
eset.
  *
+ * Also, if the statistics of the process that calls the execve system ca=
ll
+ * indicate a previous network activity or the executable file has the se=
tid
+ * flags set, the bounds_crossed flag must be set to show that a network =
to
+ * local privilege boundary or setid boundary has been crossed respective=
ly.
+ *
  * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
  * and brute_stats::lock since the task_free hook can be called from an I=
RQ
  * context during the execution of the bprm_committing_creds hook.
@@ -196,6 +322,8 @@ static void brute_task_execve(struct linux_binprm *bpr=
m)
 {
 	struct brute_stats **stats;
 	unsigned long flags;
+	bool network_to_local;
+	bool is_setid =3D false;

 	stats =3D brute_stats_ptr(current);
 	read_lock_irqsave(&brute_stats_ptr_lock, flags);
@@ -206,12 +334,18 @@ static void brute_task_execve(struct linux_binprm *b=
prm)
 	}

 	spin_lock(&(*stats)->lock);
+	network_to_local =3D (*stats)->network;
+
+	/*
+	 * A network_to_local flag equal to true will set the bounds_crossed
+	 * flag. So, in this scenario the "is setid" test can be avoided.
+	 */
+	if (!network_to_local)
+		is_setid =3D brute_is_setid(bprm);

 	if (!refcount_dec_not_one(&(*stats)->refc)) {
 		/* execve call after an execve call */
-		(*stats)->faults =3D 0;
-		(*stats)->jiffies =3D get_jiffies_64();
-		(*stats)->period =3D 0;
+		brute_reset_stats(*stats, is_setid);
 		spin_unlock(&(*stats)->lock);
 		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return;
@@ -222,7 +356,7 @@ static void brute_task_execve(struct linux_binprm *bpr=
m)
 	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);

 	write_lock_irqsave(&brute_stats_ptr_lock, flags);
-	*stats =3D brute_new_stats();
+	*stats =3D brute_new_stats(network_to_local, is_setid);
 	WARN(!*stats, "Cannot allocate statistical data\n");
 	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 }
@@ -648,12 +782,103 @@ static void brute_manage_exec_attack(struct brute_s=
tats *stats, u64 now,
 		print_exec_attack_running(exec_stats);
 }

+/**
+ * brute_priv_have_changed() - Test if the privileges have changed.
+ * @stats: Statistics that hold the saved credentials.
+ *
+ * The privileges have changed if the credentials of the current task are
+ * different from the credentials saved in the statistics structure.
+ *
+ * The statistics that hold the saved credentials cannot be NULL.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          and brute_stats::lock held.
+ * Return: True if the privileges have changed. False otherwise.
+ */
+static bool brute_priv_have_changed(struct brute_stats *stats)
+{
+	const struct cred *cred =3D current_cred();
+	bool priv_have_changed;
+
+	priv_have_changed =3D !uid_eq(stats->saved_cred.uid, cred->uid) ||
+		!gid_eq(stats->saved_cred.gid, cred->gid) ||
+		!uid_eq(stats->saved_cred.suid, cred->suid) ||
+		!gid_eq(stats->saved_cred.sgid, cred->sgid) ||
+		!uid_eq(stats->saved_cred.euid, cred->euid) ||
+		!gid_eq(stats->saved_cred.egid, cred->egid) ||
+		!uid_eq(stats->saved_cred.fsuid, cred->fsuid) ||
+		!gid_eq(stats->saved_cred.fsgid, cred->fsgid);
+
+	return priv_have_changed;
+}
+
+/**
+ * brute_threat_model_supported() - Test if the threat model is supported=
.
+ * @siginfo: Contains the signal information.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * To avoid false positives during the attack detection it is necessary t=
o
+ * narrow the possible cases. Only the following scenarios are taken into
+ * account:
+ *
+ * 1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until=
 a
+ *     desirable memory layout is got (e.g. Stack Clash).
+ * 2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly=
 until
+ *     a desirable memory layout is got (e.g. what CTFs do for simple net=
work
+ *     service).
+ * 3.- Launching processes without exec() (e.g. Android Zygote) and expos=
ing
+ *     state to attack a sibling.
+ * 4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly =
until
+ *     the previously shared memory layout of all the other children is e=
xposed
+ *     (e.g. kind of related to HeartBleed).
+ *
+ * In each case, a privilege boundary has been crossed:
+ *
+ * Case 1: setuid/setgid process
+ * Case 2: network to local
+ * Case 3: privilege changes
+ * Case 4: network to local
+ *
+ * Also, only the signals delivered by the kernel are taken into account =
with
+ * the exception of the SIGABRT signal since the latter is used by glibc =
for
+ * stack canary, malloc, etc failures, which may indicate that a mitigati=
on has
+ * been triggered.
+ *
+ * The signal information and the statistical data shared by all the fork
+ * hierarchy processes cannot be NULL.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
+ * Return: True if the threat model is supported. False otherwise.
+ */
+static bool brute_threat_model_supported(const kernel_siginfo_t *siginfo,
+					 struct brute_stats *stats)
+{
+	bool bounds_crossed;
+
+	if (siginfo->si_signo =3D=3D SIGKILL && siginfo->si_code !=3D SIGABRT)
+		return false;
+
+	spin_lock(&stats->lock);
+	bounds_crossed =3D stats->bounds_crossed;
+	bounds_crossed =3D bounds_crossed || brute_priv_have_changed(stats);
+	stats->bounds_crossed =3D bounds_crossed;
+	spin_unlock(&stats->lock);
+
+	return bounds_crossed;
+}
+
 /**
  * brute_task_fatal_signal() - Target for the task_fatal_signal hook.
  * @siginfo: Contains the signal information.
  *
- * To detect a brute force attack is necessary to update the fork and exe=
c
- * statistics in every fatal crash and act based on these data.
+ * To detect a brute force attack it is necessary, as a first step, to te=
st in
+ * every fatal crash if the threat model is supported. If so, update the =
fork
+ * and exec statistics and act based on these data.
  *
  * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
  * and brute_stats::lock since the task_free hook can be called from an I=
RQ
@@ -670,18 +895,59 @@ static void brute_task_fatal_signal(const kernel_sig=
info_t *siginfo)
 	read_lock(&tasklist_lock);
 	read_lock_irqsave(&brute_stats_ptr_lock, flags);

-	if (WARN(!*stats, "No statistical data\n")) {
-		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
-		read_unlock(&tasklist_lock);
-		return;
-	}
+	if (WARN(!*stats, "No statistical data\n"))
+		goto unlock;
+
+	if (!brute_threat_model_supported(siginfo, *stats))
+		goto unlock;

 	last_fork_crash =3D brute_manage_fork_attack(*stats, now);
 	brute_manage_exec_attack(*stats, now, last_fork_crash);
+unlock:
 	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 	read_unlock(&tasklist_lock);
 }

+/**
+ * brute_network() - Target for the socket_sock_rcv_skb hook.
+ * @sk: Contains the sock (not socket) associated with the incoming sk_bu=
ff.
+ * @skb: Contains the incoming network data.
+ *
+ * A previous step to detect that a network to local boundary has been cr=
ossed
+ * is to detect if there is network activity. To do this, it is only nece=
ssary
+ * to check if there are data packets received from a network device othe=
r than
+ * loopback.
+ *
+ * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
+ * and brute_stats::lock since the task_free hook can be called from an I=
RQ
+ * context during the execution of the socket_sock_rcv_skb hook.
+ *
+ * Return: -EFAULT if the current task doesn't have statistical data. Zer=
o
+ *         otherwise.
+ */
+static int brute_network(struct sock *sk, struct sk_buff *skb)
+{
+	struct brute_stats **stats;
+	unsigned long flags;
+
+	if (!skb->dev || (skb->dev->flags & IFF_LOOPBACK))
+		return 0;
+
+	stats =3D brute_stats_ptr(current);
+	read_lock_irqsave(&brute_stats_ptr_lock, flags);
+
+	if (!*stats) {
+		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
+		return -EFAULT;
+	}
+
+	spin_lock(&(*stats)->lock);
+	(*stats)->network =3D true;
+	spin_unlock(&(*stats)->lock);
+	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
+	return 0;
+}
+
 /**
  * brute_hooks - Targets for the LSM's hooks.
  */
@@ -690,6 +956,7 @@ static struct security_hook_list brute_hooks[] __lsm_r=
o_after_init =3D {
 	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
 	LSM_HOOK_INIT(task_free, brute_task_free),
 	LSM_HOOK_INIT(task_fatal_signal, brute_task_fatal_signal),
+	LSM_HOOK_INIT(socket_sock_rcv_skb, brute_network),
 };

 /**
=2D-
2.25.1

