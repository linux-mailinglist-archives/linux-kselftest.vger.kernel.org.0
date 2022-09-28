Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628D5EE0C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Sep 2022 17:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiI1Ppe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Sep 2022 11:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233482AbiI1Ppc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Sep 2022 11:45:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E22979A5A
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 08:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6B3261F05
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Sep 2022 15:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7DBFC433D6;
        Wed, 28 Sep 2022 15:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664379924;
        bh=qDWF7fp8uWmzWje++ap1egHoqbz0xH4/LR9Kc+omayM=;
        h=From:To:Cc:Subject:Date:From;
        b=jc/9ktrsu6ePu6lVGM+jMSwaYzNu1LeXSSJeCUq9SrTj3cl2nK1T4M3Fv/jID8U/j
         Krta78B6Hqd6iXEejjS+jk3gUl3sc8ROi1LCbqWi5JMZ8u9LlGsn4cOB0uMDEGtUej
         JE4bgMIIp/e3/4BJcQ7MdIcX2nE5+0ACalIWnURBPjF7MficWXWrGk7YwUyx3JmSYC
         M/UqezUgVXSmE6epWnt8PGDsmSJw39Gheu+chhQyrePfJCJFx3D+1JJWAKdJU4UINr
         hX5jdz2CGoSpz8VUQJXx3G60srtfYhjLmTHCEZ8SxMa9lgiKsb/hf1Ivf5yxLrgEBW
         KY2hgLX1pV1kw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Don't enable v8.5 for MTE selftest builds
Date:   Wed, 28 Sep 2022 16:45:17 +0100
Message-Id: <20220928154517.173108-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=broonie@kernel.org; h=from:subject; bh=qDWF7fp8uWmzWje++ap1egHoqbz0xH4/LR9Kc+omayM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjNGwNn5NkJgjWhN6gGtCbfZGLAJAFbGTOzJfk/QMY UFaOOvSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYzRsDQAKCRAk1otyXVSH0Mt1B/ 0X45fCXofrC3m99dx7owcMUueeP7ZFxgB4KvR7WF6XNXXFx+IaUu1K/CKpInfeyQgRry1tZth66OWs 2wB2IDvOkbixxoBKB+Urd+qM+5wIu0ZHR30IVyJclNVz1JzJalngufCGfVh+nPuN1ZbCZoCuA/yV5g HhmHwazHBQugMFV8dMqq+AG8F8H7AmA4A40bWT+i2TSs2Znu8W+ayHcLmWcBeggo1cQZ5PtOwa1gm5 ehZxhygXYKBJOVnOy+dVqQu/m7u5yCEIakjsNvsa5qTW0OwReKk6gBuEVxwu35Boi1EMkMy5Cbr+UC bJPcOy0nP9vpsoz6qzF6B2/XdojbzM
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we set -march=armv8.5+memtag when building the MTE selftests,
allowing the compiler to emit v8.5 and MTE instructions for anything it
generates. This means that we may get code that will generate SIGILLs when
run on older systems rather than skipping on non-MTE systems as should be
the case. Most toolchains don't select any incompatible instructions but
I have seen some reports which suggest that some may be appearing which do
so. This is also potentially problematic in that if the compiler chooses to
emit any MTE instructions for the C code it may interfere with the MTE
usage we are trying to test.

Since the only reason we are specifying this option is to allow us to
assemble MTE instructions in mte_helper.S we can avoid these issues by
moving to using a .arch directive there and adding the -march explicitly to
the toolchain support check instead of the generic CFLAGS.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/mte/Makefile     | 5 +----
 tools/testing/selftests/arm64/mte/mte_helper.S | 2 ++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/mte/Makefile b/tools/testing/selftests/arm64/mte/Makefile
index a5a0744423d8..037046f5784e 100644
--- a/tools/testing/selftests/arm64/mte/Makefile
+++ b/tools/testing/selftests/arm64/mte/Makefile
@@ -11,11 +11,8 @@ LDFLAGS += -pthread
 SRCS := $(filter-out mte_common_util.c,$(wildcard *.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
 
-#Add mte compiler option
-CFLAGS += -march=armv8.5-a+memtag
-
 #check if the compiler works well
-mte_cc_support := $(shell if ($(CC) $(CFLAGS) -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
+mte_cc_support := $(shell if ($(CC) $(CFLAGS) -march=armv8.5-a+memtag -E -x c /dev/null -o /dev/null 2>&1) then echo "1"; fi)
 
 ifeq ($(mte_cc_support),1)
 # Generated binaries to be installed by top KSFT script
diff --git a/tools/testing/selftests/arm64/mte/mte_helper.S b/tools/testing/selftests/arm64/mte/mte_helper.S
index a02c04cd0aac..a55dbbc56ed1 100644
--- a/tools/testing/selftests/arm64/mte/mte_helper.S
+++ b/tools/testing/selftests/arm64/mte/mte_helper.S
@@ -3,6 +3,8 @@
 
 #include "mte_def.h"
 
+.arch	armv8.5-a+memtag
+
 #define ENTRY(name) \
 	.globl name ;\
 	.p2align 2;\
-- 
2.30.2

