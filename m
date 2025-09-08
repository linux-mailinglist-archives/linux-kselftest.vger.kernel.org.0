Return-Path: <linux-kselftest+bounces-40972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C147AB49715
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 19:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75D2C4E1E01
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 17:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D613B314B70;
	Mon,  8 Sep 2025 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kmesUAa1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013063.outbound.protection.outlook.com [52.101.72.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2931579B;
	Mon,  8 Sep 2025 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757352874; cv=fail; b=Z1YUFmKiltO5Qe9O2Gnk97bQcHB5CSgMU6ezWI3+f0jIuS+Ax1FYptCwvgQwf+fDvMXri5UD1ZTazbh+qLF0nmgZpsyQNCxHX/dBGa5ep3bWhiF7VXhKu+tK+aShP9S+TrenLmwkjVixdO3vdVv7AzTBETYtQMraQaaJkZP1ok0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757352874; c=relaxed/simple;
	bh=ERJEokSuM8VAa9zZa8YA3J5dQaDBF8/yF2KN6p3JnZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=haCmAqE/os1bnp80kR2TDGZrW6DL8Lyt1iB3H72bROWFCX7rtmPIf+HdFhabcSd67RG4mKJYjVts1VlsVv8TPu0e3drZcNimPMKBkBvzKS/vt54S4IeWbu8lW3p/y9ZEybMQvSZbfth1O6p3hVdmlXQziZop+RECeHTYqe3Jcuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kmesUAa1; arc=fail smtp.client-ip=52.101.72.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0Ay/NHfiEMK1Kw2AAMbePaggVcqofSmV+OFlti3WSuvI/o0c5Z/nQo0xkDFdojWKj5hM8uHivgxAqc1jwcScb1x7xOmaihiO8AUKh/h60c0R4hxDebQnB75bfZyFr35lfNChdw0gWaPJ0t7RpLpLz29vlxKfQksDeyy+IB/O+myqGM036F4qZI4TsqSAvMD5ayk8QPdUi05PkH7DUoCkN6VnImgBZQuI0LPajCj6ooAxfurwrLxN9Jb49NV5zJzLzv2x4dEuxt+P6WtCvkfNLVWM/RpfVvy1ExcrLIJ7xl4ocTVfuqTOcLGn6KUnaluJSANDop4yXVCMS7aTGSU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=appKOLQJ1hAx7c3wRzdfBlLBMLzZF9GQUw8iIOUsODs=;
 b=SlLVXv08S6jIAJCqL+aPjQ5IGUFgu0yBny+Tex+mkAEJYFltqP9dr7HVnGns5diNGyvGiLNvHNnAqmxwlsK+4bTmBZLOQXdw6b0CgoACPiquyBPSVl7xatSlOwrIRq0t++32VaE2vAHKa5aNXwihfdqMftnIZMzg1338vPxOttFYa+TDH4tdGw1CnDyAB1v5KdIHtK5q3nSe9WKlYQVQGbNQ1atWpCaOoaZ3YqkYhGcGc63bIw5u/UptW1yYehdKC2ueFcjtDr7CQCW6nPJmnLStAhUv0C0/Dm/CSkP93PZgZN1c151coDV5Ks4yDHbkZ7qIpEgVZiN9/8xCjctumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 131.228.6.101) smtp.rcpttodomain=amazon.com
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=nokia-bell-labs.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=appKOLQJ1hAx7c3wRzdfBlLBMLzZF9GQUw8iIOUsODs=;
 b=kmesUAa1rCx3ZJXMt8O/LF5Zfcb+synQq/KPy9uzWVEp33IQpin/uktaXAOAhOKoTxscWHdB3OXFPIceUw7DXhf9Yn7+rNrDXguO83+Er0H8/fBFvnLah7a909W7fyOiqSCfRorCwBmPiQYtsK7hx0wLCe6Glg0VIm1+1cN/J3//IxR48m/ODu8F34WQrQxGFT9NIrF1uqEOgpOLCxN+trSc30V8gTIg5Mv0669tLhQ1ug2KPAkLIAnYq2G+4xaOXpEN555CUbvEpqqFr9SYEjxsVxgy9R8TgWrvvM7ZqrXXNrqHgEJ+Iy67/DuvPT4jL1u5u9YgTvQ1tcs2Yh0Yew==
Received: from AS4P192CA0035.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:658::18)
 by AMDPR07MB11263.eurprd07.prod.outlook.com (2603:10a6:20b:71d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 17:34:26 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:658:cafe::a) by AS4P192CA0035.outlook.office365.com
 (2603:10a6:20b:658::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 17:34:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 131.228.6.101)
 smtp.mailfrom=nokia-bell-labs.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nokia-bell-labs.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia-bell-labs.com
 designates 131.228.6.101 as permitted sender)
 receiver=protection.outlook.com; client-ip=131.228.6.101;
 helo=fr712usmtp1.zeu.alcatel-lucent.com; pr=C
Received: from fr712usmtp1.zeu.alcatel-lucent.com (131.228.6.101) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13
 via Frontend Transport; Mon, 8 Sep 2025 17:34:25 +0000
Received: from sarah.nbl.nsn-rdnet.net (sarah.nbl.nsn-rdnet.net [10.0.73.150])
	by fr712usmtp1.zeu.alcatel-lucent.com (Postfix) with ESMTP id 065221C004A;
	Mon,  8 Sep 2025 20:34:23 +0300 (EEST)
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
Cc: Olivier Tilmans <olivier.tilmans@nokia.com>,
	Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Subject: [PATCH v17 net-next 06/14] tcp: accecn: AccECN negotiation
