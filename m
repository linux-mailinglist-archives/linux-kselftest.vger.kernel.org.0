Return-Path: <linux-kselftest+bounces-37578-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693B8B0A63C
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 224615C1110
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531312E03F9;
	Fri, 18 Jul 2025 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BEwPVWBb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1052DFF2E;
	Fri, 18 Jul 2025 14:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752848479; cv=fail; b=X5YeR9yHTxsyH9lkswaG2KLazdA1/4ndF+IjxzALWr0vTIIKEUbGN8a4NgOG3kNoobRuMTTCL3NHd3/nHoTLDKaUkw/z2CO2suQeL3fYBSVpSgiyNIxRGERtt6rH6zxbHKP9L/7TXOQmS4elLq8sPvcQZWIaNnY9NnU56jg/m+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752848479; c=relaxed/simple;
	bh=J5CK8m36S0md7WjOpkUAeMGhY1hUR3ckcVWz85fr/IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzZ93GVNuzm5ALfygblA08J3j1PzUBtjtKcufUQRL172NqAETfUldzX8xZmgIk559v5fXRW9AYqh3ZkAYjgguK1SZYMiz50yO3SwlB460WpC1KaxdKxVBIUcxSD6P86Ej1gIBK35cMlgUuJKT69ggXJnBxR1pt6ajXY6UEGhzXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BEwPVWBb; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PClyT0OnSEzxJMCrJGZCvu/ihPG+zW1OUc59LBlENDSbtRdRFaJRWwDeyasRAzZ5284ofrvIu3Hiyz/HRVgxsIeUWOeys1X6QCjuKbh4Lp/7KHewIhliforI0ekSkGWKC9c3HmFYWLtZNk3hHRzouOIaMtKbE2nZbqjf1E93TPrkT34ZpFCwxbuYVlP4z0ic1nZlluodhaZCc0RQkHaLqm5SONalaTyoeT7w3xKc+tx2gRIIKqR0jygVJT+vXzhGu/9CMtg5ibuYj5e75Y9AihySlQ4H7Chw5JUOaOrRur83yn7c4utlPlT3RDMiIHwuJNhHUZ6nG4ZxYkFzNlJ2/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/CYrkUvCErLL+N8IV1S8MGPThtda/BZnDS08TiQVIQ=;
 b=Fqd1q0hHmz/N0WLwh0RrXBpmRVcteOOfloQErsiPGNH58WsjUEioynFllLGirOfk2r/iEcZTc85oRvBzojUMhkUqT6WTaw6sp4RbTjcrh9MGfDGB/Ajq1hqSDhFHB0/nLeKKuQus+/JzHJAti0KLGce4JH/n5G0dVZYS15f1fr5S8wAX5tAbklkuSZeiwg+13eQkwzDfWpmKpP+vAx4oaQ23zqelhVaGM0JwnwEHE7lw3vVkrBrSIPatrtakFioVVSAUtBCVy8lR4enN4tYG5zL9QJEEumn8gZeTjGLz+ynqh/Zq8HJZNX4Ju9HipalRT62TAKllLV+j4HnYeEVRwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/CYrkUvCErLL+N8IV1S8MGPThtda/BZnDS08TiQVIQ=;
 b=BEwPVWBbJZE9Goyp4+afzzoBIVyiRKfXuyRkiGUeYHHZkCSScQ6w3xIER8UxHVK/ryebfeZbb2EsY2UfWcwzFlhAR5N6GtXwVWIEebmhONk9rjXJeth88lg400AkOM0piTyoaaUlNpjJ10bJgilMdxbVUZaayY5bK3kCFBSwKk4lWkBPedAg/B/bFeGrVPc/q0YNfkXhcI0ykMmdJMcFlV6e+OOHPqtYf1lDcyPIsFdtQvJjPNuEqhoPJhTTw9xLF4/pqRhww1z5Tai2KBZLUeUh3R+u0BYoAUbp7VXKA7NXhDgcDePcuPAGHU1X6Pd8Slphgo5EvN1+pu3oBjq0yg==
