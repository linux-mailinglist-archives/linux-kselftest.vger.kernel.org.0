Return-Path: <linux-kselftest+bounces-24433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5509A101D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 09:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F0FD1887C43
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 08:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B03425949A;
	Tue, 14 Jan 2025 08:15:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15DE1CDA2F;
	Tue, 14 Jan 2025 08:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842514; cv=none; b=ncjLPhRWz8UTbXEJiBho8pI/8PdigpZkiNsCXpR4LyOEpoWbGgwxAJJ7OF/ew5VnhwytSDeDIVH8MmnhsM+meiPxGfVtc2zAXLmiwXmIx1pdV/txqX6j1yV2VJP7Cq/W2UTKtZfS6dxpi2sjNA3qXqU5o8frziy2mdAUbPTJ1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842514; c=relaxed/simple;
	bh=yI/gt1R3gK7ZHn9ABwDk+hOcOByC+1Nt2lKfurouHk0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Da7r6Fc8v8QJ9wkFCqgesJkFuVhEfWJGmSI+SXCDtWQeQwwqvkHrnP9CFE8tKzpPFLyg2Mmqn1kWS8xDU0MgM7M/NKMijOnuk0gex9VLI/XggCmWnY1G9zGenRrV23PZZIZEEd+lKAcfu91f8B8UnLZlPTEgTu3lyT/ggVUJ0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a99a5e90d24f11efa216b1d71e6e1362-20250114
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
X-CID-O-INFO: VERSION:1.1.45,REQID:2b251023-b72c-4148-a1b3-2bdf7f2b4699,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACT
	ION:release,TS:20
X-CID-INFO: VERSION:1.1.45,REQID:2b251023-b72c-4148-a1b3-2bdf7f2b4699,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6493067,CLOUDID:2fdeae1298d53e260d0628e156d50427,BulkI
	D:250114161506LJNTHBKB,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: a99a5e90d24f11efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 234293210; Tue, 14 Jan 2025 16:15:06 +0800
From: liuye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/timens/procfs: Fix Resource leak proc in read_proc_uptime
Date: Tue, 14 Jan 2025 16:15:01 +0800
Message-Id: <20250114081501.110336-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Exception branch returns without closing proc.
Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/timens/procfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
index 1833ca97eb24..e47844a73c31 100644
--- a/tools/testing/selftests/timens/procfs.c
+++ b/tools/testing/selftests/timens/procfs.c
@@ -79,9 +79,11 @@ static int read_proc_uptime(struct timespec *uptime)
 	if (fscanf(proc, "%lu.%02lu", &up_sec, &up_nsec) != 2) {
 		if (errno) {
 			pr_perror("fscanf");
+			fclose(proc);
 			return -errno;
 		}
 		pr_err("failed to parse /proc/uptime");
+		fclose(proc);
 		return -1;
 	}
 	fclose(proc);
-- 
2.25.1


