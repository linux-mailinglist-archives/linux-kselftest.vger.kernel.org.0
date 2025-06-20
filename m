Return-Path: <linux-kselftest+bounces-35413-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FDEAE16CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 10:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961613B77A8
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 08:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6983277CB7;
	Fri, 20 Jun 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="kE+QAt88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012005.outbound.protection.outlook.com [52.101.71.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3162B24EF96;
	Fri, 20 Jun 2025 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750409871; cv=fail; b=LoZgWQH/LheqxRoY4LNhBYhNSLZcQxdr4dgntpOIOX5TXcu/rmCQCuyLKUZ/O37cElp17oVatJqsF872qdUiX7TvsPmy1zPcKiMZVlJ6Pc3BPWe2qY6V1WibZy+ikEaZ3YlCiN9Cty3W3BFFi2kCuDV1x1qbXYS/aUK+MoghCPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750409871; c=relaxed/simple;
	bh=rOqbby3i5K+gmkrwpiuNfa/FgkgqrLlN4YP+tPoYFCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASq+SxBrp7rbnqQH//Fjj3QOt3vuVmmIf2FP70jDIxpVkrE+t9nTsofBRZikoCjgFubB4wIuGjqdUPviE654XIXOWmqvh2VxAm6ayaD6V67FSmYYnCkX4v/V6X9UKK9LYzRLlJYAgPqWGCLv61tyCXzvzhYeVZ3xXadcgo9+m30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=kE+QAt88; arc=fail smtp.client-ip=52.101.71.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KywZzaky+uK2jOIixO5/ndwDhN4mG4PJIViMO8UPqihrD4TEWtWzU1292mmBwEwzJXPFRUVGrfU+FeCMu/wuHG/X9VrGksPj0z1EkhWPL0jdHV6bacAwQaxTmSvqhE8yWw+OMzSi7sskeQGWTh1RBTtNnu11O5MVVT8ve/jL+Bdh1nrpfG41Yp9+F5E+x2BykpsqxyUH6K7voc4s2yxhXoxvoX+rnM8GWixBcnnDtkcFESJwerCeLIfKaM+1Bfmpt7LhAyg7i210ijVdRUjxUkqG1YIjm98AKyi55MAb+ntjMdqiuqY+9ReuoQFsZwm5IohCqT3OvJmmBZN6qS2gWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4NTUpzsMtr2riS/un60yBReQ7eeUjyuiQyY8cvJ+zQ=;
 b=kVNFjWeSmMm7KZSGUyN+sHSo2k4LFX3K7NuLTcG7q2YFNTf8CBKDdhpmUUvG6kf3tFdxspmNIijD7j0rGdzYbENkd3CG+wU2Bi4wdxBMQqKTbRoH6cB9EO3DhbU2RWQLorI4a0awzAIyXTvgol9faC0OVk34m7egR78KQvieIc/OAdP1HGyTYNc8ncSc04cElm2rXQgf7PHtdnU3jzHqvLrx/v5ZXnNid0E68EuMhzn9WHUCafjIk+k2I3FUg5tmdaIyJ/fz+F63T8KTcyBeb39MRtaBO56d2j4ADaUzKPAreBscDtpi07o2snyOm14SBfTUORNwPMimiS2pY68mmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4NTUpzsMtr2riS/un60yBReQ7eeUjyuiQyY8cvJ+zQ=;
 b=kE+QAt88gQ9ZrBFTjpqGu95rrY4IMDWO4NnVHgkr9uC2EzuK/k2LcBSr8k5Nw01mWzpcts1DkbyJPHlq1n3yO5+zVqSmeN14LCmS1j2ZTQdnQGPZKd6p+h6rB62qwFk6S9eAaP7swwEv0nlfByn/SHMEebLesT9D/3m8ViP6Al4AB0CmZsbaZIfY1Ggi+TTRsPUYV40lb4dXaIQMk9ZqId4Fye8YwUk4fbUyxBZl0MbUoINYI1o5RX4Y8rp4OH/qdnfB5lh77oY3dYzPI1eSS0AGfQ5FKNW7XMh7r4kGYMoG1MeLKJ/v/Usn9dMEjEo82f2IE7DAEK4onYrSNLznMw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7637.eurprd07.prod.outlook.com (2603:10a6:20b:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 08:57:44 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8857.020; Fri, 20 Jun 2025
 08:57:44 +0000
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
Subject: RE: [PATCH v8 net-next 04/15] tcp: AccECN core
Thread-Topic: [PATCH v8 net-next 04/15] tcp: AccECN core
Thread-Index: AQHb2gapzqCcQHBQ6EW+AwJQw56XYrQHCHoAgASxjGA=
Date: Fri, 20 Jun 2025 08:57:44 +0000
Message-ID:
 <PAXPR07MB7984C7B7A47A49FA30D24005A37CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250610125314.18557-1-chia-yu.chang@nokia-bell-labs.com>
 <20250610125314.18557-5-chia-yu.chang@nokia-bell-labs.com>
 <8ff9ee00-1bb6-4558-b2a7-c0ee59badb12@redhat.com>
In-Reply-To: <8ff9ee00-1bb6-4558-b2a7-c0ee59badb12@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7637:EE_
x-ms-office365-filtering-correlation-id: d088b9bd-405e-447f-cc3c-08ddafd8854b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?BwZ72jAw0pjDwnynYYO/i8aSBdmTQAYGRCKoGOPiSw52yVScd7qfVMGyn0?=
 =?iso-8859-1?Q?zsa4ofSDdBB38pBaEaKKe+TI1Dr/5d664iJaQXpLq/vGbMCYPNdkWeU+3s?=
 =?iso-8859-1?Q?Fnb6q60Qj1hiNznpEQaUgsO6PEYS7MN08TpRuVMJYd7QIVdEvwe6Bct31V?=
 =?iso-8859-1?Q?rpxaQ2wElKhkq2Gy4MKTcTrVEGQv4wc/WT9btWU068Kt+Zf3t1gDOpyBn3?=
 =?iso-8859-1?Q?vV3MZvrh2PrhD/PHgJUVp8eBgJfO8zbZ/QCndOx/u1kvV4nsNUpwd6nOiI?=
 =?iso-8859-1?Q?CQmoSkRQNeTE+m4FCJ9BXWzZLajk/pkTwftr3ci5mll5Rfbigd/1mYleCW?=
 =?iso-8859-1?Q?9pzGgrylv1VUGBfu5SHzziTl1vw0wVBavgjgxjOnYEV4uP6ZZ4JB4MMCOq?=
 =?iso-8859-1?Q?5CXf+JW1uaWV3LurlHiFfIaZMuaLyJM+rBjs4Nzfdx0MEtETBzJsUfdxr3?=
 =?iso-8859-1?Q?qFtnezMdLVsuNs2CwvXmElSqUBGk3INOHANuPipCja0sS+ZTk4E9CWbNkw?=
 =?iso-8859-1?Q?3ayrCxgBKR7KVt8XyOxczX3D2hDnmWnOZdEnXvK+d/mHvctX11nwk75zn9?=
 =?iso-8859-1?Q?A6my5nc6S/XNUXa4vDMXgca8jRUFlqaxqHIs44EXQ5b2IVh+1WgQjksTnK?=
 =?iso-8859-1?Q?L0SPdjspIdLp4PFubbfTnsyss4v1TXVGOxYeNCCcLuLWfRJJCYb5LVXTLC?=
 =?iso-8859-1?Q?HUcM6rr7OsvOtE4XgdUabxzpgQlWcnztnFhok1AhuyB8KY1Eca19msOe3J?=
 =?iso-8859-1?Q?gBUdcX4IvbAJTbzC01SynOwBIZ3A8jRAVq4/F5vDOwIbPknWR9usTu1QQR?=
 =?iso-8859-1?Q?1PLnn6pvQMeGfgr3Vl7HVrMSuFLTllbXdypVj8DgFejrdWG7LNLU9TV18W?=
 =?iso-8859-1?Q?5STR0YErOmiNK1Js/ve2NxmeLMLDQPVJm/C7TQG+vHZyF/sfLx7nfJ68Sb?=
 =?iso-8859-1?Q?RXgNMo25DEI2f3WNMx4tDQBjxEgCkLG00bzJ3S3wEwomHjixgNT1Gy8Ft6?=
 =?iso-8859-1?Q?EbnZeb+YyHQs47OhQZM0benw0rEru+VtH6jdbdrsAHxmUL//CXFj8onRhH?=
 =?iso-8859-1?Q?nQNUzOHMgCw+giPQT5AFEOsZ2OvLhHOLlcobeJS2C/d6OGg7heVSnftm7J?=
 =?iso-8859-1?Q?F++zQm3u5A3u2wh4rUmIEKiGRPRiyKweq/49gac0a6XZk1IZurIz/zdWSM?=
 =?iso-8859-1?Q?Mz8BGKFaltdBkHbXMOqY5S9LdstMyZXz70a7faznubxdIONo/S6R1wvsc3?=
 =?iso-8859-1?Q?ZVz5Tvg4S+IoVwUpElBLC1oW5Vi0xutu/ZZjEatLePm+2rZ2bQgwcNgigv?=
 =?iso-8859-1?Q?N1nn6nggpRG0Tz1qnr/HuyknbfDWxushtvPgWbRVC6jY8y7W3kPHrl8okU?=
 =?iso-8859-1?Q?IEWBHOSAo37hkPE3LcZs7fkajJnRnd1JtSSXlA5FKYJdNMq0XyV3b35lJl?=
 =?iso-8859-1?Q?U/5qRIlsJg7IsOShFUAoxk6junUQ1+bcDhZ3jSW+0ZpoHrkJSN422ahA0/?=
 =?iso-8859-1?Q?iGjVq5oYsUT/HeQEBC6f3r?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yeQ2CLBVcJ0u813+M8rVVzieVSAQAEZQ0PXGHMqeSDTVxhVlfQjMQ0KyQM?=
 =?iso-8859-1?Q?8qsYpVlF6q/CbCFrN/1N7dQHRq+H1ep9u1sELN/+9onlC0pp+NMWDQ1l59?=
 =?iso-8859-1?Q?WbA7o7K6dSiQBvFThcNwd70DjC8POcP44u0HvYf5/Qh4PS+JG1k3Hh+kQ/?=
 =?iso-8859-1?Q?IoUtO6EiDdP30fwi5NPWFV70hamLN8iosSgEimKZn0YdKGw3Ntx5mgG8ZG?=
 =?iso-8859-1?Q?fQ53J7NMjJTiWHuCu/sIb/RG3N0ZrKN0Vp2HVlbdp4hQ1MnpmfAEm2iF87?=
 =?iso-8859-1?Q?DnJ+yetStVrz4B0T3y3i92I4/Savnj+Y+N0XpwzB2tmIZd0eZFJFhpZk50?=
 =?iso-8859-1?Q?Gy1eZ+xF9WZI/pu8z/OiSvAoj8ZqqgZEcSlnCcvBm5FCW6na7pS479pgQI?=
 =?iso-8859-1?Q?DRFnCIPfcTUY7oM/LGo9r8xc0FGtTbgKBdj37lL0wMWa5Z1dF5ALsCkuBQ?=
 =?iso-8859-1?Q?S2S2/nlG8tViubiCkwMUB9qPfNqFPGojypwlbM+pV/dEEfNhgbkN48/klq?=
 =?iso-8859-1?Q?mrznfEMKB0z8I1m8W2DscJenZI0ReL0POnKSOzfux7JRpwGjPOy6hGNbhh?=
 =?iso-8859-1?Q?7EVA5z3dg1E8mZKAZHwgW3ipXLNqW6EQfHtbwMVjs+l4cff42xl48cM8Mp?=
 =?iso-8859-1?Q?iqK8HdL8BJqod+wMJYl0cgAQiiLQrcMtFr5lYOR05hxJwWl9/wSOu8sGHL?=
 =?iso-8859-1?Q?ofe8ZRlrEmY6OKkBIRrU7mwkF61tKbGwpar1LaTPBntvh0MWVsZN2KIK4Y?=
 =?iso-8859-1?Q?5zWU5cWwefjw6Khhx1s/nsxnVTHspBy2ICNAfhqPcwnRa343//TjLydGog?=
 =?iso-8859-1?Q?Up03YbXZTynPyyf8Qb83ft0yGv2EJBDP8zw5yeaiKafR8sYs/lKhPWN3G7?=
 =?iso-8859-1?Q?JaHG1Xr4vpTYH17RYDKI/8dXxSFzDh1D58opJyixxL+iYRw5/3s/kut6Yn?=
 =?iso-8859-1?Q?oohTd5evMd1CrkE/dHypzbUS6e8Jjjf0n5xMHjjkq+m8iz0rYJjj98SS72?=
 =?iso-8859-1?Q?UtTFog8SPa1+7ilFTwMuhrg52SO2jfM4pRWKMmCLIaaEpEbIt/IK3TaeF9?=
 =?iso-8859-1?Q?XM91pTx9gSPvukT/P3HbyQBcDFw4MyAmzqUJU25MJJo3DGukpwjWjk4NLM?=
 =?iso-8859-1?Q?R5kZQXBgmTfARwaJXBqjbHIA6PBQHqWyewdgK2oK06bZ7OBHT3dxuyJjVK?=
 =?iso-8859-1?Q?elVrzMMTI4RaxK2jTQndf/WQO9tgaWkazw7fT89hFOw5t6KK3chS43vnl8?=
 =?iso-8859-1?Q?LDPQbueRr+H4Sl2GgE39kYIzF8oj4cBPdlf/26tcIi6vy0W9BqAy8H6BYS?=
 =?iso-8859-1?Q?zRrmOJ74hfLjydxq4JBX3QBtz/GUKxBPfVpi7WbRHJtN1Wh3qvs/RraYXg?=
 =?iso-8859-1?Q?yZKIrKdzmfeC7vPR72uHAnb3/E3efU8aBp8GrJLV5LAi8BRknOW17xnB1e?=
 =?iso-8859-1?Q?ZHC+A+41K8gqO1bdKMpP4oEoTiIYY1jNP8lstK7/jna7hTK0OqyR3ywPnl?=
 =?iso-8859-1?Q?L9dqtKyWaIncGajKavXHQXOwQTPuItVvJz3icw2bROg72duzIN7Ikr4Qmg?=
 =?iso-8859-1?Q?xBjTVKjAtDsTyUyFANFFz7417zPuBxWoOVwd7YNzbv5YOKpDPpuTgRSVL/?=
 =?iso-8859-1?Q?/gYrKzJ9W9poU7CeMGoCZw2J8k/ibHpP1gk/qYyaqE4QLZ9x/UEQdCeQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d088b9bd-405e-447f-cc3c-08ddafd8854b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 08:57:44.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 13LQ1Eu7K6888rrDGLcyXnndBwT4zTUYGX/PUKSPRfV3k4JLlz3cCBxRwFI0KtnWTdxJIdRrkNkuroO6V7twMvko7vQfqZ2v9q1jtTpnXzmR17dGhUFhAW21NQB9kIqo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7637

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, June 17, 2025 10:03 AM
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
> Cc: Olivier Tilmans (Nokia) <olivier.tilmans@nokia.com>
> Subject: Re: [PATCH v8 net-next 04/15] tcp: AccECN core
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 6/10/25 2:53 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Ilpo J=E4rvinen <ij@kernel.org>
> >
> > This change implements Accurate ECN without negotiation and AccECN=20
> > Option (that will be added by later changes). Based on AccECN=20
> > specifications:
> >   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> >
> > Accurate ECN allows feeding back the number of CE (congestion
> > experienced) marks accurately to the sender in contrast to
> > RFC3168 ECN that can only signal one marks-seen-yes/no per RTT.
> > Congestion control algorithms can take advantage of the accurate ECN=20
> > information to fine-tune their congestion response to avoid drastic=20
> > rate reduction when only mild congestion is encountered.
> >
> > With Accurate ECN, tp->received_ce (r.cep in AccECN spec) keeps track=20
> > of how many segments have arrived with a CE mark. Accurate ECN uses=20
> > ACE field (ECE, CWR, AE) to communicate the value back to the sender=20
> > which updates tp->delivered_ce (s.cep) based on the feedback. This=20
> > signalling channel is lossy when ACE field overflow occurs.
> >
> > Conservative strategy is selected here to deal with the ACE overflow,=20
> > however, some strategies using the AccECN option later in the overall=20
> > patchset mitigate against false overflows detected.
> >
> > The ACE field values on the wire are offset by=20
> > TCP_ACCECN_CEP_INIT_OFFSET. Delivered_ce/received_ce count the real CE=
=20
> > marks rather than forcing all downstream users to adapt to the wire=20
> > offset.
> >
> > This patch uses the first 1-byte hole and the last 4-byte hole of the=20
> > tcp_sock_write_txrx for 'received_ce_pending' and 'received_ce'.
> > Also, the group size of tcp_sock_write_txrx is increased from
> > 91 + 4 to 95 + 4 due to the new u32 received_ce member. Below are the=20
> > trimmed pahole outcomes before and after this patch.
>=20
> AFAICS 'received_ce' fills the existing 4 bytes hole, so tcp_sock_write_t=
xrx size should be now (95 + 0), am I missreading something?

Hi Paolo,

First, thanks for the feedback.
Regarding such "+ 4" is due to the byte alignemnt needed for ARM arch.
You can see below tha pahole outputs BEFORE and AFTER this patch, in which =
a 4-byte hole is added before "tcp_clock_cache" to make it aligns from the =
multiple of 8.
And the comment in net/ipv4/tcp.c also explain it: "32bit arches with 8byte=
 alignment on u64 fields might need padding before tcp_clock_cache."
Does it make sense to you?

[BEFORE PATCH]
__u8                       __cacheline_group_begin__tcp_sock_write_txrx[0];=
 /*  1869     0 */
u8                         nonagle:4;            /*  1869: 0  1 */
u8                         rate_app_limited:1;   /*  1869: 4  1 */

/* XXX 3 bits hole, try to pack */
/* XXX 2 bytes hole, try to pack */

__be32                     pred_flags;           /*  1872     4 */

/* XXX 4 bytes hole, try to pack */

u64                        tcp_clock_cache;      /*  1880     8 */
u64                        tcp_mstamp;           /*  1888     8 */
u32                        rcv_nxt;              /*  1896     4 */
u32                        snd_nxt;              /*  1900     4 */
u32                        snd_una;              /*  1904     4 */
u32                        window_clamp;         /*  1908     4 */
u32                        srtt_us;              /*  1912     4 */
u32                        packets_out;          /*  1916     4 */
/* --- cacheline 30 boundary (1920 bytes) --- */
u32                        snd_up;               /*  1920     4 */
u32                        delivered;            /*  1924     4 */
u32                        delivered_ce;         /*  1928     4 */
u32                        app_limited;          /*  1932     4 */
u32                        rcv_wnd;              /*  1936     4 */
struct tcp_options_received rx_opt;              /*  1940    24 */
__u8                       __cacheline_group_end__tcp_sock_write_txrx[0]; /=
*  1964     0 */


[AFTER PATCH]
__u8                       __cacheline_group_begin__tcp_sock_write_txrx[0];=
 /*  1869     0 */
u8                         nonagle:4;            /*  1869: 0  1 */
u8                         rate_app_limited:1;   /*  1869: 4  1 */

/* XXX 3 bits hole, try to pack */

/* Force alignment to the next boundary: */
u8                         :0;

u8                         received_ce_pending:4; /*  1870: 0  1 */
u8                         unused2:4;            /*  1870: 4  1 */

/* XXX 1 byte hole, try to pack */

__be32                     pred_flags;           /*  1872     4 */

/* XXX 4 bytes hole, try to pack */

u64                        tcp_clock_cache;      /*  1880     8 */
u64                        tcp_mstamp;           /*  1888     8 */
u32                        rcv_nxt;              /*  1896     4 */
u32                        snd_nxt;              /*  1900     4 */
u32                        snd_una;              /*  1904     4 */
u32                        window_clamp;         /*  1908     4 */
u32                        srtt_us;              /*  1912     4 */
u32                        packets_out;          /*  1916     4 */
/* --- cacheline 30 boundary (1920 bytes) --- */
u32                        snd_up;               /*  1920     4 */
u32                        delivered;            /*  1924     4 */
u32                        delivered_ce;         /*  1928     4 */
u32                        received_ce;          /*  1932     4 */
u32                        app_limited;          /*  1936     4 */
u32                        rcv_wnd;              /*  1940     4 */
struct tcp_options_received rx_opt;              /*  1944    24 */
__u8                       __cacheline_group_end__tcp_sock_write_txrx[0]; /=
*  1968     0 */


>=20
> > @@ -384,17 +387,16 @@ static void tcp_data_ecn_check(struct sock *sk, c=
onst struct sk_buff *skb)
> >               if (tcp_ca_needs_ecn(sk))
> >                       tcp_ca_event(sk, CA_EVENT_ECN_IS_CE);
> >
> > -             if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR)) {
> > +             if (!(tp->ecn_flags & TCP_ECN_DEMAND_CWR) &&
> > +                 tcp_ecn_mode_rfc3168(tp)) {
> >                       /* Better not delay acks, sender can have a very =
low cwnd */
> >                       tcp_enter_quickack_mode(sk, 2);
> >                       tp->ecn_flags |=3D TCP_ECN_DEMAND_CWR;
> >               }
> > -             tp->ecn_flags |=3D TCP_ECN_SEEN;
>=20
> It's not clear why you need to move this statement earlier in the code pa=
th even for ecn_mode_rfc3168(). Either a comment or
>=20
>                 if (!tcp_ecn_mode_rfc3168(tp))
>                         break;
>=20
> a few lines aboved could help.
>=20
> >               break;
> >       default:
> >               if (tcp_ca_needs_ecn(sk))
> >                       tcp_ca_event(sk, CA_EVENT_ECN_NO_CE);
> > -             tp->ecn_flags |=3D TCP_ECN_SEEN;
>=20
> Same here.
>=20
> Thanks,
>=20
> Paolo

OK, will apply the above feedback in the next version and thanks.

BRs,
Chia-Yu

