Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A975ED7B
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 10:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjGXI0F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjGXIZ7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 04:25:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FADDE6C;
        Mon, 24 Jul 2023 01:25:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97F62DE0;
        Mon, 24 Jul 2023 01:26:29 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B9E3F67D;
        Mon, 24 Jul 2023 01:25:44 -0700 (PDT)
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
Subject: [PATCH v3 7/8] selftests/mm: Optionally pass duration to transhuge-stress
Date:   Mon, 24 Jul 2023 09:25:21 +0100
Message-Id: <20230724082522.1202616-8-ryan.roberts@arm.com>
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

Until now, transhuge-stress runs until its explicitly killed, so when
invoked by run_kselftest.sh, it would run until the test timeout, then
it would be killed and the test would be marked as failed.

Add a new, optional command line parameter that allows the user to
specify the duration in seconds that the program should run. The program
exits after this duration with a success (0) exit code. If the argument
is omitted the old behacvior remains.

On it's own, this doesn't quite solve our problem because
run_kselftest.sh does not allow passing parameters to the program under
test. But we will shortly move this to run_vmtests.sh, which does allow
parameter passing.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/transhuge-stress.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
index ba9d37ad3a89..c61fb9350b8c 100644
--- a/tools/testing/selftests/mm/transhuge-stress.c
+++ b/tools/testing/selftests/mm/transhuge-stress.c
@@ -25,13 +25,14 @@ int main(int argc, char **argv)
 {
 	size_t ram, len;
 	void *ptr, *p;
-	struct timespec a, b;
+	struct timespec start, a, b;
 	int i = 0;
 	char *name = NULL;
 	double s;
 	uint8_t *map;
 	size_t map_len;
 	int pagemap_fd;
+	int duration = 0;
 
 	ram = sysconf(_SC_PHYS_PAGES);
 	if (ram > SIZE_MAX / psize() / 4)
@@ -42,9 +43,11 @@ int main(int argc, char **argv)
 
 	while (++i < argc) {
 		if (!strcmp(argv[i], "-h"))
-			errx(1, "usage: %s [size in MiB]", argv[0]);
+			errx(1, "usage: %s [-f <filename>] [-d <duration>] [size in MiB]", argv[0]);
 		else if (!strcmp(argv[i], "-f"))
 			name = argv[++i];
+		else if (!strcmp(argv[i], "-d"))
+			duration = atoi(argv[++i]);
 		else
 			len = atoll(argv[i]) << 20;
 	}
@@ -78,6 +81,8 @@ int main(int argc, char **argv)
 	if (!map)
 		errx(2, "map malloc");
 
+	clock_gettime(CLOCK_MONOTONIC, &start);
+
 	while (1) {
 		int nr_succeed = 0, nr_failed = 0, nr_pages = 0;
 
@@ -118,5 +123,8 @@ int main(int argc, char **argv)
 		      "%4d succeed, %4d failed, %4d different pages",
 		      s, s * 1000 / (len >> HPAGE_SHIFT), len / s / (1 << 20),
 		      nr_succeed, nr_failed, nr_pages);
+
+		if (duration > 0 && b.tv_sec - start.tv_sec >= duration)
+			return 0;
 	}
 }
-- 
2.25.1

