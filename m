Return-Path: <linux-kselftest+bounces-41241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481CCB52F89
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 13:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977263BFB25
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 11:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37CC31D398;
	Thu, 11 Sep 2025 11:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="a52ITyQD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011041.outbound.protection.outlook.com [52.101.65.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BB531CA5D;
	Thu, 11 Sep 2025 11:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588838; cv=fail; b=slKkFhX12elHKn3XQUxuzwpH9fBxuU1JCQcjmgqQied5tmqVw/RrpQ8ng1WVN1386azDgsAlvcyFsu9SXSwe1Nhd/oSOf/7IGB4fMeVA00Le4DCfnbAr+wdsm3eJvlv+GnmzIAmVewhheNqOem6Ppu6pIEOHwYTmZrId0JBO4js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588838; c=relaxed/simple;
	bh=4roOIwVB4t/QyVRpZ7WhxO58mPofxqAcb5mjO44z5c4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qDXwqVSl/lofXanFDD2t4m2sZF8whwpobKaU5XtKuDkmxRqoDbRNlXhH8DbGNY8sT00iVXMvoyio5zJ0qs+eC9lI32EsYBNWOtA6fARnlbn8UKK7Yv+9TLwjSSjtoRcCUjdU8xDqwMc1FAjVUNXug4UD4hcwfvNIECOdJibh3cA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=a52ITyQD; arc=fail smtp.client-ip=52.101.65.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mhaLjg3YLsVyiGBuGRK+jTa3GIFXPhqJyENHKhjbb/IpkXqpDecsTQKb9pKg3OY/EvtZi62z636jqKLyNzoIwTD2zzxitmygyu2xsvjcS2z8BU7YoB5+wJuFaMygxvWm83sy1qYyS5c6IRIVo9vIfGSlWx3Bg4Rhco6ds5xJ2lAvELkYAzOK7VnwxfHMZt+m9TNcLlQAvlWR0jVzpZJFInzms0N0pZ82RoaPvJapDvcs9ey6ogA836SGHXfknS4XXd+o6X2y8emygJ2frYzNvCOnZ02TSqjd2C+FnhAHsE2bsV8bqh6TnGUnOqzmX8OdDXZMUI72LtCa1MO7wl52bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=DiY6KBZAnkTfI+Wu9cgZ7jn/SajlgUtVD8SHM36Wam7FC8hINxwe+mC0pG2bjqdhcxs6s79DnxZjulaU8gTwjoiWqoUSWp7mQatJK+bOPSDBggXPO97Y4psaWFxabsMyQrvib10zLCkhzjlg+bsWiCrpLleVeHtJNQN0W4x4nu82TlZ/pT4hOFurd6SQrn1ALZ6PZtHlp/OEVeeS1mpAv0UvsnMs1tPOWxBqrITcmCt4gF0RrKq+RSCx+3+VrXdwBrWUSBRot1tXbV7LMImhYqopD3JoWDgA5oCtxcG1CfY+StkldOK+pLMAP49aHAxSziIKJtlBb7GMjnO3J7E6lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvkpQev33JM82+voUy94wmxzIg5p1RbiMdjsJAb0Tf0=;
 b=a52ITyQD2BYvhL9ZnGhStmh7bTkWyGFSIbmCaGHGubogEXdwrFC56+614a9LTR+DqYM71SIGHAI9KIsUPtOLQwCAgJLG9LFsNr95U51RIUZFAoAEOQweBXVW12nhdyiyruoAI4nx1wCxsYvmJ+9nIqMnxRrIkAlheYR7tLliP95+1zfYb8zwKNXe8IjH9aDxxCOhBGmFg98EVUCVKJW7lXQvfZSoI/rBS7oV0xHw2GMInsX6qgXcwCDX7zfWpCVfCXdFilQnPEgLkCUgox5pVs6m0xoZJBepvV0ytSbEIpHOLqhazRd9tS/l3p+/vy8Cc/zRwd11ktrIGUiTkIEdxg==
