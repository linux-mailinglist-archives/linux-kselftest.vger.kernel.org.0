Return-Path: <linux-kselftest+bounces-42955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BBFBCD1D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 15:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F08E426DE7
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 13:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C20E2F6178;
	Fri, 10 Oct 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HCf245eW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011027.outbound.protection.outlook.com [40.107.130.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4B2F5324;
	Fri, 10 Oct 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760102269; cv=fail; b=KPZ7Hso8i0qHJDlnejw7FaCxAx/YOtpdvwCTpgJmA9cGtKJ9rq70xGt+DtKhDI6IbUxkXPW6tjwaGhCChyGCIteH8XUQRJ0L7sWtbGGMnnTppj/qJyBOrN6U8DffxuPG+QOz2YbsnjPKdt3nW/HBioMDTpMEuRzHM/kqzZh7xPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760102269; c=relaxed/simple;
	bh=HyPSTrjLdRUESe2ZKeALswOpbKpbD3icf2L5lfxfaRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IC7UtQDS1fAEDUDIAG4bJ15mRkH5gqn9boymyds/v6vW0bvWafmXpkUqlz+WFRvnzNFj9NUVZla+3ZyZODirz9sbv35QSoWuD+0DYAI0Nzn0mExGSH19Ye7EH6Sg0KyZmMXAGIJLQ+92F9bj6UhA97cL6QbiKZl6joWu2voliE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HCf245eW; arc=fail smtp.client-ip=40.107.130.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuud8bGfhD8gh0AmtUUxn+3syhEZZugMWWSQimKcJAUvDYQfWl3tf4CWIXG1/9vuIqRTJ6c9vpBlxxQdWi3z1UKSBiI6YRoE3jJgbeWhbGVEWO+nQuFiyehvLZPNPV2SV3fh0GeJccwpZQIxfl2pYbkx4MCcAvcNHO4D/Gui5RwqWyF/64sjBmdxpGSD+70xV7/24FOldvd+U13CT6wSlYiuSgAhQEqO8IEcTFPOs/U+thrzKDquATQ3O2t3edEdwQ40+37+dir0UqTU0E12Akwx+MOgyNTJJrcoaYMDgqyVO67xiNvlXh/NufIoqQX3V8Bt+d4wVnI+COOOANjO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=LcW1Btb/UegZsAkAlOrC41IpbT+cGwxP4Ig2S04Oga5Iz1YSfI0w7gxKlLU2vdgt4rohCSJR1GydKSzX+xsn+GgWWmmGz/X7U5uof+kNxFN0Q1h46IYdb/U32g1Kcc40459y5Cer6VWndrBdV2o53ryPTE5KpvZ/yGg0jy3/AqpLiiwFLiLOPAZlY16DS+Pqyvd/TN2sfCzSjSsWF+el17HfdrJG/A+CbVm6+MbhV3wjC6kOpmtC+oeyFpAiNrOg/0SiFFgpI6J1jBSjheB8oKO4e1cNdMo4tCr4Z8vZTyinRA197XMwsHhwZ5+zcrknzFu13gH5wggfCPX6OCSiug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzmrsYedXbtlFC14lNlddkSScaUDfuYExLFlMph8ZZ0=;
 b=HCf245eWT+VRD5c4IzC9ur4FcqgbjYCd++Db4l9hzuVCHMfo7IGhQ4qWIj0WIj2sq7KSoKWTNsG8I8GXDYHVE8WkAHAZTpbt0SjMrlOb+TACQpvTQg9kMBSKeLB3HEaAmR0sq5OmiHNxPVTnExCuz2/kGODEjjwKqjsldQvq6LCEfS97uGz3vO6dw5eZJ+7Y1dUkG1AGQ7EW3lEhR8os5kSG19evYUYPRwapYemX7ejJeJrHu2XQEQ5VK9etV/hBmX/caLgVZeAavk+aT2eQnwaMZLFTeb77iRCMOzNZ0bG95ApjW+X7muFKj9Ix8Pd8bpPSDL7rg04u9B6svkDODA==
Received: from DUZP191CA0063.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::7) by
 DU2PR07MB8303.eurprd07.prod.outlook.com (2603:10a6:10:27c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Fri, 10 Oct 2025 13:17:43 +0000
Received: from DU2PEPF00028D11.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::fb) by DUZP191CA0063.outlook.office365.com
 (2603:10a6:10:4fa::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Fri,
 10 Oct 2025 13:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D11.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15
 via Frontend Transport; Fri, 10 Oct 2025 13:17:42 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 6E0CD1C0056;
	Fri, 10 Oct 2025 16:17:41 +0300 (EEST)
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
Subject: [PATCH v4 net-next 07/13] tcp: move increment of num_retrans
Date: Fri, 10 Oct 2025 15:17:21 +0200
Message-Id: <20251010131727.55196-8-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D11:EE_|DU2PR07MB8303:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d493152c-7266-480b-607c-08de07ff654c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8nf4E/pAn8BFrDCV8IOCDJ5sXctTWJHahfBycU67Ob4C9rKINIDpqHipjst9?=
 =?us-ascii?Q?3MYTwzVbNMyGN5jiCi1l/xEdRBsPYEtiXlxqCpcW8S3bx2+gbr2s9HG7oC5Z?=
 =?us-ascii?Q?vGQ2rdbz9mwJq6oXjcjglZ9ybXN2OVEonQhBWYqdYNgPz49rSHecYUMic/x3?=
 =?us-ascii?Q?jvuFT4RE6IjRibMvyDmS3oWqieElpqAcqubLvtJXpJLZcSiMiru9Q4UzSUev?=
 =?us-ascii?Q?ifswbmKmBmWdZlGqlkQJppJZ05esTFB6g9YT+4/g5pR6KWpaaQSeLYd8pBEY?=
 =?us-ascii?Q?t08AlRT/5zcyAJAhol7wOx3rXlrd42ctWXbBxld64t5ZlQv6iFpOOkFjIc+C?=
 =?us-ascii?Q?2XLFi1qNqaaQ0RHdO1g56rez+DIeDWCiIXErj61xlEh8ghHWmVUi9DQAGF5H?=
 =?us-ascii?Q?vXdrMTEfFLwP9rDVjZKUvIPi5II6dKbMMG/wMriypNJtlPxM6t+N5HtKlewY?=
 =?us-ascii?Q?q9iUHdG5OgQ8r69rNguLDNxcsKumjdtWOqszZ4WsHWXD2hL2qJZ7fYqM1Uwt?=
 =?us-ascii?Q?LQqhB16oL7HMW3kxGmZaeCTovYU0kmE3RTb0bfLwGOfrlJ70pEtYEZVNOa1K?=
 =?us-ascii?Q?1QKQTS8AWtBWSB/cnlsB+CaN7g4IE+1Pm2VNmlR7uzOxVEgd1t0ObtPKxLFI?=
 =?us-ascii?Q?FXuQ8s5p2ps8Drs2Mo8b1xDPRZHwwgTLGfn40fOhU5BKKXWXOOg3QL9qKZoE?=
 =?us-ascii?Q?HzG5bGJdGh0GCNbnhN8LVBnP0bsXDgXPbY2VGgguglDbVi72L/ILcIY+JiJy?=
 =?us-ascii?Q?6X3vIEOI5djtOZXMOx9+NmiJg0MDHgJIseAabfUwOHh5ARDX5XkZosJSXqKa?=
 =?us-ascii?Q?+WgyCKvnbls+Jm0p9h/BZjQWMngaF0sVrOfDSnPnNevwzfca+FlgaY3SIHQ6?=
 =?us-ascii?Q?Skw1sgV9eR3rbVwIDTf0cJRLju9KGrosR5NC+Mjs0RKQPyzRPyihwz/gCPNF?=
 =?us-ascii?Q?A9KO9xSOpTbL8DUrk8KUkFIB66yW/a5kdLLebS0jeuDdrPmurtxFNBd1LjvO?=
 =?us-ascii?Q?Dw9CQyxsXkyu3aumkCLZGHZNrUFkJ9vhgEI5p4ordZ8HOpR0Rg3Jc25gqGgu?=
 =?us-ascii?Q?bqK+1T7EgQ5HgrdMLoONC2LnAAHSLSkiGFu5agNHnp2aYkuhHaAPEmv2dl/7?=
 =?us-ascii?Q?29TkUYcbC6Vf+xxU3ymnmWI7gJZ9yObmsVtZtFo0IlUCks0n8GmtEUkxIZ8E?=
 =?us-ascii?Q?NQ39XjZgoOrDJrFBcsOHahjjGJJ9oKLJUdcyCPef6Cy6jDWbMO2z/efRCFuS?=
 =?us-ascii?Q?HVQD7BR9AjIwExAmdKYDijFg+7ZSBYKDQtJPE5SnrNrlDcbiFT+9BLuaaPI5?=
 =?us-ascii?Q?QdiUipNtS7i84e6out41LSsA48rUZBfuXngdjduKAmC3JfNnc+rnmK5SYLgq?=
 =?us-ascii?Q?luhuz5OR5cAaImOQYfV3recKIh739YzfvnWWXMN6BQEYhIwKcK91wGTZXOXC?=
 =?us-ascii?Q?XUMiogfqw66N9LyavbG1ca1g/tcAMAHR4vPf3e8XUCYDBPtQtSopI2NhscIq?=
 =?us-ascii?Q?qXM1EbBdC3ji42+ZsQP5NKH4VX0jIkLf0oKHu34s7kvaKBYWRcY0w/96Fjlx?=
 =?us-ascii?Q?VfOevJjXgp65BVjuy/3lJ9k3Rr3MgELuM77qxq/J?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 13:17:42.9916
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d493152c-7266-480b-607c-08de07ff654c
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D11.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8303

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
index 6e6fea8f295b..ef008736e3a9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4593,6 +4593,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 	/* Paired with WRITE_ONCE() in sock_setsockopt() */
 	if (READ_ONCE(sk->sk_txrehash) == SOCK_TXREHASH_ENABLED)
 		WRITE_ONCE(tcp_rsk(req)->txhash, net_tx_rndhash());
+	WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	res = af_ops->send_synack(sk, NULL, &fl, req, NULL, TCP_SYNACK_NORMAL,
 				  NULL);
 	if (!res) {
@@ -4606,7 +4607,8 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
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


