Return-Path: <linux-kselftest+bounces-48473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3CDD02B55
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 13:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BCEA30C80CE
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F517346A16;
	Thu,  8 Jan 2026 08:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="C9Sy5rUK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010058.outbound.protection.outlook.com [52.101.69.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BAE3314D9;
	Thu,  8 Jan 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862069; cv=fail; b=JEud6okT1eo8B6DPDQKKhpB5vC618IdTvtgL82VrqZjM+3JD7+hHj2MSGVL1i2twHuExjXGlCz17csQqFDNPJmNU3GVdHWFo5EaPLWEBBp11H9bOU6zue2miKdXM9PKXOYNpsHHM6afRipArwj6PttWN8xV/lYLhZ4379adrxTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862069; c=relaxed/simple;
	bh=2DOgcCdDDPZEkWtRps+8FdFmYgrbHoh0lxeIWKWEQ/Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RjAO1hqRHgjFEMBymjNLV+ihc8p6ORKGKVUi33k9AFsgRMOqHCNcQUyamWBOdf3HQ0mDLq3Ggi/0H56IEGdifjEzj8Rf/6FUMRnidH7Spwv1CqbL6yKXjS5Y30u+JmX39t00F2IKq7FFQDEoIKg5tHwfjhRywTQH1LdbyNKs+qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=C9Sy5rUK; arc=fail smtp.client-ip=52.101.69.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YiXZH0K8a1pWmvFRP7vqgACnM2e/SMAyE0Exw1g+rsIntrEqxYh0ajRJJlrgMGTSfEWIljSfQDyRM7QiKAtyKZrrNyVCXEy29Ne65TvGMJ+Ic3omysCTKlL5whBpQ1aXY18dG0fbzYSj3AL1bHjwYqbHsswn8b5HcKGQjERssjqIJO9FzRwMSXPmP3qPSoBW5AUzIdZkoavkGURw9URjZDtmwTtLaLHh2X8gazjqQO8TphJQzb4jGaMxHtXqY/7aOJ9DCNBkTEbaAt9Nh6EcUc15fJJpI4PZce2pKdjn0PhW7wRYEYyQOC/v3vnuatNBvrQ1nK6fk0wZSUw1o3dGyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2DOgcCdDDPZEkWtRps+8FdFmYgrbHoh0lxeIWKWEQ/Y=;
 b=aVV3eDMPJdnCR2dr4xpMF1YAiRY4hkPka7KaRMuTNDKX6VpBVNPO6co+X4UN+Xif2hH2/hQwzVPibrO4bmAiaoI1iH9BUez3gJuRpHtlvk6aloY5ZPkDkevmAE+R6a3HZpaya/q4/pUl6gtGxoovnTMb09dlBPP5U0by7j372A6qicSFsQHm+97tMolvYI43K0exw7k1WUyFbsrVhzMOTLPvAyJuAdjV7OUgSahVMQ6A/HIg2f8ls0dRSjCuJ1eR00UoowXUZsKSudM3nl1sOK8Ihvg3s+lMnSkfoPapiC5cXujmHojgenJg3eABzHHqwCe16yt206vSWMnS6G8Zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2DOgcCdDDPZEkWtRps+8FdFmYgrbHoh0lxeIWKWEQ/Y=;
 b=C9Sy5rUK5IAZgxoLSuq05Kr/muIP+TazUxrjaksnus7MPPZICITBeO3KxDHLG0YMdr0pQA/mgeh/vrbvW6MrQyaElQr0UDNrR6pyGECu9ASxnOqb8ou7bWSrIMuQUclJpaszK/YgsQqfXW/vyo5o5LB1IAhA8l6HkTpY5ZuQCAuW3+yzTS8P77Xb01aRqBu/EYFcqdSSmnSVqdG29zFNRjgZ1cdaBmzBySfvjqVEHKXLrGO6LT4az8Cy03kpmxfPA6Qv7TK8JRjWdEP9CJtTs5bLPDmClzrSu7lvv0xGorBMNImtkJqtfUciMvUaFhGuHlFqJT+w4fCSTTn2cbgPSw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GV2PR07MB8963.eurprd07.prod.outlook.com (2603:10a6:150:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 08:47:34 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 08:47:34 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "parav@nvidia.com" <parav@nvidia.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@google.com" <kuniyu@google.com>,
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
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Topic: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Index: AQHcfLJYfp0P5qIzmUSdgLUUXjW7nLVH+8+AgAABAQA=
Date: Thu, 8 Jan 2026 08:47:34 +0000
Message-ID:
 <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
In-Reply-To: <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GV2PR07MB8963:EE_
x-ms-office365-filtering-correlation-id: 8efb8b75-2ba7-4141-b074-08de4e92914a
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KWoZHGr5+2NrpejZ4mA3rlVmS0D8xUEM36T0GRVD+KfMr+bujFr/tRb1AKsm?=
 =?us-ascii?Q?4A+oWyXDStbEXbrimzknO2IrDQKAtWerQcv9zbbxz377r1oNf/e1emou1Uwe?=
 =?us-ascii?Q?aYSLtpK5sDRGRATaVNJaZy5lKey1NmlbqOUSRN6OYeh4NoDLGKix4TXjnKAt?=
 =?us-ascii?Q?4fyisAuQ24EbdoD5++/OeamT9gKMUu0AJZ8348xwA3e2ax/k9TGSRq/URwmR?=
 =?us-ascii?Q?pjubwtq8n80GQYNh/is9vSYijMUPhzpSfQbidwqYkJzStLUwVRvN2byv2ViX?=
 =?us-ascii?Q?fej4tjPa+CJjYH3aa4ZhsZGuxiYZ+eZ2kc2Z1EzWrKV7K9AOwDdxP1BL9lkm?=
 =?us-ascii?Q?IvqQ9S/JO6RAaw7MjmedH7xv8pVFCX8+AV2gxWJxeC2aaa/buigJv7pVY46P?=
 =?us-ascii?Q?VJricCe+oIs36Fa7RFWiKJD+usF/b11BVkyr8xCZhICL0m7Vh2lu1es3733a?=
 =?us-ascii?Q?07Gp+zJfeY89KZ2f4v4gP16DFGB//20HaNUDWE329iqkUmcSdHjjF7qV+HOu?=
 =?us-ascii?Q?lC+qWooIIs3QXUmqdYISPNdHz2gwvrinnq6ZEPdAuznHikZnbi8TwbhetRu1?=
 =?us-ascii?Q?8c0iS7M4CDIqbqVV6Ea1aajKNyHV537OSRT6P7Z1sa7ZarW+ThuSr1KmcJ2v?=
 =?us-ascii?Q?yULTewFNZKD4moKkHUaChmJZSA2OseYDbIJx0pVqegm5wM2fkszXoPq18KaR?=
 =?us-ascii?Q?EFN6M+6Z+IA1IzTVli7fgG+ax9xJk6aDjCIfCH6JYxd/iOijdDOfM68AYgo0?=
 =?us-ascii?Q?yDSA18eek5TZVtGsapGwyJuHr2902x4o+lhvMARi6LdS9tbevhukWDDuEttH?=
 =?us-ascii?Q?bSPcyJ9z/x01yWnGb9oQuHxkcgREQZDr/n5Rf4gY1FcpGGU86xpCwOn0p23D?=
 =?us-ascii?Q?Lzkz2TuNj7ue6YoFIcf2Pua+s1YBqExFo9pdKgEcf7sAKcQrOpAZyfJGJzAE?=
 =?us-ascii?Q?dDFB34cDoNGK5sGfm9+7pU5NB1vY/RGptjE7kj+pm12DB1sIEzdo3xTFdd7i?=
 =?us-ascii?Q?i4wuwvzGhQI6wAysS0p950pNENwmAXdbkFgXiazgvWDozKqZoXssDKW9NjzI?=
 =?us-ascii?Q?jQiDrw2d2Johg3d3n/J+mRJji5yJmLlgVOC1tdwsKMHEZVB0DivcyNORaK1h?=
 =?us-ascii?Q?G1GPOReHTcCGf3i7cospcCsGAT8p2cCGlragdUHocZlx8SYDb7VpEtaMvK+T?=
 =?us-ascii?Q?GPmDWtDYP8P7ABPCOgB9G9KSMUvrraiXQ+QqA95jCqwJfwjLUlKl6OBygOC3?=
 =?us-ascii?Q?XTKmMBHRYXBxmGxsz3SMvxKACVgSL/Pvv9dr23QluGEpxT16q0tWs/lNwsF0?=
 =?us-ascii?Q?7dghnUyWBIgDaxD2L1QhjjL7LbWLkHj21TL/QRmmrN01QLsiOhPBalr4xFhb?=
 =?us-ascii?Q?Z4dbRJBcK4GeKcVieeQf1IWWBQyLoO/HKoTAuk8O54ZSvxQgIZKix1pYW8r7?=
 =?us-ascii?Q?LKTWuy6GIEe9zoEBXWcBgyAO0TiOOBXArBGaz7SsR3kViGbm7OJYoPatCRQ+?=
 =?us-ascii?Q?IwSxMSNSAtQpnyjO/AHm4b/XGI2d3X/B+LEYt4sDz8eM4rrY4VF+DLY3wA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gWrsZUY/2fDZsLeq2AdCRCM7+LTgxijQ1G77moPTPICkaEq7bHqTwQTMObvu?=
 =?us-ascii?Q?tmEsQrPkFqTfPiRjwheuZhZsm5FhrlcwNhlx9JdQPedX/LwSSu+w8Ctf8fJv?=
 =?us-ascii?Q?ZqFpPY0FUgFsAUCTFdIoiLjPaikfP15J2XrU9uHhCl8AY7kuafI30rzz7pTe?=
 =?us-ascii?Q?RcANhzpYutdSmMUMjh9m+TgcKh5Ye6IpW7G6m3s9Hjti0UbjtInXPKsME54a?=
 =?us-ascii?Q?YWI3lA/mK3vRgk6bUgNVlP9nd2L0OCr2oGSm0xuFp7XTxLTFCOk8LF/73iB6?=
 =?us-ascii?Q?FyxxyqlypafumdLR4wepkp2nuWj7esYQAGoPWpV6rId0oSBZUW8oNaBbZOaK?=
 =?us-ascii?Q?cvTQMa3TQWY4zMjfZvi+jm9UsEByNejr3uZdVdvCib121cmOeUO2QaXS023F?=
 =?us-ascii?Q?MvxfPGeSgEVkNLwvfntXty/ZOlqonHblCOi3MLvIj/I0tbBjU3JhogRKMl9k?=
 =?us-ascii?Q?jrF0kXBxA7Ju1tHRFeNXxADjiaLdcadyTHhMU4mAmt6HXuCcbDtO3YoZQnyp?=
 =?us-ascii?Q?omc3YzQ/6rOFIEdsyHMnf/zzH/Z05htOI5HWf+Mi9eiznoINt6McFnt6yDDO?=
 =?us-ascii?Q?p05EwVWRZ3oxog/BLuExR5b3VvSrJkMme7GIOWMfg6aXtX3wkuY7o09oaUJq?=
 =?us-ascii?Q?7uN6z7QaZhhHgKFSKIlEsuHFER0S9Y2NXvHtirBGae6zBWLimqRQyBBuc/7B?=
 =?us-ascii?Q?JgxMEgburq3bOR5hnpegCxUmxnFmZQUWXWPrvGk2kt/cmcEpPMvSPKcH2NsW?=
 =?us-ascii?Q?2zGQnAK2GZb96du4AU/6Iz/ZWd4iN1gx2//hR30PnzDoMev8Y+sEcGeSBOPh?=
 =?us-ascii?Q?2jVJ8F6dGKMR6wQMtlHZWyfZt+gxbpzzlNfZnuc5ACDOfS1FKoefXQr27LfF?=
 =?us-ascii?Q?5HOxUS7+UYnq5oUnUhYYQEkNq7QmlZJxkxHbB2FqP/hQMu6Lv3TvVRNQ8C9S?=
 =?us-ascii?Q?FhjR/zQAOwDLgtOnoPdjANLDDll/lGLgBpaHuRMy5WbtvYD8q+JDrXsY4oZ2?=
 =?us-ascii?Q?mjJAkOIWRW5jUtVfjtjakzkkj1Lo0jlJ/p69vaFJEr4ivEDzd+5DuGKWizXb?=
 =?us-ascii?Q?a8Fszsqvxxbjb4hz4rliTgTyRHBpw8shSsckyzFYwZYSid6tddzDtH9acHvU?=
 =?us-ascii?Q?tQ8GR5hHKJpNeMTz+JjvhqZCulyqFGR+z7hVCLNVSp3PgwHlIbnuLRdwzm0x?=
 =?us-ascii?Q?PWcYegYvMkLbUx6yEqnR8sIXRkCJjLeaLGTjxsiGRAzAxRcdPWoX1EaRZUE3?=
 =?us-ascii?Q?DXppt622an13cn9igMe/aLR1obyNS2cAXFiYWkXpyzBFEdPLMh7LZ1moSzfP?=
 =?us-ascii?Q?G67Cq/HLYLJZ9rcKcnHOtgbsgtzr8xRkI55TG12eyo232jhroJh4Y98W1AyD?=
 =?us-ascii?Q?xX/5zQ9bwCY9dfFfLgdlYKtmNxj5S6rwbY/ORgkyIFniSG35O7IKsEW3gXnA?=
 =?us-ascii?Q?xDAqosg9lrsdLoWQMLSEzCnkGFUe/CH0ttfjmRByz3urBDCcM9JwW//FQJcN?=
 =?us-ascii?Q?qbZPmsMn0PE4pxSpWMuMGF7k7QkJMxNeswdo9FxSwwhx1C5rDyEqpMTZGDHc?=
 =?us-ascii?Q?mOLrw3vEgV0HUHDczMQdps9ElCjj80cxudIMlqy0alujP18Q3b4obv7p0siU?=
 =?us-ascii?Q?tG8PZ3Erc8DhAIr8nAdl8Ej1EIiNDVwVrmnR+OzGwZONEBL//aCfXw110AKW?=
 =?us-ascii?Q?8CUvIZD824CgV9QCr7F2O1IaGgmbmJF+UExVhY2BqfjThNQWxkJHUhg78del?=
 =?us-ascii?Q?I4ek5f3DrohdiNLLaY1eq4yi0ATKuh8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efb8b75-2ba7-4141-b074-08de4e92914a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 08:47:34.2736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yCgm/v+w4c/2G1A0YB5EcSCnU8t4YJxh19W9YT+r+3per+ClzTFfSC+Eya8/SOtyceDdCVGK11Cs+vwVmLuq5wYwLeznr9b6W46r7FaU/Sqxk2/dt2fEJuEOKg1lFej6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR07MB8963

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Thursday, January 8, 2026 9:42 AM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; edumazet@g=
oogle.com; parav@nvidia.com; linux-doc@vger.kernel.org; corbet@lwn.net; hor=
ms@kernel.org; dsahern@kernel.org; kuniyu@google.com; bpf@vger.kernel.org; =
netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.=
org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us=
; davem@davemloft.net; andrew+netdev@lunn.ch; donald.hunter@gmail.com; ast@=
fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-kselftest@vger.k=
ernel.org; ij@kernel.org; ncardwell@google.com; Koen De Schepper (Nokia) <k=
oen.de_schepper@nokia-bell-labs.com>; g.white@cablelabs.com; ingemar.s.joha=
nsson@ericsson.com; mirja.kuehlewind@ericsson.com; cheshire <cheshire@apple=
.com>; rs.ietf@gmx.at; Jason_Livingood@comcast.com; Vidhi Goel <vidhi_goel@=
apple.com>
> Subject: Re: [PATCH v7 net-next 00/13] AccECN protocol case handling seri=
es
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 1/3/26 2:10 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Plesae find the v7 AccECN case handling patch series, which covers=20
> > several excpetional case handling of Accurate ECN spec (RFC9768), adds=
=20
> > new identifiers to be used by CC modules, adds ecn_delta into=20
> > rate_sample, and keeps the ACE counter for computation, etc.
> >
> > This patch series is part of the full AccECN patch series, which is=20
> > available at
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2FL4STeam%2Flinux-net-next%2Fcommits%2Fupstream_l4steam%2F&data
> > =3D05%7C02%7Cchia-yu.chang%40nokia-bell-labs.com%7C4954fd4327e54369383b=
0
> > 8de4e91c0e7%7C5d4717519675428d917b70f44f9630b0%7C0%7C0%7C6390345850669
> > 63900%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> > MCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdat
> > a=3Dx1PbPUTrvjl2KIoU%2F53WgSDw4desZzP0TJL3tIm5QuI%3D&reserved=3D0
> >
> > Best regards,
> > Chia-Yu
>=20
> I had just a minor comment on patch 11/13. I think this deserves explicit=
 ack from Eric, Neal or Kuniyuki; please wait a little longer for them befo=
re resend.
>=20
> Side note: it would be great to pair the AccECN behaviours with some pktd=
rill tests, do you have plan for it?
>=20
> Thanks,
>=20
> Paolo

Hi Paolo,

Thanks for the feedback.

Regarding the packetdrill cases for AccECN, shall I can include in this pat=
ch series (v8) or is it suggested to submit them in a standalone series?

Chia-Yu

