Return-Path: <linux-kselftest+bounces-42389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5CEBA0E84
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 19:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEFB6C20F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 17:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683930F55D;
	Thu, 25 Sep 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kdQSv3Rd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010000.outbound.protection.outlook.com [52.101.61.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDB63101AA;
	Thu, 25 Sep 2025 17:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758821633; cv=fail; b=NS6YtmNq87K7cMTmlIIF/+jL2xm4VOd4/9jaACiWHxVjMMfFa1CmodxHT9sk9BuV6BdVZOzy2jbQay5KypiSbfBV4YpZKoCZJltQgDqAvhoSWnQSWM/LJq+6MwZVR3QPonj0OcbIarqXx9Ii3gOfB/1VoP14jRBq2wy9Uz0iSGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758821633; c=relaxed/simple;
	bh=riCdUvX7mDFVqqcQWFalwNn9+Xpdc9xAcFQw22zmcrg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8V32OPrUzp5lMwp7OZx4etNf4qfjzJ29jjTQ6Wb+IMFkoZj6yyRXKbEPlvRVou2m3Gno1iDkLqms9bAwh3uzVdtSAShQiall1G5qUfKyaw+4pK0VEItGWz5fZ1XJWa9cUZhMguEv2UL5i6P4AFS71EUztoigp7zB6ZAU3JHCpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kdQSv3Rd; arc=fail smtp.client-ip=52.101.61.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMgyBUTuIiZitqxx6eRAIawzafTbX7ls9kmOp/IDcRY5v6nnGz3ZgRXRDrumiXCOJcW+JRi5Y2G18QBlqtazsx9nYTgINBD/8Ua4ikpLSUHvCqb7RQvpCwz3hN1DqLrJElFjd8sXTFveXRkPoyQsubteb6cw++3CR/QMuVse6yYHXXMA/pksNkTZrBZO2yGloCpfdbguhYdaWVy66toMtZErNEQsG7hblE0A2NjeqQZb45+ynjpZ+7gk/lwtVdIMZgCK3Nfy6e8PpxeyCTboUDMITpBtAMi8OmMEtrgbuMy9UeiyUfzzwybTFVxTmvnPl5K/wdUlNZCVdxbOhVbfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDTnWbgQL8NkjeuL4WZuzTCt+hn7Y9mH26/+t/tv2Yc=;
 b=AjWuaBqfXdQWDmoE8ruV6okdfcok1e8qvOfZbIQ6Omj276qH95Ds6XdgAybyv8DwtCmAQ57EVfCGAxVDqOKe129WUNmjuPdFvyHhkJOAV32m/g9qRlMDOCEfZDXid7qH+DtMPGk5vc3msTl+UJJTJG8gM40D5u70+S10g1E/0Elf78eWoHDwEUFlWtRTNbk2iLVylXJrj6Sx5iPyZhQQMg/cr39zxNIkBr3Ab7RhVd9Hc3IqquPDWnOTWIlGyH4harjCZV4+LjO6MKU2zmXLAMQhprYZnmJbkrQpvZ9W/4CdY6Ax44FJFXxt3bCntRZ0+rQN8foaGco7Oshu3G1i/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDTnWbgQL8NkjeuL4WZuzTCt+hn7Y9mH26/+t/tv2Yc=;
 b=kdQSv3RdWpMxW2yT/HgijxLGCubRxHS2ylg2bzot/raqspDuyzqyzDBpCOTJz0Y+lztqrSjIWGvhdNeL/ipF85LYWhByTag2Ygy3lO/5jyQL7njN0vusySx1UfTCr7XO/y/FWjegVpQU0/e2ATnQBn8RhKi4jKfscXMKBQFJOkeTcz0Eg//HvzcEMyfrJaJpdloylc6zihepx9F59W1oE5K//NdBC8Z8JjMsyU/Wqao3+F1jsjulFJXakP/SEgMKcbJHE66Cxig0k4jJ0qNSQMPKqLADDsiTlC2kIQXKgvLrLXeMKjtSrtHneqLZ9JqEz78yhsFCyXh2iybQv1mKuA==
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by DM6PR12MB4170.namprd12.prod.outlook.com (2603:10b6:5:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 17:33:47 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::89) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Thu,
 25 Sep 2025 17:33:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 25 Sep 2025 17:33:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 25 Sep
 2025 10:33:24 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Sep
 2025 10:33:19 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"Nikolay Aleksandrov" <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>,
	"Shuah Khan" <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/13] selftests: Mark auto-deferring functions clearly
