Return-Path: <linux-kselftest+bounces-6562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DEE88AD1F
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 19:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9923218FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Mar 2024 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1505C131E39;
	Mon, 25 Mar 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nnMsm4Ma"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619512C545
	for <linux-kselftest@vger.kernel.org>; Mon, 25 Mar 2024 17:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387993; cv=fail; b=pZNxFqbMqExOekWPgGR+2gn4bZjarLFGFjQ5hDr/8kAn7mQbDf8Jq3um+vMKyXSS4SCMzYKW+VTVqe0ULOwCpp4Q1HTbYX1U9KMryTl0+2WUnVgfqj8dVQcHegH5HYtycmvgWPfC2n8VanedSkf/odoszQdfWwC5IgMu3dcnXRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387993; c=relaxed/simple;
	bh=HdLBc7LTJzlez+0pU/02noPPYY1UjQ1+t4Q4/yvFYcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBd8x0WSUVgP2TSSkDwFyNuQKMzR1RAzihEDJUn5QZjeSTT2cQh9e/3QfxAGi1xf2TnVN/txcIvBLrKgEg56SEeEaT1bPP/s8bzPm5ozrVMp1NlylL1xUmxEfAEBLqSN9JibEEFxljlH6IunshqICH2MW0TamWYNTLf2lgA7SnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nnMsm4Ma; arc=fail smtp.client-ip=40.107.223.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRSoiJJXg16olACrrB3m/g9xQjdaftxnGNs4u4HX94VjKcUsW/ybJlr5gTu6AVyVOmBKi0E+k05IROOpiinA6s5CDTnRjIWy4DvYUumAqbLdHExWhCbaoTUXXkgU+t/7xTK5pDta1rhvTvbI/vd+toN9Po1VUaE+kzvyEuyj/hNuIOHGj7XBAKKsGB4KTTWQtZJ2rwgN9VaHFNGPEEILXNfPMF3BD+rxCuoIlTfY8thTd1QFLk7o4D77CRZTthbPfdtW0YCGZ2U9bBhguX4rOIggEn0Pll9b8O+vM7aL2z291c8FjLW1Jn1Yhe+D115AsSoyQL+pQXfIi+zVZOZQWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RrFesxMWCipUUd2qwALPiQvXKGIjqkZiMQWbB7nrhk=;
 b=mif2B3Imlp6GT2uJAf2zJABhEM0ITUxR2klhimqvlGqPB08kkFL1awyTPNtwQ0k3iEcrdrVVh9xkITA0L9dE4TPtZOywxTQSDXUhOYvTzJvwQMz7NEkr4rZ3HzXJQ1j5GKI5ONDu6zdWcxV11ZSLXxkOxMxFcZ+to/ZcpVHVSZlgRDfeOFtR/C70I52Tke8H8o2UYa7m+aM0+9cPqT3hqWZRnbutsumDQFf+XCJbuzd5siKhpyxd/ElBDgK7t3xXdq1EH0Y5Gla7Mmt5NjZ8zel0zOs/brH7mEFC1OfdI0WbBpy40gticdJmD77c0PpJvMqikCYKzVv5zmuDf/3wKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3RrFesxMWCipUUd2qwALPiQvXKGIjqkZiMQWbB7nrhk=;
 b=nnMsm4MapMvuEU5YtBV9flPDwGtbGeJT43FU4ZuWwtp1YEcPqG09xOzVjHpOU4oi2SoZ7/dZcyLljxKUD+N9e6lFHfCJOWrVvHmt1/SewmO3S68ERx1FeFeWNDR+MeCplT8K307rUNi+hFHOgGUjNiR+338D181ceSG39WWDsE9fR4XVnXVwEnl3h3dguwpiyw7wttvz3Y29hwMkyut0JONpMF4oJgChIGaQpz+SH0LJo6gLNyXYZEEZ8BFHbgakVGhxJSHRJURKrZSt557+rT7u1qAu/u9FZHrdLcv/QFCMw5rp/wlaXQpATytqso9xl/kR1wmv4svGmmDuJ6aO9w==
