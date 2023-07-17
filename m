Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513D975606D
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 12:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGQKcR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 06:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjGQKcP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 06:32:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 65D26A6;
        Mon, 17 Jul 2023 03:32:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7416A2F4;
        Mon, 17 Jul 2023 03:32:57 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B42D3F67D;
        Mon, 17 Jul 2023 03:32:12 -0700 (PDT)
From:   Ryan Roberts <ryan.roberts@arm.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Shuah Khan" <shuah@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        "David Hildenbrand" <david@redhat.com>,
        "Mark Brown" <broonie@kernel.org>,
        "John Hubbard" <jhubbard@nvidia.com>,
        "Florent Revest" <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/8] selftests/mm: Fix thuge-gen test bugs
Date:   Mon, 17 Jul 2023 11:31:48 +0100
Message-Id: <20230717103152.202078-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230717103152.202078-1-ryan.roberts@arm.com>
References: <20230717103152.202078-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

thuge-gen was previously only munmapping part of the mmapped buffer,
which caused us to run out of 1G huge pages for a later part of the
test. Fix this by munmapping the whole buffer. Based on the code, it
looks like a typo rather than an intention to keep some of the buffer
mapped.

thuge-gen was also calling mmap with SHM_HUGETLB flag (bit 11 set),
which is actually MAP_DENYWRITE in mmap context. The man page says this
flag is ignored in modern kernels. I'm pretty sure from the context that
the author intended to pass the MAP_HUGETLB flag so I've fixed that up
too.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 tools/testing/selftests/mm/thuge-gen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/thuge-gen.c b/tools/testing/selftests/mm/thuge-gen.c
index 380ab5f0a534..16ed4dfa7359 100644
--- a/tools/testing/selftests/mm/thuge-gen.c
+++ b/tools/testing/selftests/mm/thuge-gen.c
@@ -139,7 +139,7 @@ void test_mmap(unsigned long size, unsigned flags)
 		before, after, before - after, size);
 	assert(size == getpagesize() || (before - after) == NUM_PAGES);
 	show(size);
-	err = munmap(map, size);
+	err = munmap(map, size * NUM_PAGES);
 	assert(!err);
 }
 
@@ -222,7 +222,7 @@ int main(void)
 		test_mmap(ps, MAP_HUGETLB | arg);
 	}
 	printf("Testing default huge mmap\n");
-	test_mmap(default_hps, SHM_HUGETLB);
+	test_mmap(default_hps, MAP_HUGETLB);
 
 	puts("Testing non-huge shmget");
 	test_shmget(getpagesize(), 0);
-- 
2.25.1

