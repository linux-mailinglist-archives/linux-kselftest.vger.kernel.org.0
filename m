Return-Path: <linux-kselftest+bounces-36078-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A17AECDED
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 16:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC0D018849D1
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD1F2356B9;
	Sun, 29 Jun 2025 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dfA4FhVt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3FA235346;
	Sun, 29 Jun 2025 14:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207001; cv=fail; b=Jnxkrd6zop8V0/KPwh9D4h5u+C9KDBhqjtNrVPGFaeESWe8Ep5ffBwXMnQ6+Uvzp5s4aLG2y+pwNJGeEtT3lWnl6r00hMQkI7dYTplEJqmYMTLSWztaHWPyVoTTxM/i0zluHbktHIAzTwwuEVniIfAPQ3kAZLd4sJxgbEuAl+OY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207001; c=relaxed/simple;
	bh=M3Y05axRAa3zYBmqnVtOAC0hvFTZbIrlx9sobTk1CCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O8dTJiF/mohAD2POsd8h3nwDeNXbnyaBSfcYNkMpkYM8f8+xgwnk/eVR71NUPoOcri1JCqPZvsAqth12+vK/d5mVc3779yRKpG7h2/QxQiCnEpWlsfPxRJJ2Hl4tefVVEeqUVzfGsR/6bzjh75YCGD7M1vp1JKgAMolfV0Vao0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dfA4FhVt; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aRpwdzEY8M4KtPf836TiMwbp+tRGb+RkG5zA9XZgTZOBnNoGHPI5DZyl3JX/+Hfn8sI4RskupOWM1np/vTJVsoeUasZMdr3HU8lDCNJ3T41h+8RHPYRagRcbYLBDzGlSG9kdvAXeaLsXd5p4w/E1H944JcfFhxS+JeW/D1FrOeuyIJzEwsFloZ49cCVb/3oUw2xioFj/AlKo73Z80ByTidJvGUVF93KCzHKh1Ag9srMZ4EoDEajDaaR2/ZrpDQr8FeZh8MtNjxSuyhqv8hrcxWAmTWgPO7mFV9LjcUGLDn/AbVx0dwmM8IVHb+XFqRaT7Ec5vp/U8DREkBTMh6eeNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qm8m0XgQr2Rr23EvXJhQe4hCp0QoGQMDvLup/Tl7Noc=;
 b=e4WYqZZfmboz/KKxAlXHQXODtxngZYmJtl0ZjUTEetkXuwagf1nzCBo7uDiVqVAVX4uSN5DfIpTpFaQHhl+OMM5jcacdKMVGGzoZfyoadRYJ1eZwSaTDbotACSGKsMzbC/2vvy5zOOSi+f4XiLQzBKbfuHII1v3jvqlQ+aXWOPSJlAmy9miyP0CmPFF7+md+87HI4XAi0GUbHxls8W+a+HiqmmYl/E/UV5W2y4faUNjknxIcCmv4wnFTyCjnr1TKgtHR4hGZgZWFOZWsKmBMKMalrcnMUPYSo9IgDFax/lWOze2dOQ121NGKQJMmJ46FdM5vvZNPb2EnF3VP8zlopA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qm8m0XgQr2Rr23EvXJhQe4hCp0QoGQMDvLup/Tl7Noc=;
 b=dfA4FhVtaxNXbvgkfisgFNJVnVicyucZ+T/DTmu0BUQrMS32isZZcp6qB81Y2pYOZXnIr/LaPcvISiMNg0p1/tmqilj+bX34dlwbR27qMCRUJmNC/7QKh2AYo+5aZ89PocSCwawW8/lxr8mLVFs/hgSg9PiSQ/W3yt/M7i0hWU+7CJrxYdf3+4lwBSTK5PKR1UfCUWzT5/F2S5RsbtFg9tEwr5E3hQnVxQNWsUpHam2vo4Eq/rd4kubu3mTad3F0a+aUBrG+PRL96f6EZ5JA1ScJhdCLUWWm6Z9g4CHKm4TXoH7b4tVjoUmRg9rEqOWlbp9DPMfBjcTtQ2QtMNLWzQ==
