Return-Path: <linux-kselftest+bounces-24432-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7229AA101A9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 09:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB943A747D
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 08:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FEC246344;
	Tue, 14 Jan 2025 08:04:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4834420459B;
	Tue, 14 Jan 2025 08:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841865; cv=none; b=SF45LaBks0HPd/xQPMi4ZFvDtMMYYathGSpnPwty0assxiEcTwFbnxP0j6VTFp4XjlU2xtaekBWyHIA15Nc8TFnzf1su+ckhb+WqJnON2Y1ivRLTeYYX1NgYNlnIFUJy37lbHnzBQM8sWoDJ2mBp9S6t2j5zPzGUUfg0N5PMgSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841865; c=relaxed/simple;
	bh=Z7Vq3FbkycrgKl8siJ34Ekq2bumj/Vg+voSUtPUiEJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N/4gkC7fv5wZGAjv+aGJ9BuOeX1khh9blx6u3tLxv6QpjvpGkk6Vx9HBOXSN8KKGcOTHlbF8m0BE0sR7znEjEzRjAilpayzoAOUIwVwaOsZ/09NdS2hVIGxjJCfF9VaA13VXJVj9JzOpVGGZbLJRdBEqdvBaS57peqF/JPWr5h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 25fc0e4ad24e11efa216b1d71e6e1362-20250114
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:7752472b-af5c-4896-a0fe-6724f75b91b0,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:7752472b-af5c-4896-a0fe-6724f75b91b0,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:8e75dd4f00c653c222ea3b891b0b037f,BulkI
	D:250114160418M2SDBPLX,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 25fc0e4ad24e11efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 462913462; Tue, 14 Jan 2025 16:04:15 +0800
From: liuye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/prctl/set-process-name: Fix Resource leak fptr in check_name
Date: Tue, 14 Jan 2025 16:04:10 +0800
Message-Id: <20250114080410.108067-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Exception branch returns without closing fptr.
Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/prctl/set-process-name.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/prctl/set-process-name.c b/tools/testing/selftests/prctl/set-process-name.c
index 562f707ba771..625218fa0379 100644
--- a/tools/testing/selftests/prctl/set-process-name.c
+++ b/tools/testing/selftests/prctl/set-process-name.c
@@ -66,14 +66,18 @@ int check_name(void)
 		return -EIO;
 
 	fscanf(fptr, "%s", output);
-	if (ferror(fptr))
+	if (ferror(fptr)) {
+		fclose(fptr);
 		return -EIO;
+	}
 
 	int res = prctl(PR_GET_NAME, name, NULL, NULL, NULL);
 
-	if (res < 0)
+	if (res < 0) {
+		fclose(fptr);
 		return -errno;
-
+	}
+	fclose(fptr);
 	return !strcmp(output, name);
 }
 
-- 
2.25.1


