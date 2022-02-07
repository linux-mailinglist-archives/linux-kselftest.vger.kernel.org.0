Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F67E4ACAFC
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiBGVLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237207AbiBGVLw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:11:52 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C886C06173B
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:11:51 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id f17so15825445edd.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=alaweuer3th62ZQjykeD0cBVmVy3HsuFHxNlOwQLYv0wtP4PX75JbnFBG+M/a9oh3a
         oFrebONg/lJ1eQHgWrHVsycuq5on8kNN5A0B9WNOhzQ1eJcbLO39aSsn3TNprgYjNyDJ
         vOgw8jX3xahAFCu2x8GN5/rNeB0gWtJiMsU2I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sQV3FF5mFgBVe7Tg/aDZitfy1ByGgWInZOonbxaNvNg=;
        b=F+VMbeU+FT4VEhQiqIVEIeD+qDzd1cyUWYQE27nsnKx2TdE5qRA5Y4rtQoW0KOevjG
         a4ajs7XAVyWCG1qSQmoXnIvp+hwXetGSCAM5uQL1tMRqjM4OVk7WWg2A6mun9hIgsAAL
         kG/4I2KrlFkmQO6FUjMgacZF0Yg4Ngq9F73EWJcCRvBDT11clY+77gltf/IcRnTvf3d4
         9niUGTKmg/oGsq/qh+ZNbZKgVKt6fr87KuNmW+6+6zIKP3saFlcDYXYSSjv6Yr90zZ3+
         mJWLogFj2HpXje5daFT/oYHq8slP4bRyd7D8TTBlM+o6GrEptpXQk/xL9DfK+i5+mKKR
         u7Zw==
X-Gm-Message-State: AOAM531SjZydaHjbYcpMs1d4TIWJug6YSZpohmjGnJfPP8TVxIYl89d/
        4Y6vTbONK4qcJtX8Xv8XU3y9ajBaADEcLjMT
X-Google-Smtp-Source: ABdhPJyKAL8SeX/xC7tgICrKzkY1jnMzKvGI6dOO8jQzoiB5i9EGjWwBe1dOFOoogut4VKLY/MQc/g==
X-Received: by 2002:a05:6402:4256:: with SMTP id g22mr1394967edb.78.1644268310129;
        Mon, 07 Feb 2022 13:11:50 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z4sm4047239ejd.39.2022.02.07.13.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:11:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 6/6] apparmor: test: Use NULL macros
Date:   Mon,  7 Feb 2022 22:11:44 +0100
Message-Id: <20220207211144.1948690-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207211144.1948690-1-ribalda@chromium.org>
References: <20220207211144.1948690-1-ribalda@chromium.org>
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

