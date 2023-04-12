Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF20F6DFA70
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 17:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjDLPjk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 11:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjDLPjc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 11:39:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4907AA3
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Apr 2023 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681313914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=TYyLfq2As+fc0Uoge64kIVDicWOz8EL9ZigxxkRReJc=;
        b=emenyxu+jCvPS1nMnnuraGzqd7BUzftd4n8/Ak/lgrraGQKcRBQo0IeF/Y/JbgvbQEO3qD
        8hBOCGAgJcdon1SNAyWrrBqsyRY1dMYq1vfH7NMZ75beHOS+n8nyu9cJ+UJniIcZJR65zW
        ZGo0TaPKlNBkgEf85h2zdcGC/ctCCCM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-269-EQUm72hbPgudMJkb7k-rIw-1; Wed, 12 Apr 2023 11:38:31 -0400
X-MC-Unique: EQUm72hbPgudMJkb7k-rIw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3A701C09514;
        Wed, 12 Apr 2023 15:38:30 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 410F540C6E70;
        Wed, 12 Apr 2023 15:38:30 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH 5/5] cgroup/cpuset: Extend test_cpuset_prs.sh to test isolcpus partition
Date:   Wed, 12 Apr 2023 11:37:58 -0400
Message-Id: <20230412153758.3088111-6-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch extends the test_cpuset_prs.sh test script to support testing
the new isolcpus partition by adding new tests for specifically for
isolcpus partition. In addition, the following changes are also made:

 1) Remove the first column of the TEST_MATRIX as it is always the same
    and so is redundant.
 2) Add a new C1 cgroup directory for testing and add that column to the
    TEST_MATRIX.
 3) Add support for the .__DEBUG__.cpuset.cpus.subpartitions file if
    "cgroup_debug" kernel boot option is specified and a new column
    into TEST_MATRIX for testing against this cgroup control file.
 4) Add another column to for the list of expected isolated CPUs and
    compare it with the actual value by looking at the state of
    /sys/kernel/debug/sched/domains.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 376 ++++++++++++------
 1 file changed, 258 insertions(+), 118 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 2b5215cc599f..7fa2bfe6c1c0 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -23,18 +23,18 @@ WAIT_INOTIFY=$(cd $(dirname $0); pwd)/wait_inotify
 CGROUP2=$(mount -t cgroup2 | head -1 | awk -e '{print $3}')
 [[ -n "$CGROUP2" ]] || skip_test "Cgroup v2 mount point not found!"
 
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
@@ -52,7 +52,7 @@ do
 done
 
 # Set sched verbose flag if available when "-v" option is specified
-if [[ -n "$VERBOSE" && -d /sys/kernel/debug/sched ]]
+if [[ $VERBOSE -gt 0 && -d /sys/kernel/debug/sched ]]
 then
 	# Used to restore the original setting during cleanup
 	SCHED_DEBUG=$(cat /sys/kernel/debug/sched/verbose)
@@ -103,7 +103,7 @@ test_partition()
 	[[ $? -eq 0 ]] || exit 1
 	ACTUAL_VAL=$(cat cpuset.cpus.partition)
 	[[ $ACTUAL_VAL != $EXPECTED_VAL ]] && {
-		echo "cpuset.cpus.partition: expect $EXPECTED_VAL, found $EXPECTED_VAL"
+		echo "cpuset.cpus.partition: expect $EXPECTED_VAL, found $ACTUAL_VAL"
 		echo "Test FAILED"
 		exit 1
 	}
@@ -114,7 +114,7 @@ test_effective_cpus()
 	EXPECTED_VAL=$1
 	ACTUAL_VAL=$(cat cpuset.cpus.effective)
 	[[ "$ACTUAL_VAL" != "$EXPECTED_VAL" ]] && {
-		echo "cpuset.cpus.effective: expect '$EXPECTED_VAL', found '$EXPECTED_VAL'"
+		echo "cpuset.cpus.effective: expect '$EXPECTED_VAL', found '$ACTUAL_VAL'"
 		echo "Test FAILED"
 		exit 1
 	}
