Return-Path: <linux-kselftest+bounces-35797-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1901AAE8C91
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 20:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C556812B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8482DCBEC;
	Wed, 25 Jun 2025 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YO9UKXfD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA54F2D5415;
	Wed, 25 Jun 2025 18:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750876316; cv=fail; b=f7Fg65cTupF1gLdL25dO7p186NQ0ZyuOR7LtMvxzd4V9ctCcBXA82QoyQ+1HMViZ3E2f1S0zFyRrASdByZSefNHN3urL/ZzRgkAhHzvpSbuGXaDqQMOlXkR8sGJ5R/Ju5rTePq4IlRbvQP4job6ArRbHbES5zzkgwU+4xpVkc+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750876316; c=relaxed/simple;
	bh=zWBxuhM+fomNmG9DipKLdcONTNvR2asbPvz41Y3e1N0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VmUbqvn+waKtSTR8DDS9w9VFgVeEBiHkZxnj+b3C0TM9+qy37Ss6aXbuzn4Pi5rfwtNKUjeFRxC/G6HsANXL+pTgG0mjKWDuIilA3A63RKm7F3UjuvS8tCKG+cvgNb9TNsheQE5dAMAPts/VmIxYu3iIsUWMdBHmV2Lo7pZzXAs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YO9UKXfD; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQRTXHNrLSq9JnjwpOhVu1VTwpID2tyb5815dqzU2hw6nJXGw+YrJKA1iLvdtkEHD5TI20mGUyMJ7XeJOhbiRNTigG/9AG5P2mNDRWJI5i9oNlzRgL8HK5CAIg9rIp4qpcRHmRXoVlUxM9T3zgtYOzZvoJ1UvJUClbUSGZ7Pmrd7LFkxkxx+qYTN5ZiDPsUs4TZDlSKcC0Rkv+q/ZmoxyxxH9cSpq2zu5/+WRzurKohK83U7G2eFxZhKkipUYeVlta9AAPo97VYH/fAqmHayCeTKtsKe2arhq3XsHP4nSj7ox+zDARI9E2oP0Whf4IHeanluFbFHssbtKhkYPnwuyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAvm5AweKpCNVZyEJ3o5bzi6WDYuEYrBfIgM8T1HYUU=;
 b=aUSwIQWgc97KbQzMXHuGohhRPvazQSDLIT9Fh1jjDV+TVkkHmEDPvIhwKEh3dDmPJ3AT8u0pSQ0YqNcBGqoqlPnWqKvjYk7epy/UBZXD5yfkxDCnrcej+VE7AV2ImtLUvGJqfwaCyh5W+Ai5uk/AFrrkaCY+3dfCM7I/Jt57YUVkaFERJy6DRgObGI8zoxObr9akfEoEK/6iQMrxthXIPy5/GxV1R2jmFqlwQLNPWaazeWAAEgB6yFYPzRs7eKHjeAUCCMwzqb7svU50P5VLqIAm8F9nJAYWAIHtj2bzlpDZLKyFq4qBe2+qwc4jf1oeEzIR+3VHyhWAktlHu6b7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAvm5AweKpCNVZyEJ3o5bzi6WDYuEYrBfIgM8T1HYUU=;
 b=YO9UKXfDkmze/jUjkOBO3S/MW+u+Aa/IEoUEWLO1UZc8qEczqbGt3peGi9RUjc0lWLQgE8QVshb4jkYhy69NXFfzv7M81/VvRnx96owTDJhnQzLuZPuleqdJX02w8sn40X/WuiWPONhb8dnyVflwn9MtOACIwGXg6NTUh4sKaamAokqSVuLywfcDY2rfd9OdA9DnovY6Ko/9r5d5Xt/Ta/YVQqrB0CoFgpPaMrlzjXtZlFnJdQ0YOyXyo/erVwKb8GKIpnWKKfLxxt2KxBmkSLPfIyUbNz1T/UqSij2qWNumfk2AMIKxKkdFO3dOU3Tua0RLSSiMX1uOWs1Kp+Z9uA==
Received: from SJ0PR03CA0174.namprd03.prod.outlook.com (2603:10b6:a03:338::29)
 by CH2PR12MB4263.namprd12.prod.outlook.com (2603:10b6:610:a6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Wed, 25 Jun
 2025 18:31:47 +0000
Received: from MWH0EPF000989E5.namprd02.prod.outlook.com
 (2603:10b6:a03:338:cafe::9) by SJ0PR03CA0174.outlook.office365.com
 (2603:10b6:a03:338::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Wed,
 25 Jun 2025 18:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E5.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 18:31:46 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 11:31:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 11:31:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 25
 Jun 2025 11:31:19 -0700
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
Subject: [PATCH net-next v11 8/8] selftests: drv-net: Add test for devlink-rate traffic class bandwidth distribution
Date: Wed, 25 Jun 2025 21:30:18 +0300
Message-ID: <20250625183018.87065-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250625183018.87065-1-mbloch@nvidia.com>
References: <20250625183018.87065-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E5:EE_|CH2PR12MB4263:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e1bba0-76e0-464b-88fa-08ddb4168aaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PJ2ORS8Y8w10lFZNmE9l2MeXec41XBKSscVh9nRR9sCm8NhX+t42jK/Ocufi?=
 =?us-ascii?Q?UPB6E3fuj2aQZhy7pGq6cOuRO9ys/Im3YIGhHxj1EnriC3KTwtiJ2eVCx79u?=
 =?us-ascii?Q?e4Dt1v1QqFw/LNWYQew9Y7ze7Vlzv7pGpMBcwEGG4RSDFuBsW0vcCaqxg76S?=
 =?us-ascii?Q?Q94b+sYDmXzIVptatEoy49fV971Chii8bLRzofRNrUEmO+JmUVCQ6fR4v8zG?=
 =?us-ascii?Q?Eag+VJbAq6vaznBkLzh9uiESQDjGIQNO34QNNFQ5ZRZviG4LYds9MVom3E0E?=
 =?us-ascii?Q?dVc/BI+MXMPl0dQR4x4vrIR0hHLc7gJY777jsn06fiSbfHLpz5m5GB0gZb0V?=
 =?us-ascii?Q?P1z3ToAdue7wj2djBqbQxOQiHi0S4+2nYkVCIzCNq9md3tsA/A3KDyxxh6j0?=
 =?us-ascii?Q?O3BKZGmDawoqzzvVObsG16aniRyR9w6o7Bm0oxKnTq858wust6eKbCk+G6Qr?=
 =?us-ascii?Q?kYpLNx+xPjoaF3x1LBgazhivOASWQZ9CWaF2fB1I/PXj/Y2hRgo974HvxVgV?=
 =?us-ascii?Q?lHwdul6SO3ARvZPn2dgu/qMZIij+Ds0PhHcwI2ZyV7pBIuXadXyW9LuWI64v?=
 =?us-ascii?Q?WwtD3JsB9PJZBEApJpyCtNJjBl3RSS/CaDO3emMh0ELFF65m+ppxciRm2PUm?=
 =?us-ascii?Q?AfvY5fQ1pdGCDlRrGxYVxee0t66tE59kqdnrazXhIoNawI7tP4wwMMyBHHDd?=
 =?us-ascii?Q?bd/YL1bbV4bMb09gkTEBEKM6UnZgrPTFo4u+jM59+f5ZKQ7hDeDUX+2GTXq1?=
 =?us-ascii?Q?KjQNo+5RTxq1RZxwhRAd32co1JlDWR0WR9db2vifpQm4OUKYoVCe4xP16FcW?=
 =?us-ascii?Q?MbWIGPcCC457sAgxqKL5KS3eTiVHcG7BN2ruwRRh2/i0GevzyuPqlMdWN1Ni?=
 =?us-ascii?Q?/wFgvYkczH/dZQjn1hHa+R6f+YB80dh6R96QyAswHiZkTObhS9cbdac6vc5R?=
 =?us-ascii?Q?3dC9OlQarvXl5VkYRI75S937lwnutVzy9RFnZ/gvHfl9xgRAvd9TPlRap8IE?=
 =?us-ascii?Q?uGyN/o+NsLy1LxA51uyHQVbVseD40wrVfqrm2Ypgtlkkrx8VE9vrUlbJCARW?=
 =?us-ascii?Q?cgCvXg6n0Vxu3AmmVw/uWeWaIGaQJ0hUhEzXq77aL4dYtP1f98VPJ5KsMz6m?=
 =?us-ascii?Q?ynRQ+grw3ytA7VhmxIwLNE6vNxraor0Tqr1Tb5EmydKa8QhizBfpb721yolZ?=
 =?us-ascii?Q?QHt/q/gd5hBmw8Zbv5eJxytrBIjs3Cp2Ql1l4o9yqyLlLTEALkjfwG9eoS85?=
 =?us-ascii?Q?+eVzwPxcoVJ+hIOxiZFtZk5nryo5o+Q4zYqbOOgfgBammczvd77nShdRPgYa?=
 =?us-ascii?Q?WMUqOmV4+cuTLf3mLDyW04wkTcZOhrYeqaHh9jTeB9y9fb4k/Ae/M/u3SC39?=
 =?us-ascii?Q?IaIl6HdtEl6XeclkAKj9jeYHbZzD7Yvl2YnxBRsWQ2MY3vAmVlOrHbuzw+tQ?=
 =?us-ascii?Q?XuLMPi1yYbytjjtlciU66q9jqxUsAVDgIVlayeWsQ1NUQaCPZoNkFBpmiwv3?=
 =?us-ascii?Q?w5TBHouijcFaGBZyajhThWDM+17/Hawn/IF5k9RiRWjvNcucr82xz/HhGQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 18:31:46.4443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e1bba0-76e0-464b-88fa-08ddb4168aaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4263

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
you can find the iproute2 patch here:
https://lore.kernel.org/netdev/20250625182545.86994-1-mbloch@nvidia.com/

 .../drivers/net/hw/devlink_rate_tc_bw.py      | 466 ++++++++++++++++++
 .../testing/selftests/net/lib/py/__init__.py  |   2 +-
 tools/testing/selftests/net/lib/py/ynl.py     |   5 +
 3 files changed, 472 insertions(+), 1 deletion(-)
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


