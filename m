Return-Path: <linux-kselftest+bounces-12862-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9A991A9D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C377A1C22565
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C719923D;
	Thu, 27 Jun 2024 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oFJMBYXy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A83198A04;
	Thu, 27 Jun 2024 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499833; cv=fail; b=oB6eenV1UbZP0FAZU4Is8R4NSkScshWr7Lq4pe5mKFaLCiDH/9pL9ENpg0tzN3lhc8EkjxMCtxfcXd4OtWKAXqiUYF7XT8BscLCqRDnN4K7RY7fexzsyHxjWP+Z/Tbrin+UPBCIXP2n+zkIe016Ni8cGdvZRa5sR+Nx7p+ZuvWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499833; c=relaxed/simple;
	bh=iDxezbEXrNU38vvjLYqT6/ktYQDkunY2UTPN8gKompA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUJ4KQzCb0vGjJXgQT+CCf9hf3DU8h58uJtbEPlgI4eADkjbE7THsyn7ARUvSBj4gxCW5bhNiyZr8Nr666FLp/7qMRugxeFyPAtZ4/iYpcSldRMHihiBow1VkRdL33TdT6vySo9c0gn2Zti+YRLmwo3riA41YQXWkV87QQ4SWgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oFJMBYXy; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j944HSGGZyxK3kUA0VADatNwh4d4MRh7DCGDMxItlOonfq3NQ1RAaWjberaKIr+3woB21AAQiKr4jepCrpEbU3zCpMPXjO1K1De6GEd9iqttzQQl6uWYvwNcWPhtinfC3EEdOQ+AoLMFmmCwenZArs9IQYSfMNbM45Qyw8jDIk+oPJpKT/g1gh5GAi1qPRysJRnf1c28a6eolfRtKqZbbSVjIdm9O+QPTTCGdiT6elTJjq9ZTyn+1Zn1t4Ev2/J3r/GDyqnnudh/DuNTcj0WXZAwSDRvjcqapBIQk2xlXGWonxDzZRB5mCmWX3vBSNcw+v/OEGjgXJxPy/POI/BadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4dy/ePcL/Oih6dbpuz6kKJZBKotNDZwC+rQ0IorWrg=;
 b=TRzZ/b6lWjjbAMtXK8yufBAgVF3q0AKKYx0TqQHNrdQTbwd8hrdv2cduRaP3eV8jATIcxSkQB1/3Mm7poWn3Bzo4YmuOf3K2gy08VeTwmm00Bgo0gg9leanSZ6Tc8sP/1iZo5H+qYLat9+tOUsMyNYNvwogWRSuutlxVUSILwdWfoIVW9PeBElyVRZ+w5VOeCmlA4T04u676OiR1MM3FN43tWzq4QJae+Tfngok2vPdRXmrp3YB37wNG7jpzVjkXJ+WLDvUR6J12URfiPJ/L1GT3ON3K+E8Frjn65njDYV2h7vNSSzzXTJPLl9BqJEcoPn6H7wb5JRrqhes6/J21dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=temperror action=none header.from=nvidia.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4dy/ePcL/Oih6dbpuz6kKJZBKotNDZwC+rQ0IorWrg=;
 b=oFJMBYXyOXKAOg+bKaRaQCu3ZdW9+ZUklvHlExJF7ml4ZZAvkoyXQHirzFh74wlNlB+YhJBNfCFEmyY2B4aylmjZN9b4qanr06QeY7CAjcWPpTOKwpboxeQx3ZLX7G74rEMVbWkj/XbTBnouaDka9cS6jFlUNO1IolQTXZwAKZtL9G28Jh9XH15dkPzlHFC40Sc72co6AvDbEkh4xhs8aYD3rsbcX3yizrUHQ6kC/UcJgv3gtg73bue1InZHeLVH9PpSKt/WV/a61Zz+IcCTtG9FWIDlpx1DhNnA3Te4CF61Qo8Ek/5AKmWAHlnIRUob11LBBl/P9q7ZESIH7l83Hg==
