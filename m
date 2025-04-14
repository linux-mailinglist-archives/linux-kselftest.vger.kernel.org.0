Return-Path: <linux-kselftest+bounces-30946-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8089A8B7DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1383B770D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97572236A77;
	Wed, 16 Apr 2025 11:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YCYU1sz0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013039.outbound.protection.outlook.com [40.107.162.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EA335979;
	Wed, 16 Apr 2025 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804110; cv=fail; b=Y5XEi7lbtOHqnuE/9bjtm0PuJkJrsD0FYII6uMas+rAsQpIi5WnK/shjHPk09VTNEFQHwby1pu3xFXwJgA5BF/i4jhnM9IHYBNUnukVg6kq2TODKzJZL+7TJIfIHcFLqZoQ/Wr015S704EnqhXQ5ErNAmX1rcZPREE/ERJIhwSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804110; c=relaxed/simple;
	bh=O+Ij6PnJNya24eNiQTfN4/gm9ym90RRZa7lNIALkuHU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ26IzgswZ6VcsJbWzVSSLxlly35mFUziYFYfsII/9+lMuWky6JWjqy9E0co/FEmIXWK0mx6Q680/DsSRTeXiqi+aifx1wluMqQe7+fLhkCHQUgGetBqiLP9a89hiKvLe3KFghc01Tt2MQgHU5jpOifZI8YV3cWKZjBW0Z1KYsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YCYU1sz0; arc=fail smtp.client-ip=40.107.162.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o5aMjvaPgTNpKXkF/YpkP18w8waQevJ0y7hJFoZ0+qXmoB5pr0HK4Lf/fGhPYgxyQyRkiJtMIlIqq6c1sKtK0uhGUPHijmVqW1rUAZbzPKmWiwqCl8S86AugxnYhCfrW2axSUSkqLzkmlbUcoGGiv2FZC2vATYzNRIKJ99GgDlBFz4fWHIc+30eEyzCv2ZTycIUzNY1QstKLulgQMcrFp10PKIqezKjbFKXiT1O7t9a9tftLfWpF2fQaFYJRAA7f1ZUV6zNNukBfqbyEzW1d6+7xZaHXdhy13Sb7K9VYe5Bps95NjYzeZvsS5RgX5xoQaMI7RyDF1K8GnB69j8rb6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=UtueVJ705axEWt3dfbLsk7iMt09e1rgpFTqvoSVN5beevhKV7m+hCCkDDrz1IRARLTkYegwPbYZpa3hxyBVNcfZOSXfsgNVf8vqSypBVfNR68e+OH1WPcgvkclzfmI6ec6G4sovetEnuWJ9kgJ2s3z9LiLSMzM0vKVWKlMlHe1wyZC36zgR5yFS2qQWMJG3pu0AZIPH2/HpDaKdHoDWerTYcUudqdTT4P3UpIQ9v7LG5RZAcGBl4iPhaP+wh9qnjoeRAjNDBJMLTmN0EXfrzfXQqTx/b/FFa5dDV2/sGZqRuJSsjlFgZ6HcgtUcKphRtu4xbZ8B+6zEAHa6h5u53/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKL/5UK0OSKaRdCSKsrub6d7dkYoherKF2ghFpWUBbM=;
 b=YCYU1sz0GMYUq677WawjmCx7G7bIZ98Z3orMyzZ7FeoJXfBmEEnJYAmHJT0ktZZrKibqL8GO0qe3wJE2D1U3NHY86E/caG125dkdwNOngm8AGVsWDGblySmXnMcmUrE708evsdFwQKFqXSM+y75pU33qhHmkRhwvipluTca69IsDz5HKcbT7+LNy3lSOwfUWVLrg0bq7dBGphKMYXI6SyHqkWaC8fTtbbBY/3bySyxQtfrN94jV3iuOBkJs9WyknmBt3bufJaxtn+OujUH3LnkmATitj/mesKfp6MrwFJ20UXm3lyvXlpsaqSkLhpXLNwQLHi20Sq8HU+RLvTNj0Lg==
Received: from AS4P192CA0026.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::10)
 by DU2PR07MB8379.eurprd07.prod.outlook.com (2603:10a6:10:2f2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 11:48:24 +0000
Received: from AM2PEPF0001C717.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::e8) by AS4P192CA0026.outlook.office365.com
 (2603:10a6:20b:5e1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Wed,
 16 Apr 2025 11:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 AM2PEPF0001C717.mail.protection.outlook.com (10.167.16.187) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Wed, 16 Apr 2025 11:48:23 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9F5D64EF05;
	Mon, 14 Apr 2025 16:00:17 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v3 net-next 12/15] tcp: accecn: AccECN option ceb/cep heuristic
