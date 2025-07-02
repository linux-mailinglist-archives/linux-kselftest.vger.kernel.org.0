Return-Path: <linux-kselftest+bounces-36269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50228AF09F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43A7F480C2D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8547221544;
	Wed,  2 Jul 2025 04:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BRWWjXH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013059.outbound.protection.outlook.com [40.107.162.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF17220F51;
	Wed,  2 Jul 2025 04:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431076; cv=fail; b=DdtaEpWddPTZvL1dwJP4MYi/MSajdSLjKjPqqHLJRLeVG0ebJnGaqbh/+hItshYuVfi5duPItLNmwwaV7VQiXCSUL4Y4FBzvFfRaiCZFjoJoM8eUUEhrNI3npysPBsIfsF8BhU9uhqQ+xZWHktYVGrcmSkLwIqEBuwRXzYJWm4Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431076; c=relaxed/simple;
	bh=kdZFANffkVlmbyAcIMFzalXltaRRzTIusC03FRj2AaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzdccwRj4Iz8kWw5RiifBG0G8hecHTcWYLYaD5BJJn+ypa3fbxtoVfJdb0sAqv9WN450/LVvDH120qfsaXSFlKIm2kZJJFbqp4g+1C5oZMUKWJ/bli2LvcoNpSeu4DMwtk0BBb+fXEgO3oK7TOjeyxK2M40nWcR80c6BNtt/cpo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BRWWjXH0; arc=fail smtp.client-ip=40.107.162.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LvL/O/qRU2M4c3cKnEkpYsiWZfmBTwn/4KcsO0j82k7PYjKjzvb/c2iKR31tLVs78oamj4ugikK/KxkzR2S80Zu2TNAVzC6DOzz2gLtXRr4rmuWPmkoP8Q2R2OhhDz4m+VEED5DKVR1Blaly+RfBC7Mz0QbcIWjiN2ExmTJOgr5UKNCmOpY+ieWclHmMqbjHO7FD0eMJbXOhOJSBMoMmgw2LKkO4h3rKxoTPffuIL3zStA9IWZzp+zScsxzqPh/KEP7KG6DolYNyY605zKmZskrcoJw2wH9+vhxojh/6764GPr3kUjsigSo3cvVTGFAJitSZFf66kLoB2JtDk2VgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nKB1ok6L//Y0LrNRvzOaVHQyp8Ms7Yh+/KDS0sMiTQ=;
 b=ZJikl9OR3/WMCQ5oXsdG78HXWa8o2FpkX4sgRQ6p1QNkdK9MlzWkWeiHrDUDF3JXNWhxtnLrlPbpvd/O2aNP8oWixp5yT1YS2KLxWwZ9nfbCVtvbiFkcRNbTwkB3BSqbhhNMV97EFyq+tYORTUl9LTcz4I/fr8WqqRcLjWYZv4mGnmE3plUS7l/BoqR0jU8iqlVAG0MXZygzcXKWkLYjqKPwk35oiEUYIua7YurLfW/NgK1M4nSxebzPp1ddX4/wUVu2tvUDvWL6b6dGIjKjuugwFTjfcwyyXV46dlJhPyNIBUIfOxxs0vM3Hvr3TiBdI5wGcip37h/GuEt+0UHbcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nKB1ok6L//Y0LrNRvzOaVHQyp8Ms7Yh+/KDS0sMiTQ=;
 b=BRWWjXH00D8NiX+i9gvFhN51WYC7n38jbc7oqPpZMY4Ny6XSq95tUVZFWcA4Q+bZ2bsnJLJbfWqQW7x2upHs6j5pe/o3KNOsqqHBUcRXezCuP63JJ2ffB54hx/aNXBqC+uV97pdxEQ89S2azn0SUE/BQrLEUOdZ4hkqgwVAM/q7tIme8oeP5/pa6aeecRH/0VfmBDJgyV/QvwQ/MN0RfZRMFDTheYXjgQ01fNyahw9qnWQGCWCe0/94V+H6h9H+rq4BIkAdc4Xil27eV/x1qca9oeIjL8U34YtXWkxSs+7oRY5RWI8pD4TdkvxMb9shkGUGF0O+Gb8agRj6DeFFwoQ==
Received: from PAYP264CA0035.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::22)
 by DB9PR07MB7209.eurprd07.prod.outlook.com (2603:10a6:10:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 04:37:50 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:102:11f:cafe::33) by PAYP264CA0035.outlook.office365.com
 (2603:10a6:102:11f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.1 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:48 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4BDF51C0042;
	Wed,  2 Jul 2025 07:37:47 +0300 (EEST)
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
Subject: [PATCH v10 net-next 14/15] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Wed,  2 Jul 2025 06:37:18 +0200
Message-Id: <20250702043719.15130-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|DB9PR07MB7209:EE_
X-MS-Office365-Filtering-Correlation-Id: 9328d980-f6c1-409f-2239-08ddb92232ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WC9HazNWRi9ydzlid2VTeHc5Y24wWGVGZlpCUlpCSUNSbE9rdndqK2h2bFo4?=
 =?utf-8?B?ZitYYUpaTzV6Y0ZmSkxXMGlVZXZtcWwwYk52WVE4RldZYkV2b1F0dFdPWTA0?=
 =?utf-8?B?NEY1UlVBcjJ1RVJPSzVkREFYOEF4ekF4V3J5NkVvY252NnhlSDBMMkJObWI1?=
 =?utf-8?B?MlU2M1RLdUxZcGFWN2s5d09FdlplZWdycFZNQ2tRSXFYdDRheGozZHJWUU1J?=
 =?utf-8?B?MVpERFo4cXFTNVcxZ01hU3h5SGZucnZSeE5keDVXMDlVVUM2VmpTbUJmdkVS?=
 =?utf-8?B?WTBOY2xTUTUxV1dGZVRPUVdYNXRzTE9hOE55dXdqQnVVSFM2eHFMRVR4QmRo?=
 =?utf-8?B?eFBxUWIrZ1lvOUd2d3BMRG51V3Vqc1YvamttdGp0TjJwSVd6R3Z1b0ExcHF6?=
 =?utf-8?B?eUZINjBaUkpJVUxUTzFlOERyU25VWlJ0TXRtUU9aTXA0K3dJRndLaEVOWVBt?=
 =?utf-8?B?MjErSjZzb0lBMVdMQ3dKczFPY1dZdXlkVmlvUEppL3YwN0lYTURJSHZ5NmM3?=
 =?utf-8?B?NVVZalJ3OTZuRGFBazFrNTd4SDRTNC83eVJHTzRUR2hQUVc2YzBKNEhrdGZR?=
 =?utf-8?B?Y3laWEZOL3I4TUFSTlZydmxaTWw2YkczMGhGeHVJZC9xSFNBeExIUEcvVmt4?=
 =?utf-8?B?cnlKOEVOd0NFeUJOL0ozSGdEWTZZUS9qczZjZlNCaDg2Tk15UkR2bEtHYm9x?=
 =?utf-8?B?RW1qSzFrNTl6YmpkV3FnaWRTR0NkaDVUZFpOVEFCc2wydzhMYXp4cFcrWnhS?=
 =?utf-8?B?NlBaeElCN051anBXbTVqR0UzZXhRZkdOOVZ3NzZscGtvOWtpVnlkUHl4eWt1?=
 =?utf-8?B?MG13RjFNYUovd2V2VmowZXlEUVdjNno3QU5wa1NnWG5yNytrWHJwZHJJWDVp?=
 =?utf-8?B?RHIvYmw3eXBPRC9UQzYrWHBLZllhR2IvTDBLU1ZEWWJ3YllUSWpYczFMbzli?=
 =?utf-8?B?UWMxWExMZVp0SEJkL0tiZ3MvL1dITHhzZjNXS3ovbE5zZDJUSmtsc2V4M3BU?=
 =?utf-8?B?NlBBWXhwYWNqUi9PVkgzbXpUS3ArZEY5dTJCUzFIM08zbjVzN1VhcDBnWjJr?=
 =?utf-8?B?TS9HbWowcVBHamZ3M1duOVVDWCs0eFVHeXUvdUVDbDA3d3EyWHdGTmhRTFF0?=
 =?utf-8?B?UExvSS80M2dMNTRPSjF0NWQyaDVheXNLZnE2cDRDaXNUajlzZy9TK0EyM1VG?=
 =?utf-8?B?RHh2cEQyTzdwc1ZMd0V0bXFlb2JXd0Y1WC9ROUZMRzRTMTdVejFJU01KZkFC?=
 =?utf-8?B?ZzdTYVhhdmF1NHFXcFI2WE80YzY1UUlUVmlUN08wOC9kK3ZMWTR6Rjhma2Qz?=
 =?utf-8?B?WE5zVUhnc0RrYUJyaWVEdHB1czBlclFiRTJNRSswUnZ3TnBka3Z1c3p4R0JV?=
 =?utf-8?B?bXNQMmhXdnFWazE1eGpNb0o5NzZuc2c1OS9FWGN1V0I2VXlWUUhVdWw4S0JS?=
 =?utf-8?B?bWFkWnRVL3NWS2w5VlUxSjZ2VFVtTjJGV0hFSHY1Wk9mY3NjSUtnQVVtTjNR?=
 =?utf-8?B?bC8rZmJhVlBzeWZIdHgxeitpV0pPWmFJOXN2UCtOUGh0RXpRUDlPSE5seTJV?=
 =?utf-8?B?UVRla3NDMzA2RU9rVEliU1EvSmJMVGhwQk9sMlY0NmN6YzUxVzFXMzVXVVdY?=
 =?utf-8?B?dGJFNTE0a3ZDWjZWcG9xSjFNalpUNGZWVWlMRE43dkNyM2xHT292QmF6aFlm?=
 =?utf-8?B?RGFxd21ERG5JdkZYT1JjUU52ditkeHE1NmNGcGdxbEdUUE9oVmpoVXZSTUFx?=
 =?utf-8?B?WEJ4QnpUNnJZK0kzcGdPd2Z2M01TOU9kV3Z1TXZlc1JCZENoSk55SnFCZW0v?=
 =?utf-8?B?WmcrZFBQTjBFV0I5TGVXQnhITEV3ckdBM3E0Zzk4YXRnSkpNTXQ1NW1MSG0w?=
 =?utf-8?B?empxMGFiOVRIMUJMRmhwODdla2t4TFN3Y1g3emw0RzhGWW1LcGRZQytCUjFR?=
 =?utf-8?B?bkFpSS9iZVBiTFFWWVJZbUI5eVplUDhVQW9EUTZKQU5hVFBHcEFVUFJOTWJh?=
 =?utf-8?B?L2lSbytBQ2JtQy9qcTZ6bmF3bUdCNWc2K3FuaDlZZUFzZk5ZOHpDVWFDeURD?=
 =?utf-8?B?Sm5mLzBzaHNaaldSdUdvaUtYc3NSV1psdk4yZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:48.8531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9328d980-f6c1-409f-2239-08ddb92232ec
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7209

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
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 36 ++++++++++++++++++++++++++++++++++--
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 014a22aef25a..120a8288a0a3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -246,6 +246,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 5a8f5ca9efde..094645e0d9fc 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -492,16 +492,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -524,6 +527,35 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


