Return-Path: <linux-kselftest+bounces-30947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1533A8B7DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 13:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 077801904BDA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 11:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C403323FC41;
	Wed, 16 Apr 2025 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QcOgnbR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2085.outbound.protection.outlook.com [40.107.241.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8902229B1C;
	Wed, 16 Apr 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804111; cv=fail; b=KqNdokJCnDnKulVOTRsAOYMvGpiWQ4PLsCso5W8ktISCErRh2jZwgmXsu9btept89aW5LF9w8A9MatzqooA0ZfOZ9+/BcxWfIfv18Wg2PHIzOnRXnimJOBwuF9YdxMTx6Y8qtpnvEs+qSsiMpbmrqw2Na1AS7v9b+r7U9r+UmBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804111; c=relaxed/simple;
	bh=I4ubTWT3RFl5BeQzn9ugdonkuIPtlIVxMelUvF756Yk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXOPKYGK9D5KgN8kqRsE9PPS0Bs+KzbxQC/ei+fTiOd3pdACodcKPGie/MyArDwZpFQ6hctFYxw/Jy9bcrAos7zPdUAZpOo3IvHZoAWZxfIaHQvQvoH6n9lrugPVOY/9wEcceZ6pOFpzpmSv3titZCs8ChJl9WZuctaRTTG6WLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QcOgnbR2; arc=fail smtp.client-ip=40.107.241.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y333pHtalJfPMQLCOXFJ3BIYO4IoycV0w71deRUJcSCPPig08nlRWFXC1WRuxk3IMCuKTiwMQdsyMJmko/XlrXFkwXgdixDxRX5GAIzt4avUxObcuKpVc8KcBx4/On6KF0hLH0NlKnOwoaswndni5plx32hAv4P6rLrUr/kOQktMIFP+2ie0KrVDnL6HxbubAD2t3RK5corgjTTBJ5l81qcJ3U7v7srdRTOeJgL3k+GVXPq7IHzxF6WkUyuVeP67Cz9Lv54z5WbaUmQHcN1me3DNKyOa/20mY/PI6sUr1iX0iTt27EP6l7nNm/NNvlez7BCxfDTdZBbXy6MiZdZzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=t2zRfOsKujnwCDR556/Md0DVT1Pk9abJcjh2HD1FeGCRiXpE73segb6ROfd13Qr2A/c6BagWZEIhNPLcOSEJZ3q52y5bd5mFXiqBsSDilqaJgz5aUJNGrMP6VP7i4BfoFedXNCvuzaQriewUuJekjm0iNV9gPhspPUPZDn2c2bU8dBDpox2qln8pRluiRyFQxQIJk4toxbdsJND29xq724GYSquyDOEcD5feiqOLP2A5TrlpdkjHAgI2K09KDhH7zMITIOP1fiyd6watxxjOJ5ntXFaxyr9t0DZ3w7BfD6CHbWTu9Z4cFjAj+JLCc9xllDZFwqF/eQZHHKcuWDsviw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.20) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjzGCXWtVKbrVv/LQ94yH6VK8X9J1eeWY+M2JK853FY=;
 b=QcOgnbR21SQBMTN6AG9930rZuVqWJn3WodL1O9v6AvP7B7kIOKdKZUMPxfuLxUrNGpuXoqUa3yjvF9a2wr/RMUTJtJLs9rocWt/OXAEgCm9OMVanT8PK9JV/kTbt2MZ+gIxVRrGh/ECS451YCQ3KvyTktGO/g7ckKt5YgLkfnEVSViMM/n7vrPsqA5lnUWgf0AR722NuFejeDgNs5IdA3WaAARhQvvR19ZtrGkMT+c+e5VTGLCaynGB3j5ENaf2Wie04J87eoU5CTJAMFe4788eWIHnm+aPOuo5ItyrU37wjd7w70B1Qls2FPirHTjW/y5J8FdPAsXV0Ex/GBrtd1A==
