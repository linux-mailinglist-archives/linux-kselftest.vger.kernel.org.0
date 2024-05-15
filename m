Return-Path: <linux-kselftest+bounces-10210-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A385E8C5EA5
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 03:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D90EBB21550
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 01:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA87363B9;
	Wed, 15 May 2024 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S47n8/FF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860620E6;
	Wed, 15 May 2024 01:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715735305; cv=none; b=IXeViMAtGV/C1uQhgMrCoPVRd0052zuGuyaLjZDPCNqsIScHpdMvLXZgrDFZpK2qLVIq6X0SFyBCC9g12kcJ306KJF3isYupWY8Ab1bE7gFwied6ZwMiqQ9VbN7VgqqTu0YJJK1nytv4HrgSsvQ6QccU5vwmLqmbr9qvSuJ72s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715735305; c=relaxed/simple;
	bh=dT8ANgy09X7j18odK8IC61VYQ+K7a52NYm1T7TLwx1E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfAOOuZ6m3Wmi7fha1N9RqHHoFDNTVBeGag7MKf4I7fgUspHbjhghwRCUrS/g884VxeO9/CH/utEzW5mkmLPzcrQSDAa5syiAv+EymCMv1X7C7vjdrgyIC9CV653vnYzrwVKsQyABvLMIOy69Fm8eVi/Oqrim2Q3aF4dSI0l+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S47n8/FF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6f457853950so4802715b3a.0;
        Tue, 14 May 2024 18:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715735302; x=1716340102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7cVoRg5XLbeO8AGfzjbDfQNTG72qZnwMnMRH7ezljE=;
        b=S47n8/FF45dF39eVbU2zAzvrlDuyLR9UJ3gPl72JEm3W++Qk2ckLYbxg/0ay8UsVGR
         taxSkjuFtV5ggFGc72ZQuAZC3J+s04kBtd00s+C9LBd6iULuW/mI4fovuosw6p22cW88
         ho5rhNp7sd3l76PAQ2s3h5XwIV+vNgC3Zawou7J5/XImbj1yOxtdMOucXKS5wxuisb49
         XyH6/vxgUkk34ic7HdI0SAIrMmoWx5PMZ2GEpvYcN0AYTH9cD8nBE9UoK9oiHFJ6tSop
         Ba8jPt7+EQmivdjCxrar4/SJ9hr57WA+Aes9WMw/LfWN5NS6INWfY8JlSjs5Cy5SFJm8
         nurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715735302; x=1716340102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7cVoRg5XLbeO8AGfzjbDfQNTG72qZnwMnMRH7ezljE=;
        b=CFlPaNq95TUIiwKc+qY3YwRCije++pRxVpCyLZykR72fGA4UG+c+T9dibAjqgt43Ta
         icOlEBJa+LkiTZxmukSIeWVkgv3vJeoG2T2ZUA88NCR+CI4mpJoo2QByN9+e1wkYCbr5
         yxrKGMHzPiCHBrHaU7MrIg2zAi4lDkC8MHWMXF14znziK3MOgloRnYIVUKo8RCDCq41Y
         EvZqjAw8HXahrXq/F8DVId0a489uuOySeR9vjd51s5BCojuTVXHt0EyLc6EuZQcqk2kD
         HFOD2L4/lzTztR9bLGU6s20p3QE99rxXTzPfE+RUKv3d5ubtMmSv09kNR/2n+2haGNvc
         VNjg==
X-Forwarded-Encrypted: i=1; AJvYcCUQewV3Ggga4/TYFO2olXNwqf4TDDEp2TogvW5ULxRjcXs03RfFmcoF3nV4E15AX++sBatE0xHfWE9DnelpWtm+vnWqsFWKbhJIZwoc
X-Gm-Message-State: AOJu0YwaUP97LZmHDyjfKEZq6cj+8e6Rq76qk/iPhRp6MCiRqfzU9/EO
	GQg4YtI6e3VA38Rj5HAHrpBaw8/AEC9kANjAQEMmoBPGcgDD49SkGNIhvPWQGkI=
