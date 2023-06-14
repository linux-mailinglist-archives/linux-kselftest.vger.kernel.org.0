Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A63D730090
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jun 2023 15:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245215AbjFNNuM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 09:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245160AbjFNNt6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 09:49:58 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B26106
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 06:49:57 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88E5C3F18A
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686750595;
        bh=dSup0f5kCS3Ke0llFgGmW4NslSBs3lKdT85iJBIkPU4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=ov5a/ARCw+ifdLqGjcp0Qw8eJWxM7OZnUI378YCRwa8ZU2n1DUhuACD0lL0ZLEjfi
         8ZvqBVJBwLnvCv3O6pjLCG7qWLUyFbAERsuVcXcPHpdiUoxdanZrKWOLqQa8qlq9LZ
         n4I8ctJzoVZO/FDfbaVpH9htq9JZxlEF9Kqo6x6bXhAzgRYolJJzwGajL4RuDLrkyM
         RQTCRtycAPbyfB//cG/5xWja5Px/FjLOXtc5V7x2jS6BWY9+VqSJfYXyl46iQv4ptv
         yYp9AKW9+zD+9plq5XaEzvO4o1J59bkShu73kUB3L6pUfGFR0gCSgk7mepudKNmLWp
         VHjjtj3uRCu2g==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4ec817fb123so4812303e87.3
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Jun 2023 06:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686750594; x=1689342594;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dSup0f5kCS3Ke0llFgGmW4NslSBs3lKdT85iJBIkPU4=;
        b=jJ9JnHqEISwPTbdiqxlQXwM0VH2zzCGrmHWKj4wTDuqf1TkSEseBGhGwu6LzV5B8Rl
         o5APKvYOjPo8F974rHqel3Oy9SEP2JH0sIPfrAH2+VYM2qhkLF2WXBulZUGrjEMyPrrX
         Km8YaCx5LdbgOSRFqcam224LYIkaaFZF1V1gwoMu7plrnci/m0SpP/eJGv3wUCAESsop
         NAM+ud+rXtK4jxc4E+AEcXVp3veutWjDHvI/Fir1GzxfwGYjBOtWKOnNAV/C6jrl2+jY
         DOv+TixBgmQZLjrOqEpkJ10CEOnFDp14Q/7B1tCbGianK9k0PRY1LkTdHQ3WpiwkgHKl
         CoRw==
X-Gm-Message-State: AC+VfDwWzLI42WEY2QgzVS0KQyQ2h7U9OP+BCeLXn4mE1Z+4HArxoPei
        /ILNA1ieiX0kG2CxHsJMaf+qaCOT9vG2uV5u6d5c8FE12/Zr2W8YS6y6XCfy0coeYg5krr7m5cg
        bbEZNYN9zIOIBkZcEjwkKHtmRas1YrEwltT4TmO3B5RGjNSe3KKr/bg==
X-Received: by 2002:a05:6512:290:b0:4f3:a71a:9e5f with SMTP id j16-20020a056512029000b004f3a71a9e5fmr7852564lfp.65.1686750594462;
        Wed, 14 Jun 2023 06:49:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4nzu5zaruZx+Vpyh40rOhg82SYK1kq2tNvIdIT9O3Qm04le/l81dKpsYEIlFbH7GYyQ0iWfQ==
X-Received: by 2002:a05:6512:290:b0:4f3:a71a:9e5f with SMTP id j16-20020a056512029000b004f3a71a9e5fmr7852548lfp.65.1686750594145;
        Wed, 14 Jun 2023 06:49:54 -0700 (PDT)
Received: from localhost.localdomain (staticline-31-182-251-115.toya.net.pl. [31.182.251.115])
        by smtp.gmail.com with ESMTPSA id a29-20020a056512021d00b004e9bf853c27sm2115735lfo.70.2023.06.14.06.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:49:53 -0700 (PDT)
From:   Kuba Pawlak <kuba.pawlak@canonical.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: net: tls: fix no_pad
Date:   Wed, 14 Jun 2023 15:47:47 +0200
Message-Id: <20230614134747.329194-1-kuba.pawlak@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tls:no_pad exits the test when tls is not available. It should skip the
test like all others do

Signed-off-by: Kuba Pawlak <kuba.pawlak@canonical.com>
---
 tools/testing/selftests/net/tls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e699548d4247dd57555a72ec1627566962128f73..ea3ec8463df993d80f0b70c4632b2a1e3c57b424 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1727,7 +1727,7 @@ TEST(no_pad) {
 	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
 
 	if (notls)
-		exit(KSFT_SKIP);
+		SKIP(return, "no TLS support");
 
 	ret = setsockopt(fd, SOL_TLS, TLS_TX, &tls12, sizeof(tls12));
 	EXPECT_EQ(ret, 0);
-- 
2.37.2

