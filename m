Return-Path: <linux-kselftest+bounces-38589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E9DB1EBA3
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0903B9934
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01CF2857DD;
	Fri,  8 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC/H9Say"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DE728504D
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666491; cv=none; b=h3egvPnfYPq69EXSQBR5Qyqqk4P6vfmV99p3BloUa0OPpaLjUjgajUm+MeweEK0rqvFHISC9OdLcas2LTA/tlpqP8Kwc2PCEHoyBELjLIBs3tQivpuqXgf/UpmQpHQGa80eJb2D4bHMXV+rLeV44ys/5RUBje35Eg4s9FGikeVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666491; c=relaxed/simple;
	bh=ZncYki1KL4ndbu/cEBgE3ithy3n1MacpG1Kddz8qY/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/X0sMKhVAzglqS6/DaQOhAGX2FhkKA5G9Qh+mN/TVA37e0kvd+oK6pTYx94Y9whMO2VBawaxpw98K/DHh43xyKDgg2wGXrmUlA+yBY1yzV8NeMX9nIhIZz/JuRzmtcZkvqWBaYjjBwtE/2ivgVfB8T8zjulMybJpuTdCYFx/rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC/H9Say; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OkInnKItN1D64SESBQnElXZy3eYPYkSB5pXAhM/lfjA=;
	b=PC/H9SayD/FfXdiclMJWunqQqsVfRkgkpR/du9L6/CF33MKONaitGHup6HlKYVBPy1n2AZ
	52mNbdDLkuIXIa2Rjmw7MPInJ0JZ4gW293ZOVW/Auezolq7pNGI+9eOdDkYavOkuUXgHO8
	cGgeHtzMZBa7qEarXpLfrwNCKSbF8UA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-a8ijxvpuNdOkYZYzaCQICw-1; Fri,
 08 Aug 2025 11:21:22 -0400
X-MC-Unique: a8ijxvpuNdOkYZYzaCQICw-1
X-Mimecast-MFC-AGG-ID: a8ijxvpuNdOkYZYzaCQICw_1754666474
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 17E4919560B1;
	Fri,  8 Aug 2025 15:21:14 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D1D51800294;
	Fri,  8 Aug 2025 15:21:08 +0000 (UTC)
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
Subject: [RFC PATCH 18/18] cgroup/cpuset: Add pr_debug() statements for cpuhp_offline_cb() call
Date: Fri,  8 Aug 2025 11:20:01 -0400
Message-ID: <20250808152001.20245-9-longman@redhat.com>
In-Reply-To: <20250808151053.19777-1-longman@redhat.com>
References: <20250808151053.19777-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Add some pr_debug() statements to actions performed related to the
cpuhp_offline_cb() call to aid debugging. Since rcu_nocb_cpu_offload()
and rcu_nocb_cpu_deoffload() will print out some info text, there is
no need to add pr_debug() statements for them.

Also update test_cpuset_prs.sh test script to enable printing of dynamic
debug messages for the kernel/cgroup/cpuset.c file when loglevel is 7
(debug).

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c                         | 18 +++++++++++++-----
 .../selftests/cgroup/test_cpuset_prs.sh        |  7 +++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 489708f4e096..30632e4b5899 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -21,6 +21,7 @@
  *  License.  See the file COPYING in the main directory of the Linux
  *  distribution for more details.
  */
+#define pr_fmt(fmt) "cpuset: " fmt
 #include "cpuset-internal.h"
 
 #include <linux/context_tracking.h>
@@ -1406,10 +1407,13 @@ static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
 	if (tick_nohz_full_enabled()) {
 		tick_nohz_full_update_cpus(icpus);
 		for_each_cpu(cpu, isolcpus_update_state.cpus) {
-			if (cpumask_test_cpu(cpu, icpus))
+			if (cpumask_test_cpu(cpu, icpus)) {
+				pr_debug("Add CPU %d to nohz_full\n", cpu);
 				ct_cpu_track_user(cpu);
-			else
+			} else {
+				pr_debug("Remove CPU %d from nohz_full\n", cpu);
 				ct_cpu_untrack_user(cpu);
+			}
 		}
 	} else {
 		pr_warn_once("Full dynticks cannot be enabled without the nohz_full kernel boot parameter!\n");
@@ -1425,6 +1429,7 @@ static int do_housekeeping_exclude_cpumask(void *arg __maybe_unused)
 				ret = rcu_nocb_cpu_offload(cpu);
 			else
 				ret = rcu_nocb_cpu_deoffload(cpu);
+
 			if (WARN_ON_ONCE(ret))
 				break;
 		}
@@ -1468,11 +1473,14 @@ static void update_isolation_cpumasks(void)
 	 * Without any change in the set of nohz_full CPUs, we don't really
 	 * need to use CPU hotplug for making change in HK cpumasks.
 	 */
-	if (cpumask_empty(isolcpus_update_state.cpus))
+	if (cpumask_empty(isolcpus_update_state.cpus)) {
 		ret = do_housekeeping_exclude_cpumask(NULL);
-	else
+	} else {
+		pr_debug("cpuhp_offline_cb() called for CPUs %*pbl\n",
+			 cpumask_pr_args(isolcpus_update_state.cpus));
 		ret = cpuhp_offline_cb(isolcpus_update_state.cpus,
 				       do_housekeeping_exclude_cpumask, NULL);
+	}
 	/*
 	 * A errno value of -EPERM may be returned from cpuhp_offline_cb() if
 	 * any one of the CPUs in isolcpus_update_state.cpus can't be brought
@@ -1481,7 +1489,7 @@ static void update_isolation_cpumasks(void)
 	 * isolated partition.
 	 */
 	if (ret == -EPERM)
-		pr_warn_once("cpuset: The boot CPU shouldn't be used for isolated partition\n");
+		pr_warn_once("The boot CPU shouldn't be used for isolated partition\n");
 	else
 		WARN_ON_ONCE(ret < 0);
 
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index f61369be8bf6..43a12690775e 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -67,6 +67,13 @@ then
 	echo Y > /sys/kernel/debug/sched/verbose
 fi
 
+# Enable dynamic debug messages for cpuset only
+DYN_DEBUG=/sys/kernel/debug/dynamic_debug/control
+[[ -f $DYN_DEBUG ]] && {
+	echo "-p" > $DYN_DEBUG
+	echo "file kernel/cgroup/cpuset.c +p" > $DYN_DEBUG
+}
+
 cd $CGROUP2
 echo +cpuset > cgroup.subtree_control
 
-- 
2.50.0


