Return-Path: <linux-kselftest+bounces-46821-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B2151C984F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 683934E3700
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 16:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFFB336EE1;
	Mon,  1 Dec 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pdrHNGxH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DAE335BCE;
	Mon,  1 Dec 2025 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764607119; cv=fail; b=O/IgIP+QD4RPhVyycAP7hF0rdhIqRsrro4Mb6hQP0kqN1VgGYvqDCMv7dLB7XZhHMKswJr3t58mlyzaLkLQfZqCwQrP+SdSSAjg5xVMaLE5eXdGDkgNvrht6pFEV35GzXV9jJhyPVFc6vPgyxwf0Us2wa6uto3A/qbWueZdUK1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764607119; c=relaxed/simple;
	bh=tzyY+z9hkdkw50AZr9DmSFBBVH7ooLduP6DKrRu6Sec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WYY14CHfFuMduSIMQ8ZOo2NH2zh8P5NrAn3vRrkl8c+AjjpdX16AEsjH+zCuIdS/epbHMzfK1XO1NMh1OIDdPf7ESkualpP0RBA3lyfQOA8GZuSHA+6LMOMJ6xAPVwqDhtvvPf6WOzNVSPLO4Do62O/Fwc5HkzL/k+yKScXNJcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pdrHNGxH; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Di5NqpmDZ+DQanxYBJRx3U6V6v92+Fyss9VrNFYtyzcoc0OshPJNE5vcBTGBtnbsxfG1HSnnNDVp1p9p1toqw+3qTEw/wKw4KiKQCr++DqgK+1USDHl1cePNPfM/gGTfABrLkIT2EXG9H+7kTIwDDsGGZllj11ZAdCQRgqOJWzaKipGHevomw9JCIh05e7Op2/bm8Rkoc8xGLcURv9Y/6GaHyGweRt0iIPppf7I+4iGgE6hEdds5edxRgBIHjwq7YySAhHnyugYfRuIUWEN2epcUnm4KF8TNx9X4KZYsRtUcXopQPwJvgs5JSfGSYKrSFGNRmKNlRP9qCcjEQJJbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQMCeUo7C0ho41PGxttWSc5zJFB1t5zvzcFlFoWJnLs=;
 b=WUQjE3p07CtpSndR0Hs40h3iNPUlwcHR0pFk6Nq12oYLHTP6EXLouSwn9Smos1a5WBJWeD9gh05N9pj70ZbPYp2ybbJ++rXHo1NisMzaAAkek8TwAcAOvdyX/jCRp1QHCSavEHL4CkDIxRsMhTr+GHMlVVY2c6iOTp2AQQ9cyv6CbFeO6lrZ6Kj1+BaI1nfGTBS8cZigc+rggYPkn0jww/M1qPu2QxhjhzgeJJCP8b+5SEkKgo4DqGaoA+xQC/51724zXJ03wVvJb9y1HtvMJoLMFgf0u32nqmgVcuJ+UKt3jCW2RZ0Zf4wTP4DKe0oddWuMP35aRRnemqV4DbpsAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQMCeUo7C0ho41PGxttWSc5zJFB1t5zvzcFlFoWJnLs=;
 b=pdrHNGxH4E2ubRLyP2NUEW79NjGdfGvee7vKIvxXRh4/iVRoXMuAJ+BfntX17EPVfrFswj+YrK4GnI9BZyvrQwiJbiFfGRvpcrK2hjWyR6XfMI3oiDXQtCvWD5CM63qJDb2xt1LTv4Ata6xUswbqpVUurwLVv04AGKUNlR0VUgIyIuwjimptfohty2d6uBO0E9DqqUXviOwkyiuJZnqYACzLgCQvczNWBQr82l8A5YOB2kM5O9NASLzlrYrmGQ8TsYIfxtpcp59qWM/uysp/Wdy8b+2hgWdcBds3W9eJmySk3l2FA4tGlAFcdGCESDHwsBhorNqNXLQgCW37xL7Mrg==
