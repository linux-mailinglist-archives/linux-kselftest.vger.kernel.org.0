Return-Path: <linux-kselftest+bounces-41585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1F3B5907E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 487941BC1A40
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508E2EC54A;
	Tue, 16 Sep 2025 08:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ZdfFQqOL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53449284B36;
	Tue, 16 Sep 2025 08:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011133; cv=fail; b=hc6sErnR+u+BdYW1MXCnYH67K9N8lvol6kaB6y0KIROrEYO/CpxPBZFoGwLHyKwtfD34lH/3u+91k/94oBcwa7cRUxlz3mF5ms6U34pNXQ8oVNc8rDFtTY4Bf8N95BWixbtR1txuwwlPuvcOuvWXk79GqU/6ptMLvO/4qknih10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011133; c=relaxed/simple;
	bh=peKbn6stK3eB9kWaFb8SCBNF6uohfHhj9/TSvpnMo1M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WiSt9fzpAJJbYuYWBMl5aCgekjLmK2riHxO+mE08KDKh8l81pwcIPu1uDB8uVo8rnau8x1lK3zH6nCJOc8vfbEVV/9Xk5i6WSKlgi6spplTcPRqmC868kdSjNMSMABrcD8MI3hUKj0b81vwUvjUL1nGaiUJNZnBvtn7Ym5PC+pw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ZdfFQqOL; arc=fail smtp.client-ip=52.101.69.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NqClEY1NN96DTZySKIRNEtAY6TBv7rOLYZOPcAw4R+R5EJnno5N3sQlvQ8Qw3EKHtjITCX2tpcl6vCrOC5fWeTveH83tVXNfHQ7OsY7SeEAIDksCs7lOfHoRHAZA8KBhgYCf21pbT6vDUsRSdO3FnYvrZleaiI47lK8cwE/A1GSBq0MeR9Fg67M6BG4EoVMJW78HO0kE8WeSLL+KU7dlskcIDYLnljr1/UObOwfgs4Ecu9yQzpZ8ZI3hJ946n3WKuYFfzxDjkvNTXRptcPe3wcIU9d95HXomy9VDx4rD2vmCO+ClT53mgrwAx4SqWlJkP3cPmI2EUu+Rwez1T4mLeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXIb6DZa+VLtiMVPwKY57GAi+tsF7fzNuL2lZGeDSLk=;
 b=qH0gTJsgV06h/m4rSveElPiTKy63fWtcRb81KbBlU/KjqDJMDAcHCFbEzt94ZgK8Qoq5nw0dhmTzLAKy3t7tkzHKe7ygE4VIegkMvJLRKMLqrikg7gW/UHK3Mnbr9cwwIBm1ib/WPvC2heLxt8KxoSaY669vL83fCbDktSQpfb3i8tb64AqJDmhfAO4Idy9SvrT2v3AYBxt0qdD12HBx8vU5Br/5Q9TtKLs5NEKdPaCOSlScRtFz4Z89gsxQ/1a2Yx28TUkrA1shKcXFw9BoJTbcmNiA2XQyy0J5VB0oQSkmHZjNfxJDr944583HzPmG1ORvY7RA/e7UT1Fxdqxihw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXIb6DZa+VLtiMVPwKY57GAi+tsF7fzNuL2lZGeDSLk=;
 b=ZdfFQqOLh+MD/6Ca2dnU4Ssw/3Ofc/aGjPFPxv0ZLztg/FM3pToE8CxJFUezvcQ2+yDsTBLS1udDFQEixtHeVPN0sSormaYx7/x1leMmncWvQmW4NL0dMt4+FhV08ecWomfY9Y1GPSwZnmVfPwfi/d5JOlYxsoFNSqgo6Bbsv7sbewwqv8LreDiENpR9RkbY3zbnAO+eMYuc2rmlnxYs711p3De+EUdqq+QUPthghvFawiG6z2AE7TFVfVVoginjsLNINSwAuiZSjQEeHI8qW1FHlCf7rF7wN4WUcBjRENiAYdcayKqHqNTIN/jllD5sHwQC8qinhZ7cG2TqoCh0eQ==
