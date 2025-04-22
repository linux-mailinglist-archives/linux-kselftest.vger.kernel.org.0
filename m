Return-Path: <linux-kselftest+bounces-31307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8564AA9710F
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 17:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EA21895729
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Apr 2025 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3068290BBA;
	Tue, 22 Apr 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MD1FT7Gk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013063.outbound.protection.outlook.com [40.107.159.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079D528F944;
	Tue, 22 Apr 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745335710; cv=fail; b=NTWR5jAnVHP7BIqXaDi80wcL18L1vQDOTdYbapcf4HX9LHq4eXblF5Ih+GB9ex4q6Yhz0rFXPJTTG4CBtkM+F8G3EOHXbQ07nMxzzQ8yvDldtDsnG2+rcxH/SND/dOxO0BXGt478BbmSSs7NxlAx5bCBKefN7dpnIxqso+ZOvLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745335710; c=relaxed/simple;
	bh=CMItMv/lTyk4jZZlrtFlnbynjH5Uxu35InNO7UGZ8TQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XTw7jVjhGq3MqYOIrrvs53vhYuB4VcI+NuldVzWDh521WQH6w6UriIpiw17UshZtAZxlpwE0C8faUCI5AmMCGvQPf23BzdvkXFjtkPgPalQ+mdwxWLua3pko5bJWQ5s+5cEhpLenfGJL0t6RfySvi7t2Q3jLhAh05uhdPiFkBrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MD1FT7Gk; arc=fail smtp.client-ip=40.107.159.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YS9QklgdJ9f403k7ZAoPg9Zi6eKnBRVlqAYBnjYwYMavMFQF5b+8a/b5EV16RJcWlvdJPxbAUe0139x9arOg9skVgNNoYWlg/PL7LBwd+rWw9jGnacIHRsw12iyUhUD709+06U5zallJVp+crEQ+O4fzVmrog4E6/Xrhrzrw1FlJp3x1h4kGVn13tZ64UM1hC46K/LhiVNTUzg2ToO14IH7S03+EGf9tnnzW16ClXUMGEQGp4z2ESjUvfkuXeibkRJimmnnmFZH3Z1GtbEqTUbOoLZz/cGljxOVQS6kFsJaEY0L2dcwbc+zPP3zfC+UCprgqXnngeZuV4KqQa8qKEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qnFt6e8vRaMxn+BtPFCq0QJ7DPTiTrIGOwk3p0Vnno=;
 b=KYR4AnqEtwXpRi59+hrFVkyOvkD61MEjdWQC1wn5IMauZg/yd22s37Cq0Im2QFpsGPS46UtW5PHPKHQd6Y9vFBmGvlemIRFhnE33bXOFTzmyrbyoA1w4YQsT+jtQiahkP6fSQzuSpyB/XMKV4Wk0/bHK9KwG8QWQOm+cms2tsu1sOXL44TWqA6Wwoc5IvBRxsVLg6K1YreMyBrnmNWAvqKHSeq5fMp///Rs6M0U+G2bR3RnPNxyJotM6wYCeLfnPtJIW52GYWhqscmNz0cUxb0gltFEC6lNNS7m+CcDjRmnoCAoSXpOs3coOtLm1fZ/xleAi3luBkL7lUzjvN7t8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qnFt6e8vRaMxn+BtPFCq0QJ7DPTiTrIGOwk3p0Vnno=;
 b=MD1FT7GkRv94/klnN1a94dPmk1WzT15b4tYF/iwyqqpN+vqZUPRH2hnifcR8vOstTRvn5Vs1QmbCMMR2xqeqWilJqKICoyKTixWuvXKLJkct43WU3s6ynTJUpprBU1jpnWjuTVbxvOeuX7m1d5vWItr6QaSBqcLq1yqjZKb9umCMabDt+tTDHvrLG4/2w7rPX3RVPRVfUeANCi/t5VkzoJZFc3N/XTY48BhDFiPOadZmj46xxijayKlwNhLVuMA+98mMQs5QtYrADG1WfQSXLsfaBaxKP9HZ2Eh4NwydedXfIffn6kvcVr0PpGPM9ylmARvXxfiud90DpWpQP1nnyQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9834.eurprd07.prod.outlook.com (2603:10a6:10:4c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 15:28:23 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8678.021; Tue, 22 Apr 2025
 15:28:23 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "horms@kernel.org"
	<horms@kernel.org>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v11 net-next 3/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v11 net-next 3/5] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHbrgQUoAphc9uOXUyDP5dhjQLlNLOvgK2AgABYYSA=
Date: Tue, 22 Apr 2025 15:28:23 +0000
Message-ID:
 <PAXPR07MB79847FE321734DC68C0E2D30A3BB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250415124317.11561-1-chia-yu.chang@nokia-bell-labs.com>
 <20250415124317.11561-4-chia-yu.chang@nokia-bell-labs.com>
 <75af7a51-1a7a-4e65-8ce6-f28411800070@redhat.com>
In-Reply-To: <75af7a51-1a7a-4e65-8ce6-f28411800070@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9834:EE_
x-ms-office365-filtering-correlation-id: 92582abf-5e7c-4997-e194-08dd81b251f2
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|13003099007|38070700018|921020;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qNmIMue9zk9jwO9ey7pDrwx8NoGVttwPwceVteP/goEWXrI1V/csQOOSdh8/?=
 =?us-ascii?Q?z0h6G+IyGCU0R6WjLFZqUt0GAMpmerYwdyqIxnO6zASkhtd70jgBJlMnWevc?=
 =?us-ascii?Q?yOgvvHuNyPbOKfmnXR3aU1Ax6uiEEQzWx7OZvL7FE7a4My7qgnPgYD5j8ujn?=
 =?us-ascii?Q?1vsz6flDWggLgprcdYTa1kc7SUoIOs03ddH184FkcT9PfCHFC0imTv5wCnJb?=
 =?us-ascii?Q?RoICeV89KRmjbx2L2pJc/j1jwhOd3SFAK0SxZvTN7/kYsjk0p5M0bWUPyXc7?=
 =?us-ascii?Q?2mX5TK+Q+Rz0UOJWR0yRUESitaFIN9FGU6LmQmq0psvTUcY6cVK9VSzqpEsx?=
 =?us-ascii?Q?iXnpeJ5hngWHdWCUYi/xnL1atuF6mq3NiSxXOGHFh4UsIZSsjQo/5Yuvmafy?=
 =?us-ascii?Q?/IPxQ9yFl4L1FbnpDy/EzQjV86JYfHNgj87zT1kd0We2e/8sOhxr5w+9d5Dp?=
 =?us-ascii?Q?eN/skder8jQx/NSW+4riQvKTnKdC+vy1M58tmcpohjE0jQ1HIJhU2SYy+Xsw?=
 =?us-ascii?Q?HM5Y5Xx87fTsZXeAUhorII4+M8MrgXG0YjlYPDk+nLsdUto7ZjFi4CayAP3f?=
 =?us-ascii?Q?q8c2A9R2mIr5YL/rEQeMg88Pwe/pWFIvGi0FjQBlZhqVcJerzB7csqa4nMfd?=
 =?us-ascii?Q?182e4gtLXMKbicieZOTh4mfQij3ing9idiGG6053MmbSM9WNa5YVnIryOoYz?=
 =?us-ascii?Q?0SRIXIAYHYkLzpLWqcEroBBsD+lTzmow9AXJcOaMamF6DN7B+OhTLi2774ex?=
 =?us-ascii?Q?GxZeEw/5U42Z+jtZIw/0sDCBkk1qYjLiLHfl+ZrZ23jirpYSTOrpxMn/liax?=
 =?us-ascii?Q?uv857hcyDbMoveWV9Ld7ywYMwav0J98nWTO/9OKCe+CXSGr8tdJXpRhHdY8n?=
 =?us-ascii?Q?Il5SnnatPdfRLPKaszgIYUusBfkWFR8YMA3I4WnRv9iCqoY9s285pHtZamsN?=
 =?us-ascii?Q?wWaJ8C2iOXH7m11SelzleWPJhTKu3K2Bcs1INyYZqgIz6K7qgKVLQT/Nyerr?=
 =?us-ascii?Q?q+uRaVO/iPIZ4pOY1gfTYyLnObZWtshf/o0hqauXE0FYB1Ds4UK1pDo/MVxn?=
 =?us-ascii?Q?TBhn/7e67unAlrfMd1/d8iWi0pSV4NvqcfpyR1Cyu9AktisRSTRfGK7DBFW+?=
 =?us-ascii?Q?GUbNW6/LsZ6vTPf4cFb+ggPFVPt4VMDJeVVluk1cL6w0HNZ0EytgaxXlKgV/?=
 =?us-ascii?Q?LGeHF1M6Nry4DoNfySKvOVS9JkUqWogv+tooL4ZYQGVv9J5QTvp3eztpJU6u?=
 =?us-ascii?Q?d8D/T/6H9/+Aiwys6lbYNXVHeN1v/0K/kgbTa0BHf3JWBzDzT8yN0XNBcAjF?=
 =?us-ascii?Q?Xf5zuG1oorqBHBIA9JMwoDLVMAjZoPljsVKfwCTGsg1Z7Jr3DNHl2CPy3x10?=
 =?us-ascii?Q?a1ZbgGi20NKkCxYCPIIfilwqbbH0wEL3khSTPyERAqMQ+fbaZMvKEvP+9xsV?=
 =?us-ascii?Q?Q0XeL3EoFrU5yTRXioGIA0Ie+2ZvYGBDgFF9GPm87+IJO+A/OY1zPdbeEegR?=
 =?us-ascii?Q?p0wv7uw0oLV3Sxxrvh8EsVxNl5KqFO/UDs7s?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(13003099007)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?o3ndtLUO1jXO9oFa9iumBbX9aYwqfb2ht6ZJXv6XWT3Bh/Avbstq+B2PnJMD?=
 =?us-ascii?Q?O3oBnIZ9TnvhTHryoZok1eCBoEwRk8KLDctfAl79gJoskiAWAUxDAE7ycD6c?=
 =?us-ascii?Q?b1FV5VwiHcoykaiDuh5ogVJw13wonEwhXmtR43sReUSSszgynMUozhsfmfHc?=
 =?us-ascii?Q?nJeesBrNzU8k5et4RAUzZJ/abLyU8AC/YPw0ZY2V9Yy7eM5sfYOb+Oq4HlZv?=
 =?us-ascii?Q?azxN9bU6G+fr56Lbcw0Gb56ZXupH6+A3PwQmH2uDbflYrDU8SAaC1QvSK9Ar?=
 =?us-ascii?Q?Jgv64AVubX2/qTYhrBtlDF6T9jqeE4fK4/QAWjG9Pw+d9Ae9hZzlhW6IgGeN?=
 =?us-ascii?Q?Svj5J8W1klt7VLLWR/YBfgjTUHjVaiAILHSx+k+fnp6ntr9Mcw3a9fC1LtfO?=
 =?us-ascii?Q?7n5MbGos3ltp6tgw4ZWCklz8s4YsheOaJXjXjbxfhe/qNd5pQmvF3DNEcyJc?=
 =?us-ascii?Q?qgPyPnAsqpKfvjjFkStdOLgdktCeaBGKOBI2HdmlxxsaY85I976xshObyTmS?=
 =?us-ascii?Q?pNNG24KkcN7AwrrPrufl+J6F/PK3XasFEqPGbyxx97ofmHu2NdlZGvbm/meO?=
 =?us-ascii?Q?oWkamxMTlNihA56W8dF897Xdy2lvZUN6Yza/RBn0XXcs6ARpRY4iidogWWBw?=
 =?us-ascii?Q?an5T9usSBl5sisLEuZV2M/I7312bHbK/Blmy+Y83UycLlXKaC0tak/WT6R3L?=
 =?us-ascii?Q?pWiuCyyu4pb06iBTNAD5n3wdxeGQWEMUUl4cjILXfKlhDPi+SJPPvw+uMWHo?=
 =?us-ascii?Q?BJoHbvihNCVwGlCOZuP6/BQeFP2WqfDyW/03RiBHSRlFb5WfyaIHG78mxFrI?=
 =?us-ascii?Q?xeHz2PDbdfomU7rCLwBnJa9DSHu7kcOUVDC03eL6FmTHSMagQp6TRxNXVP+A?=
 =?us-ascii?Q?ubjDBD5jZqmJUjppE2AV0MRQBFqL6h57pT18GAEgZgAqmwOoOszMPfE0U1kB?=
 =?us-ascii?Q?Gc5UmCrkU5XQandgxjt47D87EgjQCiZ5yocbUGmBZxxLgprEoLOqVhb+k522?=
 =?us-ascii?Q?tJseVcG0HHSmQf4ohlEhrzx5/qognejzwBC5Y5KDTcvZO1aofqKu5pIjCYqZ?=
 =?us-ascii?Q?zRhuKF3CxBjg/UheHINW0piDSjspCgSSv0Cn/bLcxWIlgvEPZLDCqDhljwSu?=
 =?us-ascii?Q?pz6FqadKdMP2klzVstFGb/B484wCnx57YkJN5nrPhLTHA4rYi0wTb8RnWCvz?=
 =?us-ascii?Q?ctw1MtbhNx9D15fBf8nU9ABSM0rcw95SlbsXMPuWCXep+CUzusYTA3UxHQFh?=
 =?us-ascii?Q?ipzfoA8sBeuztDcFZZeY/aNf3C1uC+ickCZBXgj/4KWYcAAHoNari7CJeMLH?=
 =?us-ascii?Q?zVdVEC8MqgVXKHXJC1cRmUeSpf5+gulFT2Q2HOJZX9iDB8Keu7l1J8lz9nYu?=
 =?us-ascii?Q?r1Mnyjwaf8vtK2+bxFSy8KyIJ6zFUEU+4EvFE3RKOqq85zkM8euvDwrJwhKA?=
 =?us-ascii?Q?MsJMhxT08r0uiGGe6/2VScGXiHo/+wQloOygL47dnHMYzWO6MWfi0pCXA1TE?=
 =?us-ascii?Q?3nKEpZZdSyiDwhd3ryeOXn26gc6QfvOsovm44AucH5+h/vrfBIDjiqsiJZgb?=
 =?us-ascii?Q?nBlbJMOfvkicPryHSZtv/1Ov8/U7aD1EMbxAokgMC3gXLRNT/DJtT2ung1mr?=
 =?us-ascii?Q?zg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92582abf-5e7c-4997-e194-08dd81b251f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2025 15:28:23.5219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDRGs3ur8YXuiCW+QzmCuwho1O4fbjnKupHbz+FSaXP5ox24nzKMkB513UuyWPj0MOmvgC8a0MyMzBNHu323m87kg0nSqCpx11c6BFY+FdkEGCO9ProKNTrGhtef62Dk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9834

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>=20
> Sent: Tuesday, April 22, 2025 12:07 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; xandfury@g=
mail.com; netdev@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; ku=
ba@kernel.org; stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@r=
esnulli.us; davem@davemloft.net; edumazet@google.com; horms@kernel.org; and=
rew+netdev@lunn.ch; donald.hunter@gmail.com; ast@fiberby.net; liuhangbin@gm=
ail.com; shuah@kernel.org; linux-kselftest@vger.kernel.org; ij@kernel.org; =
ncardwell@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell=
-labs.com>; g.white <g.white@cablelabs.com>; ingemar.s.johansson@ericsson.c=
om; mirja.kuehlewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jaso=
n_Livingood@comcast.com; vidhi_goel <vidhi_goel@apple.com>
> Subject: Re: [PATCH v11 net-next 3/5] sched: Struct definition and parsin=
g of dualpi2 qdisc
>=20
>=20
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>=20
>=20
>=20
> On 4/15/25 2:43 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > DualPI2 is the reference implementation of IETF RFC9332 DualQ Coupled=20
> > AQM (https://datatracker.ietf.org/doc/html/rfc9332) providing two=20
> > queues called low latency (L-queue) and classic (C-queue). By default,=
=20
> > it enqueues non-ECN and ECT(0) packets into the C-queue and ECT(1) and=
=20
> > CE packets into the low latency queue (L-queue), as per IETF RFC9332 sp=
ec.
> >
> > This patch defines the dualpi2 Qdisc structure and parsing, and the=20
> > following two patches include dumping and enqueue/dequeue for the DualP=
I2.
> >
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > ---
> >  include/uapi/linux/pkt_sched.h |  24 ++
> >  net/sched/sch_dualpi2.c        | 552 +++++++++++++++++++++++++++++++++
> >  2 files changed, 576 insertions(+)
> >  create mode 100644 net/sched/sch_dualpi2.c
> >
> > diff --git a/include/uapi/linux/pkt_sched.h=20
> > b/include/uapi/linux/pkt_sched.h index 25a9a47001cd..fd5bec118cdc=20
> > 100644
> > --- a/include/uapi/linux/pkt_sched.h
> > +++ b/include/uapi/linux/pkt_sched.h
> > @@ -1210,4 +1210,28 @@ enum {
> >
> >  #define TCA_ETS_MAX (__TCA_ETS_MAX - 1)
> >
> > +/* DUALPI2 */
> > +enum {
> > +     TCA_DUALPI2_UNSPEC,
> > +     TCA_DUALPI2_LIMIT,              /* Packets */
> > +     TCA_DUALPI2_MEMORY_LIMIT,       /* Bytes */
> > +     TCA_DUALPI2_TARGET,             /* us */
> > +     TCA_DUALPI2_TUPDATE,            /* us */
> > +     TCA_DUALPI2_ALPHA,              /* Hz scaled up by 256 */
> > +     TCA_DUALPI2_BETA,               /* HZ scaled up by 256 */
> > +     TCA_DUALPI2_STEP_THRESH,        /* Packets or us */
> > +     TCA_DUALPI2_STEP_PACKETS,       /* Whether STEP_THRESH is in pack=
ets */
> > +     TCA_DUALPI2_MIN_QLEN_STEP,      /* Minimum qlen to apply STEP_THR=
ESH */
> > +     TCA_DUALPI2_COUPLING,           /* Coupling factor between queues=
 */
> > +     TCA_DUALPI2_DROP_OVERLOAD,      /* Whether to drop on overload */
> > +     TCA_DUALPI2_DROP_EARLY,         /* Whether to drop on enqueue */
> > +     TCA_DUALPI2_C_PROTECTION,       /* Percentage */
> > +     TCA_DUALPI2_ECN_MASK,           /* L4S queue classification mask =
*/
> > +     TCA_DUALPI2_SPLIT_GSO,          /* Split GSO packets at enqueue *=
/
> > +     TCA_DUALPI2_PAD,
> > +     __TCA_DUALPI2_MAX
> > +};
> > +
> > +#define TCA_DUALPI2_MAX   (__TCA_DUALPI2_MAX - 1)
> > +
> >  #endif
> > diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c new=20
> > file mode 100644 index 000000000000..3f91f6b1db2f
> > --- /dev/null
> > +++ b/net/sched/sch_dualpi2.c
> > @@ -0,0 +1,552 @@
> > +// SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +/* Copyright (C) 2024 Nokia
> > + *
> > + * Author: Koen De Schepper <koen.de_schepper@nokia-bell-labs.com>
> > + * Author: Olga Albisser <olga@albisser.org>
> > + * Author: Henrik Steen <henrist@henrist.net>
> > + * Author: Olivier Tilmans <olivier.tilmans@nokia.com>
> > + * Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > + *
> > + * DualPI Improved with a Square (dualpi2):
> > + * - Supports congestion controls that comply with the Prague requirem=
ents
> > + *   in RFC9331 (e.g. TCP-Prague)
> > + * - Supports coupled dual-queue with PI2 as defined in RFC9332
> > + * - Supports ECN L4S-identifier (IP.ECN=3D=3D0b*1)
> > + *
> > + * note: Although DCTCP and BBRv3 can use shallow-threshold ECN marks,
> > + *   they do not meet the 'Prague L4S Requirements' listed in RFC 9331
> > + *   Section 4, so they can only be used with DualPI2 in a datacenter
> > + *   context.
> > + *
> > + * References:
> > + * - RFC9332: https://datatracker.ietf.org/doc/html/rfc9332
> > + * - De Schepper, Koen, et al. "PI 2: A linearized AQM for both classi=
c and
> > + *   scalable TCP."  in proc. ACM CoNEXT'16, 2016.
> > + */
> > +
> > +#include <linux/errno.h>
> > +#include <linux/hrtimer.h>
> > +#include <linux/if_vlan.h>
> > +#include <linux/kernel.h>
> > +#include <linux/limits.h>
> > +#include <linux/module.h>
> > +#include <linux/skbuff.h>
> > +#include <linux/types.h>
> > +
> > +#include <net/gso.h>
> > +#include <net/inet_ecn.h>
> > +#include <net/pkt_cls.h>
> > +#include <net/pkt_sched.h>
> > +
> > +/* 32b enable to support flows with windows up to ~8.6 * 1e9 packets
> > + * i.e., twice the maximal snd_cwnd.
> > + * MAX_PROB must be consistent with the RNG in dualpi2_roll().
> > + */
> > +#define MAX_PROB U32_MAX
> > +
> > +/* alpha/beta values exchanged over netlink are in units of 256ns */=20
> > +#define ALPHA_BETA_SHIFT 8
> > +
> > +/* Scaled values of alpha/beta must fit in 32b to avoid overflow in=20
> > +later
> > + * computations. Consequently (see and dualpi2_scale_alpha_beta()),=20
> > +their
> > + * netlink-provided values can use at most 31b, i.e. be at most=20
> > +(2^23)-1
> > + * (~4MHz) as those are given in 1/256th. This enable to tune=20
> > +alpha/beta to
> > + * control flows whose maximal RTTs can be in usec up to few secs.
> > + */
> > +#define ALPHA_BETA_MAX ((1U << 31) - 1)
> > +
> > +/* Internal alpha/beta are in units of 64ns.
> > + * This enables to use all alpha/beta values in the allowed range=20
> > +without loss
> > + * of precision due to rounding when scaling them internally, e.g.,
> > + * scale_alpha_beta(1) will not round down to 0.
> > + */
> > +#define ALPHA_BETA_GRANULARITY 6
> > +
> > +#define ALPHA_BETA_SCALING (ALPHA_BETA_SHIFT -=20
> > +ALPHA_BETA_GRANULARITY)
> > +
> > +/* We express the weights (wc, wl) in %, i.e., wc + wl =3D 100 */=20
> > +#define MAX_WC 100
> > +
> > +struct dualpi2_sched_data {
> > +     struct Qdisc *l_queue;  /* The L4S Low latency queue (L-queue) */
> > +     struct Qdisc *sch;      /* The Classic queue (C-queue) */
> > +
> > +     /* Registered tc filters */
> > +     struct tcf_proto __rcu *tcf_filters;
> > +     struct tcf_block *tcf_block;
> > +
> > +     struct { /* PI2 parameters */
> > +             u64     target; /* Target delay in nanoseconds */
> > +             u32     tupdate;/* Timer frequency in nanoseconds */
> > +             u32     prob;   /* Base PI probability */
> > +             u32     alpha;  /* Gain factor for the integral rate resp=
onse */
> > +             u32     beta;   /* Gain factor for the proportional respo=
nse */
> > +             struct hrtimer timer; /* prob update timer */
> > +     } pi2;
>=20
> I think I already suggested in a previois revision to avoid using anonimo=
us struct to logically group some fields??? The preferred way to reach such=
 goal is to add a prefix to the field name.

Hi Paolo,

Thanks for reminder, indeed, I only fixed a portion in v10 of Dualpi2 patch=
.
And form the next version, I will fix for all structs with dualpi2_sched_da=
ta.

>=20
> > +
> > +     struct { /* Step AQM (L-queue only) parameters */
> > +             u32     thresh; /* Step threshold */
> > +             bool    in_packets; /* Whether the step is in packets or =
time */
> > +     } step;
> > +
> > +     struct { /* C-queue starvation protection */
> > +             s32     credit; /* Credit (sign indicates which queue) */
> > +             s32     init;   /* Reset value of the credit */
> > +             u8      wc;     /* C-queue weight (between 0 and MAX_WC) =
*/
> > +             u8      wl;     /* L-queue weight (MAX_WC - wc) */
> > +     } c_protection;
> > +
> > +     /* General dualQ parameters */
> > +     u32     memory_limit;   /* Memory limit of both queues */
> > +     u8      coupling_factor;/* Coupling factor (k) between both queue=
s */
> > +     u8      ecn_mask;       /* Mask to match packets into L-queue */
> > +     u32     min_qlen_step;  /* Minimum queue length to apply step thr=
esh */
> > +     bool    drop_early;     /* Drop at enqueue instead of dequeue if =
true */
> > +     bool    drop_overload;  /* Drop (1) on overload, or overflow (0) =
*/
> > +     bool    split_gso;      /* Split aggregated skb (1) or leave as i=
s */
> > +
> > +     /* Statistics */
> > +     u64     c_head_ts;      /* Enqueue timestamp of the C-queue head =
*/
> > +     u64     l_head_ts;      /* Enqueue timestamp of the L-queue head =
*/
> > +     u64     last_qdelay;    /* Q delay val at the last probability up=
date */
> > +     u32     packets_in_c;   /* Enqueue packet counter of the C-queue =
*/
> > +     u32     packets_in_l;   /* Enqueue packet counter of the L-queue =
*/
> > +     u32     maxq;           /* Maximum queue size of the C-queue */
> > +     u32     ecn_mark;       /* ECN mark pkt counter due to PI probabi=
lity */
> > +     u32     step_marks;     /* ECN mark pkt counter due to step AQM *=
/
> > +     u32     memory_used;    /* Memory used of both queues */
> > +     u32     max_memory_used;/* Maximum used memory */
> > +};
> > +
> > +static u32 dualpi2_scale_alpha_beta(u32 param) {
> > +     u64 tmp =3D ((u64)param * MAX_PROB >> ALPHA_BETA_SCALING);
> > +
> > +     do_div(tmp, NSEC_PER_SEC);
> > +     return tmp;
> > +}
> > +
> > +static ktime_t next_pi2_timeout(struct dualpi2_sched_data *q) {
> > +     return ktime_add_ns(ktime_get_ns(), q->pi2.tupdate); }
> > +
> > +static void dualpi2_reset_c_protection(struct dualpi2_sched_data *q)=20
> > +{
> > +     q->c_protection.credit =3D q->c_protection.init; }
> > +
> > +/* This computes the initial credit value and WRR weight for the L=20
> > +queue (wl)
> > + * from the weight of the C queue (wc).
> > + * If wl > wc, the scheduler will start with the L queue when reset.
> > + */
> > +static void dualpi2_calculate_c_protection(struct Qdisc *sch,
> > +                                        struct dualpi2_sched_data *q,=
=20
> > +u32 wc) {
> > +     q->c_protection.wc =3D wc;
> > +     q->c_protection.wl =3D MAX_WC - wc;
> > +     q->c_protection.init =3D (s32)psched_mtu(qdisc_dev(sch)) *
> > +             ((int)q->c_protection.wc - (int)q->c_protection.wl);
> > +     dualpi2_reset_c_protection(q);
> > +}
> > +
> > +static s64 __scale_delta(u64 diff)
> > +{
> > +     do_div(diff, 1 << ALPHA_BETA_GRANULARITY);
> > +     return diff;
> > +}
> > +
> > +static void get_queue_delays(struct dualpi2_sched_data *q, u64 *qdelay=
_c,
> > +                          u64 *qdelay_l) {
> > +     u64 now, qc, ql;
> > +
> > +     now =3D ktime_get_ns();
> > +     qc =3D READ_ONCE(q->c_head_ts);
> > +     ql =3D READ_ONCE(q->l_head_ts);
> > +
> > +     *qdelay_c =3D qc ? now - qc : 0;
> > +     *qdelay_l =3D ql ? now - ql : 0;
> > +}
> > +
> > +static u32 calculate_probability(struct Qdisc *sch) {
> > +     struct dualpi2_sched_data *q =3D qdisc_priv(sch);
> > +     u32 new_prob;
> > +     u64 qdelay_c;
> > +     u64 qdelay_l;
> > +     u64 qdelay;
> > +     s64 delta;
> > +
> > +     get_queue_delays(q, &qdelay_c, &qdelay_l);
> > +     qdelay =3D max(qdelay_l, qdelay_c);
> > +     /* Alpha and beta take at most 32b, i.e, the delay difference wou=
ld
> > +      * overflow for queuing delay differences > ~4.2sec.
> > +      */
> > +     delta =3D ((s64)qdelay - q->pi2.target) * q->pi2.alpha;
> > +     delta +=3D ((s64)qdelay - q->last_qdelay) * q->pi2.beta;
> > +     if (delta > 0) {
> > +             new_prob =3D __scale_delta(delta) + q->pi2.prob;
> > +             if (new_prob < q->pi2.prob)
> > +                     new_prob =3D MAX_PROB;
> > +     } else {
> > +             new_prob =3D q->pi2.prob - __scale_delta(~delta + 1);
> > +             if (new_prob > q->pi2.prob)
> > +                     new_prob =3D 0;
> > +     }
> > +     q->last_qdelay =3D qdelay;
> > +     /* If we do not drop on overload, ensure we cap the L4S probabili=
ty to
> > +      * 100% to keep window fairness when overflowing.
> > +      */
> > +     if (!q->drop_overload)
> > +             return min_t(u32, new_prob, MAX_PROB / q->coupling_factor=
);
> > +     return new_prob;
> > +}
> > +
> > +static enum hrtimer_restart dualpi2_timer(struct hrtimer *timer) {
> > +     struct dualpi2_sched_data *q =3D from_timer(q, timer, pi2.timer);
> > +
> > +     WRITE_ONCE(q->pi2.prob, calculate_probability(q->sch));
> > +
> > +     hrtimer_set_expires(&q->pi2.timer, next_pi2_timeout(q));
> > +     return HRTIMER_RESTART;
> > +}
> > +
> > +static struct netlink_range_validation dualpi2_alpha_beta_range =3D {
> > +     .min =3D 1,
> > +     .max =3D ALPHA_BETA_MAX,
> > +};
> > +
> > +static struct netlink_range_validation dualpi2_wc_range =3D {
> > +     .min =3D 0,
> > +     .max =3D MAX_WC,
> > +};
> > +
> > +static const struct nla_policy dualpi2_policy[TCA_DUALPI2_MAX + 1] =3D=
 {
> > +     [TCA_DUALPI2_LIMIT]             =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_MEMORY_LIMIT]      =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_TARGET]            =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_TUPDATE]           =3D NLA_POLICY_MIN(NLA_U32, 1),
> > +     [TCA_DUALPI2_ALPHA]             =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range)=
,
> > +     [TCA_DUALPI2_BETA]              =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U32, &dualpi2_alpha_beta_range)=
,
> > +     [TCA_DUALPI2_STEP_THRESH]       =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_STEP_PACKETS]      =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_MIN_QLEN_STEP]     =3D {.type =3D NLA_U32},
> > +     [TCA_DUALPI2_COUPLING]          =3D NLA_POLICY_MIN(NLA_U8, 1),
> > +     [TCA_DUALPI2_DROP_OVERLOAD]     =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_DROP_EARLY]        =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_C_PROTECTION]      =3D
> > +             NLA_POLICY_FULL_RANGE(NLA_U8, &dualpi2_wc_range),
> > +     [TCA_DUALPI2_ECN_MASK]          =3D {.type =3D NLA_U8},
> > +     [TCA_DUALPI2_SPLIT_GSO]         =3D {.type =3D NLA_U8},
> > +};
> > +
> > +static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
> > +                       struct netlink_ext_ack *extack) {
> > +     struct nlattr *tb[TCA_DUALPI2_MAX + 1];
> > +     struct dualpi2_sched_data *q;
> > +     int old_backlog;
> > +     int old_qlen;
> > +     int err;
> > +
> > +     if (!opt)
> > +             return -EINVAL;
> > +     err =3D nla_parse_nested(tb, TCA_DUALPI2_MAX, opt, dualpi2_policy=
,
> > +                            extack);
> > +     if (err < 0)
> > +             return err;
> > +
> > +     q =3D qdisc_priv(sch);
> > +     sch_tree_lock(sch);
> > +
> > +     if (tb[TCA_DUALPI2_LIMIT]) {
> > +             u32 limit =3D nla_get_u32(tb[TCA_DUALPI2_LIMIT]);
> > +
> > +             WRITE_ONCE(sch->limit, limit);
> > +             WRITE_ONCE(q->memory_limit, limit *=20
> > + psched_mtu(qdisc_dev(sch)));
>=20
> Without more strict policy, large value of 'limit' will cause overflow in=
 the above multiplication, possibly leading to unsuitable very small 'memor=
y_limit'
>=20
> You should update the policy and/or use 64 bits integer for 'memory_limit=
'

Sure, I will update the policy to make sure the value of memory_limit is be=
low 0xFFFFFFFF.

> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_MEMORY_LIMIT])
> > +             WRITE_ONCE(q->memory_limit,
> > +                        nla_get_u32(tb[TCA_DUALPI2_MEMORY_LIMIT]));
> > +
> > +     if (tb[TCA_DUALPI2_TARGET]) {
> > +             u64 target =3D nla_get_u32(tb[TCA_DUALPI2_TARGET]);
> > +
> > +             WRITE_ONCE(q->pi2.target, target * NSEC_PER_USEC);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_TUPDATE]) {
> > +             u64 tupdate =3D nla_get_u32(tb[TCA_DUALPI2_TUPDATE]);
> > +
> > +             WRITE_ONCE(q->pi2.tupdate, tupdate * NSEC_PER_USEC);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_ALPHA]) {
> > +             u32 alpha =3D nla_get_u32(tb[TCA_DUALPI2_ALPHA]);
> > +
> > +             WRITE_ONCE(q->pi2.alpha, dualpi2_scale_alpha_beta(alpha))=
;
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_BETA]) {
> > +             u32 beta =3D nla_get_u32(tb[TCA_DUALPI2_BETA]);
> > +
> > +             WRITE_ONCE(q->pi2.beta, dualpi2_scale_alpha_beta(beta));
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_STEP_PACKETS]) {
> > +             bool step_pkt =3D !!nla_get_u8(tb[TCA_DUALPI2_STEP_PACKET=
S]);
> > +             u32 step_th =3D READ_ONCE(q->step.thresh);
> > +
> > +             WRITE_ONCE(q->step.in_packets, step_pkt);
> > +             WRITE_ONCE(q->step.thresh,
> > +                        step_pkt ? step_th : (step_th * NSEC_PER_USEC)=
);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_STEP_THRESH]) {
> > +             u32 step_th =3D nla_get_u32(tb[TCA_DUALPI2_STEP_THRESH]);
> > +             bool step_pkt =3D READ_ONCE(q->step.in_packets);
> > +
> > +             WRITE_ONCE(q->step.thresh,
> > +                        step_pkt ? step_th : (step_th * NSEC_PER_USEC)=
);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_MIN_QLEN_STEP])
> > +             WRITE_ONCE(q->min_qlen_step,
> > +                        nla_get_u32(tb[TCA_DUALPI2_MIN_QLEN_STEP]));
> > +
> > +     if (tb[TCA_DUALPI2_COUPLING]) {
> > +             u8 coupling =3D nla_get_u8(tb[TCA_DUALPI2_COUPLING]);
> > +
> > +             WRITE_ONCE(q->coupling_factor, coupling);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_DROP_OVERLOAD])
> > +             WRITE_ONCE(q->drop_overload,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_DROP_OVERLOAD]));
> > +
> > +     if (tb[TCA_DUALPI2_DROP_EARLY])
> > +             WRITE_ONCE(q->drop_early,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_DROP_EARLY]));
> > +
> > +     if (tb[TCA_DUALPI2_C_PROTECTION]) {
> > +             u8 wc =3D nla_get_u8(tb[TCA_DUALPI2_C_PROTECTION]);
> > +
> > +             dualpi2_calculate_c_protection(sch, q, wc);
> > +     }
> > +
> > +     if (tb[TCA_DUALPI2_ECN_MASK])
> > +             WRITE_ONCE(q->ecn_mask,
> > +                        nla_get_u8(tb[TCA_DUALPI2_ECN_MASK]));
> > +
> > +     if (tb[TCA_DUALPI2_SPLIT_GSO])
> > +             WRITE_ONCE(q->split_gso,
> > +                        !!nla_get_u8(tb[TCA_DUALPI2_SPLIT_GSO]));
> > +
> > +     old_qlen =3D qdisc_qlen(sch);
> > +     old_backlog =3D sch->qstats.backlog;
> > +     while (qdisc_qlen(sch) > sch->limit ||
> > +            q->memory_used > q->memory_limit) {
> > +             struct sk_buff *skb =3D __qdisc_dequeue_head(&sch->q);
> > +
> > +             q->memory_used -=3D skb->truesize;
>=20
> The 'memory_limit' is computed above using psched_mtu() which return a pa=
cket length in bytes not including per packet overhead, but 'memory_used' a=
pparently accounts for the skb truesize - that includes per packet overhead=
. You should likely update the 'memory_limit' algebra to take in account pe=
r packet overhead. Rule of thumb is doubling the packet length.
>=20
> Cheers,
>=20
> Paolo

Thanks for the tip, I will add the above calculation to include this rule o=
f thumb.

BRs,
Chia-Yu