Received: from MW4PR04CA0227.namprd04.prod.outlook.com (2603:10b6:303:87::22)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:50:18 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:87:cafe::1a) by MW4PR04CA0227.outlook.office365.com
 (2603:10b6:303:87::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=nvidia.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nvidia.com: DNS Timeout)
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:06 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:50:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 07/12] selftests: mirror: Drop dual SW/HW testing
Date: Thu, 27 Jun 2024 16:48:44 +0200
Message-ID: <f2380d15027c3c14670f37a37d89a35565e50095.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1719497773.git.petrm@nvidia.com>
References: <cover.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9fceb3-b482-4575-5004-08dc96b875cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R19IeaAsoCeHCOktUDIwBMMkFx9cibu6QZeXT3btkQlnQkVQv4jCmJK716S9?=
 =?us-ascii?Q?A/51KcErIh4R7kuBZzsOhfZA6UEMyGEO2LQHOFpPZCppYlcPBaPNFQD0TnVz?=
 =?us-ascii?Q?7FtTA0pgMz1egbBxK/yDH/NhQsD5/7JLYNe7d5fnm5/NZ/Ekp7AQmgdKp5L2?=
 =?us-ascii?Q?CdtYIBldpf1AuEkus3bweBErGu41dRZqVO3zn0GTWCqljB7sr7xgifZvn0CI?=
 =?us-ascii?Q?4h0Zbs4YevOoHgRVy08OHEtBjIA0CR33kF8DXuie+SqNegptClj5phhIgJ6O?=
 =?us-ascii?Q?T1CJSoS9lFKUCXp8eUyk6gdi7hQ0fp72qj1U9+HS95JBMb/UOhdOo9LAsUnV?=
 =?us-ascii?Q?Df5Yu1ZWJ5eGyyw4jjgFkPWQn6xljKiwNNHn/tHx5LOmbg6zGtlrGfE2PE+L?=
 =?us-ascii?Q?NPZ6xvrKT/kYT95qWdxry41kFZmxHlk7BoAuE6BR6cZHXab7XqQNDPvf9/Qc?=
 =?us-ascii?Q?WL5f5tP3zQj+ycMqi9NghgGYoKWlRf+UKSNNVK0iA2+Inw+RRR4FxLMutfU8?=
 =?us-ascii?Q?/uO1ypEC7ebAKakGPwMaoU37r/RfoNobtAS5r4g3eejlUXsZoGh5ZjmtN+R/?=
 =?us-ascii?Q?XD7DAYKPZiYeuwfcP4OWy8J4xfbl1rRl7XsyLa9vB3KSdXOT1fJ/H5G9zhan?=
 =?us-ascii?Q?Gis8h52ziBo1+hMsuLSSspJ0I38f7oHl8jN/n43TDflNxL5nLr9jpsEgQD5D?=
 =?us-ascii?Q?QqYCJWDAsHUmmFI+Xz0jxjS1y3vG4vvrGjtuFscGtXrqb32wTJCMxNoq3ON+?=
 =?us-ascii?Q?AA23QpGyvZnYJ1QjoQbKf5oGXiiCc29hed1dDai/O1IIG/ekRYHP5mSO6NA6?=
 =?us-ascii?Q?YJIBBm63YWI2BBy9kdtRTrTPlT0LQFgTrBUGv9D4/gxuw0JostetTlcIHnRi?=
 =?us-ascii?Q?oh6qv5uwgzBBcOKhmc2KU9VA2pUMBEYoI0BlHlMb8Om9pkA6pjfs91Lto/hi?=
 =?us-ascii?Q?jgyLN6GSz7RndCOo9VzlznsboA6jr7+sEYQ7KFtNZ/qSVZIjsGQpAaYqlN6O?=
 =?us-ascii?Q?St7NnpdgXR7d/g+0VUvV2aiOtKBXtgOYEXQi+HH91W2gEYIKfuu6YfOEWTzc?=
 =?us-ascii?Q?Gz3mN7HbSx11WfUAEW8l4B4MbhoMMGtrildrJtO5Trp0UNK9lnrjw2Kfusyj?=
 =?us-ascii?Q?eDIGlmuG9JLyX5gDuIArK6seiXUWZVyJD0Nd41pXPj2P6c9QyJKLKMS7JXyP?=
 =?us-ascii?Q?FHqbfU+Fv7wlTy1Z8tnInGjHjXiE+XpGcn0u8kSMr0sWOdObJMDk0BVfxacc?=
 =?us-ascii?Q?ERHW9FIgaqkQ9HkEb53YokWsq5n77ubtDPv7UKoxoVxKBd+trl7B17CVMRo7?=
 =?us-ascii?Q?LxxWK+PYYvdRB+V9uHgloPfUoih13PLJlG8fNQ/nnebOrkI0wy7dqEmpvJyy?=
 =?us-ascii?Q?hxX8S27BDx6gnXLkEA2RHMe0qcf3/cqdv27Drz2s3BrxN/5nYbViww6srLOu?=
 =?us-ascii?Q?LF5AW3gpb/z2lgZN0T80QyltNURKYNcV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:17.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9fceb3-b482-4575-5004-08dc96b875cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407

