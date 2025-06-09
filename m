Return-Path: <linux-kselftest+bounces-34517-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB9AAD281C
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 22:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F85B1894477
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 20:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCACF221FDE;
	Mon,  9 Jun 2025 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UQeax7MC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935421FF3C;
	Mon,  9 Jun 2025 20:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749502355; cv=fail; b=rkjKd1J8/FCMjwNnKKgDSof8UFtOA+e+Jmxh6q/1CmGpZBm+HkNJhu+wpJkHKVZOuEYDlCnjX4Nbl6ryDPBREwKPpbwFk85KV6IppVPvAZCI84SyQ1s+TvSWg9P2XbsOwEtPzzwqOE1h4hywF9801iaUOaMBVBE3zI2W0iG4jZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749502355; c=relaxed/simple;
	bh=nOTtwMkgqA7i6S4gTeNlCy1sQmBalDmtd5zYNDEZpA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtHamc6Tq2kXSEIhTIhJqldK7UPw0U6l2tgKnNUIy9+iw+xwjCUs4G8bpnRwtznQ+Xt35Joh4XVrjnyuzcDe1OYaDcuepDAmxYvpxzbSMOCNgT8qnaKRqyFEjufHuLW8oGGdurfTNgWs+uK81tr2jybScJsAQOhRr+pQTtMnpFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UQeax7MC; arc=fail smtp.client-ip=40.107.212.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L42xKkfoVVhkSFj0nx2gXxNjs3QBzNTgcrNTHZTpeTYwe0tOEe52ux6Wto45GKWaHjwW7k88G3fIK5AoBnCBaPmopz2/VoNFI6y73qSIzsjR5B+/9are7h47KNBnD6+YHf3VCs1QXib/63p1wFmjd3yFW/TnCfC4vf2CRQ7JOfFY6UZqpOakHDYvjhuGG1yl0yqtCoLKj1pGoavvFBXiapM8ykoQpPmi6sWhIMGQGb7EmGjyjUnDBatyitNggwg8rvN/AXJbxKCBvIcJ87PoDp3NeZpbEmfKJfxC/zBIL48ZNxuIP6jtKFAv61J4GEMdXf1q9mHpelaPQcYtuJzAlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJIxDWhBUeovNAoHa4fIRmGhAeemlfXIrsrQl+KAL9g=;
 b=uZvlRa1x2pbs6pVqWW3v19MPNLoYy2vHS63xc5av22ilwWPNphgKhbbh9xSi3l8nGmmMfpdDr9l7A28q8r8r0FXIvStxCoJAoIXzi/9yWXZRrJrldlgxz0a8pxElriuS7nDIWUae5TKvc3ho2pKmLwKCdSK7/38fHUYAMxDNuYCfD7kmTmJmwQsbqDPBNj+fBh27ZqJ/3oPE4WhiKbD8RJ00gnqVPQFRTFoyi+zc7QIWChswkftm2EFXO+DrTRppyDH81PQLwjmW2c+PgiLB6Sz3Bj/UjzeeYx9BxNALXt2N8BmpLPmwsN37uH//E+NZGhl4NCNsBVBYsQNs/vdj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJIxDWhBUeovNAoHa4fIRmGhAeemlfXIrsrQl+KAL9g=;
 b=UQeax7MCsquqpz3C3oRX2o83vwuT0NDtKWPSunso6s7Jvnb3ri1j/d0N+YjMg10B7ObNZLZuutUZ9GmYL9t/TpS3WxG5ZxnFKzFbssQeF2RrPw4xBL8fhMb9IeuiHsqB88kHbg61x/ed+HW/WeXLdfNmkt00A5g26TO1mUnQ9iADe3C/71cJmh0wD7Ec/lPlD/rpWSeZtEOerScjkPcg1VBeeVDkJsvjlcla19tcYmR1yVU6OSGuxAydJcR4XjoatYKYqx4o+TZu0a7dZdzL3Lmx/vK6vKPUEx8n9zoe1BMIh1akkb11vmOP8o2K7pa9wr/BEsbdr/1cUqy/C/Hy3Q==
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by CH0PR12MB8529.namprd12.prod.outlook.com (2603:10b6:610:18d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 20:52:28 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::df) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 9 Jun 2025 20:52:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 20:52:27 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 13:52:13 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 13:52:07 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
	<netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 11/14] selftests: forwarding: lib: Move smcrouted helpers here