Received: from SJ0PR03CA0201.namprd03.prod.outlook.com (2603:10b6:a03:2ef::26)
 by PH8PR12MB7301.namprd12.prod.outlook.com (2603:10b6:510:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Mon, 25 Mar
 2024 17:33:07 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cf) by SJ0PR03CA0201.outlook.office365.com
 (2603:10b6:a03:2ef::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Mon, 25 Mar 2024 17:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 17:33:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Mar
 2024 10:32:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 25 Mar
 2024 10:32:42 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <nbu-linux-internal@nvidia.com>
CC: Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Benjamin Poirier <bpoirier@nvidia.com>, "Ido
 Schimmel" <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: [RFC PATCH net-next mlxsw 09/14] selftests: forwarding: Have RET track kselftest framework constants
Date: Mon, 25 Mar 2024 18:29:16 +0100
Message-ID: <fb7c72469b1d51556914b8a4ba3b7dd6e16815ec.1711385796.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711385795.git.petrm@nvidia.com>
References: <cover.1711385795.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|PH8PR12MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: cc865e05-495d-4879-d1e2-08dc4cf1a1e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u3GwReVuIj1qBvyrLHO43yGUcoeRhvSIil/I8BGII3KOn1+qjQjyKP/8qZpUDjf48L0W1YJwQvMEjm4BzX6mf/dFCqfr2/xpcO8btKZTyaG9Q+4t6S6nCcT6wESkVWoRxMGhd8iwRINHQtlIW6sX3WdZ0z//IEEeG6BhNvI4Y4yUeFAIz95LYevVaxb8yXog4p3392UqPHqRuP9BPlE6sBkixNgHAT0CYukSwPDk1gqC83BnvPjd1hV63S9nPT7hEK5mGb7pQ3kDOxPSa4hy0K6Z/VeZOn9R+94V0j9lFipgQW8ofT4kG9v3ZEzwsjHxkkzDP8pCIXPdE0O7DV1Dr7ueZcS2AzPCcxexHS7YI7NlZeXyxYvk6KdPHhfoULPzF48ui90wYU1XqK+BuqCAOUjqy27n5oELjLrEzgucq9SGo+23IH4kMh2XLIP1O/c1eT3lkZzKZRE24becH3lgrTfa92G1EhH5qmNXwmQFLjJpjgJcllNWlyJcpmSRJkwdpVwT3D8Yu0WGS042NwxMY3M0OnBYEPau5xM0VKbrY0ZgkxvZfQ0hfp35qDH49SzdXNVMVVzydK/EHpbgvbQJt1BZ1DihAKn1k9NhUGm7h+o0cu1KEZ5Tnn3DPK0v2TewOTuUa5HB2yyvTPQCtE03BTSn5fuMCm7LtSVRwekMOWc/BEIeYI3pYWH8WXuugCeX0wmBadhDNG+XRZd7krYtguBTEvnb9rl10uCEBcTmytoV2YE5PpqbRHSugOqqnvPO
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 17:33:06.6412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc865e05-495d-4879-d1e2-08dc4cf1a1e4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7301

The variable RET keeps track of whether the test under execution has so far
failed or not. Currently it works in binary fashion: zero means everything
is fine, non-zero means something failed. log_test() then uses the value to
given a human-readable message.

In order to allow log_test() to report skips and xfails, the semantics of
RET need to be more fine-grained. Therefore have RET value be one of
kselftest framework constants: $ksft_fail, $ksft_xfail, etc.

The current logic in check_err() is such that first non-zero value of RET
trumps all those that follow. But that is not right when RET has more
fine-grained value semantics. Different outcomes have different weights.

The results of PASS and XFAIL are mostly the same: they both communicate a
test that did not go wrong. SKIP communicates lack of tooling, which the
user should go and try to fix, and as such should not be overridden by the
passes. So far, the higher-numbered statuses can be considered weightier.
But FAIL should be the weightiest.

Add a helper, ksft_status_merge(), which merges two statuses in a way that
respects the above conditions. Express it in a generic manner, because exit
status merge is subtly different, and we want to reuse the same logic.

Use the new helper when setting RET in check_err().

Re-express check_fail() in terms of check_err() to avoid duplication.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 21 ++++++++-----
 tools/testing/selftests/net/lib.sh            | 30 +++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 5415b8d29862..e72b2370238c 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -396,14 +396,24 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
+set_ret()
+{
+	local nret=$1; shift
+	local msg=$1; shift
+
+	RET=$(ksft_status_merge $RET $nret)
+	if (( $? )); then
+		retmsg=$msg
+	fi
+}
+
 check_err()
 {
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -ne 0 ]]; then
-		RET=$err
-		retmsg=$msg
+	if ((err)); then
+		set_ret $ksft_fail "$msg"
 	fi
 }
 
@@ -412,10 +422,7 @@ check_fail()
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -eq 0 ]]; then
-		RET=1
-		retmsg=$msg
-	fi
+	check_err $((!err)) "$msg"
 }
 
 check_err_fail()
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index d9bdf6aa3bf1..88f6133ca319 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -19,6 +19,36 @@ NS_LIST=""
 
 ##############################################################################
 # Helpers
+
+__ksft_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+	local -A weights
+	local weight=0
+
+	for i in "$@"; do
+		weights[$i]=$((weight++))
+	done
+
+	if [[ ${weights[$a]} > ${weights[$b]} ]]; then
+		echo "$a"
+		return 0
+	else
+		echo "$b"
+		return 1
+	fi
+}
+
+ksft_status_merge()
+{
+	local a=$1; shift
+	local b=$1; shift
+
+	__ksft_status_merge "$a" "$b" \
+		$ksft_pass $ksft_xfail $ksft_skip $ksft_fail
+}
+
 busywait()
 {
 	local timeout=$1; shift
-- 
2.43.0


