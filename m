Return-Path: <linux-kselftest+bounces-41240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E90B52F80
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8286017A19A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027A31D377;
	Thu, 11 Sep 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GmxTZNwR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28031CA5A;
	Thu, 11 Sep 2025 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588838; cv=fail; b=RyPHV0MEQkQasoS5NMEOTF4+ewuWzNkzqeIMefJ4kZwnan3tYXgvueeKifnFDeUnveu8BRF5G34w4AaQvsmci1vVggc+1RdR5OhRWZpiWwtf5CVb9v0wRan9eCk0biNybker23qXedppHScfOcBefj633np+KiOTrBrIfV0hZwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588838; c=relaxed/simple;
	bh=REEmPc4Z+Rizbf1ZItQ1AaxS3ZWOhQVu0MW0tABlVvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHLW6vBnDUKL8rH4F02SUeUFySTBxgMc3FfA7eK1NtUdl5VJdDwCmd+Q4EGR1iEiFr5SQWujn0byCqpr4Zp5bWPg5apWkbfxGzpu96SJK7fqUs2zYMrwLYt7vFlj6UmTWuKgBuGmSQfrafVDSF/inWEElm9Vp2Kli+13T8hiwMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GmxTZNwR; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZoCz/moKbfA4RiVq1iVWjp/iMNJswteJP8uKJHaz4Lr8JJ8p8i6bpj0SX2+5yIeveZozZLgovu6tUCoZNAL00Ln2otZ/T/+oJjPpItiFE6L4fT6c00ypXycTEZSx2lOgU/wdbb9ma11Io218guM59q3ksoO9LxjFzxngi3Q2uAhVjn7p3j32JpX3ApLDkyYeAuLBkXiY5pncpPPgk6DDsgcO1tsql3DqZ8Y/AsMcK78VbQtktGclNzrNgXGr/U5FYVXjLbEQuueqgZl1/Cwamrvg9mjMi5eFVUTMhJcIT82+Pt7SYk0EwFxxv3i/tnXRrIurAi0+r3w8jikgMo5Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME/SzVo3o053nKNPydR5M2iAgnmoGtgSbbRAWb+7u4I=;
 b=EZ143ENqWNORDbIMMo5qtDEXd9Zocs7Mg9AnVFIGui8ONmzY3YWtVRAoSJ90AGCHp+L81mroe35P9tjkG9OiNXm7DBz6I5j3aUlmb3sgNXe+X30ZAMP/FWx956Yo33zhKp/GhL3szg+70j/nJ01wXTtqBSj2oRtHxmDuV2jV0tM8ttTu0yMTnKs8UJCgchcqido8Eo2HZzHkH3pawPfGt/zqybVsf/hDIWdvEI9uH7DCjmZcSf8sKfLfrVzQC2YkQeqc1JXOE7wZiPEP+HLaFp+WkG6f67gc+ZX7mN8KPZOCqvFpIKsBeJhZAkAynufj1iKcxustC9lKx/lYstG4jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME/SzVo3o053nKNPydR5M2iAgnmoGtgSbbRAWb+7u4I=;
 b=GmxTZNwRFOnZbZmkko16iV3leMEbFGIkJxZvclxEs1pvJSiCdVAU3SxJbY1CwivTtveuy8WS9FOqL9CUhC1W+N005hnehMvUgIdMeFlh+CJblBwiwjRAcO/q+4IDPsLnEKCyRVL9uux6E23Uc3UwQsfZESh9cCrsPl17czZrTFnAxv2PjOK6ZxqfBk39jukMiPyElql+qa0XgRHsLbFiX3DRlw+b2h3W9HloYBnems0rte/7znoPHx3jl7rYmPBwR+Yv42bXSWiaZ6/ifUcmvf3QkGu0OA20A3pgYuv+/gLikP3KTMl8Dod6LzhR31xeP31W/SFUvSClTqN1D/2MUw==
