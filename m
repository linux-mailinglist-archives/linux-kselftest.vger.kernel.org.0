Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D34B6831CE
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Jan 2023 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjAaPtF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Jan 2023 10:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAaPtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Jan 2023 10:49:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73715B45C
        for <linux-kselftest@vger.kernel.org>; Tue, 31 Jan 2023 07:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675180093;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jj+MngsoDFpfREm8kwbslfBpvRZkqzFwR4JCZm4vAvo=;
        b=hkL0LkZXAz2N7+H/ElK4no7jB+9kmtrWdM5x8/jRTiUq/MXq3sZBXUm20lwCQeJb7666OV
        6GvMN6eDnw618Fraxr1+YGDbqAJFEzvC4CzO0P4vBgLpCpbZa7Os7V0J01ZrJzqLCYD9B9
        BVOMuVTA/mwKq8f6t0npyn2a/CCfsqA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-RZY8mZo5Mt-fchm6kb8SFQ-1; Tue, 31 Jan 2023 10:48:08 -0500
X-MC-Unique: RZY8mZo5Mt-fchm6kb8SFQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B063F18E52D8;
        Tue, 31 Jan 2023 15:48:07 +0000 (UTC)
Received: from llong.com (unknown [10.22.10.235])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52927492C3E;
        Tue, 31 Jan 2023 15:48:07 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Subject: [PATCH] cgroup/cpuset: Fix wrong check in update_parent_subparts_cpumask()
Date:   Tue, 31 Jan 2023 10:48:03 -0500
Message-Id: <20230131154803.192530-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It was found that the check to see if a partition could use up all
the cpus from the parent cpuset in update_parent_subparts_cpumask()
was incorrect. As a result, it is possible to leave parent with no
effective cpu left even if there are tasks in the parent cpuset. This
can lead to system panic as reported in [1].

Fix this probem by updating the check to fail the enabling the partition
if parent's effective_cpus is a subset of the child's cpus_allowed.

Also record the error code when an error happens in update_prstate()
and add a test case where parent partition and child have the same cpu
list and parent has task. Enabling partition in the child will fail in
this case.

[1] https://www.spinics.net/lists/cgroups/msg36254.html

Fixes: f0af1bfc27b5 ("cgroup/cpuset: Relax constraints to partition & cpus changes")
Reported-by: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                            | 3 ++-
 tools/testing/selftests/cgroup/test_cpuset_prs.sh | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a29c0b13706b..205dc9edcaa9 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1346,7 +1346,7 @@ static int update_parent_subparts_cpumask(struct cpuset *cs, int cmd,
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
 		 */
-		if (!cpumask_intersects(cs->cpus_allowed, parent->effective_cpus) &&
+		if (cpumask_subset(parent->effective_cpus, cs->cpus_allowed) &&
 		    partition_is_populated(parent, cs))
 			return PERR_NOCPUS;
 
@@ -2324,6 +2324,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 		new_prs = -new_prs;
 	spin_lock_irq(&callback_lock);
 	cs->partition_root_state = new_prs;
+	WRITE_ONCE(cs->prs_err, err);
 	spin_unlock_irq(&callback_lock);
 	/*
 	 * Update child cpusets, if present.
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 186e1c26867e..75c100de90ff 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -268,6 +268,7 @@ TEST_MATRIX=(
 	# Taking away all CPUs from parent or itself if there are tasks
 	# will make the partition invalid.
 	"  S+ C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
+	"  S+  C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
 	"  S+ $SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
 	"  S+ $SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
 
-- 
2.31.1

