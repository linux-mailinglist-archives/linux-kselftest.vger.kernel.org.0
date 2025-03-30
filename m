Return-Path: <linux-kselftest+bounces-29935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCC3A75CEB
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 23:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FFE188A8F7
	for <lists+linux-kselftest@lfdr.de>; Sun, 30 Mar 2025 21:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD4C1E520E;
	Sun, 30 Mar 2025 21:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh/owj/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4EC1E47A3
	for <linux-kselftest@vger.kernel.org>; Sun, 30 Mar 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371647; cv=none; b=cbSljWgx3ljaqqps54A+Zb8KTOeuwpwfSliG6rwuq5i5s3b05iFvUdvK+cU0/o7yNnx3Bki3MLR+I4qgGDz88mzhtN5C/JRFx/Oe8/65Pk12poePDo78cOy42etMed2ZX3myZJbw4v22QaccDLA/0tZn8ZzsQ6upHgqgVcJqVvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371647; c=relaxed/simple;
	bh=X6qEyyM62Rhm4nq9aLITTboCNm1IH474NxPhm04k+04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2TMbEm+E+LfmpIWYk86UpxmzUSdoIY4vyQZ0G/Gj9CAX9dsK/zSa58gHZemJyDh9waAfgB10UMUfidZU8NapHO987lnf0wsHNk8VbWiYivZWNX5j1ySu0hP0geOpxMjXv92nws4jCf1CYa6YdV5ftzmvGh5gGT/2PMb3dXXTLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh/owj/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743371644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mrQjpFlShLNKMETTxcA/lOqCZh7cDFYxhNQyMaFasXA=;
	b=Yh/owj/ormtaihsgBMI24GUTrNfkQ8VRsEWLzJcxSKbrG21dfdaT/hPAf2jeaNocqe1Zu2
	PBq4nmahLxd3skWqig46u0ybopB0zdKcab95cNxnihJXhkhtLU6D9YVnVkavsAJEn6Bhz4
	hL4wKLdA9Fkdx4REmGqhxkJ2CoiRg/M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-177-Oxe5lqeuP3G8J4XLRwopuw-1; Sun,
 30 Mar 2025 17:54:00 -0400
X-MC-Unique: Oxe5lqeuP3G8J4XLRwopuw-1
X-Mimecast-MFC-AGG-ID: Oxe5lqeuP3G8J4XLRwopuw_1743371639
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3BAE018EBE8A;
	Sun, 30 Mar 2025 21:53:59 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 913071801750;
	Sun, 30 Mar 2025 21:53:57 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 09/10] selftest/cgroup: Clean up and restructure test_cpuset_prs.sh
Date: Sun, 30 Mar 2025 17:52:47 -0400
Message-ID: <20250330215248.3620801-10-longman@redhat.com>
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

Cleaning up the test_cpuset_prs.sh script and restructure some of the
functions so that a new test matrix with a different cgroup directory
structure can be added in the next patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 257 +++++++++++-------
 1 file changed, 156 insertions(+), 101 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index f11f347129d8..d99412e7d196 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -88,22 +88,30 @@ echo "" > test/cpuset.cpus
 # If isolated CPUs have been reserved at boot time (as shown in
 # cpuset.cpus.isolated), these isolated CPUs should be outside of CPUs 0-8
 # that will be used by this script for testing purpose. If not, some of
-# the tests may fail incorrectly. These pre-isolated CPUs should stay in
-# an isolated state throughout the testing process for now.
+# the tests may fail incorrectly. Wait a bit and retry again just in case
+# these isolated CPUs are leftover from previous run and have just been
+# cleaned up earlier in this script.
+#
+# These pre-isolated CPUs should stay in an isolated state throughout the
+# testing process for now.
 #
 BOOT_ISOLCPUS=$(cat $CGROUP2/cpuset.cpus.isolated)
+[[ -n "$BOOT_ISOLCPUS" ]] && {
+	sleep 0.5
+	BOOT_ISOLCPUS=$(cat $CGROUP2/cpuset.cpus.isolated)
+}
 if [[ -n "$BOOT_ISOLCPUS" ]]
 then
 	[[ $(echo $BOOT_ISOLCPUS | sed -e "s/[,-].*//") -le 8 ]] &&
 		skip_test "Pre-isolated CPUs ($BOOT_ISOLCPUS) overlap CPUs to be tested"
 	echo "Pre-isolated CPUs: $BOOT_ISOLCPUS"
 fi
