Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C6549C782
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 11:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239927AbiAZK1u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 05:27:50 -0500
Received: from foss.arm.com ([217.140.110.172]:57912 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239917AbiAZK1n (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 05:27:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D2F811B3;
        Wed, 26 Jan 2022 02:27:43 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F7A83F766;
        Wed, 26 Jan 2022 02:27:42 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, Cristian Marussi <cristian.marussi@arm.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 5/5] selftests: openat2: Skip testcases that fail with EOPNOTSUPP
Date:   Wed, 26 Jan 2022 10:27:23 +0000
Message-Id: <20220126102723.23300-6-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126102723.23300-1-cristian.marussi@arm.com>
References: <20220126102723.23300-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Skip testcases that fail since the requested valid flags combination is not
supported by the underlying filesystem.

Cc: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 tools/testing/selftests/openat2/openat2_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 1bddbe934204..7fb902099de4 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -259,6 +259,16 @@ void test_openat2_flags(void)
 		unlink(path);
 
 		fd = sys_openat2(AT_FDCWD, path, &test->how);
+		if (fd < 0 && fd == -EOPNOTSUPP) {
+			/*
+			 * Skip the testcase if it failed because not supported
+			 * by FS. (e.g. a valid O_TMPFILE combination on NFS)
+			 */
+			ksft_test_result_skip("openat2 with %s fails with %d (%s)\n",
+					      test->name, fd, strerror(-fd));
+			goto next;
+		}
+
 		if (test->err >= 0)
 			failed = (fd < 0);
 		else
@@ -303,7 +313,7 @@ void test_openat2_flags(void)
 		else
 			resultfn("openat2 with %s fails with %d (%s)\n",
 				 test->name, test->err, strerror(-test->err));
-
+next:
 		free(fdpath);
 		fflush(stdout);
 	}
-- 
2.17.1

