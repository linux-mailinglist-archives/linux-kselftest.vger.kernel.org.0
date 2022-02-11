Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4E4B2AB1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351624AbiBKQmy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:42:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiBKQmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:42:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20F5D4B
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:51 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id g7so1338030edb.5
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yxy7zthPRWHub+MPiGJfuPkSoZH4U5JEJa8lsfSBR/o=;
        b=lzPfOcHoLZ/MvAabpJ9+1KHNRqERbZ9ViET9utyITXE8KWzeHk5oIeKmMoB0JCzXfm
         WjE738yEIaQBcJf2AdwEHYaNko+xo3KTQX+r7maDKtXmDkD6QPcFYY0SwRFn/cudLoI9
         mkLC68XUZMQo7Qb/T9lbpOdTqnq5/3NAtONZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yxy7zthPRWHub+MPiGJfuPkSoZH4U5JEJa8lsfSBR/o=;
        b=XVlEff5xtQPJxyTfYLGvKyztQ63Q8ITw2Ap7Cxbj7rtaQELC8+49LcH+FI4Wa9A8P4
         +wxUZmdJ4P4dgfxvsMNuiE72QHCDatEPvSUvkNdEBRGFmhAxP7EyNy3lG/tsM+0bnBRt
         D/KnhQS/ALBL9RA1uabMoH/uh9kc4ylXm7uZJd0+ohrZYKhSht57L9O++F9z2P1PG37T
         LXFRYbazJ2oLbdl1b2gC08W84ritImf9CvkkxIAQ/ZYNOOLCubJNIy7aFjtspBZJvZre
         xyoVJRqqAtOWrw4wSuvnQjvp+sL9y0osdA8kPlJnAp6pdT/EkgIMJK0Ez3sZOiJ0rUac
         X3Uw==
X-Gm-Message-State: AOAM530WyLUZzvfaAXlRRlKP1YmfG/5HpdUbLX7EUMjEKErGUYyejaII
        gJP5RTMojIVdvvs24oHh4U7Txvx82NOK26+N
X-Google-Smtp-Source: ABdhPJzOjFHIjOptbXcHITdtxZD2BmaLRrRvZ5js16yJdezTSXuHMvUn/ik1AmIE0i9siNCsjTMHZA==
X-Received: by 2002:a05:6402:27c9:: with SMTP id c9mr2876049ede.178.1644597770279;
        Fri, 11 Feb 2022 08:42:50 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id i24sm4981233edt.86.2022.02.11.08.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:42:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 4/6] kasan: test: Use NULL macros
Date:   Fri, 11 Feb 2022 17:42:44 +0100
Message-Id: <20220211164246.410079-4-ribalda@chromium.org>
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