+
 cleanup()
 {
 	online_cpus
 	cd $CGROUP2
-	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
-	rmdir test > /dev/null 2>&1
+	rmdir A1/A2/A3 A1/A2 A1 B1 test/A1 test/B1 test > /dev/null 2>&1
 	[[ -n "$SCHED_DEBUG" ]] &&
 		echo "$SCHED_DEBUG" > /sys/kernel/debug/sched/verbose
 }
@@ -173,14 +181,22 @@ test_add_proc()
 #
 # Cgroup test hierarchy
 #
-# root -- A1 -- A2 -- A3
-#      +- B1
+#	      root
+#	        |
+#	 +------+------+
+#	 |             |
+#	 A1            B1
+#	 |
+#	 A2
+#	 |
+#	 A3
 #
 #  P<v> = set cpus.partition (0:member, 1:root, 2:isolated)
 #  C<l> = add cpu-list to cpuset.cpus
 #  X<l> = add cpu-list to cpuset.cpus.exclusive
 #  S<p> = use prefix in subtree_control
 #  T    = put a task into cgroup
+#  CX<l> = add cpu-list to both cpuset.cpus and cpuset.cpus.exclusive
 #  O<c>=<v> = Write <v> to CPU online file of <c>
 #
 # ECPUs    - effective CPUs of cpusets
@@ -453,25 +469,26 @@ set_ctrl_state()
 		PFILE=$CGRP/cpuset.cpus.partition
 		CFILE=$CGRP/cpuset.cpus
 		XFILE=$CGRP/cpuset.cpus.exclusive
