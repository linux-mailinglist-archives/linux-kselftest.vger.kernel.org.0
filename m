Return-Path: <linux-kselftest+bounces-32941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2736AB6D8E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26171179DEB
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3782627FD41;
	Wed, 14 May 2025 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qOkx790O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2074.outbound.protection.outlook.com [40.107.104.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235727B4FF;
	Wed, 14 May 2025 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231029; cv=fail; b=nz+iQZIqoJsc3DcGqCVj7j67aekjVyeMF9wiUYEQDEkxSN7UcOX9l39QloFepoBH1IhrvNqGfrDLL7b928vODOrqKX1VBLRFRDl7aVv/W+qH+Yo88rSwCRftVLHZ0u0sGfIE75ajel8NXqiu77a34/ZOb1aPfuX9exaIxeuulKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231029; c=relaxed/simple;
	bh=qitPsQQeT20VB3iwN4hlffqF1BmzCYGbkM9sU8xH3c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJ6fPTn+FmDminJmJ5pdOEpHdchnxwewa6qAYbzUggrWkwH5TDqaRDD3zmnQh2RWcRCpndFTWT39JPpRCS9vleKdL+KVWQgyKf12JURBGIpT32G1Xe7GaADseugXMyloEcrraS4rB8ACGIVOMxnflFAuMDwRfVxpQSFHMz3cMFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qOkx790O; arc=fail smtp.client-ip=40.107.104.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOoOTsQ+fJ4LLBrmvZR/Yfwqs2zt5THe6SnScwlilut1/BTTPFG35PXneSNnGTYTUJe3cBovZ0+3lTbxGYO9XzAZrtq3ZUOP/+sKYSHxdQzpzbX+X54ldv1cJFlFpB94mVRpKJusCL33XFSmN6bnrlbFLs+4f8YS8juD2oB1ArpypHzQZNDApwLGqT15FAlVjp/3Ot/5mhNBFUPA0wlbUAnFIvnlT+CuwZ9E4nBMrpuPTVNYajo9DiIC0Wy1IvjrYeF4h4FOYJU1NgQpLVEy0tAzUEPzJabQZV7To48haolEn5fmqqU72Md3mVfG/ZL35cTfN6pjGyfvB2un1b9uOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cq4W/qiqOubJXdbyF8jB58x3uBzfo5Cy9QLZ80KIoF4=;
 b=UOexvdEQpmx9BhvLxKGWoXOM0XHd6LirPofMhc0AU6gD81U4AD5vqt75um5/TagznxtaOsdSMOfOcuOe8iQZGnU9GEaEWvHhpQC0GCEsMmDz9tHZxHciNCEvM1ZFQ1msLYbJFyodbuO8NpE1uiBUFNDUu0O/tD+ptw31FsUAEbdZyQ0wtYaYHGxDcz3oalibw3er8RBxMTNldP8IBr9MV1faJXDqJ7EeJdiB5r700+dla/LHP9AABZguyDmE3V1UGSbOjcjh/B2yeKbgXYKXIzsoU/pHhhhbCA4UbH0JWgv4c/jC/Gg0dPWOPCe63UNciFSlzMpp3OfJeVZgnRxBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cq4W/qiqOubJXdbyF8jB58x3uBzfo5Cy9QLZ80KIoF4=;
 b=qOkx790OiV7v05cPv7tGJe0QjyBw3AT6IPp2IH3i62cKkuR3PoN1vbC9jJ+5nazHNUJ3P/fSHXYM/X6b5uAHA+TCT3wJAywdxt09ISwwLiOXrIBUQ5f3Gu4BbpylL8SkL6/iDvvYyvX3h1a2SLtdKllw0IXrGvwkK78PE+48d8cwnO8q1M/zPFRBuGDd+l3x8oZzgoW/uA+BT4Cu+XEIMi9FTCwC/rh6qHU14qWAr8lyINaKVZp3WorSrHUXdzY+d/rGSg4HSgHDthd5viaNgD9t76LELqTLuZCaHNC680yTUpCV2sLBN+DVQvi1Jgz0jSnpFc2uhNFBzvhdkq/7dw==
Received: from AM8P190CA0027.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::32)
 by AM7PR07MB6482.eurprd07.prod.outlook.com (2603:10a6:20b:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 13:56:58 +0000
Received: from AMS0EPF0000019F.eurprd05.prod.outlook.com
 (2603:10a6:20b:219:cafe::f5) by AM8P190CA0027.outlook.office365.com
 (2603:10a6:20b:219::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.30 via Frontend Transport; Wed,
 14 May 2025 13:56:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF0000019F.mail.protection.outlook.com (10.167.16.251) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:56:57 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3764720094;
	Wed, 14 May 2025 16:56:56 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v7 net-next 05/15] tcp: accecn: AccECN negotiation
Date: Wed, 14 May 2025 15:56:32 +0200
Message-Id: <20250514135642.11203-6-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019F:EE_|AM7PR07MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d1ca57a-f677-4a52-eb7a-08dd92ef3151
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?V3VHQ3JNSldPWXNNQzFzN3l3cnFqM28rUlAyVDdMNjRJKzh3SFdlc2RYTGpR?=
 =?utf-8?B?eEE3MjFGYytqSnlVMDM4eWFxSXg4bHZaZmxOSmlxMVVzL0hxQmRKaUdGa0F4?=
 =?utf-8?B?N0g2RzYvZHRWYWRIMklHT0s0bVYxTTJIZkV6elZiNVJyNzcvRXI2cnE2NWgz?=
 =?utf-8?B?ZUtaNm40YmdINnVCQVBoS3lzaTk0VTRiVktzU2VSb2R3TXA5NzJkWWNCZDQ2?=
 =?utf-8?B?eWdXa1psSFVyRWdtSjZ5U21YS1ZiRThQTWQrVzRPc1dseTFrWEFldEd0YXg4?=
 =?utf-8?B?VU80WDBMVThnRmlxMzhPdlZQWU5ML2xxV1h0b29ZQlowK3dGR1V2UmtycjVF?=
 =?utf-8?B?TGVRaGZIKzhxSmxsR2JBMlh3dE42eitnbHlCTmFUbnNlSnZVMDJzUWdpSmRH?=
 =?utf-8?B?VXlaVk9ET1Y0NTdKZXpXNDVOZUo4bncyd3gxd28yS29OeHNWd0RIMitaV1hj?=
 =?utf-8?B?NEk3TUJPMEZxWmVLZkFZZHlQVU9xS3hXditrZWh1VXJVTDhSR3o3UDQvaUZB?=
 =?utf-8?B?OWFQWlFxTE52NEdKd2o1VnZSbGFvdDh5ZnRPV1RGNjI1NEZnNE5MUHQyeHB5?=
 =?utf-8?B?ZS9iSFFlWjBPS003ekdzcGU2YU9uNTNFMzZqdm1NZzdGWVpJaExOUi9FZmYy?=
 =?utf-8?B?M29XaU5acTZyWWZ1S0tLUmdKYUVQdVVLc05QMENQa3ZoTGRqOHlBRktMdFVu?=
 =?utf-8?B?VllsYTRzcDg3UE9Vb3VKV05VZTdsai9scVorMGREa2RWVzBRWjBGMHV6TEtO?=
 =?utf-8?B?aHVqRlNvK2l1L3Rqdmh0Y3R6V0x6eTdjV1pVQ3NRN3QrZENLMFM5VzFURWlD?=
 =?utf-8?B?UDE1TC9rZXFHSTVvVHRXY0pzS0xFV2Zla2xaelB1c3kzRFNpY1cxQ0dULzNL?=
 =?utf-8?B?dFBMa1JmRy93N0RXM1BuaSs3SEt4MldzbkpIWnNMUjVkRTJFV1JPL1JJcnVk?=
 =?utf-8?B?UWRha0RneUwwOVZnQzUxYWx1bG8yVk9nd1NxcW5mK0xFZTdBZGRrV2JuNnFI?=
 =?utf-8?B?b3BidCs1TElXQWh2NDhYOHFyYlJoeEgwakhQcEV1V0t5R2MxdWxqVnYzUURN?=
 =?utf-8?B?T3luRHkvR1A5Sm9VVUVpdUpGQTJCeWZuQlFhN2VoM0lmLytkODVhOWhkRTJM?=
 =?utf-8?B?YUlvc3hVaXl1MnN1NVJCZ2JaR0VOWkI3WDVlK1c1bDdTNnhnaEtaSXNLdXBL?=
 =?utf-8?B?cEhIT0JvajVjby95aXozN25WTktZZm05TEY3TjRzbE9URk5lMW1pRE5wZEll?=
 =?utf-8?B?VTNvdkFRZzdXeXA0MlArc2R2UUZnYzJIcXpueU5ZM25zdmlqOThkUEJmVXQr?=
 =?utf-8?B?VU1zMWVtMjNRdTVGbEFPYWJmNjY2NHBjZUFJMXpNVU9Kc09TM3BmeWtsZ0FW?=
 =?utf-8?B?MjhUUldkS0p0ZTl3V3VMQUVsK2FsR0Y0QzNKaUsycXF0VXR6Z0hXbTluSVQ4?=
 =?utf-8?B?UTRzQ0dYb0pQZlNvMHdEOVlGcVg0UGpTeGU3bytJOU41Q2JMNGU5MjF0a3E2?=
 =?utf-8?B?bi9QeUV1R2NNWVdDK0IxYktzdDA4OHNPY2wxSC9TV3lHQVVOWHc4T0h4RUx4?=
 =?utf-8?B?MVA5OVUyWlg5ZDRlYURRMHZzcmRBNWdmNlZWT1pqY3pndEEzd1dya0c2SmdC?=
 =?utf-8?B?V3hkVFF1bVZDd3duL1lMWlFVdHlKSFBNWHVZS3A4SGdzUnViR21lQkhNdzQx?=
 =?utf-8?B?R2lTTmRidHRVQ3QzRmM2VDV0YjZweVJ2aU9idkVRR1lBQy9LdE9FNnFnckV0?=
 =?utf-8?B?bG9ZYjRzK1N1Qk1pZTV1UFZVYTFZZ1hlQ3FtVG9JdmR4Q0o1UEFiZ25qdnU1?=
 =?utf-8?B?TnhxY2llVjgvdWhPNEx1Ync1enpXWjN2aHliRVFtY01VWGtKSGtMaDJoWmRv?=
 =?utf-8?B?ZG1wTjhvL3hVajFCcmNWNTlzNnNONVlNS1VSUkovTXlWMHZvWDZhSzhTeDVH?=
 =?utf-8?B?djZYU3kvQlZObUxFU2JuWG9DUVBBam8vSkk5Z1UvbFRpaHM1cXVaVWJwSHlZ?=
 =?utf-8?Q?13M564kQ+GWuFoxLyCWUf3Vb4dnnU0=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:57.7840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1ca57a-f677-4a52-eb7a-08dd92ef3151
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6482

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN negotiation parts based on the specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN is negotiated using ECE, CWR and AE flags in the
TCP header. TCP falls back into using RFC3168 ECN if one of the
ends supports only RFC3168-style ECN.

The AccECN negotiation includes reflecting IP ECN field value
seen in SYN and SYNACK back using the same bits as negotiation
to allow responding to SYN CE marks and to detect ECN field
mangling. CE marks should not occur currently because SYN=1
segments are sent with Non-ECT in IP ECN field (but proposal
exists to remove this restriction).

Reflecting SYN IP ECN field in SYNACK is relatively simple.
Reflecting SYNACK IP ECN field in the final/third ACK of
the handshake is more challenging. Linux TCP code is not well
prepared for using the final/third ACK a signalling channel
which makes things somewhat complicated here.

tcp_ecn sysctl can be used to select the highest ECN variant
(Accurate ECN, ECN, No ECN) that is attemped to be negotiated and
requested for incoming connection and outgoing connection:
TCP_ECN_IN_NOECN_OUT_NOECN, TCP_ECN_IN_ECN_OUT_ECN,
TCP_ECN_IN_ECN_OUT_NOECN, TCP_ECN_IN_ACCECN_OUT_ACCECN,
TCP_ECN_IN_ACCECN_OUT_ECN, and TCP_ECN_IN_ACCECN_OUT_NOECN.

After this patch, the size of tcp_request_sock remains unchanged
and no new holes are added. Below are the pahole outcomes before
and after this patch:

[BEFORE THIS PATCH]
struct tcp_request_sock {
    [...]
    u32                        rcv_nxt;              /*   352     4 */
    u8                         syn_tos;              /*   356     1 */

    /* size: 360, cachelines: 6, members: 16 */
}

[AFTER THIS PATCH]
struct tcp_request_sock {
    [...]
    u32                        rcv_nxt;              /*   352     4 */
    u8                         syn_tos;              /*   356     1 */
    bool                       accecn_ok;            /*   357     1 */
    u8                         syn_ect_snt:2;        /*   358: 0  1 */
    u8                         syn_ect_rcv:2;        /*   358: 2  1 */
    u8                         accecn_fail_mode:4;   /*   358: 4  1 */

    /* size: 360, cachelines: 6, members: 20 */
}

After this patch, the size of tcp_sock remains unchanged and no new
holes are added. Also, 4 bits of the existing 2-byte hole are exploited.
Below are the pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u8                         dup_ack_counter:2;    /*  2825: 0  1 */
    u8                         tlp_retrans:1;        /*  2825: 2  1 */
    u8                         unused:5;             /*  2825: 3  1 */
    u8                         thin_lto:1;           /*  2826: 0  1 */
    u8                         fastopen_connect:1;   /*  2826: 1  1 */
    u8                         fastopen_no_cookie:1; /*  2826: 2  1 */
    u8                         fastopen_client_fail:2; /*  2826: 3  1 */
    u8                         frto:1;               /*  2826: 5  1 */
    /* XXX 2 bits hole, try to pack */

    [...]
    u8                         keepalive_probes;     /*  2829     1 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 166 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u8                         dup_ack_counter:2;    /*  2825: 0  1 */
    u8                         tlp_retrans:1;        /*  2825: 2  1 */
    u8                         syn_ect_snt:2;        /*  2825: 3  1 */
    u8                         syn_ect_rcv:2;        /*  2825: 5  1 */
    u8                         wait_third_ack:1;     /*  2825: 7  1 */
    u8                         thin_lto:1;           /*  2826: 0  1 */
    u8                         fastopen_connect:1;   /*  2826: 1  1 */
    u8                         fastopen_no_cookie:1; /*  2826: 2  1 */
    u8                         fastopen_client_fail:2; /*  2826: 3  1 */
    u8                         frto:1;               /*  2826: 5  1 */
    /* XXX 2 bits hole, try to pack */

    [...]
    u8                         keepalive_probes;     /*  2829     1 */
    u8                         accecn_fail_mode:4;   /*  2830: 0  1 */
    /* XXX 4 bits hole, try to pack */
    /* XXX 1 byte hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 169 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 .../networking/net_cachelines/tcp_sock.rst    |   4 +
 include/linux/tcp.h                           |   9 +-
 include/net/tcp.h                             |  93 ++++++++-
 net/ipv4/syncookies.c                         |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   3 +-
 net/ipv4/tcp.c                                |   2 +
 net/ipv4/tcp_input.c                          | 178 ++++++++++++++++--
 net/ipv4/tcp_ipv4.c                           |   5 +-
 net/ipv4/tcp_minisocks.c                      |  51 ++++-
 net/ipv4/tcp_output.c                         |  78 ++++++--
 net/ipv6/syncookies.c                         |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 12 files changed, 384 insertions(+), 44 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 9bf507c349a0..eef8700085de 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -103,6 +103,10 @@ u32                           delivered               read_mostly         read_w
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
+u8:2                          syn_ect_snt             write_mostly        read_write
+u8:2                          syn_ect_rcv             read_mostly         read_write
+u8:1                          wait_third_ack                              read_write
+u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index e1884df45a27..b0e6a11a3fa1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -168,6 +168,10 @@ struct tcp_request_sock {
 						  * after data-in-SYN.
 						  */
 	u8				syn_tos;
+	bool				accecn_ok;
+	u8				syn_ect_snt: 2,
+					syn_ect_rcv: 2,
+					accecn_fail_mode:4;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -376,7 +380,9 @@ struct tcp_sock {
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
-		unused:5;
+		syn_ect_snt:2,	/* AccECN ECT memory, only */
+		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
+		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
@@ -392,6 +398,7 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
+	u8	accecn_fail_mode:4;	/* AccECN failure handling */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index cc28255deef7..5fce4b49e132 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -27,6 +27,7 @@
 #include <linux/ktime.h>
 #include <linux/indirect_call_wrapper.h>
 #include <linux/bits.h>
+#include <linux/bitfield.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -234,6 +235,37 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
 
+/* tp->accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
+static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_ace_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_RECV;
+}
+
+static inline bool tcp_accecn_opt_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_opt_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_RECV;
+}
+
+static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->accecn_fail_mode |= mode;
+}
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -420,6 +452,23 @@ static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
 }
 
+/* Infer the ECT value our SYN arrived with from the echoed ACE field */
+static inline int tcp_accecn_extract_syn_ect(u8 ace)
+{
+	if (ace & 0x1)
+		return INET_ECN_ECT_1;
+	if (!(ace & 0x2))
+		return INET_ECN_ECT_0;
+	if (ace & 0x4)
+		return INET_ECN_CE;
+	return INET_ECN_NOT_ECT;
+}
+
+bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
+void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
+			  u8 syn_ect_snt);
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb);
+
 enum tcp_tw_status {
 	TCP_TW_SUCCESS = 0,
 	TCP_TW_RST = 1,
@@ -657,6 +706,15 @@ static inline bool cookie_ecn_ok(const struct net *net, const struct dst_entry *
 		dst_feature(dst, RTAX_FEATURE_ECN);
 }
 
+/* AccECN specification, 5.1: [...] a server can determine that it
+ * negotiated AccECN as [...] if the ACK contains an ACE field with
+ * the value 0b010 to 0b111 (decimal 2 to 7).
+ */
+static inline bool cookie_accecn_ok(const struct tcphdr *th)
+{
+	return tcp_accecn_ace(th) > 0x1;
+}
+
 #if IS_ENABLED(CONFIG_BPF)
 static inline bool cookie_bpf_ok(struct sk_buff *skb)
 {
@@ -968,6 +1026,7 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
+#define TCPHDR_SYNACK_ACCECN (TCPHDR_SYN | TCPHDR_ACK | TCPHDR_CWR)
 
 #define TCP_ACCECN_CEP_ACE_MASK 0x7
 #define TCP_ACCECN_ACE_MAX_DELTA 6
@@ -977,6 +1036,19 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
  */
 #define TCP_ACCECN_CEP_INIT_OFFSET 5
 
+/* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
+ * attemped to be negotiated and requested for incoming connection
+ * and outgoing connection, respectively.
+ */
+enum tcp_ecn_mode {
+	TCP_ECN_IN_NOECN_OUT_NOECN = 0,
+	TCP_ECN_IN_ECN_OUT_ECN = 1,
+	TCP_ECN_IN_ECN_OUT_NOECN = 2,
+	TCP_ECN_IN_ACCECN_OUT_ACCECN = 3,
+	TCP_ECN_IN_ACCECN_OUT_ECN = 4,
+	TCP_ECN_IN_ACCECN_OUT_NOECN = 5,
+};
+
 static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 {
 	tp->received_ce = 0;
@@ -1051,6 +1123,15 @@ struct tcp_skb_cb {
 
 #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
 
+static inline u16 tcp_accecn_reflector_flags(u8 ect)
+{
+	u32 flags = ect + 2;
+
+	if (ect == 3)
+		flags++;
+	return FIELD_PREP(TCPHDR_ACE, flags);
+}
+
 extern const struct inet_connection_sock_af_ops ipv4_specific;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -1173,7 +1254,10 @@ enum tcp_ca_ack_event_flags {
 #define TCP_CONG_NON_RESTRICTED		BIT(0)
 /* Requires ECN/ECT set on all packets */
 #define TCP_CONG_NEEDS_ECN		BIT(1)
-#define TCP_CONG_MASK	(TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
+/* Require successfully negotiated AccECN capability */
+#define TCP_CONG_NEEDS_ACCECN		BIT(2)
+#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
+			TCP_CONG_NEEDS_ACCECN)
 
 union tcp_cc_info;
 
@@ -1305,6 +1389,13 @@ static inline bool tcp_ca_needs_ecn(const struct sock *sk)
 	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
 }
 
+static inline bool tcp_ca_needs_accecn(const struct sock *sk)
+{
+	const struct inet_connection_sock *icsk = inet_csk(sk);
+
+	return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
+}
+
 static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event event)
 {
 	const struct inet_connection_sock *icsk = inet_csk(sk);
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index 5459a78b9809..3a44eb9c1d1a 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -403,6 +403,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct net *net = sock_net(sk);
+	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct sock *ret = sk;
 	struct flowi4 fl4;
@@ -428,6 +429,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
 
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -482,6 +484,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
+	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a43010d726f..75ec1a599b52 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,6 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
+static int tcp_ecn_mode_max = 5;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -728,7 +729,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= &tcp_ecn_mode_max,
 	},
 	{
 		.procname	= "tcp_ecn_fallback",
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 0c8a391d90fe..29146bb3585a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3396,6 +3396,8 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->wait_third_ack = 0;
+	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 8dbb625f5e8a..f0475f95e112 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -401,14 +401,114 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
-static void tcp_ecn_rcv_synack(struct tcp_sock *tp, const struct tcphdr *th)
+/* AccECN specificaiton, 3.1.2: If a TCP server that implements AccECN
+ * receives a SYN with the three TCP header flags (AE, CWR and ECE) set
+ * to any combination other than 000, 011 or 111, it MUST negotiate the
+ * use of AccECN as if they had been set to 111.
+ */
+static bool tcp_accecn_syn_requested(const struct tcphdr *th)
+{
+	u8 ace = tcp_accecn_ace(th);
+
+	return ace && ace != 0x3;
+}
+
+/* Check ECN field transition to detect invalid transitions */
+static bool tcp_ect_transition_valid(u8 snt, u8 rcv)
 {
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+	if (rcv == snt)
+		return true;
+
+	/* Non-ECT altered to something or something became non-ECT */
+	if (snt == INET_ECN_NOT_ECT || rcv == INET_ECN_NOT_ECT)
+		return false;
+	/* CE -> ECT(0/1)? */
+	if (snt == INET_ECN_CE)
+		return false;
+	return true;
+}
+
+bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
+{
+	u8 ect = tcp_accecn_extract_syn_ect(ace);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback)
+		return true;
+
+	if (!tcp_ect_transition_valid(sent_ect, ect)) {
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		return false;
+	}
+
+	return true;
+}
+
+/* See Table 2 of the AccECN draft */
+
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
+			       u8 ip_dsfield)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 ace = tcp_accecn_ace(th);
+
+	switch (ace) {
+	case 0x0:
+	case 0x7:
+		/* +========+========+============+=============+
+		 * | A      | B      |  SYN/ACK   |  Feedback   |
+		 * |        |        |    B->A    |  Mode of A  |
+		 * |        |        | AE CWR ECE |             |
+		 * +========+========+============+=============+
+		 * | AccECN | No ECN | 0   0   0  |   Not ECN   |
+		 * | AccECN | Broken | 1   1   1  |   Not ECN   |
+		 * +--------+--------+------------+-------------+
+		 */
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		break;
+	case 0x1:
+	case 0x5:
+		/* +========+========+============+=============+
+		 * | A      | B      |  SYN/ACK   |  Feedback   |
+		 * |        |        |    B->A    |  Mode of A  |
+		 * |        |        | AE CWR ECE |             |
+		 * +========+========+============+=============+
+		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
+		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
+		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
+		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
+		 * +--------+--------+------------+-------------+
+		 */
+		if (tcp_ecn_mode_pending(tp))
+			/* Downgrade from AccECN, or requested initially */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		break;
+	default:
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		if (INET_ECN_is_ce(ip_dsfield) &&
+		    tcp_accecn_validate_syn_feedback(sk, ace,
+						     tp->syn_ect_snt)) {
+			tp->received_ce++;
+			tp->received_ce_pending++;
+		}
+		break;
+	}
 }
 
-static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th)
+static void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+			    const struct sk_buff *skb)
 {
+	if (tcp_ecn_mode_pending(tp)) {
+		if (!tcp_accecn_syn_requested(th)) {
+			/* Downgrade to classic ECN feedback */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		} else {
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		}
+	}
 	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
@@ -3833,8 +3933,18 @@ bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 	return __tcp_oow_rate_limited(net, mib_idx, last_oow_ack_time);
 }
 
+static void tcp_send_ack_reflect_ect(struct sock *sk, bool accecn_reflector)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u16 flags = 0;
+
+	if (accecn_reflector)
+		flags = tcp_accecn_reflector_flags(tp->syn_ect_rcv);
+	__tcp_send_ack(sk, tp->rcv_nxt, flags);
+}
+
 /* RFC 5961 7 [ACK Throttling] */
-static void tcp_send_challenge_ack(struct sock *sk)
+static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
@@ -3864,7 +3974,7 @@ static void tcp_send_challenge_ack(struct sock *sk)
 		WRITE_ONCE(net->ipv4.tcp_challenge_count, count - 1);
 send_ack:
 		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
-		tcp_send_ack(sk);
+		tcp_send_ack_reflect_ect(sk, accecn_reflector);
 	}
 }
 
@@ -4031,7 +4141,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
-				tcp_send_challenge_ack(sk);
+				tcp_send_challenge_ack(sk, false);
 			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
 		}
 		goto old_ack;
@@ -6025,8 +6135,7 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-static void tcp_ecn_received_counters(struct sock *sk,
-				      const struct sk_buff *skb)
+void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -6068,6 +6177,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 				  const struct tcphdr *th, int syn_inerr)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool accecn_reflector = false;
 	SKB_DR(reason);
 
 	/* RFC1323: H1. Apply PAWS check first. */
@@ -6160,7 +6270,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (tp->syn_fastopen && !tp->data_segs_in &&
 		    sk->sk_state == TCP_ESTABLISHED)
 			tcp_fastopen_active_disable(sk);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, false);
 		SKB_DR_SET(reason, TCP_RESET);
 		goto discard;
 	}
@@ -6171,16 +6281,23 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (tcp_ecn_mode_accecn(tp))
+			accecn_reflector = true;
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
-		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt)
+		    TCP_SKB_CB(skb)->ack_seq == tp->snd_nxt) {
+			if (!tcp_ecn_disabled(tp)) {
+				tp->wait_third_ack = true;
+				tcp_send_ack_reflect_ect(sk, accecn_reflector);
+			}
 			goto pass;
+		}
 syn_challenge:
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNCHALLENGE);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, accecn_reflector);
 		SKB_DR_SET(reason, TCP_INVALID_SYN);
 		goto discard;
 	}
@@ -6393,6 +6510,12 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	if (unlikely(tp->wait_third_ack)) {
+		tp->wait_third_ack = 0;
+		if (tcp_ecn_mode_accecn(tp))
+			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+		tcp_fast_path_on(tp);
+	}
 	tcp_ecn_received_counters(sk, skb);
 
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
@@ -6645,7 +6768,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 *    state to ESTABLISHED..."
 		 */
 
-		tcp_ecn_rcv_synack(tp, th);
+		if (tcp_ecn_mode_any(tp))
+			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -6717,7 +6841,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 					     TCP_DELACK_MAX, false);
 			goto consume;
 		}
-		tcp_send_ack(sk);
+		tcp_send_ack_reflect_ect(sk, tcp_ecn_mode_accecn(tp));
 		return -1;
 	}
 
@@ -6776,7 +6900,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th);
+		tcp_ecn_rcv_syn(tp, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
@@ -6958,7 +7082,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
-			tcp_send_challenge_ack(sk);
+			tcp_send_challenge_ack(sk, false);
 			reason = -reason;
 			goto discard;
 		}
@@ -7005,9 +7129,16 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->lsndtime = tcp_jiffies32;
 
 		tcp_initialize_rcv_mss(sk);
-		tcp_fast_path_on(tp);
+		if (likely(!tp->wait_third_ack)) {
+			if (tcp_ecn_mode_accecn(tp))
+				tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
+			tcp_fast_path_on(tp);
+		}
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
+
+		if (sk->sk_socket && tp->wait_third_ack)
+			goto consume;
 		break;
 
 	case TCP_FIN_WAIT1: {
@@ -7177,6 +7308,15 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	bool ect, ecn_ok;
 	u32 ecn_ok_dst;
 
+	if (tcp_accecn_syn_requested(th) &&
+	    (net->ipv4.sysctl_tcp_ecn >= 3 || tcp_ca_needs_accecn(listen_sk))) {
+		inet_rsk(req)->ecn_ok = 1;
+		tcp_rsk(req)->accecn_ok = 1;
+		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					    INET_ECN_MASK;
+		return;
+	}
+
 	if (!th_ecn)
 		return;
 
@@ -7184,7 +7324,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
 	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
 
-	if (((!ect || th->res1) && ecn_ok) || tcp_ca_needs_ecn(listen_sk) ||
+	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
+	    tcp_ca_needs_ecn(listen_sk) ||
 	    (ecn_ok_dst & DST_FEATURE_ECN_CA) ||
 	    tcp_bpf_ca_needs_ecn((struct sock *)req))
 		inet_rsk(req)->ecn_ok = 1;
@@ -7202,6 +7343,9 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_synack = 0;
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
+	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->syn_ect_rcv = 0;
+	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
 	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
 	ireq->tstamp_ok = rx_opt->tstamp_ok;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index d5b5c32115d2..5cec04ed6a8e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1189,7 +1189,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 			      enum tcp_synack_type synack_type,
 			      struct sk_buff *syn_skb)
 {
-	const struct inet_request_sock *ireq = inet_rsk(req);
+	struct inet_request_sock *ireq = inet_rsk(req);
 	struct flowi4 fl4;
 	int err = -1;
 	struct sk_buff *skb;
@@ -1202,6 +1202,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
 		__tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
 
 		tos = READ_ONCE(inet_sk(sk)->tos);
@@ -3448,7 +3449,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 
 static int __net_init tcp_sk_init(struct net *net)
 {
-	net->ipv4.sysctl_tcp_ecn = 2;
+	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 43d7852ce07e..779a206a5ca6 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -461,12 +461,51 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	ireq->rcv_wscale = rcv_wscale;
 }
 
-static void tcp_ecn_openreq_child(struct tcp_sock *tp,
-				  const struct request_sock *req)
+void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
+			  u8 syn_ect_snt)
 {
-	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-			     TCP_ECN_MODE_RFC3168 :
-			     TCP_ECN_DISABLED);
+	u8 ace = tcp_accecn_ace(tcp_hdr(skb));
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	switch (ace) {
+	case 0x0:
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		break;
+	case 0x7:
+	case 0x5:
+	case 0x1:
+		/* Unused but legal values */
+		break;
+	default:
+		/* Validation only applies to first non-data packet */
+		if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq &&
+		    !TCP_SKB_CB(skb)->sacked &&
+		    tcp_accecn_validate_syn_feedback(sk, ace, syn_ect_snt)) {
+			if ((tcp_accecn_extract_syn_ect(ace) == INET_ECN_CE) &&
+			    !tp->delivered_ce)
+				tp->delivered_ce++;
+		}
+		break;
+	}
+}
+
+static void tcp_ecn_openreq_child(struct sock *sk,
+				  const struct request_sock *req,
+				  const struct sk_buff *skb)
+{
+	const struct tcp_request_sock *treq = tcp_rsk(req);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (treq->accecn_ok) {
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_snt = treq->syn_ect_snt;
+		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tcp_ecn_received_counters(sk, skb);
+	} else {
+		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+				     TCP_ECN_MODE_RFC3168 :
+				     TCP_ECN_DISABLED);
+	}
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
@@ -631,7 +670,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
 	newtp->rx_opt.mss_clamp = req->mss;
