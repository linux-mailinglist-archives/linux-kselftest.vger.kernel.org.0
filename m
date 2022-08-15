Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B864592F54
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiHONDv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbiHONDu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9D13E9D
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44411B80D2B
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69378C43470;
        Mon, 15 Aug 2022 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568627;
        bh=2Si0x5Wt8X911XbNVwx9q2J5SXvI/CwwHwm3xOjswWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdTQ43NgSaVvH6bY3z2XQla0O+3FLlmPY6n6/Qzs9XZZVLUUSgJrERYz2CbUhXy9L
         xQkq4Q3DtMwTP3wYo9F6WrVvlNoDIK8ZeB8CvTsGzpTgNZzOf+8mX2vgmiG6DOrrE2
         WRuwfTRCu1Fd2a9ySKG72e7onjVbEI3jYwyVNNnBmdHGDF5r/7S0krn7GW89vHqO6q
         AnOy7o2v1WTHk63s+fuCe8QCYd4OZrlo3zC9yyF29Q5lPL72X8q1StsuuXAHXGzbD/
         qsmUeHcgI744o2aj8w7/WUrlqr4pCN89mli7F/MagcyoFvT2A6UE1y52Ms4jQYsGPq
         IRD21hpmLCt5g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] kselftest/arm64: Count SIGUSR2 deliveries in FP stress tests
Date:   Mon, 15 Aug 2022 14:02:00 +0100
Message-Id: <20220815130202.204725-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815130202.204725-1-broonie@kernel.org>
References: <20220815130202.204725-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3816; i=broonie@kernel.org; h=from:subject; bh=2Si0x5Wt8X911XbNVwx9q2J5SXvI/CwwHwm3xOjswWI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kPInn+GZTzehYWYbpnfF1/guI9H2jGyssDUk+4Z ffBe6jGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpDyAAKCRAk1otyXVSH0JQ3B/ 47NrUNfZIMRqlr4f/lpSDCcdhux4LiULW/Nz21Rqs3B73D9jvXWQo3jK0P+TCtDxf4gDNWa2An9UPx GnkQdqTSfk0L2VRUvEgBflsw9f1BJ4QMmgKQvhyBUbeLjcqvjNSH2A3wlCZnkkCaiADwYL2nAZGuNB sPfE5KAp82ggZ1nzeC9w8z5Iw2/E3V9T5GFkpj85WsVO7VWRzlN+qvhJrL3GX8K05XQF7P6Vnile9w XLQUH7cVP9zO4XJeM5ElUrZ2OQ7RPKdixr7yA3AWfR8/5neswJp6CruLsD8sd0TCnf+nXtOT5eUCnv MeVh2safEw/4wGETfWxYYP73e2V3rc
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the floating point stress tests mostly support testing that the
data they are checking can be disrupted from a signal handler triggered by
SIGUSR1. This is not properly implemented for all the tests and in testing
is frequently modified to just handle the signal without corrupting data in
order to ensure that signal handling does not corrupt data. Directly support
this usage by installing a SIGUSR2 handler which simply counts the signal
delivery.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/asm-offsets.h |  1 +
 tools/testing/selftests/arm64/fp/fpsimd-test.S | 15 +++++++++++++++
 tools/testing/selftests/arm64/fp/sve-test.S    | 15 +++++++++++++++
 tools/testing/selftests/arm64/fp/za-test.S     | 15 +++++++++++++++
 4 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/asm-offsets.h b/tools/testing/selftests/arm64/fp/asm-offsets.h
index a180851496ec..757b2fd75dd7 100644
--- a/tools/testing/selftests/arm64/fp/asm-offsets.h
+++ b/tools/testing/selftests/arm64/fp/asm-offsets.h
@@ -3,6 +3,7 @@
 #define sa_handler 0
 #define sa_mask_sz 8
 #define SIGUSR1 10
+#define SIGUSR2 12
 #define SIGTERM 15
 #define SIGINT 2
 #define SIGABRT 6
diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index e21e8ea52c7e..f0f92192351a 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -151,6 +151,15 @@ function irritator_handler
 	ret
 endfunction
 
+function tickle_handler
+	// Increment the signal count (x23):
+	ldr	x0, [x2, #ucontext_regs + 8 * 23]
+	add	x0, x0, #1
+	str	x0, [x2, #ucontext_regs + 8 * 23]
+
+	ret
+endfunction
+
 function terminate_handler
 	mov	w21, w0
 	mov	x20, x2
@@ -255,6 +264,12 @@ _start:
 	orr	w2, w2, #SA_NODEFER
 	bl	setsignal
 
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 589264231a2d..79c56e6c5b23 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -314,6 +314,15 @@ function irritator_handler
 	ret
 endfunction
 
+function tickle_handler
+	// Increment the signal count (x23):
+	ldr	x0, [x2, #ucontext_regs + 8 * 23]
+	add	x0, x0, #1
+	str	x0, [x2, #ucontext_regs + 8 * 23]
+
+	ret
+endfunction
+
 function terminate_handler
 	mov	w21, w0
 	mov	x20, x2
@@ -423,6 +432,12 @@ _start:
 	orr	w2, w2, #SA_NODEFER
 	bl	setsignal
 
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 #ifdef SSVE
 	smstart_sm		// syscalls will have exited streaming mode
 #endif
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 2dd358f9edf2..901839107205 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -167,6 +167,15 @@ function irritator_handler
 	ret
 endfunction
 
+function tickle_handler
+	// Increment the signal count (x23):
+	ldr	x0, [x2, #ucontext_regs + 8 * 23]
+	add	x0, x0, #1
+	str	x0, [x2, #ucontext_regs + 8 * 23]
+
+	ret
+endfunction
+
 function terminate_handler
 	mov	w21, w0
 	mov	x20, x2
@@ -273,6 +282,12 @@ _start:
 	orr	w2, w2, #SA_NODEFER
 	bl	setsignal
 
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 	rdsvl	0, 8
-- 
2.30.2