Date: Mon, 9 Jun 2025 22:50:27 +0200
Message-ID: <4b32aa36f13a4ac662b3464ba037510b40a7caaa.1749499963.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1749499963.git.petrm@nvidia.com>
References: <cover.1749499963.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|CH0PR12MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: 226941cc-28bf-4045-c377-08dda7978b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QFaEOUmdVo+PoLR4NalYfejiVu48zLNi48+42AUmM0Q3iHupM8QnDy0CEpqQ?=
 =?us-ascii?Q?P+gAvKJgcF5OlRl/hM9EuBDChe/+KgBB/SBs8WZyrK6NLoUM70IPfcjcPGPz?=
 =?us-ascii?Q?fDj6RV/Mvg7MLrhdnX937o4zYbem5+xZFyJ2AcZ1Yhst4TtQVxJLB4MAXFZK?=
 =?us-ascii?Q?JEfTjbCd/hvlcKQcIcEufBOjWdaLwV1o8YXI3+e+5sS0dqXaSBfZHC6e6sjC?=
 =?us-ascii?Q?F5BVDUUNbY8iX7JQmFXmKYEGRPM3IRY0iPxADA87Fhk1iylsK/51pzeWaWq9?=
 =?us-ascii?Q?WGsXa9jgf+Z4P060B8y+p9Du7nxmXokuSeEZac0YZFcuOkGaVON+9harIFZH?=
 =?us-ascii?Q?HW6n+VxR6af8kfOUw3WWVAY9dHM46mEzYPVE0LFIjUl3pMhuUNnGGNJ1k6vD?=
 =?us-ascii?Q?ATn/G+labXGqZybxSTaKJ96DRTMfE48eShQH2zF4rY+np28okwsjIz30Hfld?=
 =?us-ascii?Q?GXpkTtnsNH2RwIACyqjA6bvLHwN0Jmn6qrZUTcTifpAbtY3RsupwcsUn9IYP?=
 =?us-ascii?Q?uj8a+LX6+VIKXk5d6+rMSMez/I5cq977kY9dNdQAE4H/SwFEAL4edducTBul?=
 =?us-ascii?Q?YEFHgb0WSn3ODxmRAjpR3yhpmFdYsHcLMk9hMsP9r28TVuDNksGAMuLIWCF3?=
 =?us-ascii?Q?JKbZOa1Na/bjsgh3ADKOD7dKqJ9NyofGl/koHAKtpA5NUjYF9ra57fpHFwBW?=
 =?us-ascii?Q?tW+RKVG2gXZDyOxbignjDPY6RnpXR4vc24v6h45FawKiSasG9O65sidMZVnN?=
 =?us-ascii?Q?UnR4eYx2LDUGNuECpwcv24Sc539NMlOYvuji3WPIJJv8cHXn4Z8cTZLdWjU1?=
 =?us-ascii?Q?oqmGOlrQirhr9VjtfM5ZZ6RcY47D8Zej4/04WHR3sFkdcH0NcSJs+GiN9FXV?=
 =?us-ascii?Q?E9i5ZlliJApyI6MJF0A4jXlwAxNHP0bRNSf21I5HthzL4ONKSF4OJTP+u0wM?=
 =?us-ascii?Q?IQqDC8bWU0UyrsafGGld2M4O4EEwgoVR9ECxr86zknl22KyJzfs1ssjF8NYc?=
 =?us-ascii?Q?Px8pVyKGQfcraAk5JbN8gKQy9ZPP+Ie1Z4wBAVlMXzqFu+oOY5p+8gQB71/p?=
 =?us-ascii?Q?iP7M+9NSZ9kYc4GnlN/wD6TpyOnkbDE8G0qGJf8lB5zBn5BEBfnfeL08WMfJ?=
 =?us-ascii?Q?SYi7qXB7lpTuutrLG8zFS8zXLZouyGhy+5lFp5XEnkOYEj4Lu6J9ZKcRtAid?=
 =?us-ascii?Q?fvP0Wip3RZ1bN8FPsc4ZGQ6YeiWvTYFcRLACLFJDR6T53pN6lAsWa9BL1Mzb?=
 =?us-ascii?Q?YDch+xgaUWMisCWSHcSY5wcOrnahD/RXvp937ATREGoiFknK0cUhilkC+RJQ?=
 =?us-ascii?Q?VTY97i8459uD2q3mkDqOADHaP0Zc/o7P+tSQpQuQMgm4KN0+kgnWateIUIGa?=
 =?us-ascii?Q?2gCmi3xZsb2u3OHNst2q5A8K43OObtQa/3ZoqlofhwHniylqvqchDocC9Qeo?=
 =?us-ascii?Q?r2zfwCiSMPsXYoVMnkfHkfnMpf4/kGtr2I0oj3HY6gPqeShR0aPnw1FWI0XO?=
 =?us-ascii?Q?QanJgoyoM8oYXK4P35mtUaTT2SA8woKFWt72?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 20:52:27.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226941cc-28bf-4045-c377-08dda7978b4a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8529

