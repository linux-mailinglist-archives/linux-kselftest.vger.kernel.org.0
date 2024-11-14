Return-Path: <linux-kselftest+bounces-22027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C6B69C8C9F
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C76E288CE7
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 14:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839CD2E64A;
	Thu, 14 Nov 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YpxQmSqp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98EA4D8D0;
	Thu, 14 Nov 2024 14:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731593578; cv=fail; b=UDy4RlnleqogAdNMP5+5isGSF2wGiFPYNaLM35Th9oFakuYcWuWN0mkF8yKtPmLSCI8Lyj8BV6hk5YUGa8mfK2jWCNVMIm8PsFd5u6L59WurFidjMV9kWAL1HWOFFgwy+bn2RcuFPiWQkjswqNr9X9HVySgabi+Yd81/aUrYQxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731593578; c=relaxed/simple;
	bh=W1Jbsrl3SASOFhpOFkg6RFsRhT9Nixy5sz1Lwc1l+ZA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qaiU+r2PcSjMC3YHvcrIoLSXIjlgyHR/pu7iD1Y9G15kstMKOh6+xwDPwkxDENToIKCh8ojn3G3cMJfoxzYtrO0mVjfSGAqkyhnhFkpDH5MKEblNNnKYhb2ZZPmMGwuDS2+RxYspD2sIFgelhZIfazghoLsdnl8alpWmwSRaTIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YpxQmSqp; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fo5WyYkkbr2sU920WwPt2PW1cdP00HhaGyuYuXTaVMy+FCjgDb58ZIP0VrLwoOQ4ZBr51zzD0EWDHp5elxUyZxiBu9/tVaNR4qDiZnaiR6Nvg1EUk1DUf0382KswoU0JZPngM4LcwZukzXJAZvGLgEMBoZ1the0OxvhNuecgg7vcffDcuOR/LxEWUyNJBGhtTNscS6tGyazlGIKL6iIwvoyExgpU0klmdIBbkX0IiOKwVup+7ruAB0kOiwErtpNd0qDDGQlpBiCrbqNsTlWAVMJmvoJ8Sn/xVm1ROTcAX3B51oIqX3jEtpVozT1ge5H4SH6RJLXc0S8kNKdt69wLYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Ybb3cQn8Fb6xON+SG8hrDFabuFGISwWdDVgxn/JRk8=;
 b=h6BBCgyRVkDayrZFX3VU2r7U9FYSjk8Jq5kMshHpii13KMRSR2CpLDY1VCZzkABEAjjSSrGQbF6MHd/x3MoGKv1eIlMZTt3nf4jrm6J2ZDpX0mJKSV1980NUZSXWg9MZQ/gHKta+EuxMdbp6YLQkAT19m45hlqGBYZSx5QkNWP8IQ18cij2Cj5arFhhbwRs0367SYtFwhIgAcaNZCA/XRN5Y7PTTO44WXbJxCm1fcVQCkUszi3gKaPfdcUBt7SiR2pEuJa8hiuAU7QLSLSm2Jr5Ma6RkSo+13vI8fGDuYb/zEiyPvnaPneTUhxdlzQuxCmvvogGzgbeWoy0Sys/1ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Ybb3cQn8Fb6xON+SG8hrDFabuFGISwWdDVgxn/JRk8=;
 b=YpxQmSqp1YjeamBE0phAing11hmcD+WynBDvJXfHjufRWkOutbgHdfn/FV7VoY1Q2WTQyROuI9Wf6O8GtPbL1Idssf8xAKVSfanVswwGTNyqsmu0r1ifvdso3RehByjVQDgWC/6VMP5Fl3/DHNfTxWAinz4qSukitGwEMOt7ZyY6cBDx4LJwiRtcK2PyPgTXkTQjh+lsqPoM2Q/g/kZkcHFcZWy891BQ6+hPAWVaRSbVi++JkrdEGgNl0A0SzFYM1cfuCiSAjVmR4dkurQL/toAizyGR3sHvSBVuD1Bsif+DEqqwUbau9hu2PuphK0l/nuUHjdETQlKhKBv4oxScOg==
