Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEA6203EF9
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jun 2020 20:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgFVSRW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Jun 2020 14:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgFVSQ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Jun 2020 14:16:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB20C061795
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j4so7909329plk.3
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jun 2020 11:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3p4Z8TPcn7XkHpUhjPHvxSNurMzlg2ZmMDhncesCiLE=;
        b=bLaz08tVa0vGdz5N5HvaILK7PrvIFcrHe9i/udEVEDczj9fmrnvMAXd0ftgUCZg83i
         laPUmgZIz1L6gr14QmeXME+MGVtUkEeNY4h+CUyJA2puJ5YWoLqW/tnPBnDWpdlPN9ZM
         MWlLnJqzlyWlSnxNmqlX+k/fjdzQ2j5eYfJYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3p4Z8TPcn7XkHpUhjPHvxSNurMzlg2ZmMDhncesCiLE=;
        b=BMOaGauBZjYfagJp2qx60go+IlooniY99xJwTnRZxMlhvzVpzNDh+ydh8Z4d+cENau
         akG3ZOGIh6AFFDkIAyUzv0AswFHq1pO+LbD7GbsoRn+QQuy77e7TOomfEZlPYhGe948l
         lkVn/dY/C6zQgWPxRwg1Wrgg/K7VkWTJSVtSHIRYo0ZI4mkbcQPgZ7KB6JjKiyZw0PX+
         nd58cfGUzmPtJr8pSa6lyt87sLynA6t30gIzosLIrP3pkYmW+bkzIX3plufUje3BsfZQ
         x/WmcAZHC00NMDaDmS9ZEO447SVa+gxj4dp4UAdeWmwlaap3yRmHzH9qMjCTk8BNI6FN
         zLFA==
X-Gm-Message-State: AOAM533WuaW+9x83bzP3kRAo/q54Fsfr0D4JUL11+ASHPkaInO5cFLx6
        knARjQ2mfcylDhTIAuuuu+J3vQ==
X-Google-Smtp-Source: ABdhPJxvvsYn2vMS7509fJT2isIJqbcRJ+QhY/wQ2PDoUXivb32fuxGug2Gz1RBiDvCLG3ofUhLrGA==
X-Received: by 2002:a17:902:eb13:: with SMTP id l19mr21500287plb.213.1592849818909;
        Mon, 22 Jun 2020 11:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o16sm11776658pgg.57.2020.06.22.11.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 11:16:55 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/8] selftests/binderfs: Fix harness API usage
Date:   Mon, 22 Jun 2020 11:16:46 -0700
Message-Id: <20200622181651.2795217-4-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622181651.2795217-1-keescook@chromium.org>
References: <20200622181651.2795217-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The binderfs test mixed the full harness API and the selftest API.
Adjust to use only the harness API so that the harness API can switch
to using the selftest API internally in future patches.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../filesystems/binderfs/binderfs_test.c      | 284 +++++++++---------
 1 file changed, 146 insertions(+), 138 deletions(-)

diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 8a6b507e34a8..1d27f52c61e6 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -21,7 +21,6 @@
 #include <linux/android/binder.h>
 #include <linux/android/binderfs.h>
 
-#include "../../kselftest.h"
 #include "../../kselftest_harness.h"
 
 #define DEFAULT_THREADS 4
@@ -37,37 +36,26 @@
 		fd = -EBADF;        \
 	}
 
-#define log_exit(format, ...)                                                  \
-	({                                                                     \
-		fprintf(stderr, format "\n", ##__VA_ARGS__);                   \
-		exit(EXIT_FAILURE);                                            \
-	})
-
-static void change_mountns(void)
+static void change_mountns(struct __test_metadata *_metadata)
 {
 	int ret;
 
 	ret = unshare(CLONE_NEWNS);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unshare mount namespace\n",
-				   strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unshare mount namespace",
+			strerror(errno));
+	}
 
 	ret = mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to mount / as private\n",
