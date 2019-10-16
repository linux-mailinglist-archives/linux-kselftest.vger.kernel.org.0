Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0CD95BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405279AbfJPPhV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:37:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47481 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405140AbfJPPhU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:37:20 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKlMU-00050w-QB; Wed, 16 Oct 2019 15:37:18 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 5/5] pid: use task_alive() in pidfd_open()
Date:   Wed, 16 Oct 2019 17:36:06 +0200
Message-Id: <20191016153606.2326-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016153606.2326-1-christian.brauner@ubuntu.com>
References: <20191015141332.4055-1-christian.brauner@ubuntu.com>
 <20191016153606.2326-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new task_alive() helper in pidfd_open(). This simplifies the
code and avoids taking rcu_read_{lock,unlock}() and leads to overall
nicer code.

Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch introduced
---
 kernel/pid.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 70ad4a9f728c..1f425b6c4c47 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -497,7 +497,7 @@ static int pidfd_create(struct pid *pid)
  */
 SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 {
-	int fd, ret;
+	int fd;
 	struct pid *p;
 
 	if (flags)
@@ -510,13 +510,11 @@ SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 	if (!p)
 		return -ESRCH;
 
-	ret = 0;
-	rcu_read_lock();
-	if (!pid_task(p, PIDTYPE_TGID))
-		ret = -EINVAL;
-	rcu_read_unlock();
+	if (task_alive(p, PIDTYPE_TGID))
+		fd = pidfd_create(p);
+	else
+		fd = -EINVAL;
 
-	fd = ret ?: pidfd_create(p);
 	put_pid(p);
 	return fd;
 }
-- 
2.23.0

