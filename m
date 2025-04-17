Return-Path: <linux-kselftest+bounces-31094-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1776A92D91
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 01:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E180C3B7C96
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 23:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A6C2206A9;
	Thu, 17 Apr 2025 23:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qgpAxqTc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2081.outbound.protection.outlook.com [40.107.20.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686A420896E;
	Thu, 17 Apr 2025 23:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744930881; cv=fail; b=WbDcVS+vkszlWGG1sDPdEtqFmUSb9TP8vJi2/Xf0ZTvMSV2uXFFqK6FUpZUDvdEdjuHHBgqHpExzb2Oz/wsEOlzmTabbhIyrucvxpdfF48vcFJk2s1xLuDc4nJStuDDMHJYsHuvZAsrpdyu8raOK6HfkxH7wVAch1EemBGRcLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744930881; c=relaxed/simple;
	bh=KD7/NR3z7EZK3pNxTn5FeoJCQ5ELLAzCb70Q6PtqoD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p016UKnapHRROIv+jVlzAj/vZ0w/UEcVYKtBK3PK5VANKunCV8QsOPrQD2eNNb6WBMnw+j8FEjwxHHFplj2EZ9ew7r1CeDTKT4nDJGXzIDj/M+5Vv9HMe63hiz/hGw7UgwJJ9Ee0lzNdUrstVpu3/qj5ownAYZ9xa3IUJIW1G2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qgpAxqTc; arc=fail smtp.client-ip=40.107.20.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgG1EuFZpBR66/6c81YYJ7GLFmxb0AmUfyEHfCfdvq2nw/hSGtC1LPTDJ65ny41HaiGiIaU0hT3lyZVN8zvNwSOspDmtPbJyoLcEjU2oZjLJWXz07uYeZnEQ6gQ206BD3A4y4iGmG6HGq/XlePd18oy63BjvpNW9w5V4h0QeJ3t4gdfhhgXneuKRiaX6Buk2IDJnofw3aDGp+kD3dgGobnLWjXv0vmX4ZMwT3ENj/p1AOZNRiUe8ZK3Uk3SCELWUsf67ukZbbltnroSkop4mfzA+Z1mcLZ1ud1BG4RYneSmXhHPh7pGT+N3eQPLpM12Nh0ZnTd5pF1DHJA7BuMQrzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgX0CwSPtzsPeTZbfIpkANOIMszxeyMZ4gue9xFsyEQ=;
 b=kddzynak04KSOmah97SI4JnalWCP/rKRXQSFUD8MLHNxsM2Mr7qG53sxqICNG9isacRFR7K0/s9x+qUbzDaARTJw1IODwB/QP/ndwN3meglkRLOiWyEL7dZLacbGtrXA5p+XXOc2KOf44W+6M2ssCXjo4xDagHyl0BjMDuNuAj+g4XxUVFebp+j5512b4gtHUE3tVMNl7HblHwbbq9t82v78Cn9SLsWlluFe6+H895Lnh/lrEalui5B8954Jtj5sU+cTxWRlTgToWg1/X2yzIPfnAmHNxJ11NmTuer9fI700+EIcdcZtZPLETeeTbKMtL0J5LCicFx9OHroH+6dPig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.29) smtp.rcpttodomain=amazon.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgX0CwSPtzsPeTZbfIpkANOIMszxeyMZ4gue9xFsyEQ=;
 b=qgpAxqTclUxn+GK+jvFlAe2lZ7XqBy8hkonh1A41KowEHPZXgHMW/8mw2NCqJhWGu04SreRzdIHuw3K/W6oZteTw4RhI6jUZm57wJmYhCPBWgBHBrTFQF2cZk3W1QsS9QgNF12Ej+8yURdJ2x+vIaUgXf0cCg1IX9tfud9sRJg5wcFYJnCYFUjer5ZnBD1wgPRMT//JH2x+jr3XuHru0xKXh22mTVmQAXpmCg3JrG+v6PoCEsvDjSD8e1XmFdo664utf3sJxX98BDFtbRpwt5/30gOz/PrQ8zbCKnXOKuSqBrzWH3/l07kkCKFqOm0Hi2v/2gH+W9CapAEL4QuO2+g==
