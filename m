Return-Path: <linux-kselftest+bounces-36084-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EC8AED1AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE501894FDB
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 22:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA423504D;
	Sun, 29 Jun 2025 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GqOAdfQ3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A0538DD8;
	Sun, 29 Jun 2025 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751237370; cv=fail; b=mtZ6aTBTeSwe0aAmpjiMJL2fO1Vhz7YsJCsvC12iP8vmxbS14bKU+qabl1/1cjSzylL9eq5p7UD98bzhNzoFiUHb9RtRBl9znnsyh+ux9US0n2bZluBblkJUgfHnZ2eS1GHcXPd6kMKa3ojclgXoMyC6y1U+MXGSu5cWRk4CkxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751237370; c=relaxed/simple;
	bh=tFjVAPtejDjYoqh0qKrF2ftUvDOibZy6OxA5f8XUhVA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m486LMg0jknWfGudkC9IQSqHs+Dw1lh+3ROTXODOIK61sz8M23+gWR8L8qovMy0ruhTQ3EfAt9kLvFJ/5fFDyNj8p5BRlquZN7x+c8htkfXdgmk4A6CoOvlLcccs/HTUhcQsPt3LiTcmppbR9AwHCDLYUrSi7kABEw3AB9BIi6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GqOAdfQ3; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CGRon0smLu7dOKaRokLr3LH2UqOXUY+UBWpl5CvAB0xFqYnItk3tUdQB/dhTd9CG5mgNkuULLIa4D5W0jIwtYeQabrNsWW+86dBjnC3N//MYpB5S1TCHxhEiGlFbfdTtBwiBojzfk78T0uERYkiqrctz+WbHYan0aRhfD22P+uMfsZt5zQ91bQWa/Ei7beo8GbagbYYS0D9EZ4u9NB1V0A7n+GVbnyHHAk0qGHi8XoA1TV4VeN0aC0usnmLf9tbg3DSPLMP7Zmx5Rg76/P2FmBfjQhhv6sL8dTsDXBRur9MdbaX/3QtZwDZ+CYknYe3QNcvqAbPc0bOjC6qx7/cl2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mucoQA+b3fIgbA0fowLyF/sjLnqHAx24E3F0+XY3SnM=;
 b=P1P3HekcOe70x9UjxVeg1saSJxhDh/RMhTuLkMuUaPr3l6Sp0g9SXy1sKS0zJpX7Xt2mlvOhoofJyhoebxqYVHYIgaOWk6swj0mKyoTvPzXtwe3ZV6i35etDaPC2aSKnBBoKkZtJ4c6mejSRvcQc1R0oHtMSh9oFWj9CoB0uRNHjE8TNUq25Im/b7wYrxYZYIzSQl29pE3cdr49NO/HdzCDGrmF7/B5p0VeukAz/F7w0oDeHCSVZayL/BDd4JSb4kf923Zu8vS3Sp4kssPMgzcmgQ/xF9A1nmCnXz3h1ACwPcCaSOmDE/SEjhpEguXvcxBjUWtqoyHijXWSThWXQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mucoQA+b3fIgbA0fowLyF/sjLnqHAx24E3F0+XY3SnM=;
 b=GqOAdfQ3iTpal3e8R19c2HNr/m09/MZkoRxTRk+vAGSBjK0KkSYkZ9hOVLI+1dvknMVA2ZSd1R6NIxYd7URK8NlMNY9enTvc4NqbNFwz9bhl+dMtQybE5klT3AIMZMWBC8pa2eishMzH4Qaup+N9F0qsBhijzIIYNfJofVfhMWMIWmHZcRWo1pis9fIko0/E0QZE4Z6ASxUnis2nsBGITcFr9vwq8iUmhl6YKWBM5tQMtFPKFnkmatj24UQs3Gsb+2V5TQNh9LqblR07V5zdRro93pjk8n4LLukLkm0CKg7kZmf0O3mGzFUP/psmmL7tx88QzLIdSxvsJdDnpTrt+w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS2PR07MB9376.eurprd07.prod.outlook.com (2603:10a6:20b:608::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Sun, 29 Jun
 2025 22:49:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Sun, 29 Jun 2025
 22:49:24 +0000
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
Thread-Index: AQHb4uNmCaO8PxZhYUCrH1BBViihEbQXr6IAgAMajRA=
Date: Sun, 29 Jun 2025 22:49:24 +0000
Message-ID:
 <PAXPR07MB79849FDC079A2ECB144D75D1A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-2-chia-yu.chang@nokia-bell-labs.com>
 <20250627162502.0a82accf@kernel.org>
In-Reply-To: <20250627162502.0a82accf@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS2PR07MB9376:EE_
x-ms-office365-filtering-correlation-id: 6e437bff-7516-4790-e214-08ddb75f320d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UMqEipetMR3lBPIddGm189vEr0ub/dEMyq/A+eKtpwj33ABXqhTmRJ0CvQG0?=
 =?us-ascii?Q?iSLuk39TEneBVUa4i7flRwOhGSHPGG7UpuQJDBB3cUnjA0sclpL9+eWjNVf0?=
 =?us-ascii?Q?OT8JpUS0JOc10RUB/xJlc5qhXQELQUtQZoEs9XqYCEHMTsicwyXiD/MgxEDg?=
 =?us-ascii?Q?X48/TJtAk7ooWxZID6XHmO1iFqnS6jWjY9FmmpS4Q2SJ4XfeTRjYVp/2+9Fl?=
 =?us-ascii?Q?L5/Kzbu0ntcq9HJlDBasDA/l+vFA1RDlleFOIr5cC0j6B7y6o1zCePE4a/Yu?=
 =?us-ascii?Q?ZGD01p2o7zbEyvxlxB5SrCV09bFMP7BRGAbkyg5oosFrvbxsvxG9TBNEhBO7?=
 =?us-ascii?Q?EGCd/DAXMMCoOjis6hNvah9d4AyCPPjltxzqcrHqdXn1Ww0651rkAi/wpSXa?=
 =?us-ascii?Q?lMYk8wPx2+P5F7ejtCBAR0pVS2mQ19tnT6pljJoLSDNL9yfJkXnp8+Iv8idQ?=
 =?us-ascii?Q?ef1S0CaG36B+dBE4mEqPCC/YLkvgIOCeDuMkbP0n6rX3bwejXYrY0OIXv9wL?=
 =?us-ascii?Q?zRiW4RmFs8M3yCBPSjQ29FFxNn3ah8es3x9FpMoSni7q2qgk2vzdSDmrqn/z?=
 =?us-ascii?Q?67LEu3JSvee5UiW6bYMtarK3oQGgG9YGe3cKLtnRhGOwYFH75OeckzHFfnM7?=
 =?us-ascii?Q?At7l5nRTmD+oDGMk85C97ouvFIArTMi9rY4NGsFNR3fCeuMVFdTKJe7Dp+GZ?=
 =?us-ascii?Q?Ryc8FZ1yv0fmPjf3iRo5q/crZK6PzitYzfLTipECcFWKm2sFOayFLeMINZOn?=
 =?us-ascii?Q?JMYl8zGHlQNhAovKEY2yVf2WNdAU1LndgGT0ur8bzXJ6eyxWk5cpUlfg6Yo+?=
 =?us-ascii?Q?HfxpQ2jeXH//RwU65gIPEmw5gP9bXX44q+1bAgFaYby8aza8kweTNX8gZo46?=
 =?us-ascii?Q?6rQLcICvfQcfQDF40jOOh5UocZCX2ipdjfGftQcAmghEHg5y4DxLuB8jUBmq?=
 =?us-ascii?Q?xEzvNNIAJWc0hV4ha5m7Rbz3s9znatgB6TC8iefQYN9ROVfQKJSQfStiUL0A?=
 =?us-ascii?Q?GZS7RXB7RbM+FVL+og96/JAg870imznj9sgC8NxtKkmMoQMmkkEwnROxKbjB?=
 =?us-ascii?Q?XiiPerQu/ZCHI09x10Fe7p0oC6ui7rrxUlTHyS86QwA3XAcU6QTIONQPUq92?=
 =?us-ascii?Q?d8xmb8E8x00JAL2QswSJZoPgyKGDguD9AdEGbX8SpDL59JHQ2J4Y6fTRRWvf?=
 =?us-ascii?Q?zcRtA98M0sPIe3NeMkI8kP2fNN31pdUOlsYVc0LlpixMorRYHjT6E2lo+cp4?=
 =?us-ascii?Q?6U6cwmehJWeG5XhNcYktyUHuB1CNlsL7XXOWF2Ddvnxk88qicCPJRO4mn1+i?=
 =?us-ascii?Q?87Qcl1CfT1r34TItoJtLZ0g4JaHMkJ2vZrFwjldR1/7Fe3iLVxcKJrhyqSsc?=
 =?us-ascii?Q?CpnWXBS55T+ax1YomYREDc0cTR+Ckzr1vlLqrrl6Ga+VxcEX5KJ560mXdr7M?=
 =?us-ascii?Q?17GxPOgV/+tERJkycAXSVQtOFHH2RmXZSF5EL0wpAeyqwT4ThrT1WCxrBc71?=
 =?us-ascii?Q?LVlblrMY6KhWOSM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+//wCm2CTQ165/uvWz8TxEe7WTOD49jC4ZD8Y1Wk2GGiT6VFf9+ExiDsYaFK?=
 =?us-ascii?Q?UUxQfBiYJ0fAjsD5HWkEm5OLD+UzForOdnR4+C6ER7afZ7b38PzmAFKmB6QU?=
 =?us-ascii?Q?tobyA0XZbpozfIQgkbZXfLNtmGTBxAQedVKyyOHuescJuqcHKVZOonu0tJy4?=
 =?us-ascii?Q?A61uM96cfQp0LAknzfdmUzy+3mcl0qjKU3ICUVRlHYELfa6ywwO5+USMTICb?=
 =?us-ascii?Q?pWZ017KjJdK1MxglPS/tttc0wnV54SXGaSdPSmZ+Wi53oniU8eMQjsh+W07X?=
 =?us-ascii?Q?Tx9bI3N/kkJNKZG+KH/jEmolc2SHKhMPz2vO5WbJdMaLarIgriYKGoQRd0YV?=
 =?us-ascii?Q?R96GcnlRulLHMZaVCPhyxwU/6QhxOA663jgDpAAl1hBs5KP0snRn7+osze2T?=
 =?us-ascii?Q?2xN/GbL7vQuQacpaHPZH6TthPmxWd3qp6+fLiMC2/d6qGvoPqNsxLeoO5zS6?=
 =?us-ascii?Q?ZSaY6p2EbG1PWoV6oO5NleJKSktNWkL1678PDDVbD7RKq9ItkjLWmbZ4Huow?=
 =?us-ascii?Q?6CDeR5D2Wz3ZOjmMaRgIn8w2VgCUTjUIMp+1A3ggRMCpV1D6HM0Nnts1u9Y9?=
 =?us-ascii?Q?cj+eVs2KlR9bgJdWQhpVA7wvxUhJw2rCmoDzzjKTeXT6V48H1PscGTMrrRJv?=
 =?us-ascii?Q?yNej7BotybIu8wFY1hs2N/tSjHG8mY5gsNAwplt7hJUKzctQmo+QWf46xwRu?=
 =?us-ascii?Q?MSOXSwbHRo1Vj497qGwevYORuQC7/jrcRtG4OPXi5xyTsiCgoYX5cobvosig?=
 =?us-ascii?Q?U/PZ0FCqpPpcG63SKgV/be88KwXaza4mNF/vgMRf2w7EbHx0jb70NgD9EStE?=
 =?us-ascii?Q?5AWBcmLCbhvpN58tR2hStfsRHmvrmu8LDHzpBJzyX9ErUnTI/bwhZLhXys6u?=
 =?us-ascii?Q?Mr2Tr9/nvj5mnGvLi+ygQHN6/kEMnnJaMAVhMEkPKey2KT/V4kgdsd14vRyP?=
 =?us-ascii?Q?+BeHsqz+JgnuMLLR3MKX6Bo/zsRJy/cAh5MqveJ7NWWdgdfb0eLNqII6/ZUc?=
 =?us-ascii?Q?+z7Hqxb/dyJtB72M6KHFZIqS9yuAC9EpdV6ea8mw5qFskK5omK+oLtxBAP1I?=
 =?us-ascii?Q?Xj8d5KJvTTx8KZ+3p0lP/0SnD9id+Oliw6fq3kmfeFCiasrQ/YXAW+wo8JnR?=
 =?us-ascii?Q?zmrfx90tBru3/+kQMAwyJrj8jrgncoTVkYlvSPhHBhJtySOc1qtK0gQ6gEHF?=
 =?us-ascii?Q?1xuVr0O36/8pHFYgjJFTkj+o9Q6c5iwhsdhZQ8bIGpSMFieAR4ilJ42ULTa+?=
 =?us-ascii?Q?+bRz/gU9IBIJR9dKPVdNQfSr/GLDuBlwZkH0CymNE8kGtedA1l1ldGhgZp1T?=
 =?us-ascii?Q?UlkH3Qa83uIcUNHmj6+qBFf1bUe9Gp/AMVHc+80oI8C7hvRXs2kdMN3GAxOZ?=
 =?us-ascii?Q?SZ4u5k/qpbXM2mNR454yjwtz4k4IYgH+18W6RDJmUVUALiLV+CcGZPQpxX+F?=
 =?us-ascii?Q?R6horozGsRm7NBtPd8BLqNmHDb1Rbta69z0i77yE571daqs/jQBJpeF7CF26?=
 =?us-ascii?Q?9INSW7+qEOOuZi/sD5ayB+UBBTSk0ac8rXYLNtFDV/1ycF5+Qn/FwPY6zkPQ?=
 =?us-ascii?Q?PtE99nbVKe06JsTzc8F1SiM/1AkwYQqcmij1CuB2Hyx7Aw36QTpNO8ImGDQo?=
 =?us-ascii?Q?mA=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e437bff-7516-4790-e214-08ddb75f320d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2025 22:49:24.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7OAty/mb9esqvi3P2ZY437loEsJJzHt5Xfi3QqRYSg3ptkxR+gIxJqZoQ9873bVWgamRu0023kq0VKJSeIZ78uDwlWQY8TDbDbtNjFdeZFb7KSGLdEPAjoEvppiwzPE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9376

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Saturday, June 28, 2025 1:25 AM
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
> On Sat, 21 Jun 2025 21:33:26 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
[...]
> > +
> > +     if (tb[TCA_DUALPI2_STEP_THRESH]) {
> > +             u32 step_th =3D nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> > +             bool step_pkt =3D=20
> > + nla_get_flag(tb[TCA_DUALPI2_STEP_PACKETS]);
> > +
> > +             WRITE_ONCE(q->step_in_packets, step_pkt);
> > +             WRITE_ONCE(q->step_thresh,
> > +                        step_pkt ? step_th : convert_us_to_nsec(step_t=
h));
> > +     }
>=20
> I don't get the reason for all these WRITE_ONCE()s.
> You lock the qdisc to make modifications, right?
> And the block under which I'm responding is performing two dependent writ=
es, one to ->step_in_packets and the other to ->step_thresh a change which =
is definitely not atomic..

Hi,

Thanks again for other comments again, and I will take actions in the next =
version.

As there is only one step marking in L-queue, so we still need two WRITE_ON=
CE even two attributes (one for threshold in packets and one in time) are u=
sed.

When applying the step marking, we need to know either the computation is b=
ased on the sojourn time or queue length.

Best regards,
Chia-Yu