@@ -204,124 +204,175 @@ test_isolated()
 # Cgroup test hierarchy
 #
 # test -- A1 -- A2 -- A3
-#      \- B1
+#      +- B1
+#      +- C1
 #
-#  P<v> = set cpus.partition (0:member, 1:root, 2:isolated, -1:root invalid)
+#  P<v> = set cpus.partition (0:member, 1:root, 2:isolated, 3: isolcpus)
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
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 new-C1 fail ECPUs Pstate PCPUS ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ ----- --------
+	"   C0-1     .      .    C2-3    S+    C4-5     .      .     .     0 A2:0-1"
+	"   C0-1     .      .    C2-3    P1      .      .      .     .     0 "
+	"   C0-1     .      .    C2-3   P1:S+ C0-1:P1   .      .     .     0 "
+	"   C0-1     .      .    C2-3   P1:S+  C1:P1    .      .     .     0 "
+	"  C0-1:S+   .      .    C2-3     .      .      .     P1     .     0 "
+	"  C0-1:P1   .      .    C2-3    S+     C1      .      .     .     0 "
+	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .      .     .     0 "
+	"  C0-1:P1   .      .    C2-3    S+    C1:P1    .     P1     .     0 "
+	"  C0-1:P1   .      .    C2-3   C4-5     .      .      .     .     0 A1:4-5"
+	"  C0-1:P1   .      .    C2-3  S+:C4-5   .      .      .     .     0 A1:4-5"
+	"   C0-1     .      .   C2-3:P1   .      .      .     C2     .     0 "
+	"   C0-1     .      .   C2-3:P1   .      .      .    C4-5    .     0 B1:4-5"
+	"C0-3:P1:S+ C2-3:P1 .      .      .      .      .      .     .     0 A1:0-1,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     C1-3    .      .      .     .     0 A1:1,A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .      .     .     0 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     C3      P0     .      .     .     0 A1:3,A2:3 A1:P1,A2:P0"
+	"C2-3:P1:S+  C2:P1  .      .     C2-4    .      .      .     .     0 A1:3-4,A2:2"
+	"C2-3:P1:S+  C3:P1  .      .     C3      .      .     C0-2   .     0 A1:,B1:0-2 A1:P1,A2:P1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    .      .      .     .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
 
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
+	"   C0-1     .      .    C2-3    S+    C4-5     .     O2=0   .     0 A1:0-1,B1:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0    .      .      .     .     0 A1:0-1,A2:3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O2=0   O2=1    .      .     .     0 A1:0-1,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0    .      .      .     .     0 A1:0,A2:2-3"
+	"C0-3:P1:S+ C2-3:P1 .      .     O1=0   O1=1    .      .     .     0 A1:0-1,A2:2-3"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0   O3=1    .      .     .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O3=0   O3=1    .      .     .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0   O2=1    .      .     .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P2  .      .     O2=0   O2=1    .      .     .     0 A1:2,A2:3 A1:P1,A2:P2"
+	"C2-3:P1:S+  C3:P1  .      .     O2=0    .      .      .     .     0 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .     O3=0    .      .      .     .     0 A1:2,A2: A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    T:O2=0   .      .      .     .     0 A1:3,A2:3 A1:P1,A2:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      .    T:O3=0   .      .     .     0 A1:2,A2:2 A1:P1,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     O1=0    .      .      .     .     0 A1:,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O2=0    .      .      .     .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .     O3=0    .      .      .     .     0 A1:1,A2:2,A3: A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0   .      .      .     .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0   .      .     .     0 A1:1,A2:3,A3:3 A1:P1,A2:P1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0   .     .     0 A1:1,A2:2,A3:2 A1:P1,A2:P1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O1=1    .      .     .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .    T:O2=0  O2=1    .     .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .      .      .    T:O3=0  O3=1   .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O1=1    .     .     0 A1:1,A2:,A3:3 A1:P1,A2:P1,A3:P1"
+	"$SETUP_A123_PARTITIONS    .    T:O1=0  O2=0   O2=1    .     .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 new-C1 fail ECPUs Pstate PCPUS ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ ----- --------
+	#
+	# isolcpus partition tests
+	#
+
+	# isolcpus partition can have empty cpuset.cpus & effective cpus
+	"     .      .      .     P3      .      .      .      .     .     0 B1: B1:P3"
+
+	# isolcpus partition is not exclusive
+	"   C1-2     .      .    C3:P3 C1-3:S+  C3      .      .     .     0 A1:1-2,A2:1-2,B1:3 B1:P3"
+	"   C1-3     .      .     C3      .      .      .     P3     .     0 A1:1-2,B1:3 B1:P3"
+
+	# Only 1 isolcpus partition is allowed
+	"     .      .      .    C3:P3  C1:P3    .      .      .     .     0 A1:1,B1:3 A1:P-3,B1:P3"
+
+	# Isolated partition can pull isolated cpus from isolcpus partition
+	"  C1-3:S+   C3     .    C3:P3    .     P2      .      .     .     0 A1:1-2,A2:3,B1: A2:P2,B1:P3 .:3,B1:3 3"
+	"  C1-3:S+   C3     .    C3:P3    .     P2      .    C2-3    .     0 A1:1,A2:3,B1:2  A2:P2,B1:P3 .:2-3,B1:3 2-3"
+
+	# Isolated partition becomes invalid if cpu update fails pulling
+	"  C1-3:S+   C3     .    C3:P3    .   P2:C2-3   .      .     .     0 A1:1-2,A2:2,B1:3 A2:P-2,B1:P3 .:3,B1: 3"
+	"  C1-3:S+   C3     .    C3:P3    .     P2      .     C1     .     0 A1:2-3,A2:3,B1:1 A2:P-2,B1:P3 .:1,B1: 1"
+
+	# Once isolated partition pulls cpus from isolcpus, parent can shrink cpu list
+	"  C1-3:S+  C3:P2   .    C3:P3  C1-2     .      .      .     .     0 A1:1-2,A2:3,B1: A2:P2,B1:P3 . 3"
+	"  C1-3:S+  C3:P2   .    C3:P3   C1      .      .      .     .     0 A1:1,A2:3,B1:   A2:P2,B1:P3 . 3"
+
+	# Isolated partition can't be enabled if it can't pull all isolated cpus from parent or isolcpus
+	"  C1-3:S+   C2     .    C3:P3    .     P2      .      .     .     0 A1:1-2,A2:2,B1:3 A2:P-2,B1:P3"
+
+	# Isolated/isolcpus partition online/offline tests
+	"  C1-3:S+   C3     .   C2-3:P3   .     P2     O2=0    .     .     0 A1:1,A2:3,B1:  A2:P2,B1:P3 .:2-3,B1:3 2-3"
+	"  C1-3:S+   C3     .   C2-3:P3   .     P2     O2=0   O2=1   .     0 A1:1,A2:3,B1:2 A2:P2,B1:P3 .:2-3,B1:3 2-3"
+	"  C1-3:S+  C2-3    .   C2-3:P3   .     P2     O2=0    .     .     0 A1:1,A2:3,B1:  A2:P2,B1:P3 .:2-3,B1:2-3 2-3"
+	"  C1-3:S+  C2-3    .   C2-3:P3   .     P2     O2=0   O2=1   .     0 A1:1,A2:2-3,B1: A2:P2,B1:P3 .:2-3,B1:2-3 2-3"
+
+	# Isolated partition pulling from isolcpus become invalid if all isolated cpus gone
+	"  C1-3:S+   C3     .   C2-3:P3   .     P2     O3=0    .     .     0 A1:1,A2:1,B1:2  A2:P-2,B1:P3 .:2-3,B1:"
+	"  C1-3:S+   C3     .   C2-3:P3   .     P2     O3=0   O3=1   .     0 A1:1,A2:1,B1:2-3  A2:P-2,B1:P3 .:2-3,B1:"
+
+	# Hotplug won't affect isolcpus partition with empty cpus_allowed
+	"    C1-3    .      .     P3      .      .     O1=0    .     .     0 A1:2-3,B1: B1:P3"
+
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 new-C1 fail ECPUs Pstate PCPUS ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ ----- --------
 	#
 	# Incorrect change to cpuset.cpus invalidates partition root
 	#
 	# Adding CPUs to partition root that are not in parent's
 	# cpuset.cpus is allowed, but those extra CPUs are ignored.
