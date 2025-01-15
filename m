Return-Path: <linux-kselftest+bounces-24548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D34A117B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 04:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CDAA16561A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7449922E403;
	Wed, 15 Jan 2025 03:13:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5826D20CCD9;
	Wed, 15 Jan 2025 03:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736910825; cv=none; b=GIkY5w+Udupp/CR9z2oXZltkpWorDDOWbnu/azv8RQu3M6Yx3JRNFtpfXoDomgw9NOKrzZhUynUBi0NnDfklNnUWOKjqALYhRsTf4cFbXicrvg56ZxcqM8syPdWENDxBFmFHgGXm7x0/QpAFRF+OXhISnLQD2SwfMNr/mcWdLpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736910825; c=relaxed/simple;
	bh=19fhQBX1GnkzmQ9DU/Ak5HELfw73UfqbA4i/2V/XM14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JyN8qrqnSuPRQkeNggHtcHrJCca7xfdONS7P6XILO4C7i/y6hzVgM/rGnJPXOqtk3c9fNNFgYU8u4cSXh8fv7XlUowjextim5MIaOnCRHVEGLCS6RgsTs1KzKoYspgyKm5koZkmK0MLmEeJI6//Sl7vT2/Uxng9LNkm9ZQMjQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b209254ed2ee11efa216b1d71e6e1362-20250115
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NO_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:45d68ee1-211d-47c8-a391-f8cbda3922f5,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:30
X-CID-INFO: VERSION:1.1.45,REQID:45d68ee1-211d-47c8-a391-f8cbda3922f5,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:30
X-CID-META: VersionHash:6493067,CLOUDID:175ee3dc6dc9720ea11cec0ee7149125,BulkI
	D:250115111333OMY4YBWU,BulkQuantity:0,Recheck:0,SF:17|19|24|42|66|74|78|81
	|82|100|101|102,TC:nil,Content:0|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk
	:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,
	BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b209254ed2ee11efa216b1d71e6e1362-20250115
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1552104714; Wed, 15 Jan 2025 11:13:30 +0800
From: Liu Ye <liuye@kylinos.cn>
To: horms@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	herbert@gondor.apana.org.au,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	liuye@kylinos.cn,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	shuah@kernel.org,
	steffen.klassert@secunet.com
Subject: [PATCH net V2] selftests/net/ipsec: Fix Null pointer dereference in rtattr_pack()
Date: Wed, 15 Jan 2025 11:13:22 +0800
Message-Id: <20250115031322.43561-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114160126.GJ5497@kernel.org>
References: <20250114160126.GJ5497@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: liuye <liuye@kylinos.cn>

From: Liu Ye <liuye@kylinos.cn>

Address Null pointer dereference in rtattr_pack.

Flagged by cppcheck as:
    tools/testing/selftests/net/ipsec.c:230:25: warning: Possible null pointer
    dereference: payload [nullPointer]
    memcpy(RTA_DATA(attr), payload, size);
                           ^
    tools/testing/selftests/net/ipsec.c:1618:54: note: Calling function 'rtattr_pack',
    4th argument 'NULL' value is 0
    if (rtattr_pack(&req.nh, sizeof(req), XFRMA_IF_ID, NULL, 0)) {
                                                       ^
    tools/testing/selftests/net/ipsec.c:230:25: note: Null pointer dereference
    memcpy(RTA_DATA(attr), payload, size);
                           ^
Fixes: 70bfdf62e93a ("selftests/net/ipsec: Add test for xfrm_spdattr_type_t")
---
V2: Modify description.
    Add code checking tools.
    Separating family and given name in Signed-off-by line.
    Modify code format.
    Add fixes.
---

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 tools/testing/selftests/net/ipsec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index be4a30a0d02a..9b44a091802c 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -227,7 +227,8 @@ static int rtattr_pack(struct nlmsghdr *nh, size_t req_sz,
 
 	attr->rta_len = RTA_LENGTH(size);
 	attr->rta_type = rta_type;
-	memcpy(RTA_DATA(attr), payload, size);
+	if (payload)
+		memcpy(RTA_DATA(attr), payload, size);
 
 	return 0;
 }
-- 
2.25.1


