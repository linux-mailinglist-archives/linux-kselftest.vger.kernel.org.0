Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF3561ED60D
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jun 2020 20:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFCSVm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jun 2020 14:21:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726087AbgFCSVm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jun 2020 14:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591208500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAac06P3giR5I4Nc3J9vi1Ip90+x7WJLQsxk772I3oE=;
        b=eSj3sSutCTgPIZrPN+bvJkTApoqEaTuNKjMBPwh3eXuc8hx84qJ7OetzMWfcIpZvnlduST
        1CsXjblQrnCoHWsMqDu1GVey+9lqmvij5pr5WXpxOMbhNrEgXenu+Nvfjx5YiOBecT5HOU
        EWNx3Z+6Dy2oPcT+J30mEb3DWsVtraw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-0WpOuRSGP_6tlyvkYlfIIg-1; Wed, 03 Jun 2020 14:21:35 -0400
X-MC-Unique: 0WpOuRSGP_6tlyvkYlfIIg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9D1A71800D42;
        Wed,  3 Jun 2020 18:21:34 +0000 (UTC)
Received: from dm.redhat.com (unknown [10.10.67.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 938FD5D9CD;
        Wed,  3 Jun 2020 18:21:33 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com,
        linux-kernel@vger.kernel.org, pmladek@suse.com, mbenes@suse.cz,
        kamalesh@linux.vnet.ibm.com
Subject: [PATCH v2 1/4] selftests/livepatch: simplify test-klp-callbacks busy target tests
Date:   Wed,  3 Jun 2020 14:20:55 -0400
Message-Id: <20200603182058.109470-2-ycote@redhat.com>
In-Reply-To: <20200603182058.109470-1-ycote@redhat.com>
References: <20200603182058.109470-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

The test-klp-callbacks script includes a few tests which rely on kernel
task timings that may not always execute as expected under system load.
These may generate out of sequence kernel log messages that result in
test failure.

Instead of using sleep timing windows to orchestrate these tests, add a
block_transition module parameter to communicate the test purpose and
utilize flush_queue() to serialize the test module's task output.

Suggested-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
---
 lib/livepatch/test_klp_callbacks_busy.c       | 37 ++++++++++++++-----
 .../selftests/livepatch/test-callbacks.sh     | 29 +++++++--------
 2 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/lib/livepatch/test_klp_callbacks_busy.c
index 40beddf8a0e2..7ac845f65be5 100644
--- a/lib/livepatch/test_klp_callbacks_busy.c
+++ b/lib/livepatch/test_klp_callbacks_busy.c
@@ -5,34 +5,53 @@
 
 #include <linux/module.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/workqueue.h>
 #include <linux/delay.h>
 
-static int sleep_secs;
-module_param(sleep_secs, int, 0644);
-MODULE_PARM_DESC(sleep_secs, "sleep_secs (default=0)");
+/* load/run-time control from sysfs writer  */
+static bool block_transition;
+module_param(block_transition, bool, 0644);
+MODULE_PARM_DESC(block_transition, "block_transition (default=false)");
 
 static void busymod_work_func(struct work_struct *work);
-static DECLARE_DELAYED_WORK(work, busymod_work_func);
+static DECLARE_WORK(work, busymod_work_func);
 
 static void busymod_work_func(struct work_struct *work)
 {
-	pr_info("%s, sleeping %d seconds ...\n", __func__, sleep_secs);
-	msleep(sleep_secs * 1000);
+	pr_info("%s enter\n", __func__);
+
+	while (READ_ONCE(block_transition)) {
+		/*
+		 * Busy-wait until the sysfs writer has acknowledged a
+		 * blocked transition and clears the flag.
+		 */
+		msleep(20);
+	}
+
 	pr_info("%s exit\n", __func__);
 }
 
 static int test_klp_callbacks_busy_init(void)
 {
 	pr_info("%s\n", __func__);
-	schedule_delayed_work(&work,
-		msecs_to_jiffies(1000 * 0));
+	schedule_work(&work);
+
+	if (!block_transition) {
+		/*
+		 * Serialize output: print all messages from the work
+		 * function before returning from init().
+		 */
+		flush_work(&work);
+	}
+
 	return 0;
 }
 
 static void test_klp_callbacks_busy_exit(void)
 {
-	cancel_delayed_work_sync(&work);
+	WRITE_ONCE(block_transition, false);
+	flush_work(&work);
 	pr_info("%s\n", __func__);
 }
 
diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
index a35289b13c9c..32b57ba07f4f 100755
--- a/tools/testing/selftests/livepatch/test-callbacks.sh
+++ b/tools/testing/selftests/livepatch/test-callbacks.sh
@@ -356,9 +356,7 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 echo -n "TEST: multiple target modules ... "
 dmesg -C
 
-load_mod $MOD_TARGET_BUSY sleep_secs=0
-# give $MOD_TARGET_BUSY::busymod_work_func() a chance to run
-sleep 5
+load_mod $MOD_TARGET_BUSY block_transition=N
 load_lp $MOD_LIVEPATCH
 load_mod $MOD_TARGET
 unload_mod $MOD_TARGET
@@ -366,9 +364,9 @@ disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET_BUSY
 
-check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=0
+check_result "% modprobe $MOD_TARGET_BUSY block_transition=N
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
-$MOD_TARGET_BUSY: busymod_work_func, sleeping 0 seconds ...
+$MOD_TARGET_BUSY: busymod_work_func enter
 $MOD_TARGET_BUSY: busymod_work_func exit
 % modprobe $MOD_LIVEPATCH
 livepatch: enabling patch '$MOD_LIVEPATCH'
@@ -404,11 +402,10 @@ livepatch: '$MOD_LIVEPATCH': unpatching complete
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 
 
-
 # TEST: busy target module
 #
 # A similar test as the previous one, but force the "busy" kernel module
-# to do longer work.
+# to block the livepatch transition.
 #
 # The livepatching core will refuse to patch a task that is currently
 # executing a to-be-patched function -- the consistency model stalls the
@@ -417,8 +414,7 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 # function for a long time.  Meanwhile, load and unload other target
 # kernel modules while the livepatch transition is in progress.
 #
-# - Load the "busy" kernel module, this time make it do 10 seconds worth
-#   of work.
+# - Load the "busy" kernel module, this time make its work function loop
 #
 # - Meanwhile, the livepatch is loaded.  Notice that the patch
 #   transition does not complete as the targeted "busy" module is
@@ -438,20 +434,23 @@ $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_exit"
 echo -n "TEST: busy target module ... "
 dmesg -C
 
-load_mod $MOD_TARGET_BUSY sleep_secs=10
+load_mod $MOD_TARGET_BUSY block_transition=Y
 load_lp_nowait $MOD_LIVEPATCH
-# Don't wait for transition, load $MOD_TARGET while the transition
-# is still stalled in $MOD_TARGET_BUSY::busymod_work_func()
-sleep 5
+
+# Wait until the livepatch reports in-transition state, i.e. that it's
+# stalled on $MOD_TARGET_BUSY::busymod_work_func()
+loop_until 'grep -q '^1$' /sys/kernel/livepatch/$MOD_LIVEPATCH/transition' ||
+	die "failed to stall transition"
+
 load_mod $MOD_TARGET
 unload_mod $MOD_TARGET
 disable_lp $MOD_LIVEPATCH
 unload_lp $MOD_LIVEPATCH
 unload_mod $MOD_TARGET_BUSY
 
-check_result "% modprobe $MOD_TARGET_BUSY sleep_secs=10
+check_result "% modprobe $MOD_TARGET_BUSY block_transition=Y
 $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
-$MOD_TARGET_BUSY: busymod_work_func, sleeping 10 seconds ...
+$MOD_TARGET_BUSY: busymod_work_func enter
 % modprobe $MOD_LIVEPATCH
 livepatch: enabling patch '$MOD_LIVEPATCH'
 livepatch: '$MOD_LIVEPATCH': initializing patching transition
-- 
2.25.4