-	"  S+ C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     0 A1:,A2:2-3 A1:P1,A2:P1"
+	"C2-3:P1:S+ C3:P1   .      .      .     C2-4    .      .     .     0 A1:,A2:2-3 A1:P1,A2:P1"
 
 	# Taking away all CPUs from parent or itself if there are tasks
 	# will make the partition invalid.
-	"  S+ C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
-	"  S+  C3:P1:S+    C3    .      .      T      P1     .      .     0 A1:3,A2:3 A1:P1,A2:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
+	"C2-3:P1:S+  C3:P1  .      .      T     C2-3    .      .     .     0 A1:2-3,A2:2-3 A1:P1,A2:P-1"
+	" C3:P1:S+    C3    .      .      T      P1     .      .     .     0 A1:3,A2:3 A1:P1,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .    T:C2-3   .      .      .     .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P-1,A3:P-1"
+	"$SETUP_A123_PARTITIONS    . T:C2-3:C1-3 .      .      .     .     0 A1:1,A2:2,A3:3 A1:P1,A2:P1,A3:P1"
 
 	# Changing a partition root to member makes child partitions invalid
-	"  S+ C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
-	"  S+ $SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
+	"C2-3:P1:S+  C3:P1  .      .      P0     .      .      .     .     0 A1:2-3,A2:3 A1:P0,A2:P-1"
+	"$SETUP_A123_PARTITIONS    .     C2-3    P0     .      .     .     0 A1:2-3,A2:2-3,A3:3 A1:P1,A2:P0,A3:P-1"
 
 	# cpuset.cpus can contains cpus not in parent's cpuset.cpus as long
 	# as they overlap.
