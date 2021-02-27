Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62944326E0C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 18:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhB0RAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 12:00:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:46397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230001AbhB0Q7v (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 11:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614445047;
        bh=SJ2STixNt0PyHngT/tiJ3uhIXPFdc+NSRSH1mAaXNlM=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=kk0rutEsjrywZbaGeKW4Qg+vakTIglVmnIjrc6QY1hVEQJymoN/1P1aqltHNkmMGb
         rizl4btZ2NEFafFRXIc8kWC1e9OVR85gOx08CO2jETOidiGjUX7iQfGpMJkOVgYZ4c
         4sLJgyLOY92MUJ9kGQ5R/I21jLVbIkZKYzu36Sj0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MZCbB-1lKbBP3xhp-00VARV; Sat, 27 Feb 2021 17:57:27 +0100
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
Subject: [PATCH v5 4/8] security/brute: Fine tuning the attack detection
Date:   Sat, 27 Feb 2021 16:30:09 +0100
Message-Id: <20210227153013.6747-5-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yn40DS4mJdQuKPVzadkjhT2DScePirPzJ8fREP8J8G8Rig3hU5E
 GH/IWR8VO6eAFVrES1ZfdO++lnJCEUioggFdwxMpDqKz0dUAdr5Hx42H9vmJjthehQ+suc3
 PArJfqpFPCQMHvXQ7x8rGT1PtoP53hbCM11qS5jQ+1OUHs1+IrIGsUU/SU99x21w7bPqUr+
 GZYw4hFxzjzbpGRva1FgQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:btTvl7/folo=:oKP2bWtdEKLK10rmjQkYmZ
 ohTo8Ok81RGK+fGc5rCZeZD8thtz9PlkXParvM3qSROMHASwB208pGvOfCg4wsa6S2TCssaLv
 eDHeOv4V+4Dh+dYTKmGSQFoqyCaByuNwfvwf1NWD/53b71Mt50Es9ebhBP5o21c1LU0r9swCf
 wwi4SLzZ8gfV+ST0yPnLJlVFuDPNThEV4cr1BMzdd5AgT+XfZpXD3Z+NDdtl24OTxTNbeA/Dq
 s/lKbanafhqYnx+nK5jwz3YleGko+lqABw1DM5dtBXetngnEY16v50Oi/afYuCjmIbCn+eK/C
 oB1Ryz3RpKVgU0xeoQaMSLZH0VZDMQrXK955lDHDt3GOoPq6+w7RVcEyTnAGoG2TQnYnR9JgA
 rOXZ4WH0bxTf/AKyFC40jz0gBExRyTRcYb45ZIp6ddr5/42Uyqe8CfF43jeTtvkSZo25RWgHY
 6e7Yxlr5pM8/C1M8LnkSg4L3IBLrYxm9SH78z0X1tMlNed4sESReHfG2dKOUmUPLQ2yKaEbmS
 m235STy8zVuig444LzfsfGSqb+40ZwmTXRYd5+hXn+xMxNbRlQSCCoyFL09tiBd13lnc2v3w5
 /FWZzj5xdg2HK0URMSQiSumeRE7WwYRiollngI0sOO5d3Yqp/ci1oDxtMD17Iz+PJFxZwrIec
 r2r5eLxjkWLQFjrqyC+QDV15hd2RXfMc3+t2t90blO5TpvR5TxMiJODqlsPf+Jh9opin0JSR/
 EjdrbmoTZl27i0WP3nui6NiPSB/R8N6xwSaC+YzIRx8Tf/lCctMwh3HS0/HDFji8bKx5fmMNo
 NH3oeVYI+VMAtfKp4Bzs0WYsoi6ppCyyAvERvndW7vqGY6op1etoqsmMN/iThK7nBqcc32hVg
 J1zOgkaUGM1jVF0nL+zA==
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
index 7ebc8dbf5e86..0a99cd4c3303 100644
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

 /*
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
 /*
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