Received: from AM9P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:21f::16)
 by AM7PR07MB6261.eurprd07.prod.outlook.com (2603:10a6:20b:13f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.41; Fri, 18 Jul
 2025 14:21:14 +0000
Received: from AM4PEPF00025F95.EURPRD83.prod.outlook.com
 (2603:10a6:20b:21f:cafe::4b) by AM9P195CA0011.outlook.office365.com
 (2603:10a6:20b:21f::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Fri,
 18 Jul 2025 14:21:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 AM4PEPF00025F95.mail.protection.outlook.com (10.167.16.4) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.1 via
 Frontend Transport; Fri, 18 Jul 2025 14:21:14 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id 09E79201DE;
	Fri, 18 Jul 2025 17:21:13 +0300 (EEST)
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
Subject: [PATCH v13 net-next 14/14] tcp: accecn: try to fit AccECN option with SACK
Date: Fri, 18 Jul 2025 16:20:32 +0200
Message-Id: <20250718142032.10725-15-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250718142032.10725-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F95:EE_|AM7PR07MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: 75ac9154-ba80-4e48-0fe3-08ddc6065a63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEpEZ1RMUnVqUGZuaUxqT3l1VEkwdi9PaUJDYVVyTFRQcG84TE0xSTVXaDhu?=
 =?utf-8?B?Q2hkbExxVkdia0ErNkttZXJJbTNQY29xTVdhUkdmOHdER1BEajRyV2NGTUlv?=
 =?utf-8?B?U2MzUUplQitJM0RuWllacDNYVlhLQ3VqVEZhWGxDQzNPUjNCQmdFSmJKUGJW?=
 =?utf-8?B?VlNTWSthMkM1bDhEWHcrWTVISytaNG9LNWlaTitkWlZ2KzdVWllLR2RDUWl2?=
 =?utf-8?B?aW9hWHo3V3B2bVZWSmllN1lTbEVFRDRmbEJZZFZGYW1yemJZWGtLSS9jZFd4?=
 =?utf-8?B?c0NlUS9IbnJkZnpPd3IyM1NibFRjZmdPSUhYcDV1VlJNTmRXOWxLdzFXTm0z?=
 =?utf-8?B?Wm11Qml3a1ZZcWxrOUE1N3R1STQzR3E3SjdjWWtJc3RaYmVoSGRCU21KcGtv?=
 =?utf-8?B?SElNUE55N2VNMzdPYUM1VlhsRWdpRFVjSzVSWlB0b3gxSWQwb2lCclNlKzQw?=
 =?utf-8?B?Tk1pdWtTcStRdHlOU05KMk80NjJXT2tJSzg4ckthVXlISmh1dVVwbDRVWDVw?=
 =?utf-8?B?MTFaNDZjb20xakNZYjhTUkV6U1l0c0hEdURVNCtDa05XMEJvaHhFc081REM4?=
 =?utf-8?B?RGVZczI5R0JSVnRSZFNlWFRmaU9vNWdpQUludWZRWklhbE0zcVd0VDR6YnRj?=
 =?utf-8?B?Nm5yNWxLMTg0T0t4Smlqb1lIUjUzMG9zbnF6Qmp0ejdlbVpLSWtLaEVaUm4z?=
 =?utf-8?B?c0ZaWWhXTE8yUjBKelJIVklTQ0YxYlBRNWZwN3U5UnUrU3hNUDJsZUx4MDlj?=
 =?utf-8?B?UURiTnZNVlBQemtqcTBrMHB1SjFSUmtWM2pxSVlVUmUrVHJzYW5wNmJ4TnYw?=
 =?utf-8?B?Qll3ckJMalM1dTZaVEJLSkFUZjViRjUwUXJRekVuT0I3ajI2T2lycEtXS2o2?=
 =?utf-8?B?amNiUkZqVjRLeVhENDFBWjdZZ2Z1dFlmMVBLNnREamkyemNqOHpoaG5lOEh3?=
 =?utf-8?B?K0lMUFZBbE1ZZzVYd0FxNnJYdDFuZ2FZNzhWVUo4NTJlNGNNY3hxNEFLbkoy?=
 =?utf-8?B?bHRZS0JpLzI2RTI4UGE1clp1QTExWmtDQk5ELzlUd1J0RFZuNkszT1N3NDRL?=
 =?utf-8?B?U1EwTkNxZ0diVmNhR211bTVzUmVRaGRrenpRc0VyUUFtbDNnYkdMeTV6dFV5?=
 =?utf-8?B?M3BCTmp4R3ljaVFnWUJpR2c2encvZTdmQXVpZXhhekFnc3F1K00wMGlwckha?=
 =?utf-8?B?QUwrdG5VZC9RcmVTUXczVkE3c2p6Um9KNnVaL2lPYy9BNStVdzZaTEdpSjBS?=
 =?utf-8?B?NHMzTm1QYVJRcUIxTTV6WXhJdEhLTUdtckJYeDhaNlVRYlk4WW10UjBLOStn?=
 =?utf-8?B?Ym1uVi9EREMyZkdua29Ua1ppODBseXlFYUplTzNFZWJjN01UaUphKzlPZlRX?=
 =?utf-8?B?TEJnU3MzazY5Z3A4TGVjVXJMaW8xaGRGMjZlZUQvT2xLeWVUTHMrTGkydnJY?=
 =?utf-8?B?OGF1Q1JmMVdQVFZLRHAvTEp0VUxQS3JtYzdrRUwrbXdSRnl4ckwvZkFaVmt2?=
 =?utf-8?B?dGNtUmpacmtaRTl6V2VsckRrOFI0RCtPcWN3cS9UczBEb2dKazVpZ0lwejJ5?=
 =?utf-8?B?R3hTbG5BVHUwd3lBYXoxcUF6dWpTYVZ3MTJoMWU4eU5EYjZ2YWNtd1NYeVhk?=
 =?utf-8?B?MFcwUDhFajNIdkVudUwxTDFSVVBoZkxhUjFEMkhXeGo0RVp4NE5hWEJ1SmlK?=
 =?utf-8?B?ZHNEZTBlSWJhY1ZIaXhZUlg1cVdZV0s2QnhLNGtEdEJmSWQ2SVJOSkJxcWR3?=
 =?utf-8?B?Z21reER2bW55MUpsWkJRSmI3bW1rZXFYZ0crWFdKVXZ0M3VIRW10RXl5YnF0?=
 =?utf-8?B?MXNYMlZoQURZR1B2M1pvZHZMLzB3UmtGWS94S0UyaWcyKzB1SEtIWVZMaTdw?=
 =?utf-8?B?anNzT3haSm0yNElkTERIU3V1aG04OTZxTGtndDdvSTNUdlpEazdvMGQwZHN6?=
 =?utf-8?B?UmxISVJ4ZVRnQWdpbkw3dUVGZkRhUXE4MzJDM1dOZUlDNmp3eXpJdTJKT3pI?=
 =?utf-8?B?V003OWpNdUhUS3orOERweFhvaVB0SGlMcjRDQ1NndHprL2dsQVBpRmlOR2Mw?=
 =?utf-8?B?SVA0WUhZZ3NFdTJvUFZTZDNPR0pEOFN5WGJvQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 14:21:14.4280
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75ac9154-ba80-4e48-0fe3-08ddc6065a63
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F95.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6261

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
index a309fb87bd49..f335936ba824 100644
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


