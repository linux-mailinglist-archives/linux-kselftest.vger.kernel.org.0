Return-Path: <linux-kselftest+bounces-35741-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1366AE7FD7
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 12:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07FE51631B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D275D28FAB3;
	Wed, 25 Jun 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qyruAED8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B419B1DE4E1;
	Wed, 25 Jun 2025 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848258; cv=fail; b=jfhlNdi2sliPPykUC6yUOP4nn9lY9rnR3Iug3faFrafjYyTdP0cCSPZRP0pTM94Aq+ZBKNkbJfWeYEkfYEn5LsUCT1eovyQapBZ9IJyXCAX2WWlOJoyorTi6nfmg3wzd3wmgMpEh3ncGdnQGBTjfj7br2dHlRigwyZwT6aGd3Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848258; c=relaxed/simple;
	bh=VnNcpTJxkZhROnjlXLvSyGzz3eV0W2PFYOXk6NUieZc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=icG2Jw8iAQadZq4P1HzrMXEEZ5eRuumnSygm7dDlbLbdOh/GU/577qoAJYX2MXm06+yYduV/yAbYBaSZ3DQbpH2ihqecb2km1koaY5oPJtE9Ku7oR02084YAFY9mpeNSfZ3Y3gZ/QZK+9UuMizhuLtWrBQPL0oQXKmvI5vbncPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qyruAED8; arc=fail smtp.client-ip=40.107.94.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C189PgKogqLQwcW+MCLExg08/8tN5vhURaAF+/GgrSCDdW48EJigNbE9APGPRU/mbl6QT1Pajt3T0NNMGudK179MexFVJsAA7R9QLoCeHVOHHddSbz2hnREPJr59mX8pLWM5+RwfB8AJCOPXOrv8a6ov/4uqK7iOSfsRTE8ZmN3xj/9ogN6evrf3HqWCUSSCzad2dZ1Y4UgTxHDP1UL6A0a7SaP92TQIzrB11mG6Abz+tQq238cn1mDqgQLmzNC19VwbJWqXe+wdEvnJBt9V2S5N4YYA434ji7BIcSdeQLFV+7RnVVSJPa/SLk1KiFn0qfqhKbbOOa7c67TIgd3hjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hf2rJ9DlL880BUa7+ekCcU/0IjRm0HSMqyilPSBGLuA=;
 b=E+hKM68bQGbbMaIlbjQW6vjyNXb9VwPQdBpzkjlL9Zl9rTIDnNSA/Eyq9OtFvFiIhH/9bcg0bV8Z4kaPuZlkTd8FoN9mLCifrZdnp7mkWZEBv7hLFzhwFmsMd8OCW3b6phZU1P/HATcAwaUKUcmZfxfGetsZJtpwgPmrQg3nPeYmCEicsYycN5DpV9DJ1TkqFdnpGIhd1C3c6URJJYrGFKml4Qi2ORwo+w70DmjjnPMsQ/PD3DLh5udOoCkbdiFmAWhitf//UMXEd2AVAw4A7xWTdAGwfSyozYTtECQDq3fA1J0D9BQHVXdSqpnvwOH6aWsZmrCuclFSr553o+fpow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hf2rJ9DlL880BUa7+ekCcU/0IjRm0HSMqyilPSBGLuA=;
 b=qyruAED8nbXc+IQ3IJ/FzAXrAKrXl7ws30v300EaRiG4u043R9eGAx4qnPeGavsnm7fadqOIKmipjHMKT48HdYvfAy2lR8R+/BkzjoU2LNy+IGaSZw0t7quIV6u2mF5AcnlO4y+Df2LIm9T94U0lMBi/CfKVY1tc8gC4UqBnexYxvoHZpqO6j2vBi7vWUie6pTrdZLgIC4TUqxsxKm3maWvYFw4igaqNC88VTNDHBF6M2zFR7qsH5ewM26Y7zo0lfY5eFOf5ExV90IhaSgdwjH7ttQU5BgAV2izvPrgsCjQys9kI21Mf3gEE8PeS0tyefZzETiCzlLgylv9xSS04Jg==
