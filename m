Return-Path: <linux-kselftest+bounces-29293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DF8A663B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 01:29:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A878168DB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 00:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3545A13213E;
	Tue, 18 Mar 2025 00:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="HX0VKdRw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAF117BBF;
	Tue, 18 Mar 2025 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742257679; cv=fail; b=nQxbjeg3RQPNLD457lBJ4bftWsvcAUMWeVTWSAqyNXP+5cJEmmXdE8IibpYLImuyFbuj48jydE8EXm8AubwKG+QYsysGTaOzNjh3xR9gjCaddZic5h6TFd9BAeDJYFCYpA5ZeLcSQ9eHDVIrn14ODzEyBtSLQqNioiXc7EtNbdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742257679; c=relaxed/simple;
	bh=mahsolYvqjcKyHZQnjwgoQTNEvOu+cuEN9bCZBp2VAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUDD/j7WVKgZcHNa9myDqvThnGFIeGc1lu1YqdjsSME1AxcQ9lLho1XSshVLpy+RcvRAvO3hlPbndmXwDID9XqwJ7uVwowHM99+RHM8jBgCzBINHW2xIaz6vbwmmMP2eb8Z2nbt8p7plTJJsUhHQs9K6tp6oSw31tMan8HgUskc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=HX0VKdRw; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CfJleTrYl205cwmlg4hXmXswdFLTol2t/ceHvDZywPD5JDeSg4FaLoWfFq5/tIXas8+N9DmkTAIziBzIwh5tak9j0AE8nX3PsQWUj0iPEn2o/ep2EzDHFmFZCWBZWgTTtZeCqiMDJ6j3kwAx/veXolOdx18t34V/ETlutfxV6FJ8LrgcJ7seGvJwNbf/UtPtufE3U5rEODzBz6iFHLg1W4zVpLp3MshbIkyjJfI00Mn+3cU5F8dyOzLRQGijt6FxKrVtXC26p+uctur2nl4wMV1qzHS9xsDLGeFjZBMoEaHMaA8folIAxdyT4GfLYZazod5XY8PqjmGNJqXOvKzvAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Dk8yx+3negvL+98nHzFT4Zm8MI6WwXlKQKBxKCLLtQ=;
 b=eBDj0HGMTVprGGhOoKyYh4wmrJkgtZFIlegZdrp2tyW9OhFLs1qbkqlyVljdGC6yeqgKCG05aNDTO4dAG4igETiuo9AsAVRqdmv99a6/sDEEneqenjghazBsEgEH5YGJ83mDgQdRR3sUibVxXjGdE/6/2o2o4c+FNePszBoaQ4T+e8wNVgm4X5FLAEmwCqMitJzEA7uOmlX4eQ5IqWHOBZdKmS5DHWPxYfE29ZqQyUzWakWc2Oc/Jt2pxAFplTMlBnjenYT35KKnK366mE5cwVck2gVWQjbkxxDofCRmc3uAXhkg7gXJ2lKh3b0u8mfaQwYs5IhDnWcXsXMVx4tD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Dk8yx+3negvL+98nHzFT4Zm8MI6WwXlKQKBxKCLLtQ=;
 b=HX0VKdRwbVEYWOeHoHRde+VhXthFuuHJ27ALoaTn4yFG12XMjg+KVKH8ujxlXllmFbbYMS0DAfi9PK/YkgWtfcFVzLVf/9p/hhah9/fCCfWbB3UH175kyZbPUr5TgoTf/a6Gtgtd1ldT9X/r8WMK6zCTRzYtUz0PkZq4+kGr2Cz+UVaGPyGWeHl5Ok1waKk3voD2lS5DT1bCycQ6+nRatLQWu64QU0JSuMuVK2m+neZr+GZsJKnx2iS3pHZvr86NCcQ/CV+T4fLMKwPvx295dBhhLvumdUxwL8Y3vi8FqUq5Vg+sQJTAovCBolJmaigGhU1xb6zn/xPINge3eBRGTQ==
