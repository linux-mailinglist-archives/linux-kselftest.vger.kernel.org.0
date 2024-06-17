Return-Path: <linux-kselftest+bounces-12068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929C290B3EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948011C228E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A671615D5C5;
	Mon, 17 Jun 2024 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy4DBLuf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABC15D5C4
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635285; cv=none; b=U2QB8CezE5CVu6OEupW5oefPwAML1DCJGX8PUulB/OR0mTxC0ZgTjjRCo8rBZp37tTB3QQsHtICmyQq2hwDS5E/e1kqnqElV7nsGNvuyjGzrWhUl+UPq0XFsiSGS9Z/s2Eo3X58OMJZK8aYwf0GBkY9iuWTb0vcmfK/ZM1C+YDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635285; c=relaxed/simple;
	bh=vNly73rSHdWZmEWgFpf2pMfyR4D0mdIgOgrvXPbqoDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tkZwbPdClLVY8fUPD6J3f0y/wFCxqlTE21DYEaPIGgVVZqZ7Mny3iOgFE+TtljB7dOtByZyGkfopL+z4l8+aBKwotpdA/RAzGpO1cs8+s3kG1TaavqbVpblLgr7YVvgvH1rAHCdjO4/RJVxurtrFGwf5DaY+VsCw3g7c66QU7GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy4DBLuf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718635282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgBytX8vPqY+MQ9SxR1KMRWOcnxTsKUOs+RTlxPpNYc=;
	b=gy4DBLufmWAGfL1HxbyPX3iECcnCDVYk5KOhAvNbptocPnhNe5xFltItFbrmqO8Gy9Oevh
	QSlvG7KJhK/nlFSue8EBu8f7X79X7plXSemrDpOW3Un1OZEbXip+iyewwX4j7nng6y1nSS
	tithTLvnWf5aJyHNM09hERanYPmfFBs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-ZDnb-_l-O9O4gdp7lcSOyg-1; Mon,
 17 Jun 2024 10:41:20 -0400
X-MC-Unique: ZDnb-_l-O9O4gdp7lcSOyg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 305E619560B2;
	Mon, 17 Jun 2024 14:41:19 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8AE6E1956057;
	Mon, 17 Jun 2024 14:41:16 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Xavier <ghostxavier@sina.com>,
	Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v2 4/5] cgroup/cpuset: Make cpuset.cpus.exclusive independent of cpuset.cpus
Date: Mon, 17 Jun 2024 10:39:44 -0400
Message-Id: <20240617143945.454888-5-longman@redhat.com>
In-Reply-To: <20240617143945.454888-1-longman@redhat.com>
References: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The "cpuset.cpus.exclusive.effective" value is currently limited to a
subset of its "cpuset.cpus". This makes the exclusive CPUs distribution
hierarchy subsumed within the larger "cpuset.cpus" hierarchy. We have to
decide on what CPUs are used locally and what CPUs can be passed down as
exclusive CPUs down the hierarchy and combine them into "cpuset.cpus".

The advantage of the current scheme is to have only one hierarchy to
worry about. However, it make it harder to use as all the "cpuset.cpus"
values have to be properly set along the way down to the designated remote
partition root. It also makes it more cumbersome to find out what CPUs
can be used locally.

Make creation of remote partition simpler by breaking the
dependency of "cpuset.cpus.exclusive" on "cpuset.cpus" and make
them independent entities. Now we have two separate hierarchies -
one for setting "cpuset.cpus.effective" and the other one for setting
"cpuset.cpus.exclusive.effective". We may not need to set "cpuset.cpus"
when we activate a partition root anymore.

Also update Documentation/admin-guide/cgroup-v2.rst and cpuset.c comment
to document this change.

Suggested-by: Petr Malat <oss@malat.biz>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 +-
 kernel/cgroup/cpuset.c                  | 67 +++++++++++++++++--------
 2 files changed, 49 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 722e4762c4e0..2e4e74bea6ef 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2380,8 +2380,8 @@ Cpuset Interface Files
 	cpuset-enabled cgroups.
 
 	This file shows the effective set of exclusive CPUs that
-	can be used to create a partition root.  The content of this
-	file will always be a subset of "cpuset.cpus" and its parent's
+	can be used to create a partition root.  The content
+	of this file will always be a subset of its parent's
 	"cpuset.cpus.exclusive.effective" if its parent is not the root
 	cgroup.  It will also be a subset of "cpuset.cpus.exclusive"
 	if it is set.  If "cpuset.cpus.exclusive" is not set, it is
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 144bfc319809..fe76045aa528 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -87,7 +87,7 @@ static const char * const perr_strings[] = {
 	[PERR_NOTEXCL]   = "Cpu list in cpuset.cpus not exclusive",
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
-	[PERR_CPUSEMPTY] = "cpuset.cpus is empty",
+	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
 	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 };
 
