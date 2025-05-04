Return-Path: <linux-kselftest+bounces-32295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CE8AA89B2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 00:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FC9E3B589A
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 May 2025 22:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00FE19993D;
	Sun,  4 May 2025 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="hCW1DUqP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347854A24;
	Sun,  4 May 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746396853; cv=fail; b=Ovovya778uHTKvku3kEOEOc9g8kyF/VOaeRBA2336TM+syFiNy9XV3i9spftjIDn1BN4x9DSYMKY3VDmAaHIQlaGVnOJ2jt1s3UW1eQpuMDScNE6gUwzvNisCHqQq7I0dq1Geg9RNoUgOShLdQsg1HbVgnUodDm5nVOlAEUY/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746396853; c=relaxed/simple;
	bh=G/8dZ8lCmwe3tXzj+g9GrAvRA+m2+WkEkpqOdEiTpMM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XGjNzdxqX5hwbuGk0ZGYpRsb+njv8fL3cBhevobMkp4XDhDNuIaAYQPuoih2PQ5QPvW8H+Up6TouAvEbnZDihyAlnjIoEQcb39FwsJmUAfzIutPySL5A9Q1rzDeQDDl+1cu/PwXO/zAevEOu88hF7v2fHhSiYirTmzLgopQ7O3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=hCW1DUqP; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTZiMFFQDYKdzSSGMDlTezq154te/i0Iacl7JGBJYNZJJkCLgg46Vre60VbOKuW+WaIPl7wIZpC2JHzdsojYnE8s7lqce4iYDZbKNzmjCSNGE30Z350Koq4Gshgu2RB6Pf20Sfn1+l1fqN/TxYfG4pHOEHFp4lRXccqc/NfkLSXAaBf9sy6VNYKtfSKnrt2WXNnp4f09X7Hzr88VN3UsVKDUpMYYkSxj+SaPhe6goAeSChMScpy9A4KcMnBc7B7W5M2AIQDjRrOuIOmOokhOgUhd2+HB25S+veDoSZJfRO/m2qZAP2fAU3Dg7N/hLJ7sxZ73FBnoJhzSrsWvEgCx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Cb2zMTLTtvatFK9J3DKpXOu+H0XvPpucyFcCm7ANsM=;
 b=Ig6qvc6eOY7pDrBC27IqsTCpoBm3/XIkumuDZy8kVZ8OmN6QBwWhITDlpnuNSvFaeBCk8WkRus57TNPwi9Kez04xKMS7lfon2FMBHnnJ0/NUmfX9lDpyL/5gsh90WgLuYWOfbYRjASlR3X95PSItr3shTsCslxjPw3E4DNq9JGa/kdefYwjnuxps+/4qy4FuX8gD+Wqe07Su1oVanw+Qtk8MG4oHPPrN3CraD+rcbLUrz7yYUq14kzz0moOUJ2/hDKK7dQ9YTMuJtCGLCcMiAAQs4XyI/5g6yJ+nMER7C0wOqtrCMu0us+giXsnUw15eyo4zc03D3FUv1u3bkh+WBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Cb2zMTLTtvatFK9J3DKpXOu+H0XvPpucyFcCm7ANsM=;
 b=hCW1DUqP2hHTSiDDfxqbn3zsNxinwPnuC8t1DDgR4MaV4woRJ5Z7YdKJCRchfy+zUX4/Ut98aeAkZaU63WJHQlBdbs/OZTn/ZT2A3RmydX4JXNpeSemiA3AFAoad1ti79d+7+Sa6GjASwk6WuaO9F/EnoZo/X6/8DlPrr+iO6pOy3YHqPTvfMcOUE8tmCQrv3w5vGW0r82dJfNU0xULYTp23nZ9pMrypVn4+X4vALAQs+uwAYJpCYMS7G/Sm4X1yupS1otjVwBy+PvRd6iLqmYGaJmRMl19efL82uhHaT3Tvoj0s0V5/p0m3/tSAQksClDVqbS0KAVUDDBMM5z2EbA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DUZPR07MB9862.eurprd07.prod.outlook.com (2603:10a6:10:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Sun, 4 May
 2025 22:14:04 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 22:14:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Donald Hunter <donald.hunter@gmail.com>
CC: "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHbts+Mke/s+BQEcEGH2K9LqlvrXLO65t6AgAgu8CA=
Date: Sun, 4 May 2025 22:14:03 +0000
Message-ID:
 <PAXPR07MB79842877B8262B919848AE85A38F2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250426172025.9459-1-chia-yu.chang@nokia-bell-labs.com>
 <20250426172025.9459-2-chia-yu.chang@nokia-bell-labs.com>
 <CAD4GDZxPrgfMFLTG4Mc1VK0hM5ODP2tTFF771EhMzWnbC8BwaQ@mail.gmail.com>
In-Reply-To:
 <CAD4GDZxPrgfMFLTG4Mc1VK0hM5ODP2tTFF771EhMzWnbC8BwaQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DUZPR07MB9862:EE_
x-ms-office365-filtering-correlation-id: 4a003b10-686a-4651-89ef-08dd8b58fab1
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KCaLJOv/g4XLngYWav3vpLV7p3npQonmuR5J7Yb64zyi8F9eNjuUcCH0uaSs?=
 =?us-ascii?Q?WPAyY42pACyd3B8OuvARV+xpWIMWNxmCeK5vbILwBB8F+/gvP82yTMyuaSc9?=
 =?us-ascii?Q?p/skAqoXmslLnV9hPCujrqUCoqA796DWgVfWegAh70/2XEWJqaTcTAEGUn7T?=
 =?us-ascii?Q?JqGLcDbAXNcnfH3e/HdMiP+DBA6xUH8Okw2JESYkfhKvLd0rVNx3CMeoZdrB?=
 =?us-ascii?Q?cvGyMeUVdDVJg75buZ2jengvhoDNlNqfFH3zW8J6abo+Mka1ScSgj7g0rzHq?=
 =?us-ascii?Q?YVh3PbLZx7roF1+05w397Cee/fSYYPJNVFyxQMiBkn60v7JxrwhvFfuGntvd?=
 =?us-ascii?Q?VWv0S0vbwcI1Ay3pUGp8ltMc6szm090XYSsaIlVX10RUnbRJ7uD4q1u64ltM?=
 =?us-ascii?Q?2WcgFF1YSKYBfXfErHLZH/Rb+JNFtaRqDVni0jkFFWcRsppUk9tYzhhjBIdv?=
 =?us-ascii?Q?FvjQb+yVcm2PNCjR32pCLERl+uKVK3bUuFtzjD+l97GDPi62MFD4ufpnc1Lr?=
 =?us-ascii?Q?SxgAfvTNc44s0WkzRDins4yiJ9X/gXJlm1LkjVlifWcxQtQmbz3bYOlRzrr0?=
 =?us-ascii?Q?3aoYcKnRXJQSKXvvSmuSUYSKof3BdZE6ZDMmRN9OwuuT+/1vLWL7e5qyJn3l?=
 =?us-ascii?Q?NUPwWoje/t7HMws0wgl2cu8OFW10IruLqyGFvzTGr5ODthwCGFHYa1z8MAub?=
 =?us-ascii?Q?q0ZGq9eqFlNL7EYw9hXX8O7RQz294+Fsdjgm18v03aZQ0MmzKwWI0V3dLWGx?=
 =?us-ascii?Q?klHIxPzZ5wDIHOth40tXj2i4zz3cAOISmr6H3L/aUDZsra7CrKZ0bu2qj4+9?=
 =?us-ascii?Q?It3GpJ6Fd+283KTIGl4jQkfQrlGskoCtFthPc2eOpb2nRfXkGnGKIC/UiaSC?=
 =?us-ascii?Q?0L3Lbt93NDFhSAUpyzqxq74QvRiqwUP560h4QEtSoKPB2XMVoo9WwJSJ4Jec?=
 =?us-ascii?Q?xaJv8Sttme8vcmYQmbd+GBsn4aDJw+cwZj1GFv3ZTsbaMczFz3EP6A4HkFtp?=
 =?us-ascii?Q?JaSjexUJm9lVtLITJiN/isaJsczp4lziWL4gbIJcQMfsBid2Ph/8WgJW7sD/?=
 =?us-ascii?Q?ojIyfSUsyXPbHtmlPMSs36alGCY08QahHSXypV/CjvCDVeFscHsc/0D5Nw9Z?=
 =?us-ascii?Q?LV5li2eQ7egPOB7O7GDUG8Ok4K7ihltz+sJIE8zoyYsabuNVjzwdb0Ug71B0?=
 =?us-ascii?Q?3Lb7hNLhNR1MMgLQXdL97TlCPW1gyQkQfVBAM94psjFLJai6wQ4x3li+KTF+?=
 =?us-ascii?Q?1EjylSCdJ6neO0R2NgJmNw+TxRSESWNGA1LnhLvxCjsVWhmedUZWiaKjyFf3?=
 =?us-ascii?Q?zxbLhhaJeC9aaUQR2pCW49KmbcJ71be9DcAQkFTehtFa4n5PIcdoWivkx6ZG?=
 =?us-ascii?Q?Vwh5PfaFNsvOaDUWyDB3JQgLLhCR48GVxcbFaDGaiTI/3ckfR335288kN26i?=
 =?us-ascii?Q?S38j9m+xEpODte+U6S62FTOXnwDq0HxPLJFgi0cx16/1qXBRf3slirnnCO1o?=
 =?us-ascii?Q?srwj28JyL909ujk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?twQ7S8NW0Rq7+rX1PzcOeMvpVdEBjZNbp01gbP+3Bww/YFHxajRyD+UKp/LM?=
 =?us-ascii?Q?KwDWsH1JisPwrq8RNM5Nln/smzMzgpyGHX7/XfQR6cu4I12bXBr4r/Ca31sO?=
 =?us-ascii?Q?d6pUUuKB6eh7+LWg0fy3g/yJksgbeQ+o2E0ywD2RkicVkCXQ+Y2ETVHaCcmR?=
 =?us-ascii?Q?p1ROz7NTXR+oxYo0qYzI9W16WNzf+PCvE2XZHxnHG8dF6wIxUb7EjuNJsjVQ?=
 =?us-ascii?Q?h6a41ZsDZhdL2lGl6hxwdKrhR5pkgG6fvsaXgl7YiSjoe0ytmeSN3COOMFXy?=
 =?us-ascii?Q?hgKXoeUiTOg33Lu/HFWKcgMUVDGDvdMP7O+ex1WBNv9mqkTVXNypm4UR81Uy?=
 =?us-ascii?Q?DkjupgVL2NKfc0QJkMsozQyixsDa0QdowAzSD4dvYpSykzclL3prZVb/8pj0?=
 =?us-ascii?Q?m/VnsymjoQFsg6BUmPZr/t7OD4fycrtzB/3geGA23twScgAnevHWP3GDS29r?=
 =?us-ascii?Q?Cym6XfOKzuG0boFbyjuDTttv94WVmaSY8T24h52os5Qu6ekMp3ac7ZuKiq9d?=
 =?us-ascii?Q?Pyn0ogdaDi6HO2CJIT23uGWaU6Ih+XGCMKkz4influPFYh8brOXMYFSSlDcW?=
 =?us-ascii?Q?cy3NE9LAzF8pe1r7gFXPz+LXMTDpaa0PjMNm3zFdSqRz2hV7XY4JCsK/dfK0?=
 =?us-ascii?Q?YaoHYTlrCvpczPLERAbfkJJMgjeR0dVGOte9APqIzi2rTlB7xUnNLnRsS0GT?=
 =?us-ascii?Q?i4jjx0Un9YfdfxkW8OWJOe0JFWMsf/9KAKiL/OjVMSbHQYvvCcrU++5rViEL?=
 =?us-ascii?Q?qV/VRAvXS4w/c9tw6tVVdpuCK6zaAlCPM4Tz7GDHOLavXKy4MuYhAwIdaAGJ?=
 =?us-ascii?Q?rbkH6uInoWRnQb/xR+CEZYNZs+XglmeE878l1nFObo4zlxFlk2EPYNj5+5/+?=
 =?us-ascii?Q?LAH0HorhCKC9k11x8wFmb2h95ERJsrTtxXV2qHF6vjL1jDQfO2Gv7aZv+wnB?=
 =?us-ascii?Q?ilpr8CO0t+sjBv9yzjPmcN+Uf6sfmsnF5STshCWmtItz9b+jhghlSRqIieRt?=
 =?us-ascii?Q?dP7zaCBRuPKMoT9VlrP6k9kFGB+SUXoAYyTzC4gxaM9M2LvL//CCueg0/5GP?=
 =?us-ascii?Q?UcJhYJQCkqc+3xk1nX0wFOIoElHTDMlEEHdBWjpM8q6hXdOD1Md6UxjYZvNn?=
 =?us-ascii?Q?Lm76J75CVO0EPArftzgiCVeEDDsFJHG+guz/AyEH7zpgsivX35KjVzBdsuUR?=
 =?us-ascii?Q?MDHUM4apXA+dXSLzwTzDtNl3PzrlS0Es8CAbm9oxUN0q+eWZWyeKehWYFqXj?=
 =?us-ascii?Q?HOKqmjpvnIvmsgTiCtaN7Q+8aRNMZJ2eHBOfBk4mAkcTiImhq47cNDizcSW7?=
 =?us-ascii?Q?pfAQsYLXxfrkF3XerZqfFSeNGVE2zQtRq8vD4b+iIjpQtkGtFLu6FmvbyVGO?=
 =?us-ascii?Q?yyYvUAPDp6X/2Z2GRipmZs7Forqia/QC2YtpmLThKgzzQ6DXAiFPdeYVQIuy?=
 =?us-ascii?Q?B+Q/tMwJoCFn9qQqNijUv0CzaFq73vCMbQ4eglQsdIwmOEVD81KYE7cHKsZa?=
 =?us-ascii?Q?vbOrp/VT5rgFLg0G3rPRtH0nLnBDtIeZKA+okCZ3nqGmRrOnbziQis7Af2Up?=
 =?us-ascii?Q?dC52qpDcKgMriLCWrNVwtC0OL9bOGfjV3IfKne3zoptPoXW70sx0wbEoquWS?=
 =?us-ascii?Q?nA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a003b10-686a-4651-89ef-08dd8b58fab1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2025 22:14:03.5211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8tEj2P0EH0RlPqzIIy7FaVGed4xMdswH/HaduH0EYxfzoXiAiIejR6mMiqwQ84UVLh2GXCRCvA6tSjV+mrJS95Bt61uTB4OmMOAr4hKqG9BahSciC+46i2lnprYKTxuB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9862

> -----Original Message-----
> From: Donald Hunter <donald.hunter@gmail.com>=20
> Sent: Tuesday, April 29, 2025 7:15 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pabe=
ni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaze=
t@google.com; horms@kernel.org; andrew+netdev@lunn.ch; ast@fiberby.net; liu=
hangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@ke=
rnel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@=
nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@=
ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gm=
x.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v13 net-next 1/5] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sat, 26 Apr 2025 at 18:20, <chia-yu.chang@nokia-bell-labs.com> wrote:
> >
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Introduce the specification of tc qdisc DualPI2 stats and attributes,=20
> > which is the reference implementation of IETF RFC9332 DualQ Coupled=20
> > AQM
> > (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > different
> > queues: low latency queue (L-queue) and classic queue (C-queue).
>=20
> General comment is that this does not work. Please test it like this:
>=20
> sudo tc qdisc add dev eth0 handle 1: root dualpi2 ./tools/net/ynl/pyynl/c=
li.py \
>     --spec Documentation/netlink/specs/tc.yaml --dump getqdisc
>=20
> Consider moving this patch to the end of the series so that it can be tes=
ted against the implementation patches.

Hi Donald,

	Thanks for the tip, but I had an issue using the above script.
	It seems it expected either 4B or 8B payload, but several parameters used =
in dualpi2 are uint8, e.g., coupling.
	Or it is suggested to replace all u8 to u32, e.g., like what has been done=
 in fq_codel?
=09
Error decoding 'coupling' from 'tc-dualpi2-attrs'
Error decoding 'options' from 'tc-attrs'
Traceback (most recent call last):
  File "/home/anc/net-next-github/net-next/./tools/net/ynl/pyynl/cli.py", l=
ine 160, in <module>
    main()
  File "/home/anc/net-next-github/net-next/./tools/net/ynl/pyynl/cli.py", l=
ine 141, in main
    reply =3D ynl.dump(args.dump, attrs)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 1088, in dump
    return self._op(method, vals, dump=3DTrue)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 1082, in _op
    return self._ops(ops)[0]
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 1069, in _ops
    rsp_msg =3D self._decode(decoded.raw_attrs, op.attr_set.name)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 775, in _decode
    decoded =3D self._decode_sub_msg(attr, attr_spec, search_attrs)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 726, in _decode_sub_msg
    subdict =3D self._decode(NlAttrs(attr.raw, offset), msg_format.attr_set=
)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 759, in _decode
    decoded =3D attr.as_auto_scalar(attr_spec['type'], attr_spec.byte_order=
)
  File "/home/anc/net-next-github/net-next/tools/net/ynl/pyynl/lib/ynl.py",=
 line 151, in as_auto_scalar
    raise Exception(f"Auto-scalar len payload be 4 or 8 bytes, got {len(sel=
f.raw)}")
Exception: Auto-scalar len payload be 4 or 8 bytes, got 1
=09

