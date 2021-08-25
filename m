Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BDB3F7DD0
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Aug 2021 23:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHYVlF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Aug 2021 17:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34020 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232816AbhHYVlE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Aug 2021 17:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629927617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=r5oKiyiuhTrPLojQ5m5cdMpX7cAe0uq7IPb0/BukX9s=;
        b=TpR6iDkxiLXq6f8rIgHiEhGyxvPUIibHkdDTOA2O3TkD7w9qfUU/Tk2NQ6jKPBlY51FZXF
        wmDRBPF1aO1yRdoMh5HLujv1GnsSn8eNLWxh1wi7aEYrzURh4MaRfrJxKdCXl3s+cO2yrV
        8P7wGUYhIF+9ZZsxv+gmWC1y4upM02Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-T8eKzJBzP0OISW3tCs6ztw-1; Wed, 25 Aug 2021 17:40:16 -0400
X-MC-Unique: T8eKzJBzP0OISW3tCs6ztw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91FC91934104;
        Wed, 25 Aug 2021 21:40:14 +0000 (UTC)
Received: from llong.com (unknown [10.22.18.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B78EA1B472;
        Wed, 25 Aug 2021 21:40:07 +0000 (UTC)
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
Subject: [PATCH v7 2/6] cgroup/cpuset: Show invalid partition reason string
Date:   Wed, 25 Aug 2021 17:37:46 -0400
Message-Id: <20210825213750.6933-3-longman@redhat.com>
In-Reply-To: <20210825213750.6933-1-longman@redhat.com>
References: <20210825213750.6933-1-longman@redhat.com>
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
 kernel/cgroup/cpuset.c | 46 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index ddea05e4d1f0..eb2e81f9326b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -78,6 +78,24 @@ struct fmeter {
 	spinlock_t lock;	/* guards read or write of above */
 };
 
+/*
+ * Invalid partition error code
+ */
+enum prs_errcode {
+	PERR_NONE = 0,
+	PERR_INVCPUS,
+	PERR_NOCPUS,
+	PERR_PARENT,
+	PERR_HOTPLUG,
+};
+
+static const char * const perr_strings[] = {
+	[PERR_INVCPUS] = "Invalid change to cpuset.cpus",
+	[PERR_PARENT]  = "Parent is no longer a partition root",
+	[PERR_NOCPUS]  = "Parent unable to distribute cpu downstream",
+	[PERR_HOTPLUG] = "No cpu available due to hotplug",
+};
+
 struct cpuset {
 	struct cgroup_subsys_state css;
 
@@ -163,6 +181,9 @@ struct cpuset {
 
 	/* Handle for cpuset.cpus.partition */
 	struct cgroup_file partition_file;
+
+	/* Invalid partition error code, not lock protected */
+	enum prs_errcode prs_err;
 };
 
 /*
@@ -272,8 +293,13 @@ static inline int is_partition_root(const struct cpuset *cs)
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
@@ -1243,6 +1269,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 					      cpu_active_mask))
 				part_error = true;
 			cpumask_copy(tmp->addmask, parent->effective_cpus);
+			if ((READ_ONCE(cpuset->prs_err) == PERR_NONE) && part_error)
+				WRITE_ONCE(cpuset->prs_err, PERR_INVCPUS);
 		}
 	} else {
 		/*
@@ -1264,6 +1292,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		part_error = (is_partition_root(cpuset) &&
 			      !parent->nr_subparts_cpus) ||
 			     cpumask_equal(tmp->addmask, parent->effective_cpus);
+		if (is_partition_root(cpuset) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_NOCPUS);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1427,6 +1457,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp)
 				 * When parent is invalid, it has to be too.
 				 */
 				new_prs = PRS_ERROR;
+				WRITE_ONCE(cp->prs_err, PERR_PARENT);
 				break;
 			}
 		}
@@ -2546,6 +2577,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
+	const char *err;
 
 	switch (cs->partition_root_state) {
 	case PRS_ENABLED:
@@ -2555,7 +2587,11 @@ static int sched_partition_show(struct seq_file *seq, void *v)
 		seq_puts(seq, "member\n");
 		break;
 	case PRS_ERROR:
-		seq_puts(seq, "root invalid\n");
+		err = perr_strings[READ_ONCE(cs->prs_err)];
+		if (err)
+			seq_printf(seq, "root invalid (%s)\n", err);
+		else
+			seq_puts(seq, "root invalid\n");
 		break;
 	}
 	return 0;
@@ -3155,6 +3191,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 			spin_lock_irq(&callback_lock);
 			cs->partition_root_state = PRS_ERROR;
 			spin_unlock_irq(&callback_lock);
+			if (parent->partition_root_state == PRS_ERROR)
+				WRITE_ONCE(cs->prs_err, PERR_PARENT);
+			else
+				WRITE_ONCE(cs->prs_err, PERR_HOTPLUG);
 			notify_partition_change(cs, old_prs, PRS_ERROR);
 		}
 		cpuset_force_rebuild();
-- 
2.18.1

