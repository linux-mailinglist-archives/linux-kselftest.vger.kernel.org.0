Return-Path: <linux-kselftest+bounces-40796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8DB4440F
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 19:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B46F58121A
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Sep 2025 17:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF2430F817;
	Thu,  4 Sep 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="O6s9Ka9z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129F30F7E4;
	Thu,  4 Sep 2025 17:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005804; cv=fail; b=Undu3FBNCsD8eE16oSvE0esrFhEkoFWa0HGPprmdO94sgwHYEDUlFqzaC5BGiwF5uebW/JDl+dxGUOhCHC30MfzLV8//UgKZtoLKCj135fAIwaJpvkDKM152I1Cj+fSlZWdU9+sUWC92ZhqmeNTk82IIlBSBRXS8U0wQW3YqJRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005804; c=relaxed/simple;
	bh=LLpZPWchKO+ZWeM1bmw7h+RE6Ay2EiM4B2+Tmltb+Q4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q4PoCnfjbzRsj30Qum+zM7n7rYXDwaXtEK8gGXdUTBSNUJE1XzOQ8m8f68judqIB8O4re2ujNo90h/6sc2yHAqlj4HGxen2LcUKZYnQlPnFAlDHO5uHdCE9Gw3rsvQWXHuuRfTHrpESV2huvyzJcBNQGyzfddHSMPAN2rEVT5TI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=O6s9Ka9z; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z88tFbaUe3XrPjsZXcB4JpcPJPf/xWF9C9HeFXODazQqRCq3ZcohucuEwyPcVXxK3rhy1+EqdQjQTA2zJmtCSlk+y0SrGh3PjkmIUsfzVy1Yf6GJcHIpWHkZQd6/eBMLvpL40ugSWMvy9GG/Hz66SXJjGypfZrR/lydlM52eQk3t4gpeAoBqFtH9JoHCp7PsC3uGHkNI79gL8nSzeyhcv92MdqECWWf5ZKfbnUmTShv5+U1o04YEBVEAp4fWUdg383/W1NTte+1Qm0BAbqvtY443sRuhunWKmasMLYKlaXvGVLgZQjWkc8q1SyrlGQdRYNNB9RS3nxu/bfaOE06CrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBNf6qTvF1sYX18f67lPZpr+G9Rk4E9YJm2jFOzSz94=;
 b=KFyRo86XhNL1WP47gJefym2rguSAUwpxyDuASuuaTV4ekJ0B/DP9aydvOxP91FQHyTlP3QmjKe798sgGfKXUiySuDy8MEIMoksgBhDuqyljIm552JRQwpRE996POfepnJMBYc8dFvs4IVEnw/1ONrHqKqVe90uh5rR9sDno2suXrWAZrJl6l9D6N9jfPp179BfsTegt1ZmREw2i+ZjGqXc3B+uG5fT2RhzF5X0Kckh834A6gQWyAcXbyqE6mhAobfikSzd6Wjeh3iVlboehapv4+UCmPHXjSWWBGZV2yXfAAPI2XA4n8P2RkF3JGdYUlUKxuxP5ya0UvajlkQ2GCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBNf6qTvF1sYX18f67lPZpr+G9Rk4E9YJm2jFOzSz94=;
 b=O6s9Ka9z5HrVAL7AU/o/UGQ+JUgAOkqqvMiGBuBxGu9F3ZLVMHB6nmh9GREJsewyZblgTmUPml1/gWKLMx/pKsRe2PCTZyixy9/77ywyeexEER7ET8bkywDWdMB09KsSGY/ZIvp6csn7ybhU+xwq7VwTNWIvtwa+3GWeObQL0dcHyoaCG2Zl6vuNflD07VSPtwCpklaGrIotWKhDxukya3+0jZi3ZgQmsSm9jjsY7FytsFoOYZnNJ87izhxBxkYwZKiTyTlsD4q3VVVSfd05sCzkM1YNOvupc9YVFRvtCDBiN2TD8OBoeznJ5nXNhcWFn2Ie8o5eXBKHXBPe0HSWCA==
