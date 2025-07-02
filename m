Return-Path: <linux-kselftest+bounces-36267-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93936AF09EA
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BF7480A5F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A14214A93;
	Wed,  2 Jul 2025 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="lq/LvO5e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AAD21883C;
	Wed,  2 Jul 2025 04:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431073; cv=fail; b=dBnYusw90k1gqX1tNwRl5YnWg+1UwY/PZHkYZD5JmroPjlsZC2xyF6LalzE3R/QD88rE1RkE2nUNDEOGfsjc8rO0q04S10T8LugscEDPemwiF6c/Kci+o38WqyRtpx8wgdw1jByc5q9Ed3R6qr8udt6pIWOrnnPMz30WcIRIYp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431073; c=relaxed/simple;
	bh=1t7BBWanj02qZy04VdPUKaCAYR2vDRSyjnza2xuia14=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBg32df67IBdYatovl26sIRhsJh9lzxOSGN6QxxHv5yLxvtEwbMKBkWH1K0qdNa/Vr8w2GYnDDJazs7VcdKHCyz83987gCxx/K8bR1P4Kf+I/nTZJNq0Ax7JIMBUzC9/WLsh3Y/BPZuN/VDyUgHPV5yj/IItghx8hivVN6Jd5Wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=lq/LvO5e; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIl7SIYIfWDfJCxQei0kBJqV/FNPwySPJLiK/uAnYMXvgPx192iiJYkLQ4uWKa/f5SsrJIF3QdDbUBaYKrhjqW0rDHDDDpzROAN3eOog77lRgfYEaDVku974lUaxpfI3sNaQKEyz6ni3lJuLze8JHbvAEajb3rR3wgM0pm366HtqTzLtVLx/+uB9A2ZLyX1JHOh99MM491LHtB/F6FG16/OE4CrP8bf7rFR44nO8cFTmF4WsrMZMyTii7oWsnh8iEY30aW+G2cYrWZhC1sZ8y2giVvNUi/PXV0HkDcn+9YOwDgXgU4dmvcnu9QmKtNcSCieIZ9eXayIUK4TAWJPs2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otophF1Wi4UAQwLAtoJAuBdbyy/VYF4/v3LhdX07py0=;
 b=P1mKFlpwbzfdopNZs7OHfHGR1dqVU9sGUqh/Vt/XXBqz/uCisfJcT6K/X9FqWKMg2fm9KLSUX/mlJdFtkL9Rzp7kw+J1/FmfR1c1H9/mcA3fNrxOHcvnB9AIksJGVjpPO05N3SvPkTAQEOhENu0GnndIS9D4qSoVKnzGboxnYuyUhrmn58+E7n87+tr6YKHEgpNSCGdqgKoacQjJr+KSOprUVAO9Zv9qkpSxIG2jFqOTIiVKj1pbA2/B35MrJjM5cYjgf71S0vF8h/i+sqm7endl+1mnEMWbfKywTjx/ptpA+oPS3oXb2HKs/eIclzEInm4aGV3ALGDeHntDHouOdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otophF1Wi4UAQwLAtoJAuBdbyy/VYF4/v3LhdX07py0=;
 b=lq/LvO5eJRp9A0Ji/YASEDu1NWJw3e/SL5y09PBF1XA8/8OitebgD+3QIH8ruoQO3bxNhGO1LbkTlg1bLnyYRd9ECOQAxiLYpomNn38Nvj6tqkzO1sZu6lVEQU+9gBuuwK4Y0gU67Z8e6MhWMLpnT5RCoWrgtdsrC6B4BX29SlM5IHgWMSoQxTslWtbXQJXYlWPe4kKqhfRO5rOIUe5MwuxqubU/YCQ+CFyVMqNgnGFTxTlucpnefmTUmgBKlotleluHv920oA8g7S6tCfJa0tE8niY74qvEr3fRJxXUxmgQXRPVWFE/rWjDK2cpSxaLCY6Er25CZY/3V0hcvrlFmg==
