Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14DF94ACA9A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiBGU3w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242125AbiBGU1V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:21 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A7CC0401E4
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:18 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id cz16so14424765edb.8
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0o7uOOFR/F8wdFMHcK21ektAthAmrg4gw7mo/oxzd4=;
        b=W+jEhB6BQocffxsFNkW+QnIj1nMaeUqVvtmgY5zdnPDs+Nl9psIec7vViyEMf3K8eY
         AWEv/EFHjEuuMQtec0OsFSFAEEx748otMn9oQZ4FwkLpJrHKqLz4qMpEz8ccLJjAQnBq
         4PLvMgxVzPRNB78doQxoaq4QwYt00S4K2U78A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0o7uOOFR/F8wdFMHcK21ektAthAmrg4gw7mo/oxzd4=;
        b=PL3KyTokd6f47PYbVthxy3m5Wtpqey8wjdaXfx/4xQeTwzsa/xgWOW3u+2bVBPpVfh
         TsvyCux0ULiivIuQBt75xCik9zb4EbK71/j8LzCyZKn2zVpITbfBFmQT94V7ingzwhUQ
         cRssBG/kv7cU8Ctjwmh6ZyEpfaM9TeCKEymd+xCF05E7F22A9vaHNK5JXIFWndhFoL9+
         LafuiSV3j7kQYCYPg9uD+FTDv+JIOhfthU1c3WSe8Y0kIjNCMi7plaaSGirb13JyuIaS
         tCyh/FkZOlRhd66bqPLUY6nzsznIklhiLF9D3xsR/gmGIQ1gwHQHr7VC0Aj4mtUUvZNe
         R0ig==
X-Gm-Message-State: AOAM531ffBcRKd1y+0sOm1fRdMjSvxokpjEtcvuXtCoruMN/iQ34Iwow
        pa1rGcU0qqddgdugSUuTJMnezA==
X-Google-Smtp-Source: ABdhPJwZ01sfMnma+G/owZbNQQ6Vbx9u1iDGad+CJgUFIBxKxstM5jut25ZccIWAIp+1Sc/C/BmxZA==
X-Received: by 2002:a05:6402:1649:: with SMTP id s9mr1266085edx.38.1644265637064;
        Mon, 07 Feb 2022 12:27:17 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:16 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/6] kunit: use NULL macros
Date:   Mon,  7 Feb 2022 21:27:10 +0100
Message-Id: <20220207202714.1890024-2-ribalda@chromium.org>
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

