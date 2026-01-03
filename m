Return-Path: <linux-kselftest+bounces-48112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E641CEFFD5
	for <lists+linux-kselftest@lfdr.de>; Sat, 03 Jan 2026 14:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59D2C3112589
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jan 2026 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7CB30BF7D;
	Sat,  3 Jan 2026 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Tqy33RLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013010.outbound.protection.outlook.com [52.101.83.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD6C2F5A34;
	Sat,  3 Jan 2026 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767445855; cv=fail; b=th10ZSZl4x9wFliQuFT8mlSdkCY8dakITh3mRiF6J1Th9MeHqzOjV2Nv0cn+bwU6IiOfoXsBtggF1LA4QqfGPYp3B6c5ytAvINVIMAnjNxAOF6B7H9BXsiX8BygAqotSUWt3X25MFlBhLkRji2nmiaOonlWMIvjCUI07QorYXOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767445855; c=relaxed/simple;
	bh=tzyY+z9hkdkw50AZr9DmSFBBVH7ooLduP6DKrRu6Sec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eQTHpkerPdQit51qOH6uL+nna6IT4RCQxbCbwAk0orodXuiTxeNu34Tfjpt/sJxPjSDB0/YoGpzM/zGqpyv5hR42FCNm8IVLrBFTUUrs/4HPaX51OuBdKvbso6U3LVQKamdTYH73h+Ye/7ZLFUxdQOAOYVZX+vZ390ZvIuKtOSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Tqy33RLi; arc=fail smtp.client-ip=52.101.83.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBFdAHGK8Dzb6Vk4fM+D2VbMz4yzOqoAcrz5PSvBdpwY0ZmQy+DitqRG93wPoWBaIV2Tv1NX/AewYKdSu6bHkjPqOXbrKZA+wPVkQVYvtDZSv/ZrYI3UmmCTuab//p5E7lBWm4+Hj0GDnulUpvXTa42jPhhUXToMeeLbdxItIhp4wpRdjAc/bdwYoz273emSP91gLjNkQkzkvMh7BwW5yhXafQa41qz/zph8yqwLyLDSqxwn3iWZyaiA2ue7uvVRMh6W2vRjfHnqx4eVLjKICjH8fzMsMlDOQFzB8OlqRQLNsNEm77Jvu6eyeBiWNwmSulmJ0mP+jOA3f5yg669yWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQMCeUo7C0ho41PGxttWSc5zJFB1t5zvzcFlFoWJnLs=;
 b=yNk/UnQZXe7H5pb7enZlXw4mvYIIgFC0TryCsVlsYUAW52peRLZKOU92GRzoPKR34uDAd6n4v1h5UOnjrBhSfmRUX2qNBA/MUsKOYgyh2uPmNNqi2mQ4VPQIoc3RS6EC9VSwT5AJtAZj8XKKjB7zEGyKMd81aTBrEinHJRqXXPQwpr3n24UGrtPPqUXXaZMGYLZKTRZzaHuwP2uf3YrhMGNolnder1tn0iZfPny0Fvj2DxhPCVtFCxebVfILj6Je3yGZz2hrlOZCOmgCuffekqtAyzCfxeMlX2HfE0+/FPBeAk6ymbF+bEivShDe2cUla3WHzhyW9sYY0YGwVC2C3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQMCeUo7C0ho41PGxttWSc5zJFB1t5zvzcFlFoWJnLs=;
 b=Tqy33RLiz9gZUeKMgyVxu4ikb+SXU0gMzDuDXNRIxh4z9gSrMXaio2GOE05hlrINxv0yEHeO8k/IsX3+MAWQ5/0VdKOxDpgxDuyBNvoe038nTtpNqwqt+fBA8VhbMCLNhKLPfhm5+++LleNgpJZpcg1FqpevDqHS+0R+wfA31Obhr8gbifaqLxUxsr0lyBRnXBbJ6Nomxq0ET4+7mhM/Eu/Wc6f+WP7mrUUe5y4E7YuVhdOHZg4MUSJUp/vZJmtSC9ghl0ntm8uJN428GQnyR1jy6sWCXbc30sL/rZxK10nn56vabFLvm6KE59K71PCv0hYxxwqik1Qto6IkZPzWIg==
Received: from AM9P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::17)
 by AM9PR07MB7329.eurprd07.prod.outlook.com (2603:10a6:20b:2c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sat, 3 Jan
 2026 13:10:48 +0000
Received: from AM3PEPF0000A793.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::31) by AM9P192CA0012.outlook.office365.com
 (2603:10a6:20b:21d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Sat, 3
 Jan 2026 13:10:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A793.mail.protection.outlook.com (10.167.16.122) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1
 via Frontend Transport; Sat, 3 Jan 2026 13:10:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id ED6E01C003B;
	Sat,  3 Jan 2026 15:10:46 +0200 (EET)
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
Date: Sat,  3 Jan 2026 14:10:23 +0100
Message-Id: <20260103131028.10708-9-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A793:EE_|AM9PR07MB7329:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ee9ebe72-b238-43d6-39a7-08de4ac9835d
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?H3f3388Nk/d7t1jl7hzLyrkNa8x68a0LN1g2hOquENQK1C4SPDZ6ZEEbQpJ/?=
 =?us-ascii?Q?b6VP/IrntuUHHWZr9+xgjkF0l6exbjgfUNywN9VFy2wrELGdi2COcO9tQTtw?=
 =?us-ascii?Q?cHd88QsYHNVHCRLyxDBc+frZUjdwvmKppzoVUCD6CwINO+9HWTsF3ETcyrLZ?=
 =?us-ascii?Q?zYI4wVfQG36ELIgLCrsfHh20BTnB3QlnwrdjMpsYwxB/wLNP035VD7Yrugz0?=
 =?us-ascii?Q?nXFNMgEh9fTYg7LiStmhObKw0QFU9H/RT3QlZ2Y24wqfs4cShpS61VAgu4h1?=
 =?us-ascii?Q?7zIaA920od20sWxxKNRSD5aEo7yVcDcs4mvadXUlxz8ZPQxNZuyoRjKpYzfg?=
 =?us-ascii?Q?68s66Dabn4ZlggIiuc0ZlKy2rbImG5CW6GVCBAR2WVID2Va8h/aLBCjGphEG?=
 =?us-ascii?Q?ds9+IKspVl6HuIv8Ib571KM3bTZr6VFABUE9vsftArwGwOIChJtdxNnzg5Xp?=
 =?us-ascii?Q?yWVLWU8Ds530KEZ5eGaFtp4EgRXFMz/vcrFUbOKnn/rmrjvoE9c7KYTBnaBX?=
 =?us-ascii?Q?8JDtKn3y3qcM3DNaNTgYTzmq68xBdPnDmwigBri6VN1sL4x01lOjrqdqoL2v?=
 =?us-ascii?Q?HJ7BKgcHMDSDbRz99UiahyU42iBebnln8SUmxQOYAWl/yyeggkhfBJUYiIy3?=
 =?us-ascii?Q?oghrEoJPc6fLmEpJHN3qNZYja9067EaciBxbev7sITaGg4oXkVDGmg4rK1NS?=
 =?us-ascii?Q?ZGOGNSSn4i2QpGW1R1s1r8eTf0OP0gVGjET8kAA5JnkK2qLfEVtv95vNh9yz?=
 =?us-ascii?Q?OUtf/h684Hh6QyS3ufsECmIwPcH1QFRPzQxJKIOcDUDhfcyCS18WQ113Dns7?=
 =?us-ascii?Q?WwHMlN7T1+2fLlK8oGbVuDlfyhldO/Q9zDoOGtPiQC6LgaDQcP/HYfLg0OM3?=
 =?us-ascii?Q?9XfQG2HtWkMorp4cIN15n3Pj66EJl5/a4CtePBnPaVT4nZpeHv5yL+Ujy096?=
 =?us-ascii?Q?UqPuC/QqOdaYPxlH+hkSqd2YCM8cBl9cCoRh5JcqrRCQKANuoQD2+BLWJsU8?=
 =?us-ascii?Q?GzKUS0UAluZpcRQ+7t3y/DPuGIUxu+yqJFmuVPjRs8m5GsdhkUQwMIVpPeNs?=
 =?us-ascii?Q?NTepVpDmPUaRKNT0tuIp1IdPxSuGGx8NTUwgZ5hH5GTLRJFafFkPxHfHJwwd?=
 =?us-ascii?Q?dEKYkEiDiS95SQ6w9z5+ky8S4UMTU3KjZNCw4DPtYDbLZBAZX6JUMnXLB74T?=
 =?us-ascii?Q?V3vMVlJ0gO2jQV6WkK2ds+HHqc/918tAT5uLM5bdTECBs2HZv+loLlK8R5FD?=
 =?us-ascii?Q?oiYcrwHk6iR9mWIWBAjw8VZinvdbggK0XTTTKBbh5g5tRT6+wLw5kG0e83rZ?=
 =?us-ascii?Q?MFveV/7FbeCMUWpQmB6cgZw4h/T5Es+V+hSEWDt6X4yFU1TEvcsseIQBdXcg?=
 =?us-ascii?Q?ACeNw+j0PBlpFnjmLhHmvj4d4zNYmJPWYQe14EzhtW7Mglyj/1yB7jrcGvBP?=
 =?us-ascii?Q?cszf/vxfCRZb8uUGqGBy8dJYLluM5aww8tfPJLkCkyNcJaONiGfSo9TA7/pK?=
 =?us-ascii?Q?JaHPIu2/SFMFkEl26+UsuN38AyjSao0E+xD0Oa8BKi4gfYZ46I8auuV1TvYH?=
 =?us-ascii?Q?xeSljMFdirGA4rFJD9c=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2026 13:10:48.5216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9ebe72-b238-43d6-39a7-08de4ac9835d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A793.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7329

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