Date: Mon,  8 Sep 2025 19:34:00 +0200
Message-Id: <20250908173408.79715-7-chia-yu.chang@nokia-bell-labs.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|AMDPR07MB11263:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0278c7-fc82-4618-d726-08ddeefdf4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dyt2UHZJYzlWQXd4NFE2MkI5ZzZKeGhVSk9ZcjdXc2hzYUZsM0gzQjVtb253?=
 =?utf-8?B?TlBEdStWcUxlczJaR3NXYUQvZ3RBRXQzRXhFazMwZ3VtR08yaFIxdjA5TG44?=
 =?utf-8?B?V0JrbitmQk9MMS8yY2NtZlpmaW5UdjVYMHVtK056VVk3WVBtK1pmSU8yTWI4?=
 =?utf-8?B?c1JUQ3ZUeHdZaWVyaDEzL1dmM1lkRzZJMWZnZW5kWWVpMS9xdXNPeVl4QVM5?=
 =?utf-8?B?bFRxKy9adkFuSXlJZlk1bnd5TU5qU1o5OFVURExOOVFhTE1DcnViL2VvSlpG?=
 =?utf-8?B?NldIaU1Qd3h6MkRkTFQ5TjJwQk5PV2ZjeUZxT3dIbE41a1YwdERKandpclFu?=
 =?utf-8?B?YXlSOERMK3JxV0t6d3RFaXNuaW4wb1hRcGd4QkhuT2JXSDk3NnU4L1pYREdP?=
 =?utf-8?B?WUs4aWxCTlliMEM1QzRtSE5KUUdmK0pYdTdaejBxNGdEbWROcVR6a3Fpa2RT?=
 =?utf-8?B?b3FBSy9sZUlvTWliSWhPckRCWGVYamRRSkFoZTJGbSs5ZkJ4SUtXU3FPcWVh?=
 =?utf-8?B?RzFXejBMZStGR0ZDRGtJcHorZEd3OEx6QTBlbUVGS1ZRVEVBYm1ENzVoOUxZ?=
 =?utf-8?B?SExNY0hFUUh0Yk1MdzIxSGVDTFRBS2FqNDZtRnNUOFVZR25CcWxpWmZySlJa?=
 =?utf-8?B?THBrY0NVNEx6Tk5MMm1CcjJuV1dOT2h2bmZoTkNGL3VrVEhOcStRS2JrdDVa?=
 =?utf-8?B?QWJyZHRzOGdxbE85dXVWa3JqYVhROTQ3dVBBdlVKVnZJaDN1elBvRkFpUy9M?=
 =?utf-8?B?MTN2eUo2YlUwSmVwK0pjUkdZQzIyOGsrN2FteHJHMC83TkE4VUpFeTZwMXNC?=
 =?utf-8?B?TXgzT1plRVQ1TnBZWHRlVXA4cDFiOXMremFRNFNzUFpqL1UwdWNJSDA5blp4?=
 =?utf-8?B?eGtPcmlUaWFYMmZ1R0h1cG1JRTFINGRZWExySjN6TFZiVjRha0NyaTBzZDZM?=
 =?utf-8?B?bTRBbUxCcG9pemtQZGVEVWFuSStDRU1QUTFQeEwwSytTcjgvQ1pUTUp1Q0pM?=
 =?utf-8?B?cmhhVEdscjh2cGUyTU8wVVVrQTY1ako3Q3lhYVpXL2NCQ3RPQ0krcStFcGRx?=
 =?utf-8?B?Q0lzTWwzT05Wd1hjNlZkOVRURHJCNnhMTkxyT2lJSDRqYitUQjlZUVdUUHZN?=
 =?utf-8?B?M1U2RTdiWjZBQUJhalYrdi85djhRK2RiQ3dCNmJaUlhyb3RJaFNQTDdHdkNp?=
 =?utf-8?B?Z0V2UHM1QlJBdVpNOFlCZElhZ0xwYmtrS0pYMlNuS3pGejBpS2IvS0UzZFF0?=
 =?utf-8?B?L0JsbXU0RmkySExwYkxhUVM2cWUydlVkc3hMak80dVo5UDQ0KzlPVmRrdzda?=
 =?utf-8?B?bnV4RWc5OW1nR1JWODJ0K1l2dWhZWXNjc0ZMbzV0eVd3R3g5TnFYangzekI5?=
 =?utf-8?B?WEk2ZHhFQzJUS3JBUXVhSnE0L3AvSTU5NUtKNkRSbmZQUjJkM0hCSTRpOXox?=
 =?utf-8?B?MjV2eENac3lGUVBSTG1zaGluTE5ibDNmdHJrU2k0N1VKTlpMWkRYOE1RTUt4?=
 =?utf-8?B?MWZML0RML0FqK3Y0aDZXWWlLdmRuVkp6VHhHcmQ0eFhmZUpOVEFpbEZsUUU1?=
 =?utf-8?B?ZVZjbGkwKzFMbFl6UndTcEIxcjhJcy9aOE9ReVFSWm1iR1l4cTVPM3Bucnh1?=
 =?utf-8?B?S1lUWk13SWw4cWFTbzhyRGgyKzM5aWwzWnBpUzNHYURlSk1FM1hCdEFnbUY5?=
 =?utf-8?B?R0Y3L2pSMnNVMC9pSExGMzhYUTZuMFVwN0FpMHgzQXRQbG1ZNEhVb25VUkFK?=
 =?utf-8?B?OUZrVWxtQ0Z0VnU5WjB4RFF0bCtCaWhOQzJ2SlhzWVpOWWx3RWRZb3VXLy9k?=
 =?utf-8?B?bU56ZzJiY3hWZ3JnZ3JQWTBPTEUzSnhIN2JZRHpEN25qRDhqc1ZSdHhWdzJr?=
 =?utf-8?B?TFNpb1d3Ukw2d29BNXRuR0tjWGlpQm03V24wZFpXdjRoSmtRcUUzSkViUVQx?=
 =?utf-8?B?Z3R2YytUQ0pHOFNBN2Z4QjRJMGxWNzFYbWY3VytERzI1T1JZSUk3ODkyTmFj?=
 =?utf-8?B?R0ZoektmUWQrSDIrZG5Bd3JuRHJRRy9FYzZCTXVKd1AwQUVHMjRIOTFKRGtx?=
 =?utf-8?B?UFNRZjAyUWdTMTcrWkwweXZreGNsanp3RU4rUT09?=
