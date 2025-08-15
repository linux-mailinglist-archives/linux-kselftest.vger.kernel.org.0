Return-Path: <linux-kselftest+bounces-39080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00929B27B85
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D6E606775
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EB72D7396;
	Fri, 15 Aug 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="rguuykST"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7ED2D7383;
	Fri, 15 Aug 2025 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247210; cv=fail; b=DhLFr+nm31Yo5wWQFdnvE6ohw8jL1JeJDJPmu3Dhl/R7KoIvu0OAWaTlp9O/1BUQFTfgCSq7O/A2cnFgmshTu/3+gJdXUbgkoK2GyNOwMsiIY+CV2loNwvh0odfJdnOo1LWbJDtzbkO9ZyXNDIVc6+2f64VYMcAIprzSqwerckE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247210; c=relaxed/simple;
	bh=cIypRx2+SLh74ghKOyhbKxUH6/CbFzylNAowA87thrk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uDkLqpkuHHKV3WXbFrgMfSKTX5bjSOeR4Az1ecVjaYxj2ltsB5PGMuRxNrhNCNX2hLLCFyaTxUwAJa5p20FKYMqE0/VmSaLE6Dh4tFISdNsS97mptS7QBbdB23XJZlkF2vH8MFwWr6U88170YQKn7JeBgX81RVlnl14dbRWlHHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=rguuykST; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ntWh+CnTrrHF9gOLI/qFrontBokL0HxGOZpVEs2QTaufuFIsRX8pI3fVN3ZxTLw5qZVTGw9ekflg6nKmAkFT1NAA9bFplLpBc1aNgiTT10DktmT9Igbx7S+Q23oVrRvhZ+0VS86U0OqseJwUof90ABQyikOUXopuy1yVYO9Y45nj+/E8+xrHwO3AJV3fnAYqzyvfvJA2ZGxdZFjjWbekWcJiDhCQhwtfVJrW6nXRvhlZxefLWdZqd+g6Y49PgdLbjnMbeZCShxFBDBj03ZWU8aP8h/Wi09z4I+1IcGzUliTkIrt7C9PeEMqGfvgFeBC+zAmqnmiuZRerA3RJuQE1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=inNVaeb/lzhmMP6XVrs6Ay5JhWTk71ZBKEzSGPgYJ0k=;
 b=N0QwMwRcJfY6vfeaJirNxpNjVs2I+2zUZ5nrKpCgZfrEq3XIoqlMuQAfcEZ6u9jW03Sit+/+MJvD6Ww95SMtaX4Gyg05lvL1bPt1saxBsaRwB9cUxB11zhYu82+la9rrFHMHxrm9rsng8nod4Oi0YnERp6XFIcStwgT0HbKmV+Jq0wsq8W6uaqg7LEu630lH/rg4X8XgONUQFj3V6u5Gpp/O4fPWLC3iVh0pUtIK7MYCXoUmpUeIXJCfEFl/k199Jouo27eI+YTHSQPQKmtPFyDAVuZt2z/tQSVbF9wM69qzXwwjL+FtSxd62vpAeaPuslTMmw1Ufhbbkr7t+YKbKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=inNVaeb/lzhmMP6XVrs6Ay5JhWTk71ZBKEzSGPgYJ0k=;
 b=rguuykSTpDKT9xQ2rd/YKKLTh2iO2Zp9U1pcbSvSvUHvfb+ipMf0WqYaJxkYq51XWiRHVrvrpN/hLGQcN+u+LIojQsPdBS34EmqCMPTjub8CSsRtmv4dAxnLCfQ7itrE0U8munF4x+bC0bzWoiEg0ouzF+TtFD8NvYcngHOq7pSD/eLuuLftEVMSB7+sREfWbqPGaaSBd/47aiVzIt+jdacGZjm5IaQP1qZli2spMZj+NIBLWNdtYlMZUCiDXddFdhN35mzGJmb0/08H/v+fmhDzhLVOyKfcKHtwaGJxBSXEMLXx9M+RRBW0Lq+RH7YS//5Hi4siwEelLRWfAfgPzw==
