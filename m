Return-Path: <linux-kselftest+bounces-41242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BDAB52F9B
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449557BC89A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A5A31DD9F;
	Thu, 11 Sep 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hLxD7LXT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D481231CA7B;
	Thu, 11 Sep 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588840; cv=fail; b=WaNr71L/u8GM4oLCLP1S5H/Vyu6UIZh9TwluMIkBMkeWmmf+TU61xUwSujvMaT9IPl6K1QreuWVgKBoNLNvU+mIOPryqxfwJcva1u5Aq5uqiryYgLue3mzpoNGPLjPFl6nchuEhk19E75jvegJO5ADtbr1vokO/0r3blhjhvUuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588840; c=relaxed/simple;
	bh=XPVkbZkj7koxR4w1cdFb0mrQgdRdBjU1WthGL8D5ZAQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aRlQVkPwM1sm5QvHdxvZCTi0L5L5J/KUU1cK59oLjwL5LlmTkao86K1xUa5YUkdQ+qxo/SrJfeQx18ISm6xRYe5/C8jRehOveU5d6CGNVX6E1TfDtvQDUp+v8/zQdU8aM0d9s7sPL5TOZxxxMGoHjMl06LIMvqHEcQzwKq+pTeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hLxD7LXT; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TOGfq41NDY1rzIY8jx4grsLBabeXIUXvaeOZadT7yv64Fk58azlE5xeb54rfyysc9V0vUaOEy6XTv68LeIiFR8nmRYdMqC4t5HHrpnGGi5k4FPgz8i0Tm9qhtM9cVAXrt8v+FST2ktkwtvHoXjJs8CdMd/oubDtNekMNj+CMg4WgHYsONNl5YxavHsXBSR1EzDXSm0ZpcvSXoqBMgTJBxxYzfX29KozsNPu40QBm2t8HE+V9K80Br/mputF9U1Xq3s5D8m8eLm7c/nmWbRjtij0X9q1iEE32WIlkjBIgkzvmsJfPYnghF2JonCPECgcYYxH9RwfNK5yb6VMgLILg0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDERhCjmCqtwXcwthksjmYQf9R+Cd1ScNSvk7AkOCd4=;
 b=sGM3KzbXJs2/fmXcNuya88ms8YiPY+JJCj8NLj/PWAD0kNTzXHjlFbmjjsMEbj/7NSz9TI47lRa7dMqDrIVG6PAIawA8HCIZ0oHbqd/iM4Kq05ww+Fb/izKZ9xnGI1QzKCDvJD2VFUVOT8p4//MR9QEkoGfJ3OX3Ya35ciB362JpeKQ35ADBnJTOouxfWtoBTjMf5KX0wMy9a6fsgul343Xh7GnPJ+7oDh37JpVpsvX5nRV2WbliAhup3js0x2t1AgeA/8e/ep07pZXQ5wcHVdRKAq6VuQamOjhhS/0V1I3F78YP7CUh6zyN4MoEEeQCK6Ar8IQD1zrqkKYYOuriOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDERhCjmCqtwXcwthksjmYQf9R+Cd1ScNSvk7AkOCd4=;
 b=hLxD7LXT2xuQzLNj/BCYzaUaOd1qmxMrEAGGiaDKxhwy0Csqx+xNmPP4ucUvXfJMJIVCVzbzDBFTnK2WEYhQ7PRlx5EQXw0PzmV78QCuAkZGAYSVcpSqjgxYdtQOlq0c1wfa60jfzF33I2xS2uon8TyEO5+eaTKljXm3lyPF+ugZPe+fT+Sg54enwtaLS27CKAvdAFpCvxThXpjNfsE13yq70RQrzhcaVuJuHsWdHe2+mf8v4LhGDGlkY5RDQbj54Uhll/59glx07sPalszoV11t7oSdR/CWCJqZuZ3uT37GrHu1xoUQohxmwq/6uE8ta1n7OzHjvVGDfa/5ZzC+YA==