Received: from MN2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:208:23e::34)
 by PH8PR12MB8429.namprd12.prod.outlook.com (2603:10b6:510:258::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 25 Jun
 2025 10:44:10 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::e6) by MN2PR14CA0029.outlook.office365.com
 (2603:10b6:208:23e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Wed,
 25 Jun 2025 10:44:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 10:44:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 25 Jun
 2025 03:43:53 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 25 Jun
 2025 03:43:47 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>, Shuah Khan
	<shuah@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next] selftests: forwarding: lib: Split setup_wait()
Date: Wed, 25 Jun 2025 12:41:23 +0200
Message-ID: <8e13123236fe3912ae29bc04a1528bdd8551da1f.1750847794.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.49.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|PH8PR12MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: f54fe085-e7df-4b10-e79e-08ddb3d53743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jfcnJiYfg9BcxZorhN4F16R4b4R3KYoskKkVg6BOVK3tTQrqvP0nSI262ARB?=
 =?us-ascii?Q?EP7wHDkdiYBaNs2fGU7avZZKhqgOugblK167S/g8aMyhm1SgJF13xhRfmgSz?=
 =?us-ascii?Q?i/7nRsxbkBTFnQNuhJw1QyjadHcHBhURCmAxFjP+hnQPSd4HVF2rWtioiSQx?=
 =?us-ascii?Q?e78YbYSdnW5hBcNW49vJvofmXNlqM61bWx/V6ndE63gI8Cl7rIg/+vZF8g5I?=
 =?us-ascii?Q?BK+uQfos2PXOc4oplPZNIp5YIJ/xnqp/p7sCUCvLc/CdXJoGE/05nX9w42zc?=
 =?us-ascii?Q?PCwTLsFctfvIsrWgweRqtHSKvk4r7c6LvITMh1TWv0kUAmjq3yqQ1vQSobSP?=
 =?us-ascii?Q?VTCMwO7D1L9A5KV5BvyxIVW+M66oLw8y68QV3uL2vWoJJbuohwBksL2pOUfS?=
 =?us-ascii?Q?3MuvpUqnt3b1XT3mZcXHQdrVnz7q2JoFwuFrnA83nLxf0JjBWnkrIvcldG+r?=
 =?us-ascii?Q?LsxgPrS+tLLZ0IXhzl69bn4Ngxw9pzyBW1xJw4IL+z9rD0URkHqqxYegBcGK?=
 =?us-ascii?Q?i7jU3CrbruHiwc4TUOcdKvtnQaMZIpYgUXU5naFHSX5yvBPcxsjnMSWfJ3lF?=
 =?us-ascii?Q?/FzKYOfcDhJj8z5yd05lO/tBlQjGLyYnYC92OojS173goXYX6xVsWNuzYHbc?=
 =?us-ascii?Q?ypJyMMCL9H5EFEJbBVKAXg3KA/yGpMWsZ5QrkFAE4OY2nqmrBxV8abaQ8xt+?=
 =?us-ascii?Q?UwLZCPxCJY6PuFQUjumaCp8SF6jhsLdGMslGLSJtjKG/MJqlb1FOSM86cIXP?=
 =?us-ascii?Q?C9HRvkhSDjiP9mSb37cPOaFKYPqgN999t4hZS9edqo8x2U7Wz9rmaxmINpAp?=
 =?us-ascii?Q?ZjlNiGPM51rVx7uZD7afPT6b9MlspR2hBIgz10jw2MhsvuZQq4Ed+MVty1O1?=
 =?us-ascii?Q?NojfMHEj/bcSK6lDGrXL8iwlRx4kq4XJauKRkEQybZLLzM6ExUB3xunGMpbS?=
 =?us-ascii?Q?h0Rr3FyJVy4TrMrYmboQxT80JI31SqWPgjKX6UC0RGhxDYxHXYaMoFGmCbo0?=
 =?us-ascii?Q?rZiIatGdnXZrGQwd84Yp31APoSdn0t2XtT/4rwg9u5O9LuCaVoK9FBB4jPE6?=
 =?us-ascii?Q?2fhWUkcIIycnP8o3YARjdnCQI5L4cB/fLJSqvPz+d/lZYjuEjtbeY0QiH43A?=
 =?us-ascii?Q?jvEl5r+9qFr/D3sAb1wK9BEHT+g5U4lDGowmttcj0lL+iuwhGliOjKhavAtX?=
 =?us-ascii?Q?2BHRLjTP9SDK8oJ1W+oyzgol5C44fq9NX5PG+axZdCo3WoyH3brsE477vw+z?=
 =?us-ascii?Q?MwiNBspM6Ypxu1K0aOKiXis6UYjyal5dep6+9r9EfY2kavEN9sTGMqvSU7i6?=
 =?us-ascii?Q?uyy3LrmvJqU6H8Fs/awRbUG3F00rayMkOILYiU8/GeAzrCXFqWy9pcMHOXqB?=
 =?us-ascii?Q?M0vwMO2osV6E8iX4QdjT0TINRHQLge6RtS1e0UJFWCEvvB3M5Y5hYFnDlmby?=
 =?us-ascii?Q?FTgRicT2xOgbpsYPsSk1AVLWekjpd7iBuKOY5NlM4uZ8Kk+rmfnPhmWA2Wpn?=
 =?us-ascii?Q?qgyREPQf5qX4ZPZDy03afy4D0Mj8UGCOsJWO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 10:44:09.1209
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54fe085-e7df-4b10-e79e-08ddb3d53743
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8429

