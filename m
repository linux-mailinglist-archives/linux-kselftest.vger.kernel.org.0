Return-Path: <linux-kselftest+bounces-42523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E0567BA5B0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 10:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD4274E101C
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Sep 2025 08:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB1C2D7395;
	Sat, 27 Sep 2025 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="f8P/fzcT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608342D6E58;
	Sat, 27 Sep 2025 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962902; cv=fail; b=n0qciCxW4XvD6ZOaMlx2+YTmEc41Z/RCoGNxveccLrU+jMZJ2vXCsYYB/Wc5f3yaf/T9Q4Jw0sVepDqXztvvFLgXOEm50/tobq/GtmWyu0p08Wfq6VO9OTuC7e0UMVMf910ujins734YcuMEaaQnAfVsaemsUsu9kHJTjJ1Sc+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962902; c=relaxed/simple;
	bh=7kUU+eniR1AhAtT5GffU/pxr+TFYXdLJwjzk+M06eOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iuFSAGqarxrMjifKD/uSYSTlV9EQKUSXGNjvUDCegAK5Q5WWm71887iujF1Cuxi5l+Hnu4p9PIf/vfruVIOWZynw0aGZF9DQ+AukI6P18h35CIBSenhlO/Cc3yMX/dew09E9DSaQi89cECA+P2ep72vlf02vl50SNqDYZDoJEjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=f8P/fzcT; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gu+p8GxtFV9HqGmjg7K1pNJeK25MtEUpZ2HO6C1MXAeNp2B0gppFe+SrtSgMy4TfEDFRB3ikYYsJ4Vg9ZPjhZHS+siFjReAnkOvXp7dS55N2dzRxXg3CIUR80fwphW/GLmwNjFe+or5+IE4R+jSAZ/RTuTjxlBqQnB7dFdn5EH+qWHMhWy8iVo3wJhJWcXQG20gej5M53i/RbSjlYpOLtd+l7amj3vf1s7kaGfhgX4DwipBI5MpVx62CKuSn2lSyZlPRtbeO7zs6xQ/LQo6nsvCxkER0SoFafR03cBdhFHUKZFC50ohq5HlpWLIjBYQ/CQG1vEie3fKIWf4gmaRTmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgHhuTQC0gBqXBjipfNI4/OicuJ+AtQ8d+LLTNPiiWI=;
 b=lprwrlV3ttzNj4ilva8PQNEhGyd+QHzlcqIdofKTdAj6G2mYVuIk1vohECA908/ZUf636i4fniKMVau3oQbh87xJumAN8ISMO9f+ype/lc6tQgNyx003hcyNaK51VrfR68qKg4boVLkIaJDqkftqdXkYPO46rKwDh8YO5Ec+A0w1qrOOKU4T6UM8prCiy4ayRycxBa2QoTt0BBDUWaFrzWpqThudmB0hS8/s0gzLKTelmRzhU+Smu+BhnoIDo4r0Wy11wWb8IQygTtIrQkJv5qg8I69RPNtyjyKjdPH+WIj0UXw6uMWS1nmgokOGpC6f0piSYKRUWnvep2MKh1Nw9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgHhuTQC0gBqXBjipfNI4/OicuJ+AtQ8d+LLTNPiiWI=;
 b=f8P/fzcTKz1p3IZ/vje3/NFu5M4VX4Zn8xYMWAB+oyjHs5h2aKemZ2iyc9YFFIbxRazMFlImpaeFWpn8lV6/1j0G/25GkJpIG0sbyQmSNMyLtncFXg7StehXP9MvQD6bgEoU3jCAYLlLNKjMjOxFc3ZHBb7a+ALzg9YGPZDDO8pT7rTxwqFYeP3zhiW7HLaZhagmpwROcbEEAbiDKqQANmNgc2CKdUIOQ38h5V/U8ui7zCZ/GFldTn1kueRm8iwZVQqBpZqtt8FL5D82b4is0B5EjsgbavTHQuyVpezKQiQ1szQmbRrYUjxS3tYwgatwPOSLmSkcFwkZLyL793ltDA==
