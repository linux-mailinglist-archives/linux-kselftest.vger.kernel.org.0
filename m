Return-Path: <linux-kselftest+bounces-23521-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4305E9F6C32
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 613097A63D3
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6CF1FA140;
	Wed, 18 Dec 2024 17:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oaxmFbcN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65EE1F892F;
	Wed, 18 Dec 2024 17:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734542263; cv=fail; b=a5vjbMr5WUD+Ui88FwC+YLgtxdfIb+1jdgxgqxyHGXnPMIXmWpMOuOZ8ZMMy9kKFuQV372Mp0E6YoGEVJf3o52Dt9gU9oHh48N5ASADRjlRfV6M45AgkUXEwG/IwP+amGrvX5Qksn3FphuV5QQqeMQuvlV95xc5A0Q2P8NHhTvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734542263; c=relaxed/simple;
	bh=Vwp3lUHHvujSoWb4POXPbrUUbEzwqbqwDRKe4J4pOFc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGhOcxbq0BcvJmpRBGsJlqH+obO6yrqZzisYkAInYfP5k2Rahx72Oh5oyqqodzJYJ7EaexFCg5YXgPqM9ibY3BZpd3FljvkMzOyH0dMK6U6qbicFWZZ8kGUkKkPuaA/RaN1fsJLBRcdOR4PYYGZm/E4jCb/xJQx66sowkgKXshc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oaxmFbcN; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvD4TINiqIkhdMx/LvULLEap7DldBkqa/Vv2rLEKCobdXoOWCH1FEiAiMSbXU7KtEfldSvXnb513MBvIFwU8QMEQJALxVsjly2Ftr0F6nNrm3/4vE4C54QORt3pr9N1OpQBNapm/VCOkciASJ6bEZ5/dTqA5DPwBBgsOlMhyoncVxKJqhAswzx7701KIvQ/k63DKAOHp+0G/KUVVo2CfAywodTOEeNLwIwfSTuKqnbj83XA0UD94q6b+VZMenzk7zrnCmCbdiZFLwCly6OIHPZBNoplDL1S7AhuMTmhglCDaPq531g++8M1STkCvW90QWUYb3MQv+ohqO7SQljjziQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nH+pZ5P++boFENwS3s1empsfhYQbMoop11/VBUzQeh4=;
 b=N/LekQaqrsErPDuYndopAv4MaqEn+DunUIYin9hHjL4h2NAjjcTn8/8IReBWmoU0AlpfLJmOgo0VJoXGdi23JuyFC6AR+Ho1CXmxby4E41sVD6Owcnq4DViQaGUa5+DsqgOSLvb58BQHR5rolojDdRPjzT7xcWXNf9zqPH3ovi7K0hHrxhS7yikUD/W+fYslTrjhBZjTHjJKFDVHj5aiIjLCIyxcG80m34BPwDozqGOJUoENc8q93OSeVloSkwmrbklUsB2Z++gIjAL3yXDGe3KB+qN4QavoKQACwUc6a5aPyL9asU4zraqUo6lZpfoCaWPh0RLrTSNjijvx6kBSaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nH+pZ5P++boFENwS3s1empsfhYQbMoop11/VBUzQeh4=;
 b=oaxmFbcNBpDCHTAL75kdi21arvtxZxTI4KYvtL1mSUxNQ2X7tNbJcIUB/Csg5MorocgC/DPz7xYchnrZJBR67N0M7BTMk4MxUIdkKPBl2yhY/uJ9JEMI5pUYilJ0mez237AZbiGinLDyJKSlIimWkTWTkSILoOhl65vCZH77C5KN+0lo32wDpmW/9+q4JgskNwl8+U6vflF7HiNp8Ny65lkFFilTClNtl5v2kHnzZ8Au4Hj8OirvYnURRsssoIgd9BcF4EKCr41zz9jzUYaDX33uCNrhSaOOdfft/ZFjGcwNjmCnrnYj7MCIJdbpqoq+lTcpoUzW6qXNkD/3PokrFQ==
