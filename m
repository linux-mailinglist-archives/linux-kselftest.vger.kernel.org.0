Return-Path: <linux-kselftest+bounces-48712-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B84BD108A8
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 05:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 849D73046997
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 04:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC02303C93;
	Mon, 12 Jan 2026 04:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BNNQOHTL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FA30BF58
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 04:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768191010; cv=none; b=IinFfaL5EsyVVzs35rCtrt7z0ROHjUUth0CmXylCtaII85NcR/G/UelvHRMO5f16n3qtZDQ3yJ6UL2bd8H23J3HYSus8zmJD8t2b7NfNAl0AMJ1Fyv+3KVo8opcgUOiBlPkX0n/tVtpSfhuBqFJP8aWxtwsbhdwyyoH/dkqx2cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768191010; c=relaxed/simple;
	bh=ZkAVkHML8eDQGH5JEQzNWgXaq+XcoQKd1lrbZhLVRuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXT6PLI3EMkMahIccIUOQ6wq8+2Ptjv7sxRdO4DmkiIUCVq7g+62pLJ/1vdOzSip8OmOEGmKVkiQVKFs5GE0jO4qcj/hvGEZyAXY8QfQeyWJtjK/z2b4sNmbqSOTp+ZDrDWESeRT1G5fA2KdW0IlrRTSmugwdZKaF5YEdqIpDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BNNQOHTL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768191007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HdasYJPCoxVdOiqbOW3eT8JBsi/YaL/aD+daljmfraQ=;
	b=BNNQOHTL38JWdJe2ywq02r5uwvzMN9w3YRU6Va/KCHESL7EpDwZ0YNYwJfbZHmYVzcpmko
	eIw1JPPFHVsTkdWyzz61kYBwDIfmO8pqkr7oP9jYekBRbm8Z6oTu44YUwWvrZvEw9u429V
	1XbPzXNaIvSQQUAQjQ7k+gPHQKPRhj0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-UkaO5SMbNVG-SWIC3P3s1g-1; Sun,
 11 Jan 2026 23:09:53 -0500
X-MC-Unique: UkaO5SMbNVG-SWIC3P3s1g-1
X-Mimecast-MFC-AGG-ID: UkaO5SMbNVG-SWIC3P3s1g_1768190992
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5B8F1954B06;
	Mon, 12 Jan 2026 04:09:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.71])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D0465180009E;
	Mon, 12 Jan 2026 04:09:49 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>,
	Chen Ridong <chenridong@huawei.com>
Subject: [PATCH cgroup/for-6.20 v4 5/5] cgroup/cpuset: Move the v1 empty cpus/mems check to cpuset1_validate_change()
Date: Sun, 11 Jan 2026 23:08:56 -0500
Message-ID: <20260112040856.460904-6-longman@redhat.com>
In-Reply-To: <20260112040856.460904-1-longman@redhat.com>
References: <20260112040856.460904-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

As stated in commit 1c09b195d37f ("cpuset: fix a regression in validating
config change"), it is not allowed to clear masks of a cpuset if
there're tasks in it. This is specific to v1 since empty "cpuset.cpus"
or "cpuset.mems" will cause the v2 cpuset to inherit the effective CPUs
or memory nodes from its parent. So it is OK to have empty cpus or mems
even if there are tasks in the cpuset.

Move this empty cpus/mems check in validate_change() to
cpuset1_validate_change() to allow more flexibility in setting
cpus or mems in v2. cpuset_is_populated() needs to be moved into
cpuset-internal.h as it is needed by the empty cpus/mems checking code.

Also add a test case to test_cpuset_prs.sh to verify that.

Reported-by: Chen Ridong <chenridong@huaweicloud.com>
Closes: https://lore.kernel.org/lkml/7a3ec392-2e86-4693-aa9f-1e668a668b9c@huaweicloud.com/
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
---
 kernel/cgroup/cpuset-internal.h               |  9 ++++++++
 kernel/cgroup/cpuset-v1.c                     | 14 +++++++++++
 kernel/cgroup/cpuset.c                        | 23 -------------------
 .../selftests/cgroup/test_cpuset_prs.sh       |  3 +++
 4 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
index e8e2683cb067..fd7d19842ded 100644
--- a/kernel/cgroup/cpuset-internal.h
+++ b/kernel/cgroup/cpuset-internal.h
@@ -260,6 +260,15 @@ static inline int nr_cpusets(void)
 	return static_key_count(&cpusets_enabled_key.key) + 1;
 }
 