Received: from DUZPR01CA0302.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::19) by DUZPR07MB10125.eurprd07.prod.outlook.com
 (2603:10a6:10:4de::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 04:37:44 +0000
Received: from DU6PEPF00009529.eurprd02.prod.outlook.com
 (2603:10a6:10:4b7:cafe::cf) by DUZPR01CA0302.outlook.office365.com
 (2603:10a6:10:4b7::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Wed,
 2 Jul 2025 04:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF00009529.mail.protection.outlook.com (10.167.8.10) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:43 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id B70E81C0042;
	Wed,  2 Jul 2025 07:37:41 +0300 (EEST)
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
Subject: [PATCH v10 net-next 11/15] tcp: accecn: AccECN option
Date: Wed,  2 Jul 2025 06:37:15 +0200
Message-Id: <20250702043719.15130-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF00009529:EE_|DUZPR07MB10125:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f932643-ddb9-413e-751f-08ddb9222fa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFR1N2tWakdwSVVqRE1aNGNQVnZGYVRoeENqeWp5N2tpanV2L0pFTWRVak01?=
 =?utf-8?B?QW9GZE5iTmtOWEdnRFVBTmtyNmYvYnBMdUliazAzNGF6SG1JUTY2MExWRmxZ?=
 =?utf-8?B?VUxGZ1FwY1B1c29pWjFiakNLaS82cktremFPTnZ0Mk5QekVlVXRXR2NaVEJU?=
 =?utf-8?B?MG1ia2VIbENicy9GcEtsMkFqTTlZdTFyTENMZmFWM2xFcGl4QXhUL1ZZd1NN?=
 =?utf-8?B?aVo0OGZESVp4NTF6UWRmdUZNSHE4YVpnZElxTUw0N1pMd3RHcUFpMkNWUnNm?=
 =?utf-8?B?V3k5aVc4NzhCYW9CZ3pjKzRJTDdib0pZeU5ZZm0vVExmWHAvdE5PWmM2L1hj?=
 =?utf-8?B?ZFJZK21HWVZCd05vZ0xEekUvZktSYzc0eWN6NE5aM0RFT2V2cGpVenZYcUlq?=
 =?utf-8?B?OXBucWx4cVFuYTNxNGhQM3VDMzk3TGZBaWZYRGxCOWhrYzgrSmEvbDIzYmFy?=
 =?utf-8?B?ZXFGMXpldnhVUXFtZ2xRdUcyc3VaakdSUUpCbnliT3RoVUtUVmxheUhKREpm?=
 =?utf-8?B?RUxnY000V3N5MU4wSlkvV2l3ZnNBQVBGdXVGY3plMEE1VE1RQWlkZVEvenNk?=
 =?utf-8?B?RTdMRlZGMlhxUXRXc3JlTExWMyt5bnBJVEp3T0RWNGRlcExuZnpQT2tuUlQw?=
 =?utf-8?B?SXhUa0JWRzBKMjhJR1B4d2tDZjJLRmFHM3AwNzgwYkxMdnhnWmhSQjJTbEhJ?=
 =?utf-8?B?OFg4eE9oSmdSSXdMV0ZDaEh3NVR1SjZFeVpqV3lOaDBHcko1YUtIeDI4Ykhx?=
 =?utf-8?B?UnRsT1J1YWJnVlBmZnYvOXN3QVJOT3dTRXo0KzhVVDl2WGdHOStJSkNlaVA3?=
 =?utf-8?B?bHFtRXhHNDFjTk9kejhTUXRFN3FMNjFxNG1HdE9wUFRva2hGUElpcEh1Vjd1?=
 =?utf-8?B?VGhqVXhyVVBJanRjV1g4ejZGcWlsNHhyTG5xQ3M0cHA0Vk9IN0lxdzl1Q2ZS?=
 =?utf-8?B?OGRMbWxYMVpCQUN2Yk5vRy92eXJxV2tzREFvWWF0WnFMdGtKazRTZ1FPbUlu?=
 =?utf-8?B?TVhXVFVmdW91SjJoRGxEclRCSDBRUWltTnIyUjJXNGRDVmk1RGJKaEF5aWc2?=
 =?utf-8?B?eXpqN2ZFWWZmVEVDa0JkbmYzQ1I4bGo0alV2ZVRhQ012V003M01tRzBPSTN1?=
 =?utf-8?B?dDJzODhtRlhkN0pEUDlGbXRDZEUvUzRrd0o5SXhScmtYamhPZ2k3Vk0zOVpD?=
 =?utf-8?B?cUdobktDZnRQVWVqNUpkRzFnNTl0NU9wZ0JUS0JBdlNrelJjMTBISG9yWHo1?=
 =?utf-8?B?MnBuazYvSFVqNjVFbTZsLzdleWg2NkEzcER5SUhuUDVHZUtFa3I3K2VWakNa?=
 =?utf-8?B?RFBMVFg1R0dicENQZCs2WG5VZ0ZlQWtTeEtoVEQvQ2F3ZWs2b1NIM1NMMEVz?=
 =?utf-8?B?NnJSTmt4aUovQ2hYZ3pWZ3pkZXM1am5HZUVrSktuM3JiUFFacEtRSXRPSmRI?=
 =?utf-8?B?UXpRTkdSS2lJWXhIRHc0d2FwMkN1UFNqdVNURlhGdDFtOENzMEdobTR1VTNJ?=
 =?utf-8?B?a29GU0U2Z3lzNmo1RGhiR1BJdFBmNkRIdzd6QXpPZ05zUDg3K3Zoa241TjFt?=
 =?utf-8?B?ak5DY2d2NDNDK2lHdlVXSUNlcDdYaVR4NHV2RTZwYXFGdFlPZStTY0Zmbmpm?=
 =?utf-8?B?bG9iQldVWllxUlFncU1YRU5MaThWZVltMTlQNlIyVUlBQmw5K1ZNUm52Vngv?=
 =?utf-8?B?aE5LREhzV3RoYVJBTzFaTnliOUFDVDJqS3dZTkRNMFlNRmVPOTVReTN0cCtL?=
 =?utf-8?B?NjI5STAyblFCYjkzVEoySzZieHhKU0RQaDlZY1YxQ3AzVDdKNmVrakFOVVFJ?=
 =?utf-8?B?YkNNMnZuRm1WeUpON2gycHltVDBDbnVCRWVFaU1LUTJ2Nk5iOUZLSWl0NkZJ?=
 =?utf-8?B?bm92a0FIUGRyRlFxaXc5dWxjM0x1Tlp4UTlpeEhnTnNXZTR6NHZlSHlocUxl?=
 =?utf-8?B?RjFYODU4QlpXbFN5M1NOUXdZTEk3QXM0MFFDQ3BkOVZIazlVWTlmTU5OVVZp?=
 =?utf-8?B?Q3o5bk0wYnNYRTN3ZDlFR09HblBOcVlyNXhqUkk1Ukt1MS9KbmRkcjZHdDBE?=
 =?utf-8?B?Q29ueGNxd0JQSUM3c2x3MkpiNTU3cGIxdFZLZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:43.4881
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f932643-ddb9-413e-751f-08ddb9222fa7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB10125

From: Ilpo Järvinen <ij@kernel.org>

The Accurate ECN allows echoing back the sum of bytes for
each IP ECN field value in the received packets using
AccECN option. This change implements AccECN option tx & rx
side processing without option send control related features
that are added by a later change.

Based on specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
(Some features of the spec will be added in the later changes
rather than in this one).

A full-length AccECN option is always attempted but if it does
not fit, the minimum length is selected based on the counters
that have changed since the last update. The AccECN option
(with 24-bit fields) often ends in odd sizes so the option
write code tries to take advantage of some nop used to pad
the other TCP options.

The delivered_ecn_bytes pairs with received_ecn_bytes similar
to how delivered_ce pairs with received_ce. In contrast to
ACE field, however, the option is not always available to update
delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
bytes calculated based on the cumulative ACK+SACK information
are assigned to one of the counters using an estimation
heuristic to select the most likely ECN byte counter. Any
estimation error is corrected when the next AccECN option
arrives. It may occur that the heuristic gets too confused
when there are enough different byte counter deltas between
ACKs with the AccECN option in which case the heuristic just
gives up on updating the counters for a while.

tcp_ecn_option sysctl can be used to select option sending
mode for AccECN: TCP_ECN_OPTION_DISABLED, TCP_ECN_OPTION_MINIMUM,
and TCP_ECN_OPTION_FULL.

This patch increases the size of tcp_info struct, as there is
no existing holes for new u32 variables. Below are the pahole
outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_info {
    [...]
     __u32                     tcpi_total_rto_time;  /*   244     4 */

    /* size: 248, cachelines: 4, members: 61 */
}

[AFTER THIS PATCH]
struct tcp_info {
    [...]
    __u32                      tcpi_total_rto_time;  /*   244     4 */
    __u32                      tcpi_received_ce;     /*   248     4 */
    __u32                      tcpi_delivered_e1_bytes; /*   252     4 */
    __u32                      tcpi_delivered_e0_bytes; /*   256     4 */
    __u32                      tcpi_delivered_ce_bytes; /*   260     4 */
    __u32                      tcpi_received_e1_bytes; /*   264     4 */
    __u32                      tcpi_received_e0_bytes; /*   268     4 */
    __u32                      tcpi_received_ce_bytes; /*   272     4 */

    /* size: 280, cachelines: 5, members: 68 */
}

This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
group size of tcp_sock_write_rx is increased from 96 to 112. Below
are the pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u8                         received_ce_pending:4; /*  2586: 0  1 */
    u8                         unused2:4;             /*  2586: 4  1 */
    /* XXX 1 byte hole, try to pack */

    [...]
    u32                        rcv_rtt_last_tsecr;    /*  2732     4 */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];      /*  2792     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 170 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    u8                         accecn_minlen:2;      /*  2587: 0  1 */
    u8                         est_ecnfield:2;       /*  2587: 2  1 */
    u8                         unused3:4;            /*  2587: 4  1 */

    [...]
    u32                        rcv_rtt_last_tsecr;   /*  2732     4 */
    u32                        delivered_ecn_bytes[3];/*  2736    12 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    __cacheline_group_end__tcp_sock_write_rx[0];     /*  2808     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 174 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v10
- Add documentation of tcp_ecn_option in ip-sysctl.rst to this patch
- Remove the global variable u32 synack_ecn_bytes[3]
- Add READ_ONCE() over every reads of sysctl

v9:
- Restruct the code in the for loop of tcp_accecn_process_option()
- Remove ecn_bytes and add use_synack_ecn_bytes flag in tcp_out_options
  struct to identify whether syn_ack_bytes or received_ecn_bytes is used
- Replace leftover_bytes and leftover_size with leftover_highbyte and
  leftover_lowbyte and add comments in tcp_options_write()

v8:
- Reset leftover_size to 2 once leftover_bytes is used
---
 Documentation/networking/ip-sysctl.rst        |  19 ++
 .../networking/net_cachelines/tcp_sock.rst    |   3 +
 include/linux/tcp.h                           |   9 +-
 include/net/netns/ipv4.h                      |   1 +
 include/net/tcp.h                             |  10 ++
 include/net/tcp_ecn.h                         |  84 ++++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/sysctl_net_ipv4.c                    |   9 +
 net/ipv4/tcp.c                                |  15 +-
 net/ipv4/tcp_input.c                          |  93 +++++++++-
 net/ipv4/tcp_ipv4.c                           |   1 +
 net/ipv4/tcp_output.c                         | 166 +++++++++++++++++-
 12 files changed, 404 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index ebd391a1a3af..9b63466bcbf5 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -468,6 +468,25 @@ tcp_ecn - INTEGER
 
 	Default: 2
 
+tcp_ecn_option - INTEGER
+	Control Accurate ECN (AccECN) option sending when AccECN has been
+	successfully negotiated during handshake. Send logic inhibits
+	sending AccECN options regarless of this setting when no AccECN
+	option has been seen for the reverse direction.
+
+	Possible values are:
+
+	= ============================================================
+	0 Never send AccECN option. This also disables sending AccECN
+	  option in SYN/ACK during handshake.
+	1 Send AccECN option sparingly according to the minimum option
+	  rules outlined in draft-ietf-tcpm-accurate-ecn.
+	2 Send AccECN option on every packet whenever it fits into TCP
+	  option space.
+	= ============================================================
+
+	Default: 2
+
 tcp_ecn_fallback - BOOLEAN
 	If the kernel detects that ECN connection misbehaves, enable fall
 	back to non-ECN. Currently, this knob implements the fallback
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 804480d39132..ed6af7d0110c 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -104,9 +104,12 @@ u32                           delivered_ce            read_mostly         read_w
 u32                           received_ce             read_mostly         read_write
 u32[3]                        received_ecn_bytes      read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
+u32[3]                        delivered_ecn_bytes                         read_write
 u8:2                          syn_ect_snt             write_mostly        read_write
 u8:2                          syn_ect_rcv             read_mostly         read_write
 u8:1                          wait_third_ack                              read_write
+u8:2                          accecn_minlen           write_mostly        read_write
+u8:2                          est_ecnfield                                read_write
 u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 0c2331e186e8..0008b8190ea0 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -122,8 +122,9 @@ struct tcp_options_received {
 		smc_ok : 1,	/* SMC seen on SYN packet		*/
 		snd_wscale : 4,	/* Window scaling received from sender	*/
 		rcv_wscale : 4;	/* Window scaling to send to receiver	*/
-	u8	saw_unknown:1,	/* Received unknown option		*/
-		unused:7;
+	u8	accecn:6,	/* AccECN index in header, 0=no options	*/
+		saw_unknown:1,	/* Received unknown option		*/
+		unused:1;
 	u8	num_sacks;	/* Number of SACK blocks		*/
 	u16	user_mss;	/* mss requested by user in ioctl	*/
 	u16	mss_clamp;	/* Maximal mss, negotiated at connection setup */
@@ -293,6 +294,9 @@ struct tcp_sock {
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
 	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
 		unused2:4;
+	u8	accecn_minlen:2,/* Minimum length of AccECN option sent */
+		est_ecnfield:2,/* ECN field for AccECN delivered estimates */
+		unused3:4;
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -337,6 +341,7 @@ struct tcp_sock {
 	u32	rate_delivered;    /* saved rate sample: packets delivered */
 	u32	rate_interval_us;  /* saved rate sample: time elapsed */
 	u32	rcv_rtt_last_tsecr;
+	u32	delivered_ecn_bytes[3];
 	u64	first_tx_mstamp;  /* start of window send phase */
 	u64	delivered_mstamp; /* time we reached "delivered" */
 	u64	bytes_acked;	/* RFC4898 tcpEStatsAppHCThruOctetsAcked
diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
index 6373e3f17da8..4569a9ef4fb8 100644
--- a/include/net/netns/ipv4.h
+++ b/include/net/netns/ipv4.h
@@ -148,6 +148,7 @@ struct netns_ipv4 {
 	struct local_ports ip_local_ports;
 
 	u8 sysctl_tcp_ecn;
+	u8 sysctl_tcp_ecn_option;
 	u8 sysctl_tcp_ecn_fallback;
 
 	u8 sysctl_ip_default_ttl;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 62e3ed0a1954..ff3e774fcf26 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -203,6 +203,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOPT_AO		29	/* Authentication Option (RFC5925) */
 #define TCPOPT_MPTCP		30	/* Multipath TCP (RFC6824) */
 #define TCPOPT_FASTOPEN		34	/* Fast open (RFC7413) */
+#define TCPOPT_ACCECN0		172	/* 0xAC: Accurate ECN Order 0 */
+#define TCPOPT_ACCECN1		174	/* 0xAE: Accurate ECN Order 1 */
 #define TCPOPT_EXP		254	/* Experimental */
 /* Magic number to be after the option value for sharing TCP
  * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
@@ -220,6 +222,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_TIMESTAMP      10
 #define TCPOLEN_MD5SIG         18
 #define TCPOLEN_FASTOPEN_BASE  2
+#define TCPOLEN_ACCECN_BASE    2
 #define TCPOLEN_EXP_FASTOPEN_BASE  4
 #define TCPOLEN_EXP_SMC_BASE   6
 
@@ -233,6 +236,13 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
 #define TCPOLEN_MD5SIG_ALIGNED		20
 #define TCPOLEN_MSS_ALIGNED		4
 #define TCPOLEN_EXP_SMC_BASE_ALIGNED	8
+#define TCPOLEN_ACCECN_PERFIELD		3
+
+/* Maximum number of byte counters in AccECN option + size */
+#define TCP_ACCECN_NUMFIELDS		3
+#define TCP_ACCECN_MAXSIZE		(TCPOLEN_ACCECN_BASE + \
+					 TCPOLEN_ACCECN_PERFIELD * \
+					 TCP_ACCECN_NUMFIELDS)
 
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index 1027edd3c387..bed52eb38faf 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -24,6 +24,13 @@ enum tcp_ecn_mode {
 	TCP_ECN_IN_ACCECN_OUT_NOECN = 5,
 };
 
+/* AccECN option sending when AccECN has been successfully negotiated */
+enum tcp_accecn_option {
+	TCP_ACCECN_OPTION_DISABLED = 0,
+	TCP_ACCECN_OPTION_MINIMUM = 1,
+	TCP_ACCECN_OPTION_FULL = 2,
+};
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -174,6 +181,74 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	}
 }
 
