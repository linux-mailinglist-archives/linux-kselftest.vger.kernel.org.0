Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D638573F008
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 02:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjF0A7Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 26 Jun 2023 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjF0A7I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 26 Jun 2023 20:59:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0641FC8
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Jun 2023 17:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687827372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E6YHVyNv9jllDW5EgfHaZ/VxsLpfT00bCuAF1yM8w0Q=;
        b=Zl5PUoZijY6OQyUUqV5Rm1eSmiKjXfkgE0EfRwoFqpyRxuMkVVU8mY3EVHVyJMaxTDZa7R
        /EkjGKJz9hEf9PHPTxnJi53Kmz3UCwHFUxZ1e6drVpSX0yv2Ns5ueWn7/KQnrQ1l/CmNT9
        6Z2Xqs3Ez7/w8bNwNb9CXLTDbHa9kdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-354-PUu6twrkOO6E8zMAzzUyTg-1; Mon, 26 Jun 2023 20:56:07 -0400
X-MC-Unique: PUu6twrkOO6E8zMAzzUyTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1D85891F21;
        Tue, 27 Jun 2023 00:56:06 +0000 (UTC)
Received: from llong.com (unknown [10.22.33.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC4F32166B25;
        Tue, 27 Jun 2023 00:56:05 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3 9/9] cgroup/cpuset: Extend test_cpuset_prs.sh to test remote partition
Date:   Mon, 26 Jun 2023 20:55:29 -0400
Message-Id: <20230627005529.1564984-10-longman@redhat.com>
In-Reply-To: <20230627005529.1564984-1-longman@redhat.com>
References: <20230627005529.1564984-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch extends the test_cpuset_prs.sh test script to support testing
the new remote partition and use the new "cpuset.cpus.exclusive" file
by adding new tests for them. In addition, the following changes are
also made:

 1) Run the state transition tests directly under root to ease testing
    of remote partition and remove the unneeded test column.
 2) Add a column to for the list of expected isolated CPUs and compare
    it with the actual value by looking at the state of
    /sys/kernel/debug/sched/domains which will be available if the
    verbose flag is set.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 398 ++++++++++++------
 1 file changed, 259 insertions(+), 139 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 2b5215cc599f..ace992d1ed9e 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -3,7 +3,7 @@
 #
 # Test for cpuset v2 partition root state (PRS)
 #
-# The sched verbose flag is set, if available, so that the console log
+# The sched verbose flag can be optionally set so that the console log
 # can be examined for the correct setting of scheduling domain.
 #
 
