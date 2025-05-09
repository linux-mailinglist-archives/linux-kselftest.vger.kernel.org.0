Return-Path: <linux-kselftest+bounces-32795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9B6AB1EFE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 23:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF571C2873C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7CA265616;
	Fri,  9 May 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="pM9ZljZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013048.outbound.protection.outlook.com [40.107.162.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13395264FAF;
	Fri,  9 May 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746825551; cv=fail; b=A46Q1M0Yeeaniq4m8G+3uHNQumkTI1zoek7bRzDdoQzJhKJdvdEk7e6QNaerMRxoA40RvA47ECuGyLjdq/33ZLTJ9gGeHPEOhkwNauGBhpB9TThga0CSHOtvsko0Em6cgtH/btkJlZvNQ37G4CnV4MkCHDOdx+37kNpCV9sGWvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746825551; c=relaxed/simple;
	bh=WgImRcwEmgJNcRO3Jth7KR+wi04rTAsl3V3je1EMJTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTv5EBngH6b0C90Ca+F+KXBsjqA1wOM/aM4L7s1Wt/iCVl3EQvpkXSS84HkXUYyRaE3yqeSa+v8jiwLxokU5qqHJC21mBTleX2RvP8gpuK6WBBmRVOOhTdnfx0nmq8EvOZEuYBEbekVyJ3+/WxgE7D6uj9j6rIPVkQveEcBV8f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=pM9ZljZP; arc=fail smtp.client-ip=40.107.162.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbDQsB4sigE9wWqsmvUjY63nWQJB8MCB3QgAlbpXj7n5LS89Nbe7lqp66rJBDNaTD9N4d7baDeWd38n2p03yyTpbOTT1K93uUN9Po4sPl0hMOt8Rkmg1zRO1FTTslrrd2UT5T+9qON8LXcfTmmVI4I4qCSDrrBXKyoaSwPiaUEoH4V6QSp5MSiY5A9izqyA2vwvp1Rpy1cX82Dv0nZ46RkdhT3k8jiNDaEMXqjLqnjU0sB4PX3hSRy5vU4H75WjFOfqvHOVsNoEIYs0Xnr/Z0CBYWWb3cEQpGFkKQ0FPAX37zpGIZbCMJ4+zRxdbXI54HhFClUycL4EUqcgYxg5c6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tVcbjETXI4+GBlxa0WPHA/navtEph2cG13IGH2oEE0=;
 b=yeDfpwWI0Taqi2YFieQ0wQfgUhVJusIXsIRNaCAJkVbfDXBqn0/nTRGYoPCpTwB+5dE9DdaI/q5Aj2wCfzpVaiJfMWwe6S9OPOrW3iuQxw6xy8oOoGUDBNft7M3MRthLiJc5IFTbDppS6rCYrcK9IBVFU5oUre9ZzOe5+GbPdvyky9JiiyvTX1rDFv+q1xgUjEZDR2GAfe3mrzEq6hW96IRGBW5j+sY+Ts6o91ClBoZTKSMQw4Lyn+raeE6aPCB3tKVeiWKQ5TukUJqQyPAeyfY7mETj5D0pMLTApeQqHwi5KV4MA2TZpGIblI/8Mz30jIQ6bl4MRPI9Wvy8ebuLkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tVcbjETXI4+GBlxa0WPHA/navtEph2cG13IGH2oEE0=;
 b=pM9ZljZPXLrKSZum1euW7/xBSHHwFENoIMtDr5BLRWI8+1kle8We5Z3rlb/dqpWUwpiw1G94MEjhBhYA2heVMON2EmbRqrnhr3TOY+UIM2ANfleZwrSToHdW0r6AhzxPy+agSkQ293upyjFmQEX27kwQXgU8oiJ/YXIzFPgLpBX/XrrqFHcNShVr5JuiOFbdIm/D2FpkCY0IZ9zXeLxYO+iAZdQk3z5nnFU6cFPZnKKosikFBWG0IXVovI26BDMBaE1g7Cce0GA3z2ANkSEsDJkigvBs6NynMkt9aupUeea8uVuqwIT1HZo2CquGI5Bhrc8tZ01KzUkCi9tTOnpSkA==
