Return-Path: <linux-kselftest+bounces-26015-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF9AA2CA44
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 18:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903A83A389A
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Feb 2025 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A373199EAD;
	Fri,  7 Feb 2025 17:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fIwmx8ur"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2073.outbound.protection.outlook.com [40.107.101.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C24719D072;
	Fri,  7 Feb 2025 17:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738949721; cv=fail; b=e0sxCqYcQivKAoCQX2PR8fjtnvXgwAZJAUus0UrGeiKopvPc/QWpGoZfmvYXSpYaAY0oCu0m3oZ8waGU9o6urPGCpluPVc5d81fmfgOsOPIIeomhkxkeLNZzSLnif2oGStGC9J1wxLrNs/+/NV98fsnZ+GriXJp0M+t4buEQeyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738949721; c=relaxed/simple;
	bh=PyiBw1NN0MIVQSnwXJoJ5K5AYfHpBWypLlDQ0u657qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lEIoQ5SjAYcVVwZzySJUnla65fMRWxjVNoAAzNJnyA6wdhXe0zvAkrmE/K6ACtLc3TKGPDWWE9zZutO7Ubb/s4sbYfkOR6fzLtfEtvn7k2+0RKaPm+IPF9XS9Yok2MpLdkFq/Zbr41gPyCmLjwcggcemo+6ZQnQrWkxbXil5hnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fIwmx8ur; arc=fail smtp.client-ip=40.107.101.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s0O8SEGwYDaQ4naAAePxdtjfVKSi9IjpytBtHessurm/gx73C2B+taeafgMWKNgkNjECP1BQwfZahQitFr1HL8tH+hIc/6qgnP2buy6dmphvSrjtIKJz3kgt/9abuWVnhCXcYWG3f72GiId8qlmNQKQ2nLJN1iv9CtiUXwJvooVfZgzGJcDqQGIBGjtumKjQkr5F7wx+dcVyMOzn3tCiRwO4DzNr3nLeQmGdsaCrHgI1u8A51yJnuRYqQV9/u3SMAtG67l6x2KrgCeQBuNEjsBLzRsb0eOoVpX/h4svVvqsg95+diuNuqiEMKYw4S+9QH8QH9DudyOGnCfXBTq4GtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEo5WWTK5khQiPIj7CoxzrR5tVDniFaoGDoi64w769Q=;
 b=FzQSYL0HG6t6VgyYX/r4LXdfckWQwcdYekS2ajWKHoc1MpkODit2sUqCeT1m1bLx6Ps+Brrg3gHb6MTuXMFhrA6vFbix6snYadKRVHvYrmY2aA0thdyu7FJKJOZoTrqhPcd1VBvWb0rZztdM8EMk4aCJAAZJdzWzaouRUZ6mObURfU1HpEqB15ppVmnenVea5Yg4U25f8SsAvMSgNYdaDvHeaeLIam0gyGu36fViN099pOrbxxixohZ8SU3Svy3j3z5dddXO67ltcnV3cmzndHfIzKaMyO6d2zwjk3VAhb6DfjPbKwifuBZMnJ3SFCNHIOeCLF6uCX/kSvtRUo+Q8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEo5WWTK5khQiPIj7CoxzrR5tVDniFaoGDoi64w769Q=;
 b=fIwmx8ur06p8MA6PRM5F6h+/G14pYA9bAY9lgiHs+T9EsL3WhcZO3BQkBZ/Xe3HOn9g8MLW0LG7PNXvjzVzI7hry2KEXwAw4ZWkI6FPwUEQLggx7VeLPbVoLlPYXgTCcoHyjJFTjyFQH1TJ2bfFyszJBlfs4rjiBERegBxD6km5byOM2zR0EmH43hA/ghJGHGMSj6C5/Zq6p/OgTHixmEriumFqP7gm8FOb8IGExnao/I/V2tR7mN/rCemCvU0tFS4rPIdNnKO0qkuVG6naZK0Z2wablQ6ixzlfPEnTIVZG0urowNIUXJ/GhFAO4q7Joy0N4bax2BXM0CLS1KA/vKg==
