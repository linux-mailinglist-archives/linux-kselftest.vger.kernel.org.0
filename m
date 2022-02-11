Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474ED4B224C
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 10:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344381AbiBKJlr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 04:41:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiBKJln (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 04:41:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB810A1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:42 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p24so21659449ejo.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ne9bnxO4PK4jt9C/gSl+PDTM3EheSheXGE0rb10tDic=;
        b=ax9bjuve6BrNMkQSSXctiM/dV+eL1/lcbDQ84T6r66QJ99CkuEmyUO1llnabtnQcXL
         SsZrJC8bH2va8mntZb2mcCcbzr3ooLw0YYNziKlXyqK4CIxba/igkLsl6iWGJQrXnNEV
         k60hzLDXVlHKxAkkHH0CQOOe5He+wTYtibCWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ne9bnxO4PK4jt9C/gSl+PDTM3EheSheXGE0rb10tDic=;
        b=AZkNpTQpF4z+EFpLJ58geiqWQ1E8svBGV0CN9WDZywEAGGsNiivhKgEx2z2bFTc8SC
         i0VUKbOj98m6p9JQwRlsnAlcAxD5Ql1QE4M5seVujMnXIvEbCM+tjc1p+Jm4WyUzD6nZ
         xOG7vCJm1E9ozn7D9HVLd5+4FDUP1dHjkYJUW4Hg90WwGRIIrZofYM+mKXnQGsfG2XMA
         c75EwIVpJH/MwveClt5IZ9WgPAGg27h+iTGNNTK/xtc6tOyefom2iVqI827eZ+vDz0nZ
         YOK5SdoTZHEh4T31/sE1/VSDgbR1Skj2zTZH88QvLJrf7mKkNRcB5tkWd+W1xai5eKlG
         35DQ==
X-Gm-Message-State: AOAM533xZCWvgoyyPAtQGoed31wny1ljkYcjoHqIHRZOVOdZ6V2qAZAe
        J0hHVJV+U6RQiycdpcbPf8uGdg==
X-Google-Smtp-Source: ABdhPJwfmsiZdlDqcJsXTagGpbGWkcbSlCWsVHu2QBkU6D78ReN602fp7vkB0QIoNwVMvo8alBygzA==
X-Received: by 2002:a17:906:1d0a:: with SMTP id n10mr656306ejh.143.1644572501424;
        Fri, 11 Feb 2022 01:41:41 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:83e3:abbd:d188:2cc5])
        by smtp.gmail.com with ESMTPSA id e8sm603196ejl.68.2022.02.11.01.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:41:40 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 2/6] kunit: use NULL macros
Date:   Fri, 11 Feb 2022 10:41:29 +0100
Message-Id: <20220211094133.265066-2-ribalda@chromium.org>
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