router_multicast.sh has several helpers for work with smcrouted. Extract
them to lib.sh so that other selftests can use them as well. Convert the
helpers to defer in the process, because that simplifies the interface
quite a bit. Therefore have router_multicast.sh invoke
defer_scopes_cleanup() in its cleanup() function.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/forwarding/lib.sh | 31 +++++++++++++++++++
 .../net/forwarding/router_multicast.sh        | 31 +++----------------
 2 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 508f3c700d71..88e63562f5c5 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -37,6 +37,7 @@ declare -A NETIFS=(
 : "${TEAMD:=teamd}"
 : "${MCD:=smcrouted}"
 : "${MC_CLI:=smcroutectl}"
+: "${MCD_TABLE_NAME:=selftests}"
 
 # Constants for netdevice bring-up:
 # Default time in seconds to wait for an interface to come up before giving up
@@ -1757,6 +1758,36 @@ mc_send()
 		msend -g $groups -I $if_name -c 1 > /dev/null 2>&1
 }
 
+adf_mcd_start()
+{
+	local i
+
+	check_command $MCD || return 1
+	check_command $MC_CLI || return 1
+
+	local table_name="$MCD_TABLE_NAME"
+	local smcroutedir="$(mktemp -d)"
+
+	defer rm -rf $smcroutedir
+
+	for ((i = 1; i <= $NUM_NETIFS; ++i)); do
+		echo "phyint ${NETIFS[p$i]} enable" >> \
+			$smcroutedir/$table_name.conf
+	done
+
+	$MCD -N -I $table_name -f $smcroutedir/$table_name.conf \
+		-P $smcroutedir/$table_name.pid
+	busywait "$BUSYWAIT_TIMEOUT" test -e $smcroutedir/$table_name.pid
+	defer kill_process $(cat $smcroutedir/$table_name.pid)
+}
+
+mc_cli()
+{
+	local table_name="$MCD_TABLE_NAME"
+
+        $MC_CLI -I $table_name "$@"
+}
+
 start_ip_monitor()
 {
 	local mtype=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/router_multicast.sh b/tools/testing/selftests/net/forwarding/router_multicast.sh
index 5a58b1ec8aef..1e2378777b48 100755
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
+	adf_mcd_start || exit $EXIT_STATUS
 
 	vrf_prepare
 
@@ -206,7 +183,7 @@ cleanup()
 
 	vrf_cleanup
 
-	kill_mcd
+	defer_scopes_cleanup
 }
 
 create_mcast_sg()
@@ -216,7 +193,7 @@ create_mcast_sg()
 	local mcast=$1; shift
 	local dest_ifs=${@}
 
-	$MC_CLI -I $table_name add $if_name $s_addr $mcast $dest_ifs
+	mc_cli add $if_name $s_addr $mcast $dest_ifs
 }
 
 delete_mcast_sg()
@@ -226,7 +203,7 @@ delete_mcast_sg()
 	local mcast=$1; shift
 	local dest_ifs=${@}
 
-        $MC_CLI -I $table_name remove $if_name $s_addr $mcast $dest_ifs
+        mc_cli remove $if_name $s_addr $mcast $dest_ifs
 }
 
 mcast_v4()
-- 
2.49.0


