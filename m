Return-Path: <linux-kselftest+bounces-18460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B44988350
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 13:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 261D5281870
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 11:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145D189B88;
	Fri, 27 Sep 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="qayqo+NG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pv50p00im-ztbu10021601.me.com (pv50p00im-ztbu10021601.me.com [17.58.6.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C0188A19
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727436548; cv=none; b=iYwS59XXmMgy2khGnPl+zAMbuU5IGRK+GxPlPe0SFLA9X+OmfoFCTxMKgLpy8blj6iJKy2KahF4vQ+YkO885qxhK5F+SUSEu8fa2J4x7aaaJsriojJRzhLj9b+G6Slj1mWFODUpS02Wf0UdvO4ve5zN1eIjwfS90kiiCeRDss5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727436548; c=relaxed/simple;
	bh=rk1gw1GYIq555GVXnBrmmHYxpEBquNuWdvp/FwYd/B0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwmx8t9S95wZUrVwl88xnN0aA6WKvvxG6R+oM9q/HXOILMD/JG/G+mMAXhUA40ZPSDX1zLWVtIs//iLD3VUsnwWRN8ETs9JiaTZS6vn6xLKpFlsW6NjNF6E9Mvs/gE5gO75I/WtX/6lIb7k00WL5ag6N3bv99MbbifDYcGJx8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=qayqo+NG; arc=none smtp.client-ip=17.58.6.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1727436546;
	bh=gahwgEjwJ8WJdDaKDONVkWLZffBPs8UIBVa1U8f6z5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qayqo+NGF8h5pnYrk+Bvu4sI9LY7eOAzkJZvAIvEmdfOvhhNdJIHHotz+UmAoNXZD
	 sAwkmjOAkK4/eCUTgwWe3YTq3RyF0YGXvSF++v6Uyf3f8GoGif8S0dzc6Ybpok++J3
	 AtW6BTy69Amy2tdCSMu8ntk3+Lnbxkf2eVSnNB9t0JoO1jKrr44wcPEEh1jnPkZT0A
	 7Vog+9Ar5QcfPmEpz6LpGUrLAuuccfAmwdewuVudcgUDDvJphw2DAnf7RlazNJIJth
	 WgXW0pxn6P7h+B0bMAAbCMMGW8chfVlb8BLQR0LHyvu0tYqg3IM9SBAIA2TdSSE8er
	 leXf2PyuRItog==
Received: from ubuntu.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-ztbu10021601.me.com (Postfix) with ESMTPSA id D8672801E3;
	Fri, 27 Sep 2024 11:28:56 +0000 (UTC)
From: Kacper Ludwinski <kac.ludwinski@icloud.com>
To: davem@davemloft.net
Cc: kuba@kernel.org,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petrm@nvidia.com,
	horms@kernel.org,
	edumazet@google.com,
	shuah@kernel.org,
	Kacper Ludwinski <kac.ludwinski@icloud.com>
Subject: [PATCH net v3] selftests: forwarding: no_forwarding: Fix issue related with assigning two different vids to the same interface.
Date: Fri, 27 Sep 2024 20:28:24 +0900
Message-ID: <20240927112824.339-1-kac.ludwinski@icloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -BAgs17o5Cq4uYCJT73esTrIfu-z6C_B
X-Proofpoint-GUID: -BAgs17o5Cq4uYCJT73esTrIfu-z6C_B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-27_06,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=999 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2409270082
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

Fix typo.
Currently, the second bridge command overwrites the first one.
Fix this by adding this VID to the interface behind $swp2.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Kacper Ludwinski <kac.ludwinski@icloud.com>
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