Received: from AM0P190CA0002.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::12)
 by VI1PR07MB10089.eurprd07.prod.outlook.com (2603:10a6:800:1de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 08:25:27 +0000
Received: from AM3PEPF00009B9B.eurprd04.prod.outlook.com
 (2603:10a6:208:190:cafe::b2) by AM0P190CA0002.outlook.office365.com
 (2603:10a6:208:190::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.21 via Frontend Transport; Tue,
 16 Sep 2025 08:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM3PEPF00009B9B.mail.protection.outlook.com (10.167.16.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 08:25:26 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id D22C72032D;
	Tue, 16 Sep 2025 11:25:24 +0300 (EEST)
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
Subject: [PATCH v19 net-next 08/10] tcp: accecn: AccECN option failure handling
Date: Tue, 16 Sep 2025 10:24:32 +0200
Message-Id: <20250916082434.100722-9-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9B:EE_|VI1PR07MB10089:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e781248-06f8-4479-600a-08ddf4fa96c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFo4SkdjalhxQXhGYVN6UlpEek5BNUsrTGltaEc2TjBTZngzRXYvandpT1ow?=
 =?utf-8?B?dWpDTEErNmo1Mk5sRVZEU1dXZy84Y2tyT0NQVlFkYm1MVSt4M3B6WDFaTDNP?=
 =?utf-8?B?VE9vWXpHT1dIaG0zRXVaT21VR1NYbG9wWUl3VzcrZ1hLbE9LSitIbVpFMEp5?=
 =?utf-8?B?VkNyNW8zZC9ML2hoUjJZdE4rNGNYT3NGOTdPUzlHSnN6cTRsT09kdmlPcnlm?=
 =?utf-8?B?emJCNHBSVlMxQ0kzNWpsWVFodWtHd2FYVzNoRnFHWG85elBkVFJzZEdQTnhn?=
 =?utf-8?B?S0VqZCs2dG1JaW51TVhYd09DRGE1V3RyVFl0MlNUR3hZam96d0NUQm14eW1Q?=
 =?utf-8?B?T0dWQzVaU05DcGJKc3dKaFpFMHI2OE1nVUhOS2V2Q3J1ZlBxYkxhb3hFTW1j?=
 =?utf-8?B?VUxaV1pkdWxLUmI3THJURXFpOGN5N2pYU2xVVDFvMkphbUtXT3l3MkJXa0JC?=
 =?utf-8?B?KzNPUHdEcDRQc0d6WW1iYkdJSEU2UzR3MDA1aUI5TmV1bXVUV0ZwRVlvbnBH?=
 =?utf-8?B?NjV0ZmNhWTRMNm9YaFpoV20zNFgrYWVYbUpSVzhvUThQSDFwK004dXo5eTFI?=
 =?utf-8?B?MW83TUJ0VTBIUkxzNE9Zd3ZaSFFlZlJiWEVyWkpVS3UyWldEb2hVVHdkMTVn?=
 =?utf-8?B?WE9hSkU4dERXRXowelI3TUhzT0cwSmZNN3pEMEVwZGJKSlA5UG8zRVhPa3Nq?=
 =?utf-8?B?QVRvT3JqMVprOTVLTjJwUnk1K0wrN1hCSFgzaExpMVFJa1crWkRIcjZwbVRr?=
 =?utf-8?B?aHgrVklJQnN5alVtODY3K2FrTDlyZUQ3MDV4cHBPNStpZXVtOUJ5ejlVbUE2?=
 =?utf-8?B?YWliRWtLVVdWcVkxZDE2OWlDYjNkM3VKYTUwNzdCa1Q3dDl1cndtMCs2OFRT?=
 =?utf-8?B?Y1JMeGR0bjB1dzVUaEtQSzBxMWtNL0RDSE9OallqSUVXam5xRUJ4Sk03QTND?=
 =?utf-8?B?UEs3UzUySHJSYUd4NTFmSGxTNUpOcUIySWlaVGZYaXBKQisvOUZPc1U1clE0?=
 =?utf-8?B?VjZwOFRpVkdWR0FYVEJLZDZYUmY0R1JUYThOc1QzbUJEVk5KcXAwSGJ4Vkw5?=
 =?utf-8?B?SWJhTUJuVzFwdUdYL1p2YzMvVHp2T0xqTTJvNVpqTnBsWkwvQnk4YmxLaDJM?=
 =?utf-8?B?RXlLaXl1Vi9iWGxSMXZqTW94MU94NFpTdzBKMHcvb1lWcnc3TERPWGNJT3Rj?=
 =?utf-8?B?Sk5xU0I2dGxtbG9SZjJ2Z0JpejFaZ1BGc0MwbmN5dk9Ub2ZQc3hoQWppWmJN?=
 =?utf-8?B?eTJVN3RyNGNZRlIzUWY2emYvKzl0K3VLMk5Hd1RTZTRldU5DTHhXbEt0T0hF?=
 =?utf-8?B?NGI2TmRwNW42c3ZmMHdvYk1GbEl3MUd3c2t0N3dyREJUaDJmSjlQRTJiZG8y?=
 =?utf-8?B?SDVGU3JVNVQrR1ZlaXI2R2VMdG9scGhHc3oyQlBpNXZxT1g0SkRjNktiQ1o1?=
 =?utf-8?B?UjFGZmhrNnR6cVJXNks1NjFjUXNKY1JNTzVWU3VTU1pWYUdQaEVmSHBnT3ZH?=
 =?utf-8?B?OTlJakxBN0c3cHgxR1NsU3hJUFBxZFo5VjFNMmE4UGVQWWhHZEdyalhIL2FC?=
 =?utf-8?B?RDRrcmtTakhjdGVDNitLMm1OVHVzOC9OdlJkejdYTkk2cHNvWU9YMFVSY0lL?=
 =?utf-8?B?VC9Rc0pVc1B2eXU0NnFRVnhlajE3bnlOL2RHT2xObnMzdWMydW1lK2JSVEs4?=
 =?utf-8?B?eHd5NVBXdUIwL1U1T1lhNEZSUFJFMUg1MUExZDM5dDNDaGJzelZuWitmUjZS?=
 =?utf-8?B?RWFhRVlPZFcwMU9WU0xRZWZTZ0V6eDlmaGRsM2ZQcnZVbzFDQjFjV0NxWXYx?=
 =?utf-8?B?L3VYdm5pQ3MrOFFoMkpQSGxYcjh3cFVxbWwrVEdFRUR2Mm5DN1ZDZEl3c1p6?=
 =?utf-8?B?ZWwvbStHdXZnRnppNVF0N3BxNGdwRDBtVmN1ZWVPc3NCWXVaT0JmMG1YcEVP?=
 =?utf-8?B?VkNkQ0U0SGNXbnVsNzJtdHZxUWQ4ZUFXNHpiUWZXOXZVamc4MHhTQXdZQ2ND?=
 =?utf-8?B?M1FwVlgwaDBmL1doditCSUNEam1oYkhRZ1Q2b29yNWF0UkxhOE1lVStSTnFG?=
 =?utf-8?B?Zm5nU2JEYzZjd3ZKa2dCbm1YYUNBNGI0dGNPQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:25:26.2606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e781248-06f8-4479-600a-08ddf4fa96c7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF00009B9B.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10089

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
v18:
- Reorder tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info

v16:
- Add tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info

v13:
- Return TCP_ACCECN_OPT_FAIL_SEEN if WARN_ON_ONCE() is true in
  tcp_accecn_option_init()

v9:
- Add comments about the 1st retx SYN still attempt AccECN negotiation

v8:
- Add new helper function tcp_accecn_saw_opt_fail_recv()
---
 include/linux/tcp.h      |  4 +++-
 include/net/tcp_ecn.h    | 51 +++++++++++++++++++++++++++++++++++++---
 include/uapi/linux/tcp.h |  2 ++
 net/ipv4/tcp.c           |  3 +++
 net/ipv4/tcp_input.c     | 35 +++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 ++++++---
 7 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index f637b659b35a..3ca5ed02de6d 100644
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
@@ -407,7 +408,8 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
-	u8	accecn_fail_mode:4;	/* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 133fb6b79500..f13e5cd2b1ac 100644
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
@@ -146,6 +151,14 @@ static inline bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace,
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
@@ -428,9 +441,35 @@ static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
 	}
 }
 
+static inline u8 tcp_accecn_option_init(const struct sk_buff *skb,
+					u8 opt_offset)
+{
+	u8 *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	if (WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1))
+		return TCP_ACCECN_OPT_FAIL_SEEN;
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
@@ -469,7 +508,13 @@ static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
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
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index 53e0e85b52be..dce3113787a7 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -323,6 +323,8 @@ struct tcp_info {
 	__u32	tcpi_received_e1_bytes;
 	__u32	tcpi_received_e0_bytes;
 	__u32	tcpi_received_ce_bytes;
+	__u16	tcpi_accecn_fail_mode;
+	__u16	tcpi_accecn_opt_seen;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 090f9ac43d4c..5b5c655ded1d 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3409,6 +3409,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
@@ -4287,6 +4288,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	info->tcpi_accecn_fail_mode = tp->accecn_fail_mode;
+	info->tcpi_accecn_opt_seen = tp->saw_accecn_opt;
 	info->tcpi_received_ce = tp->received_ce;
 	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[ect1_idx];
 	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[ect0_idx];
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 87154fd86167..5732f2d4329c 100644
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
 
@@ -415,6 +430,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
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
@@ -6123,7 +6145,13 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
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
@@ -6606,7 +6634,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7177,6 +7206,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 193343494558..327095ef95ef 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -463,6 +463,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -678,6 +679,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -855,6 +857,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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
index f897c2594954..65b90f73daa0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -985,9 +985,14 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
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
@@ -1076,7 +1081,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	if (treq->accecn_ok &&
 	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		opts->use_synack_ecn_bytes = 1;
 		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
 	}
@@ -1156,7 +1161,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	if (tcp_ecn_mode_accecn(tp)) {
 		int ecn_opt = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
 
-		if (ecn_opt &&
+		if (ecn_opt && tp->saw_accecn_opt && !tcp_accecn_opt_fail_send(tp) &&
 		    (ecn_opt >= TCP_ACCECN_OPTION_FULL || tp->accecn_opt_demand ||
 		     tcp_accecn_option_beacon_check(sk))) {
 			opts->use_synack_ecn_bytes = 0;
-- 
2.34.1