Received: from DU2PR04CA0331.eurprd04.prod.outlook.com (2603:10a6:10:2b4::19)
 by AM9PR07MB7844.eurprd07.prod.outlook.com (2603:10a6:20b:304::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 23:01:16 +0000
Received: from DB1PEPF000509F4.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::4d) by DU2PR04CA0331.outlook.office365.com
 (2603:10a6:10:2b4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.22 via Frontend Transport; Thu,
 17 Apr 2025 23:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.29)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.29 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.29; helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.29) by
 DB1PEPF000509F4.mail.protection.outlook.com (10.167.242.150) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12
 via Frontend Transport; Thu, 17 Apr 2025 23:01:16 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id 3E7D120827;
	Fri, 18 Apr 2025 02:01:15 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: dsahern@kernel.org,
	kuniyu@amazon.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	dave.taht@gmail.com,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	kuba@kernel.org,
	stephen@networkplumber.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
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
Subject: [PATCH v4 net-next 11/15] tcp: accecn: AccECN option failure handling
Date: Fri, 18 Apr 2025 01:00:25 +0200
Message-Id: <20250417230029.21905-12-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250417230029.21905-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F4:EE_|AM9PR07MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 358a1f2c-2cbd-45bf-d8a9-08dd7e03c25f
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MUVsWm4vTnJnWHpoUkxBT1BlRmtVYU9yS2NGRUlITTNYS3JoL2JJSndyKzlY?=
 =?utf-8?B?d2VPaStGRU9hSlRZZFVSMjNocUJjYmZDVzhwYTNZZ2F1OFRuS3FjS1AwNkpR?=
 =?utf-8?B?c3lVSFp6TmdQS09rcWs4ci9UTU1sNUZIdUtFR3VRbHM1Rk1FYU5DZkRBamJ5?=
 =?utf-8?B?WFh4YWRqRXpIMC9TeHVGOFhaRk5IYnJQR05ockJtSUFKSWFhS1hhaHhSU2wy?=
 =?utf-8?B?d1RWdkxOZmJJRzlIeFE4ZjRPVkhuTTg1TEM0MytLam8xMGl5eU5nY0IweGJU?=
 =?utf-8?B?Z0dqYUJyMUlybkZHYzFMdmNlYW1wdEk5NlRDT1pXY0ZZS3l5MDgwc2VCS0Zn?=
 =?utf-8?B?K2dTTUo5OUUrYk1ZUkdWS0VVVXlPcm5Ea25nZFJxT2NEZkJMRWZwWjBoT3c1?=
 =?utf-8?B?T1ZHTm9oZUxQV0w5ZkRsRTRublVXa0dEc21maDE4MjlmTHg1TE5jeDUxd2lS?=
 =?utf-8?B?dlFSNmMxYVlGVmZHSFY0ZFVMSm5KY2w4a1huMkZnRTRsOUZjWUtmcEZld0lj?=
 =?utf-8?B?SVp0MHZZbVNEelc0NVNIU2tmemo5SHNQeHBGcEp5OXZqc2dYZGlsSEU5TkR4?=
 =?utf-8?B?V0JMUi9VTXlwTlZoZlgxMEtWcGtXT2Zob3BjNlpZZnhCQitWNk44Qm5LUVMx?=
 =?utf-8?B?ZmQ1dWhMT0FDeGVKTEgzT0JxRG5CaWlabHVPcWxoTklpSWxYYTFhZ0p5cGVt?=
 =?utf-8?B?dkhZcFdQWTJoaXVvL3VkekQwdmtTck5DeTByb2Vyc3h4NEFZQWJwdXFRcEh1?=
 =?utf-8?B?VjNoby9abm5wN3VjYzFUanAySDF2OHJKSUFHdjYzT0JNTEZtNEVmNVd6MURP?=
 =?utf-8?B?VFhhUDBDZ2JGYWZadUMvU2RmS2xSTU9KSHJLWjV2eFI3MmhoRTZkeU44dmFa?=
 =?utf-8?B?bmV3WUI5ZmRjMHJNTDNqYW5jWGNxQmMrWE80SGFDcUIrUkFlN3g2ZlpCNldo?=
 =?utf-8?B?WDRhTDllaDhZSWE2dUZ4YjAxRWo1K2d0STZabjhWd3RzOVZ3VWxhQ2dtQ2pG?=
 =?utf-8?B?ME5DS0x3ME96UXdyMGozVGdNMGZ1azZTTFRyb1FCeHVoY3E5cjZCd3BrZ1ZR?=
 =?utf-8?B?Y0t2ZHhFdHkxSWI1THdHd2tNL1BPZURCM1dxbEtqTlIrRTJ4UXZuWUdaYXh0?=
 =?utf-8?B?MWx3Z0J6U0pGdzFJZ3lJYm56SmZvTnRQenh6cXJNZzByaHhLR1A2ZDdwQXBm?=
 =?utf-8?B?ZDEwK0J5VVN4ZG9LT3l5bExCTWtEaEdxaWFTdWRWWFJPSklTWXZMd2xjckNV?=
 =?utf-8?B?NDlnc000b1M0elRWY3dBQjJCQnpicUVNYXZ5ckZSME41bkRTbjdON2RibDBa?=
 =?utf-8?B?YzBmbzdnQk9NMEJ1R3d1ZHhDTncxNkFOVWdOeCtZcmU2VnFLMEFHdkwzMkJx?=
 =?utf-8?B?SzlBQU5jaGRBOHNxVlJCRkQwbDBBRWc1VFg1NjV0RGlLVy9HV1U3RG90YkxR?=
 =?utf-8?B?VnFuU3RGWkhKMGlVMER2a1dkSWdEN2F0LzZIUmFLVHMwbDNsS1B5TFdMaFZG?=
 =?utf-8?B?QUpXME5RNFJhZEc2S0l3VThNSzFBNzFwWmIxanQwbVRsV3dzWEx3ek1ueDZq?=
 =?utf-8?B?MzhyV2orMXNRcU1lN1lmZHVmNUVucmdTRjMrMW05UStzODU4NUxUbm1MeUQy?=
 =?utf-8?B?ajlOWGhPcnJ0dG5LOGQ0TmdndUlFZi9YV3RBQW5nOVE1M0paQXlnOGx5Z3lS?=
 =?utf-8?B?M1g5bHJ5OS9xcWxxRnE2NHpIejZxb3Fac2ZveTZ2OFh6NkpwVXpDeVlvWkhE?=
 =?utf-8?B?T0kwcndMWitjbVlCVlVUeHg2dnd5WkozSnNZSXNjM0hHb2d0eFF4N3dsREsv?=
 =?utf-8?B?QlBkZmZZU25MRUx3NE0wQmhtMzdJb1RmbzdrblYveU9QaS9QWG9FL0Jld2ZU?=
 =?utf-8?B?R1BNQytabzdLaUdLVHZMNXlUdjIycnQ4S1l6OWlNRWorVzA1STB5Y3dad1I2?=
 =?utf-8?B?ckFROEVJdWtWdmJicllObVhFM0dMYXVOalkrSC9qdENka09NaGdZaU01VnNr?=
 =?utf-8?B?K2JUYlNWQmZQTmJuNjZFcFpjTUtueFRxQW1VMkdCM2Z2RGNWanVBWkxBV0lj?=
 =?utf-8?B?VlZNdUREOHZGTE1WS09yK1dmd01VK1lPN3Vudz09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.29;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 23:01:16.7082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 358a1f2c-2cbd-45bf-d8a9-08dd7e03c25f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.29];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7844

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

