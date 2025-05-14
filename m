Return-Path: <linux-kselftest+bounces-32936-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E72AB6D92
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127B23A6CB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF2327BF83;
	Wed, 14 May 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="B2XxZelO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012067.outbound.protection.outlook.com [52.101.66.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED21327C173;
	Wed, 14 May 2025 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231016; cv=fail; b=Nbud8xF4Fkg7IsRKV+p5Y3AuvrZQUU6bkZM4ZrHWOwtzLq7cmPmRNRUvMqOgF+f3wnS4v0N/98wTFQC7Xd0XHu51VKU+1S1SXZEHH/6ky38GSmxlKC7NqlCNz18PMOPIKzwA9Mxnhizh1G568dmbhXGO7DRHe3n+zNxFATkNCvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231016; c=relaxed/simple;
	bh=jzGjlVHTjyWEGx0OxJrvgDWNiNQ6gwMZm/yT5kX2loA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TywcwNKvLv984nqEZ0rsyR7pWtEEbFBFzLCFYX5R62tmz2+YmL1UO7fmIPsatak2IZQh9bV8JcmKSYicrz6WF3ePoZdgBh0jJcK2yP9Nh2PfZdhacf/p+FCqAEc295Yujk3JV6Pp6aJ1NH+lPp4rl3W1VphNCf0ykG1CK6VoiBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=B2XxZelO; arc=fail smtp.client-ip=52.101.66.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u1glOzfu9BBP29Ai65h2hAvwBj3WIRZjycCyptuBMds6sl7nyNywRIev4RvkczlqJtuHWtwBj8EdXh7D4486Q2VsA2f8WxLQ03nmFr7X7vux4OeX4Z4mOfrK2R8ogXaa16U0cJhs22XjidNe0J3Ed17azLdYSg8Dv+2mrq0p7XeB2FBi0PyYj27jpFP8inxjjjT5u+wU0/nS6VB0audowjxXK/5UydQw1LlvjmlLQlmUvQpxejz57RJ5sRCoWjqylYnznPYmIgRzAcA/Ex0F5IIh/ouYVZw0Hby+sP0Rx7NgVHex7YUj0zK1anW27y3wvCjcCRWFChjeQOYDVKxMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=N3qJiR+9IuFSopcPQMcGqc39j9WDvMSupkBY9lTY27uhgURtHCz1eHWMoCaeAQ02ObsaA7VeC+cQesFRgzm4sS9ONyXaP1S7ET13SOWQyZY42pX1y9YHJ9nVg5e1yEhrkkt06hml0YWC0q/6l8UlsP9/BEH9P4jMT5cEYRotAtwZhMGBh1oGzAFh4kudsoI5KRpqMKOscT4cRW0yZqUWgCEIFoY/HmEzBQxHbtxUD8KAuft2OFiYxblorddkigVAl6NpUusOl6Ew5DtdgA3jPuN1nxBi0TXkNs/T2qfLWgOIeIJjFsXUdrpzpvz/06sZQIYHoRAZHGHfiLHUnz5N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP/7Psq07ihqriJaEJ63jaVwaWZLAB4da/DunpSK6As=;
 b=B2XxZelOAFf1sJsHCp41qJpHYMqFJVqDe1IYbhdd8CdXvOM18pYoq3w95JFuRSE1/UhyY28YqJU2QWCN7ocZ20TbeH4uaWCv171/FwGziM1rtrU9+FbHY3rrJThxWDQK+MJKmupr6ULghr6oHfuFirItcJjZeGsxtThT5G2BX7XiIgPVx7IXEnZUDTz0Yj0UgGyzBJLD07zoIniJFFmiw/+0hQ0sqUGrv+NpWsfa9Iee8ochgKj16oC9kkhLpU1ql5VSfiZWqPdqenHZcag1lLhDj4m5Ljp0ZAbNCp8nOMSType/gPZnExJqNT1QXQvvvMO+h/jwoOoSp7COzFkTnQ==
Received: from AS4P192CA0025.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::19)
 by AS2PR07MB9375.eurprd07.prod.outlook.com (2603:10a6:20b:609::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:56:50 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::3f) by AS4P192CA0025.outlook.office365.com
 (2603:10a6:20b:5e1::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.17 via Frontend Transport; Wed,
 14 May 2025 13:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:56:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 815B42009B;
	Wed, 14 May 2025 16:56:48 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Cc: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 02/15] tcp: fast path functions later
