Return-Path: <linux-kselftest+bounces-20395-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8639A9AB172
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A1281C20E0B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D81A2643;
	Tue, 22 Oct 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q7pgm604"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B31A257D;
	Tue, 22 Oct 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608707; cv=fail; b=qb1QY5iOjDYbNwSKVgxlPsKzkkOmcDBu4Fyr6wKE2BV7HcGywbUyNRIwQLMcxelsR01UAO/QwOH05pv8RHF/IT6d6rntfp9/+RVndXqDhOBDS930VugXFRWIaKqE1RvDiQISAQZTuTV7pIxPSipLUsp1TJm++n2Wxm25yFBCwiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608707; c=relaxed/simple;
	bh=rgxDZOEsXWWOkGKIzm90NApYTnvFBiFzFItqLgea9n0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kkn0lMMC8q0VYGrW1zRB/AiUdLitRCzQPgiSN7Hpi4Yr089tIQd9voak9aDbGBplJ/bHH3KmJ5whlDVLLSwXjCPMw0Aul4HJya9xKBwuYe9pzykNPhHQ30rPJKcwl5E/jSfMNmfCPWFWAZPuf+1zau9JW0zOTInHsZ5HdSJX6ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q7pgm604; arc=fail smtp.client-ip=40.107.237.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITaGo2fZbcWH96tDUWwCcxHtu6KOlgQK0f7i2WwRTwiqNuVXrwK5btyvwAywC9Cvg0+LtQodOoqOb1d1L2zQXc0jWJLldKaIdEmVwmZDX70WYY1YMLB0ZQ7y2UuJA745uagveDd+79oXnogZPwgEaC5V72IGtFc530stvdbhIewArek7M6Y4rLskNzKntkE7r06GCVe6g3GPdbIf6osl9KEnxqLRsjESmUyL/KHyJBMpThKUJaSzjArYgXelByLxTcsU7iq4UurB0GRHuQ7mwkxKKTfYYJBFQ4CKiy0yTGDHwWBkmUy249F2nx5BMlB8NRUgCeBwD6V/thmNKmuzdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GdO3rPdlb8EFNfFy+do5y+79s97PNpR/Z4h8OJIgKOY=;
 b=U8px+dpZ1vNIBNIeKcZH3f8jqRc9BAvJpXfTyqlaCNPGo834eXd762GuS9knvCh0mPM/YVQl9SrFW+QMi/FCwHm09ZPMlZLqL7231rrwPLtmLXt4JZX4dL6U+Zhqp6kSh7xg0vRAmiRNKWjnWRO4kvODBe4JfmB6Ue+S2vvq66U03B3peONrYkMydIIKawiS0qJotDD8Nqnvcm9V5lMMCkm1Ke+2m1m0B/FUrCSzYBEoM3KNFhlg5EzdafIIAIXe849Y4cHq75S1cRK9Gc7ggQCwfTKIXD7pXmH7QaHbKXrOryaAa1TWv2fFOI+HhaGgOwW0bPoRkTqxi6lGB2cEOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GdO3rPdlb8EFNfFy+do5y+79s97PNpR/Z4h8OJIgKOY=;
 b=q7pgm604JEHrOGRZ0yw8J+AbPXLrD4/wBG6+zgm1UNnQBYpFvIyW43r3nCpYR2WObVoQ0vTV1BRblwjpIVtsOWnywc1GJkZIEfZlgE4LMrSMvs855c1DwUm20JJlsS/0HjYYEFRo1Av99Ne979WL4c2M5lNRaL71xrwzOLmHt92pp4Jsdq8lSJFp4MUN62RC8Yo+xmIB/rTEf7KFtrxTuyEV1gmGnSbJSQMDWZlRWY3L/ZfUXIB7Gru430TZGqmIap/td7lGq/ZcHNvGjbcKHvSXU1NuYxL2ROYFUC98oHRsUoMDwlcEBUPjW5Wtal+gnH3auTQRFeuxg6yM8cPh7g==
Received: from SJ0PR13CA0064.namprd13.prod.outlook.com (2603:10b6:a03:2c4::9)
 by PH7PR12MB9254.namprd12.prod.outlook.com (2603:10b6:510:308::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Tue, 22 Oct
 2024 14:51:42 +0000
Received: from SJ1PEPF000023D6.namprd21.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::d4) by SJ0PR13CA0064.outlook.office365.com
 (2603:10b6:a03:2c4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 14:51:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D6.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 14:51:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:26 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:20 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 4/8] selftests: net: lib: Move logging from forwarding/lib.sh here
