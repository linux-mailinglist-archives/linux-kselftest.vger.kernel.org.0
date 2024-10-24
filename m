Return-Path: <linux-kselftest+bounces-20557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E509AECE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43EFD1F24772
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA641F9EBA;
	Thu, 24 Oct 2024 16:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ugK+WGIs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DC1F81AF;
	Thu, 24 Oct 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789132; cv=fail; b=Z5b2Toyv4rJH3yRkgo3T+PKEtuczHovQ91y4E01LskMeKOTQqqv5TjEyBiWOhyiWnqnIZAmc7JJwgqwjXOiWHuDGqjoXgJDWRA0SMZZEqsfsvtqe1rRQ9LIaUpro/+v4ammGKGWNlCSBsfvB8WpWDY0DbRoHPILJpIL1XfINnOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789132; c=relaxed/simple;
	bh=bB2VEd4YT6YHTgXj+C/TTYBPSR0awEE01De4Ib/o5PI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ty/Jhg3ux1a3UFRTNfhZVqBIoZttLyqqu4tVBUzHwAg6Z4kkuTirpPmAtPwPNmc9unT3N6rNB0UXx0u3/24MIF/lhM+DBulXOOKmqt4K+JGMFpld7TcaQ+6pJ0nONIxXXfGw41sYfSZQRSG1bEoi/g/S3bkMuqtt6EVWWHiaSEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ugK+WGIs; arc=fail smtp.client-ip=40.107.237.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MdW7jF/Rn2a5aWVPsVQ4e9fPq+5PXclS582p1skN9oTdW66g+wSM40s1A/+uiLDrsZV4fgfakJUsM9WzrUWh+W9NdxAGQX5D5HUJNwoUyIfMCoIVR+Mjr+YTBnQ7xaMmXeEXyZrFtb9jQ84ArJD2NFb/9FXQc9TmQ9ek3r/xKM/XgDkeXIkRCjXlrijgBjR3wo42XlpE1NCmjB+H5pL9FfqgW7CgP4OmSy2cpdtwaK1Z7YdNv9Tu9bhbMf9BYgPTK3aP0T0DA9IxzlJWRYjKV5vXCHIaF1SYEx5G7LkqJxwKaLmig4EK71gsi5B3HU0thb/2joLHbzTzWGRz89fStQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VNNSF0NBgVWkmy9I4jKrbk6AagiRly6wf8AwsXICTQ=;
 b=pmXNVPxyDcw42iHdseMbWVNwt2VvyRZKvtwpouvRnMymmkYSt85ar/Xeekv1i9C5A73TcOwsmCDY1LiEQLDQRNaa8wyw3aSOY5lHZtdShUb24VAW4LTHMAx4kUUxuU6G1OJe2OBh6gPoU+FuKn8LluaIZy/4KkZe7tIgIeN5vmxWg2fA+rJFvqehDWDsK/yhWf0RB2kq7l1oAjdpO2DZHAB6y5xavRV2kEIcNTimvUcA499s0FbPqiA1lF2vrSVW0kf2ZDAQcrTrgy98L1ulmHBSJO6DxIAJN77IP0noyIKAF4kov0/iCTNf/M++/Ko8AZN2HyzVzLkPLvNSwY3HWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VNNSF0NBgVWkmy9I4jKrbk6AagiRly6wf8AwsXICTQ=;
 b=ugK+WGIsz1TjqrAsbPPD32UOpcwNPDyDLmUy/gFDho78448yFBjQodnOgzVNMqBIRijhIv+virL8W+JfwyLUeL9giVt4T/TTt/iGHgpW7DDOpWfOQFDmhCL2JYG1FuWm90eci0+W7zQ4YT/jQ6OYRssipRXF4it5qHL1CeJWtV88v/fyVJr61Ca5NjkbTndZ0E9TafFUvrgKg5XqYuUpS9FiS+TSpwEDe2XaQAWaOX4LKwyPltbglBv3l0shVdt8aK5n+10W7KcsHqC4bj30HdarnhjJ617ewR3ltAJgV4yzsa3mTd7cd+2I9XV2Uc2jjwJb5+XdamdXQJVtud/cdg==