Received: from BN8PR07CA0025.namprd07.prod.outlook.com (2603:10b6:408:ac::38)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Sun, 29 Jun
 2025 14:23:10 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:ac:cafe::1a) by BN8PR07CA0025.outlook.office365.com
 (2603:10b6:408:ac::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Sun,
 29 Jun 2025 14:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Sun, 29 Jun 2025 14:23:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 29 Jun
 2025 07:23:01 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 29 Jun
 2025 07:23:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 29
 Jun 2025 07:22:53 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
	<jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky
	<leon@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Jeff Layton
	<jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
	<okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
	<tom@talpey.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next v12 8/8] selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution
Date: Sun, 29 Jun 2025 17:21:38 +0300
Message-ID: <20250629142138.361537-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250629142138.361537-1-mbloch@nvidia.com>
References: <20250629142138.361537-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="Yes"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f02514d-a25d-4c45-8556-08ddb7187998
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CO17EGxzSxRoTr204fKddH5dUCLDdMKwjs4qEmSeAtoqFrKF44GW6ZwLsboq?=
 =?us-ascii?Q?fHTjknZ//CUzzwdijMzG1aF2Awc0oASFmFiA3AlHFZKULVZeKBkxawhBQYVC?=
 =?us-ascii?Q?btMELJl9SSultf2vRoznVwSzMrADTSU53qCaRBJ5HjhSZg4fA1LeBFNUXov0?=
 =?us-ascii?Q?bWiuJfVl7/5nPOIwrXtS//AB80NilxY1fHhWoiE2LYZEEa1uui1F1OFtFS/0?=
 =?us-ascii?Q?xPlVVk4lR8ypfxVIpWr/qm170CaNW6dx+RTQV59/Gkn2a8345AlkIZX+GgfZ?=
 =?us-ascii?Q?Jy4rT/BJ5UPTsgr4/BqmCZWtNzbg8FAx2sRJZ83oQKoVX7i3gvyufvyS7aOV?=
 =?us-ascii?Q?Jhjq+n7kWBosUPb6i5YPhnBtITz/yeejqcOtzscXWs7agi+pqgWd4nMRfcsM?=
 =?us-ascii?Q?67qq0XTO/2nrcZ3r1EAiIYEsaiANtUjXqjdn5e1wvmfYOGbLArQmq/j0LYla?=
 =?us-ascii?Q?K/EW6P+Ur0Ts9pxQSzARIHNP09Vf1lWoiexkvHi3q5XStSKt7o2WHIlAjT73?=
 =?us-ascii?Q?GpEQfuzpQf7mpeEegiAXAuoxQG5+KTgTYAximt2xwS4zyGFO6i5pzNNVAH2H?=
 =?us-ascii?Q?GKzMayOtljCQYynMqAzaEqpCwtjP2E7ffGJgP3bZUDAVNcW9xMscM0024FJu?=
 =?us-ascii?Q?e0ItUAXRGFy16a6FS1dy1FCtM736R5+Ze2XsXwbM/I5U1NkxhL94bGOtCh5H?=
 =?us-ascii?Q?nCIxGuHFjLRocQ2oPnU+gQbF4+7rhI0o876oGnGOwATpv75XFtE6P8CeiHAY?=
 =?us-ascii?Q?dpgPs8JOVJ1zyg6RCrFEI3o5+Tp0VZG7AxBsJmL0bBX8LkmNGxUkV+vLWOhK?=
 =?us-ascii?Q?b3OKQXDF6nXoLNiEnLIjB7MBE7dmRT8GfxBwzSZzlwYC+kzrKYBBrrLC+olF?=
 =?us-ascii?Q?te0cJ3Zclj1hRKRaxK/1oIt6Mt4wh2tp9+F9qF/S8VLh8/BtMPeQEQoiuEN9?=
 =?us-ascii?Q?yBZpPsQp4jY5Hbv3ZEbh0Q47+doIzPL429f7umbmC7CYTG4ulFKddihLEpnf?=
 =?us-ascii?Q?Bf9+EkVrwI6Ga1g7uQszYFOAG9SFOHRZTpEGvm9lCHuBibm1YifnOVCbt4CH?=
 =?us-ascii?Q?+vKaEDfrW1I1nJxe+9tudnHEdsbL8l4MA6GpHZItCUjctJfXBZ9C/T1gO+fz?=
 =?us-ascii?Q?yWEMIabbyk5diwEvS7vzR3eUPSpC96J0JkZHmKXCvwZGLXDIE7sSV8FbC2F7?=
 =?us-ascii?Q?Kk3dHo8dlFutJ82f3NyxK5guz+wchPakrhNPFMYiPHIzxcFlEJ38NQ39Td+4?=
 =?us-ascii?Q?AYT8S0qcVI3qFsWd9Ru0B653eP7Cw56tAYNA33yWI1DDtFNwVRxzsoKjmjUe?=
 =?us-ascii?Q?q0R8hhjblFNkTuydoP6vizE4rnAKlxCv5kS+x3rs5xY/dhiHv+zZxpyZ14HE?=
 =?us-ascii?Q?Nbiv2Vjb7MYUb3qU+VXthmg/r9QJynAOwHf7/yH3vtZfTxzaizWkM68Glytu?=
 =?us-ascii?Q?tIJABb6oTDFKC5oQJ40U1WILhabJt99sGrVL8UP1FXJ+MJ8gWhfBsBGVghfI?=
 =?us-ascii?Q?mXu0CcYv4PHPxY7UtAXHiiCvg2yjkpal7qZviaZkSieKOG/K+6Ci93/HqA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2025 14:23:10.1632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f02514d-a25d-4c45-8556-08ddb7187998
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