Received: from BN9PR03CA0358.namprd03.prod.outlook.com (2603:10b6:408:f6::33)
 by DM6PR12MB4284.namprd12.prod.outlook.com (2603:10b6:5:21a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Thu, 4 Sep
 2025 17:09:58 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com (2603:10b6:408:f6::4)
 by BN9PR03CA0358.outlook.office365.com (2603:10b6:408:f6::33) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17
 via Frontend Transport; Thu, 4 Sep 2025 17:09:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.14 via Frontend Transport; Thu, 4 Sep 2025 17:09:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 4 Sep
 2025 10:09:33 -0700
Received: from fedora.docsis.vodafone.cz (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 4 Sep 2025 10:09:28 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Simon Horman <horms@kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
	<bridge@lists.linux.dev>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 09/10] selftests: net: lib.sh: Don't defer failed commands
Date: Thu, 4 Sep 2025 19:07:26 +0200
Message-ID: <af10a5bb82ea11ead978cf903550089e006d7e70.1757004393.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|DM6PR12MB4284:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e09548-2d22-4307-fe6c-08ddebd5e06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrY5zFNRpzSFtM2KI42Y38HyrG5JkeaKLYEMjfJ53cMkTnYYPYqw9h3rdfgL?=
 =?us-ascii?Q?oglxynlaKgnHQbCIIqEhDVabhMMNLMoR7Ef/OvWa6CFUA5T16aPILB6bs70H?=
 =?us-ascii?Q?VewQ8CHKoqSs0xEAP97rvu7WP8CC7chkGWxeQKtoqP7n//9a/+zoiEMATRHc?=
 =?us-ascii?Q?uP58wOACYCh9fT20tZpSFybd329NQ3WEa3gio9Fv1F3kF97Ep4U1EdKIXSCB?=
 =?us-ascii?Q?dXVT4ZI1EDQUoYfPjBJqqL7y9Twvkltk/BM/oXbjOnLR8znhhIRhWREJAH+F?=
 =?us-ascii?Q?x+trlnVSNfbVDkl1YXtgkm8aSDDVJayhFzqE7LugFXruBsU22DUUz6uys22+?=
 =?us-ascii?Q?Wr7cNmLHYkkPRyLC/KbmQArUB9/K/2PZsGfs5/PgyyM9SNElykWBbp0Tp6Ld?=
 =?us-ascii?Q?/5TkDjvUTnRO+SFHoKFtC/WfrOvC6NxUzEcauiFILAguZJ3fFj2sMLXRr/9J?=
 =?us-ascii?Q?hnNFLkW+O7sMFIR6L/jMcjgT5qumm8IGWkt/AdPtekTUkpioC8XZW6sVzh5h?=
 =?us-ascii?Q?59cHMOROmSt/jGFwY5ryKFU4Xx2V37gSGuaP3z0Ryia+1pCgNEFPuzqMwFvD?=
 =?us-ascii?Q?gm95pLltPKf0FjZsnsIG2ndh5kmT2XrXG+3RtcqUejWMaVo0xeHGnXY/Gy0J?=
 =?us-ascii?Q?8j8roKzCvO3DL1S3cB/5K3qiIN6FlTEO+3FTfRC/41kWIeQ1m/JGYZutQux8?=
 =?us-ascii?Q?/HV/eoPrYBUGR46qki8rG+TOpPXOorP1gI4lg5yoGSA2URr6CMHZQKuhHm7e?=
 =?us-ascii?Q?tg4ddWERN/zOSNHR2fd5u17gc94QgXJ7xfv973m1XkEWsaeH2kvZh5rpw996?=
 =?us-ascii?Q?ByKEbaUMJG5IFoXEUu+GaJuL8mzo6Mt5d3vK1boIgYUiZpTabhVpbqThdgfh?=
 =?us-ascii?Q?KPIW6LJDwdWKGbKq2eoHyHmuwH0/IHyTBiL3yZUDAD5zQWW7UJFH3l4YLjtV?=
 =?us-ascii?Q?/CRpDTQxRGbZJr/xlUBP0yef2XsVXqjGR+k/nCt+D1ql0BOoYQrAi1NO3l7m?=
 =?us-ascii?Q?Ta55c9Rul3Jljf60Tmlj21iqRmyH9ec2eHcN8Fk/Pc/mLEODAYrv2sJJDRv1?=
 =?us-ascii?Q?a8lv6a9apXIgEwT62B6D7XtSZE+SlTeTdFuCbcooKkpfirTQ5Zo6IJwutPxu?=
 =?us-ascii?Q?O8tPLQoQMY6jtDn4P4Ghnmb3jxcr1JE9X9c5ZQFDiFBn0RhU54zeJO6kCpWD?=
 =?us-ascii?Q?tfZEZP6r3lXAm03YxMNBSJObIFB+MuID7TvnHWo3zTj2eLY4mwCfzxJ8Rri9?=
 =?us-ascii?Q?IfGZC12k5c8SoooN7Qj/n0kf63su4XVwzGwwrlGkeXClEaUCtIQSzzUEctaw?=
 =?us-ascii?Q?45flm/gtELETl3aYu1iM5ufSkurTFW9HgVlygKqjAqZuYsv5jhUUrEoNIuxs?=
 =?us-ascii?Q?cCTvCdLhyW6Zr3S/Dy9TeQ0dq0J6C/S7zZYezJgMwM4LBOZkMM4Ta26bsalZ?=
 =?us-ascii?Q?QlcyxwQq9/5Sc9YBnQ6YFDR22xIz7xlHKq5oGu8mr/+7CKSborF/ieaC34la?=
 =?us-ascii?Q?TWCQ3QXdhVXSNOPTwRSHyxQsogXghTieqGbC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 17:09:57.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e09548-2d22-4307-fe6c-08ddebd5e06e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4284

Usually the autodefer helpers in lib.sh are expected to be run in context
where success is the expected outcome. However when using them for feature
detection, failure can legitimately occur. But the failed command still
schedules a cleanup, which will likely fail again.

Instead, only schedule deferred cleanup when the positive command succeeds.

This way of organizing the cleanup has the added benefit that now the
return code from these functions reflects whether the command passed.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 tools/testing/selftests/net/lib.sh | 32 +++++++++++++++---------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index c7add0dc4c60..80cf1a75136c 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -547,8 +547,8 @@ ip_link_add()
 {
 	local name=$1; shift
 
-	ip link add name "$name" "$@"
-	defer ip link del dev "$name"
+	ip link add name "$name" "$@" && \
+		defer ip link del dev "$name"
 }
 
 ip_link_set_master()
@@ -556,8 +556,8 @@ ip_link_set_master()
 	local member=$1; shift
 	local master=$1; shift
 
-	ip link set dev "$member" master "$master"
-	defer ip link set dev "$member" nomaster
+	ip link set dev "$member" master "$master" && \
+		defer ip link set dev "$member" nomaster
 }
 
 ip_link_set_addr()
