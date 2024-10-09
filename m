Return-Path: <linux-kselftest+bounces-19338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCBF996994
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 14:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801722843B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 12:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CDF192B89;
	Wed,  9 Oct 2024 12:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ap6b5lzT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CA18EFE0;
	Wed,  9 Oct 2024 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728475781; cv=fail; b=XermYYnB+DHGOOhT0v02Fntr/G9nkmDL/dDRYeyZKZSQmOuXe7NJdTK9zYU+AkDz9wOa4CkDYV3c2GXQt+cDuH8xa70QZSg/8JUpREs1pWS1qX6SyWFr96VQ79APk5iqsjA/7VRrOGCcyKkDY/WlhEVBI+PT/rGc3lac0zl8IN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728475781; c=relaxed/simple;
	bh=OL5goZHBJbRlNFj2bFadNkqzCi7d8A05WZnaF2eL+q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvUyn1KjQoiE4mceEAOwhR17dLBmT7lwVAVmBz9JJ0+e0i7nEq3swdILfvC7MuXf2Gv3nEQ9o6BJsixQlounPULzzNhOKlSWQCKk+PI2noadqf7aqq5IMNwDWMUVmbuJbe0TiD0XVvMi7vxKMIX8BehLvOR05/k5I6Y+JZN/Uyc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ap6b5lzT; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zDABkp5QW7Wc6uXHipECfPiEGZqCbmo+wd15ZwzzuQt5Y/DPIYdaILuVm3XtvajxyyUOseCTi9PGTsAOv0G3HlKnwlkQtmQEIDCIj6Mo/MlwNHP3W/JfPUZXwcBgH2PJB5EpI3t7dQVDGJsn9zA+3+tHruIrPDawzicwMo+qK1XCVj92uH52dgGAAN+kB427phK2nhQkEhXUlig6yL8HnkmgnQ1aLkiS8pc0Ylzxw6rp4AVSYB9OvKtO6qc2duosh/x4Tr9UirJHl7AtnFZzwskGnTU1O7RvLlYsg+95UGXSG/uAJdzSY47wWNjiqyUSW3NEmYSO22IWipUvuvF1fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkTCV4+EcwE0hlJwb2+2DJW+HxzhVE4nJxzpnMGXTI8=;
 b=swnSbbz/AJL9e4SJXIav69DQNB8/4OagmYRr3RJ7+Og7Rxjgc59ito+BC24f0qGyhr6ftuhjIRwPeY87Ixp9hyBk3RaNv4FwiOgxKrxwbYpYUwL8XstRG+bvKIjFvoahacDqoRv3FZICxbVv0bdJkGCYW0WD15GRjJ7bvbdx46nRIC1ESTol3fYG8eYk5xEhPum5VNeGON7LGmdlx5ZYGvfnrCRMOM+yt6dWvRRs3m/kOQqcqZ+SORxLKyR7KejF6/ZhipKSOdCrV7+R35aL6V0coKHvRSIx3tlrX8+NJymbu0v/2J8BHHW2p/sUQu4rzgXSZEPm4LJCsMkznSXDgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkTCV4+EcwE0hlJwb2+2DJW+HxzhVE4nJxzpnMGXTI8=;
 b=ap6b5lzTrzqMi0UoQZ1Ivkvc2GSptE1zZBHhbiqsms2OVBt51pHqeDuy6VVsmuSIpTCpgg2ymBhfF+cirJW5MzCuYHsRK4KV9KMoyjrdmAOxBW1xFtZjikFPF82n0Aur1nxmVbl9JL0/H5cQhDLVKoKsTTy67qLhvXU/fg0yMnwAI/5Qzm/+KomU77LC4EvxFfy15KvAnSSimbDpQ2hRA2WLWvXTTEnYm/9NhzQY2rLDVdsl9pk594jn3vT56Krsj/RX4DbkH921j13+o+IEHX9uTJMUwj8qG+yNdw2P07B+o+IOYJ74LAH/xjGxsLn5cYkDE9nTXGil0Jj7EzNfnQ==
