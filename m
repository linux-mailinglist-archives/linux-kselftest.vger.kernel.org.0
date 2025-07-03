Return-Path: <linux-kselftest+bounces-36386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFBDAF69AE
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE931C47000
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B1529B208;
	Thu,  3 Jul 2025 05:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="EiiFmMBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012011.outbound.protection.outlook.com [52.101.71.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02EB28FAA8;
	Thu,  3 Jul 2025 05:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519949; cv=fail; b=oChv7OqpkGyWcgStYiNiUH8ZGayKgMxauoi69arvCQwkYd77h1Sq9c0tHDeKU8tKf4yRHHXPVnXHSVbN3+FudxvkhP52azPS8JaHPDobqqnoJMvCSy2ZQOcjg6shdojzhMoEFo8LxfZRuQ7oleyZWtpUtXa5Dj854cRwx53PUW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519949; c=relaxed/simple;
	bh=e65vpy8aP06p/9EIeo2gEdPW2UfSA1eVrLybu5PoYik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLvhQf8BsgoWXqZFhj+vCQwmXb4ozbGauLYYdJ3/IXYuX44E7risceBVyCiG1gzneut/z982q9+WafURO5jRbE38OOuo/hLe5TMxUckMCqHFKh1UgyptaDjSMDa+8dG70sWfEhiUYJAK58ZNPpulXaTDliQmu1rzMM1mIQ27MGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=EiiFmMBb; arc=fail smtp.client-ip=52.101.71.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYSVKmQE7a2m6d6Ibdi/BG+S7c2iBvG5mKBmpyZrBJu8+tIKrQp7C8wwvzlOKHGRMJuOvcAMBehUCagqi/bhHbQO0QwGpsUEseT+ThUhmXnCH+lw2PEPsqEo5EU8K9PFzbqaeFlxHU0LFoK3D50SR51cHO8/eIZGiSjNs8R7tvyYrEhWOKjW8f/s1Y3ICvb0OqmzzV0/Q+unD0meG/PxSfVhtx6Yr0kwKifMAmDsEtNsAU6/QGMij4RlL1lBXee/cJhlUxSqxi/rIG60SlSscmBPzVsAlgrjlbPZSca6TrC55Y3X7e6Zg1Mgzvy/C2P2oYPb+3yzSjHpUJQkxz1GQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXnJB+fXW1KaQ3+mOgx+929+1xYTBxmT1e5aPdrUkBQ=;
 b=Nfx1bfIKbDe0M/n9rT6grmaDNoaHk9S5+v1/FFEdD0jOdkkgE6PiTeqaAe13Y6qKd3AJqWRNiOsnJ4zhq2OWDqK/t39YYO0FEz7n7uJhx6Bx3pxA6NNSYtj3DS42TuAe7z1xflMh+JsGiA5u4oWCwYTFZpl1xHkYRC/jM61QET410Ei9u8/K+/FQaKTvBnt/q76t6jpdzFFN+cm+wi/13gJ0xZUJIox4rLMnnWXPmByh8NOLdrDqfH50O3GhoCOk6iQkbk7y0J/rYVtv8JsiEUAJxl6Pw/tknHcxyfCkqW8vO/FLIa/zvTMwhblX2zsOOA6Xtc41djB+h1Hc7VnnJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXnJB+fXW1KaQ3+mOgx+929+1xYTBxmT1e5aPdrUkBQ=;
 b=EiiFmMBbbU0d4FIlF5R3bZ27bxH/RSnBUHTgxOIFck0RD14r+D0tUd0AFnygDjJFqwx9sgYlyRDNadCroQPfZzKRjjAWoiWPEPOeZM1I1L65wFpljJUtVS3K1tP4ZhbhsbaNfUWeZMzC63AvHLg/SesRCQXcIgwd2bxcW+5pr4r12jI18JCh1nEfVYIib5F9rjN9IME2uB1HVJXiACPIc12LFGEvtFTq41vIZ5Md4xmuXAIec9mEquy+T+3YjJoWyAu5JNoyxjabyJcvsOSn7LtlKouTTL3ORNZ6TDlrye4yP9cId/Fxy0jmadZR90/AFC5MAH0DwnhK3asCq0gGkQ==
