Return-Path: <linux-kselftest+bounces-36257-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3DCAF09C2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 06:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C73A480A9D
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 04:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB501EBFE0;
	Wed,  2 Jul 2025 04:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JfTxdUcs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013058.outbound.protection.outlook.com [40.107.159.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F81DDA31;
	Wed,  2 Jul 2025 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431053; cv=fail; b=g9u91pS5El8NAcYGD8+dVdYdo3E8jLXPQbPNanp79bn+RS+FtjNQuql1j+1mBzvv37l8AikfR4YKhgkKSHOeTrjJOMExj9zX6pv0FdPGSkr0EkLxw8MQ2pKBGUIY79O9cWIkEVmsKs/Y4OEjHGSNMX5B9XxDS0sr9RHzCwa7QhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431053; c=relaxed/simple;
	bh=5ZVilwk0fc6Og+hueLzax4w1CmqWKuYXOYTSRRWlgSg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=briUtCRzTYaKVDN/UcGTzzMxqGfOGww2ZPUI1O5mN5v+tjVc1zARLar6mHFQvb7UAGtngjJ0fXuCjYgW8erhHMvcA34pQnqrVue08oelcaa628VD2vdt5dWLWGjdj2JoXLKUWMSbZ5UyRf9CQ3hbAo+1yM+qvp1wXzbatBdhzUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JfTxdUcs; arc=fail smtp.client-ip=40.107.159.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkAc88akvr9QOk8u4mlr5T6bgbJLh0FzSzcKbkzoYQslEbaIXvIQgf7R2/JCKnlVaxxJCoiDCcUSV/aKIlQ3SW4eCDG9XGBB8fs2GMz/gxo9GQKDRZZGfQJz6Vx01mVoHY7bUfP8sz2O4waP69Wdv8FbFpxU3Ruzep1r3dooCIuFp5gXfooyMYebUNQSP8F5iP9Lf3kWopUZSvCHNb6DOoc8Rq+yek0NoE1JrbqEjQi3HYTAtjGvm9Ix4mYTqo55IHTCp5JXHaj3HgQ4bnw/zWw81/HHmlqyLb2ZC0zZEAHz4q6VWOS91EJmQ4K6fxm9c5hBjTIHDfFkqVoxwc0P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAufUH0dIPLWzvIFef28v2XEH4wE5bOMxfurpUw0iL0=;
 b=glX4QwZiFWUaX6yG05TEBK+iDUujWyRMzNFeGX0KqqkhEzDORa4XlTAmGn0Uj45A6zxDS0AUbas0RX/pB6ybYqr84TF1lnhUongFDv0CjrSMsI75CPGpm97+l/8GJKbuuTXHgPDMI3nc0uTIGCtWAv1TZdtHtIUh43UI6nqy2elREenH2sCcRtvAJqmCBEs/K0xq8P4Mldcjw6kD07FbsJilGs6YwPpqvH4LTGX//25GS6rs5V2mp/05ab5dveYUR6Tndfa1bUvGA3Q67Fp2MxhCsby9Y4MgAvhH3+6vmiOVaIglz1yHHugxcGTXldwhslS0wfmp+bD4XDM2IswiRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=temperror action=none
 header.from=nokia-bell-labs.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAufUH0dIPLWzvIFef28v2XEH4wE5bOMxfurpUw0iL0=;
 b=JfTxdUcs/8D7Y7m5LahC8aM+/9JVuQi+zOyIOZ+CuTG0tITQ5gQOmhdNGXPBhc9x+wbIqhLWG9ZqCftKIYQa3xgKBIsJho+lMJV7cagLzIX54MuPiFUzb/sTKAdXNyB56Wi6Ee/2RoaKYbU8OVBcMlmMiA8CjLqM7PgKQDKyZ/DQqddInqF9RmrNv9rDxwgdGswpKfWh5xLZnO9ZkQByPE7lt1qnYieNz/55poRFMNZD0kIpFRnrwa94rWnImwjr/JIeex1/mscm7SmloFUNxWNKgWXe1dETL2wOUbEMUs8HXGMnFkfwGawtNWAVoCzCGcBRexAXbNelP5N/nlZYYg==
Received: from DB7PR03CA0076.eurprd03.prod.outlook.com (2603:10a6:10:72::17)
 by AM0PR07MB6258.eurprd07.prod.outlook.com (2603:10a6:20b:155::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 04:37:25 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:72:cafe::18) by DB7PR03CA0076.outlook.office365.com
 (2603:10a6:10:72::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Wed,
 2 Jul 2025 04:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 131.228.6.101) smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not
 signed) header.d=none;dmarc=temperror action=none
 header.from=nokia-bell-labs.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of nokia-bell-labs.com: DNS Timeout)
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.15 via
 Frontend Transport; Wed, 2 Jul 2025 04:37:22 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 4A4761C0033;
	Wed,  2 Jul 2025 07:37:21 +0300 (EEST)
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
Subject: [PATCH v10 net-next 00/15] AccECN protocol patch series
Date: Wed,  2 Jul 2025 06:37:04 +0200
Message-Id: <20250702043719.15130-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000952A:EE_|AM0PR07MB6258:EE_
X-MS-Office365-Filtering-Correlation-Id: 25233e5e-73c0-4136-6a2d-08ddb9222363
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEJQa2pWYVlRcUV3NG1rYXVzY2NTR0JTZzlQNWJRY1d5NFFXeUppMnRpUzNN?=
 =?utf-8?B?UzZvbXdxeDZqcDRyUWF5ZTR3WGliR1lYSXVVS1dhVDhhVEdMNEpWbmpjMFZW?=
 =?utf-8?B?bzlKSzBKQ2dXOURrczBsVWFsR2xqNUpkc1VhbS9PWkc1M1FtTGhMaFNnYy8v?=
 =?utf-8?B?WHVzOGtFL0ZVaVVZR1ZxcHFyS3FYcUN2RzcvMitFcENSZko5MVY1M1NueGZO?=
 =?utf-8?B?cUNWS2tGaWZEUmgvNCs3VDdzUCtCQ3JMK2Vud25mNnB3M21Wc1VMaFI1ZGkz?=
 =?utf-8?B?OUJIWEhaMFcyRnU5MWtVTUpYazJxcldCdHJpankyc2FtZERvT2dreTJhaDF3?=
 =?utf-8?B?VUpnaWo1K21lU0d3MlNzWlJLWWdKd2lJWGlkeGl6TTllcFNsN1dubVpDdHF0?=
 =?utf-8?B?T3RtbmVFbVdLaUwrSlVjREt6TmIyYVJ4UlkvR1AzMUpwTWZOK3B5WnQwRXZv?=
 =?utf-8?B?ZnJwckdjdkhkYjZJNDBhb25EVlFiNXcwVDZFL3NaSkpJakxlZmx3eWNFcG12?=
 =?utf-8?B?elRSdi9kNmFEZzFsSWEvVmtoQUFZUlA2UFFhV0sySmtQalkwOW9MK1dTWFR4?=
 =?utf-8?B?RjR1aCs4Z3g4Rkk5THhraHhJVHBCNXpZMUxEdW9uY2pBdnc3K3BkU0dzWnU4?=
 =?utf-8?B?VTVMVlV6RC9hWTB3UE9rSGNnbmxWeVpaQzFRV081WnJSZnR0ZldUZ2YxS1Vs?=
 =?utf-8?B?VWUxVVg1YnBVSXN5L1VkVHI2S2JIclMwblhIdEUrQTNSRXVMbElWbTZseTY4?=
 =?utf-8?B?R1h2VXE0MHlDM1lFTkh4cGNyTUZ1dERkZWJ0OXR5QTNBajlBajhMUml3djNx?=
 =?utf-8?B?R0lVNDJESlZyUXhKQ0FSY0w0ZXQ1bTZTNXpUQmdUdzlZbUpLK3k2dHlmMTdo?=
 =?utf-8?B?V1dlV015TDZ2bFJyWVN6aWM3U2loWTRhSllROVF5MmpBOUtmY2JDY2xTQmw2?=
 =?utf-8?B?MHduVFhtRjgyeUtkRm5DTC9STFIwSEhBRkkrZGEvNUUyb3d3dm9qNXhHRTdy?=
 =?utf-8?B?NXBhYXZzMFdaeUdoWHZRaEhFbmJDYWZyaGM3cmk2UVNIUHRPc1dFZUhxS00x?=
 =?utf-8?B?NDM2OU4yM2h5TSswNEN4TTJ4Y0hDZTAwMndZdE9JZlBHUFVyVmpCY1QySC9R?=
 =?utf-8?B?cVR1emx1Mmt1TVoreEM5Z1VoTmxNNDI2UEpiSUN5WldHbWtyZTBaTmluL0Vl?=
 =?utf-8?B?N0dJOG9ESStjbGUvYnFzbG9SazcvUVRlT1UycysvbjVXSWw2YUYxalpBWXZp?=
 =?utf-8?B?ck8yQ2o3ZnpIVXZMOWE3eFVmU1ZZS3VNczg4RWkydXJyODRLaWNobDQ1bTNP?=
 =?utf-8?B?WWYvU3Z3SlJLRWlLMXNCMjFaV2ZaWXYyRDRBN01mT2tqUVBxbEFTYk5nTTl5?=
 =?utf-8?B?dDVydmpYOUxOa1ZVUVR1eml4enNVbXdOZDJ6N29KYkUwMHpjUXc4VmR4N1pv?=
 =?utf-8?B?QVFMcXg5WnVJc0dQaWVobVpnM1FEbGc5Q2xiZ3FpdkpCM05qY211dnErOEJo?=
 =?utf-8?B?Y0ZSUVZHclVaQ3c1dUsvYk5OUUVwSWlqTlM0MGkvQVlxTHZXNjk0WjVrZUkr?=
 =?utf-8?B?K2xFa2JPczdxa0lzd1BKbDIyL3VGTXczaE9UNUV5anl5Z3dmemxzQXk0V3V1?=
 =?utf-8?B?bVJ5L0JhdWNzWGxJQkh2RVJha0cxdjhuRUsvSVJnNXRKVWhHdTZVOVN3ZTNM?=
 =?utf-8?B?a21vdzBYai8wTzVkQnB4elZVQ0pnQThXbEV5SXVZeWVPMVFnWFF0YXhvcjFQ?=
 =?utf-8?B?V3JVSVNBRHQ1NGdZUmNpTHZxOEI4d01tdVc2eXc1dDlEVXk1bEhEZkRaZkhB?=
 =?utf-8?B?VmZKWWx6WTQ0cnJRRUExUWdvMnMvWVFxS3N1YkJzU3RHZG5sWVdUSlo4czB6?=
 =?utf-8?B?Nm5uRzFNRVJTQzA0cjZTckNXTVZaZmFEUzMyaG9nSGZsZ0E5Z0dwZ3RqQmtJ?=
 =?utf-8?B?YjZMc01iZGZ1MVRueDJOUEM2MWE5QjJPcDNUVWxTc2hHbXdTaWFJZDZNbitP?=
 =?utf-8?B?allCeXlyd2taaU8xMWpRWTF1enpNNDBRVGVKam84dHVjeE5TYUwxanUzdDdZ?=
 =?utf-8?B?RHd3Z0J5dFIxWlkvd0didDRFUkRNaVJ0bUo4Zz09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 04:37:22.9405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25233e5e-73c0-4136-6a2d-08ddb9222363
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6258

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
v10 (03-Jul-2025)
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
Chia-Yu Chang (6):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: ecn functions in separated include file
  tcp: Add wait_third_ack flag for ECN negotiation in simultaneous
    connect
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
 .../networking/net_cachelines/tcp_sock.rst    |  13 +
 include/linux/tcp.h                           |  33 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             |  87 ++-
 include/net/tcp_ecn.h                         | 647 ++++++++++++++++++
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  29 +-
 net/ipv4/tcp_input.c                          | 371 ++++++++--
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 297 ++++++--
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1428 insertions(+), 187 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


