Return-Path: <linux-kselftest+bounces-38234-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D52AB19DA5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 10:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DECD1899871
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Aug 2025 08:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3321E9B22;
	Mon,  4 Aug 2025 08:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="aiYMcBQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010065.outbound.protection.outlook.com [52.101.69.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08CB7464;
	Mon,  4 Aug 2025 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296289; cv=fail; b=b2uSFLUyrFd0+vLJysxls2wzE0ZtRtFjE8eZY7bi42nF5GTTx4g7XaW8E0iOgTb8YcV0IQS2vQbyMbdlTOUWuF1uOXc+pb/hjbR84X2GjmQWc0QZuMF1s8SnwHItFSQ8gcHHtgqML1N7AA6ZWETot2XhpqQoqsrmCAHuRORg2f4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296289; c=relaxed/simple;
	bh=Z5Q19tCBjJrcsgUC+mR/tlxYVzIjUFnnGSgfYIiznMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QDOJrk5ZkQlV/nUL7GC3iZCzpj0xvHt0aBmK0frB1awZ7YTQT1Yd1XWixqBf218/kf4p1az/xy37IlZi1cinpwKW+hI9KtCScSkBpZJOdmqNgrK/QoG9Str1nKvLIlTFOGRY1/Zw3Mf3hxVfizU5sJoA2FN/327zLmSyFBXrq14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=aiYMcBQ/; arc=fail smtp.client-ip=52.101.69.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gd1ubRT0LwbnmURGBBI6q7cq18nnzq13K+22LpZ+pSN9emyS7+ZLsnHhVQsLxc1J5peKaLgJBR26rXU4OMFmRvqlii/6mSsKITEPn+tBTkTeQhQVJ5jmfNgY2C6NWllPMw/YiKR0Z9OaQ4hFcZ2LBLPx8l+BcIn0ppASolU3Zc4MUUMRLpbP3swN9ujj5tyUEaUyhuHr8AFrxc/JE5Tjvk4e5r3NohaK5tKPQyCVNvHl/Ms70dW301iOvIPBQVEaShgYTtQkdKNKDozf1Kb3QAc2762jTMLNoV0tDPjzL2b0/s4MuzjX8v8aWMoskqYm4eKjp7CB6e+Zpe2asVAIhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRKKFGp8mtpXGxbs4CktolQyl2v/zY/7YLz7AtyJHig=;
 b=EkhCJTE443GGO3VnP2nCXRlLi4DZWPJ0jw6IHn2Xpevr+7CwWm1QULDnYRX5PVQP5Sf4ZyTWq9qJrScRlfkufFb5G25LQ9Vnl7CmXpR71IxpFE3cs63f0jtdrI6EhslyJVes6eJFN5G2OqJTTCGOzqybYhc7RPNgVxocvVXHDcjXRYx2N8/kb6/1W9Qxx/nWnEvq3gctkuWxOHFuJjbj21tRBZJnSaPWVA64HwKcayDn41StYXDbCEfIS5Jcp7fIL1mLI7Wq90druCBi3htYo84ypSARJdb9XP58F1C4w4MDJ/pNxfv9PC5KsvRy50CMKpe8EZoiGUXfQS7vR5reww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRKKFGp8mtpXGxbs4CktolQyl2v/zY/7YLz7AtyJHig=;
 b=aiYMcBQ/X2TQq6tg6Nih10XYtWfMv8nuRR7fhrOW5Lc5sPStTC2p86Y56PmPOfz6vVV92CMpNjFYj8/8QTW5chCWQNrm9QNmY50GIS1qCiVvlx4j1hBcBF+md3SbTdxwEUKqW6fUvsy9vqgTPI6kHQhx4aaXP+QbCo+VdjspiOrxOHUxX1hM0L0Y+1OnRnbdV4fNapsgs1e8RwORSj3P04VpFIXJXbon8vNzGXG4YHAFYl05kbwNl8pc/G13VXfy806XbXCWd9g0xKSFdmC6VxWE9ftWvGoU5Q6dbGwWdtkuxaav/47ZD7Gu6SLpp51jb+YVgy1LjBUj38nS1tunJA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9954.eurprd07.prod.outlook.com (2603:10a6:10:4cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:31:22 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 08:31:22 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: David Ahern <dsahern@kernel.org>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "xandfury@gmail.com" <xandfury@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
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
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
CC: Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: RE: [PATCH v11 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Topic: [PATCH v11 iproute2-next 1/1] tc: add dualpi2 scheduler module
Thread-Index: AQHb93HkgB2gTiGCxEiMMdi2lG3SvrRJ1tSAgAhuMTA=
Date: Mon, 4 Aug 2025 08:31:21 +0000
Message-ID:
 <PAXPR07MB7984749932F11F883982B4C2A323A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250717232357.69185-1-chia-yu.chang@nokia-bell-labs.com>
 <20250717232357.69185-2-chia-yu.chang@nokia-bell-labs.com>
 <ad4c6ff2-afd3-48ce-b55b-c9ea51168c79@kernel.org>
In-Reply-To: <ad4c6ff2-afd3-48ce-b55b-c9ea51168c79@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9954:EE_
x-ms-office365-filtering-correlation-id: e9d6fd8b-af1b-481c-e479-08ddd3314ae0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RgEQn+TE5Yjfsl88LpPbBrdfxZEqpRhR37LNBfoQ3zN1GA5kcAOE/auRYFcH?=
 =?us-ascii?Q?kpzVGpN0OJbeMID6NCas9mPb+qDQS0JSXaLCGirDdupoeGNpg70FUyVbPMaT?=
 =?us-ascii?Q?JfU419SRgerYRyXnHkLviQShVEhFn7wyZBrsHB7YiuxEi5n579czbyGtE/Bl?=
 =?us-ascii?Q?IXNXuxrxR5XZyxFibhE3X3Ydm55Pp0lweMV7v4FrVmHJC5MPlvwQ0wyMRORD?=
 =?us-ascii?Q?9/K3fw6VMQWflTdDJtVAv+xemFZH5FLEJmOJOjQrmkSgM3rYQRF65JkyHKFk?=
 =?us-ascii?Q?6OzQXsoF2l/6daBnz8BI0kkhkYjuRy4vX78Mu9Ool8RAmMfD5Fev7vwF5XIR?=
 =?us-ascii?Q?WNbk2T+mX3a23KcrL15MpTNHaoIjms3FJN3jdkM4gtAzFL5wdieIWRqzyfgA?=
 =?us-ascii?Q?t3L3EZJdBeHcYHnzxcYiPEb08oCqPixCFw8fBTZf4TKmBssThmXW54y7EMGT?=
 =?us-ascii?Q?NUN8dFYKwHsEHgHhXUx1jSMI9JkHDNQBOU4g1ajbrDD/MponqrWbYehbVY5n?=
 =?us-ascii?Q?1aQ0suNbJyL6OkQOV3FjKI59igXjNdzd81Oy7dw5UP66HjY9OiIHlf8LpTvC?=
 =?us-ascii?Q?e7GDWRZIplZE1q9WAymHhKqVOcG7qXFwKorMO8ZVSzcYLkXhk733MRrThN/Q?=
 =?us-ascii?Q?YU/AjhVbYVcmo43/tmuSFzjS9Ah4IXqWGAP0uh5ccYz1ZqT5BlPc/hqOOS5R?=
 =?us-ascii?Q?BCb/1hj+IAYTw7LurJUSp0q2KXTVTByesOteb6Yo5kYEKLjIUuNr4UGp7nUK?=
 =?us-ascii?Q?ADDwQcx/1WeIdrVvG6MOCilRMQnf+Au6SD5SWrDAfFkNArVttYnIH5hJmUF8?=
 =?us-ascii?Q?AdGmZ5rUVUKSAyyaO6JDjq0qmhT1dTDGI/3mwhNCxMsyW/Sz3xBP4q6IMJwe?=
 =?us-ascii?Q?ldTD7/ivl9UOcqHd7fdILmuGv7pb8Jn6x6AdIrZXKo+BtmByZ17keRVyy/Dj?=
 =?us-ascii?Q?Ljd8JysCb+B/PdZm40Wj9dECMUcHcJCVQ8fnyNzdPD9te3u6KF31Joz17ADU?=
 =?us-ascii?Q?//qY45Rnq7Z/wGyxX69LBthXVse8UiqoTiJCwMPsqw6wKXnLAN3spGRrtEiD?=
 =?us-ascii?Q?EmObF2X3GCfrxpBqtCvY37hSqxXfCNZWBPPGQFLKxJ8KfyqHcPkGswEF14gx?=
 =?us-ascii?Q?DoSPgxRIUtG6x1Bik0t3+PQb6K5dnaZiu1Cy7LWuce57fn7fSDA52DiV/JEL?=
 =?us-ascii?Q?XEKTDmyb+rgkJZ6k0eGJHIemzLgNXVUCJjCijQfGcqKEK3BQkBLdO2mvdwYG?=
 =?us-ascii?Q?Xfg7PIIGq6r6JVgtIUK1iJWEyidJqY3LC6j0p30YrRD6joAdmuG1IcYr3qow?=
 =?us-ascii?Q?SlWbtIDQmpIAMNUBJ6fJq7qseWH2Wrs6xrsAfjaXxDjtA9VU8I2E8QhwaWqs?=
 =?us-ascii?Q?IPrfBM+ax74O6US171VFoDm/L0RKF7YChPBCVTtzAyS83Htr1HLLXIGUOFD5?=
 =?us-ascii?Q?bzgGOCsoQi0aiLFsW9L4jDsufNOJHtutkBEj39ubJjHU0R6xsaDlE1tBKLPl?=
 =?us-ascii?Q?Fvf5w38c+fwOApD3YGRTo18U2KxRQYgFyQDq?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ADXRhZsfbKSPgFXf6Z26wS3GPJQUJArcE22Zv9/8TAdBfTQnsCezuJzO42gh?=
 =?us-ascii?Q?K7ZGh6cGc9x4Tj0mLkspi2kSxRuc/Qr5cekkUlPEWx6q6C7Q2dS9WCWGCgdY?=
 =?us-ascii?Q?hvSmtv3YNgHcZkEPs0Vv2d4IEfOvjJiMm0Ko1s6qcXNOqvL5P5P0ZIu9dOKi?=
 =?us-ascii?Q?0A+x4FJUfkDlyz7qVqHqb6XRiFpmrctJMgo3HmC/oqwhL1MItsZVGQBhXV9n?=
 =?us-ascii?Q?HZ1FzPtB7RnsS2MuJhAj8ACxGPq4iALeFgZSDECR4kj17tAl5c8bWCzZcBfh?=
 =?us-ascii?Q?0DaTxtqiexEcFnF6v7QiSpce28h9fv9UNpqjSW5V2qTomXfOy8JngIkg2Mx4?=
 =?us-ascii?Q?kGT76S2gVrHvVony9NuSKQAwN0hNmiwy/Eheg0TjvV7n5ijwpd2ulH56nMqZ?=
 =?us-ascii?Q?mKVW5fPHFoT6S5fD2lbaLsNj8VcsuIn73w5LKB59+9Qt+51BJN/g39NYOCyN?=
 =?us-ascii?Q?hmD0xmtN4ePGz/PTptSucgULIRbEuX6UlV5HIvwwTqXrURpX4yIYsfV7715q?=
 =?us-ascii?Q?ga/iIScsPycC923txFNOdUpqwzKNJYDamkorBGNAzNBBZe3O3Ha7FPXX76RM?=
 =?us-ascii?Q?iy7YTjuNq8z3EJy930jQlDlYZtMjSjUHM56fI7q4VGU4chp6fdUzAgsC5KLU?=
 =?us-ascii?Q?kXj36Wqhq+QrA5g+lfa8YXkzEMTJcMIBMjjMFugCBDbro3oOEOB/Jsn7BXaE?=
 =?us-ascii?Q?zERrC4gSQe4z/xV3JIBXCHXNtIaSkU4H5yzf88j3YW009Qh2AP95rHyWXX5l?=
 =?us-ascii?Q?976Z2lhaQMkolMus1Cb+4sXOXFqOHBB6Ru1AJVMGQRJjObt7RouzZIY5Snaf?=
 =?us-ascii?Q?UWF3hr+U3VNli81IGu+weXZJyKTq2ixZC79Jvh54zEdgZcp+/XzYUAjjFwCH?=
 =?us-ascii?Q?5bcne/E31vr8S9UvtjUk1z3ut/CHtWgh72bxtHf1G00Aa50wtD1f1vLYEaE/?=
 =?us-ascii?Q?YsLudV4gI1cOYFqzBIFaQOLVaI9U0Ie57faB6ttMmFjK6y/d+2YRZ1Ly58+m?=
 =?us-ascii?Q?G9HSPKP4rL96WurfeZhwZXdO4yUtk8TVSeiwkzvbveSvYwBY3NBGjbTnhHbH?=
 =?us-ascii?Q?pXuKuMOSxWizQWJ4jcBsxJbSKAcFqv+vW3REySXbJdZxyvRHD61JULvlyfgB?=
 =?us-ascii?Q?AsIYyg6p5e+2Pd0KxnaVdy9u9vulDGnzG3ac2YViRbCNoLIsSXUzJJSBPLlh?=
 =?us-ascii?Q?TzOvaIVVa80eo5yxGCRQXFxbyAONC4EC9Ewv2wQG98AgafpS2lQItatFIQM4?=
 =?us-ascii?Q?iWyRcChm4J2cUFN49vbsgzAWU+2gjcKtPj5Plz54w0nAvBqwKshk1jRT0MHA?=
 =?us-ascii?Q?OPpYRFm4ibXxWaXs8fLvk7Qz/KXIQAyQh4SDjht+gEJkhrs6jRSzLoL01ceq?=
 =?us-ascii?Q?G3S1QWL0tyjqjF3xqSwXodDDftgfI+sVbuyojUzX2I728LHUU6AFqVtxfj29?=
 =?us-ascii?Q?teLJpwloxTYYODKLyR8aLVd9+DtuNu6e1lZ7tp7nHmoTj7F6/Vsxn6uidSua?=
 =?us-ascii?Q?m3PceYhgzmYVVopMtSJvogZQaCJSX1k5qVe8sl+Uq+rfNlfpyRIxMbcq0jXk?=
 =?us-ascii?Q?Q2P3QmDjkVuC3A5GBgbwSgPupt95rTup3KHAKwyKXAEZZBBPUCdT1Bhlk9GA?=
 =?us-ascii?Q?Wg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d6fd8b-af1b-481c-e479-08ddd3314ae0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2025 08:31:21.9374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5nE7NCOcp50FDy4e72f36d/DS8aG9wNpvEJm6jMVwK4HVUK90urrgHldN7XqOABHOzIYnJQpTrqv0Nb62vkIjidJFm9zn/n1QsX9a9Twm5g+YyQJpz1C0NgP6qzhdT04
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9954

> -----Original Message-----
> From: David Ahern <dsahern@kernel.org>=20
> Sent: Wednesday, July 30, 2025 1:45 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; alok.a.tiw=
ari@oracle.com; donald.hunter@gmail.com; xandfury@gmail.com; netdev@vger.ke=
rnel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; kuba@ke=
rnel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnul=
li.us; davem@davemloft.net; edumazet@google.com; horms@kernel.org; andrew+n=
etdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; lin=
ux-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De =
Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.=
com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; chesh=
ire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel@appl=
e.com
> Cc: Olga Albisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.t=
ilmans@nokia.com>; Bob Briscoe <research@bobbriscoe.net>; Henrik Steen <hen=
rist@henrist.net>
> Subject: Re: [PATCH v11 iproute2-next 1/1] tc: add dualpi2 scheduler modu=
le
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 7/17/25 5:23 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > diff --git a/include/uapi/linux/pkt_sched.h=20
> > b/include/uapi/linux/pkt_sched.h index 958d9407..15d1a37a 100644
> > --- a/include/uapi/linux/pkt_sched.h
> > +++ b/include/uapi/linux/pkt_sched.h
>=20
> you can drop the uapi changes.

Hi,

Sorry for the late reply, this will be done along with the following two re=
quests.

>=20
[...]=20
> > --git a/lib/utils.c b/lib/utils.c index 706e93c3..dd242d4d 100644
> > --- a/lib/utils.c
> > +++ b/lib/utils.c
> > @@ -220,6 +220,36 @@ int get_unsigned(unsigned int *val, const char *ar=
g, int base)
> >       return 0;
> >  }
> >
> > +int get_float(float *val, const char *arg) {
> > +     float res;
> > +     char *ptr;
> > +
> > +     if (!arg || !*arg)
> > +             return -1;
> > +     res =3D strtof(arg, &ptr);
> > +     if (!ptr || ptr =3D=3D arg || *ptr)
> > +             return -1;
> > +     *val =3D res;
> > +     return 0;
> > +}
>=20
> Put the move of get_float in a standlone patch indicating it is a code mo=
ve.
>=20
>=20
> > +
> > +int get_float_min_max(float *val, const char *arg, float min, float=20
> > +max) {
> > +     float res;
> > +     char *ptr;
> > +
> > +     if (!arg || !*arg)
> > +             return -1;
> > +     res =3D strtof(arg, &ptr);
> > +     if (!ptr || ptr =3D=3D arg || *ptr)
> > +             return -1;
> > +     if (res < min || res > max)
> > +             return -1;
> > +     *val =3D res;
> > +     return 0;
> > +}
> > +
> >  /*
> >   * get_time_rtt is "translated" from a similar routine "get_time" in
> >   * tc_util.c.  We don't use the exact same routine because tc passes
>=20
> Add get_float_min_max in a standalone patch.
>=20
>=20
>=20
> > diff --git a/tc/q_dualpi2.c b/tc/q_dualpi2.c new file mode 100644=20
> > index 00000000..50d52aad
> > --- /dev/null
> > +++ b/tc/q_dualpi2.c
> > @@ -0,0 +1,528 @@
[...]
> > +
> > +static int get_packets(uint32_t *val, const char *arg) {
> > +     unsigned long res;
> > +     char *ptr;
> > +
> > +     if (!arg || !*arg)
> > +             return -1;
> > +     res =3D strtoul(arg, &ptr, 10);
> > +     if (!ptr || ptr =3D=3D arg ||
> > +         !(matches(ptr, "pkts") =3D=3D 0 || matches(ptr, "packets") =
=3D=3D=20
> > + 0))
>=20
> we are not allowing any more uses of "matches".

Then, is it allowed to use strncmp iteratively?

Or any other suggested function could be used?

>=20
>=20
> > +             return -1;
> > +     if (res =3D=3D ULONG_MAX && errno =3D=3D ERANGE)
> > +             return -1;
> > +     if (res > 0xFFFFFFFFUL)
> > +             return -1;
> > +     *val =3D res;
> > +
> > +     return 0;
> > +}
[...]
> > +static int dualpi2_parse_opt(const struct qdisc_util *qu, int argc,
> > +                          char **argv, struct nlmsghdr *n, const char=
=20
> > +*dev) {
> > +     uint32_t limit =3D 0;
> > +     uint32_t memory_limit =3D 0;
> > +     uint32_t target =3D 0;
> > +     uint32_t tupdate =3D 0;
> > +     uint32_t alpha =3D DEFAULT_ALPHA_BETA;
> > +     uint32_t beta =3D DEFAULT_ALPHA_BETA;
> > +     int32_t coupling_factor =3D -1;
> > +     uint8_t ecn_mask =3D 0;
> > +     int step_unit =3D __TCA_DUALPI2_MAX;
> > +     uint32_t step_thresh =3D 0;
> > +     uint32_t min_qlen_step =3D  0;
> > +     bool set_min_qlen_step =3D false;
> > +     int c_protection =3D -1;
> > +     uint8_t drop_early =3D __TCA_DUALPI2_DROP_EARLY_MAX;
> > +     uint8_t drop_overload =3D __TCA_DUALPI2_DROP_OVERLOAD_MAX;
> > +     uint8_t split_gso =3D __TCA_DUALPI2_SPLIT_GSO_MAX;
> > +     uint32_t rtt_max =3D 0;
> > +     uint32_t rtt_typ =3D 0;
> > +     struct rtattr *tail;
>=20
> iproute2 follows kernel coding standards and netdev's preference for reve=
rse xmas tree listing of variables.

Sure, I will take correspondence course of actions.

Chia-Yu


