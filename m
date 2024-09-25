Return-Path: <linux-kselftest+bounces-18337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF3985214
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 06:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D51F24DE9
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 04:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C36153BF7;
	Wed, 25 Sep 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b="SjVdS4dq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from ms11p00im-qufo17282001.me.com (ms11p00im-qufo17282001.me.com [17.58.38.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD31A14B959
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 04:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727239118; cv=none; b=PDX90uTLo9nJ9okwbO/cLLqkZCkHPsxffhf8DINDM71zcMwyEsYskmocdwU/Qz5LTQK6uWwhq8shIlO02OMGaFKUehU13TpHxsnW05HDM3onozZGql5ewBjxqm4k3P2HGD705Q5LTLIn/Cb9S4bfCcY3eMos2ne7CmA+MUSti4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727239118; c=relaxed/simple;
	bh=cnwFYYGk82ueC0ybmoGUyCpSEP839tim3QSaNtcvnGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHM+Ok1V7FkFBFc1QC0XHtlsF/A5/+sbrL4n+2gq+ElH4XLj+0C5h3hXKpMqCc7FRif6frxqFfwQlBifhSueACAeF8OCEaeHKBKcaWeZdIsxpuSZGsrT/lA4624B7gSP0vfQeTWZzJnIOOOpuVYuzIO5RzGoIIGlylhqukywxEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev; spf=pass smtp.mailfrom=ludwinski.dev; dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b=SjVdS4dq; arc=none smtp.client-ip=17.58.38.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ludwinski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ludwinski.dev;
	s=sig1; t=1727239115;
	bh=A8K/uFUDiFHk8zlvTjYFSNdfEg//HrYSwqvjOdFpdsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=SjVdS4dqEhl9uIfMbErv7DLAwl5HBMBkWHJanLU1S62rNv+bp8oji2gxU7VhmQ6iR
	 9aapo3HjRJ3CSLR+Mm6YVzeR+yeVAB2Dwmef4jwPrFMbxHyuaA7hhOYdcBmYocNX7n
	 HG3hrqSheKn4y5rCL8YU4kHME7owe+eDB37c90q5t5Eo6zLVngA9e5WwqPSUZOEQVG
	 gzvRJpbPpwhYuSOVRjqKNj7rcng0ZEU8u/jfOYqPDGo0fluuiVJZfz8FjvmGNn3oqw
	 JPTaz/lzf4gXKRoC6QH5qRJTC6c5FeaWyQEBG1FfeGycXk4h49JjVZxXtRCZIxs7pX
	 U7qvCRsj5qzoQ==
Received: from ubuntu.. (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17282001.me.com (Postfix) with ESMTPSA id EB1131E0223;
	Wed, 25 Sep 2024 04:38:31 +0000 (UTC)
From: Kacper Ludwinski <kacper@ludwinski.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Kacper Ludwinski <kacper@ludwinski.dev>
Subject: [PATCH] Fix issue related with assigning two diffrent vids to the same interface.
Date: Wed, 25 Sep 2024 13:37:24 +0900
Message-ID: <20240925043724.1785-1-kacper@ludwinski.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 9NI5YyQG8HNCNDON2XDDpFn56xFtAmzS
X-Proofpoint-GUID: 9NI5YyQG8HNCNDON2XDDpFn56xFtAmzS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=639 malwarescore=0 phishscore=0 spamscore=0 suspectscore=0
 clxscore=1030 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409250030

Fixes: 476a4f0 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Kacper Ludwinski <kacper@ludwinski.dev>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index 9e677aa64a06..694ece9ba3a7 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -202,7 +202,7 @@ one_bridge_two_pvids()
 	ip link set $swp2 master br0
 
 	bridge vlan add dev $swp1 vid 1 pvid untagged
-	bridge vlan add dev $swp1 vid 2 pvid untagged
+	bridge vlan add dev $swp2 vid 2 pvid untagged
 
 	run_test "Switch ports in VLAN-aware bridge with different PVIDs"
 
-- 
2.43.0


