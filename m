Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F838326DE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 17:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhB0Qht (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 11:37:49 -0500
Received: from mout.gmx.net ([212.227.15.18]:45161 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230132AbhB0Qhs (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 11:37:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614443740;
        bh=4OqQTeHT1sz7SLHXIOTourO5pyKXhKfPwzZOatWjvRs=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=b1mtcuLVJNdLLLCQk870GN4is+7rJGm4iRAVUhoObTZuTEaXCFrn40eTAnTJ/5w2l
         ZYL1fausgXTTJ+hFWYiiRR3ni27j46FyhwcYoB5Djx7+AIwrcE016SoiUUrdqp9onY
         bqjpP5wj3sG8QcgbbZ5lpZeR1fMyaJzkjo1bFi5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N33Ed-1lxFfF17ef-013NKj; Sat, 27 Feb 2021 17:35:40 +0100
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
Subject: [PATCH v5 3/8] securtiy/brute: Detect a brute force attack
Date:   Sat, 27 Feb 2021 16:30:08 +0100
Message-Id: <20210227153013.6747-4-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WlrRclMb4u4MUJFNJzjhpwNp0sFLdTjuPDqGeGfOpaazpTg/ESk
 bYvliiiUgt6FDenraxBQJvegSqvEQ/F694ev/ODqkZ+yKGkueHruq0H5l/oil72TK9ubwy4
 uhOiSGT0PVAN3PybRC3S+Mnl0trrPz7zOdUt2IAqIuMYMFjqBQgl0pxrlzGYCNnVUp8PCVE
 z5+Luy2AwagPOLjkdE1UA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:81YyVxIRsWY=:taccfePKMGhx0+zlWj+TX1
 56U4QAIE++NeYEFbcsaLgr2Pnyv5cgowUtH3GXnX+tuOQG7uqSDLIsMVCR2OeUdJjRAHPBj/w
 9Ah3mMZX188KjnoGCCj/+eUvn2V0m7uNVzFMOEmXMeGlPz+uj7R8aKyjsjgwEsjk59MGGrZMx
 MbYid6fqCJTIRmC+qB6O2vqILU5FO26zr1wlpAdnvxNEPW8TBNXc1Pvj+DeeTztOXS3m9+Vto
 RD1cDORFf8HtsZ3cLrAEz2EgRb6dtODUkkODvh/UwMAOr7CApPc6veRGeWcPUDhRRZXfRcrCw
 Keeg0RIvRqYfe7gXx1HrZHeXugkpkkJ1ZD2WrvWNg923hlEvd8cHSA2oELQ+EyMranw7hEv0e
 ENxQVLltjlfKJ45sb9zgc3BE+HT3si4ZqCninnxpDd9j1SlHXRKuRSGX+OU/DbDJn1CYTv6g1
 QCvgUT1y8QK1KnMabZWQ9z580imoh9+B4dW9ZzSIan5XdOqdXu4qSIWX9hC1LltJDC9JeONxP
 ykWOCFSA0q3OkVsrDs18NSmTJNw0CAMVKYWb2d6wkXRNLOVTo4RCK5w9zlFToaMzAe/sFAPb5
 oxM8OB8+ciDix7L81OgDSuv9dbspUAQOvR+KF5RRuBf6oPSB7s3QA03zvrYBMrMyAWCMTeJhA
 ryBXUJbeN5zg9lqv1l78ALtaFqehKrGWyoBme/gb/7t0zNbd3/UiTslUlTXb7IeqmpdKseFww
 Q4rPAVnKG5qv49XpXrwgfxKowCLKerXWNe6h3iQTlDK8Tg2FUjJB1egvNFE3lKeDEjIeTUrbQ
 xOtNlP9CqzeCSanEdlCLONBe4nZ2bzEeZYRX/u6DylAFJjZuKF2NDStIfnun6XetRxygXXqD4
 t1dAdBAifosK9VYl785w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To detect a brute force attack it is necessary that the statistics
shared by all the fork hierarchy processes be updated in every fatal
crash and the most important data to update is the application crash
period. To do so, use the new "task_fatal_signal" LSM hook added in a
previous step.

The application crash period must be a value that is not prone to change
due to spurious data and follows the real crash period. So, to compute
it, the exponential moving average (EMA) is used.

There are two types of brute force attacks that need to be detected. The
first one is an attack that happens through the fork system call and the
second one is an attack that happens through the execve system call. The
first type uses the statistics shared by all the fork hierarchy
processes, but the second type cannot use this statistical data due to
these statistics disappear when the involved tasks finished. In this
last scenario the attack info should be tracked by the statistics of a
higher fork hierarchy (the hierarchy that contains the process that
forks before the execve system call).

Moreover, these two attack types have two variants. A slow brute force
attack that is detected if the maximum number of faults per fork
hierarchy is reached and a fast brute force attack that is detected if
the application crash period falls below a certain threshold.

Also, this patch adds locking to protect the statistics pointer hold by
every process.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 488 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 474 insertions(+), 14 deletions(-)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index ece876695af1..7ebc8dbf5e86 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -11,9 +11,14 @@
 #include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/lsm_hooks.h>
+#include <linux/math64.h>
 #include <linux/printk.h>
 #include <linux/refcount.h>
+#include <linux/rwlock.h>
+#include <linux/rwlock_types.h>
 #include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/sched/task.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -37,6 +42,11 @@ struct brute_stats {
 	u64 period;
 };

+/*
+ * brute_stats_ptr_lock - Lock to protect the brute_stats structure point=
er.
+ */
+static DEFINE_RWLOCK(brute_stats_ptr_lock);
+
 /*
  * brute_blob_sizes - LSM blob sizes.
  *
@@ -74,7 +84,7 @@ static struct brute_stats *brute_new_stats(void)
 {
 	struct brute_stats *stats;

-	stats =3D kmalloc(sizeof(struct brute_stats), GFP_KERNEL);
+	stats =3D kmalloc(sizeof(struct brute_stats), GFP_ATOMIC);
 	if (!stats)
 		return NULL;

@@ -99,16 +109,17 @@ static struct brute_stats *brute_new_stats(void)
  * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
  * since the task_free hook can be called from an IRQ context during the
  * execution of the task_alloc hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
  */
 static void brute_share_stats(struct brute_stats *src,
 			      struct brute_stats **dst)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&src->lock, flags);
+	spin_lock(&src->lock);
 	refcount_inc(&src->refc);
 	*dst =3D src;
-	spin_unlock_irqrestore(&src->lock, flags);
+	spin_unlock(&src->lock);
 }

 /**
@@ -126,26 +137,36 @@ static void brute_share_stats(struct brute_stats *sr=
c,
  * this task and the new one being allocated. Otherwise, share the statis=
tics
  * that the current task already has.
  *
+ * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
+ * and brute_stats::lock since the task_free hook can be called from an I=
RQ
+ * context during the execution of the task_alloc hook.
+ *
  * Return: -ENOMEM if the allocation of the new statistics structure fail=
s. Zero
  *         otherwise.
  */
 static int brute_task_alloc(struct task_struct *task, unsigned long clone=
_flags)
 {
 	struct brute_stats **stats, **p_stats;
+	unsigned long flags;

 	stats =3D brute_stats_ptr(task);
 	p_stats =3D brute_stats_ptr(current);
+	write_lock_irqsave(&brute_stats_ptr_lock, flags);

 	if (likely(*p_stats)) {
 		brute_share_stats(*p_stats, stats);
+		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return 0;
 	}

 	*stats =3D brute_new_stats();
-	if (!*stats)
+	if (!*stats) {
+		write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return -ENOMEM;
+	}

 	brute_share_stats(*stats, p_stats);
+	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 	return 0;
 }

