Return-Path: <linux-kselftest+bounces-42963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE65BCDA18
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 16:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4853A282A
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Oct 2025 14:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2732F7465;
	Fri, 10 Oct 2025 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PQUbFGYn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E62F746C;
	Fri, 10 Oct 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108117; cv=fail; b=eqXAnlgEg0Txm2jBGPRV5zOD5IzxJ7LhSQ1s5zcDJQ9GyAJb8KehjYZdojB/8yhZSePfZe9xJsG6V0Zl6+h/t5i3IsEXFYfCkgMuhugwm0zKOTbp0Kmcvz99Hb2Y3McT3iUC5q1xL2/hBwTizdU2+5HnzsWnq+kTijm2PoITGgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108117; c=relaxed/simple;
	bh=WZSohty9q3H46iyCNo45thZXCzVcBLu7nFAaq6PSZlM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=c/Te4xyKyzuqAVoSIykyjJIhDc4j3XwUwTS9FC174MpXh0UnVggUvG0a/RfRLq0LohZVV0aPUM6SyR0SIbZIUpmT/S77AKCAeTIn4b/jdImw9GxLbe6m/GLHdIkH92ApZG909zhlpPsGPrxwLCCVhjh52Xrhfx6ULzDenr+M4Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PQUbFGYn; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BmarbYJFQ0Hc4ocS/R0oe2GTvSxM+WdXljXHRwrmGOVAU3m97/xTcS47FscepGEn2/rBCeSUApekzQDeMECI/T70cCvg8jN4gu37uY6Nl2JhvailgYPu4HMvxLFquEkH/0ZLkwwktGRn0KWbN9cKj3x19Tz56H1IMJ4gKXgharLphrFqOWKhy3b6oh8zP/EMxCrLN1yq9sz3dxcy47oOfuPovGihspMlD6d7/XlQkwc5sAbVh9mlpsF3VDjmZ84bAFbUk0C0zd2HGmalKkdSX/CuH5IqCTS2q6xSv5u2e8puPilMbo+CSwuhWsAgMycdML3LY0cnhFgUTv65/pdMng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZSohty9q3H46iyCNo45thZXCzVcBLu7nFAaq6PSZlM=;
 b=i6HO5q8HpPk0sreEXFP3b/FzIaAzn34wMSqnoaPRhs+CYcX2n/SCH7XpPCG08c/9j1/iA9/K7mnHIBaExm2SbJqyGbbemLGp/YcB85FIjG19LGxq6wCXowiL+7BwFvVSYLWNcWbeYNl3BKF7Eqw0m6UKA4de+1m6ooqqljIelkrMqiK3W1T7WXjIhQCeo/RYM1S8qVVH0kiFUPFHS3qzINFqkNaZLSOgAnTz41wA6fk+aQPFofHbNQw6lr5AlIyxuwZRHAUrg0BhDWcOFqG6xx6MH8645Ty7WJ6tux8AnP5+S1ljReYSTZittLK58uy+pKzyELLbZLrZhk8gvq4Fag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZSohty9q3H46iyCNo45thZXCzVcBLu7nFAaq6PSZlM=;
 b=PQUbFGYniUVbhL8jQGnxLbIwA9ex40J2J8CcNehI5Mky4KaMMN92+ogAQqpJEHLJXUWy6Ap3qDMrdIeg6jHNn8WaEWSBu/YEerGot+w+FIF84yOmwZWOL6AhmE/gNGQ+3FztRn8B54AixCcm1jdLtcFuyfwKHwVo73Vd2MlQkJY49wwzQc2hezNP+quzO+N+2mG1LTFfVyPok+4mY7lHk40pmJvUpztWn23k9PXJrVzZOwLfBEf8kHb/5+Cpgrk4hK/8gRM5W3XWVfsR6C35LFOlMVGbVgG0UvNbiOLQFjeoMcJSO41hlIl0EK+KfxbTyDFPDBuS9UlK1xh8fAFxUQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA3PR07MB10625.eurprd07.prod.outlook.com (2603:10a6:102:4ac::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 10 Oct
 2025 14:55:11 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9203.009; Fri, 10 Oct 2025
 14:55:11 +0000
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
Subject: RE: [PATCH v4 net-next 00/13] AccECN protocol case handling series
Thread-Topic: [PATCH v4 net-next 00/13] AccECN protocol case handling series
Thread-Index: AQHcOeg8Mb6b4t46M0qYgAgRF+DklrS7d38AgAAARwA=
Date: Fri, 10 Oct 2025 14:55:11 +0000
Message-ID:
 <PAXPR07MB79849FC1F67FD3F380A290B7A3EFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251010131727.55196-1-chia-yu.chang@nokia-bell-labs.com>
 <0ec01c17-1c39-4207-96f8-597bc8d6c394@redhat.com>
In-Reply-To: <0ec01c17-1c39-4207-96f8-597bc8d6c394@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA3PR07MB10625:EE_
x-ms-office365-filtering-correlation-id: 6a484eb5-f1d5-42e8-ab4b-08de080d0308
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HWwEWtyCQx4ZzAAcMaAXYXI+fedh5SfBlYnb7W59DiNBfputpxEHSVhK5RW+?=
 =?us-ascii?Q?gC5De2kObCcCvACYtEU0SDRLt49Twq6IrYyI7R9ehoCzV66xQF/G3G5pUXQH?=
 =?us-ascii?Q?tYMO6d7g9AVIR8dmAs7EUgw06a73kQMKs3yCYLAsS8of7U2hxlJ21aVhzmua?=
 =?us-ascii?Q?r0BFLhN45qZn7eqQJWudrxoN6iP/T2PUukf6sytuK7Rl2ijU1V3cpt/JeTXY?=
 =?us-ascii?Q?Rxkuf52JO7DEtf0A9WDjeQ6wrZaoJhJuCrrFrDK/52JcY+25NF2yBNfbtWCP?=
 =?us-ascii?Q?eTUWbp1R1Q35p1jzPIAaAS65mKFjdi5gQnKEnsvSgTAfxuJuEy5hUGoOcozY?=
 =?us-ascii?Q?dYWMyOf4gZnFOyXyJ4ge2TFbP/7KQL4u6wkFJ9GOi3BNERWX27eAqKL4vkhb?=
 =?us-ascii?Q?6ITecOf2bHjtgilKQ+bBKsJQZCont7PnL9R4KomVF3HiLB19sGCwdIAmWMCx?=
 =?us-ascii?Q?hKKKm0U7YYH4ETzZYo9t+bLvhQj/v4Yg25Ebd000bjbjscg1ydYWaRAkyEGw?=
 =?us-ascii?Q?WvWTULlGUtxnBOeOZpCpRgiaPWTWRb67W3+1fa4xmGJUzbIeNDzycyRDfM/x?=
 =?us-ascii?Q?xred/gxPmuXNxxBDxerqXiX2rCnkobPvx6/RX56/2uWNw30KIH6FadwMLq/Q?=
 =?us-ascii?Q?hbPgJ80z+OxxsW8hTf1hc1Ek3c21UfZeEgza94hO4zxawklFXSxAV0cRbm42?=
 =?us-ascii?Q?oOenyZu2MBtKmIp+4Q/tsITlup9jZLf8ndV1UIb71pJw23hTiVrfyXeEMVWC?=
 =?us-ascii?Q?VZhoUuVDv+1cmfSk8bU2rQBT2OdSDaqRgGUiGbKnxlz5DbMBxFfEWRIfAUKm?=
 =?us-ascii?Q?3G/nL2ShgCVhU33PVIDr4SVSe1wNpS22TsEVwmhnL4JBO2X6Xm+RKEk+APOu?=
 =?us-ascii?Q?U/nWJUsUXD8hYuckGi0xfurDW6HPpQ4Dhm5w0tJVfSEGJCJz3XVZR/Z1jUKm?=
 =?us-ascii?Q?9tv/8e0ip5MA4wgSwSp1zGakPa45Bz4pQp0QScLvLWPsRjIR2NaV87q9ZY1i?=
 =?us-ascii?Q?Ya51bhzeJR3ka0/a9fyB9Ps5UKz8+otFb2Z2KMdPZYsbN8VFtFpZJqfOXMc4?=
 =?us-ascii?Q?aD3TqR+gsR7PF8/wvSGsuQAhQ4lMLEMBkrD2v03iREs1xuGJTREryP389ba0?=
 =?us-ascii?Q?r39bjNG4A2HntDwsl5HA5NnbsMUPGCwgm3ZACO1Uiiy+USpnRDDZdLNXY9zI?=
 =?us-ascii?Q?3UYhsyimKeMvKPFTTmgsz5P7mjEO5/JU3SmqRoCh295JvxheW9/DMRhXnY7o?=
 =?us-ascii?Q?IUZoso7m/D+qk7u8fi3zq1UWZIR2JUzMli+xwhL8DqFMyEWwtLMaAe4RdrvA?=
 =?us-ascii?Q?9FEsL6RBzV/iqJmHERX22BEI21eBPI0rU6AR6yz6NwkO7/p7ps/dp4S2ygJ2?=
 =?us-ascii?Q?wCF9SYW8l/R0ldlAGYaV04Tptkvt2QoWKLgjrYYcuYEVaPFghtj/Gvu5zkwb?=
 =?us-ascii?Q?PnnqYgm7AWwb60X/Rb1FHnRANX3XDtegc5Fw+qGfH9EIY9t4g7HDx0RQbvJi?=
 =?us-ascii?Q?RHxaVvkLuL0W8vhnQU5ZKNM/vvSyNGWJ6W3F9GX7/z4XHMF5YdMbmPZycg?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qt4ggxC9C8bjnhkzgz0ReHzyJCiwWPUlZm2r9ZL0SVHAp9VeF/Zcq3qBE7Sj?=
 =?us-ascii?Q?X1YE0tcdQP8faMJsunrY8KC+7QwU2hCkjlnQhngqWfbNAuqjAE39+RkEv6lS?=
 =?us-ascii?Q?Jtr5Hrkcgs20TbtqqwSi1qWY4SY/NX0fGRrrMgZ6BZ8ITa6louYEWKxpMMAg?=
 =?us-ascii?Q?2XQjy/5vOsBzrSCMqDj5I7rIfaJCe0354qbQ9FUIIjOjr9McRkH1321kXO63?=
 =?us-ascii?Q?1xCp7A7l+QG6XNjIuDZ3YP2Fev7Z91gutGHLMCi5dYVZ+pWGGYJgyssSaeWU?=
 =?us-ascii?Q?r70O6GcNEAagrGoWg19KnoXgSXk0qQPTOavpYd66w4vkG09o9PCE28/z8Pf0?=
 =?us-ascii?Q?OvFHfp8CcdoQ/rgR8iKTsNVmHgGPgl4GR1behhtKHAFcVktFBoCkJZucRElK?=
 =?us-ascii?Q?OnMS03F8MRefelXLWmiZTo/xdNWFQhxYswmbaYgYwH7AdMLD/XFajcxexY2o?=
 =?us-ascii?Q?f5rSMIq3lFDpocNAoyH06NaStePmibaElNhrmExX9DU+SVS9UNAVKwbxmw1P?=
 =?us-ascii?Q?0ps4yJbd7nYBZVUILaLUwzXoKbd3Ohjrv1hnLfZrmlLOsi86G4U9j9H2e1LU?=
 =?us-ascii?Q?IYk5m0T4bFyVOLmrqznFtAqooIdY6M/To14od+2/3F3/zY/XfdfynDd+KUag?=
 =?us-ascii?Q?m7saexKmPwBmYiHQu6kRKZgx6KLay3/f/bW3zzB2Y4/I+IXfMFMUpNAhC4tX?=
 =?us-ascii?Q?z/2gxxfk4NGml9ouS3MqPTaaSF4VgiS2ieP/r6CEg9YJj8EFTyd7nhFnhQQy?=
 =?us-ascii?Q?rIAc3uQZ67pSuyXqtRtlh10NQNPdX90y0lQ+TSregnsQq1aoiRQQVIcBvifx?=
 =?us-ascii?Q?CpSezMKfULc5j32oP6n1sXn6tr4BFtcNzsYykv+SIFtCobPhkgxWlZi+T/pY?=
 =?us-ascii?Q?qzKS8WOb/vnqu+gjKiLmfb1tAJyxh3PDuoCh9QVBxoYL91iI/l1NN9Ool7R8?=
 =?us-ascii?Q?T6B/PNLsBdrq3tbcBGKAt/mRbidBFNHVrJEylLwjjWCNnVNauunbwzHXGFRG?=
 =?us-ascii?Q?MR0IP/1Es/tD1Qv3fN3Y3bOyBEQ1hsKKi3SI3K/bn1rlTc/mbKwNq+Y54Bof?=
 =?us-ascii?Q?ReHr2cpkL65C/7pyqKtwYpvbF/yLE/GdJ1pXnPWRyT8bS7eEDaRn2J2zcsUG?=
 =?us-ascii?Q?xD03fF5JM/wpR5gE2/I0HBWIOyAKXeAWUslQIEkK55co5bmMLtTQqPftajC0?=
 =?us-ascii?Q?MMUgvtwy5LFoiiMyUbGmoM6WJ7TZYEkaxy1eRTzorfSfX+47+TUbVbFB2TKQ?=
 =?us-ascii?Q?JwePtuDPOHQ6TrjKtjEF5PKhJ9Hn2wHX7P6QWtKOUZmTWE+5zPHlkyPKceZe?=
 =?us-ascii?Q?H8yopMjHOKFIHl2NtaiE/V8O7CyAanoo+CW+LIM/OOCe57bKOL+vtdHx3P1R?=
 =?us-ascii?Q?25W5BAyYc6pSVdqQnyroiBKWXWpv/8HqTG6+G0X5CDM73OSyLffvUh49f/ca?=
 =?us-ascii?Q?4NQMRzT8QFcaAvSoVM2L51DU+1M+hBxBBfrcPHzvY16PX24JayIwcr9raanN?=
 =?us-ascii?Q?Tr4rFT3B3MNbZw/YiSXfOI0efII45TsFg6ntyj7U6cMDE1xoWxrR9IFWPlne?=
 =?us-ascii?Q?8VHW3QZ4/t+8I1uw73Nh+cujKcYJuVJOm6Kn+t1fFbHxaD1RDrb6dDeMD4AI?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a484eb5-f1d5-42e8-ab4b-08de080d0308
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2025 14:55:11.1179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o1dHjfifqttgMv94vlkrOZYjg2fSLIdLqpYvKtv7pUQrnjFtGHJxAxbV2/cyI3XDk/TtqcysI3IupPC2Dzbb8/bHAuBtRMlF63d6SjtQjbozbPaGTwjAMRPa5XGOrACY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR07MB10625

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Friday, October 10, 2025 4:54 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsa=
hern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel=
.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@netwo=
rkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.=
net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuha=
ngbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kern=
el.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@no=
kia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com=
; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_=
Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v4 net-next 00/13] AccECN protocol case handling seri=
es
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 10/10/25 3:17 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Plesae find the v4 AccECN case handling patch series, which covers=20
> > several excpetional case handling of Accurate ECN spec (RFC9768), adds=
=20
> > new identifiers to be used by CC modules, adds ecn_delta into=20
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is=20
> > available at
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FL4STeam%2Flinux-net-next%2Fcommits%2Fupstream_l4steam%2F&data
> > =3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7Cb901188c311e44625384=
0
> > 8de080ccfff%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C6389570482857
> > 32929%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> > a=3D43fGh93FKg1yBBBhGTNzy8tfJvm5Y%2FYmdABUmTuD%2FLU%3D&reserved=3D0
> >
> > Best regards,
> > Chia-Yu
>=20
> ## Form letter - net-next-closed
>=20
> The merge window for v6.18 has begun and therefore net-next is closed for=
 new drivers, features, code refactoring and optimizations. We are currentl=
y accepting bug fixes only.
>=20
> Please repost when net-next reopens after October 12th.
>=20
> RFC patches sent for review only are obviously welcome at any time.

Sorry for spamming, I will repost after October 12th.