Chia-Yu

> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  Documentation/netlink/specs/tc.yaml | 166=20
> > ++++++++++++++++++++++++++++
> >  1 file changed, 166 insertions(+)
> >
> > diff --git a/Documentation/netlink/specs/tc.yaml=20
> > b/Documentation/netlink/specs/tc.yaml
> > index aacccea5dfe4..9eaab15cc216 100644
> > --- a/Documentation/netlink/specs/tc.yaml
> > +++ b/Documentation/netlink/specs/tc.yaml
> > @@ -51,6 +51,31 @@ definitions:
> >        - tundf
> >        - tunoam
> >        - tuncrit
> > +  -
> > +    name: tc-dualpi2-drop-overload-flags
> > +    type: flags
> > +    entries:
> > +      - drop
> > +      - overflow
>=20
> These enums need to be defined as part of the UAPI in pkt_sched.h and thi=
s file needs to be in sync with those definitions.
>=20
> This enum seems to contradict the comment in sch_dualpi2.c:
>=20
> bool drop_overload; /* Drop (1) on overload, or overflow (0) */
>=20
> > +  -
> > +    name: tc-dualpi2-drop-early-flags
> > +    type: flags
> > +    entries:
> > +      - drop-enqueue
> > +      - drop-dequeue
>=20
> Also contradicts comment in sch_dualpi2.c:
>=20
> bool drop_early; /* Drop at enqueue instead of dequeue if true */
>=20
> > +  -
> > +    name: tc-dualpi2-ecn-mask-flags
> > +    type: flags
> > +    entries:
> > +      - l4s-ect
> > +      - any-ect
> > +      - none
> > +  -
> > +    name: tc-dualpi2-credit-queue-flags
> > +    type: flags
> > +    entries:
> > +      - C-queue
> > +      - L-queue
> >    -
> >      name: tc-stats
> >      type: struct
> > @@ -816,6 +841,64 @@ definitions:
> >        -
> >          name: drop-overmemory
> >          type: u32
> > +  -
> > +    name: tc-dualpi2-xstats
> > +    type: struct
> > +    members:
> > +      -
> > +        name: prob
> > +        type: u32
> > +        doc: Current probability
> > +      -
> > +        name: delay-c
> > +        type: u32
> > +        doc: Current C-queue delay in microseconds
> > +      -
> > +        name: delay-l
> > +        type: u32
> > +        doc: Current L-queue delay in microseconds
> > +      -
> > +        name: pkts-in-c
> > +        type: u32
> > +        doc: Number of packets enqueued in the C-queue
> > +      -
> > +        name: pkts-in-l
> > +        type: u32
> > +        doc: Number of packets enqueued in the L-queue
> > +      -
> > +        name: maxq
> > +        type: u32
> > +        doc: Maximum number of packets seen by the DualPI2
> > +      -
> > +        name: ecn-mark
> > +        type: u32
> > +        doc: All packets marked with ecn
> > +      -
> > +        name: step-mark
> > +        type: u32
> > +        doc: Only packets marked with ecn due to L-queue step AQM
> > +      -
> > +        name: credit
> > +        type: s32
> > +        doc: Current credit value for WRR
>=20
> The credit member is declared in the wrong place here. The struct members=
 must match those from struct tc_dualpi2_xstats, in exactly the same order.
