Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A614ACA9B
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbiBGUaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiBGU1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:22 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43CCC0401E6
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:19 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id b13so32687325edn.0
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KXm+9Zz7kQqt2EFBwAfIC5XooSw7CB+RPRatZ+DKukY=;
        b=NlftQC1QAC85AVhg4e70haxCay1d5UaQ/sYrPd/Ykn5T4wsxmaS8Do2qnK4qoD6W8Z
         7bQD4HbOh1JjJq2JbX3e+Vbs+W5y69+vEEb2Eq7iOECqiuIyVcl5Ivmo6cAJ/Wnx7tPn
         ETFG7OFiwue6SqY00x8m4JVuHsRnXituauObc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KXm+9Zz7kQqt2EFBwAfIC5XooSw7CB+RPRatZ+DKukY=;
        b=6EeL5jouzWkjD7MzmDkY+f5KcbFrgjFuVK+ytjsdrbJj70r/1EnYt/7sHRx+KUrpGb
         qji+z++6RM4m1y3pzAVccopFyLHGvYVC5mEF+4MDDU3dQYfxkHbcpUUiMVVCLtMHPs1o
         QrNcwQmVr1fCHl7a+1d2hkBUj89QxBSbBaTuj6WZRjsk/m7YFebm5ZW8ErO7+lPEy4w0
         csZeTZpAYVFEA8sTCrOaKzUIzamIKWNBS72HQOf0wNI1l2MEC7eltW/1IQ7CfwMZCIMw
         wgQl2LBbeIWFDYbEfA4nl1WDtDZVi+0wZH2/pngs/NBZ6/lUMGTUfYuUDbu6205qSjax
         qreA==
X-Gm-Message-State: AOAM5303xgQoIO+RqkCk/sTlPRtVAbv+TY6i5XTWsmEiwBCdLC4wY/QU
        kGvGTud6tV5ynomaPpxL9L8BCA==
X-Google-Smtp-Source: ABdhPJzlqQ6oN5LMYSCFOI0DUJfg+KXi1o6eA0wp31mozViPZLaZguKm6kPaK/6AZvov5UeEuUs9MQ==
X-Received: by 2002:a05:6402:448f:: with SMTP id er15mr1246579edb.222.1644265638490;
        Mon, 07 Feb 2022 12:27:18 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 4/6] kasan: test: Use NULL macros
Date:   Mon,  7 Feb 2022 21:27:12 +0100
Message-Id: <20220207202714.1890024-4-ribalda@chromium.org>
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

