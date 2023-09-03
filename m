Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B821790CB0
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Sep 2023 17:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243833AbjICPNu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 3 Sep 2023 11:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243470AbjICPNp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 3 Sep 2023 11:13:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB01111D
        for <linux-kselftest@vger.kernel.org>; Sun,  3 Sep 2023 08:13:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-792717ef3c9so18311439f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 03 Sep 2023 08:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693754020; x=1694358820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3i4JKzyyHPJXK5xbz9I2FYDU9mp4fFQ0BqGZeRR+IkI=;
        b=FTlhbyia5QMCbrtLFXMkUmgVcb+mZtdvE4C2xiUXUbtiUDneBOuatj8RUARk0V/4zr
         M4hQmMSKtICjpEc0hHUIrB2+cXl13nTfFVXlLUp3rSD++8cPriJMSsl+78pMLBv9debc
         c3w6G9A3fkJCeWnwIaPVdDApuafr1lpaDtS4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693754020; x=1694358820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3i4JKzyyHPJXK5xbz9I2FYDU9mp4fFQ0BqGZeRR+IkI=;
        b=ER3M/s0FaDNPHDh2E2YauidSfubUyFni+VYhgTItL/yfgY6ixvoLx/kZu5mWEnZKwp
         t58//Zb/G6QEklGpG52R2aOX/qPnpAhPzLy7BQ62GDbRYyKXGfF/aIFU0S4+uJwP1cdh
         CAqovZA15arLga2N6x0kCwvMsTn2Xa28LS2cuYTqFluHMz8vHbkvYkOEqYbOnwmiu4+R
         hN75bP46j9enwX4tL4Hh9cJaWFy3bZ4TKtKtxLrgINLziJ3P1be9h4RfrK5KP5Qo3h7B
         5SlRN9/JhxN95C42peampyhsXW3Xf1FZzwFn3uQKOBkJKRsPehrgEt1w53M+Cao1O8cz
         oywg==
X-Gm-Message-State: AOJu0YybnQV/gf2J3lXunprdnV3A137KM8/nzg7kqf+OSjt7fGAhURdY
        qZlw0dO336+DTDAgVdLu6C5BKQ==
X-Google-Smtp-Source: AGHT+IHONBzFDHNEJj9fUdFbCOcAZGQgCkRLbDItObOX2Jewvf4Oe2vlmaZIITxIM+/izWF1P0j3xg==
X-Received: by 2002:a5e:aa0a:0:b0:792:4d29:ecc7 with SMTP id s10-20020a5eaa0a000000b007924d29ecc7mr7910869ioe.15.1693754020233;
        Sun, 03 Sep 2023 08:13:40 -0700 (PDT)
Received: from joelboxx5.corp.google.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id f5-20020a6b5105000000b007835a305f61sm2605897iob.36.2023.09.03.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 08:13:39 -0700 (PDT)
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
Subject: [PATCH v6 4/7] selftests: mm: Add a test for mutually aligned moves > PMD size
Date:   Sun,  3 Sep 2023 15:13:25 +0000
Message-ID: <20230903151328.2981432-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230903151328.2981432-1-joel@joelfernandes.org>
References: <20230903151328.2981432-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Lorenzo Stoakes <lstoakes@gmail.com>
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
2.42.0.283.g2d96d420d3-goog