Received: from BL1PR13CA0013.namprd13.prod.outlook.com (2603:10b6:208:256::18)
 by IA0PR12MB8976.namprd12.prod.outlook.com (2603:10b6:208:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:17:37 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:256:cafe::51) by BL1PR13CA0013.outlook.office365.com
 (2603:10b6:208:256::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8272.10 via Frontend Transport; Wed,
 18 Dec 2024 17:17:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8293.6 via Frontend Transport; Wed, 18 Dec 2024 17:17:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:17:16 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 09:17:09 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, "Nikolay
 Aleksandrov" <razor@blackwall.org>, <bridge@lists.linux.dev>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 4/4] selftests: net: Add a VLAN bridge binding selftest
Date: Wed, 18 Dec 2024 18:15:59 +0100
Message-ID: <baf7244fd1fe223a6d93e027584fa9f99dee982c.1734540770.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734540770.git.petrm@nvidia.com>
References: <cover.1734540770.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|IA0PR12MB8976:EE_
X-MS-Office365-Filtering-Correlation-Id: f4803180-343c-494d-102f-08dd1f87de8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jb7IjCMjKm96QISqDLjrhTkznIW202x+vbnKIqY0i3N/xJFfcYw59v6EP8j?=
 =?us-ascii?Q?GM9Mq9ea1jVyYI4T2YReOCpN3e1pWiVhyklfSzb44xgXhwbsryZUnvoqLNrM?=
 =?us-ascii?Q?YvNnzlmnoJva2G5cKvUd9D9zs+ORx1jwgEP1WNXEhL6c+dw5OBS4fNxg/OmJ?=
 =?us-ascii?Q?+bQ4XB4Bkrzjj2JiB5VFe23oO/eLTrbgJ24XRhZzcyuoZRPmnzY+EixDfsrB?=
 =?us-ascii?Q?jjzJlzTE15cojNURZ7379nGUIPhARjB25Er6QoIzDYFOTnGcyUMhDlswofJ6?=
 =?us-ascii?Q?673qVhsfED0rJqKAyOYsc89WFVzN9b+q74f1tx2fWMBw4bIHVwQBagBNf9aU?=
 =?us-ascii?Q?66BMUm1+s77Pgk4o9Dfl5xcI9ineH14UgabNJeMnyM4RjZ9F7QxAseSqRDQx?=
 =?us-ascii?Q?B1+4juu+hEQgjuTMk6s+7gEmZmK3Mto6+qpFXQUEQIdHL7Pc3waBnknxewjK?=
 =?us-ascii?Q?xCAkWRaUcsILUCgsQA3l4CP4oPqGOEBTRkEdI+1dJzi/LNUYygfQoLcnZV1f?=
 =?us-ascii?Q?hjxiwmKEs7skhrrvMINK9Ef+2z2+nYJOZDUqdn2X2L/esJrtFBJbWSInEDuU?=
 =?us-ascii?Q?4CTwh7PGCu6INC8ZVimo1Z1gNg8sm07t0cGsn6uRwtCyzld9Bc4Lc8zLIl3v?=
 =?us-ascii?Q?DqQ3A4N6ScWAF9mY6zIPK/S6h34embyAgqb3h9sAdA7P8TdzYxNOoceupGzt?=
 =?us-ascii?Q?hx+oDaCD2d44QKNcL5HTlam/y8nu+UNGdYiF6Xl2ja9OtEKC24VaXfx2UMTV?=
 =?us-ascii?Q?WqmaGwgwzZ8HEozOerAnNdMABlGWNCmixxaAHo+W31siVOgKiido/cWZlFiJ?=
 =?us-ascii?Q?5E7TLZi5PWykrgUgoT/Z1VLg/RgSBy6EmuQXWSMyAApaYbbEE/ML97iYY5Tf?=
 =?us-ascii?Q?a4um0O93IbAdEMZo8phDJdH2TcZsVV0w56RmJ/qSmKZIdHsx/ZdhJqo3JWYg?=
 =?us-ascii?Q?MaTdeXBj4RZRfm5/6Q9li4+HGVqiDYJ2MfAdOObTr/Kpj7wn0jvb11ZEcRw6?=
 =?us-ascii?Q?a4ysjBdt0oqhnttEggwSN7izE8MTT+9Ra3aFH/eG5gEwIxB7N0HN8mkSD+cp?=
 =?us-ascii?Q?Im39l0Z1lD18k8mHQB03p+mRlQpZOj6OozK4FtaM04je4WXJh6nuFBzirZ2m?=
 =?us-ascii?Q?M8PU6/PVYdk4ppdl1k55RpqkzEclNS/9/iR7KrT5ISHxJ0k8d8Ty3i4LOVUB?=
 =?us-ascii?Q?zi1VZ3ZsUBlF9ubd9goAz3SMhs0RFj6mX1gJ6rjS2f/SRQe2rWTv/VV0KVeR?=
 =?us-ascii?Q?OpynwEI4XsKeZqdxE6YhBAb5Sx8RJ/AgcZK5ZzYXOY60Qq5vR4HsdzTky9/+?=
 =?us-ascii?Q?WrLx/WFcESeEGLsI9Snpm8TwoQIRCUDI8vwYDxOxI5qRk7Vw0RLNqAyWohJh?=
 =?us-ascii?Q?g0sZmyz8lmhRDLYcPXKcUWz1IgPYl5vIOgHQbxI+exEMUq8Eju5a1YdjnbD3?=
 =?us-ascii?Q?s03jiQak9KHlXPOREjSosL7gaq9nzQoaOAg22C+Mb+hHNCELgr/GZAHrCOC3?=
 =?us-ascii?Q?A9fLjdAPOHz3/Ps=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:17:36.8927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4803180-343c-494d-102f-08dd1f87de8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8976

Add a test that exercises bridge binding.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

---
 tools/testing/selftests/net/Makefile          |   1 +
 .../selftests/net/vlan_bridge_binding.sh      | 256 ++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100755 tools/testing/selftests/net/vlan_bridge_binding.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index f09bd96cc978..73ee88d6b043 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -96,6 +96,7 @@ TEST_PROGS += test_bridge_backup_port.sh
 TEST_PROGS += fdb_flush.sh fdb_notify.sh
 TEST_PROGS += fq_band_pktlimit.sh
 TEST_PROGS += vlan_hw_filter.sh
+TEST_PROGS += vlan_bridge_binding.sh
 TEST_PROGS += bpf_offload.py
 TEST_PROGS += ipv6_route_update_soft_lockup.sh
 TEST_PROGS += busy_poll_test.sh
diff --git a/tools/testing/selftests/net/vlan_bridge_binding.sh b/tools/testing/selftests/net/vlan_bridge_binding.sh
new file mode 100755
index 000000000000..e7cb8c678bde
--- /dev/null
+++ b/tools/testing/selftests/net/vlan_bridge_binding.sh
@@ -0,0 +1,256 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+ALL_TESTS="
+	test_binding_on
+	test_binding_off
+	test_binding_toggle_on
+	test_binding_toggle_off
+	test_binding_toggle_on_when_upper_down
+	test_binding_toggle_off_when_upper_down
+	test_binding_toggle_on_when_lower_down
+	test_binding_toggle_off_when_lower_down
+"
+
+setup_prepare()
+{
+	local port
+
+	ip_link_add br up type bridge vlan_filtering 1
+
+	for port in d1 d2 d3; do
+		ip_link_add $port type veth peer name r$port
+		ip_link_set_up $port
+		ip_link_set_up r$port
+		ip_link_set_master $port br
+	done
+
+	bridge_vlan_add vid 11 dev br self
+	bridge_vlan_add vid 11 dev d1 master
+
+	bridge_vlan_add vid 12 dev br self
+	bridge_vlan_add vid 12 dev d2 master
+
+	bridge_vlan_add vid 13 dev br self
+	bridge_vlan_add vid 13 dev d1 master
+	bridge_vlan_add vid 13 dev d2 master
+
+	bridge_vlan_add vid 14 dev br self
+	bridge_vlan_add vid 14 dev d1 master
+	bridge_vlan_add vid 14 dev d2 master
+	bridge_vlan_add vid 14 dev d3 master
+}
+
+operstate_is()
+{
+	local dev=$1; shift
+	local expect=$1; shift
+
+	local operstate=$(ip -j link show $dev | jq -r .[].operstate)
+	if [[ $operstate == UP ]]; then
+		operstate=1
+	elif [[ $operstate == DOWN || $operstate == LOWERLAYERDOWN ]]; then
+		operstate=0
+	fi
+	echo -n $operstate
+	[[ $operstate == $expect ]]
+}
+
+check_operstate()
+{
+	local dev=$1; shift
+	local expect=$1; shift
+	local operstate
+
+	operstate=$(busywait 1000 \
+			operstate_is "$dev" "$expect")
+	check_err $? "Got operstate of $operstate, expected $expect"
+}
+
+add_one_vlan()
+{
+	local link=$1; shift
+	local id=$1; shift
+
+	ip_link_add $link.$id link $link type vlan id $id "$@"
+}
+
+add_vlans()
+{
+	add_one_vlan br 11 "$@"
+	add_one_vlan br 12 "$@"
+	add_one_vlan br 13 "$@"
+	add_one_vlan br 14 "$@"
+}
+
+set_vlans()
+{
+	ip link set dev br.11 "$@"
+	ip link set dev br.12 "$@"
+	ip link set dev br.13 "$@"
+	ip link set dev br.14 "$@"
+}
+
+down_netdevs()
+{
+	local dev
+
+	for dev in "$@"; do
+		ip_link_set_down $dev
+	done
+}
+
+check_operstates()
+{
+	local opst_11=$1; shift
+	local opst_12=$1; shift
+	local opst_13=$1; shift
+	local opst_14=$1; shift
+
+	check_operstate br.11 $opst_11
+	check_operstate br.12 $opst_12
+	check_operstate br.13 $opst_13
+	check_operstate br.14 $opst_14
+}
+
+do_test_binding()
+{
+	local inject=$1; shift
+	local what=$1; shift
+	local opsts_d1=$1; shift
+	local opsts_d2=$1; shift
+	local opsts_d12=$1; shift
+	local opsts_d123=$1; shift
+
+	RET=0
+
+	defer_scope_push
+		down_netdevs d1
+		$inject
+		check_operstates $opsts_d1
+	defer_scope_pop
+
+	defer_scope_push
+		down_netdevs d2
+		$inject
+		check_operstates $opsts_d2
+	defer_scope_pop
+
+	defer_scope_push
+		down_netdevs d1 d2
+		$inject
+		check_operstates $opsts_d12
+	defer_scope_pop
+
+	defer_scope_push
+		down_netdevs d1 d2 d3
+		$inject
+		check_operstates $opsts_d123
+	defer_scope_pop
+
+	log_test "Test bridge_binding $what"
+}
+
+do_test_binding_on()
+{
+	local inject=$1; shift
+	local what=$1; shift
+
+	do_test_binding "$inject" "$what"	\
+			"0 1 1 1"		\
+			"1 0 1 1"		\
+			"0 0 0 1"		\
+			"0 0 0 0"
+}
+
+do_test_binding_off()
+{
+	local inject=$1; shift
+	local what=$1; shift
+
+	do_test_binding "$inject" "$what"	\
+			"1 1 1 1"		\
+			"1 1 1 1"		\
+			"1 1 1 1"		\
+			"0 0 0 0"
+}
+
+test_binding_on()
+{
+	add_vlans bridge_binding on
+	set_vlans up
+	do_test_binding_on : "on"
+}
+
+test_binding_off()
+{
+	add_vlans bridge_binding off
+	set_vlans up
+	do_test_binding_off : "off"
+}
+
+test_binding_toggle_on()
+{
+	add_vlans bridge_binding off
+	set_vlans up
+	set_vlans type vlan bridge_binding on
+	do_test_binding_on : "off->on"
+}
+
+test_binding_toggle_off()
+{
+	add_vlans bridge_binding on
+	set_vlans up
+	set_vlans type vlan bridge_binding off
+	do_test_binding_off : "on->off"
+}
+
+dfr_set_binding_on()
+{
+	set_vlans type vlan bridge_binding on
+	defer set_vlans type vlan bridge_binding off
+}
+
+dfr_set_binding_off()
+{
+	set_vlans type vlan bridge_binding off
+	defer set_vlans type vlan bridge_binding on
+}
+
+test_binding_toggle_on_when_lower_down()
+{
+	add_vlans bridge_binding off
+	set_vlans up
+	do_test_binding_on dfr_set_binding_on "off->on when lower down"
+}
+
+test_binding_toggle_off_when_lower_down()
+{
+	add_vlans bridge_binding on
+	set_vlans up
+	do_test_binding_off dfr_set_binding_off "on->off when lower down"
+}
+
+test_binding_toggle_on_when_upper_down()
+{
+	add_vlans bridge_binding off
+	set_vlans type vlan bridge_binding on
+	set_vlans up
+	do_test_binding_on : "off->on when upper down"
+}
+
+test_binding_toggle_off_when_upper_down()
+{
+	add_vlans bridge_binding on
+	set_vlans type vlan bridge_binding off
+	set_vlans up
+	do_test_binding_off : "on->off when upper down"
+}
+
+trap defer_scopes_cleanup EXIT
+setup_prepare
+tests_run
+
+exit $EXIT_STATUS
-- 
2.47.0


