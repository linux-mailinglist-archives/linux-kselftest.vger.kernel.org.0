Return-Path: <linux-kselftest+bounces-35562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E6AAE2BC4
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FB0179DEE
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728132737E6;
	Sat, 21 Jun 2025 19:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mPuey7xq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F51C84B3;
	Sat, 21 Jun 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534692; cv=fail; b=YOZxEGWuZBGHV06FLCURKwQt8A2JYvekUpifTZKSPYpYP+WkGJuSsQO+5OdRXBe6XgO0paQqWz2LYsJdGLYmmXilkJ+qPp60fVUnOO7LMh/eLv3sXXIGyJQa3rrx5/fg2kC5EvRdqFDbkHbqsxYPrtqux7K0v0LTyHUPy419BwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534692; c=relaxed/simple;
	bh=hxxlguBzXA/k0vmaAOuWYyAV8YvHkQVxGBqYJbgQ728=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EL6xVqsDbAf086uixQcdg/UMGnwmvPNlaNCdPQZxNoNTrIHcPc86MmukqiHfpSNL/z1gFQsYc0VY6lGOG7wf09FSSYa28yjofQYloJCTJExcT9nVvNd4z1+5SPbc6VLsDYcqsFyGR2Fqy65eFwE//yK8Ocbo15dAR3QxfZkyE4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mPuey7xq; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAD5hXHFapVVepmG7WKZRzP5CioD6+4D6QDLbnRMs0v9BNAvKagMcwcoRrT3Ju/at4suB03mmoz3RE2laZi0ymdtTLO0SZOHFBnwIS4NwggdsABRBgESHBqAWBoE8Q8/+B9q36qxSplB8ZlN1RT6oj9jPJuDxhH9pKYz3KQgDWoCvCu7lqdXqCDFz8pHkvqndrfEFc5ooudSGOMWO6jK22lVNplyGW4TxXr9fuNdritpWmmIttxw6250DBWH5/1JXs+auXijSphs2GEcSnoy5k5R2wfKtNG5GI+dhohAITr01dxDhLtILKTb5IUbUAQgQcWmQTEVYeq/Q06mZDmVCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIGKAB8KOAtwkioLVZP1TySuk/h8WufVkKFOpDv+XR8=;
 b=g0ngcIPTaxSK43wI1qizu0QyExvzea7k/Fluo0QsYUWQr1YkCnBVo86JCw2usg6jTSb+JlKteKkCIrm2LpmksGZQtVrYOY0wYLYuJrTolfmYUEz7OZVfKyGfYym/jXu3/DABceoMORhPG8ZDzQow+Rnq3oSwoG4Fw6S0Fnj9YCCQQ5pIzIs3Ae/FvRLhlyjAlnlnn0ECjRJpJiyysCNXoflJGHTxLi7KWRdg0iJE7iDyD5PiGW7Cmh7qlJXO+gEicjZYrGNPn5ZHfAekUzr3G1q17RQ3hJCuIFsoYo4cuO1ApmAmdKRdWeOoEKHfd5P8uQJ/RehpC39F0Drmxb1mFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIGKAB8KOAtwkioLVZP1TySuk/h8WufVkKFOpDv+XR8=;
 b=mPuey7xqC35bKQED1Fa7CXlL4UnaC1J76lBGZjazbSpx1bfhgRyEpYnmc7dQDbHi6uKQ3vdyaGisW3kE5yFJFNbn8BI64P4agJ1MQvwW7S8BPpegDFkfZkGba4jCc63nfQ1iUoZRLSHGA5I1b1H8p6J5Ju6qf/1VTofYAGvNtkd95SqvpBpLYb6FzwmUIOV0i9jLI52bcIoKpNMoPBt78j4IzwbUKxQxVyPTTMEvF8KXL9WHRk3oNDY0/k68vs15aSrYmBc6D32WufKi5LqbVp3HHQcp8joeeto8CxhJYncjiBuRcxOuTBFK+HrU+/LyNefyTzf1vinQVW8mZD8krg==
