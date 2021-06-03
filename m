Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6839ACCA
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhFCV0u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhFCV0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622755501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=WUGY8sYtZzxYZSnhBIxuLuhJwQQu5J4ornFBXmTKadM=;
        b=Af/VFunv8bLg8P3LHrJXykFOPRhvACz2cpXYpnCb8Bbdb6UjXXYXR/EmhCnu13K9+vnX10
        AH683zInpi9ED/TNvgFB2inovknZvTrSNi9xMRQw0EbGqgZvYdImrLxfGQ/4z7WBltsnNW
        HE6yFS30M5QFKPcuqZHGbOrjGTDmHyI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-xF1QuBkwN4mkdbG0TiNQ1g-1; Thu, 03 Jun 2021 17:24:59 -0400
X-MC-Unique: xF1QuBkwN4mkdbG0TiNQ1g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44E498030A1;
        Thu,  3 Jun 2021 21:24:57 +0000 (UTC)
Received: from llong.com (ovpn-116-222.rdu2.redhat.com [10.10.116.222])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E26DF614FD;
        Thu,  3 Jun 2021 21:24:55 +0000 (UTC)
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
        Waiman Long <longman@redhat.com>
Subject: [PATCH 3/5] cgroup/cpuset: Allow non-top parent partition root to distribute out all CPUs
Date:   Thu,  3 Jun 2021 17:24:14 -0400
Message-Id: <20210603212416.25934-4-longman@redhat.com>
In-Reply-To: <20210603212416.25934-1-longman@redhat.com>
References: <20210603212416.25934-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, a parent partition root cannot distribute all its CPUs to
child partition roots with no CPUs left. However in some use cases,
a management application may want to create a parent partition root as
a management unit with no task associated with it and has all its CPUs
distributed to various child partition roots dynamically according to
their needs. Leaving a cpu in the parent partition root in such a case is
now a waste.

To accommodate such use cases, a parent partition root can now have
all its CPUs distributed to its child partition roots as long as:
 1) it is not the top cpuset; and
 2) there is no task directly associated with the parent.

Once an empty parent partition root is formed, no new task can be moved
into it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 44 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 78dd6c91dcd6..ef19eb317fef 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1117,7 +1117,7 @@ enum subparts_cmd {
  * cpus_allowed can be granted or an error code will be returned.
  *
  * For partcmd_disable, the cpuset is being transofrmed from a partition
- * root back to a non-partition root. any CPUs in cpus_allowed that are in
+ * root back to a non-partition root. Any CPUs in cpus_allowed that are in
  * parent's subparts_cpus will be taken away from that cpumask and put back
  * into parent's effective_cpus. 0 should always be returned.
  *
@@ -1172,21 +1172,31 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 	if ((cmd != partcmd_update) && css_has_online_children(&cpuset->css))
 		return -EBUSY;
 
-	/*
-	 * Enabling partition root is not allowed if not all the CPUs
-	 * can be granted from parent's effective_cpus or at least one
-	 * CPU will be left after that.
-	 */
-	if ((cmd == partcmd_enable) &&
-	   (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus) ||
-	     cpumask_equal(cpuset->cpus_allowed, parent->effective_cpus)))
-		return -EINVAL;
-
 	/*
 	 * A cpumask update cannot make parent's effective_cpus become empty.
 	 */
 	adding = deleting = false;
 	if (cmd == partcmd_enable) {
+		bool parent_is_top_cpuset = !parent_cs(parent);
+		bool no_cpu_in_parent = cpumask_equal(cpuset->cpus_allowed,
+						      parent->effective_cpus);
+		/*
+		 * Enabling partition root is not allowed if not all the CPUs
+		 * can be granted from parent's effective_cpus. If the parent
+		 * is the top cpuset, at least one CPU must be left after that.
+		 */
+		if (!cpumask_subset(cpuset->cpus_allowed, parent->effective_cpus) ||
+		    (parent_is_top_cpuset && no_cpu_in_parent))
+			return -EINVAL;
+
+		/*
+		 * A non-top parent can be left with no CPU as long as there
+		 * is no task directly associated with the parent. For such
+		 * a parent, no new task can be moved into it.
+		 */
+		if (no_cpu_in_parent && parent->css.cgroup->nr_populated_csets)
+			return -EINVAL;
+
 		cpumask_copy(tmp->addmask, cpuset->cpus_allowed);
 		adding = true;
 	} else if (cmd == partcmd_disable) {
@@ -1208,9 +1218,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		adding = cpumask_andnot(tmp->addmask, tmp->addmask,
 					parent->subparts_cpus);
 		/*
-		 * Return error if the new effective_cpus could become empty.
+		 * Return error if the new effective_cpus could become empty
+		 * and there are tasks in the parent.
 		 */
-		if (adding &&
+		if (adding && parent->css.cgroup->nr_populated_csets &&
 		    cpumask_equal(parent->effective_cpus, tmp->addmask)) {
 			if (!deleting)
 				return -EINVAL;
@@ -2181,6 +2192,13 @@ static int cpuset_can_attach(struct cgroup_taskset *tset)
 	    (cpumask_empty(cs->cpus_allowed) || nodes_empty(cs->mems_allowed)))
 		goto out_unlock;
 
+	/*
+	 * On default hierarchy, task cannot be moved to a cpuset with empty
+	 * effective cpus.
+	 */
+	if (is_in_v2_mode() && cpumask_empty(cs->effective_cpus))
+		goto out_unlock;
+
 	cgroup_taskset_for_each(task, css, tset) {
 		ret = task_can_attach(task, cs->cpus_allowed);
 		if (ret)
-- 
2.18.1