From: Carolina Jubran <cjubran@nvidia.com>

This test suite validates the functionality of the devlink-rate API for
traffic class (TC) bandwidth allocation. It ensures that bandwidth can
be distributed between different traffic classes as configured, and
verifies that explicit TC-to-queue mapping is required for the
allocation to be effective.

The first test (test_no_tc_mapping_bandwidth) is marked as expected
failure on mlx5, since the hardware automatically enforces traffic
class separation by dynamically moving queues to the correct TC
scheduler, even without explicit TC-to-queue mapping configuration.

Test output on mlx5:
 1..2
 # Created VF interface: eth5
 # Created VLAN eth5.101 on eth5 with tc 3 and IP 198.51.100.2
 # Created VLAN eth5.102 on eth5 with tc 4 and IP 198.51.100.10
 # Set representor eth4 up and added to bridge
 # Bandwidth check results without TC mapping:
 # TC 3: 0.19 Gbits/sec
 # TC 4: 0.76 Gbits/sec
 # Total bandwidth: 0.95 Gbits/sec
 # TC 3 percentage: 20.0%
 # TC 4 percentage: 80.0%
 ok 1 devlink_rate_tc_bw.test_no_tc_mapping_bandwidth # XFAIL Bandwidth matched 80/20 split without TC mapping
 # Created VF interface: eth5
 # Created VLAN eth5.101 on eth5 with tc 3 and IP 198.51.100.2
 # Created VLAN eth5.102 on eth5 with tc 4 and IP 198.51.100.10
 # Set representor eth4 up and added to bridge
 # Bandwidth check results with TC mapping:
 # TC 3: 0.21 Gbits/sec
 # TC 4: 0.78 Gbits/sec
 # Total bandwidth: 0.98 Gbits/sec
 # TC 3 percentage: 21.1%
 # TC 4 percentage: 78.9%
 # Bandwidth is distributed as 80/20 with TC mapping
 ok 2 devlink_rate_tc_bw.test_tc_mapping_bandwidth
 # Totals: pass:1 fail:0 xfail:1 xpass:0 skip:0 error:0

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
Hi Jakub,
You can find the iproute2 patch here:
https://lore.kernel.org/netdev/20250625182545.86994-1-mbloch@nvidia.com/

 .../drivers/net/hw/devlink_rate_tc_bw.py      | 466 ++++++++++++++++++
 .../drivers/net/hw/lib/py/__init__.py         |   2 +-
 .../selftests/drivers/net/lib/py/__init__.py  |   2 +-
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 5 files changed, 474 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py