Received: from PR3P191CA0019.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:54::24)
 by GVXPR07MB9889.eurprd07.prod.outlook.com (2603:10a6:150:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Sat, 27 Sep
 2025 08:48:13 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:102:54:cafe::e) by PR3P191CA0019.outlook.office365.com
 (2603:10a6:102:54::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.13 via Frontend Transport; Sat,
 27 Sep 2025 08:48:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.9
 via Frontend Transport; Sat, 27 Sep 2025 08:48:12 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 1423D200D5;
	Sat, 27 Sep 2025 11:48:11 +0300 (EEST)
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
Cc: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
	Olivier Tilmans <olivier.tilmans@nokia.com>
Subject: [PATCH v3 net-next 03/12] tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
Date: Sat, 27 Sep 2025 10:47:54 +0200
Message-Id: <20250927084803.17784-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250927084803.17784-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|GVXPR07MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3d35b8-2dd7-4dc2-ce64-08ddfda29798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGluV2RTZUtTRXlndHdScUduMWFsMGNxYUlvekQ4SXZUbVZtRjE1VnJMdmdW?=
 =?utf-8?B?a0VDbEFwdVh3S0MyV1lrQnQ3S1lwV2lDWlZwQ2xUSTBaRWtkSFVaejV3ejN4?=
 =?utf-8?B?VWI2cGFsT2xIcVZIOFMyMzVDQXJBM0t4OFQrSS9WYkt5dHZydDZJdmNMeHhs?=
 =?utf-8?B?WVBGRUFFTnFyKy9oYVBTWGJwcWs2NVRmcU10Zm4yc1B3MVM2UkR3b2QvZnVt?=
 =?utf-8?B?bnFBRGcwOHBvZk9uVzBBeGlYQU5HR0lJcmRUQ2RlbW1TWUJwbzVaVHVtL2di?=
 =?utf-8?B?SmVPYkxEbGxpejdLTWpyaXl4V0JBdXZlUEY0c0N2MFhPcTNIWldHSC9lbVJv?=
 =?utf-8?B?OGRaZ1VsNVJqeUo1TFl2d2V6TjBtcnI0V3FzMjZhQ2MzNEZVZGNaVW93ejd2?=
 =?utf-8?B?OU5hMzdiMHB3eEt5cWZ6R0JZeDdYMWI4amZJNGp0YmFkZmFsR29sY3VzZGRY?=
 =?utf-8?B?RHcrWENXVFFjdW81dHBZUFZNNXA4RTdJNDUrT0RlUGJMWE9mZ3Iwa3J6dlBx?=
 =?utf-8?B?S1FzSjFzejdJL1FZT0Q4c3RhTTZmQjI5NysvYWNGVnY4dkpMTXNEVEEzS25k?=
 =?utf-8?B?UzFXKzFoMUNIVVN1ZFlWOXg2eERFYnJHbFVsQk5DTk9HWGJvRlJTMnZaL3Nz?=
 =?utf-8?B?Ymd6aUlEbVYrTlBjTTZCdmFsSlpneWVzK1VQNncza201VmREOEIzZ3F1cE8v?=
 =?utf-8?B?Z2d1dmFCakdmdzJJN3pCOGtsM1Mzazh6clpOb2pXT1htSEJpeTNBQjB3eTRH?=
 =?utf-8?B?SUE0Qkx5SWlUVkpCTnlWVEVSTXJUK1hmUkRuWHlyTjVicW1hRmNiOWpUc1Fs?=
 =?utf-8?B?R29aRVVjbVlkalRMRVkyWlNaOGovL1lRZFpRWEpXOWJxRnlEZ1p3RFoxV0xD?=
 =?utf-8?B?c3c3K1o4VFQraXNLWmtjUlh1dzBwSVlrR2FoL3BhSW5vTy8vTDc0c3E2Wm9m?=
 =?utf-8?B?eDFFMkoxMmdKSkVlZktkOXU1Q1dXdjVhOFBCMmVrdWY3N3VCM2lyeE5WSTk4?=
 =?utf-8?B?eW5Sdk1CZnNDbzR0SFNyejUzWnR6dGVjQzdXNWtzbUJ3dE5mVWg1SG16S0Fq?=
 =?utf-8?B?SUQ3L0ZPcXBhUEp6Yk1MeURuNEdGWWxtZXdWNzQxYmpZSFR2cW55NG1mRWpt?=
 =?utf-8?B?ZFF0elNLVTBUT2sxTlhlcDlPSytXZitIMUxONHprbHJ0NFpTZ0RLTUZTTFZ4?=
 =?utf-8?B?bm5Sc3lXTmJuNGIrRm1reGI3Z09DVkE5THNnQnFYd2JnRkxrTDJJRWkxTWZw?=
 =?utf-8?B?QmpMUnFZbVZBb1Avc1dzV3hreVRRaHFkOVR3dmJqb3FPb3BNMDRvZHN0dGlN?=
 =?utf-8?B?dC9IcE9qN0s2dE5ybEI3eXJIL0o0VGpvaldLbWZTUE1Nbm5qRHZyRGtoRGMv?=
 =?utf-8?B?ZDlTZDI4ZE84T2pyeGdaMkV0MXJldmtPU0liMzNpd2UyLzdKbGIzelZqdG05?=
 =?utf-8?B?Lzg3Z3dSUGY2ZXJKR01xQXYyTXByTTFlTlRJVDVzWmp0MUFtQ3FhZ01TMW1U?=
 =?utf-8?B?WjZBUVRRU0ZYaW9Hc3pwN3VQa2xONEhJcXdzUGJ2UGhkcGV4dVZBR3ZLekxF?=
 =?utf-8?B?V3NFa25vclp0Y1lyYUM2dnN5Skk5TzhuUVM2WU9LeWlsdUtiODV6L3F3Mmtq?=
 =?utf-8?B?RjNqaE5UbVE0SHBVeWlJbG1IZXNYTVBZT29jeWd5UWUyUTRUditNQ1ZmWUxv?=
 =?utf-8?B?cE44cFRVSlY0bmswbHJaUm9STUhzWlpqQjcvTklFcEI4Ky9WOVpVdzczSTls?=
 =?utf-8?B?QWhmbVFYbkw2RUFISVQvQTRNRnlEZHRmVXFCWCtzZHludXQzSjNpU1lpZ0NE?=
 =?utf-8?B?SWFnNHIrMXFTZGdPMmp3SU80SFU3S2FSbG1ua2phenhtRjRkQlJ1MVZzclJp?=
 =?utf-8?B?MS93aFdtQWRacmdTYVVOYWJqS0huZWRIaEV4K1RWZHB5QWs1ZUpEODhtOVlJ?=
 =?utf-8?B?NUlYOHJSL0paYzVmSFZDQ1dqWWJPSHkwdUowdWJPd1BJWjB0U01IU0xvYXpY?=
 =?utf-8?B?c1phcjhhUHdHa0lKQVV4QjNReW1vR1pQWDNQYTg5TjFDT000QjJldkJoQTBE?=
 =?utf-8?B?Q0VGT2x4U3dreWt6c2lZSHhFMi9wRXI2dkROdzNnU0dOaUJYV0hNRVUybGxF?=
 =?utf-8?Q?H9jVL/VmkDYDn20W94qDCd2yi?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2025 08:48:12.5703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3d35b8-2dd7-4dc2-ce64-08ddfda29798
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR07MB9889

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Two CA module flags are added in this patch. First, a new CA module
flag (TCP_CONG_NEEDS_ACCECN) defines that the CA expects to negotiate
AccECN functionality using the ECE, CWR and AE flags in the TCP header.
The detailed AccECN negotiaotn during the 3WHS can be found in the
AccECN spec:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Second, when ECN is negociated for a TCP flow, it defaults to use
ECT(0) in the IP header. L4S service, however, needs to se ECT(1).
This patch enables CA to control whether ECT(0) or ECT(1) should
be used on a per-segment basis. A new flag (TCP_CONG_WANTS_ECT_1)
defines the behavior expected by the CA when not-yet initialized for
the connection.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Change TCP_CONG_WANTS_ECT_1 into individual flag.
- Add helper function INET_ECN_xmit_wants_ect_1().
---
 include/net/inet_ecn.h | 20 +++++++++++++++++---
 include/net/tcp.h      | 22 +++++++++++++++++++++-
 include/net/tcp_ecn.h  | 13 ++++++++++---
 net/ipv4/tcp_cong.c    | 10 +++++++---
 net/ipv4/tcp_input.c   |  3 ++-
 net/ipv4/tcp_output.c  | 10 ++++++++--
 6 files changed, 65 insertions(+), 13 deletions(-)

diff --git a/include/net/inet_ecn.h b/include/net/inet_ecn.h
index ea32393464a2..827b87a95dab 100644
--- a/include/net/inet_ecn.h
+++ b/include/net/inet_ecn.h
@@ -51,11 +51,25 @@ static inline __u8 INET_ECN_encapsulate(__u8 outer, __u8 inner)
 	return outer;
 }
 
