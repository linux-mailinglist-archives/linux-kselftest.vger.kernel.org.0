Return-Path: <linux-kselftest+bounces-40889-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C9B4745A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DE4A5886FB
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C525D2F83AE;
	Sat,  6 Sep 2025 16:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="TzZUyhN0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013071.outbound.protection.outlook.com [40.107.162.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C292F7ADF;
	Sat,  6 Sep 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176164; cv=fail; b=l1sMGM5wRlLO2YkfHG0AI+ynfRqPo51InH8UqAG/b5qo9x5luYSasAnmakMCMYZs4KjUeAjq/KUAMvcc/6+0BULpuoIaFSJATY77hP6haNiycxuBAbo+X7S/j4j/fDM3cPN832nfnoNkjVhL1anabcLMDAt92G1X07QoW1fmlIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176164; c=relaxed/simple;
	bh=GPX2pCdt1UKY3a2TSvi0OrmYLZZxhQKYIJsiKMU6HAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qawBj71JXGPRIyqJvv4pRaGhbpekpGYbqlqGzXyPO0aYwcFHdsrgHvZTXP+dqO5FbpBObM24yTtYGw5bC/S0KlxpGXHP3vAoutUGiOhPhtHEMZhiYtBgYMOFgO7xRChnspiAeXWA7lbjW5zz7lk8d79g5jSNF8qQ+BYMdi/L6JY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=TzZUyhN0; arc=fail smtp.client-ip=40.107.162.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5rYUlmXXWj0HPFCiNeqLfOq4T29Z+WK5bo5FiU9bjHcgLy42oxrFUYAasAZBuIdCu/TDtLDfbWniTzH5+F7ByD4bSl2Jt+jbF51jRHZbV2joqT9lzqtJWsqjzEE3Cj/D3c2HA6mEZzoWsKKKjAK5oDiPtAkNSXWdPGnyf1uZxGt5cqeffnL02+HhGRituYiAC8D7nqJQPx/4XtNEBQBoN7P9xjmZfrVX/xVYhW92kQbmfwZx/T0FWh+UpOsZwM/LMynjz5f+mY2DC/7QKIXvoySBwp5OF0y2t7YIM/ixMp9oNlnnP4xk2OW07KSKJFfsqSitIzjvVm1nSWcNyFC3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIpuDxOJ1kbSnDC/PlLVYqv/OtY85XWYVBo2QURaktU=;
 b=JDbhrS3Es/dLize9ZVWGuILSZ0Ck9bj9FBU0zfz24eNoRsfxJvScvmFUm0zM/CkMotgiXQKoKPdhVJx/1qtlJpStmVRr50/TfqJt7bZr8FPYZ6mzb0KXfgVQ4DWbHamchaQIROV4Q0Iv/+CSvoWlKbtBWqCTwmRBqdRrvLoeIaYLZLvS3jPfyDB+ZGeGZpDRr20ScWj838+GJDy1u3hyiOPnESbWKpVG+2ra7r9iplE6e2z2cSfeDuYRkLJ4E+IDY+3eON1lFhuVsCOFvb2c1Jmgse4cw9NIVe2Hng7VVzHBX3FM1uCvSBWGDP6xYayWHoVNTXZ/iyACELl0ryDlTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIpuDxOJ1kbSnDC/PlLVYqv/OtY85XWYVBo2QURaktU=;
 b=TzZUyhN0EWRAP0aMwE5x+umchySViV+B7PUTbojSLFribHmh5QA7KfN/cJtEt4EqjNWQcTTKmjA6BDBYEihfAm0pN7Q4Mb/amVbyirzzo5/bgzlfMVZACSeZnuj/u0iXlGvNI3ojEz/aEM+Vp48hQ9w3JPwaFq84iw/mkYN5Q/HzZp0Ggm6/aH9S1nduwAww8nVM0Mr4JQqsCbGnaYiZHhAqLuSBdGlii5owkOhbcRGp5Usz2F1QPR5MrLdgK6vG08mrDsLf2LABjxDBDiruIi8eszhgKlvVx+ssnLnJ6Jfl/cT0jA/kQySGgNAdQPhJvo/U49Ai8/8djQMvuKdA0A==
