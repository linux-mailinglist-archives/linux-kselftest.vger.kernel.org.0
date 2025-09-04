Return-Path: <linux-kselftest+bounces-40795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6498FB4440A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:11:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB2E4586B13
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732530EF6D;
	Thu,  4 Sep 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CMVuBK+f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7730E85F;
	Thu,  4 Sep 2025 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005798; cv=fail; b=av7d1Fq8Ee49oom9wrg7zwmFkqFUKOgHl2wkpHnZzAWPChmJehRo3++wSflHrId4hBKj7AYVxiYK173YbtuqxARTcFTkmpqfpRY1FABUzXbycxuWpWDEBY3cqMvHUB6yb2iBEcZ0gs35Ly4nSEgQSbHsBtPm46XoJwfjCS0QEpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005798; c=relaxed/simple;
	bh=aIgUM5KljVd7v9nTxVgZFIeSNmsbzFsgG6bMt3AAC3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoGKzvsHxSJdbz2NCWI521N9BrsA9tsnwKstlGQSf9Y7LLOihZjkIhgecPmmGRKFdAzkq8EdIhCJcA26+ondkP41WDaTvWlVhy9VwFzDxrVrLInMM6Ns+koeXOAa5rSf/d3qqkmERnrv08+8bVhyhZT94EB9Tq5mWQLxn7hTyxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CMVuBK+f; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbu7b/uIl2lnsQ6HFyw93byVlIiqDI5UysgMfFSSBzacuCqlMN+7Mtiy7LkJfF2+FE8R+/8qN01qQCsx73Igj3Tfl8rgWa0dssuFECuCplIrUsVUGe3nA/4J9oLsYHQbk73kUiT1lt5HvI1Dqg/sYLl7dIEUvPu0+WM2fRegy3DLATbzNYv5QYH+aSv//J+1HM8j1Ed+EkqhypPVsUSRt4GO4J1AtTX6Th998K2zvSoFIM/VaSRUODk2OYTPhTPep9PVwkdZO2XGNuXl5baEfOfpG5J3axNqV1zY4SM7ufzXEmUtWvkDsqsIDu8EuBwsoH7vbxTo7H8tUSROqfdCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JE3i25LJ7i+KOYt+mH7ojBg9Jagz3t5cB26XcMqPjI=;
 b=LHzFmRgSM0tK+E+f+htuonFM6uAqjfDUQowE3Qmj0OfBFdc+ixh7oVuqwswyI0tiRsakDXFgcQ7FsWv3lAepprUgjq85lzRDM//Esm8O0PdC3U8TtT/Lvh7gn7nXzkPdBC4loYBhL9F97GRn2k35PwxfnDFnDSOZIjBDspIphIjzDf4qTrx78EzyWZxIjJ8Fe6nX2y9dLKjX7IuOrbJ9Eo7yFv/D42MJG+8v8uc58AP/PbUJuGi5uKjd8AzDB0ljtCgVNWEePy6JLpsSOcxmgSPbFZ8HxKrW1b+/qqOnwlwvIVYNBUgsRgNFEmL2Xm428s4dtMtQexO88o55GIZIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JE3i25LJ7i+KOYt+mH7ojBg9Jagz3t5cB26XcMqPjI=;
 b=CMVuBK+fmrhXncmP6adi4MomG7A1G7Q7j1MYfncooy2sF5xqVbxu70LxEUhHG4C1v4NpVZg11wd4/ZS2TmgHA6JtwPfXTMqSeMMKvxsDttQYkoGGfH9l8uEj/YRQsS/AYGYZuw6UpPCYrTqF+Vqqok1r9ZEKexEiv8c7smRjpLXDUkBF/KTJpc7eVt1FPEQPNR5D0G1lz2ul3knvHVrcgSQmWCOd+y1PafChlxthimmwpIpIFsv0tru4balrxONk1l7C0gi0t9M3uasDPxOPTaz1PwCnQb2wk1h+aiCUEToWBFyti+9E/WZm/qcYse5V8CceUQGggwXstGmPompdNg==
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by CH3PR12MB8484.namprd12.prod.outlook.com (2603:10b6:610:158::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:09:53 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:408:13b:cafe::9d) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.19 via Frontend Transport; Thu,
 4 Sep 2025 17:09:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:28 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:22 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 08/10] selftests: defer: Introduce DEFER_PAUSE_ON_FAIL