diff --git a/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
new file mode 100755
index 000000000000..820d8a03becc
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/devlink_rate_tc_bw.py
@@ -0,0 +1,466 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Devlink Rate TC Bandwidth Test Suite
+===================================
+
+This test suite verifies the functionality of devlink-rate traffic class (TC)
+bandwidth distribution in a virtualized environment. The tests validate that
+bandwidth can be properly allocated between different traffic classes and
+that TC mapping works as expected.
+
+Test Environment:
+----------------
+- Creates 1 VF
+- Establishes a bridge connecting the VF representor and the uplink representor
+- Sets up 2 VLAN interfaces on the VF with different VLAN IDs (101, 102)
+- Configures different traffic classes (TC3 and TC4) for each VLAN
+
+Test Cases:
+----------
+1. test_no_tc_mapping_bandwidth:
+   - Verifies that without TC mapping, bandwidth is NOT distributed according to
+     the configured 80/20 split between TC4 and TC3
+   - This test should fail if bandwidth matches the 80/20 split without TC
+     mapping
+   - Expected: Bandwidth should NOT be distributed as 80/20
+
+2. test_tc_mapping_bandwidth:
+   - Configures TC mapping using mqprio qdisc
+   - Verifies that with TC mapping, bandwidth IS distributed according to the
+     configured 80/20 split between TC3 and TC4
+   - Expected: Bandwidth should be distributed as 80/20
+
+Bandwidth Distribution:
+----------------------
+- TC3 (VLAN 101): Configured for 80% of total bandwidth
+- TC4 (VLAN 102): Configured for 20% of total bandwidth
+- Total bandwidth: 1Gbps
+- Tolerance: +-12%
+
+Hardware-Specific Behavior (mlx5):
+--------------------------
+mlx5 hardware enforces traffic class separation by ensuring that each transmit
+queue (SQ) is associated with a single TC. If a packet is sent on a queue that
+doesn't match the expected TC (based on DSCP or VLAN priority and hypervisor-set
+mapping), the hardware moves the queue to the correct TC scheduler to preserve
+traffic isolation.
+
+This behavior means that even without explicit TC-to-queue mapping, bandwidth
+enforcement may still appear to work—because the hardware dynamically adjusts
+the scheduling context. However, this can lead to performance issues in high
+rates and HOL blocking if traffic from different TCs is mixed on the same queue.
+"""
+
+import json
+import os
+import subprocess
+import threading
+import time
+
+from lib.py import ksft_pr, ksft_run, ksft_exit
+from lib.py import KsftSkipEx, KsftFailEx, KsftXfailEx
+from lib.py import NetDrvEpEnv, DevlinkFamily
+from lib.py import NlError
+from lib.py import cmd, defer, ethtool, ip
+
+
+class BandwidthValidator:
+    """
+    Validates bandwidth totals and per-TC shares against expected values
+    with a tolerance.
+    """
+
+    def __init__(self):
+        self.tolerance_percent = 12
+        self.expected_total_gbps = 1.0
+        self.total_min_expected = self.min_expected(self.expected_total_gbps)
+        self.total_max_expected = self.max_expected(self.expected_total_gbps)
+        self.tc_expected_percent = {
+            3: 20.0,
+            4: 80.0,
+        }
+
+    def min_expected(self, value):
+        """Calculates the minimum acceptable value based on tolerance."""
+        return value - (value * self.tolerance_percent / 100)
+
+    def max_expected(self, value):
+        """Calculates the maximum acceptable value based on tolerance."""
+        return value + (value * self.tolerance_percent / 100)
+
+    def bound(self, expected, value):
+        """Returns True if value is within expected tolerance."""
+        return self.min_expected(expected) <= value <= self.max_expected(expected)
+
+    def tc_bandwidth_bound(self, value, tc_ix):
+        """
+        Returns True if the given bandwidth value is within tolerance
+        for the TC's expected bandwidth.
+        """
+        expected = self.tc_expected_percent[tc_ix]
+        return self.bound(expected, value)
+
+
+def setup_vf(cfg, set_tc_mapping=True):
+    """
+    Sets up a VF on the given network interface.
+
+    Enables SR-IOV and switchdev mode, brings the VF interface up,
+    and optionally configures TC mapping using mqprio.
+    """
+    try:
+        cmd(f"devlink dev eswitch set pci/{cfg.pci} mode switchdev")
+        defer(cmd, f"devlink dev eswitch set pci/{cfg.pci} mode legacy")
+    except Exception as exc:
+        raise KsftSkipEx(f"Failed to enable switchdev mode on {cfg.pci}") from exc
+    try:
+        cmd(f"echo 1 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
+        defer(cmd, f"echo 0 > /sys/class/net/{cfg.ifname}/device/sriov_numvfs")
+    except Exception as exc:
+        raise KsftSkipEx(f"Failed to enable SR-IOV on {cfg.ifname}") from exc
+
+    time.sleep(2)
+    vf_ifc = (os.listdir(
+        f"/sys/class/net/{cfg.ifname}/device/virtfn0/net") or [None])[0]
+    if vf_ifc:
+        ip(f"link set dev {vf_ifc} up")
+    else:
+        raise KsftSkipEx("VF interface not found")
+    if set_tc_mapping:
+        cmd(f"tc qdisc add dev {vf_ifc} root handle 5 mqprio mode dcb hw 1 num_tc 8")
+
+    return vf_ifc
+
+
+def setup_vlans_on_vf(vf_ifc):
+    """
+    Sets up two VLAN interfaces on the given VF, each mapped to a different TC.
+    """
+    vlan_configs = [
+        {"vlan_id": 101, "tc": 3, "ip": "198.51.100.2"},
+        {"vlan_id": 102, "tc": 4, "ip": "198.51.100.10"},
+    ]
+
+    for config in vlan_configs:
+        vlan_dev = f"{vf_ifc}.{config['vlan_id']}"
+        ip(f"link add link {vf_ifc} name {vlan_dev} type vlan id {config['vlan_id']}")
+        ip(f"addr add {config['ip']}/29 dev {vlan_dev}")
+        ip(f"link set dev {vlan_dev} up")
+        ip(f"link set dev {vlan_dev} type vlan egress-qos-map 0:{config['tc']}")
+        ksft_pr(f"Created VLAN {vlan_dev} on {vf_ifc} with tc {config['tc']} and IP {config['ip']}")
+
+
+def get_vf_info(cfg):
+    """
+    Finds the VF representor interface and devlink port index
+    for the given PCI device used in the test environment.
+    """
+    cfg.vf_representor = None
+    cfg.vf_port_index = None
+    out = subprocess.check_output(["devlink", "-j", "port", "show"], encoding="utf-8")
+    ports = json.loads(out)["port"]
+
+    for port_name, props in ports.items():
+        netdev = props.get("netdev")
+
+        if (port_name.startswith(f"pci/{cfg.pci}/") and
+            props.get("vfnum") == 0):
+            cfg.vf_representor = netdev
+            cfg.vf_port_index = int(port_name.split("/")[-1])
+            break
+
+
+def setup_bridge(cfg):
+    """
+    Creates and configures a Linux bridge, with both the uplink
+    and VF representor interfaces attached to it.
+    """
+    bridge_name = f"br_{os.getpid()}"
+    ip(f"link add name {bridge_name} type bridge")
+    defer(cmd, f"ip link del name {bridge_name} type bridge")
+
+    ip(f"link set dev {cfg.ifname} master {bridge_name}")
+
+    rep_name = cfg.vf_representor
+    if rep_name:
+        ip(f"link set dev {rep_name} master {bridge_name}")
+        ip(f"link set dev {rep_name} up")
+        ksft_pr(f"Set representor {rep_name} up and added to bridge")
+    else:
+        raise KsftSkipEx("Could not find representor for the VF")
+
+    ip(f"link set dev {bridge_name} up")
+
+
+def setup_devlink_rate(cfg):
+    """
+    Configures devlink rate tx_max and traffic class bandwidth for the VF.
+    """
+    port_index = cfg.vf_port_index
+    if port_index is None:
+        raise KsftSkipEx("Could not find VF port index")
+    try:
+        cfg.devnl.rate_set({
+            "bus-name": "pci",
+            "dev-name": cfg.pci,
+            "port-index": port_index,
+            "rate-tx-max": 125000000,
+            "rate-tc-bws": [
+                {"rate-tc-index": 0, "rate-tc-bw": 0},
+                {"rate-tc-index": 1, "rate-tc-bw": 0},
+                {"rate-tc-index": 2, "rate-tc-bw": 0},
+                {"rate-tc-index": 3, "rate-tc-bw": 20},
+                {"rate-tc-index": 4, "rate-tc-bw": 80},
+                {"rate-tc-index": 5, "rate-tc-bw": 0},
+                {"rate-tc-index": 6, "rate-tc-bw": 0},
+                {"rate-tc-index": 7, "rate-tc-bw": 0},
+            ]
+        })
+    except NlError as exc:
+        if exc.error == 95:  # EOPNOTSUPP
+            raise KsftSkipEx("devlink rate configuration is not supported on the VF") from exc
+        raise KsftFailEx(f"rate_set failed on VF port {port_index}") from exc
+
+
+def setup_remote_server(cfg):
+    """
+    Sets up VLAN interfaces and starts iperf3 servers on the remote side.
+    """
+    remote_dev = cfg.remote_ifname
+    vlan_ids = [101, 102]
+    remote_ips = ["198.51.100.1", "198.51.100.9"]
+
+    for vlan_id, ip_addr in zip(vlan_ids, remote_ips):
+        vlan_dev = f"{remote_dev}.{vlan_id}"
+        cmd(f"ip link add link {remote_dev} name {vlan_dev} "
+            f"type vlan id {vlan_id}", host=cfg.remote)
+        cmd(f"ip addr add {ip_addr}/29 dev {vlan_dev}", host=cfg.remote)
+        cmd(f"ip link set dev {vlan_dev} up", host=cfg.remote)
+        cmd(f"iperf3 -s -1 -B {ip_addr}",background=True, host=cfg.remote)
+        defer(cmd, f"ip link del {vlan_dev}", host=cfg.remote)
+
+
+def setup_test_environment(cfg, set_tc_mapping=True):
+    """
+    Sets up the complete test environment including VF creation, VLANs,
+    bridge configuration, devlink rate setup, and the remote server.
+    """
+    vf_ifc = setup_vf(cfg, set_tc_mapping)
+    ksft_pr(f"Created VF interface: {vf_ifc}")
+
+    setup_vlans_on_vf(vf_ifc)
+
+    get_vf_info(cfg)
+    setup_bridge(cfg)
+
+    setup_devlink_rate(cfg)
+    setup_remote_server(cfg)
+    time.sleep(2)
+
+
+def run_iperf_client(server_ip, local_ip, barrier, min_expected_gbps=0.1):
+    """
+    Runs a single iperf3 client instance, binding to the given local IP.
+    Waits on a barrier to synchronize with other threads.
+    """
+    try:
+        barrier.wait(timeout=10)
+    except Exception as exc:
+        raise KsftFailEx("iperf3 barrier wait timed") from exc
+
+    iperf_cmd = ["iperf3", "-c", server_ip, "-B", local_ip, "-J"]
+    result = subprocess.run(iperf_cmd, capture_output=True, text=True,
+                            check=True)
+
+    try:
+        output = json.loads(result.stdout)
+        bits_per_second = output["end"]["sum_received"]["bits_per_second"]
+        gbps = bits_per_second / 1e9
+        if gbps < min_expected_gbps:
+            ksft_pr(
+                f"iperf3 bandwidth too low: {gbps:.2f} Gbps "
+                f"(expected ≥ {min_expected_gbps} Gbps)"
+            )
+            return None
+        return gbps
+    except json.JSONDecodeError as exc:
+        ksft_pr(f"Failed to parse iperf3 JSON output: {exc}")
+        return None
+
+
+def run_bandwidth_test():
+    """
+    Launches iperf3 client threads for each VLAN/TC pair and collects results.
+    """
+    def _run_iperf_client_thread(server_ip, local_ip, results, barrier, tc_ix):
+        results[tc_ix] = run_iperf_client(server_ip, local_ip, barrier)
+
+    vf_vlan_data = [
+        # (local_ip, remote_ip, TC)
+        ("198.51.100.2",  "198.51.100.1", 3),
+        ("198.51.100.10", "198.51.100.9", 4),
+    ]
+
+    results = {}
+    threads = []
+    start_barrier = threading.Barrier(len(vf_vlan_data))
+
+    for local_ip, remote_ip, tc_ix in vf_vlan_data:
+        thread = threading.Thread(
+            target=_run_iperf_client_thread,
+            args=(remote_ip, local_ip, results, start_barrier, tc_ix)
+        )
+        thread.start()
+        threads.append(thread)
+
+    for thread in threads:
+        thread.join()
+
+    for tc_ix, tc_bw in results.items():
+        if tc_bw is None:
+            raise KsftFailEx("iperf3 client failed; cannot evaluate bandwidth")
+
+    return results
+
+def calculate_bandwidth_percentages(results):
+    """
+    Calculates the percentage of total bandwidth received by TC3 and TC4.
+    """
+    if 3 not in results or 4 not in results:
+        raise KsftFailEx(f"Missing expected TC results in {results}")
+
+    tc3_bw = results[3]
+    tc4_bw = results[4]
+    total_bw = tc3_bw + tc4_bw
+    tc3_percentage = (tc3_bw / total_bw) * 100
+    tc4_percentage = (tc4_bw / total_bw) * 100
+
+    return {
+        'tc3_bw': tc3_bw,
+        'tc4_bw': tc4_bw,
+        'tc3_percentage': tc3_percentage,
+        'tc4_percentage': tc4_percentage,
+        'total_bw': total_bw
+    }
+
+
+def print_bandwidth_results(bw_data, test_name):
+    """
+    Prints bandwidth measurements and TC usage summary for a given test.
+    """
+    ksft_pr(f"Bandwidth check results {test_name}:")
+    ksft_pr(f"TC 3: {bw_data['tc3_bw']:.2f} Gbits/sec")
+    ksft_pr(f"TC 4: {bw_data['tc4_bw']:.2f} Gbits/sec")
+    ksft_pr(f"Total bandwidth: {bw_data['total_bw']:.2f} Gbits/sec")
+    ksft_pr(f"TC 3 percentage: {bw_data['tc3_percentage']:.1f}%")
+    ksft_pr(f"TC 4 percentage: {bw_data['tc4_percentage']:.1f}%")
+
+
+def verify_total_bandwidth(bw_data, validator):
+    """
+    Ensures the total measured bandwidth falls within the acceptable tolerance.
+    """
+    total = bw_data['total_bw']
+
+    if validator.bound(validator.expected_total_gbps, total):
+        return
+
+    if total < validator.total_min_expected:
+        raise KsftSkipEx(
+            f"Total bandwidth {total:.2f} Gbps < minimum "
+            f"{validator.total_min_expected:.2f} Gbps; "
+            f"parent tx_max ({validator.expected_total_gbps:.1f} G) "
+            f"not reached, cannot validate share"
+        )
+
+    raise KsftFailEx(
+        f"Total bandwidth {total:.2f} Gbps exceeds allowed ceiling "
+        f"{validator.total_max_expected:.2f} Gbps "
+        f"(VF tx_max set to {validator.expected_total_gbps:.1f} G)"
+    )
+
+
+def check_bandwidth_distribution(bw_data, validator):
+    """
+    Checks whether the measured TC3 and TC4 bandwidth percentages
+    fall within their expected tolerance ranges.
+
+    Returns:
+        bool: True if both TC3 and TC4 percentages are within bounds.
+    """
+    tc3_valid = validator.tc_bandwidth_bound(bw_data['tc3_percentage'], 3)
+    tc4_valid = validator.tc_bandwidth_bound(bw_data['tc4_percentage'], 4)
+
+    return tc3_valid and tc4_valid
+
+
+def run_bandwidth_distribution_test(cfg, set_tc_mapping):
+    """
+    Runs parallel iperf3 tests for both TCs and collects results.
+    """
+    setup_test_environment(cfg, set_tc_mapping)
+    bandwidths = run_bandwidth_test()
+    bw_data = calculate_bandwidth_percentages(bandwidths)
+    test_name = "with TC mapping" if set_tc_mapping else "without TC mapping"
+    print_bandwidth_results(bw_data, test_name)
+
+    verify_total_bandwidth(bw_data, cfg.bw_validator)
+
+    return check_bandwidth_distribution(bw_data, cfg.bw_validator)
+
+
+def test_no_tc_mapping_bandwidth(cfg):
+    """
+    Verifies that bandwidth is not split 80/20 without traffic class mapping.
+    """
+    pass_bw_msg = "Bandwidth is NOT distributed as 80/20 without TC mapping"
+    fail_bw_msg = "Bandwidth matched 80/20 split without TC mapping"
+    is_mlx5 = "driver: mlx5" in ethtool(f"-i {cfg.ifname}").stdout
+
+    if run_bandwidth_distribution_test(cfg, set_tc_mapping=False):
+        if is_mlx5:
+            raise KsftXfailEx(fail_bw_msg)
+        raise KsftFailEx(fail_bw_msg)
+    if is_mlx5:
+        raise KsftFailEx("mlx5 behavior changed:" + pass_bw_msg)
+    ksft_pr(pass_bw_msg)
+
+
+def test_tc_mapping_bandwidth(cfg):
+    """
+    Verifies that bandwidth is correctly split 80/20 between TC3 and TC4
+    when traffic class mapping is set.
+    """
+    if run_bandwidth_distribution_test(cfg, set_tc_mapping=True):
+        ksft_pr("Bandwidth is distributed as 80/20 with TC mapping")
+    else:
+        raise KsftFailEx("Bandwidth did not match 80/20 split with TC mapping")
+
+
+def main() -> None:
+    """
+    Main entry point for running the test cases.
+    """
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.devnl = DevlinkFamily()
+
+        cfg.pci = os.path.basename(
+            os.path.realpath(f"/sys/class/net/{cfg.ifname}/device")
+        )
+        if not cfg.pci:
+            raise KsftSkipEx("Could not get PCI address of the interface")
+        cfg.require_cmd("iperf3")
+        cfg.require_cmd("iperf3", remote=True)
+
+        cfg.bw_validator = BandwidthValidator()
+
+        cases = [test_no_tc_mapping_bandwidth, test_tc_mapping_bandwidth]
+
+        ksft_run(cases=cases, args=(cfg,))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
diff --git a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
index 56ff11074b55..1462a339a74b 100644
--- a/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/hw/lib/py/__init__.py
@@ -13,7 +13,7 @@ try:
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily
+        NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/tools/testing/selftests/drivers/net/lib/py/__init__.py
index 9ed1d8f70524..fce5d9218f1d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -12,7 +12,7 @@ try:
 
     # Import one by one to avoid pylint false positives
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily, \
-        NlError, RtnlFamily
+        NlError, RtnlFamily, DevlinkFamily
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, defer, ethtool, fd_read_timeout, ip, \
         rand_port, tool, wait_port_listen
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 8697bd27dc30..02be28dcc089 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -6,4 +6,4 @@ from .netns import NetNS, NetNSEnter
 from .nsim import *
 from .utils import *
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
-from .ynl import NetshaperFamily
+from .ynl import NetshaperFamily, DevlinkFamily
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index 6329ae805abf..2b3a61ea3bfa 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -56,3 +56,8 @@ class NetshaperFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
+
+class DevlinkFamily(YnlFamily):
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('devlink.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
-- 
2.34.1


