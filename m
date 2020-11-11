Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1842AFA6F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgKKVew (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgKKVev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:51 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F94C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Nov 2020 13:34:51 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL16WtDzlhXlJ;
        Wed, 11 Nov 2020 22:34:49 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL14p8Gzlh8T8;
        Wed, 11 Nov 2020 22:34:49 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 4/9] landlock: Always intersect access rights
Date:   Wed, 11 Nov 2020 22:34:37 +0100
Message-Id: <20201111213442.434639-5-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Following the previous commit logic, make ruleset updates more
consistent by always intersecting access rights (boolean AND) instead of
combining them (boolean OR) for the same layer.

This defensive approach could also help avoid user space to
inadvertently allow multiple access rights for the same object (e.g.
write and execute access on a path hierarchy) instead of dealing with
such inconsistency.  This can happen when there is no deduplication of
objects (e.g. paths and underlying inodes) whereas they get different
access rights with landlock_add_rule(2).

Update layout1.ruleset_overlap and layout1.inherit_subset tests
accordingly.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/ruleset.c                | 17 ++++-----
 tools/testing/selftests/landlock/fs_test.c | 41 +++++++++++++++-------
 2 files changed, 34 insertions(+), 24 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 9fe92b2f5fbd..7654a66cea43 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -82,11 +82,11 @@ static void put_rule(struct landlock_rule *const rule)
 /**
  * landlock_insert_rule - Insert a rule in a ruleset
  *
+ * Intersects access rights of the rule with those of the ruleset.
+ *
  * @ruleset: The ruleset to be updated.
  * @rule: Read-only payload to be inserted (not owned by this function).
- * @is_merge: If true, intersects access rights and updates the rule's layers
- *            (e.g. merge two rulesets), else do a union of access rights and
- *            keep the rule's layers (e.g. extend a ruleset)
+ * @is_merge: If true, handle the rule layers.
  *
  * Assumptions:
  *
@@ -117,16 +117,11 @@ int landlock_insert_rule(struct landlock_ruleset *const ruleset,
 		}
 
 		/* If there is a matching rule, updates it. */
-		if (is_merge) {
-			/* Intersects access rights. */
-			this->access &= rule->access;
-
+		if (is_merge)
 			/* Updates the rule layers with the next one. */
 			this->layers |= BIT_ULL(ruleset->nb_layers);
-		} else {
-			/* Extends access rights. */
-			this->access |= rule->access;
-		}
+		/* Intersects access rights. */
+		this->access &= rule->access;
 		return 0;
 	}
 
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index ade0ad8728d8..1885174b2770 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -591,14 +591,16 @@ TEST_F(layout1, unhandled_access)
 TEST_F(layout1, ruleset_overlap)
 {
 	const struct rule rules[] = {
-		/* These rules should be ORed among them. */
+		/* These rules should be ANDed among them. */
 		{
 			.path = dir_s1d2,
-			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_WRITE_FILE,
 		},
 		{
 			.path = dir_s1d2,
-			.access = LANDLOCK_ACCESS_FS_READ_DIR,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				LANDLOCK_ACCESS_FS_READ_DIR,
 		},
 		{}
 	};
@@ -609,24 +611,37 @@ TEST_F(layout1, ruleset_overlap)
 	enforce_ruleset(_metadata, ruleset_fd);
 	EXPECT_EQ(0, close(ruleset_fd));
 
+	/* Checks s1d1 hierarchy. */
+	ASSERT_EQ(-1, open(file1_s1d1, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, open(file1_s1d1, O_WRONLY | O_CLOEXEC));
 	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file1_s1d1, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
 	ASSERT_EQ(-1, open(dir_s1d1, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
 	ASSERT_EQ(EACCES, errno);
 
-	open_fd = open(file1_s1d2, O_WRONLY | O_CLOEXEC);
-	ASSERT_LE(0, open_fd);
-	EXPECT_EQ(0, close(open_fd));
-	open_fd = open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	/* Checks s1d2 hierarchy. */
+	open_fd = open(file1_s1d2, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, open_fd);
 	EXPECT_EQ(0, close(open_fd));
+	ASSERT_EQ(-1, open(file1_s1d2, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file1_s1d2, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d2, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
 
-	open_fd = open(file1_s1d3, O_WRONLY | O_CLOEXEC);
-	ASSERT_LE(0, open_fd);
-	EXPECT_EQ(0, close(open_fd));
-	open_fd = open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	/* Checks s1d3 hierarchy. */
+	open_fd = open(file1_s1d3, O_RDONLY | O_CLOEXEC);
 	ASSERT_LE(0, open_fd);
 	EXPECT_EQ(0, close(open_fd));
+	ASSERT_EQ(-1, open(file1_s1d3, O_WRONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file1_s1d3, O_RDWR | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(dir_s1d3, O_RDONLY | O_DIRECTORY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
 }
 
 TEST_F(layout1, interleaved_masked_accesses)
@@ -766,8 +781,8 @@ TEST_F(layout1, inherit_subset)
 	 * any new access, only remove some.  Once enforced, these rules are
 	 * ANDed with the previous ones.
 	 */
-	add_path_beneath(_metadata, ruleset_fd, LANDLOCK_ACCESS_FS_WRITE_FILE,
-			dir_s1d2);
+	add_path_beneath(_metadata, ruleset_fd, rules[0].access |
+			LANDLOCK_ACCESS_FS_WRITE_FILE, dir_s1d2);
 	/*
 	 * According to ruleset_fd, dir_s1d2 should now have the
 	 * LANDLOCK_ACCESS_FS_READ_FILE and LANDLOCK_ACCESS_FS_WRITE_FILE
-- 
2.29.2

