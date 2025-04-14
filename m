Return-Path: <linux-kselftest+bounces-30691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97544A8816A
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D8FF3AE9BB
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909B42D4B57;
	Mon, 14 Apr 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Zj4P7uKo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013020.outbound.protection.outlook.com [52.101.67.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE332D4B50;
	Mon, 14 Apr 2025 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744636451; cv=fail; b=dvVCjsR5QuMQeNgMZRQPwmcor2d6T38D+d94x46goQ+BEZrAViXNYcMkVjonoCTWOKdsPaGZZw09M2pNiyROXPK6m5TD7k2o0T2GSjAXR2p0tKJKGaAwwBAtKGiqv+m9/KmKK1KZv0wqrXt7WcaE9ReMBbeFL79Cpty89ZCLktU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744636451; c=relaxed/simple;
	bh=U6q/bXRBi17sP6YLpcdxzeTbpNHFCeio/M7MPrlQrZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JLIQq5+/Xu+Yb/cA5Mw+qYS/+2PbvcJ51gRI4jbsFk+onVszsvo4C34490yJfBXlwjJd3g7405hfEq2DewOOMH1WmpL6kqTMrVow+/rcsMm14N2feEW3G3kUWwl/I+RmbkN/U2TMdsuec3cfe2Iu6DzhOp7bLdt6xfYnwYO2qok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Zj4P7uKo; arc=fail smtp.client-ip=52.101.67.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dm5H2p4GqJkzZdx3N8iKZOyRrPijzJvNLjgk/G4he6YyE76w7H4Y1FRUmXSCSqP+JGnCf/Az71+CWt+UFjT0CKV8RrBJLOMlDzb1Rv4l1uu6FCeAKIdpyINp2PmKYRLgG7841P3Iy5IHN8ZL39m4t6njadCCKyjhG45S4ajXr0VxWX6DGBMEmb0zq3sOL/QTEw676PFQVybkBmrRaKb8L4lYs3yRFz/5bH00LAyzoLpAUKa/ZAKjp23O/K5ISvqOeCHtrfKRO7q/lkz5xjZ1V+sHMeRG44rw9iDdeZC5Kq4Vkkj9TLlL6SUGQ7v2HOgenl2N3N6v7gmN+UlBbEwJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EO0JnilW42J6qJIyNXcH3joHs9jMP2hYH+EBwh+DOUk=;
 b=IvCRqrHVbAeBFsd6gNJJdfHj0E5xdnsfvg9it8G0z4EYBt1gWjc9XaTWFUMW2hKMmrZFI/MVBJhrKb0Oq1Ou/12/X1avH5sgCgITJhs8BTcHrxE3xCGm1U5y4WWHvw0lDnaZZJkuHHRf6cQ1b7ZWR3luvbzizJaKaW9ChYql2MLX4/4L4dclWStSFXbd00X/M1FOT9cWJIUt/hZ4Ras2RUjCEAQf+Du+E5mzeQXT9Fuh1ZDYtiHYsM9j2xxNcr9d4Rp2IE8jOjop+OCK9LCY0tSdW8A7gMxK3E2XkOX6Dcx/lhDXsrTAENaP3aKSTAFBnzLVAbusDnPkzSyPeNEvBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=nokia-bell-labs.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EO0JnilW42J6qJIyNXcH3joHs9jMP2hYH+EBwh+DOUk=;
 b=Zj4P7uKoaYdbWxz9w3tVKp5gq+FYzkEm/0IZgZgUTScapISNm/m53cM45RpYeoU4rFfXf0SVfzray3sq9a8kNqkUlJqQotIKI3RYK+BlPaQpgaO1FY4U/QJsc5ro5mUKx2M0p1ZbPfUcej7AtmL20uZ36xCvCsIJHil2/afrz4+SXe9OcYBJDGdOAoHo/TN7pBuvYYVYd/tOtTHpkcFbfdl1qGrgbBrJVGiCLZbl0wNRh/krGCMCNPna6QPivTL7h52/831Hx0W8jFMu8ShuuDg5ivnYBrY+OBTtEVAcNb5WenfKJxZcnrRo6gRVBVA0gfx9MWSbaILkyf5gHkjZdA==
Received: from VI1PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:803:14::35) by DU2PR07MB9588.eurprd07.prod.outlook.com
 (2603:10a6:10:46f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 13:14:01 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:803:14:cafe::8e) by VI1PR0202CA0022.outlook.office365.com
 (2603:10a6:803:14::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 13:14:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.4 via Frontend Transport; Mon, 14 Apr 2025 13:14:00 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (GMO) with ESMTP id 53EDDQBE009623;
	Mon, 14 Apr 2025 13:13:57 GMT
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
        Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v3 net-next 03/15] tcp: AccECN core
