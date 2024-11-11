Return-Path: <linux-kselftest+bounces-21793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC379C4345
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2141F21CFE
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DBB1A4F12;
	Mon, 11 Nov 2024 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="R56EpXIv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0221B95B;
	Mon, 11 Nov 2024 17:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345144; cv=fail; b=CffFDrHT016a8kqZ0oO9P9dFQN4EccTjoUftjZEds2892VvC6LQTyslZ2dvCW7G1KCMe0/4mYL4PscA38CP61wa3G/yObsXXkJj0Rg4M/2kb4SlMGyzGVK2LUgyNz6n7osMH5T7QvWryafackvby+FkKl7gCP1jlhwLEyFJA4us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345144; c=relaxed/simple;
	bh=W1Jbsrl3SASOFhpOFkg6RFsRhT9Nixy5sz1Lwc1l+ZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHyAbF7WSc6Ax/prrPeMMsF6WRRa88enoro7QSm1Xa8wwUb+nmbZ2eu66OcWpeWrS1AKLtbOwGdQh1efMPpV+Ug1LVWvJY+5TCVFmrv2tRKmtCKBym6XLA5Owg+DCvXJCK5OeVYozcuuhCXghdOrAa3qHyQ1npLN9nZLmGsvMio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=R56EpXIv; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xfh7dvPwwQBRmjF6CvUAa2Bm15ty5PqyJ5JDTx/3rkgcVenRWvsU6heMDCl+7m8c9QNaUraQw/0qrXc7uAZQJk3fl233ErZilucrOI9A/YcJb00YHBcswYFwanfRUZVWxbQSk0voqambUyiRdzgqfTKz9Cg7pp9tAwEOosSBvARCjvmVHd7HR1gqFvlNRKS/q7lKeaegxzJKdnExlR1lvfiuaNnmH9Yog+p1TIDJj1gAwbdbR2uXekKmxv2Ztk+M7MQSuiRyrtsvj8uBtxbJzZWHrgQ7qd8dKCb587oXhTWx1BwknNF+TgommQH2bhwJCrR9WfwwyDloQjJURnth1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ybb3cQn8Fb6xON+SG8hrDFabuFGISwWdDVgxn/JRk8=;
 b=vR9fkFNYYr1nI++3QzQXSQH9Sxza0GkAnUQu2XE4UJpStfanEd2NxdpM2sLGRBL55POeUCw1DZ4WwKaeQUXrBm6z2bu5ZisNaVCz1/kuM82qnWaMcKxl34oUhRa2WS8lQrfNo3P4glnSC4m5iz4qV81NviJyUtCSPk2MpvxtnjLO1no0pkFvjxCJiSWyT6YJ3JhdwpiK7+CSsyWvXicQ2uWaeNcTktW/C8xA3Qm9WlNuWqXz4NRTIAIuGQnBHUthHbbJjv2AhRzsWPGGcp1lPlBHqQsZfOyBZb5vqHK4xzo7J19i3SbTmJG9Wc47YjVPuMhcWHHJc8s3l/XUDIC3SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ybb3cQn8Fb6xON+SG8hrDFabuFGISwWdDVgxn/JRk8=;
 b=R56EpXIvNexEwcm7tlNa8wK5vthJsvzo6Z3oCFjuGfgTiYpJnrsbQDYVe8H3+7krlnMJ0+1l4ST6PDnNpha8xrwtlV/WqgdXvh0sPgzKjbjr/W1HImG9Q68Y3oqfcs4/l93fjA0KhnkuZ7pm4j7VSbxLnveK0y9PtVIEOo21l4oL1R67LxZWNQNxIDkbY7m2QHi1JmhDIym3m3d40gQF1V2zlBKjgpGi8ZMEFBHk6WYdBv1d+Q7e7O8QrEAj0tfZ7AGb1oU2Urv1MhNdWZumVODLPbxWU3Tmdapig0L0zJYsF9mPT7ARdX1wUBpD+XohJGjnD55wHtkyUmeSyaeYPg==
