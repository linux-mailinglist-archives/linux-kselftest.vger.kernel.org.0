Return-Path: <linux-kselftest+bounces-39071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60590B27B56
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 10:41:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29EDFA21F36
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286CD27815E;
	Fri, 15 Aug 2025 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aJWfCVs3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16C2257431;
	Fri, 15 Aug 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755247190; cv=fail; b=KNBtAeXZVOgG1eydOaC6EU87tcmYAp9wgyz4SHNPpzPvaKbSGqxHzhNPsp1tyXPX2tWkOkRJ8QHRUvTntUyCLdU6jrSm3EqzLz1wfyBK++FoLQKP27sXfZHPlFpHbTbB+qDvCNWXgnoE9xf3O5oe47+KkR+p5wcw4ApPlXIKx0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755247190; c=relaxed/simple;
	bh=Wb0Vllp9jhnJkv3QBw2GKYHJYvPC0eX9labZYhOs0l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CRoL7Oi8eld+RoifE+vDa3/CntyND5wgbDhkYYxxvOeKIqvPvLA6rDPs4mRhIbKf0a8X9qRT4ABFBIPz4tF6yu6aSFkpQFdGfzmA27WVkGSHKCrnkR4ulh8zYYHuGeA1Wr5tFdzaaigcvI8LtQF5kKUmIPbAFWHFlvhip9861pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aJWfCVs3; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akakLOX3FhjXbYl/OU8liXpZAecB6WrXRUva9kAT75fO7eUDVEn7JRPgc7vEOYu9hkBBjEbFIaoCuEncn+VMhaDnDYcf2svIBIPXwlMhi8Iv6H2X2k0xu5VOB42CgnsXycqmyBotNlT+d7NW89ItrwkG08ZfqwzXhdW0Vm6E5SPw2i8jRejw8GHuov3sb1nM4MYuztPRjaGf1eE+hd51cn+qqvHFpDlUC75FEeYBHwsi/oC6yrpAiCw/1zJDefAPv3/HCJqIOfaBbPDkATmn/luSd+WIuTf0wDE2uM/KNyajjz7BX38MytzWpTrp8Usd7BIeUGg+8+rXMRzlucCtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MS2ssKuCL7wUei6f2ZxHsMzfgTAYG5nBXWw9V6aartA=;
 b=XYbzLjZSue9rYxHB7nSGFq/U7gBy0U6VY+rjkJxuKCP/3wk8zO4gE9DVNHUCEXvJyXp0FlGwHSV8tCgke4ksJTn0aotIBOlG59A+j6vndQ9xsw4QRap2MdYESO8oXPnv9mNVJ2wZOGqEVp7pURswXu8tr3yBRCBnrahbQLpMnAJig56IMqNldUZe6y20FH512rivgz2i3mBJXCBv6bRXJjFWyejbMHsdInX7HqsNjlCsvoz2hDt5368zhTtBpeaFu4VVVjU0z2nEVLp6I/ZshLw+MkhGdby/irOEJB43de0OKEQVFe3QBhMKO+1VQzfPaWGpgCFR8X1Q0Jr91qHSPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MS2ssKuCL7wUei6f2ZxHsMzfgTAYG5nBXWw9V6aartA=;
 b=aJWfCVs3RQjPyt4djTrmn2y4D6/eesUmXMA75CAJwAT5eF8tSLY5TfRJWS2KRA0G+apjdUlTrmzvM0eLMuZt8JWZyg2XEx3jDiDeOTdZ37ROJJGve5k7wqwg9uP2LNpAxPUSJxGvSjAcV8SV8f0KD3HaQ1tce+W02oDuOqGaJBqWGlguCtdM8xAQ26gIZtPMXwT7cOT2ksymYTFWd98KoBK/jOU3BTyOoSBszouBxYcoljqwQeY3ZQN5dxLBvUTxFWDtu8TCOY6iyDkDYepyEWJ2hMubzravzaaIOEAl7NnYAnAs6MSZYwxKW3zxAHKx9fL3CHr4vBrpQGxBt8KQMg==
