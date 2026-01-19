Return-Path: <linux-kselftest+bounces-49408-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1816CD3B6AD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137C63119A0C
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AFA39281E;
	Mon, 19 Jan 2026 18:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rjxNTUd/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4A138BDA7;
	Mon, 19 Jan 2026 18:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849180; cv=fail; b=hmQOfP3tW2cTjwP5RTQ+r2ZFKifgJUyLBBXEQwxhSHXa8HDnOicCCzEWxYLrZzlmmnJ4MsSNGjOUMR0Jgvx2WPTJfpRcGebTxF7G2T1+Ymg1lIk/ed4jCN8FSvZoeZSw+NnazI03bXilt1/awyYmwfGpebVuIo/Ag3IH4zDMrtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849180; c=relaxed/simple;
	bh=K9sp/cKFhO2N1xPzkjJWGMSrD6M/VgnZ8iPjal4WcLM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+mcUChYPo4xhxL8enOdsE0Yckiy8QbDdBuPhZ5rnSKFyKoJysBa5/hb8erzmo0n0RizZtPDcPoPeBAvrnBPbckaI4T36PeXLynM5+bZ2ZDTDXTHGL/GTfWZT7xSAL6jZjfEihNXgszoEURtRJsnTYaOcVr/WOaV0zlOXoYKlJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rjxNTUd/; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uLpmYKRI8VBZ3JepR0LoTl/zc0cp7x3YJK81RQHeCWCos1IaoXHJdV2U51S7yfShFaF1fZuon0MQG3Xt7tsuY7aLrgx9S1tJiQJHhhii3LIx6Ch5yd3cZAFHt2VvNdUXLe5mPPI1oSQdqgtXR6wqi6ZMY15/zQhxt35WpsqiQyh4p6+u6CVrR+IU6dAGe1xe8mOqDVWeDbiPLXTJPl3ZkH1lcovITH/QyYMK0pulVZRMNFfIY14R8zAGvVRaURvhj+q58Xk5LQuSUb6YlhcJvnEYhKnN7Uq0yjquDp7NF30YcVseHJXpx/wLLfzzPEZWAQZL5E0VP51OMSFPPND0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=sXxkYtcwUPkLr/xxY0VXwEgwR1O6/1MJvdAmWI6u1ONazSI6CMbVJ9g/ypna+tqOqhMsdNW4Kh5p4XywD46JZNhYBtR5hmIe6+defIqM/Plu8txxQo0j9S9zgxAjTBxLCo8qGYkH5oV/LBab5NpwVab4IqYLCJrSRDZP22L00lm0fsxOER5+fiuFbb6E0DEJ/VgNSm3aeXOAKH/VzN/SP87MymwAYvFXCM6TdwE+C2PZ/NhT07UqsdgRFuztCQyv15DovPAmhMCTZCwjnDBCP6ona7ZPBXjwuxRFaWdiEgKLCsJuJHs2dX/w4y6jR2uSGb+pWe4e9sa9FcXt7kFO5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utpWZB31jtldMqB4ZA8NQqghWs8Hn3X9j6pkTLcicYI=;
 b=rjxNTUd/TcwMpANCrFSSP2uYpTG7bI7za+qJlsSUgw8kAjoD1FQU/MrW8jxmSAR84SdezGlsbOXSeIAw+ozPTw092pzJu+8m35LP9SFZ5EGH2Ow0503PBLx9mrKf6G/Dt0pImGyfo1k7EwRA0lmDRuzyhb4v/oexZwA6jm4nApNqRK8UAvq+WL9S3ggGcvX5C57LZKSziW1CJlUr/YfVOqwzAejioXT/I53J0WpJWkb2e98SVbNXKXe1J8+UgQ33cbX/1PaOBoMwRDHf2tDHnXRNRJeraBaAC4DH4VV5JOp9f+EAkmdjlKLHhFy2MfYKxbeBvS7KuEAn5vIhHDDKdA==
