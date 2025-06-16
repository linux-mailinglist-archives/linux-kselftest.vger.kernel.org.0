Return-Path: <linux-kselftest+bounces-35149-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E73DADBD2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 00:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70E6A18933A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 22:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765CF2264A5;
	Mon, 16 Jun 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h6d4eeTJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69CB11CBA;
	Mon, 16 Jun 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750113994; cv=fail; b=l4lZfDT5XUNOh4fYaGgfi1gJxcdBrtE4x29i6gMeGhV/o5zrJhHCkXkcKU4ti54gVrpRoNp5S56zaofuu++2y32IRAZXmaV6ddvEcEvQAip4XNFc0/yaDWpm4QM0IIdQoji9qjGX1w4l4keJ6n8LhOeNGOMa9Lh9+ShIEuS8qVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750113994; c=relaxed/simple;
	bh=JTS9WTQcG1wHKXqM8xfovsZwhw31X+qo8Bw1s+EnRwU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Bzy3EjuisNZiLGLm3y15ppw5Pxk3K3PIzRxabjzLTURDQjMlvSPPZPuv1Ht/txj669IwfPD3HFk87MGwrHy4VXzpzDLBw9QhFM2arlpdWu32MqlDx0SKQipFb4wiPgeO/JDsNOOKjlkZoQwvK3NvX0BxcKgSKgCH9R57iUD2M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h6d4eeTJ; arc=fail smtp.client-ip=40.107.220.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=futK6E4QD36ZQv+DlxEYoGvYIgEROwOWdJ9hE96cV6NC/4XhGYk8Q3P13b6WIWql+JBZmnLaJ9KkJs6JJhlYC83VvOGg3X1SU1JsOS9h86TJwV8uSBbW1eBJDbtfEU1R52I37WCbdSiy0TlVSKIcHceGmEuL6jhHymIMM+ZAZHCBQvw3Pp8loWmDLgwmeiT3DVw9yoNliLP4r67SmPI/Gah+JfBV6mcqqVrIN5ekejqIp+DtRCB19D2L+RNAFLPSuWDbRyw1xsAe/wV0E5DLsucpNOW0l5pt1NqFs737e59mLF28R8USui83QgdntE3lJtXhbUtCA0OrKZZlyYaDnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX8Rv1nZE8jlvxETU2QgUXqb1q1vyzwWaoQiliByBVs=;
 b=s2pnEMsAU2lb6rwC/ER2Mks2guuypFZWPg5vSAyI/EkJ+3wbzg7kp5eCvyx8WYSIZ3dkJ5lBC3tddwUCaxtvzsY2GgbO15YPobJDSqfHBKcM/ROAfEe+EENTXEKpTczXHcWKAhbjgPUOlAH4ZwLL1KBgdwqmY5U2mltpbRI2eux1M0JY8TI3s05bWRgvg6shcoywsqeJyauiaEt3O+4hzuH3i5civpwm/iRXVUnGhOSxGbHggskR4GvFxhFTTL/Q3Kc8nFzl8jnC7LmGQ6D4bd+RcazgPqUzQacOt9XsqdLs4IvaXDTqAtbWwf8ws0IIlxG8NcY9T6GkaDkLJmudnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX8Rv1nZE8jlvxETU2QgUXqb1q1vyzwWaoQiliByBVs=;
 b=h6d4eeTJkzdictYBK2HaCu0U6Px2j9xA6s7GxnXOVe2G9D8/bEHy0QRF5GuJCCChCdYBMtNd6jsa4lF3EUEdCdTnoYgag+FwipLlc+V+mhZEiaJWlGaxd1TvuqnVU0M1zh6QLE4g7xtya3iecvFUuxebkHStPn0I07JMHrI3c2r1tGIej1mwxkevG69tig2hLCPz9VcRL+uGAZaTl1P4EZ8vyjde8vyVHghXUyxC5AOkbFHBdeJKifp8CBFmXlllM01zxY415SjoZlKbvVUbnJ8oi2q3gH/lTapGluVQYOzB4uvm3KFwuW6wF0faqUdLe+DFXxZw7+RQPk16946SkQ==
Received: from SA0PR11CA0149.namprd11.prod.outlook.com (2603:10b6:806:131::34)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 22:46:28 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::ff) by SA0PR11CA0149.outlook.office365.com
 (2603:10b6:806:131::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.28 via Frontend Transport; Mon,
 16 Jun 2025 22:46:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 22:46:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Jun
 2025 15:46:14 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 16 Jun
 2025 15:46:08 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v3 12/15] selftests: forwarding: lib: Move smcrouted helpers here
