Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7C5AF796
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 00:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiIFWCH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 18:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiIFWCH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 18:02:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9979BB4A
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 15:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE656B81A76
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Sep 2022 22:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A8EC433D6;
        Tue,  6 Sep 2022 22:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662501723;
        bh=K8oZMRiTP6csOh1stCbMxqGuXdt/4TmVB2Ei7geRoCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=CkWoVHzUv1m1/cD2AtfCezWJjca88b8MlCqk35K7BNo7aj7ohHehnSg4jjAh4lZOB
         pwpF65wnTruRRaOyu3A9Mc447adevkItn5CSkaeMEy70Il14n0lOTsXFuvnPpsFxNJ
         lQd/dd9YULoQWs4/ropDOKMTlrDq4/yrAD/PHkzpgKGndCy3S8PsjgRnV8EwI53qY7
         Izl/zLbm7wEwI4dT+MXOKDhsWlTIYei7tPDfyxXVoxe1NrcgaMXVnM+UcJ+us/bW7S
         H8nzkHhnb94azY0u3pO6YEBhAUjrh6USdv0iSfQM6AiWYEK/FvWkkz9aLN/wZR8lR2
         hxYe+npctjriA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: Install signal handlers before output in FP stress tests
Date:   Tue,  6 Sep 2022 23:00:56 +0100
Message-Id: <20220906220056.820295-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5019; i=broonie@kernel.org; h=from:subject; bh=K8oZMRiTP6csOh1stCbMxqGuXdt/4TmVB2Ei7geRoCQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjF8MYW2JMRd6zhGWcSAFrHyngiSAl5WCyVX1A2Xg2 A58kK0+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYxfDGAAKCRAk1otyXVSH0BRlB/ 4yo0X1ss8dg2eL2d3hgFWQ2te1ZcuN8Z0Np0pjx5IPCsy/YT5NkawOEK3/S6kYJqdb4G9wXZZL1YYo kypYgl1sj0buUftF8HNpsn3Y35Q9902XAtZthYpnkf9ttR1GXe7T4FTcGICsg5WDEHVzuMmvc7zgk0 dxuzOqEbKuM9DXO3uLfOTUeN/2/mkP2ur6PEAbuiDKpsY7PmEQh2toD/5cRV/yxRUYOqagz/2a85KM o5BKLVNzDGAXl3tjFJQNklovnA55ToNfQW5rAgl1A/SpyQKHdiyOR/n4IWzYtZ+bWrVlgkAhfZ2qSh v34Dn3/GtvTVeFeijHzhC7fT+JLG0U
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

Signed-off-by: Mark Brown <broonie@kernel.org>
---

Resending with signoff added, was missed on previous postings.

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

