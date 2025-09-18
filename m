Return-Path: <linux-kselftest+bounces-41868-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5671FB85F65
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 18:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CEF97AF249
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA897314D34;
	Thu, 18 Sep 2025 16:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="L/MI4hPj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013060.outbound.protection.outlook.com [52.101.83.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6E312836;
	Thu, 18 Sep 2025 16:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212502; cv=fail; b=aIALtu5qMeN49IUN3dcZN1jxwAeTFzub+42G+yxENub9RuiIUN9t9XX1fAUb6px9Cc7DjDeOXNtbkog75GiKR0IInU43ZcYBdqHYFnRPuk6MM6icaM8GhFQPeZmTZZkYq0xZCBKjQWDci2Etawck/8B5ADSZnD5ixKXCC+CiP7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212502; c=relaxed/simple;
	bh=VxEvj2noUBZZ3VLVLhObYr+XwHtnWlwRBEaKarmbvnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hYOZHeFTASMxSMTI3XrfIB+MH68dmaDN3eTZAhLg1UcRo7od8IRPZUGkap5BP0wpx2jnJojTeikTIYZEeSBxjeoADyYZ0Zql2OzEAvLLt8qZWDqOQ+FRvgVLB0nupNCreFILG1cyiRx+FpkUDh+SNF9iw3JRTHdFw92ZDdwSdSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=L/MI4hPj; arc=fail smtp.client-ip=52.101.83.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UoJ01TUgqIlwBxmAluHaNKNQk+MTKp/BC3IKsDEkhxZia+gzQ0g5x7KrsQkyOkUCmBGvnpVHwDnbAbcMOumDmgGntXAJl9iFC7QP1sAp/J1ssohQ2Wm5gaQ0RE2SZ9oICHs5911tqTp1uLY9YDXq74goBHHg9O+3pI3HJ8Vg5Cp+HyRpYSLaBxuXClG66cdwGAa1+5va+b2vDd+uOAfQgdTuUuW0C2jEaKaZHWS4qoQhijii+QtlufA1wZpcKtetvVC3ye7BQYCKqVF8ZRApWxo57A4THKx5KgEJ3gE1fuF7NmvzAHu14m9zAxKW0YtvXvgE6vUquOTGLWqwMq1Xqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y697nvhJ3awJ0wOZdYsic+UlfgJM1iAIkamvrbSgEvM=;
 b=rcljBqaFEM5JItc4EEUlnvSR4eJ4L69CwF25n3yZemqIw8KeG9zdI918l2JxgasJbJZwGH2zTNxSrA4KwwOGWWY7oQwjkmGQ0KDfw5FzLo9S4XUfdtKB4qGRJf9iW6EjOusF4pW5kMLr/ktp+xE8diDFYbsUdTzKADvbNxJw120ZxQ8w3CM4D1MVq570ieElOUtNe1blWA5n8TRQ9hlMTiw2ALbwjO36G2wYfbCjrIZBI58Vj/xUdCNFFLndBE6QHLqH8KhZ7hnoSn/sWqlsgiGCvMy0KVGE5RgU2GzE58qqFIYwzW4voCj7gJ4ns2EKsNCoSuSEOk+/jsU+Eo+92w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.2.240) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y697nvhJ3awJ0wOZdYsic+UlfgJM1iAIkamvrbSgEvM=;
 b=L/MI4hPj6+wQRtG1whkQyb5KIe7EEU9itkhIYRQ0flwA7QmjHGPlCDuj8EOV7nLWGvgDKKRX4lX2ZR8eoX0A7yKtQHP/doC/3AoZS7qLqSuauwI1Cw5HE49ycMryNm0D/RBiUZ4Oy5QRiF+K9Dzr9Zt4b6L+ptIOmk4Ks16gQ703vWnN/r1XkhkPIJ7F23FqJVFtsS/HZAJbUH1fndabiZGPwepWyIt54sTemIRhN+SQ2HHsd2YBRso2bp8355Zmx62XhQ9FF8vTUW6DSQTgF7gwZQrubAq7vRt9mUw52d9DcyfhFptfJaFMNn5w4eWZ4XSChEfZN2zfFSCAlIteLA==