The mirroring tests are currently run in a skip_hw and optionally a skip_sw
mode. The former tests the SW datapath, the latter the HW datapath, if
available. In order to be able to test SW datapath on HW loopbacks, traps
are installed on ingress to get traffic from the HW datapath to the SW one.
This adds an unnecessary complexity when it would be much simpler to just
use a veth-based topology to test the SW datapath. Thus drop all the code
that supports this dual testing.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/mirror_gre.sh | 33 +++----------
 .../drivers/net/mlxsw/mirror_gre_scale.sh     | 18 +------
 .../selftests/net/forwarding/mirror_gre.sh    | 33 +++----------
 .../net/forwarding/mirror_gre_bound.sh        | 23 +--------
 .../net/forwarding/mirror_gre_bridge_1d.sh    | 21 +--------
 .../forwarding/mirror_gre_bridge_1d_vlan.sh   | 21 +--------
 .../net/forwarding/mirror_gre_bridge_1q.sh    | 21 +--------
 .../forwarding/mirror_gre_bridge_1q_lag.sh    | 27 ++---------
 .../net/forwarding/mirror_gre_changes.sh      | 47 ++++++-------------
 .../net/forwarding/mirror_gre_flower.sh       | 25 ++--------
 .../net/forwarding/mirror_gre_lag_lacp.sh     | 25 ++--------
 .../net/forwarding/mirror_gre_lib.sh          | 12 ++---
 .../net/forwarding/mirror_gre_neigh.sh        | 25 ++--------
 .../selftests/net/forwarding/mirror_gre_nh.sh | 29 ++----------
 .../net/forwarding/mirror_gre_vlan.sh         | 21 +--------
 .../forwarding/mirror_gre_vlan_bridge_1q.sh   | 39 ++++-----------
 .../selftests/net/forwarding/mirror_vlan.sh   | 35 ++++----------
 17 files changed, 77 insertions(+), 378 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
index 47be3b269088..8cf06fcd724c 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre.sh
@@ -118,7 +118,7 @@ test_span_gre_ttl_inherit()
 	RET=0
 
 	ip link set dev $tundev type $type ttl inherit
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type ttl 100
@@ -126,7 +126,7 @@ test_span_gre_ttl_inherit()
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: no offload on TTL of inherit ($tcflags)"
+	log_test "$what: no offload on TTL of inherit"
 }
 
 test_span_gre_tos_fixed()
@@ -138,14 +138,14 @@ test_span_gre_tos_fixed()
 	RET=0
 
 	ip link set dev $tundev type $type tos 0x10
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type tos inherit
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: no offload on a fixed TOS ($tcflags)"
+	log_test "$what: no offload on a fixed TOS"
 }
 
 test_span_failable()
@@ -156,7 +156,7 @@ test_span_failable()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	if ((should_fail)); then
 	    fail_test_span_gre_dir  $tundev
 	else