-				   strerror(errno));
-}
-
-static void rmdir_protect_errno(const char *dir)
-{
-	int saved_errno = errno;
-	(void)rmdir(dir);
-	errno = saved_errno;
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to mount / as private",
+			strerror(errno));
+	}
 }
 
-static int __do_binderfs_test(void)
+static int __do_binderfs_test(struct __test_metadata *_metadata)
 {
-	int fd, ret, saved_errno;
+	int fd, ret, saved_errno, result = 1;
 	size_t len;
 	ssize_t wret;
 	struct binderfs_device device = { 0 };
@@ -75,113 +63,107 @@ static int __do_binderfs_test(void)
 	char binderfs_mntpt[] = P_tmpdir "/binderfs_XXXXXX",
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
-	change_mountns();
+	change_mountns(_metadata);
 
-	if (!mkdtemp(binderfs_mntpt))
-		ksft_exit_fail_msg(
-			"%s - Failed to create binderfs mountpoint\n",
+	EXPECT_NE(mkdtemp(binderfs_mntpt), NULL) {
+		TH_LOG("%s - Failed to create binderfs mountpoint",
 			strerror(errno));
+		goto out;
+	}
 
 	ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-	if (ret < 0) {
-		if (errno != ENODEV)
-			ksft_exit_fail_msg("%s - Failed to mount binderfs\n",
-					   strerror(errno));
-
-		rmdir_protect_errno(binderfs_mntpt);
-		return 1;
+	EXPECT_EQ(ret, 0) {
+		if (errno == ENODEV)
+			XFAIL(goto out, "binderfs missing");
+		TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+		goto rmdir;
 	}
 
-	/* binderfs mount test passed */
-	ksft_inc_pass_cnt();
+	/* success: binderfs mounted */
 
 	memcpy(device.name, "my-binder", strlen("my-binder"));
 
 	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
 	fd = open(device_path, O_RDONLY | O_CLOEXEC);
-	if (fd < 0)
-		ksft_exit_fail_msg(
-			"%s - Failed to open binder-control device\n",
+	EXPECT_GE(fd, 0) {
+		TH_LOG("%s - Failed to open binder-control device",
 			strerror(errno));
+		goto umount;
+	}
 
 	ret = ioctl(fd, BINDER_CTL_ADD, &device);
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to allocate new binder device\n",
+	EXPECT_GE(ret, 0) {
+		TH_LOG("%s - Failed to allocate new binder device",
 			strerror(errno));
+		goto umount;
 	}
 
-	ksft_print_msg(
-		"Allocated new binder device with major %d, minor %d, and name %s\n",
+	TH_LOG("Allocated new binder device with major %d, minor %d, and name %s",
 		device.major, device.minor, device.name);
 
-	/* binder device allocation test passed */
-	ksft_inc_pass_cnt();
+	/* success: binder device allocation */
 
 	snprintf(device_path, sizeof(device_path), "%s/my-binder", binderfs_mntpt);
 	fd = open(device_path, O_CLOEXEC | O_RDONLY);
-	if (fd < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("%s - Failed to open my-binder device\n",
-				   strerror(errno));
+	EXPECT_GE(fd, 0) {
+		TH_LOG("%s - Failed to open my-binder device",
+			strerror(errno));
+		goto umount;
 	}
 
 	ret = ioctl(fd, BINDER_VERSION, &version);
 	saved_errno = errno;
 	close(fd);
 	errno = saved_errno;
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to open perform BINDER_VERSION request\n",
+	EXPECT_GE(ret, 0) {
+		TH_LOG("%s - Failed to open perform BINDER_VERSION request",
 			strerror(errno));
+		goto umount;
 	}
 
-	ksft_print_msg("Detected binder version: %d\n",
-		       version.protocol_version);
+	TH_LOG("Detected binder version: %d", version.protocol_version);
 
-	/* binder transaction with binderfs binder device passed */
-	ksft_inc_pass_cnt();
+	/* success: binder transaction with binderfs binder device */
 
 	ret = unlink(device_path);
-	if (ret < 0) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("%s - Failed to delete binder device\n",
-				   strerror(errno));
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to delete binder device",
+			strerror(errno));
+		goto umount;
 	}
 
-	/* binder device removal passed */
-	ksft_inc_pass_cnt();
+	/* success: binder device removal */
 
 	snprintf(device_path, sizeof(device_path), "%s/binder-control", binderfs_mntpt);
 	ret = unlink(device_path);
-	if (!ret) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg("Managed to delete binder-control device\n");
-	} else if (errno != EPERM) {
-		rmdir_protect_errno(binderfs_mntpt);
-		ksft_exit_fail_msg(
-			"%s - Failed to delete binder-control device but exited with unexpected error code\n",
+	EXPECT_NE(ret, 0) {
+		TH_LOG("Managed to delete binder-control device");
+		goto umount;
+	}
+	EXPECT_EQ(errno, EPERM) {
+		TH_LOG("%s - Failed to delete binder-control device but exited with unexpected error code",
 			strerror(errno));
+		goto umount;
 	}
 
-	/* binder-control device removal failed as expected */
-	ksft_inc_xfail_cnt();
+	/* success: binder-control device removal failed as expected */
+	result = 0;
 
-on_error:
+umount:
 	ret = umount2(binderfs_mntpt, MNT_DETACH);
-	rmdir_protect_errno(binderfs_mntpt);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unmount binderfs\n",
-				   strerror(errno));
-
-	/* binderfs unmount test passed */
-	ksft_inc_pass_cnt();
-	return 0;
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
+	}
+rmdir:
+	ret = rmdir(binderfs_mntpt);
+	EXPECT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to rmdir binderfs mount", strerror(errno));
+	}
+out:
+	return result;
 }
 
 static int wait_for_pid(pid_t pid)
@@ -291,7 +273,7 @@ static int write_id_mapping(enum idmap_type type, pid_t pid, const char *buf,
 	return 0;
 }
 
-static void change_userns(int syncfds[2])
+static void change_userns(struct __test_metadata *_metadata, int syncfds[2])
 {
 	int ret;
 	char buf;
@@ -299,25 +281,29 @@ static void change_userns(int syncfds[2])
 	close_prot_errno_disarm(syncfds[1]);
 
 	ret = unshare(CLONE_NEWUSER);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to unshare user namespace\n",
-				   strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to unshare user namespace",
+			strerror(errno));
+	}
 
 	ret = write_nointr(syncfds[0], "1", 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("write_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("write_nointr() failed");
+	}
 
 	ret = read_nointr(syncfds[0], &buf, 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("read_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("read_nointr() failed");
+	}
 
 	close_prot_errno_disarm(syncfds[0]);
 
-	if (setid_userns_root())
-		ksft_exit_fail_msg("setid_userns_root() failed");
+	ASSERT_EQ(setid_userns_root(), 0) {
+		TH_LOG("setid_userns_root() failed");
+	}
 }
 
-static void change_idmaps(int syncfds[2], pid_t pid)
+static void change_idmaps(struct __test_metadata *_metadata, int syncfds[2], pid_t pid)
 {
 	int ret;
 	char buf;
@@ -326,35 +312,42 @@ static void change_idmaps(int syncfds[2], pid_t pid)
 	close_prot_errno_disarm(syncfds[0]);
 
 	ret = read_nointr(syncfds[1], &buf, 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("read_nointr() failed\n");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("read_nointr() failed");
+	}
 
 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getuid());
 	ret = write_id_mapping(UID_MAP, pid, id_map, strlen(id_map));
-	if (ret)
-		ksft_exit_fail_msg("write_id_mapping(UID_MAP) failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("write_id_mapping(UID_MAP) failed");
+	}
 
 	snprintf(id_map, sizeof(id_map), "0 %d 1\n", getgid());
 	ret = write_id_mapping(GID_MAP, pid, id_map, strlen(id_map));
-	if (ret)
-		ksft_exit_fail_msg("write_id_mapping(GID_MAP) failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("write_id_mapping(GID_MAP) failed");
+	}
 
 	ret = write_nointr(syncfds[1], "1", 1);
-	if (ret != 1)
-		ksft_exit_fail_msg("write_nointr() failed");
+	ASSERT_EQ(ret, 1) {
+		TH_LOG("write_nointr() failed");
+	}
 
 	close_prot_errno_disarm(syncfds[1]);
 }
 
