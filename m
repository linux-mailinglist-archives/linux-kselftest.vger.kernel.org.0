Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EED257539
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Aug 2020 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgHaIYC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Aug 2020 04:24:02 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28016 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbgHaIYB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Aug 2020 04:24:01 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bg3Bf5clGz9v478;
        Mon, 31 Aug 2020 10:23:54 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7v1O8RfXhnSa; Mon, 31 Aug 2020 10:23:54 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bg3Bf4Mj5z9v475;
        Mon, 31 Aug 2020 10:23:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C6748B7BC;
        Mon, 31 Aug 2020 10:23:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Gm8JKCzRAbJL; Mon, 31 Aug 2020 10:23:59 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6AD238B79B;
        Mon, 31 Aug 2020 10:23:59 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1E1EE65D48; Mon, 31 Aug 2020 08:23:59 +0000 (UTC)
Message-Id: <e27481224564a93d14106e750de31189deaa8bc8.1598861977.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] selftests/vm: Fix display of page size in map_hugetlb
To:     Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Date:   Mon, 31 Aug 2020 08:23:59 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The displayed size is in bytes while the text says it is in kB.

Shift it by 10 to really display kBytes.

Fixes: fa7b9a805c79 ("tools/selftest/vm: allow choosing mem size and page size in map_hugetlb")
Cc: stable@vger.kernel.org
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 tools/testing/selftests/vm/map_hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/map_hugetlb.c b/tools/testing/selftests/vm/map_hugetlb.c
index 6af951900aa3..312889edb84a 100644
--- a/tools/testing/selftests/vm/map_hugetlb.c
+++ b/tools/testing/selftests/vm/map_hugetlb.c
@@ -83,7 +83,7 @@ int main(int argc, char **argv)
 	}
 
 	if (shift)
-		printf("%u kB hugepages\n", 1 << shift);
+		printf("%u kB hugepages\n", 1 << (shift - 10));
 	else
 		printf("Default size hugepages\n");
 	printf("Mapping %lu Mbytes\n", (unsigned long)length >> 20);
-- 
2.25.0

