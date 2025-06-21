Return-Path: <linux-kselftest+bounces-35555-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C32A9AE2B9F
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B671189884B
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C24270EA5;
	Sat, 21 Jun 2025 19:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iJBhkXnn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9E726F463;
	Sat, 21 Jun 2025 19:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534679; cv=fail; b=MruGH4XQr4jn5Ae4Lh1U8qQJdyWgmAga96MUcY+rd7B9cAHFBpUr6j/q+FwCkcwHj+uQVtMt14k09BcMvFYl4Ho015c2K/XHKLXgN8ZpqftpIbGufm7ik08rqstsWJZ6rHtwrTrCbQvX9qgYVWUlSV4YHPTXo/rhf/M0g6lmr/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534679; c=relaxed/simple;
	bh=BsDwe9MN9EhKNmauP0xy5BZhVt8S6cdTXLndNNId6sg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iply4OhTs6l15mlQZjbtL+TgZfhj0dQ9OBgjXiaHH31OgXNYBxV7eO5+DjmvmLojqwepEG+f01RwoT+zvUh9ORbRbbrSk2I9henkbuxAy7gFo8sYPF+Vs7pnBxPIQs7ft/7plC3SOmhhMPWpS9Wom7PySYzeHyAJdcrcUIcgyI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iJBhkXnn; arc=fail smtp.client-ip=52.101.66.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vcqQBdnILuEr/ZseF64ky4bZ2oSsE9HpChWVmAd+rNuHdVBMj+xm37GtCLprZELjjyUFokDFoJAmphLYXO7MkY8sjrEDMQTou8LWJgxfDOVrfNPjEdAsLqTKJAfyT7CLIyhDC8rwrJFCOLFRdZc5KgguX4YI9B/Ocrf1dgC/hQIUkf+HFRH+Ljwbo1fMOjaVssu/fYSFv7bPqS+HjVjMeSbRqTTBheQ2EawpuoPmvWSYRo8ZG5ARecs35b2fgEGxHxBDwTt3/cBnUnkJbRZnFBIBOxJOgsUGn4ATt+pYzS/CcBn6qEgT4fkKKXn0Slb+PVQGRWKlMXwe4WKV8QEHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP/+0hgbTOeuimz95knht2mhD+W1Ii3B7b9fato1e/U=;
 b=kbtemn+UAIdo1HNplKtBHK+Av/dcHek3YwoJ7clhJymHB4gqU+xOWiCiwY8Nh7trVduLo1voIR6pzIu7SMcA9BEn1nSN7kCWAO1s7XX0EM68sqDm7l3S5nZToVu6vPHKuIAAVJev3zIYZMz6rG9+bemKLzQdhqGnQF7XeU1kccFeQ9aMWkGwv1Yu32UoXuFmgY1T5ybWZBKY5N0L9/MxJdy9vumuIjFIedWIrdmEpOh/8wIPLIJ3saQXjNfDHHPYUhqGSdXz0Td2hF1hiooz6ysJXIdS/M+SI2t/ECIZAvkf9Ig7G+xbAiTT4WP0tBAsRCCaDZmsOUkvxKjBsKwAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP/+0hgbTOeuimz95knht2mhD+W1Ii3B7b9fato1e/U=;
 b=iJBhkXnnN7Ne4N6kWySlCyGuBt6k6pgDmQHskt/ofn9WgSbirw4WaN9LdXDmDW6PWrq5p+eaqoSYBJppCwHWXVRl4uH0bqSp21SesSADb3sMRrkFuQM6o7TxCmTu0XE06bVPnU6aPeiMNQKrb5KhS4v51wvIjez71hXqt+F7PDv2FTs6APFUm7UOrRau8ZmaY5bgC5fwLJh4edsuG/SFKKGURe7qMbyMoZ2m/q4STDqNqxjricFkMaZcY+DST9U5E+ldRgAB9mO4Sn9iJrVQ0Jvi0eMLpOnIfRPkaW6Wr1f0j30l73e00pxffSqjou02Nygf4T0tKA5fykAyQ16pmQ==