@@ -164,7 +164,7 @@ test_span_failable()
 	fi
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: should_fail=$should_fail ($tcflags)"
+	log_test "$what: should_fail=$should_fail"
 }
 
 test_failable()
@@ -175,17 +175,6 @@ test_failable()
 	test_span_failable $should_fail gt6-soft "mirror to gretap w/ soft underlay"
 }
 
-test_sw()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	test_failable 0
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 test_hw()
 {
 	test_failable 1
@@ -202,16 +191,6 @@ trap cleanup EXIT
 setup_prepare
 setup_wait
 
-if ! tc_offload_check; then
-    check_err 1 "Could not test offloaded functionality"
-    log_test "mlxsw-specific tests for mirror to gretap"
-    exit
-fi
-
-tcflags="skip_hw"
-test_sw
-
-tcflags="skip_sw"
 test_hw
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre_scale.sh
index e5589e2fca85..d43093310e23 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/mirror_gre_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/mirror_gre_scale.sh
@@ -79,7 +79,7 @@ mirror_gre_tunnels_create()
 		cat >> $MIRROR_GRE_BATCH_FILE <<-EOF
 			filter add dev $swp1 ingress pref 1000 \
 				protocol ipv6 \
-				flower $tcflags dst_ip $match_dip \
+				flower skip_sw dst_ip $match_dip \
 				action mirred egress mirror dev $tun
 		EOF
 	done
@@ -107,7 +107,7 @@ mirror_gre_tunnels_destroy()
 	done
 }
 
-__mirror_gre_test()
+mirror_gre_test()
 {
 	local count=$1; shift
 	local should_fail=$1; shift
@@ -131,20 +131,6 @@ __mirror_gre_test()
 	done
 }
 
-mirror_gre_test()
-{
-	local count=$1; shift
-	local should_fail=$1; shift
-
-	if ! tc_offload_check $TC_FLOWER_NUM_NETIFS; then
-		check_err 1 "Could not test offloaded functionality"
-		return
-	fi
-
-	tcflags="skip_sw"
-	__mirror_gre_test $count $should_fail
-}
-
 mirror_gre_setup_prepare()
 {
 	h1=${NETIFS[p1]}
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre.sh b/tools/testing/selftests/net/forwarding/mirror_gre.sh
index b645cb8d696a..921c733ee04f 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre.sh
@@ -74,7 +74,7 @@ test_span_gre_mac()
 
 	RET=0
 
-	mirror_install $swp1 $direction $tundev "matchall $tcflags"
+	mirror_install $swp1 $direction $tundev "matchall"
 	icmp_capture_install h3-${tundev} "src_mac $src_mac dst_mac $dst_mac"
 
 	mirror_test v$h1 192.0.2.1 192.0.2.2 h3-${tundev} 100 10
@@ -82,15 +82,15 @@ test_span_gre_mac()
 	icmp_capture_uninstall h3-${tundev}
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction $what: envelope MAC ($tcflags)"
+	log_test "$direction $what: envelope MAC"
 }
 
 test_two_spans()
 {
 	RET=0
 
-	mirror_install $swp1 ingress gt4 "matchall $tcflags"
-	mirror_install $swp1 egress gt6 "matchall $tcflags"
+	mirror_install $swp1 ingress gt4 "matchall"
+	mirror_install $swp1 egress gt6 "matchall"
 	quick_test_span_gre_dir gt4 8 0
 	quick_test_span_gre_dir gt6 0 8
 
@@ -98,13 +98,13 @@ test_two_spans()
 	fail_test_span_gre_dir gt4 8 0
 	quick_test_span_gre_dir gt6 0 8
 
-	mirror_install $swp1 ingress gt4 "matchall $tcflags"
+	mirror_install $swp1 ingress gt4 "matchall"
 	mirror_uninstall $swp1 egress
 	quick_test_span_gre_dir gt4 8 0
 	fail_test_span_gre_dir gt6 0 8
 
 	mirror_uninstall $swp1 ingress
-	log_test "two simultaneously configured mirrors ($tcflags)"
+	log_test "two simultaneously configured mirrors"
 }
 
 test_gretap()