-		S=$(expr substr $CMD 1 1)
-		if [[ $S = S ]]
-		then
-			PREFIX=${CMD#?}
+		case $CMD in
+		    S*) PREFIX=${CMD#?}
 			COMM="echo ${PREFIX}${CTRL} > $SFILE"
 			eval $COMM $REDIRECT
-		elif [[ $S = X ]]
-		then
+			;;
+		    X*)
 			CPUS=${CMD#?}
 			COMM="echo $CPUS > $XFILE"
 			eval $COMM $REDIRECT
-		elif [[ $S = C ]]
-		then
-			CPUS=${CMD#?}
+			;;
+		    CX*)
+			CPUS=${CMD#??}
+			COMM="echo $CPUS > $CFILE; echo $CPUS > $XFILE"
+			eval $COMM $REDIRECT
+			;;
+		    C*) CPUS=${CMD#?}
 			COMM="echo $CPUS > $CFILE"
 			eval $COMM $REDIRECT
-		elif [[ $S = P ]]
-		then
-			VAL=${CMD#?}
+			;;
+		    P*) VAL=${CMD#?}
 			case $VAL in
 			0)  VAL=member
 			    ;;
@@ -486,15 +503,17 @@ set_ctrl_state()
 			esac
 			COMM="echo $VAL > $PFILE"
 			eval $COMM $REDIRECT
-		elif [[ $S = O ]]
-		then
-			VAL=${CMD#?}
+			;;
+		    O*) VAL=${CMD#?}
 			write_cpu_online $VAL
-		elif [[ $S = T ]]
-		then
-			COMM="echo 0 > $TFILE"
+			;;
+		    T*) COMM="echo 0 > $TFILE"
 			eval $COMM $REDIRECT
-		fi
+			;;
+		    *)  echo "Unknown command: $CMD"
+		        exit 1
+			;;
+		esac
 		RET=$?
 		[[ $RET -ne 0 ]] && {
 			[[ -n "$SHOWERR" ]] && {
@@ -532,21 +551,18 @@ online_cpus()
 }
 
 #
-# Return 1 if the list of effective cpus isn't the same as the initial list.
+# Remove all the test cgroup directories
 #
 reset_cgroup_states()
 {
 	echo 0 > $CGROUP2/cgroup.procs
 	online_cpus
-	rmdir A1/A2/A3 A1/A2 A1 B1 > /dev/null 2>&1
-	pause 0.02
-	set_ctrl_state . R-
-	pause 0.01
+	rmdir $RESET_LIST > /dev/null 2>&1
 }
 
 dump_states()
 {
-	for DIR in . A1 A1/A2 A1/A2/A3 B1
+	for DIR in $CGROUP_LIST
 	do
 		CPUS=$DIR/cpuset.cpus
 		ECPUS=$DIR/cpuset.cpus.effective
@@ -565,6 +581,21 @@ dump_states()
 	done
 }
 
+#
+# Set the actual cgroup directory into $CGRP_DIR
+# $1 - cgroup name
+#
+set_cgroup_dir()
+{
+	CGRP_DIR=$1
+	[[ $CGRP_DIR = A2  ]] && CGRP_DIR=A1/A2
+	[[ $CGRP_DIR = A3  ]] && CGRP_DIR=A1/A2/A3
+	[[ $CGRP_DIR = c11 ]] && CGRP_DIR=p1/c11
+	[[ $CGRP_DIR = c12 ]] && CGRP_DIR=p1/c12
+	[[ $CGRP_DIR = c21 ]] && CGRP_DIR=p2/c21
+	[[ $CGRP_DIR = c22 ]] && CGRP_DIR=p2/c22
+}
+
 #
 # Check effective cpus
 # $1 - check string, format: <cgroup>:<cpu-list>[|<cgroup>:<cpu-list>]*
@@ -576,7 +607,8 @@ check_effective_cpus()
 	do
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
-		CPUS=$2
+		EXPECTED_CPUS=$2
+		ACTUAL_CPUS=
 		if [[ $CGRP = X* ]]
 		then
 			CGRP=${CGRP#X}
@@ -584,10 +616,10 @@ check_effective_cpus()
 		else
 			FILE=cpuset.cpus.effective
 		fi
-		[[ $CGRP = A2 ]] && CGRP=A1/A2
-		[[ $CGRP = A3 ]] && CGRP=A1/A2/A3
-		[[ -e $CGRP/$FILE ]] || return 1
-		[[ $CPUS = $(cat $CGRP/$FILE) ]] || return 1
+		set_cgroup_dir $CGRP
+		[[ -e $CGRP_DIR/$FILE ]] || return 1
+		ACTUAL_CPUS=$(cat $CGRP_DIR/$FILE)
+		[[ $EXPECTED_CPUS = $ACTUAL_CPUS ]] || return 1
 	done
 }
 
@@ -602,23 +634,21 @@ check_cgroup_states()
 	do
 		set -- $(echo $CHK | sed -e "s/:/ /g")
 		CGRP=$1
-		CGRP_DIR=$CGRP
-		STATE=$2
+		EXPECTED_STATE=$2
 		FILE=
-		EVAL=$(expr substr $STATE 2 2)
-		[[ $CGRP = A2 ]] && CGRP_DIR=A1/A2
-		[[ $CGRP = A3 ]] && CGRP_DIR=A1/A2/A3
+		EVAL=$(expr substr $EXPECTED_STATE 2 2)
 
-		case $STATE in
+		set_cgroup_dir $CGRP
+		case $EXPECTED_STATE in
 			P*) FILE=$CGRP_DIR/cpuset.cpus.partition
 			    ;;
-			*)  echo "Unknown state: $STATE!"
+			*)  echo "Unknown state: $EXPECTED_STATE!"
 			    exit 1
 			    ;;
 		esac
-		VAL=$(cat $FILE)
+		ACTUAL_STATE=$(cat $FILE)
 
-		case "$VAL" in
+		case "$ACTUAL_STATE" in
 			member) VAL=0
 				;;
 			root)	VAL=1
@@ -642,7 +672,7 @@ check_cgroup_states()
 		[[ $VAL -eq 1 && $VERBOSE -gt 0 ]] && {
 			DOMS=$(cat $CGRP_DIR/cpuset.cpus.effective)
 			[[ -n "$DOMS" ]] &&
-				echo " [$CGRP] sched-domain: $DOMS" > $CONSOLE
+				echo " [$CGRP_DIR] sched-domain: $DOMS" > $CONSOLE
 		}
 	done
 	return 0
