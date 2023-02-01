Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D7667E739
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jan 2023 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233662AbjA0N6K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Jan 2023 08:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233365AbjA0N6H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Jan 2023 08:58:07 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6437F3C2B;
        Fri, 27 Jan 2023 05:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1674827881;
        bh=/r5DrLF/JnnrCyCX+xyiU+do3tg3tLC+bmepKRA47SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXTtFhpPzdgYG0kWDxPuCWBOGn63bUivm1Qkx8RL2J1DKR6JezXMTe57Xb0u1Woyk
         duXtqsizw3Sk+rzlOfaVTFsKD3vF8YOfiIh5a8l32QiISEwkxtcIgeWz8ChyJA58rg
         b5IHx+VJzziALJI9w5RORpbA/Mi+klhKLRtvdJvcqf6FYAlcp73xAoXhSVaZ3Erulb
         ZrSOmGP5eUSBvYtKoPDLmzzUnaa3t2Bmu2VCoEcPWjzUVrtzw2NZvRT9dlTLunqkCd
         kT2TyJSr7HvOYbf4oK9fB7JMruYfgk3gOdxaC6PiwdeAwoeaukjdYi2XDo9HnCF5rC
         SqJcADq/6/Icg==
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4P3K0T2SkNzhT6;
        Fri, 27 Jan 2023 08:58:01 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        stable@vger.kernel.org
Subject: [PATCH 01/34] selftests: arm64: Fix incorrect kernel headers search path
Date:   Fri, 27 Jan 2023 08:57:22 -0500
Message-Id: <20230127135755.79929-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
building against kernel headers from the build environment in scenarios
where kernel headers are installed into a specific output directory
(O=...).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>
Cc: <stable@vger.kernel.org>    [5.18+]
---
 tools/testing/selftests/arm64/fp/Makefile   | 2 +-
 tools/testing/selftests/arm64/tags/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 36db61358ed5..932ec8792316 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -3,7 +3,7 @@
 # A proper top_srcdir is needed by KSFT(lib.mk)
 top_srcdir = $(realpath ../../../../../)
 
-CFLAGS += -I$(top_srcdir)/usr/include/
+CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := fp-stress \
 	sve-ptrace sve-probe-vls \
diff --git a/tools/testing/selftests/arm64/tags/Makefile b/tools/testing/selftests/arm64/tags/Makefile
index 41cb75070511..6d29cfde43a2 100644
--- a/tools/testing/selftests/arm64/tags/Makefile
+++ b/tools/testing/selftests/arm64/tags/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS += -I../../../../../usr/include/
+CFLAGS += $(KHDR_INCLUDES)
 TEST_GEN_PROGS := tags_test
 TEST_PROGS := run_tags_test.sh
 
-- 
2.25.1

