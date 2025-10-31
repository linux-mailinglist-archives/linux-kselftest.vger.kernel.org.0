Return-Path: <linux-kselftest+bounces-44492-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B06C238E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 08:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5151895E3E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529F5329C6B;
	Fri, 31 Oct 2025 07:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="GjZp9HLa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC30E329391;
	Fri, 31 Oct 2025 07:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761895953; cv=fail; b=Zgyz4OPvWkppcPMQGiKc3czZrhv+8lEiWqKL2JFAvgPs9mhfpgLYP0oJiZ01born6InXO2t6SybGbNBVnb2wbUuKqvAUCbmtUv9dcV7m5C6g4Rmfi5S4FhGTHvICr9EhhMJJ3kaSEghSGn46HNVsUruD7KVQswka9do64X2pQuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761895953; c=relaxed/simple;
	bh=r+fUeZIdvBMv47rfkF62ZP/78RmWLFWfuFlOD9f+fv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EljstkbcviQjVdUxVFQbsXKG/+aJQ3ivS96Tq2Njw6SfeqVPztsOsiKi4YsWvbUrCoLdt9nUT0iv1SWnBpsTcZ2gquHknNGYfeffdCz7nk7zgjLc9rdoMTKsh2HeUlSD7IqpmmXNKwaW1+oFP+oHlrUtkLRHkMz8fP6fIGB45M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=GjZp9HLa; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL24cx6h778rk6G/LAJCerTDTDpzyFUqBvlGVBUYh0pZzp1jsDTowJI05G3Ak3xZr6U3X3mTCtpm4nOoS41ho+1EPk+W3HsjvIHXt3J/PaaLbX2pUtxPs4MrqO94bFRuqyvOiryVBaH3SbepY+RhkezdsqbVhWaTk0O3HMzG3Kq24Oo6yzvgohQgncxyZpjN+7CeeyzKX7+RaVQXMmUnaP+iaQOods2hKByuWboLIG6kJYYzp5KB4durTB57SbWPFUNgUcdsVWHUMuyIT5pir+GoRdXUQMwOcKvqoBJxZHARPRd567WvTbxk9Vmu+qAnLdQrfCnTsoHlIo2vAy570w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+fUeZIdvBMv47rfkF62ZP/78RmWLFWfuFlOD9f+fv4=;
 b=OKUS+qYgZxuIPAkCzUe9x5Ics4jK22jqflIjBivUhyJxuprPartrQw0dW3yOK7FscbCjatXSuQ78RAm+Dneb6BPAzv8rzAl+OOqJYT2MZn454cM4gooZaxmLwRUFXa4AdOW2ArM5dBsLD5QKl0/N4PP6FZiyganYeSVr3hcwc7QauWoWFcEpEpksCRkzLRY3ee1qBexTtGD6VmSw4eFfZS+j7+28RSpRfv9TjJY72bXjP7ZJ2/+pJiuQomrweQhiMlobana9F0eQEmJvDNeH7w2ahPqFGxKG1QW+sTLFVdWZfziXQXl8bgyze9ZR+z1yeIEE9Jlyy9SF0JNbTDR6yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+fUeZIdvBMv47rfkF62ZP/78RmWLFWfuFlOD9f+fv4=;
 b=GjZp9HLa9AKd6dQ1TC4R3X93/I531GffZ1Csnl7KtIIQOtYEWblWXQ4mP9HlGm1OolyfzJ4EMfZa/Hd8GfFTuUPyWWuRJawSFQ6E8+c7Y/K4wWQvL2AMVpj/5EhviUXJADo6YpmFz1n7ntgsf4bid6wCK5HykD2Fxyi71yCBDi19crTYiMaFQ9vR+U9/7rrcAPtQlgyMhARiLdbok3QSIRr1uezR2AWrcvROXCdPWHP8sCWfz1uhAhUYHn6bhmsFbU78ht4/d9Z8D/VdIF8NBQPfIP4gsaRL43p91EF62qBBvk3A8HKMnDkq6hw2QZZUCiSg3A0u7RdLR7vPvjR4rQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM4PR07MB11088.eurprd07.prod.outlook.com (2603:10a6:20b:6ea::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Fri, 31 Oct
 2025 07:32:27 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 07:32:27 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 00/14] AccECN protocol case handling series
