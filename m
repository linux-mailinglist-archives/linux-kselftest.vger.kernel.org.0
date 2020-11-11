Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF42AFA8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgKKVfZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:35:25 -0500
Received: from smtp-8faf.mail.infomaniak.ch ([83.166.143.175]:47145 "EHLO
        smtp-8faf.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgKKVev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:51 -0500
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL05tD5zlhS6t;
        Wed, 11 Nov 2020 22:34:48 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL02mhLzlh8T4;
        Wed, 11 Nov 2020 22:34:48 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 3/9] landlock: Enforce deterministic interleaved path rules
Date:   Wed, 11 Nov 2020 22:34:36 +0100
Message-Id: <20201111213442.434639-4-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To have consistent layered rules, granting access to a path implies that
all accesses tied to inodes, from the requested file to the real root,
must be checked.  Otherwise, stacked rules may result to overzealous
restrictions.  By excluding the ability to add exceptions in the same
layer (e.g. /a allowed, /a/b denied, and /a/b/c allowed), we get
deterministic interleaved path rules.  This removes an optimization
which could be replaced by a proper cache mechanism.  This also further
simplifies and explain check_access_path_continue().

Add a layout1.interleaved_masked_accesses test to check corner-case
layered rule combinations.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c                     | 38 +++++----
 tools/testing/selftests/landlock/fs_test.c | 95 ++++++++++++++++++++++
 2 files changed, 115 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 33fc7ae17c7f..2ca4dce1e9ed 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -180,16 +180,24 @@ static bool check_access_path_continue(
 			rcu_dereference(landlock_inode(inode)->object));
 	rcu_read_unlock();
 
-	/* Checks for matching layers. */
-	if (rule && (rule->layers | *layer_mask)) {
-		if ((rule->access & access_request) == access_request) {
-			*layer_mask &= ~rule->layers;
-			return true;
-		} else {
-			return false;
-		}
+	if (!rule)
+		/* Continues to walk if there is no rule for this inode. */
+		return true;
+	/*
+	 * We must check all layers for each inode because we may encounter
+	 * multiple different accesses from the same layer in a walk.  Each
+	 * layer must at least allow the access request one time (i.e. with one
+	 * inode).  This enables to have a deterministic behavior whatever
+	 * inode is tagged within interleaved layers.
+	 */
+	if ((rule->access & access_request) == access_request) {
+		/* Validates layers for which all accesses are allowed. */
+		*layer_mask &= ~rule->layers;
+		/* Continues to walk until all layers are validated. */
+		return true;
 	}
-	return true;
+	/* Stops if a rule in the path don't allow all requested access. */
+	return false;
 }
 
 static int check_access_path(const struct landlock_ruleset *const domain,
@@ -231,12 +239,6 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 				&layer_mask)) {
 		struct dentry *parent_dentry;
 
-		/* Stops when a rule from each layer granted access. */
-		if (layer_mask == 0) {
-			allowed = true;
-			break;
-		}
-
 jump_up:
 		/*
 		 * Does not work with orphaned/private mounts like overlayfs
@@ -248,10 +250,10 @@ static int check_access_path(const struct landlock_ruleset *const domain,
 				goto jump_up;
 			} else {
 				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
+				 * Stops at the real root.  Denies access if
+				 * not all layers granted access.
 				 */
-				allowed = false;
+				allowed = (layer_mask == 0);
 				break;
 			}
 		}
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 8aed28081ec8..ade0ad8728d8 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -629,6 +629,101 @@ TEST_F(layout1, ruleset_overlap)
 	EXPECT_EQ(0, close(open_fd));
 }
 
+TEST_F(layout1, interleaved_masked_accesses)
+{
+	/*
+	 * Checks overly restrictive rules:
+	 * layer 1: allows s1d1/s1d2/s1d3/file1
+	 * layer 2: allows s1d1/s1d2/s1d3
+	 *          denies s1d1/s1d2
+	 * layer 3: allows s1d1
+	 * layer 4: allows s1d1/s1d2
+	 */
+	const struct rule layer1[] = {
+		/* Allows access to file1_s1d3 with the first layer. */
+		{
+			.path = file1_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const struct rule layer2[] = {
+		/* Start by granting access to file1_s1d3 with this rule... */
+		{
+			.path = dir_s1d3,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		/* ...but finally denies access to file1_s1d3. */
+		{
+			.path = dir_s1d2,
+			.access = 0,
+		},
+		{}
+	};
+	const struct rule layer3[] = {
+		/* Try to allows access to file1_s1d3. */
+		{
+			.path = dir_s1d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	const struct rule layer4[] = {
+		/* Try to bypass layer2. */
+		{
+			.path = dir_s1d2,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{}
+	};
+	int open_fd, ruleset_fd;
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, layer1);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks that access is granted for file1_s1d3. */
+	open_fd = open(file1_s1d3, O_RDONLY | O_CLOEXEC);
+	ASSERT_LE(0, open_fd);
+	EXPECT_EQ(0, close(open_fd));
+	ASSERT_EQ(-1, open(file2_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, layer2);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Now, checks that access is denied for file1_s1d3. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file2_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, layer3);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks that access rights are unchanged with layer 3. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file2_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+
+	ruleset_fd = create_ruleset(_metadata, ACCESS_RO, layer4);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	EXPECT_EQ(0, close(ruleset_fd));
+
+	/* Checks that access rights are unchanged with layer 4. */
+	ASSERT_EQ(-1, open(file1_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+	ASSERT_EQ(-1, open(file2_s1d3, O_RDONLY | O_CLOEXEC));
+	ASSERT_EQ(EACCES, errno);
+}
+
 TEST_F(layout1, inherit_subset)
 {
 	const struct rule rules[] = {
-- 
2.29.2

