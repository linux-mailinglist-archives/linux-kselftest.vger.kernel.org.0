Return-Path: <linux-kselftest+bounces-20558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9329AECEA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 18:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CA9B20E6F
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 16:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 255811F9ECF;
	Thu, 24 Oct 2024 16:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JlqQ0neT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0257D1F81AF;
	Thu, 24 Oct 2024 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789137; cv=fail; b=olsD9UUXzzMDTptmxrnxhcNrKxmJgKVRjv1m7hsbCq1m3TeADkxg5jinSAfGMCEB7d9PC5/cdtqGGy1ZmrL2lIk4b5PPr+ItuL68PGNkG/DR+8k3P+6OFiQAyNXDy32z2U+VFXXd160Prl7nbHbLeqeNaDxbj+zDoSYUyxHtJBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789137; c=relaxed/simple;
	bh=Cx1KZ+eM+5wKNXtVq3x7VyerLK4E5Jp9hqU0zwPDRaM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WldwG3Pucfn/NHtvRRFZLvMS0wJ9hHoHxJX9EDGa6a+K3LBYhhqeuAhaL2+vDlyc7j2hERglObf//etVwzvGlneqpD5R35ONsSJdJT/cW1U0n5DAy2b9j6xnSOMCl0hxPq3OTblB6gmWusIsnzdqM8aKMyWDgPP+FDhyjWBkEw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JlqQ0neT; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMp3ejDsB3bB3d2CCZiCdKpdQ41lv5SJcIAnnN49o0Eck0e30Bh1w473Jr5Cuapb0UZYt3fsLYnLYft1A9tDJMq7mTWm0NS94DqjDTOpGYVZoHsxzHRPlEce3wH237QD93uBATigfFMLAmr7m4DNkMOc6RaWjOrURdTwg24hYmVHxQCOTVbK8lQlbnGKhQr88KzNPbWSkErbUofLNPGyzLhRl9TCdHPdlUBtBr/KVbck/ZQOVDDd2dSeqfXmybszmrM99mWPU6BtGUMM8H0eIBGQArF1emsj6IHCFVYp2TKn6cK8meyBjjdPNHG1b4WV2bg4oIlZDl9aw0sdZVRlGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h75OKqmbdspK33j1SNqmnzjhuVTM8evUshJkvY4u6Jo=;
 b=k2Cv3v+ZiUUH/ajgRTUurz8TwVHF8aF14Z1BmgYk8xvJjNNmhFvwev8N/5NM8o8ubUymfmtxIBJx8Xj96zXx/WFY5UR98E7Snug5A8d46/F9u485FxcQEfEgw2ubXcWL3f8koDwHr0FUmIgigIDXVoNdac4tqi9RRucrgJV+mgNrD3K3wX0fA/BaiJsgs4x7SuFtUyU2YYyi80l+zbVotUVros0HTGIXrNWfQQO5DXSjx1QNAJVt1TbULs5hTT8N8EIXqS9yIcXIxAlEPDVALpw9bmTGTfOIh/cSxNbENphzWLfvmesZzwUoEglNUKBPB6RqRCymzk6KzbDaIiIO7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h75OKqmbdspK33j1SNqmnzjhuVTM8evUshJkvY4u6Jo=;
 b=JlqQ0neTemiPxMX2uuV9tLL6AobXNBU87wMcy2yDfuszE5/oCftJRTMgqXyFnyw89LMmXvrzgMQ78vh6FuisgyG/82JkYxkAMdKJ0B7QP7+LIZ+QHF20lzBpMdlKTekciZYu/y+aVdtsukJxAgee9ayjG3KGWFwn1WuJVDbsQTjdMLf4SBzAUdFL1tjNm6v/ApgF57zuSYmXyoxHJfmg//TfzOr/EV7nCspmEKhWPjWoR8yjF3fNf4c15tTyqoDRGY+Ksm+tJ+sVApCXIXGJfq5PI5A30OUAj1JXuZXfb0dNbVuo5nlGYvysjdEaOKfgFuI+4a5zeGur2+te5SygkA==
