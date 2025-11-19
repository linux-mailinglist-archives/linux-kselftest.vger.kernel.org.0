Return-Path: <linux-kselftest+bounces-45962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FBC6DF7B
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A063F383877
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5041348890;
	Wed, 19 Nov 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="RkVPwHP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B632D0F5;
	Wed, 19 Nov 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763547880; cv=fail; b=SJxlpFzLRat0Vm6sci2twqKg2reRoRvx8xPrkVZ0qesvIP+Dkhc8BWPjlHY/CONI8chXftQrwMle3fJqR/YmBAaDYFMF2/n3rZYYU3qjR7TRLLgscIptTtjW+CD+t03Ii0XfWGCz70LVkYywQXyLLHCxcwr/GQvjMKl0E+gx38w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763547880; c=relaxed/simple;
	bh=OdNNseDVyFFHNLNpHFqMWoomtJ81J2+Yj4l0T4KLi8Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GDLKeczeum+muF7VnHXE4VX80ji3lc17slnSsjx5MM2kYSZ2m1rbw/cbtyXPHzdw75Ngq1r/ayiiK6DcWSEzG61aJ/2eKEGzHdGIt0Akt0/6uEdwUHQk8mP3LHS5q7BN34VFRjjiWhlYl0V3od5TKGo52PIA6J5U8lzy+oabFxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=RkVPwHP8; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KH5VjOZBQAoJC3IiTm6QxJnSC5+pRLXTxiQ82OkwfN6HYtzMdayENaAKuxELs8syY0L4lgsrMA8O0i6TzbIYHl899X9Pu2y1Vo33KU8EgIVa33aFUHL13PYUDKEjsTaL7s9rqTgxQshHt6xnwiVnFiBJQW/NucxRhWtjc8/Row1azlT2crPOWoIjRL4jIQsFTEA1ijEV1AUsImShYjTMIcgJ1Xr3fbn5iE7ngpCLGGdL8iRcVRJz7EaGFxbMUi3zIV2a/IVqjQWlqs8ZxgMXbec5eyCNcBoAtlcEIexrGtf4G73NHbKIRPuIV0txXmKsN0Dg86g4/OWE2EeIUNnsDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdNNseDVyFFHNLNpHFqMWoomtJ81J2+Yj4l0T4KLi8Q=;
 b=nIO8rrvwlWQj4neZ0uEXre1sSTnw2amLmPwOrUlGaZSK/9wZWJqeSH+5KjrZuhUnL3nbbtct31XGR0YplPPO6nmbW4aipwBvaYOFDFBpBMkKJ0OfbihIGfGXtC76jO5M5mHAJtztmFskmn60UBlXLnr8Wl2zjVNhjvUsjMaVfb6FMEUaPEBQv8wTahOTjrQ+MJfS39+tclbT36Ylfn2iDY/BUJExbhzbBzCxKNWU+1LXKpJ5CPdMB8V2EUfJEaQD847GUrFDZrz/Q7EVCaLrDp0/1yH+OEIQ8FBuaRzfGNoaWxPO7fAsioP/9vagvzPOCYeTXG5Vzy9Fyhd6HF3Haw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OdNNseDVyFFHNLNpHFqMWoomtJ81J2+Yj4l0T4KLi8Q=;
 b=RkVPwHP8RieMAlfpX7rEAq8hZFyAFIJksdUwOeSM5gryqs5EamQBIIF/EmRmh508h4BntZ7hnL0/RwGUo5U8ZhOEUYFhOKxWnlvLp7K9z5/nfmW2FLmGigHNF4wkY54tA+t+rfI7PfsEKWYSCuSCy5ruk9hyqyuDf52QKVRo5oCGjM1CxmnHvQFAKzWEVGbjxuuQPfD04LIP68kGlbRQbvRXgzMqTU/odwvPlcAiQflT6z3SIE8uBZObv+LxjVnb2/xqeummVKQEGhuUNRv9Y6zBu73llWmMO5OWcDBRGP0uWIC6HJlpDLZW2a/0XJ8CFZNTDWrBQxdHIlbIn3E+sw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB7945.eurprd07.prod.outlook.com (2603:10a6:10:2a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:24:34 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:24:33 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
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
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Topic: [PATCH v6 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Index: AQHcVTY/Vojp0P94/0mOC8z6JaaJb7T4W/UAgAFx7lA=
Date: Wed, 19 Nov 2025 10:24:33 +0000
Message-ID:
 <PAXPR07MB79842DF3D2028BB3366F0AF6A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-4-chia-yu.chang@nokia-bell-labs.com>
 <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
In-Reply-To: <d87782d4-567d-4753-8435-fd52cd5b88da@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB7945:EE_
x-ms-office365-filtering-correlation-id: b34db03e-51c7-472f-5933-08de2755d56c
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NUQxQ21QV3hnbXp0SFozS0QyWkpmNmFLcS9WK0w2NnpDVDFJczl0U2xIMFpk?=
 =?utf-8?B?U1M4WXlyZTIvb2wxcWtRaXNrb2UweFJScUo2L0Fsdi9MN2YzcE9MMWxmaUlt?=
 =?utf-8?B?c0Z5WXBKdnFQcjdLZkZOUTBFTTg3UVZJbVhoVkpoNlpGcDlvUEZxUGxMN1Ra?=
 =?utf-8?B?L2lWOUxnNGlGL0ZERThXRzRXelJNUWFiSStFd1NJZEhTbkNxR1BvZytsVlp2?=
 =?utf-8?B?QjVRcStBajhUTVVVM05ka1crbmRBMndxc3g2ZE5FeFZoR08xc1p0MlRUQ1FO?=
 =?utf-8?B?UVFqdEZtbHN5K1BHK1F0N0NDQlM0SSs1a3oyU09pTmNBWjB0bEloYituQnRp?=
 =?utf-8?B?Vm9leHhlS01sV1crYUs3K2hYVDlNa2FXOERtSU1rWnJXS0Z2aXJNRmRDN21y?=
 =?utf-8?B?RlZ6UGJvaDF0d21xNWxOMzUyWi95RU1aVUZ1b2orVFJqVFZ3RlFPeDdSUnlL?=
 =?utf-8?B?aUljWE1EeHV1UDltYUpFYldiRFNsS1JGaVJXb0lnRjgvMCtYSmJNaWlVbmRs?=
 =?utf-8?B?M2VDUEVNblArY1ZsLzdCV0JNU1N3UXpyaWNnYkJieWFBc0I2SGZDWUpNMTRi?=
 =?utf-8?B?TnNoR0Z6R3huYUNnQUlaK2RWY2tIVkhHcGkzOXJ4QlhzL3Q4SXIyNkJEYzBN?=
 =?utf-8?B?WFdqTjFMbnBESjJmQkxqOXJ5NDBBNFZSQ1Z5OW4rN1I3R0c4Y3BBUzYrMW5J?=
 =?utf-8?B?VXQyelhwdms5MzJidmhGTFVUYURTa2FvbU9Sb3VPV3JjK1ErTG5WTjBra0c3?=
 =?utf-8?B?cXJhbWlaR3h2eXR2SUZWdUluUEI4bmJNclFySm5LUEd4N2tzVkFqZGpscml3?=
 =?utf-8?B?WWFmUGNPM3N1TE5yb0dVZm90ZzZrZUNMVENNM2o2YkQ1RmYwR05zRlpDN0pr?=
 =?utf-8?B?SWt5aGhDUms0czVsOExjYTJSUUx1Q2psYUwxZkRmV214ejJBYTNIWlJDNkV5?=
 =?utf-8?B?cDNoM0NPN2xMakxlN0t4bkNpK1pLWnNtTzkyR1J0MGlEaEVvaGVmY1lRQk8x?=
 =?utf-8?B?MC9Ra05waHJjMnJvMi9VREhBcmFKRU5MNkt4aTlUZTlQeFZUczlGZnUwVy9T?=
 =?utf-8?B?WlVwQ0x0Tks1WDNkM2FyR1k5ZDZwS0ZlR05XTUlOTzc4RE5nMm5KRmU3Rlo1?=
 =?utf-8?B?Q3hDVWFEaTBJMyt5RURiYXQ3WHNPREUxYmVRVm8yVlV1Wlk4MGpjbk9lT1lL?=
 =?utf-8?B?QytVaTNhclIzOEd1L2tqenN1blNNdEtWbTdNbTBSckt0cGZ0RXpJa25sQWJs?=
 =?utf-8?B?V21zVy84dzFGUVV2ZVZCbk5kVmNHRWJTWDAzM3MxY2JzMWhhRmtBaWtWWCsw?=
 =?utf-8?B?LytTcGt4Z1BRV09TQWxFVnhSeUVUUE9MbXVLa3Q4YmFWUnI2TnFReGpKRnY2?=
 =?utf-8?B?WTVtMDZrSkR1OUxXY1lUS1dBZlg5VFc4RUVFeVhDMnlnL3Bad3ZrQjVwNGxn?=
 =?utf-8?B?eWVwR0FnVFlUUytnamsrMXlHUDVBdTdoT0htN0YySElxQTQzNnJOSEV1MWph?=
 =?utf-8?B?Wm9SdHdvUUl2T21FL1pFRS9rNTVKbXBVdHdGeXFlTDNJY2FXVXkrZjNKSHJV?=
 =?utf-8?B?OHY2OHV1R1poTHpQT2RaSVN1M1pnNzlucGQ4THFSYWtWaFlzalJTYWFtbllX?=
 =?utf-8?B?QUROblY0TGVOYmFnSmJOK0FycjZ0cGJ6WjBrNXNvdUx3YXN3T0hlcWREYmVy?=
 =?utf-8?B?NlpxZjJ4aDZpTS9CNFhISWVGS2NaSWJBdmZoYzM3bWZodXZ5SE5UcEJiWmQ3?=
 =?utf-8?B?SWw5RTVrL2xsK0pHQTM5SyttcmdPMWo2UVlKeFRLc0tWRXhXOFBHaEdEaFVB?=
 =?utf-8?B?RGZEMW85Zllld3lhVnBuSlBGYmtxUTNRNit0SUxaWWJDQ0JpV2ZEUStOR1J3?=
 =?utf-8?B?VlVBWGhTWk12TVBrblRBbm95a2tsTjY2UFFoTXlidm9SSzZEbnVNWFg0c3hR?=
 =?utf-8?B?T2tFY3lCMTAvRUdnUCtFYkh5K2h3MHFlaEVuejBtanF4Nm9Gcm1tUi9oS1pW?=
 =?utf-8?B?UU5mZTZRbXF6VDNxcmdxdHZ2eGxtYko4RnR1d3dMcEpxRnNmd2VQSHV2ampK?=
 =?utf-8?B?aDRhNmdGdlZNbXU1VGl4eS9ibmR5SHdmb21GQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NUxFWm4wR2dvdjVDM2p2aHBPd0lxc1JVK3BaMThNaDZSVkl2Y0hnK0Vha2pB?=
 =?utf-8?B?MFdFaEZ2M1JwNXNBRnNKbmE3T0RQVnlxQXhPU2VWcVhKQzlZSlFxOWF1ZGJh?=
 =?utf-8?B?Zjgra3ZyTjd3OEdva1FVYnVtaHBWODZqdk5xcjJYZmJKc2pnVWk1RWhha1Fj?=
 =?utf-8?B?RzBxRm80VG5TTER1NDN0emF3c0lVZ041OFdmM0ZrWlVBN1dkL0tFZE5uTVdF?=
 =?utf-8?B?S0hhTjJBQXlWd1JEK1ZlTktIQ1c4REJDRnVIVGVjOERPb1V5VURENWs1c2c0?=
 =?utf-8?B?VnlFc2N4eDRMbDNMRDVRS3FXcmYvR2k5RnpyQWhPQnVOeDIrRHR1ckFLeUNC?=
 =?utf-8?B?VWZvbkZObldvY3lnQnVKc29aSVI4TU5hVnlDSlhrWm9mMG1kRG5sUVMyNmlH?=
 =?utf-8?B?UXRGdTR1UjkydEtMMzVzdDVtZ1lWTUVnVWVIMjkrV3l4cktaTFVpMEMvMDFl?=
 =?utf-8?B?cXUxZjBRWVJ2STdrR1NNeWJmNEpEL1o1ai92Q3gzS0xVZG0zVUZkVWlVam56?=
 =?utf-8?B?WFZ0ZUhkcHBSM2pnNGdKa01VYkZWUkp5QmNBSXRkY2hpWjY3SlpPSWZuWXQ3?=
 =?utf-8?B?djdBMDZPcmJzN0ExaVZoOTJsWU9XN0kvVjdqdDM0TDhIU3k2eUhhTUdGcDFI?=
 =?utf-8?B?MmZtUEQwVGNqQVNyd0FRcnZCMmF4WEc3K1Y0eUZ4a1JHclF2YkdXb1Vsb0E3?=
 =?utf-8?B?OHZqcXdMN1B3enc1NW5ycDdLdU9pZ2Ewd0FsV2RWSytJMGhEbUNUWWJ2Z1Fq?=
 =?utf-8?B?OVpvdFhWZVRJOVcvSlJ3R2owOXpkRzM5MmV2M3FoK0I4alZMbGJscWNuSmtN?=
 =?utf-8?B?SEJqM3hGOVd6UlVVWVIvcUNGS2N5Vnk1SG5WWTd6ZklxNDRUYU5aSzF5YU15?=
 =?utf-8?B?NXg2OXBSYWE2VFYyR0xkdzdyanlyVUE0QkJ0VVhYZTlYZjNSNUczYjBvcWEr?=
 =?utf-8?B?YmorckNTNm5CRnJvS010ZFRCRWVuZ0kydDFUR0wydGtwZkwxMmowek1jc2Rq?=
 =?utf-8?B?SHZjNGhERlBWcm05eHZtR1hoRHhscHgxV0twOTRXMDIxaUxtNjJUSXRJN0dt?=
 =?utf-8?B?d0pHMkJNVXIwREM5cE5Fa1I4N3hTTnh6RTBFNW9XL1hQTXpESWN2c0dCaHE5?=
 =?utf-8?B?WHIrbEdVZEwyV1d6L0FhakRVNHAyL3h1OFR1V2tLSmM3ZG5VcEJqVGJRdGFC?=
 =?utf-8?B?NGJNcG1TOG5hWkZSRi9Vd1Rkc0JhOWt3T2VQT09WOFVJYTdKbXVteDVEaXY0?=
 =?utf-8?B?ditqQ0RkaU13SUtuc1VtS2VHQXJpMVJCVTAvalBMb1VVSk0zWGkxTlpLZ1F2?=
 =?utf-8?B?aldXK3hUc1dQQUtOQmVybzdET3BLMkxKeHRFSGxnS2RROGtxQno1MmJDWmk3?=
 =?utf-8?B?QktDcDBmV0RaUE9FenpiQmpWd0lqdnYvOHF4c0xDUW9sRW9Mc0x5U21DZmUx?=
 =?utf-8?B?VEdCL0FXS2tMWkNLeDB1UHY4MXVHa3UxWEtPUzlWdGwrVDRHOXgyTXJvd2NF?=
 =?utf-8?B?d3U4c2dpME51T1o0R2FuVnllVjlJbkIxdE1TaUFMQ3RzY28yWm80cXdncXZG?=
 =?utf-8?B?YWFqR2RjZm40enlQU0M3ME81WThxTEY5eVNWdmNqaWx3d0tFdlhabExxejBH?=
 =?utf-8?B?ekJpTnl3YnFtVDJLcDRpd1FqTmU1QUVoUTVMZzdzRG5LNXduanlkVStMZkp6?=
 =?utf-8?B?dWRFc3JsYVowcnFlTFpYQ3l5VXN1REpkQi8xYzlhMFNrRUhnSWg1TUlyV2Z3?=
 =?utf-8?B?Z2xKb2RsQkhsL2JJcUZrdTZoL0R3cnZrNGtmdkFqeStHVUV3OGtjVlgvSDBY?=
 =?utf-8?B?Y0R6MVovZTc3elY4REQveHZUM2tlSkRyTndHZkNmSFZFYmY0MUp6ekhZOVp2?=
 =?utf-8?B?L2dHTjNhVEhWWGxMdWh6aWthL2FzekxXM2lCbHE0VU14cy83ellJTkZtc2M5?=
 =?utf-8?B?bzBKck1YcmFwaDJsQU83SlZqSUhBNTZidjFRakh5TFlnc1VCY0pkbWwwaVlw?=
 =?utf-8?B?UDh0U2paY2VJck9aUUhKRTYzdWlCSEQwUGduYUNJZ3VoVFRvQ1RhLzdtZDh3?=
 =?utf-8?B?WlcxOThERjFMUW13c1JzU2krQ0FOWXNtUEpuTThxOE9KQjlDMFBCMGt1MHJl?=
 =?utf-8?B?d1F0U3hnQXpMRGpQazY5dGw1YWJ3V1RnUjR4WXRBRi9RN1Jnd3JVMnJWK0FE?=
 =?utf-8?B?ZWc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b34db03e-51c7-472f-5933-08de2755d56c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:24:33.9285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d/E8qPR2vorJiFJCLfn13e4Eh1kAkTAQZumQvDfeBnyBIZbVFgmys2+vCWUnx8KDRVauqCXWGZR/TMSgslIvJBKphA9GQa0WBGmUgUPSlOjiW6TcfX/eLevHhfT5KP4I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7945

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOCwgMjAyNSAxOjAyIFBN
DQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT47IGVkdW1hemV0QGdvb2dsZS5jb207IHBhcmF2QG52aWRpYS5jb207IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2Fo
ZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29nbGUuY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53
YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJl
cmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtz
ZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUu
Y29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVs
bC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBl
cmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hl
c2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0
LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjYgbmV0LW5leHQgMDMvMTRdIG5ldDogdXBkYXRlIGNvbW1uZXRzIGZvciBTS0JfR1NP
X1RDUF9FQ04gYW5kIFNLQl9HU09fVENQX0FDQ0VDTg0KPiANCj4gDQo+IENBVVRJT046IFRoaXMg
aXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2lu
ZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZv
ciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBOb3RlOiB0eXBvIGluIHRo
ZSBzdWJqDQo+IA0KPiBPbiAxMS8xNC8yNSA4OjEzIEFNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20gd3JvdGU6DQo+ID4gRnJvbTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFu
Z0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+DQo+ID4gTm8gZnVuY3Rpb25hbCBjaGFuZ2VzLg0K
PiANCj4gU29tZSByZWFsIGNvbW1pdCBtZXNzYWdlIGlzIG5lZWRlZC4NCj4gDQo+ID4NCj4gPiBD
by1kZXZlbG9wZWQtYnk6IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4g
Pg0KPiA+IC0tLQ0KPiA+IHY2Og0KPiA+IC0gVXBkYXRlIGNvbW1lbnRzLg0KPiA+IC0tLQ0KPiA+
ICBpbmNsdWRlL2xpbnV4L3NrYnVmZi5oIHwgMTQgKysrKysrKysrKysrKy0NCj4gPiAgMSBmaWxl
IGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaCBp
bmRleCANCj4gPiBmZjkwMjgxZGRmOTAuLmUwOTQ1NWNlZThlMyAxMDA2NDQNCj4gPiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC9za2J1ZmYuaA0K
PiA+IEBAIC02NzEsNyArNjcxLDEzIEBAIGVudW0gew0KPiA+ICAgICAgIC8qIFRoaXMgaW5kaWNh
dGVzIHRoZSBza2IgaXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLiAqLw0KPiA+ICAgICAgIFNL
Ql9HU09fRE9ER1kgPSAxIDw8IDEsDQo+ID4NCj4gPiAtICAgICAvKiBUaGlzIGluZGljYXRlcyB0
aGUgdGNwIHNlZ21lbnQgaGFzIENXUiBzZXQuICovDQo+ID4gKyAgICAgLyogRm9yIFR4LCB0aGlz
IGluZGljYXRlcyB0aGUgZmlyc3QgVENQIHNlZ21lbnQgaGFzIENXUiBzZXQsIGFuZCBhbnkNCj4g
PiArICAgICAgKiBzdWJzZXF1ZW50IHNlZ21lbnQgaW4gdGhlIHNhbWUgc2tiIGhhcyBDV1IgY2xl
YXJlZC4gVGhpcyBpcyBub3QNCj4gPiArICAgICAgKiB1c2VkIG9uIFJ4IGV4Y2VwdCBmb3Igdmly
dGlvX25ldC4gSG93ZXZlciwgYmVjYXVzZSB0aGUgY29ubmVjdGlvbg0KPiA+ICsgICAgICAqIHRv
IHdoaWNoIHRoZSBzZWdtZW50IGJlbG9uZ3MgaXMgbm90IHRyYWNrZWQgdG8gdXNlIFJGQzMxNjgg
b3INCj4gPiArICAgICAgKiBBY2N1cmF0ZSBFQ04sIGFuZCB1c2luZyBSRkMzMTY4IEVDTiBvZmZs
b2FkIG1heSBjb3JydXB0IEFjY0VDTg0KPiA+ICsgICAgICAqIHNpZ25hbCBvZiBBY2NFQ04gc2Vn
bWVudHMuIFRoZXJlZm9yZSwgdGhpcyBjYW5ub3QgYmUgdXNlZCBvbiBSeC4NCj4gDQo+IFN0YXRp
bmcgYm90aCB0aGF0IGlzIHVzZWQgYnkgdmlydGlvX25ldCBhbmQgY2FuIG5vdCBiZSB1c2VkIGlu
IHRoZSBSWCBwYXRoIGlzIGEgYml0IGNvbmZ1c2luZy4gUmFuZG9tIENvbnRyaWJ1dG9yIG1heSBi
ZSB0ZW1wdGVkIGZyb20gcmVtb3ZpbmcgRUNOIHN1cHBvcnQgZnJvbSB2aXJ0aW9fbmV0DQo+IA0K
PiBQbGVhc2Ugc3RhdGUgZXhwbGljaXRseToNCj4gLSB3aHkgaXQgbWFrZXMgc2Vuc2UgdG8gdXNl
IHRoaXMgaW4gdmlydGlvX25ldA0KPiAtIHRoaXMgbXVzdCBub3QgYmUgdXNlZCBpbiB0aGUgUlgg
cGF0aCBfb3V0c2lkZV8gdGhlIHZpcnRpbyBuZXQgZHJpdmVyDQo+IA0KPiBzb21ldGhpbmcgYWxp
a2U6DQo+IA0KPiAvKiBGb3IgVHgsIHRoaXMgaW5kaWNhdGVzIHRoZSBmaXJzdCBUQ1Agc2VnbWVu
dCBoYXMgQ1dSIHNldCwgYW5kIGFueQ0KPiAgKiBzdWJzZXF1ZW50IHNlZ21lbnQgaW4gdGhlIHNh
bWUgc2tiIGhhcyBDV1IgY2xlYXJlZC4gSG93ZXZlciwgYmVjYXVzZQ0KPiAgKiB0aGUgY29ubmVj
dGlvbiB0byB3aGljaCB0aGUgc2VnbWVudCBiZWxvbmdzIGlzIG5vdCB0cmFja2VkIHRvIHVzZQ0K
PiAgKiBSRkMzMTY4IG9yIEFjY3VyYXRlIEVDTiwgYW5kIHVzaW5nIFJGQzMxNjggRUNOIG9mZmxv
YWQgbWF5IGNvcnJ1cHQNCj4gICogQWNjRUNOIHNpZ25hbCBvZiBBY2NFQ04gc2VnbWVudHMuIFRo
ZXJlZm9yZSwgdGhpcyBjYW5ub3QgYmUgdXNlZCBvbg0KPiAgKiBSeCBvdXRzaWRlIHRoZSB2aXJ0
aW9fbmV0IGRyaXZlci4gU3VjaCBleGNlcHRpb24gZXhpc3QgZHVlIHRvDQo+ICAqIDxyZWFzb24+
DQo+ICAqLw0KPiANCj4gL1ANCkhpIFBhb2xvIGFuZCBJbHBvLA0KDQpJIHdhcyB0aGlua2luZyB0
byB0b3RhbGx5IHJlbW92ZSBFQ04gZnJvbSBSeCBwYXRoLCBhbmQgYWRkIHRoZSBjb21tZW50cyBv
bmx5IGluIEFjY0VDTiwgbGlrZSBiZWxvdzoNCkJlY2F1c2Ugd2UgY291bGQgdXNlIFNLQl9HU09f
VENQX0FDQ0VDTiBpbiBSeCB0byBleHBsaWNpdGx5IHRlbGwgbGF0dGVyIEdTTyBUeCBpbiBhIGZv
cndhcmRpbmcgY2FzZSB0aGF0IGRvIE5PVCBjbGVhbiBDV1IgZmxhZy4NCldoYXQgZG8geW91IHRo
aW5rPw0KDQoNCi8qIEZvciBUeCwgdGhpcyBpbmRpY2F0ZXMgdGhlIGZpcnN0IFRDUCBzZWdtZW50
IGhhcyBDV1Igc2V0LCBhbmQgYW55DQogKiBzdWJzZXF1ZW50IHNlZ21lbnQgaW4gdGhlIHNhbWUg
c2tiIGhhcyBDV1IgY2xlYXJlZC4gSG93ZXZlciwgYmVjYXVzZQ0KICogdGhlIGNvbm5lY3Rpb24g
dG8gd2hpY2ggdGhlIHNlZ21lbnQgYmVsb25ncyBpcyBub3QgdHJhY2tlZCB0byB1c2UNCiAqIFJG
QzMxNjggb3IgQWNjdXJhdGUgRUNOLCBhbmQgdXNpbmcgUkZDMzE2OCBFQ04gb2ZmbG9hZCBtYXkg
Y29ycnVwdA0KICogQUNFIHNpZ25hbCBvZiBBY2NFQ04gc2VnbWVudHMuIFRoZXJlZm9yZSwgdGhp
cyBjYW5ub3QgYmUgdXNlZCBvbiBSeC4NCiAqLw0KU0tCX0dTT19UQ1BfRUNOID0gMSA8PCAyLA0K
Wy4uLl0NCi8qIEZvciBUWCwgdGhpcyBpbmRpY2F0ZXMgdGhlIFRDUCBzZWdtZW50IHVzZXMgdGhl
IENXUiBmbGFnIGFzIHBhcnQgb2YNCiogQUNFIHNpZ25hbCwgYW5kIHRoZSBDV1IgZmxhZyBpcyBu
b3QgbW9kaWZpZWQgaW4gdGhlIHNrYi4gRm9yIFJYLCBhbnkNCiogQ1dSIGZsYWdnZWQgc2VnbWVu
dCBtdXN0IHVzZSBTS0JfR1NPX1RDUF9BQ0NFQ04gdG8gZW5zdXJlIENXUiBmbGFnDQoqIGlzIG5v
dCBjbGVhcmVkIGJ5IGFueSBSRkMzMTY4IEVDTiBvZmZsb2FkLCBhbmQgdGh1cyBrZWVwaW5nIEFD
RQ0KKiBzaWduYWwgb2YgQWNjRUNOIHNlZ21lbnRzLiBUaGlzIGlzIHBhcnRpY3VsYXJseSB1c2Vk
IGZvciBSeCBvZg0KKiB2aXJ0aW9fbmV0IGRyaXZlciBpbiBvcmRlciB0byB0ZWxsIGxhdHRlciBH
U08gVHggaW4gYSBmb3J3YXJkaW5nDQoqIHNjZW5hcmlvIHRoYXQgaXQgaXMgTk9UIG9rIHRvIGNs
ZWFuIENXUiBmbGFnIGZyb20gdGhlIDJuZCBzZWdtZW50Lg0KICovDQpTS0JfR1NPX1RDUF9BQ0NF
Q04gPSAxIDw8IDE5LA0KDQpDaGlhLVl1DQo=

