Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2D4521EFC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345987AbiEJPji (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346038AbiEJPjQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 11:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37BAF227062
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 08:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652196876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zmp3GU6lr5BXYKTwCgRRnMUeaC9QIFA4NnCFReGa84k=;
        b=HawWtVUs12UsD/CNIGtzTx4s3LCN06bJnswF/zFoGbztlZ8JTODQf5Q8Q5rk60e6IW+q+E
        d5S29BV7xW3uoMMP+KMV4WDUvTfheyqhxfaGcnDcFT1g2iglU3EqaAiMbVxGewTYe1g9gD
        qQny7qnhxKvONE8yNTXc78q/YiwIPAs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-pCQZwa8iM1qov1KCvyOByg-1; Tue, 10 May 2022 11:34:33 -0400
X-MC-Unique: pCQZwa8iM1qov1KCvyOByg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE44F3C977E6;
        Tue, 10 May 2022 15:34:32 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D30C403171;
        Tue, 10 May 2022 15:34:32 +0000 (UTC)
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
Subject: [PATCH v11 0/8] cgroup/cpuset: cpu partition code enhancements
Date:   Tue, 10 May 2022 11:34:05 -0400
Message-Id: <20220510153413.400020-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v11:
 - Fix incorrect spacing in patch 7 and include documentation suggestions
   by Michal.
 - Move partition_is_populated() check to the last one in list of
   conditions to be checked.

v10:
 - Relax constraints for changes made to "cpuset.cpus"
   and "cpuset.cpus.partition" as suggested. Now almost all changes
   are allowed.
 - Add patch 1 to signal that we may need to do additional work in
   the future to relax the constraint that tasks' cpumask may need
   some adjustment if child partitions are present.
 - Add patch 2 for miscellaneous cleanups.

This patchset include the following enhancements to the cpuset v2
partition code.
 1) Allow partitions that have no task to have empty effective cpus.
 2) Relax the constraints on what changes are allowed in cpuset.cpus
    and cpuset.cpus.partition. However, the partition remain invalid
    until the constraints of a valid partition root is satisfied.
 3) Add a new "isolated" partition type for partitions with no load
    balancing which is available in v1 but not yet in v2.
 4) Allow the reading of cpuset.cpus.partition to include a reason
    string as to why the partition remain invalid.

In addition, the cgroup-v2.rst documentation file is updated and a self
test is added to verify the correctness the partition code.

The code diff from v10 is listed below.

Waiman Long (8):
  cgroup/cpuset: Add top_cpuset check in update_tasks_cpumask()
  cgroup/cpuset: Miscellaneous cleanups & add helper functions
  cgroup/cpuset: Allow no-task partition to have empty
    cpuset.cpus.effective
  cgroup/cpuset: Relax constraints to partition & cpus changes
  cgroup/cpuset: Add a new isolated cpus.partition type
  cgroup/cpuset: Show invalid partition reason string
  cgroup/cpuset: Update description of cpuset.cpus.partition in
    cgroup-v2.rst
  kselftest/cgroup: Add cpuset v2 partition root state test

 Documentation/admin-guide/cgroup-v2.rst       | 149 ++--
 kernel/cgroup/cpuset.c                        | 718 +++++++++++-------
 tools/testing/selftests/cgroup/Makefile       |   5 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 674 ++++++++++++++++
 tools/testing/selftests/cgroup/wait_inotify.c |  87 +++
 5 files changed, 1304 insertions(+), 329 deletions(-)
 create mode 100755 tools/testing/selftests/cgroup/test_cpuset_prs.sh
 create mode 100644 tools/testing/selftests/cgroup/wait_inotify.c

-- 
diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 94e1e3771830..9184a09e0fc9 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2130,10 +2130,10 @@ Cpuset Interface Files
 	CPUs should be carefully distributed and bound to each of the
 	individual CPUs for optimal performance.

-	The value shown in "cpuset.cpus.effective" of a partition root is
-	the CPUs that the parent partition root can dedicate to the new
-	partition root.  They are subtracted from "cpuset.cpus.effective"
-	of the parent and may be different from "cpuset.cpus"
+	The value shown in "cpuset.cpus.effective" of a partition root
+	is the CPUs that the partition root can dedicate to a potential
+	new child partition root. The new child subtracts available
+	CPUs from its parent "cpuset.cpus.effective".

 	A partition root ("root" or "isolated") can be in one of the
 	two possible states - valid or invalid.  An invalid partition
