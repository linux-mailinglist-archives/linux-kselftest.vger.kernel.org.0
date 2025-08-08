Return-Path: <linux-kselftest+bounces-38578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D63EEB1EB4F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EBA01A5F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8ED284694;
	Fri,  8 Aug 2025 15:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MBo+K3Pg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6C628466F
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665966; cv=none; b=elu71VnsOxBmT0A45rrXaxVH5AowoTGuREs9QqPs6q68M/11vgwIZQZ4ZCRSqu4x4YYJhMFxAIAw7Afa8THGcrJ82EV8hHofDZPqqvZ1PDlpE+427NXcaf64vwuFp4n5Y2ng+I+NNjt3m1OMuzu3LYhXet9iWvau7arhsBBzmPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665966; c=relaxed/simple;
	bh=WxcyJCO0fWF/itVzNgLAUOJpV3YrZhfDRj22jYzwLrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xwrrgs0TI1r2y+/6LvAdi/e2oZh6VwfwFEQqqbAzHxFfC/ZpKosOjSuJmYR721xj+lPvx7Pjg6EYmITsqS4PI13p2zO4gdO5O47RTsigqFn0INsHwrsfRw9wHuVc1Nl2Ih8je15n9mtTnhr4G67kcbv94YjJA1G5Xx3vKUxvM0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MBo+K3Pg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TXhSdoNCpYJCnFLmB+Mv+/bGCPmxw1lkTCoajFKNs5U=;
	b=MBo+K3PgaUgc/Vip8TJSF3dXnHDWMmPG+C6AqDhjT41XKoaIVMz2UuuAZiYj01Ku2pb4Ay
	T8u75kDC0b4Al2C1cHuREhSiUV2oPNfxbnPTZGBm9lE11rkVZijhSMEC38CCP9jIArffkC
	eqJ3mwb6HJpH+xjN4Ml0KQZlgEBvlRg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-soRIi8mEPtCYPkmgpol81A-1; Fri,
 08 Aug 2025 11:12:39 -0400
X-MC-Unique: soRIi8mEPtCYPkmgpol81A-1
X-Mimecast-MFC-AGG-ID: soRIi8mEPtCYPkmgpol81A_1754665955
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60AE018004A7;
	Fri,  8 Aug 2025 15:12:35 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3182A1954196;
	Fri,  8 Aug 2025 15:12:29 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Phil Auld <pauld@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Cestmir Kalina <ckalina@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 07/18] cgroup/cpuset: Allow overwriting HK_TYPE_DOMAIN housekeeping cpumask
Date: Fri,  8 Aug 2025 11:10:51 -0400
Message-ID: <20250808151053.19777-8-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

As we did not modify housekeeping cpumasks in the creation of cpuset
partition before, we had to disallow the creation of non-isolated
partitions from using any of the HK_TYPE_DOMAIN isolated CPUs. Now we
are going to modify housekeeping cpumasks at run time, we will now allow
overwriting of HK_TYPE_DOMAIN cpumask when an isolated partition is first
created or when the creation of a non-isolated partition conflicts with
the boot time HK_TYPE_DOMAIN isolated CPUs. The unnecessary checking code
are now being removed. The doc file will be updated in a later patch.

On the other hand, there is still a latency spike problem when CPU
hotplug code is used to facilitate the proper functioning of the
dynamically modified nohz_full HK_TYPE_KERNEL_NOISE cpumask. So the
cpuset code will be modified to maintain the boot-time enabled nohz_full
cpumask to avoid using cpu hotplug if all the newly isolated/non-isolated
CPUs are already in that cpumask. This code will be removed in the
future when the latency spike problem is solved.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 45 ++++++++----------------------------------
 1 file changed, 8 insertions(+), 37 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 2190efd33efb..87e9ee7922cd 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -59,7 +59,6 @@ static const char * const perr_strings[] = {
 	[PERR_NOCPUS]    = "Parent unable to distribute cpu downstream",
 	[PERR_HOTPLUG]   = "No cpu available due to hotplug",
 	[PERR_CPUSEMPTY] = "cpuset.cpus and cpuset.cpus.exclusive are empty",
-	[PERR_HKEEPING]  = "partition config conflicts with housekeeping setup",
 	[PERR_ACCESS]    = "Enable partition not permitted",
 	[PERR_REMOTE]    = "Have remote partition underneath",
 };
