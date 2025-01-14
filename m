Return-Path: <linux-kselftest+bounces-24423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA2B3A0FED7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 908503A6AC3
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A92230999;
	Tue, 14 Jan 2025 02:38:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A322FE19;
	Tue, 14 Jan 2025 02:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736822338; cv=none; b=Pl/2FI8HbwacRPN3soXSy5Yewgb5IY0LqLhWVYiw4TR1MkMibhZ7tOj1eEs1Um6zOxv89t+C97RoEUSDztL5UVtCbIhGWCA+SXj9B2ZXkpyqq9LY9fND7XsfdyyLNRObrhFL6VFADJCJNzamcbk3Xq5ExqSsXPCkYVJPkqt3r7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736822338; c=relaxed/simple;
	bh=Zi/MTfRW3jnz9RCrKpf67kmcBKyoBF2yxh0PKagvYjg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oLaMa+WVC41khQJEvHjG7P/AHYOb7/ijeSgPAKNrJLrakPacOxvBjjfy/t6HbTATORknQEahRYC0lqj84RINQ66aGflL9aUcSw9ZuzLJQ/3CPJs1VXZLfu6asNa6HbZEDi7ZEuWlDmixrtm2Hhni2h2yvRsWzUIlHP7QY92qJ2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aca147ead22011efa216b1d71e6e1362-20250114
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:fee4e13a-7370-4fe4-8369-4e8123aa97a5,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:fee4e13a-7370-4fe4-8369-4e8123aa97a5,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:29c75f80375dd1e9a92c84609f06fa94,BulkI
	D:250114103846GD9UCBC9,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: aca147ead22011efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 813885902; Tue, 14 Jan 2025 10:38:44 +0800
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/mm/mkdirty: Fix memory leak in test_uffdio_copy()
Date: Tue, 14 Jan 2025 10:38:38 +0800
Message-Id: <20250114023838.48589-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Release memory before exception branch returns to prevent memory leaks

Checking tools/testing/selftests/mm/mkdirty.c ...
tools/testing/selftests/mm/mkdirty.c:283:3: error: Memory leak: src [memleak]
  return;
  ^

Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/mm/mkdirty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 1db134063c38..af2fce496912 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -280,6 +280,7 @@ static void test_uffdio_copy(void)
 	dst = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
 	if (dst == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
+		free(src);
 		return;
 	}
 
-- 
2.25.1


