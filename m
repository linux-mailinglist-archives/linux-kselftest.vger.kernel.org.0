Return-Path: <linux-kselftest+bounces-7835-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A048A3460
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 19:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79431F21DA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 17:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1A14C5BF;
	Fri, 12 Apr 2024 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="X1HSNeH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB0214D29B;
	Fri, 12 Apr 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712941573; cv=fail; b=Dd5MAzf+TLEZHSfKPDOnKC/Nz5EAVZLa5rNpcvlP163xkVUahM2aYcF4qF07KTHcGlKn82gKP8tpfL30MR9Eih+fK5f0p0GjPgfCGGTPW0MQod2f3FjhrY1iMSCG6yQ1rZGl+Ylv/KG878usfHW2t8iqnRJ2+7FrycLkdjKIglk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712941573; c=relaxed/simple;
	bh=8noxrdO3dZgEDc8nwQylBwHRzWz1t1GIEqsjg/VK2sI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8EMusBCHeguY4QuhGidr2NtzIEfPY33Y9mZ6sj3tQ6a424TIFgsnGlcJBdtiiASJJbj4HY9HjiSh3p0qUXXpJCKTc+t197G8XRX5pADhCPgstTyX6m2U4nU+B3k13oA3VftjRy9LWHRTW0Kh48G6gAw8egXKehj2RfaPYjjX3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=X1HSNeH3; arc=fail smtp.client-ip=40.107.223.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZfQRnFxtqB/ZijjljwWMtfV/YewEsYEzIhvva+bJWUhHh3gOSOws3b0c4ZbuV8NfftjYDSTGKrjeRy4+l4abA2ptQXGjPsrKmbY6oXYgfiWILdCH8jSkSGJqRdZJEyF/Sv4H13rsxFRnxbMduAiqfNzA8w4Ww9M60uD8g1cWDAd/oaSNpCeQvODufoN2jR9LEwP5P0fEbMb6DeyL+YuIBXBbd+AQFbRUOuZrp/V5Jceekg3LfsQc8FTF3XlsC1UHjtF616wI0JdlPWTPgPc+u/Ct3dG8j0wBxphNCoZLU4vym4ZfEhcxHoTlKBV0chre8onGxTdMYVmQnTqztTz9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YT1SM2kxVq74dq4TOCc/zcAFTStTs0y0dF0oPxjr1QI=;
 b=SabFwGQ5aBbfBGrV+eCCpJ1jTxoE1+p1BuFONJzHxnaatR7QGr51Yezpy2fYFZPjYZaUPx6mLVu9L+ilDnkUBxo9AxRkP2WhnBn29KhDfc37BBR9KPe+GI2B4hbrjJXFuHZxAflfVWg2nshgoLwNG4aPQeabW5gHiRST1yfKX+Hz32Tz0x2PsuTcJ8BeKIdT4ZA5QU3dfR+edgL4V8EEtIi0tPsfRci1lcMI2e2MBUYMBway7O2XaSm/MgRNkn7vgSfYBP0XElQ4gfiQzlI6ZdeLlijPLQ//E9d0nUXTKVM2aq0bhKQJLj3aOD9/pXsDe2NZadgR3qEG0lzFJDsgyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YT1SM2kxVq74dq4TOCc/zcAFTStTs0y0dF0oPxjr1QI=;
 b=X1HSNeH3lb+HevWvXK38Yu1Um9dHIZuPENFX60U85Qn0Aw485TGdtQHw0rSpeOqWl0zpYWkoeADG/7Hi0D0E5tkPEb+rCRMf4gBiK9/d6Y6NF3B+ZvLbei3y9r3CdSju9BeXKc/2g7AcQhPgPzNl6uVqyfSZqeBJIr++7ltquvX8qOw7CFQ3l7ulSaLAgCx4YTBE3e3z5PkuOCLb9pdq5nTt70nXoUUPwWQdaE18JYaSE1OmLXVHjxnrnzB/B1ELHlKA7m53V2hYgYeoAmt8LCAQGygtPPrnTVzRQITziODtip/neXPhkLbrEu8MtPyhF4rpSR3iG6GIXYTLjBi/9g==