+/* Maps IP ECN field ECT/CE code point to AccECN option field number, given
+ * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
+ */
+static inline u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
+{
+	switch (ecnfield & INET_ECN_MASK) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return 1;
+	case INET_ECN_CE:
+		return 2;
+	case INET_ECN_ECT_0:
+		return 3;
+	}
+	return 0;
+}
+
+/* Maps IP ECN field ECT/CE code point to AccECN option field value offset.
+ * Some fields do not start from zero, to detect zeroing by middleboxes.
+ */
+static inline u32 tcp_accecn_field_init_offset(u8 ecnfield)
+{
+	switch (ecnfield & INET_ECN_MASK) {
+	case INET_ECN_NOT_ECT:
+		return 0;	/* AccECN does not send counts of NOT_ECT */
+	case INET_ECN_ECT_1:
+		return TCP_ACCECN_E1B_INIT_OFFSET;
+	case INET_ECN_CE:
+		return TCP_ACCECN_CEB_INIT_OFFSET;
+	case INET_ECN_ECT_0:
+		return TCP_ACCECN_E0B_INIT_OFFSET;
+	}
+	return 0;
+}
+
+/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
+static inline unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int option,
+							   bool order)
+{
+	u8 tmp;
+
+	option = order ? 2 - option : option;
+	tmp = option + 2;
+
+	return (tmp + (tmp >> 2)) & INET_ECN_MASK;
+}
+
+/* Handles AccECN option ECT and CE 24-bit byte counters update into
+ * the u32 value in tcp_sock. As we're processing TCP options, it is
+ * safe to access from - 1.
+ */
+static inline s32 tcp_update_ecn_bytes(u32 *cnt, const char *from,
+				       u32 init_offset)
+{
+	u32 truncated = (get_unaligned_be32(from - 1) - init_offset) &
+			0xFFFFFFU;
+	u32 delta = (truncated - *cnt) & 0xFFFFFFU;
+
+	/* If delta has the highest bit set (24th bit) indicating
+	 * negative, sign extend to correct an estimation using
+	 * sign_extend32(delta, 24 - 1)
+	 */
+	delta = sign_extend32(delta, 23);
+	*cnt += delta;
+	return (s32)delta;
+}
+
 /* Updates Accurate ECN received counters from the received IP ECN field */
 static inline void tcp_ecn_received_counters(struct sock *sk,
 					     const struct sk_buff *skb, u32 len)
