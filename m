Return-Path: <linux-kselftest+bounces-12858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3745491A9C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9156281C41
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6407D1991D7;
	Thu, 27 Jun 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AwEpss1a"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A8D198828;
	Thu, 27 Jun 2024 14:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499807; cv=fail; b=r5D87bA7FafxI8lUMfc2I/xbXj7VIfzdjp6zRfDlQakhxuIYuBjgoXneOzAfEXgWD/E8+m4rSWp8P2GcPTRKLOQcT8SsrfMJlf2lFjfWWtJKpXjipW22SMlIOBwhHvUc9aMtvKXaNO3h8rqfX2Y4gJQjvRUqLxZkaFLec25/OVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499807; c=relaxed/simple;
	bh=1BjHwPmL8fvoM1tpzSt8+Bto1/LmiGAQK3d8DndtU48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DV+eF2VotIK9NC62STFIlhtyDziqJU/R30B9KQU/17OjDD/QUpfdPPrhOkub5435ClBHytUuTxA8m3V22TznLTbOBGgdq0HAWt5EEIauRL8KDrcg9f9BlfVUeK4SdpQlbw0RcVYkRrcWZqVvh9qU2Q64fQ9inx9OuAJ7fqInV64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AwEpss1a; arc=fail smtp.client-ip=40.107.94.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sv5WlgiJoMoO5DWrum/FgbL2/awOWZCtkbgYcN8Rm3un1HnfmKumz6WkyWbNs0xKRloc0/uVfW2CGlAaz/xhohvQiZPNGex/ZPfLq/CVYlYHKlLU0MhE89L90RuvEEYL+hB0K/HlpN1/+/4dEyhyTw3CvQv46xmvFjNL/QeGVctFLEk5whNQKs1E3EdTTUiIjkp4Iuerg/RcoMho6pUY2MANMtcBgg+GmUNYWrus4Zkcx3fTszfDVgcod43t2KRA3hM0ZR6QHSmFBcTtdgdrx5rhXyOH55LLrOuhuH3eph4i3cSxvfNkcas+d7/qLf76iieNSoaG7+qZHkpHo3FyuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZsLAkPU+gS/0LN29X3WN+YZg0pJDDg+8IDmqYdaPUk=;
 b=MTzutjGGceiIFIJNoNptKbudLUmae2E7WKFi+TOy9150BfJwN68vmq6CKqdc55WIaFVbJJkKLGQ4PzmU4t/BNXFj2as97QEQ/PhLAaPM+2+HRzfuHRitYJHaeG2sUJlORDnZ0CCGAuuqCg9i70EC1fIvkPn3skEyWxh7mtoH7+XacW5JevccCJOHCLJ7rilRIlS38+dDqkmyP2VNW18fkEvu4p8ptPzMyv+SUW5/WrVQgHJ8jlRK9GFRJMKiR53zv0BD52CI92CclK3cxFx/FPJKGs80qw+ni6nwobYR9xUUpWwNtp8FPzmwqiIIJLfHbNCwN/CeHrSKicKDxARXBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZsLAkPU+gS/0LN29X3WN+YZg0pJDDg+8IDmqYdaPUk=;
 b=AwEpss1aedvq1UzQDZWIGFtfD5dHd1P3eEOC+r6Eaw5VGlXp6j7X0tlenqr66T6WqEkP4U//aGDeI39qJ9tr/84ajXfwCqtqZNgZ7ViVTZmOcF8hCt2iL5o13Xt0aJMhH+Cqbisg0fZDuyai94LBR3WKQBhqfk44G1nL8UpuQxt7lzvoCZ6BRLzaLIvr9bU3/Z6jW3ph7hg44Y9pGaq7zCa/22tSDbU3YvpVxUiICkwYsCdF6iE8sUFA1dQ5QxETXB5+IP+x+wqw7NX8f8jsAhc5BciqJoiD0rXrvhaKjXK5nXwF1ibM6aNuKQmd3Kw7h0RQ7zFVcRilVqxFMaRZTw==
Received: from BY5PR16CA0029.namprd16.prod.outlook.com (2603:10b6:a03:1a0::42)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 14:50:02 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::5b) by BY5PR16CA0029.outlook.office365.com
 (2603:10b6:a03:1a0::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26 via Frontend
 Transport; Thu, 27 Jun 2024 14:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:50:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:48 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 04/12] selftests: mirror_gre_lag_lacp: Check counters at tunnel
