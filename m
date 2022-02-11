Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC894B2248
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 10:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiBKJlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 04:41:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbiBKJls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 04:41:48 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FD110A3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:47 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id j14so21614880ejy.6
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYp/F1vbxbLivUF65w2maaWuA20v5CCQAIJDPT6o8JY=;
        b=P+snyK/K7F5kmeZGRo227byIU7hqoXUXFAMxaM7IHj/+iPYMPx52ptzFV3qwjEzBBx
         u7S6QvgV566gReynCO/sCR7MADt80CU+VBpiIlotgPN7/ECTjT1sGrujoGBZ8dEPf2II
         trpbWctMwxax83jjKpSo4lNU2DWXqq5gJe7pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYp/F1vbxbLivUF65w2maaWuA20v5CCQAIJDPT6o8JY=;
        b=eeB1BfloXE5OGWRSsJiOGWkM5EjpB08pfPP6lii6sX28mPzvuMbMoDBdM4CFT0xqqp
         S61lWdy3eO5yU/w/tZRMc12HS+/lfRJ0PxaFRAH5c2cWDZBo+87Bf6rWGHzfNew86S0e
         o3d0Vvu0lgCCI+tCX7jgaQ+uaOWKExR4v4itlApY1J9vExhroiqTLgNUTmqB2lhbb2gh
         LQgKx9za349+t5zi6C3Zm1SUq3rossdtPZSgeHxnwZpqqYEoBi57uC2C1yP5wSSFnfU9
         Mc/I0oEmgMPs/GsNkGA7Q5ue0Kf5R0z/hEjM3zq3+wR9Siw+UQ1gzn9IW6wejbnQdJ4E
         mWcg==
X-Gm-Message-State: AOAM532490JxFpqQFWEB8zMF+HwtOTKtlc24ruLX8cR/nlhN1tUIKJfs
        56O85zd6eTXbAWSMyeL/4qgFnjaDgDKGLg==
X-Google-Smtp-Source: ABdhPJwB08ud+/5tndfSYmQIcISb2WgFiQwIJDrv/9+u7r5FFmQbtjrgV41CpZkWzFF6UZDM3bUzUQ==
X-Received: by 2002:a17:907:6d88:: with SMTP id sb8mr639925ejc.25.1644572506148;
        Fri, 11 Feb 2022 01:41:46 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:83e3:abbd:d188:2cc5])
        by smtp.gmail.com with ESMTPSA id e8sm603196ejl.68.2022.02.11.01.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:41:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 6/6] apparmor: test: Use NULL macros
Date:   Fri, 11 Feb 2022 10:41:33 +0100
Message-Id: <20220211094133.265066-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
In-Reply-To: <20220211094133.265066-1-ribalda@chromium.org>
References: <20220211094133.265066-1-ribalda@chromium.org>
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

