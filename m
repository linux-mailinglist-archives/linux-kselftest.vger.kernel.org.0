Return-Path: <linux-kselftest+bounces-22025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FF29C8CB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9090FB32312
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD441A8E;
	Thu, 14 Nov 2024 14:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ilCLM2IG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963903BB48;
	Thu, 14 Nov 2024 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593557; cv=fail; b=T9sB39jj6SoehsPDB7X3lwaAITQ0pR7GYpW3Sre8w/xe0tbOKyjMM2GgHrHnYK0gTfyARKWoYdWtcbRHNm6HHDxBpjRA1DgRdBB1xOPVWKJrLSnnxYtEKKz8kpOr9MxmqTOCjoVF6hdlrBnzv6KMdv4KE+KKJWte8DmOPUUskbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593557; c=relaxed/simple;
	bh=3ZfWdtTvPyMpZTakc0Gwfzt/1QyfrPAAl7qK0gavtHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3HGDzm+7uvZ7B3YlmiM3Uj0I7Fb3LS/bexHcq28qo/jPkQedhKUenk0JGprCYlhQpC0/Ze40hZ8ElKpikW6dPi0q/wLBB0Lsk8dHqqsyDQV+HW+zcEv4sBO35BptpKdHsa2XP8fZFI2cRHkjtHYptgWo6A+pBumvnqx9mbY3iU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ilCLM2IG; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnayUW3KaKLvjGvFJb1/H7p8pqxwF0asZUFxMQzd5ohieE2jCvFyf5s/y97OL5ek0LoACwkJSTghxZZLwC3TYYpHbNQdYXrJhtCd5lhJqI5p7GPGXM51w0t3J8ZTNvLyrv6uMinMD1d9EHXc+BU6PjDTk/eLdclGlYfd3geq7YDXZWgb/erorjG3t58iOIOfhQrSPWhxTrgkF3BjketnbqgUTZJyegMswMdI+X3bi0faOABH3bWRnj817waLL+GQilXDi9mtWAvBrOZM8CAL48+nKckbcAhHLOrKvzZaMzV+sm3QZfqGA8zYNQBB2Qtc5xS+vcgpuL07rX2MgZCdOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD6zqn2kMbHyPquhEmL/7TNRjNgDHXSmBbaIweEFVMQ=;
 b=WjqxBuav7iolxupmAl1/CMiu0eMtXnb8yiqhBrcp2rfBrV/ESrOEcYKE72JLKszwYV7p69bPVOVFNVcu6PzKSfwI01ZfjkzGF/PIQnpZAJ0h3BQtkrJR3AyagvHi6pxzdGJLC7t/gSpTSigN5bg3lVm5cQDapyMvQTPgRbNlugmSY8VzqGWKL3tRVDMaQZXqPqnbCQxr+SVcugCuYIsp/afYH/+wW9dAqRvN5XaJ1BLiAPUPdJ8U3wLoPtZgr+VOGd4Otx173nX0uQGqNT1D3VT/dTjxQPvV51FUEIAcw42kBn3TCUEY0K1S7tMgP9ndkeqP0vTuMbiSpaPV5FQUeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD6zqn2kMbHyPquhEmL/7TNRjNgDHXSmBbaIweEFVMQ=;
 b=ilCLM2IG2Ex8MtkIclOiWRnPiggaEY47AuhVzh8T/XMBHAkjEazlPK4Og/l2+j7dN5mbOxEwGSiiv1I2sxqG1fDGtZX4DmVWYqR/pRop0/aFE59hYExoy872nqvl0PSwH0XRPuu2YII+yoSQTPEYMFibqkRGZpmm2oG66INrAcUbgwH1XvowXVzt3HBHRt3+ZsHnvTpyJFid5jmKd19uFo+4WkwgaRATbA6JPP3Rfo3a5TNPGGxCaM5ly1Bd7JptUyq/WHgD4HZKgQlW3vWA9tAYVamMOrS44nDWOxQkgpLETb7i+cw/m5v4PdfDSuQGduatuMurMg4t/1CSQrU+fQ==
