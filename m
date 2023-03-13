Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD46B83DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Mar 2023 22:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCMVSg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Mar 2023 17:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjCMVSf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Mar 2023 17:18:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6064584B3;
        Mon, 13 Mar 2023 14:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 361B6614F1;
        Mon, 13 Mar 2023 21:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93956C433EF;
        Mon, 13 Mar 2023 21:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678742295;
        bh=6mjt9yhry9OZrGSoFR8oPMv/MhGYAYm5/QiZHqwgr3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=SALdwbEY67uvSj2NKIONHf4FyVXtnGDxNlObLGFUagGwVN6ayhPWsXf3i4zYs8RFv
         UH3MjeVdE4evNvqVpwAGOpINbdEBSnoUfb80mWBjePkoqSH7RA3/e6vk5zo5UOSADS
         y8Kmpr6hzjYvbFcaKD0cx8dwZ9k4BUWJryD0iaVSKQ4YBXRqZDyGiCPFkgrhgSTu4/
         IhdPoofNqzzGwVim6/IrdXd/mO/KiEhwfMlYv6Et70EBQ1hcMG+++5wcaUKDwLd0rD
         vO47Vf0yxE7NdcPT/1qbCcqmsIebO+im14pbhnuNDFtG9SUKQCMLksghODxr9lhtWo
         8K7ROvfOyUd0w==
From:   Ross Zwisler <zwisler@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v4 1/3] selftests: use canonical ftrace path
Date:   Mon, 13 Mar 2023 15:17:43 -0600
Message-Id: <20230313211746.1541525-1-zwisler@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ross Zwisler <zwisler@google.com>

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in tools/testing/selftests still refer to this older debugfs
path, so let's update them to avoid confusion.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Signed-off-by: Ross Zwisler <zwisler@google.com>
---

v3 here:
https://lore.kernel.org/all/20230310192050.4096886-1-zwisler@kernel.org/

Changes from v3:
 * Added Reviwed-by from Steven to patch 2
 * Rebased onto the current linux/master

 tools/testing/selftests/mm/protection_keys.c      |  4 ++--
 tools/testing/selftests/user_events/dyn_test.c    |  2 +-
 tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
 tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 95f403a0c46d..0381c34fdd56 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -98,7 +98,7 @@ int tracing_root_ok(void)
 void tracing_on(void)
 {
 #if CONTROL_TRACING > 0
-#define TRACEDIR "/sys/kernel/debug/tracing"
+#define TRACEDIR "/sys/kernel/tracing"
 	char pidstr[32];
 
 	if (!tracing_root_ok())
@@ -124,7 +124,7 @@ void tracing_off(void)
 #if CONTROL_TRACING > 0
 	if (!tracing_root_ok())
 		return;
-	cat_into_file("0", "/sys/kernel/debug/tracing/tracing_on");
+	cat_into_file("0", "/sys/kernel/tracing/tracing_on");
 #endif
 }
 
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index d6265d14cd51..8879a7b04c6a 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -16,7 +16,7 @@
 
 #include "../kselftest_harness.h"
 
-const char *dyn_file = "/sys/kernel/debug/tracing/dynamic_events";
+const char *dyn_file = "/sys/kernel/tracing/dynamic_events";
 const char *clear = "!u:__test_event";
 
 static int Append(const char *value)
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 404a2713dcae..a0b2c96eb252 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -16,11 +16,11 @@
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *enable_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/enable";
-const char *trace_file = "/sys/kernel/debug/tracing/trace";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
+const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
+const char *trace_file = "/sys/kernel/tracing/trace";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 static inline int status_check(char *status_page, int status_bit)
 {
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 8b4c7879d5a7..31505642aa9b 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -18,10 +18,10 @@
 
 #include "../kselftest_harness.h"
 
-const char *data_file = "/sys/kernel/debug/tracing/user_events_data";
-const char *status_file = "/sys/kernel/debug/tracing/user_events_status";
-const char *id_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/id";
-const char *fmt_file = "/sys/kernel/debug/tracing/events/user_events/__test_event/format";
+const char *data_file = "/sys/kernel/tracing/user_events_data";
+const char *status_file = "/sys/kernel/tracing/user_events_status";
+const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
+const char *fmt_file = "/sys/kernel/tracing/events/user_events/__test_event/format";
 
 struct event {
 	__u32 index;

base-commit: fc89d7fb499b0162e081f434d45e8d1b47e82ece
-- 
2.40.0.rc1.284.g88254d51c5-goog