@@ -131,30 +131,11 @@ test_ip6gretap_mac()
 	test_span_gre_mac gt6 egress "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bound.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bound.sh
index 6c257ec03756..e3cd48e18eeb 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bound.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bound.sh
@@ -196,32 +196,11 @@ test_ip6gretap()
 	full_test_span_gre_dir gt6 egress  0 8 "mirror to ip6gretap w/ UL"
 }
 
-test_all()
-{
-	RET=0
-
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
index 04fd14b0a9b7..6c7bd33332c2 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
@@ -108,30 +108,11 @@ test_ip6gretap()
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
index f35313c76fac..909ec956a5e5 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d_vlan.sh
@@ -104,30 +104,11 @@ test_ip6gretap_stp()
 	full_test_span_gre_stp gt6 $swp3.555 "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
index 0cf4c47a46f9..40ac9dd3aff1 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
@@ -104,30 +104,11 @@ test_ip6gretap()
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
 
-tests()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-tests
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	tests
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
index b719d24a4ae5..fe4d7c906a70 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q_lag.sh
@@ -227,10 +227,10 @@ test_lag_slave()
 	RET=0
 
 	tc filter add dev $swp1 ingress pref 999 \
-		proto 802.1q flower vlan_ethtype arp $tcflags \
+		proto 802.1q flower vlan_ethtype arp \
 		action pass
 	mirror_install $swp1 ingress gt4 \
-		"proto 802.1q flower vlan_id 333 $tcflags"
+		"proto 802.1q flower vlan_id 333"
 
 	# Test connectivity through $up_dev when $down_dev is set down.
 	ip link set dev $down_dev down
@@ -252,7 +252,7 @@ test_lag_slave()
 	mirror_uninstall $swp1 ingress
 	tc filter del dev $swp1 ingress pref 999
 
-	log_test "$what ($tcflags)"
+	log_test "$what"
 }
 
 test_mirror_gretap_first()
@@ -265,30 +265,11 @@ test_mirror_gretap_second()
 	test_lag_slave $h4 $swp4 $swp3 "mirror to gretap: LAG second slave"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
index b57fb9f069f4..65ae9d960c18 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_changes.sh
@@ -73,7 +73,7 @@ test_span_gre_ttl()
 	RET=0
 
 	mirror_install $swp1 ingress $tundev \
-		"prot ip flower $tcflags ip_prot icmp"
+		"prot ip flower ip_prot icmp"
 	tc filter add dev $h3 ingress pref 77 prot $prot \
 		flower skip_hw ip_ttl 50 action pass
 
@@ -87,7 +87,7 @@ test_span_gre_ttl()
 	tc filter del dev $h3 ingress pref 77
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: TTL change ($tcflags)"
+	log_test "$what: TTL change"
 }
 
 test_span_gre_tun_up()
@@ -98,7 +98,7 @@ test_span_gre_tun_up()
 	RET=0
 
 	ip link set dev $tundev down
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev up
@@ -106,7 +106,7 @@ test_span_gre_tun_up()
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: tunnel down/up ($tcflags)"
+	log_test "$what: tunnel down/up"
 }
 
 test_span_gre_egress_up()
@@ -118,7 +118,7 @@ test_span_gre_egress_up()
 	RET=0
 
 	ip link set dev $swp3 down
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	fail_test_span_gre_dir $tundev
 
 	# After setting the device up, wait for neighbor to get resolved so that
@@ -130,7 +130,7 @@ test_span_gre_egress_up()
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: egress down/up ($tcflags)"
+	log_test "$what: egress down/up"
 }
 
 test_span_gre_remote_ip()
@@ -144,14 +144,14 @@ test_span_gre_remote_ip()
 	RET=0
 
 	ip link set dev $tundev type $type remote $wrong_ip
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	fail_test_span_gre_dir $tundev
 
 	ip link set dev $tundev type $type remote $correct_ip
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: remote address change ($tcflags)"
+	log_test "$what: remote address change"
 }
 
 test_span_gre_tun_del()
