Return-Path: <linux-kselftest+bounces-37566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A13DB0A617
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14751C807E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772442DC33C;
	Fri, 18 Jul 2025 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FIbk1oDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011062.outbound.protection.outlook.com [40.107.130.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B371C36;
	Fri, 18 Jul 2025 14:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848455; cv=fail; b=A51601u0XmZWTYAPMvIyFrfv9egQI82WxYU4pAE+J/Z1OtQ0Xc9u10WF4/hTuH9Hg2BHGJOOVId6q9mU0KXfWYAzDR7HD0jdv/vmSZIMQTOrfgKaaMXJ8yuBK7Zp7C78e/x1ivhDsPl9jiGycKAXUwuh2aIAkCv8aEdSv7bIjZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848455; c=relaxed/simple;
	bh=0OMhzzuVxsAZ4Sfpyz3irrdbn5ARQT0giowpUgdAvko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=g0fLylQg5yeVGsgWrbhXjewqCvuBqrQ1lRHfX4hAfclM6gu+efPHC5ZUxGfoGDJVSFzjmt4YK6hTfvvvpAPUYv1kPCZ84kGdBeCfEIKEEHcbjZtlZrgvWmzn/w1Ghvda0QfnjikCiC6eHHjK0yHZNr+kcJ8xfS2+/l54KhiVa7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FIbk1oDv; arc=fail smtp.client-ip=40.107.130.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfCW45BWtdeUG3iN0zNwE23BO+Z3L8hkZ7EF+vpHsqkW5Sjyrc++4j1O9MIO53fbrGkNI3KI28HFlu1xHDEOvYC99uvzXUBgYmwhH30SdIzvQSgENMT7OswDpMgu9gRUDcTDgvwpLxQ0L+D3+y4KslpxLriHhDwlqOEKYfFpRWW4sFUET83F1sApLvx43AmjPy/0SocrOrsjpFruBydZR5ezYSK33hGSVAs85HcOGvkQ3gTcM1AfIqOYq7XMN+RRCMAsXpOlSmUGKlpLf58/6gPse65Q3oMcHI6mxagDuVkOT058ZGjkq3X/skTPdj2bAGRwnuzDe6tcuNMiTOtPOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNpeIMaKgvLaOicwE5VXw5kvUl2onS8Dobm+31L1ic0=;
 b=bAM7blC/txMikwbegKgOq1NzvLqlwkEM9QWkAmQw6Mj/1WVjE/A/k2oHH+b5svxWp/Eb/DVMgumAVg5qjeulJK7gEsFXnFc3S+Q+d2E/7DlYXHbpBrSWbPGuL77Rem+1GVb4+9k0kFOHb+G6nzdJ2mCUmzhDE6auHUsd1Uv8H5oUXM9S2lT6wvV/mvBposFWMiYM58aqcMgTpdEhZK+5XAwaFkZ9J5A5st4K2UDWRSlVIRZKiPFiSiZYGVhDZocOQCyyKHkm7UQPkFDss/kxq4pUsFaZUeuSE6Ul/1LT77IpZsfjmeufii5Mf5B+PaxD98l/tJgiTiznbx7/Ax/3HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNpeIMaKgvLaOicwE5VXw5kvUl2onS8Dobm+31L1ic0=;
 b=FIbk1oDvveO2A3Q82VQTwQqquhnhk10rgrGN3i5jI1yI1NnKfIpc42Ym2RiFPWOva44iqh8YCJJklxdxk4HI/VakflR6zpnPfyjnGqD1wWnlNAhWhckklqqdBeH49tA0YiNfi1ZLqZ7NLr0LNQ6JIPXadXbZOyzAvqaj+iwbZl5j1DKviz3kLLHccN7htA1B0JC/kcwbdKkenx55iognHdg7tRpqWIOvAX1JGyeNHuLU+kElAqY0LtP1zBOPr4BaRG2a/vRagp/Vq5lYruI7QoYlpERpRmETdrZQYowmT52QWRQDwADve24F2Duhs/VaLZAaZVygGbA/zJR/OrV6HQ==
Received: from AM9P195CA0029.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::34)
 by AS8PR07MB7718.eurprd07.prod.outlook.com (2603:10a6:20b:350::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.26; Fri, 18 Jul
 2025 14:20:46 +0000
Received: from AM2PEPF0001C715.eurprd05.prod.outlook.com
 (2603:10a6:20b:21f:cafe::d3) by AM9P195CA0029.outlook.office365.com
 (2603:10a6:20b:21f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C715.mail.protection.outlook.com (10.167.16.185) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21
 via Frontend Transport; Fri, 18 Jul 2025 14:20:46 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 3296320098;
	Fri, 18 Jul 2025 17:20:45 +0300 (EEST)
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
Subject: [PATCH v13 net-next 00/14] AccECN protocol patch series
Date: Fri, 18 Jul 2025 16:20:18 +0200
Message-Id: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C715:EE_|AS8PR07MB7718:EE_
X-MS-Office365-Filtering-Correlation-Id: c52e8667-4249-4432-a622-08ddc60649cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUYrWUdFUXlGUTVES2FMVU1WSDY3NGdGdkQwYnVwOVpDL1ZEclp5Tk0vRWlR?=
 =?utf-8?B?bERaMCtPZWRJTjUxdDRpajJreWJnVDZKd3BlcXNra0w0dVpqc3ZDZjFTY002?=
 =?utf-8?B?bnJZcXE3WVk3eUtla2lsa0RhTnYrNmR3UUNhcGNwN2p5bmxUbno0aHVvNFAy?=
 =?utf-8?B?TGhuc0Vsdmt1UjJlbGdiRDl2QThKTUpRVTJTR2UraHl4aHE0a202ejI2bzE4?=
 =?utf-8?B?ZWxrR0xNSmV1aExGTHVWRHRkcFFkOWtUeTExSHlwRGJ6L040d1NyZ0FyNVdV?=
 =?utf-8?B?Vndadkt3MldTdzVYaDg5Vkd4angwVytFYWZqVlVCcXU2ZlV5VWVxZFdkczFs?=
 =?utf-8?B?anBrSUppaVFldVFCbUowWjJZcGZoSWJUbEc2MnpJK1pyVzZZcjF4Z0s4Zjds?=
 =?utf-8?B?MWVDUzNHazlIb1lUVHJJSWRtb1hEZ0FQZmhpYmRDaTlNdnJKaFR5cUdBc1hR?=
 =?utf-8?B?WDNEZ1U5VXh6TzZHQmFyM0hDbzZ4bXA4TG84RWo3ZWxicjczd0N0Q2NkVTZu?=
 =?utf-8?B?SlR3Y3h4cWNGcGx1S0JxeGM4ME12eW51UHVSMWxyeldLZTJTZzdlVDRiak4v?=
 =?utf-8?B?TEF2bTJvMG1OalhQNTA0SmlJUUFzelBmN3VidEk3R05nWE81VDN4VnZkNlFY?=
 =?utf-8?B?WWxlclFaTVgyNW0zTVFOU3V6QmlhcG1EaXcrV2t2MFJnbUMrd2liYXdGQ25W?=
 =?utf-8?B?cmp3cHN3N05aWFh0SFhHYVBDQkMybzdUM3QwWW02L0RkL0Z6OEZYZjh2V1Fl?=
 =?utf-8?B?d0E5d2RCL1Y3dmZHQXR0U0ZGTVlRQWw4YmRzVWQxVFBuTUdHRk5uVTgxYlBR?=
 =?utf-8?B?S0FSTGU5c3ZlODNOUVNWUnN3NXZaV2toNXk5M0JkQThMS3lOaTlhQ1dHYTE0?=
 =?utf-8?B?ek5xR3dXaXMxRWFZdHB1d0phM2hvM1l4bmpZNnhFTG1qZGtNdmVxOE5nZ0RY?=
 =?utf-8?B?akRoTy90eEZIWDZMUGZIRUdKOU4vb0lacS9UbUMyWHI0c1hYMkRkTE15QlBR?=
 =?utf-8?B?Si92TnNlRENxZnpXRDdhcU94T1NDQUllZ2JETDRKK045bzJNelprdXE4VldZ?=
 =?utf-8?B?OGpqbVptQWZ4WXVZdXZFeC93NlI0a25lN3N3WUNmbzhGVC94cG5FeVoyOHAy?=
 =?utf-8?B?Q0NyL2dsOXEyZktoMFB1dkNOU1lRam1sdXpaQlBVSVNXMG9CM1NhK3lsUEdH?=
 =?utf-8?B?L1VLQ0tNTE5BcEVyS1JBWmJvVE4xbUhZOUxpU3Zma3ZGdjVmdHdoTnEyNjA0?=
 =?utf-8?B?a0NmOC9kSS9MRGR1QnRTeXBiZk1KTzRyS21kZTViNTNCc2dyZ3NjWFZ2WGwz?=
 =?utf-8?B?VDdDaGVGbVY1Q3FzQURHbVFRZTY2YXFvRDJCN0lrSWl2TWpZSktRVHhnV29D?=
 =?utf-8?B?Vm9WbVozbWx1Z1l6M1lDbWp0WktQNzB5ZWJYUnZsdHNUMTRHKzQrZkdWWnFw?=
 =?utf-8?B?MmVuK2hFK1JheGhWRmlqTFgySW1VRkE2S2hQaG5YRk9TMjBVSFNrMUNLYXRy?=
 =?utf-8?B?cVRGckNDNU9YTk53Mm9WVzRTYnpIbXByQ0FwdlRvSVEvZ1hNRFE1Zzdodmd5?=
 =?utf-8?B?cEVjWmRyVmVka3ZnazlYY0UvNEorQ3Fwak5CQlgwakZINHpVRDNOT0c0UTJ1?=
 =?utf-8?B?SG1HUjBycjQvVWlVZkM1OUZmTmdsWnhSa3djRWEycmhsTUJTWldwTnd2M3VM?=
 =?utf-8?B?NkpMaWswd2pyMTFRT1dZc25VZnlxT3d4c3BnUnowenZqOE5PT2JicFBYamYw?=
 =?utf-8?B?YW1xRUNXaGowYWttN3NZZXpSR0NJZXVpMUZHQnNoczhYT3Q3eGtyTnI0SFZZ?=
 =?utf-8?B?MEI4TklvcHFCSEFBTll0UU4xTlV4RHM5QndvWEEvNjVRblR3ZXdjekJVYXRO?=
 =?utf-8?B?SVBQQlNXYnlHOXNKR253YThEa2tVOHErUG5FRkVoT1ZaRzZ5QWs0VHJuOExm?=
 =?utf-8?B?eWIrK09mS1lIS3FLMFhSajYxVitIdTBxY0htVm5XNng0Q1BpSGJpSER5d3pT?=
 =?utf-8?B?bGhzcUZxd0ZTbFpacWFIVEtDQ3NvdG93OVlhQ2dOZHM3d3hzV0lRdXFkb2hG?=
 =?utf-8?B?elBQMzN3dnZWV2R0K3kzSlJvZWpEQ3UvVWhpbkRDbFdyWkQvbWhTbmYvRjIv?=
 =?utf-8?Q?DOWU=3D?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:20:46.6243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c52e8667-4249-4432-a622-08ddc60649cf
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C715.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7718

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


