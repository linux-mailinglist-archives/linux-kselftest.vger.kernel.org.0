Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F49592F53
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiHONDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiHONDx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:03:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C18713F1E
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:03:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DE79B80DBE
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76E91C433C1;
        Mon, 15 Aug 2022 13:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660568629;
        bh=kNdHaT/qXo9Kq6Jc4eiXI0BUtp2IIIBIqz43Sl64nEs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPxJiV/qqyhw9KSXL+PxrwYtEdsihmluKqsJeuPUzyzOAd25OzEYHJLMFNL9ys/N/
         aETHOq8+33plC17/bkzzA3UrFXBkl0kC8kN+Lf8+iA0o34eUJZC4DPWyX/NDPHT6bX
         v3Gda9hAJM7DziX8T5/zOvqyTYYEWUIrxQzSZSu0/jtGJmae8Wc8r4aAqJzeG+PH07
         +LA0J+XMMNfgxLMVA9O991fKeJ8q3124JMom7zQfJR0cDm7XAzaj0Fk4M5GMthEJGm
         GU01w+x3v7ym8h6FTEuF5LdOJ+QgXduuvMbLNNGdpRLSGpx4lYzA86yt9Wkv9uycvC
         SRpmosPF4YnBA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/4] kselftest/arm64: Install signal handlers before output in FP stress tests
Date:   Mon, 15 Aug 2022 14:02:01 +0100
Message-Id: <20220815130202.204725-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815130202.204725-1-broonie@kernel.org>
References: <20220815130202.204725-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4901; i=broonie@kernel.org; h=from:subject; bh=kNdHaT/qXo9Kq6Jc4eiXI0BUtp2IIIBIqz43Sl64nEs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kPJQi1NRIvlvkjpPxaq0uvNtOfGYvSkbW0u6zLK Ry5YQ6mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpDyQAKCRAk1otyXVSH0MTgB/ wP/j7QroSJw8QwgInMAiq8evLha53kC78RbtCYO+8SqngPSEmRwpvgzY9+lo7OplbUKZWuKuaIP6/5 nEvuFZaq/eYCKvBhjrtYKnETwUKs4bhUp8ouE81rgNrdORv8tMow9wyQNKVPytORgYgA2WPp6/FacB l9xYm5XxNOkxKpLHi4a5koZMCV88G23ldSoMhvHoFMzBpM+SgHI6DSd+ugh7D+GgT254T5EsEpb0/E YSL2Y/bQ4fO6x5dMHBzVifx6YodWOS/1hMiuYpGgKSOxlLWI1OErXD6ViA4J1CxEqOkgMhl13BQrJv m0dC2Jvs4jphq/2w9IWP5goj6mbpn3
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

