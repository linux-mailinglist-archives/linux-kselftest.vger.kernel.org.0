Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA3D8F9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2019 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfJPLdW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Oct 2019 07:33:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:35626 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728838AbfJPLdW (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Oct 2019 07:33:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64620B1B1;
        Wed, 16 Oct 2019 11:33:19 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     rostedt@goodmis.org, mingo@redhat.com, jpoimboe@redhat.com,
        jikos@kernel.org, pmladek@suse.com, joe.lawrence@redhat.com
Cc:     linux-kernel@vger.kernel.org, live-patching@vger.kernel.org,
        shuah@kernel.org, kamalesh@linux.vnet.ibm.com,
        linux-kselftest@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v3 2/3] selftests/livepatch: Make dynamic debug setup and restore generic
Date:   Wed, 16 Oct 2019 13:33:14 +0200
Message-Id: <20191016113316.13415-3-mbenes@suse.cz>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016113316.13415-1-mbenes@suse.cz>
References: <20191016113316.13415-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

Livepatch selftests currently save the current dynamic debug config and
tweak it for the selftests. The config is restored at the end. Make the
infrastructure generic, so that more variables can be saved and
restored.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---
 .../testing/selftests/livepatch/functions.sh  | 22 +++++++++++--------
 .../selftests/livepatch/test-callbacks.sh     |  2 +-
 .../selftests/livepatch/test-livepatch.sh     |  2 +-
 .../selftests/livepatch/test-shadow-vars.sh   |  2 +-
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 79b0affd21fb..b7e5a67ae434 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -29,29 +29,33 @@ function die() {
 	exit 1
 }
 
-function push_dynamic_debug() {
-        DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
-                awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
+function push_config() {
+	DYNAMIC_DEBUG=$(grep '^kernel/livepatch' /sys/kernel/debug/dynamic_debug/control | \
+			awk -F'[: ]' '{print "file " $1 " line " $2 " " $4}')
 }
 
-function pop_dynamic_debug() {
+function pop_config() {
 	if [[ -n "$DYNAMIC_DEBUG" ]]; then
 		echo -n "$DYNAMIC_DEBUG" > /sys/kernel/debug/dynamic_debug/control
 	fi
 }
 
-# set_dynamic_debug() - save the current dynamic debug config and tweak
-# 			it for the self-tests.  Set a script exit trap
-#			that restores the original config.
 function set_dynamic_debug() {
-        push_dynamic_debug
-        trap pop_dynamic_debug EXIT INT TERM HUP
         cat <<-EOF > /sys/kernel/debug/dynamic_debug/control
 		file kernel/livepatch/* +p
 		func klp_try_switch_task -p
 		EOF
 }
 
+# setup_config - save the current config and set a script exit trap that
+#		 restores the original config.  Setup the dynamic debug
+#		 for verbose livepatching output.
+function setup_config() {
+	push_config
+	set_dynamic_debug
+	trap pop_config EXIT INT TERM HUP
+}
+
 # loop_until(cmd) - loop a command until it is successful or $MAX_RETRIES,
 #		    sleep $RETRY_INTERVAL between attempts
 #	cmd - command and its arguments to run
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index e97a9dcb73c7..a35289b13c9c 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -9,7 +9,7 @@ MOD_LIVEPATCH2=test_klp_callbacks_demo2
 MOD_TARGET=test_klp_callbacks_mod
 MOD_TARGET_BUSY=test_klp_callbacks_busy
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: target module before livepatch
diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
index f05268aea859..493e3df415a1 100755
--- a/tools/testing/selftests/livepatch/test-livepatch.sh
+++ b/tools/testing/selftests/livepatch/test-livepatch.sh
@@ -7,7 +7,7 @@
 MOD_LIVEPATCH=test_klp_livepatch
 MOD_REPLACE=test_klp_atomic_replace
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: basic function patching
diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
index 04a37831e204..1aae73299114 100755
--- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
+++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
@@ -6,7 +6,7 @@
 
 MOD_TEST=test_klp_shadow_vars
 
-set_dynamic_debug
+setup_config
 
 
 # TEST: basic shadow variable API
-- 
2.23.0