Received: from CH2PR19CA0021.namprd19.prod.outlook.com (2603:10b6:610:4d::31)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 12:09:34 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::ba) by CH2PR19CA0021.outlook.office365.com
 (2603:10b6:610:4d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.17 via Frontend
 Transport; Wed, 9 Oct 2024 12:09:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Wed, 9 Oct 2024 12:09:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:24 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Oct 2024
 05:09:18 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	"Benjamin Poirier" <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	"Vladimir Oltean" <vladimir.oltean@nxp.com>, Ido Schimmel
	<idosch@nvidia.com>, "Przemek Kitszel" <przemyslaw.kitszel@intel.com>, Petr
 Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 01/10] selftests: net: lib: Introduce deferred commands
Date: Wed, 9 Oct 2024 14:06:19 +0200
Message-ID: <5c0506e2d1bcdd513b9917716702c9bc5f656198.1728473602.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728473602.git.petrm@nvidia.com>
References: <cover.1728473602.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: a996ea20-d2db-446f-495b-08dce85b3cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9uAy+xrO4sFFNFM2/zsWvM13QqF+Kq9hJcKVALqWyGL5arLiSPqTcQ3nsPee?=
 =?us-ascii?Q?BAdZxwgZiBi5Q2+DLUZJ7qtE+c9rupgKfXGQyjyEV39Qma+J5GWpp8rVRcCL?=
 =?us-ascii?Q?0ALhO9ydF+j8AZER9mEvLzg8a46Qn1ZqRO5wIn2OcSs2ROrDLoKPh8ogimcw?=
 =?us-ascii?Q?wA658y2Fyty7XQc2TqvmdM1V3DVv+y/fbRc7OrDk3tWxW2NBX/VbLf7wbyDL?=
 =?us-ascii?Q?VQgxhRREGfwuxGanKiOvIvdPa3rdqYeXT+LjavG/Vq1+pdCJc3VodNZOW4ja?=
 =?us-ascii?Q?7I4Z3XSuLxabBGZrkhKDmw/DZLXmI2IpP0ns5DZJfA04nmgqqPs9MfDYLENs?=
 =?us-ascii?Q?SJIWVVLGcx4vhuTXuakZuZ4ogfN941K+jSwlc6m23WxEkuG44Qu+66j7zxv2?=
 =?us-ascii?Q?x3HVBCcT3zMTckNaNQoB5UUbyJxYC8sBL7SW5P0hyGUe/pr87WhLFF7V2v2n?=
 =?us-ascii?Q?VRYIc9VEZzh2oqFH33rMIS5ubT/NREHuaqZ+0v+WMdSszojks3XJmmSLREly?=
 =?us-ascii?Q?N3TTadRiZkImMe7NHbtMQRVlJBctlx7Zs97nMaBAbmNkNgFcHX8/2Tf3Ioyf?=
 =?us-ascii?Q?LK+cjX3ud2c07tBVh/W1g+GU3RiiUQSidV0pjfFTvlR2oz+GWuqCDKTi+gaT?=
 =?us-ascii?Q?TCV4W3x1N3mK/gX7LjPUSZ0BOik+oEq310li4V3NQEzRQkKmGhF0Crggb5EV?=
 =?us-ascii?Q?S5UR5GQT5hyMmEmxx1v737deOv5iJRIT8ajk7vCJxx+3RNM2GSLKTkXBSw3t?=
 =?us-ascii?Q?YM/pZCu3yqIVEy3ImLuhCxkdMxbft5tSWhNo1VebFeFhbdCmF3bxP/wzOyUP?=
 =?us-ascii?Q?ROj/mW4TplRfDaSNPyC3DkFNrDnLUcXRw+OEbNhKn3az2A3uEv8J0C+4nZF2?=
 =?us-ascii?Q?JGt1Rvb1kwAyATkqoZBEITstBqn7qPGScFfy9j/qoK7gdeGzsOMhYXpELcb/?=
 =?us-ascii?Q?81zvfAbtapCxFeFRyjgYSgFjsmxvjjhZYoKywl4sjFaYhE5IjRXV7DKMMPpA?=
 =?us-ascii?Q?PlX6yfzVI9P8DcHLzciMNzTIBIaOfMyLJB16BIj9BXg7utXZlofd95Y/ijGX?=
 =?us-ascii?Q?pkS4adsynyhz24JszrwU+sAnUPQT1UnWTuecx/Yb3oF5AbBRYUQozTE5OTwT?=
 =?us-ascii?Q?UZ9ZZjkHmcIRqZjlsBlRL1reb1GgVuEReHe2ooyXbgH/E8+tT8KBbbOvMZTj?=
 =?us-ascii?Q?NxpHa3U5nUB4eaDjNrqelO9dt3WCrvRULe65qAJ6GbKmde8rVzGUj21ESkOJ?=
 =?us-ascii?Q?m/pCf6dhQVHOdZE7HuzHzR8XCR0eSsDtMfLxuCy9jBZLXGx1iBdizsockVHm?=
 =?us-ascii?Q?F6ZaWrx6TKQeqMG2GYFdkPraPbFw9Nx9iOKWz7SQMoJiS98MkVd+w+lNSEj8?=
 =?us-ascii?Q?R/H2IaWp8smHv0qxQ5WXVQqScLV8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 12:09:33.7002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a996ea20-d2db-446f-495b-08dce85b3cbc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043

