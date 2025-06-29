Return-Path: <linux-kselftest+bounces-36083-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397E3AED1A4
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Jun 2025 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F2316F91B
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Jun 2025 22:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D638DD8;
	Sun, 29 Jun 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="N62Dq0Ez"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010054.outbound.protection.outlook.com [52.101.84.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956028FD;
	Sun, 29 Jun 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751236344; cv=fail; b=XP4UxbBfJf0XNAW9BBMBI50mhk4HLHRV3CmZdsmaux82ex7VXA8fl4+2WlaHWe8tJVnexJrQoSRaFFvETOzCb0gTYsmCEc0KZcQ7NsUH8DzJZOM4V2T1rEFycUJaWoV5IYinZC2SYB7SJR+K/DFsPHEpxhqXMlf2ik3dffRSv/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751236344; c=relaxed/simple;
	bh=u3RoTkeVtL6Ipdf2xxRYkrG35hIO2C1VzMpV9xCuLjo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rwaF/H2aWLf+gkho7KibvDuiwEON3geyXLzZjLNFHa9JhrBzu+75+fp3357Ggy0lYNMRS8dOKCFslB8S5GEAh3KI4UbqBDMlLV8d/XV5+IwA7MDDJdRtxfihkubiqDRzVKyzY8zjBvljAbRGuJfOxcWGeoQOGD9oLYbAV2yaIL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=N62Dq0Ez; arc=fail smtp.client-ip=52.101.84.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1mpt1VKU240c8F+KHnuuJYH3h0OcdIakLOFxb0kGyUwFSum2twqTq/JcmRi4laoFsXDiMqX1R7RLoXOxLNf71hn/0O2ttyj5L6x89YNvqCJKmrBUaAI9iHKrPB14okjmcUL0iGyNGx6UbQ2QU1askxmuzyM84EKMEk3JH8C591+Pt++gf5TGngDLrTXPaBIvaX8op/iTcmeVU7Eney+mLQ8ZY/Ex8nWsIkUheG//enCm8ccAxvNxqRfm1kRt0yy99fhQOEGxXJJeb0Rhjyf+TRWFZ15TBKHvXeetgl4YhqxQZwfKi0PzXU0gQbnDj5T+M24mXZHJQdHe2g0AOzUVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IJVBxK6pidU2Z19rCc40prNKiIATKlA/2x7a1K5kg4=;
 b=ZTxS2NB8EvRwTd3SeJBFrhY0jVAF1Xg8XUnTzl0Z+o5mbk4Oqw8hkswKmBDFQWIdH2031VLX5IbFJuCY2f9PRb9rJfxjhIJCXVfucGdSwAmzAEJDRZNN6FSPf7d/3RFSLU9IvXtbWBIiIGt5yjvFXymtsT0pQ04822ogjgyXTImQGNvp4TjFKDwnsQ3PBVcI4+4OHTUFBHDs9eO696PrrlOisPg2nQG5nQnDSmZ6rOXEOeheNPoMv0TgB0iz31DqhWluc4tUuVBIDNh+FCkbwSSEtwc4VzqDTA06BTTpT8QFio48WrQbTmihTyvKvjsyFbFJZgPnn157Gbc4ExEM3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IJVBxK6pidU2Z19rCc40prNKiIATKlA/2x7a1K5kg4=;
 b=N62Dq0EzxvHmKYcNHcWdarVE+mQocTZSOS2qPEr7+ESCyPc+3U/iWhf8o2THUp9dZUljQIdAoBdK8NANtbx2zdeg+fE68Qgcsa6tXD5+t1cvh7kuq2ByOuFVcQsEbM5rrQwuwp7N6W5tVLzwx3HTUVwOK11JP16hDwaUHe+E/TmpZB4KJtEEFgNCvdvZMh7t7s6hOZ8hPI9a6RV0gbbybUxRcboct9Oost4iyiLwmCYKpHn+/13N0vGniH258TszB92wltj+bROu5EQ/TVLMQwt/Tazlto/Ir8b8A8SuK+pW0n4EGEBNX1w/yecflz7SBm/J+qOdHw/1EZxNv8eOVQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB9084.eurprd07.prod.outlook.com (2603:10a6:150:c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.16; Sun, 29 Jun
 2025 22:32:15 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8880.026; Sun, 29 Jun 2025
 22:32:15 +0000
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
Subject: RE: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Topic: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: Add
 DualPI2 specification
Thread-Index: AQHb4uNqIs45AgjdskKJnV37K9wpJrQXrhYAgAMXXaA=
Date: Sun, 29 Jun 2025 22:32:15 +0000
Message-ID:
 <PAXPR07MB79842E86F802F227C79C05F6A347A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193331.16421-1-chia-yu.chang@nokia-bell-labs.com>
	<20250621193331.16421-7-chia-yu.chang@nokia-bell-labs.com>
 <20250627161930.385554c0@kernel.org>
In-Reply-To: <20250627161930.385554c0@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB9084:EE_
x-ms-office365-filtering-correlation-id: cea181d5-edde-4c90-50e6-08ddb75ccc73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ors8usrSE8g+kn/q7mE/rSt0ZfCD7N/0zP2a09MNbJgJidSU6rcCBWuSfMGW?=
 =?us-ascii?Q?cmMmeFq+2CkUQjDVVpm8Q6O4O1rlfH9myn+QWAiL2N5wGHYPQC7JRNU9KXc3?=
 =?us-ascii?Q?XLP1g+rjwLHlUEadXsGjX7XyYh74QeYP/bhOOYNU5NF18086eU4ums1lqslL?=
 =?us-ascii?Q?wprM7oYYflM3YEuGDvHumombEhHveQ/II1WmDU7BcL32RLI4taSX6cMilPOg?=
 =?us-ascii?Q?QNMD7cFxqUy0e/Wotlz4DUJX5fBTCQCNAnCr466Wnac2esreMN5VK1zJQQkU?=
 =?us-ascii?Q?nnao3kmGDg16jwY53AIXl633q31nW8czafCKeZikVdoANlBjIa8UV4I5KUZk?=
 =?us-ascii?Q?tUeC7PVvKaAEl+crisUBCrzxBTC7Lza96Epfqp3hg4dyhoGJeu8D38VHXOEA?=
 =?us-ascii?Q?az1Vlzdo52ap8Pdqje4CNRMs2Y35HSVOsZzulMaSCoJlzTpS7R0UYPKRw3ZF?=
 =?us-ascii?Q?immg4zQErqoLzjNOsriMm6x7+MFkHq4PzuIdNuhYkIRJnK9l9/of8j47yZce?=
 =?us-ascii?Q?k5lkrF0ekl6+aoLZQjjJa/zCsdepFq/qhSTqGZXg+cq1UJ0QuzqO8SbDe0Y2?=
 =?us-ascii?Q?Sl2kWFCsRHv3RN9XjP5+fZVCmFj+t6vhK6p2uXOgwv8URZkouS6Zp1sCIBpj?=
 =?us-ascii?Q?9CabEogFQA25KDk5N8HF3fWVsSQARnQidgYtli7PnkHZCYffQjZh26+6QTVZ?=
 =?us-ascii?Q?hpd+t/WaF+a8hXxKsyd0lm9eGVs7FNyZfJLi0y89M81+KGG/UtR//+RTsQvJ?=
 =?us-ascii?Q?+NDFCOQjRCbBH0tThAz3TzXBVemE3R3ipR/cwWLaQGai1vVC48+ZLb1WzfQq?=
 =?us-ascii?Q?U9UD9VBh0xoXaZy9EY5QDbnYsIA/SzO9EXEeDEAOMi8HH22zNHMsaeyQ4XFk?=
 =?us-ascii?Q?Cw7A9H4KGGZSMrYR7Z3+TbbXALgIAB3EQ6oYaGYMxy773mVwmm58RMmOaVb3?=
 =?us-ascii?Q?PVpsmIAH8qbj1wtr1U7qeVYgg3JzElJYJD/se9N6/gvtLmPI7VsYC9Q66VBQ?=
 =?us-ascii?Q?l17gOrlXQQo2WYCbKX+D3L203vL7BBI2SkEZD8q7vuhmaI3gOUCfBwL76xWK?=
 =?us-ascii?Q?QFpYUN07SPigzS7j4/c9r0UeiUvJatdHeMxFb8r8uZjTopyhClLDm7oX4Hh+?=
 =?us-ascii?Q?e4OZ1mVaOk2j126tIyQ+7t6CbbJg63G5bx0q6OmoSyxRMoWpcA/vRzOUsIf/?=
 =?us-ascii?Q?1Rp/kcIQn+RYbv+ZYUEH26+TTgLc3PnLrY3650kpIOQTn7yAfQQvI9G37jqb?=
 =?us-ascii?Q?G1nCTDp95ipatGvI39hw30N2Bwp9NbJDBBxtDAL7z3X9AslKMJcJo1sIZ27G?=
 =?us-ascii?Q?f8CO/Mh/u9oY7d7au72zIjLxgFu+ynKjvMIWXpKtvl94g26arnpw3fkTP1Us?=
 =?us-ascii?Q?YJMn2poBoM9rP3MlagcUVHLxhTPnjRyjLb+BpFgT14kC8UNw4Pzu9KOWyERX?=
 =?us-ascii?Q?XUrTX3PUd0pLnah+fZhBcldCTEESQIwn2o5X5w3Zlm+06FcUo7NkxwPCYRPO?=
 =?us-ascii?Q?LgNE/7JkjpdjH1U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?W9QlMvbNAMYv3gpkJ/IhkjiGG439XbuFW7jZ8YuN+gTQOna4txSd49BuR8Nv?=
 =?us-ascii?Q?39KVqIA1bedqc8rulyZv0SyqUA1jbQn1ujkiBpvLVPeLfKkggBwkHWKNSL93?=
 =?us-ascii?Q?KQQkaQ1fRKT9g9zGNu15eRm0xr3dDMoD+85dfkzKsXm94C4iNdRKuG8HtZLP?=
 =?us-ascii?Q?pm60RVRurcL9meAJnZ9qP05TQogy4bc7CS7DUUBmD9cSYI0z3Kc7TlSzFhXg?=
 =?us-ascii?Q?V+7sKPY+EiQ7dA2m/M0XBLv9Z+m+hjV4IFKHc//p1pfpb/kDegPVUXMJv+Yh?=
 =?us-ascii?Q?3xm11djDgCSOwU0zoCPBIK6os+QjVlJjmvhbjrF6Xis9HcKZ4pmaB197R/lN?=
 =?us-ascii?Q?53Ufia0zUzT3UG/mF37setWYeK1BEfTPFHUW9G5caIBlusNpZsJdPYspU201?=
 =?us-ascii?Q?yT8x8j8g9/vN/mQF9OXIhGR+h4T+dHLP6T/b945rgMzA3vGffTD1e1ongXNE?=
 =?us-ascii?Q?P2NH6KR4vr31tjBFD96bbMM5ck0Fz1RAlXS+ufg7Te6YASQMJ9o16IsmNF7e?=
 =?us-ascii?Q?HX8cymWSZigQsh+lhKooHnoROyK8V+xv/WALKFHzuzv51BO6XR9+aZNzjU1q?=
 =?us-ascii?Q?BD34FJTQoxi6CMaCqS4fndJQeE+YZn13YujT8z/lobs3H5MqfKcGIsV7YdCY?=
 =?us-ascii?Q?tA/0QojrtX5SNIBIgahBgUAR7uAC0VG5iSYBD+sYdH0KQzZGiWfq/sS0ckPv?=
 =?us-ascii?Q?9GRZI2sy2G7aBok+UhUNwpiWZz5lWWufuQ3BItT2oNHijbhTvOTwkGfaYSLw?=
 =?us-ascii?Q?h/p5CQS1F/omQ5q1L2Puy+msjy6Ml5WJCZWmKVnr0wLtPTJQ0jLqLKW0iYMU?=
 =?us-ascii?Q?7DJCyJUKNrc2R8cwOP/28sIALLx5nai8U6RvB56uOpXEwKQedLOLYHA0I73I?=
 =?us-ascii?Q?YdbHn1CihU1Ua3XHuLd7TE0OwsFIJhifKaDOlmQT+k9naFYssToNTy8C1mRy?=
 =?us-ascii?Q?WyMUzpSuk4WwFvs8+Qse1/fR5X/EmeLbhy1ROHkeHQT3scg1CaTOov+0FHOH?=
 =?us-ascii?Q?s+wGYqkO5+usK9Ar2MgymNhNmJS4OkL7oqcxGew6VzWjBaNrQZwGxulJk7XU?=
 =?us-ascii?Q?QJSMNsyPEp+q6j7pzHxcHAt6q7DgykiMhc+ALX8qqdumfdt7HZz/dl0HE671?=
 =?us-ascii?Q?eXpTem8APbiaHXXjOU2Aui7B0XczevsljmUky8rrTkbUnnIAN0+3sE1SXPAp?=
 =?us-ascii?Q?DVvLC6+Ub1IVOStHa9/8FhQeAaOFjqNDXPkvvN9Qy/IsXcUNPqitOTMNaaKM?=
 =?us-ascii?Q?OMGkKUp9cdTTgA5Sp2ToRObnYfBIyT1n8/2LsHUJhJYpRB0O4NnBK2VcRMbP?=
 =?us-ascii?Q?NnOusgR8VmZQkIyKw+gHU2lb9WSou+l4R+ayYSEk3E6Gxl8ndvFS7k/Gnmxj?=
 =?us-ascii?Q?/IL4ViFm61fiiGACQ68Mz407rwi8p6ImP7dWE3eQq7o6cANV2GWb5iMJKn08?=
 =?us-ascii?Q?Nl+B8uHjTrQZ6/q2e7fV4ijmhPlVqh7BefypcPobbwnrETs1LmpDyNsmOSrx?=
 =?us-ascii?Q?N0Ay7LjvLX3ZFY8zYp8jznIw2ysxwsTeWhOqYLYuj3mx3yfv04BtYSLN4sXt?=
 =?us-ascii?Q?frunirNJOfjXllIhguvGX/UadGowjoFnObe1iQY08M56dsfRbI4gq+65yKP8?=
 =?us-ascii?Q?Aw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cea181d5-edde-4c90-50e6-08ddb75ccc73
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2025 22:32:15.1172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nuL1FDhPVsRXWqv2zTyVPxwcU7Cq/ct+O8BIUOp4v6Arv38PP1NLIkBcj/dsd8LluWtZW3SxHslmmF+BkNC7Osfc7L18LMpEeEOohPX79Er/nYuJRvf/U5nzjoq40TaP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB9084

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Saturday, June 28, 2025 1:20 AM
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
> Subject: Re: [PATCH v20 net-next 6/6] Documentation: netlink: specs: tc: =
Add DualPI2 specification
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sat, 21 Jun 2025 21:33:31 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Introduce the specification of tc qdisc DualPI2 stats and attributes,=20
> > which is the reference implementation of IETF RFC9332 DualQ Coupled=20
> > AQM
> > (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > different
> > queues: low latency queue (L-queue) and classic queue (C-queue).
>=20
> > diff --git a/Documentation/netlink/specs/tc.yaml=20
> > b/Documentation/netlink/specs/tc.yaml
> > index 4cc1f6a45001..8a183799dceb 100644
> > --- a/Documentation/netlink/specs/tc.yaml
> > +++ b/Documentation/netlink/specs/tc.yaml
> > @@ -56,6 +56,41 @@ definitions:
[...]
> > +      -
> > +        name: step-thresh
> > +        type: u32
> > +        doc: L4S step marking threshold (see also step-packets)
> > +      -
> > +        name: step-packets
> > +        type: flag
> > +        doc: L4S Step marking threshold unit in packets
> > +             (otherwise is in microseconds)
>=20
> Why mux two distinct values in one attr and carry another attr for the un=
it?
>
> IMO it'd be more idiomatic for Netlink to define two attributes, one for =
threshold in packets and one in time.
>
> And enforce that only one can be sent in a message (probably using an exp=
licit check in the code).
>
> Conversely only report one in GET / DUMP.

Hi,

First, thanks for other comments, and I will do corresponding changes in th=
e next version.

As for this comment, there are already two dualpi2 attribute of net-next an=
d iproute2-next:

- "step_thresh" and "step_in_packets" in sch_dualpi2.c of net-next

- "TCA_DUALPI2_STEP_THRESH" and "TCA_DUALPI2_STEP_PACKETS" in q_dualpi2.c o=
f iproute2-next

And the above two attributes in tc.yaml can therefore be mapped one-to-one.

I was thinking could we keep the same strucutre? As we already have several=
 rounds of review for both net-next and iproute2-next.

Best regards,
Chia-Yu

