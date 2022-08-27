Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CB25A3742
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 13:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245418AbiH0LQC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 07:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243366AbiH0LPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 07:15:55 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE5D20BC5;
        Sat, 27 Aug 2022 04:15:53 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MFDc04VsLzGpsS;
        Sat, 27 Aug 2022 19:14:08 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 19:15:51 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mic@digikod.net>, <paul@paul-moore.com>, <jmorris@namei.org>,
        <serge@hallyn.com>, <shuah@kernel.org>, <corbet@lwn.net>
CC:     <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: [PATCH -next v2 2/6] landlock: abstract walk_to_visible_parent() helper
Date:   Sat, 27 Aug 2022 19:12:11 +0800
Message-ID: <20220827111215.131442-3-xiujianfeng@huawei.com>
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

This helper will be used in the next commit which supports chmod and
chown access rights restriction.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 security/landlock/fs.c | 67 ++++++++++++++++++++++++++++++------------
 1 file changed, 49 insertions(+), 18 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index c57f581a9cd5..4ef614a4ea22 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -38,6 +38,44 @@
 #include "ruleset.h"
 #include "setup.h"
 
+enum walk_result {
+	WALK_CONTINUE,
+	WALK_TO_REAL_ROOT,
+	WALK_TO_DISCONN_ROOT,
+};
+
+/*
+ * walk to the visible parent, caller should call path_get()/path_put()
+ * before/after this helpler.
+ *
+ * Returns:
+ * - WALK_TO_REAL_ROOT if walk to the real root;
+ * - WALK_TO_DISCONN_ROOT if walk to disconnected root;
+ * - WALK_CONTINUE otherwise.
+ */
+static enum walk_result walk_to_visible_parent(struct path *path)
+{
+	struct dentry *parent_dentry;
+jump_up:
+	if (path->dentry == path->mnt->mnt_root) {
+		if (follow_up(path)) {
+			/* Ignores hidden mount points. */
+			goto jump_up;
+		} else {
+			/* Stop at the real root. */
+			return WALK_TO_REAL_ROOT;
+		}
+	}
+	/* Stops at disconnected root directories. */
+	if (unlikely(IS_ROOT(path->dentry)))
+		return WALK_TO_DISCONN_ROOT;
+	parent_dentry = dget_parent(path->dentry);
+	dput(path->dentry);
+	path->dentry = parent_dentry;
+
+	return WALK_CONTINUE;
+}
+
 /* Underlying object management */
 
 static void release_inode(struct landlock_object *const object)
@@ -539,8 +577,8 @@ static int check_access_path_dual(
 	 * restriction.
 	 */
 	while (true) {
-		struct dentry *parent_dentry;
 		const struct landlock_rule *rule;
+		enum walk_result wr;
 
 		/*
 		 * If at least all accesses allowed on the destination are
@@ -588,20 +626,12 @@ static int check_access_path_dual(
 		if (allowed_parent1 && allowed_parent2)
 			break;
 
-jump_up:
-		if (walker_path.dentry == walker_path.mnt->mnt_root) {
-			if (follow_up(&walker_path)) {
-				/* Ignores hidden mount points. */
-				goto jump_up;
-			} else {
-				/*
-				 * Stops at the real root.  Denies access
-				 * because not all layers have granted access.
-				 */
-				break;
-			}
-		}
-		if (unlikely(IS_ROOT(walker_path.dentry))) {
+		wr = walk_to_visible_parent(&walker_path);
+		switch (wr) {
+		case WALK_TO_REAL_ROOT:
+			/* Stop at the real root. */
+			goto out;
+		case WALK_TO_DISCONN_ROOT:
 			/*
 			 * Stops at disconnected root directories.  Only allows
 			 * access to internal filesystems (e.g. nsfs, which is
@@ -609,12 +639,13 @@ static int check_access_path_dual(
 			 */
 			allowed_parent1 = allowed_parent2 =
 				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			goto out;
+		case WALK_CONTINUE:
+		default:
 			break;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
+out:
 	path_put(&walker_path);
 
 	if (allowed_parent1 && allowed_parent2)
-- 
2.17.1