@@ -197,8 +272,12 @@ static inline void tcp_ecn_received_counters(struct sock *sk,
 		tp->received_ce_pending = min(tp->received_ce_pending + pcount,
 					      0xfU);
 
-		if (len > 0)
+		if (len > 0) {
+			u8 minlen = tcp_ecnfield_to_accecn_optfield(ecnfield);
 			tp->received_ecn_bytes[ecnfield - 1] += len;
+			tp->accecn_minlen = max_t(u8, tp->accecn_minlen,
+						  minlen);
+		}
 	}
 }
 
@@ -269,6 +348,9 @@ static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
 	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
 	__tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
+	__tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
+	tp->accecn_minlen = 0;
+	tp->est_ecnfield = 0;
 }
 
 /* Used for make_synack to form the ACE flags */
diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
index bdac8c42fa82..53e0e85b52be 100644
--- a/include/uapi/linux/tcp.h
+++ b/include/uapi/linux/tcp.h
@@ -316,6 +316,13 @@ struct tcp_info {
 					 * in milliseconds, including any
 					 * unfinished recovery.
 					 */
+	__u32	tcpi_received_ce;    /* # of CE marks received */
+	__u32	tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters */
+	__u32	tcpi_delivered_e0_bytes;
+	__u32	tcpi_delivered_ce_bytes;
+	__u32	tcpi_received_e1_bytes;
+	__u32	tcpi_received_e0_bytes;
+	__u32	tcpi_received_ce_bytes;
 };
 
 /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 75ec1a599b52..1d7fd86ca7b9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -731,6 +731,15 @@ static struct ctl_table ipv4_net_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= &tcp_ecn_mode_max,
 	},
