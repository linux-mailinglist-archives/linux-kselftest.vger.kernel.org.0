Return-Path: <linux-kselftest+bounces-36374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490BBAF696E
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 07:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC41D7A07EC
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 05:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49D28F51F;
	Thu,  3 Jul 2025 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iIvQ9k/z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F212DE709;
	Thu,  3 Jul 2025 05:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751519916; cv=fail; b=OzhxZtju7nh/OP7PZK9cCSPBXhR19+fxd1SVNHLfBBtxYJgTt/p2R2GaLtSRJNv+EPeR4jF1X569nA9qSOmyI76PgB3PYQqfgpsWJcbF1s4COArBYsWCAJKsGfIkxCqKVsuYxlhn/bEmm+TGDXPuDROg6sONn7wz79EFWHy2QOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751519916; c=relaxed/simple;
	bh=IJghDTmRZaqhNKb/ysz16NCTY8yRQgVnxTV1XqIETXc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DXGTPb7588IDyJnl/G18p805Ru84YSvAnw8Twp24i7vUvvYYtz5413eCSQsyN5FFPrQex+ayH1CzZWENhynteT2R0fhpH0rNRD7L9neHfxP4ahZG3+iWZOKL+1mLMkzreNjfC8yTN+4qiKT1nxd/Ku4k1/SAi7ZWrt5a/aehmt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iIvQ9k/z; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYYaJQ6MeTT09Hbt1FLpOIX9AyEo3oqy0rEsjgOdXroKwC8YZpKJ1Zqh41kRKKhoxVNYDO7QLImjp1THblSe+R8UAjbSyBdqPfPlSDq5zRKfRxebTcyZ+vpp315Ay7rWnLEh1HrJN7L7b/kQBM6G7hB1jS3lDI7fJmk3Vm5iMvBnxS8/3GkcpfC2XFOq4LZ8xA/MrPwBwhm7mb3Te0o98vpwnn6WNocUiecc3P83/R+yShXi0SpLPHg0U0G/LIZOo8lsLX1SSlKiv2kBo4+KxvMrtLcAbnrpa+7q+D7jRQSK4eZ97gvRY9uywVYnL/sIWJnHNWutMHHUWc4I4H5uYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZN+jo/zhOX8i4DNomE0xmADVbWjhmhk123ww16QMZyQ=;
 b=YlY1Q7nvI9/pD5aMgoii9q8zqofQEHg+btqLAzIU6MBYIDiKd4pSDx1wdaqWJtIs5BdiAD3+TCkU+tqrO3Qo8RQs8eMKhgiOFUOrGSYpcQpOF9kZwVkfKLrpb2EDZOCBDLxAOlJ6cayGu4YNgX5DFNqmTgtJz/2y6DxH/rFJpXVwjYNxPLpUZXD0X2P8qJ8ZEThAjm+E9qyKuLUoORQ+0+rf5eU0b55Fscp5qqySubFGB6hnQYX6FYYNGK2Rkk/Q+uOChuLr02Ci1QNfqZ3NC0B5vWMcMhW54rE7vd1E01G0yDw8Dzw8QEYvkAMzvNpEwlS48HGuJ9ZqUxO+L9flig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZN+jo/zhOX8i4DNomE0xmADVbWjhmhk123ww16QMZyQ=;
 b=iIvQ9k/zMIwvynpJa6f7eskD2erCvW3/X1oA3bC3hivBadHmVc2N3JJ+BXeQoEIkHWtIQWvz4JcJh4qAcyRZuooMzdRAm4TLW6dPxYYXZBRCoKaBpPoTN56LG2qr8sFjnrqLjaSxpqWiitvkTctmfvJbV5ltaHp9RG7vrRE/tnqFBkJK6qf78cn+1woYO0h4R8/LJAIhjQEyBq9ZcCDwnC1zyLmUEvfA1gYrYWga7uEUEx+bIaMVPg0Tc0QIStGXMuJmI99n3DjYYRlGSz3x3DManvpFgoL5JeKZuLYHrAu9pG7ZWTRZhCVcG/YBL7q0qlBjdpblzSIwwAiyX19eDg==