@@ -566,8 +566,8 @@ ip_link_set_addr()
 	local addr=$1; shift
 
 	local old_addr=$(mac_get "$name")
-	ip link set dev "$name" address "$addr"
-	defer ip link set dev "$name" address "$old_addr"
+	ip link set dev "$name" address "$addr" && \
+		defer ip link set dev "$name" address "$old_addr"
 }
 
 ip_link_has_flag()
@@ -590,8 +590,8 @@ ip_link_set_up()
 	local name=$1; shift
 
 	if ! ip_link_is_up "$name"; then
-		ip link set dev "$name" up
-		defer ip link set dev "$name" down
+		ip link set dev "$name" up && \
+			defer ip link set dev "$name" down
 	fi
 }
 
@@ -600,8 +600,8 @@ ip_link_set_down()
 	local name=$1; shift
 
 	if ip_link_is_up "$name"; then
-		ip link set dev "$name" down
-		defer ip link set dev "$name" up
+		ip link set dev "$name" down && \
+			defer ip link set dev "$name" up
 	fi
 }
 
@@ -609,20 +609,20 @@ ip_addr_add()
 {
 	local name=$1; shift
 
-	ip addr add dev "$name" "$@"
-	defer ip addr del dev "$name" "$@"
+	ip addr add dev "$name" "$@" && \
+		defer ip addr del dev "$name" "$@"
 }
 
 ip_route_add()
 {
-	ip route add "$@"
-	defer ip route del "$@"
+	ip route add "$@" && \
+		defer ip route del "$@"
 }
 
 bridge_vlan_add()
 {
-	bridge vlan add "$@"
-	defer bridge vlan del "$@"
+	bridge vlan add "$@" && \
+		defer bridge vlan del "$@"
 }
 
 wait_local_port_listen()
-- 
2.49.0


