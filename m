Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3424AD813
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 13:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358115AbiBHLu4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 06:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237835AbiBHLu2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:28 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA3CC0048E7
        for <linux-kselftest@vger.kernel.org>; Tue,  8 Feb 2022 03:45:49 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k25so51016526ejp.5
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Feb 2022 03:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34ZmyfAhOEYAooNo/xPVmg8jgekAv0axuEgwIeZSupk=;
        b=VWm2iwcQQkpnk65R4SmtbJhKVg2unvzMEnXszek1LqS/doZylu/IDpFQZdvgLiwYYW
         pWHY9vi8CVqd83iGgSIaKS91N+vakWK2dRGD1WTg/SlBWDXbslVHHVE+OiixHPKErXAo
         YpAG91FdGfQvIf7PJZ/PKuuqYihmj1LkduWRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34ZmyfAhOEYAooNo/xPVmg8jgekAv0axuEgwIeZSupk=;
        b=OkhiPhxJA1hUG0Gr8OfAWRDQVWki7kSUTM/jMf/72G25hPzMelWEr9H43MZjIgnd9j
         tZeB1s0WURiuqg5wJ0qXni8cbGe38mpP9bx+WocJEcPRMm+qJ+Wio9tZM5IOtyJYEz4J
         AFHOoanw6bTspQXvXOW1VpNHTJwuRE5IyaIL337TKQ+QVOBB9KqYYzVwwNh64g5vrYgF
         xL95dOQ77BASY155ZLos4aYPs4tX10HVMF9kDPXbf0Thqf1Q7e1vuV3C55DCrbyYkBsc
         svtIqadk/0cbXwvoixWN+h6eUW4FlyraLuvUpzwpyPVUEeGXOoyWNeQM3gTiyKLq2XZG
         8R1w==
X-Gm-Message-State: AOAM530H6zyw/7EgYjD4C2LhGF5m2zrhNeV5OeZIWotjWLTBY2OEboON
        XiBPjVXFWLi2sMXPw9xk7if18g==
X-Google-Smtp-Source: ABdhPJzcIOqW4k13lO6xxbSRnY8WUE4J6Y9D4oo2fT5T0AbhgJTCz5acugMKk2ASIOmm0WpCivu35A==
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr3185433ejc.444.1644320748441;
        Tue, 08 Feb 2022 03:45:48 -0800 (PST)
Received: from alco.corp.google.com ([2620:0:1059:10:5d0f:d242:ddbf:a8a6])
        by smtp.gmail.com with ESMTPSA id y2sm4151902edt.54.2022.02.08.03.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:45:48 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 5/6] mctp: test: Use NULL macros
Date:   Tue,  8 Feb 2022 12:45:40 +0100
Message-Id: <20220208114541.2046909-5-ribalda@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208114541.2046909-1-ribalda@chromium.org>
References: <20220208114541.2046909-1-ribalda@chromium.org>
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

Reviewed-by: Daniel Latypov <dlatypov@google.com>
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

