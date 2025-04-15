Return-Path: <linux-kselftest+bounces-30881-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09446A8A260
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 17:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D09C1881B52
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8D8158520;
	Tue, 15 Apr 2025 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="G62sJs/M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2087.outbound.protection.outlook.com [40.107.20.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505541E51D;
	Tue, 15 Apr 2025 15:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744729534; cv=fail; b=gwlGYewca5jkGjHIwPsGryzhtT0kcSJcZlUHe2rGuDhsOKijWxnO9dqZZlS5Kqusf3GdISpaemYPQXsQEBDPQB59C2awgdaZETPTvGmwwPmL9BdTsEmU7VySZ1VKKDMZkVgSmQ1uz/QiyYL9kOkRFs2qIruE2U+/J1qt5vBe9B0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744729534; c=relaxed/simple;
	bh=5UQooJXFsiiXnRhZ481ITiefIIShxOwdsuZjmfPZteg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CXq478QxDlQFwXld+Q0SXZ6DdmsoV3NiotvMS0j2W7vXXJXa14fzbM14Lltmz4O/5k3G9DfSUkC0HALH7xxrvLNGaIDcbfydRADN3pZ7YVdsmJZmhU74e2CVxWzzDhHzxYB9GMOoAtcJSGlg2lahN2uO8srURsje+oHxXY7MzNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=G62sJs/M; arc=fail smtp.client-ip=40.107.20.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uoAaj8lO2MF+IP2UBGGRAwNkyRmq7olYsxcMBPIfvfVX67izliUgaqCZztOc1+cCWbULgznEwyIT6ZYn9kWbUFgJJ7mZvTFtNCbdgt4cOqJ/B90CNkKQSEA90D/Z6mml96w5jfo2mCJwebQbUT3xppYjstJxA+2SIrwUG2B8wgF0qcPFIrvvFM8/46l1FMICEmNjn+Q9/+PjkmQ5duNiJt2WupjTCAXBCHG5JPQ/aGKbKApV1N6UqPRYH6h6aGuDD4zesrBW9Sn2xw5dfM6H9ebvePU2F7BwJrjVD0FdX9PRsZxXaI4pX1sYDql+ZqXr1xaMFLbzsCYzDMQnmmR4rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/gHble+HKoh3+Ba8Z87FaKJIJWxBNX39RvRafIa9ok=;
 b=A6sToNRi94fWQlsGBC0l3i5ZABXKGzRni3k1tZ1YGW0VhupGvJT2lFlqwfeDBL2pbcDkyAvQikFDJXUvwWwSJWNQs9rTPlkfKKiZkNSYRLOHa0ai1W6qs6EXITtQQu+ip10iXVehpXE7xoYlhbOXfQYXGHPCTZljS9wROAjQeJ7nrqNom1njEf+R8Oq5oQz2ouYTK+RYTBPlNEcFSsGMdFywXnX6vpx7Sv/NTyACInYVj8YUBNSpjt3SBBfEqA1CLc57PhWacEKScYPBWlBvOJh2L+JfnQIxzGZ94CwDffVR4LDFgAg7Pjq/01+DOY4eaJktPwv49RK0MWH99GJ7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/gHble+HKoh3+Ba8Z87FaKJIJWxBNX39RvRafIa9ok=;
 b=G62sJs/MqkOBGVMExvuhi0AmfpkLINvmz9LIfsDZDkDL3aDfPRemxx1ueyBtuSYj3gNS6hXc1kSUMpa6kXZkVpVIjcFB5JyAM+dYCow/B9L7a1cP3/pv17JiUbxis+soBvReJlmgymlwZL5lRSD7mpvXjLRYPKGNy8ZcDNPswHACljZMaee+K2xqjF8NYlowBJOPJnaeMCn+0oMfBiWC9LP6rfDPS2Eoxgn5384RBrjpXYKOjQw3Te1pqKVYsZ/gXyNpcW1UFTHFJx/+ZjGFMNoNo4a3/D5NV2c63A6kWrux99k5/joypWsfWHZvyQrvc4O5dihRGxh4Q2tNHa3X4A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAVPR07MB9215.eurprd07.prod.outlook.com (2603:10a6:102:317::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 15:05:29 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 15:05:29 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "xandfury@gmail.com" <xandfury@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "horms@kernel.org" <horms@kernel.org>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v11 net-next 0/5] DUALPI2 patch
