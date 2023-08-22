Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418337837AB
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Aug 2023 03:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjHVBzt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjHVBzq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 21:55:46 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2649A194
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:27 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-34ca63f6a27so6271005ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Aug 2023 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692669326; x=1693274126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD9aGvqokkyzhhNkz6Ym1Row+eZXw3mkXyW6dIKtxjg=;
        b=BVxKaBwCWqmv9ynuQE7s7YtVK38FkX779KlBkPDkQBjoFlq8GAIqxdpbPgdXIHuYEP
         sTZl8JURdoNTsMC+vviGXqt9EnyyK4mtdmmYuLB06JdlbsUAxre1uPUPQ9095aYWBBzQ
         UX41cyoBUmNRAXgSpAygarUMAnDMlAVDQL8Lk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692669326; x=1693274126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD9aGvqokkyzhhNkz6Ym1Row+eZXw3mkXyW6dIKtxjg=;
        b=VtI9bLyqikS0s6RqZKJh2I2jVAHA2iBcqGOZpomt/ECMXCTv35oxXm0or48f8zzSHc
         HU5GXHHHym2xsNmeIkPuS1leCnAXtgb1oylBVT5qBQn1eaLLduc8cs+T2bAbPr+y+BYX
         Yloi5LX2cACE7JIGBvQCVcajXLchS2M7CYmXUMNPXwzDNJ4KDOBRg8Ss7hpQl5Zr2BP3
         FSERA/5ckQ4zBVWoQOl2xgIOPX//LJyZ/6dsLmbN7kA3usyEcEP1eP2BemNRv9+MMOEm
         9RYi/STtPOaPt+9u0f+GwNcyg17t6Yz5w+rPThsnqInqspwwc9hiPgipmVFsJ+tiVx32
         M5tQ==
X-Gm-Message-State: AOJu0YyG8iNGb9Y7Vac0AXHZ/3gP4MLBnyjdJIbrpaLaQ8YDtiGdRCXz
        tF6MSCndSETL/L50/UeO1D8nuw==
X-Google-Smtp-Source: AGHT+IHvcEbCoDqCw1Fy8RgEWPuit/xENlfoh2EHuYOQYRSjxZ82L50BdV84tK7DyIjYWJTuRfLE/Q==
X-Received: by 2002:a05:6e02:190d:b0:346:1185:31d0 with SMTP id w13-20020a056e02190d00b00346118531d0mr11455463ilu.9.1692669326463;
        Mon, 21 Aug 2023 18:55:26 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id q11-20020a92d40b000000b0034886587bdcsm2907390ilm.18.2023.08.21.18.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 18:55:25 -0700 (PDT)
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
Subject: [PATCH v5 6/7] selftests: mm: Add a test for remapping within a range
Date:   Tue, 22 Aug 2023 01:54:59 +0000
Message-ID: <20230822015501.791637-7-joel@joelfernandes.org>
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

Move a block of memory within a memory range. Any alignment optimization
on the source address may cause corruption. Verify using kselftest that
it works. I have also verified with tracing that such optimization does
not happen due to this check in can_align_down():

if (!for_stack && vma->vm_start <= addr_masked)
	return false;

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 79 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index d7366074e2a8..f45d1abedc9c 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -23,6 +23,7 @@
 #define VALIDATION_NO_THRESHOLD 0	/* Verify the entire region */
 
 #define MIN(X, Y) ((X) < (Y) ? (X) : (Y))
+#define SIZE_MB(m) ((size_t)m * (1024 * 1024))
 
 struct config {
 	unsigned long long src_alignment;
@@ -226,6 +227,79 @@ static void mremap_expand_merge_offset(FILE *maps_fp, unsigned long page_size)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+/*
+ * Verify that an mremap within a range does not cause corruption
+ * of unrelated part of range.
+ *
+ * Consider the following range which is 2MB aligned and is
+ * a part of a larger 10MB range which is not shown. Each
+ * character is 256KB below making the source and destination
+ * 2MB each. The lower case letters are moved (s to d) and the
+ * upper case letters are not moved. The below test verifies
+ * that the upper case S letters are not corrupted by the
+ * adjacent mremap.
+ *
+ * |DDDDddddSSSSssss|
+ */
+static void mremap_move_within_range(char pattern_seed)
+{
+	char *test_name = "mremap mremap move within range";
+	void *src, *dest;
+	int i, success = 1;
+
+	size_t size = SIZE_MB(20);
+	void *ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = 0;
+		goto out;
+	}
+	memset(ptr, 0, size);
+
+	src = ptr + SIZE_MB(6);
+	src = (void *)((unsigned long)src & ~(SIZE_MB(2) - 1));
+
+	/* Set byte pattern for source block. */
+	srand(pattern_seed);
+	for (i = 0; i < SIZE_MB(2); i++) {
+		((char *)src)[i] = (char) rand();
+	}
+
+	dest = src - SIZE_MB(2);
+
+	void *new_ptr = mremap(src + SIZE_MB(1), SIZE_MB(1), SIZE_MB(1),
+						   MREMAP_MAYMOVE | MREMAP_FIXED, dest + SIZE_MB(1));
+	if (new_ptr == MAP_FAILED) {
+		perror("mremap");
+		success = 0;
+		goto out;
+	}
+
+	/* Verify byte pattern after remapping */
+	srand(pattern_seed);
+	for (i = 0; i < SIZE_MB(1); i++) {
+		char c = (char) rand();
+
+		if (((char *)src)[i] != c) {
+			ksft_print_msg("Data at src at %d got corrupted due to unrelated mremap\n",
+				       i);
+			ksft_print_msg("Expected: %#x\t Got: %#x\n", c & 0xff,
+					((char *) src)[i] & 0xff);
+			success = 0;
+		}
+	}
+
+out:
+	if (munmap(ptr, size) == -1)
+		perror("munmap");
+
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 /*
  * Returns the start address of the mapping on success, else returns
  * NULL on failure.
@@ -491,6 +565,7 @@ int main(int argc, char **argv)
 	unsigned int threshold_mb = VALIDATION_DEFAULT_THRESHOLD;
 	unsigned int pattern_seed;
 	int num_expand_tests = 2;
+	int num_misc_tests = 1;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -572,7 +647,7 @@ int main(int argc, char **argv)
 				(threshold_mb * _1MB >= _1GB);
 
 	ksft_set_plan(ARRAY_SIZE(test_cases) + (run_perf_tests ?
-		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests);
+		      ARRAY_SIZE(perf_test_cases) : 0) + num_expand_tests + num_misc_tests);
 
 	for (i = 0; i < ARRAY_SIZE(test_cases); i++)
 		run_mremap_test_case(test_cases[i], &failures, threshold_mb,
@@ -590,6 +665,8 @@ int main(int argc, char **argv)
 
 	fclose(maps_fp);
 
+	mremap_move_within_range(pattern_seed);
+
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
 		 "mremap HAVE_MOVE_PMD/PUD optimization time comparison for 1GB region:");
-- 
2.42.0.rc1.204.g551eb34607-goog

