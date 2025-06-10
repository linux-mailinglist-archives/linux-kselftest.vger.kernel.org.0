Return-Path: <linux-kselftest+bounces-34563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD35AD37CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31585188CAD6
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D572BDC3E;
	Tue, 10 Jun 2025 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JFrvxh3R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE862BD029;
	Tue, 10 Jun 2025 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560005; cv=fail; b=Xsu0SlFqdykPhDxeArsr7MH8VcbZlOLVlN0LgGYld2hvZU2T7kst5bkXGjac01j+KGYi5rV94KvFx7X1RSItNLmtzFkW794HkVXe+Gd8pUvqEbHrUomh3nymUuIpfFOAY8safZNuakengxZ2jVJWgbfXeOtLvJD1X/vWK+07A3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560005; c=relaxed/simple;
	bh=VUIIJl3rw6cEfbmF0z+iwMHdAQq+VESbWoTPvpweElA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWckEkOHtNlCNp42q2bVbFXXuxH9C4aGQUuSLPlJfjMJ6LmPmd6a84SxN0DpDYwQv0is5D02Ida/55KohRXKo11JD4JzdiyVufUEr65OdfRc2Sxu8Pz7EApWLam1IpzM4IPaookg2tPWsf5QnKntRID0Y22AR6eq04EXLQU85Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JFrvxh3R; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Io7KMUlai7oEQ7XsIpEq08MMkH5snhd/fLuyhgy7BfdA4WU8TX8n/9R2jwdz7k/MXU/fKjWDuXdrdAcjlKfil/oYJtD1OgXv7XXQYTCdcjmBJ3Ios611tqROt2Qgq556cr2jhaDKjYbyM4eSnCXGAVZ4red39roJCZ00M7gUAibB4kfCoHVBHM36DJLXXuioc8Jgc+7Xv1nX2wm9orG/9D2dFpt6SApGxx4I4uBZ8LfRUHGka6VeunC/XpK7VtrmSZK/oWsOyCmjkIH//nF8DmM8nJT2uxy2QLDGGLwsClc2ptxZcxwtTb7vDu7FEOl8KNcSyDBPg2Qxx8Y65AJibQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3XJvuhuamS43w/lJjBCXhLCRCQkA5JF/uMfQzysCqE=;
 b=jbqEjelDSgbnWCO3vUfdF5DU4A4BI8DhtjNZMOvtJ38izko60GpoHa6EIYYBywS6z4fmWERkvauuS7sBIuCLRY/IInqm9xzAzK6M3lCHKIeof59phJbgfhvvW70YkEvzuZ8GObENz2TLToEg0TvwdX8X5HBrCDPjXYKMajjUfH7nboM/RLpzslW4z+7IqFsCE0onT0G5ZVgjV7pNZaGaL8FngSJ/iEYrnisXEryOo/4X2ZyUUe0UPbYZR92IFK0a6czt1HtSaOydp6Y5/GMOQmeoP9OZDeA+LxbKdwigUHGB3Adx3agJL7w+MwHK9koymcnYYLz9553B+bb+2g0dWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3XJvuhuamS43w/lJjBCXhLCRCQkA5JF/uMfQzysCqE=;
 b=JFrvxh3RKb6i8bWt07wZb0jdIJ12vw1ReR5h6KwFnqhNVKVtIIY4kCAMmysnnXEdGJPkuSZlFKSSY2/DOgMWmficD2MZxr1hg0NtD9fTiqCiFIzc9fAqiBPBrFKwxWVTSgwjEJzfyhbQQVnobM8GjpMC8Fimm0KBce7eYNRnsLGdTKyAArXaoD1d+nM/mWGi6+a/qzfmyML25Xl0H7vnKTpbwNqoZm2gan7NLJGJ3noiz2h7aMguvJHbiTXD3djAewJDkXWrIFWywpxJFjTUPZjOYMBPft+UgPQxHs7hglFk5/ls0miWWBOnM0+ZtiBXgA25vWSUJK3qcYnj/T5JYQ==
