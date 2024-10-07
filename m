Return-Path: <linux-kselftest+bounces-19167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FC0993347
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 18:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5F81C22C96
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 16:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FAD1DB52F;
	Mon,  7 Oct 2024 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bjeq6f9p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85711DB540;
	Mon,  7 Oct 2024 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318554; cv=fail; b=oO1+CJV1vqwRIt/eRoSg6WylAfDF16Y3kkpTTdgSMYFQaWaALnSDCnacKbujBgydlQ+EkTWBjAlqmTN/nB+uajT4uIJba78IUS5DWFKpLOtELxXNJj3vUlZftYIsGpyU2VAzeKyMOnx/bKGM4X3Pwz/gooWDaxmfOEwhJw+C9sU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318554; c=relaxed/simple;
	bh=evNv1oJdEls/x6ILOvbOlxP/BBM25xHqtMI8H86Asc0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=COozpB6J1FFhaG/er9ZvAxoawu2ReWG2wasNbk4BuWeUmDxDTuZaVJL+02qYTAcYCgUWELsEgXAljV5ol7U5JYxl8QLX3nnfZTy/D+IT9KTtnflrmflNTIxVuld90tknlNwQrtV70jdXtRRtqqYD9NRv4HnOoQAqhu8PhvZMUME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bjeq6f9p; arc=fail smtp.client-ip=40.107.223.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikH53AzAuTxA2NsqxEuOF8570bJ5dK3JfJUmVCiVzT+28VQJqN/smLARMvzmUySVogmG1U06Hqja5ojmrTJzba9KYZE5UtCLUubPdeT3bdhOxEnLMDY7T/f8R/Rx6yuXM5gV6rKztWP27Ddr4Eb+V1ozpBoDmvmTTY0Uvzqda3L+tSYtclg8wRE3va0gYZzSB2KdYothrS83I69wfmHg+uLfRamUaOd+8zcMDSMCKYsNgWFeOphES1+cEO4gQW6jpf9n4k+xKQpACuLD/0oJLuMbg/Cf2RnhGHDcXGStI+iGGvVR2vMOqbDUERjaEsprearVCD2WzmcrAMR8XLe3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiWNSlx89gnJMC471eTT5GkBmMJTHv/WCrqJxkEgg78=;
 b=ZixQWPw5WI2KRLLzR9qwvSz71gnEAYiB9wVcDQhXSewcQbBH/CftVubqMOogz3cNzDsYjt0QNZH82JdS09MYt76t79GA/08EASSfT1YhYDoGP+49HQqfXnhtQvyuHNUTRUVtTEJSQoWb+gxzJNDQKd3R2afOiqf/Kk/JfLgKomou6syNx0yQVlYcaRzF21KKch5zVfJrZlodmpGLhllz3z7v1YwN2/Q/uXQKZ1hS/Ne+Ot+mqHWlSFY2E1ALgrcoGqRRfqmDuHxE/6Dte6RxUgAlljbqnN8uDSkABgliNcp66eWst6DbKo5/4tlkF+CTpG/s58Mu3KpjACEb03Ld2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiWNSlx89gnJMC471eTT5GkBmMJTHv/WCrqJxkEgg78=;
 b=bjeq6f9ploWiYmlMcIGoWiW96/VffufB7m/E/GxfZlRYiBG8pi+TEeVJa8+Omr/YEr2AeH9o5UbYqw4Q+ilXPbG9jqRtxcMRTd893p/0MJuwR+K66pXAUzYkXnPYLG1OsjxCq4+vR8F6lVbFhiXlcm+3lQy4XExefoiQsn2FTvzwYjqxjvqOjTGppnIjo2WVt8hNxopQJoEV4LvpCVgDwyMGHRQ09izQLeTpUpI3IKNHwYz40Ftp7CpVYVgSsjMWptyqDBnUnPd/Pclt7qHqkewYjCdhPg6eY5i98sb0J7jqEkcK5hCcQSbdUehN2HNojC8xS7tSWoXOPJqQxMZsuQ==
