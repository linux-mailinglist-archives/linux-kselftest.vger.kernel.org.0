Return-Path: <linux-kselftest+bounces-23710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F049F9DD8
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 02:54:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C403316A218
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 01:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193657CBE;
	Sat, 21 Dec 2024 01:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dLfH2NDH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D74282EE;
	Sat, 21 Dec 2024 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734746051; cv=fail; b=a2J60TayPed3VhkH/uwG2KBl0himeCeAVEUqt1WFVlXJxvadTiCMsLAlB3cAn1WJciDnpxowAx2Zkbn1Cd96c3AxdKjXTA2S4vOM9hapIK3lENZzqN8rIhDzFXqTjCifI5H1cZ/1DPe6ehEYg67o8k8v9BhM6e6L3RbkaOyxBD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734746051; c=relaxed/simple;
	bh=VflWz464ft5pOz+r+a6sny8Fy13apTbOcUrU7mWXjEY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QY3pQHmeHIN1c59pNjM/wprzbCYjsX+lh5pD9phnb2MSfWKlE8DTZpY18xwon8n/4iGYQaMJl4tciB1K24yFfwS9o4snnIACDTZyOqu2Uh1zHLsjMDYPnv4CUQDD4Codftn1hFFCSJq1kxAHF9FzM5LJhJVQBxlYezU2Ag+7iW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dLfH2NDH; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSf3ShiHTk7WgukS53GsM8XZkaaRIsI7K1LXDujoesTe7btqhv/Sriij3pPPg0BVlUKaCXqHI1kEE7eFQlB7qzxuyOdMvINZJ82sjgp8newAqJqJPppUfCAKLZIv1Q7znKh8x2aeEjQcS3luFQPsULf77+dJeCCv1x1S/SHS1fCSpp+yCwe3h7WviT0jcaEkQhKdo690l/Oo/vUyTHvfiwz3s1T9OwmrejjCjvZ7X1eJigt5LZFvWnXIEpFpdUvY6Vp9Nn/jAUT+/NV2XUYF96itjF2bqxFFKEzpTBAvKpFAkcjllsnAOguNDoIM6yjHel/66UgYwmxIUwATOx1eOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VflWz464ft5pOz+r+a6sny8Fy13apTbOcUrU7mWXjEY=;
 b=Lyh/ofOU6cd1Z3uKOGgmnbrpqKUwKcO4won1v6Oax1wmO+CzKBNNX2G41RobIdi6MWs9XVxCNxldtSvW8+hPbzq2V+h2JNY80ntTIxgG1JpEmaSZR8/2tf1i6JzyNg7O4vNs5/wQ/c7chtPJUF+7rEKVVBJL4qBamicJzFP4AAlDO7ueg2mJPsInJI40x8pHH6bri/lLvqa4tw0Wx3S9JTSJBeghg00VS6h3WxeeTmYJA+UO1+ndlfN2tVFhlFT0K5nvG9nyVHj1kL/fOqYcY69/EBYnwgmaTcxqNvhxSdQw2Ev/p2LbNmuMvPtWvmN8uga5uozbGA79xzFE/aBpuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VflWz464ft5pOz+r+a6sny8Fy13apTbOcUrU7mWXjEY=;
 b=dLfH2NDHgsku1NdxWiH4IvHyk68xhqDbJ6lRSi2cyc7pzBy8qdFlZBR1/x54uJoSXMLrPPhuM3pzjHxLmAw/cYUfoULgvsXFm5KX1eUQrBXoYnHiZTgV6zHz85e3JcofV47QEq4v+cXcRjdCAfAX2dguLbtUPvz3V4F7ON7srpUD6HbdHTOckICjsT3tkIVs3M8qE4cd6fkvZEE5EkIOwJ+ZsQ5EWp7/yWdm+pFElAM29hBmQbyDGUriQTrFZJflHJaJm8xqHy1sXFeEHFw/TAggRUxYoeMRj74uHf10I6l/ig8wPdxXNEOBPVv5RP6BYqYZfROrMaHhJjC8ralE4w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.17; Sat, 21 Dec
 2024 01:54:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8272.005; Sat, 21 Dec 2024
 01:54:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "hawk@kernel.org" <hawk@kernel.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"mykolal@fb.com" <mykolal@fb.com>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Thread-Topic: [PATCH bpf] selftests/bpf: add XDP_UMEM_TX_METADATA_LEN flag to
 umem_config
Thread-Index: AQHbUsKbt+d4ByGi+UO0J+Wtft+nMbLvQa8AgACvDnA=
Date: Sat, 21 Dec 2024 01:54:02 +0000
Message-ID:
 <PAXPR04MB8510E8884DEEA3888BCAC5DB88002@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20241220091806.1856223-1-wei.fang@nxp.com>
 <Z2WMwPc9fj5kHcul@mini-arch>