Date: Tue, 17 Jun 2025 00:44:20 +0200
Message-ID: <410411c1a81225ce6e44542289b9c3ec21e5786c.1750113335.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750113335.git.petrm@nvidia.com>
References: <cover.1750113335.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: 281a7aa9-910c-46ad-495c-08ddad27a13c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMwcqtP6QTz/XIgFcZ/rH/Ur7SjJKCSl2y1tzYLaYy93PK3Btn0ZvlLm58Mc?=
 =?us-ascii?Q?3wF/dL2Leg8jizkrP2/HguhUOonKiXl6POKCDkD911Cl/EZth8R9pyHXMS11?=
 =?us-ascii?Q?lnexEFYEmQ6ozmdD6COHVsrZJqsniqGvhRJDUs8ait1tIYZt3sr8mXeZcjxr?=
 =?us-ascii?Q?Tl5NhyKwaKPrAKEJHqEdT6g4SbqtVR65mOq9Iyad2FQu2kKpi9yjpNwEpxCn?=
 =?us-ascii?Q?qN/ZOFBTZfAHwTlr2zDQUKcF/b7mfiermVOYAIECUHRoNcTEPFGU9AO7fPWv?=
 =?us-ascii?Q?wHiHkZh0dePa9E893ZmD9rZ7vHi+nWdjaGoWcJHY/Z+vyLNTddI7OUutiN82?=
 =?us-ascii?Q?uRH7utlQBt+QiT2kR0IoBUVfWCgWZCKaLy06FDWgsMSKYXclNhj7y1ZSXVpD?=
 =?us-ascii?Q?EXvSz8grA1moLBObfDszuOTUYFkQRXIRiq+HVeQg+Vxzye7zvagjWUtStJ14?=
 =?us-ascii?Q?sxkcWH26dQsOLQyyzFlAq+cQNqjrzEt/YEr2Ne/r+YVDsTWAbd2aLVxKobiu?=
 =?us-ascii?Q?e5D8gu0EfrCgtESVhIuQj/za6mGlfs8DS3b8ZhAmcRYR+W1j5FJb8kZiuHsO?=
 =?us-ascii?Q?rchUgCL4Ga3mvFCs1+2nUf7PcQPi4Q90jbFBLaBRLZ9H+EiSv8OrFwylNBFz?=
 =?us-ascii?Q?SJ1oiHcezTblrN79B0LP3kD+GYTG5+cdb2pCd8KmgPU8IcyEr774+1fkZLep?=
 =?us-ascii?Q?BLKK9mt8qDjeeWcRFwPJwhcwJbGNED/VzOAsz5XPQ597QKm9BUQe7M0H3gKE?=
 =?us-ascii?Q?cPa+dzjTsAt8oTfPhoPLby5CcmEXbrA2nV36jnLZwaQzbmApEyO9AAdRQKPs?=
 =?us-ascii?Q?nXqkmaQ5jYoy845VOaSa1Lg0wHAGEZ4iETykzLSkh+Vmv1VFtuLMXbQieiLz?=
 =?us-ascii?Q?lK8voA7ihnGUhorC0GHkNyd3a7s7mMdncGoBdDkyBmEm7SGZVJpm376Ax3cL?=
 =?us-ascii?Q?aXw7hfPVHxhzJGz11q73S6ErJXa2J1RAd1h5GcIEaWaP8TXhWK9vt4j/lfGN?=
 =?us-ascii?Q?7gScIZaBZMJbbJ7UxPcOqc1HweOcRoXV2dmQyfGx86QYsBTKOpm2rWcKeuMW?=
 =?us-ascii?Q?4OtZXFZJK6Go7wm7KufS2HFRLg4mxGKBQflhP4jx/5Ckc7o7eUhrUoYx+H2x?=
 =?us-ascii?Q?ZfWPdAD5KDEuuF2xcW+icWVDGTnrUdBNWC/yOGlHD7JGihbXF8G2U+pfs5iv?=
 =?us-ascii?Q?R2iEadOHbei8wh6gg6WldvcTXh4P59FQBXtMP25IIiRWTzHjqqxYyyk7crBS?=
 =?us-ascii?Q?Lc9xdqEEMfS3NMxZcCV2WS/ooUAbvvIeCETgAu4UsyJy8Rj8t+ojg5tQQ4yn?=
 =?us-ascii?Q?dSPsuQ/+UJk4VFKeyVcXHhAMXE+1YOctTOpqoRJYmzqFBZaIcp5XZJIH8Z9x?=
 =?us-ascii?Q?KL0+vhaRBAY9QhGeHRf4qt75b9upvTyG5e27e6ZivppzlmrvWOvc2vdsrQZK?=
 =?us-ascii?Q?Yg6xyE3Lmpe+OlH8yvULgvD24EB81Pb1Y3CINa99HiaiXthMrK9uJQpGTBMB?=
 =?us-ascii?Q?X0RM0/HZRf8+osTMSyWUalGuB29f/lEWWX1r?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:46:27.5400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 281a7aa9-910c-46ad-495c-08ddad27a13c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

