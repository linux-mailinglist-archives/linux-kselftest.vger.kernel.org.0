Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2374E755040
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Jul 2023 20:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjGPSSi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 16 Jul 2023 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGPSSh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 16 Jul 2023 14:18:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E091B0;
        Sun, 16 Jul 2023 11:18:36 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1b9e9765f2cso21858475ad.3;
        Sun, 16 Jul 2023 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689531516; x=1692123516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uRr4t72OqG7bbsdSQp36s5QmJpiGmQDwT7OtOfgVJAs=;
        b=GaaYjzKLGGS1UieotsqzLzc8zg49fL2l6LbQTq3nbfRE+3kPmSrdRXeC5u7qg1VvXB
         ruuwP3vXsuw7i7PcoixYO4rTMutHMuhoAoT3wQ5lO0TZi5uBCYh/B1j8b1Tkuh+p1Jw5
         GMyOpBuH6+TcBxZYOBO7/F0bG+EraHMrDfGydgkurseGk/ofa92an7A/FhERLpHr4pte
         OwQINR0kLvSSLFs9k4ApiPmnIGKO79f9d38yBzjXvL6Cj1FNF3U3Trp8ZGs/fSG1hzdK
         A8pZkBlstHyHiWzs/QntkFLl6bp9ddzq4TpFicx12n3wumpjmvzZaC1DUudpjgA9OeVg
         EzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689531516; x=1692123516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRr4t72OqG7bbsdSQp36s5QmJpiGmQDwT7OtOfgVJAs=;
        b=OMe7v2235ncjIfyuUvOVSeUa96RHL2FxtZ8CXieSDEjDLHt/jzJ8F0/I4RJxWeZrQK
         50PexF7fqmf1UfCk+R+gdHau/Axda/c0tIOOLfZlQuvX0bt4BLpULY4OPheLrVOBUa1X
         fkNUe6IHU4Trq0GzZe6Ljrb0C7FQ6bKHbe1MAYDvO2H2VaHFMAzPO1E3Igl72PaXfqHi
         bRBjwXBzD7dWg5rhWb6BSIYwF2U4jmeAMTBr7XY2llSdQFaA48MKvA4iUALFTIj9NPIP
         IGJnDU6txtdzmheoSGjOKlgxHem8X0fCmiEgB0Ep2yS8XY1LDc+hITcUt+A1uf4pWUxo
         Vflg==
X-Gm-Message-State: ABy/qLbcMxhO7pZHW6wWGihLQavI51Jiuz/wMkW56WV6K+3FaSux7l59
        BGFXvh9sRqHk8j+ItALY+4n/Oq6alT4=
X-Google-Smtp-Source: APBJJlGeSVnKgr9IYi96OpeUoLCDTdox4GFlFamj0ylUDg3pvZD2cublCV/5BfUn/SiWjyUynohRiw==
X-Received: by 2002:a17:903:182:b0:1b8:944a:a932 with SMTP id z2-20020a170903018200b001b8944aa932mr10984982plg.2.1689531516055;
        Sun, 16 Jul 2023 11:18:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58ea:65e4:f662:2536:5ba8])
        by smtp.gmail.com with ESMTPSA id e15-20020a17090301cf00b001b87d3e845bsm11242422plh.149.2023.07.16.11.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 11:18:35 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] selftests: rtc: Improves rtctest error handling.
Date:   Sun, 16 Jul 2023 23:48:25 +0530
Message-Id: <20230716181825.44337-1-atulpant.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

When running the rtctest if we pass wrong rtc device file as an argument
the test fails expectedly, but prints the logs that are not useful
to point out the issue.
To handle this, the patch adds a checks to verify if the rtc_file is valid.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---

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

