Return-Path: <linux-kselftest+bounces-31433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC37A9962D
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 19:15:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7FBF1B81067
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2780B2857C3;
	Wed, 23 Apr 2025 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="QILEW3Bk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2086.outbound.protection.outlook.com [40.107.20.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDBB13B797;
	Wed, 23 Apr 2025 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745428521; cv=fail; b=pqvbvcmxg9a7guLKd6tVLzbv1AQQfzPyjWUF7F6UP8vKiTgGSnBtFiDwKCFhTfGZWzRq3ZWZKjqVWvU5ex0K+RMtjxByBdYJRwMUdhWaWJt3zvhTWv9tYvRX0tMVq64c7L0SoD99o7pIWX2/dXTLVsvAWXDnWUfavBaRd+ZRFrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745428521; c=relaxed/simple;
	bh=IRmVYjcK2xbkuVpFHzrlnSICtqJR71XbzCy355w51yU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CAgQBoD41A2V97lgtwvEEt7pRFZ6GBSP2ne98QMBFUqSQb5P00f6Q52pyEVybxxd0GQBVZYhUeQARUNpa9Pzi1gF380o2qIjn26F1oCu3u3OL8cJ8+lFJLi/Xq9jUt3qiDsCUS3tXP/2VDbp2+drazByQLSXSCLoX5qJBWPhpcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=QILEW3Bk; arc=fail smtp.client-ip=40.107.20.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhONYvbcqkmzX0eTKyZtq/pJoRzKVA/a5aKZwzse1LXXAZ7GTs9ntGfBAM3MSxdiPHNmRPxfZiFhfrT+EWZbODslJesdIXmCH8NN0sYhxlg5+X3k5U6cFFfDVvG3P+wr+PLNdq5oc4XgcGpODKq2lFwfm0IXqjQvaN4GL/LD+K7fs7Mcuu7VzUwkUjJ6ZlisoautD7ks/YE3fufVEoFjR5FpBGOYdGqQcHp4oW84olcXYEQeih48G7GQVqe32tW+/gYWlrsoUEmTfH6CaryHSKgKDFoRvLGalb2l7C6mlAIemcPK0QRocdN3Mk0uDTAnniLFkfovgGy0ZQkTJGwVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca6oCsiuAf5UbfTlOMoC7zOCkNAi5S+A8F2oe/f3M8k=;
 b=cZjtKMn1ZC4J7XMOIHTJmFTgBKpTDHy7fPKG4NvE0fnx8KT6frjUSzWrENe0urVCBAB+1f0ViT8wGB8Ph6DYohLwU6Fv4PdNbyqu0WE+ly7OmS1D0FzyfchQQg5FWBHCxLHKR8aRN9YIv9af08h9o+sueP10/R8LK1PbKC7c8rk8Rql8R+rE7YG2wb4Sarv7YImdzc1SRHmrzEE3OaNXjQVR3xT4XsskXahnJatcTiiqx/htIIGfzQcAL0vkOodVflpZfEdAsUCTAyYvKPOozMjshIDQFHgrXvCGS8YpKIsWuRjLzNZziuGqQHu0ESLTAyAkzgx+r7g28Mo4hw2SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca6oCsiuAf5UbfTlOMoC7zOCkNAi5S+A8F2oe/f3M8k=;
 b=QILEW3BkkDcbN9+D59+UqO+oKwFdgz4Ko3cN39lkOS8W3PNsdeb4BOpj2dGeh2fM/cFKRsLABVjzoQT3tFMz4FUDCVlY3XuB4bi3t4CDKICAXKmffbPeGqMIe66h1mNLmYf8oWRiwm8tLmsUynrlYHkrJhDQm/45XKcs3JuNxcsgR32lqMLxLw0KZ4DBl7pXiZVYUNgU010u8eUiZoAvO3e0psmrhtQd5ny7GVr+CHFAeSpHmlo9Ips7TSquYg4rAIoXMZU1ROFVuzISeYeUAXMJLDT1p1DkBcJc9ZXYvgpH2IIODdnNDEScpPP2eAFyrGm7wTY2v0iPYXTrr3XcuA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU0PR07MB9361.eurprd07.prod.outlook.com (2603:10a6:10:44b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Wed, 23 Apr
 2025 17:15:15 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 17:15:15 +0000
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
Subject: RE: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHbs8NmIQkwVudS6k+2maCdGlvRfbOxKjD/gABTlwA=
Date: Wed, 23 Apr 2025 17:15:15 +0000
Message-ID:
 <PAXPR07MB79840FF6B073C61136AC238CA3BA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422201602.56368-1-chia-yu.chang@nokia-bell-labs.com>
	<20250422201602.56368-2-chia-yu.chang@nokia-bell-labs.com>
 <m2o6wnt8to.fsf@gmail.com>
In-Reply-To: <m2o6wnt8to.fsf@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU0PR07MB9361:EE_
x-ms-office365-filtering-correlation-id: ec425891-cc0e-40ea-08bd-08dd828a6a0b
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/21GAhyJC7uU6EkL3TgjHyuinyB6iypU/T8ObLlc2jQPz+GzvZQLofu1I/CO?=
 =?us-ascii?Q?EJzZgop2OxOBqPhN1yTUscBUsqFs/vkGoEfHwyqc7vHllygNzJaLRjkuLZsV?=
 =?us-ascii?Q?6eRZ1Z2xvvvHJdtmvPJqM7HO456V//6GuLzxeaDXRsw9wFtQGLs+IHvif5Vo?=
 =?us-ascii?Q?Z5wxoHlQgh8oA4DabXRaYQ6brQWFoqHuzFvTYrOuWTpVj+2fgYwtzXZYp5OP?=
 =?us-ascii?Q?pdD/EwdVrYtW759Rp2AAnbSJnP3GeOmkst60xigcOl5/fA53zAEJFn7OwjY3?=
 =?us-ascii?Q?wc2H6esKhz2gx2fouro+32HkCA9zorFaCBsLUyX+gXK6ct9NGTyw0sUjj2ZL?=
 =?us-ascii?Q?eNeox0AtF6Bs2ShrO08/I3Fym2h0KtrY/GZ04De8T3dkuJAzPhHNM23r6H8O?=
 =?us-ascii?Q?6f3Kp7bFtRqwCtSO04WwqBZvVpqpqicrCWNmBceKGbrWX1NXqzWRew0dDmJE?=
 =?us-ascii?Q?hYTjt1BxB4nniycm/YmSgOarhBa3YdUxhR7r18nxd+YTS6XRS5ysCqnf/p9c?=
 =?us-ascii?Q?b1s8YAGS51/e+16kYYVvnLWax1XTNsGxjR0+RPZXe1QjAmhx381Ozk2f0lO2?=
 =?us-ascii?Q?8NKobRbJC6eSM0VQyCzvr1t8xChXAnb1Eo/uoGP5/dbYB5VRK176rwWhDEVj?=
 =?us-ascii?Q?4KPTOxoaF7Xpn5CPXuh+qg9sFhvXdnvQJVdVmC1CWYWw26eg6JeXRs3B51Ki?=
 =?us-ascii?Q?O5b5S8A3k7o2/14HKa5BxMmHaC72HGZyXtp8QtMq4wEtfewi27eidJUpt+9W?=
 =?us-ascii?Q?sTAV8XK6yp2gN0N9fLjLF0TLIJjdOB/SMwkHlzfjdxAsB4E8JUZnvzXdGvsy?=
 =?us-ascii?Q?VD+HcZ0346GcXy6t+BaGro8W5Kj1SVyLih5AyCPLHJ9XOe/zLJFm9Wi4vCB0?=
 =?us-ascii?Q?Br24qraNCfrpnGHHChZyr5sGhMF8gKL71ovnNbNFjoYUas2WE4NIlC4SmkEZ?=
 =?us-ascii?Q?g2YkbI8fCXiW4WS7DGVoK0XCGGhNX3P6798W4IH/98v/OSwtXnhrxJQmg1uD?=
 =?us-ascii?Q?hzwkJuHT8KUQZSXAbh378RTIwgLAwMg8ZL3q4sWVLSe2zyaqTFj5EQPU/300?=
 =?us-ascii?Q?udg4U6NPJo/raicRMnVO7hQ02/FC7W5938YfUEBJdimgZ5YQCohf6gUsOoll?=
 =?us-ascii?Q?HMjwdcYUesgioCducx18TvTtqzzL2uSLjT65RPdE0QoeovJVKSjgWgNKnYgM?=
 =?us-ascii?Q?Ms6A3F4mZx4vfOGmyQftGwfjl8pqx4N64Ua4GMNsxYfBjMbw4jW/w3yyO0gH?=
 =?us-ascii?Q?kSOk6sDm4EcSpWWwLw7DLK/5J83Tbo2DW6RapiWz5f/WAV36G5ov9tSVi1ET?=
 =?us-ascii?Q?QdV3EDbZCcJwETWJNbYJSQEkBbRTZkU8t3bVNnvo0Bge+G4AyfHHONhflIfP?=
 =?us-ascii?Q?vj+kaPybgi8wfLLJuwRki1fkBbA6/3Y5kFNx88G/qUQ3RAXDvSomvH1xCtAp?=
 =?us-ascii?Q?ea2+zjI5EJvVKUuxvzUZRT21Vn2Y6cLTyz1GqLuhYVvq/k80OArZMf6t9h6z?=
 =?us-ascii?Q?b9xHdSxMqyxsaGk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?aLywnabl1lTRySRKVHHd/HriavuL6TE9AGNp5RuqNOJdxtg40wnICLMc7l7E?=
 =?us-ascii?Q?ALsvHzeFbUhCf5Q00w5w5WixE+l+HshM435l3V2GCpMalrs+2uI5Tnyor+43?=
 =?us-ascii?Q?BY6FRRfeNgeXjsYPtivJ8OuWoeYqUilmOheZCNwEaFMIbg79oT5ZBYQR31p+?=
 =?us-ascii?Q?16CWpODIM4M68Llh1v7pmVefnf1oRT4F/jjHRg0zQQ+WK4PuGoBAOyS/PRgn?=
 =?us-ascii?Q?bzbKgpuNHpmMxU8ancZo6quItXHj/zApZBC7pjR7lHQWfRlC+uCdXclOH8xY?=
 =?us-ascii?Q?sfqGvGv1Jm5oPnbiJFcgBBMfQnPBfMaCjdTCOjnbivAcMjsixwy+Udi4LSC4?=
 =?us-ascii?Q?HvjHnWPY4YwI3KtQyNZ66K4Nyk+T26MWk5lVm3YYXdpBn/EIU2fHPF+C053I?=
 =?us-ascii?Q?vCFpVi6TcVfm/60DQktK22wf/wOAuvhhlpUutRppxPWR4UaF1MsEXX8xiBd0?=
 =?us-ascii?Q?0qkZ00irllUi6J80M1XoxxxGslHdSJAZCWAD3UUQNgTlxpPSCJdOHGMLCr/u?=
 =?us-ascii?Q?lsX5wVB9ghOD27PaorK1RLtGuJ6tUA759oTRAEJLQAFsinqVriHo6QvISgZh?=
 =?us-ascii?Q?DBCe9It+KjVoVE6PY/NQkgqUNLjNBd9WHuRy0ttKMOJAAQbh8N0g/d1ZiOKO?=
 =?us-ascii?Q?q3ikO3+EI0zwa75/z3+EoFiRDJ3cenYDTDq4o0AUR1VqkiYXaddtq3/yhFL3?=
 =?us-ascii?Q?iNHy7OHxKc/AR7qvJ9G5wZto5FNlgo37yW6Y2CHsVRc9Fha5wYzJFYdk8h1l?=
 =?us-ascii?Q?S5Msn5EYUFagOnWL/+n2k81Uti9AkmSEtdFOojjfanioxUGrDseSrLulqGKq?=
 =?us-ascii?Q?ijZyoRtXT+ipSHhrgLmvP/3LynpXvusOLiNGPJIn8qRv4nijLzNE2p6sawhq?=
 =?us-ascii?Q?JyKF2YHVyV0XhMVkNiK137Rwb9PLMGHqeUwp80ee80LYO+2KcA0ikyKT52Or?=
 =?us-ascii?Q?0Lkw1RQWngp8FsW3DEu6EOaMFTOQHl3JjnDRItU11SDWsbJucbGUuuj3EAoR?=
 =?us-ascii?Q?tKhxDOIVkXEO0fIwzuoiovSNyIAIax1aFyvpd1wV7R6kOghPu5dBqn0apu75?=
 =?us-ascii?Q?F2b1AqDXU++GCg5Qzu8RELcjmecZ8MIcnDn6lstm4Q3flwPOdG9UqyQTiRZD?=
 =?us-ascii?Q?/Y4cJnb7iWOcTyLxpTMuAOwMqq/fMF35e/MVC0Ueq7G/aikC8jWoL972Wbtz?=
 =?us-ascii?Q?yw5Tt9GcZliZGcf5nSFExqlnbMpHFOTk54AeeI1tR0hPQzMHoM7DhyJ1v4JA?=
 =?us-ascii?Q?bxRjbNKaClpxPIewoba+eZOtv1W2toeKZHfcSV1CZLl9lr1PtyggohDSb8F3?=
 =?us-ascii?Q?sLrmFFIvKCOyYKgIV910DsymGYDRM+6KTwSTxDXpFMUpAy0Exe8EYlD9fTyK?=
 =?us-ascii?Q?qx8THrwTKi/kcBLkRdTpBnY6upDfCaCOvUUoCH08qZAInmhmnqaDiXS8sEmN?=
 =?us-ascii?Q?LTiGtNZT6G3cml2fO+Aw9TfvjRHpzjIY9cAt75nF+QDJoNdjkvrpUKPhIzP0?=
 =?us-ascii?Q?jJV/qXFhN1lJHXLF4O+re03Nmm82c0NpNdznKnADUaLJ6dgYBUn4pFgEVPV7?=
 =?us-ascii?Q?jqWOB0dAZna3Y7GsA+fTeBaJeZSQz6MAJcwXeEtU+/kCHU9eXQ9HJAQehtt2?=
 =?us-ascii?Q?JDNpfmkTVHryOJ2iwxzVM1g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec425891-cc0e-40ea-08bd-08dd828a6a0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2025 17:15:15.2609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z7ZN/MnG7yn3agAkPrRCti0gVxYxBHNqeUZffxiT5QRGrZDWEeAPgnxHlZakYG5BLO4OiFViet0eZu6JofAZKpivVbL8sDE5h8jPv0LEJsNkm241EqbHI55VhOJBdda/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR07MB9361

> -----Original Message-----
> From: Donald Hunter <donald.hunter@gmail.com>=20
> Sent: Wednesday, April 23, 2025 1:29 PM
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
> Subject: Re: [PATCH v12 net-next 1/5] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> chia-yu.chang@nokia-bell-labs.com writes:
>=20
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Introduce the specification of tc qdisc DualPI2 stats and attributes,=20
> > which is the reference implementation of IETF RFC9332 DualQ Coupled=20
> > AQM
> > (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > different
> > queues: low latency queue (L-queue) and classic queue (C-queue).
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  Documentation/netlink/specs/tc.yaml | 144=20
> > ++++++++++++++++++++++++++++
> >  1 file changed, 144 insertions(+)
>=20
> The syntax is not valid so this doesn't pass the schema check and presuma=
bly hasn't been tested. Please validate YNL .yaml additions e.g.
>=20
> ./tools/net/ynl/pyynl/cli.py \
>     --spec Documentation/netlink/specs/tc.yaml \
>     --list-ops
>=20
> ...
> jsonschema.exceptions.ValidationError: Additional properties are not allo=
wed ('entries' was unexpected) ...
> On instance['attribute-sets'][30]['attributes'][14]:
>     {'name': 'gso_split',
>      'type': 'flags',
>      'doc': 'Split aggregated skb or not',
>      'entries': ['split_gso', 'no_split_gso']}
>=20

Hi Donald,

	Thanks for the feedback, and I will take actions for below points as well =
as the corresponding iproute2-net fixes.
	One more question is I see "uint" type is not valid during validation - se=
e below (but which was suggested in v11), shall I change it back to u32/u8?

Failed validating 'enum' in schema['properties']['definitions']['items']['p=
roperties']['members']['items']['properties']['type']:
    {'description': "The netlink attribute type. Members of type 'binary' "
                    "or 'pad'\n"
                    "must also have the 'len' property set.\n",
     'enum': ['u8',
              'u16',
              'u32',
              'u64',
              's8',
              's16',
              's32',
              's64',
              'string',
              'binary',
              'pad']}

On instance['definitions'][42]['members'][12]['type']:
    'uint'=09

Best regards,
Chia-Yu
=20
> >
> > diff --git a/Documentation/netlink/specs/tc.yaml=20
> > b/Documentation/netlink/specs/tc.yaml
> > index aacccea5dfe4..08255bba81c4 100644
> > --- a/Documentation/netlink/specs/tc.yaml
> > +++ b/Documentation/netlink/specs/tc.yaml
> > @@ -816,6 +816,58 @@ definitions:
> >        -
> >          name: drop-overmemory
> >          type: u32
> > +  -
> > +    name: tc-dualpi2-xstats
> > +    type: struct
> > +    members:
> > +      -
> > +        name: prob
> > +        type: uint
> > +        doc: Current probability
> > +      -
> > +        name: delay_c
>=20
> Please use dashes in member names, e.g. "delay-c", to follow YNL conventi=
ons. Same for all member and attribute names below.
>=20
> > +        type: uint
> > +        doc: Current C-queue delay in microseconds
> > +      -
> > +        name: delay_l
> > +        type: uint
> > +        doc: Current L-queue delay in microseconds
> > +      -
> > +        name: pkts_in_c
> > +        type: uint
> > +        doc: Number of packets enqueued in the C-queue
> > +      -
> > +        name: pkts_in_l
> > +        type: uint
> > +        doc: Number of packets enqueued in the L-queue
> > +      -
> > +        name: maxq
> > +        type: uint
> > +        doc: Maximum number of packets seen by the DualPI2
> > +      -
> > +        name: ecn_mark
> > +        type: uint
> > +        doc: All packets marked with ecn
> > +      -
> > +        name: step_mark
> > +        type: uint
> > +        doc: Only packets marked with ecn due to L-queue step AQM
> > +      -
> > +        name: credit
> > +        type: int
> > +        doc: Current credit value for WRR
> > +      -
> > +        name: memory_used
> > +        type: uint
> > +        doc: Memory used in bytes by the DualPI2
> > +      -
> > +        name: max_memory_used
> > +        type: uint
> > +        doc: Maximum memory used in bytes by the DualPI2
> > +      -
> > +        name: memory_limit
> > +        type: uint
> > +        doc: Memory limit in bytes
> >    -
> >      name: tc-fq-pie-xstats
> >      type: struct
> > @@ -2299,6 +2351,92 @@ attribute-sets:
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
> > +        name: step_thresh
> > +        type: uint
> > +        doc: L4S step marking threshold in microseconds or in packet (=
see step_packets)
> > +      -
> > +        name: step_packets
> > +        type: flags
> > +        doc: L4S Step marking threshold unit
> > +        entries:
> > +        - microseconds
> > +        - packets
>=20
> This is not valid syntax. Enumerations and sets of flags need to be defin=
ed separately. For example, look at the definition of tc-cls-flags and its =
usage.
>=20
> BUT step_packets is defined as a boolean in the implementation so could b=
e implemented as a boolean flag in the API. If it needs to be extensible in=
 future then it should be declared as an enum in uAPI and defined in this s=
pec as an enum. Either way, the parsing and policy in patch 2 should be mad=
e more robust.
>=20
> > +      -
> > +        name: min_qlen_step
> > +        type: uint
> > +        doc: Packets enqueued to the L-queue can apply the step thresh=
old when the queue length of L-queue is larger than this value. (0 is recom=
mended)
> > +      -
> > +        name: coupling_factor
> > +        type: uint
> > +        doc: Probability coupling factor between Classic and L4S (2 is=
 recommended)
> > +      -
> > +        name: drop_overload
> > +        type: flags
> > +        doc: Control the overload strategy (drop to preserve latency o=
r let the queue overflow)
> > +        entries:
> > +        - drop_on_overload
> > +        - overflow
>=20
> Not valid syntax. Use a boolean flag or define an enum.
>=20
> > +      -
> > +        name: drop_early
> > +        type: flags
> > +        doc: Decide where the Classic packets are PI-based dropped or =
marked
> > +        entries:
> > +        - drop_enqueue
> > +        - drop_dequeue
>=20
> Not valid syntax. Use a boolean flag or define an enum.
>=20
> > +      -
> > +        name: classic_protection
> > +        type: uint
> > +        doc: Classic WRR weight in percentage (from 0 to 100)
> > +      -
> > +        name: ecn_mask
> > +        type: flags
> > +        doc: Configure the L-queue ECN classifier
> > +        entries:
> > +        - l4s_ect
> > +        - any_ect
>=20
> Not valid syntax. Type should probably match implementation, unless you w=
ant to enumerate the valid values by definining an enum.
>=20
> > +      -
> > +        name: gso_split
> > +        type: flags
> > +        doc: Split aggregated skb or not
> > +        entries:
> > +        - split_gso
> > +        - no_split_gso
>=20
> Not valid syntax. Use a boolean flag or define an enum.
>=20
> > +      -
> > +        name: max_rtt
> > +        type: uint
> > +        doc: The maximum expected RTT of the traffic that is controlle=
d by DualPI2 in usec
> > +      -
> > +        name: typical_rtt
> > +        type: uint
> > +        doc: The typical base RTT of the traffic that is controlled=20
> > + by DualPI2 in usec
> >    -
> >      name: tc-ematch-attrs
> >      attributes:
> > @@ -3679,6 +3817,9 @@ sub-messages:
> >        -
> >          value: drr
> >          attribute-set: tc-drr-attrs
> > +      -
> > +        value: dualpi2
> > +        attribute-set: tc-dualpi2-attrs
> >        -
> >          value: etf
> >          attribute-set: tc-etf-attrs
> > @@ -3846,6 +3987,9 @@ sub-messages:
> >        -
> >          value: codel
> >          fixed-header: tc-codel-xstats
> > +      -
> > +        value: dualpi2
> > +        fixed-header: tc-dualpi2-xstats
> >        -
> >          value: fq
> >          fixed-header: tc-fq-qd-stats

