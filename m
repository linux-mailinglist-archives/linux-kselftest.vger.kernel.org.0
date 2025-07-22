Return-Path: <linux-kselftest+bounces-37816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53642B0D690
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55AB31C2729C
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8235A2E2F1C;
	Tue, 22 Jul 2025 09:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Bydlpcat"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011056.outbound.protection.outlook.com [52.101.65.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0DE2E173E;
	Tue, 22 Jul 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178385; cv=fail; b=PH31/CxfaJhAM0WSCEpw3uwt75/C3Px+e/Sstt9wD/yS06lD+AIsMHMBA7TmXXzmQTJQjCh9KpGM+FHX/8STJgpMfJKrkWtnGDuzxt2Bed9YCwfo4NTHcDYUXprcvvAhgHgYJA6Xp5V1AjxYghwWZn1A5YHve21ASTS8ZvEhbec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178385; c=relaxed/simple;
	bh=QheIjnkZhAAj/gUXxo2UK5OQhY+fZUG8lLWtSanvv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=evbwX0l8aJ/udl9rfNpze2mmFhRn/fWVEfRbwLN457T5wCQ66Au/iyFS5exhxXT5psPug5xgVViE24G5aiXWyAVEVAX9q23UeXkEC/WT7zbqtzKs5OYqGAQtDaEtUArQtDmxHFagtuOkn3y8dqEF9iIjnZFtgsUNPV0nioeOMXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Bydlpcat; arc=fail smtp.client-ip=52.101.65.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOliGVsnK9Z24KokAuxheIc2lP0M2WFJZPDvUhCumjmzChVjTiPD2ocwDBnTGfo926brzAidXzCTCiDvPKPH2uGOnUIEhDb7ZsB9omvO6zMaUxx2WV9v24ugvLM9f4gJEOXdoLUgG+4laY4q67h0dd42pD9CCN8CyDI8jGDe7V0G7U/Vy1OawYYtPizitAe90MiMmaNCpu0svZZdtM+NQ1QDTwlNLfFbNyMJlcVaNocNyCju7KbWos+hRX5f4d7Msl5xn9Qoj4DS7p1VOsWyJku1SSe2mjc2v3P7u566QJ/7W/NtManZ6/KiM1mGILf85DguwvBQUkIOHflTdgX/dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=CufErZCNO7CyOtyU3SaXXB1DCTwB63OAUnirGxwTqcBcBj7pGlgW3nFWkgKwN3NfdqO2Sbp8BS3sgvCxRkltR8qj9B4CoqFtNbFadKNKBubRNfqGeDtrAHm/gPMY4CQBtIfR772BQDIiz3O0x1PEuwIYs7PfSXfy9J0GRT3IBRYfrw4cwusax8umfyE8VtiJVg6j0aZ+5xNiqjHLgKIa7VzGVc1Wg+stoEVa/C0IqRhVc1eVhRSr8z/JgW5YvgFuBPGFkL3DblU/KLHIuEKjKgcku56StXcZbTQiGvFW8rACmhUHQIT/bR+Reyf4bHSInsCiTBKEJsnvAvQdxpBNqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+ETTqRHjl1PhpSYo1DUXf4AWZcV2Hu4tc2zyFyl39c=;
 b=Bydlpcat1vtHSVnkOOL/xLXi5ibfgGrIBlYeOmJeA4qRRcspBkCDpjOIof8xCnbdPpDl47t2qj26Q3e3FHriSPLVxmARnwIFz0TuLWi4Ei4+wugJn+Bo04M9RxyRJctTLOr4my9PePbApDBLDAcejBewSP2O8sdJes5GjMXNbUbOojwWSSUaz85ST0SDlqTsNI3BVfgRLjZJksRR3MaZj5awmNA+XmVYJm0ZBlI0xDg9msrDRS648bGbluQFP4FOeRscWUStHLq81q7MI1CyjOOe93SflQlLR1iaJX9r8IczySGzhvvOfsHIrTHYzg3zr+MfGu73Zd5HwXocUZ202Q==