Received: from DB9PR05CA0002.eurprd05.prod.outlook.com (2603:10a6:10:1da::7)
 by PA1PR07MB11096.eurprd07.prod.outlook.com (2603:10a6:102:501::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 16:21:37 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:1da:cafe::1b) by DB9PR05CA0002.outlook.office365.com
 (2603:10a6:10:1da::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 16:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.2.240 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.2.240;
 helo=fihe3nok0735.emea.nsn-net.net; pr=C
Received: from fihe3nok0735.emea.nsn-net.net (131.228.2.240) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Thu, 18 Sep 2025 16:21:37 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fihe3nok0735.emea.nsn-net.net (Postfix) with ESMTP id CFCC220107;
	Thu, 18 Sep 2025 19:21:35 +0300 (EEST)
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
Subject: [PATCH v2 net-next 00/14] AccECN protocol case handling series
Date: Thu, 18 Sep 2025 18:21:19 +0200
Message-Id: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB3PEPF0000885D:EE_|PA1PR07MB11096:EE_
X-MS-Office365-Filtering-Correlation-Id: 575ca6f8-8501-4526-cf90-08ddf6cf712f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODVlSkRFSGtBZFRrTXoyR2VVTDMxTGF0RmJxM1R3L2tNZmpNakI2MnhMQ0Js?=
 =?utf-8?B?QW43aWpzR0p3b3M1Uk14RE4xTUlZbFFxb3Zsc1puQ3U0dXdLZTYwTHNLVTRh?=
 =?utf-8?B?L25SRkRKZ2JJOHBrOTI5Q3o3Nmk2Q1h5bEtkYWRldkc1VWVuQmVtd0tSL3ZU?=
 =?utf-8?B?OCswRFJmRnlnMnFyYjVYWGJ4a0t3aTVydkxKb0trMFZML2RUWDBYc2xvT1I0?=
 =?utf-8?B?QmhnNEh1RWdxaFhXcEs4eHZLNFpZYlUvMVdUYjdiSkFoYXl6UzFPZjk1eDVQ?=
 =?utf-8?B?c3lOd1IwcFFEam05eHF3OS9sK1dwOFc5T2hIemorTmpIdlBSQkwvVXlKeURh?=
 =?utf-8?B?Y1d0R21YN0c4dHJlTmtvOVlnVkdKZ1kvbUt5VDdtTng3TFVNU29NSzhiWDRx?=
 =?utf-8?B?cCtJc0tKdHNNY0k1c3hraXkyMFNEL0krM1hYNzRlVTRrVUl3ZGp3bjhEMGgy?=
 =?utf-8?B?Nk1MS3pWdzBiSmpPQVdhMGU5TW5HMmdGUTZlSG03QkdMV0gyM3FvdEx1TTEy?=
 =?utf-8?B?ZG5YMXNsRzYrWEhFczJKSEdYMkp2K3BiSkpIZUhEa055VUgvTVFUcGxJZmQw?=
 =?utf-8?B?UElvTEwyZXkrZjFCczhtbGFMdnlhdnhHK0dKUGMyTHBzUmYvMEpxMkl5Sm9D?=
 =?utf-8?B?aDQrTjdjazl0d0V1R2dFWi81N2RrV0JOWnJBWlRoNGdWSjJpQjVNeTYyTE1m?=
 =?utf-8?B?MFVxakkyOVIyN1o4cDJJNXFMVC9US2JjOHRCRXFDR3ljbHJ6ZzRTRlFrMkZk?=
 =?utf-8?B?QjZzbG1PQjRkbVY1SDdNUzN0NW45UlloeFltNzlsYmF1cllNS3hZVEtkd29V?=
 =?utf-8?B?QjNuN1FIeXZJaFhDVHkrZlRwQXo1QlgxS1lNSm8wOU0zM3JTWjYvckZQOS9x?=
 =?utf-8?B?SHZNU0dwTjd5cEdXS3RTK2NPVkZCVmFEdldZNnorcFBoRlhDYVJ0djhEOFdJ?=
 =?utf-8?B?b1RGTm1Wd3VCMDVEUzEybjRYeWk1OEFVVktQVzBHRWZsNlFna0ZGSXFMeTNn?=
 =?utf-8?B?YmgyRXdpSFJvUVg0N1A5MVhJTXNDZHhWWHhaMER2L1l0WkQ4K1Z0eDdZeVlH?=
 =?utf-8?B?d3BsVGc5S0UxSGlCeDlDZksyTVdqWHlNSXpHOHpoYm94SEY3Vkk2MkpyUi96?=
 =?utf-8?B?ZW9OSmJEWEdqQklMdC9TRmhubVZiNXUva3BPajZJYTlMYW1VZWViUytEdXNE?=
 =?utf-8?B?SHFpcU1aMEhLOERHTUo2aXRYRGdONU95ZkhTWlo2MTdLOUVJeTdWUFhZUEJH?=
 =?utf-8?B?SndhbGFGbDRHK0FDcVlkcHhNWVdZRXI0YWFjamQ1SGpYMXJ4Vjdna3NqVWZ3?=
 =?utf-8?B?NmNIeEk3ZklOSkJLQVNIa1NRWHRyRVlnSHQzTTF6Wm5QU296UUNTWk1TS1U1?=
 =?utf-8?B?SUN4U05GLys5Y2gwSUxtSlVpVTlVYTNCV1l2ZDVjL3d2SkZUd25mcVFkZkNO?=
 =?utf-8?B?NkRsdEYrb3ArVkFhVnVMZFd0S2ZDSU82WmhmUzIrdm9GMEpYYm1jNGxtZDJ3?=
 =?utf-8?B?VE4rOURmMU11K2FLWUcwNzA2SHpUZ2svMCtoZ3NMR0dkb3FhTXNXemlXUWZh?=
 =?utf-8?B?a3E5aExUTFFzeWU4VE1jVmtTTmNIaGx4TzcvaW8wTnZXUWEzWVZLYVE1eUJE?=
 =?utf-8?B?dk5CdUthVmdONXcwTE5vanRIcEJjSTRjQ2I3V05QbEYvbVl6KzB6dFhRdkxG?=
 =?utf-8?B?L2tpeno0bDU2U1AyQXZXaWk2Mmc1NE1YRzQvVkJlcXhuTnMzc3dTZ1NKSEI1?=
 =?utf-8?B?QkdQa0tzeTNYdTFBdkhRaFlsc3Z1a21pd1A3TTBic2NtOG1aTnZjc09pMzFo?=
 =?utf-8?B?OXkvTm5Jbmh4aFNHSUlUbzhZcDhPMGpqeXZBRTFvaVFhUzZybmxTbEpJblU0?=
 =?utf-8?B?UEhIaTJRZ2hXNHVvTGlHN3l4NTI0UWtZbmk1UTQrVm8vcXlaczBab2Q4dVpX?=
 =?utf-8?B?R0RGbXUxZDB3RzRYWk9sNmhyd0liT2hYTWFQWU9sanQ3WTNSOXFTWnRDM2xG?=
 =?utf-8?B?ZS9BQ2ZSMXZNV01ndkZVUmpwNnYzVUpnZUFUZDI1R2M4RXBjMHlFcVJNcW5w?=
 =?utf-8?B?clF2a1hLMFN3MFJYVEd2Kzk0SCtiQ1h5eldJUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.2.240;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fihe3nok0735.emea.nsn-net.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 16:21:37.3307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 575ca6f8-8501-4526-cf90-08ddf6cf712f
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[fihe3nok0735.emea.nsn-net.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB11096

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Plesae find the v2 AccECN case handling patch series, which covers
several excpetional case handling of Accurate ECN spec (RFC9768),
adds new identifiers to be used by CC modules, adds ecn_delta into
rate_sample, and keeps the ACE counter for computation, etc.

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best regards,
Chia-Yu

---
Chia-Yu Chang (11):
  tcp: L4S ECT(1) identifier and NEEDS_ACCECN for CC modules
  tcp: disable RFC3168 fallback identifier for CC modules
  tcp: accecn: handle unexpected AccECN negotiation feedback
  tcp: accecn: retransmit downgraded SYN in AccECN negotiation
  tcp: move increment of num_retrans
  tcp: accecn: retransmit SYN/ACK without AccECN option or non-AccECN
    SYN/ACK
  tcp: accecn: unset ECT if receive or send ACE=0 in AccECN negotiaion
  tcp: accecn: fallback outgoing half link to non-AccECN
  tcp: accecn: verify ACE counter in 1st ACK after AccECN negotiation
  tcp: accecn: stop sending AccECN opt when loss ACK w/ option
  tcp: accecn: enable AccECN

Ilpo Järvinen (3):
  tcp: try to avoid safer when ACKs are thinned
  gro: flushing when CWR is set negatively affects AccECN
  tcp: accecn: Add ece_delta to rate_sample

 .../networking/net_cachelines/tcp_sock.rst    |  1 +
 include/linux/tcp.h                           |  4 +-
 include/net/inet_ecn.h                        | 20 +++-
 include/net/tcp.h                             | 30 +++++-
 include/net/tcp_ecn.h                         | 85 ++++++++++++-----
 net/ipv4/sysctl_net_ipv4.c                    |  2 +-
 net/ipv4/tcp.c                                |  2 +
 net/ipv4/tcp_cong.c                           |  9 +-
 net/ipv4/tcp_input.c                          | 91 +++++++++++++------
 net/ipv4/tcp_minisocks.c                      | 40 +++++---
 net/ipv4/tcp_offload.c                        |  3 +-
 net/ipv4/tcp_output.c                         | 38 +++++---
 12 files changed, 239 insertions(+), 86 deletions(-)

-- 
2.34.1