X-Google-Smtp-Source: AGHT+IFY4jTPkpJSgOMJ1ofHJHNHSJk7qB+CEBi9vn/qEzpmkAeFX89tuhzk3Yaa04nqSXvGJGQLzw==
X-Received: by 2002:a17:902:d507:b0:1ec:7084:3d8d with SMTP id d9443c01a7336-1eefa03a4f8mr252551145ad.9.1715735302418;
        Tue, 14 May 2024 18:08:22 -0700 (PDT)
Received: from server.ucalgary.ca (S0106f85e42401d5e.cg.shawcable.net. [174.0.240.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d16cfsm104973325ad.18.2024.05.14.18.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 18:08:22 -0700 (PDT)
From: Abhinav Saxena <xandfury@gmail.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Abhinav Saxena <xandfury@gmail.com>
Subject: [RFC PATCH 1/4] selftests/binderfs: Run clang-format on binderfs test
Date: Wed, 15 May 2024 01:08:02 +0000
Message-Id: <20240515010805.605511-2-xandfury@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515010805.605511-1-xandfury@gmail.com>
References: <20240515010805.605511-1-xandfury@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds some fixes towards making
`filesystems/binderfs/binderfs_test.c` conform to the kernel coding
standards, improving readability and maintainability.

Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
---
 .../filesystems/binderfs/binderfs_test.c      | 187 +++++++++++-------
 1 file changed, 116 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 5f362c0fd890..447ec4296e69 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -41,15 +41,16 @@ static void change_mountns(struct __test_metadata *_metadata)
 	int ret;

 	ret = unshare(CLONE_NEWNS);
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to unshare mount namespace",
-			strerror(errno));
+		       strerror(errno));
 	}

 	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
-	ASSERT_EQ(ret, 0) {
-		TH_LOG("%s - Failed to mount / as private",
-			strerror(errno));
+	ASSERT_EQ(ret, 0)
+	{
+		TH_LOG("%s - Failed to mount / as private", strerror(errno));
 	}
 }

@@ -61,22 +62,25 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	struct binderfs_device device = { 0 };
 	struct binder_version version = { 0 };
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
-		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
-	static const char * const binder_features[] = {
+	     device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") +
+			 BINDERFS_MAX_NAME];
+	static const char *const binder_features[] = {
 		"oneway_spam_detection",
 		"extended_error",
 	};

 	change_mountns(_metadata);

-	EXPECT_NE(mkdtemp(binderfs_mntpt), NULL) {
+	EXPECT_NE(mkdtemp(binderfs_mntpt), NULL)
+	{
 		TH_LOG("%s - Failed to create binderfs mountpoint",
-			strerror(errno));
+		       strerror(errno));
 		goto out;
 	}

 	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-	EXPECT_EQ(ret, 0) {
+	EXPECT_EQ(ret, 0)
+	{
 		if (errno == ENODEV)
 			SKIP(goto out, "binderfs missing");
 		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
@@ -87,11 +91,13 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)

 	memcpy(device.name, "my-binder", strlen("my-binder"));

-	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
+	snprintf(device_path, sizeof(device_path), "%s/binder-control",
+		 binderfs_mntpt);
 	fd = open(device_path, O_RDONLY | O_CLOEXEC);
-	EXPECT_GE(fd, 0) {
+	EXPECT_GE(fd, 0)
+	{
 		TH_LOG("%s - Failed to open binder-control device",
-			strerror(errno));
+		       strerror(errno));
 		goto umount;
 	}

@@ -99,22 +105,24 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	EXPECT_GE(ret, 0) {
+	EXPECT_GE(ret, 0)
+	{
 		TH_LOG("%s - Failed to allocate new binder device",
-			strerror(errno));
+		       strerror(errno));
 		goto umount;
 	}

 	TH_LOG("Allocated new binder device with major %d, minor %d, and name %s",
-		device.major, device.minor, device.name);
+	       device.major, device.minor, device.name);

 	/* success: binder device allocation */

