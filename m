Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E2A4E18FE
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Mar 2022 00:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiCSXVy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Mar 2022 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240402AbiCSXVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Mar 2022 19:21:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20D45072;
        Sat, 19 Mar 2022 16:20:28 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p9so16184738wra.12;
        Sat, 19 Mar 2022 16:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BNzk/6MtnNLiXGXvVyfwvCWzIwLhP+ShlErnksixr+U=;
        b=dmjwNLdfWyGLpa2sWEml7Z1tf4clTCmw86dgqS6Jyv6F8s/sBa76xZbWybDeegDi9B
         3kIa5lk/GoeKK6of4yefI9yGRdGGSwI3CzX9CITLq3pnYdJnFcrfumFT0lz0BDWdD/Z0
         wpEc5p6JLaAmEghNpbNjZFrv6xb/4fpMQA19sNjoTfOqXsOyvObCr4cwv3myYQ2F0lvH
         Ml9xVA8oM6TAF7o/vwL4e/Kx3mmDPc/fXdS4sO+Vw4AbcjOLOjNARQoQpZOmTUJ1fjV2
         /CQGquFI2VAArdSLPdNq4lfLpenb8+/IBPUbIKycJaWwzLj1xSIMMfLizENthvVojd/1
         vomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BNzk/6MtnNLiXGXvVyfwvCWzIwLhP+ShlErnksixr+U=;
        b=768nfk2DqoIdIoj0fuTstP1cMmSaS0MCC/EJNS+8DiZyju5evjp3B5iRkpQc1CtBUL
         +F/KM+QY8REjODnKUgOMZa0YvCjIjLsa4dokRaHX80W5GSfw4mSStrLQkN6JvBQh6mU9
         RwDToNe/9ujXt6nmX9WzUCse2WkJl25CJOctgXWzk+tSUWgax9w8+fEsW4VXznBhJ1U1
         br58ktpK/0n32R9h7zeILVX7hCQCLRGTS4CYMo+pl8m+fmFu9fXBIB6dT8CriIm6231R
         iQySe38LuSEYJgORFnadBrbIen5ekuGpewHR1pusZyfXR6oTVu+8IXja9dVjX25Bg35B
         tAMA==
X-Gm-Message-State: AOAM5322NKf+IoMI8JduBGahZmD6AdQhpZv6Nq6E5iaHWhNAXPFE40uD
        /BuiJcfT1XT0t4CKdDKV/90=
X-Google-Smtp-Source: ABdhPJxtvsnHmneE09xrDF3eTfL4lgsytbRDwN+qSw8ui0UxseW78A+LmkoR3hGYVO4Qkwd82jfpZQ==
X-Received: by 2002:a5d:6f0d:0:b0:203:dc69:2e69 with SMTP id ay13-20020a5d6f0d000000b00203dc692e69mr12471640wrb.533.1647732027022;
        Sat, 19 Mar 2022 16:20:27 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm9591581wmb.22.2022.03.19.16.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 16:20:26 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Shuah Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc/pmu: fix spelling mistake "mis-match" -> "mismatch"
Date:   Sat, 19 Mar 2022 23:20:25 +0000
Message-Id: <20220319232025.22067-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There are a few spelling mistakes in error messages. Fix them.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/powerpc/security/spectre_v2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/security/spectre_v2.c b/tools/testing/selftests/powerpc/security/spectre_v2.c
index d42ca8c676c3..e832605442bb 100644
--- a/tools/testing/selftests/powerpc/security/spectre_v2.c
+++ b/tools/testing/selftests/powerpc/security/spectre_v2.c
@@ -183,7 +183,7 @@ int spectre_v2_test(void)
 		// These should all not affect userspace branch prediction
 		if (miss_percent > 15) {
 			printf("Branch misses > 15%% unexpected in this configuration!\n");
-			printf("Possible mis-match between reported & actual mitigation\n");
+			printf("Possible mismatch between reported & actual mitigation\n");
 			/*
 			 * Such a mismatch may be caused by a guest system
 			 * reporting as vulnerable when the host is mitigated.
@@ -201,14 +201,14 @@ int spectre_v2_test(void)
 		// This seems to affect userspace branch prediction a bit?
 		if (miss_percent > 25) {
 			printf("Branch misses > 25%% unexpected in this configuration!\n");
-			printf("Possible mis-match between reported & actual mitigation\n");
+			printf("Possible mismatch between reported & actual mitigation\n");
 			return 1;
 		}
 		break;
 	case COUNT_CACHE_DISABLED:
 		if (miss_percent < 95) {
 			printf("Branch misses < 20%% unexpected in this configuration!\n");
-			printf("Possible mis-match between reported & actual mitigation\n");
+			printf("Possible mismatch between reported & actual mitigation\n");
 			return 1;
 		}
 		break;
-- 
2.35.1

