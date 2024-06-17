Return-Path: <linux-kselftest+bounces-12066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C189890B3E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D57928A678
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F9715B997;
	Mon, 17 Jun 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q1lQ2xS7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C715CD47
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Jun 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635281; cv=none; b=orpfGDnVIXxCrSSSY2LG8CigmXDc25FFVtXZTCm+ZFY2i2uEQRFsWztjoxfWLIdnuvzbI8GsRmskVasPuk+oxE5/XzeBLwA2QhehfKqIL7ujWe9ypbKq4isdBNkdudQdVRMwB4xAoQF6LPxXuR3xfrGgpQkmdMvDeamUkgaaw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635281; c=relaxed/simple;
	bh=rxsR7U/YvvGUO9SU+gZVaocyTWFefPbzUS56onemTSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yp3CrGaUc/evODmvnbrSlhAQFFZTZVe0X4VxWM4yUkA7syzLAN4pUBQYjfjHAseKxPpQpKhETpjndEzVVWe5vg00JT+hm9Ci1uR1MH8p4CWxHjRqSyqxfIcAU2gk41U48SQuXZmVyfaj15GUeO8k17ABYMUrQSlFifle7hvKt48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q1lQ2xS7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718635279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=COdoiIbcjskr3CZ+b0ndr1ezwQxaMDEVmxWG+69AViE=;
	b=Q1lQ2xS75f9LMsmyDwdTNd/iRzrhFXCzwChaqjx0TCE7W6oZmX39I+1apybqjREdo9AJd6
	xkOUZ9dIe3vlYcr6wNSrk0V7/vhzVGcOYuWhkN9vLuaUR5Ir5R1LmhZfNm0C/LIe0jzISG
	QdxHfxmtdUwue70+tl+CyLauoKVmZnM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-33-rF8BIeCLOVC61x_7d4u2Qw-1; Mon,
 17 Jun 2024 10:41:15 -0400
X-MC-Unique: rF8BIeCLOVC61x_7d4u2Qw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6532B195608E;
	Mon, 17 Jun 2024 14:41:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81FD21956054;
	Mon, 17 Jun 2024 14:41:10 +0000 (UTC)
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
	Xavier <ghostxavier@sina.com>,
	Peter Hunt <pehunt@redhat.com>,
	Petr Malat <oss@malat.biz>,
	Waiman Long <longman@redhat.com>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH-cgroup v2 2/5] selftest/cgroup: Fix test_cpuset_prs.sh problems reported by test robot
Date: Mon, 17 Jun 2024 10:39:42 -0400
Message-Id: <20240617143945.454888-3-longman@redhat.com>
In-Reply-To: <20240617143945.454888-1-longman@redhat.com>
References: <20240617143945.454888-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The test robot reported two different problems when running the
test_cpuset_prs.sh test.

 # ./test_cpuset_prs.sh: line 106: echo: write error: Input/output error
 #  :
 # Effective cpus changed to 0-1,4-7 after test 4!

The write error is caused by writing to /dev/console. It looks like
some systems may not have /dev/console configured or in a writeable
state. Fix this by checking the existence of /dev/console before
attempting to write it.

After the completion of each test run, the script will check if the
cpuset state is reset back to the original state. That usually takes a
while to happen. The test script inserts some artificial delay to make
sure that the reset has completed. The current setting is about 80ms.
That may not be enough in some cases especially if the test system is
slow. Double it to 160ms to minimize the chance of this type of failure.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202406141712.dbbaa8fd-oliver.sang@intel.com
Signed-off-by: Waiman Long <longman@redhat.com>
---
 .../selftests/cgroup/test_cpuset_prs.sh       | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_cpuset_prs.sh b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
index b5eb1be2248c..96bf2b5c5eb6 100755
--- a/tools/testing/selftests/cgroup/test_cpuset_prs.sh
+++ b/tools/testing/selftests/cgroup/test_cpuset_prs.sh
@@ -28,6 +28,14 @@ CPULIST=$(cat $CGROUP2/cpuset.cpus.effective)
 NR_CPUS=$(lscpu | grep "^CPU(s):" | sed -e "s/.*:[[:space:]]*//")
 [[ $NR_CPUS -lt 8 ]] && skip_test "Test needs at least 8 cpus available!"
 
+# Check to see if /dev/console exists and is writable
+if [[ -c /dev/console && -w /dev/console ]]
+then
+	CONSOLE=/dev/console
+else
+	CONSOLE=/dev/null
+fi
+
 # Set verbose flag and delay factor
 PROG=$1
 VERBOSE=0
@@ -103,8 +111,8 @@ console_msg()
 {
 	MSG=$1
 	echo "$MSG"
-	echo "" > /dev/console
-	echo "$MSG" > /dev/console
+	echo "" > $CONSOLE
+	echo "$MSG" > $CONSOLE
 	pause 0.01
 }
 
@@ -694,9 +702,9 @@ null_isolcpus_check()
 	[[ $VERBOSE -gt 0 ]] || return 0
 	# Retry a few times before printing error
 	RETRY=0
-	while [[ $RETRY -lt 5 ]]
+	while [[ $RETRY -lt 8 ]]
 	do
-		pause 0.01
+		pause 0.02
 		check_isolcpus "."
 		[[ $? -eq 0 ]] && return 0
 		((RETRY++))
@@ -726,7 +734,7 @@ run_state_test()
 
 	while [[ $I -lt $CNT ]]
 	do
-		echo "Running test $I ..." > /dev/console
+		echo "Running test $I ..." > $CONSOLE
 		[[ $VERBOSE -gt 1 ]] && {
 			echo ""
 			eval echo \${$TEST[$I]}
@@ -783,7 +791,7 @@ run_state_test()
 		while [[ $NEWLIST != $CPULIST && $RETRY -lt 8 ]]
 		do
 			# Wait a bit longer & recheck a few times
-			pause 0.01
+			pause 0.02
 			((RETRY++))
 			NEWLIST=$(cat cpuset.cpus.effective)
 		done
-- 
2.39.3


