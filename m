Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD397140D9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2020 16:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgAQPPr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jan 2020 10:15:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728816AbgAQPPr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jan 2020 10:15:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4EDB1AF40;
        Fri, 17 Jan 2020 15:15:44 +0000 (UTC)
From:   =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To:     cgroups@vger.kernel.org
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>,
        alex.shi@linux.alibaba.com, guro@fb.com, kernel-team@android.com,
        linger.lee@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        shuah@kernel.org, tomcherry@google.com
Subject: [PATCH 1/3] cgroup: Unify css_set task lists
Date:   Fri, 17 Jan 2020 16:15:31 +0100
Message-Id: <20200117151533.12381-2-mkoutny@suse.com>
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

We track tasks of css_set in three different lists. The iterators
unnecessarily process each list specially.
Use an array of lists and simplify the iterator code. This is
refactoring with no intended functional change.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 include/linux/cgroup-defs.h | 15 ++++---
 include/linux/cgroup.h      |  4 +-
 kernel/cgroup/cgroup.c      | 81 +++++++++++++++++++------------------
 kernel/cgroup/debug.c       | 16 ++++----
 4 files changed, 60 insertions(+), 56 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 63097cb243cb..e474b5a67438 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -180,6 +180,13 @@ struct cgroup_subsys_state {
 	struct cgroup_subsys_state *parent;
 };
 
+enum css_set_task_list {
+	CSS_SET_TASKS = 0,
+	CSS_SET_TASKS_MG,
+	CSS_SET_TASKS_DYING,
+	CSS_SET_TASKS_COUNT,
+};
+
 /*
  * A css_set is a structure holding pointers to a set of
  * cgroup_subsys_state objects. This saves space in the task struct
@@ -214,14 +221,12 @@ struct css_set {
 
 	/*
 	 * Lists running through all tasks using this cgroup group.
-	 * mg_tasks lists tasks which belong to this cset but are in the
+	 * CSS_SET_TASKS_MG lists tasks which belong to this cset but are in the
 	 * process of being migrated out or in.  Protected by
 	 * css_set_rwsem, but, during migration, once tasks are moved to
-	 * mg_tasks, it can be read safely while holding cgroup_mutex.
+	 * CSS_SET_TASKS_MG, it can be read safely while holding cgroup_mutex.
 	 */
