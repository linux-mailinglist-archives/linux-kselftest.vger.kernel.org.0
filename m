Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F04874B3C4
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 17:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjGGPJE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 11:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233327AbjGGPIz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 11:08:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C157926B5;
        Fri,  7 Jul 2023 08:08:49 -0700 (PDT)
X-QQ-mid: bizesmtp91t1688742515ti7jswgp
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 07 Jul 2023 23:08:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: D6RqbDSxuq6OBW3CsVdKIjFvpbHMW/wgNqC9K9ilhUQlZg0IgX7nDFBEM0M1Q
        Xro0AOa3zXB43uoPd20W0Y477EJFex9MLuooi5XD4l6HZh5jKuXPydugZugaq81/kFkWdzi
        3NKHk+AalEIw0dPBy4h4W6KiwiEYiJPPyFG6rYQmY/1kCx+saPO3DCVGv3MJVWfYJsPD6KV
        IuJTjUO3zKXqGBxMOdDSSIuwIhoddepxd1W7qukyLJhlVo6ysR4binyQztDX5Ilg0LLohMa
        XYhps7gmzdcUzBnqBo8YRSzHFNKM1F6c/RShkpHyQHJCnFVnbO0EY/nmeOLelwc4WTsFgqO
        KwzB6ccg8NLuclWZ81+ujKcAIST6H1z9RVvh+O8xaKEeySAb/fX7v939M8dFY1sJi6Xp/fp
        /tU5uvp4U9o=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12299959330165944862
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 15/15] selftests/nolibc: add mmap_munmap_good test case
Date:   Fri,  7 Jul 2023 23:08:20 +0800
Message-Id: <838f401801aea4476f54d7f5117dc90d8839a515.1688739493.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688739492.git.falcon@tinylab.org>
References: <cover.1688739492.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

mmap() a file with a good offset and then munmap() it. a non-zero offset
is passed to test the 6th argument of my_syscall6().

Note, it is not easy to find a unique file for mmap() in different
scenes, so, a file list is used to search the right one:

- /dev/zero: is commonly used to allocate anonymous memory and is likely
  present and readable

- /proc/1/exe: for 'run' and 'run-user' target, 'run-user' can not find
  '/proc/self/exe'

- /proc/self/exe: for 'libc-test' target, normal program 'libc-test' has
  no permission to access '/proc/1/exe'

- argv0: the path of the program itself, let it pass even with worst
  case scene: no procfs and no /dev/zero

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702193306.GK16233@1wt.eu/
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/bff82ea6-610b-4471-a28b-6c76c28604a6@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 60 ++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8644e415cb66..a7191b637b85 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -595,6 +595,65 @@ static int test_stat_timestamps(void)
 	return 0;
 }
 
+int test_mmap_munmap(void)
+{
+	int ret, fd, i;
+	void *mem;
+	size_t page_size, file_size, length;
+	off_t offset, pa_offset;
+	struct stat stat_buf;
+	const char * const files[] = {
+		"/dev/zero",
+		"/proc/1/exe", "/proc/self/exe",
+		argv0,
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
+	/* file size of the special /dev/zero is 0, let's assign one manually */
+	if (i == 0)
+		file_size = 3*page_size;
+	else
+		file_size = stat_buf.st_size;
+
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
@@ -671,6 +730,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
 		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)1, 0), -1, EINVAL); break;
+		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
-- 
2.25.1

