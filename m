Return-Path: <linux-kselftest+bounces-35691-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B83E1AE6792
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 15:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90EB818968A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760BD2D2380;
	Tue, 24 Jun 2025 13:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Dqo0YJkM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011016.outbound.protection.outlook.com [40.107.130.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9242D1F7E;
	Tue, 24 Jun 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773217; cv=fail; b=kS7PtGQOklsFZ6IO+xJQyq8hSwH59B0LuKbXQTQyAJGUZAXD2T1n1pahKzVXEU2+MvKE9e+OeFxjdQoDwpamDBdFEp4Wv9aq/e8m91bAzUBdPVBQgmSi3wCAJQ+HqOWqZLEQP73k55KCx2SJtuigzKRR1D/pcFPPpCoI2+1zdUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773217; c=relaxed/simple;
	bh=i+4/A332miNg+hT7Ur+wtoQ3NlUSqZ9NmYnyWhr9ktQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fVS/xbeXlYzOP/fiO2+nXFvTWPdGfTDTMHxyT270syolvlTGOIZKaTGnGXxAljMbIWQ09xkp1q4paXQkO8IdOyN/8+/vgQvsN0MyqWBeqyGKxGHzyHFTHZIDq4pPfBWPj2pR3sgPgvOUFT0PJi8x5TmbZeUFHjir9xI0X3BuIS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Dqo0YJkM; arc=fail smtp.client-ip=40.107.130.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNbeHoVLaFcs96Bp71xOfkxGOXJ0ndvR2PkhS4NeW2YCGN5uYdK+bZVu1VdBzPWoUUSRrPP59c0A8yvD87W2nAUIWXL1ZUjyXJjNOdkHpdxD2jY4Q+aESQmQoE5zJ2LHFVtmHB3fg3s0PBnS7wPwe4FAF5OfLX0qaH6qXDLsx/9nauM/af9flDHe9qwqf9AxvzMJ+mDgPNvTDYYdx8f75RGxBNKypVVjwIHBNPkjHbHRZRITu6HG25T/Jkp30EXszqhRwV+PCJQGdCEDMSRQpBgqJiCKP/MtqdGox3bMdWj8NlJPtPDpLUoRlY3cFbm8aB02XWI+Py2d6lGjD2hH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wo4Z3f8iE3IjYR4zm8KrHIZD5Imnjt32eMPewNFk+Q=;
 b=l32fauExSUCV/4nzFN90Jk+tdAJZEglbXgp1Za/8SMS1L29lt7DkO00rOdG+O6aK0qtXnikiI18jVMhuB/14kZEX7HgFsDrWgUxJITcEI6Z4n9nc9pNNW508cOCsMQ41IMwOIdSGJwjs4ohHpJ5hY4pvxGlslMShlk+BUpj6CLpwH2wbIfS+H4c9YYzi0MpVdEzsgi4iGyUJrt/yRChF0qU8t/tDnVNKYTe7uZHtgTB1OV0eU9KP0NESkdqBDGVgE+sAgcO0zw63xFQXrA2gntycNCwTMF+j0aWvaX6N9iAhZo0Lx6yCPJ8wYGZALKWuJF4pLyAZcTo+AeSobCTfqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wo4Z3f8iE3IjYR4zm8KrHIZD5Imnjt32eMPewNFk+Q=;
 b=Dqo0YJkM/IiN/36rChQqbmj+61JzKdwhHKq5qjrIBMyZHeNSHGhtur4I9oGrBdkqRnsqqcADYEQj7e655yqDapDxd6/JvaQoiswn56l3iu+RqrysBIJoGVRO4ByNHWANJzE/I64IM/926Z4ntRk4b6jXzCHuDdbHYbxrjpcvKrKSfY58friXh9xSGRBDN/CkUT95e03MIY0f1KaPZwjbhxbB/1kPAnlGUB/uhQ9Zu/lAf1E8lhLW6kf5mSXKR608c7AE5oZEB92zXzTyG6/S/ONzMqE4evZMDj16aV3olyoKw/WUk4faxeOZLfmXz2gwkl7BV1Q1xXvdoSnI2a8qGQ==
Received: from VI1PR07MB5567.eurprd07.prod.outlook.com (2603:10a6:803:c1::26)
 by DBAPR07MB6550.eurprd07.prod.outlook.com (2603:10a6:10:18e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Tue, 24 Jun
 2025 13:53:32 +0000
Received: from VI1PR07MB5567.eurprd07.prod.outlook.com
 ([fe80::483b:8cf8:ea12:cf16]) by VI1PR07MB5567.eurprd07.prod.outlook.com
 ([fe80::483b:8cf8:ea12:cf16%6]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 13:53:32 +0000
From: "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>
To: Ferenc Fejes <ferenc@fejes.dev>, "Chia-Yu Chang (Nokia)"
	<chia-yu.chang@nokia-bell-labs.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
	<pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v20 net-next 0/6] DUALPI2 patch
Thread-Topic: [PATCH v20 net-next 0/6] DUALPI2 patch
Thread-Index: AQHb4uNkcSu1X+GxuE6DacHZaR9EoLQSQwKAgAATWvA=
Date: Tue, 24 Jun 2025 13:53:31 +0000
Message-ID:
 <VI1PR07MB5567EDDD3F6F999B7B082575B978A@VI1PR07MB5567.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
 <6f880f49c2d9ef20ab087c6e9d1a6d6c8f6e500a.camel@fejes.dev>
In-Reply-To: <6f880f49c2d9ef20ab087c6e9d1a6d6c8f6e500a.camel@fejes.dev>
Accept-Language: nl-BE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR07MB5567:EE_|DBAPR07MB6550:EE_
x-ms-office365-filtering-correlation-id: 9e952a4d-2fca-45df-2fe6-08ddb3268185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?R4xF7zWXy8s3UBCXs5H0KUai0/6FXAFz+xCpkXfsL0JILiCyi9+pf6m2lf1h?=
 =?us-ascii?Q?OEkg45vSCf9FlO+fZForpyjnwOTlH1MWTXruA5LATGmIuuose7DpjH1+8ZNE?=
 =?us-ascii?Q?fSJ2uEKPkGwk/2A4FCDrEDsC4KxsTTotOybhd2PamjoOgjFhh8EBhRx2ZH4w?=
 =?us-ascii?Q?bmGXkS4g4AxvcKyuOvvfbcLyxiDzSBK2o9YwlF4A0Z80gYhK+PGQCZzpn4oo?=
 =?us-ascii?Q?fOlSRMEqxRqJ9ziM7Y00aLPWx64chDY1fAt+nCyp7vJmEaBxGVRDXVFBX5FL?=
 =?us-ascii?Q?Mq8PX8nqpoZLMqmlDHU2zYbwo6KMUriuQLf42eds6EXdgT2DPU5OBOTzDH/y?=
 =?us-ascii?Q?BYVC/IYD7dwkCKB2TLfRDsuyvcZjX9UbYtLZsRYQX7y/9Huo5ZQVk1x5o5ot?=
 =?us-ascii?Q?Lps1Z2u7iArxCU02pLUzTqpy4AndOUZXJMjaApH2tIWETMyOBlQXz/TrgAsb?=
 =?us-ascii?Q?VckSzIxS21yGutKVAYxUsEaACwk2iFzFFEz+QfGUdDMcOP/ruxOOUN0kz4G/?=
 =?us-ascii?Q?M2nWlqDxsIRAqmKERGVsVL4ceO/sYs0xh5faqzEUJOdkPCDXOuHEq4oRaUk9?=
 =?us-ascii?Q?oc/KaWFKFK9cB/25E3ITTihQ7+QqgFrmMXpQR4xSpso8ckjsU7nAtoFc336J?=
 =?us-ascii?Q?Ho+mhK8wiRRgcTtYDt+V77fpx+399TZbDT1bpY34SquuC7HbA64lWOG0tmgs?=
 =?us-ascii?Q?2sRHCiZW8v10yY+0UYuO3slRpaYOTi3t8AGJvYFMLzSaTlzdRcrhBB1uACiX?=
 =?us-ascii?Q?xULno9W1KZ3ZUbBxlpp20mKnPwUxWf9xfC+otRpgjAnVHmZYL/i9xRl4sn6g?=
 =?us-ascii?Q?7zU3F/xJ7vDIUMBDQB2/zFtVQ2vTpSk7SR+NqM32/JsymxdLzn2CjJHeiQHJ?=
 =?us-ascii?Q?gaCnkTu0S9Sw9qhyahMDvsRnsZywSDneTywmVKN0mfWE+YRPov0Xdxzz7htY?=
 =?us-ascii?Q?gL68WmLHuRcLycM+7j0TM3UhEIf+ZIo7VDlDcsiYZQdQ2q5tIxLFBcWYcCLk?=
 =?us-ascii?Q?GRmC+7fqUq6LAaZfGpWbwfPDFG2yvwUzcVnUMBfo39iWv5W6skHB/q6QniyH?=
 =?us-ascii?Q?zUaRQ7zUMrFMtb/e93O4Q5wf5Q3LH0AaEPwkLB/zSSIDH2P//TFTfi8aGOD/?=
 =?us-ascii?Q?dkI7lT2uNrywQMdKYK/HZRFJgD5KdXpjx+BByPjc/voSceY4d+POPDbqpFCe?=
 =?us-ascii?Q?As9x7gMXFBETkc1CiqftF97PxiTCS7mYKYc9duZoFfJJF/LpajVYV5bJKIS1?=
 =?us-ascii?Q?+KV9GyLPAKCtjsfYP1qC4UQFJg99hzB8DTBQv76KC6bH3Kx0MkE78wEev3SA?=
 =?us-ascii?Q?w5ZrwNT24h7pb+0wffR10fV8TntxN98m2rVhUAaw4lBjaFW56Ja0k05/RFj4?=
 =?us-ascii?Q?WNXFalwEIvSeRUECOtgm6ppy1PzZK2mq5BKAI8KMrcViASCRLBCRJ2m8Ila1?=
 =?us-ascii?Q?SsidNNsscS8tEHaEEVWmNUMrYqrkBDinlWkQrS8uf6ZIkLH/0eL7b8z/TBhj?=
 =?us-ascii?Q?a1Zu8yZiuLYK7bxETBMe5F231G+SyKB2b1WP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR07MB5567.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bnj/2YAvWLoMS8OL5M1K3pwYKGNrnVPiZYY1h1GmMRrCLTD+TUxnwOmxTqWT?=
 =?us-ascii?Q?iUEjbVB+e5CDcEbOP2FYvRH8n74XWjgN+7agZNYsvtT93o6psc1dVaSFmnUr?=
 =?us-ascii?Q?784NJtZSTo4/Ap0j+RMOuAv2IaPTjewDNSs33BeI89HJ7c0v2DtUKzHuwp0p?=
 =?us-ascii?Q?FU5nJ3OImTYynaXAuIajuFNeW4UGWYZKiLGCB1/PqFUHZeOu1TXuhCvC5Kzb?=
 =?us-ascii?Q?Qt4VblWLGDZR1gs30HY3jDW7VpkRGGh0ZNN7iqw7hTY2Z3ZRObFv5uXk3Xu0?=
 =?us-ascii?Q?6UZ9Srw2Doff9OGohj48al4LgZhmhYp6FYGgpcij7qzW9uyL08Xcuw7Wwxvc?=
 =?us-ascii?Q?Om3/00YxrHsLqHQw8SHqZec8n7BeyQ7HCrilV/MMvEBOvkMZ8mXOxd74xn2v?=
 =?us-ascii?Q?eOwf5sqgOgNv/y5Oz4qQYw1tpqdVJfHoGxM3j79l70FdlJB8zUa+kTYWCylr?=
 =?us-ascii?Q?epHWkSZv0Jno3JzjvY8e6ZsqBBs0oAOjwvfiv+MDl33ZKsx6Au8FchalUFfY?=
 =?us-ascii?Q?f+NC0tB1FRaxVoGfo4G25AfAjscVq4SBE8lInZgye44Akn/iOyClEqZD03fN?=
 =?us-ascii?Q?8OUKTdznU+W47HmBGBMUeEovaKSOp/fbxk1Q50/Zfv8GkS03MjcN+cgNlb8e?=
 =?us-ascii?Q?UacjKKLnQg8lYRTr4BRzOo1xIs9Mz2zVPlXgya0Ft/6ra13xQ/evziXifWF9?=
 =?us-ascii?Q?kmrf9Ak50G7xWTouMfyKNZ3IrT6gdNQy+gjTQ2hWz6jJcUUokYO+qtjRImRH?=
 =?us-ascii?Q?53fYe5EVmjtTmGn89LUUijuXtDy1rkPv7vbMCFNso/V6XWRl2gVgqo3NV9lZ?=
 =?us-ascii?Q?ItuN3eiTDTKUITR8c/LyBl4WoZxsOQvsvEeLdnYa0FDS555rCDfzLKLbZjLC?=
 =?us-ascii?Q?tPODrF6ZzyjwqjqbVDFazEWSZOucW7Ii1gNDTcZXxNc/j6urtzPDTyV2j/nb?=
 =?us-ascii?Q?TPT8urCgGRfar9agdN4sn0anlSGmeuPr/WC5HREpJ0NT9Cy2fwXoFD1fOOm1?=
 =?us-ascii?Q?fRvDf83CKSmFPXLXMsFl0eiqm6y/DtmeoG7LXD3oYDuvlpDqWL9ROkrQzczw?=
 =?us-ascii?Q?Zp7D4vwg+ZPpi5IHx520eZPvl1YVmhmY9qWbqfWRnBSB9nCoMsiLkAbOmgdt?=
 =?us-ascii?Q?tgxf9rM9ISfWjTbjWHI8qhZeAnFBoifPuOP+5hoi28tp7rUdDgWEJOPweUdJ?=
 =?us-ascii?Q?gROfxssekMGk2D1AepWPur3MPQP5V+ihE64cT51/876vAslzIFunG6yey4Q6?=
 =?us-ascii?Q?uv29kIPr+fKmO7WHkrsE5sp/07zaAh829pJg4QLj9xSWDmmCFOXTHdKGRZYi?=
 =?us-ascii?Q?LJNjCmlV48iy1/w5CG0wOnpkA9HQCdL99tPjfXHGsPbWCc8gVLey12fqL6X+?=
 =?us-ascii?Q?AHC1cNVz6XD1/PYvxGXlK06Z2J95wrI7oIPNnPlCj5cDl0POJB8mvb1amBBs?=
 =?us-ascii?Q?M685D5ba+Dc1SR13+1taFHgnnH8DT7A6JM2/UE6GFe8ZV2bYA1ri+g1F9seX?=
 =?us-ascii?Q?sd/TdTlWN7Lwo+9YSpNCfxU/JAOSKFNSCzojBX/lPFKKr+pQACjKm/g6LEWm?=
 =?us-ascii?Q?HKUaFLoOOTP0Kg6qL8PpZr6gVKc8scAjXCY6uI1nznqmtT4r0C+1oij77cL+?=
 =?us-ascii?Q?fqwSmqqBBZiMfj2ln6Q2wFA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: VI1PR07MB5567.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e952a4d-2fca-45df-2fe6-08ddb3268185
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:53:31.9176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b98h7JQj0v/3euwALJWLJ6A/NdByKaMa0JyVNH2NDqvfg2fPy5sES0Q4C5LNku/XZTaWAlRiiYp2afZ0StErtOba9TuLZX0ct/SJHYi+JBtuRXLsF0XIwJ82OIOkt9/d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6550

Hi Ferenc,

We spend a lot of effort on the tc version of DualPI2, mainly to share the =
know how with others as a reference implementation. I hope this tc realizat=
ion can be accepted now.=20

This shouldn't stop any other realizations (using other technologies) that =
can be done in parallel by people that are interested in those. The perform=
ance and correct functioning of those other realizations can then also be c=
ompared/verified with the tc DualPI2.

Regards,
Koen & Chia-Yu.


-----Original Message-----
From: Ferenc Fejes <ferenc@fejes.dev>=20
Sent: Tuesday, June 24, 2025 2:35 PM
To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; alok.a.tiwar=
i@oracle.com; pctammela@mojatatu.com; horms@kernel.org; donald.hunter@gmail=
.com; xandfury@gmail.com; netdev@vger.kernel.org; dave.taht@gmail.com; pabe=
ni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.or=
g; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; edumaze=
t@google.com; andrew+netdev@lunn.ch; ast@fiberby.net; liuhangbin@gmail.com;=
 shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwel=
l@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.co=
m>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewi=
nd@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcas=
t.com; vidhi_goel@apple.com
Subject: Re: [PATCH v20 net-next 0/6] DUALPI2 patch

[Some people who received this message don't often get email from ferenc@fe=
jes.dev. Learn why this is important at https://aka.ms/LearnAboutSenderIden=
tification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On Sat, 2025-06-21 at 21:33 +0200, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Hello,
>
>   Please find the DualPI2 patch v20.
>
>   This patch serise adds DualPI Improved with a Square (DualPI2) with=20
> following features:
> * Supports congestion controls that comply with the Prague=20
> requirements in
> RFC9331 (e.g. TCP-Prague)
> * Coupled dual-queue that separates the L4S traffic in a low latency=20
> queue (L- queue), without harming remaining traffic that is scheduled=20
> in classic queue
> (C-queue) due to congestion-coupling using PI2 as defined in RFC9332
> * Configurable overload strategies
> * Use of sojourn time to reliably estimate queue delay
> * Supports ECN L4S-identifier (IP.ECN=3D=3D0b*1) to classify traffic into=
=20
> respective queues
>


Looking at this, I wonder if DualPI2 would be implemented in BPF.
For example, you could have two FIFOs with a BPF Qdisc, such as:

struct bpf_list_head l_queue __contains(skb_node, node); struct bpf_list_he=
ad c_queue __contains(skb_node, node);

The bpf_list_push_back and bpf_list_pop_front functions are also available =
for handling these.

There are also spinlock helpers, and the pi2_timer can be replaced with upd=
ates based on the struct bpf_timer. Of course, there are tricks to consider=
 regarding GSO, which might require additional BPF helpers. However, lookin=
g through the code, I see a chance to implement this as a pure BPF qdisc. W=
hat do you think?

Having this as a regular qdisc with the iproute2 tc interface is great, con=
sidering the effort already spent on it. However, since all the operational=
 bits are already sorted out, it might be worth looking into the feasibilit=
y of a BPF version.

Best,
Ferenc

