Return-Path: <linux-kselftest+bounces-42272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C15B9DE0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 09:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B2CE74E10BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 07:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C442E92B3;
	Thu, 25 Sep 2025 07:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ol0SlROu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013028.outbound.protection.outlook.com [40.107.162.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BE0281358;
	Thu, 25 Sep 2025 07:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758786010; cv=fail; b=l7xc9sjSZiKhdfzGNmccvGiFA9p6NJfuyfku2QGA3db95mR5cQwTQjLLxzzRsOnPG/V2w1hzYXYXuH/58Gf2rk+0E4nkDfiJp8V7EDKPDr7HgHDkNgPiypllsMJ1xiwZoMJJ8TLVNQqPDQzGVbSa9KmSUWfEjAhhoYBN8ZBiQjU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758786010; c=relaxed/simple;
	bh=HmYbgBLn68yRnaEXE9soxy9a/imUNuQz31GKIr+1FUQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lrzAGI4hmGYr3U8jC+94E4oxMybF6eoRY2Pt93FcxSaH/QNWb1oU7iIk0g+CcMiwqJTWzzj+CmvAjDoCW+yW+5Xvt+47nTnyxGowS+5ViI8unI1EtnyrZkiu8eRQOgNYXfphz9mO3rcZh5mUDj4JtuYXDzju37n2uUaSPACx54I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ol0SlROu; arc=fail smtp.client-ip=40.107.162.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=olRSqk/CmdtrjTfaJmDn+C1xnNGcDAIBA1ZXSSg3rDPWiA0iwabKqZpZHLt1qdfgOazbtmmD7cO7XQrvz6gu5h0ZsBRfpwyh97jGvVBeeFLEDa7F5zytwCUK7wmfPWNSoiuyZF66R5ra0F5d4gJ7qAXf1GCJGqvD3cZ0Gydq6xeboKoD8sHvTWZy8pOynXZeyXUTX/MB+DoE0+AFW2q7xK+OVjtk6FPVKx7bJMCT6vVyv41CsO/Q1TLMf+xeCd+lNeiYUEaEDRTTRO7taqHd9tSbvV07x/DOo3+dB3XKffrYynNwKrq6IfDYpxEoauTUfU7h1TPldaiMWAud9oilcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmYbgBLn68yRnaEXE9soxy9a/imUNuQz31GKIr+1FUQ=;
 b=txw9Q2RdIXO5R6ewZ5dIXHTEdANILowJNmUQ6d7jGk16n8K9WrT3DfEiz9siTYS18P/DdeU9pA5NwclSduyMEg0K6JTq6LlExaA39Ouq2+qJlSeBKOYF+IqBQZIHIt+20GFf3aLd7+ilOvuCVqS6Y4PD/CyESdg4h9c34vg2MkYkGyeBtT4d42M3mgR8gBZHTxC4Rdqsm/LXmBnD8B3OuHVL5C8Rk0bOGse5ZrVPDmZNfDXvDsUBuRwPvqstTFqCijGAI66uFAS3NoD3g1hd5sJwU3HT7lLK3fB/T2UZY+g88afBBFvIQYQzkNUSNczPho+v234SJJUpNvrG3hhQOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmYbgBLn68yRnaEXE9soxy9a/imUNuQz31GKIr+1FUQ=;
 b=ol0SlROulRNl1kB+14D3z2bGVSQ/Fp7F2eavMT/Tuv9UWk9pvSMtgwzipjtreBmF3FIX4CGr4mwK8FLAFYBB/XG569n3ZomiQRZ9FoKRRRaD2kXyvdamtnMnPbrk1TQQv+0n0LU2Horv2LEDKfZG/hjcR0wLNKOa3SMXlT7wVB2AD04z2SCwaCF8h0K40mBgEvwbwhVSbnL7eZyVrEJO4tUPKxq6g8gDDhcWZSo17sMOTz6sYm2/U+lyeUSd1+av1XKBJi7Td/+1f/QlY6g//97LpCsKLU7d0pCcgULd2x3IFM6uJlxUXEmm4QtaQjoFXI4qMikFpBTzwRzf6sK5yA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AMBPR07MB11322.eurprd07.prod.outlook.com (2603:10a6:20b:6f7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 07:40:04 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 07:40:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
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
CC: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
Thread-Topic: [PATCH v2 net-next 03/14] tcp: accecn: Add ece_delta to
 rate_sample
Thread-Index: AQHcKLhVeG3p04bBK0eKi9gGpt1XfrSgjMcAgAL6CNA=
Date: Thu, 25 Sep 2025 07:40:03 +0000
Message-ID:
 <PAXPR07MB7984DC6C693DAED54AC14161A31FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250918162133.111922-1-chia-yu.chang@nokia-bell-labs.com>
 <20250918162133.111922-4-chia-yu.chang@nokia-bell-labs.com>
 <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
In-Reply-To: <161c09cc-9982-4046-9aa0-d0ec194daba0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AMBPR07MB11322:EE_
x-ms-office365-filtering-correlation-id: c629c5aa-b8ed-4fee-15bf-08ddfc06bdb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXJ5MzN3bnBCTVVqVlU4TGI1R1lTbWI4Mi9VRVR5YXBUdWRnQSsrZ21GK2tT?=
 =?utf-8?B?OWFsdG50cnNMWGZEOVJCOHdOMlB6d0NQcjRmcFVEbVg4Zlk3aWZNS09tRE5H?=
 =?utf-8?B?eWJYMjVNUlNxczkyR01NYVh5VUVONzYwa3FQVUtLV3c4VXRpNVlNdGVpUk5n?=
 =?utf-8?B?SEl4YnFVc0tjU0xMOUtZb2NIdHd4bDlPUkFzU0tnU05GM25BVGR3VEhrWlRN?=
 =?utf-8?B?dzdtTFF1MDRjK3BINE9kQ204YVVQRS85Q3ZWeVk5VzZCYXdpb25SRnNIdG51?=
 =?utf-8?B?d2wrNGlVMDQwRzJGWDlwSUdObTdtN0luZUlyMWZ6ZlhiN3RZNFB3cXY1d1NO?=
 =?utf-8?B?bFpDbFNrbmQyQTFKbjBCem5iaTE5V3NJTUVGUTdjR1grRjYzaWovejdYU0RD?=
 =?utf-8?B?K3ArTmZNbmZUcmk1VnFlUFE5a2Jtb3R1am4rSnlWNDcxQVV3WG5maFc0Z2hv?=
 =?utf-8?B?SWdhYTRpMUw0SWpxSWJjMGpkL0trckJsL0IwSzFyWlhrM0hvVnk5cXdEL0JZ?=
 =?utf-8?B?SDFvQmwzMVpmcmdjblIwckY2RENWRURBZE82anpFRWpYQ1pUQjVXaVdTQ1h4?=
 =?utf-8?B?cnFSWStNWUJzRkhCbjdCVEQ2L2hZUUhWM1JqdDAvZW50M0hvVmVwOGdaSFBo?=
 =?utf-8?B?czRVV0VsbnI4aTFvMi9JTGJTK3VyaEtJQjE5RUlTNFRKeXFya2taN0dZY0Q4?=
 =?utf-8?B?VXdzY052M2ZtNWpxVzRCMFBsWS9XZXN4RTlJNnhhNEdzWStWdFREQmN6bWla?=
 =?utf-8?B?VDhSRkZESXU2QkhMVE56dmNBMjFIaVNNYXpocW1NdGJ2Y0oxTGNHVEQ0N05U?=
 =?utf-8?B?VzhmeTVGR0hremZIT3NITWc4OGJybko1UDRvNnZCZHpHZkxqTVZoc2QrZnUz?=
 =?utf-8?B?V09ia0tmN2V6NkxjeFJXZ1dJZ1l0ZEFwaGhjVCs3WmhockYrZ1ozbHFlNU1z?=
 =?utf-8?B?Y1M2NTlVZTZoaXRvV01HdDB5R1RrN3JyTWJJMmFpbE1CWi9xNlpXWXZlKzFE?=
 =?utf-8?B?WUhIUXgwSmI5UG1yTUM1NVQ1aVJlQkowcUlBN3JpaE5abmkxelhuTTI3aGV2?=
 =?utf-8?B?dE1MOHhRczZtV1BzQzlxVHZ5OFZBTktlWVRyNlNVUmFsU2svLzVEVnozeUhj?=
 =?utf-8?B?WjU2czFKaUo1QnlEQXVKVzMzSHh1eG5pTFZISTZVZnJRN2hHRytnTlF5REFy?=
 =?utf-8?B?ZVF3OW4zclJXb2pta21BOUprQUlTUE1nMjdWYTZoalJyemxSUkdsV3NOQXNK?=
 =?utf-8?B?Kzd0MUhNR05FUGhDeEJuYUpjcFBIQnZ4cng1RjByazlBUjdhZXQwc3ZVbHRn?=
 =?utf-8?B?R2V4OHlVYTA5YzFBNXBIMGZOQ2N1WXArVkVucm44RWUyRUVYREc0T1FCSTU3?=
 =?utf-8?B?RCsxUW9qbmV2b1NodVREeFhhSVJHL3cyY3VKdlljUUpuYms4ekVRbU9HbXp4?=
 =?utf-8?B?TW5YdCs4TkxYNnRTM0hUL3k0ekhkY09rQ3dDOGdNYnhZL0R6QkJpZngwZWRn?=
 =?utf-8?B?bTYxeE5wYXFwR0c2QUg4LzQvQUFvTmYzZndPSTdqUlNaekZZSTdjQnZRZGsr?=
 =?utf-8?B?d0RNck5KUXRNR3JyeHVDd0p0Y0NCRW54UlFOempqT0VOMEl5R0JBdFU1TmZs?=
 =?utf-8?B?YnFwY3NGVmRNM21IcmdFek9CVTJLYTlkaXM3c2d1U2VpdVhxbGFxeDRwcVlv?=
 =?utf-8?B?clZjakhqMVFlQWdZemNiVVp6U3lTNzZBeHMzbHJ6Sk4zcFhZeVRoZldDUUdi?=
 =?utf-8?B?RWIzeUlCZFoyalVDZ09FTHk1L1o4VGZDK2hsY3FuUUdDK0hmaWVJRTJPV2VF?=
 =?utf-8?B?WFVna2tOOTQ5QkZaeEJFWHR3WWxvR2Qxd2xVVzdLVFphb2thV3Q3QXMvVzhw?=
 =?utf-8?B?dkJKL3g5eVBlWUdYRmhMck5yQTh2aWpDb3JYOTduMGJkUG1LUUZMNkh1VVRy?=
 =?utf-8?B?Y0FVREZHMWtQMmwvNTJCVzNHS24wZm1MYWNWSDFUd2Fmb1JURTRuejVUY3Y5?=
 =?utf-8?B?b2tuR0d0WHh0anhuRi9yV0pZeTROaTZDV2p6eGxJRzJMWTZ2NFN4Smdmd1kv?=
 =?utf-8?B?YXJWWWVxa0hvbE56amRsM1oxZGNLWWJFM3BiQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0Q2VG01Tkx4RmVIbVNjaXhvVm5MczA5RldsWnE4SnVLM1VHMzZ2NUtZeWZt?=
 =?utf-8?B?ODdKL29nRTV3U2R3UjRvUVdwbm45ZmJoQnVGazlBa2tjK1dLSURzREVHTFNv?=
 =?utf-8?B?a2NXOHFwSHVMMklTTEJVQmhLbEpTR215U0hTSVZDeGNMN0p2anRGQ0Fzc2FC?=
 =?utf-8?B?QlJlZ0REaHlSL0lMTXErbmozbjZWU0VEQzdiMDl4L0MzR1pqOEhwcDU5T0ha?=
 =?utf-8?B?STd6Z21lSzNQQUxPZ2luMnoxcXZEaVZaQWJhcWZTUDhXSm1WeUhFdUVSUjQy?=
 =?utf-8?B?NFBodzdMVnF0bENkQ0tlOFVmMnVNOVRCVWNzV1J2Ly91ZUFkeDNnSGpLNTZH?=
 =?utf-8?B?TnRYRVBNbXY0Q09vZi83WUsrT3hhRTFvUTNhYjJsdWlyRjhHUVVCU2dMZ0pF?=
 =?utf-8?B?RnNzWEJkUlN1b3VhM2I2WndRaFpMdzZKYXJjUkJvQk1KUWZOY2Jkc0lvOW1q?=
 =?utf-8?B?amVwc2FNbUZudW12SmNaSU5KckJHRDhycGhwM2E5c00yZ0owV3RSL1JHR1lS?=
 =?utf-8?B?eWdqclRQODZEN1ErTmZTMWxwT1JNaUwvSFZvSFZOR0FHR2tsMmtyQWEyZFFQ?=
 =?utf-8?B?N0ZoTDR5emdTbHBQSE1MTGo0SUI2NHZCZFUzN3pIbkRMc0RaOG1VckpNZ0F0?=
 =?utf-8?B?Y2pSeCtFdU5DS1YrWmplV3JvcE9jNEVXVFFGRWVtVG94Sm9RNHFuMGc5cldV?=
 =?utf-8?B?aDZpQnlDS0lZc1UrK1R1VEJnQWgvWkxCUExqYlJYNGYwSlRIK3ZscXNPVE0y?=
 =?utf-8?B?MXpHSWVWQTJyMk1jdjBIcS82cXRwa1dLVUVBY2JuQWVFWDBXQ0lsUXFjcVE3?=
 =?utf-8?B?a05Qbk5iaUc4QTBaQnF3ejBjSmVXY080eVc0Uit4ZGdOVWVWb0pkYVc2cmZh?=
 =?utf-8?B?bDFkOVpQUjZtdFM5azdqNGxESWs4dHVkTzVCUU8wK2MvZklEaGhiUmVSL0JO?=
 =?utf-8?B?WnJ6SnN5ZXMxVTQyZ1FYUU16aTd5ZmJJSmlYTFNkeFpnU2ZrN1hGbUJoWVJw?=
 =?utf-8?B?V3UrL1pFdlVOVVZoalJOSEQ1bUZrdDlCdFV1dUpyU2huc2tNbzZuNFlKdURX?=
 =?utf-8?B?OGYwUkNzUjBHWVU0dnM0dUFLUTVrWkpTVHhQZ0oyay9ORHNsRkFzOHVZaXlV?=
 =?utf-8?B?MFQ1S25jN2txTDdMU25PTm9ZRW94VEJTd3pNYUpQbFNEejdWOXJYbVQwcERJ?=
 =?utf-8?B?Z3ZkbWIrQzNORStOaWxQckg3dVp2alRTMExMb2h4Y0ZJRXQ2Qy9Kck1HVW96?=
 =?utf-8?B?Q0NKTzRFSWdGS1pYc2ZtRGZ4NkJSKzNNN3VRRnJXbFpsTzNCdjBPNEFVa0VJ?=
 =?utf-8?B?Ty9neVNpQTBxUXM4UzB3Tm9WaVg0VGh1eWFpQ1l6cytMQ2p1Mll6d3BZV1dH?=
 =?utf-8?B?T0xuNm41UjAyNHdlNXBFaGd2c2YvS2RPdytteEpCNU9uNnM1YVRnWVhQeG4z?=
 =?utf-8?B?T0E5RlNwL2hMZXVqWkRBQmlBTGZ4ZVVxaVBzdC9KVHBaYzVYL0szUThIbVl0?=
 =?utf-8?B?dmszdlYzRDkzQmlBN0VCN1VLUWhBMmpmNmJaVTNxN0ZzSXBvRmFuQ2lCeDdT?=
 =?utf-8?B?UWJXcmJ0TlVzNDJabE9qQnNqN2RFeUhGS2t1Z0xkaElCUG9pTmFCWmszMzg4?=
 =?utf-8?B?Y2d1UFJoUTR1MWNrbTB2bzVzSEh5d2xYb1h2YWloUUpXcHFaRDBtdWRxaU1m?=
 =?utf-8?B?VnUzRmI1dUdCYk9jMjAzazNrWVJkcENtbXlTR1VnbGZGdFI3dm43dlRKSzBa?=
 =?utf-8?B?MDcyUXZ4VWIvdnVuS3J0R0JKYnRaM1UrNkR5ODJOWjVqdzlvcGJrN1lCSnQr?=
 =?utf-8?B?RXBOUWRZMEN3d0VtUk0yTzFQcTloVk1vZi9KK0NVMmdadGlleFVCT1hua0Iz?=
 =?utf-8?B?c2JsK2NmazljUUhZQ3lPWGVveFpsd3RXZ3d3aG8yaEszdTcwQkFDSFo0U1hK?=
 =?utf-8?B?NEszTHhvRmE4RHRSWUZOQ0tXY0N2WmdlWEJBcVpJY0NlWHhVWWFmS2lYZFlI?=
 =?utf-8?B?NjRZbktFRUo0bkNhcnRRUFk5dEllSHY3NjdTcmd2UXFNeWF4S3Y5NzUxUE9x?=
 =?utf-8?B?UWZtcm9wMTNHQndDbmFnakFMUTdueTlFWURPYU5ndWRBTVJsQ2p4WDlDUldK?=
 =?utf-8?B?dEdZemwzM3dyQjMxMWtKSjFTTXBJcDJQRXBuMjljZEk3K0tNUlYxajZzUXhK?=
 =?utf-8?Q?sAHZlwPoqZ3H6S7H6KFQCqI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c629c5aa-b8ed-4fee-15bf-08ddfc06bdb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2025 07:40:03.8722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UzUolfVnqJDXwXnwHuOJNJm+9b1Cqd0dw3oWgBr98OKKmxzVHVE64Q37HWBhaP+lJ07w2mTuNrDzmOtxoQIF6c1xxRbNsoV3PQpdtjG+6/xAjqzlFt1RfzS4kGMyNTHI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR07MB11322

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjUgMTE6NDgg
QU0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPjsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9y
ZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsg
a3VuaXl1QGFtYXpvbi5jb207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGRhdmUudGFodEBnbWFpbC5jb207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVs
Lm9yZzsgc3RlcGhlbkBuZXR3b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNv
bTsgamlyaUByZXNudWxsaS51czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBs
dW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5n
YmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2Vy
bmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2No
ZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53
aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWly
amEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBn
bXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb20N
Cj4gQ2M6IE9saXZpZXIgVGlsbWFucyAoTm9raWEpIDxvbGl2aWVyLnRpbG1hbnNAbm9raWEuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIG5ldC1uZXh0IDAzLzE0XSB0Y3A6IGFjY2Vjbjog
QWRkIGVjZV9kZWx0YSB0byByYXRlX3NhbXBsZQ0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMg
YW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBs
aW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBh
ZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiA5LzE4LzI1IDY6MjEgUE0s
IGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBJbHBv
IErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPg0KPiA+IEluY2x1ZGUgZWNob2VkIENFIGNv
dW50IGludG8gcmF0ZV9zYW1wbGUuIFJlcGxhY2UgbG9jYWwgZWNuX2NvdW50IA0KPiA+IHZhcmlh
YmxlIHdpdGggaXQuDQo+IA0KPiBXaHk/IHNraW1taW5nIG92ZXIgdGhlIG5leHQgZmV3IHBhdGNo
ZXMgaXQncyBub3QgY2xlYXIgdG8gbWUgd2hpY2ggaXMgdGhlIGdvYWwgaGVyZS4NCj4gDQo+IEV4
cGFuZGluZyB0aGUgY29tbWl0IG1lc3NhZ2Ugd291bGQgaGVscCwgdGhhbmtzIQ0KPiANCj4gUGFv
bG8NCg0KSGkgUGFvbG8sDQoNClNvcnJ5IGZvciBteSBsYXRlIHJlcGx5Lg0KSGVyZSwgZWNlX2Rl
bGF0YSB3aWxsIGJlIHVzZWQgaW4gdGhlIG5leHQgcGF0Y2ggc2VyaWVzIGJ5IHRjcF9wcmFndWUg
KG9yIG90aGVyIGNvbmdlc3Rpb24gY29udHJvbCBhbGdvcml0aG0pIHRoYXQgc3VwcG9ydCBQcmFn
dWUgcmVxdWlyZW1lbnQgdG8gYWRqdXN0IHRoZSBjb25nZXN0aW9uIHdpbmRvdyBhY2NvcmRpbmds
eS4NCkkgd2lsbCBlbGFib3JhdGUgbW9yZSBvbiB0aGUgcGF0Y2ggbm90ZXMsIG9yIHlvdSB0aGlu
ayB0aGlzIHNoYWxsIHN0YXkgaW4gdGhlIHRjcF9wcmFndWUgcGF0Y2ggc2VyaWVzPw0KDQpCZXN0
IHJlZ2FyZHMsDQpDaGlhLVl1DQo=

