Return-Path: <linux-kselftest+bounces-37475-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA5B08657
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 09:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D81F168332
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 07:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C349721772D;
	Thu, 17 Jul 2025 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="c6ulECsP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012030.outbound.protection.outlook.com [52.101.71.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74C41F4717;
	Thu, 17 Jul 2025 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736630; cv=fail; b=uhGkt92u0cVvJIdhSjIQ3x/1v0kxCKqUdCqKrjNa4E7AY/+ntXQPXmKdsXzbzLd8dtWcipDZeGSOMXbERHPKkdnXFKs5RhMm4dMEkLgp2lei8re62hqH2FVntJhQ20hF+C0YjVHPPtKStJzbdeplg5ioiR6drvi/gN5Q2MuMaAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736630; c=relaxed/simple;
	bh=yrEg89NbsZ1Xxnhxw9d2Lc1BnwdPBabf4ePwKppdcds=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QvXBaEx5lB7aP6Dh3TKz9SIGDNk15m6tSjZ9lGqdFQG0C72yaDeqlSkA414PyNQY9HZzmcXbujgwICUpF7cVgOLe+XvwlVi1vJ60Rpc+Kw2+MUJ5BReYWEL9wvKIVPpf/Z232PE3I1DsnNuFAE0zJcUw66DXBbFFBKz9WPEtN38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=c6ulECsP; arc=fail smtp.client-ip=52.101.71.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj0zZsAA9LvIY2xp4tzz42UmBgVVt/4/AVXIDr92JgeVP0iTQ+gWT83TgppSJfouWSMJzDrCmzh0DzGxC2f4oX4AE5VZyzOhEtObCVjCtUAGwI6gEEzOEKjcQrezGi9qO62otjoyt5BvLvM6n+kWS2tJxhzms+aw7zHT9jSj0Tb6B/p8T0eQVUt4BU8Ip+LstqYhixMQKxLW1gbu10VUZOSaRP4g4gFZ8kkZdl7P24bnLprKaIXurAWLYPAcgvT4It4TNRT7z6TaZHYhePGgubzJ95cs+kwkNRzg4p/PycROMv7kbEZeFpXdN1YUil6aFQO+Uqkc57xMMNB04ES7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUFpa6vn2QOJ6/09qEhqCjkj0RkO/1YMNAFt4jT2XKg=;
 b=QC6aKr8CsXhBb00vFOIniTF8D7hhBVbY50qdnjoIprizNRslh6JuXG60xQI1fybOscdWGGZU89GgVRGmpoot9rTPDsrR+ObiQkq8tt4OFkywFjf7QtGN9xJ1fALUiTfO76U98+lcd+8DuOBSrnYV2f4p+Lex3OdSm3KC3LPoaprPJx+tW0OgWwUdozSADlo2Hvg0QsDLuFqi4sr6pMc/KZiRX6Gk1ZAqMclG/FRffFAuch1wVeJ7I9sw4ColkhYL3UNCmUWKJWzQKedE89XvCQd6sft+ZQQ76bUzDYKyWJLqFIciDpZH+rPAh8kfz3iV0tdcZNLEpGik6qe1rBxERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUFpa6vn2QOJ6/09qEhqCjkj0RkO/1YMNAFt4jT2XKg=;
 b=c6ulECsPgynvm3IgnneKECV1gE3NgD68qtG2QjuffgscyqBF0pqhYSmCaHBpM3TCUh5UPJMeefTXxk82+6c4shw5+gBgUURmDZJWiBE79FUEMfetin1unpCsjiqDqYZaKBGO7e4WmUVbmtjfhaXxdec2Zm/Z1aAjLmtXd9L4IKooERBvgiu7AghNOcoH5ZtRcUw4wVe27Bcx4AaqQBbLwMiN1KHki0tC4dBpA2KZuBeiXSubV89KxoMD37jQyNRnbs/mQ8bPpouilh2q0YCd+Hxjkn/8FP5VhvcQYj3Ms5R8Lp9y2I18H83u9VtyBfGCvWhsRBsWL+AjXN3ay3WrSg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9714.eurprd07.prod.outlook.com (2603:10a6:10:4c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Thu, 17 Jul
 2025 07:17:05 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 07:17:05 +0000
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
Subject: RE: [PATCH v23 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v23 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb8+RE8DDWpYvQaEawmS20VPZnHLQ1cGMAgAB9PWA=
Date: Thu, 17 Jul 2025 07:17:05 +0000
Message-ID:
 <PAXPR07MB79841BB73CDB3C6B441D0851A351A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250713105234.11618-1-chia-yu.chang@nokia-bell-labs.com>
	<20250713105234.11618-2-chia-yu.chang@nokia-bell-labs.com>
 <20250716164810.60cb683f@kernel.org>
In-Reply-To: <20250716164810.60cb683f@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9714:EE_
x-ms-office365-filtering-correlation-id: 83d52451-b5e7-48eb-7973-08ddc501ef60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?b4DQpJSdNOilp3bwO3F27yxa32/BhLwjO+Gl0HCSq+45fyLwV3hG3ivVMAlS?=
 =?us-ascii?Q?YS3uvJ0DSIwlfZwbkBI1KvHkHgXhPCTdeFeg6S5lcIXL0hSFOp7X0F+GY7zf?=
 =?us-ascii?Q?Ui5/wCgE+voYZgErVBWPIavZGRxtWaIyiSEGmuNfHULt5UbmRCEuxDZ7T/3A?=
 =?us-ascii?Q?6A91iWzI5/lwSXDu6Jrt452L9Pa7XSIlOdBYoNhZf2tRN6/SbNVDhVPdjzWC?=
 =?us-ascii?Q?0IvmfkW1Wtgke7J2rQslH37BLdNpNrPFOMuE4cpZHHIIlAvboZkg46pBXrt4?=
 =?us-ascii?Q?TNVuXOF4j0YHaTRIXIyvmVI1cuongch8wwZKZkkSDqndZDBiV8wcDGWVoFBj?=
 =?us-ascii?Q?/bIY9ylEm2EK97V7zgQwNj18qMikbP/lKgZIURUC5IJtAw/twe7K4zngRFJc?=
 =?us-ascii?Q?TN88FBjHQwysxNcp8hPX6xcwDNYyRES/VDY5HupEgOzbd8cTCX5juWuWwHGH?=
 =?us-ascii?Q?jS2Fn0thKMHRFutSwFPGjmQyf3XhsAUt3VFAhUycyoriHbnFOMdJlhJAvSxk?=
 =?us-ascii?Q?bRImRkVfCH/QcXSGbmfLhFkaJLEMaFTQ0VnteXOMx9egpfZPftRsQVb0yeoB?=
 =?us-ascii?Q?Gq/Oxxo1DI8ibi5uMWEJYVrqdwf02IEAsvMmCrNidLoRtS28JQItfsmV6xzY?=
 =?us-ascii?Q?Q4fCt84LIaSlKYKM+nNAoE7wxrrv4XSTF8mN/Fnt0zAzGx621Nlmo32qmHIS?=
 =?us-ascii?Q?HrnImzMvjhuZiieK1fSVWbnGcz5JeEa4BK2NV8mlOx1LN92WNGD6A9jlyHNp?=
 =?us-ascii?Q?nv8wHsYz4k9jWHdrvNZRNFfbdkdRglHhIAQ0ZJjeoMgfA6LQjw02ffEA1Fp8?=
 =?us-ascii?Q?ZEV3zbXYSxPsuDApkOpCIs5mDU3Gj/XZlcTZWTgfiz8+UZvQoslVaVgQveJ7?=
 =?us-ascii?Q?PZhBvxn9A6Ag7KZuA4jsLXWPVgJPVxSUxeDcD4LIOpQJe8IZQXGlJ8p6K411?=
 =?us-ascii?Q?E/yRmtsTJHawieqQPpENeDuCYjcnN5OB/6/D/CcWFH9X+rCQ8yMQu2ozOYti?=
 =?us-ascii?Q?9Y1yQQAKCHRpi+0ZgAq+U81hFPkVcP4kZffnKSnhyOmu7Pwuzb8m+saPFzoo?=
 =?us-ascii?Q?5FV5AojSE4MN6eQbyVOAGkACDd+8s8YR6zbZeXpMg1M+KO56v6SKdBNpPbpE?=
 =?us-ascii?Q?PYfTKAVc3S9h1JnYxjnqkC/n9Ccg555C18pv7swVEPzycAp6wsybpNLlzEof?=
 =?us-ascii?Q?xlIi2JNjRTivOdYVDuaL19emzJsCEbEHBkVmMezh6IGtQpfbDibX3l+N88bZ?=
 =?us-ascii?Q?RBoJDUoZCn44pNZekF3lxl9T+GZlqAYxWwQJsiEqYfxRw2F+CnP/4Jfj3E9Q?=
 =?us-ascii?Q?q9C3wTGUKbQa6e1TTeE+1pdFlYVtsIGFszqJ3btte5RZ0wf1Rk7QCGiPugBv?=
 =?us-ascii?Q?C8VPWObrNp3oWGeYHmykaStPDk79G4ZXHosMOJV8jAMJSA/hozqPyvIpw4KO?=
 =?us-ascii?Q?MZh3qEmuz9LvZPnEgTUz7LSFIdNDowEoM4pGJObYhSkXiCVlscZZ9jjcrSvi?=
 =?us-ascii?Q?UdjNj/TBtoK7ZkI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E02FfvR7511/F9D2OYSXtAh47KQtMboQJLn/SeEo42+kPlzuqr90zo7z2s7+?=
 =?us-ascii?Q?cW/bfmJmQpVhSJR/W9sF5s2GViY7cyxgOLgAxkH/SEDAmZ70WsrB/WQN8kAV?=
 =?us-ascii?Q?g81ICsZAFB5oF9wAMR/IQ61237n4x4wLoPorysJbGU+PDRqzuTZJ4Vl9+5AU?=
 =?us-ascii?Q?vYncUUnWmsFqA0L4rCmagqgxDtcF09TxD4FvVKorK2d+7NSXy8pqMDMHbkjD?=
 =?us-ascii?Q?pOBFuTe1n04C7wKKy9E9LSWWqpgqZrNLW23lklvyZTOk9SdD6574sBx9XSH1?=
 =?us-ascii?Q?QrVzUcDe2Vn3MOyMkxZFNQtgV/wOuAKOMkr6p5QXti1WYyjBMVEZHZPZybAX?=
 =?us-ascii?Q?C6PmvsiT08d/xoasXLy1E0V20APfP+z8T0w24XcASkX8Zx5z6Of2CZO+5Yo+?=
 =?us-ascii?Q?UiPMMgY6jbfp1QvdL9p63Id9UvpMN+0c1xNnTv4KcGY8p2BtoHQJFLgwpQuS?=
 =?us-ascii?Q?MlmkdUI+1kp4ce7TKbOcsfb08LgSo0G7ec9i75ptlq5Qc5gvLTWNndpvLLJQ?=
 =?us-ascii?Q?HAVvPnYYZ+6HnvheqVNcKfqmxfk5Jmn05fp5etp+i24DR7tzMRvb9hC6I8QD?=
 =?us-ascii?Q?vejLUB5CWcrrKyg8skUKNzRvpoG2c3zuu/OvsQmhD934k9fv8Ti7q+3TIiS0?=
 =?us-ascii?Q?AiiKLtmuIXsTRYhPJheZ4bgGqHiAHhpwn5z9qtcUZjh7+Hr6yXe/MZYs4su3?=
 =?us-ascii?Q?e5PWGtydNiBqaZfSRuqpwo04rqv/JZDJ4+dIQG8ECD32SfBj/OFbL4qOxz4l?=
 =?us-ascii?Q?9XhU1Pl8YG2wfpkcJEPQngNzPFp1rY0TndB5CNrI+TZKNLl4sYYhZoQzJmDc?=
 =?us-ascii?Q?kB6eQs0b3SMse13iPCX+9AI5Fmnli8ZGGf21cmS5HK0neXZ+Xezlafa2jJ9w?=
 =?us-ascii?Q?290iaEksTgYsIy8kTPJzBF5mHpzGWxEwV846phCwg1JFxpHGgxQUJctmYfFR?=
 =?us-ascii?Q?pb/uPjF+T/BaKq+oTJeBfPoNfVDKdQ6M0yopdS4PHml7UFSbnd0J3wL8BaBB?=
 =?us-ascii?Q?dfeSDqSUZkwkfQYTkQdazbrpiCUlrX3xygAJLgm4iITFQyWXl+eQVvaDaYQb?=
 =?us-ascii?Q?ZYmV7wAsnHCJrAVEvGYYisLmXQtp5eWWInl7qq3mGvwnAsxpvnp6ec7JDLya?=
 =?us-ascii?Q?zy08c2TrtO9RufdyGuNVzYJfOFFRP5GBx2mv5PVJoY7DRJGFnukRt03pLNrM?=
 =?us-ascii?Q?armHQgsBJm37Vo18DQPiY/h3XSZ7qIGW5kJZjWQD9EY2hiy1iQJ1SPTVAF6y?=
 =?us-ascii?Q?qrhkWUo1EH6ryJu1Of0DnSZN1iOySm0c2qqAefxdBOx70t1rNxVS9geonbPf?=
 =?us-ascii?Q?GVKtikA4IeInfUzwjTI0SL3zxfNNnzjinJLNbm5dYGXB/X0gLhdjFtcXMrcp?=
 =?us-ascii?Q?YLkytrit7vpw+vIb/dntlXSO3RhGSJPnnfhFYBGB4J0dgJ/Z7L9a6+Zrd5LM?=
 =?us-ascii?Q?zwKP/249/ohyZiICBVaPxnAb1eRTphgtDFF8rryUv3XFA5ofxPE8K+jkWGNN?=
 =?us-ascii?Q?JcGhiEJkKKi1hkyI13pRyr64oWKozZFFHyUbuOwVXaioF3UNIodWK9YL+o4D?=
 =?us-ascii?Q?CDxGVQTv2DaYeVoS7dAssPUy+ZUaqKnV/IyvKcxju8Tbh68JUH6v9WIJntUq?=
 =?us-ascii?Q?WA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 83d52451-b5e7-48eb-7973-08ddc501ef60
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:17:05.7952
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgnBAhoLewcu1EN921B8Vnq5DAb95OnwDv/cfUorKRhZG19/Y8DEkFrG1QDkfmbT+YzXe2RUFabttOCEwNZPGcetx2AtQA8/j7Yv+uX6taUdDCgvECM8mZekPderi+fw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9714

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, July 17, 2025 1:48 AM
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
> Subject: Re: [PATCH v23 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sun, 13 Jul 2025 12:52:29 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > +     err =3D nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy=
,
> > +                            extack);
> > +     if (err < 0)
> > +             return err;
>=20
> We should probably have:
>=20
> +       if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRES=
H_US]) {
> +               NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attribut=
es");
> +               return -EINVAL;
> +       }
>=20
> here?

Yes, you are right. I will add that in the next version.

