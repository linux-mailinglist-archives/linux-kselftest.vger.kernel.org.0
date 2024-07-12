Return-Path: <linux-kselftest+bounces-13649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7959192F63E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B351F23619
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A606F10A1E;
	Fri, 12 Jul 2024 07:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="0gY6Q2aK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5238F58;
	Fri, 12 Jul 2024 07:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720769470; cv=none; b=L+dbIi2WQAQyPyaVpIbZnZY2UHlCecWr2eDcHC81VYgZTHU8fXEYXx3Kgcx6366/K1dUiCU1HpxoFMuCAyEYjKgguf2CSMIRC7bxnspQnjMtQzU727FV7guvNOkA72k4WmoTo3rRG0MlNiR079iWjOlCGfSBmG+iaZjqjtKKBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720769470; c=relaxed/simple;
	bh=RwEDCtWq60L79GQOwVtAiJNUvr/rS15cB8K0JYOfvvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ncqPv8Z11SmAypDUJc1aV9QADuF4xHg+vQt43KiKdywphMbjb4V5okB+7HHbHK9w0fDrlVFFcz+JGNKPIMrb2vRAV26oAOOQBNGBboKNFnCZUfEdO+idfZ1LaX6HroUAh1fQeTzASu2IZAhYlLNYL30BKSqox/+KHmDJgdHEor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=0gY6Q2aK; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720769464;
	bh=RwEDCtWq60L79GQOwVtAiJNUvr/rS15cB8K0JYOfvvU=;
	h=From:To:Cc:Subject:Date:From;
	b=0gY6Q2aKvJYm0a2Fc90cS8Nm76pGp1Kb+x1RthmVoGC5/3MC0emUw10djO/xWdpI3
	 1Y/LJfjTj3V6aSurDeopC/aquCAZc7MDCx+b3LJWyt1aHKb9qDa/f/McYtpiIkEr3T
	 C1DUNo7Dgg8/vf9pnkFIAh3wwlsUzVurRmkmILuDySq8r/WJxaIp6alM672GQDBSVN
	 mFyU1AQXVtBoWLvZ98oVWEfOAkKkTs/bldSPzqhootmYCz9FOCwN1D1OVa7Tird0cm
	 2zG6u2ZRLPGHRO+9geDMODfVzc1K8YZhPl4oLkEfC8Pe3HYOXzN4iWB3QBaiI1KWFM
	 GkXwl/BdLdEHA==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 18EFE37821F8;
	Fri, 12 Jul 2024 07:31:01 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	"Chang S . Bae" <chang.seok.bae@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: x86: vdso_restorer: remove manual counting of pass/fail tests
Date: Fri, 12 Jul 2024 12:30:42 +0500
Message-Id: <20240712073045.110014-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kselftest wrapper to mark tests pass/fail instead of manually
counting. This is needed to return correct exit status. This also
improves readability and mainability.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/x86/vdso_restorer.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f24341554..8e173d71291f6 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -21,6 +21,7 @@
 #include <unistd.h>
 #include <syscall.h>
 #include <sys/syscall.h>
+#include "../kselftest.h"
 
 /* Open-code this -- the headers are too messy to easily use them. */
 struct real_sigaction {
@@ -44,9 +45,10 @@ static void handler_without_siginfo(int sig)
 
 int main()
 {
-	int nerrs = 0;
 	struct real_sigaction sa;
 
+	ksft_print_header();
+
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso)
@@ -57,6 +59,8 @@ int main()
 		return 0;
 	}
 
+	ksft_set_plan(2);
+
 	memset(&sa, 0, sizeof(sa));
 	sa.handler = handler_with_siginfo;
 	sa.flags = SA_SIGINFO;
@@ -69,12 +73,7 @@ int main()
 
 	raise(SIGUSR1);
 
-	if (handler_called) {
-		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
-	} else {
-		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
-		nerrs++;
-	}
+	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
 
 	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
 
@@ -86,10 +85,5 @@ int main()
 
 	raise(SIGUSR1);
 
-	if (handler_called) {
-		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
-	} else {
-		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
-		nerrs++;
-	}
+	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
 }
-- 
2.39.2


