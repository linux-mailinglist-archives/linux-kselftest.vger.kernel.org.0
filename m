Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FCF31E324
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Feb 2021 00:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhBQXkh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Feb 2021 18:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbhBQXka (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Feb 2021 18:40:30 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1FBC0613D6
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Feb 2021 15:39:50 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id m20so12925191ilj.13
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Feb 2021 15:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language;
        bh=OAi3bCTUamV79nUDzWdo6STXlztjyx8SQiJkl7CAOGc=;
        b=KPX1xdgo0G7UDa9OsqzjK7U8QZ2Q2OVsQNtbD/xrdW2EezvmWvMTF1J87hXgcdHWyt
         dUvr++z/dvOp2gTTfzmAt95R04Xdx7Xr4hRLp7Kd2Dk9/hmGjVlmwUx4soci1WCxTCcK
         hO4Ln30fepIsxxsx6roel9w3lIDMKi+cc7RqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language;
        bh=OAi3bCTUamV79nUDzWdo6STXlztjyx8SQiJkl7CAOGc=;
        b=SuOeRGSGm6MavoSyDOAJzLavgQDbRfxKIjlZ//r/bzqqeOTq8xbmUi5/i8n4bCUzTd
         LwDennJ4oOCN93nvgASEiaKVHDdpTMwUg0bJv8d0/ogRrItLG3t+BTgh9tynnuzGlldY
         BcTE0S1cN5ksosSa3Y8DPVZ1h7cjRa7bjJGG3DyOCjW0qhky5UfWg3Cl1GynV45lWsTz
         amcqp1RO6doQvjo0DVbTs4McXUlEAASiiwhV3pCog4vvx5yOH6FFhKklujVB5kHdoFiv
         YPJvIjIeanP929Tv7fSbKombVa3o9dhm63rBIA5vAZvd3+vNmdj3k0ibBY0Kgis6O9cs
         r8HA==
X-Gm-Message-State: AOAM532JksqXUPWdTeXSipK4BQbdyNjT6sHuv0ZgRIDlVZyacueiK2Ag
        OoKBnCMTKDON9yiQlYHPkqvRmtjVZTFFfA==
X-Google-Smtp-Source: ABdhPJweicADcz/OL1zMHCYOo53UohCs/UVFCEWjXj/JMDSKqQeUwh7mqbSG8j08+H2J8WA2k3OHMg==
X-Received: by 2002:a05:6e02:1a68:: with SMTP id w8mr1271735ilv.147.1613605189121;
        Wed, 17 Feb 2021 15:39:49 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id b11sm2170541ilj.19.2021.02.17.15.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 15:39:48 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest update for Linux 5.12-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Message-ID: <448c2248-d217-c3fe-3b03-761fa4749b78@linuxfoundation.org>
Date:   Wed, 17 Feb 2021 16:39:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------E46C5C00380023A0CB943BAD"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------E46C5C00380023A0CB943BAD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest update for Linux 5.12-rc1.

This Kselftest update for Linux 5.12-rc1 consists of:

- dmabuf-heaps test fixes and cleanups from John Stultz.
- seccomp test fix to accept any valid fd in user_notification_addfd.
- Minor fixes to breakpoints and vDSO tests.
- Minor code cleanups to ipc and x86 tests.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 92bf22614b21a2706f4993b278017e437f7785b3:

   Linux 5.11-rc7 (2021-02-07 13:57:38 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-next-5.12-rc1

for you to fetch changes up to e0c0840a46db9d50ba7391082d665d74f320c39f:

   selftests/seccomp: Accept any valid fd in user_notification_addfd 
(2021-02-09 17:39:01 -0700)

----------------------------------------------------------------
linux-kselftest-next-5.12-rc1

This Kselftest update for Linux 5.12-rc1 consists of:

- dmabuf-heaps test fixes and cleanups from John Stultz.
- seccomp test fix to accept any valid fd in user_notification_addfd.
- Minor fixes to breakpoints and vDSO tests.
- Minor code cleanups to ipc and x86 tests.

----------------------------------------------------------------
John Stultz (5):
       kselftests: dmabuf-heaps: Fix Makefile's inclusion of the 
kernel's usr/include dir
       kselftests: dmabuf-heaps: Add clearer checks on DMABUF_BEGIN/END_SYNC
       kselftests: dmabuf-heaps: Softly fail if don't find a vgem device
       kselftests: dmabuf-heaps: Cleanup test output
       kselftests: dmabuf-heaps: Add extra checking that allocated 
buffers are zeroed

Seth Forshee (1):
       selftests/seccomp: Accept any valid fd in user_notification_addfd

Tiezhu Yang (1):
       selftests: breakpoints: Use correct error messages in 
breakpoint_test_arm64.c

Tobias Klauser (2):
       selftests/vDSO: fix ABI selftest on riscv
       selftests/timens: add futex binary to .gitignore

Yang Li (2):
       selftests/ipc: remove unneeded semicolon
       selftests/x86/ldt_gdt: remove unneeded semicolon

  .../selftests/breakpoints/breakpoint_test_arm64.c  |   4 +-
  tools/testing/selftests/dmabuf-heaps/Makefile      |   2 +-
  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 149 
++++++++++++++++-----
  tools/testing/selftests/ipc/msgque.c               |   6 +-
  tools/testing/selftests/seccomp/seccomp_bpf.c      |   8 +-
  tools/testing/selftests/timens/.gitignore          |   1 +
  tools/testing/selftests/vDSO/vdso_config.h         |   4 +-
  tools/testing/selftests/x86/ldt_gdt.c              |   2 +-
  8 files changed, 132 insertions(+), 44 deletions(-)

----------------------------------------------------------------

--------------E46C5C00380023A0CB943BAD
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-next-5.12-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-next-5.12-rc1.diff"

diff --git a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
index ad41ea69001b..e7041816085a 100644
--- a/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
+++ b/tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
@@ -145,7 +145,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
 
 	if (ptrace(PTRACE_CONT, pid, NULL, NULL) < 0) {
 		ksft_print_msg(
-			"ptrace(PTRACE_SINGLESTEP) failed: %s\n",
+			"ptrace(PTRACE_CONT) failed: %s\n",
 			strerror(errno));
 		return false;
 	}
@@ -159,7 +159,7 @@ static bool run_test(int wr_size, int wp_size, int wr, int wp)
 	}
 	alarm(0);
 	if (WIFEXITED(status)) {
-		ksft_print_msg("child did not single-step\n");
+		ksft_print_msg("child exited prematurely\n");
 		return false;
 	}
 	if (!WIFSTOPPED(status)) {
diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
index 607c2acd2082..604b43ece15f 100644
--- a/tools/testing/selftests/dmabuf-heaps/Makefile
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
 
 TEST_GEN_PROGS = dmabuf-heap
 
diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 909da9cdda97..29af27acd40e 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -130,16 +130,13 @@ static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
 					 dmabuf_fd);
 }
 
