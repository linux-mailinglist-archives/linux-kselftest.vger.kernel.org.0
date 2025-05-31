Return-Path: <linux-kselftest+bounces-34105-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1899AAC9A46
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17579189D66E
	for <lists+linux-kselftest@lfdr.de>; Sat, 31 May 2025 09:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A695238C3C;
	Sat, 31 May 2025 09:41:14 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B9C2367A6
	for <linux-kselftest@vger.kernel.org>; Sat, 31 May 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748684474; cv=none; b=JIHEczX+nfCZLaEF3kiV5npY+kXqXW2vGzsgjO1U0p9vpjFIRZQdmEdirupDO9u96QmHLfDDWLgOj+qxZV6sETTlY3KDnpEX7WuTcKzM+9OVhePKXFkumcsZ1M/KNdDIzzcadh4Hkaam3GPP4BWzDAUYh4uIt98VgnWVuP9qXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748684474; c=relaxed/simple;
	bh=IQDBV1iizNhVrtnNG+NNT84wSuJakI4vpYHNCeGvRwU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MZ4dF+84ingDJIOwY8NTepIPL4ACWiyXhy47MQ8bdj27jmSDpiHbuhYjZo+7ElhrTZ+Dm7rfwmMzG6CYMqfa8dtX2LtQTS82PX0urJ5AnZ8cQMf+zGSV9EblXvTWfLsXReDlVhgR8ziPB+kJhTBSqdO2o7BDxvNXgjbmmWQOeoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5b16c1443e0311f0b29709d653e92f7d-20250531
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_LOWREP, SRC_LOWREP, DN_TRUSTED
	SRC_TRUSTED, SA_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1
	AMN_GOOD, AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f956c98f-4bfd-40d2-a1d3-feb70bb9b648,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:5
X-CID-INFO: VERSION:1.1.45,REQID:f956c98f-4bfd-40d2-a1d3-feb70bb9b648,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:5
X-CID-META: VersionHash:6493067,CLOUDID:b2c9250d742b24aafa3ece4a54a07843,BulkI
	D:25053117311345NPQOAB,BulkQuantity:1,Recheck:0,SF:17|19|25|45|66|78|102,T
	C:nil,Content:0|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:40,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-UUID: 5b16c1443e0311f0b29709d653e92f7d-20250531
X-User: lienze@kylinos.cn
Received: from ubuntu.. [(61.48.215.241)] by mailgw.kylinos.cn
	(envelope-from <lienze@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 683696029; Sat, 31 May 2025 17:40:58 +0800
From: Enze Li <lienze@kylinos.cn>
To: sj@kernel.org,
	shuah@kernel.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	enze.li@gmx.com,
	Enze Li <lienze@kylinos.cn>
Subject: [PATCH] selftests/damon/_damon_sysfs: skip testcases if CONFIG_DAMON_SYSFS is disabled
Date: Sat, 31 May 2025 17:39:37 +0800
Message-ID: <20250531093937.1555159-1-lienze@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_DAMON_SYSFS is disabled, the selftests fail with the
following outputs,

not ok 2 selftests: damon: sysfs_update_schemes_tried_regions_wss_estimation.py # exit=1
not ok 3 selftests: damon: damos_quota.py # exit=1
not ok 4 selftests: damon: damos_quota_goal.py # exit=1
not ok 5 selftests: damon: damos_apply_interval.py # exit=1
not ok 6 selftests: damon: damos_tried_regions.py # exit=1
not ok 7 selftests: damon: damon_nr_regions.py # exit=1
not ok 11 selftests: damon: sysfs_update_schemes_tried_regions_hang.py # exit=1

The root cause of this issue is that all the testcases above do not
check the sysfs interface of DAMON whether it exists or not.  With this
patch applied, all the testcases above now pass successfully.

Signed-off-by: Enze Li <lienze@kylinos.cn>
---
 tools/testing/selftests/damon/_damon_sysfs.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/damon/_damon_sysfs.py b/tools/testing/selftests/damon/_damon_sysfs.py
index 6e136dc3df19..cab67addfb00 100644
--- a/tools/testing/selftests/damon/_damon_sysfs.py
+++ b/tools/testing/selftests/damon/_damon_sysfs.py
@@ -15,6 +15,10 @@ if sysfs_root is None:
     print('Seems sysfs not mounted?')
     exit(ksft_skip)
 
+if not os.path.exists(sysfs_root):
+    print('Seems DAMON disabled?')
+    exit(ksft_skip)
+
 def write_file(path, string):
     "Returns error string if failed, or None otherwise"
     string = '%s' % string

base-commit: 0f70f5b08a47a3bc1a252e5f451a137cde7c98ce
-- 
2.43.0


