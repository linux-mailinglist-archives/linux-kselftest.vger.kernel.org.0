Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB8F7B3DE3
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Sep 2023 05:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjI3Dpi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 23:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjI3Dpg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 23:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135ADB
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Sep 2023 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696045489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zn4xqFs4rGY0oTQr3T07H0KV6gmXQ+zDOaROsq+w2v4=;
        b=ddr1hOgyKT6Ukz7kcgIn+Fos25ONcFNuyuxDZFd1hhn0unDsc6heTpRc5TtFoqdQogBziZ
        VZPoFb0KwSmaiH50rWl1VODaMPgsArVNVxgXrt805Oj1TiYYm4SrL5SUTG8xxs3yVRBx4w
        YIcYVrBsmGHavcD23fRxvAycj1tr22M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-530-3LdkRfShNZ-VxcbofFnY7g-1; Fri, 29 Sep 2023 23:44:44 -0400
X-MC-Unique: 3LdkRfShNZ-VxcbofFnY7g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60B71101A529;
        Sat, 30 Sep 2023 03:44:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.177])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 950AB10F1BE7;
        Sat, 30 Sep 2023 03:44:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup] cgroup/cpuset: Enable invalid to valid local partition transition
Date:   Fri, 29 Sep 2023 23:44:02 -0400
Message-Id: <20230930034402.2776278-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a local partition becomes invalid, it won't transition back to
valid partition automatically if a proper "cpuset.cpus.exclusive" or
"cpuset.cpus" change is made. Instead, system administrators have to
explicitly echo "root" or "isolated" into the "cpuset.cpus.partition"
file at the partition root.

This patch now enables the automatic transition of an invalid local
partition back to valid when there is a proper "cpuset.cpus.exclusive"
or "cpuset.cpus" change.

Automatic transition of an invalid remote partition to a valid one,
however, is not covered by this patch. They still need an explicit
write to "cpuset.cpus.partition" to become valid again.

The test_cpuset_prs.sh test script is updated to add new test cases to
test this automatic state transition.

Reported-by: Pierre Gondois <pierre.gondois@arm.com>
Link: https://lore.kernel.org/lkml/9777f0d2-2fdf-41cb-bd01-19c52939ef42@arm.com
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                        | 79 +++++++++++--------
 .../selftests/cgroup/test_cpuset_prs.sh       | 17 ++--
 2 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 15f399153a2e..93facdab513c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1806,17 +1806,28 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		 *
 		 * Compute add/delete mask to/from effective_cpus
 		 *
-		 * addmask = effective_xcpus & ~newmask & parent->effective_xcpus
-		 * delmask = newmask & ~cs->effective_xcpus
-		 *		     & parent->effective_xcpus
+		 * For valid partition:
+		 *   addmask = exclusive_cpus & ~newmask
+		 *			      & parent->effective_xcpus
+		 *   delmask = newmask & ~exclusive_cpus
+		 *		       & parent->effective_xcpus
+		 *
+		 * For invalid partition:
+		 *   delmask = newmask & parent->effective_xcpus
 		 */
-		cpumask_andnot(tmp->addmask, xcpus, newmask);
-		adding = cpumask_and(tmp->addmask, tmp->addmask,
-				     parent->effective_xcpus);
+		if (is_prs_invalid(old_prs)) {
+			adding = false;
+			deleting = cpumask_and(tmp->delmask,
+					newmask, parent->effective_xcpus);
+		} else {
+			cpumask_andnot(tmp->addmask, xcpus, newmask);
+			adding = cpumask_and(tmp->addmask, tmp->addmask,
+					     parent->effective_xcpus);
 
-		cpumask_andnot(tmp->delmask, newmask, xcpus);
-		deleting = cpumask_and(tmp->delmask, tmp->delmask,
-				       parent->effective_xcpus);
+			cpumask_andnot(tmp->delmask, newmask, xcpus);
+			deleting = cpumask_and(tmp->delmask, tmp->delmask,
+					       parent->effective_xcpus);
+		}
 		/*
 		 * Make partition invalid if parent's effective_cpus could
 		 * become empty and there are tasks in the parent.
@@ -1910,9 +1921,11 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	/*
 	 * Transitioning between invalid to valid or vice versa may require
-	 * changing CS_CPU_EXCLUSIVE.
+	 * changing CS_CPU_EXCLUSIVE. In the case of partcmd_update,
+	 * validate_change() has already been successfully called and
+	 * CPU lists in cs haven't been updated yet. So defer it to later.
 	 */