-	"  S+ C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     0 A1:2,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  .      .      .      .   C3-4:P1   .      .     .     0 A1:2,A2:3 A1:P1,A2:P1"
 
 	# Deletion of CPUs distributed to child cgroup is allowed.
-	"  S+ C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     0 A1:4-5,A2:4-5"
+	"C0-1:P1:S+ C1      .    C2-3   C4-5     .      .      .     .     0 A1:4-5,A2:4-5"
 
 	# To become a valid partition root, cpuset.cpus must overlap parent's
 	# cpuset.cpus.
-	"  S+   C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     0 A1:0-1,A2:0-1 A1:P1,A2:P-1"
+	"  C0-1:P1   .      .    C2-3    S+   C4-5:P1   .      .     .     0 A1:0-1,A2:0-1 A1:P1,A2:P-1"
 
 	# Enabling partition with child cpusets is allowed
-	"  S+   C0-1:S+  C1      .    C2-3    P1      .      .      .     0 A1:0-1,A2:1 A1:P1"
+	"  C0-1:S+  C1      .    C2-3    P1      .      .      .     .     0 A1:0-1,A2:1 A1:P1"
 
 	# A partition root with non-partition root parent is invalid, but it
 	# can be made valid if its parent becomes a partition root too.
-	"  S+   C0-1:S+  C1      .    C2-3     .      P2     .      .     0 A1:0-1,A2:1 A1:P0,A2:P-2"
-	"  S+   C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     0 A1:0,A2:1 A1:P1,A2:P2"
+	"  C0-1:S+  C1      .    C2-3     .      P2     .      .     .     0 A1:0-1,A2:1 A1:P0,A2:P-2"
+	"  C0-1:S+ C1:P2    .    C2-3     P1     .      .      .     .     0 A1:0,A2:1 A1:P1,A2:P2"
 
 	# A non-exclusive cpuset.cpus change will invalidate partition and its siblings