@@ -2165,24 +2165,28 @@ Cpuset Interface Files
 	2) The parent cgroup is a valid partition root.
 	3) The "cpuset.cpus" is not empty and must contain at least
 	   one of the CPUs from parent's "cpuset.cpus", i.e. they overlap.
-        4) The "cpuset.cpus.effective" must be a subset of "cpuset.cpus"
-           and cannot be empty unless there is no task associated with
-           this partition.
+	4) The "cpuset.cpus.effective" must be a subset of "cpuset.cpus"
+	   and cannot be empty unless there is no task associated with
+	   this partition.

 	External events like hotplug or changes to "cpuset.cpus" can
 	cause a valid partition root to become invalid and vice versa.
 	Note that a task cannot be moved to a cgroup with empty
 	"cpuset.cpus.effective".

-        For a valid partition root or an invalid partition root with
-        the exclusivity rule enabled, changes made to "cpuset.cpus"
-        that violate the exclusivity rule will not be allowed.
+	For a valid partition root or an invalid partition root with
+	the exclusivity rule enabled, changes made to "cpuset.cpus"
+	that violate the exclusivity rule will not be allowed.

 	A valid non-root parent partition may distribute out all its CPUs
 	to its child partitions when there is no task associated with it.

-        Care must be taken to change a valid partition root to "member"
-        as all its child partitions, if present, will become invalid.
+	Care must be taken to change a valid partition root to
+	"member" as all its child partitions, if present, will become
+	invalid causing disruption to tasks running in those child
+	partitions. These inactivated partitions could be recovered if
+	their parent is switched back to a partition root with a proper
+	set of "cpuset.cpus".

 	Poll and inotify events are triggered whenever the state of
 	"cpuset.cpus.partition" changes.  That includes changes caused
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 90ee0e4d8d7e..261974f5bb3c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1283,9 +1283,12 @@ static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs,
  * invalid to valid violates the exclusivity rule.
  *
  * The partcmd_enable and partcmd_disable commands are used by
- * update_prstate(). The partcmd_update command is used by
- * update_cpumasks_hier() with newmask NULL and update_cpumask() with
- * newmask set.
+ * update_prstate(). An error code may be returned and the caller will check
+ * for error.
+ *
+ * The partcmd_update command is used by update_cpumasks_hier() with newmask
+ * NULL and update_cpumask() with newmask set. The callers won't check for
+ * error and so partition_root_state and prs_error will be updated directly.
  */
 static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 					  struct cpumask *newmask,
@@ -1326,8 +1329,8 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
 		 */
-		if (partition_is_populated(parent, cs) &&
-		   !cpumask_intersects(cs->cpus_allowed, parent->effective_cpus))
+		if (!cpumask_intersects(cs->cpus_allowed, parent->effective_cpus) &&
+		    partition_is_populated(parent, cs))
 			return PERR_NOCPUS;

 		cpumask_copy(tmp->addmask, cs->cpus_allowed);
@@ -1361,9 +1364,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 * Make partition invalid if parent's effective_cpus could
 		 * become empty and there are tasks in the parent.
 		 */
-		if (adding && partition_is_populated(parent, cs) &&
+		if (adding &&
 		    cpumask_subset(parent->effective_cpus, tmp->addmask) &&
-		    !cpumask_intersects(tmp->delmask, cpu_active_mask)) {
+		    !cpumask_intersects(tmp->delmask, cpu_active_mask) &&
+		    partition_is_populated(parent, cs)) {
 			part_error = PERR_NOCPUS;
 			adding = false;
 			deleting = cpumask_and(tmp->delmask, cs->cpus_allowed,
@@ -1749,13 +1753,13 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,

 	/*
 	 * Make sure that subparts_cpus, if not empty, is a subset of
-	 * cpus_allowed. Clear subparts_cpus if there is an error or
+	 * cpus_allowed. Clear subparts_cpus if partition not valid or
 	 * empty effective cpus with tasks.
 	 */
 	if (cs->nr_subparts_cpus) {
-		if (cs->prs_err ||
-		   (partition_is_populated(cs, NULL) &&
-		    cpumask_subset(trialcs->effective_cpus, cs->subparts_cpus))) {
+		if (!is_partition_valid(cs) ||
+		   (cpumask_subset(trialcs->effective_cpus, cs->subparts_cpus) &&
+		    partition_is_populated(cs, NULL))) {
 			cs->nr_subparts_cpus = 0;
 			cpumask_clear(cs->subparts_cpus);
 		} else {

