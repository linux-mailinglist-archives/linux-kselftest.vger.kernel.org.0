Return-Path: <linux-kselftest+bounces-37828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4B0B0D6EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 12:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5341456347B
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Jul 2025 10:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBA72E3AF3;
	Tue, 22 Jul 2025 10:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VOojdQe5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D572E3396;
	Tue, 22 Jul 2025 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178686; cv=fail; b=hy1KtP+HskYzUVl/vf+kQTPJNwqC1BEse9Ni4xKpPGDEKlpjNaCZvJKi0HUIEPIyVXCiczFsmAOhV+YY0L90XO4M/vOk48p7LNmxZY5DGRkp0Bdz07VLzsK5jfSZ0KRHQlTmgQI2wNi8K66+WwaX8+NoDNx7T5PjAQIegXT0iug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178686; c=relaxed/simple;
	bh=nUEDh18FBEb9EsuCpjNFYwz0Ohrl2uKIkzUJ/NuBsV8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K75+Psr63EthZauurdZakq53wnLCN4WyLn4qAZfWZIuS8FgtDxw/DbFCXHLIfw4YxwizreZ2QGuwN5STBjrYxAWk/iPoYD12LyqufYtorhrW4UBcSh9Pfpq215TkrR2npvhUK2miU3VuQybW8zzLptv3xADJrXx1bIBWIuIUk2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VOojdQe5; arc=fail smtp.client-ip=40.107.159.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=csZ+rzcDEfDgpUzPa1Xgcn2sWmZ5X8HlziJ36asndW81b8We//lWY4FeIrLHpuPcoloyILy+dg/VwYDiNesm1IYiVb2+hN2GI9f3bj3k2qnf9Z7R7lBhvRHL3/lrEJUmDNCSJshi66yVoWVBBKevIBQpAOyWO7T0dfJvQJhLvKQg5czNfSmnHoRSXiFIW/ulOZWjEFLTo+AUSjhNmH+vqF8n25hgyn6JeRPagGxuyMpvqh1f9681MrQYvMke+CdpVUyhfJDL955QYWT1jrLPZduu1dR4lLp4qua6u3ONlFQz7qOdPV7uCOr/XKLNHfVzT5+37AnSWY23UFlY6Dx/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+kXIv2sYF3Jzypb9JBq9Q2Y7ahAY6Gf3NYjZHeE8ao=;
 b=WuY9ugXN4n1dYpesv360J6pk5tZLn9CIQtDJ/QjIjkKt9p6h9L60hikuTfTXrMXaxL+pQPJh5DUsT669CB4h2EBxIoyQ/ilO/QAVDsgvq1J+wiJN7FSrcCw/cwKTFehwgA71ko/TO9BTkU3L5oEzjDJcwWXyYQKiMb3sYZ5J5svtXF1sHmWY5+fmnP/dOV7OcZwGK0UvkMobl5wF0YV1UF+fIyNYBgbBM6R/KshCMkCZfZ/nXkfe0TSamYGao1tByhmSd01DJ7KNJzVzBqX2Ne8QNmWpOG6Zw6aTojQDjIVVZCJl1TLrNPO3nrCyuq4m4uw58wiH9akCMKA2pipFJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+kXIv2sYF3Jzypb9JBq9Q2Y7ahAY6Gf3NYjZHeE8ao=;
 b=VOojdQe5O/xSLishqdug5CS0lNzxnWdPaDYn4E405vp0eu3am6SrG8oRtjFpts6XcvCa+XfbwgXbNZLUgqDFI8hoKf8iNEYVXW4tbTOhCQC6DzWPg8qPanzka7BiHA4e91mYRExZNJ0Vf4lv5atwa7hhod7UcO4CkNXA4WqIKKmOj7AtDxbm0cbCPBv8juTku0gflfg2bAIN5QBXDhlvgDNAoQQTqcJ8Z1doPY3v7KV9fMK99VSmwA70/ZYVXjwmT/swookkgAAy1OTwP2dtUc5uIwIgN/qxlws7KE710HJV26d16wWcyIiND8Va5BFWBCsGmkNmMa60yff4Dq4wNA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS8PR07MB9546.eurprd07.prod.outlook.com (2603:10a6:20b:63f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 10:04:39 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8943.029; Tue, 22 Jul 2025
 10:04:39 +0000
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
Subject: RE: [PATCH v25 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v25 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb+O2PO3/NDCPNP0GSkYeAFRX8ZLQ9VAGAgACZJbA=
Date: Tue, 22 Jul 2025 10:04:39 +0000
Message-ID:
 <PAXPR07MB7984D04907E26205EA9936F8A35CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250719204129.15737-1-chia-yu.chang@nokia-bell-labs.com>
	<20250719204129.15737-2-chia-yu.chang@nokia-bell-labs.com>
 <20250721175243.5e620997@kernel.org>
In-Reply-To: <20250721175243.5e620997@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS8PR07MB9546:EE_
x-ms-office365-filtering-correlation-id: cc31b3a9-4386-4a8a-e3f6-08ddc9072bc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o+JJMa20zEJhby0d9VhH7m6SBlDfnp77BLaqFiPdDtyq+HytQazhw0VOe29y?=
 =?us-ascii?Q?UPLlQx1In0GWjOjMoyR/AZEK1KTXrIc/G40gXLIJREiyP8UNRXfqe7eTNo4v?=
 =?us-ascii?Q?8UuFzwQAWsFZVIEBE33Mtc/zaUyiFwYdBwfoAS3t7Ufa/2S4OO0My7lBi2xb?=
 =?us-ascii?Q?ROBA9Mq+ymOOwgc2r4ueMRwdmWMzTHES9NCGs8Pt79QycCbvGqGC0WCZiDag?=
 =?us-ascii?Q?xD/CYU70DH0rD61Sf5MeT2g3n2LoqDvHkeFNsD7aBIdDSwtUfzslspbfT1Gj?=
 =?us-ascii?Q?Y7ix0tGemxIQUGFv+T+CV4dsJx1+VwwFbprEUl4R2qs6kWWXLyIr1fJFH6+a?=
 =?us-ascii?Q?Fea2CsGrq4IN5fkCS9IJ7dU4fWNkQo/fjSysYBQMqo4dGL3+bbWHfP99Uize?=
 =?us-ascii?Q?/BJWAZaYrnh1+bDTxQ5jn9oQv5ZCAQ08F9XDrSifQZvPlfyhPuVfUJkZdfnB?=
 =?us-ascii?Q?CQbnk3mNEkUOgyvXzRltFK9Lgg8sYZoZWg2khL3KfxFKN2EMa7mmw37dhnI8?=
 =?us-ascii?Q?7ma6xno/6njwIYi3Q0eWVuFoXZDxEMgty/E4wt559uuwQjPg6FUq6qOU5u/M?=
 =?us-ascii?Q?OsCqiN2d857d4DXnRRO7Q04vHGBZUOdc3WhLZrmeGnWLo6Nix+zYRf7i2gxW?=
 =?us-ascii?Q?OuVuIIvIKd+3vYy7ssI2nAIhMDb+a/EWs5xu3sKwnYgfDs0WapTBBHfNqI6b?=
 =?us-ascii?Q?wvL0A0Lm/8P0ggA64QrGn3oVDjHYJTsVK3DbN0qPHoUNerwEsoLUpRV0jEUL?=
 =?us-ascii?Q?UiECAfldb1cJGoZmfsrpOB/ORLAspRNMp9CbEKDuPKP74a/Q02XQSyvla9ZD?=
 =?us-ascii?Q?kw4Se5OA7LypiKF3YYXnZF0yETiDGfrD3zhNwGdr17+m+A0ayfKeyJddafn/?=
 =?us-ascii?Q?Z2w5ivBZFCCLZtDCUaY/yBux24ceMuWCsa7VQNiLIIg5kXyqK3FCz8Xquw/N?=
 =?us-ascii?Q?dRdgY84ChgYbRc7q/yffhrzKYcodJ4vZMmXfS8O3/2iGGmr9boBg20Mjh57R?=
 =?us-ascii?Q?dMbT3184n25rP9DHbuz6OfardfKcdMuSo+8g2mVP5NZ/VJvdVMnBFrKclCOp?=
 =?us-ascii?Q?6b+toRCdCHzRQy4P545I9JfViIKz7lWz8D9UVt7PprO6wM3ZFwKWSeGRElz2?=
 =?us-ascii?Q?HwihtQzWQHkO4ogg8/PKb9dVEpqO6rXO/3m1Q9MPDlClC70TIc9/DDetEAYG?=
 =?us-ascii?Q?j61tz0sHY4H0rOhnudGV0YbYafh/Nd0p1YC/jmBjdzAkKPrJaColdldBFMzC?=
 =?us-ascii?Q?UyEcJm5+v5TB+QspzojisB31wsnkCXMZqLkTUjP746VAkRsGd052ftSGygPa?=
 =?us-ascii?Q?jigAl2YpsHD24Em1iGPuiOQGvUk91LTF4D334knsFC6MNWUxdFJN5+/PbzoL?=
 =?us-ascii?Q?CeJDYmJAGU+5pCHiFKFrGw3WvYxphbDCZ9MZp1kny329f0oqigpCu69ZQD8a?=
 =?us-ascii?Q?1lsUCQvscfOc4XIUwzpKC9IYcQD85QmvH0kzx/yTG4DnZz0kNroCpF+3KE+U?=
 =?us-ascii?Q?SDQM4ACBlXb4wzU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KfhuK7kKLJFELsiOWh6mQImeZw2x/SqBsU2BoBSC76li4WhshLirCuHe3QyD?=
 =?us-ascii?Q?X2pbblRxYQSAQQtFXCwXyw+7SX0a+1spMu5bs6vAIEpc2rBDJEvKLPCRRBIQ?=
 =?us-ascii?Q?FiFb9KsuXZLYpYQP1ZS8JKJanGBzE7R7kqOHMbokufYQb2mg3hkYQ0osKDe9?=
 =?us-ascii?Q?UtdB0AbKUAFJwkRmDwCV5WSFwugO0t2cgWuXsac9guem6PipwcsUx+4eABJy?=
 =?us-ascii?Q?/30AM+amxQip/Qrs0g22OinFtw4lVOMEmRvBdj8QITlrnCGePxnnPlDjocyw?=
 =?us-ascii?Q?Q5XGXqk5489BlRKkoo09z+Zja8/0+PNrPk8YXLgperL9+DnjolJ+xf7CShb/?=
 =?us-ascii?Q?q87qymku37X83UMtZ5ZehEcpxn1TMs/kgeQQEEOwVH+9DS6+dOVbj8Ezs92M?=
 =?us-ascii?Q?n38kPNpFZU75WP8OQuWFk78Zc4jzM9keo7Gml4ncGctM2T219iU1ZY6A9V4t?=
 =?us-ascii?Q?H7C73IfLSrLGFxAzd0okiOYqUblbluG6WXG6Eelq1P7mIdxk9HsSCi4+uDUT?=
 =?us-ascii?Q?cdCnZlWMKtw9mPvuKVkz8/DnKeqkCCqwLeT0ubuMvhJFtRSCilpPQrGtSBWc?=
 =?us-ascii?Q?qu/FZlZkCuJG4ddE043GJtLHcKEIDwu+YrOqYwy1q85qSnHwZGDgxAdicKX9?=
 =?us-ascii?Q?Xb0LC2DdgceflbuoahbRQjqQp3P8XUmCXHA5NLO+HlBQZLGUZ7lCedQpTe78?=
 =?us-ascii?Q?hqKJbKcjSXFVZtuUKkrTFpLJ393fRM1uSho8WlXRU95TQofmwpjnK6H3hDPe?=
 =?us-ascii?Q?W+lT0K1RFPjTqYemYvC8XuTM7wuw5NaI5kqDtoMzyQBIsmmv1axWL/UPxSwy?=
 =?us-ascii?Q?ka6AnJYuX4oCU7sf4lrvFLPa/+RdVQjvAVRBw7bZPWNeuyO0NemNx+V2/nKQ?=
 =?us-ascii?Q?7VKlW0X6d8FiKn7fP1gMmU/eucIjyaUs3vEPsmhdoT8dbzkiTS9+lDqCOeJO?=
 =?us-ascii?Q?76o5AOSTf4SzRPWtSWuG1fy/8ezDAO7QRoQqYhK68DX08IbuQ50+LWk1iCT4?=
 =?us-ascii?Q?aATYlWb5fPERdR9Dn4tVZUlYkcW7vAdoM4Fz7HnHNPqJoz7eOupauJqTmb9Y?=
 =?us-ascii?Q?f93lWyYvn+gDf+BPjxl6My4p2oMjS4TiGXRlAMtCZssq3Zs1ScM6qMJrAs/f?=
 =?us-ascii?Q?1ByRFGa2hDmu69hR+XQe4P43XC/IXjOuGRT7+xfQ6tTKvfw1+gYjMC7QRovk?=
 =?us-ascii?Q?EJs5Ll8vuNpCqz2Rh6myQHa1AD8kn1jioBxnvBKYPzBd31bnwsWFl0ryVehY?=
 =?us-ascii?Q?URakChK3GAZTRbGDwnKLerItGRGe02rwSQAy5dl/wa5ppwXgw4blH3zYaTzq?=
 =?us-ascii?Q?ouvrEgLX57MXPaJT+UaL2xgkki4LJq7O+iF1E3sHS5TszujUtK0agefmASNH?=
 =?us-ascii?Q?J+DLym95SXGiEggfbvCoIEK75mYYgul9cTCnf04+5rJAEAt9Uianp2rGjal/?=
 =?us-ascii?Q?EwpyWYrKGzcWEzH+yc7q1nBrMHThAD3e+XfMGDPxAPhVKrkrXuBrlPXFexf0?=
 =?us-ascii?Q?q5pS/M0gt0gGnMBpbWR3O6Y0Kd+xkVuQ7FTOM3Vy5hW8DGxcsobQ/c5BxdTi?=
 =?us-ascii?Q?pgA02+lArT1syGtP/aTmJkseDCxggtvqORwPy/6RVNLSBndeaFb4RqSB7Hh1?=
 =?us-ascii?Q?lg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc31b3a9-4386-4a8a-e3f6-08ddc9072bc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2025 10:04:39.2553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6eNXice/c+FZgx3bOxTobNVpsh/84FnUT+OsyuG2UUW4F+Wed0ml3LMmqunyMrXQHxsVqWrNt8D21P5Heab3HOk+NXaoqWx0Zn5IAcbxyybUUsGX07PGxuJ2paZ3Xx+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB9546

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Tuesday, July 22, 2025 2:53 AM
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
> Subject: Re: [PATCH v25 net-next 1/6] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Sat, 19 Jul 2025 22:41:24 +0200 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > +     q =3D qdisc_priv(sch);
> > +     sch_tree_lock(sch);
> > +
> > +     if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRES=
H_US]) {
> > +             NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attribut=
es");
> > +             sch_tree_unlock(sch);
> > +             return -EINVAL;
> > +     }
>=20
> tb[] is local state on the stack, parsed from the netlink message (also l=
ocal). You can move the:
>=20
>         q =3D qdisc_priv(sch);
>         sch_tree_lock(sch);
>=20
> lines after the check and then you won't have to unlock on the error path=
.

Thanks! I've fixed in the recent v26.
And the check of both step thresholds is done like below, so no unlock is n=
eeded.

       err =3D nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy,  =
         =20
                              extack);                                     =
       =20
       if (err < 0)
               return err;     =20
       if (tb[TCA_DUALPI2_STEP_THRESH_PKTS] && tb[TCA_DUALPI2_STEP_THRESH_U=
S]) {  =20
               NL_SET_ERR_MSG_MOD(extack, "multiple step thresh attributes"=
);     =20
               return -EINVAL;
       }

       q =3D qdisc_priv(sch);
       sch_tree_lock(sch);

