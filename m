Return-Path: <linux-kselftest+bounces-29930-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF22A75CD3
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DCC1885F02
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD151DF97F;
	Sun, 30 Mar 2025 21:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jxg714VM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438E01DEFF5
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371633; cv=none; b=MHKtdYRDNwJq6o5HKTtAWfSPKKg4qHxUlLVI+Cs3LS3ZX9Ucxc/x1AW12mA9SEsiqz5NdMaPikhRwhxwhzG5+FQnek4bNctFrCOYmcXKmbH9YvJVUOaHJarw4GmP0XtL0sPV2IGawN4to9gmGE3UY38ngB40+b510+ruD1mo2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371633; c=relaxed/simple;
	bh=wIACSkeO4vRoizm1S/WsoY1k3BJsNOCB6s2ajv4Hje0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlZTdII/GvywonO7/JSZONhWjVsS4AvmJbXh1lfMzVceFrJxS3VIchvu2KGJndhSM+mp8bSsWJT3VJFaKng8okhrcmWxlBJI7fAJJxcVKlaW5tuZMPVjxMjeTrtWcntMReyh9ORHVTA9MS0THiKXvNevvCTbx7k6p9nKgSxbNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jxg714VM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GRL+fg9mL/3GjOTKTowst4cQ96q8nZqCEULdMdc92O8=;
	b=Jxg714VMfRNIOnXkznLvVQTuSWAYNFj01EAg9jmpfdG63sltrNprEXtUhtnsjcMdrQ7ha+
	31kGf9lPhb3HYaH8fbyY02Ga0eilSh3WRwMhaeKA9LI1dSHPK3WJeRLlMs/oSOHksAeaKx
	lobsSTnmE1apWlSh9eY/5KQejwLISJA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-287-npDiENFfMz6m-5K-1Pun8w-1; Sun,
 30 Mar 2025 17:53:47 -0400
X-MC-Unique: npDiENFfMz6m-5K-1Pun8w-1
X-Mimecast-MFC-AGG-ID: npDiENFfMz6m-5K-1Pun8w_1743371626
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F8D518007E1;
	Sun, 30 Mar 2025 21:53:46 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22F061801750;
	Sun, 30 Mar 2025 21:53:44 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 03/10] cgroup/cpuset: Fix error handling in remote_partition_disable()
Date: Sun, 30 Mar 2025 17:52:41 -0400
Message-ID: <20250330215248.3620801-4-longman@redhat.com>
In-Reply-To: <20250330215248.3620801-1-longman@redhat.com>
References: <20250330215248.3620801-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When remote_partition_disable() is called to disable a remote partition,
it always sets the partition to an invalid partition state. It should
only do so if an error code (prs_err) has been set. Correct that and
add proper error code in places where remote_partition_disable() is
called due to error.

Fixes: 181c8e091aae ("cgroup/cpuset: Introduce remote partition")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a4d7bfef855f..2c5b25609c56 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1406,6 +1406,7 @@ static int remote_partition_enable(struct cpuset *cs, int new_prs,
 	list_add(&cs->remote_sibling, &remote_children);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
+	cs->prs_err = 0;
 
 	/*
 	 * Propagate changes in top_cpuset's effective_cpus down the hierarchy.
@@ -1436,9 +1437,11 @@ static void remote_partition_disable(struct cpuset *cs, struct tmpmasks *tmp)
 	list_del_init(&cs->remote_sibling);
 	isolcpus_updated = partition_xcpus_del(cs->partition_root_state,
 					       NULL, tmp->new_cpus);
-	cs->partition_root_state = -cs->partition_root_state;
-	if (!cs->prs_err)
-		cs->prs_err = PERR_INVCPUS;
+	if (cs->prs_err)
+		cs->partition_root_state = -cs->partition_root_state;
+	else
+		cs->partition_root_state = PRS_MEMBER;
+
 	reset_partition_data(cs);
 	spin_unlock_irq(&callback_lock);
 	update_unbound_workqueue_cpumask(isolcpus_updated);
@@ -1471,8 +1474,10 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 
 	WARN_ON_ONCE(!cpumask_subset(cs->effective_xcpus, subpartitions_cpus));
 
-	if (cpumask_empty(newmask))
+	if (cpumask_empty(newmask)) {
+		cs->prs_err = PERR_CPUSEMPTY;
 		goto invalidate;
+	}
 
 	adding   = cpumask_andnot(tmp->addmask, newmask, cs->effective_xcpus);
 	deleting = cpumask_andnot(tmp->delmask, cs->effective_xcpus, newmask);
@@ -1482,10 +1487,15 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *newmask,
 	 * not allocated to other partitions and there are effective_cpus
 	 * left in the top cpuset.
 	 */
-	if (adding && (!capable(CAP_SYS_ADMIN) ||
-		       cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
-		       cpumask_subset(top_cpuset.effective_cpus, tmp->addmask)))
-		goto invalidate;
+	if (adding) {
+		if (!capable(CAP_SYS_ADMIN))
+			cs->prs_err = PERR_ACCESS;
+		else if (cpumask_intersects(tmp->addmask, subpartitions_cpus) ||
+			 cpumask_subset(top_cpuset.effective_cpus, tmp->addmask))
+			cs->prs_err = PERR_NOCPUS;
+		if (cs->prs_err)
+			goto invalidate;
+	}
 
 	spin_lock_irq(&callback_lock);
 	if (adding)
@@ -1601,7 +1611,7 @@ static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
  * The partcmd_update command is used by update_cpumasks_hier() with newmask
  * NULL and update_cpumask() with newmask set. The partcmd_invalidate is used
  * by update_cpumask() with NULL newmask. In both cases, the callers won't
- * check for error and so partition_root_state and prs_error will be updated
+ * check for error and so partition_root_state and prs_err will be updated
  * directly.
  */
 static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
@@ -3753,6 +3763,7 @@ static void cpuset_hotplug_update_tasks(struct cpuset *cs, struct tmpmasks *tmp)
 
 	if (remote && cpumask_empty(&new_cpus) &&
 	    partition_is_populated(cs, NULL)) {
+		cs->prs_err = PERR_HOTPLUG;
 		remote_partition_disable(cs, tmp);
 		compute_effective_cpumask(&new_cpus, cs, parent);
 		remote = false;
-- 
2.48.1


