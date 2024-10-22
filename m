Return-Path: <linux-kselftest+bounces-20399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F09AB179
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEB901C22450
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497801A262D;
	Tue, 22 Oct 2024 14:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cbyu1Q0w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F2F19EED4;
	Tue, 22 Oct 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608740; cv=fail; b=OeBa+Zs9aUinK0Hp5wVS1o62fkUYO/xRagq/+5XU2/RQrYuSgqjE0VkFGhon1m4LKzqpCbOibxA6E8LUtLOFXEVf70LAHd4XXcxhz9FiLZO+hnxu+SLkiFY7v2p6xJwlydKyXtdKXIqep1rr4p5+QK37hBZ2ciT0CjFVU6TWeJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608740; c=relaxed/simple;
	bh=UJmnmlTfL7DKpX0epTT+DWDmctUFH/S0+XoPbo1yvgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sYEEK3d4K/BGs0hxpj8n2TT0vCGuoRa/CqKqXuFUpeYcoB2B9suH1Xt2liuSWSTIDRAEFrxGZixyciwAXJywF4fI26108TKdnzTC4bMKFTPVy1HKTc+gynr3N1Zb76PKAMvY68ftyH56YXa/lvlOssIIsWslB20s20SGxERcTuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cbyu1Q0w; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUliAKWwWB+Ewv5+Ld/PyhyJ2qxAGOliH3vgGKt2NXk/AqDv+25zc7OII1Xty9Fc1mHnEeA7hpxHPOPSfMXoMWyB7h66kGY4dvBgnKpSy0AAQwA+WPJlsYgaBTfaZeLN8+DDf7p3eh/gOMa40M6SiG+tnJfzDEE2geHnASMAA1Hqu74OJrumN3MrSsohZ8qRj/7xJgG7FZSo5n5bOrDz9zQPJx+Apg/BiIyUnyt/9HxpY0BRKuLNTDff/6elGrtaDXXSBYSacgRSgR7ZEXi+ikk/S00CnUNEYm74s/aUcitfkY+X4mms3Sh89yUXDnZSXU+7Pjiqx/UE8o7SHxbUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6xOfbvduhWp3r2ZbJXG/bT3O79FynaTkLVDmv++o1M=;
 b=rtqyWAGJCjZRZvvolxn649cqsUc9TfwcW/QJHl8buanID2zu5Z1665oBe+ZXA19t549AogMSd/fgrLKmP6piWoYIIrMlGhegyEw+ZmHlWCt9pkf9yc8u/rWhKgmK+bQ7Sdj7KBxlOKA/UsyUDXAghJH0OgIl09s4BXHqwMSq1A3VR+5hTtrd4n05Yk6QdKktKgkzaG02HOLv0op97fWDfu8wGOAVN69XYGE4qgTJx+7bt0lIcwSAyEaqAe8qhSMopsXH1zjV/pwCeEWJTkmbQDSlrU/3vIBxsLKIedcaMjtz8QtW0HFT5yRJQDB7X4I5+MOPANXHnVP3uhNsPu39JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6xOfbvduhWp3r2ZbJXG/bT3O79FynaTkLVDmv++o1M=;
 b=Cbyu1Q0wDdqC2ex7svnLpEno7ExPUKU8WtCKuucqNqTH8HAskUOAJ/4HO2cZdxe0BNx4Y5q8FmPkrhw4VB64rNAzz00f3CFlzS7TNvjxolSGtLjhnTBhh4ldclx/NeqrhIQW5OsEhFlY5ySJTc8MgkeKaHsfiZGls65QhrC/S9smYNZ4hMtYxdVbYG0fwpCk696RbDsP+jd8eo6s7ts/YxnOnhp32A31XUh0jkpBzT5/tga4EKqLdxsvMXLyix9FCs4zfe0tAluonSG73K5SHLIJLgoa9AsGJbQ7rnZpRcum7yIusRtUhjXYPuuFjw5bPLrVVxJJWMpNFND45cC+LQ==
Received: from CH0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:610:11a::13)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 14:51:59 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::27) by CH0PR03CA0351.outlook.office365.com
 (2603:10b6:610:11a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 14:51:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Tue, 22 Oct 2024 14:51:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:39 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>, Benjamin Poirier
	<bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>,
	<linux-kselftest@vger.kernel.org>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net-next 6/8] selftests: net: lib: Move checks from forwarding/lib.sh here
