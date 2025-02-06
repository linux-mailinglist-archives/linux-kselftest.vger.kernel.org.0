Return-Path: <linux-kselftest+bounces-25877-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA57A29E9C
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 03:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3037E167899
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 02:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3010B70838;
	Thu,  6 Feb 2025 02:12:57 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12566A33B;
	Thu,  6 Feb 2025 02:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738807977; cv=none; b=mHzS/PjIe71rGu5JpolAAhQZqUBzS2ySGvPtSDJPPk9i9H+eq1ey+/ogf+iJ28j4gFaMSBhSPxQwoGDDCyX5BDlo2BQebODdHaRQ/++bqL6dYLNXZLuHkNebx0KywZrHUf0xRvqDEp8z1YHR3lxzX6xs+vZFUN3z4ag4xHcevK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738807977; c=relaxed/simple;
	bh=MPbnuZ1ow3tlM4Uv6Z/zyzk9+r7Hmhv9A/qr2lRAQ3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diFQopcJ3Ngcc791hM/MRrwF9ljlG8y92WIklD3iyQMWTXuJrzDNK4EcrdpBB4o3Rt3dOBclpPXk8N9fefzNb3BxD1vYvA5uzOr5rNzJdmw90Hsbov8ZSqLY9W5Gfrv33GzL2oJ1e6qr/uxb3betRPc8bPtwXqxgapCDj0ZPOWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: da6ca3d8e42f11efa216b1d71e6e1362-20250206
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_T1, AMN_GOOD, AMN_C_TI, AMN_C_BU
	ABX_MISS_RDNS
X-CID-CACHE: Type:Local,Time:202502061008+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:819c88e5-44d1-4377-87f2-e8eebea3ecf4,IP:10,
	URL:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,AC
	TION:release,TS:-35
X-CID-INFO: VERSION:1.1.45,REQID:819c88e5-44d1-4377-87f2-e8eebea3ecf4,IP:10,UR
	L:0,TC:0,Content:0,EDM:-30,RT:0,SF:-15,FILE:0,BULK:0,RULE:EDM_GN8D19FE,ACT
	ION:release,TS:-35
X-CID-META: VersionHash:6493067,CLOUDID:6aad5d02811ccb8a696d51ce0a976a2f,BulkI
	D:2502061008201UDVF6YE,BulkQuantity:0,Recheck:0,SF:17|19|24|44|66|78|102,T
	C:nil,Content:0|50,EDM:2,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: da6ca3d8e42f11efa216b1d71e6e1362-20250206
X-User: liuye@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <liuye@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 609545772; Thu, 06 Feb 2025 10:12:45 +0800
From: Liu Ye <liuye@kylinos.cn>
To: shuah@kernel.org
Cc: zhujun2@cmss.chinamobile.com,
	iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Ye <liuye@kylinos.cn>
Subject: [PATCH] selftests/dma: Fix bad array reference.
Date: Thu,  6 Feb 2025 10:12:39 +0800
Message-Id: <20250206021239.51897-1-liuye@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dir[directions] should be directions[dir] to correctly index the
directions array.

Signed-off-by: Liu Ye <liuye@kylinos.cn>
---
 tools/testing/selftests/dma/dma_map_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index b12f1f9babf8..b925756373ce 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 	}
 
 	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
-			threads, seconds, node, dir[directions], granule);
+			threads, seconds, node, directions[dir], granule);
 	printf("average map latency(us):%.1f standard deviation:%.1f\n",
 			map.avg_map_100ns/10.0, map.map_stddev/10.0);
 	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
-- 
2.25.1