+	{
+		.procname	= "tcp_ecn_option",
+		.data		= &init_net.ipv4.sysctl_tcp_ecn_option,
+		.maxlen		= sizeof(u8),
+		.mode		= 0644,
+		.proc_handler	= proc_dou8vec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_TWO,
+	},
 	{
 		.procname	= "tcp_ecn_fallback",
 		.data		= &init_net.ipv4.sysctl_tcp_ecn_fallback,
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 8b767f6f9524..3bf9248f5e11 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -270,6 +270,7 @@
 
 #include <net/icmp.h>
 #include <net/inet_common.h>
+#include <net/inet_ecn.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
 #include <net/mptcp.h>
@@ -4139,6 +4140,9 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 {
 	const struct tcp_sock *tp = tcp_sk(sk); /* iff sk_type == SOCK_STREAM */
 	const struct inet_connection_sock *icsk = inet_csk(sk);
+	const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+	const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+	const u8 ce_idx = INET_ECN_CE - 1;
 	unsigned long rate;
 	u32 now;
 	u64 rate64;
@@ -4265,6 +4269,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info *info)
 	if (tp->rto_stamp)
 		info->tcpi_total_rto_time += tcp_clock_ms() - tp->rto_stamp;
 
+	info->tcpi_received_ce = tp->received_ce;
+	info->tcpi_delivered_e1_bytes = tp->delivered_ecn_bytes[ect1_idx];
+	info->tcpi_delivered_e0_bytes = tp->delivered_ecn_bytes[ect0_idx];
+	info->tcpi_delivered_ce_bytes = tp->delivered_ecn_bytes[ce_idx];
+	info->tcpi_received_e1_bytes = tp->received_ecn_bytes[ect1_idx];
+	info->tcpi_received_e0_bytes = tp->received_ecn_bytes[ect0_idx];
+	info->tcpi_received_ce_bytes = tp->received_ecn_bytes[ce_idx];
+
 	unlock_sock_fast(sk, slow);
 }
 EXPORT_SYMBOL_GPL(tcp_get_info);
