Return-Path: <linux-kselftest+bounces-19339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C24996996
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 287672847B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3208192D70;
	Wed,  9 Oct 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p4Xy1EUY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E1C18EFE0;
	Wed,  9 Oct 2024 12:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475785; cv=fail; b=KVwHkh/r3dKy6DxduOa2v6PZIDbC+7eRiZDR5SQZMPg//5JPvcOMOaKlE+NgJSD1a95hHpXkxecBo0R5TRrlkw8vq2Qu4hpMO5tDblj3xQo3i4N0IaJCSfarqv0Y+4+sR980gAmrgHlH38KxNRVr2CGS1q2UWaZsxx+JEhA5ubE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475785; c=relaxed/simple;
	bh=8eTAhafly0Mfvshg6/RwMFAf7yM0TeCsjNHdMfGrd10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lYIMXQnU9BNrGpUKDnCv4xvPvEpslPkJADigPWi6LruYtL+tPENCwjCqgVNt7jlhqtjNsoLzLhaxcVSElTURFke80ZwZl32zoFXuMrWgU6lXjz/bq5mlMFAdrHa4+PdrLuzYLVgfD9jVZqVFuA5m7t1G8arK8eNMdVA7KolwroM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p4Xy1EUY; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuUvnJVnsaBomR7/gWwwvUyXxmA/ycx2r6RU7/9r2/G8BnAYVhbxOabPw5rzb5VqDqwf0F4zDbLhDLySwKbrC46bNodS/NgbY3GSDZvosK9jfpqkDHhx3bfEr4NYTQVgcrurNIb5jtRjts2kn6pWS0SIOoHqWzhXx7gYjddj2mJ/Fj+BrKDGkNOXOQrSlu4wtjeuJAJutwXE7LfqSKZKJUDjDut3XsApAfANNYIiL5i988aD3dSow/ReSOuzj+o8rImOe3TghAK0BhQh52nKFiqk2/OUiEBLKpb2WQEvHKTgqqqdgwkFf6bx6ybHgmoq0VNRb+EpaEkeWOlEgFwSYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gNc6MMS/BlvVKe4601stBCiVf8UuGnJz+JaIMw8O8Y=;
 b=shzkb0Yy90s7WT68oah6/5CKU5Se+v87mfTAvlRLYCzFkj5W2SOEfiLbx33h4+dfi4KFdahF1Zwa4EBN36CPVZ74muKuQljkJVNolSE8MY94PAdwv8hzZIstFHxr6PLe3/dmEISclTGHh4ZK3fXwy5wXrLF17ExUjegGGsO37WhRrUdiv6sOUpsvwrzm6bWbbCAwDS7qcY6Hm5rYdx0nlqDsHj5NRH+n7hI0w53uMJCbgZPtWdScUoZCZ1CRW6C6xKuJv9jHtMJktkkYH/ljb2tEOGk3RttwC3dnVeuwOlbkYFO9dClRp7TmWPC142GNobmPAOJeuodr4BoiZMjUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gNc6MMS/BlvVKe4601stBCiVf8UuGnJz+JaIMw8O8Y=;
 b=p4Xy1EUYzxuzGTZxKVol5nla5037h9AhHQQakioNn5RP8MnRDi+pp659RVKyrHUhnjdi0X0IoR2XXoQAJC3jiZURdsdwR7/2IkgJHlKPY/pMCfVyBV/I6MbP1kmhwMy+I7cO9qQttfAz8Gk7SaxpUSKfmWG/n/DRoSoZb6ANcGwni3K+wTn2c7sXQR47EKl48renNRbF5Ebs+qhZ7CcASwbs0o/v/EBTvY8pIf2s6mo8X07oO/jr0nSYFirNti0DzvNVWcAhPnCzajDBwgw2p7py601a+Oyl2mQLC7BFfmY983TQ5gTtf0OLNM8LlcrEuadiX9ny16O5LGs/HGJWKQ==
