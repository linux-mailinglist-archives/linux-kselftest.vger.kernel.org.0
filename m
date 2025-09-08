Return-Path: <linux-kselftest+bounces-40981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4766DB49740
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8B207AF4E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3728F319871;
	Mon,  8 Sep 2025 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eFQSBTj8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013007.outbound.protection.outlook.com [52.101.72.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65051313E38;
	Mon,  8 Sep 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352887; cv=fail; b=VmUzl2VsCxyRFFJ1ihufmS/aMsjS5bPhThD/A5zaEt7vSCFVoeZOAslN09W97bPej2iEtLnXFwp8HvJM4xNrNWvKnaNpaIGefeiMhqSoI9FoCtirfqYyZ59y5kJutsAFLmJK8HFHGq8wbYFsB8bfffT8L1FZUaetOAOCY/Cbd1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352887; c=relaxed/simple;
	bh=GPX2pCdt1UKY3a2TSvi0OrmYLZZxhQKYIJsiKMU6HAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEnA9r2rzQwmc7MPEaUEDOt9zp0TXgA0GDXTHpxoeH+JmQOWLRveqJfCNWIPwricGrL/1G6BAVFZtWgnBZweSBUBADq1BmBN2Ji4KNJQ1Nl+pv3yvSt9b8bac9CConpMIEsA/c/LYwhb1H1NmFFJWIXTcVm2sn7QDxkjVvPrHiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eFQSBTj8; arc=fail smtp.client-ip=52.101.72.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yttaDQu5HElCvDKw6OdLpFu7oQlknFOv27MTT6UxsNwBIq8H/DxLto284agw6MXNFlFP/e4Ab+gU2tsP1U7T8YY42cVX2vYs29oj82ZUSdZiM7lUu87T3mBke/D1DFK+WPMAeccYtFQvqeKKEqDhLXVGrv8yWe5lupzzs7Tsa31wYym5Ww3BUE8kBChj+2+PJvkOVrrennmNl8RlneiwXF0Qc+XpGWOQrqZYT6pykpeUF8XnSvM78Gzaom6GlGA7JH/0TAb5Rpjna5MrixNwIcqi6PuEx7JKNnTJYWyEekFl/AcVi5RSWd080bCtOoKwM0zqm9ZGTew/92/LSCbAGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIpuDxOJ1kbSnDC/PlLVYqv/OtY85XWYVBo2QURaktU=;
 b=rqzSFIMVt2rsBupULZi7oFg5qgQjkmQlB1UedMPXy+52PofT4V+PFPmu1zzAVqvMibByblJ8vYxRYwaYkSLKty3U1A5wKr9NA3uOkI4umm+UuaV6hM2nKeoXSTDdgoLxSYdE1EJi9R3Tw2YhJcj+QABn9I2sksxk2JjJ25XZNYLnNRs0aWw/ImWq6aBS6086STQ4eeiHwZEn72lZNqPAB0P8sxWEa8tJJ2sxBvwK2M/LgoXHG6zSyUb29Xq/iMTGSmvNcZTqNB/0AebaDEKz9VAVGtMbpXpUHx/Avcx78PSuSf5SSs5SUnuZiJxMKq4kzCesAM0KJHrmarGetvH6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIpuDxOJ1kbSnDC/PlLVYqv/OtY85XWYVBo2QURaktU=;
 b=eFQSBTj8rgevbPoPEQzx+llyrBpzki306MHTOnRfSTEe7c1LSr0qpvtwbcY75QhdUOiLTQ0wd0eVbHmPNAkxT/trNfTd+ZHr3mfcaUSmuKWqKJiMVcjGeg04PUPJlCOoOjYW+v8jnEKwS39GPZG5fzE/aRy8mCRzfy48KgYytQ7VrEaA1zixHL6Sm0rl25AM8pbtMu+75f39vbpwyJwwph4CRQO5ZET4qo25HneJmNoANF2DzDQfGe+hkNMbe/l8vPRZGhoUf3MvV+DN998EjMSuIlFd/t+PZ7SR6ARWxca/2pQK12ZrfMpfw1eT6qFi+XZD+Su6dT7+TBaq7ZVtHA==
Received: from AS9PR06CA0501.eurprd06.prod.outlook.com (2603:10a6:20b:49b::26)
 by GV2PR07MB9060.eurprd07.prod.outlook.com (2603:10a6:150:bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:38 +0000
Received: from AM3PEPF0000A796.eurprd04.prod.outlook.com
 (2603:10a6:20b:49b:cafe::b5) by AS9PR06CA0501.outlook.office365.com
 (2603:10a6:20b:49b::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A796.mail.protection.outlook.com (10.167.16.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5E4781C004A;
	Mon,  8 Sep 2025 20:34:36 +0300 (EEST)
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
Subject: [PATCH v17 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Mon,  8 Sep 2025 19:34:07 +0200
Message-Id: <20250908173408.79715-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A796:EE_|GV2PR07MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: d77f503b-52d2-4fd5-895a-08ddeefdfc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3lxMytiQzV2YUZsMnA1Q1ZNbC95MjFFaDdTYnkrRGRndllKM1dtbVNPSGVj?=
 =?utf-8?B?OU95MzVJYzhOWmI5bDFiU2tzTnhWSjRjaXhmbDFUMmxvQzIxR0JVVlNqODBE?=
 =?utf-8?B?NXAwNkJRc0dlVUp5OUN2ZGQ5a2NJQzlST1FIOXFDTDNPc0V5T1VXYU1MZGpF?=
 =?utf-8?B?VEdVN05TRDFvMFdQYjVLN2x1QmhxcmpRTld3ano0TWx2QWEzSVdIUURxU3lv?=
 =?utf-8?B?M3VESHdVK2xPM0lHeE91SmpiN3dTRWNKQytIUmM3WVREVThod3Q1N01aeXNx?=
 =?utf-8?B?dnU5eTRGSlpaWkFZRzRiTzdBSGhVeThoSnRkaHpTZVhaaWdSekMxelRObHlF?=
 =?utf-8?B?UUtLc0M5TFNveER2TnZFZTVKVW5ZNjVSL2VBaGUvOVFjSTNzVDU4eTJkenk4?=
 =?utf-8?B?T1RDQnYrWk1GYi90K1BPd21NaTl6Q2QxbGhBbFp5bFJnMVFYZTcyVmtUbzlq?=
 =?utf-8?B?N3BhM3MzdWZ5dUd6WFVYRW1qWVFJRTlEMHhhdmw0NjlOQkx0b0JtRVUwYkta?=
 =?utf-8?B?Y2EwTnVlVFE1T0N3d0FGeEZkR25wV0kvL1R5WTFmYXJ4eEh5QTAxays1MW5E?=
 =?utf-8?B?d0ZNQVZCdWZWaXpCNnVRVUM0akhyR1IydTZPa3pxb0h2VWh5aW0rMnpZVVUz?=
 =?utf-8?B?eGtLRU1PK2hNcmhHMmppN0NaM1FPYnBYbzF1R3B0RlBGa2h0VEZZMk82ZW0y?=
 =?utf-8?B?UmdibXREK244L2JBc20xTnVYY1JIVGxIdDh4bDJ4TFJKK0Q3WlI4Z3ZJTWQ3?=
 =?utf-8?B?U0Y1ZzlKYzJpNGtlV2R6eDVxc3llOE0yVjFxK0dpWG8vdEl2VnV2SnRhWGJu?=
 =?utf-8?B?amhyRzB5Q3psc2pNSDZIVWRIaStJNXA4dDN3ckxnVSsrdU5UcTRJeVZla0g5?=
 =?utf-8?B?eFhsUWtTbmo2TEhVQnJNd3RqWkVpd08vYnJaeVd1VUVCanR5Rmc3akRGZkEx?=
 =?utf-8?B?dTIyVDF4ZHRuQ2xHWUp2WDRmYTk4MDYxYlZPMkw3WlBUcU9IQXpvWWF4RHlC?=
 =?utf-8?B?Zit6bkZFbUtGeVdMVElRV0VJaVRpSUxvMEw1N1NNRVV3UlNSckF5a2R1WWp4?=
 =?utf-8?B?UGFMTEtFLzJaaXhSOWVJR1hDQXlzSUNsdHdieGgyRU82U1pYbXFTandQNmta?=
 =?utf-8?B?ZnJlR2FpNjBXYll5UmpPcEVOKzdCclZRL00rakhuT3daV2dPV05sZnRQZnN5?=
 =?utf-8?B?R0JweWFLWE1BVDYzUEJ5VFRHR1lQN0x2UVB0MkpNRGk5T1BRS0dHVUZTcTU0?=
 =?utf-8?B?Z2pNMEQ5VkxvbGxUNmVaUW0yZlN1Sy9PeVRCMVpZRWh1VFo5YXk4ckQwVmRJ?=
 =?utf-8?B?UjNpdmI1c21vQVBXUy96NnREWE1BOGVMNHA4ZUxFbm1laGM5d3BJVXhSSWRL?=
 =?utf-8?B?aUxBOVNHb2dGcTBndTZjcHQ4UnhhRy85bXJEN1BhSEd5U2hpRktablZNbWQv?=
 =?utf-8?B?Ung0VittZmdBWmtzNmJINzVZZGtvMVZyVTNqblR3RXd5N2d0T25SbG5TTEtN?=
 =?utf-8?B?VXdxMjNaelYrbEF4R3NwOTBFV1lLU1NVcDNWNnlpQzB4Vjhtejc2MXh1SE9I?=
 =?utf-8?B?YjArWkpUZ0xKem04OXRCUmRhSlVQYWJPVldLRVJEeTM0ekpBY1JERDAya0hP?=
 =?utf-8?B?c1NsNVc4blhBTlVpNldkQ093SW83UUdTMDhOU0pZK1RxVUJnV1QyS3d4MzRF?=
 =?utf-8?B?S3JhNjIyMTVacCs1Nm51eDB5cktQUUJDdWNiM0ZjdldvaXY0K2FKaU5HQjdz?=
 =?utf-8?B?VHg1dzBEVXZjMFN6V2ZQNzdGUTBoQ25pT0hEblhnb1dRUlFhTStudmcyV3da?=
 =?utf-8?B?eXJNUjhiYWlPZnJxcEUzNkxDbTNXdFBVR1paWU9GWDh0aTVVZGRqL3Qyekk4?=
 =?utf-8?B?R3daNzRReVE4YmdJcHBCWlk0bWlvVlNlTUVMS0QvK1A4U3gxUmN4VVczdnZy?=
 =?utf-8?B?U2xrcVduTnMzb0g5dlczcTgxNVF1ZDREaDk1ZVY0Q3IrcVRvSy8rR2tUUDcz?=
 =?utf-8?B?MjZjT1NkdEpxTVlrdUhCaWpQcG8vUW15Wjh3cWNMbS8vWjRYS0J3RFlUWldw?=
 =?utf-8?B?TE1iWDh5OW8vV1A5cmdrV3MzM3I4OG1pb0NpZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:37.8393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77f503b-52d2-4fd5-895a-08ddeefdfc08
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A796.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9060

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