@@ -165,7 +165,7 @@ test_span_gre_tun_del()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 	ip link del dev $tundev
 	fail_test_span_gre_dir $tundev
@@ -176,11 +176,11 @@ test_span_gre_tun_del()
 	# Recreating the tunnel doesn't reestablish mirroring, so reinstall it
 	# and verify it works for the follow-up tests.
 	mirror_uninstall $swp1 ingress
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: tunnel deleted ($tcflags)"
+	log_test "$what: tunnel deleted"
 }
 
 test_span_gre_route_del()
@@ -192,7 +192,7 @@ test_span_gre_route_del()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 
 	ip route del $route dev $edev
@@ -203,7 +203,7 @@ test_span_gre_route_del()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: underlay route removal ($tcflags)"
+	log_test "$what: underlay route removal"
 }
 
 test_ttl()
@@ -244,30 +244,11 @@ test_route_del()
 	test_span_gre_route_del gt6 $swp3 2001:db8:2::/64 "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
index c7d532e6f31e..3a84f3ab5856 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_flower.sh
@@ -91,7 +91,7 @@ full_test_span_gre_dir_acl()
 	RET=0
 
 	mirror_install $swp1 $direction $tundev \
-		       "protocol ip flower $tcflags dst_ip $match_dip"
+		       "protocol ip flower dst_ip $match_dip"
 	fail_test_span_gre_dir $tundev
 	test_span_gre_dir_acl "$tundev" "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
@@ -99,7 +99,7 @@ full_test_span_gre_dir_acl()
 	# Test lack of mirroring after ACL mirror is uninstalled.
 	fail_test_span_gre_dir_acl "$tundev"
 
-	log_test "$direction $what ($tcflags)"
+	log_test "$direction $what"
 }
 
 test_gretap()
@@ -114,30 +114,11 @@ test_ip6gretap()
 	full_test_span_gre_dir_acl gt6 egress 0 8 192.0.2.3 "ACL mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
index f521648682bf..1e4f0887724d 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
@@ -223,7 +223,7 @@ test_lag_slave()
 	RET=0
 
 	mirror_install $swp1 ingress gt4 \
-		       "proto 802.1q flower vlan_id 333 $tcflags"
+		       "proto 802.1q flower vlan_id 333"
 	vlan_capture_install gt4-dst "vlan_ethtype ipv4 ip_proto icmp type 8"
 
 	# Move $down_dev away from the team. That will prompt change in
@@ -250,7 +250,7 @@ test_lag_slave()
 	# Wait for ${h,swp}{3,4}.
 	setup_wait
 
-	log_test "$what ($tcflags)"
+	log_test "$what"
 }
 
 test_mirror_gretap_first()
@@ -263,30 +263,11 @@ test_mirror_gretap_second()
 	test_lag_slave $h4 $h3 "mirror to gretap: LAG second slave"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
index cc3a0a3f83ba..aa96644e3866 100644
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lib.sh
@@ -47,12 +47,12 @@ full_test_span_gre_dir_ips()
 
 	RET=0
 
-	mirror_install $swp1 $direction $tundev "matchall $tcflags"
+	mirror_install $swp1 $direction $tundev "matchall"
 	test_span_dir_ips "h3-$tundev" "$forward_type" \
 			  "$backward_type" "$ip1" "$ip2"
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction $what ($tcflags)"
+	log_test "$direction $what"
 }
 
 full_test_span_gre_dir_vlan_ips()
@@ -68,7 +68,7 @@ full_test_span_gre_dir_vlan_ips()
 
 	RET=0
 
-	mirror_install $swp1 $direction $tundev "matchall $tcflags"
+	mirror_install $swp1 $direction $tundev "matchall"
 
 	test_span_dir_ips "h3-$tundev" "$forward_type" \
 			  "$backward_type" "$ip1" "$ip2"
@@ -81,7 +81,7 @@ full_test_span_gre_dir_vlan_ips()
 
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction $what ($tcflags)"
+	log_test "$direction $what"
 }
 
 quick_test_span_gre_dir()
