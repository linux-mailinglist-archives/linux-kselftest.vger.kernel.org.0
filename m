Return-Path: <linux-kselftest+bounces-49027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9FBD247E6
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C89930031A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A239B4A4;
	Thu, 15 Jan 2026 12:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="O57bmyFU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA77F396D38;
	Thu, 15 Jan 2026 12:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480169; cv=fail; b=WLwzKAYOUIn3Cs6SoFPAcP1w3BCpJCgSK/FlyrmwUf+gpR5V6PymxzTuJaqunoxuaWseScUWHojpkXMOp6z7naLTYaHMb8vB3Ub7Jx5QAG2W8U+yTMs/k5uACZcF6PZCFWZRmzFbigvY4v0WTx9ECRXdkHqZLV8c3e1m6C7fDKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480169; c=relaxed/simple;
	bh=bGrDa5EkVhUN+KgRlhyfCNJ/vfklSbtm7Gj3iIz80Yw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dcPRo3Ck7rKnkegIr7TBqE5ohjQc3Co1TCUPpB2lOIm9zLyK456AVZNIEElS9eYh6Jr2H6Gh5zfuPPyAv1fByEb0KHovrRglxhxs1CIS1jG+m3beiq79CFLlRNcs9ypTy9LlOsWTZoywxDnH/OSXRtBHi1eZR3UTlB90upgdf/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=O57bmyFU; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ga8JAjhlceafWEnlh4PUMwn/RR6PvQxz5XXDihBpu6xhVCSLnLooFODCPI0/OsIuoPET44XQlZ58x+krKSEyugknG4dkQ5aR9/yHHTNSTp54xQH3zO9YYH6v2FuUC/Alvdo85nJyjn15cYJOr0vfR3WzJRFhJ4TuQtSmZTeYTjxwJmk5MyAL0Q+Ykgiv0n4PFnNSJcfT47OqA1wxmBR94qxrcSyv7ypWNxuTaAZPNDSMZPrG96QiOPfDVNU7HmKhPKyOv+A/t4JChteNCdVYrKJe2+EhIBw980NNw1l4OKptdUu9IHi6Zgr4v+Ht7fgu/P3e4T8A7ueIovAYdoq8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=X73I4fZOHLLC+hBELlwUlvN2C66JG9p70FKyvVmePrk41iqeZBSodc+Sae3JhFBTh3VarosY3A34pFEIMFvofyWQv4lvrSNKv9ioxlsYbreFflVTUutI5fBZMBm37Bqv9uwDP6JQBGFgzj/ZpZBovSZI/S046ORvjAUlzbXGDID1klXWvaphzV1F2r4ebZOwUNogk0zrVpeqTKNYjqoRUCh61HiNRJWloA55uV81vXm9YVIE53Y16ZWUUGYLBOIi573x0i+G/is0BxxjwfC6Scf/iHWgQKk2DygqK5xiAIxjIz5ZbHkh51JD5YBtrmtpssDyhk9l8CPV0qCqWWLS3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pr5Wlj5y4UaCCLUMXC/uQIvk3dFXSguLdULxWSqrRwI=;
 b=O57bmyFU1Q1WS2966QjWOIA6Kwlw0uTVc/jV2itpnoNBsyjM5a+YNFsA7qCQREjAdF3IPnmMFIJoO8wo6SqiGFOmEvOIrsT2aa6fa8knfboxHnoPlcKDm3syYZshD2KuTdoU+mEyuutXJj/hfpHF5FMkRZm+AUQS6hppiBuP1QfaXxmQTfAqpDn3JD0aGrq/YrcuJJV11dr4wF7GyVf46qxRSOS7UQTUyP+SOO+dsHb6dUS8BO3W4tzDWABpSmm3NTi+tSuuN9uw2+crI6brz4LdLYxjEoT6tCCELg0LzTbaXxhiqM8LttY0+A4wZvaFKOX01e3hUc5mV4Eh7kBhZw==