In-Reply-To: <Z2WMwPc9fj5kHcul@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM8PR04MB7858:EE_
x-ms-office365-filtering-correlation-id: 45d3d0d2-5034-4bc2-8634-08dd21625816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+vX8TeptzAYzW6Irf6iCU/IyitiWsvmedl9B8G/O9PrzzP37zdGIBq1Jd09Y?=
 =?us-ascii?Q?M9KoRahFd2qW3n1A0PTB1TGH6zKf9ww5IyesJNzOwGeh1L2QSpYQq6/ZdJwv?=
 =?us-ascii?Q?g84gBIQpC2H/4hQskPGbBbZOMo5JTb895rXraZvIJpBEjd9cqp01V2lT3Jpr?=
 =?us-ascii?Q?7iq1UaerajxYlHgCEJExxzX9V0RbEL2Kf4G5EfRL0ei3Q5IFtSHLDtgy/fiI?=
 =?us-ascii?Q?dRdroDBNVHp8ssMlA+qjIpZzZCcofHepYRvaSLmUUKJDgpjSs0JwYv2cIfWd?=
 =?us-ascii?Q?7qwqD894DslXeKK4eqMFgc9nSFO5sgljro5Fq1FyVhfnv4aB6f1rDFc3t6l3?=
 =?us-ascii?Q?weTgGZ0t5nMxokEfaY8dp/iokC6wVeY6ACGL/ktKtY/srsHGsuQB1lRPfolr?=
 =?us-ascii?Q?BAyMQ6dZ9tlbWhlYwEM02IiQii/ZTnbSMFB5i3J7SySe2uLd7KGFtEUzwXKh?=
 =?us-ascii?Q?qkiRcQMvkBLdQ3MEz3QNFgdRFlz5p6NjhpF9pygNtgIaP2W9Kvb2QCw5IFBi?=
 =?us-ascii?Q?p27YK6b4GomiXWKsK5BUbvScJzpFvFpSIGgaUQutotQ4z4JGeKHWh4CGHy3p?=
 =?us-ascii?Q?1TqouIByJNzfdA6aaN1yxTUDZ8vZMsC+x99OQz4NRr3s5l4fTAFAEqH3M+VD?=
 =?us-ascii?Q?uOyaKBdiGHJsuifVEj+lskzuaQPVlbCLq7hVYDESftX1KTQjDPXaeZGZQna7?=
 =?us-ascii?Q?uFaogolXCsgq0/YwYGN3/yD3ngflIeB5KF+voF6W98yNZ/Wfym+SlTEao2fm?=
 =?us-ascii?Q?onRkNCEPi/f63Y25WLzYauNrMC1TY3Ud/DUqd3We2vr73b3we8nzN9VYnOgr?=
 =?us-ascii?Q?DepOadPn0wNK9AwNedjGTfAmlkzx7Dwxq1yA87fEUrLpMgXktuZFvS9e6PBQ?=
 =?us-ascii?Q?L0bfDNyUhRmZ7Ko2m1Xe0l3j6pfUXJqUoHTtzIBjStlP87dw66p+POSliIOM?=
 =?us-ascii?Q?SQ6NmTHi5PDjVaoM38/jaGwE+S1cPrd3rmW7xcnz3NAuZMS0usD38uaOvwXn?=
 =?us-ascii?Q?n8FyEGqM3DrLzlvXkRwPi8hC0fktCfQW5xWPOxJOlkgX/EHwxhCrYVuO5k4L?=
 =?us-ascii?Q?zVme0kEBOgtez+NIkhR4sK8wdTt+geMpA6LB4v0FQ7GwlvL5ElVGbr8GVkvE?=
 =?us-ascii?Q?0Fbv42cddkRYzyfOwhA6YjsErRrWpf5HDErg6e8hw+TBL/ytmbZ/vozvyRt6?=
 =?us-ascii?Q?0cg2su6YLirWM7dovCa8yNNW/FcQFZZzmp9lgAiVsdiKASGNf7iMTjoEUUpo?=
 =?us-ascii?Q?amZdyV/w/twUoR5/DyLHh3iirjctjlw4WACMpD6GkP501nI/MVgVb0SGK7NS?=
 =?us-ascii?Q?ZqHU68azIi2OGWzcYcGV8ar23+2IOMzcToYJgDEMINAb5RQRkv5fQA0QVAXK?=
 =?us-ascii?Q?vfH0hOWrfWS/Vcy8ISm+lvP6rMKp2uNDIhN6YtBNGddZyJC9nGNLagNgETpf?=
 =?us-ascii?Q?HP6BZKzbStw5GXMM8eeu/wZVCg/dfNKr?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GlUfmXvRS8OHCWO21SG9egK1ImV0mskiKOFkXvyCTQ/Mst5xoaTViOZl6O1C?=
 =?us-ascii?Q?ylsYfEmgS0FbPD/Bc9t00ahOvDCPFiRPYlInQ5vGyoDLB2ol3p8+cItnniaG?=
 =?us-ascii?Q?FVOzXhc6S364G8dEa1ouvHi2YdgVx7VYgfoxE0jf1W9NT3NUPdl/E/4dkBXT?=
 =?us-ascii?Q?xtDilSGtIFn1Fh8tPQbGO6/3Dx9BfvLnhGRgI/PfctcxfsxzZt8WBxTPcdHM?=
 =?us-ascii?Q?VJJG7g9b+R0P4+9OC0mI31FVv0Amq1BMdf8defaaLUiNz1R3pczSGncLht7w?=
 =?us-ascii?Q?9PGCMLyEOsS/wFGcbKJtwPcH6pzparTjOKJkSpnhMBhZ5DRFy/XFx8w4pIau?=
 =?us-ascii?Q?CRWkKMId5gGmZ0aM6269TxaMse/ssMwUPZJHtMLdBHolI6EjBrxreiJSwPkw?=
 =?us-ascii?Q?OmF0dTtMNtl94e0gM2jcqO2GGIPYVIsQvgc97J323ImWYS0wveEwLoSqEGX+?=
 =?us-ascii?Q?yzaNZ9rIjt5U/AzPD9FOJQ8EAOXxL1pIABiz7L0azd4yccYLYxcw/2mFQXZW?=
 =?us-ascii?Q?QmgWNFf1gFjT+uCrdWlsEMb3AUnHIUr8KQ9oJHv9mBO0HW5t3MTkhIV1O7J7?=
 =?us-ascii?Q?wK5fBO3hO8xyR6f/5UOznezq2T5NAx3cmX5a7QG9DDkcnGE4eZXNAIeQixr+?=
 =?us-ascii?Q?7ZEnwQBHEFgXopM3UOGSgP7YrtZCy0HYYT87QmCKX7sQA6ZRSU7NACkriMBr?=
 =?us-ascii?Q?W0XJvmxZQYVhGFSrD/0+aC/qyU+cI8PH6cAv7mrCqLoqhvtzNUzxjBnEDJNN?=
 =?us-ascii?Q?QVUlifYhKKbW8U2RGCVLLnBLiBhgwbsNVOFyRuHAMI0DqQZY50xPIv0hfPIo?=
 =?us-ascii?Q?8otT7Zskid9ELB5PauJwfw0hwK26I9jOVHE0Td7x+2OdxQk5OuCkoQoQlHKh?=
 =?us-ascii?Q?y5++ws75rKwUOVDwj8IEseMP6kVs3jmL50m3+bXu2VBtvjQYpJa6baZSMrJZ?=
 =?us-ascii?Q?Wi2G7IEuUjBQke0frcUdG4bBT0HXL/5HhLL9/lbs+8xXoG9Tc8pjJS1Mnx7Q?=
 =?us-ascii?Q?EIj9bWe51kbd6axL832eUT2lz67VpB+qqJ4Up+iP0aQL2oRKRsNU5m9fSzwJ?=
 =?us-ascii?Q?PPa055TTSwH14RoB7UXNgsRJCK5UqNLeqcl19gKm2CRATVU0+WkZBS5yY2Bq?=
 =?us-ascii?Q?jguvKuRB11srranLIHxKpOq8k6VqLdY9h9aJIGdtkZNYvB3Ik+KMYsSSGz3F?=
 =?us-ascii?Q?zDcakws5CB6EwHYKPqWvzYu8o8LuJr8PGouxT4KfXaeNEUz3ndrPb5cvBdKb?=
 =?us-ascii?Q?Nk/CUg/OSansASZrfg+K35UXYWMvHT2ZeKwCRD+Pu2V8LbdC4ssGzWUK8PVL?=
 =?us-ascii?Q?RQjCE9a4bp1FstTZrW2ua8cmVuULG08F+aLTMGHidin+89/6boSxP2d1iD2T?=
 =?us-ascii?Q?jJHh9LsVli4qTx3OnQYf2zSL/amF8lVuvmG0/jdLPXWGoKgwmeX96Li0IlbB?=
 =?us-ascii?Q?RGLjzi5l5k9s4F3m4a7Q32jv3O9xd3D/LzoXLkNRIyCvCXIo3Eik+My8IAe8?=
 =?us-ascii?Q?vvTpWB9XsE/9q3qG3yDDC3OY7xfc2psX12nI/ZQ29lzMGGCb/V+rahJyU5nz?=
 =?us-ascii?Q?bz1UShfgBWIfhoSFy0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45d3d0d2-5034-4bc2-8634-08dd21625816
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2024 01:54:02.4475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cce9gk5eVXymO6RilcHXOu/KXtLtHt1HvxwIgx9AU+vOUHm8WJ9dT+ymK5PbjDNNXMWoB68IH2SO6LUznEbbrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

> On 12/20, Wei Fang wrote:
> > The Tx metadata test has been broken since the commit d5e726d9143c
> ("xsk:
> > Require XDP_UMEM_TX_METADATA_LEN to actuate tx_metadata_len").
> Because
> > this change requires XDP_UMEM_TX_METADATA_LEN flag to be set,
> > otherwise xsk_buff_pool::tx_metadata_len will be initialized to 0,
> > which means that the driver cannot get Tx metadata and cannot execute
> > AF_XDP Tx metadata hooks.
> >
> > Fixes: d5e726d9143c ("xsk: Require XDP_UMEM_TX_METADATA_LEN to
> actuate
> > tx_metadata_len")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
>=20
> Thanks for the patch, but it should have been fixed recently in:

Oh, I was not aware of that the same patch had been applied to
bpf-next tree, thanks for reminder.