Received: from CH5P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::20)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 17:35:12 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::e9) by CH5P222CA0019.outlook.office365.com
 (2603:10b6:610:1ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 7 Feb 2025 17:35:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 17:35:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 7 Feb 2025
 09:34:59 -0800
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 7 Feb
 2025 09:34:55 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	<mlxsw@nvidia.com>, Simon Horman <horms@kernel.org>, Shuah Khan
	<shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next 3/4] selftests: test_vxlan_fdb_changelink: Convert to lib.sh
Date: Fri, 7 Feb 2025 18:34:23 +0100
Message-ID: <1fc265cc6b129698b00cf1e70a66b9939ed72acd.1738949252.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738949252.git.petrm@nvidia.com>
References: <cover.1738949252.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5b7f26-02c1-4320-446a-08dd479dc69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VeY4GCbbaJiiU0w1neYEcyxZfhMbv2+bs/2fZ2b3TLlVzCq7qPmeeKcWgt38?=
 =?us-ascii?Q?FaArwaruNfVX8VNoQr94m2Ok2v8wNQLjwLVrPsXle8gMYNL6/ekhr6jvMViS?=
 =?us-ascii?Q?iXqbDM1/auaS9SE33iOO6dIkvq22dbRnvkoIFGY09oxwiU4pDKV6yv2GYBp9?=
 =?us-ascii?Q?4VlLZNPVx1zUaju78orLci/2zwyB4jJmO/ZbaBTU0p8HHbEUBhD9GK3mNAAC?=
 =?us-ascii?Q?LMn+t/wtS7jts8xjCPLk0hVCVbl52UmXD+2QVaSI8W9rwlKBwi/aeb317Eah?=
 =?us-ascii?Q?gRweMuPaH04VoD7RIlIsCj08DICQXwwRF3qlWA+DNsRYP0gNfguZ+mfKZ4+h?=
 =?us-ascii?Q?1EwIrvQMA5gcOFZL++VjWQLPsBas45uVEvIEr9l93a7MT5IWGJuMel/ejMsb?=
 =?us-ascii?Q?3EQWXt3AkEl6gFitoKx9LRSvbcadV5bdHz0yFa9R8hwjd5pmiyx5sIeC+K+V?=
 =?us-ascii?Q?7Gq9NVDwMKPisW+Q5ISfeKqLQRwAyd2kWJdZqzNEkAlkF6nxuIJiXljQbVj+?=
 =?us-ascii?Q?xfr5UaJaBw+nbDB8jpm/S25yfhO0npMO1HBpdgwREi777WLIeVPHwsWZj/wa?=
 =?us-ascii?Q?G5U1OtgxykB2XgwqGJVKTmT1kr6cd1Wp4R2Huyur2V7bsW4cA7LoomkdxNEC?=
 =?us-ascii?Q?7RIqTFe1mMjGVjaccDZzc4io2WkxLXyX0e9PyP6Wp1IAm16IBjSfHzABkhHM?=
 =?us-ascii?Q?LHTplIcVq6iLSCJrcI1hfK+RAvP0vcq+5+Im7aU6tqKJ5hUL6GMaKu6Jbtoy?=
 =?us-ascii?Q?ZZ7q2b/nsP95g3R8kKA3QW1/JM5UM0nIr0Uf3FiQUFCqV2zY9xcwswe/sHmr?=
 =?us-ascii?Q?dzapi2Cqy5sqWVZfcuJ/7vcrUFAaM81D6/y3DUp1rkfs7XV+5b4VcvuDW3p0?=
 =?us-ascii?Q?ggl0JFS0FoOCCn9FRIujLfgJlGqumObzH5D8Z9qB4yITZ2zIniG0VFt1XsEt?=
 =?us-ascii?Q?4tYT7xf7nYXpOEyNRPxewaX8dHP/eywFZjfRn3PMQq5G9uBK2/5RErBo1AvE?=
 =?us-ascii?Q?PEhQuBRkU7IrRvR67rcY/w3jEJKUgQl82vIcKcDwEHxu/A7x8KJUo3vHlItk?=
 =?us-ascii?Q?uupsLJ4VRAFcTQL9MTcxmsEkO4vuzvaIB74JBCbIzfM75zR2TVI39nUMCRgo?=
 =?us-ascii?Q?WxTxugTwW5HUfrvXoZnUy+vPsjl6D1RfBBauuykb/4bRvPTZ5r87cpqHOd5R?=
 =?us-ascii?Q?A3rWt4GwtVbOhfi0nJIilKX69nnb0KuXncJlFQSimFk+sSnpIFBqFZ+RUWSC?=
 =?us-ascii?Q?PEEAkBCS/OxH8EmTQcWbmdgYS3rjVFPNes52+RjXAJrPi0RlGBb7P/dG49Rl?=
 =?us-ascii?Q?oWJj3gstTBZd06tS/E6UFd2y10nswJbi/mZljn6jsZ+JsQjd7TM+ZaV27dHa?=
 =?us-ascii?Q?3jkZDpt/6Fa7Ytna0lzJ9xiKe01oGQ1ryuTV9agrkyaxUei2764MTwo9D4l8?=
 =?us-ascii?Q?Me1VKVeEIJsMgFfw44LLOjlGYkAlgA2mstUUsGKOo8qzlmN2iOirE3qsU6MM?=
 =?us-ascii?Q?PJZJCpxb1T/1Wmg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 17:35:12.2327
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5b7f26-02c1-4320-446a-08dd479dc69c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

