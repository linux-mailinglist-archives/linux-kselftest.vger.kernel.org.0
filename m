Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091C595A34
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Aug 2022 13:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiHPLcu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Aug 2022 07:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiHPLce (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Aug 2022 07:32:34 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF01FC9251
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 03:51:12 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 73so8891551pgb.9
        for <linux-kselftest@vger.kernel.org>; Tue, 16 Aug 2022 03:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=dkLR8fLUAaEMxniDx/rOllCA2y+wrv1MyJ10xgDHyXs=;
        b=je2t0lBRccO0CZFPvmYYe0IawIh5rA/NUsFftbJAdVjvzp3nh1DtWrY4gDx66RwN4s
         HYarmuM9g1C4e7BFLf+TUQvI6FvsxXobHgPAgQrMzEYxXTRgtNptruNyns4szzQD0ZKI
         VXgc16WqUyTE5zfXrBuPcIW+gwPsG73TBQ5jxb1bsyn8nG5aFLWbDMCvmAS+TNUppMLE
         ByZB/1etSdsJ9qhy58qM8AMjypUWfy4dDotyUmECEG68/abU5x1Ue0HzanTV7YRrO5k+
         0IHaEO7OPdip1x80XQ4zF/WAyFYRdZY0/eaTxncr+Hm+vorqzrnMznwKuPzrxdzqSQ4x
         lrZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=dkLR8fLUAaEMxniDx/rOllCA2y+wrv1MyJ10xgDHyXs=;
        b=U+ISHRDU7EAbTyXU/dfF0u9CjcHZcZslItCWRX57SKFVNP3PrJBC1N3ZQ/QtqWD1t9
         +jDxgdSwzO2pBSejCuNEdI0jYwwFVDz/4nlEOkPYfIOVEsmiEYuc6sSl8I/OotoeB80H
         PQop65dXvbCmjHD0CG0aOE4+R8VZDZZqY/49fmZGdJejBNq1PsbuQKa0wtgSZFmKJjT/
         d8/HuIGELhZnwg/hjYliPTOhYUdOqU49GyVGv14AWLV6XhMVw++0cSG+wipB437gMJpY
         tx9FdsXYqHH5Q+PIDigT5Dd+G1fsx1Yt2gW3gXgVU/pG5bB4fKsesCRLwAVma22jI1G1
         kfjg==
X-Gm-Message-State: ACgBeo2d2F6AKva7dlYP2/rdCohT8QXfJn0/2UqKW+zjqicnvj1GNP2s
        28IsvFVp0un37E8ZAGNrcYvxqFvV0jU=
X-Google-Smtp-Source: AA6agR4k9yj/1XclGGrkEeI442gXbD5Zs9aCtj+m+d0HpDkDKyn40rFU5AuW79e476nNfIPNRQ9aOA==
X-Received: by 2002:a05:6a00:e85:b0:52b:5db8:f3df with SMTP id bo5-20020a056a000e8500b0052b5db8f3dfmr20741399pfb.14.1660647072147;
        Tue, 16 Aug 2022 03:51:12 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c15-20020a170903234f00b0016d6c939332sm8717447plh.279.2022.08.16.03.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 03:51:11 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     npiggin@gmail.com, christophe.leroy@csgroup.eu, shuah@kernel.org,
        linux-kselftest@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] powerpc/selftests:Use timersub() for gettimeofday()
Date:   Tue, 16 Aug 2022 10:51:06 +0000
Message-Id: <20220816105106.82666-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Use timersub() function to simplify the code.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
index 6b415683357b..580fcac0a09f 100644
--- a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
+++ b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
@@ -12,7 +12,7 @@ static int test_gettimeofday(void)
 {
 	int i;
 
-	struct timeval tv_start, tv_end;
+	struct timeval tv_start, tv_end, tv_diff;
 
 	gettimeofday(&tv_start, NULL);
 
@@ -20,7 +20,9 @@ static int test_gettimeofday(void)
 		gettimeofday(&tv_end, NULL);
 	}
 
-	printf("time = %.6f\n", tv_end.tv_sec - tv_start.tv_sec + (tv_end.tv_usec - tv_start.tv_usec) * 1e-6);
+	timersub(&tv_start, &tv_end, &tv_diff);
+
+	printf("time = %.6f\n", tv_diff.tv_sec + (tv_diff.tv_usec) * 1e-6);
 
 	return 0;
 }
-- 
2.25.1