Received: from AM0P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::16)
 by VI1PR07MB10116.eurprd07.prod.outlook.com (2603:10a6:800:1de::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Sat, 21 Jun
 2025 19:38:04 +0000
Received: from AMS0EPF000001AC.eurprd05.prod.outlook.com
 (2603:10a6:208:190:cafe::f8) by AM0P190CA0006.outlook.office365.com
 (2603:10a6:208:190::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:38:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AMS0EPF000001AC.mail.protection.outlook.com (10.167.16.152) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.14
 via Frontend Transport; Sat, 21 Jun 2025 19:38:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id AE40E1C0031;
	Sat, 21 Jun 2025 22:38:02 +0300 (EEST)
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
Subject: [PATCH v9 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Sat, 21 Jun 2025 21:37:33 +0200
Message-Id: <20250621193737.16593-12-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001AC:EE_|VI1PR07MB10116:EE_
X-MS-Office365-Filtering-Correlation-Id: 9de816e8-abb9-4cf0-dad8-08ddb0fb2431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWFPS3FkSlBDZFg5VWl0K0RVU1hNQ1RYNnZxc0o0eUkvbFhLM09hdW43NVBm?=
 =?utf-8?B?N216MjZOaThSbjZ4SXNYNWJjalBvYlRGU1ZSU25aNnVGc0RDcHpGM2VjeHNH?=
 =?utf-8?B?WXBWbVZuTmNybUI4VzhMcnhxZjE5Q0tOS3gvY210OHo4c1RwS1poZEVNMjE4?=
 =?utf-8?B?cG5JQ29iVkx3dUwrL080dXRzYVo2bFZ6cnczYWVlMlhQMWVpQUJZNS9mVk5u?=
 =?utf-8?B?SmNxREJTVlRmejB6K3FNTXJHbkNFYThaWitYeWZCKzMwcWpNcnJMMHZxTENl?=
 =?utf-8?B?U2JzOUl5U1JwR1FYTmRCemxReHpuWjZxL2dnWWJMQ2ZtUkhzTnpYVlgxRlJX?=
 =?utf-8?B?ejBDbUpsa2VvM3cvYnBBTnJjenAwbjZzQjdYWm5iNm5LSmpMMVdvY01MUEpZ?=
 =?utf-8?B?MnJwTGFBWkJtREtWODNueDREcU9zS2V6SHd2UFQybjFxTkdxWXNZbFV6a0lG?=
 =?utf-8?B?SGVzVlQzcjB0aHdBMGJXMDJBVGNUMTFiVWJXZ1djYVFDckFvcWhySjE3Zk05?=
 =?utf-8?B?K2d2VmNkYU1OWkVnN3puZUVxTVIrS3o0VFMyRkpMdHNVdVd5QVcwaW5pR2hN?=
 =?utf-8?B?bjh5d0ZjN0hyWTlNZDM1ejU2RnY4Q2ZSeHBJS0s3QTdKVHcwdVFWQXhxREVW?=
 =?utf-8?B?am1Qb1oyZHovZ3l4d2hvVW9nQmtKRWFISEVuMklpckZueldMYkp6QXdmM2xl?=
 =?utf-8?B?azlYSGNHeVU0bmZrZnBlN0lqeHNJZWFmK2VJY3RpL1JJMnpZWGVCTy9BRGlw?=
 =?utf-8?B?L3VLZ29naHAwUXBlYjk2akJIeVA2UlVVVFhONTlhQTc4Wi9GNUt1KzdPcDdY?=
 =?utf-8?B?YTNURitLMXhBdmVwdUd5NjZEYlF3Ui9aVXFSSmRXczVoV1FjR0pwKzRzYmxB?=
 =?utf-8?B?Z0FESnVzOFBnd01keDY1NXNkdWtyYy9xVTYwbFY3OXJKUFpsYmhpZVhSZFZt?=
 =?utf-8?B?K1RGbENrNlY4TWwxVHFoM2JQSkh3TERWaDJacHRhVHRicVNoYWJPcjdEcWQw?=
 =?utf-8?B?VjAySzdTOEVEbnJOUWNSZ2FEa2g1RWlGdU5PVUxoRXhvR1laWnRJVGhHZFNh?=
 =?utf-8?B?azVUS0hBZGNYKzRiQy9XUG90R0FFVHR1M1pTWFI0YjRreTFWQm9kaVF1Tm5R?=
 =?utf-8?B?T05qUDZ3Z2RXbWs0VTI5dXByWFFFYWxORFVVMXNaWjdUYWJCMEYvdjFjK0RW?=
 =?utf-8?B?MXBybUVXQ05tcHByNzhBOFByN3pBdXk3SUpiQ3lWZFB0elREODcxWVBhRkV6?=
 =?utf-8?B?SmlxbXdLRlliaDlzbGRGbUJPdHNSMmZtR29nYUk4RVZHcjR5Y0Q2NkZzOW5H?=
 =?utf-8?B?aUpNb1RHV1B3UEkxcThrQXVSZU9OUlhUUktEVXRnZUNVZlJuN21kaW1UUENH?=
 =?utf-8?B?WjRaaTJYcEExdkMwcE9UVlR3djcycVZjTUN6U3A3cEJpS1FwM04xdGxyaThk?=
 =?utf-8?B?Yy9hSVJuTVhCOGhwTDl5Q1Z3RWdzMHJpVnBYQXlCOGp5dzJaUHBmYXdrZzVX?=
 =?utf-8?B?T1FjcitEbmFObEhkZDdUcDRzNmc4KzFXamo2eFcvTWtDanYyYWNkaC9Eek04?=
 =?utf-8?B?eE9RSnVpZnFZMFVTQXBsSVBpeDVFM0xLTlpRY1lmdzgwQ2poZHN3RUFFZ3JU?=
 =?utf-8?B?VE1IQ0loTFNxd3RLbVl5STdUci9CNzBYaFVxaldFcUkrZ0Q0YnBtTEtMTGl6?=
 =?utf-8?B?Q0ZDWDhqV0d1eUYrUDR1Vnd1Zm9mRlBNbWp4MGFEZDlIZXR1Q3dGM2RkbmYy?=
 =?utf-8?B?MGlYOWVobG9lSjhiZUpXb0Jnd3dLZk91ZzZzTkFRempOTDFZazRlYVlRRHIz?=
 =?utf-8?B?OHBxMWZGN0h4d29UR2pScmRQYU4xV0xrQmxGejZwZ2owMkh1d3ZUdCtuM0Vv?=
 =?utf-8?B?THF5NWZ2VHYxUk1WMUQ5Wks2bis5ZFM5dTFLa290c29lVmtHVnF3Uk9zUERm?=
 =?utf-8?B?SWFnRlAzVGErTkd5eXJxbThwVmJYSTZxZ1k3bGNUM3cwWXBOUE1tQ003bDBZ?=
 =?utf-8?B?RFhjeTlmc3hjaUVVTmFpTHJ6cHlVRm9ITlpkSVd5Y1hLSjNyVGlpd1VLYmlE?=
 =?utf-8?B?Q21wQ01tWjYxVytaWHdmV0V1bW9VOGI4NFJLdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:38:04.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9de816e8-abb9-4cf0-dad8-08ddb0fb2431
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001AC.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10116

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Attempt to negotiate the use of AccECN on the 1st retransmitted SYN
	- From the 2nd retransmitted SYN, stop AccECN negotiation
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

This patch use existing padding bits in tcp_request_sock and
holes in tcp_sock without increasing the size.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v9:
- Add comments about the 1st retx SYN still attempt AccECN negotiation

v8:
- Add new helper function tcp_accecn_saw_opt_fail_recv()
---
 include/linux/tcp.h      |  4 ++-
 include/net/tcp.h        |  8 ++++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 55 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 +++++++++++++++++++++++++++
 net/ipv4/tcp_output.c    | 11 ++++++--
 6 files changed, 108 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 2c0a2db6e6dd..8609fb138108 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -173,6 +173,7 @@ struct tcp_request_sock {
 	u8				syn_ect_snt: 2,
 					syn_ect_rcv: 2,
 					accecn_fail_mode:4;
+	u8				saw_accecn_opt  :2;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -408,7 +409,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index fb0d69ee3ce1..7ee85f6b733a 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -279,6 +279,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+/* tp->saw_accecn_opt states */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -478,9 +484,11 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 }
 
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
+void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp, u8 saw_opt);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
 void tcp_accecn_opt_demand_min(struct sock *sk, u8 opt_demand_min);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters_payload(struct sock *sk,
 				       const struct sk_buff *skb);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index f7a85192c86f..a9e30c72d71b 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3395,6 +3395,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3cc9c57d9983..f415ed549339 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -455,10 +455,16 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 	return true;
 }
 
-/* See Table 2 of the AccECN draft */
+void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp, u8 saw_opt)
+{
+	tp->saw_accecn_opt = saw_opt;
+	if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+}
 
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+/* See Table 2 of the AccECN draft */
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -497,7 +503,13 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+			tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -613,7 +625,22 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	unsigned int i;
 	u8 *ptr;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				u8 saw_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			u8 ecnfield = estimate_ecnfield - 1;
 