Instead of inlining equivalents, use lib.sh-provided primitives.
Use defer to manage vx lifetime.

This will make it easier to extend the test in the next patch.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---

Notes:
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: linux-kselftest@vger.kernel.org

 .../net/test_vxlan_fdb_changelink.sh          | 39 ++++++++++++-------
 1 file changed, 24 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
index 2d442cdab11e..6f2bca4b346c 100755
--- a/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
+++ b/tools/testing/selftests/net/test_vxlan_fdb_changelink.sh
@@ -1,29 +1,38 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-# Check FDB default-remote handling across "ip link set".
+ALL_TESTS="
+	test_set_remote
+"
+source lib.sh
 
 check_remotes()
 {
 	local what=$1; shift
 	local N=$(bridge fdb sh dev vx | grep 00:00:00:00:00:00 | wc -l)
 
-	echo -ne "expected two remotes after $what\t"
-	if [[ $N != 2 ]]; then
-		echo "[FAIL]"
-		EXIT_STATUS=1
-	else
-		echo "[ OK ]"
-	fi
+	((N == 2))
+	check_err $? "expected 2 remotes after $what, got $N"
 }
 
-ip link add name vx up type vxlan id 2000 dstport 4789
-bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
-bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
-check_remotes "fdb append"
+# Check FDB default-remote handling across "ip link set".
+test_set_remote()
+{
+	RET=0
 
-ip link set dev vx type vxlan remote 192.0.2.30
-check_remotes "link set"
+	ip_link_add vx up type vxlan id 2000 dstport 4789
+	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.20 self permanent
+	bridge fdb ap dev vx 00:00:00:00:00:00 dst 192.0.2.30 self permanent
+	check_remotes "fdb append"
+
+	ip link set dev vx type vxlan remote 192.0.2.30
+	check_remotes "link set"
+
+	log_test 'FDB default-remote handling across "ip link set"'
+}
+
+trap defer_scopes_cleanup EXIT
+
+tests_run
 
-ip link del dev vx
 exit $EXIT_STATUS
-- 
2.47.0


