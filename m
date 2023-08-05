Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7B7712E0
	for <lists+linux-kselftest@lfdr.de>; Sun,  6 Aug 2023 00:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjHEWlg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 18:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHEWlf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 18:41:35 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4119B5;
        Sat,  5 Aug 2023 15:41:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bbf8cb61aeso21419215ad.2;
        Sat, 05 Aug 2023 15:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691275294; x=1691880094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RdojjPd8jvPUy+VY2bdrww/YrOG4FByQTZ03QZtrm54=;
        b=ozZ5l4FBOZxgf7mujZOAtnlb+SkNaxFvIjeBW6mDAZ5T3bifbXM/cMhHRKVjbkZ4NO
         24Dlele9V4ytN3EVZjnD79Jp9Hkf7lW5YpSnnr1CUICs6YtrQxh+D7evr5/k15Fh3b2/
         X3eAGU5mIsacQaDXBruJD0gdL8Mc/u8nAnFjaJIHgT1lQworaCPN5TG/PkJCv8y4bLAO
         14YQwGJ0WhgZjqVzYzyppwA78o6rXU/lqTXUTKMENMiIjQVTYkMk9aBFbp3CcPzdgP6O
         1Ietr4SjTwoc1QN+bSyAboKJq5fNHXFiW4+/bWHMDUVAqDXIbDcIOqMy3la436kU4NHh
         RArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691275294; x=1691880094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RdojjPd8jvPUy+VY2bdrww/YrOG4FByQTZ03QZtrm54=;
        b=V5wNSAlg9JiH82RIt9bK0fpLhhnb7QJpMJh7DvebYfa4T2txB3yz7r+hMqLm+DnEAQ
         CRv+QHBGE6Sj1t/Y5DVOTi3dj3q4fFweHtivMO6JvVksiZssyxwALK/NUgKPYXBPsUnR
         d5V/8vEjs5zTxPjmVq85nVnwfyctHQ+6NsNEB3+twmBmYPlkjUSLS0Rg6Mfu1xbNnsR8
         gHIYXZId6TKzElggshRF9s+GWfsOGXqKg1m+sPZzT6g/lF5OiN/7IOGR7i/F3K+zbJlv
         A0pkh+2m7F57uQQ1MCd3hly5I2dGYZcCgPoAmG24XlTVNbEmompJfocS53UVejiIddw0
         9KxQ==
X-Gm-Message-State: AOJu0Ywk5JAy7Yws/Bt/w1W2EnKZ0YybdkiaOQkJdVJd9MUzoVBawZrZ
        s35D9ykPdavrpZmm8Wlh+l8=
X-Google-Smtp-Source: AGHT+IEr3Ev54+ZX199Mfgcb1yPQS5UrLPN6X4H84L2cml1KstTYje3IxocoRhMgKtwZF3hk0VNjqg==
X-Received: by 2002:a17:902:d48c:b0:1bc:1df2:4c07 with SMTP id c12-20020a170902d48c00b001bc1df24c07mr5554184plg.63.1691275293522;
        Sat, 05 Aug 2023 15:41:33 -0700 (PDT)
Received: from Osmten.. ([103.84.150.77])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001a6a6169d45sm3960358plh.168.2023.08.05.15.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 15:41:33 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     =shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] selftests: prctl: Add prctl test for PR_GET_NAME
Date:   Sun,  6 Aug 2023 03:41:15 +0500
Message-Id: <20230805224115.22540-1-osmtendev@gmail.com>
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

