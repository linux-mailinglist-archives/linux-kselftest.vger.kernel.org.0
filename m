Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CE0667FA9
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjALTyR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240260AbjALTxw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46946C61
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAB9D62161
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47950C4339C;
        Thu, 12 Jan 2023 19:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553147;
        bh=QmqB4tlR6U8BFzd9JJsRGVi0Xek+w56l/71nPQDypns=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=KIs0ci0945zkDLMc7Y6BAH0Ni/LilgpVNeItZVTHSuduQ7WOU1VP06/ejmjckdMQM
         G6YZ8jDGWqdOTG1VUqCEOJMyJKhSHcWWK44Vi5sfT9xdz7kylarWRYDC5NCWrEwhn0
         2XkBFe4HfWOXct/y/5sGlG/3tPG0MDzC60zjXA3xK7Xg8NQustBSYW7BJLtsRScLsa
         C/HP7kQBZQIUxdMQJ03bIhN5mVttu3e7Xl6n/sogpBfnxoCuTwRDZyKHWLyy1gk49u
         xyTDf/a1cg8mh7E6Q4QldVQ3OeGlEpAZSqpIayrO1uk7+6Fj7nmej6R8k8256NEzFj
         ATHMB9OwPM8aw==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 12 Jan 2023 19:51:51 +0000
Subject: [PATCH 5/6] kselftest/arm64: Support build of MTE tests with clang
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-clang-v1-5-89c69d377727@kernel.org>
References: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
In-Reply-To: <20230111-arm64-kselftest-clang-v1-0-89c69d377727@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-8b3d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1910; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QmqB4tlR6U8BFzd9JJsRGVi0Xek+w56l/71nPQDypns=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjwGTr/dveUlthPKb/Jm4BV50ZdjQ/TD3DOUtj2slE
 oMqCu46JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8Bk6wAKCRAk1otyXVSH0HCQB/
 9LqXrVxyKEjXgtmcxf4ooUM7a26O3dIUTegMwxRUwnw0rLT6g/LlcZbYkpn8Ay1bW+jEYHFwE5muhd
 5N5SNPCvyA3cs/Swv20RuvXlTnBDaDw0TvGoH/bSvJEWeUOSrwLbdydIs8/5i5p7kX2+6yZQNhVvji
 FgxBkBj5qPcjDLXpMrSWMKQQ+NqWqX0fojOETQwmYnfYUetWSRBt1KPufCuwx6Hjom5jOSRxvnx1F0
 a369jjQ81c7RQUq0rzsSpjHglsYLbMWbbZXrYD9F7NiGAsZxSYvfEiv8PD381z6AM+e/d2pMdnqZHn
 qbbmYvAXdzHJ73eOc9vhkiGvs+wt2d
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The assembly portions of the MTE selftests need to be built with a
toolchain supporting MTE.  Since we support GCC versions that lack MTE
support we have logic to suppress build of these tests when using such a
toolchain but that logic is broken for LLVM=1 builds, it uses CC but CC
is only set for LLVM builds in libs.mk which needs to be included after
we have selected which test programs to build.

Since all supported LLVM versions support MTE we can simply assume MTE
support when LLVM is set.  This is not a thing of beauty but it does the
job.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/Makefile | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index 037046f5784e..fdb9acdca42b 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -1,19 +1,29 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2020 ARM Limited
 
-# preserve CC value from top level Makefile
-ifeq ($(CC),cc)
-CC := $(CROSS_COMPILE)gcc
-endif
-
 CFLAGS += -std=gnu99 -I. -pthread
 LDFLAGS += -pthread
 SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
 
+ifeq ($(LLVM),)
+# For GCC check that the toolchain has MTE support.
+
+# preserve CC value from top level Makefile
+ifeq ($(CC),cc)
+CC := $(CROSS_COMPILE)gcc
+endif
+
 #check if the compiler works well
 mte_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.5-a+memtag -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
 
+else
+
+# All supported clang versions also support MTE.
+mte_cc_support := 1
+
+endif
+
 ifeq ($(mte_cc_support),1)
 # Generated binaries to be installed by top KSFT script
 TEST_GEN_PROGS := $(PROGS)

-- 
2.30.2
