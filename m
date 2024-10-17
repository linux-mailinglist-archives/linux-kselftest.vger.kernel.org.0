Return-Path: <linux-kselftest+bounces-19947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F759A1EE9
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F77AB259A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A841DC1A2;
	Thu, 17 Oct 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d2OJRtzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CE1DC195;
	Thu, 17 Oct 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158496; cv=fail; b=ohaX/J0GkQoKQ9vGO7RQ4+ecX0GEbZSHFDt6tRKQ8wGBvtiEPysMTzORteX1+NhsPRFBNbO4f6s6NLN+8oaQZEYCW75WeR/jMJDADKPA0vrj2XIyU4NFYdffkTRv8Ftp0/zb/Q2u0pH6fVW+ovXMkZZkOrCnLwJfMb3TXwvT2QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158496; c=relaxed/simple;
	bh=CGbzMlnE8NQ2E0+7jxlDy4cOi2zh+2y9Mz8URLCBqXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sx8B9qH4mM8s5gxvybIWYv8fBoYjJg+9PkC5TYCj5zdacGN77nNYEh43xOlpHgwr3UZlIyarEbkpngr+wxIbXeXJAOc/+8j0oQUKlFQ8EPld83dkvEov9PyZM8wmnDc3HoO3ybdPbxoQ88Fst2LgU6aAzaRs/rtKVE/ZReP8w+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d2OJRtzy; arc=fail smtp.client-ip=40.107.96.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QascfLlZ+FUws5GEc5cd6dh/bcyzYStTynsNLHVmcf/iGiUi0dcC9CQdXgj47Ts+KeHQ6QEBvo++CMynOvCeAJLoPXHLoBZ0SnDzYRQqhvBwEuFY7LLn5RH0h5CKskwmqb+KcmGrQDKV8UkR3mclGuD+ed3oKUe0G3taGhXOcA5Mw932JrSvS3ey1WU3Em9GCq267wwq8TuJLIaCfUlHfyDszol1kilivSKoDZmg72oPpZpNH5bT5nNrhX6gkHsf5ExnexwvL72UWLk01Uk+uTHmyFKQd2x6yZkssRuVZUnUCJ0fqOnY5QfWqQ6nuTrNmNuDCad++W6RLiVAnfAaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jd6MnZn98keCO6B5yBoxOZkIOQOubnd8AutPhbtdt6g=;
 b=Ib8I5wWb7V8pBi12NevO3rDukoCZ4UTBeC/BM8y2fJzFiDx0F6xWjoQ2rRwI3OoVyN1L5bRF4agwkLQQuyGkzlB7DYoiNJMDjcK3HLs6DnqV9kuCIO9IklpkfrTmfOyuSwo6sK9P5HeVy6wMxf4eM8tlNpkNaqSfV/xkYMWkCFtDGiNfuUJ1VlHiRG5jI+eynIUIb9fx5NgjgXUbUXL2RJIg8BY7m/4qT9w+qH0OWMUezeDa9XTmKWj+DyLII1q1d8gGCsCSnF50hKL34BAgBX2JJCXQjbI+Mbyt3jBQf05YDCvXkXIMRNN1wUA4iamgD5rEQvKa6pk22PrscakpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jd6MnZn98keCO6B5yBoxOZkIOQOubnd8AutPhbtdt6g=;
 b=d2OJRtzyeS0JTP7sgPoQX+jflD/ecIaa+9WKlzVosoCfGzaYiKDYDpzWnZkuNboWjpFft+mINtvYUKffk/6dvkspoyJOD/Ax1FnnXEQZggh162zyWug98JZaTLbzqSdjnbHjzC5OxDbBapzpz+ablsrPxEslgeL0bq2R0GuoQy2Vu/gwbWtgrUpEpCpWf/a7fHVP1m2ykBUsRwXvxAMW58SH/gRiS/aKtKgkS4fPcU6/k2U599ywPsQ2ffB2m4Krhu+Vg18PnWvsvgBSnqIfmmvrTBFnPBdglMVxN7JI+FHDROpX+8Xnj2SoMJVU7v5J0gHBZodyf629F28l7ur+WA==
Received: from SN7PR04CA0024.namprd04.prod.outlook.com (2603:10b6:806:f2::29)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Thu, 17 Oct
 2024 09:48:08 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::7a) by SN7PR04CA0024.outlook.office365.com
 (2603:10b6:806:f2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 09:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:48:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:53 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:47:48 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, Willem de Bruijn <willemb@google.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 10/10] selftests: mlxsw: devlink_trap_police: Use defer for test cleanup
