Return-Path: <linux-kselftest+bounces-38588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 68924B1EB9C
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 17:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BAA44E492F
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Aug 2025 15:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A39128541C;
	Fri,  8 Aug 2025 15:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYowSVmD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B43828504C
	for <linux-kselftest@vger.kernel.org>; Fri,  8 Aug 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754666491; cv=none; b=mWQ+ilnSN1ryrMzSdqTKaUcoDEKPfP7rDTVSZRMDAwvsF9QIw1UOpwORjPbrJ6zR8CzJ+UM4w944o9b5hv6K+2Sn6WZgO9A/4tN6AgWe0UZCwI2kgeIV2IbflWvVkkOIXsCOA1IGHC8x9dErZAfrX4tSG5W199OaiGhi32nayrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754666491; c=relaxed/simple;
	bh=MBqCNbw0/4mMEsbRSaYRdm3BtIBo7r05XDeSRZQ1KiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LNfgizzVNNvHLWZz7PEHUFo0Msci9AeTKdEY+gMkSvpwjfLjGqbkiCaQwNKwUmX/z0jtsCL0svXUuRmF/ichq42wK0kT23jjZHRH4iOkaPTY+j5NKCzOA6DGX8ZRVssI3DtNPFEKly+apz5/RRxfbP57RoeJQLl9VP6aDZjrYgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYowSVmD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754666484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adgD1KsqgDBawHB48N8oiqlBQgZtCJcFgOO35w2t8QQ=;
	b=MYowSVmDlFLijx5j6agiF6DesjW2TX/Nmg+f8Xd4pjtxSlp/WhXQIoeWvymz9gSmLDkWNk
	zKjlADJKyizUVO4diEynrKbElulO0TpCsetSMBX95C+x9E91Mwd529vFupVbGHldyLCHj6
	C2a7b8qO9/5MRwu9/DY259RYbkF269A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-bNd6t_mVN-WPjfintDeu9A-1; Fri,
 08 Aug 2025 11:21:20 -0400
X-MC-Unique: bNd6t_mVN-WPjfintDeu9A-1
X-Mimecast-MFC-AGG-ID: bNd6t_mVN-WPjfintDeu9A_1754666468
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC26F195605F;
	Fri,  8 Aug 2025 15:21:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.65.37])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1DDF4180029B;
	Fri,  8 Aug 2025 15:21:01 +0000 (UTC)
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
Subject: [RFC PATCH 17/18] cgroup/cpuset: Documentation updates & don't use CPU 0 for isolated partition
Date: Fri,  8 Aug 2025 11:20:00 -0400
Message-ID: <20250808152001.20245-8-longman@redhat.com>
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

As CPU hotplug is now used to improve CPU isolation of CPUs in isolated
partitions. The boot CPU (typically CPU 0) cannot be put offline
impacting the amount of CPU isolation available. Now we have to advise
users that the boot CPU should never be used for isolated partitions. A
warning will be printed when boot CPU is used and the cgroup-v2.rst is
updated accordingly. The test_cpuset_prs.sh selftest is also updated
to remove CPU 0 when forming isolated partitions.

Also update the cgroup-v2.rst file to show the need to specify the
"nohz_full" kernel boot parameter to enable better nohz_full behavior
for the CPUs in isolated partitions as well as the latency spike issue
with using CPU hotplug.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst       | 33 +++++++++++++++----
 .../selftests/cgroup/test_cpuset_prs.sh       |  8 ++---
 2 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index d9d3cc7df348..26213383b34b 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2556,11 +2556,12 @@ Cpuset Interface Files
 
 	It accepts only the following input values when written to.
 
-	  ==========	=====================================
+	  ==========	===============================================
 	  "member"	Non-root member of a partition
 	  "root"	Partition root
-	  "isolated"	Partition root without load balancing
-	  ==========	=====================================
+	  "isolated"	Partition root without load balancing and other
+		        OS noises
+	  ==========	===============================================
 
 	A cpuset partition is a collection of cpuset-enabled cgroups with
 	a partition root at the top of the hierarchy and its descendants
@@ -2593,9 +2594,29 @@ Cpuset Interface Files
 
 	When set to "isolated", the CPUs in that partition will be in
 	an isolated state without any load balancing from the scheduler
-	and excluded from the unbound workqueues.  Tasks placed in such
-	a partition with multiple CPUs should be carefully distributed
-	and bound to each of the individual CPUs for optimal performance.
+	and excluded from the unbound workqueues as well as without
+	other OS noises.  Tasks placed in such a partition with multiple
+	CPUs should be carefully distributed and bound to each of the
+	individual CPUs for optimal performance.
+
+	As CPU hotplug, if supported, is used to improve the degree of
+	CPU isolation close to the "nohz_full" kernel boot parameter.
+	The boot CPU (typically CPU 0) cannot be brought offline, so the
+	boot CPU should not be used for forming isolated partitions.
+	The "nohz_full" kernel boot parameter needs to be present to
+	enable full dynticks support and RCU no-callback CPU mode for
+	CPUs in isolated partitions even if the optional cpu list
+	isn't provided.  Without that, adding the "rcu_nocbs" boot
+	kernel parameter without the cpu list can be used to enable
+	RCU no-callback CPU mode without full dynticks.
+
+	Using CPU hotplug for creating or destroying an isolated
+	partition can cause latency spike in applications running
+	in other isolated partitions.  A reserved list of CPUs can
+	optionally be put in the "nohz_full" kernel boot parameter to
+	alleviate this problem.  When these reserved CPUs are used for
+	isolated partitions, CPU hotplug won't need to be invoked and
+	so there won't be latency spike in other isolated partitions.
 
 	A partition root ("root" or "isolated") can be in one of the
 	two possible states - valid or invalid.  An invalid partition
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a17256d9f88a..f61369be8bf6 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -318,8 +318,8 @@ TEST_MATRIX=(
 	# Invalid to valid local partition direct transition tests
 	" C1-3:S+:P2 X4:P2  .      .      .      .      .      .     0 A1:1-3|XA1:1-3|A2:1-3:XA2: A1:P2|A2:P-2 1-3"
 	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
-	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
-	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
+	"  C1-3:P2   .      .    C4-6   C1-4     .      .      .     0 A1:1-4|B1:4-6 A1:P-2|B1:P0"
+	"  C1-3:P2   .      .    C4-6 C1-4:C1-3  .      .      .     0 A1:1-3|B1:4-6 A1:P2|B1:P0 1-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
@@ -329,8 +329,8 @@ TEST_MATRIX=(
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
 				   .      .    C4:X     .      .     0 A1:1-3|A2:1-3|A3:2-3|XA2:|XA3: A1:P2|A2:P-2|A3:P-2 1-3"
 	# Local partition CPU change tests
-	" C0-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:0-2|A2:3-5 A1:P2|A2:P1 0-2"
-	" C0-5:S+:P2 C4-5:S+:P1 .  .    C1-5     .      .      .     0 A1:1-3|A2:4-5 A1:P2|A2:P1 1-3"
+	" C1-5:S+:P2 C4-5:S+:P1 .  .      .    C3-5     .      .     0 A1:1-2|A2:3-5 A1:P2|A2:P1 1-2"
+	" C1-5:S+:P2 C4-5:S+:P1 .  .    C2-5     .      .      .     0 A1:2-3|A2:4-5 A1:P2|A2:P1 2-3"
 
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
-- 
2.50.0