Received: from DUZPR01CA0308.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::19) by VI0PR07MB11129.eurprd07.prod.outlook.com
 (2603:10a6:800:2fd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 18:59:31 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::92) by DUZPR01CA0308.outlook.office365.com
 (2603:10a6:10:4ba::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 18:59:30 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 50E34204E9;
	Mon, 19 Jan 2026 20:59:29 +0200 (EET)
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
Subject: [PATCH v9 net-next 14/15] tcp: accecn: enable AccECN
Date: Mon, 19 Jan 2026 19:58:51 +0100
Message-Id: <20260119185852.11168-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|VI0PR07MB11129:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1e55a6d4-bb65-4404-2f45-08de578ce0b2
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|36860700013|7416014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?2UBALS83gI54CAsgr9wZD9NvoaVo+sRJ4DDYshuVV8LMJuL6UHEMUKN/RBMF?=
 =?us-ascii?Q?8xUpy6Ir1/rNoe1lLRzSaIum7OnIDlbeiTxJBnq7v+LsmGbzksX6QWCPuvMF?=
 =?us-ascii?Q?X8aA/o3QTn2Jw3HWqPCozByzeclMe4iPZmcf8KOgJj5cRj7eHrc6BEh/XSOb?=
 =?us-ascii?Q?Q+1wEbiEa3WU1o9vSUxDvZACf2CmUn/H7v1I2I6vZjolYD6hjAm8GG8CTCei?=
 =?us-ascii?Q?155ouXYaY/vxPSEinKEDeRt6C5zx0Zq6OSRo1vL/aeYPU1+cxfzB6gngAuUh?=
 =?us-ascii?Q?8JcYm4aAv44favLVusFsjaTR0q3UdkHQ+O34cMuurJT8+EPwjFBEfiUjOs/P?=
 =?us-ascii?Q?DwmPXgTMLMagKeiUZhhSCkISN3k8bNA/e2DJqPGggAIMmH4G3Tr94nA0Ncck?=
 =?us-ascii?Q?3pjWiaCzRt6zE40iTeR9jCl/zMhD7IlPR+dgF81dFbDZJ/KDENMDYWZ55okY?=
 =?us-ascii?Q?GIi3klAnZjECg6btABruwtmblIejTMlGMkznSUi10fhpqsqdHatKRbL8Pb7p?=
 =?us-ascii?Q?ZdDK2VonwC1okMVtj9W931Nv6h4C5IRN/8aAz86M78BA6qpBfEzhV+sfv4U+?=
 =?us-ascii?Q?XZ9QsbX41ulhlZaDJPaKKp4qq3wN4QgH6luMPAgyFuioao8yAfHobHzNvReU?=
 =?us-ascii?Q?dbOREBMf9LTNIF8VHLUGiMN7uXoCq2ECsr61fSaec+ZHTG79Eq2B5yLxwiuS?=
 =?us-ascii?Q?e+u2lYv98U69QtAeiV0nR7ovc1Iy01Sne6ot//Zq99Bt+fTOiiLbXT34TSKS?=
 =?us-ascii?Q?IbRHVjoLXO2tv4Ai02+r2lY1+2DJvf11+dTOLamQuj3uAggOBbLMxeEHBATW?=
 =?us-ascii?Q?miKRUy1qEnd06sQGmUu+a3hsYXiaf/GyNNNMqVAH6kwv0HerEDyOTEBktfc7?=
 =?us-ascii?Q?RZH0u3JgGCr93CvclT8nBCdSRgSxTyYhFIn1CcPzt8Sdi2rqJIUScaW6mz6z?=
 =?us-ascii?Q?mgSCT1EWYYxS2eXf0osmx6ZPl656FZetNr8jeQ+hCVj9Y9Ls1VzkeIZ//fiR?=
 =?us-ascii?Q?iU7+w66OB2IJuZe3tR9+yRlH3FO8Je37ygomCY0kOIqlV2/J6qmIPwimArYy?=
 =?us-ascii?Q?dZUxFtn9H2YOq7Ev3UbJHRVb7W2gSLEenR2dlGl5zENRgHKwluPTY2QNL+5G?=
 =?us-ascii?Q?r0rlVvHEz31CiDyExKD7zELtVrolWAMTtsXoLpLa3VkH02pEHVPP3Tx/s0H2?=
 =?us-ascii?Q?CInM0MB75fGIpPOSblEVRaxybE1N3MWfWZRcVFyMzxnFnG8EAJpBBGh2rLF0?=
 =?us-ascii?Q?LBUsWWyybFMNRJ1VLwlYgQHBNMevcfpgE36O6LdKrhXahGR8OJ70jQpHSLJY?=
 =?us-ascii?Q?IYBOq46No1MphLrMSfE6jZRn3eBXfNI1at4BGDysk7S/4z3kmDPAkJs8KOHB?=
 =?us-ascii?Q?bv00HyrgqeualKgry1nqCuHq6UWl+dfItI7a5NYQTSbAXyaP3p5V1+3cuLLa?=
 =?us-ascii?Q?Vt0HHF7fendmBYGibWiBPFPq9KL4JIVZFIN0RLcfGacWJM0N46g7Dv1RfzZg?=
 =?us-ascii?Q?YIlzJrb6/LN2eGSQJ1p3BeO/jaD5vcLPRBF+ot4LhoiTUa/91sBwCcdVYaSM?=
 =?us-ascii?Q?FFogNv9AzLXGpG+mm4HOWTmYwdeeStxE5nhB6bm1Qleb3+sLnmizHG5ramoN?=
 =?us-ascii?Q?qDevXVZx8X8Ovl+N+aXet3q1GUbcBVVwNeBQcaCK8l49LLZ+xR+zoOW7q+DU?=
 =?us-ascii?Q?/a1p9WyDID0Dd6Uqw4QjqiH+pew=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(7416014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:30.9129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e55a6d4-bb65-4404-2f45-08de578ce0b2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11129

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


