Return-Path: <linux-kselftest+bounces-41578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E391B5905D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 10:24:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E41188CC2A
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Sep 2025 08:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E6D28850D;
	Tue, 16 Sep 2025 08:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RFMiLXlu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4788728488D;
	Tue, 16 Sep 2025 08:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011086; cv=fail; b=g2xnt+rxN2Tqtw8OcYdrUTCM4FRXrjYqkXY9VFmwv4hhNrjJH0Ob5KYZAKAyyOywTAek7TB/RKvigTd5NdnCuENVH4oAJZfYdP550jdtcoYlSeGSCrhvLhWHi/WFzLNsSqPRXZw8U6DqleNGf+OBtJGjpUcWKbId4JR47hU5Bqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011086; c=relaxed/simple;
	bh=ydCDJvEQB+B14hiwhB5RFrcWBAVRK3bbkDblYQADqqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Iznrw55onkMfLkLTTcu5Yclp5YVH8Huq2wb4n2lbfhqshBxjxFDYM0imNRIEdvhna2j0hR83pgtDZ4ryhUO7a9y6sbFbkKyaV6+JRymBpRl2LTq+lVanczUWdsGVUlRqo8KLmTmd4E2poRyr7jc7CEHP0wFkUsYAdU9sQaNuoy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RFMiLXlu; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyGEPOyFMaSbV8cn3BlK/H8E2Ru7z3ry/aQ1lbBb8K97W1ZM7wG3xj51YqzgiRurB4OczpG2LJHxehhoTZM8pQJ1mIVA9g6EP2+nh+jApmsGu4XQ2Jt5DBMWtkQtX0BLFJtg2NRwIybqrZZvo8QWdsAOOaULCN9Ue1CwPEoDBptz+dh3i3Ls8ydM9IkcCtW/R29KDwxet1G+EJENyzlj/wHuial5mjtj1l2Fl2SeVK2Z3fs0OIFdkE03RfXICaok36F5oVjqlYKAWUuOOCqkv0y+6NxqXDvkA/w4gVioC3pyEkpiA1thGIfJhUBU0xRSFfIL+6dJjTrLzxeYrc1PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We13C3/aXP/Rot5ZsgrUeTxpZ+Mm9/RPLhyGu+mejhQ=;
 b=YFbboWkEzzUhrSJFrb6/Dura4uvrO51Z9erDtRPZuW/C/m5wbWF/i1Axi1zLcYCHH3lz64518Q88c1mAXqhfStz1BOs8QfdIzQ1LJxP7arvStu2yPaYeliEisufxIwr8xZWteKnaFWIGXDL/a6tu2wkk0RJgXOVwS7fn0M/f97cftHOBfjAL3x5N9N3+bIQmDqSvZNLsB/kdx+N/emvXJVpLiIboREZGZ8qD3KBNYdP9ZGQJiyAKwWl+EJRgd5YJJrqv8NktHtyVAld0MRi6Wy1rO5DXL3+xFjT5cOzxkZua5S5LvKes/FTdvnVky3WjSG8ed07hKUI4yO2WC419Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We13C3/aXP/Rot5ZsgrUeTxpZ+Mm9/RPLhyGu+mejhQ=;
 b=RFMiLXluAy7WalGNzwY40AW/N6wgtYjonk2pjM243aYtRRYHlsCj8voJ4qVA4Ppsjks2lrlyFlw/ttNProT/Gieq1WlsqrRq5HpveR5AFkGjZq9OeTesj8WD0WvoqcCL0Iu8cankclFXmG4xFc5wKDjD9OtUu1J52j4XVqHNmLQf+5mm5mKcBZmw7WPhinx+gcoF7TZVjNN82Y5siALMaPNaE/Bb17W3tqnW8vqSuObGsX92dGdGDtXR+kVQBJlGSH1oxXV3a2w5fxWMjJ1jR193LVlIWopYMO/uMVNpN0un4dPRXGjJgEIWme0j1K6u+6NIJEeoGFYvfzAqrwP8kg==