Received: from CH0PR03CA0419.namprd03.prod.outlook.com (2603:10b6:610:11b::8)
 by DS7PR12MB6360.namprd12.prod.outlook.com (2603:10b6:8:93::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Thu, 14 Nov
 2024 14:12:28 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::18) by CH0PR03CA0419.outlook.office365.com
 (2603:10b6:610:11b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 14:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:12:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:15 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:07 -0800
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
Subject: [PATCH net-next v4 3/7] selftests: net: lib: Move logging from forwarding/lib.sh here
Date: Thu, 14 Nov 2024 15:09:55 +0100
Message-ID: <edd3785a3bd72ffbe1409300989e993ee50ae98b.1731589511.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1731589511.git.petrm@nvidia.com>
References: <cover.1731589511.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|DS7PR12MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 922090c6-875f-4347-97ea-08dd04b65f27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MX06NW8sL/QbtlzoyWXS8TYvYQ1cDGsJYqydXqB3juvZEV119Rd3iEqd0gC1?=
 =?us-ascii?Q?skc2vsyIVta/fJGFgKhiSQupkm1cc5JYK04by50J4mQkunSVEW3NvtLqi8CF?=
 =?us-ascii?Q?YUHSL3V5sAt0HbwMWPLUgNxbD+NLmByuqE6QVpNhWHI3o2sdn7Oe4e315zp1?=
 =?us-ascii?Q?GmT4GvNfowHd96oA47oE4dZuglkv/856CSbjPR8RIOsHBPzOKmb0UtMdKml0?=
 =?us-ascii?Q?SoIGEX9QpQ4/Rqao2kfdeEYYGkD1H8fRAe0nsuE5QfI/Pm10kUxApkq+idsA?=
 =?us-ascii?Q?EkwO2jPy33lVHgZ5l91ed0ER2cVFf4fVYeKbQBOu+bIrAttpejC6e/oxeSwv?=
 =?us-ascii?Q?LW01RvJ7mUB2zU5dyrpbUeiwWYIqcsaNtAZNs+fwHDnU5icZSIvQe6d7BnTx?=
 =?us-ascii?Q?VCKpKSWgXSajASlytcnOTtie45Dc+nH5RcXgF3XCv40ZpIF/fUWLbTwCpdsx?=
 =?us-ascii?Q?EtZbC/IaPFfnYIfsTbNnTx6e5IolQOIoIW+vV7JV7xONkG+pV6cTkOd8ezNB?=
 =?us-ascii?Q?vyBnMAq5uUdqn7oF7byagAXCFsS4V2TJhMYwwRdw7Cyo7uCbI0drStZbRzQu?=
 =?us-ascii?Q?wv4E/8lSK/jhYtcLBQ5HpRnJG1EEz0X1FzAiyfEr4HA66kK/KyPCcJaAclHb?=
 =?us-ascii?Q?nt/RCXwGGImcSUm+dV9RXxCte0H5NvW7pRIV5/NIW/33nw7hC+vTUDu3N9vv?=
 =?us-ascii?Q?D5hg4y/8WpXDaaDiYwaEzVxfp9hQnZaofBxEuj1kVxKIFU1H7CYNlZNDicir?=
 =?us-ascii?Q?gkE3G8bPotJZnuxwglTmjmF3HKGASaZtZkaiuiKNv2IQuf1vWMkIj2ehXtIc?=
 =?us-ascii?Q?9UQ8MKrRXhzCEO7uXze71B/sL5sfZ9gnjfCIkcL1y3KZKEdZlfGEZ1HVoW0U?=
 =?us-ascii?Q?OzjqT4BwFaPc0Q5Ke9JoSC1ggbFntZaBH7KlV5vtXf3TdcA7z4HnRBRZnxej?=
 =?us-ascii?Q?uMR7dTQOoy0xN7N5Z+a6gL3DFiYdLKytqUufxl1UIjfYsUKwV2fhGm86koj4?=
 =?us-ascii?Q?meLNkuH2/PrILmLqFunutphKdi32Mh/zhejiPumD4zEHZXqiRCTxr6Thsw9v?=
 =?us-ascii?Q?LkkQsN2Rsdab8eNycP6vin/h0ldNuzHC1OIvgM8WdF3kcSLD9n2h7OkQ7R5f?=
 =?us-ascii?Q?MCbWI46unnj/zjtPTQ1/Tqgc00YwymPL4LVr28TlHCxbfD9WPAPNKBltJKda?=
 =?us-ascii?Q?rFE9SdcUhxy0zX/jGgwyrl2Dr02Uh4CfPux23b8SgB9awTDRS0A+8PR+yYIn?=
 =?us-ascii?Q?bShfF44/Dvp/Bby5S7vlI3fJBcEQzik8f47AvMlWklwVulL75DPZSxuThwl/?=
 =?us-ascii?Q?UI3r65eRnPqGN2IGOcmbPPm4B6pg4rijDoZZ68b0Rt8xPvDl2Z5Pz6/UEs+Y?=
 =?us-ascii?Q?VNavypfd2iOtALUShf/IoX+c3XG6cKNn2JFTx/yEenpQBvAnbw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:12:28.2061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922090c6-875f-4347-97ea-08dd04b65f27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6360

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


