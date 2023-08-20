Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812C5781E14
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Aug 2023 16:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHTOTW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 20 Aug 2023 10:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjHTOTS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 20 Aug 2023 10:19:18 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FE7DE;
        Sun, 20 Aug 2023 07:14:26 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a43cbb432aso1810019b6e.3;
        Sun, 20 Aug 2023 07:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692540866; x=1693145666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwwTQQ1AlxkkGA94reFOkINLaB8FDvWBNmcU/1DHybQ=;
        b=nJSc/7pdskLX6pheeigBl0BMJ6/Hi1umU6OcMZhqIKolk2ymBTqZtk7fawnua7fe4j
         ATRHSuVgdH5wnYol7phln5Dr2ZYpNK7G9XygFqAlvhaX+t91sxyqdfkZ6hoAeXy6gN4j
         rNxKTja6EveeDQECkUJx6zVaJSiFpwSqn89VD2fWEKFVfQgvZ0jTpXWiCFhR9k2V401k
         E8dDFFKhBUPSOoXWRC4bULthciYLamrKJIROkhjgolGaNR+DEJSyCqkoaku9afqACw4K
         59L63VrQpMKExJZpaB4gQrHmC3WgilJEyANqkC6B2Cn/8auG5yQhFXQdwD1dWzqgZJ1D
         rxBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692540866; x=1693145666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwwTQQ1AlxkkGA94reFOkINLaB8FDvWBNmcU/1DHybQ=;
        b=GqDEq4UstofU85tBXZjH1j5amDO5kJ2ZhYgdf4Bw5lxWmKeEa/I/PFyTJ3r1zvkqCt
         6N/mk9+pG9ZLhB8jrZw3IoJgsmc1yL/V+gCGL3YBxaQcdR1tkWhIvwCoKOir2ow4GWME
         zGaMjRdcWsS0QEMESwwiTzfh/nZmx2LTHPJf+IbYQ279H4PDLNd1owPEBQ/WUhO5z1D1
         3AHnqNv3kJ2CbDiMeWp6qfNR1z05sHksGS7lR/vvdkPr5JaSWVlvx3iDkKAic9CEJUBL
         mrfEXwuHnM047HHQVZsfINHEuDNnfupRlsrwEW/rwHor4QU1Q/3epHoKyxSCY6lt0kCE
         8QQw==
X-Gm-Message-State: AOJu0YxzHhNwl8Viq5qibcmG58ws9zDty6lpnnB/p7/jnM+5v+W/xM9B
        uvFLNV+YNyGGL3cdlE3q42k=
X-Google-Smtp-Source: AGHT+IEWD5uUsCdUw3am+cnR1SHD7U395wgIwdpZJnvdZTrxJk/ppoKIRamYAF971alVbaBebj3U4g==
X-Received: by 2002:a54:4e84:0:b0:3a7:c13:c8d1 with SMTP id c4-20020a544e84000000b003a70c13c8d1mr5398645oiy.17.1692540865573;
        Sun, 20 Aug 2023 07:14:25 -0700 (PDT)
Received: from Osmten.. ([103.84.150.75])
        by smtp.gmail.com with ESMTPSA id n8-20020aa78a48000000b0068859ce216csm4520337pfa.0.2023.08.20.07.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 07:14:25 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH v2] selftests: prctl: Add prctl test for PR_GET_NAME
Date:   Sun, 20 Aug 2023 19:13:54 +0500
Message-Id: <20230820141354.29687-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch covers the testing of PR_GET_NAME by
reading it's value from proc/self/task/pid/comm
and matching it with the value returned by PR_GET_NAME.
If the values are matched then it's successful, otherwise
it fails.

changes since v1:
	- Handled fscanf,fopen error checking.
	- Defined MAX_PATH_LEN.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 .../selftests/prctl/set-process-name.c        | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 3bc5e0e09..562f707ba 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -12,6 +12,7 @@
 #define CHANGE_NAME "changename"
 #define EMPTY_NAME ""
 #define TASK_COMM_LEN 16
+#define MAX_PATH_LEN 50
 
 int set_name(char *name)
 {
@@ -47,6 +48,35 @@ int check_null_pointer(char *check_name)
 	return res;
 }
 
+int check_name(void)
+{
+
+	int pid;
+
+	pid = getpid();
+	FILE *fptr = NULL;
+	char path[MAX_PATH_LEN] = {};
+	char name[TASK_COMM_LEN] = {};
+	char output[TASK_COMM_LEN] = {};
+	int j;
+
+	j = snprintf(path, MAX_PATH_LEN, "/proc/self/task/%d/comm", pid);
+	fptr = fopen(path, "r");
+	if (!fptr)
+		return -EIO;
+
+	fscanf(fptr, "%s", output);
+	if (ferror(fptr))
+		return -EIO;
+
+	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
+
+	if (res < 0)
+		return -errno;
+
+	return !strcmp(output, name);
+}
+
 TEST(rename_process) {
 
 	EXPECT_GE(set_name(CHANGE_NAME), 0);
@@ -57,6 +87,8 @@ TEST(rename_process) {
 
 	EXPECT_GE(set_name(CHANGE_NAME), 0);
 	EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
+
+	EXPECT_TRUE(check_name());
 }
 
 TEST_HARNESS_MAIN
-- 
2.34.1

