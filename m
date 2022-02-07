Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5FE4AC8B1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 19:37:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233985AbiBGSgx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiBGSdP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 13:33:15 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36816C0401D9
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 10:33:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id eg42so16291799edb.7
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 10:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=LEDvpjbLxdkIAECgUtmhd0Pewx1MCYa0vTxWBQ5qOvlF9mxSP9MgL2WPumTTF76XQd
         rs/FWbPD/12K4cKHrCp40Q/xDzWkqd6ZohMpK2WRtXfeE7ZHVZFzkm38chEZFaLfZ+rG
         TuagRfezFAf5P9Iahh9BeHasERZJQdCttHLnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=3SgdITlnVZ8jDeYFwU38nDht0XqjaqZIXbIKGQ8go/HAZVs/deu2570ZHApHXYI4JD
         LsMjGTZPLr6ATKBJiP1+QgOOpcaEMizlHz805p7nAZv+mAohxRg+I4ro8aXA1WoVbdNW
         PuLKCtKsh9jVUEKDPvufC0YJvosDVW9iTVFRm28e/WCRdYTzPMcuQTJxHHoAwIws4LB1
         E9+2wsGLEz8Kap/NpYxeH+ogISk90LxUuaTTAF8AivmrIakRjv+Zm6rTBBEtOQ61+FQ2
         4+UbI6VQxs0Y9W9jIzhSxHv/b8wYhM3n+wlGaczaObRCA23Fko6TzIEzIiCMCiXGLNqW
         OvEQ==
X-Gm-Message-State: AOAM532VDcA6S1qJoa9XoHKYq3YlVx3O3q5ehSNjLonx0Bu4Pq7nHuBv
        0S9Tr//vOMnFiNiL/Y6NNBYo5A==
X-Google-Smtp-Source: ABdhPJyYpPuIcCeeyxuf5tTwSyQd8EC7oNpXtyv9AK75BOvAZ9VzgGG58uhyr6gisCzTKM431Calhg==
X-Received: by 2002:a05:6402:2789:: with SMTP id b9mr784253ede.308.1644258793829;
        Mon, 07 Feb 2022 10:33:13 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id k15sm3045173eji.64.2022.02.07.10.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 10:33:13 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 5/6] mctp: test: Use NULL macros
Date:   Mon,  7 Feb 2022 19:33:07 +0100
Message-Id: <20220207183308.1829495-5-ribalda@chromium.org>
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

Replace the PTR_EQ NULL checks wit the NULL macros. More idiomatic and
specific.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 net/mctp/test/route-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 750f9f9b4daf..eb70b524c78e 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -361,7 +361,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 	} else {
 		KUNIT_EXPECT_NE(test, rc, 0);
 		skb2 = skb_recv_datagram(sock->sk, 0, 1, &rc);
-		KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
+		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
 	__mctp_route_test_fini(test, dev, rt, sock);
@@ -430,7 +430,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 		skb_free_datagram(sock->sk, skb2);
 
 	} else {
-		KUNIT_EXPECT_PTR_EQ(test, skb2, NULL);
+		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
 	__mctp_route_test_fini(test, dev, rt, sock);
-- 
2.35.0.263.gb82422642f-goog