Received: from DUZPR01CA0311.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4ba::12) by VI2PR07MB10909.eurprd07.prod.outlook.com
 (2603:10a6:800:2df::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 08:24:38 +0000
Received: from DB1PEPF000509E4.eurprd03.prod.outlook.com
 (2603:10a6:10:4ba:cafe::5a) by DUZPR01CA0311.outlook.office365.com
 (2603:10a6:10:4ba::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.22 via Frontend Transport; Tue,
 16 Sep 2025 08:24:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB1PEPF000509E4.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 08:24:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 7388E20230;
	Tue, 16 Sep 2025 11:24:36 +0300 (EEST)
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
Subject: [PATCH v19 net-next 00/10] AccECN protocol patch series
Date: Tue, 16 Sep 2025 10:24:24 +0200
Message-Id: <20250916082434.100722-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E4:EE_|VI2PR07MB10909:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a10e32-9655-4862-312a-08ddf4fa79e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2VhVU80dkhnTUVkN3NmNVYxMldmQ2xrV1NJUjZqdlBHL2d3Z0Q3d01HNWhV?=
 =?utf-8?B?ZE5YMndxaEZpRDRtNEk0LzNIb09kRWc4NGQyM21GTmJBRXBBTTM3WlIreVR3?=
 =?utf-8?B?dVJ2eFJmdzVST0lNQ25rYmVlUktCMnJVY3NVZ2dpdzA4eW1DT3Fnemw4dGQ0?=
 =?utf-8?B?aUY2M2dKRm41SG5aRzdlQTd3a0NaK015dzErNVlwN0tmVW5zeFY0cnhWb2t1?=
 =?utf-8?B?RDNMd0ZXNi9UQWFaU3BISXNZaVBQdXhBQlpVMlY1SFdIN24xU21Xa3B0MU9z?=
 =?utf-8?B?OHdUSUowRGR4ZDlYdXZsalFkRlpoNnNDYWVJVE1xSnIvQ015N1lOTWdkYzYz?=
 =?utf-8?B?aW9HQmJjWFhxYU8yVld5NTZmSjYvVnBWNUhwNFA2WkcvalN3VzluR1BrRy9R?=
 =?utf-8?B?MWxKcXF4K3IzVEhzb3paY2cwQzJuMHJ4Vm9Eby96YXVHRzMyKzFhdkJUMlJU?=
 =?utf-8?B?Y0h1WUNIeHoramhmTGdiVXVoQUJhcW80RC9lK2xqSUFXbGsrQVR6ODRKcExD?=
 =?utf-8?B?ZUNwdG9kTTlrL01XUGZ1a3h6c2U3MzBpNmdkZDhHM0dqMVA5NlQxb3FrTUw4?=
 =?utf-8?B?NE9xYTVvSkg1c1lxYUhWcHlpTHNiN0VyNkJFY3RMK1J0V2htM1NPamJGYndB?=
 =?utf-8?B?Rm45SE1wV2NaTHVIUDZqR3ZJek9oV3BkV2tnSTF4U2tkbmthZnhHV2poTlJK?=
 =?utf-8?B?YjVZUWdCbzhxa0daaHE3U3lYa3NUa29NVEI0S2hkWmdxdkhWQmIvRDVNMEpk?=
 =?utf-8?B?N2RzTHlOWGVGMlp4RVJkenNEQktJcytNUkNNTTBmcFVTM1NvVktwdlc0RCs1?=
 =?utf-8?B?SVFxM0RlaDhHdjEvU3NBTnJxR1NPc0xiaFlJaEhLU3BHZm1BeFRqNWxpcjN5?=
 =?utf-8?B?Rjd3Y01UamJsajRDa0ttUTU1OVFaMldwd1lsU0srWEQ5TWs5UGFTd3FSNTh4?=
 =?utf-8?B?SmhKRkdudUEvYVBobzY3NFRTZHlpQ3hEMkp1NnpzSVd0OUp5dUFTT3luTHd6?=
 =?utf-8?B?b3hNVFl4dUFvUk9Id01zWjEyTEc3cEJHMXF6SmxzY1dGZGovWlhtMkk4L3pL?=
 =?utf-8?B?TWpFRFpnTW9qTEl4TllrVUVvalhuSmxzREFVNXlqMTgwZFR1cTNRSDBzL203?=
 =?utf-8?B?NWtTZFJBQmJBMFJCaEhDa05td0xEZ2g4UlpRSjRWOFh4TldxMWRvUnlMVkhS?=
 =?utf-8?B?UXhrSE9pQ3VnOTJtVit6dzFIWHovRnVXeEMvdUg4MmJoYzh5eXhXTFR1Ymhm?=
 =?utf-8?B?MHMwZ2l4MUo5WDl4VjNKUVgxblE4RWE3Um5zaExzN0pSM3RwVTJvdnJtV2Ri?=
 =?utf-8?B?cisrV1FqR2wyZDBsdEVlek1KY2FQZitRbmEzbWRGUzNWSmJsMDRmcURGdVdq?=
 =?utf-8?B?R01jNnRiUFhjMzl4SGlJM2d4YitVY2o5UHNidThHV21tMjFkUTNpSWFDZndT?=
 =?utf-8?B?NEQ0ZWtHMUExNjhWZDVGNDM5d0tMZGRmSkJLT20vUFR1aHFIbE4reEdRSE5w?=
 =?utf-8?B?TjU0MU1aY1Mvdm5QRm9HWUY1ZXpRZmdYSldjSHJ6WUhDN1drNk8vaHprQTVs?=
 =?utf-8?B?R3BmV0JLNHZzZTdZUnFiaWF5NVNQZGJ2SDRvWVBFeEpvMHd5bzhJYW4vUndT?=
 =?utf-8?B?eGx1VXZjRE0wK0IvNk1kdkZncDFQV3psU1FRNm9IeXNkaGRFMk1BUWtoVFdw?=
 =?utf-8?B?OXpTSHpyOUhzMWM2YVVCYU1SenhJQm82TzJScDF6NStFZjFxaFZMUGVqZFYx?=
 =?utf-8?B?UHQwSTNYSjRROWxGWEtBbU1Yek90WW1OVnBXd0hxeWI0Uzg5VW9kYWh3OGNz?=
 =?utf-8?B?M2lIbTY4R0dtbzRFM3IrdlhzeHlRa3drYWVxb0lYMEVjL3Z0ZFVvczU3ajR0?=
 =?utf-8?B?dk9qcU5Xa3pDcUZOZkM1TldMQXJKUFUya25CcWdjaHg2NitYSDFQUEloQzZy?=
 =?utf-8?B?b3JUTG9FS1MwRzVNZ0dPakdqcDJUS1pUenhMTE5OSzllUDNVTmFVQ0NhMVVG?=
 =?utf-8?B?amNEN2cxMFBoVlZUT093NlJ2TU9JQmdCN2tpL1JZcVBQWENaQllaR281bnlh?=
 =?utf-8?B?V1B6NER6MWFYbEo4V2d5cGk4U1lWT243Z2JEdz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 08:24:37.9675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a10e32-9655-4862-312a-08ddf4fa79e4
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509E4.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR07MB10909

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v19 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
will be RFC9768.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
v19 (16-Sep-2025)
- Repost remaining 10 patches in this series, as the first 4 patches are applied (Jakub Kicinski <kuba@kernel.org>)

v18 (11-Sep-2025)
- Reorder tcpi_accecn_fail_mode and tcpi_accecn_opt_seen to avoid adding fields in the middle of tcp_info (Eric Dumazet <edumazet@google.com>)

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
Chia-Yu Chang (3):
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option failure handling
  tcp: accecn: try to fit AccECN option with SACK

Ilpo Järvinen (7):
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option ceb/cep and ACE field multi-wrap heuristics

 Documentation/networking/ip-sysctl.rst        |  55 +-
 .../networking/net_cachelines/tcp_sock.rst    |  12 +
 include/linux/tcp.h                           |  28 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             |  33 ++
 include/net/tcp_ecn.h                         | 554 +++++++++++++++++-
 include/uapi/linux/tcp.h                      |   9 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 318 +++++++++-
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 239 +++++++-
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1278 insertions(+), 76 deletions(-)

-- 
2.34.1


