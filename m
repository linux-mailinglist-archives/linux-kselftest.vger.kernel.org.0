Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D2D3DA9B9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2019 12:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408809AbfJQKTI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Oct 2019 06:19:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36474 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408801AbfJQKTI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Oct 2019 06:19:08 -0400
Received: from [185.81.136.22] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iL2s6-0007tP-Q6; Thu, 17 Oct 2019 10:19:06 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 5/5] pid: use pid_has_task() in pidfd_open()
Date:   Thu, 17 Oct 2019 12:18:32 +0200
Message-Id: <20191017101832.5985-5-christian.brauner@ubuntu.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017101832.5985-1-christian.brauner@ubuntu.com>
References: <20191016153606.2326-1-christian.brauner@ubuntu.com>
 <20191017101832.5985-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use the new pid_has_task() helper in pidfd_open(). This simplifies the
code and avoids taking rcu_read_{lock,unlock}() and leads to overall
nicer code.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
---
/* pidfd selftests */
passed

/* v1 */
patch not present

/* v2 */
Link: https://lore.kernel.org/r/20191016153606.2326-5-christian.brauner@ubuntu.com
patch introduced

/* v3 */
- Oleg Nesterov <oleg@redhat.com>:
  - s/task_alive/pid_has_task/
---
 kernel/pid.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 124d40b239b1..7b5f6c963d72 100644
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
+	if (pid_has_task(p, PIDTYPE_TGID))
+		fd = pidfd_create(p);
+	else
+		fd = -EINVAL;
 
-	fd = ret ?: pidfd_create(p);
 	put_pid(p);
 	return fd;
 }
-- 
2.23.0

