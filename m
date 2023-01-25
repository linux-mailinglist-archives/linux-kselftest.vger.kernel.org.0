Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E7767AA43
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jan 2023 07:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjAYGTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Jan 2023 01:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjAYGTp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Jan 2023 01:19:45 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796F228868
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:19:44 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-4c11ae6ab25so177277917b3.8
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jan 2023 22:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rN+sm+TcugjUv59BMF0yG8d1YW/2kNYdNAY7JYWtYoU=;
        b=f9UIMJC2vqWBeTaMiQjOJIw/h6moDE7Vx1h6AAUCHw9ZcZwTmkfoMoKAxeNGQWE10D
         5uCwIXapRgC01sIpfJdfBourkCV3UyU1UkawxV8hgjLOzAXgKXhFUOc4L+PPi+ihffSV
         pN4ICj+K1xr/lFY3VH0W+X7ke3Y3AwzS2+uDk52tc1rDNxmbvzdvg/bOwUW7imdC99G/
         FfZzzz7HGioffluxkziMrPLSguCYxe7TUqyI4OUAk5DmGTtCcmFoTohCFeLKtKYwWMKs
         hRFtRhDKPFLfVxNQ6HzibIP/59XQ7hFmlSpg5C7RdjPRpyhX/Dpd1+someJQV/J2iD/y
         gXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rN+sm+TcugjUv59BMF0yG8d1YW/2kNYdNAY7JYWtYoU=;
        b=y2LrzoNRtY89jHOI4XNHPU3QFjQ5DeEPNBvthTyTmufIjRrLu7BovzDs0eeFbdzjhH
         IKhroCjFntJUZ8LiE1XS9K9poFazldx1JsHi0fxKJYexY/a0HelRFm2a/g7Nc0E6HdeX
         9PrcBT6omH8Uqjk2RzR/lIeEt90Mp508HTngHaSu7EuFBYVQ8xZnxTaGPUxyGt0IVtph
         BqJ+CBheiJTXGLwYMa8j9OmTppsfij0TG+r5Xv+nYhydXWeJzYZaaEVnnZ6N8oIAUsUm
         nqmB8QKCBGpQKRUUxX2RYkC58ni97ohCKLORaF/796AMdJ8KQ4Ak6u7GiHMIry6PPlId
         QZAQ==
X-Gm-Message-State: AO0yUKXPGDf00aR4rDYM5CIMmtRYb9noWVCacfuY7SSP4PdVvynooLuM
        TfJlbfYysJ1+kTnXLd9C3VEw5gri1Q==
X-Google-Smtp-Source: AK7set8CBvCLr3fTesrkX4RhU0QPjG2ETUfl1pA3AVqwS7g5yhO/xJaFw1tJZD8G3z3bq+fxDk2A0vM13g==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:320f:0:b0:80b:5654:64f2 with SMTP id
 y15-20020a25320f000000b0080b565464f2mr781190yby.640.1674627583719; Tue, 24
 Jan 2023 22:19:43 -0800 (PST)
Date:   Wed, 25 Jan 2023 06:19:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.405.gd4c25cc71f-goog
Message-ID: <20230125061927.141538-1-rmoar@google.com>
Subject: [PATCH v1] kunit: fix bug in KUNIT_EXPECT_MEMEQ
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ, add check if one of the
inputs is NULL and fail if this is the case.

Currently, the kernel crashes if one of the inputs is NULL. Instead,
fail the test and add an appropriate error message.

This was found by the kernel test robot:
https://lore.kernel.org/all/202212191448.D6EDPdOh-lkp@intel.com/

Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Rae Moar <rmoar@google.com>
---
 include/kunit/test.h |  7 ++++---
 lib/kunit/assert.c   | 40 +++++++++++++++++++++++++---------------
 2 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 87ea90576b50..3c7045e22512 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -683,9 +683,10 @@ do {									       \
 		.right_text = #right,					       \
 	};								       \
 									       \
-	if (likely(memcmp(__left, __right, __size) op 0))		       \
-		break;							       \
-									       \
+	if (likely(__left && __right))			   \
+		if (likely(memcmp(__left, __right, __size) op 0))	     \
+			break;							       \
+											       \
 	_KUNIT_FAILED(test,						       \
 		      assert_type,					       \
 		      kunit_mem_assert,					       \
diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
index f5b50babe38d..05a09652f5a1 100644
--- a/lib/kunit/assert.c
+++ b/lib/kunit/assert.c
@@ -241,24 +241,34 @@ void kunit_mem_assert_format(const struct kunit_assert *assert,
 	mem_assert = container_of(assert, struct kunit_mem_assert,
 				  assert);
 
-	string_stream_add(stream,
-			  KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
-			  mem_assert->text->left_text,
-			  mem_assert->text->operation,
-			  mem_assert->text->right_text);
+	if (!mem_assert->left_value) {
+		string_stream_add(stream,
+				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+				  mem_assert->text->left_text);
+	} else if (!mem_assert->right_value) {
+		string_stream_add(stream,
+				  KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
+				  mem_assert->text->right_text);
+	} else {
+		string_stream_add(stream,
+				KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
+				mem_assert->text->left_text,
+				mem_assert->text->operation,
+				mem_assert->text->right_text);
 
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
-			  mem_assert->text->left_text);
-	kunit_assert_hexdump(stream, mem_assert->left_value,
-			     mem_assert->right_value, mem_assert->size);
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+				mem_assert->text->left_text);
+		kunit_assert_hexdump(stream, mem_assert->left_value,
+					mem_assert->right_value, mem_assert->size);
 
-	string_stream_add(stream, "\n");
+		string_stream_add(stream, "\n");
 
-	string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
-			  mem_assert->text->right_text);
-	kunit_assert_hexdump(stream, mem_assert->right_value,
-			     mem_assert->left_value, mem_assert->size);
+		string_stream_add(stream, KUNIT_SUBSUBTEST_INDENT "%s ==\n",
+				mem_assert->text->right_text);
+		kunit_assert_hexdump(stream, mem_assert->right_value,
+					mem_assert->left_value, mem_assert->size);
 
-	kunit_assert_print_msg(message, stream);
+		kunit_assert_print_msg(message, stream);
+	}
 }
 EXPORT_SYMBOL_GPL(kunit_mem_assert_format);

base-commit: 5cb26c298ffde271d9bd1dd1b87ad028218f77fe
-- 
2.39.1.405.gd4c25cc71f-goog

