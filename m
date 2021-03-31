Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4397F3501C9
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 16:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhCaN7z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 09:59:55 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23848 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235758AbhCaN7Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 09:59:24 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4F9Sbn1nmCz9v07Q;
        Wed, 31 Mar 2021 15:59:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3rRmCpjMfqXX; Wed, 31 Mar 2021 15:59:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4F9Sbn0llnz9v07K;
        Wed, 31 Mar 2021 15:59:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CE458B82A;
        Wed, 31 Mar 2021 15:59:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id dLeeJDDL2ccw; Wed, 31 Mar 2021 15:59:18 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EAD958B829;
        Wed, 31 Mar 2021 15:59:17 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A10F867640; Wed, 31 Mar 2021 13:59:17 +0000 (UTC)
Message-Id: <469f37ab91984309eb68c0fb47e8438cdf5b6463.1617198956.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] selftests: timens: Fix gettime_perf to work on powerpc
To:     Shuah Khan <shuah@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Date:   Wed, 31 Mar 2021 13:59:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On powerpc:
- VDSO library is named linux-vdso32.so.1 or linux-vdso64.so.1
- clock_gettime is named __kernel_clock_gettime()

Ensure gettime_perf tries these names before giving up.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/timens/gettime_perf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/timens/gettime_perf.c b/tools/testing/selftests/timens/gettime_perf.c
index 7bf841a3967b..6b13dc277724 100644
--- a/tools/testing/selftests/timens/gettime_perf.c
+++ b/tools/testing/selftests/timens/gettime_perf.c
@@ -25,12 +25,20 @@ static void fill_function_pointers(void)
 	if (!vdso)
 		vdso = dlopen("linux-gate.so.1",
 			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-vdso32.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
+	if (!vdso)
+		vdso = dlopen("linux-vdso64.so.1",
+			      RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
 	if (!vdso) {
 		pr_err("[WARN]\tfailed to find vDSO\n");
 		return;
 	}
 
 	vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__vdso_clock_gettime");
+	if (!vdso_clock_gettime)
+		vdso_clock_gettime = (vgettime_t)dlsym(vdso, "__kernel_clock_gettime");
 	if (!vdso_clock_gettime)
 		pr_err("Warning: failed to find clock_gettime in vDSO\n");
 
-- 
2.25.0

