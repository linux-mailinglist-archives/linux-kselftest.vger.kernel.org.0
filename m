Return-Path: <linux-kselftest+bounces-6085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04106875CA6
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 04:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2594C1C20FE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Mar 2024 03:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192BD2C85A;
	Fri,  8 Mar 2024 03:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QpqXMXc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6C2C684;
	Fri,  8 Mar 2024 03:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867859; cv=none; b=d0N4PeDTMaQHMxrNI6SG9EoGb4yq7N2qhY0zvNXbF79xHrMoVyW3WYu2nP1QmpRc668cUOX9B0PItB4+1+wWTnqpha/jTeOUJoJhvyyksvtK7r9mvFmkjzyplc4he+Bsz4yy2QGP0HdRPMo20Jj86JjD9IQWhheUh18IDd0tEB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867859; c=relaxed/simple;
	bh=4Sy6HjQT0R4TSYXK22k7jkxy7MdvO9WkaPp52ywCZYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmeMHVirU8hXRUMaqq44ne8feWq7QANgLF/aqO0Cs2lAzQgLE6S3x/HyKuBqsR/2r3NFQ6Qta3AQ0erz3xu4Of3zWUbjfFrZ2phvrAuq/tH6pKS6MGJ3ag5/omxIuby5xmJHs3D7zYIjMHVUBwHoSaG+Qcst+e4m0e4jEjLnr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QpqXMXc3; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709867853; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TQjtAD0VH/M9/CSlEii+2IdqraHARU9mdrM1K9D7Z2Q=;
	b=QpqXMXc3iFbNKjxPg2/mhodTMCEO9dOuMzbYSYp19OTxVKwNi7OhxJwxlptZ6Ccowl6/CLRWYWN8xQI3lr2uAOcSi3NClVjKRrajpB6J5qjkzWNeVjY0BuCqTUtJwp39wlBTU5OqMxP35fkhDAvl7o8xD2CFWLAU9KtGi1Njnpw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0W21N1Nr_1709867851;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W21N1Nr_1709867851)
          by smtp.aliyun-inc.com;
          Fri, 08 Mar 2024 11:17:32 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	xiangzao@linux.alibaba.com,
	yixingrui@linux.alibaba.com,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 4/4] tools/testing: adjust pstore backend related selftest
Date: Fri,  8 Mar 2024 11:16:56 +0800
Message-Id: <20240308031656.9672-5-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
References: <20240308031656.9672-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pstore now supports multiple backends, the module parameter
pstore.backend varies from 'registered backend' to 'backends that are
allowed to register' and a new entry /sys/module/pstore/loaded_backend
is added to show which pstore backends are loaded at present. Adjust
selftests to match the change.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 tools/testing/selftests/pstore/common_tests   |  8 +--
 .../selftests/pstore/pstore_post_reboot_tests | 67 ++++++++++---------
 tools/testing/selftests/pstore/pstore_tests   |  2 +-
 3 files changed, 40 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/pstore/common_tests b/tools/testing/selftests/pstore/common_tests
