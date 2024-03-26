Return-Path: <linux-kselftest+bounces-6649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B2288CA17
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 733941C624C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A595A84FC9;
	Tue, 26 Mar 2024 17:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fvfI+kkB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E2A1CD11;
	Tue, 26 Mar 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472519; cv=fail; b=UiysHZoXzA2M1Oqi0eYL8HJ1lGaXyxILwR7HVSWcy+ZCAPlGECJYpasOK0q42qvtclp9OsWQmT/otq0d/nSxafA2XjbK7bFy/q7DAYd9Jc30JzdBGxMwqAxsOgpKHRHWVVgZd1dtvG6WgbQMNdAjCfELpP729QXZgyt0MHsJn+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472519; c=relaxed/simple;
	bh=sSYwjOrOgKy6m8wve4tKsRPt+gTovOReL5XmBXqY8s4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cT8zP3u7qxw3nsDbBr92rymmahfrhv2vmrKU8GjZtXB70q0FnG/pXOkZ2TQ6Xb6rLnbNO5mzmoG4b33wIGB/PegKmVWX/tHSw8mgqFjytHAbV8N05St6Sjnb6zG0K5VB83fmhGiEWrjQbMPYNH4P/czSpTDcYhMxSEcLoWPfq/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fvfI+kkB; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+ip01aFAqIWrswrgSDKiSQeMovGdji/9qiZlY95SxxmfotvZb3UcHox3RrgMyZcgsIqiGe7iB69Ht2eUdOa0M1ODEDwsA+s7DUfoo+brVeYg1PYiKEc4WAEYBuFK2TEvgtoKlOPHritZ24wehGrGJJ9bFwIbQ91US91mn3lQeksaX0pSxzd44ikRJPKCETjEnWsRJ60rUVW38cAXOTrVKxjHTU3C045dNCPraVmEqNYWD4V5yh5pW8Zs13dsKwG9oWHCJhgeANCqIxY6opXKWrjORr9HUgiMCpP4r+dvHiW59tjj3Esv72DC0Sy7hVJaunug7zkkSW/JkHYGm26Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6cJ6yKi8ZqS5c31O3GhLJGCv/2kZHpaea/0vl72qBg=;
 b=a5qED0A7QZ0j8WWgLVxU+slzdSehtoUr++4FcF7TrOl64Z0Qij6NsuFrmRFRQm7E7wETVn3bKGuVuB5+9/FHIxKUvYcLixYXy5y2DBUCvrXE0qt8Zq7ASXQm5vEISdURIccdWpSC20CGMtw/b1I9CZBfjXxXjlPXK1F+TGe3bgPhl7+dZr+kTydii0DuOl/Th3tgcVBzGWsTb2DCDiH1mHZShsh1BAWt4MCAxNKCLa9TTWgdb6MNxvCPgrizbA0Gg6Uh2fqXsCVYwa1Ll62BaFia6OkCq0fHIKug8hXyM/Id4wcJ7+uw+20gkiAFCw0gIGtodPKM9lqdrY0HRB+sTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6cJ6yKi8ZqS5c31O3GhLJGCv/2kZHpaea/0vl72qBg=;
 b=fvfI+kkB9JY8iljXu7M8rnV4GSbJaTjzQM5T1tckUbz7ygBUSCtv1ZisxFujugsZJvzBF05sYmRzcYZtencwMeIcVxHPzSv4ibV+qKPvgIRzl7X1XWIbNqWW1SO/k8VdydUKIrFZThPk/KG4O1VshUZgfg5hqNGv8BQy+lenBfDLhQUeS7emAJhg1ENH/GEYgP3uzQljIeB2hx25+ijVzfoj19bskCK8ipIyOC1PQPvuAJrbd048SC7789wEVwl3cBgEgiN1xRebK77FZDNtoQy3zzAXMADmu78qWDQEfkma143mJsJrEchNJYzOyKI3MIxUTZgT1UbZU4jABrE6yw==
Received: from CH0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:610:77::18)
 by SJ2PR12MB9192.namprd12.prod.outlook.com (2603:10b6:a03:55d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Tue, 26 Mar
 2024 17:01:49 +0000
Received: from CH3PEPF00000009.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::6) by CH0PR04CA0043.outlook.office365.com
 (2603:10b6:610:77::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000009.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:48 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:20 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:01:14 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 12/14] selftests: forwarding: Mark performance-sensitive tests
Date: Tue, 26 Mar 2024 17:54:39 +0100
Message-ID: <9a357f8cf34f5ececac08d43a3eb023008996035.1711464583.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1711464583.git.petrm@nvidia.com>
References: <cover.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000009:EE_|SJ2PR12MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1511c3f8-42ac-4f97-50d1-08dc4db66cf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FmL+CbtpT9TeFKSlRSrs2QpbkYr4AXIXmBhl40/XSIEq6tAqwCoBvuBrqNBDiVIyMLY61c1WnnBsMSEeiMI82ZsqLI61b+5OrzDxtY7YMbJ12pAEtGgmBf00vn5X/GkcmhExw+SN/+vA+qljlSM2DeErsXkpPxnnxuLs6qqzQH4vo3UUO4zzEaHFxUYYSupaLAvreIwq6w8oZ3oMlE2YGqxO3Hjv4DUHS5xZrF94PLPc3EBQh14DR2H4rhoL5ACh3oG2pdY3R1HPJxlAazTbLhQsCq4qY+kn9fBB2NX1nuRMYge5GTT/xGfWDM+e5H0rJwR6mz1Y5A7vMU6FQhQusAz2kNg4Dy6prVExA6E6o04s/fng1r/Syj652lyJ34f4bmcrdFl/fad/IAltB+4/eVPAGBRB34A+nLakZSb8uXy9oT9Q95gz8IH66cheySO2w/wUjQwTHKZwZscVb7kF8mmYdHnvoz5rOW7QcyPHv6YZwDF8UXCV95UW0QvQXMolFuWXSJzovjF88mUIKJIIQN1yJlL7y/kEzcVXGsZ1H9Qc1J2K1vR72CzQpJky3kqcnuBnsxqUaHFHJwJumEeZ8VXG8dxXykZBSJ1ltUQsAkLISamzTMstWfhaLIJ3fRAw1EuGy7RogOCgCMPKHplImqNWMQVAVJtoOK3GjKe6Gu4uy8NPtEi0JVRT+Qft32UxZGa2fi0pm6parCP+bIwK0gzRnychDoi1YXTWxpfMHhXrztWbBNrUWuzt7QeP4NV6
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:48.5714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1511c3f8-42ac-4f97-50d1-08dc4db66cf9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000009.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9192

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


