Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDBA4AD7DC
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237835AbiBHLu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 06:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358577AbiBHLu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5DCC0048E4
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 03:45:46 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cf2so20800837edb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 03:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9VMyC++vTek0pyoJ8XF9UlZhDAZzB3BunnVOUcavb4=;
        b=nciZK8XK4HXTyA2uEuWZvJ+pWcv3aYHI4EZugGz9baKykiUndpsbB95GbrkZXVF/uR
         p6erRfH92KQ6Xiz2aQPoFVjc/gifsOlXJeABKp8kUdmaPsaSEYgU6q6UMADWfGy/1iV1
         97i9k0WAi83kE/EO+vbxSp+LWXshLscK2zA2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9VMyC++vTek0pyoJ8XF9UlZhDAZzB3BunnVOUcavb4=;
        b=ISXd8wBBV4ac22EO8IxnZd6rC5xr4fAAFwFqEjsd/sBDt5WfDgOIel9scdNQymZxZ8
         gHQzp7/jNVzDVR/gSq7hTyu1kl6B2/lLvpQR7otcDw6lZx8zJwQvfp2U1jDHlHajw84I
         yUjTR1rgS14914Oi8pZ9wdYfxB4f80IpwjrVgpTfkRvojgzpMHigjjl+2iVpbwQdUCmG
         dlpVcuPQbq24URyz21UQTsr0WGtW4JDsCLn55AJVQOE1QnSHokiug72HHezH3mMZcUQT
         sAZVBRj/Gg6nrPifn25S3i+0v4MMK60iN5XFsfX7wI9L5LUR5zyLRtgWIBhQZLI555m/
         HkNA==
X-Gm-Message-State: AOAM5326jS6qxnO7QHlA8Ld7/3oUpi/VatJG1ehjsFAoCHDah6Q8dtdJ
        dBXWDvOZ/l35vVqA8o63yDdzIw==
X-Google-Smtp-Source: ABdhPJz6AhsEy+rzQLutQdQWcpK/sR/MMayVMdMO8tAjY+Rg/bj0fcXlH0BdIhEEb5+NVSh0xreEGQ==
X-Received: by 2002:aa7:da51:: with SMTP id w17mr4111043eds.8.1644320745410;
        Tue, 08 Feb 2022 03:45:45 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:5d0f:d242:ddbf:a8a6])
        by smtp.gmail.com with ESMTPSA id y2sm4151902edt.54.2022.02.08.03.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:45:45 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 2/6] kunit: use NULL macros
Date:   Tue,  8 Feb 2022 12:45:37 +0100
Message-Id: <20220208114541.2046909-2-ribalda@chromium.org>
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

Replace the NULL checks with the more specific and idiomatic NULL macros.

Reviewed-by: Daniel Latypov <dlatypov@google.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 lib/kunit/kunit-example-test.c | 2 ++
 lib/kunit/kunit-test.c         | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-test.c
index 4bbf37c04eba..91b1df7f59ed 100644
--- a/lib/kunit/kunit-example-test.c
+++ b/lib/kunit/kunit-example-test.c
@@ -91,6 +91,8 @@ static void example_all_expect_macros_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, test);
 	KUNIT_EXPECT_PTR_EQ(test, NULL, NULL);
 	KUNIT_EXPECT_PTR_NE(test, test, NULL);
+	KUNIT_EXPECT_NULL(test, NULL);
+	KUNIT_EXPECT_NOT_NULL(test, test);
 
 	/* String assertions */
 	KUNIT_EXPECT_STREQ(test, "hi", "hi");
diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index 555601d17f79..8e2fe083a549 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -435,7 +435,7 @@ static void kunit_log_test(struct kunit *test)
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test,
 				     strstr(suite.log, "along with this."));
 #else
-	KUNIT_EXPECT_PTR_EQ(test, test->log, (char *)NULL);
+	KUNIT_EXPECT_NULL(test, test->log);
 #endif
 }
 
-- 
2.35.0.263.gb82422642f-goog

