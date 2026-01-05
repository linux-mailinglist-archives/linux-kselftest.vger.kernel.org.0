Return-Path: <linux-kselftest+bounces-48169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C27B7CF20F1
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 07:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6B24300F89D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAAA324B34;
	Mon,  5 Jan 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kVp2IGW+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5B2322539;
	Mon,  5 Jan 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767594268; cv=none; b=uxKMWFBgwA6IbcWijln9Q3Jh6WWkJjxrekF5A5aa7BesE72MCygSIRC4VTJZPxbT6PkCgZ6Ua4StHZe8R7FzANDUtX0By4WFljKwdoUTlilUP0RW3G3nbz2SYeOIzOtA5P4jKvlbUA6QTVX+PslfvHMKQvp82flVBH0HiheV41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767594268; c=relaxed/simple;
	bh=JU0u5tY1o3GDIe8fblC9Bc9QKFSobkvHwA/nCliet5M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lWeKZinkEfcfNnys0fFRZqU4TS1vqJT62dnsJTwzje8Pdyb6ive1WiyJrn8VEwv7sVu0ynRi9eMypdf/GGpfGJsFLB5/igLsV8ztnvDVap5Dmcjpm+iMUjeLe7IuxurTPLYSH2FjZ/dXj9CnUlXJdSq6FWnlJFSOXBosRfcko5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kVp2IGW+; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=279Ad9T5c2/1r/JJ0GDdNhAiIajr2H/Njlx3H6m6YR0=;
	b=kVp2IGW+FASyTawr8rjVO8zNpAHi2iH1CTfJuv76P8uEPN1hD+f/1TUtMVaIC3NbeolXJXL6b
	p5qRbrVzuJh3go5BVdgcjiBabkCDiOLzc2tLTDE3xcUfzfTNDXO/HTzm0mhLbu7VMaaXM1gBJnv
	3BP7QXTVbyJG6NogiKsWv5U=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dl42H6SfCz1T4GZ;
	Mon,  5 Jan 2026 14:21:43 +0800 (CST)
Received: from dggpemf100004.china.huawei.com (unknown [7.185.36.110])
	by mail.maildlp.com (Postfix) with ESMTPS id 9478E40539;
	Mon,  5 Jan 2026 14:24:22 +0800 (CST)
Received: from huawei.com (10.175.121.217) by dggpemf100004.china.huawei.com
 (7.185.36.110) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 5 Jan
 2026 14:24:21 +0800
From: caojiaqiang 00593155 <caojiaqiang@huawei.com>
To: <gregkh@linuxfoundation.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<shuah@kernel.org>
CC: <stable@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dsahern@kernel.org>
Subject: [5.15.y BACKPORT] selftests: net: test_vxlan_under_vrf: fix HV connectivity test
Date: Mon, 5 Jan 2026 14:38:05 +0800
Message-ID: <20260105063805.17044-1-caojiaqiang@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf100004.china.huawei.com (7.185.36.110)

From: Andrea Righi <andrea.righi@canonical.com>

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


