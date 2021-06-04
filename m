Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52BD39B909
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jun 2021 14:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhFDMc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Jun 2021 08:32:58 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:10132 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229718AbhFDMc6 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Jun 2021 08:32:58 -0400
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4FxMZ65Xs1zBCns;
        Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HUvhFCORwV31; Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FxMZ64GJ0zBCmY;
        Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8856C8B8A2;
        Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T_jecGVNfPOv; Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 40FEE8B885;
        Fri,  4 Jun 2021 14:31:10 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E48BF64BD9; Fri,  4 Jun 2021 12:31:09 +0000 (UTC)
Message-Id: <0ad62673d3e063f848e7c99d719bb966efd433e8.1622809833.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/selftests: Use gettid() instead of getppid() for
 null_syscall
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Date:   Fri,  4 Jun 2021 12:31:09 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gettid() is 10% lighter than getppid(), use it for null_syscall selftest.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/powerpc/benchmarks/null_syscall.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/null_syscall.c b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
index 579f0215c6e7..9836838a529f 100644
--- a/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
+++ b/tools/testing/selftests/powerpc/benchmarks/null_syscall.c
@@ -14,6 +14,7 @@
 #include <time.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/syscall.h>
 #include <signal.h>
 
 static volatile int soak_done;
@@ -121,7 +122,7 @@ static void do_null_syscall(unsigned long nr)
 	unsigned long i;
 
 	for (i = 0; i < nr; i++)
-		getppid();
+		syscall(__NR_gettid);
 }
 
 #define TIME(A, STR) \
-- 
2.25.0

