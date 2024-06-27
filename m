Return-Path: <linux-kselftest+bounces-12855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 774B691A9C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 16:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039931F20DD4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A7D20DF4;
	Thu, 27 Jun 2024 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aILVPXa6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DA819;
	Thu, 27 Jun 2024 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719499781; cv=fail; b=adPTxcq+nKBeXJan2bLfcKP8Xz66GIzh9XVZLY+k8SWangmklUrSEheTh2KwlvaDi/Y8OVNOip3/g7CAgFqf3m3b7Ud/Dvzxqv6GNmAlf0qdInYvp8XXX3Gr8SaDUFkQma+VQDyLIGOnlmvfFONe9rc2bOSY73eon37xidUGFL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719499781; c=relaxed/simple;
	bh=LuZoSc4QQkqMMCVsLabsoYIfiYlOYu+SvkbUAvokPjI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ek/9Sbk0EuWA3bLFhnf85hNlOeuu7e0sHXtY6gg6AEHMTtpSg3oW62rj0VyUehK0QtyZuavCI4olCDX9nrQEEOgcAtWLWTWJybxSFG4vFNP/UtPktH0MOYZZagioKuKmuTYqxlzwAXolKNj7zoQzloJ2b+LokVyA3mNgv4zBzi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aILVPXa6; arc=fail smtp.client-ip=40.107.243.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R36UlE8CM7cyPYJeFJLPGwyWRcYAb/b4/0VsrbYc8Rn4Egfs5MGjNt/4ltuJ5Tuhh49YQc/LQEH8iO2awDPQ4+TBeg/KLW6fp3ULxvwZCwY9NeSupom4+VygL/JdnHnmXz7qUfn+I0pwbUllzSBjDmMLB3/bBTdyVoai8wUPYQtJkzgl3X6PHcuLgFpCGZxMei5Qpsk/ZO31GMjkrWH922NtNS0wzW/RZB6tbdIBY84rQ4LpEWGE7W8Gk9GttM4DZy+XMFxQ8fTEs7uAAtwoPD3fYHfEFeAT4oP74OOz7E8YumeKOK8Ab+gzrFq9Zuqc8ov1Cm2y3lov7gpqFZR/Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JE7lGmVonIGhdOWBlRSiSvhRF4QDBVXWseB6iO0Ttk=;
 b=PzZdpI00n4HzQ76lkPgA6bMTdG85nu8o6iO7RVcsPpGl7xJwBuEA4bi+gco8HOPOWfM4hsBNr1rrSuoxHDFqunBws8oP7g6caWUxF4Jcaidk9EKErQWb5EmUM9OV0dOKX2fvvplOr/3r4wIXPTvHBUW02alDAagPRV5oJblj49Ic7ZCUihH8hnCTj3wuJW98urPlaYAxnDnpMLwTQaWAkQ2skoAwk3kCYPushoyl+U9RtJUuIVLkTHL5j2iwhzaggM6htNoODCcx3zo5RF9Aptuu3+STFFHipWniSkxku7JUche+SomZUgPjVdKS1kVm4971x5Y39L6wF8OyW5DWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JE7lGmVonIGhdOWBlRSiSvhRF4QDBVXWseB6iO0Ttk=;
 b=aILVPXa6gS15dniUhus1MkByZpE65IqKzzzzORKqLYrKnzX3O3BldMprL/z5VMLVTi85ity3UkEGq4DuHDYvkoXFHmMpteZsozSNZWPD5IaCtw79e6ov4kPQZA3DARg8yNeEl7XRd37HBkJlL/rGkdLA8ZMy+UWSkRjMzH8EHEEb/dNAIGz22mye3jy0Mjm8ECp0r77zhZr04u0HJRZFLkoeJ3QFY8X24+fGVXcwFzBgQW9RItuqZRTIUpZGNTWxe1uZTndpFWcMFU+FzZ1DIuVQbE+s2s3b7ZjljM06/CYePQWW6JMEWmoK5ZjVP5IehX1dFJ/zhc6WyMAos8WIPg==
Received: from BY5PR16CA0025.namprd16.prod.outlook.com (2603:10b6:a03:1a0::38)
 by SJ2PR12MB8718.namprd12.prod.outlook.com (2603:10b6:a03:540::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Thu, 27 Jun
 2024 14:49:34 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::7d) by BY5PR16CA0025.outlook.office365.com
 (2603:10b6:a03:1a0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.25 via Frontend
 Transport; Thu, 27 Jun 2024 14:49:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Thu, 27 Jun 2024 14:49:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:24 -0700
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Jun
 2024 07:49:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Danielle Ratson <danieller@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 00/12] selftest: Clean-up and stabilize mirroring tests
