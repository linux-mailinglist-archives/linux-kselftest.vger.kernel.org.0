Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52252790CAF
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbjICPNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243483AbjICPNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:45 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59A7AF
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-792965813e7so30064439f.2
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754021; x=1694358821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BMtnhYdeu/zB56jX4tl+3iW5OG7Lep/G1Bzlyk4Cto=;
        b=t/vtfEzYtLVv1yf2Lo7ALU4J2usC6H/HyqzAIFvreHvc91Lg1/S4u1MpnMjtdvH+Sf
         BPZtO3oPSPNGkTCRM6aRRFT+T9aSKnESqRIyUBsJ54BcD8tWU8IKBVANgYP1jugU2RK6
         XCpkyOR9c0LDmFaG7jgf5VzEkMvoBbH6mSORI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754021; x=1694358821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+BMtnhYdeu/zB56jX4tl+3iW5OG7Lep/G1Bzlyk4Cto=;
        b=dD51I7WvmmocpNBAHwq4SA8fuW77wc4XQyws7VtSGZpY6jip4UD/KHh/lLqoV5rSNf
         ZqdYvdbdDnmynZmyXGVjkMFkzMzhsj3O3pwNFz/q/5NAKUcwyHq/W4u/QoviSMLjeqMm
         x/McZRHlc+DCweNGjoasPJjkoTCp1HalAfrMqYqr3CkjpWldlmUJ0WaSIs576YfeGQTu
         A/g3Qi5qn4U7dxdFGKSOr1mOT7xEitY3maQ490eezGzpB5Gm5kHPTtii7RrgVILJZvAI
         TCQDeIXl2GNmxvwvDhhK1pX1Z0ofDtBJZL0hwbAzdK7zc67UA7podPZ26j9Nb64tlO8f
         k49A==
X-Gm-Message-State: AOJu0YwAEzBZ22l1aD1UBTTyCI62wcHFVqy0gq91gcNV6QkY1e1HZdET
        3sz1bE5qF/HcURZJT0PVlWGnyQ==
X-Google-Smtp-Source: AGHT+IGoiNLSWXDDcRwa+CUKmoRj1KyKVnC5w9SpA0dWyRbwniu1q3CeYE3pp5OaUl5HGdBBsO8atw==
X-Received: by 2002:a6b:f104:0:b0:795:1a7c:486f with SMTP id e4-20020a6bf104000000b007951a7c486fmr8841640iog.14.1693754021116;
        Sun, 03 Sep 2023 08:13:41 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:40 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v6 5/7] selftests: mm: Add a test for remapping to area immediately after existing mapping
Date:   Sun,  3 Sep 2023 15:13:26 +0000
Message-ID: <20230903151328.2981432-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds support for verifying that we correctly handle the
situation where something is already mapped before the destination of the remap.

Any realignment of destination address and PMD-copy will destroy that
existing mapping. In such cases, we need to avoid doing the optimization.

To test this, we map an area called the preamble before the remap
region. Then we verify after the mremap operation that this region did not get
corrupted.

Putting some prints in the kernel, I verified that we optimize
correctly in different situations:

