Return-Path: <linux-kselftest+bounces-21516-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A609BE232
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 10:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DA99284776
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 09:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3D1DB37B;
	Wed,  6 Nov 2024 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HnfGmM5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97DF1DA112;
	Wed,  6 Nov 2024 09:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730884672; cv=none; b=HLtvF/X/iEkq6qJbN8yWK/w8az293jqxBgstg30IUajlsytMzXqTdHkbdUbjININax/jabUS117/PGyW0o2Ihygbpvv0t4IBKgUMS+PJ7CP9cngkvEOEiVTAfGY3bm9AmtWARLFQklQMBlmc/dUUksI1fhyq7MeQiHFQrrDT1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730884672; c=relaxed/simple;
	bh=PU4WfgUM1ro3cadfp0A9doBchIBBYfkaALVPJ8YnCxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2+VIS3VzJ22ATNnmmadPGLoSl+TTdbCP+gbaoftJxdNi0OJW2vabhqgeCilKFq0aPF8B7j3YSqt9VmSOqoiaNh4BfO+83LYCcKOEiceHsZQrSSXvaQdrOEOjzUsvcBWTK/xY5cDLnXEExJvwpROh5Z5UaHBQaqg4oJuExLbE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HnfGmM5u; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HLWm035703;
	Wed, 6 Nov 2024 03:17:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730884641;
	bh=rLlcShJe5zacwcN83f3SDxaOHpg6xeUc4ekG3drQ/gc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=HnfGmM5uLcyLE7yRiZT/T9JMzo+mBAJ+hw9kgvSr2XhOEJenGvyMVhZDSgCKdFNoq
	 FHNTmZb+OGK49ZB/VgvYoETi/Yu9wa77n7uA9+DM6w0eUMBSoIHqCDhHtC/1gnknpB
	 +Ec5ab24s+nxA01I/usmX18Xa+ZmWXIsuSNjHi1g=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A69HLLU116896
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 6 Nov 2024 03:17:21 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 6
 Nov 2024 03:17:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 6 Nov 2024 03:17:20 -0600
Received: from fllv0122.itg.ti.com (fllv0122.itg.ti.com [10.247.120.72])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A69HKZq066912;
	Wed, 6 Nov 2024 03:17:20 -0600
Received: from localhost (danish-tpc.dhcp.ti.com [10.24.69.25])
	by fllv0122.itg.ti.com (8.14.7/8.14.7) with ESMTP id 4A69HJ9f020797;
	Wed, 6 Nov 2024 03:17:20 -0600
From: MD Danish Anwar <danishanwar@ti.com>
To: <geliang@kernel.org>, <liuhangbin@gmail.com>, <jiri@resnulli.us>,
        <w-kwok2@ti.com>, <aleksander.lobakin@intel.com>, <lukma@denx.de>,
        <jan.kiszka@siemens.com>, <diogo.ivo@siemens.com>, <shuah@kernel.org>,
        <horms@kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
        <edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>
CC: <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
Subject: [PATCH net-next v3 4/4] selftests: hsr: Add test for VLAN
Date: Wed, 6 Nov 2024 14:47:10 +0530
Message-ID: <20241106091710.3308519-5-danishanwar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241106091710.3308519-1-danishanwar@ti.com>
References: <20241106091710.3308519-1-danishanwar@ti.com>
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
 tools/testing/selftests/net/hsr/hsr_ping.sh | 98 +++++++++++++++++++++
 2 files changed, 99 insertions(+)

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
index f5d207fc770a..5a65f4f836be 100755
--- a/tools/testing/selftests/net/hsr/hsr_ping.sh
+++ b/tools/testing/selftests/net/hsr/hsr_ping.sh
@@ -175,6 +175,100 @@ setup_hsr_interfaces()
 	ip -net "$ns3" link set hsr3 up
 }
 