>=20
> > +      -
> > +        name: credit-queue
> > +        type: u8
> > +        doc: Current credit queue
> > +        enum: tc-dualpi2-credit-queue-flags
> > +        enum-as-flags: true
>=20
> The credit-queue member does not exist in struct tc_dualpi2_xstats so sho=
uld be removed from here.
>=20
> > +      -
> > +        name: memory-used
> > +        type: u32
> > +        doc: Memory used in bytes by the DualPI2
> > +      -
> > +        name: max-memory-used
> > +        type: u32
> > +        doc: Maximum memory used in bytes by the DualPI2
> > +      -
> > +        name: memory-limit
> > +        type: u32
> > +        doc: Memory limit in bytes
> >    -
> >      name: tc-fq-pie-xstats
> >      type: struct
> > @@ -2299,6 +2382,83 @@ attribute-sets:
> >        -
> >          name: quantum
> >          type: u32
> > +  -
> > +    name: tc-dualpi2-attrs
> > +    attributes:
> > +      -
> > +        name: limit
> > +        type: uint
> > +        doc: Limit of total number of packets in queue
> > +      -
> > +        name: memlimit
>=20
> The convention used in YNL specs is to use the same naming as the enum de=
finition from the header, with the prefix stripped off. For this attribute =
that would be TCA_DUALPI2_MEMORY_LIMIT -> memory-limit
>=20
> > +        type: uint
> > +        doc: Memory limit of total number of packets in queue
> > +      -
> > +        name: target
> > +        type: uint
> > +        doc: Classic target delay in microseconds
> > +      -
> > +        name: tupdate
> > +        type: uint
> > +        doc: Drop probability update interval time in microseconds
> > +      -
> > +        name: alpha
> > +        type: uint
> > +        doc: Integral gain factor in Hz for PI controller
> > +      -
> > +        name: beta
> > +        type: uint
> > +        doc: Proportional gain factor in Hz for PI controller
> > +      -
> > +        name: step-thresh
> > +        type: uint
> > +        doc: L4S step marking threshold (see also step-packets)
> > +      -
> > +        name: step-packets
> > +        type: flag
> > +        doc: L4S Step marking threshold unit in packets (otherwise is =
in microseconds)
> > +      -
> > +        name: min-qlen-step
> > +        type: uint
> > +        doc: Packets enqueued to the L-queue can apply the step thresh=
old when the queue length of L-queue is larger than this value. (0 is recom=
mended)
> > +      -
> > +        name: coupling-factor
>=20
> The definition is TCA_DUALPI2_COUPLING so either this should be "coupling=
" or the enum name should be expanded.
>=20
> > +        type: uint
> > +        doc: Probability coupling factor between Classic and L4S (2 is=
 recommended)
