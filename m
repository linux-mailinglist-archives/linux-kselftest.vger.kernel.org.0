Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A4F790CB2
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243965AbjICPNw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243495AbjICPNq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:46 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9553011A
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:42 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-795547f055fso33810839f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754022; x=1694358822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JBAJc+/RO3zfkzT8oQUizmToikDAYdiXUobcga/v+/I=;
        b=XNqp/7cUxCblamQ14jAv2530ONZdbHS8TfgSn+1vc+pkWsi4bjulAI+d5M7X6rN2Jo
         1IhL1ZQDqWYsXj14OYub0Xh2CCcakwHVDpNea7lDyOSqkMFLqhDYLVqSBT4X3Xn+ztf+
         ZxoPkY1DZVB9n60LXrBl/boVlxcvPLUov7YqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754022; x=1694358822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBAJc+/RO3zfkzT8oQUizmToikDAYdiXUobcga/v+/I=;
        b=R+NlkrPkGK2TlA2nXPYXGSpNjjXU5jylAR6xS03K638wcIRuviLn3Bf9hjBv/huSQ7
         wOSQcJjafIysTZUDeY67bgmosO6gS6Bc15K+pvyXJR8LMXasTkkCFCQxqduqh8aZjtPx
         ifsdn/iJnDXuozq0SrkrsyN5igb2i47UflsSCvq8Mj8ia324yW5kzVZNlfBe6i6o3+xa
         ZCKWgOpZ+kZTn2PyVSwvNelUexeAwfkTwWUdBb9gRz4BatYtKJjCjb+VjtMejx0ym9Zp
         2lDAMM502uJB6OtWRywBALxytNPSn6T6RTayaMTVhOOTGJvM0thnKXPufI6+0NDG7f7T
         fg1g==
X-Gm-Message-State: AOJu0YwI9jYK4KJF4yed5LXkzt9skOiFTWtbALcZUxkZNTy1BD0t67ot
        mW4A3YL6Xoi6sBw66S4rUCTjLskdad5IpaRKFQQ=
X-Google-Smtp-Source: AGHT+IEnJA2vqbUSl47p66mh9CCynh4MUM2TZrhlzcxgAiU4zPqoOBOaRdFGp3Nx/rofoZWjgNCIdw==
X-Received: by 2002:a6b:7218:0:b0:77e:3598:e511 with SMTP id n24-20020a6b7218000000b0077e3598e511mr9517002ioc.2.1693754022005;
        Sun, 03 Sep 2023 08:13:42 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:41 -0700 (PDT)
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
Subject: [PATCH v6 6/7] selftests: mm: Add a test for remapping within a range
Date:   Sun,  3 Sep 2023 15:13:27 +0000
Message-ID: <20230903151328.2981432-7-joel@joelfernandes.org>
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

Move a block of memory within a memory range. Any alignment optimization
on the source address may cause corruption. Verify using kselftest that
it works. I have also verified with tracing that such optimization does
not happen due to this check in can_align_down():

if (!for_stack && vma->vm_start != addr_to_align)
	return false;

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 79 +++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index d7366074e2a8..12a095457f4c 100644
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
+ * a part of a larger 20MB range which is not shown. Each
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
2.42.0.283.g2d96d420d3-goog

