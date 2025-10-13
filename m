Return-Path: <linux-kselftest+bounces-43020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862B7BD558A
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 19:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED5618A4230
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Oct 2025 17:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1BC2C0F78;
	Mon, 13 Oct 2025 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N5jUSqMJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846F63054C2;
	Mon, 13 Oct 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760375050; cv=fail; b=DBdQmyGBctjtKlHbXCqnQ+SCwMx4J9BfOHqjtGrN4Hy7UQ1srhhYSvVtCfx/9b6aFaUOMqhm/qBKqZyc/E4eeKVMWPLDMsohbebYMfiaVNGLocfzvlmfatzth1bzL82cT4JBn0oppKMItZ94xk7BbFlhVkVUDywqJDphENLzfOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760375050; c=relaxed/simple;
	bh=YRP132taWkgNyQYz86N1X9emhm2FTHuW0+suYCJwSRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4HTAhL0RMcpMHyGT256ugezsMz5Cool7j7+EScowYbPBSyzL5PNFIxjaf1rekYLHqwFVN7BF1SjldQ0ngSWZqn2PBWrMPtmG5gtwZ170EqsJnuaWbOKuj0rpLKspvHaKMoBaeJtip7djTAe2X9glZGb00SmCMHM3yOaToa8yew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N5jUSqMJ; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9ml2RSKlEN3LIHUpufWlykb7NLQNx43LcP+QYWMo1c+VkYnN/nrXEB3wgDRkndDJMyCcOnmHdtbDbscoZp8LDEugImHaEQHaYzHT08QSqCQNfg+oXdsANopOzCBfHHeQNVyprRcdAsUdCq7dWvqZnmBn4Sp+FJzj1oUNGF7GALfHvWeWEM5xG0BVJhBnlOhZ54h8hRpHn1+CaN2t8rJFi1U4z3sboey7IKGUqyi+6eodlxjVZtbujs6oyv62SBWrH1RF/bpxggb1IoCb0sJ8shy+kADKhRUdjhtO67YZIvP5lHgD2QSG4X2Yu90uVof4ICYKWGCjGGhbQk3651e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=hwyPE6fSPAZ0oGVpfl4nvtJYtFoxhy1vCV3hiFfyC3SFjjVbYXIR3g5Xxph7zSuFKuccVVdJngPpj7to2etDhg6ZEjgDb25k5TumylBt5s3iHQAo0PzVDIWWvNkpbsge7oohOEKHR8tYXvSV6GMqhsPY14zfS3hmN9Sjrxy2eVRoHhyxYhGr3qPi9el146TERkbfdQADmFNTiuBgSQbQbkr5dwvTa3/yYOzZ0oifMNmTB3Q7PmOJyWaZcBIZyCBXSLgE/+nKCC3iKRPqUK9tigyDdtcz+Zf4SNzge2Lm73De9UsPYAOIehaOHdOqpQdc3VkuqKJSS4FT+hEwsDBEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCg2EMw2XRkq8ZGaAjDIJbN0lRmhdEsGo54KVZzooZ4=;
 b=N5jUSqMJEbvvKJsecV+zkHA3WDJXff9cBFn/5KaK8UMeMPzKLtYooqo6FlP4JlB6QZ+0U+saNRWy7NJA2jeevsBMJjR8Z/Z+hgIBqRawDeWn98i90Ckcynvj+hRjk8EXAKG1DYguE1Nxqahv9xX3hT5NZjBwD4vt/Q+NCmM5ouWVOLc9YGTPA2zVqrZRa+F2uAo6eM+yk+Oewzs5HTDJPvE2GcQmkDJ283K7P6qA4JYbVJq7XxHaJNYXr2gEOVbV7qSqXxL4pgZ3HFLGBXtlNwXyvh/wYQM5fJRbCL/beP05VWObWZI8YB0pn6OJ2p3K2+dNY7ffmmktMEM/hMVEfQ==
