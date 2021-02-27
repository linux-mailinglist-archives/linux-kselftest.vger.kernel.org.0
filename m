Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2A5326E64
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Feb 2021 18:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhB0RYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Feb 2021 12:24:35 -0500
Received: from mout.gmx.net ([212.227.17.20]:38983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230223AbhB0RWn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Feb 2021 12:22:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614446351;
        bh=f9979xLEL4tmv6pKlArL8pZAWWrdLIZBJP+PfwGW+EA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=T3kumE5gYLo5QzBPFZQcwh7tzNIsDWpTas1Qg1qFxEPS9RQc2BC9KsO2WOD4pP5Ju
         ob7lYgT8hsIkERwxAFrpSFyDjoWJC8iZ+QVGqa4M8TYrgOPqE2qGsAo0SBQfPBVkQr
         /HuPIdPM/nNbfb6Z5sS3AxuDx2aD0fQdQiiF3mWg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.229.153]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MY6Cb-1lJUaB3DxN-00YTBq; Sat, 27 Feb 2021 18:19:10 +0100
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
Subject: [PATCH v5 5/8] security/brute: Mitigate a brute force attack
Date:   Sat, 27 Feb 2021 16:30:10 +0100
Message-Id: <20210227153013.6747-6-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227153013.6747-1-john.wood@gmx.com>
References: <20210227153013.6747-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:N9BKOY8hiGdBPHnQMaciOAbJcMHRrfanbEh/6b//IXbA/ZK30Qt
 GWzzwDIpksnfdMGLROP0Qf+owHixm9rLyGW74QMTaex4gWWyZjhWKmwR4tu9Flz8A7R6iZA
 zzyRVmqA5xFj6Wy4pIEYA4iNGQF5Wg1U6IDEm9x4hxidxG/nGRHMauakmZWTaOlgCY0KyC0
 0j9kLkRX8qItyZF2WBicQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kSdF3TXhtH8=:9SQpwjKK38trO/Q6Wq4i0P
 1RYb5ygdlQo/huv4F5I2cWU1m7kdTD3s04IEf62MeM9Nh4dy/FC7yYw3/N92PCyUnoEMWF6Ln
 AWmmVjhXtSCjxZ0ZAqGtAjgvaGke203UeLnCLANXPRX3Fv9X/qfU/SXMA7HTbksKyn9VaKYp5
 r9iORiEnE9FxjYnEXj6zwwSJTnTayLUTNn7fgqSV9qwVb+4mtt8dOD/iTqk7G7k/dLbFOSDST
 BU3+AFoeUilaOCIetT64xoeIynNEWNcqSqn2QQ/kEkF9kRYpKkj7bzjHbSkO0Plmq2cTEZ3pB
 6Wgj6v5m+PdtBCSA+LWmdQlY/c/oG0YrHLn2VqcWHodxWl89WLe03/AoKEtO7QMoS3VvOOSqA
 DrL15NWaGtfyYqxp6+YC6jLih+hdaqe6rARcuDdAqXTGmL3yKN5yxiwG9F7zxXQsQEyTxm63Q
 lWZSlYWvRoV8U8z1l+O5B244cHuyN1TKOag2sUuOsaA4iG4KoXU8diPEtDW9HmotTRrzHD+Pk
 Di6lYLpyW/urOlXZmEhwqX9i3XfWTkhrxhrZowglIQi2vqXxbg6/RLYJvuJW+QPf7twapHVJ1
 EsTHP4Ke3+7HYV/0CPUdUOcLLkFX4xqx5Y7YgkV/5N3moFEbriJnFn63cvUcV2caBzXU3fMhb
 8zNp/Bpqj14Wa3PCNBh3hpQXVFkee3B7jfzuTLsv1d1UNWxTbkmIMv/H5QUCJ55Af4bhOtdFW
 kBcn4nw0BwVt/hm/rcM4nLGUgiqfZ8cuVNEcFSZYO1sIsjS8A95U2XTkbfYgkuulOaEsiNYbX
 nIp2TP3PpI4CUV4aPnRSs5//obp57eJzjnbJna4zaDJNSnidtwmsuMd2jnWTQJ0oooYRfhxSk
 Bg0+iS09JAaEkCm3Cd5w==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to mitigate a brute force attack all the offending tasks involved
