Return-Path: <linux-kselftest+bounces-48765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AED1D13E1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 17:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA41D30001AC
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5B6364055;
	Mon, 12 Jan 2026 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tyltzwra"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBEB35CBB7
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 16:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233684; cv=none; b=AuvbtO9+OqSAJYy0O/Zv5+9hNZyFks9yNZMPA8MDkiduItVUubNDX2PKHDZO4ys13AKazAyIUCn6Yn139JB2AhwonuGOIeTAGQEo+Kaba8xDGR4cuZzo4ROebO0JGRnAARVSGUqYUrf8jpAecDSod3mHO6B/NFc0UvfN7uO25HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233684; c=relaxed/simple;
	bh=36mAFxRYaNY06HT5BGbXc/h0ywPNpQUoVyhIHkIpbeE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/w24i4qm5mjk5kgxgMmH/aM62VtGAsTH3JfJuCIB5taR1RPY0Egla9fFyJntiFMKiI2OQVijUU2w3LiOQqGcDK6SQ7u762ahQOII34yaA7r0A0gzUC1WZimCSLY5xro2lSAv+LXODo41gKZ61JP1tSAeJtpfd8EV0z1FBQAef8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tyltzwra; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768233681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3GpY/lMd+KwV4w59jZdkQcFRXk2EASk1qcLjb4w5/n4=;
	b=TyltzwraJcF/Bxqlaqw4ef1ag7LYli+OEGl8cfZAA7AN8kb7SEWw6BJUcMusDHWPBKfaxI
	nSLwG8Pr4qsIl1QrL7bY8ms0CHqpP51pDNy+8fvZMyN2PBQ/SPtKi7581aSXUhBx8Kioj/
	0p80SQxqeeV+vt/cDdZJTir7LwPemps=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-sShUt-sJP2mNyJ5CYUyRfw-1; Mon,
 12 Jan 2026 11:01:17 -0500
X-MC-Unique: sShUt-sJP2mNyJ5CYUyRfw-1
X-Mimecast-MFC-AGG-ID: sShUt-sJP2mNyJ5CYUyRfw_1768233675
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 92A42195605F;
	Mon, 12 Jan 2026 16:01:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.95])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C133619560B2;
	Mon, 12 Jan 2026 16:01:04 +0000 (UTC)
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
Subject: [PATCH cgroup/for-6.20 v5 3/5] cgroup/cpuset: Don't fail cpuset.cpus change in v2
Date: Mon, 12 Jan 2026 11:00:19 -0500
Message-ID: <20260112160021.483561-4-longman@redhat.com>
In-Reply-To: <20260112160021.483561-1-longman@redhat.com>
References: <20260112160021.483561-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Commit fe8cd2736e75 ("cgroup/cpuset: Delay setting of CS_CPU_EXCLUSIVE
until valid partition") introduced a new check to disallow the setting
of a new cpuset.cpus.exclusive value that is a superset of a sibling's
cpuset.cpus value so that there will at least be one CPU left in the
sibling in case the cpuset becomes a valid partition root. This new
check does have the side effect of failing a cpuset.cpus change that
make it a subset of a sibling's cpuset.cpus.exclusive value.

With v2, users are supposed to be allowed to set whatever value they
want in cpuset.cpus without failure. To maintain this rule, the check
is now restricted to only when cpuset.cpus.exclusive is being changed
not when cpuset.cpus is changed.

The cgroup-v2.rst doc file is also updated to reflect this change.

Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Chen Ridong <chenridong@huawei.com>
---
 Documentation/admin-guide/cgroup-v2.rst |  8 +++----
 kernel/cgroup/cpuset.c                  | 30 ++++++++++++-------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 7f5b59d95fce..510df2461aff 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2561,10 +2561,10 @@ Cpuset Interface Files
 	Users can manually set it to a value that is different from
 	"cpuset.cpus".	One constraint in setting it is that the list of
 	CPUs must be exclusive with respect to "cpuset.cpus.exclusive"
-	of its sibling.  If "cpuset.cpus.exclusive" of a sibling cgroup
-	isn't set, its "cpuset.cpus" value, if set, cannot be a subset
-	of it to leave at least one CPU available when the exclusive
-	CPUs are taken away.
+	and "cpuset.cpus.exclusive.effective" of its siblings.	Another
+	constraint is that it cannot be a superset of "cpuset.cpus"
+	of its sibling in order to leave at least one CPU available to
+	that sibling when the exclusive CPUs are taken away.
 
 	For a parent cgroup, any one of its exclusive CPUs can only
 	be distributed to at most one of its child cgroups.  Having an
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 894131f47f78..4819ab429771 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -609,33 +609,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 
 /**
  * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
- * @cs1: first cpuset to check
- * @cs2: second cpuset to check
+ * @trial:	the trial cpuset to be checked
+ * @sibling:	a sibling cpuset to be checked against
+ * @xcpus_changed: set if exclusive_cpus has been set
  *
  * Returns: true if CPU exclusivity conflict exists, false otherwise
  *
  * Conflict detection rules:
  * 1. If either cpuset is CPU exclusive, they must be mutually exclusive
  * 2. exclusive_cpus masks cannot intersect between cpusets
- * 3. The allowed CPUs of one cpuset cannot be a subset of another's exclusive CPUs
+ * 3. The allowed CPUs of a sibling cpuset cannot be a subset of the new exclusive CPUs
  */
-static inline bool cpus_excl_conflict(struct cpuset *cs1, struct cpuset *cs2)
+static inline bool cpus_excl_conflict(struct cpuset *trial, struct cpuset *sibling,
+				      bool xcpus_changed)
 {
 	/* If either cpuset is exclusive, check if they are mutually exclusive */
-	if (is_cpu_exclusive(cs1) || is_cpu_exclusive(cs2))
-		return !cpusets_are_exclusive(cs1, cs2);
+	if (is_cpu_exclusive(trial) || is_cpu_exclusive(sibling))
+		return !cpusets_are_exclusive(trial, sibling);
 
 	/* Exclusive_cpus cannot intersect */
-	if (cpumask_intersects(cs1->exclusive_cpus, cs2->exclusive_cpus))
+	if (cpumask_intersects(trial->exclusive_cpus, sibling->exclusive_cpus))
 		return true;
 
-	/* The cpus_allowed of one cpuset cannot be a subset of another cpuset's exclusive_cpus */
-	if (!cpumask_empty(cs1->cpus_allowed) &&
-	    cpumask_subset(cs1->cpus_allowed, cs2->exclusive_cpus))
-		return true;
-
-	if (!cpumask_empty(cs2->cpus_allowed) &&
-	    cpumask_subset(cs2->cpus_allowed, cs1->exclusive_cpus))
+	/* The cpus_allowed of a sibling cpuset cannot be a subset of the new exclusive_cpus */
+	if (xcpus_changed && !cpumask_empty(sibling->cpus_allowed) &&
+	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
 		return true;
 
 	return false;
@@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *c, *par;
+	bool xcpus_changed;
 	int ret = 0;
 
 	rcu_read_lock();
@@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * overlap. exclusive_cpus cannot overlap with each other if set.
 	 */
 	ret = -EINVAL;
+	xcpus_changed = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
 	cpuset_for_each_child(c, css, par) {
 		if (c == cur)
 			continue;
-		if (cpus_excl_conflict(trial, c))
+		if (cpus_excl_conflict(trial, c, xcpus_changed))
 			goto out;
 		if (mems_excl_conflict(trial, c))
 			goto out;
-- 
2.52.0


