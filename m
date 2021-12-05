Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCAF468CCB
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Dec 2021 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237431AbhLESgo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Dec 2021 13:36:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237385AbhLESgi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Dec 2021 13:36:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638729190;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTVK2QbSlbKwETYyCQJF8wyM9kXXVhmFsC/fxsA6l+8=;
        b=GdBi9KeW4Y4UNHdT4t+5By5/gt4vUc6r4wBrDQ8uNAkBKyP21QOM0REnH56BNHdmZEG+SP
        JjIG56xI+kAvcfKiaZL2068RFiTOecM6zxvRDO4qdNeY2qnwEO+QZubGXB4eamrKRxbWZf
        h/5GYkTy1cI0Ke5CZoU3mtl7QEcN/S8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-nozpO1CQMUCjKaLMalcZWA-1; Sun, 05 Dec 2021 13:33:07 -0500
X-MC-Unique: nozpO1CQMUCjKaLMalcZWA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB4D1006AA0;
        Sun,  5 Dec 2021 18:33:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E73D7694BD;
        Sun,  5 Dec 2021 18:33:03 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v9 5/7] cgroup/cpuset: Show invalid partition reason string
Date:   Sun,  5 Dec 2021 13:32:18 -0500
Message-Id: <20211205183220.818872-6-longman@redhat.com>
In-Reply-To: <20211205183220.818872-1-longman@redhat.com>
References: <20211205183220.818872-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are a number of different reasons which can cause a partition to
become invalid. A user seeing an invalid partition may not know exactly
why. To help user to get a better understanding of the underlying reason,
The cpuset.cpus.partition control file, when read, will now report the
reason why a partition become invalid. When a partition does become
invalid, reading the control file will show "root invalid (<reason>)"
where <reason> is a string that describes why the partition is invalid.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 58 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index cfab10911682..d1025470b9ea 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -85,6 +85,26 @@ struct fmeter {
 	spinlock_t lock;	/* guards read or write of above */
 };
 
+/*
+ * Invalid partition error code
+ */
+enum prs_errcode {
+	PERR_NONE = 0,
+	PERR_INVCPUS,
+	PERR_INVPARENT,
+	PERR_NOTPART,
+	PERR_NOCPUS,
+	PERR_HOTPLUG,
+};
+
+static const char * const perr_strings[] = {
+	[PERR_INVCPUS]   = "Invalid change to cpuset.cpus",
+	[PERR_INVPARENT] = "Parent is an invalid partition root",
+	[PERR_NOTPART]   = "Parent is not a partition root",
+	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
+	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
+};
+
 struct cpuset {
 	struct cgroup_subsys_state css;
 
@@ -168,6 +188,9 @@ struct cpuset {
 	int use_parent_ecpus;
 	int child_ecpus_count;
 
+	/* Invalid partition error code, not lock protected */
+	enum prs_errcode prs_err;
+
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
 };
@@ -282,8 +305,13 @@ static inline int is_partition_root(const struct cpuset *cs)
 static inline void notify_partition_change(struct cpuset *cs,
 					   int old_prs, int new_prs)
 {
-	if (old_prs != new_prs)
-		cgroup_file_notify(&cs->partition_file);
+	if (old_prs == new_prs)
+		return;
+	cgroup_file_notify(&cs->partition_file);
+
+	/* Reset prs_err if not invalid */
+	if (new_prs != PRS_ERROR)
+		WRITE_ONCE(cs->prs_err, PERR_NONE);
 }
 
 static struct cpuset top_cpuset = {
@@ -1292,6 +1320,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		part_error = partition_is_populated(parent, cpuset) &&
 			cpumask_subset(parent->effective_cpus, tmp->addmask) &&
 			!cpumask_intersects(tmp->delmask, cpu_active_mask);
+
+		if ((READ_ONCE(cpuset->prs_err) == PERR_NONE) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_INVCPUS);
 	} else {
 		/*
 		 * partcmd_update w/o newmask:
@@ -1315,6 +1346,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 			      !parent->nr_subparts_cpus) ||
 			     (cpumask_equal(parent->effective_cpus, tmp->addmask) &&
 			      partition_is_populated(parent, cpuset));
+
+		if (is_partition_root(cpuset) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_NOCPUS);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1471,6 +1505,9 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 * invalid too.
 				 */
 				new_prs = PRS_ERROR;
+				WRITE_ONCE(cp->prs_err,
+					  (parent->partition_root_state == PRS_ERROR)
+					   ? PERR_INVPARENT : PERR_NOTPART);
 				break;
 			}
 		}
@@ -2632,7 +2669,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
-	const char *type;
+	const char *err, *type;
 
 	switch (cs->partition_root_state) {
 	case PRS_ENABLED:
@@ -2646,7 +2683,11 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 		break;
 	case PRS_ERROR:
 		type = is_sched_load_balance(cs) ? "root" : "isolated";
-		seq_printf(seq, "%s invalid\n", type);
+		err = perr_strings[READ_ONCE(cs->prs_err)];
+		if (err)
+			seq_printf(seq, "%s invalid (%s)\n", type, err);
+		else
+			seq_printf(seq, "%s invalid\n", type);
 		break;
 	}
 	return 0;
@@ -3236,7 +3277,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 	if (is_partition_root(cs) &&
 	   ((cpumask_empty(&new_cpus) && partition_is_populated(cs, NULL)) ||
 	    !parent->nr_subparts_cpus)) {
-		int old_prs;
+		int old_prs, parent_prs;
 
 		update_parent_subparts_cpumask(cs, partcmd_disable,
 					       NULL, tmp);
@@ -3249,10 +3290,17 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		}
 
 		old_prs = cs->partition_root_state;
+		parent_prs = parent->partition_root_state;
 		if (old_prs != PRS_ERROR) {
 			spin_lock_irq(&callback_lock);
 			cs->partition_root_state = PRS_ERROR;
 			spin_unlock_irq(&callback_lock);
+			if (parent_prs == PRS_ERROR)
+				WRITE_ONCE(cs->prs_err, PERR_INVPARENT);
+			else if (!parent_prs)
+				WRITE_ONCE(cs->prs_err, PERR_NOTPART);
+			else
+				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
 			notify_partition_change(cs, old_prs, PRS_ERROR);
 		}
 		cpuset_force_rebuild();
-- 
2.27.0