Received: from DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) by DU2PR07MB8048.eurprd07.prod.outlook.com
 (2603:10a6:10:23b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 12:53:20 +0000
Received: from DU6PEPF0000B61B.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::ff) by DUZPR01CA0243.outlook.office365.com
 (2603:10a6:10:4b5::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Tue,
 10 Jun 2025 12:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61B.mail.protection.outlook.com (10.167.8.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id F2D28200D1;
	Tue, 10 Jun 2025 15:53:17 +0300 (EEST)
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
Subject: [PATCH v8 net-next 01/15] tcp: reorganize SYN ECN code
Date: Tue, 10 Jun 2025 14:53:00 +0200
Message-Id: <20250610125314.18557-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61B:EE_|DU2PR07MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61eafc-0c49-4db6-0ab7-08dda81dc693
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?RDVlTS9Td2xYU0pzNlRTNWQrOVFKUlQ5aWl1Ykg1ZjUreDhmNmNZUnpJdTVZ?=
 =?utf-8?B?aVJVYnlLaDFuWDdmc0tHVndKSHFwTHZWcGwxSiswVW5MWlQyNkp3cXQyeGVh?=
 =?utf-8?B?MlNkOWYweEtlNkw2clN4U0dubWRmdG83MFZVT0VvNVRXM081a05ValpOZ2Js?=
 =?utf-8?B?bkY4RWJVeG16UU1sUTFtN1J3MlJIMm1nc3FNaFk0d3MwdGVpSnkxcUkxNmhn?=
 =?utf-8?B?YTM2QkwzazFmcExNVmtrZE5jdFpwTEcwL3NLVzlVM1BoT01aR0tESDE0b1Y3?=
 =?utf-8?B?a3huaVRlb2xxejRRSjBxZHdDWTJXQzJ6aFBTOHJSV1UvK0V3dnZHZ25VWFVC?=
 =?utf-8?B?c3lneHBraVA1TkMxYUhuVk5jeHZ5MGxBN1pkOFI0OC94VjQ5MWRzUTVQNDhm?=
 =?utf-8?B?TFBScVYrdTA1SE82M2J2QU1LVnlIdFd1eldGOExOSkNnZlpXMlVLK0FMT2hE?=
 =?utf-8?B?UUZ4MXZZbUVxbEdMOGJCd3Zxd1NscWdseHF2dWVWWndMRjZKMG5IRkVLamQv?=
 =?utf-8?B?R08vbVdISGFTNnpMMFFUbC9scThTeVAzWlBkYXBrNTJjREtnSHEzYU85STIy?=
 =?utf-8?B?TXUvMitPT1hFWmVNOFkyYnArZXZlOWllbDFtdDZ2L00ya0xvUFhWelJNOWky?=
 =?utf-8?B?MFpnUlNENHd0NU81WERGNFcxUnR5dzM1bFdJQy90UlNPZzZYc0p1MDBzK0ZC?=
 =?utf-8?B?eGZrMjFoV2FPSDE4RWxWbDZtRlRrZUJmOEJid2xxNm16Zi9tNmhuUzY1TEZm?=
 =?utf-8?B?d2dwQ0cvVnBzeXZqakN0dGptS1pOaXBwbHVNdmNiaW15NlFXa2hUcVpiclkv?=
 =?utf-8?B?Q3d3ZkhXczM5bjJpcWIvVHlQZ3FBTFl1bURYR3A3K2JoS0lCRURSaS9ZTFRO?=
 =?utf-8?B?L1FBeWxqbzgvZzJqSWdLSlRuZC9KSHA4MHZSQkk1WXlNQnYvc1JUdmJsL3JP?=
 =?utf-8?B?TFppd0pYUnB4SmhzaFp1YWhSUHJ3L0Y4RklDTmdMM280K21YNlBxWGxoamgx?=
 =?utf-8?B?cE9lcjEzRDdsWjlqZ3JsdmM1RE1QSkFyK09XRTVPY2lDMlVvZ0x2SVl4ZG9I?=
 =?utf-8?B?UE9ZdFNOMjh0MWJxK052Yit0T0tlNS9jVzFGaVYrVjdReVh0YkJSc2x1WWFO?=
 =?utf-8?B?SDBZZkRHU0VvMTU5QkliWmJOaUtuZzFSR2dDV3VYRGxjdkl4b2ZiTnZBTjYr?=
 =?utf-8?B?bVFLWDdpSzRDdTRBWlV3anZVMzdTMW4vVHI0aExRd1VFSnhrbjR1S0wwRlA0?=
 =?utf-8?B?RWlHczZCN3RGZmhGUXIzMjZBd3lsbXM0WnNoTFA1Q3lGa0VmT0JQU3lHNDNn?=
 =?utf-8?B?cEhRUDJMemJFellCNG0xdHU3U1gydzJTMWtidGpzTXFpdndhcGpuSUxGanUw?=
 =?utf-8?B?eUlRUit1TExXckVrNUgwYlhyTVEvRWJwdUpRaDRQSTNTcGRQMndTVFJVNFZt?=
 =?utf-8?B?Wm1LVFpzTzhRR2Vzc2JySlV5aXR4Q1VTUjk0dzdRSnFNK0hiVWFvM1hFR0JU?=
 =?utf-8?B?c3JWbmpDeENWeUh2VlJoeTA2VElacTM0S1ZyOUdaRlk2V29HTkc2UVpiQ05L?=
 =?utf-8?B?alNBbnBHV3FCdmhncThCYVhVL3VYRjZEVkM2dDRoWmdmSE9nTkFsc0xNT3Rh?=
 =?utf-8?B?TEtVbkxaRVRrZ011Y3BLTU1pZXZoMVZ6ekdDR2t6SEdhWnNwUGJKWFpQMFdG?=
 =?utf-8?B?TGI3OFg1MW5rZElCMUd5R2hIU3lhWitPMDJ2YmU3ZjBBU3c1V2pXTnY0Ykhs?=
 =?utf-8?B?OUozaDR2dnB1TjJlQ3dtOTJpblpOdklHMjNQK2x6WTZSUHpTL3h1TjZGbFh4?=
 =?utf-8?B?QnA2eXIzQ2JkdXIwTWJJWTV5a21sSE8wcjh5Q2NKVGNYbW40ZUkrdzVZRmhq?=
 =?utf-8?B?UkhQdDF4ZUNOSlJoTElwNXExOFJjY3phMW9rS3IvS09FdkYrRms3UXB2V2pa?=
 =?utf-8?B?RG1OMjhqZTl1UGFQaSs2RnV2SHY0RlhXVEQzL3RKNlNoa2RiTm92QWRlL3dh?=
 =?utf-8?B?UGlYcStzRnN1aXdHUldVb05rOHo4aHlhNFBoNjZ5ODIxQTlsOXJXZHQvMWQ5?=
 =?utf-8?B?dGpIdzMrQ1dKSnk5U2x6ck9yUUMrUGlUdGlQQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:19.4723
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61eafc-0c49-4db6-0ab7-08dda81dc693
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8048

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
index 3ac8d2d17e1f..2ede3c190293 100644
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


