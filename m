Return-Path: <linux-kselftest+bounces-38944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C39B25E10
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 09:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4E33AF27E
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 07:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B702D5406;
	Thu, 14 Aug 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="VSDvO9sr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011059.outbound.protection.outlook.com [40.107.130.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8635A28689A;
	Thu, 14 Aug 2025 07:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157831; cv=fail; b=ParJJ8zk8PhQ81cV3M55b2ZcgPCWX6wQSqV0wjVc4zv5r8CBeI3fKJY8ZmeDmz92WyxY+7LIM2k1dLJ/erB2hjZSsnZaVS6bEgP1iK+QdsoxxTDNG0FLnkCGPo45Ew12dOuokLVtNhVDLdlth0/ytgbUPq4GXI6qTlnc30SUoOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157831; c=relaxed/simple;
	bh=3dlybEQ9TZ48NlBWn8tVdvxcL2AaJ+ML9gpAqqdFhVU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jja0BQJVZ3pbxYwisD/ECX1QVsoN4pulLEx0Y2iMjtNSD3Hh601Swy9I8kk74MbTdq/vJfJ2zq6lhuFUH5vEkFxNMeEhuHsT7aCrRMP6V0ALlNzInem3SGMqTeZH0b2ukDapTrrVopzzYHUVtZmZynTAUObLZxbiI5NFgdbhhvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=VSDvO9sr; arc=fail smtp.client-ip=40.107.130.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CB67gjSJX4YIvx0mFoBabggO2PFXnseNRMyQ8HCo7HHqcRu1qYB3pM2GCiioackUutbFIdp3ldqaKzQzBa8ggkmUbMBVMULlqHBU8JFHVje19A+kckfmP6tgnqsCFLbHK+XR+5VArgZLpRil1pDiVveZdZh/eoi6OOIcoH8vQfLhg6VtU9/X8sta5ohH7A+ngAODvS//I6qqIrEghwuEi4q1M5nZTpxc/aJhozcMknHvPnd4zI9gR/k3CB9g9lSbe8fYaLvzpnKdSEjqPVNr1na73env15RkDQRnRTMuhpBa6Rx5M1ziF+qo2Kw8XOt0Z0ALtfTbRwX4jWDdjHiCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dlybEQ9TZ48NlBWn8tVdvxcL2AaJ+ML9gpAqqdFhVU=;
 b=BZuRMkwRYtwO6Rduwg0ge3bfU5Jrue+4VLVDKMNBMz0Lzfa7VEuMNjmPdbB4yQncmPhYrkvYE25V0xCCMuaJROc+CfzXBaRHPVx2tzV11BjvFZRobaqBuFYqwM4kWQJac0HTBRZbqYOWab4zCf+Rx/nmqkpj6y4qtBaF67hwHzguso3F0oezoPRWcf++xACoTHhUrq6XQxiiF8tPgfZIffzdIMtXJIlr3+/CCuLfvsuyfHMgxaT5lSnGO0dsIwxT8VQbrVFTUfEnnskKZwKWthGIg0NLEtkJ9PEdSKU9rZj4C5ewmkMHDZl6AXgZkRskHq3jyQZvQ7Jkccvz3o2aPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dlybEQ9TZ48NlBWn8tVdvxcL2AaJ+ML9gpAqqdFhVU=;
 b=VSDvO9srYACleA4YUbVguxerafbcbFlO72YSgJppJTjo+5JiCFRd73zP9jXFnTp7nTxIfL4YVefcxMCSlDoH4q91QxAA594oJhee9W+nfxi+9J4teviWk1BAAE7thoPOhPCx4Nkmxb6kNhb6/ykKryVGgN8R3nRfHOiP7Hq9Gov97RpMGB8o3ETtjgjmRqBRXm3ZwTwM0tLTKY/ITdLbwYJTP6NY7sAuKf0htjqePKEXQRgbkmktMk8hFl44bO/POlCZyP/QEUxsh2NrT7q3zwF/PTGFU5dUOBfn7zo/SYacN4Wiy/mEfrp/rQ6jkj55UrzcjzT7qw/JdFCC1KbKPw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AM0PR07MB6404.eurprd07.prod.outlook.com (2603:10a6:20b:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Thu, 14 Aug
 2025 07:50:26 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.9009.018; Thu, 14 Aug 2025
 07:50:26 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "Livingood, Jason"
	<Jason_Livingood@comcast.com>, "edumazet@google.com" <edumazet@google.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Dave Taht <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
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
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "vidhi_goel@apple.com"
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v14 net-next 00/14] AccECN protocol patch series
Thread-Topic: [PATCH v14 net-next 00/14] AccECN protocol patch series
Thread-Index: AQHcDO9onnh7956fkESvji3S9l3+BLRhxiew
Date: Thu, 14 Aug 2025 07:50:26 +0000
Message-ID:
 <PAXPR07MB79849D1112057C72FE44E286A335A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References:
 <BL0PR11MB29614F8BE9B66484A478F6F4C72AA@BL0PR11MB2961.namprd11.prod.outlook.com>
 <274729ea-8db3-41e4-9dfa-f33e5e65222b@redhat.com>
