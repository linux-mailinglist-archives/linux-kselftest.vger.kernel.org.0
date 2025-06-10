Return-Path: <linux-kselftest+bounces-34577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554EAD3863
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 15:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C973B5E5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 13:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4AB26528F;
	Tue, 10 Jun 2025 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="XHPbCGDf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011038.outbound.protection.outlook.com [52.101.70.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8E1265283;
	Tue, 10 Jun 2025 12:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560037; cv=fail; b=LmT21R/v4HE5s3CGDYzM5zfAdZuvkk96IvqHieBHZmI+o0v9wCkSCggGWvXG+cSdzRnoHi9EJ/um5kv7Ndp9Dnc9t4NSyIadpCIuBVzBVAwtnKBD706SPGzWSmGJcGdlAPHrxi856tYGqu/sg3Qh3wdHs+/HKp/vzg15gpl/BLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560037; c=relaxed/simple;
	bh=NH57R62fJmJw0NvDG6IhpFOYueANYaz5W6Tc9sUm2RI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTwIKTSw9pTcxOsWphOeZ0XQsqGRucPkihaCm45ZZg3DX7p6hYmhGXdsdafVPoQmTGTkYhHv/I/7BQdXeHEMe5bxeynYO8YZPRR2rP9JkpPzlJ2H/Muc+cNrVPPZGtFb6fwnOlpZgf3XzPzYFes1dkSUYV+E2244KbTx+5ZrpOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=XHPbCGDf; arc=fail smtp.client-ip=52.101.70.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JevSEer7K/xbnXaaGA/96qPUciIhc27NI2P1axsNt6+a2BXqmRqzVNZt8RgcxeB3c3Ab1Dq/6/fYrjbH0kq7e70gbHjqMDVw4s34TrViHnEN/++rtnfnGNcylNNfcCUQsCxyCBfXVTOiQF4bCSL8f+0hZN3UtUCNvJJrNkhv2G5+AJ8tiKJ5uMW0UOemn1edOOt4L8XPbZTa8wBWvWntlq3Y7bcsiCL77R5g8/I0t70kzKvOKvBKnq8PER8houA7MRnqm3YEakM4ENqKYlYN9fD+eM6bYQ7VuAu3bRanNjpqMfhArN6KjQA9GjqnYUQE0A8Ot7gYhP/fNVFgqSq9ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnUEV4JigGjnviKZYRhzdzpSM1JYv8nt6RzFTFRJGJU=;
 b=uATmll+10uODK9vSSd4no+ZEd34fvx25CdsqwamleInRFUtttzP6XevYY4iCxjnF9kcneyc92IbCSAURQJ/lz7kjIEIJ78pmCQWwS1ZMK0eKtLFUJ3qdivzUyEhJzkBJ3+NlNnZjbH5/chh5GO5s/OXUB4CdRFMrYyEV5e3zGdrfc6ld+cV/gTeBhxl0/nNEfsZZ7eInmOUJbfqiLgp8Di7d7UVGi8BwYDpqNVKDb3XjwFdw7xMHNu9YSnRhlk2R8XUlupxqtm2HdelCsPd46qTl0p5O4iMpDYFsNM9DuqaRRWCcto6uM+3v/D0OrYs5+rGGgHB6plNrCbSeLt2bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnUEV4JigGjnviKZYRhzdzpSM1JYv8nt6RzFTFRJGJU=;
 b=XHPbCGDfhXnTteyf6HKmdT+HR+PbhXCfWLsLyKrn1+8i3mlU3Bnn4Cmxe4Xh2ThGVZ+maFCvain9kVKG4zYBslqEsVUUV6NCp6UedNdUPc40konWtwkJUzEqtz3KhU69NDT92FWxqYry90I1oEnbLevU0oJnRqcWm+at9aSARtKG8dC4MADpVjIA2KK8UAz6T+NgfFJPOhdsbNfT3zA08ITqBv/U39aRlTIjG1Lbgplfm32v/cZ2dBvbdhq9fN0fXZE7v7DwQaQ1juX5TocVDeZD/l2QnHOJ/M6PLren0SF5IosJsDNQOogWXBDSYDbmhYyXOesfKRuwUcgq2f4A7A==
