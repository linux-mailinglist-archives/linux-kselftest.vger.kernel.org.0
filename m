Return-Path: <linux-kselftest+bounces-41288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930E5B54540
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 10:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531A3584FEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 08:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4CB2D7DCE;
	Fri, 12 Sep 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hljY2AXc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D0320ADD6;
	Fri, 12 Sep 2025 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665540; cv=none; b=Jm6q04Sg3AkvPKmDmAPdXMXClrzwF0LZcrILNMohEK4tSHDBWTgZ9/iKwzgU2A12iHrvKGAlMGd75dv75MJ+vU59cGO4pIzdMTiQgGLKRBwvYc2vYyTTlIZyHHVdcj8ybd5Km8SWZuGqGUby0JJjYjg2/gbTeiX//MmMrMz/8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665540; c=relaxed/simple;
	bh=cunwV8xu8FqIBp/EAtK0dvN8jpjPle1njb/OrNDzCxo=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=L38T/ZXuPcDc9AaCUdbtY3ltHbS8j7/xnQe6jzPsAfGlv4246PtdGa0YzdZOHBSi9+5rOf/ZQc/7kO117qyH5ElNXHOks9iaN2ssvy9C5xj6F7LhLC6kSQ6ro4MsORXgvDJa4H4o3wfqg6bpjxME7RA6tL3BMt7RGEaU1jsAV8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hljY2AXc; arc=none smtp.client-ip=43.163.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1757665229; bh=JVgWk74aBBUGYWnw57FKGQnctHzfE1dwx1v7FRI4+1Y=;
	h=From:To:Cc:Subject:Date;
	b=hljY2AXcaRAgSLXwybXVIRkxX07u3j6Doqivc+csyQPDYNqSon7HSEesAQQbF3g0k
	 pMHnhPTjvn28VjCUojSpnQ82Zf0dN2qA3KKvpA/HCOfSXOo64wU1m4uMy4Pd8UvV53
	 nwci3eCMXxEJ/Cs7w5RJnyIXoqKoymX0Jbl86Yvs=
Received: from localhost.localdomain ([116.128.244.171])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id 51B0D4B1; Fri, 12 Sep 2025 16:20:27 +0800
X-QQ-mid: xmsmtpt1757665227t70xqaoi3
Message-ID: <tencent_CA0C296180B9D75FF6A53D6B4F2130888D05@qq.com>
X-QQ-XMAILINFO: NT7uTz3cNku257dThSuBFAkPHkFum1Rm9XBseMDLCOsSn/PNI1w45UQUGtF7Xb
	 T00lUeew2Bf+q/NyH0p136uiOwfMnMcMZpAYPPjheSIqCNbJfji0gxv8tIRhD+ndfpaQAfj46QFX
	 4+eiW2PCNeWcd24bjWeiflDnemVd6kCAWIV4y5augakdR0tYc38FXLuDnKdmDYbV5INPytMPYy/P
	 NvWZHFLMpswJErOxzQiHa/iKzdyFWiBz8cQUoGwliBQnWvwK3NA/wL6yE5jGkK2nFofYjM21rFe3
	 FWAhLb7Rh7Qbtc++9O0vpdSg+FkGZgtt6CI5jNtydfEbg/NjVh+5MTl5WhyA0GEL3cSiMG5/7ikD
	 ZUM7m+yUt+X2OVuhncw0CuIZC3MU5zJV6HndcWwzs9p2o55JdaROT84bEh26NLqgIlO84iuImjRD
	 9n2iumD01ZYeHZlVVsU9bst6KVmxUK9SUQEvG7uZ/lqjPRarwY0vNfKnSx3egNBHmdJbG1cL4cfA
	 bLT2QiaJVIaCGbHQNUGfqiSYNZfp0lsxANin+S8v3E0woU0Iba4mvuwBaEepRcC7pId6xT/zh/z3
	 fNUxIUjbh9m4N6ZtVQ3l4m6X6MvKJyP3Xm3SlQCmYbuihDTjQBDjss9IGoOb+EZ62JlCaF/PNE2m
	 keYLH9IFf8HHRLasu8Ia5I0Bu4k1xkqdt+rf6JAHAhO/r2+4mHX5ePffTxH5LO+jupkD1sYqU7lE
	 WQCNUk7suUP6/Ze62nZsiBZgWQpBVGlbPVlYKkeyqo1jprIZrbEBEcojsDMxxTGqMVVL6pYCoTXd
	 LtJar++UEaB+HCl9F7ECqUPBQ+m3pAFwA14K/QQHhxVnNVaJXLAiZZRBA0TcC0XdPN1wHQIJk9H2
	 1IhHUxZADchnogZMFFZ3WHNOiBYzxKvLJyL4cpfqCTVoJ8BORy5dLG9DCWik6dj9TY/soQK9ojnV
	 gq+l+LRZxCZwQMZFtipD+eKUnxJcFg3pBmQk7loSBbz4BV7dKwZX5+Mu/icJ51TnTB1mEjw03iU8
	 DnKoh/TMFS6+2GVqfyDosZPc73Y/vcivOjbFNZm13iBsSnZUum6l0PsB+aKr8=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Haofeng Li <920484857@qq.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	Haofeng Li <13266079573@163.com>,
	Haofeng Li <lihaofeng@kylinos.cn>
Subject: [PATCH] mm: transhuge-stress: fix potential memory leak on realloc failure
Date: Fri, 12 Sep 2025 16:20:24 +0800
X-OQ-MSGID: <20250912082024.1952510-1-920484857@qq.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haofeng Li <lihaofeng@kylinos.cn>

When realloc() fails in transhuge-stress test, the original code
exits immediately without freeing the previously allocated memory,
causing a memory leak. This patch introduces a temporary pointer
to hold the realloc result, ensuring proper cleanup by freeing
the original map before exiting on allocation failure.

Signed-off-by: Haofeng Li <lihaofeng@kylinos.cn>
---
 tools/testing/selftests/mm/transhuge-stress.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
index 68201192e37c..cbe86c5b8de0 100644
--- a/tools/testing/selftests/mm/transhuge-stress.c
+++ b/tools/testing/selftests/mm/transhuge-stress.c
@@ -30,7 +30,7 @@ int main(int argc, char **argv)
 	int i = 0;
 	char *name = NULL;
 	double s;
-	uint8_t *map;
+	uint8_t *map, *map_tmp;
 	size_t map_len;
 	int pagemap_fd;
 	int duration = 0;
@@ -107,9 +107,12 @@ int main(int argc, char **argv)
 
 				nr_succeed++;
 				if (idx >= map_len) {
-					map = realloc(map, idx + 1);
-					if (!map)
+					map_tmp = realloc(map, idx + 1);
+					if (!map_tmp) {
+						free(map);
 						ksft_exit_fail_msg("map realloc\n");
+					}
+					map = map_tmp;
 					memset(map + map_len, 0, idx + 1 - map_len);
 					map_len = idx + 1;
 				}
-- 
2.25.1


