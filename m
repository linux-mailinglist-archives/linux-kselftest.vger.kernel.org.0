Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE64724AAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 19:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjFFR4H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjFFR4F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 13:56:05 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7EBE47;
        Tue,  6 Jun 2023 10:56:03 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1ac373c9eso61864451fa.0;
        Tue, 06 Jun 2023 10:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686074162; x=1688666162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7V43niT3bFuzcXVb3owqhMz6/rSNqxbUJG0mdfeT+pM=;
        b=j6sD2SnD9ZobF4KFq0rNVOUnr9PigavlPpCS0RKJelwFZOncbRQbPqXbppk3E8bwMv
         VbXO4i61rpW2enpq8P5ywFpxth5rLOO37QxF4i5DpeFGFg1VvfLHIFjevempn8PPq4zr
         4ZIFNQKVJcRy3hsHlS6uxHFPjc2upAjZZWV7dt/1XAmVP/R4rT0Z8myheU4K7yZuKZwt
         BwMrmSKCyRjah5zoJNskAuRtTObMy4qTEv15JlI7o7xWCJTXB+X6FwG74uKxTJlY+OzQ
         FruvtptPFkRT+raByoLx4drv8zBKIijVtLwjqEMf8JLNuug01OqbtZuNZic0YMsvjk4O
         9cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686074162; x=1688666162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7V43niT3bFuzcXVb3owqhMz6/rSNqxbUJG0mdfeT+pM=;
        b=QIpNLZ2fZ4Z3Dkc4hUOTVDtRaFsTJfc+rBuCaxcAUpUhfQIu2X5j0G2qoJvetjCxUP
         2d7zWwKXYhbMSFP8WyF6uN7sbh1Rh3WoenHXnDijXMIyRXk4zXoul7EmJMVdLRC7ynsZ
         SWfMmUGoc6tuZ5uK1C11fpgRsw3w/UJg/4B07OvwJhMrJc6ZhFxHGPvk9YsDDuSJrUAx
         DjkWrQ4ltnolxlzFIaD8UYUp4e1CfUCUhUbHHxE7L//gGGdjA8dcKEpl0SZqKOkcjVeC
         Ntdj3OoAK5vO94CmXAkqTX+MiiX9BNs46kTT0rS1W/nhaYDhSRISJyttJDiIdpOdb9bq
         x6OQ==
X-Gm-Message-State: AC+VfDw1nMqQubRUx4WrtJz/iU1VwXyJnxC4hxalnPO5iO1npMZ2L0Wv
        x2icCJzcD/kGG0SAo0+61LEw7Hp1ow8=
X-Google-Smtp-Source: ACHHUZ4ml9ySl8HNd4W0ORtwXUhAa1ymIB9lg5eJpAeBM3PnMpITkKDawtKemHbOYQv1iWpk4BcxwQ==
X-Received: by 2002:a2e:9215:0:b0:2b1:a810:e442 with SMTP id k21-20020a2e9215000000b002b1a810e442mr1354865ljg.49.1686074161246;
        Tue, 06 Jun 2023 10:56:01 -0700 (PDT)
Received: from Osmten.. ([103.84.150.69])
        by smtp.gmail.com with ESMTPSA id y4-20020a05651c020400b002ab1536377fsm1892439ljn.105.2023.06.06.10.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 10:56:00 -0700 (PDT)
From:   Osama Muhammad <osmtendev@gmail.com>
To:     shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ivan.orlov0322@gmail.com, Osama Muhammad <osmtendev@gmail.com>
Subject: [PATCH] selftests: prctl: Add new prctl test for PR_SET_NAME
Date:   Tue,  6 Jun 2023 22:55:15 +0500
Message-Id: <20230606175515.12855-1-osmtendev@gmail.com>
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
 tools/testing/selftests/prctl/Makefile        |  2 +-
 .../selftests/prctl/set-process-name.c        | 61 +++++++++++++++++++
 2 files changed, 62 insertions(+), 1 deletion(-)
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
index 000000000..12c5ed9a5
--- /dev/null
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -0,0 +1,61 @@
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
+	char name[16];
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

