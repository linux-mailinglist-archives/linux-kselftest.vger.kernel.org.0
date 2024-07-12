Return-Path: <linux-kselftest+bounces-13655-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE30692F72F
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 10:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB7A1F22FE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B53A142E77;
	Fri, 12 Jul 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pReCniDU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D71428EA;
	Fri, 12 Jul 2024 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720774036; cv=none; b=iroREdGHd6wP96LhsezN8jTAmxrFHpsX4U4DtvG4BRyYYYEWv+5cKTKRHKfzljxo64vxzVL0zHg7DoowfcgBoCS/EvjHYKj2o70r8qy4ZmoW68820s2ZyjwpJr7A2svrO5TM6neSRpLzX2iRcghP6GGuwha765OgIu/8Cer7zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720774036; c=relaxed/simple;
	bh=newjgmZ8NVY0WI0RWTkosD/XDmBr5O5rKuL1X4AnNXE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BxCxMc1Stt43rUwhSm2bTql4jn3Z5y13UfKmxPtH0DcSjTNZPbk1kSOcKrBctd0WpMJviOdHPLoQShotXEEq2RF0N/jA7RyaLdU/6zY1YFlEVQD3gcHTApx8mOzG4r6gk5TkILXNzSWGZ9KGtX3MYPAGycG2BXZDv/O7EYw0WJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=pReCniDU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720774033;
	bh=newjgmZ8NVY0WI0RWTkosD/XDmBr5O5rKuL1X4AnNXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pReCniDUnO7W/79x05NPUjbdW61unz/tZYL2FIO7L/w5nIq4KwYZlExShMBdeodWZ
	 Y6n+30wu3UG2SfdcLycbzY9boMwY5SWmBDOKM+5sNxCcN2qiiLHwOL+RUUaVAAtOH2
	 vrTPCD37vX+fFznrhN+GKFt8B0CR9EbmXjXN6uVTnuPMgxsqTgueQXQG4xCPj0PAlV
	 12+cPyq7xQ/hHp+nNPNmKX+FoTEyK2TbbIYUHJZuXDI4n/qYuriPRU0QJSBmMQBrvy
	 4dbUr0W/AIRl7Tx2R32rOycowRgL86005GUsYNc2OFy1MyH++r38sGqP7HVLyRPasq
	 iOiPFXTO9VTog==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B01FB3782212;
	Fri, 12 Jul 2024 08:47:10 +0000 (UTC)
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
Subject: [PATCH v2 1/4] selftests: x86: check_initial_reg_state: remove manual counting and increase maintainability
Date: Fri, 12 Jul 2024 13:46:22 +0500
Message-Id: <20240712084625.297249-2-usama.anjum@collabora.com>
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

- Removes manual counting of pass and fail tests
- Increase readability and maintainability of tests
- Print logs in standard format (without [RUN], [OK] tags)

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 .../selftests/x86/check_initial_reg_state.c   | 24 +++++++++----------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/x86/check_initial_reg_state.c b/tools/testing/selftests/x86/check_initial_reg_state.c
index 3bc95f3ed5859..b91c2b06b9881 100644
--- a/tools/testing/selftests/x86/check_initial_reg_state.c
+++ b/tools/testing/selftests/x86/check_initial_reg_state.c
@@ -7,6 +7,7 @@
 #define _GNU_SOURCE
 
 #include <stdio.h>
+#include "../kselftest.h"
 
 unsigned long ax, bx, cx, dx, si, di, bp, sp, flags;
 unsigned long r8, r9, r10, r11, r12, r13, r14, r15;
@@ -53,20 +54,19 @@ asm (
 
 int main()
 {
-	int nerrs = 0;
+	ksft_print_header();
+	ksft_set_plan(2);
 
-	if (sp == 0) {
-		printf("[FAIL]\tTest was built incorrectly\n");
-		return 1;
-	}
+	if (sp == 0)
+		ksft_exit_fail_msg("Test was built incorrectly\n");
 
 	if (ax || bx || cx || dx || si || di || bp
 #ifdef __x86_64__
 	    || r8 || r9 || r10 || r11 || r12 || r13 || r14 || r15
 #endif
 		) {
-		printf("[FAIL]\tAll GPRs except SP should be 0\n");
-#define SHOW(x) printf("\t" #x " = 0x%lx\n", x);
+		ksft_test_result_fail("All GPRs except SP should be 0\n");
+#define SHOW(x) ksft_print_msg("\t" #x " = 0x%lx\n", x)
 		SHOW(ax);
 		SHOW(bx);
 		SHOW(cx);
@@ -85,17 +85,15 @@ int main()
 		SHOW(r14);
 		SHOW(r15);
 #endif
-		nerrs++;
 	} else {
-		printf("[OK]\tAll GPRs except SP are 0\n");
+		ksft_test_result_pass("All GPRs except SP are 0\n");
 	}
 
 	if (flags != 0x202) {
-		printf("[FAIL]\tFLAGS is 0x%lx, but it should be 0x202\n", flags);
-		nerrs++;
+		ksft_test_result_fail("FLAGS is 0x%lx, but it should be 0x202\n", flags);
 	} else {
-		printf("[OK]\tFLAGS is 0x202\n");
+		ksft_test_result_pass("FLAGS is 0x202\n");
 	}
 
-	return nerrs ? 1 : 0;
+	ksft_finished();
 }
-- 
2.39.2