In commit 8510801a9dbd ("selftests: drv-net: add ability to schedule
cleanup with defer()"), a defer helper was added to Python selftests.
The idea is to keep cleanup commands close to their dirtying counterparts,
thereby making it more transparent what is cleaning up what, making it
harder to miss a cleanup, and make the whole cleanup business exception
safe. All these benefits are applicable to bash as well, exception safety
can be interpreted in terms of safety vs. a SIGINT.

This patch therefore introduces a framework of several helpers that serve
to schedule cleanups in bash selftests:

- defer_scope_push(), defer_scope_pop(): Deferred statements can be batched
  together in scopes. When a scope is popped, the deferred commands
  scheduled in that scope are executed in the order opposite to order of
  their scheduling.

- defer(): Schedules a defer to the most recently pushed scope (or the
  default scope if none was pushed.)

- defer_prio(): Schedules a defer on the priority track. The priority defer
  queue is run before the default defer queue when scope is popped.

  The issue that this is addressing is specifically the one of restoring
  devlink shared buffer threshold type. When setting up static thresholds,
  one has to first change the threshold type to static, then override the
  individual thresholds. When cleaning up, it would be natural to reset the
  threshold values first, then change the threshold type. But the values
  that are valid for dynamic thresholds are generally invalid for static
  thresholds and vice versa. Attempts to restore the values first would be
  bounced. Thus one has to first reset the threshold type, then adjust the
  thresholds.

  (You could argue that the shared buffer threshold type API is broken and
  you would be right, but here we are.)

  This cannot be solved by pure defers easily. I considered making it
  possible to disable an existing defer, so that one could then schedule a
  new defer and disable the original. But this forward-shifting of the
  defer job would have to take place after every threshold-adjusting
  command, which would make it very awkward to schedule these jobs.

- defer_scopes_cleanup(): Pops any unpopped scopes, including the default
  one. The selftests that use defer should run this in their exit trap.
  This is important to get cleanups of interrupted scripts.

- in_defer_scope(): Sometimes a function would like to introduce a new
  defer scope, then run whatever it is that it wants to run, and then pop
  the scope to run the deferred cleanups. The helper in_defer_scope() can
  be used to run another command within such environment, such that any
  scheduled defers run after the command finishes.

The framework is added as a separate file lib/sh/defer.sh so that it can be
used by all bash selftests, including those that do not currently use
lib.sh. lib.sh however includes the file by default, because ideally all
tests would use these helpers instead of hand-rolling their cleanups.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh |   3 +-
 tools/testing/selftests/net/lib.sh            |   3 +
 tools/testing/selftests/net/lib/Makefile      |   2 +-
 tools/testing/selftests/net/lib/sh/defer.sh   | 115 ++++++++++++++++++
 4 files changed, 121 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/lib/sh/defer.sh

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index c992e385159c..d24b6af7ebfa 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1403,7 +1403,8 @@ tests_run()
 	local current_test
 
 	for current_test in ${TESTS:-$ALL_TESTS}; do
-		$current_test
+		in_defer_scope \
+			$current_test
 	done
 }
 
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index be8707bfb46e..c8991cc6bf28 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -1,6 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+net_dir=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+source "$net_dir/lib/sh/defer.sh"
+
 ##############################################################################
 # Defines
 
