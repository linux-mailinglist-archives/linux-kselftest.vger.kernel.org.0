Return-Path: <linux-kselftest+bounces-43558-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7986BF2198
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 17:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BDD5188FA43
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12315266EFC;
	Mon, 20 Oct 2025 15:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="qRHv1TVO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FD823E33D;
	Mon, 20 Oct 2025 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974005; cv=fail; b=UzFR+L9uOv14d6wsXjLU5Nic+V95gB3Tmw6kGOyDBDsudPPiZq2pv8gu+S9odMUjs7BbwcoEF/0y83+xv2NuMK2Li65uSNoTf2QvHBCjEbFI/BGOhyqnkGsWUmP8+kLqI/YtVzrsoionFf2iRkIxoqdHCjQWyiSdrQmozoR/C6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974005; c=relaxed/simple;
	bh=lGF6VlYQ2mS5PUlTXTaPBo3xg9970LBZnXDNIemfJLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jk4IzI7ZUnXFkNZ937LdHFJl2O0XPZroXfEN1gzq9zvqUy6R7WZSrhg3wNNaxxz/pc9zyOMdMDzGcT1WFJgcE9Vx86gkaas4eJb0Y/LkytyIJYBXJ/pl4oQJakf0V14o6jLVr5OhRIRvkQe01s3UYaMqRMsjdSGDlZ+OJw1WS3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=qRHv1TVO; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OqWy1gCPwCKP8Ht3rEPR12XHbR958RFRpgKv7hWYVNMZu0BKJ6fxcRmkU/w7apRQFatQc2lm5kTniotaxm8x89RHJZ85SKFkgUyJ59ajadInkl2eWI1QR4b4JibUIpvUoM5FKsn42gTCkQXR4hwYcteoQcJLW053uwnNh0p1g0zyutCwyZpR84NnFGuMhaYHXf6HA5oymWFzUgpZ6gqMa3sHc1uSpl/5EMF9RxQ2yjuT9Khzh4IEVHaNOtQcvGnOgXx+9jwVXC3mKaOCDUToFgG+8i2EwIHPU/Z8cuT9i4PE/yr7ojFdzo5m5dpPRNVuLi6PlmZA6v/vReYXQQTomw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lGF6VlYQ2mS5PUlTXTaPBo3xg9970LBZnXDNIemfJLE=;
 b=HMzCNORLNFGDNhWeP0z9oxLRme0Fp3TufkZazhQKZRviEd3CjzIkcGIMZNgi7AEE0PNEbYIAYa1//ADPgRlameT6r+UAr4DrLlvHeAupq7+SXrCTZ6Ij4+vPLJHpbucMk2kUopGJi0GvMv3r6G2keUpLfBeQlB5kQRz2RR7v+ytGHHt2+7yfgeIFqwOO3O6O+YGSTHyOUa6rjhPWqkEMQNMYaxf0JY3tFfTW1kc3979EclTuFFx+pBnLY0mkQ3lC57RSPxqbI1vm7SnMyWqIb0TZR3krXSiTqgkldCmnRsZPlcqOJryvG3uJcf1UmgLO4bYCNOdXODKly1j9snG0KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lGF6VlYQ2mS5PUlTXTaPBo3xg9970LBZnXDNIemfJLE=;
 b=qRHv1TVO+QL7BwdREIoEYkJIN5bWqm+Ky4kJSkLeU3U00aWokQRj+z4Xqt0craUERtNH0JaJ1z8AKOjvFMMZlSTk2ZYBqmFTj2pENmE8b9ffsWmN0CfxuyTiX/v7ube5/MYqA6PmAdhUgXtpditMua0NJJt1Drb3KY4X10Eu2s+11s5qPVl10vXlOcnzxgVMDv4BuwVJOyl8Bj9J+QYnzUFF5Kdw5vrn4+V308oQWMG1XiUPdiNuTigmL0TKHE/lBPTZsnIjgF5PTGWIj6n2+4L7ZAMKAK/NM9HUIDJP8+npEWNBrjd0LhcaOZ/C2WeFb7+M7JOc/6b4oi6ls7Ysxw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB8916.eurprd07.prod.outlook.com (2603:10a6:102:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 15:26:38 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 15:26:38 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ij@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "edumazet@google.com" <edumazet@google.com>, "linux-doc@vger.kernel.org"
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
	<linux-kselftest@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
Thread-Topic: [PATCH v4 net-next 02/13] gro: flushing when CWR is set
 negatively affects AccECN
Thread-Index: AQHcPGNXbBwtXLsf+UCUrmd3vsiJYbTEgoEAgAC7KICABfJyUA==
Date: Mon, 20 Oct 2025 15:26:38 +0000
Message-ID:
 <PAXPR07MB7984DB68F2D9E7468D839BEFA3F5A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com>
 <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
 <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
In-Reply-To: <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB8916:EE_
x-ms-office365-filtering-correlation-id: 4b7ce4cc-7cd9-4f42-ad39-08de0fed0ff6
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?WUJIOHBuREhJTTUzRXhEWlFhUWY2K2dhZ3JsZE91anl0eURqY2pHanl4UmYy?=
 =?utf-8?B?THAxcGxFaUZHdHBtTFBIbnBtdC9Kb0tPdmh2QnBGL1ljZlFlUU9ZQjN4ZzFG?=
 =?utf-8?B?dHliWVcrVFdXSXc2QUJwaFNLL3ZPVXBnQjZHdlFmRVpuVzZDd0d2UFlQRDl5?=
 =?utf-8?B?ZHlWblByMmxNcmVMLzNWNCsrNXU3aGJGNEVvejJVa0xMWWhGT2lqMjJ0QkpI?=
 =?utf-8?B?KzRhRVdGUml1SUppSmRZODVvazRvaWIvODdBT1lpb0tNckljMlcrUFhVTEtO?=
 =?utf-8?B?YU51Q2ozb3VKVTZBWmxWTXFESEdsYXZGVUNicWk3Q2daaXh0Yk1DTU1qeXQy?=
 =?utf-8?B?ZWpYeDU0NE8yZ1Yvem01OVBFSk9NUHFCUEVQZGJRRmY5a1EzZ1M2MDNKN1py?=
 =?utf-8?B?b25zRkdUZXNsd0tzMklMY3VXYkkrU2lzNkpRN1pxWHB0QW11TEJkQThLN09t?=
 =?utf-8?B?TnFBY1ZIQmgvZ3ZiSWFxTTdNbVMyckhmNUgxMnY5cm96S3R2b2xFMjQxT2tS?=
 =?utf-8?B?VTh6RWduaWxIYWw5Y3RaV0hrSVA0eVI3SHpTZHkrejlTMnNTRmw3c09YaU8x?=
 =?utf-8?B?TklsbUUzWUUxYTRZbzFNWUt0cjJjMXdUcjVvNzhQbm16dVgyRnRTV2hIWDlP?=
 =?utf-8?B?UllLdHB3Y1dpTkVNcFZpaXhRbWU3U1RaTHNab3FKb2lLekJpeGpaUkNqWVd0?=
 =?utf-8?B?UzdsZDF4REpuaHd1Uzk3MFIySWp2MFRZNGJPdzVuL2w1R3dQWklzdU1ZN2ZH?=
 =?utf-8?B?b001NGNFSkVpcjh4azErSXlvTEdydUdlL2JwQkxSU0wwWWJXOGVqOGZ4ZEQz?=
 =?utf-8?B?d1dmZC96b1E1WmYvdXlaZEVrYm00RS9SeExiTUhMS1RNT1VCeFQrRTZKeU42?=
 =?utf-8?B?S2x6MDRmRSs1OEtrUTdvNVVXR1dzVS9SVGs3dTV5UVYrZDNQeTQyemxuWmlP?=
 =?utf-8?B?YnphT3k5OTVlZEd4L1BNVEk3RWlKMjZwUU04cTFqbGJhaWRaKzM0MzU4anNS?=
 =?utf-8?B?eWtCQVk1ZFNMWlFYamFrZEIrZ2oyd2hqZk1xZEQ0VTVqUGF2NVhaQm9YWlI4?=
 =?utf-8?B?UjMxcDJkV2FidzdqM0VRS1pZZXpFbXF5UjZHNnUzRklHWmFUMkdvejFLckk1?=
 =?utf-8?B?Z0hQQnpIdmxWMTRqMDhXcFRaTktwanNhNUhLRkdSdSt4dGRoak4wbm1vSnNV?=
 =?utf-8?B?UmV1RkpEVGcrVVE4TldwY1I0WXRzZTNWbmhuS3Z2MHlFN0RNVURXc0dYSFls?=
 =?utf-8?B?R0NWZ2grUTF3cHhxOC9lMzlGN3NBVElyOERIWnVtT1VDRXU1RjQ3QjFzT2dv?=
 =?utf-8?B?RVZDem1kdzR5UEFLQXhoNEpPOFhFd2QycDM1MU81SGFCUlZsSHBRM1gwZEI4?=
 =?utf-8?B?RlU3OWNkV1ZRbDFJUUtXNFBMMUVsaHRwVVB2WFNOVDNSZXdQZlUrWnpUQ3Jp?=
 =?utf-8?B?QUh5Ni9EaVp1Z3Q2aEQrbUxVZHZzNW9kUmJzWU04M2RLZkxxOGhQSEdtWWlP?=
 =?utf-8?B?Q2FlZVZEWkx4TjNyY01TOW5OMXlxbzdFTEt5eVFZdmpEK2xHNEpCT0xIem9v?=
 =?utf-8?B?QWkwUnk2UjRwYVJBS2dzZEFzVnp5SmNLR2tuZ3dPdWRZdm1OZDd5bHR0MUxT?=
 =?utf-8?B?dlRBWjRHS0tjWEN0Vk8wMWZ0S0Fhb3cxZEVnM3N4Q09mK2loemNhNVZYbkFl?=
 =?utf-8?B?ckN0SytYQ3IxcnEzNUpwZHQzVDRQRDFzQnBrdmtpZmQxS1RrTDlzbzdkdnhK?=
 =?utf-8?B?UVQwaTZSbEFCejlYN2diaHJjWURmRXVIUU8yNHEwTHkzR24vV3cxcWg1bkF0?=
 =?utf-8?B?UzJaV3hCTkxLaXNoRGtzMGhvSng1WjhDOTk2NUFLQzNZcjdFaDQ3TTVqT1dX?=
 =?utf-8?B?Tm9oUVZDNmJaYXVVVGlCSnNUdnZFdThReTdCWDhtL2tjZk16THN4WkRodTZW?=
 =?utf-8?B?OGk0ZUlWa2ZJRVQvWnZCZDRxbmZGMDROODlOYnYzalJNWnVlUW5pNzlNeGUx?=
 =?utf-8?B?MmpPbTV2RmZFU1k1TXUzenVNQzNZK3FKVDRiMkwzbjR6L0dBNGp2eklOWHoz?=
 =?utf-8?Q?OsXqem?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVoycnZUNWFQWTArQ2t5aDEzajhOalNSR2RSZHh0YWMyYnB5ZGR4VHhwVklF?=
 =?utf-8?B?cEQ4VEN0eW1KbkpBUnMxTHh1OFl4VVZ1MUFnRGd0NThOTGpWUXFkWlgzMFZN?=
 =?utf-8?B?RURZMjVwVTZuUEZYd1htVmRVcTZYejhHbHVZcStjTTZYcU9leEdsM3JIakVT?=
 =?utf-8?B?TXIwNXhkaWxZY2pXZWVsOFZjT2M5M2loR3VSRnA4Y3ZFSFFJdVd2ODlnLzJH?=
 =?utf-8?B?N3FOTXp4WFcrNVlscEkrZER3V3psSjRjTjFSSEhlS1M4ckNUUWRHNDRZdlZO?=
 =?utf-8?B?eW1IdGFpWUxuZDA5bWNjaldndnR3L0hPSVJvcHRRVDErWHlmbTR5dzZaTzNz?=
 =?utf-8?B?OHB4WEVHUE1rc2YzNlhxbzdES1ZrVHU4ZG1QS29rNWxxT3FNME5ia2JVcDdi?=
 =?utf-8?B?QmpKdHkzZFUxdzdndWRDclNSU1N0OUo4N0ppdnkxd29wdVgxRmxKUmVLTXZP?=
 =?utf-8?B?Q0tlZG5PYWN2cFVMSjlVMExJTEszbmZsZjB0ckR0VzFtOUIzdmFGTlQ4Yzlk?=
 =?utf-8?B?R0tUbUpEaHVRL2VaY3lOZ2l4a0UyUHJzMGYwWEZ0bEY2MmpqRitVbHFlM3Fa?=
 =?utf-8?B?bDRiZHRGWERSUG4vZGtsYlRpTWcvQXlZMHVvSklrWmZuVXdlOXV4WEJTUzVi?=
 =?utf-8?B?R3hnM2ZaaTBpOC9pSzR6NFlQRjlyaUJTSjh6Wm9taXFmdG8xMGNuMXNmMit3?=
 =?utf-8?B?aXpKYW11VkdkbGRLVHY5YzlpK1VXdmNTMWJrMlRvYUhwZHcxdzF3TStVYUlj?=
 =?utf-8?B?VG93NS91UWZ3M2Qzd3pzRndqR0c5aXo0KzczeE9zRHpEbmYzZWJSZTVTcWM4?=
 =?utf-8?B?aXRWT1l4TlllREkrME0raHAxeXVHa2lHbHVPdDRVc09kWCtkVittdXlGcjNE?=
 =?utf-8?B?RXNIWHQ5a2JPNlVFVy9HZDUvVG5vWWdHZWpyY2VSVWo5cWxUYWs0Q1c0SG5z?=
 =?utf-8?B?elVYQ3R3UzlYSUFBMEFuVHZRTElqS0E5MXlLWFQzN3ZVbDBTUWo5WFpJQmNT?=
 =?utf-8?B?QXJGQ3J3Z1dLa1NyazVhVE1JWkQ0T0VDM2syUVJaaXE1aUMvbW5zRXllOXBp?=
 =?utf-8?B?V0FYdEN1TVpucitzWm5zZVQvU1ovd0tEdFUxR3hiOFpjSFRQTS9KZWVWYmRx?=
 =?utf-8?B?TktzSTJoaUNiU1IzZ1RmQkRtUVlSTEg1S2FsbXN5amFNTFFpRkNhVlZhSHd3?=
 =?utf-8?B?Ymd6QU9ydjEwSzJtaXhVS1FGcENQUHB2Qyt4VWUyTFhWTTlRS1Erc0hCM3dG?=
 =?utf-8?B?U0gyeUVWbHR6SWhXcXg2VUZCR1N1WDR1OXdBVkU3bzdaWHhnRUdVcmluUlkx?=
 =?utf-8?B?TzlNR2JoU2xuWHZFcm5Zb282QVJTNmIyOWEzL3c0aDNjWXdETnMxU01yMTVr?=
 =?utf-8?B?Tkl5anZKNlZvdm0xRExpUFVzVkVYc2JCdVpzdFN5bGJ4YW5CTE5PQXlvU01K?=
 =?utf-8?B?d1FsMXJLaHhOY2NkMnBaK2NBWXIySTRXejJuODRuTkhDamZlb1ppSzZ0Tm9h?=
 =?utf-8?B?Qng0OTBCZmlETUtJTS82VVMyV0NESGtSblpqMUYrcVQ2TExrOVE3dnBnU3pr?=
 =?utf-8?B?eHhZNWxSdENVNVh0R29zUXNKVzhNUVZTZlVVUVR1WWQ0SmRoQU5jOXh3dzlk?=
 =?utf-8?B?U2hjTzJ6RWVrVGRLL2tiWXdObHJOanRVd2crVjJ6Vm42QktsWXZVbThFYytW?=
 =?utf-8?B?Y2VWSXQrTndueTZKV01Xa0tWd0d6eVhQSENTUVZJZmlvU1F3MUxqQ0ozV3lX?=
 =?utf-8?B?R0xvaUgvM3AzTjBQNHpBYlMrMWg5cG05dGVoc3paN29jR2ZmbDk5dHVIYjZG?=
 =?utf-8?B?VUQ5REZuNkxOSGxoMTQ4Zm1MR0g2ZmZZcHJOSloyUVJrdkhUb29qZ1QycmNp?=
 =?utf-8?B?ZVprWGphZnNzbjFLbEpHYUV3SWkyaGxjbnNyVlhBbVlFbjNaenU5ZHhRWVFx?=
 =?utf-8?B?QlZKd251U2h4dGVKS05nVEFUbWZUaWxVS2hyN09Ld0Q5U2pLWGhQWkhVTzVT?=
 =?utf-8?B?Njlna2lvMi91Y3lyN3VVVVYxeGZQTDNDbElCRUlrNVQrSFYwSm9oaTNUMzRr?=
 =?utf-8?B?djFBbWdrYTFYTHNNdWxJNXdaWVA2T2Z2Z3pjeG9QdFM0OEF4SFM0NkJ3Tk9R?=
 =?utf-8?B?L3VBalBuYk4wTHhjQlJCbDROak83QXVmdlYrYUJWUHF4c0NuQ3JzSnVGMVh0?=
 =?utf-8?B?UlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7ce4cc-7cd9-4f42-ad39-08de0fed0ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 15:26:38.2639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KUWDcr2rb7MPzlQPc7oH2Y3TnCG7K1htXtatvq8V0YZUDzsmY4BqRkJQivu6pxNCjiI9k2EzZt2V4z3d2jRdlEGL3NwIbUWjRJBZf9PbXeWY0Y9/s149B1984mcAgmZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8916

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWpA
a2VybmVsLm9yZz4gDQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDE2LCAyMDI1IDEwOjI3IFBN
DQo+IFRvOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+DQo+IENjOiBDaGlhLVl1IENo
YW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT47IGVkdW1hemV0
QGdvb2dsZS5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBo
b3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6b24uY29tOyBi
cGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21h
aWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29y
a3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7
IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRl
ckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFo
QGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IG5jYXJkd2VsbEBn
b29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9r
aWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFu
c3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGly
ZSA8Y2hlc2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBj
b21jYXN0LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0ggdjQgbmV0LW5leHQgMDIvMTNdIGdybzogZmx1c2hpbmcgd2hlbiBDV1IgaXMg
c2V0IG5lZ2F0aXZlbHkgYWZmZWN0cyBBY2NFQ04NCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlz
IGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcg
bGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gVGh1LCAxNiBPY3QgMjAy
NSwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+ID4gT24gMTAvMTMvMjUgNzowMyBQTSwgY2hpYS15dS5j
aGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+ID4gRnJvbTogSWxwbyBKw6Rydmlu
ZW4gPGlqQGtlcm5lbC5vcmc+DQo+ID4gPg0KPiA+ID4gQXMgQWNjRUNOIG1heSBrZWVwIENXUiBi
aXQgYXNzZXJ0ZWQgZHVlIHRvIGRpZmZlcmVudCBpbnRlcnByZXRhdGlvbiANCj4gPiA+IG9mIHRo
ZSBiaXQsIGZsdXNoaW5nIHdpdGggR1JPIGJlY2F1c2Ugb2YgQ1dSIG1heSBlZmZlY3RpdmVseSBk
aXNhYmxlIA0KPiA+ID4gR1JPIHVudGlsIEFjY0VDTiBjb3VudGVyIGZpZWxkIGNoYW5nZXMgc3Vj
aCB0aGF0IENXUi1iaXQgYmVjb21lcyAwLg0KPiA+ID4NCj4gPiA+IFRoZXJlIGlzIG5vIGhhcm0g
ZG9uZSBmcm9tIG5vdCBpbW1lZGlhdGVseSBmb3J3YXJkaW5nIHRoZSBDV1InZWQgDQo+ID4gPiBz
ZWdtZW50IHdpdGggUkZDMzE2OCBFQ04uDQo+ID4NCj4gPiBJIGd1ZXNzIHRoaXMgY2hhbmdlIGNv
dWxkIGludHJvZHVjZSBhZGRpdGlvbmFsIGxhdGVuY3kgZm9yIFJGQzMxNjggDQo+ID4gbm90aWZp
Y2F0aW9uLCB3aGljaCBzb3VuZHMgbm90IGdvb2QuDQo+ID4NCj4gPiBARXJpYzogV0RZVD8NCj4g
DQo+IEknbSBub3QgRXJpYyBidXQgSSB3YW50IHRvIGFkZCBJIGZvcmVzYXcgc29tZWJvZHkgbWFr
aW5nIHRoaXMgYXJndW1lbnQgYW5kIHRodXMgd2FudGVkIHRvIG5vdCBoaWRlIHRoaXMgY2hhbmdl
IGludG8gc29tZSBvdGhlciBwYXRjaCBzbyBpdCBjYW4gYmUgcHJvcGVybHkgZGlzY3Vzc2VkIGFu
ZCByZWplY3RlZCBpZiBzbyBwcmVmZXJyZWQsIGVpdGhlciB3YXkgaXQncyBub3QgYSBjb3JyZWN0
bmVzcyBpc3N1ZS4NCj4gDQo+IEkgYWdyZWUgaXQncyBwb3NzaWJsZSBmb3Igc29tZSBkZWxheSBi
ZSBhZGRlZCBidXQgdGhlIHF1ZXN0aW9uIGlzIHdoeSB3b3VsZCB0aGF0IG1hdHRlcj8gIkNXUiIg
dGVsbHMgc2VuZGVyIGRpZCBhbHJlYWR5IHJlZHVjZSBpdHMgc2VuZGluZyByYXRlIHdoaWNoIGlz
IHdoZXJlIGNvbmdlc3Rpb24gY29udHJvbCBhaW1zIHRvLiBTbyB0aGUgcmVhY3Rpb24gdG8gY29u
Z2VzdGlvbiBpcyBhbHJlYWR5IGRvbmUgd2hlbiBHUk8gc2VlcyBDV1IgKHNvbWUgbWlnaHQgaGF2
ZSBhIG1pc2NvbmNlcHRpb24gdGhhdCBkZWxpdmVyaW5nIENXUiBjYXVzZXMgc2VuZGVyIHRvIHJl
ZHVjZSBzZW5kaW5nIHJhdGUgYnV0IHRoYXQncyBub3QgdGhlIGNhc2UpLiBXaXRoIFJGQyAzMTY4
IEVDTiwgQ1dSIG9ubHkgdGVsbHMgdGhlIHJlY2VpdmluZyBlbmQgdG8gc3RvcCBzZW5kaW5nIEVD
RS4gV2h5IGRvZXMgaXQgbWF0dGVyIGlmIHRoYXQgaW5mb3JtYXRpb24gYXJyaXZlcyBhIGJpdCBs
YXRlcj8NCj4gDQo+IElmIHRoZXJlIGFyZSBvdGhlciBzZWdtZW50cywgdGhleSBub3JtYWxseSBk
b24ndCBoYXZlIENXUiB3aXRoIFJGQyAzMTY4IEVDTiB3aGljaCBub3JtYWxseSBzZXQgQ1dSIG9u
Y2UgcGVyIFJUVC4gQSBub24tQ1dSJ2VkIHNlZ21lbnQgcmVzdWx0cyBpbiBmbHVzaCBhZnRlciBh
biBpbnRlci1wYWNrZXQgZGVsYXkgZHVlIHRvIGZsYWdzIGRpZmZlcmVuY2UuIFRoYXQgZGVsYXkg
aXMgbm90aGluZyBjb21wYXJlZCB0byBHUk8gYWdncmVnYXRpbmcgbm9uLUNXUiBzZWdtZW50cyBl
biBtYXNzZSB3aGljaCBpcyBpbiBuIHRpbWVzIHRoZSBpbnRlci1wYWNrZXQgZGVsYXkgKHNpbXBs
aWZpY2F0aW9uLCBpZ25vcmVzIGJ1cnN0aW5lc3MsIGV0Yy4pLg0KPiANCj4gSWYgdGhlcmUgYXJl
IG5vIG90aGVyIHNlZ21lbnRzLCB0aGUgcmVjZWl2ZXIgd29uJ3QgYmUgc2VuZGluZyBhbnkgRUNF
cyBlaXRoZXIsIHNvIHRoZSBleHRyYSBkZWxheSBkb2VzIG5vdCBzZWVtIHRoYXQgaW1wYWN0ZnVs
Lg0KPiANCj4gU29tZSBtaWdodCBhcmd1ZSB0aGF0IHdpdGggdGhpcyAic3BlY2lhbCBkZWxpdmVy
eSIgZm9yIENXUiB0aGUgc2VnbWVudCBjb3VsZCB0cmlnZ2VyIGFuIEFDSyAic29vbmVyIiwgYnV0
IEdSTyBzaG91bGRuJ3QgaG9sZCB0aGUgc2VnbWVudCBmb3JldmVyIGVpdGhlciAodGhvdWdoIEkg
ZG9uJ3QgcmVjYWxsIHRoZSBkZXRhaWxzIGFueW1vcmUpLiBCdXQgaWYgd2UgbWFrZSB0aGF0IGFy
Z3VtZW50ICh3aGljaCBpcyBubyBsb25nZXIgRUNOIHNpZ25hbGxpbmcgcmVsYXRlZCBhdCBhbGws
IEJUVyksIHdoeSB1c2UgR1JPIGF0IGFsbCBhcyBpdCBhZGQgZGVsYXkgZm9yIG90aGVyIHNlZ21l
bnRzIHRvbyBkZWxheWluZyBvdGhlciBBQ0tzLCB3aHkgaXMgdGhpcyBDV1InZWQgc2VnbWVudCBz
byBzcGVjaWFsIHRoYXQgaXQgaW4gcGFydGljdWxhciBtdXN0IGVsaWNpdCBBQ0sgQVNBUD8gSXQn
cyBoYXJkIHRvIGp1c3RpZnkgdGhhdCBkaXN0aW5jdGlvbi9DV1Igc3BlY2lhbGl0eSwgdW5sZXNz
IG9uZSBoYXMgdGhhdCBtaXNjb25jZXB0aW9uIENXUiBtdXN0IGFycml2ZSBBU0FQIHRvIGV4cGVk
aXRlIGNvbmdlc3Rpb24gcmVhY3Rpb24gd2hpY2ggaXMgYmFzZWQgb24gbWlzdW5kZXJzdGFuZGlu
ZyBob3cgUkZDIDMxNjggRUNOIHdvcmtzLg0KPiANCj4gVGh1cywgd2hhdCBJIHdyb3RlIHRvIHRo
ZSBjaGFuZ2Vsb2cgYWJvdXQgdGhlIGRlbGF5IG5vdCBiZWluZyBoYXJtZnVsIHNlZW1zIHdlbGwg
anVzdGlmaWVkLg0KPiANCj4gPiBPbiB0aGUgZmxpcCBzaWRlIGFkZGluZyB0b28gbXVjaA0KPiA+
IEFjY0VDTiBsb2dpYyB0byBHUk8gKGkuZS4gdG8gYWxsb3cgYWdncmVnYXRpb24gb25seSBmb3Ig
QWNjRUNOIGVuYWJsZWQNCj4gPiBmbG93cykgbG9va3Mgb3ZlcmtpbGwuDQo+IA0KPiBUaGUgdXN1
YWwgYWdncmVnYXRpb24gd29ya3Mgb24gaGVhZGVyIGJpdHMgcmVtYWluaW5nIGlkZW50aWNhbCB3
aGljaCBqdXN0IGhhcHBlbnMgdG8gYWxzbyBzdWl0IEFjY0VDTiBiZXR0ZXIgaGVyZS4gVGhlIFJG
QyAzMTY4IENXUiB0cmlja2VyeSBpcyB3aGF0IGlzIGFuIGV4cGVjdGlvbiB0byB0aGUgcnVsZSwg
YW5kIGFzIGV4cGxhaW5lZCBhYm92ZSwgaXQgZG9lcyBub3Qgc2VlbSBldmVuIHRoYXQgdXNlZnVs
Lg0KPiANCj4gVGhpcyBDV1Igc3BlY2lhbCBkZWxpdmVyeSBydWxlLCBvbiB0aGUgb3RoZXIgaGFu
ZCwgaXMgY2xlYXJseSBoYXJtZnVsIGZvciBhZ2dyZWdhdGluZyBBY2NFQ04gc2VnbWVudHMgd2hp
Y2ggbWF5IGhhdmUgbG9uZyByb3cgb2YgQ1dSIGZsYWdnZWQgc2VnbWVudHMgaWYgQUNFIGZpZWxk
IHJlbWFpbnMgdW5jaGFuZ2luZy4gTm9uZSBvZiB0aGVtIGNhbiBiZSBhZ2dyZWdhdGVkIGJ5IEdS
TyBpZiB0aGlzIHBhcnRpY3VsYXIgY2hhbmdlIGlzIG5vdCBhY2NlcHRlZC4gTm90IGFuIGVuZCBv
ZiB0aGUgd29ybGQgYnV0IGlmIHdlIHdlaWdodCB0aGUgcHJvcyBhbmQgY29ucywgaXQgc2VlbXMg
dG8gY2xlYXJseSBmYXZvciBub3Qga2VlcGluZyB0aGlzIHNwZWNpYWwgZGVsaXZlcnkgcnVsZS4N
Cg0KSGkgUGFvbG8sDQoNCkkgYWdyZWUgd2l0aCB3aGF0IHdhcyBtZW50aW9uZWQgYnkgSWxwbyBh
Ym92ZS4NCg0KQnV0IGlmIEVyaWMgY2FuIHNoYXJlIGV4dHJhIGNvbW1lbnRzIG9yIHNvbWUgcGFy
dGljdWxhciBjYXNlcyB3b3VsZCBiZSBoZWxwZnVsLg0KDQpTaGFsbCB3ZSBzdWJtaXQgYWxsIHBh
dGNoZXMgd2l0aCBjaGFuZ2VzIChhbmQga2VlcCB0aGlzIHBhdGNoIHVuY2hhbmdlZCk/IE9yIHBs
ZWFzZSBzdWdnZXN0IG90aGVyIHdheXMgdG8gbW92ZSBmb3J3YXJkLg0KDQpDaGlhLVl1DQo=