in the attack must be killed. In other words, it is necessary to kill all
the tasks that share the fork and/or exec statistical data related to the
attack. Moreover, if the attack happens through the fork system call, the
processes that have the same group_leader that the current task (the task
that has crashed) must be avoided since they are in the path to be killed.

When the SIGKILL signal is sent to the offending tasks, the function
"brute_kill_offending_tasks" will be called in a recursive way from the
task_fatal_signal LSM hook due to a small crash period. So, to avoid kill
again the same tasks due to a recursive call of this function, it is
necessary to disable the attack detection for the involved hierarchies.

To disable the attack detection, set to zero the last crash timestamp and
avoid to compute the application crash period in this case.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 141 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 132 insertions(+), 9 deletions(-)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index 0a99cd4c3303..48b07d923ec7 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -22,6 +22,7 @@
 #include <linux/math64.h>
 #include <linux/netdevice.h>
 #include <linux/path.h>
+#include <linux/pid.h>
 #include <linux/printk.h>
 #include <linux/refcount.h>
 #include <linux/rwlock.h>
@@ -64,7 +65,7 @@ struct brute_cred {
  * @lock: Lock to protect the brute_stats structure.
  * @refc: Reference counter.
  * @faults: Number of crashes.
- * @jiffies: Last crash timestamp.
+ * @jiffies: Last crash timestamp. If zero, the attack detection is disab=
led.
  * @period: Crash period's moving average.
  * @saved_cred: Saved credentials.
  * @network: Network activity flag.
@@ -566,6 +567,125 @@ static inline void print_fork_attack_running(void)
 	pr_warn("Fork brute force attack detected [%s]\n", current->comm);
 }

