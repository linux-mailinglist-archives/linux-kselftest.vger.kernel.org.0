Return-Path: <linux-kselftest+bounces-4208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8484C26B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 03:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B8D1C24679
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Feb 2024 02:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C80F9FE;
	Wed,  7 Feb 2024 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="iM+5XBYy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A0EEAC;
	Wed,  7 Feb 2024 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272400; cv=none; b=uNdjxtQRwRDlG59T29KbFAg0YH33Zse5RQ5gmT10UQYGFfZMcrdjkHPB9lbEx9cQf5aNeIWKmj7VhDmKtxa/ilBwOUYCT7/iukILyZsoKmVHZoIgt0ZmJAF4/b4widy/fOcluxIhbey5VsHJIScwq1Vr4kkF+Egtlh9gtdc+QBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272400; c=relaxed/simple;
	bh=70uIplFj6tYmIaM2+/hdbOkFRGVdFZN4V4RRhP1FyCA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok5HRpQHxeaqvXwpC6kfGrbiiUHGWcnxedL3Int/PAK5z6P9ctBFMMHkhjCbHhgEwIRFPLF6EbwaHN/Pn5Uq0nZy9ZHh/dur7u0r8EpAjA7V4+r1X0vQOEzUMwqRqu6eLi6qLiXE3LZa+WkCcs55wBMGNziao8IRx+v7DPQL95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=iM+5XBYy; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707272395; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=z5XFUY+97aQgYz9qIycNQwP7iD9Nqzay3ltOgamXdOE=;
	b=iM+5XBYypPqRqVkX7SSdMAFhYxUxL+5jwHujoF6KahwLpbJbrlyCWX1Lc7IykOcWQk2UVajwGD1H/xOf40kgNxtXZvRfgO2BPTY/Hrgm2iM5SNEExsM6oChVhum0G2dmF9NXeo10qxkesjKzrCzlmFhVRm9r5zNSsGoI7yWyEOk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xiangzao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W0F5hYM_1707272393;
Received: from localhost.localdomain(mailfrom:xiangzao@linux.alibaba.com fp:SMTPD_---0W0F5hYM_1707272393)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 10:19:54 +0800
From: Yuanhe Shu <xiangzao@linux.alibaba.com>
To: keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	shuah@kernel.org,
	corbet@lwn.net
Cc: xlpang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yuanhe Shu <xiangzao@linux.alibaba.com>
Subject: [PATCH 3/3] tools/testing: adjust pstore backend related selftest
Date: Wed,  7 Feb 2024 10:19:21 +0800
Message-Id: <20240207021921.206425-4-xiangzao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
References: <20240207021921.206425-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pstore now supports multiple backends, the module parameter
pstore.backend varies from 'registered backend' to 'backends that are
allowed to register'. Adjust selftests to match the change.

Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>
---
 tools/testing/selftests/pstore/common_tests   |  8 +--
 .../selftests/pstore/pstore_post_reboot_tests | 65 ++++++++++---------
 tools/testing/selftests/pstore/pstore_tests   |  2 +-
 3 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/pstore/common_tests b/tools/testing/selftests/pstore/common_tests
index 4509f0cc9c91..497e6fc3215f 100755
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
+backends=$(dmesg | sed -n 's/.*pstore: Registered \(.*\) as persistent store backend.*/\1/p')
 show_result $?
-prlog -e "\tbackend=${backend}"
+prlog -e "\tbackends="$backends
 prlog -e "\tcmdline=`cat /proc/cmdline`"
 if [ $rc -ne 0 ]; then
     exit 1
diff --git a/tools/testing/selftests/pstore/pstore_post_reboot_tests b/tools/testing/selftests/pstore/pstore_post_reboot_tests
index d6da5e86efbf..9e40ccb9c918 100755
--- a/tools/testing/selftests/pstore/pstore_post_reboot_tests
+++ b/tools/testing/selftests/pstore/pstore_post_reboot_tests
@@ -36,45 +36,46 @@ else
 fi
 
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


