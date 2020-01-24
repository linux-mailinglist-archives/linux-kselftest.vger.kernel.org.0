Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8BEC148414
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2020 12:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392058AbgAXLkd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Jan 2020 06:40:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:50776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391200AbgAXLkd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Jan 2020 06:40:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43407B149;
        Fri, 24 Jan 2020 11:40:30 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     alex.shi@linux.alibaba.com, guro@fb.com, hannes@cmpxchg.org,
        kernel-team@android.com, linger.lee@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, lizefan@huawei.com,
        matthias.bgg@gmail.com, shuah@kernel.org, surenb@google.com,
        tj@kernel.org, tomcherry@google.com
Subject: [PATCH v2 1/3] cgroup: Iterate tasks that did not finish do_exit()
Date:   Fri, 24 Jan 2020 12:40:15 +0100
Message-Id: <20200124114017.8363-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124114017.8363-1-mkoutny@suse.com>
References: <20200120145635.GA30904@blackbody.suse.cz>
 <20200124114017.8363-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

PF_EXITING is set earlier than actual removal from css_set when a task
is exitting. This can confuse cgroup.procs readers who see no PF_EXITING
tasks, however, rmdir is checking against css_set membership so it can
transitionally fail with EBUSY.

Fix this by listing tasks that weren't unlinked from css_set active
lists.
It may happen that other users of the task iterator (without
CSS_TASK_ITER_PROCS) spot a PF_EXITING task before cgroup_exit(). This
is equal to the state before commit c03cd7738a83 ("cgroup: Include dying
leaders with live threads in PROCS iterations") but it may be reviewed
later.

Reported-by: Suren Baghdasaryan <surenb@google.com>
Fixes: c03cd7738a83 ("cgroup: Include dying leaders with live threads in PROCS iterations")
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup.h |  1 +
 kernel/cgroup/cgroup.c | 23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index d7ddebd0cdec..e75d2191226b 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -62,6 +62,7 @@ struct css_task_iter {
 	struct list_head		*mg_tasks_head;
 	struct list_head		*dying_tasks_head;
 
+	struct list_head		*cur_tasks_head;
 	struct css_set			*cur_cset;
 	struct css_set			*cur_dcset;
 	struct task_struct		*cur_task;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..a6e3619e013b 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4404,12 +4404,16 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 		}
 	} while (!css_set_populated(cset) && list_empty(&cset->dying_tasks));
 
-	if (!list_empty(&cset->tasks))
+	if (!list_empty(&cset->tasks)) {
 		it->task_pos = cset->tasks.next;
-	else if (!list_empty(&cset->mg_tasks))
+		it->cur_tasks_head = &cset->tasks;
+	} else if (!list_empty(&cset->mg_tasks)) {
 		it->task_pos = cset->mg_tasks.next;
-	else
+		it->cur_tasks_head = &cset->mg_tasks;
+	} else {
 		it->task_pos = cset->dying_tasks.next;
+		it->cur_tasks_head = &cset->dying_tasks;
+	}
 
 	it->tasks_head = &cset->tasks;
 	it->mg_tasks_head = &cset->mg_tasks;
@@ -4467,10 +4471,14 @@ static void css_task_iter_advance(struct css_task_iter *it)
 		else
 			it->task_pos = it->task_pos->next;
 
-		if (it->task_pos == it->tasks_head)
+		if (it->task_pos == it->tasks_head) {
 			it->task_pos = it->mg_tasks_head->next;
-		if (it->task_pos == it->mg_tasks_head)
+			it->cur_tasks_head = it->mg_tasks_head;
+		}
+		if (it->task_pos == it->mg_tasks_head) {
 			it->task_pos = it->dying_tasks_head->next;
+			it->cur_tasks_head = it->dying_tasks_head;
+		}
 		if (it->task_pos == it->dying_tasks_head)
 			css_task_iter_advance_css_set(it);
 	} else {
@@ -4489,11 +4497,12 @@ static void css_task_iter_advance(struct css_task_iter *it)
 			goto repeat;
 
 		/* and dying leaders w/o live member threads */
-		if (!atomic_read(&task->signal->live))
+		if (it->cur_tasks_head == it->dying_tasks_head &&
+		    !atomic_read(&task->signal->live))
 			goto repeat;
 	} else {
 		/* skip all dying ones */
-		if (task->flags & PF_EXITING)
+		if (it->cur_tasks_head == it->dying_tasks_head)
 			goto repeat;
 	}
 }
-- 
2.24.1

