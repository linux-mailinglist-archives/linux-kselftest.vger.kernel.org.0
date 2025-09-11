Return-Path: <linux-kselftest+bounces-41226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B55CDB52EB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 12:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D1C8168642
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Sep 2025 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E730C347;
	Thu, 11 Sep 2025 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="g9J4o7tK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013032.outbound.protection.outlook.com [40.107.162.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAFA23506A;
	Thu, 11 Sep 2025 10:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757587105; cv=fail; b=rtSnxIgwykQrsYbl4d+U0TzT7m8HRPmLWP15E6dNrB2YhRNdBF5VwNS53cdDO2Boj8IqVGh/5aaZUZkvmcTbU2ihpTpZ0h05p8bCCMpyJc6mvVoGhJ0rHSwhgsaDqfHVA++ze8sg1MIfEVM3DlOaVWsgbFM43x5F2MQvTozW0Cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757587105; c=relaxed/simple;
	bh=wx2yeEHxovUQZg+8AvGf659voJ+ixu7tXUSwYflqwS8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OlwSj+qdtmVear/1HxDuBZE20y5pC5bqSflm3KaBdrbXd3ZEQi3LK2JxbosVmJUX/HwMMLAO8pEbJ+n87SaGEuioJYSQ5BTXc3IY2u4Xy84Oq+26gpbe3QE9ZOwFaq3iYTEeeoV+Pl8x0cr9PUeyP1BRgON6ZuNfI34wkWZyPdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=g9J4o7tK; arc=fail smtp.client-ip=40.107.162.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx9zekP8qGbgPhZNDyW529oVSna0MIPisgp08V7Uwv+BaiUbR0N9vZC1n58op0geovwJt2DXVZQ2mBDRtzSTTNm543jkCOMpD4GRxR1PQCV+ft+sbNdJzTQbn99gT5crXl9dofjZAmp+4Fyhg0BJKa+8BFiQntsvd4E4wYKZ6NVhYFfwzhpB3ct4/6eyyEPvkqRAeqCHc+637aqavZ4QYZJ+3ncT01tG14wm4qkivhV6Wds+EUqZLXe+ASQnZw4nIGqTizkI054b84nGPBwV9B9ZTTxyhn4R5oEObeHmPsXzHIepZkvemERmFQccwY9TTa2kasbtfTzWbml1j1l92g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx2yeEHxovUQZg+8AvGf659voJ+ixu7tXUSwYflqwS8=;
 b=Jr8U5kp1a3q5T4ZWU1pDc5QDCLaor1VOp96EFeQT3E1Wzmvkk2v+cuWEynZUnjMI2frWwW6/vdHhRcqPjA7p9xlqQ9NF74EuwebwilPpFbDKCfBwk12u65MO59Att/YfeC1B4JGRwjr43dG2oJPsLtyPI5NZ+gkgs4XYQ4Z/BmBvtQ3TjlCFWYTDbUuPc0Yweva9VWVOJ8H8dJZLyzwjFuKxwbdDwM8qgG+g63SaAQ6PYAngxOL5ITg549zoiM4V/na8K12hNb2yMwzr+OckDvKMrG1K9MK6zQGP0sOdrky3HkxQuZMWjkdbrZ6DImjMCTpSmibAghPkWryAqRdIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx2yeEHxovUQZg+8AvGf659voJ+ixu7tXUSwYflqwS8=;
 b=g9J4o7tKk+z3a1EMXc+tWe/RixpbRt8HKVlNECzArgvHk9AZiXyJtXQiXDmtirSjdmp66Mua95BURPBEmfWgMHCu6cJwVd+VoWZfnkKv7I5ltCp2JcL62hQxpecI9JbTNLXo9bQPdpONAKI1yTy2gBIC4GDIyv4PgcSSgTKQ8C+gWFOTP4NEm4THc+hrQ2OmS/LMTH9K3L1ORwkhrcnPp4uKZ1vYFfy5K0EIt3go20iB4Sk+EToIvQys9UByvGZWBMPl+ZPo2jsOadHIKgQzSboU538CRJYI41Lg3X3LwmHWm3PnTBNxwoXst5pJR6QSYZOSFJOH3Os4EIhmZNrzqw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV4PR07MB11313.eurprd07.prod.outlook.com (2603:10a6:150:2da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 10:38:19 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 10:38:19 +0000
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
Subject: RE: [PATCH v17 net-next 12/14] tcp: accecn: AccECN option failure
 handling
Thread-Topic: [PATCH v17 net-next 12/14] tcp: accecn: AccECN option failure
 handling
Thread-Index: AQHcIObaQLyJwh0L6UStJ0wh1xMLfrSNzfKAgAAAXuA=
Date: Thu, 11 Sep 2025 10:38:19 +0000
Message-ID:
 <PAXPR07MB798426ADB8195A9A68A82FDBA309A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250908173408.79715-1-chia-yu.chang@nokia-bell-labs.com>
 <20250908173408.79715-13-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iJcyWE_SxM+sHWM_Es8KibOQpfs+HUTD0G+bnHr3WQn-A@mail.gmail.com>
In-Reply-To:
 <CANn89iJcyWE_SxM+sHWM_Es8KibOQpfs+HUTD0G+bnHr3WQn-A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV4PR07MB11313:EE_
x-ms-office365-filtering-correlation-id: 5537b8a1-f6fa-47ec-1a37-08ddf11f532e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TDVTU3Jydm5MdjQ1aFV0M3AzZDR0dWpESmxHUi9paUhWNlAvSmxURHFzSU5s?=
 =?utf-8?B?M2xydVNRMFZhWng4cGJiTGRib3p3SHlUOWIyR2ZXbkUyMUNVMVRQSCtNdFkw?=
 =?utf-8?B?ZlJSTG1OTDZqejd5MjgwY1N5U0lBTThjTElXZXpKMlJ4cU5va2RXdERNUnVJ?=
 =?utf-8?B?M05PREFYWHJwTEdvUGNQaFE1ejBpS1hjaFI1bDc5RVJyWVczdEtvcnpzVWNZ?=
 =?utf-8?B?QXVrUlhpK0kvSWp1T0o0SjMrckM4dXZyRW5DWUkvWlZwUFNmNnlqS2ZWQTdo?=
 =?utf-8?B?enFOaVRsY1h2RHArRjFsZUErZ0plMm9WN3k4YkhsZ0NKcGhJYmtyekV6ZURa?=
 =?utf-8?B?eHFrRDBhWGs0RGRBK2p3K1RHT05DMUdhdlE4WmFPYkxsQ0dudlVGMUtVZkw4?=
 =?utf-8?B?RnpKNnFiM0FJNXJjc3hrVDJNWTd5NXpqYy9IOUxtZjNJSFZSK0QxWXRWa2Mv?=
 =?utf-8?B?M1FQVWliN1lnNUIvV2tqUXlNM0JhTzBIc2h1K3lmRFJEY0R4L2hvb3JhNFVq?=
 =?utf-8?B?Y1Y2bVc0cjFpc2dqUFJ1YkR4azV3dGREcDhxdncralN2NXc5Y1QwZDlWVnUz?=
 =?utf-8?B?ZmJobHhwaUc3OHVlVXQ2VEd1QlZNMHlLSytQOVBGdzlWZkd4dHJVMmVwYVhN?=
 =?utf-8?B?VnJTSGgvMmV1TitVYTZybzh6MU1MaHhwTEJsazZKeHZIaEc5QnpBcGNjL0pv?=
 =?utf-8?B?cU9SS0dwWW1sWURvQVhITGR3NVZvai9FU3JWUzB0d0lCS05SOXhiVGJDNEFs?=
 =?utf-8?B?QlkwWEovSStBZVRDMWMvb2tLUXFtV2NydW1iRlhKLzdKYlJYeXBNN0tPWmhJ?=
 =?utf-8?B?YmJmRDlmeG0zSHFOcHdIMUlyRHF0MVpDcW5xaWpQNEE1bEEzaFVLS3d4RnRy?=
 =?utf-8?B?aXFKYWZzUUhiMTg0Z2lsREFmakcxREx5R2V3dU1KWXNNazM4TUFyMU5NWTBP?=
 =?utf-8?B?aDBJcC9FT2tJZGI1b2p1ejBuUmlYazJTSkVFYUVPTFR3a0FJWjc0VU13TDh4?=
 =?utf-8?B?cENJenJCWTZjWS9XT1JEQnpwOVFoSWtTQStyb01tQ3c1UU5WaXZMSFVlOHJZ?=
 =?utf-8?B?MCtMZWdXcVJKblo2Njk3S2FQNTkweVVVdDdxVXBqc3JYUU1FTkgrYnJTWmtl?=
 =?utf-8?B?d294L1JFak96YmVOeFdkZVFVYXJGR0pZZlJkMTRvaCtTWDFNNGg3eEp2NFNX?=
 =?utf-8?B?U1ZndkwwMS95UmZla3dZMGJwTXBJUVJadWd4dUVNVlFSOEFnMCtQODJFa2Jz?=
 =?utf-8?B?SFNwM3FWK3hIYnRSakRxRWhyM2J1L1d6OGNaS202SjQ1QUtZQWlJWjkxdUQ5?=
 =?utf-8?B?MTlZVHQ3NmtKbk9YNitsa0c1U1FpR0crdEZQZEdSM3VoSTJqZEF5dFMwc0RL?=
 =?utf-8?B?N2M1dGd5VnJIY1FLL1paaDVKd3dDNVlyb0MxdEtJaGtWckpiN3RDRCtlYUtl?=
 =?utf-8?B?Q0RBWjdkamRLR1BiTExRS09RTFNYR2p3NGQxdHduSUJOamdEaXA3cWE4aWwr?=
 =?utf-8?B?MERML3hodjc2eGV4VzVwTGRxKzFnZWVZaUU2R1FVYitNSjlsaitUeTMxSUlQ?=
 =?utf-8?B?aGhBUGhSU2JVUHA1Qjk1WHdmUVJLL2RxTGJuSDgyN0hCWlZuTHlTR3hsR1dK?=
 =?utf-8?B?UGdZSHQwcDVyeVkrSDIrQ2lYNllONjlTWnAyZUdSTWgrK0pvWnAzdVhhODJj?=
 =?utf-8?B?TkRMcmhiMlVVeGNKUFdVeGNjMWxnMkdXY0dSVnU5VnBCMCtua1F4VHpTeDZu?=
 =?utf-8?B?NXBITW50anNndTU3L3dXZTMvbnQwUVRyd081Vmh0cWE1T1c4NTh5UnFoN0xG?=
 =?utf-8?B?b0NLM3hOeDVKN1MyOUJyTFNEZ2ZrZ0QzT2U0Q01KKzNwY1NDaVRkWnZaWnk4?=
 =?utf-8?B?T1MraWkvVkh3cGlteHNPOVN0VjNNNk5WNEdYSzVyRlAzdU1NTnJCaG11NSs2?=
 =?utf-8?B?M3U5VUlDbWtZeGtSN3lNN3R2V0RNVlpyb2kvTUU3VkVEenBMUEtlYWwzczh3?=
 =?utf-8?Q?ipddgEj75kDvz5STrxyWjBVgn8/ekI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RHF1cHAyMUdZVnFDcXc1NFdBYS9lVUdXdjZkdE1UVmpvVFZObElmcmZmZk9X?=
 =?utf-8?B?dThGaTMyWFVwdVBkWDBOQ3VpMnJ2WUVBRTVtclZ3T0FXSVBBakN3Z3g2S2dZ?=
 =?utf-8?B?cGFOSHduTmJNZ1VBYXJENnJiUHVJOVVNd2hTYnFyZVVONk9UZGhzdExxcEFH?=
 =?utf-8?B?TnhoaVRuVGZUeXdKZ3lxK041enFrQTYxMWo0VDBLQm9hdjV5ZlNYeCthZDZO?=
 =?utf-8?B?WWUxNWZtcjdjcWR0bDJsa2d1eW9nNEp2ZlZscG9zQUVWR21wSDFPM1YwbHp1?=
 =?utf-8?B?QTY1UWN5ejJwbHlHRzJITTc2MGViVHF0QjYrd2JUVVFiZzlicTJDRlhaSjVY?=
 =?utf-8?B?VmxMci9pa3JQQXRFREp0ZzVacVlaTVFCc3ZWaElwTENqcEhEbk1PdVIvbklG?=
 =?utf-8?B?cldkU2pmaDFYUi9KM0l4Z21XOVlCTUZkTWlSOEVURnpSY2pLSG1aekVYNWpn?=
 =?utf-8?B?c3FSTFY2NkM0S2RnMWtPckpWanZHWkNRS3hBSFNzV0hQZFhnclo0WTJHaXNY?=
 =?utf-8?B?QTN0Ymh0TXY5NUhaeGlkdEpLVE0rSXA2dFN4M0ZHMEgzMWNtZ3A5YjJ4M09j?=
 =?utf-8?B?cG5tMlhNTC96bE1WNVZ3MjY3aDhBRk05eklKZFFicisvcUlZZTlGaWNWeXVD?=
 =?utf-8?B?S2h4US93NVkxSXN2K1lnNGo3alRDSVp2NTVVK0FPSlRqTGN5TXdCU0hwWXNW?=
 =?utf-8?B?dkcxMDlBcHlwVHNrWjFCQjY2c3owMTJKck5HUGRTbk5RalRPaGpOTkZCOVJS?=
 =?utf-8?B?UnhSMzdobkRvMVN3VTVPWG1LWVZRaFdPR09abXlXQ3NiQjRCWUE2N0xWRmRX?=
 =?utf-8?B?TWxzM2M4NnR4aGRxRUFjWFQ4ZjZvdFZrMTA0ZkdsK05VTFU4U09RTWpvR1RL?=
 =?utf-8?B?NGduVFdPL3h0NGxmOU9oaHBxRC9zdWZNMXFDZ3hGOHIvOTdseXZlMEt1UVcz?=
 =?utf-8?B?ZERSU0xobnNKQlF3VHg5SXN6N1QrK1VjcUlZcGwzYk01WW9iRldMZXh3c1Fh?=
 =?utf-8?B?V000ZytCSGduTHQrU29kdEhUd3VMNEJyWFp3YzNsR2xqblovYVRxTFd0R2tT?=
 =?utf-8?B?MkNycTRUNExTRC9YWjhZbzE0czBKWmpwWnVmQ09jR2RuS1Y0cFQ4SExPME1n?=
 =?utf-8?B?OFBvUDBXSk5Zb0VRWmV1YVp1VHBTL1lMZ0gyajVHQy9DUkpuVk9MOGRBdHNV?=
 =?utf-8?B?QnR5VXBSS1Z4b0s0eTVMVnFKYitWTFdrZkhPd0ZBU21MU0cyUXN4QzRvcURW?=
 =?utf-8?B?VUhIMHhSUWtLbWIycWNxU1dTTUl6ZFlaRXU2bkZwaEllb0g5K2ZURkhFTHVZ?=
 =?utf-8?B?OGF4OFNzL2h4QXJHMnR0cDFLQXNRcjZvOUZIeGNVRmh6N21VMUt4cC9ITHpw?=
 =?utf-8?B?QXYzeHJDR0g4K3pMRmdPeHBPLy84RUI1c3l1dGlxL0wzU2dPTERhbDVjNTAz?=
 =?utf-8?B?dVRUaTdKTXpmV3l6YmhFbFhoTTJRZkxOeTNNR3RYL2VRVUk2WlhYWEVOY2dU?=
 =?utf-8?B?MXh5ekZkanBvMHBYR2FiN1lvYTVIa3FFMUtUZWdWdzVxcUQ3c3VKYnNSd1M4?=
 =?utf-8?B?Q2lTNTIrdWRTMlc5ckF2SHJ3cFVvdnl3MTRRd0F6R1hjak43N1FsN0k5MnVn?=
 =?utf-8?B?RjVES0FkZEx5V3Y0SnpjZURrelBJSkNHazZ3YkNhdjhiWVp1aEJnNnNwQ245?=
 =?utf-8?B?SkNEYXgvZjZSY1B5SVNCa1pNZ2FIZHBmeUgxQkFHZ3BvY0hRZ2hhdm1uZXJQ?=
 =?utf-8?B?L0ZleENSNWtVVmx2bzNYSXNMdnlUNHJGc281QWQ5cXpBRFlsaWFwcWFXWXpj?=
 =?utf-8?B?M1puTzgyU1VMUXUvTHRPY3c4NE1nNHE3RUk1V0JwWE5hVURITmNKQXhvZGxU?=
 =?utf-8?B?WGgwUHgxektmZ3hscnYwNDIyOS81dDg2dURjYjh2YTBmL2szdW5zb290aVI0?=
 =?utf-8?B?a1ZOb1daVno1WEFoM0NYOVhTU3VVdnliWWMyaTh4bGN2dERBcVc4RFNjcE1X?=
 =?utf-8?B?cGxENHBGRFRJUU9OZDc4WHhjZEtydy9HeTF5T2I1OUpSS3E2b0N3Q21rcyt1?=
 =?utf-8?B?L1JjTlIrVTA5NGRlU2NraUZqaFlmcDh4RjVjS2t5THVDMDQ3Mm9vZEU5WlFE?=
 =?utf-8?B?SHUrS3hlU2Y0clphNGRhOWRJMWUxS3ZqS1BMOUp1bG5Rdm1uY1hvQS9DTnRE?=
 =?utf-8?B?RlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5537b8a1-f6fa-47ec-1a37-08ddf11f532e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 10:38:19.7709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 51VmIXOh7f2zh9Iqq85iUnTzeyeaFnS13UB8oKp2OH8hOIz3uocuDv1GWzjQwjeifBJT9sZvAoQc8oMBifdZZKGe/DugWn0oxeLuWdrJ0wkcL0vgfvNnSL9P0ZR5+hcB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR07MB11313

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDExLCAyMDI1IDEy
OjM2IFBNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4NCj4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBsaW51eC1kb2NAdmdlci5r
ZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJu
ZWwub3JnOyBrdW5peXVAYW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3Vi
YUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdA
Z21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcr
bmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7
IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RA
dmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsgS29l
biBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5j
b20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24u
Y29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBy
cy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFw
cGxlLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYxNyBuZXQtbmV4dCAxMi8xNF0gdGNwOiBh
Y2NlY246IEFjY0VDTiBvcHRpb24gZmFpbHVyZSBoYW5kbGluZw0KPiANCj4gDQo+IENBVVRJT046
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBj
bGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQv
ZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBNb24sIFNl
cCA4LCAyMDI1IGF0IDEwOjM04oCvQU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5v
a2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBBY2NFQ04gb3B0aW9uIG1heSBmYWlsIGluIHZh
cmlvdXMgd2F5LCBoYW5kbGUgdGhlc2U6DQo+ID4gLSBBdHRlbXB0IHRvIG5lZ290aWF0ZSB0aGUg
dXNlIG9mIEFjY0VDTiBvbiB0aGUgMXN0IHJldHJhbnNtaXR0ZWQgU1lODQo+ID4gICAgICAgICAt
IEZyb20gdGhlIDJuZCByZXRyYW5zbWl0dGVkIFNZTiwgc3RvcCBBY2NFQ04gbmVnb3RpYXRpb24N
Cj4gPiAtIFJlbW92ZSBvcHRpb24gZnJvbSBTWU4vQUNLIHJleG1pdHMgdG8gaGFuZGxlIGJsYWNr
aG9sZXMNCj4gPiAtIElmIG5vIG9wdGlvbiBhcnJpdmVzIGluIFNZTi9BQ0ssIGFzc3VtZSBPcHRp
b24gaXMgbm90IHVzYWJsZQ0KPiA+ICAgICAgICAgLSBJZiBhbiBvcHRpb24gYXJyaXZlcyBsYXRl
ciwgcmUtZW5hYmxlZA0KPiA+IC0gSWYgb3B0aW9uIGlzIHplcm9lZCwgZGlzYWJsZSBBY2NFQ04g
b3B0aW9uIHByb2Nlc3NpbmcNCj4gPg0KPiA+IFRoaXMgcGF0Y2ggdXNlIGV4aXN0aW5nIHBhZGRp
bmcgYml0cyBpbiB0Y3BfcmVxdWVzdF9zb2NrIGFuZCBob2xlcyBpbiANCj4gPiB0Y3Bfc29jayB3
aXRob3V0IGluY3JlYXNpbmcgdGhlIHNpemUuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJbHBv
IErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENo
YW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gDQo+IA0KPiAu
Li4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC90Y3AuaCBiL2luY2x1
ZGUvdWFwaS9saW51eC90Y3AuaCBpbmRleCANCj4gPiA1M2UwZTg1YjUyYmUuLjAwNjA0YjdmMmYz
ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdGNwLmgNCj4gPiArKysgYi9p
bmNsdWRlL3VhcGkvbGludXgvdGNwLmgNCj4gPiBAQCAtMzE2LDYgKzMxNiw4IEBAIHN0cnVjdCB0
Y3BfaW5mbyB7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAq
IGluIG1pbGxpc2Vjb25kcywgaW5jbHVkaW5nIGFueQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKiB1bmZpbmlzaGVkIHJlY292ZXJ5Lg0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gPiArICAgICAgIF9fdTE2ICAg
dGNwaV9hY2NlY25fZmFpbF9tb2RlOw0KPiA+ICsgICAgICAgX191MTYgICB0Y3BpX2FjY2Vjbl9v
cHRfc2VlbjsNCj4gDQo+IFdlIG5ldmVyIGFkZCBmaWVsZHMgaW4gdGhlIG1pZGRsZSBvZiB0Y3Bf
aW5mbyAsIGV2ZW4gaW4gYSBwYXRjaCBzZXJpZXMuDQo+IA0KPiBTb21lIHBlb3BsZSBtaWdodCBt
aXNzIHRoaXMgcnVsZSBpbiB0aGUgZnV0dXJlLCBieSBsb29raW5nIGF0IGEgcGF0Y2ggZG9pbmcg
dGhpcywgYW5kIHJlcGVhdGluZyB0aGUgbWlzdGFrZS4uLg0KPiANCj4gDQo+ID4gICAgICAgICBf
X3UzMiAgIHRjcGlfcmVjZWl2ZWRfY2U7ICAgIC8qICMgb2YgQ0UgbWFya3MgcmVjZWl2ZWQgKi8N
Cj4gPiAgICAgICAgIF9fdTMyICAgdGNwaV9kZWxpdmVyZWRfZTFfYnl0ZXM7ICAvKiBBY2N1cmF0
ZSBFQ04gYnl0ZSBjb3VudGVycyAqLw0KPiA+ICAgICAgICAgX191MzIgICB0Y3BpX2RlbGl2ZXJl
ZF9lMF9ieXRlczsNCg0KVGhhbmtzIEVyaWMuDQoNCkkgd2lsbCBmaXggdGhpcyBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQpDaGlhLVl1DQo=

