Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5D94D95CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 17:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405399AbfJPPhd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 11:37:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47477 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405138AbfJPPhT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 11:37:19 -0400
Received: from [213.220.153.21] (helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iKlMT-00050w-Ed; Wed, 16 Oct 2019 15:37:17 +0000
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     oleg@redhat.com, linux-kernel@vger.kernel.org
Cc:     aarcange@redhat.com, akpm@linux-foundation.org,
        christian@kellner.me, cyphar@cyphar.com, elena.reshetova@intel.com,
        guro@fb.com, jannh@google.com, ldv@altlinux.org,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mhocko@suse.com, mingo@kernel.org, peterz@infradead.org,
        shuah@kernel.org, tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 3/5] pid: use task_alive() in __change_pid()
Date:   Wed, 16 Oct 2019 17:36:04 +0200
Message-Id: <20191016153606.2326-3-christian.brauner@ubuntu.com>
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

Replace hlist_empty() with the new task_alive() helper which is more
idiomatic, easier to grep for, and unifies how callers perform this
check.

Cc: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v1 */
patch not present

/* v2 */
patch introduced
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 0a9f2e437217..70ad4a9f728c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -299,7 +299,7 @@ static void __change_pid(struct task_struct *task, enum pid_type type,
 	*pid_ptr = new;
 
 	for (tmp = PIDTYPE_MAX; --tmp >= 0; )
-		if (!hlist_empty(&pid->tasks[tmp]))
+		if (task_alive(pid, tmp))
 			return;
 
 	free_pid(pid);
-- 
2.23.0

