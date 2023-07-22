Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5075DA44
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Jul 2023 08:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGVGHU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 22 Jul 2023 02:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVGHT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 22 Jul 2023 02:07:19 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0E93A97;
        Fri, 21 Jul 2023 23:07:18 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1b3c503af99so2074746fac.0;
        Fri, 21 Jul 2023 23:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690006037; x=1690610837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rW6GM0YOKgtl8KRMmye9ZDjg4JN8bbrjMVuMmk40jik=;
        b=DoBw3Me1QOOkU/J1GVBk5SaEYGjZnik2o7BnISvlBySPxczy5lmYzvOCcxWqQYxb1N
         NcgDMNi+jaKY6uI1eqHyRlE0ugCo1Gnhlw2RNAVeQswQ202G2D+OtrzWvU9IvH1nQjTC
         Bbsms1KXORTHkB591U+nMfZIGXO7twpzOMR4YEeKk45fAyAG4vSpWppYDPNTNOCqy1E1
         L2L8XC92xts5DmJySbJTIpxki27QNH8SFTt9dfBoR9ANQ1ZRWVGbM5EAQG94yzo53tQ/
         ryPh2g3T98RbYr/JoNCPYZ7szaUIfMkibSE7AD76BOVKuAvSv8xxF+EUnJ+NvjmKC21j
         Mc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690006037; x=1690610837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rW6GM0YOKgtl8KRMmye9ZDjg4JN8bbrjMVuMmk40jik=;
        b=ehFUa17EdEXRUIVbPffnfsfgLEKOnOI9arMzrwiKKicrLeyyeOTS//lGpFC6pRzvPB
         Llze4CppmskGMOCLpctf0xCcIAhp437yPf3fFQlINyw3pHfNA782f6rlfcCSirl+kkAZ
         sKQJdbGhh62IGaii6WMn6eIDL6bXj9T7aty0GSdvUjETwaGtXM3NO2sSIofxv1j93trJ
         yqVxL3V+WX1Nte5nfyyYWwtWzAM/UiC5bo3cfj0mq0kBBZ0zcpuOFKSYk9ciVpJ1BaMJ
         v+1WlumalQkkFjktuiXzUVTtGTL2Zeqg7E1Hs5kQM6PZgTp9n4g2lsQzKZOLHRLO3fbo
         v0gg==
X-Gm-Message-State: ABy/qLaDOl1fjmFW/Nj6X37xZ/7wgqG4oaeIwRj/61a3aQAedZHncXF3
        I5M7JPkzgXegAMoiqXJTkbA=
X-Google-Smtp-Source: APBJJlHCe0dYIQRNUPOiWsNip1lqerBaA6M371j3mQZBtlg6icpfQ1ao2XrDcq24IliOaCsmOVeg6A==
X-Received: by 2002:a05:6870:a40a:b0:1b4:4a2e:b698 with SMTP id m10-20020a056870a40a00b001b44a2eb698mr4386468oal.47.1690006036749;
        Fri, 21 Jul 2023 23:07:16 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:afd6:100a:624c:cf38])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b0063b898b3502sm3886060pfm.153.2023.07.21.23.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 23:07:16 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] selftests: rtc: Fixes rtctest error handling.
Date:   Sat, 22 Jul 2023 11:37:06 +0530
Message-Id: <20230722060706.79759-1-atulpant.linux@gmail.com>
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

Adds a check to verify if the rtc device file is valid or not
and prints a useful error message if the file is not accessible.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---

changes since v4:
    Updated the commit message.

changes since v3:
    Added Linux-kselftest and Linux-kernel mailing lists.

changes since v2:
    Changed error message when rtc file does not exist.

changes since v1:
    Removed check for uid=0
    If rtc file is invalid, then exit the test.

 tools/testing/selftests/rtc/rtctest.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/selftests/rtc/rtctest.c
index 63ce02d1d5cc..630fef735c7e 100644
--- a/tools/testing/selftests/rtc/rtctest.c
+++ b/tools/testing/selftests/rtc/rtctest.c
@@ -17,6 +17,7 @@
 #include <unistd.h>
 
 #include "../kselftest_harness.h"
+#include "../kselftest.h"
 
 #define NUM_UIE 3
 #define ALARM_DELTA 3
@@ -419,6 +420,8 @@ __constructor_order_last(void)
 
 int main(int argc, char **argv)
 {
+	int ret = -1;
+
 	switch (argc) {
 	case 2:
 		rtc_file = argv[1];
@@ -430,5 +433,11 @@ int main(int argc, char **argv)
 		return 1;
 	}
 
-	return test_harness_run(argc, argv);
+	// Run the test if rtc_file is valid
+	if (access(rtc_file, F_OK) == 0)
+		ret = test_harness_run(argc, argv);
+	else
+		ksft_exit_fail_msg("[ERROR]: Cannot access rtc file %s - Exiting\n", rtc_file);
+
+	return ret;
 }
-- 
2.25.1

