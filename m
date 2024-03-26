Return-Path: <linux-kselftest+bounces-6646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393788CA11
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 18:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500B21C2A39F
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Mar 2024 17:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07941CA95;
	Tue, 26 Mar 2024 17:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VZuWkxe6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2071.outbound.protection.outlook.com [40.107.220.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429E13D60A;
	Tue, 26 Mar 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472491; cv=fail; b=FpwomCuI71mlhNoEyE65EI24/+tHNq86Y/nVE0tNY8AYxG4lFE+gXgItHWIhiov9F01TKVvOGhUy539cZh3qWA47cTjYzNdiOUXCP8z9L5i005ct/DZXK/afj+/6Xj9B91DxPLamYvJ4TmmFEX4LLKhKzyXyTMidKpeDt79L9SA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472491; c=relaxed/simple;
	bh=MMbyYpseX8cgtVXFVMcHJEGY4PLUs2oJ3WLF7aeLgwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oP67jAOOnz1dgkW6MBAnb27yU8tuXHmi+H+ejnLk+4cI9QLZRhpxLCUv8GoGigZfrYoEKTo2O31LkPPe9lLSv4W5Kh7Lq9wTSIZihF13Ef/8JiO9TiuOaggtychQ4ZOdioiqXxATwyYGNceTjZOWF/EczNR8u7zP6uldh5vL7SI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VZuWkxe6; arc=fail smtp.client-ip=40.107.220.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyODqOasLhf9jNdAs+YJvh0LsvRd2g1rUQaPkST+izgukiORiAIHov0DNPxdd++pkfATjTkDWJJi7v6Lh1IzxpKRVxmoliE1pkkW2hI+9f/lZ3EFiS30seJ5SVLZZclCsT5G5m9czDmuUYjJm/JqD8H/3AdI3/uCHGF3dD9jCCB3goxktBzgk+ob6+lrMAuQDae7EjbCc8GTMJLj84YWUelvUBYiKEL+wuSrUE4z6SWIscplVwssdPWT+VYhIpnaS+0/Ru5A3IUhTV2fzfqPHjWcWO2LiCnyteQ/Eu6f5G3uTP1FWVfeyPTQNeRGNXtwMvpo6xudnC+fldbe9LTypQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=us4RBSOFdP01athsgO43cz87CQIT044thZyXhZAmrS4=;
 b=NYzEo1oR8fp/bPSk3B/KnYvklNXoARuoBjriAQKCNU7PisEprbHnxwChby/eccmi4MQ4oZuEuhIX0V/4UhPpVAfvrfeuh8g1Ns4BEHwIH8QKkW/NMPfBwYWpQcQeXbS8cMguy0lBgyrnFQW7FjXavdmuKoujdzmJJhIAhbht6V2KHecQwbCvetJe84c4GdgsCzq/r6eV88fpSgB4zazx4uYzTw3YymIPtclIL7KCLGOjz+zAWZf6LNzMz44KPX9rY3tbObae+4nyT/6ndAclqPykw0KFT6v3/fomX4ja3ASRZn9uU/nxfudJZ7IZU5hGBnXGPlu/109rlrG0CP8MfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=us4RBSOFdP01athsgO43cz87CQIT044thZyXhZAmrS4=;
 b=VZuWkxe61h8BNenyNhQHJerS8PE28k+r3vShKYKsx3jp/GWXyKGE7xG8LtAV3sEdGK3yBSwrdtLCZGC+lx8WYIOypRNLGPC7Xf7vbb4py2I1Ni63N0D0vpAHvRhnLhs8jyjwNUeO4UZnOUoOj+eod6rzB4JaxV6t0Tn+u5uhRnUXPXdvf8nusRNZ/LMVpFXYaOFb4L68RRbbTyNd13W6UXTyEKAROfVoK9TnMvGXZIjymck9KmYLaFgK5kG7TeKEBIt4d2hskDD+0f7meifM/+NFIfRCCALqy7Jk/paSdq/aiORYnLQOp2vOXj7ta3CRJxqsLa6snSsWEPvPf2mdWg==
Received: from CH2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:610:50::35)
 by SJ0PR12MB5611.namprd12.prod.outlook.com (2603:10b6:a03:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 17:01:26 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::7d) by CH2PR16CA0025.outlook.office365.com
 (2603:10b6:610:50::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 26 Mar 2024 17:01:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 26 Mar 2024 17:01:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 26 Mar
 2024 10:01:01 -0700
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 26 Mar
 2024 10:00:55 -0700
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
Subject: [PATCH net-next 09/14] selftests: forwarding: Have RET track kselftest framework constants
Date: Tue, 26 Mar 2024 17:54:36 +0100
Message-ID: <7dfff51cc925c7a3ac879b9050a0d6a327c8d21f.1711464583.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ0PR12MB5611:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ebd1f6-d622-40dd-33a4-08dc4db65f28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tfbAjWqgniG0tRVpEGJMtFZ81wKNXRiim0nSLgt94+Ozo7435jkbVYIpJq+JFDvLiTbbF0rIs2pVBZg8hc9WPoWQGfB4Qx1VmI/LxFtM+hlwl79G3mmIjylzLR+npxlWJJGhoV4JO+jJa35sJ6HGCFMQI/Glebu9lc/r6qgrSPYGp00vDgWZ7zk/jbL0X7SwY5C2TFzezF1anKx2uc2thsnDX6uqpbuQzHa+OxHBK/Lqp/2NB18orUzYINbFRNbGkLqSi4ahzOeGavAdW97RQn9T+XQ6qEphaeDXzjpw/9AQqNMwfKnIt5CUgUKPU40v1EbKG//6zyuQ+FyNHmRleZaNTOXqjGqzse0FMzkxhyLS/cwbveoCSpmK0VkngCjBWrxk+PV3ckJkcXPil/SxDt1pbMbFb7wjA1pfDw5x1/1/HJGerr8vS3vILzh//BOMImz5I/3ezllQccXoMF0fPHUgJ0z9i/RkzfQHKyVxJXO2nLr65Mdxx11gXZa1B/JzJCXohaw2eKtDiY6/ysfkz4uUACsSEmMd5L5AcOE6ejer1EL8ufJ7zZp4YUjg1oWPfoZiM3fwguZ2wiyK2YG4jEAMUuHfsDPFGjEe39Zi/QI27bziemI2T+I1xCBKOyxcFDJmK698+9IPxHVpYzjfbovqz93Mat0TnlqO5ioEp2/EtnZxk7F89hTiIrYV+vBneX462cH+2yaEnLBj01kzEOZtLE8DQZNR+kEVOEgUkPO7NMnSPhV57IL+F3lK3pvl
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(7416005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 17:01:25.3909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ebd1f6-d622-40dd-33a4-08dc4db65f28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5611

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

Notes:
    v1:
    - Clarify intended usage by s/set_ret/ret_set_ksft_status/,
      s/nret/ksft_status/

 tools/testing/selftests/net/forwarding/lib.sh | 21 ++++++++-----
 tools/testing/selftests/net/lib.sh            | 30 +++++++++++++++++++
 2 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 5415b8d29862..ee8153651b38 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -396,14 +396,24 @@ EXIT_STATUS=0
 # Per-test return value. Clear at the beginning of each test.
 RET=0
 
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
 check_err()
 {
 	local err=$1
 	local msg=$2
 
-	if [[ $RET -eq 0 && $err -ne 0 ]]; then
-		RET=$err
-		retmsg=$msg
+	if ((err)); then
+		ret_set_ksft_status $ksft_fail "$msg"
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


