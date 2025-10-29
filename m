Return-Path: <linux-kselftest+bounces-44255-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F173C18E98
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58EDB1C877CC
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 08:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4888531BC96;
	Wed, 29 Oct 2025 08:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WEPDzeVK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012007.outbound.protection.outlook.com [52.101.66.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F138C31A562;
	Wed, 29 Oct 2025 08:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761725180; cv=fail; b=G4oer4OPqmf+KRixLgGL0/L/u3vCX8iWafJItyaSlJ8n6wl71Mh6Ypnan2dY7GrxoSgMD0J3Dh9rkY7dTaVN0e+SncIUICYyJGFFjtJomEOACaetdW/xKt9eq2xXGwQqx8v1aV4GjQDpJsUcOLtvcdQXQLVRHsXWgoQM5eVPTzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761725180; c=relaxed/simple;
	bh=gl3KYdwFPr5kG5ylpWJ49KOafH3C1sXGOstcCfy3vQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WKj8iRh4REVV7pZFDW3zog+9HSocbLSa6I5igk4ctm6ChQw4McmUHFJxRXXKeZPdFcz0fyZNLoH8yF/zZyCGAMW4iAZusVuLBpwRI71od3wG6Y2Evjcz7Q611Re1okGbIiOMIs+kCEwA457e6lHgJh9aeUHBfCzceW75xcPy12Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WEPDzeVK; arc=fail smtp.client-ip=52.101.66.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoUbDNGJOkQlD4qh2DajeOuekEEQ4TSBf9Dy5IjXzBcisJyz0+KAkQ9hJPmUiDIhflLHii/m7PgLz8qH8swmVbbpU1G0PIq57Gaq+3n6ImkIKONtmejRqujF0BTCqzdy5x5S5qlkYdFMp6tS4FwaqTE1v+yV6Fqn3lFn1jRKyJX0OpJwiamthAgvE417BODY0DkQx37Pe2sRQUaIIMvKI37WFFdWT4KhqNcRtal8JD3JEZh9XW2X+A+tJR7on0ZrPCH4STwhG+pL06TIGI39OOLWZgtVa+Iv9w5podMtQ21gwggFxgV6ilvzUMmHcx0gAhV0OIfxaFpxH10Ac9h3DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7463pAfxF/t63kgtwYfAhr0jj4/tftxhp/gxfR2FA9I=;
 b=IGksNSVSJXX6d1SqgTJ9HJrL0mHnKJuzyNNfezO0s7041TVhbYEOlpC7/OcwEJUeAEIaL2+O5LEd7fqgTcDOrAycHfCE/FsP2aSO5ouwx07HoLghigWPRP8FZOQ0kLMvOJfrrCppGbyiM55bVg7IEUOv7SkMV8jyDOvq8C6cTOCk2hzzh1W+YV66siaRKF/NSPBkx9/beBrrXrW/kJGPeijT5nknvVlgB3Vg/wUbM+KDwNK11+7GA02jmZgEQ2ag/kODpps4o9TDNNO8wVeGy8trkKHQCpYaNP5abL7lhJOs/Str+42duzFkzV5vqM/LbcngvfpoKf5zcVNSaS/eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7463pAfxF/t63kgtwYfAhr0jj4/tftxhp/gxfR2FA9I=;
 b=WEPDzeVKVEE26iHbHcj6gLb4J0kfRXT8gToa50oHFLfIZ1r18tkChi1jDV1XnOqj3g1ItSeexkUYvj8DWoPmLpgtnHSklbI2EB0qlIROAm/yw0e7Lh3YwISLGIXP99m9xDPsOjVWPVLI4Ok4c1zHu7pLI58U60VVmgieuj9ASPqAoSPrzze9p5w9xTJBspOicqd3geTdLBIjKJMfspJS1EDz50WcPAtQoW40fNw5+td2uNgy1yOKFe4Pe82i6O/cY76/4RvuXNy1j3vDssr1rdtbQIJQY8eZkF/w3FKBdMSvDKH1HPHeOw87XuoXo6JrIUGilXHNIgE/bEVjSlkArQ==
Received: from PR0P264CA0214.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1f::34)
 by AM0PR07MB11588.eurprd07.prod.outlook.com (2603:10a6:20b:6f8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Wed, 29 Oct
 2025 08:06:14 +0000
Received: from AM4PEPF00025F9B.EURPRD83.prod.outlook.com
 (2603:10a6:100:1f:cafe::9b) by PR0P264CA0214.outlook.office365.com
 (2603:10a6:100:1f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 08:06:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F9B.mail.protection.outlook.com (10.167.16.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.0
 via Frontend Transport; Wed, 29 Oct 2025 08:06:13 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 593CA20186;
	Wed, 29 Oct 2025 10:06:12 +0200 (EET)
From: chia-yu.chang@nokia-bell-labs.com
To: pabeni@redhat.com,
	edumazet@google.com,
	parav@nvidia.com,
	linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@google.com,
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
Subject: [PATCH v5 net-next 01/14] tcp: try to avoid safer when ACKs are thinned
Date: Wed, 29 Oct 2025 09:05:55 +0100
Message-Id: <20251029080608.92428-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
References: <20251029080608.92428-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9B:EE_|AM0PR07MB11588:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d9a407-5c38-4df0-3506-08de16c20794
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TlpCaEZOemRwamJWZlQyTHRaOWw3WUVDcVROVksxSXZYZnBlU0xCZW1IT0tR?=
 =?utf-8?B?Ny9EOHViM0h2MEJjWURXOVpHd1k3VVc3UFh0Y0NvVzZZS3pDYlJPVldOYlN5?=
 =?utf-8?B?dlBIczFtUlMrOWRKR3FqbjNiOHpGaUZCRWtYZWNkY08reFlaYklpY1NiVjNl?=
 =?utf-8?B?QWUrdzIxN3JqZXdyeG5FVWN0TjVKK25qSzZhZVl3ZXpKeW5TZ1RNZXQ1c3lT?=
 =?utf-8?B?MVM1V3U1dTNDZjdoMjFTWUVVWFY0UzZjVld6TC94elJQYnpBYkNkUDNNUE5R?=
 =?utf-8?B?dUdmZFZMa21ER0h4Y3NHN1BpaldFNDFWNHZQbmI0QkNZaDcyaWdIMUlBTVpy?=
 =?utf-8?B?b3RNa2NMSGtsMlIxNHNYdm8yRCt6SjIra056cFRpRG5EeXFsNEgyMW54TFRT?=
 =?utf-8?B?azlJbFFJdkNCdGt1RmtjSFZKRm5PdGRHY2pjQ0F0OXVmS1VSTFNNeERtaEVZ?=
 =?utf-8?B?cTJzREpPNGU0R0ZOUzlFVWhMMUQ3bWtBamwzNHNFNXc3K0dtT1hIckorbEsw?=
 =?utf-8?B?dGU1eHoyREFRV2ZLSUIwNUZVQXJ3ZjFhVlZlTmNESnlLQkZCZmErUGNZS2RN?=
 =?utf-8?B?T250VkZpYXdBYjI5cVROK01CaWdvYm9ENmFJQngwUThmSy9CaXNqNzk0T0Zs?=
 =?utf-8?B?ZEMxRDZXRGxkOGxJTDlreStHQVp6bldhMktTOUloQVNKYjE3Tnc0aEtTalVL?=
 =?utf-8?B?NWdHdWNnZDBRRWl1NlRIYnN4WCtDWEY4V2hkbGx2cUY5WGh2LzV5V0tqZUhK?=
 =?utf-8?B?MGw3WEloQ1M5S1NwMmhHZ3NoUHVrV2hSMFNFemdQVy9FM0psUzN6OVp6NmRr?=
 =?utf-8?B?YitRaTdIRklnYnA3T096OEI3ei9ZeGM4L1Rud3hqajdVc2tYVkw1UVVURHM0?=
 =?utf-8?B?ZE5kMGEvQmY4TWYvaG4rcm9HMGE0RTg1U0syMkFRNG1jdXlXejhiWWZRNmZl?=
 =?utf-8?B?QUtJNXBva3JXcGl0VWhxQkZJRFBZNHRGMk5HRWVkQmpQZXc1Y3Y5OHRBUG9S?=
 =?utf-8?B?bzAvZGc3MXh6cmtHODdMRkUyYS9ZSWgrenlwZXdxRzBUM2RSZHB2bk52YURh?=
 =?utf-8?B?WHU0SzVwVW1wQ3pTLzY3ZUpDRkpiV1l3cCtKRnhGbkNHS3lHdzEzVTA1UW01?=
 =?utf-8?B?ZnV5U1g2RFNuZzEwMVhtNDdrVFZ3QUx5NkI3MGNCZVVTRm9BVHdhbVU5QmFW?=
 =?utf-8?B?ak14TThESEx4VDNITDdhUzRmQUJ4UFBteDlWbis4YmFGZjJkazZSdUVoaTNs?=
 =?utf-8?B?aHFqYklscmhRQzZLRjcxc0hxanV6MTkyVzc2dTh5TDluaDNDZWcxcDVoNHVy?=
 =?utf-8?B?eFdhU2JjK2U1WHBmUjUvVm1CYjh1MUt6UlJMcmRzMG5rODVEUGlLblFvaXJl?=
 =?utf-8?B?ZWxXVTZudEhadEYrY1hlb3BXeUxtbm5xTUgrRFhxYUVGRGV3UFM4MzBUR1Ew?=
 =?utf-8?B?YlNCaXJUT2s4Um5vT2RxMi8yRnJNa3ZvZVlJYTdLaDN1a2ZQTk13Ui9UeEg5?=
 =?utf-8?B?QmVDYTBxNjhWSzU5UEpHNGxoamhoMUJsNVRrZFNOVmNrcVYwRXFoQ0pMV2Jx?=
 =?utf-8?B?dk1reHYvek1LZnJOSDIvVlc3UEFHSHJ3RHpSQWNXMHByWS9NRG42czFFVXBP?=
 =?utf-8?B?MmZOY2RkcGVNZ0VtYnY1cTRZYWtqcW0wOGJhRktkVExkOWk0Tk9GVE9Ma25v?=
 =?utf-8?B?SmxqNjdCZWlxTUhYUUUvdVZ0bHVYVTlFOWtkY200aGhVb1p5Q3NaVzAydW1M?=
 =?utf-8?B?YkVNNUVKRXlyVHJOSHBUSTl4Z3c4NGhJYlR4Y3Nsc3JXNHlTY1ZwVi8zekE1?=
 =?utf-8?B?eC9ndXZKS2JjdDBpQzFhSXNnTG1OSThNUmpzaHpib05HRy9FcngzbEtvYW1K?=
 =?utf-8?B?YjdWbFptenJWc2pUTnVQb3RHaWMrVWZ5aHptejNjbjRzd0xLL3VKZDZpSk4r?=
 =?utf-8?B?RURVYXJoMnNwYVlpa0cxd2hUOG02VTlwb3ZsS3FrZWpGdENrNENzRnBIRWtP?=
 =?utf-8?B?WXg5d2l0ZnFkSGgxNnRLWUt6RERTQXR1WFpmZ3U1aUFEdk9FSEdQMEVnZ3Bx?=
 =?utf-8?B?Kzhyc0s5OVFkeTFwTUZNbE1FK3NXVHNGanZRNjFWdEVaR2hkek1MRGJiSUxW?=
 =?utf-8?Q?dSqOHc20vc1h4qlPMO4EVymVn?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 08:06:13.8588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d9a407-5c38-4df0-3506-08de16c20794
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00025F9B.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB11588

From: Ilpo Järvinen <ij@kernel.org>

Add newly acked pkts EWMA. When ACK thinning occurs, select
between safer and unsafe cep delta in AccECN processing based
on it. If the packets ACKed per ACK tends to be large, don't
conservatively assume ACE field overflow.

This patch uses the existing 2-byte holes in the rx group for new
u16 variables withtout creating more holes. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 177 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u32                        delivered_ecn_bytes[3]; /*  2744    12 */
    u16                        pkts_acked_ewma;        /*  2756     2 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 178 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v3:
- Add additional min() check if pkts_acked_ewma is not initialized.
---
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 26f32dbcf6ec..563daea10d6c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:2                          accecn_minlen           write_mostly        read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 20b8c6e21fef..683f38362977 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -345,6 +345,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index a9345aa5a2e5..d92223954cc7 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3420,6 +3420,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5193,6 +5194,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index ff19f6e54d55..f6e6f30c3d79 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -488,6 +488,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -499,6 +503,7 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	u32 delta, safe_delta, d_ceb;
 	bool opt_deltas_valid;
 	u32 corrected_ace;
+	u32 ewma;
 
 	/* Reordered ACK or uncertain due to lack of data to send and ts */
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
@@ -507,6 +512,18 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			ewma = tp->pkts_acked_ewma;
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+		}
+		tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -555,7 +572,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 		if (d_ceb <
 		    safe_delta * tp->mss_cache >> TCP_ACCECN_SAFETY_SHIFT)
 			return delta;
-	}
+	} else if (tp->pkts_acked_ewma > (ACK_COMP_THRESH << PKTS_ACKED_PREC))
+		return delta;
 
 	return safe_delta;
 }
-- 
2.34.1