Received: from DU7P194CA0008.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::25)
 by DB5PR07MB9514.eurprd07.prod.outlook.com (2603:10a6:10:48f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.31; Wed, 16 Apr
 2025 11:48:26 +0000
Received: from DU2PEPF00028D05.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::66) by DU7P194CA0008.outlook.office365.com
 (2603:10a6:10:553::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Wed,
 16 Apr 2025 11:48:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.20)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.20 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.20; helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.20) by
 DU2PEPF00028D05.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Wed, 16 Apr 2025 11:48:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 9F8E14EF16;
	Mon, 14 Apr 2025 16:00:18 +0300 (EEST)
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
Subject: [PATCH v3 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Mon, 14 Apr 2025 14:59:42 +0200
Message-Id: <20250414125944.97350-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D05:EE_|DB5PR07MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: bc3cda81-6757-40e9-6602-08dd7cdc9945
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|376014|1800799024|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UjFmbnB5bDNBVEorU0N3Ky9nTjcvalIyOXdWMHJnR3FyeUtOWTczelpQdnA5?=
 =?utf-8?B?OWNGdmxnNFVSNnoyYjVHNkR5R2JsVFdBUjRDMWpIdHFzcENScUpYaDloTElo?=
 =?utf-8?B?WlpwWkpxb09KRWUya0x1bmVJaEpNOWtWMmJGVU83WmY0bXppVWxUaUNOUTBs?=
 =?utf-8?B?TEd0aGNpWDE5T2J3dXprNUNDbVdnWHZacjA5Y0lqRzZjM3pjanY2TGdhaTN0?=
 =?utf-8?B?UDRDN3dWbG9NQzJwUlRUVmJLOW1jSCtaUzVTb08vSlAzenpqLy9NV2Zhenp1?=
 =?utf-8?B?dXlRVGxzSS8yQ3I5UmtjM3hkZGN6VGFBRSsvVndCNmp5SDgrRy9HSDRCMGtG?=
 =?utf-8?B?NjFBSkxPUGpyNlA4dm1ESDg1emxPcFRKQXRTczhTNlR1ajJkbjJjdS8rQk9D?=
 =?utf-8?B?V0ZlSkdqSzB4c1VzNThjSTQ2L2lvNW9GenhQNWpVd1J5bjVJZzIvci85WVVo?=
 =?utf-8?B?N0x5VEpyTWdFVmtTYzVwRmFML3MwSHVxdzM0SURrWXNvZ3ByTjNPRWVJVHJG?=
 =?utf-8?B?QjRtb1BZa2JEbHRGSFpMcHFwcjdqVHZTVHVpQlNqMnhjeEVHc3kvUUV0UXJM?=
 =?utf-8?B?clNmTjVodnppM2tYNk00Q25QU3VsdDJPSWRoZkRrbFE0R3pRZEZkK24wQzNk?=
 =?utf-8?B?ZEtXSkJ2c0ROOC80MGgwNTNZdHgzS2pZQzR3eGwvS0p2Yy9VaGdiT2NRbzRV?=
 =?utf-8?B?c0ZBOG1xZmh2T29vTVlZSXlXTm15bUlkSUpOZE9Hc0xxSDFtKy9PanZncWJL?=
 =?utf-8?B?S210cDY2NTllNURqREx3M01KaG83eFZsUGRmUG5GNUl6amY1bHI3VVFXMXh4?=
 =?utf-8?B?WUczdjZ6cFlDMy9nK3F5eHlUeStzRkgwNktsak9aSDlhaXAxWnpyZ0xDejkv?=
 =?utf-8?B?R0liYUU1VEtZZWV3Sjhuam9yVnJFcTB1WmRlR3Y4ZE5idjRHTUk5UzFIWWdL?=
 =?utf-8?B?SkNpbEh3Y3dtRzBtSnkvckh4dmprZGl5S212ZnVkR09PK0pRbHhSQWxtWWk4?=
 =?utf-8?B?RE1ZVUF4allvZ1JsZ2Fib0NXWXl4bmpzaHNTMkRzcnBjblBLTUM0ZHU4SFVa?=
 =?utf-8?B?Z3FGMlpTbXNHUUtBWlBUS3B3ZWZSVmR0MzFYY1pycUxaYnZ0c1cxUEFzbFY5?=
 =?utf-8?B?MVVhTkpERHp2cG9PNWtlTHNaV2liYzFzaWpFNVpzVm9ISDFNalNCWlp5OUh3?=
 =?utf-8?B?czRRb3dWSThHNkdHNjgydlBubGxla1ZucjlYdkdMcW5hTDEzVzZ5S0EzTy96?=
 =?utf-8?B?U3JOYWVVY2dTSHczcEo3czAxNGgvVTZ3dFdJK0cwQTQzL0NsM0RjbTd0MWVL?=
 =?utf-8?B?aWJ4VmkzUnJmMklDeG1VRFVIN3p2ZmtCd2NWUTdNUmNtNUtJV2Y4SkdaS2Qr?=
 =?utf-8?B?TW1obm1tTGJxTkFzazdRY1pUdUprTE4wTUdDNi9ReUk5Z2Z4ZDdZK2JOcjZF?=
 =?utf-8?B?T2p1a3hTcXIrdlM0SVhxcVE0RWNGOXVRTDc4YzlKSjU1OGI0aWhqRUgzdDIr?=
 =?utf-8?B?T2syTzRucHBIUEhEQWRXZVFLbVcxbVFQOE1YREUvRW1RRTFRWkJsMElLVDdx?=
 =?utf-8?B?RjdpU21meUMzanRwdmsvUTQ4UGsvY29zS3F1cW5COCt2OWZXdlU2cTRSblQw?=
 =?utf-8?B?cGJIS2UxSW1OcEhiZDFncWE1OEJGZU5jSGI0VDVLd3ZZYUd0UDVadzcySjh3?=
 =?utf-8?B?MExJZVdKNGx5dXF4QmlEUUJ6S1FDSitNWnVWcEJpdnZCaVpBc21Ec1ZiM1Za?=
 =?utf-8?B?YThHY2ozSGtaYTNGbnIwV3hPK29NbGIxbnl0QlJmUlA2Y0hJcVRWd3plTDZL?=
 =?utf-8?B?Tk9oNTUrbTlGWGozT0RTVk1aTjdkSXhBK09uN0NzclR0NFltVENteXdOSjNs?=
 =?utf-8?B?YWRNVVBxUlhPdW5ydnE4cGt0cTUxNHRRS2Q2VEorZkpZSmNWcHpjRVFtY042?=
 =?utf-8?B?SmNkaDRSeDdLNnZHNWhUbTN2ZGlxcGNrUlNmbWl2UWFydEVka0EwYXJtdmxL?=
 =?utf-8?B?d3J6MFhZWEZiOHhYUjNNV2pJaldzYS9oTTFuamtQTlBZdzlrRXdxL3ZFdFFJ?=
 =?utf-8?B?eThFazJ2UllwbzRYZzNnS2R3d252dW5lN0RHZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.20;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 11:48:26.1652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc3cda81-6757-40e9-6602-08dd7cdc9945
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.20];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D05.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9514

From: Ilpo Järvinen <ij@kernel.org>

Armed with ceb delta from option, delivered bytes, and
delivered packets it is possible to estimate how many times
ACE field wrapped.

This calculation is necessary only if more than one wrap
is possible. Without SACK, delivered bytes and packets are
not always trustworthy in which case TCP falls back to the
simpler no-or-all wraps ceb algorithm.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_input.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 54f798161d14..c6dac3c2d47a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -733,6 +733,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		d_ceb = tp->delivered_ecn_bytes[INET_ECN_CE - 1] - old_ceb;
 		if (!d_ceb)
 			return delta;
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
 		if (d_ceb > delta * tp->mss_cache)
 			return safe_delta;
 		if (d_ceb <
-- 
2.34.1