+struct __test_metadata *_thread_metadata;
 static void *binder_version_thread(void *data)
 {
+	struct __test_metadata *_metadata = _thread_metadata;
 	int fd = PTR_TO_INT(data);
 	struct binder_version version = { 0 };
 	int ret;
 
 	ret = ioctl(fd, BINDER_VERSION, &version);
 	if (ret < 0)
-		ksft_print_msg("%s - Failed to open perform BINDER_VERSION request\n", strerror(errno));
+		TH_LOG("%s - Failed to open perform BINDER_VERSION request\n",
+			strerror(errno));
 
 	pthread_exit(data);
 }
@@ -377,68 +370,79 @@ TEST(binderfs_stress)
 		device_path[sizeof(P_tmpdir "/binderfs_XXXXXX/") + BINDERFS_MAX_NAME];
 
 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to create socket pair", strerror(errno));
+	}
 
 	pid = fork();
-	if (pid < 0) {
+	ASSERT_GE(pid, 0) {
+		TH_LOG("%s - Failed to fork", strerror(errno));
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
-		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
 	}
 
 	if (pid == 0) {
 		int i, j, k, nthreads;
 		pthread_attr_t attr;
 		pthread_t threads[DEFAULT_THREADS];
-		change_userns(syncfds);
-		change_mountns();
+		change_userns(_metadata, syncfds);
+		change_mountns(_metadata);
 
-		if (!mkdtemp(binderfs_mntpt))
-			log_exit("%s - Failed to create binderfs mountpoint\n",
-				 strerror(errno));
+		ASSERT_NE(mkdtemp(binderfs_mntpt), NULL) {
+			TH_LOG("%s - Failed to create binderfs mountpoint",
+				strerror(errno));
+		}
 
 		ret = mount(NULL, binderfs_mntpt, "binder", 0, 0);
-		if (ret < 0)
-			log_exit("%s - Failed to mount binderfs\n", strerror(errno));
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("%s - Failed to mount binderfs", strerror(errno));
+		}
 
 		for (int i = 0; i < ARRAY_SIZE(fds); i++) {
 
 			snprintf(device_path, sizeof(device_path),
 				 "%s/binder-control", binderfs_mntpt);
 			fd = open(device_path, O_RDONLY | O_CLOEXEC);
-			if (fd < 0)
-				log_exit("%s - Failed to open binder-control device\n", strerror(errno));
+			ASSERT_GE(fd, 0) {
+				TH_LOG("%s - Failed to open binder-control device",
+					strerror(errno));
+			}
 
 			memset(&device, 0, sizeof(device));
 			snprintf(device.name, sizeof(device.name), "%d", i);
 			ret = ioctl(fd, BINDER_CTL_ADD, &device);
 			close_prot_errno_disarm(fd);
-			if (ret < 0)
-				log_exit("%s - Failed to allocate new binder device\n", strerror(errno));
+			ASSERT_EQ(ret, 0) {
+				TH_LOG("%s - Failed to allocate new binder device",
+					strerror(errno));
+			}
 
 			snprintf(device_path, sizeof(device_path), "%s/%d",
 				 binderfs_mntpt, i);
 			fds[i] = open(device_path, O_RDONLY | O_CLOEXEC);
-			if (fds[i] < 0)
-				log_exit("%s - Failed to open binder device\n", strerror(errno));
+			ASSERT_GE(fds[i], 0) {
+				TH_LOG("%s - Failed to open binder device", strerror(errno));
+			}
 		}
 
 		ret = umount2(binderfs_mntpt, MNT_DETACH);
-		rmdir_protect_errno(binderfs_mntpt);
-		if (ret < 0)
-			log_exit("%s - Failed to unmount binderfs\n", strerror(errno));
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("%s - Failed to unmount binderfs", strerror(errno));
+			rmdir(binderfs_mntpt);
+		}
 
 		nthreads = get_nprocs_conf();
 		if (nthreads > DEFAULT_THREADS)
 			nthreads = DEFAULT_THREADS;
 
