Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C04D4ACAFD
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 22:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbiBGVLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 16:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237189AbiBGVLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 16:11:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDC3C061355
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 13:11:50 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m11so32920774edi.13
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=lWY1yE5wKIASyJXgtGCgxLDElV3EV9DhpYy+E74+cnAetZntpYULRFkbvx+R2UxRnz
         lauGL1CZLWU0e9MF0/4SlyOe7TQNJx21RsojfcLNJbQjV5LfQQ/RxLA1eE5RigGKsKpv
         9ER6tRfe74XHVh9IiqJMuZ2BKQVbPw6aA9hpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=YL3kjFjpEKGksWgDLoeN+lCNJf1U/91iUaR+NyETNt7fDjNQL/WpDxu0rdmGXAG+iF
         LAoiN6qqD6EIoaTsFnZtTgtfFKrciCWKX2hyxTCRcWRdSIzozz3jX1sw57rY/LdyMg27
         0AXNsE6oJxnkuBe0d8y4jGihBZFbZNCwUO7KLW1Q6JXmz8sA+5pkpLZ/vV37ZEnTKOB5
         tH4CM86WrpaIubPYctIIW4Wr7rI11oVC/LhjIPF1GIXwoCwV7ItLEm8kbw5msCIkTCVa
         julxz7nZRc0XrdvDQMdNd5v48gAf+WjuKhUaw0iabpJ77eMwxEMcpZDBZ5JlRWPxwjO7
         bsSg==
X-Gm-Message-State: AOAM533/fjlFI19iLHW3GvDbgF5C/pHa81/VBMczfWxmVW5LCAM0yKR5
        4fk7LvwUot+t568wHwzdUi51mA==
X-Google-Smtp-Source: ABdhPJxB6/NEBc9T8A0bEWo+axzfycLTCqlNLFeJ4YTCMjs+Eg7lGH+YWgCZj33xHDxovYuIf8ctMw==
X-Received: by 2002:a05:6402:1651:: with SMTP id s17mr1370551edx.0.1644268309509;
        Mon, 07 Feb 2022 13:11:49 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z4sm4047239ejd.39.2022.02.07.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:11:49 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v3 5/6] mctp: test: Use NULL macros
Date:   Mon,  7 Feb 2022 22:11:43 +0100
Message-Id: <20220207211144.1948690-5-ribalda@chromium.org>
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

