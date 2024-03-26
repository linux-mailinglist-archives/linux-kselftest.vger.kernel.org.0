Return-Path: <linux-kselftest+bounces-6650-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F3D88CA19
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4519321FA1
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0525129A81;
	Tue, 26 Mar 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iobb6EHG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2066.outbound.protection.outlook.com [40.107.96.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABC61CD11;
	Tue, 26 Mar 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472524; cv=fail; b=P3foR8eYqSelhzGkkGg2OlnJi0qY3Y7AiNnimFkkIpZtFZnUyajnSocierMvJQW4q7rW+OpXTmHPBX9hTuiZcFYeXas5X841/+Ur8Y++amDIKLTXIFA8JHdomZlQQNX+0gSyGvmQYmr2G3aIwvIAuGfADsreaIDme507LbeFNOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472524; c=relaxed/simple;
	bh=bIdZR29d71wog5DD+7gm3SQN4+IqO7xFShC5Vvpj8tw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9/BXGILR/5zdRhMDiDoNv8p8yqWvXoeRjIW306G3atdxCJN3w7vF0PQOtUiGLRnbJzjlF8IqbWsEtIYsXAJAGF56f2CWyPpFeSHdGo2vrQI1rC+c8AfUV0kyN/sYIywGJzWDDlNhoVb5PCq4AYbEXZrrKjC7I8AOIVyAuQOfO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iobb6EHG; arc=fail smtp.client-ip=40.107.96.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8pW2wz393tuX8ZVbRUYVZ1N3FRC4PgTHUdIZN93/PirCzWpvFIAMCsqa12oFme5Ax1I5ugRslR3SX20NPeE/U+CdfiMYhx92jBa+4B6LbKxFR6l9y+YUAR1Jb1zNBeI0CbmkhGg/PxcZ5zbfzcBeUHWj2eiWlhldxD8oiOv2DRZ0z4S63O08qNpXq3R2v9mK5XGyf9Zr/DSUOqVuGc0ovrxKkDsl104CSdMjg5D3h6NaIPcXk83ELWN7OBC1pmG6yg33BhxI4UXveInPMIJZ4IY0EV9cxF4NO8YZVZ3In3VemdUImsaB4ym6oimyrxVKoNFfXM85zQ0IL0dWjOchA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14NYtEbeH0hz72BbkVr5R+v1zHQPqoAs0iuS1ashEos=;
 b=QvmjTOxZcVbqkzMvhlBcRjLyXRgnWFfaDrvv9ZXR5zL4o/Q8qWvNkxnamnLBflAket4AH7zK+iM4zEV+UFpzBm4xG81H01lfL30o9ZWjGHzN/lZ8yBXh79ymo1fj4pIlop1JGFbMiaWQlrxhYj6kvPAd93kR5GYwWxetKZDohlkutV6FHR0pdvmmljA+tPAt8NgfHFYaYoK/2uI8QSt90NLVkrlBpyW2d5sWl7+3LhEpjtSrwYDJeRF4mmCvSKGktF1Kvy5dq5H2yRU8sxVeokDF6THblJi1mGdzvS+wnp5y7W49IHDNT4cZvVSZNbOt8V5ug3qhDciKe7x4lE+Kow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14NYtEbeH0hz72BbkVr5R+v1zHQPqoAs0iuS1ashEos=;
 b=Iobb6EHGPbY8r3ERO8hmSrRsNpQdihQ4S3T+ZQYnFy1cJT0xRC2ER4AdY3BCimAiygUeRQgWCRnFtrVQ12sLaYv13rkGCpMXjsQDeDAXNFtTYYHG9EzEUHh64iCpBpuBwECLc8a8EtGBl/SLeO+sqw5nd0aERyv1945V3NsP6SqybBrfygnu688avMQPovagAQeHjxV3L6mqDc5W5jPB61J4PD0Z7m6LXOm3wAm07tNRQ2wuREF9U36fgkjdiuuJyHdROFtekqPiF8zCTn6UhkgMU7LKXuTeOdDgWmZEVhHHbWG5CgWl4xpG4F/puv3viyaCSj0lYd0fyl1p3P1BxA==
Received: from CH0PR03CA0399.namprd03.prod.outlook.com (2603:10b6:610:11b::18)
 by DM4PR12MB6037.namprd12.prod.outlook.com (2603:10b6:8:b0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 17:01:40 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::d1) by CH0PR03CA0399.outlook.office365.com
 (2603:10b6:610:11b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:07 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:01:01 -0700
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
Subject: [PATCH net-next 10/14] selftests: forwarding: Convert log_test() to recognize RET values
Date: Tue, 26 Mar 2024 17:54:37 +0100
Message-ID: <e5f807cb5476ab795fd14ac74da53a731a9fc432.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|DM4PR12MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 592f3fc5-de39-45f8-fa39-08dc4db66672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	daB0S9nHk/O6Iqi+YUqqolXK2WTzbyPr0yGchej56548sfQvl8Xj9Iia1qyA95LIXywOfV7zNgmVFGGP9mWr48LLla965xbjPdwmPSr1HOG2onlF7T//hyPrE20RrEWDNwhD0ChE0iliDptmVDmsuVoHzDB8yn3msGzbu9XcW+wjgGfp8yr/W1Qg8lbWYXcyogeqeQCb3NBwbMO1HhSeKObO+j2OjM+cKcfa8T/eYx/txquATa+H12hzAddKt5IhwXCynOAWuqZUB0GcaM0vUO0lBs0kdS8A4LimZRhreP3/3/BrgAKQIezBbtvEtlSULtxiphTp16bZglReBqTE5a4vDRBsLvWe0KEg3eZq5WgevW5RYQEtXMiO4rVwSTv4CuxLmPE9wtddB43alsZ64AHODkiDutXgrTDbh6m0dmExQs2ZXwrx21pnWwN0jAscT2SKAuF8lb1RdG5jPUzWgR+W+V8zXeyzbVUApG7ywnrP45zqrRE7ioUugRvUS7U4IjEo7iSoTtO7tFZFWxU91s9p+lGFp3gSMYZFOACVzswv6BS3Ddi3q5lN7M8qy4jwbKRma1JOyPfxHCuhnLeygFIP21GOINo/AMlzSy1NuL0ot/2qJC6OV+mHmtZcn2xhIbCIUxKiMC889m5G1hn8/boI+nU70+fdg/3TvGKlJGy221pOq6yHI7EXThNS3q2L+7KwbG4qkRx6gNcWsLSDGpPL0H2LF5HZg/WSPQbWYTqvuLa0Ok9mYkwo6Gj39e9o
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:37.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592f3fc5-de39-45f8-fa39-08dc4db66672
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6037

In a previous patch, the interpretation of RET value was changed to mean
the kselftest framework constant with the test outcome: $ksft_pass,
$ksft_xfail, etc.

Update log_test() to recognize the various possible RET values.

Then have EXIT_STATUS track the RET value of the current test. This differs
subtly from the way RET tracks the value: while for RET we want to
recognize XFAIL as a separate status, for purposes of exit code, we want to
to conflate XFAIL and PASS, because they both communicate non-failure. Thus
add a new helper, ksft_exit_status_merge().

With this log_test_skip() and log_test_xfail() can be reexpressed as thin
wrappers around log_test.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 92 ++++++++++++++-----
 tools/testing/selftests/net/lib.sh            |  9 ++
 2 files changed, 77 insertions(+), 24 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index ee8153651b38..370fc377249b 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -438,6 +438,62 @@ check_err_fail()
 	fi
 }
 
+log_test_result()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+	local result=$1; shift
+	local retmsg=$1; shift
+
+	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
+	if [[ $retmsg ]]; then
+		printf "\t%s\n" "$retmsg"
+	fi
+}
+
+pause_on_fail()
+{
+	if [[ $PAUSE_ON_FAIL == yes ]]; then
+		echo "Hit enter to continue, 'q' to quit"
+		read a
+		[[ $a == q ]] && exit 1
+	fi
+}
+
+handle_test_result_pass()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" " OK "
+}
+
+handle_test_result_fail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_xfail()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
+	pause_on_fail
+}
+
+handle_test_result_skip()
+{
+	local test_name=$1; shift
+	local opt_str=$1; shift
+
+	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
+}
+
 log_test()
 {
 	local test_name=$1
@@ -447,40 +503,28 @@ log_test()
 		opt_str="($opt_str)"
 	fi
 
-	if [[ $RET -ne 0 ]]; then
-		EXIT_STATUS=1
-		printf "TEST: %-60s  [FAIL]\n" "$test_name $opt_str"
-		if [[ ! -z "$retmsg" ]]; then
-			printf "\t%s\n" "$retmsg"
-		fi
-		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
-			echo "Hit enter to continue, 'q' to quit"
-			read a
-			[ "$a" = "q" ] && exit 1
-		fi
-		return 1
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
 	fi
 
-	printf "TEST: %-60s  [ OK ]\n" "$test_name $opt_str"
-	return 0
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
 }
 
 log_test_skip()
 {
-	local test_name=$1
-	local opt_str=$2
-
-	printf "TEST: %-60s  [SKIP]\n" "$test_name $opt_str"
-	return 0
+	RET=$ksft_skip retmsg= log_test "$@"
 }
 
 log_test_xfail()
 {
-	local test_name=$1
-	local opt_str=$2
-
-	printf "TEST: %-60s  [XFAIL]\n" "$test_name $opt_str"
-	return 0
+	RET=$ksft_xfail retmsg= log_test "$@"
 }
 
 log_info()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 88f6133ca319..b7f7b8695165 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -49,6 +49,15 @@ ksft_status_merge()
 		$ksft_pass $ksft_xfail $ksft_skip $ksft_fail
 }
 
+ksft_exit_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
+}
+
 busywait()
 {
 	local timeout=$1; shift
-- 
2.43.0