@@ -127,19 +127,28 @@ struct cpuset {
 	/*
 	 * Exclusive CPUs dedicated to current cgroup (default hierarchy only)
 	 *
-	 * This exclusive CPUs must be a subset of cpus_allowed. A parent
-	 * cgroup can only grant exclusive CPUs to one of its children.
+	 * The effective_cpus of a valid partition root comes solely from its
+	 * effective_xcpus and some of the effective_xcpus may be distributed
+	 * to sub-partitions below & hence excluded from its effective_cpus.
+	 * For a valid partition root, its effective_cpus have no relationship
+	 * with cpus_allowed unless its exclusive_cpus isn't set.
 	 *
-	 * When the cgroup becomes a valid partition root, effective_xcpus
-	 * defaults to cpus_allowed if not set. The effective_cpus of a valid
-	 * partition root comes solely from its effective_xcpus and some of the
-	 * effective_xcpus may be distributed to sub-partitions below & hence
-	 * excluded from its effective_cpus.
+	 * This value will only be set if either exclusive_cpus is set or
+	 * when this cpuset becomes a local partition root.
 	 */
 	cpumask_var_t effective_xcpus;
 
 	/*
 	 * Exclusive CPUs as requested by the user (default hierarchy only)
+	 *
+	 * Its value is independent of cpus_allowed and designates the set of
+	 * CPUs that can be granted to the current cpuset or its children when
+	 * it becomes a valid partition root. The effective set of exclusive
+	 * CPUs granted (effective_xcpus) depends on whether those exclusive
+	 * CPUs are passed down by its ancestors and not yet taken up by
+	 * another sibling partition root along the way.
+	 *
+	 * If its value isn't set, it defaults to cpus_allowed.
 	 */
 	cpumask_var_t exclusive_cpus;
 
@@ -230,6 +239,17 @@ static struct list_head remote_children;
  *   2 - partition root without load balancing (isolated)
  *  -1 - invalid partition root
  *  -2 - invalid isolated partition root
+ *
+ *  There are 2 types of partitions - local or remote. Local partitions are
+ *  those whose parents are partition root themselves. Setting of
+ *  cpuset.cpus.exclusive are optional in setting up local partitions.
+ *  Remote partitions are those whose parents are not partition roots. Passing
+ *  down exclusive CPUs by setting cpuset.cpus.exclusive along its ancestor
+ *  nodes are mandatory in creating a remote partition.
+ *
+ *  For simplicity, a local partition can be created under a local or remote
+ *  partition but a remote partition cannot have any partition root in its
+ *  ancestor chain except the cgroup root.
  */
 #define PRS_MEMBER		0
 #define PRS_ROOT		1
@@ -709,6 +729,19 @@ static inline void free_cpuset(struct cpuset *cs)
 	kfree(cs);
 }
 
+/* Return user specified exclusive CPUs */
+static inline struct cpumask *user_xcpus(struct cpuset *cs)
+{
+	return cpumask_empty(cs->exclusive_cpus) ? cs->cpus_allowed
+						 : cs->exclusive_cpus;
+}
+
+static inline bool xcpus_empty(struct cpuset *cs)
+{
+	return cpumask_empty(cs->cpus_allowed) &&
+	       cpumask_empty(cs->exclusive_cpus);
+}
+
 static inline struct cpumask *fetch_xcpus(struct cpuset *cs)
 {
 	return !cpumask_empty(cs->exclusive_cpus) ? cs->exclusive_cpus :
@@ -1593,7 +1626,7 @@ EXPORT_SYMBOL_GPL(cpuset_cpu_is_isolated);
  * Return: true if xcpus is not empty, false otherwise.
  *
  * Starting with exclusive_cpus (cpus_allowed if exclusive_cpus is not set),
- * it must be a subset of cpus_allowed and parent's effective_xcpus.
+ * it must be a subset of parent's effective_xcpus.
  */
 static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
 						struct cpumask *xcpus)
@@ -1603,12 +1636,7 @@ static bool compute_effective_exclusive_cpumask(struct cpuset *cs,
 	if (!xcpus)
 		xcpus = cs->effective_xcpus;
 
-	if (!cpumask_empty(cs->exclusive_cpus))
-		cpumask_and(xcpus, cs->exclusive_cpus, cs->cpus_allowed);
-	else
-		cpumask_copy(xcpus, cs->cpus_allowed);
-
-	return cpumask_and(xcpus, xcpus, parent->effective_xcpus);
+	return cpumask_and(xcpus, user_xcpus(cs), parent->effective_xcpus);
 }
 
 static inline bool is_remote_partition(struct cpuset *cs)
@@ -1887,8 +1915,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 	 */
 	adding = deleting = false;
 	old_prs = new_prs = cs->partition_root_state;
-	xcpus = !cpumask_empty(cs->exclusive_cpus)
-		? cs->effective_xcpus : cs->cpus_allowed;
+	xcpus = user_xcpus(cs);
 
 	if (cmd == partcmd_invalidate) {
 		if (is_prs_invalid(old_prs))
@@ -1916,7 +1943,7 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		return is_partition_invalid(parent)
 		       ? PERR_INVPARENT : PERR_NOTPART;
 	}
-	if (!newmask && cpumask_empty(cs->cpus_allowed))
+	if (!newmask && xcpus_empty(cs))
 		return PERR_CPUSEMPTY;
 
 	nocpu = tasks_nocpu_error(parent, cs, xcpus);
@@ -3130,9 +3157,9 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 				       ? partcmd_enable : partcmd_enablei;
 
 		/*
-		 * cpus_allowed cannot be empty.
+		 * cpus_allowed and exclusive_cpus cannot be both empty.
 		 */
-		if (cpumask_empty(cs->cpus_allowed)) {
+		if (xcpus_empty(cs)) {
 			err = PERR_CPUSEMPTY;
 			goto out;
 		}
-- 
2.39.3