+/* Apply either ECT(0) or ECT(1) */
+static inline void __INET_ECN_xmit(struct sock *sk, bool use_ect_1)
+{
+	__u8 ect = use_ect_1 ? INET_ECN_ECT_1 : INET_ECN_ECT_0;
+
+	/* Mask the complete byte in case the connection alternates between
+	 * ECT(0) and ECT(1).
+	 */
+	inet_sk(sk)->tos &= ~INET_ECN_MASK;
+	inet_sk(sk)->tos |= ect;
+	if (inet6_sk(sk)) {
+		inet6_sk(sk)->tclass &= ~INET_ECN_MASK;
+		inet6_sk(sk)->tclass |= ect;
+	}
+}
+
 static inline void INET_ECN_xmit(struct sock *sk)
 {
-	inet_sk(sk)->tos |= INET_ECN_ECT_0;
-	if (inet6_sk(sk) != NULL)
-		inet6_sk(sk)->tclass |= INET_ECN_ECT_0;
+	__INET_ECN_xmit(sk, false);
 }
 
 static inline void INET_ECN_dontxmit(struct sock *sk)
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 7c51a0a5ace8..cb8901e02ccc 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -402,6 +402,7 @@ static inline void tcp_dec_quickack_mode(struct sock *sk)
 #define	TCP_ECN_DEMAND_CWR	BIT(2)
 #define	TCP_ECN_SEEN		BIT(3)
 #define	TCP_ECN_MODE_ACCECN	BIT(4)
