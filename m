Return-Path: <linux-kselftest+bounces-35565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D76AE2BC7
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9DF189B579
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55853270574;
	Sat, 21 Jun 2025 19:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R3aJA9jm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013051.outbound.protection.outlook.com [40.107.159.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E321F8753;
	Sat, 21 Jun 2025 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534698; cv=fail; b=QpQV6zdHVkutRbaah966A1wdojlAkVLDCjRx07nhQ9q/sDTcl8ny9RYDsfKYE3neGAdyVdx7BqAfnbqpXQ2CzwtCq2r7mCVmjWcXAWoMNCWZcVzb5qqeeq3wR6roVVkOV3d9WIllW/0/cl8lECVy9P+5niVsH34Cxg2HUhWo4GM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534698; c=relaxed/simple;
	bh=V8jj6wEXdCVIFSasiziwiE/h7QW+uCjw67cDVA/Ah78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=in0x6xy/YbR+r9iViFvgNhS5XAP40e4OOONJ2FBg4dywn4OjC5HQ2qpD4mTfyyRjEx4V5+XHGFoCIZuLUanOdA5LjiU/NBXNwxmdU1ch/0P/T6k50pTzJvH5TUNeeJcr4IlbQkP04zv4D/UmQLvlMJTd391GReUIm/6ZtxuiRG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R3aJA9jm; arc=fail smtp.client-ip=40.107.159.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPl4Z6Y7zCfAcpj1+yPVZQM18MznMr1fPYF7NLPGp0Lkal8XUGWbt3We6d1BKee++Qi/iUKpNaNQ8xkUGXvcF3g1eK7WG8vBHo/kgcLb2g4ACpMVHtXMBwvFoiQD21vwFHXVNPLicSOO5jEYxX+7d6JoP71o3CMedE5ACYh5FIYFVWUwW/OY6WpD4eV8BhR8P6a/9OXoaiBhLe8QPzu7x+8Ny0i/i46Sjij06UmbX9SETrP2lNnkaeHNleIIRlFcQGZeCq+mtx3fKc/ciRpyUVZKKc8tG/c6eCyNZMHYLDh2obreQXCvm2S0f5+paqjRkBgagahiGemZ2DrlpJQ5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lp7Yj183TjyJfN88VdSEfBdlvIKA6DyK+node/MPShY=;
 b=jml0xqcopPLjaaXjMltmKk/odeliA4eYu9YqDmQoahCDKDzkqq0d8xYImLBYzSAfIg/Nu3pwNqwS1WWIBPwE1x0e9tOrnBV28oYZZcKK3K/Djn87CH5GvnPx4+eBD5TC+YOmRTxbWGloVaD1Xf4RoopbXm7PDhkSZbwAIVoQBuQBDeiakG7JSimOgru7WPYyCF4FbiTm3LPeXOgSaWIuW09rXkDYgHSb8/ZL8ffvpP8JwGdG3sS1xMu+7bf6mnaBS8G5bB97+fEnlCFlDRrpASfzVutY23ximIWusHaLf7uOn0udXu/H7bqlRBFEfJvWy2Z1DIzsVTSVQsYqaKBRFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lp7Yj183TjyJfN88VdSEfBdlvIKA6DyK+node/MPShY=;
 b=R3aJA9jmKCpbBRYEYp2sMU0sXvy5ppDnudmnRF7xOesprtcWaLhcPh/uaNtgF/g2TqDkRbXd/A/ZTtUv0KJU3++b8rNEt5XaUaRnZ6g3HyIa28B1ZhyTpE1xJ5wClkfL9ynJw9gbCL7dQYmPC8rCGlHBlJlKg3QIg8LYFggB0xlYO8DuUAnm9ab4VKiLwF9jSi9VSfggwGZSEbZGEWwawBd6NN66Y/PwriWrlRIlciQ4qfv/m2B7aJtEqu7cjUBsGT1lOlmGCgn3T/EMNADEVPTg+VB3Zy68EIH+Fww4z5exCIPMuRemXRw9X7V3sDMZGlocIeqmH4z6vpybAFNuKg==
Received: from BE1P281CA0384.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:80::11)
 by VI1PR07MB6239.eurprd07.prod.outlook.com (2603:10a6:800:13e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 19:38:12 +0000
Received: from AMS0EPF000001A8.eurprd05.prod.outlook.com
 (2603:10a6:b10:80:cafe::14) by BE1P281CA0384.outlook.office365.com
 (2603:10a6:b10:80::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14 via Frontend Transport; Sat,
 21 Jun 2025 19:38:11 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001A8.mail.protection.outlook.com (10.167.16.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:38:09 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 10B961C002B;
	Sat, 21 Jun 2025 22:38:08 +0300 (EEST)
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
Subject: [PATCH v9 net-next 14/15] tcp: accecn: try to fit AccECN option with SACK
Date: Sat, 21 Jun 2025 21:37:36 +0200
Message-Id: <20250621193737.16593-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A8:EE_|VI1PR07MB6239:EE_
X-MS-Office365-Filtering-Correlation-Id: 459c7ae2-0231-4afe-3ab3-08ddb0fb2741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEdmcllPWmRrdUxBcHo4TXI0dUx6TVlaVjlQS0hPcG53NmFXMWwzTFlIZWxC?=
 =?utf-8?B?QjNSSzZ0eU9xaCtEZWZiWUo3SFVWT1VSVE9vZHA0K3NzeWpYYUJsWkUvai9t?=
 =?utf-8?B?bDkrdGhzcWxVa0RnMHZoUURKSDVpaXh6YUhKcHI2eFd6Vi9KQk9QWDZxaFlK?=
 =?utf-8?B?UDFXdzd1a1hEczFKQ1dONFI3UFc3WjJRSWR5SDdSOGNFSFdnSVcxZERWN3h6?=
 =?utf-8?B?eG43djFyVmFia2ZZaHF0bVBKOHVIMndaVVVlRWF0eVNWTVlFZ3psWi9oT1Bo?=
 =?utf-8?B?dklHVUhUdjJKdlJ4UEhIZy92NEFhTkFmekdieGM3S0VTaWE3bnFvUmlJUzlI?=
 =?utf-8?B?dmMyMEdUeVlhMS95UkJvZVdYTFQ5aVcxMzZlblRKTlpuMmR5c2VnZkR6dG9l?=
 =?utf-8?B?ZGkydGlvcnFEMVBaVHNVeW4raHBmM0hDYVU1cFQ0TEpCemlDUWhZMEl6ZExL?=
 =?utf-8?B?STI3MU9Dc0g0NHJsck5PZFdXUGozVW4xTUp6OTNVWXFQYlA5UGhqSFhrWlQz?=
 =?utf-8?B?TmlvM0VHZFU4UWtqZnYvejMxcVE2WU1jOGsyM3g0cWxRVHlYQmFqYlJZNHVH?=
 =?utf-8?B?bnYwREFwUk40ZnBrR1lSbGxVZTRMRG1GbWFOeUhia1B3c3Ryc01zYjdQL3hw?=
 =?utf-8?B?UWhUTkRKaFBjMzFzSjZBdWEvNWU5eTExYytrZVhRZ09oTWJsbTRSZU9FK3Uv?=
 =?utf-8?B?bzZobHBmcVhxTU0wR2phT2tyUFhLMmgycFdaQ1VRSUE5MHY3WDh4QUlpWjc2?=
 =?utf-8?B?a3dudWRDTmZwc2k4VDFibDRjYUV2Tk96eHBhRTFoVklnZ05wSFRhUDJ4Z1dW?=
 =?utf-8?B?VE8ybjV1YXJQemxyRTlXdndwUUptL0NjNFVNb0p1QlhvSGYwNFN3a0c5ekhG?=
 =?utf-8?B?T2hRNGZpM25xSGkrNGVRcTMzRnBDejhyOWk3QUtLaUdCZXl2Wmd1TlJuUi93?=
 =?utf-8?B?bEFwdk04a2pUZTVYaCtsbTdTQ1hNVGVkY1BhRWdmbVdOU3FqazQ5bUlObTFu?=
 =?utf-8?B?QWlaVndtcHZYZzB2T01JWXhOUGJ1TVplK0VpZWJoZU01NVJBeVBsQ2tKRHZu?=
 =?utf-8?B?QVFjWE5DSFRpdzFGTUZLaVNWd2tTRmxNTS9DbGhMZVFKWDhKVXlLWXM3YlhV?=
 =?utf-8?B?a2ltaHA3bzArSzMxaUsvZlY1d2VrSXdVeHNVNTlhd3JydnQ1RGVaQlk1d05V?=
 =?utf-8?B?eWZyTC9VMzVyVStTMEl4VjMyZWNLNUJWbElFeUZXRUJjQysyNDZXYk4rNzJY?=
 =?utf-8?B?cFNmZXNBUWpJcEtYaitzL1lFMDRYNVBFUGREdW1wckdxd0pQNFlkSzZrd2kv?=
 =?utf-8?B?aFBHKy82VHNXcjg0azM1WUpGcXZ1Q205b1Nhb1MyVzE0OGZqc2U5WjJwSXdM?=
 =?utf-8?B?QURJSkpubDY2ZDd2QmpGSWlyd3ZvaENTRWlDSG41SkhUc0ZOWHkvTDNBOUR2?=
 =?utf-8?B?MGtIQmxndDJDQVZOci9KdjVpQ0N6V21YdXl0dWViUHAyUXJhMFFHdEhUVlEz?=
 =?utf-8?B?Wmo1QlI1KytvZXAwWnhwUG1BUFI0b1ZsUXNSckZCWlZTUlpOajRqbFpPMG4y?=
 =?utf-8?B?RHJFTXN4K1dZYTV0TXluVXFCd0FZVS9MQjV5VW9GdW1jYk9xM28vUGN0M3Mv?=
 =?utf-8?B?SGxieEFVWEdlQktmNkJCMjdzOUN2M2JocE1SeU0vVmozZnZMdWJqNElWR201?=
 =?utf-8?B?UGxNdGtIQ2psZ1JET2hRVmJjNE5KZ1pGT1dwb1lDU1c4bDAzeExRMjAwMXBl?=
 =?utf-8?B?c1V2TmlSY213bVVSRUZLdnZoSkU1RXBwUnFKeklCbzVHeXdjeis4MVhRNCs2?=
 =?utf-8?B?WitraENXSUtJSisyQ09VRGJ0UUFYY2c2MkZvMWEzWnN1dGNkamZBYm9tM0Yw?=
 =?utf-8?B?ZHNJdE43SG80cW13U2JFT2YvaEhMS2J5bzY3NVVkVWtQYnEyZGFWNEM3NjVL?=
 =?utf-8?B?OWYzblF5Y0liendINm13RGdEYWVSaDJzcklBNTVCbS8vbi9ZNnV1cHQ4c0dv?=
 =?utf-8?B?STNiQXBlUUUzdVlGcmkrM3hJRTdFV29RdXNnazNLOWFGcUZwdGNqQ280Wm5o?=
 =?utf-8?B?eGFML2tNWXR2R0dPaFhIRFhlMldMd1BDb0Fndz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:09.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 459c7ae2-0231-4afe-3ab3-08ddb0fb2741
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A8.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6239

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and attempt to fit the AccECN option
there by reducing the number of SACK blocks. However, it will
never go below two SACK blocks because of the AccECN option.

As the AccECN option is often not put to every ACK, the space
hijack is usually only temporary. Depending on the length of
AccECN option (can be either 11, 8, 5, or 2 bytes, cf. Table
5 in AccECN spec) and the NOPs used for alignment of other
TCP options, up to two SACK blocks will be reduced.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v8:
- Update tcp_options_fit_accecn() to avoid using recursion
---
 net/ipv4/tcp_output.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 4a87380037cb..001c883c2940 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -984,23 +984,41 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining, int max_combine_saving)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
+	int rem = remaining;
 
 	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
-
 	while (opts->num_accecn_fields >= required) {
 		int leftover_size = size & 0x3;
 		/* Pad to dword if cannot combine */
 		if (leftover_size > max_combine_saving)
 			leftover_size = -((4 - leftover_size) & 0x3);
 
-		if (remaining >= size - leftover_size) {
+		if (rem >= size - leftover_size) {
 			size -= leftover_size;
 			break;
+		} else if (opts->num_accecn_fields == required &&
+			   opts->num_sack_blocks > 2 &&
+			   required > 0) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			sack_blocks_reduce++;
+			rem = rem + TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+			size = TCP_ACCECN_MAXSIZE;
+			continue;
 		}
 
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
+	if (sack_blocks_reduce > 0) {
+		if (opts->num_accecn_fields >= required)
+			size -= sack_blocks_reduce * TCPOLEN_SACK_PERBLOCK;
+		else
+			opts->num_sack_blocks += sack_blocks_reduce;
+	}
 	if (opts->num_accecn_fields < required)
 		return 0;
 
-- 
2.34.1