Received: from DU6P191CA0056.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::17)
 by AM9PR07MB7106.eurprd07.prod.outlook.com (2603:10a6:20b:2cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sat, 21 Jun
 2025 19:37:51 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::a4) by DU6P191CA0056.outlook.office365.com
 (2603:10a6:10:53e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:50 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 332EA1C0031;
	Sat, 21 Jun 2025 22:37:49 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v9 net-next 04/15] tcp: AccECN core
Date: Sat, 21 Jun 2025 21:37:26 +0200
Message-Id: <20250621193737.16593-5-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|AM9PR07MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2fc577-4afc-448e-b700-08ddb0fb1c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014|30052699003|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWhCT1JTSzdOZEFuZk9pQmNlZFd3aTdXTnc4Q0dIYjRpOXdyVjBSR1FrNDVr?=
 =?utf-8?B?dXFScmdibURWVUFaZXpLeWk0Q0pZVDJWR2hFdGJ2bjcyRU16b0ROWHZZcm5x?=
 =?utf-8?B?cW5oeEY1Nlk3SDZyYk5YQjE3R0FYYTdBa0puQ1RjNHcweUl2ZUlzS2lsVmdk?=
 =?utf-8?B?T0JXV1ZvS1dST2QzUVc2OXp6VjIwWlJpYkw3cklHc2RPUGdaajVBWUxUSlR6?=
 =?utf-8?B?L21mUUprN0ttU21qYk1iSTd2MzczdS9wVzVuViszZnZYa0FXd1IvNU1laFZ6?=
 =?utf-8?B?Vmg1L3VxSlZ2R3lSSjE4cytZS09XcHVuam05VWtzekxCM1hzNW91a2cyN2NX?=
 =?utf-8?B?R0drMXJGakxlS1FYSXFRZld5TTdJcVkveXlyRlZnUlNYcHFKVFE1ZjhkZm1j?=
 =?utf-8?B?SGRKbjBPSnB0YkVGSGxzYmhGK1BjNXlPdldzUGNvUUFKczFnWnNxM1A5OEdw?=
 =?utf-8?B?dkFMZnBla2ZOUzg4bTlUTTdMdnNjU3lUc3A4V2U5MUczNDBFeHduM2NWajhW?=
 =?utf-8?B?cy80NlhrMHBweWNaY0J2VUF5UDhvY3V3ZFBvVkx0QkFPR2VtYU83d1Z5OGZL?=
 =?utf-8?B?SHhMVjZWTEVrV0FwZDRtNCtXNkZBUXJhMUQzQVYxZGp3SHZTRWlQamgxS2hF?=
 =?utf-8?B?STUwTERETG5YUUw1Ykp4RVRKMDhuZGFlLzQvV3VuS3pBSnljc3RJTUhKTlZW?=
 =?utf-8?B?RFpPTm52V2ZaZVpOQjdCTGFjSnh6RnIrYnNmalM5aHNmS0NyWGtoUXNIRTVp?=
 =?utf-8?B?Ky9pUkNVTy9KVFhiVDZCRnQ2Ti9ucm1LamkxT2JJajQrVVZBY3d5c2JlRXFm?=
 =?utf-8?B?QmRBQXRQMWlpNnpkOXpZR3B1dVBGMGlRMDVDUmJhQ2RTdmM3L1Z4TDFnQm5Z?=
 =?utf-8?B?RGgzbTFCd05tTlJpTmZpTEltaWRWTHAxYnMyNlBmOWZDMVRKYVpJdWZsRHF0?=
 =?utf-8?B?MGVMKzEreWt6QWtsb3ZqdUVTQURRY0t3Z3EyRUlsbWt6ODRidXhteXp5OURW?=
 =?utf-8?B?U2NQRDdPZmh2V05YWW53M3F6clJiUExwWFowZmJNV1hnVDhvWjZQZmYyRk0v?=
 =?utf-8?B?d1o5S25MYzUxMnVManNrcGE4NW9MWlNrVExld2tHdGZGdDVzZUFEd1FIMysw?=
 =?utf-8?B?bmkrMjlKSWpPTzB1d09OcXNiU01HWHB5T3o1NnNoT2pOY0xFNXZQajhPQWdS?=
 =?utf-8?B?YWU2V1ZMb1B0UWpIeGlMY21KSzlxUjdNZS9Vb1BVUE1KbGV4RlZXclhjZnZZ?=
 =?utf-8?B?RkRyajgySTJWZ1k2SXNjWUFaUHlHcEdrNXFveGYxSEhNelVpRzhxQmF4Z25B?=
 =?utf-8?B?c2ZVQWlXL3FBQkRQOHhVNWhEblhPSENEWHgrWmJ4NHVEUDZQZGIzdFJ6T25G?=
 =?utf-8?B?VFlya0VGTjBBajJ5cGc2RitmaGlrN3piZGZUSmRqbGltRjh3OXQ2Q043ZVJL?=
 =?utf-8?B?YUI0ejBvS0VPdzk0cFNTT3RQMS9wRjkvS2grb0UrOVI3RWgvZ1E3QUxIQWlF?=
 =?utf-8?B?YWRHQm5NZGR2bU1iTkRFeCs4SXRjaEJ1dzZaamJHcTQ0eExrNGg1VytZZUxP?=
 =?utf-8?B?YmZETkJ0aVFBYVluaWlMa292RlliSXJSME95clY3R25sQlNkS1hHL2Vac2JK?=
 =?utf-8?B?RW8rNTBDRjZRK1dlRnJTK1NER0lnczM0UzU0S1pFR3dVVTFwVllPWGFXenAv?=
 =?utf-8?B?NjlPVVlJRmQ5VS9PVWtKa1g5ajEzdElmZHV1Y0M0V0lJVi80WFpjMmFrTUNw?=
 =?utf-8?B?RlEyeHZhYW4rc2VnS2NYRmFPdVBVSVp2YmJXUzBDQjlVQ0hhVXlTRnlpSE1C?=
 =?utf-8?B?aFUraW0rVUF5SWs3K1hXcnVxdXBkOU1aSEdEdzBCMS9ickgrOE1rczhaVWxu?=
 =?utf-8?B?MU1HZ1pscUR1bFFsZHd1cXhWN1JZZm5zdjZBaGx6eWxUSXNYdXJpVlNzbGh6?=
 =?utf-8?B?dWh3Z1kzS012QnJUTjBjZzMzTEYrVHJxRE5nem5DNUdEcS9UVkV2TGhXak10?=
 =?utf-8?B?QSsyczV0MVdISVlUbnVjbUx4dTVmNkYzaVB0UjFtUTNNb2kyTHFxRU1OTnVh?=
 =?utf-8?B?aWx0aHRFY041eTJTNWlHdHFTa1VQNDJCMXVzUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014)(30052699003)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:50.7903
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2fc577-4afc-448e-b700-08ddb0fb1c0d
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7106

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

