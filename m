Return-Path: <linux-kselftest+bounces-7920-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B268A4288
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 15:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52CC6B212F8
	for <lists+linux-kselftest@lfdr.de>; Sun, 14 Apr 2024 13:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490647F79;
	Sun, 14 Apr 2024 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WE6XktZc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B9F45BFA;
	Sun, 14 Apr 2024 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100673; cv=none; b=SLnYJ9vlp43QYwUpodbumtt+nhkGbeI53xE+l0VOyE5KHIa9qM2eDVBc8wrm5qr9uixhveevP+wIHUcdRNzqB8nEsvSdzBlX3ABEmjdvabZX35UZeHVdL0ezQVhw2fLmSywp5/VMlpvkaFLRKymbVLRZR0maUOxLuoLyGyiK/1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100673; c=relaxed/simple;
	bh=LgG/w5qdFetHcwqOkNqngUxFET9OESjfCC+ZDPdjLeA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ME58qtXa0GiMnYSzEcC1M7bOqSeKYx0f1nwTasNSjlRf15MqfWZiNgTEM6UVyUcWfoW5CYntd3do7M5WsmX+gstXRvtpuiDlQTdswg4Ajjx0MJXYrArbW3LjW4OtsRiqTH//UUkQtbo0KZa9lk4txdWR0+Qqw7r7t6h0ikY9P9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WE6XktZc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713100670;
	bh=LgG/w5qdFetHcwqOkNqngUxFET9OESjfCC+ZDPdjLeA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WE6XktZci+fvrtTY8njC/bMd24bbIXySAl5RjmCtus+qvsW+hgreB/e2pskSc3Ptk
	 7UEoHxF9TuhTXLyn8djP9XBAUDbci0jA8TXQRLeU8raxZ6oeam3+WOkkWWs5sI+oX0
	 J96bC6PmbyP0lbmBPP9dY/JPDTAeANy4dLcOz0EeNm8Sd/Nqfkm9ay+P5zpCIBmYB7
	 ZignZFLLQ/Vn+rG6/e0lO2RTxRUQWK1AtUWFZhKvF0Y0d6zuVcS01/C55ozoYHZal5
	 tO10eBgRrgkj43NTt2HahVtd2hlxcC93tpyaOLb0m1NTFdmhCHXwlV/dIUJTJ/QPhe
	 Ib3UKnBlbbusw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B8AE03781104;
	Sun, 14 Apr 2024 13:17:47 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 2/4] selftests: x86: corrupt_xstate_header: conform test to TAP format output
Date: Sun, 14 Apr 2024 18:18:05 +0500
Message-Id: <20240414131807.2253344-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240414131807.2253344-1-usama.anjum@collabora.com>
References: <20240414131807.2253344-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/x86/corrupt_xstate_header.c     | 30 +++++++++++--------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/x86/corrupt_xstate_header.c b/tools/testing/selftests/x86/corrupt_xstate_header.c
index cf9ce8fbb656c..119ff74763c6d 100644
--- a/tools/testing/selftests/x86/corrupt_xstate_header.c
+++ b/tools/testing/selftests/x86/corrupt_xstate_header.c
@@ -39,7 +39,7 @@ static void sethandler(int sig, void (*handler)(int, siginfo_t *, void *),
 	sa.sa_flags = SA_SIGINFO | flags;
 	sigemptyset(&sa.sa_mask);
 	if (sigaction(sig, &sa, 0))
-		err(1, "sigaction");
+		ksft_exit_fail_perror("sigaction");
 }
 
 static void sigusr1(int sig, siginfo_t *info, void *uc_void)
@@ -48,26 +48,29 @@ static void sigusr1(int sig, siginfo_t *info, void *uc_void)
 	uint8_t *fpstate = (uint8_t *)uc->uc_mcontext.fpregs;
 	uint64_t *xfeatures = (uint64_t *)(fpstate + 512);
 
-	printf("\tWreck XSTATE header\n");
+	ksft_print_msg("Wreck XSTATE header\n");
 	/* Wreck the first reserved bytes in the header */
 	*(xfeatures + 2) = 0xfffffff;
 }
 
 static void sigsegv(int sig, siginfo_t *info, void *uc_void)
 {
-	printf("\tGot SIGSEGV\n");
+	ksft_print_msg("Got SIGSEGV\n");
 }
 
 int main(void)
 {
 	cpu_set_t set;
 
+	ksft_print_header();
+	ksft_set_plan(2);
+
 	sethandler(SIGUSR1, sigusr1, 0);
 	sethandler(SIGSEGV, sigsegv, 0);
 
 	if (!xsave_enabled()) {
-		printf("[SKIP] CR4.OSXSAVE disabled.\n");
-		return 0;
+		ksft_print_msg("CR4.OSXSAVE disabled.\n");
+		return KSFT_SKIP;
 	}
 
 	CPU_ZERO(&set);
@@ -79,18 +82,21 @@ int main(void)
 	 */
 	sched_setaffinity(getpid(), sizeof(set), &set);
 
-	printf("[RUN]\tSend ourselves a signal\n");
+	ksft_print_msg("Send ourselves a signal\n");
 	raise(SIGUSR1);
 
-	printf("[OK]\tBack from the signal.  Now schedule.\n");
+	ksft_test_result_pass("Back from the signal. Now schedule.\n");
+
 	pid_t child = fork();
-	if (child < 0)
-		err(1, "fork");
 	if (child == 0)
 		return 0;
-	if (child)
+
+	if (child < 0) {
+		ksft_test_result_fail("fork: %s\n", strerror(errno));
+	} else if (child) {
 		waitpid(child, NULL, 0);
-	printf("[OK]\tBack in the main thread.\n");
+		ksft_test_result_pass("Back in the main thread.\n");
+	}
 
 	/*
 	 * We could try to confirm that extended state is still preserved
@@ -98,5 +104,5 @@ int main(void)
 	 * a warning in the kernel logs.
 	 */
 
-	return 0;
+	ksft_finished();
 }
-- 
2.39.2