Received: from BN9PR03CA0552.namprd03.prod.outlook.com (2603:10b6:408:138::17)
 by DS7PR12MB9043.namprd12.prod.outlook.com (2603:10b6:8:db::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.27; Mon, 11 Nov 2024 17:12:16 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::e) by BN9PR03CA0552.outlook.office365.com
 (2603:10b6:408:138::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27 via Frontend
 Transport; Mon, 11 Nov 2024 17:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:12:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:57 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:50 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, Amit Cohen <amcohen@nvidia.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Andy Roulin <aroulin@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan
	<shuah@kernel.org>, Benjamin Poirier <bpoirier@nvidia.com>, Hangbin Liu
	<liuhangbin@gmail.com>, <linux-kselftest@vger.kernel.org>, Jiri Pirko
	<jiri@resnulli.us>
Subject: [PATCH net-next v3 5/7] selftests: net: lib: Move checks from forwarding/lib.sh here
Date: Mon, 11 Nov 2024 18:08:59 +0100
Message-ID: <a2d01d4d77fcc1fdcb0dabd653fd9497b6f5d7a2.1731342342.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731342342.git.petrm@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DS7PR12MB9043:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6300d3-c8cd-4a73-e82f-08dd0273fdac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UKERRKjBLyj+BFRebDY0S25nyaHpQlbBqgYoVwxabKuRkeFE8IVn7oeVWXkH?=
 =?us-ascii?Q?fnGVKMySMQhvqdd60ydGV2WNOkPVjCk/puRZuf1cM0k8xH8b0YRK5YMXB5j3?=
 =?us-ascii?Q?z72P5YnPMm12r2YN/StSJqFIcZsKfeexz/pUpt8Eau/BNMStL/+3IkdXkJaf?=
 =?us-ascii?Q?q6z1o8ceImBdyRXpHHEkQr/JgKfGuZKh+F+4llEOPJmpJMNJxPyh4A1vO+JM?=
 =?us-ascii?Q?p7Kqt4uJ7lCw2RKLUl/0ZjPhExYCvYLSU/JvAx4uXDJ1jSP+PjK0qi8KuK+q?=
 =?us-ascii?Q?mpBmdZyc10mFItyQh/Pgas/zSJ80qz+Sp8R+v4eqAW5YHfAT1dlDK2XfO99m?=
 =?us-ascii?Q?W+P4qlERqzbde1e27aJS4Ze8EeO/9kBLfdIAvQCUcrAylOAU3Hur277cu/jP?=
 =?us-ascii?Q?Zv2KTjojW9aT/B7b2ALMGq1s0XYLWRsYwS0bEVvMcgSUhjwUrGoD9dpR+D8+?=
 =?us-ascii?Q?0doG5HB5vPXHezKV3S5jGt5K7K4wRh74qdq9Ek0Jr0NIMIozBCkuHzmoptgy?=
 =?us-ascii?Q?TieTCF24wZhSmKvayM9t7BP8dJk6LWOExwtjIDVsStLAXEnDpo8VCCwjVNgJ?=
 =?us-ascii?Q?w/hIDbiG72P2t8jAkvT/nM8JouvWhlPonRPAJ3HXjybkntFMhu/X5UOZdalV?=
 =?us-ascii?Q?/EvZAmNJJ2z94nzmTb5ueF40NzJQ6Ae5LU+aU0BHMI3GtdAtTginifnCCtDJ?=
 =?us-ascii?Q?0hmGvOyHv7hXx0sTSH8GfgbSvo4qs3ohpzET8R6Atdwx72vjadUYRiyKSYHU?=
 =?us-ascii?Q?kIaberYC9mJPGXPHmoj0sd4Q33rYt/hUrFNA+y9r6ibzu8r2+cXAtb73c3+Z?=
 =?us-ascii?Q?q3qvWTQfuWoCi0N6BaFGf0SimQYYXfiJnCFFIUcY7jh+cOuRKIMD0Dhj2n1L?=
 =?us-ascii?Q?BBhqf2jgK2h2SIYek11zMYUpzE2q6gjP1ljFI9erYxe4ojdMcimsvGTjMwzQ?=
 =?us-ascii?Q?nl/gWLh0Od4yQ6sxmTgGNqi9RMY38+VtyhA9/62IdQhYvRN2qlWmLqDsZYxY?=
 =?us-ascii?Q?bW5WHHYLbwT1iwtnQdJg/QKspooeDNwDJdK8d2fzEM6OcjrS7qmD6ZuAoiHF?=
 =?us-ascii?Q?/YzAebeY1Vx0+u/2K0i1nQevJV3xWamU0eruuyWGd/Vt1rLkA55yYKdNTRDH?=
 =?us-ascii?Q?7ycmIKI8vPxgSXeqM7aplTEzyzTnqL92O6Qh003f/wiivhJo5kutDEWttB05?=
 =?us-ascii?Q?V17QDqGEHWbC181AmufTgStrfqrW3htol37iHQfeabh0Sl/K3tnxDsAAC+FB?=
 =?us-ascii?Q?Ui7u38WTaQtSb1d8OBDfOQKBpRsg35oKinmr/+Ry7cUZb1lHp1wuHcvfP10l?=
 =?us-ascii?Q?o59GkaewU1vz2PH7KGca0jR/9mbe8rns3henpIHRJKAkfRRvBLkNIgtOqQnu?=
 =?us-ascii?Q?cDwP91mBrvu0u64qS+pxN49LkxN6K+VAUFytPKBDFi1Gc1blNQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:12:15.4752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6300d3-c8cd-4a73-e82f-08dd0273fdac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9043

For logging to be useful, something has to set RET and retmsg by calling
ret_set_ksft_status(). There is a suite of functions to that end in
forwarding/lib: check_err, check_fail et.al. Move them to net/lib.sh so
that every net test can use them.

Existing lib.sh users might be using these same names for their functions.
However lib.sh is always sourced near the top of the file (checked), and
whatever new definitions will simply override the ones provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Benjamin Poirier <bpoirier@nvidia.com>
CC: Hangbin Liu <liuhangbin@gmail.com>
CC: linux-kselftest@vger.kernel.org
CC: Jiri Pirko <jiri@resnulli.us>

 tools/testing/selftests/net/forwarding/lib.sh | 73 -------------------
 tools/testing/selftests/net/lib.sh            | 73 +++++++++++++++++++
 2 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index d28dbf27c1f0..8625e3c99f55 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -445,79 +445,6 @@ done
 ##############################################################################
 # Helpers
 
-# Whether FAILs should be interpreted as XFAILs. Internal.
-FAIL_TO_XFAIL=
-
-check_err()
-{
-	local err=$1
-	local msg=$2
-
-	if ((err)); then
-		if [[ $FAIL_TO_XFAIL = yes ]]; then
-			ret_set_ksft_status $ksft_xfail "$msg"
-		else
-			ret_set_ksft_status $ksft_fail "$msg"
-		fi
-	fi
-}
-
-check_fail()
-{
-	local err=$1
-	local msg=$2
-
-	check_err $((!err)) "$msg"
-}
-
-check_err_fail()
-{
-	local should_fail=$1; shift
-	local err=$1; shift
-	local what=$1; shift
-
-	if ((should_fail)); then
-		check_fail $err "$what succeeded, but should have failed"
-	else
-		check_err $err "$what failed"
-	fi
-}
-
-xfail()
-{
-	FAIL_TO_XFAIL=yes "$@"
-}
-
-xfail_on_slow()
-{
-	if [[ $KSFT_MACHINE_SLOW = yes ]]; then
-		FAIL_TO_XFAIL=yes "$@"
-	else
-		"$@"
-	fi
-}
-
-omit_on_slow()
-{
-	if [[ $KSFT_MACHINE_SLOW != yes ]]; then
-		"$@"
-	fi
-}
-
-xfail_on_veth()
-{
-	local dev=$1; shift
-	local kind
-
-	kind=$(ip -j -d link show dev $dev |
-			jq -r '.[].linkinfo.info_kind')
-	if [[ $kind = veth ]]; then
-		FAIL_TO_XFAIL=yes "$@"
-	else
-		"$@"
-	fi
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 4f52b8e48a3a..6bcf5d13879d 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -361,3 +361,76 @@ tests_run()
 			$current_test
 	done
 }
+
+# Whether FAILs should be interpreted as XFAILs. Internal.
+FAIL_TO_XFAIL=
+
+check_err()
+{
+	local err=$1
+	local msg=$2
+
+	if ((err)); then
+		if [[ $FAIL_TO_XFAIL = yes ]]; then
+			ret_set_ksft_status $ksft_xfail "$msg"
+		else
+			ret_set_ksft_status $ksft_fail "$msg"
+		fi
+	fi
+}
+
+check_fail()
+{
+	local err=$1
+	local msg=$2
+
+	check_err $((!err)) "$msg"
+}
+
+check_err_fail()
+{
+	local should_fail=$1; shift
+	local err=$1; shift
+	local what=$1; shift
+
+	if ((should_fail)); then
+		check_fail $err "$what succeeded, but should have failed"
+	else
+		check_err $err "$what failed"
+	fi
+}
+
+xfail()
+{
+	FAIL_TO_XFAIL=yes "$@"
+}
+
+xfail_on_slow()
+{
+	if [[ $KSFT_MACHINE_SLOW = yes ]]; then
+		FAIL_TO_XFAIL=yes "$@"
+	else
+		"$@"
+	fi
+}
+
+omit_on_slow()
+{
+	if [[ $KSFT_MACHINE_SLOW != yes ]]; then
+		"$@"
+	fi
+}
+
+xfail_on_veth()
+{
+	local dev=$1; shift
+	local kind
+
+	kind=$(ip -j -d link show dev $dev |
+			jq -r '.[].linkinfo.info_kind')
+	if [[ $kind = veth ]]; then
+		FAIL_TO_XFAIL=yes "$@"
+	else
+		"$@"
+	fi
+}
-- 
2.45.0


