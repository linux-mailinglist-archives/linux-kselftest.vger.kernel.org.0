Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7B94466FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Nov 2021 17:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhKEQas (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Nov 2021 12:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbhKEQao (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Nov 2021 12:30:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DE1C061714
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Nov 2021 09:28:04 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x27so19805733lfu.5
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Nov 2021 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fa7Z6nglF14QRStQgbgptF1fA20fCaVRUV/pNu+eqLM=;
        b=EKRe7n8ax5DNYYW6YP/lIzY6bHmkK1CRdjLwWq9BPWIrnt06mK03oOdDdS+NkVWG5L
         BVmrmKlTGeZsn9Gy3h+aZgJkc35JrlYirDCw3yykztrp+jWD6XFXYDJn2Dco/ikfZ8/e
         dO6XwL8FtbJuNNRatSNT35fU3PGY4iQITkUTKUl1GqicrYG/5kU2nXS0HReaf+C7RRpx
         EOUF9aHCA6gCUnAXIp1ztXYDv7koXGK2/G7FV/5IQMrqvdTXmV7aIhGTBiwpm92w2YV5
         RbaqdsNwoLAZ1gNw+yUGwrimB5uisck7N1SRSPlQWztE9q9C7j5nH/SK/kS2x+MyLula
         ELcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fa7Z6nglF14QRStQgbgptF1fA20fCaVRUV/pNu+eqLM=;
        b=8QEnuITTqxEe0sv6f1WOUje5ExJLlIhRN0xeIP+spesJs2i3rV1j4Az2noB5gzAKdd
         3k4WYX6ccOXOygHcUdyGMoJyN7JKgl9q4YC3BvVOfdGL+n6VvbDW1QcSewExAq++w16f
         9QkD/cY1ePZMa3WbF4o93uAXBUasEhS8dysgncJ42Llh/SUr7QMKlg9HltOl6bptJs4K
         rLzqCrihe5NcM74Yx73Z3HxUXivnjiK4G7qluURiCm2Aa/eNCoeXzwRFHnKD0SUHadc/
         IUqna6YeCvTBP+6zyw+ExC2bcehZf5Cw4F8rHAbhZk5o1364sbGBF7pxQnLDAM9++aOM
         60cg==
X-Gm-Message-State: AOAM533oDPaQhoGY3v9Sz+UMlQ4CTJjlw+fWgTmMSsGpYbjN6d2pm7+a
        KEnhso2NdAk+ZdiV9yP4uO8PYA==
X-Google-Smtp-Source: ABdhPJz7gvTwzAM6Evcf7owRlQfpCs/L3f/eIxh6EHcbCdoD14bk1rQyi+Kz0k127+E0BVXJXkWsAg==
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr51578864lfq.192.1636129683115;
        Fri, 05 Nov 2021 09:28:03 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id p12sm872557lfa.265.2021.11.05.09.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:28:02 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     nathan@kernel.org, ndesaulniers@google.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: vDSO: parse: warning: fix assignment as a condition
Date:   Fri,  5 Nov 2021 17:27:56 +0100
Message-Id: <20211105162756.3314148-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building selftests/vDSO with clang the following warning shows up:

clang -std=gnu99 -Wno-pointer-sign    vdso_test_gettimeofday.c parse_vdso.c  -o /home/anders/.cache/tuxmake/builds/current/kselftest/vDSO/vdso_test_gettimeofday
parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
                if (g = h & 0xf0000000)
                    ~~^~~~~~~~~~~~~~~~

Rework to a parentheses before doing the check.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index 413f75620a35..b47b721a4ea4 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
 	while (*name)
 	{
 		h = (h << 4) + *name++;
-		if (g = h & 0xf0000000)
+		if ((g = (h & 0xf0000000)))
 			h ^= g >> 24;
 		h &= ~g;
 	}
-- 
2.33.0