@@ -22,27 +22,27 @@ WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
 # Find cgroup v2 mount point
 CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
 [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
+SUBPARTS_CPUS=$CGROUP2/.__DEBUG__.cpuset.cpus.subpartitions
+CPULIST=$(cat $CGROUP2/cpuset.cpus.effective)
 
-CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
-[[ $CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
+NR_CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
+[[ $NR_CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
 
 # Set verbose flag and delay factor
 PROG=$1
-VERBOSE=
+VERBOSE=0
 DELAY_FACTOR=1
 SCHED_DEBUG=
 while [[ "$1" = -* ]]
 do
 	case "$1" in
-		-v) VERBOSE=1
+		-v) ((VERBOSE++))
 		    # Enable sched/verbose can slow thing down
 		    [[ $DELAY_FACTOR -eq 1 ]] &&
 			DELAY_FACTOR=2
-		    break
 		    ;;
 		-d) DELAY_FACTOR=$2
 		    shift
-		    break
 		    ;;
 		*)  echo "Usage: $PROG [-v] [-d <delay-factor>"
 		    exit
@@ -52,7 +52,7 @@ do
 done
 
 # Set sched verbose flag if available when "-v" option is specified
-if [[ -n "$VERBOSE" && -d /sys/kernel/debug/sched ]]
+if [[ $VERBOSE -gt 0 && -d /sys/kernel/debug/sched ]]
 then
 	# Used to restore the original setting during cleanup
 	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
@@ -61,14 +61,26 @@ fi
 
 cd $CGROUP2
 echo +cpuset > cgroup.subtree_control
+
+#
+# If cpuset has been set up and used in child cgroups, we may not be able to
+# create partition under root cgroup because of the CPU exclusivity rule.
+# So we are going to skip the test if this is the case.
+#
 [[ -d test ]] || mkdir test
-cd test
+echo 0-6 > test/cpuset.cpus
+echo root > test/cpuset.cpus.partition
+cat test/cpuset.cpus.partition | grep -q invalid
+RESULT=$?
+echo member > test/cpuset.cpus.partition
+echo "" > test/cpuset.cpus
+[[ $RESULT -eq 0 ]] && skip_test "Child cgroups are using cpuset!"
 
 cleanup()
 {
 	online_cpus
+	cd $CGROUP2
 	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
-	cd ..
 	rmdir test > /dev/null 2>&1
 	[[ -n "$SCHED_DEBUG" ]] &&
 		echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
@@ -103,7 +115,7 @@ test_partition()
 	[[ $? -eq 0 ]] || exit 1
 	ACTUAL_VAL=$(cat cpuset.cpus.partition)
 	[[ $ACTUAL_VAL != $EXPECTED_VAL ]] && {
-		echo "cpuset.cpus.partition: expect $EXPECTED_VAL, found $EXPECTED_VAL"
+		echo "cpuset.cpus.partition: expect $EXPECTED_VAL, found $ACTUAL_VAL"
 		echo "Test FAILED"
 		exit 1
 	}
@@ -114,7 +126,7 @@ test_effective_cpus()
 	EXPECTED_VAL=$1
 	ACTUAL_VAL=$(cat cpuset.cpus.effective)
 	[[ "$ACTUAL_VAL" != "$EXPECTED_VAL" ]] && {
-		echo "cpuset.cpus.effective: expect '$EXPECTED_VAL', found '$EXPECTED_VAL'"
+		echo "cpuset.cpus.effective: expect '$EXPECTED_VAL', found '$ACTUAL_VAL'"
 		echo "Test FAILED"
 		exit 1
 	}
@@ -139,6 +151,7 @@ test_add_proc()
 #
 test_isolated()
 {
+	cd $CGROUP2/test
 	echo 2-3 > cpuset.cpus
 	TYPE=$(cat cpuset.cpus.partition)
 	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
@@ -203,125 +216,163 @@ test_isolated()
 #
 # Cgroup test hierarchy
 #
-# test -- A1 -- A2 -- A3
-#      \- B1
+# root -- A1 -- A2 -- A3
+#      +- B1
 #
-#  P<v> = set cpus.partition (0:member, 1:root, 2:isolated, -1:root invalid)
+#  P<v> = set cpus.partition (0:member, 1:root, 2:isolated)
 #  C<l> = add cpu-list
 #  S<p> = use prefix in subtree_control
 #  T    = put a task into cgroup
-#  O<c>-<v> = Write <v> to CPU online file of <c>
+#  O<c>=<v> = Write <v> to CPU online file of <c>
 #
 SETUP_A123_PARTITIONS="C1-3:P1:S+ C2-3:P1:S+ C3:P1"
 TEST_MATRIX=(
-	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
-	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
-	"  S+    C0-1     .      .    C2-3    S+    C4-5     .      .     0 A2:0-1"
-	"  S+    C0-1     .      .    C2-3    P1      .      .      .     0 "
-	"  S+    C0-1     .      .    C2-3   P1:S+ C0-1:P1   .      .     0 "
-	"  S+    C0-1     .      .    C2-3   P1:S+  C1:P1    .      .     0 "
-	"  S+   C0-1:S+   .      .    C2-3     .      .      .     P1     0 "
-	"  S+   C0-1:P1   .      .    C2-3    S+     C1      .      .     0 "
-	"  S+   C0-1:P1   .      .    C2-3    S+    C1:P1    .      .     0 "
-	"  S+   C0-1:P1   .      .    C2-3    S+    C1:P1    .     P1     0 "
-	"  S+   C0-1:P1   .      .    C2-3   C4-5     .      .      .     0 A1:4-5"
-	"  S+   C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
-	"  S+    C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
-	"  S+    C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1,A2:2-3"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1,A2:2-3"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3,A2:3 A1:P1,A2:P0"
-	"  S+ C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4,A2:2"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:,B1:0-2 A1:P1,A2:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
+	"   C0-1     .      .    C2-3    S+    C4-5     .      .     0 A2:0-1"
+	"   C0-1     .      .    C2-3    P1      .      .      .     0 "
+	"   C0-1     .      .    C2-3   P1:S+ C0-1:P1   .      .     0 "
+	"   C0-1     .      .    C2-3   P1:S+  C1:P1    .      .     0 "
+	"  C0-1:S+   .      .    C2-3     .      .      .     P1     0 "
+	"  C0-1:P1   .      .    C2-3    S+     C1      .      .     0 "
+	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .      .     0 "
+	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .     P1     0 "
+	"  C0-1:P1   .      .    C2-3   C4-5     .      .      .     0 A1:4-5"
+	"  C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     0 A1:4-5"
+	"   C0-1     .      .   C2-3:P1   .      .      .     C2     0 "
+	"   C0-1     .      .   C2-3:P1   .      .      .    C4-5    0 B1:4-5"
+	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     0 A1:0-1,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     0 A1:1,A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     0 A1:3,A2:3 A1:P1,A2:P0"
+	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     0 A1:3-4,A2:2"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   0 A1:,B1:0-2 A1:P1,A2:P1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
 
 	# CPU offlining cases:
-	"  S+    C0-1     .      .    C2-3    S+    C4-5     .     O2-0   0 A1:0-1,B1:3"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O2-0    .      .      .     0 A1:0-1,A2:3"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O2-0   O2-1    .      .     0 A1:0-1,A2:2-3"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O1-0    .      .      .     0 A1:0,A2:2-3"
-	"  S+ C0-3:P1:S+ C2-3:P1 .      .     O1-0   O1-1    .      .     0 A1:0-1,A2:2-3"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     O3-0   O3-1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
-	"  S+ C2-3:P1:S+  C3:P2  .      .     O3-0   O3-1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     O2-0   O2-1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
-	"  S+ C2-3:P1:S+  C3:P2  .      .     O2-0   O2-1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     O2-0    .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
-	"  S+ C2-3:P1:S+  C3:P1  .      .     O3-0    .      .      .     0 A1:2,A2: A1:P1,A2:P1"
-	"  S+ C2-3:P1:S+  C3:P1  .      .    T:O2-0   .      .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
-	"  S+ C2-3:P1:S+  C3:P1  .      .      .    T:O3-0   .      .     0 A1:2,A2:2 A1:P1,A2:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .     O1-0    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .     O2-0    .      .      .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .     O3-0    .      .      .     0 A1:1,A2:2,A3: A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .      .    T:O2-0   .      .     0 A1:1,A2:3,A3:3 A1:P1,A2:P1,A3:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .      .      .    T:O3-0   .     0 A1:1,A2:2,A3:2 A1:P1,A2:P1,A3:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O1-1    .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .      .    T:O2-0  O2-1    .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .      .      .    T:O3-0  O3-1   0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O2-0   O1-1    .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:O1-0  O2-0   O2-1    .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-
-	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
-	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   0 A1:0-1,B1:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     0 A1:0-1,A2:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     0 A1:0-1,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0    .      .      .     0 A1:0,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0   O1=1    .      .     0 A1:0-1,A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0   O3=1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O3=0   O3=1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0   O2=1    .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     0 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     0 A1:2,A2: A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     0 A1:2,A2:2 A1:P1,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     0 A1:1,A2:2,A3: A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0   .      .     0 A1:1,A2:3,A3:3 A1:P1,A2:P1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0   .     0 A1:1,A2:2,A3:2 A1:P1,A2:P1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O1=1    .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0  O2=1    .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0  O3=1   0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O1=1    .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O2=1    .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
+	#
+	# Remote partition and cpuset.cpus.exclusive tests
+	#
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3     .      .      .     0 A1:0-3,A2:1-3,A3:2-3,XA1:2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3  X2-3:P2   .      .     0 A1:0-1,A2:2-3,A3:2-3 A1:P0,A2:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X3:P2    .      .     0 A1:0-2,A2:3,A3:3 A1:P0,A2:P2 3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3  X2-3:P2   .     0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:C3 .     0 A1:0-2,A2:1-2,A3:3 A1:P0,A3:P2 3"
+	" C0-3:S+ C1-3:S+ C2-3   C2-3     .      .      .      P2    0 A1:0-3,A2:1-3,A3:2-3,B1:2-3 A1:P0,A3:P0,B1:P-2"
+	" C0-3:S+ C1-3:S+ C2-3   C4-5     .      .      .      P2    0 B1:4-5 B1:P2 4-5"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2   P2    0 A3:2-3,B1:4 A3:P2,B1:P2 2-4"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3 X2-3:P2:C1-3 P2  0 A3:2-3,B1:4 A3:P2,B1:P2 2-4"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X1-3  X1-3:P2   P2     .     0 A2:1,A3:2-3 A2:P2,A3:P2 1-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3   X2-3  X2-3:P2 P2:C4-5 0 A3:2-3,B1:4-5 A3:P2,B1:P2 2-5"
+
+	# Nested remote/local partition tests
+	" C0-3:S+ C1-3:S+ C2-3   C4-5   X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4-5 \
+								       A1:P0,A2:P1,A3:P2,B1:P1 2-3"
+	" C0-3:S+ C1-3:S+ C2-3    C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:,A3:2-3,B1:4 \
+								       A1:P0,A2:P1,A3:P2,B1:P1 2-4"
+	" C0-3:S+ C1-3:S+  C3     C4    X2-3  X2-3:P1   P2     P1    0 A1:0-1,A2:2,A3:3,B1:4 \
+								       A1:P0,A2:P1,A3:P2,B1:P1 2-4"
+
+	# Remote partition offline tests
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 .   0 A1:0-1,A2:1,A3:3 A1:P0,A3:P2 2-3"
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-3   X2-3 X2-3:P2:O2=0 O2=1 0 A1:0-1,A2:1,A3:2-3 A1:P0,A3:P2 2-3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3    P2:O3=0   .   0 A1:0-2,A2:1-2,A3: A1:P0,A3:P2 3"
+	" C0-3:S+ C1-3:S+  C3      .    X2-3   X2-3   T:P2:O3=0  .   0 A1:0-2,A2:1-2,A3:1-2 A1:P0,A3:P-2 3"
+
+	# An invalidated remote partition cannot self-recover from hotplug
+	" C0-3:S+ C1-3:S+  C2      .    X2-3   X2-3   T:P2:O2=0 O2=1 0 A1:0-3,A2:1-3,A3:2 A1:P0,A3:P-2"
+
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	#
 	# Incorrect change to cpuset.cpus invalidates partition root
 	#
 	# Adding CPUs to partition root that are not in parent's
 	# cpuset.cpus is allowed, but those extra CPUs are ignored.
-	"  S+ C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:,A2:2-3 A1:P1,A2:P1"
+	"C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:,A2:2-3 A1:P1,A2:P1"
 
 	# Taking away all CPUs from parent or itself if there are tasks
 	# will make the partition invalid.
-	"  S+ C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
-	"  S+  C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
+	" C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
 
 	# Changing a partition root to member makes child partitions invalid
-	"  S+ C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
 
 	# cpuset.cpus can contains cpus not in parent's cpuset.cpus as long
 	# as they overlap.
-	"  S+ C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2,A2:3 A1:P1,A2:P1"
 
 	# Deletion of CPUs distributed to child cgroup is allowed.
-	"  S+ C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5,A2:4-5"
+	"C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5,A2:4-5"
 
 	# To become a valid partition root, cpuset.cpus must overlap parent's
 	# cpuset.cpus.
-	"  S+   C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1,A2:0-1 A1:P1,A2:P-1"
+	"  C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1,A2:0-1 A1:P1,A2:P-1"
 
 	# Enabling partition with child cpusets is allowed
-	"  S+   C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1,A2:1 A1:P1"
+	"  C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1,A2:1 A1:P1"
 
 	# A partition root with non-partition root parent is invalid, but it
 	# can be made valid if its parent becomes a partition root too.
-	"  S+   C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1,A2:1 A1:P0,A2:P-2"
-	"  S+   C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0,A2:1 A1:P1,A2:P2"
+	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1,A2:1 A1:P0,A2:P-2"
+	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0,A2:1 A1:P1,A2:P2"
 
 	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
-	"  S+   C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P0"
-	"  S+   C0-1:P1   .      .  P1:C2-3  C0-2   .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P-1"
-	"  S+    C0-1     .      .  P1:C2-3  C0-2   .      .      .     0 A1:0-2,B1:2-3 A1:P0,B1:P-1"
+	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P0"
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P-1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P0,B1:P-1"
 
-	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
-	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
 	# Failure cases:
 
 	# A task cannot be added to a partition with no cpu
-	"  S+ C2-3:P1:S+  C3:P1  .      .    O2-0:T   .      .      .     1 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    O2=0:T   .      .      .     1 A1:,A2:3 A1:P1,A2:P1"
+
+	# cpuset.cpus.exclusive must be a subset of cpuset.cpus & parent's cpuset.cpus.exclusive
+	" C0-3:S+ C1-3:S+ C2-3     .    X2-4     .      .      .     1"
+	" C0-3:S+ C1-3:S+ C2-3     .    X1-2   X2-3     .      .     1"
 )
 
 #
 # Write to the cpu online file
-#  $1 - <c>-<v> where <c> = cpu number, <v> value to be written
+#  $1 - <c>=<v> where <c> = cpu number, <v> value to be written
 #
 write_cpu_online()
 {
-	CPU=${1%-*}
-	VAL=${1#*-}
+	CPU=${1%=*}
+	VAL=${1#*=}
 	CPUFILE=//sys/devices/system/cpu/cpu${CPU}/online
 	if [[ $VAL -eq 0 ]]
 	then
@@ -349,11 +400,12 @@ set_ctrl_state()
 	TMPMSG=/tmp/.msg_$$
 	CGRP=$1
 	STATE=$2
-	SHOWERR=${3}${VERBOSE}
+	SHOWERR=${3}
 	CTRL=${CTRL:=$CONTROLLER}
 	HASERR=0
 	REDIRECT="2> $TMPMSG"
 	[[ -z "$STATE" || "$STATE" = '.' ]] && return 0
+	[[ $VERBOSE -gt 0 ]] && SHOWERR=1
 
 	rm -f $TMPMSG
 	for CMD in $(echo $STATE | sed -e "s/:/ /g")
@@ -362,12 +414,18 @@ set_ctrl_state()
 		SFILE=$CGRP/cgroup.subtree_control
 		PFILE=$CGRP/cpuset.cpus.partition
 		CFILE=$CGRP/cpuset.cpus
+		XFILE=$CGRP/cpuset.cpus.exclusive
 		S=$(expr substr $CMD 1 1)
 		if [[ $S = S ]]
 		then
 			PREFIX=${CMD#?}
 			COMM="echo ${PREFIX}${CTRL} > $SFILE"
 			eval $COMM $REDIRECT
+		elif [[ $S = X ]]
+		then
+			CPUS=${CMD#?}
+			COMM="echo $CPUS > $XFILE"
+			eval $COMM $REDIRECT
 		elif [[ $S = C ]]
 		then
 			CPUS=${CMD#?}
@@ -430,7 +488,7 @@ online_cpus()
 	[[ -n "OFFLINE_CPUS" ]] && {
 		for C in $OFFLINE_CPUS
 		do
-			write_cpu_online ${C}-1
+			write_cpu_online ${C}=1
 		done
 	}
 }
@@ -443,18 +501,25 @@ reset_cgroup_states()
 	echo 0 > $CGROUP2/cgroup.procs
 	online_cpus
 	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
-	set_ctrl_state . S-
+	pause 0.02
+	set_ctrl_state . R-
 	pause 0.01
 }
 
 dump_states()
 {
-	for DIR in A1 A1/A2 A1/A2/A3 B1
+	for DIR in . A1 A1/A2 A1/A2/A3 B1
 	do
+		CPUS=$DIR/cpuset.cpus
 		ECPUS=$DIR/cpuset.cpus.effective
+		XCPUS=$DIR/cpuset.cpus.exclusive
 		PRS=$DIR/cpuset.cpus.partition
+		PCPUS=$DIR/.__DEBUG__.cpuset.cpus.subpartitions
+		[[ -e $CPUS  ]] && echo "$CPUS: $(cat $CPUS)"
+		[[ -e $XCPUS ]] && echo "$XCPUS: $(cat $XCPUS)"
 		[[ -e $ECPUS ]] && echo "$ECPUS: $(cat $ECPUS)"
 		[[ -e $PRS   ]] && echo "$PRS: $(cat $PRS)"
+		[[ -e $PCPUS ]] && echo "$PCPUS: $(cat $PCPUS)"
 	done
 }
 
@@ -470,11 +535,17 @@ check_effective_cpus()
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
 		CPUS=$2
+		if [[ $CGRP = X* ]]
+		then
+			CGRP=${CGRP#X}
+			FILE=cpuset.cpus.exclusive
+		else
+			FILE=cpuset.cpus.effective
+		fi
 		[[ $CGRP = A2 ]] && CGRP=A1/A2
 		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
-		FILE=$CGRP/cpuset.cpus.effective
-		[[ -e $FILE ]] || return 1
-		[[ $CPUS = $(cat $FILE) ]] || return 1
+		[[ -e $CGRP/$FILE ]] || return 1
+		[[ $CPUS = $(cat $CGRP/$FILE) ]] || return 1
 	done
 }
 
@@ -524,6 +595,64 @@ check_cgroup_states()
 	return 0
 }
 
+#
+# Get isolated (including offline) CPUs by looking at
+# /sys/kernel/debug/sched/domains and compare that with the expected value.
+#
+# Note that a sched domain of just 1 CPU will be considered isolated.
+#
+# $1 - expected isolated cpu list
+#
+check_isolcpus()
+{
+	EXPECT_VAL=$1
+	ISOLCPUS=
+	LASTISOLCPU=
+	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
+	[[ -d $SCHED_DOMAINS ]] || return
+
+	for ((CPU=0; CPU < $NR_CPUS; CPU++))
+	do
+		[[ -n "$(ls ${SCHED_DOMAINS}/cpu$CPU)" ]] && continue
+
+		if [[ -z "$LASTISOLCPU" ]]
+		then
+			ISOLCPUS=$CPU
+			LASTISOLCPU=$CPU
+		elif [[ "$LASTISOLCPU" -eq $((CPU - 1)) ]]
+		then
+			echo $ISOLCPUS | grep -q "\<$LASTISOLCPU\$"
+			if [[ $? -eq 0 ]]
+			then
+				ISOLCPUS=${ISOLCPUS}-
+			fi
+			LASTISOLCPU=$CPU
+		else
+			if [[ $ISOLCPUS = *- ]]
+			then
+				ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
+			fi
+			ISOLCPUS=${ISOLCPUS},$CPU
+			LASTISOLCPU=$CPU
+		fi
+	done
+	[[ "$ISOLCPUS" = *- ]] && ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
+	[[ $EXPECT_VAL = $ISOLCPUS ]]
+}
+
+test_fail()
+{
+	TESTNUM=$1
+	TESTTYPE=$2
+	ADDINFO=$3
+	echo "Test $TEST[$TESTNUM] failed $TESTTYPE check!"
+	[[ -n "$ADDINFO" ]] && echo "*** $ADDINFO ***"
+	eval echo \"\${$TEST[$I]}\"
+	echo
+	dump_states
+	exit 1
+}
+
 #
 # Run cpuset state transition test
 #  $1 - test matrix name
@@ -536,88 +665,80 @@ run_state_test()
 {
 	TEST=$1
 	CONTROLLER=cpuset
-	CPULIST=0-6
 	I=0
 	eval CNT="\${#$TEST[@]}"
 
 	reset_cgroup_states
-	echo $CPULIST > cpuset.cpus
-	echo root > cpuset.cpus.partition
 	console_msg "Running state transition test ..."
 
 	while [[ $I -lt $CNT ]]
 	do
 		echo "Running test $I ..." > /dev/console
+		[[ $VERBOSE -gt 1 ]] && {
+			echo ""
+			eval echo \"\${$TEST[$I]}\"
+		}
 		eval set -- "\${$TEST[$I]}"
-		ROOT=$1
-		OLD_A1=$2
-		OLD_A2=$3
-		OLD_A3=$4
-		OLD_B1=$5
-		NEW_A1=$6
-		NEW_A2=$7
-		NEW_A3=$8
-		NEW_B1=$9
-		RESULT=${10}
-		ECPUS=${11}
-		STATES=${12}
-
-		set_ctrl_state_noerr .        $ROOT
+		OLD_A1=$1
+		OLD_A2=$2
+		OLD_A3=$3
+		OLD_B1=$4
+		NEW_A1=$5
+		NEW_A2=$6
+		NEW_A3=$7
+		NEW_B1=$8
+		RESULT=$9
+		ECPUS=${10}
+		STATES=${11}
+		ICPUS=${12}
+
+		set_ctrl_state_noerr B1       $OLD_B1
 		set_ctrl_state_noerr A1       $OLD_A1
 		set_ctrl_state_noerr A1/A2    $OLD_A2
 		set_ctrl_state_noerr A1/A2/A3 $OLD_A3
-		set_ctrl_state_noerr B1       $OLD_B1
 		RETVAL=0
 		set_ctrl_state A1       $NEW_A1; ((RETVAL += $?))
 		set_ctrl_state A1/A2    $NEW_A2; ((RETVAL += $?))
 		set_ctrl_state A1/A2/A3 $NEW_A3; ((RETVAL += $?))
 		set_ctrl_state B1       $NEW_B1; ((RETVAL += $?))
 
-		[[ $RETVAL -ne $RESULT ]] && {
-			echo "Test $TEST[$I] failed result check!"
-			eval echo \"\${$TEST[$I]}\"
-			dump_states
-			exit 1
-		}
+		[[ $RETVAL -ne $RESULT ]] && test_fail $I result
 
 		[[ -n "$ECPUS" && "$ECPUS" != . ]] && {
 			check_effective_cpus $ECPUS
-			[[ $? -ne 0 ]] && {
-				echo "Test $TEST[$I] failed effective CPU check!"
-				eval echo \"\${$TEST[$I]}\"
-				echo
-				dump_states
-				exit 1
-			}
+			[[ $? -ne 0 ]] && test_fail $I "effective CPU"
 		}
 
-		[[ -n "$STATES" ]] && {
+		[[ -n "$STATES" && "$STATES" != . ]] && {
 			check_cgroup_states $STATES
-			[[ $? -ne 0 ]] && {
-				echo "FAILED: Test $TEST[$I] failed states check!"
-				eval echo \"\${$TEST[$I]}\"
-				echo
-				dump_states
-				exit 1
-			}
+			[[ $? -ne 0 ]] && test_fail $I states
 		}
 
+		# Compare the expected isolated CPUs with the actual ones,
+		# if available
+		[[ -n "$ICPUS" ]] && {
+			check_isolcpus $ICPUS
+			[[ $? -ne 0 ]] && test_fail $I "isolated CPU" \
+				"Expect $ICPUS, get $ISOLCPUS instead"
+		}
 		reset_cgroup_states
 		#
 		# Check to see if effective cpu list changes
 		#
-		pause 0.05
 		NEWLIST=$(cat cpuset.cpus.effective)
+		[[ $NEWLIST != $CPULIST ]] && {
+			# Wait a bit longer & recheck
+			pause 0.05
+			NEWLIST=$(cat cpuset.cpus.effective)
+		}
 		[[ $NEWLIST != $CPULIST ]] && {
 			echo "Effective cpus changed to $NEWLIST after test $I!"
 			exit 1
 		}
-		[[ -n "$VERBOSE" ]] && echo "Test $I done."
+		[[ $VERBOSE -gt 0 ]] && echo "Test $I done."
 		((I++))
 	done
 	echo "All $I tests of $TEST PASSED."
-
-	echo member > cpuset.cpus.partition
 }
 
 #
@@ -642,6 +763,7 @@ test_inotify()
 {
 	ERR=0
 	PRS=/tmp/.prs_$$
+	cd $CGROUP2/test
 	[[ -f $WAIT_INOTIFY ]] || {
 		echo "wait_inotify not found, inotify test SKIPPED."
 		return
@@ -655,7 +777,7 @@ test_inotify()
 	rm -f $PRS
 	wait_inotify $PWD/cpuset.cpus.partition $PRS &
 	pause 0.01
-	set_ctrl_state . "O1-0"
+	set_ctrl_state . "O1=0"
 	pause 0.01
 	check_cgroup_states ".:P-1"
 	if [[ $? -ne 0 ]]
@@ -689,5 +811,3 @@ run_state_test TEST_MATRIX
 test_isolated
 test_inotify
 echo "All tests PASSED."
-cd ..
-rmdir test
-- 
2.31.1

