Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232EB7264C4
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 17:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241099AbjFGPgb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 11:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240598AbjFGPgb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 11:36:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6558E;
        Wed,  7 Jun 2023 08:36:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-977e7d6945aso560211066b.2;
        Wed, 07 Jun 2023 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686152188; x=1688744188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yw8NnBB2eVrIeNQ76jclUnfMKFC0ZCvSsvCVA2pp0w8=;
        b=r+lieSHxxcxOsum/U4sQs6DxlvivqcGA1Qi7YMCYD0+6yMmaBhxQ2ijmuSOcC7Sfgo
         JoHN/K+5zkj2h4tBDBr2p93HRjLvTbNd2jwyRGLGoezeE4EALPmA5Rajd8+gyh+m4hGh
         UdfW3ccM2D7UJoXvv9LzRyLHdyr2ZhmcUG7yhhoa6s+0Yx/h1tZ5gavYMKbBIlZWHCVx
         Wikgl/6evBRKD2ZAQ+2wtud6CP0QRoJgPkTiYXbjyMBXcuaFhFQ5c6HNwjmDmmmIx5VX
         /802K+cKYLt7E6nbzAEbuVZ+gWENIdcYdQEnDLwF55PSd5Ep9m3dWrEK7eobb6qYrnaF
         mWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686152188; x=1688744188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yw8NnBB2eVrIeNQ76jclUnfMKFC0ZCvSsvCVA2pp0w8=;
        b=YJuwaC3YJHo5mOFO+A04QlQTz0mOUDqOpxKvF0Hd+q9B0FaBZ1nXYip57ElmwpXCm7
         6pQNAUppOifgWxUCca/FpMvi1T57TTxVepMftymYkGv8h6BAipse9dCa7jyaQpNObCvI
         57jWAVgkEEdUbIyJ3EwmyKfeIXUSscPfJHWAIPGA53CMw+zsRcLSq0Wy+Ti5H3IGB+Ne
         WQ6SL9x0u6gev4qnf04fautnAwpSJCkPEYFJC+KJCIRNJXEXK46i9Bj2AFLBiRvrLINv
         OylZDSlBEYSnnbzL+t92kgTUHMgLN6oNQ05hLlvlof7pTPZ+B3tfouxXVbSMiweYcuHv
         mONg==
X-Gm-Message-State: AC+VfDxevl3dRQjYB3YxDkBtdl7guJOJSYZf88TUU/FknOIYjSGMP3ak
        fle8S12jP+0oRABCZ6X4mj4BMIYdgbM=
X-Google-Smtp-Source: ACHHUZ4XhyIYxYG6b0ch4xFGUEd+1+0mvfa7mu2cF1vBE0T20wV4Jz1+L+fVUql4PBxWt55WwxqX9w==
X-Received: by 2002:a17:907:6d98:b0:96f:ea85:3ef6 with SMTP id sb24-20020a1709076d9800b0096fea853ef6mr6869464ejc.62.1686152187484;
        Wed, 07 Jun 2023 08:36:27 -0700 (PDT)
Received: from Osmten.. ([103.84.150.92])
        by smtp.gmail.com with ESMTPSA id p22-20020a170906499600b0097866bc5119sm2398069eju.200.2023.06.07.08.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:36:27 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v2] selftests: prctl: Add new prctl test for PR_SET_NAME
Date:   Wed,  7 Jun 2023 20:36:00 +0500
Message-Id: <20230607153600.15816-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch will add the new test, which covers the prctl call
PR_SET_NAME command. The test tries to give a name using the PR_SET_NAME
call and then confirm it that it changed correctly by using  PR_GET_NAME.
It also tries to rename it with empty name.In the test PR_GET_NAME is
tested by passing null pointer to it and check its behaviour.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>

---
changes since v1:
	-Used TASK_COMM_LEN instead of using numerical value 16.
	 
---
 tools/testing/selftests/prctl/Makefile        |  2 +-
 .../selftests/prctl/set-process-name.c        | 62 +++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/prctl/set-process-name.c

diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
index c058b81ee..cfc35d29f 100644
--- a/tools/testing/selftests/prctl/Makefile
+++ b/tools/testing/selftests/prctl/Makefile
@@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),x86)
 TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
-		disable-tsc-test set-anon-vma-name-test
+		disable-tsc-test set-anon-vma-name-test set-process-name
 all: $(TEST_PROGS)
 
 include ../lib.mk
diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
new file mode 100644
index 000000000..3bc5e0e09
--- /dev/null
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This test covers the PR_SET_NAME functionality of prctl calls
+ */
+
+#include <errno.h>
+#include <sys/prctl.h>
+#include <string.h>
+
+#include "../kselftest_harness.h"
+
+#define CHANGE_NAME "changename"
+#define EMPTY_NAME ""
+#define TASK_COMM_LEN 16
+
+int set_name(char *name)
+{
+	int res;
+
+	res = prctl(PR_SET_NAME, name, NULL, NULL, NULL);
+
+	if (res < 0)
+		return -errno;
+	return res;
+}
+
+int check_is_name_correct(char *check_name)
+{
+	char name[TASK_COMM_LEN];
+	int res;
+
+	res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
+
+	if (res < 0)
+		return -errno;
+
+	return !strcmp(name, check_name);
+}
+
+int check_null_pointer(char *check_name)
+{
+	char *name = NULL;
+	int res;
+
+	res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
+
+	return res;
+}
+
+TEST(rename_process) {
+
+	EXPECT_GE(set_name(CHANGE_NAME), 0);
+	EXPECT_TRUE(check_is_name_correct(CHANGE_NAME));
+
+	EXPECT_GE(set_name(EMPTY_NAME), 0);
+	EXPECT_TRUE(check_is_name_correct(EMPTY_NAME));
+
+	EXPECT_GE(set_name(CHANGE_NAME), 0);
+	EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1