Received: from DS7PR03CA0208.namprd03.prod.outlook.com (2603:10b6:5:3b6::33)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 14:12:46 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::2b) by DS7PR03CA0208.outlook.office365.com
 (2603:10b6:5:3b6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Thu, 14 Nov 2024 14:12:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 14:12:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:30 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 06:12:22 -0800
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
Subject: [PATCH net-next v4 5/7] selftests: net: lib: Move checks from forwarding/lib.sh here
Date: Thu, 14 Nov 2024 15:09:57 +0100
Message-ID: <f488a00dc85b8e0c1f3c71476b32b21b5189a847.1731589511.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f78a25a-03fe-4574-32bc-08dd04b669ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K4Qchhjo2iBHDnwjHPHwvyLygw/RfmQ4C/sqqqO1qanV8cgXzz71KgCFgcgJ?=
 =?us-ascii?Q?CnD37Ul9UvmztCtqLesDTeqJ1210ho9INBGZmqEjOSBTq72MqLLR2dNAwbM5?=
 =?us-ascii?Q?fobun87WxFVgJebzqFovTY4zBeu/MX1GMO7vd0UTFFUBwNX5hkl+irbZFwXx?=
 =?us-ascii?Q?+1KroHNAfuj7CMZlD7PVMDMubrP/k7ROPsHMoNEn8CoxCMVFHkzwNSYFWMrT?=
 =?us-ascii?Q?r56XjxCY4/wtn/6LTziQwYV75oLOkLjQHXx/euft7P3ynziKmxNxezNGA0Hz?=
 =?us-ascii?Q?mj8rD+na9nEBvnQAtGmdq4+dqAWDs3UFAUUAy3kNYp6/MPNX6As/He2XXiPx?=
 =?us-ascii?Q?6oP9GAesJZtUt6cEEVfaOpvTMHlH+Vm5HF+x3od6YGqOiq/l8DfiFoS+eRIr?=
 =?us-ascii?Q?TAOjxjreiPKHiQZJuF3aYnMRt0ILWAHGS97bVgvflS66nw1NLtfly7KU5UBd?=
 =?us-ascii?Q?TJIrCL1acu9prkK6hnm20/aCViWh7r5sbjhMtFqCvtJ9DqLqKJf/d/JTD4mH?=
 =?us-ascii?Q?MW24Bha1VW3vKRXPNeJZoYlnj8V04xccH37fZhFkmqBxAIsfFMfZwHSuqviA?=
 =?us-ascii?Q?+2ehJQBiq7omFKStqlORaCphd30oekvQ96OkG/pvWOQycFqNAInYtYOmQaYO?=
 =?us-ascii?Q?rTkB8z2SXML42A4OTRHQRkITAx1NOvn1fQrN51r4BnMdbeWYUUpSdj8J4wuP?=
 =?us-ascii?Q?iHVjdDjGDfuUQ+rO+aZiauZNU8s1oM+ooPx4AtPxxLNPENv+b0Q/weJmCb14?=
 =?us-ascii?Q?E9SdgzBzesK6pwhhidbxTH/Rl9JOD3qQkky7Kre/2JxPFy+Rhhn/KwY4EvGx?=
 =?us-ascii?Q?FRCUgktXhTtPICs/iKoM0tDkRqSGo6hPEITbXbDySJT/BXJcXCfPqMHjx2ep?=
 =?us-ascii?Q?5mFlC8WJ0hRtBBIMQE4jD6iwFL/CohFY5E4NLOGyGihhqu0OJXLgotU9S3xi?=
 =?us-ascii?Q?eJg4/0kQGfsb2S8iNi2yXCi2wN9LprbFeOcWYtSXV4X4pe6sTqdzq6UF+FeB?=
 =?us-ascii?Q?sjWkVr7FS5i26NGdYwqljWLcPreGpwXc2aVoOOOuim0fNSuBkWo9CCMrMJXE?=
 =?us-ascii?Q?2pDRvigYb76QKdSWTFeGlqHTZo+i2VKVoOaAAOhAZvgnSP8Ug1/ZnfS2N5pE?=
 =?us-ascii?Q?fHyMX07Q+RmFRXtQlUpwl/n/DIkq0r/yOMBwrXRC/ZpZNljCEGw3cwnVFTsY?=
 =?us-ascii?Q?oNfAyariPxodbrmgfulIjIEuFqe+gJpZJwmLpN0QmLKRoSuWdf8bhc2zz/v3?=
 =?us-ascii?Q?EaGe/Zu9RZTyPTkdHqzeT7dBjXUEacLv9hVPhwzWCpuZkXY9ObzvjWOZqqzI?=
 =?us-ascii?Q?JOcJhqgZJ+I0V+/0ZWjByGccqtdnJtTd/718GiYuG1fE2/zZB+7WpGCqMKkT?=
 =?us-ascii?Q?iYUMykLy5WyrgBm3P82+r3xG+9/2qIUfh8S/VM81aA1Lx+oyuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 14:12:46.2587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f78a25a-03fe-4574-32bc-08dd04b669ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717

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


