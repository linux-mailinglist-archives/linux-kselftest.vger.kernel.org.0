Return-Path: <linux-kselftest+bounces-30961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F7A9095D
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 18:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606AD188213E
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5AF211497;
	Wed, 16 Apr 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="FVq7l8zD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013068.outbound.protection.outlook.com [40.107.162.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A218870C;
	Wed, 16 Apr 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744822275; cv=fail; b=OVAd5NLNrpGsc/t80ZtdsuPIq02SV2RsToBhLBa3RPDTOpBh/TwkfjciIZ8dG1cEhCN5OGz8BObJE2yamOFoaBxc6HRDyPtHZoUc6Vl33ZPg8gP6zc3vxlAtKf42ZxQ2u+lFcIpcrxLAqJZvmwnfhvJ9McYR/9NDMNqGvWnQvmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744822275; c=relaxed/simple;
	bh=i34yHPRcY0MBZ8vNpu4ZjA5Y0EwyJClyXvXtp3/9yo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzNCaOYMknIzNjACHjUUa9DlwYM22TtaR5TgJrzj5iB4utptyhjDITKGCiujU/ZmtIRgNtNK7wTL+/3Yj6NkzHz1/kM88Zy/bSCbFjcTOKeW5aqLCS/fDKkOLnK0V2Fi1qql+6ir8P0gGBxA257odwGK9EXmxKlpxHlqS6fagFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=FVq7l8zD; arc=fail smtp.client-ip=40.107.162.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzS4uniwCygG+KlJ4r4q//NGIUcqXCT8WPi8MUsdCKiNHYY3UdITDKl0oq7qPgLJv5asXIBX4xiq6FppmdQ45+REdrxRpL/brSBj4iyu43ob3uEGc0aa1mJ9PAkHW93TmlMTKU8FcpZE7Ria2OxVs1uAKV3ULB2zEGKOefa+7wXHElghM253AGH/x9t/7orET22uT68xiKpeySt+fF59xQA5OLWZy8ERSOizZN2GCzEm6VrXtabY2V8pwSal1ptWctP/aTAazOFnhZb0H921P31T6x3lSTC29r/0blL9FIK+C+fT1RP5gKlKXToJEO8Y8b68/WjjJLtwIojOBDouBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQSp8nFsccUy58tEScFn8Y1byIOOqxC3T3mHJ4igE+o=;
 b=VYN8ECuqhvTzoku9bqH4781GCchlx0ZOemnobFwsmPCTbYM7FHkp92M3/NjoI54ekI+cr0mpohlJUO1HWgNlDGPQswwfFmgXxuOQ1SmrYHuW2bgB+L2sm0FuMzkhoOQw65nOH+HY7sn1IZN4op2SAudJaZnDkgzzzIMEnFBIpufYfLVs/W7Ig1LOyYagi+b9vAMwvBrnJw8joCnh4aVANkLkyn/AvbutrF0Jt5/518M59nbG+lxNgbi7z24Ywe9X++fYXKhFpwnn6MExFJLUIGskzh820SklZGspblm+ZsFMFRjzLc6XHOFAK35LMRyVYgyce+JfnJ39bElOKG8+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQSp8nFsccUy58tEScFn8Y1byIOOqxC3T3mHJ4igE+o=;
 b=FVq7l8zDAdHJd8VvYP04c2T96urMnHzlR3/8FyU5yp4wLDllvVQWVMAcBo2pXWZBplL5sMnJVrl0mquCyd336ub2ZRPkmoJJRxRLaeB0f+Npvo1P2p1s5jNAaCXz2vlSGFd/hTffKsEMj577CsLgXspei5YRHgqKX9VPrqjdG7Tb7+GGnY1tyPtX+9aHCoOhAdVHE9Wi4Y6MmRfd3O8+1IqfPND9NFKdd7/cBPmcwS0nIkrW3A+orKTu1fTNkXsLlD+7DmSps/x7Vz1PT2mNLAE2Q0Dtzr1wSCOmBQ4r1jBCPocEZA8XWg9xvfE4gk0hLoAGomAQTQGyEoU8rcmFBw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB8PR07MB6345.eurprd07.prod.outlook.com (2603:10a6:10:137::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Wed, 16 Apr
 2025 16:51:07 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 16:51:07 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Victor Nogueira <victor@mojatatu.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
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
	<vidhi_goel@apple.com>
CC: Olga Albisser <olga@albisser.org>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>, Bob Briscoe <research@bobbriscoe.net>, Henrik
 Steen <henrist@henrist.net>
Subject: RE: [PATCH v5 RESEND iproute2-next 1/1] tc: add dualpi2 scheduler
 module
Thread-Topic: [PATCH v5 RESEND iproute2-next 1/1] tc: add dualpi2 scheduler
 module
Thread-Index: AQHbrT/UYQZ/4/K/DkidXZDf34zdwrOmOcaAgABK5UA=
Date: Wed, 16 Apr 2025 16:51:07 +0000
Message-ID:
 <PAXPR07MB798432ABD92FBDAA04D644B8A3BD2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250414131859.97517-1-chia-yu.chang@nokia-bell-labs.com>
 <20250414131859.97517-2-chia-yu.chang@nokia-bell-labs.com>
 <ef8c59a0-be86-4ddc-b25a-d198051f12b2@mojatatu.com>
In-Reply-To: <ef8c59a0-be86-4ddc-b25a-d198051f12b2@mojatatu.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB8PR07MB6345:EE_
x-ms-office365-filtering-correlation-id: 06b379d0-256b-440a-50a3-08dd7d06e26b
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?lNJk+BU7METU7FK/Vuv20tm/FJHPb4xlCNVww8yvnm6oKtcy8AyysOnI2RpB?=
 =?us-ascii?Q?RK0d36Jv57bhXXXQtGMHW+mYSOi88DIRx/oIoTQvimbNe8JzbRMV4PAuvOvF?=
 =?us-ascii?Q?65WgmdiKL8XqO65Q7MF1FLtCvuv+0HBVmy4fFWgqlFxmaiWtgByyeQuHIseZ?=
 =?us-ascii?Q?g/fBIFEBkSp7MrMgNp21PunlXigjAn8x2OGXsMYSwHoWhrhp6L7BXfTcD1Nx?=
 =?us-ascii?Q?srQjSdwGM5O+KybZ2KOPEg5ydr3PXtzO8FHVO5rMwm+KJa2ak3HyVa1yoPyC?=
 =?us-ascii?Q?Ktzc+CQe1w7mrWwhy9kqHTK7MdVcYLOnGpecT2cH6kDddVCWLTgXP98FXixD?=
 =?us-ascii?Q?H7nIPfVaYiI3+9L+tpWsXCoyGO6H84CHzoSPWK0TOoAneTGPR6cK0rDQoEHu?=
 =?us-ascii?Q?jGt5xtCS2DTqmNzN8j/vc9Eh/AYv0mTuXlFYzFS0Vzvxj6XNH5cGJZzeS4qq?=
 =?us-ascii?Q?qQFXlaWFxTev9EBAbJ7MYZPSpc/ZD6bH6mLcvAVGSmqyXY2BY0TGek2wHMLb?=
 =?us-ascii?Q?e/PrWFu40dMi2Og5m+LYf7x9Km0UUcnNJ45IRqVK2McOx5Mw45rfoEHdQ1Mf?=
 =?us-ascii?Q?/7XCROlHUFDYC9egWRvhvQS8S9bjZ3Sted8eG745+pQoNi23O6obFQwLrqvt?=
 =?us-ascii?Q?C+kd449D3EfBZDQHv7LZkO9Wv1FYO7UE4t3EW6T4mX8w2kLPl+P84lXdv3jc?=
 =?us-ascii?Q?RuieAZpHjJw7z2eUobW3RmdylHJVe6xWMll90kMNtEeL37XiiX6W4RThv404?=
 =?us-ascii?Q?Bd55DT2MmyCr1ko8rQ6qUhQLjUNjoUo8OM+cHffXTfC9iKbFgRUeBsE9fzq+?=
 =?us-ascii?Q?pWnKkVE2EldXfy4Q5ntsO6SbxRw8aMu1mUo9Lkx9k9bmQGp8I2GfRPlY8kj0?=
 =?us-ascii?Q?0YhAdE1YEi0D9P2MJjMJ0pbNfKb9GCN4FgMOTcNEJX078sN+f/8wh5bscfkD?=
 =?us-ascii?Q?R5yAWHwRss/5eKUzn5pxWG3ZARdWf6F7ZlcF2TSpXWFA2giZGWOg7wsPSk/X?=
 =?us-ascii?Q?7t5CUH2Z6zJT14Rq/m0djW3zWsj/LXu8UfFWPTlxcgHHq5iX8w2cmmBDqEwE?=
 =?us-ascii?Q?vzL3McKA2NM6NkMJV1bpWJMWy7k7RGvff/byNbuy5XRMCddtLEDsym5R0/Zu?=
 =?us-ascii?Q?8dLr3iVhegGd28O5UiVW92c7BmPyzGCunju0BCQFU4ifjFt6HhY3aq057xgG?=
 =?us-ascii?Q?5/AJIJ7dnl3yIoRfTG4uYJxUcK+mF1m2ceAgy6YhUX7lku/GA7+Sp0be2pyQ?=
 =?us-ascii?Q?+VQWipWu1s5IibC9grVpKtKyRMDIOqR7F0qXcOcDuedmRLRrH6B7mp57LBxQ?=
 =?us-ascii?Q?96By1HB8pTt9tA2O38mtA+BNQoFwF4kAjvH+wM1ktKuhyIpdoI3bMsuYPHrs?=
 =?us-ascii?Q?16Nt42VOwDYDi0Bw1SaeFsOEoS9rZl4ZeeuuWz85WQf8d5C3oW8B6A3rEOsi?=
 =?us-ascii?Q?vrG+y2b8tpVre24lh7IBzXp00wJtp6050rSl5dIzefgOT5P/W9ST4hnwMvox?=
 =?us-ascii?Q?41btDCIa8PLx7uPz4w+fU1Yn+deV+Wlzp2+M?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kNQrjiw0WMJZdu9WgZjpNyD1ZAUaPSA5rnXb3g8BV0WvgaOquWoWT8BrJkxh?=
 =?us-ascii?Q?gw/XyLAiyh8QsVoQEYcREM/WRVzAJdtjMvrRyuyGYUybFqWunm6QxC/hrsXA?=
 =?us-ascii?Q?u6zOMGvNV6cv+P22lZn4/QZC6arTqDk8AHpAeI51/rNkhnVVAwnrT9OHrTz1?=
 =?us-ascii?Q?a6FGAz1LviVl2QMh2yVwhkFHD4xFD06kVuHGMXYZYgxwPblSLnskd/cz9D/i?=
 =?us-ascii?Q?OKs/tnuUiaCD/FkZyCDIDQhZItBuTvaemYq6Mv+N7jwwn/3Yt0JUJ35G8SUu?=
 =?us-ascii?Q?y4DDGLVR++C6rRnVyCm3Z1AXm8P9mmffHoYH9thMj94eQLAjer5ih0Ej91BT?=
 =?us-ascii?Q?ZomVdVAYBbL2aKz4To04Cg/56418hcJDDk3fsx/tY3EVDsaB3/RBfKsySAt/?=
 =?us-ascii?Q?xo3jCGXEAdBkF4h9voT6OBv95jU9afivg8m3wxZLGIzmzH9TsvO7JR0NytAv?=
 =?us-ascii?Q?6bn04jGyN8DwlRRn14cW9h7GARalH+2pueEsdUgvFEBpaHxAypK6DcReGFyk?=
 =?us-ascii?Q?lVzYQEf/8UaXbTgex5P3dn7VWkWY2jo7P4l3IZDL4V9K7fmFMjwiQlVxKgRt?=
 =?us-ascii?Q?+8+dcqF6aLWna6mOK8u24yYs0CGNgDWPZR3jwhQZmyUB2EWmrDXaBDpiVrjy?=
 =?us-ascii?Q?YRGAmBJWAJBHoaTZ9IuTzEtlIW1WmPXR9EPfi59VCJIpFTggSDfeRn2lU/oe?=
 =?us-ascii?Q?nXxg50xqPJ36zlvgoN17QOvMRbrIa4tptTi2aPtjVY1pVRSEzbgSR8pGltr2?=
 =?us-ascii?Q?HY2PlauqodrQg2gur6OA/b0ZYPUXLvDh/x+qf7yLIScLdMWV8Byn8Tci6X3T?=
 =?us-ascii?Q?TI0jc494PEriyxvJmIO9fyOWeoggB7XZIx8Bk8YQgyoQwRAvwnT1IfmhMFHi?=
 =?us-ascii?Q?ZwVshPyYq6ocUZB+Pb26O92OlyMlH4au3tFxt8V1qEa9KrkQlGrpJrmL2a6Q?=
 =?us-ascii?Q?Cfr8GKV8n1dfkx39JwaawNJDrZTt6IddbiS3jNrSkXWqPwQXmkXQ//4IrQi0?=
 =?us-ascii?Q?EvXDBZCLfDK299mJgKFbYZyHA2uz1P+rWS87Ufe0Jc+Gx7nUUGxeIde15l91?=
 =?us-ascii?Q?TWYc6RrMnLuy+kvY92RkmvIchfnEJ9WKn62mtg5blANLusg0ZuIJzCHacO5e?=
 =?us-ascii?Q?HNqlEhpJkVYxycakSVMXLA7Ez8dIExYheoxREgZnTZHB/MuSiK65KpjEyegw?=
 =?us-ascii?Q?BfoUMAU+TrAlMIa0kLdMSSOi/BfJyXW6hPiRSHFFa5fPzQP0dbS4LDl59CM2?=
 =?us-ascii?Q?JrgoJp6SvqHKxwpapkDFjvaUqZ6hzs1IPeVJ0g6m/zbAsvdAW8ylNlutsQk/?=
 =?us-ascii?Q?tMYxkLQb+vdGCK0b1I505s03l6q3Thxru8SD4KEax16TZip2Fm/N62oihfre?=
 =?us-ascii?Q?DIpoXHGOP1OPOAqPP9Y/5QRicax7ocRO5Q4096Dzel46crBcEq6l1sKje7Rt?=
 =?us-ascii?Q?miVDy44eabOWyJd89+v/yVJa4Uoq2NZ1Hzh40ENvfqVKV3+axSvqJNXmxLGX?=
 =?us-ascii?Q?uVEMqthuF2dpDDfRuTQsmTLWD8xfkBDdwqYvEdFZAp+yIKMa4XoHpiH4GaLY?=
 =?us-ascii?Q?OfAzKZVplBYzXM0wCz7wsxBLY179gvp2yFd+jbjOIB2kKVFvNrXucRqPl6kz?=
 =?us-ascii?Q?Hw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06b379d0-256b-440a-50a3-08dd7d06e26b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2025 16:51:07.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8pDn4HJRznlpykyregYS+NcIYIIvTQ3pSUGdIoXnUe2mPe8y4LJuNqRJRvtNsUYouJIOwLiYC5iUZfPhY7NBmcQ6wvO3pdGay7aiKCJmt3ZK4BlYEz1SjOIlklUQkVx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR07MB6345

> -----Original Message-----
> From: Victor Nogueira <victor@mojatatu.com>=20
> Sent: Wednesday, April 16, 2025 2:22 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; netdev@vge=
r.kernel.org; dave.taht@gmail.com; pabeni@redhat.com; jhs@mojatatu.com; kub=
a@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@re=
snulli.us; davem@davemloft.net; edumazet@google.com; horms@kernel.org; andr=
ew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gma=
il.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; n=
cardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-=
labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.co=
m; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason=
_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Cc: Olga Albisser <olga@albisser.org>; Olivier Tilmans (Nokia) <olivier.t=
ilmans@nokia.com>; Bob Briscoe <research@bobbriscoe.net>; Henrik Steen <hen=
rist@henrist.net>
> Subject: Re: [PATCH v5 RESEND iproute2-next 1/1] tc: add dualpi2 schedule=
r module
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
> On 4/14/25 10:18, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > DUALPI2 AQM is a combination of the DUALQ Coupled-AQM with a PI2=20
> > base-AQM. The PI2 AQM is in turn both an extension and a=20
> > simplification of the PIE AQM. PI2 makes quite some PIE heuristics=20
> > unnecessary, while being able to control scalable congestion controls l=
ike TCP-Prague.
> > With PI2, both Reno/Cubic can be used in parallel with Prague,=20
> > maintaining window fairness. DUALQ provides latency separation between=
=20
> > low latency Prague flows and Reno/Cubic flows that need a bigger queue.
> >
> > This patch adds support to tc to configure it through its netlink=20
> > interface.
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > Co-developed-by: Olga Albisser <olga@albisser.org>
> > Signed-off-by: Olga Albisser <olga@albisser.org>
> > Co-developed-by: Koen De Schepper=20
> > <koen.de_schepper@nokia-bell-labs.com>
> > Signed-off-by: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> > Co-developed-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> > Signed-off-by: Oliver Tilmans <olivier.tilmans@nokia.com>
> > Signed-off-by: Bob Briscoe <research@bobbriscoe.net>
> > Co-developed-by: Henrik Steen <henrist@henrist.net>
> > Signed-off-by: Henrik Steen <henrist@henrist.net>
> > ---
> >   bash-completion/tc             |  11 +-
> >   include/uapi/linux/pkt_sched.h |  39 +++
> >   include/utils.h                |   2 +
> >   ip/iplink_can.c                |  14 -
> >   lib/utils.c                    |  30 ++
> >   man/man8/tc-dualpi2.8          | 249 ++++++++++++++++
> >   tc/Makefile                    |   1 +
> >   tc/q_dualpi2.c                 | 519 ++++++++++++++++++++++++++++++++=
+
> >   8 files changed, 850 insertions(+), 15 deletions(-)
> >   create mode 100644 man/man8/tc-dualpi2.8
> >   create mode 100644 tc/q_dualpi2.c
>=20
> Hi!
>=20
> I compiled your patch and am seeing the following warnings:
>=20
> q_dualpi2.c: In function 'dualpi2_parse_opt':
> q_dualpi2.c:218:37: warning: pointer targets in passing argument 1 of 'ge=
t_u32' differ in signedness [-Wpointer-sign]
>    218 |                         if (get_u32(&min_qlen_step, *argv, 10)) =
{
>        |                                     ^~~~~~~~~~~~~~
>        |                                     |
>        |                                     int32_t * {aka int *}
> In file included from q_dualpi2.c:39:
> ../include/utils.h:157:20: note: expected '__u32 *' {aka 'unsigned int *'=
} but argument is of type 'int32_t *' {aka 'int *'}
>    157 | int get_u32(__u32 *val, const char *arg, int base);
>        |             ~~~~~~~^~~
> q_dualpi2.c: At top level:
> q_dualpi2.c:516:27: warning: initialization of 'int (*)(const struct qdis=
c_util *, int,  char **, struct nlmsghdr *, const char *)' from incompatibl=
e pointer type 'int (*)(struct qdisc_util *, int,  char **, struct nlmsghdr=
 *, const char *)' [-Wincompatible-pointer-types]