Date: Mon, 14 Apr 2025 14:59:41 +0200
Message-Id: <20250414125944.97350-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414125944.97350-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C717:EE_|DU2PR07MB8379:EE_
X-MS-Office365-Filtering-Correlation-Id: ad327d63-7ce6-4229-1745-08dd7cdc97e5
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Y0JoV3lqOC84ajU5Z29wanR5S3V0eEFRcVJKc1NRcFhab3NRY2tKTURxNjJT?=
 =?utf-8?B?YjNGV0NOT0lSZXlVN0hicHRaaEJoTnFGdUlweGVYY1kvbnlDRFY5RjZ3a3Bk?=
 =?utf-8?B?WmhkRGpQWW5Ec3NIVnVDeis0TEY2TG5EOWZSTUx2YjUzSzRxdCtrNmZGaW1W?=
 =?utf-8?B?UHJkbVRyRk5tc3o4VnJPVnlTWStBU05mM0hwNUh1UjBFb0tXS1c0R1dEN1F2?=
 =?utf-8?B?L3kzSFhtaFduZmNRUmtHTGpPL2FNeGFWbHVVODZGVDVSS0l5TjdJRXRLQjlM?=
 =?utf-8?B?Q0FnZjMwdE9WVVNSdWpyU2FRY1o2Ynp2YkxaRDYrS05YTDN3b0taNE1hczN1?=
 =?utf-8?B?aTV4RWR6ODhYWlczbnhGSmp5Y2ZvM3pibmFwd2pNN1dsemtWSUxDUFJvZ1c0?=
 =?utf-8?B?cldFQ3g2ck5HNkVoSFBDbEIvMVBCUVBWc2hocUpzeXUrZGl5aXN0SE5wN1hm?=
 =?utf-8?B?d3pWdlMrcUN0WjZmSjloaVVNWUhIT3NiNnRycHdmSG9MZ0xEN3VaUDA3MHlh?=
 =?utf-8?B?ZzVxcEZyUk5NQ1c5dXRJeUgxWTNBcjdkR2RoWDVFTFVUd2NWTCs1TnlQMDV3?=
 =?utf-8?B?bklrTnhEaDI1SFIrSHBXbUUwTHV4bnpnUGVpQ0F3Z1JFbUJZcU1IZlo1VHBK?=
 =?utf-8?B?RndiWkdCV2o5QVdZM0d0YThLcE1RMUJXeTZwcU5pa3JwQ1VESlJtcE4zUHJr?=
 =?utf-8?B?b1RFTDhHc1pwRVo3aXBtY05GVjdodnF4WmRIZC8xSnhHM2ZqbmtPelJRWjM3?=
 =?utf-8?B?bVJDd01zSnVzbmRvNVZvRk45ZmRRbG9Ma3R2azhQZ2YxYnZTZm9PWCtCSWxz?=
 =?utf-8?B?a2hCU3NMdlRuSGJCUnp5Y245R0JSNXYwUWthUkZleFNZYi9BK2tWYUN0S094?=
 =?utf-8?B?bmlLKzNVaUdwVnRYV1BSQjExNzE1N0p5TXNsQ3RYVjRPb1pWMmNsSDR2VEY1?=
 =?utf-8?B?UEFUR3pZN2hWcXNoRHdHb2RPaWk4OExIdlBEZDkreWx5MkVNK1JML0ZaNEJ5?=
 =?utf-8?B?NEpEMFlJQWdqTGpkeGJ2MEMyc2lqZkFsazFZTmZ5MkZvQzlwaGVjeVpOZjd4?=
 =?utf-8?B?WEl0NStuMHFpZ0NxQVJlRHVQaFhzY2dRVGpBaEhHYWxNbGpNdDI1UUZaQjZI?=
 =?utf-8?B?QlphTXJOY28vSFc4RkZ4b0VpWUxlWEM0eDdPNWdXWHBxWWlYZzVQa0ZDY3FN?=
 =?utf-8?B?MDFsb3MxZVdaMk9TWmsvOXg2UFlXV05qc09zMFdnUVN0SlU3QU1yWCt6a1BP?=
 =?utf-8?B?ZE9JRU4xcXp6VUxIWGZGSmtQUXpTd1RTWlBTTklrcWxVVnljNFU1dXF3ZFVm?=
 =?utf-8?B?cDMzZm9Zdnk4MUxqSjhrT1Q1clpFTkN0TTBaVUlWbTVBcW5DUklxMWZnaVFm?=
 =?utf-8?B?VHVmS0lzS2pWNjVBRCt2YTFMQW56VTZFNlFCSDAvc2w2cXdpLys5Qk9xb1JS?=
 =?utf-8?B?ZGIzZ0U2bWx5N3FuNitMZEdzc09vR2x0MzhIenRtTTZ6Q1VWb09YWGs5NGlM?=
 =?utf-8?B?OW1TZmMxdkRpRUI2OXhWcjFuSlhmRW52aFk0MmlYbDFlaTRUTFlUaHAzUkxy?=
 =?utf-8?B?Sjc5aEdWN1RDcFlyTEN2MmxNR1RiZmNQbzd4c1ZJOW9xSkdCWTBid0ttWDRK?=
 =?utf-8?B?WDMrWXpCVWdhUk5ldUVVZk5NL1pmSUFyY21MWmhvSm90UmZycWZ0bVdZYXBp?=
 =?utf-8?B?MmF6cWM0MWwwRVRJK1dEbTVoeTZlTTl1VVZkNm5KTTFiQVhoRHlvakdHYVRL?=
 =?utf-8?B?WnNIbWt3azAxYkRCa1VPM1NXL3RydUN6MUtQbGlvWTNNdWRzbkJ1aFpTL3lC?=
 =?utf-8?B?TVdSeGFIM1g2V1NhcVIvWXh0VDNDd3BJN1lXbXVjZG5Uai9QRXFMZ1FGeEUz?=
 =?utf-8?B?TFBqT25zTVZGNEFCWDNVR3oyMkp5WmxXMEJaWEI4OFpxZC9aTW44bDJpbHZz?=
 =?utf-8?B?SUx3NU8vQ056NWFlMTE2endtc3Q4ZWJwaEpsaTkrcU5mdm0rdTF5dkNacFJa?=
 =?utf-8?B?WXdENlB3YjlyQjJYMzFWazJwd090RjFqVnNHU0JZaDhSMHpUY2RxaElyVG1T?=
 =?utf-8?B?YWM2NW40Mm1CdHVRc3UzdmJ2QWIwSi8rNEhPUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:48:23.8407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad327d63-7ce6-4229-1745-08dd7cdc97e5
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C717.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8379

From: Ilpo Järvinen <ij@kernel.org>

The heuristic algorithm from draft-11 Appendix A.2.2 to
mitigate against false ACE field overflows.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h    |  1 +
 net/ipv4/tcp_input.c | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 0ade2873b84e..3ceed4792d13 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -244,6 +244,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
 					 TCPOLEN_ACCECN_PERFIELD * \
 					 TCP_ACCECN_NUMFIELDS)
+#define TCP_ACCECN_SAFETY_SHIFT		1 /* SAFETY_FACTOR in accecn draft */
 
 /* tp->accecn_fail_mode */
 #define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8f1e10530880..54f798161d14 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -694,16 +694,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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
@@ -726,6 +729,17 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	safe_delta = delivered_pkts -
 		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
 
+	if (opt_deltas_valid) {
+		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
+		if (!d_ceb)
+			return delta;
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


