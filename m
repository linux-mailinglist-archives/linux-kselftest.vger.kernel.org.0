Return-Path: <linux-kselftest+bounces-19938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305DE9A1ECE
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 11:47:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4BB1C2556B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 09:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DAF1D8DE4;
	Thu, 17 Oct 2024 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uRm46AOV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAF5199E92;
	Thu, 17 Oct 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158440; cv=fail; b=fZM81a6JOLgWDP7St6vk9mZm8RX6hQ2Npx01UN/dXolN7G5JcOcEO4M8UtYF46kdbTpSm9SvkLtGHbql71yLgXiROlej/C0jnJJbaj643cAka6dLi4o83HZC0lmi6B4jyhvjFIYRMJQWReB7mwrYAIbKPw6W+2cVq+aSd7IdFFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158440; c=relaxed/simple;
	bh=goKL+L8i/+yheYPP/hZY9ujcT7qZ7MPDgYYlqUekWVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c8RfqX1Wm0tffGWflHL+hHM9QP5PNpW7HMvITsHp1RaX9ActMKGd5PCgP5mPE+UYsexofFZXmJWLhltmSaUTMdfJqoLigscL0zM+BuIgw+Q+8XeMh8EaV0o745mRnVPSIEp/Lh+8fS9tC6JemJCG96+6+J0VE5KpzGbR0dYRBG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uRm46AOV; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHQER6NbmPZ/SbHN9wTyJeX9SaNrE23UTDnfSylksgG5NTEu+1DofXwRXcvUavxDSEHhfFQc7FQEVgYPzE4KNKChjxPL0lN6+vgogqg9W+p3TTBAnWm28c5HNrcM1EJ9Qel6zJyHJdDChQrZFQX388V2FRRzYJdQbAFAe7Ok35mY8aJIBi9byWKqyU3oa9qVuMFpEimCHrDySCQtew6ZGPapY9Be3HNhpMWYNSWa4k57IS5/I4PHYeREEfGdqAjXoOmoHMJyu4vxNHxmiiwb4JeZZUWLJYS/FZL0ZEwMEl9MV6UqL/wjanGsDaRU/q2GzsItpAPKawuMWlEc9geuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed1HrE/fQ/RaTQ4ZcWnmrS4KJWrqClFbqGRTCXm/uLI=;
 b=luPaOExBpuXk+gaY6lbLBb3NP7ZfIXvqNCtE4suApADBpwJ6GHe+BseDj7vuX+e7q3OWCSM2GfHxiIImEYPOkm8Y9hjo3F9u7ozCR+nJ8g52GM+Q46yXMoyFs4J9iWIoptj9RBvW2nSkHZMxoCgJ/A+SGbOU+iJpZfgN2P6I4nDwelH9Ohd9WeJj2ZYeVd2msDQZ42E5IIsOea4tTduJGdqcXuI6qQDAAnbVvqxk9K63a4iuOMr9BF0k6H2N+dSeTuDMnVsxRJsfACRwdeBxEALFtzPaYu0puxDkwkmRHC58XPiLl7fUNKI45qtCqW0nQ0UNOMUeD14eJs1Gj4HIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed1HrE/fQ/RaTQ4ZcWnmrS4KJWrqClFbqGRTCXm/uLI=;
 b=uRm46AOVcAUG71EkQkTaokwMpvt7vM+Uz+CtPNpTYSqSsrZjM0kELzSWmseAPH2aiTKTqsvcKk22nPrficgUVUqhJ0fBOT+fVocc5Hj38NRdt8/8far9w78gLm3v1+EAAi669feB12wkCaMewCzZK0EJ6a/+gV3R1MXkfHBzrTemyfVkKqNoGBKJXz6niEJEw1AnO5pxJt+87K1d1ifAGatG9QX+ktwKU8lZNnp2IxnWqZJvj1nTxenyuvwwCgi2uoAgFNZ1It1V9R3U919I6vtW5ZHnoowgZ5dFCXYPucnSzba3HN6bminVr7Cr6sIopn2U844FDCvqyRz/Jnyecw==
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by PH7PR12MB7796.namprd12.prod.outlook.com (2603:10b6:510:275::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.19; Thu, 17 Oct
 2024 09:47:12 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::a8) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 09:47:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 09:47:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:46:59 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Oct
 2024 02:46:53 -0700
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
Subject: [PATCH net-next v2 01/10] selftests: net: lib: Introduce deferred commands
Date: Thu, 17 Oct 2024 11:45:43 +0200
Message-ID: <daa8551601ac52140a0278d729d233e031b96853.1729157566.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|PH7PR12MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: c66b8b15-7ec9-4a29-43d9-08dcee90ac7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U75vEWvp2godu3WCXkDduCMXvaIMVATzt1bwcXvoGxrJx8MI541l/Fs1fwNq?=
 =?us-ascii?Q?TCKY37EPrjDIyk6Qrtl8uwvJBy+E2rth3FNEPzFPMxavEVBxvQvPUEZuZCzL?=
 =?us-ascii?Q?n6UuF/sAWuPMfIWlLf4aDeeZMa4oR5x5qRhOAoDyofOm0s+xT6uExZo7tUeA?=
 =?us-ascii?Q?v+VYaDDTZS8WlSyfUP0PNF8ouGqh3+hMBotjh9BPDCK+mx9zsnW2OrVOvZX1?=
 =?us-ascii?Q?LIHcQVgd2MLUHVYd5oc/NyceuidGl+UPa4CPNyDqvJbMZD1yJziVG29p6VGc?=
 =?us-ascii?Q?JO8CGw1r2uGFdea3Fo1R6pm3wSNZr9rd0YEMnct5FUdVjVVbLEwlxfsfyZ9U?=
 =?us-ascii?Q?O7vOvHpFUH3GlG8CQ/kSfy/0L4SCuPWzLNWo+2ThZ0f1y3n5i7BpkWPTD5SE?=
 =?us-ascii?Q?ozxAuBSBLwOU3VmmtOhmWxapT9SXIFU7D3U/5QqAf4CD4aKwyE92KFPMThDb?=
 =?us-ascii?Q?wTreW/WUkrtdzqijrDwJN8Sg5d0OowbSZ2Dmxhp21QRkV1XAsOPhF4RiAw1y?=
 =?us-ascii?Q?oKgzkYE80BAEhOKf+MbHF/etPsbCNFjgcTxDRYpMiXh9rWJoUUX3cFWw28yW?=
 =?us-ascii?Q?l5HEkhh3TMFs0z+L1UOaNeVsEblRhnoRsSTlXYkVXoE+Gzqh/W7KrlhWsylZ?=
 =?us-ascii?Q?bps6P7b3j10WLjKwmacsLJjNndN8jdmQaDXA6OObJphg9xoR+U6G37vG7T++?=
 =?us-ascii?Q?NWYBwNjtnNb368Hwq2lBaWbeu9FFSXz85c206cIzRfak+YEykf/FvPrT4CIg?=
 =?us-ascii?Q?PJT/1Dt1PxvlvhYeG44xFO7YmbRSCXhK6k+5MjyD7RmESI3MjoVOAMtSHF//?=
 =?us-ascii?Q?aRJrG5PZpvHJe2zJnTimCqvsVtvAePzFisj5xhVxRnL4ZljjEAL9XbTtgXRP?=
 =?us-ascii?Q?Kpcct9XCtEVGurCrKyAKS7SKshx2wK0vLpT4lXkSNeiojpsIRVTlqJ2f1PYy?=
 =?us-ascii?Q?NoEeeLmkwyAtDa36n9zP3Kfanx7lGID90ekkKnOu8NB7un+xgrNGuRRz+lR6?=
 =?us-ascii?Q?lenZJ4I5pM1/c2CAjcKUBDbqChMS7i95cXV5c1/oUlF7NvpsfoKSroQSOWAB?=
 =?us-ascii?Q?i5wm/cYSfy0fXbSYSlrW6eJhQYn4s664lLEcYl8BauONYBABPh6hIPn3kMEm?=
 =?us-ascii?Q?Jtz6y0OqoB1HgIts74k6JIpQiFKrKvyZsA1D8Plv3oFI0wkheH5OddqTyUEe?=
 =?us-ascii?Q?FHsWL1+cTUdvie4RqC4pd4EGQ190sI65sjDiHJd9b44M1l0DxcQmeS4L77be?=
 =?us-ascii?Q?mK4eDNRg37FQNWX2KT692zoUQE3noMeobk7zmaJqlNT3MGx9OGgz5e52uVzm?=
 =?us-ascii?Q?ycN4eKn6wbTGnc9G0eHvDjDBFM5sVUXI5y1VAN/bpZCBZ75mK/KFqnY05Q3T?=
 =?us-ascii?Q?iU0A+RxV4BLoxTGkq4jKAziJHtuwAQLdisua3IBCcznnzlll6g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 09:47:11.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66b8b15-7ec9-4a29-43d9-08dcee90ac7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7796

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

Notes:
    v2:
    - In __defer__schedule(), use ndefers in place of
      ${__DEFER__NJOBS[$ndefers_key]}

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
index 000000000000..082f5d38321b
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
+	__DEFER__NJOBS[$ndefers_key]=$((ndefers + 1))
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