Date: Thu, 4 Sep 2025 19:07:25 +0200
Message-ID: <2a07d24568ede6c42e4701657fa0b738e490fe59.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|CH3PR12MB8484:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b1e618-c151-4f9c-726f-08ddebd5dd7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xva+sH4BDhQ6hFZz/7mlXqOXE4H7sFWxY7XEOC9vVOZylkV8rkzgdK6bvfAb?=
 =?us-ascii?Q?9GUIzgwo02FrjR9zJvKTbLTyy1Yh0KQ8eNeCg7YfZbrlXmm2yLO8QrbE19yi?=
 =?us-ascii?Q?76G27UxCTG1cuvpAFY8DyTJEBfNOUeXYU9shPzT1wCTkRCDZ05AfLbx6g2fk?=
 =?us-ascii?Q?4uzwCa4Q6m/ftWefUhjq4bhkZ7xpRK+QHr9dXkrZvilVGnxcJt0FeUnb8hUZ?=
 =?us-ascii?Q?MMcCjK8kUpTck7tQaDOtjFRsceqf3czvT3ESiGQLyItAmUaNIByQc0Nlr5gf?=
 =?us-ascii?Q?jw7gRgNf8/PXwgKQnuc9YQzirkU8ssCvNRshUA50iGai4WzwYGG+7Ylo8qDU?=
 =?us-ascii?Q?EbGSxrp0ZPxyPbOMkEXI490XDFvSrL+75hZQxh3p1A5WTz5+rKpdVaK4liPD?=
 =?us-ascii?Q?HvB3vlc1n7Me73A6saiA6FdPEJ/N2MWNsusN7RSyGaDjmRv/j58q8YOthtp6?=
 =?us-ascii?Q?gkDY6wmkug7X3Q8oaIoLqh+FqJAJp7/PVP4K+MnUxrbyMSQu61uJKSvuvNiO?=
 =?us-ascii?Q?iiOZnc56Lyhb1LMxJG4CD1OPXJ6Hwq60pOif3aPuBX0tizK4Bvf4uofe07vW?=
 =?us-ascii?Q?WHb3CMeh5vhiB09+o63AMArLWI70hmeTZlVLA7DhKBFO9jpiBP2ZVfAB1A6k?=
 =?us-ascii?Q?s99ZnPrsplqkzMT0vHWCLFfxxGlvVhyRU+OBxESwFJY5hFaMo6QJicoPYEjJ?=
 =?us-ascii?Q?n3ZWAbSBFVjGrUx7Qxo8/FyR7kSVZke/x6EI1ugu2423XUZ08HzuuwaLyEn0?=
 =?us-ascii?Q?ENL2bYkhrQTYg3kUdUIMuS0Bbu9mmW7rzsAtbhW/LC/ob9m5QN2KR+qTfeN3?=
 =?us-ascii?Q?Dc4W82nVMjqw/qqXqrbWsd+7wluwWuiuGe2thYk5lk36eb4MqRzVlBQ/Fcp6?=
 =?us-ascii?Q?38bPokvs4NKSe8hTQ1kIGOhBqeWcxqkaHWrj1JCrpndff1jQT22tBYS0uBRY?=
 =?us-ascii?Q?ZD5zQVSOOO1zq6lyMGOnmX7jMVzxJXeiExrcGJOoK0c6V6JPuP8Bq3Tw+fNh?=
 =?us-ascii?Q?TjPepNjdJXecMMTWUjcKWoYP3QCU9qZVUob6OglKJLyc+6jeYYnVPA/2qMiF?=
 =?us-ascii?Q?WFtGzItS4yUj1zQWcjXH8HGyU9ScjA7Y+LT7x1DWSQbhp/G53zlvXMrnKl2f?=
 =?us-ascii?Q?IjgMq0gyYByzDHvSJKFvY7juulQAtSjxz/+8izIVH8wxUPyJlJjXAvMlBWnL?=
 =?us-ascii?Q?vwZ75jM10TaRk3gZiZ96I2MArEnOCN0YCP1fAi/4wCFXKR7zf3t/aTs7Qiv2?=
 =?us-ascii?Q?o8kiJ50XGTWfj/0qliBGBQfgBtdvuO+SKwGnSQyYzqdAkIqQowFHqj8pZ7be?=
 =?us-ascii?Q?v3C7QQnMLZg4SlzNQaH34+mXOa7VERM+iyGRLNFOxp0jzYe6Qb4jUCKGJLS1?=
 =?us-ascii?Q?NPkjaJm/B6STJHV61eOPVpX3Z2UBkWWLgqCmncpZmxh3zIcg+wY8pVSwUsOu?=
 =?us-ascii?Q?ZncXlvdWBAut3+Rl1oak2ZlLbuUqSLZDN2gatSpWG4dqsQEvpQaYaj5fpasn?=
 =?us-ascii?Q?JgXO30dknVzW9MEmGp4VgwGbUH185TVVQBAK?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:53.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b1e618-c151-4f9c-726f-08ddebd5dd7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8484

The fact that all cleanup (ideally) goes through the defer framework makes
debugging of these commands a bit tricky. However, this also gives us a
nice point to place a hook along the lines of PAUSE_ON_FAIL. When the
environment variable DEFER_PAUSE_ON_FAIL is set, and a cleanup command
results in non-zero exit status, show a bit of debuginfo and give the user
an opportunity to interrupt the execution altogether.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib/sh/defer.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/net/lib/sh/defer.sh b/tools/testing/selftests/net/lib/sh/defer.sh
index 6c642f3d0ced..47ab78c4d465 100644
--- a/tools/testing/selftests/net/lib/sh/defer.sh
+++ b/tools/testing/selftests/net/lib/sh/defer.sh
@@ -1,6 +1,10 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
+# Whether to pause and allow debugging when an executed deferred command has a
+# non-zero exit code.
+: "${DEFER_PAUSE_ON_FAIL:=no}"
+
 # map[(scope_id,track,cleanup_id) -> cleanup_command]
 # track={d=default | p=priority}
 declare -A __DEFER__JOBS
@@ -38,8 +42,20 @@ __defer__run()
 	local track=$1; shift
 	local defer_ix=$1; shift
 	local defer_key=$(__defer__defer_key $track $defer_ix)
+	local ret
 
 	eval ${__DEFER__JOBS[$defer_key]}
+	ret=$?
+
+	if [[ "$DEFER_PAUSE_ON_FAIL" == yes && "$ret" -ne 0 ]]; then
+		echo "Deferred command (track $track index $defer_ix):"
+		echo "	${__DEFER__JOBS[$defer_key]}"
+		echo "... ended with an exit status of $ret"
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ "$a" == q ]] && exit 1
+	fi
+
 	unset __DEFER__JOBS[$defer_key]
 }
 
-- 
2.49.0