Received: from DB3PR08CA0018.eurprd08.prod.outlook.com (2603:10a6:8::31) by
 DB9PR07MB8609.eurprd07.prod.outlook.com (2603:10a6:10:305::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Thu, 11 Sep 2025 11:07:08 +0000
Received: from DB5PEPF00014B8A.eurprd02.prod.outlook.com
 (2603:10a6:8:0:cafe::d2) by DB3PR08CA0018.outlook.office365.com
 (2603:10a6:8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 11:07:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B8A.mail.protection.outlook.com (10.167.8.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:07:08 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B6DDF203B5;
	Thu, 11 Sep 2025 14:07:06 +0300 (EEST)
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
Subject: [PATCH v18 net-next 12/14] tcp: accecn: AccECN option failure handling
Date: Thu, 11 Sep 2025 13:06:40 +0200
Message-Id: <20250911110642.87529-13-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B8A:EE_|DB9PR07MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: c0902a80-1c8b-4fd9-3e20-08ddf123596d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk5oTFQ4emVGRS9mcTVONFNQTisvNzFxVFJ2dU1KMW5XNm5HY3I4eG13ckc1?=
 =?utf-8?B?dnJTY2hCYVRtUTNHQzNmc0d3OXQwTlorc0FBSWFxOU5jTHgzY3BraGZ0bU1O?=
 =?utf-8?B?N1RjcEs2L2pYam9IR29TbittU2dHNFNWdmJnR212UkZKQjQ5R3FueW84TGxD?=
 =?utf-8?B?QTY1VUtZcm5PdFNOWnRjM0kxRE84Z1JyUzFQU0NwdDZad0NNdGlSSU5jK0Vs?=
 =?utf-8?B?TGIwZUNxVkVrelNBWjBEdkpDWTBBNHpLUVg5NXNHaWd2NGdIT245QjNaaDNU?=
 =?utf-8?B?NGpqNmFmTFQ5ZG9BdzlDcFNMQmNaaG9Uc09hcmRReTU1S1UzbyswcnFDbEdS?=
 =?utf-8?B?RUE2VVN2NmRLT0c5NlpUd2tMT3BTVndkMzlJa0lReEJKTVc0Rnc2NlhJVmtO?=
 =?utf-8?B?aHhQQW1LUWJaeTQrNTkyYjQrWjR4Q2U1ZDNvTGVkZ3NEVm02TGRETmZrWVEx?=
 =?utf-8?B?dDhXM04zUXcwOW5YWlNiczRTS3BSMlJXTXZjc2lzTTRaY1ljN2hOQldoS2dz?=
 =?utf-8?B?OEkrNDlDaEZuWnkvZUZJWmloanVleHE2Q0wwU3A2R3RCTVB1RUVyTHB4ay9L?=
 =?utf-8?B?NXVKMThPaFVNaHUrK255VWNEYVA4QVZSZmxkT3AxcEJCQVFiZ3dZb3VKWjBq?=
 =?utf-8?B?RXBOMXV5NG5IcjJrazRnOVoyT1ErQnB4MmF2djh4NHQweGdpZDV6NTR6QS9t?=
 =?utf-8?B?dllBZ2J4dXgzS0M4S0dWQWdmaFNKT0JldE9JbW1yL0psV241SXFFcHNRYTBE?=
 =?utf-8?B?Qk56M1VBVDNEMmJwVDdvdVBnTG1WdDExdUE2dEw4c1Fud2NidEtLTXp3U3E5?=
 =?utf-8?B?ZitZTUlibmw3bktoaWJwZ2lEWURNaG45WTFtOHg0MVFFU0pyeTIzQlFqU040?=
 =?utf-8?B?TTFoM0U5dEVOcHR2TGU2aHVPbFBOaG9sS1RHSCs5czdOamY1d3kxa1RKaXlR?=
 =?utf-8?B?TWtaZWJDMW5BUFo5TGN3b3pLeGIyVnlXSXo4emNLc0lKWWE5Rk9vY0s1OEN2?=
 =?utf-8?B?VllHdnliSndIMXVZNnpYZmVteTkvYitPMkpQMTg1TVh0dm9xcHk1MFd3MFlu?=
 =?utf-8?B?WmhwUFh0ZDl0SVlFU2hFUWVwa3ZPNmhmYkZKeExXUlNud0FnMlhoK1NpbVY2?=
 =?utf-8?B?MkE2c0ZlZmpSeDZESEdrQ2hCbFBSZWVwbWlObUQwcVMxUjBDZy9JWXI5UVhI?=
 =?utf-8?B?UlB3QTFQbGF1MzdRUkxwNnpvY3NUQ0dnU0ZqLy96aVAvZUhqWUt2VFMxd2hM?=
 =?utf-8?B?bmNxajNMZDV4OVFaUE5WSHQyT2k0WVN3Yk5JbTMvRUxIL1BZQUVmZWpxczNY?=
 =?utf-8?B?VG80cmQxY2RCWnNDQ1lQNzl3eU96aHdIRmlJS1JPQ3ZDYjhnR3pjOTNTb0F1?=
 =?utf-8?B?OWdub0FwODFNNnVGZXM4Ylc3WkxJZ3Iya1RScU4wcGdoSEZVTENzemE3UnE2?=
 =?utf-8?B?aWg0TTF5YW0wcWtFTWdQbzhhRFNPTUVVbmRDTEk1OFdNd293WUQ1K0FCWnBv?=
 =?utf-8?B?ek9NOGIxVmh3MytwRHpubjJuR0RGOXh4bVBhY1gzeFNzQW1aQkNzSlRkdk5J?=
 =?utf-8?B?d01JSE5RQ0M5MTN4eitMWnNFKytLbmZEWjEvaTE5cXExQ0JHRklVOW54SzhZ?=
 =?utf-8?B?YS9QQ212ZzVhdWZ3ZDBybnJZb0E5ZmZkTFRhZ3FQR0plbitDazlvdTZLczNn?=
 =?utf-8?B?TzgvSzJJNFUvWG5MdldvYWhyNUJablN1UXFJVjhjOEFPRC9NU1BBbk9aVkFJ?=
 =?utf-8?B?N2FlUnNBU05ZTktMUnBjRUdQdXJZcm1VQ3o2M1lRQkNoTjFpZi9RRERuUjln?=
 =?utf-8?B?cFJwYmNnU0h6QkVha3lzOTgzZ3UvUDFJQ1p0OTZmREtlSkhDWEVSQlcwVlNU?=
 =?utf-8?B?RHdUcHF4bXd4b1hCRlhoNk0yb21xNEhVTjFPSXlaZW84U3FBdWJiTWV1WHIx?=
 =?utf-8?B?QTlRZkVaZGM1MFZNcjlMZ3Q4Y3hxMWpJQXduRzllK3ZtNjNIaUlCQ0IrTjRH?=
 =?utf-8?B?Z1NMSFJQMFJKMXhkUzhtZk1vT0ZnU2FTTWhCTE9qUS80V0NmN0FteTVEelI5?=
 =?utf-8?B?aDJ1VE9IRWFjRTlTZnlpajFrR3FMZVFhbFpodz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:07:08.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0902a80-1c8b-4fd9-3e20-08ddf123596d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B8A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8609

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
index 3216d5e2657f..76202706d3ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3393,6 +3393,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
@@ -4271,6 +4272,8 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
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
index a5a814a655fd..7dc641227acf 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -472,6 +472,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters_payload(sk, skb);
@@ -687,6 +688,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -864,6 +866,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
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


