Return-Path: <linux-kselftest+bounces-49031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F01D24852
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 13:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B24A3049F3C
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 12:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BCC399035;
	Thu, 15 Jan 2026 12:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BeLgMqHK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5931B36B07F;
	Thu, 15 Jan 2026 12:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480389; cv=fail; b=HRpwofWyfQtRXSGPnyUn4+Lg+Y4keQIzCmvBxvuJ1g66cyJ/WFZ83uzxQ7gY9heNmHa+xy6iwdFIl3D8e6Rbh/GL3usRU7VXd4YR9+CKcrVPWWBN5yDc7Nge1uwUwZ0sR9lJqxVMEoP5cmvqRWJzwCWWUkeV5xhf3ec0yS2lmcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480389; c=relaxed/simple;
	bh=8NcgwPK858lXROEZAS0o7zMnbFv3T+sxLAYyExoAX9U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nv8lvUihYcPcHkh6w61SfGvcxg6M9qmD6Lrj+D9ar/qpog5EeOSygm+0mv4IppZjB8vL25NKIkt1G1t6UMpE0kXjFT14JNojQj/kaAjqflbHPSPsBXmkie+bkD9/IQqxZzFhFtXkvQBykADDs/9rufz7YY2m7mIi/ABznqFreB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BeLgMqHK; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LejXdz1T3ssFwZSlzu7ZSj97lfl9Om2soVTioLDQR0z/QcUNJL/u2372f1E6adZI0e5QG7vYNTsFhbsIn0n+4kn4FbuYBFqjryA3m8p8ui2vmfThuC05mWETFzL6IjVV1XUQeokBfP/8v9nwPex8hnCfBWK/7DpGOQj7lyoXDt+XPIM4LumbvjraFoVivrtsaVlgJeiYNUdghPpLmRCojiz6q/T3zASTRabH2yDgeB4ZwG6JvdjvW+1hjBzCLKjPquvglZeKlvEJUgO24+bgqHC1jzLEe4ErbSfE/0e121sVPZyEIkNjVhJcJSqRaDAx/VnyVZKAyG5JawSgGX67nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NcgwPK858lXROEZAS0o7zMnbFv3T+sxLAYyExoAX9U=;
 b=Cahm1/+ECSgXcs0OQQ/U925lI0Q5woF+0Xuc1EZx5P78U3V+OZONLcwHFXgRvu7tW/kYyUJR6rlp0lYV3/ZnByDbUgevy4Iw+aAfFZaNulvMwfJraLKgT3iIrK0YnPDT+6iQVOuQaOkzQRKihvKo59OGd8sD/+k1v0DIVvr1rx9lUufivclmhbdoM5xqv5I+hWQLXHO93ZBHA36N9aBsT/xi7mYY4BWZsQs0U36xxdsWQ7V/NLP6e8At2eHrDKgkYqtFd8S8X6v4aIFGQnFoItvBzY67ABELm23aRo+8C1BIPcnwVnYcOIlPPjw9uNC/j3wBuCfQZS/InJIrt/5XNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NcgwPK858lXROEZAS0o7zMnbFv3T+sxLAYyExoAX9U=;
 b=BeLgMqHKEyHopLFy9/A2FH7mLF1NNXoysTjqQSENyau+xEUckTcp79bxxjfKkEVw6Buf2X1KRJ2a7CpWdkk5UMlcJKI7/TY2H2PjsyjVOjdYBICO3m0bK34Wm4sSv+5LUPQXX86FBdMvrGHvhhzrYliP5QL8XBxLdqUM2OfFb4fkSrkkw8IPGN1y2P8YI4s6lmhmwLGvhAPpGwe8m0dO1vYB2n9U3MR3DyW0zDDDfYYXQbKEq1Aako9SH/aA3xaVl4VwclHkjjvxjHui8e3XKUe7KMOkSGyJL6h5iKaCgxbQdoGl+kuNFboDqSWRwkq1Yo/97KbDkk8L9zXmrSaKWw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB10068.eurprd07.prod.outlook.com (2603:10a6:800:1d0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 12:33:02 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 12:33:02 +0000
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
Subject: RE: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Thread-Topic: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
Thread-Index: AQHchXLvLZ9jpF/GoE2EiLZqr4hX4LVSS/cAgAAA3dCAAFJWgIAAi5+g
Date: Thu, 15 Jan 2026 12:33:02 +0000
Message-ID:
 <PAXPR07MB7984DAC49A65444E61206A90A38CA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260114162915.94820-1-chia-yu.chang@nokia-bell-labs.com>
	<20260114151346.734001ac@kernel.org>
	<PAXPR07MB7984E23DB685074239202CA8A38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260114201133.710abe3c@kernel.org>
In-Reply-To: <20260114201133.710abe3c@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB10068:EE_
x-ms-office365-filtering-correlation-id: 055ce134-f5d0-4ab1-c15c-08de543239b5
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?D1knh5tBnC5DHb4cnljWrPqPhbKep7qpE7szH7aLJt5WSQ4e48py+cXirijs?=
 =?us-ascii?Q?oo7SkOHYXgr2zx8HJIt5ylh/uCJ8gkd/pz9VrGTMzJHGBIloWLNBkgcCOanw?=
 =?us-ascii?Q?E0r+oeqzpPg1YcpEwPOe42U/DuBO2afHksZ6eS13enBP+jH+dQ966eSWf4qA?=
 =?us-ascii?Q?pYNVTtmXUsel6//oo/Avvz23+m1iDmgGZhLVyqcYErWrOOuy9wJcU+0iU7ee?=
 =?us-ascii?Q?IUNiwkxIDGiSywgRjOfH+SwoASwVLCf95I7W6hNWZz5fSaACOASjE13/awnP?=
 =?us-ascii?Q?1l1vzca4ipopSL7eGsQZbfmqTxfZZ4otRRxMjI7XES4sgLCk5eN+eHM6koNn?=
 =?us-ascii?Q?SvDEDHTHQvoAXNMVBbjaGKAwfwtfRfLMoL6veXT+y10R5kvCpOHzAijkNive?=
 =?us-ascii?Q?f/aDZMDxA5a8i5toe1oQAnik+XQPY4TQk59jq1Rg/UkVT0gkgGmgFNFOsV+w?=
 =?us-ascii?Q?oX9X6IrtPF0LCPPFlWxeypA7rFg1NBxMG00HsAzkb55gMW6bP7mwzGGCKcoR?=
 =?us-ascii?Q?jkItBMyQJI88Gm+Mi2hvXUDnmXI+vbuzVloOABNX9Gfhp/PcNY0iVFGFV4ZK?=
 =?us-ascii?Q?hSjgUv0MHs1PShu4EOAYu08K/VkDiRw1R5PT3cV9/iZ0AKDo+UdrMixeG8dy?=
 =?us-ascii?Q?Cd1b23WCk4SwTN9HQPeHm+ali/0ubnHQFyVh4khXzQWBD+KYgnGCae6/bAbe?=
 =?us-ascii?Q?xf4WO57AXUL4IEL+jStmXU50EE2hl+HYkkZfR9+GHgi/AvoT28cLYBvq13jW?=
 =?us-ascii?Q?kiDb/vRwiXENEwQANZ2uljNsEt7HIalj9uJRT0eZjC0JZAEEMNat+6LtriDm?=
 =?us-ascii?Q?q9eW9ZCijBxnuh4jtl2tzM2dIbgriuwPAYh88Biz5nYFbd2AsGZsYLYqpHmX?=
 =?us-ascii?Q?Iaulv8jBzHyyDJzusUDEB2bKwILusxtsBc6zqjaG+JVF1MlVF4FBuKQ5EMbF?=
 =?us-ascii?Q?MfzzP2eAG0Rm4vJ1PUl33e1VWTR+OwvgYLXwVCfT9vRXtJegkqsZNBMpjZab?=
 =?us-ascii?Q?NqMrDLB1gFYftXQdPzsdNPqqhsAImJmR7KGESE2cAsdrlj8hLxOph6BRAhm+?=
 =?us-ascii?Q?AgiLpzZ27QcRuzxAE8hkrMhFRQiRTkAn2XHQVxbCd4yZMTFBuxBTGFsdN4tX?=
 =?us-ascii?Q?qAd+GajaEUKGydWcSgwo8X4FTlIY+ZPm1AYjHymIZyXX22VNyF3y0hEMcsxO?=
 =?us-ascii?Q?+DVl57xXihP9dxN2c9QoPMYFGUKj5W6B3GzuOOOB4CvqPPccvCql/FiL1OMv?=
 =?us-ascii?Q?mp2iIOy4viBaP+k8CYcucLGtDQmyyoob+oAx8z3ltYxT6VN5rZe4QpfthRiu?=
 =?us-ascii?Q?3/qkArlk5imIPI8KMWi4KjdNZPryPqq/IXMmaQQxoiIRbXBCcaks+9UovMAy?=
 =?us-ascii?Q?M0My5N4nlDxtTGxFlparHA+wlrjfwRQebCYwoFrQNGNo0azdGmMRSyt+HIoW?=
 =?us-ascii?Q?N6OEqsogDEmzTF/K+Ezf+ItvKR9hjK+quKagPSVyJ62CnyRybtkqZ4FkrntR?=
 =?us-ascii?Q?bH/PawmyQUEBUayeKlGCS3vmNUtw76uxTzXttlKCgveMpM8OYYqxHEgAMyRe?=
 =?us-ascii?Q?+1i/ctj51B+39IndIHYGaQoPEaFeSkphxtm2ioLkMdMfi/YtTmDmADE7DgIM?=
 =?us-ascii?Q?OGX5U8UrVGme3IW5lQTSxQs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?C1A4ztx8wAbT3PpuNdUd4UYkYqdg4EmKjH0oBl8eBLVfRzV0dACoDevSIMrA?=
 =?us-ascii?Q?wFJeRdQzZwb0cnYVt1qr/4Zew8dPV+kjPcse/k5xzjKO2Onpr/fr8C3v0nPX?=
 =?us-ascii?Q?vlfykdH4H4dn2K83fd7orjXCK+j08lPr/9b07eeWIrFNFrrVjLCVKnGt4JaY?=
 =?us-ascii?Q?GPjhL7aHlhfkafZbWt3BIzcWgPhszZ/fNj7zKEgXEyiDJELHvzzdwKGw1AjX?=
 =?us-ascii?Q?uUpNahk1mVPg/SFnqCnD2xhTj+dLwLz4DhfAYv3M7IaOiSr3Ra1RqlFTR6Di?=
 =?us-ascii?Q?LUSA6CO32NKaXQt6L9RDiDEwtLWahsSFMNQzF6TpUzQ9DQ6GeuowL/VMvzpG?=
 =?us-ascii?Q?mnwpf2bQLp+7kggflRktiVNoUTRWVQu06CfChS57/cFJuzueWcTsKAAJL+Qu?=
 =?us-ascii?Q?xx8TGx52RsCvkZ+pCd8T8qR1AkqvG9jJetQJHcOA4yRHzNSCLwYfqhwwvU6J?=
 =?us-ascii?Q?d0/VZM33Ml0qtQS+8+yA4cHlOUDHey3jfjbb+zeQaVEbR1X30WlnpWArEc13?=
 =?us-ascii?Q?3jyyqowQrp5cyH6OimuWMVYKLIlfhFA1KYsKfjx76ePN4c7wEglc4nUO0Hg0?=
 =?us-ascii?Q?L48J5T/sN0/mvq3AWepfKbUuwwyRG/7iYnx0eNVT2hR3H0LFDq1rhrRKvObn?=
 =?us-ascii?Q?CNa8QCq5LmzoXUf4/pDJ0OYuWHWkZw5yNPmEVE0D+MDU4biU1zJf5VKW/gjU?=
 =?us-ascii?Q?96T/hBVgeCFgmF/haIQJDs0QX6b/C8x50XohA8elGvSQAQUK1WVGSeg1ZiNF?=
 =?us-ascii?Q?eAMlb/Qlh4bLjIGGwuem0eu0OKX/QMRR0n8MnSPU32ADxz4aM+v2agJqDJsu?=
 =?us-ascii?Q?QohEXDvNqHZnNn/Kagbf5uv185tULE1wqOOyshW8p14ubGBkQDZxVyn5QL97?=
 =?us-ascii?Q?xkUt+DFKTwqMISgggmRtlr+v8mayT6Ui0CfWs8O44JjVm7xOrYzAQEp0o7yE?=
 =?us-ascii?Q?PsbbrGKNRKt1Cp8BLbH3Z/xG1hYVHLhbtgXshjSl20EdN4gsBIb72sjDqV6f?=
 =?us-ascii?Q?uqbCbX/WqUu0uFaCw7bsnOoqWJrs++mAdYhk0I/jz5Kwk++83eg8vPJouonc?=
 =?us-ascii?Q?sloEVzwqBiXNTgFPDojYy7cz+bs3vQ5l9E5N9D6bM5YfEXceDQzbSNxAHpr3?=
 =?us-ascii?Q?HhZIoJwtlnqk8dB1TvpZ9elawXkZh6cvU5S7vy+vzOiFrWJvxgjCxqQrwTM0?=
 =?us-ascii?Q?sy8KhAYIaDhWJuymVAYxvbrMhzakp7627cLnm/UFgHLe9zjAQEVqa+9gtb6t?=
 =?us-ascii?Q?mizhpvbKgDpYUhyoro9hl3XCotwSGRgwpYaR0d0p6+9YofCX2yas3x8nkWqW?=
 =?us-ascii?Q?bcJEr2cN0XGJlFAMSxgeJOX9yotizmNx2RZ31cv7s1R8kRkIwbqplmWof+Bo?=
 =?us-ascii?Q?E6pvSzwbzn0R5vsUHW0z5H/FJ/6Qcc/VnIustviJOUi4Ft97JECQhwQSh/M9?=
 =?us-ascii?Q?3uyDOcmTyJHkB9H50f8OwBBGtOukKij66EpLpuUltuvdi5UsyszOjCvMJpdy?=
 =?us-ascii?Q?eyDyKC4ST5ryM+NOScsvaUSCXP/nymU/rboLcvbiXTc9MZxgEa5v3WOwryH1?=
 =?us-ascii?Q?MTvxxYIz+/ebpmW3KgMU6PO+WH7a/XTngaVcpp/9GNHnaB/NWFyIj9zz4C+W?=
 =?us-ascii?Q?eEpmtovqDI68TgnMVCp2N/tfqpQU1js4HUMUR+aEiQwfEdOlgcg/QFtSIATV?=
 =?us-ascii?Q?4LzrVl1dedT/BgruOFzDXtxo9m20ZPSSGH5QFHs8hGIbBdic6ayRKIx5pwhp?=
 =?us-ascii?Q?3lEhFlWMfmuJkQzkc8/ee93ErNty4oM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 055ce134-f5d0-4ab1-c15c-08de543239b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2026 12:33:02.6257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EN2L647R840cdi9onx+q5U7mCX4FyfnrmdPDPRkI7n34bteThx7rRRx0ChyPt8oHm+0BvBYM7dtVQs20Vqd+hlsmK5M1wJy3U1e0B47a7osmKQiKD/43rjGix0WaSAJJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10068

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>=20
> Sent: Thursday, January 15, 2026 5:12 AM
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
> Subject: Re: [PATCH v2 net-next 0/1] AccECN packetdrill selftest series
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On Wed, 14 Jan 2026 23:25:59 +0000 Chia-Yu Chang (Nokia) wrote:
> > > Missing your own SoB on the patch, but also -- are these supposed to =
pass without the kernel patches? Without going back to check Paolo's messag=
e my understanding was that you'd repost this as patch 15 of the kernel ser=
ies.
> > >
> > > On the packetdrill side -- is PR #61 the code we need merged?
> > > Doesn't seem like it. Could you please clean that part up and start t=
he review process?
> >
> > Thanks, I will add my own SoB in the next version.
> > This patch can NOT pass without the last kernel patch; shall I merge=20
> > this series into that kernel series? If yes, I will submit v8 on that=20
> > series and add this patch as the last one.
>=20
> Yes, please.
>=20
> > On the packetdrill, the used packetdrill is commit=20
> > 6f2116af6b7e1936a53e80ab31b77f74abda1aaa of the branch:
> > https://eur03.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit=
h
> > ub.com%2Fminuscat%2Fpacketdrill_accecn&data=3D05%7C02%7Cchia-yu.chang%4=
0nokia-bell-labs.com%7C4e8d1d517df64fb0e6b008de53ec2d5e%7C5d4717519675428d9=
17b70f44f9630b0%7C0%7C0%7C639040470993547718%7CUnknown%7CTWFpbGZsb3d8eyJFbX=
B0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUI=
joyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D5%2BP0xyXIjXqfC7B6kuMAaEp%2FYuoPSUkYzKC5Pg=
RZUA4%3D&reserved=3D0 Shall I create PR? Or above info is ok for merging in=
to packetdrill.
>=20
> Please create a PR and let's give Neal a couple of days to look thru it.
> We don't need the packetdrill side to be fully merged upstream but I'd lo=
ve some indication that it's not going to take long because we need to manu=
ally manage the packetdrill build if it's not upstream.

A new PR is now created: PR#96 I google/packetdrill
And the v8 of this patch is also submitted with the updated commit messages=
.

Thanks.
Chia-Yu

