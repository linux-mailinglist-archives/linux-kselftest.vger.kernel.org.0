Return-Path: <linux-kselftest+bounces-24430-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B1DA1007A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 06:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3A4188815A
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 05:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D2D231A5C;
	Tue, 14 Jan 2025 05:42:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1884B24025D;
	Tue, 14 Jan 2025 05:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736833330; cv=none; b=N3SeHhCW8eTpqkMMH17yjOLmVQBgM/rPl/+z8WdoFJ61rIfQ+dWY6FrbSJso4BUcVnYicQGeaR0pdjslNTqMcVb49KWuKbLyvqiF9bjAun9OeAXlNpmk8BqonXgjGgz1E5B8NhJbn5SPfRiusN+9AIzPLTkUR4pHTVulYLaUov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736833330; c=relaxed/simple;
	bh=pJ0ZMqAJVQHS+mzvS73FTFri7vqerXbdvVYDkcJAksU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ejNavEM4f6v5bPBpZVyGZ+qHi52z62ZoBSFhtZPEPDvrTg39S2vEnN7MoKroq+iYJfNEa65lSP9z8WMbEwtvL6DociiKo58CYkrlAg1rW8x886uCcMUVPbmCE2r27W1lp1p0+JsptLs2XQtYL2lEeTVUYZGmRZETfWtTPV+wz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 457bb6d0d23a11efa216b1d71e6e1362-20250114
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
X-CID-O-INFO: VERSION:1.1.45,REQID:e67ee197-e3d1-4fa4-8c24-94385079bfd7,IP:10,
	URL:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-30
X-CID-INFO: VERSION:1.1.45,REQID:e67ee197-e3d1-4fa4-8c24-94385079bfd7,IP:10,UR
	L:0,TC:0,Content:0,EDM:-25,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GE969F26,ACT
	ION:release,TS:-30
X-CID-META: VersionHash:6493067,CLOUDID:6882ff5972c98d22d96f231d27637257,BulkI
	D:2501141342010I5YS1S4,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:1,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: 457bb6d0d23a11efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1740425968; Tue, 14 Jan 2025 13:41:58 +0800
From: liuye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: amer.shanawany@gmail.com,
	usama.anjum@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/capabilities/test_execve: Initialize the variable have_outer_privilege
Date: Tue, 14 Jan 2025 13:41:29 +0800
Message-Id: <20250114054129.73331-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Uninitialized variable: have_outer_privilege.
    Fix it.

Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/capabilities/test_execve.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..c9617b38d6f7 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -83,7 +83,7 @@ static bool create_and_enter_ns(uid_t inner_uid)
 	uid_t outer_uid;
 	gid_t outer_gid;
 	int i, ret;
-	bool have_outer_privilege;
+	bool have_outer_privilege = false;
 
 	outer_uid = getuid();
 	outer_gid = getgid();
-- 
2.25.1


