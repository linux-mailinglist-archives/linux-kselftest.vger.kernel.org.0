Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C844AC8B3
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiBGSgw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240875AbiBGSdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:33:15 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A671EC0401DF
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:33:14 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id p15so44721579ejc.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elxmE3zs5g2Y4x1nlwNY1X/XBfQO0VsIOMiC0QvhdRs=;
        b=ib7OInvnGb1390rQvsxx41sBLDlYlnymqB0W0z5ewFkH7jX1eD7AhbpgqSMOyBYVpB
         DLEad2S0PIUl8kXzhHS/oLN5pUStvOM0WPsxQeQHfedN29gpnGMXXeoh384vDq6//n2G
         RyjMwFGldPpDN29Jg+T3JflHK6vN4HiODJMbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=elxmE3zs5g2Y4x1nlwNY1X/XBfQO0VsIOMiC0QvhdRs=;
        b=ofLzYhSr/1IMmomboPphGzM0Tpu3504o26IZeOdH73mKGiTD5E/mVrODUMYN3zmBaP
         j4cd4HYgGCt2UE0cSH0Xl8xRpXBqS+de6SWxKLiD0KPyRTFlt3KvozVt8HFdSMXQHJN7
         quxbmMWoXGv6TwXqA4jR+5y2hs0fEZcZ1JPxzXWKsiWtEzVpXZ+Aw4LOulUDriJdEwTa
         9nr+rK3SHq+AMI5uBXRdbzEA5dJmSEp4HZZdzyzgSP5ziAxuigozjFihvX5Y+2QkjDOt
         ZaIOJ5kVNvyj1sEoXp/WXnnWC3uhYE4lmS9t7uZg15734xuj4tx0/265x6v02cfUa3ka
         Yv2A==
X-Gm-Message-State: AOAM533hD6vhXttOu/5M/pDFnprhcTf059Z+Tp/VVIbfU0R2Hc6mjaed
        CaKIgdUBi7dFvPdSRgvKF7s/BQ==
X-Google-Smtp-Source: ABdhPJx2znfkJdWuVEfTJQm+QwhAab9EmEa5PLUcvF/yiqLO7zPWj6QRIx5XFn0ngzxpPzD5Fv6lpA==
X-Received: by 2002:a17:906:9756:: with SMTP id o22mr807187ejy.448.1644258793323;
        Mon, 07 Feb 2022 10:33:13 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k15sm3045173eji.64.2022.02.07.10.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:33:13 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 4/6] kasan: test: Use NULL macros
Date:   Mon,  7 Feb 2022 19:33:06 +0100
Message-Id: <20220207183308.1829495-4-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220207183308.1829495-1-ribalda@chromium.org>
References: <20220207183308.1829495-1-ribalda@chromium.org>
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
index 26a5c9007653..ae15f7bf7313 100644
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

