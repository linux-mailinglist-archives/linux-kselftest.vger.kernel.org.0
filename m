Return-Path: <linux-kselftest+bounces-8910-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3BE8B352E
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 12:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327FD1F23036
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 10:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657AA145B12;
	Fri, 26 Apr 2024 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="uHKWPnK/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF89142625;
	Fri, 26 Apr 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126682; cv=none; b=QwxBDothfmGMEJCICncEYDrL9bLMsZ/pePZ5OqWn+RRKvZ7P08lYd/skt6FL/ZCpg3L3K1WpF+Vy5AOSazOROdl27hRFdVhdSy1xCfmJCrsCPCUR1b7UVNFPKdDexj9Fj0HV0qOUKxFTD2++fXuZn+5HpMIJaLnpVIiRtr5x3lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126682; c=relaxed/simple;
	bh=SuhIwCajet75pBQ8i3LxLuVtlkqvgvktzAYz1G96tqk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnbBp4MQk22LAJOmxws/aIocO1fTWFkw7g43lmHqGmBjEWGPJ3W99YMjZDIFAoVHF0JRvP6KjheQI13wLNhBWig8lkoFRgU1g7ifIdbwqYIkzg/zqnIeTdhl4T8oZVy0equPGRz0GbK/yF4DJIzhls1A0FSAdr7y4lEg3LXLpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=uHKWPnK/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714126679;
	bh=SuhIwCajet75pBQ8i3LxLuVtlkqvgvktzAYz1G96tqk=;
	h=From:To:Cc:Subject:Date:From;
	b=uHKWPnK/aXQOOIlE5fceeGsq+yhHf5pwIEWcwyHiqc1UrPvf08mMn1gVFgARoDHMy
	 5mU+rLw8++8MwKxyQtW1GoohvIUGJeD9Lq3jEUsvhmmenVFNlncVm3s+6Fdl1HLZq8
	 8J6Odz5GrRDQ2xIKEuNP4ZaCYqwzKcJIQ0VH9W+bBhB5kGa2sEzjG7HRe4iy0F8/X9
	 VVdE3DmpqrDvgjt3MV/NBlk2EQBl4WTHcKKICbh/9McFHjE2kuTDr2w2l0nRT5IIeo
	 FY0oVXeL66EQ6nJya5lJb3PJWAIi2l5cQ3WxQYytjuD+Ir/q7Gp9d8+xubjzNQLr3g
	 c3XOE9oEwccoQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2C5343782156;
	Fri, 26 Apr 2024 10:17:54 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: "Chang S . Bae" <chang.seok.bae@intel.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests: x86: conform test to TAP format output
Date: Fri, 26 Apr 2024 15:18:22 +0500
Message-Id: <20240426101824.2894574-1-usama.anjum@collabora.com>
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
Changes since v1:
- No changes, sending it again as got no response on v1 even after weeks
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


