Return-Path: <linux-kselftest+bounces-29351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5736A6745D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16C3417B953
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Mar 2025 12:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05A320B7E8;
	Tue, 18 Mar 2025 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ACCB0/n+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2061.outbound.protection.outlook.com [40.107.103.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE13F9D5;
	Tue, 18 Mar 2025 12:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742302509; cv=fail; b=gPauYrot7pLEmm1XHXY4hAEvx4YKzFV2U5pfJAaOiDPQniahNtw2vhGSYAgc4gMpwjnu3LCTvuOS8HfjFymvpRUytMAxnu7FnuF7jW6qGjWQXqketx1OdVXEr+9la3tOlCxmySdZBy2oPiKVedrmGENs5LzMVTnV4m4Zke2+BNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742302509; c=relaxed/simple;
	bh=VeOdnNA+oMj2JGP5vx3jZzLm1aS40c54UrZ4umptS4k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PDZcKzsPCxc3Ix9FUyVBu1Akm5Za36FjrdDSHKziz1hlePqlU4C8JflkxvRZZji5qJGyayJ8AhxE1YMjeGyXbhpBkHsyjG+b+7WPFY3EDzKJER5rqxK6lJZbmDeVq3CJw+rM7iLNa7FqD0mAjM72NbFM9woJ5OE5kle+rb8g8xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ACCB0/n+; arc=fail smtp.client-ip=40.107.103.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E4Og2WeKDjcEi50CU047YTMGFb3oi9LaLT/hTE3q4A6r5AfllsSipX/Tztf3WM85D0u/gn1CFF8YFihhComvekgBpTbgpefU/qgrcZg5rg0isAYub1GtsP6PHwrMzNtQDHG7kv2Cpu2A+ci3hknIneOa2cwTfkxAd/iEEiQg3Y/g2ncQajby+7EEVHfVY52eKrmWh/zhG8tDKjelMEudUYtYpxprQmapf8OA3cnzIMek0eKaoxNcGvXQqMfG/fVgEG11EzWzs9K6X5rGn08zYPN7Ao1GjyElhKj8jhXTimcu+l9tkpq08bJz74x7+ygyF2KYgdcbkykYGx5Gqry3CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9SlyA56cioDl07JhBHpBd9U9M1yrJW8TEdTPXKoasc=;
 b=WaAt5awrhdFagX8GuER2592+i4eNVnbGdLxSYX+JUqjf1YS53iL/B+113a2czOxwzDhDB0gl4i58f/I2dU5LpmQGZ7adRQZ1gJXw/CEnaSHzy0U/vd3vYaZyiiSA7vicCr7FnVs9d2USSL2hc/u8Seks0xaQjKWcpSnkD8FdDRn5FWHTFcthFsl33JHmnKofXlIVxE+bbRjs4hE3ktrYkbXn35oReqfXvxaQLtVKk94zTH0odCYV80zIpq9dEUiSytdUWf6ykKlPivjRtViUDik2XhRGVl4787nF8iH827mVVEKjETIc6PMYzVQNfuBveexWv7K2iHior7NZh9wHqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9SlyA56cioDl07JhBHpBd9U9M1yrJW8TEdTPXKoasc=;
 b=ACCB0/n+zEr/YFpw5ryt+tapBe9jScmtpx1iVyAe2vN4jQp2/QX0PmR/cGl3kLOmYnMvt750MbKkq27J3z8j2gNlHgGphva1IMDCbgHn/b4U1JLpdheXXLc0U+96K4/G5toghhJ3GsgmVo0h6Ubj6YWqfged4iVFAe1SrYn9B4nQvZPQefC8nU8m3KCdsHECReugqneJEH8iVOOPGASQTjEeLCTEXzD2rHVlmn3w1KPu4TbHftQfsmehGXA53V3MyL3mzqsLp0yf8Ff3pnZWEYCy0pts+TscNWriEfFT2W9ZRCD2039tFe0NZQAZdBHn07AWcr33qrn8SCz4/jV/2w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB7941.eurprd07.prod.outlook.com (2603:10a6:20b:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 12:55:04 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 12:55:04 +0000
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
Thread-Index: AQHblomz65WqQmgTSEiGQj+R5VbIwrN3VT8AgAGGzTA=
Date: Tue, 18 Mar 2025 12:55:04 +0000
Message-ID:
 <PAXPR07MB798434C6EAC5F2398E7138E8A3DE2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250316153917.21005-1-chia-yu.chang@nokia-bell-labs.com>
	<20250316153917.21005-2-chia-yu.chang@nokia-bell-labs.com>
 <20250317063326.42e3e550@hermes.local>
In-Reply-To: <20250317063326.42e3e550@hermes.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB7941:EE_
x-ms-office365-filtering-correlation-id: caeb8db1-9ef2-4166-9dbb-08dd661c1a64
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HO0hXTOes07v0T9aZe0dnEOFSwCzmzjLRjZOukTPhW2RYKxXUoLzVGLmnOS/?=
 =?us-ascii?Q?hA+5V2zFH41iaauKD1taG6YHZQgLCWgFjl28sYgiRueVhaBHFBwgMPnhHUFq?=
 =?us-ascii?Q?tTcMEZrWPl3Rie7F8g6St12yiF3eFUqAYPT4MaUp4o6mGNNMUB8Zf1gSw8hw?=
 =?us-ascii?Q?/K9oDFTS2c5gNTkRJzLP8LpjtSJ4W8KO0Hn4MIQjPi93x6008AK7H6Pe5n6Q?=
 =?us-ascii?Q?1kfnyQwQSr5QZLLI2D0nwQSlx16l/H7xj2yeuyO2vRTxFoAo0adiBalpVF1U?=
 =?us-ascii?Q?a+pUO4QnPuQz0TM93IC3c1sNIxbYQBkuK0nVgS7IJ2i+oLg1D3E2xim+J8Sx?=
 =?us-ascii?Q?yL9hmHSasCrejtNmiAbA5sRwSQZMbPfA5Qb6nb8XsAenMWwpfzdpCwVhGgZK?=
 =?us-ascii?Q?/9PA1SAA20AHNJaJh53FhhSh948Uk/cPJfqnUI/BcCD9MGm9EOUvyD9caAc7?=
 =?us-ascii?Q?07fhf7Z0QWrn9zZTLhgXrKVCCZUDjnwB+LYzWx/8DfeppTRObq6/KOzj23sV?=
 =?us-ascii?Q?TLHpTk5F/f5XBQbqcXOpKSy6XYELs453HMTO6M1yWyU1Fpf7WY1WlRl0YMJ1?=
 =?us-ascii?Q?8QBg0kCSNpaE2srgJRDEO+iqjzbCKxRSk/bocXFwpgIGgRz2AMxKHPx9VKBe?=
 =?us-ascii?Q?isuI8DmuzenQf+BjePmf4VUA9s5Yg4jGw6rUE4K/NkTvUtL6s+VJ+vhepYw4?=
 =?us-ascii?Q?2AsPsPMd55X9yWQJU3/DL7dmIRw7SZbzBFRPLkEldmxQH3BSAqvWDq4lOGwQ?=
 =?us-ascii?Q?T/U7WEOpQmmZhV30I11f6hCQlFKIq9gtmoyshGcO3M7kJVc6qqfxk8vnb2Dz?=
 =?us-ascii?Q?kgefU4tuyngUZzJX2z9sUhN0eRk9b85sLh/XBnw+xqCqMUhkaWy3wvPLeVgc?=
 =?us-ascii?Q?SDzB8qUo5cF/fecaO1vtfcbl20o6sHpfKhwk113ME8tLqaMy3+Tv+SprkoAs?=
 =?us-ascii?Q?i5gvfvVRQth2L/pmtqCcn4mHsg0fMAOFkVoivQG7PvCwBUFVVEo53Bu/96Gs?=
 =?us-ascii?Q?e1VZsBbQqRJUGWqXW2EHoR7S34pbAI4Wmfd0FeADeTWJuGuXT8Pc+6rN+sdS?=
 =?us-ascii?Q?3nmROINv6MHtZqzFLe0wQ0ZIBlpNvH10dVpWQSh4DayuFojTFBOXq6diN7nE?=
 =?us-ascii?Q?c90KAYJw1vswJq5pdPQkGKtJNM+aIhs7mkmFCPgVLUlhcdBGW/BtpoG31PhO?=
 =?us-ascii?Q?xebsEGSWoaY7v6UoIhQbSJh906NimCxdO06PGl3/XCVeA+IcIVYAc5iFHLJ5?=
 =?us-ascii?Q?v0W4DqPKPPC1BqOXgfU+9pcFxpSW28FhWslI0efPDIOhGBHXSDxgWsRgh6ut?=
 =?us-ascii?Q?by/hUw4NxDWEJUg87z8YjkmX0LI9Pwu5jddRkz4v2X67CmEN4WhU+aFPU3rF?=
 =?us-ascii?Q?hzT6W6U83crKOWpbPXmfypcdsQ9tR92X9on0EfaYVp6OnTXz+4f/7fthTVNc?=
 =?us-ascii?Q?WAgh/xC/JTctP3bo8pBpQn8Y1x4d3M9L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RL0JX2YBQFBFJIXqkGySu5vJFhl70wZCkgHqQw/crjX/Z5IRq/cZIqkFW85F?=
 =?us-ascii?Q?VHyTYSh8RcwEud6O4ZeA4W7SFeFo2zJ7D0XmdXO6bfi8/yTXxWWiWpzt3v1W?=
 =?us-ascii?Q?T2GzvsoX51NpKEF1Z10KvvSdfM/ReTFBLThAYNeMPa5R3BTRVzIL4imps655?=
 =?us-ascii?Q?5Nag6GXl9N0Kogv3tzcdcBXIOOyE0Zk1btWwMP3xHt8Mr1zTN+auwR29A39m?=
 =?us-ascii?Q?xVuRDNC/OPFGMLeWfc/MdwgzUoRLNIylwSR8Qposh0ajpSkoaLiGtfAI2doG?=
 =?us-ascii?Q?JiJ1UI4vzclxKID7393TYw/sgubfFpdBe3dwqQUPmwl1afn9j+GsqqRY/6rU?=
 =?us-ascii?Q?eYhqytr8lAJj3hZ6b60gFjuOmjVj7NJ+jNMGe+HpdJ5Gbgb289xPkvRXuFXy?=
 =?us-ascii?Q?lrA+kxeAMzikQHHuKU5TkwwEjFgwTb+XxBUkjYvfgR449mq22nw3DQyAfepN?=
 =?us-ascii?Q?mXMRQSjWYDr6VT0gNgkw+P4Bac/q4S1qgtcwPJWDj6UZKJiFFKGNEcpg1LCW?=
 =?us-ascii?Q?idGzYRxM3JYvKw2uXQ/yODT0UrRqgKlPTuSCOrzRGiqbJDppxRuusWJ5Jicj?=
 =?us-ascii?Q?Bu3HHxGzIbtCdzzwMSHsG/uDvi6Tls/UOr9lXefJ+QSItDg762LmxvkQ1AIg?=
 =?us-ascii?Q?W6sZ/CAGxnRAL5fj68npQNpnP5vnYYCwmqrbSggl04BV0odHzeg/ONJcR62q?=
 =?us-ascii?Q?pgcuRdjFmCTYRyoM9iUHYJmW2wfvxAHM1UMKb3lvb+woEkG+8Le/S2lyMUsO?=
 =?us-ascii?Q?Y4AneGQGJbrZmTTAgDqnonaImPugg7U8ufUkbh/PtSUjbbUMdGitsjA0c0c8?=
 =?us-ascii?Q?mskEzPoNF4zbKXLEJ9eJOH0GKFHsV3audu1U5itk41CXmcTh2qOsBj7H8UVv?=
 =?us-ascii?Q?4nucfvlPPVAo9I9ex5UICm0T664EVQONIPUy6JSJyarT5IgHIL4tgBmsdJ0X?=
 =?us-ascii?Q?ni50w0ZldIJ7ib9pBR+fNyZaopd+4eRSvy+BNk3LNPgDgcuoLW6ebrl1xblc?=
 =?us-ascii?Q?aJU9htNBm86clUUW+AtDE+ZXy8T2WWRcQe6Ha5cdyL3KcnMBV9TNgPihcdlf?=
 =?us-ascii?Q?oqPrGhyMqzr/GtY607PhqDN0Hq5K67xD9o/LuD+1fHIAkLQfjhcZN0wMnQup?=
 =?us-ascii?Q?IUqQhlNPBscW1SOym5qZ/SE4Cz0VUEIs5AT4jqsWmv6X81LZdkha9u8pI+So?=
 =?us-ascii?Q?O2ZDTJAI9SXmjPTupLJ2rX1Z826CNFYNH2wKi8sopD/J5eukNG5xNujh+nKs?=
 =?us-ascii?Q?a+dDGhglaAknyeVOyfFHEfS31/OpqdbVbc5exVWMJl+Yu/NuHW9NOdJUR4XX?=
 =?us-ascii?Q?RygGnsKe+s+HNSdGYLHngSrS+8IdQDl0msNoicmAmpuuTA0yB+XE/lRjuo15?=
 =?us-ascii?Q?PsZ/5JDqYxLr3jg0O7TCc2Y0nNuBKud6JE0HUuf3YvDdNJBLT8Lyz5U2VHzt?=
 =?us-ascii?Q?Kfo+yKvCsaOeqGr3CLTf+VK7pNZkHNUv8KItfAWSNCMIT4CSHVsoYfjeeH82?=
 =?us-ascii?Q?0+lgymSe0bP65MLluWZLNbFrSSh6Zqio2pJXyAKFVv+GBCYoTB2PwcA5IxIS?=
 =?us-ascii?Q?u53P0ZKYhAOSizK/yY2hWygKsXL41zOt4tLyMGD9HTdLyiWE78K3ZvfbjRbr?=
 =?us-ascii?Q?p6BIM3NU71sh95ldZR16so8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caeb8db1-9ef2-4166-9dbb-08dd661c1a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 12:55:04.4002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Wudei84D+ZajUNA1TG0DSBWNTWJuk0ggk4zuWUEiXsDzuz4PSGaOhX+x7LspPEG8aI9t+r3xSb2F+Tdfh7E9LII8JYWHZznjWY1Qs+QYX569ksBKMq2LS8T1WcGbqUf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7941

> -----Original Message-----
> From: Stephen Hemminger <stephen@networkplumber.org>=20
> Sent: Monday, March 17, 2025 2:33 PM
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
> > +static int get_packets(uint32_t *val, const char *arg) {
> > +     unsigned long res;
> > +     char *ptr;
> > +
> > +     if (!arg || !*arg)
> > +             return -1;
> > +     res =3D strtoul(arg, &ptr, 10);
> > +     if (!ptr || ptr =3D=3D arg ||
> > +         (strcmp(ptr, "p") && strcmp(ptr, "pkt") && strcmp(ptr, "pkts"=
) &&
> > +          strcmp(ptr, "packet") && strcmp(ptr, "packets")))
> > +             return -1;
>=20
> No shortcuts please.
> We ran into this with matches() and arg conflicts already.

Thanks for the feedback, and I will use matches() between ptr and "pkts" an=
d matches() between ptr and "packets".

Would this be ok or you expect further things to be modified? Many thanks.

Chia-Yu