Received: from DU2P250CA0024.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::29)
 by GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Fri, 9 May
 2025 21:19:05 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::ce) by DU2P250CA0024.outlook.office365.com
 (2603:10a6:10:231::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Fri,
 9 May 2025 21:19:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Fri, 9 May 2025 21:19:04 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 50231200A3;
	Sat, 10 May 2025 00:19:03 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: horms@kernel.org,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
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
Subject: [PATCH v6 net-next 15/15] tcp: try to avoid safer when ACKs are thinned
Date: Fri,  9 May 2025 23:18:20 +0200
Message-Id: <20250509211820.36880-16-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250509211820.36880-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61E:EE_|GV1PR07MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 99532316-1804-4750-7b2b-08dd8f3f2087
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NHUvK2NjemEzeFhpMlBmVmduZVJXSC9RRFVqV3NIRXFsemdURzlaVVFab0I1?=
 =?utf-8?B?eFk1QzhFaWdBZ1kyQjdvQ2lmYXNyK0tFVVJwZERMY1NENjJVN0NISUxjcnhY?=
 =?utf-8?B?K2FkOEsxd0l2MnYwMkFNVThNc2NkOGhsbTZBTmNOdEpmS2hua29RVzAvbEdy?=
 =?utf-8?B?N1RUa0Z3WUkwT01MNmtITGdHd21QYjM3czhRNCtCbHNTZmlPalBOSDBoUVJi?=
 =?utf-8?B?cGZ3SlpoemRTUTBRZXBVOU9ITkZnODFpV3VDeEpudUluNGpZRG9CQXpma3pl?=
 =?utf-8?B?cEJFMXN2UzZBMDlSeldQU3p5ZTdWa0p2UXJuOG9WYy9IQXNsWC9LaVV0Yndn?=
 =?utf-8?B?clZLaFViQTBSUDZubDUrdzE4Q0RERitaM002SlVBOEVIVkdVSlRTSE1DV2xi?=
 =?utf-8?B?cDJYajRPTklidWZxVzhkSFVHWEhhUlpYUG51VU1CdmJTOWcrcmNyNVNJaVh6?=
 =?utf-8?B?THJ1OW1qM3RWc2Q1bGg1dWxDSktSbm1kM2VLYVZpL1AxUElFWkxEZndHVkg2?=
 =?utf-8?B?eEtpTmhwL0FCSGRUanlaU2ZpK0JJUEFXYjlvV21aRkczZGR2WmdWR3JmaHlD?=
 =?utf-8?B?Vy9BOXFneGJRZ2gzZTVGSElKMDFmc04ySnl0MVRWS3l4QkZwUmFlZkU2SmND?=
 =?utf-8?B?dnNmK3h1S1ZOa1FoMW1Pb21uck1kS01VQyttSjNqY0RrRGtPb2R4V3hPa25a?=
 =?utf-8?B?SUtOQVR3M1J3STJzcWhSTWNvOFhrcmgzTXZjTVdFTXVseG9OYjJRUld3eGdY?=
 =?utf-8?B?UFpYQ2pldlVLdDNPMkt6VlRsZDRZZkVuRTF2UzlCcXNZbm5hNWduM3kwM2hV?=
 =?utf-8?B?M0xwWk9mU09zOWlMN2VKalBJYzhka0tsd1diT3FrWE1Oc1BqN0ZmL1NQK1dz?=
 =?utf-8?B?RzZkMHVWd1JIRG13eWVaUmhVckg2SzRQVG4wVW1kb3FsUFFiVFJQTER3bVhH?=
 =?utf-8?B?NUhnYlFLZ3BWMGVrTWt1cTJCaUhNRkptak1IKys3dmtEYVdJT0FIMGc5d2h2?=
 =?utf-8?B?Y09XMVFZTVU3N1Uvc2g3a3o3Tmd1YWNUejZYWGpLSVhUMkp6czEwcU9iSGFB?=
 =?utf-8?B?T1owMnJuSUc3UHc4dXVHM3JVT3FrZEJLM1dLM2llbTJFLzFjYmdWbUROWkJw?=
 =?utf-8?B?U3FHZGo5SVUwbmpOK2ZCa1hZVW5mRkdxekxCTnR4dXloK2pzYkJBYW9ya3BB?=
 =?utf-8?B?SzFyTTA4VHo5Wm5xTXBvVUF5QmJEMHU2WEVneHNNc0VWeHNwK0I3ZThwbXZU?=
 =?utf-8?B?MTRIbnFMN25uaHpnODFrN0FSV05XSmpJL3RLcHZmQ1IrMGxaVUZJU2VjVU8z?=
 =?utf-8?B?dmRkSThucHp2SjFNMWFMZjFZTUxvUWlaWW5pTXNUMEczTjlzWllSVEZURzdM?=
 =?utf-8?B?MWN2ZXM3SStCKzY5Q0VwTEM3V1FqeXAvOUlJUHduR0ROb0JaNEZBc1RiWHR6?=
 =?utf-8?B?eEhyaHkwMzJhK1FENk90THIybXB3VXF0UGFQV3pDVmJ2eEl4bVI0Q1N2WGND?=
 =?utf-8?B?cDdGays4UnFjZHBCZGE1TlcwWWFueFRBK0tpOFhxQlg5dzZTNzBiRE43R1hX?=
 =?utf-8?B?U3ZwUUp1bnlpaWpiOGF3RTU5TndVUDdRblNpYkhaL1JtSXBZNXJMeHZvS0Fs?=
 =?utf-8?B?YUgyVU51a3RLK0dzK1FUY3pLTGdJb2NJcGd6UitaNTZqQzhHZS9nZEZsNkxN?=
 =?utf-8?B?R2tUYTRFR1hIWGpkdmRjQlhvY3ZJdGV6UHliWWNDbno3Z000b3QwSkZId2h2?=
 =?utf-8?B?WHE1aXFXd1QyVGYwU2g1ZU9TQ3NuTWhJbkV0YitUVmZtSWNKeWZXekZrSnJu?=
 =?utf-8?B?QmxwWmkyYVA1K2ljZDhTYjJieUsxTmxDN1N2aUVwQ3djRUczdFdJM3B0bVJO?=
 =?utf-8?B?Tys3TTJBT0tOWUZOeEt2VHVjdFhhalIxMXRmQTFScjJ0ZmY0RjRwQW04Wmht?=
 =?utf-8?B?ekxtVGt5bVZMN1NrblNaVForQzZ4cXc0VTV3Z2J5ZjQyUlEyeUtXWW9RTE4y?=
 =?utf-8?B?QnF0eTlZZzFQMTVYNFVlTFRWSWpDTWJNeW1FQnZWRFZUancrV1lySWp4dWFM?=
 =?utf-8?B?MjliK0kwZFkxdm5YNFB6dUlnM3hPUXBUM1JoZz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 21:19:04.7496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99532316-1804-4750-7b2b-08dd8f3f2087
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9047

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
 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  1 +
 net/ipv4/tcp.c                                |  2 ++
 net/ipv4/tcp_input.c                          | 20 ++++++++++++++++++-
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index af76d4f9b33a..2e6ef8290aff 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -105,6 +105,7 @@ u32                           received_ce             read_mostly         read_w
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
 u32[3]                        delivered_ecn_bytes                         read_write
+u16                           pkts_acked_ewma                             read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:1                          wait_third_ack                              read_write
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index b5066eef8782..b22914a4f3cb 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -346,6 +346,7 @@ struct tcp_sock {
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
 	u32	delivered_ecn_bytes[3];
+	u16	pkts_acked_ewma;/* Pkts acked EWMA for AccECN cep heuristic */
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8e7446346a65..e9a834418227 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3371,6 +3371,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
+	tp->pkts_acked_ewma = 0;
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5132,6 +5133,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, pkts_acked_ewma);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index deced87f31f8..7535de493d43 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -704,6 +704,10 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 		tcp_count_delivered_ce(tp, delivered);
 }
 
+#define PKTS_ACKED_WEIGHT	6
+#define PKTS_ACKED_PREC		6
+#define ACK_COMP_THRESH		4
+
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 				u32 delivered_pkts, u32 delivered_bytes,
@@ -723,6 +727,19 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	opt_deltas_valid = tcp_accecn_process_option(tp, skb,
 						     delivered_bytes, flag);
 
+	if (delivered_pkts) {
+		if (!tp->pkts_acked_ewma) {
+			tp->pkts_acked_ewma = delivered_pkts << PKTS_ACKED_PREC;
+		} else {
+			u32 ewma = tp->pkts_acked_ewma;
+
+			ewma = (((ewma << PKTS_ACKED_WEIGHT) - ewma) +
+				(delivered_pkts << PKTS_ACKED_PREC)) >>
+				PKTS_ACKED_WEIGHT;
+			tp->pkts_acked_ewma = min_t(u32, ewma, 0xFFFFU);
+		}
+	}
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -771,7 +788,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
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