Date: Mon, 14 Apr 2025 15:13:03 +0200
Message-Id: <20250414131315.97456-4-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250414131315.97456-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DU2PR07MB9588:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf855a3-b2ac-4fcf-aa52-08dd7b56389b
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|30052699003|1800799024|376014|36860700013|82310400026|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?R1NIZnR4bllJMk9OU2JHNFZhT1RPcVFpaDBUOFRPb0FtVWY2ei9peWNIOTNB?=
 =?utf-8?B?RjAxdG9oZlF1M2xIWnNENmgzR05CR3QySG1NT3JYdnNrbWlhWUV3WFZER3Nq?=
 =?utf-8?B?NmlubFZ4MkVHTVgraVJKbSs5Q3B2NnNXNVYyaUJ2SExiTlVFUXFWd3RaSkRL?=
 =?utf-8?B?RXozZnhxQU9YZTJkRVhXdGU2V1VPazlxQm5SM0ZrbUVNQkN6YTFHUERCVWhC?=
 =?utf-8?B?SG1tNFYwUUlXem9JT1NSZmR4RThrVVQwS2pMcGtmb2NtbWRsbmhIZ2RiclNW?=
 =?utf-8?B?eXhrM1Y4djRHQ0xGazI3amp4Tmp0cFcrT1l0bEdjR2Rka3VoZzVPL1hwTEd2?=
 =?utf-8?B?UUxhWVRPMzdCa3E0QkxZQTd3cmFUQ1BadjhGbUUySklNY0pFY0huWUNuOC9w?=
 =?utf-8?B?dHA0QjVmUTJMc2pyTzlCenVmTEZrc3B2SDRIRGRENGtMQWZZM2FKN254bTBw?=
 =?utf-8?B?aU5YK1pCNFhZMEhZT3hVQ3Z5RTh3TENyUDVQc2J5dVZtWGVPdE1aRkdFTGZ5?=
 =?utf-8?B?ZDl0dDBXRHpGUUFkR0NGYkg5b2JBSGg0eGxDc2g1UTZYSE1CVWVsYS9NRW9F?=
 =?utf-8?B?bWNHQ1owVW5hdjlFUVZXcjF2cmlUaU1jTFBRWHBvenltZnF0eE5qNHkrQnB2?=
 =?utf-8?B?b0thRTJrUTE1RS9XTU5SdzgxVU0yM0tXMWRHS0ZWTmhIQmthUFBHUzVYN1lN?=
 =?utf-8?B?V1lHSklGOWF4T0pmV1RFSTlTRTcrWWVReDc5emg3c1Rqekc2eUFKMlFsaDNl?=
 =?utf-8?B?bVBDM3JTeFpLdXhvTHZIc3VOdEEraWdRQ3JaY2J0VEkySTIwenFuZmQvSHVK?=
 =?utf-8?B?R1B6bmVDa3hYQVd4L1dldTRuY0NWTUxJb1RyRU13NHdSRXJKNVllbSs5YjE0?=
 =?utf-8?B?QTRMaUduUWFkTTBBdFZlS1AyeUhHWGkxUzBvUzc5STRVN2k0SW5vT0pwNlEy?=
 =?utf-8?B?cTg1VHprT2k4Yjc5T3k5SDFkMTFuTjdqbGdMNFJmeHZYcjh0YVhHOWRTbjRW?=
 =?utf-8?B?WGFFd0RnMWlXRXpiNnNjVDU3cmc2cEtmWFRod1lxSU1DOGYrRDdlL2dJa0FI?=
 =?utf-8?B?Zjdmd1hWdzNSK0twQlBWdUE0YndPMzhLYzB0cFlqcjc2TVhTdFFwTzh0RlZr?=
 =?utf-8?B?NTVDYmx4KzZZd0FOYzZGeGgxUDZCT0ZrejNJc2RnQ1JHNytoL2hrMmhOQ0Zy?=
 =?utf-8?B?bTNhUGJpakNPTmpEWE01SDYvZHVXS09tQ1A4TzhWV2xOUEhEWFIzZUV3RkxF?=
 =?utf-8?B?cGowTFk4Q1p3clN1ZTF3T0lsNC9xd2ZQU1cyK0dWcXRtNXp0ZEZrUXNxcy9J?=
 =?utf-8?B?NTljRmN6RFBXMXN1bGFJTEZkY0N3NTlvdk94aEtmZ3c1WUh3bkttMWM2Q01l?=
 =?utf-8?B?eGhBaVZGUkljMXh4eURyVnI5T0lHa0Q0UkJYQ1pjTjEzdTgrcDVEV3hYZDNM?=
 =?utf-8?B?SzFXQ1pVRHpiWjN5L3ZxZzVhbEVPTmRyemZaMjR3QmtFa1JLcmM1dnRLbkRR?=
 =?utf-8?B?cUhoU2hlditpVDRseGxyWHc3VVVvOU00dmU1N3g2bDdZRjNhUVNKd25QQ3FP?=
 =?utf-8?B?NmRsRDNYNUljNWRFNzJlam1nUEtjZDROZmFSQW5EakxMQXJzbTZIdHY3U3Fo?=
 =?utf-8?B?RXhsSnhEV2xYR3pkMFRIdTJkOHFZcy9HTXU1Y0duVFRDN09WeEFMdWdLaW5P?=
 =?utf-8?B?RlViZnN1a0t5R21DRHgzWUtrVStLR2FxbFNpQmFPZUJ1RFNrQ0xaUlJZWENy?=
 =?utf-8?B?TCtRTEVVSmlLd0cwNlNJWEczZjdHVFhZZldaWnJ3UkhGd1VYdTlLVUpLUWty?=
 =?utf-8?B?RE95SzFYT2Z6UDNSWFJoUFJaWWJrTDY1OHFYWERyRDhpNXQ5bVFqeEEraUFj?=
 =?utf-8?B?bGd6TFJmZzRBRTRsMXFxUEhKcmVqUjRxSEVxeU83ZmlkbThUdWRRRFBqYTJ4?=
 =?utf-8?B?ZmRSMkFBTnIxQ0VNdGZKcEJPUWlzd0hYNmtVcUVDcHZFYkZxeDVtMlhsemF6?=
 =?utf-8?B?T0l1anFIaE5nTGhzMEF4aWl3WkFUeldPNEcralphM2lDZ0N1RWFoak5WK29U?=
 =?utf-8?B?bzBMeHpPT3FNUDlrYmd0Nlc4UFdxM0FsZEV5QT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(30052699003)(1800799024)(376014)(36860700013)(82310400026)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:14:00.2813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf855a3-b2ac-4fcf-aa52-08dd7b56389b
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9588

