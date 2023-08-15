Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B14077CFB7
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbjHOP5G (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238376AbjHOP4f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:56:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCD74A6;
        Tue, 15 Aug 2023 08:56:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA2F21515;
        Tue, 15 Aug 2023 08:57:15 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B6893F6C4;
        Tue, 15 Aug 2023 08:56:32 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests: cachestat: test for cachestat availability
Date:   Tue, 15 Aug 2023 16:56:12 +0100
Message-Id: <20230815155612.2535947-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815155612.2535947-1-andre.przywara@arm.com>
References: <20230815155612.2535947-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As cachestat is a new syscall, it won't be available on older kernels,
for instance those running on a build machine. In this case, a run
reports all tests as "not ok" at the moment.

Test for the cachestat syscall availability first, before doing further
tests, and bail out early with a TAP SKIP comment.

This also uses the opportunity to add the proper TAP headers, and add
one check for the syscall error handling (illegal file descriptor).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../selftests/cachestat/test_cachestat.c      | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index a5a4ac8dcb76c..77620e7ecf562 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -15,6 +15,8 @@
 
 #include "../kselftest.h"
 
+#define NR_TESTS	8
+
 static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
 	"/proc/version", "/proc"
@@ -235,7 +237,25 @@ bool test_cachestat_shmem(void)
 
 int main(void)
 {
-	int ret = 0;
+	int ret;
+
+	ksft_print_header();
+
+	ret = syscall(__NR_cachestat, -1, NULL, NULL, 0);
+	if (ret == -1 && errno == ENOSYS) {
+		printf("1..0 # Skipped: cachestat syscall not available\n");
+		return KSFT_SKIP;
+	}
+
+	ksft_set_plan(NR_TESTS);
+
+	if (ret == -1 && errno == EBADF) {
+		ksft_test_result_pass("bad file descriptor recognized\n");
+		ret = 0;
+	} else {
+		ksft_test_result_fail("bad file descriptor ignored\n");
+		ret = 1;
+	}
 
 	for (int i = 0; i < 5; i++) {
 		const char *dev_filename = dev_files[i];
-- 
2.25.1