Received: from MW4PR04CA0102.namprd04.prod.outlook.com (2603:10b6:303:83::17)
 by MN0PR12MB6342.namprd12.prod.outlook.com (2603:10b6:208:3c1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 17:06:07 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:83:cafe::35) by MW4PR04CA0102.outlook.office365.com
 (2603:10b6:303:83::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Fri, 12 Apr 2024 17:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Fri, 12 Apr 2024 17:06:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 10:05:38 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 10:05:33 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Benjamin Poirier
	<bpoirier@nvidia.com>
Subject: [PATCH net-next 01/10] selftests: net: Unify code of busywait() and slowwait()
Date: Fri, 12 Apr 2024 19:03:04 +0200
Message-ID: <db8b8885e254893bba61d824d7cf2a6774dcb336.1712940759.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712940759.git.petrm@nvidia.com>
References: <cover.1712940759.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|MN0PR12MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5c886c-6422-4e96-a4b7-08dc5b12d7f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+bwK+jM1rn0PLhYFokGKGaJ1ry/z0kBw/6nqKNTVfevsL1V70Rkb9BgKUMzW6p2uCHx8YzD6PwHqfvJlk3fthWrVRM/PXm9BJY9E6mfI7acg/7ihFVRhDqCHidkVAWMlbjjcjcpBr3qYoNbbSJcKxuvBOkVqnLMyadmI0WZp04RzsfMv0rTVWodFQ9fPcADNl5tA8/cS7HSnPj6SocbC8fWzp+n2nzD29+3n+693HVqkIJ0zCf6OMpoK4nd5Xp+ePw9b0ZcSdcshVV8Wnckj43kThXABQ49RAvmg2jGCjjCbsQxHLDP4NDpLG99IQHjLKL/FfeNCZn2dVc6a9oggqrVgA0fQHtm1KM4+KktcvdEprHl1YZ9+7VLBkOiNBNJ62yZLq8w4rXU7bUW4XPg3axqXcqOQXy5ykOxBS4Vms+sqQCIdKkpqFrKaK6iABxKkgjbc0MqBrUMF49tRxwX6GlKHghLTzpqAoLmQQNEqNPUVAbYQnvt+IEWRZt+WIyr9FwdoCI/PFG6eIkN4GpZeLLijdTW25k6veq7O9nyQdHD8/zhhwpEMSMuCyp4gRKee1uG5ifLRr2DL+U4DUaJYz7kMZ5ZaBIYHrC59F+shfIuR+W+t9pmkODfBv8cET7Z8BkJzvo74rxdBMJ98xPAYP8cvCAPjIBr9W0H85bVUfyax7SLxmDZ2r0XRCan1zTtUpJ05QsNTwtc9Uc0jQc39rz9ba/hDA0GJPAVshFU96EOqUOQ2RFLO4kEhuQP9inf1
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 17:06:06.9075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5c886c-6422-4e96-a4b7-08dc5b12d7f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6342

Bodies of busywait() and slowwait() functions are almost identical. Extract
the common code into a helper, loopy_wait, and convert busywait() and
slowwait() into trivial wrappers.

Moreover, the fact that slowwait() uses seconds for units is really not
intuitive, and the comment does not help much. Instead make the unit part
of the name of the argument to further clarify what units are expected.

Cc: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
---
 tools/testing/selftests/net/forwarding/lib.sh | 22 ++-----------------
 tools/testing/selftests/net/lib.sh            | 16 +++++++++++---
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 4103ed7afcde..658e4e7bf4b9 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -95,27 +95,9 @@ source "$net_forwarding_dir/../lib.sh"
 # timeout in seconds
 slowwait()
 {
-	local timeout=$1; shift
+	local timeout_sec=$1; shift
 
-	local start_time="$(date -u +%s)"
-	while true
-	do
-		local out
-		out=$("$@")
-		local ret=$?
-		if ((!ret)); then
-			echo -n "$out"
-			return 0
-		fi
-
-		local current_time="$(date -u +%s)"
-		if ((current_time - start_time > timeout)); then
-			echo -n "$out"
-			return 1
-		fi
-
-		sleep 0.1
-	done
+	loopy_wait "sleep 0.1" "$((timeout_sec * 1000))" "$@"
 }
 
 ##############################################################################
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index b7f7b8695165..c868c0aec121 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -58,9 +58,10 @@ ksft_exit_status_merge()
 		$ksft_xfail $ksft_pass $ksft_skip $ksft_fail
 }
 
-busywait()
+loopy_wait()
 {
-	local timeout=$1; shift
+	local sleep_cmd=$1; shift
+	local timeout_ms=$1; shift
 
 	local start_time="$(date -u +%s%3N)"
 	while true
@@ -74,13 +75,22 @@ busywait()
 		fi
 
 		local current_time="$(date -u +%s%3N)"
-		if ((current_time - start_time > timeout)); then
+		if ((current_time - start_time > timeout_ms)); then
 			echo -n "$out"
 			return 1
 		fi
+
+		$sleep_cmd
 	done
 }
 
+busywait()
+{
+	local timeout_ms=$1; shift
+
+	loopy_wait : "$timeout_ms" "$@"
+}
+
 cleanup_ns()
 {
 	local ns=""
-- 
2.43.0


