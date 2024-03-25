Return-Path: <linux-kselftest+bounces-6565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F31988AD22
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD5CE2E80CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF49F131E29;
	Mon, 25 Mar 2024 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iYnb6iFq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D45D130ADF
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388011; cv=fail; b=UCNeBbVk+fvwDSGFJbPYBKY/lTgM/c64YSHZpIbIVGyu5BgPVUuUj96IluNTormq0eRtySkB8VePQMCh6GGj6QRlyBxz2kRV5UAVm7Jttyut3I7l6uWAQwksomWRv52LxOZaAwcwAc0abry0H+U8zbA70EwoK4enLeeqM9wFdZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388011; c=relaxed/simple;
	bh=sSYwjOrOgKy6m8wve4tKsRPt+gTovOReL5XmBXqY8s4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zc+1azNo1ioDII+Uibz0Tjd+/QoxrSfleWfGf3hhPF89z4ScwXaSer+7UTyxANWgkYiaYDkfOBjdHcJpJhsEp9CHaQw7KMB0+Phy5+wHZCsmCzVZ9x6W88F6S2vnqtj8yAnEKUBTEJOsi/cF0FRDkL9fjxz2gBEw5kJSmwPIKDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iYnb6iFq; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bd/B+HCeMqx96dg4jAvWE/Kb2OzKRKLT1XpaGxy6YWRq6NTW7ecaFgXyV/DkxIi7VqO4gofXSu7m4WzsPHgX9ODQun8rZ466FfyB5Vverc77qTj+OnyPLneiXexCPrek40HHRgVjBaWN62aGQUeceMUzRxXZLGfQgzV3gi6mOFuMT9cI6zmofkTwAMuwAipp7i6WpDpjBmDb9lJ22el5DsHrLJizKOD+kQei2ag24TtqSAMHvFrfAbAqGbdcEW0Pvu4tJ7hTWLB/wwiXjtLaHlMJhY7FpGipHJQb3BLfkl4wLIpBkEVT3pO/dPQz9JguqRCQyZfPmo8hfcf53xdDSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6cJ6yKi8ZqS5c31O3GhLJGCv/2kZHpaea/0vl72qBg=;
 b=QIWFlcnwx/5jr0RHqh7iHsXBhQ3t66kuyRqp/cWKwYTudRdFl893jCPeLOOsdznOc3DlkDVcBpDIC/U3Q/DM22R/5zegLLjEO/ZK5SZh8brvdjT25rTH7UHrhjZyIkXj+iRYPPwBh4CxCNtrdAek0SbjwB2tMDf32uWvxCUUWLQ+YFza1+50nrDzl+gbYASMut3pZWJ5bVwEnwk4txJ+iZkWfABoUPWaf7LACy8IuCtYTk9TiKCGY2v2AxxhvmC5zSKk0ZH99E3KhEBIcjBG2j/+f+PPww3itN3f4TPoEqTiwvCETMuAtJcHf89e5hA5PAGAo9Cd60ET5on/kwvuuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6cJ6yKi8ZqS5c31O3GhLJGCv/2kZHpaea/0vl72qBg=;
 b=iYnb6iFqp89sl24bHav/EZYS/Cb6RopvFVVTBFiGm/37Molm9eGfFGxEMud+iH6U3GKnuZsjJ5z1dKG35At1jEvsJR/D4Y+lcEjQHIy4JOFqmHVInjVQteAcqVgtqXSXX1n+HiKkHrhrB1t/dbdGFoc4W2kOfDNScBBYk/3qYbs1cGyq4Bg5a2xJoE9n9akArHxuS/6XOmSxU6qax09hK1Kp9HmnZDjsEJY9e6dEkZwHKuOxgV7aNT8PKxDIlDTZU3uEMF+IWBl+JMqDob88Y059l0CSzLU14872QtbpveY5ix8S3IsyMM8nsQHA8k6iedV9PtHU3DvBJovz67M4kA==
Received: from BY5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:a03:1d0::30)
 by DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 17:33:24 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2c) by BY5PR04CA0020.outlook.office365.com
 (2603:10b6:a03:1d0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:33:05 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:59 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 12/14] selftests: forwarding: Mark performance-sensitive tests
