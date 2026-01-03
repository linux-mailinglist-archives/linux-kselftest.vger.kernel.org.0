Return-Path: <linux-kselftest+bounces-48117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F507CEFFFF
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C9EA30B9FF9
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A95630C359;
	Sat,  3 Jan 2026 13:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ayIYDt8o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA062DC34E;
	Sat,  3 Jan 2026 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445864; cv=fail; b=BotnCHjXdI09TQMtTlzmbER/7m4L1AN+EwEi4+7YDxpRlCKsIIS61Pt8j0oa1es1jlUEXxDboRnh6MP0jozMRPzAxF7hAo0wHQF6kCIFjYfMasKlUWrsE9+oAZuWRFz2rjiM0/ddq1+8b+K6QmsFFaOFHqxfIy0VLPTdG0nyZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445864; c=relaxed/simple;
	bh=K9sp/cKFhO2N1xPzkjJWGMSrD6M/VgnZ8iPjal4WcLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV0nSUw1h8paiv9NtNIK8Bq31ux7/uLuGy0hgqB1ltgk0XAzlV+wgKaDCauerlqaNybxMAbf/9UH4gNIyZD/wpWvrkOC2yBLC+7fertb6ZYNACYjyDXQTiBFNmBihuSaSjF0bkUSYDPSXHdp8CBpOq0alHR1RmD77g/Pi+anT8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ayIYDt8o; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TL3Tz4hDtC7gezSnrOYSocIwd5LICidfnKvRCWawpVrTGcBVWiI7lFVLUyyh9uYNYKK2uAPUnwo142oqFgMtGczVfJ4X4AnhUWhqGtMdSAICKMhtoIvHN7ODIjwAaGX68s04z8j9HdsliCS9T65PukeUDJfWFN0rQCKrHQjLEsfgQZnljHnpdOF+mav5SP9qGPKqO82MFJPVwns4XltE7gsjGzooZ7gietHeza2wdUW7C79W1mfAC7OD5DBWXVMLu59aHJ+vUJ54lFgoBfS/FWrdsyV14lriT6L8siljXGdaqp00kZ3DmUlbEUJIHVd2PcNl2X3rlMxr2uyfhI6sSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=Im6iOVUUN4+Vh5vBfBnglOz4dVLSps7ucXfsj9zvn6c3JNSCU1qvZUmdFlySSxe9Q6mmzAR5sWTgIhfTFPjV2Rrw1GNTrZsVLn5txYQDCnc9FeHiDatW2LgDzGMydFi++KCU1LuYelVE6Yw+cwbHHeDssoxvD0I4860EwOwv3obKu9wAJa4Y3mGXohnFagr8vRv+LYsAJj3MN53L0O/atwacYZ4a57/8gDkm4SIyzku0oXrXCT6eXJMjP6172/l3tNH9UCNPaalNZWlLTJhf3i5IJLWeVpEGVrgf3VoA7o52JqlfuDTpnU+walKWhfqoC/cl4fJw/beTiL6O2DCQkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=ayIYDt8oBLd+Wc/HJLK9H08+GcOgOgm+3T8nJPutwXG4IRgB9/5HE5RFaIJps7BcIecpNFZJJ4k5xWIIATOBUsaR2LqHHoobB9dUn7IGswaIzfogK8Vnwn/BqSXpIOzoXZffcHPh6c03OLGpgJhPBrLG5O/ZlATp7bzm4c/dIBjt3JLVwuY31pLTDSG7giRxEEGvZilb2rH9OP1dkAIdJE+aImmbgnFWswTHLyWwYv8vWD8JZ3Wde3ClnD3iZ8UyQbXXDwS1xS3vHYP7/ssCyJvnY6vPnLZg8YcEvYhxICb122rcRUWFJlKH6Q4e1LGQ76P3ZNisBP2jsXZq9/fgUg==
Received: from DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) by DB5PR07MB11907.eurprd07.prod.outlook.com
 (2603:10a6:10:64b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:57 +0000
Received: from DU2PEPF00028D0C.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::f5) by DUZPR01CA0045.outlook.office365.com
 (2603:10a6:10:468::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0C.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4
 via Frontend Transport; Sat, 3 Jan 2026 13:10:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0F28F1C0031;
	Sat,  3 Jan 2026 15:10:56 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v7 net-next 13/13] tcp: accecn: enable AccECN