Date: Thu, 27 Jun 2024 16:48:41 +0200
Message-ID: <06fbe94a8526cc770fa19bb30ade85c9534f1e8d.1719497773.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: c1a84bc5-bdfc-4ff3-ba3b-08dc96b86c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VrEcUz4Nbgcl//fUvnjrWy3hd8ZEAcG2/g+kfmZJ1SL/Ew/b9YPmbyuf2ta6?=
 =?us-ascii?Q?QDPSYB/z6pY2/e5ib0PIBrzlllt+AyBQgFsnDkFmhm46yHpNO+AK+FFq7kie?=
 =?us-ascii?Q?MgW9YVXfKK5EnTOCj9Zf/KBiaT3sZTnMOVrm96rfeeqKi9OaWcEHLCdB+LTm?=
 =?us-ascii?Q?o+k2R7Iu65FrfA4fMTZoIm3YHpjVjcY87Cf87G4/J26HR5beUK1Lz5uMUemJ?=
 =?us-ascii?Q?sxuQVAz2PEISLi6yRjSzVUh3P2qeNiukMAjtzbgRN2n5QoS4L4kj+Cm2j7f7?=
 =?us-ascii?Q?14VK3dEBPd3CaFgGMvOe4IOD2kuzGHXxrk7nsj5uSfDu9u2Tg/OHmep02zsY?=
 =?us-ascii?Q?gEJyAb05fPZTz0LdCLaa3jnyJ0eUYxASIm9VfWsxE2bpDdN4nHb3ckFzJ5Tl?=
 =?us-ascii?Q?zTCUu2cT6m23GqP0Bgn3mEgP+8bjW/B6Ir69IbHD7JGh1QNw440I9ZIBBWqT?=
 =?us-ascii?Q?3EMOMI0ZlcsznO48WDQhsjnbcGWZVnvkqmZGFkJpnX239lFqLqSvqG+vjGgP?=
 =?us-ascii?Q?SEMigXSIb+YNDDvuDWXPV7bMmNJ9ovcn/Ua9/f5yskVyt/yXezcp7v5K+xay?=
 =?us-ascii?Q?Mn3sAaSR/117MrFS6aT7nR8HuTbN8tCzIv9mgVh5wUFmBAv945O5sCdDSvcA?=
 =?us-ascii?Q?F/3lpAX5cgrdVRdhrx4s/5Q4Zo7A8VIbWWaQPs8OFSGDn3yXy0dNZ1lCYqm3?=
 =?us-ascii?Q?4Dt4slTP3z0BkSIzd5obGPRjsFPUCW1Ucc778BcFifwgMoExqOQwZ1wKFKuI?=
 =?us-ascii?Q?4RyEcFnV4PQOt3gUK8GkaUl4HXLGrLqofIUSF6kF+PAILtedBSEH11C8BO/i?=
 =?us-ascii?Q?JIoszaAQCKF0O7xPkwU7qys78DKxq8WUZ4cEdugwDdSGwbjlbTQR/exOwS+M?=
 =?us-ascii?Q?adVKEuJ9pfj2gsJThDa6DRzynNKG0yB5/uLQAxuJHqTgPzROoZu6HNag8Gew?=
 =?us-ascii?Q?y62vG43c5B1jn1SRWYsiK7SGDE/83RtOO3yldRF/qFml82TYjCLAq6nCOSaS?=
 =?us-ascii?Q?1ds0GHzked2Xnjmz14ekXxL5ncw4fWv/d42jALW6MHCtXrFkKPAweqvxJXic?=
 =?us-ascii?Q?zE2ocXlwXenqjHjLjL7m+LBc00ckwIHXLHD+VA8EjrPvbEEaO/Q48TmWCf1j?=
 =?us-ascii?Q?lmq81nqXDd3YMNlErwB5BB4FUpyPGDMfbVB6adczSGcR5i1zi/avBs3Mvbpc?=
 =?us-ascii?Q?jF/m3ahSBxYVxDeIuotzsXJ0RG7jsBqNRk1XhgslJ+cYFSjE6gEpKc5tl/1B?=
 =?us-ascii?Q?gwm9Ixksc29rGd4srLdmZBfBr0YN0wmfiX6jXgadpmJtqzP9GlM59jMRV1Q6?=
 =?us-ascii?Q?mfNTTGRMQfEzNY4gajLKrfZy/WnajkPY6qxQcYzsXOzeQ2ict79DSyWIQU8Q?=
 =?us-ascii?Q?kRBS2/Qt8SDkLSdZzKg8DMXKzzWz4bLbqC6IusgwJiXty9mDmlMFWEtjVvNi?=
 =?us-ascii?Q?n7DoG2XxIjTgvg643kljrNUvUEnY6Gi8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:50:01.7808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a84bc5-bdfc-4ff3-ba3b-08dc96b86c7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946

