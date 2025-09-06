Return-Path: <linux-kselftest+bounces-40879-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860E8B4743A
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B16587CDB
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Sep 2025 16:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AAA286415;
	Sat,  6 Sep 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="dShdahQW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DCF13FEE;
	Sat,  6 Sep 2025 16:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176142; cv=fail; b=p61YEVRfD4pu1NWW4PM7F3tr/T3gUnGpQheaYR/akRVMRp8awqs0jPsmkMaJ6gM2CnSPYtb4zA9uiiZ1UuJF2rhqQiR3PkmPMGUOrDVUZkDrSztB512m6UqGnJ5P3zUuw7HSoTnCU9I9QVflfyrWuWw2IJozZW7N+A/ZEocJZ4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176142; c=relaxed/simple;
	bh=JiAqr3vyEmWonPtpXxpoeKWwSo8SNaHgZrKmr/1KuBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=cgwVSmuGlSAR6PgZiom67pzA8E1/MhQOiX5hBrfihE+00WI6x/pAmmR0c1x9vDJgim0vvih35R7XlnzJfebfT51JtRk/gPALvXawctfnxqVAq2CgD1szD1TWqsvFfp/KiKfUNnd2Al9j1jA6qpMpCrdI7xVTqjoE33cZdPa8uqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=dShdahQW; arc=fail smtp.client-ip=40.107.159.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iDWGuRXAItqAlGB/c0XMg4wQwUcUz2ir56rfOodSjxpZRhWprxd2uhkFQI7RRKINqfnHKnl/mnA7qYvHQWw2/Fue+EZ2nfmAZiJG7FLGUe004kUYLO02/CbxM1xXj7UwRncha38SeV7AcCZTpcRWNurxMs2IIuCMgdlAJX92Tqxzks9xa4QjqBC0veuCgr4b5Ae9e9RoHh5hkNk2wKLS/Q4G0Kb2KWzAlS2PYOcbd41JwrEA0CQQcqfxBhBoXW55KLXet/4aPZsdruYugQQQBVeTLjqzdkQi1tceekGFYeRXWgc2jZI67y+02qbBj5vya/d/MVL6iBAb3xvod/6PMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKTZan85M2g2M3MAUrjWknxDj/mtVw3xvhyLSD9RIDE=;
 b=VaYou9weXQQta6G5larVI71eXKM91N/RJb01w2YfJu5l/DL3OMWYZ2bgEQcX0AJodtkirKfD1zbt7FDOGM3ZLc3tNsmwiOj+TSKij95vbrbcz9ikOXmtR03r7yiSbDQzZNXJbDexFTDkJ2MgLx3frN2MKYRoCQOQPO1aGEx4JZo6wV+gQ/iLZlirWmjhZyOiqGdwlaL5CrWSM1pDNDwe/OBhDW+pYDxZag+aLVuU2icJhOjY0gEQBISHnCYCbaA6OuMxoaP26jhs7V+In6LixYJpRhgTJWFOGuT2n4a6y8DF8U0TFvMQ/MPOw2zDGAPKPe+bSCuUjJAurI1aJRvmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKTZan85M2g2M3MAUrjWknxDj/mtVw3xvhyLSD9RIDE=;
 b=dShdahQW1rrbqw7r5eV4+8RVGGqDQJpicqq4TrBG0XR9RdGq1wkg1Gg4cckhpCWgUZ2q2n93210Fw4soe/7m7imb/s7TRAQ4VHw4H/otqhuOG1eFiJjRjugWv/LajlqceTZqFdsBfTggyKKOc5/vbBxPG2/rEefvjykv9x/ScZmzWhbXoqCX8WVxRJiiDvor92qg8BEMKgub28jkDqcxRSy86O4Rue50DXz/ZkKUeK0c9vAMLJffTjLkgRzUmzVWeyqKe0EnDFJTe+bdoqFNKvRJFKiGtmG3K7BL0RGNoaSmsJXLu2Y8OTT7Z4TmhwaT8GpkKETUVFaSMI7yWDk5HA==
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by DU0PR07MB10244.eurprd07.prod.outlook.com (2603:10a6:10:5dd::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Sat, 6 Sep
 2025 16:28:54 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:657:cafe::86) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Sat,
 6 Sep 2025 16:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14
 via Frontend Transport; Sat, 6 Sep 2025 16:28:53 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 890E51C002B;
	Sat,  6 Sep 2025 19:28:52 +0300 (EEST)
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
Subject: [PATCH v16 net-next 00/14] AccECN protocol patch series
Date: Sat,  6 Sep 2025 18:28:36 +0200
Message-Id: <20250906162850.73598-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|DU0PR07MB10244:EE_
X-MS-Office365-Filtering-Correlation-Id: 313d0d0f-df1e-486a-c081-08dded62787e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|1800799024|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGxweC9jN2xFRExCRGhvQktQRytxVHFXZEYyb096RkxQbGlpWU16cXZ6azF5?=
 =?utf-8?B?YzFvemE0WjY1L3A5TERIQS9ES0Z6RjNYSnVDTHZkRGZNd2NDeXRMRk02WnBp?=
 =?utf-8?B?RTdwaU1HMXlBTW9LVE9vYmxCaWFjdGVOSnNtRzkzOVB2bEVWYm1CN3RvQkRy?=
 =?utf-8?B?cUJZemtxdzJBZGlEZWlJdUZCT1ZBSU1yNG5sNHF5ZUFMam5Ibk1ibmRIOHlY?=
 =?utf-8?B?L3hwTG13blJ2b1RpeXdrWjRCYTMvUW5vaklZcG5wTFA0bjRXVTB1WlVLaUor?=
 =?utf-8?B?akF3OE1CeFQ0VS9SUjFsT2RVQ3JmYWxVZ3RIdVRZR1RqMHgzNnhJMVFlL2NG?=
 =?utf-8?B?b3VNKzZXcFNHUXBSMTF1MWlnR21lSUNEb09SL2VJMWpERnh1TjlaRGhXeGpj?=
 =?utf-8?B?R3RCOEZicEM0aFB6dTlkSk1DdWpWOGdTYkZBSGVoNVVDSGg5b1FpMU1ORHJY?=
 =?utf-8?B?TlppRzJzTWpQV1dRblAwQWFXNkZVU0RQY1JGdzhMT0Y1YTlyMjVjUmo0NUsx?=
 =?utf-8?B?dGI1RHJJUStYZ1JqV24wNWcvVlJWVFJzWHpQVUtOaDRSWlVybUhmaTNPcklC?=
 =?utf-8?B?ckl3RDhDM0dsTmVvRTFMYzVrTkpWMDY1RnVZbW96NGg3YUpoSG84VjNhMkJQ?=
 =?utf-8?B?S3RFaWJSZ2RWVi96RnYyaDR6U3hvOFVHWlgzRmFNT2JFODRGZFdUcDJGSUxX?=
 =?utf-8?B?TUsvR0lCTVBIaTMyZmxScUY2VXNIVlAvTWh0VzFXRUhtUzFTcTNxTlVNMEVm?=
 =?utf-8?B?MDBWSjUvRGFncFJRYk5saE5FV0dNdXkzTUJKWHpucjhRRUE2WkhhTFFxa0dl?=
 =?utf-8?B?S2U4SC9teHUzRDIyZy9IM1RWUnh0UFhlK0Z3bUFQWDZnYllyTFFkRTJNZ0Jp?=
 =?utf-8?B?Uy9hbXhPM2V0aWVZeEppOUt0M1Bhd1BMZWx2L0tTN0MxUkJtcXVUaUZyZk1D?=
 =?utf-8?B?Qis1TW1JOW9reUxsWGZnSkY5cUNsdmpTdjYzeEVhZmNkV0pzQWFycG1zWnZG?=
 =?utf-8?B?UVFHUFh2T0dVQmJwSkJvdE9sSW1iS1dwdlZtb2tybzlvbGhTaEM4cWttRmN0?=
 =?utf-8?B?M1NDd05QRGJLZjcxTGhuV0dMQ0NZWHNFZlhIRkpsS1RmUDVlbVpKVW5yUGIx?=
 =?utf-8?B?Z1ZnbWNCUTFTY2czT2ZVMng2b1cyZmJ6eHI3ZDJrdFF0V2FsakowTWhyQ3lt?=
 =?utf-8?B?ZEJGK3JWc0pTY1plaUtsclNiMmZuVDJhWTNyZkRzQklnTXdrQkZGOTdQUzJz?=
 =?utf-8?B?aW1rTVBvRG4vQmI1VGpnTTlYNE1UdTlOREpPS09CSGxSOWRRVmIySnlickR3?=
 =?utf-8?B?dG1wMEFmdlJUSm90c2kzT1JvTmM4RkN4Z2hGaWh6bEhaNG51Q2dSUjlncWZH?=
 =?utf-8?B?cGNoalZhckNHbTE0b3ZaYVRLNERGQzRPbnpXbU93RlJVb3d6NHJ6c1dJeFpr?=
 =?utf-8?B?WjdDa0VYUWxNSGdyYUorL3lrT2hLeWdSTGlheFdOa1pjcVN1Q0R0c1JxNDg1?=
 =?utf-8?B?ZjhSOCtYWGRFS1dpNVNSV3NWMDgzck9KSE4vUDNLNjRaWGhIN1hHeml1L0c1?=
 =?utf-8?B?NyswaUdwa3NPbXdKU2gwWU93T0haSlF6OXlEbUlxYkJkSmJxbDBnOG5VeHB5?=
 =?utf-8?B?a2V3bWdhRkJhWVkvSmhuMk8rM2NURDZWZlBFdC9lQW02bjcvYlYyVVZuMGU2?=
 =?utf-8?B?OU45VWpCRXkraDNqbWRvU2p2SDVINmtaUCtFc1pWWnNaSlFoTEovV3JLMGxo?=
 =?utf-8?B?cHhyUGdiMzdZdkhtVm9OQnBhbjBEeVl3N0ZLaUFTcVEvNXpBRnllQmcvdDha?=
 =?utf-8?B?MERBRXFHZzlYNFlTM2w2NzNHbU9ubUs0dktDRG5DMEsza3FwbG4yRWNqUFJa?=
 =?utf-8?B?MiszWFNXOU15RHd2T1ZwSDlvWEQySDVFVDhjdlQxR2NObDVvQ2RGRUl1L05J?=
 =?utf-8?B?MmtJMi9mVzlPWGsxYmN6SkxYVm9KSktLb0NEY2lFUnRlK0xXUmF3UmlYcFk3?=
 =?utf-8?B?S2o1bzErS1E4RWVKQ1pCdnBiVCtIcWxJdmRnbXZ6RnZPUzhnd29NRnl6ZWJX?=
 =?utf-8?B?SHhFeXZvUk93Ym9GbkpKd2VRTTQrdnlqU0Uvdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(1800799024)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2025 16:28:53.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 313d0d0f-df1e-486a-c081-08dded62787e
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB10244

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v16 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
will be RFC9768.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
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