Received: from AS4P189CA0051.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::16)
 by AM7PR07MB6675.eurprd07.prod.outlook.com (2603:10a6:20b:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Thu, 15 Jan
 2026 12:29:21 +0000
Received: from AM2PEPF0001C714.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::4e) by AS4P189CA0051.outlook.office365.com
 (2603:10a6:20b:659::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.6 via Frontend Transport; Thu,
 15 Jan 2026 12:29:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM2PEPF0001C714.mail.protection.outlook.com (10.167.16.184) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Thu, 15 Jan 2026 12:29:21 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 7B6F720164;
	Thu, 15 Jan 2026 14:29:19 +0200 (EET)
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
Subject: [PATCH v8 net-next 11/14] tcp: accecn: fallback outgoing half link to non-AccECN
Date: Thu, 15 Jan 2026 13:28:43 +0100
Message-Id: <20260115122846.114576-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260115122846.114576-1-chia-yu.chang@nokia-bell-labs.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C714:EE_|AM7PR07MB6675:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a453e527-a5c5-460c-0e98-08de5431b5a7
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?FymhiXgAG25YSKkWqNUBweeD0Eul4Ltw6Im1jjyqoeeEO3FXMF0JiWbo0GsX?=
 =?us-ascii?Q?FFE9tW9HVo68q40+VQ+UB3MIDUP4G7iAQtAD7HctlfHyrk3Ymyki6TwH2mzi?=
 =?us-ascii?Q?h4B5UmLTf4LjxaaFFiXhKVrNo8qeucG+xW/i7hvQ4dw1KiJYwRwlPr2Dp4oj?=
 =?us-ascii?Q?N5n0sBAU5borl7j+TgoURf+ikYuDRawYri6XQK1Mi22UziM4JQ3wRDDP3Ju7?=
 =?us-ascii?Q?isHb7plaa0G6GpPj2NHgUBHH+OB+D5nVbNpTcpZWADq3tryQrO1Lu4CoHeBE?=
 =?us-ascii?Q?qSvpnMSywdHJZX+jjKqPAb/c58lXZSfoo2jzX69geg1IFXsn0MHe5z1NHzzU?=
 =?us-ascii?Q?hu+TrX+q+1E1halwSuv58ac8VtUO/28lKmbyFIbqeGvDA+VFyr3pYyLN33Ew?=
 =?us-ascii?Q?blNM+Ieo2TT0NtmTrBKCM/dtfUFZGl9IdZkOenlRz6kqJRxjtzJom1z8kgEm?=
 =?us-ascii?Q?rH4BwTTGk/Eh7HEq8DLEs/k2olAh0c8PCACaZ3jswSrZexZbUjG6jguwyTL0?=
 =?us-ascii?Q?vnzzcc4bKYhxRlZFxcg64vtN2QAjFyJDb/3CTfl55c1peBBpg00upkmuhQPA?=
 =?us-ascii?Q?+CbssKx5tdRuKxmy8UfRgkHaB5AielshFwRHrNhHQrstQikqInPkQ7fKR+Q/?=
 =?us-ascii?Q?6JXyKmXrlIHeDhqfG9jU8hjGItql6Mroeq4K+Jy7iP2entebI/4/ldA2zPc5?=
 =?us-ascii?Q?vg8SvOpl2/awSulhUgt0xhwBP/ZXKy3z1OXOaCtxV4xPN5F/14E6gut5X/Zv?=
 =?us-ascii?Q?n566CjmnI5cF6YJXubXbhYSoGB8/57ghWs9VmX+Y+MxjuDR0qqyYvygExf/D?=
 =?us-ascii?Q?Sw6IJm+7jZXfz2t28c3e/jVfl9zcTi4EoRsFbdCiU30omaT8Q1+MRl/EAol/?=
 =?us-ascii?Q?5elsGa9Lho21ONCc5bdKJgueVQvvg8ra4BRRBMbKusAF6X92M1ZXVBWdl534?=
 =?us-ascii?Q?yN+k8KgFi6XcI/YSSGMKIJHXcLvhkQA1iE3qCp4A0n2Fn9lxKoH0CwpJ59sG?=
 =?us-ascii?Q?Ti2qXRd+Umj/M1ZcfsYeTB6zCRt9MtiepwI2bBMAyVoFFKGuE5CkkYguMdQH?=
 =?us-ascii?Q?E3TFNv4nfAQrQu4JTXAP+l2zZTycGcym5fgUUvlWl4H3Iemuu9aUCALTEoyc?=
 =?us-ascii?Q?rnQs9MGDx60aGw4utEOx8+8O5BjKY9HkMh98dibAZAmneHhvrL/YsxDMULpG?=
 =?us-ascii?Q?whXUfwq3532SCoXnkPZ0HpwK2GuKi1m+JgJ3svVPkZyqZvc0js9eDRw/q3O5?=
 =?us-ascii?Q?SfUAHBExKldImr/4ygwyByrUEsrWA4gWcxftllWwoTMxOazwo7bhYFotkN3E?=
 =?us-ascii?Q?hXzO9Z8IIb7aOcwN60S97AHnXppsWSqw4rNLJJ6wvBO66nc0ZjV9yOYTDhl/?=
 =?us-ascii?Q?WEXEiwH+bGh0j4ei5kGIzJM0iheZHoUnAytI8acjd2jzMUHsM7oUXgqId3Kd?=
 =?us-ascii?Q?3QmXHv5N8pdo8OEm2PiX38bIORTjgYL/3iHRIneb+/w9Q4QkvrkKPm4BB71h?=
 =?us-ascii?Q?kd9Y2i4AevIHzncDDo5akcGz2bR7Ihct4xCRD3UpMjG9UJojRVuU8LevQ+MA?=
 =?us-ascii?Q?ffjHfPTX3jxXRfWXx4aEbtTgH5xrXKPEYuDeUVJOvTgp5CYcFT8ovbn+Lg6F?=
 =?us-ascii?Q?LY62cx6NR7WEt7LLlomso68dmxmNxWcloRUaBZmzsTBDEuvoGoHcZdNolCJ8?=
 =?us-ascii?Q?GlYtRgh2ZqxeOJhfcQdJTGKxF3Q=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 12:29:21.0220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a453e527-a5c5-460c-0e98-08de5431b5a7
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM2PEPF0001C714.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6675

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

According to Section 3.2.2.1 of AccECN spec (RFC9768), if the Server
is in AccECN mode and in SYN-RCVD state, and if it receives a value of
zero on a pure ACK with SYN=0 and no SACK blocks, for the rest of the
connection the Server MUST NOT set ECT on outgoing packets and MUST
NOT respond to AccECN feedback. Nonetheless, as a Data Receiver it
MUST NOT disable AccECN feedback.

Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>

---
v3:
- Remove unnecessary brackets.
---
 include/net/tcp_ecn.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index f5e1f6b1bec3..bf7d3f9f22c7 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -182,7 +182,9 @@ static inline void tcp_accecn_third_ack(struct sock *sk,
 	switch (ace) {
 	case 0x0:
 		/* Invalid value */
-		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		if (!TCP_SKB_CB(skb)->sacked)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV |
+						     TCP_ACCECN_OPT_FAIL_RECV);
 		break;
 	case 0x7:
 	case 0x5:
-- 
2.34.1


