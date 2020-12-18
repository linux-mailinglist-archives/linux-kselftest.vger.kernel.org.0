Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38D72DE1EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Dec 2020 12:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731586AbgLRLZN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Dec 2020 06:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgLRLZN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Dec 2020 06:25:13 -0500
X-Greylist: delayed 67969 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Dec 2020 03:24:32 PST
Received: from sym2.noone.org (sym2.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA4EC0617A7
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Dec 2020 03:24:32 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Cy62j01ydzvjl6; Fri, 18 Dec 2020 12:24:28 +0100 (CET)
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kselftest@vger.kernel.org,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [PATCH] selftests/core: fix close_range_test build after XFAIL removal
Date:   Fri, 18 Dec 2020 12:24:28 +0100
Message-Id: <20201218112428.13662-1-tklauser@distanz.ch>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

XFAIL was removed in commit 9847d24af95c ("selftests/harness: Refactor
XFAIL into SKIP") and its use in close_range_test was already replaced
by commit 1d44d0dd61b6 ("selftests: core: use SKIP instead of XFAIL in
close_range_test.c"). However, commit 23afeaeff3d9 ("selftests: core:
add tests for CLOSE_RANGE_CLOEXEC") introduced usage of XFAIL in
TEST(close_range_cloexec). Use SKIP there as well.

Cc: Giuseppe Scrivano <gscrivan@redhat.com>
Fixes: 23afeaeff3d9 ("selftests: core: add tests for CLOSE_RANGE_CLOEXEC")
Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
---
 tools/testing/selftests/core/close_range_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 87e16d65d9d7..670fb30d62f6 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -241,7 +241,7 @@ TEST(close_range_cloexec)
 		fd = open("/dev/null", O_RDONLY);
 		ASSERT_GE(fd, 0) {
 			if (errno == ENOENT)
-				XFAIL(return, "Skipping test since /dev/null does not exist");
+				SKIP(return, "Skipping test since /dev/null does not exist");
 		}
 
 		open_fds[i] = fd;
@@ -250,9 +250,9 @@ TEST(close_range_cloexec)
 	ret = sys_close_range(1000, 1000, CLOSE_RANGE_CLOEXEC);
 	if (ret < 0) {
 		if (errno == ENOSYS)
-			XFAIL(return, "close_range() syscall not supported");
+			SKIP(return, "close_range() syscall not supported");
 		if (errno == EINVAL)
-			XFAIL(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
+			SKIP(return, "close_range() doesn't support CLOSE_RANGE_CLOEXEC");
 	}
 
 	/* Ensure the FD_CLOEXEC bit is set also with a resource limit in place.  */
-- 
2.29.0

