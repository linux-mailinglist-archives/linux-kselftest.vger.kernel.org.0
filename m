Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E5F5A3745
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 13:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbiH0LQD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 07:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbiH0LPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 07:15:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF417AA5;
        Sat, 27 Aug 2022 04:15:54 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MFDYt2l3wzkWZY;
        Sat, 27 Aug 2022 19:12:18 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:15:52 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next v2 3/6] landlock: add chmod and chown support
Date:   Sat, 27 Aug 2022 19:12:12 +0800
Message-ID: <20220827111215.131442-4-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220827111215.131442-1-xiujianfeng@huawei.com>
References: <20220827111215.131442-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Add two flags LANDLOCK_ACCESS_FS_CHMOD and LANDLOCK_ACCESS_FS_CHGRP to
support restriction to chmod(2) and chown(2) with landlock.

If these two access rights are set on a directory, they only take effect
for its context, not the directory itself.

This patch also change the landlock ABI version from 3 to 4.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 include/uapi/linux/landlock.h                | 10 +++--
 security/landlock/fs.c                       | 43 +++++++++++++++++++-
 security/landlock/limits.h                   |  2 +-
 security/landlock/syscalls.c                 |  2 +-
 tools/testing/selftests/landlock/base_test.c |  2 +-
 tools/testing/selftests/landlock/fs_test.c   |  6 ++-
 6 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 735b1fe8326e..07b73626ff20 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -141,14 +141,16 @@ struct landlock_path_beneath_attr {
  *   directory) parent.  Otherwise, such actions are denied with errno set to
  *   EACCES.  The EACCES errno prevails over EXDEV to let user space
  *   efficiently deal with an unrecoverable error.
+ * - %LANDLOCK_ACCESS_FS_CHMOD: Change the file mode bits of a file.
+ * - %LANDLOCK_ACCESS_FS_CHGRP: Change the owner and/or group of a file.
  *
  * .. warning::
  *
  *   It is currently not possible to restrict some file-related actions
  *   accessible through these syscall families: :manpage:`chdir(2)`,
- *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`chmod(2)`,
- *   :manpage:`chown(2)`, :manpage:`setxattr(2)`, :manpage:`utime(2)`,
- *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`, :manpage:`access(2)`.
+ *   :manpage:`stat(2)`, :manpage:`flock(2)`, :manpage:`setxattr(2)`,
+ *   :manpage:`utime(2)`,:manpage:`ioctl(2)`, :manpage:`fcntl(2)`,
+ *   :manpage:`access(2)`.
  *   Future Landlock evolutions will enable to restrict them.
  */
 /* clang-format off */
@@ -167,6 +169,8 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 12)
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
+#define LANDLOCK_ACCESS_FS_CHMOD			(1ULL << 15)
+#define LANDLOCK_ACCESS_FS_CHGRP			(1ULL << 16)
 /* clang-format on */
 
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 4ef614a4ea22..6ac83d96ada7 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -185,7 +185,9 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHGRP)
 /* clang-format on */
 
 /*
@@ -690,6 +692,31 @@ static inline int current_check_access_path(const struct path *const path,
 	return check_access_path(dom, path, access_request);
 }
 
+static inline int
+current_check_access_path_context_only(const struct path *const path,
+				       const access_mask_t access_request)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+	struct path eff_path;
+	int ret;
+
+	if (!dom)
+		return 0;
+	eff_path = *path;
+	/* if it's dir, check its visible parent. */
+	if (d_is_dir(eff_path.dentry)) {
+		path_get(&eff_path);
+		/* dont care if reaches the root or not. */
+		walk_to_visible_parent(&eff_path);
+		ret = current_check_access_path(&eff_path, access_request);
+		path_put(&eff_path);
+	} else {
+		ret = current_check_access_path(&eff_path, access_request);
+	}
+	return ret;
+}
+
 static inline access_mask_t get_mode_access(const umode_t mode)
 {
 	switch (mode & S_IFMT) {
@@ -1177,6 +1204,18 @@ static int hook_path_truncate(const struct path *const path)
 	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
 }
 
+static int hook_path_chmod(const struct path *const path, umode_t mode)
+{
+	return current_check_access_path_context_only(path,
+					LANDLOCK_ACCESS_FS_CHMOD);
+}
+
+static int hook_path_chown(const struct path *const path, kuid_t uid, kgid_t gid)
+{
+	return current_check_access_path_context_only(path,
+					LANDLOCK_ACCESS_FS_CHGRP);
+}
+
 /* File hooks */
 
 static inline access_mask_t get_file_access(const struct file *const file)
@@ -1230,6 +1269,8 @@ static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
 	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
 	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
+	LSM_HOOK_INIT(path_chmod, hook_path_chmod),
+	LSM_HOOK_INIT(path_chown, hook_path_chown),
 
 	LSM_HOOK_INIT(file_open, hook_file_open),
 };
diff --git a/security/landlock/limits.h b/security/landlock/limits.h
index 82288f0e9e5e..7cdd7d467d12 100644
--- a/security/landlock/limits.h
+++ b/security/landlock/limits.h
@@ -18,7 +18,7 @@
 #define LANDLOCK_MAX_NUM_LAYERS		16
 #define LANDLOCK_MAX_NUM_RULES		U32_MAX
 
-#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_TRUNCATE
+#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_CHGRP
 #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
 #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
 
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index f4d6fc7ed17f..469e0e11735c 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -129,7 +129,7 @@ static const struct file_operations ruleset_fops = {
 	.write = fop_dummy_write,
 };
 
-#define LANDLOCK_ABI_VERSION 3
+#define LANDLOCK_ABI_VERSION 4
 
 /**
  * sys_landlock_create_ruleset - Create a new ruleset
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 72cdae277b02..9f00582f639c 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -75,7 +75,7 @@ TEST(abi_version)
 	const struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
 	};
-	ASSERT_EQ(3, landlock_create_ruleset(NULL, 0,
+	ASSERT_EQ(4, landlock_create_ruleset(NULL, 0,
 					     LANDLOCK_CREATE_RULESET_VERSION));
 
 	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index debe2d9ea6cf..f513cd8d9d51 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -404,9 +404,11 @@ TEST_F_FORK(layout1, inval)
 	LANDLOCK_ACCESS_FS_EXECUTE | \
 	LANDLOCK_ACCESS_FS_WRITE_FILE | \
 	LANDLOCK_ACCESS_FS_READ_FILE | \
-	LANDLOCK_ACCESS_FS_TRUNCATE)
+	LANDLOCK_ACCESS_FS_TRUNCATE | \
+	LANDLOCK_ACCESS_FS_CHMOD | \
+	LANDLOCK_ACCESS_FS_CHGRP)
 
-#define ACCESS_LAST LANDLOCK_ACCESS_FS_TRUNCATE
+#define ACCESS_LAST LANDLOCK_ACCESS_FS_CHGRP
 
 #define ACCESS_ALL ( \
 	ACCESS_FILE | \
-- 
2.17.1

