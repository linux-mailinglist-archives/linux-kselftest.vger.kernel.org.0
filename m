Return-Path: <linux-kselftest+bounces-38027-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4022B13644
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 10:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E55179505
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B847236A9C;
	Mon, 28 Jul 2025 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="gp72qQo3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A11231858;
	Mon, 28 Jul 2025 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690893; cv=fail; b=uxq/Ir9k5dM4SG/D31SgSEGzUTJseO4YBWa2cX5YTNjMq8OvvhIaDMPkvq3aZ1xx7h0UNx6Q4KWEhP1y/zDu10yT7grddyiVJu6lu4+7q4/AVaeZvZrkvNjBxxtQdlolgPCXJYOVcpybqO7WAkW3UddyV0huyLienNQT05Wv8vE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690893; c=relaxed/simple;
	bh=39sbgf+SXcHpXnHPuINj18OH5LmhvFUgpjMoPYgKgZ4=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cLxdv5fR9ItLICvUsEDqcMz//YYJzoJdQ6Xtwr3ikThLiSGRvUnm63/jYE+p4jA3A4SsZjuN3XzQLaoW/ALOGVgyFjD9weavTOLwbHqe2HKgW6EWqaFvcmdMtQKpBOGE75GJ42s3vVYgl1S3qQ6bnBvAF3k/gC18RCxCs1rUuOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=gp72qQo3; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmLxqYK6O/JyBCERrV2YDMrJn5aWxIX+oEbnW0YfcyFcim3g+knG3VpmbgEYR/ueHMINp8Z5fY/aXEgzsZ9AV1HCdHm6jy3xfqRKgssKUZscru7bhwLttsTZjR2S0qiD9Lf+m3Gmm8CMNV+JAKv3IAdPuYAeVe3N0uHGKCNO9U/mKvR0ZVJg1BioXD+BomSfvIJZxzfBLmMMFDB0rqNGY2x6awEhKwAlPGzG+dkbmtj5BlRQkdtjCkixEy/oA7WrL4PbcULom9orfAE6YquKtDggIvLkNgvYXaZI7vpRuYEgqz1wgNW5YBpqXTF9c2II9NeIhcMlOTq3WFe9mjdJRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=39sbgf+SXcHpXnHPuINj18OH5LmhvFUgpjMoPYgKgZ4=;
 b=lqWOYyqMQyMjsnES2TU2AZ7capgDyWO6wCy70uLzcDjJrU1Nw3S1mFWhn9xFVm1mTIK88HsmtX6GDNfdShpsUsfzKYN6nVL1Dq/vMTlsMiQ4XbJdqGNSb3ofsxZvzjlEmXcv3fZ6TamLDsuJaZfQYAoROwUJcS4dJOyrN4Hdj5sH4xdjZmYkxDEp8codU86tu9/EtWyX7i6v3tJTIKSNm2cMtXckGuHrQvFcv4j5RUNqtkSqSUQfnkGAHQor/YY9srwAZroxDuB9vtvFtXI5Sn6Q7JbSOdP828N2dTkvJMWopyVah24e2jN9Oz+Fuij6Sks3vo8XcovMZqXXSv836Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39sbgf+SXcHpXnHPuINj18OH5LmhvFUgpjMoPYgKgZ4=;
 b=gp72qQo3Z8EW20U9JmcDMumaa4tM1dKll7P6Qd3yqDJfBug4JQTuSRScDpoVuXjj1a8HWMdPVl40s42dFW0kKV2VrgQtypU9j1SS/Tj/KPH71TDga0RX2vUNB3hmvitnH8peKjJAW6yPk7KMstc5mD74+uyAlWL8DwEseQMkzg6r1Ql13PTzElabjvIEupYcJwQ/+1BcJP7g8ezxWXyLhH+R5PY2r1ETj2qn7JVoekgXFbgLQ8LN4srKCfC8UOB2U3GGiE8WeUApYOelDTwE3z9yLbvybUCWtjQveJHJ8c1gMLlvEPmgtu/U0JqGR+/OYCMQbQKN69e/hIpaJZZs8w==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB9601.eurprd07.prod.outlook.com (2603:10a6:102:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 08:21:27 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 08:21:27 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>,
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org"
	<shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v14 net-next 00/14] AccECN protocol patch series