X-Forefront-Antispam-Report:
	CIP:131.228.6.101;CTRY:FI;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:fr712usmtp1.zeu.alcatel-lucent.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 17:34:25.5048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0278c7-fc82-4618-d726-08ddeefdf4b2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.6.101];Helo=[fr712usmtp1.zeu.alcatel-lucent.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR07MB11263

From: Ilpo Järvinen <ij@kernel.org>

Accurate ECN negotiation parts based on the specification:
  https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt

Accurate ECN is negotiated using ECE, CWR and AE flags in the
TCP header. TCP falls back into using RFC3168 ECN if one of the
ends supports only RFC3168-style ECN.

The AccECN negotiation includes reflecting IP ECN field value
seen in SYN and SYNACK back using the same bits as negotiation
to allow responding to SYN CE marks and to detect ECN field
mangling. CE marks should not occur currently because SYN=1
segments are sent with Non-ECT in IP ECN field (but proposal
exists to remove this restriction).

Reflecting SYN IP ECN field in SYNACK is relatively simple.
Reflecting SYNACK IP ECN field in the final/third ACK of
the handshake is more challenging. Linux TCP code is not well
prepared for using the final/third ACK a signalling channel
which makes things somewhat complicated here.

tcp_ecn sysctl can be used to select the highest ECN variant
(Accurate ECN, ECN, No ECN) that is attemped to be negotiated and
requested for incoming connection and outgoing connection:
TCP_ECN_IN_NOECN_OUT_NOECN, TCP_ECN_IN_ECN_OUT_ECN,
TCP_ECN_IN_ECN_OUT_NOECN, TCP_ECN_IN_ACCECN_OUT_ACCECN,
TCP_ECN_IN_ACCECN_OUT_ECN, and TCP_ECN_IN_ACCECN_OUT_NOECN.

After this patch, the size of tcp_request_sock remains unchanged
and no new holes are added. Below are the pahole outcomes before
and after this patch:

[BEFORE THIS PATCH]
struct tcp_request_sock {
    [...]
    u32                        rcv_nxt;              /*   352     4 */
    u8                         syn_tos;              /*   356     1 */

    /* size: 360, cachelines: 6, members: 16 */
}

[AFTER THIS PATCH]
struct tcp_request_sock {
    [...]
    u32                        rcv_nxt;              /*   352     4 */
    u8                         syn_tos;              /*   356     1 */
    bool                       accecn_ok;            /*   357     1 */
    u8                         syn_ect_snt:2;        /*   358: 0  1 */
    u8                         syn_ect_rcv:2;        /*   358: 2  1 */
    u8                         accecn_fail_mode:4;   /*   358: 4  1 */

    /* size: 360, cachelines: 6, members: 20 */
}

After this patch, the size of tcp_sock remains unchanged and no new
holes are added. Also, 4 bits of the existing 2-byte hole are exploited.
Below are the pahole outcomes before and after this patch:

[BEFORE THIS PATCH]
struct tcp_sock {
    [...]
    u8                         dup_ack_counter:2;    /*  2761: 0  1 */
    u8                         tlp_retrans:1;        /*  2761: 2  1 */
    u8                         unused:5;             /*  2761: 3  1 */
    u8                         thin_lto:1;           /*  2762: 0  1 */
    u8                         fastopen_connect:1;   /*  2762: 1  1 */
    u8                         fastopen_no_cookie:1; /*  2762: 2  1 */
    u8                         fastopen_client_fail:2; /*  2762: 3  1 */
    u8                         frto:1;               /*  2762: 5  1 */
    /* XXX 2 bits hole, try to pack */

    [...]
    u8                         keepalive_probes;     /*  2765     1 */
    /* XXX 2 bytes hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 164 */
}

[AFTER THIS PATCH]
struct tcp_sock {
    [...]
    u8                         dup_ack_counter:2;    /*  2761: 0  1 */
    u8                         tlp_retrans:1;        /*  2761: 2  1 */
    u8                         syn_ect_snt:2;        /*  2761: 3  1 */
    u8                         syn_ect_rcv:2;        /*  2761: 5  1 */
    u8                         thin_lto:1;           /*  2761: 7  1 */
    u8                         fastopen_connect:1;   /*  2762: 0  1 */
    u8                         fastopen_no_cookie:1; /*  2762: 1  1 */
    u8                         fastopen_client_fail:2; /*  2762: 2  1 */
    u8                         frto:1;               /*  2762: 4  1 */
    /* XXX 3 bits hole, try to pack */

    [...]
    u8                         keepalive_probes;     /*  2765     1 */
    u8                         accecn_fail_mode:4;   /*  2766: 0  1 */
    /* XXX 4 bits hole, try to pack */
    /* XXX 1 byte hole, try to pack */

    [...]
    /* size: 3200, cachelines: 50, members: 166 */
}

Signed-off-by: Ilpo Järvinen <ij@kernel.org>
Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
v17
- Change tcp_ecn_mode_max from 5 to 2 to disable AccECN enablement
  before the whole AccECN feature been accpeted

v16
- Use TCP_ECN_IN_ACCECN_OUT_ACCECN, TCP_ECN_IN_ECN_OUT_ECN, and
  TCP_ECN_IN_ACCECN_OUT_ECN in comments of tcp_ecn_send_syn()

v13
- Implement tcp_accecn_extract_syn_ect() and tcp_accecn_reflector_flags()
  with static array lookup
- Fix typos in comments

v10
- Add documentation of tcp_ecn in ip-sysctl.rst to this patch
- Move wait third ACK functionality into a later patch
- Add comments on the AccECN helper functions in tcp_ecn.h

---
---
 Documentation/networking/ip-sysctl.rst        |  36 +-
 .../networking/net_cachelines/tcp_sock.rst    |   3 +
 include/linux/tcp.h                           |   8 +-
 include/net/tcp.h                             |   1 +
 include/net/tcp_ecn.h                         | 310 ++++++++++++++++--
 net/ipv4/syncookies.c                         |   4 +
 net/ipv4/sysctl_net_ipv4.c                    |   3 +-
 net/ipv4/tcp.c                                |   1 +
 net/ipv4/tcp_input.c                          |  50 ++-
 net/ipv4/tcp_ipv4.c                           |   6 +-
 net/ipv4/tcp_minisocks.c                      |  24 +-
 net/ipv4/tcp_output.c                         |  10 +-
 net/ipv6/syncookies.c                         |   2 +
 net/ipv6/tcp_ipv6.c                           |   1 +
 14 files changed, 400 insertions(+), 59 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 9f5891c9b07b..3d8eb54b84f9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -443,20 +443,28 @@ tcp_early_retrans - INTEGER
 
 tcp_ecn - INTEGER
 	Control use of Explicit Congestion Notification (ECN) by TCP.
-	ECN is used only when both ends of the TCP connection indicate
-	support for it.  This feature is useful in avoiding losses due
-	to congestion by allowing supporting routers to signal
-	congestion before having to drop packets.
-
-	Possible values are:
-
-		=  =====================================================
-		0  Disable ECN.  Neither initiate nor accept ECN.
-		1  Enable ECN when requested by incoming connections and
-		   also request ECN on outgoing connection attempts.
-		2  Enable ECN when requested by incoming connections
-		   but do not request ECN on outgoing connections.
-		=  =====================================================
+	ECN is used only when both ends of the TCP connection indicate support
+	for it. This feature is useful in avoiding losses due to congestion by
+	allowing supporting routers to signal congestion before having to drop
+	packets. A host that supports ECN both sends ECN at the IP layer and
+	feeds back ECN at the TCP layer. The highest variant of ECN feedback
+	that both peers support is chosen by the ECN negotiation (Accurate ECN,
+	ECN, or no ECN).
+
+	The highest negotiated variant for incoming connection requests
+	and the highest variant requested by outgoing connection
+	attempts:
+
+	===== ==================== ====================
+	Value Incoming connections Outgoing connections
+	===== ==================== ====================
+	0     No ECN               No ECN
+	1     ECN                  ECN
+	2     ECN                  No ECN
+	3     AccECN               AccECN
+	4     AccECN               ECN
+	5     AccECN               No ECN
+	===== ==================== ====================
 
 	Default: 2
 
diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 31313a9adccc..4f71ece7c655 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -103,6 +103,9 @@ u32                           delivered               read_mostly         read_w
 u32                           delivered_ce            read_mostly         read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u32                           received_ce             read_mostly         read_write
 u8:4                          received_ce_pending     read_mostly         read_write
+u8:2                          syn_ect_snt             write_mostly        read_write
+u8:2                          syn_ect_rcv             read_mostly         read_write
+u8:4                          accecn_fail_mode
 u32                           lost                                        read_mostly         tcp_ack
 u32                           app_limited             read_write          read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
 u64                           first_tx_mstamp         read_write                              tcp_rate_skb_sent
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 90cee6e53527..b8432bed546d 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -168,6 +168,10 @@ struct tcp_request_sock {
 						  * after data-in-SYN.
 						  */
 	u8				syn_tos;
+	bool				accecn_ok;
+	u8				syn_ect_snt: 2,
+					syn_ect_rcv: 2,
+					accecn_fail_mode:4;
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
@@ -375,7 +379,8 @@ struct tcp_sock {
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
-		unused:5;
+		syn_ect_snt:2,	/* AccECN ECT memory, only */
+		syn_ect_rcv:2;	/* ... needed during 3WHS + first seqno */
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
 		fastopen_no_cookie:1, /* Allow send/recv SYN+data without a cookie */
@@ -391,6 +396,7 @@ struct tcp_sock {
 		syn_fastopen_child:1; /* created TFO passive child socket */
 
 	u8	keepalive_probes; /* num of allowed keep alive probes	*/
+	u8	accecn_fail_mode:4;	/* AccECN failure handling */
 	u32	tcp_tx_delay;	/* delay (in usec) added to TX packets */
 
 /* RTT measurement */
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3a25c8f0b99e..2da65bc164f4 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -972,6 +972,7 @@ static inline u32 tcp_rsk_tsval(const struct tcp_request_sock *treq)
 
 #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
 #define TCPHDR_SYN_ECN	(TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
+#define TCPHDR_SYNACK_ACCECN (TCPHDR_SYN | TCPHDR_ACK | TCPHDR_CWR)
 
 #define TCP_ACCECN_CEP_ACE_MASK 0x7
 #define TCP_ACCECN_ACE_MAX_DELTA 6
diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
index b0ed89dbad41..da0b355418bd 100644
--- a/include/net/tcp_ecn.h
+++ b/include/net/tcp_ecn.h
@@ -4,12 +4,26 @@
 
 #include <linux/tcp.h>
 #include <linux/skbuff.h>
+#include <linux/bitfield.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <net/inet_ecn.h>
 
+/* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
+ * attemped to be negotiated and requested for incoming connection
+ * and outgoing connection, respectively.
+ */
+enum tcp_ecn_mode {
+	TCP_ECN_IN_NOECN_OUT_NOECN = 0,
+	TCP_ECN_IN_ECN_OUT_ECN = 1,
+	TCP_ECN_IN_ECN_OUT_NOECN = 2,
+	TCP_ECN_IN_ACCECN_OUT_ACCECN = 3,
+	TCP_ECN_IN_ACCECN_OUT_ECN = 4,
+	TCP_ECN_IN_ACCECN_OUT_NOECN = 5,
+};
+
 static inline void tcp_ecn_queue_cwr(struct tcp_sock *tp)
 {
 	/* Do not set CWR if in AccECN mode! */
@@ -39,19 +53,125 @@ static inline void tcp_ecn_withdraw_cwr(struct tcp_sock *tp)
 	tp->ecn_flags &= ~TCP_ECN_QUEUE_CWR;
 }
 
+/* tp->accecn_fail_mode */
+#define TCP_ACCECN_ACE_FAIL_SEND	BIT(0)
+#define TCP_ACCECN_ACE_FAIL_RECV	BIT(1)
+#define TCP_ACCECN_OPT_FAIL_SEND	BIT(2)
+#define TCP_ACCECN_OPT_FAIL_RECV	BIT(3)
+
+static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_ace_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_RECV;
+}
+
+static inline bool tcp_accecn_opt_fail_send(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_SEND;
+}
+
+static inline bool tcp_accecn_opt_fail_recv(const struct tcp_sock *tp)
+{
+	return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_RECV;
+}
+
+static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode)
+{
+	tp->accecn_fail_mode |= mode;
+}
+
 static inline u8 tcp_accecn_ace(const struct tcphdr *th)
 {
 	return (th->ae << 2) | (th->cwr << 1) | th->ece;
 }
 
-static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+/* Infer the ECT value our SYN arrived with from the echoed ACE field */
+static inline int tcp_accecn_extract_syn_ect(u8 ace)
 {
-	tp->received_ce = 0;
-	tp->received_ce_pending = 0;
+	/* Below is an excerpt from the 1st block of Table 2 of AccECN spec */
+	static const int ace_to_ecn[8] = {
+		INET_ECN_ECT_0,		/* 0b000 (Undefined) */
+		INET_ECN_ECT_1,		/* 0b001 (Undefined) */
+		INET_ECN_NOT_ECT,	/* 0b010 (Not-ECT is received) */
+		INET_ECN_ECT_1,		/* 0b011 (ECT-1 is received) */
+		INET_ECN_ECT_0,		/* 0b100 (ECT-0 is received) */
+		INET_ECN_ECT_1,		/* 0b101 (Reserved) */
+		INET_ECN_CE,		/* 0b110 (CE is received) */
+		INET_ECN_ECT_1		/* 0b111 (Undefined) */
+	};
+
+	return ace_to_ecn[ace & 0x7];
+}
+
+/* Check ECN field transition to detect invalid transitions */
+static inline bool tcp_ect_transition_valid(u8 snt, u8 rcv)
+{
+	if (rcv == snt)
+		return true;
+
+	/* Non-ECT altered to something or something became non-ECT */
+	if (snt == INET_ECN_NOT_ECT || rcv == INET_ECN_NOT_ECT)
+		return false;
+	/* CE -> ECT(0/1)? */
+	if (snt == INET_ECN_CE)
+		return false;
+	return true;
+}
+
+static inline bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace,
+						    u8 sent_ect)
+{
+	u8 ect = tcp_accecn_extract_syn_ect(ace);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
+		return true;
+
+	if (!tcp_ect_transition_valid(sent_ect, ect)) {
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		return false;
+	}
+
+	return true;
+}
+
+/* Validate the 3rd ACK based on the ACE field, see Table 4 of AccECN spec */
+static inline void tcp_accecn_third_ack(struct sock *sk,
+					const struct sk_buff *skb, u8 sent_ect)
+{
+	u8 ace = tcp_accecn_ace(tcp_hdr(skb));
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	switch (ace) {
+	case 0x0:
+		/* Invalid value */
+		tcp_accecn_fail_mode_set(tp, TCP_ACCECN_ACE_FAIL_RECV);
+		break;
+	case 0x7:
+	case 0x5:
+	case 0x1:
+		/* Unused but legal values */
+		break;
+	default:
+		/* Validation only applies to first non-data packet */
+		if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq &&
+		    !TCP_SKB_CB(skb)->sacked &&
+		    tcp_accecn_validate_syn_feedback(sk, ace, sent_ect)) {
+			if ((tcp_accecn_extract_syn_ect(ace) == INET_ECN_CE) &&
+			    !tp->delivered_ce)
+				tp->delivered_ce++;
+		}
+		break;
+	}
 }
 
 /* Updates Accurate ECN received counters from the received IP ECN field */
