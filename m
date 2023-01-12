Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB66A667FAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jan 2023 20:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjALTyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 Jan 2023 14:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240256AbjALTxw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Jan 2023 14:53:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE63AC
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 11:52:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A2FE6216F
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Jan 2023 19:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D1C433F1;
        Thu, 12 Jan 2023 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673553142;
        bh=N+rkOUdz8pFlkVOQJ7wMoEbs6vwb9dQCS+jyjI4yr0w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=sEwDAdHG+WS9hN6kyw8Xez5NVsbVf5Kn1PAxwDW2AOp1xcpAf/IrQaE5jWWWN9Mp7
         Q3GV8VUZsbrM4LNoU+EpIKpq4uyeydyXxODfl+eSg/4TRFTwvFNERkbamnGdvxFWRT
         pClywv+UHvLXlSHlloHydDWFKk5lm+EtoViBRPt9+1kx2PXy9zwJrjIa+I1OS4Lq42
         T+GnVHdkixPsxMOplHZVpRfekMXgs2baCetD91ADVBAnvNuOsm5NW7dzFEjzYHTGed
         +ZZznKUSAda2/dZTDSFvw5a0r9UNM9iBxinm+CKBprUuegAZnZ4Dnnq9YeX1+o2TPN
         jvG/iN8MRRDBA==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 12 Jan 2023 19:51:49 +0000
Subject: [PATCH 3/6] kselftest/arm64: Don't pass headers to the compiler as source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230111-arm64-kselftest-clang-v1-3-89c69d377727@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2253; i=broonie@kernel.org;
 h=from:subject:message-id; bh=N+rkOUdz8pFlkVOQJ7wMoEbs6vwb9dQCS+jyjI4yr0w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjwGTp/f4zdF4G6Q+1ACaPAaVth3j1KTCyjFadZQDV
 xgtTaKqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8Bk6QAKCRAk1otyXVSH0JMOB/
 0WNFW0Jm+7kLZdGWl+VaZ4OSqlRsDp8yCHKDqTnxQ2j1ByMorud1Sz50ptaH+0Upm4QDcreK+/zn4Y
 pdD1M2iLk5LIZQBNe/8V8A8wH08UK3vPG2JCZczQdKZI97s9r/a1zCvi8iu5K+IiW1s4MttKQZPjMx
 /rzViMmQPmSakWp2GgIq9ia2dKXh5Re8n126CU6xcOjhcP2zelOvr7+kzpF3t+kGCOgC18f9Ey3AfU
 CJxRzx7HKv1nEK70BMoDC/cNW6boL8JvetV5j/Bhmrq6VEKp99pcQSPCo8vz/IsgTAQUtrwyAQSi3w
 MAmOeCOOy+wsQm/7vdl92ihLsD6Mxi
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

The signal Makefile rules pass all the dependencies for each executable,
including headers, to the compiler which GCC is happy enough with but
clang rejects:

   clang --target=aarch64-none-linux-gnu -fintegrated-as -Wall -O2 -g -I/home/broonie/git/linux/tools/testing/selftests/ -isystem /home/broonie/git/linux/usr/include -D_GNU_SOURCE -std=gnu99 -I.  test_signals.c test_signals_utils.c testcases/testcases.c signals.S testcases/fake_sigreturn_bad_magic.c test_signals.h test_signals_utils.h testcases/testcases.h -o testcases/fake_sigreturn_bad_magic
  clang: error: cannot specify -o when generating multiple output files

This happens because clang gets confused about what to do with the
header files, failing to identify them as source.  This is not amazing
behaviour on clang's part and should ideally be fixed but even if that
happens we'd still need a new clang release so let's instead rework the
Makefile so we use variables for the lists of header and source files,
allowing us to only pass the source files to the compiler and keep clang
happy.

As a bonus the resulting Makefile is a bit easier to read.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/Makefile | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index be7520a863b0..8f5febaf1a9a 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -22,6 +22,10 @@ $(TEST_GEN_PROGS): $(PROGS)
 
 # Common test-unit targets to build common-layout test-cases executables
 # Needs secondary expansion to properly include the testcase c-file in pre-reqs
+COMMON_SOURCES := test_signals.c test_signals_utils.c testcases/testcases.c \
+	signals.S
+COMMON_HEADERS := test_signals.h test_signals_utils.h testcases/testcases.h
+
 .SECONDEXPANSION:
-$(PROGS): test_signals.c test_signals_utils.c testcases/testcases.c signals.S $$@.c test_signals.h test_signals_utils.h testcases/testcases.h
-	$(CC) $(CFLAGS) $^ -o $@
+$(PROGS): $$@.c ${COMMON_SOURCES} ${COMMON_HEADERS}
+	$(CC) $(CFLAGS) ${@}.c ${COMMON_SOURCES} -o $@

-- 
2.30.2