@@ -629,6 +656,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		u32 init_offset;
@@ -6380,7 +6414,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
 			accecn_reflector = true;
-			tcp_accecn_opt_demand_min(sk, 1);
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 saw_opt = tcp_accecn_option_init(skb, tp->rx_opt.accecn);
+
+				tcp_accecn_saw_opt_fail_recv(tp, saw_opt);
+				tcp_accecn_opt_demand_min(sk, 1);
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6870,7 +6910,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7445,6 +7486,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 5b0f703f23a5..ddf2837eb4d1 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -500,6 +500,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -554,6 +555,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 #endif
 }
 
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
+{
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -715,6 +740,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -892,6 +918,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+
+		tcp_rsk(req)->saw_accecn_opt = saw_opt;
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+			u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+			tcp_rsk(req)->accecn_fail_mode |= fail_mode;
+		}
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a4c80be115e5..4a87380037cb 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1102,9 +1102,14 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
-	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN.
+	 * It is attempted to negotiate the use of AccECN also on the first
+	 * retransmitted SYN, as mentioned in "3.1.4.1. Retransmitted SYNs"
+	 * of AccECN draft.
+	 */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1194,7 +1199,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->use_synack_ecn_bytes = 1;
@@ -1275,6 +1280,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= TCP_ECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