Date: Tue, 22 Oct 2024 16:50:17 +0200
Message-ID: <6e337cad958bf489d0dba5446cc01e90d2d9ac02.1729607879.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: bb211a50-7efb-4dcb-8300-08dcf2a914a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?syduBq444RUWzg/IHfaiiy5ukLEKEQG0Lz0+MpwnB2lLcGi7JyIOEh/MN+4P?=
 =?us-ascii?Q?X/sv4AQPbYBVycIBx6nn4BmQ4YstOKZVV+79Ie0zSYlJgNiPiI2iISPMgLAI?=
 =?us-ascii?Q?eviINTqsJN1WmzAVohCkHOlWMySBGBebsVaHOxc6KvbpeyjX4OWzNhbAFILj?=
 =?us-ascii?Q?ZWxgIcFWhSQFb6UJNJzRxWHDVd9r5+5kUR9ALqjHOgkW2jALVK1B1Jok7vsc?=
 =?us-ascii?Q?O9i6LcBQZUVRCAoWUc1z54KeoVD6hKDRA/K2il4zFeiV07qRn/ZPzehPbAa9?=
 =?us-ascii?Q?a3rnCzsneE3cSSUksFhZE4rbeenqoz1ov7b/h9whHuS0Ez8/x2Hm/2NoFD5g?=
 =?us-ascii?Q?pMWi0uarP0EH/9ricezNusEMrzcu245/e1EemvAhfE4rthU2DHwO6GX1baK/?=
 =?us-ascii?Q?gP1Jn+XZ+QrLviZtQex11wRJFNtIbwIpQDAw5b9CfmGqttGxXiY/iVL+J/zI?=
 =?us-ascii?Q?JSUQRGHuK3gJChBgnIa1ZbZI5hv9hECDqyVdkHbMIjtG+3hCxgyIi2WXq0XR?=
 =?us-ascii?Q?B+0vpHc2G++lYKU1FI5xDHFZjzrJqyc0GfFJ3WWFfvDsiF/3m/tDhw+C2OP7?=
 =?us-ascii?Q?jmFBWPrgUzjJWLi0zZpkdnGud2Gy2jmMU3jw6gAAj3vD9D98/S1vptMDRH7o?=
 =?us-ascii?Q?z3vw7ER/r4OFE6mznu6jcQkNwr4Rp30VpYb0DjgsPCPd3LNejjd1PPYhYGw6?=
 =?us-ascii?Q?B24zQ78PjShooKC5pqkKX5EFz/VGYdi3BEwfJabfc78rTJrCVPW6NlurlCw3?=
 =?us-ascii?Q?D1vJkSOt6PaCwXVufeK3gQpCS3wmO5S5CrHq+6bvSsrSoIrUGASAyBzADPTT?=
 =?us-ascii?Q?bxG4Q1hZZMxKbc/Zu/TJ+XlPmctxrwBzOFoood2gy6lEFofBV2xb38lUvgIq?=
 =?us-ascii?Q?QiJxH0WVzhaDQTF0t6XC24Y0eWc/vQZUuOwgjDL7SMVp8p/1pgAf/X41a+m7?=
 =?us-ascii?Q?GvIw4sD6n+pKeoHDW1uB3Ue7UnF7JuIjkX26y3q95USEKt5jMMSdfzEzoWa8?=
 =?us-ascii?Q?3BtJhd7SOjXl6DOo8dlFb6Vg0mhflfyG23OobFKUsZQk7xfu+kejbCAxsW8C?=
 =?us-ascii?Q?gnoMZRK2ogQaNzG0ISktIv74TEtstohEbRFO7km2isHyUBbaKgSR6LF9DQWX?=
 =?us-ascii?Q?okOxKJsYliliY977Z6AuoTAKTQXRnH3AWyfVuDLUXZhntPKSnATCe2RNxv20?=
 =?us-ascii?Q?ijhyqmaclB7HAJbcd/HfCckj4cYq8bxmcOEK0q7SDtjqFOAHXX3xJ9eSfo9Z?=
 =?us-ascii?Q?qFC77MfEb0b2L2DSKGSKpS1EeVSN3FLIXdUFqhr2KbEv4Cl2UJFYifAw8nHb?=
 =?us-ascii?Q?d6FctgwR2Q6ZldSQOPAwZRh8k861n01HalAVXCX4jkJIPX8GDhAcUOI0taKS?=
 =?us-ascii?Q?MTVlypjXqnN7V8VDnPzi/M0v9VQYKC4P6cOAsdkOYl9h6oaRfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:58.8188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb211a50-7efb-4dcb-8300-08dcf2a914a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688

For logging to be useful, something has to set RET and retmsg by calling
ret_set_ksft_status(). There is a suite of functions to that end in
forwarding/lib: check_err, check_fail et.al. Move them to net/lib.sh so
that every net test can use them.

Existing lib.sh users might be using these same names for their functions.
However lib.sh is always sourced near the top of the file (checked), and
whatever new definitions will simply override the ones provided by lib.sh.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
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


