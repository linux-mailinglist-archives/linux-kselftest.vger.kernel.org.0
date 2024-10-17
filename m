Return-Path: <linux-kselftest+bounces-19937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3628D9A1ECA
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96B3282246
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF2F1D95B7;
	Thu, 17 Oct 2024 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uMeb5V1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81ADE1D6DD1;
	Thu, 17 Oct 2024 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158433; cv=fail; b=euV1ao20e9f81ExJLqHiQXzyKijOdsMf1kmul+CqvppVpcOkyyucTH2gBPSM8/QwT9oBySMD0DxTSfinegDK9nwVRUxx8EL/1e6noGcOG6wGq4omsErUP+mzqT+r4hLoT1sS1OXs+KauHxZtSo+rMl3//Ro4ToBJsqDRW34wQuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158433; c=relaxed/simple;
	bh=b3xf5P2pCNXQvZysfgNNxHcBUXG9uRp9LoQGr8u8Rao=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NgdLwzU3wD/4w1XuJPAL2BTFuD3+OhJVt8b+2Cff4+/WP3sEdh5QDUMmPIXnPiKbc2gM32qpTljaiJ6lR3IB4A9far9VbIk4g12mO5NlTd4U5s389W46ySsvN3YmDUGDdiRp5BjjqT4cyt1RFZ1aeHDRgfkTFma6vGUMAf9iqcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uMeb5V1P; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ejkTRNqZk2G0c3ro10uNzSC7d/9biEpP87lf+RaIE+RXNI6yN+yZ+Gi/eFcR72/vTu44l/Mr2CtCHvh5OF5+WZClphT4Olt6mg+f7RHL/BUegcy7QLolOUejalW0LzQqwggkquXBe3wv2NWbKYnITNtuQt28DRBxuzJHXxuLK1UycXK8RqKUROXz+fznhfqTH/hnr2XHx50iNGGRwIutMxgoPktHZf/XLSkGfVRCHFlF29EC2SB/Uz2NhiTCkNViYSbhZYPA2JZode3q7/RB7pdHo7D79ntP57gI3zhhmw1/V1A1yBD0T0bIuX3fTXRlAQ7jpTgFs+iqAjdY7xzQTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3kUa5X4xhY+Gu2J8Jij+sJKNEuql2LIobzjTcPF6vUQ=;
 b=QbO7TKFIj0CpUE9qGyBes83JCWubiHMdiYzZH1cuQ+UjoIYsCyMdN7KkX2EZ+dFdlyArNv5/8nQ4bgk+BzlecmPs9ZhlXZfTp1lj+t2gYZkgY/XFUgP7lxLnqWGl3FXhTeqnj903EZiEuAKql3bmt1FXkb4jmdFmK7ipgBT6oUVvYRShmCHiz8Gyn1CtGR58rlcQ0nAW8jmCPJiIvPMaCVbyvPF1A4VpoX1U7BD9o/jemHTeodFLHQT7qTPw48M4rndCYigkoqusUEWkE/ss6vhIRPzy93e+GxgPYUELz50ggGiFL0FRW5bQgwUYTW5XloZ9uSmjlcuudE+OFj+1sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3kUa5X4xhY+Gu2J8Jij+sJKNEuql2LIobzjTcPF6vUQ=;
 b=uMeb5V1PqG+wwq2dSzg7SgmdXUVn4kFqZbvjC631uG3uWFisgjNPiTRcQfVBuFb5tCrIoUHy8IHR7+EHd6ssutfG9qrTL+qcvHboCvRBwZ0qz75HY+qtxWcIzYvcwdYVbW06sNRsrJxqJCg+PgPqsnyi/DA83sXRXDQgz6XEOnJVB/gYXs/RdpRCNbH44M68a7/g119YYjv8YNVgLZX4bAeGeYnpMLaMeXclDbFLyZ3HMOr2QojAp4EwCXssEHTXXLkOI5JW1e2QBVBuNRiSWqT9d4Px1nJzqkNAq9H47IBtpmOPJWBWgbLARrUOrkRe+L1oFxx3WpECpoasJvCeVw==
