Return-Path: <linux-kselftest+bounces-36113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16079AEE312
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C7B189F04E
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 15:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F155028CF40;
	Mon, 30 Jun 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="P59erWDM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010001.outbound.protection.outlook.com [52.101.84.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89548F54;
	Mon, 30 Jun 2025 15:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751298679; cv=fail; b=LzC+xrJYpcqpbQJzQqdCtUTC+Oco9i/pH3ciO76B+Bg7uBsOAsTILAFSfRd5bWWGrRxe8XbQIdzVC4GLwCPjGUA2gRYPiodXu18AgzOLalJ5Bvd17r2XdQ6M2arteUhjG235fKtfQ1dFa6bvERo4g4Dg6qRAbETyMXjZ3UubW8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751298679; c=relaxed/simple;
	bh=w9EiI0hnxgq99xfjnx93jo3KRBWJDPHHdvcjXhntuMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CP4eSyXcnOfwNf3Bcw5wbTqIO9b5hKfeVBq+wJcwkiBPJKCRv1Or2qE+DCsyJ107v2ssySObT9a9eugd9QHEEnKne9xDNKMJYIP4ywfPE4hp/EINsbOGJFGUSg+lxK4WUiZhb90eJDxEn2alN90DFSmr/Jtl2ORhdOWLaVcgyCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=P59erWDM; arc=fail smtp.client-ip=52.101.84.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU17qNXGMxK8185+yNqDCjD0gIOvRy3JBGrqUZ5vMBZGPNw+jc8KZDyx7QHHXWKmRh9EQ8Kn3/QPVbvhIdrt3RUc01QQsu9PZtZaCtPZ3NrIkiaPNinif7B4XCBIMcF9I7XQT1QAQ+BzDhMeroKokktV/g+yqdLNl0gxUneGPYf5hWdJesqYmhURiE2duRI9+EQ0zkgQgm8RoH05Zs5hUER4h09KHV5Sd5kr7+bA1BA5KkkcXhN4oxj3nZ2N9rMRjytsF23qb7msehLR3kNeunafsBTODzalZDvjXk9zjnCt8YJGmemz+dQTRIXMNc2HqwQUZnUdHTyNAD6kcUgg0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9EiI0hnxgq99xfjnx93jo3KRBWJDPHHdvcjXhntuMI=;
 b=LDrpGChBjZn7qhGHGNRwN90kVBXpo2FksaTRA9aHcprrw6VlVQtbZbWfMlKGjbXmIKa2P7neiVrIJyiohPP8DMJ6lEb1LllnBxzbpotp6ykuudWTRlPWg3wLsY8vH3SwNOJ0BkOaC4HgEEFxgP1bmqqx3tiRtraoC/XD2OV3WunzpZ9aFLXRUXCdRJg74q6duCEh0UZfryn22qlTLiqjE/sJelZ2Usz78AHgwvm+a1o073gV+TX4BvD+gGPtkNZLYdJsXc/Bdzp68Z2jgCZlzQHjRPY10VLVKiL1bTpio5GukBL8szO6EWvaaG8rruKOFNKkyoGOwKYhsGyoHnrV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9EiI0hnxgq99xfjnx93jo3KRBWJDPHHdvcjXhntuMI=;
 b=P59erWDMa0+latblEiy1+w4u5FlKJGQvxojhqDJhJ79CaD6So2l5B9O6YajkAq2FjqQXV0yExu/hW6kaQyyVlbwmDIFZCqgxJ3SQbOw4s3f08/uZJUDba2CzCTc+USxTKwQSW6QklPYGQDhefuGgngPCGuekfj0AshOVJVi71P5XY/aTbz7DMjHXq+AKx/2dW5brQepXvmn8mhxMCba9CI3Jn665aPePiIjhH79d3No9wxQ7j9t5r0mHjrQtUXDhZuOPnnvs3Pm75tNivSIhTXNyMt5nlWdmfvtFJpEeIGthMTMIUzA5PrmSRGhzGdDWxLwxuJSWHrT0hj0YbmeLiQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PR3PR07MB8129.eurprd07.prod.outlook.com (2603:10a6:102:170::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 15:51:14 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 15:51:14 +0000
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
Subject: RE: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v20 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb4uNmCaO8PxZhYUCrH1BBViihEbQXr6IAgAMajRCAARMzgIAABBIg
Date: Mon, 30 Jun 2025 15:51:11 +0000
Message-ID:
 <PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250630081349.4c9d7976@kernel.org>
In-Reply-To: <20250630081349.4c9d7976@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PR3PR07MB8129:EE_
x-ms-office365-filtering-correlation-id: c3397a10-2d5a-4c2b-9b7b-08ddb7edefca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?YdjIKMKj6JfFaaY2VZCwR/LFgbJe7W1l5bGBKC78qFi7kagzBKbQ7Iql5Fvz?=
 =?us-ascii?Q?PvHjCVczwjSd2tf3xCqm3aDWSgGEIshbdW4c9sHxI4fd07yWl6fc+jheWfGo?=
 =?us-ascii?Q?5+n8zDvz8yjQ+U/YbWc39u0mGFjw6tfls4SmunciOfTy2648WKCNqfdbjRE3?=
 =?us-ascii?Q?Zr0s08SBtSkxG0pOM3fE4cHSscyplyaURE4dHYdBFNmkwNVQtcl/gapjsn+H?=
 =?us-ascii?Q?8iSfNMq97vv9EkR8V+f0bwruZhSIaDRgNHdOnXzIJKtWPHEC2SJNLXlnLFFg?=
 =?us-ascii?Q?DPH+aE08o2aihLCdHBbif8/0QCOc/SBTb7ayICyABcTpdNvFC4OcNVs7IlnP?=
 =?us-ascii?Q?zhZ8qQLRPFWDVJiouo9GFeXr9udCyGrHxFoQYhrbvHQT1OXYwUjfwq+Bm/et?=
 =?us-ascii?Q?mb8qdwx+k238uy1IZhH8boWmvJeGyYgisBp6k4xRBGGkxMJgnBFXkyJ106KL?=
 =?us-ascii?Q?nFAbtOFUh2BFnBZON1QdMCE6jq6hre2f22oH2yZk/6vvqFzcWeA4+Hv3y4tT?=
 =?us-ascii?Q?yErGQAnjXKm8RiMlRc4NYM5ZJar5nEh5NAe/wvTRvTMWXnpXQcJPgE3tcMLh?=
 =?us-ascii?Q?u0FLyvoaSwF3DhSwEakhBpHr55dXk2VoMeUvEefWy2T6K7wy6e23RpC9GRSB?=
 =?us-ascii?Q?AVqNOkjXc26cjufB+LImm0WPbAd33kn4ChW7ln/tCCWb0mBtFl6BENwEuwr5?=
 =?us-ascii?Q?V3yc1QGpfo6mKmO2b4FNfE0f0HDDoaMLZ29tRG1mfU1EShBbqBwXOB9sXNK5?=
 =?us-ascii?Q?Ah2MstfBAO/6sZg+N4cZFeAt/cc6MeHqwhqg0/N/YhqDcihL22Y6ANY2eMIn?=
 =?us-ascii?Q?yAjUBi+1DTojeeWV0hql0FumGyadzmTWoBxTnGTc4FjpxQzAEpN1fnDv6U8I?=
 =?us-ascii?Q?fPBJvoNdB+ukM9CGHQOwXcmlYFJvfBqZ1VcsoJ0w7PagJC5c6IozUqlgkQcH?=
 =?us-ascii?Q?kzvU5NFYD7Jc7R4yHFvsX0oxNyBX+QxHicEfjSFxICEK+k4mL6fTEcUMTG3A?=
 =?us-ascii?Q?1yW+PTg0CXr6X73/REx0OHrARO9jil0uWJGehYNFpTOxz1QfCD3oEHJs5k+K?=
 =?us-ascii?Q?EZoLuJWw/SvAbap54zHCphpGil2+hwb6cuMxSj3X3DGP74C7wwRZXFMpApcR?=
 =?us-ascii?Q?NuYEDJkZqsdTXzFvPoPaYz8eXEtW/Ux9TvOV7/tiubTswyRI4OhXs67669vf?=
 =?us-ascii?Q?ryksrKS8hWzuvb2XLg7WMWGg3mIIeDjBFmRNhYw6LbG9gMJT59AHmT/UGZsp?=
 =?us-ascii?Q?uDynPSMPF/VyD2sgtZiS7Jlcby7cFscrdxQZKOgHY/lQxo6jdT6Z0P98tjej?=
 =?us-ascii?Q?RKtw9vHizgNYhJOukm7JUgZx8YccksvvQYUw09XQRZlw5sJHCwzVIpMwB6kr?=
 =?us-ascii?Q?QSNhzPk0SUvoIy/6Jv/HdzbrTJZZnQXHCj2+n0WWexHe7zA+RwuLChzQV3K6?=
 =?us-ascii?Q?v1/5nQpVsouXlOn+4eWBbfMJXX8O843H8ahf28KWiEmDl7FVqRrlzc5JwT1b?=
 =?us-ascii?Q?cjpRs9XtRlbhhK8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VKr//vjBcD7sbA4MJXr9N2xZ5WpekAoNDaBz3IgrC08G5Y/Mn9pcB5wEo36E?=
 =?us-ascii?Q?5OniCUufCLfZ/sFAhML4EZ6beFSzmaOQ/2Ze8jJjeA2aCTBwnrZEToAsxsei?=
 =?us-ascii?Q?RIjS0qXcNci4dbgsSYOIFqgkQ2Z3hwnJt1UL5ryGqvUDmdGLnjLFuB/IpFmt?=
 =?us-ascii?Q?cbsfoeuTdB0PmJ9IyUYrLcYbFfq+hcjRIDJZgicNBmVuKJBaIZlwT+i3vrVr?=
 =?us-ascii?Q?Ik4UmGeedp1hAmB/T6zud2/m5cPFoK5jDdJt8Wt8L5kBKdxfUqmhGeAuOXvq?=
 =?us-ascii?Q?9QzvO6PdTvUW8V5qWk4sObB7RwtF8oV7lmhT4CcjAIXW8Kmy7SQGF3rDCWxR?=
 =?us-ascii?Q?DfxQJhkb9JeVb3t1sc+4cNfzBSCqA/oxZmcH4lZNwRAv/a0/tL1AMqgF8E4D?=
 =?us-ascii?Q?gwmjYd8dIcnkU8lX2KewuKysPNqcMhbvtcCgxrh+XPoXg4GxmnlpBjP5Rr1f?=
 =?us-ascii?Q?ysmYUHsq8GaFT6oStE9CyLtEkz9GG4kwRb0T1+LXo7/r85r3nS0CW52Bf+Va?=
 =?us-ascii?Q?lDBOuGfEmqq8UrJXY+zpI5ZxPsBA3dnmPY8WNzJ73bUL59vExCRWL6CIcaW8?=
 =?us-ascii?Q?qPQ+Udf/CyTnNUCQLBIqYkszWdf2CQ5RaiInWE9VR4SIGhydgm11DxkzeSnU?=
 =?us-ascii?Q?Q2yFzV+9tiIIrDaadx+G79U1LkPTOoJpq6r9mAmSAkBo7dadmYVJMo18rSlr?=
 =?us-ascii?Q?1muJv2Fg27QrIZDuXtOGrAXQtOOybCcVcXtvWyrdyIu8gle4W0vZSFMnyqcM?=
 =?us-ascii?Q?NT1EA+CU/3W8pqG235Bv3V8rZNQ46oY0HsGdecE3ksclqjCc5kanhjBhfJ42?=
 =?us-ascii?Q?1RUkPHoZZzIHujBxWZUpj6VzWSpDM+EZEALxLIAQIxPRrH7fFITVVru3JKQw?=
 =?us-ascii?Q?m0IPf4S45Bgd4IOlArT1PQRW0AyqXJ+BG3cTjaC8AbtkoVM3Iaof8mrYXZ+f?=
 =?us-ascii?Q?BJJUeQ2PAm3Rd3rgdOpS99xa8eCJSoxoHhiebXBYRlvRIX06pBwiTnSL+rpK?=
 =?us-ascii?Q?/TvBTZcL/NrZ3P9zxqORN1MppfEhunyODlMnJzS05TX5zqchoYZ68C8mUW6P?=
 =?us-ascii?Q?te+YsplrLZitQYmxWSlMlWF6Hp4qkeX/OsIOKlUGn16dN2+cQGxgkOGRxo8e?=
 =?us-ascii?Q?mkAb2EfofFwSjDmPBKA+pb2flaetwWEYHuSVLlyKT/JdON3GeJCTdCqhU5XY?=
 =?us-ascii?Q?DhXP0/wDbEDtx2w8LYsvrpXk4AxFblwU8fWNh2jiPb8lWOHHD+7SIHMSD3RV?=
 =?us-ascii?Q?bWf+guXOmUD5e/jPSIkqODUe9zdjnuZm34zNUtEKIGWIlFZbbwyOfVcx1dEG?=
 =?us-ascii?Q?X9cumcG5OFFHLjlZsN5t2cAtFcdsjZl3hvUsma6D4g1vcp+GoVuNza8vSDrK?=
 =?us-ascii?Q?KbL/bjM+WFfUSqbH6y7VvOL+ETgnsyJNO2kKBrmgMqF15DcKZjPN7GBIo6Tb?=
 =?us-ascii?Q?InfiMhuqFDNpmzghq5wrVRP24XjxnPth4rDWV+jP6JRTVnrmfgMpY3rXLSG7?=
 =?us-ascii?Q?pxLg+ZFHGIDv0uQPq1ojS4hGWm2JZ9gFjcTwvUTJgTNun79E4KhSuT2GoOZS?=
 =?us-ascii?Q?MyxefBvNula37prJN/bnvsQ3Nzd8jgYoE0syZn+v94RWtu5eB3gHG3MWM9jf?=
 =?us-ascii?Q?0w=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3397a10-2d5a-4c2b-9b7b-08ddb7edefca
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 15:51:11.4202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0B467eEq7jlkXc9OS/c5XE3l5o0pBP+ZE/U7ri5CcRS0yn5dRgXlpCrFYI/tQ+S4sYdPu30qz3AU4Yi6eEn0ndWiCF3FGg1J70DPGMr/rF+xvGsm/3oLx0/MyX7eLpgA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB8129

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Monday, June 30, 2025 5:14 PM
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
> Subject: Re: [PATCH v20 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 29 Jun 2025 22:49:24 +0000 Chia-Yu Chang (Nokia) wrote:
> > > I don't get the reason for all these WRITE_ONCE()s.
> > > You lock the qdisc to make modifications, right?
> > > And the block under which I'm responding is performing two dependent =
writes, one to ->step_in_packets and the other to ->step_thresh a change wh=
ich is definitely not atomic..
> >
> > Thanks again for other comments again, and I will take actions in the n=
ext version.
> >
> > As there is only one step marking in L-queue, so we still need two=20
> > WRITE_ONCE even two attributes (one for threshold in packets and one=20
> > in time) are used.
> >
> > When applying the step marking, we need to know either the computation=
=20
> > is based on the sojourn time or queue length.
>=20
> Let me ask again - why do you use WRITE_ONCE() at all if the modification=
 takes the qdisc lock? Which reader are you afraid of racing with?

This still needs 2 WRITE_ONCE even "step_thresh" (NLA_U32) and "step_in_pac=
ktes" (NLA_FLAG) are replaced with "step_pkt_thresh" (NLA_U32) and "step_ti=
me_thresh" (NLA_U32) - which was proposed in my another email.

Because we need to know which kind of AQM is applied, either based on # of =
packets or sojourn time in the L-queue.=20

And the corresponding reader will be at the dualpi2_dump.