-	tcp_ecn_openreq_child(newtp, req);
+	tcp_ecn_openreq_child(newsk, req, skb);
 	newtp->fastopen_req = NULL;
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 63352372248b..d0f0fee8335e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -322,7 +322,7 @@ static u16 tcp_select_window(struct sock *sk)
 /* Packet ECN state for a SYN-ACK */
 static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 {
-	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
 	if (tcp_ecn_disabled(tp))
@@ -330,6 +330,13 @@ static void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
 		INET_ECN_xmit(sk);
+
+	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+		TCP_SKB_CB(skb)->tcp_flags |=
+			tcp_accecn_reflector_flags(tp->syn_ect_rcv);
+		tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+	}
 }
 
 /* Packet ECN state for a SYN.  */
@@ -337,8 +344,20 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
-	bool use_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) == 1 ||
-		tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
+	bool use_ecn, use_accecn;
+	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
+
+	/* ==============  ==========================
+	 * tcp_ecn values  Outgoing connections
+	 * ==============  ==========================
+	 *      0,2,5       Do not request ECN
+	 *       1,4        Request ECN connection
+	 *        3         Request AccECN connection
+	 * ==============  ==========================
+	 */
+	use_accecn = tcp_ecn == 3 || tcp_ca_needs_accecn(sk);
+	use_ecn = tcp_ecn == 1 || tcp_ecn == 4 ||
+		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
 
 	if (!use_ecn) {
 		const struct dst_entry *dst = __sk_dst_get(sk);
@@ -354,35 +373,58 @@ static void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		if (use_accecn) {
+			TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_AE;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_PENDING);
+			tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+		} else {
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		}
 	}
 }
 
 static void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 {
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback)) {
 		/* tp->ecn_flags are cleared at a later point in time when
 		 * SYN ACK is ultimatively being received.
 		 */
-		TCP_SKB_CB(skb)->tcp_flags &= ~(TCPHDR_ECE | TCPHDR_CWR);
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+	}
+}
+
+static void tcp_accecn_echo_syn_ect(struct tcphdr *th, u8 ect)
+{
+	th->ae = !!(ect & INET_ECN_ECT_0);
+	th->cwr = ect != INET_ECN_ECT_0;
+	th->ece = ect == INET_ECN_ECT_1;
 }
 
 static void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (inet_rsk(req)->ecn_ok)
