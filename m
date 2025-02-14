Return-Path: <linux-kselftest+bounces-26667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C5A362E0
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 17:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B9E3A9CE3
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Feb 2025 16:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F0C2676FD;
	Fri, 14 Feb 2025 16:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eVxhKRPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048CC2676CF;
	Fri, 14 Feb 2025 16:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549982; cv=fail; b=rCoxkC3kBe7bJOdzo89n9Y/RuFMncjMrykwffNTobnXVFwhS0FJ570dYmku+XVSOHhVlPggQmUOFcymLhL/SgGKQsQ03ITDDzisqt1sNt//YtUfigY4dyJqj2ZW6+1v8sQpO+VteFzPpR5/Xzwtdol9TWPfenBDDHHGemFHMm2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549982; c=relaxed/simple;
	bh=+wbcbyXnXvn1PMP9ymid+vdhhzJIeOlZcycTthupwoU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ncvou/nj1GsnM1U2+rMW7xNXpopLhzABUVxwdY+nFGotDaFbiAhGThDq9Kp0WfRcA3eOvb18x97udSoAlnnU3nEiMdamEOGRowjqDnNePzop7wUDfOGhy6+ZwbGzXdNrzrRbsrzRYPI1jzM6Aw/lq9/ZvTKXkp4rYbbtavPp++s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eVxhKRPO; arc=fail smtp.client-ip=40.107.223.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JhG0gX1/3moI3gohl6Gm02ZvqcXrwO8XEPVDy2TSDrozb8IdiIESB+RZlG2FJeZtxM6xQ7MjzFYcfzfIi2c2L9wDt2Gw3YXjQ50qwjJ+V9zInaE6zAkn7Y61l+932yIVEBbRuz4LGRBvwT9Zj52tdGjCl5itMlHNTjz9wjWQJwoZ+6ow6FriSTUlQdOcaadeRuc5soC/jtDviD+Ep75pE39Kv76890ZfWjNLkuXAIXDVFQ50fiw3WeQxBVC56xah3cTl3H7FelmIc3PVsKqq9EJ2tEgq+H60ifx0f429I25O04r5T0W04HTJw3FG546MyNxqgeoZ1gAHSfj93rpihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1mKSnH03/+WnGU1/2SdKtQRHTDHaRyS3u5W4LHT2oMU=;
 b=orNe4leUZlbqt7MNC6FlMfClrh7PnWS1mOTIBjcoT+55qU1vGqx30T3ghzRuHe6rYt4v/0FRWSA4w9E9YPt3DxMnpyEmnUIpGOi+sxsA7q8dEhMNGzMWacs4YGnjIfxBFCQGiSbRvb7sBY0cFkpupT+GwerpTM0PjuNQa03U6HaNCnAURqHq0kn1wNQGthu3yxIzLnvswXGBbEBBc0G0ndU29WpceBSfdKiZYkeXsT0PthHk4R/EP7/zbKdx1PbxCfF/1mcEssovjC6BtQw6aJAKyOJKMaqKvaCniK2eJ/+D9DeOcjVSEE2fCVD3t3UHfwc4dwxfUTkmVmwV2V1q0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1mKSnH03/+WnGU1/2SdKtQRHTDHaRyS3u5W4LHT2oMU=;
 b=eVxhKRPOLQOipJK9y1SVgupvcjGFk06UYiSlRr9Vd7P4LyzSLIclU5GfFSED0ZTYdXb2HiGH3DXbY+Ouf9ZFgncpEEx8oTK6cZcWb7y/V42VrFflCIDZvaG1ZB2/xV5wGOP5x6hlMAJZfAqoS122jh5lL/kQkkt7T01n+xXfCxGYv1dhuCUhmx5EINg7n6aa4gqvL+alk+4KZ2/+WD5NhF8LplQItjUc6wjqcPKTgtPIzN00zcO5x5KNMtnIIDJhfXc+pOzd6ih/yEM4mdSssKdzbqAK5P+KzWD7C2akGfZajKZ0VEmObDkCypgDV6QK9TCNpV7fUrfOWaOpN9nzsg==