Received: from CH0PR03CA0422.namprd03.prod.outlook.com (2603:10b6:610:10e::19)
 by SN7PR12MB7130.namprd12.prod.outlook.com (2603:10b6:806:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:09:34 +0000
Received: from DS2PEPF00003448.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::c9) by CH0PR03CA0422.outlook.office365.com
 (2603:10b6:610:10e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.25 via Frontend
 Transport; Wed, 9 Oct 2024 12:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003448.mail.protection.outlook.com (10.167.17.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:09:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:18 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:11 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 00/10] selftests: net: Introduce deferred commands
Date: Wed, 9 Oct 2024 14:06:18 +0200
Message-ID: <cover.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003448:EE_|SN7PR12MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdff7fb-2b7f-4d0f-d03a-08dce85b3cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?juNdZ8GB/drQaw9stWroSvgs8gOz8dIQP3WnQ4mWOOA1dMULH1bJtgeFkED5?=
 =?us-ascii?Q?5zjNFarKDTFJIkW5a9BvMiyioWhMJRX78Fq7fDRn5qLpY1KL3nSHEABzlwPy?=
 =?us-ascii?Q?7f/HpYPVk1o5xo9+k7AOOClg7y1ajMfuh3OO4vD9H9LybKsb/6Cj8zjIV4ge?=
 =?us-ascii?Q?vjy9MCPW2t/bwrXuIxmSKqxe6vxPpr0IWaDR4n4TScni/UvVtHBLrAARMQB1?=
 =?us-ascii?Q?ak9MmtU9qqXRsHzZ4T2ATColG5QjMpyU8n5/iwP8AVvNbONdlD/So6TrTh5Z?=
 =?us-ascii?Q?0oACfkPJxZtfrXotT/smo2jnP4w5NRvk3h87m6FUnCOlhH61iexvTaKFFiai?=
 =?us-ascii?Q?T35dFuGhvj5xbl/se+4T+WQOQGPBipVK0K/Ps38k6O41CTq/SbthmiYbwLBo?=
 =?us-ascii?Q?Mwe+jmiojgCzx+pigR+chRI1PDdSAW7h9s8JVdWa+PEFJYwN6tB8+FKZkkWP?=
 =?us-ascii?Q?G39TmcwyN9LlKM8mvdI3kYaLJPgy77PeNd8/hKS1wkeUBALC+XiAtappbh27?=
 =?us-ascii?Q?mPL66WqJbwDFhmESZwpaxBOZU+TN0OBKhMRAo4u7n1en1R2JO3AWuVoOHQGQ?=
 =?us-ascii?Q?6Fgn5231suTCTTvnv/+R5AqJFTfPN0pZuPbSegLJBgc6n7dlnYs3bTuIVsW0?=
 =?us-ascii?Q?Ue48wBtBEnRxN8wfiK2LQEj9Kso/aMrZ0lkx4qyqD5Ne5FwDejZ9Akr0cxSa?=
 =?us-ascii?Q?K8CIwlXoBcmC5UbjPTLjYTfICc4XyCnMfYn2rC86hBJx/OtwP0oH53xeb7PT?=
 =?us-ascii?Q?vMS3Sg/aBYwjUTtS4OAjbYo3ewk7T2bob0UuCqs8loL8DIzurpcLkMy+EhzP?=
 =?us-ascii?Q?YX+2BulXNpuQC8iLY8DwG5JF898FnF1T9EZQ1RaFZgip/RRrTvf7JJ3yjaI/?=
 =?us-ascii?Q?UCgefC6L8jJWDrlYvNV7sBPQ9qzKhBzqvO3P8hANVhcFvxfxDLkAVbsqIZPm?=
 =?us-ascii?Q?re5ZAojJpSb4i3tFLlmIjvHi18mlM9rNJxsYW2cbL4WGr1lPib2iUFBWJqWZ?=
 =?us-ascii?Q?PsH2O3m7t2XBYjElUbDPeAQ3mpi9cPQ3MEIIRGdT74YWrsSf/5cDoFvuond+?=
 =?us-ascii?Q?ZRY+wewydGP42ixURH4qXVaDYBjOJLEwXcBp383eiUny/E+F94cpbQJQa3mb?=
 =?us-ascii?Q?Tr26T3ExBGhCDpl1f4IYtvOWdFhfGt9U9cMLIAYjsz+swTwaOjXVSfxNOWFn?=
 =?us-ascii?Q?Jt9/9PucbQUhGCA2GHWZYBU4qeyyZ2EdXutKa5yLHNGhbDVVOMFI6SnwFwiv?=
 =?us-ascii?Q?2i2i4bbnjNRe4E+czwoH+GxDCZXMtapdRwkgJjrGZT9wVsPHWJmQ+tK5W4ib?=
 =?us-ascii?Q?k+JQGdMOytVcs1hNGWAbHvb7Go5ooIgSBm+/RG7rxp6f3Yi4uH6IGhAcqfiC?=
 =?us-ascii?Q?RVWiur8x/SCSQbRmZvxIqp8nZUAF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:33.6053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdff7fb-2b7f-4d0f-d03a-08dce85b3cad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003448.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7130

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

 .../drivers/net/mlxsw/devlink_trap_policer.sh |  85 ++++-----
 .../drivers/net/mlxsw/qos_ets_strict.sh       | 167 ++++++++---------
 .../drivers/net/mlxsw/qos_max_descriptors.sh  | 118 +++++-------
 .../drivers/net/mlxsw/qos_mc_aware.sh         | 146 +++++++--------
 .../selftests/drivers/net/mlxsw/sch_ets.sh    |  26 ++-
 .../drivers/net/mlxsw/sch_red_core.sh         | 171 +++++++++---------
 .../drivers/net/mlxsw/sch_red_ets.sh          |  24 +--
 .../drivers/net/mlxsw/sch_red_root.sh         |  18 +-
 tools/testing/selftests/net/forwarding/lib.sh |  13 +-
 .../selftests/net/forwarding/sch_ets.sh       |   7 +-
 .../selftests/net/forwarding/sch_ets_core.sh  |  81 +++------
 .../selftests/net/forwarding/sch_ets_tests.sh |  14 +-
 .../selftests/net/forwarding/sch_red.sh       | 103 ++++-------
 .../selftests/net/forwarding/sch_tbf_core.sh  |  91 +++-------
 .../net/forwarding/sch_tbf_etsprio.sh         |   7 +-
 .../selftests/net/forwarding/sch_tbf_root.sh  |   3 +-
 tools/testing/selftests/net/lib.sh            |   3 +
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 tools/testing/selftests/net/lib/sh/defer.sh   | 115 ++++++++++++
 19 files changed, 587 insertions(+), 607 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/sh/defer.sh

-- 
2.45.0


