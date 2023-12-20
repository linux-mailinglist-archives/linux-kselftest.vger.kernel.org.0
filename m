Return-Path: <linux-kselftest+bounces-2262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC67981A1E6
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 16:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8EFB2419E
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Dec 2023 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830123E46E;
	Wed, 20 Dec 2023 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDFE105y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A7D3E47C
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Dec 2023 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703085124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UGXHGx7fIiQQEp0PPgJ61uCfXTD7P90Z9jAT2290LTc=;
	b=iDFE105yFlH9uW8tIfOdT5NKINALYWXvs5suNqOWVwuplT/T88xZdpnO5/cIOWPBrYQQ6m
	yjfTYsxndbXZpnDWpUEx5eo7AAc1MiKxxIYtYkXNqT7X5Lg/uZDvYb4tuhJhQPOJRtU3Rq
	B8l8FaiBKZNSVluM1zjsl2bu158TvnQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-Pnr5I9iHMSiIgdwsThPEeg-1; Wed, 20 Dec 2023 10:12:01 -0500
X-MC-Unique: Pnr5I9iHMSiIgdwsThPEeg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBD97868903;
	Wed, 20 Dec 2023 15:12:00 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (unknown [10.22.33.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9BFAFC15968;
	Wed, 20 Dec 2023 15:12:00 +0000 (UTC)
From: Joe Lawrence <joe.lawrence@redhat.com>
To: live-patching@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH] selftests/livepatch: fix and refactor new dmesg message code
Date: Wed, 20 Dec 2023 10:11:51 -0500
Message-ID: <20231220151151.267985-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

The livepatching kselftests rely on comparing expected vs. observed
dmesg output.  After each test, new dmesg entries are determined by the
'comm' utility comparing a saved, pre-test copy of dmesg to post-test
dmesg output.

Alexander reports that the 'comm --nocheck-order -13' invocation used by
the tests can be confused when dmesg entry timestamps vary in magnitude
(ie, "[   98.820331]" vs. "[  100.031067]"), in which case, additional
messages are reported as new.  The unexpected entries then spoil the
test results.

Instead of relying on 'comm' or 'diff' to determine new testing dmesg
entries, refactor the code:

  - pre-test  : log a unique canary dmesg entry
  - test      : run tests, log messages
  - post-test : filter dmesg starting from pre-test message

Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Closes: https://lore.kernel.org/live-patching/ZYAimyPYhxVA9wKg@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com/
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 .../testing/selftests/livepatch/functions.sh  | 37 +++++++++----------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index c8416c54b463..b1fd7362c2fe 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -42,17 +42,6 @@ function die() {
 	exit 1
 }
 
-# save existing dmesg so we can detect new content
-function save_dmesg() {
-	SAVED_DMESG=$(mktemp --tmpdir -t klp-dmesg-XXXXXX)
-	dmesg > "$SAVED_DMESG"
-}
-
-# cleanup temporary dmesg file from save_dmesg()
-function cleanup_dmesg_file() {
-	rm -f "$SAVED_DMESG"
-}
-
 function push_config() {
 	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
 			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
@@ -99,7 +88,6 @@ function set_ftrace_enabled() {
 
 function cleanup() {
 	pop_config
-	cleanup_dmesg_file
 }
 
 # setup_config - save the current config and set a script exit trap that
@@ -280,7 +268,15 @@ function set_pre_patch_ret {
 function start_test {
 	local test="$1"
 
-	save_dmesg
+	# Dump something unique into the dmesg log, then stash the entry
+	# in LAST_DMESG.  The check_result() function will use it to
+	# find new kernel messages since the test started.
+	local last_dmesg_msg="livepatch kselftest timestamp: $(date --rfc-3339=ns)"
+	log "$last_dmesg_msg"
+	loop_until 'dmesg | grep -q "$last_dmesg_msg"' ||
+		die "buffer busy? can't find canary dmesg message: $last_dmesg_msg"
+	LAST_DMESG=$(dmesg | grep "$last_dmesg_msg")
+
 	echo -n "TEST: $test ... "
 	log "===== TEST: $test ====="
 }
@@ -291,23 +287,24 @@ function check_result {
 	local expect="$*"
 	local result
 
-	# Note: when comparing dmesg output, the kernel log timestamps
-	# help differentiate repeated testing runs.  Remove them with a
-	# post-comparison sed filter.
-
-	result=$(dmesg | comm --nocheck-order -13 "$SAVED_DMESG" - | \
+	# Test results include any new dmesg entry since LAST_DMESG, then:
+	# - include lines matching keywords
+	# - exclude lines matching keywords
+	# - filter out dmesg timestamp prefixes
+	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
 
 	if [[ "$expect" == "$result" ]] ; then
 		echo "ok"
+	elif [[ "$result" == "" ]] ; then
+		echo -e "not ok\n\nbuffer overrun? can't find canary dmesg entry: $LAST_DMESG\n"
+		die "livepatch kselftest(s) failed"
 	else
 		echo -e "not ok\n\n$(diff -upr --label expected --label result <(echo "$expect") <(echo "$result"))\n"
 		die "livepatch kselftest(s) failed"
 	fi
-
-	cleanup_dmesg_file
 }
 
 # check_sysfs_rights(modname, rel_path, expected_rights) - check sysfs
-- 
2.41.0