From: Ilpo Järvinen <ij@kernel.org>

This change implements Accurate ECN without negotiation and
AccECN Option (that will be added by later changes). Based on
AccECN specifications:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN allows feeding back the number of CE (congestion
experienced) marks accurately to the sender in contrast to
RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
Congestion control algorithms can take advantage of the accurate
ECN information to fine-tune their congestion response to avoid
drastic rate reduction when only mild congestion is encountered.

With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps
track of how many segments have arrived with a CE mark. Accurate
ECN uses ACE field (ECE, CWR, AE) to communicate the value back
to the sender which updates tp->delivered_ce (s.cep) based on the
feedback. This signalling channel is lossy when ACE field overflow
occurs.

Conservative strategy is selected here to deal with the ACE
overflow, however, some strategies using the AccECN option later
in the overall patchset mitigate against false overflows detected.

The ACE field values on the wire are offset by
TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the
real CE marks rather than forcing all downstream users to adapt
to the wire offset.

Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h   |   3 ++
 include/net/tcp.h     |  26 +++++++++
 net/ipv4/tcp.c        |   4 +-
 net/ipv4/tcp_input.c  | 121 +++++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_output.c |  21 +++++++-
 5 files changed, 160 insertions(+), 15 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 1669d95bb0f9..e36018203bd0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -298,6 +298,9 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