-	struct list_head tasks;
-	struct list_head mg_tasks;
-	struct list_head dying_tasks;
+	struct list_head tasks[CSS_SET_TASKS_COUNT];
 
 	/* all css_task_iters currently walking this cset */
 	struct list_head task_iters;
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index d7ddebd0cdec..284e6b4b43cc 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -58,10 +58,8 @@ struct css_task_iter {
 	struct list_head		*tcset_head;
 
 	struct list_head		*task_pos;
-	struct list_head		*tasks_head;
-	struct list_head		*mg_tasks_head;
-	struct list_head		*dying_tasks_head;
 
+	enum css_set_task_list		cur_list;
 	struct css_set			*cur_cset;
 	struct css_set			*cur_dcset;
 	struct task_struct		*cur_task;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 735af8f15f95..b56283e13491 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -737,9 +737,9 @@ EXPORT_SYMBOL_GPL(of_css);
 struct css_set init_css_set = {
 	.refcount		= REFCOUNT_INIT(1),
 	.dom_cset		= &init_css_set,
-	.tasks			= LIST_HEAD_INIT(init_css_set.tasks),
-	.mg_tasks		= LIST_HEAD_INIT(init_css_set.mg_tasks),
-	.dying_tasks		= LIST_HEAD_INIT(init_css_set.dying_tasks),
+	.tasks[CSS_SET_TASKS]	= LIST_HEAD_INIT(init_css_set.tasks[CSS_SET_TASKS]),
+	.tasks[CSS_SET_TASKS_MG]	= LIST_HEAD_INIT(init_css_set.tasks[CSS_SET_TASKS_MG]),
+	.tasks[CSS_SET_TASKS_DYING]	= LIST_HEAD_INIT(init_css_set.tasks[CSS_SET_TASKS_DYING]),
 	.task_iters		= LIST_HEAD_INIT(init_css_set.task_iters),
 	.threaded_csets		= LIST_HEAD_INIT(init_css_set.threaded_csets),
 	.cgrp_links		= LIST_HEAD_INIT(init_css_set.cgrp_links),
@@ -775,7 +775,8 @@ static bool css_set_populated(struct css_set *cset)
 {
 	lockdep_assert_held(&css_set_lock);
 
-	return !list_empty(&cset->tasks) || !list_empty(&cset->mg_tasks);
+	return !list_empty(&cset->tasks[CSS_SET_TASKS]) ||
+	       !list_empty(&cset->tasks[CSS_SET_TASKS_MG]);
 }
 
 /**
@@ -865,7 +866,7 @@ static void css_set_skip_task_iters(struct css_set *cset,
  * @task: task being moved
  * @from_cset: css_set @task currently belongs to (may be NULL)
  * @to_cset: new css_set @task is being moved to (may be NULL)
- * @use_mg_tasks: move to @to_cset->mg_tasks instead of ->tasks
+ * @use_mg_tasks: move to @to_cset->tasks[CSS_SET_TASKS_MG] instead of ->tasks[CSS_SET_TASKS]
  *
  * Move @task from @from_cset to @to_cset.  If @task didn't belong to any
  * css_set, @from_cset can be NULL.  If @task is being disassociated
@@ -896,6 +897,8 @@ static void css_set_move_task(struct task_struct *task,
 	}
 
 	if (to_cset) {
+		enum css_set_task_list ls = use_mg_tasks ? CSS_SET_TASKS_MG : CSS_SET_TASKS;
+
 		/*
 		 * We are synchronized through cgroup_threadgroup_rwsem
 		 * against PF_EXITING setting such that we can't race
@@ -904,8 +907,7 @@ static void css_set_move_task(struct task_struct *task,
 		WARN_ON_ONCE(task->flags & PF_EXITING);
 
 		cgroup_move_task(task, to_cset);
-		list_add_tail(&task->cg_list, use_mg_tasks ? &to_cset->mg_tasks :
-							     &to_cset->tasks);
+		list_add_tail(&task->cg_list, &to_cset->tasks[ls]);
 	}
 }
 
@@ -1211,9 +1213,9 @@ static struct css_set *find_css_set(struct css_set *old_cset,
 
 	refcount_set(&cset->refcount, 1);
 	cset->dom_cset = cset;
-	INIT_LIST_HEAD(&cset->tasks);
-	INIT_LIST_HEAD(&cset->mg_tasks);
-	INIT_LIST_HEAD(&cset->dying_tasks);
+	INIT_LIST_HEAD(&cset->tasks[CSS_SET_TASKS]);
+	INIT_LIST_HEAD(&cset->tasks[CSS_SET_TASKS_MG]);
+	INIT_LIST_HEAD(&cset->tasks[CSS_SET_TASKS_DYING]);
 	INIT_LIST_HEAD(&cset->task_iters);
 	INIT_LIST_HEAD(&cset->threaded_csets);
 	INIT_HLIST_NODE(&cset->hlist);
@@ -2285,7 +2287,7 @@ EXPORT_SYMBOL_GPL(task_cgroup_path);
  * Add @task, which is a migration target, to @mgctx->tset.  This function
  * becomes noop if @task doesn't need to be migrated.  @task's css_set
  * should have been added as a migration source and @task->cg_list will be
- * moved from the css_set's tasks list to mg_tasks one.
+ * moved from the css_set's tasks list to tasks[CSS_SET_TASKS_MG] one.
  */
 static void cgroup_migrate_add_task(struct task_struct *task,
 				    struct cgroup_mgctx *mgctx)
@@ -2307,7 +2309,7 @@ static void cgroup_migrate_add_task(struct task_struct *task,
 
 	mgctx->tset.nr_tasks++;
 
-	list_move_tail(&task->cg_list, &cset->mg_tasks);
+	list_move_tail(&task->cg_list, &cset->tasks[CSS_SET_TASKS_MG]);
 	if (list_empty(&cset->mg_node))
 		list_add_tail(&cset->mg_node,
 			      &mgctx->tset.src_csets);
@@ -2348,12 +2350,12 @@ struct task_struct *cgroup_taskset_next(struct cgroup_taskset *tset,
 
 	while (&cset->mg_node != tset->csets) {
 		if (!task)
-			task = list_first_entry(&cset->mg_tasks,
+			task = list_first_entry(&cset->tasks[CSS_SET_TASKS_MG],
 						struct task_struct, cg_list);
 		else
 			task = list_next_entry(task, cg_list);
 
-		if (&task->cg_list != &cset->mg_tasks) {
+		if (&task->cg_list != &cset->tasks[CSS_SET_TASKS_MG]) {
 			tset->cur_cset = cset;
 			tset->cur_task = task;
 
@@ -2416,7 +2418,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	 */
 	spin_lock_irq(&css_set_lock);
 	list_for_each_entry(cset, &tset->src_csets, mg_node) {
-		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
+		list_for_each_entry_safe(task, tmp_task, &cset->tasks[CSS_SET_TASKS_MG], cg_list) {
 			struct css_set *from_cset = task_css_set(task);
 			struct css_set *to_cset = cset->mg_dst_cset;
 
@@ -2470,7 +2472,7 @@ static int cgroup_migrate_execute(struct cgroup_mgctx *mgctx)
 	spin_lock_irq(&css_set_lock);
 	list_splice_init(&tset->dst_csets, &tset->src_csets);
 	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
-		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
+		list_splice_tail_init(&cset->tasks[CSS_SET_TASKS_MG], &cset->tasks[CSS_SET_TASKS]);
 		list_del_init(&cset->mg_node);
 	}
 	spin_unlock_irq(&css_set_lock);
@@ -2592,7 +2594,7 @@ void cgroup_migrate_add_src(struct css_set *src_cset,
 
 	WARN_ON(src_cset->mg_src_cgrp);
 	WARN_ON(src_cset->mg_dst_cgrp);
-	WARN_ON(!list_empty(&src_cset->mg_tasks));
+	WARN_ON(!list_empty(&src_cset->tasks[CSS_SET_TASKS_MG]));
 	WARN_ON(!list_empty(&src_cset->mg_node));
 
 	src_cset->mg_src_cgrp = src_cgrp;
@@ -2905,7 +2907,7 @@ static int cgroup_update_dfl_csses(struct cgroup *cgrp)
 		struct task_struct *task, *ntask;
 
 		/* all tasks in src_csets need to be migrated */
-		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
+		list_for_each_entry_safe(task, ntask, &src_cset->tasks[CSS_SET_TASKS], cg_list)
 			cgroup_migrate_add_task(task, &mgctx);
 	}
 	spin_unlock_irq(&css_set_lock);
@@ -4402,18 +4404,18 @@ static void css_task_iter_advance_css_set(struct css_task_iter *it)
 			it->task_pos = NULL;
 			return;
 		}
-	} while (!css_set_populated(cset) && list_empty(&cset->dying_tasks));
-
-	if (!list_empty(&cset->tasks))
-		it->task_pos = cset->tasks.next;
-	else if (!list_empty(&cset->mg_tasks))
-		it->task_pos = cset->mg_tasks.next;
-	else
-		it->task_pos = cset->dying_tasks.next;
+	} while (!css_set_populated(cset) && list_empty(&cset->tasks[CSS_SET_TASKS_DYING]));
 
-	it->tasks_head = &cset->tasks;
-	it->mg_tasks_head = &cset->mg_tasks;
-	it->dying_tasks_head = &cset->dying_tasks;
+	it->cur_list = CSS_SET_TASKS;
+	while (list_empty(&cset->tasks[it->cur_list])) {
+		/* At least one list should be non-empty */
+		if (WARN_ON(++it->cur_list == CSS_SET_TASKS_COUNT)) {
+			it->cur_list = CSS_SET_TASKS;
+			it->task_pos = NULL;
+			return;
+		}
+	}
+	it->task_pos = cset->tasks[it->cur_list].next;
 
 	/*
 	 * We don't keep css_sets locked across iteration steps and thus
@@ -4458,21 +4460,22 @@ static void css_task_iter_advance(struct css_task_iter *it)
 repeat:
 	if (it->task_pos) {
 		/*
-		 * Advance iterator to find next entry.  cset->tasks is
-		 * consumed first and then ->mg_tasks.  After ->mg_tasks,
-		 * we move onto the next cset.
+		 * Advance iterator to find next entry. All lists in
+		 * cset->tasks[] are consumed, then we move onto the next cset.
 		 */
 		if (it->flags & CSS_TASK_ITER_SKIPPED)
 			it->flags &= ~CSS_TASK_ITER_SKIPPED;
 		else
 			it->task_pos = it->task_pos->next;
 
-		if (it->task_pos == it->tasks_head)
-			it->task_pos = it->mg_tasks_head->next;
-		if (it->task_pos == it->mg_tasks_head)
-			it->task_pos = it->dying_tasks_head->next;
-		if (it->task_pos == it->dying_tasks_head)
-			css_task_iter_advance_css_set(it);
+		while (it->task_pos == &it->cur_cset->tasks[it->cur_list]) {
+			if (++it->cur_list == CSS_SET_TASKS_COUNT) {
+				css_task_iter_advance_css_set(it);
+				break;
+			}
+
+			it->task_pos = it->cur_cset->tasks[it->cur_list].next;
+		}
 	} else {
 		/* called from start, proceed to the first cset */
 		css_task_iter_advance_css_set(it);
@@ -5986,7 +5989,7 @@ void cgroup_exit(struct task_struct *tsk)
 	WARN_ON_ONCE(list_empty(&tsk->cg_list));
 	cset = task_css_set(tsk);
 	css_set_move_task(tsk, cset, NULL, false);
-	list_add_tail(&tsk->cg_list, &cset->dying_tasks);
+	list_add_tail(&tsk->cg_list, &cset->tasks[CSS_SET_TASKS_DYING]);
 	cset->nr_tasks--;
 
 	WARN_ON_ONCE(cgroup_task_frozen(tsk));
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027ac3..26b4908600f7 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -124,6 +124,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 		struct task_struct *task;
 		int count = 0;
 		int refcnt = refcount_read(&cset->refcount);
+		enum css_set_task_list ls;
 
 		/*
 		 * Print out the proc_cset and threaded_cset relationship
@@ -161,17 +162,14 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 		}
 		seq_puts(seq, "\n");
 
-		list_for_each_entry(task, &cset->tasks, cg_list) {
-			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
-				seq_printf(seq, "  task %d\n",
-					   task_pid_vnr(task));
+		for (ls = CSS_SET_TASKS; ls < CSS_SET_TASKS_DYING; ++ls) {
+			list_for_each_entry(task, &cset->tasks[ls], cg_list) {
+				if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
+					seq_printf(seq, "  task %d\n",
+						   task_pid_vnr(task));
+			}
 		}
 
-		list_for_each_entry(task, &cset->mg_tasks, cg_list) {
-			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
-				seq_printf(seq, "  task %d\n",
-					   task_pid_vnr(task));
-		}
 		/* show # of overflowed tasks */
 		if (count > MAX_TASKS_SHOWN_PER_CSS)
 			seq_printf(seq, "  ... (%d)\n",
-- 
2.24.1