Date: Wed, 14 May 2025 15:56:29 +0200
Message-Id: <20250514135642.11203-3-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|AS2PR07MB9375:EE_
X-MS-Office365-Filtering-Correlation-Id: d24f394f-a8e3-4bef-46b3-08dd92ef2cb8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?SVhEZUNBK3REUkI2YnB6a3ZkMHNQUGlaanJGdGVLbWFpVFQxNHUwVkxIeXl3?=
 =?utf-8?B?S0FhT2c2MEdwME44LzNlSDgrRVlvQlJ6dVM4cXQxOG1TdXJoY3VaSGM3T3Rm?=
 =?utf-8?B?QkJjaUpCSzUrNjRPT3I1NnB3Zy9XalhCY3pRV0VSRXZHM0FxVS93Y2pKS0xa?=
 =?utf-8?B?VWRJMGJORWdJeHdXeitxS1VyL0lVYkxlU08zN3pSd0lFNDNqb09kT0wrSWFF?=
 =?utf-8?B?VWwzNnJPRUVHZFlwZmpMZWthaUttU1MraHJqa3pmak85eEEvOE9ab3FtTS95?=
 =?utf-8?B?SnRuUVRVYTN2Q0dwWDhXdUIyNVYrN3IyVS91TVFGbFlqbVFocUptSmJVdFVI?=
 =?utf-8?B?SnIwZlh0Nmh6S09GZnpTZEdIZkNxZ1J2cGRDQ3d2bjRsaTBjQWE5dkxzdEV3?=
 =?utf-8?B?TzlwQmt6NFRvY29Qckw5ZlBSR0xMaGxabGdOcFdGUVc2K0JaMGRMcFRvYjNC?=
 =?utf-8?B?THQzUndXOFQyQVpEWXRpbmFETkR3b1VKdldlUDhnblBHQVNlMEM2RUN4c1Zs?=
 =?utf-8?B?KzVmQlk5Y29KM2FoTVc2R0dqYWh5NW94bXZyODhUZ2ZuZ0hzQTBVMWNoZUdw?=
 =?utf-8?B?bGtGM2tsSFdKTXJpWFZUMEZVdjIrU0N4ZlRkdmZyQ05HdEp2YzN4Y2M1ZW1j?=
 =?utf-8?B?QlN3WTRFN0kzOTZDenFQUk9oR01CK01QcU5rZzRaT0dmZFdSWlNlaWhXNW0w?=
 =?utf-8?B?RXo2RWRZaFloTVZJR0xhcGFjcC9nZ05mYjRuTllXRVYycDVYRVpRWHcxbmlX?=
 =?utf-8?B?Qk5YNTBlNHBWamwvSXdVTmRGYXh0aW9nT3ZDWlpnNEtRbTNZYUhZeXFWK2xK?=
 =?utf-8?B?cW5NUW8xNkpEd1ZOR0g2WkJJbzE4VkxSTWl2Q2t5QzNBQUhrTXd3Rit2dDUr?=
 =?utf-8?B?ZVRTb01zRTVJdS8va1A1dm5OVTRYTTV5a1NiMW9tYkhmcHlDdmhYSFRlck9B?=
 =?utf-8?B?b3JXVDdMeXRNaWpudTNXWWVoSHdrZDVJbTliQkpPSVJvcE13UFVlUXhFelZ1?=
 =?utf-8?B?RCtZNzM1dkpTRk5LMU9odHM3L1pPa2RwSnBzOUVZQWh0VnhJSVhvMExITGJr?=
 =?utf-8?B?V3pLYjgzS0dlTkdFb0FXV2F5T3VVb04zaDI1TEJJUGlDR0NCcnBQYnEveWEx?=
 =?utf-8?B?YlFVTlpVUlZoQ1lWMmp2c29CcmdJNlRnYmx5U2Q4d0cxS2RpdnUrc2JoL0M1?=
 =?utf-8?B?OGhyYnBPRFQ1K1hNSlZtTUlUbk9PQnNZZHJjMUZYc0dZSlphUkFzaUpLUnJ4?=
 =?utf-8?B?YXRmT3B6VDBldlVwVFlkV2NldDlWNW5na05LOFJqLzVMeldPSE9qWFc1VjhG?=
 =?utf-8?B?QWZoNGlwYkVidEgxWFV2ZVFOeGZZUlBZbG45UlFKa01uczRNQkFJL3RwdGRh?=
 =?utf-8?B?UkhydlREMk50WDRyRk1vSW9xL1F6VkJlSW91TDBMN3BsSFJIcGdPdmI3ekds?=
 =?utf-8?B?emNYdkdtNXBHY05ueE52ejIzd28vTExrTHpTd2orRWVmdVI3TkliUCtEWWxl?=
 =?utf-8?B?a0JWcFBVd2N5QXRhTnFtMXZ1K2RXVFRWZzROblNOSEMvcERCYmFWZU1MK0ZL?=
 =?utf-8?B?Rzk2bGxVM3ptYUJyOTloQ2lSUTdkMXJyYkxnQ0U2OVI1eXdrWUh5MTFxLzNv?=
 =?utf-8?B?eUovSE1GOU91bVhHT0NSa0I2TVpXZkhnbTRBZ29wbFFXTXRjelQva0RrdWpP?=
 =?utf-8?B?TmpRbHBsVDVhdnlXUWxoQUduYVJmbXpXU3BNVnZuU1I0ZkhRUklaS29yZnRu?=
 =?utf-8?B?aC9zcHVHZ1c1b0RnRCtNWHdXdUdVQWxFYVE1TVBTK29FZGVpNXZkR2tYSis1?=
 =?utf-8?B?WEkrNmxXTk5rMTA3WG5RQ2VhdDloRFZDQURHVklNUGJDbzRBYlJxKzhDR3Jv?=
 =?utf-8?B?TXd5RnVWVExoWE4zeFBvQmZkd1kyckFrbmYvSkJTSjJWYU81akQycTJRbDJH?=
 =?utf-8?B?b2NOVXZCSHF1MFkzRU1mUStac2xxbUZzeWlYTVRmalZqbUVhRkJDNGIzbFBM?=
 =?utf-8?B?UVRkMFpqRElkL0FIVnRYZWFkZjc5VDZKcWdXUmJHTDM3clJiSVBYbCs1UkdP?=
 =?utf-8?B?S0NOYXhMN1AwSU1FSXQzY0Q5U0JRakhJQ3pNZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:50.0896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24f394f-a8e3-4bef-46b3-08dd92ef2cb8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9375

