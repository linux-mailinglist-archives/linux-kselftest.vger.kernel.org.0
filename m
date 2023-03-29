Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D8B6CD689
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Mar 2023 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjC2Je3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Mar 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjC2JeS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Mar 2023 05:34:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B83C10;
        Wed, 29 Mar 2023 02:34:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so11020852wmq.4;
        Wed, 29 Mar 2023 02:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680082453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f5L2cTIuCdaJiW3kAEBYG9/8fNy39SDv5isWb6sXKGM=;
        b=I+fC0ydL01GfwIBgvIYgnfsZcoBEBUXq/KfNCmxkH3u+gUS+VPGwstWfzHntGT3s4D
         06YRrPgW7vj8Km/bsEGuKU4bHs6m2PAITdcCl1w5PBaTJlMzeYeRslhYTHi2mvBWC274
         kM3ecJrSgXUEPGvAMo9l55ZNepovGzob/ZJIb1WKDEIpGi1A9MkJW6t4MfRNPSwn0//h
         qfcTsPzPwlWZHK9zOLgk/uvjgF8fTCFiEx1J12T8/tvFn1foix4OlgtBojtGhEThpHoj
         ln3pLhz4N75RXQaPECr/FQuOf1h07MrSK7MatXwtnxIaWPI0pp0hTvBEzN4Zgj2P615W
         jsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680082453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f5L2cTIuCdaJiW3kAEBYG9/8fNy39SDv5isWb6sXKGM=;
        b=RuWpfjWSzMuxcetCoH2uXtwnS+tFOVmht6vl0mvtHn1hZOK986IITc5GyOiy8qMhIJ
         NIhMCp0aPF2H7wMJJupeVZ4Z9CTJh8HkTAF89WfTeldTFoF8kuI7ZR5raXTUn/tl1HR8
         MkzaC72IthhTPCsSddqpJBNrm1i9L6T4avsSWBnwWgfT/gFVCCtCgHCJXClG3Kye69xa
         WhJ4YMaEpD46uBicsoMZkRFTqwJqzPXkVg9YtOvhy9fXfF/RSO2RM++fOQPxhMhKf8Vs
         XmOl1IIA1LhbUAQxQszlQS2/moONEnWv0MgF4YR1yBuQE4zmZz7lbS7pHQznAHOwj2un
         ETjA==
X-Gm-Message-State: AO0yUKUDJt0/soKxB5DerUzvCR7rdL4uWMyUM4xezglOsL+ohPuVbXIJ
        ZQoAi6k6WY4iUIy33rckqJA=
X-Google-Smtp-Source: AK7set8yccsbCx8knRfGBpGr70fkvWQCIQnYubRMqFF/G/oWX8LJbX8Xce/R3cgBARkf4tTb+lD0eg==
X-Received: by 2002:a05:600c:114f:b0:3ed:5eed:555d with SMTP id z15-20020a05600c114f00b003ed5eed555dmr13587420wmz.10.1680082453537;
        Wed, 29 Mar 2023 02:34:13 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id a21-20020a05600c349500b003ee91eda67bsm1637214wmq.12.2023.03.29.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:34:13 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: prctl: Fix spelling mistake "anonynous" -> "anonymous"
Date:   Wed, 29 Mar 2023 10:34:12 +0100
Message-Id: <20230329093412.419317-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in an log message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/prctl/set-anon-vma-name-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/prctl/set-anon-vma-name-test.c b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
index 26d853c5a0c1..4275cb256dce 100644
--- a/tools/testing/selftests/prctl/set-anon-vma-name-test.c
+++ b/tools/testing/selftests/prctl/set-anon-vma-name-test.c
@@ -97,7 +97,7 @@ TEST_F(vma, renaming) {
 	TH_LOG("Try to pass invalid name (with non-printable character \\1) to rename the VMA");
 	EXPECT_EQ(rename_vma((unsigned long)self->ptr_anon, AREA_SIZE, BAD_NAME), -EINVAL);
 
-	TH_LOG("Try to rename non-anonynous VMA");
+	TH_LOG("Try to rename non-anonymous VMA");
 	EXPECT_EQ(rename_vma((unsigned long) self->ptr_not_anon, AREA_SIZE, GOOD_NAME), -EINVAL);
 }
 
-- 
2.30.2