Date: Thu, 17 Oct 2024 11:45:52 +0200
Message-ID: <35d5fd1600f9440bc94ea683aeb66d6ee7921222.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729157566.git.petrm@nvidia.com>
References: <cover.1729157566.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: f000b2b4-17ef-4a20-0760-08dcee90ce67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iKJ+zDnaMb6ez+fYl/gJ8MFqaCmEuWDCmPz9YIhGiQKTXG92Hh9jL5L71uZR?=
 =?us-ascii?Q?uAp1TRkFyBHFVB6eS92dizRV2l95Xs5G/Em2K7PIVLA1BHFi38pxkds7My8y?=
 =?us-ascii?Q?QTGZChtidIaOMHTyQs//Vd5KQu8p2vctZAmMNc6Z/6DBwEnLrKmx2VB24Tbw?=
 =?us-ascii?Q?YmsWXsLBHKWwsyfDF2Y+PaStkYuUttZK1xmUzdXiaYqWh79KNYh51EtXYeBU?=
 =?us-ascii?Q?/yDpmR4PR5oPtyi+8f/OnL8VnrpYCJVIknTwiE0cPr3Rs1YB1cplYmHNkRfp?=
 =?us-ascii?Q?tUp1SOd5S97CpP+9GQ4F/hDpYdhkdLb3Fb7imwLLCfI35cnJRCdEGt7ei0Da?=
 =?us-ascii?Q?lOKxOPrGqGFVQOfb03oYmS+WG3NwKcBFJ1sPUgKNS2E7LsvqY6QL2VHdfy00?=
 =?us-ascii?Q?BS/VzvAuMg2gu9WOH/h5QC6P9WKJ3CYZVC5Rxq+Xd5QGA7LzVm78iqbWVRAs?=
 =?us-ascii?Q?WLDON3svn6YF+4s8Vy/rbetSfkkq5a25Sm9Xr08YiECgk6feqCYX9KoWEGde?=
 =?us-ascii?Q?ywHCN3MvX3qeQ8cxGQvA9ixADRwoK4uTZ23m3jhtURAWp2ysue0MsTRC1NDu?=
 =?us-ascii?Q?01tbMWOh+wR6kft3hnrST4JOUaT28NQV0aOzHoJOuVIWo3mZitAvDCw5OI1T?=
 =?us-ascii?Q?vthQA0+LYTmdEFFVZZw75hPGNDNpec/ZBxO/sSYHh+FxiOvbOJgzvHambsFr?=
 =?us-ascii?Q?A50hD0O+HsfFOKs+A5fwUcEzDZRepSMYDDDO7tHrZIzpJh5BucJozwU2SVo2?=
 =?us-ascii?Q?6SZ+cFBzJUyi+wUiQyp0q3reDMcj8LNbStnJzeJAgxmrOSmqXOv1UhPagGNl?=
 =?us-ascii?Q?Ts2vdNRYtgzmWLjhBQkJEAIXLJdLBBEJ7Ukq0sm9SaV3qwU9bM6uCOz8a0sO?=
 =?us-ascii?Q?aHpah1UpCdg6ag7jVYyKu3CkoDI165itWonlqlt1Y0CDcQ+L4UimxPc3w/w8?=
 =?us-ascii?Q?XFBNgUdRlxePTehe+ty25WHNwcOX59tJ+coAXDOzdh5eT15ubpNhaGxv/f4W?=
 =?us-ascii?Q?WPyWJQ3AA0ivQB9hQmTd4As9V92F02bnJL7MK43kUnhiYu1AaHCyQI5rDPtm?=
 =?us-ascii?Q?wiqYnUOwZuW1LuEqkFKiXrveIMBWb7TfnstriOT8CGiEhuDTMzAjD7f1b4H1?=
 =?us-ascii?Q?NJopL8ljKn/YjSL4LcJ+RlJ471UNJJ6/kJ9nE3iNt1v2gb8rVlUae1X1VnDV?=
 =?us-ascii?Q?paopnFTQrV+dcRIpkD8Cw382ak6JOCbV5ONwT0m5YnWLwppjroHq5dH05nNe?=
 =?us-ascii?Q?MpLdq3jrDpF5UBGmFQ/Xp8ZiA18HYVBVijJHltDa/2efwoBAd3LwvfEckppF?=
 =?us-ascii?Q?VAkRdXE9BoDIJstPZs1Zl4UjgFr42A7ZHV00iK1IUblv7oaSKhklP2BM/In3?=
 =?us-ascii?Q?05abG+2THZYtSJKXcwQAH1W1FaKi2BeafalntfiH7g3s4YdD0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:48:08.3921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f000b2b4-17ef-4a20-0760-08dcee90ce67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Use the defer framework to schedule cleanups as soon as the command is
executed.

Note that the start_traffic commands in __burst_test() are each sending a
fixed number of packets (note the -c flag) and then ending. They therefore
do not need a matching stop_traffic.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../drivers/net/mlxsw/devlink_trap_policer.sh | 85 ++++++++-----------
 1 file changed, 36 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