@@ -151,7 +151,7 @@ full_test_span_gre_stp_ips()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir_ips $tundev $ip1 $ip2 \
 				    "$forward_type" "$backward_type"
 
@@ -166,7 +166,7 @@ full_test_span_gre_stp_ips()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: STP state ($tcflags)"
+	log_test "$what: STP state"
 }
 
 full_test_span_gre_stp()
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
index 0615f9244406..2cbfbecf25c8 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_neigh.sh
@@ -67,13 +67,13 @@ test_span_gre_neigh()
 	RET=0
 
 	ip neigh replace dev $swp3 $addr lladdr 00:11:22:33:44:55
-	mirror_install $swp1 $direction $tundev "matchall $tcflags"
+	mirror_install $swp1 $direction $tundev "matchall"
 	fail_test_span_gre_dir $tundev "$forward_type" "$backward_type"
 	ip neigh del dev $swp3 $addr
 	quick_test_span_gre_dir $tundev "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction $what: neighbor change ($tcflags)"
+	log_test "$direction $what: neighbor change"
 }
 
 test_gretap()
@@ -88,30 +88,11 @@ test_ip6gretap()
 	test_span_gre_neigh 2001:db8:2::2 gt6 egress 0 8 "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh b/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
index 2011dad06cf4..34bc646938e3 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_nh.sh
@@ -75,7 +75,7 @@ cleanup()
 test_gretap()
 {
 	RET=0
-	mirror_install $swp1 ingress gt4 "matchall $tcflags"
+	mirror_install $swp1 ingress gt4 "matchall"
 
 	# For IPv4, test that there's no mirroring without the route directing
 	# the traffic to tunnel remote address. Then add it and test that
@@ -88,29 +88,18 @@ test_gretap()
 	ip route del 192.0.2.130/32 via 192.0.2.162
 
 	mirror_uninstall $swp1 ingress
-	log_test "mirror to gre with next-hop remote ($tcflags)"
+	log_test "mirror to gre with next-hop remote"
 }
 
 test_ip6gretap()
 {
 	RET=0
 
-	mirror_install $swp1 ingress gt6 "matchall $tcflags"
+	mirror_install $swp1 ingress gt6 "matchall"
 	quick_test_span_gre_dir gt6
 	mirror_uninstall $swp1 ingress
 
-	log_test "mirror to ip6gre with next-hop remote ($tcflags)"
-}
-
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
+	log_test "mirror to ip6gre with next-hop remote"
 }
 
 trap cleanup EXIT
@@ -118,14 +107,6 @@ trap cleanup EXIT
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan.sh
index 88cecdb9a861..63689928cb51 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan.sh
@@ -63,30 +63,11 @@ test_gretap()
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
index b49b70416e32..1b902cc579f6 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_vlan_bridge_1q.sh
@@ -153,7 +153,7 @@ test_span_gre_forbidden_cpu()
 	RET=0
 
 	# Run the pass-test first, to prime neighbor table.
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 
 	# Now forbid the VLAN at the bridge and see it fail.
@@ -167,7 +167,7 @@ test_span_gre_forbidden_cpu()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: vlan forbidden at a bridge ($tcflags)"
+	log_test "$what: vlan forbidden at a bridge"
 }
 
 test_gretap_forbidden_cpu()
@@ -187,7 +187,7 @@ test_span_gre_forbidden_egress()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 
 	bridge vlan del dev $swp3 vid 555
@@ -202,7 +202,7 @@ test_span_gre_forbidden_egress()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: vlan forbidden at a bridge egress ($tcflags)"
+	log_test "$what: vlan forbidden at a bridge egress"
 }
 
 test_gretap_forbidden_egress()
@@ -223,7 +223,7 @@ test_span_gre_untagged_egress()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 
 	quick_test_span_gre_dir $tundev
 	quick_test_span_vlan_dir $h3 555 "$ul_proto"
@@ -246,7 +246,7 @@ test_span_gre_untagged_egress()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: vlan untagged at a bridge egress ($tcflags)"
+	log_test "$what: vlan untagged at a bridge egress"
 }
 
 test_gretap_untagged_egress()