Received: from DBBPR09CA0013.eurprd09.prod.outlook.com (2603:10a6:10:c0::25)
 by AS1PR07MB9645.eurprd07.prod.outlook.com (2603:10a6:20b:483::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 00:27:53 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:10:c0:cafe::86) by DBBPR09CA0013.outlook.office365.com
 (2603:10a6:10:c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 00:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 00:27:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (GMO) with ESMTP id 52I0RNBm024935;
	Tue, 18 Mar 2025 00:28:00 GMT
From: chia-yu.chang@nokia-bell-labs.com
To: netdev@vger.kernel.org, dave.taht@gmail.com, pabeni@redhat.com,
        jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, horms@kernel.org, andrew+netdev@lunn.ch,
        donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
        shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
        ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
        g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
        mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
        Jason_Livingood@comcast.com, vidhi_goel@apple.com
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v2 net-next 06/15] tcp: allow embedding leftover into option padding
Date: Tue, 18 Mar 2025 01:27:01 +0100
Message-Id: <20250318002710.29483-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250318002710.29483-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|AS1PR07MB9645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb58baa-c305-4955-1084-08dd65b3b8d7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NkdOZEpKdFU3Y0JCcTM2S1NJdkllMUZRSkVjQWpWTy9FeS9OR2lndXZRY2FL?=
 =?utf-8?B?L05rbnByWjVQYkJUK2l5bFk1V1Z6S3BYL1VsUnZMeTljZ3QwN2ppZlhzQi9Q?=
 =?utf-8?B?M3E0WTZvQytWeUw0TThQQmRoTVBjNkJrMWJkYU5ockRaaHk2T05CSkQySXRP?=
 =?utf-8?B?OVVwQVJYaWVHNWdJYkcwMmEyNjl1TnJqU1pJblZ3V0hTbFdwSnZRR3ZzOVlv?=
 =?utf-8?B?Rm9HbEZZaDlGeXNJR2tNUHpDQllLb0VKMlZLc09BYlM0WFJtSUxGRmE0R3cv?=
 =?utf-8?B?azNOMWozQS9UZzI5bi91MGxCYlVaMEZ3MXltMUp1Q21MNjllUFhVcWxOOXNC?=
 =?utf-8?B?MTViWmgzZU5JRDhTd2xYR2VMejd2TDJ1RU5jeDlGUnkycG9JWmpGd1RCbUgv?=
 =?utf-8?B?YUR3UzFna296V1Y3Y3NyYXpSR3NDc2dPUmJac01sZld4Qzd4Uyt3U1Z1YVdE?=
 =?utf-8?B?Nm5sQTRTNWZKWDJvL0xCUzU5ZG9jY3AzY29XcVhtbUIxKzN1NlBUeFRyZVB4?=
 =?utf-8?B?SENSZ0Z4ZVQ4UkhHTkxoaXk4WEx4QldzalllNmw5bmxjaDA1SWlnVUJHNFNL?=
 =?utf-8?B?eHZTcFRqYXVPUlJQWFVUTmRwbkMyWHFjTHEwVGkrWEVUM3MvcTlFaGRHakRD?=
 =?utf-8?B?SXBrYXFDUDBlVGV2aGRld2NtOGIyb3Z3UkxBS0dXWG9CNTg1UjgvcVpGVFZP?=
 =?utf-8?B?Ym4xV01qcDg4V1hBK1V5akRLeGkyQzJQdXZ6bm1hc1VKWEIzSDdvaG5raUhE?=
 =?utf-8?B?TGtlL2xoZGEwc2kvVzU3akNIUlBmcUo0WTRLR3c0eHhKNklTaE92NEdmazJU?=
 =?utf-8?B?UGFuRzhyRDJmSkNLUEppTE5Ec25HdGZRc0VlV0lMbktQL1dNak5pNk51a2VY?=
 =?utf-8?B?amZERmd5MGVqTWZxZWpwMFJBQ1FTMk1tR215MENwdW9rbWhuQzcvNUVvc0ZN?=
 =?utf-8?B?ZEQ5bnI5L1BOWU5ESE1qU1VxVCtRQjVLNFdoZFVPSzhYdTlOaHBJQUJ1RlNX?=
 =?utf-8?B?bys3UG1yOVJHbGIrdUxnV0dsRFFqbFlHSUwrdmx3RXdrZGI5UWd3dll3NFlU?=
 =?utf-8?B?Z2hnMS96dTQyWHJqc3REN0EzZ2NHczFkQ2VtQ2VTaTdXTWZoS0hpVFNKeC9X?=
 =?utf-8?B?QlNxTTFNbFRZaXFsVGRlazBhRGJjZzVPVXhBbHlOUTlQMVoydmxOSjJhRGlH?=
 =?utf-8?B?OEgyNS9tTkFUTFpVMTQyM1RUTzlXazVXR1hWcGxFSjZpQm5hZVh0UFhwU1Yr?=
 =?utf-8?B?K1JzcXR5VFRUbDByKzdNUmZSOS9ldWw5UnJSR202NjNTOXZyWGJuUDU3d3NL?=
 =?utf-8?B?SjlpcUt5VVYvSXZYOFdyTG1qeEpVbFNUT2I5bVYrUUtFaDF5aUl4bm9jd0g4?=
 =?utf-8?B?Q3NnbDhPRDlhdU8wRHNOUjJKMWdROU4vdHVQaWRDbHdNV1lOM1V0enhjK3FH?=
 =?utf-8?B?dUREMzJCUlc2TEtvZW53QkJROStYNGUya04xMlEzbVJjcmRZdmZxZlZLcm5R?=
 =?utf-8?B?bjNFYXcreC84aTZKaFZxVnpzME5QWHAxaDZRYkhwa1d6RmFjSDlRMklyckU5?=
 =?utf-8?B?NU1jK3pWZis3d0taU1l2WjUvVDZJTHlpeC8zWXRHMmMrYk5hSTVrSDFWM21a?=
 =?utf-8?B?bkNSMTVBUjlRdHJEZWwzVjRhUVBlZ2syanZUYmJLaURZV3JYbTVvNitvQWpa?=
 =?utf-8?B?cnNpTWNoQ0U0WjA5UUtWNGlweUt6R2Z1cGp2RmxMVkhGMmwrNUp3UzBWSFdj?=
 =?utf-8?B?KytKZm1Td1BLOUN0Y3BPcm5oU25ZVGU0ZUtCMm9vTG9OUFBlT2tiRlJRWGN2?=
 =?utf-8?B?VHNJZ1dvSjVROXdwNmR0RTRpdHZ5WU9aeTNlYlZCNzRzUExDRThhRWFVMFBW?=
 =?utf-8?B?VUZWUjZqK3J2cXBBNDJVSDFDVzRaMFU1TEpBaW85SmkxN3E1YmhzbTdKZi9Y?=
 =?utf-8?B?RlY2SDQ2UEFYQ0o1ZmExN2czdkw2eUpqN3pha0NsRkNzUUhmTHdvNUdPZ0cr?=
 =?utf-8?B?MFp1N1V4U1IzVDBXYXpqNjBlc1I0Wnc0N0ZTUENwYmpjTm9RK05zZkVCbWpt?=
 =?utf-8?Q?3N1ZbV?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 00:27:53.0194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb58baa-c305-4955-1084-08dd65b3b8d7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB9645

