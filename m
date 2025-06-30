Return-Path: <linux-kselftest+bounces-36118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94F5AEE53A
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0256189E661
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17BF191F92;
	Mon, 30 Jun 2025 17:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="B8v/zTTV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011051.outbound.protection.outlook.com [52.101.65.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAD2EAE3;
	Mon, 30 Jun 2025 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751303103; cv=fail; b=nOqZdb1NAEXGcrfm1FKxKfLyyhOje0XWKU3x2TGSDX28yr3+1x8sJqgseaLRopC6XEVIM6YOF2Pab6hEpBW0Ak2be7KuZoKMTgR0ypUbqSXyA7yPRR3EZsIk3JefE1xpM2OvHNXRTZhFFwNfI+phhwFmbxD/1pjU/Ol/uxc9F44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751303103; c=relaxed/simple;
	bh=V9cbp3hfqWmKWsAjpUA4W0jHA+bDLR6l/Hbl4pnmdKA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eu4xGYi9sVsCI/SzehWVXJDSEgL6PGXmUfnX5ALJ4vzmwwP7lmYJtMxCbx0MVaBzMYafAnaMKTD9kdDh10NRdOGVl6H5YBgV72T6LTBSZyAV5ESkkVOpXJA/0eOkBB8+YMeopogyFeJRE1WePlGDIX28RMnbpUCp2ag27yjHTzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=B8v/zTTV; arc=fail smtp.client-ip=52.101.65.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESvdsy10j65G4lQDrhF3HtkBov3eYKqFC3tczRSotRqaAUKL6dihtutIITKuUMlaTAjT/kA2V44CMfvQTFdErpZKMaGXGDEC/ct72/X/b6fFLIg832CLTi73OK2dfIroPn95pUS/NkW0Zu8uvoBlo9qUfADMpWPXZ8/j7ZoHkCwlllJQRh8mkLV1mWxXzXpV7toDCRZWlgxQIkG+Yj87Sc8LsBYXI65UTF/r0U2LwnNIXwjLgCNJgPC7o7Fls6Va0fXpBJpKfiv4kXWlExR2xtOXP3GKMA525zTCvRcWTzsCWkcjIgsq6Y1/SrAODxQOr0t7AS4HG88zkM+Cp5JKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NAIsxgUCAonCTdlwfP67iws+in9gAtEHpHdx4nV+Gtg=;
 b=hNgr0oyGipwkGIme6tuyKarnGE3xgFJoFuhq4qp7umYgbHVUJw17YEZwmPejn4N4O3Ejl9lIKfUsD/vXXdq6K35f817je0tH7eg3P6i4mDaMja2XQ5p8JOWnzZTuqly4NAuiefJIcj3MiMy0/3R5LoUWShaVGakYpoIkHJtNVfKw01t8/IF8wa3Q6aifRNFY0H7hIvMlbdxTn5M0NEpHJsM//RGh486bgSxUqNPqpIWyQqhdloIl3U6kYI/nAvdujNqv367g07qnoGkcux5afnwe6Y4Z0dD0t7s7Hu96iHGFZRf3z7flw1/hWxmC4JPV+tabIxmiEHzRDbvmAlbtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAIsxgUCAonCTdlwfP67iws+in9gAtEHpHdx4nV+Gtg=;
 b=B8v/zTTV8IPoaXZ8jHn+VQYNATxtP0hhb4QaQvy1Vi1gT1/R2L0MyxZpyfrgRS9QLrPkZGJ1UtCENWhz4tgKNtmFo4NiNlTAkvRUGMvDGGolJ6mz2fUOda6Ii9DJB1CFT8WamOdPFl/UhwwxKGyqwtff2dMYK+fje+/cEofCka5YHNms3dI7lszTlauWLNmQqxAWuFNatuNJWrnEIGd66+Gj5FzrOl7BEu3FLpYCk1nIxVOQ4lZdHaAEj14aSxAzUC+6c2h85SHJbTuHfGiorX7T9BvMnWmvEQVSZkpxURnUcRmHM0BkRK+EsHaDB4Lus2w8wAxU0XpUWa3lhiILnA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PR3PR07MB6666.eurprd07.prod.outlook.com (2603:10a6:102:61::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 17:04:56 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Mon, 30 Jun 2025
 17:04:56 +0000
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
Thread-Index:
 AQHb4uNmCaO8PxZhYUCrH1BBViihEbQXr6IAgAMajRCAARMzgIAABBIggAAPVgCAAAsGIA==
Date: Mon, 30 Jun 2025 17:04:56 +0000
Message-ID:
 <PAXPR07MB798410A4142386C43B2E0B1DA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
	<20250627162502.0a82accf@kernel.org>
	<PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
	<20250630081349.4c9d7976@kernel.org>
	<PAXPR07MB7984F85A786D9B35898ECEBDA346A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20250630092316.031b29d8@kernel.org>
In-Reply-To: <20250630092316.031b29d8@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PR3PR07MB6666:EE_
x-ms-office365-filtering-correlation-id: 637b4b02-e920-472e-6dd0-08ddb7f83d1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?K67tmTytXyjZjXg5v6GBNw6ChpaZala93qFIj8+jZzIcsDyj3NYiy2BTrYzI?=
 =?us-ascii?Q?/79tZIrVIx473JiqFeWjpp5doHxSgIoAHZqzgZLsR7PyAgWXsUC/djICBZS8?=
 =?us-ascii?Q?dTWXsA93R1RH1Pwpyw078Rf5IYX9QUUQqsdlBPg+fYJdPpSRueoqI1kjti3h?=
 =?us-ascii?Q?vsjoQ/7cJCJQd5HoBhTUAivBMhRVK0Nyv2fxVXwaLt3KqykQ6bVaTNsgd0lz?=
 =?us-ascii?Q?aZ3dtUXW9l0Ycvay4JAAkcg2ZvFfc9O2lSsQBImlzuaX+PTADrBSbOcUSMYk?=
 =?us-ascii?Q?rBgcGpvzuTkj2SwbycHCAdDH5tKLhExjvGuXfZPtqDvnE90ttucVak/c+xYL?=
 =?us-ascii?Q?qNxPXB3WOG7P925zSvtkyw8K2eV0JvOcUBluIPk1n62u5T0lzt39mLQdhi1Y?=
 =?us-ascii?Q?HSiCRxB0wUwjnVSxO+MhQY0uONd/g5R47+bLktgh53zq3Ed2CX1PY3IpkbNJ?=
 =?us-ascii?Q?vbYZn936PUmSBwiYETWPah0UF7bKqN5Nm8hyPkZWHoG89ZK7Sydi/Yg2Ij0+?=
 =?us-ascii?Q?JQ7BBtTbRsERp/H2rpvLnTcY7CliTK39W73oymhUEM4qcZQnvSXEguZKrREC?=
 =?us-ascii?Q?ihGuThfhx9Z58STF0uWhTXGA6Rnu/Q/ppWm9KgODv2zueUM4ccUuasemkYyo?=
 =?us-ascii?Q?lBsrLxwPKCLhlj8fnvc6U3hPBpD1jQzGg+la5d6SFgBWVVSllyIDvCFFuu+G?=
 =?us-ascii?Q?pLOt2DYzVjyoUta1uMl4bj4ey2nok7KEkkSBeMXhRjbhQDbUnnDEVCBCLwxJ?=
 =?us-ascii?Q?R6iQWXtahO9/GHfwnfZdCR+VNBgX8Hh7egwo+Xy+TlJRGNMHdgQ1Cg352Jml?=
 =?us-ascii?Q?hcAuRvYUVjYSSH1goTsMo94v6cfnn8nHEJuc2/zimCmYVIjuEm0CUiGqMbig?=
 =?us-ascii?Q?iX62zQUvXaiJXDi2mQNXuloEN3PsZNpyYiG/ICx9MMFZBh44ZxCuu0WSMpv/?=
 =?us-ascii?Q?qm/wHMZKlshYiCAaYxoFncuHTtI85Nf3JSM3qUpMaEwUZTHvx/e7cGW/+kBx?=
 =?us-ascii?Q?sRr9PibYeWvaFPNXRyqI8WT45d7BkMNXGtd73X/ZxHvVlf6dyeeltqk4Nndn?=
 =?us-ascii?Q?mcuT47UYRFI27muMbVNCO1RrbPxVcKSoGG7y64XQF2xAIxYzVnQuvFQeaPYb?=
 =?us-ascii?Q?dSFRfkFyuPZ8ucjBctfFIuyWlaXIPeHPuJj9IOSCs74v8CrDBnWs59UFUKLA?=
 =?us-ascii?Q?GAm9VykFShQUU2f1o6VLGJ2gtS9Lel74v/CAUqI5GoUd3t5kYuW87OonRb1J?=
 =?us-ascii?Q?zU09hErjkv4cDbrxQUs/x4ntQob3weSS3nJB38WgjWMWLi/GiXDkps2Lwlv1?=
 =?us-ascii?Q?00c590/D7HVwBDvatYLWFvxnYZKnnN6Vq/3ydWqG5scU/KhSbB5BjWkE0vqx?=
 =?us-ascii?Q?5nqM5Km3eVW25mefJ8TfZd8s/MJAfYLMKicWksZlxDOaHPJu3YkCvjB6NK2+?=
 =?us-ascii?Q?EACM2QYcYRoSZxIpVt0tGpMnYgKBDc3mUHsZ1flDIwe5QEp8VprHIEoW2L8t?=
 =?us-ascii?Q?o7LKAFaOtoZqlfQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1dHozRthuJzHDX2DieJF0w9/Kzb30hI6/RfwfEsN8KxUIya1Dr4QDJK9kRid?=
 =?us-ascii?Q?IhYp8qaY0OdpQaa7xEF6gT3RMs00QHOVTLC1Nc9eABgjt08pDWHT+yhKetSs?=
 =?us-ascii?Q?75mrZBKwNdz7jLMTkpg4/nfd9wHda7oyeKgCXYXUqaZ/DoKy3YzR85VN7WvN?=
 =?us-ascii?Q?V9Qr1KX8T/V1KTTHFqtEFnfig9Uh8ZRG/zucH0E0pPrLe1h9QngoQG7mYccH?=
 =?us-ascii?Q?FRXDfQCGHkelAa1bG/MzaGBgt9YJaQZ1kWWECrU0dT21N+Pf47nXbb/I9/El?=
 =?us-ascii?Q?sS7AtXsse5pKHVpRzDAZYP4V9bXYioCyo9CMfQshBL1W5RXtn0Rh8RCEA2PG?=
 =?us-ascii?Q?w6eat7kll4oMfDTwfdJwYG1DpmiFvPyR83p398izKcuDXdjRDejezdPHJJmX?=
 =?us-ascii?Q?YM+bS47Jy9VDI+t60Jx26iERkbLKcPj7sHQZQCVG4676LUkqN8WyIP6FaETW?=
 =?us-ascii?Q?Y02LZyaMk1PcUxSuLDVnfcQWhP0mVHWqk8BEpS2pXCsaX6yecYkgVwYvFc9T?=
 =?us-ascii?Q?uV8eVVDobRs6OHjQ+lVfY1NDm5aCxu0++PcqsvCHEdxUyO1TCaBbxO/5CW6k?=
 =?us-ascii?Q?HQHXCCyJBxLtsBKNAJb+iG4YKZ0JYHASv2AOkuAj7/duWEt6GWopg9FlTsl7?=
 =?us-ascii?Q?fqQZqt9OAr/FKeStwCAYF54FfPaL/5+8oszbVxNgf0Xh5N/lpEv2Yfds7xX0?=
 =?us-ascii?Q?5jA1uoILEx5uxPfvUyc3jfRaoWGAcKQoev/dO4zwwpopS28tS777gnDZBL9J?=
 =?us-ascii?Q?lBNUZjwMRieoZHS7AbK2A6txq+kdI7nLdQ+GcV9OFexMFuqbHVlmO4rACN8l?=
 =?us-ascii?Q?KM3OBG4kveUGevGdYCNDaE9FzTsjLFNgS8rjwMgHH5ZT3oe7cu9u4Sdu8pR2?=
 =?us-ascii?Q?1JjNMk7gBRqhLBu75Ljd7vxjZQhaLC2JOiwh0gPqlebRsQFD6fViXfLL1I0o?=
 =?us-ascii?Q?lbUxNS6uh6aqPwezESRaZVuTOy8SR1DPiB6LBaD36q7b/UQ9B2D9BATRl71S?=
 =?us-ascii?Q?WykxZlO1Z0e5tMlWmo9mEP1DqA42ceXZpRKbQmCaVXs/bKPly8z0x/O7noyZ?=
 =?us-ascii?Q?froazhLhGNZDeT06YDTLmTQwzc5wCZ55iUJBk/B1/P7QfdLYpPELQ45cQyGK?=
 =?us-ascii?Q?Mgc7CQb/CayomuDuJSZgQm0Vete7xi6QYkXZ5EYhOHdp+6K8/nd9mS/xQaFH?=
 =?us-ascii?Q?y4kokoODNqIFY/SB54O1IhRXOIdC0eFmbYTC454JlmwbEMjQQbTj0s6QQhMn?=
 =?us-ascii?Q?v/m5Ww+tJOBG1urCrl2Kk/JqSQyH/8JhEDLE2hehEFd2ddbX0wxRAhpPtcbQ?=
 =?us-ascii?Q?o1CCvMCBpSKEcyMLv0MiPaJF2YD0GjHwDFWnvN75I2gKS5Rpa2RPt/B2WT8v?=
 =?us-ascii?Q?uyfINOH+ML3YBSSyHqLj3pd/kedMUFhKLVIyUnTb8QZOdO5JJ4k8JcIL1XTa?=
 =?us-ascii?Q?bQTKyVOBHjTjaX0dqLA0ZSgRlJrLeMk7PAbug2dz+yvsQxm1T1xUYYykR+TU?=
 =?us-ascii?Q?WAB7SFkw9aSBO5n3rOcQOuePARzKfaiIgoB56MkBrADgRLUy7w9d4l4reFLb?=
 =?us-ascii?Q?qn065kNQ+4+dptVthI9ywSDtw/gMG9k++h7B2XhpIy/E6LcNKYdHAkBhQEb1?=
 =?us-ascii?Q?vg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 637b4b02-e920-472e-6dd0-08ddb7f83d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2025 17:04:56.1134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYO+ZygwAcwL3BQafQx0bjXOfZIHSv4/Lyn/ajahN73Fq2iAL+Hf5nd3ZrAnBCuPI1EKDhcfT8ZeQcMaHfkRDW887MoA94O2ApH7AhxzsBV+6CnletasllI63qGlosl/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6666

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Monday, June 30, 2025 6:23 PM
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
> On Mon, 30 Jun 2025 15:51:11 +0000 Chia-Yu Chang (Nokia) wrote:
> > > > > > +     if (tb[TCA_DUALPI2_STEP_THRESH]) {
> > > > > > +             u32 step_th =3D nla_get_u32(tb[TCA_DUALPI2_STEP_T=
HRESH]);
> > > > > > +             bool step_pkt =3D=20
> > > > > > + nla_get_flag(tb[TCA_DUALPI2_STEP_PACKETS]);
> > > > > > +
> > > > > > +             WRITE_ONCE(q->step_in_packets, step_pkt);
> > > > > > +             WRITE_ONCE(q->step_thresh,
> > > > > > +                        step_pkt ? step_th : convert_us_to_nse=
c(step_th));
> > > > > > +     }
> > > > >=20
> > > > > I don't get the reason for all these WRITE_ONCE()s.
> > > > > You lock the qdisc to make modifications, right?
> > > > > And the block under which I'm responding is performing two depend=
ent writes, one to ->step_in_packets and the other to ->step_thresh a chang=
e which is definitely not atomic..
> > > > Thanks again for other comments, and I will take actions in the nex=
t version.
> > > >
> > > > As there is only one step marking in L-queue, so we still need two=
=20
> > > > WRITE_ONCE even two attributes (one for threshold in packets and=20
> > > > one in time) are used.
> > > >
> > > > When applying the step marking, we need to know either the=20
> > > > computation is based on the sojourn time or queue length.
> > >
> > > Let me ask again - why do you use WRITE_ONCE() at all if the=20
> > > modification takes the qdisc lock? Which reader are you afraid of=20
> > > racing with?
> >
> > This still needs 2 WRITE_ONCE even "step_thresh" (NLA_U32) and=20
> > "step_in_packtes" (NLA_FLAG) are replaced with "step_pkt_thresh"
> > (NLA_U32) and "step_time_thresh" (NLA_U32) - which was proposed in my=20
> > another email.
>=20
> If you don't understand the question - ask for clarifications :/

You are right.

Could you elaborate on the orignal comment "And the block under which I'm r=
esponding is performing two dependent writes, one to ->step_in_packets and =
the other to ->step_thresh a change which is definitely not atomic.."?

I don't see we access the same atomic variable multiple times in a single e=
xpression, the 2 WRITE_ONCE() are in different expressions.

And, in the last WRITE_ONCE(), what we access are local variables: "step_pk=
t" "step_th", will it create problem?