Date: Sat,  3 Jan 2026 14:10:28 +0100
Message-Id: <20260103131028.10708-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0C:EE_|DB5PR07MB11907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e05823d-a5fc-43a8-a3ab-08de4ac988d2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?Ao0fWe32My/UDsxlHbN9kv3QsDC1CZ9TzIBCEofvSrceZ30wHiXxxK0TXhT6?=
 =?us-ascii?Q?H2aENBO4FhM617jYl/j0l/kQzGyhzfl/ot2YaAxazptW0iEkG4Ob5yqVOOf9?=
 =?us-ascii?Q?oZpPuZ3bCceI8gg7HqdrY1HRl1xsJg4edMg2co8lFfRqOfwP3CuHc91M35Zs?=
 =?us-ascii?Q?ugZkd169yjSWIMrYSlh2HyI9eKkC4QghOxj5XfbtJVJrhwZWDeG8oDAz9ARx?=
 =?us-ascii?Q?5WP0BCgsx0fNxLZAovefbRTguauvlOx5Rr4okP91FvPBPI+ptIA+0TNtqYgH?=
 =?us-ascii?Q?o5cDWWQ1gcoFfbHpOtQlgRSvM+FiTyVwjrEjzQQwiqZTagBW+0vd0dbEP7tQ?=
 =?us-ascii?Q?rH35b6ZnTGJ3VkuQtayGcva1bcvampOmwSzH43Qvp84AEWnDPUsgKRHda8Wp?=
 =?us-ascii?Q?LMFfuoooq9oNbJvfwOItocvMSnQ2LEcAWfb/zehrwPJD7KU4YLhFsrO4FG5x?=
 =?us-ascii?Q?QZLDsegVLkMXOev5Iv0K/20UIFEM7zzHDxAmebt3YElNypl+xdayggAHyNSZ?=
 =?us-ascii?Q?l7LQ8tN+5cVErcak1c6a3pr4fWbssomI7ioMECXkkLcHXA2l44aXTh35JAGA?=
 =?us-ascii?Q?y01J4qXM/XEz56OH/Q0HTCJmMdK5XK0JaZKAQOxYp5xF3bY6Mr4vTtzBixvL?=
 =?us-ascii?Q?ICvpnVV0IDGPoABxibnmnivK04fyW+SzGVQy0eXilW1iIH8S9LoSGSW4Tp1t?=
 =?us-ascii?Q?e3hEEBI1cTNEGseGAyCOTmj86A5iBhTqChrEK9m7PC/TgwUELYfEshHz+kWI?=
 =?us-ascii?Q?c5ANc8oc0kvjLXAy1DVOQB8X0BzcGjFxaMZ5zKNS+z9R4aRTMf1T5fGBFxhd?=
 =?us-ascii?Q?MFJOV8TeIfHIBhen4uE/nLL+7JtAXM6EBxs+mHwXD0Dv7RvJtOJRKlwqDvQf?=
 =?us-ascii?Q?1MJILLzwHrPAlFKBZqym2eM7hkWQa1rKJTVJHvgvnCY1JUAs8PaEXPWhGUcf?=
 =?us-ascii?Q?MRNtorZ5IyiOaWIzT0xBIHFz3TYKVuQ4G2uw/+fzLS4cRNrOtuDnnh1NAX4R?=
 =?us-ascii?Q?3aDTCPi+ErmvfSGIMGCZCoaHfgwxxCn+6BvOuwhyQWBvEMUXVG0uTMqZMYps?=
 =?us-ascii?Q?uERFhHeiWCbBalNzXNYVAtXMCOblnwlU8kFXiHkY9yN8PcYeCaDXDw5gvMaB?=
 =?us-ascii?Q?6IEd0/ctpIIMw8dgQRxrKNAw3eGN7axL1NsLldSRJhcEbplIfDapz9O/XAO3?=
 =?us-ascii?Q?fHuzS0egh07AzrjHGUB+IBPpqtvX7CnaBn3wV3mXvbowQIssP8IcSApQIpTI?=
 =?us-ascii?Q?1do7a9phwjofaPtXwuZBo9EoxaSSKLjMKLXPtqMUk3StdZVp8TSNJ4ZFvBp9?=
 =?us-ascii?Q?9J3DZJbKbsIf4jhPpL1L8Ga9uFa+ypay0wYbVqO+E7rdfnahyLyY4qMFr/2l?=
 =?us-ascii?Q?bwCdSIxZfwgRdK0et/NZ6yCB3G5SQ7gYWNrYKwBF66WD7wxlk0etq9ep7Zns?=
 =?us-ascii?Q?MlT81p2ye58Tr05RtJMcU2jxTJvdk8kyw+dsSaNEOqpQVxbMc5EzyY1D/nD3?=
 =?us-ascii?Q?GRuFPYIAo3pV6nSr2nB2cDw0NMij1gQ0PmQAqUlC4nfp5ehByUlALKMwKaLd?=
 =?us-ascii?Q?Tz9f84B6Su1qMwe/NFL5NTM6gPPSsshJDPiaxQ8T?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:57.6761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e05823d-a5fc-43a8-a3ab-08de4ac988d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D0C.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB11907

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
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/ipv4/sysctl_net_ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 385b5b986d23..643763bc2142 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,7 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
-static int tcp_ecn_mode_max = 2;
+static int tcp_ecn_mode_max = 5;
 static u32 icmp_errors_extension_mask_all =
 	GENMASK_U8(ICMP_ERR_EXT_COUNT - 1, 0);
 
-- 
2.34.1


