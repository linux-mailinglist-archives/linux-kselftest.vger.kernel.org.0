Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6554B224A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346940AbiBKJlu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 04:41:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237122AbiBKJlp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 04:41:45 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3302210A0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:45 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id u20so17312218ejx.3
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yxy7zthPRWHub+MPiGJfuPkSoZH4U5JEJa8lsfSBR/o=;
        b=bMKbgW7aFIfE/6ZGdevAMND4WHxGavX3P0U7c1oMkYPnj5X6vDTxJpHyzZ9dvTtB50
         qRfxUpu0tP6mL6vnWmWy1UOgFBy1UFJFdu5VEzxvRl6x0VCeyMag99XlAsitkNJUfOsY
         GlbuEws7MVgYj1jPY723Qc2p7VGd0VZkDzjfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxy7zthPRWHub+MPiGJfuPkSoZH4U5JEJa8lsfSBR/o=;
        b=3TW36ZBxMuzKGPW4VL6pnugR2yML2aMxWeq4EFJg9I2noLfixWCBlYCZxX640FrnMq
         UhGxJXdmSHvOap3MXxp73boEL9M5T9Zr3joT7TE3RMwivbIE+mfGO2I/6UK3AVARsSdF
         zoxQ1kHJuFz0y9ttjPOUpB0oqRQRXMAjvD9EO6XalfRcvqcW8NQMQvl+Tw1WVHm3cwiE
         WCGJdmZ7QA0Uvu7nWYtkMXJR6qwFmKHrLej9lC4RWZJdEodZFC+AnmRcT29eA1Mg6tqK
         38BVb1NfC0kgvuMRJtBMRmBBcSvUilq9EH1cvmjmKAgH02RtP30IXOfYSwXEv/qy//2e
         nx8A==
X-Gm-Message-State: AOAM533S/ZxXjp7psn9j174XAufUZZ9Z/wCC1+sgeFgW+L49dKQrwk6b
        l9AcJmUWkNGG5OXdZUHzmpVndg==
X-Google-Smtp-Source: ABdhPJxmw8Lyteg7L9vr91/sVmTT0oKcFyXdZooemd+eaoTijRVlmPrV+x1ld9ia5WqmzhvcDcaOSA==
X-Received: by 2002:a17:907:d0f:: with SMTP id gn15mr660915ejc.195.1644572503756;
        Fri, 11 Feb 2022 01:41:43 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:83e3:abbd:d188:2cc5])
        by smtp.gmail.com with ESMTPSA id e8sm603196ejl.68.2022.02.11.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:41:43 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 4/6] kasan: test: Use NULL macros
Date:   Fri, 11 Feb 2022 10:41:31 +0100
Message-Id: <20220211094133.265066-4-ribalda@chromium.org>
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

Replace PTR_EQ checks with the more idiomatic and specific NULL macros.

Acked-by: Daniel Latypov <dlatypov@google.com>
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
2.35.1.265.g69c8d7142f-goog

