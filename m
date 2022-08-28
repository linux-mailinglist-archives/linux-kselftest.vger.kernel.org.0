Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65625A3C1E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Aug 2022 08:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiH1GT4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 28 Aug 2022 02:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiH1GTz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 28 Aug 2022 02:19:55 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15952140CA;
        Sat, 27 Aug 2022 23:19:55 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d12so5152548plr.6;
        Sat, 27 Aug 2022 23:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=sLVNtThA6kbuS/oRroGdbcyy2Nj7hrpD+Ej4bmUd9L4=;
        b=MY88iUoinQOIEQiwjpmDKiDkP4GEIuwVDcfjGm4QH+nVyUS2SiLfAilP62XrzHqy++
         ONUHYfye7rUhS2LJ5JCU013UBUM9eyAcXglCOb7BTCWxN1tR8EUjbnOARuNMMJ2VGC+2
         PaAGuthEzsu83i5U73UfMCDRQwNWafrm+/2hHI2ARSTCJywDsyzoWNMGZiNfNSl5Z4DB
         as1gTNOkHqJADIqSqXYd+XaKA3AQdnspP+awsOkG6P5jzMxJQotg/DY+k3SOAhojhknR
         FnsXTks9mui+IEC3UbBvaBeTbo9Br4cErKySTY3qxP0Z4/WqOQ+l5gEQir1IKLlMr+SC
         JaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=sLVNtThA6kbuS/oRroGdbcyy2Nj7hrpD+Ej4bmUd9L4=;
        b=MpqtWY5+VJhR+Mj5MQQvCohfA1zrDuLel8pwTk5ipFPKBKvbQZh1gMwwbVcGi2itcg
         KUP2Ud6F8IaqsM5DnEX9VMUt2lP3+Ze3PIhhQf+kzjW+mx/ctmp4t0J6Qh3Syl/2pMp8
         ND0JQhbpJC5iGsCLNfi28pwurz27vH7BPr3ZySGuE+Q+fiMd+CZGx8egwjPwK49zrIay
         7v75pSQYWfvTwrDFInwJtnt+X2OJZ+ujCx0gFlr0pQkP2NL0WSffzq1kPWNB8whqZNn9
         f3RV1D3AT9dQM8Z5gzV8rm+ojpJaIkSc6p/tv2DYWG/DSSkkVfiM+4goJhP+31kGgTD0
         GCSg==
X-Gm-Message-State: ACgBeo0vzZhkalDNa5eyTee81tXFcVDqjx+8fq5wKQOodBBzlTgPzCUl
        os/EfVqlX80uQQFQlNqFBpA=
X-Google-Smtp-Source: AA6agR5GXEpuUuIpVK0i7e8hmtA5JdEolz8bkSYO/QqWkrRUOSx9vsUTuR+eY7uUNYh02M5LX9oPMQ==
X-Received: by 2002:a17:90b:3142:b0:1f7:338a:1d38 with SMTP id ip2-20020a17090b314200b001f7338a1d38mr11926797pjb.223.1661667594639;
        Sat, 27 Aug 2022 23:19:54 -0700 (PDT)
Received: from localhost.localdomain ([112.134.152.151])
        by smtp.gmail.com with ESMTPSA id 1-20020a621601000000b00538116baa56sm1012843pfw.102.2022.08.27.23.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 23:19:54 -0700 (PDT)
From:   Dhanuka Warusadura <wdnuka@gmail.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com, shuah@kernel.org,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Dhanuka Warusadura <wdnuka@gmail.com>
Subject: [PATCH] selftests/sgx: Fix OpenSSL deprecated warning for ERR_get_error_line
Date:   Sun, 28 Aug 2022 11:48:59 +0530
Message-Id: <20220828061859.181061-1-wdnuka@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These changes fix the "error: ‘ERR_get_error_line’ is deprecated:
Since OpenSSL 3.0" warning.

Signed-off-by: Dhanuka Warusadura <wdnuka@gmail.com>
---
 tools/testing/selftests/sgx/sigstruct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 50c5ab1aa6fa..671d9b58e274 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -136,7 +136,7 @@ static bool check_crypto_errors(void)
 			break;
 
 		had_errors = true;
-		err = ERR_get_error_line(&filename, &line);
+		err = ERR_peek_last_error_line(&filename, &line);
 		ERR_error_string_n(err, str, sizeof(str));
 		fprintf(stderr, "crypto: %s: %s:%d\n", str, filename, line);
 	}
-- 
2.37.2