Received: from DU7PR01CA0048.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::17) by VI1PR07MB9756.eurprd07.prod.outlook.com
 (2603:10a6:800:1da::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.30; Thu, 11 Sep
 2025 11:07:12 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:50e:cafe::c6) by DU7PR01CA0048.outlook.office365.com
 (2603:10a6:10:50e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.17 via Frontend Transport; Thu,
 11 Sep 2025 11:07:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Thu, 11 Sep 2025 11:07:11 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 5E43D20106;
	Thu, 11 Sep 2025 14:07:10 +0300 (EEST)
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
Subject: [PATCH v18 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Thu, 11 Sep 2025 13:06:42 +0200
Message-Id: <20250911110642.87529-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250911110642.87529-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|VI1PR07MB9756:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ad690d-ea46-4c96-97c9-08ddf1235b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmVWbXdjTW9mbktyTXNOcXFNMlNYN3pONU9rbkx6eHBCcGVzcGVEOXFuN1lt?=
 =?utf-8?B?ZkdJUTZGU3FYMFZMYS8zeTdsWStmSG1GMEM2OUx6bkV3Z052R1JUVVZvZzl0?=
 =?utf-8?B?c0RCcDQwMFJFVzN0K1dIWkczVjlZTm1kSWFzcFF3dEJlU3RSRytHekdjMHdv?=
 =?utf-8?B?WnVMR3A0QW9EZ01SVy9nc2ZIcnkxRWU3cmI2SDlpME1Xdk9nc29QRDY1dnZz?=
 =?utf-8?B?Q05lMWxzZlMxVFJTQWtXNVBmMG5qK0hmLy9CSS85OVk4WWE4b1JtL2p3WTJI?=
 =?utf-8?B?RUNUWWdMRCtqeFlyN1VHQTFIbkZyaFNnc1RnMXplYnNqVENEQ3hZZml3R0Q2?=
 =?utf-8?B?VitzTW1FQWNUNXkrZVk0KzN1MktqdzNnZWlTUVIxRFR5L1pNZUtGOUZBcDll?=
 =?utf-8?B?NDU1anRIRXExajJRQWVTeVhDZzMzSzlTaDN5QlA5SktTcW56N0lVbjAyYzFs?=
 =?utf-8?B?RFhsU1V2TVg2VTF0azdaaXVYOWxNR21zWlpjVzBlT1JtRDlrWXhsZ0RtRE9O?=
 =?utf-8?B?V2xoRFFtczV5MGw4cTd4NUducEtlZkpMTWtCRUJ1K1BjYUFkdDlHN045OUx4?=
 =?utf-8?B?VStxN0xva3lsdUVKSGlJdHpQdmxEb2VTT3V4UGZZa0ViMkVNTjJ0cXIySmhY?=
 =?utf-8?B?MmF2YzJoYVlaZDM3UElvYVJJc2JKOFNGd0I1aEhDejFLbU9mZHJxSGdmaXVP?=
 =?utf-8?B?R0xlZjBxbkZuZDZQdWxLWFJ5STI2a2Fka1hCZXJ3QUxtVmxnNXplTm5pVUli?=
 =?utf-8?B?ZGl0bk95bWlhZEFuSUFzV0huVVBXMFkwbFVwazR0U0dJclNKK2VxOE5sa1pH?=
 =?utf-8?B?Mm9ma00wSXQraDByNkg3d1pLRmlkdDUyQW5rZEtaTmlaQTB5a1IvMUxnLy9S?=
 =?utf-8?B?V293WEJBbk9JNDc4RFNZMm1WbHJvOGFrVUNJc2h0cUxtZzBlczBpdkZzdUZY?=
 =?utf-8?B?R1VrRUZkQlJHbE9iNVlGeGV2MDgxNUNRMElFRVpyK2ZKUzlDWkNqNXFScTV3?=
 =?utf-8?B?UnhCZk5Vcm9uOWRqdUtSUTlZaHRTdlo4R1Z6VWx4Q0JDZkdzM0Z0Wko3UnBY?=
 =?utf-8?B?NG5CUGs2UGhEWE1GOWJwWnA3MXlPN3hVMXVtNkducC9Fbk41RkcvbU1YQmhE?=
 =?utf-8?B?YkdCMkJRWXkrSHhIZXpFT3JyY2l3LzRlOFlKWUdLaVUyQ2pVUS85SnN2MHJo?=
 =?utf-8?B?eTRsakxLc3YwaUVqNjNTZ3JlZW93d2xjU1hYbjUvNkd3K2VMQnkycVNobElH?=
 =?utf-8?B?d3RNcGVZYnJzSGVkRmNaVEhUU2gzb2x0MU8ydFRFN3dCUDlKcmdHd09OZHgv?=
 =?utf-8?B?eHlGOFI4OUZLRGZqTU5udmdEY1c0T2dWVlljL093aHJWVWlWUzdQMVhZZlNW?=
 =?utf-8?B?bC9ZVXRrTWhBMTRGa1BXdGNMMTMybUR4R3lZdVZwSE5sN2I0ZVlBM29IQW5S?=
 =?utf-8?B?Sjd1M0VtbzNMZVhTby9EWlB2V2VWRTdQdnVEOVJLUUYyUHFwTGVnc3FKU2FX?=
 =?utf-8?B?VldpSkhrc0F3b21ESUxITmpXT1djZVpYVlBockJBaTMzMEQzZjdMVXhtQTRn?=
 =?utf-8?B?QU1WYURaU2dqQkhKa3FwaTY1U2MxQkh0dHB4RzJTOHZydGEyeGE3UXRpNDhu?=
 =?utf-8?B?ckNWK0pFa2w3U05RNE42MUxNVFVSUHFhR0RneVhkU3hmV3lzMm5NcnBxS2xr?=
 =?utf-8?B?eGUvQWNPMlVzWC82Y2swQ2FPMzU1Z05xdXdTbU45N3UrNm91NVk3bWkrRnRL?=
 =?utf-8?B?L3ppaU5JQ05sSFY5Z0VCR2hhaXQxTjZZc1VVc0l6d0l0azlFOFdsenpNUklC?=
 =?utf-8?B?Wno1dUN1ZzE5RjdjS3NtYllyQU5PSTJzWFVsOVZ4dmZZRndMQXJsN0tjeEtK?=
 =?utf-8?B?YzIrbWRzZE5MclZpdWpPUDhROWFMOEh5enl4NFJoRjlRQ2NsL1Q2RjdrdFY1?=
 =?utf-8?B?Wjh6aXhRZTlIbjVZeVZWMzF0Y0J4WXpHVDluSFNRL1k0V3gwRkVCTi9MV21S?=
 =?utf-8?B?U0hnUTROekJXMStmSzBacGc3TnpoS1VuQk9oa205SnFmTEtEbE1mU3hwY1VC?=
 =?utf-8?B?V0NHRkRRWnkrY0tBMlpKQTNxUU9NbkNVTWpFQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 11:07:11.8619
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ad690d-ea46-4c96-97c9-08ddf1235b99
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9756

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

As SACK blocks tend to eat all option space when there are
many holes, it is useful to compromise on sending many SACK
blocks in every ACK and attempt to fit the AccECN option
there by reducing the number of SACK blocks. However, it will
never go below two SACK blocks because of the AccECN option.

As the AccECN option is often not put to every ACK, the space
hijack is usually only temporary. Depending on the reuqired
AccECN fields (can be either 3, 2, 1, or 0, cf. Table 5 in
AccECN spec) and the NOPs used for alignment of other
TCP options, up to two SACK blocks will be reduced. Please
find below tables for more details:

+====================+=========================================+
| Number of | Required | Remaining |  Number of  |    Final    |
|   SACK    |  AccECN  |  option   |  reduced    |  number of  |
|  blocks   |  fields  |  spaces   | SACK blocks | SACK blocks |
+===========+==========+===========+=============+=============+
|  x (<=2)  |  0 to 3  |    any    |      0      |      x      |
+-----------+----------+-----------+-------------+-------------+
|     3     |    0     |    any    |      0      |      3      |
|     3     |    1     |    <4     |      1      |      2      |
|     3     |    1     |    >=4    |      0      |      3      |
|     3     |    2     |    <8     |      1      |      2      |
|     3     |    2     |    >=8    |      0      |      3      |
|     3     |    3     |    <12    |      1      |      2      |
|     3     |    3     |    >=12   |      0      |      3      |
+-----------+----------+-----------+-------------+-------------+
|  y (>=4)  |    0     |    any    |      0      |      y      |
|  y (>=4)  |    1     |    <4     |      1      |     y-1     |
|  y (>=4)  |    1     |    >=4    |      0      |      y      |
|  y (>=4)  |    2     |    <8     |      1      |     y-1     |
|  y (>=4)  |    2     |    >=8    |      0      |      y      |
|  y (>=4)  |    3     |    <4     |      2      |     y-2     |
|  y (>=4)  |    3     |    <12    |      1      |     y-1     |
|  y (>=4)  |    3     |    >=12   |      0      |      y      |
+===========+==========+===========+=============+=============+

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>

---
v8:
- Update tcp_options_fit_accecn() to avoid using recursion
---
 net/ipv4/tcp_output.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 65b90f73daa0..388c45859469 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -873,7 +873,9 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 				  int remaining)
 {
 	int size = TCP_ACCECN_MAXSIZE;
+	int sack_blocks_reduce = 0;
 	int max_combine_saving;
+	int rem = remaining;
 	int align_size;
 
 	if (opts->use_synack_ecn_bytes)
@@ -888,14 +890,31 @@ static int tcp_options_fit_accecn(struct tcp_out_options *opts, int required,
 		else
 			align_size = ALIGN_DOWN(size, 4);
 
-		if (remaining >= align_size) {
+		if (rem >= align_size) {
 			size = align_size;
 			break;
+		} else if (opts->num_accecn_fields == required &&
+			   opts->num_sack_blocks > 2 &&
+			   required > 0) {
+			/* Try to fit the option by removing one SACK block */
+			opts->num_sack_blocks--;
+			sack_blocks_reduce++;
+			rem = rem + TCPOLEN_SACK_PERBLOCK;
+
+			opts->num_accecn_fields = TCP_ACCECN_NUMFIELDS;
+			size = TCP_ACCECN_MAXSIZE;
+			continue;
 		}
 
 		opts->num_accecn_fields--;
 		size -= TCPOLEN_ACCECN_PERFIELD;
 	}
+	if (sack_blocks_reduce > 0) {
+		if (opts->num_accecn_fields >= required)
+			size -= sack_blocks_reduce * TCPOLEN_SACK_PERBLOCK;
+		else
+			opts->num_sack_blocks += sack_blocks_reduce;
+	}
 	if (opts->num_accecn_fields < required)
 		return 0;
 
-- 
2.34.1


