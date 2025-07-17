Return-Path: <linux-kselftest+bounces-37474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE010B08650
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 09:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4505117FA99
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 07:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDF420A5DD;
	Thu, 17 Jul 2025 07:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IScBnWiC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012021.outbound.protection.outlook.com [52.101.66.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB051D554;
	Thu, 17 Jul 2025 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736587; cv=fail; b=gGZ1b4GwNq+CpIX5QsyBoz8wVVzuV/ocnj/NyJBU/S22RSj4ZDtW57lMhZ/e9CB9+O6whj0SmwCLXJ8ZkZZujnfx/E36GooAhVrgioIOgah5fAZB7ifxRCk87AtqKztdyfZ1d4WrdvPEJWzP47d2mb+uogTVaFzZ6b2ei79pZ0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736587; c=relaxed/simple;
	bh=4N6ltMHnOLCl7VF4npTUG2NSXXOYcoGNMTzV7qwHMyo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mzr6Q6LsTDWg8yIw0Lit2Z4PHtCFooHqfU+f2sXWp2zYEsNye/tRx/MgMqdryEZJ8IQ5B2/bJfROk013QJeUGlr4H9f4PKitVQxH4rep4/dqMq8UzhB2IlYubRYX+JhjqJ6UarILmwMDF76963JHd5zsyDLsRw/f7nE0jnL++ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IScBnWiC; arc=fail smtp.client-ip=52.101.66.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OZyr40ua+IbLK46scjtJLeZogG4kimbqppL5HyW897GQDf210uh9QPWLhc33CD/BHoBCbD2SyzEmN44Kp1NW52ZiF9ujTYLpy4+LGv/odRgMLYmd3upH1Kl/k78Neqq5lA/UYZHrIubh9OTg7MH+NdMKCiOXyyTpLvxvk2LRybHYodHZw/OTWnLfFyqRNwSrxjLCRIZQ/wzud9485OnIcXTwlSMLZmpX5ckzdcLp8IVVpEszjbM0lpmdxAbzLsRzZwHo620V4rWHTt14T0csK7jEN/5bm94hX2ZDGL+BZQ09aH88bms4j60W7DCcJC4/paE7Cf+ka6oEwiRdN6Lgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+OSXSI8MCjth+iHUXBweXXR3gDTsZW9B+g8i7/awU4=;
 b=aV1zFx5PecZwWJALVpnngzHN43gWK6igfypy2YVVpV84Ic5Y2Ou4AOy7xKGPwl0bhQdX/fjeISkzewejf5qV33mQaYl1uHlPqWTY02sZj69iSScg2kzq4A7oXReqjLYGz9+yd8IymN5D30eZggOPYZ5jYs3iBG3hLj3z4OQWqMc/Wi5+RxOdo5rKS6xwhr3/4WpHlU91jgHd9KnQqUbbISaQGXRAJJJ/OM9c0+fGx4lrBfopx4x2HgHIHkxMVd/UzFqTEx4ClnwgtpHG2z0Tm09W61e3ohS/OFZSaYsF9p7aLF1GNaquWwRiCvDk/U3Zaldjj1eaP4LnE72PJ6WDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+OSXSI8MCjth+iHUXBweXXR3gDTsZW9B+g8i7/awU4=;
 b=IScBnWiCiEMrGnbE6k/ZZeaUdQjvcWX2cRB9sA4pfD+/ti4P+Zx1PK/8Hxa4cGctpvEHBtjYY0q8PemAG+76KEQThaxW1klgoCKLl8QPuorVrPpVah3yRhls5X0u17X3jTefyWKqR6e56EWcq+4QWpQG64atVTON+StR+K6Tbcixve7tF2et8zg89Usr4orDL3JH/+8z0D6D8jTnBKTIevISQkornEa/jSfRhVQM7nejIWMGe/chRHdup280GDv3ArRChZV/utmtbcRVxrO0lAvkM3xtWBEhwd2r42tIoepVlvWr1JKqHLqDg9ZSPzFMNPZpnw6vTXCRRAGwB9qajg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9714.eurprd07.prod.outlook.com (2603:10a6:10:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 07:16:21 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:16:21 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "alok.a.tiwari@oracle.com" <alok.a.tiwari@oracle.com>,
	"pctammela@mojatatu.com" <pctammela@mojatatu.com>, "horms@kernel.org"
	<horms@kernel.org>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v23 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v23 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb8+RE8DDWpYvQaEawmS20VPZnHLQ1b7iAgAB7nDA=
Date: Thu, 17 Jul 2025 07:16:21 +0000
Message-ID:
 <PAXPR07MB7984AFFA35DA43805C02E542A351A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
	<20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
 <20250716164547.6d415024@kernel.org>
In-Reply-To: <20250716164547.6d415024@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9714:EE_
x-ms-office365-filtering-correlation-id: dfab0ea1-2853-4877-6680-08ddc501d4d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?buGCIrjBRApyY7fczCVM7HZoFzfcnfe/fndwSn6V9fX5402yj6+1pqSojAgJ?=
 =?us-ascii?Q?mO43vSbzDbQqM05HRIRP4F0jioUo4FWDdrWnOmw5mdmF5xh+0OgDNLMnri1k?=
 =?us-ascii?Q?uFUXc3tH+zLAxCs+1JsZjPYkwI3MzXwZqtb0zTnU7ZnRGBbajm9IOsvxUG6i?=
 =?us-ascii?Q?JWcwhRCfUeiQLdzsmHc6T2aqYcY5k1R6I2GpuXpVtXkoaFVgKbQY0Z00Noe2?=
 =?us-ascii?Q?dNyQiBseqfIR/n+Nk42JM50t23a3oy7JRhF41icwlV9TdfF6Q5EQ9bDN+G58?=
 =?us-ascii?Q?QNy6whvaeC9hrV9LzGQ8bEGakIuDajXQV3xz4jNXki9qNVzX8pftvATlG20u?=
 =?us-ascii?Q?W+1zMcXoKtKdKjXL6P3+C7/9CQOngeFLpmc1J9VAGXeKR4qn3JoFsC9Q40ez?=
 =?us-ascii?Q?QOMrM6TnROqzQci9RnrLmNe6+9lAjtBHOgrcI+2WN3QMqlklYo3zuEzpTWRp?=
 =?us-ascii?Q?KvzzcywoHmBpuSfo7mJYdtxvz3Tfo9XR4kAkF1V0ej97q6mHprYPxEs2skUv?=
 =?us-ascii?Q?hQw3NVAJx12KeWeGh+TB8mYpsKuri0xeg3O0h5ksj4coZ6zHIZPhbGCOPcCE?=
 =?us-ascii?Q?YC0XmgXBCmGW97H2FfA8XrDtdvr1BkINTlt69wDWvXduE0HcmLvCfAXIAUrV?=
 =?us-ascii?Q?VXl3WQhj8F4q9vAvo1BJ7L5IOYhJcvXskjuClzZrFtxi+9hHFBoySpuf0nBA?=
 =?us-ascii?Q?lLpY+Py6tH/W7iOPyJaUghBWDx5U1utR143ZJ69QyEdr7oqXFcQbzgM19DJu?=
 =?us-ascii?Q?HvKIbZDeHj9FIIW+0m2yY+bZE/QVzk8bNjBeEMW8SVqjHIhQAl2IdO7YTgbA?=
 =?us-ascii?Q?QIojEtmkQPXSsh9hhqi2f0YtnaHlO5ZFXL1y2HUY8JH71uvFacoK6S4HNKCl?=
 =?us-ascii?Q?yhQQOTXavsuUlH1z3Gr6Q+yf4iYWwBy011WETmcOQaLnJr4L1ta54CEBuLrG?=
 =?us-ascii?Q?FP6vd0W7teFYE3wGd9u/6wkjcvnJQAmvCGICij945fV+RTEOkC+7gYFM1yI5?=
 =?us-ascii?Q?C726mYWOKKFUGxUG7cOCTa7WPWdVNX6xptO4I1cKNoem6e8zevM01g3/Lxfq?=
 =?us-ascii?Q?8tos2Valh3Gow7LUNbwZgORxhp+E5f6ZmsZwMJhVIPkgLe4yUouww1MGKLws?=
 =?us-ascii?Q?wMgLwWtPafJ9LNxOfLAuVnD8Iy1f3pzn8FV2R2nhxq/HlxbntOmOJcz3lUD4?=
 =?us-ascii?Q?lpsytld8HJtiEFjuRMWee9fHIMLl/B4ZAjWr7QqJxnNE4kjFMLmwdSqLu+W4?=
 =?us-ascii?Q?InyBY4umt9srMofbrPWRMLrRDOtVCzEkf3GE9FldKXIK/fET5TGOsdg2ItN1?=
 =?us-ascii?Q?gjW0w5AF1NTjV/hjkCgfnrMmBKHcqmMEGNcfrcU9LVYlRT2kWmdoVTvEEZji?=
 =?us-ascii?Q?NU70BowSk5QKgh+wzV79nV3eD+lTAqObUwULf/OUlljG6PqFd7Cy70bEDLWP?=
 =?us-ascii?Q?E4ouehJUcZP9EOGgcSz9OYG8HIymLGJuKnlvVW7eOBdapmQpwqsk5grgHrwF?=
 =?us-ascii?Q?e0Hi/R+vgu0lsuQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ej3F7tRew4QLIPtWGEUVWXvxpo5Atf3UhHollrjq3/ALFF1tJpl2Bf2TY3GB?=
 =?us-ascii?Q?qtlKvnWIltt4KFBdkxATHgRA7gqXsX50lr8VpUlFSrbgd4yHGjC1/pRN/8AI?=
 =?us-ascii?Q?Pf/gVk/HQMTJUf99SITToN9DbeTy2EXashEtxL7vdRyjBsB+KlypN7P+nl6s?=
 =?us-ascii?Q?7dTBBiOGCGqkiYdMbIWKGY2iy9we94sgPTifb+pZV1HrQkgVkTfVdHrhyorr?=
 =?us-ascii?Q?ntbOBF3ZMf1mOD1bEZyxMfTHxypD7m+p+3KBds9Fr/qGcYkUdeByZ2cBt22d?=
 =?us-ascii?Q?pp1HQgmq63UolTD56gZDz/Cm2bE1MjL2thJMylT2efk0mb87ctkLfnkF6LIN?=
 =?us-ascii?Q?kTUoAEUu28yMh3xvxlkl+O3vO43ZOtoQNTLJ83JwIDWF7MSjz6HXLW0CTMJk?=
 =?us-ascii?Q?54QORxGolloYCdfoGnNC/e3uIJP+224qV7ddlK3J0vLhyak2RWvViceoxVUv?=
 =?us-ascii?Q?xU3ejJ0SlCkMr257uCaCtn4EQeTycbNa0i2+oQ/xNsE9OcE/stiI5VDfU3vP?=
 =?us-ascii?Q?Yv8bGviTcKiyFgiF7d+xRf3ucmZRC1RASV4ESaJS656kbMS9XOCO9f9bzaGi?=
 =?us-ascii?Q?dKdp2pEF6UdX3U+deFt7rJkSU9Orw3CBOJM12D38c0Ga9hXO+AHtZFcfGo8R?=
 =?us-ascii?Q?GEU8efY/ZnhcUh3N6tRVvGJamH70xcPoyWxHlccR3iRt03lxHd9U0YZM3ks5?=
 =?us-ascii?Q?1aWuprktrlHwjt9ogwhz6Ckm64leAK2yPABBDEQSzd4Cpibj4qjBWdK/sJ7+?=
 =?us-ascii?Q?Ad79fZ8DBIjy0kf7VgGGVV7rWyHLwEDAIMvEleRhRiI2x2oaw+/YNRrCYkGq?=
 =?us-ascii?Q?PVJOYFXihjkQAUi/4LY0S6PcXL3oqjcYe2vg72s4kFSfTIByVVpDH8cSzC52?=
 =?us-ascii?Q?K2kdLw10+gkDoHoyraNWPAzy9cqOvfz8CRX9BvNfjgqZb+CUo0nSqFBPYM2b?=
 =?us-ascii?Q?xCp/7pJyHZQRKheZzSqMFvMLP+08G+dZyzmvLNr9nzg5tKiUWiy253yMBEBd?=
 =?us-ascii?Q?qHIJruRDglu99SYWIxxXz1DuWHSkNt47EJgOviZkCTvgvTR0M7lxRxkIeewD?=
 =?us-ascii?Q?0W0B0IE0YcO4C+SD1RhKWCTURno4xUOMZPk3FNlwY6os4V8IISyIEwsb6NAv?=
 =?us-ascii?Q?kZ082P2h3ouGKrq9GeBABAiFpPh06CDjpcLCppukOJFQBdwLRXbuOTa4M4aC?=
 =?us-ascii?Q?X3ZFQmP6tIUoovLtkiFIkUKc3YLmnURNHt6QxIYLO/SLEVkye1cg/NN10Cw8?=
 =?us-ascii?Q?hIxwJP2kAgWMUFuUeQnPHkr1LdZaWbE+0Kk/Athb8IVtsDMqkX0OkjQvU0E9?=
 =?us-ascii?Q?j+Vugyn/oqgO9ObqT7YI+pidkzsswH8mKQZyMNP8ph+c/2Y355sMdUDqj9Ww?=
 =?us-ascii?Q?wK9g/Tn1i31r+3JGh6s/jQK7Rvbj/bkMr03iUym8UFFUc43R18bdq3mCzDNT?=
 =?us-ascii?Q?dkwjysBcYs+u6R1OYPrwD6ezV+zVV9s/gELZ1mrhrDxX5yBiduDikQFsJ1FH?=
 =?us-ascii?Q?2WUlOEmFLmN72RJaUHwtu7M2nYMWL84cTNUW21zxeB7YAL0MK8xsXRSSpbhR?=
 =?us-ascii?Q?bt4ugQzi72QWMiFMKpERzF/X3raZJlbttSs+09Tkz+gSIZuwlHJchdXhSVwI?=
 =?us-ascii?Q?LQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dfab0ea1-2853-4877-6680-08ddc501d4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:16:21.2646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tXsOXDZ67TaVPXZDUM4BsXeyDs+8VQYbXhU1hjfVukT78rAadoMEOndqRx+o5YUX9KT5BLh4hbTQd3Py+0Z4ZsJw6LzYPL6WNw9Wmf3Orjk7VjIjWoHahk3S7ilb7PWm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9714

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, July 17, 2025 1:46 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: alok.a.tiwari@oracle.com; pctammela@mojatatu.com; horms@kernel.org; d=
onald.hunter@gmail.com; xandfury@gmail.com; netdev@vger.kernel.org; dave.ta=
ht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; stephen@networkplumber.o=
rg; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaz=
et@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.com=
; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwe=
ll@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.c=
om>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlew=
ind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comca=
st.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v23 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 13 Jul 2025 12:52:29 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > +/* DUALPI2 */
> > +enum tc_dualpi2_drop_overload {
> > +     TCA_DUALPI2_DROP_OVERLOAD_OVERFLOW =3D 0,
> > +     TCA_DUALPI2_DROP_OVERLOAD_DROP =3D 1,
> > +     __TCA_DUALPI2_DROP_OVERLOAD_MAX, }; #define=20
> > +TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)
> > +
> > +enum tc_dualpi2_drop_early {
> > +     TCA_DUALPI2_DROP_EARLY_DROP_DEQUEUE =3D 0,
> > +     TCA_DUALPI2_DROP_EARLY_DROP_ENQUEUE =3D 1,
> > +     __TCA_DUALPI2_DROP_EARLY_MAX,
> > +};
> > +#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)
> > +
> > +enum tc_dualpi2_ecn_mask {
> > +     TCA_DUALPI2_ECN_MASK_L4S_ECT =3D 1,
> > +     TCA_DUALPI2_ECN_MASK_CLA_ECT =3D 2,
> > +     TCA_DUALPI2_ECN_MASK_ANY_ECT =3D 3,
> > +     __TCA_DUALPI2_ECN_MASK_MAX,
> > +};
> > +#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)
> > +
> > +enum tc_dualpi2_split_gso {
> > +     TCA_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO =3D 0,
> > +     TCA_DUALPI2_SPLIT_GSO_SPLIT_GSO =3D 1,
> > +     __TCA_DUALPI2_SPLIT_GSO_MAX,
> > +};
> > +#define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)
>=20
> Looks like you fixed the type name but not the entry names :( Once again,=
 TCA_ stands for TC Attribute. These are not attribute IDs but values. YNL =
will expect them to be prefixed with TC_DUALPI2, for example:
>=20
> static const char * const tc_dualpi2_ecn_mask_strmap[] =3D {
>         [TC_DUALPI2_ECN_MASK_L4S_ECT] =3D "l4s-ect",
>         [TC_DUALPI2_ECN_MASK_CLA_ECT] =3D "cla-ect",
>         [TC_DUALPI2_ECN_MASK_ANY_ECT] =3D "any-ect", };
>=20
> Only the last enum you're adding in this file, which defines the attribut=
es IDs should use the TCA_ prefix.

Thanks for feedback.
May I ask is it fine if I put the enum like below?

enum tc_dualpi2_drop_overload {
       TC_DUALPI2_DROP_OVERLOAD_OVERFLOW =3D 0,
       TC_DUALPI2_DROP_OVERLOAD_DROP =3D 1,
       __TCA_DUALPI2_DROP_OVERLOAD_MAX,
};
#define TCA_DUALPI2_DROP_OVERLOAD_MAX (__TCA_DUALPI2_DROP_OVERLOAD_MAX - 1)

enum tc_dualpi2_drop_early {
       TC_DUALPI2_DROP_EARLY_DROP_DEQUEUE =3D 0,
       TC_DUALPI2_DROP_EARLY_DROP_ENQUEUE =3D 1,
       __TCA_DUALPI2_DROP_EARLY_MAX,
};
#define TCA_DUALPI2_DROP_EARLY_MAX (__TCA_DUALPI2_DROP_EARLY_MAX - 1)

enum tc_dualpi2_ecn_mask {
       TC_DUALPI2_ECN_MASK_L4S_ECT =3D 1,
       TC_DUALPI2_ECN_MASK_CLA_ECT =3D 2,
       TC_DUALPI2_ECN_MASK_ANY_ECT =3D 3,
       __TCA_DUALPI2_ECN_MASK_MAX,
};
#define TCA_DUALPI2_ECN_MASK_MAX (__TCA_DUALPI2_ECN_MASK_MAX - 1)

enum tc_dualpi2_split_gso {
       TC_DUALPI2_SPLIT_GSO_NO_SPLIT_GSO =3D 0,
       TC_DUALPI2_SPLIT_GSO_SPLIT_GSO =3D 1,
       __TCA_DUALPI2_SPLIT_GSO_MAX,
};
#define TCA_DUALPI2_SPLIT_GSO_MAX (__TCA_DUALPI2_SPLIT_GSO_MAX - 1)
=20
=20
And shall such change also been applied to Dualpi2 attributes below? As the=
se are more attribute-like, so I assume no.

enum {
        TCA_DUALPI2_UNSPEC,
        TCA_DUALPI2_LIMIT,              /* Packets */
        TCA_DUALPI2_MEMORY_LIMIT,       /* Bytes */
        TCA_DUALPI2_TARGET,             /* us */
        TCA_DUALPI2_TUPDATE,            /* us */
        TCA_DUALPI2_ALPHA,              /* Hz scaled up by 256 */
        TCA_DUALPI2_BETA,               /* Hz scaled up by 256 */
        TCA_DUALPI2_STEP_THRESH_PKTS,   /* Step threshold in packets */
        TCA_DUALPI2_STEP_THRESH_US,     /* Step threshold in microseconds *=
/
        TCA_DUALPI2_MIN_QLEN_STEP,      /* Minimum qlen to apply STEP_THRES=
H */
        TCA_DUALPI2_COUPLING,           /* Coupling factor between queues *=
/
        TCA_DUALPI2_DROP_OVERLOAD,      /* Whether to drop on overload */
        TCA_DUALPI2_DROP_EARLY,         /* Whether to drop on enqueue */
        TCA_DUALPI2_C_PROTECTION,       /* Percentage */
        TCA_DUALPI2_ECN_MASK,           /* L4S queue classification mask */
        TCA_DUALPI2_SPLIT_GSO,          /* Split GSO packets at enqueue */
        TCA_DUALPI2_PAD,
        __TCA_DUALPI2_MAX
};

#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)