-static inline void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *skb)
+static inline void tcp_ecn_received_counters(struct sock *sk,
+					     const struct sk_buff *skb)
 {
 	u8 ecnfield = TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
 	u8 is_ce = INET_ECN_is_ce(ecnfield);
@@ -74,27 +194,152 @@ static inline void tcp_ecn_received_counters(struct sock *sk, const struct sk_bu
 	}
 }
 
-static inline void tcp_accecn_set_ace(struct tcphdr *th, struct tcp_sock *tp)
+/* AccECN specification, 5.1: [...] a server can determine that it
+ * negotiated AccECN as [...] if the ACK contains an ACE field with
+ * the value 0b010 to 0b111 (decimal 2 to 7).
+ */
+static inline bool cookie_accecn_ok(const struct tcphdr *th)
 {
-	u32 wire_ace;
+	return tcp_accecn_ace(th) > 0x1;
+}
+
+/* Used to form the ACE flags for SYN/ACK */
+static inline u16 tcp_accecn_reflector_flags(u8 ect)
+{
+	/* TCP ACE flags of SYN/ACK are set based on IP-ECN received from SYN.
+	 * Below is an excerpt from the 1st block of Table 2 of AccECN spec,
+	 * in which TCP ACE flags are encoded as: (AE << 2) | (CWR << 1) | ECE
+	 */
+	static const u8 ecn_to_ace_flags[4] = {
+		0b010,	/* Not-ECT is received */
+		0b011,	/* ECT(1) is received */
+		0b100,	/* ECT(0) is received */
+		0b110	/* CE is received */
+	};
+
+	return FIELD_PREP(TCPHDR_ACE, ecn_to_ace_flags[ect & 0x3]);
+}
 
