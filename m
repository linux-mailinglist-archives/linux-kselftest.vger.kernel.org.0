Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE75638CCE0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 May 2021 20:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhEUSGk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 May 2021 14:06:40 -0400
Received: from mout.gmx.net ([212.227.15.15]:36933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232931AbhEUSGj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 May 2021 14:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621620287;
        bh=FkAJBNlJfXLTD1aQ6QDAIzJgHaThVI5Z24R4aGMuUUA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=iAgVa/3bF5UaWLOS11qXVGUcBijLwHVI3/+lSKQlkeLKapq5Dx7E0Fv6Agx7eplAk
         QqcMhEYoxsBVzVruTuvit1W6SlN0fgyMs1o10Y9vG2U8p9Y1Aj2+DKF9isTc+jUvqz
         347CPGpNZVeywpzBFvg6f/8y3m10hHX+Rz1zh3no=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([83.52.228.41]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MUXtS-1lsqh52Nw8-00QT09; Fri, 21 May 2021 20:04:47 +0200
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
Subject: [PATCH v7 4/7] security/brute: Mitigate a brute force attack
Date:   Fri, 21 May 2021 19:24:11 +0200
Message-Id: <20210521172414.69456-5-john.wood@gmx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521172414.69456-1-john.wood@gmx.com>
References: <20210521172414.69456-1-john.wood@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zRoeZqE/E+sUnl6e4VWaC6n7LeLrOHxonXqERKe/uJW00GZSVOs
 /qTH7j1end+WvQAikPGKqA7eYPxBZAacnNY4Z7LSY8JgL0DUdxdGwvww2bfxeeJMiJKsa5g
 I0FyJHJblOkC78fn2a1iaqE6Q/N4uYoV+8/RwauYWwfX7+pr55UXVHCY5fzF+vSz3KI4VS7
 4MmMA6hglQ6HiDGXiFCbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+WT2bkSS6RQ=:iSRmDYv2F2PmKlCpx+OmO9
 0EPhng9GnF779vkXZqS7J4ioH8QxVNOqjjhLq9ELRLP6vrCibK/oOkVkDoEEaUnPeWTlawszh
 w5OMjp6wAlyx2CbCRQluGuxOnaGdWJzKooV+1GOrK9KVov/46JL8G/XXnjZHLoyEyIXc+ehQ/
 Y4CAmEWzBYT2yVWABNO2x+jvjtZpWgIEGgL30gXZqlAggtoqIlqfnOCIfK238NH3h1A3RCM0W
 O649kXkDjp3qJTIbHRIErEKGWMtvRW+uTx/lXqXRVAqw+HdTjAk0C6Z5er/YpxG41Zkq9JnyI
 gP4yxbE/cIXo8dZMGYKu+mjIh/crnWf26eEnI3CVEdFHlZfJy8TBVD53LL4FdpER9EMzPX9NS
 sfd1eLLBjw6hQGDYqSniavVe+P6GlwtrSRcAS4lyJi2Coh16rbHyX4dmRPi0sIbFzV+hMdGjW
 vpW1FdPdUWyOIeomaEcLdYSMppRqgpwujqy/kERWvtUiQJafQPcR7L0SuHHzuW5+DQs8vlTIM
 8zFEXPoA+rjMs/2Np56J4qHF7qe3bDSJP2p3REJ1vCV29X8UO920FNomiUvj5FLwy3LQCeJwK
 RUI5O3P+O/0ZhyEomm48oN/aeXzE6mcK9So6CXO020CuH1rVv9gI17YXX7i4x9wfUVoVny1EL
 /Yayib2zjBzNQd0ttfxdnOg+vyFrqEUJivc5qQnIf5FulJ9icWESdmtFHz1qmhaAsbfQQIWHd
 bCmKhwkY9Qp3f6W+nv5Hn3VmJXwlhneOwVfbGsPH2UHimdg3QcP5vfx9ZIM0txSNDtLv7Laou
 k4T7xnWKA3XyBjUPalrOpjtoh5vkPERoCwvw/cC6TCsPJ5Tq93UFTstHGf5+cv8JSnKNWkmH/
 dHluKoSWPLpBJLPTq62sQGMxMEi5hjsa6XPAlEahw/QJVEfM+Q91LT3vUdX5zfceFdOSKVscg
 IKrU53PlZAZSyJ5Fv5u6+ARO/4ZLKKsyrA8uZ0Qu8hiFetV519WfDyBTLgAtK9XLFJo+vQSNh
 MPzjgzoiprBMQs27z8z89Bujgly4zWYGiq/Ri55rkAwUgm4Bwc2kzPDgmdYHLM1UzXBkLu1I0
 MnZTFy14YoFofmyfWXTVrQD58pgNERMVqK35sVGrrQo1hEkxvIgE1mhP32BCrkdd/3nkzzM9r
 y9DjiniX+cHw0/faaHJn2JeyDcBxGbUAbGhyd//H9xS9Abc1QYiqzdBlydvWWsZwsTPDY=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a brute force attack is detected all the offending tasks involved
in the attack must be killed. In other words, it is necessary to kill
all the tasks that are executing the same file that is running during
the brute force attack.

Also, to prevent the executable involved in the attack from being
respawned by a supervisor, and thus prevent a brute force attack from
being started again, test the "not_allowed" flag and avoid the file
execution based on this.

Signed-off-by: John Wood <john.wood@gmx.com>
=2D--
 security/brute/brute.c | 113 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 11 deletions(-)

diff --git a/security/brute/brute.c b/security/brute/brute.c
index 66db0dd0664d..7712dac888db 100644
=2D-- a/security/brute/brute.c
+++ b/security/brute/brute.c
@@ -233,6 +233,88 @@ static inline void brute_print_attack_running(void)
 		current->comm);
 }