Received: from DB8P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::29)
 by PAWPR07MB10093.eurprd07.prod.outlook.com (2603:10a6:102:38f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:59:36 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::47) by DB8P191CA0019.outlook.office365.com
 (2603:10a6:10:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:36 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 8720B680045;
	Tue, 22 Jul 2025 12:59:34 +0300 (EEST)
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
Subject: [PATCH v14 net-next 01/14] tcp: reorganize SYN ECN code
Date: Tue, 22 Jul 2025 11:59:18 +0200
Message-Id: <20250722095931.24510-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|PAWPR07MB10093:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6eb955-8dfa-4aac-27ae-08ddc9067727
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VjBZbkpNaWNzWktWY3ROa2VNRWM4cmtCUlc2Y2kwN2cyUlhTQzVHdmQwVmht?=
 =?utf-8?B?QXVvbGg4S1Q5UWV2aXhncGNaUzlpL3pkcHRZVFdkMXJkMXZiRjNLajRGTm9E?=
 =?utf-8?B?V08zU1k0MTdOSG9RTEFpeWlDS2c2TmJWaVV0VlpQUFEzRFFBbHpETGxnVHNJ?=
 =?utf-8?B?b1pBRWpQeEpycHFabUttUnkwK0g3bjRnbkkxM2Z1QVpnanJvWUxMUmU5K3J0?=
 =?utf-8?B?dnowNUoxNC9PaGQrV2VDaVMwRWM3T3h4TUlmSGVxY3RmRUtjYnhnSUhhOFhw?=
 =?utf-8?B?VThXeWc4UkcwNVQ1N0IrZm51RlNBbmhnd1RvQVJVdmttUWV0SFdMdm9kWUtE?=
 =?utf-8?B?LzFpSDBGZ1I3aVR1SFNwaktqTkxNSkZnZVd6ck41UXZaSkxuV0pldU1qbWpp?=
 =?utf-8?B?d0NmMVdRR3lGOWhmQkpxVjM4UE80VnN3VzJqK1IwclN4MndFZGlCaHVQMkNM?=
 =?utf-8?B?aG1yVHRBMlkxelhWa0JHeDNqdEwyeUtSWlRnT21xWGdEdWE3VlhFUkFwQzI1?=
 =?utf-8?B?c1pCK3BUVml1Um1vOG9uU2dRd3NiNjRpY25CNmVHU0o1SzN2Z3JuRURaeitO?=
 =?utf-8?B?OURNUDFDSmR1TGw2SERLOERtN1ZXMVNVdytxVHozdisrWDlPM3pnRGFqOHQ3?=
 =?utf-8?B?QmlPYzNwUkl1aXp1cWt4bEZlWHdjVjU3dCtNVWs1RllMOFNaZWo5eitvczAv?=
 =?utf-8?B?VXNyM015QU1TVjVmM05qNU5UektwamlCZ2kydUliV0NDbkRBV1c5LzkyRWhR?=
 =?utf-8?B?T21CeTlOTEduc0pFYTJic1FvdWtuUERYWmxSeVc2MW1JeVNXL1FHZEt4dTUx?=
 =?utf-8?B?OTR2RDFDeUhCdWJYMEk1NVgyZEI5Yk9Ca2dHRFpXUXRrZzMrNjBnMnF1QnAx?=
 =?utf-8?B?Z2pOTEQ0ZTJxY2ViM2s5bk9KRjdza2E5cFZveVlwSU45L2p2RWVrRTNmc3J5?=
 =?utf-8?B?RkNpMURidkRpNDFSdnVHNVVKODk0djM0SXQwVU5iQzN0RzZSZ1ljeml2MWMr?=
 =?utf-8?B?dGdyZEZGd2NVYTF3TlRjUWRjaUFlSlNJNWFheVkvU3BBdHJ5SDVxenlaa0Jh?=
 =?utf-8?B?Z3ZYWW1RbmtrWVYyNkJXWHFvLy80ZXl4K1IzOWdXbkhsdTB1Njc5QVU2Q3RG?=
 =?utf-8?B?NHVrQUpFMGJvallGMzdYc3FKSVJtcUNsUnlwQ2FmVW1GNmFMOXRaOE1DaTQ3?=
 =?utf-8?B?ZmJjclZNUEh2amVxcWoxa1hvQjNJbXpZQ3gwdWREQ0tuZTB2UmRDb2M3YUgz?=
 =?utf-8?B?TjhkSFdaNE1HWTFGeWpQVUptbEI2aWJxeFJDbmowOTgwMTUyeFlicWw1UStE?=
 =?utf-8?B?U2Z0SjdCR3E1Uzl0THdUVmdoQVFBdzhvcHpBdEk1eHNBNHJhK28yOEhMYnJt?=
 =?utf-8?B?dm9SRjBNN2hZV1I3RDlWZUZDVTBTY0ZrR2E2ek5FcXFFbE5DOWF0dVh2eERJ?=
 =?utf-8?B?cy9Ia0NKci9aelZUWXYxSUcvbEFMSVNvZ2NMcTdxc0FsV1NRV01XUmw2Lzcr?=
 =?utf-8?B?Q1VYRDV1bnd5WldXb054QncyS0FTNXBlSDZMUm1iY3llRnBlVXA2bnFNQ0lI?=
 =?utf-8?B?TnhOMWFsNHZjMmhCRjZ2VW5Mbko4bGRkUmZJSEdHK3R4NHE1SE94Yk5HK3ZU?=
 =?utf-8?B?a3NWdFdQNFhsY25WLzFuL2gyRkplR0hXdzdYMzZoNmRIVjZ1dnlsYUJpZVlX?=
 =?utf-8?B?RjRqSHF4KzNHdUYyL1lseW5BZ3dUOUFMckdic2tHbWU0SHNsSFRSN0MybVlu?=
 =?utf-8?B?cUd1R2YwbkJ4Ymp6ekpPcWd4VS9XZlI0MEdEbDNraW0wVE1TOHB4NlRPM2VK?=
 =?utf-8?B?bzNVVVVibDRkWjlYOCtUNXUzWjJ4TjdLbkRpanFOcWc4cU42QXE3c2lJNWlD?=
 =?utf-8?B?MTY0eFA3aTlacUlIUEpqZnBuZEM3WVVDS3JCcEpOdkxLbWU2dWVoNnhnbVph?=
 =?utf-8?B?a3JDWHBVSDNNWmthQ3oyYlVEakhLTFBRaGFhSnVTVXJReGRYUkFWME9KWXQ2?=
 =?utf-8?B?WEsrWjVNc3hYVHVJQS90bmFiYU9YK3lVb0g3a25GNHhQLzR2OVFHUldyVmtM?=
 =?utf-8?B?WEVZSlIzQnkydnpyWlQxVkNDQURIdFJ4aFFkdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:36.1732
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6eb955-8dfa-4aac-27ae-08ddc9067727
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10093

From: Ilpo Järvinen <ij@kernel.org>

Prepare for AccECN that needs to have access here on IP ECN
field value which is only available after INET_ECN_xmit().

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_output.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index b616776e3354..caa980c3f25a 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -350,10 +350,11 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	tp->ecn_flags = 0;
 
 	if (use_ecn) {
-		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
 			INET_ECN_xmit(sk);
+
+		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
 	}
 }
 
-- 
2.34.1