Date: Tue, 22 Oct 2024 16:50:15 +0200
Message-ID: <4421094dd36be3714eeea70d577ff761454de3b3.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D6:EE_|PH7PR12MB9254:EE_
X-MS-Office365-Filtering-Correlation-Id: 79916a8d-d432-4916-7d05-08dcf2a90a9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XLWG1+5bM1Kbv/JczZRKV1FnE5x6FlbBUuq+aUDXVIRk3tBU/YqhjjaixGaw?=
 =?us-ascii?Q?W+k4M26/+IIQMhAWFEHgTIHm2gzVNkHMwbkiVUv3MjQaP4nzMszf+watxHMc?=
 =?us-ascii?Q?5gXDCjh+LV7eDiAW4XEU68M8ZWRvX9AUKvlljXcPOglEBYTNgtm9Pus1S933?=
 =?us-ascii?Q?iSGN+B7oX0bz8YTR3zt1mkgpJhoeXLWLP3vDwpV2oWjL1kHxdeK2RZI1+pZX?=
 =?us-ascii?Q?E0dC6GKyV1tNvcxQhkrnBYsqh7rRcDtW40V9pVrGJpY0UR3Idqid/AtSjeX1?=
 =?us-ascii?Q?KfFh5pHspeWyt0MIwP+AH4mJDv7yg3Lke8zqOwUJgcHxRxfKu1qNsg9WEcuv?=
 =?us-ascii?Q?Ujy/GfOXjkhySEQRqcS5BBKCux3Ds33dhHdZo9iWNI1dgmApf1i5v7SPma/g?=
 =?us-ascii?Q?QJy2+JD9ApjVFncMV8EDsEqdWSlBTUeCe5QQMq3s6XTromu9OjvcpUdMsPXL?=
 =?us-ascii?Q?3mvGV4qaWcd8gahx5TqVEGmaIhTP+s+mXjpUA48ckvf9b9PmkngJ9T835NDe?=
 =?us-ascii?Q?GbKgNMcojqZZK0z56/YS0I1q/BOUV2tCzcpwB+CzGojkjmTDbMKB7HsXGspI?=
 =?us-ascii?Q?DfREtrCtpgxgncagkc3+mRX4fIN9bANK1N4XE9lcdEyPxneLmcvKJW7YcK3M?=
 =?us-ascii?Q?YDZIxGxLDJKHNwyn/0uklygRC1nipgFqPh5ITxSlBjCl9XxyIcrHe3x+mPay?=
 =?us-ascii?Q?XUntGqxdMBNituKIeOQ5UohL2Buch0gN3Pps/8HwXVby9U7J/I/iXFhvrLtK?=
 =?us-ascii?Q?ujkXyZJTBtolgQLEqK8/rDlqNOdgrJgMHwP1osxe9c9BSA//yphqw2jDHk4z?=
 =?us-ascii?Q?z64EThfgMi5ewE2jindQ5iukn20sjJzvCXFwDJHv9piTE7zu1QUM+6pgkvVP?=
 =?us-ascii?Q?v2mmpmel78jAgftng/VsMxGyQXsMUuYXM5hNoT36FGc84pzBUgASpfTWZsb3?=
 =?us-ascii?Q?3T6kEZmcujcjgf+aKF+MCEQIMNd5KSoL7OWUQxGrEy+V7cjBvZbthnhSWzCL?=
 =?us-ascii?Q?IqUZGpKei+thE7Tp473d49ZfZDiLT/Em1UkaFWX4ZT7hy22YfT83CwAqlb25?=
 =?us-ascii?Q?qieWPn2fdANvnvui5qojz/aScDa0YgaXtlSR3mdhRNQ6Pq8oXVnvBJE9VSRW?=
 =?us-ascii?Q?KGcCdMiE9+lGgSS2r2yDLU5IOl/Ci/NZeNRR/6VVmQF1GIz3LLn+AgBGMr69?=
 =?us-ascii?Q?jGjlLZDzR7PB0kVjYj3wVcfK6xO/wBhxgJw19NCW+G3n8KmbbvpMPfTRkTzE?=
 =?us-ascii?Q?fX36me/JDR/SsnRcU+0E8pk9Cmc1pcFSKMoBuiUG7YRGwNDhMhnqR7V/q3kS?=
 =?us-ascii?Q?tIHGAFCOBepMPgYsOgjA7kTWUzR64lH0sYNVOMmGtqR3bLuTPC6/UrS84BV1?=
 =?us-ascii?Q?IVc0jAglywOLFR1fJk37Y90DPll7vUlF7Bs5uWVpkEK6DInUmw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:41.9940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79916a8d-d432-4916-7d05-08dcf2a90a9c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9254

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
---
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