@@ -167,9 +188,9 @@ static int brute_task_alloc(struct task_struct *task, =
unsigned long clone_flags)
  * only one task (the task that calls the execve function) points to the =
data.
  * In this case, the previous allocation is used but the statistics are r=
eset.
  *
- * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
- * since the task_free hook can be called from an IRQ context during the
- * execution of the bprm_committing_creds hook.
+ * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
+ * and brute_stats::lock since the task_free hook can be called from an I=
RQ
+ * context during the execution of the bprm_committing_creds hook.
  */
 static void brute_task_execve(struct linux_binprm *bprm)
 {
@@ -177,24 +198,33 @@ static void brute_task_execve(struct linux_binprm *b=
prm)
 	unsigned long flags;

 	stats =3D brute_stats_ptr(current);
-	if (WARN(!*stats, "No statistical data\n"))
+	read_lock_irqsave(&brute_stats_ptr_lock, flags);
+
+	if (WARN(!*stats, "No statistical data\n")) {
+		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return;
+	}

-	spin_lock_irqsave(&(*stats)->lock, flags);
+	spin_lock(&(*stats)->lock);

 	if (!refcount_dec_not_one(&(*stats)->refc)) {
 		/* execve call after an execve call */
 		(*stats)->faults =3D 0;
 		(*stats)->jiffies =3D get_jiffies_64();
 		(*stats)->period =3D 0;
-		spin_unlock_irqrestore(&(*stats)->lock, flags);
+		spin_unlock(&(*stats)->lock);
+		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 		return;
 	}

 	/* execve call after a fork call */
-	spin_unlock_irqrestore(&(*stats)->lock, flags);
+	spin_unlock(&(*stats)->lock);
+	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
+
+	write_lock_irqsave(&brute_stats_ptr_lock, flags);
 	*stats =3D brute_new_stats();
 	WARN(!*stats, "Cannot allocate statistical data\n");
+	write_unlock_irqrestore(&brute_stats_ptr_lock, flags);
 }

 /**
@@ -210,17 +240,446 @@ static void brute_task_free(struct task_struct *tas=
k)
 	bool refc_is_zero;

 	stats =3D brute_stats_ptr(task);
-	if (WARN(!*stats, "No statistical data\n"))
+	read_lock(&brute_stats_ptr_lock);
+
+	if (WARN(!*stats, "No statistical data\n")) {
+		read_unlock(&brute_stats_ptr_lock);
 		return;
+	}

 	spin_lock(&(*stats)->lock);
 	refc_is_zero =3D refcount_dec_and_test(&(*stats)->refc);
 	spin_unlock(&(*stats)->lock);
+	read_unlock(&brute_stats_ptr_lock);

 	if (refc_is_zero) {
+		write_lock(&brute_stats_ptr_lock);
 		kfree(*stats);
 		*stats =3D NULL;
+		write_unlock(&brute_stats_ptr_lock);
+	}
+}
+
+/*
+ * BRUTE_EMA_WEIGHT_NUMERATOR - Weight's numerator of EMA.
+ */
+static const u64 BRUTE_EMA_WEIGHT_NUMERATOR =3D 7;
+
+/*
+ * BRUTE_EMA_WEIGHT_DENOMINATOR - Weight's denominator of EMA.
+ */
+static const u64 BRUTE_EMA_WEIGHT_DENOMINATOR =3D 10;
+
+/**
+ * brute_mul_by_ema_weight() - Multiply by EMA weight.
+ * @value: Value to multiply by EMA weight.
+ *
+ * Return: The result of the multiplication operation.
+ */
+static inline u64 brute_mul_by_ema_weight(u64 value)
+{
+	return mul_u64_u64_div_u64(value, BRUTE_EMA_WEIGHT_NUMERATOR,
+				   BRUTE_EMA_WEIGHT_DENOMINATOR);
+}
+
+/*
+ * BRUTE_MAX_FAULTS - Maximum number of faults.
+ *
+ * If a brute force attack is running slowly for a long time, the applica=
tion
+ * crash period's EMA is not suitable for the detection. This type of att=
ack
+ * must be detected using a maximum number of faults.
+ */
+static const unsigned char BRUTE_MAX_FAULTS =3D 200;
+
+/**
+ * brute_update_crash_period() - Update the application crash period.
+ * @stats: Statistics that hold the application crash period to update.
+ * @now: The current timestamp in jiffies.
+ *
+ * The application crash period must be a value that is not prone to chan=
ge due
+ * to spurious data and follows the real crash period. So, to compute it,=
 the
+ * exponential moving average (EMA) is used.
+ *
+ * This kind of average defines a weight (between 0 and 1) for the new va=
lue to
+ * add and applies the remainder of the weight to the current average val=
ue.
+ * This way, some spurious data will not excessively modify the average a=
nd only
+ * if the new values are persistent, the moving average will tend towards=
 them.
+ *
+ * Mathematically the application crash period's EMA can be expressed as
+ * follows:
+ *
+ * period_ema =3D period * weight + period_ema * (1 - weight)
+ *
+ * If the operations are applied:
+ *
+ * period_ema =3D period * weight + period_ema - period_ema * weight
+ *
+ * If the operands are ordered:
+ *
+ * period_ema =3D period_ema - period_ema * weight + period * weight
+ *
+ * Finally, this formula can be written as follows:
+ *
+ * period_ema -=3D period_ema * weight;
+ * period_ema +=3D period * weight;
+ *
+ * The statistics that hold the application crash period to update cannot=
 be
+ * NULL.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
+ * Return: The last crash timestamp before updating it.
+ */
+static u64 brute_update_crash_period(struct brute_stats *stats, u64 now)
+{
+	u64 current_period;
+	u64 last_crash_timestamp;
+
+	spin_lock(&stats->lock);
+	current_period =3D now - stats->jiffies;
+	last_crash_timestamp =3D stats->jiffies;
+	stats->jiffies =3D now;
+
+	stats->period -=3D brute_mul_by_ema_weight(stats->period);
+	stats->period +=3D brute_mul_by_ema_weight(current_period);
+
+	if (stats->faults < BRUTE_MAX_FAULTS)
+		stats->faults +=3D 1;
+
+	spin_unlock(&stats->lock);
+	return last_crash_timestamp;
+}
+
+/*
+ * BRUTE_MIN_FAULTS - Minimum number of faults.
+ *
+ * The application crash period's EMA cannot be used until a minimum numb=
er of
+ * data has been applied to it. This constraint allows getting a trend wh=
en this
+ * moving average is used. Moreover, it avoids the scenario where an appl=
ication
+ * fails quickly from execve system call due to reasons unrelated to a re=
al
+ * attack.
+ */
+static const unsigned char BRUTE_MIN_FAULTS =3D 5;
+
+/*
+ * BRUTE_CRASH_PERIOD_THRESHOLD - Application crash period threshold.
+ *
+ * The units are expressed in milliseconds.
+ *
+ * A fast brute force attack is detected when the application crash perio=
d falls
+ * below this threshold.
+ */
+static const u64 BRUTE_CRASH_PERIOD_THRESHOLD =3D 30000;
+
+/**
+ * brute_attack_running() - Test if a brute force attack is happening.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * The decision if a brute force attack is running is based on the statis=
tical
+ * data shared by all the fork hierarchy processes. This statistics canno=
t be
+ * NULL.
+ *
+ * There are two types of brute force attacks that can be detected using =
the
+ * statistical data. The first one is a slow brute force attack that is d=
etected
+ * if the maximum number of faults per fork hierarchy is reached. The sec=
ond
+ * type is a fast brute force attack that is detected if the application =
crash
+ * period falls below a certain threshold.
+ *
+ * Moreover, it is important to note that no attacks will be detected unt=
il a
+ * minimum number of faults have occurred. This allows to have a trend in=
 the
+ * crash period when the EMA is used and also avoids the scenario where a=
n
+ * application fails quickly from execve system call due to reasons unrel=
ated to
+ * a real attack.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
+ * Return: True if a brute force attack is happening. False otherwise.
+ */
+static bool brute_attack_running(struct brute_stats *stats)
+{
+	u64 crash_period;
+
+	spin_lock(&stats->lock);
+	if (stats->faults < BRUTE_MIN_FAULTS) {
+		spin_unlock(&stats->lock);
+		return false;
+	}
+
+	if (stats->faults >=3D BRUTE_MAX_FAULTS) {
+		spin_unlock(&stats->lock);
+		return true;
+	}
+
+	crash_period =3D jiffies64_to_msecs(stats->period);
+	spin_unlock(&stats->lock);
+
+	return crash_period < BRUTE_CRASH_PERIOD_THRESHOLD;
+}
+
+/**
+ * print_fork_attack_running() - Warn about a fork brute force attack.
+ */
+static inline void print_fork_attack_running(void)
+{
+	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
+}
+
+/**
+ * brute_manage_fork_attack() - Manage a fork brute force attack.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ * @now: The current timestamp in jiffies.
+ *
+ * For a correct management of a fork brute force attack it is only neces=
sary to
+ * update the statistics and test if an attack is happening based on thes=
e data.
+ *
+ * The statistical data shared by all the fork hierarchy processes cannot=
 be
+ * NULL.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
+ * Return: The last crash timestamp before updating it.
+ */
+static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
+{
+	u64 last_fork_crash;
+
+	last_fork_crash =3D brute_update_crash_period(stats, now);
+	if (brute_attack_running(stats))
+		print_fork_attack_running();
+
+	return last_fork_crash;
+}
+
+/**
+ * brute_get_exec_stats() - Get the exec statistics.
+ * @stats: When this function is called, this parameter must point to the
+ *         current process' statistical data. When this function returns,=
 this
+ *         parameter points to the parent process' statistics of the fork
+ *         hierarchy that hold the current process' statistics.
+ *
+ * To manage a brute force attack that happens through the execve system =
call it
+ * is not possible to use the statistical data hold by this process due t=
o these
+ * statistics disappear when this task is finished. In this scenario this=
 data
+ * should be tracked by the statistics of a higher fork hierarchy (the hi=
erarchy
+ * that contains the process that forks before the execve system call).
+ *
+ * To find these statistics the current fork hierarchy must be traversed =
up
+ * until new statistics are found.
+ *
+ * Context: Must be called with tasklist_lock and brute_stats_ptr_lock he=
ld.
+ */
+static void brute_get_exec_stats(struct brute_stats **stats)
+{
+	const struct task_struct *task =3D current;
+	struct brute_stats **p_stats;
+
+	do {
+		if (!task->real_parent) {
+			*stats =3D NULL;
+			return;
+		}
+
+		p_stats =3D brute_stats_ptr(task->real_parent);
+		task =3D task->real_parent;
+	} while (*stats =3D=3D *p_stats);
+
+	*stats =3D *p_stats;
+}
+
+/**
+ * brute_update_exec_crash_period() - Update the exec crash period.
+ * @stats: When this function is called, this parameter must point to the
+ *         current process' statistical data. When this function returns,=
 this
+ *         parameter points to the updated statistics (statistics that tr=
ack the
+ *         info to manage a brute force attack that happens through the e=
xecve
+ *         system call).
+ * @now: The current timestamp in jiffies.
+ * @last_fork_crash: The last fork crash timestamp before updating it.
+ *
+ * If this is the first update of the statistics used to manage a brute f=
orce
+ * attack that happens through the execve system call, its last crash tim=
estamp
+ * (the timestamp that shows when the execve was called) cannot be used t=
o
+ * compute the crash period's EMA. Instead, the last fork crash timestamp=
 should
+ * be used (the last crash timestamp of the child fork hierarchy before u=
pdating
+ * the crash period). This allows that in a brute force attack that happe=
ns
+ * through the fork system call, the exec and fork statistics are the sam=
e. In
+ * this situation, the mitigation method will act only in the processes t=
hat are
+ * sharing the fork statistics. This way, the process that forked before =
the
+ * execve system call will not be involved in the mitigation method. In t=
his
+ * scenario, the parent is not responsible of the child's behaviour.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and tasklist_lock and
+ *          brute_stats_ptr_lock held.
+ * Return: -EFAULT if there are no exec statistics. Zero otherwise.
+ */
+static int brute_update_exec_crash_period(struct brute_stats **stats,
+					  u64 now, u64 last_fork_crash)
+{
+	brute_get_exec_stats(stats);
+	if (!*stats)
+		return -EFAULT;
+
+	spin_lock(&(*stats)->lock);
+	if (!(*stats)->faults)
+		(*stats)->jiffies =3D last_fork_crash;
+	spin_unlock(&(*stats)->lock);
+
+	brute_update_crash_period(*stats, now);
+	return 0;
+}
+
+/**
+ * brute_get_crash_period() - Get the application crash period.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * The statistical data shared by all the fork hierarchy processes cannot=
 be
+ * NULL.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          held.
+ * Return: The application crash period.
+ */
+static u64 brute_get_crash_period(struct brute_stats *stats)
+{
+	u64 crash_period;
+
+	spin_lock(&stats->lock);
+	crash_period =3D stats->period;
+	spin_unlock(&stats->lock);
+
+	return crash_period;
+}
+
+/**
+ * print_exec_attack_running() - Warn about an exec brute force attack.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * The statistical data shared by all the fork hierarchy processes cannot=
 be
+ * NULL.
+ *
+ * Before showing the process name it is mandatory to find a process that=
 holds
+ * a pointer to the exec statistics.
+ *
+ * Context: Must be called with tasklist_lock and brute_stats_ptr_lock he=
ld.
+ */
+static void print_exec_attack_running(const struct brute_stats *stats)
+{
+	struct task_struct *p;
+	struct brute_stats **p_stats;
+	bool found =3D false;
+
+	for_each_process(p) {
+		p_stats =3D brute_stats_ptr(p);
+		if (*p_stats =3D=3D stats) {
+			found =3D true;
+			break;
+		}
 	}
+
+	if (WARN(!found, "No exec process\n"))
+		return;
+
+	pr_warn("Exec brute force attack detected [%s]\n", p->comm);
+}
+
+/**
+ * brute_manage_exec_attack() - Manage an exec brute force attack.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ * @now: The current timestamp in jiffies.
+ * @last_fork_crash: The last fork crash timestamp before updating it.
+ *
+ * For a correct management of an exec brute force attack it is only nece=
ssary
+ * to update the exec statistics and test if an attack is happening based=
 on
+ * these data.
+ *
+ * It is important to note that if the fork and exec crash periods are th=
e same,
+ * the attack test is avoided. This allows that in a brute force attack t=
hat
+ * happens through the fork system call, the mitigation method does not a=
ct on
+ * the parent process of the fork hierarchy.
+ *
+ * The statistical data shared by all the fork hierarchy processes cannot=
 be
+ * NULL.
+ *
+ * It's mandatory to disable interrupts before acquiring the brute_stats:=
:lock
+ * since the task_free hook can be called from an IRQ context during the
+ * execution of the task_fatal_signal hook.
+ *
+ * Context: Must be called with interrupts disabled and tasklist_lock and
+ *          brute_stats_ptr_lock held.
+ */
+static void brute_manage_exec_attack(struct brute_stats *stats, u64 now,
+				     u64 last_fork_crash)
+{
+	int ret;
+	struct brute_stats *exec_stats =3D stats;
+	u64 fork_period;
+	u64 exec_period;
+
+	ret =3D brute_update_exec_crash_period(&exec_stats, now, last_fork_crash=
);
+	if (WARN(ret, "No exec statistical data\n"))
+		return;
+
+	fork_period =3D brute_get_crash_period(stats);
+	exec_period =3D brute_get_crash_period(exec_stats);
+	if (fork_period =3D=3D exec_period)
+		return;
+
+	if (brute_attack_running(exec_stats))
+		print_exec_attack_running(exec_stats);
+}
+
+/**
+ * brute_task_fatal_signal() - Target for the task_fatal_signal hook.
+ * @siginfo: Contains the signal information.
+ *
+ * To detect a brute force attack is necessary to update the fork and exe=
c
+ * statistics in every fatal crash and act based on these data.
+ *
+ * It's mandatory to disable interrupts before acquiring brute_stats_ptr_=
lock
+ * and brute_stats::lock since the task_free hook can be called from an I=
RQ
+ * context during the execution of the task_fatal_signal hook.
+ */
+static void brute_task_fatal_signal(const kernel_siginfo_t *siginfo)
+{
+	struct brute_stats **stats;
+	unsigned long flags;
+	u64 last_fork_crash;
+	u64 now =3D get_jiffies_64();
+
+	stats =3D brute_stats_ptr(current);
+	read_lock(&tasklist_lock);
+	read_lock_irqsave(&brute_stats_ptr_lock, flags);
+
+	if (WARN(!*stats, "No statistical data\n")) {
+		read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
+		read_unlock(&tasklist_lock);
+		return;
+	}
+
+	last_fork_crash =3D brute_manage_fork_attack(*stats, now);
+	brute_manage_exec_attack(*stats, now, last_fork_crash);
+	read_unlock_irqrestore(&brute_stats_ptr_lock, flags);
+	read_unlock(&tasklist_lock);
 }

 /*
@@ -230,6 +689,7 @@ static struct security_hook_list brute_hooks[] __lsm_r=
o_after_init =3D {
 	LSM_HOOK_INIT(task_alloc, brute_task_alloc),
 	LSM_HOOK_INIT(bprm_committing_creds, brute_task_execve),
 	LSM_HOOK_INIT(task_free, brute_task_free),
+	LSM_HOOK_INIT(task_fatal_signal, brute_task_fatal_signal),
 };

 /**
=2D-
2.25.1

