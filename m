Return-Path: <linux-kselftest+bounces-41228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3F6B52F54
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B441895BE3
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8392C311C1B;
	Thu, 11 Sep 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GtgJOvYF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013034.outbound.protection.outlook.com [52.101.72.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D3F3101C8;
	Thu, 11 Sep 2025 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588812; cv=fail; b=CIx6qbRKa5N+l26OizwwDTlVU/pLcsjudV5ala8Jnfd4pCXYQmStXaoO4kNQdcojkQSEkTkNqrkRsS3FUDOCluRoR6aR51cnXfqSGr37qTFaXwsbap1jLphp+msOHU7rkTcUD/Pf5HL3c34QZg6M6ud+R5j/yzzzZofDQCcyFV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588812; c=relaxed/simple;
	bh=rJXJeg96qv/RM+J7L16F3PRwCxPFTIMUnxIN0u7mIRM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=LZS2bWRYRACcKdmGWOyMj4MJ5h5nxpQ+SlrI/rP1eGG9aNxL5FNo+E+MPy0rpMxuUgPd6l4ae2pppJaWs5glglmPt9tODFdTU2GRTl/q/AHSXyZ7vG8tP0vt4k4XJaghE0vd/IAGIfs75nyDPvKX56Y2LeU0vHH1LDledh/dork=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GtgJOvYF; arc=fail smtp.client-ip=52.101.72.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rld+seHD2F21LnKPUZ1yIYj37LsMPA80zBzJkVgcM6amJGcIT/i6u9M2ZH0wbMwvjBSajf5C/LyoYVCSktBOWHiCDhRgkwXVIaTYIsKOmNB/cNg2L0Ny4+l7wxN9bJBUqLniEpHsUl9gpCZ4Wa07O6p5wc845WFC7pcKkeItT+qcY+AtKQ4dR5FYYQbiOtRi2+77hlHkM/3Wz8jlHmp6D+GdLZeP9ksi37ujPL/H7V6iFqZ0pEYuAUOaxwF9s3xXQaE1ZQZZDhm1L5stKEc9E2HReEbrBurVJwaZl/bLiut32Qtv7s6gmTBopWHOmrSwsgt+WgWHGemBKd61cTGzTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObHc7b1YAyFB+IbIm2uu4Y85fQ9QLm/WHbNHttmEjNA=;
 b=V7feizNr5KQLXhgf8tpKRH5zQVl53DSvFvruO992+IdxoRbvedcO5LkQhLoqgg7kTK6KJncC6gF9GG0t8ahd7Zt470NWON73T/18cbZsXOssl+rRzUFUdi7lm5WGlWeEUdkJKmvjR+kWxX0fK3BmJHzXyYUjmcOBe3azCbh5dHk/6VNncq6n2u7GEPr19KqguzNQX8rNK6uCbCDEoY4qw7Gg5AG27zPvMIjRZaut/gTC5FfkB7rXiM8B47ms3euRDq0WdQ/+tcal2vhXwwlzqwoQN9FAhHm4vgAyMgEldiCZ/0l/7lQZEqXMTE4E0GunLv1hpGWWRu6gnzPtZfkzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ObHc7b1YAyFB+IbIm2uu4Y85fQ9QLm/WHbNHttmEjNA=;
 b=GtgJOvYFE+I4JaC7mPValh7KbXzArFljLrzm6AEl0uSvwphgERk2tg/56jHTx7+FMHhcPA+vfSXlEN3Y+DrlVqXAAyqyBzDJUaXEzCus+7erhjdn55RV6xTpH9Nvm+9Yj2rOFNwK83Zn7idOB0Vgo+MmkpULQhgTV/Grfi41Vf916+zbKC3xAdGi7oPpdtE9URMjy1i+YGag3S2lv04FSaY6NZoHOjnyaOpYQE8e5T7Gz0s3OXnv0gFFRo+JIooh+nlU2WXi28+eBmQRLeREZucA9zD+BZmJ4tpXQ+o6xd9Nlf++TFB2gh6BvsKBx7e7bAnW1D6EHy65n9R+bQwHFQ==
Received: from DB6PR0301CA0073.eurprd03.prod.outlook.com (2603:10a6:6:30::20)
 by DU0PR07MB9266.eurprd07.prod.outlook.com (2603:10a6:10:44e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 11:06:46 +0000
Received: from DB5PEPF00014B92.eurprd02.prod.outlook.com
 (2603:10a6:6:30:cafe::3d) by DB6PR0301CA0073.outlook.office365.com
 (2603:10a6:6:30::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 11:06:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B92.mail.protection.outlook.com (10.167.8.230) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:06:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 2D160200C3;
	Thu, 11 Sep 2025 14:06:44 +0300 (EEST)
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
Subject: [PATCH v18 net-next 00/14] AccECN protocol patch series
Date: Thu, 11 Sep 2025 13:06:28 +0200
Message-Id: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B92:EE_|DU0PR07MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f11f369-21e8-4b6e-050b-08ddf1234c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QW5BajdCMzJQZVFsMFNLYnNPdHd1cWlENElZc1NuSHB0Ri8vUTduTnhtZXZo?=
 =?utf-8?B?Y3ZrWDZKZXcvaW5SWmhZK1RYZjduSVh4a3VMeVpGcTk1SnFSUXJsVTdDT1RW?=
 =?utf-8?B?OWVRblJVNHlpbXhwTHNObmpRQmxNUXIyNHBwOHBqQjRwMEs0Z1RjTzFrTTU2?=
 =?utf-8?B?Mk04UGhkakFhRURUc3Z2dDA1a1lQVGczVUNoNDhZZHRiRnBMZFRYMVI0SFdR?=
 =?utf-8?B?Y0JBY0tMeXBoOWtaNmNLbk5VUU5jbVBnY2J3SGJ5L1FoUmFnaUJmZ1JOWXd1?=
 =?utf-8?B?ZC9YTnlNNlJFbE5lcElxT2cwYzlxQkVqRUxuSzBmblN1YjIvSmNLVjJVdUgx?=
 =?utf-8?B?c1IrZGVNdjU0RVA0cGlsMXYrUThLdEd4SlB6MHlRYTVtUzJLeW9iR21oWHhr?=
 =?utf-8?B?SnptUjcyM3lzbVNNaUE1STBUTDQyKzV5OTVOb05XakdUelN0ZGkySS9UV0Qv?=
 =?utf-8?B?eEhiNHl2MHFPZFpjUERzTzhmSVl4TnV6U2JweDdzU3U0WGlSdUFUM0hpb3lZ?=
 =?utf-8?B?aEJlWjZaMkJ4dEsyVkxwYTFRak0yeVB4RlpWSlZ3NmNwMEhyUVlvNmR6bTJN?=
 =?utf-8?B?Q1VBV0hKNmh0WUNkM0VLbnJnZmRjUzZzdTFEbnB1TjBzZmJDVTZjRHMxRkkz?=
 =?utf-8?B?UGFIeEFFUUJSTklNZzRtTXcyUkFiQWhydzdlUjZwTzdDZzlyeTRnVzc4Rmt4?=
 =?utf-8?B?bHJsWU9PL0RzRWJybGJ0NVhjcVpWdXhIT1FIWWNFR09IZHBtSFVtNzdYZ2VV?=
 =?utf-8?B?MkdvNGRIU09pSkNLSmo3akRRS21ESGVWN2NJSkZ4Y3RvejlSaURjMGsrRlFr?=
 =?utf-8?B?KzdPV3FGdmp6WVRLK0lpMWRBSWpDRjhhd013aUx0VERlS2Y2TmI2TURQbCtt?=
 =?utf-8?B?djNsa1dNM0FIUWVVU3NPZHJRMWlkbFh3cWlGUXFWTjlTMU43aWo0Tm5HYVd2?=
 =?utf-8?B?aFBSaHRxR2t1cTBhUTRpVlppME41UjRnSkhEdnJkOHVENUpEQU8rZmdlZG04?=
 =?utf-8?B?UFBVVGQyL1ZiTG45Z25ybVFhVllBN0RCUFltYURkWUFXU1BOR2kraHRLM1Vt?=
 =?utf-8?B?YUxuWFdGK1hFWTVUV2xLQ3g2MFYvdkZrOStqM2RrQklocVU4bi81WmFET09Y?=
 =?utf-8?B?d1hBSGJuM3BnUHJDS1VDN3pxdzJGMjBGOW5YOWgwY08vR3V1WXJkSUt1Y3pR?=
 =?utf-8?B?YVVoN3ZTUkNjTmZCQWVleVhDK3pITFFWcVErSkI2STlwYXhWdEdVRXZ3ako2?=
 =?utf-8?B?QWtDQ2tFa2FGZUdiWHp0U3pqUnlXVXpNb3FXbm5uTm9tOTdMaWUrSUxZcmRj?=
 =?utf-8?B?SlB1UXlTbHAxZ1pIWnlTZlM3YW12dys4ajZrRWhROE5lYjdHbGFDU2RrZVBv?=
 =?utf-8?B?ZWlXQ0ZmNGYvbEgvTm04Tmhwdi9RNTQvenh4RjRPMGV3M0tXNHhEb3l1UEtJ?=
 =?utf-8?B?VmVGTW9OeVBQWWFYSGFheFRpMCs3VlAyVTFYeG5OUndNSnF4eU8za2hHTi95?=
 =?utf-8?B?eWhJSFBzZFVhcTRpdGtUUGFQeFlSOWVHb0MvbXhHeHg0Y3JHczQrZHBEQ2xa?=
 =?utf-8?B?TnFPaXJnd3pUS2U4K0MyUjlWY3M4VHFjbnNDZUR3bXozOUNRRStHUExMZ1cv?=
 =?utf-8?B?bWxVNWxzWWUvS3RVM1RUVlVxL0h2bGk5Wk9BbktKa2RsVGJmY1VadzJVR3lB?=
 =?utf-8?B?NVJ1cWdOY2tMcjhlcHBPUlBzTjJLc1o0ZnVGdlBaRVp5VVl1TWhISjFPUm84?=
 =?utf-8?B?NzVDdy96QlFCbk1TZEY1MDYvcWxuR0QxcHZrUXVPcUNmbmhZbU9TemFRZ0g5?=
 =?utf-8?B?TW9oMGNUVG1qeUg2NEVGTFR2ckRoY3FhbXp4VXltUmZ0T0FpWUtGakRZbEJ2?=
 =?utf-8?B?WmgwekZBTXNPN1lxVWVGVjRnaXBPM0N0WnUrRk9ZVmc3cTVYME16cGlTajNy?=
 =?utf-8?B?R1ZZQXZYVkZHRWhxZGhabGtPNVZMVFIyK0YrNThJYi9jMDFjR2EyWFhaWDhv?=
 =?utf-8?B?Q1NYZW12Q0xUSlJqcENxQUpBNVVJbW01V0JYT0tKME1xaVJ5YzF5cDlpOUZR?=
 =?utf-8?B?bGdZekZMTXdCdVRsLzkwY0EzNGIzY2tHaHRlQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:06:45.8347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f11f369-21e8-4b6e-050b-08ddf1234c1a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B92.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9266

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v18 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28, and it
will be RFC9768.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
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