+	if (tcp_rsk(req)->accecn_ok)
+		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+	else if (inet_rsk(req)->ecn_ok)
 		th->ece = 1;
 }
 
-static void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+static void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
+			       struct tcphdr *th)
 {
 	u32 wire_ace;
 
-	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
-	th->ece = !!(wire_ace & 0x1);
-	th->cwr = !!(wire_ace & 0x2);
-	th->ae = !!(wire_ace & 0x4);
-	tp->received_ce_pending = 0;
+	/* The final packet of the 3WHS or anything like it must reflect
+	 * the SYN/ACK ECT instead of putting CEP into ACE field, such
+	 * case show up in tcp_flags.
+	 */
+	if (likely(!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACE))) {
+		wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+		th->ece = !!(wire_ace & 0x1);
+		th->cwr = !!(wire_ace & 0x2);
+		th->ae = !!(wire_ace & 0x4);
+		tp->received_ce_pending = 0;
+	}
 }
 
 /* Set up ECN state for a packet on a ESTABLISHED socket that is about to
@@ -397,8 +439,9 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		INET_ECN_xmit(sk);
-		tcp_accecn_set_ace(th, tp);
+		if (!tcp_accecn_ace_fail_recv(tp))
+			INET_ECN_xmit(sk);
+		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
@@ -3415,7 +3458,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback */
+	/* RFC3168, section 6.1.1.1. ECN fallback
+	 * As AccECN uses the same SYN flags (+ AE), this check covers both
+	 * cases.
+	 */
 	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
 		tcp_ecn_clear_syn(sk, skb);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index 9d83eadd308b..50046460ee0b 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -264,6 +264,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
+	tcp_rsk(req)->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 	if (!ret) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index e8e68a142649..eb7dc7fb08cc 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -544,6 +544,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = np->tclass & INET_ECN_MASK;
 		__tcp_v6_send_check(skb, &ireq->ir_v6_loc_addr,
 				    &ireq->ir_v6_rmt_addr);
 
-- 
2.34.1