Received: from SA9PR13CA0170.namprd13.prod.outlook.com (2603:10b6:806:28::25)
 by BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 09:47:05 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:28:cafe::20) by SA9PR13CA0170.outlook.office365.com
 (2603:10b6:806:28::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:46:53 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:46:47 -0700
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
Subject: [PATCH net-next v2 00/10] selftests: net: Introduce deferred commands
Date: Thu, 17 Oct 2024 11:45:42 +0200
Message-ID: <cover.1729157566.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 84002106-a26b-4555-cf09-08dcee90a81b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JTh7Fo4XcSu2N7+aso3M6K3NXx0wGp8Lvl3yj2L6H836u2JrR/kaqri+xb0D?=
 =?us-ascii?Q?gTLkx8QQOOzONHbSoHR7TNUN9yW7GHmH0VWWOMjRZ91fvnSoakl/Y2kXh6uY?=
 =?us-ascii?Q?umUUllom39i2KRDn2EU0adNqyx1ArOJ4qZDZSoS6n5xfJ1zNpq3PvUGx9LV1?=
 =?us-ascii?Q?+bz7Pd8+G4PpljxGgBwW/2sONpfHI6CH84ym59H+uSLiYyPq4ZPj2Ne5flY7?=
 =?us-ascii?Q?Ctf0cy4PC7yPzvonj1NGF3wemITbN0pELxCcWIq3TKeXtI4MKrCTEcjSs4GN?=
 =?us-ascii?Q?sbG2O969n3SQdf2APJwRjpfBvo+6YQ1Tww2yBOxhuyrLkPG/gyvnkoidMUGF?=
 =?us-ascii?Q?4t52rOUlndtwQ0Gdby3JgJpC6iBmKbxULve6OAcC4H8Kriq6gc2D+XmkNXgZ?=
 =?us-ascii?Q?i7eqrTBE9NVJh97QiggM2Lx62JxRctbNftMDmNijd4ut9j0fWel6lVBP0BbG?=
 =?us-ascii?Q?Vfe+3CybGazC/RmebhhnRY4LLXO8lWTgN/9h1Pd+/ik87L8S/kmh5gT+O8Al?=
 =?us-ascii?Q?Z+E2uwKGPnnOXHgEonNAP0zvhzvGNmhVsfCRXsZwMAPehY83Xc6O7nmaEYg4?=
 =?us-ascii?Q?06nwx5R8d1SdOzfXzEF6700PwtCty+cQVm3zoxTt1cRp4Bu9GJhPhISPjaI7?=
 =?us-ascii?Q?b3qgi2weQGvNL8MpSRVuK83+0KrUit9tgVF1S508kFxQiuiZDJ6nI8wFU66S?=
 =?us-ascii?Q?mvtAI9VIO2a9XJD+3r50zWvc6FK2pPXT2OcEExSfwmxxrpN9Tj8wmIkREU/V?=
 =?us-ascii?Q?vbQoWr5BC/4DFmzEhsLumSSDyqoM1RuyGojeXDbEqm6WiPmZ/YjgVjIt7E6f?=
 =?us-ascii?Q?LtkgdAtLnkKhFAnm0FbvM+YkNH/wJjjM5mkXG1wAlLBj+6vil0zLF12dhVkl?=
 =?us-ascii?Q?NApRmhdKRtLugHbMGgnTM4DeaWcpDUAtuqw/JFdH0EzZSxgKuK5kBCzJe2Qc?=
 =?us-ascii?Q?eCPBTM3u0w3OF3mVhDQAkeakMVA8F9Nqy4kAuzEt1/YquKZrE4G6+EIofsjO?=
 =?us-ascii?Q?I4Zc9HylNL5M0hZEsYp0Fy9gmJjK70O6H/Cylkm2/maf8eflJiBtQsU3IC9p?=
 =?us-ascii?Q?q0iFm2sZlJi23XuC/ISHG4fdek53rVZUBJVpNmUn63zeMxdkQBlwjTgb+rhu?=
 =?us-ascii?Q?Iug4LRBIQGF7GNLSo9Zq9fxHA5rgHD3VyMKf8KR3otXgalSvN7yVCgi0ds9B?=
 =?us-ascii?Q?I6p4Nk5iqEzYalVL2lo5Cg/RxTntsserbzlftiO6xCQYve+jtqLBcylv8mS8?=
 =?us-ascii?Q?pXu6AuksCarF7dxUiRrMtvmr0pVA8l1xHFzWxqcsLCPkdu2RYDTCeMu5c2L7?=
 =?us-ascii?Q?b5SLEcpA4Ae5Rp0pw712uP9V0rLWf7EgkP7bmdaKhptvL66FZCaO4OG6PO6q?=
 =?us-ascii?Q?BCiAbPOR0D5AqDrL/u0Utw7BWRwWmMz9NS1o1kPGQewZ3CcF6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:04.1457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84002106-a26b-4555-cf09-08dcee90a81b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132

Recently, a defer helper was added to Python selftests. The idea is to keep
cleanup commands close to their dirtying counterparts, thereby making it
more transparent what is cleaning up what, making it harder to miss a
cleanup, and make the whole cleanup business exception safe. All these
benefits are applicable to bash as well, exception safety can be
interpreted in terms of safety vs. a SIGINT.

This patchset therefore introduces a framework of several helpers that
serve to schedule cleanups in bash selftests.

- Patch #1 has more details about the primitives being introduced.
  Patch #2 adds a fallback cleanup() function to lib.sh, because ideally
  selftests wouldn't need to introduce a dedicated cleanup function at all.

- Patch #3 adds a parameter to stop_traffic(), which makes it possible to
  start other background processes after the traffic is started without
  confusing the cleanup.

- Patches #4 to #10 convert a number of selftests.

  The goal was to convert all tests that use start_traffic / stop_traffic
  to the defer framework. Leftover traffic generators are a particularly
  painful sort of a missed cleanup. Normal unfinished cleanups can usually
  be cleaned up simply by rerunning the test and interrupting it early to
  let the cleanups run again / in full. This does not work with
  stop_traffic, because it is only issued at the end of the test case that
  starts the traffic. At the same time, leftover traffic generators
  influence follow-up test runs, and are hard to notice.

  The tests were however converted whole-sale, not just their traffic bits.
  Thus they form a proof of concept of the defer framework.

v2:
- Patch #1:
    - In __defer__schedule(), use ndefers in place of
      ${__DEFER__NJOBS[$ndefers_key]}
- Patch #4:
    - Defer stop_traffic including the sleep. The sleep is actually
      necessary and v1 was wrong in that it had the sleep prior to the
      stop_traffic invocation.

v1 (from the RFC):
- Patch #1:
    - Added the priority defer track
    - Dropped defer_scoped_fn, added in_defer_scope
    - Extracted to a separate independent module
- Patch #2:
    - Moved this bit to a separate patch
- Patch #3:
    - New patch
- Patch #4 (RED):
    - Squashed the individual RED-related patches into one
    - Converted the SW datapath RED selftest as well
- Patch #5 (TBF):
    - Fully converted the selftest, not just stop_traffic
- Patches #6, #7, #8, #9, #10:
    - New patch

Petr Machata (10):
  selftests: net: lib: Introduce deferred commands
  selftests: forwarding: Add a fallback cleanup()
  selftests: forwarding: lib: Allow passing PID to stop_traffic()
  selftests: RED: Use defer for test cleanup
  selftests: TBF: Use defer for test cleanup
  selftests: ETS: Use defer for test cleanup
  selftests: mlxsw: qos_mc_aware: Use defer for test cleanup
  selftests: mlxsw: qos_ets_strict: Use defer for test cleanup
  selftests: mlxsw: qos_max_descriptors: Use defer for test cleanup
  selftests: mlxsw: devlink_trap_police: Use defer for test cleanup

 .../drivers/net/mlxsw/devlink_trap_policer.sh |  85 ++++----
 .../drivers/net/mlxsw/qos_ets_strict.sh       | 167 ++++++++--------
 .../drivers/net/mlxsw/qos_max_descriptors.sh  | 118 ++++-------
 .../drivers/net/mlxsw/qos_mc_aware.sh         | 146 +++++++-------
 .../selftests/drivers/net/mlxsw/sch_ets.sh    |  26 ++-
 .../drivers/net/mlxsw/sch_red_core.sh         | 185 +++++++++---------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  24 +--
 .../drivers/net/mlxsw/sch_red_root.sh         |  18 +-
 tools/testing/selftests/net/forwarding/lib.sh |  13 +-
 .../selftests/net/forwarding/sch_ets.sh       |   7 +-
 .../selftests/net/forwarding/sch_ets_core.sh  |  81 +++-----
 .../selftests/net/forwarding/sch_ets_tests.sh |  14 +-
 .../selftests/net/forwarding/sch_red.sh       | 103 ++++------
 .../selftests/net/forwarding/sch_tbf_core.sh  |  91 +++------
 .../net/forwarding/sch_tbf_etsprio.sh         |   7 +-
 .../selftests/net/forwarding/sch_tbf_root.sh  |   3 +-
 tools/testing/selftests/net/lib.sh            |   3 +
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 tools/testing/selftests/net/lib/sh/defer.sh   | 115 +++++++++++
 19 files changed, 595 insertions(+), 613 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/sh/defer.sh

-- 
2.45.0


