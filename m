Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F557A2A75
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 00:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237800AbjIOW2e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 18:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbjIOW2E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 18:28:04 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F0DC183;
        Fri, 15 Sep 2023 15:27:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.125])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6992C212BE7E;
        Fri, 15 Sep 2023 15:27:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6992C212BE7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1694816878;
        bh=/8z3AEQ24YTro7keEG8buhoc3usXHslsxfG7k0QXs58=;
        h=From:To:Cc:Subject:Date:From;
        b=qeLI7rvg0vt3CAIUEnCNwCBwjgpY8sq1g2DwUns2Ca1BeSsCzQu2PwnqWHl/CGojs
         2oW26WfgE74X3BCVrEm5X5VKimtDnSjuEyuCQGOUolvsjJd0R/QcaVdIaV/oaC5Lfz
         fUqmnK+ytI0UscqZkEhpkaSRNJtA+egBKnZl4CmY=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, shuah@kernel.org, mhiramat@kernel.org,
        broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/user_events: Fix to unmount tracefs when test created mount
Date:   Fri, 15 Sep 2023 22:27:54 +0000
Message-Id: <20230915222754.16591-1-beaub@linux.microsoft.com>
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

Fix to unmount tracefs if the self-test mounted it to allow testing.
If tracefs was already mounted, this does nothing.