+setup_vlan_interfaces() {
+	ip -net "$ns1" link add link hsr1 name hsr1.2 type vlan id 2
+	ip -net "$ns1" link add link hsr1 name hsr1.3 type vlan id 3
+	ip -net "$ns1" link add link hsr1 name hsr1.4 type vlan id 4
+	ip -net "$ns1" link add link hsr1 name hsr1.5 type vlan id 5
+
+	ip -net "$ns2" link add link hsr2 name hsr2.2 type vlan id 2
+	ip -net "$ns2" link add link hsr2 name hsr2.3 type vlan id 3
+	ip -net "$ns2" link add link hsr2 name hsr2.4 type vlan id 4
+	ip -net "$ns2" link add link hsr2 name hsr2.5 type vlan id 5
+
+	ip -net "$ns3" link add link hsr3 name hsr3.2 type vlan id 2
+	ip -net "$ns3" link add link hsr3 name hsr3.3 type vlan id 3
+	ip -net "$ns3" link add link hsr3 name hsr3.4 type vlan id 4
+	ip -net "$ns3" link add link hsr3 name hsr3.5 type vlan id 5
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
+
+	ip -net "$ns1" link set dev hsr1.2 up
+	ip -net "$ns1" link set dev hsr1.3 up
+	ip -net "$ns1" link set dev hsr1.4 up
+	ip -net "$ns1" link set dev hsr1.5 up
+
+	ip -net "$ns2" link set dev hsr2.2 up
+	ip -net "$ns2" link set dev hsr2.3 up
+	ip -net "$ns2" link set dev hsr2.4 up
+	ip -net "$ns2" link set dev hsr2.5 up
+
+	ip -net "$ns3" link set dev hsr3.2 up
+	ip -net "$ns3" link set dev hsr3.3 up
+	ip -net "$ns3" link set dev hsr3.4 up
+	ip -net "$ns3" link set dev hsr3.5 up
+
+}
+
+hsr_vlan_ping() {
+	do_ping "$ns1" 100.64.2.2
+	do_ping "$ns1" 100.64.3.2
+	do_ping "$ns1" 100.64.4.2
+	do_ping "$ns1" 100.64.5.2
+
+	do_ping "$ns1" 100.64.2.3
+	do_ping "$ns1" 100.64.3.3
+	do_ping "$ns1" 100.64.4.3
+	do_ping "$ns1" 100.64.5.3
+
+	do_ping "$ns2" 100.64.2.1
+	do_ping "$ns2" 100.64.3.1
+	do_ping "$ns2" 100.64.4.1
+	do_ping "$ns2" 100.64.5.1
+
+	do_ping "$ns2" 100.64.2.3
+	do_ping "$ns2" 100.64.3.3
+	do_ping "$ns2" 100.64.4.3
+	do_ping "$ns2" 100.64.5.3
+
+	do_ping "$ns3" 100.64.2.1
+	do_ping "$ns3" 100.64.3.1
+	do_ping "$ns3" 100.64.4.1
+	do_ping "$ns3" 100.64.5.1
+
+	do_ping "$ns3" 100.64.2.2
+	do_ping "$ns3" 100.64.3.2
+	do_ping "$ns3" 100.64.4.2
+	do_ping "$ns3" 100.64.5.2
+}
+
+run_vlan_tests() {
+	vlan_challenged_hsr1=$(ip net exec "$ns1" ethtool -k hsr1 | grep "vlan-challenged" | awk '{print $2}')
+	vlan_challenged_hsr2=$(ip net exec "$ns2" ethtool -k hsr2 | grep "vlan-challenged" | awk '{print $2}')
+	vlan_challenged_hsr3=$(ip net exec "$ns3" ethtool -k hsr3 | grep "vlan-challenged" | awk '{print $2}')
+
+	if [[ "$vlan_challenged_hsr1" = "off" || "$vlan_challenged_hsr2" = "off" || "$vlan_challenged_hsr3" = "off" ]]; then
+		echo "INFO: Running VLAN tests"
+		setup_vlan_interfaces
+		hsr_vlan_ping
+	else
+		echo "INFO: Not Running VLAN tests as the device does not support VLAN"
+	fi
+}
+
 check_prerequisites
 setup_ns ns1 ns2 ns3
 
@@ -183,9 +277,13 @@ trap cleanup_all_ns EXIT
 setup_hsr_interfaces 0
 do_complete_ping_test
 
+run_vlan_tests
+
 setup_ns ns1 ns2 ns3
 
 setup_hsr_interfaces 1
 do_complete_ping_test
 
+run_vlan_tests
+
 exit $ret
-- 
2.34.1