From: Ilpo Järvinen <ij@kernel.org>

The following patch will use tcp_ecn_mode_accecn(),
TCP_ACCECN_CEP_INIT_OFFSET, TCP_ACCECN_CEP_ACE_MASK in
__tcp_fast_path_on() to make new flag for AccECN.

No functional changes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chai-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/net/tcp.h | 54 +++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 5078ad868fee..4dacd4a11669 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -812,33 +812,6 @@ static inline u32 __tcp_set_rto(const struct tcp_sock *tp)
 	return usecs_to_jiffies((tp->srtt_us >> 3) + tp->rttvar_us);
 }
 
-static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
-{
-	/* mptcp hooks are only on the slow path */
-	if (sk_is_mptcp((struct sock *)tp))
-		return;
-
-	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
-			       ntohl(TCP_FLAG_ACK) |
-			       snd_wnd);
-}
-
-static inline void tcp_fast_path_on(struct tcp_sock *tp)
-{
-	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
-}
-
-static inline void tcp_fast_path_check(struct sock *sk)
-{
-	struct tcp_sock *tp = tcp_sk(sk);
-
-	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
-	    tp->rcv_wnd &&
-	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
-	    !tp->urg_data)
-		tcp_fast_path_on(tp);
-}
-
 u32 tcp_delack_max(const struct sock *sk);
 
 /* Compute the actual rto_min value */
@@ -1798,6 +1771,33 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 	return true;
 }
 
+static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
+{
+	/* mptcp hooks are only on the slow path */
+	if (sk_is_mptcp((struct sock *)tp))
+		return;
+
+	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       ntohl(TCP_FLAG_ACK) |
+			       snd_wnd);
+}
+
+static inline void tcp_fast_path_on(struct tcp_sock *tp)
+{
+	__tcp_fast_path_on(tp, tp->snd_wnd >> tp->rx_opt.snd_wscale);
+}
+
+static inline void tcp_fast_path_check(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (RB_EMPTY_ROOT(&tp->out_of_order_queue) &&
+	    tp->rcv_wnd &&
+	    atomic_read(&sk->sk_rmem_alloc) < sk->sk_rcvbuf &&
+	    !tp->urg_data)
+		tcp_fast_path_on(tp);
+}
+
 bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 			  int mib_idx, u32 *last_oow_ack_time);
 
-- 
2.34.1