Thread-Topic: [PATCH v11 net-next 0/5] DUALPI2 patch
Thread-Index: AQHbrgQF62lYmTPW00eTqXQlUlj+sbOk0ZcAgAAAg2A=
Date: Tue, 15 Apr 2025 15:05:29 +0000
Message-ID:
 <PAXPR07MB798477409AF023CAC191C70CA3B22@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415075814.5b182f04@kernel.org>
In-Reply-To: <20250415075814.5b182f04@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAVPR07MB9215:EE_
x-ms-office365-filtering-correlation-id: 63328182-e00e-4f21-1228-08dd7c2ef5f6
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b8V1QgG2VL30sVQl835jdTEkNohCsFqhzT00R5A33FoMpxlJQhDzy+89LwB6?=
 =?us-ascii?Q?C9G1hEqwCyKDOkNoLNY1Mi6Dx5AbNRvQI/3mAZEzWPNz+m/Inj5yFqKckW8d?=
 =?us-ascii?Q?Wm2UmjsL2P9Qzn0TrH+2Sy9xFA5/u+c3FYwROWL88FUJNvjlRwYxJTdT+3JK?=
 =?us-ascii?Q?dRUQMP2M81RqTcGJJgAswjahGk+QzWYj0Ch7wN6Na7eq08VkO6E1jLZdTmDp?=
 =?us-ascii?Q?aw9YPuAjcLqFGN2ufhdiQVVT5kUV8dA2p/yKPFU485FOVKgsffOReyhF6KH+?=
 =?us-ascii?Q?EGZBy2qsqSnOjLbTDn6oSUGmxcKSKPWuhHru2SvLtbpZMWhzSV7DL6RaAvIF?=
 =?us-ascii?Q?j7Ik3ukaGi1QyCJYkZic9MF7y/0MsVI18cyExm5evIdJp1YN8Ddi654Cn7Dv?=
 =?us-ascii?Q?7yjgNo1q3avhYlPetfbhgPTplSwWUT542chU27wiaZXBEc0Dmk8ukQYWSeMi?=
 =?us-ascii?Q?NL276oAKLGi1w2o3csBT/DkLkABdTH9NBjuLmhJZBL+zlZwaFx+D6Ht7/KwL?=
 =?us-ascii?Q?GexUdlpCF6EgmI7XRL25Ky/SLh3zBDEg8Pk+8elS7UOFedn21CcKSW6BMLY8?=
 =?us-ascii?Q?/aS+s4K6oM4SfVS/VWGoovYyCnNXs/Kn3olJsP2Melz17y4RTHaOGATY0roD?=
 =?us-ascii?Q?KHE8MFKWD86ybZWgs2f25Qk611PIwxvFeZ/t1gUNe9HasMDNRZgTWrqHQTlp?=
 =?us-ascii?Q?LF6pCIWv6nERNZBWUBxn3kMIpVlUo+8qr8ZBDNhVTfMUypizmAv23N+AWpAV?=
 =?us-ascii?Q?wS35YGFGZQis5YgT9wno1/rI8krOfoMT2JAHAzQuOCeZBvNNhi63E/6EcqsO?=
 =?us-ascii?Q?EOOtYrmePgHa2zl4GvVj/THGKQz94n6grKPTqjuX75mOWGaycngbhLzlnKy5?=
 =?us-ascii?Q?bQoPXoiShBFnelcjs4C51IbPjWUA/vp3cJWYWyuM/zl+txWRc2OKMc5IKo5f?=
 =?us-ascii?Q?wUz00NYymM5JW1AADZvU7lkC+7jlLCP4DsAZ8aArKGr/wu4jazVYjXZB+YxB?=
 =?us-ascii?Q?YIwj+ymiar7otifuEm3eCqGMAdndId7andJaw47u3dNVlFzZzLypjcf3HD7M?=
 =?us-ascii?Q?WwHZLUuK0YEd4WisWGeEyCX5x5UH+YRoGS1VwsG7dcXHl4aoWHzE+jPY8m9R?=
 =?us-ascii?Q?+FkqUySwkrw8mnz3KPh/rq8tj9Od+4+hzjnLN+30tF2+c1zzEOyKLQZ+VnUF?=
 =?us-ascii?Q?t3cvIjh2KGeWalS6+pi/JYWrqXtvJqzVn+CMbywSu9Sm1nCuIYytCBQuvOKO?=
 =?us-ascii?Q?ywfFMgzFc2FZiZY1Gma8garTIZdcPdFVavWdixXtA7bWtXMZyKJWqs1bYQly?=
 =?us-ascii?Q?7mle0CaGpqaH555edTE00ieH5qD/H4HWS5z3LSODYDGbA0G7Lgye+B5HX6Bh?=
 =?us-ascii?Q?dGRu41gsAKbtex2e/nd1BbiTCgktq4zen4vMboxhBUNNJhPPG4sw91Qy946d?=
 =?us-ascii?Q?bekUxGujvC3on0O0gosBmQ8GyhPRmh5qbXy3dDDVVbbozidTC72xRjnQJ+7k?=
 =?us-ascii?Q?7jND49pfRwkdq/Y=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gcrVZdeEnTzV6LxPDc/QBm0NyA4k+fECKLDZxIvxc4oOi9on4Dpd70cA1XSI?=
 =?us-ascii?Q?6sI4x279gN6YBUzFbxunJraah3xg9kTA8QUE22n5qcTZA9BiALnmUVm0AEyz?=
 =?us-ascii?Q?EpWY7rFN+UCzNCSyIWNOB56lTZwNF8Uo4zboDThvaP3XYBEZiK+xydLXhKsw?=
 =?us-ascii?Q?1z3PlsAnedFW2Mcg755M4lE6iX03+qpeliq7n1x/zAoNjN8mWSmYXaFSmzRF?=
 =?us-ascii?Q?Fxj+lb3OE857px1ZHGfcMOjtFOU4PRESQNgRV6Eq55lXNFCOB/9uY4sGv+4k?=
 =?us-ascii?Q?arDpBI3WdO9fIz/qFAZJjpWEv+rkBFT0pdUvirWG/f/tU/EnEzrgEpM1Gf0P?=
 =?us-ascii?Q?CNffpc+i4sWhwl3kq2ARi1GMwDtE+ka60d4/pbmhwnVSkLfFOfHdSJt5PPf6?=
 =?us-ascii?Q?mL0/DcnAO9PWfedd9t9x+8Vp71jjDvWRydMI3gZiF5g7eqY1YCLdpZWbIubH?=
 =?us-ascii?Q?iJgu60Nf+dtICtPWq4/LZT5H1VMat1EVwIYtb+1Z/n+HJO+KA9ufBno+KZ//?=
 =?us-ascii?Q?4RsmsZCVbbTxsesXLFvPw6GvZ/OgVbmT8FmRG6Fo8RWhD6B1uVKA8M8WyfjY?=
 =?us-ascii?Q?q5MjNAnHWWXAgiz+dyvSh9WseWbZ7er5OzOnDEGsr8oTj8kD4zZR8YqGxrJy?=
 =?us-ascii?Q?LuZLhTJ1opMdkt5WALjU8gb4iyACa6Ez2vVgOn09phESZQJB6xFX+my5GpLH?=
 =?us-ascii?Q?QBPHyxXy5LVWXbxJZlJ4nNeexEkKkD2w2jhetw9NRM4bMiocUWiNF9ylgCZK?=
 =?us-ascii?Q?apSQQpkDreFcPVqYCcw5jocLTBWtb7bSnUnWgZ2X24texDvIur/FYYvYBWeW?=
 =?us-ascii?Q?EeOyiWdGgjW2AWKZV4c/RTNTZ+HdCcBipJFllXQti0L/GXVQC8Zwy8oWnWtf?=
 =?us-ascii?Q?jJsgxOdO/BinZK4NZ9Mvhlb0v709QDC7DGxO+L3TPTOBp7JJankT2M9FFMDH?=
 =?us-ascii?Q?axQQRAItagHd1HZpWPvU8gtIFMdaLi3Sb9ScgVubpGUIAa4CrfonHRA1CXN5?=
 =?us-ascii?Q?pzMMqwaolzu22/0ZuwQnG7PfMJtsluemsytV8ThtBqC5rd9JeoMuaNzsWf8D?=
 =?us-ascii?Q?Oa1niHi7ktbBzQLHroGVtYQVpMCDIgGb/v98/UjguHxspyQ9F9qkmJ+KAL0W?=
 =?us-ascii?Q?Isd951BSPz9+0LwPRwFszvpBw45RMRRpP5UVp7K4VU8VYw2L5jjUrXwVQtC/?=
 =?us-ascii?Q?+K9hSozaiLWU/1E7/UMjRL5z+9yYuhQDowmN56Fc0kionW/hPOiI7frjieR9?=
 =?us-ascii?Q?qvaGEsWg/jH3kHeZoQBBssIK+v3SoyEXfk3K2z/s7vkziQgp2HA8SkIJDGzG?=
 =?us-ascii?Q?iqrVwpoiHJbN+uMvxy8m/Xmkyo79LNJ38d/OtQ7VczuxKR1U9q9p22IW8oPG?=
 =?us-ascii?Q?cZAfgBSLElMhXDhJ5vhbVwQ1B9hO/3La6tKuXRq0ZYGKxfrVp+5IPq2A/6ff?=
 =?us-ascii?Q?dzJAL25KoHZpbWEw7UM9Usy6FZkPaVo0X8neTbGlwHhfXoQuOFzWZbgQbVLW?=
 =?us-ascii?Q?cERzSvofHFdDOXMen/ALEPnZac33uPCjvWM+dgC88xu0cWXzT3zkgSCujZES?=
 =?us-ascii?Q?4pluxioqV+jtcAjG5yBXF51F6Z1+gW0WK+ZfAc8hKGn94nHr3UnOHpY+Mjqk?=
 =?us-ascii?Q?4Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 63328182-e00e-4f21-1228-08dd7c2ef5f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2025 15:05:29.3219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jlu7uQYX0Ggt/qJxajp23xREzmqzGKF4/tOvgpnoER8KqE3ipfFbKqvP0Ky+g93tuAD+o+ZwP7JPSzROPZaqLLn21VbAXbemHQoobM9oYw1wJiRkhR1dse2qOTHsP14U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR07MB9215

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Tuesday, April 15, 2025 4:58 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pabe=
ni@redhat.com; jhs@mojatatu.com; stephen@networkplumber.org; xiyou.wangcong=
@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumazet@google.com; hor=
ms@kernel.org; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.=
net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.or=
g; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_s=
chepper@nokia-bell-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.jo=
hansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs=
.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com=
>
> Subject: Re: [PATCH v11 net-next 0/5] DUALPI2 patch
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Tue, 15 Apr 2025 14:43:12 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> >   Please find the reposted DualPI2 patch v11.
>=20
> 24 hours means 24 hours, not 23, especially when you're reposting because=
 your previous version did not build!
>=20
> Our infra is severely behind on testing, such sloppiness is impacting our=
 ability to process patches :|

Really sorry for submitting within 23 hours.

Shall I resubmit such v11 after another 24 hours again? Or shall I submit n=
ow?

Sorry again for inconvenience.

Chia-Yu