Received: from AM0PR02CA0163.eurprd02.prod.outlook.com (2603:10a6:20b:28d::30)
 by AS8PR07MB7925.eurprd07.prod.outlook.com (2603:10a6:20b:392::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Sat, 6 Sep
 2025 16:29:18 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:20b:28d:cafe::e8) by AM0PR02CA0163.outlook.office365.com
 (2603:10a6:20b:28d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:29:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 571DF1C002B;
	Sat,  6 Sep 2025 19:29:17 +0300 (EEST)
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
Subject: [PATCH v16 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Sat,  6 Sep 2025 18:28:49 +0200
Message-Id: <20250906162850.73598-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|AS8PR07MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cd28f3-d2b7-4c22-bdc9-08dded62874d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R3ViLzlLWDBtbHhZVHVZd0RKelV2alc3NnVaaUpkeE9LY0VEclp3SjVROTA3?=
 =?utf-8?B?dnZQVVlVSTRJb0xOemcwRVRaaisrdlNyZHEvUjZmdEZjdGprYlNPTGo3QXRr?=
 =?utf-8?B?bmpkMlRYUGRtb09SaTA2LytkWWJVeEdxU3dPL3dQK0wrSDVoeEJnc0RIQUdq?=
 =?utf-8?B?NjlucHBHWUhtblFJUEpCeVVpVnNod01ROVkzM1BwZUNlRnpQMURzR2k5Z01v?=
 =?utf-8?B?Yzd1VUx1UW12U1ZHSmhzaU81RHZzL3pkM1BYMTN6R0tXR2hFdHgzc3hobk5O?=
 =?utf-8?B?V3JCd0t4YXVmaXRmcmlsSzdoa0lOZ0tSNEhRUEdxUTNLVEEyU3lBL1ovd0pY?=
 =?utf-8?B?MndjSDU4L0NXeGV0dkF5UkVXZFRCRTRCTXhWQ2RDSDJXNW00TEFBbG9GWWxv?=
 =?utf-8?B?aFFsRldqdG1rdTByZkNaL0hYMGdQa3BINVVJUmxpMkY3QW0ycUg3RDlGeGVw?=
 =?utf-8?B?T01iWWliTkJGYzJTU3VTVWtZdnFtV0NFY1l4SWtBMnA5WGYvbGpIbmZUZHRp?=
 =?utf-8?B?ak9BanNlWDNHbUtSUDRjQ05SS1krd25HVWsxN3RYa1h6YzJuS0czNzNJUUFG?=
 =?utf-8?B?R3d0SkNzU3p1VDhxU24vbkZ4ZDlNS3BMTEx3OVlBcHYyaFI2eTFoNXRHdlRj?=
 =?utf-8?B?OCtLOGxNdkptdWlhN2MzNW54OUR6YzhNLzNRbWpzejJNMEduWFlucFNBMUc1?=
 =?utf-8?B?Y2xBOWhwKzZDdWFxbUpSV2o3d1loNXVPV2RQRE0xWEI4SS9pQUZJOHh5QURU?=
 =?utf-8?B?SldXVUtVcmxyUEJnZkcrWkpBWlU2NUxPS3dKYlQyYmhjZUwvcWUrYnFuL2hJ?=
 =?utf-8?B?OHBQSzRIb3hjbjN6eUc1U0kvcGJVT3locHRoZzZmVkVJdTZ5VUhEbHlpREZa?=
 =?utf-8?B?eTBBZG5NUWY2WGE2Q0J1U0Fhajk0b3Y5dldkaGVteTZuYjN1MmwxWWhlbW5o?=
 =?utf-8?B?cjRKdjBWemxYUWNsNjJQUjJYcHJwMjFHckNaRUFYZUVubGlwaGpXTm1FTGg2?=
 =?utf-8?B?dDlrS1BqbHpzd1ZiWXVmcEJrd0NGY3ZDaEN1RU52Qy8yeTM3Q1ltZlNMS1lH?=
 =?utf-8?B?aXNkbnZvNk1zWWdsQ3RLRGV5TGdUaElSQld4ZCswSmJkYmVreTlSQWRhMm0x?=
 =?utf-8?B?Q0dRdEdPMmN6OUFhd0F3UkorQVRnZmhvc1ZGVll3L1BzUkxMdlpHSUZLT2tw?=
 =?utf-8?B?SUEwOCtmRDZVZElpNk0ybjRpeC9Pc1pyMmxQRlZzVlRRME5vODd3V0crYXpu?=
 =?utf-8?B?T0J1UkZETmRJc0J5dXE4ZzVHZDB3WEpJYS83bVNqcnZGdnpUaTNtMVNnTDZ5?=
 =?utf-8?B?bVJQUmJMcW55WXdTUlpQOEIzbWN2bHZMWnJ6aEt2aFdlZWl4UnhRZFE1YTE2?=
 =?utf-8?B?N0hHTnBiZ3pZVXN0Z3pmc3RNdTE5bjdpR3ppeklCa0gxbGFvWVdaVUg2b3kz?=
 =?utf-8?B?WWRkVUp6ei95ZC93Z2Nkbysva05NcUJvVDdvemozb0RqeHIxN1dYazlhY1BL?=
 =?utf-8?B?c3F1a3M0Z2VDa1lWMFdBUXpBODFQV1NuTUJTUUptZWpMUkdOdUdnN0FtSGQv?=
 =?utf-8?B?RHZyL2w1QVUvcXNvTFc4eW8zNnljQ1VEbXhhaU80WVpBbnJsY2FiUVJzNXVQ?=
 =?utf-8?B?TjByMDRWR281dmlWbGZjUVNJTUpoYll2ODM5YjR0b3Yyam1VTm05SFN2RC9Y?=
 =?utf-8?B?QS9JUWhOTEh5dGN3VEdySkFRQmMrVzZLdDFjM3BXVGFoZHo1T2lLZWswcERE?=
 =?utf-8?B?ZnRvTUVCR0ZUS2F1ZW5GT3F1MFBvUEtPZk9EOHQ1SVI3MXZtMVhsdmVzL2hF?=
 =?utf-8?B?UUsrMXJLRVBsUGZnb09jbGNjZUVlNDViY3FOTzlCaEdDOTc1S0tQQnZ4YXlj?=
 =?utf-8?B?a2NUbHliU2VEUHk4R1FLNnlmU1VuR1VnWG1FY2hKelpKakdaNFVjUDExNzdo?=
 =?utf-8?B?VDNJd0ZubXA3b0pSMnQ1RjEya3E4NW05WjZlOEVPUW5jdis4eFh0bzdwQzNo?=
 =?utf-8?B?ZXpDcjBMZk5pVzBSbHZ0YmswS3pabkVJb29wM0Y1enpUU2JrUEszd2hWSm5B?=
 =?utf-8?B?QnFYM3dhOFhjNFd2cEVxNENLM21xdzQ2Y1YzUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:29:18.8396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cd28f3-d2b7-4c22-bdc9-08dded62874d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7925

From: Ilpo Järvinen <ij@kernel.org>

The AccECN option ceb/cep heuristic algorithm is from AccECN spec
Appendix A.2.2 to mitigate against false ACE field overflows. Armed
with ceb delta from option, delivered bytes, and delivered packets it
is possible to estimate how many times ACE field wrapped.

This calculation is necessary only if more than one wrap is possible.
Without SACK, delivered bytes and packets are not always trustworthy in
which case TCP falls back to the simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index dbb28c33ddc1..0ffb7dcf450d 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -256,6 +256,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5732f2d4329c..9fdc6ce25eb1 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -493,16 +493,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
 				int flag)
 {
+	u32 old_ceb = tcp_sk(sk)->delivered_ecn_bytes[INET_ECN_CE - 1];
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
-	u32 delta, safe_delta;
+	u32 delta, safe_delta, d_ceb;
+	bool opt_deltas_valid;
 	u32 corrected_ace;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
-	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
+						     delivered_bytes, flag);
 
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
@@ -525,6 +528,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
+
+		if ((delivered_pkts >= (TCP_ACCECN_CEP_ACE_MASK + 1) * 2) &&
+		    (tcp_is_sack(tp) ||
+		     ((1 << inet_csk(sk)->icsk_ca_state) &
+		      (TCPF_CA_Open | TCPF_CA_CWR)))) {
+			u32 est_d_cep;
+
+			if (delivered_bytes <= d_ceb)
+				return safe_delta;
+
+			est_d_cep = DIV_ROUND_UP_ULL((u64)d_ceb *
+						     delivered_pkts,
+						     delivered_bytes);
+			return min(safe_delta,
+				   delta +
+				   (est_d_cep & ~TCP_ACCECN_CEP_ACE_MASK));
+		}
+
+		if (d_ceb > delta * tp->mss_cache)
+			return safe_delta;
+		if (d_ceb <
+		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
+			return delta;
+	}
+
 	return safe_delta;
 }
 
-- 
2.34.1