Received: from DUZPR01CA0156.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::19) by PA1PR07MB10511.eurprd07.prod.outlook.com
 (2603:10a6:102:4f0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:07:12 +0000
Received: from DU2PEPF00028D01.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::1) by DUZPR01CA0156.outlook.office365.com
 (2603:10a6:10:4bd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:07:18 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D01.mail.protection.outlook.com (10.167.242.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:07:10 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 8A5BD202BD;
	Thu, 11 Sep 2025 14:07:08 +0300 (EEST)
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
Subject: [PATCH v18 net-next 13/14] tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics
Date: Thu, 11 Sep 2025 13:06:41 +0200
Message-Id: <20250911110642.87529-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D01:EE_|PA1PR07MB10511:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fcf2327-9430-4213-d007-08ddf1235a83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dVl3YWNTOWthUXBiaHJFc2FLaWMwa2ova0dodVJUNXl5N3l4dzZnQ1JDNXZm?=
 =?utf-8?B?ck1zeVRmVzd0Mm5RdlpSV1MwekNtOGlhZld0dGhBeithdjJVZnRzY1NZWWxV?=
 =?utf-8?B?MFZOa29hVGJ2Y0d0MmZ1emRxR1ErbGkrSGttcWpSMmJZVUJEcVdCaS9nQmlq?=
 =?utf-8?B?ZWlJeEdKWjg2NVh1SGZML2RsWHRPSUg3bkw0NXU2U2VHU0VHci96WVlVb254?=
 =?utf-8?B?alkzSFhGdHp4dTNMelNLYUhYbSsvbTVpU05ibktaRVJYbkVmTloxOXhoMlVI?=
 =?utf-8?B?ZGFZMGxxU0hrQ25oaE5rblNYMnhVZzlwM2NGL1ZndWdBa2krOGMrZm9BYi9r?=
 =?utf-8?B?R1NndG5uL2NMUnZLVTdxQ2JqOFo2bkNiMldnVHFyVjVISjZJK1VhYmgwYmRz?=
 =?utf-8?B?S3JmeTUzU1FzU1ZXSDREZ2Vjc1VraGM4SlRTZGIreitNVGhBZFdDaFJxSHFH?=
 =?utf-8?B?aUhsbmlpUUxvRTFMbjlXNzEzaVVBQVJ2cDRhN2E1RHlobTIwVHpjdFFrYXdN?=
 =?utf-8?B?Y0dTM2NvWW00VzJqVWp1OFR2T0pzN2x1blZ0dHpLeTJGaDQ2SExMVGRycWs3?=
 =?utf-8?B?VGdqM1FxSm9JWTRkQytmb0FWL0VkUXdORkRpdjZUT012aWtTVWtSUWNUQzcv?=
 =?utf-8?B?NkNOdDVUNjIzQk5iMXdaS1pJcVpnNklyVlJ3N3NVZHpKaDk3eHhKcTZtYkta?=
 =?utf-8?B?YmlQVTZKZWZlQXZZbTdDMHRWRFJ1Z2xMRzBMUEZ6b05CMzdybk1uVUFmMEd6?=
 =?utf-8?B?N1JNb0NhRHdoRHFnRTVwSUtWOUFuSS84NHpjZUF5L0VIb1VzWmlPUy9YQUI5?=
 =?utf-8?B?TXRYTWVMWUhHM3ZrTjlqTUgxeTl6YW1UQnRGUThhYnZMNEpjUmxqU2c5NVRK?=
 =?utf-8?B?akUySXREaHdMRkl3VW1RVUhIRDFVeWlhSlZuWno4QlplY2N5a3NlOTF5cEVT?=
 =?utf-8?B?TS9VckhjK0FDUmtleGx5OGdUdUwzUmdXKy9HN1pIRnJ6TXAxNG0zSTRkZys1?=
 =?utf-8?B?WlJDZXVXSWl3RTRZVXVZaFhrMWZ5S1hWR3NFbnBDV2FOTUxka3BtcHNPTytY?=
 =?utf-8?B?MG1zNDRvN1dzZ3A3dno0dlgyOHQ4Wkx0eXE1K1RSSkFRZGtJT21DWUprelJl?=
 =?utf-8?B?RlB3d1pqZ0M0emsvSk8yM2h6ZktiNTJUYngzcTB6SStabWRsMmxKZkZhbGZR?=
 =?utf-8?B?WkRkWjkvNmJaaHEzWS94TlFCcGZ1WmphRDV1UUdWMnZMaUtTTXJXbmxRT1VR?=
 =?utf-8?B?bG1FZnRDdENHWEtOUHllV3plZFE4bTkzaEt2WU1pVjdCdEdBeWxMVlI5OFhN?=
 =?utf-8?B?Q0NJQk96T2R6RmlGYmFiZjk2bFRqQlVlK2M3ZmJzRFZ4T3VHZW1ycmlUazlr?=
 =?utf-8?B?QVVSTEprbmRNQWRYeXdMSEJDVEU2R3lFa2V2cThrTDVhelpYUW80d2NscWh6?=
 =?utf-8?B?MWhaQ1FmcUc3YXJKTWhFTnY5OHYyQ0xCVFptSDRIRWlKMkRJekxqZG5hd2Yr?=
 =?utf-8?B?Q2p4WlMrZDAzTFJVUG9kSnZkZWlNVk4yUzVxdVFJcGMxbUM1K2w4OWtZY1JU?=
 =?utf-8?B?NmN3TWx4VjE3Y1kxSlowTnk0SzR3blVVSmFPZFVvYWhlcHlpd25YKy9FeE5u?=
 =?utf-8?B?UU93ZHJjczFvZHFNQlcrUlNoL3V6VzRpUkRvckNnK0ZVbXI1UHY5QmxMVEt3?=
 =?utf-8?B?RldZMTltSThzcGFtTU1pcjYyWWxxaDdmdHlrNHdrRjlRZHllTlFKNVRpVk4w?=
 =?utf-8?B?T3F2OFVETERkU1Jic0Z5aWlOd3FRT2VTc3Fpek5qY2pXdDhKQjNDZGlOc3RS?=
 =?utf-8?B?ZVozalBmMTdkeVp6MFZNaXdPUzFCUXhZa1dZbjhobmcyYUttaTJnY0tjRG1G?=
 =?utf-8?B?UFJtZ3ZnOTJIQkdyalk1YTJ4ODc5bWhRN1RPTU8wek5UakYwcGFjeTdSZC9B?=
 =?utf-8?B?b2lUNUhZS3M5YS9yRXB3a1M4bmorbWFWajNOZzVLeUdoSmg5UFRFdDZNYXZz?=
 =?utf-8?B?WU01WTIyUnQ3ZE9oV0dQRXFmSW1uRWVQbUduYTBNdXFSMzYzc3JLK3JQVEly?=
 =?utf-8?B?TlRyZTBVVGQyczRrM0NDeXBqV0JuRXN0eUxFdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:07:10.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fcf2327-9430-4213-d007-08ddf1235a83
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10511

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
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


