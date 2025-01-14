Return-Path: <linux-kselftest+bounces-24425-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6FFA0FF84
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 04:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB0F1697E8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 03:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5C23026F;
	Tue, 14 Jan 2025 03:35:10 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123E617543;
	Tue, 14 Jan 2025 03:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825710; cv=none; b=nnbSx3YmNLrSyVctdrlt3sFGMygMKLqZyospyo2yqXhBvSEmZm2vVxop72jaUAvpivg2lWWUkNJLJeJjoi+F7bszQHld6FeTPD5VUh2CIh9UyDnq94bbfE9qAHqH0z5TP/KsymgQIo1IDJqhY8dB4mhY2pSdA/oCDBQFFxQnhHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825710; c=relaxed/simple;
	bh=XaWaR/L2Ba1vhirP0EMbhuXRXuzihNtUDBT516DZfQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jlNYoh+BZODdrIpWH6YnFE5QP1gTgJOJ+06LV6gshQCtxKrehu/78vYOzGvFD+Nw/kise6z59qc+l7kmdq7/04wwdyfX3T/uOck63eC1TaJP03yxVCer6sVCv3pz2t0PB5I3VQ3gb3/fskpC5nB6uLmq80nrB82p4Z3CcDMR9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 89750696d22811efa216b1d71e6e1362-20250114
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
X-CID-O-INFO: VERSION:1.1.45,REQID:e9b35b08-22df-43bf-96ed-60208467d408,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.45,REQID:e9b35b08-22df-43bf-96ed-60208467d408,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:4a66c22110f6700263eddaa5bc23f8fb,BulkI
	D:250114113502UPUYUWF7,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:
	nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 89750696d22811efa216b1d71e6e1362-20250114
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1877572655; Tue, 14 Jan 2025 11:35:01 +0800
From: liuye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: abdulrasaqolawani@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuye <liuye@kylinos.cn>
Subject: [PATCH] selftests/acct/acct_syscall: Fix file descriptor leak
Date: Tue, 14 Jan 2025 11:34:56 +0800
Message-Id: <20250114033456.62179-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

    Exception branch returns without closing fp.
Signed-off-by: liuye <liuye@kylinos.cn>
---
 tools/testing/selftests/acct/acct_syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
index e44e8fe1f4a3..a8a4f8fc9ef9 100644
--- a/tools/testing/selftests/acct/acct_syscall.c
+++ b/tools/testing/selftests/acct/acct_syscall.c
@@ -54,6 +54,7 @@ int main(void)
 	if (child_pid < 0) {
 		ksft_test_result_error("Creating a child process to log failed\n");
 		acct(NULL);
+		fclose(fp);
 		return 1;
 	} else if (child_pid > 0) {
 		wait(NULL);
@@ -65,6 +66,7 @@ int main(void)
 		if (sz <= 0) {
 			ksft_test_result_fail("Terminated child process not logged\n");
 			ksft_exit_fail();
+			fclose(fp);
 			return 1;
 		}
 
@@ -73,6 +75,6 @@ int main(void)
 		ksft_exit_pass();
 		return 0;
 	}
-
+	fclose(fp);
 	return 1;
 }
-- 
2.25.1


