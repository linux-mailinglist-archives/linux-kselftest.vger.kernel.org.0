Return-Path: <linux-kselftest+bounces-21791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB639C435A
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 18:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B060B22050
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271341A7045;
	Mon, 11 Nov 2024 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Sil2jZzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2711A4F1B;
	Mon, 11 Nov 2024 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731345127; cv=fail; b=uh/pQ8gNG0Bu53apISR1fyIVehDpxkW6r/6R6XswcvCG2JePia7i3iy6WW8lQot8ax/QTXqh+W0OiwkTX9c43H4CaYwPlEj2nvw2yJJ2YiB3738dMIX8Mir2Qjdi27i1GmTlgtL1X9QQ5NsoWF+GOOX2Z5Ov1n5TfLNg0UAZXRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731345127; c=relaxed/simple;
	bh=3ZfWdtTvPyMpZTakc0Gwfzt/1QyfrPAAl7qK0gavtHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cy/3vTZ1fLXa+ukbrVqw4wGHkE1EXIKPAGNVf0m9hSDkk0hdsnrL3om+KwvwrvofvNpGX1VIFNiuqMr03nzcvIOnxUtljvMI1uUXJ73ciEoScD0QIMW7/G5ltb2hImPDtyE9xlUJ9EI8lE4mzSnQXSLGJWR9eBJ5rW7IG5egJGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Sil2jZzf; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5ZzgbGLkHs7vj7hQjI/TUXgMXsu+vCtjwmjDTCb5mWuCFlVhSBEgVl+8N4D5AfIdJh+Dv19p9E+pXwYqaBpIBtw/Qi00QPH/SK6cfi0HVkK8m0bgPoVvWy4Ff4zFWfVpockPfscdovjaFN+VNUItqtx9a80oLN//Ho/WPjxMo1GbjO29LIv1tQL6wTWkTNcbNoSyvm+j6lHltKwYRt91zbYPjkrMk7OYgSCgzfJAg5JxMHUdpYUuR/rJgZIrJVOrfqiIob7ZwDBUrN7CwZEpdDj0bfk5lPb1dguBN93u8weK6xspUWWRGjbBoDk92MqXA+ltAFENMXQXfjNroVNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YD6zqn2kMbHyPquhEmL/7TNRjNgDHXSmBbaIweEFVMQ=;
 b=FVuqDmo1+q3xjgZnGMXvqcRyBwgsdwPZCMidFCe8yB+CBPfI0L2eMXL0u5t8Hky08ZoY5iKXvTzkA07NiraKDjJJ8JJmXzMXh0fSqSnHn6SFVe9EnBAvy7m3CXlHw4GViaq0XCaFpYNJC/cJxiV95RRRowhL2/1W5bRlEh+pI6I8IiR28LEWfJA4lJ2FLkYVj3m1JZIIynouDrWLl6Yub2nEFhL8NUtqYWiLM4t7u2AGGNVCW852o5ux6LM0GTsCVJn9V34CmU+yoZXRWTcEWbSLYul8o4rvVNlzaosZkwA+N91EJpYbosx4UeqPwSi9h3vn3E3xzj5+FgD7msBYnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YD6zqn2kMbHyPquhEmL/7TNRjNgDHXSmBbaIweEFVMQ=;
 b=Sil2jZzfo5mzQiD/XFER13qpc/CtTj0n41NC8dvHX7JcLuQ+lB0t22dPmG7K+pfCVBQmKH8CYuJ3EBmd7IXQeGPL5KMXn9w+drB0GTSktMHZmJLTAEsLl8/LPsjLWXqfdw3ysQl07gdX3oWCUnRbJOA0vH175RjaWsuEhVtBy+Sof29+0HnuY7RO+Mai+5v1z412Ml6K3kLtiFD2fiG27R5+OjGwUpUikQzhTLKIdwgAsn04FM4yFS3+zWbAt2b+R2AIOMAMVnraVr1b4lv842pBZyj5iIKJpVIbsndU1nMWyk1OE7X3U5g29/7qPAym+vpadDfULuHoofNGS0q1Pg==