-	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
+	snprintf(device_path, sizeof(device_path), "%s/my-binder",
+		 binderfs_mntpt);
 	fd = open(device_path, O_CLOEXEC | O_RDONLY);
-	EXPECT_GE(fd, 0) {
-		TH_LOG("%s - Failed to open my-binder device",
-			strerror(errno));
+	EXPECT_GE(fd, 0)
+	{
+		TH_LOG("%s - Failed to open my-binder device", strerror(errno));
 		goto umount;
 	}

@@ -122,9 +130,10 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	EXPECT_GE(ret, 0) {
+	EXPECT_GE(ret, 0)
+	{
 		TH_LOG("%s - Failed to open perform BINDER_VERSION request",
-			strerror(errno));
+		       strerror(errno));
 		goto umount;
 	}

@@ -133,23 +142,26 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 	/* success: binder transaction with binderfs binder device */

 	ret = unlink(device_path);
-	EXPECT_EQ(ret, 0) {
-		TH_LOG("%s - Failed to delete binder device",
-			strerror(errno));
+	EXPECT_EQ(ret, 0)
+	{
+		TH_LOG("%s - Failed to delete binder device", strerror(errno));
 		goto umount;
 	}

 	/* success: binder device removal */

-	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
+	snprintf(device_path, sizeof(device_path), "%s/binder-control",
+		 binderfs_mntpt);
 	ret = unlink(device_path);
-	EXPECT_NE(ret, 0) {
+	EXPECT_NE(ret, 0)
+	{
 		TH_LOG("Managed to delete binder-control device");
 		goto umount;
 	}
-	EXPECT_EQ(errno, EPERM) {
+	EXPECT_EQ(errno, EPERM)
+	{
 		TH_LOG("%s - Failed to delete binder-control device but exited with unexpected error code",
-			strerror(errno));
+		       strerror(errno));
 		goto umount;
 	}

@@ -159,9 +171,10 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		snprintf(device_path, sizeof(device_path), "%s/features/%s",
 			 binderfs_mntpt, binder_features[i]);
 		fd = open(device_path, O_CLOEXEC | O_RDONLY);
-		EXPECT_GE(fd, 0) {
+		EXPECT_GE(fd, 0)
+		{
 			TH_LOG("%s - Failed to open binder feature: %s",
-				strerror(errno), binder_features[i]);
+			       strerror(errno), binder_features[i]);
 			goto umount;
 		}
 		close(fd);
@@ -172,12 +185,14 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)

 umount:
 	ret = umount2(binderfs_mntpt, MNT_DETACH);
-	EXPECT_EQ(ret, 0) {
+	EXPECT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
 	}
 rmdir:
 	ret = rmdir(binderfs_mntpt);
-	EXPECT_EQ(ret, 0) {
+	EXPECT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to rmdir binderfs mount", strerror(errno));
 	}
 out:
@@ -259,7 +274,8 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
 			return -1;

 		if (setgroups_fd >= 0) {
-			ret = write_nointr(setgroups_fd, "deny", sizeof("deny") - 1);
+			ret = write_nointr(setgroups_fd, "deny",
+					   sizeof("deny") - 1);
 			close_prot_errno_disarm(setgroups_fd);
 			if (ret != sizeof("deny") - 1)
 				return -1;
@@ -299,29 +315,34 @@ static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
 	close_prot_errno_disarm(syncfds[1]);

 	ret = unshare(CLONE_NEWUSER);
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to unshare user namespace",
-			strerror(errno));
+		       strerror(errno));
 	}

 	ret = write_nointr(syncfds[0], "1", 1);
