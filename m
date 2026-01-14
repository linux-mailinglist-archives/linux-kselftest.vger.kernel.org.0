Return-Path: <linux-kselftest+bounces-48956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423E9D20360
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D8FD3011FA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 16:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB253A35C2;
	Wed, 14 Jan 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="inhMSy3r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013043.outbound.protection.outlook.com [52.101.83.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3913A1E9A;
	Wed, 14 Jan 2026 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408164; cv=fail; b=XDEGmcfYEFCbwDKt/Kms4dD8VcluEycURudhpnN/eJyjXKok/guh9QFuVKJkh8a5dWRyCaWJEEPuez4LAtf6KWOZ7nLD5CuYfZR8dkZHLZDEGROyHNsnrYi/OdRHtg5uY4xiuCbqh65PtIFQ/9l1Jjh+INe5pSgjoXY8CV/MhVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408164; c=relaxed/simple;
	bh=wYg8Odzw6MUyYuLVwmexnjCrEgqEpt+GVm0/2hVrEPg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=evhxQ9E1U+zmkLajeiDviQ8FIjenSs/j4YSjAw0OYAXaJQuz0C4VWRk4WNAyq3ygvr4TcYu4NFLtJvXkwuyQCtWgcNgfW+Pl5xdeMHadA5Z1rJ/u7F6dcn+LLVcZfJPu8pm6/oXmcOQIchRQ/wIbOUF06LoKFm/5+d9PvuI6FFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=inhMSy3r; arc=fail smtp.client-ip=52.101.83.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2hPPnPY+XQLikhbBbsvd2i2ggjVcJ0q0+ONeTZrBE1dE3LSdfQEbfkaafDQwTcQgxy3MfK9EX+Esd8RpAHsbgvDCvByxrAYxa7SBzEphtR8ldqdXSsS4ZMduNYNqWueTu1CTQu8l96IrinTNQAanyneBkzRKPSsWQQrMc+RJ3wKPqmubgsVR5EC4J9gKSabso2H/b7Dl+Cx0U/ZrbmJk1sEDkKu+zhs67KB8CJBWLesMT0PD0INrXBC52Nbsr8/lhCOEuuO9yRUI0Ffd3IbWfWLRk0MFq0S8pa7Rz3QE1QDQw6sH6mQkXGneOmZZzVKCsKMR81baHDznYBWCwi1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMm25k2pQs+dO4j20LCR2DyHgqcTk2wJTSNwa9Jq764=;
 b=Nt7pR4s4vQdAX+CBM6nn8PRp6wq3Yl+/hXYnDP5y+HwdzyCoSTyblJjp2dNLKchgmuB8Tx1nBzHCOdXsu6kinTs6ErBcs30fLI0/9a+a0e217a5Se0Hd49gE2NszUG06rt6yRLlkzoDBd+CR8vGFjLOXOiTfOlhMF2BrzwRYOapU4lMd8jl4tUn7WtdscYNganV+lC4RSHD1LGaeJrJc+vY9glXFsN0lQs54gst36Atm2ZkaM5f9PoFEUtvHA+NRLSm2LrY2bRl1rpDLQ1UPY5m27o86tAi3xy+qY1cluEtgkVhOA7VqZMYO0T+Ca8nhvg2/XqsQc7gInCugjtbDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMm25k2pQs+dO4j20LCR2DyHgqcTk2wJTSNwa9Jq764=;
 b=inhMSy3rYnVivPfbCabW2oU5wRcvD8hcuQP9YVTNKY97WZch6lEKbEXQPTSytta8Ph3q+tCre64FhbGahzfVgPZoT0ywonI5ayO+MqRhKMT767Zs8STXG1u/HIPgWfaXvFsibomDBmRrsPqi8v0F9jE0yaLfe+NaqkGeEn7OkTk39fDXCRGgnHTodIMVXOk8Bv2Q0h5b752K99rSEdNfI999uLXBAaI2TqWEesbBICGQ9rsgyZJ9ucfPfQ8KPcRlHEbKNqGeWTjqMl4DTQ+YPcmz9SzdDnnuPmb6/wmk1kwkiQO+xsB8CjP8DwZFuObWd2AudEpAJTPQWJiabO4JCg==