+#define	TCP_ECN_ECT_1		BIT(5)
 
 #define	TCP_ECN_DISABLED	0
 #define	TCP_ECN_MODE_PENDING	(TCP_ECN_MODE_RFC3168 | TCP_ECN_MODE_ACCECN)
@@ -1189,7 +1190,12 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+/* Use ECT(1) instead of ECT(0) while the CA is uninitialized */
+#define TCP_CONG_WANTS_ECT_1		BIT(3)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN | TCP_CONG_WANTS_ECT_1)
 
 union tcp_cc_info;
 
@@ -1321,6 +1327,20 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
+static inline bool tcp_ca_wants_ect_1(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_WANTS_ECT_1;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f13e5cd2b1ac..0cc698a8438c 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -31,6 +31,12 @@ enum tcp_accecn_option {
 	TCP_ACCECN_OPTION_FULL = 2,
 };
 
+/* Apply either ECT(0) or ECT(1) based on TCP_CONG_WANTS_ECT_1 flag */
+static inline void INET_ECN_xmit_wants_ect_1(struct sock *sk)
+{
+	__INET_ECN_xmit(sk, tcp_ca_wants_ect_1(sk));
+}
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -561,7 +567,7 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ECE;
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 
 	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
 		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
@@ -579,7 +585,8 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 	bool use_ecn, use_accecn;
 	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
 
-	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN ||
+		     tcp_ca_needs_accecn(sk);
 	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
 		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
 		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
@@ -595,7 +602,7 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 
 	if (use_ecn) {
 		if (tcp_ca_needs_ecn(sk) || bpf_needs_ecn)
-			INET_ECN_xmit(sk);
+			INET_ECN_xmit_wants_ect_1(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
 		if (use_accecn) {
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index df758adbb445..1a8ed6983ac3 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -16,6 +16,7 @@
 #include <linux/gfp.h>
 #include <linux/jhash.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <trace/events/tcp.h>
 
 static DEFINE_SPINLOCK(tcp_cong_list_lock);
@@ -227,7 +228,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 }
@@ -240,7 +241,10 @@ void tcp_init_congestion_control(struct sock *sk)
 	if (icsk->icsk_ca_ops->init)
 		icsk->icsk_ca_ops->init(sk);
 	if (tcp_ca_needs_ecn(sk))
-		INET_ECN_xmit(sk);
+		/* The CA is already initialized, expect it to set the
+		 * appropriate flag to select ECT(1).
+		 */
+		__INET_ECN_xmit(sk, tcp_sk(sk)->ecn_flags & TCP_ECN_ECT_1);
 	else
 		INET_ECN_dontxmit(sk);
 	icsk->icsk_ca_initialized = 1;
@@ -257,7 +261,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
 	if (ca->flags & TCP_CONG_NEEDS_ECN)
-		INET_ECN_xmit(sk);
+		INET_ECN_xmit_wants_ect_1(sk);
 	else
 		INET_ECN_dontxmit(sk);
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 858ea87a32b7..2d58fc96677b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7222,7 +7222,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	u32 ecn_ok_dst;
 
 	if (tcp_accecn_syn_requested(th) &&
-	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3 ||
+	     tcp_ca_needs_accecn(listen_sk))) {
 		inet_rsk(req)->ecn_ok = 1;
 		tcp_rsk(req)->accecn_ok = 1;
 		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index bb3576ac0ad7..c7b884f173d0 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -328,12 +328,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 			 struct tcphdr *th, int tcp_header_len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool ecn_ect_1;
 
 	if (!tcp_ecn_mode_any(tp))
 		return;
 
+	ecn_ect_1 = tp->ecn_flags & TCP_ECN_ECT_1;
+	if (ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
+		__INET_ECN_xmit(sk, true);
+
 	if (tcp_ecn_mode_accecn(tp)) {
-		if (!tcp_accecn_ace_fail_recv(tp))
+		if (!ecn_ect_1 && !tcp_accecn_ace_fail_recv(tp))
 			INET_ECN_xmit(sk);
 		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
@@ -341,7 +346,8 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
+			if (!ecn_ect_1)
+				INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


