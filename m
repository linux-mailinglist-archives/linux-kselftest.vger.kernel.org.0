Return-Path: <linux-kselftest+bounces-6063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A3187562C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFCFB1F21E2B
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC0131731;
	Thu,  7 Mar 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PbskTq7s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648AA12DDA2;
	Thu,  7 Mar 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836607; cv=none; b=EIsQq/BZK5mz4WVB5VH3oaYa99+M+13WZo7q2L40LwemBVMGQ1FaprzL74YJDi5ukImYeleAIwjQrdnp4VFPcUmoE4QOSKvFnhitLDdZrQ5OJwB7Pn7AKGD4aIUZFAaKO+fInCRGXzV7SGbVauK/V0XwJ+muOMbkZJpcc9lmiyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836607; c=relaxed/simple;
	bh=s9ZMRgsps8xV9aF1ouJT2BympJlLSJgQ9oA0+90tMxk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XdqxH8vgBts5Ih58uua50iB0F7g8Q94qdc9G9cah/HuLN0fukXISaWhpEgaKtLi4S8Jn3RmrFstBYklKg2puF6VZ6V4kVVclV/xsY7tpWDiZ+We/T3r0sXLGMs+j9yr6Iad97nqs7FLEhMIThjFmOxHLZ4YwD+6+cTwL//ocQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PbskTq7s; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709836603;
	bh=s9ZMRgsps8xV9aF1ouJT2BympJlLSJgQ9oA0+90tMxk=;
	h=From:To:Cc:Subject:Date:From;
	b=PbskTq7sP2K0cTFWbqdr8FsMTtMZ9EhqwsyB6ekP/FBoZw1ITRpPA0evAd06xraou
	 vB0YNi00wa8vF131ctJ0j2K2JnjIgkG5YXLyu4/4AmkHhVI9JJoHIdG+ihFepeAUXU
	 GKLqTf8jaNRXBfe8Z7l4LvTRyxoIaKSvkmi59IDzpFw3Xxw/qodwkRTkk76Wv07E6o
	 +i4UTvuUO2+6O2oy7kPEWG5sOx56z0l9B6BGW/ArD9zV9cV5nSiFF1hc+zazJupaO2
	 MpNnHI2oZGTAeFlDrCTKSzdAwN/uMZrF7fNR/dHomIws7OKvZUlqJV9oWNeqcvYJsb
	 lckwIcpGzjNcQ==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E002B378134F;
	Thu,  7 Mar 2024 18:36:41 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: x86: conform test to TAP format output
Date: Thu,  7 Mar 2024 23:37:06 +0500
Message-Id: <20240307183708.2857513-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
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
 tools/testing/selftests/x86/vdso_restorer.c | 29 +++++++++------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/x86/vdso_restorer.c b/tools/testing/selftests/x86/vdso_restorer.c
index fe99f24341554..f621167424a9c 100644
--- a/tools/testing/selftests/x86/vdso_restorer.c
+++ b/tools/testing/selftests/x86/vdso_restorer.c
@@ -21,6 +21,7 @@
 #include <unistd.h>
 #include <syscall.h>
 #include <sys/syscall.h>
+#include "../kselftest.h"
 
 /* Open-code this -- the headers are too messy to easily use them. */
 struct real_sigaction {
@@ -44,17 +45,19 @@ static void handler_without_siginfo(int sig)
 
 int main()
 {
-	int nerrs = 0;
 	struct real_sigaction sa;
 
+	ksft_print_header();
+	ksft_set_plan(2);
+
 	void *vdso = dlopen("linux-vdso.so.1",
 			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso)
 		vdso = dlopen("linux-gate.so.1",
 			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso) {
-		printf("[SKIP]\tFailed to find vDSO.  Tests are not expected to work.\n");
-		return 0;
+		ksft_print_msg("[SKIP]\tFailed to find vDSO. Tests are not expected to work.\n");
+		return KSFT_SKIP;
 	}
 
 	memset(&sa, 0, sizeof(sa));
@@ -62,21 +65,16 @@ int main()
 	sa.flags = SA_SIGINFO;
 	sa.restorer = NULL;	/* request kernel-provided restorer */
 
-	printf("[RUN]\tRaise a signal, SA_SIGINFO, sa.restorer == NULL\n");
+	ksft_print_msg("Raise a signal, SA_SIGINFO, sa.restorer == NULL\n");
 
 	if (syscall(SYS_rt_sigaction, SIGUSR1, &sa, NULL, 8) != 0)
 		err(1, "raw rt_sigaction syscall");
 
 	raise(SIGUSR1);
 
-	if (handler_called) {
-		printf("[OK]\tSA_SIGINFO handler returned successfully\n");
-	} else {
-		printf("[FAIL]\tSA_SIGINFO handler was not called\n");
-		nerrs++;
-	}
+	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
 
-	printf("[RUN]\tRaise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
+	ksft_print_msg("Raise a signal, !SA_SIGINFO, sa.restorer == NULL\n");
 
 	sa.flags = 0;
 	sa.handler = handler_without_siginfo;
@@ -86,10 +84,7 @@ int main()
 
 	raise(SIGUSR1);
 
-	if (handler_called) {
-		printf("[OK]\t!SA_SIGINFO handler returned successfully\n");
-	} else {
-		printf("[FAIL]\t!SA_SIGINFO handler was not called\n");
-		nerrs++;
-	}
+	ksft_test_result(handler_called, "SA_SIGINFO handler returned\n");
+
+	ksft_finished();
 }
-- 
2.39.2