Received: from AM0PR04CA0076.eurprd04.prod.outlook.com (2603:10a6:208:be::17)
 by FRWPR07MB10267.eurprd07.prod.outlook.com (2603:10a6:d10:19e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Thu, 3 Jul
 2025 05:19:02 +0000
Received: from AM2PEPF0001C709.eurprd05.prod.outlook.com
 (2603:10a6:208:be:cafe::d2) by AM0PR04CA0076.outlook.office365.com
 (2603:10a6:208:be::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:19:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM2PEPF0001C709.mail.protection.outlook.com (10.167.16.197) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:19:01 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 761FF200BA;
	Thu,  3 Jul 2025 08:19:00 +0300 (EEST)
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
Subject: [PATCH v11 net-next 13/15] tcp: accecn: AccECN option failure handling
Date: Thu,  3 Jul 2025 07:17:26 +0200
Message-Id: <20250703051728.37431-14-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C709:EE_|FRWPR07MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d813d1-c39b-4c76-7274-08ddb9f11f55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MUVJWlpJam1rSnEyaW13NGVuNUhnZnJnUEZwb1BTMmllSjh1WitudVY4WkRW?=
 =?utf-8?B?YjA4bDRrMjNMd29VTWcrUkhOMHJSS2Q0NEw1RnlGYVNCeHNHcVE0c0p1b0ZH?=
 =?utf-8?B?Ym55elJqSXV6K2RMcGpLUEtmR3VRbGMyeVNLYmtGUnVVSzBpNTZlek03MWY5?=
 =?utf-8?B?TklEb1FJSmM3dEpxZUloM0plTDNDTnNUNGo2NC9IVndvdTFod2FTN0xJUTlT?=
 =?utf-8?B?M0lheXNNcDc0dVpCSkUrZ29sVzQxY1JnR1NXS0ZNeXJHNGlPSkJldmp1UG41?=
 =?utf-8?B?dWxZeFdQdVJoT01VdGFTNld2a1ZkVHJXRzN5OW1vVjQ5OWY4M3B3YlJlb1Ir?=
 =?utf-8?B?MVh6MTFrUmZqRW9UVmFoQktoaFNlMXhndXUvbEtKUVNVWXBJQ1ZNLzlyb0hH?=
 =?utf-8?B?STRtZTVHMmdhSFhBaWFEd1dWU2pIUVpWM2FmMGdwbzVZWVlaZnl5ekpCM3k1?=
 =?utf-8?B?RThnMFdtK2l5YjVPUkI5VWw0REgyMW4wdy83MEYwQWNRZXR4NXFqK0FVZ2Rn?=
 =?utf-8?B?aXVWZ3lpeVQ5eGRVaDY0eXVQVER3YVc5TUJXMzhRZWdWQXJwd0lkbUNvaGpC?=
 =?utf-8?B?SW0wN3VHK01HKzJBcUU3Nk52VkhGR2xraUNBbHhlSjFVQXprUEdLTHQ4bmVn?=
 =?utf-8?B?djlQb1M4aVBnU2ZINmpUK25aUy9QaDhHbHBrTnlPZGhGSmpla2RJbFpKemJq?=
 =?utf-8?B?ejQwWXpma2ZCRkkxTzh6eVpwV1ZXNEdnRTVYWWQyVFIwbXV3dW8yR0NmMDQv?=
 =?utf-8?B?TlRHbzg5M0FIK1NrTExSSG1HZC93cXZaZk42VEg1SGNGUXdDWHdLTmhDa1dH?=
 =?utf-8?B?YTBXVWU4bEtqTmxtV2x5Y3RhaFVTeXgxOVgxWnZwUTZEWlJtL1BVMXR2UUxx?=
 =?utf-8?B?MjNCTHNQa0RlVWRiOGxnZ3kzeGVuTENua0FyTW81d2FSTGhLWlV3eWlUaGpy?=
 =?utf-8?B?VDNqMnF1S0VUMUNqa3JxOTdXSElueE5YNTJYNmp6Uks1a3p4eklDUGcwNVFL?=
 =?utf-8?B?TDljNER4c3hYV3YrNGZhV2dxVWVneVpvYU11RWVwNHpCNE5UTEQ3Ry9xVEUw?=
 =?utf-8?B?SmJkZk44MVQwTXdBeXJQQkVSNWJnZk5qeEdUVWlFMXlMRkxETHdJcWd0Sitt?=
 =?utf-8?B?TW96L0NQUXJSS3hOdmNBTmxETmVaWWxGc1FDWFJhbXdJU2tIVHhaODhHSlcr?=
 =?utf-8?B?R2FlQzh4UHJDN01GbG1IR3pqWWVqd3RudStiT3duakxOTzBudjk4NjVpbFpm?=
 =?utf-8?B?Z2NPem02ejI4ZCtVN092MVVUV1NaZTA4NWZTQVdlcFpFd3RKd0dXbWRZNzdy?=
 =?utf-8?B?eDhUcVhndWY4SFErQ0VZd2lHNDVFRTQwSDVtQ1h2ZTRHbjFHeG1QV0RieUxS?=
 =?utf-8?B?ckh2dEIxa3pvOTB0TjlhdFZVbUd6VzJiWEpqS2M2dDZhUDAwaW5DYStVLzAr?=
 =?utf-8?B?amZFSjZNS0xWTGloMElQYVhRdmQ4WmpnR0Z3SUlNdERCeUF5MFlvQll6Nkdj?=
 =?utf-8?B?dWhxUlhiNEloMkRvT1d6aEhBTVVRaVRRbFUwQktVREg3ZmU4bVRjczRxc2F3?=
 =?utf-8?B?LzJGNEk5c2lSeFQ4bEZEN1IzRVN4Y09hRW5ZZUVmQjQ0QlJzWGNDU1VCbnlR?=
 =?utf-8?B?US9uTElSUmxWZ1UyQ1lsaVZZSkpvYU5mS0JFd1pFbFhmVmw4MnQwaW01QWNv?=
 =?utf-8?B?MmYxSlFDSDloQ21VeFBJL3VaSW41MW9uR3FGQ3NGd3BmdnlQSlVqeVNucXhm?=
 =?utf-8?B?eUovSXVFUFM0ZEYrcGhZcnU2cGlHNnk3cmoyNnpBcitFSTdkeUtBbjVYUHZL?=
 =?utf-8?B?Rm44VUhia3hWMU13OXRmK3NBdVN0Y1B4Vk1kcy8zamdvc0MwdWFKbGJmcVRE?=
 =?utf-8?B?Yi8yb1NPREJTaHNsdGcvV2FncHR5aCthWjJhcVp1RWovVm42WU1kU1pHR21l?=
 =?utf-8?B?a2gyT2xyYWtvTkJvZ3B1U25tRXFjcFFHZU5nZDZHaG1sN2VyUUpzM1YzWExC?=
 =?utf-8?B?UUN2YkxYViswTWprMng1MWp6MzhCVWVNaHZOWXlhNHc4T015R2VnYXp3RGdL?=
 =?utf-8?B?aXRmS3F5S1NISFNHNUx0a0Znb3NCMmo1MmNFdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:19:01.9747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d813d1-c39b-4c76-7274-08ddb9f11f55
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C709.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10267

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
index 667f4df961b3..1f6394405c4e 100644
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
@@ -428,9 +441,34 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
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
@@ -469,7 +507,13 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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