-	"  S+   C0-1:P1   .      .    C2-3   C0-2     .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P0"
-	"  S+   C0-1:P1   .      .  P1:C2-3  C0-2   .      .      .     0 A1:0-2,B1:2-3 A1:P-1,B1:P-1"
-	"  S+    C0-1     .      .  P1:C2-3  C0-2   .      .      .     0 A1:0-2,B1:2-3 A1:P0,B1:P-1"
+	"  C0-1:P1   .      .    C2-3   C0-2     .      .      .     .     0 A1:0-2,B1:2-3 A1:P-1,B1:P0"
+	"  C0-1:P1   .      .  P1:C2-3  C0-2     .      .      .     .     0 A1:0-2,B1:2-3 A1:P-1,B1:P-1"
+	"   C0-1     .      .  P1:C2-3  C0-2     .      .      .     .     0 A1:0-2,B1:2-3 A1:P0,B1:P-1"
 
-	# test  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate
-	# ----  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------
+	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 new-C1 fail ECPUs Pstate PCPUS ISOLCPUS
+	#  ------ ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ ----- --------
 	# Failure cases:
 
 	# A task cannot be added to a partition with no cpu
-	"  S+ C2-3:P1:S+  C3:P1  .      .    O2-0:T   .      .      .     1 A1:,A2:3 A1:P1,A2:P1"
+	"C2-3:P1:S+  C3:P1  .      .    O2=0:T   .      .      .     .     1 A1:,A2:3 A1:P1,A2:P1"
+
+	# Task is not allowed in an isolcpus partition
+	"     .      .      .    C3:P3    .      .      .      T     .     1"
+
+	# Child cpuset is not allowed under an isolcpus partition
+	"   C1:P3    .      .      .     S+      .      .      .     .     1"
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
@@ -383,6 +435,9 @@ set_ctrl_state()
 			    ;;
 			2)  VAL=isolated
 			    ;;
+			3)
+			    VAL=isolcpus
+			    ;;
 			*)
 			    echo "Invalid partition state - $VAL"
 			    exit 1
@@ -430,7 +485,7 @@ online_cpus()
 	[[ -n "OFFLINE_CPUS" ]] && {
 		for C in $OFFLINE_CPUS
 		do
-			write_cpu_online ${C}-1
+			write_cpu_online ${C}=1
 		done
 	}
 }
@@ -442,19 +497,23 @@ reset_cgroup_states()
 {
 	echo 0 > $CGROUP2/cgroup.procs
 	online_cpus
-	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
+	rmdir A1/A2/A3 A1/A2 A1 B1 C1 > /dev/null 2>&1
 	set_ctrl_state . S-
 	pause 0.01
 }
 
 dump_states()
 {
-	for DIR in A1 A1/A2 A1/A2/A3 B1
+	for DIR in . A1 A1/A2 A1/A2/A3 B1 C1
 	do
 		ECPUS=$DIR/cpuset.cpus.effective
 		PRS=$DIR/cpuset.cpus.partition
+		PCPUS=$DIR/cpuset.cpus.subpartitions
+		[[ -e $PCPUS ]] ||
+			PCPUS=$DIR/.__DEBUG__.cpuset.cpus.subpartitions
 		[[ -e $ECPUS ]] && echo "$ECPUS: $(cat $ECPUS)"
 		[[ -e $PRS   ]] && echo "$PRS: $(cat $PRS)"
+		[[ -e $PCPUS ]] && echo "$PCPUS: $(cat $PCPUS)"
 	done
 }
 
