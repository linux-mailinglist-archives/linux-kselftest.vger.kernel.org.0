Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EB14B2AB0
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351640AbiBKQmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351632AbiBKQmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:42:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC624D68
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:52 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id e7so20029149ejn.13
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYp/F1vbxbLivUF65w2maaWuA20v5CCQAIJDPT6o8JY=;
        b=CL6Jlbne1nQ4xOStNkTjKFGiu6eZkyt70Mcb0LWc0882nAZ7P7kd+jW4SmkAkdbSOi
         SK2lKsX8ECKyxCq1E/oi+ky7sq/74xwgWEug8LnHLiiTm/zDSY3u7V739zYQHq14qwu0
         KRESuB29xjHnegmn33WD7l+FJH06sG7eTLfZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYp/F1vbxbLivUF65w2maaWuA20v5CCQAIJDPT6o8JY=;
        b=JkVmEoBzRzoOJ9P12d/p69fSvBzmV2KQu7GCdSUbfGvSP9WvuQqtCjkBwV99je92oO
         TCwcselHbB5Ka5XpVchx5UgOwQFOtPWVJJ9Ze+c+JWTYiWFGhi+Qi9UdkLEKVtwh+ePX
         qN7TP09A0aa0D6wjTgF90O2e7lm8fg/0xPC8W2ZXg1K0+nesfWMMbeIoI8FUbMvE0CZK
         Kc1VXi31AjV0Q0JB5PEUOBDB2EgnhZsz/666RhLECUWkB22RMVI8rznccpgO3CMBkoS/
         6d1qVtbwGvrI/7QlYvAGM+fsjCWHaXSeqXPjUK1C9bFS8PpTVsvyVsQ3XzdmKwXxsXSr
         T9uQ==
X-Gm-Message-State: AOAM532XqjWgpoYOVWNLyWSoXfMS/XMa8ZChZ/O0TGGBY+TvJO180c/j
        WvhVuh5bvXSX0HpcCrSBbRgiTQ==
X-Google-Smtp-Source: ABdhPJygyJBMvsfog6wCOcGdFWEDQXX093IZi30k7s33kVrBINglEQvM2MGt+3IsIw8946097lp0cw==
X-Received: by 2002:a17:907:6d1b:: with SMTP id sa27mr2076137ejc.166.1644597771403;
        Fri, 11 Feb 2022 08:42:51 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id i24sm4981233edt.86.2022.02.11.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:42:51 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 6/6] apparmor: test: Use NULL macros
Date:   Fri, 11 Feb 2022 17:42:46 +0100
Message-Id: <20220211164246.410079-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211164246.410079-1-ribalda@chromium.org>
References: <20220211164246.410079-1-ribalda@chromium.org>
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

Acked-by: Daniel Latypov <dlatypov@google.com>
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
2.35.1.265.g69c8d7142f-goog

