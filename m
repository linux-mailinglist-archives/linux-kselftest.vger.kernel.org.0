Return-Path: <linux-kselftest+bounces-38579-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79768B1EB51
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15C423AB2E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFCA283C82;
	Fri,  8 Aug 2025 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQF9vPSF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A52836A4
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754665980; cv=none; b=OCb+47xzW8m7gTaQUAgKiz2Nx8R4CUquQUUIULYhk1m45aqBZfkuad+JW9E866JURL2qB7537E7Q9VDakgWdGbTasNn7pGDpESSJSV6C71jzLo3OTRibDHCy8zuAwMhV0a7uwYAutLAfOjYqgf2i+iidcc7rhXJ30FG2NdYKq74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754665980; c=relaxed/simple;
	bh=cIpLk/5NGgJNNjuGY9UZLAULUVicJJ7g5IXjevBvTvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PhtczoKAXLrRylMAjFZxPTP8AMJm14fP8Dfx3o9mZpISeNvPbPKAlz0h8qLCZodF4J6oeC8qZUaeHV/j9zeTL5SGjANNyi5f6t4MN+1Nuaqfw3XfCyA2EwachlPgZuD0nImX+q/KwGNLVGq03QQqpDRoXIGhWBnCEZL35VtZTVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TQF9vPSF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754665977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcgR+/Mgcw3wYRw08/uxfDNmVczMzzLTybzSdrby6Ro=;
	b=TQF9vPSF3CY8m4pwiz7IQZ5pVLACzmaPD9kuWE6+fQeJZYw0BwLECD5eOh5KyBac1prlIZ
	RQ6YJGGTKyYUoRKc/Vq9tGKy7Oji04bmuinx0qqhooc4O3oQx/q/Izom8tO1C9NWhk8JIq
	DBm7ay8TuqmBrF2lDYtihNHpLkgrEts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-114-nwSTaxClN8ahNFuZwPS4cg-1; Fri,
 08 Aug 2025 11:12:49 -0400
X-MC-Unique: nwSTaxClN8ahNFuZwPS4cg-1
X-Mimecast-MFC-AGG-ID: nwSTaxClN8ahNFuZwPS4cg_1754665962
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3F8F180029A;
	Fri,  8 Aug 2025 15:12:41 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A6212195419C;
	Fri,  8 Aug 2025 15:12:35 +0000 (UTC)
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
Subject: [RFC PATCH 08/18] cgroup/cpuset: Use CPU hotplug to enable runtime nohz_full modification
Date: Fri,  8 Aug 2025 11:10:52 -0400
Message-ID: <20250808151053.19777-9-longman@redhat.com>
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

One relatively simple way to allow runtime modification of nohz_full,
and rcu_nocbs CPUs is to use the CPU hotplug to bring the affected CPUs
offline first, making changes to the housekeeping cpumasks and then
bring them back online. However, doing this will be rather costly in
term of the number of CPU cycles needed. Still it is the easiet way to
achieve the desired result and hopefully we can gradually reduce the
overhead over time.

Use the newly introduced cpuhp_offline_cb() API to bring the affected
CPUs offline, make the necessary housekeeping cpumask changes and then
bring those CPUs back online again.

As HK_TYPE_DOMAIN cpumask is going to be updated at run time, we are
going to reset any boot time isolcpus domain setting if an isolated
partition or a conflicting non-isolated partition is going to be
created.

Since rebuild_sched_domains() will be called at the end of
update_isolation_cpumasks(), earlier rebuild_sched_domains_locked()
calls will be suppressed to avoid unneeded work.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 95 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 87e9ee7922cd..60f336e50b05 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1355,11 +1355,57 @@ static void partition_xcpus_del(int old_prs, struct cpuset *parent,
 	return;
 }
 
