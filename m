Return-Path: <linux-kselftest+bounces-15788-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B269958EEB
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 21:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A199D1F233F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2024 19:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C4166F06;
	Tue, 20 Aug 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRMHRvZN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85016133C
	for <linux-kselftest@vger.kernel.org>; Tue, 20 Aug 2024 19:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183778; cv=none; b=FaHfgM+HVxuTtMqDJGAhwsLd/8Rk3qHOxWyI0opcBEaL5yKgxB1UiUcG8S0VCktBBfJto4C0sVEryi6diy7VuFy8+VG/1cPxBoQaz8qHtcO4E7yi8EKi/MR24AIZUGQ7HjcAlbhpbjpi0ODUhh1OXHphvjx6suT5nBiQCHHuJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183778; c=relaxed/simple;
	bh=18cPMSaDtaY+lxHJME2xrBNGIO0S/92DLC/TXWVkzfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BDz+u5PPouOBacqoBNjMK7BVObqm+Ko3hG25rlHtf3vhfMYkktkcEO0r7swAJT0tPuidUBFcL+lSTSviBYJgS+mUatfy82v77yaiXNzdJteTNOBBsm5krUyajqKZEyToLREFfaVV921X7eyXDAPxVnFsaVIWtSRFrZX+Rc5O9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IRMHRvZN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724183775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXWHRdiKeY3vLGIwaF2E78Blh3Oa1dH56pxG/kH/jxM=;
	b=IRMHRvZN1wRNyu1VR223LgSEySOrQNn08TaRJLOgd3/XeodZl73/pcdGKQEkSWa5+A2gI+
	5tLRvou5O9m8Cvkdg/EaDVtK4I0kYyemK85J+E78udssTLzy313bnOehisYBomcBrqrKeO
	YNYBuPjEmXfxw2DQtSaP1EZqIowCbJs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-tznN8F2mNKuvOyc2cDphlw-1; Tue,
 20 Aug 2024 15:56:11 -0400
X-MC-Unique: tznN8F2mNKuvOyc2cDphlw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B0801955BF9;
	Tue, 20 Aug 2024 19:56:09 +0000 (UTC)
Received: from llong.com (unknown [10.2.17.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73A6F3001FFB;
	Tue, 20 Aug 2024 19:56:07 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 2/2] selftest/cgroup: Make test_cpuset_prs.sh deal with pre-isolated CPUs
Date: Tue, 20 Aug 2024 15:55:36 -0400
Message-ID: <20240820195536.202066-3-longman@redhat.com>
In-Reply-To: <20240820195536.202066-1-longman@redhat.com>
References: <20240820195536.202066-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since isolated CPUs can be reserved at boot time via the "isolcpus"
boot command line option, these pre-isolated CPUs may interfere with
testing done by test_cpuset_prs.sh.

With the previous commit that incorporates those boot time isolated CPUs
into "cpuset.cpus.isolated", we can check for those before testing is
started to make sure that there will be no interference.  Otherwise,
this test will be skipped if incorrect test failure can happen.

As "cpuset.cpus.isolated" is now available in a non cgroup_debug kernel,
we don't need to check for its existence anymore.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 44 ++++++++++++++-----
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index 7295424502b9..03c1bdaed2c3 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -84,6 +84,20 @@ echo member > test/cpuset.cpus.partition
 echo "" > test/cpuset.cpus
 [[ $RESULT -eq 0 ]] && skip_test "Child cgroups are using cpuset!"
 
+#
+# If isolated CPUs have been reserved at boot time (as shown in
+# cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-7
+# that will be used by this script for testing purpose. If not, some of
+# the tests may fail incorrectly. These isolated CPUs will also be removed
+# before being compared with the expected results.
+#
+BOOT_ISOLCPUS=$(cat $CGROUP2/cpuset.cpus.isolated)
+if [[ -n "$BOOT_ISOLCPUS" ]]
+then
+	[[ $(echo $BOOT_ISOLCPUS | sed -e "s/[,-].*//") -le 7 ]] &&
+		skip_test "Pre-isolated CPUs ($BOOT_ISOLCPUS) overlap CPUs to be tested"
+	echo "Pre-isolated CPUs: $BOOT_ISOLCPUS"
+fi
 cleanup()
 {
 	online_cpus
@@ -642,7 +656,8 @@ check_cgroup_states()
 # Note that isolated CPUs from the sched/domains context include offline
 # CPUs as well as CPUs in non-isolated 1-CPU partition. Those CPUs may
 # not be included in the cpuset.cpus.isolated control file which contains
-# only CPUs in isolated partitions.
+# only CPUs in isolated partitions as well as those that are isolated at
+# boot time.
 #
 # $1 - expected isolated cpu list(s) <isolcpus1>{,<isolcpus2>}
 # <isolcpus1> - expected sched/domains value
@@ -669,18 +684,21 @@ check_isolcpus()
 	fi
 
 	#
-	# Check the debug isolated cpumask, if present
+	# Check cpuset.cpus.isolated cpumask
 	#
-	[[ -f $ISCPUS ]] && {
+	if [[ -z "$BOOT_ISOLCPUS" ]]
+	then
+		ISOLCPUS=$(cat $ISCPUS)
+	else
+		ISOLCPUS=$(cat $ISCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
+	fi
+	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
+		# Take a 50ms pause and try again
+		pause 0.05
 		ISOLCPUS=$(cat $ISCPUS)
-		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
-			# Take a 50ms pause and try again
-			pause 0.05
-			ISOLCPUS=$(cat $ISCPUS)
-		}
-		[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
-		ISOLCPUS=
 	}
+	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
+	ISOLCPUS=
 
 	#
 	# Use the sched domain in debugfs to check isolated CPUs, if available
@@ -713,6 +731,9 @@ check_isolcpus()
 		fi
 	done
 	[[ "$ISOLCPUS" = *- ]] && ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
+	[[ -n "BOOT_ISOLCPUS" ]] &&
+		ISOLCPUS=$(echo $ISOLCPUS | sed -e "s/,*$BOOT_ISOLCPUS//")
+
 	[[ "$EXPECT_VAL" = "$ISOLCPUS" ]]
 }
 
@@ -730,7 +751,8 @@ test_fail()
 }
 
 #
-# Check to see if there are unexpected isolated CPUs left
+# Check to see if there are unexpected isolated CPUs left beyond the boot
+# time isolated ones.
 #
 null_isolcpus_check()
 {
-- 
2.43.5