Received: from MN0PR04CA0021.namprd04.prod.outlook.com (2603:10b6:208:52d::32)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.17; Fri, 14 Feb
 2025 16:19:36 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::49) by MN0PR04CA0021.outlook.office365.com
 (2603:10b6:208:52d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.16 via Frontend Transport; Fri,
 14 Feb 2025 16:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.10 via Frontend Transport; Fri, 14 Feb 2025 16:19:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Feb
 2025 08:19:20 -0800
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 14 Feb
 2025 08:19:15 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	<netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v2 5/5] selftests: test_vxlan_fdb_changelink: Add a test for MC remote change
Date: Fri, 14 Feb 2025 17:18:24 +0100
Message-ID: <dcaf5e786362a5e39297f93bff480482b78ec393.1739548836.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739548836.git.petrm@nvidia.com>
References: <cover.1739548836.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 53626a83-1c5f-4767-10e9-08dd4d135f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QtuTrPUMcpzpEELvXlEUuGspf7A0SoG2WmVdny4qE+/sQ+NC5AAZLBLpg8EP?=
 =?us-ascii?Q?RWGwUwqpxBCQwI+5QyVmGZ1WdfNAMC5QGxP1szemzMBfalVYNQ2UNHEskiXw?=
 =?us-ascii?Q?Ol+20HkxX5u4LY3CD2lEHUl4RbaM6OPWiBlM/fNVXsTMMC4D9TsGVcgNg3u8?=
 =?us-ascii?Q?qLr5dpP5MgA3pV7/A5dN93KyNViqp8adSkaOkLYmC7P3g+yQXPro49o+GvAZ?=
 =?us-ascii?Q?kjB9XsmlzjVEOoQPHMueYMVBO+1wuDzQjOuANci58ylNYk78Loso14FuqMsp?=
 =?us-ascii?Q?y52B573RX8W9x3kd1cpPkKILwnekVAex+PcgYMX9oL5InHfuIn3Cvq5+vLCJ?=
 =?us-ascii?Q?HYgYQEfVqLCfl2DkK7dvFMsT/lqb05wCmCc3MDK05bl2qFnQrcw2nE5cURIN?=
 =?us-ascii?Q?dsxpFWaVVzKHBucoHvNtdBIa7o0xBJLxrTRUr26XwqJaVbNK9XjyZxwsiGcd?=
 =?us-ascii?Q?zhzo6fiT1v/kVejD86aVwsqHph1nVgBFynEy7jUCJs9QOPnvDH7YTfMfLL2h?=
 =?us-ascii?Q?rB4LTgvtBUvVIIVUBaJOqRZBPRd2rh4FT8SiA3bmnaoWURgpU5koigxt0Xo8?=
 =?us-ascii?Q?oZOKJj1sIxbyuqXlziNm/lwbHdTaHRZW5XL7z8z7sNn81JKkXT1TDO4LkOsT?=
 =?us-ascii?Q?C27FC4NOe158eZEYx9BcU4ePVxdwQ7ZTvEmkfAsox5vWcG9F8lgXqufaDW5c?=
 =?us-ascii?Q?7zNjFgUeSLXWQSPjPApcRonj5j4xAAFwF/LrkgxBwxIvmAgnSPewSpAYfhGQ?=
 =?us-ascii?Q?gjAFONlLqD8wgW2OXlQxye41vDkPVyJA9OJnzdy/TJV91YFy+yLF0Xtodatf?=
 =?us-ascii?Q?T+fM3KmZzUl5pPMNbFCYQiuV7tEkfg3fHs51c70yUstgPQFFQWW2zdVEwjDE?=
 =?us-ascii?Q?l7S7W57jbFoER9t4fnQnG1CDQb+j+9g+AbtSBAg7768LvDBttTVIElbpMvJu?=
 =?us-ascii?Q?n+SL9opZIn7L6juyqj89+KC97d0JbrqQUtaUgGf5NIl/PYydUXIOoKZ/L7BJ?=
 =?us-ascii?Q?tQg4CNhhhfloTJFvswx/TE2WxLloE0H/FwD9DI1LrzKosJjaCd2rxb8YlZMP?=
 =?us-ascii?Q?C529qCI3cjH7IoC/oOJqN5e2+hZ8sIr6kYIiIzMlZRwZxGhksHzjXjDdLN2q?=
 =?us-ascii?Q?hAYDlgLzcj2Q5ejpGXDEZYuBJeBPyExxUCJ1gjRzGlTgv3An8reXdt01QUCC?=
 =?us-ascii?Q?WzXSHSMg4dm6JrFsg2MujlHKndjApBJZT8UHFfvPHhuPONAfiHhPyEv5ak18?=
 =?us-ascii?Q?uIlYHJO/VSL4iRhDI7gKkQ1SkQKb5h8+yYYHozOdRJjoPDlP3bcdO981546V?=
 =?us-ascii?Q?ko+TNftis9NWKIEBrd4jnsu1nRTgt85pIxj0BLUeUP/OR6Sf9xV/ByeHShFJ?=
 =?us-ascii?Q?k9llCQZGBcs67jBUJc4oIXG8xeMhODyiM3LJ0jVbx0GyX4+E/2C3tyfflD5G?=
 =?us-ascii?Q?ro7vMlxcebMo6BxDUsjy5jaDF9tfOKzFxrVBosfKhOXuYegrVLClXWkrR8Ua?=
 =?us-ascii?Q?RQ/VwEIHoQ4ZkLk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 16:19:35.3640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53626a83-1c5f-4767-10e9-08dd4d135f56
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

