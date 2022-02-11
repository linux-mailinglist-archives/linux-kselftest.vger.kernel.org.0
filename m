Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C23894B2AB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Feb 2022 17:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345874AbiBKQmz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Feb 2022 11:42:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346048AbiBKQmy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Feb 2022 11:42:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8CD65
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id fy20so23964977ejc.0
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Feb 2022 08:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rByTC1qdfOpqKBTw6wu+dL30l5MNIQcmECFcqJUWyKk=;
        b=Apm/1Dcq04AOQP1nf0sM50YTxPSNKPphcmBwPtpFYqyf48PIpexvySpft5eC4s5CQA
         ae+uVMZ8qnlg2VP1Y+JiUUO7VfCItetgHqc7crAJHon7uUOj8uMWTEFkDKnRch2Yb2lb
         7Uoujn7i2r1YGrk5IHyCN2Ks955cOItQA4pyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rByTC1qdfOpqKBTw6wu+dL30l5MNIQcmECFcqJUWyKk=;
        b=79IUEGCP6ZHzvcNwcLHmx8YUHictEOXLw5HSPpp3q6TWlKZg+weY/j5Ml3BWSJJeIn
         jxruigDHF2vGrJr386s3DdqiBM2oAG7N0+b4/Y+tC7tEWcbWSWSXeFBN1l7oerBh4Uz7
         MBCDRRfjq2k4apSUi8qIs58H9kwuxLssHPW0BNXr9UJF5aw03rLUQbezZ8zkQl3usj+e
         LizTCq4ErnquTSgNgkIj8P0JhXPdGb9jYvon6ku3GYxmWY8EzEbF8DsOAxyIMzdRU9ui
         IN9pYbLvB9MKQbcZ5plcoFCatcgNkmfBdZo+FdDjVcHFgmoINbY4dapuecpO4hMvcfLY
         bm1Q==
X-Gm-Message-State: AOAM533Sw2JdZsaoqLK2HQ0nIR9ICOGXJ5hqM4LaPvn+FXHobEykHuGw
        ZwxgyZJVoBVj+x9cH168fHQB9f9EjYL0mG6O
X-Google-Smtp-Source: ABdhPJyghpl0kmsPlbudSlrl9sXyxv6+Gp2dtQpTLg38O5ChSt/cIhmJazsho7PPlnjZmCPj5bWvwA==
X-Received: by 2002:a17:907:6e14:: with SMTP id sd20mr2085294ejc.749.1644597770859;
        Fri, 11 Feb 2022 08:42:50 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id i24sm4981233edt.86.2022.02.11.08.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:42:50 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Daniel Latypov <dlatypov@google.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v6 5/6] mctp: test: Use NULL macros
Date:   Fri, 11 Feb 2022 17:42:45 +0100
Message-Id: <20220211164246.410079-5-ribalda@chromium.org>
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

