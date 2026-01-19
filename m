Return-Path: <linux-kselftest+bounces-49394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970ED3B661
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 19:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2DF283001C96
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 18:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E5538F25E;
	Mon, 19 Jan 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="UPwWNHIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011041.outbound.protection.outlook.com [40.107.130.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DF325711;
	Mon, 19 Jan 2026 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849143; cv=fail; b=ITou8QSlqhAVaJ3YNVbI5oCmkvC5yAB1b/Ty9fWOxW+v0VV62dudlSZJiJ/oNdtL/PTVNxUOlkI4FVx/AOGU+2K9q4lPtuXrpaPX6KXS6QieKLDXtz5s5RXH/9urQP/4y1w3uL8sw8ac1PpoZ1yTqqScKVX4X8ee2/aboLiDr6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849143; c=relaxed/simple;
	bh=Pp02bweThsZcCHcWx1JhVwT3kIfUcvPMNeViT2Y+FaA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qsSOMLasbU/6uFK6+uVdpKiJAhq9IxvNF6lldRfgrS8Xe3IkzeHer3HZy2YebNr5Wy2ERvpTtWD4unkoMfbX7GlCz1Y9QwwxF4C5RGGRVOwfZd8tsBqJrYqkJh/1GOu7F6pdJJv1DZ6OCKqX6BQsVvJAnq4Im6sEYuZfbn5spbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=UPwWNHIr; arc=fail smtp.client-ip=40.107.130.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cSESbRP4K33WnO2pJfIw+7tCcAe6U2q+nQEEp1aN0nRHXkJssapNAX0C6wPAmb+P8No4XAvR8m40iSOKV6fWN6nDB/cjcNXjoFBmmyESv/FQJ62T60jh6dlf3TZyTiZa/o640Vvf4WMXMTphzsBSvaT6ciokV8xxE2haC+uHE6KiKTViHb+0O3TO9wnF1Gu3t2tP1xCscC0+DyPYH9N8PLUdPGIlK2wsRlojsHvx4LLvPFLdxs50w/G8BSliAwnJYwZEls3AnQcV6TSPc1OB4KRZkypNIAgU/WUSTTJ4NxCf/MUw5DLbXn4/o10k9dDmcuWFKVzdRBST17681Un7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bitWSCN0K/7mDWq53QWdVlDdA0TQQWqwGGZvlKon82c=;
 b=X1jTL3EczNcRKW21l6DHDRV+/IEutyFp7H+XXGs/fIeO5HeqFLVJmubRCfWBKMSl/S6dqXlZWgsLvP+qU5bGvx+grL3a+/G2e9apyD85RoWH0jpah143G4WMOjV+uBI9pPrcBDj4/Mes6Qqcf1AWvuwdBE6bHOoAJOm+QcqNcRMHH2JsAG/gbJuhJiVVMy+qbTzSRJXngC8IAIA9yh1ne1e8OP0aqnqJpp4J/qHKay5ihBE4Gma8MXd98hO0DwYrpj3lOJDjQNiOVKQ9B4ItBOueIR4I6zBUpRUYgPNS4IEiagC9wimHMLjCRGC0kiqBe3Qjhzh5PI0d2wv2aBU/lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.241) smtp.rcpttodomain=apple.com smtp.mailfrom=nokia-bell-labs.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bitWSCN0K/7mDWq53QWdVlDdA0TQQWqwGGZvlKon82c=;
 b=UPwWNHIrg5XJFtP8SQcicV6Y9gNVjZqo5+UKULp7cTxbIzluGKGmKKAL5Hoc4aG3oKddKHXYIlEbThfM+1cifN20u9+NaI6NjRXLKweJ7xWpVqUqW1Tj5MMChIzqQ+EhGq2V5XpcdjEUp6eL3DdEyUxAT0M9y/ZS8JOYlnKhl0qSZQVdC0rqEz38esDPyTFJptR+2wcmI9CoRNCk0vgk8cecp/8VuQuzK715HXqkYUwc/XUO2sONcAv6qHi+89XLdVT2PlieMqmvyslfLSHpeGpoTmdH4luXAsKuGOQ+t+jRVJjTdxL8pSPCjFkI6Y9Aj9nZLNZq12dbrAE54y3ryA==
