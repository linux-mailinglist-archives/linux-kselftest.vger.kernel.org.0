Return-Path: <linux-kselftest+bounces-20559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B44F89AECEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7413E283668
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F7B1F9431;
	Thu, 24 Oct 2024 16:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BTeoLZf+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC401F81B8;
	Thu, 24 Oct 2024 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789148; cv=fail; b=sfHHwXxGPh0BCZz6xyer3lkKqybsZ5QlEc8G5bLv6Ycqwm+OC7GUmDrMvK4RtGHMpd4K2UCq86TBcwtsKABguy4DTLgqHgPI1zy+BxuSVVw8oI4P85PrPFmll+xh4qP0q1IkpNMFxJcefV4+E0PMP0x9xg4OrUzshPOcq1tEctU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789148; c=relaxed/simple;
	bh=xxAdYsW3HOEs0Cml+QCp5VwfBEkfmFKsghgwW8Ivsm0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yrk8fqPNqHMA1d1q3z9ig4/ilhT054NJBGyYf+3LYyVZ+B2ZHIfNRjb2tFNcBJSbXCMzvllA7GHUFTeZFeurvMyJXWFPx2F3p0LOVqnigNMVbAxHrrXXjW0ecCLK40JWtceaPRSzcmoxRaDvUJLZyseYgE9op4CYian2K2HsJlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BTeoLZf+; arc=fail smtp.client-ip=40.107.92.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr1Ur7l4snzup+ox1pgZIWNFK2gNK7kTMX9qNUl+OU8h2RLQSRvklZi9L48qmubVwO6My+cwPA1YNMv89kLvXAd6gKJEIdnWvSU23R+lJpu6drREdm56/aRtuYk3+peezlkSxVqQwi2hBwQ9b6aTurgbsJHG2ekeHiCqkWGEYbGyOEk0tcwjjyTCoOgCwLq9FtMXfnvSA6GM/GQZEAWBAAVBUVHF56dLnAgDqzQKs65KVI9CtczFlQqTA5rlCk3wkXkZriiuCXdNxNZhQH5GhBcuLDOdCyi7YcLROnG8MxjMW9XD+Xp0GWORFvxrqBjBbOo7OqmJnMSohwxRBcc5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNQzkEYujqRiG0Ljs6B48BRVlLwKrxXSiws9RhvFwEo=;
 b=cQzhdR07PM8hyccU+kGcAahFXNRRpI66d1XRLHg9jZx8pVh57dvs2kXjU4Kb9gDf98JUEUFf5sSDlV9cSM6AJQBq3LZrr8uLx1K6SeSrezbHAzdsQO1rmXC24f567cdQG3tq1P2NCxbXOOP7DcmfhrFclv800ug6a72+pbMZk93PypgkbJgcxl8tBWUExqPHnks4kXDK9EpC3vXPieBjyQenht9S8/CJpHOLa4kABsGmFiEp/ENYuS+JBq8SUKymluZUpMS+dqLxOnG2xAivVdd/lTEC207zsBdzxL4XCyq+mhvOoV39cnMX/IRO0ga4c7wDoND1avEDhftM542EDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNQzkEYujqRiG0Ljs6B48BRVlLwKrxXSiws9RhvFwEo=;
 b=BTeoLZf+zsyh3kKr/saSrhKkx2VP/eh3oN6O106lEJM1FejUKPxgr8NDzi6BX85tYS9o7QeSTu2H79unXd8mxRJQT13tuZKkVh7nr7d1zXHTLU7c+vmk+lI6ED9LyWwd7+9KiGJ0FqBhRRlBKAMM4IT9eURHsn96nIWkSLm60hwoqXSrCaRsPjV76shGKmTamkPP7OY7uVVtRiITIHZVb7v+Pt0iM/tNAegPOHcwVs9OEZAkBHltulGLTGJlC9W6255vKZfIgtRuzf9nt7RLVUd70WTdSLrH2ytYA61G1E8Wyp7Kxnja19ffd5OlWRYs8knQ78Or60ON6vO/ygPXJw==