+/**
+ * brute_disabled() - Test if the brute force attack detection is disable=
d.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * The brute force attack detection enabling/disabling is based on the la=
st
+ * crash timestamp. A zero timestamp indicates that this feature is disab=
led. A
+ * timestamp greater than zero indicates that the attack detection is ena=
bled.
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
+ * Return: True if the brute force attack detection is disabled. False
+ *         otherwise.
+ */
+static bool brute_disabled(struct brute_stats *stats)
+{
+	bool disabled;
+
+	spin_lock(&stats->lock);
+	disabled =3D !stats->jiffies;
+	spin_unlock(&stats->lock);
+
+	return disabled;
+}
+
+/**
+ * brute_disable() - Disable the brute force attack detection.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * To disable the brute force attack detection it is only necessary to se=
t the
+ * last crash timestamp to zero. A zero timestamp indicates that this fea=
ture is
+ * disabled. A timestamp greater than zero indicates that the attack dete=
ction
+ * is enabled.
+ *
+ * The statistical data shared by all the fork hierarchy processes cannot=
 be
+ * NULL.
+ *
+ * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
+ *          and brute_stats::lock held.
+ */
+static inline void brute_disable(struct brute_stats *stats)
+{
+	stats->jiffies =3D 0;
+}
+
+/**
+ * enum brute_attack_type - Brute force attack type.
+ * @BRUTE_ATTACK_TYPE_FORK: Attack that happens through the fork system c=
all.
+ * @BRUTE_ATTACK_TYPE_EXEC: Attack that happens through the execve system=
 call.
+ */
+enum brute_attack_type {
+	BRUTE_ATTACK_TYPE_FORK,
+	BRUTE_ATTACK_TYPE_EXEC,
+};
+
+/**
+ * brute_kill_offending_tasks() - Kill the offending tasks.
+ * @attack_type: Brute force attack type.
+ * @stats: Statistical data shared by all the fork hierarchy processes.
+ *
+ * When a brute force attack is detected all the offending tasks involved=
 in the
+ * attack must be killed. In other words, it is necessary to kill all the=
 tasks
+ * that share the same statistical data. Moreover, if the attack happens =
through
+ * the fork system call, the processes that have the same group_leader th=
at the
+ * current task must be avoided since they are in the path to be killed.
+ *
+ * When the SIGKILL signal is sent to the offending tasks, this function =
will be
+ * called again from the task_fatal_signal hook due to a small crash peri=
od. So,
+ * to avoid kill again the same tasks due to a recursive call of this fun=
ction,
+ * it is necessary to disable the attack detection for this fork hierarch=
y.
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
+static void brute_kill_offending_tasks(enum brute_attack_type attack_type=
,
+				       struct brute_stats *stats)
+{
+	struct task_struct *p;
+	struct brute_stats **p_stats;
+
+	spin_lock(&stats->lock);
+
+	if (attack_type =3D=3D BRUTE_ATTACK_TYPE_FORK &&
+	    refcount_read(&stats->refc) =3D=3D 1) {
+		spin_unlock(&stats->lock);
+		return;
+	}
+
+	brute_disable(stats);
+	spin_unlock(&stats->lock);
+
+	for_each_process(p) {
+		if (attack_type =3D=3D BRUTE_ATTACK_TYPE_FORK &&
+		    p->group_leader =3D=3D current->group_leader)
+			continue;
+
+		p_stats =3D brute_stats_ptr(p);
+		if (*p_stats !=3D stats)
+			continue;
+
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_PID);
+		pr_warn_ratelimited("Offending process %d [%s] killed\n",
+				    p->pid, p->comm);
+	}
+}
+
 /**
  * brute_manage_fork_attack() - Manage a fork brute force attack.
  * @stats: Statistical data shared by all the fork hierarchy processes.
@@ -581,8 +701,8 @@ static inline void print_fork_attack_running(void)
  * since the task_free hook can be called from an IRQ context during the
  * execution of the task_fatal_signal hook.
  *
- * Context: Must be called with interrupts disabled and brute_stats_ptr_l=
ock
- *          held.
+ * Context: Must be called with interrupts disabled and tasklist_lock and
+ *          brute_stats_ptr_lock held.
  * Return: The last crash timestamp before updating it.
  */
 static u64 brute_manage_fork_attack(struct brute_stats *stats, u64 now)
@@ -590,8 +710,10 @@ static u64 brute_manage_fork_attack(struct brute_stat=
s *stats, u64 now)
 	u64 last_fork_crash;

 	last_fork_crash =3D brute_update_crash_period(stats, now);
-	if (brute_attack_running(stats))
+	if (brute_attack_running(stats)) {
 		print_fork_attack_running();
+		brute_kill_offending_tasks(BRUTE_ATTACK_TYPE_FORK, stats);
+	}

 	return last_fork_crash;
 }
@@ -778,8 +900,10 @@ static void brute_manage_exec_attack(struct brute_sta=
ts *stats, u64 now,
 	if (fork_period =3D=3D exec_period)
 		return;

-	if (brute_attack_running(exec_stats))
+	if (brute_attack_running(exec_stats)) {
 		print_exec_attack_running(exec_stats);
+		brute_kill_offending_tasks(BRUTE_ATTACK_TYPE_EXEC, exec_stats);
+	}
 }

 /**
@@ -895,10 +1019,9 @@ static void brute_task_fatal_signal(const kernel_sig=
info_t *siginfo)
 	read_lock(&tasklist_lock);
 	read_lock_irqsave(&brute_stats_ptr_lock, flags);

-	if (WARN(!*stats, "No statistical data\n"))
-		goto unlock;
-
-	if (!brute_threat_model_supported(siginfo, *stats))
+	if (WARN(!*stats, "No statistical data\n") ||
+	    brute_disabled(*stats) ||
+	    !brute_threat_model_supported(siginfo, *stats))
 		goto unlock;

 	last_fork_crash =3D brute_manage_fork_attack(*stats, now);
=2D-
2.25.1

