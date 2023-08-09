Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6103A77660F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 19:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjHIREp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHIREo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 13:04:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4CE0E2107;
        Wed,  9 Aug 2023 10:04:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5F6139F;
        Wed,  9 Aug 2023 10:05:26 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 310843F59C;
        Wed,  9 Aug 2023 10:04:43 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests: landlock: skip all tests without landlock syscall
Date:   Wed,  9 Aug 2023 18:04:35 +0100
Message-Id: <20230809170435.1312162-3-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230809170435.1312162-1-andre.przywara@arm.com>
References: <20230809170435.1312162-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

"landlock" is a relatively new syscall, and most defconfigs do not enable
it (yet). On systems without this syscall available, the selftests fail
at the moment, instead of being skipped.

Check the availability of the landlock system call before executing each
test, and skip the rest of the tests if we get an ENOSYS back.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/landlock/base_test.c | 27 ++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 1e3b6de57e80e..c539cec775fba 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -21,12 +21,20 @@
 #define O_PATH 010000000
 #endif
 
+static bool has_syscall(void)
+{
+	return landlock_create_ruleset(NULL, 0, 0) == -1 && errno != ENOSYS;
+}
+
 TEST(inconsistent_attr)
 {
 	const long page_size = sysconf(_SC_PAGESIZE);
 	char *const buf = malloc(page_size + 1);
 	struct landlock_ruleset_attr *const ruleset_attr = (void *)buf;
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	ASSERT_NE(NULL, buf);
 
 	/* Checks copy_from_user(). */
@@ -75,6 +83,10 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
+
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	ASSERT_NE(0, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
@@ -107,6 +119,9 @@ TEST(create_ruleset_checks_ordering)
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	/* Checks priority for invalid flags. */
 	ASSERT_EQ(-1, landlock_create_ruleset(NULL, 0, invalid_flag));
 	ASSERT_EQ(EINVAL, errno);
@@ -153,6 +168,9 @@ TEST(add_rule_checks_ordering)
 	const int ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	ASSERT_LE(0, ruleset_fd);
 
 	/* Checks invalid flags. */
@@ -200,6 +218,9 @@ TEST(restrict_self_checks_ordering)
 	const int ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	ASSERT_LE(0, ruleset_fd);
 	path_beneath_attr.parent_fd =
 		open("/tmp", O_PATH | O_NOFOLLOW | O_DIRECTORY | O_CLOEXEC);
@@ -240,6 +261,9 @@ TEST(ruleset_fd_io)
 	int ruleset_fd;
 	char buf;
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	drop_caps(_metadata);
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
@@ -267,6 +291,9 @@ TEST(ruleset_fd_transfer)
 	pid_t child;
 	int status;
 
+	if (!has_syscall())
+		SKIP(return, "landlock syscall not available");
+
 	drop_caps(_metadata);
 
 	/* Creates a test ruleset with a simple rule. */
-- 
2.25.1