Date: Mon, 25 Mar 2024 18:29:19 +0100
Message-ID: <7d32cc650373af8e477c193d77b7748913bb5594.1711385796.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS7PR12MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: 811f4efc-3215-423c-8c53-08dc4cf1ac29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NoRezW23hTxO+N4waBeWfCjOACQ4qPzB/IW8k/RWlC01X388b/HSS9mW0ixOk1wss7A3Goh3cBMV/9avxMe2GUnT6iaqMHldn0uAG1SXxqf0ewqzIHv+RxxWIeyWmTioX+1GX/WqykJklptsHhfoN85IceXDL67FsH2zjJxVRMeYfOitQIDFsVNgrVsKJsSZ3RvnxTUby7S/8bxYnfs1uSJfIgBYAOhgjhh9YvvimwmgjyLrRjGr0yTu2KpZx1ZPlADsQplWXiNb3dDmRzyxFW+hNzAYvR7lQ22NgGtl5CBVZ1HFW6NaiJ2m5i/CiTderY3o82ekyMmOGfyQSOx3OJkSN95yDnn9AH7rUPlNYrQstk8sRSqnAbh3lAJ7SQ/GR9+MnrNzfLBrVsvRvkYPXfcHAF4fbM0gqrvfbOALyASBw1gS7hbtWeR3502kvoPww2yzb2N5XJ5BZl3Oj3eAuh7FcWkqZb8kNaA58IBEoici2hKG47ctNLfytfve7C0nWzIPm6RDsWckcEV0AsAFJAvyPLSEddzDga4iap1azOBaAsjC6ZehhADUefoOYluzhic5Tm3t9RQk5Igd+DkKh1pcCGEQTqveg/TBn6E+ZYBvZQiw2OOq9WOGele0OCTqEeYXbebKDY88R9veu3vKKP1ohzVgcfGegZzIinkxFKdFuu1rQwH8zQPWH/KatOJVGV7PlHctXEgTFdFI573/zBG75fm+OJcqpIPKn1VHVngfRAayUgSbGvCxC17d8829
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:23.8688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 811f4efc-3215-423c-8c53-08dc4cf1ac29
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6288

When run on a slow machine, the scheduler traffic tests can be expected to
fail, and should be reported as XFAIL in that case. Therefore run these
tests through the perf_sensitive wrapper.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../selftests/net/forwarding/sch_ets_tests.sh | 19 +++++++++++--------
 .../selftests/net/forwarding/sch_red.sh       | 10 +++++-----
 .../selftests/net/forwarding/sch_tbf_core.sh  |  2 +-
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
index cdf689e99458..f9d26a7911bb 100644
--- a/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
+++ b/tools/testing/selftests/net/forwarding/sch_ets_tests.sh
@@ -199,25 +199,28 @@ ets_set_dwrr_two_bands()
 ets_test_strict()
 {
 	ets_set_strict
-	ets_dwrr_test_01
-	ets_dwrr_test_12
+	xfail_on_slow ets_dwrr_test_01
+	xfail_on_slow ets_dwrr_test_12
 }
 
 ets_test_mixed()
 {
 	ets_set_mixed
-	ets_dwrr_test_01
-	ets_dwrr_test_12
+	xfail_on_slow ets_dwrr_test_01
+	xfail_on_slow ets_dwrr_test_12
 }
 
 ets_test_dwrr()
 {
 	ets_set_dwrr_uniform
-	ets_dwrr_test_012
+	xfail_on_slow ets_dwrr_test_012
+
 	ets_set_dwrr_varying
-	ets_dwrr_test_012
+	xfail_on_slow ets_dwrr_test_012
+
 	ets_change_quantum
-	ets_dwrr_test_012
+	xfail_on_slow ets_dwrr_test_012
+
 	ets_set_dwrr_two_bands
-	ets_dwrr_test_01
+	xfail_on_slow ets_dwrr_test_01
 }
diff --git a/tools/testing/selftests/net/forwarding/sch_red.sh b/tools/testing/selftests/net/forwarding/sch_red.sh
index 81f31179ac88..17f28644568e 100755
--- a/tools/testing/selftests/net/forwarding/sch_red.sh
+++ b/tools/testing/selftests/net/forwarding/sch_red.sh
@@ -451,35 +451,35 @@ uninstall_qdisc()
 ecn_test()
 {
 	install_qdisc ecn
-	do_ecn_test $BACKLOG
+	xfail_on_slow do_ecn_test $BACKLOG
 	uninstall_qdisc
 }
 
 ecn_nodrop_test()
 {
 	install_qdisc ecn nodrop
-	do_ecn_nodrop_test $BACKLOG
+	xfail_on_slow do_ecn_nodrop_test $BACKLOG
 	uninstall_qdisc
 }
 
 red_test()
 {
 	install_qdisc
-	do_red_test $BACKLOG
+	xfail_on_slow do_red_test $BACKLOG
 	uninstall_qdisc
 }
 
 red_qevent_test()
 {
 	install_qdisc qevent early_drop block 10
-	do_red_qevent_test $BACKLOG
+	xfail_on_slow do_red_qevent_test $BACKLOG
 	uninstall_qdisc
 }
 
 ecn_qevent_test()
 {
 	install_qdisc ecn qevent mark block 10
-	do_ecn_qevent_test $BACKLOG
+	xfail_on_slow do_ecn_qevent_test $BACKLOG
 	uninstall_qdisc
 }
 
diff --git a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
index d1f26cb7cd73..9cd884d4a5de 100644
--- a/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
+++ b/tools/testing/selftests/net/forwarding/sch_tbf_core.sh
@@ -227,7 +227,7 @@ do_tbf_test()
 	local nr=$(rate $t2 $t3 10)
 	local nr_pct=$((100 * (nr - er) / er))
 	((-5 <= nr_pct && nr_pct <= 5))
-	check_err $? "Expected rate $(humanize $er), got $(humanize $nr), which is $nr_pct% off. Required accuracy is +-5%."
+	xfail_on_slow check_err $? "Expected rate $(humanize $er), got $(humanize $nr), which is $nr_pct% off. Required accuracy is +-5%."
 
 	log_test "TC $((vlan - 10)): TBF rate ${mbit}Mbit"
 }
-- 
2.43.0


