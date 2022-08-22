Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D359BEF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiHVLvZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234866AbiHVLuR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 07:50:17 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34CE18E2D;
        Mon, 22 Aug 2022 04:50:15 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MB9c35BfHzGpmK;
        Mon, 22 Aug 2022 19:48:35 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 22 Aug 2022 19:50:13 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next 3/5] landlock/selftests: add selftests for chmod and chown
Date:   Mon, 22 Aug 2022 19:46:59 +0800
Message-ID: <20220822114701.26975-4-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220822114701.26975-1-xiujianfeng@huawei.com>
References: <20220822114701.26975-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the following simple testcases:
1. chmod/fchmod: remove S_IWUSR and restore S_IWUSR with or without
restriction.
2. chown/fchown: set original uid and gid with or without restriction,
because chown needs CAP_CHOWN and testcase framework don't have this
capability, setting original uid and gid is ok to cover landlock
function.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 tools/testing/selftests/landlock/fs_test.c | 228 +++++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 5b55b93b5570..f47b4ccd2b26 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -59,6 +59,9 @@ static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
 
 static const char dir_s3d1[] = TMP_DIR "/s3d1";
 static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
+static const char file2_s3d1[] = TMP_DIR "/s3d1/f2";
+static const char file3_s3d1[] = TMP_DIR "/s3d1/f3";
+
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
@@ -211,6 +214,8 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	create_file(_metadata, file2_s2d3);
 
 	create_file(_metadata, file1_s3d1);
+	create_file(_metadata, file2_s3d1);
+	create_file(_metadata, file3_s3d1);
 	create_directory(_metadata, dir_s3d2);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
@@ -234,6 +239,8 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(file1_s2d1));
 
 	EXPECT_EQ(0, remove_path(file1_s3d1));
+	EXPECT_EQ(0, remove_path(file2_s3d1));
+	EXPECT_EQ(0, remove_path(file3_s3d1));
 	EXPECT_EQ(0, remove_path(dir_s3d3));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
@@ -3272,6 +3279,227 @@ TEST_F_FORK(layout1, truncate)
 	EXPECT_EQ(0, test_creat(file_in_dir_w));
 }
 
+static int test_chmod(const char *path)
+{
+	int ret;
+	struct stat st;
+	mode_t mode;
+
+	ret = stat(path, &st);
+	if (ret < 0)
+		return errno;
+	/* save original mode in order to restore */
+	mode = st.st_mode & 0777;
+	/* remove S_IWUSR */
+	ret = chmod(path, mode & ~0200);
+	if (ret < 0)
+		return errno;
+	ret = stat(path, &st);
+	if (ret < 0)
+		return errno;
+	/* check if still has S_IWUSR */
+	if (st.st_mode & 0200)
+		return -EFAULT;
+	/* restore the original mode */
+	ret = chmod(path, mode);
+	if (ret < 0)
+		return errno;
+	return 0;
+}
+
+static int test_fchmod(const char *path)
+{
+	int ret, fd;
+	struct stat st;
+	mode_t mode;
+
+	ret = stat(path, &st);
+	if (ret < 0)
+		return errno;
+	/* save original mode in order to restore */
+	mode = st.st_mode & 0777;
+
+	fd = openat(AT_FDCWD, path, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return errno;
+	/* remove S_IWUSR */
+	ret = fchmod(fd, mode & ~0200);
+	if (ret < 0)
+		goto err;
+	ret = stat(path, &st);
+	if (ret < 0)
+		goto err;
+	/* check if still has S_IWUSR */
+	if (st.st_mode & 0200) {
+		ret = -1;
+		errno = -EFAULT;
+		goto err;
+	}
+	/* restore the original mode */
+	ret = fchmod(fd, mode);
+err:
+	if (close(fd) < 0)
+		return errno;
+	return ret ? errno : 0;
+}
+
+static int test_chown(const char *path)
+{
+	int ret;
+	struct stat st;
+
+	ret = stat(path, &st);
+	if (ret < 0)
+		return errno;
+	/*
+	 * chown needs CAP_CHOWN to modify uid and/or gid, however
+	 * there is no such capability when the testcases framework
+	 * setup, so just chown to original uid/gid, which can also
+	 * cover the function in landlock.
+	 */
+	ret = chown(path, st.st_uid, st.st_gid);
+	if (ret < 0)
+		return errno;
+	return 0;
+}
+
+static int test_fchown(const char *path)
+{
+	int ret, fd;
+	struct stat st;
+
+	ret = stat(path, &st);
+	if (ret < 0)
+		return errno;
+	fd = openat(AT_FDCWD, path, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return errno;
+	/*
+	 * fchown needs CAP_CHOWN to modify uid and/or gid, however
+	 * there is no such capability when the testcases framework
+	 * setup, so just fchown to original uid/gid, which can also
+	 * cover the function in landlock.
+	 */
+	ret = fchown(fd, st.st_uid, st.st_gid);
+	if (close(fd) < 0)
+		return errno;
+	return ret ? errno : 0;
+}
+
+TEST_F_FORK(layout1, unhandled_chmod)
+{
+	const struct rule rules[] = {
+		{
+			.path = file2_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file3_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_chmod(file2_s3d1));
+	ASSERT_EQ(0, test_fchmod(file2_s3d1));
+	ASSERT_EQ(0, test_chmod(file3_s3d1));
+	ASSERT_EQ(0, test_chmod(dir_s3d1));
+}
+
+TEST_F_FORK(layout1, chmod)
+{
+	const struct rule rules[] = {
+		{
+			.path = file2_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_CHMOD,
+		},
+		{
+			.path = file3_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHMOD, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_chmod(file2_s3d1));
+	ASSERT_EQ(0, test_fchmod(file2_s3d1));
+	ASSERT_EQ(EACCES, test_chmod(file3_s3d1));
+	ASSERT_EQ(EACCES, test_chmod(dir_s3d1));
+}
+
+TEST_F_FORK(layout1, no_chown)
+{
+	const struct rule rules[] = {
+		{
+			.path = file2_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file3_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, ACCESS_RW, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_chown(file2_s3d1));
+	ASSERT_EQ(0, test_fchown(file2_s3d1));
+	ASSERT_EQ(0, test_chown(file3_s3d1));
+	ASSERT_EQ(0, test_chown(dir_s3d1));
+}
+
+TEST_F_FORK(layout1, chown)
+{
+	const struct rule rules[] = {
+		{
+			.path = file2_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_CHOWN,
+		},
+		{
+			.path = file3_s3d1,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const int ruleset_fd =
+		create_ruleset(_metadata, ACCESS_RW | LANDLOCK_ACCESS_FS_CHOWN, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	ASSERT_EQ(0, test_chown(file2_s3d1));
+	ASSERT_EQ(0, test_fchown(file2_s3d1));
+	ASSERT_EQ(EACCES, test_chown(file3_s3d1));
+	ASSERT_EQ(EACCES, test_chown(dir_s3d1));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.17.1