AccECN option may fail in various way, handle these:
- Remove option from SYN/ACK rexmits to handle blackholes
- If no option arrives in SYN/ACK, assume Option is not usable
        - If an option arrives later, re-enabled
- If option is zeroed, disable AccECN option processing

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
---
 include/linux/tcp.h      |  6 ++--
 include/net/tcp.h        |  7 +++++
 net/ipv4/tcp.c           |  1 +
 net/ipv4/tcp_input.c     | 67 +++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_minisocks.c | 38 +++++++++++++++++++++++
 net/ipv4/tcp_output.c    |  7 +++--
 6 files changed, 115 insertions(+), 11 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 9619524d8901..782e4dd58bf7 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -160,7 +160,8 @@ struct tcp_request_sock {
 	u8				accecn_ok  : 1,
 					syn_ect_snt: 2,
 					syn_ect_rcv: 2;
-	u8				accecn_fail_mode:4;
+	u8				accecn_fail_mode:4,
+					saw_accecn_opt  :2;
 	u32				txhash;
 	u32				rcv_isn;
 	u32				snt_isn;
@@ -391,7 +392,8 @@ struct tcp_sock {
 		syn_ect_snt:2,	/* AccECN ECT memory, only */
 		syn_ect_rcv:2,	/* ... needed durign 3WHS + first seqno */
 		wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
-	u8	accecn_fail_mode:4;     /* AccECN failure handling */
+	u8	accecn_fail_mode:4,	/* AccECN failure handling */
+		saw_accecn_opt:2;	/* An AccECN option was seen */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3ee5b52441e3..0ade2873b84e 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -276,6 +276,12 @@ static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
 	tp->accecn_fail_mode |= mode;
 }
 
+/* tp->saw_accecn_opt states */
+#define TCP_ACCECN_OPT_NOT_SEEN		0x0
+#define TCP_ACCECN_OPT_EMPTY_SEEN	0x1
+#define TCP_ACCECN_OPT_COUNTER_SEEN	0x2
+#define TCP_ACCECN_OPT_FAIL_SEEN	0x3
+
 /* Flags in tp->nonagle */
 #define TCP_NAGLE_OFF		1	/* Nagle's algo is disabled */
 #define TCP_NAGLE_CORK		2	/* Socket is corked	    */
@@ -477,6 +483,7 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
 bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect);
 void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
 			  u8 syn_ect_snt);
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset);
 void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb,
 			       u32 payload_len);
 
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 25a986ad1c2f..8e3582c1b5bb 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3367,6 +3367,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->delivered_ce = 0;
 	tp->wait_third_ack = 0;
 	tp->accecn_fail_mode = 0;