@@ -5143,12 +5155,13 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rate_interval_us);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_last_tsecr);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_ecn_bytes);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, first_tx_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, delivered_mstamp);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_acked);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcv_rtt_est);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, rcvq_space);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 96);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 112);
 }
 
 void __init tcp_init(void)
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f7d7649612a2..107c20ae0f5b 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -70,6 +70,7 @@
 #include <linux/sysctl.h>
 #include <linux/kernel.h>
 #include <linux/prefetch.h>
+#include <linux/bitops.h>
 #include <net/dst.h>
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
@@ -384,6 +385,72 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 	}
 }
 
+/* Returns true if the byte counters can be used */
+static bool tcp_accecn_process_option(struct tcp_sock *tp,
+				      const struct sk_buff *skb,
+				      u32 delivered_bytes, int flag)
+{
+	u8 estimate_ecnfield = tp->est_ecnfield;
+	bool ambiguous_ecn_bytes_incr = false;
+	bool first_changed = false;
+	unsigned int optlen;
+	bool order1, res;
+	unsigned int i;
+	u8 *ptr;
+
+	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (estimate_ecnfield) {
+			u8 ecnfield = estimate_ecnfield - 1;
+
+			tp->delivered_ecn_bytes[ecnfield] += delivered_bytes;
+			return true;
+		}
+		return false;
+	}
+
+	ptr = skb_transport_header(skb) + tp->rx_opt.accecn;
+	optlen = ptr[1] - 2;
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	order1 = (ptr[0] == TCPOPT_ACCECN1);
+	ptr += 2;
+
+	res = !!estimate_ecnfield;
+	for (i = 0; i < 3; i++) {
+		u32 init_offset;
+		u8 ecnfield;
+		s32 delta;
+		u32 *cnt;
+
+		if (optlen < TCPOLEN_ACCECN_PERFIELD)
+			break;
+
+		ecnfield = tcp_accecn_optfield_to_ecnfield(i, order1);
+		init_offset = tcp_accecn_field_init_offset(ecnfield);
+		cnt = &tp->delivered_ecn_bytes[ecnfield - 1];
+		delta = tcp_update_ecn_bytes(cnt, ptr, init_offset);
+		if (delta && delta < 0) {
+			res = false;
+			ambiguous_ecn_bytes_incr = true;
+		}
+		if (delta && ecnfield != estimate_ecnfield) {
+			if (!first_changed) {
+				tp->est_ecnfield = ecnfield;
+				first_changed = true;
+			} else {
+				res = false;
+				ambiguous_ecn_bytes_incr = true;
+			}
+		}
+
+		optlen -= TCPOLEN_ACCECN_PERFIELD;
+		ptr += TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (ambiguous_ecn_bytes_incr)
+		tp->est_ecnfield = 0;
+
+	return res;
+}
+
 static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
 {
 	tp->delivered_ce += ecn_count;
@@ -400,7 +467,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
 
 /* Returns the ECN CE delta */
 static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-				u32 delivered_pkts, int flag)
+				u32 delivered_pkts, u32 delivered_bytes,
+				int flag)
 {
 	const struct tcphdr *th = tcp_hdr(skb);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -411,6 +479,8 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 	if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
 		return 0;
 
+	tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
+
 	if (!(flag & FLAG_SLOWPATH)) {
 		/* AccECN counter might overflow on large ACKs */
 		if (delivered_pkts <= TCP_ACCECN_CEP_ACE_MASK)
@@ -436,12 +506,14 @@ static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
 }
 
 static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb,
-			      u32 delivered_pkts, int *flag)
+			      u32 delivered_pkts, u32 delivered_bytes,
+			      int *flag)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u32 delta;
 