+		_thread_metadata = _metadata;
 		pthread_attr_init(&attr);
 		for (k = 0; k < ARRAY_SIZE(fds); k++) {
 			for (i = 0; i < nthreads; i++) {
 				ret = pthread_create(&threads[i], &attr, binder_version_thread, INT_TO_PTR(fds[k]));
 				if (ret) {
-					ksft_print_msg("%s - Failed to create thread %d\n", strerror(errno), i);
+					TH_LOG("%s - Failed to create thread %d",
+						strerror(errno), i);
 					break;
 				}
 			}
@@ -448,7 +452,8 @@ TEST(binderfs_stress)
 
 				ret = pthread_join(threads[j], &fdptr);
 				if (ret)
-					ksft_print_msg("%s - Failed to join thread %d for fd %d\n", strerror(errno), j, PTR_TO_INT(fdptr));
+					TH_LOG("%s - Failed to join thread %d for fd %d",
+						strerror(errno), j, PTR_TO_INT(fdptr));
 			}
 		}
 		pthread_attr_destroy(&attr);
@@ -459,11 +464,12 @@ TEST(binderfs_stress)
 		exit(EXIT_SUCCESS);
 	}
 
-	change_idmaps(syncfds, pid);
+	change_idmaps(_metadata, syncfds, pid);
 
 	ret = wait_for_pid(pid);