>    516 |         .parse_qopt     =3D dualpi2_parse_opt,
>        |                           ^~~~~~~~~~~~~~~~~
> q_dualpi2.c:516:27: note: (near initialization for
> 'dualpi2_qdisc_util.parse_qopt')
> q_dualpi2.c:517:27: warning: initialization of 'int (*)(const struct qdis=
c_util *, FILE *, struct rtattr *)' from incompatible pointer type 'int (*)=
(struct qdisc_util *, FILE *, struct rtattr *)'
> [-Wincompatible-pointer-types]
>    517 |         .print_qopt     =3D dualpi2_print_opt,
>        |                           ^~~~~~~~~~~~~~~~~
> q_dualpi2.c:517:27: note: (near initialization for
> 'dualpi2_qdisc_util.print_qopt')
> q_dualpi2.c:518:27: warning: initialization of 'int (*)(const struct qdis=
c_util *, FILE *, struct rtattr *)' from incompatible pointer type 'int (*)=
(struct qdisc_util *, FILE *, struct rtattr *)'
> [-Wincompatible-pointer-types]
>    518 |         .print_xstats   =3D dualpi2_print_xstats,
>        |                           ^~~~~~~~~~~~~~~~~~~~
> q_dualpi2.c:518:27: note: (near initialization for
> 'dualpi2_qdisc_util.print_xstats')
>=20
> cheers,
> Victor

Hi Victor,

Thanks for prompt feedback, I will fix these warning in the next version.

BRs,
Chia-Yu

