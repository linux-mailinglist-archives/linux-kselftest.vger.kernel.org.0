Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21E734ACA80
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiBGUaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiBGU1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:22 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2413EC0401E9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:21 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s7so6058577edd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=jaLc531Lfzn2CIV3hjJSKaDeRwXxJSGmK4s7rLQ1op80VPV2iUd3RuDz+EMbQkudBj
         Hv9XQPhoEK7+gB6QGHphiFjftE5yK+hJJ5W3aJHiQ5UW0SMWjutS5BTU/blvEG0wEOaR
         uJ/LUXY8sEG9yuIHa8cYRyExBL1cBc981TsmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=sOy+LRJ6Ep/jjjnHyhwWE3vh+A5BQlAaBeJB+1p5USd/SzZQo8MI2lOZV/yoHjjQAn
         74C3N6n9r3yktTBamNfbG8/O+749/HkzUxIJ2At5knB/DLZTcM96jTBmSUlfEteOfW9Y
         T8bsNuS9umbjT86kxJge/SU6mVwW0MeCo1fk4ZYyBLSmr9zsMFc6sLuzbKtWR3cNhfdJ
         qpuVYnb8vjxweVJlUFTMT9zvpdTbQZU5D3sprDakFVNOlMjwU6223YSlBlj7iVqDE3k3
         sjzFDfp7NU/N5uo2kfdi6YlMr07EAN7bSu4EAZqidArH42rGwgRWrKc5ghPT2LMWTwfy
         /wcw==
X-Gm-Message-State: AOAM532R7NkVeRjXzzOywV+o1JqBKC0tlDtHpDjatVxHZNgK4pnpMmzh
        MjWOLvm6N/JGf6tkzQU3cjpg1fS5HoJUOQ==
X-Google-Smtp-Source: ABdhPJwr1EykwK0wYZzzVHs63PyiZ+KXMYLSa/HWcMvv57rHzdRsH7ALubADeRW2s/i7IhOUOmmknQ==
X-Received: by 2002:a05:6402:2022:: with SMTP id ay2mr1198884edb.273.1644265639653;
        Mon, 07 Feb 2022 12:27:19 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:19 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 6/6] apparmor: test: Use NULL macros
Date:   Mon,  7 Feb 2022 21:27:14 +0100
Message-Id: <20220207202714.1890024-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207202714.1890024-1-ribalda@chromium.org>
References: <20220207202714.1890024-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Replace the PTR_EQ NULL checks with the more idiomatic and specific NULL
macros.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 security/apparmor/policy_unpack_test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/apparmor/policy_unpack_test.c b/security/apparmor/policy_unpack_test.c
index 533137f45361..5c18d2f19862 100644
--- a/security/apparmor/policy_unpack_test.c
+++ b/security/apparmor/policy_unpack_test.c
@@ -313,7 +313,7 @@ static void policy_unpack_test_unpack_strdup_out_of_bounds(struct kunit *test)
 	size = unpack_strdup(puf->e, &string, TEST_STRING_NAME);
 
 	KUNIT_EXPECT_EQ(test, size, 0);
-	KUNIT_EXPECT_PTR_EQ(test, string, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, string);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, start);
 }
 
@@ -409,7 +409,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_1(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
 }
 
@@ -431,7 +431,7 @@ static void policy_unpack_test_unpack_u16_chunk_out_of_bounds_2(
 	size = unpack_u16_chunk(puf->e, &chunk);
 
 	KUNIT_EXPECT_EQ(test, size, (size_t)0);
-	KUNIT_EXPECT_PTR_EQ(test, chunk, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, chunk);
 	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
 }
 
-- 
2.35.0.263.gb82422642f-goog

