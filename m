Return-Path: <linux-kselftest+bounces-37225-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28581B036BA
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 08:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E0B81650A1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Jul 2025 06:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6345B21C174;
	Mon, 14 Jul 2025 06:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="tDOPrq/e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012053.outbound.protection.outlook.com [52.101.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3155D218596;
	Mon, 14 Jul 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473653; cv=fail; b=cpdu/hefC32vbQ/DlWlRvtKihkV7pKROh061klxYlYPF7P7KwtbZkrjbjZLNGizPW1k//e5c572MJ2G0mokUqIfeekHw6tI6Kl+kF8x81VQyx8V41+AaIxstoGKRjMcF7oxHyjC44af/5cjiluXvG/eliwRSoAzjmqYrUrvV+/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473653; c=relaxed/simple;
	bh=owIYnV4SEqyeQic9rvA0V8bM+L02etgsQMPyeknJ0BY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uRO+5EtHzeMXMKQJesyRPSwVHnh3V5NGaB8Qiap5n0kap47GDxXTyBRNzcowDItVq6TIJ8t53hZTkI2GvSuWWzBBtyEIXm2CZHEdSqNMzyD8IQYPpzaMWAAe433rixZFzbE40CBvDl+1uHHs/YrRNSLRj2sRRU5/E1AqRtoj0HU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=tDOPrq/e; arc=fail smtp.client-ip=52.101.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RQJRDDcn5wic9AfybP0W3nMPUDoAp06x0UfBBw+vPUg5xWNku8wIsF1uQ8V00Bego2VQihVDO/QhruP0yqVEzxtzbovzb2Tg5wxWwsetr/bEemIp15ogP4AEhAjuBpPlGq3ZVevFndRykS3o6ZwNqoBL4Cr7usURG+lxcPPOLMlsSfiNTX20i6TEEtQTcRC74xRufTpOVQ3lMF91jgO8p7tsZmeWp8st2EQHUz6g78zu7kRN3BErr1ZyX1uOg7scIIeR1iMEd3qnXfFw4deUtxDAev2GeISV4ogV5iXKwa1KTTcD+1BoXP2WnlDJm0imNdPLJlRvGE17g5sPGvKPjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OrSBfvJNFpjRAAXlemAbM4YVdIm1sXZA12o576VMPg4=;
 b=DRxnBC54tpyDxozjVauZSffVDcxpNJWA4vowlUJ9BuYI8EnHi52rwPhs/AUt8ysBYxNDc1StNVCgZGhoayz8VaofSbsps9Fnlf6WNfdTulRv43b+7NBdxkbGwICsgtxwTTw/3xwQRnemr4RsLgKWpr1NyK+4FcirEldVbfYeQO6gKyh3HjxY21d5xIkCMY8uvISVJ7HlpywXPQjtiiA+qSQr5dSAq7SjtGDK4Ysae4O82rgdtFK7/z9MIaKtoondPLPGYcX/iPu6nlczEO1kZvGL1D/Xa6hVwL3MhDrnV1IwYK8w6+/gAfwcrCqF/kvYlJwx7iSm4ymzn6EEv7iZfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrSBfvJNFpjRAAXlemAbM4YVdIm1sXZA12o576VMPg4=;
 b=tDOPrq/eGm9zh/R18o96uKMTz2lFNOtHZcYO6433pYSyEIY7EyY7dFLZ77xpiswa70CWTmDz7f/CXRPlLMIsUo2Y9l4Cy/G1CL4IHJ0WybDCX0NWz81ibRd9n9oINGYHyfjInCLTp2uPuPC4VGELXOujMg6w3A9da/eIrCbCM3Z143b7Zh/BRV4voKlhTXPScNGGRsQQv0qdusUT/QuCLWR3nyKhkjOElM0UrLK5d04m+nSjgwS60wie5TOviiYky3wCp+DvS45a2ZnN9Ygglu6FmgH4vdzJqZoo6oH+jdgjaCd/2v2mbJ6ueQQ2113Y9jzwJTZ6+xYEPbWbpupVjg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA4PR07MB7311.eurprd07.prod.outlook.com (2603:10a6:102:d3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 06:14:08 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 06:14:08 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Victor Nogueira <victor@mojatatu.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
	<pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@fiberby.net" <ast@fiberby.net>,
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
Subject: RE: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests for
 qdisc DualPI2
Thread-Topic: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests for
 qdisc DualPI2
Thread-Index: AQHb8nCgdyoY2HJck0ybSTf6+6zluLQtSvMAgAPb80A=
Date: Mon, 14 Jul 2025 06:14:07 +0000
Message-ID:
 <PAXPR07MB798429728A10CA40CEEDB0DCA354A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250711143208.66722-1-chia-yu.chang@nokia-bell-labs.com>
 <20250711143208.66722-6-chia-yu.chang@nokia-bell-labs.com>
 <01a580b4-0c8d-4d22-a3e4-264335d7a947@mojatatu.com>
In-Reply-To: <01a580b4-0c8d-4d22-a3e4-264335d7a947@mojatatu.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA4PR07MB7311:EE_
x-ms-office365-filtering-correlation-id: 42306967-8bce-4fc5-1d88-08ddc29da46c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Vih9kBtNPyFHfBukWThoLxxeePqPzclq+aUbL75zfYoUIBzeCCv7B7OZmlV3?=
 =?us-ascii?Q?Cz7kYCPoQl5KNYtAPTsHwe3HRgaex5NUVqKY+4yKF/sRl/oXo7ZnxuhommvS?=
 =?us-ascii?Q?4rb65wc7GZ1VDFtLu/cUDhxzFVyJHdp0J4AXaAkhaT88pl8wHV8vIxVgS5Ra?=
 =?us-ascii?Q?grlaLHJz6mQUjNQb2SPaq2CPgK4XyFLJTA668iT4liFa+1chEpSAa08YkoC2?=
 =?us-ascii?Q?CgScQ76b9gaDYIuU4bmqumWAVy559gpipvBcYlYD7rIrAuFKfgnS/qjQqUWx?=
 =?us-ascii?Q?l3+WC8QTaGaTFTiyDY+Hu2LFmlEzz00fKY1olVfHyWlMrBnTV5Y/qb2SARhz?=
 =?us-ascii?Q?Ps4OSCM+QQQREaqpQMvOSjz9I6Y+KqgeTtnz4b4NWIe7fvxLOXyBn0ITDltl?=
 =?us-ascii?Q?DAAfcwzVFLZorNWu2MrZ5ZoCWofO0+qVnt7y2tXVMOaBv1L0Q45gN7sfENV4?=
 =?us-ascii?Q?yBGG4J98Zm+GdZ1KxyivlSctJoUGxNtUhSfJif7PxiZqE/CHvsoWA8xNR+Ow?=
 =?us-ascii?Q?Kv0Iwc3zK7qnYWnEfPsXaHJHoK4SaFVKGszMyq01lih/jQLAeDW+lstm4vOH?=
 =?us-ascii?Q?wVO5ug/lh80ZeImGxOGUPLXZ2JlpXtIaP1u37uPpEDrfZgTFiEuYyFVY8C9s?=
 =?us-ascii?Q?10aTj9BueXOVTWDBtrmYwW40t04e6uleVY7++0uzlVnJBRy+qhpSWTA41y5b?=
 =?us-ascii?Q?4mxIW/7zZ0qn0RpxPx1Pvw9DGsT0HzmZhPbaxcBRo7kRZIFNqQpOTFNSRqTT?=
 =?us-ascii?Q?QakYMqvpPS1S/0udyrsmBKYnEYQfI/G1Jom/456fWT1x4JNPVdaknaOgT7s1?=
 =?us-ascii?Q?QrTPtzv+ccx58tyui4eVpRk1YImu3vVYYZJH91PRYYyKENRGz5OI0WDdJfk7?=
 =?us-ascii?Q?0Z6vU1dvkZGPL4j3J209AQJPFWLAUNw8V80mMeJF7LY26uc7zx+AQYN0V9YI?=
 =?us-ascii?Q?YaB/6htnd6uTi395NFbH+4GD1gLid6orhRZSSBc7ugusiIOxzu6VVLCtj02l?=
 =?us-ascii?Q?SUysEjk60SVSyPvUzfKxCcBEyY/t/Cw4cNQN6KuLkdenSwz+LEaC/NEIlyrP?=
 =?us-ascii?Q?NZsrzdRv2o6PX3EWfrdWy4putp1B1mOL6VSG7zUPosaHoU1S50ynxpMcUsHw?=
 =?us-ascii?Q?2iD+vt6fSRoS5hDVM9iG8zYb7RAOTQBGiZP80nbFONXWnk7YgmKkTAW/K0jS?=
 =?us-ascii?Q?bgeO9INHNFKoSaCToNswhxU/Y5li1t1P/6Q9L2trK2Pbx4LxGzQJYjAUOdUe?=
 =?us-ascii?Q?fXzk1bXj6AZS4NDadGxbUv3GO4UDnuAc1T+Znn8aU5bdAtko0AflSgB6JhEk?=
 =?us-ascii?Q?gvlGz/JoRFB8D8hjiMZLMUlUX2MM7eFZKUyEeVcvMlNrIfqyZ1uD1Gv+h+sC?=
 =?us-ascii?Q?i0EfkDMeYU7zDXCNq+dcSurp+fjDlVPhpOhSmdbNBKwW5q660hzt1h1bdZo1?=
 =?us-ascii?Q?hDT16tWzJRibXatLRhR20+byCI9eyAUUtDF5ujyrZ/miUDFppFwzZoDPilY6?=
 =?us-ascii?Q?kOTkXDex3Di9p4Z9h4o67OLrTAWp7idl7J1F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?LAFOCvxKAZZpqkwMSG/FO2h7yQejRMhD1LI0P9TlS8DVCnnBU4Ou5ooYcmTc?=
 =?us-ascii?Q?8zUcJUY5Vzbgvpey6PouIdHPh+wI55jrVmnCywEcxURKwIwC1u4WqQgMR2ji?=
 =?us-ascii?Q?jm8cAeQ4c59Oxxu4I+Hd5Ry8FkfTqX/KxCLlcTkbbLAuot+y668whkSxrH8G?=
 =?us-ascii?Q?vcj9RA6hYZCRyxK3j1mxd28T8kqqdV0t44En89VusC2pQ8skxcb3scqb/ur7?=
 =?us-ascii?Q?37bnNg0PqQx2YJbRID5d/qlrMVz36uWhIQkuW6TEjpp0VMCDsWtLrUSybEKk?=
 =?us-ascii?Q?iBJ9322/B/Bnq6bI5KGyZf82Ae9Hw5Y794XnfLNKj1FPAOOCr7vr3fQncvqB?=
 =?us-ascii?Q?tytawMS/MkTL/Uesl895B+dSWUg53zIXT0vCmgQP2tx9P/ivzXtst+EBCteq?=
 =?us-ascii?Q?C04b9ZVi8qIomiS3oGnoRSDoerb/6r+xdeDY9r0V6eGTIRC1YUFgosenlso7?=
 =?us-ascii?Q?VhJNX53UVPb2iPXNeRV35vPrtWpWF/7+f1u6c4RQp6Sq2N3daWa6tirCh73x?=
 =?us-ascii?Q?sWhLqYQAJ+Oga3bVDJAQvoDjRrfz+gxQpnvWruElwsXEgSXkRV4DXGxE0vOw?=
 =?us-ascii?Q?sD5z+OsFoQA1lvurvTo7KbZzkZDsQJSg3dMf6a26sNHNA1qXBx6pgVYvr3AI?=
 =?us-ascii?Q?rVlg+7SHB4CelcwvUR4laGKfCdFxu3jTTeVZEvSOPF24aSumo0ZhSOVO9Q84?=
 =?us-ascii?Q?OAeKr5VKFGUAMrEU2xu2STCqKQQntxccH8PLv/imSkqss0Nic5tYHbepiDwV?=
 =?us-ascii?Q?fLfU0BC8Y6tMdidYpwqHU6kb5rAQkeImY00JC64vGq0ES2hrtNwOxR66vb7T?=
 =?us-ascii?Q?y76qnk16dEj3VFUKr4Aos2OMWBzoVGK+3bn/wMrpl17Jg+XwtJaVtvLegLOD?=
 =?us-ascii?Q?sUI0z2oE+beahhnyHQYG4Ao8gBO/Tw9HXNYXcRf27yf4PdkYOhdiw2zqU/Sy?=
 =?us-ascii?Q?vVuUTczuQMyX7LMMbd0uZdrygt6t1Lgnr3/Mix17CIS9XoT2Vq2iKQp9F9o0?=
 =?us-ascii?Q?lCGRdnOhiRdANXjZe094FD/gWIcbRYvFIteDp+6x7k2Cf4XRoA2EnqiIaI7d?=
 =?us-ascii?Q?D7v1Ek3jYfBXU5qfozw2VmSf7axKKf4V6oycWBJURzf9jqkd6f3LK7yRr7mr?=
 =?us-ascii?Q?b7+icBSUFwWaw1TSb8LgE97rRxMjE0azz9XPi05ajtX/2SVFwDTieYQ8h3aQ?=
 =?us-ascii?Q?AYUxvmpV56Pf4iO9phhtD4fEQwO8tXruo00uozSeeOt+WvExLOU2mgueKtXD?=
 =?us-ascii?Q?ibHNnpj705wo/jYfcURiy/NjYOiC2xhATRG1ToJdOvveUZldVBGT7DQ1t1V/?=
 =?us-ascii?Q?rYCr8mH+312BPIjHsEUlwGZ4WDNMzr8AXbxd2VJK7eSsmxiGSEJ6YUy1d0Z/?=
 =?us-ascii?Q?kDG6pZtrjl/YkyjB5pWZA4H+8TsYoUnrAJWl9/4E5tPPXBMX3AHfN8ufhruL?=
 =?us-ascii?Q?VM6sL3zreREeG2oP8MI+nYntuKwirEn5/Z4Im64qZ/evbtzrLZ0XexWhLF7X?=
 =?us-ascii?Q?kPMeC3gKM/OAzyVAGjlt/IIsd9nXtgwwkrXqmmuwdMMrgxKgeazgtrJVlaSb?=
 =?us-ascii?Q?CAQj+MrQ3gf4DuSLlXurl1uavb8SmwFLVvcS9SCssLT7T4qk+Wo18OHLYSBD?=
 =?us-ascii?Q?/A=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42306967-8bce-4fc5-1d88-08ddc29da46c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 06:14:08.0149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfAbIVNed7Vmt6DuRmivNFcpky84vFGxmMpC1+UW+MhJKyq0yvk+KHjMjXcNr4WIgf7CvLmve3U+zL0QSUAj/+3ZS0gZNZ5l3BqnuW7P1qIS0/E3NOt4bfnDIT5iTdRW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7311

> -----Original Message-----
> From: Victor Nogueira <victor@mojatatu.com>=20
> Sent: Friday, July 11, 2025 9:14 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; alok.a.tiw=
ari@oracle.com; pctammela@mojatatu.com; horms@kernel.org; donald.hunter@gma=
il.com; xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pa=
beni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.=
org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; eduma=
zet@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.co=
m; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardw=
ell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.=
com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehle=
wind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comc=
ast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v22 net-next 5/6] selftests/tc-testing: Add selftests=
 for qdisc DualPI2
>=20
> [You don't often get email from victor@mojatatu.com. Learn why this is im=
portant at https://aka.ms/LearnAboutSenderIdentification ]
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 7/11/25 11:32, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Update configuration of tc-tests and preload DualPI2 module for=20
> > self-tests, and add following self-test cases for DualPI2:
> >
> >    Test a4c7: Create DualPI2 with default setting
>=20
> This test case is failing now:
>=20
> Test a4c7: Create DualPI2 with default setting
> exit: 2
> exit: 0
> Error: sch_dualpi2: Dualpi2 options are required.
>=20
> cheers,
> Victor

Hi Victor and All,

The above issue of v22 is fixed in the re-submitted v23.
However, I see v23 now is labelled as "Changes Requested" but I do not see =
email.
Would it be possible to let me know which changes are needed for v23? Thank=
s.

Best Regards,
Chia-Yu

