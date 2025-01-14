Return-Path: <linux-kselftest+bounces-24435-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0D2A101FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 09:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FEC718855BE
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 08:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50B32500C8;
	Tue, 14 Jan 2025 08:27:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129D91C3BE1;
	Tue, 14 Jan 2025 08:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843228; cv=none; b=ZXZNR9FnLs6ReuFhsaHq2TkE6BbIBGSHaZrcHv876TniGUpeJL+y6QS4K9QtoV4uDTFzqFLaYDdgz9C02RS4BWp82UMN8hF+v6MnxyRFskecBcgfOYjpJlIddAls0huwdUZ8YIWURAtX/3vSb6gTv0nqiHy5Amx8LTfK5D/3q1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843228; c=relaxed/simple;
	bh=HNK4XmTZgkL57rc4SKg5UD+hMPqB6MFCTRpmbEplU9E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XMxlACsAdruVHDdzR53yzNFkD5ORQ7ifSH7+cGoglKYgw+d5UFX7gGUtzZm06gS/SOa45iwI8QoH/ZZ2j23qNB1FyAomdngaMv8PXFnevdOIU1Fli6i9r3NO6q1/eRY3Bih65wdNg+cZoioC1KstTO5HzBmjg+Dcco494o4n0uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 51c80b16d25111efa216b1d71e6e1362-20250114
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6ebcb8c2-c68b-4843-88ec-f8ca786aba21,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:6ebcb8c2-c68b-4843-88ec-f8ca786aba21,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:2b9900c9a86a09c8b2b53bc6c4fc9dd5,BulkI
	D:250114162700AODYS4L7,BulkQuantity:0,Recheck:0,SF:17|19|24|38|44|66|78|10
	2,TC:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,B
	EC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 51c80b16d25111efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 830795914; Tue, 14 Jan 2025 16:26:57 +0800
From: liuye <liuye@kylinos.cn>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	shuah@kernel.org,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/x86/lam: Fix Memory leak fi in do_uring
Date: Tue, 14 Jan 2025 16:26:50 +0800
Message-Id: <20250114082650.113105-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Exception branch returns without free fi.
Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/x86/lam.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 0ea4f6813930..74f422e76dce 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -596,8 +596,10 @@ int do_uring(unsigned long lam)
 	fi->file_fd = file_fd;
 
 	ring = malloc(sizeof(*ring));
-	if (!ring)
+	if (!ring) {
+		free(fi);
 		return 1;
+	}
 
 	memset(ring, 0, sizeof(struct io_ring));
 
-- 
2.25.1


