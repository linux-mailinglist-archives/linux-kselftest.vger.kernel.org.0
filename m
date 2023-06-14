Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97E072CF1C
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jun 2023 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbjFLTPG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbjFLTOw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:52 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDD3E56
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 12:14:45 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b633ZZzMq8NJ;
        Mon, 12 Jun 2023 19:14:42 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b56dRlz1WQ8;
        Mon, 12 Jun 2023 21:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597282;
        bh=dQkYX36jTDSeJo8SzhoPDVUOJ2TyKr9pVuNY0nvc1PQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RTnB7itTTwDWOuQSJ8JqgXlVzQqlfA+Cnym9zSqg/4DUI3Fc3chJptmCAoDO8ssvI
         uaiHEMbDhM8624pNOnd3/qlAVyzy25h5VJEEawEFK5czOakPvJzUwF96Z4m/lWApGg
         zry/wnS3zqSPRpFArJLlt7BDUCfFS/tQG5KHrXkM=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 4/6] selftests/landlock: Make mounts configurable
Date:   Mon, 12 Jun 2023 21:14:28 +0200
Message-ID: <20230612191430.339153-5-mic@digikod.net>
In-Reply-To: <20230612191430.339153-1-mic@digikod.net>
References: <20230612191430.339153-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a new struct mnt_opt to define a mount point with the mount_opt()
helper.  This doesn't change tests but prepare for the next commit.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 45 +++++++++++++++++++---
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index c1e655fc06bb..737047a81547 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -213,7 +213,26 @@ static int remove_path(const char *const path)
 	return err;
 }
 
-static void prepare_layout(struct __test_metadata *const _metadata)
+struct mnt_opt {
+	const char *const source;
+	const char *const type;
+	const unsigned long flags;
+	const char *const data;
+};
+
+const struct mnt_opt mnt_tmp = {
+	.type = "tmpfs",
+	.data = "size=4m,mode=700",
+};
+
+static int mount_opt(const struct mnt_opt *const mnt, const char *const target)
+{
+	return mount(mnt->source ?: mnt->type, target, mnt->type, mnt->flags,
+		     mnt->data);
+}
+
+static void prepare_layout_opt(struct __test_metadata *const _metadata,
+			       const struct mnt_opt *const mnt)
 {
 	disable_caps(_metadata);
 	umask(0077);
@@ -225,11 +244,27 @@ static void prepare_layout(struct __test_metadata *const _metadata)
 	 */
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, unshare(CLONE_NEWNS));
-	ASSERT_EQ(0, mount("tmp", TMP_DIR, "tmpfs", 0, "size=4m,mode=700"));
+	ASSERT_EQ(0, mount_opt(mnt, TMP_DIR))
+	{
+		TH_LOG("Failed to mount the %s filesystem: %s", mnt->type,
+		       strerror(errno));
+		/*
+		 * FIXTURE_TEARDOWN() is not called when FIXTURE_SETUP()
+		 * failed, so we need to explicitly do a minimal cleanup to
+		 * avoid cascading errors with other tests that don't depend on
+		 * the same filesystem.
+		 */
+		remove_path(TMP_DIR);
+	}
 	ASSERT_EQ(0, mount(NULL, TMP_DIR, NULL, MS_PRIVATE | MS_REC, NULL));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
+static void prepare_layout(struct __test_metadata *const _metadata)
+{
+	prepare_layout_opt(_metadata, &mnt_tmp);
+}
+
 static void cleanup_layout(struct __test_metadata *const _metadata)
 {
 	set_cap(_metadata, CAP_SYS_ADMIN);
@@ -269,7 +304,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	create_file(_metadata, file1_s3d1);
 	create_directory(_metadata, dir_s3d2);
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s3d2));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 
 	ASSERT_EQ(0, mkdir(dir_s3d3, 0700));
@@ -4068,7 +4103,7 @@ FIXTURE_SETUP(layout2_overlay)
 	create_directory(_metadata, LOWER_BASE);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	/* Creates tmpfs mount points to get deterministic overlayfs. */
-	ASSERT_EQ(0, mount("tmp", LOWER_BASE, "tmpfs", 0, "size=4m,mode=700"));
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, LOWER_BASE));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	create_file(_metadata, lower_fl1);
 	create_file(_metadata, lower_dl1_fl2);
@@ -4078,7 +4113,7 @@ FIXTURE_SETUP(layout2_overlay)
 
 	create_directory(_metadata, UPPER_BASE);
 	set_cap(_metadata, CAP_SYS_ADMIN);
-	ASSERT_EQ(0, mount("tmp", UPPER_BASE, "tmpfs", 0, "size=4m,mode=700"));
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, UPPER_BASE));
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 	create_file(_metadata, upper_fu1);
 	create_file(_metadata, upper_du1_fu2);
-- 
2.41.0