-static void dmabuf_sync(int fd, int start_stop)
+static int dmabuf_sync(int fd, int start_stop)
 {
 	struct dma_buf_sync sync = {
 		.flags = start_stop | DMA_BUF_SYNC_RW,
 	};
-	int ret;
 
-	ret = ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
-	if (ret)
-		printf("sync failed %d\n", errno);
+	return ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
 }
 
 #define ONE_MEG (1024 * 1024)
@@ -151,16 +148,14 @@ static int test_alloc_and_import(char *heap_name)
 	void *p = NULL;
 	int ret;
 
-	printf("Testing heap: %s\n", heap_name);
-
 	heap_fd = dmabuf_heap_open(heap_name);
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Allocating 1 MEG\n");
+	printf("  Testing allocation and importing:  ");
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Allocation Failed!\n");
+		printf("FAIL (Allocation Failed!)\n");
 		ret = -1;
 		goto out;
 	}
@@ -172,11 +167,10 @@ static int test_alloc_and_import(char *heap_name)
 		 dmabuf_fd,
 		 0);
 	if (p == MAP_FAILED) {
-		printf("mmap() failed: %m\n");
+		printf("FAIL (mmap() failed)\n");
 		ret = -1;
 		goto out;
 	}
-	printf("mmap passed\n");
 
 	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	memset(p, 1, ONE_MEG / 2);
