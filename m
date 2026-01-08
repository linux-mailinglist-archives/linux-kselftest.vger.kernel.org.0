Return-Path: <linux-kselftest+bounces-48539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDDD0436C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5FE5E30EDBEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6197922CBF1;
	Thu,  8 Jan 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="koA+r3n5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011037.outbound.protection.outlook.com [40.107.130.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFC51F0E25;
	Thu,  8 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767887907; cv=fail; b=iQgIBSkZx4NhObA5XOUlwKUn56GHkizggYRvXqorZkdacqv5lBk0FjsYa7Jy8gP/0QMKY0qvrKoJZyIW087V1Aawj18pLeP8ZNY1xJ4GIJQ9SoReuUn47z7hhF0C6rCmJsj4Qd3ZCSPUwzSzFwp7b8FDzyUblPq9xAHjR3CnYGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767887907; c=relaxed/simple;
	bh=fIhIMwuEkxPlfKk6ebBaeYT3f841rOtv/vMHE+j8dHc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jYPFTAVxd0xHOctGGzMHSSUOO70XNj2jeeNUD028KLsJyFw7ZctpvbvWIjqe5MqGTILUaQd0ev6F5DK+06gH+M7gwNgrDtRwwTsD0ACr1jK2U0reDcRHW2VFij3j7u8RXEp5R/7djCsLcwh4fWFuudWlZy7BlP2pyhbZqcajPLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=koA+r3n5; arc=fail smtp.client-ip=40.107.130.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kIA/wKmT1qE1MFsAzEyKlzkR2hWuRZ5MURvDGSDb+Eiu9eqqKBIpuWnRjswGSwMuDA9TWN4SRf8mkao1Ox/8LKPEf/7ajCQPMEU1IJlLJ5k1kW3FHVqk0Z4VBvrBTzgUhf1gsilkrGFt8LXYZAQGz2Osmnk1Y+mOmVTyWprc5qmDiPZN2s+YS+Iphaz1Q/VO/tGQmTPPN0CBNbpFG/VFKaeByQ3G9g74UeFAx8S9G3uQIDmDIlmMZ4M5DK3Mj4FACMQX688lAzDAFOj56Gvg6xiaJCL/CUTYaLbcB7gh4uHDewa9jlApdKwxUUqatcfECDOa2VghfTfP9rb28/goDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=olPwJX2H7K90aW33zds3ExEdFSGLobj2XO4MqlTul4E=;
 b=vb4i563o6XeYUarfAn2YGcrjS0PfVLxYW/hMu1G/A/kV24U6oaXH8Znmv5iRU1soiDAHq0qq/CTEuyoAaFvBmZSosFvOo1LBLk39VQOOm1ZcCNjMKbUMJ+kfPzIVML2UVpEo1q1mZ05pcpF2OIrNxWll8ZU79f/xd+fnw5ti6mg6pqB72Eu+1AEKe+xOiUW1oVD+uOE7Oq7DUi+coshPQsrafMUGf8Wxp3PFkmYRIdSubmowlEl28lqyPNsnYkCG9VvROhOOEBq+Ff3bDMCJpNAJnRvmAlsxaChIIL7c255cDFURD1XHYJbrP2ymw4mtkWRDkZgxxKx37dwytXweWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=olPwJX2H7K90aW33zds3ExEdFSGLobj2XO4MqlTul4E=;
 b=koA+r3n5/LZPaXIUg4HzsrtqLp5KQP3JBKxicsjGDTjsNSydBbh1p66PZmfq1PP6dPnkpqWwj0N7zlSeurKVcpVEQtSKNQHtSCrGuMofM1kcjkE9t4fFWonf5T6mxURYgVSDrGUvmD/CHKmwdqyV+PAvxfekz8xDGYqAERS51AYFwdgQwBN34eY8nPTJzAqv8GEIRg2UIystELoYrEf8mi58Bjy+WMsOZfClw11BwVnX9C12C18f5se2iawrAHd5+ao18IHkzqNKEwdUlhFwO9y+ozp5wwVCbsMA/VYedgDaLNwK0ShqwcPUvevSg2JPs/c1+LIAX/Ib4FEwGYaTJA==
