Return-Path: <linux-kselftest+bounces-36530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6C6AF8D44
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BBB1C83BFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7982FA64E;
	Fri,  4 Jul 2025 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ol0Y6eio"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013020.outbound.protection.outlook.com [40.107.162.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1339B2FA627;
	Fri,  4 Jul 2025 08:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619341; cv=fail; b=dxFJp+uSkAZDvQD/xAwEDI83fngH9B88mncA6w/Nqp7NoasCv5hcQ03/aA0D3YDemJCwDwbARQAg6/mNzlRG1+k5mnzxYDdQ62T7cIziDuMJX3wq4Yws4FDKVB2iihZspwSscmpB8/6zMcJUzJrR581eDAJc/qc7t4xHfODGDzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619341; c=relaxed/simple;
	bh=gq1aBQBpqzgXNWSUEeP94073kXsR0bwlPocbxWB5dHA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AQg5X4eaDVWcE2m/omBJzoBRF3+VRjoyFW7IQzdf7fdQjN7uWs/S2YxBCZw5xUSplbCGbmhf/X21nYzXboMMGIyUHQnYDm4TvzCDzC9pDYvPD1JtT/NC9BJ4wqgq2hdYmStWoCksjGoac+SmB9CphTFVERDXZetJ3BbZaFxfJPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ol0Y6eio; arc=fail smtp.client-ip=40.107.162.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywE6NYKIe4MfXXLyZOSCeY3owqsma7xL+YdCJtUtGs5bzcb1NdfUJ5329dxa32IQz7KLDRGbgBL9mMnw/hq/41uqj13tQ8FmKkppb/3j7Gh91b/LCf3842UghTuY21ONqR04vHSZ1M7D52qZvBoo9O0RMvAr/SnxdlLl7FvFQx3UOg5lJsB+WR8yKymJwD1PUBWhaveSd1Jmu4k4Zp7Jt+wi31/K4cSFwkDzmN/VDF0ds5Iyw2F2Iag6PWasKyKLyM+Aq4hrSICiB2ZSnGN4oSOejlTNLw9hz/NmNwgPNgW07LP84R8GKxgCj/GuEC0PoZmPrUz3cX1kM2bV0Vv47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36emPlVjts8w9H6MMf1NQTC+1p/Ehg5SZfz+kObYQg8=;
 b=MWp5cSUCDhxfrDRJxqiKU0NG0Fs+3l27/ryjULaUUQiHVptMVGg82c94eCiVptmpmgSUiOBBJ/kCihcaIE0LvBpPPk/rdhaqzEdFTP0r6RM31y/14zyiJU3f7lyiV8t/PxJVyFfk9i0ljAhH0IkmeKYomztE58rXi0ye0QTtLbqJ0WwDn7RdfmTptowjG/T+3nzY3k3vSZJxT7m6MeJ3OG3zEV2yM4qs+l4WE3pNJChvFyASNSCXDrWOTyK/yaW93zTf3aVMG9IFtK7LDgJklf7+vcB+PGtDs9otvEm2QZXbr2gh+QQNCsWKNq2UgPIbDVs1EwIQgcVVa/Luhsf9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36emPlVjts8w9H6MMf1NQTC+1p/Ehg5SZfz+kObYQg8=;
 b=ol0Y6eiokwvDGuCrP4XlvkuiKW5HkOHiGOagyTSuZFWucacMR/0oIgEoWKKS3hh902rwZjdF3oH9yqnrI38DkpX/EN7gLiXLSaX+IOKd/lAZvOizqMYAdfNBviYKw/56Kle8pLvTuSb9YSgXsMOzkNd+iPUYkYg8Rt0BsDRk6mm+RtD/enYLO6Cb48DYhWJnxHcXFTDMLT/sNqu5qX8FD+Uiom42PNU4jfJ+QP5HImQnG8yhp2/hGCYSjKNOA0+T/Y9OkOJ+E7JBPFR1YrpsxIfDfwrHG2aEtULx2C9kzJkQzRISQ04qAXRQ3WocRPM5rtP09KMcWXLAwLNj1tfQjg==