-	ASSERT_EQ(ret, 1) {
+	ASSERT_EQ(ret, 1)
+	{
 		TH_LOG("write_nointr() failed");
 	}

 	ret = read_nointr(syncfds[0], &buf, 1);
-	ASSERT_EQ(ret, 1) {
+	ASSERT_EQ(ret, 1)
+	{
 		TH_LOG("read_nointr() failed");
 	}

 	close_prot_errno_disarm(syncfds[0]);

-	ASSERT_EQ(setid_userns_root(), 0) {
+	ASSERT_EQ(setid_userns_root(), 0)
+	{
 		TH_LOG("setid_userns_root() failed");
 	}
 }

-static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2], pid_t pid)
+static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2],
+			  pid_t pid)
 {
 	int ret;
 	char buf;
@@ -330,24 +351,28 @@ static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2], pid
 	close_prot_errno_disarm(syncfds[0]);

 	ret = read_nointr(syncfds[1], &buf, 1);
-	ASSERT_EQ(ret, 1) {
+	ASSERT_EQ(ret, 1)
+	{
 		TH_LOG("read_nointr() failed");
 	}

 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getuid());
 	ret = write_id_mapping(UID_MAP, pid, id_map, strlen(id_map));
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("write_id_mapping(UID_MAP) failed");
 	}

 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getgid());
 	ret = write_id_mapping(GID_MAP, pid, id_map, strlen(id_map));
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("write_id_mapping(GID_MAP) failed");
 	}

 	ret = write_nointr(syncfds[1], "1", 1);
-	ASSERT_EQ(ret, 1) {
+	ASSERT_EQ(ret, 1)
+	{
 		TH_LOG("write_nointr() failed");
 	}

@@ -365,7 +390,7 @@ static void *binder_version_thread(void *data)
 	ret = ioctl(fd, BINDER_VERSION, &version);
 	if (ret < 0)
 		TH_LOG("%s - Failed to open perform BINDER_VERSION request\n",
-			strerror(errno));
+		       strerror(errno));

 	pthread_exit(data);
 }
@@ -385,15 +410,18 @@ TEST(binderfs_stress)
 	size_t len;
 	struct binderfs_device device = { 0 };
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
-		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
+	     device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") +
+			 BINDERFS_MAX_NAME];

 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to create socket pair", strerror(errno));
 	}

 	pid = fork();