From: Ilpo Järvinen <ij@kernel.org>

There is some waste space in the option usage due to padding
of 32-bit fields. AccECN option can take advantage of those
few bytes as its tail is often consuming just a few odd bytes.

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 net/ipv4/tcp_output.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index fa7facec04ed..87a2a20243c7 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -709,6 +709,8 @@ static __be32 *process_tcp_ao_options(struct tcp_sock *tp,
 	return ptr;
 }
 
+#define NOP_LEFTOVER	((TCPOPT_NOP << 8) | TCPOPT_NOP)
+
 /* Write previously computed TCP options to the packet.
  *
  * Beware: Something in the Internet is very sensitive to the ordering of
@@ -727,8 +729,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
+	u16 leftover_bytes = NOP_LEFTOVER;      /* replace next NOPs if avail */
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
+	int leftover_size = 2;
 
 	if (tcp_key_is_md5(key)) {
 		*ptr++ = htonl((TCPOPT_NOP << 24) | (TCPOPT_NOP << 16) |
@@ -763,17 +767,22 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 	}
 
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		if (unlikely(leftover_size == 1))
+			highbyte = leftover_bytes >> 8;
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
+		leftover_bytes = NOP_LEFTOVER;
 	}
 
 	if (unlikely(opts->num_sack_blocks)) {
@@ -781,8 +790,7 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_bytes << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
@@ -794,6 +802,10 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_bytes != NOP_LEFTOVER)) {
+		*ptr++ = htonl((leftover_bytes << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
-- 
2.34.1