-	delta = __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
+	delta = __tcp_accecn_process(sk, skb, delivered_pkts,
+				     delivered_bytes, *flag);
 	if (delta > 0) {
 		tcp_count_delivered_ce(tp, delta);
 		*flag |= FLAG_ECE;
@@ -3973,6 +4045,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 
 	tcp_in_ack_event(sk, flag);
@@ -4012,6 +4085,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if (tcp_ecn_mode_accecn(tp))
 		ecn_count = tcp_accecn_process(sk, skb,
 					       tp->delivered - delivered,
+					       sack_state.delivered_bytes,
 					       &flag);
 	tcp_in_ack_event(sk, flag);
 	/* If data was DSACKed, see if we can undo a cwnd reduction. */
@@ -4139,6 +4213,7 @@ void tcp_parse_options(const struct net *net,
 
 	ptr = (const unsigned char *)(th + 1);
 	opt_rx->saw_tstamp = 0;
+	opt_rx->accecn = 0;
 	opt_rx->saw_unknown = 0;
 
 	while (length > 0) {
@@ -4230,6 +4305,12 @@ void tcp_parse_options(const struct net *net,
 					ptr, th->syn, foc, false);
 				break;
 
+			case TCPOPT_ACCECN0:
+			case TCPOPT_ACCECN1:
+				/* Save offset of AccECN option in TCP header */
+				opt_rx->accecn = (ptr - 2) - (__u8 *)th;
+				break;
+
 			case TCPOPT_EXP:
 				/* Fast Open option shares code 254 using a
 				 * 16 bits magic number.
@@ -4290,11 +4371,14 @@ static bool tcp_fast_parse_options(const struct net *net,
 	 */
 	if (th->doff == (sizeof(*th) / 4)) {
 		tp->rx_opt.saw_tstamp = 0;
+		tp->rx_opt.accecn = 0;
 		return false;
 	} else if (tp->rx_opt.tstamp_ok &&
 		   th->doff == ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED) / 4)) {
-		if (tcp_parse_aligned_timestamp(tp, th))
+		if (tcp_parse_aligned_timestamp(tp, th)) {
+			tp->rx_opt.accecn = 0;
 			return true;
+		}
 	}
 
 	tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
@@ -6094,6 +6178,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 	 */
 
 	tp->rx_opt.saw_tstamp = 0;
+	tp->rx_opt.accecn = 0;
 
 	/*	pred_flags is 0xS?10 << 16 + snd_wnd
 	 *	if header_prediction is to be made
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 861dfe3ddab8..a6ae6f261ce8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3450,6 +3450,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 static int __net_init tcp_sk_init(struct net *net)
 {
 	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
+	net->ipv4.sysctl_tcp_ecn_option = TCP_ACCECN_OPTION_FULL;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d98a1a17eb52..2169fd28594e 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -385,6 +385,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock *tp)
 #define OPTION_SMC		BIT(9)
 #define OPTION_MPTCP		BIT(10)
 #define OPTION_AO		BIT(11)
+#define OPTION_ACCECN		BIT(12)
 
 static void smc_options_write(__be32 *ptr, u16 *options)
 {
@@ -406,6 +407,8 @@ struct tcp_out_options {
 	u16 mss;		/* 0 to disable */
 	u8 ws;			/* window scale, 0 to disable */
 	u8 num_sack_blocks;	/* number of SACK blocks to include */
+	u8 num_accecn_fields:7,	/* number of AccECN fields needed */
+	   use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
 	u8 hash_size;		/* bytes in hash_location */
 	u8 bpf_opt_len;		/* length of BPF hdr option */
 	__u8 *hash_location;	/* temporary pointer, overloaded */
@@ -621,6 +624,8 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			      struct tcp_out_options *opts,
 			      struct tcp_key *key)
 {
+	u8 leftover_highbyte = TCPOPT_NOP; /* replace 1st NOP if avail */
+	u8 leftover_lowbyte = TCPOPT_NOP;  /* replace 2nd NOP in succession */
 	__be32 *ptr = (__be32 *)(th + 1);
 	u16 options = opts->options;	/* mungable copy */
 
@@ -656,15 +661,79 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		*ptr++ = htonl(opts->tsecr);
 	}
 
