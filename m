Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC964B224B
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 10:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiBKJlw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 04:41:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343993AbiBKJlr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 04:41:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D99410A1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:46 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id eg42so15508411edb.7
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 01:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rByTC1qdfOpqKBTw6wu+dL30l5MNIQcmECFcqJUWyKk=;
        b=VUF1ln/AaimYO2p+uZpOAdkRRPgWr9Sh9DnknjDBhd3HEVjL16nRNrdixTL/el2pXf
         jepc0KvxhRWBbiqlwmSakBTcqII73kF5l6JbxQGpswp9YNZWetVczfaJKDHO59rKgj2I
         TXrvFdygLdjXfVqpUY0QOM/VaskMX1udOQsfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rByTC1qdfOpqKBTw6wu+dL30l5MNIQcmECFcqJUWyKk=;
        b=MZmLDFiGmXNZYRO59lK2mS6tapy53tDHKQ1yw9JytqoM6tlgTZtUyZtrCOcQPNs5Xh
         Ki9fJvZyYl22dbI4/DpeA2pwY0Ve8jTxM9xw8gSL90iONu2qzD8vFkzxCYuZMBxdiXya
         39kwP4xhHwCOlv+wEO2Zca4tmjfeuCP+9mmgyaiPHOQQRCSQLICPUVPeY+4dGv9uDZn4
         eFbgscwjLsLfeZYJeTs8mXJKr2r17XEV18LfWZODTtkUItzlSFDnshK3668QhB8w19r4
         n7XepcjrE5DERx/1T+m8Sh1w4aV7zfA6PqtmGSAV1q+iAn8exqOQeOmJeu4PyO0AFp9N
         tijg==
X-Gm-Message-State: AOAM532TFKyrteOt/2naCOqwPkqgZ7q/HsErBiBrSV4risVGbeIeDXBS
        dcF6YDlvtvgD43Ktew547nfkOA==
X-Google-Smtp-Source: ABdhPJyRsu8tQUCFUT8m0bGKkxsBOwI472jS764nzrRwqCQ6vMEydON2X0JGJ2Nu7zY/Er1dso2Dcw==
X-Received: by 2002:a05:6402:14c5:: with SMTP id f5mr958178edx.122.1644572505144;
        Fri, 11 Feb 2022 01:41:45 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:83e3:abbd:d188:2cc5])
        by smtp.gmail.com with ESMTPSA id e8sm603196ejl.68.2022.02.11.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 01:41:44 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v5 5/6] mctp: test: Use NULL macros
Date:   Fri, 11 Feb 2022 10:41:32 +0100
Message-Id: <20220211094133.265066-5-ribalda@chromium.org>
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

Replace the PTR_EQ NULL checks wit the NULL macros. More idiomatic and
specific.

Acked-by: Daniel Latypov <dlatypov@google.com>
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
2.35.1.265.g69c8d7142f-goog

