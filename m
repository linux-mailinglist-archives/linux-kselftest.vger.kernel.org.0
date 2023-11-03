Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B287E0808
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 19:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbjKCSYS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 14:24:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjKCSYR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 14:24:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A18DB;
        Fri,  3 Nov 2023 11:24:11 -0700 (PDT)
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 09D8866073F9;
        Fri,  3 Nov 2023 18:24:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699035850;
        bh=WCwIVvIPo9o8DL2cD4gn2WucfUf+vrOIACI0R4C5a9I=;
        h=From:To:Cc:Subject:Date:From;
        b=m1jmSbYFalrqo28EWpqoUapQlUI504MP4D408EXWCQBVC8CQeq5eoFy+WbJr0o7U1
         OGk0tK9iGbEm0RdPc9i9RNly/AqSB9ufH0Vp6PAblFFsg0p7bqZpTSCSk4xsosj7ou
         DO6VxofuNujdPgsCOiGrSxTmczL4zfnQs9RRkamqLeaZC++D6eX9Q6roBrM+UMCgou
         wKBf0YcQoyAfrUoJWwPjnphGHxjc6PybsS9symKd78k1q8yqWqwEjpqd5/NSKEvN0s
         Ie+NwHt9d5s54MkF6pV0UR3zfgeu/b6m4vcLhAqpYLaIOyKFazIUrcw7VHX4E8Mxps
         0DmmzK5ow+DqQ==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     kernel@collabora.com, Ryan Roberts <ryan.roberts@arm.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: mm: skip whole test instead of failure
Date:   Fri,  3 Nov 2023 23:23:41 +0500
Message-ID: <20231103182343.2874015-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some architectures don't support userfaultfd. Skip running the whole
test on them instead of registering the failure.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Closes: https://lore.kernel.org/all/f8463381-2697-49e9-9460-9dc73452830d@arm.com
Fixes: 46fd75d4a3c9 ("selftests: mm: add pagemap ioctl tests")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/pagemap_ioctl.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 0161fb49fc6ef..f8685a2ea07e6 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -94,19 +94,19 @@ int init_uffd(void)
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd == -1)
-		ksft_exit_fail_msg("uffd syscall failed\n");
+		return uffd;
 
 	uffdio_api.api = UFFD_API;
 	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |
 			      UFFD_FEATURE_WP_HUGETLBFS_SHMEM;
 	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
-		ksft_exit_fail_msg("UFFDIO_API\n");
+		return -1;
 
 	if (!(uffdio_api.api & UFFDIO_REGISTER_MODE_WP) ||
 	    !(uffdio_api.features & UFFD_FEATURE_WP_UNPOPULATED) ||
 	    !(uffdio_api.features & UFFD_FEATURE_WP_ASYNC) ||
 	    !(uffdio_api.features & UFFD_FEATURE_WP_HUGETLBFS_SHMEM))
-		ksft_exit_fail_msg("UFFDIO_API error %llu\n", uffdio_api.api);
+		return -1;
 
 	return 0;
 }
@@ -1479,6 +1479,10 @@ int main(void)
 	struct stat sbuf;
 
 	ksft_print_header();
+
+	if (init_uffd())
+		return ksft_exit_pass();
+
 	ksft_set_plan(115);
 
 	page_size = getpagesize();
@@ -1488,9 +1492,6 @@ int main(void)
 	if (pagemap_fd < 0)
 		return -EINVAL;
 
-	if (init_uffd())
-		ksft_exit_fail_msg("uffd init failed\n");
-
 	/* 1. Sanity testing */
 	sanity_tests_sd();
 
-- 
2.42.0

