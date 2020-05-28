Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE9C11E62B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 May 2020 15:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390550AbgE1NtC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 May 2020 09:49:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53503 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390514AbgE1NtB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 May 2020 09:49:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590673739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJL20W3ir/b9MVshm2OPM91U5HXtTb+5zv6fUX0lrTk=;
        b=HtT/Njkv8+nbSIQvIVK9aSqxJsCJUcUcBR7szaTro33Y//AGxtP8uj057u+PJSh8d61C2z
        C2Kcj7vDAAHRVF/YkLw1nz09DhvcpZczwrJLvd2xC6Mx0CmSR/PeJnCPZh/pXXw02KREtI
        uYPjxKX6jF+UkIxYJjNevGT4LZGKyNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-bU2HXs-YPTyO22tTMBRIRg-1; Thu, 28 May 2020 09:48:57 -0400
X-MC-Unique: bU2HXs-YPTyO22tTMBRIRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 628CD107ACCA;
        Thu, 28 May 2020 13:48:56 +0000 (UTC)
Received: from dm.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D20B9797EB;
        Thu, 28 May 2020 13:48:55 +0000 (UTC)
From:   Yannick Cote <ycote@redhat.com>
To:     live-patching@vger.kernel.org
Cc:     linux-kselftest@vger.kernel.org, joe.lawrence@redhat.com
Subject: [PATCH 1/4] selftests/livepatch: rework test-klp-callbacks to use completion variables
Date:   Thu, 28 May 2020 09:48:46 -0400
Message-Id: <20200528134849.7890-2-ycote@redhat.com>
In-Reply-To: <20200528134849.7890-1-ycote@redhat.com>
References: <20200528134849.7890-1-ycote@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Joe Lawrence <joe.lawrence@redhat.com>

The test-klp-callbacks script includes a few tests which rely on kernel
task timings that may not always execute as expected under system load.
These will generate out of sequence kernel log messages that result in
test failure.

Instead of using sleep timing windows to orchestrate the test, rework
the test_klp_callbacks_busy module to use completion variables.

Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Yannick Cote <ycote@redhat.com>
---
 lib/livepatch/test_klp_callbacks_busy.c       | 42 +++++++++++++++----
 .../selftests/livepatch/test-callbacks.sh     | 29 +++++++------
 2 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/lib/livepatch/test_klp_callbacks_busy.c
index 40beddf8a0e2..c3df12f47e5e 100644
--- a/lib/livepatch/test_klp_callbacks_busy.c
+++ b/lib/livepatch/test_klp_callbacks_busy.c
@@ -5,34 +5,58 @@
 
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
+static DECLARE_COMPLETION(busymod_work_complete);
 
 static void busymod_work_func(struct work_struct *work)
 {
-	pr_info("%s, sleeping %d seconds ...\n", __func__, sleep_secs);
-	msleep(sleep_secs * 1000);
+	bool early_complete = block_transition;
+
+	pr_info("%s enter\n", __func__);
+
+	/*
+	 * When blocking the livepatch transition, set completion flag
+	 * early so subsequent test commands see the transition.
+	 */
+	if (early_complete)
+		complete(&busymod_work_complete);
+
+	while (block_transition)
+		msleep(1000);
+
 	pr_info("%s exit\n", __func__);
+
+	/*
+	 * In non-blocking case, wait until we're done to complete to
+	 * ensure kernel log ordering
+	 */
+	if (!early_complete)
+		complete(&busymod_work_complete);
 }
 
 static int test_klp_callbacks_busy_init(void)
 {
 	pr_info("%s\n", __func__);
-	schedule_delayed_work(&work,
-		msecs_to_jiffies(1000 * 0));
+	schedule_work(&work);
+	wait_for_completion(&busymod_work_complete);
+
 	return 0;
 }
 
 static void test_klp_callbacks_busy_exit(void)
 {
-	cancel_delayed_work_sync(&work);
+	block_transition = false;
+	cancel_work_sync(&work);
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