Received: from DU7PR01CA0009.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::27) by GV4PR07MB11630.eurprd07.prod.outlook.com
 (2603:10a6:150:2e8::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 16:29:18 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::4c) by DU7PR01CA0009.outlook.office365.com
 (2603:10a6:10:50f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 14 Jan 2026 16:29:18 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 960F21C003D;
	Wed, 14 Jan 2026 18:29:16 +0200 (EET)
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
Subject: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Date: Wed, 14 Jan 2026 17:29:14 +0100
Message-Id: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|GV4PR07MB11630:EE_
X-MS-Office365-Filtering-Correlation-Id: b4421112-5ace-4b03-1431-08de538a109e
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K1c1aTBic1pRRy9yRzR5NFJpek5BMnkweENObmU4SXJkVmtKNTF5d0VQNVJN?=
 =?utf-8?B?S3JzMTdEL3ZjemVzQUcvTXNtRXZJeDJlQ1k1azhGN005OWVHUklSazlUdTk2?=
 =?utf-8?B?WS92LzNkWDVkcDMxM2xnb0VNaUtsYmlkWC9ZaHB3SVNKaUdJQjV4YzVTVVRM?=
 =?utf-8?B?QnBFM2ovdC9ZWHErQk8wV2h4WXo4dHcvUUQ1RFovcVFnRGovaFdIeDIxOFlm?=
 =?utf-8?B?NEVGY1cxZ21oa0V2bVU1aVVyVUtYcWVpNXNGUXBueUxraXBVK21FK092ejdl?=
 =?utf-8?B?bmt5aUNRSHBkOG96Zy9KTitRUjNpc3UyRWRKQ2oyUlhpYTFzQTBVS0dXeTFa?=
 =?utf-8?B?RHNJeWorYTd1bkFNRmJJNi8rblJYS2F6ZnIzQnE4S3U3NjBJa1N1MDFNbFRE?=
 =?utf-8?B?TUdvd3BKVDB4blI1SXdFZnB4UEcvTmE4UTJuN3YrUTlDM0Vla1lQZmM4dTRE?=
 =?utf-8?B?OWRlMUpNcDc2Z3JkeEo2cTYrRFByU1FXZThCRmIrbVkxK0tiMWhwNkdMbFJo?=
 =?utf-8?B?alZWUEJsT2dpbkFjY3dEV3l5Znl2S2RvR2QxNGtTZS9DL2xyUTFtTzQ3VlNM?=
 =?utf-8?B?cS9oU1NXeUxpQzFpTDNvbkJ1V2dqWklGMGVNeG40VzVwSzExdmJBUnN1Q3dq?=
 =?utf-8?B?YkJ0TURFVjZOa2hZSjNSMEw5bFM1eWZnR0RrenplK3NmUWVKczVmNWh6aE52?=
 =?utf-8?B?eUwwV0pucmFQRzJSRXpTVUpiMlpWVnc5S0l6VmpZNE5rQUxqczVTUEdWMEhy?=
 =?utf-8?B?ZUo2bkdVTU5saEFDa1VvWU1ON213SU9Mcitkdm90MDJaa0FKTUhrMnNGRDZG?=
 =?utf-8?B?elNMUlFqLzY3ZDRpQnhEUjlxZ0FraGlYVDhlQktBQXQrUHYyd2RkQ3F1SUt3?=
 =?utf-8?B?Q0xtNkJ0THFKbkc0Z1ppdnBBa1RMM3dLVi9UY012MTlpWWJxcm9pYmphbXBZ?=
 =?utf-8?B?VTE2Y3RrNklnWkYrbmVQSTg2VFYrZ09xa1c3dTZHWUtVOTZDRUJobXpaVXpU?=
 =?utf-8?B?RHRjODhHLzU5TlYyR0VMcCtjL01NSWtOeEtFRkxrOE1ONlpVam9KMC92cWVF?=
 =?utf-8?B?cDZ2WGVRTnJwa293bnpxdUZMMStseXl0cFZKQ1pCbWRjTy9vUElpak5jR3BO?=
 =?utf-8?B?Y25kWm9VT1cvNUk2eEh3L252Q1FrRVFjdVhCYmhkMlNsQ2krSFhjYUZiMUJq?=
 =?utf-8?B?aGlIekNjMUtwRUtxMkE1dG0yZGxnMDVPcndIUVVYN2JjMUsrRE82N0Jtc1pC?=
 =?utf-8?B?aTR1RDJLTTczdExoR3FtSnVVamoreG9LcDRpTEIzTWtUVm50N3NEUTd6dzZZ?=
 =?utf-8?B?UlhHS0NkdnZPWkdVSTFRaTJIUXZiM2loU1RCY2xwVnIyaHZEK3ZSb2pvdUpX?=
 =?utf-8?B?T0tXR2dwSlZ6dTk2SFdXV282dWhEd1pmWFFqOVIzb1dlbUVnMGthVWoxQ3kz?=
 =?utf-8?B?MjJNeHg4RjhNRnA4WVI1dUQwR2dldkFyUEVudTlJMkZxandpK1JZNlZqODQ5?=
 =?utf-8?B?SzVKekcwbjYwT01PMWZ4K1k4ZUJFTU9yWE1YNThiOUhPc1BXKzhoOUkvOEQw?=
 =?utf-8?B?WnZlNkZVRUJGWjJWMkhuSmpzYnBmRlJqZ0lKeVBMTTVseXVaZ1gzMEE3TWFP?=
 =?utf-8?B?dk1CRlhUYXQraW56aDhRREFTKzhRQzlXcGJDUVF6eDFBV3Z4VkZLRVZuU1dx?=
 =?utf-8?B?MnhKQ1hReE5OTjk3ODUyK1I1aGJuM3JpLzB5THFIaTlTU2t2RWxhVjRqaVVK?=
 =?utf-8?B?NU5KRUZhY01KWERFZzZSUUU2MmQ3Z29EWVVPN0RGalhQcDR4cU1qQkFFK0tN?=
 =?utf-8?B?cW5aYlg2YW1sbXNpK3Rwdjk4S283UUpFK1ZtNDNGTUZyRlprTEpXZkFVVnp0?=
 =?utf-8?B?WHNVdmlLQXFYaitteklnUHozUzd6UnRTUWd4blMzeGhZektNZlFkQ1E1VXZj?=
 =?utf-8?B?ZGtnZ29ubGYxQk0zWmtldldETkcwMU1LUGN0dHk3b1o5V0oxWDFaamFCUkFh?=
 =?utf-8?B?UVpaZkJBZXg0ZjBLUDdnRDlSYTZWMFBoVGlqbDBMOFBaeUZIRzEzRFF0ZTV2?=
 =?utf-8?B?a2ZYeUR4b01CamlIVkFSYUhPSkgwWkFJaklPYW9CZmJsRkNZZTRsZHdPb1Rr?=
 =?utf-8?B?UlNqNDM3UDlDeGxlcEI4VWJlYXl4bDFLeTM5MUlYLzBreGdRcTVFNUxUWEtV?=
 =?utf-8?B?eDUydFBvUngxQUdhYWgyUit3dFpDRkhXeVFCVUJTNi9DLzdJTFBab3U4OXpV?=
 =?utf-8?Q?UjQtH8Cac3mKQI2alzUDzaKI+yrBONfny3X3h4V4hI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:29:18.1728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4421112-5ace-4b03-1431-08de538a109e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11630

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v2 AccECN packetdrill selftest patch series, which
includes 58 test cases used to verify the functionality of
Accurate ECN spec (RFC9768) under a variety of conditions.

The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
of the branch: https://github.com/minuscat/packetdrill_accecn

Best regards,
Chia-Yu

---
v2:
- Change patch title
- Rename all AccECN cases with tcp_accecn in the prefix
- Move all cases under tools/testing/selftests/net/packetdrill/

---
Chia-Yu Chang (1):
  selftests/net: packetdrill: add TCP Accurate ECN cases

 .../tcp_accecn_2nd_data_as_first.pkt          | 24 +++++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  | 30 ++++++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  | 19 +++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt | 18 +++++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       | 22 ++++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   | 26 +++++++
 .../tcp_accecn_acc_ecn_disabled.pkt           | 14 ++++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          | 18 +++++
 .../tcp_accecn_client_accecn_options_drop.pkt | 34 +++++++++
 .../tcp_accecn_client_accecn_options_lost.pkt | 38 ++++++++++
 .../tcp_accecn_clientside_disabled.pkt        | 12 ++++
 ...cecn_close_local_close_then_remote_fin.pkt | 25 +++++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      | 25 +++++++
 ..._accecn_delivered_falseoverflow_detect.pkt | 31 ++++++++
 .../tcp_accecn_delivered_largeack.pkt         | 24 +++++++
 .../tcp_accecn_delivered_largeack2.pkt        | 25 +++++++
 .../tcp_accecn_delivered_maxack.pkt           | 25 +++++++
 .../tcp_accecn_delivered_updates.pkt          | 70 +++++++++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       | 12 ++++
 .../tcp_accecn_ecn_field_updates_opt.pkt      | 35 ++++++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   | 14 ++++
 .../tcp_accecn_listen_opt_drop.pkt            | 16 +++++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      | 28 ++++++++
 .../tcp_accecn_multiple_syn_drop.pkt          | 18 +++++
 .../tcp_accecn_negotiation_bleach.pkt         | 23 ++++++
 .../tcp_accecn_negotiation_connect.pkt        | 23 ++++++
 .../tcp_accecn_negotiation_listen.pkt         | 26 +++++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  | 23 ++++++
 .../tcp_accecn_negotiation_optenable.pkt      | 23 ++++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        | 20 ++++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      | 27 +++++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt | 27 +++++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        | 18 +++++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         | 18 +++++
 .../tcp_accecn_sack_space_grab.pkt            | 28 ++++++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    | 39 +++++++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt | 20 ++++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt | 20 ++++++
 .../tcp_accecn_serverside_broken.pkt          | 19 +++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    | 19 +++++
 .../tcp_accecn_serverside_only.pkt            | 18 +++++
 ...n_syn_ace_flags_acked_after_retransmit.pkt | 18 +++++
 .../tcp_accecn_syn_ace_flags_drop.pkt         | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     | 27 +++++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  | 28 ++++++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt | 22 ++++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  | 15 ++++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    | 25 +++++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   | 26 +++++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt | 25 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

-- 
2.34.1