Changes to MC remote need to be reflected in actual group memberships.
Add a test to verify that it is the case.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---

Notes:
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../net/test_vxlan_fdb_changelink.sh          | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 6f2bca4b346c..062f957950af 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -3,6 +3,7 @@
 
 ALL_TESTS="
 	test_set_remote
+	test_change_mc_remote
 "
 source lib.sh
 
@@ -31,6 +32,81 @@ test_set_remote()
 	log_test 'FDB default-remote handling across "ip link set"'
 }
 
+fmt_remote()
+{
+	local addr=$1; shift
+
+	if [[ $addr == 224.* ]]; then
+		echo "group $addr"
+	else
+		echo "remote $addr"
+	fi
+}
+
+change_remote()
+{
+	local remote=$1; shift
+
+	ip link set dev vx type vxlan $(fmt_remote $remote) dev v1
+}
+
+check_membership()
+{
+	local check_vec=("$@")
+
+	local memberships
+	memberships=$(
+	    netstat -n --groups |
+		sed -n '/^v1\b/p' |
+		grep -o '[^ ]*$'
+	)
+	check_err $? "Couldn't obtain group memberships"
+
+	local item
+	for item in "${check_vec[@]}"; do
+		eval "local $item"
+		echo "$memberships" | grep -q "\b$group\b"
+		check_err_fail $fail $? "$group is_ex reported in IGMP query response"
+	done
+}
+
+test_change_mc_remote()
+{
+	check_command netstat || return
+
+	ip_link_add v1 up type veth peer name v2
+	ip_link_set_up v2
+
+	RET=0
+
+	ip_link_add vx up type vxlan dstport 4789 \
+		local 192.0.2.1 $(fmt_remote 224.1.1.1) dev v1 vni 1000
+
+	check_membership "group=224.1.1.1 fail=0" \
+			 "group=224.1.1.2 fail=1" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after VXLAN creation"
+
+	RET=0
+
+	change_remote 224.1.1.2
+	check_membership "group=224.1.1.1 fail=1" \
+			 "group=224.1.1.2 fail=0" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after changing VXLAN remote MC->MC"
+
+	RET=0
+
+	change_remote 192.0.2.2
+	check_membership "group=224.1.1.1 fail=1" \
+			 "group=224.1.1.2 fail=1" \
+			 "group=224.1.1.3 fail=1"
+
+	log_test "MC group report after changing VXLAN remote MC->UC"
+}
+
 trap defer_scopes_cleanup EXIT
 
 tests_run
-- 
2.47.0