This patch uses the first 1-byte hole and the last 4-byte hole of
the tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
Also, the group size of tcp_sock_write_txrx is increased from
91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are
the trimmed pahole outcomes before and after this patch.

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */
    /* XXX 2 bytes hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        app_limited;          /*  2644     4 */
    u32                        rcv_wnd;              /*  2648     4 */
    struct tcp_options_received rx_opt;              /*  2652    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2676     0 */
    /* XXX 4 bytes hole, try to pack */

    [...]
    /* size: 3264, cachelines: 51, members: 163 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    __cacheline_group_begin__tcp_sock_write_txrx[0]; /*  2585     0 */
    u8                         nonagle:4;            /*  2585: 0  1 */
    u8                         rate_app_limited:1;   /*  2585: 4  1 */
    /* XXX 3 bits hole, try to pack */

    /* Force alignment to the next boundary: */
    u8                         :0;
    u8                         received_ce_pending:4;/*  2586: 0  1 */
    u8                         unused2:4;            /*  2586: 4  1 */
    /* XXX 1 byte hole, try to pack */

    [...]
    u32                        delivered_ce;         /*  2640     4 */
    u32                        received_ce;          /*  2644     4 */
    u32                        app_limited;          /*  2648     4 */
    u32                        rcv_wnd;              /*  2652     4 */
    struct tcp_options_received rx_opt;              /*  2656    24 */
    __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */

    [...]
    /* size: 3264, cachelines: 51, members: 166 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

---
v9:
- Use tcp_data_ecn_check() to set TCP_ECN_SEE flag only for RFC3168 ECN
- Add comments about setting TCP_ECN_SEEN flag for RFC3168 and Accruate ECN
---
 .../networking/net_cachelines/tcp_sock.rst    |   2 +
 include/linux/tcp.h                           |   3 +
 include/net/tcp.h                             |  26 ++++
 net/ipv4/tcp.c                                |   4 +-
 net/ipv4/tcp_input.c                          | 132 ++++++++++++++++--
 net/ipv4/tcp_output.c                         |  20 ++-
 6 files changed, 175 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 7bbda5944ee2..31313a9adccc 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -101,6 +101,8 @@ u32                           prr_delivered
 u32                           prr_out                 read_mostly         read_mostly         tcp_rate_skb_sent,tcp_newly_delivered(tx);tcp_ack,tcp_rate_gen,tcp_clean_rtx_queue(rx)
 u32                           delivered               read_mostly         read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, tcp_rate_gen, tcp_clean_rtx_queue (rx)
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
+u32                           received_ce             read_mostly         read_write
+u8:4                          received_ce_pending     read_mostly         read_write
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index bd692764d039..874e0e45dfad 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -287,6 +287,8 @@ struct tcp_sock {
  */
 	u8	nonagle     : 4,/* Disable Nagle algorithm?             */
 		rate_app_limited:1;  /* rate_{delivered,interval_us} limited? */