-	wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
-	th->ece = !!(wire_ace & 0x1);
-	th->cwr = !!(wire_ace & 0x2);
-	th->ae = !!(wire_ace & 0x4);
+/* AccECN specification, 3.1.2: If a TCP server that implements AccECN
+ * receives a SYN with the three TCP header flags (AE, CWR and ECE) set
+ * to any combination other than 000, 011 or 111, it MUST negotiate the
+ * use of AccECN as if they had been set to 111.
+ */
+static inline bool tcp_accecn_syn_requested(const struct tcphdr *th)
+{
+	u8 ace = tcp_accecn_ace(th);
+
+	return ace && ace != 0x3;
+}
+
+static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
+{
+	tp->received_ce = 0;
 	tp->received_ce_pending = 0;
 }
 
-static inline void tcp_ecn_rcv_synack(struct tcp_sock *tp,
-				      const struct tcphdr *th)
+/* Used for make_synack to form the ACE flags */
+static inline void tcp_accecn_echo_syn_ect(struct tcphdr *th, u8 ect)
 {
-	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || th->cwr))
+	/* TCP ACE flags of SYN/ACK are set based on IP-ECN codepoint received
+	 * from SYN. Below is an excerpt from Table 2 of the AccECN spec:
+	 * +====================+====================================+
+	 * |  IP-ECN codepoint  |  Respective ACE falgs on SYN/ACK   |
+	 * |   received on SYN  |       AE       CWR       ECE       |
+	 * +====================+====================================+
+	 * |      Not-ECT       |       0         1         0        |
+	 * |      ECT(1)        |       0         1         1        |
+	 * |      ECT(0)        |       1         0         0        |
+	 * |        CE          |       1         1         0        |
+	 * +====================+====================================+
+	 */
+	th->ae = !!(ect & INET_ECN_ECT_0);
+	th->cwr = ect != INET_ECN_ECT_0;
+	th->ece = ect == INET_ECN_ECT_1;
+}
+
+static inline void tcp_accecn_set_ace(struct tcp_sock *tp, struct sk_buff *skb,
+				      struct tcphdr *th)
+{
+	u32 wire_ace;
+
+	/* The final packet of the 3WHS or anything like it must reflect
+	 * the SYN/ACK ECT instead of putting CEP into ACE field, such
+	 * case show up in tcp_flags.
+	 */
+	if (likely(!(TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACE))) {
+		wire_ace = tp->received_ce + TCP_ACCECN_CEP_INIT_OFFSET;
+		th->ece = !!(wire_ace & 0x1);
+		th->cwr = !!(wire_ace & 0x2);
+		th->ae = !!(wire_ace & 0x4);
+		tp->received_ce_pending = 0;
+	}
+}
+
+/* See Table 2 of the AccECN draft */
+static inline void tcp_ecn_rcv_synack(struct sock *sk, const struct tcphdr *th,
+				      u8 ip_dsfield)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u8 ace = tcp_accecn_ace(th);
+
+	switch (ace) {
+	case 0x0:
+	case 0x7:
+		/* +========+========+============+=============+
+		 * | A      | B      |  SYN/ACK   |  Feedback   |
+		 * |        |        |    B->A    |  Mode of A  |
+		 * |        |        | AE CWR ECE |             |
+		 * +========+========+============+=============+
+		 * | AccECN | No ECN | 0   0   0  |   Not ECN   |
+		 * | AccECN | Broken | 1   1   1  |   Not ECN   |
+		 * +========+========+============+=============+
+		 */
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
+		break;
+	case 0x1:
+	case 0x5:
+		/* +========+========+============+=============+
+		 * | A      | B      |  SYN/ACK   |  Feedback   |
+		 * |        |        |    B->A    |  Mode of A  |
+		 * |        |        | AE CWR ECE |             |
+		 * +========+========+============+=============+
+		 * | AccECN | Nonce  | 1   0   1  | (Reserved)  |
+		 * | AccECN | ECN    | 0   0   1  | Classic ECN |
+		 * | Nonce  | AccECN | 0   0   1  | Classic ECN |
+		 * | ECN    | AccECN | 0   0   1  | Classic ECN |
+		 * +========+========+============+=============+
+		 */
+		if (tcp_ecn_mode_pending(tp))
+			/* Downgrade from AccECN, or requested initially */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		break;
+	default:
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_rcv = ip_dsfield & INET_ECN_MASK;
+		if (INET_ECN_is_ce(ip_dsfield) &&
+		    tcp_accecn_validate_syn_feedback(sk, ace,
+						     tp->syn_ect_snt)) {
+			tp->received_ce++;
+			tp->received_ce_pending++;
+		}
+		break;
+	}
 }
 
