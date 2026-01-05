Return-Path: <linux-kselftest+bounces-48192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4796CF3074
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 854EC3053800
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11E4313E02;
	Mon,  5 Jan 2026 10:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Fz2JOjb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29AB2D8382;
	Mon,  5 Jan 2026 10:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609561; cv=none; b=i97XljJZhGKsRmxPXlaSKPaIZDMSDVSdDYmPnFoWXbXcYoLrL1t7FmNSDL4wYxD2JWo3y19xP15sVWJdaPfZ/AZ5m38w5Cf/KSjUpwB+jkbY6c/xLyVewA+vh49OT/BSk5H7BfgDfWAgyXIG22x83U2jBiGBxIUiGoyOOa543SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609561; c=relaxed/simple;
	bh=auaWrlklStGyGtxL5JgH4a3smEJfo2D0fNwKvm7SaKo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ci135+EovxVX8FBQ3t/LjMPi1QuX2fxxNVKaZVVJoDg4JTCTtSZuwI8lFGTW+b/bFYtlRmCTnDZ8LsQ0QDSO3aSoF/A8dejiMdp6MqcF3/uT1jIzsp1p/uAZmgFe6jeng4m4UwV9xBPLfoIEc6gPcp/y449hcwMkWQvUHafAdMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Fz2JOjb4; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=l3s7cX/ZeOHl9HnqSZY8U8DaJGP2WKlEP0TykuYXlbM=;
	b=Fz2JOjb4Te8gnO7rj4dgrJ7j+hrcNBCFgX/jivMD93VAMHJGMXFOwHSVS4imda5hIQsfjhwCY
	ZimlykASdKpWy8j/AGUGvXUPUaq5Iu5hmnLE+f9S5gPh7L5BQUjdwefwpb+HTSL8Iwl3jo/CjGF
	Vt+tJckoOQUSnru8/0geYw0=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dl9gL5NTDzcb14;
	Mon,  5 Jan 2026 18:35:42 +0800 (CST)
Received: from dggpemf100004.china.huawei.com (unknown [7.185.36.110])
	by mail.maildlp.com (Postfix) with ESMTPS id 08AFD404AD;
	Mon,  5 Jan 2026 18:39:11 +0800 (CST)
Received: from huawei.com (10.175.121.217) by dggpemf100004.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 5 Jan
 2026 18:39:09 +0800
From: Cao Jiaqiang <caojiaqiang@huawei.com>
To: <gregkh@linuxfoundation.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<shuah@kernel.org>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dsahern@kernel.org>, <vincent.wang@huawei.com>, <liujian56@huawei.com>,
	<yi.zhang@huawei.com>, <caojiaqiang@huawei.com>
Subject: [PATCH 5.15.y] selftests: net: test_vxlan_under_vrf: fix HV connectivity test
Date: Mon, 5 Jan 2026 18:52:51 +0800
Message-ID: <20260105105251.33854-1-caojiaqiang@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf100004.china.huawei.com (7.185.36.110)

From: Andrea Righi <andrea.righi@canonical.com>

[ Upstream commit e7e4785fa30f9b5d1b60ed2d8e221891325dfc5f ]

It looks like test_vxlan_under_vrf.sh is always failing to verify the
connectivity test during the ping between the two simulated VMs.

This is due to the fact that veth-hv in each VM should have a distinct
MAC address.

Fix by setting a unique MAC address on each simulated VM interface.

Without this fix:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [FAIL]

With this fix applied:

 $ sudo ./tools/testing/selftests/net/test_vxlan_under_vrf.sh
 Checking HV connectivity                                           [ OK ]
 Check VM connectivity through VXLAN (underlay in the default VRF)  [ OK ]
 Check VM connectivity through VXLAN (underlay in a VRF)            [FAIL]

NOTE: the connectivity test with the underlay VRF is still failing; it
seems that ARP requests are blocked at the simulated hypervisor level,
probably due to some missing ARP forwarding rules. This requires more
investigation (in the meantime we may consider to set that test as
expected failure - XFAIL).

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Cao Jiaqiang <caojiaqiang@huawei.com>
---
 tools/testing/selftests/net/test_vxlan_under_vrf.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_under_vrf.sh b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
index 6fadc8e2f116..1fd1250ebc66 100755
--- a/tools/testing/selftests/net/test_vxlan_under_vrf.sh
+++ b/tools/testing/selftests/net/test_vxlan_under_vrf.sh
@@ -101,6 +101,8 @@ setup-vm() {
     ip -netns hv-$id link set veth-tap master br0
     ip -netns hv-$id link set veth-tap up
 
+    ip link set veth-hv address 02:1d:8d:dd:0c:6$id
+
     ip link set veth-hv netns vm-$id
     ip -netns vm-$id addr add 10.0.0.$id/24 dev veth-hv
     ip -netns vm-$id link set veth-hv up
-- 
2.22.0