setup_wait() takes an optional argument and then is called from the top
level of the test script. That confuses shellcheck, which thinks that maybe
the intention is to pass $1 of the script to the function, which is never
the case. To avoid having to annotate every single new test with a SC
disable, split the function in two: one that takes a mandatory argument,
and one that takes no argument at all.

Convert the two existing users of that optional argument, both in Spectrum
resource selftest, to use the new form. Clean up vxlan_bridge_1q_mc_ul.sh
to not pass a now-unused argument.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: Matthieu Baerts <matttbe@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../drivers/net/mlxsw/spectrum-2/resource_scale.sh       | 2 +-
 .../drivers/net/mlxsw/spectrum/resource_scale.sh         | 2 +-
 tools/testing/selftests/net/forwarding/lib.sh            | 9 +++++++--
 .../selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh    | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
index 899b6892603f..d7505b933aef 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum-2/resource_scale.sh
@@ -51,7 +51,7 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 		fi
 
 		${current_test}_setup_prepare
-		setup_wait $num_netifs
+		setup_wait_n $num_netifs
 		# Update target in case occupancy of a certain resource changed
 		# following the test setup.
 		target=$(${current_test}_get_target "$should_fail")
diff --git a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
index 482ebb744eba..7b98cdd0580d 100755
--- a/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/spectrum/resource_scale.sh
@@ -55,7 +55,7 @@ for current_test in ${TESTS:-$ALL_TESTS}; do
 				continue
 			fi
 			${current_test}_setup_prepare
-			setup_wait $num_netifs
+			setup_wait_n $num_netifs
 			# Update target in case occupancy of a certain resource
 			# changed following the test setup.
 			target=$(${current_test}_get_target "$should_fail")
diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 83ee6a07e072..9308b2f77fed 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -526,9 +526,9 @@ setup_wait_dev_with_timeout()
 	return 1
 }
 
-setup_wait()
+setup_wait_n()
 {
-	local num_netifs=${1:-$NUM_NETIFS}
+	local num_netifs=$1; shift
 	local i
 
 	for ((i = 1; i <= num_netifs; ++i)); do
@@ -539,6 +539,11 @@ setup_wait()
 	sleep $WAIT_TIME
 }
 
+setup_wait()
+{
+	setup_wait_n "$NUM_NETIFS"
+}
+
 wait_for_dev()
 {
         local dev=$1; shift
diff --git a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
index 7ec58b6b1128..462db0b603e7 100755
--- a/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
+++ b/tools/testing/selftests/net/forwarding/vxlan_bridge_1q_mc_ul.sh
@@ -765,7 +765,7 @@ ipv6_mcroute_fdb_sep_rx()
 trap cleanup EXIT
 
 setup_prepare
-setup_wait "$NUM_NETIFS"
+setup_wait
 tests_run
 
 exit "$EXIT_STATUS"
-- 
2.49.0