-static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp,
-				   const struct tcphdr *th)
+static inline void tcp_ecn_rcv_syn(struct tcp_sock *tp, const struct tcphdr *th,
+				   const struct sk_buff *skb)
 {
+	if (tcp_ecn_mode_pending(tp)) {
+		if (!tcp_accecn_syn_requested(th)) {
+			/* Downgrade to classic ECN feedback */
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		} else {
+			tp->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					  INET_ECN_MASK;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		}
+	}
 	if (tcp_ecn_mode_rfc3168(tp) && (!th->ece || !th->cwr))
 		tcp_ecn_mode_set(tp, TCP_ECN_DISABLED);
 }
@@ -110,7 +355,7 @@ static inline bool tcp_ecn_rcv_ecn_echo(const struct tcp_sock *tp,
 /* Packet ECN state for a SYN-ACK */
 static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 {
-	const struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_sock *tp = tcp_sk(sk);
 
 	TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_CWR;
 	if (tcp_ecn_disabled(tp))
@@ -118,6 +363,13 @@ static inline void tcp_ecn_send_synack(struct sock *sk, struct sk_buff *skb)
 	else if (tcp_ca_needs_ecn(sk) ||
 		 tcp_bpf_ca_needs_ecn(sk))
 		INET_ECN_xmit(sk);
+
+	if (tp->ecn_flags & TCP_ECN_MODE_ACCECN) {
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+		TCP_SKB_CB(skb)->tcp_flags |=
+			tcp_accecn_reflector_flags(tp->syn_ect_rcv);
+		tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+	}
 }
 
 /* Packet ECN state for a SYN.  */
@@ -125,8 +377,13 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	bool bpf_needs_ecn = tcp_bpf_ca_needs_ecn(sk);
-	bool use_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn) == 1 ||
-		tcp_ca_needs_ecn(sk) || bpf_needs_ecn;
+	bool use_ecn, use_accecn;
+	u8 tcp_ecn = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
+
+	use_accecn = tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ACCECN;
+	use_ecn = tcp_ecn == TCP_ECN_IN_ECN_OUT_ECN ||
+		  tcp_ecn == TCP_ECN_IN_ACCECN_OUT_ECN ||
+		  tcp_ca_needs_ecn(sk) || bpf_needs_ecn || use_accecn;
 
 	if (!use_ecn) {
 		const struct dst_entry *dst = __sk_dst_get(sk);
@@ -142,23 +399,32 @@ static inline void tcp_ecn_send_syn(struct sock *sk, struct sk_buff *skb)
 			INET_ECN_xmit(sk);
 
 		TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_ECE | TCPHDR_CWR;
-		tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		if (use_accecn) {
+			TCP_SKB_CB(skb)->tcp_flags |= TCPHDR_AE;
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_PENDING);
+			tp->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
+		} else {
+			tcp_ecn_mode_set(tp, TCP_ECN_MODE_RFC3168);
+		}
 	}
 }
 
 static inline void tcp_ecn_clear_syn(struct sock *sk, struct sk_buff *skb)
 {
-	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback))
+	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_fallback)) {
 		/* tp->ecn_flags are cleared at a later point in time when
 		 * SYN ACK is ultimatively being received.
 		 */
-		TCP_SKB_CB(skb)->tcp_flags &= ~(TCPHDR_ECE | TCPHDR_CWR);
+		TCP_SKB_CB(skb)->tcp_flags &= ~TCPHDR_ACE;
+	}
 }
 
 static inline void
 tcp_ecn_make_synack(const struct request_sock *req, struct tcphdr *th)
 {
-	if (inet_rsk(req)->ecn_ok)
+	if (tcp_rsk(req)->accecn_ok)
+		tcp_accecn_echo_syn_ect(th, tcp_rsk(req)->syn_ect_rcv);
+	else if (inet_rsk(req)->ecn_ok)
 		th->ece = 1;
 }
 
diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index eb0819463fae..569befcf021b 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -12,6 +12,7 @@
 #include <linux/export.h>
 #include <net/secure_seq.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/route.h>
 
 static siphash_aligned_key_t syncookie_secret[2];
@@ -403,6 +404,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct inet_request_sock *ireq;
 	struct net *net = sock_net(sk);
+	struct tcp_request_sock *treq;
 	struct request_sock *req;
 	struct sock *ret = sk;
 	struct flowi4 fl4;
@@ -428,6 +430,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	}
 
 	ireq = inet_rsk(req);
+	treq = tcp_rsk(req);
 
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -483,6 +486,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, &rt->dst);
+	treq->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, &rt->dst);
 	/* ip_queue_xmit() depends on our flow being setup
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 3a43010d726f..268f8b86e8a7 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -47,6 +47,7 @@ static unsigned int udp_child_hash_entries_max = UDP_HTABLE_SIZE_MAX;
 static int tcp_plb_max_rounds = 31;
 static int tcp_plb_max_cong_thresh = 256;
 static unsigned int tcp_tw_reuse_delay_max = TCP_PAWS_MSL * MSEC_PER_SEC;
+static int tcp_ecn_mode_max = 2;
 
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
@@ -728,7 +729,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dou8vec_minmax,
 		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_TWO,
+		.extra2		= &tcp_ecn_mode_max,
 	},
 	{
 		.procname	= "tcp_ecn_fallback",
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 56b957efdee1..a387c39c9ea2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3391,6 +3391,7 @@ int tcp_disconnect(struct sock *sk, int flags)
 	tp->window_clamp = 0;
 	tp->delivered = 0;
 	tp->delivered_ce = 0;
+	tp->accecn_fail_mode = 0;
 	tcp_accecn_init_counters(tp);
 	if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
 		icsk->icsk_ca_ops->release(sk);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 98782134c2f4..8449a5a3e368 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3665,8 +3665,18 @@ bool tcp_oow_rate_limited(struct net *net, const struct sk_buff *skb,
 	return __tcp_oow_rate_limited(net, mib_idx, last_oow_ack_time);
 }
 
+static void tcp_send_ack_reflect_ect(struct sock *sk, bool accecn_reflector)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	u16 flags = 0;
+
+	if (accecn_reflector)
+		flags = tcp_accecn_reflector_flags(tp->syn_ect_rcv);
+	__tcp_send_ack(sk, tp->rcv_nxt, flags);
+}
+
 /* RFC 5961 7 [ACK Throttling] */
