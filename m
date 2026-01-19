Return-Path: <linux-kselftest+bounces-49404-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EE5D3B694
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 20:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4637E30700CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCEA392828;
	Mon, 19 Jan 2026 18:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qkuJvCnY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012008.outbound.protection.outlook.com [52.101.66.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7029938F953;
	Mon, 19 Jan 2026 18:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849168; cv=fail; b=fL11GYs0v+FNT1h9+tRSL2qiVK5UnqQM860Qwn7KljmVNoiDsc/Ijkr99ScQsdJnwNMGYVhMTViKlTsdS+qitridtOjGOGTuCf8rFqH5+7VomfnEPN2d9lwxi+Fne1jBLotJjDAo9Au8qDWSqJA6AlCHtO+mp/2S92iwxS2K6eA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849168; c=relaxed/simple;
	bh=ZaUmMryssnBkimhjq+dg6ZQVdLJrJFihfHgYhAyiXBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6ZUReS+aYBzOY50RHV76cqk41ZX2vvmt5KS5OTlkBVznOQodqbyL/DJnvkHOmKH4nen6Db+i5StiSnhEr4b0rGh4gW+Hsh88KIi8noNMEliI/o+TEgUNh7rrkXiqNqgQbg8pb3iwRfcqxNyx0sP2sEHmfhkB1QH4NbTg+WGPoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qkuJvCnY; arc=fail smtp.client-ip=52.101.66.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcbe70On7TvPH4sjH0osaoJqqfM8jVyWIhzfj+Wgn5Xt74ZkIGpF+1XDqR61/B6UFiG+iQ8S7S5Fk2s55oqi0LiAL3MV7icCtzGxl4UbSo/XhldHlDEXOMrniNF8Fiskc+M6ocN/4pEOPegTFSbiBi3O489Cth7jxJLy3/lKMsrDuY1safYcTfJCXW/zHzGfz2gVPqf5v6nngIZvwY9/dqI/zRXZu7V19np/pMB+53U/3LD1NaQ2DtEh4hUfpqL5Nk6WldzgEESFYPATH9LrhV5Sq2WkcqQL1FQL/7+zvM/GYUYBAW2+EdDO7QbrA3rw+K7bgjk1rK5qEe+gTLzrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDpz0wVie0Tuq3kT00oWsSRc67BczXrg0GBNufK69Zg=;
 b=ygPUnL2HjPuhNx29Wz+79MchGbx0/1XwFsiBg1tEWk2KNx8hFP2mn0WBk1D+nZYevm26lp5Jcgmq2ufkEK5DSn4S6wv3BD4UC6bZ4sMOIcn4lUJyfUBSzhkqtmgDioqLeSzCX55P8XVHoFbfC5GU1m3rp+pmI7FOsdEXCdZ8+LUL7LgjxS6/T/jv5nt9blSLaHu5/nprU5g8Q8gX+Q4hs7DuvSfZQvXQN+nSFLKXUtauXG8y2GQ6pdYTtaN4n1FNJn/vjhvJ0MK5AacH0t2hEIPa+usRJqV8+FRv1ToIgIi9mhLO2q7uCJZUQ6cdqEdGPICbfhERsxRhUu+EEvX+/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDpz0wVie0Tuq3kT00oWsSRc67BczXrg0GBNufK69Zg=;
 b=qkuJvCnYCo1ldRBQNKVxRGRZ6bWbVGXzpCbmprJ0CPsbfbzb9/ncw1inLu3jnYRow1LQNnxlvk77JQogKvQVaTspY2/iW4XPfk/h/WLGkrYfilY+CPB+ApplzVclLAxzM/I58j2gi5+GC8Mtg5wZRhIl/iQqaztBEZu9gsxXEmtOYi0adE3XCgPLEnYDeUHckOy+i2DZ4h9bTBy7w8PnS9/+3HFILAWvcFORAiUZvo3yjCVr55GNS2L5oNzDhNawyVSxLL9DepcCHmNf3yJdsoLZKEcKSEciCOGLqJr3vaCioHImZhgkbMc/t6n7XO+mhsza/a58LsyDTNVjz2MKzQ==
Received: from AS4P189CA0068.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::23)
 by VI1PR07MB6269.eurprd07.prod.outlook.com (2603:10a6:800:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.9; Mon, 19 Jan
 2026 18:59:15 +0000
Received: from AM3PEPF0000A797.eurprd04.prod.outlook.com
 (2603:10a6:20b:659:cafe::c9) by AS4P189CA0068.outlook.office365.com
 (2603:10a6:20b:659::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM3PEPF0000A797.mail.protection.outlook.com (10.167.16.102) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 18:59:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id A43DF2014A;
	Mon, 19 Jan 2026 20:59:12 +0200 (EET)
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
Subject: [PATCH v9 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
Date: Mon, 19 Jan 2026 19:58:45 +0100
Message-Id: <20260119185852.11168-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A797:EE_|VI1PR07MB6269:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a767b975-7ea8-453e-cb75-08de578cd70e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?jHdhNrtBN+0XqAJkBFvBqoaFNC4wT3YwnkdtomIOfqHwne2qiolrVlStOv9S?=
 =?us-ascii?Q?kiBXn93YlKlM98CFyKTFGrW9JGsmH+hI8URlFH78kF4PFnJPo8FJBkWg+CXa?=
 =?us-ascii?Q?BwwrNo530cqovD+5y+gYPuG7+d6Yr/n6DnUd3sMM+vJN+SgMizp3SVcjjabT?=
 =?us-ascii?Q?XWkXFS7g5oTq3vSGsqy4+oMCKMa2Bc/2C9iGKJmEgtWB08qv33OpTdeVGyEY?=
 =?us-ascii?Q?EQPpAd8dU3ABReFnGnK5OtMU65ielLNZS56w6Xeg2N+LTUNV/kLj2dYvwJ00?=
 =?us-ascii?Q?VhI8DeNdhVftSS4i7MwH7dC95FqB/WErZglrqm+uhCBrTzjT+kGqY0JjwMVu?=
 =?us-ascii?Q?MRFzbQVd3zNnubETywt3FAJyFIiiglZ2RSSS5G+yVNPj8LArC2Ez04AdhN5J?=
 =?us-ascii?Q?e1AjQvor9J7pjs83XQGf41hyEKWRvUQATOIjz24obamrGvSK0PF3j34bOZgb?=
 =?us-ascii?Q?FLvoHA1FrxlMIX9H6u+lD+p/082wNVhsXFIxAc+jgLn+bzNHgs4HY8wK+9ah?=
 =?us-ascii?Q?mGpd0O6By5D2feFHtmIMj42ef/ZVx27af0AYKStIwmwyAfjVd3OYxpmoABe0?=
 =?us-ascii?Q?TRU0Pc9CNb+C04Yh7jbIImcGQH/sLrzzDhoAXM45OUWmLseMiqs1IQ7YNZCA?=
 =?us-ascii?Q?f3AdN/Q6VpF3WDYzKNyZHNonv/XQ4ni0R1kdvP5pb4HoIjT4ygCR65VMHxol?=
 =?us-ascii?Q?oOE/K5JevmVzk8O6/gLOhNhdRsfBJErPaG1rDgdH6MfPK2w8Z+Z3t+5BoVAk?=
 =?us-ascii?Q?fy3JAj4eeWnsQiQ98rbqr5397nuuT6LMLGQaOLh4eM/pSvBOjvWqV5FRSoPU?=
 =?us-ascii?Q?j3PLpLR5AqKgvAfSR5xUiW/BvxKnlaUqGRGwbKj8wpTXs9McFiZPs2LZAkKN?=
 =?us-ascii?Q?f1wF8uG3/F0NUOx57f3iMkPUlEbs0kXiDqnp8eUrD0GAbn76eeO53EFJwcSu?=
 =?us-ascii?Q?+BXfqmqXsttdf7E4DxmFsMZmphlFCSPbMQqCC9sp6EbprQL/n7iV7Xe+Tbx2?=
 =?us-ascii?Q?efNFRfSK+WDm3UkZepwyhk13K5yemqS2p5Eg+A+QlOe1IlcyW8ohVTTgM1yB?=
 =?us-ascii?Q?g6snkgga2cnInn8Ydn3os8UB3WxOsdhI89hTzJJ470Tm+mOJUiWFw2ga4FV8?=
 =?us-ascii?Q?euC+J7BIad/2J3pSUSTOPo+ggkVjfxMoZveEoCK1bwtgibuBy6nvE/tPDBaK?=
 =?us-ascii?Q?YOOKC5DFvbTDtluy2z9PLZ6t3KnAxqBft3WejUlAHOWVLJwuoMi/Yl9y2fDO?=
 =?us-ascii?Q?CzE3V6qCgyO/rr4xLDnk/Kv/vI9dZLwl7ljkArZpHhmkX9qt0Zo+7CoY+MD0?=
 =?us-ascii?Q?wOD6oulPKGVu/qdIe19dgEgOboyIN5tjWF4ygEK/ynN2uY4z+l6zSt8mXJyJ?=
 =?us-ascii?Q?HMF3No/swJ5b0WtVISEa90tYy+3MJjCeMYs4eThWjk79ArKzH4Emv+X4aolt?=
 =?us-ascii?Q?PygFfIJu62sNhMkGQl/j/qQHqOCVa3sDC+K3uyRhbrMXhgT//QUi0C6KInjF?=
 =?us-ascii?Q?7xwhnWabEeIxdW6WNeLrn88Ss7S8Q8YeKxN4/Vp7OtbfW1ASeNJjSnLBOxyZ?=
 =?us-ascii?Q?DN7nPlX2RJu+3rw+Yq98igIHq+R+XFD2EFAph3owGwfyfp6Vq6mBlK011sUh?=
 =?us-ascii?Q?N9RCnvsBMc9KXCQvVBQVFBv7Kx35TTXOBsRxBz2Iy7AlTi/Q8hri07gWK3iW?=
 =?us-ascii?Q?M/AoYg=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:59:14.7575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a767b975-7ea8-453e-cb75-08de578cd70e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A797.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6269

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
index 426571272688..96c3b27de0f5 100644
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
index d5d695a501f8..329e7e461c52 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3956,6 +3956,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 
 	switch (synack_type) {
 	case TCP_SYNACK_NORMAL:
+	case TCP_SYNACK_RETRANS:
 		skb_set_owner_edemux(skb, req_to_sk(req));
 		break;
 	case TCP_SYNACK_COOKIE:
@@ -4641,7 +4642,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
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