Received: from AM0PR10CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::17)
 by FRWPR07MB10622.eurprd07.prod.outlook.com (2603:10a6:d10:177::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:40:05 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:208:15:cafe::cd) by AM0PR10CA0064.outlook.office365.com
 (2603:10a6:208:15::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:40:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:40:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 5E9991C003D;
	Fri, 15 Aug 2025 11:40:03 +0300 (EEST)
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
Subject: [PATCH v15 net-next 12/14] tcp: accecn: AccECN option failure handling
Date: Fri, 15 Aug 2025 10:39:28 +0200
Message-Id: <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|FRWPR07MB10622:EE_
X-MS-Office365-Filtering-Correlation-Id: 294a4d35-2b7f-4eb5-e09b-08dddbd75532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXQ1aTlWRUFUQUV4MFhRSGQxU0tnQVp1dWdWT0UwUGdEaXlqNytvRC9VNWpn?=
 =?utf-8?B?YUcwN0RRaEJvZlcrNmZkZ3h5RU5iSnd6cWpZdEVzSEVVRjZDWmgzeGczWjZC?=
 =?utf-8?B?OUZHZGVYV2swaTJxa2JMQ21LT0lCd0trZ1oxNmVrcE0xazRkQjhUdEd5aWhj?=
 =?utf-8?B?UFdNNDNNVENwYzFXM3J3Sjk5MGthL0duNVFmQnhWOTJDZE1kUVMvY0dpL29G?=
 =?utf-8?B?ZERRd1BFR0xqNlRibkJYbWpoTWxwRG8wYnZ0a3lkbmo2b0hMV05zY1A0b1d1?=
 =?utf-8?B?QXRjRmN5d29Fb2t1OGNGSXZCVHNjbkt3N2t2R1lqMjk1OGpDK3BXZlY5cUxW?=
 =?utf-8?B?cTBJOFJGYmIxNlh6bk82M0MwNDZZSHp0aUVjTzBHSWxENEtrM3M4RXZvbzhS?=
 =?utf-8?B?bGcwV3Z5WjU0VDFpblRVbktKSGdOWk5lTU5rcnVoSnVzZE5jai9uM3NQWEtm?=
 =?utf-8?B?OHdEMDZFTitSQUE5bjZZVmp0Ty9DZU8xcERsYTB2aS96Zno4OWViTjJQOXBl?=
 =?utf-8?B?N0FvS1ltNHdXbDJ5Q1pqdC8rR3hIcUptdm9KQklhbTk0cU0zcU1EQW53aWZW?=
 =?utf-8?B?em1Gb2UyckpuQTFyNksreU9JYlRORERtekdEVVZpbG51NzgvWHBnYklTT01r?=
 =?utf-8?B?RC8yQkdBU0FnRE5LQTZ3TlhnVXJmL1RmL0tOcUV5WFVBMUdsQ2h1WHhIaHZn?=
 =?utf-8?B?WGkvc25oODhkVHBUbGVOQXRqb0JzZUErN0JqZVU0aWRMVU95eW0wN085S2Jl?=
 =?utf-8?B?dkNhUmV4dGlYSm1hcXVsZFI1Wmx6ckZTWUVkUlUwbjBqS282cjdmcUZja25H?=
 =?utf-8?B?QkZWOURpbmhhNUFsVFFsRkUwY1BKVkdIMjVLa1NJT1lpM0YvZHJwMHdpMUNX?=
 =?utf-8?B?UXgrOGhrWXFuUThoemJQK3NpYk1vbkFDSHRNaDZnS0NGTlVnY3BTcmFKMzBU?=
 =?utf-8?B?MUtUNHRZUTFqdTZmSUVldGtXZzg0cUdPYVVML2tXOVQ5K1Vkdmt3eEFUaCt3?=
 =?utf-8?B?M25aVkx0TEcrRlhsUld1eHo3THpxWHc3MnluQ2R6VjlaTTRjRDdqV0pKQkhX?=
 =?utf-8?B?cWhpaHRHYTExRkNJcitUWGp2M0xya1RwZ2dtT25zdk0venJUL3dFcVZkMFJD?=
 =?utf-8?B?N0RFUG5aYVYwcUJKQldub01zTi9pRjZqZHpIZFZmcXoyNFFHUkI0UWdtUzdp?=
 =?utf-8?B?Q3V2eEMyYzNHbVhTZ2g2ZEVBU1BQSFViZm5YdTBQVGI3UitCTXZFb0lRT2ta?=
 =?utf-8?B?UVVFT1BsM1JIcVd3TnMrRFJLNkREYVh0YkNVVmJKOVlVME5qTDVJOXJINkpn?=
 =?utf-8?B?QktHbmMzejFjQnlVREo1T0ZjcjNaVnY4MnhxK0lBT1ZNV3p5ejJCSEdhVGdt?=
 =?utf-8?B?YWdQcDU2eVNkMDVvek1jeVAwbXc5QnRnUm9yQmN0Q2FYcWI2SXBvNGFLMk9N?=
 =?utf-8?B?MEh3WDdaZTh0NWZXMnYxbHZ1bVNIWmtqMzdkOFE0UXh5RFBldkFVcEpBTENU?=
 =?utf-8?B?REpORGZwUWVmNGl1VHB2TUViaWxweXphSS9McDNHMXRWUld1NzBPbXNsRkF5?=
 =?utf-8?B?b1VwVm9iUER2WW9DcnZNeGJBL2YxMnN5WFJLTklpWmVFRzFXYjUvMXRxTkdy?=
 =?utf-8?B?a3FwaUlXbmFibnhYeDZSUlJzUEN1Q0lMR1ZMN0toNkM0ZUYrN2JGb2dRcFZS?=
 =?utf-8?B?YS9GSkNSS1ZldGt4dHVQUGg0VWZzRFV6VkNVbC83MnREVENKZzhRWCtweDNk?=
 =?utf-8?B?eGU1SmlRVmtOSDVtOWRMSUNNanVGVHlsWS84enRRSVYvc1Z6NnBHVERDcnVy?=
 =?utf-8?B?cTAvUTdxVGRGWjN6bFpCYUhkckt3OGp3M1JNVE9TVHNpbEZHL3c4SGZHWUd1?=
 =?utf-8?B?WGNmbUJsRUowQ0pRRVFZRzlsU3ZHZ0QrMHd4RTBPcGtLcTE2WkJGMStBY2FR?=
 =?utf-8?B?WUQ4VDYweTVJN1ZKc1JaRXdxNHhYOHpGNURTSGFjdCtGVGx6eXJtV01aUkV1?=
 =?utf-8?B?UEdRdFN3dlh0eGpFNm5lNW9QVGR3U2Zod2w4NVJkaWloM0JZMGNTR2tyUHRh?=
 =?utf-8?B?ZlVzejZPbUFySEtrSEk3bWRzYnJ0ODdwWHppZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:40:04.9536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294a4d35-2b7f-4eb5-e09b-08dddbd75532
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR07MB10622

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
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 35 +++++++++++++++++++++++++--
 net/ipv4/tcp_minisocks.c | 14 +++++++++++
 net/ipv4/tcp_output.c    | 11 ++++++---
 6 files changed, 107 insertions(+), 9 deletions(-)

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
index 89a01bc99233..d591c4ce1b9a 100644
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
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7808666bafda..6add6959cc92 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3392,6 +3392,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9db75de542a5..8676b7a512c3 100644
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
index 376f858575d4..e71740ec51cd 100644
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