-static void tcp_send_challenge_ack(struct sock *sk)
+static void tcp_send_challenge_ack(struct sock *sk, bool accecn_reflector)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
@@ -3696,7 +3706,7 @@ static void tcp_send_challenge_ack(struct sock *sk)
 		WRITE_ONCE(net->ipv4.tcp_challenge_count, count - 1);
 send_ack:
 		NET_INC_STATS(net, LINUX_MIB_TCPCHALLENGEACK);
-		tcp_send_ack(sk);
+		tcp_send_ack_reflect_ect(sk, accecn_reflector);
 	}
 }
 
@@ -3863,7 +3873,7 @@ static int tcp_ack(struct sock *sk, const struct sk_buff *skb, int flag)
 		/* RFC 5961 5.2 [Blind Data Injection Attack].[Mitigation] */
 		if (before(ack, prior_snd_una - max_window)) {
 			if (!(flag & FLAG_NO_CHALLENGE_ACK))
-				tcp_send_challenge_ack(sk);
+				tcp_send_challenge_ack(sk, false);
 			return -SKB_DROP_REASON_TCP_TOO_OLD_ACK;
 		}
 		goto old_ack;
@@ -5907,6 +5917,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 				  const struct tcphdr *th, int syn_inerr)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	bool accecn_reflector = false;
 	SKB_DR(reason);
 
 	/* RFC1323: H1. Apply PAWS check first. */
@@ -6004,7 +6015,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (tp->syn_fastopen && !tp->data_segs_in &&
 		    sk->sk_state == TCP_ESTABLISHED)
 			tcp_fastopen_active_disable(sk);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, false);
 		SKB_DR_SET(reason, TCP_RESET);
 		goto discard;
 	}
@@ -6015,6 +6026,8 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 	 * RFC 5961 4.2 : Send a challenge ack
 	 */
 	if (th->syn) {
+		if (tcp_ecn_mode_accecn(tp))
+			accecn_reflector = true;
 		if (sk->sk_state == TCP_SYN_RECV && sk->sk_socket && th->ack &&
 		    TCP_SKB_CB(skb)->seq + 1 == TCP_SKB_CB(skb)->end_seq &&
 		    TCP_SKB_CB(skb)->seq + 1 == tp->rcv_nxt &&
@@ -6024,7 +6037,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
 		if (syn_inerr)
 			TCP_INC_STATS(sock_net(sk), TCP_MIB_INERRS);
 		NET_INC_STATS(sock_net(sk), LINUX_MIB_TCPSYNCHALLENGE);
-		tcp_send_challenge_ack(sk);
+		tcp_send_challenge_ack(sk, accecn_reflector);
 		SKB_DR_SET(reason, TCP_INVALID_SYN);
 		goto discard;
 	}
@@ -6493,7 +6506,8 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		 *    state to ESTABLISHED..."
 		 */
 
-		tcp_ecn_rcv_synack(tp, th);
+		if (tcp_ecn_mode_any(tp))
+			tcp_ecn_rcv_synack(sk, th, TCP_SKB_CB(skb)->ip_dsfield);
 
 		tcp_init_wl(tp, TCP_SKB_CB(skb)->seq);
 		tcp_try_undo_spurious_syn(sk);
@@ -6565,7 +6579,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 					     TCP_DELACK_MAX, false);
 			goto consume;
 		}
-		tcp_send_ack(sk);
+		tcp_send_ack_reflect_ect(sk, tcp_ecn_mode_accecn(tp));
 		return -1;
 	}
 
@@ -6624,7 +6638,7 @@ static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 		tp->snd_wl1    = TCP_SKB_CB(skb)->seq;
 		tp->max_window = tp->snd_wnd;
 
-		tcp_ecn_rcv_syn(tp, th);
+		tcp_ecn_rcv_syn(tp, th, skb);
 
 		tcp_mtup_init(sk);
 		tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
@@ -6806,7 +6820,7 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		}
 		/* accept old ack during closing */
 		if ((int)reason < 0) {
-			tcp_send_challenge_ack(sk);
+			tcp_send_challenge_ack(sk, false);
 			reason = -reason;
 			goto discard;
 		}
@@ -6853,9 +6867,12 @@ tcp_rcv_state_process(struct sock *sk, struct sk_buff *skb)
 		tp->lsndtime = tcp_jiffies32;
 
 		tcp_initialize_rcv_mss(sk);
+		if (tcp_ecn_mode_accecn(tp))
+			tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
 		tcp_fast_path_on(tp);
 		if (sk->sk_shutdown & SEND_SHUTDOWN)
 			tcp_shutdown(sk, SEND_SHUTDOWN);
