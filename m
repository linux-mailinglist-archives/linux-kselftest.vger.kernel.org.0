Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65170FA27
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 17:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236010AbjEXPdA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjEXPc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 11:32:57 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DDB194
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:56 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-74e4f839ae4so88404185a.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 May 2023 08:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684942375; x=1687534375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BlbglpAiZ94wJYkjhcCjsilb7jfKjCG904F6yJstFY=;
        b=M1+QdVekzfaYabKgKHR4vetDn9xM5mnD1uJWBlxynPLjOJfqn9oU5l1EBrOn9cJpSz
         Hq98wTXJQOIQVLk3KS5/hG2Zi5acdW1WRswNIK3R6vCGj/LzIulXp3+4a64uKUCOthvR
         XxhMU2PzCdmfCd52I8rtjdt6QU++OhdOr5Brc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942375; x=1687534375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BlbglpAiZ94wJYkjhcCjsilb7jfKjCG904F6yJstFY=;
        b=AZPiZwm6PkuurlMoh4uK+8n+JEd2XAQdMj9BohCIkWcGlBCaQJGlOzVfuxrqBanEgY
         AEkCNdhyC+fIT2gfb3TyYRxqF26Rw0dulq0iREhEfTQNgK2sIq1a3JzXLk2eJYwE2KFn
         ZnhAhFtIE/3QZxdqORoqvQLhpELe30i5EYl3/ILZtWzenGIEgLQELl/54mg14IJAGi5x
         tJHP8tVUvUwk+NwSveOL3O8V2XWC29eluduX4tfcCIxkzvCUXeA74SkSFK40PyIkT24x
         ldelHTVOcy55gQuSJwfUsN9Fx8LfEqDlhcZKUv0QhX6+1k8yq+ZxNiVuha4C0UFi/62W
         tA9Q==
X-Gm-Message-State: AC+VfDwoWiGFbum2nmVK8tyxxJSxcZav70DQXlCzNKFW9ox1GqIjKR3d
        yDceJ1X2FMDfwUFVnPl4OKKi9Q==
X-Google-Smtp-Source: ACHHUZ7pGnIf2o9ajIrHimtsY3ZVo0AwxwHuV3J27Cvh7vb4ofkI3lzj/qbuT6W4fOkb8sK71jM2Aw==
X-Received: by 2002:a05:620a:8d0e:b0:75b:23a1:3680 with SMTP id rb14-20020a05620a8d0e00b0075b23a13680mr6261791qkn.65.1684942375456;
        Wed, 24 May 2023 08:32:55 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id v18-20020a05620a123200b007590aa4b115sm3296906qkj.87.2023.05.24.08.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:32:55 -0700 (PDT)
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
Subject: [PATCH v3 4/6] selftests: mm: Add a test for mutually aligned moves > PMD size
Date:   Wed, 24 May 2023 15:32:37 +0000
Message-ID: <20230524153239.3036507-5-joel@joelfernandes.org>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
In-Reply-To: <20230524153239.3036507-1-joel@joelfernandes.org>
References: <20230524153239.3036507-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

