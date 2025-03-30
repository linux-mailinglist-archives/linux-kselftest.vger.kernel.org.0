Return-Path: <linux-kselftest+bounces-29937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5686A75CEF
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F39188AD0B
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98CC1E5B66;
	Sun, 30 Mar 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUh1arbT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F521E521F
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371649; cv=none; b=f81HxswEYX3ghB1OdX5FEISZkejBiDsW4d0rCEs4rZz8oG2iIPcoAxqfC1VTfnteA2AhBn5kTFcxPgdwRgSVr7GlGToomas7i6vFw4dk2HgINtj6A6BowDCaftnbWb9rTmNSi9HWrBehWDM9G4RYKVPrvCTK3PKPOXq9qDFdhaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371649; c=relaxed/simple;
	bh=kctpo9J9KWhQO+Td/9xcOa96QG1Xvi2mfONXtYgkJZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNcE01aFW7DFa3R2vOwV9fZVoaz/DeTNlqIbYEkdR1Z4hdKl6AB5nUyd+p7x4yf2YSEgZqzgwqU1EjJ8uVSttKeuIGj/tyYfBl9IuR3VHwJsSqCEcONfdR126TNVv6TqMzk+lNHOFuZ9xGdM99/EnH4sg2yJ+KNhrOlXUzlgjbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUh1arbT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d/gln7HjCzS4EQxgvfxBgXSkSYvBREZLHgr/rHkeCk0=;
	b=FUh1arbT175MBSx6Xr8Vc6mrnrEmuJjPuMPsGv+Po3Ial3rJOcJccKzA+Hu/kqKa0HF6MK
	8c0xS6mwr7k9x3xsMXJUwRVoJvzi//vXmttV27IBcxQZFSOngcQsvB/7EM21TzCEk5CKmk
	hz4fd9oKSVsgosm8wzmFsC41HbNdIlo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-lKli_u7eMzuI_oQrxX44Cw-1; Sun,
 30 Mar 2025 17:54:02 -0400
X-MC-Unique: lKli_u7eMzuI_oQrxX44Cw-1
X-Mimecast-MFC-AGG-ID: lKli_u7eMzuI_oQrxX44Cw_1743371641
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1AF118EBE88;
	Sun, 30 Mar 2025 21:54:00 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 60C0C1801750;
	Sun, 30 Mar 2025 21:53:59 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 10/10] selftest/cgroup: Add a remote partition transition test to test_cpuset_prs.sh
Date: Sun, 30 Mar 2025 17:52:48 -0400
Message-ID: <20250330215248.3620801-11-longman@redhat.com>
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

The current cgroup directory layout for running the partition state
transition tests is mainly suitable for testing local partitions as
well as with a mix of local and remote partitions. It is not that
suitable for doing extensive remote partition and nested remote/local
partition testing.

Add a new set of remote partition tests REMOTE_TEST_MATRIX with another
cgroup directory structure more tailored for remote partition testing
to provide better code coverage.

Also add a few new test cases as well as adjusting existig ones for
the original TEST_MATRIX.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 154 ++++++++++++++++--
 1 file changed, 143 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index d99412e7d196..a17256d9f88a 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -112,6 +112,8 @@ cleanup()
 	online_cpus
 	cd $CGROUP2
 	rmdir A1/A2/A3 A1/A2 A1 B1 test/A1 test/B1 test > /dev/null 2>&1
+	rmdir rtest/p1/c11 rtest/p1/c12 rtest/p2/c21 \
+	      rtest/p2/c22 rtest/p1 rtest/p2 rtest > /dev/null 2>&1
 	[[ -n "$SCHED_DEBUG" ]] &&
 		echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
 }
