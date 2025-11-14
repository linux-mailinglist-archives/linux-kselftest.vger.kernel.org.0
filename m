Return-Path: <linux-kselftest+bounces-45625-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9203FC5BBFB
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 08:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 80A4435DB0C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 07:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AC02FD1AD;
	Fri, 14 Nov 2025 07:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="CTmlnX1z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010019.outbound.protection.outlook.com [52.101.69.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC88D2FB962;
	Fri, 14 Nov 2025 07:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763104466; cv=fail; b=arkgHaDMztRVQ7brB6vffceEfRHYORR1ie4thncQNoV7Rkit+9iTEHa3+I91Krpjxcbsj2x7sIy1hRfByYl3vlDkJc9/YFIRfF1MV1iYy+HUodD09zN7uamiEhz7Kj6aiRCWIqyApQEOEnamFn1iT5vBp2IzS96hX7FhRMVaFrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763104466; c=relaxed/simple;
	bh=ysEtE8z1ernfQZLmXOZkBhW7KEVKGRW6x2sseqULYPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rstQ7xIppbwT1K038EB019nojfFPxbGbvM1XnleuJa6OHPQBchsHypYoXJBHk8WvQ2yzd7Ch7KSeU87Iga2dDmOTxhiE36GD0acYKTdtRixKR6rFNKNhEP6nV8m6+v35Mj2z/eaGSFyemLkQAZCAGeW64Y2n9RCPbidhQhydUbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=CTmlnX1z; arc=fail smtp.client-ip=52.101.69.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDqvUJxlwyAcQ9zMDoBjhWVhHmBBnnx/bDXOj3NHDy1VhL0DAPI0vUV8L+UK7SQLqeBnv3/r4J/m4FhQoFpxN+Q/WYGZjPeq4NEHNB0SKLabxJfqAraZHTaSaMsZgMLOri9A5hEUI/wsuokN2pz/og9lbm5ydDWebdtK/ACALZ1ID80tzg70A/bB7kL+m+vWmV7FfhdAqHnTet/tQDoQKtC64NumGMg7xP/k8S8kjcdilSN2CpyKTdQ3IpZrjjK/Z6UNbw7ozmVPFod7Cx/3JagapD9TRl9YUimlzt18+yqQM8tb5bDR2h4tFNss4U3mEHKsTTWe7R5CzNJLSXlrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d6UwF4goqZJTCWoqfCv+7kw2fsKDXobIlOF3NWs9qDU=;
 b=WmRTwXNoGNAm5UqyS/Rz+tTcUdJQxumxmgkCYjPjq7CMkj2zQYE+j+ym0+mEtcVFDl5OIX3Sjx67jRve0eK60r2SMEipGP0mbEn9W5gCh/Vjpseb+asegA90/sFjbhvri+ZQum3VTfGocz9MIWRJu676MYiffZHmhP/43a+sR99NKEXi+Z0Xnqna11tZkWSwWtFmPnQqe5ZH4kMS/cucdujQrUw5dXa2EJUd9qsLMfLk1oITeiZf1h8CfSSBIINerGGqYs3Sg90U7CI7f8WorLt8ummEl/6kF4y9fqgAASxIl0bxj4zF6O1zKw9i1m4L9nTs4I2tuSKdCNdSLJ0BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d6UwF4goqZJTCWoqfCv+7kw2fsKDXobIlOF3NWs9qDU=;
 b=CTmlnX1z7+nI7ImH8SjXFcTZDHO5wiuaZDdyNnGoStf9M6IZEoTP6B6popxGZQpl1pPJLHO6w4hCUGd8zFmpumaa16oKUZEzQPBQK5FE2VJsiUJR+AHQuworEASHbA1GS0NEDMz9PBNv3GIcc27GFWREBPbgQeeLFZVtnUCzuUtMIaQBBfHTf2P8zt5eDtZN+Pb/EHX6Zo4eD6Ct7wf4kbjou40zbi76VNPbKJ5jvU7JaUswVkrcNJIBnNSJdA0t2tRntNkb4kpmxdwTY8U5Mt3rukrqr7LwRlCLHLe3xwYsooM++4E58anKjgVx/EV4Qcj3RIW4drvh/V0a0VGPjw==