Received: from MW4PR04CA0124.namprd04.prod.outlook.com (2603:10b6:303:84::9)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 16:58:59 +0000
Received: from SJ1PEPF00002310.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::31) by MW4PR04CA0124.outlook.office365.com
 (2603:10b6:303:84::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002310.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:43 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:36 -0700
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
Subject: [PATCH net-next v2 6/8] selftests: net: lib: Move checks from forwarding/lib.sh here
Date: Thu, 24 Oct 2024 18:57:41 +0200
Message-ID: <6a29cda5dfe01a29673c300d01725ff93a4bea6d.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002310:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: 50d09751-d41c-491e-9150-08dcf44d24fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xNWKjSxDueE2fob8Z83MMvTH1LAMrr6L6P6qJGsFiZAlkUD8ttQXHGZBvXuw?=
 =?us-ascii?Q?nVBl8ssuD5youmIb/Hg+517HUrpv7KffRtu7cjPZ4mdPRIrpM/bJiN0lyVZ2?=
 =?us-ascii?Q?hDYbmI9HFLrBlGvt0wYBa5VwzcfwWC34+SdFXPy7Ud1+TBvxndijgp/iPf/M?=
 =?us-ascii?Q?EIkZJFaiDuOo0/6N9XM9oWaDrvi5SYoNQUIALjqEQ8UfQBMSUiYsKZn5N0HX?=
 =?us-ascii?Q?tr1YxkDVOuf28rhm5m6iSYKsOoTHshw6eO/3tCvx3+SjJaUmHHMRd0ZfT3hg?=
 =?us-ascii?Q?ho6WEG3+XrbUvnpiA7W5X8k6ze8XWoexzB5fvCUSvGQkYGxTXvaeAZFQ/A8S?=
 =?us-ascii?Q?iAcQU5GiBdwrAFovtuw5vE0lVmnERkrzPXj0y5lFJg3h0nX03x8pbhMTUq1a?=
 =?us-ascii?Q?PdPMuKE+0ar+ktPMo8yBLumZy+phvXcOzAOwKW0dpLw3eWyzRfCT45hpj9b8?=
 =?us-ascii?Q?cQv7kQ/J6L8GFuMKGfPAHVuRRe13CZS3BkHod+OrcGhBwll3elIq20/UCyUo?=
 =?us-ascii?Q?TdgGFXUXDxlW6dAEofalWWxsMPfTU9/nSI3AvgGoMY0YSH4XMspiM+Tn6e5F?=
 =?us-ascii?Q?NbU/1TptVDCfTUONFnGeRQb68fWTMU7fmfi83bTkdAspS26uJP+Oc9xpbO1q?=
 =?us-ascii?Q?2WiTNsOR1uplHAuA27ULuAQ65/4c7QETfsi0oUmTKPpcnpmVpV0B856R32Sg?=
 =?us-ascii?Q?WptYehR9eMSlrlZBD6N1EmvrtBu0sv8wRNGF1VpcKTHM+5xzHJEuvHh7NN9+?=
 =?us-ascii?Q?/80Spkf8qasWQNmmU7jnyrRjcilrRk5TEEyHYvVMqFUF94+STkKsLKBd+wdV?=
 =?us-ascii?Q?lC9Un7DmIhZq4btcBqATlJoMJ60tnqb4NhalSSBXSXh6q8Ii6NXvTLbIlZfq?=
 =?us-ascii?Q?aewAXQHzaBa8/2SCgt62otNfb8jGlGxJTw7e2xUrqb9BAkE4gpbEKpLWI/U3?=
 =?us-ascii?Q?vOK3i5JnHBVFCl8iRAtAYCBKmSE5EKL81Br4Ruyfr9lxaU15Dmt0rIbGEEHI?=
 =?us-ascii?Q?xxklEDBlSlSYPfGlFlaYzSf/JhlBQvxP1R19VCxWgm4ntsBjDYdSYXqNmZsr?=
 =?us-ascii?Q?Vjd6kE/el7sXBWV1KqhAHFzVrpmSd5S2iwT/ODA6SgkqLATMg9iHaNJnObvo?=
 =?us-ascii?Q?ezqTJbULFde0oHkIe8D4/cBHopGEWxqGRC1yNuQ2yN230u4Z1F3tMHJzhu5A?=
 =?us-ascii?Q?8DjFb89FcyTqGWG4U0akQaFxEqk2JPXdM6DbU1TvFWBoN8j7dJGsMnR64IRA?=
 =?us-ascii?Q?/PXj4n5oeMzHDsMBboY8ZMdC8P/3zOwNAGKYAhGG+hbmDAXQZlFe9JbnX4BN?=
 =?us-ascii?Q?dqy1CAyTN3dhMdMTO+w7wqbW1jBmmNdzH64z2SqB3qUnXTRjKVzRS0TOoYef?=
 =?us-ascii?Q?GpwEmnWbEQ6X+qWcknbihORzFufje2zOS2SFhqoxPdzCa0kTDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:54.9555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d09751-d41c-491e-9150-08dcf44d24fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002310.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

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
---

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


