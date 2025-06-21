Return-Path: <linux-kselftest+bounces-35551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1DEAE2B90
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 21:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99121170DE5
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jun 2025 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A83D26A1AC;
	Sat, 21 Jun 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="D2Chmn7j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013023.outbound.protection.outlook.com [40.107.159.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE731BD01F;
	Sat, 21 Jun 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750534668; cv=fail; b=kbegwD5rVeP6QjVREtCxu4p0joRS1/1ypkNpGoUTjLKOzX4Y7oe3DyM/ugZp6A5jLlrGSj6To+E6Ku/dGsES/aenYOe5mNiwMoJSF0lHaCHUv2dlTtRli5JKKvuORsw5zL3vNBfOiSrJAnZmUU/jOY75Dv9bW2/YK0dz2xQ2kVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750534668; c=relaxed/simple;
	bh=rvF+VwF3eNImZZsguenTykKKU5OsIfLuBVpZk1uzpvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AUOWBZl3qWdnUmDqBYEBbih3zPMIhJFd9nSw2cWm8yDGbVJg7uFNsBhpjAgT/KBaQdpzFTuZQWA9srtde7djaNCyxaUA4oevj7ahmxpttE0mm7+xegcWGbNXFIesxlUbp66e3bI5Mo5q0Xav4Gk2RMhtwD3FSinEsz09V4bEVhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=D2Chmn7j; arc=fail smtp.client-ip=40.107.159.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rs1ETKV+94+Nfx6AeXgyC+02ASuKWsMC5JB4zMIsxlComRigGBwGuzeV31qtXngyZt6iJWu+aDZSoEBYbKN2MGhn82MIsPrU8U8rQAciuGCCc1NaySQzj73iOjtFskGROeOxyhV70uuE4JIph2RPPpR4xu8DEMhMetHJqiXL+c+/xdcdYwjZNHbPyD5TbmDrHIt3HzpyJoU13sSjqM0dXNOyjX4NU25rznGYx5ldikcRL9VUHRDAOXRqv780RThQsh97k4HQDkUWG/CZefDScoWyS0OH6h6ifnea8CscYKsG2gZQ+30nRDYlf4clkeYDv57OuSy3hqkE/fZGeMc5ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lybUFgKwD9XoOhmUNtxQx9j31SnpBmZsREpE//NNok=;
 b=qzHYdQDJPCOUvvryRofapdShl1RF2vStM0ZZ40FbWBsQ5FY+ymAp3Kajs6fjX4KHOPmoZecjLPpKkNo8hEkB6g7CgVSqsviYYo4rqMFsWC5gi+bA6/L47oYYKWwO/2Ri9s20tltdrwYbzdXihLgs0CBxLz2omUEObZGNt61NP1GfcBE0eP0z9Ittdy0dcjUwC7Tkwqh9dK8lw3VMEJRyh2FFdPFi6s/bWw3IFpxhbWpfHZAHPizPzhTehJEwws2zn/U9sJsFoNGgzTtgCP4tbqD5R0oO+DOR5z5plzEXSwuCcH+iDiX3/qTG/96UggvS84kOGYfttqy+cAZeG4IGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lybUFgKwD9XoOhmUNtxQx9j31SnpBmZsREpE//NNok=;
 b=D2Chmn7jTVQ4G+U0e8FAKwcqaq9A8nPo1d2NB4SQuTlqRgunkiDR6UXa7FxXUMlPjEUzl0YnexZIQn/OepOP3wsyWnrxk+0Hgv4plNeN/TUHD0v/EOTX4zGIngXNNF+KgJmr29jVIeVYLG6m7x54pBtQr4XKBDhSKgH7v4zPS5yEmsnjFH+VUCOzpRS4C7PdC0RcjsHnSBxp4BYYVb9nj9b0UhRdX0KXfRcw5U/Qz4uvfkSIM+/IBQ0NbbP6g0QWhtpPZVkxdFy9CM9CXZ9mkGmR+eWrk2eBZYfvAg2KGcCJjMAVbFFr+6iJxwaD8iNIjTk0yH+NWCKP0NnkalVHfA==
