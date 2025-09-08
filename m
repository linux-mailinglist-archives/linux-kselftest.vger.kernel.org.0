Return-Path: <linux-kselftest+bounces-40966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D239B496FD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228B03B3F73
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8690313546;
	Mon,  8 Sep 2025 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WaRa3f0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6F31062D;
	Mon,  8 Sep 2025 17:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352861; cv=fail; b=Xr2LTwKY8er/LamGqBAA+L2EgzcWe86ZTFWyEmQR4UDEpL+mKwlARhyBTuwbPt2qI962VF9mJyUaBwhqz5m4S87ERSWFM0s+Mi0IHOEWACvKYFm7V9Xni+4KV8imdu4oejsTOEWxMb0t9Ce1H9DHJZYOIpBBveiez4xn5Nb5Ak4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352861; c=relaxed/simple;
	bh=J61gs4jq2S1+vbqg9V3+38mv15MmbRW1Ie/XCWYpiV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=I5RUmQVSw5RgGBKxsgXlRadhIxT+pDVRnDcnDeqVpWv4zn6WKJcDwosmcdrn4AqfWy9REoq8E+YzWLzKeIXgb4RP1pz9MM0a8g9zHa4MUzy5dlnC1/tyzM29i853xfrIgY0aUiAzWamEzobRyxU4+Cr4jKmakMOL6BnBs5pJtLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WaRa3f0I; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp/o4yM+zmxW0lmXNVeGsj/jvwYjwvhQMx2tLoUwHay99R27+i9PeuxoW+tk3sYWCejCG5cQ/DCTttuIQT9xAjV5jLSg6GbDLLO3UhsUoBbUFwLzadl33JgjYXt+U86cOnZPApYfuZ4PSuBjd+Yk4QBKGxooxrx50h8yNlc3yQAyHrSIii+gD/sI9I0qnealgyOZqJKjPtzQxScouRXvl0JLnkwTgVWv4zhE81JNfTWJy8u8+yqRvhNna0bOcf6NN5Ra1xnMN5o2yZsZ8R0N3aOS2UKXrhx5ObCFhVwtEIjaCbClB3QXTvaAIs+0j9BnrenkAeX5/YUl7NMTQ5mOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DP/uY7gtMAKIPjdGSFexCFSB46SGx+hMWuvKbOLeteA=;
 b=jPoovVRRdoaBhmqmH/Gl8bB12ccCaAP1uPjS+TtC/UC5QMjKKQxbWQaBY8aI3ARRQsRb3zAeW8myhFVTLjL5wnAYXDUw5EeZAUY46a9fwDuAeLmE2Dgk2nM3C8/Xu3++0hMNQc2rGISyJdKwHZ+dDGuiKSYykZ56oa/ZAaAM4vtdtQVRiJkAvlY7W4le7am1D/N3u5zXyhumppqjyo15737lRuYh+en4g/7Xid3dH9/+iPvfGz3RQyqtJ+Ohx/hyQyNo2dzLt7z0kIJSOkRI5K7YKe08y0nISsEE4s3S56nUBxpVRi0Chx5WOZyPlGinpYDtNrBSQlKrCeqVYS9gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DP/uY7gtMAKIPjdGSFexCFSB46SGx+hMWuvKbOLeteA=;
 b=WaRa3f0IlJESXYSWxs/DR+wqxqDlNHdMGNBjPm8nLvcXmGwiFvgT5SG7+jBIWvlpcJlI1Y9Tiw+K3LXdH47Y55ejMkScl63EY3ykKwcrtfipl57e8fbrz58VCqZy6pHtMf5VR78YmecySSV+auGvc1kkVu/Ep0OlElD/tLrL2j/QmYE3Ltx+7Mm8MsfyFV0hH0ma3dLjK/2DhP+pJG6XlHW5G2wTc/DzjlKuPOTda/GDV23aAkfATWkDWU6CMVmpPFgnR3N808Q9hDrod+DAo/bGT7Sfx6hW1TyA29EcsKOSbcVX78n1Sc91dxCuuGkwBzwVcH0ohh1W7RzBJVpK0w==
