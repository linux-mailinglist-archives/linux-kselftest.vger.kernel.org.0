Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BFF4B2AAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiBKQmw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:42:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiBKQmw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:42:52 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78452D65
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id bx2so17313822edb.11
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne9bnxO4PK4jt9C/gSl+PDTM3EheSheXGE0rb10tDic=;
        b=eJVH8qawyVTBLCSWPWiGRU0BRG5bChJSOS86AFKUmAwQP28wio8kX3AvbIQDYMxGea
         OpbC9YsZnavJCmJUFvHxPjia5MQ9L/V0DtN0HmsiBRuZ2tb6gRODPFKa4HpZSobNW1DK
         hpa97d+1DkBz3ze/babCdiw+mYbKLMRt8Kij4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne9bnxO4PK4jt9C/gSl+PDTM3EheSheXGE0rb10tDic=;
        b=VNOfgwT5KbS+HWOq+SgRwE9ubdRxyz4LRMvOGN0aZm4MaLRncICcq/KWvA3EpZk2U9
         6T5cFaIyYpYktmRhFF07zHsIm0arW/nwMrV1nyAd6UlCiL3HY/+XS8SYzUEr8ai2YKn6
         XJROVIr/UkLN1ObZOCFKumyXQA4CPxjfPbv/fCeytOmwC6RiDN0Gy/H74gOV3aJbfiJK
         Ra1fU1ysIa9xLT8p05Pl/+1by2auhlH3KUzsMKsmyxMtMa1eu3bruvY98EtgJW8f+ymY
         eLs0jrfpNpSEKl28pQp0TI+tO3KRK1KvPHyIZCDz90+FQ0PoPgBt6kTZrWBTyVB38I9E
         XCZw==
X-Gm-Message-State: AOAM532H1EStN8YTvcUIUih6rgBY6+KLVTwNEpj4NWt37WZvzu+PDTRE
        h4HDzFNmS5hhAbw+fNduxAwI1w==
X-Google-Smtp-Source: ABdhPJyEK70H5tG8606Z//huqYZksMdOT+gUfcDtP7gw9as16sSq0mkvRiF4OyU4XyFil4PXQBV5WQ==
X-Received: by 2002:a05:6402:34c7:: with SMTP id w7mr2808333edc.397.1644597769058;
        Fri, 11 Feb 2022 08:42:49 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id i24sm4981233edt.86.2022.02.11.08.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:42:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 2/6] kunit: use NULL macros
Date:   Fri, 11 Feb 2022 17:42:42 +0100
Message-Id: <20220211164246.410079-2-ribalda@chromium.org>
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

Replace the NULL checks with the more specific and idiomatic NULL macros.

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
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
2.35.1.265.g69c8d7142f-goog

