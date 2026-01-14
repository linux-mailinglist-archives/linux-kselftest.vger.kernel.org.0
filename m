Return-Path: <linux-kselftest+bounces-48957-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEED6D2034E
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 17:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 988813002945
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 16:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC103A35D4;
	Wed, 14 Jan 2026 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="R7u8t62S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013045.outbound.protection.outlook.com [52.101.72.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729B3A35D7;
	Wed, 14 Jan 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768408171; cv=fail; b=YL5pvQM/mw8WtVFQ5aEjnuyQp17wkU0kAYSA52ae3u9aiz7TWBX2bqED36GkvrkVg3Tt4Qvjwj8FtmmlRagztVLRRt8eFKHePuXVIadDsXYYyGeAC+JrKA3B0IyyfahC35VTk2QBlAuiqYgeRnyykJ1ixIuymrNkoDrlVipUKiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768408171; c=relaxed/simple;
	bh=Z6SZSEVvg7DBT96nv4XGCcobPqedo8XtcIoy4JggvtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3nVkgWIWjW1oOA3TyZ5z1HltcJoDU5x/OC/LJ/miqDtzxub8PuQoYljVp5lCvyV5kiqIEM6HmzAoucvA5ufL1x/benjJQk8IVgj4osrpZhS8yl6GI+cwSxjl/zKze1UGvQTckEHAa0/ltepDik5xDbxSkgQCZ7hXsQ+U6/I7SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=R7u8t62S; arc=fail smtp.client-ip=52.101.72.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MI8Z94IPjF7L5sjS4lhhja/bVCl0E52QLYIXsPv6EsMNxUbw8ducX2/3Uo/ksNdZMOe+8wI44koUKL7fbf40ApIxq0Wq9WWcajxnVuCltpbu/P6vkI9meYzfROy2Q00HEsfsY5tiIbBUqJTu47Ps3UUCMRNuR16KqMpDiltPaWVgWaKb+/A53O+Z3sqQzoMvQOJDms5JPohfGPdojwQ3y7RoZ54Z56YoNLz3sm+YOzy8Tq14lHxkNY93G7dzdNi5F/xMSJi44Lt1foJzmtDsZMOVWrkwd6UMhMsm1d1Z9VzzpfvHqrQFVQiGSAJOeHhIcmT5gGkh5DyJCAzum96PBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iwistvvlrxdl5nqVLqBw/3OJHHd5iK/zDMwCiQktzrI=;
 b=ypuIhJtVu0JL9n8dMvl98k8JzvL9VcupdfgYF8Yy9CROzonqfSeLlKiyneq/o45tbdlswO3vOVIPg3y37HiWhDylFps8XqSxfxJ9jiHtLu6i67NyOMfl8P5uu+IohquXfW6/6T+kyTeMV+bhrotauHNbanxfHXn9bGS5+MjSEfY08ENK+mt96W4WJ2RxKIP41RszFF6XQwAY9n8Lk1HjCS+oOUvuhB8obZYC+wOgVsrtBHo1AgSjg8FGDPwOmOf30B/2M4tJJs8H7k3pU/MIr2SkrmMgnRQWtIqneNDNLVIWFJFlEKRJcwG/8S/jCIXapyBv8u41rAk+5WrLHvwZMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iwistvvlrxdl5nqVLqBw/3OJHHd5iK/zDMwCiQktzrI=;
 b=R7u8t62SvmJEiCKsgsjbrJYg5B19sXlY1wZPgr8nvq3/kvQDscXar0zDqZcPC3f4OIaSo0U8a9Ga0a2KJBhzTIoxM5+H/YnKYA/DoPns31Stja+MpmMoIN0hUbhXNXc9xep+MCj1CP2BnaS1ArRKN23TxJPBWuYVci4nGqXxvWcvEnAYoMdstsXW4E5tsfx/4KG/KRLqLinxSgdDIm6P8IljQCH1CQKF44kNBl9qDlNj/Oihscs5OtTh0bfFtkquegmV9c8edSDD4AIZnCy/FPL/2CbPhbISAg/a7msbGvmgiL+rAhTzd2wK5jnNg17PLk2Ho5f4if/OUquK2DRy2A==
