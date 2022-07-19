Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF1D57A92D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 23:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbiGSVpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 17:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240133AbiGSVpU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 17:45:20 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAA65B7E2;
        Tue, 19 Jul 2022 14:45:16 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 26JLj5qH002591;
        Tue, 19 Jul 2022 23:45:05 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     Pranith Kumar <bobby.prani@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Mark Brown <broonie@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 10/17] selftests/nolibc: recreate and populate /dev and /proc if missing
Date:   Tue, 19 Jul 2022 23:44:42 +0200
Message-Id: <20220719214449.2520-12-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20220719214449.2520-1-w@1wt.eu>
References: <20220719214449.2520-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of the time the program will be run alone in an initramfs. There
is no value in requiring the user to populate /dev and /proc for such
tests, we can do it ourselves, and it participates to the tests at the
same time.

What's done here is that when called as init (getpid()==1) we check
if /dev exists or create it, if /dev/console and /dev/null exists,
otherwise we try to mount a devtmpfs there, and if it fails we fall
back to mknod. The console is reopened if stdout was closed. Finally
/proc is created and mounted if /proc/self cannot be found. This is
sufficient for most tests.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 56 ++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 45793b6f2244..0bbfe0b3b648 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -530,6 +530,54 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+/* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
+int prepare(void)
+{
+	struct stat stat_buf;
+
+	/* It's possible that /dev doesn't even exist or was not mounted, so
+	 * we'll try to create it, mount it, or create minimal entries into it.
+	 * We want at least /dev/null and /dev/console.
+	 */
+	if (stat("/dev/.", &stat_buf) == 0 || mkdir("/dev", 0755) == 0) {
+		if (stat("/dev/console", &stat_buf) != 0 ||
+		    stat("/dev/null", &stat_buf) != 0) {
+			/* try devtmpfs first, otherwise fall back to manual creation */
+			if (mount("/dev", "/dev", "devtmpfs", 0, 0) != 0) {
+				mknod("/dev/console", 0600 | S_IFCHR, makedev(5, 1));
+				mknod("/dev/null",    0666 | S_IFCHR, makedev(1, 3));
+			}
+		}
+	}
+
+	/* If no /dev/console was found before calling init, stdio is closed so
+	 * we need to reopen it from /dev/console. If it failed above, it will
+	 * still fail here and we cannot emit a message anyway.
+	 */
+	if (close(dup(1)) == -1) {
+		int fd = open("/dev/console", O_RDWR);
+
+		if (fd >= 0) {
+			if (fd != 0)
+				dup2(fd, 0);
+			if (fd != 1)
+				dup2(fd, 1);
+			if (fd != 2)
+				dup2(fd, 2);
+			if (fd > 2)
+				close(fd);
+			puts("\nSuccessfully reopened /dev/console.");
+		}
+	}
+
+	/* try to mount /proc if not mounted. Silently fail otherwise */
+	if (stat("/proc/.", &stat_buf) == 0 || mkdir("/proc", 0755) == 0) {
+		if (stat("/proc/self", &stat_buf) != 0)
+			mount("/proc", "/proc", "proc", 0, 0);
+	}
+
+	return 0;
+}
 
 /* This is the definition of known test names, with their functions */
 static struct test test_names[] = {
@@ -550,6 +598,14 @@ int main(int argc, char **argv, char **envp)
 
 	environ = envp;
 
+	/* when called as init, it's possible that no console was opened, for
+	 * example if no /dev file system was provided. We'll check that fd#1
+	 * was opened, and if not we'll attempt to create and open /dev/console
+	 * and /dev/null that we'll use for later tests.
+	 */
+	if (getpid() == 1)
+		prepare();
+
 	/* the definition of a series of tests comes from either argv[1] or the
 	 * "NOLIBC_TEST" environment variable. It's made of a comma-delimited
 	 * series of test names and optional ranges:
-- 
2.17.5

