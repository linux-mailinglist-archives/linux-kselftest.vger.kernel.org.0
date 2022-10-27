Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D20660F219
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 10:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiJ0IUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 04:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234598AbiJ0IUX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 04:20:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538AD3687F;
        Thu, 27 Oct 2022 01:20:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id o4so898092wrq.6;
        Thu, 27 Oct 2022 01:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZhAkeTE+r3qGSdf1uyZlVySOESrVW6Y6fLcnPw4YAY=;
        b=DiIQNYyGrONs6G2AQZr+dH+U4Jsn1FBRy0IMRIDZ7JwnXFYfQfDx2nvhwWlwRS3BAO
         eBm+2xhvAhNAoD9cFxe/7H3bUDw4fOg6AGfRjMk//F9lvQWnNzxR/R2TLWJBjnfXlOkT
         Qb5EOia6u6jGmzYO8Gim9Lll50kq5jv/zaC7dWh1yrQeuRJ35ifdQC95/5K1tBCKLyCB
         CDsKBeJl/YhXGwRk5QSzOibqNb4MmhBoeWN6FNofhaMmfSDYYkCgq8Yy0scM3zhYWMkk
         PvwANTuSx6fd+fJALVH0vCJ6Gv0/pcaCdqW+cPCOCcI15EI2hNghLYUb17kALwkndbcw
         c0UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZhAkeTE+r3qGSdf1uyZlVySOESrVW6Y6fLcnPw4YAY=;
        b=qgxnMUhIQMEc55Z9+Ma4Xnoot5Ghi1ZfK3Ss3/W48FOmDSno380O4syQaqEeKlcgE2
         Y4/i68wjzGmL2AA+WqIyE4la1oHvbA1DeDzaN8/tbTWn+ge6IK3l0MtY0QKz0KYZyljA
         ybovRnp4nO8SyyeIMWfXYebe9bire7+Awsyf8awSgthvBxbavVxiRV0eBsNQoGCGG24S
         P+hecNk1cB26FSuruqADoiiaoQqtsvkw8qws3AMDTvxenQQVeVDRFzeoRHLKJ004w7Ba
         6innEr7IPjYp/KtRUf80IpeBrKcFviTfDXLgGXROH/5bh/dACv9q7YtY/WW4Y2I0MOO+
         kTOg==
X-Gm-Message-State: ACrzQf2Xd30/Pv1YFwsUW3wn08osxn/yH4GTr00kbKJcKT9Uqbpiy1K5
        +O3sV25aejavZHZEjWq9quY=
X-Google-Smtp-Source: AMsMyM4fwrpf2P3XzwJoDzmjqVVVomWWxMoIdN49K5425D5uKFtKQmYX6UoderE+s+rzfRIQjOZtKg==
X-Received: by 2002:a05:6000:10d1:b0:236:755b:e038 with SMTP id b17-20020a05600010d100b00236755be038mr12072900wrx.153.1666858818700;
        Thu, 27 Oct 2022 01:20:18 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6751000000b00236488f62d6sm519681wrw.79.2022.10.27.01.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 01:20:18 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/watchdog: Fix spelling mistake "Temeprature" -> "Temperature"
Date:   Thu, 27 Oct 2022 09:20:17 +0100
Message-Id: <20221027082017.3255055-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a spelling mistake in a print statement. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/watchdog/watchdog-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/watchdog/watchdog-test.c b/tools/testing/selftests/watchdog/watchdog-test.c
index fb3ca67785c2..bc71cbca0dde 100644
--- a/tools/testing/selftests/watchdog/watchdog-test.c
+++ b/tools/testing/selftests/watchdog/watchdog-test.c
@@ -260,7 +260,7 @@ int main(int argc, char *argv[])
 			if (ret)
 				printf("WDIOC_GETTEMP: '%s'\n", strerror(errno));
 			else
-				printf("Temeprature: %d\n", temperature);
+				printf("Temperature %d\n", temperature);
 
 			break;
 		case 't':
-- 
2.37.3

