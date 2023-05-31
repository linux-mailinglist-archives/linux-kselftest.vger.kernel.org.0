Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7F5718E1D
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jun 2023 00:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjEaWIv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbjEaWIn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 18:08:43 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E53196
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:21 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f6b2f1a04bso68295951cf.3
        for <linux-kselftest@vger.kernel.org>; Wed, 31 May 2023 15:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685570901; x=1688162901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpicKoUd2HYKUWTIhMS6ThagQPd/JY7bC7rJfvoQE2Y=;
        b=C2nanwM4s2qBeaw7g/O1s/IU/DVR7Y2rNl+A3MbDPeVyLvdaIPdY6T2eaGhET6A0sF
         up/AOMYaez92DN3FPLb14JMGsjTAdM2hcriEezhuAu++ExO/CNN3lO1c6isZ2nAox6kS
         6vZCyox2c8xGrqTdhmbAICcrkrOV8Zq0SaMjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685570901; x=1688162901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dpicKoUd2HYKUWTIhMS6ThagQPd/JY7bC7rJfvoQE2Y=;
        b=fwovIn+/q1AnRPA7gOq3lkQhXawrsAHzpABBey6g5cp29Vov+wJ5++eb9S7rjrZ3tq
         1WWbwtNm5z5ReuogkOXSpBPj+/Fur7/NtGkojzYfjAVBu3+D0uv3UW6tnVgQYeACchZZ
         1NCB/Mp7izMOdkjXhtnvB7D5Zewu+ivb9IGJflEuE/pwo5bIY3ukHzm1spCs8OG90bZx
         1VnJTr5bg8xMPxg+o2J6bmjj5c50YknWf8DRIFeSbECuLKOab0POJ5McofM/YX4+eaYt
         ZB6I/7I7iq95TkAjQ43zdFNYKcAklyGL2SjZlbu5vJ+QldPViXF+YSahO1hXeuFywdHf
         zpPw==
X-Gm-Message-State: AC+VfDzuwcqLa3g50i9YKaklefPC58ZcPpIvByFb0lF541I++TtWmeE+
        CsczeSYhiuFhyWaSukKdlYfXXA==
X-Google-Smtp-Source: ACHHUZ4fuBeiJwYmTyjlbh3vNdxD6U2rVYsiG5NEaciB66hwrL3r2K1rWBnhNt+DCnNTWPl/qP0dEg==
X-Received: by 2002:a05:622a:189d:b0:3f4:cfed:96bd with SMTP id v29-20020a05622a189d00b003f4cfed96bdmr9701607qtc.21.1685570900832;
        Wed, 31 May 2023 15:08:20 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id f2-20020ac87f02000000b003f6b0f4126fsm6666172qtk.8.2023.05.31.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 15:08:20 -0700 (PDT)
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
        Lokesh Gidra <lokeshgidra@google.com>,
        Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH v4 4/7] selftests: mm: Add a test for mutually aligned moves > PMD size
Date:   Wed, 31 May 2023 22:08:04 +0000
Message-ID: <20230531220807.2048037-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230531220807.2048037-1-joel@joelfernandes.org>
References: <20230531220807.2048037-1-joel@joelfernandes.org>
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
2.41.0.rc2.161.g9c6817b8e7-goog

