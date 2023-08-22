Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EFE7837AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHVBzs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjHVBzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:46 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5553189
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:25 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-34cacab5e33so5168275ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669325; x=1693274125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axho/C2d3GxLBo+LZnFUqjVo2BRyImetugTXkfwiHhM=;
        b=dcsD/55UXOmDc6JKsWv76PEhXAR+DHegc6mDX9k2Jt5pnmj+7kdpAShITM6SWA8XVM
         +P0Xr5RhvhwbMxDE/FrWsVMmWu1bcOxe96a9Sj6svTHwHS6oAJLaYFyQ1ynl3xKLRc8F
         pQ+Bm6+1vG8lQOIPDNwuUzZJIUNfw4RUA4nHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669325; x=1693274125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axho/C2d3GxLBo+LZnFUqjVo2BRyImetugTXkfwiHhM=;
        b=B9g3DkALZYAfXkMtFV1nWwfPSSpmWe9/Rv96g8PGPDk7ownI7igrG40CsyaUBxHRQg
         Ow/mOjJ9XauO7ut9qJCvTXkuuQ/jKFV4hS1xKThpCTv7U2lyKL8eLmA1ygIebyvBm4BY
         YNM1wVuADoHKfhi6C+a2E79v3yxML7zcRej9MWAwDWEHxkTaU+YsUB9j+BFXRMEwxRud
         /TTe38Omqt53xHdCaFV+dEKjYqdt2QPEztbSX42HpDuTiS0/I1lMfmRu02E7P8kO2rDc
         fWzzr2irJsJINiqQVBSIk+/ffhf0+6L37h6dgyDB1riBbts5LjS7xsO1H0U/Rq8jXiyR
         KWUQ==
X-Gm-Message-State: AOJu0YxB3jjl6e99WdOeoR8sPK0+/8JQyl8rBVrjpt7pd2IqMHw55tF0
        ECEdQQYE+dtkQVhuknOAMpHvFw==
X-Google-Smtp-Source: AGHT+IGZXIerY8NUWYReuIPpDpvFlLHcIDml9i8pszriAMC0UzQ9sup1GqyFJEY4NY5BpU4X49RLVw==
X-Received: by 2002:a05:6e02:dce:b0:349:a4f8:8815 with SMTP id l14-20020a056e020dce00b00349a4f88815mr9945123ilj.2.1692669325296;
        Mon, 21 Aug 2023 18:55:25 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:24 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
Subject: [PATCH v5 5/7] selftests: mm: Add a test for remapping to area immediately after existing mapping
Date:   Tue, 22 Aug 2023 01:54:58 +0000
Message-ID: <20230822015501.791637-6-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230822015501.791637-1-joel@joelfernandes.org>
References: <20230822015501.791637-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
2.42.0.rc1.204.g551eb34607-goog

