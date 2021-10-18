Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9E4431FFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Oct 2021 16:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhJROlG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Oct 2021 10:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59040 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231736AbhJROlF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Oct 2021 10:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634567933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=474JE8KDGexTjFdGx4bBirOGDjMm7XbgTSGx/41x5Xw=;
        b=fd5jgqASSKOm0svok9zioXn6SogEWcqI1gqi3rYwSpCiidsECsuifD/YHGM7+ZPuK39fhM
        TOEsN5EfzKZCMW9ABp5HXG/cRWaxPab20fcvHNTo/+gLFde+kx1dacUkkmMjP9IC+JmjRz
        ktCzEBZtvnRJAeP3dVIYM8se9Nfd2Z4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-DOmqaj5tPsaZCl6u_vQnag-1; Mon, 18 Oct 2021 10:38:50 -0400
X-MC-Unique: DOmqaj5tPsaZCl6u_vQnag-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9186A80668C;
        Mon, 18 Oct 2021 14:38:48 +0000 (UTC)
Received: from llong.com (unknown [10.22.16.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CD126A8E5;
        Mon, 18 Oct 2021 14:37:48 +0000 (UTC)
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
Subject: [PATCH v8 4/6] cgroup/cpuset: Show invalid partition reason string
Date:   Mon, 18 Oct 2021 10:36:17 -0400
Message-Id: <20211018143619.205065-5-longman@redhat.com>
In-Reply-To: <20211018143619.205065-1-longman@redhat.com>
References: <20211018143619.205065-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
 kernel/cgroup/cpuset.c | 48 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index fab31921728c..9c5ecc8d100c 100644
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
+	[PERR_PARENT]  = "Parent is no longer a valid partition root",
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
@@ -275,8 +296,13 @@ static inline int is_partition_root(const struct cpuset *cs)
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
@@ -1282,6 +1308,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		part_error = partition_is_populated(parent, cpuset) &&
 			cpumask_subset(parent->effective_cpus, tmp->addmask) &&
 			!cpumask_intersects(tmp->delmask, cpu_active_mask);
+
+		if ((READ_ONCE(cpuset->prs_err) == PERR_NONE) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_INVCPUS);
 	} else {
 		/*
 		 * partcmd_update w/o newmask:
@@ -1305,6 +1334,9 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 			      !parent->nr_subparts_cpus) ||
 			     (cpumask_equal(parent->effective_cpus, tmp->addmask) &&
 			      partition_is_populated(parent, cpuset));
+
+		if (is_partition_root(cpuset) && part_error)
+			WRITE_ONCE(cpuset->prs_err, PERR_NOCPUS);
 	}
 
 	if (cmd == partcmd_update) {
@@ -1478,6 +1510,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
 				 * When parent is invalid, it has to be too.
 				 */
 				new_prs = PRS_ERROR;
+				WRITE_ONCE(cp->prs_err, PERR_PARENT);
 				break;
 			}
 		}
@@ -2637,6 +2670,7 @@ static s64 cpuset_read_s64(struct cgroup_subsys_state *css, struct cftype *cft)
 static int sched_partition_show(struct seq_file *seq, void *v)
 {
 	struct cpuset *cs = css_cs(seq_css(seq));
+	const char *err;
 
 	switch (cs->partition_root_state) {
 	case PRS_ENABLED:
@@ -2649,7 +2683,11 @@ static int sched_partition_show(struct seq_file *seq, void *v)
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
@@ -3256,6 +3294,10 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
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
2.27.0

