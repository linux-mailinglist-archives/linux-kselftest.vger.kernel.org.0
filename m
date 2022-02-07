Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111F4ACAFA
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237161AbiBGVLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiBGVLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:11:51 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48EAFC06173B
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:11:50 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id st12so21018362ejc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXm+9Zz7kQqt2EFBwAfIC5XooSw7CB+RPRatZ+DKukY=;
        b=H6UeLb8yZqR9jOkJrN80o+pROs5hO0lXcYjp43FIQuc8v+aPr8Fy2g9iOBdAcT6OWW
         QkQ0y2UDUhGSaR+47VsdqnV8sf9P4ejnSmpqIAZOsT22v7Op3pjHLrhyEnR2vLb2jR4v
         NhQlKuXq4fe9vauUGMvLZPCm64w42L8iWcq2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXm+9Zz7kQqt2EFBwAfIC5XooSw7CB+RPRatZ+DKukY=;
        b=taVZ+VcUFX2jADl4T1Ixswb6ioWzo0r0ldTlCRxn9bO17ozPyi0NDn800ZFPHxB2Yx
         OZ2qbV7e62nHCKCm1fdfogJHLdY+nSqBUYYh5pdCGZpkSZPA1SpRT/Sq+I2O5rIUrGxr
         DRZSHj7mHlLKVcj49POZVkl9PxIcjW//Qzk2ar6J3JOMC8sir1znpkyONxsB/+Yhm326
         8oQrohDHbRxK2bllfjmUzn3v40Hhd1SsE4dkLT/L4YWxMoGtKYrJjxX34uyphD3nSmf+
         yzjuJXRfHgPJ/nBCqXha0oB7CO+lxN0hMpLmBLfJD/4utNcQlgsU1f6gv8EAu/lLJO+8
         B8wg==
X-Gm-Message-State: AOAM5308jYJYVakRBsA55uQcKQymSlJj9GhGCzu9Pik7eR/cPkh9YXuN
        j3txEYmC3/FYZrFACPJ8JsOzMQ==
X-Google-Smtp-Source: ABdhPJwVQfsNeDOoZGt41vt1TJLkuPwEZwTOBJRKwfK0nwJ2H+LCaq9HbnBgA4KACqPHq67Er/g/ag==
X-Received: by 2002:a17:907:3d92:: with SMTP id he18mr1176037ejc.597.1644268308882;
        Mon, 07 Feb 2022 13:11:48 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z4sm4047239ejd.39.2022.02.07.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:11:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 4/6] kasan: test: Use NULL macros
Date:   Mon,  7 Feb 2022 22:11:42 +0100
Message-Id: <20220207211144.1948690-4-ribalda@chromium.org>
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

Replace PTR_EQ checks with the more idiomatic and specific NULL macros.

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