Received: from DU7PR01CA0024.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50f::26) by DB5PR07MB12029.eurprd07.prod.outlook.com
 (2603:10a6:10:650::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 16:29:20 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:50f:cafe::cb) by DU7PR01CA0024.outlook.office365.com
 (2603:10a6:10:50f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.5 via Frontend Transport; Wed,
 14 Jan 2026 16:29:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Wed, 14 Jan 2026 16:29:20 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id ABE1D1C0037;
	Wed, 14 Jan 2026 18:29:18 +0200 (EET)
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
Subject: [PATCH v2 net-next 1/1] selftests/net: packetdrill: add TCP Accurate ECN cases
Date: Wed, 14 Jan 2026 17:29:15 +0100
Message-Id: <20260114162915.94820-2-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|DB5PR07MB12029:EE_
X-MS-Office365-Filtering-Correlation-Id: e205d378-47bb-4b77-bae0-08de538a11ef
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?alhKWkg1SjZxbGtZK2ozZm9sOFVHRHhKUHdvZUlXQjJIQVhWRHlLM01aa0RF?=
 =?utf-8?B?Rm1SOFhETlBNUXJ3MzVVbUllZ1pFMmpneFl2bWVLdkFxQlRiQytyU3R4N0E0?=
 =?utf-8?B?U2JiTkFYVGk0V1k2bG52QzhtanZ0SW9xTTJxMWhNT3NjSnFkOVg3RTBmcjNu?=
 =?utf-8?B?OUhTZEY5VzN2WURyRUY2VWdCL2Y5cEhlMDdkSlJyVEdTUjlKU1UySVBmVUVZ?=
 =?utf-8?B?cWhid1FBRER1TStic3FTd2NHdVU3V2hpQndBVUl1OVhVOXZBU04rRFhBaWt5?=
 =?utf-8?B?MXE4V2IvcG0xbkRTYUgxWkVLalFXMTZsbURBMTducFZFUm4zYmxQSzNldG1a?=
 =?utf-8?B?NkxyTU5MSUczRG5BTXFuVWpVdnRSRmduang5aHhqdXZiNXRsdWQwTkw4NTYz?=
 =?utf-8?B?VmZSdml2cmhaRGNzOW9lN2xUZEl5Z2pjVHdTdjJpT09XdnFNeFBhMzJncDVL?=
 =?utf-8?B?UE1kSWlwLzlWVjhTQkpKMTFOMktPcG45SHNEc01vcFJ2Z1AxZTFCR1RrU3pL?=
 =?utf-8?B?Vi91VkoyZjhIaExTNmYyNnlXZFB1SEQvVmZjK21pZE01WHF1TEJrTnFPY3pC?=
 =?utf-8?B?TDY5R1A2V1pRdEJ3cHZ5bUpNUzNyaGVzdVUwdkhyalBOdVQyd1BLdWVIamlQ?=
 =?utf-8?B?SGVkOHk2VDkvczFCUEprTDh4NEZLWGZDWnp2enhkY2hhU053aDcyZDM3VUxH?=
 =?utf-8?B?RXYva2habGMzQnpjYmxZSVdSL0VvUGZvMzNaNE1kRnZHMGY2MW5aR2s4TDZu?=
 =?utf-8?B?WXhsYlJuYzUyZkxRMG8rcFlMck43UjB0eEZiZHMrUldjWWhWMm8xc0lMVlcw?=
 =?utf-8?B?NmZSM256RGUzTWQxWkZkVGVvMVBhTmQ3S3Y4aWRSTUx0ejRPNlpxNEF2QnRD?=
 =?utf-8?B?MTFHTkIxK09QejQ1cUF0T2NxYlU0TFFpbWZieis2dk5LcHlVU0J4NjR1Mlhy?=
 =?utf-8?B?T1JtUE1WcWppK3pqYXRENSt2Z0lWclczelJvNnV1SXhhVFRveHNjTU15UWtn?=
 =?utf-8?B?dU83azZueGFTS2tBZStVS0FRb1dybnhzY2o5dlhmcndSY1dPRTRBN3lPcTE4?=
 =?utf-8?B?UVBSSHdWMEJ6UnhVZTg1NmVTam5KSE1RVnJZNWQ0QlVCM2poM2UvNDlCclJt?=
 =?utf-8?B?b0RBdDBjUGN2QXgvNVBIZk5idE9BeEM5R1pPZ1RoVHZkbm9ENkUyTnFNUWF1?=
 =?utf-8?B?WkFtRCs5QXNkVk1vNmdxdWU5Y3dnQVFJZk43anc5V2lVWGVQa3pyZEhMZGhj?=
 =?utf-8?B?ZmhwTnVHRmR5d0ZDNUpiMWsrYXRGWHRRQm1LcDM0OElJTDVoL21NTG13SXk3?=
 =?utf-8?B?Z0tNRkNjNkhNbUFyU2pZcHRLZ29oZ2M5ODRJREU1MjkvTGlHSU1WSHFic3NJ?=
 =?utf-8?B?eVpKK3A2L09ZZTBlWFRBYndHSlBhd1BCeWN6eUcvSnV3OXgxWEtwbUlwZ2tP?=
 =?utf-8?B?V0ZCR2xxTk4zODBmWWpQV3FoY1dqNXBXUEF3eUNFenVVKzB2c05DK2FuNWIz?=
 =?utf-8?B?enp5VXBWM2NGemlDc0dmMG9WUGo5WjhOTWZxRGFrY1E2bmpJUmFFQUl3SUwr?=
 =?utf-8?B?djZnOUVLbGxJaXBmT1cyWGo2elBlWkQ2SllDK2NmU2hjZ2FMOGZmb2J5cXBU?=
 =?utf-8?B?aWx0QzRwekp2ZXpQNlZUb3UveVN1UE8zNkZEalZ4WXdNTUtXcEw3R3RKQUVM?=
 =?utf-8?B?R2FSeTVod2pIUVlPNXpSNlBXamppdDREY1J1eUY5c3VHY2h0NnYwZFJHcXF4?=
 =?utf-8?B?L3VWWnVQWC9XQmRubjllOUI0RnFNNG5KeTRVay9CUnYxWkVCK3kxT0hUMS8r?=
 =?utf-8?B?c3R2d2hMYVFYSmdxZG9pTWt4NEwzRW81RC9INmpDRE41cEEyZjhUTk4zem1W?=
 =?utf-8?B?MXBta3BJbTdFanExdTJucWsxY0toUG9lTUpaSGFKMmIzcDdFdzJKS3RMQ0ti?=
 =?utf-8?B?S2JERHpIR3ZLM3FOaUJUTjhoOW9sSlIzQmpZbWpiSmd5NEE0YzVEWlMzWnNH?=
 =?utf-8?B?M1U4dVUrSlgzV0xuMENtcHZCMGRsQlEyRSt1R2NObmRRZGw1NjdsQWhZV1Aw?=
 =?utf-8?B?NzlldXJ1OVVDV1dwQ0g1aExGNG93ODI4eHJKejZ2U1FZMEs5MEZtSW4rSjBZ?=
 =?utf-8?B?TWVCNlRkL3M4R0lGQ3VGbXJsTmRzSXVMM0wxakk1a0lya1pHSkRPNDB3Wmkx?=
 =?utf-8?B?b1kyUmNxOGZWdHE3bmJUdjVHQlZUaGVkQVFzSC96M1RmNG81TWYrS2ExSm83?=
 =?utf-8?Q?b3x1zZmVobOi/1uHbnAiHlkuPxKtFo8aPJBMk89mUs=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 16:29:20.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e205d378-47bb-4b77-bae0-08de538a11ef
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB12029

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Linux Accurate ECN test sets using ACE counters and AccECN options to
cover several scenarios: Connection teardown, different ACK conditions,
counter wrapping, SACK space grabbing, fallback schemes, negotiation
retransmission/reorder/loss, AccECN option drop/loss, different
handshake reflectors, data with marking, and different sysctl values.

Co-developed-by: Ilpo Järvinen <ij@kernel.org>
Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Neal Cardwell <ncardwell@google.com>

--
v2:
- Change patch title
- Rename all AccECN cases with tcp_accecn in the prefix
- Move all cases under tools/testing/selftests/net/packetdrill/
---
 .../tcp_accecn_2nd_data_as_first.pkt          | 24 +++++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  | 30 ++++++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  | 19 +++++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt | 18 +++++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       | 22 ++++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   | 26 +++++++
 .../tcp_accecn_acc_ecn_disabled.pkt           | 14 ++++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          | 18 +++++
 .../tcp_accecn_client_accecn_options_drop.pkt | 34 +++++++++
 .../tcp_accecn_client_accecn_options_lost.pkt | 38 ++++++++++
 .../tcp_accecn_clientside_disabled.pkt        | 12 ++++
 ...cecn_close_local_close_then_remote_fin.pkt | 25 +++++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      | 25 +++++++
 ..._accecn_delivered_falseoverflow_detect.pkt | 31 ++++++++
 .../tcp_accecn_delivered_largeack.pkt         | 24 +++++++
 .../tcp_accecn_delivered_largeack2.pkt        | 25 +++++++
 .../tcp_accecn_delivered_maxack.pkt           | 25 +++++++
 .../tcp_accecn_delivered_updates.pkt          | 70 +++++++++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       | 12 ++++
 .../tcp_accecn_ecn_field_updates_opt.pkt      | 35 ++++++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   | 14 ++++
 .../tcp_accecn_listen_opt_drop.pkt            | 16 +++++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      | 28 ++++++++
 .../tcp_accecn_multiple_syn_drop.pkt          | 18 +++++
 .../tcp_accecn_negotiation_bleach.pkt         | 23 ++++++
 .../tcp_accecn_negotiation_connect.pkt        | 23 ++++++
 .../tcp_accecn_negotiation_listen.pkt         | 26 +++++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  | 23 ++++++
 .../tcp_accecn_negotiation_optenable.pkt      | 23 ++++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        | 20 ++++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      | 27 +++++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt | 27 +++++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     | 28 ++++++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        | 18 +++++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         | 18 +++++
 .../tcp_accecn_sack_space_grab.pkt            | 28 ++++++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    | 39 +++++++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt | 20 ++++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt | 20 ++++++
 .../tcp_accecn_serverside_broken.pkt          | 19 +++++
 .../tcp_accecn_serverside_ecn_disabled.pkt    | 19 +++++
 .../tcp_accecn_serverside_only.pkt            | 18 +++++
 ...n_syn_ace_flags_acked_after_retransmit.pkt | 18 +++++
 .../tcp_accecn_syn_ace_flags_drop.pkt         | 16 +++++
 ...n_ack_ace_flags_acked_after_retransmit.pkt | 27 +++++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     | 27 +++++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   | 13 ++++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  | 28 ++++++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt | 22 ++++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    | 24 +++++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  | 15 ++++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    | 25 +++++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   | 26 +++++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt | 25 +++++++
 58 files changed, 1366 insertions(+)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt

diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
new file mode 100644
index 000000000000..07e9936e70e6
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first.pkt
@@ -0,0 +1,24 @@
+// 3rd ACK + 1st data segment lost, data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
+// 1st data segment lost
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 1000 e0b 1,nop,nop,nop,sack 1001:2001>
++.002 accept(3, ..., ...) = 4
+
++0.2 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1,nop>
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 264
++.001 > [ect0] . 1:1(0) ack 3001 <ECN e1b 1 ceb 3000 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
new file mode 100644
index 000000000000..76b8422b34dc
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_2nd_data_as_first_connect.pkt
@@ -0,0 +1,30 @@
+// 3rd ACK + 1st data segment lost, 2nd data segments with ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 2000) = 2000
+// 1st data segment lost + 2nd gets CE
++.002 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.000 > [ect0] P.5 1005:2001(996) ack 1 <ECN e1b 1 ceb 0 e0b 1, nop>
++0.05 < [ect0] .6 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 996 e1b 1,nop,nop,nop,sack 1005:2001>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.002~+0.1 > [ect0] .5 1:1005(1004) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] .6 1:1(0) ack 2001 win 264 <ECN e0b 1005 ceb 996 e1b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++0~+0.002 > [ect0] P.5 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] .5 1:1001(1000) ack 3001 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++0~+0.01 > [ect0] .5 3001:3001(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
new file mode 100644
index 000000000000..84060e490589
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_after_synack_rxmt.pkt
@@ -0,0 +1,19 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.1 < [ect0] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Our code currently sends a challenge ACK
+// when it receives a SYN in ESTABLISHED state
+// based on the latest SYN
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
new file mode 100644
index 000000000000..d3fe09d0606f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_ce_updates_received_ce.pkt
@@ -0,0 +1,18 @@
+// Third ACK CE increases r.cep
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ce] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] WAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
new file mode 100644
index 000000000000..d28722db42b1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_ack_lost_data_ce.pkt
@@ -0,0 +1,22 @@
+// 3rd ACK lost, CE for the first data segment
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// 3rd ACK lost
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.05 < [ce] EAP. 1001:2001(1000) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.001 > [ect0] EWA. 1:1(0) ack 2001 <ECN e1b 1 ceb 2000 e0b 1 ,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
new file mode 100644
index 000000000000..a4d808116e34
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_3rd_dups.pkt
@@ -0,0 +1,26 @@
+// Test SYN/ACK rexmit triggered 3rd ACK duplicate + CE on first data seg
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// SYN/ACK rexmitted => two 3rd ACKs in-flight
++1.0~+1.1 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+// Delivered 1st 3rd ACK
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Duplicate 3rd ACK delivered
++1.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
new file mode 100644
index 000000000000..509838d5a4b2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_acc_ecn_disabled.pkt
@@ -0,0 +1,14 @@
+// Test that when accurate ECN is disabled,
+// client uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
new file mode 100644
index 000000000000..10728114b11b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_then_notecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
new file mode 100644
index 000000000000..04d928f0d44d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_accecn_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test AccECN -> RFC3168 fallback when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
new file mode 100644
index 000000000000..788af6bea69c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_drop.pkt
@@ -0,0 +1,34 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox drops AccECN option and client
+// reverts to ACE flags only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+sysctl -q net.ipv4.tcp_ecn_option_beacon=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <ECN e1b 1 ceb 0 e0b 2001,nop,nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 1001 <nop,nop,sack 1:1001>
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EA. 1:1(0) ack 2001
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
new file mode 100644
index 000000000000..d04e11bba37c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_client_accecn_options_lost.pkt
@@ -0,0 +1,38 @@
+// Client negotiates AccECN and starts sending
+// AccECN option in last ACK and data segments
+// Middlebox accepts AccECN option but some packets
+// are lost due to congestion. Client should
+// continue to send AccECN option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1024,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Send
++0.01 write(4, ..., 3000) = 3000
++.002 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 1013:2025(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 2025:3001(976) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// First two segments were lost due to congestion as SACK was
+// received acknowledging 3rd segment
++0.1 < [ect0] .5 1:1(0) ack 1 win 264 <ECN e1b 1 ceb 0 e0b 977,nop,nop,nop,sack 2025:3001>
+
+// Since data with option was SACKed, we can
+// continue to use AccECN option for the rest of
+// the connection. This one is a rexmt
++.02~+0.5 > [ect0] .5 1:1013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.1 < [ect0] .5 1:1(0) ack 3001 win 264 <ECN e1b 1 ceb 0 e0b 3000,nop>
+
+// Send new data, it should contain AccECN option
++0.01 write(4, ..., 2000) = 2000
++.002 > [ect0] .5 3001:4013(1012) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.002 > [ect0] P.5 4013:5001(988) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
new file mode 100644
index 000000000000..c00b36d6a833
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_clientside_disabled.pkt
@@ -0,0 +1,12 @@
+// AccECN sysctl server-side only, no ECN/AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,nop,nop,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
new file mode 100644
index 000000000000..f9c27f39f354
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_close_local_close_then_remote_fin.pkt
@@ -0,0 +1,25 @@
+// Test basic connection teardown where local process closes first:
+// the local process calls close() first, so we send a FIN, and receive an ACK.
+// Then we receive a FIN and ACK it.
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+ +.01...0.011 connect(3, ..., ...) = 0
+   +0 > [noecn] SEWA 0:0(0) <...>
+   +0 < [ect1] SW. 0:0(0) ack 1 win 32768 <mss 1000,nop,wscale 6,nop,nop,sackOK>
+   +0 > [ect0] EW. 1:1(0) ack 1
+
+   +0 write(3, ..., 1000) = 1000
+   +0 > [ect0] P5. 1:1001(1000) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1001 win 257
+
+   +0 close(3) = 0
+   +0 > [ect0] F5. 1001:1001(0) ack 1
+   +0 < [ect0] .5 1:1(0) ack 1002 win 257
+
+   +0 < [ect0] F5. 1:1(0) ack 1002 win 257
+   +0 > [ect0] . 1002:1002(0) ack 2
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
new file mode 100644
index 000000000000..6d771234124a
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_2ndlargeack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 1461 win 264
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 8, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
new file mode 100644
index 000000000000..76384f52b021
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_falseoverflow_detect.pkt
@@ -0,0 +1,31 @@
+// Test false overflow detection with option used to rule out overflow
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
+// Stop sending option to allow easier testing
++0 `sysctl -q net.ipv4.tcp_ecn_option=0`
+
++0.002 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+
++0.05 < [ect0] .5 1:1(0) ack 1460 win 264 <ECN e0b 1461 ceb 0 e1b 1,nop>
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264 <ECN e0b 14601 ceb 0 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 14600, tcpi_delivered_e0_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
new file mode 100644
index 000000000000..8bce5dce35a2
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack.pkt
@@ -0,0 +1,24 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
++0.05 < [ect0] .5 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
new file mode 100644
index 000000000000..5f2b147214f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_largeack2.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (> ACE field max)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .6 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
new file mode 100644
index 000000000000..fd07bdc14f37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_maxack.pkt
@@ -0,0 +1,25 @@
+// Test a large ACK (at ACE field max delta)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 14600) = 14600
++.002 > [ect0] P.5 1:14601(14600) ack 1
+  // Fake CE
++0.05 < [ect0] .4 1:1(0) ack 14601 win 264
+
++0.01 %{ assert tcpi_delivered_ce == 7, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
new file mode 100644
index 000000000000..cb1e70ff2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_delivered_updates.pkt
@@ -0,0 +1,70 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE
++0.05 < [ect0] WA. 1:1(0) ack 1001 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 1000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect0
++0.05 < [ect0] WA. 1:1(0) ack 2001 win 264 <ECN e0b 1001 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 1, tcpi_delivered_ce
+assert tcpi_delivered_e0_bytes == 1000, tcpi_delivered_e0_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 2001:3001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] EWA. 1:1(0) ack 3001 win 264 <ECN e0b 1001 ceb 2000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 2000, tcpi_delivered_ce_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 3001:4001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ect1
++0.05 < [ect0] EWA. 1:1(0) ack 4001 win 264 <ECN e0b 1001 ceb 2000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 2, tcpi_delivered_ce
+assert tcpi_delivered_e1_bytes == 1000, tcpi_delivered_e1_bytes
+}%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 4001:5001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake ce
++0.05 < [ect0] . 1:1(0) ack 5001 win 264 <ECN e0b 1001 ceb 3000 e1b 1001,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 3, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 3000, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
new file mode 100644
index 000000000000..6627c7bb2d26
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn3.pkt
@@ -0,0 +1,12 @@
+// Test that tcp_ecn=4 uses RFC3168 ECN for SYN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=4
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.05 connect(4, ..., ...) = 0
+
++.002 > SEW 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
new file mode 100644
index 000000000000..51879477bb50
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ecn_field_updates_opt.pkt
@@ -0,0 +1,35 @@
+// Test basic AccECN CEP/CEB/E0B/E1B functionality & CEP wrapping
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.05 < [ce] EAP. 1:1001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 1001 <ECN e1b 1 ceb 1000 e0b 1,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect0] EAP. 1001:2001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] WA. 1:1(0) ack 2001 <ECN e1b 1 ceb 1000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 2001:3001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 3001 <ECN e1b 1 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ect1] EAP. 3001:4001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] EWA. 1:1(0) ack 4001 <ECN e1b 1001 ceb 2000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
+
++0.05 < [ce] EAP. 4001:5001(1000) ack 1 win 257 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] . 1:1(0) ack 5001 <ECN e1b 1001 ceb 3000 e0b 1001,nop>
+   +0 read(4, ..., 1000) = 1000
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
new file mode 100644
index 000000000000..0c72fa4a1251
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_ipflags_drop.pkt
@@ -0,0 +1,14 @@
+// Test IP flags drop
+--tolerance_usecs=50000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 1.1 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02 ~ +1.1 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
new file mode 100644
index 000000000000..171f9433e55f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_listen_opt_drop.pkt
@@ -0,0 +1,16 @@
+// SYN/ACK option drop test
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.02 ~+2 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+5 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.02 ~+8 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
new file mode 100644
index 000000000000..0f65cf56cd2b
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_ack_drop.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++4~+4.4 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK after sending 3rd retransmission, not a blackhole
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
new file mode 100644
index 000000000000..c008b8785554
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_multiple_syn_drop.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags and without
+// ACE flags got dropped. Although we disable
+// ECN, we shouldn't consider this as blackholed
+// as these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 3.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8> 
++.02~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++.02~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
new file mode 100644
index 000000000000..37dabc4603c8
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_bleach.pkt
@@ -0,0 +1,23 @@
+// Test AccECN flags bleach
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] . 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [noecn] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
new file mode 100644
index 000000000000..5b14892fda51
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 0,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
new file mode 100644
index 000000000000..25f7cb2feb25
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_listen.pkt
@@ -0,0 +1,26 @@
+// Test basic AccECN negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
new file mode 100644
index 000000000000..50e08c492a69
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_noopt_connect.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation without option
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
new file mode 100644
index 000000000000..2904f1ba9975
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_negotiation_optenable.pkt
@@ -0,0 +1,23 @@
+// Test basic AccECN negotiation, late option enable
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++.05 < [ect0] EAP. 1:1(0) ack 1001 win 256 <ECN e0b 1001 ceb 0 e1b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
new file mode 100644
index 000000000000..64e0fc1c1f14
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_no_ecn_after_accecn.pkt
@@ -0,0 +1,20 @@
+// Test client behavior on receiving a non ECN SYN-ACK
+// after receiving an AccECN SYN-ACK and moving to
+// ESTABLISHED state
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+// Receive an AccECN SYN-ACK and move to ESTABLISHED
++0.05 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
+// Receive a non ECN SYN-ACK and send a challenge ACK with ACE feedback
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
new file mode 100644
index 000000000000..f407c629a3f7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noopt.pkt
@@ -0,0 +1,27 @@
+// Test basic AccECN negotiation with option off using sysctl
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1
++0.05 < [ect0] EAP. 1:1(0) ack 1001 win 320
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1001:2001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
new file mode 100644
index 000000000000..32454e7187f9
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_noprogress.pkt
@@ -0,0 +1,27 @@
+// Test no progress filtering
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 1000 e1b 1,nop>
+
++0.01 %{
+assert tcpi_delivered_ce == 0, tcpi_delivered_ce
+assert tcpi_delivered_ce_bytes == 0, tcpi_delivered_ce_bytes
+}%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
new file mode 100644
index 000000000000..6597d5f2d778
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_notecn_then_accecn_syn.pkt
@@ -0,0 +1,28 @@
+// Test that SYN-ACK with ACE flags and without
+// ACE flags got dropped. Although we disable ECN,
+// we shouldn't consider this as blackholed as
+// these are dropped due to congestion
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] S 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN
++0.1 < [ect0] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
+// Write with AccECN option but with ip-noecn since we received one SYN with ACE=0
++0.01 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
new file mode 100644
index 000000000000..0f97dfcfa82d
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_fallback.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 fallback when sysctl asks for AccECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
new file mode 100644
index 000000000000..9baffdd66fe5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_rfc3168_to_rfc3168.pkt
@@ -0,0 +1,18 @@
+// Test RFC3168 ECN when sysctl asks for RFC3168 ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=1
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEW 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SE. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.05 < . 1:1(0) ack 1 win 320
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] P. 1:1001(1000) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
new file mode 100644
index 000000000000..3fc56f9c6a6f
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab.pkt
@@ -0,0 +1,28 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
++.01 < [ect0] EAP. 3001:4001(1000) ack 1 win 264
++0.002 > [ect0] EA. 1:1(0) ack 1 <ECN e1b 1001 ceb 0 e0b 1001,nop,nop,nop,sack 3001:4001 1001:2001>
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 1001,nop,nop,nop,sack 5001:6001 3001:4001 1001:2001>
+// DSACK works?
++.01 < [ect0] EAP. 5001:6001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:6001 5001:6001 3001:4001>
++.01 < [ect1] EAP. 6001:7001(1000) ack 1 win 264
++0.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 2001 ceb 1000 e0b 2001,nop,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
new file mode 100644
index 000000000000..1c075b5d81ae
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_sack_space_grab_with_ts.pkt
@@ -0,0 +1,39 @@
+// Test SACK space grab to fit AccECN option
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 100 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 100,ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// One SACK block should allow all 3 AccECN fields:
++.01 < [ect1] EAP. 1001:2001(1000) ack 1 win 264 <nop,nop,TS val 3 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 160 ecr 2,ECN e1b 1001 ceb 0 e0b 1,nop,nop,nop,sack 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 3001:4001(1000) ack 1 win 264 <nop,nop,TS val 4 ecr 100>
++0.002 > [ect0] EA. 1:1(0) ack 1 <nop,nop,TS val 172 ecr 2,ECN e1b 2001 ceb 0,nop,nop,sack 3001:4001 1001:2001>
+
+// Two SACK blocks should fit w/ AccECN if we only need to use 2 AccECN fields: check CE arriving.
++.01 < [ce] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 184 ecr 2,ECN e1b 2001 ceb 1000,nop,nop,sack 5001:6001 3001:4001>
+
+// Check that DSACK works, using 2 SACK blocks in total, if we only need to use 2 AccECN fields: check ect1 arriving.
++.01 < [ect1] EAP. 5001:6001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 196 ecr 2,ECN e1b 3001 ceb 1000,nop,nop,sack 5001:6001 5001:6001>
+
+// Check the case where the AccECN option doesn't fit, because sending ect0
+// with order 1 would rquire 3 AccECN fields,
+// and TS (12 bytes) + 2 SACK blocks (20 bytes) + 3 AccECN fields (2 + 3*3 bytes) > 40 bytes.
+// That's OK; Linux TCP AccECN is optimized for the ECT1 case, not ECT0.
++.01 < [ect0] EAP. 6001:7001(1000) ack 1 win 264 <nop,nop,TS val 5 ecr 100>
++0.002 > [ect0] WA. 1:1(0) ack 1 <nop,nop,TS val 204 ecr 2,nop,nop,sack 5001:7001 3001:4001 1001:2001>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
new file mode 100644
index 000000000000..6b88ab78bfce
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled1.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 1|0|1 (AE is unused for classic ECN)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [ect0] F.5 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
new file mode 100644
index 000000000000..d24ada008ece
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_accecn_disabled2.pkt
@@ -0,0 +1,20 @@
+// Test against classic ECN server
+// Not-ECT on SYN and server sets 0|0|1
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SE. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [ect0] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++0 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
new file mode 100644
index 000000000000..a20d7e890ee1
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_broken.pkt
@@ -0,0 +1,19 @@
+// Test against broken server (1|1|1)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] SEWA. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <...>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
new file mode 100644
index 000000000000..428255bedab7
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_ecn_disabled.pkt
@@ -0,0 +1,19 @@
+// Test against Non ECN server (0|0|0)
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,sackOK,TS val 700 ecr 100,nop,wscale 8>
++.002 > [noecn] . 1:1(0) ack 1 <nop, nop, TS val 200 ecr 700>
+
++0 write(4, ..., 100) = 100
++.002 > [noecn] P. 1:101(100) ack 1 <nop,nop,TS val 300 ecr 700>
++0 close(4) = 0
+
++.002 > [noecn] F. 101:101(0) ack 1 <nop,nop,TS val 400 ecr 700>
++0.1 < [noecn] R. 1:1(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
new file mode 100644
index 000000000000..e9a5a0d3677c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_serverside_only.pkt
@@ -0,0 +1,18 @@
+// Test AccECN with sysctl set to server-side only
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=5
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..412fa903105c
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,18 @@
+// Test that SYN with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got SYN-ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
+
++0.1 < [noecn] SW. 0:0(0) ack 1 win 32767 <mss 1016,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
new file mode 100644
index 000000000000..4622754a2270
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ace_flags_drop.pkt
@@ -0,0 +1,16 @@
+// Test that SYN with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 2.1 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++1~+1.1 > [noecn] S 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.1 < [noecn] S. 0:0(0) ack 1 win 32767 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0~+0.01 > [noecn] . 1:1(0) ack 1
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
new file mode 100644
index 000000000000..ee15f108cafe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_acked_after_retransmit.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags was Acked
+// after 2nd retransmission. In this case,
+// since we got the last ACK that supports Accurate
+// ECN, we consider this as successful negotiation
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with ACE flags, state should be set to negotiation succeeded
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
new file mode 100644
index 000000000000..3807e7fafafb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ack_ace_flags_drop.pkt
@@ -0,0 +1,27 @@
+// Test that SYN-ACK with ACE flags got dropped
+// We retry one more time with ACE and then
+// fallback to disabled ECN
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// SYN-ACK maybe getting blackholed, disable ECN
++2~+2.2 > [noecn] S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
+
+// Received an ACK with no ACE flags, state should be set to blackholed
++0.1 < [noecn] . 1:1(0) ack 1 win 320
++0 accept(3, ..., ...) = 4
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
new file mode 100644
index 000000000000..dc83f7a18180
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ce.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ce] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SWA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
new file mode 100644
index 000000000000..e63a8d018c37
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect0.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect0] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SA. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
new file mode 100644
index 000000000000..23c0e43b3dbe
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_syn_ect1.pkt
@@ -0,0 +1,13 @@
+// Test AccECN ECN field reflector in SYNACK
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < [ect1] SEWA 0:0(0) win 32792 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SEW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
new file mode 100644
index 000000000000..44add14c57f4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce.pkt
@@ -0,0 +1,28 @@
+// Test SYNACK CE & received_ce update
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > [noecn] SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ce] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] WA. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6  101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.6 101:201(100) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
+
++0.1  < [ect1] P.5 201:301(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .6 201:201(0) ack 101 <ECN e1b 101 ceb 0 e0b 101,nop,nop,nop,sack 201:301>
+
++0.01 < [ce] .6 401:501(100) ack 201 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
++.002 > [ect0] .7 201:201(0) ack 101 <ECN e1b 101 ceb 100 e0b 101,nop,nop,nop,sack 401:501 201:301>
+
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
new file mode 100644
index 000000000000..5fd77f466572
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ce_updates_delivered_ce.pkt
@@ -0,0 +1,22 @@
+// Reflected SYNACK CE mark increases delivered_ce
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_fallback=0
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
++0.05 < SEWA 0:0(0) win 32767 <mss 1050,nop,nop,sackOK,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+// Fake ce for prev, ECT validator must be disabled for this to work
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
new file mode 100644
index 000000000000..f6ad1ea5c0c4
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect0.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect0] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] A. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect0] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect0] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 1 ceb 0 e0b 101,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F.5 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
new file mode 100644
index 000000000000..7ecfc5fb9dbb
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_ect1.pkt
@@ -0,0 +1,24 @@
+// Test SYN=0 reflector
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < [ect1] SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] EW. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P.5 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
++0.05 < [ect1] P.5 1:1(0) ack 101 win 256 <ECN e0b 101 ceb 0 e1b 1,nop>
+
++0.01 < [ect1] P.5 1:101(100) ack 101 win 256 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 > [ect0] .5 101:101(0) ack 101 <ECN e1b 101 ceb 0 e0b 1,nop>
++0 read(4, ..., 100) = 100
+
++0 close(4) = 0
++0 > F5. 101:101(0) ack 101 <...>
++0.1 < R. 101:101(0) ack 102 win 4242
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
new file mode 100644
index 000000000000..9e0959782ef5
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rexmit.pkt
@@ -0,0 +1,15 @@
+// Test 3rd ACK flags when SYN-ACK is rexmitted
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 4
++.002 ... 0.052 connect(4, ..., ...) = 0
+
++.002 > SEWA 0:0(0) <mss 1460,sackOK,TS val 100 ecr 0,nop,wscale 8>
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
+
++0.05 < SW. 0:0(0) ack 1 win 32767 <mss 1460,ECN e0b 1 ceb 0 e1b 1,nop,nop,nop,sackOK,nop,wscale 8>
++.002 > [ect0] W. 1:1(0) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
new file mode 100644
index 000000000000..a5a41633af07
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_synack_rxmt.pkt
@@ -0,0 +1,25 @@
+// Test that we retransmit SYN-ACK with ACE and without
+// AccECN options after
+// SYN-ACK was lost and TCP moved to TCPS_SYN_RECEIVED
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+sysctl -q net.ipv4.tcp_ecn_option=2
+`
+
++0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
++0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
++0 bind(3, ..., ...) = 0
++0 listen(3, 1) = 0
+
++0 < [noecn] SEWA 0:0(0) win 32792 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++.002 > [noecn] SW. 0:0(0) ack 1 <mss 1460,ECN e1b 1 ceb 0 e0b 1,nop,nop,nop,sackOK,nop,wscale 8>
+
+// Retransmit SYN-ACK without option
++1~+1.1 > [noecn] SW. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 8>
++0.1 < [noecn] W. 1:1(0) ack 1 win 320 <ECN e0b 1 ceb 0 e1b 1,nop>
++.002 accept(3, ..., ...) = 4
+
+// We try to write with AccECN option
++0.01 write(4, ..., 100) = 100
++.002 > [ect0] P5. 1:101(100) ack 1 <ECN e1b 1 ceb 0 e0b 1,nop>
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
new file mode 100644
index 000000000000..f3fe2f098966
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsnoprogress.pkt
@@ -0,0 +1,26 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+--tolerance_usecs=7000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
diff --git a/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
new file mode 100644
index 000000000000..1446799d2481
--- /dev/null
+++ b/tools/testing/selftests/net/packetdrill/tcp_accecn_tsprogress.pkt
@@ -0,0 +1,25 @@
+// Test TS progress filtering
+--tcp_ts_tick_usecs=1000
+
+`./defaults.sh
+sysctl -q net.ipv4.tcp_ecn=3
+`
+
+    0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+   +0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+   +0 bind(3, ..., ...) = 0
+   +0 listen(3, 1) = 0
+
+   +0 < SEWA 0:0(0) win 32792 <mss 1050,sackOK,TS val 1 ecr 0,nop,wscale 8>
++.002 > SW. 0:0(0) ack 1 <mss 1460,sackOK,TS val 10 ecr 1,ECN e1b 1 ceb 0 e0b 1,nop,nop,wscale 8>
++0.05 < [ect0] W. 1:1(0) ack 1 win 264 <nop,nop,TS val 2 ecr 10>
++.002 accept(3, ..., ...) = 4
+
++0.01 %{ assert tcpi_delivered_ce == 0, tcpi_delivered_ce }%
+
++0.01 write(4, ..., 1000) = 1000
++.002 > [ect0] EAP. 1:1001(1000) ack 1 <nop,nop,TS val 83 ecr 2>
+  // Fake CE and claim no progress
++0.05 < [ect0] WA. 1:1(0) ack 1 win 264 <nop,nop,TS val 3 ecr 83>
+
++0.01 %{ assert tcpi_delivered_ce == 1, tcpi_delivered_ce }%
-- 
2.34.1


