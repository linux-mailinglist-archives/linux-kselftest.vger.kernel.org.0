Return-Path: <linux-kselftest+bounces-23311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AA9F08D3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 10:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619701696B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 09:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276D91C3C14;
	Fri, 13 Dec 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CYZwMRSR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E890F1C3BFB
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 09:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083731; cv=none; b=iI0gCx+OXoToYxMuycdSU4GksVeEXR6U9SOyR/iboKojNAAv7YuDKop9/HJA9vlVx6dJUFw1j3SAcy3SokeXGavB76IE1ASGhKGmPfba7ARPQivgQXLdaIHX1E+89ylbIEGLlarNmQe66qCPC6e7DiHG2OJwpW+u04mH3OvE0e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083731; c=relaxed/simple;
	bh=6qIwBxURNeiKQ7WOfYT7k2Laq20fkTyAqgmtL1dLl68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnJoHENkY0FBtfXADPCP2lQeJ41+Abdxi1sqdUZM0gTT1+4wJzpObW1bqTgoLTNXbvsokgjaviaAdbkTsMHDkI+kg9Aq8DCJWs/ENZpguj0fAMl6dLF/hkD+bcZiAmwAut0avEIER09cInE7jcoUObmw0DpEP6hnGgJdHUfG6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CYZwMRSR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734083725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zoc1rmo1ZxPdELSIwUBxgusiNNtCrVkbWCsaBTVZCO8=;
	b=CYZwMRSRwsqztNd1aIK/aTnQ/SiLVOUDQx5Vc7jlxWH7apg/AXzep+mhZvXa/ReUK/JpWC
	ADC71xd7TT6MfaVjNXqwQU9InOm4I+Or+gWVoEHYzxgkwt1qSw1W6A7NR9+UILAclkETwm
	mMMKTu5Rv5f9W1sprdOR8T6eFk+KThc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-uVqnbA6wPtKoeuvb26eCFw-1; Fri,
 13 Dec 2024 04:55:22 -0500
X-MC-Unique: uVqnbA6wPtKoeuvb26eCFw-1
X-Mimecast-MFC-AGG-ID: uVqnbA6wPtKoeuvb26eCFw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8A721955BFE;
	Fri, 13 Dec 2024 09:55:20 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B19E1953951;
	Fri, 13 Dec 2024 09:55:16 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 2/4] sched: Remove mm_cid_next_scan as obsolete
Date: Fri, 13 Dec 2024 10:54:05 +0100
Message-ID: <20241213095407.271357-3-gmonaco@redhat.com>
In-Reply-To: <20241213095407.271357-1-gmonaco@redhat.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The checks for the scan time in task_mm_cid_work are now superfluous
since the task runs in a delayed_work and the minimum periodicity is
already implied.

This patch removes those checks and the field from the mm_struct.

Additionally, we include a simple check to quickly terminate the
function if we have no work to be done (i.e. no mm_cid is allocated).
This is helpful for tasks that sleep for a long time, but also for
terminated task. We are no longer following the process' state, hence
the function continues to run after a process terminates but before its
mm is freed.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 include/linux/mm_types.h |  7 -------
 kernel/sched/core.c      | 19 +++----------------
 2 files changed, 3 insertions(+), 23 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 92acb827fee4..8a76a1c09234 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -829,12 +829,6 @@ struct mm_struct {
 		 * runqueue locks.
 		 */
 		struct mm_cid __percpu *pcpu_cid;
-		/*
-		 * @mm_cid_next_scan: Next mm_cid scan (in jiffies).
-		 *
-		 * When the next mm_cid scan is due (in jiffies).
-		 */
-		unsigned long mm_cid_next_scan;
 		/**
 		 * @nr_cpus_allowed: Number of CPUs allowed for mm.
 		 *
@@ -1228,7 +1222,6 @@ static inline int mm_alloc_cid_noprof(struct mm_struct *mm, struct task_struct *
 		return -ENOMEM;
 	mm_init_cid(mm, p);
 	INIT_DELAYED_WORK(&mm->mm_cid_work, task_mm_cid_work);
-	mm->mm_cid_next_scan = jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY);
 	schedule_delayed_work(&mm->mm_cid_work,
 			      msecs_to_jiffies(MM_CID_SCAN_DELAY));
 	return 0;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e3b27b73301c..30d78fe14eff 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10520,28 +10520,15 @@ static void sched_mm_cid_remote_clear_weight(struct mm_struct *mm, int cpu,
 
 void task_mm_cid_work(struct work_struct *work)
 {
-	unsigned long now = jiffies, old_scan, next_scan;
 	struct cpumask *cidmask;
 	struct delayed_work *delayed_work = container_of(work, struct delayed_work, work);
 	struct mm_struct *mm = container_of(delayed_work, struct mm_struct, mm_cid_work);
 	int weight, cpu;
 
-	old_scan = READ_ONCE(mm->mm_cid_next_scan);
-	next_scan = now + msecs_to_jiffies(MM_CID_SCAN_DELAY);
-	if (!old_scan) {
-		unsigned long res;
-
-		res = cmpxchg(&mm->mm_cid_next_scan, old_scan, next_scan);
-		if (res != old_scan)
-			old_scan = res;
-		else
-			old_scan = next_scan;
-	}
-	if (time_before(now, old_scan))
-		goto out;
-	if (!try_cmpxchg(&mm->mm_cid_next_scan, &old_scan, next_scan))
-		goto out;
 	cidmask = mm_cidmask(mm);
+	/* Nothing to clear for now */
+	if (cpumask_empty(cidmask))
+		goto out;
 	/* Clear cids that were not recently used. */
 	for_each_possible_cpu(cpu)
 		sched_mm_cid_remote_clear_old(mm, cpu);
-- 
2.47.1