+	if (OPTION_ACCECN & options) {
+		/* Initial values for AccECN option, ordered is based on ECN field bits
+		 * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
+		 */
+		static u32 synack_ecn_bytes[3] = { 0, 0, 0 };
+		const u8 ect0_idx = INET_ECN_ECT_0 - 1;
+		const u8 ect1_idx = INET_ECN_ECT_1 - 1;
+		const u8 ce_idx = INET_ECN_CE - 1;
+		u32 e0b;
+		u32 e1b;
+		u32 ceb;
+		u8 len;
+
+		if (opts->use_synack_ecn_bytes) {
+			e0b = synack_ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
+			e1b = synack_ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
+			ceb = synack_ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
+		} else {
+			e0b = tp->received_ecn_bytes[ect0_idx] + TCP_ACCECN_E0B_INIT_OFFSET;
+			e1b = tp->received_ecn_bytes[ect1_idx] + TCP_ACCECN_E1B_INIT_OFFSET;
+			ceb = tp->received_ecn_bytes[ce_idx] + TCP_ACCECN_CEB_INIT_OFFSET;
+		}
+
+		len = TCPOLEN_ACCECN_BASE +
+		      opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
+
+		if (opts->num_accecn_fields == 2) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+		} else if (opts->num_accecn_fields == 1) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			leftover_highbyte = e1b & 0xff;
+			leftover_lowbyte = TCPOPT_NOP;
+		} else if (opts->num_accecn_fields == 0) {
+			leftover_highbyte = TCPOPT_ACCECN1;
+			leftover_lowbyte = len;
+		} else if (opts->num_accecn_fields == 3) {
+			*ptr++ = htonl((TCPOPT_ACCECN1 << 24) | (len << 16) |
+				       ((e1b >> 8) & 0xffff));
+			*ptr++ = htonl(((e1b & 0xff) << 24) |
+				       (ceb & 0xffffff));
+			*ptr++ = htonl(((e0b & 0xffffff) << 8) |
+				       TCPOPT_NOP);
+		}
+		if (tp)
+			tp->accecn_minlen = 0;
+	}
+
 	if (unlikely(OPTION_SACK_ADVERTISE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
-			       (TCPOPT_NOP << 16) |
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
 			       (TCPOPT_SACK_PERM << 8) |
 			       TCPOLEN_SACK_PERM);
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 	}
 
 	if (unlikely(OPTION_WSCALE & options)) {
-		*ptr++ = htonl((TCPOPT_NOP << 24) |
+		u8 highbyte = TCPOPT_NOP;
+
+		/* Do not split the leftover 2-byte to fit into a single
+		 * NOP, i.e., replace this NOP only when 1 byte is leftover
+		 * within leftover_highbyte.
+		 */
+		if (unlikely(leftover_highbyte != TCPOPT_NOP &&
+			     leftover_lowbyte == TCPOPT_NOP)) {
+			highbyte = leftover_highbyte;
+			leftover_highbyte = TCPOPT_NOP;
+		}
+		*ptr++ = htonl((highbyte << 24) |
 			       (TCPOPT_WINDOW << 16) |
 			       (TCPOLEN_WINDOW << 8) |
 			       opts->ws);
@@ -675,11 +744,13 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 			tp->duplicate_sack : tp->selective_acks;
 		int this_sack;
 
-		*ptr++ = htonl((TCPOPT_NOP  << 24) |
-			       (TCPOPT_NOP  << 16) |
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
 			       (TCPOPT_SACK <<  8) |
 			       (TCPOLEN_SACK_BASE + (opts->num_sack_blocks *
 						     TCPOLEN_SACK_PERBLOCK)));
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 
 		for (this_sack = 0; this_sack < opts->num_sack_blocks;
 		     ++this_sack) {
@@ -688,6 +759,14 @@ static void tcp_options_write(struct tcphdr *th, struct tcp_sock *tp,
 		}
 
 		tp->rx_opt.dsack = 0;
+	} else if (unlikely(leftover_highbyte != TCPOPT_NOP ||
+			    leftover_lowbyte != TCPOPT_NOP)) {
+		*ptr++ = htonl((leftover_highbyte << 24) |
+			       (leftover_lowbyte << 16) |
+			       (TCPOPT_NOP << 8) |
+			       TCPOPT_NOP);
+		leftover_highbyte = TCPOPT_NOP;
+		leftover_lowbyte = TCPOPT_NOP;
 	}
 
 	if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
@@ -768,6 +847,59 @@ static void mptcp_set_option_cond(const struct request_sock *req,
 	}
 }
 
+static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opts)
+{
+	/* How much there's room for combining with the alignment padding? */
+	if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) ==
+	    OPTION_SACK_ADVERTISE)
+		return 2;
+	else if (opts->options & OPTION_WSCALE)
+		return 1;
+	return 0;
+}
+
+/* Calculates how long AccECN option will fit to @remaining option space.
+ *
+ * AccECN option can sometimes replace NOPs used for alignment of other
+ * TCP options (up to @max_combine_saving available).
+ *
+ * Only solutions with at least @required AccECN fields are accepted.
+ *
+ * Returns: The size of the AccECN option excluding space repurposed from
+ * the alignment of the other options.
+ */
+static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
+				  int remaining)
+{
+	int size = TCP_ACCECN_MAXSIZE;
+	int max_combine_saving;
+
+	if (opts->use_synack_ecn_bytes)
+		max_combine_saving = tcp_synack_options_combine_saving(opts);
+	else
+		max_combine_saving = opts->num_sack_blocks > 0 ? 2 : 0;
+	opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+	while (opts->num_accecn_fields >= required) {
+		int leftover_size = size & 0x3;
+		/* Pad to dword if cannot combine */
+		if (leftover_size > max_combine_saving)
+			leftover_size = -((4 - leftover_size) & 0x3);
+
+		if (remaining >= size - leftover_size) {
+			size -= leftover_size;
+			break;
+		}
+
+		opts->num_accecn_fields--;
+		size -= TCPOLEN_ACCECN_PERFIELD;
+	}
+	if (opts->num_accecn_fields < required)
+		return 0;
+
+	opts->options |= OPTION_ACCECN;
+	return size;
+}
+
 /* Compute TCP options for SYN packets. This is not the final
  * network wire format yet.
  */
@@ -850,6 +982,15 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		}
 	}
 
+	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
+	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
+		     tcp_ecn_mode_accecn(tp) &&
+		     READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+		     remaining >= TCPOLEN_ACCECN_BASE)) {
+		opts->use_synack_ecn_bytes = 1;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
+	}
+
 	bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
 
 	return MAX_TCP_OPTION_SPACE - remaining;
@@ -867,6 +1008,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 {
 	struct inet_request_sock *ireq = inet_rsk(req);
 	unsigned int remaining = MAX_TCP_OPTION_SPACE;
+	struct tcp_request_sock *treq = tcp_rsk(req);
 
 	if (tcp_key_is_md5(key)) {
 		opts->options |= OPTION_MD5;
@@ -929,6 +1071,13 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
+	if (treq->accecn_ok &&
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option) &&
+	    remaining >= TCPOLEN_ACCECN_BASE) {
+		opts->use_synack_ecn_bytes = 1;
+		remaining -= tcp_options_fit_accecn(opts, 0, remaining);
+	}
+
 	bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
 			      synack_type, opts, &remaining);
 
@@ -1001,6 +1150,13 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		opts->num_sack_blocks = 0;
 	}
 
+	if (tcp_ecn_mode_accecn(tp) &&
+	    READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option)) {
+		opts->use_synack_ecn_bytes = 0;
+		size += tcp_options_fit_accecn(opts, tp->accecn_minlen,
+					       MAX_TCP_OPTION_SPACE - size);
+	}
+
 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
 					    BPF_SOCK_OPS_WRITE_HDR_OPT_CB_FLAG))) {
 		unsigned int remaining = MAX_TCP_OPTION_SPACE - size;
-- 
2.34.1