@@ -665,22 +695,22 @@ check_cgroup_states()
 #
 check_isolcpus()
 {
-	EXPECT_VAL=$1
-	ISOLCPUS=
+	EXPECTED_ISOLCPUS=$1
+	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
+	ISOLCPUS=$(cat $ISCPUS)
 	LASTISOLCPU=
 	SCHED_DOMAINS=/sys/kernel/debug/sched/domains
-	ISCPUS=${CGROUP2}/cpuset.cpus.isolated
-	if [[ $EXPECT_VAL = . ]]
+	if [[ $EXPECTED_ISOLCPUS = . ]]
 	then
-		EXPECT_VAL=
-		EXPECT_VAL2=
-	elif [[ $(expr $EXPECT_VAL : ".*|.*") > 0 ]]
+		EXPECTED_ISOLCPUS=
+		EXPECTED_SDOMAIN=
+	elif [[ $(expr $EXPECTED_ISOLCPUS : ".*|.*") > 0 ]]
 	then
-		set -- $(echo $EXPECT_VAL | sed -e "s/|/ /g")
-		EXPECT_VAL=$1
-		EXPECT_VAL2=$2
+		set -- $(echo $EXPECTED_ISOLCPUS | sed -e "s/|/ /g")
+		EXPECTED_ISOLCPUS=$2
+		EXPECTED_SDOMAIN=$1
 	else
-		EXPECT_VAL2=$EXPECT_VAL
+		EXPECTED_SDOMAIN=$EXPECTED_ISOLCPUS
 	fi
 
 	#
@@ -689,20 +719,21 @@ check_isolcpus()
 	# to make appending those CPUs easier.
 	#
 	[[ -n "$BOOT_ISOLCPUS" ]] && {
-		EXPECT_VAL=${EXPECT_VAL:+${EXPECT_VAL},}${BOOT_ISOLCPUS}
-		EXPECT_VAL2=${EXPECT_VAL2:+${EXPECT_VAL2},}${BOOT_ISOLCPUS}
+		EXPECTED_ISOLCPUS=${EXPECTED_ISOLCPUS:+${EXPECTED_ISOLCPUS},}${BOOT_ISOLCPUS}
+		EXPECTED_SDOMAIN=${EXPECTED_SDOMAIN:+${EXPECTED_SDOMAIN},}${BOOT_ISOLCPUS}
 	}
 
 	#
 	# Check cpuset.cpus.isolated cpumask
 	#
-	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && {
+	[[ "$EXPECTED_ISOLCPUS" != "$ISOLCPUS" ]] && {
 		# Take a 50ms pause and try again
 		pause 0.05
 		ISOLCPUS=$(cat $ISCPUS)
 	}
-	[[ "$EXPECT_VAL2" != "$ISOLCPUS" ]] && return 1
+	[[ "$EXPECTED_ISOLCPUS" != "$ISOLCPUS" ]] && return 1
 	ISOLCPUS=
+	EXPECTED_ISOLCPUS=$EXPECTED_SDOMAIN
 
 	#
 	# Use the sched domain in debugfs to check isolated CPUs, if available
@@ -736,7 +767,7 @@ check_isolcpus()
 	done
 	[[ "$ISOLCPUS" = *- ]] && ISOLCPUS=${ISOLCPUS}$LASTISOLCPU
 
-	[[ "$EXPECT_VAL" = "$ISOLCPUS" ]]
+	[[ "$EXPECTED_SDOMAIN" = "$ISOLCPUS" ]]
 }
 
 test_fail()
@@ -773,6 +804,63 @@ null_isolcpus_check()
 	exit 1
 }
 
