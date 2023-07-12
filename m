Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAE2750A5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 16:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjGLOBq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 10:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjGLOBg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:36 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD9F19BE;
        Wed, 12 Jul 2023 07:01:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82dc7so71733595e9.2;
        Wed, 12 Jul 2023 07:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689170484; x=1691762484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fe/Z+3ZtV+7rEEbA5ujf7MvOol2TwmyPnYuPdYc8Nwg=;
        b=UiX61zfF22NdJKf458JphAbi6m+mWH28KarzHGFtUyEVhXabazOSNAkurpgz5quMnl
         izUUZNQJJXMbmbtgB1bl4o9YSib/GV5m5jD54AQmzsi5Xz4NAoCrHjqthsSde3sidZXT
         Bk6xEDMjY+ny22PFJzjXXmkcS02rSo8B0wnA6YRoiFdR1UXtiNOIA/kC3XBjeEzryjFx
         /bUmYpKgnQGso1HekqStoMn2S9aWHyFNPb4Q4/m8TeqdfdH7hLJKw3qLiSr4ttzspj/9
         0H+9IQgjST/1GgGohMsheteYm26A2XZaSiuSjO29zVVmE8ETfPKF9NBS+6f6ROGS59Wx
         AoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689170484; x=1691762484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fe/Z+3ZtV+7rEEbA5ujf7MvOol2TwmyPnYuPdYc8Nwg=;
        b=c/r7ywFU5/fmxYACKQTB4Kq7PrNguHegJ72k3ZfORWmVrg/7RZT09gqyjoPZ2lYL/Y
         75J/WwlOtEUR6aWeiVZf0iHkkKZSFpWnXQdK+u/fhCDhmf4TQgq0pPK0GXrFp3EPZDAd
         v4Vbverz0mDLGHERqL22BVZ64hqE7mKvpRbHc1Z+vV1g/zXuQtmE7bHWfMgTGu/WLi+u
         PMh4mfn1102XNHnLFRo+AwUSvJfaOamkTnUx23uUzELVRAB0fXWRQ9hiGkBlgKmDmwfS
         5qMvHoAjA4RU0dI7CZRI17CKIzB4/uy2S/Qh02dCrbSNJaKGNsr3slfgDgPniiPprtOX
         V3ZA==
X-Gm-Message-State: ABy/qLbXdwm6C5FO9TKrm3RsW6eYMzhY0xPM1cY4B5H3jD81m23Y2OZv
        b/nHid/L+KPIIVg2hvKnp+o=
X-Google-Smtp-Source: APBJJlEPYGZqRWNC5D4AwhzPhHaPUZb4AP4spv2VYPHTJyc6HbPStnjhWinQ0WTnopg5Pgu40RTwoQ==
X-Received: by 2002:a7b:c451:0:b0:3fb:b4fc:be62 with SMTP id l17-20020a7bc451000000b003fbb4fcbe62mr17218287wmi.17.1689170484340;
        Wed, 12 Jul 2023 07:01:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h6-20020a05600c314600b003fa9a00d74csm2318867wmo.3.2023.07.12.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 07:01:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>,
        alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests: ALSA: Fix fclose on an already fclosed file pointer
Date:   Wed, 12 Jul 2023 15:01:22 +0100
Message-Id: <20230712140122.457206-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In the case where a sysfs file cannot be opened the error return path
fcloses file pointer fpl, however, fpl has already been closed in the
previous stanza. Fix the double fclose by removing it.

Fixes: 10b98a4db11a ("selftests: ALSA: Add test for the 'pcmtest' driver")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/testing/selftests/alsa/test-pcmtest-driver.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/test-pcmtest-driver.c b/tools/testing/selftests/alsa/test-pcmtest-driver.c
index 71931b240a83..357adc722cba 100644
--- a/tools/testing/selftests/alsa/test-pcmtest-driver.c
+++ b/tools/testing/selftests/alsa/test-pcmtest-driver.c
@@ -47,10 +47,8 @@ static int read_patterns(void)
 
 		sprintf(pf, "/sys/kernel/debug/pcmtest/fill_pattern%d", i);
 		fp = fopen(pf, "r");
-		if (!fp) {
-			fclose(fpl);
+		if (!fp)
 			return -1;
-		}
 		fread(patterns[i].buf, 1, patterns[i].len, fp);
 		fclose(fp);
 	}
-- 
2.39.2

