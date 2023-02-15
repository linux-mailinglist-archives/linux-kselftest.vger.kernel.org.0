Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58F56987F1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Feb 2023 23:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBOWeD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Feb 2023 17:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjBOWeB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:01 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D043608F
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Feb 2023 14:33:59 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id i6so170395ilk.5
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Feb 2023 14:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lP7i4Vg5vCi45+1jZsWESpRSmXH35ZniV9m1/+tW+Hk=;
        b=nkZL9fJ4DuIlF/CtEtVuUWG1NHpyIExHBSMUpvG++W5Ao+0jTazceFPQ+qafDgTzZN
         P+qX432q5PjnU01ridwbkLLkiU0rTtSZdXZEQd/FetfZiE1KzwwCeQCqOizI8U6m/CdR
         qCDN90d6J3zjeKTJ5KEfh+qukVjCgjja+cIZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lP7i4Vg5vCi45+1jZsWESpRSmXH35ZniV9m1/+tW+Hk=;
        b=fHdPwumIjuQ7yOzpJLrRUkVkzU3kfmZ5n0ZRreBNsDDrVjyAXLHklAYdawLjJfNn8r
         ucF83KO3I3fq8us7zTKO/bI3qXPUkzIadPKe+fy0NmlyvWI8SWdl42Kro6iWVzZFMRGp
         ilnG81IQRCY821zg3eVOiMVoX/DOOqktcEqhkBy8uU2iWCwG1ZGhnP8dRTbqUNWdyQ2e
         wGXkLEeJyCPep8APKXMdnDj5OTXGTULiJQ1G5FTWigUiJMAwfbkW3/iSsisGxofdbMFF
         T4KXZHyl6ZININejXVAQjnRiA5ICJzczqgXU6siBiegU8I2Ytl4a8/+wyln2UeTKYd1m
         442g==
X-Gm-Message-State: AO0yUKXHU/8Mcodv9tHRO1gUD2K6oPT34UmFz7k8xrZ1E/btGFLYEY0P
        0Fn7sWbbhj2R/tJ38kz0sUjm6g==
X-Google-Smtp-Source: AK7set/iT57WkSxfAxsAOUoPZU2et6o/KodiZpe6LUgEgddn6Z+TYNMWbr3f09Z6/v0pnuZZ8Xenpg==
X-Received: by 2002:a05:6e02:1d91:b0:315:7004:3e6c with SMTP id h17-20020a056e021d9100b0031570043e6cmr3354878ila.23.1676500439322;
        Wed, 15 Feb 2023 14:33:59 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:33:59 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 2/6] selftests: use canonical ftrace path
Date:   Wed, 15 Feb 2023 15:33:46 -0700
Message-Id: <20230215223350.2658616-3-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
In-Reply-To: <20230215223350.2658616-1-zwisler@google.com>
References: <20230215223350.2658616-1-zwisler@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

A few spots in tools/testing/selftests still refer to this older debugfs
path, so let's update them to avoid confusion.

Signed-off-by: Ross Zwisler <zwisler@google.com>
---
 tools/testing/selftests/user_events/dyn_test.c    |  2 +-
 tools/testing/selftests/user_events/ftrace_test.c | 10 +++++-----
 tools/testing/selftests/user_events/perf_test.c   |  8 ++++----
 tools/testing/selftests/vm/protection_keys.c      |  4 ++--
 4 files changed, 12 insertions(+), 12 deletions(-)

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
diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index 95f403a0c46d..0381c34fdd56 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
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
 
-- 
2.39.1.637.g21b0678d19-goog