Received: from DUZPR01CA0259.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::7) by VI0PR07MB10151.eurprd07.prod.outlook.com
 (2603:10a6:800:264::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 08:39:41 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::e) by DUZPR01CA0259.outlook.office365.com
 (2603:10a6:10:4b9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.18 via Frontend Transport; Fri,
 15 Aug 2025 08:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Fri, 15 Aug 2025 08:39:39 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 7AC3E1C0054;
	Fri, 15 Aug 2025 11:39:37 +0300 (EEST)
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
Subject: [PATCH v15 net-next 00/14] AccECN protocol patch series
Date: Fri, 15 Aug 2025 10:39:16 +0200
Message-Id: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|VI0PR07MB10151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6dfd79-bb7c-41f5-db08-08dddbd745ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MFBpUXFzenpBci9mQmdxeVloenFid3BBV3FRMlVpZTRVcUJoanQ0dmlER2F6?=
 =?utf-8?B?V0VkR2p3Q210OWRsL21LWmFqelRxTVlDMUdaQ29HRGZwMlBlcm9PbkNNclY0?=
 =?utf-8?B?YnIzdEN1ZnZuUE9pVWVoZUdpcUJqd0J6K2loMFc1eGpWZWtmQ3VSR1cyTFJw?=
 =?utf-8?B?cGNFWlFSOGJOdXlmQmdzdCtEOVVOb0VOaGlzVlBLdFhPRUFMMEU5dEZiSVBL?=
 =?utf-8?B?ekpZSnhvSUNkRUkwaEh6akQvbWFVVnRDOCtXNUtBWGl6TTI1dGxIVG9BZWVi?=
 =?utf-8?B?RnF5VkhUYzBYakxkVy9FY0diTGpNaHVoUVNzcmZXODhLZ2xZU1lOZXMxU0Zr?=
 =?utf-8?B?TkpjM1BTTkZlOFNlTktKMEswT20vYnU3Zm9iWmZXYjRDenU0NFFwY3BEMDc1?=
 =?utf-8?B?akw1dm52WFB5aDN3NWdBdTA3d2ZSZHBpSm1FUStyaDVjZ213T1pqMDRRYkx0?=
 =?utf-8?B?Mnc4Wm5GQ3N3MFU0bFNjNkdCcUdOazZRalhsOCtybzhKSDI0OWdTMzkyQzdN?=
 =?utf-8?B?d2dBa1VEVzBOUkdXU1VFa2dsVVlaaHV5dnBhenh2ZFJSYVNTa2JDclptSUg1?=
 =?utf-8?B?RnErZkYzTkp4KzNTcmdEU3dyZFJJWnZwWVpPbFd4U1dMNDJmT2xHNHR4bzRZ?=
 =?utf-8?B?YjY1b3BOZUI4VURBa2t0WTR3WFhwaE1IY1V3R0h4UzAyVXc0dlpReVp3MGRC?=
 =?utf-8?B?aXBTKytuRVNSTnp1M0ZYOVU2T0RnMkhaaEc0MURYS25ZQUJWMzArVURvS1VP?=
 =?utf-8?B?NnhSb0Z2OWlZcGhBOTBsREtnWW5tYm1hMUtQWXFqaUVSdThsSkYxSWNRYXFZ?=
 =?utf-8?B?WEZlR3ZHSVhDYXBYd3FoWHdTOFhvUE5MbTVSN2FPdTE0MEVFbERvR3lwRjli?=
 =?utf-8?B?dTY3Q2RaMVRUeTA4bUVrZWQ3dThsK0hBdzhrZW44Z25aRVNUaFAyaGJ6aFQ5?=
 =?utf-8?B?Sk9ZU3p4SVBJbnlHYVAvNWFrK0RXcEh6elE2TkdMUkhPTnJqbmVvbldoQ1Vk?=
 =?utf-8?B?WXRHMEticUFUNjUvd1VpQU1QSEtJMUFQUGM5VjdHdmVpVjFpWDV5WFgyN2Iv?=
 =?utf-8?B?WEhIYzJhUE5VNXNFSCtadzV2L3h1emd0NzFhcE5UU2Z6UjRja05GMnl1MjdV?=
 =?utf-8?B?Z01NNm95ekpHWWtjbzFWbzJ1OEhmSEJkV3JITW5VL0hRelVsMkMwS09sU2lj?=
 =?utf-8?B?QzlkU1ljN241S0IxdzNtSFl6MjBUK25TM011SmZ4Y3V4dWU1RlNSNVdteFEv?=
 =?utf-8?B?TU4wZVBucXRDbGtuUWZONmhsYkplQUpJOTBPZ2RxU1VydnJwUnFkcHduZWJa?=
 =?utf-8?B?dE9FU1lHVys1Q2ZxcmF1Nit4ZDRWTW5XVC8xTG5FcGlCck9lcit6MWVUTHBq?=
 =?utf-8?B?aHZZZFFPQUlJcVc0N3cydmhYZHhtTEk5Ri93OWRDeXdFZWJJQmM0WUE2Nmdy?=
 =?utf-8?B?TDZwQTU5WVd3ZWtFbWx1R1VXTU81czVHQnFsbzFvK1JGVGFtdUozMHorYUFY?=
 =?utf-8?B?UU1IaTVLNUNDZ2JmZzRzNWxiWWdkY2NLOFFCVUorcWZUMVpNcHk1ajVESkhp?=
 =?utf-8?B?UGdORjV6ZFhZNis5bXdZTU4vYlZCUG1IL093OGV0RWlwN0dIaGxObW0xUE16?=
 =?utf-8?B?NWZtZUU3bDhJYkFIdTRwTTdKL2lIT2tPV1BWTHpzT1pTTUVWRnJ6dGoxRXlZ?=
 =?utf-8?B?SWh5ZUdZYk5pQVNaU3IwNkZ1OHdqQmVjYXRUdVR3REZZaXJUY1dsYkJsUXlW?=
 =?utf-8?B?c3BkNy9rZEk1THJtYzBYVEd6TW5LaWdyT1NXM2VCd0FhcnVsbmQ0YzhtV0px?=
 =?utf-8?B?V0R2R0FaNlpDUW13azVaWm5ZQi8zeG10dUMybVFHRHl3YS90R0RMaVZxNWpV?=
 =?utf-8?B?c1VWYW5iMFRkb1hFaFF2dVdXYU5FRnFJZ2R5Yk84dTE3MGdmVEdUWS96Ynk2?=
 =?utf-8?B?VmVyNk9MQWhpVmJwWUR2Umhjb09zM2FlenlyNHpjNW0zSzBEUW95dUxXOElk?=
 =?utf-8?B?bXp2Q2NMcUJFNEJ0elBBeFY0V0piYXBLMk5Lam42dGNlVWZJdXp0Y0g2dzdk?=
 =?utf-8?B?TVlJdG50aitRYWRHbEpBcGJlaGFwdFdQc3hMUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 08:39:39.0005
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6dfd79-bb7c-41f5-db08-08dddbd745ba
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB10151

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v15 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
will become RFC9768.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
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
 include/net/tcp_ecn.h                         | 649 ++++++++++++++++++
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  28 +-
 net/ipv4/tcp_input.c                          | 353 ++++++++--
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 294 ++++++--
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1409 insertions(+), 184 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


