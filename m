Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E138CCC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 19:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234848AbhEUR4j (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 13:56:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:58273 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232832AbhEUR4i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 13:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621619684;
        bh=+R5t0/zrJeQqbmiLiGPXh/L2XjmF15vBCZmCmoedNdQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=dZOuXAg6ArC9bUlxALvCZLgYilxkXAkiedJTBTwCK9QOXFL1n4i3nk3L+9btEX0vV
         3l1hQ+AmJeEp97abthTQb1e5TcJkgnZ6JKGiUvSz+TvEP4zvGeDTHdo7KMDz3IS5eP
         C5fw8ydgZyRDv3cgmryfZru1OKM8vVMf5HQgLoD4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MAfYw-1ldWZw1CGW-00B0lt; Fri, 21 May 2021 19:54:44 +0200
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
Subject: [PATCH v7 3/7] security/brute: Detect a brute force attack
Date:   Fri, 21 May 2021 19:24:10 +0200
Message-Id: <20210521172414.69456-4-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521172414.69456-1-john.wood@gmx.com>
References: <20210521172414.69456-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Trlmb+U40dzl+1U481ccJxduXI0CahO7IvEpRF8zPQEbf00rMl+
 OSL59QXFur0Jdt8ylx7H4CUnqVdiBRCFS84xLlMi8hPpCNC+DXhtH0ZplN1ia6PpWMb7Mir
 FgxcNsyvbR7xmxw5p36XODq+QrWMp+6NgVxtdvJeYovkouRKUeh+R3tw1pejO0Ot3Nvo4KA
 TWMX5gG2sP5dA/KvdakTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+J5qzQKHjlM=:br0PCK+eIRIUvKqfjkCyQV
 yJlKB+H+/603ERROUYPYsVhapHnqXJKisD8tK8GHNhAtS8/rO5/aXnk6uWSrFPCtkzT3JBgVo
 1a1GSBjGOeiHK521UyFHXkvEee8ulL46YBOdE0vLFEcq1VJRN0+jX5o8/e/j7YcMdnSOxk+me
 0C9W8BN0QS1nJ70Tl8H/hrLflWVq7A8qYmlzxas8dqN/kd31T4VIZ9ma5MIWPVF4DUrrgM3/m
 delGTS56jcQL8JBbC9tyDpe6So/6m/r+ZV+xQRWBlddAvSv5ubQR4OrE4b7A0fDyQPEYHgILh
 ump8tuQafLfkbiypc8V4TPrYGf+Oln8rdlV5mOW/9QUlBvnTUWWTm5J2IxkTQZoQiHm/lNLCL
 qyt5neMlP4M2ItjToOoTIhSRn8qTt7rPR/XqmmGkDp+dPqjTJ6X7dEnfNdgrHyNIM4MQaxuJk
 mqC+YMmcO/mKVATalafqPinJLIv+UAsDsRlTkWjiNUd1yds9JLSTICpv9ApbnlAl+f5UdCxbX
 +xJ0Yi0N8pfqlj9SyqaflRQaEwirDyIjrUfNkAckBbeCifvy/w1m319WHMozjK2uugPp1Wy1x
 6I/R5YkQrT6fcjhW+VucPOYzXFumNSycdd721VenlPlrPLX+WYMqQ6WgAUeCc+2GoSyKxY0qr
 fj6VdsHtWlJN/MLCIC6hP0qwlCAflgW5fGMYDBkJMt1eIlP5ZcRahCig8B1scDII3JiiPifBv
 Vp6pwELCbUSJ9bpRHVcslzR6PIEcoDN3Zy06NQGo9XGrUPw/5Y7RvLY6J/eXuYrpzd7j6EdBE
 acyVFhTmlg6eeZ3nsxSRQYb1sQEmWa0nBbSg8I9cU7qV2sXb7J3JIuLg+SJICv41NIC6rsM7R
 45BFw1DsbTsaC1crFNoJyRxwrq8UDDkFo11Z5gqNuF2cGfkjdEPnXIOZNp3mlPd0m8sdW0W2L
 UCVpZ8jHWLS4ZofroYqx6S3isMQdf+F29cVaSRoaCY0YNZVFcVixdrv5xFksac58IrPY1q3ED
 6iGNvls7TeDDMPpK6Vy3WehJb68bM6IEenGV9MGRCAXXNXf1IwV8qx2rXXDZTp7TU2UlGtwhs
 Wz+9lkqFvM5XPzvXbxOHDhuSgDroqRqtfCAXwNN25dSRaigLbCzJa/wcZsYzzOTlXgRUNcwH8
 SmFYoaivoMYwcgKrgv9gL7ZaLjQYt/vSRZEEas4ii/ZGR4EHJDMryDIFGg728v7+W1POQ=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For a correct management of a fork brute force attack it is necessary to
track all the information related to the application crashes. To do so,
use the extended attributes (xattr) of the executable files and define a
statistical data structure to hold all the necessary information shared
by all the fork hierarchy processes. This info is the number of crashes,
the last crash timestamp and the crash period's moving average.

The same can be achieved using a pointer to the fork hierarchy
statistical data held by the task_struct structure. But this has an
important drawback: a brute force attack that happens through the execve
system call losts the faults info since these statistics are freed when
the fork hierarchy disappears. Using this method makes not possible to
manage this attack type that can be successfully treated using extended
attributes.

Also, to avoid false positives during the attack detection it is
necessary to narrow the possible cases. So, only the following scenarios
are taken into account:

1.- Launching (fork()/exec()) a setuid/setgid process repeatedly until a
    desirable memory layout is got (e.g. Stack Clash).
2.- Connecting to an exec()ing network daemon (e.g. xinetd) repeatedly
    until a desirable memory layout is got (e.g. what CTFs do for simple
    network service).
3.- Launching processes without exec() (e.g. Android Zygote) and
    exposing state to attack a sibling.
4.- Connecting to a fork()ing network daemon (e.g. apache) repeatedly
    until the previously shared memory layout of all the other children
    is exposed (e.g. kind of related to HeartBleed).

In each case, a privilege boundary has been crossed:

Case 1: setuid/setgid process
Case 2: network to local
Case 3: privilege changes
Case 4: network to local

To mark that a privilege boundary has been crossed it is only necessary
to create a new stats for the executable file via the extended attribute
and only if it has no previous statistical data. This is done using four
different LSM hooks, one per privilege boundary:

setuid/setgid process --> bprm_creds_from_file hook (based on secureexec
                          flag).
network to local -------> socket_accept hook (taking into account only
                          external connections).
privilege changes ------> task_fix_setuid and task_fix_setgid hooks.

To detect a brute force attack it is necessary that the executable file
statistics be updated in every fatal crash and the most important data
to update is the application crash period. To do so, use the new
"task_fatal_signal" LSM hook added in a previous step.

The application crash period must be a value that is not prone to change
due to spurious data and follows the real crash period. So, to compute
it, the exponential moving average (EMA) is used.

Based on the updated statistics two different attacks can be handled. A
slow brute force attack that is detected if the maximum number of faults
per fork hierarchy is reached and a fast brute force attack that is
detected if the application crash period falls below a certain
threshold.

Moreover, only the signals delivered by the kernel are taken into
account with the exception of the SIGABRT signal since the latter is
used by glibc for stack canary, malloc, etc failures, which may indicate
that a mitigation has been triggered.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 include/uapi/linux/xattr.h |   3 +
 security/brute/brute.c     | 478 +++++++++++++++++++++++++++++++++++++
 2 files changed, 481 insertions(+)

diff --git a/include/uapi/linux/xattr.h b/include/uapi/linux/xattr.h
index 9463db2dfa9d..ce1c8497dceb 100644
=2D-- a/include/uapi/linux/xattr.h
+++ b/include/uapi/linux/xattr.h
@@ -76,6 +76,9 @@
 #define XATTR_CAPS_SUFFIX "capability"
 #define XATTR_NAME_CAPS XATTR_SECURITY_PREFIX XATTR_CAPS_SUFFIX

+#define XATTR_BRUTE_SUFFIX "brute"
+#define XATTR_NAME_BRUTE XATTR_SECURITY_PREFIX XATTR_BRUTE_SUFFIX
+
 #define XATTR_POSIX_ACL_ACCESS  "posix_acl_access"
 #define XATTR_NAME_POSIX_ACL_ACCESS XATTR_SYSTEM_PREFIX XATTR_POSIX_ACL_A=
CCESS
 #define XATTR_POSIX_ACL_DEFAULT  "posix_acl_default"
diff --git a/security/brute/brute.c b/security/brute/brute.c
index 0edb89a58ab0..66db0dd0664d 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -2,8 +2,85 @@

 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

+#include <linux/binfmts.h>
 #include <linux/lsm_hooks.h>
 #include <linux/sysctl.h>
+#include <linux/xattr.h>
+#include <net/ipv6.h>
+#include <net/sock.h>
+
+/**
+ * struct brute_stats - Fork brute force attack statistics.
+ * @faults: Number of crashes.
+ * @nsecs: Last crash timestamp as the number of nanoseconds in the
+ *         International Atomic Time (TAI) reference.
+ * @period: Crash period's moving average.
+ * @flags: Statistics flags as a whole.
+ * @not_allowed: Not allowed executable file flag.
+ * @unused: Remaining unused flags.
+ *
+ * This structure holds the statistical data shared by all the fork hiera=
rchy
+ * processes.
+ */
+struct brute_stats {
+	u32 faults;
+	u64 nsecs;
+	u64 period;
+	union {
+		u8 flags;
+		struct {
+			u8 not_allowed : 1;
+			u8 unused : 7;
+		};
+	};
+};
+
+/**
+ * struct brute_raw_stats - Raw fork brute force attack statistics.
+ * @faults: Number of crashes.
+ * @nsecs: Last crash timestamp as the number of nanoseconds in the
+ *         International Atomic Time (TAI) reference.
+ * @period: Crash period's moving average.
+ * @flags: Statistics flags.
+ *
+ * This structure holds the statistical data on disk as an extended attri=
bute.
+ * Since the filesystems on which extended attributes are stored might al=
so be
+ * used on architectures with a different byte order and machine word siz=
e, care
+ * should be taken to store attribute values in an architecture-independe=
nt
+ * format.
+ */
+struct brute_raw_stats {
+	__le32 faults;
+	__le64 nsecs;
+	__le64 period;
+	u8 flags;
+} __packed;
+
+/**
+ * brute_get_current_exe_file() - Get the current task's executable file.
+ *
+ * Since all the kernel threads associated with a task share the same exe=
cutable
+ * file, get the thread group leader's executable file.
+ *
+ * Context: The file must be released via fput().
+ * Return: NULL if the current task has no associated executable file. A =
pointer
+ *         to the executable file otherwise.
+ */
+static struct file *brute_get_current_exe_file(void)
+{
+	struct task_struct *task =3D current;
+	struct file *exe_file;
+
+	rcu_read_lock();
+	if (!thread_group_leader(task))
+		task =3D rcu_dereference(task->group_leader);
+	get_task_struct(task);
+	rcu_read_unlock();
+
+	exe_file =3D get_task_exe_file(task);
+	put_task_struct(task);
+	return exe_file;
+}

 /**
  * DOC: brute_ema_weight_numerator
@@ -19,6 +96,18 @@ static unsigned int brute_ema_weight_numerator __read_m=
ostly =3D 7;
  */
 static unsigned int brute_ema_weight_denominator __read_mostly =3D 10;

+/**
+ * brute_mul_by_ema_weight() - Multiply by EMA weight.
+ * @value: Value to multiply by EMA weight.
+ *
+ * Return: The result of the multiplication operation.
+ */
+static inline u64 brute_mul_by_ema_weight(u64 value)
+{
+	return mul_u64_u32_div(value, brute_ema_weight_numerator,
+			       brute_ema_weight_denominator);
+}
+
 /**
  * DOC: brute_max_faults
  *
@@ -30,6 +119,56 @@ static unsigned int brute_ema_weight_denominator __rea=
d_mostly =3D 10;
  */
 static unsigned int brute_max_faults __read_mostly =3D 200;

+/**
+ * brute_update_crash_period() - Update the application crash period.
+ * @stats: Statistics that hold the application crash period to update. C=
annot
+ *         be NULL.
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
+ */
+static void brute_update_crash_period(struct brute_stats *stats)
+{
+	u64 current_period;
+	u64 now =3D ktime_get_clocktai_ns();
+
+	if (stats->faults >=3D (u32)brute_max_faults)
+		return;
+
+	if (stats->nsecs) {
+		current_period =3D now > stats->nsecs ? now - stats->nsecs : 0;
+		stats->period -=3D brute_mul_by_ema_weight(stats->period);
+		stats->period +=3D brute_mul_by_ema_weight(current_period);
+	}
+
+	stats->nsecs =3D now;
+	stats->faults +=3D 1;
+}
+
 /**
  * DOC: brute_min_faults
  *
@@ -51,6 +190,343 @@ static unsigned int brute_min_faults __read_mostly =
=3D 5;
  */
 static unsigned int brute_crash_period_threshold __read_mostly =3D 30;

+/**
+ * brute_attack_running() - Test if a brute force attack is happening.
+ * @stats: Statistical data shared by all the fork hierarchy processes. C=
annot
+ *         be NULL.
+ *
+ * The decision if a brute force attack is running is based on the statis=
tical
+ * data shared by all the fork hierarchy processes.
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
+ * crash period when the EMA is used.
+ *
+ * Return: True if a brute force attack is happening. False otherwise.
+ */
+static bool brute_attack_running(const struct brute_stats *stats)
+{
+	u64 threshold;
+
+	if (stats->faults < (u32)brute_min_faults)
+		return false;
+
+	if (stats->faults >=3D (u32)brute_max_faults)
+		return true;
+
+	threshold =3D (u64)brute_crash_period_threshold * (u64)NSEC_PER_SEC;
+	return stats->period < threshold;
+}
+
+/**
+ * brute_print_attack_running() - Warn about a fork brute force attack.
+ */
+static inline void brute_print_attack_running(void)
+{
+	pr_warn("fork brute force attack detected [pid %d: %s]\n", current->pid,
+		current->comm);
+}
+
+/**
+ * brute_get_xattr_stats() - Get the stats from an extended attribute.
+ * @dentry: The dentry of the file to get the extended attribute.
+ * @inode: The inode of the file to get the extended attribute.
+ * @stats: The stats where to store the info obtained from the extended
+ *         attribute. Cannot be NULL.
+ *
+ * Return: An error code if it is not possible to get the statistical dat=
a. Zero
+ *         otherwise.
+ */
+static int brute_get_xattr_stats(struct dentry *dentry, struct inode *ino=
de,
+				 struct brute_stats *stats)
+{
+	int rc;
+	struct brute_raw_stats raw_stats;
+
+	rc =3D __vfs_getxattr(dentry, inode, XATTR_NAME_BRUTE, &raw_stats,
+			    sizeof(raw_stats));
+	if (rc < 0)
+		return rc;
+
+	stats->faults =3D le32_to_cpu(raw_stats.faults);
+	stats->nsecs =3D le64_to_cpu(raw_stats.nsecs);
+	stats->period =3D le64_to_cpu(raw_stats.period);
+	stats->flags =3D raw_stats.flags;
+	return 0;
+}
+
+/**
+ * brute_set_xattr_stats() - Set the stats to an extended attribute.
+ * @dentry: The dentry of the file to set the extended attribute.
+ * @inode: The inode of the file to set the extended attribute.
+ * @stats: The stats from where to extract the info to set the extended a=
ttribute.
+ *         Cannot be NULL.
+ *
+ * Return: An error code if it is not possible to set the statistical dat=
a. Zero
+ *         otherwise.
+ */
+static int brute_set_xattr_stats(struct dentry *dentry, struct inode *ino=
de,
+				 const struct brute_stats *stats)
+{
+	struct brute_raw_stats raw_stats;
+
+	raw_stats.faults =3D cpu_to_le32(stats->faults);
+	raw_stats.nsecs =3D cpu_to_le64(stats->nsecs);
+	raw_stats.period =3D cpu_to_le64(stats->period);
+	raw_stats.flags =3D stats->flags;
+
+	return __vfs_setxattr(&init_user_ns, dentry, inode, XATTR_NAME_BRUTE,
+			      &raw_stats, sizeof(raw_stats), 0);
+}
+
+/**
+ * brute_update_xattr_stats() - Update the stats of a file.
+ * @file: The file that holds the statistical data to update. Cannot be N=
ULL.
+ *
+ * For a correct management of a fork brute force attack it is only neces=
sary to
+ * update the statistics and test if an attack is happening based on thes=
e data.
+ * It is important to note that if the file has no stats nothing is updat=
ed nor
+ * created. This way, the scenario where an application has not crossed a=
ny
+ * privilege boundary is avoided since the existence of the extended attr=
ibute
+ * denotes the crossing of bounds.
+ */
+static void brute_update_xattr_stats(const struct file *file)
+{
+	struct dentry *dentry =3D file_dentry(file);
+	struct inode *inode =3D file_inode(file);
+	struct brute_stats stats;
+	int rc;
+
+	inode_lock(inode);
+	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
+	WARN_ON_ONCE(rc && rc !=3D -ENODATA);
+	if (rc) {
+		inode_unlock(inode);
+		return;
+	}
+
+	brute_update_crash_period(&stats);
+	if (brute_attack_running(&stats)) {
+		brute_print_attack_running();
+		stats.not_allowed =3D true;
+	}
+
+	rc =3D brute_set_xattr_stats(dentry, inode, &stats);
+	WARN_ON_ONCE(rc);
+	inode_unlock(inode);
+}
+
+/**
+ * brute_reset_stats() - Reset the statistical data.
+ * @stats: Statistics to be reset. Cannot be NULL.
+ */
+static inline void brute_reset_stats(struct brute_stats *stats)
+{
+	memset(stats, 0, sizeof(*stats));
+}
+
+/**
+ * brute_new_xattr_stats() - New statistics for a file.
+ * @file: The file in which to create the new statistical data. Cannot be=
 NULL.
+ *
+ * Only if the file has no statistical data create it. This function will=
 be
+ * called to mark that a privilege boundary has been crossed so, if new s=
tats
+ * are required, they do not contain any useful data. The existence of th=
e
+ * extended attribute denotes the crossing of privilege bounds.
+ *
+ * Return: An error code if it is not possible to get or set the statisti=
cal
+ *         data. Zero otherwise.
+ */
+static int brute_new_xattr_stats(const struct file *file)
+{
+	struct dentry *dentry =3D file_dentry(file);
+	struct inode *inode =3D file_inode(file);
+	struct brute_stats stats;
+	int rc;
+
+	inode_lock(inode);
+	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
+	if (rc && rc !=3D -ENODATA)
+		goto unlock;
+
+	if (rc =3D=3D -ENODATA) {
+		brute_reset_stats(&stats);
+		rc =3D brute_set_xattr_stats(dentry, inode, &stats);
+		if (rc)
+			goto unlock;
+	}
+
+unlock:
+	inode_unlock(inode);
+	return rc;
+}
+
+/**
+ * brute_current_new_xattr_stats() - New stats for the current task's exe=
 file.
+ *
+ * Return: An error code if it is not possible to get or set the statisti=
cal
+ *         data. Zero otherwise.
+ */
+static int brute_current_new_xattr_stats(void)
+{
+	struct file *exe_file;
+	int rc;
+
+	exe_file =3D brute_get_current_exe_file();
+	if (WARN_ON_ONCE(!exe_file))
+		return -ENOENT;
+
+	rc =3D brute_new_xattr_stats(exe_file);
+	WARN_ON_ONCE(rc);
+	fput(exe_file);
+	return rc;
+}
+
+/**
+ * brute_signal_from_user() - Test if a signal is coming from userspace.
+ * @siginfo: Contains the signal information.
+ *
+ * To avoid false positives during the attack detection it is necessary t=
o
+ * narrow the possible cases. So, only the signals delivered by the kerne=
l are
+ * taken into account with the exception of the SIGABRT signal since the =
latter
+ * is used by glibc for stack canary, malloc, etc failures, which may ind=
icate
+ * that a mitigation has been triggered.
+ *
+ * Return: True if the signal is coming from usersapce. False otherwise.
+ */
+static inline bool brute_signal_from_user(const kernel_siginfo_t *siginfo=
)
+{
+	return siginfo->si_signo =3D=3D SIGKILL && siginfo->si_code !=3D SIGABRT=
;
+}
+
+/**
+ * brute_task_fatal_signal() - Target for the task_fatal_signal hook.
+ * @siginfo: Contains the signal information.
+ *
+ * To detect a brute force attack it is necessary, as a first step, to te=
st in
+ * every fatal crash if the signal is delibered by the kernel. If so, upd=
ate the
+ * statistics and act based on these data.
+ */
+static void brute_task_fatal_signal(const kernel_siginfo_t *siginfo)
+{
+	struct file *exe_file;
+
+	if (brute_signal_from_user(siginfo))
+		return;
+
+	exe_file =3D brute_get_current_exe_file();
+	if (WARN_ON_ONCE(!exe_file))
+		return;
+
+	brute_update_xattr_stats(exe_file);
+	fput(exe_file);
+}
+
+/**
+ * brute_task_execve() - Target for the bprm_creds_from_file hook.
+ * @bprm: Contains the linux_binprm structure.
+ * @file: Binary that will be executed without an interpreter.
+ *
+ * This hook is useful to mark that a privilege boundary (setuid/setgid p=
rocess)
+ * has been crossed. This is done based on the "secureexec" flag.
+ *
+ * To be defensive return an error code if it is not possible to get or s=
et the
+ * stats using an extended attribute since this blocks the execution of t=
he
+ * file. This scenario is treated as an attack.
+ *
+ * It is important to note that here the brute_new_xattr_stats function c=
ould be
+ * used with a previous test of the secureexec flag. However it is better=
 to use
+ * the basic xattr functions since in a future commit a test if the execu=
tion is
+ * allowed (via the brute_stats::not_allowed flag) will be necessary. Thi=
s way,
+ * the stats of the file will be get only once.
+ *
+ * Return: An error code if it is not possible to get or set the statisti=
cal
+ *         data. Zero otherwise.
+ */
+static int brute_task_execve(struct linux_binprm *bprm, struct file *file=
)
+{
+	struct dentry *dentry =3D file_dentry(bprm->file);
+	struct inode *inode =3D file_inode(bprm->file);
+	struct brute_stats stats;
+	int rc;
+
+	inode_lock(inode);
+	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
+	if (WARN_ON_ONCE(rc && rc !=3D -ENODATA))
+		goto unlock;
+
+	if (rc =3D=3D -ENODATA && bprm->secureexec) {
+		brute_reset_stats(&stats);
+		rc =3D brute_set_xattr_stats(dentry, inode, &stats);
+		if (WARN_ON_ONCE(rc))
+			goto unlock;
+	}
+
+	rc =3D 0;
+unlock:
+	inode_unlock(inode);
+	return rc;
+}
+
+/**
+ * brute_task_change_priv() - Target for the task_fix_setid hooks.
+ * @new: The set of credentials that will be installed.
+ * @old: The set of credentials that are being replaced.
+ * @flags: Contains one of the LSM_SETID_* values.
+ *
+ * This hook is useful to mark that a privilege boundary (privilege chang=
es) has
+ * been crossed.
+ *
+ * Return: An error code if it is not possible to get or set the statisti=
cal
+ *         data. Zero otherwise.
+ */
+static int brute_task_change_priv(struct cred *new, const struct cred *ol=
d, int flags)
+{
+	return brute_current_new_xattr_stats();
+}
+
+/**
+ * brute_socket_accept() - Target for the socket_accept hook.
+ * @sock: Contains the listening socket structure.
+ * @newsock: Contains the newly created server socket for connection.
+ *
+ * This hook is useful to mark that a privilege boundary (network to loca=
l) has
+ * been crossed. This is done only if the listening socket accepts extern=
al
+ * connections. The sockets for inter-process communication (IPC) and tho=
se that
+ * are listening on loopback addresses are not taken into account.
+ *
+ * Return: An error code if it is not possible to get or set the statisti=
cal
+ *         data. Zero otherwise.
+ */
+static int brute_socket_accept(struct socket *sock, struct socket *newsoc=
k)
+{
+	struct sock *sk =3D sock->sk;
+
+	if (sk->sk_family =3D=3D AF_UNIX || sk->sk_family =3D=3D AF_NETLINK ||
+	    sk->sk_rcv_saddr =3D=3D htonl(INADDR_LOOPBACK) ||
+	    ipv6_addr_equal(&sk->sk_v6_rcv_saddr, &in6addr_loopback))
+		return 0;
+
+	return brute_current_new_xattr_stats();
+}
+
+/*
+ * brute_hooks - Targets for the LSM's hooks.
+ */
+static struct security_hook_list brute_hooks[] __lsm_ro_after_init =3D {
+	LSM_HOOK_INIT(task_fatal_signal, brute_task_fatal_signal),
+	LSM_HOOK_INIT(bprm_creds_from_file, brute_task_execve),
+	LSM_HOOK_INIT(task_fix_setuid, brute_task_change_priv),
+	LSM_HOOK_INIT(task_fix_setgid, brute_task_change_priv),
+	LSM_HOOK_INIT(socket_accept, brute_socket_accept),
+};
+
 #ifdef CONFIG_SYSCTL
 static unsigned int uint_max =3D UINT_MAX;
 #define SYSCTL_UINT_MAX (&uint_max)
@@ -137,6 +613,8 @@ static inline void brute_init_sysctl(void) { }
 static int __init brute_init(void)
 {
 	pr_info("becoming mindful\n");
+	security_add_hooks(brute_hooks, ARRAY_SIZE(brute_hooks),
+			   KBUILD_MODNAME);
 	brute_init_sysctl();
 	return 0;
 }
=2D-
2.25.1

