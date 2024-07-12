Return-Path: <linux-kselftest+bounces-13656-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295D592F732
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8019DB21C6C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEFE142645;
	Fri, 12 Jul 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mO6o/ntA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E611428EA;
	Fri, 12 Jul 2024 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774041; cv=none; b=T6gHJJWrRoRkQ3IhOUs5Fin+lpzM74Zqb0CQgJ6u1Pxc42l0atdkcXcKUdw9OBJAVdNIiGOPdWHEHZ0746K0RK0vvEmuWXIfNfMQfAB7yQxuxpPsVepNzP1+Du+ips9SZf3cjQ3mtAwClCek3L7xxmttKfA8KEERKUcEWPtq+t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774041; c=relaxed/simple;
	bh=RLfXVBOBZZZ+0wOWembK7DR9NrstP766ajYT0vmw47Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qu/AL2wZYcpF15z2GndN3rknTe0eEfh58uPh0AYzZmUjNFnWDuz+v9SoekzJl+W6x4L2w+JLAzOCr7jqYY4TV3kwZrEBzDu/mrR54KVEDo5CP8BqVOil/eJCjnyGMUhaF0itX7j/v0JGbnYaI2t+Z9X6kzQHW8I+E184bVzcjlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mO6o/ntA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774037;
	bh=RLfXVBOBZZZ+0wOWembK7DR9NrstP766ajYT0vmw47Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mO6o/ntAcJqJnib31+xjmRmpjTjQ/Xh7Zs5PgeVR0cnwwkDWuI/OVnA/hrpX6FxpM
	 d22aPux2XbGz1Uo7fU2r4h57ekRqeFg708B+COLqJfmxqyL8Vl0HgeMvwgDAREzkxZ
	 c4LMHONylEeVTPIBGq9mQDg/1b6WtPx4Wjww7XEVKRVISyGidHA+P9cKyHtc6EYBO2
	 RE6TU4aHCDSo360TyBRPuSMolnq/PD9HYi3Z5+22wtHUqa7MYEp2Gy2ss5635mZtuQ
	 9st5SiA18gvX76e4RbfyG96BfIA4QTIsfkQDKzDiX0NDky4Bu5DONDjIPxyG4ceimL
	 X4OmPrN0c6oqQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9D7E73782211;
	Fri, 12 Jul 2024 08:47:15 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCH v2 2/4] selftests: x86: corrupt_xstate_header: remove manual counting and increase maintainability
Date: Fri, 12 Jul 2024 13:46:23 +0500
Message-Id: <20240712084625.297249-3-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712084625.297249-1-usama.anjum@collabora.com>
References: <20240712084625.297249-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Correct the skip, pass and fail return codes. Otherwise the test
  always return 0
- Returns correct number of stats about passed/failed tests
- Print logs in standard format

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


