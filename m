Return-Path: <linux-kselftest+bounces-47956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BED3ACDD721
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 08:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 43A4A3051176
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Dec 2025 07:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1052F5306;
	Thu, 25 Dec 2025 07:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cOcYlS5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF222EFD86
	for <linux-kselftest@vger.kernel.org>; Thu, 25 Dec 2025 07:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647942; cv=none; b=bi9jjX/137SspjOZK5jKR6GLDvGbbPzkkKFkjzKXQNV4uAr3D3S5AxbyJLyIXVqs1xwuXOLl3efLjfUa/MnTZ80nCzA54o45qnHXoEXNno3YMwlMT96R1Zav3M+riKoXUKAhY69jlfeFvD8Wu7U9d8cE1D78DJmbBrAQmd1LVzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647942; c=relaxed/simple;
	bh=75xJ6prGWp/1P+h9I5vp4bI5zt+FiTdbPW4rpGCL5/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fLcnd28fnF0nZWKiDt3F3hmMmkczBPrfO5AOAhYXLoJuaMEBQBIZBPkYbCaZ5o4S8wNxyy+FpaxjhgaJYAo2UxAJcFFigupFQpTySOO3WC75rAuqudrXwH/EkXdxyaUp/XtGHkWZ6LEoPWPjVmFIe0+ruXmH+L0aajNFwURWnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cOcYlS5C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766647939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ZkYmlLwb/ewVkxYYA2X8cDrZisOxU2FQ19pbIPXRmc=;
	b=cOcYlS5C1DXfX0B0tFkrXHokWtKJFu1cwvMe2DGJvzkxm22wgIOg+U9aH4nhicvZQCpRaD
	IRjVFYEE0VdrQ/vtShHjou9YCxm+xxrqTLdOFs/1auHZScr1WSKQQldtyRz+r1HHpVrZmU
	wWmAffxkfD42ugcPFIQEmdTHgR1joHI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-H1HRxGFiNo6ej_3-fQ4lNg-1; Thu,
 25 Dec 2025 02:32:13 -0500
X-MC-Unique: H1HRxGFiNo6ej_3-fQ4lNg-1
X-Mimecast-MFC-AGG-ID: H1HRxGFiNo6ej_3-fQ4lNg_1766647932
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A902C19560B2;
	Thu, 25 Dec 2025 07:32:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.2.16.7])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EF14A19560AB;
	Thu, 25 Dec 2025 07:32:08 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Sun Shaojie <sunshaojie@kylinos.cn>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Waiman Long <longman@redhat.com>
Subject: [cgroup/for-6.20 PATCH 3/4] cgroup/cpuset: Don't fail cpuset.cpus change in v2
Date: Thu, 25 Dec 2025 02:30:55 -0500
Message-ID: <20251225073056.30789-4-longman@redhat.com>
In-Reply-To: <20251225073056.30789-1-longman@redhat.com>
References: <20251225073056.30789-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 850334dbc36a..83bf6b588e5f 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -609,33 +609,31 @@ static inline bool cpusets_are_exclusive(struct cpuset *cs1, struct cpuset *cs2)
 
 /**
  * cpus_excl_conflict - Check if two cpusets have exclusive CPU conflicts
- * @cs1: first cpuset to check
- * @cs2: second cpuset to check
+ * @trial:	the trial cpuset to be checked
+ * @sibling:	a sibling cpuset to be checked against
+ * @new_xcpus:	new exclusive_cpus in trial cpuset
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
+				      bool new_xcpus)
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
+	if (new_xcpus && !cpumask_empty(sibling->cpus_allowed) &&
+	    cpumask_subset(sibling->cpus_allowed, trial->exclusive_cpus))
 		return true;
 
 	return false;
@@ -672,6 +670,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 {
 	struct cgroup_subsys_state *css;
 	struct cpuset *c, *par;
+	bool new_xcpus;
 	int ret = 0;
 
 	rcu_read_lock();
@@ -728,10 +727,11 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 	 * overlap. exclusive_cpus cannot overlap with each other if set.
 	 */
 	ret = -EINVAL;
+	new_xcpus = !cpumask_equal(cur->exclusive_cpus, trial->exclusive_cpus);
 	cpuset_for_each_child(c, css, par) {
 		if (c == cur)
 			continue;
-		if (cpus_excl_conflict(trial, c))
+		if (cpus_excl_conflict(trial, c, new_xcpus))
 			goto out;
 		if (mems_excl_conflict(trial, c))
 			goto out;
-- 
2.52.0