+
 		break;
 
 	case TCP_FIN_WAIT1: {
@@ -7025,6 +7042,15 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	bool ect, ecn_ok;
 	u32 ecn_ok_dst;
 
+	if (tcp_accecn_syn_requested(th) &&
+	    READ_ONCE(net->ipv4.sysctl_tcp_ecn) >= 3) {
+		inet_rsk(req)->ecn_ok = 1;
+		tcp_rsk(req)->accecn_ok = 1;
+		tcp_rsk(req)->syn_ect_rcv = TCP_SKB_CB(skb)->ip_dsfield &
+					    INET_ECN_MASK;
+		return;
+	}
+
 	if (!th_ecn)
 		return;
 
@@ -7032,7 +7058,8 @@ static void tcp_ecn_create_request(struct request_sock *req,
 	ecn_ok_dst = dst_feature(dst, DST_FEATURE_ECN_MASK);
 	ecn_ok = READ_ONCE(net->ipv4.sysctl_tcp_ecn) || ecn_ok_dst;
 
-	if (((!ect || th->res1) && ecn_ok) || tcp_ca_needs_ecn(listen_sk) ||
+	if (((!ect || th->res1 || th->ae) && ecn_ok) ||
+	    tcp_ca_needs_ecn(listen_sk) ||
 	    (ecn_ok_dst & DST_FEATURE_ECN_CA) ||
 	    tcp_bpf_ca_needs_ecn((struct sock *)req))
 		inet_rsk(req)->ecn_ok = 1;
@@ -7050,6 +7077,9 @@ static void tcp_openreq_init(struct request_sock *req,
 	tcp_rsk(req)->snt_synack = 0;
 	tcp_rsk(req)->snt_tsval_first = 0;
 	tcp_rsk(req)->last_oow_ack_time = 0;
+	tcp_rsk(req)->accecn_ok = 0;
+	tcp_rsk(req)->syn_ect_rcv = 0;
+	tcp_rsk(req)->syn_ect_snt = 0;
 	req->mss = rx_opt->mss_clamp;
 	req->ts_recent = rx_opt->saw_tstamp ? rx_opt->rcv_tsval : 0;
 	ireq->tstamp_ok = rx_opt->tstamp_ok;
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 1e58a8a9ff7a..153ec53108f8 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -65,6 +65,7 @@
 #include <net/icmp.h>
 #include <net/inet_hashtables.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/transp_v6.h>
 #include <net/ipv6.h>
 #include <net/inet_common.h>
@@ -1189,7 +1190,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 			      enum tcp_synack_type synack_type,
 			      struct sk_buff *syn_skb)
 {
-	const struct inet_request_sock *ireq = inet_rsk(req);
+	struct inet_request_sock *ireq = inet_rsk(req);
 	struct flowi4 fl4;
 	int err = -1;
 	struct sk_buff *skb;
@@ -1202,6 +1203,7 @@ static int tcp_v4_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = inet_sk(sk)->tos & INET_ECN_MASK;
 		__tcp_v4_send_check(skb, ireq->ir_loc_addr, ireq->ir_rmt_addr);
 
 		tos = READ_ONCE(inet_sk(sk)->tos);
@@ -3575,7 +3577,7 @@ static void __net_init tcp_set_hashinfo(struct net *net)
 
 static int __net_init tcp_sk_init(struct net *net)
 {
-	net->ipv4.sysctl_tcp_ecn = 2;
+	net->ipv4.sysctl_tcp_ecn = TCP_ECN_IN_ECN_OUT_NOECN;
 	net->ipv4.sysctl_tcp_ecn_fallback = 1;
 
 	net->ipv4.sysctl_tcp_base_mss = TCP_BASE_MSS;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index d1c9e4088646..9eeb33344762 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -20,6 +20,7 @@
  */
 
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 #include <net/xfrm.h>
 #include <net/busy_poll.h>
 #include <net/rstreason.h>
@@ -460,12 +461,23 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	ireq->rcv_wscale = rcv_wscale;
 }
 
-static void tcp_ecn_openreq_child(struct tcp_sock *tp,
-				  const struct request_sock *req)
+static void tcp_ecn_openreq_child(struct sock *sk,
+				  const struct request_sock *req,
+				  const struct sk_buff *skb)
 {
-	tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
-			     TCP_ECN_MODE_RFC3168 :
-			     TCP_ECN_DISABLED);
+	const struct tcp_request_sock *treq = tcp_rsk(req);
+	struct tcp_sock *tp = tcp_sk(sk);
+
+	if (treq->accecn_ok) {
+		tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
+		tp->syn_ect_snt = treq->syn_ect_snt;
+		tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
+		tcp_ecn_received_counters(sk, skb);
+	} else {
+		tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
+				     TCP_ECN_MODE_RFC3168 :
+				     TCP_ECN_DISABLED);
+	}
 }
 
 void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
@@ -630,7 +642,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
 	newtp->rx_opt.mss_clamp = req->mss;
-	tcp_ecn_openreq_child(newtp, req);
+	tcp_ecn_openreq_child(newsk, req, skb);
 	newtp->fastopen_req = NULL;
 	RCU_INIT_POINTER(newtp->fastopen_rsk, NULL);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index a3a6d3e91d84..deb9b085a8a2 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -332,8 +332,9 @@ static void tcp_ecn_send(struct sock *sk, struct sk_buff *skb,
 		return;
 
 	if (tcp_ecn_mode_accecn(tp)) {
-		INET_ECN_xmit(sk);
-		tcp_accecn_set_ace(th, tp);
+		if (!tcp_accecn_ace_fail_recv(tp))
+			INET_ECN_xmit(sk);
+		tcp_accecn_set_ace(tp, skb, th);
 		skb_shinfo(skb)->gso_type |= SKB_GSO_TCP_ACCECN;
 	} else {
 		/* Not-retransmitted data segment: set ECT and inject CWR. */
@@ -3356,7 +3357,10 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 			tcp_retrans_try_collapse(sk, skb, avail_wnd);
 	}
 
-	/* RFC3168, section 6.1.1.1. ECN fallback */
+	/* RFC3168, section 6.1.1.1. ECN fallback
+	 * As AccECN uses the same SYN flags (+ AE), this check covers both
+	 * cases.
+	 */
 	if ((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN_ECN) == TCPHDR_SYN_ECN)
 		tcp_ecn_clear_syn(sk, skb);
 
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index f0ee1a909771..7e007f013ec8 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -16,6 +16,7 @@
 #include <net/secure_seq.h>
 #include <net/ipv6.h>
 #include <net/tcp.h>
+#include <net/tcp_ecn.h>
 
 #define COOKIEBITS 24	/* Upper bits store count */
 #define COOKIEMASK (((__u32)1 << COOKIEBITS) - 1)
@@ -264,6 +265,7 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	if (!req->syncookie)
 		ireq->rcv_wscale = rcv_wscale;
 	ireq->ecn_ok &= cookie_ecn_ok(net, dst);
+	tcp_rsk(req)->accecn_ok = ireq->ecn_ok && cookie_accecn_ok(th);
 
 	ret = tcp_get_cookie_sock(sk, skb, req, dst);
 	if (!ret) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 0562e939b2e3..704bde5e156d 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -544,6 +544,7 @@ static int tcp_v6_send_synack(const struct sock *sk, struct dst_entry *dst,
 	skb = tcp_make_synack(sk, dst, req, foc, synack_type, syn_skb);
 
 	if (skb) {
+		tcp_rsk(req)->syn_ect_snt = np->tclass & INET_ECN_MASK;
 		__tcp_v6_send_check(skb, &ireq->ir_v6_loc_addr,
 				    &ireq->ir_v6_rmt_addr);
 
-- 
2.34.1