index 0bd5ffc218ac..29a672c2270f 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/devlink_trap_policer.sh
@@ -45,63 +45,52 @@ source $lib_dir/devlink_lib.sh
 h1_create()
 {
 	simple_if_init $h1 192.0.2.1/24
+	defer simple_if_fini $h1 192.0.2.1/24
+
 	mtu_set $h1 10000
+	defer mtu_restore $h1
 
 	ip -4 route add default vrf v$h1 nexthop via 192.0.2.2
-}
-
-h1_destroy()
-{
-	ip -4 route del default vrf v$h1 nexthop via 192.0.2.2
-
-	mtu_restore $h1
-	simple_if_fini $h1 192.0.2.1/24
+	defer ip -4 route del default vrf v$h1 nexthop via 192.0.2.2
 }
 
 h2_create()
 {
 	simple_if_init $h2 198.51.100.1/24
+	defer simple_if_fini $h2 198.51.100.1/24
+
 	mtu_set $h2 10000
+	defer mtu_restore $h2
 
 	ip -4 route add default vrf v$h2 nexthop via 198.51.100.2
-}
-
-h2_destroy()
-{
-	ip -4 route del default vrf v$h2 nexthop via 198.51.100.2
-
-	mtu_restore $h2
-	simple_if_fini $h2 198.51.100.1/24
+	defer ip -4 route del default vrf v$h2 nexthop via 198.51.100.2
 }
 
 router_create()
 {
 	ip link set dev $rp1 up
+	defer ip link set dev $rp1 down
+
 	ip link set dev $rp2 up
+	defer ip link set dev $rp2 down
 
 	__addr_add_del $rp1 add 192.0.2.2/24
+	defer __addr_add_del $rp1 del 192.0.2.2/24
+
 	__addr_add_del $rp2 add 198.51.100.2/24
+	defer __addr_add_del $rp2 del 198.51.100.2/24
+
 	mtu_set $rp1 10000
+	defer mtu_restore $rp1
+
 	mtu_set $rp2 10000
+	defer mtu_restore $rp2
 
 	ip -4 route add blackhole 198.51.100.100
+	defer ip -4 route del blackhole 198.51.100.100
 
 	devlink trap set $DEVLINK_DEV trap blackhole_route action trap
-}
-
-router_destroy()
-{
-	devlink trap set $DEVLINK_DEV trap blackhole_route action drop
-
-	ip -4 route del blackhole 198.51.100.100
-
-	mtu_restore $rp2
-	mtu_restore $rp1
-	__addr_add_del $rp2 del 198.51.100.2/24
-	__addr_add_del $rp1 del 192.0.2.2/24
-
-	ip link set dev $rp2 down
-	ip link set dev $rp1 down
+	defer devlink trap set $DEVLINK_DEV trap blackhole_route action drop
 }
 
 setup_prepare()
@@ -114,7 +103,11 @@ setup_prepare()
 
 	rp1_mac=$(mac_get $rp1)
 
+	# Reload to ensure devlink-trap settings are back to default.
+	defer devlink_reload
+
 	vrf_prepare
+	defer vrf_cleanup
 
 	h1_create
 	h2_create
@@ -122,21 +115,6 @@ setup_prepare()
 	router_create
 }
 
-cleanup()
-{
-	pre_cleanup
-
-	router_destroy
-
-	h2_destroy
-	h1_destroy
-
-	vrf_cleanup
-
-	# Reload to ensure devlink-trap settings are back to default.
-	devlink_reload
-}
-
 rate_limits_test()
 {
 	RET=0
@@ -214,7 +192,10 @@ __rate_test()
 	# by the policer. Make sure measured received rate is about 1000 pps
 	log_info "=== Tx rate: Highest, Policer rate: 1000 pps ==="
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac
+	defer stop_traffic $!
 
 	sleep 5 # Take measurements when rate is stable
 
@@ -229,13 +210,16 @@ __rate_test()
 	check_err $? "Expected non-zero policer drop rate, got 0"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	# Send packets at a rate of 1000 pps and make sure they are not dropped
 	# by the policer
 	log_info "=== Tx rate: 1000 pps, Policer rate: 1000 pps ==="
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac -d 1msec
+	defer stop_traffic $!
 
 	sleep 5 # Take measurements when rate is stable
 
@@ -244,7 +228,7 @@ __rate_test()
 	check_err $? "Expected zero policer drop rate, got a drop rate of $drop_rate pps"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	# Unbind the policer and send packets at highest possible rate. Make
 	# sure they are not dropped by the policer and that the measured
@@ -253,7 +237,10 @@ __rate_test()
 
 	devlink trap group set $DEVLINK_DEV group l3_drops nopolicer
 
+	defer_scope_push
+
 	start_traffic $h1 192.0.2.1 198.51.100.100 $rp1_mac
+	defer stop_traffic $!
 
 	rate=$(trap_rate_get)
 	(( rate > 1000 ))
@@ -265,7 +252,7 @@ __rate_test()
 	check_err $? "Expected zero policer drop rate, got a drop rate of $drop_rate pps"
 	log_info "Measured policer drop rate of $drop_rate pps"
 
-	stop_traffic
+	defer_scope_pop
 
 	log_test "Trap policer rate"
 }
-- 
2.45.0


