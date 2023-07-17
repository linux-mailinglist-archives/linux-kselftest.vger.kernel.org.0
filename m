Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBA7756AFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 19:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGQRxD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 13:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGQRxD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 13:53:03 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305A1B5;
        Mon, 17 Jul 2023 10:53:01 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8c81e36c0so29069925ad.0;
        Mon, 17 Jul 2023 10:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689616381; x=1692208381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5tYEoMOLm/mIuBIhnH5hvMExYrOHr41KyvUDfsyubA4=;
        b=I610iZ7puRZvI+aUPm6JVT0dUWkBr3MTu4xvOwRBstjV0TF5f0x8XaPiSALfqFBbqM
         dq50Oy2VSixBwIgHaPOAsRoQk3tXHlBR4VNJ+2hKoduHsI0FfsVSr9WtOzXoOtdLy+a/
         amFKicpj+oCr0f3pca8erDuiaCYXQw5nn11b9++W2VBN0HxfEddFqtHYnuOrK76LIu18
         vHGIVUS2DKYekCR9g1cHPJh4fGy8yzrS5hHC2BLVqbJ9s2nTNDIbrAm6tM32e/Ua0Uu2
         QsA1kN9g5/ZrIks+bm/3DkeVq28dk/Tdlc7ZHbkA01h7WLbnJQLKbmTceS/OQLA/fEW5
         Vbmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689616381; x=1692208381;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5tYEoMOLm/mIuBIhnH5hvMExYrOHr41KyvUDfsyubA4=;
        b=HaotZ03GpqelLUUGzGfzZvL3Czjs+Y6oOKzu6zj5rs4fx4IYufHgYQuxSbXciVAEDY
         1pxjBEpXgmqIhbYel2ELOtePknl6VMr+FamHa6irF2ExP0EG4vnsJHlDkM0OqK/HzBAC
         Meetiv342h02LOIKB0LY6Zk3YZAewPcdaOWd061swB/UZtMSLcVATzDmhU81R/bRHplA
         8MGOgQhs3Kc9S+9bjXy3hYAPV2Ti0ILb6M0V0MwVFsn8MqCyJCuoVYoDosxDV11uMn4u
         f7akNnE7NojcVw558JapKv4qvR+cmdLIzVFLwE4b9J+ClO2hvA9bd6HqukcVbr+q897y
         ZCqA==
X-Gm-Message-State: ABy/qLYRkNeQpyIrWgZbDWVm8l567KDb0LIjy4MKsxuGOgs85MaSiedU
        sX58PQqyvSZ6xBP+PUTIaxs=
X-Google-Smtp-Source: APBJJlH9GFTB1GX/3XF09GHgj4tbHjuW07ilNWgS+K2qPVPVLx1MwqHs+N8oVGSFHP8+/sOryWoVxw==
X-Received: by 2002:a17:902:be0f:b0:1b8:7483:d481 with SMTP id r15-20020a170902be0f00b001b87483d481mr10786269pls.8.1689616381291;
        Mon, 17 Jul 2023 10:53:01 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58ea:6a1e:612b:7001:f9bd])
        by smtp.gmail.com with ESMTPSA id jk11-20020a170903330b00b001b8896cd57bsm148971plb.269.2023.07.17.10.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 10:53:00 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>, shuah@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-rtc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] selftests: rtc: Fixes rtctest error handling.
Date:   Mon, 17 Jul 2023 23:22:51 +0530
Message-Id: <20230717175251.54390-1-atulpant.linux@gmail.com>
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

Adds a check to verify if the rtc device file is valid or not
and prints a useful error message if the file is not accessible.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
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

