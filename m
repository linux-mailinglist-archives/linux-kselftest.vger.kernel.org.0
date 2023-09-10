Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEE5799F7C
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Sep 2023 21:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjIJT3k (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 10 Sep 2023 15:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjIJT3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 10 Sep 2023 15:29:37 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0A3188;
        Sun, 10 Sep 2023 12:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694374163;
        bh=iXISKFMxSwqsbdiN0L+f35DyWarIGiJQLnukw86Cd9E=;
        h=From:Date:Subject:To:Cc:From;
        b=mP26J0GdNnotkg3mALjkDU0d39CK1f9tY9aHj4s29fAAI5MTUbJPZEOu4CmNLdIbj
         aSb59dErQldEOCtmNFJCj4KXMXCtgyUm33S+dwtsX84QF0YIlWM2FwLqfbxuqjrrGS
         zsHeyCAJDepqbB+1A4JnAle0SEFB0vlIDVCYa3Ig=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 10 Sep 2023 21:29:01 +0200
Subject: [PATCH] selftests/nolibc: libc-test: avoid -Wstringop-overflow
 warnings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230910-nolibc-poll-fault-v1-1-2b7a16f48259@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPwY/mQC/x3MTQ5AMBBA4avIrE3SHwRXEYtiyiRNKy0iEXfXW
 H6L9x5IFJkS9MUDkS5OHHyGLAuYN+NXQl6yQQmlRScF+uB4mnEPzqE1pzuwkrUyTasbsi3kbo9
 k+f6fw/i+H1r5xIRjAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694374162; l=4663;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=iXISKFMxSwqsbdiN0L+f35DyWarIGiJQLnukw86Cd9E=;
 b=2Iv84yGEzPB3mR/55/KWES0iOYVZ3GzoiKHeBxC3wYsv2No1p5GPnI7dVzIm8/t4CgNVyp5xD
 aZ5RJezVFhmCXxOsWQSKhrwJmajxvT4FMs8pMuXhI8G78HSf7D4gAi6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Newer versions of glibc annotate the poll() function with
__attribute__(access) which triggers a compiler warning inside the
testcase poll_fault.
Avoid this by using a plain NULL which is enough for the testcase.
To avoid potential future warnings also adapt the other EFAULT
testcases, except select_fault as NULL is a valid value for its
argument.

nolibc-test.c: In function ‘run_syscall’:
nolibc-test.c:338:62: warning: ‘poll’ writing 8 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
  338 |         do { if (!(cond)) result(llen, SKIPPED); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
      |                                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nolibc-test.c:341:9: note: in expansion of macro ‘EXPECT_SYSER2’
  341 |         EXPECT_SYSER2(cond, expr, expret, experr, 0)
      |         ^~~~~~~~~~~~~
nolibc-test.c:905:47: note: in expansion of macro ‘EXPECT_SYSER’
  905 |                 CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
      |                                               ^~~~~~~~~~~~
cc1: note: destination object is likely at address zero
In file included from /usr/include/poll.h:1,
                 from nolibc-test.c:33:
/usr/include/sys/poll.h:54:12: note: in a call to function ‘poll’ declared with attribute ‘access (write_only, 1, 2)’
   54 | extern int poll (struct pollfd *__fds, nfds_t __nfds, int __timeout)
      |            ^~~~

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e2b70641a1e7..a0478f8eaee8 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -895,14 +895,14 @@ int run_syscall(int min, int max)
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
 		CASE_TEST(mmap_bad);          EXPECT_PTRER(1, mmap(NULL, 0, PROT_READ, MAP_PRIVATE, 0, 0), MAP_FAILED, EINVAL); break;
-		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap((void *)1, 0), -1, EINVAL); break;
+		CASE_TEST(munmap_bad);        EXPECT_SYSER(1, munmap(NULL, 0), -1, EINVAL); break;
 		CASE_TEST(mmap_munmap_good);  EXPECT_SYSZR(1, test_mmap_munmap()); break;
 		CASE_TEST(open_tty);          EXPECT_SYSNE(1, tmp = open("/dev/null", 0), -1); if (tmp != -1) close(tmp); break;
 		CASE_TEST(open_blah);         EXPECT_SYSER(1, tmp = open("/proc/self/blah", 0), -1, ENOENT); if (tmp != -1) close(tmp); break;
 		CASE_TEST(pipe);              EXPECT_SYSZR(1, test_pipe()); break;
 		CASE_TEST(poll_null);         EXPECT_SYSZR(1, poll(NULL, 0, 0)); break;
 		CASE_TEST(poll_stdout);       EXPECT_SYSNE(1, ({ struct pollfd fds = { 1, POLLOUT, 0}; poll(&fds, 1, 0); }), -1); break;
-		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll((void *)1, 1, 0), -1, EFAULT); break;
+		CASE_TEST(poll_fault);        EXPECT_SYSER(1, poll(NULL, 1, 0), -1, EFAULT); break;
 		CASE_TEST(prctl);             EXPECT_SYSER(1, prctl(PR_SET_NAME, (unsigned long)NULL, 0, 0, 0), -1, EFAULT); break;
 		CASE_TEST(read_badf);         EXPECT_SYSER(1, read(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(rmdir_blah);        EXPECT_SYSER(1, rmdir("/blah"), -1, ENOENT); break;
@@ -911,7 +911,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(select_stdout);     EXPECT_SYSNE(1, ({ fd_set fds; FD_ZERO(&fds); FD_SET(1, &fds); select(2, NULL, &fds, NULL, NULL); }), -1); break;
 		CASE_TEST(select_fault);      EXPECT_SYSER(1, select(1, (void *)1, NULL, NULL, 0), -1, EFAULT); break;
 		CASE_TEST(stat_blah);         EXPECT_SYSER(1, stat("/proc/self/blah", &stat_buf), -1, ENOENT); break;
-		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat((void *)1, &stat_buf), -1, EFAULT); break;
+		CASE_TEST(stat_fault);        EXPECT_SYSER(1, stat(NULL, &stat_buf), -1, EFAULT); break;
 		CASE_TEST(stat_timestamps);   EXPECT_SYSZR(1, test_stat_timestamps()); break;
 		CASE_TEST(symlink_root);      EXPECT_SYSER(1, symlink("/", "/"), -1, EEXIST); break;
 		CASE_TEST(unlink_root);       EXPECT_SYSER(1, unlink("/"), -1, EISDIR); break;

---
base-commit: f7a6e4791e3d685eddca29b5d16d183ee0407caa
change-id: 20230910-nolibc-poll-fault-4152a6836ef8

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