Thread-Topic: [PATCH v14 net-next 00/14] AccECN protocol patch series
Thread-Index: AQHb+u9Wsvbmfakbnk6OyT7s46V2OLRBQusAgAX3ioA=
Date: Mon, 28 Jul 2025 08:21:27 +0000
Message-ID:
 <PAXPR07MB798417C584E5949EB903B8E0A35AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250722095931.24510-1-chia-yu.chang@nokia-bell-labs.com>
 <e79b4382-9421-498d-8b8c-6157ff070a34@redhat.com>
In-Reply-To: <e79b4382-9421-498d-8b8c-6157ff070a34@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB9601:EE_
x-ms-office365-filtering-correlation-id: 454a58ba-ea40-46cc-cb9b-08ddcdafbf95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OOq2TRMwA4CfN1u3Tx8MAPn6It781Uxv+Fq31nNAa1wskO/fHLHDV4Tk42Zq?=
 =?us-ascii?Q?sKXWPoNkoqhH172Js6MMESFop7vA8NrZFBfJSsAu7Zt/ijyjO7lVldAi/+Sa?=
 =?us-ascii?Q?bq3w87WKv9RE9whzYzTu3sKNtURv9hIBlVqFweLXpyIEXalanj2P0NUNAMpn?=
 =?us-ascii?Q?wuexoQO9Zy010PGN2s0TDefLGN6D94pRoYBkvAtEgDPwVBNQEKW7SzGQ1o62?=
 =?us-ascii?Q?ix4aFiGVfVfo4HmwqgQuVy5RO+ypzFJpYznWCGfzgsl6xqF27CGePzXnb/Bs?=
 =?us-ascii?Q?4uh0Q1+ZEl0wutPjbBITJ99wWzgywV3DTdNb+vdzl9WNy7hljy0eZyn7sfWz?=
 =?us-ascii?Q?m67HsoLtzoUjZbrQG6Jghl2YLS37knVlvJKYA3wU5z+RdnJfwviGFdhna280?=
 =?us-ascii?Q?IMjQ+j8dZItPcDtZXCZ5FxDaWvDGBECeGHFHL5hh8Y7ldvnBA0woqWyWvzAq?=
 =?us-ascii?Q?rth5L2w1FC0FJMOhV49CHDm2Rhhap13x52IYWqIXv+YQF3b2zcPXbl4wPFb1?=
 =?us-ascii?Q?eUVu1XB6ZF2LVTX16g7MQ3KO720tt6wqF5Aik5IfmTEy+s6sgBml0ELKpmC6?=
 =?us-ascii?Q?X9Uqdhjto5u++1LHnQL02Q5pAXQYbZW2DQ6o0pgrs83rZIVAW1d9VRmigyct?=
 =?us-ascii?Q?mFT8n02BOQp4PXLNPuXH20NAtMcT71RKkkuVnSiItNWIBFukpRay6N3k/m12?=
 =?us-ascii?Q?nvYzzxnpznEC4vpxMXOEAukiuDx/nhcWyEsQCz1AhnjOZXN/yxU42yb+QnKU?=
 =?us-ascii?Q?5bZLSNiIXEjnnUuQl92nwlOEMUwwdhOJWTsKy/NLphjFm0J9IJOb21jRethe?=
 =?us-ascii?Q?27rNZV8YD5yP0ETmJpUF7v0i6cTGhbQVukOSg7mOUM+N8jSfvGmv9uyAeBYq?=
 =?us-ascii?Q?aG+ie/rmRg8q/fSu312jaic6SX1dXfuJpg5uNmQBnHc/aEU5olOdjLs1Pdbk?=
 =?us-ascii?Q?+luJJl9M8wBpngBFZxmlerynfxIOTwkFX9mGNPGOvkPZ6389brGVIKicGvx2?=
 =?us-ascii?Q?zCDxyAfMByASnyNs84PI5FOlrKxj8vPvRv6onRv3EycRruPegbTkPbUAXy3P?=
 =?us-ascii?Q?d8esL1kHOS58ttcQr2FPRbxBERls6B78PrGompZOz2rDX2LQvdw4jAePRrlE?=
 =?us-ascii?Q?2hC/MmkznEaUfUoN1HnKPBL05TI81v2S9fTl3QTlqTl7vp0krEhpxYGhqQmG?=
 =?us-ascii?Q?rC6uKd/e+ajmjGXFCFu/Dx1NQ5unRAMolREICvUrSlaZacD0c+rNf3lt+Csw?=
 =?us-ascii?Q?JmIfMszm9TteV1YEemzMA9nfs6mM2uDAot0ZYal7BYCgG8gr355JDQ3Y5knU?=
 =?us-ascii?Q?kE7OPnyQXsHOR7jrj+V6fIhhfgUhelp8Cfcrj0pZe2JbQBrJa3jTVBp0WXZy?=
 =?us-ascii?Q?W5odPj8LN69OMY1IviOz383Yzn6AUVNttHJkMfSiDABavOqwoPgKD6CcPlv2?=
 =?us-ascii?Q?mlW6EIGtwEURPGzTT4GXy7xfsmZ9Q33m5WewqfIAnZZewya+NcVwxOjG/Sv7?=
 =?us-ascii?Q?BAc5aUxJ6S/Z3GtA9Jlgb6dVrddZNXzqKT3L?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WTnBcm3fhV6ejKuSAl5ZkplOnKj10mPsrkhkrTLjbjj+5c8rVOxLwmLRvN8o?=
 =?us-ascii?Q?0/J78p0EVneNtr/onwNO4WQqCnub1rbrQ3tu9CliNAf/KvriEcY/Gap9Zyco?=
 =?us-ascii?Q?QTkYNx6tdGnaFRdf2HFs6Bk8XtykaM3t9SU1xBRGvIsE1mCeOKX0XnLnvCd0?=
 =?us-ascii?Q?BFscvsVjywvxssHMFelP1/6JvMFpxXVpG/+m0v9VDbXgHn798fxkK2viPJtv?=
 =?us-ascii?Q?PYPeHG1Jwzyz8ho2ZBnzKrbqu8cSYOJMFpEVISOH+7xTM4ckF5gPoYdDiLnE?=
 =?us-ascii?Q?j/1dlvT/nmC7ui+mw3kJoaCRpyQAxGb0RWxQcP/lQaGsUkCIckeGMD8yLWK/?=
 =?us-ascii?Q?UGwdRRSTAB+2F0zrISVKPeuL1095PSyKcU+7LfTQLvzUvDcCMjBuUVYRAy4V?=
 =?us-ascii?Q?PSwRUfc7XpELYQqeYtXB3ic/rF2/t7O6nesB0fSd6cCHHd7jGqfCLlL9bKpV?=
 =?us-ascii?Q?9VEyAK2FgdEGNXJSh87yJpIjBzSofjON1piovW6640XgzMHc5lSBSljYjoM4?=
 =?us-ascii?Q?LSwy8twV3eo+bg4xz8cOLPV1cYZMqKxKRSn5z+w3/EL8VN//Dy6mim7ZwJwu?=
 =?us-ascii?Q?1I9VHFTUSKMvRX5ih1WxiDdoLyPN6+UI33lS8OqNma74L/Tbk4tBzW+TFae1?=
 =?us-ascii?Q?13LWjg91OkGGjoTykVUBvge4gsFxOfp2Pe1mUt4e/nbe62x1bgP0UCzysFNc?=
 =?us-ascii?Q?JESTWj6XL4kCj44WQHT/DkyYTwE1Qlev20Mb2SAZh13QKvvDkDcb/n+pjwvo?=
 =?us-ascii?Q?oWmZIPbRoUVqnrQYyltYmAsji1N39ZkJUIFFgyf2CyYK14Pf1tyAEb46JUbI?=
 =?us-ascii?Q?KHYm/GLqEsmW+HnsL4v8CDl2YI/eF/hCQvP4KxefzlYsZR6pvOOzlc9ODVhh?=
 =?us-ascii?Q?sNmPgwmGfvsXub+1yF1lpMML6nALJue8ld27dZ/hJpzOt2BSGrbkRytoDfUU?=
 =?us-ascii?Q?uIBTwMZAeVkHQ5fxapar2Zotzp7m6uw/ok6DETjIwU3DAJvrPXJvCmvQr7aM?=
 =?us-ascii?Q?dDGCmqA5lLrr3lec4E66A3cmvZr9HRFrpzgPLqY4Mo6aFq98lUIseUjD1H45?=
 =?us-ascii?Q?1vgxFbVDMO4M5tx8Vd1BseHB0UtvGooQcsID/JxVsUfqSAPxDCxmoSt+qkiq?=
 =?us-ascii?Q?jJG9TACXmYr89H8Ns0lT4PFdnnXhcj6dDLglAlrslKfAOCc+kroUtV/KxkIE?=
 =?us-ascii?Q?/PUTyMvYU0+blcxc8SUIGlAXS49WCtxs3kNeNu8JfQCpQGOrIwH0po6Ck6wm?=
 =?us-ascii?Q?ME6ASEodr5llnWU7HHMbaFjLHKDRge1ayE9N/LFzYVQKVdTOuFYEMt3clCTd?=
 =?us-ascii?Q?aiMQMO7zntl8QbMGjKLXs9jRgtSjYj97Zr4f2K99jpNtuwZg6u349wptFZCG?=
 =?us-ascii?Q?jH5m2OuBwqJjdoSAlgIFatYIhm+ICI07wc8Fm4FKGKThnHCMFjubo+c6UTUz?=
 =?us-ascii?Q?I8RstHUmSmTclmuqI/pe/DNBNDwAtIAGbdlcF4QKAIk2AVvcx1GzATFoz4ns?=
 =?us-ascii?Q?rFOLM47d/iV1qNC9b1HFdc/usYOOjnINCyBzsh8htzzvxX75Vl1rF9PIBVFs?=
 =?us-ascii?Q?KXdqm03oJX7TYZgWWw78ckGx6nP/sBUSzbu8qIfA4jw4zIyXqTTwd6d1B229?=
 =?us-ascii?Q?ImT+cXl4Rb4Wbdec49zw9C8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 454a58ba-ea40-46cc-cb9b-08ddcdafbf95
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 08:21:27.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P2PbMLI00ns+8EokD8rBEDw9so1TFMw2UlEl0+jV+Mn0BmWWMEX+GC04fIr99lX9MKaztwSFRZSR+lrkzrXngNfoEBHao5VgjxkWXmLZsWP66Oz+ljAW1VftJrVPBoga
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB9601

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Thursday, July 24, 2025 3:11 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; linux-doc@vger.kernel.org; corbet@lwn.net; horms@kernel.org; dsa=
hern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netdev@vger.kernel=
.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; stephen@netwo=
rkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.=
net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuha=
ngbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kern=
el.org; ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@no=
kia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com=
; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_=
Livingood@comcast.com; vidhi_goel@apple.com
> Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> Hi,
>=20
> On 7/22/25 11:59 AM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Please find the v14 AccECN protocol patch series, which covers the=20
> > core functionality of Accurate ECN, AccECN negotiation, AccECN TCP=20
> > options, and AccECN failure handling. The Accurate ECN draft can be=20
> > found in
> > https://datatracker.ietf.org/doc/html/draft-ietf-tcpm-accurate-ecn-28
> >
> > This patch series is part of the full AccECN patch series, which is=20
> > available at
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FL4STeam%2Flinux-net-next%2Fcommits%2Fupstream_l4steam%2F&data
> > =3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7Cdea2afda16db47bac335=
0
> > 8ddcab38c99%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C6388895946950
> > 64349%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> > a=3D31iNaKPYVFldNPeSytOPmepH4K4TebzVzevkuiPwV70%3D&reserved=3D0
>=20
> I don't have any additional comments, but let's wait for Eric's review.
>=20
> Also we are very far in the development cycle, likely this will have to b=
e postponed to the next cycle.
>=20
> Thanks,
>=20
> Paolo

Hi,

Thanks for the feedback, and I see this patch series is now marked as "defe=
rred".

May I ask what shall I do (or just wait for the announcement of the next cy=
cle) to proceed?

Best Regards,
Chia-Yu

