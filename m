Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B595154082
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2020 09:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBFImE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Feb 2020 03:42:04 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:20629 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728047AbgBFImD (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Feb 2020 03:42:03 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48CsP44jN9z9vC0r;
        Thu,  6 Feb 2020 09:42:00 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=wkjVDANm; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 2lcOikkEyzC2; Thu,  6 Feb 2020 09:42:00 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48CsP43hxRz9vC0n;
        Thu,  6 Feb 2020 09:42:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1580978520; bh=89Y1BOmA6wd1Qv1aLetSGC2roM1Y6EfmkaNgZWi44Bs=;
        h=From:Subject:To:Cc:Date:From;
        b=wkjVDANm8pbO0N3AKTilK3eCwh8bumOVKS5vfWKUrOYOvLd6ZaUIcXBSVPjSmTBF5
         AxrjfEnc382MsgT0Ui6v/WgrJ5MrsZ8rI4UsEs44JCQQakGPkP1SYEk1kpDnL1SxOa
         dJewoePk7SdTIQO0dfgnZdaPFmr2x/li07lS00j4=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5FC0A8B863;
        Thu,  6 Feb 2020 09:42:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MqOjk89_hQPt; Thu,  6 Feb 2020 09:42:01 +0100 (CET)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0CA8F8B85F;
        Thu,  6 Feb 2020 09:42:01 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id BCF98652B7; Thu,  6 Feb 2020 08:42:00 +0000 (UTC)
Message-Id: <9a404a13c871c4bd0ba9ede68f69a1225180dd7e.1580978385.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] selftests/vm: Fix map_hugetlb length used for testing read
 and write
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Date:   Thu,  6 Feb 2020 08:42:00 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and
page size in map_hugetlb") added the possibility to change the size
of memory mapped for the test, but left the read and write test using
the default value. This is unnoticed when mapping a length greater
than the default one, but segfaults otherwise.

Fix read_bytes() and write_bytes() by giving them the real length.

Also fix the call to munmap().

Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 tools/testing/selftests/vm/map_hugetlb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 5a2d7b8efc40..6af951900aa3 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -45,20 +45,20 @@ static void check_bytes(char *addr)
 	printf("First hex is %x\n", *((unsigned int *)addr));
 }
 
-static void write_bytes(char *addr)
+static void write_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		*(addr + i) = (char)i;
 }
 
-static int read_bytes(char *addr)
+static int read_bytes(char *addr, size_t length)
 {
 	unsigned long i;
 
 	check_bytes(addr);
-	for (i = 0; i < LENGTH; i++)
+	for (i = 0; i < length; i++)
 		if (*(addr + i) != (char)i) {
 			printf("Mismatch at %lu\n", i);
 			return 1;
@@ -96,11 +96,11 @@ int main(int argc, char **argv)
 
 	printf("Returned address is %p\n", addr);
 	check_bytes(addr);
-	write_bytes(addr);
-	ret = read_bytes(addr);
+	write_bytes(addr, length);
+	ret = read_bytes(addr, length);
 
 	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
-	if (munmap(addr, LENGTH)) {
+	if (munmap(addr, length)) {
 		perror("munmap");
 		exit(1);
 	}
-- 
2.25.0