+static inline bool cpuset_is_populated(struct cpuset *cs)
+{
+	lockdep_assert_cpuset_lock_held();
+
+	/* Cpusets in the process of attaching should be considered as populated */
+	return cgroup_is_populated(cs->css.cgroup) ||
+		cs->attach_in_progress;
+}
+
 /**
  * cpuset_for_each_child - traverse online children of a cpuset
  * @child_cs: loop cursor pointing to the current child
diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
index 04124c38a774..7a23b9e8778f 100644
--- a/kernel/cgroup/cpuset-v1.c
+++ b/kernel/cgroup/cpuset-v1.c
@@ -368,6 +368,20 @@ int cpuset1_validate_change(struct cpuset *cur, struct cpuset *trial)
 	if (par && !is_cpuset_subset(trial, par))
 		goto out;
 
+	/*
+	 * Cpusets with tasks - existing or newly being attached - can't
+	 * be changed to have empty cpus_allowed or mems_allowed.
+	 */
+	ret = -ENOSPC;
+	if (cpuset_is_populated(cur)) {
+		if (!cpumask_empty(cur->cpus_allowed) &&
+		    cpumask_empty(trial->cpus_allowed))
+			goto out;
+		if (!nodes_empty(cur->mems_allowed) &&
+		    nodes_empty(trial->mems_allowed))
+			goto out;
+	}
+
 	ret = 0;
 out:
 	return ret;
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 83fb83a86b4b..a3dbca125588 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -370,15 +370,6 @@ static inline bool is_in_v2_mode(void)
 	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
 }
 
-static inline bool cpuset_is_populated(struct cpuset *cs)
-{
-	lockdep_assert_held(&cpuset_mutex);
-
-	/* Cpusets in the process of attaching should be considered as populated */
-	return cgroup_is_populated(cs->css.cgroup) ||
-		cs->attach_in_progress;
-}
-
 /**
  * partition_is_populated - check if partition has tasks
  * @cs: partition root to be checked
@@ -695,20 +686,6 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 
 	par = parent_cs(cur);
 
-	/*
-	 * Cpusets with tasks - existing or newly being attached - can't
-	 * be changed to have empty cpus_allowed or mems_allowed.
-	 */
-	ret = -ENOSPC;
-	if (cpuset_is_populated(cur)) {
-		if (!cpumask_empty(cur->cpus_allowed) &&
-		    cpumask_empty(trial->cpus_allowed))
-			goto out;
-		if (!nodes_empty(cur->mems_allowed) &&
-		    nodes_empty(trial->mems_allowed))
-			goto out;
-	}
-
 	/*
 	 * We can't shrink if we won't have enough room for SCHED_DEADLINE
 	 * tasks. This check is not done when scheduling is disabled as the
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index ff4540b0490e..5dff3ad53867 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -425,6 +425,9 @@ TEST_MATRIX=(
 	# cpuset.cpus can be set to a subset of sibling's cpuset.cpus.exclusive
 	" C1-3:X1-3  .      .    C4-5      .     .      .     C1-2   0 A1:1-3|B1:1-2"
 
+	# cpuset.cpus can become empty with task in it as it inherits parent's effective CPUs
+	" C1-3:S+   C2      .      .       .    T:C     .      .     0 A1:1-3|A2:1-3"
+
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
-- 
2.52.0