Received: from DB8PR06CA0008.eurprd06.prod.outlook.com (2603:10a6:10:100::21)
 by PAWPR07MB9249.eurprd07.prod.outlook.com (2603:10a6:102:2e9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Fri, 4 Jul
 2025 08:55:33 +0000
Received: from DB1PEPF000509EC.eurprd03.prod.outlook.com
 (2603:10a6:10:100:cafe::7) by DB8PR06CA0008.outlook.office365.com
 (2603:10a6:10:100::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.24 via Frontend Transport; Fri,
 4 Jul 2025 08:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.241) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509EC.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:31 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 23D0420138;
	Fri,  4 Jul 2025 11:55:30 +0300 (EEST)
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
Subject: [PATCH v12 net-next 13/15] tcp: accecn: AccECN option failure handling
Date: Fri,  4 Jul 2025 10:53:43 +0200
Message-Id: <20250704085345.46530-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EC:EE_|PAWPR07MB9249:EE_
X-MS-Office365-Filtering-Correlation-Id: a048f1ea-9aa6-4104-b43b-08ddbad88833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eXk1dElPa1V4SStsWVEwd1VsN04wOGpIci9FWktlNlUwNmhjYXRydmdRcVd0?=
 =?utf-8?B?RU9zVEcreDkrWm1kYWhkakFReWtRUDk5NDZPaEcvN0hGVEtublJXTnUrYkJL?=
 =?utf-8?B?dDhrM2JPQWdtNDFwSW1KTFRNWThLbjdyZXFPajBOS1gvTkwzc0wvNlhWYjZ6?=
 =?utf-8?B?Z1BFQzFXaGlMbWlpTURvUDhOTGV2RFEvcDZhN1RTYU45OERHTG1CeTV1ODJF?=
 =?utf-8?B?ZmIwQldkeXp1THpZcnc5MFdQbUQvbUhGUGIzdXpqWlVGMmw4ODVJR1lNWWpN?=
 =?utf-8?B?bGJkSVR3NnMyR3ZmUEVuVUFSY3EzZlJmUTh0ZmpXTmZKaVRoVStvNGNRcWdN?=
 =?utf-8?B?SG9GQlF0dmYrcktvVy96WHByS3ZzS3J5ckI2Y0l5TGlNbFI1aU1XTXZOY1Bv?=
 =?utf-8?B?aWJ1dmhOTUsrdjFKNFlid0cvZkpaeHA2R1lPakVJcFB6OHE1RlhwWkdkTEdw?=
 =?utf-8?B?MHdtcmluNUp6QU5xVUxHSUpnNittTkVjWW82U0JTT3JQSDVjK2VTNzhVbTh4?=
 =?utf-8?B?blpwYjBGaTZOMGwwajVDSGdUZ0FWajNWR3hMVkkwUTA5YWVWZXh1TXdBWVVw?=
 =?utf-8?B?YllwWTRrK2oxZHZxQVgyZS9kaGVxWHRvcmtVWGgydHIyQ2xFNUhZdTVuc1Z4?=
 =?utf-8?B?eHRXTFdGT3AyK1BDT0F3SlJERkRTUTVidmVud2JPcGZxZHBKWmpjK2NhVnVM?=
 =?utf-8?B?WlplMmNUL1NMQzZGbUdvZk5CMXJkZkIzaUFHSnVxem5OdUxZZjF2L0F3bmY2?=
 =?utf-8?B?N3AzQmhCRFVlQ0F2ZHM5WWxSZnh5Qm9pL0l2SEluNUtKbldNQ3VGMVY4MHc0?=
 =?utf-8?B?N3Ixc2FTZmJXalNGQVE2dUFFaEFUY0JuU2haaFlBenNlaGYxazBITnoya0NW?=
 =?utf-8?B?ZFB2bnpyUmd4MXhUazFWOFF0K0xQMTFXYzJqSXJydTJic012a0ZGK29BUnFY?=
 =?utf-8?B?cC81ckRjNzJValpzNk9LK29zUEZ3L29sSDJrMFJZZE9DRG5udXg0ZG1YaDJB?=
 =?utf-8?B?UFNGM2lxUVB1K0dGa1ZPSmxwRE5OTjczTHFCQWt2V0FINEJQd2xhODJ3SzV3?=
 =?utf-8?B?ZUFzT3UyR0k3NG4rYVJLb29ONmxkTk9oMlY5eDZpdzd2aHpnTDVnM1NWbnJE?=
 =?utf-8?B?dGN5UWhyWlVwMTN5R3hwV0NqTUlQY3J5U1lSNnQxK3o2eFJGZnNraUFJdDVy?=
 =?utf-8?B?SW11cWZHV1ZwanFxRFJMVFF1VXRYSWdGd2pWWWt2akdXMFRObmNvN2RRY1lD?=
 =?utf-8?B?amw1OEs4RXlNbkZwTERySXJtWDNHeGNESzByYXFDRkhQcFBlNnkwWm1sc21y?=
 =?utf-8?B?eGRGTjQ2b25tOW1UbUxxYVRWU2poVHhPcTFlRlZrNFp6V0VtcHVPRVFicWJD?=
 =?utf-8?B?S1Vyc3dyUlJSSEFVcUtMWTdCbnJheFpBRWcvMHZqcmxNOGU0dnhtSG0wbnAx?=
 =?utf-8?B?UEJxZ3RqVzNrYjBaVkJ4TE9jeERoTUZKQ3dKem9wcFBNMDZmNXVkMDhYVGdk?=
 =?utf-8?B?OTcvM1NmTGRCdXBVQ056anc2RDhlV3EzT1FBNmZ0T3pYa0NFSG5LNlAxdmR5?=
 =?utf-8?B?U0RJdkFxZEhsaVdPSGFOUGlRR2RJUFFYVUwvVkNSWGF6SmE4R2hFOXc2RFBU?=
 =?utf-8?B?L0VObzFlTlg1ZmZMNUJzcytjNXRObDNENzliTmJZcDFXaWRRakpXSWFMVHJL?=
 =?utf-8?B?SldFc2paUmJVWXRTWk5WeUJQaW5xcmt2UTNidmNQS0lSRVJkeEttYStXZ0pH?=
 =?utf-8?B?MkVndVlWQm9nQjZ6aTBxdzdMNS9HNUN4N3Z4T1lJM21wd3dSTFBwaHc5SEpk?=
 =?utf-8?B?RVBwWTJUY3pqaTFBTUhvb0VsK2JUQWEzSjlwczlPTWpROHhheUoxcE9rNFZh?=
 =?utf-8?B?OHpNaUtDSHd1OGtnWmNaSDIrVVJLZkQ3VW9ZVDY4eWJyRGgxQktZd1pKUXpz?=
 =?utf-8?B?TWE2WG4zeENEbEYwY2wxdDAwWUxlMC9KdXQ1N1dZOFlWeGhZR0FjNmJZcjV4?=
 =?utf-8?B?ZXU4cEhUejVaWGNsOStMOWpYaVkzZTE2eEhaZ3Y0VWxmL25iQVJTNXlJN2la?=
 =?utf-8?B?eXFWVmxKR3JXR2ZRQXUxNUdNenlKNFpuQ1Q3Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:31.6460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a048f1ea-9aa6-4104-b43b-08ddbad88833
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9249

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
 include/linux/tcp.h      |  4 +++-
 include/net/tcp_ecn.h    | 50 +++++++++++++++++++++++++++++++++++++---
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 35 ++++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 +++++++--
 6 files changed, 107 insertions(+), 8 deletions(-)

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
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index fa13fa0b7e02..ce722551614d 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -91,6 +91,11 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
@@ -151,6 +156,14 @@ static inline bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace,
 	return true;
 }
 