+	tp->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
 	tcp_accecn_init_counters(tp);
 	tp->prev_ecnfield = 0;
 	tp->accecn_opt_tstamp = 0;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 1e8e49881ca4..8f1e10530880 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -446,8 +446,8 @@ bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_ect)
 }
 
 /* See Table 2 of the AccECN draft */
-static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
-			       u8 ip_dsfield)
+static void tcp_ecn_rcv_synack(struct sock *sk, const struct sk_buff *skb,
+			       const struct tcphdr *th, u8 ip_dsfield)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	u8 ace = tcp_accecn_ace(th);
@@ -466,7 +466,19 @@ static void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
 	default:
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
-		tp->accecn_opt_demand = 2;
+		if (tp->rx_opt.accecn &&
+		    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+			u8 saw_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+
+			tp->saw_accecn_opt = saw_opt;
+			if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			tp->accecn_opt_demand = 2;
+		}
 		if (INET_ECN_is_ce(ip_dsfield) &&
 		    tcp_accecn_validate_syn_feedback(sk, ace,
 						     tp->syn_ect_snt)) {
@@ -586,7 +598,23 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	bool order1, res;
 	unsigned int i;
 
+	if (tcp_accecn_opt_fail_recv(tp))
+		return false;
+
 	if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
+		if (!tp->saw_accecn_opt) {
+			/* Too late to enable after this point due to
+			 * potential counter wraps
+			 */
+			if (tp->bytes_sent >= (1 << 23) - 1) {
+				u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+				tp->saw_accecn_opt = TCP_ACCECN_OPT_FAIL_SEEN;
+				tcp_accecn_fail_mode_set(tp, fail_mode);
+			}
+			return false;
+		}
+
 		if (estimate_ecnfield) {
 			u8 ecnfield = estimate_ecnfield - 1;
 
@@ -602,6 +630,13 @@ static bool tcp_accecn_process_option(struct tcp_sock *tp,
 	order1 = (ptr[0] == TCPOPT_ACCECN1);
 	ptr += 2;
 
+	if (tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		tp->saw_accecn_opt = tcp_accecn_option_init(skb,
+							    tp->rx_opt.accecn);
+		if (tp->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN)
+			tcp_accecn_fail_mode_set(tp, TCP_ACCECN_OPT_FAIL_RECV);
+	}
+
 	res = !!estimate_ecnfield;
 	for (i = 0; i < 3; i++) {
 		if (optlen >= TCPOLEN_ACCECN_PERFIELD) {
@@ -6457,10 +6492,25 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 */
 	if (th->syn) {
 		if (tcp_ecn_mode_accecn(tp)) {
-			u8 opt_demand = max_t(u8, 1, tp->accecn_opt_demand);
-
 			send_accecn_reflector = true;
-			tp->accecn_opt_demand = opt_demand;
+			if (tp->rx_opt.accecn &&
+			    tp->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+				u8 offset = tp->rx_opt.accecn;
+				u8 opt_demand;
+				u8 saw_opt;
+
+				saw_opt = tcp_accecn_option_init(skb, offset);
+				tp->saw_accecn_opt = saw_opt;
+				if (tp->saw_accecn_opt ==
+				    TCP_ACCECN_OPT_FAIL_SEEN) {
+					u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+					tcp_accecn_fail_mode_set(tp, fail_mode);
+				}
+				opt_demand = max_t(u8, 1,
+						   tp->accecn_opt_demand);
+				tp->accecn_opt_demand = opt_demand;
+			}
 		}
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
@@ -6954,7 +7004,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 */
 
 		if (tcp_ecn_mode_any(tp))
-			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
+			tcp_ecn_rcv_synack(sk, skb, th,
+					   TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -7531,6 +7582,8 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
 	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->saw_accecn_opt = TCP_ACCECN_OPT_NOT_SEEN;
+	tcp_rsk(req)->accecn_fail_mode = 0;
 	tcp_rsk(req)->syn_ect_rcv = 0;
 	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index e0f2bd2cee9e..8bb4953fc8bd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -501,6 +501,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
 		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
 		tp->syn_ect_snt = treq->syn_ect_snt;
 		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tp->saw_accecn_opt = treq->saw_accecn_opt;
 		tp->prev_ecnfield = treq->syn_ect_rcv;
 		tp->accecn_opt_demand = 1;
 		tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
@@ -555,6 +556,30 @@ static void smc_check_reset_syn_req(const struct tcp_sock *oldtp,
 #endif
 }
 
+u8 tcp_accecn_option_init(const struct sk_buff *skb, u8 opt_offset)
+{
+	unsigned char *ptr = skb_transport_header(skb) + opt_offset;
+	unsigned int optlen = ptr[1] - 2;
+
+	WARN_ON_ONCE(ptr[0] != TCPOPT_ACCECN0 && ptr[0] != TCPOPT_ACCECN1);
+	ptr += 2;
+
+	/* Detect option zeroing: an AccECN connection "MAY check that the
+	 * initial value of the EE0B field or the EE1B field is non-zero"
+	 */
+	if (optlen < TCPOLEN_ACCECN_PERFIELD)
+		return TCP_ACCECN_OPT_EMPTY_SEEN;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+	if (optlen < TCPOLEN_ACCECN_PERFIELD * 3)
+		return TCP_ACCECN_OPT_COUNTER_SEEN;
+	ptr += TCPOLEN_ACCECN_PERFIELD * 2;
+	if (get_unaligned_be24(ptr) == 0)
+		return TCP_ACCECN_OPT_FAIL_SEEN;
+
+	return TCP_ACCECN_OPT_COUNTER_SEEN;
+}
+
 /* This is not only more efficient than what we used to do, it eliminates
  * a lot of code duplication between IPv4/IPv6 SYN recv processing. -DaveM
  *
@@ -716,6 +741,7 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	bool own_req;
 
 	tmp_opt.saw_tstamp = 0;
+	tmp_opt.accecn = 0;
 	if (th->doff > (sizeof(struct tcphdr)>>2)) {
 		tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0, NULL);
 
@@ -893,6 +919,18 @@ struct sock *tcp_check_req(struct sock *sk, struct sk_buff *skb,
 	if (!(flg & TCP_FLAG_ACK))
 		return NULL;
 
+	if (tcp_rsk(req)->accecn_ok && tmp_opt.accecn &&
+	    tcp_rsk(req)->saw_accecn_opt < TCP_ACCECN_OPT_COUNTER_SEEN) {
+		u8 saw_opt = tcp_accecn_option_init(skb, tmp_opt.accecn);
+
+		tcp_rsk(req)->saw_accecn_opt = saw_opt;
+		if (tcp_rsk(req)->saw_accecn_opt == TCP_ACCECN_OPT_FAIL_SEEN) {
+			u8 fail_mode = TCP_ACCECN_OPT_FAIL_RECV;
+
+			tcp_rsk(req)->accecn_fail_mode |= fail_mode;
+		}
+	}
+
 	/* For Fast Open no more processing is needed (sk is the
 	 * child socket).
 	 */
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a76061dc4e5f..8e1535635aab 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1085,6 +1085,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 	/* Simultaneous open SYN/ACK needs AccECN option but not SYN */
 	if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
 		     tcp_ecn_mode_accecn(tp) &&
+		     inet_csk(sk)->icsk_retransmits < 2 &&
 		     sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
 		     remaining >= TCPOLEN_ACCECN_BASE)) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
@@ -1174,7 +1175,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 	smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
 
 	if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
-	    remaining >= TCPOLEN_ACCECN_BASE) {
+	    req->num_timeout < 1 && remaining >= TCPOLEN_ACCECN_BASE) {
 		u32 saving = tcp_synack_options_combine_saving(opts);
 
 		opts->ecn_bytes = synack_ecn_bytes;
@@ -1252,7 +1253,9 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 	}
 
 	if (tcp_ecn_mode_accecn(tp) &&
-	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
+	    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&
+	    tp->saw_accecn_opt &&
+	    !tcp_accecn_opt_fail_send(tp)) {
 		if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >= 2 ||
 		    tp->accecn_opt_demand ||
 		    tcp_accecn_option_beacon_check(sk)) {
-- 
2.34.1


