Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4607077F2
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 04:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjERCSz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 22:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjERCSt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 22:18:49 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFF3268A
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:48 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-7575fc62c7aso156703185a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 17 May 2023 19:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684376327; x=1686968327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGuemAvtIS/ALPtC/Ke2yJXoSr37KqjSOh21F52Z0b4=;
        b=XjEWVFgjHhBSgx+JzMuzHzMuMMrg6ZCjBCCAdXf//YzfKBHsPOaTSvveyrxyVc63mB
         OszLdP5qzb0tPw+Ax1TNz+UB1DuNFET/RCjILS/7u5bCzvBBR1KOj19dWdhgLKcgBzef
         NYJtJv4KZejE9EsPY58w3IzlHS7ZNhsiLoXuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684376327; x=1686968327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGuemAvtIS/ALPtC/Ke2yJXoSr37KqjSOh21F52Z0b4=;
        b=Vo1ePpI/fr9BuU5nORhy1AaA7A7GMPvHVLNeX6HhSpTCgXMj5osl9opaOUNtuta69r
         UpmuYnGLesBxB769OO7L3ORrHhMPE0vGIZ5V/ifDEsfSHivozRHijA/YZI/3ndWQ8Gl+
         2knwkixkNvsbeGV3x3dfBuhKhFfoD3iqna9ud2WZ2JS8kqwo8nege4RE9xJlWEcT8Ft5
         Uyk730r0wNWLyjI7lPmxidlDQcxznCzT+2U+8//w25GiJCtcSZK3KQFxGQNuZwqmPkP6
         WyQT/L6UzDUcBHB/7KZinTtaynFVA8fVhpQ/jDknjoGQlTrau9atZu1c+ZUE52hp6Jpr
         Hogw==
X-Gm-Message-State: AC+VfDwdVMeA+8lw0y35dflNWS70rdLbwVpaYOKLxpZ0wabl8fjUwh67
        tZ015dfG3s9bjNfye9ULOVv43g==
X-Google-Smtp-Source: ACHHUZ4YcOJzn6aoVPNard/VpdQHjhpKxZ/STCMnHfkC5tH5L1a/155XBb4RZDt8EkvRYuJwqaMCWA==
X-Received: by 2002:a05:622a:1d0:b0:3ef:366b:5afa with SMTP id t16-20020a05622a01d000b003ef366b5afamr3403956qtw.54.1684376327485;
        Wed, 17 May 2023 19:18:47 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id j13-20020a05620a000d00b007577ccf566asm85082qki.93.2023.05.17.19.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 19:18:46 -0700 (PDT)
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
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC 4/4] selftests: mm: Add a test for remapping to area immediately after existing mapping
Date:   Thu, 18 May 2023 02:18:25 +0000
Message-ID: <20230518021825.712742-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
In-Reply-To: <20230518021825.712742-1-joel@joelfernandes.org>
References: <20230518021825.712742-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
check_addr_in_prev(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
check_addr_in_prev(new_vma->vm_start=2f00000, new_addr=2f00000, mask=-2097152): 0
=== Starting move_page_tables ===
Doing PUD move for 2800000 -> 2e00000 of extent=200000 <-- Optimization
Doing PUD move for 2a00000 -> 3000000 of extent=200000
Doing PUD move for 2c00000 -> 3200000 of extent=200000
</prints>

Don't optimize when there is alignment but there is previous mapping
(this is tested by this patch).
Notice that check_addr_in_prev() returns 1 for the destination mapping
as we detected there is something there.
<prints>
check_addr_in_prev(old_vma->vm_start=2900000, old_addr=2900000, mask=-2097152): 0
check_addr_in_prev(new_vma->vm_start=5700000, new_addr=5700000, mask=-2097152): 1
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
2.40.1.606.ga4b1b128d6-goog