+/*
+ * We are only updating HK_TYPE_DOMAIN and HK_TYPE_KERNEL_NOISE housekeeping
+ * cpumask for now. HK_TYPE_MANAGED_IRQ will be handled later.
+ */
+static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
+{
+	int ret;
+	struct cpumask *icpus = isolated_cpus;
+	unsigned long flags = BIT(HK_TYPE_DOMAIN) | BIT(HK_TYPE_KERNEL_NOISE);
+
+	/*
+	 * The boot time isolcpus setting will be overwritten if set.
+	 */
+	have_boot_isolcpus = false;
+
+	if (have_boot_nohz_full) {
+		/*
+		 * Need to separate the handling of HK_TYPE_KERNEL_NOISE and
+		 * HK_TYPE_DOMAIN as different cpumasks will be used for each.
+		 */
+		ret = housekeeping_exclude_cpumask(icpus, BIT(HK_TYPE_DOMAIN));
+		WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
+
+		if (cpumask_empty(isolcpus_update_state.cpus))
+			return ret;
+		flags = BIT(HK_TYPE_KERNEL_NOISE);
+		icpus = kmalloc(cpumask_size(), GFP_KERNEL);
+		if (WARN_ON_ONCE(!icpus))
+			return -ENOMEM;
+
+		/*
+		 * Add boot time nohz_full CPUs into the isolated CPUs list
+		 * for exclusion from HK_TYPE_KERNEL_NOISE CPUs.
+		 */
+		cpumask_andnot(icpus, cpu_possible_mask, boot_nohz_full_hk_cpus);
+		cpumask_or(icpus, icpus, isolated_cpus);
+	}
+	ret = housekeeping_exclude_cpumask(icpus, flags);
+	WARN_ON_ONCE((ret < 0) && (ret != -EOPNOTSUPP));
+
+	if (icpus != isolated_cpus)
+		kfree(icpus);
+	return ret;
+}
+
 /**
  * update_isolation_cpumasks - Update external isolation CPU masks
  *
  * The following external CPU masks will be updated if necessary:
  * - workqueue unbound cpumask
+ * - housekeeping cpumasks
  */
 static void update_isolation_cpumasks(void)
 {
@@ -1371,7 +1417,41 @@ static void update_isolation_cpumasks(void)
 	ret = workqueue_unbound_exclude_cpumask(isolated_cpus);
 	WARN_ON_ONCE(ret < 0);
 
+	 /*
+	  * Mask out offline and boot-time nohz_full non-housekeeping
+	  * CPUs from isolcpus_update_state.cpus to compute the set
+	  * of CPUs that need to be brought offline before calling
+	  * do_housekeeping_exclude_cpumask().
+	  */
+	cpumask_and(isolcpus_update_state.cpus,
+		    isolcpus_update_state.cpus, cpu_active_mask);
+	if (have_boot_nohz_full)
+		cpumask_and(isolcpus_update_state.cpus,
+			    isolcpus_update_state.cpus, boot_nohz_full_hk_cpus);
+
+	/*
+	 * Without any change in the set of nohz_full CPUs, we don't really
+	 * need to use CPU hotplug for making change in HK cpumasks.
+	 */
+	if (cpumask_empty(isolcpus_update_state.cpus))
+		ret = do_housekeeping_exclude_cpumask(NULL);
+	else
+		ret = cpuhp_offline_cb(isolcpus_update_state.cpus,
+				       do_housekeeping_exclude_cpumask, NULL);
+	/*
+	 * A errno value of -EPERM may be returned from cpuhp_offline_cb() if
+	 * any one of the CPUs in isolcpus_update_state.cpus can't be brought
+	 * offline. This can happen for the boot CPU (normally CPU 0) which
+	 * cannot be shut down. This CPU should not be used for creating
+	 * isolated partition.
+	 */
+	if (ret == -EPERM)
+		pr_warn_once("cpuset: The boot CPU shouldn't be used for isolated partition\n");
+	else
+		WARN_ON_ONCE(ret < 0);
+
 	cpumask_clear(isolcpus_update_state.cpus);
+	rebuild_sched_domains();
 	isolcpus_update_state.updating = false;
 }
 
@@ -2961,7 +3041,16 @@ static int update_prstate(struct cpuset *cs, int new_prs)
 	update_partition_sd_lb(cs, old_prs);
 
 	notify_partition_change(cs, old_prs);
-	if (force_sd_rebuild)
+
+	/*
+	 * If boot time domain isolcpus exists and it conflicts with the CPUs
+	 * in the new partition, we will have to reset HK_TYPE_DOMAIN cpumask.
+	 */
+	if (have_boot_isolcpus && (new_prs > PRS_MEMBER) &&
+	    !cpumask_subset(cs->effective_xcpus, housekeeping_cpumask(HK_TYPE_DOMAIN)))
+		isolcpus_update_state.updating = true;
+
+	if (force_sd_rebuild && !isolcpus_update_state.updating)
 		rebuild_sched_domains_locked();
 	free_cpumasks(NULL, &tmpmask);
 	return 0;
@@ -3232,7 +3321,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
 	}
 
 	free_cpuset(trialcs);
-	if (force_sd_rebuild)
+	if (force_sd_rebuild && !isolcpus_update_state.updating)
 		rebuild_sched_domains_locked();
 out_unlock:
 	mutex_unlock(&cpuset_mutex);
@@ -3999,7 +4088,7 @@ static void cpuset_handle_hotplug(void)
 	}
 
 	/* rebuild sched domains if necessary */
-	if (force_sd_rebuild)
+	if (force_sd_rebuild && !isolcpus_update_state.updating)
 		rebuild_sched_domains_cpuslocked();
 
 	free_cpumasks(NULL, ptmp);
-- 
2.50.0


