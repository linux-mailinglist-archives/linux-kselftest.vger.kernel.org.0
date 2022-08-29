Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1825A506A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiH2Pp0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiH2PpZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:45:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2CC42AFA
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:45:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 337DFB81103
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:45:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8450C433D6;
        Mon, 29 Aug 2022 15:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661787921;
        bh=kNdHaT/qXo9Kq6Jc4eiXI0BUtp2IIIBIqz43Sl64nEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EpkcwpwURjzKaN2sfilGwsxY5WHbq0JgLGPxJCN+ADgsZd9hJGplb15aULQLEKKZs
         XIcBEHNGuQmnqjg20ixZJxnCxwdbUKi934XpurxT8SW4F2SEUyWZsW3beCDDhp8ziF
         vxhkx/HT/3sD2vlSltSnRztvNCO258efHMfUfJ35/uHgtQ40V79z5Tl7Ntme2rZSeb
         gQOjtd3IBrViM+HBV/d1Ss4s3qGyDwaM+OGAlXYHBv8H6DRZmFfwJobEG9uOVedqlb
         1RCBcZJWCoUvWaY4mJ4r+A+Wx0c2eDD7SobuGZ05crA6axG7hJytxabo4wSBcResw2
         E5QpsPjwSOpHA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 3/4] kselftest/arm64: Install signal handlers before output in FP stress tests
Date:   Mon, 29 Aug 2022 16:44:51 +0100
Message-Id: <20220829154452.824870-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154452.824870-1-broonie@kernel.org>
References: <20220829154452.824870-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4901; i=broonie@kernel.org; h=from:subject; bh=kNdHaT/qXo9Kq6Jc4eiXI0BUtp2IIIBIqz43Sl64nEs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN7yQi1NRIvlvkjpPxaq0uvNtOfGYvSkbW0u6zLK Ry5YQ6mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwze8gAKCRAk1otyXVSH0N81B/ 9fKbpb7nW5DOcshCUukMTjmiU3A6F7/cZT3Fr0Gr2p1HSP3ivuRbbImuET662r6ep4Copn6NRp64TI O5mjQBsKypVcv/C02HU+BhTglWd3MFutcnLgyrqJ+rfnQo0f46NUvIMACZmItJYl+czbmgRqEhgmG8 hR+7SxOuhVUoAV8vQeDU0wYo9S2Zue6rUs0OIOzc40SEz+iaT15J1k9hWa3sLQ7wYLqSIGrD+CXTUS seplFoQQ7bIpjKKp117W1BGbqxqishV/CIh3X2LSqK7E6wsqC1DCiG+D68E2xWL06GFMF3Fa88K4Wu 9jYSdiF2pEzfHDJ8qoMaoeAE3fI5C9
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

To interface more robustly with other processes install the signal handers
in the floating point stress tests before we produce any output, this
means that a parent process can know that if it has seen any output from
the test then the test is ready to handle incoming signals.
---
 .../testing/selftests/arm64/fp/fpsimd-test.S  | 48 +++++++++----------
 tools/testing/selftests/arm64/fp/sve-test.S   | 48 +++++++++----------
 tools/testing/selftests/arm64/fp/za-test.S    | 48 +++++++++----------
 3 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fpsimd-test.S b/tools/testing/selftests/arm64/fp/fpsimd-test.S
index f0f92192351a..918d04885a33 100644
--- a/tools/testing/selftests/arm64/fp/fpsimd-test.S
+++ b/tools/testing/selftests/arm64/fp/fpsimd-test.S
@@ -216,6 +216,30 @@ endfunction
 .globl _start
 function _start
 _start:
+	mov	x23, #0		// signal count
+
+	mov	w0, #SIGINT
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGTERM
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGUSR1
+	adr	x1, irritator_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 	// Sanity-check and report the vector length
 
 	mov	x19, #128
@@ -246,30 +270,6 @@ _start:
 	mov	x0, x20
 	bl	putdecn
 
-	mov	x23, #0		// Irritation signal count
-
-	mov	w0, #SIGINT
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGTERM
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGUSR1
-	adr	x1, irritator_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
-	mov	w0, #SIGUSR2
-	adr	x1, tickle_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index 79c56e6c5b23..2a18cb4c528c 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -379,6 +379,30 @@ endfunction
 .globl _start
 function _start
 _start:
+	mov	x23, #0		// Irritation signal count
+
+	mov	w0, #SIGINT
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGTERM
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGUSR1
+	adr	x1, irritator_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 #ifdef SSVE
 	puts	"Streaming mode "
 	smstart_sm
@@ -414,30 +438,6 @@ _start:
 	mov	x0, x20
 	bl	putdecn
 
-	mov	x23, #0		// Irritation signal count
-
-	mov	w0, #SIGINT
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGTERM
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGUSR1
-	adr	x1, irritator_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
-	mov	w0, #SIGUSR2
-	adr	x1, tickle_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
 #ifdef SSVE
 	smstart_sm		// syscalls will have exited streaming mode
 #endif
diff --git a/tools/testing/selftests/arm64/fp/za-test.S b/tools/testing/selftests/arm64/fp/za-test.S
index 901839107205..53c54af65704 100644
--- a/tools/testing/selftests/arm64/fp/za-test.S
+++ b/tools/testing/selftests/arm64/fp/za-test.S
@@ -232,6 +232,30 @@ endfunction
 .globl _start
 function _start
 _start:
+	mov	x23, #0		// signal count
+
+	mov	w0, #SIGINT
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGTERM
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGUSR1
+	adr	x1, irritator_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	mov	w0, #SIGUSR2
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
 	puts	"Streaming mode "
 	smstart_za
 
@@ -264,30 +288,6 @@ _start:
 	mov	x0, x20
 	bl	putdecn
 
-	mov	x23, #0		// Irritation signal count
-
-	mov	w0, #SIGINT
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGTERM
-	adr	x1, terminate_handler
-	mov	w2, #SA_SIGINFO
-	bl	setsignal
-
-	mov	w0, #SIGUSR1
-	adr	x1, irritator_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
-	mov	w0, #SIGUSR2
-	adr	x1, tickle_handler
-	mov	w2, #SA_SIGINFO
-	orr	w2, w2, #SA_NODEFER
-	bl	setsignal
-
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 	rdsvl	0, 8
-- 
2.30.2

