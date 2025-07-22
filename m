Return-Path: <linux-kselftest+bounces-37813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B2B0D685
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C20F51C237C5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABC222E1733;
	Tue, 22 Jul 2025 09:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="F4xvAEVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8339C289E20;
	Tue, 22 Jul 2025 09:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178382; cv=fail; b=m8bgxe0smbQScExBmj6uGTKM3ACgbarVJj54xj7pp4HUV2NGzP+G/fvrD2Ib/a6mkIyfb43lbZVc2jlOD16QWbEObERiHIT2jFC15ccEHJ310pzQjay0+ntYK8y6jygvsCD7OIcx49zE8CDPY7RKbqkZBuY0NNtu9WWlUEhmdjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178382; c=relaxed/simple;
	bh=ag3w48a6ogj5g51za0w8+Yh2WSRaZdHenlKzyEBIhUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=q1Qwzgx7k9xvlOVFPh3UUXGE9xA5MC4SVbUE8QXNH/ejsv12K7V03Hndo4lFbLqzDf02Abn+erN73FnIFH3pcKuGXUJ4wTkaknOyt3XwqaABXrs2zQfLJiU9rwwsmM0KPNqLNr3/rp9CuCn9ykgNtPXEcClYTNRvnsngdO/nNS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=F4xvAEVU; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJuT/uTeL28tqV/NybjglrtsHwD33soB7PpbZLwn4iTJvKLpot6ccmnjhpU+VT4oUMBaT2LlQmRfA3LY6ozXHaa1vm2mpQCGk6TaOlogbELBMe+njO1dta4vuX/9Ss7cTbuw5I1SibwzFfaZ3fLULBMnIOm2615bJ9XSRGse+jpu137cDH0NGAVEsQrmUbmaGsxU7oV9RD3MHBpTjRf8CRbwjuhB2vv7NI4QDK73Bxk8tDYOaWfqDVnz6eDlr7m1Av+1Abq+KUikhmqZj/hjdFCmuEnu31oRHKlyFggBcwFLb8VRTrkhTBDMIaMtIxpltSoR3omILamTy8QahxDqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7wknqcrJEH2YCj8hdvtkhGE69pE8B78L7wKUhH1bCw=;
 b=mE+luyiSDB6nOhaxbL9Azb6gD0ku4ytxi4k3ohpwaVmW8dGXARt1yAN+mSZY9oRAsDONt4MhP37EyDrC87N/TF782AbUQW7qJmSHVjKW3YkOMEEmmyOF+u79DHHndKGPWQy5DChSoBfYU/dJqFA323Y5M4YAJ7Ud8jxsBn5/cR3X+GpAJYz2Yi/9bLiYTCchXnQSwE3GLV6ZezuCWIf6HQtxhbopTrvkGGi5Ujnkl5Gvfqr1ely9vOGIoHOib/umBG0+Bx3ltYvumISBJgDyGAVsxT300L/LO6++2mm6hTv1vREkZg3eIEKhpiwBD8rRdsgn3JNe9lVQkmhWmiUMbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.100) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7wknqcrJEH2YCj8hdvtkhGE69pE8B78L7wKUhH1bCw=;
 b=F4xvAEVUR2X3R1lvvQy+zC1v9aV4XQhas59Ivr1ScbrOsOyDXfBTRRXiNxnalBCYhHk6fNO5Xg0tNX1fpbJrtd1BtHSwHhPh2fviarSf25arQGHZIbaGIRkAyiI1JA+DUCPpROCFj2TvA5Axk61K9WbBL5+Rr4Z6QjxKNGCipJYCxGQ63I8bd0lNhCY+LyFQEzpiHzF+/0A+NE/DUSojnFbwdBSIlnw436QrlayykvXpa05ob7M2Pn9ZKwXmc/4s+tyK5+86yxE/X0ontVY2PZifAZi118k53FOqzYfJ9kJFmhow6XfsxscVTubtlcwCvL9hIpC2515EWsdJ51iHIg==
Received: from DU2PR04CA0270.eurprd04.prod.outlook.com (2603:10a6:10:28e::35)
 by PAWPR07MB9577.eurprd07.prod.outlook.com (2603:10a6:102:360::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Tue, 22 Jul
 2025 09:59:34 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::32) by DU2PR04CA0270.outlook.office365.com
 (2603:10a6:10:28e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Tue,
 22 Jul 2025 09:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.100)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.100 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.100;
 helo=fr711usmtp2.zeu.alcatel-lucent.com; pr=C