-	if (ret)
-		ksft_exit_fail_msg("wait_for_pid() failed");
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("wait_for_pid() failed");
+	}
 }
 
 TEST(binderfs_test_privileged)
@@ -471,7 +477,7 @@ TEST(binderfs_test_privileged)
 	if (geteuid() != 0)
 		XFAIL(return, "Tests are not run as root. Skipping privileged tests");
 
-	if (__do_binderfs_test() == 1)
+	if (__do_binderfs_test(_metadata))
 		XFAIL(return, "The Android binderfs filesystem is not available");
 }
 
@@ -482,31 +488,33 @@ TEST(binderfs_test_unprivileged)
 	pid_t pid;
 
 	ret = socketpair(PF_LOCAL, SOCK_STREAM | SOCK_CLOEXEC, 0, syncfds);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s - Failed to create socket pair", strerror(errno));
+	ASSERT_EQ(ret, 0) {
+		TH_LOG("%s - Failed to create socket pair", strerror(errno));
+	}
 
 	pid = fork();
-	if (pid < 0) {
+	ASSERT_GE(pid, 0) {
 		close_prot_errno_disarm(syncfds[0]);
 		close_prot_errno_disarm(syncfds[1]);
-		ksft_exit_fail_msg("%s - Failed to fork", strerror(errno));
+		TH_LOG("%s - Failed to fork", strerror(errno));
 	}
 
 	if (pid == 0) {
-		change_userns(syncfds);
-		if (__do_binderfs_test() == 1)
+		change_userns(_metadata, syncfds);
+		if (__do_binderfs_test(_metadata))
 			exit(2);
 		exit(EXIT_SUCCESS);
 	}
 
-	change_idmaps(syncfds, pid);
+	change_idmaps(_metadata, syncfds, pid);
 
 	ret = wait_for_pid(pid);
 	if (ret) {
 		if (ret == 2)
 			XFAIL(return, "The Android binderfs filesystem is not available");
-		else
-			ksft_exit_fail_msg("wait_for_pid() failed");
+		ASSERT_EQ(ret, 0) {
+			TH_LOG("wait_for_pid() failed");
+		}
 	}
 }
 
-- 
2.25.1

