Return-Path: <linux-kselftest+bounces-20537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8919AE29A
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:32:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3241C215DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EF51CACFD;
	Thu, 24 Oct 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y3fMsBd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892971C8FC6;
	Thu, 24 Oct 2024 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765897; cv=none; b=HKdDNsvtCJcBoBNbyXU3ZnunIGdX88vnTBACIxLMzMRylgnviz2I3BfUcRXw2Fjt+aqB2Yw+eVPgjrij6LgvUoLe/BUNCEHutYzNL/zHd3GfUOJnzr6DuGaRwTFKjH5o1xD+eK1QdAGQvvC/665cDNDmhgmwCX2hEfXHVL6NsBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765897; c=relaxed/simple;
	bh=gbDuprkSDRO1ZVxjUu34hDqDYjqd4wbx47kCz6jjL28=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elIjZFNPZ7HoUVpW/mxELR8kO93CAdsdif+bxBvQjiMGosBt9gXobfsC3VbSw2pUrA3Op6ibFDkELmSrwb0l4Qd4J2w5SIQx4VfFZxOGD/7uR8AO27AsmNgoT9XD+3+Wmv0haQ58wxCLe1AjwuuGWWhY25Qf5xDtfHN7ifTPUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y3fMsBd6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49OAV6i9054005;
	Thu, 24 Oct 2024 05:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729765866;
	bh=NR17OZSW7xbWDhOwoXB2afulJaLK/GIoceGzWejwggk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=y3fMsBd6DPWrecQ6AqVWprha/GtdeiWLSxY2tL9oOUwiUKgPo1YLc64iZznxpvBW/
	 rxo00XozE3k1yP7gtHRuyg3tRu9ec+d8eEQjM4PJJSr2Exdnjlbfy4w9HtsyAdfeVK
	 9SB0PTbd41hNUkmCYLOavOsNaHVRnuUUTfOfwWTo=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49OAV6HQ023086
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 24 Oct 2024 05:31:06 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Oct 2024 05:31:05 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Oct 2024 05:31:05 -0500
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49OAV5BS000717;
	Thu, 24 Oct 2024 05:31:05 -0500
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 49OAV4g6024608;
	Thu, 24 Oct 2024 05:31:05 -0500
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <dan.carpenter@linaro.org>,
        <jiri@resnulli.us>, <n.zhandarovich@fintech.ru>,
        <aleksander.lobakin@intel.com>, <lukma@denx.de>, <horms@kernel.org>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
        <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>,
        <m-malladi@ti.com>
Subject: [PATCH net-next v2 4/4] selftests: hsr: Add test for VLAN
Date: Thu, 24 Oct 2024 16:00:56 +0530
Message-ID: <20241024103056.3201071-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241024103056.3201071-1-danishanwar@ti.com>
References: <20241024103056.3201071-1-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add test for VLAN ping for HSR. The test adds vlan interfaces to the hsr
interface and then verifies if ping to them works.

Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
---
 tools/testing/selftests/net/hsr/config      |  1 +
 tools/testing/selftests/net/hsr/hsr_ping.sh | 63 ++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/hsr/config b/tools/testing/selftests/net/hsr/config
index 241542441c51..555a868743f0 100644
--- a/tools/testing/selftests/net/hsr/config
+++ b/tools/testing/selftests/net/hsr/config
@@ -3,3 +3,4 @@ CONFIG_NET_SCH_NETEM=m
 CONFIG_HSR=y
 CONFIG_VETH=y
 CONFIG_BRIDGE=y
+CONFIG_VLAN_8021Q=m
diff --git a/tools/testing/selftests/net/hsr/hsr_ping.sh b/tools/testing/selftests/net/hsr/hsr_ping.sh
index f5d207fc770a..fb7c7d3fb6c7 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -2,13 +2,15 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ipv6=true
+vlan=false
 
 source ./hsr_common.sh
 
-optstring="h4"
+optstring="h4v"
 usage() {
 	echo "Usage: $0 [OPTION]"
 	echo -e "\t-4: IPv4 only: disable IPv6 tests (default: test both IPv4 and IPv6)"
+	echo -e "\t-v: Enable VLAN tests"
 }
 
 while getopts "$optstring" option;do
@@ -20,6 +22,9 @@ while getopts "$optstring" option;do
 	"4")
 		ipv6=false
 		;;
+	"v")
+		vlan=true
+		;;
 	"?")
 		usage $0
 		exit 1
@@ -175,6 +180,50 @@ setup_hsr_interfaces()
 	ip -net "$ns3" link set hsr3 up
 }
 
+setup_vlan_interfaces() {
+	ip link add link hsr1 name hsr1.2 type vlan id 2
+	ip link add link hsr1 name hsr1.3 type vlan id 3
+	ip link add link hsr1 name hsr1.4 type vlan id 4
+	ip link add link hsr1 name hsr1.5 type vlan id 5
+
+	ip link add link hsr2 name hsr2.2 type vlan id 2
+	ip link add link hsr2 name hsr2.3 type vlan id 3
+	ip link add link hsr2 name hsr2.4 type vlan id 4
+	ip link add link hsr2 name hsr2.5 type vlan id 5
+
+	ip link add link hsr3 name hsr3.2 type vlan id 2
+	ip link add link hsr3 name hsr3.3 type vlan id 3
+	ip link add link hsr3 name hsr3.4 type vlan id 4
+	ip link add link hsr3 name hsr3.5 type vlan id 5
+
+	ip -net "$ns1" addr add 100.64.2.1/24 dev hsr1.2
+	ip -net "$ns1" addr add 100.64.3.1/24 dev hsr1.3
+	ip -net "$ns1" addr add 100.64.4.1/24 dev hsr1.4
+	ip -net "$ns1" addr add 100.64.5.1/24 dev hsr1.5
+
+	ip -net "$ns2" addr add 100.64.2.2/24 dev hsr2.2
+	ip -net "$ns2" addr add 100.64.3.2/24 dev hsr2.3
+	ip -net "$ns2" addr add 100.64.4.2/24 dev hsr2.4
+	ip -net "$ns2" addr add 100.64.5.2/24 dev hsr2.5
+
+	ip -net "$ns3" addr add 100.64.2.3/24 dev hsr3.2
+	ip -net "$ns3" addr add 100.64.3.3/24 dev hsr3.3
+	ip -net "$ns3" addr add 100.64.4.3/24 dev hsr3.4
+	ip -net "$ns3" addr add 100.64.5.3/24 dev hsr3.5
+}
+
+hsr_vlan_ping() {
+	do_ping "$ns2" 100.64.2.1
+	do_ping "$ns2" 100.64.3.1
+	do_ping "$ns2" 100.64.4.1
+	do_ping "$ns2" 100.64.5.1
+
+	do_ping "$ns2" 100.64.2.3
+	do_ping "$ns2" 100.64.3.3
+	do_ping "$ns2" 100.64.4.3
+	do_ping "$ns2" 100.64.5.3
+}
+
 check_prerequisites
 setup_ns ns1 ns2 ns3
 
@@ -183,9 +232,21 @@ trap cleanup_all_ns EXIT
 setup_hsr_interfaces 0
 do_complete_ping_test
 
+# Run VLAN Test
+if $vlan; then
+	setup_vlan_interfaces
+	hsr_vlan_ping
+fi
+
 setup_ns ns1 ns2 ns3
 
 setup_hsr_interfaces 1
 do_complete_ping_test
 
+# Run VLAN Test
+if $vlan; then
+	setup_vlan_interfaces
+	hsr_vlan_ping
+fi
+
 exit $ret
-- 
2.34.1