Received: from PAZP264CA0069.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fd::19)
 by AS4PR07MB8534.eurprd07.prod.outlook.com (2603:10a6:20b:4f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.26; Tue, 10 Jun
 2025 12:53:43 +0000
Received: from AMS1EPF0000004D.eurprd04.prod.outlook.com
 (2603:10a6:102:1fd:cafe::7e) by PAZP264CA0069.outlook.office365.com
 (2603:10a6:102:1fd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.17 via Frontend Transport; Tue,
 10 Jun 2025 12:53:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF0000004D.mail.protection.outlook.com (10.167.16.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.15
 via Frontend Transport; Tue, 10 Jun 2025 12:53:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 7D90F20099;
	Tue, 10 Jun 2025 15:53:41 +0300 (EEST)
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
Subject: [PATCH v8 net-next 13/15] tcp: accecn: AccECN ACE field multi-wrap heuristic
Date: Tue, 10 Jun 2025 14:53:12 +0200
Message-Id: <20250610125314.18557-14-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000004D:EE_|AS4PR07MB8534:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a26911-8a74-4ca9-ecea-08dda81dd4b4
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cjRIY2lFS21oclNHQkxZZ3l2ejBRc3k4aGF6ek1hZHhvbG1XS0dDYXJBOWxI?=
 =?utf-8?B?RmNWMmx6SzE1dzg0aUQwakNTc1ZHbENzWDVsZ01haVh1UW1KeXY2UXlwd0xI?=
 =?utf-8?B?NCtSemRPU0wrMjU5UmlDeDYrZ1plbWpsNDdENm9ZTXRuem9meU80NWFwNC9j?=
 =?utf-8?B?d2tnaGZwcm9kVkl5VEJYeXhzSkdKSGJMbEVkMG9QdnBwc3h2L1dub2wwL0JK?=
 =?utf-8?B?aktjS21xVmhra2xMWGdBK1BzMHdaQkhnaTVHNlk4eHplazBjRE1qaEs2SERx?=
 =?utf-8?B?MSsrNlVWS0NnUTRlRHpTVGQ1VTlHWE9SVmJQZ0xVTUNiR3BtUHNrRm9lNmZC?=
 =?utf-8?B?aHZrSUIzS1ZyekM1aHZMWjFUSmRGUERaZFhSWTFDalMzM084S1dXUzI5blcv?=
 =?utf-8?B?T2g0Q2xhS29tbkZiVm5JSEZkd3l0cndSVlZtNUZyODF2TzhTbllLSUxtaGZm?=
 =?utf-8?B?dXpLWjh0SVNLRVQzUEQrd0VvNzd1MjQ4UUhGdGljd2pIL1d0czR5U1cwMTBv?=
 =?utf-8?B?YXRIOGc3eTBQWUtpaGFTYXpxMjRnRVdwcCtyZDYwN3pCbTZOK2cxeUNVTU1U?=
 =?utf-8?B?RW9vNE8vQXBDZ0xOVGZrbGczUTNlekc5WFBFcUs5MEV5MUhSRlRFRVU5VzQw?=
 =?utf-8?B?UjR6aDk2OE9oc2E2SnZYNlV6eTZ0RUFRU0JTYkFXbi9ST1UwZGJvNmVKbVdY?=
 =?utf-8?B?TCs1aW9SUWlkN0c4dXM0UnZKL01VUllOcWpZS21vSVdSdjRZQjBZdlFMdFZO?=
 =?utf-8?B?Q0FNOEowbHFPT3M3Sk0yZTcrWjhyZnJvMlQ3UXhTTlVUVzJYanc2amlnbmpj?=
 =?utf-8?B?dG41RnAxTjhNVmNWSlFjckZ0ZUhwb0llMzF5WTNUM2JseWkwWmhsd0krenVZ?=
 =?utf-8?B?ZmhTNkI5QVJlcEJPUjJMVW4rUlBHUGl4ejJ4OFJnYmhXaVhXbzVMZ0dLSGIy?=
 =?utf-8?B?SWhVdWVWWmZFK3hqY3p2NDR6T2gvWklrc1o1ejlmczVtcVJsRnlLTzZtbWFi?=
 =?utf-8?B?WXFSZFlzaG5ieEw4TlBBT3hFYjBrWGoxWXZFQVc4Z2pNQkZhRmx1M2ZueDBo?=
 =?utf-8?B?UWpXRlE3Rm1Jd3pIbTdWaWlBR1JiL0RsRURuWGF2a2tXM0s2aEYwcmN6TFF5?=
 =?utf-8?B?V1BIY0crTjVhNDVNa2haT0VHZnNzbFRPQ2VGcFErZCtZMUcvU0xHUHVaWHds?=
 =?utf-8?B?cHVkVndOYTh1ZUdvOGRUcE9rVEJkR3JYMXBCVHMvQkxVR0w0V01QbVlxL2Y2?=
 =?utf-8?B?RDBQY0orZGp2VUdVblN2eWNPRExxNno0VFpEeTI1UWFxbVZZRFYvemMxNEQ3?=
 =?utf-8?B?aGVZaEEybDhIbmVGMTlGRGlPQ1o4aTlGN0xkckxNMVV2bDBjU2tma05sZjNw?=
 =?utf-8?B?djZnVDNWZUF4V21hcW1hckVTSHJqK1pQUGZDKzhNNVlnRlYvYnRJNmZ5MWsv?=
 =?utf-8?B?Z1dJM3hCTW1hVkgvcyt6UnJDOWZxbEd1QVlPK0Y2eDdSakxnZUlTcTRoTkJm?=
 =?utf-8?B?SXN0WVU1bTNjV3JRWmdTQzEvSzg5YUZWUHBIZ1YzSWo1cVRNcG9oWlByUGNu?=
 =?utf-8?B?ZXpPQkNnL0w3WmtxZ2FYU2wySURzT0paTlhtejJaemREYllneHF1Y3JQYmVt?=
 =?utf-8?B?SFNOb3hPd1d4aWdjWnN6WnFTVjViUWFVc1FqZ0wzREJOOFlhV3E5bG54bUpP?=
 =?utf-8?B?WUk0VEw1WVluK3VMSVFWWkhKSlovRGNmK3dBWjNFd080MUZqVlorZkV4bGJv?=
 =?utf-8?B?TXordWVReXZlWU83VzFrZUVEckx5QWlDa0pvc3NObkpDVUNqMEhGRVA3a0RH?=
 =?utf-8?B?YXZlZm5aU1RTNFFJbFNGNTlsZDA4VU9OaWxhY1NUY1MyNktieWhmSVY2eitY?=
 =?utf-8?B?MnFpbXh3cDNHRVpIWHNXSy9rd3JmUmxuT0FodFB6L0ZQZGJtOFFZTDNHUncw?=
 =?utf-8?B?Z1hXQ283TnozVkJ3SVY2ZUpNRnhPOEZFMGxRZ01pbVhpbGdsYmJqOXBFYi9Q?=
 =?utf-8?B?T29QUUJxSVV6ODBzY005aEViNnAxL1JWVWRlaVp2UktHcHZMQmkxUGZsMnQ2?=
 =?utf-8?B?b1c1TEE1dFNLU3JLUUtBSjkrNzh1NWVRaVViQT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 12:53:43.1698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a26911-8a74-4ca9-ecea-08dda81dd4b4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF0000004D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8534

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
index b0492f85c4a7..6fb845e9b3aa 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -748,6 +748,24 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