Received: from CH5PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:1f1::19)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 16:29:06 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::77) by CH5PR03CA0003.outlook.office365.com
 (2603:10b6:610:1f1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Mon, 7 Oct 2024 16:29:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 16:29:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:48 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 7 Oct 2024
 09:28:44 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Amit Cohen <amcohen@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	<linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, "Petr
 Machata" <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/5] selftests: mlxsw: sch_red_core: Send more packets for drop tests
Date: Mon, 7 Oct 2024 18:26:08 +0200
Message-ID: <abc869b9f6003d400d6293ddd5edb2f4517f44d5.1728316370.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <cover.1728316370.git.petrm@nvidia.com>
References: <cover.1728316370.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: bd8d74a5-1aa5-4c1f-2fb1-08dce6ed29a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NT9B0r3YL8Y7Y1wSJ1zevjM4lezfv+6T6UxlD4eEc/wGLetwmgGLt1oY1phA?=
 =?us-ascii?Q?Fa+VpMKHaAYTxI0XYRLAvbRaxz1vtkdjrw12IkmwO0d1YxBC5yiqLDQCkMye?=
 =?us-ascii?Q?Y8v4K/k9kxA8d8ef50G93IAR77npecUW4f3njiGlxao2EsmJ+odelXgyMBE3?=
 =?us-ascii?Q?zeTdfxtRJJfTYlwVxIfhNkgLHZi2TJRLoC5oYGShI5n9hqLK720Y69F+vCFt?=
 =?us-ascii?Q?Jrlyeqt0lcsym6MLfftLZYxYGTa0U2wzxME2XJvILu01X2iKNsy2QNVPVp7I?=
 =?us-ascii?Q?JI0R3owAPevSyft0v1qR/sH6QT8nctNv26qldBc07UO8XCSa68nsinUarD/U?=
 =?us-ascii?Q?rxd+lcVAe0LjD4RHu4Tf4NBa2gz9NiHHdJ6ZVYfqcgmtQcTdHT7N9tn9H7B9?=
 =?us-ascii?Q?TVYJnh2QE9O7xf6sb26EL2E87OPXPQFWFNwyzfb4VgF/48EFpMDYFXg+w+vD?=
 =?us-ascii?Q?HuNhDjZ8P2n1bqEEpTTdh1OOROatPSDl+DlexD6uJAvgDWeRD4jtNGAGOEIq?=
 =?us-ascii?Q?hBS2IztcLyaOcIZ+11KF+PLRXM7gvZfwrf+nm45bqqOnRPaiSDxfDu/1hsph?=
 =?us-ascii?Q?1T7ZBlvVUHTAajN1m+QiYEnmu50KRGsllKJeFgIMM09DQAjbNYw2CFsna8BF?=
 =?us-ascii?Q?gGLSApRfecGk/CZF4S+5zdOAZqx7bPiYJ8db1VKNUyPz04EzLIU697/1Hh71?=
 =?us-ascii?Q?c8zyYI2+f9E7Ur2qGEEwrC56HA1LuLWRho4mPHAkFKNKrmKQyZnaGUYVTo92?=
 =?us-ascii?Q?Gg/t8muhQPwHU8u6sk7J2YWGzXBTPT/Ux0UpD7L9hJOtijhsGjd29RO/erlk?=
 =?us-ascii?Q?xYUmXHh24rDIuRbrLu2EFxnwSgjmK7gcUWzymXiV2LSeI2HCDO9/cuT6krPp?=
 =?us-ascii?Q?pnAwH0GQHZMeC+7+0v3VVfxtxYRPt8iueIOkcGlcWYrTMolNgkFwqvXU2+cl?=
 =?us-ascii?Q?tZY0pWwPS8apkdGkvCZXZwLamskkfAUw+bJonquzBy7UKiWK/CMQYwNQ8Ck6?=
 =?us-ascii?Q?c+TOO1NoDp9XzYixnxDzg/vKd0AgPC7RPYdUl7ecIZ4n+yB+6g6oRo7SHOTB?=
 =?us-ascii?Q?jmtT+IYy5Tq9/T0iJRuYutW3nRdvtNtbnGmmqxb2YvtkDc3mJVoqJLmoTQ7B?=
 =?us-ascii?Q?JSwCFs83MtJ5v8TJ95cJlv4WXmeh1Mrj+JAdvXJe6ro+Z5heq3Rg9LcmQm+D?=
 =?us-ascii?Q?Z/TW1AQsImKeg3b4P32Pc/DVF+qL7veebqamAu36wufXCffocbRG82mPx2aB?=
 =?us-ascii?Q?0IeBm5skMGr0aPlmweus5M38tDuoQ9yPUpYtfpnYNF7r5T10xwWDXZb6FcfI?=
 =?us-ascii?Q?SFLxfZRwF87Y82Fvt8S6L6M4v4sTT7cpOgeBcfn32sKErlZQ6zD2dgOEZOY7?=
 =?us-ascii?Q?eZQ1WOE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 16:29:05.8171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd8d74a5-1aa5-4c1f-2fb1-08dce6ed29a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

This test works by injecting into a port with a maxed-out queue a couple
packets and checks if a corresponding number of packets were dropped. This
has worked well on Spectrum<4, but on Spectrum-4 it has been noisy. This
is in line with the observation that on Spectrum-4, queue size tends to
fluctuate more. A handful of packets could then still be accepted to the
queue even though it was nominally full just recently.

In order to accommodate this behavior, send many more packets. The buffer
can fit N extra packets, but not N% packets. This therefore allows us to
set wider absolute margins, while actually narrowing them relatively.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 .../selftests/drivers/net/mlxsw/sch_red_core.sh  | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
index b1ff395b3880..316444389c4e 100644
--- a/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/sch_red_core.sh
@@ -653,20 +653,22 @@ do_drop_test()
 	build_backlog $vlan $((3 * limit / 2)) udp >/dev/null
 
 	base=$($fetch_counter)
-	send_packets $vlan udp 11
+	send_packets $vlan udp 100
 
-	now=$(busywait 1100 until_counter_is ">= $((base + 10))" $fetch_counter)
-	check_err $? "Dropped packets not observed: 11 expected, $((now - base)) seen"
+	now=$(busywait 1100 until_counter_is ">= $((base + 95))" $fetch_counter)
+	check_err $? "${trigger}ped packets not observed: 100 expected, $((now - base)) seen"
 
 	# When no extra traffic is injected, there should be no mirroring.
-	busywait 1100 until_counter_is ">= $((base + 20))" $fetch_counter >/dev/null
+	busywait 1100 until_counter_is ">= $((base + 110))" \
+		 $fetch_counter >/dev/null
 	check_fail $? "Spurious packets observed"
 
 	# When the rule is uninstalled, there should be no mirroring.
 	qevent_rule_uninstall_$subtest
-	send_packets $vlan udp 11
-	busywait 1100 until_counter_is ">= $((base + 20))" $fetch_counter >/dev/null
-	check_fail $? "Spurious packets observed after uninstall"
+	send_packets $vlan udp 100
+	now=$(busywait 1100 until_counter_is ">= $((base + 110))" \
+		       $fetch_counter)
+	check_fail $? "$((now - base)) spurious packets observed after uninstall"
 
 	log_test "TC $((vlan - 10)): ${trigger}ped packets $subtest'd"
 
-- 
2.45.0