Received: from DU2PR04CA0215.eurprd04.prod.outlook.com (2603:10a6:10:2b1::10)
 by DU4PR07MB10418.eurprd07.prod.outlook.com (2603:10a6:10:5ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 3 Jul
 2025 05:18:27 +0000
Received: from DB1PEPF000509EA.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::17) by DU2PR04CA0215.outlook.office365.com
 (2603:10a6:10:2b1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Thu,
 3 Jul 2025 05:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509EA.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15
 via Frontend Transport; Thu, 3 Jul 2025 05:18:27 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 2EB55200BF;
	Thu,  3 Jul 2025 08:18:26 +0300 (EEST)
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
Subject: [PATCH v11 net-next 00/15] AccECN protocol patch series
Date: Thu,  3 Jul 2025 07:17:13 +0200
Message-Id: <20250703051728.37431-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EA:EE_|DU4PR07MB10418:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cd9524-550f-4ce3-bd5d-08ddb9f10ae7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bk9NR0RQWWF3OVRoNW5RdXFvRjFNczgzdldzbEN3N1NrV1g1c1llaE9aeEUz?=
 =?utf-8?B?RjJSSExIelZ4T2JhWmtSK2RkMnhZdy9mSWg4MlBmbTA3UCtNbVRRdUFaRWV6?=
 =?utf-8?B?cTIvSVVROTk4Nk1nZkExYmtaNnNXbUdsOVZVZUp0WWdXemMyellKUHhweC9l?=
 =?utf-8?B?dFBxeWR4aldYd2JGMnpxSzNkT0gxS3FUWEtxVkFzMnp1azFwL2lXYjJjWGlU?=
 =?utf-8?B?NDJwSklZb2lnVmM2N3hSR3lHQ01VcWdlUFdHWUZVMTRWMjQ2eFl4RWtDaVYr?=
 =?utf-8?B?OTUxOVQ4UjZoQngySGVaeU10UFNndk9XcTRrYzFJaG04eDdoWVhKMjgyRXdL?=
 =?utf-8?B?dWYzWHdNMDZUUHJ5Vy9XSXUxbGs5OEJFNjZRck4vdE9nRkZYL0czbmhOd2I3?=
 =?utf-8?B?M1hPSWc3SzNRRjVSKzE0YkM4NXJ5UlE0bkFKNmdYSUJkb2tQMElXKzJYNnFO?=
 =?utf-8?B?RGc4YVE0bVJGeVBSSm54M2Q0aFp6cDVZVjhuY2tQakwreXQvRzBWZlB5aFdn?=
 =?utf-8?B?VklCQVo4V3NuT3JjQjFtbU50Y05vbUFPQnFlQzl6Y3NKVG1LTEdsc1RrQnRV?=
 =?utf-8?B?Kzl4Q1E3NVR4Ulh4ajdnZFIrUkFLZkFpZUFlQTF2N3F0dGMrNVlEQ05NMUpF?=
 =?utf-8?B?blpoZHpuTHNpcUkyTmZaQ1hzSStzOWQxNmxVY2lzbWtDb0JWK3lqWVlEQWJK?=
 =?utf-8?B?RHhFL0RqOXplaDBVNjlMbGpmdWtnVmVaZndTUmkram1KbUQ3OWFZTHFNL0lL?=
 =?utf-8?B?SHZ3WEdpK3NpdWdvWTJhRUZwczdwZWhrUytMU05BdVBwL281RFZ0cmtIbndn?=
 =?utf-8?B?blU2SG1NSktqNURjbkpySjAwYlRvUkRqM2FTRnZ4OXBnTEw4bVlPT1NqVGpi?=
 =?utf-8?B?d3pRN3dpRVRyeEVSUGZXSjhCblFiRS9BRk90OXo5SFVjSEFUckZGemxpK21t?=
 =?utf-8?B?UGgwR29lWkNiTmM5Q0YwTnpGMjdxUy9TL2tvNzdMR0NrSVovblNZbnZUZklh?=
 =?utf-8?B?Ri9JK0N5MlpkTnZseXVDZ1ViN1dUK2ZUeitkSkIyY1BVR1ozeTcvZXVOalF4?=
 =?utf-8?B?VkxSYVhaZ3JmdE1uKzRwcVptYkRKZi9VSmtBeFFraUozczBhSGZLei9wUEJa?=
 =?utf-8?B?bjNOMDRkcjloU1NveU1vTEJyVnNOVFA4clpRTUtNckg2UzkyWDh5L1FNMmFK?=
 =?utf-8?B?QWkvbXRwMkE3cHF4VnB2eVF3d2NaVGNGS1ZGT0tQQTZwblhCOXNYMUdKc09z?=
 =?utf-8?B?azdoMk9ZV1daZkVKbjNKVVI4N3dlRXV0YW1Ldy9rZzVocm53Wk5tY1V5R1Yr?=
 =?utf-8?B?OTRjM0o3NXptcG9GdFpuaWdhOFJFMEtxZFZqd2QwbnlRVnNGWThCbkhwUTUx?=
 =?utf-8?B?SVpzQUduZVFEZnRKL0pYSzR2ZXkyd0ROYmdBV3dTYVRpWnZ4a1Mzc3VxM3VW?=
 =?utf-8?B?NkI1WWRGZFAwOWYrMFZKRWk1MTFEM0hJbUJ3YmplQVBCbklnVlgxWVp0cDV0?=
 =?utf-8?B?S2xrK3JPK1pKeE0wc29ISzRlR2dPTmZsVkhnTzQrQXZhMEo1bDZVRTFsdHIv?=
 =?utf-8?B?TlRBUkRkQi9CZlQvOFpnNXM3ckFaSWRLcGtxMGNNdkpsZGxNWFE2bFlVbThF?=
 =?utf-8?B?S2ljdlIyNFZoQmEyK1hmakozdDRscTdMWTNJQmhOcHl3ZTM5MVpXVW9wc1Er?=
 =?utf-8?B?eklkaGlpYlYzM05vZVFkT3NDNmkvbXdkcU0wd3pJQkxqd2xtQlpuTGtPdEhO?=
 =?utf-8?B?MWcyZTBMVWY4SXN5UDVXc3hIZk1kSFhQNE5ZKzJoNlJDOUdVN1dPMlFERCtR?=
 =?utf-8?B?M2g0QVN6cG9ERUszWm43TmNJUkZKdVhndFQ5enV3dHYvZ1M2TE9UcEdjUjl0?=
 =?utf-8?B?NElYbGNvT0ZRK0luTDIzeTVwc0xUaDBFK0FjWWZEVGJSdUxIbVRxMTVheE5z?=
 =?utf-8?B?eDRBMzd5SjdTaXNoMHNRQ0pmSk5hL3pDYzdBaFBWamsrVEsyM2ZpZEl0R3Bx?=
 =?utf-8?B?bXFzTndheGxxOWJUOVVSa0JSZy8ydEdhOXg0cTI1OGN1ZjQ4S3lLS0JqY1VP?=
 =?utf-8?B?U0FxYWxQNUFHQ1d3cEw5RXBubE00RndwRjR3QT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 05:18:27.6888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cd9524-550f-4ce3-bd5d-08ddb9f10ae7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EA.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10418

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v10 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
v11 (04-Jul-2025)
- Fix compilation issue of some intermediate patches in v10

v10 (03-Jul-2025)
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
  tcp: Add wait_third_ack flag for ECN negotiation in simultaneous
    connect
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
 include/net/tcp_ecn.h                         | 648 ++++++++++++++++++
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
 16 files changed, 1429 insertions(+), 187 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