Received: from AS4P192CA0037.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::28)
 by AM7PR07MB6850.eurprd07.prod.outlook.com (2603:10a6:20b:1b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 17:04:05 +0000
Received: from AMS1EPF0000004E.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::c) by AS4P192CA0037.outlook.office365.com
 (2603:10a6:20b:658::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.13 via Frontend Transport; Mon,
 13 Oct 2025 17:04:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS1EPF0000004E.mail.protection.outlook.com (10.167.16.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Mon, 13 Oct 2025 17:04:05 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6B5F31C003B;
	Mon, 13 Oct 2025 20:04:03 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	andrew+netdev@lunn.ch,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	liuhangbin@gmail.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	ij@kernel.org,
	ncardwell@google.com,
	koen.de_schepper@nokia-bell-labs.com,
	g.white@cablelabs.com,
	ingemar.s.johansson@ericsson.com,
	mirja.kuehlewind@ericsson.com,
	cheshire@apple.com,
	rs.ietf@gmx.at,
	Jason_Livingood@comcast.com,
	vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v4 net-next 13/13] tcp: accecn: enable AccECN
Date: Mon, 13 Oct 2025 19:03:31 +0200
Message-Id: <20251013170331.63539-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004E:EE_|AM7PR07MB6850:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f4af246f-57fd-4a60-5672-08de0a7a840b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|82310400026|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ADWCON8eoTXfidzJ49kYquONKYJJ4f2g7DpXvtq5w7aJCuP2YyqQmOYSJbwp?=
 =?us-ascii?Q?eH3mch4Cn92UgVHwbvGerWUTcDW3EX9suvOntP9+e+tE21MRw5Fr3FEwnfck?=
 =?us-ascii?Q?VqbYElpV81K2K+6vo1BuzKmgSUvpEcNt3YP6DPkOu99QXK22q4FFBEbu7aaF?=
 =?us-ascii?Q?cmPxd4dYWRnI/aivuQLUz6XMv5ZhDGWEpH71vQc5ozfjdgk5iiPSLIZHtjJ6?=
 =?us-ascii?Q?2YEgFZ7v7qe72MAEgU72O5tPlx5cQYBvH0r4sU2JPXzM+bQKjfU/YfpAfE+U?=
 =?us-ascii?Q?NtHwuPJ6MB+529+BOgZGgJQ3muQ1IZ3Xv6Gn7oDbtsO3Mbh1wLvjy/dTl/2t?=
 =?us-ascii?Q?Ps+enA2R3DbJQon+1TODlJ18pSlw5zkaIXumXUeQAru9JK8upx0aVMjASqgN?=
 =?us-ascii?Q?w0+n4GbhReWF3r8c5HDwuoOV1JEm4C7/69PgRmQIcKOf3ZNFIXwCucTymQdr?=
 =?us-ascii?Q?U2ZynFDvUenwimlRAMQMOgEc6Bo5FKkZhELIrLOdVpinodgfeKv+HZszoHGM?=
 =?us-ascii?Q?qd9wEZrMx1jyQN00yzgnAcy2eozpBTG479am+bOdX4j7vg6xZ2EL8HaOsPEr?=
 =?us-ascii?Q?E56uESoE+ioRxccmFrG8CmgHDFgpguTOf6J3uXJXINYYJ0tzu7kkbIjtTwCt?=
 =?us-ascii?Q?1R5pEb91+DH24AcIIdj7WpNPOqw19jXst6uuZNfG/zYQ3BNUKzGuwBEDxhxQ?=
 =?us-ascii?Q?vpvqL20E+wOyomYb4sGuhD2I+C0BEb/rabh0JqCHNzqe5aJFsGmq2W9LNoUo?=
 =?us-ascii?Q?CZbKgzdHYZS1plE9ZpdrigGvM/o64TEkPRnDH3Fc79QHKHIOY7aIdHk9cR35?=
 =?us-ascii?Q?pWM8wLmd07PPYHFALMEHmqnnN/f4koCiFWrUG5R50HIbaiOrzIAN0aLExDSt?=
 =?us-ascii?Q?GL3EKRXCqmyXF8OQpVNHnS9EdXHmGye4ehDu85C1xSj9jyus8uM9YY83et04?=
 =?us-ascii?Q?csS6AfydsR7tDCeZZuiDY+3gpJLvlWO1v/buZCRnWwvZU/HNdYI3VQ7HMQkM?=
 =?us-ascii?Q?XBhfpbc4Va8yZxUV3/aIGburPCw9Hz1iDdLEHVxf1Hk3HdTeQ1kW+7pukbMT?=
 =?us-ascii?Q?nXeOhkkE9RHhLn6uYnvXvbWzo4nLPu1wlx3dhzjjWB3B5Is8ikpxkdk3t1+W?=
 =?us-ascii?Q?i2wvEB6viJg5Z49DR7HkdkFvuStloMKYnHG8Pm2lE/edIN+d+e492ULVoz48?=
 =?us-ascii?Q?9yG/ltDZhZPG0lzZUsrJ5h2DX5r9aNS4nDGMhJp5KE7asy3t2PlXB69gSW2u?=
 =?us-ascii?Q?PjvUJPpiGor3UCpx271sbAeuKmHQLD4FiYqM1vUKDwLQrIAZcP7jazo1eMnA?=
 =?us-ascii?Q?q1I893e+VAQkfyQgJeOxoo+5mCjoEwBL+cKUCgUW7+yz2FTMPbfDR3Qq+IJN?=
 =?us-ascii?Q?cc9gQ8+9tmUBuI0YdR82IT33b0e+SSkHOJoZeDAm9yfRqxdvIT7dZf5D9Tg2?=
 =?us-ascii?Q?3bnw+wqZ9cCzI7D/BsVIAHZslhTsZAc6kEUfySSdCT6V5dEtrlyCZf0Hdcpu?=
 =?us-ascii?Q?ovy++fDJlizYSXPN4V2vcow/ZYZkNVpfx03w7Cq0wQIIP+3TI3Lte3JlbbtH?=
 =?us-ascii?Q?l34TLjotwfd0UVhAd2kP8+Y2grKIE1JOnrjxLa55?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(82310400026)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 17:04:05.0102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4af246f-57fd-4a60-5672-08de0a7a840b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AMS1EPF0000004E.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6850

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Enable Accurate ECN negotiation and request for incoming and
outgoing connection by setting sysctl_tcp_ecn:

+==============+===========================================+
|              |  Highest ECN variant (Accurate ECN, ECN,  |
|   tcp_ecn    |  or no ECN) to be negotiated & requested  |
|              +---------------------+---------------------+
|              | Incoming connection | Outgoing connection |
+==============+=====================+=====================+
|      0       |        No ECN       |        No ECN       |
|      1       |         ECN         |         ECN         |
|      2       |         ECN         |        No ECN       |
+--------------+---------------------+---------------------+
|      3       |     Accurate ECN    |     Accurate ECN    |
|      4       |     Accurate ECN    |         ECN         |
|      5       |     Accurate ECN    |        No ECN       |
+==============+=====================+=====================+

Refer Documentation/networking/ip-sysctl.rst for more details.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 91a90c34a810..9072584e6617 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
-- 
2.34.1


