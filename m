Return-Path: <linux-kselftest+bounces-18561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D7B9898F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 03:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4D46B2153C
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB292119;
	Mon, 30 Sep 2024 01:33:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5BC8F45;
	Mon, 30 Sep 2024 01:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727659998; cv=none; b=b7djEE61kX6PQV2ihHoHGKFBrNW9ikrmVEjfvh9F8Ehds3JwDl1X91iGmvVCbW10Y/maXUmL2927VBeknTnOYZu5hD9e1jpgBce/WyhuqwYLo91uADs4rvDaNvtcxOkAly6JfZsaYp7K2GS+lWk/42BJMDqz6YI41WEBF5XSETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727659998; c=relaxed/simple;
	bh=08VJNtcS+rcA7QZ4rAKhlxeMH19+5rRxSPp9p1HDcaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P7NUWBpur/Q+uwE2cR40SymKHdAgfzwYAX+uS/4/Swy1J1wIXzBrrmvK6i5aY07wCdt9tFkR9CGlYFS3w21kX3cxxpkWnCYPW8GKY9a85LiVhZ61ZyqeaINdpTQEzQ0Gq+BiuN/NcLvSEddNJLoRdxzmTkqPLrLYIa+omDAgt7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f1d073027ecb11efa216b1d71e6e1362-20240930
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_UNTRUSTED, SRC_UNTRUSTED, IP_UNFAMILIAR, SRC_UNFAMILIAR, DN_TRUSTED
	SRC_TRUSTED, SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS
	DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD_SPF, CIE_UNKNOWN
	GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_T1, AMN_GOOD
	AMN_C_TI, AMN_C_BU, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:7cfdac14-61c4-4608-b71a-8d392611962c,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:40
X-CID-INFO: VERSION:1.1.38,REQID:7cfdac14-61c4-4608-b71a-8d392611962c,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:40
X-CID-META: VersionHash:82c5f88,CLOUDID:cf79c44db204f9b2660c90e28a0a05dc,BulkI
	D:240930093309R2IFMP0Z,BulkQuantity:0,Recheck:0,SF:72|19|43|74|66|38|23|10
	2,TC:nil,Content:0,EDM:5,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FSD
X-UUID: f1d073027ecb11efa216b1d71e6e1362-20240930
X-User: tianyaxiong@kylinos.cn
Received: from tian-thinkpad-x390.. [(223.153.174.217)] by mailgw.kylinos.cn
	(envelope-from <tianyaxiong@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 104374964; Mon, 30 Sep 2024 09:33:07 +0800
From: Yaxiong Tian <tianyaxiong@kylinos.cn>
To: martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	shuah@kernel.org,
	hinker.li@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <iambestgod@outlook.com>,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH] selftests/bpf: Add __init and __exit to the functions bpf_test_no_cfi_init()/bpf_test_no_cfi_exit()
Date: Mon, 30 Sep 2024 09:33:01 +0800
Message-Id: <20240930013301.10817-1-tianyaxiong@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yaxiong Tian <iambestgod@outlook.com>

To save some running memory,Add __init and __exit to the
module load/unload functions.

Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
index 948eb3962732..aa571ab3c6c6 100644
--- a/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
+++ b/tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
@@ -56,7 +56,7 @@ static struct bpf_struct_ops test_no_cif_ops = {
 	.owner = THIS_MODULE,
 };
 
-static int bpf_test_no_cfi_init(void)
+static int __init bpf_test_no_cfi_init(void)
 {
 	int ret;
 
@@ -71,7 +71,7 @@ static int bpf_test_no_cfi_init(void)
 	return ret;
 }
 
-static void bpf_test_no_cfi_exit(void)
+static void __exit bpf_test_no_cfi_exit(void)
 {
 }
 
-- 
2.34.1


