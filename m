Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9924ACA99
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Feb 2022 21:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiBGUaH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Feb 2022 15:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242227AbiBGU1W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Feb 2022 15:27:22 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E7EC0401E7
        for <linux-kselftest@vger.kernel.org>; Mon,  7 Feb 2022 12:27:20 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id y3so24771786ejf.2
        for <linux-kselftest@vger.kernel.org>; Mon, 07 Feb 2022 12:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=VSeSAlio7FB8hddPjGhLo211NvE6XCzT2LJAV6ROiWEcOAh1BFQUqKifxX2sEs+B25
         MIXekCZe5nnABXNv6xIcR4wPDTTF3T1wzvBV7MyUmkkPvKppiTouxzBiQOHNSuIqKNWj
         9mAqOGqzlNkebYwxR/AUQjOT7Io2R7FNlZQxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COoBb1joui25djaKHvMRbQv4Mt4Thb8VpuVozeRERCg=;
        b=n6+1hr2pbnEKsCNOqQZykCdNchhRFshCajNg6U5IxTacjyEOl6Ux6ZaO/KyHMn9zQO
         o13m/1CKrtr8lHWbJRc09XzGa+TLMWNBqTuW7akJC4STO+duTwvreqQOgfVqZD0rLawT
         TTUg6zLqRGhTEzKxse9NpOS5vgxBHcNtMQChQC0DgOiW85CnjLxCiQ+59wUr3FYBV9NQ
         GV1SmHxmhAyEjo3z3ef9QCIxhiCdOefC9w4DPI2BX2HZXIbx7zgMd/ZcUPCDTdyyYIUM
         6TNGqghaBk0+gow+p20ZwLRjC+Q99tXmupQfVVh/fILe1iA6OniB5JSckBlVPeRhMZaS
         eMmw==
X-Gm-Message-State: AOAM531vDUPrBJePnWgXT/J6RLHyPN32dybA2c9zv6AwOcps6lvmYC1m
        wD1BAMLK42ywC89Y4AI2OqoJmQ==
X-Google-Smtp-Source: ABdhPJwxq5vsBYIvCeuX1CSIjGLgWBnKzjKg/K3tRDOOPsLqZxt6IT8qorePca+E3sURcJzbRWBInA==
X-Received: by 2002:a17:907:9494:: with SMTP id dm20mr1097662ejc.148.1644265639140;
        Mon, 07 Feb 2022 12:27:19 -0800 (PST)
Received: from alco.lan (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id t8sm787893eji.94.2022.02.07.12.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 12:27:18 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     kunit-dev@googlegroups.com, kasan-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 5/6] mctp: test: Use NULL macros
Date:   Mon,  7 Feb 2022 21:27:13 +0100
Message-Id: <20220207202714.1890024-5-ribalda@chromium.org>
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