@@ -267,7 +267,7 @@ test_span_gre_fdb_roaming()
 
 	RET=0
 
-	mirror_install $swp1 ingress $tundev "matchall $tcflags"
+	mirror_install $swp1 ingress $tundev "matchall"
 	quick_test_span_gre_dir $tundev
 
 	while ((RET == 0)); do
@@ -279,7 +279,7 @@ test_span_gre_fdb_roaming()
 		if ! bridge fdb sh dev $swp2 vlan 555 master \
 		    | grep -q $h3mac; then
 			printf "TEST: %-60s  [RETRY]\n" \
-				"$what: MAC roaming ($tcflags)"
+				"$what: MAC roaming"
 			# ARP or ND probably reprimed the FDB while the test
 			# was running. We would get a spurious failure.
 			RET=0
@@ -296,7 +296,7 @@ test_span_gre_fdb_roaming()
 
 	mirror_uninstall $swp1 ingress
 
-	log_test "$what: MAC roaming ($tcflags)"
+	log_test "$what: MAC roaming"
 }
 
 test_gretap_fdb_roaming()
@@ -319,30 +319,11 @@ test_ip6gretap_stp()
 	full_test_span_gre_stp gt6 $swp3 "mirror to ip6gretap"
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-
-	tests_run
-
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
diff --git a/tools/testing/selftests/net/forwarding/mirror_vlan.sh b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
index bc3297846511..2f150a414d38 100755
--- a/tools/testing/selftests/net/forwarding/mirror_vlan.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_vlan.sh
@@ -40,12 +40,16 @@ setup_prepare()
 
 	vlan_create $h2 111 v$h2 192.0.2.18/28
 	bridge vlan add dev $swp2 vid 111
+
+	trap_install $h3 ingress
 }
 
 cleanup()
 {
 	pre_cleanup
 
+	trap_uninstall $h3 ingress
+
 	vlan_destroy $h2 111
 	vlan_destroy $h1 111
 	vlan_destroy $h3 555
@@ -63,11 +67,11 @@ test_vlan_dir()
 
 	RET=0
 
-	mirror_install $swp1 $direction $swp3.555 "matchall $tcflags"
+	mirror_install $swp1 $direction $swp3.555 "matchall"
 	test_span_dir "$h3.555" "$forward_type" "$backward_type"
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction mirror to vlan ($tcflags)"
+	log_test "$direction mirror to vlan"
 }
 
 test_vlan()
@@ -84,12 +88,12 @@ test_tagged_vlan_dir()
 
 	RET=0
 
-	mirror_install $swp1 $direction $swp3.555 "matchall $tcflags"
+	mirror_install $swp1 $direction $swp3.555 "matchall"
 	do_test_span_vlan_dir_ips '>= 10' "$h3.555" 111 ip 192.0.2.17 192.0.2.18
 	do_test_span_vlan_dir_ips  0 "$h3.555" 555 ip 192.0.2.17 192.0.2.18
 	mirror_uninstall $swp1 $direction
 
-	log_test "$direction mirror tagged to vlan ($tcflags)"
+	log_test "$direction mirror tagged to vlan"
 }
 
 test_tagged_vlan()
@@ -98,32 +102,11 @@ test_tagged_vlan()
 	test_tagged_vlan_dir egress 0 8
 }
 
-test_all()
-{
-	slow_path_trap_install $swp1 ingress
-	slow_path_trap_install $swp1 egress
-	trap_install $h3 ingress
-
-	tests_run
-
-	trap_uninstall $h3 ingress
-	slow_path_trap_uninstall $swp1 egress
-	slow_path_trap_uninstall $swp1 ingress
-}
-
 trap cleanup EXIT
 
 setup_prepare
 setup_wait
 
-tcflags="skip_hw"
-test_all
-
-if ! tc_offload_check; then
-	echo "WARN: Could not test offloaded functionality"
-else
-	tcflags="skip_sw"
-	test_all
-fi
+tests_run
 
 exit $EXIT_STATUS
-- 
2.45.0