@@ -223,9 +225,9 @@ TEST_MATRIX=(
 	"  C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
 	"   C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
 	"   C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
-	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1|A2:2-3"
-	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1|A2:2-3"
-	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:|A2:3 A1:P1|A2:P1"
+	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1|A2:2-3|XA2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1|A2:2-3|XA2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:|A2:3|XA2:3 A1:P1|A2:P1"
 	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3|A2:3 A1:P1|A2:P0"
 	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4|A2:2"
 	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:|B1:0-2 A1:P1|A2:P1"
@@ -291,7 +293,7 @@ TEST_MATRIX=(
 								       A1:P0|A2:P2|A3:P1 2"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4|A2:1-4|A3:2-4 \
-								       A1:P0|A2:P-2|A3:P-1"
+								       A1:P0|A2:P-2|A3:P-1 ."
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1|A2:2-4|A3:2-4 \
 								       A1:P0|A2:P2|A3:P-1 2-4"
@@ -303,13 +305,13 @@ TEST_MATRIX=(
 	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2|A2:1-2|A3:1-2 A1:P0|A3:P-2 3|"
 
 	# An invalidated remote partition cannot self-recover from hotplug
-	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2"
+	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3|A2:1-3|A3:2 A1:P0|A3:P-2 ."
 
 	# cpus.exclusive.effective clearing test
 	" C0-3:S+ C1-3:S+  C2      .   X2-3:X    .      .      .     0 A1:0-3|A2:1-3|A3:2|XA1:"
 
 	# Invalid to valid remote partition transition test
-	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3|A2:1-3|XA2: A2:P-2"
+	" C0-3:S+   C1-3    .      .      .    X3:P2    .      .     0 A1:0-3|A2:1-3|XA2: A2:P-2 ."
 	" C0-3:S+ C1-3:X3:P2
 			    .      .    X2-3    P2      .      .     0 A1:0-2|A2:3|XA2:3 A2:P2 3"
 
@@ -318,7 +320,6 @@ TEST_MATRIX=(
 	" C1-3:S+:P2 X4:P2  .      .      .    X3:P2    .      .     0 A1:1-2|XA1:1-3|A2:3:XA2:3 A1:P2|A2:P2 1-3"
 	"  C0-3:P2   .      .    C4-6   C0-4     .      .      .     0 A1:0-4|B1:4-6 A1:P-2|B1:P0"
 	"  C0-3:P2   .      .    C4-6 C0-4:C0-3  .      .      .     0 A1:0-3|B1:4-6 A1:P2|B1:P0 0-3"
-	"  C0-3:P2   .      .  C3-5:C4-5  .      .      .      .     0 A1:0-3|B1:4-5 A1:P2|B1:P0 0-3"
 
 	# Local partition invalidation tests
 	" C0-3:X1-3:S+:P2 C1-3:X2-3:S+:P2 C2-3:X3:P2 \
@@ -334,10 +335,10 @@ TEST_MATRIX=(
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .    X:C4     .      P2     .     0 A1:4|A2:4|XA2:|XA3:|A3:4 \
-								       A1:P0|A3:P-2"
+								       A1:P0|A3:P-2 ."
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .     X1      .      P2     .     0 A1:0-3|A2:1-3|XA1:1|XA2:|XA3:|A3:2-3 \
-								       A1:P0|A3:P-2"
+								       A1:P0|A3:P-2 ."
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .      .     X3      P2     .     0 A1:0-2|A2:1-2|XA2:3|XA3:3|A3:3 \
 								       A1:P0|A3:P2 3"
@@ -385,7 +386,7 @@ TEST_MATRIX=(
 	# A partition root with non-partition root parent is invalid| but it
 	# can be made valid if its parent becomes a partition root too.
 	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1|A2:1 A1:P0|A2:P-2"
-	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2"
+	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0|A2:1 A1:P1|A2:P2 0-1|1"
 
 	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
 	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2|B1:2-3 A1:P-1|B1:P0"
@@ -405,6 +406,17 @@ TEST_MATRIX=(
 	# affect cpuset.cpus.exclusive.effective.
 	" C1-4:X3:S+ C1:X3  .      .       .     C      .      .     0 A2:1-4|XA2:3"
 
+	# cpuset.cpus can contain CPUs that overlap a sibling cpuset with cpus.exclusive
+	# but creating a local partition out of it is not allowed. Similarly and change
+	# in cpuset.cpus of a local partition that overlaps sibling exclusive CPUs will
+	# invalidate it.
+	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6|XB1:5-6 \
+								       A1:P0|A2:P2:B1:P1 2-4"
+	" CX1-4:S+ CX2-4:P2 .    C3-6      .     .      .      P1    0 A1:1|A2:2-4|B1:5-6 \
+								       A1:P0|A2:P2:B1:P-1 2-4"
+	" CX1-4:S+ CX2-4:P2 .    C5-6      .     .      .   P1:C3-6  0 A1:1|A2:2-4|B1:5-6 \
+								       A1:P0|A2:P2:B1:P-1 2-4"
+
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
@@ -419,6 +431,54 @@ TEST_MATRIX=(
 	"   C0-3     .      .    C4-5   X3-5     .      .      .     1 A1:0-3|B1:4-5"
 )
 
+#
+# Cpuset controller remote partition test matrix.
+#
+# Cgroup test hierarchy
+#
+#	      root
+#	        |
+#	      rtest (cpuset.cpus.exclusive=1-7)
+#	        |
+#	 +------+------+
+#	 |             |
+#	 p1            p2
+#     +--+--+       +--+--+
+#     |     |       |     |
+#    c11   c12     c21   c22
+#
+# REMOTE_TEST_MATRIX uses the same notational convention as TEST_MATRIX.
+# Only CPUs 1-7 should be used.
+#
+REMOTE_TEST_MATRIX=(
+	#  old-p1 old-p2 old-c11 old-c12 old-c21 old-c22
+	#  new-p1 new-p2 new-c11 new-c12 new-c21 new-c22 ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------- ------- ------- ------- ----- ------ --------
+	" X1-3:S+ X4-6:S+ X1-2     X3     X4-5     X6 \
+	      .      .     P2      P2      P2      P2    c11:1-2|c12:3|c21:4-5|c22:6 \
+							 c11:P2|c12:P2|c21:P2|c22:P2 1-6"
+	" CX1-4:S+   .   X1-2:P2   C3      .       .  \
+	      .      .     .      C3-4     .       .     p1:3-4|c11:1-2|c12:3-4 \
+							 p1:P0|c11:P2|c12:P0 1-2"
+	" CX1-4:S+   .   X1-2:P2   .       .       .  \
+	    X2-4     .     .       .       .       .     p1:1,3-4|c11:2 \
+							 p1:P0|c11:P2 2"
+	" CX1-5:S+   .   X1-2:P2 X3-5:P1   .       .  \
+	    X2-4     .     .       .       .       .     p1:1,5|c11:2|c12:3-4 \
+							 p1:P0|c11:P2|c12:P1 2"
+	" CX1-4:S+   .   X1-2:P2 X3-4:P1   .       .  \
+	      .      .     X2      .       .       .     p1:1|c11:2|c12:3-4 \
+							 p1:P0|c11:P2|c12:P1 2"
+	# p1 as member, will get its effective CPUs from its parent rtest
+	" CX1-4:S+   .   X1-2:P2 X3-4:P1   .       .  \
+	      .      .     X1     CX2-4    .       .     p1:5-7|c11:1|c12:2-4 \
+							 p1:P0|c11:P2|c12:P1 1"
+	" CX1-4:S+ X5-6:P1:S+ .    .       .       .  \
+	      .      .   X1-2:P2  X4-5:P1  .     X1-7:P2 p1:3|c11:1-2|c12:4:c22:5-6 \
+							 p1:P0|p2:P1|c11:P2|c12:P1|c22:P2 \
+							 1-2,4-6|1-2,5-6"
+)
+
 #
 # Write to the cpu online file
 #  $1 - <c>=<v> where <c> = cpu number, <v> value to be written
@@ -902,10 +962,11 @@ run_state_test()
 		STATES=${11}
 		ICPUS=${12}
 
-		set_ctrl_state_noerr B1       $OLD_B1
 		set_ctrl_state_noerr A1       $OLD_A1
 		set_ctrl_state_noerr A1/A2    $OLD_A2
 		set_ctrl_state_noerr A1/A2/A3 $OLD_A3
+		set_ctrl_state_noerr B1       $OLD_B1
+
 		RETVAL=0
 		set_ctrl_state A1       $NEW_A1; ((RETVAL += $?))
 		set_ctrl_state A1/A2    $NEW_A2; ((RETVAL += $?))
@@ -920,6 +981,76 @@ run_state_test()
 	echo "All $I tests of $TEST PASSED."
 }
 
+#
+# Run cpuset remote partition state transition test
+#  $1 - test matrix name
+#
+run_remote_state_test()
+{
+	TEST=$1
+	CONTROLLER=cpuset
+	[[ -d rtest ]] || mkdir rtest
+	cd rtest
+	echo +cpuset > cgroup.subtree_control
+	echo "1-7" > cpuset.cpus
+	echo "1-7" > cpuset.cpus.exclusive
+	CGROUP_LIST=".. . p1 p2 p1/c11 p1/c12 p2/c21 p2/c22"
+	RESET_LIST="p1/c11 p1/c12 p2/c21 p2/c22 p1 p2"
+	I=0
+	eval CNT="\${#$TEST[@]}"
+
+	reset_cgroup_states
+	console_msg "Running remote partition state transition test ..."
+
+	while [[ $I -lt $CNT ]]
+	do
+		echo "Running test $I ..." > $CONSOLE
+		[[ $VERBOSE -gt 1 ]] && {
+			echo ""
+			eval echo \${$TEST[$I]}
+		}
+		eval set -- "\${$TEST[$I]}"
+		OLD_p1=$1
+		OLD_p2=$2
+		OLD_c11=$3
+		OLD_c12=$4
+		OLD_c21=$5
+		OLD_c22=$6
+		NEW_p1=$7
+		NEW_p2=$8
+		NEW_c11=$9
+		NEW_c12=${10}
+		NEW_c21=${11}
+		NEW_c22=${12}
+		ECPUS=${13}
+		STATES=${14}
+		ICPUS=${15}
+
+		set_ctrl_state_noerr p1     $OLD_p1
+		set_ctrl_state_noerr p2     $OLD_p2
+		set_ctrl_state_noerr p1/c11 $OLD_c11
+		set_ctrl_state_noerr p1/c12 $OLD_c12
+		set_ctrl_state_noerr p2/c21 $OLD_c21
+		set_ctrl_state_noerr p2/c22 $OLD_c22
+
+		RETVAL=0
+		set_ctrl_state p1     $NEW_p1 ; ((RETVAL += $?))
+		set_ctrl_state p2     $NEW_p2 ; ((RETVAL += $?))
+		set_ctrl_state p1/c11 $NEW_c11; ((RETVAL += $?))
+		set_ctrl_state p1/c12 $NEW_c12; ((RETVAL += $?))
+		set_ctrl_state p2/c21 $NEW_c21; ((RETVAL += $?))
+		set_ctrl_state p2/c22 $NEW_c22; ((RETVAL += $?))
+
+		[[ $RETVAL -ne 0 ]] && test_fail $I result
+
+		check_test_results $I "$ECPUS" "$STATES" "$ICPUS"
+		((I++))
+	done
+	cd ..
+	rmdir rtest
+	echo "All $I tests of $TEST PASSED."
+}
+
 #
 # Testing the new "isolated" partition root type
 #
@@ -1056,6 +1187,7 @@ test_inotify()
 
 trap cleanup 0 2 3 6
 run_state_test TEST_MATRIX
+run_remote_state_test REMOTE_TEST_MATRIX
 test_isolated
 test_inotify
 echo "All tests PASSED."
-- 
2.48.1