In-Reply-To: <274729ea-8db3-41e4-9dfa-f33e5e65222b@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AM0PR07MB6404:EE_
x-ms-office365-filtering-correlation-id: e091250f-0ec0-4631-417b-08dddb073b5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?V57yZOYXP1hw8sAvkmIfznVxh71i9/GNugH+buRt2SAMtK08oChzh0Ejoh55?=
 =?us-ascii?Q?8qkMoWYajUWuifJBzd4EbbKLh3mfKJVB+e68oUiNZqARFhtQNkXNhn85oLKt?=
 =?us-ascii?Q?iqvk0rHTngMi4e04w9DBYgQy0TEA/53kNp/riOB3TCqK34aeJnk+txopRENW?=
 =?us-ascii?Q?O562FkLz9TezrbYSu0uCVzmqyoej+MYNNw+mZQN5BCRh4PeRP/YJPLChVmRT?=
 =?us-ascii?Q?LcJjREW/ru1uBkj2yWphkwDV5RSnJAlKoxzy+31IRCG7DV6CGFCYx6zD0lnU?=
 =?us-ascii?Q?bK58bMNin7yd1tzCXaOiveU91pKFBKAj/c7AA+T9uD46xGFmcdcbKJiXNBI3?=
 =?us-ascii?Q?M3qPTmxZZq6GJX0dsEL5Repc2YS2oOBRQozyF4ym4i9mUy7B1smTpwKHa87v?=
 =?us-ascii?Q?AbD7//kGeq8AaBdTtjwwjO4aiGwUoAVJQhfFqEKaIjIhH8N9RNxfkKfPaNTZ?=
 =?us-ascii?Q?9KMMZDf1Hqf6xNIcuxn6/Gp7Da1S/VB/fdppwLkR9pEgL7FbT6bE8NYiGx7Y?=
 =?us-ascii?Q?i9D93QxIdqDrN3DFNdKeg334lQ2SLwfS2pK9Il5JkCLJqXVgKcbXEKRE5lHk?=
 =?us-ascii?Q?q+RWMvE1rv3y9yg2z7WU40o0cNzBdI4Q5ySKcH5hFGkvSpHLzYBS68bgmipF?=
 =?us-ascii?Q?yHrhp9xE8l9y72HOPXJ8bY5jIV0cr2zmDhA6f//j24d+T9H3AYXbPyQriC9k?=
 =?us-ascii?Q?6u9WHkgZDAr9oHQzh6eZqDOIc3EHDsd3//VLXEcrKxWmxZ4dFx59mK0A6pzY?=
 =?us-ascii?Q?eGy/SuSmXipSnjlmKww5mAz9DnFh3+5JDnyQ8fMZ+oouFzpcwNPRkToD+zXv?=
 =?us-ascii?Q?/e03OrH6EBn9B59pTu+Wyk0wpqKAB7O9x781RH+i4HdqiYQDUeH8e1B8neQ6?=
 =?us-ascii?Q?YIu1ZToImEIQQ1rwtMw7RUIQRf3wwTcCvYi2ledB+wyhyUSvrOoGBx+UVI1f?=
 =?us-ascii?Q?jAG05MQ2FRV3iFc7qs9ZgaEXuCStQGR9/GBF2ZATP23xZESOHdAA8SF4Z5St?=
 =?us-ascii?Q?+iDmGj1EwwcPPeBiePVtPLsBnRXqTw3rHzj5dNs/CTuRWR210ebfJfTjUVJ8?=
 =?us-ascii?Q?xQXpMnfHc6V/lR2Ce06baPgtnuKj7RdntaABjkcgM5VNHNV93ccMRAguPnM6?=
 =?us-ascii?Q?nRyDQyEv/+TxCtmAMaMmYqGh1ksIr9xGsgKUmjzsaSS5Cs7DCwhOmBn2vaLy?=
 =?us-ascii?Q?fLAf2pAP0Do+uaJ+9FGBibqdBT/yPUOxNFNa3L3S2XbuzG7gfXr4iRWRirLw?=
 =?us-ascii?Q?tJZxO3lzK6qBaWwaHXuh8aw1VhizMYAI30be0hcAHpXMP3vs4lhJCdVWYOxs?=
 =?us-ascii?Q?b0HOwThARnZnM+YdfrANFTIGWKJLNGy4LK0Yex0yMr7BwLt4/HywIHrqu+5S?=
 =?us-ascii?Q?NVuapdz6bDYDQQQNnSD1CS6uE7WvcHHpmJyCx3kVQyFxZeUOLO6Git8hcmiK?=
 =?us-ascii?Q?JpWcjgQuVNJytixng6BNaaOR/sf4TTpBABSIg79BVuJgbO4Drtp1bIFuqSyu?=
 =?us-ascii?Q?6APNzY5/QxQRaDL3n2/fitXwxTSqK8Csv2qA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cVhO056CaR5TBCuaKYUZTPakfGTOXYN0kXs5ZaJEViaSXqS4YsBzFwWTkGe1?=
 =?us-ascii?Q?hDdt/xyAOi27rPegOOQh7yF5ZJSwOAwEM3l0EUdp9QLwsBNT9pK/5DJf9YTV?=
 =?us-ascii?Q?Xb7Ul2tzKNY+LNbFT/kaqF7jPp7Bq7S73nc8OLa+1OtzeFhuuUDaB6yEZ2B4?=
 =?us-ascii?Q?mrTFCtjyo3JNWS+R29udDUk4LrTk6AdHe6YIpvPGV6RY/XJP1wVDwKiFH+8z?=
 =?us-ascii?Q?b9oDjQ4x32TMG06x08ovgkkzUy/I2Xpx3JADZFo3gwgWnTe9zGZIM+zL6ppK?=
 =?us-ascii?Q?rAt9vY5wpbo0wlZ6ORO50xSOKw4oCsJiG5mB/ZFSfHU3R3IzID6bndmbZDVk?=
 =?us-ascii?Q?BIm8vyOXBQNObXG0ERZ3Cr2SKLBdMWhhb43dfwrlS95+2H8Co78lyZCZMJJQ?=
 =?us-ascii?Q?P49EgTGsVDFA32scDeP9siPcRIZi/Ltnx13Y31U7Jkr2HDM7r8AHkQSO6ZU2?=
 =?us-ascii?Q?14NMhdDbYb29VXCM/qPfbqGr/qvR6z5W8UKBif2TqmrGhaofl3SNoA4XclW0?=
 =?us-ascii?Q?HOcGl0RYzNfKAEHqAiONrtHEeRwrydkwlPx5h+0G98Ns/zWuV87ZgABF/t0g?=
 =?us-ascii?Q?8KQ65JPs6RQuAS4pEOj+DvHvAC43fMuGHTnbjbUSCGn6eJV7Gh/LE4KtSZaD?=
 =?us-ascii?Q?nbatW0cCKDqTmhqXV4MBSp1+kr/K9nV9AhT+rzkNbpjyhz4MAd3V9ihIwI9G?=
 =?us-ascii?Q?eJKICri0iINZVgbj8afzfGOn2TBPbGC1EAT6y1iwnnaeLV3nz716ckRy3E+c?=
 =?us-ascii?Q?vHjIur4XXtKBl9pI2Ql/lOzvVlW44cPQXJUjskzzdWRpxL46hYwjZOtKC4Cx?=
 =?us-ascii?Q?TmwFvPa2Su3/JV94W8BaOUfvF3Ng0KWqovNuNClu9/ZxReRHtaeur8adxQZ9?=
 =?us-ascii?Q?qTr+JYFx+13VMJtS4J0lzx6aLu8LKR8YJFiRD9t1AeBMbjkInTRBMOd5FUQx?=
 =?us-ascii?Q?Uk4S/8qTzOzIvzugiOiE8lCZ58mWuskLJVTyS+PUB5dWyTG4n5DQdlLBys4j?=
 =?us-ascii?Q?dl6zvH30ZvRpnCBlupMERPVCERRP4r2Sbduc1/BZMVKtjEZhXpnoQjNS58RX?=
 =?us-ascii?Q?Z3v3eFSp3+AOYMSQ5g3FYFUlp0R1jzBYzMvuwkavH46Ga1XXUp4uK32yTfNP?=
 =?us-ascii?Q?MnqS1B3+rBZZ/DekKya9OjsPmV4Fq9vTD8ax+cXV7hMf6QwtJC0eaqLH4r5L?=
 =?us-ascii?Q?0cqKb75W8O3kCwVz1lcqLQjg2kEZlEfhYR9P/jB3COwCGt0N1Yka7Ucmaaj5?=
 =?us-ascii?Q?zvViAq83LcjJtCJJKbRT4U6ZkTC52Aid0reHlzR23kivUrGgGWcbo2dmcqoc?=
 =?us-ascii?Q?4Bf6iFEiyfBh4HuNjoiAcS0UF9r00bOBee7hSz8ZL01YoOLwa/XUjXaf335N?=
 =?us-ascii?Q?xOPS9yWrfEOKoqxPa8tXxJ4VB1d56RB5z1MFrEYurtuUU/Ra2j1h01iRE6A+?=
 =?us-ascii?Q?VOV5fUqTlJ9HigKAho4TgCKV9KFnAGXaLhygMjjZIy+JDhgBvXvNAEMz9p4J?=
 =?us-ascii?Q?9eSkZZSM+EUqSyPCptPuyQrZzx4ijpLR2Kvq2qZUULFt8MpcHwWOJtvoMaTY?=
 =?us-ascii?Q?v4De5/Df1puQePxbRBMtb21qa6IxCIL7aU99zqSAgKXP+yeIhpLTEvi9uqgr?=
 =?us-ascii?Q?Zw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e091250f-0ec0-4631-417b-08dddb073b5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 07:50:26.3446
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7iWJMglkHNdrDUnAOrYZDQsM4GQKEDiErDbzAJiDLtkfDLJQeHxi6ap/kvqkcSBlvoQ/tD5VCYHDp35MeLtvF1PWUXOxKfWjXeyVZB1ju+G/y8/jbnzcIXGivhsmLFUF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR07MB6404

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Thursday, August 14, 2025 9:45 AM
> To: Livingood, Jason <Jason_Livingood@comcast.com>; Chia-Yu Chang (Nokia)=
 <chia-yu.chang@nokia-bell-labs.com>; edumazet@google.com; linux-doc@vger.k=
ernel.org; corbet@lwn.net; horms@kernel.org; dsahern@kernel.org; kuniyu@ama=
zon.com; bpf@vger.kernel.org; netdev@vger.kernel.org; Dave Taht <dave.taht@=
gmail.com>; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplumber.org; =
xiyou.wangcong@gmail.com; jiri@resnulli.us; davem@davemloft.net; andrew+net=
dev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gmail.com=
; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; ncardwe=
ll@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.c=
om>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlew=
ind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; vidhi_goel@apple.com
> Subject: Re: [PATCH v14 net-next 00/14] AccECN protocol patch series
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On 8/13/25 5:43 PM, Livingood, Jason wrote:
> > Hi Paolo - If this patch series is delayed to the next release cycle,
> > what release number would that be and - more critically - what would
> > the timing be?
>
> See:
>
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#git-t=
rees-and-patch-flow
>
> net-next is open now. Patch need to be re-submitted and will be processed=
 with the usual timing.
>
> Thanks,
>
> Paolo

Thanks Paolo.

I will take actions correspondingly.

BRs,
Chia-Yu