index 4509f0cc9c91..db717f656a73 100755
--- a/tools/testing/selftests/pstore/common_tests
+++ b/tools/testing/selftests/pstore/common_tests
@@ -27,9 +27,9 @@ show_result() { # result_value
 }
 
 check_files_exist() { # type of pstorefs file
-    if [ -e ${1}-${backend}-0 ]; then
+    if [ -e ${1}-${2}-0 ]; then
 	prlog "ok"
-	for f in `ls ${1}-${backend}-*`; do
+	for f in `ls ${1}-${2}-*`; do
             prlog -e "\t${f}"
 	done
     else
@@ -74,9 +74,9 @@ prlog "=== Pstore unit tests (`basename $0`) ==="
 prlog "UUID="$UUID
 
 prlog -n "Checking pstore backend is registered ... "
-backend=`cat /sys/module/pstore/parameters/backend`
+backends=`cat /sys/module/pstore/loaded_backend`
 show_result $?
-prlog -e "\tbackend=${backend}"
+prlog -e "\tbackends=${backends}"
 prlog -e "\tcmdline=`cat /proc/cmdline`"
 if [ $rc -ne 0 ]; then
     exit 1
diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
index d6da5e86efbf..666b45bd7b87 100755
--- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
+++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
@@ -35,46 +35,49 @@ else
     fi
 fi
 
+IFS=','
 cd ${mount_point}
+for backend in ${backends}; do
+    prlog -n "Checking ${backend}-dmesg files exist in pstore filesystem ... "
+    check_files_exist dmesg ${backend}
 
-prlog -n "Checking dmesg files exist in pstore filesystem ... "
-check_files_exist dmesg
+    prlog -n "Checking ${backend}-console files exist in pstore filesystem ... "
+    check_files_exist console ${backend}
 
-prlog -n "Checking console files exist in pstore filesystem ... "
-check_files_exist console
+    prlog -n "Checking ${backend}-pmsg files exist in pstore filesystem ... "
+    check_files_exist pmsg ${backend}
 
-prlog -n "Checking pmsg files exist in pstore filesystem ... "
-check_files_exist pmsg
+    prlog -n "Checking ${backend}-dmesg files contain oops end marker"
+    grep_end_trace() {
+        grep -q "\---\[ end trace" $1
+    }
+    files=`ls dmesg-${backend}-*`
+    operate_files $? "$files" grep_end_trace
 
-prlog -n "Checking dmesg files contain oops end marker"
-grep_end_trace() {
-    grep -q "\---\[ end trace" $1
-}
-files=`ls dmesg-${backend}-*`
-operate_files $? "$files" grep_end_trace
+    prlog -n "Checking ${backend}-console file contains oops end marker ... "
+    grep -q "\---\[ end trace" console-${backend}-0
+    show_result $?
 
-prlog -n "Checking console file contains oops end marker ... "
-grep -q "\---\[ end trace" console-${backend}-0
-show_result $?
-
-prlog -n "Checking pmsg file properly keeps the content written before crash ... "
-prev_uuid=`cat $TOP_DIR/prev_uuid`
-if [ $? -eq 0 ]; then
-    nr_matched=`grep -c "$TEST_STRING_PATTERN" pmsg-${backend}-0`
-    if [ $nr_matched -eq 1 ]; then
-	grep -q "$TEST_STRING_PATTERN"$prev_uuid pmsg-${backend}-0
-	show_result $?
+    prlog -n "Checking ${backend}-pmsg file properly keeps the content written before crash ... "
+    prev_uuid=`cat $TOP_DIR/prev_uuid`
+    if [ $? -eq 0 ]; then
+        nr_matched=`grep -c "$TEST_STRING_PATTERN" pmsg-${backend}-0`
+        if [ $nr_matched -eq 1 ]; then
+	    grep -q "$TEST_STRING_PATTERN"$prev_uuid pmsg-${backend}-0
+	    show_result $?
+        else
+            prlog "FAIL"
+            rc=1
+        fi
     else
-	prlog "FAIL"
-	rc=1
+        prlog "FAIL"
+        rc=1
     fi
-else
-    prlog "FAIL"
-    rc=1
-fi
 
-prlog -n "Removing all files in pstore filesystem "
-files=`ls *-${backend}-*`
-operate_files $? "$files" rm
+    prlog -n "Removing all ${backend} files in pstore filesystem "
+    files=`ls *-${backend}-*`
+    operate_files $? "$files" rm
+done
+unset IFS
 
 exit $rc
diff --git a/tools/testing/selftests/pstore/pstore_tests b/tools/testing/selftests/pstore/pstore_tests
index 2aa9a3852a84..f4665a8c77dc 100755
--- a/tools/testing/selftests/pstore/pstore_tests
+++ b/tools/testing/selftests/pstore/pstore_tests
@@ -10,7 +10,7 @@
 . ./common_tests
 
 prlog -n "Checking pstore console is registered ... "
-dmesg | grep -Eq "console \[(pstore|${backend})"
+dmesg | grep -Eq "console \[(pstore console)"
 show_result $?
 
 prlog -n "Checking /dev/pmsg0 exists ... "
-- 
2.39.3


