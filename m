Return-Path: <linux-kselftest+bounces-24424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00824A0FF26
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 04:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 157B3168C73
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F22309B9;
	Tue, 14 Jan 2025 03:21:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F62135AF;
	Tue, 14 Jan 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736824895; cv=none; b=PMMI/T2XZcU6xh4Sj4E8z/8mIiklNPPxyOqVw44cFUuLBadQen8bUYBIvZQ867furHFAXHLnOaMOrEhRJhJw9uMLlUZ34z0qKcEILwNoCeGToy6bwG9rjI9Fj2t7zOWyEys+mUQPXj5J7dCRV1fYfXAu/m96gujF8LEBgykmbU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736824895; c=relaxed/simple;
	bh=6FVZBhlARSUjiY7jL5gfTZ+7TE1QkBzAjx9DQy3UNzE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ee9L4LXp4Qd1Z8W/NoelWV2TJT9fABxrcjVwFrMx5QFjhIbeIkghGWI0vD8KXfxCoEDE+7n3hqjVQUue2bJP9v0xcDJ7uzYGk/e18Z3XXlvwVK/TR5Pvl/YUsFOOffyl4isEzMxZ5gKYAG1m1bDYN75b5EYu+O0vf0vfl6dIs8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a16fe1dcd22611efa216b1d71e6e1362-20250114
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
X-CID-O-INFO: VERSION:1.1.45,REQID:27230a6d-843a-4920-91a5-09be823a5986,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:27230a6d-843a-4920-91a5-09be823a5986,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:a1c314994a8851facfc1fd68fca71cb8,BulkI
	D:2501141121263L6GQO2Z,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR
X-UUID: a16fe1dcd22611efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1909309603; Tue, 14 Jan 2025 11:21:23 +0800
From: liuye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: akpm@linux-foundation.org,
	jeffxu@google.com,
	isaacmanjarres@google.com,
	lorenzo.stoakes@oracle.com,
	gthelen@google.com,
	sauravshah.31@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/memfd/memfd_test: Fix possible NULL pointer dereference
Date: Tue, 14 Jan 2025 11:21:15 +0800
Message-Id: <20250114032115.58638-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    If name is NULL, a NULL pointer may be accessed in printf.

Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/memfd/memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index c0c53451a16d..5b993924cc3f 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -171,7 +171,7 @@ static void mfd_fail_new(const char *name, unsigned int flags)
 	r = sys_memfd_create(name, flags);
 	if (r >= 0) {
 		printf("memfd_create(\"%s\", %u) succeeded, but failure expected\n",
-		       name, flags);
+		       name ? name : "NULL", flags);
 		close(r);
 		abort();
 	}
-- 
2.25.1


