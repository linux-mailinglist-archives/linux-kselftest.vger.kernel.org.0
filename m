Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4C075ED79
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231503AbjGXI0C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjGXIZ6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E700A1A1;
        Mon, 24 Jul 2023 01:25:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A37E515A1;
        Mon, 24 Jul 2023 01:26:27 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C45423F67D;
        Mon, 24 Jul 2023 01:25:42 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        "Peter Xu" <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/8] selftests/mm: Make migration test robust to failure
Date:   Mon, 24 Jul 2023 09:25:20 +0100
Message-Id: <20230724082522.1202616-7-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230724082522.1202616-1-ryan.roberts@arm.com>
References: <20230724082522.1202616-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The `migration` test currently has a number of robustness problems that
cause it to hang and leak resources.

Timeout: There are 3 tests, which each previously ran for 60 seconds.
However, the timeout in mm/settings for a single test binary was set to
45 seconds. So when run using run_kselftest.sh, the top level timeout
would trigger before the test binary was finished. Solve this by meeting
in the middle; each of the 3 tests now runs for 20 seconds (for a total
of 60), and the top level timeout is set to 90 seconds.

Leaking child processes: the `shared_anon` test fork()s some children
but then an ASSERT() fires before the test kills those children. The
assert causes immediate exit of the parent and leaking of the children.
Furthermore, if run using the run_kselftest.sh wrapper, the wrapper
would get stuck waiting for those children to exit, which never happens.
Solve this by setting the "parent death signal" to SIGHUP in the child,
so that the child is killed automatically if the parent dies.

With these changes, the test binary now runs to completion on arm64,
with 2 tests passing and the `shared_anon` test failing.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/migration.c | 12 +++++++++---
 tools/testing/selftests/mm/settings    |  2 +-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
index 379581567f27..6908569ef406 100644
--- a/tools/testing/selftests/mm/migration.c
+++ b/tools/testing/selftests/mm/migration.c
@@ -10,12 +10,13 @@
 #include <numa.h>
 #include <numaif.h>
 #include <sys/mman.h>
+#include <sys/prctl.h>
 #include <sys/types.h>
 #include <signal.h>
 #include <time.h>
 
 #define TWOMEG (2<<20)
-#define RUNTIME (60)
+#define RUNTIME (20)
 
 #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
 
@@ -155,10 +156,15 @@ TEST_F_TIMEOUT(migration, shared_anon, 2*RUNTIME)
 	memset(ptr, 0xde, TWOMEG);
 	for (i = 0; i < self->nthreads - 1; i++) {
 		pid = fork();
-		if (!pid)
+		if (!pid) {
+			prctl(PR_SET_PDEATHSIG, SIGHUP);
+			/* Parent may have died before prctl so check now. */
+			if (getppid() == 1)
+				kill(getpid(), SIGHUP);
 			access_mem(ptr);
-		else
+		} else {
 			self->pids[i] = pid;
+		}
 	}
 
 	ASSERT_EQ(migrate(ptr, self->n1, self->n2), 0);
diff --git a/tools/testing/selftests/mm/settings b/tools/testing/selftests/mm/settings
index 9abfc60e9e6f..ba4d85f74cd6 100644
--- a/tools/testing/selftests/mm/settings
+++ b/tools/testing/selftests/mm/settings
@@ -1 +1 @@
-timeout=45
+timeout=90
-- 
2.25.1