Date: Thu, 27 Jun 2024 16:48:37 +0200
Message-ID: <cover.1719497773.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SJ2PR12MB8718:EE_
X-MS-Office365-Filtering-Correlation-Id: 9867e54a-c54a-4783-b71e-08dc96b85c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U3ex6OaIw7FY7jxKuWLqsVbTUH+hKO5J43OM7UVOW+mEo0v5i1sSlFlrI+Kn?=
 =?us-ascii?Q?g5uBNgrNF3pgL5TGLW8fEbg4xQSfIY8nAjUx4E3zkym9P8GVxn5X9FLS5rvd?=
 =?us-ascii?Q?T59YC7m49Wrpl2Fdm0f2xlPGzv7F+6FCXLzPGg4ZFuenX4PyAnfxtjmKA2AM?=
 =?us-ascii?Q?7DNrOpeQY9LlrEDGNJZpJ1uf7X+ikYieOSBpJBE3F27R5dc0sUOM3vUqcznH?=
 =?us-ascii?Q?VVMvf32nl51pEurH82fvFigAUaKOmbKzJ9xA8qsX1BLorHGYR+Guht9S9lqg?=
 =?us-ascii?Q?tR0BX3XD/nqyJsB02G+EPY6yfRXfdJVwNOU7N8eKVfw32M03JvHrtKAPN03d?=
 =?us-ascii?Q?gTZPjfhVIXhwWQv9b0BEyZSv5czqoN8eG65ppKW2Oe/xZGLJqNr0Qr/JyzYM?=
 =?us-ascii?Q?3Tb7YVDmEbBWCLY69RVbXeH4tbKSw/hnlajxlKW1kCrDn0LySmLDei5vY6fo?=
 =?us-ascii?Q?fTKFIBAfmv2ZMWqL9nxDscQsAW1Mjv0aLK6/M4obDBN8AzPxCiXwkGOweh6M?=
 =?us-ascii?Q?C69g1+Splf8nr7SkmnRZzDBzTaXJAaRkDuCtJ5+mxq+FqltVuDHjsTyAZKXA?=
 =?us-ascii?Q?jfiGhH0mcpVjAcQ9jbXFydjJbHJV2zguiyf3ZglIMJLxUpeeGEpoHzExMVKo?=
 =?us-ascii?Q?GDaSySSeP4ozYG97X3aRUFRdBwyQUmsOS5jH6qxBnu2O9cZqM7Jyn6q5tQUj?=
 =?us-ascii?Q?C74LDvmanudzRUM8eZTNEddq6jsuiWI3jNuIzZQn61NadJ+G/ehWmrfqZKM9?=
 =?us-ascii?Q?Puc8PfDDtT/iMii1/XC6sH2EXmq7LWe6YeNNeRKi6c7yPQExTk2RJZRbArX/?=
 =?us-ascii?Q?07U1GsyarluocjA9CKVMFOPAHhOkP12hyQPmR0NqM/Xr0PadOdsFi8sZAKDb?=
 =?us-ascii?Q?/xNn53aNidS4lCsRqYrtke9mdf/jvgnNuws9iJ9mIy271qibjjjiumsjbP71?=
 =?us-ascii?Q?StyFz1EFKfUKoiptxdzceeaP1uUUaubch5q4btd8bWtAwNwU2AFPwnlfQDdW?=
 =?us-ascii?Q?Brp6wYG0T/wG4Ub1Hx9JHEFpmvpJF98i5CNXg8TX22PJvAMHnhayFxeXMdkH?=
 =?us-ascii?Q?msBvsmfHs8LCTZ64SDuKgZ0HigXKuiy1y43QG6DVVTdXIwzl/IAPn94LN+kM?=
 =?us-ascii?Q?heEaAO/GY4Xg765mTfqsNS3BrdUMmUYyNA6c3iPj/ntDUz07A99pgHxJYVH3?=
 =?us-ascii?Q?624XakLO2TpK8Ro3sjSOa5Y722SLlb2b9n6Cr99Rv0u0K1ZgMvL3ZbkJim0U?=
 =?us-ascii?Q?k1R05cODa331W7RpO+nFV/8Nzp9rKf/4EnauAVVrzFb+HR72oPtahxHLxknB?=
 =?us-ascii?Q?8PGV53zKkGejOlnwFBXUv0s2DkZ9QQpa4PSTo/F6IjZn40U2G80JVp6S0cU9?=
 =?us-ascii?Q?ZpiIuyCS/pkEw/iWmdxwXQLhSbgyK9pdRJieGLwy86Not7Xh8f3Xmr7p1Jp0?=
 =?us-ascii?Q?OUQmPbHCSE5/FOSxoPjZkGrgZMq9+ESx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:49:34.4522
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9867e54a-c54a-4783-b71e-08dc96b85c31
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8718