Received: from DUZPR01CA0300.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::24) by AS8PR07MB8119.eurprd07.prod.outlook.com
 (2603:10a6:20b:372::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 16:38:31 +0000
Received: from DU6PEPF0000A7DD.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::69) by DUZPR01CA0300.outlook.office365.com
 (2603:10a6:10:4b7::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 16:38:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DU6PEPF0000A7DD.mail.protection.outlook.com (10.167.8.37) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.8 via
 Frontend Transport; Mon, 1 Dec 2025 16:38:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id EA42868002E;
	Mon,  1 Dec 2025 18:38:29 +0200 (EET)
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
Subject: [PATCH v7 net-next 08/13] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Mon,  1 Dec 2025 17:37:55 +0100
Message-Id: <20251201163800.3965-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251201163800.3965-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7DD:EE_|AS8PR07MB8119:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6a1b7052-d6d6-4def-a3af-08de30f8104d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?UWr0vo/FAe2VX8xbkZRbi0SejBg3xCN7FwfG9NQaRmo/iVOw0snQ0Jh9HA8f?=
 =?us-ascii?Q?CSwDvO6kTxyZ0hJ/hIZF9w2BCmZ51r0/SYusfz7CyDdQa7ppQ4s3z8luXfgY?=
 =?us-ascii?Q?xWa6rV77GXdOhLRUALzRjHPdFZo45AYwIcTcE2TajaW+39uLPLYpyDE81+BG?=
 =?us-ascii?Q?5Qaet8rsa9oKLKK1Asu31b23UkGJd8ec+8JGpG7GvQhf/ZoqgkwAu8rxtKQA?=
 =?us-ascii?Q?Tf+N4vOekw1pPJslYdGsE5yAOsZDmjeVdBHnH3XL6wShl/ycp5Ke+4Pvx3zk?=
 =?us-ascii?Q?9fSxzyFXiA6/Kz4vwLUmN2xSIUkj1ZnMmhaZJpl9KP8tUDldOIPaWs/coupj?=
 =?us-ascii?Q?ZVRj0ZvsTEGC9yoz2TrIKvKxO3kecT/5hSMTfjn89Pudtx25t/pRcFZlpKdP?=
 =?us-ascii?Q?S7aNPSBp8ICmtXspqZLjNZkAU+RAuZwrSeV9V3/fzflBns/O4f6LBRs7dhWE?=
 =?us-ascii?Q?a7lMWplQkXPnW+CJ8uUpJTJ2LUCOOqeYIeZ6kkA1KiUoA4uWYQZL+CFeYZnD?=
 =?us-ascii?Q?d8eRZMu+NTWRziEpfCmIUfgsiGpRA+O1MVzmtyxCUafMerzxmoinEn7HgQwz?=
 =?us-ascii?Q?WGUY94i1qt7CkluS5wItW6N2W/iMI+U8jlkPDyfsM64b7u1Y7uJBIVKIKnRs?=
 =?us-ascii?Q?PyZx7XVc38RUhL7I55viM0V2R56BDD/JaXW743DMuNutEt1c/Wkf+v1rmePI?=
 =?us-ascii?Q?lJ8CJKDDPUFfYXUWL0JcT82hpraNsrQNFuhuuN7i9knF0XJZk/BXnvMO444+?=
 =?us-ascii?Q?7dHalwGNzda05JmT90FtItgAOP4pGKP2Hk7/gjqxphyWfp+w0hPi0HLk8ftS?=
 =?us-ascii?Q?45nvGaaOlej4NVqVA2//fd3ANQWds8BcfwagxdmnUVNXtUUMtojSZVY1pBRy?=
 =?us-ascii?Q?TeL/wWKkzXTi3MFQEUA031worszEr4hcgEktOnt1gFhbNCHXZ9X7/PJqU7dP?=
 =?us-ascii?Q?QfU4m7hfYvo9hDR37oX5d7qPrJTSKo62vsd+GtigH+mgpNtIap0/MxGefcLF?=
 =?us-ascii?Q?aPHvB6koWIm+o/OpdlwHv9VIJrv0xzVyyqfchPnuFXcEw1OvQnU8O8G+/SBj?=
 =?us-ascii?Q?FIQ0C7YhnlAQROfel4Sud/9GdHhzMU2ApryLjVgNMcWQq/KqHRQLtIKrUFTA?=
 =?us-ascii?Q?K3ysdBf2PkpNdc21RtpnkaXGN04KjDtelXbXgiOYvxWMPSQC51VexeCTa1Vi?=
 =?us-ascii?Q?QyHPqp9SRjeL/Oml4PWaP5Jhq2jOfvNEyQlMiUz6hYGWjM1g8K1aJ5LooUp2?=
 =?us-ascii?Q?LycnEIZIf59W6DoQ2uW9RtJOOP9idWr+G17E1tVSAzPeupODYonKoSIP4hs9?=
 =?us-ascii?Q?nwC1imhRM4stH2/4sEMXd88KOAvPxJqjKF2ILj8KG73+mwp6qGjROGCAMddS?=
 =?us-ascii?Q?4R9p+LULADMihBZ68uDpjD+9bwUA9r2D1GIlmXnIhTA/7xYKNcjLwDAg+J9R?=
 =?us-ascii?Q?aJ0aszoS+BU290BpstKIKtD+knkx7+gRw9fetYHv/F1k5hsEbJ+N2IrS1uLb?=
 =?us-ascii?Q?lGTBGu/ySndltAVF6ZuLB4Kq85KlmjQ0xSE3fIXtqq8BWytkV+nwFNLPBIsW?=
 =?us-ascii?Q?NsA6LxEMf8/wkjKxyb4=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 16:38:31.5931
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1b7052-d6d6-4def-a3af-08de30f8104d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU6PEPF0000A7DD.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8119

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Before this patch, retransmitted SYN/ACK did not have a specific synack_type;
however, the upcoming patch needs to distinguish between retransmitted and
non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
synack_type (TCP_SYNACK_RETRANS).

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v6:
- Add new synack_type instead of moving the increment of num_retran.
---
 include/net/tcp.h     | 1 +
 net/ipv4/tcp_output.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index e0a5cf2f7818..607a4cb4984c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -541,6 +541,7 @@ enum tcp_synack_type {
 	TCP_SYNACK_NORMAL,
 	TCP_SYNACK_FASTOPEN,
 	TCP_SYNACK_COOKIE,
+	TCP_SYNACK_RETRANS,
 };
 struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 				struct request_sock *req,
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 8039c726d235..5fa14a73d03f 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3921,6 +3921,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4606,7 +4607,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
-	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
+	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_RETRANS,
 				  NULL);
 	if (!res) {
 		TCP_INC_STATS(sock_net(sk), TCP_MIB_RETRANSSEGS);
-- 
2.34.1