+#
+# Check state transition test result
+#  $1 - Test number
+#  $2 - Expected effective CPU values
+#  $3 - Expected partition states
+#  $4 - Expected isolated CPUs
+#
+check_test_results()
+{
+	_NR=$1
+	_ECPUS="$2"
+	_PSTATES="$3"
+	_ISOLCPUS="$4"
+
+	[[ -n "$_ECPUS" && "$_ECPUS" != . ]] && {
+		check_effective_cpus $_ECPUS
+		[[ $? -ne 0 ]] && test_fail $_NR "effective CPU" \
+			 "Cgroup $CGRP: expected $EXPECTED_CPUS, got $ACTUAL_CPUS"
+	}
+
+	[[ -n "$_PSTATES" && "$_PSTATES" != . ]] && {
+		check_cgroup_states $_PSTATES
+		[[ $? -ne 0 ]] && test_fail $_NR states \
+			"Cgroup $CGRP: expected $EXPECTED_STATE, got $ACTUAL_STATE"
+	}
+
+	# Compare the expected isolated CPUs with the actual ones,
+	# if available
+	[[ -n "$_ISOLCPUS" ]] && {
+		check_isolcpus $_ISOLCPUS
+		[[ $? -ne 0 ]] && {
+			[[ -n "$BOOT_ISOLCPUS" ]] && _ISOLCPUS=${_ISOLCPUS},${BOOT_ISOLCPUS}
+			test_fail $_NR "isolated CPU" \
+				"Expect $_ISOLCPUS, get $ISOLCPUS instead"
+		}
+	}
+	reset_cgroup_states
+	#
+	# Check to see if effective cpu list changes
+	#
+	_NEWLIST=$(cat $CGROUP2/cpuset.cpus.effective)
+	RETRY=0
+	while [[ $_NEWLIST != $CPULIST && $RETRY -lt 8 ]]
+	do
+		# Wait a bit longer & recheck a few times
+		pause 0.02
+		((RETRY++))
+		_NEWLIST=$(cat $CGROUP2/cpuset.cpus.effective)
+	done
+	[[ $_NEWLIST != $CPULIST ]] && {
+		echo "Effective cpus changed to $_NEWLIST after test $_NR!"
+		exit 1
+	}
+	null_isolcpus_check
+	[[ $VERBOSE -gt 0 ]] && echo "Test $I done."
+}
+
 #
 # Run cpuset state transition test
 #  $1 - test matrix name
@@ -785,6 +873,8 @@ run_state_test()
 {
 	TEST=$1
 	CONTROLLER=cpuset
+	CGROUP_LIST=". A1 A1/A2 A1/A2/A3 B1"
+	RESET_LIST="A1/A2/A3 A1/A2 A1 B1"
 	I=0
 	eval CNT="\${#$TEST[@]}"
 
@@ -824,45 +914,7 @@ run_state_test()
 
 		[[ $RETVAL -ne $RESULT ]] && test_fail $I result
 
-		[[ -n "$ECPUS" && "$ECPUS" != . ]] && {
-			check_effective_cpus $ECPUS
-			[[ $? -ne 0 ]] && test_fail $I "effective CPU"
-		}
-
-		[[ -n "$STATES" && "$STATES" != . ]] && {
-			check_cgroup_states $STATES
-			[[ $? -ne 0 ]] && test_fail $I states
-		}
-
-		# Compare the expected isolated CPUs with the actual ones,
-		# if available
-		[[ -n "$ICPUS" ]] && {
-			check_isolcpus $ICPUS
-			[[ $? -ne 0 ]] && {
-				[[ -n "$BOOT_ISOLCPUS" ]] && ICPUS=${ICPUS},${BOOT_ISOLCPUS}
-				test_fail $I "isolated CPU" \
-					"Expect $ICPUS, get $ISOLCPUS instead"
-			}
-		}
-		reset_cgroup_states
-		#
-		# Check to see if effective cpu list changes
-		#
-		NEWLIST=$(cat cpuset.cpus.effective)
-		RETRY=0
-		while [[ $NEWLIST != $CPULIST && $RETRY -lt 8 ]]
-		do
-			# Wait a bit longer & recheck a few times
-			pause 0.02
-			((RETRY++))
-			NEWLIST=$(cat cpuset.cpus.effective)
-		done
-		[[ $NEWLIST != $CPULIST ]] && {
-			echo "Effective cpus changed to $NEWLIST after test $I!"
-			exit 1
-		}
-		null_isolcpus_check
-		[[ $VERBOSE -gt 0 ]] && echo "Test $I done."
+		check_test_results $I "$ECPUS" "$STATES" "$ICPUS"
 		((I++))
 	done
 	echo "All $I tests of $TEST PASSED."
@@ -932,6 +984,7 @@ test_isolated()
 	echo $$ > $CGROUP2/cgroup.procs
 	[[ -d A1 ]] && rmdir A1
 	null_isolcpus_check
+	pause 0.05
 }
 
 #
@@ -997,6 +1050,8 @@ test_inotify()
 	else
 		echo "Inotify test PASSED"
 	fi
+	echo member > cpuset.cpus.partition
+	echo "" > cpuset.cpus
 }
 
 trap cleanup 0 2 3 6
-- 
2.48.1


