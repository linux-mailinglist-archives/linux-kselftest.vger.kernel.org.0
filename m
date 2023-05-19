Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05378709FBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjESTK3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjESTKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:10:23 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E543110F8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:49 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id a1e0cc1a2514c-783f88ce557so2057896241.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684523389; x=1687115389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BlbglpAiZ94wJYkjhcCjsilb7jfKjCG904F6yJstFY=;
        b=x8ZyDrw6ni184t1nPUu9gHzYGnCU4QMuz0CHgZiJdJSkGolahQopXIQzMHUKRX1tuL
         Sk9VbgqX2HUtPxhGHeN4FRXjhKh1tAahRr6lwwpWuDo763W0ExapWgKq8ZNizk5D6Nj+
         cwyjlwYVFmQ1N0AvIKfGAIKpy+GRM3WOTBx+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684523389; x=1687115389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BlbglpAiZ94wJYkjhcCjsilb7jfKjCG904F6yJstFY=;
        b=QXTHEP4fpiNwHs6rC1VP0It3Yko6AxEkJ58TXyf8ksaX6x/s83yuUFfGP8VDdaOuHH
         KopW2CgBvYQLn8WVqUDCpM0lPovG1X3AG4JTDxNBiYx89ApkrjmvSg/DlklcT/NlLCCs
         3YeSRwFfVDJaSU8Re6EpQz0BAmhN8gi5Zg5sBKepXvaRpAhXYY9g4hujgQUEg56YOmTO
         gO0yX4DxObNCuGDOiL4HWjEY8+6hvyT4traMquSjmCt/+QTooMw02QHOHDa2mfsDh/oq
         MGqCTmj1IHvKr8zj11mUX3FTePE8KtcSCHwm2PbI4eThi4sGI5cp3Wcr7fGEbTwl9QPJ
         QbCA==
X-Gm-Message-State: AC+VfDyLm245C+Kddl8qF1az98sHHmkJ31xyO+8QePDiIAQ2zCeVZ5IV
        mAfervYNi2VTtvrame29c4Mctw==
X-Google-Smtp-Source: ACHHUZ7k2Kr/gJkiN5S1M+tfEjayIP8g2cDy6n/x0srwgMQ1712z1LJILIPD/wMAeXbKBNfnKX869w==
X-Received: by 2002:a1f:5901:0:b0:43f:ea80:e8af with SMTP id n1-20020a1f5901000000b0043fea80e8afmr1449033vkb.4.1684523388940;
        Fri, 19 May 2023 12:09:48 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id q20-20020ae9e414000000b0074e1ee30478sm1317611qkc.37.2023.05.19.12.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 12:09:48 -0700 (PDT)
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
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 3/4] selftests: mm: Add a test for mutually aligned moves > PMD size
Date:   Fri, 19 May 2023 19:09:33 +0000
Message-ID: <20230519190934.339332-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230519190934.339332-1-joel@joelfernandes.org>
References: <20230519190934.339332-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch adds a test case to check if a PMD-alignment optimization
successfully happens.

I add support to make sure there is some room before the source mapping,
otherwise the optimization to trigger PMD-aligned move will be disabled
as the kernel will detect that a mapping before the source exists and
such optimization becomes impossible.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 tools/testing/selftests/mm/mremap_test.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index 6822d657f589..6304eb0947a3 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -44,6 +44,7 @@ enum {
 	_1MB = 1ULL << 20,
 	_2MB = 2ULL << 20,
 	_4MB = 4ULL << 20,
+	_5MB = 5ULL << 20,
 	_1GB = 1ULL << 30,
 	_2GB = 2ULL << 30,
 	PMD = _2MB,
@@ -235,6 +236,11 @@ static void *get_source_mapping(struct config c)
 	unsigned long long mmap_min_addr;
 
 	mmap_min_addr = get_mmap_min_addr();
+	/*
+	 * For some tests, we need to not have any mappings below the
+	 * source mapping. Add some headroom to mmap_min_addr for this.
+	 */
+	mmap_min_addr += 10 * _4MB;
 
 retry:
 	addr += c.src_alignment;
@@ -434,7 +440,7 @@ static int parse_args(int argc, char **argv, unsigned int *threshold_mb,
 	return 0;
 }
 
-#define MAX_TEST 13
+#define MAX_TEST 14
 #define MAX_PERF_TEST 3
 int main(int argc, char **argv)
 {
@@ -500,6 +506,10 @@ int main(int argc, char **argv)
 	test_cases[12] = MAKE_TEST(PUD, PUD, _2GB, NON_OVERLAPPING, EXPECT_SUCCESS,
 				   "2GB mremap - Source PUD-aligned, Destination PUD-aligned");
 
+	/* Src and Dest addr 1MB aligned. 5MB mremap. */
+	test_cases[13] = MAKE_TEST(_1MB, _1MB, _5MB, NON_OVERLAPPING, EXPECT_SUCCESS,
+				  "5MB mremap - Source 1MB-aligned, Destination 1MB-aligned");
+
 	perf_test_cases[0] =  MAKE_TEST(page_size, page_size, _1GB, NON_OVERLAPPING, EXPECT_SUCCESS,
 					"1GB mremap - Source PTE-aligned, Destination PTE-aligned");
 	/*
-- 
2.40.1.698.g37aff9b760-goog