The test works by sending packets through a tunnel, whence they are
forwarded to a LAG. One of the LAG children is removed from the LAG prior
to the exercise, and the test then counts how many packets pass through the
other one. The issue with this is that it counts all packets, not just the
encapsulated ones.

So instead add a second gretap endpoint to receive the sent packets, and
check reception counters there.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Danielle Ratson <danieller@nvidia.com>
---
 .../net/forwarding/mirror_gre_lag_lacp.sh     | 37 +++++++++++--------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
index 9edf4cb104a8..f521648682bf 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_lag_lacp.sh
@@ -37,8 +37,14 @@
 # |    \                                              /                       |
 # |     \____________________________________________/                        |
 # |                           |                                               |
-# |                           + lag2 (team)                                   |
-# |                             192.0.2.130/28                                |
+# |                           + lag2 (team)  ------>   + gt4-dst (gretap)     |
+# |                             192.0.2.130/28           loc=192.0.2.130      |
+# |                                                      rem=192.0.2.129      |
+# |                                                      ttl=100              |
+# |                                                      tos=inherit          |
+# |                                                                           |
+# |                                                                           |
+# |                                                                           |
 # |                                                                           |
 # +---------------------------------------------------------------------------+
 
@@ -122,16 +128,21 @@ h3_create()
 {
 	vrf_create vrf-h3
 	ip link set dev vrf-h3 up
-	tc qdisc add dev $h3 clsact
-	tc qdisc add dev $h4 clsact
 	h3_create_team
+
+	tunnel_create gt4-dst gretap 192.0.2.130 192.0.2.129 \
+		      ttl 100 tos inherit
+	ip link set dev gt4-dst master vrf-h3
+	tc qdisc add dev gt4-dst clsact
 }
 
 h3_destroy()
 {
+	tc qdisc del dev gt4-dst clsact
+	ip link set dev gt4-dst nomaster
+	tunnel_destroy gt4-dst
+
 	h3_destroy_team
-	tc qdisc del dev $h4 clsact
-	tc qdisc del dev $h3 clsact
 	ip link set dev vrf-h3 down
 	vrf_destroy vrf-h3
 }
@@ -188,18 +199,12 @@ setup_prepare()
 	h2_create
 	h3_create
 	switch_create
-
-	trap_install $h3 ingress
-	trap_install $h4 ingress
 }
 
 cleanup()
 {
 	pre_cleanup
 
-	trap_uninstall $h4 ingress
-	trap_uninstall $h3 ingress
-
 	switch_destroy
 	h3_destroy
 	h2_destroy
@@ -219,6 +224,7 @@ test_lag_slave()
 
 	mirror_install $swp1 ingress gt4 \
 		       "proto 802.1q flower vlan_id 333 $tcflags"
+	vlan_capture_install gt4-dst "vlan_ethtype ipv4 ip_proto icmp type 8"
 
 	# Move $down_dev away from the team. That will prompt change in
 	# txability of the connected device, without changing its upness. The
@@ -226,13 +232,14 @@ test_lag_slave()
 	# other slave.
 	ip link set dev $down_dev nomaster
 	sleep 2
-	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $up_dev 1 10
+	mirror_test vrf-h1 192.0.2.1 192.0.2.18 gt4-dst 100 10
 
 	# Test lack of connectivity when neither slave is txable.
 	ip link set dev $up_dev nomaster
 	sleep 2
-	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $h3 1 0
-	mirror_test vrf-h1 192.0.2.1 192.0.2.18 $h4 1 0
+	mirror_test vrf-h1 192.0.2.1 192.0.2.18 gt4-dst 100 0
+
+	vlan_capture_uninstall gt4-dst
 	mirror_uninstall $swp1 ingress
 
 	# Recreate H3's team device, because mlxsw, which this test is
-- 
2.45.0