@@ -478,6 +537,26 @@ check_effective_cpus()
 	done
 }
 
+#
+# Check subparts cpus
+# $1 - check string, format: <cgroup>:<cpu-list>[,<cgroup>:<cpu-list>]*
+#
+check_subparts_cpus()
+{
+	CHK_STR=$1
+	for CHK in $(echo $CHK_STR | sed -e "s/,/ /g")
+	do
+		set -- $(echo $CHK | sed -e "s/:/ /g")
+		CGRP=$1
+		CPUS=$2
+		[[ $CGRP = A2 ]] && CGRP=A1/A2
+		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
+		FILE=$CGRP/.__DEBUG__.cpuset.cpus.subpartitions
+		[[ -e $FILE ]] || return 0	# Skip test
+		[[ $CPUS = $(cat $FILE) ]] || return 1
+	done
+}
+
 #
 # Check cgroup states
 #  $1 - check string, format: <cgroup>:<state>[,<cgroup>:<state>]*
@@ -512,18 +591,80 @@ check_cgroup_states()
 			isolated)
 				VAL=2
 				;;
+			isolcpus)
+				VAL=3
+				;;
 			"root invalid"*)
 				VAL=-1
 				;;
 			"isolated invalid"*)
 				VAL=-2
 				;;
+			"isolcpus invalid"*)
+				VAL=-3
+				;;
 		esac
 		[[ $EVAL != $VAL ]] && return 1
 	done
 	return 0
 }
 
+#
+# Get isolated (including offline) CPUs by looking at
+# /sys/kernel/debug/sched/domains and compare that with the expected value.
+#
+# $1 - expected isolated cpu list
+#
+check_isolcpus()
+{
+	EXPECT_VAL=$1
+	ISOLCPUS=
+	LASTISOLCPU=
+	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
+	[[ -d $SCHED_DOMAINS ]] || return 0	# Skip check
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
@@ -548,60 +689,59 @@ run_state_test()
 	while [[ $I -lt $CNT ]]
 	do
 		echo "Running test $I ..." > /dev/console
+		[[ $VERBOSE -gt 1 ]] && eval echo \"\${$TEST[$I]}\"
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
+		OLD_A1=$1
+		OLD_A2=$2
+		OLD_A3=$3
+		OLD_B1=$4
+		NEW_A1=$5
+		NEW_A2=$6
+		NEW_A3=$7
+		NEW_B1=$8
+		NEW_C1=$9
 		RESULT=${10}
 		ECPUS=${11}
 		STATES=${12}
+		PCPUS=${13}
+		ICPUS=${14}
 
-		set_ctrl_state_noerr .        $ROOT
+		set_ctrl_state_noerr .        "S+"
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
+		set_ctrl_state C1       $NEW_C1; ((RETVAL += $?))
 
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
 
+		[[ -n "$PCPUS" && "$PCPUS" != . ]] && {
+			check_subparts_cpus $PCPUS
+			[[ $? -ne 0 ]] && test_fail $I "subpartitions CPU"
+		}
+
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
@@ -612,7 +752,7 @@ run_state_test()
 			echo "Effective cpus changed to $NEWLIST after test $I!"
 			exit 1
 		}
-		[[ -n "$VERBOSE" ]] && echo "Test $I done."
+		[[ $VERBOSE -gt 0 ]] && echo "Test $I done."
 		((I++))
 	done
 	echo "All $I tests of $TEST PASSED."
@@ -655,7 +795,7 @@ test_inotify()
 	rm -f $PRS
 	wait_inotify $PWD/cpuset.cpus.partition $PRS &
 	pause 0.01
-	set_ctrl_state . "O1-0"
+	set_ctrl_state . "O1=0"
 	pause 0.01
 	check_cgroup_states ".:P-1"
 	if [[ $? -ne 0 ]]
-- 
2.31.1

