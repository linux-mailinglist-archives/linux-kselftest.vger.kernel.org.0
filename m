Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82075ED6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjGXIZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjGXIZh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:37 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED6771B8;
        Mon, 24 Jul 2023 01:25:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB53EFEC;
        Mon, 24 Jul 2023 01:26:17 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081BE3F67D;
        Mon, 24 Jul 2023 01:25:32 -0700 (PDT)
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
Subject: [PATCH v3 1/8] selftests: Line buffer test program's stdout
Date:   Mon, 24 Jul 2023 09:25:15 +0100
Message-Id: <20230724082522.1202616-2-ryan.roberts@arm.com>
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

The selftests runner pipes the test program's stdout to tap_prefix. The
presence of the pipe means that the test program sets its stdout to be
fully buffered (as aposed to line buffered when directly connected to
the terminal). The block buffering means that there is often content in
the buffer at fork() time, which causes the output to end up duplicated.
This was causing problems for mm:cow where test results were duplicated
20-30x.

Solve this by using `stdbuf`, when available to force the test program
to use line buffered mode. This means previously printf'ed results are
flushed out of the program before any fork().

Additionally, explicitly set line buffer mode in ksft_print_header(),
which means that all test programs that use the ksft framework will
benefit even if stdbuf is not present on the system.

Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/kselftest.h         | 9 +++++++++
 tools/testing/selftests/kselftest/runner.sh | 7 +++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 829be379545a..529d29a35900 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -113,6 +113,15 @@ static inline int ksft_get_error_cnt(void) { return ksft_cnt.ksft_error; }
 
 static inline void ksft_print_header(void)
 {
+	/*
+	 * Force line buffering; If stdout is not connected to a terminal, it
+	 * will otherwise default to fully buffered, which can cause output
+	 * duplication if there is content in the buffer when fork()ing. If
+	 * there is a crash, line buffering also means the most recent output
+	 * line will be visible.
+	 */
+	setvbuf(stdout, NULL, _IOLBF, 0);
+
 	if (!(getenv("KSFT_TAP_LEVEL")))
 		printf("TAP version 13\n");
 }
diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 1c952d1401d4..261c73cab41b 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -105,15 +105,18 @@ run_one()
 		echo "# Warning: file $TEST is missing!"
 		echo "not ok $test_num $TEST_HDR_MSG"
 	else
+		if [ -x /usr/bin/stdbuf ]; then
+			stdbuf="/usr/bin/stdbuf --output=L "
+		fi
 		eval kselftest_cmd_args="\$${kselftest_cmd_args_ref:-}"
-		cmd="./$BASENAME_TEST $kselftest_cmd_args"
+		cmd="$stdbuf ./$BASENAME_TEST $kselftest_cmd_args"
 		if [ ! -x "$TEST" ]; then
 			echo "# Warning: file $TEST is not executable"
 
 			if [ $(head -n 1 "$TEST" | cut -c -2) = "#!" ]
 			then
 				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
-				cmd="$interpreter ./$BASENAME_TEST"
+				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
 			else
 				echo "not ok $test_num $TEST_HDR_MSG"
 				return
-- 
2.25.1