Received: from BYAPR03CA0006.namprd03.prod.outlook.com (2603:10b6:a02:a8::19)
 by BY1PR12MB8447.namprd12.prod.outlook.com (2603:10b6:a03:525::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Thu, 24 Oct
 2024 16:58:51 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a02:a8:cafe::c4) by BYAPR03CA0006.outlook.office365.com
 (2603:10b6:a02:a8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17 via Frontend
 Transport; Thu, 24 Oct 2024 16:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Thu, 24 Oct 2024 16:58:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:36 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 24 Oct
 2024 09:58:28 -0700
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
Subject: [PATCH net-next v2 5/8] selftests: net: lib: Move tests_run from forwarding/lib.sh here
Date: Thu, 24 Oct 2024 18:57:40 +0200
Message-ID: <08d58ac71e0418883a1a3af190277f1cb3f2f6c3.1729786087.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|BY1PR12MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 465aa389-babb-4357-e19c-08dcf44d22e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0R3CSRgbh7hH2vxZrbWRpBiY56e1qCbCfMyM0EkKIgW05spLV6ooVwPcI7Nj?=
 =?us-ascii?Q?wuVKUO/5fibFaUMcU1hVKx5kYJP/0czzFuDc6LWEJzNcIJzB2JfIsWFBW9hI?=
 =?us-ascii?Q?WEXcCUgn6irSS9PvjSs9N2N6v0OApIQxt9P+oHjTehrVwWFeNm8pwtk1Hg39?=
 =?us-ascii?Q?qkfrWG7hkhIadx1NrcrNBiG59uSpICFc2hrYv9EDRsNTkO5vMQWgTSBpjG6o?=
 =?us-ascii?Q?diOvly/WTlTUl3sOcDdIXm5mmAvM+39nXRiMzMFvod/4M3fJYRIM/b4BcyB5?=
 =?us-ascii?Q?bT62+vvZFTz7MLsvP4TZg6ePQxmSoqoHpOwQuuZ5DZV4JFoIEathWslG7123?=
 =?us-ascii?Q?33uy3Qc4zIV+/rBOrW6QgPCrGiigmWxepL46E7PJtkfcBHhjIF4wOzb+ox8B?=
 =?us-ascii?Q?r/A6ZVfK7NDbvfTUNSX34UqaqyWqSnU0iwcuFXe+7x9JxyvR0O3OGCdSeDX1?=
 =?us-ascii?Q?yGEyt9DRMmBlmu97fwOXRaePbl3czZcnf20In1uqq7I7y0vOXd+uuPZcWwB2?=
 =?us-ascii?Q?EcnH2PrHCGsvYkYNrJkVjf7eWwn83U+fFnggbdJRX6bsEztVIKUvLQxQ7Dde?=
 =?us-ascii?Q?kko4WR8UhxdTNh25rFoLSRlXJ7D7HLZnSOvTtkQ5HVVI9CzFBlP4OAaX8CtK?=
 =?us-ascii?Q?5Ww4Vq+Evh96Ds7CbJjbwpZpJDWUeS86JoayPjoxarBYrh0cARVsFggfK33j?=
 =?us-ascii?Q?CZTNzFA9HABmzF3G2HguxRHNdoIRGDaYt6DLBAqXfzaIAz+X2wL/OH6PKS+m?=
 =?us-ascii?Q?uRd6eP9jZTR4itQ1Kx7t3bfYCg4py+0HtfqAJ78nc8YzSGnY9GhJslbaUrx8?=
 =?us-ascii?Q?3elYu6ghByakkudjqJRF4gTQ4AhRgLudnlgyrg9+aTBeX4iSaaOPuljcffbH?=
 =?us-ascii?Q?ZxDr39bSBoLUNTEQ0kPv5HpxX/fTsR1rIgdOJa5/0NgSvuJKnn5WvBdlIfSe?=
 =?us-ascii?Q?4g5zg2kr8Q72XsZMslpTNByMCsURImwIIaxsiP2k6GOPDvuqYhraf0eiZ+/4?=
 =?us-ascii?Q?1krDQa/xo+qlqoEmYXNnf0uv96qGfqUObgFv2vLwdbhz4L4o/qNyr1pWSGJ/?=
 =?us-ascii?Q?18HQIleN7YZLjgR20KP3mFzFJ7gDufngLMPHEWECUQc2gbvZEE+3T5ILiSN5?=
 =?us-ascii?Q?UEHaqkhJnQKXg6GwAQ8zG3m9A5lmoMRj+q3+W+I6zzwCPZxCDbhQAPujOyxK?=
 =?us-ascii?Q?9vOiJ/FvT7mpEj2Q2oPzYNKNUySg6scl6v8I/TA94h9D01ENuDo+lCLvnHd2?=
 =?us-ascii?Q?Rb09VCDkVZWsX7bCoeSXIPjVOtg5p/Z3Q2Bu6TjnZzV1X8QKJTiy+bjzG6+V?=
 =?us-ascii?Q?ietBdF0XpZF3KC5QKPrcATxILlrhwNOxvoX2ptrNQ1aFEU+YdGV7SyFdcOLM?=
 =?us-ascii?Q?YUJZs/Y9r/RXNFocGSfs5J/WITUq+3/whbg6nY4OEP7fhEplFA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 16:58:51.3027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465aa389-babb-4357-e19c-08dcf44d22e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8447

It would be good to use the same mechanism for scheduling and dispatching
general net tests as the many forwarding tests already use. To that end,
move the logging helpers to net/lib.sh so that every net test can use them.

Existing lib.sh users might be using the name themselves. However lib.sh is
always sourced near the top of the file (checked), and whatever new
definition will simply override the one provided by lib.sh.

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

 tools/testing/selftests/net/forwarding/lib.sh | 10 ----------
 tools/testing/selftests/net/lib.sh            | 10 ++++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
index 41dd14c42c48..d28dbf27c1f0 100644
--- a/tools/testing/selftests/net/forwarding/lib.sh
+++ b/tools/testing/selftests/net/forwarding/lib.sh
@@ -1285,16 +1285,6 @@ matchall_sink_create()
 	   action drop
 }
 
-tests_run()
-{
-	local current_test
-
-	for current_test in ${TESTS:-$ALL_TESTS}; do
-		in_defer_scope \
-			$current_test
-	done
-}
-
 cleanup()
 {
 	pre_cleanup
diff --git a/tools/testing/selftests/net/lib.sh b/tools/testing/selftests/net/lib.sh
index 691318b1ec55..4f52b8e48a3a 100644
--- a/tools/testing/selftests/net/lib.sh
+++ b/tools/testing/selftests/net/lib.sh
@@ -351,3 +351,13 @@ log_info()
 
 	echo "INFO: $msg"
 }
+
+tests_run()
+{
+	local current_test
+
+	for current_test in ${TESTS:-$ALL_TESTS}; do
+		in_defer_scope \
+			$current_test
+	done
+}
-- 
2.45.0


