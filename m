Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014644AD7DB
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358480AbiBHLue (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 06:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358594AbiBHLu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:28 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF182C0048E6
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 03:45:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y3so30630232ejf.2
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 03:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ora2gAZjzTFWwGBCGckRLz708H124CL8azMV0mFmXpM=;
        b=mBet+b8ue5pdw7D2ilHNZW9XZIQ1Soij1gU5bMNz8/IZc6C1avMRvt6tu33aO/ZqxM
         5Y0zlZ+UwcV+n/AwoyXUbISHdf8aBekA2SN3nrwxHldVPopiEPBDY06Z2QG0miVCxR/3
         gu/aZnrE2W8T+OxjWkladaNGsWrTJRZHg7ndc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ora2gAZjzTFWwGBCGckRLz708H124CL8azMV0mFmXpM=;
        b=o9oYm7fDsJs4SSDVjaWwzM6dJVno+6hZrAeyG9NDUa21uB/yPsjKZUfhACCNsvig58
         HX4+/AkZUcKZv3pjHRdmAqRUKSIYd7EUJp0/vyU2ZLoeKmSATSC3PIBBSbezvgU1GL5o
         N+9KXLrnBwc8GYs6WWWoXEjRKKWWW18E6qnbVBTxmCDVsVy3jSUL4QLUqAV2Qzh1z7kl
         6M3wXgOun8hkyX1MkNxXZP4dc2c5m/Xy/dpkYU5bA+qbMeFrGpCR0GVdiMHwUAj5tEwf
         sG0ybwENhZxp5pssrSe/GgoQ2XdFcdahSmC+n0bJDZTc6oAv0DyH2LecZq/W4ZC26yOy
         LXjg==
X-Gm-Message-State: AOAM532cTYpxSqS8lD8qZ4FQIWW4B3fRgthH5SWXOkVLxndztZcS9qCZ
        geQytoAf+4xgQai5vYLcYQBAWw==
X-Google-Smtp-Source: ABdhPJyfzRgBBS+4gTD8KSas5ql8fczRt2MQ40oU9QoMfgD0DIvtQXytV2NVhrzIaVNc5xD7L6jy5Q==
X-Received: by 2002:a17:907:7212:: with SMTP id dr18mr3513058ejc.187.1644320747443;
        Tue, 08 Feb 2022 03:45:47 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:5d0f:d242:ddbf:a8a6])
        by smtp.gmail.com with ESMTPSA id y2sm4151902edt.54.2022.02.08.03.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:45:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 4/6] kasan: test: Use NULL macros
Date:   Tue,  8 Feb 2022 12:45:39 +0100
Message-Id: <20220208114541.2046909-4-ribalda@chromium.org>
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

Replace PTR_EQ checks with the more idiomatic and specific NULL macros.

Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 847cdbefab46..d680f46740b8 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -385,7 +385,7 @@ static void krealloc_uaf(struct kunit *test)
 	kfree(ptr1);
 
 	KUNIT_EXPECT_KASAN_FAIL(test, ptr2 = krealloc(ptr1, size2, GFP_KERNEL));
-	KUNIT_ASSERT_PTR_EQ(test, (void *)ptr2, NULL);
+	KUNIT_ASSERT_NULL(test, ptr2);
 	KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)ptr1);
 }
 
-- 
2.35.0.263.gb82422642f-goog