+	u8	received_ce_pending:4, /* Not yet transmit cnt of received_ce */
+		unused2:4;
 	__be32	pred_flags;
 	u64	tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_mstamp_refresh()) */
 	u64	tcp_mstamp;	/* most recent packet received/sent */
@@ -299,6 +301,7 @@ struct tcp_sock {
 	u32	snd_up;		/* Urgent pointer		*/
 	u32	delivered;	/* Total data packets delivered incl. rexmits */
 	u32	delivered_ce;	/* Like the above but only ECE marked packets */
+	u32	received_ce;	/* Like the above but for rcvd CE marked pkts */
 	u32	app_limited;	/* limited until "delivered" reaches this val */
 	u32	rcv_wnd;	/* Current receiver window		*/
 /*
diff --git a/include/net/tcp.h b/include/net/tcp.h
index ed01ae4be7a9..6cf5cea992e3 100644
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
index 18b6cb7dc02e..8e0e8d784b1c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3392,6 +3392,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -5118,6 +5119,7 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, snd_up);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, delivered_ce);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, received_ce);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, app_limited);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rcv_wnd);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txrx, rx_opt);
@@ -5125,7 +5127,7 @@ static void __init tcp_struct_check(void)
 	/* 32bit arches with 8byte alignment on u64 fields might need padding
 	 * before tcp_clock_cache.
 	 */
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 91 + 4);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 95 + 4);
 
 	/* RX read-write hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx, bytes_received);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 19a1542883df..0fa3803b353d 100644
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
@@ -384,16 +387,25 @@ static void tcp_data_ecn_check(struct sock *sk, const struct sk_buff *skb)
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
 
-		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
+		if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
+		    tcp_ecn_mode_rfc3168(tp)) {
 			/* Better not delay acks, sender can have a very low cwnd */
 			tcp_enter_quickack_mode(sk, 2);
 			tp->ecn_flags |= TCP_ECN_DEMAND_CWR;
 		}
+		/* As for RFC3168 ECN, the TCP_ECN_SEEN flag is set by
+		 * tcp_data_ecn_check() when the ECN codepoint of
+		 * received TCP data contains ECT(0), ECT(1), or CE.
+		 */
+		if (!tcp_ecn_mode_rfc3168(tp))
+			break;
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	default:
 		if (tcp_ca_needs_ecn(sk))
 			tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
+		if (!tcp_ecn_mode_rfc3168(tp))
+			break;
 		tp->ecn_flags |= TCP_ECN_SEEN;
 		break;
 	}