Received: from BYAPR02CA0009.namprd02.prod.outlook.com (2603:10b6:a02:ee::22)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 16:58:42 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::2e) by BYAPR02CA0009.outlook.office365.com
 (2603:10b6:a02:ee::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:28 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, "Andy
 Roulin" <aroulin@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next v2 4/8] selftests: net: lib: Move logging from forwarding/lib.sh here
Date: Thu, 24 Oct 2024 18:57:39 +0200
Message-ID: <74af7d80d649ac931c0fa164a2a510a6600966bb.1729786087.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729786087.git.petrm@nvidia.com>
References: <cover.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: 1563387d-edb3-4903-f7bc-08dcf44d1d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K2PpV30iDcwYk3W65WAcF1DMEK+17JjqxA5fv6tG25senQom9BC2Na1NvgMv?=
 =?us-ascii?Q?tN1YBjDxkxtut8/olGjKzAda7T2cg0R5MNa0OJAH0JT6VamPvd9HHOBFqr0L?=
 =?us-ascii?Q?FouAGe5yv/AoVyEJXfj7e1ZTpcxBEqKaExyqpdLWHTcihjskaeRyAqN6865F?=
 =?us-ascii?Q?uHiI2qPnJ6zYkBzl6qnl1C/ep9HqCZtENDl1+ob8GM5Wn1eya2Hyz9oXBB85?=
 =?us-ascii?Q?X/Gaz1HIBm/6eflVF62v+wecfw85JyI5FpVH0d7vdyjSzOJH5VptyDlLyev5?=
 =?us-ascii?Q?sLMu/hMpumKbeG7wGKEO02EtYnKft4kZbR8X3w5VXVW9C+dqyyySno5RjWqx?=
 =?us-ascii?Q?zS5PPngOtX/UhKrOjzUp1fk1G900ntKV/pCEHQN0vUm/B3Jy5p7o/0JfKhLd?=
 =?us-ascii?Q?jna9Oe4nFLq2UJ75Xa2mQTBtrZONAM9/4SoUvokUhQXivkfqCN+qCA9sudGn?=
 =?us-ascii?Q?P4Ipi22vZ5GV2cy45ovfTDf4tHDdd2+hD6WiNayveuuk7QWtEuvQau1Rcx+g?=
 =?us-ascii?Q?3VDqM9jAE8yeAlhNj9Hl9IOHCT6SXRlE42lj0NzOJwrfse4YcM/yFmKHWq0h?=
 =?us-ascii?Q?sK9ZohJuNhy8hQgDP7leJaVLzZ9WiHzo6ZveorSil2sfSJvRGorQpwx3k7U6?=
 =?us-ascii?Q?Yx9OO1EMHscl90LJC03lcP8DjsU8dxgneQwue31l7Jyv1RCLEG2i9CcqQMiE?=
 =?us-ascii?Q?T352OVxMI1BlbhuYEwziM6w66ZY7Sr1fXZTbUoG9/s4fI4rPWWWCLsa4yRNs?=
 =?us-ascii?Q?exeG0MbmGq15PS9oFeTn27sqB3acjVH/uSDFdV6yp2FNhjqSHfLB6OcJfh+O?=
 =?us-ascii?Q?oiOlPd8cLdWZkD+oyiKchHwrM4sthYKLG91OQrK6Gi4rAUruUxDgWTvo2yi2?=
 =?us-ascii?Q?m24B/iBMd1XYvNioYRQu8v71jtkQ78Q8ch4iC6Scu1nea6xW06y5bF9b8tn7?=
 =?us-ascii?Q?62mfJg32sbuiRA6J72mYiuHpdNE0qkQN5pBGIgCerdp7GjEhNhM+b+h7r2aB?=
 =?us-ascii?Q?JawpAiMps6ZH1YrYr5tIKGvz3u3VhP4j+OiYwwAdIDAJVrOnqzhBhWkpPWKS?=
 =?us-ascii?Q?knxolRqzOIAD4qwQZef5qO8YAomoN0/8+xqSHdCL/t8qezm3gqoHcoNI20CB?=
 =?us-ascii?Q?a+HhDhnlWS2/fDoVthjprGv3rXIJm6nFwQ4EtiIdahbkw7d1YfD/TZcFq21M?=
 =?us-ascii?Q?VHjYDuNTxGEoGIb/4NiOSvxQYZ2rAkQWye6tW2SpafZoqtlp70BYTtmZ6TqK?=
 =?us-ascii?Q?XPaf12CaC6aZnggq2qHURR1LBPeNLBE31L9hSJTwGvcirLVHYGcp5+bm9LAZ?=
 =?us-ascii?Q?41UqKOZ89fQCSwDYoEfPM49jekbqpfBIHu6CTaljSlEbWEQtSzwRj50+iPhQ?=
 =?us-ascii?Q?Y6ShfdM6oUAzs6Eq8KKmahJ7L930E/MNnn80FwVV8WoUuqAZZQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:41.8273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1563387d-edb3-4903-f7bc-08dcf44d1d27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375

Many net selftests invent their own logging helpers. These really should be
in a library sourced by these tests. Currently forwarding/lib.sh has a
suite of perfectly fine logging helpers, but sourcing a forwarding/ library
from a higher-level directory smells of layering violation. In this patch,
move the logging helpers to net/lib.sh so that every net test can use them.

Together with the logging helpers, it's also necessary to move
pause_on_fail(), and EXIT_STATUS and RET.

Existing lib.sh users might be using these same names for their functions
or variables. However lib.sh is always sourced near the top of the
file (checked), and whatever new definitions will simply override the ones
provided by lib.sh.

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
---

 tools/testing/selftests/net/forwarding/lib.sh | 113 -----------------
 tools/testing/selftests/net/lib.sh            | 115 ++++++++++++++++++
 2 files changed, 115 insertions(+), 113 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 89c25f72b10c..41dd14c42c48 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -48,7 +48,6 @@ declare -A NETIFS=(
 : "${WAIT_TIME:=5}"
 
 # Whether to pause on, respectively, after a failure and before cleanup.
-: "${PAUSE_ON_FAIL:=no}"
 : "${PAUSE_ON_CLEANUP:=no}"
 
 # Whether to create virtual interfaces, and what netdevice type they should be.
@@ -446,22 +445,6 @@ done
 ##############################################################################
 # Helpers
 
-# Exit status to return at the end. Set in case one of the tests fails.
-EXIT_STATUS=0
-# Per-test return value. Clear at the beginning of each test.
-RET=0
-
-ret_set_ksft_status()
-{
-	local ksft_status=$1; shift
-	local msg=$1; shift
-
-	RET=$(ksft_status_merge $RET $ksft_status)
-	if (( $? )); then
-		retmsg=$msg
-	fi
-}
-
 # Whether FAILs should be interpreted as XFAILs. Internal.
 FAIL_TO_XFAIL=
 
@@ -535,102 +518,6 @@ xfail_on_veth()
 	fi
 }
 
-log_test_result()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-	local result=$1; shift
-	local retmsg=$1; shift
-
-	printf "TEST: %-60s  [%s]\n" "$test_name $opt_str" "$result"
-	if [[ $retmsg ]]; then
-		printf "\t%s\n" "$retmsg"
-	fi
-}
-
-pause_on_fail()
-{
-	if [[ $PAUSE_ON_FAIL == yes ]]; then
-		echo "Hit enter to continue, 'q' to quit"
-		read a
-		[[ $a == q ]] && exit 1
-	fi
-}
-
-handle_test_result_pass()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" " OK "
-}
-
-handle_test_result_fail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" FAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_xfail()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" XFAIL "$retmsg"
-	pause_on_fail
-}
-
-handle_test_result_skip()
-{
-	local test_name=$1; shift
-	local opt_str=$1; shift
-
-	log_test_result "$test_name" "$opt_str" SKIP "$retmsg"
-}
-
-log_test()
-{
-	local test_name=$1
-	local opt_str=$2
-
-	if [[ $# -eq 2 ]]; then
-		opt_str="($opt_str)"
-	fi
-
-	if ((RET == ksft_pass)); then
-		handle_test_result_pass "$test_name" "$opt_str"
-	elif ((RET == ksft_xfail)); then
-		handle_test_result_xfail "$test_name" "$opt_str"
-	elif ((RET == ksft_skip)); then
-		handle_test_result_skip "$test_name" "$opt_str"
-	else
-		handle_test_result_fail "$test_name" "$opt_str"
-	fi
-
-	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
-	return $RET
-}
-
-log_test_skip()
-{
-	RET=$ksft_skip retmsg= log_test "$@"
-}
-
-log_test_xfail()
-{
-	RET=$ksft_xfail retmsg= log_test "$@"
-}
-
-log_info()
-{
-	local msg=$1
-
-	echo "INFO: $msg"
-}
-
 not()
 {
 	"$@"
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c8991cc6bf28..691318b1ec55 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -9,6 +9,9 @@ source "$net_dir/lib/sh/defer.sh"
 
 : "${WAIT_TIMEOUT:=20}"
 
+# Whether to pause on after a failure.
+: "${PAUSE_ON_FAIL:=no}"
+
 BUSYWAIT_TIMEOUT=$((WAIT_TIMEOUT * 1000)) # ms
 
 # Kselftest framework constants.
@@ -20,6 +23,11 @@ ksft_skip=4
 # namespace list created by setup_ns
 NS_LIST=()
 
+# Exit status to return at the end. Set in case one of the tests fails.
+EXIT_STATUS=0
+# Per-test return value. Clear at the beginning of each test.
+RET=0
+
 ##############################################################################
 # Helpers
 
@@ -236,3 +244,110 @@ tc_rule_handle_stats_get()
 	    | jq ".[] | select(.options.handle == $handle) | \
 		  .options.actions[0].stats$selector"
 }
+
+ret_set_ksft_status()
+{
+	local ksft_status=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $ksft_status)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
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
+log_test()
+{
+	local test_name=$1
+	local opt_str=$2
+
+	if [[ $# -eq 2 ]]; then
+		opt_str="($opt_str)"
+	fi
+
+	if ((RET == ksft_pass)); then
+		handle_test_result_pass "$test_name" "$opt_str"
+	elif ((RET == ksft_xfail)); then
+		handle_test_result_xfail "$test_name" "$opt_str"
+	elif ((RET == ksft_skip)); then
+		handle_test_result_skip "$test_name" "$opt_str"
+	else
+		handle_test_result_fail "$test_name" "$opt_str"
+	fi
+
+	EXIT_STATUS=$(ksft_exit_status_merge $EXIT_STATUS $RET)
+	return $RET
+}
+
+log_test_skip()
+{
+	RET=$ksft_skip retmsg= log_test "$@"
+}
+
+log_test_xfail()
+{
+	RET=$ksft_xfail retmsg= log_test "$@"
+}
+
+log_info()
+{
+	local msg=$1
+
+	echo "INFO: $msg"
+}
-- 
2.45.0


