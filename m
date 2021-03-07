Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499BE3300BF
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 13:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhCGMQD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 07:16:03 -0500
Received: from mout.gmx.net ([212.227.15.15]:55367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhCGMPv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 07:15:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615119302;
        bh=HBg6nwzMK9rUlr84ocCvFvuMxv6lgyd43Gr97J+P9q0=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KehiecDsqXGSV2TEZH7RSNp/Gb/KZIMF882moAJ4+MD4SDBd9mwrZIr8nRn/yo7Cm
         O5cCHPd4ycI+0+3T+wEewDuMQUi7wX+GKha+gtD/P/x6vHjGIbcQareKy3ta+cHXgb
         088+GT4Jhze+H4MZR9alaZ6EnbrWF0jTBOLNV93g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MD9T1-1lRyzv2VNZ-0094kc; Sun, 07 Mar 2021 13:15:02 +0100
From:   John Wood <john.wood@gmx.com>
To:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morris <jmorris@namei.org>, Shuah Khan <shuah@kernel.org>
Cc:     John Wood <john.wood@gmx.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Subject: [PATCH v6 2/8] security/brute: Define a LSM and manage statistical data
Date:   Sun,  7 Mar 2021 12:30:25 +0100
Message-Id: <20210307113031.11671-3-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210307113031.11671-1-john.wood@gmx.com>
References: <20210307113031.11671-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FAIaqHKd9DFkeVPKuFxziNufcLTrbdDB19dh73Z1IY7KMJVJLxv
 w+bDRZncVD9Knjg6A5DyP/+Rs2i2YC78YJYisYJCWFndaH79FEEGTssoTdi890yEmwDwzpV
 jFlTGqNsA2oCvPlIMwMa/FjlL2b23oBggMO2aXR7b+XSLAQ5U8x1Q3TiUBlhdcUl0uHSWrn
 3PdpuzznoOawKttsl38Pg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mRU4VFHySEI=:5DtJl+hYwWLLbgz5L07ygH
 5rWJhdBrIS7b45E2DWoojd07JOLlquTXs+k/qcDL81J2oLEXs4T0CGNJnD1RYhFDeUYvnXuVS
 m8mxEruz5tWhlfNX+By1X4wC9Pkx1TH2Og8dW0eEs1B1a61731uagrA5TQflfeHYCwT2i8Pzh
 JU+nmf/hXkefkHqbYuhkP8dGMm6G2TBhTStfqt0KJ9+k6fuD1cCLPCH8fOHCif5nx+LsUrWoQ
 +irmDxnkrsWNAq32vO9cT3jSv+9XPUOd3v7ws5Eke7Wn1aLh8y+FH+SNUWSiBToz2kGhzoAjz
 9XmpW5W+TkVhPNMsLytN0dhHWJXlIQuRgtOINNIHoFyORmLnjnxm/a1GgFRtOadymDVCkG6oo
 2gN7pA+9ju8Tz4J3vjxI3aw1WSMRnEl9lKYFK/6Q2mNwfsjLiVOx2g2lEm6N1+sZi5w6JQL6i
 2OilvV1n+g8bMWI4NNztam5q2hrm1SK0Kb8G3Mac6uEbwyCeyb6MnuY1zhFKSfLYiGFchx2eV
 Z2WAQep6X3r01zytueZiqostH+l5+U0ISTkMitpI7MfAZ11pDS6baBveGYh5o5i7rcyuV2FYq
 tEaO3Muec04dIleI+y7EXeohWKS1R5N/kAYYcV+f/vXvVlL0BrXn0ef0baa44F5L4edldHvP1
 Zb2jJRFzeb8PIvkiAM7zWRtFyXNz71Tn1NQL+ZE4Jf8dovOialjXTMuGPohnfHJHdBqoJw8Ex
 Ce/6DsAIeZTJbrQCSdSNL2E1iHfN+NBl240hBus5GkKJ4ricx2nTB0o8wUSuUAcdvCLCYRFc+
 Kcp/TZbRJaHvXBGtAfqsd6nd/6FG6W6gigGv6AvezkLNa/6nInc3GPsEnMQRTGMoKkuzKU4FU
 EZpAgibuEtb1auR0KOKA==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new Kconfig file to define a menu entry under "Security options"
to enable the "Fork brute force attack detection and mitigation"
feature.

For a correct management of a fork brute force attack it is necessary
that all the tasks hold statistical data. The same statistical data
needs to be shared between all the tasks that hold the same memory
contents or in other words, between all the tasks that have been forked
without any execve call. So, define a statistical data structure to hold
all the necessary information shared by all the fork hierarchy
processes. This info is basically the number of crashes, the last crash
timestamp and the crash period's moving average.

When a forked task calls the execve system call, the memory contents are
set with new values. So, in this scenario the parent's statistical data
no need to be shared. Instead, a new statistical data structure must be
allocated to start a new hierarchy.

The statistical data that is shared between all the fork hierarchy
processes needs to be freed when this hierarchy disappears.

So, based in all the previous information define a LSM with three hooks
to manage all the commented cases. These hooks are "task_alloc" to do
the fork management, "bprm_committing_creds" to do the execve management
and "task_free" to release the resources.

Also, add to the task_struct's security blob the pointer to the
statistical data. This way, all the tasks will have access to this
information.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/Kconfig        |  11 +-
 security/Makefile       |   4 +
 security/brute/Kconfig  |  12 ++
 security/brute/Makefile |   2 +
 security/brute/brute.c  | 257 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 281 insertions(+), 5 deletions(-)
 create mode 100644 security/brute/Kconfig
 create mode 100644 security/brute/Makefile
 create mode 100644 security/brute/brute.c

diff --git a/security/Kconfig b/security/Kconfig
index 7561f6f99f1d..204bb311b1f1 100644
=2D-- a/security/Kconfig
+++ b/security/Kconfig
@@ -240,6 +240,7 @@ source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"

 source "security/integrity/Kconfig"
+source "security/brute/Kconfig"

 choice
 	prompt "First legacy 'major LSM' to be initialized"
@@ -277,11 +278,11 @@ endchoice

 config LSM
 	string "Ordered list of enabled LSMs"
-	default "lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,=
apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smac=
k,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAUL=
T_SECURITY_TOMOYO
-	default "lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECUR=
ITY_DAC
-	default "lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,=
apparmor,bpf"
+	default "brute,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,t=
omoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "brute,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinu=
x,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "brute,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if =
DEFAULT_SECURITY_TOMOYO
+	default "brute,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT=
_SECURITY_DAC
+	default "brute,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,t=
omoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index 3baf435de541..1236864876da 100644
=2D-- a/security/Makefile
+++ b/security/Makefile
@@ -36,3 +36,7 @@ obj-$(CONFIG_BPF_LSM)			+=3D bpf/
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+=3D integrity
 obj-$(CONFIG_INTEGRITY)			+=3D integrity/
+
+# Object brute file lists
+subdir-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute
+obj-$(CONFIG_SECURITY_FORK_BRUTE)	+=3D brute/
diff --git a/security/brute/Kconfig b/security/brute/Kconfig
new file mode 100644
index 000000000000..1bd2df1e2dec
=2D-- /dev/null
+++ b/security/brute/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+config SECURITY_FORK_BRUTE
+	bool "Fork brute force attack detection and mitigation"
+	depends on SECURITY
+	help
+	  This is an LSM that stops any fork brute force attack against
+	  vulnerable userspace processes. The detection method is based on
+	  the application crash period and as a mitigation procedure all the
+	  offending tasks are killed. Like capabilities, this security module
+	  stacks with other LSMs.
+
+	  If you are unsure how to answer this question, answer N.
diff --git a/security/brute/Makefile b/security/brute/Makefile
new file mode 100644
index 000000000000..d3f233a132a9
=2D-- /dev/null
+++ b/security/brute/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_SECURITY_FORK_BRUTE) +=3D brute.o
diff --git a/security/brute/brute.c b/security/brute/brute.c
new file mode 100644
index 000000000000..99d099e45112
=2D-- /dev/null
+++ b/security/brute/brute.c
@@ -0,0 +1,257 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <asm/current.h>
+#include <linux/bug.h>
+#include <linux/compiler.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/init.h>
+#include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/lsm_hooks.h>
+#include <linux/printk.h>
+#include <linux/refcount.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+/**
+ * struct brute_stats - Fork brute force attack statistics.
+ * @lock: Lock to protect the brute_stats structure.
+ * @refc: Reference counter.
+ * @faults: Number of crashes.
+ * @jiffies: Last crash timestamp.
+ * @period: Crash period's moving average.
+ *
+ * This structure holds the statistical data shared by all the fork hiera=
rchy
+ * processes.
+ */
+struct brute_stats {
+	spinlock_t lock;
+	refcount_t refc;
+	unsigned char faults;
+	u64 jiffies;
+	u64 period;
+};
+
+/*
+ * brute_blob_sizes - LSM blob sizes.
+ *
+ * To share statistical data among all the fork hierarchy processes, defi=
ne a
+ * pointer to the brute_stats structure as a part of the task_struct's se=
curity
+ * blob.
+ */
+static struct lsm_blob_sizes brute_blob_sizes __lsm_ro_after_init =3D {
+	.lbs_task =3D sizeof(struct brute_stats *),
+};
+
+/**
+ * brute_stats_ptr() - Get the pointer to the brute_stats structure.
+ * @task: Task that holds the statistical data.
+ *
+ * Return: A pointer to a pointer to the brute_stats structure.
+ */
+static inline struct brute_stats **brute_stats_ptr(struct task_struct *ta=
sk)
+{
+	return task->security + brute_blob_sizes.lbs_task;
+}
+
+/**
+ * brute_new_stats() - Allocate a new statistics structure.
+ *
+ * If the allocation is successful the reference counter is set to one to
+ * indicate that there will be one task that points to this structure. Al=
so, the
+ * last crash timestamp is set to now. This way, it is possible to comput=
e the
+ * application crash period at the first fault.
+ *
+ * Return: NULL if the allocation fails. A pointer to the new allocated
+ *         statistics structure if it success.
+ */
+static struct brute_stats *brute_new_stats(void)
+{
+	struct brute_stats *stats;
+
+	stats =3D kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
+	if (!stats)
+		return NULL;
+
+	spin_lock_init(&stats->lock);
+	refcount_set(&stats->refc, 1);
+	stats->faults =3D 0;
+	stats->jiffies =3D get_jiffies_64();
+	stats->period =3D 0;
+
+	return stats;
+}
+
+/**
+ * brute_share_stats() - Share the statistical data between processes.
+ * @src: Source of statistics to be shared.
+ * @dst: Destination of statistics to be shared.
+ *
+ * Copy the src's pointer to the statistical data structure to the dst's =
pointer
+ * to the same structure. Since there is a new process that shares the sa=
me
+ * data, increase the reference counter. The src's pointer cannot be NULL=
.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_alloc hook.
+ */
+static void brute_share_stats(struct brute_stats *src,
+			      struct brute_stats **dst)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&src->lock, flags);
+	refcount_inc(&src->refc);
+	*dst =3D src;
+	spin_unlock_irqrestore(&src->lock, flags);
+}
+
+/**
+ * brute_task_alloc() - Target for the task_alloc hook.
+ * @task: Task being allocated.
+ * @clone_flags: Contains the flags indicating what should be shared.
+ *
+ * For a correct management of a fork brute force attack it is necessary =
that
+ * all the tasks hold statistical data. The same statistical data needs t=
o be
+ * shared between all the tasks that hold the same memory contents or in =
other
+ * words, between all the tasks that have been forked without any execve =
call.
+ *
+ * To ensure this, if the current task doesn't have statistical data when=
 forks,
+ * it is mandatory to allocate a new statistics structure and share it be=
tween
+ * this task and the new one being allocated. Otherwise, share the statis=
tics
+ * that the current task already has.
+ *
+ * Return: -ENOMEM if the allocation of the new statistics structure fail=
s. Zero
+ *         otherwise.
+ */
+static int brute_task_alloc(struct task_struct *task, unsigned long clone=
_flags)
+{
+	struct brute_stats **stats, **p_stats;
+
+	stats =3D brute_stats_ptr(task);
+	p_stats =3D brute_stats_ptr(current);
+
+	if (likely(*p_stats)) {
+		brute_share_stats(*p_stats, stats);
+		return 0;
+	}
+
+	*stats =3D brute_new_stats();
+	if (!*stats)
+		return -ENOMEM;
+
+	brute_share_stats(*stats, p_stats);
+	return 0;
+}
+
+/**
+ * brute_task_execve() - Target for the bprm_committing_creds hook.
+ * @bprm: Points to the linux_binprm structure.
+ *
+ * When a forked task calls the execve system call, the memory contents a=
re set
+ * with new values. So, in this scenario the parent's statistical data no=
 need
+ * to be shared. Instead, a new statistical data structure must be alloca=
ted to
+ * start a new hierarchy. This condition is detected when the statistics
+ * reference counter holds a value greater than or equal to two (a fork a=
lways
+ * sets the statistics reference counter to a minimum of two since the pa=
rent
+ * and the child task are sharing the same data).
+ *
+ * However, if the execve function is called immediately after another ex=
ecve
+ * call, althought the memory contents are reset, there is no need to all=
ocate
+ * a new statistical data structure. This is possible because at this mom=
ent
+ * only one task (the task that calls the execve function) points to the =
data.
+ * In this case, the previous allocation is used but the statistics are r=
eset.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the bprm_committing_creds hook.
+ */
+static void brute_task_execve(struct linux_binprm *bprm)
+{
+	struct brute_stats **stats;
+	unsigned long flags;
+
+	stats =3D brute_stats_ptr(current);
+	if (WARN(!*stats, "No statistical data\n"))
+		return;
+
+	spin_lock_irqsave(&(*stats)->lock, flags);
+
+	if (!refcount_dec_not_one(&(*stats)->refc)) {
+		/* execve call after an execve call */
+		(*stats)->faults =3D 0;
+		(*stats)->jiffies =3D get_jiffies_64();
+		(*stats)->period =3D 0;
+		spin_unlock_irqrestore(&(*stats)->lock, flags);
+		return;
+	}
+
+	/* execve call after a fork call */
+	spin_unlock_irqrestore(&(*stats)->lock, flags);
+	*stats =3D brute_new_stats();
+	WARN(!*stats, "Cannot allocate statistical data\n");
+}
+
+/**
+ * brute_task_free() - Target for the task_free hook.
+ * @task: Task about to be freed.
+ *
+ * The statistical data that is shared between all the fork hierarchy pro=
cesses
+ * needs to be freed when this hierarchy disappears.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_free hook.
+ */
+static void brute_task_free(struct task_struct *task)
+{
+	struct brute_stats **stats;
+	unsigned long flags;
+	bool refc_is_zero;
+
+	stats =3D brute_stats_ptr(task);
+	if (WARN(!*stats, "No statistical data\n"))
+		return;
+
+	spin_lock_irqsave(&(*stats)->lock, flags);
+	refc_is_zero =3D refcount_dec_and_test(&(*stats)->refc);
+	spin_unlock_irqrestore(&(*stats)->lock, flags);
+
+	if (refc_is_zero) {
+		kfree(*stats);
+		*stats =3D NULL;
+	}
+}
+
+/*
+ * brute_hooks - Targets for the LSM's hooks.
+ */
+static struct security_hook_list brute_hooks[] __lsm_ro_after_init =3D {
+	LSM_HOOK_INIT(task_alloc, brute_task_alloc),
+	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
+	LSM_HOOK_INIT(task_free, brute_task_free),
+};
+
+/**
+ * brute_init() - Initialize the brute LSM.
+ *
+ * Return: Always returns zero.
+ */
+static int __init brute_init(void)
+{
+	pr_info("Brute initialized\n");
+	security_add_hooks(brute_hooks, ARRAY_SIZE(brute_hooks),
+			   KBUILD_MODNAME);
+	return 0;
+}
+
+DEFINE_LSM(brute) =3D {
+	.name =3D KBUILD_MODNAME,
+	.init =3D brute_init,
+	.blobs =3D &brute_blob_sizes,
+};
=2D-
2.25.1