Suggested-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/all/29fce076-746c-4650-8358-b4e0fa215cf7@sirena.org.uk/
Fixes: a06023a8f78d ("selftests/user_events: Fix failures when user_events is not installed")

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 .../testing/selftests/user_events/abi_test.c  |  4 +++-
 .../testing/selftests/user_events/dyn_test.c  |  5 +++-
 .../selftests/user_events/ftrace_test.c       |  5 +++-
 .../testing/selftests/user_events/perf_test.c |  5 +++-
 .../user_events/user_events_selftests.h       | 24 +++++++++++++++----
 5 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 22374d29ffdd..8202f1327c39 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -91,16 +91,18 @@ static int reg_disable(long *enable, int bit)
 
 FIXTURE(user) {
 	long check;
+	bool umount;
 };
 
 FIXTURE_SETUP(user) {
-	USER_EVENT_FIXTURE_SETUP(return);
+	USER_EVENT_FIXTURE_SETUP(return, self->umount);
 
 	change_event(false);
 	self->check = 0;
 }
 
 FIXTURE_TEARDOWN(user) {
+	USER_EVENT_FIXTURE_TEARDOWN(self->umount);
 }
 
 TEST_F(user, enablement) {
diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
index 32c827a52d7d..a85980190bea 100644
--- a/tools/testing/selftests/user_events/dyn_test.c
+++ b/tools/testing/selftests/user_events/dyn_test.c
@@ -144,13 +144,16 @@ do { \
 
 FIXTURE(user) {
 	int check;
+	bool umount;
 };
 
 FIXTURE_SETUP(user) {
-	USER_EVENT_FIXTURE_SETUP(return);
+	USER_EVENT_FIXTURE_SETUP(return, self->umount);
 }
 
 FIXTURE_TEARDOWN(user) {
+	USER_EVENT_FIXTURE_TEARDOWN(self->umount);
+
 	wait_for_delete();
 }
 
diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index 6a260caeeddc..dcd7509fe2e0 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -204,10 +204,11 @@ FIXTURE(user) {
 	int data_fd;
 	int enable_fd;
 	int check;
+	bool umount;
 };
 
 FIXTURE_SETUP(user) {
-	USER_EVENT_FIXTURE_SETUP(return);
+	USER_EVENT_FIXTURE_SETUP(return, self->umount);
 
 	self->status_fd = open(status_file, O_RDONLY);
 	ASSERT_NE(-1, self->status_fd);
@@ -219,6 +220,8 @@ FIXTURE_SETUP(user) {
 }
 
 FIXTURE_TEARDOWN(user) {
+	USER_EVENT_FIXTURE_TEARDOWN(self->umount);
+
 	close(self->status_fd);
 	close(self->data_fd);
 
diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index f893398cda05..5288e768b207 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -111,16 +111,19 @@ static int clear(int *check)
 FIXTURE(user) {
 	int data_fd;
 	int check;
+	bool umount;
 };
 
 FIXTURE_SETUP(user) {
-	USER_EVENT_FIXTURE_SETUP(return);
+	USER_EVENT_FIXTURE_SETUP(return, self->umount);
 
 	self->data_fd = open(data_file, O_RDWR);
 	ASSERT_NE(-1, self->data_fd);
 }
 
 FIXTURE_TEARDOWN(user) {
+	USER_EVENT_FIXTURE_TEARDOWN(self->umount);
+
 	close(self->data_fd);
 
 	if (clear(&self->check) != 0)
diff --git a/tools/testing/selftests/user_events/user_events_selftests.h b/tools/testing/selftests/user_events/user_events_selftests.h
index 690378942f82..e1c3c063c031 100644
--- a/tools/testing/selftests/user_events/user_events_selftests.h
+++ b/tools/testing/selftests/user_events/user_events_selftests.h
@@ -11,13 +11,19 @@
 
 #include "../kselftest.h"
 
-static inline bool tracefs_enabled(char **message, bool *fail)
+static inline void tracefs_unmount(void)
+{
+	umount("/sys/kernel/tracing");
+}
+
+static inline bool tracefs_enabled(char **message, bool *fail, bool *umount)
 {
 	struct stat buf;
 	int ret;
 
 	*message = "";
 	*fail = false;
+	*umount = false;
 
 	/* Ensure tracefs is installed */
 	ret = stat("/sys/kernel/tracing", &buf);
@@ -37,6 +43,8 @@ static inline bool tracefs_enabled(char **message, bool *fail)
 			return false;
 		}
 
+		*umount = true;
+
 		ret = stat("/sys/kernel/tracing/README", &buf);
 	}
 
@@ -49,13 +57,14 @@ static inline bool tracefs_enabled(char **message, bool *fail)
 	return true;
 }
 
-static inline bool user_events_enabled(char **message, bool *fail)
+static inline bool user_events_enabled(char **message, bool *fail, bool *umount)
 {
 	struct stat buf;
 	int ret;
 
 	*message = "";
 	*fail = false;
+	*umount = false;
 
 	if (getuid() != 0) {
 		*message = "Must be run as root";
@@ -63,7 +72,7 @@ static inline bool user_events_enabled(char **message, bool *fail)
 		return false;
 	}
 
-	if (!tracefs_enabled(message, fail))
+	if (!tracefs_enabled(message, fail, umount))
 		return false;
 
 	/* Ensure user_events is installed */
@@ -85,10 +94,10 @@ static inline bool user_events_enabled(char **message, bool *fail)
 	return true;
 }
 
-#define USER_EVENT_FIXTURE_SETUP(statement) do { \
+#define USER_EVENT_FIXTURE_SETUP(statement, umount) do { \
 	char *message; \
 	bool fail; \
-	if (!user_events_enabled(&message, &fail)) { \
+	if (!user_events_enabled(&message, &fail, &(umount))) { \
 		if (fail) { \
 			TH_LOG("Setup failed due to: %s", message); \
 			ASSERT_FALSE(fail); \
@@ -97,4 +106,9 @@ static inline bool user_events_enabled(char **message, bool *fail)
 	} \
 } while (0)
 
+#define USER_EVENT_FIXTURE_TEARDOWN(umount) do { \
+	if ((umount))  \
+		tracefs_unmount(); \
+} while (0)
+
 #endif /* _USER_EVENTS_SELFTESTS_H */

base-commit: 7e021da80f48582171029714f8a487347f29dddb
-- 
2.34.1

