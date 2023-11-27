Return-Path: <linux-kselftest+bounces-664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAF7FAA9C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 20:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C773C2817EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 19:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C73845950;
	Mon, 27 Nov 2023 19:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1LmlbiF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC2FDE
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 11:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701114676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yetQtQw07rU4YZ4FG3ra/SKREh1x+pvvLVJIVKSvN98=;
	b=D1LmlbiF+W4pKuMqgZWssNHBqCkXS+C44ljypm/wlpIF4dDmDrYopCtv6sm9miRO6VtGNn
	0L+oYplAmGU+QUCFwmUggZNs9vsmf0KvET7s/Vx88fsUWS71oyHFTgpkQAUgId93QDUO7L
	OPbZMtWkFrILn/ggmkHjW8CCnlVSoR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-68-8QI2V3YVMdKdlmPH0cmaFA-1; Mon, 27 Nov 2023 14:51:13 -0500
X-MC-Unique: 8QI2V3YVMdKdlmPH0cmaFA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A75F6185A780;
	Mon, 27 Nov 2023 19:51:12 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.93])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0D435492BE9;
	Mon, 27 Nov 2023 19:51:12 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH] cgroup/cpuset: Expose cpuset.cpus.isolated
Date: Mon, 27 Nov 2023 14:51:05 -0500
Message-Id: <20231127195105.290402-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

The root-only cpuset.cpus.isolated control file shows the current set
of isolated CPUs in isolated partitions. This control file is currently
exposed only with the cgroup_debug boot command line option which also
adds the ".__DEBUG__." prefix. This is actually a useful control file if
users want to find out which CPUs are currently in an isolated state by
the cpuset controller. Remove CFTYPE_DEBUG flag for this control file and
make it available by default without any prefix.

The test_cpuset_prs.sh test script and the cgroup-v2.rst documentation
file are also updated accordingly. Minor code change is also made in
test_cpuset_prs.sh to avoid false test failure when running on debug
kernel.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/admin-guide/cgroup-v2.rst       |  7 ++++
 kernel/cgroup/cpuset.c                        |  2 +-
 .../selftests/cgroup/test_cpuset_prs.sh       | 32 +++++++++++--------
 3 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cf5651a11df8..30f6ff2eba47 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2316,6 +2316,13 @@ Cpuset Interface Files
 	treated to have an implicit value of "cpuset.cpus" in the
 	formation of local partition.
 
+  cpuset.cpus.isolated
+	A read-only and root cgroup only multiple values file.
+
+	This file shows the set of all isolated CPUs used in existing
+	isolated partitions. It will be empty if no isolated partition
+	is created.
+
   cpuset.cpus.partition
 	A read-write single value file which exists on non-root
 	cpuset-enabled cgroups.  This flag is owned by the parent cgroup
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 1bad4007ff4b..2a16df86c55c 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -3974,7 +3974,7 @@ static struct cftype dfl_files[] = {
 		.name = "cpus.isolated",
 		.seq_show = cpuset_common_seq_show,
 		.private = FILE_ISOLATED_CPULIST,
-		.flags = CFTYPE_ONLY_ON_ROOT | CFTYPE_DEBUG,
+		.flags = CFTYPE_ONLY_ON_ROOT,
 	},
 
 	{ }	/* terminate */
diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 7b7c4c2b6d85..b5eb1be2248c 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -508,7 +508,7 @@ dump_states()
 		XECPUS=$DIR/cpuset.cpus.exclusive.effective
 		PRS=$DIR/cpuset.cpus.partition
 		PCPUS=$DIR/.__DEBUG__.cpuset.cpus.subpartitions
-		ISCPUS=$DIR/.__DEBUG__.cpuset.cpus.isolated
+		ISCPUS=$DIR/cpuset.cpus.isolated
 		[[ -e $CPUS   ]] && echo "$CPUS: $(cat $CPUS)"
 		[[ -e $XCPUS  ]] && echo "$XCPUS: $(cat $XCPUS)"
 		[[ -e $ECPUS  ]] && echo "$ECPUS: $(cat $ECPUS)"
@@ -593,17 +593,17 @@ check_cgroup_states()
 
 #
 # Get isolated (including offline) CPUs by looking at
-# /sys/kernel/debug/sched/domains and *cpuset.cpus.isolated control file,
+# /sys/kernel/debug/sched/domains and cpuset.cpus.isolated control file,
 # if available, and compare that with the expected value.
 #
 # Note that isolated CPUs from the sched/domains context include offline
 # CPUs as well as CPUs in non-isolated 1-CPU partition. Those CPUs may
-# not be included in the *cpuset.cpus.isolated control file which contains
+# not be included in the cpuset.cpus.isolated control file which contains
 # only CPUs in isolated partitions.
 #
 # $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
-# <isolcpus2> - *cpuset.cpus.isolated value = <isolcpus1> if not defined
+# <isolcpus2> - cpuset.cpus.isolated value = <isolcpus1> if not defined
 #
 check_isolcpus()
 {
@@ -611,7 +611,7 @@ check_isolcpus()
 	ISOLCPUS=
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
-	ISCPUS=${CGROUP2}/.__DEBUG__.cpuset.cpus.isolated
+	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
 	if [[ $EXPECT_VAL = . ]]
 	then
 		EXPECT_VAL=
@@ -692,14 +692,18 @@ test_fail()
 null_isolcpus_check()
 {
 	[[ $VERBOSE -gt 0 ]] || return 0
-	pause 0.02
-	check_isolcpus "."
-	if [[ $? -ne 0 ]]
-	then
-		echo "Unexpected isolated CPUs: $ISOLCPUS"
-		dump_states
-		exit 1
-	fi
+	# Retry a few times before printing error
+	RETRY=0
+	while [[ $RETRY -lt 5 ]]
+	do
+		pause 0.01
+		check_isolcpus "."
+		[[ $? -eq 0 ]] && return 0
+		((RETRY++))
+	done
+	echo "Unexpected isolated CPUs: $ISOLCPUS"
+	dump_states
+	exit 1
 }
 
 #
@@ -776,7 +780,7 @@ run_state_test()
 		#
 		NEWLIST=$(cat cpuset.cpus.effective)
 		RETRY=0
-		while [[ $NEWLIST != $CPULIST && $RETRY -lt 5 ]]
+		while [[ $NEWLIST != $CPULIST && $RETRY -lt 8 ]]
 		do
 			# Wait a bit longer & recheck a few times
 			pause 0.01
-- 
2.39.3


