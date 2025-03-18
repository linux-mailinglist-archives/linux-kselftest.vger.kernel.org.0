Return-Path: <linux-kselftest+bounces-29352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9C2A67467
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 13:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65DC417C8EA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB67920CCC5;
	Tue, 18 Mar 2025 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="iW0X5ywP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C120C48D;
	Tue, 18 Mar 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302568; cv=fail; b=kyUAw3woeCpxeIHtMtTWmlTSdfhrlQRcHbW5uh2I7P9y0q1lySiY4YNCULpCMMy68XAu1KKpPLu1AUawRABgoZqyvAf5+Gix9L44T4BRnEMdYb3Mkks2+ieuAPEZWWlOU7IpJTslabLq4myClpN6j8gJWRrIk+afB9SMuI7P6wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302568; c=relaxed/simple;
	bh=Q2nmtzUJqZD1f0kGfyNgnknQGDjCbaUVbDuJy26gluc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pylg8Do9AZmq23sdlhZYzxeKNs9t6HTfKmy19nzgJfvwvpL+Az9KvDh8sLkBcyxeVz+cKw12WHN+ebCBt0nPxLaLHQXLFQt0+t22vFzmEW2KwERspFP0RLupBLy4jwuGeY/T1c1sUMe5N497sadJb+5FJmZksCOQ5cHGnrMq15k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=iW0X5ywP; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swmzoKPXaCVJSbvJpHgnoRV+ftIhNCt8irxvEW1mJOYoiiXTylyip5/qDcWjp9uOvHFxZUPeaRo0gZL0bUoUA+F0+i7i7+lyktHdwU2ormPBd8JbquVksWc2OgmMo2XVDotg2Xbn4/rFFsWA8b6YVc5zF9rE631bsrAH4i1HlKNPGlblmDvI5GFhfNYoWl0obSHvzruXMXdHkJuC12P3lTcrZbuxe6R3Dmj6JuUhrtMW6KnSNWrIk37WoBW4Kwa4pOs3eDQlnajGqN2FWtWAaw6hFEQ35/3H8v30ZPTdUxLQ/EFDBDjEPP4yXe18cL1E9UMUpb/AS9MKWRkyaNGMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeBYEsj4BYYPmS7ov+Ez23URRG6nasblVrYK3Q60UGE=;
 b=J7ctUR023c/LHAW0DfYC8nG2q+534zpMwNPGl4CAq6sje0idLWEqpunJH7qTdY4mfsSgJOu2sYp4C0UpH9Gis1jxjNSExTXdjPTEmyaRD+qWci+zFmdMn/DmNvO0smoApsydvG46UruaRV38Qid1U6bijnAV/lq0ABZ8OTQfNaErDIKYfqCjlBVf0oRKvhWaVDEfX5/hA7hqYhPAOIAJdQ0ml85QcU+1qvgUXCId0uQoBj8Z6qHrxx6E7sg62yu/fg+GQZB3EnOewkVMDKQ3UQ8tVQcigY2cR9UPQD6U/pxEdlUYIDrLSB5D2w8ClLRvnHC/truPFepPwTzUASY4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeBYEsj4BYYPmS7ov+Ez23URRG6nasblVrYK3Q60UGE=;
 b=iW0X5ywPdN1cMv27gt78Rmsz2flR+/w0Lc8FoCUp2NYNZRMdtvWNEcrF0efeWGNiQYg68pdrZBDr96tjevay6TTeTADWjNksfVpXxMzdUpqLv5sodXrgmP6851f+x2t8YeOr8z8z40k50fGSDW5S7pCMtx5eAVKnywpcvvEG/A5pzM2HJy9KHdaRagsrd489EfWMmzF7rmwO4jQx2aitbxTmKFTsUJJulahUl4skhyt9R9CW/Aiv20kiiQkIBsshrJZ+c0AqVmtrcSuWPh86d0INIv0gOVQpam63LZS5zsVdz5xJu/h1tS/fUvvccGJO7vo0jpRkLBA76vMTVv6B1g==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7941.eurprd07.prod.outlook.com (2603:10a6:20b:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:55:59 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:55:59 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>, Olga Albisser <olga@albisser.org>, "Olivier Tilmans
 (Nokia)" <olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>,
	Henrik Steen <henrist@henrist.net>
Subject: RE: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Topic: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Index: AQHblomz65WqQmgTSEiGQj+R5VbIwrN3Vg4AgAGG1TA=
Date: Tue, 18 Mar 2025 12:55:59 +0000
Message-ID:
 <PAXPR07MB7984C846DD3CB85405B408A2A3DE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
 <20250317063620.30d24269@hermes.local>
In-Reply-To: <20250317063620.30d24269@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7941:EE_
x-ms-office365-filtering-correlation-id: 3a0a18c1-d042-40f2-6bcc-08dd661c3b0b
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+LKZMKOgiu9GF0DDMfzYZDoTcnZLFCbF70JnX+vpRJGLjaAYMWYmwaYbAwlf?=
 =?us-ascii?Q?YRXJmaN8DJXz3Tb5fMcSmCTDsswH9c7HFz4JEx8KiXLM3zTbEIGc0sey610s?=
 =?us-ascii?Q?RY9vGqi06dQiUxHyG1bDw1tR0S1JwtQKN7QKLXyyJmctao80xd066wiJFLY9?=
 =?us-ascii?Q?yA7FNdEDZkfmZIdBI/Jlr4k+ZiJbj4/2tueL52eqMkxL925xztA7TkwuwyjY?=
 =?us-ascii?Q?THN/2cZUMEPoolfLgW587H7FL+B+ktScmodILKhlltafMAnA2n6zH4XOJCjs?=
 =?us-ascii?Q?DrhhPG8NL0KukeRPpIv+SgGDnFVrxiq2Mnw7HJJM/EdzN9Ybhk94eMdJN9E6?=
 =?us-ascii?Q?W/9WJAeWnSnMM0WdHGcZZfmLmG9wozbxQEang2a6ZRyVbXlGFHxUdhmLqVS9?=
 =?us-ascii?Q?EW0o41oevNosaUkUkAkO5ANN3/CMdDUyro0KnTHGp7leskLXz5D4uLU3uWZ9?=
 =?us-ascii?Q?ioOxcOwWaxm+82cu2d3O869kYh3BvCTus4iTvLMu+oD0LknousAMzw7JLwy1?=
 =?us-ascii?Q?jp527dwY0sClR1PRKtb5fVdu+E2e1zQhihIdekupI2m5zqKRR74QNKURkQrk?=
 =?us-ascii?Q?+MEruW8fQnzlISEX8bxn2sZMJca+n+2HWRFuXg2zAWVQV2Tfk1XTND7kU9SO?=
 =?us-ascii?Q?aFdTqk2PN7L4MJxdRwx4NgJ7XWf/OfFohGJw9B2dViquIKOHBsEfxvpgf2GQ?=
 =?us-ascii?Q?sz21U1n9qPcnrmWGPmIXyT/5yuY2l2lerDPcepMr1otLoMLcx+7X2Q0ebSHD?=
 =?us-ascii?Q?2uF5T4EGlMqPC38atkSBdkC3TYssJq1K9MGy9+qFSilF+x008PHZ1PvMpPrz?=
 =?us-ascii?Q?ZRoslVYjavYIZVzJEbItBaWAZnbiAcF2rzX3JRtiAHiOB50/eWUIjiUbsSVN?=
 =?us-ascii?Q?bTn1DQuP2qCdheMlsMu4gmSfRjSUtIEBYTf+xWNyvcFretcEbZXpPaHjvrkq?=
 =?us-ascii?Q?s9FmEHtJiKTz/eBbpp729UJJwBK2nWHoHW2Xo8huu4EmMgdilmiJZZ9qAiLJ?=
 =?us-ascii?Q?z1ipHQfrHW/c3XPp0R+nPrhTmzyPeTWTngYD2I6LEnT1pkhz3GzoLV2GsJiS?=
 =?us-ascii?Q?JxDZogVVvsWTFMLydd0B4AKvO09VSecUKf8f685kMawzQ+PCzB5I7b87jygM?=
 =?us-ascii?Q?mw0D7r8zR70sLyMwx66kw+D0F+z7GoG09YZ24Tg0UQqQelWSPUDVJgAMN+82?=
 =?us-ascii?Q?3sPf/pC5Y6hcWAEupDOCOv0k5/ngDKK4SM6KYfb0PRtyempqO5I81mS7OBFo?=
 =?us-ascii?Q?ZsXWAbW8H5pd20tmbGK/oixRIx1oK1C0FB0FsKi55SVh7AbzyNEIetHJ5I3E?=
 =?us-ascii?Q?sKdgsQEqAnyeKMb6vOkC7gSOlnAqp6wa4vJ2mjHbZZ8MGfS4KwZeh/NVd1jG?=
 =?us-ascii?Q?z5VLC4/DrjF7CZHrfT2eMlZZR3XnDlyRO4wPIn8QZVMo0BVmDpIYnU18yLcp?=
 =?us-ascii?Q?zwGr1PqprZCwSbWPmYa0d+OoLAo/MHzs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?onIniz6b2Ih3vY7M3/amxdDBb+hT9qe3+fClrp0nwtqkaw9FFnvwArzF+skM?=
 =?us-ascii?Q?mf6zpUF37liC0Ysf1IypVZE26VjuTf88qboFp54Dk8h4jZX/scvK2ROtJeoW?=
 =?us-ascii?Q?4DlNAtTjRd7a+2Hgslc65PZNcDgHIorK5n+xZ8o6WgRmSfizVaty3GZVX/uK?=
 =?us-ascii?Q?+rOg1/OYhXw04euYZL6RNOllDyph8nc+1GOI1EKf+5UBW2O8sM3HDd5JOwG7?=
 =?us-ascii?Q?+wSf43dfbDEb1s9T/cKfPSBWLQL5zAigzIfC7pe+gjcqw6N0PoBUrokn/w5T?=
 =?us-ascii?Q?cJH1KiMuMq7qyGNbl4LtCnXNW3Tl6A7PbrSb01nkYRA7BpsmJUimOqPE6NhH?=
 =?us-ascii?Q?g8cChI0kNJM3aByGvfqbiJar0UQ+5DnQT+hSPLe7o4JfFGLbVIzJDiji4+pr?=
 =?us-ascii?Q?/AlhncmlCUJJV6M9zjD1x1oSnmigxs99LTxP21wUR7ud3iByJJPyivMqSczS?=
 =?us-ascii?Q?XqpO2IOWBWGZciZeLV2QKiElD34cbvOegfv1iey3IWK0jUDbxikltjwoZAOn?=
 =?us-ascii?Q?pcP6bp7uSZ2ZNB0QqbCk/h6SYbP0C+jBuoa2iIpJy0a4Z3+HeLS4ykeGswB0?=
 =?us-ascii?Q?6uKrXbBOiv5apxcplrAyyLB2VWKJGgDu/T8V9DJf1AaiMWLf9A1kM4nmZ2WL?=
 =?us-ascii?Q?9tYJFbLBvStcFNVsPof5S97MOYd+5OY4/8qzwmNoK2DGtkTmm7kd6G2QkKWJ?=
 =?us-ascii?Q?gimDCYvLLWCcNwtN0TCDBlBPlGnA6ZrRJf8lnGmnnJF5iG4sAhg0rlHjBuu9?=
 =?us-ascii?Q?XaU41b4pWblRWYwDwLwmOyEyKMtchiYQfcOP6xQUU78iS9nLHPKbM6jLFwt8?=
 =?us-ascii?Q?lyT4mTuS2h3eqAmyNf3SVrrgdYjMvnm8wIoGiuLHW1ONq1ntAQR88i2ywZci?=
 =?us-ascii?Q?E32CibFiHZb1DKJzI0/H3HNlWRRgqegNNR/a8T+Wga8EAa5c2DA7fdxc830R?=
 =?us-ascii?Q?ci0LF2LMqpokTXa4xzg60aM6m58ERnQcyZfQ/cRn+TC+C8svXui9usW+rxfG?=
 =?us-ascii?Q?nOwdLEIklsnq+eGsvlnKtrog5hYz+VX7t/3R0xpHX87H2MfLvOOwtKfcn2mo?=
 =?us-ascii?Q?OrnPs9tG9cqaUWkRc1nC/XycskWTS3hWebvwLxRYxbDyPWS2AoVFD9gqHT+9?=
 =?us-ascii?Q?GUnPcjmkSNo15sDr1lpJMsiFNXXtE3tDFEhU4cBwqBiwTOd2w2BiD8hhHU4i?=
 =?us-ascii?Q?xvWUYFP6My5iG+c+MU6cEHVZ1Sf1GVloFd/yGJq4lcx4qKILFgumgSW6vAUU?=
 =?us-ascii?Q?T9Gjg7qBV/MlANQDLY36bPKB9zuOKseKweBWmYXIrSo0gLtAiHlmyk2ROh0a?=
 =?us-ascii?Q?fUXXdAc00U5im4C5iaWt2TPJmBBpQGV2MHAX/MUqoq9Id161M8Vs6OzT/Zoj?=
 =?us-ascii?Q?j7I6AsGNyE9HmrYwZpd8JhPLNqoqLRD5UDYtRo5d82TCrfc7ibUyV2yTLVVq?=
 =?us-ascii?Q?JAGd1o2rlt9bTXJ0fsf7YOXWG4RlQkg4068j7UUy9Z1QwvXxSVshq1GxWDjG?=
 =?us-ascii?Q?xf/WU2MUZT901oXbXdWywSI/WXroAk+k9CfPykHUhaa+x9tvLAmrDMoepmei?=
 =?us-ascii?Q?Q4ZFxhPkmiKgl5nSFsD0ceijbWYacB0dlySYyixHmugPZcIwy/aTmv7tS+9e?=
 =?us-ascii?Q?8qTcgb5aslBWTkkWqgbR1sU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0a18c1-d042-40f2-6bcc-08dd661c3b0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:55:59.1748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qN09DYGaGMTCSnbZHvGJi2eWE6rponoJ4Q498sMCKHMY8fEusoTxHDy9Ck+J5Il6dWnLawnCLxuPNOpOXICx1EiD1XeDjlhYZm7nyB0dOkME18oqHbGa8317BO+eIlp0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7941

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>=20
> Sent: Monday, March 17, 2025 2:36 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: netdev@vger.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@m=
ojatatu.com; kuba@kernel.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; d=
avem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+netdev@lu=
nn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shua=
h@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@goo=
gle.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g=
.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.com; mirja.kue=
hlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@c=
omcast.com; vidhi_goel <vidhi_goel@apple.com>; Olga Albisser <olga@albisser=
.org>; Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>; Bob Briscoe <re=
search@bobbriscoe.net>; Henrik Steen <henrist@henrist.net>
> Subject: Re: [PATCH v4 iproute2-next 1/1] tc: add dualpi2 scheduler modul=
e
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 16 Mar 2025 16:39:17 +0100
> chia-yu.chang@nokia-bell-labs.com wrote:
>=20
> > +static int dualpi2_print_xstats(struct qdisc_util *qu, FILE *f,
> > +                         struct rtattr *xstats) {
> > +     struct tc_dualpi2_xstats *st;
> > +
> > +     if (xstats =3D=3D NULL)
> > +             return 0;
> > +
> > +     if (RTA_PAYLOAD(xstats) < sizeof(*st))
> > +             return -1;
> > +
> > +     st =3D RTA_DATA(xstats);
> > +     fprintf(f, "prob %f delay_c %uus delay_l %uus\n",
> > +             (double)st->prob / (double)MAX_PROB, st->delay_c, st->del=
ay_l);
> > +     fprintf(f, "pkts_in_c %u pkts_in_l %u maxq %u\n",
> > +             st->packets_in_c, st->packets_in_l, st->maxq);
> > +     fprintf(f, "ecn_mark %u step_marks %u\n", st->ecn_mark, st->step_=
marks);
> > +     fprintf(f, "credit %d (%c)\n", st->credit, st->credit > 0 ? 'C' :=
 'L');
> > +     fprintf(f, "memory used %u (max %u) of memory limit %u\n",
> > +             st->memory_used, st->max_memory_used, st->memory_limit);
> > +     return 0;
> > +
>=20
> You should support JSON for the stats as well.

Sure, will do that in the next version.