+	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
+		unused2:4;
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 4dacd4a11669..cc28255deef7 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -415,6 +415,11 @@ static inline void tcp_ecn_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->ecn_flags |= mode;
 }
 
+static inline u8 tcp_accecn_ace(const struct tcphdr *th)
+{
+	return (th->ae << 2) | (th->cwr << 1) | th->ece;
+}
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -964,6 +969,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
 
+#define TCP_ACCECN_CEP_ACE_MASK 0x7
+#define TCP_ACCECN_ACE_MAX_DELTA 6
+
+/* To avoid/detect middlebox interference, not all counters start at 0.
+ * See draft-ietf-tcpm-accurate-ecn for the latest values.
+ */
+#define TCP_ACCECN_CEP_INIT_OFFSET 5
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
+	tp->received_ce_pending = 0;
+}
+
 /* State flags for sacked in struct tcp_skb_cb */
 enum tcp_skb_cb_sacked_flags {
 	TCPCB_SACKED_ACKED	= (1 << 0),	/* SKB ACK'd by a SACK block	*/
@@ -1773,11 +1792,18 @@ static inline bool tcp_paws_reject(const struct tcp_options_received *rx_opt,
 
 static inline void __tcp_fast_path_on(struct tcp_sock *tp, u32 snd_wnd)
 {
+	u32 ace;
+
 	/* mptcp hooks are only on the slow path */
 	if (sk_is_mptcp((struct sock *)tp))
 		return;
 
+	ace = tcp_ecn_mode_accecn(tp) ?
+	      ((tp->delivered_ce + TCP_ACCECN_CEP_INIT_OFFSET) &
+	       TCP_ACCECN_CEP_ACE_MASK) : 0;
+
 	tp->pred_flags = htonl((tp->tcp_header_len << 26) |
+			       (ace << 22) |
 			       ntohl(TCP_FLAG_ACK) |
 			       snd_wnd);
 }
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index e0e96f8fd47c..372c58170f4c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3364,6 +3364,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5088,6 +5089,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5095,7 +5097,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 92 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 97 + 7);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index a35018e2d0ba..8dbb625f5e8a 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -341,14 +341,17 @@ static bool tcp_in_quickack_mode(struct sock *sk)
 
 static void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
+	/* Do not set CWR if in AccECN mode! */
 	if (tcp_ecn_mode_rfc3168(tp))
 		tp->ecn_flags |= TCP_ECN_QUEUE_CWR;
 }
 
 static void tcp_ecn_accept_cwr(struct sock *sk, const struct sk_buff *skb)
 {
-	if (tcp_hdr(skb)->cwr) {
-		tcp_sk(sk)->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (tcp_ecn_mode_rfc3168(tp) && tcp_hdr(skb)->cwr) {
+		tp->ecn_flags &= ~TCP_ECN_DEMAND_CWR;
 
 		/* If the sender is telling us it has entered CWR, then its
 		 * cwnd may be very low (even just 1 packet), so we should ACK
@@ -384,17 +387,16 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
-		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
 }
@@ -428,10 +430,64 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 				bool ece_ack)
 {
 	tp->delivered += delivered;
-	if (ece_ack)
+	if (tcp_ecn_mode_rfc3168(tp) && ece_ack)
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+/* Returns the ECN CE delta */
+static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+				u32 delivered_pkts, int flag)
+{
+	const struct tcphdr *th = tcp_hdr(skb);
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta, safe_delta;
+	u32 corrected_ace;
+
+	/* Reordered ACK or uncertain due to lack of data to send and ts */
+	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
+		return 0;
+
+	if (!(flag & FLAG_SLOWPATH)) {
+		/* AccECN counter might overflow on large ACKs */
+		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+			return 0;
+	}
+
+	/* ACE field is not available during handshake */
+	if (flag & FLAG_SYN_ACKED)
+		return 0;
+
+	if (tp->received_ce_pending >= TCP_ACCECN_ACE_MAX_DELTA)
+		inet_csk(sk)->icsk_ack.pending |= ICSK_ACK_NOW;
+
+	corrected_ace = tcp_accecn_ace(th) - TCP_ACCECN_CEP_INIT_OFFSET;
+	delta = (corrected_ace - tp->delivered_ce) & TCP_ACCECN_CEP_ACE_MASK;
+	if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
+		return delta;
+
+	safe_delta = delivered_pkts -
+		     ((delivered_pkts - delta) & TCP_ACCECN_CEP_ACE_MASK);
+
+	return safe_delta;
+}
+
+static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
+			      u32 delivered_pkts, int *flag)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u32 delta;
+
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	if (delta > 0) {
+		tcp_count_delivered_ce(tp, delta);
+		*flag |= FLAG_ECE;
+		/* Recalculate header predictor */
+		if (tp->pred_flags)
+			tcp_fast_path_on(tp);
+	}
+	return delta;
+}
+
 /* Buffer size and advertised window tuning.
  *
  * 1. Tuning sk->sk_sndbuf, when connection enters established state.
@@ -3919,7 +3975,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3927,8 +3984,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
 	delivered = tp->delivered - prior_delivered;
 	NET_ADD_STATS(net, LINUX_MIB_TCPDELIVERED, delivered);
-	if (flag & FLAG_ECE)
-		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, delivered);
+
+	if (flag & FLAG_ECE) {
+		if (tcp_ecn_mode_rfc3168(tp))
+			ecn_count = delivered;
+		NET_ADD_STATS(net, LINUX_MIB_TCPDELIVEREDCE, ecn_count);
+	}
 
 	return delivered;
 }
@@ -3949,6 +4010,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -4056,6 +4118,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -4080,7 +4147,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -4089,12 +4157,16 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	return 1;
 
 no_queue:
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
 	if (flag & FLAG_DSACKING_ACK) {
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 	}
 	/* If this ack opens up a zero window, clear backoff.  It was
 	 * being used to time the probes, and is probably far higher than
@@ -4115,7 +4187,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -5952,6 +6024,26 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 	}
 }
 
+/* Updates Accurate ECN received counters from the received IP ECN field */
+static void tcp_ecn_received_counters(struct sock *sk,
+				      const struct sk_buff *skb)
+{
+	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
+	u8 is_ce = INET_ECN_is_ce(ecnfield);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!INET_ECN_is_not_ect(ecnfield)) {
+		u32 pcount = is_ce * max_t(u16, 1, skb_shinfo(skb)->gso_segs);
+
+		tp->ecn_flags |= TCP_ECN_SEEN;
+
+		/* ACE counter tracks *all* segments including pure ACKs */
+		tp->received_ce += pcount;
+		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
+					      0xfU);
+	}
+}
+
 /* Accept RST for rcv_nxt - 1 after a FIN.
  * When tcp connections are abruptly terminated from Mac OSX (via ^C), a
  * FIN is sent followed by a RST packet. The RST is sent with the same
@@ -6214,6 +6306,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6258,6 +6352,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6298,6 +6393,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 9a1ab946ff62..9c978d12c7cf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -374,6 +374,17 @@ tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 		th->ece = 1;
 }
 
+static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+{
+	u32 wire_ace;
+
+	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+	th->ece = !!(wire_ace & 0x1);
+	th->cwr = !!(wire_ace & 0x2);
+	th->ae = !!(wire_ace & 0x4);
+	tp->received_ce_pending = 0;
+}
+
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
  * be sent.
  */
@@ -382,11 +393,17 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	INET_ECN_xmit(sk);
+	if (tcp_ecn_mode_accecn(tp)) {
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-			INET_ECN_xmit(sk);
 			if (tp->ecn_flags & TCP_ECN_QUEUE_CWR) {
 				tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 				th->cwr = 1;
-- 
2.34.1


