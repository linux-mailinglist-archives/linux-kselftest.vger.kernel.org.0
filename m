Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CD8280E83
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Oct 2020 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgJBIHC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Oct 2020 04:07:02 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2023 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgJBIHC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Oct 2020 04:07:02 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f76df990011>; Fri, 02 Oct 2020 01:06:49 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 2 Oct
 2020 08:06:24 +0000
Received: from sandstorm.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Fri, 2 Oct 2020 08:06:24 +0000
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 1/1] selftests/vm: 8x compaction_test speedup
Date:   Fri, 2 Oct 2020 01:06:21 -0700
Message-ID: <20201002080621.551044-2-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002080621.551044-1-jhubbard@nvidia.com>
References: <20201002080621.551044-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601626009; bh=Ntx8Ri/1CPTa9H9QwVpmWKo8Bl+lnYBsuI8bdqZxJ5c=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=o/OoG1IJ89o/To3O5xOF1hwH7PD3vheBI22pWRct7jiG5lkZAytwJSFMia1mVrZBI
         o1FyM/Sxc/HqML+oXsxsAgR6tUTnfg3O37RKuB87eyZuTQdFpHFf8RpCwTmMDy9RjG
         WZS2PuyHr4mpuBFlSC55jLpUbbiVc9gNFcbvQe9be3RuwbD40tJsFw73CN6KHxZD4i
         i89oAl3Ta2oQOTKIiW9FyoDB6hVeic6kyNhB/5g5t1d5F1oJ+wy5OVvMuJhtSX3vfu
         q/ATmf1+WrfhI24e2/bVJUwg6aSrakR2l/Ou/SSbXKS10Eugx+LRsaZBN+9UTLQM6C
         8A/vu5l7h/c1Q==
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch reduces the running time for compaction_test from about 27
sec, to 3.3 sec, which is about an 8x speedup.

These numbers are for an Intel x86_64 system with 32 GB of DRAM.

The compaction_test.c program was spending most of its time doing
mmap(), 1 MB at a time, on about 25 GB of memory.

Instead, do the mmaps 100 MB at a time. (Going past 100 MB doesn't make
things go much faster, because other parts of the program are using the
remaining time.)

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/vm/compaction_test.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/compaction_test.c b/tools/testing/s=
elftests/vm/compaction_test.c
index bcec71250873..9b420140ba2b 100644
--- a/tools/testing/selftests/vm/compaction_test.c
+++ b/tools/testing/selftests/vm/compaction_test.c
@@ -18,7 +18,8 @@
=20
 #include "../kselftest.h"
=20
-#define MAP_SIZE 1048576
+#define MAP_SIZE_MB	100
+#define MAP_SIZE	(MAP_SIZE_MB * 1024 * 1024)
=20
 struct map_list {
 	void *map;
@@ -165,7 +166,7 @@ int main(int argc, char **argv)
 	void *map =3D NULL;
 	unsigned long mem_free =3D 0;
 	unsigned long hugepage_size =3D 0;
-	unsigned long mem_fragmentable =3D 0;
+	long mem_fragmentable_MB =3D 0;
=20
 	if (prereq() !=3D 0) {
 		printf("Either the sysctl compact_unevictable_allowed is not\n"
@@ -190,9 +191,9 @@ int main(int argc, char **argv)
 		return -1;
 	}
=20
-	mem_fragmentable =3D mem_free * 0.8 / 1024;
+	mem_fragmentable_MB =3D mem_free * 0.8 / 1024;
=20
-	while (mem_fragmentable > 0) {
+	while (mem_fragmentable_MB > 0) {
 		map =3D mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_PRIVATE | MAP_LOCKED, -1, 0);
 		if (map =3D=3D MAP_FAILED)
@@ -213,7 +214,7 @@ int main(int argc, char **argv)
 		for (i =3D 0; i < MAP_SIZE; i +=3D page_size)
 			*(unsigned long *)(map + i) =3D (unsigned long)map + i;
=20
-		mem_fragmentable--;
+		mem_fragmentable_MB -=3D MAP_SIZE_MB;
 	}
=20
 	for (entry =3D list; entry !=3D NULL; entry =3D entry->next) {
--=20
2.28.0

