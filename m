Return-Path: <linux-kselftest+bounces-36515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F135AF8D3B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 11:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BD17629C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9F2E7BD9;
	Fri,  4 Jul 2025 08:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nuX4KhyF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010052.outbound.protection.outlook.com [52.101.69.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8ED2E7BAB;
	Fri,  4 Jul 2025 08:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751619313; cv=fail; b=jMKGimxWsWEYf/3I/fv7WFSxYUbRPehrejZYmH2SbAlrCJi/yJvtUsXM3DyU3fSQWKZYw09fl6Kyx4GoCaxgt4BFJWMEXzhzmrEOX/4GvKDg/UiLyB6qyqPJHpKTLDm9Xn2lQLVl26zNX+M1PcL/dQgd8EPdzpBkz38STh/RHQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751619313; c=relaxed/simple;
	bh=9r36F+Mq4VjbxRSpiE5Wpwrb13Ecy4+N2Lhx2rbw25o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hgtPRsX8h783gHaMSFfqs8qFHMDa4g+YTKOkdX5ND7A7R76VZy53Ae3bnNbTCR6x+BCd4gHgTDeRKwG19tLUxD/zu3GD3VDdwgb6WqmizEwwljGsgYFS8r2/oXPcfpdcdDXcjPkASQMI3uHMHEZ7KKMY+TrQYzTVeCvbFcYuwEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nuX4KhyF; arc=fail smtp.client-ip=52.101.69.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AeSI8D/EaYCkQrUsqKUtvyeXRWSqmI/NB4ufFAwBt4NaGt5SZQbNlEu/4RIx/9YjyK1bAXQUsLEOWioanPdOBwFLd5YbaP7ttLwO+/+r1NubH2L41FNiJ/cfM5YL7boau7k9mXrhzv4/G1JyCQqEq62bFv72f2rFNogFVhx7Q4dtv31FXp6BJ+HYIQlhjulcO/HXe831sibFsNYd41VvIIxfTomdwEls1a1fyMGdBQXAtzKFmhtBOCc1CoGmv/tYGt1s2OpPigIvKrmh8Vyght/9CcZYDKhwExy05IF62TxR/e0ZPbMOumJmTcW9idZaNxQScgCeiWsm3pnJUHor2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/X2oBAgUbRCvMDl4VqtRuKqUFbuPNOlgonVkgNzzDqg=;
 b=ap9sxcrpA1yRBJyMF5Csc12KJGPtgAZTGvcMKhZdAhZVrx4KuK3fwGVDh1vxGUmwrBQAyqfmTgmnhmTvhd843mYS3OgOXzpE3aDeFev31yTjBpMWqUPkd++sWHKrXiSmL7uV5VIhSfopJ37DzYWbWeaVh7xpTCsq8EddBulHuwXN3h4s6qQmpIWzS6wut3Bg6y2JqVHkpXW7HJ/b/cGZC4SK4WMoAEdgIQdlIfCsgRjazZ+j99LQFdcoRePcrM84DF2IKXCdc/5rAn9bmXIywgfKqAJU9DTyb4XdC+OIVNUo21q9g/kFjC/Imlga4Mv7rqXmYTapd/EAlB6/rAJNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/X2oBAgUbRCvMDl4VqtRuKqUFbuPNOlgonVkgNzzDqg=;
 b=nuX4KhyFfymjf/G5WNAwEkr7dirF22sw0PMBvQkfSJvTchE3zPx/YJkfeQR717VQ9/hQISMxGP5IvF/x56hDLLwIYdUM/588eYLM7ZrGbZzLlwySV0ulozEqL8fhJQInpbfv2nFe1UVfIBbN84362OOXorjC+Oiyui3UAgWu4Omnft3WwYhpvXH4Qy8M5n7/rXN/Xr7zxyCdpPhXqli3DLk3c2ngAUiX3ikwqopZVkBP/Kq2VASXFwLEoY+SEhgXaXJzbOEnAKnF7sdoztWdPDcvld/wdIDGKKIAfcAsu42ZkkuwbYRsj/SxUtZK8l1/ZLW9cQvBUMujOFSeGbW6fQ==
Received: from DB8PR06CA0019.eurprd06.prod.outlook.com (2603:10a6:10:100::32)
 by PA4PR07MB7549.eurprd07.prod.outlook.com (2603:10a6:102:cd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 08:55:07 +0000
Received: from DB3PEPF0000885A.eurprd02.prod.outlook.com
 (2603:10a6:10:100:cafe::e3) by DB8PR06CA0019.outlook.office365.com
 (2603:10a6:10:100::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.22 via Frontend Transport; Fri,
 4 Jul 2025 08:55:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB3PEPF0000885A.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Fri, 4 Jul 2025 08:55:07 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 0DCE2200C1;
	Fri,  4 Jul 2025 11:55:06 +0300 (EEST)
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
Subject: [PATCH v12 net-next 00/15] AccECN protocol patch series
Date: Fri,  4 Jul 2025 10:53:30 +0200
Message-Id: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885A:EE_|PA4PR07MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: ffaa04d3-c6a8-4b9c-e152-08ddbad879d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2NXTDF1WGhQVXBYcTV0eENPTmF2VUJLMjRrRUt1L09ZVVE3WEwrTngzZ2JC?=
 =?utf-8?B?MStFUTZzK3VPMU9sLzhDeFZlczBDME8zUVNhcTZNa1NZMFVHcmh6Vy9hTE1W?=
 =?utf-8?B?djlwZklUWklMOE00OXFNRytUWVZPVFcrSWlpYnF4K2c1cWcySWw5eEM3d2pB?=
 =?utf-8?B?c0dVVnVDaDlxZ3QrV2xObkNXdTBQNHBuUFpzV3BDNzAvQ1orc2UxOEVieHdq?=
 =?utf-8?B?ZHl2V1lDNG1CNUp6MWJYSjV1bzg0Y0VIL1huTFlZRHdxMWc5R3BzdjVjeUhu?=
 =?utf-8?B?c1NwSXBCaEVNZXk2b0tOS1RrWTFhNE91TytPYnNFdHBNM2ZXQm5ZUlFPRXlv?=
 =?utf-8?B?RGZ6MDYzTjF2VkxVeTlJUk5ITE0vY2YzWWduZjFTK09jWDUwVHF0bE1YbnFo?=
 =?utf-8?B?MVVvc2VuQWQ3blRpeDVDczMvaXNyR0Q5L3IzcmtjdEdSZzNTMFZoQnV2czJT?=
 =?utf-8?B?KzZlQ3plVSsxOSs0SUd6dGJDdjNUVXQvWFNUbUFmNzR1YU4wczU5REJ4emhI?=
 =?utf-8?B?UHRhdDNDZGFDVFd2SlhJOUdTajl4OC9hYkprT1RwQ3FFdUFHeit6M3Z5cXFT?=
 =?utf-8?B?WHhYUldVZ1RwdG1QNVVRakdkRmRxUFM1TGd6OTBaRmdycVViWSs3UnhNWWta?=
 =?utf-8?B?QnJoaEhwYXdIL2IxVlhmK01nbHREODV5UDEyV3NNcHBzTDNEV3RiS3Mzak1T?=
 =?utf-8?B?b2RZTmtEYWlxNTlmTkVIdzlIeWYza2p0MU1Wdkd4Q2FlaDJlWnpRQVo3cUhP?=
 =?utf-8?B?RERPNFhBSFpZcmE2ZW1IYllUeUhSNkFDREhiT3cwNitRUWFzQ09VMFc4dG80?=
 =?utf-8?B?dnRwc0dQZHM5SkxOM0dTSUpuRS9SQm9zVlVSR2crY2R0WDVVT2p1ZjU1dzdD?=
 =?utf-8?B?V2ZJS1R5VGFZWGJhN1F6MjVsdDh6UUtHQWJCWkZERlJlM0J1aGNDNHV1bUJH?=
 =?utf-8?B?SDJkN0pESUJKL2RzOEs1T3Y3UmtRREIra0ViaVU5OThIVTROUEx0YWJhbit2?=
 =?utf-8?B?NHZQSUQ4dG1Mb3hwazdSVVdXTitsTTZuaU1YQ2FPR0ErQ1c2MjNDSHl6eWg0?=
 =?utf-8?B?dndlaG1IMENpb2hyMVF2ZW1MTlc4d2hFdVcxTGdCNGxYMDcyT0xvd2tVc2I4?=
 =?utf-8?B?ZWRyRUpyRDNNbGxzUDNtSktaT3VMTjF3a2UwdGRCLzlJLzArL0NXR2RMRlQr?=
 =?utf-8?B?dHZWYzE5QUNXQ1IrbnF3aG1YZS9CWjZvWW1kc1E5RkVNeXdYQ2ZmMHVIbXNO?=
 =?utf-8?B?a0o1UmJ6eTNTdElYZE4vNldQNjZUc1Jic1NCaXkrdnM1ayt0RkhPN1U1SXVV?=
 =?utf-8?B?c1haTGcyRDM2L3BGOVJ3ckwzbVBmVWtUcy9Mby9WOTVHMUQvaUR3VUJ6YlVw?=
 =?utf-8?B?bWtBcmpBWkRxcUJEWk1OSC9iQWVHcGlOYThQc0hoU2FWbllObCs2c01TTkI2?=
 =?utf-8?B?cWpZU0dOcmxkMy9QaWx6QjBvVjI0RERBYURFRnNTVnc2NFpSSjNzTjM1UnNX?=
 =?utf-8?B?OUlHNEcxSyszeDlVbUw2TG9ORStQVXJsUk96WThTbEdSSTBtQkcrci9VVktG?=
 =?utf-8?B?RTVjY0MwaHlueVphZnVWWkNpcjJta1YycUpqOU1iYW9zc1VKUTl0a3dnVWVn?=
 =?utf-8?B?RG1iQjhEMVFaclNoV0YzNm9LWkV1SjhCTUVWNVBnVWZFS21ITFFPamw2RFlJ?=
 =?utf-8?B?d05IRnF1RXFoLzdFRlh6bC9TQUJvUGxXc0ZwQklCNUZIYTVSbGJ0dFJBdEJZ?=
 =?utf-8?B?bERCTmRrUTFiWGtRRE5PWmJ2MjYxQk1KSXlWNU5iU2VZUm1ETE9ZOWw5Z05G?=
 =?utf-8?B?QXlyNVJRSzliMURrZmYwN2tJZjEybWRXYmVBZ1hxYnlaTmh6dndTK1RoTUht?=
 =?utf-8?B?aWkyRER2bGEwNGI5N1lmUDVQa3ZPSnVuT1Fxa1BoVmNsQzBWZmIySGtVTEV5?=
 =?utf-8?B?cUtoWXNoTngyaDNRck85dTllRDhnUDAwOGo1QW91elJuY0Zwd0lVR3hxekd6?=
 =?utf-8?B?Y2VSUEJhcGYvTEg2NE5HMkdZbWZYbEpPOFFFWldva21Wdzkvbk1KV08wMHM0?=
 =?utf-8?B?ZzhWTk1HWjNpcDdVOWt4bld2eHNOUzlXY09KZz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:55:07.5665
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffaa04d3-c6a8-4b9c-e152-08ddbad879d9
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7549

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v12 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
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
Chia-Yu Chang (6):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: ecn functions in separated include file
  tcp: Add wait_third_ack for ECN negotiation in simultaneous connect
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
 .../networking/net_cachelines/tcp_sock.rst    |  13 +
 include/linux/tcp.h                           |  33 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             |  87 ++-
 include/net/tcp_ecn.h                         | 663 ++++++++++++++++++
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  29 +-
 net/ipv4/tcp_input.c                          | 371 ++++++++--
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 297 ++++++--
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1444 insertions(+), 187 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


