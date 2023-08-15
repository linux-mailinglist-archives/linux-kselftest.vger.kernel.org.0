Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2A77CFB6
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 17:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238355AbjHOP5F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 11:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238375AbjHOP4d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 11:56:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B95319B3;
        Tue, 15 Aug 2023 08:56:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92054143D;
        Tue, 15 Aug 2023 08:57:14 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 431D13F6C4;
        Tue, 15 Aug 2023 08:56:31 -0700 (PDT)
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftests: cachestat: use proper syscall number macro
Date:   Tue, 15 Aug 2023 16:56:11 +0100
Message-Id: <20230815155612.2535947-3-andre.przywara@arm.com>
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

At the moment the cachestat syscall number is hard coded into the test
source code.
Remove that and replace it with the proper __NR_cachestat macro.
That ensures compatibility should other architectures pick a different
number.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 54d09b820ed4b..a5a4ac8dcb76c 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -19,7 +19,6 @@ static const char * const dev_files[] = {
 	"/dev/zero", "/dev/null", "/dev/urandom",
 	"/proc/version", "/proc"
 };
-static const int cachestat_nr = 451;
 
 void print_cachestat(struct cachestat *cs)
 {
@@ -126,7 +125,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 		}
 	}
 
-	syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
+	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
 	ksft_print_msg("Cachestat call returned %ld\n", syscall_ret);
 
@@ -152,7 +151,7 @@ bool test_cachestat(const char *filename, bool write_random, bool create,
 			ksft_print_msg("fsync fails.\n");
 			ret = false;
 		} else {
-			syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
+			syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
 			ksft_print_msg("Cachestat call (after fsync) returned %ld\n",
 				syscall_ret);
@@ -213,7 +212,7 @@ bool test_cachestat_shmem(void)
 		goto close_fd;
 	}
 
-	syscall_ret = syscall(cachestat_nr, fd, &cs_range, &cs, 0);
+	syscall_ret = syscall(__NR_cachestat, fd, &cs_range, &cs, 0);
 
 	if (syscall_ret) {
 		ksft_print_msg("Cachestat returned non-zero.\n");
-- 
2.25.1