Received: from DB3PR08CA0016.eurprd08.prod.outlook.com (2603:10a6:8::29) by
 DU4PR07MB10300.eurprd07.prod.outlook.com (2603:10a6:10:5d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:16 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:8:0:cafe::1e) by DB3PR08CA0016.outlook.office365.com
 (2603:10a6:8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:16 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 41F841C004A;
	Mon,  8 Sep 2025 20:34:13 +0300 (EEST)
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
Subject: [PATCH v17 net-next 00/14] AccECN protocol patch series
Date: Mon,  8 Sep 2025 19:33:54 +0200
Message-Id: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DB1PEPF00039233:EE_|DU4PR07MB10300:EE_
X-MS-Office365-Filtering-Correlation-Id: cf6d84c7-0016-4ca9-d64e-08ddeefdee92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nm9nVk5udzZ5bzdraFRaeXlNTEFYdCtuaFpkR05DSW9IeGFmOGkwcCtQdUM0?=
 =?utf-8?B?ZkFad0gwYytVdXdwMkNKWXRBMGlsOU1OZDlDWkVkWnpkUXJ5SjZsMDBOZkI2?=
 =?utf-8?B?UFJjTlplTlErc1doeGg5OEE3NmovcGVGV1pka3FIQ2pPeTVKMDEzaTNvYXZZ?=
 =?utf-8?B?VFUvaktkNXlISlhaWnVaWWQ3NkRBSE9HODlGUmdsM3U2REl1U0k0MWxmUm5N?=
 =?utf-8?B?R1RlWkROQjZsVzdlSlljbzVQaEpaZTJrUi9mZmpQbUY3TlVTbTBaNWFHYUJp?=
 =?utf-8?B?dExYZExPWTZId3NPRjVvLytTUlFMVXE0c0wrRUkvRGlFb3hFdDhTOXE5Ymxh?=
 =?utf-8?B?TXFrUGF3ZHo5Mk5qQ04vTzNhYkpNVEw1ZlphY0RvQnRqL0F2Nys5RnpCcDE4?=
 =?utf-8?B?bzNvZHFwci9OTEFqSE9lR3RkYU5XNFlpdy9SS2lDZlRZTytoempKS01zQ3VV?=
 =?utf-8?B?UWJPMEprNUFvcElqam11QzRCWDFObHAreXBKSFVaWENIdER1SjFyNk1DSDg2?=
 =?utf-8?B?b2V5UjNPVk5jWWh0UUN0SjFQMHB6OXlPZ2RkQXc4T2VpNHU3YnF0SnM2aGxE?=
 =?utf-8?B?Qkl5U1FieEJBVmgwMjI1N1FZMVFEOXkvS2pTdGhPVzhmbUM3QnpjakhHMS8y?=
 =?utf-8?B?bFJkblZhWUtYMnpFSDNpY0xUVWZ3M1ZlenZ2dVpONHNkODdiQzk2UUNmZlhP?=
 =?utf-8?B?ODlYbTAxeFcyaU9XUThFZ29qQVFxZnU0OXJ2MGppTlIwbUdFZThOV0txSXlm?=
 =?utf-8?B?VzBNeGpmQW5GKzM5Y2lrVVViRDNHenJPOU52bzh6bVlzRHRrRU1Hc0o2SDQ2?=
 =?utf-8?B?Vi9MRGhKZFI4N0VkWDF2Z0tKcUZCbzlUOWNQZyt5bGY1TkRPNWlTbDdHQ2ZM?=
 =?utf-8?B?L01ySXpoY2RBT29jazBjT284eFM0Z1FBM24rU1JsQTNMcFlJb2R6NlB1K2Vw?=
 =?utf-8?B?VjN2cDBKYzB6MUFCNFVPamREZkdTME13UVMxL2VMdlJkejZhTEhobHUrU2px?=
 =?utf-8?B?S3JpeUd6Nzc5U3kwTGV0cktTeWpoRjZGaGl1cFdDcU8vNWZNOFhRcktoc1Mv?=
 =?utf-8?B?cC9TUERIRFMzcDFEZ2sza2l1YzVLcUJaZm5KVFduTFJHdXRNTmFDREV4Vzk2?=
 =?utf-8?B?cFE0dlVRaFVydExndkp0TEtlWUQ5RVVjcnh6QjZQRlFZNjdMZ2hlVGJ3em5l?=
 =?utf-8?B?UWxsaDJ1OFg3VEhNaGtIMGpDRU5jM01vK2NDWW5ETDlyNDMrUm4yTDY0VDBr?=
 =?utf-8?B?ZlhMY1JWQXNuWWxwcTVXOEVOMzgzWjhSYTNSSlArek44ZXJWeE1zd3pZalAr?=
 =?utf-8?B?ZHBXcXR3UkdxV2dqV05yUUorbEJENlBYV3JVZGo1SFdXTGZabXZ2dnZPVzBK?=
 =?utf-8?B?NTJlSzEvZ21NVWQwc1M4NkQ2WWkvS0RGdFVzY1hMOUJaR3M0bDk1YVVZZWtY?=
 =?utf-8?B?dVY5c2dkOFlLQmFmZFhRMmFMc3QyWGlnQUdZSmpZcTNvTzlBdHYvNys5RjRr?=
 =?utf-8?B?QlJnaEw1ZGp4eno1N3FWWncrdUo4WU53cGNNUlQ0ckRNbG5HNXNuWlB0eTYv?=
 =?utf-8?B?eTlMOUFKcUU1RTJYaU5Pd1ZsZlgvcm1iTUpJTURWU1lERjRqNjJXYnVCRzNj?=
 =?utf-8?B?TlFoV000MDh4RDZRRUFMajMycDMwN3lKb1B5T0RUV3BTcEJvaHlVbTFFSjZB?=
 =?utf-8?B?dTA4cmFGVW9PQ1NtemNFaUFKM0FSYlFjWkVtWW1OOXFMcVkrUlcvVituL3dH?=
 =?utf-8?B?eDhwYVhJVzJRd21rQWlmTVZVUGdFV0gwa1BCaDZPMUw0Z2RVdVEvUW91Z2pq?=
 =?utf-8?B?STFQenZwS2ZOMTlzMXBiSldRTTl5bXIybGJTNzdzUXlabzVPMWcyakZlbzNm?=
 =?utf-8?B?N09oRmgwWUZKYllQcXI0d2hGaktYcytGOUMxRVZ2eExRMlBtRHg5SGpOYjhx?=
 =?utf-8?B?ZHRKd3FLa3VQSXVhdXpxZEF3YmdzNFdBd2N0YzhMRFV5Y040dGM3TW5zODdB?=
 =?utf-8?B?K3pJbHVSQklVZG00UDFJL3MrME9XVjFaNUNpWEFSeXJXbHdqMGoyOEdnRzRi?=
 =?utf-8?B?bFgwcXpYR0dsQWY5VWU4ZXZ3UUFXMGZ1Q0JYUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:14.8394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6d84c7-0016-4ca9-d64e-08ddeefdee92
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10300

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v17 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
will be RFC9768.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
v17 (8-Sep-2025)
- Change tcp_ecn_mode_max from 5 to 2 to disable AccECN enablement before the whole AccECN feature been accpeted

v16 (6-Sep-2025)
- Use TCP_ECN_IN_ACCECN_OUT_ACCECN, TCP_ECN_IN_ECN_OUT_ECN, and TCP_ECN_IN_ACCECN_OUT_ECN in comments of tcp_ecn_send_syn() (Eric Dumazet <edumazet@google.com>)
- Add tcpi_accecn_fail_mode and tcpi_accecn_opt_seen to make tcp_info be multiple of 64 bits in patch #12

v15 (14-Aug-205)
- Update pahole results in commit messages
- Accurate ECN will become RFC9768

v14 (22-Jul-2025)
- Add missing const for struct tcp_sock of tcp_accecn_option_beacon_check() of #11 (Simon Horman <horms@kernel.org>)

v13 (18-Jul-2025)
- Implement tcp_accecn_extract_syn_ect() and tcp_accecn_reflector_flags() with static array lookup of patch #6 (Paolo Abeni <pabeni@redhat.com>)
- Fix typos in comments of #6 and remove patch #7 of v12 about simulatenous connect (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and TCP_ACCECN_CEB_INIT_OFFSET from patch #7 to #11 (Paolo Abeni <pabeni@redhat.com>)
- Use static array lookup in tcp_accecn_optfield_to_ecnfield() of patch #11 (Paolo Abeni <pabeni@redhat.com>)
- Return false when WARN_ON_ONCE() is true in tcp_accecn_process_option() of patch #11 (Paolo Abeni <pabeni@redhat.com>)
- Make synack_ecn_bytes as static const array and use const u32 pointer in tcp_options_write() of #11 (Paolo Abeni <pabeni@redhat.com>)
- Use ALIGN() and ALIGN_DOWN() in tcp_options_fit_accecn() to pad TCP AccECN option to dword of #11 (Paolo Abeni <pabeni@redhat.com>)
- Return TCP_ACCECN_OPT_FAIL_SEEN if WARN_ON_ONCE() is true in tcp_accecn_option_init() of #12 (Paolo Abeni <pabeni@redhat.com>)

v12 (04-Jul-2025)
- Fix compilation issues with some intermediate patches in v11
- Add more comments for AccECN helpers of tcp_ecn.h

v11 (03-Jul-2025)
- Fix compilation issues with some intermediate patches in v10

v10 (02-Jul-2025)
- Add new patch of separated header file include/net/tcp_ecn.h to include ECN and AccECN functions (Eric Dumazet <edumazet@google.com>)
- Add comments on the AccECN helper functions in tcp_ecn.h (Eric Dumazet <edumazet@google.com>)
- Add documentation of tcp_ecn, tcp_ecn_option, tcp_ecn_beacon in ip-sysctl.rst to the corresponding patch (Eric Dumazet <edumazet@google.com>)
- Split wait third ACK functionality into a separated patch from AccECN negotiation patch (Eric Dumazet <edumazet@google.com>)
- Add READ_ONCE() over every reads of sysctl for all patches in the series (Eric Dumazet <edumazet@google.com>)
- Merge heuristics of AccECN option ceb/cep and ACE field multi-wrap into a single patch
- Add a table of SACK block reduction and required AccECN field in patch #15 commit message (Eric Dumazet <edumazet@google.com>)

v9 (21-Jun-2025)
- Use tcp_data_ecn_check() to set TCP_ECN_SEE flag only for RFC3168 ECN (Paolo Abeni <pabeni@redhat.com>)
- Add comments about setting TCP_ECN_SEEN flag for RFC3168 and Accruate ECN (Paolo Abeni <pabeni@redhat.com>)
- Restruct the code in the for loop of tcp_accecn_process_option() (Paolo Abeni <pabeni@redhat.com>)
- Remove ecn_bytes and add use_synack_ecn_bytes flag to identify whether syn_ack_bytes or received_ecn_bytes is used (Paolo Abeni <pabeni@redhat.com>)
- Replace leftover_bytes and leftover_size with leftover_highbyte and leftover_lowbyte and add comments in tcp_options_write() (Paolo Abeni <pabeni@redhat.com>)
- Add comments and commit message about the 1st retx SYN still attempt AccECN negotiation (Paolo Abeni <pabeni@redhat.com>)

v8 (10-Jun-2025)
- Add new helper function tcp_ecn_received_counters_payload() in #6 (Paolo Abeni <pabeni@redhat.com>)
- Set opts->num_sack_blocks=0 to avoid potential undefined value in #8 (Paolo Abeni <pabeni@redhat.com>)
- Reset leftover_size to 2 once leftover_bytes is used in #9 (Paolo Abeni <pabeni@redhat.com>)
- Add new helper function tcp_accecn_opt_demand_min() in #10 (Paolo Abeni <pabeni@redhat.com>)
- Add new helper function tcp_accecn_saw_opt_fail_recv() in #11 (Paolo Abeni <pabeni@redhat.com>)
- Update tcp_options_fit_accecn() to avoid using recursion in #14 (Paolo Abeni <pabeni@redhat.com>)

v7 (14-May-2025)
- Modify group sizes of tcp_sock_write_txrx and tcp_sock_write_rx in #3 based on pahole results (Paolo Abeni <pabeni@redhat.com>)
- Fix the issue in #4 and #5 where the RFC3168 ECN behavior in tcp_ecn_send() is changed (Paolo Abeni <pabeni@redhat.com>)
- Modify group size of tcp_sock_write_txrx in #4 and #6 based on pahole results (Paolo Abeni <pabeni@redhat.com>)
- Update commit message for #9 to explain the increase in tcp_sock_write_rx group size
- Modify group size of tcp_sock_write_tx in #10 based on pahole results

v6 (09-May-2025)
- Add #3 to utilize exisintg holes of tcp_sock_write_txrx group for later patches (#4, #9, #10) with new u8 members (Paolo Abeni <pabeni@redhat.com>)
- Add pahole outcomes before and after commit in #4, #5, #6, #9, #10, #15 (Paolo Abeni <pabeni@redhat.com>)
- Define new helper function tcp_send_ack_reflect_ect() for sending ACK with reflected ECT in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add comments for function tcp_ecn_rcv_synack() in #5 (Paolo Abeni <pabeni@redhat.com>)
- Add enum/define to be used by sysctl_tcp_ecn in #5, sysctl_tcp_ecn_option in #9, and sysctl_tcp_ecn_option_beacon in #10 (Paolo Abeni <pabeni@redhat.com>)
- Move accecn_fail_mode and saw_accecn_opt in #5 and #11 to use exisintg holes of tcp_sock (Paolo Abeni <pabeni@redhat.com>)
- Change data type of new members of tcp_request_sock and move them to the end of struct in #5 and #11 (Paolo Abeni <pabeni@redhat.com>)
- Move new members of tcp_info to the end of struct in #6 (Paolo Abeni <pabeni@redhat.com>)
- Merge previous #7 into #9 (Paolo Abeni <pabeni@redhat.com>)
- Mask ecnfield with INET_ECN_MASK to remove WARN_ONCE in #9 (Paolo Abeni <pabeni@redhat.com>)
- Reduce the indentation levels for reabability in #9 and #10 (Paolo Abeni <pabeni@redhat.com>)
- Move delivered_ecn_bytes to the RX group in #9, accecn_opt_tstamp to the TX group in #10, pkts_acked_ewma to the RX group in #15 (Paolo Abeni <pabeni@redhat.com>)
- Add changes in Documentation/networking/net_cachelines/tcp_sock.rst for new tcp_sock members in #3, #5, #6, #9, #10, #15

v5 (22-Apr-2025)
- Further fix for 32-bit ARM alignment in tcp.c (Simon Horman <horms@kernel.org>)

v4 (18-Apr-2025)
- Fix 32-bit ARM assertion for alignment requirement (Simon Horman <horms@kernel.org>)

v3 (14-Apr-2025)
- Fix patch apply issue in v2 (Jakub Kicinski <kuba@kernel.org>)

v2 (18-Mar-2025)
- Add one missing patch from the previous AccECN protocol preparation patch series to this patch series.

---
Chia-Yu Chang (5):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: ecn functions in separated include file
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option failure handling
  tcp: accecn: try to fit AccECN option with SACK

Ilpo Järvinen (9):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics

 Documentation/networking/ip-sysctl.rst        |  55 +-
 .../networking/net_cachelines/tcp_sock.rst    |  12 +
 include/linux/tcp.h                           |  32 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             |  87 ++-
 include/net/tcp_ecn.h                         | 642 ++++++++++++++++++
 include/uapi/linux/tcp.h                      |   9 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 353 ++++++++--
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 294 ++++++--
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1406 insertions(+), 184 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