@@ -186,25 +180,31 @@ static int test_alloc_and_import(char *heap_name)
 	importer_fd = open_vgem();
 	if (importer_fd < 0) {
 		ret = importer_fd;
-		printf("Failed to open vgem\n");
-		goto out;
+		printf("(Could not open vgem - skipping):  ");
+	} else {
+		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+		if (ret < 0) {
+			printf("FAIL (Failed to import buffer)\n");
+			goto out;
+		}
 	}
 
-	ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-		printf("Failed to import buffer\n");
+		printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
 		goto out;
 	}
-	printf("import passed\n");
 
-	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	memset(p, 0xff, ONE_MEG);
-	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
-	printf("syncs passed\n");
+	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+	if (ret < 0) {
+		printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
+		goto out;
+	}
 
 	close_handle(importer_fd, handle);
 	ret = 0;
-
+	printf(" OK\n");
 out:
 	if (p)
 		munmap(p, ONE_MEG);
@@ -218,6 +218,84 @@ static int test_alloc_and_import(char *heap_name)
 	return ret;
 }
 
+static int test_alloc_zeroed(char *heap_name, size_t size)
+{
+	int heap_fd = -1, dmabuf_fd[32];
+	int i, j, ret;
+	void *p = NULL;
+	char *c;
+
+	printf("  Testing alloced %ldk buffers are zeroed:  ", size / 1024);
+	heap_fd = dmabuf_heap_open(heap_name);
+	if (heap_fd < 0)
+		return -1;
+
+	/* Allocate and fill a bunch of buffers */
+	for (i = 0; i < 32; i++) {
+		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
+		if (ret < 0) {
+			printf("FAIL (Allocation (%i) failed)\n", i);
+			goto out;
+		}
+		/* mmap and fill with simple pattern */
+		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
+		if (p == MAP_FAILED) {
+			printf("FAIL (mmap() failed!)\n");
+			ret = -1;
+			goto out;
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
+		memset(p, 0xff, size);
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
+		munmap(p, size);
+	}
+	/* close them all */
+	for (i = 0; i < 32; i++)
+		close(dmabuf_fd[i]);
+
+	/* Allocate and validate all buffers are zeroed */
+	for (i = 0; i < 32; i++) {
+		ret = dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]);
+		if (ret < 0) {
+			printf("FAIL (Allocation (%i) failed)\n", i);
+			goto out;
+		}
+
+		/* mmap and validate everything is zero */
+		p = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, dmabuf_fd[i], 0);
+		if (p == MAP_FAILED) {
+			printf("FAIL (mmap() failed!)\n");
+			ret = -1;
+			goto out;
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
+		c = (char *)p;
+		for (j = 0; j < size; j++) {
+			if (c[j] != 0) {
+				printf("FAIL (Allocated buffer not zeroed @ %i)\n", j);
+				break;
+			}
+		}
+		dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
+		munmap(p, size);
+	}
+	/* close them all */
+	for (i = 0; i < 32; i++)
+		close(dmabuf_fd[i]);
+
+	close(heap_fd);
+	printf("OK\n");
+	return 0;
+
+out:
+	while (i > 0) {
+		close(dmabuf_fd[i]);
+		i--;
+	}
+	close(heap_fd);
+	return ret;
+}
+
 /* Test the ioctl version compatibility w/ a smaller structure then expected */
 static int dmabuf_heap_alloc_older(int fd, size_t len, unsigned int flags,
 				   int *dmabuf_fd)
@@ -292,23 +370,24 @@ static int test_alloc_compat(char *heap_name)
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Testing (theoretical)older alloc compat\n");
+	printf("  Testing (theoretical)older alloc compat:  ");
 	ret = dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Older compat allocation failed!\n");
+		printf("FAIL (Older compat allocation failed!)\n");
 		ret = -1;
 		goto out;
 	}
 	close(dmabuf_fd);
+	printf("OK\n");
 
-	printf("Testing (theoretical)newer alloc compat\n");
+	printf("  Testing (theoretical)newer alloc compat:  ");
 	ret = dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Newer compat allocation failed!\n");
+		printf("FAIL (Newer compat allocation failed!)\n");
 		ret = -1;
 		goto out;
 	}
-	printf("Ioctl compatibility tests passed\n");
+	printf("OK\n");
 out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
@@ -327,17 +406,17 @@ static int test_alloc_errors(char *heap_name)
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Testing expected error cases\n");
+	printf("  Testing expected error cases:  ");
 	ret = dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid fd)!\n");
