Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AFF7990EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 22:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbjIHUT2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 16:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjIHUT2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 16:19:28 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDC958E;
        Fri,  8 Sep 2023 13:19:23 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.120])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1368C212B5C9;
        Fri,  8 Sep 2023 13:19:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1368C212B5C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694204362;
        bh=dquOv3dRAsWU7zZ/8ALd/SttxVRTrgGAgsVuK3vyB2U=;
        h=From:To:Cc:Subject:Date:From;
        b=nv0PCRTKs3ZvQgZlzeccLicvgGiDRpBH/9uJr8v3taiJCSrEJJIpPdErqduiM+dtR
         8g/bu3A0H0RPrQrCTLsDGm6Jc4JIbFnmWnJ0vdj6LUouvtboJWDoaxOK+AhgsJzI4h
         VJnO9oGwsnw4ee0mXzUiKj+XtgVCK/ewqjj1BDxs=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        broonie@kernel.org, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, arnd@arndb.de
Subject: [PATCH v2] selftests/user_events: Fix failures when user_events is not installed
Date:   Fri,  8 Sep 2023 20:19:16 +0000
Message-Id: <20230908201916.562-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When user_events is not installed the self tests currently fail. Now
that these self tests run by default we need to ensure they don't fail
when user_events was not enabled for the kernel being tested.

Add common methods to detect if tracefs and user_events is enabled. If
either is not enabled skip the test. If tracefs is enabled, but is not
mounted, mount tracefs and fail if there were any errors. Fail if not
run as root.

Fixes: 68b4d2d58389 ("selftests/user_events: Reenable build")
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/all/CA+G9fYuugZ0OMeS6HvpSS4nuf_A3s455ecipGBvER0LJHojKZg@mail.gmail.com/

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
V2 Changes:
  Moved to stat() for existence checks vs open()/close().

 .../testing/selftests/user_events/abi_test.c  |   3 +
 .../testing/selftests/user_events/dyn_test.c  |   2 +
 .../selftests/user_events/ftrace_test.c       |   3 +
 .../testing/selftests/user_events/perf_test.c |   3 +
 .../user_events/user_events_selftests.h       | 100 ++++++++++++++++++
 5 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/user_events/user_events_selftests.h

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 5125c42efe65..22374d29ffdd 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 
 #include "../kselftest_harness.h"
+#include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__abi_event/enable";
@@ -93,6 +94,8 @@ FIXTURE(user) {
 };
 
 FIXTURE_SETUP(user) {
+	USER_EVENT_FIXTURE_SETUP(return);
+
 	change_event(false);
 	self->check = 0;
 }
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 91a4444ad42b..32c827a52d7d 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "user_events_selftests.h"
 
 const char *abi_file = "/sys/kernel/tracing/user_events_data";
 const char *enable_file = "/sys/kernel/tracing/events/user_events/__test_event/enable";
@@ -146,6 +147,7 @@ FIXTURE(user) {
 };
 
 FIXTURE_SETUP(user) {
+	USER_EVENT_FIXTURE_SETUP(return);
 }
 
 FIXTURE_TEARDOWN(user) {
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 5beb0aef1d81..6a260caeeddc 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *status_file = "/sys/kernel/tracing/user_events_status";
@@ -206,6 +207,8 @@ FIXTURE(user) {
 };
 
 FIXTURE_SETUP(user) {
+	USER_EVENT_FIXTURE_SETUP(return);
+
 	self->status_fd = open(status_file, O_RDONLY);
 	ASSERT_NE(-1, self->status_fd);
 
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 8b09be566fa2..f893398cda05 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -17,6 +17,7 @@
 #include <asm/unistd.h>
 
 #include "../kselftest_harness.h"
+#include "user_events_selftests.h"
 
 const char *data_file = "/sys/kernel/tracing/user_events_data";
 const char *id_file = "/sys/kernel/tracing/events/user_events/__test_event/id";
@@ -113,6 +114,8 @@ FIXTURE(user) {
 };
 
 FIXTURE_SETUP(user) {
+	USER_EVENT_FIXTURE_SETUP(return);
+
 	self->data_fd = open(data_file, O_RDWR);
 	ASSERT_NE(-1, self->data_fd);
 }
diff --git a/tools/testing/selftests/user_events/user_events_selftests.h b/tools/testing/selftests/user_events/user_events_selftests.h
new file mode 100644
index 000000000000..690378942f82
--- /dev/null
+++ b/tools/testing/selftests/user_events/user_events_selftests.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _USER_EVENTS_SELFTESTS_H
+#define _USER_EVENTS_SELFTESTS_H
+
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/mount.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include "../kselftest.h"
+
+static inline bool tracefs_enabled(char **message, bool *fail)
+{
+	struct stat buf;
+	int ret;
+
+	*message = "";
+	*fail = false;
+
+	/* Ensure tracefs is installed */
+	ret = stat("/sys/kernel/tracing", &buf);
+
+	if (ret == -1) {
+		*message = "Tracefs is not installed";
+		return false;
+	}
+
+	/* Ensure mounted tracefs */
+	ret = stat("/sys/kernel/tracing/README", &buf);
+
+	if (ret == -1 && errno == ENOENT) {
+		if (mount(NULL, "/sys/kernel/tracing", "tracefs", 0, NULL) != 0) {
+			*message = "Cannot mount tracefs";
+			*fail = true;
+			return false;
+		}
+
+		ret = stat("/sys/kernel/tracing/README", &buf);
+	}
+
+	if (ret == -1) {
+		*message = "Cannot access tracefs";
+		*fail = true;
+		return false;
+	}
+
+	return true;
+}
+
+static inline bool user_events_enabled(char **message, bool *fail)
+{
+	struct stat buf;
+	int ret;
+
+	*message = "";
+	*fail = false;
+
+	if (getuid() != 0) {
+		*message = "Must be run as root";
+		*fail = true;
+		return false;
+	}
+
+	if (!tracefs_enabled(message, fail))
+		return false;
+
+	/* Ensure user_events is installed */
+	ret = stat("/sys/kernel/tracing/user_events_data", &buf);
+
+	if (ret == -1) {
+		switch (errno) {
+		case ENOENT:
+			*message = "user_events is not installed";
+			return false;
+
+		default:
+			*message = "Cannot access user_events_data";
+			*fail = true;
+			return false;
+		}
+	}
+
+	return true;
+}
+
+#define USER_EVENT_FIXTURE_SETUP(statement) do { \
+	char *message; \
+	bool fail; \
+	if (!user_events_enabled(&message, &fail)) { \
+		if (fail) { \
+			TH_LOG("Setup failed due to: %s", message); \
+			ASSERT_FALSE(fail); \
+		} \
+		SKIP(statement, "Skipping due to: %s", message); \
+	} \
+} while (0)
+
+#endif /* _USER_EVENTS_SELFTESTS_H */

base-commit: 9b1db732866bee060b9bca9493e5ebf5e8874c48
-- 
2.34.1