-	if (old_prs != new_prs) {
+	if ((old_prs != new_prs) && (cmd != partcmd_update))  {
 		int err = update_partition_exclusive(cs, new_prs);
 
 		if (err)
@@ -1960,6 +1973,9 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 
 	spin_unlock_irq(&callback_lock);
 
+	if ((old_prs != new_prs) && (cmd == partcmd_update))
+		update_partition_exclusive(cs, new_prs);
+
 	if (adding || deleting) {
 		update_tasks_cpumask(parent, tmp->addmask);
 		update_sibling_cpumasks(parent, cs, tmp);
@@ -2356,8 +2372,9 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (alloc_cpumasks(NULL, &tmp))
 		return -ENOMEM;
 
-	if (is_partition_valid(cs)) {
-		if (cpumask_empty(trialcs->effective_xcpus)) {
+	if (old_prs) {
+		if (is_partition_valid(cs) &&
+		    cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
 		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
@@ -2391,13 +2408,16 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		 */
 		invalidate = true;
 		rcu_read_lock();
-		cpuset_for_each_child(cp, css, parent)
+		cpuset_for_each_child(cp, css, parent) {
+			struct cpumask *xcpus = fetch_xcpus(trialcs);
+
 			if (is_partition_valid(cp) &&
-			    cpumask_intersects(trialcs->effective_xcpus, cp->effective_xcpus)) {
+			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
 				rcu_read_unlock();
 				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, &tmp);
 				rcu_read_lock();
 			}
+		}
 		rcu_read_unlock();
 		retval = 0;
 	}
@@ -2405,18 +2425,24 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval < 0)
 		goto out_free;
 
-	if (is_partition_valid(cs)) {
+	if (is_partition_valid(cs) ||
+	   (is_partition_invalid(cs) && !invalidate)) {
+		struct cpumask *xcpus = trialcs->effective_xcpus;
+
+		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
+			xcpus = trialcs->cpus_allowed;
+
 		/*
 		 * Call remote_cpus_update() to handle valid remote partition
 		 */
 		if (is_remote_partition(cs))
-			remote_cpus_update(cs, trialcs->effective_xcpus, &tmp);
+			remote_cpus_update(cs, xcpus, &tmp);
 		else if (invalidate)
 			update_parent_effective_cpumask(cs, partcmd_invalidate,
 							NULL, &tmp);
 		else
 			update_parent_effective_cpumask(cs, partcmd_update,
-						trialcs->effective_xcpus, &tmp);
+							xcpus, &tmp);
 	} else if (!cpumask_empty(cs->exclusive_cpus)) {
 		/*
 		 * Use trialcs->effective_cpus as a temp cpumask
@@ -2493,7 +2519,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (retval)
 		return retval;
 
-	if (is_partition_valid(cs)) {
+	if (old_prs) {
 		if (cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
@@ -2927,19 +2953,10 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		return 0;
 
 	/*
-	 * For a previously invalid partition root with valid partition root
-	 * parent, treat it as if it is a "member". Otherwise, reject it as
-	 * remote partition cannot currently self-recover from an invalid
-	 * state.
+	 * Treat a previously invalid partition root as if it is a "member".
 	 */
-	if (new_prs && is_prs_invalid(old_prs)) {
-		if (is_partition_valid(parent)) {
-			old_prs = PRS_MEMBER;
-		} else {
-			cs->partition_root_state = -new_prs;
-			return 0;
-		}
-	}
+	if (new_prs && is_prs_invalid(old_prs))
+		old_prs = PRS_MEMBER;
 
 	if (alloc_cpumasks(NULL, &tmpmask))
 		return -ENOMEM;
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 0f4f4a57ae12..243c4c926964 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -318,16 +318,18 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3,A2:1-3,A3:2 A1:P0,A3:P-2"
 
 	# cpus.exclusive.effective clearing test
-	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .      0 A1:0-3,A2:1-3,A3:2,XA1:"
+	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3,A2:1-3,A3:2,XA1:"
 
-	# Invalid to valid remote partition indirect transition test via member
-	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .      0 A1:0-3,A2:1-3,XA2: A2:P-2"
+	# Invalid to valid remote partition transition test
+	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3,A2:1-3,XA2: A2:P-2"
 	" C0-3:S+ C1-3:X3:P2
-			    .      .    X2-3   P0:P2    .      .      0 A1:0-2,A2:3,XA2:3 A2:P2 3"
+			    .      .    X2-3    P2      .      .     0 A1:0-2,A2:3,XA2:3 A2:P2 3"
 
 	# Invalid to valid local partition direct transition tests
-	" C1-3:S+:P2 C2-3:X1:P2 .  .      .      .      .      .      0 A1:1-3,XA1:1-3,A2:2-3:XA2: A1:P2,A2:P-2 1-3"
-	" C1-3:S+:P2 C2-3:X1:P2 .  .      .    X3:P2    .      .      0 A1:1-2,XA1:1-3,A2:3:XA2:3 A1:P2,A2:P2 1-3"
+	" C1-3:S+:P2 C2-3:X1:P2 .  .      .      .      .      .     0 A1:1-3,XA1:1-3,A2:2-3:XA2: A1:P2,A2:P-2 1-3"
+	" C1-3:S+:P2 C2-3:X1:P2 .  .      .    X3:P2    .      .     0 A1:1-2,XA1:1-3,A2:3:XA2:3 A1:P2,A2:P2 1-3"
+	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4,B1:4-6 A1:P-2,B1:P0"
+	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3,B1:4-6 A1:P2,B1:P0 0-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
@@ -336,6 +338,9 @@ TEST_MATRIX=(
 				   .      .     X4      .      .     0 A1:1-3,A2:1-3,A3:2-3,XA2:,XA3: A1:P2,A2:P-2,A3:P-2 1-3"
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
 				   .      .     C4      .      .     0 A1:1-3,A2:1-3,A3:2-3,XA2:,XA3: A1:P2,A2:P-2,A3:P-2 1-3"
+	# Local partition CPU change tests
+	" C0-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:0-2,A2:3-5 A1:P2,A2:P1 0-2"
+	" C0-5:S+:P2 C4-5:S+:P1 .  .    C1-5     .      .      .     0 A1:1-3,A2:4-5 A1:P2,A2:P1 1-3"
 
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
-- 
2.39.3

