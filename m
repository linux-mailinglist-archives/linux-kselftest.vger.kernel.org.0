Return-Path: <linux-kselftest+bounces-39515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2EBB2FDB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE0568604A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AAC2F6184;
	Thu, 21 Aug 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IEKBHQJU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA90281378;
	Thu, 21 Aug 2025 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755788306; cv=fail; b=KwvLWxVP54ttc+NnXLtcOxuqMOH2Md/D/b2XYdkNl8tdV766nzLiFNyRwCq+3xyIhtj3idfdybMBTY04tlFSdtZ7sR02WZI9WU0+oLwoY1HOQJqOFieoHhrC3O8C9RqUvMTNDaeSfNAsMWUfAR5sYd0k0JMhyqG4vSE7RUxlUos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755788306; c=relaxed/simple;
	bh=PGmbvksRBWaMgyL4VWA1u7Dr7ZejNUYChd25ySxuHiM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ACBR9Yo2aABmJfeDZPT9kIhjHVmRT9ltZk8zmdwCDH8r8L6JBDtc2Wz5gl+4RDcd5Eb1RG95g25bUlGZCddUxP4ecPgQjNlQdZPd+5mm3D8+nFZs2MzRXf9uLzLzOqZ2gN/j+2YQOm57TF+U5KgF77gwJvBwUV0GsAnskfYMbcY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IEKBHQJU; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0nijdgAI3CdVYZJda0pP74/NmIrUA766Q2HeP1mkCmJXnni30R5MkxR6dOa9r/w9aBz7hYtYY03ke2EMPs15QyggkLfMgn+hXj4vKg199lFeeOX5Hfe+FUTa5nGUjcw6qeizCoWAoQdYzQt/+XxYIoSteWLAnHfFHJivsDhZ+/YIt35ln3+moQz41Ic39LPUo2DhSxhYkfcLjVoE7U/o/VtJSRMgn8uApVjzkk/HzNmovW5HlNnSw+IrxVXlR7+X2bWBEtyy1pqPHPMzQ4y4fpDwSRVmnQidtTRrqT6SE6abME2Pb4zHdBgfFojX1Y7my5ORwDCL940FaCVIJkUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGmbvksRBWaMgyL4VWA1u7Dr7ZejNUYChd25ySxuHiM=;
 b=hG2czep+2EQc/gfK+kqkAQRM8xzzu6aFt9jkLI6PSBilHAj/DkfD2mveR6SBcGIPa/+cxdOpwIqoFNS8Lge/qWKn5Dm8PtxoGfGxvSzxDcbMg0+tCbfRLvSa6JUwFhxicvKtTX1T1b8X5qkLf37+/Ut3zoSolUeOukVhlTAAmguiKAMhiHEaYdBm79MbfPlPNwc1s8tab5kxOIcq3cHF0nYsNONbNkWAlkOPvVJPr4Md47W8pquXj23fHyIPRcD5xw+/OaUirzDNVUd6rgNinp/mpAToa9HVoZ0MWCYiYeB7Yl6t6trEQKvYQLaps0hM4a4naOW1jkOwknomav1uug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGmbvksRBWaMgyL4VWA1u7Dr7ZejNUYChd25ySxuHiM=;
 b=IEKBHQJUvmvejPOMWGDaU2XybHU3KH3yG+7BXK56NriPppFaVJdFFztUASUR1fURme4JK7PaEJl8qc21R/+yKAsWGKuC5xGCxPxoc0Kr8YhARiwLThyKv0fP5L8nOrOD5O+P9ZNnif94zDkVH32cLZdb6PlX0FZ8QVLIL6S628n0Zq9s/387llg3IRHBPguleDOYUgLsWc/+Fr46QqtCcXtMdBYk3LQV4SFbnwZa7rkyqYLZTjMExoqgilORxfkMSru3CJ9XVqLfe7PfEMFc5G1m/zTjOUZCh2ExXo+QkluZCsBQ2vDOQsaBokm4Pyk8fifSt+XdmXyUrB5+BQzh8w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR0701MB6943.eurprd07.prod.outlook.com (2603:10a6:800:19b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Thu, 21 Aug
 2025 14:58:21 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:58:21 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
Thread-Topic: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
Thread-Index: AQHcDcAxy2pRdXRRoEee7i9sQ4q1KrRtEwQAgAAi57A=
Date: Thu, 21 Aug 2025 14:58:20 +0000
Message-ID:
 <PAXPR07MB798496F6B674558AFD2B1641A332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com>
In-Reply-To:
 <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR0701MB6943:EE_
x-ms-office365-filtering-correlation-id: 1cc5583d-188d-4314-3a17-08dde0c32b86
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SHZJejZISnZzZ05jRjR2Z3hXeFNaTzRlRDduRmFzM1ZvK2pBbDhxbVE5dzh1?=
 =?utf-8?B?b09vNDZqYTA4WHREb3RPcDhQMXVvYmNIYm5SL1ZEUFhmSXYwVldNU3IxK25J?=
 =?utf-8?B?VFJuV2dab3gwdjhEQVo2b014Z243Q1F0OE9OR3hSMTFNV3o3dmVmb2JXZXdn?=
 =?utf-8?B?clpYNjBHNkxVZWN2TGJBMk5yUjhYb09KWi9uN05leHFWM052QkhIekRJQXlV?=
 =?utf-8?B?bFNsakVURXl5Z1lIL2pJaU5mc2h0Y1Q5UkRYY09QNm1pUmF5MFdRZHNzcE91?=
 =?utf-8?B?NVdsRitJTkwvcFRlOTFGMGt3TFhYWDBZanluQ1htNDNySnFiQWFuc0x5dzNu?=
 =?utf-8?B?b2V3RVhxelFzTVFIaDc3ZEJUY3hEVmx0cVNEOWdGaVpwbXFuY3R6V1A0bEVa?=
 =?utf-8?B?ekJLUWFhZVVwa1ZnZEw3RStTSFZkU1FCYXpVaEgzQ1p4dlVicFZ2dmppS3JB?=
 =?utf-8?B?dU91djNuM25sNU5JSkNid2JUOWNSZUdZNFg3YXlqYlBlbkRUcy9DcWRyNUNJ?=
 =?utf-8?B?SEJWR1NIcVZjN2VBd1Z0c2NUc3dQYVR5WitIaEFvSVhEaG9YRzhOYk1uRHJa?=
 =?utf-8?B?VXRMWkxQWDBxWi9sNGkzczdBTURuOWhwYWF5NlZIVnF5RmdzVVlWWG9udHZv?=
 =?utf-8?B?emw3RllsTFd3bUwrS1M0bTB6TXNYdmZhT3Q0R2JGTDd5UFlGRjA2UUloWGEv?=
 =?utf-8?B?RC9RMGI4eUZMTVkyTmtoa2tyalFRd05CaGkvUUYvRThUUDBIVGVWdlZxUUY4?=
 =?utf-8?B?eWliR2NLRXk3QXU1YjZiTmRJNHZrRzJKMEtkZWtlM1VLdlpvNVYzR3BWalFn?=
 =?utf-8?B?Nis1NzN4bDNOL3l6WmtxTlhielpFa25pdHhIaE0rYVBRakd3cmdRZDZZdk1K?=
 =?utf-8?B?eStsQmJaUFNFc1kxejJ1QXhYM1hzQWttMlhzQmNaRkFXdU5zdThyVkl5UHVQ?=
 =?utf-8?B?YmJmQkw2diszQmlsazRhUFFyclVsMGtkK0M1WHNaTkF1aHlKSmdHaHI1TTR2?=
 =?utf-8?B?cFBDMElFZUhqM3g4OVJuNnRyeXRjelZMZzIzZDE4MTdaYWFzZks2aExZeXJD?=
 =?utf-8?B?UHlPQXpLT08xMlQrem5oQWRYcnU5YmMxRFNkTXVzZ3h4WHBsaC94MFN3Z3lz?=
 =?utf-8?B?NS9DNGExRTV6UVJkY0FQeUpPamtsNU9DaHd2cGxPTjFKMTJ4d01EZnRnbUVm?=
 =?utf-8?B?VFBCd2xuWVlnbEpWdnZjZ1RrVDRZWGJZVE1MZk4wcXkwVVdrd2FMZGR1aTIv?=
 =?utf-8?B?RnZvMG5IMVhSeVRoWjg0MVZJb0JvcVZ4RFJNREZsTXVVUThiL2huS0U5Vm04?=
 =?utf-8?B?QWNzZFJDdUZhcXU2Y3BueGVITUxEL1grcFdOMTNMV2xzbEhnS0l1TldjUjRv?=
 =?utf-8?B?c0pVQVhNb1FWNGcyM2VsS1hwRFdZKzhodTQ2WW5JUzBLOHBjZzNsaVRITFpB?=
 =?utf-8?B?L0lpNVpEczM5MFg1Qzh2R2twZGNrOEJDYjB2bXJLaXF5NjVJRjI3d0NxczR5?=
 =?utf-8?B?NCtINVlraWg4T3d1SkRGZ1FjbEtwVVd3L0xJYnF2aVdzTFpBYXI1RytzRW5q?=
 =?utf-8?B?SjJyVUozOXFsVDhaaHdBMzdZNUJSb01LNEVweDg0UTVDaFVsNnFEVzNhN2Jq?=
 =?utf-8?B?UEdrTi9Xak9aYlB1anJUQzBCNFlUMnNhN3ZzenMxWDRUZWQ5OFU4ZEgwbmQz?=
 =?utf-8?B?YytpTHI0d1BkNE5NelpJazBhVGN0elZzUklPbWJEa0pIOERXVTVZdmo2SEhz?=
 =?utf-8?B?TE53ZEFHdXBiK2NTZmRFekVTVnVaSDcwVFZ0K05FTWpqRWNkOU8raU9Yb29o?=
 =?utf-8?B?bUE5ZDdIR2pCcjl0cjk4Y3dmMDFaRUFIV1Z3WWF5Q05vbWpOTDBnWkk2eUc2?=
 =?utf-8?B?aHF4cnp5WlNKV3RpaEN0WlNFVGlHRnBURUFNeWt4MmVYVmt0b2R2UWhQSS9D?=
 =?utf-8?B?blpkbUN6TUdyN1lCQVhjbkgvRjFueWVCZGZxblNjL0JNWlFWQU1YRnh0OFUv?=
 =?utf-8?Q?eSFGHtdsI+a1jaiLsRLvkuVUS/586k=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVFyVm1UZ1BFL3IxVFZEWnlIN0JLUDhpbTBSU1J1ZnkwRUJKaW1QQWZWNkZk?=
 =?utf-8?B?cjkzSTdQQkQrRFcyK3JCbEU5SEFJUGxNMm45WGZCeTlBQ3FMd0U0U01WM1Vk?=
 =?utf-8?B?cXlwSHFRS1I2QjgxTW83TlJFOGhHWGppcTgxc1ZCUWxCQlV4eXY2RWRCMkZz?=
 =?utf-8?B?eSt3Vm5mZUFQK0ZOL1dJbk81SmhGZHNiS3NUQUFTSXp1NWc3WVdmN1hVWVJO?=
 =?utf-8?B?c3dZZlE5MGNFcmwzMjViaWQ0OWlqYjhGK2NtTEpOczVZRGxTT3NxVUUrcXdM?=
 =?utf-8?B?elJ4Z3llMi9EMzRITzBXUjdmcXNoN3k5WEc4bDQ4a1AwMUZFTGp5Z2dhMTdX?=
 =?utf-8?B?S3JhUDFvYlZ0NE14ODVtOHZNVml5K3JDckNJa3dUdERxZXdpcklzdlFKaHE0?=
 =?utf-8?B?UTF1VEt2MGhvWnZPTlNxSFRsV09Fd3hac0RSOWM2eUNGczlJS252dkczV3ky?=
 =?utf-8?B?OXFUMGI5NVFkK043V0dQNVh6elR6dnBBeGZTeDc4Y3hiTkxmR0s3bjJ6bU55?=
 =?utf-8?B?L1hRN25zNTVmWlZxUktUVjRkbDc4bFhNakszSWpWbmtKcUwxbDlENTZWZXVl?=
 =?utf-8?B?Ly91bk9vNEQ2RUY4NzRhZTVQVkR3bWJmanVjRnh2TlU5cm10UXVqOE1FMm1j?=
 =?utf-8?B?R0VoTk92Si9XVkVpQ3JmeXgvdzl0SytpeEl1K0M4M0VZakkzdy9hMXNrRU9L?=
 =?utf-8?B?aXJ2U2NqS0Y3enYrSmEwN0FFZXlqanpJVWx2UFdWYS85VG8zNnFvWXhFM29q?=
 =?utf-8?B?dG9KQytOazlINGFTSXc0TERRQVFrL0p3bjJkWFlaY3V0Y1h5NTZUUGpTaWs3?=
 =?utf-8?B?T2ZmWUl3dE1XRU8xWGJNclNidS9FKzM5N3luRW5kajZCdmZrQXZHM1B2VzNT?=
 =?utf-8?B?ejBQakNQUkJyU3BMM0xhS1Bkdkg5dHk1bUZIMWUxWFQ0TlNOSGM3emFBS3lG?=
 =?utf-8?B?d3h3Q01pQjI5cUR5Mk5KSWVZMVhJdkc3d3ZBVms4Y0ZwOHRZU0p0eHlNU2Fy?=
 =?utf-8?B?T0FnbHgvbmEzZEpjRCtXbE5nSkw2S1BqeGcvQTJyS3AwUzNZQlE2M01pUDRU?=
 =?utf-8?B?TC9YNkxadEI5MVdYMEpidkk0N2hxNjNSNjlvYjd3d2QwWmdjZnNYdlNHVFda?=
 =?utf-8?B?bVZuSW44Z0ZKTzZUcDl1b2k5NGRWQkVYM3VqWExRN1IxYzllQzE4cHBPN0NV?=
 =?utf-8?B?RVl2ZVNLYUZPQ3ZkRXBCS0ovOEFVNkUxaHJvZUpSV05QK3lzcXIyTGdGYnFU?=
 =?utf-8?B?NnV1d3lnYmlBSmFPSWVvRUg0MHlHUXViY0xNWHNjcDdkMk1NTjFGWjRBZkNu?=
 =?utf-8?B?RWNYUmNrd1lLNG90TXQraHo0dzhOeXltOWpKOEhDVEVOaWhJd2NnTDJEWU1x?=
 =?utf-8?B?NThkaDhtNFVSNEhZNWtzaHpKZStuVmxyZUl2VmZXa0ExbVFlSmt1emJEeDNB?=
 =?utf-8?B?b0xFSHhvaDZBbS91aHFxeks3ZVU0UTY0WmZTUDV6QUVtNm1WN0FVZ2FkUVlj?=
 =?utf-8?B?TVpuekhPNWVXeWRJMHRQeDcvRytDTGhaYlBYOWtsWWJiZk8rbFZEdUsrdS9F?=
 =?utf-8?B?TkI0TThLd3NxNEs0QTZPZEJPODV2WU1kYlgzNXlmcTZDcXNIeWExOWI0RWVv?=
 =?utf-8?B?RzZ4d0lnQmpRV1RLZlpvM1NlOU5xc0k3VVY4WVU1TGFLTjR5NFZHV29NYTF4?=
 =?utf-8?B?b2VWdmRMSzdvQUFoUkdBSXNLUTBFays1N0REY0w0Tmp2M2ZVaVcyTm45Qjdu?=
 =?utf-8?B?VEJpQ1N0NEJtODhTT1pROE5mVk53VFRQZDNJeEdValhoOFJ3SURkdjVsS2xi?=
 =?utf-8?B?UE55OFVvWTB4c0s4aG9EQ0pQR0JEblcwU25VZkFmTVp1RFRjWEtOSE5MWlFY?=
 =?utf-8?B?cTA1KzF2NU9mMjN5bFhyZ1E0cVE1YnN3ZVBWUndjTVlIRzlTbzFjS3I2QnJM?=
 =?utf-8?B?L0w5NmJQWkZDcGtBTXZhOWR3dlg5ZFRkUkUzRktYTmJCRHo0UjNRbDNIelRk?=
 =?utf-8?B?VG5CMFlScUxqMU95a1I2cUVpdFpYbWdIYnEvemFEaldXMG0rZEpHbHlvNlRk?=
 =?utf-8?B?LzZrT0V6QW45cDNPZ3czeCtuaHVDQ3AyaThMRkR0aWVzSTRNT0lrNHUrLzF6?=
 =?utf-8?B?c3ArYkRSNlNuVGhjeVFSYzA5eXBLOUpOOWlvOGZ2ZERvKzNlY25OZ21GL0cz?=
 =?utf-8?B?VFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc5583d-188d-4314-3a17-08dde0c32b86
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 14:58:20.9800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Exyj5vjvHRjVmtPkfzHh5rbzfGk8ca9k9n0MalsCcsDJm/ZrzA4u2tcj+h6ONvQleCvv1/NLApVWW6AGT0qWsiCnoxZvNTR/Q0gibybxUVII/RFw2mPmvC47+Nrz8I3E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0701MB6943

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDI6MzAg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5v
cmc7IGt1bml5dUBhbWF6b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtl
cm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFp
bC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRk
ZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1
aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERl
IFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47
IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207
IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmll
dGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE1IG5ldC1uZXh0IDEwLzE0XSB0Y3A6IGFjY2Vj
bjogQWNjRUNOIG9wdGlvbg0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwg
ZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVu
aW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGlu
Zm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBGcmksIEF1ZyAxNSwgMjAyNSBhdCAxOjQw4oCv
QU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQpbLi4uXQ0KPiA+
ICAvKiBVc2VkIGZvciBtYWtlX3N5bmFjayB0byBmb3JtIHRoZSBBQ0UgZmxhZ3MgKi8gZGlmZiAt
LWdpdCANCj4gPiBhL2luY2x1ZGUvdWFwaS9saW51eC90Y3AuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC90Y3AuaCBpbmRleCANCj4gPiBiZGFjOGM0MmZhODIuLjUzZTBlODViNTJiZSAxMDA2NDQNCj4g
PiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdGNwLmgNCj4gPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdGNwLmgNCj4gPiBAQCAtMzE2LDYgKzMxNiwxMyBAQCBzdHJ1Y3QgdGNwX2luZm8gew0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBpbiBtaWxsaXNl
Y29uZHMsIGluY2x1ZGluZyBhbnkNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICogdW5maW5pc2hlZCByZWNvdmVyeS4NCj4gPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICBfX3UzMiAgIHRjcGlfcmVjZWl2
ZWRfY2U7ICAgIC8qICMgb2YgQ0UgbWFya3MgcmVjZWl2ZWQgKi8NCj4gPiArICAgICAgIF9fdTMy
ICAgdGNwaV9kZWxpdmVyZWRfZTFfYnl0ZXM7ICAvKiBBY2N1cmF0ZSBFQ04gYnl0ZSBjb3VudGVy
cyAqLw0KPiA+ICsgICAgICAgX191MzIgICB0Y3BpX2RlbGl2ZXJlZF9lMF9ieXRlczsNCj4gPiAr
ICAgICAgIF9fdTMyICAgdGNwaV9kZWxpdmVyZWRfY2VfYnl0ZXM7DQo+ID4gKyAgICAgICBfX3Uz
MiAgIHRjcGlfcmVjZWl2ZWRfZTFfYnl0ZXM7DQo+ID4gKyAgICAgICBfX3UzMiAgIHRjcGlfcmVj
ZWl2ZWRfZTBfYnl0ZXM7DQo+ID4gKyAgICAgICBfX3UzMiAgIHRjcGlfcmVjZWl2ZWRfY2VfYnl0
ZXM7DQo+ID4gIH07DQo+ID4NCj4gDQo+IFdlIGRvIG5vdCBhZGQgbW9yZSBmaWVsZHMgdG8gdGNw
X2luZm8sIHVubGVzcyBhZGRlZCBmaWVsZHMgYXJlIGEgbXVsdGlwbGUgb2YgNjQgYml0cy4NCj4g
DQo+IE90aGVyd2lzZSBhIGhvbGUgaXMgYWRkZWQgYW5kIGNhbiBub3QgYmUgcmVjb3ZlcmVkLg0K
DQpIaSBFcmljLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KVGhlbiwgd291bGQgaXQg
bWFrZSBzZW5zZSB0byBhZGQgX191MzIgcmVzZXJ2ZWQ7IGhlcmUgb3IgdGhpcyBpcyBub3QgYW4g
b3B0aW9uPw0KDQpDaGlhLVl1DQo=