diff --git a/tools/testing/selftests/net/lib/Makefile b/tools/testing/selftests/net/lib/Makefile
index 82c3264b115e..18b9443454a9 100644
--- a/tools/testing/selftests/net/lib/Makefile
+++ b/tools/testing/selftests/net/lib/Makefile
@@ -10,6 +10,6 @@ TEST_FILES += ../../../../net/ynl
 
 TEST_GEN_FILES += csum
 
-TEST_INCLUDES := $(wildcard py/*.py)
+TEST_INCLUDES := $(wildcard py/*.py sh/*.sh)
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/lib/sh/defer.sh b/tools/testing/selftests/net/lib/sh/defer.sh
new file mode 100644
index 000000000000..8d205c3f0445
--- /dev/null
+++ b/tools/testing/selftests/net/lib/sh/defer.sh
@@ -0,0 +1,115 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# map[(scope_id,track,cleanup_id) -> cleanup_command]
+# track={d=default | p=priority}
+declare -A __DEFER__JOBS
+
+# map[(scope_id,track) -> # cleanup_commands]
+declare -A __DEFER__NJOBS
+
+# scope_id of the topmost scope.
+__DEFER__SCOPE_ID=0
+
+__defer__ndefer_key()
+{
+	local track=$1; shift
+
+	echo $__DEFER__SCOPE_ID,$track
+}
+
+__defer__defer_key()
+{
+	local track=$1; shift
+	local defer_ix=$1; shift
+
+	echo $__DEFER__SCOPE_ID,$track,$defer_ix
+}
+
+__defer__ndefers()
+{
+	local track=$1; shift
+
+	echo ${__DEFER__NJOBS[$(__defer__ndefer_key $track)]}
+}
+
+__defer__run()
+{
+	local track=$1; shift
+	local defer_ix=$1; shift
+	local defer_key=$(__defer__defer_key $track $defer_ix)
+
+	${__DEFER__JOBS[$defer_key]}
+	unset __DEFER__JOBS[$defer_key]
+}
+
+__defer__schedule()
+{
+	local track=$1; shift
+	local ndefers=$(__defer__ndefers $track)
+	local ndefers_key=$(__defer__ndefer_key $track)
+	local defer_key=$(__defer__defer_key $track $ndefers)
+	local defer="$@"
+
+	__DEFER__JOBS[$defer_key]="$defer"
+	__DEFER__NJOBS[$ndefers_key]=$((${__DEFER__NJOBS[$ndefers_key]} + 1))
+}
+
+__defer__scope_wipe()
+{
+	__DEFER__NJOBS[$(__defer__ndefer_key d)]=0
+	__DEFER__NJOBS[$(__defer__ndefer_key p)]=0
+}
+
+defer_scope_push()
+{
+	((__DEFER__SCOPE_ID++))
+	__defer__scope_wipe
+}
+
+defer_scope_pop()
+{
+	local defer_ix
+
+	for ((defer_ix=$(__defer__ndefers p); defer_ix-->0; )); do
+		__defer__run p $defer_ix
+	done
+
+	for ((defer_ix=$(__defer__ndefers d); defer_ix-->0; )); do
+		__defer__run d $defer_ix
+	done
+
+	__defer__scope_wipe
+	((__DEFER__SCOPE_ID--))
+}
+
+defer()
+{
+	__defer__schedule d "$@"
+}
+
+defer_prio()
+{
+	__defer__schedule p "$@"
+}
+
+defer_scopes_cleanup()
+{
+	while ((__DEFER__SCOPE_ID >= 0)); do
+		defer_scope_pop
+	done
+}
+
+in_defer_scope()
+{
+	local ret
+
+	defer_scope_push
+	"$@"
+	ret=$?
+	defer_scope_pop
+
+	return $ret
+}
+
+__defer__scope_wipe
-- 
2.45.0