@@ -81,9 +80,10 @@ static cpumask_var_t	subpartitions_cpus;
 static cpumask_var_t	isolated_cpus;
 
 /*
- * Housekeeping (HK_TYPE_DOMAIN) CPUs at boot
+ * Housekeeping (nohz_full) CPUs at boot
  */
-static cpumask_var_t	boot_hk_cpus;
+static cpumask_var_t	boot_nohz_full_hk_cpus;
+static bool		have_boot_nohz_full;
 static bool		have_boot_isolcpus;
 
 /* List of remote partition root children */
@@ -1609,26 +1609,6 @@ static void remote_cpus_update(struct cpuset *cs, struct cpumask *xcpus,
 	remote_partition_disable(cs, tmp);
 }
 
-/*
- * prstate_housekeeping_conflict - check for partition & housekeeping conflicts
- * @prstate: partition root state to be checked
- * @new_cpus: cpu mask
- * Return: true if there is conflict, false otherwise
- *
- * CPUs outside of boot_hk_cpus, if defined, can only be used in an
- * isolated partition.
- */
-static bool prstate_housekeeping_conflict(int prstate, struct cpumask *new_cpus)
-{
-	if (!have_boot_isolcpus)
-		return false;
-
-	if ((prstate != PRS_ISOLATED) && !cpumask_subset(new_cpus, boot_hk_cpus))
-		return true;
-
-	return false;
-}
-
 /**
  * update_parent_effective_cpumask - update effective_cpus mask of parent cpuset
  * @cs:      The cpuset that requests change in partition root state
@@ -1737,9 +1717,6 @@ static int update_parent_effective_cpumask(struct cpuset *cs, int cmd,
 		if (cpumask_empty(xcpus))
 			return PERR_INVCPUS;
 
-		if (prstate_housekeeping_conflict(new_prs, xcpus))
-			return PERR_HKEEPING;
-
 		/*
 		 * A parent can be left with no CPU as long as there is no
 		 * task directly associated with the parent partition.
@@ -2356,9 +2333,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		    cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
-		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
@@ -2499,9 +2473,6 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 		if (cpumask_empty(trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_INVCPUS;
-		} else if (prstate_housekeeping_conflict(old_prs, trialcs->effective_xcpus)) {
-			invalidate = true;
-			cs->prs_err = PERR_HKEEPING;
 		} else if (tasks_nocpu_error(parent, cs, trialcs->effective_xcpus)) {
 			invalidate = true;
 			cs->prs_err = PERR_NOCPUS;
@@ -3787,11 +3758,11 @@ int __init cpuset_init(void)
 
 	BUG_ON(!alloc_cpumask_var(&cpus_attach, GFP_KERNEL));
 
-	have_boot_isolcpus = housekeeping_enabled(HK_TYPE_DOMAIN);
-	if (have_boot_isolcpus) {
-		BUG_ON(!alloc_cpumask_var(&boot_hk_cpus, GFP_KERNEL));
-		cpumask_copy(boot_hk_cpus, housekeeping_cpumask(HK_TYPE_DOMAIN));
-		cpumask_andnot(isolated_cpus, cpu_possible_mask, boot_hk_cpus);
+	have_boot_nohz_full = housekeeping_enabled(HK_TYPE_KERNEL_NOISE);
+	have_boot_isolcpus  = housekeeping_enabled(HK_TYPE_DOMAIN);
+	if (have_boot_nohz_full) {
+		BUG_ON(!alloc_cpumask_var(&boot_nohz_full_hk_cpus, GFP_KERNEL));
+		cpumask_copy(boot_nohz_full_hk_cpus, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
 	}
 
 	return 0;
-- 
2.50.0