+		printf("FAIL (Did not see expected error (invalid fd)!)\n");
 		ret = -1;
 		goto out;
 	}
 
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid heap flags)!\n");
+		printf("FAIL (Did not see expected error (invalid heap flags)!)\n");
 		ret = -1;
 		goto out;
 	}
@@ -345,12 +424,12 @@ static int test_alloc_errors(char *heap_name)
 	ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
 					~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid fd flags)!\n");
+		printf("FAIL (Did not see expected error (invalid fd flags)!)\n");
 		ret = -1;
 		goto out;
 	}
 
-	printf("Expected error checking passed\n");
+	printf("OK\n");
 	ret = 0;
 out:
 	if (dmabuf_fd >= 0)
@@ -379,10 +458,20 @@ int main(void)
 		if (!strncmp(dir->d_name, "..", 3))
 			continue;
 
+		printf("Testing heap: %s\n", dir->d_name);
+		printf("=======================================\n");
 		ret = test_alloc_and_import(dir->d_name);
 		if (ret)
 			break;
 
+		ret = test_alloc_zeroed(dir->d_name, 4 * 1024);
+		if (ret)
+			break;
+
+		ret = test_alloc_zeroed(dir->d_name, ONE_MEG);
+		if (ret)
+			break;
+
 		ret = test_alloc_compat(dir->d_name);
 		if (ret)
 			break;
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 5ec4d9e18806..656c43c24044 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -69,7 +69,7 @@ int restore_queue(struct msgque_data *msgque)
 			printf("msgsnd failed (%m)\n");
 			ret = -errno;
 			goto destroy;
-		};
+		}
 	}
 	return 0;
 
@@ -180,7 +180,7 @@ int fill_msgque(struct msgque_data *msgque)
 				IPC_NOWAIT) != 0) {
 		printf("First message send failed (%m)\n");
 		return -errno;
-	};
+	}
 
 	msgbuf.mtype = ANOTHER_MSG_TYPE;
 	memcpy(msgbuf.mtext, ANOTHER_TEST_STRING, sizeof(ANOTHER_TEST_STRING));
@@ -188,7 +188,7 @@ int fill_msgque(struct msgque_data *msgque)
 				IPC_NOWAIT) != 0) {
 		printf("Second message send failed (%m)\n");
 		return -errno;
-	};
+	}
 	return 0;
 }
 
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c72f2b61b1..9338df6f4ca8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	/*
-	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
-	 * 4(listener), so the newly allocated fd should be 5.
-	 */
-	EXPECT_EQ(fd, 5);
+	EXPECT_GE(fd, 0);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, 6);
+	EXPECT_GE(fd, 0);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 2e43851b47c1..fe1eb8271b35 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 clock_nanosleep
 exec
+futex
 gettime_perf
 gettime_perf_cold
 procfs
diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
index 6a6fe8d4ff55..6188b16827d1 100644
--- a/tools/testing/selftests/vDSO/vdso_config.h
+++ b/tools/testing/selftests/vDSO/vdso_config.h
@@ -47,10 +47,12 @@
 #elif defined(__x86_64__)
 #define VDSO_VERSION		0
 #define VDSO_NAMES		1
-#elif defined(__riscv__)
+#elif defined(__riscv__) || defined(__riscv)
 #define VDSO_VERSION		5
 #define VDSO_NAMES		1
+#if __riscv_xlen == 32
 #define VDSO_32BIT		1
+#endif
 #else /* nds32 */
 #define VDSO_VERSION		4
 #define VDSO_NAMES		1
diff --git a/tools/testing/selftests/x86/ldt_gdt.c b/tools/testing/selftests/x86/ldt_gdt.c
index 1aef72df20a1..3a29346e1452 100644
--- a/tools/testing/selftests/x86/ldt_gdt.c
+++ b/tools/testing/selftests/x86/ldt_gdt.c
@@ -607,7 +607,7 @@ static void do_multicpu_tests(void)
 
 		failures++;
 		asm volatile ("mov %0, %%ss" : : "rm" (orig_ss));
-	};
+	}
 
 	ftx = 100;  /* Kill the thread. */
 	syscall(SYS_futex, &ftx, FUTEX_WAKE, 0, NULL, NULL, 0);

--------------E46C5C00380023A0CB943BAD--
