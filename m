Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE6C3AF58A
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jun 2021 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbhFUSwG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Jun 2021 14:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35737 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231200AbhFUSwF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Jun 2021 14:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624301390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=a3Hgg1XgaMSsbVd330JUCd8UUvif2vzvATq1jEUWKfo=;
        b=fIq9l3GLxpxrw3rJlmt1Kf/Rx/AImgci5ORFqHv0DlhSuXQF2J1a5W3DRVv4G+DnMIbuhs
        P6M6yNan0l2M2REpOHSOF4qG6HIN+M36DFT9WYQktMxbaeg8h3SWvvL1qO85PGXdLeeW+H
        GaMGiv/kj2K6RKyyXNSTK3HcopURwDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-5ZeRV1qzMkiCAyu6EhE7Yw-1; Mon, 21 Jun 2021 14:49:49 -0400
X-MC-Unique: 5ZeRV1qzMkiCAyu6EhE7Yw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4134134912;
        Mon, 21 Jun 2021 18:49:47 +0000 (UTC)
Received: from llong.com (ovpn-114-127.rdu2.redhat.com [10.10.114.127])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A83D65DA2D;
        Mon, 21 Jun 2021 18:49:45 +0000 (UTC)
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
Subject: [PATCH v2 1/6] cgroup/cpuset: Miscellaneous code cleanup
Date:   Mon, 21 Jun 2021 14:49:19 -0400
Message-Id: <20210621184924.27493-2-longman@redhat.com>
In-Reply-To: <20210621184924.27493-1-longman@redhat.com>
References: <20210621184924.27493-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use more descriptive variable names for update_prstate(), remove
unnecessary code and fix some typos. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index adb5190c4429..d4164e07c61b 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1114,7 +1114,7 @@ enum subparts_cmd {
  * cpus_allowed can be granted or an error code will be returned.
  *
  * For partcmd_disable, the cpuset is being transofrmed from a partition
- * root back to a non-partition root. any CPUs in cpus_allowed that are in
+ * root back to a non-partition root. Any CPUs in cpus_allowed that are in
  * parent's subparts_cpus will be taken away from that cpumask and put back
  * into parent's effective_cpus. 0 should always be returned.
  *
@@ -1225,7 +1225,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
 		/*
 		 * partcmd_update w/o newmask:
 		 *
-		 * addmask = cpus_allowed & parent->effectiveb_cpus
+		 * addmask = cpus_allowed & parent->effective_cpus
 		 *
 		 * Note that parent's subparts_cpus may have been
 		 * pre-shrunk in case there is a change in the cpu list.
@@ -1937,30 +1937,28 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
 
 /*
  * update_prstate - update partititon_root_state
- * cs:	the cpuset to update
- * val: 0 - disabled, 1 - enabled
+ * cs: the cpuset to update
+ * new_prs: new partition root state
  *
  * Call with cpuset_mutex held.
  */
-static int update_prstate(struct cpuset *cs, int val)
+static int update_prstate(struct cpuset *cs, int new_prs)
 {
 	int err;
 	struct cpuset *parent = parent_cs(cs);
-	struct tmpmasks tmp;
+	struct tmpmasks tmpmask;
 
-	if ((val != 0) && (val != 1))
-		return -EINVAL;
-	if (val == cs->partition_root_state)
+	if (new_prs == cs->partition_root_state)
 		return 0;
 
 	/*
 	 * Cannot force a partial or invalid partition root to a full
 	 * partition root.
 	 */
-	if (val && cs->partition_root_state)
+	if (new_prs && (cs->partition_root_state < 0))
 		return -EINVAL;
 
-	if (alloc_cpumasks(NULL, &tmp))
+	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
 
 	err = -EINVAL;
@@ -1978,7 +1976,7 @@ static int update_prstate(struct cpuset *cs, int val)
 			goto out;
 
 		err = update_parent_subparts_cpumask(cs, partcmd_enable,
-						     NULL, &tmp);
+						     NULL, &tmpmask);
 		if (err) {
 			update_flag(CS_CPU_EXCLUSIVE, cs, 0);
 			goto out;
@@ -1997,7 +1995,7 @@ static int update_prstate(struct cpuset *cs, int val)
 		}
 
 		err = update_parent_subparts_cpumask(cs, partcmd_disable,
-						     NULL, &tmp);
+						     NULL, &tmpmask);
 		if (err)
 			goto out;
 
@@ -2015,11 +2013,11 @@ static int update_prstate(struct cpuset *cs, int val)
 		update_tasks_cpumask(parent);
 
 	if (parent->child_ecpus_count)
-		update_sibling_cpumasks(parent, cs, &tmp);
+		update_sibling_cpumasks(parent, cs, &tmpmask);
 
 	rebuild_sched_domains_locked();
 out:
-	free_cpumasks(NULL, &tmp);
+	free_cpumasks(NULL, &tmpmask);
 	return err;
 }
 
@@ -3060,7 +3058,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 		goto retry;
 	}
 
-	parent =  parent_cs(cs);
+	parent = parent_cs(cs);
 	compute_effective_cpumask(&new_cpus, cs, parent);
 	nodes_and(new_mems, cs->mems_allowed, parent->effective_mems);
 
-- 
2.18.1