Received: from DB9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:1db::28)
 by OSKPR07MB10519.eurprd07.prod.outlook.com (2603:10a6:e10:99::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 15:58:20 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::1f) by DB9PR06CA0023.outlook.office365.com
 (2603:10a6:10:1db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 15:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 8 Jan 2026 15:58:19 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 67C4D20320;
	Thu,  8 Jan 2026 17:58:18 +0200 (EET)
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
Subject: [PATCH net-next 0/1] AccECN packetdrill selftest series
Date: Thu,  8 Jan 2026 16:58:15 +0100
Message-Id: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|OSKPR07MB10519:EE_
X-MS-Office365-Filtering-Correlation-Id: 692f31a4-fc8e-4cce-4719-08de4ecebe8f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WlVkcnB3NjJyZ0lpa1Q2NDhNMFhLZzVNZ2p5aTJHZVY2UHEyWDNFVUFENFdR?=
 =?utf-8?B?akJQUlhZNVRROWlGNXJSMGhKZ1kzZ3NjOXFGRFN3SUcwMTFHVGNYSE1lay9W?=
 =?utf-8?B?ZzlYc2s5N3FseURjMy9ZMmJKcXVGR0xLWkFEU2kwd3ZNeS9BTmhoS2dKbCs0?=
 =?utf-8?B?VGNYODJxckw5V001M3dMYjlJNjMvTG15R3pCbWlIclA0TWxmS3JSTENWVEJa?=
 =?utf-8?B?SHZkajZqZjJ4bVExOWNPa0VOY2IzR3daY2p5YlhFZVd2VHJNYUlVTE5teHdB?=
 =?utf-8?B?ak42bFIwUEx3Z2lleXV2dXJKMG9aL3FUTVBjYy93cUU4QnlXMkFnc3BRMWx6?=
 =?utf-8?B?WHpnYXdNYTNmdENWMGtMNFlkQnRHMnBtTUgyZlh5Uk5oQ2JKVVJ0dEdyZ2Q2?=
 =?utf-8?B?UmZLdG1YZ3ZxTFNBRDBPUUUzQXVmdmlOb08vdGZoY2JudFJ1b2wxYlFsYXhL?=
 =?utf-8?B?VHpYbkl6ZVdvQk9ia2FGQjQwNVBWdE1JOWVmMi9SaTlLWW5reGdRWUVDSUp0?=
 =?utf-8?B?VkNReFgwUWc5V3JYRVludVF1ZHhLTnJic0dKZE9ITmNocTlEdGh4cVljUjdL?=
 =?utf-8?B?U1lmMkFYWlZzVUNOTFdvWUlkY1dYcGtTeTNsbE1uNmk2aE10dTBXS1I1NWZr?=
 =?utf-8?B?Z05zTktkUGVVdHIxN2pPSUUyU0JURVJ5Vm9wai9BTEV6Z3NVS1hiTUt0M1B0?=
 =?utf-8?B?Z1VwbGVQU1lxblNxR1BjY0locVhDSjdzczVhcTVBUlAyTGFjU1pIWi9FMFZ1?=
 =?utf-8?B?SU1uMTJ5a1lwdExPKzg1OUdOMUM0WXQyeEJXRXJwUWVGT0hSL08rTDBKMUFM?=
 =?utf-8?B?Zk1ndXlyTXVaTmhuYzFXSzRGaHM3akU0blQybHFkUGVYVnFWbjQxbTZMY3dX?=
 =?utf-8?B?WUUxaDgzZjcxRkRGMTRlc3B5QWN6TGlIQXN0SU4yNTFlNm9pUWEyeWhvK1Zn?=
 =?utf-8?B?SFUvODVlOWozcmZjVmRsSjM1d1FnaDRHVG9JTmM2ZkJlUzA0QnQySzlYYWU1?=
 =?utf-8?B?OEZJQVNDdEtqalFnS09DQnl2Z2NROVdTaXB4aGZ6R3JXTHFQdGRwZG1takFv?=
 =?utf-8?B?OTFBZExiOVNVKzhVUU5pNjNyMlJIeklpZVpnRlJMTVBWS3BxbnpBK1k2RXlF?=
 =?utf-8?B?aitlUStnc0xtMlRLSnZwQkJnVEp5QWNYNUdEdVd2ZWJjRzhpTjJuRzFNaHI1?=
 =?utf-8?B?N0dOYTVnS1JIdHpYU3pKUWl0REF6LzBZSnBQMW1UWnZaYnZuRFdvYUplNi9y?=
 =?utf-8?B?aXBkeGt1QTk5VEJwc0x3ZHZ2WEZJTW5TUGNlYTJ5TXFJckZhNXl4QUNCY2dH?=
 =?utf-8?B?bmFzMTNOaVRwZGJVdjdLc1JkM043T2VjZlVkZ0ZoWTF1R2xZV1RRc0NiRGxJ?=
 =?utf-8?B?NWZadGw2dk00R1JtOUY2TzNjYTl0ZDZ0RDlBUDJLa2RCT0E5STV6S2ZZcjlF?=
 =?utf-8?B?U0R2OFMrUDZncTVDanFNT1c1ZkhEYkdwY1FEbnhueE56cVZySEt0QllGdXF1?=
 =?utf-8?B?RG54elgrUnROcW5LUVZtYjQ4WVplak5yWW1sV2FMOHduZ3M1bWJaZlVrdnU5?=
 =?utf-8?B?UzR3Q1dNNlQzU05jRzhneURYYW8vWGsyVGdYZ3UzZ3FQY0FrQlpBd1B6Zlkv?=
 =?utf-8?B?SVllenRsREwrdDU5OEFGb3haN0NnSlRJcWtLaFpHdTg5VmxRK1JGbEsyTUF3?=
 =?utf-8?B?NytlZ1NNVVJ2T0R3TC9kdUhGMlJTNkN1Q0RDVVQzZ1d6SmYzMGZ1NHpxQWdw?=
 =?utf-8?B?NjdvaFBUY1pHMTh6bEJSVFpLRVIxREp0NGhtWlFqME1Kb1E0M09jSGw2MXBh?=
 =?utf-8?B?UUx3bjhJQk1vZHN0ckJxUnh6ZVFrZFFXVUNrVkRNdUF2akhYelNPK2pSemlR?=
 =?utf-8?B?cEhoTkJVMk5VUUYrYkZKbjg3akNoOWNJMERVOWlVMi80T21LYnM4bm9RNmN4?=
 =?utf-8?B?L1U0L29jdXROOWtlN0d5TEJIRERkaEFvNCtRbTU1RFY3QWlyVFJjbUtYUENX?=
 =?utf-8?B?QzF3U0tHWHBXbnlpdHM3dUg2VmNrcnB0WnlNS3krZldnVHZMc3VHaHByN3di?=
 =?utf-8?B?RVEzL0VsRnpiTnB2dXBOaXEvaGtJTEFIMXYzSVVSdXNKZmdkR1QyYWdMU1B3?=
 =?utf-8?Q?DewMHgT/sG2vjsnQiTTDHIhrQ?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 15:58:19.9636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 692f31a4-fc8e-4cce-4719-08de4ecebe8f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR07MB10519

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v1 AccECN packetdrill selftest patch series, which
includes several test cases used to verify the functionality of
Accurate ECN spec (RFC9768) under a variety of conditions.

The used packetdrill is commit 6f2116af6b7e1936a53e80ab31b77f74abda1aaa
of the branch: https://github.com/minuscat/packetdrill_accecn

Best regards,
Chia-Yu

Chia-Yu Chang (1):
  selftests/net: Add packetdrill packetdrill cases

 .../close-local-close-then-remote-fin.pkt     | 25 +++++++
 .../accecn/counters/3rd-ack-lost-data-ce.pkt  | 22 ++++++
 .../accecn/counters/delivered-2ndlargeack.pkt | 25 +++++++
 .../delivered-falseoverflow-detect.pkt        | 31 ++++++++
 .../accecn/counters/delivered-largeack.pkt    | 24 +++++++
 .../accecn/counters/delivered-largeack2.pkt   | 25 +++++++
 .../accecn/counters/delivered-maxack.pkt      | 25 +++++++
 .../accecn/counters/delivered-updates.pkt     | 70 +++++++++++++++++++
 .../accecn/counters/ecn-field-updates-opt.pkt | 35 ++++++++++
 .../accecn/counters/noprogress.pkt            | 27 +++++++
 .../counters/sack-space-grab-with-ts.pkt      | 39 +++++++++++
 .../accecn/counters/sack-space-grab.pkt       | 28 ++++++++
 .../accecn/counters/tsnoprogress.pkt          | 26 +++++++
 .../accecn/counters/tsprogress.pkt            | 25 +++++++
 .../accecn/fallback/acc_ecn_disabled.pkt      | 14 ++++
 .../accecn/fallback/accecn-to-rfc3168.pkt     | 18 +++++
 .../fallback/client_accecn_options_drop.pkt   | 34 +++++++++
 .../fallback/client_accecn_options_lost.pkt   | 38 ++++++++++
 .../net/packetdrill/accecn/fallback/ecn3.pkt  | 12 ++++
 .../accecn/fallback/ipflags-drop.pkt          | 14 ++++
 .../accecn/fallback/listen-opt-drop.pkt       | 16 +++++
 .../accecn/fallback/multiple_syn_ack_drop.pkt | 28 ++++++++
 .../accecn/fallback/multiple_syn_drop.pkt     | 18 +++++
 .../accecn/fallback/negotiation-bleach.pkt    | 23 ++++++
 .../accecn/fallback/rfc3168-to-fallback.pkt   | 18 +++++
 .../accecn/fallback/rfc3168-to-rfc3168.pkt    | 18 +++++
 .../syn_ace_flags_acked_after_retransmit.pkt  | 18 +++++
 .../accecn/fallback/syn_ace_flags_drop.pkt    | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../fallback/syn_ack_ace_flags_drop.pkt       | 27 +++++++
 .../negotiation/3rd-ack-after-synack-rxmt.pkt | 19 +++++
 .../accecn/negotiation/3rd-dups.pkt           | 26 +++++++
 .../negotiation/accecn_then_notecn_syn.pkt    | 28 ++++++++
 .../negotiation/clientside-disabled.pkt       | 12 ++++
 .../negotiation/negotiation-connect.pkt       | 23 ++++++
 .../accecn/negotiation/negotiation-listen.pkt | 26 +++++++
 .../negotiation/negotiation-noopt-connect.pkt | 23 ++++++
 .../negotiation/negotiation-optenable.pkt     | 23 ++++++
 .../negotiation/no-ecn-after-acc-ecn.pkt      | 20 ++++++
 .../packetdrill/accecn/negotiation/noopt.pkt  | 27 +++++++
 .../negotiation/notecn_then_accecn_syn.pkt    | 28 ++++++++
 .../serverside-accecn-disabled1.pkt           | 20 ++++++
 .../serverside-accecn-disabled2.pkt           | 20 ++++++
 .../accecn/negotiation/serverside-broken.pkt  | 19 +++++
 .../negotiation/serverside-ecn-disabled.pkt   | 19 +++++
 .../accecn/negotiation/serverside-only.pkt    | 18 +++++
 .../accecn/negotiation/synack-rexmit.pkt      | 15 ++++
 .../accecn/negotiation/synack-rxmt.pkt        | 25 +++++++
 .../reflector/2nd-data-as-first-connect.pkt   | 30 ++++++++
 .../accecn/reflector/2nd-data-as-first.pkt    | 24 +++++++
 .../3rd-ack-ce-updates-received_ce.pkt        | 18 +++++
 .../packetdrill/accecn/reflector/syn-ce.pkt   | 13 ++++
 .../packetdrill/accecn/reflector/syn-ect0.pkt | 13 ++++
 .../packetdrill/accecn/reflector/syn-ect1.pkt | 13 ++++
 .../synack-ce-updates-delivered-ce.pkt        | 22 ++++++
 .../accecn/reflector/synack-ce.pkt            | 28 ++++++++
 .../accecn/reflector/synack-ect0.pkt          | 24 +++++++
 .../accecn/reflector/synack-ect1.pkt          | 24 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/close/close-local-close-then-remote-fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/3rd-ack-lost-data-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-falseoverflow-detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/delivered-updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/ecn-field-updates-opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab-with-ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/sack-space-grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/counters/tsprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/accecn-to-rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/ipflags-drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/listen-opt-drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/negotiation-bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/rfc3168-to-rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/fallback/syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-ack-after-synack-rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/3rd-dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/clientside-disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-noopt-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/negotiation-optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/no-ecn-after-acc-ecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-accecn-disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-ecn-disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/serverside-only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/negotiation/synack-rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first-connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/2nd-data-as-first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/3rd-ack-ce-updates-received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/syn-ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce-updates-delivered-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/accecn/reflector/synack-ect1.pkt

-- 
2.34.1


