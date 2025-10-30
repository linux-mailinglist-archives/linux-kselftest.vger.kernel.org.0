Return-Path: <linux-kselftest+bounces-44411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DFDFC20A9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 15:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D13944EFCBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Oct 2025 14:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FDE2836AF;
	Thu, 30 Oct 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qHN3p3eB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010021.outbound.protection.outlook.com [52.101.69.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7E283FC5;
	Thu, 30 Oct 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834900; cv=fail; b=HcLbWp/I598zn28lla+njvX/i1pt6bKbnFP1tJutYirgS1A0hIDo7orcfVynYDwWAwaXWAQ/wHKEYyPXC5b/w5pYv0JN7emVvB6F54VvvnWs3p7fgq8miVJb23WnlI4dRSCfnuA/sAgVkX7fk3sVGfe8fIn2jloEbT3o8rkS5+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834900; c=relaxed/simple;
	bh=GeTcQ7Cr98RzPxeasujjNcocwNmZtG/Gdaik4pF8STA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ple+sviQeOAfNZvqlUlFmW4/QfoQMRdinQyhbryXEG6VF4ZgrYCGcjLJFyBl3qgblfoCuDPMmClSiDexYVEvWIDi7aXDUWTtv+QjWPZMgYePT53qZDmmfMTSChXQYDPcVZjiIlOcw0T/5wXW5fq1zWwmXcCuSGmQpCydxI5BoM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qHN3p3eB; arc=fail smtp.client-ip=52.101.69.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnAVSh3h6Afr3qmN9JarcmBtkr4NKqdnVe3XGvm6mRMWkPQzpYpP3XQocPSx5LhX3Ya/2py1znA1IIVHwy1IFRP+kUc9zsAWPDqx1ZpoFzQNT4Supyr0ztJrvUDlJvOLHke3gv7eD7exLmkNIlZO9s4EvVN24DyT5w3u7IXfftU25tYX4flUs7i7BrEUel+IV4Yyy0VSikTOAFMiLfsJkvZl31X6strWX9bC4cL8AyhcS+KZ8OjqDsy37acOw/KhGsFV4MNbO9XeAXQTueRSuTcSy1QrOaDISq4Ghw0Uh8biFIcbYUnK1rAAs9b/MrmVw7fLjJmaIf3n9XGm1+CpmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58lNnSobhs9Y81kVbO0FmLxd7z65M6EZZANnq4zBvO8=;
 b=TrzYw1wXC1zdgcL57QzmQ7lwv34iKDopdjdhLHULsZPsq1NyQ42hLMO7s+jnHciZVpmPE1uhIcBzHO0/+aDruL2babeQYPeKt1LZWL99Qc3eWxlh7x3FuXdM+0cYRQ2JaLqt2ksaMxiVEsOEHkJW+Nv5d8z2hVSPEooS102uJ00pq93oTMgZNz9Y6KtWgBzH39rotwhXpUfZWSUcHRMyFvGRLnHolqTV9MglIPn9rJPmiZZeT20wY040lk5gfWHtotec3CLIl1cR9HhyyR3y3Vh7t4C6a/DcTTyNQL3e13IpwOWzOEM55IWGBKREu2sw/5tSKwAJ9HqoIKg/bO1xDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58lNnSobhs9Y81kVbO0FmLxd7z65M6EZZANnq4zBvO8=;
 b=qHN3p3eBILQU0kEle7Wuo81VrOmNRw23udt9svjCrvzYGRWaFBgcg21vx+14WXFgNygGeVRLmUyuUltRWJXPxXcgbs+UYJBN3WOBIajqe783AolDLFN4OXs6lj3KU1E0n8iQrwiiRPlVoOq99sd8nJ1JdfKRLKHxfVSKa1f5GbUAzhqpDK5Besui8OB0HhdnrgJo8kjuwn5sbExX47b6P1ftg+vhyN4Cd7trSBPacUvdNsYRItAchoRsUhe5Q6dGAOvOnG5mK5wysj7a53YkANbizDGpnXxLF2knw3K+5+7krmRy62Mbv8LpGWleIP32CdefGOjGEXi5pOEDYsYbhQ==
Received: from DUZPR01CA0134.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::9) by AM4PR07MB11070.eurprd07.prod.outlook.com
 (2603:10a6:20b:6ea::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 14:34:53 +0000
Received: from DB5PEPF00014B96.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::66) by DUZPR01CA0134.outlook.office365.com
 (2603:10a6:10:4bc::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 14:35:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B96.mail.protection.outlook.com (10.167.8.234) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.10
 via Frontend Transport; Thu, 30 Oct 2025 14:34:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 072DE200D2;
	Thu, 30 Oct 2025 16:34:51 +0200 (EET)
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
Subject: [PATCH v5 net-next 09/14] tcp: move increment of num_retrans
Date: Thu, 30 Oct 2025 15:34:30 +0100
Message-Id: <20251030143435.13003-10-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B96:EE_|AM4PR07MB11070:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 568399e7-d898-4557-f51b-08de17c17d9b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?mwdvijW4PN8TIAyTZzUvXU2/nXw42W4IB32LQhhBJBuppJoLszJLl3TTdssd?=
 =?us-ascii?Q?dX+gVPwf9NLLQ9e46z32rrSWk9Gpj3SrHPivZeZed6m1Uv3He85Mqf2m/BDD?=
 =?us-ascii?Q?qPxBZapKC01V5n6Dg+laz9CCDwky7xOKrmiHB1glNOnrePo836x45/tjveLj?=
 =?us-ascii?Q?iaewb7HGLwyu9k//Y20ukt9HxBuu45WIAVfffLxtF6MqvfDru3RnNpgKNJBw?=
 =?us-ascii?Q?V++vnFnLP08Q6kBSOvNdPdnIsW6GfJKiJREgvAJASFRDOJUrK4a1iwmd0Ywo?=
 =?us-ascii?Q?ckF6Wqa6wgzc4SItLt2Szs6tktZOBfM2n2p9XzkRI4laMmFROcVfjFDLyt68?=
 =?us-ascii?Q?tjOlu50Z5w7mOF/tdiWHKLe0BnpS8PxTehRMe0MDYtntsPOiA7YlFqo5Z6x1?=
 =?us-ascii?Q?C8uvAml/FJKbOsZxp4T59y510f2MhhnF5bOJmq0269ia2dPL960GzCIdyyMM?=
 =?us-ascii?Q?VYAHCNoNahTEUHctbcg3hYIDKyddI4Rf47+jMbsh0scwAwq/0wBuk0+URDtr?=
 =?us-ascii?Q?YffZFJ6w531e8as4nF3usWiaH6nF4hHAYj5grnZbgAFEMSYt/bDen6aeSXfZ?=
 =?us-ascii?Q?fTUD435RBZ07LuwOqCU9ofNTmQ29tduT0zlibKHIlsqM93hs5CxPSPxLfwwv?=
 =?us-ascii?Q?KzYdsDcM/7OUcXImmomjJkC8pLeAj7pQ6l9jklCy+uKW/U0D5PNhcW5tBt4r?=
 =?us-ascii?Q?2psaplI+OTKPkusm58VhXXvP32zAOOGFBwPSmx4GYCNfDJPrJefvic+/AvT5?=
 =?us-ascii?Q?AGZhX+pM+UYo4ENfuRi8b/JZT0sXQYZJ3ZI033xoLJn3FXkWlXCgIrDBCH6a?=
 =?us-ascii?Q?mwaFbwQAvgA+saROrycocJk+NlRXvjw4ZFy9eDSTtRAoQyi1NtiJbQz1pJ/q?=
 =?us-ascii?Q?08Qg2JfZr4vBy8b6KUtVRWodq/VuTxX3UIutT3QvLlt9AETMPAfDY2UU57hF?=
 =?us-ascii?Q?NYa4IziE2fYD0ZdFEHINjcImL3PPsl4xVy5zwr5YcjG+3R9kwcfY+Pwi4Wwr?=
 =?us-ascii?Q?h7OxxSKeyYK0kDAjAQ0lwEr+BDS3WAOSxw3F45SbVHP3EIkTMNk/cXgtK69d?=
 =?us-ascii?Q?nFo4nvgpnAiEhCd7TQGu9UYNWXzO++O99efeTW/mJKSvGlfHdDESY5xrmTZk?=
 =?us-ascii?Q?OVbaSvVBgUFmxUJvcJfwuKuANZyUp+KVAnQID+eSw7lexWhveRr2VXznOM3w?=
 =?us-ascii?Q?LYzlySnJyAsF/rP3DIVI9qNlrCnle7PutmNt4nEBCkzjJEo/HLKMpRs1k/ri?=
 =?us-ascii?Q?GKn63xqfH4qimQFu9qha6CUa51i5ot8Oaglkw1rlbA2CLqKyqS0HagxFZyVF?=
 =?us-ascii?Q?IvvZUYi5a/hMyJTRft8kfRmoiwsVigV+mj9j6Hq96G4iG4aGAblD01gyE4HA?=
 =?us-ascii?Q?peBmt0XQmAXGwWCBoM1w2YQJUAGEwAawu9rJFnTEe3Pi8k7QpqF8h6QckEzb?=
 =?us-ascii?Q?v16HvmTlmNL4qJjq/p/9hcfnZPGq/hb+zzPW2tm7l7cTDsEIVWkpLIJ1Oq6x?=
 =?us-ascii?Q?hkDMXcw/FbuhOO8ve75lWnzqLOY6DJE1+nvujr314YVAtalUXndgihjlEDuj?=
 =?us-ascii?Q?T5MDSp208R1xJzYUXBz0d0qZCUBkXsMi/ODQA/BU?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 14:34:53.5767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568399e7-d898-4557-f51b-08de17c17d9b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B96.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB11070

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, num_retrans = 0 for the first SYN/ACK and the first
retransmitted SYN/ACK; however, an upcoming change will need to
differentiate between those two conditions. This patch moves the
increment of num_tranns before rtx_syn_ack() so we can distinguish
between these two cases when making SYN/ACK.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 71f65bb26675..90a71556b93c 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4609,6 +4609,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4622,7 +4623,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
+	} else {
+		WRITE_ONCE(req->num_retrans, req->num_retrans - 1);
 	}
 	return res;
 }
-- 
2.34.1


