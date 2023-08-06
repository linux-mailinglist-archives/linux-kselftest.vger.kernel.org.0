Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A2D7715D5
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 17:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHFPSd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 6 Aug 2023 11:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjHFPSb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 6 Aug 2023 11:18:31 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9135E114;
        Sun,  6 Aug 2023 08:18:30 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6873a30d02eso2429110b3a.3;
        Sun, 06 Aug 2023 08:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691335110; x=1691939910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdojjPd8jvPUy+VY2bdrww/YrOG4FByQTZ03QZtrm54=;
        b=JXCDXpwu+g6gyowY8O0u01Gj0laYagxCnjlPvk5TAa9d1pafaYRjonaQw+SDEIUNg0
         se4xChJ18bF8mRvnrNsi0lH7jnYi0U4q7HJ4u6abgsdJCTU/U+PmktiLQ0u1kGHfNGy2
         uB0RM4690coQNSG33cWjFy5bzb0SJvL+beWvNv5GrdyppYxM0xEYWK214q+9U7CyU2OH
         hf8b6/mp2NhV/qU9Sok1OXXCm/Dcsvpf/Dikk9gGtClQxz03aU18afsh42ScP5HckIn1
         Wf18CMjtl01b8BRiwSfdxEpDhKzmbkCmx7VZj5rjd+3foDMADvhaDMhSnKnFq7Yqdi+C
         TuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691335110; x=1691939910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdojjPd8jvPUy+VY2bdrww/YrOG4FByQTZ03QZtrm54=;
        b=U7zsi0vM5gFhxhliSWunIuYhjHdmuHIYNWaipYs0nC5MYxyvFUt8CKRyJAnvF89sur
         Ql11G58v6SCAa5+9EbRtgXbjQVnrx+vbcjMVXSg1/QN8+FF9TBdxIbUcQ6YyVJO3WtI+
         3xuX4E00TExsuPy3xyo+BuPS4ogrMmuOgMnTtYGyVIG8CQbnp8ShxzTm/sNAoYx9MymD
         UsPTU1fSPT/ikphnpXYCc8Bwqy2IYrE9Is8TdQB8c20bIh9innkDI0BADQ6ite/ILqe2
         ICCFrHQwu8LRCkjERfM4/Ep3J197K85/1/QQ0c2naQv6MV3fedFW7PJmnIr+8dAmp9bc
         ou8w==
X-Gm-Message-State: AOJu0YxsKyUxx7XLz3M1bp/qoFfNDhCd8wt049DIlyKVOEqqWuQxdAyd
        KQ+frxE+Kq28+A/wDXnhjmg=
X-Google-Smtp-Source: AGHT+IGcQtcV98NulZ42qCdFzvMwUafqFsrmOr1yoV2WX84uBk8XgJSlMW7dsx57V7WIvBcT/LmPRQ==
X-Received: by 2002:a05:6a21:1f14:b0:13d:56cb:6b9d with SMTP id ry20-20020a056a211f1400b0013d56cb6b9dmr5514964pzb.32.1691335109433;
        Sun, 06 Aug 2023 08:18:29 -0700 (PDT)
Received: from Osmten.. ([103.84.150.75])
        by smtp.gmail.com with ESMTPSA id n27-20020a638f1b000000b00551df489590sm3654374pgd.12.2023.08.06.08.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 08:18:29 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] selftests: prctl: Add prctl test for PR_GET_NAME
Date:   Sun,  6 Aug 2023 20:18:10 +0500
Message-Id: <20230806151810.9958-1-osmtendev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch covers the testing of PR_GET_NAME by
reading it's value from proc/self/task/pid/comm
and matching it by the value returned by  PR_GET_NAME.

Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
---
 .../selftests/prctl/set-process-name.c        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 3bc5e0e09..41f4b105d 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -47,6 +47,28 @@ int check_null_pointer(char *check_name)
 	return res;
 }
 
+int check_name(void)
+{
+
+	int pid;
+
+	pid = getpid();
+	FILE *fptr;
+	char path[50] = {};
+	int j;
+
+	j = snprintf(path, 50, "/proc/self/task/%d/comm", pid);
+	fptr = fopen(path, "r");
+	char name[TASK_COMM_LEN] = {};
+	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
+	char output[TASK_COMM_LEN] = {};
+
+	fscanf(fptr, "%s", output);
+
+	return !strcmp(output, name);
+
+}
+
 TEST(rename_process) {
 
 	EXPECT_GE(set_name(CHANGE_NAME), 0);
@@ -57,6 +79,9 @@ TEST(rename_process) {
 
 	EXPECT_GE(set_name(CHANGE_NAME), 0);
 	EXPECT_LT(check_null_pointer(CHANGE_NAME), 0);
+
+	EXPECT_TRUE(check_name());
+
 }
 
 TEST_HARNESS_MAIN
-- 
2.34.1