-	ASSERT_GE(pid, 0) {
+	ASSERT_GE(pid, 0)
+	{
 		TH_LOG("%s - Failed to fork", strerror(errno));
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
@@ -406,47 +434,54 @@ TEST(binderfs_stress)
 		change_userns(_metadata, syncfds);
 		change_mountns(_metadata);

-		ASSERT_NE(mkdtemp(binderfs_mntpt), NULL) {
+		ASSERT_NE(mkdtemp(binderfs_mntpt), NULL)
+		{
 			TH_LOG("%s - Failed to create binderfs mountpoint",
-				strerror(errno));
+			       strerror(errno));
 		}

 		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-		ASSERT_EQ(ret, 0) {
+		ASSERT_EQ(ret, 0)
+		{
 			TH_LOG("%s - Failed to mount binderfs, check if CONFIG_ANDROID_BINDERFS is enabled in the running kernel",
-				strerror(errno));
+			       strerror(errno));
 		}

 		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
-
 			snprintf(device_path, sizeof(device_path),
 				 "%s/binder-control", binderfs_mntpt);
 			fd = open(device_path, O_RDONLY | O_CLOEXEC);
-			ASSERT_GE(fd, 0) {
+			ASSERT_GE(fd, 0)
+			{
 				TH_LOG("%s - Failed to open binder-control device",
-					strerror(errno));
+				       strerror(errno));
 			}

 			memset(&device, 0, sizeof(device));
 			snprintf(device.name, sizeof(device.name), "%d", i);
 			ret = ioctl(fd, BINDER_CTL_ADD, &device);
 			close_prot_errno_disarm(fd);
-			ASSERT_EQ(ret, 0) {
+			ASSERT_EQ(ret, 0)
+			{
 				TH_LOG("%s - Failed to allocate new binder device",
-					strerror(errno));
+				       strerror(errno));
 			}

 			snprintf(device_path, sizeof(device_path), "%s/%d",
 				 binderfs_mntpt, i);
 			fds[i] = open(device_path, O_RDONLY | O_CLOEXEC);
-			ASSERT_GE(fds[i], 0) {
-				TH_LOG("%s - Failed to open binder device", strerror(errno));
+			ASSERT_GE(fds[i], 0)
+			{
+				TH_LOG("%s - Failed to open binder device",
+				       strerror(errno));
 			}
 		}

 		ret = umount2(binderfs_mntpt, MNT_DETACH);
-		ASSERT_EQ(ret, 0) {
-			TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
+		ASSERT_EQ(ret, 0)
+		{
+			TH_LOG("%s - Failed to unmount binderfs",
+			       strerror(errno));
 			rmdir(binderfs_mntpt);
 		}

@@ -458,10 +493,12 @@ TEST(binderfs_stress)
 		pthread_attr_init(&attr);
 		for (k = 0; k < ARRAY_SIZE(fds); k++) {
 			for (i = 0; i < nthreads; i++) {
-				ret = pthread_create(&threads[i], &attr, binder_version_thread, INT_TO_PTR(fds[k]));
+				ret = pthread_create(&threads[i], &attr,
+						     binder_version_thread,
+						     INT_TO_PTR(fds[k]));
 				if (ret) {
 					TH_LOG("%s - Failed to create thread %d",
-						strerror(errno), i);
+					       strerror(errno), i);
 					break;
 				}
 			}
@@ -472,7 +509,8 @@ TEST(binderfs_stress)
 				ret = pthread_join(threads[j], &fdptr);
 				if (ret)
 					TH_LOG("%s - Failed to join thread %d for fd %d",
-						strerror(errno), j, PTR_TO_INT(fdptr));
+					       strerror(errno), j,
+					       PTR_TO_INT(fdptr));
 			}
 		}
 		pthread_attr_destroy(&attr);
@@ -486,7 +524,8 @@ TEST(binderfs_stress)
 	change_idmaps(_metadata, syncfds, pid);

 	ret = wait_for_pid(pid);
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("wait_for_pid() failed");
 	}
 }
@@ -494,10 +533,12 @@ TEST(binderfs_stress)
 TEST(binderfs_test_privileged)
 {
 	if (geteuid() != 0)
-		SKIP(return, "Tests are not run as root. Skipping privileged tests");
+		SKIP(return,
+			   "Tests are not run as root. Skipping privileged tests");

 	if (__do_binderfs_test(_metadata))
-		SKIP(return, "The Android binderfs filesystem is not available");
+		SKIP(return,
+			   "The Android binderfs filesystem is not available");
 }

 TEST(binderfs_test_unprivileged)
@@ -507,12 +548,14 @@ TEST(binderfs_test_unprivileged)
 	pid_t pid;

 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	ASSERT_EQ(ret, 0) {
+	ASSERT_EQ(ret, 0)
+	{
 		TH_LOG("%s - Failed to create socket pair", strerror(errno));
 	}

 	pid = fork();
-	ASSERT_GE(pid, 0) {
+	ASSERT_GE(pid, 0)
+	{
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
 		TH_LOG("%s - Failed to fork", strerror(errno));
@@ -530,8 +573,10 @@ TEST(binderfs_test_unprivileged)
 	ret = wait_for_pid(pid);
 	if (ret) {
 		if (ret == 2)
-			SKIP(return, "The Android binderfs filesystem is not available");
-		ASSERT_EQ(ret, 0) {
+			SKIP(return,
+				   "The Android binderfs filesystem is not available");
+		ASSERT_EQ(ret, 0)
+		{
 			TH_LOG("wait_for_pid() failed");
 		}
 	}
--
2.34.1