Optimize when there is alignment and no previous mapping (this is tested
by previous patch).
<prints>
can_align_down(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
can_align_down(new_vma->vm_start=2f00000, new_addr=2f00000, mask=-2097152): 0
=== Starting move_page_tables ===
Doing PUD move for 2800000 -> 2e00000 of extent=200000 <-- Optimization
Doing PUD move for 2a00000 -> 3000000 of extent=200000
Doing PUD move for 2c00000 -> 3200000 of extent=200000
</prints>

Don't optimize when there is alignment but there is previous mapping
(this is tested by this patch).
Notice that can_align_down() returns 1 for the destination mapping
as we detected there is something there.
<prints>
can_align_down(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
can_align_down(new_vma->vm_start=5700000, new_addr=5700000, mask=-2097152): 1
=== Starting move_page_tables ===
Doing move_ptes for 2900000 -> 5700000 of extent=100000 <-- Unoptimized
Doing PUD move for 2a00000 -> 5800000 of extent=200000
Doing PUD move for 2c00000 -> 5a00000 of extent=200000
</prints>

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 57 +++++++++++++++++++++---
 1 file changed, 52 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 6304eb0947a3..d7366074e2a8 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -29,6 +29,7 @@ struct config {
 	unsigned long long dest_alignment;
 	unsigned long long region_size;
 	int overlapping;
+	int dest_preamble_size;
 };
 
 struct test {
@@ -283,7 +284,7 @@ static void *get_source_mapping(struct config c)
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char pattern_seed)
 {
-	void *addr, *src_addr, *dest_addr;
+	void *addr, *src_addr, *dest_addr, *dest_preamble_addr;
 	unsigned long long i;
 	struct timespec t_start = {0, 0}, t_end = {0, 0};
 	long long  start_ns, end_ns, align_mask, ret, offset;
@@ -300,7 +301,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		goto out;
 	}
 
-	/* Set byte pattern */
+	/* Set byte pattern for source block. */
 	srand(pattern_seed);
 	for (i = 0; i < threshold; i++)
 		memset((char *) src_addr + i, (char) rand(), 1);
@@ -312,6 +313,9 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	addr = (void *) (((unsigned long long) src_addr + c.region_size
 			  + offset) & align_mask);
 
+	/* Remap after the destination block preamble. */
+	addr += c.dest_preamble_size;
+
 	/* See comment in get_source_mapping() */
 	if (!((unsigned long long) addr & c.dest_alignment))
 		addr = (void *) ((unsigned long long) addr | c.dest_alignment);
@@ -327,6 +331,24 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		addr += c.dest_alignment;
 	}
 
+	if (c.dest_preamble_size) {
+		dest_preamble_addr = mmap((void *) addr - c.dest_preamble_size, c.dest_preamble_size,
+					  PROT_READ | PROT_WRITE,
+					  MAP_FIXED_NOREPLACE | MAP_ANONYMOUS | MAP_SHARED,
+							-1, 0);
+		if (dest_preamble_addr == MAP_FAILED) {
+			ksft_print_msg("Failed to map dest preamble region: %s\n",
+					strerror(errno));
+			ret = -1;
+			goto clean_up_src;
+		}
+
+		/* Set byte pattern for the dest preamble block. */
+		srand(pattern_seed);
+		for (i = 0; i < c.dest_preamble_size; i++)
+			memset((char *) dest_preamble_addr + i, (char) rand(), 1);
+	}
+
 	clock_gettime(CLOCK_MONOTONIC, &t_start);
 	dest_addr = mremap(src_addr, c.region_size, c.region_size,
 					  MREMAP_MAYMOVE|MREMAP_FIXED, (char *) addr);
@@ -335,7 +357,7 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 	if (dest_addr == MAP_FAILED) {
 		ksft_print_msg("mremap failed: %s\n", strerror(errno));
 		ret = -1;
-		goto clean_up_src;
+		goto clean_up_dest_preamble;
 	}
 
 	/* Verify byte pattern after remapping */
@@ -353,6 +375,23 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
 		}
 	}
 
+	/* Verify the dest preamble byte pattern after remapping */
+	if (c.dest_preamble_size) {
+		srand(pattern_seed);
+		for (i = 0; i < c.dest_preamble_size; i++) {
+			char c = (char) rand();
+
+			if (((char *) dest_preamble_addr)[i] != c) {
+				ksft_print_msg("Preamble data after remap doesn't match at offset %d\n",
+					       i);
+				ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
+					       ((char *) dest_preamble_addr)[i] & 0xff);
+				ret = -1;
+				goto clean_up_dest;
+			}
+		}
+	}
+
 	start_ns = t_start.tv_sec * NS_PER_SEC + t_start.tv_nsec;
 	end_ns = t_end.tv_sec * NS_PER_SEC + t_end.tv_nsec;
 	ret = end_ns - start_ns;
@@ -365,6 +404,9 @@ static long long remap_region(struct config c, unsigned int threshold_mb,
  */
 clean_up_dest:
 	munmap(dest_addr, c.region_size);
+clean_up_dest_preamble:
+	if (c.dest_preamble_size && dest_preamble_addr)
+		munmap(dest_preamble_addr, c.dest_preamble_size);
 clean_up_src:
 	munmap(src_addr, c.region_size);
 out:
@@ -440,7 +482,7 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
 	return 0;
 }
 
-#define MAX_TEST 14
+#define MAX_TEST 15
 #define MAX_PERF_TEST 3
 int main(int argc, char **argv)
 {
@@ -449,7 +491,7 @@ int main(int argc, char **argv)
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
 	unsigned int pattern_seed;
 	int num_expand_tests = 2;
-	struct test test_cases[MAX_TEST];
+	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
 	time_t t;
@@ -510,6 +552,11 @@ int main(int argc, char **argv)
 	test_cases[13] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
 				  "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
 
+	/* Src and Dest addr 1MB aligned. 5MB mremap. */
+	test_cases[14] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+				  "5MB mremap - Source 1MB-aligned, Dest 1MB-aligned with 40MB Preamble");
+	test_cases[14].config.dest_preamble_size = 10 * _4MB;
+
 	perf_test_cases[0] =  MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
 					"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
 	/*
-- 
2.42.0.283.g2d96d420d3-goog