Thread-Topic: [PATCH v5 net-next 00/14] AccECN protocol case handling series
Thread-Index: AQHcSapSn7GQdee2bkej55rw+3u3GrTbbyYAgABscqA=
Date: Fri, 31 Oct 2025 07:32:27 +0000
Message-ID:
 <PAXPR07MB798409CBEC44A185BD40ED42A3F8A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030175650.69d77ddd@kernel.org>
In-Reply-To: <20251030175650.69d77ddd@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM4PR07MB11088:EE_
x-ms-office365-filtering-correlation-id: 675159cb-6fdc-4bf8-9b0c-08de184fa462
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2FOsLk8d+QJUMZsLqcHClgdYGf1QZX+ptFYxjue3frT6jksvOICzwbKHohQ1?=
 =?us-ascii?Q?U/NOt2n/7KISu+jMrYp7uMXXe9+mci8gdMvtdcsE0Vt86n2i0tJnrgoPuFhK?=
 =?us-ascii?Q?tCgAucbPyt/ytA2K0+weCp75bkpdnmGLwHOLH4qJqWne5gpm29Dy6KUwhsgH?=
 =?us-ascii?Q?thM5F5lpV4UHm6lcSt5azPTDEnZDs4XuWsrqacHDrkpjV2PK2Az+Q8cP6KfO?=
 =?us-ascii?Q?AgBS7wX0QKPoB60ZUAFGfgf3PKNK82tO63CeD9lfTJkpQkJ6K0515aVaDlAN?=
 =?us-ascii?Q?MGyuXBuRHwdzgzYCT5Ne8ClJ2Wt18qsVurv/QUehPoHXG2cxhjP4gu632QMQ?=
 =?us-ascii?Q?2n84AVCPHj4927oWGw4BPaUL8xlsmRISIwTS/VHHP3bqEEDxYXVK5Pqs5eC6?=
 =?us-ascii?Q?AsnoOKZsh6b8h1iBQrjlzKekGlTCuZN0AJ9Ii30pJDwea1k+Xj9A5CI8vPNq?=
 =?us-ascii?Q?ORsF4Aufsy01Ceq/fqmn1TiInMjUzKZIx3kqxwc5dw89L5iaqyuaZS35Qi9x?=
 =?us-ascii?Q?xmhKEekqki+T0fWP8C4XGrQ5nrZJaSAJ0oB/SMixLESJ5TjoNmPXAaFZiWO7?=
 =?us-ascii?Q?z1P1tW7CMNxsboaFkDkLopL9yo96BfM8p0eCE/Fpc8d3PlOWNUWy8Rg+Xzew?=
 =?us-ascii?Q?M6JRs2evSOBYloaf6f7IUv9YaEg1zpwZoK3eqTJTxMwxxfH7+FqZeZb9FC9I?=
 =?us-ascii?Q?xXveCczBnBLqoJ/XzmmHuHvuoD++11yw1Q55HvHJYwZDxU8Cw+gjoFWsO9So?=
 =?us-ascii?Q?bk1qmeOb3Z7Ez/cGBV0mOdQfFFous6ZfCk1JDgdSvf8iJ1xFMzkbBzpM7cgD?=
 =?us-ascii?Q?nWQS9lWy+9ipCWaDO3PLZHYkL0XKiySkA+J/Ct1ZsIJkrVNrGn98GAXJ4+DI?=
 =?us-ascii?Q?KuU7GxZNM4dMSjgdZmy0l7B8yn0n83J37oFKdLzvSSKbdyhmUMTc60phkYZM?=
 =?us-ascii?Q?NZM1h2TAvU4Mt/fQwPhaDEt+ilqFo6EMuhfOKDe4zpSOO5coGqPAstcrJOm7?=
 =?us-ascii?Q?VRSXsLDm3AU8pLf6fPuP7+YTUuCqaYqaTaBA9rkWTNRUcQYPoU6Gj0g8VRLl?=
 =?us-ascii?Q?+qkqvri6iomFm01u1lBy8kX6+FEa90d951T8V4cfT8ho4QB7LxTLkVU7gspK?=
 =?us-ascii?Q?kpUgBPaWCe04+ZoOpeLqJBvZvNeZwC5v56O75OPkIfqCFtxXVG6laJl7tZfL?=
 =?us-ascii?Q?/F3NlzCtxwbRNLLFgIXfnGdbqtYvEFIF2DrYzLrJLONOupVC/fS1b2T1E1a4?=
 =?us-ascii?Q?sIjgET42ChSSMscvTEGHxdDTccyH4xSd4tLLUZnrpq5J/ZY7V2fGFuhLOcbp?=
 =?us-ascii?Q?FO4B+0a+2B3fSKWwI5WVt14A+vN2zGZCUUotVTKBf4yCEsDb1nVEztxJI9uy?=
 =?us-ascii?Q?DPk94nh2RJmnatUyy0xRIU1iNFlYiSkRrUOS60CO3qqI3euQ7m6fz05vz1hp?=
 =?us-ascii?Q?Te96KIDYXxeVOQhC9yEC3vUkuE1KnVnRhdMY004q3xOEBBLYlkuno2NNXVbu?=
 =?us-ascii?Q?LXvEGSO0YgmR6clnauKv5l4dE40CRR0QbLc/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SXeAitOIzXzKoBb9dpGtJkaDayKtnZVJeMWEgu03BMPhzZl2EVBvsRuSUdQC?=
 =?us-ascii?Q?ysLL82G9voDoWRQYBdmEqsQrDNsc/eXjZx5UF/fdFZnIVTIOJutQHpJroy8R?=
 =?us-ascii?Q?5oYmeWlqwt4FctNdSy6pFaXptuhSfmAom7a8S0PTIotXbpeNNTJEw3B8EO5Q?=
 =?us-ascii?Q?ObufJXCsi2dkJz/UYFBvbvHmNkNHwlVnPztUfjcPRWCErl/TxIM/C6Wo2/qC?=
 =?us-ascii?Q?ODD8oPUZyZkaBwzCXy9AjOiTFKhk7NB44KC/HgZJmVDLibOvbV1XV85XXhsq?=
 =?us-ascii?Q?lgvKjr6wKD5LuP9NMYizL7lFGUFn81SPS2Go989ozkU6lNpCrz+sNRFdfj77?=
 =?us-ascii?Q?jDn8khUr6yhAKOgG2LPNX/8d59wKO9RTlRkFBnp++FQKem3xIT+WXwmIhGjI?=
 =?us-ascii?Q?3NY2XJifewviH+kpfDe6eQhCtIaSY/ovv+efAgStKZJ4LsaCCwxh1ynJx8Br?=
 =?us-ascii?Q?5RBm7EWkUj1MQQTQJO5OHkeZ9ksWR6QbyTZbzO00SPg6DVEXmBHw+bPXlBgI?=
 =?us-ascii?Q?/JftI/jO5Ev6p+zqx6/kU9ukvZ/2c8qznZQSBC5U3pU8eY6ySnKuI45jCEKn?=
 =?us-ascii?Q?HRU/odKFf5acT3IF7tOhMSX6icE0ISUaH3P/nIqAz2UKyUKzWViIR/f6TcIM?=
 =?us-ascii?Q?37uC5/Fk7ZuvRNAUZSae29fR7x4gqFIiQ/ZUWgUYtYiI0Za74ZD5ZPHvqJH9?=
 =?us-ascii?Q?Y8Ln86LpnsZ87XfLrWhNn4/4gwjwUUnkSSjuZWaVeHuTB/3h5j1zUUWHPl+7?=
 =?us-ascii?Q?S2UHyKDwdSvqNVoSrxPIax/a/cJNhXdWgGiLz4dCkWlLF+/X6Dm0ZbzcoyX1?=
 =?us-ascii?Q?KWSbGggT7I/sEcSFhcUW5s9m8B+rtsL3hQGKhryKxqx4MfsyxZK0Y+3VMQwp?=
 =?us-ascii?Q?vj4sbHxiyTnRa4qoH26PTdG2LYImZ+hynlAcHw7R1b/aVEjwMCWPAEYXvapz?=
 =?us-ascii?Q?KPNJE84hubmnE9ypNg2D6b62z0KGdSusVbuylhqrgoSqySprXeACtroLwZkq?=
 =?us-ascii?Q?JjtCXa9vujJUF6LG2yBMO7B4gOdtqDmaKH3SNdNbFx2LnepM2x++oNwm92X/?=
 =?us-ascii?Q?o+B8KgYMUhfZwU/0MYYnSfCWzCcjje/j5NITPUvsvxvXoP1/9ANb5bZnBfxB?=
 =?us-ascii?Q?xGIyYOQW0svBLX6Of6ypNN7QCp6CdfGHF8BzJ8NAAyYbN2gnfRxmLZNTdKw9?=
 =?us-ascii?Q?EL1amr81xlQiILvsnWWZF2ajKCY5AzkVkOYH5lUYm4iSnn+3iUfrosqQuG0r?=
 =?us-ascii?Q?pTTCdSFLB0DUt/+6LSlylC6KeanMLMQIV4Vhadfo1LUuLnDZtMppQjSwfGQs?=
 =?us-ascii?Q?jJr8QLDk00K6nqBLNlXFGL4BsIYQiGmwqYpiIdMXbMZGqWgF7/TPpq/OygZY?=
 =?us-ascii?Q?tKmAhHaUjzoTkkvk3RCA5pL/5ZktZnZ5uK59ua5dtCA8+lc522lcfUnAfI/G?=
 =?us-ascii?Q?0Ul+7Hvjy4b3tc1nXB6/DM6fUhlwDZt7apMbNPyc1djZ+Y0H6JcQB2nsXWce?=
 =?us-ascii?Q?WWijVKmjYTNhmCObqZfNFTp/WlOrsLsPG73mx0Dy/T43zQfE29R63uXYuY70?=
 =?us-ascii?Q?mKruZGe6Axxm5eVbTwpKbxMoFgZ3vg9/WUUnQgXfDXI50t3TffbrEkDLKbPC?=
 =?us-ascii?Q?CQ=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 675159cb-6fdc-4bf8-9b0c-08de184fa462
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2025 07:32:27.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XsObv8wHkVLWFiQoC0jspxnzoK/JqiyzOJ8w7/LzlNDFqV5SoNM4vVY0Y7WYN9zcwNT7+zn8K5H1ES85AS1x28jzyDYouWCrZpN7u6W2wt1Bdzj5vvzfZQPLJAvXE0cD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR07MB11088

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Friday, October 31, 2025 1:57 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Cc: pabeni@redhat.com; edumazet@google.com; parav@nvidia.com; linux-doc@v=
ger.kernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniy=
u@google.com; bpf@vger.kernel.org; netdev@vger.kernel.org; dave.taht@gmail.=
com; jhs@mojatatu.com; stephen@networkplumber.org; xiyou.wangcong@gmail.com=
; jiri@resnulli.us; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunt=
er@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linu=
x-kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De S=
chepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.c=
om; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshi=
re <cheshire@apple.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi=
 Goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v5 net-next 00/14] AccECN protocol case handling seri=
es
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Thu, 30 Oct 2025 15:34:21 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > Plesae find the v5 AccECN case handling patch series, which covers=20
> > several excpetional case handling of Accurate ECN spec (RFC9768), adds=
=20
> > new identifiers to be used by CC modules, adds ecn_delta into=20
> > rate_sample, and keeps the ACE counter for computation, etc.
>=20
> Is this a pure repost or you changed something?

It only removes one empty line between "Fixes:" and "Signed-off" - no error=
 was reported when using checkpatch.pl, but an error showed in patchworks p=
ipeline.

Shall I resubmit with v6 tag? Thanks.

