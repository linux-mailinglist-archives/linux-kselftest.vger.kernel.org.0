Return-Path: <linux-kselftest+bounces-35846-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A24FAE98C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8174316C426
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E25229290A;
	Thu, 26 Jun 2025 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="PlguareB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012003.outbound.protection.outlook.com [52.101.71.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D82153CE;
	Thu, 26 Jun 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750927529; cv=fail; b=XvkD3CMyZcD4M6SQ5o2EErH9AahKLSoJcnQhPZTGLBYaokQDGvJiDj9XSEDRXGan+bGT7AZvgUUS73dEKwxUfvzFj/mek2wwjuwB2829B0xk7ZIi/I+/qgKhMd+Y0NI0OuL5CP6Da6hBpBzcgJiiYf413D0mBHaxUKFYwdo90pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750927529; c=relaxed/simple;
	bh=L00zZWLNxipcdWAYqOiTTxiC+9pbA6oPuRy3CCVKrcY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zi+EfREovIiYb56nfEuSo29ssPQ8LEe0GXmuM9+gVUnTdmOKsKdAJqrEbi2MOKFuJibJQEkG3sFDK7Jtn5MnNfRuadXhS1KXd7YLzZ13K2hQuBXLLZaaPajSQI9X7zFluWHkzmnw08NkpFuE1ZrkP7Qyj1pVpaKF437P3+QVRDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=PlguareB; arc=fail smtp.client-ip=52.101.71.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lIlfWVRCsgJ5nmGuSqVhKJbaAAP6wvaA2tDnC5JQuwCDgu3Y88vKKJvVtkWXavrm55KOUCcS8fQV/leWBNM2BqsFkw3TTdmf38h8FiKC/HrckMF2vvlJb6XeZZ+NZOgzzVgm6Xko5ePiTz0d8sd7327orYECxUyuS9UkhAa6HlBYnRG7BARA5n+i+G1XuljKZjppQt/KmjzdBciMo+jc7us6EjvW1nCduIJC0C8PUyLw8ERx4/D204yKg49PJx3v862c0JSYDujqtYPyHZhs3bBvGRNr9qHoIGCL0dKtsMMsOMye9QFbDdfPjPBtNYwmnbGW1PMDsFPLllUHPwrTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L00zZWLNxipcdWAYqOiTTxiC+9pbA6oPuRy3CCVKrcY=;
 b=jmVqcwvAHYJrnE9hpONgk0K5sMvKeHbTrSHneSbxqj63MQ7xdeD7s+PD5NLmRVkYmVof3ON+uKWfYlu/cdYKxEfZr4pzBcRJ0MpGIMcT8dFALENHOwtC5l0lm1gz/wvGgRCxcuUtAunWapcGs1oFqCBMu51cfrfh7IVikGnuGxeN41KuugG8wJJlxbmz7vdoGYgADG4facLazYyG5tCecB8qiy46eg526CDN7+CsjdaFxD6nHwrB20RkPQ93jlSzMYg7gltr7EPkp8ka1aPpHHJVncAzJVblcZtp7UbNhyEegFQQPdqNBSr9QIorcF1udBa/kuMaTXg+lPcx4s9qSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L00zZWLNxipcdWAYqOiTTxiC+9pbA6oPuRy3CCVKrcY=;
 b=PlguareBME9KknZJriYmEk+edXMdPbsNl/PBMkSO7+ekrDmND4BCc3595DTRC8lAOCx1hCrWebamj+v+HLLTwq80DSxNkbtqUSdOOW9Pa1UETSj6cmIS4D+3QZJcWdfcOmZOFkRnrB+Q2hOsgHRlSqTzgP3toa6xP5Ez3dD0XIagb8fX39KRh7RSLLxzppZB0wLEkcIJpyTLfWA5P+gaOTbwIetWjti5PG84idhEiYZkwkXlzZFQeLj5BbeGqtyVFHUP25HoWWlkn0JVJfz7oXLUEiZzqokJRdbSnF2sHqXfgb/zG+oF9B4beOI6YQhnCTVxAIQb7ZMK6AA9lc+vSQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DU2PR07MB9507.eurprd07.prod.outlook.com (2603:10a6:10:493::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Thu, 26 Jun
 2025 08:45:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:45:23 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
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
Subject: RE: [PATCH v9 net-next 06/15] tcp: accecn: add AccECN rx byte
 counters
Thread-Topic: [PATCH v9 net-next 06/15] tcp: accecn: add AccECN rx byte
 counters
Thread-Index: AQHb4uP+74UZDn0ohkqbBMJKMTT/I7QTieOAgAGSxRA=
Date: Thu, 26 Jun 2025 08:45:23 +0000
Message-ID:
 <PAXPR07MB7984CE30212EEEF91004F894A37AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
 <20250621193737.16593-7-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKuE7gLXq5qn0PDCKOXxOZdMXXxtW1dA-D0eLjfhwApgQ@mail.gmail.com>
In-Reply-To:
 <CANn89iKuE7gLXq5qn0PDCKOXxOZdMXXxtW1dA-D0eLjfhwApgQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DU2PR07MB9507:EE_
x-ms-office365-filtering-correlation-id: 2265b84c-c374-45c9-61bb-08ddb48dca56
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OEpJK2wwQzN5Y0FQZnN0N09JWUZBNGRGcG96U2p1YzNneW9YU0RkcnNrRmVU?=
 =?utf-8?B?T1hsc2NuVkFLQWdNbUJZeVd5TmZaMFlndDV1UStMVGxpT0ZvblluL1ZmczNJ?=
 =?utf-8?B?V2dLUktlQTg5MEE0UEkvWnJjQUJ3aGltMldTMlJGUXVxcENxa25xd2wvM3Zj?=
 =?utf-8?B?NElOV0ZPS1hZK0VmRFBSTldzRi96ei8wTlNyTnYrd0FvSWFPK3VPWitEMWR0?=
 =?utf-8?B?SVhjYUlYeXhRdlpkT2Jyd24vYnpkYlJSdy9QVkd6MFFqaHVUZi9RbDZ4V3gr?=
 =?utf-8?B?Q0UvMVhzc2J4N0gxSVdnem1xR3VkUlZXRjJnRGFxdDhWWUhIWkYwcGNLaFRw?=
 =?utf-8?B?c2tZeWQ2Rm0vcFlTdlJ3MUkrV0FFVHcyRXZvcmxldm5aeWNaZlNlMGFGckc2?=
 =?utf-8?B?VkdnMnBkTlZld05COGdEZ1huTnBPQStPdElMYXhWUHgrMG1kS1ZMWWg2MUlI?=
 =?utf-8?B?cmVZYjB0Wm55OEpCRFZJUVNoYW52b2ROVk4yd2Fsc2FnV3hqNFp1MG5YSk9i?=
 =?utf-8?B?NjgzOUt6M2IxYnVmMi9SbzNUSzFHZVNKMGQ5YkhIVU9ieit0eXFZVTB6UWtM?=
 =?utf-8?B?bWpKZjgzNVd0dzk2V3BkNHJvNUdaWVI2Mzk2aEd1QWhCTUY0dzdFZGp5VVAr?=
 =?utf-8?B?ZGlLSUNpb0MxRnp3WmxZWWJzMVBrTmVHaStWSG00MWNhb0I3Q0RMbnVMejZs?=
 =?utf-8?B?L0c1MHZvWjZBUW1HMWJvRndyZlJCMW9tcGFsbDBMY1hsbk5Qd3BISHRtOFVT?=
 =?utf-8?B?UGFyMWNTM250VkJXU2hJNTgzZzNUbGZsZG1VVjlYTmpoQW9IQ3Q0cCtVUGNJ?=
 =?utf-8?B?N2lwb0I3ZmoyUDVxVEJxTVl6Q1dnTXF5MEgwT1ZzbHNEOUp0bm0rZlQ0WUFH?=
 =?utf-8?B?OGpWUnNhQXVZOHdreUlSZGdPb0I1NjI2eEVtemVRQ3JIaUMvTUZPdi8rMkVt?=
 =?utf-8?B?SVdNbkZqQUw2bUFvU1MxalhrODdLQmlOQTB6TEE4Wk5QZHJBWjFTOGliV2hi?=
 =?utf-8?B?ZFFuZm9ITmRENmI3T1dTOERBdE9KcG5OSW1KYjhsQkIyU0JCcmcwRlNJTjVa?=
 =?utf-8?B?U1pmOWpxY0tQSHlrdUxnMGpmRUV2MDg4cUhkb2FzbmtBSkdoaFBrL3VXQmJH?=
 =?utf-8?B?K3lVL0RYTHFUWERXOFRQSDM0VVUxWWtXM3ovMEVlNmFFNTBnd0hKbEgzYVJB?=
 =?utf-8?B?NkFYVlBicFRaVSswMm90Rm5rQTFKdkRBaGlmYXplL0J6OTlseTVvOEdEVGxl?=
 =?utf-8?B?QnZpcDlHWUhGZlI4dDZ2R3owalYyMUdOVXd2WjFvNVNtRlMyR3Z4UDBSQzFJ?=
 =?utf-8?B?MXVjVU1TOTFPeVExdEhEVng0MmR5SHRvaHE4c2ZTdGU1c3ZJVmZaYjdTMzZZ?=
 =?utf-8?B?UzZyWlpXSUgwWmY2M1RndERLSjNqdHdOZkh1b256ZTlkQmYvMEtXb1psZUhD?=
 =?utf-8?B?MG1CRkxFaE04aHhuL25oelpOT2w0b2hQczRFckF6ZGw1TytaUnROeE9pNlRF?=
 =?utf-8?B?WjBwUEtodFlLdWZ5b1N6ZlNsNEYyQlVYMmtjbFh2VkRuQTRpRnl2elY1ei9E?=
 =?utf-8?B?MkZmTDI2TzNyS0N0WVVBVzVjVmN1Qlc3eXczSm1zVTIvcWFvQ3JORDdVUWw3?=
 =?utf-8?B?dzN2d3lqZXpLNysvbmh4R0k2V2oxQndFWGVZdHFlOXRwcVp2OUVaaTQ2azZ5?=
 =?utf-8?B?anN2RWZONzJwR0tmb01CWW1Ea2s3Zm5SQlB3dU1KWEFQZEg5VUluYmdVZDRW?=
 =?utf-8?B?REgvVEluSzNFS0k5RGU1TWtIVG1vSXZBSFh0Wkd4ZXBnYk9sV0dkN3hnQnZ5?=
 =?utf-8?B?cEwrTkRtTWFTcU5VREZBdjdjV20xQkJZRFhGdWplL2Y3OGorSm1BVG0vc0Q3?=
 =?utf-8?B?WlNnaXUrdWFmVmwzQTNyOThaVVovQUh0c1ZoOW1yYUNBd1g3dWp6MzhSakZ4?=
 =?utf-8?B?Zk5sSXIzTGtJK0pSYUxiTTROYmdSZTBERDU1Z1lYTWtoTnB0YUdxaHdOZUt4?=
 =?utf-8?Q?xw3811iPqSK5BF5KSHoIHE8GzMoBCQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NHJCcjZERzVxblVwVlpzTzAxTmZMdjhiaWsraXpUSDNSNzBhN01JdjZWNko1?=
 =?utf-8?B?bVBzZkw2ckJ2V2o3bTlwOFpMOG9kTFQ5NzFNZzkxT3ZUalRxOFhhbWpYbW9q?=
 =?utf-8?B?UXZHU2s5YWN4UXlZd1ZHckQyZ3dMbkU1V3B4K2xaeTk5Vk5CWXo3b2dhVi85?=
 =?utf-8?B?UjdVOFBwdU9VNUdmTDhlU1JDV0RFUitHQzBjTklaNzZROUFuSnZRWENCOUtn?=
 =?utf-8?B?Z2RKdTBHbU8va2xkZFhyL0NSRUpYbzhKWU9SRDFHZjMrNmhGcktxZTdzT1Jm?=
 =?utf-8?B?SVJDNmd4OWFuaDY0SVZrUTJ2V0Y3WFp6UG9EbGF4Z09ZaE1DNXVrQUdEZFd0?=
 =?utf-8?B?ZmRTbDFUTDJub3B4eVAyZ3JlZXFkbFRjZXN6SE9lU040TzgvQkFXMU9wOFl5?=
 =?utf-8?B?U2hWbHdMS2tjN2tqYlR6d0p1MjdoWjA0MDNIUVRXbGVwM1dQZGhENmU3WXQz?=
 =?utf-8?B?NHRoeVRTRmFYWTJCODRkNUU3WDdxTzNyR3pWanZVWEU3elJrdTU0aWd2Y24y?=
 =?utf-8?B?a0ZhaUk3dXpuVUVGVVgyVHIwTVBIR2RwTDZ4bW93R3RmbjdOQjlld2pXNUpO?=
 =?utf-8?B?UkNMWlVUSmNNdGtIdkZMdWZhdXN2ZXhSYThOUVJ0enlyb3l1cDJIZFVmM1Rn?=
 =?utf-8?B?UnZUZHRuSG5xblhEeFJqdW9zT2dpekU4Y2lWdFIrUkRUTDZ5cDBmSERqeGR5?=
 =?utf-8?B?NVJHUFRFR1RzckhZc3dHL0ZMaGlTSUkvTjNjb3Z1bFY1aVZqbHZYNEpSOUR1?=
 =?utf-8?B?UFZheEIrNGVreXZvQ0hvMTRnTHAxZERvejBRY2JQYi9GWGpraEVldXlmaHFy?=
 =?utf-8?B?d29tbFNmUFpPTVo1NnBYRWtjR1dVVVZQLy9nZ1RpWk1sZ3diN3g3YldvMGxw?=
 =?utf-8?B?dithUjdaRVZuMjZXV2d4dWVrUDkvVTQrTmRIVDVqbFBFWEVJcHk5d245TG9P?=
 =?utf-8?B?WVhPL25FSzVLWTBqK2JPcVIyc29NeVNIWXFWTDRacEVJbHVjV3phck5qd2lI?=
 =?utf-8?B?dFpIQnVra2tWQzB6L2d1cmVsbVRNQUU5NGM4SVlvOCs0Nll6cXM1K0l2cVpH?=
 =?utf-8?B?MC9Ca3dHVkdwMmdjWjFYVDhtaTBVNGxiMEY4ODRmV25OcjVjL0hDS2l3c1ll?=
 =?utf-8?B?MGN1eGlEaTUvbFNYaElCRlBlZzNXZ2tnMTdGWEZCbllCbzFPRVRCQlVLMFZ6?=
 =?utf-8?B?Ky9lWksyRWU3VVlVM0JaSHB2WnhocDZFaEkwa3lHbHpkZWlPTGlsSTI2cEJw?=
 =?utf-8?B?TXkrT3JSL2NCQnAreU9YTFVEVkZPNHYrWlp0SW9STTVVMW10SG1zWHU4SkdY?=
 =?utf-8?B?eHgzNGdiWmxCOWdmWXlET0dCR0h5YklBSWJES0ZyV3hVRFZ2aEo3dzFhUk9H?=
 =?utf-8?B?RUY5Tk9nL1FpVUxVdWRyejJFcnlMajFYWWhPMC82dXZrZXU1TDlKSEVLSnY0?=
 =?utf-8?B?NzErR1ZRTkg5K1k1ci9xcHFrM1BHYi8zQW94Z2FYVVN1NjJKaDNuNGxQRVI3?=
 =?utf-8?B?N1VUK2Q0bTRzV25QZ3JWNm9LTEMwMmpoSlVsRkVNaEQxL0NiaE15bGR6ZDBR?=
 =?utf-8?B?d0ZuSGoxbnIzekVnSDh6VHcydzQ5MnZiN3gyV3dsUGx5dUhlZk9wUWZaZkdl?=
 =?utf-8?B?VGUzVkVmR2dnRGdNTEp6dm1kRGVaZ1pKcWFGaWZGS05nZmdXckZaY3FyQUFx?=
 =?utf-8?B?dFMrWFArYzhJaEE0amp1RndaM3FiclFGeXpVTTg3YlV4cGNLRW1pdUQzblNm?=
 =?utf-8?B?WDBsVEVrK2VTdzg3em1YVExVR3NwUXMrN012R0k2M00vOUhnWkZzeTdDSzRH?=
 =?utf-8?B?Y0N1TUhXK2lBRjBOSloyTG1EVk93eFExK0tJYmhDelhPdTRLMlNUQkFiSy91?=
 =?utf-8?B?SmsrZjNmY3FCdEZzcFlZYk5sMi9ZWVpUVDRJbFE4UHliQnRMSjNQUFlRNXV4?=
 =?utf-8?B?WTltTlNTckRvR09rSzVSUlNOcHZDUUU5a3k1bjhqT0FIVk5UTmUydHNPMXVF?=
 =?utf-8?B?WFVrQzBlaCtmUDcxK3FMTzkwekloYzVZVTIyeHYvRjFaQUxQd3NWUnFielg0?=
 =?utf-8?B?SmFVaWJzM0c3a0I3b2lQL3dzV0YyTWY5ZGIxc2dMRWZEeVJKNWhsTHBOalZ4?=
 =?utf-8?B?WE5PNGhKOHNEcXBRUkpDdk5rYldhS1hhOGxSZWtxUVcyNnBXb3ZGb2d1bHhM?=
 =?utf-8?B?Q1E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2265b84c-c374-45c9-61bb-08ddb48dca56
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:45:23.4018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K9aq6WXvu6jHesNo1ygOFnjVVbt4yG6H9Ck27C+l0rEnZEvVZgwnlSarcm3Xp3zGYncFPhxXvGL02nPCYI3biB6TlM90qlWLT2bOKogFqzMF2+qjDKQ8/hH+yqsRLd2K
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB9507

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjUsIDIwMjUgMTA6MDUg
QU0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5v
cmc7IGt1bml5dUBhbWF6b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtl
cm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFp
bC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRk
ZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1
aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERl
IFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47
IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207
IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmll
dGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUu
Y29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjkgbmV0LW5leHQgMDYvMTVdIHRjcDogYWNjZWNu
OiBhZGQgQWNjRUNOIHJ4IGJ5dGUgY291bnRlcnMNCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gU2F0LCBKdW4gMjEsIDIw
MjUgYXQgMTI6MzfigK9QTSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPiA+DQpb
Li4uXQ0KPiA+IC0tLSBhL25ldC9pcHY0L3RjcF9pbnB1dC5jDQo+ID4gKysrIGIvbmV0L2lwdjQv
dGNwX2lucHV0LmMNCj4gPiBAQCAtNjAxMyw4ICs2MDEzLDE3IEBAIHN0YXRpYyB2b2lkIHRjcF91
cmcoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBjb25zdCBzdHJ1Y3QgdGNw
aGRyICp0DQo+ID4gICAgICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICt2b2lkIHRjcF9lY25fcmVj
ZWl2ZWRfY291bnRlcnNfcGF5bG9hZChzdHJ1Y3Qgc29jayAqc2ssDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYikgew0K
PiA+ICsgICAgICAgY29uc3Qgc3RydWN0IHRjcGhkciAqdGggPSAoY29uc3Qgc3RydWN0IHRjcGhk
ciAqKXNrYi0+ZGF0YTsNCj4gPiArDQo+ID4gKyAgICAgICB0Y3BfZWNuX3JlY2VpdmVkX2NvdW50
ZXJzKHNrLCBza2IsIHNrYi0+bGVuIC0gdGgtPmRvZmYgKiA0KTsgfQ0KPiA+ICsNCj4gPiAgLyog
VXBkYXRlcyBBY2N1cmF0ZSBFQ04gcmVjZWl2ZWQgY291bnRlcnMgZnJvbSB0aGUgcmVjZWl2ZWQg
SVAgRUNOIA0KPiA+IGZpZWxkICovIC12b2lkIHRjcF9lY25fcmVjZWl2ZWRfY291bnRlcnMoc3Ry
dWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3QgDQo+ID4gc2tfYnVmZiAqc2tiKQ0KPiA+ICt2b2lk
IHRjcF9lY25fcmVjZWl2ZWRfY291bnRlcnMoc3RydWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgcGF5
bG9hZF9sZW4pDQo+ID4gIHsNCj4gPiAgICAgICAgIHU4IGVjbmZpZWxkID0gVENQX1NLQl9DQihz
a2IpLT5pcF9kc2ZpZWxkICYgSU5FVF9FQ05fTUFTSzsNCj4gPiAgICAgICAgIHU4IGlzX2NlID0g
SU5FVF9FQ05faXNfY2UoZWNuZmllbGQpOyBAQCAtNjAzNCw2ICs2MDQzLDkgQEAgDQo+ID4gdm9p
ZCB0Y3BfZWNuX3JlY2VpdmVkX2NvdW50ZXJzKHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3RydWN0
IHNrX2J1ZmYgKnNrYikNCj4gPiAgICAgICAgICAgICAgICAgdHAtPnJlY2VpdmVkX2NlICs9IHBj
b3VudDsNCj4gPiAgICAgICAgICAgICAgICAgdHAtPnJlY2VpdmVkX2NlX3BlbmRpbmcgPSBtaW4o
dHAtPnJlY2VpdmVkX2NlX3BlbmRpbmcgKyBwY291bnQsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4ZlUpOw0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgaWYgKHBheWxvYWRfbGVuID4gMCkNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB0
cC0+cmVjZWl2ZWRfZWNuX2J5dGVzW2VjbmZpZWxkIC0gMV0gKz0gDQo+ID4gKyBwYXlsb2FkX2xl
bjsNCj4gPiAgICAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gQEAgLTYzMDcsNyArNjMxOSw3IEBA
IHZvaWQgdGNwX3Jjdl9lc3RhYmxpc2hlZChzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBza19idWZm
ICpza2IpDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsYWcg
fD0gX190Y3BfcmVwbGFjZV90c19yZWNlbnQodHAsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+ID4g
ZGVsdGEpOw0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB0Y3BfZWNu
X3JlY2VpdmVkX2NvdW50ZXJzKHNrLCBza2IpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdGNwX2Vjbl9yZWNlaXZlZF9jb3VudGVycyhzaywgc2tiLCAwKTsNCj4gPg0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLyogV2Uga25vdyB0aGF0IHN1Y2ggcGFj
a2V0cyBhcmUgY2hlY2tzdW1tZWQNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAqIG9uIGVudHJ5Lg0KPiA+IEBAIC02MzUzLDcgKzYzNjUsOCBAQCB2b2lkIHRjcF9yY3ZfZXN0
YWJsaXNoZWQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAgICAg
ICAgICAgICAgICAgICAgICAgIC8qIEJ1bGsgZGF0YSB0cmFuc2ZlcjogcmVjZWl2ZXIgKi8NCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgICB0Y3BfY2xlYW51cF9za2Ioc2tiKTsNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICBfX3NrYl9wdWxsKHNrYiwgdGNwX2hlYWRlcl9sZW4pOw0KPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgIHRjcF9lY25fcmVjZWl2ZWRfY291bnRlcnMoc2ssIHNr
Yik7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgdGNwX2Vjbl9yZWNlaXZlZF9jb3VudGVy
cyhzaywgc2tiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbGVuIC0gDQo+ID4gKyB0Y3BfaGVhZGVyX2xlbik7DQo+ID4gICAgICAgICAgICAg
ICAgICAgICAgICAgZWF0ZW4gPSB0Y3BfcXVldWVfcmN2KHNrLCBza2IsICZmcmFnc3RvbGVuKTsN
Cj4gPg0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHRjcF9ldmVudF9kYXRhX3JlY3Yoc2ss
IHNrYik7IEBAIC02NDAwLDcgDQo+ID4gKzY0MTMsNyBAQCB2b2lkIHRjcF9yY3ZfZXN0YWJsaXNo
ZWQoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiKQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHRjcF9hY2NlY25fdGhpcmRfYWNrKHNrLCBza2IsIHRwLT5zeW5fZWN0X3Nu
dCk7DQo+ID4gICAgICAgICAgICAgICAgIHRjcF9mYXN0X3BhdGhfb24odHApOw0KPiA+ICAgICAg
ICAgfQ0KPiA+IC0gICAgICAgdGNwX2Vjbl9yZWNlaXZlZF9jb3VudGVycyhzaywgc2tiKTsNCj4g
PiArICAgICAgIHRjcF9lY25fcmVjZWl2ZWRfY291bnRlcnNfcGF5bG9hZChzaywgc2tiKTsNCj4g
DQo+IEkgbWlzc2VkIHRoaXMgZnJvbSBhIHByaW9yIHBhdGNoLCBidXQgaXMgaXQgZXhwZWN0ZWQg
dG8gYWNjb3VudCBieXRlcyBldmVuIGlmIHRoZSBwYWNrZXQgaXMgZHJvcHBlZCA/DQo+IA0KDQpI
aSBFcmljLA0KDQpXaGF0IEkga25vdyBpcyB0aGF0IHBhY2tldHMgd2lsbCBiZSBhY29vdW50ZWQg
YWZ0ZXIgdmFsaWRhdGlvbi4NCg0KU28sIGlmIG9uZSBwYWNrZXQgaXMgZGlzY2FyZGVkIGR1ZSB0
byB0Y3BfdmFsaWRhdGVfaW5jb21pbmcoKSwgaXQgd2lsbCBOT1QgYmUgY291bnRlZCBpbiB0aGUg
QWNjRUNOIGNvdW50ZXJzLg0KDQpCZXN0IHJlZ2FyZHMsDQpDaGlhLVl1DQo=