Received: from AS4P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::17)
 by DBBPR07MB7641.eurprd07.prod.outlook.com (2603:10a6:10:1f3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 07:14:20 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::f) by AS4P250CA0024.outlook.office365.com
 (2603:10a6:20b:5e3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 07:14:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.13
 via Frontend Transport; Fri, 14 Nov 2025 07:14:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 0735F1C003F;
	Fri, 14 Nov 2025 09:14:18 +0200 (EET)
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
Subject: [PATCH v6 net-next 14/14] tcp: accecn: enable AccECN
Date: Fri, 14 Nov 2025 08:13:45 +0100
Message-Id: <20251114071345.10769-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|DBBPR07MB7641:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 96b5698b-9082-41bd-9710-08de234d6e84
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?m4/RwoUvE3oRNSseEsdZogAXAeFCB1uCbZ27gz+h8f1j2jHEaAbCbvtz8xOf?=
 =?us-ascii?Q?TKq9N/yeAyhxDz28jjIjS0vyeRXMC8c+ToO/k5dAF20YbhTloOH2PqNtmeGm?=
 =?us-ascii?Q?Zz7D/8WMkZ6j0Q8n9/DLIW/FkuBJPVYL9reyh/gEnKar+SRUlE0KlBUelzWB?=
 =?us-ascii?Q?qaVF3ftD3vkybiqkGW0kiMucZHwzkZF0Hj+Lh/8CHynIBFoXXPiGBHddGCSc?=
 =?us-ascii?Q?Lzchft4wcBYO5Fo18d6tPnserQQMpYPt8RpOMrAGBhjdqFZpAu8IZb16X0f8?=
 =?us-ascii?Q?UuzxH+hYGWvWR8dk/24vON8BgHSswkpKzQl4nRm0nOdcDIvGZmTdDKJwdGEO?=
 =?us-ascii?Q?C4aaE7TvrjhTG0rtxuerwx0wSzKCaV0iA6FWVKZf6YimPIWdoOa8Rby42ReQ?=
 =?us-ascii?Q?wGMUTQwIbflg510gwDLAqFzEQ3FtGFNR5Ifc4zYdv39gKr4S6SZgWDenVX4B?=
 =?us-ascii?Q?VrFAuHd/wUptYYOfAxINwfydI2j/IrChB4e7MyUG0YVD+BT92fMzMU7s6lTy?=
 =?us-ascii?Q?yr05UaAPXwiqt0S+qyj2GlTlFwma1IydjyrvhzsO55D7ZJsBRIQx5WWA9aMC?=
 =?us-ascii?Q?qHOH1SSN1JQL9TCrWrz5Z7hPDPulbzstBMlqfo/ZMMLVi67Z0b7/RIrpPa+W?=
 =?us-ascii?Q?uzcXOtPAt+sBO2pNae8VGZ9hcYMK/Y0Q80ytXrrOd2BezdOgxqeKChdRH2Vv?=
 =?us-ascii?Q?9i3xbJYN4w6s9Ci9+QI88/1RIRJn6Z/u6qyXy5aKhcK2k0KM0BGn+5SPgfGn?=
 =?us-ascii?Q?xRYPc0GU92gs6Q84DevsMF6cgpnNjh+msuTzdrRxQGOtLbrpo/x7/vMuxNMP?=
 =?us-ascii?Q?LED/lRbnp6UdhUeamhnVcqdvzECh+Y655TenAjqJ/TSQ9pKuUZsRz3EA6wGV?=
 =?us-ascii?Q?S4usAzDMrAvIGekbhl+cIZBGeWJyUcrAeRXgVjGAMEr3FEWBnGSG95oI22WL?=
 =?us-ascii?Q?tIRJw/nXw+C7vlIN7lkyb9itQR72gdqHkfouy3TI46ReYA0w9U8HbN71eM29?=
 =?us-ascii?Q?HbvS9SZvqTyfOusQ4fZ6LuENxFt60H/I5+Ma0VqGVnD8IGAfYoUBJ0ydwUcW?=
 =?us-ascii?Q?fFCWlAICdP/AMr3wprQaNXqOxLscNuT513gVBQoX6e/uo85f7XOWAde3ciga?=
 =?us-ascii?Q?AW4IV9g6TwsGSi+7OKH1qlE3K/UHNs7HReu6g5r9JPWc8PYjiiGzFFhuWlDP?=
 =?us-ascii?Q?xrSicue2XNYuI12MeUKxHZkbPPKYZj948JDh1w9MorQS4IRoSbmJu4FN2kG6?=
 =?us-ascii?Q?f9XLBzhOvaSse2mmqZbKonZ02mEPX5aFUAWhlmCS8Of46JO+ZHmHtNoAlSRn?=
 =?us-ascii?Q?o1lAFwSZCGpYgzxDvlzlx7aOFoINGCuEAF7CwGvHXuh6V/7k6autC4Sf/+Jv?=
 =?us-ascii?Q?lgJiUjllNmye/3HaD4XpdwWKZ5sA+6/K0DO3kh2kL1s4oQ8h5AAAwsgHtmxW?=
 =?us-ascii?Q?aQB70bpwcgGN1VAYmozalAeG5bIuLSF3gI9gXu8vmmoTIqe7AiB5A1Q5/AUV?=
 =?us-ascii?Q?1kLpWZFsR9UVstWkB3cpPWzgXyY3ZZIkN9M8ReNGXIsb6hye2ekZT0LvkNlu?=
 =?us-ascii?Q?FCo4/AKxAzGXoGeatlJGrt5evV/NK0wv4Xp5M39V?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 07:14:20.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b5698b-9082-41bd-9710-08de234d6e84
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR07MB7641

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
index ef21a85e021c..bde49331dc07 100644
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


