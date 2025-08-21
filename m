Return-Path: <linux-kselftest+bounces-39510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 239EFB2FD34
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C4506223A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D00B21CC63;
	Thu, 21 Aug 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LAm31926"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C4A1A9F8A;
	Thu, 21 Aug 2025 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786819; cv=fail; b=rX3crVyZy63Jc7o2GR4/aUzjvL6ahQoxwmYu4VLz4XYBjrVNNRVvD12W/cSRZr1q3e33Og43xksSrkuN6j6WRtchG11pfPNgOtUv7TtqmOlrNJqMWo+5+i3UdbU8U7CVzJfGWwc6/zmmxE5YVrv5buJC+HT7r5nOYh05oiW1dLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786819; c=relaxed/simple;
	bh=dmbHR1gHEa01ha0gBwWL1F/x5OxmA3B69iJ824Wu23A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oJz4SLvkIK3oRqW16l9L23PPE1yTUD+iwq1J++Dh1uB+2ykO0rfsmd/hqLMeRVrRKCdX7/ex0Lwh4rLpPX/JSXB4dqW8MMx0VXPtezImx/7L5a4zEKzit49M9SI8sODW6f1h4WXNMttA591zPTAKMDy/SFfeBEsxdxZKT6alU6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LAm31926; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz+uGIEXaXqkpNwgYugU36HoceJTLILW3MXnJZR23jc69LqqHNxUu9TZ2SKs/bfWFCbgF3+xbzfXuiGznFmxi0n25IGQ62G3cbmyExh30K253pffkpcgeI+OGB0MIMjFcJt6NoAFkUlFpiY75t9do+YqwCOpB+NDmM8wtSBaDu3fabg7l8Bb70lButMeAo9J1/ervjJU1Jvredh84dbXdlhFNwVxIPqoZm0wzc3Xsp/m7xFFJvOzZhNDJXHaOg+hiJZov+VEhNEVu4Bw9ZL2pibhvQF5wIYgTWMPwPr77W5tmpRqyqe/kGK1qaNOa1jUad2fFU3O1vVmr6nQV0pvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmbHR1gHEa01ha0gBwWL1F/x5OxmA3B69iJ824Wu23A=;
 b=WeLqZ4Axi+qQ5wEel9j/gw7F2IHcsyy6OlpR1PTbZESj2ixlILj5ggvEx1aJNqRDZNy4IBZWOP60uE9H2ZhyDefGn+djww4/WBGDWg9sxcZOiVd8rH2mvH4XIJ0x+7YufY/jJ0FfjAGTUH1odyGmnkLk2yP7qCSkdkE2B8ewajwHD3Uk9U5PQNJI8RT8J9EABs0N2PVPgRTbSapRb9GPVwMCjBle04B8xZPQ4iesf0DtFqauoHSscr/94vgJA/H86qDChnFyhuQ0UvT9AKJ+xBJjXWYW8DmdpeXo5Mu86ID+/rndA3phu/GSXxaqb+uV9HXV0dUG3JaAywP9iTB1Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmbHR1gHEa01ha0gBwWL1F/x5OxmA3B69iJ824Wu23A=;
 b=LAm31926tlxSPX9SByA+BVIkB35K3eAJO3cNbVSKyZ1QO1LBJZI5ztfNwbXuAPcg969ZF5BRKAUCl9vy8oohLJjBS3g6uFD9XKonYoJOAS24HtbRwsgzD0o1jOR2j4ztYICG0jWJgaPwLyp0ZFKxN/pH2ZxaEfIC0TZo1GnitCEWIU2AqZq+a/eew19msP0YbT/4Rh0h9vjs3Ja/73tDpVBfPRRdbwQpMypbo/Qdhqe5+hwt/rYIS49hQDjOTgjSnUPu2deHAzls+uWrCuS+wFxg4MIIKd2+FnbUaCmg0oYJFxbdfb6KVCMik1wc7mm6XD0G10jaNQiAjE7YlP3txw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB7792.eurprd07.prod.outlook.com (2603:10a6:102:13b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:33:34 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:33:34 +0000
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
Subject: RE: [PATCH v15 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
Thread-Topic: [PATCH v15 net-next 08/14] tcp: accecn: AccECN needs to know
 delivered bytes
Thread-Index: AQHcDcAulvHvl1lAhUS9ZZ/UPq/mErRtEYOAgAAi5pA=
Date: Thu, 21 Aug 2025 14:33:34 +0000
Message-ID:
 <PAXPR07MB79846C85BDC7CC6ED5112A6AA332A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-9-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKvwM4EFwzuLXOr8OzddQto_rPfdBHUMLzS=xxG3USzTg@mail.gmail.com>
In-Reply-To:
 <CANn89iKvwM4EFwzuLXOr8OzddQto_rPfdBHUMLzS=xxG3USzTg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB7792:EE_
x-ms-office365-filtering-correlation-id: 7d853a1f-e66b-4d7f-a46b-08dde0bfb553
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?R3lQOGZMMTA3bC9pOEVhRmVvMUVWV21EdmoxV3V0bC9LcllUSGFpT3NJSzcr?=
 =?utf-8?B?bUcycUlVN21sWjBPTXV2WnlkVFo4clRnaXFLbGRyOVhxOHEwRFdhNENuTkpB?=
 =?utf-8?B?cThUQ25CYTFabVFxUG9sYjNzMVd0SDNkNC9Sb1F4ZTZOLy9ZZDBpR0lOTkFv?=
 =?utf-8?B?VmQzbzRjMWhyNlE1Yko1TGhVWjhSd21jSXVWODJtODRqV1VCR1NNZHU1N0tw?=
 =?utf-8?B?aEV2eHVkMmNXdTBRenppNFlTaEtlQ2RQOW8wMngxdCtablErL3FIdHByeHA1?=
 =?utf-8?B?cjhqMzRHZk1tVmp5eXYxUURXYlJiYzdmQjdHQ3BERW40Nm1sbzhqVEhoNDBp?=
 =?utf-8?B?RlRIaWJndkNEUyt6YUZsK0hpRk1WS1BBSFpISmJNa2tSclRTMStQU0hJQVB2?=
 =?utf-8?B?UzZ0ZzI1UGtNNGx5QUpsY25VeHNCUTJFR1hKazdIM0pWdHlqRmJTMmwyL0dt?=
 =?utf-8?B?b2FkRTNOVFFoQzFISkZnZ1V1aFp5TWs3MjRNMWdEV1doc1l0VUxUbGV6YU9z?=
 =?utf-8?B?TDRjKzM5NElwYzZFQjdtdHRLT3UwSG5XNFBpNmV1akJ5SkxaUk5ZK2dVV3ZD?=
 =?utf-8?B?VWRoaEtnU29PRmMyb3R2VVdLbU8rU09tU3NYa05MVHZ3c0l6cEczbjlnbWRi?=
 =?utf-8?B?YjZtSS9LeXVCOER4NlI5azZnZXBSaEZPNmZ3Ny9TM1lRdTlaUWdOb2YzeHhm?=
 =?utf-8?B?bWgyemdEdmtFNmJWQjVYbys0OFlyR1dtSTkwV0FpWDY5TzFEWXJpSmQvVFZM?=
 =?utf-8?B?V2RLOEZoS21aR1czQlBEMC95UEMvdklzRzZHcFBZS2s4U3VMNlVSbE1yNGFa?=
 =?utf-8?B?Wmt4VCtpWnlzYlJaSmZKdzN2aURLOXZUV3lkTmk5WDdpVkNrWDVRdDdWVDNZ?=
 =?utf-8?B?QlBNY1kzeklxVTFCRWV3VW8zUit3NjJvOGczam5mVnBKK3hUN0MrS0F0MzlH?=
 =?utf-8?B?Q0wwb0x6Z2F2dE5yMTFDd1ZpVDd6OHlLcWtFaXF3R0RYTXhkS1pXbVpXRFFz?=
 =?utf-8?B?eGdtQjc5d3JRYU5qZFdLaFdzREZEY0xPZDNCZm93SXBSeEdTU2ZzL0xOanpx?=
 =?utf-8?B?ZmY1RzdpVzM3TzBISXBnSXI1Z3R2dUl0SGFwYVkyY1A5NGN5bkxaUm5FQ3ZS?=
 =?utf-8?B?bDlGWGJnS0ZabHRUcWhCTUUzMUZLaW5BcFhuSThqT1QrdlpZd0RYY3RDWndK?=
 =?utf-8?B?QW9iTWtraFdmTFBvS2U1MjFLZWViUnI5QXJjVFNOYUVja1JMU3Jhamo0OCtu?=
 =?utf-8?B?d2JqR0pSU0lNdmhLUXUwZGcwMEtERWNwRmpIMWhlV1JIVUY0YmZka2lCMDhR?=
 =?utf-8?B?YXlVZituTFBjVlZFSXd2eGZjeENaSGY3MzBUcEEvRGtGR3doR2gwL3RnVktw?=
 =?utf-8?B?YUxXNldmREVwMmF4WmRlQzB3d3lETDgzQUxmRC9qSFdrb3l1RUViUnF5UnN4?=
 =?utf-8?B?NVpoazduWWd0TCsxWFJVSXFmYXI2aDZnTXg1WUNpRjE3bTZMbURPN2s4eXhE?=
 =?utf-8?B?MlVlV1d4bTA4YVZhSzVzNGdpcEltQ1FiYTlQVWZmWHVicjdFd3dXV2xuZ0tI?=
 =?utf-8?B?UWx6SUxMbFJCcitwS3RxRDdTeFIraVFTYmhBR2xvRnRoWDl6dHNCWjZYRjIy?=
 =?utf-8?B?ZXNkcmRKcmlPQ3lHNDRUeS9Renl6QWlKODU4VDVWZ3Y0Mmo5RVFDTGxDeHlp?=
 =?utf-8?B?a0dibjA2ME54UUNyM3B6UmxsaUNUV1BJTWtOazhqMUNBek9QbllYM3ZkQ3dY?=
 =?utf-8?B?RTVLdVFrQTl0M2FwelZXVHh1aHh4NDlCaklnR2RNMjdnT212dEZMUktBSUxO?=
 =?utf-8?B?ZjFPTFovRWdOYmVINXdTQ2ZOUEdOcysranZaaXpYNktPSzdLSXJFRVEzc1JC?=
 =?utf-8?B?cWtiWlREQXM1ZTdvVmZVd1VXVTZCTzRCSHFXcWxtV1d4S0ZCSVdEbi9kRnRx?=
 =?utf-8?B?S3BjQUVpNnFYNTk1Y3pjRTRZN0xuRnI2SE9MUUVLNVNYYVBZL0gxNnpRZzls?=
 =?utf-8?Q?6TwNpOYaxpubF0RQG0a2zW1ilmdb+w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WVZsdFRFNW8vYUo0b0QrY1VuZjhwdlQ0cWhIK2R4UjQzb01yc00wbEhCQTdl?=
 =?utf-8?B?NndLZUhudnEzUlhEQTVxN0pRbDdMVEhSMVA2enZyeXdYUDFyU2tHM0ZjQklV?=
 =?utf-8?B?djBYcDBYc2Z1V01FM2hqbWl5V3dSU2FUaGo1REZEWC84UzJqVHR2WTBhRHcw?=
 =?utf-8?B?MVZGZDZ3Y0tkU2g0SGpSRy9OZ0UveitjYyswd21kSTBIWWJnKzhYT2tQY3pO?=
 =?utf-8?B?eUJmZnZZM3JHUzZGZjY5b01FV0h6RXNZZnNMWk13WFRpaDJITDhTMnlsVXMz?=
 =?utf-8?B?bkxaSHlCYmpMWHdMZXdrenFMVzRTNlpBQ1FEb1YrNWlqcGxIWjVWWVk4dXFx?=
 =?utf-8?B?RDg1UlNWN1BQblFNdER2Z3hwNDc4ejBXZ3cweFI5SUQ0S1EwZFY4Tms5ajR6?=
 =?utf-8?B?clBmd04yWmRHK0VLQkFXa1Z6U0RSK3hKN1h0K21aM0QvenJFSXU5K2liTGl5?=
 =?utf-8?B?SjJVdXdEb3J4aFdJSCtHamFqVDVuUGV0TjRPZGlzdmNLeUNyYUl0b1lWNFFt?=
 =?utf-8?B?UXRUc05XK280WDRnRlBXREFXLzhXQjhTRFBHTUEvaDRsTUxLZ0t6QXBPT0ZF?=
 =?utf-8?B?V0pRVlhOVEIyTTBLenlNN2hTSHZjbG1OY0ltRGhLY2RFdU9uM0JlOHhxZFpo?=
 =?utf-8?B?L2dIYXNzcCtscjZOc2VMeGRnU1VCNXY4SWZhMi9abVlHNk1nQ21LTVhNQnIr?=
 =?utf-8?B?N0YwcFN0cjZmNkZJNGJIMkJTR3NSSjJaSXIyVzlZK2wyQ2xHMlEwRndjS3Uw?=
 =?utf-8?B?a1N2R0crbUFKTVYwTDR4NWxCVkNnVEgwTEphUnBSaEx6bjNKUVpYZVAwZjk3?=
 =?utf-8?B?K0pENCswSnJhaERCdTUrbmRQYTVXMFk3VmpxanlnODFSZjF2akxtdHBFNnJH?=
 =?utf-8?B?NFV3UEJVSGJnVzZLN01GVjNwK1kydkUwRmw2WVNKQmdEbGlhUWx2by9iVlUr?=
 =?utf-8?B?S0RIUlg3OVZXVEo2TUQ2Tlh4WWZxN0F1dHQ2S3lPaE1pckppZEcvZmZNM2Nh?=
 =?utf-8?B?VFJQeGZZWXF1cFlKZU9ESnIyMlc5dXN6empBejRQY3pkbnRYa08xeVhpSStm?=
 =?utf-8?B?RmRVOUkrSkk0QjdWWGpsZUZkcmovSnZzR0pibmh6SC9QR1VKUFB3V1NpOGVL?=
 =?utf-8?B?NlRjMDhwZzVUR0VvMnRKUGpCWHkrbGpYQzZBbEVBTFd1Wk1uZmZwako3OVAx?=
 =?utf-8?B?UFN5UDF2bHFzWi9ob0VFVlV4YTJXcVRvL3kydHhaaVVsT0sxc3R1R2VubHEy?=
 =?utf-8?B?eUhFb1d4WTIveXpodEU0Nmk5NlAyYWlZNitEYXMxNUFZR29wL1A4VnVnZG1l?=
 =?utf-8?B?N0drdm5sRFROdEVQakZjdzBvK0hDNFYrS2ZHd0dwVi9BdG1QT1cxeWVqbHVJ?=
 =?utf-8?B?S3RWZGlXSEFUSjhOOHY0R25XaVZZM3hWbEJ0N2h0b3Z0aTRiSlNXR3QyVmk2?=
 =?utf-8?B?NTd1VUpjQlNaUzBLWklpNUsrb0U5RUhUOFlwZ1BIVDdwUElaU3Eyb0t3cXRp?=
 =?utf-8?B?Y3N0ZUROUmVEQTI5bVdobU1RK1Z0Q2Q3aTVLSnRQTlpjVEd6TTdiTjlmR2hZ?=
 =?utf-8?B?UisrM1lvL3NzWm5jVThGN2pNOVdjMG94TXJFNzBpdm1FaHRJNlN5UlNkRlYr?=
 =?utf-8?B?VzVwb29GTTd5bGNYNlB4L0d6TjdYMWVEME1zWE9nZ0o4SFd6SXJ0YjkzVldT?=
 =?utf-8?B?NmpXNkkrVUlRTkNTS0JnN3pqNkZBNFZ3Z3FmY3dtN2lKaDdGak9HVXpoMGhF?=
 =?utf-8?B?N3VieStGQlRsc3VybXRoT1RXK2lIWERPVjF5TGlmWkVOQzIzMm1aMHg1ZW9W?=
 =?utf-8?B?R2FHNXdlTTRoUVpkOXg3MjlwQmhhQlBWRWJheHFXZXNiaDI5dmFndFNOc1Y2?=
 =?utf-8?B?eUhNWUp6Ykh1L1pYa3hXTmd4c3dSMGNSMWxGSW1sN3Q1VGVPeU1veHhIOTV0?=
 =?utf-8?B?ckltSHRiTzhZQXdldnhlMFYwRXlEc08yNlVmLy9lMDJjcWFDclRxcWdlTFpi?=
 =?utf-8?B?NXRNSnlxT0MvZGhSQVNqVmVOeHVJUnZ0VXZ3OU5XZUw1UG56cnRDUGhjZVUv?=
 =?utf-8?B?N2Mrbis1MStjNkRGQ1hsemo0a1k5ZUFIMTVmYVJTMTNOak1DRm9SUjZ2bXJ0?=
 =?utf-8?B?R25kV0RrNHNYaTNDUjI1YlpXOGVJajh3K2t4R0pFNkZxT1RGU09sdmx5WTdp?=
 =?utf-8?B?T1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d853a1f-e66b-4d7f-a46b-08dde0bfb553
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2025 14:33:34.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OeMFnc9tuBwTTB6NzPU37Jk2zsK1gcj6IfzIZ7fcESzdzVfhbU5CYE5jz0WMdQw6dsBH8MUlf+GD9ZQRLfhiJASEQsKQkVFHgDbTvioKpIbh929Wo/k2cBY15PUqukBa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB7792

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDI6MjQg
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
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjE1IG5ldC1uZXh0IDA4LzE0XSB0Y3A6IGFjY2Vj
bjogQWNjRUNOIG5lZWRzIHRvIGtub3cgZGVsaXZlcmVkIGJ5dGVzDQo+IA0KPiANCj4gQ0FVVElP
TjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVu
IGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5p
dC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIEZyaSwg
QXVnIDE1LCAyMDI1IGF0IDE6MznigK9BTSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMu
Y29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3Jn
Pg0KPiA+DQo+ID4gQWNjRUNOIGJ5dGUgY291bnRlciBlc3RpbWF0aW9uIHJlcXVpcmVzIGRlbGl2
ZXJlZCBieXRlcyB3aGljaCBjYW4gYmUgDQo+ID4gY2FsY3VsYXRlZCB3aGlsZSBwcm9jZXNzaW5n
IFNBQ0sgYmxvY2tzIGFuZCBjdW11bGF0aXZlIEFDSy4gVGhlIA0KPiA+IGRlbGl2ZXJlZCBieXRl
cyB3aWxsIGJlIHVzZWQgdG8gZXN0aW1hdGUgdGhlIGJ5dGUgY291bnRlcnMgYmV0d2VlbiANCj4g
PiBBY2NFQ04gb3B0aW9uIChvbiBBQ0tzIHcvbyB0aGUgb3B0aW9uKS4NCj4gPg0KPiA+IE5vbi1T
QUNLIGNhbGN1bGF0aW9uIGlzIHF1aXRlIGFubm95aW5nLCBpbmFjY3VyYXRlLCBhbmQgbGlrZWx5
IGJvZ3VzLg0KPiANCj4gRG9lcyBpdCBtZWFuIEFjY0VDTiBkZXBlbmRzIG9uIFNBQ0sgPw0KPiAN
Cg0KSW4gZmFjdCwgQWNjRUNOIGRvZXMgbm90IGRlcGVuZCBvbiBTQUNLIHRvIGZ1bmN0aW9uOyBo
b3dldmVyLCBpdCB3b3VsZCBiZSBtb3JlIGFjY3VyYXRlIGlmIFNBQ0sgd2VyZSB0aGVyZS4NCklu
IG9yZGVyIHRvIGF2b2lkIGNvbmZ1c2lvbiwgSSB3aWxsIHJlbW92ZSB0aGlzIG9sZCBjb21tZW50
IGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkNoaWEtWXUNCg==

