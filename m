Return-Path: <linux-kselftest+bounces-32934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87797AB6D82
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 15:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3E283A3116
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 May 2025 13:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE04E27A131;
	Wed, 14 May 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BnzfhfeJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A0D27978D;
	Wed, 14 May 2025 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747231012; cv=fail; b=Um4WehKBDOw8R5uzFOPtg94h5TJr/HoU03WZeRrDozpGSVq6nq8dWExKeJde7sWmSCCqHrvXjcmBcAedF/bk70FlmjYPdYvxtlu+Nrj57FuJ47QJzk/H/MFdWpj3PD4nSGMrNP2ufmb57SOYiMZjhdnLJHAhbsJTiH8LpVE5HN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747231012; c=relaxed/simple;
	bh=WQlaKsqDCAQyYWREmtVpxV1lxHa/DjpF/1X7yY2+yF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kPVIkunOr+dHW0jB8iE1ufH1aYvpkwUYmlOchIZ0wocoMR9dfk+cYp17vKvR0lewpTvoOv1wuzZnIIQ2GDsoPzgqsxnPyMwWwqb06ik22CTU5XOKTpBaT750hy0/VCLP4plQc2bGhAfGPUF1sDRepLjr9ZpH4fApKXXgEBsEFb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BnzfhfeJ; arc=fail smtp.client-ip=40.107.21.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc6hJnPaW7hsZBGm/o1JZJreLw4AZTafFplXY/l2NiuTFnEv0hD3aIRz4uwyo2c5euGJcb3HpY3eNqh3sQua2LNvrKRR1gW6EEO7B0psFUpaH8i8HrhbQH7Lu/W6LeSBR+YOqqhFz7Csaj+VuFK92IRovx+O9AApL24GRCGjE+rFiEFPZjTzV2EhymiO+wbDsnrD515FXwn5QA4wPHBIAZnfpot8M+A8wTZ7Hd2qLj/dhy91qSnCvGkZ3RL0p3BWbbGuh5P/TikCOheuf4oDsr9S9qBao69M6cQfrF5AN8aL4r/rjSkUIdkOHFwnuBDNE9tDODBoo1uePlnpFU5L+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7NraifL/0cCQ2CiMNzVfuO/kGreHFc1j21MZvvk9m1c=;
 b=q8Du+Y2JDSEwzSciyjBwU7FvSBw1IX5AhioMzYseWf4JieZ36e6sy2U34dnw5foU84aqQXeQd3QhSfuD//GfwIHqovyzP9w1hK3XCrm32dGStC2zmKI860BnI4WrPqG1bK6A1Lma/nvrXCOv7CcdjD6B0OQu7KxiQetXY2oZXz+NlIopUAJs7Q94smaPUSv074TD9sQL0X5uFHivchO5YmeVxbf3PBcYy0b5rWW1SLhkKKCAQz0LeVzEi/joGzTzD5Rol0lxdliDQ9BzSeElwf1QOhQc96vwR9w+DaMKid9+t1w7RCzwyE4kyAjWGRTmo+GfC9nUfFwDtrRdYJkLEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7NraifL/0cCQ2CiMNzVfuO/kGreHFc1j21MZvvk9m1c=;
 b=BnzfhfeJUZgq4MEXf9sjYkN9EPkgu1Ka6cDxAm47+4Co7f8uNS/4d5QwzGK+8TZeymVlyBZ0hi9q0d4eP9/lYdQBmvosmkiAeG+l/P6bG8Sa+oYzxn2ohvE9/3hyDFfbVfMJ6i/uh54GsR1rY0pZNIY/BnVzNoTBBvmemSEM4cNoDnjJqRO/e02f8jC2cD813vv9vaNlB+/A9c+m6ZTC/olgZKs7hb703jEqcTJ3Eh3OVCCNS9yWjPfjOQrilsf2fBl5TqcSbgtkGRLxnuJisc+IHH8qileO58p83Fs4OwsQy8XqWYqUPthDs2kenA0nG2SuZ1LUCPI/wOmSDlQonQ==
