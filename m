Return-Path: <linux-kselftest+bounces-32783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E635AB1ED4
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254B2A005E3
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76C25F7BA;
	Fri,  9 May 2025 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nxy1aOcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2063.outbound.protection.outlook.com [40.107.103.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37522F766;
	Fri,  9 May 2025 21:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825528; cv=fail; b=D1VlzxSsXMkuvVa1BjdlvMgDX5alNmPWycj/ICUuI9o01hFDANVPWHzR0GKlqiRW/XHV3WjqhpoeWHhAmuKoGNRN3/2O99DQTggFYfhwWZDpuEKkwS0NQ0kmu0IMzbruB6lau3GM9gV53AHu64vr9BJDxp+roRFxoq+/YIGOHhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825528; c=relaxed/simple;
	bh=MNr6KDtqkkit/GcvqOhloLEQrdS5n127BfgBrGE8ZcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UheT4uF6i47GORY1CPA/7BRyLF+iGeY6kbKXz4sUvtYq9qPOHss0ol5vFPTBqU8DC4qsLxddoG5812fQsGjA2AokMQqqGRyQ0VFCkSiMmNX+vm46oVwcuIqChwIZ/W7MFgUpV3ZCJEh5nroeyMSv0qBvKvVIXwkuUvjx8A+rZO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nxy1aOcl; arc=fail smtp.client-ip=40.107.103.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkEKwk/j7X69sF80/NSj/b8kcOMv0ACl8xJ5DAC9LFcbs5vZkCLRrI5yDMSE6pA3RCV8ZPsoGTAcxSTLAE6mOWAWDjkIfkgP9uol5wouU5HwuWUSQ/Q+skMIxYjIjHOW4Hdny0dD/jsw9e9rIUryDgmqjZq5/c20NjOOBS4ZZIgd6R3qJRDwY1spMAii7GNliNXSo0uSCu1ftYmfr+cIOj/4Z+9/fnLqqaoMQ+TgvtXeVTIavToNR6XYj+MJUn8JiUUGThVriaV9lqhF+eh9A4DSq84fNsD9a8A7Itd9iUHJF5LXeRry1UoqQvQYIDVx8kU1mGvV5HKy//Vir4YEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txXD5HVohcaLbFXRjdapjANk336kC42Z+zcGQl9lof4=;
 b=OuF5NyxcceLjtV+jwoRNpKkd/nhrSr8Nk7IF2JB4RamR+I0+3oBcH09jaiqtQd+RPuQTE+1FB/0OgHklGbWVw5JWZk0NCoDYt7mFDO6ovreQKeB3FREyDbjyBPEHvNgDcQDLxzsFbLehsra1IK+NZgmvf0yLo3Y+qLn6WGZJP9uhelZVnLNCihKjbt/fFJk458zztViQF+GG34f0fzKISkR9YDHTFcYdj04THFnNQcKJ0LT1YfQHQp6kHIqvlVx80bZhVCfW0WkPGS2HrbBKP7SQKj3exk4sh8+ceJFt3fvlw9wSiUrb7QScCOQzyQ9WWe40E1uk5x/z6iyQcIFhxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=txXD5HVohcaLbFXRjdapjANk336kC42Z+zcGQl9lof4=;
 b=nxy1aOclT5ASitkmdAtfrK8/Q4spGWcAnTwsjyAT5ksvPdh/lhC4w+9rCv7lxbGr/FJFBFr+avkiy2HbUFOz7rKE9arfOgToeQy1aBmDyDUhh4ms1CWPkvzmhfC5NJrrzqxo9P5n1XQtqFCbl17dIhOJoOjazHVYEOwmhO85oszGXxWNFoKaKMK0PBnmwaW4EZPZ5E78EJXc7RKwfEbT11CldF41IbYfV42zGOF8ndhoAnZlhEthJYQA8aNJYtjSuXzmFW8/H/JWeKgMV2HKJiaykRFWOVwQqmHEoIbpDpWIB7QKBHe5T3iTjuI/J3gQswdBRE6/Cu3lOaEM6YSnQw==
Received: from AM0PR02CA0180.eurprd02.prod.outlook.com (2603:10a6:20b:28e::17)
 by AS8PR07MB8185.eurprd07.prod.outlook.com (2603:10a6:20b:374::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 21:18:41 +0000
Received: from AM3PEPF0000A795.eurprd04.prod.outlook.com
 (2603:10a6:20b:28e:cafe::13) by AM0PR02CA0180.outlook.office365.com
 (2603:10a6:20b:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 21:18:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF0000A795.mail.protection.outlook.com (10.167.16.100) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:18:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id A66302009C;
	Sat, 10 May 2025 00:18:39 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v6 net-next 03/15] tcp: reorganize tcp_sock_write_txrx group for variables later
Date: Fri,  9 May 2025 23:18:08 +0200
Message-Id: <20250509211820.36880-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A795:EE_|AS8PR07MB8185:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 65b836f6-fb05-4af9-923b-08dd8f3f126c
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2ZfexKCoJ54WrgWxJgW8mk7nOjunneNIoeU5wcVL/EA8AC7Gg6bt2TZykhj0?=
 =?us-ascii?Q?4Cod+aC7d0enDlFNFHzxBzhfvsJhnTAazfkyCtZIfDqt6mN3TfRA/RO0GeD/?=
 =?us-ascii?Q?7aE3zYwo1QzrHMzaQvi2tGJRGzDc4Eb5u2sGcE1xBKSixMEl39snN5Rs04p5?=
 =?us-ascii?Q?6jXlYSSa/W/2qUJrp7QynDJkF7DLYEFdhg+BwoJIaXsIIkCdRzxNf0L+UjTc?=
 =?us-ascii?Q?Tg7k8CSjJMzeA0rUR546mGAed6uQF0Cc9PJuhSqI1OFUe758/NDeMiq5iea3?=
 =?us-ascii?Q?j7BqdWfvkX/hQErdRqgobpe+oCqDPifscrlV0njUo78sBD6IPwUV73kbXG6g?=
 =?us-ascii?Q?FlOJuz8KjF2k9klmICRTfW20sewCoS1cZJq2AvqbkgkfI9GMuJ2aTi5ytgBa?=
 =?us-ascii?Q?wtCYeaDXgGPgsqsXmZxfyu58q1pEyxXsZiyGoQ8xWouITggwDD87SHGQzgqF?=
 =?us-ascii?Q?7/sthmfi01TGlKLOKA1nrwwslCmkWb1Sxduy9BL6LVUPB5zPspH4tRuPjJpq?=
 =?us-ascii?Q?MBhyVsJj0ev/rcqCJxtxiCPVJkj9rSqUE+UIKsRrdo53KnPKxgHZph6DW3II?=
 =?us-ascii?Q?uxo2aqO9gS30ADj3BwD8IDeqAouN0yusMfzlos6en2NanXwiDPieH9490HR7?=
 =?us-ascii?Q?0qSKDyyDFP1rQAhQTe+jAZnDIPxGopsNy0FOw00lHTqoOyPdC+vF6jy3KOtd?=
 =?us-ascii?Q?elEHemQ0VgjCBr0y6wqNb4pDcnPuijuZ49URSxRbHCsz/mLtbk4NhZ85Ldsb?=
 =?us-ascii?Q?m0/0tYd/DumIPJ2p+ZdEnP4cSj5bAk6J63TkH9e9t3HOr8dqhvIek4BxKcDD?=
 =?us-ascii?Q?HGu9VkH+OHjUbbC4/lz3rCErOHGi3N/TO/X7Zf76Ckn6EsdvcFTEm/PVPSD3?=
 =?us-ascii?Q?pg7NVbpF3FZybZcga2F7dZFM66CPPdgk7nihoM1V3iP3rTtoCf8bxXcXOF7X?=
 =?us-ascii?Q?V2FwiBHE6wHYEKK2KS3Bwv+SpA/KNah+hYkjjvQhymCnfOuvF3swvcu3DhiK?=
 =?us-ascii?Q?n56EBvcPPZy7lumwmpQ4pwK0ZYeQFURSjqNvnxF/z1rrOAT3ZRvlRgubgxwN?=
 =?us-ascii?Q?VHtN9xZc8+8HbyE0l0XiiGQhCfuuehHdZQKJilGn7o8KOFI3lQ391x+BVpuZ?=
 =?us-ascii?Q?ge7hDEMGuajjSIYLWNI96SmcPI0Ed8MmhUCDOqJjqxcx6Tz6AEfJnJ8ifO20?=
 =?us-ascii?Q?5LI8oVg4NaGmfYUzmDTX8WmdmiXg7OmBL9vDAfYG/XwBkycV+9yCJGGcZRI3?=
 =?us-ascii?Q?sBdze1Xm2n3coJaaJhHm7E2u7SiCzQQ3ZzbjnhfrFDVqOZ0sUy8omsoXb7iP?=
 =?us-ascii?Q?nhY132Kn6w47R9OBbYyVcafyqp+0bk9HxZD0qrcRWQSSXb0t0brD5CYnSNhn?=
 =?us-ascii?Q?XQ+MZUbV2c+82KNEvHXrbYQa2Ea+5WPcXWo6A3kjhMXebPX6cRpb/LjmKyQt?=
 =?us-ascii?Q?hEDbK39HHZuqYbqt+5KyzenKjeBoTKJde1h8uufGAzq3glL4pVOiJy6ovlpt?=
 =?us-ascii?Q?P7VScGdaIZJDJZAlQx8Qsp1Yo5TK/DHil11LTqxsURw3B8ajHZFChrJuSQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:18:41.0898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b836f6-fb05-4af9-923b-08dd8f3f126c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A795.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8185

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Use the first 3-byte hole at the beginning of the tcp_sock_write_txrx
group for 'noneagle'/'rate_app_limited' to fill in the exisintg hole
in later patches. Below are the trimmed pahole outcomes before and after
this patch.

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    /* XXX 3 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */
    u8                         nonagle:4;            /*  2676: 0  1 */
    u8                         rate_app_limited:1;   /*  2676: 4  1 */
    /* XXX 3 bits hole, try to pack */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2677     0 */
    /* XXX 3 bytes hole, try to pack */
    [...]

    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    struct tcp_options_received rx_opt;              /*  2652    24 */

    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */
    [...]

    /* size: 3264, cachelines: 51, members: 163 */
}

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index a8af71623ba7..0c82a8c942dc 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -286,6 +286,8 @@ struct tcp_sock {
  *	Header prediction flags
  *	0x5?10 << 16 + snd_wnd in net byte order
  */
+	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
+		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -304,8 +306,6 @@ struct tcp_sock {
  *      Options received (usually on last packet, some only on SYN packets).
  */
 	struct tcp_options_received rx_opt;
-	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
-		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	__cacheline_group_end(tcp_sock_write_txrx);
 
 	/* RX read-write hotpath cache lines */
-- 
2.34.1


