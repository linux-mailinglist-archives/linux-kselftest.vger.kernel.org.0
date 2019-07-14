Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 061F367F44
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Jul 2019 16:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbfGNO2e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 14 Jul 2019 10:28:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNO2e (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 14 Jul 2019 10:28:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 11CFCC058CBA;
        Sun, 14 Jul 2019 14:28:34 +0000 (UTC)
Received: from jlaw-desktop.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 823365D9D6;
        Sun, 14 Jul 2019 14:28:32 +0000 (UTC)
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     shuah@kernel.org
Subject: [PATCH] selftests/livepatch: add test skip handling
Date:   Sun, 14 Jul 2019 10:28:29 -0400
Message-Id: <20190714142829.29458-1-joe.lawrence@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 14 Jul 2019 14:28:34 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before running a livpeatch self-test, first verify that we've built and
installed the livepatch self-test kernel modules by running a 'modprobe
--dry-run'.  This should catch a few environment issues, including
!CONFIG_LIVEPATCH and !CONFIG_TEST_LIVEPATCH.  In these cases, exit
gracefully with test-skip status rather than test-fail status.

Reported-by: Jiri Benc <jbenc@redhat.com>
Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 tools/testing/selftests/livepatch/functions.sh | 18 ++++++++++++++++++
 .../selftests/livepatch/test-callbacks.sh      |  5 +++++
 .../selftests/livepatch/test-livepatch.sh      |  3 +++
 .../selftests/livepatch/test-shadow-vars.sh    |  2 ++
 4 files changed, 28 insertions(+)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 30195449c63c..92d6cfb49365 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -13,6 +13,14 @@ function log() {
 	echo "$1" > /dev/kmsg
 }
 
+# skip(msg) - testing can't proceed
+#	msg - explanation
+function skip() {
+	log "SKIP: $1"
+	echo "SKIP: $1" >&2
+	exit 4
+}
+
 # die(msg) - game over, man
 #	msg - dying words
 function die() {
@@ -43,6 +51,16 @@ function loop_until() {
 	done
 }
 
+function assert_mod() {
+	local mod="$1"
+
+	if ! modprobe --dry-run "$mod" &>/dev/null ; then
+		skip "Failed modprobe --dry-run of module: $mod"
+	fi
+
+	return 1
+}
+
 function is_livepatch_mod() {
 	local mod="$1"
 
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index e97a9dcb73c7..87a407cee7fd 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -9,6 +9,11 @@ MOD_LIVEPATCH2=test_klp_callbacks_demo2
 MOD_TARGET=test_klp_callbacks_mod
 MOD_TARGET_BUSY=test_klp_callbacks_busy
 
+assert_mod $MOD_LIVEPATCH
+assert_mod $MOD_LIVEPATCH2
+assert_mod $MOD_TARGET
+assert_mod $MOD_TARGET_BUSY
+
 set_dynamic_debug
 
 
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index f05268aea859..8d3b75ceeeff 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -7,6 +7,9 @@
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_REPLACE=test_klp_atomic_replace
 
+assert_mod $MOD_LIVEPATCH
+assert_mod $MOD_REPLACE
+
 set_dynamic_debug
 
 
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 04a37831e204..1ab09bc50363 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -6,6 +6,8 @@
 
 MOD_TEST=test_klp_shadow_vars
 
+assert_mod $MOD_TEST
+
 set_dynamic_debug
 
 
-- 
2.21.0