Received: from DUZP191CA0064.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::17)
 by PR3PR07MB8276.eurprd07.prod.outlook.com (2603:10a6:102:17b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Sat, 21 Jun
 2025 19:37:41 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::f8) by DUZP191CA0064.outlook.office365.com
 (2603:10a6:10:4fa::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.27 via Frontend Transport; Sat,
 21 Jun 2025 19:37:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.21
 via Frontend Transport; Sat, 21 Jun 2025 19:37:41 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 801C91C0010;
	Sat, 21 Jun 2025 22:37:39 +0300 (EEST)
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
Subject: [PATCH v9 net-next 00/15] AccECN protocol patch series
Date: Sat, 21 Jun 2025 21:37:22 +0200
Message-Id: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|PR3PR07MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d573899-c57e-4069-79bd-08ddb0fb162a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|7416014|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OEJaYlJzeDBBQU5sL2ZESDFBSnhOS2Q4RG41Z1pHREhKbEtSaDFhYzUrdWFv?=
 =?utf-8?B?Y3YyVVpwZ2VjQW02OHM5RTZTVjNmRmE5NkVXUEhBd21UU2EwVVY0d3lGZndX?=
 =?utf-8?B?ZWduc1hUajZjSG5EMFhlMHNRU1RkRUFXdHhVVzdCRmlYQ0I2RW5wMEtSOFY5?=
 =?utf-8?B?WlFiUFpCRlJKQWhNNzVpQ0FkR2czZWphYTlrckJvaURiaTZKbWRNeDZVQXJS?=
 =?utf-8?B?bVF4a1hFa2dFUExmZG9ES3o4SWp6cDlkNnlFQVI4ZUgrUVlPbmR6aStXTG5z?=
 =?utf-8?B?cFU1NlZ6MlNaYzR3UmdmZXNpamFBdFc1REFaWTRNQzh0R1hHNWdVbWNQcTZ4?=
 =?utf-8?B?ZVIrRmVXQ0tUVUo3RXllVFpiM2gwTkJ5amxBblBnMG1wdlVpdHYybmMxa05h?=
 =?utf-8?B?SktTOTE3aXpleGx0WXZ6TTFuL1EvQUZZZklVSTFnZHMxZ2E3Sm5yVnltT1Bj?=
 =?utf-8?B?cnBjMk1wN0E2Z20zcGNWdDRlRUxURVFYRkpVTC9rR1ZsQm1xK1hXcUNKSEJt?=
 =?utf-8?B?L01VZDIzclZjVzd3WG1reU5qN1ZNV0srRGZyT252eDZsalNxcG9jUkc1NUNs?=
 =?utf-8?B?Ym90QlkyNng2TTc5dVhxOGlnWmlodUxta0V2TUdITnFMcW1teU5Id284UUcv?=
 =?utf-8?B?TGNOMmoxR3NYTTZ5ays0RGhPUk9KRnY4c3hTOHNVSjNiUTFlZ2E1K3NYWDRK?=
 =?utf-8?B?ZjRFbXBEVDhrWjB0dXgweUcrTjVCckt4dE41L0hqT3UwMld1bEI1ZGVZRmlS?=
 =?utf-8?B?ZkpzZmxHdDJHaVhvVXR2MXcveW9FRHVzSUhTZ1E3V3A5eEdSYUtmejRJMXdM?=
 =?utf-8?B?TXJYUm1nRkJrVjJTMFFNbm8ySXA1a2JTQTV5MnNNV054bkw4UU0xQmVoSjFo?=
 =?utf-8?B?QTVKK3Vra20wQk1xVHVndWd1UVdoRGo3YnMvNDFOLzJjbCtpd0dzR0RkeGpN?=
 =?utf-8?B?ZnhrUlFFMndsUmlNSjl0ejJ0QXZUOHJQbVJIQ2ZkSTM0Kzk4YnFVa1huOG8z?=
 =?utf-8?B?cmNZam1sczFtZEU1ZHV6NVNvMGRRWFRtb2JsSnV6NHZ3anUvZyt4cm5Vbm8w?=
 =?utf-8?B?TWpXQVg3RW1pRzhiNFhLUlBWZHhSc3hOL1lIak1MWjJ2QW9sYzNnYVp5VzVQ?=
 =?utf-8?B?NTM4cFdaS0JhU3NIeGZrRi85RXdSWmJ6Ykh6aDRoOEFLUUFWMUtoQkQ3Qkls?=
 =?utf-8?B?bm92aWU4UkdCRDVyRkg1V21yWDlhVXZlQ3B4bTI3SFBTSS92VURFOXI0a3Nh?=
 =?utf-8?B?RVZ4NkFsZko1bmNldDlRQnk5NVZ2QVhpM3RHRFBudFlHck1zandneFZ4WTg2?=
 =?utf-8?B?aUFEczBpK3Y4bCtVVjdzMEkxaGNqekdmYys5T1NLSjZ0WVJmODVaS2w2cXZY?=
 =?utf-8?B?T3ZDUHBtdzJPdWU0YmtLMkY3WEpIR0JBZlh3K3ppSlk0bFFZaFF1bWx2dUl3?=
 =?utf-8?B?WGRZUkZENi9KYm04SVlKajVrdjFhemtxTUliaEtjQXUrL0J6azJjc0RZcjFX?=
 =?utf-8?B?TlNBV1ViQU83aWt1Sk5nWEJvVlBSb2lldGlLckhZODIrdlN6by9NQ3JGTm9j?=
 =?utf-8?B?SEpSUkpLOXpOT1FQTXhsL3ZsT2haTlpyVnpyWjc5RVF2K1ZkWHdDN3RRM0p1?=
 =?utf-8?B?NGU5Vm9xMHN5NUZrc1hUV3d0MUU5WVN3a2NNREN5ekNRRzV0c0VlVW1nSmpD?=
 =?utf-8?B?Wit6aittdHlKZzFZWWh6Y1pPRlpwM1dGVHhpUXZ6b1VCYTcvb0VEN2VqTnZW?=
 =?utf-8?B?RlRzMlBKTk1GL29ib0RLSGdrVmwrL3BYOVRTYTF6VGk1TUdRR0FZR2xMaU9W?=
 =?utf-8?B?aksvUW5OU3VQRS9zeTErWE5UaFlWNTZqMk9pYzNHcTVDNUEyV2phVGM3UFdU?=
 =?utf-8?B?dXFRY01maHhiL1lNM3FtWXFPZXh3L29HS3h1UHB5TE0vaXg0OXFudVppZmw2?=
 =?utf-8?B?ckM5RGdjZGtuaFZpcWdYS0pUK3NleENkS0VZcWRubG1xUzIzQStkOVd5dXZv?=
 =?utf-8?B?MnhUWDkzNFBWMXh0aFJlMnVGL2szUU9lc2pMb3doY2s2WmN2eENnRjhyTllr?=
 =?utf-8?B?bFJ0dXRCalBwejU5b3NiWXk3c3lpQlhoS05Ndz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7416014)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 19:37:41.0859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d573899-c57e-4069-79bd-08ddb0fb162a
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8276

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v9 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
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
Chia-Yu Chang (3):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: accecn: AccECN option failure handling
  tcp: accecn: try to fit AccECN option with SACK

Ilpo Järvinen (12):
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
  tcp: try to avoid safer when ACKs are thinned

 .../networking/net_cachelines/tcp_sock.rst    |  14 +
 include/linux/tcp.h                           |  34 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             | 225 ++++++-
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   3 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  30 +-
 net/ipv4/tcp_input.c                          | 622 +++++++++++++++++-
 net/ipv4/tcp_ipv4.c                           |   7 +-
 net/ipv4/tcp_minisocks.c                      |  91 ++-
 net/ipv4/tcp_output.c                         | 325 ++++++++-
 net/ipv6/syncookies.c                         |   1 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 14 files changed, 1285 insertions(+), 96 deletions(-)

-- 
2.34.1


