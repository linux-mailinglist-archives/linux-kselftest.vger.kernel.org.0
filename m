Return-Path: <linux-kselftest+bounces-18338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6090C98522C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 07:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2810F285667
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7EB1547F2;
	Wed, 25 Sep 2024 05:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b="hczqQYZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pv50p00im-ztbu10011701.me.com (pv50p00im-ztbu10011701.me.com [17.58.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42E51870
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Sep 2024 05:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727240826; cv=none; b=PzYiKQ22Sus9NorhEGyCwD2wJPvij+Pi5WnLxAZWBv2MVIpXRSv7INUPkJeloYd1j1rmXoNH055822HbHBqNhwaC4pWDFvY+htJOYvFn3Qyz/BbbV9SY2T2TeSd3NrnuxY2k/J2sXXJPERig6hmQWfkvCjciZuUDuzdW4Yv5Yak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727240826; c=relaxed/simple;
	bh=ZQmPLurWg8bBFA6Nqi8RQUZAXqWWg/v371tCKDxHcJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gC8JlAjmA5kYDSkRMrC28LLkaiJEaiZQXCjIXpYZlIYcjz/9tYfu9FZBupHjsXn4E+2oMeCVWvMGEhbvL0hHsFqHidY0S6UImVfb4mYzz563rVfbvDm5g1L0URyBzNTkQf/iY1w0tk1y2jZDH6GgffAakUiFz2XWvdfLe+Z7U08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev; spf=pass smtp.mailfrom=ludwinski.dev; dkim=pass (2048-bit key) header.d=ludwinski.dev header.i=@ludwinski.dev header.b=hczqQYZF; arc=none smtp.client-ip=17.58.6.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ludwinski.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ludwinski.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ludwinski.dev;
	s=sig1; t=1727240823;
	bh=0ScNFFQi3tBi9pjXGBPJ4aeFaBdyK4X71baS0jOPlj8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=hczqQYZF9sYYjAUdT95lyUx2+qO5Zs9fCnCr/vJROwjzp6FK/uL9RXDXtBffUGGUc
	 ZyuV1KnJLdfspUdzgDPugYIcizk03kuBEpqPp0Jq7Z1lIQ61dbt3DnvDwpf0uvQmSj
	 iy1IOa4bGq7ecMf7JmAeqXyrk96j9DwiqSL5Kv3kWVLacyFwgOREJird1QCCBev8ut
	 DNihAN726oYHnLFPG6OcLqv/D3zEGHDbm/WGiYOLsmzQPVOxILlDthrA5Ul8LbKazn
	 Mxhi8Tg40rV3Hq2NmA7e1S/doH5D+nZ9TDq8fOHi50AwMeVPe3jRA8lkpJYPon8+dM
	 GptoRLnpi6Rzg==
Received: from ubuntu.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id E34E974032B;
	Wed, 25 Sep 2024 05:06:38 +0000 (UTC)
From: Kacper Ludwinski <kacper@ludwinski.dev>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Kacper Ludwinski <kacper@ludwinski.dev>
Subject: [PATCH] Fix issue related with assigning two diffrent vids to the same interface.
Date: Wed, 25 Sep 2024 14:05:39 +0900
Message-ID: <20240925050539.1906-1-kacper@ludwinski.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925043724.1785-1-kacper@ludwinski.dev>
References: <20240925043724.1785-1-kacper@ludwinski.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e9IBxhJkomuhuHVFvVPdjIMgWI83dFH5
X-Proofpoint-ORIG-GUID: e9IBxhJkomuhuHVFvVPdjIMgWI83dFH5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1030
 mlxlogscore=654 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2409250034

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
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


