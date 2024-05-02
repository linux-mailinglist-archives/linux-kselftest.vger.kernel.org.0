Return-Path: <linux-kselftest+bounces-9282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E02158BA1E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 23:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59DA51F22AD0
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 May 2024 21:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834351C2327;
	Thu,  2 May 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="aT7uiL4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4665F194C9D
	for <linux-kselftest@vger.kernel.org>; Thu,  2 May 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684195; cv=none; b=Dg304EBC00NfwIURUtHSEOJBn5eMjlEFXh/5UrMadmUGRTL1fjuZsXNdXBpnfvDSLE6gsBP/DGMD8X5cN/l3GO9gMZsks7w93LCROFiWaAsI8AOZ2LExlWIqjZREmL/Xe3a8c2VcAA4mvH4Gdq0gJs+VqLehWaCvqXyxlGC7vEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684195; c=relaxed/simple;
	bh=jw4R3rrY+OC2XdTr3iRaQSj/Q6GJ0Ni0bEq4asle6Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmEa7kvmRLVyZghUzKUwj3QVoOcyA3YSKMnj7I3yRHgvss1sXaKZUmI3gMUocvhvPDtJUeGIAjfmkYo0a8eTJe6Wg2lmsAUltSn2TyMRQzB3gfKljv6CTjMlAd7fOnFqf+PkXdQWMZD9RLwsCsUCpUv/KpIIgiN3vms8IEkswYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=aT7uiL4o; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VVmls6z3kzNgQ;
	Thu,  2 May 2024 23:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714684185;
	bh=jw4R3rrY+OC2XdTr3iRaQSj/Q6GJ0Ni0bEq4asle6Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT7uiL4oBzfeHAqB7ipNeHdwZrzsl6OSKadvxK/dR5Xs3HJLgiJex09UaspZf+E/h
	 /VQRLz1oCr7N1porjxHlg1AJBsDSaZ8rROdV5NsZSskW+BWEGRydFDoQkmQ7GESMQj
	 NEG/GcLbhdbrzGBgSfMeWY3u6IW5QiBKo/kKhNqg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VVmls00bGztFV;
	Thu,  2 May 2024 23:09:44 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 05/10] selftests/landlock: Do not allocate memory in fixture data
Date: Thu,  2 May 2024 23:09:21 +0200
Message-ID: <20240502210926.145539-6-mic@digikod.net>
In-Reply-To: <20240502210926.145539-1-mic@digikod.net>
References: <20240502210926.145539-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Do not allocate self->dir_path in the test process because this would
not be visible in the FIXTURE_TEARDOWN() process when relying on
fork()/clone3() instead of vfork().

This change is required for a following commit removing vfork() call to
not break the layout3_fs.* test cases.

Cc: Günther Noack <gnoack@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240502210926.145539-6-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/landlock/fs_test.c | 57 +++++++++++++---------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 46b9effd53e4..1e2cffde02b5 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -9,6 +9,7 @@
 
 #define _GNU_SOURCE
 #include <fcntl.h>
+#include <libgen.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -4624,7 +4625,6 @@ FIXTURE(layout3_fs)
 {
 	bool has_created_dir;
 	bool has_created_file;
-	char *dir_path;
 	bool skip_test;
 };
 
@@ -4683,11 +4683,24 @@ FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
 	.cwd_fs_magic = HOSTFS_SUPER_MAGIC,
 };
 
+static char *dirname_alloc(const char *path)
+{
+	char *dup;
+
+	if (!path)
+		return NULL;
+
+	dup = strdup(path);
+	if (!dup)
+		return NULL;
+
+	return dirname(dup);
+}
+
 FIXTURE_SETUP(layout3_fs)
 {
 	struct stat statbuf;
-	const char *slash;
-	size_t dir_len;
+	char *dir_path = dirname_alloc(variant->file_path);
 
 	if (!supports_filesystem(variant->mnt.type) ||
 	    !cwd_matches_fs(variant->cwd_fs_magic)) {
@@ -4697,25 +4710,15 @@ FIXTURE_SETUP(layout3_fs)
 
 	_metadata->teardown_parent = true;
 
-	slash = strrchr(variant->file_path, '/');
-	ASSERT_NE(slash, NULL);
-	dir_len = (size_t)slash - (size_t)variant->file_path;
-	ASSERT_LT(0, dir_len);
-	self->dir_path = malloc(dir_len + 1);
-	self->dir_path[dir_len] = '\0';
-	strncpy(self->dir_path, variant->file_path, dir_len);
-
 	prepare_layout_opt(_metadata, &variant->mnt);
 
 	/* Creates directory when required. */
-	if (stat(self->dir_path, &statbuf)) {
+	if (stat(dir_path, &statbuf)) {
 		set_cap(_metadata, CAP_DAC_OVERRIDE);
-		EXPECT_EQ(0, mkdir(self->dir_path, 0700))
+		EXPECT_EQ(0, mkdir(dir_path, 0700))
 		{
 			TH_LOG("Failed to create directory \"%s\": %s",
-			       self->dir_path, strerror(errno));
-			free(self->dir_path);
-			self->dir_path = NULL;
+			       dir_path, strerror(errno));
 		}
 		self->has_created_dir = true;
 		clear_cap(_metadata, CAP_DAC_OVERRIDE);
@@ -4736,6 +4739,8 @@ FIXTURE_SETUP(layout3_fs)
 		self->has_created_file = true;
 		clear_cap(_metadata, CAP_DAC_OVERRIDE);
 	}
+
+	free(dir_path);
 }
 
 FIXTURE_TEARDOWN(layout3_fs)
@@ -4754,16 +4759,17 @@ FIXTURE_TEARDOWN(layout3_fs)
 	}
 
 	if (self->has_created_dir) {
+		char *dir_path = dirname_alloc(variant->file_path);
+
 		set_cap(_metadata, CAP_DAC_OVERRIDE);
 		/*
 		 * Don't check for error because the directory might already
 		 * have been removed (cf. release_inode test).
 		 */
-		rmdir(self->dir_path);
+		rmdir(dir_path);
 		clear_cap(_metadata, CAP_DAC_OVERRIDE);
+		free(dir_path);
 	}
-	free(self->dir_path);
-	self->dir_path = NULL;
 
 	cleanup_layout(_metadata);
 }
@@ -4830,7 +4836,10 @@ TEST_F_FORK(layout3_fs, tag_inode_dir_mnt)
 
 TEST_F_FORK(layout3_fs, tag_inode_dir_child)
 {
-	layer3_fs_tag_inode(_metadata, self, variant, self->dir_path);
+	char *dir_path = dirname_alloc(variant->file_path);
+
+	layer3_fs_tag_inode(_metadata, self, variant, dir_path);
+	free(dir_path);
 }
 
 TEST_F_FORK(layout3_fs, tag_inode_file)
@@ -4857,9 +4866,13 @@ TEST_F_FORK(layout3_fs, release_inodes)
 	if (self->has_created_file)
 		EXPECT_EQ(0, remove_path(variant->file_path));
 
-	if (self->has_created_dir)
+	if (self->has_created_dir) {
+		char *dir_path = dirname_alloc(variant->file_path);
+
 		/* Don't check for error because of cgroup specificities. */
-		remove_path(self->dir_path);
+		remove_path(dir_path);
+		free(dir_path);
+	}
 
 	ruleset_fd =
 		create_ruleset(_metadata, LANDLOCK_ACCESS_FS_READ_DIR, layer1);
-- 
2.45.0