The mirroring selftests work by sending ICMP traffic between two hosts.
Along the way, this traffic is mirrored to a gretap netdevice, and counter
taps are then installed strategically along the path of the mirrored
traffic to verify the mirroring took place.

The problem with this is that besides mirroring the primary traffic, any
other service traffic is mirrored as well. At the same time, because the
tests need to work in HW-offloaded scenarios, the ability of the device to
do arbitrary packet inspection should not be taken for granted. Most tests
therefore simply use matchall, one uses flower to match on IP address.
As a result, the selftests are noisy.

mirror_test() accommodated this noisiness by giving the counters an
allowance of several packets. But that only works up to a point, and on
busy systems won't be always enough.

In this patch set, clean up and stabilize the mirroring selftests. The
original intention was to port the tests over to UDP, but the logic of
ICMP ends up being so entangled in the mirroring selftests that the
changes feel overly invasive. Instead, ICMP is kept, but where possible,
we match on ICMP message type, thus filtering out hits by other ICMP
messages.

Where this is not practical (where the counter tap is put on a device
that carries encapsulated packets), switch the counter condition to _at
least_ X observed packets. This is less robust, but barely so --
probably the only scenario that this would not catch is something like
erroneous packet duplication, which would hopefully get caught by the
numerous other tests in this extensive suite.

- Patches #1 to #3 clean up parameters at various helpers.

- Patches #4 to #6 stabilize the mirroring selftests as described above.

- Mirroring tests currently allow testing SW datapath even on HW
  netdevices by trapping traffic to the SW datapath. This complicates
  the tests a bit without a good reason: to test SW datapath, just run
  the selftests on the veth topology. Thus in patch #7, drop support for
  this dual SW/HW testing.

- At this point, some cleanups were either made possible by the previous
  patches, or were always possible. In patches #8 to #11, realize these
  cleanups.

- In patch #12, fix mlxsw mirror_gre selftest to respect setting TESTS.

Petr Machata (12):
  selftests: libs: Expand "$@" where possible
  selftests: mirror: Drop direction argument from several functions
  selftests: lib: tc_rule_stats_get(): Move default to argument
    definition
  selftests: mirror_gre_lag_lacp: Check counters at tunnel
  selftests: mirror: do_test_span_dir_ips(): Install accurate taps
  selftests: mirror: mirror_test(): Allow exact count of packets
  selftests: mirror: Drop dual SW/HW testing
  selftests: mlxsw: mirror_gre: Simplify
  selftests: mirror_gre_lag_lacp: Drop unnecessary code
  selftests: libs: Drop slow_path_trap_install()/_uninstall()
  selftests: libs: Drop unused functions
  selftests: mlxsw: mirror_gre: Obey TESTS

 .../selftests/drivers/net/mlxsw/mirror_gre.sh | 71 ++++++---------
 .../drivers/net/mlxsw/mirror_gre_scale.sh     | 18 +---
 tools/testing/selftests/net/forwarding/lib.sh | 83 +++++++++++------
 .../selftests/net/forwarding/mirror_gre.sh    | 45 +++-------
 .../net/forwarding/mirror_gre_bound.sh        | 23 +----
 .../net/forwarding/mirror_gre_bridge_1d.sh    | 21 +----
 .../forwarding/mirror_gre_bridge_1d_vlan.sh   | 21 +----
 .../net/forwarding/mirror_gre_bridge_1q.sh    | 21 +----
 .../forwarding/mirror_gre_bridge_1q_lag.sh    | 29 ++----
 .../net/forwarding/mirror_gre_changes.sh      | 73 ++++++---------
 .../net/forwarding/mirror_gre_flower.sh       | 43 ++++-----
 .../net/forwarding/mirror_gre_lag_lacp.sh     | 65 ++++++--------
 .../net/forwarding/mirror_gre_lib.sh          | 90 ++++++++++++++-----
 .../net/forwarding/mirror_gre_neigh.sh        | 39 +++-----
 .../selftests/net/forwarding/mirror_gre_nh.sh | 35 ++------
 .../net/forwarding/mirror_gre_vlan.sh         | 21 +----
 .../forwarding/mirror_gre_vlan_bridge_1q.sh   | 69 ++++++--------
 .../selftests/net/forwarding/mirror_lib.sh    | 79 +++++++++++-----
 .../selftests/net/forwarding/mirror_vlan.sh   | 43 +++------
 tools/testing/selftests/net/lib.sh            |  4 +-
 20 files changed, 355 insertions(+), 538 deletions(-)

-- 
2.45.0


