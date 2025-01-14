Return-Path: <linux-kselftest+bounces-24421-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA4DA0FECD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057B41672E2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 02:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7093D230980;
	Tue, 14 Jan 2025 02:29:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5E42A83;
	Tue, 14 Jan 2025 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736821787; cv=none; b=F4y3K67jSGAQ5JF2+W1Nvxr6LZ4CF9sTIszVWav4RAyfY2kuJlh89g4v1pVqOT9wMEPf3aAPt9pSKE8sXhXXxM9NEaqjdY47D9Z55ZewIjpGxclod69kzMBMW1Sgm8GCAPu91KCGwLiPhh4ScLIK00Dt+vVbwp2PfwLS3Vw+qrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736821787; c=relaxed/simple;
	bh=EfIX6EbwrkMka+UmzM3egautT9Ujumec5v+jmKFTz20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsCV+tig68p1NGJ2m35ndM9asEyPnXtsOM9N5mw35xHHaU52i0ruMENlFlAjudguQG8vOoEqvmsKY2vDkoWo9lZhSw6ak/+rcS4gS81KoEjv5gA/195ensiCS0woCdsx3ftE2zUk7fCEiwd1aOg4OV1IxmseNYbftN63IKTtNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 661db11ad21f11efa216b1d71e6e1362-20250114
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
X-CID-O-INFO: VERSION:1.1.45,REQID:e6da6398-c88e-48e1-aae0-2cf1fd4f9916,IP:10,
	URL:0,TC:0,Content:46,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:66
X-CID-INFO: VERSION:1.1.45,REQID:e6da6398-c88e-48e1-aae0-2cf1fd4f9916,IP:10,UR
	L:0,TC:0,Content:46,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Spam_GS981B3D,AC
	TION:quarantine,TS:66
X-CID-META: VersionHash:6493067,CLOUDID:f0aad51c684a930b438bf3ec02af1efb,BulkI
	D:250114101207A7VC4N0T,BulkQuantity:3,Recheck:0,SF:17|19|24|38|44|66|78,TC
	:nil,Content:4|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil
	,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 661db11ad21f11efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 679831835; Tue, 14 Jan 2025 10:29:37 +0800
From: liuye <liuye@kylinos.cn>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/mm/cow : Fix memory leak in child_vmsplice_memcmp_fn()
Date: Tue, 14 Jan 2025 10:29:29 +0800
Message-Id: <20250114022929.46364-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Release memory before exception branch returns to prevent memory leaks.

Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/mm/cow.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 1238e1c5aae1..959327ba6258 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -167,19 +167,30 @@ static int child_vmsplice_memcmp_fn(char *mem, size_t size,
 	/* Backup the original content. */
 	memcpy(old, mem, size);
 
-	if (pipe(fds) < 0)
+	if (pipe(fds) < 0) {
+		free(old);
+		free(new);
 		return -errno;
-
+	}
 	/* Trigger a read-only pin. */
 	transferred = vmsplice(fds[1], &iov, 1, 0);
-	if (transferred < 0)
+	if (transferred < 0) {
+		free(old);
+		free(new);
 		return -errno;
-	if (transferred == 0)
+	}
+	if (transferred == 0) {
+		free(old);
+		free(new);
 		return -EINVAL;
+	}
 
 	/* Unmap it from our page tables. */
-	if (munmap(mem, size) < 0)
+	if (munmap(mem, size) < 0) {
+		free(old);
+		free(new);
 		return -errno;
+	}
 
 	/* Wait until the parent modified it. */
 	write(comm_pipes->child_ready[1], "0", 1);
-- 
2.25.1