Received: from CWLP123CA0004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:56::16)
 by PAWPR07MB9578.eurprd07.prod.outlook.com (2603:10a6:102:361::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 13:56:47 +0000
Received: from AMS0EPF000001A6.eurprd05.prod.outlook.com
 (2603:10a6:401:56:cafe::ba) by CWLP123CA0004.outlook.office365.com
 (2603:10a6:401:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.23 via Frontend Transport; Wed,
 14 May 2025 13:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.2.240) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 AMS0EPF000001A6.mail.protection.outlook.com (10.167.16.233) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18
 via Frontend Transport; Wed, 14 May 2025 13:56:45 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id D3E412004A;
	Wed, 14 May 2025 16:56:43 +0300 (EEST)
From: chia-yu.chang@nokia-bell-labs.com
To: linux-doc@vger.kernel.org,
	corbet@lwn.net,
	horms@kernel.org,
	dsahern@kernel.org,
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
Subject: [PATCH v7 net-next 00/15] AccECN protocol patch series
Date: Wed, 14 May 2025 15:56:27 +0200
Message-Id: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A6:EE_|PAWPR07MB9578:EE_
X-MS-Office365-Filtering-Correlation-Id: 50df4bab-473d-41c9-0002-08dd92ef29d8
X-LD-Processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TzVtcjRKajJXK2toOEJoNXJFK3JOZ3UwWWVYVmEwZTJXWHFERlZPQ0hlWEkw?=
 =?utf-8?B?Nmh1QWFYdXFKNHNPdHBHRWVkOWRMakJaVFpZU3VyN1czeXNiQlVERHdaY0sy?=
 =?utf-8?B?RlVXWmZvQkdMZkpYaDJjM1hiNXdSNnhEanVzcTFmRlZGYUNCckwyNWsvTTFM?=
 =?utf-8?B?WEpjRE5nWHB4MDdleTYvZUxiY3J3dTU2aytCSmd2L1dFNVo2NlVKWXdmK3ZB?=
 =?utf-8?B?ejlvWGFXdGc0d1A3MCtwQW9MZkQ2TnM0RnhBdzR2dnBUSkhNd25LVTJma3Ur?=
 =?utf-8?B?L1kzc1JoVW5DeVAyL0RROVU3RFdwMURrczc3UCs1K0wxT010aEJVVlVGbmVQ?=
 =?utf-8?B?RVdHNFZQdHg0ZDBxQnhBMm1odG5CaTB0M21TU0FTRC9PYmt1L0ZkczF2aHln?=
 =?utf-8?B?WHVvSXBPTkpydTY4U001T240UXZpbHVLajJUUU9KV2ZwbkZVd05mamlmQXZJ?=
 =?utf-8?B?V1lyY1dIc1lIRTZKMlhVaDFIdmpvdHdMMjNMZXNmK2lOWGZGU1BVME9yMkZt?=
 =?utf-8?B?dDBPUXZTa01lUE5BcmZVQm5qTDFkRjRIdEdlYU9QS042eHN0NkVTeDJxenBQ?=
 =?utf-8?B?S0tuRmJTWmtyR0hGYk9PVVpYUTcvZ3lTK2FDdHVUTGlSVjRydGR5eGFpRTd5?=
 =?utf-8?B?cmF4VzBXdmk5aHovTWl5emk4eGxxOXB4OWNoeFR4Y3l5QmNwckR0VTFlR3pQ?=
 =?utf-8?B?T1hIQlZyTThic1hDd3kwNUFGODNDOWl4RzlBcDMrckUzQUZNOGtCTUdoV0ZK?=
 =?utf-8?B?Q3VrczBrczJFempOcUJ1bE9hdkVEMkpSQmVaY1VpNmI4UnlkR2tJUk1hbFhK?=
 =?utf-8?B?ZDZTLzZPZGRialFHYXVaMUM2MEVrK3crUE0wNlY2YmJlYkJPRXNGS1VXZDhl?=
 =?utf-8?B?dUxkUjM3aE9lNzlzSTB5OXNYZ1Y4TkIwcW1VL09yUTRoREdsM3RkZzdBMzdS?=
 =?utf-8?B?VXYzeUxUc0JiaElpL1pxaTlKUnFBVTdMR0RoSWRkenJpOVFYcjBrTGdlckRG?=
 =?utf-8?B?VEtuRGJJNEQwSUYwQlZlU3cwLzROT0VPcTJqbmcxdTlhdlRWWFR1bDJ5WXc2?=
 =?utf-8?B?bDVuTVVQSm9XMUdOaGVUeFYzK3l2UWhieDc5R3NkblpMR2sxNEhmMXBuU0Jk?=
 =?utf-8?B?dHF3V2IxNS9CK0dlTXpMamJDVHg2RXlGQ1BrMEhhZ3FSWHh1bTVLYmx3TEty?=
 =?utf-8?B?OVZHVHZaRE5hb21qVzVydmQwWk9GWktpNDYyckpOSEN0Qy9iai9aYk1WWEdL?=
 =?utf-8?B?UitGb2tQMFM2NS9lUTVNemNmL3pVS0ptL05NQWdhZ25ab1JIQTY2L0NpR1No?=
 =?utf-8?B?TnlMZG5EQjlZb2JrdTRVN1EySzhpT0xadllwa2lWYzNGczIxMDlEbW9SSjNh?=
 =?utf-8?B?T2JkWDZjdXp6MytmQ2JKU2RicnoxRUVhcFNuWWZhb1BCMkxrUmQ5dDhYU0xH?=
 =?utf-8?B?NVF2VE9KS0ZzcDJKT25menpqTlpXb2IzbFltNTNMdHY3dmJMSWJWZWFTMitP?=
 =?utf-8?B?anlPMDQ1N21PclhRNDRZY0ZnZnc0eGZKVW5NaURnZHFiZ2lmWnFpamJpdnpI?=
 =?utf-8?B?SjFZSVlubDRmYmtuM0hjKzFadzdJOUdKb1NHTURkeFlIbTZFZEdSMFlhbXpu?=
 =?utf-8?B?dVNzV0JWcUs1UkJqdzFPZnZ5bjI0cWdqSTA2T1M1ZFM0eDlXUWl0SE5rL3pa?=
 =?utf-8?B?SVRKaWsrckdQL1BHclBJVlQ2ZzJka2tlb1g3TEREeEtjZ2Y4Wm92ZVVKOU4x?=
 =?utf-8?B?YmZlVDl1VFZLUmRsa3VSSUFMa1B4VmtHM21ydm4vdnFpWXpobGdhMS9nRnlm?=
 =?utf-8?B?VHJuL3FLajlvMnJtcmxJa3Mzbmhxb0tZQWpuUXkzbnhDY25Vb2RvY2tXbGU0?=
 =?utf-8?B?dmxKd3BoMlhnTXJTMloyVzFXekUvVklnSlU5YXlsckladCt2aXhQZXR4eXp6?=
 =?utf-8?B?RDRIODFVUnhweENRUlhpd3FibzdKTG5GSFNtZmRjcEhkbnhYUjh5N1lybXFZ?=
 =?utf-8?B?cVA0bWVoL3BrWEhpVnVHb3doS2dQN2VuQ1g3dGRDU1ZYeUZlMjkxMStZRURh?=
 =?utf-8?B?YzNMcnQxeDVsY1lOL01wZVFrSVJNbisrOHdkUT09?=
X-Forefront-Antispam-Report:
 CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:56:45.2652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50df4bab-473d-41c9-0002-08dd92ef29d8
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A6.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9578

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v7:

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

The full patch series can be found in
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

Best regards,
Chia-Yu

Chia-Yu Chang (2):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: accecn: AccECN option failure handling

Ilpo Järvinen (13):
  tcp: reorganize SYN ECN code
  tcp: fast path functions later
  tcp: AccECN core
  tcp: accecn: AccECN negotiation
  tcp: accecn: add AccECN rx byte counters
  tcp: accecn: AccECN needs to know delivered bytes
  tcp: sack option handling improvements
  tcp: accecn: AccECN option
  tcp: accecn: AccECN option send control
  tcp: accecn: AccECN option ceb/cep heuristic
  tcp: accecn: AccECN ACE field multi-wrap heuristic
  tcp: accecn: try to fit AccECN option with SACK
  tcp: try to avoid safer when ACKs are thinned

 .../networking/net_cachelines/tcp_sock.rst    |  14 +
 include/linux/tcp.h                           |  34 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             | 221 ++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 608 +++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/tcp_minisocks.c                      |  92 ++-
 net/ipv4/tcp_output.c                         | 296 ++++++++-
 net/ipv6/syncookies.c                         |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 14 files changed, 1237 insertions(+), 98 deletions(-)

-- 
2.34.1


