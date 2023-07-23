Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EED75E027
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jul 2023 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGWGmH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Jul 2023 02:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGWGmG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Jul 2023 02:42:06 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56321FD2
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Jul 2023 23:42:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68336d06620so3140811b3a.1
        for <linux-kselftest@vger.kernel.org>; Sat, 22 Jul 2023 23:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690094523; x=1690699323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Z4DK/biTW+DU3lNfXFXK1/9r53OdVKpygo77g5mjg=;
        b=Yv9vYGpEg5a3tvQJxB+jXbSpD6IfFyngrnmM3j1hGdo8+UUz8NN4V/bzttR70DoCct
         CjC0MV2b9CwglBgRo75pgYWiQvkUa5QvxaPADxKjlf7BX8241/Kt6pQMSZLXMQX0xvTI
         1iCPSPdgRSkReZGAm6R86afSmA31UtNbOSxMzjKlh4MssZl84Cj9Z9ywjAExeVdmS8jh
         uMGQ083Xo1TQVKOoRP5bouPenPsa4DVlQE77jbN/hurf2NQlJpR81hFZsICHZnbw9dcR
         dPpnnlHTSv0gRgDezDwSiCr4Ng2HkWNeUpxsWmIKd3eZinmAf5qXs/sDYZPC5t+OIpc7
         50Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690094523; x=1690699323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2Z4DK/biTW+DU3lNfXFXK1/9r53OdVKpygo77g5mjg=;
        b=An4GVCJoBbqCBXbqAgwv430N0YpjhQ6T5s3dTWnCPfl99hWxdvM4Mf9fkMlCwjj8LZ
         U+1Ut0Y15J0ErgEuJUa3+jULQoAM9D7TltCC/kIzfXB/GmRrCbLd3HM6j002nYs6YuXu
         oS68Rwn/Z1DrDvh48cqAD/m0j5hFfbM1RNpEOWps+GEbr/u/JabcmFK8/gZIz0J09kbS
         kMGDHEM5GJkzAO7+ZG0Gop91ZK4a5PTCOA8ZhUYx0DsgZ1X42nP4ySbYRKurqApuTryc
         meIcEmLmHThKE0OzBIDsNgo4ogi2OQxmwe5VUvEA7b+BYd5/RGoE9aNBufVTrnucig1N
         svQw==
X-Gm-Message-State: ABy/qLZEAMn4TLtvOgWaOdbzNaH87Dhn7D8OzLYl+Jj+JXhw7fVLCfTq
        OByZDY28HUAbIUhYDUgLAk0=
X-Google-Smtp-Source: APBJJlEWT0Zrha6XrT67EXlC9BYYFmDhOxsUfSPgdpFRFVyxZ7h4ub6qpj/NTMtlIKG394UWmqRHIg==
X-Received: by 2002:aa7:88d5:0:b0:63a:ea82:b7b7 with SMTP id k21-20020aa788d5000000b0063aea82b7b7mr6444493pff.28.1690094523150;
        Sat, 22 Jul 2023 23:42:03 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:c009:58e9:5a21:2ad8:393a:4253])
        by smtp.gmail.com with ESMTPSA id ff12-20020a056a002f4c00b005d22639b577sm5416817pfb.165.2023.07.22.23.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 23:42:02 -0700 (PDT)
From:   Atul Kumar Pant <atulpant.linux@gmail.com>
To:     shuah@kernel.org
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        linux-kselftest@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v1] selftests: ipc: Updates the msgque test to use kselftest framework
Date:   Sun, 23 Jul 2023 12:11:54 +0530
Message-Id: <20230723064154.89443-1-atulpant.linux@gmail.com>
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

Updates the msgque test to print the pass or fail status after the
completion of the test.

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
---
 tools/testing/selftests/ipc/msgque.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 656c43c24044..513b1265bb75 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -9,6 +9,7 @@
 
 #include "../kselftest.h"
 
+#define NUM_TEST_CASES		1
 #define MAX_MSG_SIZE		32
 
 struct msg1 {
@@ -197,6 +198,7 @@ int main(int argc, char **argv)
 	int msg, pid, err;
 	struct msgque_data msgque;
 
+	ksft_set_plan(NUM_TEST_CASES);
 	if (getuid() != 0)
 		return ksft_exit_skip(
 				"Please run the test as root - Exiting.\n");
@@ -243,13 +245,16 @@ int main(int argc, char **argv)
 		printf("Failed to test queue: %d\n", err);
 		goto err_out;
 	}
+	ksft_test_result_pass("# Test Passed\n");
 	return ksft_exit_pass();
 
 err_destroy:
 	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
+		ksft_test_result_fail("# Test Failed\n");
 		return ksft_exit_fail();
 	}
 err_out:
+	ksft_test_result_fail("# Test Failed\n");
 	return ksft_exit_fail();
 }
-- 
2.25.1