Received: from DU2PR04CA0081.eurprd04.prod.outlook.com (2603:10a6:10:232::26)
 by MRWPR07MB11675.eurprd07.prod.outlook.com (2603:10a6:501:93::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 18:58:55 +0000
Received: from DB1PEPF000509FC.eurprd03.prod.outlook.com
 (2603:10a6:10:232:cafe::52) by DU2PR04CA0081.outlook.office365.com
 (2603:10a6:10:232::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 18:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.241 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.241;
 helo=fihe3nok0734.emea.nsn-net.net; pr=C
Received: from fihe3nok0734.emea.nsn-net.net (131.228.2.241) by
 DB1PEPF000509FC.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.1
 via Frontend Transport; Mon, 19 Jan 2026 18:58:55 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0734.emea.nsn-net.net (Postfix) with ESMTP id B0C472014A;
	Mon, 19 Jan 2026 20:58:53 +0200 (EET)
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
Subject: [PATCH v9 net-next 00/15] AccECN protocol case handling series
Date: Mon, 19 Jan 2026 19:58:37 +0100
Message-Id: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FC:EE_|MRWPR07MB11675:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e2e5687-a4df-4419-7e7a-08de578ccb76
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020|18082099003;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?cmNIRVd5WjBWSmRpOW9OUVNxQXJlMkxsMVdLSGk5NS8rcGNXNjYwNE9VdFRu?=
 =?utf-8?B?Qm1OSm1DSUlQYkNTZ2VZYUZPN3c4anNHZXNCMzlMOG5IbG1EcjZNZlkwZjNK?=
 =?utf-8?B?SlA5cW04UTVzRFFrY1RBa1h4RlQ4SEFRRnY0ZHlJcDhrbEo1NmdUY2k1dlFl?=
 =?utf-8?B?YzIrUWdmM2xkREt2bDJiaTV4NUhsSTQ2T2hlNS9Hbk5nblZQYnFtS1dtaHdS?=
 =?utf-8?B?WHVPMWJvN0dNNUh4RG5iTWNXYzh6NGNJbXExUHN1L3g0RlRVTmRQZWxweXJt?=
 =?utf-8?B?eEhvSmxZTktpdUV2VVoxdHl4b1Bsd2k4S3F6RzJNcGhiaWpST2dzRzA3Uzlm?=
 =?utf-8?B?am9JZjA2UDFNbGt5QUVJMzFxU3hhSFJ1cG1VSUV5WEFXYlNxWmVwUW9hRk82?=
 =?utf-8?B?bFA4TVRQTVY3U2M3QzlXZ1FTUTVoU3dvbmhITWxrd1NRSzIwVlI2NFRoRXor?=
 =?utf-8?B?WlAyYjlLcXhrc3BtU2NZL1dsM3F0RlZDOVEyUDlPY2hoQjN2MmRPKzRQQnE0?=
 =?utf-8?B?SlhCZXUwQ1o1YjhIajQzUTRGZVpuSjZHKzdmaWc5Q1FjSnMvTEVyRzZoWHdM?=
 =?utf-8?B?OFhvZDNjWnlxckYzYnNsS3ZuclM1WWR1bmJpZGpIUUJuUjI2a25Banl1aC9J?=
 =?utf-8?B?SWZuTm1WcEdHNmFPdHFlTkJmRW9sYW5sNzNMZXNtRUJuZ3htOHppang4d3dv?=
 =?utf-8?B?akMvaDJPVUN1MU1vTkxHNmN2Vi9kTzhhYVdGU1RtSVdXbDlZZFJrOTZ2SUNF?=
 =?utf-8?B?MGFiMy9CK0NYYXhHalRJd1VibW5lTUxMc2VCZkc1VzFLVzhjMDlWT3EyZXdC?=
 =?utf-8?B?M29iVkNkSUZsVFpIc1VZRVJYWmtBUysvTG0vYkE0ZURDRWUwVE5Kd01QTmEx?=
 =?utf-8?B?NEJtcVlKQzhhVVBZcFZnTjRmM3RzY2pTRWtMKzBlKzRMR05mMWtpYVQrWWF5?=
 =?utf-8?B?ckJrQ2dDY3MzclpUU2JjclFmM2dkamtXZjR0REhmeDB1cjM2dmJ4UGNMdU5K?=
 =?utf-8?B?bzhaYXVJY1A2eG9lNklCTXNSYTVQU2pmZkVJcndabm4reFNnbDRaaUp6cHR0?=
 =?utf-8?B?ajRQSm4zWlNJMnF0M2ZCSS9WY1NFUTNHM3JKOGhNYXAzK0xqTU5WSXdHTEMy?=
 =?utf-8?B?ZS9tb1V5SEE4dlZDVnVxY0UvVVNSbkMwRWIxWHg2WktEZDRFMVlhSU5HM0Mx?=
 =?utf-8?B?aDRsODRZTVpNYkNnSFdSaVB0V3B2NE9nNXp3enNpWU9tRm9FZ2UvL0h4VzNS?=
 =?utf-8?B?dHlISEFIYklBc1hFais0bWF4YXZab1dKODZoTGF5cWJERXloaTNQUGFXWnVX?=
 =?utf-8?B?Yy92Wlh3elhJTkxrWGRXbHVBb3pCYlVaK0FaZnlaUFFwMmRYb2ZFZFRwSmxP?=
 =?utf-8?B?MGtYM2hZR2YrZStsSHBkYmNUOVFRZnF5Vks1dHA1TFQ0QVhvcnpOcDVJZ1Ri?=
 =?utf-8?B?L0JraTI2WkYrS0J5Wi9OcG5NRjNmeXU2THVXU25yVVZlT0hldjBPSUNib2Ur?=
 =?utf-8?B?WEkrWmtiTTM0aDBWTkpSR0prSE9IZndhVmhDc21JR0M4aGZZdDArdmpCWUZF?=
 =?utf-8?B?WUV3Vk1tVXpLcnJRM09QSDVqbk9maUdteEhOUnYxcXFCb1Y5Smx6R1UxL2dx?=
 =?utf-8?B?MFFsUytiU2FnMU9rcDVzVTR2RUpHSVdJdUFtSFVUSm8vZHhhUkZNTVBieTI3?=
 =?utf-8?B?Y2JCNFlnd0xRQndTQklSSk9YZ2JTK0N1NjVKV3BnOXJvcjJJVGtqLzkrZUIv?=
 =?utf-8?B?WUtKdUdtZE85QVU0MXJIS1JtRitxanFuaEppb0FiN3hmZStONEVmWEVQdlB5?=
 =?utf-8?B?TlZOK2JUR0lleFlPOXNiRFJ1Zno5Yzk0clhYWmdMWHhFYlB1K0dsVXQrRmZ2?=
 =?utf-8?B?Z2s4RjF1STEzQkpWNytrdXRKSVV1ZDZoaTVtY0UxcmVlc3J5SmdSZkxCN1NE?=
 =?utf-8?B?eWRuTDFiQ3IzZlRTbGpLbGxacXVYY1RvVlYrTFFwN1lLbmg3dXBQSEd3Yk4x?=
 =?utf-8?B?QUM2cGUrL2hpb3JkWGxXbGU2aENyemw1TkhDT3NaN1pmT21nSVVCZ3ZYUnNa?=
 =?utf-8?B?cWs5MFZUOHlBdXBmYXVEL1pLeUNMaTFocEtoc3VHSjNOeldFMk1QZHhJS2pK?=
 =?utf-8?B?N0pZWFh4eVRvbzZVSnNnR1ZESENweUxHc1NocU15SXBqbGxaZWQ4cURhOXVO?=
 =?utf-8?B?MXQ2amppRjlQMXU0ZXdmNzFqSkppTDdPN0laRVUybTVZSWJTNnhDL2Y4QTRB?=
 =?utf-8?Q?kkknQbYNTKTNZl0e4DyBLu+byaQ5gl2Vq94vy6SfdI=3D?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.241;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0734.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020)(18082099003);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 18:58:55.2577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2e5687-a4df-4419-7e7a-08de578ccb76
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[fihe3nok0734.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB1PEPF000509FC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR07MB11675

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v9 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
v9:
- Add 1 patch for 2-bit tcpi_ecn_mode and 24-bit tcpi_options by reducing bits used by tcpi_accecn_fail_mode and tcpi_accecn_opt_seen in tcp_info (Neal Cardwell <ncardwell@google.com>)
- Add missing comma in patch #3 (Jakub Kicinski <kuba@kernel.org>)
- Update patch message of patch #15

v8:
- Add apcketdrill patch #14 into this series (Paolo Abeni <pabeni@redhat.com> & Jakub Kicinski <kuba@kernel.org>)
- Add helper function in patch #10 (Paolo Abeni <pabeni@redhat.com>)

v7:
- Update comments in #3 (Paolo Abeni <pabeni@redhat.com>)
- Update comments and use synack_type TCP_SYNACK_RETRANS and num_timeout in #9. (Paolo Abeni <pabeni@redhat.com>)

v6:
- Update comment in #3 to highlight RX path is only used for virtio-net (Paolo Abeni <pabeni@redhat.com>)
- Rename TCP_CONG_WANTS_ECT_1 to TCP_CONG_ECT_1_NEGOTIATION to distiguish from TCP_CONG_ECT_1_ESTABLISH (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_CONG_ECT_1_ESTABLISH in #6 to latter patch series (Paolo Abeni <pabeni@redhat.com>)
- Add new synack_type instead of moving the increment of num_retran in #9 (Paolo Abeni <pabeni@redhat.com>)
- Use new synack_type TCP_SYNACK_RETRANS and num_retrans for SYN/ACK retx fallbackk for AccECN in #10 (Paolo Abeni <pabeni@redhat.com>)
- Do not cast const struct into non-const in #11, and set AccECN fail mode after tcp_rtx_synack() (Paolo Abeni <pabeni@redhat.com>)

v5:
- Move previous #11 in v4 in latter patch after discussion with RFC author.
- Add #3 to update the comments for SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN. (Parav Pandit <parav@nvidia.com>)
- Add gro self-test for TCP CWR flag in #4. (Eric Dumazet <edumazet@google.com>)
- Add fixes: tag into #7 (Paolo Abeni <pabeni@redhat.com>)
- Update commit message of #8 and if condition check (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #13 (Paolo Abeni <pabeni@redhat.com>)

v4:
- Add previous #13 in v2 back after dicussion with the RFC author.
- Add TCP_ACCECN_OPTION_PERSIST to tcp_ecn_option sysctl to ignore AccECN fallback policy on sending AccECN option.

v3:
- Add additional min() check if pkts_acked_ewma is not initialized in #1. (Paolo Abeni <pabeni@redhat.com>)
- Change TCP_CONG_WANTS_ECT_1 into individual flag add helper function INET_ECN_xmit_wants_ect_1() in #3. (Paolo Abeni <pabeni@redhat.com>)
- Add empty line between variable declarations and code in #4. (Paolo Abeni <pabeni@redhat.com>)
- Update commit message to fix old AccECN commits in #5. (Paolo Abeni <pabeni@redhat.com>)
- Remove unnecessary brackets in #10. (Paolo Abeni <pabeni@redhat.com>)
- Move patch #3 in v2 to a later Prague patch serise and remove patch #13 in v2. (Paolo Abeni <pabeni@redhat.com>)

---

Chia-Yu Chang (13):
  selftests/net: gro: add self-test for TCP CWR flag
  tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN identifiers
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: add TCP_SYNACK_RETRANS synack_type
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: detect loss ACK w/ AccECN option and add
    TCP_ACCECN_OPTION_PERSIST
  tcp: accecn: add tcpi_ecn_mode and tcpi_option2 in tcp_info
  tcp: accecn: enable AccECN
  selftests/net: packetdrill: add TCP Accurate ECN cases

Ilpo Järvinen (2):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN

 Documentation/networking/ip-sysctl.rst        |   4 +-
 .../networking/net_cachelines/tcp_sock.rst    |   1 +
 include/linux/tcp.h                           |   4 +-
 include/net/inet_ecn.h                        |  20 +++-
 include/net/tcp.h                             |  32 +++++-
 include/net/tcp_ecn.h                         | 108 ++++++++++++------
 include/uapi/linux/tcp.h                      |  26 ++++-
 net/ipv4/inet_connection_sock.c               |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |   4 +-
 net/ipv4/tcp.c                                |  10 ++
 net/ipv4/tcp_cong.c                           |   5 +-
 net/ipv4/tcp_input.c                          |  37 +++++-
 net/ipv4/tcp_minisocks.c                      |  43 ++++---
 net/ipv4/tcp_offload.c                        |   3 +-
 net/ipv4/tcp_output.c                         |  32 ++++--
 net/ipv4/tcp_timer.c                          |   2 +
 tools/testing/selftests/drivers/net/gro.c     |  81 +++++++++----
 tools/testing/selftests/drivers/net/gro.py    |   3 +-
 .../tcp_accecn_2nd_data_as_first.pkt          |  24 ++++
 .../tcp_accecn_2nd_data_as_first_connect.pkt  |  30 +++++
 .../tcp_accecn_3rd_ack_after_synack_rxmt.pkt  |  19 +++
 ..._accecn_3rd_ack_ce_updates_received_ce.pkt |  18 +++
 .../tcp_accecn_3rd_ack_lost_data_ce.pkt       |  22 ++++
 .../net/packetdrill/tcp_accecn_3rd_dups.pkt   |  26 +++++
 .../tcp_accecn_acc_ecn_disabled.pkt           |  14 +++
 .../tcp_accecn_accecn_then_notecn_syn.pkt     |  28 +++++
 .../tcp_accecn_accecn_to_rfc3168.pkt          |  18 +++
 .../tcp_accecn_client_accecn_options_drop.pkt |  34 ++++++
 .../tcp_accecn_client_accecn_options_lost.pkt |  38 ++++++
 .../tcp_accecn_clientside_disabled.pkt        |  12 ++
 ...cecn_close_local_close_then_remote_fin.pkt |  25 ++++
 .../tcp_accecn_delivered_2ndlargeack.pkt      |  25 ++++
 ..._accecn_delivered_falseoverflow_detect.pkt |  31 +++++
 .../tcp_accecn_delivered_largeack.pkt         |  24 ++++
 .../tcp_accecn_delivered_largeack2.pkt        |  25 ++++
 .../tcp_accecn_delivered_maxack.pkt           |  25 ++++
 .../tcp_accecn_delivered_updates.pkt          |  70 ++++++++++++
 .../net/packetdrill/tcp_accecn_ecn3.pkt       |  12 ++
 .../tcp_accecn_ecn_field_updates_opt.pkt      |  35 ++++++
 .../packetdrill/tcp_accecn_ipflags_drop.pkt   |  14 +++
 .../tcp_accecn_listen_opt_drop.pkt            |  16 +++
 .../tcp_accecn_multiple_syn_ack_drop.pkt      |  28 +++++
 .../tcp_accecn_multiple_syn_drop.pkt          |  18 +++
 .../tcp_accecn_negotiation_bleach.pkt         |  23 ++++
 .../tcp_accecn_negotiation_connect.pkt        |  23 ++++
 .../tcp_accecn_negotiation_listen.pkt         |  26 +++++
 .../tcp_accecn_negotiation_noopt_connect.pkt  |  23 ++++
 .../tcp_accecn_negotiation_optenable.pkt      |  23 ++++
 .../tcp_accecn_no_ecn_after_accecn.pkt        |  20 ++++
 .../net/packetdrill/tcp_accecn_noopt.pkt      |  27 +++++
 .../net/packetdrill/tcp_accecn_noprogress.pkt |  27 +++++
 .../tcp_accecn_notecn_then_accecn_syn.pkt     |  28 +++++
 .../tcp_accecn_rfc3168_to_fallback.pkt        |  18 +++
 .../tcp_accecn_rfc3168_to_rfc3168.pkt         |  18 +++
 .../tcp_accecn_sack_space_grab.pkt            |  28 +++++
 .../tcp_accecn_sack_space_grab_with_ts.pkt    |  39 +++++++
 ...tcp_accecn_serverside_accecn_disabled1.pkt |  20 ++++
 ...tcp_accecn_serverside_accecn_disabled2.pkt |  20 ++++
 .../tcp_accecn_serverside_broken.pkt          |  19 +++
 .../tcp_accecn_serverside_ecn_disabled.pkt    |  19 +++
 .../tcp_accecn_serverside_only.pkt            |  18 +++
 ...n_syn_ace_flags_acked_after_retransmit.pkt |  18 +++
 .../tcp_accecn_syn_ace_flags_drop.pkt         |  16 +++
 ...n_ack_ace_flags_acked_after_retransmit.pkt |  27 +++++
 .../tcp_accecn_syn_ack_ace_flags_drop.pkt     |  27 +++++
 .../net/packetdrill/tcp_accecn_syn_ce.pkt     |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect0.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_syn_ect1.pkt   |  13 +++
 .../net/packetdrill/tcp_accecn_synack_ce.pkt  |  28 +++++
 ..._accecn_synack_ce_updates_delivered_ce.pkt |  22 ++++
 .../packetdrill/tcp_accecn_synack_ect0.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_ect1.pkt    |  24 ++++
 .../packetdrill/tcp_accecn_synack_rexmit.pkt  |  15 +++
 .../packetdrill/tcp_accecn_synack_rxmt.pkt    |  25 ++++
 .../packetdrill/tcp_accecn_tsnoprogress.pkt   |  26 +++++
 .../net/packetdrill/tcp_accecn_tsprogress.pkt |  25 ++++
 76 files changed, 1684 insertions(+), 100 deletions(-)
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

-- 
2.34.1