> > +      -
> > +        name: overload
>=20
> The definition is TCA_DUALPI2_DROP_OVERLOAD so this should be "drop-overl=
oad"
>=20
> > +        type: uint
> > +        doc: Control the overload strategy (drop to preserve latency o=
r let the queue overflow)
> > +        enum: tc-dualpi2-drop-overload-flags
> > +        enum-as-flags: true
> > +      -
> > +        name: drop-early
> > +        type: uint
> > +        doc: Decide where the Classic packets are PI-based dropped or =
marked
> > +        enum: tc-dualpi2-drop-early-flags
> > +        enum-as-flags: true
> > +      -
> > +        name: classic-protection
>=20
> Also does not match the eum definition. Should the enum name be expanded?
>=20
> > +        type: uint
> > +        doc: Classic WRR weight in percentage (from 0 to 100)
> > +      -
> > +        name: ecn-mask
> > +        type: uint
> > +        doc: Configure the L-queue ECN classifier
> > +        enum: tc-dualpi2-ecn-mask-flags
> > +        enum-as-flags: true
> > +      -
> > +        name: split-gso
> > +        type: flag
> > +        doc: Split aggregated skb or not
> > +      -
> > +        name: max-rtt
>=20
> Does not exist in the DUALPI2 enum so should be removed.
>=20
> > +        type: uint
> > +        doc: The maximum expected RTT of the traffic that is controlle=
d by DualPI2 in usec
> > +      -
> > +        name: typical-rtt
>=20
> Also does not exist in the DUALPI2 enum so should be removed.
>=20
> > +        type: uint
> > +        doc: The typical base RTT of the traffic that is controlled=20
> > + by DualPI2 in usec
> >    -
> >      name: tc-ematch-attrs
> >      attributes:
> > @@ -3679,6 +3839,9 @@ sub-messages:
> >        -
> >          value: drr
> >          attribute-set: tc-drr-attrs
> > +      -
> > +        value: dualpi2
> > +        attribute-set: tc-dualpi2-attrs
> >        -
> >          value: etf
> >          attribute-set: tc-etf-attrs
> > @@ -3846,6 +4009,9 @@ sub-messages:
> >        -
> >          value: codel
> >          fixed-header: tc-codel-xstats
> > +      -
> > +        value: dualpi2
> > +        fixed-header: tc-dualpi2-xstats
> >        -
> >          value: fq
> >          fixed-header: tc-fq-qd-stats
> > --
> > 2.34.1
> >