Date: Thu, 25 Sep 2025 19:31:43 +0200
Message-ID: <cover.1758821127.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM6PR12MB4170:EE_
X-MS-Office365-Filtering-Correlation-Id: f344e1c1-0a96-4392-b589-08ddfc59ae4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+hqLfh1on3ke/lexPyXGWRKah+5IWSLnjjnmFiQpMlm26zJ/BR9n2873yRD7?=
 =?us-ascii?Q?0Dty8bXTE1NFnBuWIbQ/Nm+CTytoZNHsikSZw0JKRGx8+swkeFPd7xxu8a1w?=
 =?us-ascii?Q?5XwvKyB6+D1eqK9fFwYxIBa3MvPzftW85pWj0ETPz2/BzCJCKZnQLtno2u5E?=
 =?us-ascii?Q?Jd52FPlBKul3onqkiA85Zz8GbdhXQY9JZFdeFuB5auhZ3ESl9lfDHDXNA+zH?=
 =?us-ascii?Q?wLxMaVq5RrvmeKHNjNqt9GaGmic9Qb3+PbM4P2ybG5obStfcCRMhJpeVNOMB?=
 =?us-ascii?Q?6UMn0XcK4yCx6nXhYyW2ATmFrmoYLa8k7Uuiz/EUYJFiXtN4zwIrEokkhley?=
 =?us-ascii?Q?N7Hb9ndQbDq4KPp+kYbqzENS1MNFUbBQeNY5gD+ta9ArjqCR5B3K6kvcvV7H?=
 =?us-ascii?Q?Mkatm1V8EBE1BLe+9WMR7tCAqXi9wjtTxB8nbc8ro0VxZyB83mL2p4Ti/jI9?=
 =?us-ascii?Q?THNmV2m5PfMi0oI6oIKhFoTX9w4fl3mxb+/vNZ2uDOzFxQa75PNdIPjXp7bt?=
 =?us-ascii?Q?KAJmHXxB7jCr/TTGfMWVrj0lfwV0QMUeMNyS+//s/GquChsgMHYw8bwHuZNm?=
 =?us-ascii?Q?dImQYoMVIB6BLNcnbQdVScViQpFRxhRptm5rOwiJgMcUbXBbn8TYqOBcQEmF?=
 =?us-ascii?Q?rIw8ECJ+YLge6+y4v5XSQpGbXI7UnaGTyep/XVdSkqRHGEHNOV7lSdOMLQ5+?=
 =?us-ascii?Q?Yngn41/MTVqQlLmifhAHJ8qBy1xoiH+ktQu5WoavihGgxqkvoQ/I+7XOmmbb?=
 =?us-ascii?Q?VFuy4PIVBhUui0x8ju3Rhe6yDSzD/TwMz7cpiqztqBljXvy/qUDjH7wqCZBr?=
 =?us-ascii?Q?Dqg2d7ni4/luhR4H0bQf3lM2d9evHbRX5wq1sk8gqY7Kn1K7Ax/8fP3dyDgN?=
 =?us-ascii?Q?23OCPz8TLdfhhh8o3z3aAcnccEt1muNBI8YDl4oq2flJhg0KvoLsHXzDieLp?=
 =?us-ascii?Q?ATZobHsgPU/y9c26Ut15xVsn3zuBJXx5qP/r62zWFnXM0YCF7q5GTxVLONyU?=
 =?us-ascii?Q?Sro2sWSr5flT2bJuG+FKEm2GoG62+AWMxPN80Yg+SyEnQ5AOavLc4mKAD4tY?=
 =?us-ascii?Q?DZxLctb+v0UXiE1vQfp4HfoEh/et8k41+8pTg9OS1ycTJdh6BiraHAGc17PE?=
 =?us-ascii?Q?By9sehVT4xSJGdb7z4r6yHS0O+wch3YMIhPx5kDovhWVHUzTGc/WyFWo+Lg/?=
 =?us-ascii?Q?uLmwvHq+sLM+EAIssj7pKNNyPq8FdDD4zoatHn6so5JP22P4EO/x+JNhZlV2?=
 =?us-ascii?Q?t3SyK5pbH8GwcIr1UiIlSh12A1jVSVLnUHJg7o9EMwH868lt/46Y15OZQg81?=
 =?us-ascii?Q?93hN89eoM9Xb4faytRAfdlNy3p0r9F7WcENDxJ9SFpNPque0QMGfa0NtwPqm?=
 =?us-ascii?Q?4pVm69oBcw/QEiMcN2L2fxfGwFWjeGM9Yet2MUfHr/8/12YRCHVVC5/GqPaw?=
 =?us-ascii?Q?GsVrprlmJl0Lcnj9+iZirenZNv8r5znOnF8K94CvOn4ruIKnzK8sUzZWPCd1?=
 =?us-ascii?Q?Wij1gkHa6OVhKj82YpzZiFr2Q0/cOmi9PoN7umCAoJqCvpoPTd07l+mRVfX9?=
 =?us-ascii?Q?p83UniGQSYMY3VG9B3g=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 17:33:46.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f344e1c1-0a96-4392-b589-08ddfc59ae4f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4170

