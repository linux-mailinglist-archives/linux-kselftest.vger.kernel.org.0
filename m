Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D0774130D
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjF1Nw7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:52:59 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:24582 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230134AbjF1Nw7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:52:59 -0400
X-QQ-mid: bizesmtp70t1687960359tni690qj
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:52:38 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3gKXKanXwgZabHXjbnoFngx1wvfnSz0uOskTN7UFKKfl8K9pwyoW
        lLGGXQ8tWZlqCvyDZd0AS9Br15JwY11vDDscXdIG+B2xyH2CUJ3lhz/pVb/FlgJptB4/km+
        ghISocdsunroAA+gCYmqxyiwuj5DrrEKclcEVznVP/9ztyYwXYLEF2KKM7OL21LdUXvqImY
        Ld8SKewCaxu9d1+NIioVIiBEnxkpFptnqbaxkoT1zu4Xm+qIzoPVm49uns8mRQxOEIaIFeD
        0VO9Cw7WUFs9mG78HATpmsnWEWqs52czIiLumoLQMWt6CbQBi/swc443hQqi3VjTXtfg7xf
        0jbZlzFyg9BBUmBopZgsn4+QtumJG4YNBhYf8CeIe+VLdd46AdFhzio8IKJOi/7oBIPYOUg
        ILQtAwD04Vg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7823172912297135595
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 14/14] selftests/nolibc: add mmap and munmap test cases
Date:   Wed, 28 Jun 2023 21:51:57 +0800
Message-Id: <90179484b62c0bafb0fad9b03680136bd6fedee3.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Three mmap/munmap related test cases are added:

- mmap_bad: the length argument must be greater than 0, otherwise, fail
  with -EINVAL.

- munmap_bad: invalid (void *)-1 address fail with -EINVAL.

- mmap_munmap_good: mmap() a file with good offset and then munmap().

Note, it is not easy to find a unique file for mmap() in different
scenes, so, a file list is used to search the right one:

- /proc/1/exe, for 'run' and 'run-user' target
  'run-user' can not find '/proc/self/exe'

- /proc/self/exe, for 'libc-test' target
  normal program 'libc-test' has no permission to access '/proc/1/exe'

- the others, for kernel without procfs
  let it pass even with 'worst case' kernel configs

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/bff82ea6-610b-4471-a28b-6c76c28604a6@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 80ab29e2887c..b178bfa29ad9 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -592,6 +592,59 @@ static int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_mmap_munmap(void)
+{
+	int ret, fd, i;
+	void *mem;
+	size_t page_size, file_size, length;
+	off_t offset, pa_offset;
+	struct stat stat_buf;
+	static const char * const files[] = {
+		"/proc/1/exe", "/proc/self/exe",
+		"/init", "/sbin/init", "/etc/init", "/bin/init", "/bin/sh",
+		NULL
+	};
+
+	page_size = getpagesize();
+	if (page_size < 0)
+		return -1;
+
+	/* find a right file to mmap, existed and accessible */
+	for (i = 0; files[i] != NULL; i++) {
+		ret = fd = open(files[i], O_RDONLY);
+		if (ret == -1)
+			continue;
+		else
+			break;
+	}
+	if (ret == -1)
+		return ret;
+
+	ret = stat(files[i], &stat_buf);
+	if (ret == -1)
+		goto end;
+
+	file_size = stat_buf.st_size;
+	offset = file_size - 1;
+	if (offset < 0)
+		offset = 0;
+	length = file_size - offset;
+	pa_offset = offset & ~(page_size - 1);
+
+	mem = mmap(NULL, length + offset - pa_offset, PROT_READ, MAP_SHARED, fd, pa_offset);
+	if (mem == MAP_FAILED) {
+		ret = -1;
+		goto end;
+	}
+
+	ret = munmap(mem, length + offset - pa_offset);
+
+end:
+	close(fd);
+	return ret;
+}
+
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -666,6 +719,9 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
+		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
+		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)-1, 0), -1, EINVAL); break;
+		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.25.1

