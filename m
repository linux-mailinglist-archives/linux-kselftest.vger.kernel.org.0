Return-Path: <linux-kselftest+bounces-48919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44060D1E3A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 11:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 809D330055A1
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Jan 2026 10:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD12396B8A;
	Wed, 14 Jan 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="mTkoAvc0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010029.outbound.protection.outlook.com [52.101.69.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26BD393DC2;
	Wed, 14 Jan 2026 10:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387897; cv=fail; b=GgKUFtYqWRDpGpscXA6pp4hod/MaN7CaiKJARDKOtNNpVMsmA1WQTvKNMMpKTT5Xpht2MZzSdxLVVWN2RGJ4lu4Dyw93o1Ja/I6YVFyUku33OX7m0U056Pi9K8aa6kFlOcpFMNi3IZqZ0q2UjwIEi2wF20xHZdL1JsEW40k5lzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387897; c=relaxed/simple;
	bh=2QYFSaueUCwmHCZ5CfDD7lArPKnnOaoEAy04Zwz6lY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AeHO4CK41ffLAsxhKB00zOvLE1Ty8AxcLDZk7eiXklrFpSpPbaziOf7n43B3bkvss7b2U5Ym8a3jBObzGWnqVcgp17G4GsnyHNvzsLEvVn1DQYJ+2Av2PN7+1GX7O8mCgo+1/kHKCAFjG0uDlZP0kXr1tTQ8dW32CxQ/UGqf94A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=mTkoAvc0; arc=fail smtp.client-ip=52.101.69.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2U7IlOkU14XhQyFyU7zAxz7piGjKyLCEqmaMT8HILWh6hpfPoNvU/JB0JztRzX6hv7pg1l/rF7u2nUQleadV3+k1E7yW6uJg+knr7Ai79lSf/rphysKnhlARVlLjCvKEs2zD/kuJlpSH0sG3vUrVF18ty/BCslYKtOYO+W2l+v1qKBoxj5fcdsoS/X0xddt5xTiyHbPOduQt/ded1UdJySv50J1RWenD6fiuJ8m6/76KSUMizPXODqgmOtzt/zaWF/mVPP5/os/JmwOXUFFzJ3hACR4l2VUYMvfOC3JSBRxIbvjVHfyhscrFj8zXh1VWpz8K3CFPPUUENvz4EhwWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QYFSaueUCwmHCZ5CfDD7lArPKnnOaoEAy04Zwz6lY4=;
 b=EeRuSNQtryiicJ6wQcYJbWwzVibO6FjQWb2AiBWYtzX5MBmLBvhax16e3c1BLp06p0Dxf+oD+3QrRrrVxqe1PwQVUP07gsTtaId44Pv4zNpFytDn3BztabnJxY+kS7eE0CZYYodNLsS1CHqPYqYrzxO8dCcRVejUu0tLWhrLoSF3FpL3qwxuGyjEOdcGG4nDWQ3o4y1ANU7r8QXfQDM8rPYnew8H304A4x7Je6Uac3WqZ9sDFlwWj0X/CSD4T4ZqpLC38I/aRdKXu4ppEH3zvw7wIeAKWHPle8cpoZhThtenbNL2WhB9oeyiHjutAiBZwiRC8GD9TuOd5+hDewejOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QYFSaueUCwmHCZ5CfDD7lArPKnnOaoEAy04Zwz6lY4=;
 b=mTkoAvc0OQewAUm7XZH6bD1kK2zf+50hNjw0fDLOSWfbMcjDjmghoFyPexFMT3rc05JY3xBCEAx7t/l+SxtoKfCmGQK5DsasQYfeFbE9SVk3P5++w7SymuOcbRL0zJ338RFvrL3iTEuLVk5rNywmPqB4TkzNnYx3tYMAsLOFvqYqmwT1zIqCCiEEjZQ1hqN6RcH5IrgZb/WsHkE3zfLt08ifk+NSFwZAi2lvF8tCmCT44w6jwccFqBu53AxzaAEMexveEyqZCETF9nnANQalRcYds/MFbo3kUAhzijRGGb4x7iOThmTzJWGGV0DNPscthps+JmFex5qpePpRT5wgnw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB11220.eurprd07.prod.outlook.com (2603:10a6:10:607::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 10:49:46 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 10:49:46 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
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
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, "Koen De
 Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire
	<cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel
	<vidhi_goel@apple.com>, Willem de Bruijn <willemb@google.com>
Subject: RE: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Thread-Topic: [PATCH net-next 1/1] selftests/net: Add packetdrill packetdrill
 cases
Thread-Index: AQHcgLegOXymg0Ec9k+0aqtx9yIf/LVI3+eAgAik+TA=
Date: Wed, 14 Jan 2026 10:49:46 +0000
Message-ID:
 <PAXPR07MB7984F8BDC1261BD144D20DCFA38FA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
In-Reply-To:
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB11220:EE_
x-ms-office365-filtering-correlation-id: 03d159f5-547a-4c03-818f-08de535aa235
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?eUc3U25rNHJmQ2prZXd3QytvRi9oMXJkUTJXeXIvRGJxUXZYc3dtbGlQVkhh?=
 =?utf-8?B?ZzlzSTJNSnhtUmFXbzZUWWlQajJ2VjljODJENURETlI4bmtPMEdXY1BYd3BS?=
 =?utf-8?B?M3Vrak5JaDlCNk1KdDlDenhFa3dka2ltSkh3cUdxTitVb1VoWSswZUIrd2Qz?=
 =?utf-8?B?OWpDUHdNcklmKzNzdzlHWkFWMUpqM3lHZEo1T3JrZlcvWXQvMUlrSzdBaXd2?=
 =?utf-8?B?cjhhd3RXb2JYRjBBVnVmQ3I1M1R6b1ZWMVlqWm5KazNJUkJqclJGcjR2SkxL?=
 =?utf-8?B?bHhqOXk1RHlRMHRQdHRnRStQemg1b3dyOHRLTmI5MXdCdTJEWm5ScVJOam0w?=
 =?utf-8?B?bk1Wc1YveXlCdmpGUnNPQlFaOFlRdTlyRFA1ZmtYK1dDV0FlU1Vqdy8rTXBz?=
 =?utf-8?B?OXlJdGZJbnpZZG5pN3Btay9KSVdRYnVwS01DRnVxZmllV0xsa21IWkZUazUz?=
 =?utf-8?B?M2dHWWY3NnV3eDVCemhTUGtOWFVtQlNzRjNQTEJMUlJDS2I1dUljMVlnNk5w?=
 =?utf-8?B?R3hEVEF2dmg3TmdreHlZRkcwUVU3OGoweWJqNS9DWHdKL0czZ3VsanIybm9r?=
 =?utf-8?B?cUsvVUIxZk9nVGRVVVRnbllXQWxIRE5OUGtnRENaYVlpTVJZRUplSEgxYldp?=
 =?utf-8?B?OGtrdWZISHIrdnRvWXFkU2RsZzFOM2pYUi9NaEhubnNlOEZBK1I2UFl1bWtZ?=
 =?utf-8?B?Ynk0QytPMWVyV0RZQjhaSTVuaHFiajQyUTd0dmdLZ1pTbmF0aE1pZlRpTE1u?=
 =?utf-8?B?TWQ3dW5EMGh3NUVyY2N0cDl4K3RzcFdUVU93NTdHZUozMzdvRmdoRWs2UGdM?=
 =?utf-8?B?UUJFVmkrOUdkeEw3SWY5SUNyVUhJbzdpdDdzdk4xZmF0T2dNODlzMnhwQzdk?=
 =?utf-8?B?RStidVVSTzArcTFLL0ZPOTQxdjBXZFdKV21iQjA3UTJuY1Q5S3VzWXJDOTVT?=
 =?utf-8?B?YVpZYjRJZ2hpVEdUY2wxeGFsQ3ovN2FwQm9iRzFGSC9VQm1HVzlESkdnU2RX?=
 =?utf-8?B?MTR4cWMzd1R0cjFmTG8xb0ErdWtCSnhFSmdIZ2lKY1U0MG8vRW43UmgwelNE?=
 =?utf-8?B?eFQ5YWx5WjFtYmFOZU1oTmRLWWlMSXZqQmZrdnhMc1Mza1JubCtNcU51YzRv?=
 =?utf-8?B?VTM1ZFVSd0k2WlV4YTdvZ3ZaVktsT3VLMzFRQ1ByV21YeGt1RTZLK0UvRXli?=
 =?utf-8?B?Q05CbUVOWHdoRElVS0FlVTNEWStzUW5xMGJqRDVVWFNiL28xRVlJNk5JUHUr?=
 =?utf-8?B?VFJJeE5tMkg0MENUcmxIckN1WUczQTdkK3d0dFF1NWVTL0ZIOXpONUxlTGxu?=
 =?utf-8?B?Z1hadnNRdEtOSlYzOFpWVysvZ1NIOWdBSkE0VDhaYXUzUXp2RnFHTXFoanQv?=
 =?utf-8?B?ck5DUGhHd0drczRZRnVhZzNHTjByTG5sQXRPUkw0QTAyZGdMTXFjZ0JTRWVR?=
 =?utf-8?B?NjNrVWt4WkFubUdoSzNkSWV6WCsySTFLNEc3L1RoQTUrU3NnYUhhY2NaL29P?=
 =?utf-8?B?V3ZmSkx3bDljSTFaMjNNcTFTUFdqOXNVL1lRSmZjcjVJMnBzZnZpMHdDMXNK?=
 =?utf-8?B?d0RnV3k1elNIY0VjMDhMRmtBNUNqR2tkc3BTRVlFUjF4Rm1KSXBPb1ZCWm9v?=
 =?utf-8?B?YWJHbks2WlRmZm5QblJ4SnpyUExGbXdvWTZSUktyZmwxY2Z1YzZCRkhFWmt5?=
 =?utf-8?B?aE5rWjVZVm85UzNuL3ZOZjdLRkpxWXFZckRvQW1CQTg5YjZHTVJTQVJ2YkI3?=
 =?utf-8?B?QVRNK0gwaEdsbCtINkpGNmZ5bDZuNjZqbEd2OGgxTU8xcEI2WEVza3FCSWIx?=
 =?utf-8?B?T2VORjZsUDBWaVJTWHU4WitTcWdBWjY1ZmI5bHArRjNHWFhLcFpSbERtQXhR?=
 =?utf-8?B?YmVSbDlYUHY0VUxtaEdXNXJnVDhrOHdyOXZsQVZ1ak9XUXJzT0xSZnNiNWZa?=
 =?utf-8?B?L3NTRVpZN3d2Vk9BZkhOTG1Zd2EraXVzRTB5cS9Za3duT3NERmdBek9rL0lh?=
 =?utf-8?B?T09uZUhVZG1sU29LQTA1bEowMm5NRng1dmxCemg2T0twaktOVXBZV2w2dk5j?=
 =?utf-8?B?RkRLbmRLTTRycHV6eGdoSTdGQVk4YzY5cy9qQ3EzRGZyVW9HK1hVWkU0LzNJ?=
 =?utf-8?B?M1BaT24rRDNEU095VlVDdW5lem4rTEYycHAyeURCem9NaVo5bmVOL1c3WU1r?=
 =?utf-8?Q?cFT5xXmLurEbnXV6vY7iR98=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SGFUZThEZkF6dVQrRExNdDBGZTdVZzd6eiszK0NwdnVBd0JLN0EvdUV6d2Y0?=
 =?utf-8?B?RHc1M3p1MndFQmJsYWtIaXlpWmVOYm55V2hHdFJ6QTJVV2V0RGt0NVJaRGNh?=
 =?utf-8?B?VkRjd29LMWVsV0FBR2tmVmVtcmdXZzY5Unpad0ZCNVVvUEY5SlJkRkk2eUNp?=
 =?utf-8?B?RGxacnN4S1ZqREVkODVFM1BrbUZYd0JCbHRuM3h3L2ZiaXpGOThmTDV6cjB5?=
 =?utf-8?B?dmI1Y3dBTldGc3lFbXh0bmhVb0gvWUJDYk1WaklJUUFoTVpMQ0FwaU9ma3ls?=
 =?utf-8?B?aVUzNHlXbWxaS2tuSThYRFM1ZDN5ejBkU1VVbmpXbUdKdG1aM0FEd1lEUUEr?=
 =?utf-8?B?UkFFVUJLNUdnVzkwUFRkQ1UyRmhnN2ZSVXgwSVRIL05jRnhyb2ZvbVZJOWZu?=
 =?utf-8?B?OGd0WXpvZDJPQmFadFVidjBKK0QwdGs4ZUxKdmluTVRhcnJ3T3gxQTVxRk5j?=
 =?utf-8?B?L2M5QlIrRlZPcVVsR3FVNjNXM3dBYUhkaDJZZU1UV21JZlU5V2pBbEkzOHY2?=
 =?utf-8?B?OUdDWHF3a1lHZ1I5NVJTWk9YUTM1R3ZaNGJ1Q1hha0FFSXEvN0lNWDJYZlZZ?=
 =?utf-8?B?NWIwWWZCVkdPMVJvb2E4QmFxS2c0QzNHaS9Qa3h2ZHNIUUlDUGdHQkt0ZVBF?=
 =?utf-8?B?R1Z3MjJIZnF3K2tzVUU3UzFyM2hTSGo4YU1RSW1YekI2M2tXSDBJSEpsWGFG?=
 =?utf-8?B?WldqaHUreWxRMy9QZk9HeldsS3FSc0pwSFVxaW9kYmZxOUoyb3d5LzdvUEdL?=
 =?utf-8?B?bmEwQ3hQbHVicHhtZEk3RkNqUnZUUlprVkNmWHlzWGp3Vkk0ZE1qdjhMSFpk?=
 =?utf-8?B?VzI1TCtmTjF2WGpyd1Awc2xlM2JzTXVnVnFrT3ZzekMvMktFSVROb3JpVWJs?=
 =?utf-8?B?VElaOWR2TlJ1dXZWS1NHQVNGSmpUbG9DRTJyZ0sxUTF5WUg4dW0yaDB0cG9O?=
 =?utf-8?B?cVYxY3JNOC9CRVVsR0l4QVViRTVRUGh0UjRTR2FLdncxdEtkSy9FVFUyS3ov?=
 =?utf-8?B?V0RXOVZyeW01VVNZMS9IOTJpbEZybTVVK1l6Y0E2bmFENFlQbFdGcTRyMlZM?=
 =?utf-8?B?eXFsaGRXYXRiNDZYWFFPNWZCREU4a2paRkppQjNZdmZkK0hIZEFzMzRUTTY1?=
 =?utf-8?B?RVpveGJpZ0ZBMm9VYXJReVBGZHN2UXBieG1hbGwxTHNYdnZqbWU1YVVZaTBU?=
 =?utf-8?B?OUdoMk5vRXZQQlk1QTFYMS80K3RLNVpvVlhmZDVkVUxYL1JpKy9kUU44OTlz?=
 =?utf-8?B?b0Y0RDM3OVlrZDlXNytOQTNBNXJreFZpeWtPempZeVhkT1lDR3Vwd1l6L0lO?=
 =?utf-8?B?TSsvczlHdDJ0MDVUZHFwOWZKVHRlMzNLM1FxQ1UwZk1ERng0VmpDTGVLclA1?=
 =?utf-8?B?MlhrY0dFSTFRNlpLZGpkRHJwYTBNajUrQ0F6NUcvVXRTOHdUZ1l2WEtRMEZz?=
 =?utf-8?B?Ui9TaTVraFN4STJXZ1QwQU1pcVUya3JZaE9mSHBndWJDNmh4Skk3bzJyUnlo?=
 =?utf-8?B?aWtYMktEZTdLVHVMQktuZzhVTXJ0TUl0VXdoUENsczdHeWM3MXlXN1FKZGNv?=
 =?utf-8?B?S214OVlqRjIyZWtiQlZSOFdtUUdMMUdwK0hyQ2RJV1FkR3doTlhUVjVZMERr?=
 =?utf-8?B?TEpDakdMTFNyN0RpMHhSMWUrcGhnZXNwblB6Tzl0ZGl2cE9nZy9yM0JRdGZw?=
 =?utf-8?B?Y1E3ZndBYU1oS1NGVy9HVjVRNU1LUWhoTS9KQzV5ZHRIYk9iREw0UU02V0h3?=
 =?utf-8?B?a3JwYnpubmJ2MVd4RGpBNndqMW5LeUNpT2paV0NkckJEeGRGelNhbWVNZVdJ?=
 =?utf-8?B?bmdYM1VnQWZablVCZ0gyaHFBQnRHMUJaNGZjOStVVUhmdEM2Q2tOdGJNN3hm?=
 =?utf-8?B?UnVvK1cwT25WYzJUNERnQjMwa2hDdlBoMURyMzE3WTdoamdpZnFsUnFuMUd5?=
 =?utf-8?B?Q1JubDR6UVMwRUthMmV1ZlFNK0k0MFdEeUVRUW1maG10Nk00akwwMTljTGFB?=
 =?utf-8?B?RkJjREFkWUl3bVVWRzZNOXZzdEIwdERSNTc5QmRucFZLK01VdkQrSWczMGtR?=
 =?utf-8?B?ay9heGNpYWZGTU5KcFBWc2pjN0ViVUgyMWlPZUxQY01CczFlOW1hS1dvMUpZ?=
 =?utf-8?B?citBTWJHdnJqS0MwR3E3OFZwMEZoMjZJVEFUcFQ5ZHBZZnVWZVJpZTlXVVFa?=
 =?utf-8?B?RlNNZ0pKKzZlQkhkejBybGxlYVNCNkErcWdaOXNrdWFPRzRRaGp1Q1ZLTlRK?=
 =?utf-8?B?dDhQRHZkRmxGSWRrSUFwRVo3M0c0eHNJYWhnSEZLMjh4cUcyRm4wTXpqV2w1?=
 =?utf-8?B?TEswczl6UE1DellSeUpoRDhRWXdmUll4UVdEcWpSditIRHM5YU5LVjQ3bEhP?=
 =?utf-8?Q?8NDtK8TTeP6yLQ3M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d159f5-547a-4c03-818f-08de535aa235
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 10:49:46.6276
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bsv49kca7KyX+ldmy3nxiQUYHy3xvcLLggjBtWiZhf6cGj95ch45LcVXBzydSfHCfTDOHqL8RP2+C/+p4etNv3WBWvld52R0fBjs+7NAN4lT67lA/OE/QYy5mvAUg89s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB11220

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4gDQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDgsIDIwMjYgMTE6
NDcgUE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1i
ZWxsLWxhYnMuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5jb207IGVkdW1hemV0QGdvb2dsZS5j
b207IHBhcmF2QG52aWRpYS5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBs
d24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29n
bGUuY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZl
LnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBo
ZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVz
bnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9u
YWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5j
b207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlq
QGtlcm5lbC5vcmc7IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBu
b2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9o
YW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNo
aXJlIDxjaGVzaGlyZUBhcHBsZS5jb20+OyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29k
QGNvbWNhc3QuY29tOyBWaWRoaSBHb2VsIDx2aWRoaV9nb2VsQGFwcGxlLmNvbT47IFdpbGxlbSBk
ZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQt
bmV4dCAxLzFdIHNlbGZ0ZXN0cy9uZXQ6IEFkZCBwYWNrZXRkcmlsbCBwYWNrZXRkcmlsbCBjYXNl
cw0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBi
ZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRz
LiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiAN
Cj4gDQo+IA0KPiBPbiBUaHUsIEphbiA4LCAyMDI2IGF0IDEwOjU44oCvQU0gPGNoaWEteXUuY2hh
bmdAbm9raWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENo
YW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBMaW51eCBB
Y2N1cmF0ZSBFQ04gdGVzdCBzZXRzIHVzaW5nIEFDRSBjb3VudGVycyBhbmQgQWNjRUNOIG9wdGlv
bnMgdG8gDQo+ID4gY292ZXIgc2V2ZXJhbCBzY2VuYXJpb3M6IENvbm5lY3Rpb24gdGVhcmRvd24s
IGRpZmZlcmVudCBBQ0sgDQo+ID4gY29uZGl0aW9ucywgY291bnRlciB3cmFwcGluZywgU0FDSyBz
cGFjZSBncmFiYmluZywgZmFsbGJhY2sgc2NoZW1lcywgDQo+ID4gbmVnb3RpYXRpb24gcmV0cmFu
c21pc3Npb24vcmVvcmRlci9sb3NzLCBBY2NFQ04gb3B0aW9uIGRyb3AvbG9zcywgDQo+ID4gZGlm
ZmVyZW50IGhhbmRzaGFrZSByZWZsZWN0b3JzLCBkYXRhIHdpdGggbWFya2luZywgYW5kIGRpZmZl
cmVudCBzeXNjdGwgdmFsdWVzLg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBJbHBvIErDpHJ2
aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8
aWpAa2VybmVsLm9yZz4NCj4gPiBDby1kZXZlbG9wZWQtYnk6IE5lYWwgQ2FyZHdlbGwgPG5jYXJk
d2VsbEBnb29nbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IE5lYWwgQ2FyZHdlbGwgPG5jYXJk
d2VsbEBnb29nbGUuY29tPg0KPiA+IC0tLQ0KPiANCj4gQ2hpYS1ZdSwgdGhhbmsgeW91IGZvciBw
b3N0aW5nIHRoZSBwYWNrZXRkcmlsbCB0ZXN0cy4NCj4gDQo+IEEgY291cGxlIHRob3VnaHRzOg0K
PiANCj4gKDEpIFRoZXNlIHRlc3RzIGFyZSB1c2luZyB0aGUgZXhwZXJpbWVudGFsIEFjY0VDTiBw
YWNrZXRkcmlsbCBzdXBwb3J0IHRoYXQgaXMgbm90IGluIG1haW5saW5lIHBhY2tldGRyaWxsIHll
dC4gQ2FuIHlvdSBwbGVhc2Ugc2hhcmUgdGhlIGdpdGh1YiBVUkwgZm9yIHRoZSB2ZXJzaW9uIG9m
IHBhY2tldGRyaWxsIHlvdSB1c2VkPyBJIHdpbGwgd29yayBvbiBtZXJnaW5nIHRoZSBhcHByb3By
aWF0ZSBleHBlcmltZW50YWwgQWNjRUNOIHBhY2tldGRyaWxsIHN1cHBvcnQgaW50byB0aGUgR29v
Z2xlIHBhY2tldGRyaWxsIG1haW5saW5lIGJyYW5jaC4NCj4gDQo+ICgyKSBUaGUgbGFzdCBJIGhl
YXJkLCB0aGUgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3BhY2tldGRyaWxsLw0KPiBpbmZy
YXN0cnVjdHVyZSBkb2VzIG5vdCBydW4gdGVzdHMgaW4gc3ViZGlyZWN0b3JpZXMgb2YgdGhhdCBw
YWNrZXRkcmlsbC8gZGlyZWN0b3J5LCBhbmQgdGhhdCBpcyB3aHkgYWxsIHRoZSB0ZXN0cyBpbiB0
b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJpbGwvIGFyZSBpbiBhIHNpbmdsZSBk
aXJlY3RvcnkuDQo+IFdoZW4geW91IHJ1biB0aGVzZSB0ZXN0cywgZG8gYWxsIHRoZSB0ZXN0cyBh
Y3R1YWxseSBnZXQgcnVuPyBKdXN0IHdhbnRlZCB0byBjaGVjayB0aGlzLiA6LSkNCj4gDQo+IFRo
YW5rcyENCj4gbmVhbA0KDQpIaSBOZWFsLA0KDQpSZWdhcmRzICgyKSwgSSB3aWxsIHB1dCBhbGwg
QUNDRUNOIGNhc2VzIGluIHRoZSB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvcGFja2V0ZHJp
bGwvDQpCdXQgSSB3b3VsZCBsaWtlIHRvIGluY2x1ZGUgYW5vdGhlciBzY3JpcHQgdG8gYXZvaWQg
cnVubmluZyB0aGVzZSBBY2NFQ04gdGVzdHMgb25lLWJ5LW9uZSBtYW51YWxseSwgZG9lcyBpdCBt
YWtlIHNlbnNlIHRvIHlvdT8NClRoYW5rcy4NCg0KQ2hpYS1ZdQ0K

