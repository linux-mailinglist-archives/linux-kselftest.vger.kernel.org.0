Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD262140D9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 16:16:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgAQPPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 10:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60056 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgAQPPr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 10:15:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C73C5AF41;
        Fri, 17 Jan 2020 15:15:45 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        alex.shi@linux.alibaba.com, guro@fb.com, kernel-team@android.com,
        linger.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, tomcherry@google.com
Subject: [PATCH 2/3] cgroup: Iterate tasks that did not finish do_exit()
Date:   Fri, 17 Jan 2020 16:15:32 +0100
Message-Id: <20200117151533.12381-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117151533.12381-1-mkoutny@suse.com>
References: <20200116043612.52782-1-surenb@google.com>
 <20200117151533.12381-1-mkoutny@suse.com>
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
 kernel/cgroup/cgroup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b56283e13491..132d258e7172 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4492,11 +4492,12 @@ static void css_task_iter_advance(struct css_task_iter *it)
 			goto repeat;
 
 		/* and dying leaders w/o live member threads */
-		if (!atomic_read(&task->signal->live))
+		if (it->cur_list == CSS_SET_TASKS_DYING &&
+		    !atomic_read(&task->signal->live))
 			goto repeat;
 	} else {
 		/* skip all dying ones */
-		if (task->flags & PF_EXITING)
+		if (it->cur_list == CSS_SET_TASKS_DYING)
 			goto repeat;
 	}
 }
-- 
2.24.1

