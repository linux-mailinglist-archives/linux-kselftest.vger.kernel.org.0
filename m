Return-Path: <linux-kselftest+bounces-198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287BA7EDA58
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 04:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D664628124A
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Nov 2023 03:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCB8F79;
	Thu, 16 Nov 2023 03:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b6XKdCMq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABFE1BE
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 19:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700105681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nT8mn+CYHK0/rYux6OcfYs1wPw2RH0li5fDfUDzstNM=;
	b=b6XKdCMqUaezS0fS14s8pngM4r20UhKAq+80Ne18MFlL+P/c06/K5XfvSXajg4CYaOk1vB
	6Q0i+6boOsvebBvt5DkrwUvtraU1oY90MwZksBbchzLerRGi7VUQH99Kb420yP9oAsBBOa
	7t9qgTZkx5NdbtJ5osnofanIMJv1czc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vIOZoG-TNlW8FyI9gfS8VA-1; Wed, 15 Nov 2023 22:34:35 -0500
X-MC-Unique: vIOZoG-TNlW8FyI9gfS8VA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DAD1185A781;
	Thu, 16 Nov 2023 03:34:35 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E4FC7492BFE;
	Thu, 16 Nov 2023 03:34:34 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Peter Hunt <pehunt@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/5] selftests/cgroup: Minor code cleanup and reorganization of test_cpuset_prs.sh
Date: Wed, 15 Nov 2023 22:34:03 -0500
Message-Id: <20231116033405.185166-4-longman@redhat.com>
In-Reply-To: <20231116033405.185166-1-longman@redhat.com>
References: <20231116033405.185166-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Minor cleanup of test matrix and relocation of test_isolated() function
to prepare for the next patch. There is no functional change.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 142 +++++++++---------
 1 file changed, 71 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index a6e9848189d6..2b825019f806 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -146,71 +146,6 @@ test_add_proc()
 	echo $$ > $CGROUP2/cgroup.procs	# Move out the task
 }
 
-#
-# Testing the new "isolated" partition root type
-#
-test_isolated()
-{
-	cd $CGROUP2/test
-	echo 2-3 > cpuset.cpus
-	TYPE=$(cat cpuset.cpus.partition)
-	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
-
-	console_msg "Change from member to root"
-	test_partition root
-
-	console_msg "Change from root to isolated"
-	test_partition isolated
-
-	console_msg "Change from isolated to member"
-	test_partition member
-
-	console_msg "Change from member to isolated"
-	test_partition isolated
-
-	console_msg "Change from isolated to root"
-	test_partition root
-
-	console_msg "Change from root to member"
-	test_partition member
-
-	#
-	# Testing partition root with no cpu
-	#
-	console_msg "Distribute all cpus to child partition"
-	echo +cpuset > cgroup.subtree_control
-	test_partition root
-
-	mkdir A1
-	cd A1
-	echo 2-3 > cpuset.cpus
-	test_partition root
-	test_effective_cpus 2-3
-	cd ..
-	test_effective_cpus ""
-
-	console_msg "Moving task to partition test"
-	test_add_proc "No space left"
-	cd A1
-	test_add_proc ""
-	cd ..
-
-	console_msg "Shrink and expand child partition"
-	cd A1
-	echo 2 > cpuset.cpus
-	cd ..
-	test_effective_cpus 3
-	cd A1
-	echo 2-3 > cpuset.cpus
-	cd ..
-	test_effective_cpus ""
-
-	# Cleaning up
-	console_msg "Cleaning up"
-	echo $$ > $CGROUP2/cgroup.procs
-	[[ -d A1 ]] && rmdir A1
-}
-
 #
 # Cpuset controller state transition test matrix.
 #
@@ -304,7 +239,7 @@ TEST_MATRIX=(
 								       A1:P0,A2:P2,A3:P1 2-4"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      X5      .      .    0 A1:0-4,A2:1-4,A3:2-4 \
-								       A1:P0,A2:P-2,A3:P-1 ."
+								       A1:P0,A2:P-2,A3:P-1"
 	" C0-4:X2-4:S+ C1-4:X2-4:S+:P2 C2-4:X4:P1 \
 				   .      .      .      X1      .    0 A1:0-1,A2:2-4,A3:2-4 \
 								       A1:P0,A2:P2,A3:P-1 2-4"
@@ -347,10 +282,10 @@ TEST_MATRIX=(
 	# cpus_allowed/exclusive_cpus update tests
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .     C4      .      P2     .     0 A1:4,A2:4,XA2:,XA3:,A3:4 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .     X1      .      P2     .     0 A1:0-3,A2:1-3,XA1:1,XA2:,XA3:,A3:2-3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3 \
 				   .      .     C3      P2     .     0 A1:0-2,A2:0-2,XA2:3,XA3:3,A3:3 \
 								       A1:P0,A3:P2 3"
@@ -359,13 +294,13 @@ TEST_MATRIX=(
 								       A1:P0,A3:P2 3"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .      .     X3      .      .     0 A1:0-3,A2:1-3,XA2:3,XA3:3,A3:2-3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .      .     C3      .      .     0 A1:0-3,A2:3,XA2:3,XA3:3,A3:3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 	" C0-3:X2-3:S+ C1-3:X2-3:S+ C2-3:X2-3:P2 \
 				   .     C4      .      .      .     0 A1:4,A2:4,A3:4,XA1:,XA2:,XA3 \
-								       A1:P0,A3:P-2 ."
+								       A1:P0,A3:P-2"
 
 	#  old-A1 old-A2 old-A3 old-B1 new-A1 new-A2 new-A3 new-B1 fail ECPUs Pstate ISOLCPUS
 	#  ------ ------ ------ ------ ------ ------ ------ ------ ---- ----- ------ --------
@@ -804,6 +739,71 @@ run_state_test()
 	echo "All $I tests of $TEST PASSED."
 }
 
+#
+# Testing the new "isolated" partition root type
+#
+test_isolated()
+{
+	cd $CGROUP2/test
+	echo 2-3 > cpuset.cpus
+	TYPE=$(cat cpuset.cpus.partition)
+	[[ $TYPE = member ]] || echo member > cpuset.cpus.partition
+
+	console_msg "Change from member to root"
+	test_partition root
+
+	console_msg "Change from root to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to member"
+	test_partition member
+
+	console_msg "Change from member to isolated"
+	test_partition isolated
+
+	console_msg "Change from isolated to root"
+	test_partition root
+
+	console_msg "Change from root to member"
+	test_partition member
+
+	#
+	# Testing partition root with no cpu
+	#
+	console_msg "Distribute all cpus to child partition"
+	echo +cpuset > cgroup.subtree_control
+	test_partition root
+
+	mkdir A1
+	cd A1
+	echo 2-3 > cpuset.cpus
+	test_partition root
+	test_effective_cpus 2-3
+	cd ..
+	test_effective_cpus ""
+
+	console_msg "Moving task to partition test"
+	test_add_proc "No space left"
+	cd A1
+	test_add_proc ""
+	cd ..
+
+	console_msg "Shrink and expand child partition"
+	cd A1
+	echo 2 > cpuset.cpus
+	cd ..
+	test_effective_cpus 3
+	cd A1
+	echo 2-3 > cpuset.cpus
+	cd ..
+	test_effective_cpus ""
+
+	# Cleaning up
+	console_msg "Cleaning up"
+	echo $$ > $CGROUP2/cgroup.procs
+	[[ -d A1 ]] && rmdir A1
+}
+
 #
 # Wait for inotify event for the given file and read it
 # $1: cgroup file to wait for
-- 
2.39.3


