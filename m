Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4354ACAF7
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:11:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbiBGVLu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiBGVLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:11:49 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2218FC061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:11:49 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id o12so45856629eju.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0o7uOOFR/F8wdFMHcK21ektAthAmrg4gw7mo/oxzd4=;
        b=U0xYQyzv+kTO8AxuwNmKVI711i0//ZIA4rlpwh5YZqDxAgPPG+JsT4ApjgR6Lq2bJe
         BTHwmQ4nLGY8ZOumMCWp1uA1mSRG+y8XhabBVy7uIF80LNrENJjadW8peuZzKVH41gQn
         JLOTjd/JdSko0qgzeJU6BPLU0YQtjmtLhCNpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0o7uOOFR/F8wdFMHcK21ektAthAmrg4gw7mo/oxzd4=;
        b=WXI3mC5XVYbo7BrQzPlVJgbekHogd6rR5mE0kZMcz+rtEXiSXiJcaqhVEEWro+OZF5
         Lp8ZOc61Stjxuu2pCnMFyWAD2x13UruT9jI2IEtUTlQ/hR/RwQnmDS8pdd+wPWMVl14H
         +RxgErWk7Q0ucDsEAYNzctziFQQZnWL8Y64N6lECq8SeB2lBRveCnRQy1IacAuc4IQZL
         7OeDxTtuDBPA7sPxrDh0bxjIQm5ddNsO4shy1xumHrtqiUnCNednXiIP5p+aoCTFKhWs
         8T3dKdr5muA0I6M3NU1zSMUETaviLhwpaZnde3ci4LgR7BhblrVo7w45AOgwwd0Fn5y9
         ES1w==
X-Gm-Message-State: AOAM533OvNLqr13nXIciCkS2tItzeF8V1LkNT8XlJjYLEVHnxUAJ6VtR
        5FR7xIWSojQKcBylcTjSRVgYfw==
X-Google-Smtp-Source: ABdhPJzIOlYxpeRo6e+vj2nxgC+CGS5+/j095dIT0xN3XNqyTf4BaeJgQfpGRTFa0n62ezho3NWJvQ==
X-Received: by 2002:a17:907:d28:: with SMTP id gn40mr1252294ejc.750.1644268307679;
        Mon, 07 Feb 2022 13:11:47 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z4sm4047239ejd.39.2022.02.07.13.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:11:47 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 2/6] kunit: use NULL macros
Date:   Mon,  7 Feb 2022 22:11:40 +0100
Message-Id: <20220207211144.1948690-2-ribalda@chromium.org>
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

Replace the NULL checks with the more specific and idiomatic NULL macros.

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