router_multicast.sh has several helpers for work with smcrouted. Extract
them to lib.sh so that other selftests can use them as well. Convert the
helpers to defer in the process, because that simplifies the interface
quite a bit. Therefore have router_multicast.sh invoke
defer_scopes_cleanup() in its cleanup() function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Adjust as per shellcheck citations
    
---
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 33 +++++++++++++++++
 .../net/forwarding/router_multicast.sh        | 35 ++++---------------
 2 files changed, 39 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 508f3c700d71..253847372062 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,7 @@ declare -A NETIFS=(
 : "${TEAMD:=teamd}"
 : "${MCD:=smcrouted}"
 : "${MC_CLI:=smcroutectl}"
+: "${MCD_TABLE_NAME:=selftests}"
 
 # Constants for netdevice bring-up:
 # Default time in seconds to wait for an interface to come up before giving up
@@ -1757,6 +1758,38 @@ mc_send()
 		msend -g $groups -I $if_name -c 1 > /dev/null 2>&1
 }
 
+adf_mcd_start()
+{
+	local table_name="$MCD_TABLE_NAME"
+	local smcroutedir
+	local pid
+	local i
+
+	check_command "$MCD" || return 1
+	check_command "$MC_CLI" || return 1
+
+	smcroutedir=$(mktemp -d)
+	defer rm -rf "$smcroutedir"
+
+	for ((i = 1; i <= NUM_NETIFS; ++i)); do
+		echo "phyint ${NETIFS[p$i]} enable" >> \
+			"$smcroutedir/$table_name.conf"
+	done
+
+	"$MCD" -N -I "$table_name" -f "$smcroutedir/$table_name.conf" \
+		-P "$smcroutedir/$table_name.pid"
+	busywait "$BUSYWAIT_TIMEOUT" test -e "$smcroutedir/$table_name.pid"
+	pid=$(cat "$smcroutedir/$table_name.pid")
+	defer kill_process "$pid"
+}
+
+mc_cli()
+{
+	local table_name="$MCD_TABLE_NAME"
+
+        "$MC_CLI" -I "$table_name" "$@"
+}
+
 start_ip_monitor()
 {
 	local mtype=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_multicast.sh b/tools/testing/selftests/net/forwarding/router_multicast.sh
index 5a58b1ec8aef..83e52abdbc2e 100755
--- a/tools/testing/selftests/net/forwarding/router_multicast.sh
+++ b/tools/testing/selftests/net/forwarding/router_multicast.sh
@@ -33,10 +33,6 @@ NUM_NETIFS=6
 source lib.sh
 source tc_common.sh
 
-require_command $MCD
-require_command $MC_CLI
-table_name=selftests
-
 h1_create()
 {
 	simple_if_init $h1 198.51.100.2/28 2001:db8:1::2/64
@@ -149,25 +145,6 @@ router_destroy()
 	ip link set dev $rp1 down
 }
 
-start_mcd()
-{
-	SMCROUTEDIR="$(mktemp -d)"
-
-	for ((i = 1; i <= $NUM_NETIFS; ++i)); do
-		echo "phyint ${NETIFS[p$i]} enable" >> \
-			$SMCROUTEDIR/$table_name.conf
-	done
-
-	$MCD -N -I $table_name -f $SMCROUTEDIR/$table_name.conf \
-		-P $SMCROUTEDIR/$table_name.pid
-}
-
-kill_mcd()
-{
-	pkill $MCD
-	rm -rf $SMCROUTEDIR
-}
-
 setup_prepare()
 {
 	h1=${NETIFS[p1]}
@@ -179,7 +156,7 @@ setup_prepare()
 	rp3=${NETIFS[p5]}
 	h3=${NETIFS[p6]}
 
-	start_mcd
+	adf_mcd_start || exit "$EXIT_STATUS"
 
 	vrf_prepare
 
@@ -206,7 +183,7 @@ cleanup()
 
 	vrf_cleanup
 
-	kill_mcd
+	defer_scopes_cleanup
 }
 
 create_mcast_sg()
@@ -214,9 +191,9 @@ create_mcast_sg()
 	local if_name=$1; shift
 	local s_addr=$1; shift
 	local mcast=$1; shift
-	local dest_ifs=${@}
+	local dest_ifs=("${@}")
 
-	$MC_CLI -I $table_name add $if_name $s_addr $mcast $dest_ifs
+	mc_cli add "$if_name" "$s_addr" "$mcast" "${dest_ifs[@]}"
 }
 
 delete_mcast_sg()
@@ -224,9 +201,9 @@ delete_mcast_sg()
 	local if_name=$1; shift
 	local s_addr=$1; shift
 	local mcast=$1; shift
-	local dest_ifs=${@}
+	local dest_ifs=("${@}")
 
-        $MC_CLI -I $table_name remove $if_name $s_addr $mcast $dest_ifs
+        mc_cli remove "$if_name" "$s_addr" "$mcast" "${dest_ifs[@]}"
 }
 
 mcast_v4()
-- 
2.49.0