selftests/net/lib.sh contains a suite of iproute2 wrappers that
automatically schedule the corresponding cleanup through defer. The fact
they do so is however not immediately obvious, one needs to know which
functions are handling the deferral behind the scenes, and which expect the
caller to handle cleanups themselves.

A convention for these auto-deferring functions would help both writing and
patch review. This patchset does so by marking these functions with an adf_
prefix. We already have a few such functions: forwarding/lib.sh has
adf_mcd_start() and a few selftests add private helpers that conform to
this convention.

Patches #1 to #8 gradually convert individual functions, one per patch.

Patch #9 renames an auto-deferring private helpers named dfr_* to adf_*.
The plan is not to retro-rename all private helpers, but I happened to know
about this one.

Patches #10 to #12 introduce several autodefer helpers for commonly used
forwarding/lib.sh functions, and opportunistically convert straightforward
instances of 'action; defer counteraction' to the new helpers.

Patch #13 adds some README verbiage to pitch defer and the adf_*
convention.

Petr Machata (13):
  selftests: net: lib: Rename ip_link_add() to adf_*
  selftests: net: lib: Rename ip_link_set_master() to adf_*
  selftests: net: lib: Rename ip_link_set_addr() to adf_*
  selftests: net: lib: Rename ip_link_set_up() to adf_*
  selftests: net: lib: Rename ip_link_set_down() to adf_*
  selftests: net: lib: Rename ip_addr_add() to adf_*
  selftests: net: lib: Rename ip_route_add() to adf_*
  selftests: net: lib: Rename bridge_vlan_add() to adf_*
  selftests: net: vlan_bridge_binding: Rename dfr_set_binding_*() to
    adf_*
  selftests: forwarding: lib: Add an autodefer variant of vrf_prepare()
  selftests: forwarding: lib: Add an autodefer variant of
    simple_if_init()
  selftests: forwarding: lib: Add an autodefer variant of
    forwarding_enable()
  selftests: forwarding: README: Mention defer, adf_

 .../drivers/net/mlxsw/devlink_trap_policer.sh |   9 +-
 .../drivers/net/mlxsw/qos_ets_strict.sh       |  12 +-
 .../drivers/net/mlxsw/qos_max_descriptors.sh  |   9 +-
 .../drivers/net/mlxsw/qos_mc_aware.sh         |  12 +-
 .../drivers/net/mlxsw/sch_red_core.sh         |   6 +-
 tools/testing/selftests/net/fdb_notify.sh     |  26 ++--
 tools/testing/selftests/net/forwarding/README |  15 ++
 .../net/forwarding/bridge_activity_notify.sh  |  21 ++-
 .../net/forwarding/bridge_fdb_local_vlan_0.sh |  65 ++++----
 tools/testing/selftests/net/forwarding/lib.sh |  18 +++
 .../selftests/net/forwarding/sch_ets_core.sh  |   9 +-
 .../selftests/net/forwarding/sch_red.sh       |  12 +-
 .../selftests/net/forwarding/sch_tbf_core.sh  |   6 +-
 .../net/forwarding/vxlan_bridge_1q_mc_ul.sh   | 141 +++++++++---------
 .../net/forwarding/vxlan_reserved.sh          |  33 ++--
 tools/testing/selftests/net/lib.sh            |  16 +-
 .../net/test_vxlan_fdb_changelink.sh          |   8 +-
 .../selftests/net/vlan_bridge_binding.sh      |  44 +++---
 18 files changed, 225 insertions(+), 237 deletions(-)

-- 
2.49.0