Received: from fr711usmtp2.zeu.alcatel-lucent.com (131.228.6.100) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Tue, 22 Jul 2025 09:59:34 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr711usmtp2.zeu.alcatel-lucent.com (Postfix) with ESMTP id 930E368002E;
	Tue, 22 Jul 2025 12:59:32 +0300 (EEST)
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
Subject: [PATCH v14 net-next 00/14] AccECN protocol patch series
Date: Tue, 22 Jul 2025 11:59:17 +0200
Message-Id: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|PAWPR07MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 8610940f-d2ce-4063-38d1-08ddc9067617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z08vOXdJYWxkcGxHVE0zYXRocisvNDZvclVGNGl4RU4vVHpqL25rYTdnNU9m?=
 =?utf-8?B?ZEljeXE4N1U1MUJDQWxWQ1ZRelpFc3hCMVZRQWFqQzlMWER0QzJtbWlSK2pP?=
 =?utf-8?B?Sk9qVGhFdEc3TU03Q3BUQk1oREViNkFWeVRJOVpDVGVFTy95TG1CYWtjZmtZ?=
 =?utf-8?B?UWEyZTU4dWxtR1FNWlZDYnV0dTJCK2xDZnR0THJ1OUNlaklFQjU2Wk5xcEtw?=
 =?utf-8?B?OXExNGsxcWxhNXRCczFHV3NrUE5mT1ZOY0grVDhzVTlQbXNDeU9iSTRrN3da?=
 =?utf-8?B?KzBKL1I4dzlONG9YUnhmVHIvNTFPeWhHSGhIeHgxeCtueDQ1QnUvdVh2VmNX?=
 =?utf-8?B?ZCtUL2VtR2RleXIrK0Mxbjk4RVloNzk4akplQ21mbng5NjlSS2JHbTB0dzJm?=
 =?utf-8?B?c1Z5ODFFSGFzR0NQci8vTzAwT1NDWVlpYlVneVBPM0JCMDdkODE1NjJaN01C?=
 =?utf-8?B?MDZDRFdFT29xNmRXc2VpRXlGRlYrdnF6MTRZZFFrV0xISHlrNWVnOTVnY1FC?=
 =?utf-8?B?VitRREIyQkFCYXNVd0h5cHRjUGdYOFE5QS9UbHVoWi9IWDJlRGFuNXR5NVE5?=
 =?utf-8?B?aEFJNE00ekxSK3lFZTBoSkthWUZ0NEs4NHZjT0w2cThCUnpSRVJ6N0oxWU9a?=
 =?utf-8?B?dWMyTGRpSTZQclJXNzMyV1BSUEtkRzFFOG00amoweDJRUmFpNWhlK2NNQjdr?=
 =?utf-8?B?K0lwWjA0RTAzeFpOKzc4SGpwTnU4MEc2NzhhUExGb0ZKMmtWaUN1QzJxMW9P?=
 =?utf-8?B?VnNqT3FMQWo3c1lRTmJhbjAxYUdGVkd4a0prTVBwcjBNVzlXYUw2a1dpMVFH?=
 =?utf-8?B?Y3VLeGJUb3pjUXNIeC80Rjc0bS9XbG5mcW5ZaGpINWlsM1BGT0w4SHRqQno1?=
 =?utf-8?B?WFU2Z3BCNWhSSXN5aStNa2ZEV2ZGMTdZODRNVjUwSCtpRG93ZW1vU2dpWVpz?=
 =?utf-8?B?RDVKUzlFcGFvSEZaUmtpQnR0NGl4R1k3TndqeGNrTnM4d1BkcjZVcDMxK1hK?=
 =?utf-8?B?ZDFiMlFUSngyeHR0V1JURmllUk93djJ3NEliNm5KN3RqenVRTUpvdjNFQ0Vi?=
 =?utf-8?B?QWZ4V01tZjQrZTUrUlE3ZGxydUUyMkthOFpZMUh5M0dNbGF0aUxMNDJHZmRP?=
 =?utf-8?B?TlZNcW4rdXVXRVppVWJLMDY0YnhSS3VLUlEzUjZhTkMxelVWQ1g2RDBmYllp?=
 =?utf-8?B?SEd4TnBYTi9paHdKalQ4UWlDNUxEVFZ3eVRqOGtaSHNJckFIWXhKNXRhZnNP?=
 =?utf-8?B?SnF0TGNpaWR1VmNRZ09zZGhkWHhValZadndUK3kzb2JYOGxNMno4bUJoVGIv?=
 =?utf-8?B?S0R0dXIzdUZkVlV5S3JuZDEzVllwQzZwMi8xRDlsRVlLNGZsandyQU1kUVYw?=
 =?utf-8?B?TkUxb29KdmQxZkFCU1VhUFp6dGY1VWJPYWVUbXBrRVBnSXdEVjIvSU4xMXA3?=
 =?utf-8?B?SzBGWkRQUC94dGd5MHE4TVZiVzdSNTVhbHc1d0g4M0ROSHVFNnZhdzgyZmFC?=
 =?utf-8?B?SWdiRVNSQkF2Z0lWMXB3aWYvUTRLaktaa242d0pwai90UHR0c0pHODFkR3V4?=
 =?utf-8?B?UVVFeUorMGszdUp4c3M5TFludjFiakx5S2ZKYzF3Wng0MlIxUGxZZVA2VWtt?=
 =?utf-8?B?Sk5LVWZGVHVGOGpFU21YeUkraFVuWVBQNytwZ0JObG9EemJqQ1ozaFE4WTV5?=
 =?utf-8?B?OEtDZjJTNnpRSVp4Mk9iV3h2RWMvMXJQblcweUR6SmUxNVVBUWpWTzFIWlNl?=
 =?utf-8?B?aTAvbDU0L0VLU29OTDFid3RRUkRIenc0TnFzSDJ4Wm9UVkE0TnYxUlZQOXFl?=
 =?utf-8?B?ZFJJQWxlcjNGdkdUMytGdzdLOW1aUFlySmhvZ2U1aGdoNkc0cEtpZW1aZ2Ra?=
 =?utf-8?B?bThiTmtzZDVDWE5qYjg1Z2VWdDJ0SnZWakVzdUwwTUdkSzdGTnFyNWQzNzJV?=
 =?utf-8?B?WEMvM0MxWG1kS0dTK1ZUL1VEdGNpRWJUejdqT1pSYTFWTk1ibzM5bzloY1pj?=
 =?utf-8?B?Y0RpUUZEZnBxNFRWMDhLemdYcWthcm5VMUhsUGdEMkc0ZGdWbWVETXlGbnQ3?=
 =?utf-8?B?RzJoTnlpZlFHRDc1U0pUVkl3NjRNU05QeFVZQT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.100;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr711usmtp2.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:59:34.1559
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8610940f-d2ce-4063-38d1-08ddc9067617
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.100];Helo=[fr711usmtp2.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9577

From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Hello,

Please find the v14 AccECN protocol patch series, which covers the core
functionality of Accurate ECN, AccECN negotiation, AccECN TCP options,
and AccECN failure handling. The Accurate ECN draft can be found in
https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28

This patch series is part of the full AccECN patch series, which is available at
https://github.com/L4STeam/linux-net-next/commits/upstream_l4steam/

Best Regards,
Chia-Yu

---
v14 (22-Jul-2025)
- Add missing const for struct tcp_sock of tcp_accecn_option_beacon_check() of #11 (Simon Horman <horms@kernel.org>)

v13 (18-Jul-2025)
- Implement tcp_accecn_extract_syn_ect() and tcp_accecn_reflector_flags() with static array lookup of patch #6 (Paolo Abeni <pabeni@redhat.com>)
- Fix typos in comments of #6 and remove patch #7 of v12 about simulatenous connect (Paolo Abeni <pabeni@redhat.com>)
- Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and TCP_ACCECN_CEB_INIT_OFFSET from patch #7 to #11 (Paolo Abeni <pabeni@redhat.com>)
- Use static array lookup in tcp_accecn_optfield_to_ecnfield() of patch #11 (Paolo Abeni <pabeni@redhat.com>)
- Return false when WARN_ON_ONCE() is true in tcp_accecn_process_option() of patch #11 (Paolo Abeni <pabeni@redhat.com>)
- Make synack_ecn_bytes as static const array and use const u32 pointer in tcp_options_write() of #11 (Paolo Abeni <pabeni@redhat.com>)
- Use ALIGN() and ALIGN_DOWN() in tcp_options_fit_accecn() to pad TCP AccECN option to dword of #11 (Paolo Abeni <pabeni@redhat.com>)
- Return TCP_ACCECN_OPT_FAIL_SEEN if WARN_ON_ONCE() is true in tcp_accecn_option_init() of #12 (Paolo Abeni <pabeni@redhat.com>)

v12 (04-Jul-2025)
- Fix compilation issues with some intermediate patches in v11
- Add more comments for AccECN helpers of tcp_ecn.h

v11 (03-Jul-2025)
- Fix compilation issues with some intermediate patches in v10

v10 (02-Jul-2025)
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
Chia-Yu Chang (5):
  tcp: reorganize tcp_sock_write_txrx group for variables later
  tcp: ecn functions in separated include file
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
 .../networking/net_cachelines/tcp_sock.rst    |  12 +
 include/linux/tcp.h                           |  32 +-
 include/net/netns/ipv4.h                      |   2 +
 include/net/tcp.h                             |  87 ++-
 include/net/tcp_ecn.h                         | 649 ++++++++++++++++++
 include/uapi/linux/tcp.h                      |   7 +
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |  19 +
 net/ipv4/tcp.c                                |  28 +-
 net/ipv4/tcp_input.c                          | 353 ++++++++--
 net/ipv4/tcp_ipv4.c                           |   8 +-
 net/ipv4/tcp_minisocks.c                      |  40 +-
 net/ipv4/tcp_output.c                         | 294 ++++++--
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 16 files changed, 1409 insertions(+), 184 deletions(-)
 create mode 100644 include/net/tcp_ecn.h

-- 
2.34.1