+/**
+ * brute_print_file_not_allowed() - Warn about a file not allowed.
+ * @dentry: The dentry of the file not allowed.
+ */
+static void brute_print_file_not_allowed(struct dentry *dentry)
+{
+	char *buf, *path;
+
+	buf =3D __getname();
+	if (WARN_ON_ONCE(!buf))
+		return;
+
+	path =3D dentry_path_raw(dentry, buf, PATH_MAX);
+	if (WARN_ON_ONCE(IS_ERR(path)))
+		goto free;
+
+	pr_warn_ratelimited("%s not allowed\n", path);
+free:
+	__putname(buf);
+}
+
+/**
+ * brute_is_same_file() - Test if two files are the same.
+ * @file1: First file to compare. Cannot be NULL.
+ * @file2: Second file to compare. Cannot be NULL.
+ *
+ * Two files are the same if they have the same inode number and the same=
 block
+ * device.
+ *
+ * Return: True if the two files are the same. False otherwise.
+ */
+static inline bool brute_is_same_file(const struct file *file1,
+				      const struct file *file2)
+{
+	struct inode *inode1 =3D file_inode(file1);
+	struct inode *inode2 =3D file_inode(file2);
+
+	return inode1->i_ino =3D=3D inode2->i_ino &&
+		inode1->i_sb->s_dev =3D=3D inode2->i_sb->s_dev;
+}
+
+/**
+ * brute_kill_offending_tasks() - Kill the offending tasks.
+ * @file: The file executed during a brute force attack. Cannot be NULL.
+ *
+ * When a brute force attack is detected all the offending tasks involved=
 in the
+ * attack must be killed. In other words, it is necessary to kill all the=
 tasks
+ * that are executing the same file that is running during the brute forc=
e
+ * attack. Moreover, the processes that have the same group_leader that t=
he
+ * current task must be avoided since they are in the path to be killed.
+ *
+ * The for_each_process loop is protected by the tasklist_lock acquired i=
n read
+ * mode instead of rcu_read_lock to avoid that the newly created processe=
s
+ * escape this RCU read lock.
+ */
+static void brute_kill_offending_tasks(const struct file *file)
+{
+	struct task_struct *task;
+	struct file *exe_file;
+	bool is_same_file;
+
+	read_lock(&tasklist_lock);
+	for_each_process(task) {
+		if (task->group_leader =3D=3D current->group_leader)
+			continue;
+
+		exe_file =3D get_task_exe_file(task);
+		if (!exe_file)
+			continue;
+
+		is_same_file =3D brute_is_same_file(exe_file, file);
+		fput(exe_file);
+		if (!is_same_file)
+			continue;
+
+		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_PID);
+		pr_warn_ratelimited("Offending process %d [%s] killed\n",
+				    task->pid, task->comm);
+	}
+	read_unlock(&tasklist_lock);
+}
+
 /**
  * brute_get_xattr_stats() - Get the stats from an extended attribute.
  * @dentry: The dentry of the file to get the extended attribute.
@@ -295,6 +377,10 @@ static int brute_set_xattr_stats(struct dentry *dentr=
y, struct inode *inode,
  * created. This way, the scenario where an application has not crossed a=
ny
  * privilege boundary is avoided since the existence of the extended attr=
ibute
  * denotes the crossing of bounds.
+ *
+ * Also, do not update the statistics if the execution of the file is not
+ * allowed and kill all the offending tasks when a brute force attack is
+ * detected.
  */
 static void brute_update_xattr_stats(const struct file *file)
 {
@@ -306,7 +392,7 @@ static void brute_update_xattr_stats(const struct file=
 *file)
 	inode_lock(inode);
 	rc =3D brute_get_xattr_stats(dentry, inode, &stats);
 	WARN_ON_ONCE(rc && rc !=3D -ENODATA);
-	if (rc) {
+	if (rc || (!rc && stats.not_allowed)) {
 		inode_unlock(inode);
 		return;
 	}
@@ -320,6 +406,9 @@ static void brute_update_xattr_stats(const struct file=
 *file)
 	rc =3D brute_set_xattr_stats(dentry, inode, &stats);
 	WARN_ON_ONCE(rc);
 	inode_unlock(inode);
+
+	if (stats.not_allowed)
+		brute_kill_offending_tasks(file);
 }

 /**
@@ -433,21 +522,17 @@ static void brute_task_fatal_signal(const kernel_sig=
info_t *siginfo)
  * @bprm: Contains the linux_binprm structure.
  * @file: Binary that will be executed without an interpreter.
  *
- * This hook is useful to mark that a privilege boundary (setuid/setgid p=
rocess)
- * has been crossed. This is done based on the "secureexec" flag.
+ * If there are statistics, test the "not_allowed" flag and avoid the fil=
e
+ * execution based on this. Also, this hook is useful to mark that a priv=
ilege
+ * boundary (setuid/setgid process) has been crossed. This is done based =
on the
+ * "secureexec" flag.
  *
  * To be defensive return an error code if it is not possible to get or s=
et the
  * stats using an extended attribute since this blocks the execution of t=
he
  * file. This scenario is treated as an attack.
  *
- * It is important to note that here the brute_new_xattr_stats function c=
ould be
- * used with a previous test of the secureexec flag. However it is better=
 to use
- * the basic xattr functions since in a future commit a test if the execu=
tion is
- * allowed (via the brute_stats::not_allowed flag) will be necessary. Thi=
s way,
- * the stats of the file will be get only once.
- *
- * Return: An error code if it is not possible to get or set the statisti=
cal
- *         data. Zero otherwise.
+ * Return: -EPERM if the execution of the file is not allowed. An error c=
ode if
+ *         it is not possible to get or set the statistical data. Zero ot=
herwise.
  */
 static int brute_task_execve(struct linux_binprm *bprm, struct file *file=
)
 {
@@ -461,6 +546,12 @@ static int brute_task_execve(struct linux_binprm *bpr=
m, struct file *file)
 	if (WARN_ON_ONCE(rc && rc !=3D -ENODATA))
 		goto unlock;

+	if (!rc && stats.not_allowed) {
+		brute_print_file_not_allowed(dentry);
+		rc =3D -EPERM;
+		goto unlock;
+	}
+
 	if (rc =3D=3D -ENODATA && bprm->secureexec) {
 		brute_reset_stats(&stats);
 		rc =3D brute_set_xattr_stats(dentry, inode, &stats);
=2D-
2.25.1