@@ -428,10 +440,64 @@ static void tcp_count_delivered(struct tcp_sock *tp, u32 delivered,
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
@@ -3787,7 +3853,8 @@ static void tcp_xmit_recovery(struct sock *sk, int rexmit)
 }
 
 /* Returns the number of packets newly acked or sacked by the current ACK */
-static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
+static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered,
+			       u32 ecn_count, int flag)
 {
 	const struct net *net = sock_net(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
@@ -3795,8 +3862,12 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
 
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
@@ -3817,6 +3888,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	u32 delivered = tp->delivered;
 	u32 lost = tp->lost;
 	int rexmit = REXMIT_NONE; /* Flag to (re)transmit to recover losses */
+	u32 ecn_count = 0;	  /* Did we receive ECE/an AccECN ACE update? */
 	u32 prior_fack;
 
 	sack_state.first_sackt = 0;
@@ -3924,6 +3996,11 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 
 	tcp_rack_update_reo_wnd(sk, &rs);
 
+	if (tcp_ecn_mode_accecn(tp))
+		ecn_count = tcp_accecn_process(sk, skb,
+					       tp->delivered - delivered,
+					       &flag);
+
 	tcp_in_ack_event(sk, flag);
 
 	if (tp->tlp_high_seq)
@@ -3948,7 +4025,8 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 	if ((flag & FLAG_FORWARD_PROGRESS) || !(flag & FLAG_NOT_DUP))
 		sk_dst_confirm(sk);
 
-	delivered = tcp_newly_delivered(sk, delivered, flag);
+	delivered = tcp_newly_delivered(sk, delivered, ecn_count, flag);
+
 	lost = tp->lost - lost;			/* freshly marked lost */
 	rs.is_ack_delayed = !!(flag & FLAG_ACK_MAYBE_DELAYED);
 	tcp_rate_gen(sk, delivered, lost, is_sack_reneg, sack_state.rate);
@@ -3957,12 +4035,16 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
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
@@ -3983,7 +4065,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 						&sack_state);
 		tcp_fastretrans_alert(sk, prior_snd_una, num_dupack, &flag,
 				      &rexmit);
-		tcp_newly_delivered(sk, delivered, flag);
+		tcp_newly_delivered(sk, delivered, ecn_count, flag);
 		tcp_xmit_recovery(sk, rexmit);
 	}
 
@@ -5821,6 +5903,31 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
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
+		/* As for accurate ECN, the TCP_ECN_SEEN flag is set by
+		 * tcp_ecn_received_counters() when the ECN codepoint of
+		 * received TCP data or ACK contains ECT(0), ECT(1), or CE.
+		 */
+		if (!tcp_ecn_mode_rfc3168(tp))
+			tp->ecn_flags |= TCP_ECN_SEEN;
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
@@ -6083,6 +6190,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 					flag |= __tcp_replace_ts_recent(tp,
 									delta);
 
+				tcp_ecn_received_counters(sk, skb);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -6127,6 +6236,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 			/* Bulk data transfer: receiver */
 			tcp_cleanup_skb(skb);
 			__skb_pull(skb, tcp_header_len);
+			tcp_ecn_received_counters(sk, skb);
 			eaten = tcp_queue_rcv(sk, skb, &fragstolen);
 
 			tcp_event_data_recv(sk, skb);
@@ -6167,6 +6277,8 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 		return;
 
 step5:
+	tcp_ecn_received_counters(sk, skb);
+
 	reason = tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT);
 	if ((int)reason < 0) {
 		reason = -reason;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 974e4062be88..4b32aa619594 100644
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
@@ -382,7 +393,14 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 
-	if (tcp_ecn_mode_rfc3168(tp)) {
+	if (!tcp_ecn_mode_any(tp))
+		return;
+
+	if (tcp_ecn_mode_accecn(tp)) {
+		INET_ECN_xmit(sk);
+		tcp_accecn_set_ace(th, tp);
+		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
+	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
 		if (skb->len != tcp_header_len &&
 		    !before(TCP_SKB_CB(skb)->seq, tp->snd_nxt)) {
-- 
2.34.1