Received: from BN0PR04CA0026.namprd04.prod.outlook.com (2603:10b6:408:ee::31)
 by SJ2PR12MB8977.namprd12.prod.outlook.com (2603:10b6:a03:539::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.26; Mon, 11 Nov
 2024 17:12:01 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:ee:cafe::5d) by BN0PR04CA0026.outlook.office365.com
 (2603:10b6:408:ee::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Mon, 11 Nov 2024 17:12:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Mon, 11 Nov 2024 17:11:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:43 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 11 Nov
 2024 09:11:36 -0800
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
Subject: [PATCH net-next v3 3/7] selftests: net: lib: Move logging from forwarding/lib.sh here
Date: Mon, 11 Nov 2024 18:08:57 +0100
Message-ID: <617f172428a18f697bfe8bebc01516a5b9f08a44.1731342342.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ2PR12MB8977:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f486c7-7329-4872-0c3e-08dd0273f44d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lXLnOY+0sZqOQKjJCY+Yhd2uhp63p6/LoJ6GTp2zv06nqp722mn6MQ0jD5k?=
 =?us-ascii?Q?praU1apaghn7O6FtfvZfS5Ey5Vl1EuAxWDvsyNqCAxRGxZ00swNXThJGyw3g?=
 =?us-ascii?Q?7jIrtYZbM9RzknsWKbB4OV6x82eizLsgzfBAQ6lWyj6Efjbt96FTw3aabTWx?=
 =?us-ascii?Q?X2Fq9IcXgylOQprsi7RNg9JZfAYzLSOsnvowZKNql5fvFNB7SwCHdtQTJWSp?=
 =?us-ascii?Q?akTYSZLIhP+mO6J6mfs7SDkLa3MATBuguJOONdGYlxx+jahlf4uLgo39qq1w?=
 =?us-ascii?Q?uXroG7tb6tsLG6A3ijvzuQ6Z47pqpnKR2qp8j8TxMOPZXF7EGAYxQUCPFuwz?=
 =?us-ascii?Q?vUc0vOrsSuZ83CRQzQUdTuJhSFPo2OP4nAWJiYCSC0Nx/7H8LORNN6O/Bvov?=
 =?us-ascii?Q?ymFT2yIO+NuNqKTpMdefdxR8/3KJ5vTPJLQhBTnuSv2MwX7nmUyPLgr5X9AH?=
 =?us-ascii?Q?kgPwApM6Lpu6WlEGZp2meLdtrHAF6ub83RNIntccJKsyUGsrDuPYHcWslfHT?=
 =?us-ascii?Q?maOVAqszwZUNYKlgz3crnC8dOEDdrsktNgQcKT10FYfY5Z5uC9ynokxy92h1?=
 =?us-ascii?Q?zWJEuFVfiSKhTU+SddTvqYZQrFaOZ+0oNrixax7eYxOdPkpJQUNvF6NtXgO6?=
 =?us-ascii?Q?j3Py7Fj0o8oifzBTw051nHkS154OdaEsDfyO4ABH7TEN0NOGPuk35cviM1QP?=
 =?us-ascii?Q?IyaYvF9+5ObRbqtsdjvcrIdyvV25q1jHnfmpvFsSRbXqmC0ap0x6SlR7tTO4?=
 =?us-ascii?Q?8W/0Wvg344LYM/vXKWJKpPjI5R5CrkJBeYvNAswuzW/yxUa/L6cI9cW6lcDR?=
 =?us-ascii?Q?jHPrfaXN8e0smf58xFtRg4KCUW3tRM+fJPl4O0vjgObysV02AtNT3U2CyYYd?=
 =?us-ascii?Q?0PlI/VZxH1hJN2qFD0lL0sxCDpjc/tnApizTbthcDx6ErJytebeNMWgiKgc3?=
 =?us-ascii?Q?t4ie6RAU01S8+c8zCvUsyv3jVIA72XYvwI5nh06oOxJEBPArB33wX7CEsh16?=
 =?us-ascii?Q?Oew7ZQRHoBpMUbUCCA8zkucJ4P85P2PIKwtE8PxsDuED7Lz32oXn9qbAEcTu?=
 =?us-ascii?Q?RrMWP7Vwbp95wNxTtSriLu0QbtA/RosW71IZDqKdUDk2qiIgg98OswPGMSnU?=
 =?us-ascii?Q?udluDReyrwCncbY4uSzjfCxio3yDDYp5PcU4qC1G5vZz6GPBJTWycb5D8lN9?=
 =?us-ascii?Q?kj0qd+DH6yIDVuIQ1/I//90xzxIqIgIJ3vch03Ij9E1Sf97hjzDxakklusnt?=
 =?us-ascii?Q?ONBF6osKyIi3Ho4tnYlLPrqQXLMl3lwBJJJPWI67WScdzK67aQdCDlB/BoV/?=
 =?us-ascii?Q?GS7dRad3La7k4u/3tj95pEo+6q0T3/YwiDoUMeKweeFG6DxuqKgFjTR05ZAN?=
 =?us-ascii?Q?rbrc9lLwaRjpUcBcOTtmUgcGlSZOj8Upr+R/bIH3BVjlNf6DcQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2024 17:11:59.7631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f486c7-7329-4872-0c3e-08dd0273f44d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8977

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