+static inline void tcp_accecn_saw_opt_fail_recv(struct tcp_sock *tp,
+						u8 saw_opt)
+{
+	tp->saw_accecn_opt = saw_opt;
+	if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+}
+
 /* Validate the 3rd ACK based on the ACE field, see Table 4 of AccECN spec */
 static inline void tcp_accecn_third_ack(struct sock *sk,
 					const struct sk_buff *skb, u8 sent_ect)
@@ -443,9 +456,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
 	}
 }
 
+static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
+					u8 opt_offset)
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
 /* See Table 2 of the AccECN draft */
-static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-				      u8 ip_dsfield)
+static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+				      const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -484,7 +522,13 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7bfe763da9f4..ec001f40307f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3394,6 +3394,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 103260fc9130..5a8f5ca9efde 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -398,7 +398,22 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
 
@@ -414,6 +429,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
@@ -6092,7 +6114,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
@@ -6582,7 +6610,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7157,6 +7186,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 848c756a37b8..fd80e24ea30b 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -473,6 +473,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -688,6 +689,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -865,6 +867,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index 65ef1c3c97c2..560b0ca54bb8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -986,9 +986,14 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
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
 		     READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		opts->use_synack_ecn_bytes = 1;
@@ -1077,7 +1082,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -1156,6 +1161,8 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 
 	if (tcp_ecn_mode_accecn(tp) &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp) &&
 	    (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) >= TCP_ACCECN_OPTION_FULL ||
 	     tp->accecn_opt_demand ||
 	     tcp_accecn_option_beacon_check(sk))) {
-- 
2.34.1


