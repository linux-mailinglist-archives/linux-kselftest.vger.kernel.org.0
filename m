Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586334AD7D9
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 12:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355842AbiBHLuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 06:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358060AbiBHLu3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AB7C0048EC
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 03:45:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id m4so51555333ejb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 03:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HihT2WHm5CL9KTfiGWQaowQJbGra0dr2IasABIBxyUw=;
        b=dIU94/X3NSIjW+rsZ/+s0eeBqfr3PvqsbVqXO6YiS3opCaDTgSHjBC6a5bzaVC+fmC
         7hJY2+P8i+1tDD9eY6/IsSwD5g78d6XUSWGspQOlq5T/5LqyahFVFcIX1tf2Hq20QCFO
         XIOfuk4gjyKsHJT0PULu8IFwxLpabXqzpBy/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HihT2WHm5CL9KTfiGWQaowQJbGra0dr2IasABIBxyUw=;
        b=KVOSUWRSFYMudWQ762n0EFTu9vKxTXRWNUMSndlOeo8ii/pCZ/l+jo2rKdW5StWmHR
         se6U9PCoRQwSc1ohURdZg6KC9/0ftsFUlY6POu9rCo4U6HkyOIUiRk6xup3Y7gI2Forg
         TtM5lK4/Y8qBvMq2WJP1hpOF1cPyAgnhh9Il9f0ZUKp1cyZgax8Id//qWDDFIS+6/H+i
         zjz1pB9xvur8cxIq0m0ZnI1j3zRrxN3E7hFdzVbZBJfP/mSu6y7D+EAw/TWop3GUv/ER
         HO2sHrPyPvHOcFoQPx0JUF4gdSAnle6bBsjN5qVXiPqRfxe2i2QSsgMm4EEs8oRWA9px
         psfw==
X-Gm-Message-State: AOAM530qvNzJJ/nnSSIDVl3zdB1ichtRgvI5q9Pih4Mse0hnCIgS0JYp
        hwMSDz1BP7b4hY0WK6tbTl4Gfw==
X-Google-Smtp-Source: ABdhPJzo1ehebUbL5Zza/R8qwmqZqxbxBXxGJPyv3pmwWAQvc2EDBDyYvTbVgE/7K50OuPHt4wmwXQ==
X-Received: by 2002:a17:907:c27:: with SMTP id ga39mr3323524ejc.626.1644320749345;
        Tue, 08 Feb 2022 03:45:49 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:5d0f:d242:ddbf:a8a6])
        by smtp.gmail.com with ESMTPSA id y2sm4151902edt.54.2022.02.08.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:45:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 6/6] apparmor: test: Use NULL macros
Date:   Tue,  8 Feb 2022 12:45:41 +0100
Message-Id: <20220208114541.2046909-6-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208114541.2046909-1-ribalda@chromium.org>
References: <20220208114541.2046909-1-ribalda@chromium.org>
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

Reviewed-by: Daniel Latypov <dlatypov@google.com>
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

