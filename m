Return-Path: <linux-kselftest+bounces-36770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E469AFD853
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 22:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 403FE5435A6
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Jul 2025 20:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211B0248872;
	Tue,  8 Jul 2025 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Np+y7BtI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011005.outbound.protection.outlook.com [52.101.65.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4C2459F8;
	Tue,  8 Jul 2025 20:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006149; cv=fail; b=lMzXCInkiwbV2q3HjEia23XZJCQNKnBaNiMJh8nOq3saybd0oiXfU0qCRJxZIprc99/XxoKCR8swkyQobs2UKas0gQxAtBuzGvLRJTmfaSSzOB5y0aFGeGM2pkvMJ5EEj8d0q8E+udDnCvYBVU3TC44Bkas+j5Tgw+4IKKuHMFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006149; c=relaxed/simple;
	bh=izHIyFUnvE6psxKT1cLFhqcK6gqgHvwv1Z0/VZIJj1Y=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LmNwY1HtKjD+ctrsHQXX7mNmmUx6rv4Jhb7+RZJKwgz9nCoWic/rTrm3aI5NXCU2aRaECKHj5ujj8VQgGndNu9Sasdjt3XzJqdouG0TN/Nm84M/i+MknVcHBQY0+qfxQ457MIj+GwhtBYWMLCzMbUjwWANHm5DIxS78Y+frIpAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Np+y7BtI; arc=fail smtp.client-ip=52.101.65.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rkPxc+Bn29NPsTdwFpJMwqwt4ue8mmOyQCllw9uEyv8LU90Ro9SU7P8ThdF2pIPw9ZQmtUDMOqrQ5IOe0RCe8KK+iQR5UQ0FAkgL8I8vcbA/Cv7zvNODcOO3WbhpthuVwUOdKWX0owKMTmQ/QKaF6kyOSeMU02HwuCewLnXPhm99ai+cspJSYTCRILExOPeIy453YBe4XGAY/2XFun+s53O+A2Sfmw8CMvef/WjxBEhMzlhurmn+7p+76eQ3DuME2VTnVWO61joCdfLZmk6fqQinUHnkuS08QEpTNQ17AUA9TAFsviJQ0uc8nlFOaOUAfOGoRqEf8ZSZ+KeMmXLwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=izHIyFUnvE6psxKT1cLFhqcK6gqgHvwv1Z0/VZIJj1Y=;
 b=Y7o11jqAS/SMN3RQUOHySapsmL09rqITjkcIpTdcRWU78+w1z0g8m9SinK1F7ph7sSThlJUjx8nwoniMuyoDouAE/DE9zfWXMewI896DvViJmVg/rBUezMMfKf8jafo+BgbEYedtzI9y5QZLRe/XTHLLh9FleCfJgulTu9fhucNmGgn4HBSWVR6Go2y5HYThKoKICRrrhxY75peLyHxgWFvPyYPiCMCKbFpHr+tcBcn8l2ugDgtic2R598sNF0H+eh/6IygUY+tbo52K3KAgxfjZ+qbXI5UoEsVJu9TRcTp4cTVTvW4NzyvRhC1VJE1ocwDj+Dwk5vcmLkEhfYT/VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=izHIyFUnvE6psxKT1cLFhqcK6gqgHvwv1Z0/VZIJj1Y=;
 b=Np+y7BtI5IImm9uzVNOxft4hvXVv9l6t6BiujDyoYsQx3oelIhhxpe6UzjHVS4ENRW9kMBpH4GIy1T8cRfEpYUdZ8Nek2PhaxYJfGEl1JxtgxfF5LlhclIyB1spB5WlVTrlKUsOkLHdsf2rLiCtbZic8K8FFE9lYDA26XIV6YBkUaR5m7j0gGy+YN+DiIH5dU84BNn6voRxyHcEeNr+4Q1z9HmbcDPp98lx/F50QyqT2CLZRO3KdZN1gLpIQgq7k234H8My+rCrz7ClnCWGn5gQ1v6st/+vlSiz/L8d1E6bhYZeherBPNJ37nKILvJzerWb2Z0Ibg/Sx0pglIacGHA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA3PR07MB10671.eurprd07.prod.outlook.com (2603:10a6:102:4ac::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 20:22:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 20:22:23 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "pctammela@mojatatu.com"
	<pctammela@mojatatu.com>, "horms@kernel.org" <horms@kernel.org>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "xandfury@gmail.com"
	<xandfury@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dave.taht@gmail.com" <dave.taht@gmail.com>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@fiberby.net" <ast@fiberby.net>,
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
Subject: RE: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Topic: [PATCH v21 net-next 1/6] sched: Struct definition and parsing of
 dualpi2 qdisc
Thread-Index: AQHb6wFfiA0/kvNCkESHJ9jIHTxQzrQoEEmAgACltMA=
Date: Tue, 8 Jul 2025 20:22:23 +0000
Message-ID:
 <PAXPR07MB798488E0305080CE891E8286A34EA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250702032817.13274-1-chia-yu.chang@nokia-bell-labs.com>
 <20250702032817.13274-2-chia-yu.chang@nokia-bell-labs.com>
 <13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
In-Reply-To: <13b00d4f-ad0a-409a-b9c1-0f4e195450a9@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA3PR07MB10671:EE_
x-ms-office365-filtering-correlation-id: e50c13b4-055f-4526-7091-08ddbe5d2610
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2xtTmxKTnRLUndZUnpUWVhrcFRNRTdxZHpvMmc2aEh2NEttZW1weGthSFdM?=
 =?utf-8?B?em5WMHl5UkYwUkwwRG1KcmVxc0tuVGFvSHh6bStVYnp4c2dwMEJVUm8xRFZp?=
 =?utf-8?B?N2JvcjREQlFQWHJwYzJ4U05ENS95bUgwVjdwcU1MdkZZODkzSlVSRkI4Y3Zv?=
 =?utf-8?B?aElkN2s1UHBtK2YyNUNZWVlVWUUwdS9KMVNacXA3LzVkTWhKV2lVL1ErVkFn?=
 =?utf-8?B?bmFTQUJ5eE1JL09SM081cm9IaitVdHdNOFBEaHlPbFFvOVVBZFE0djF1S3Qx?=
 =?utf-8?B?N2lSMU9jRjgxeCtaMmN4SmFhTU1WeGo2Rm5heHN5VloyZmFYcVRLMUhtRkZj?=
 =?utf-8?B?dlhtL29lOW93UXBoOUg1cmxhdlh0RWlqcTA5RDQzZGZUeks0VEEyYk80T3F0?=
 =?utf-8?B?RHlqUCtPMnZrWEg5UjQvSmM5dTMybVZ3MlQrS0IzbkhQQTE4cHpYTmZZOWZD?=
 =?utf-8?B?T0tWNnp0UW5YOWE2ck1GRVJwSFJUcndYOXJjdjhoN3JhZEZ6VysxWXFuNDU5?=
 =?utf-8?B?OWh5N282TnE1U1pyRVE1M1J4eVRJR1JXMUpGMkQ1Z0NMWUw5TEdXaWdoZDJv?=
 =?utf-8?B?dDJlK3lWditUaElEcWc3NkFVZ3E4Z216eEYwcEMxY3J5NjBZYXZibS9NbGdt?=
 =?utf-8?B?WnBFc0NRMDlZR2pYemcyRnF5ZmRGZ3hUc0NFMktVQkNiL1ExeGxJMFBTRHJi?=
 =?utf-8?B?V1NZVTNWSVdEN21MTmlXSEJqMi95LzhUdVBKWmtMdWcwTTd2Um5pNHNFbDl0?=
 =?utf-8?B?SkVvMEtzOXNZM1BzTlYwNGQzVFRIbm8rMUt2TVMxazVDM2VlbVg5elc3d0Fo?=
 =?utf-8?B?TmVPNk1scVFWa0tPc0xGcnVnUjkrMUp6MTdCUkJoaC9xTE13Vy9QUHFlRmhW?=
 =?utf-8?B?b2o0aFE3WWNiRWhSbjkvL0E0ZzdBVGZZbm1sWjMxSkN1NGxudkRBbFZNZ0NF?=
 =?utf-8?B?Z0dvSUhlTmxmUjcxUzYxWU9nWllvNjl4N3QzdHIycEZtcGgvenlXaXhhS2R0?=
 =?utf-8?B?YUdHY0JSM2xHeGtuQVRMT3o5bGY2RVRsU2pUYk1NbjkvRFNrYnMzTm5MVHNw?=
 =?utf-8?B?L0FsSXVkWVRIRE5WdUdTZnE1M1UyUm5JaVY2R2FVMDVpakJqaW1tOGtoR3Z5?=
 =?utf-8?B?ZmN3L2FMQk1mdFV5ZE5pNjBPY2p4YjMyczZhaVFKTWhQbzdDRzJzZTFscUs2?=
 =?utf-8?B?RDI1NGR4cE5oaHhLKzI0aXFabUN2YmxDVUFXdEVRSERzTG1EcDZEdTBKQkRu?=
 =?utf-8?B?enE2RTNIZ2xxUHNIRGZUZjEyREd5L2t1KzF5cjNBRmcwVXFQMkJ2ZUNpR0t0?=
 =?utf-8?B?a05BRlk4dW8xTndwUTNrUlg3QmpSbExxTm01d0pLMFl2M0psWmNmdG4yUHhp?=
 =?utf-8?B?SmFESmlJOFVXYVE3ZVowQUhlQWtlNGF4SFMvSUFScW02WCsxSEp1UnM3d1pa?=
 =?utf-8?B?cHpxVURJVEZKcUVCYWVCbHc2RElpS1BBY1NwM2tIYmM4OFVPKzZmTlhBcmlO?=
 =?utf-8?B?c3Q1djNHV1NZSDJxY0ZqVmZNcWRwV2JsOGhhbGVJWHlYbmpvWWFuWldqdVFo?=
 =?utf-8?B?YnRnamptbGExdW1lQ1BHZS9kMkhNKzFWd0l6Mk42MlZjWUxpb1dhdDVMY25U?=
 =?utf-8?B?MVBVSmJOUHgvTHc3aUM1OWgyamJHWTU4d28wU3JJNlRWNTREWjIzQ2dwMy93?=
 =?utf-8?B?WFZxSDRhY29XM3NGMFVHRDFFUFZyY2VUN1F3ekIzUUxLQTloWTZwNFJ4b1dN?=
 =?utf-8?B?TXl4dlV1NUhpcEpNODNvZGsreTQ1ZXFVUEJXMFZydUlLYVZuUXZhdzRMb2pZ?=
 =?utf-8?B?aEhzTDl4MzQ1czBlTFBybFIrVENiRmYvRVpxVUpwcTg0OWhHSUlJRmFaMU1E?=
 =?utf-8?B?SXdmejhlQnhVNHIxQlR3YmRBRnpNdjRpYzA3T1pTNUVBRHNyRFlzWmx4ak81?=
 =?utf-8?B?TkpoUXBnbkZFUEpYYm9QNDBEOXJEZEcvSWhLRC83TGRLVnFTekxsUDZKc3lz?=
 =?utf-8?B?SXRUaVpDWDB4S3NTT3V0NEZzai9mRmhHVkV3eW03K3c1V29vL29Obm4xSnY3?=
 =?utf-8?Q?RkOgeT?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1FEQjlOaFpTbTF1U3Bvb3c5SkkzUmt4ZDJWaEFnRUUvT0NHWVB1K25WL2xB?=
 =?utf-8?B?dkJKWGlCWU5qKzVLY1lXZWtnK1h5akZsa2k1R2V2M3JYN0h0bFZack5heVk2?=
 =?utf-8?B?Q1o2NHNWNk1mZ2hXYW1VemQzdGkvOEJpNmZoWUhkeGFMQ0I1QWI5emlybWFz?=
 =?utf-8?B?QjJkNGRvaFJwMmt4TUJLTTZhZ3ZOYTVOZGJOc28wdUs5VmhCbnhic2lZOEpx?=
 =?utf-8?B?K01ON1FCOTNqTjZybFlUTnlPV3ZZRzZZdEhMSWZWMmlWQXRwampXdnYvS1BN?=
 =?utf-8?B?a09HRXB3V00yVGwrLzIvSWJvMFFJeXdsQXd2L2lodlFGQnNuVEsvcG84SkNy?=
 =?utf-8?B?ejV5TDM2a2RuT0FCQ2RZNkdIT3ZPU3JtQWtYUFg3VVpUNHlBbnJmdjl5Y29Y?=
 =?utf-8?B?SGVXNk9JNWJ4bFJJQ3VHcU1wOGI2WGdrbFZBNVQrZFM3dUFPbnJsYnE0TGRQ?=
 =?utf-8?B?VlhxUGQxRUg3ZlJvSzZURlQ0MWt0dldGZCtiWlZkbC9jNFdFbXIvNkN3V2Rm?=
 =?utf-8?B?UVBiVGxYZTlZV09zUUU1VHRJYWNCZ3FzTnNxbGIxVTN1RXFFVE9CZitKc0dI?=
 =?utf-8?B?RjJmWWt6R1RneEw3NWY5OTA5TllpTnNjZWdxUW42RHk1dUNRdHpIczBrM0lE?=
 =?utf-8?B?ei9MRkVkRGVXMXdDTDZxY3RXdy9LMnlpdlRKL2NtWWJHRGkzcHcyWHA3RlZ1?=
 =?utf-8?B?TFpuVnNJT0FJd3EzWEdDa1hiV2xFa1FFQkEwcERWcEF4UkxmR09HY24wVE40?=
 =?utf-8?B?dURXUEVNQ2oxN0swbmVUd054WStIdE9FNFNqVnJBYXlhUldYbm1RaGdiMHBz?=
 =?utf-8?B?SXUrckREb1hid1RNcFVJdmtwSlMzdlR1bE5YMkVHMm5KUjhvUzBsS3JvUlhr?=
 =?utf-8?B?UmtOejNOVVV5eG5CbU1Zd0xubEc3NDZzRmF4SnprUEJ2aGtneFNBMXdaYnRk?=
 =?utf-8?B?RWd4a2ZKTU1ndEVSTlAwTnd1UEhYcDl5ZFRUdFdicnlFd2IzN3pFQXZrenZY?=
 =?utf-8?B?UWloSFVXaTdvTE03TW8vTDBhdmN2UWVmUm9sZkdJRm1BS2oxSUdCUmRNMUZU?=
 =?utf-8?B?ODhQb1QrOXE2RWhQMGhtZ0lOQnNNME5GOXJCbVJFUTRPeHZoMUJ1a3ZoQ2h4?=
 =?utf-8?B?a29taW9QMkZueEd4aWY3NHl5NGtFY1dRTjBPWDAzMnhpd21rYmNwQURUdjc4?=
 =?utf-8?B?ZFZCWGpoeEdERnlYM05tR2QrcmdPRWNJbGNhWUhBOFNEUWJyZjNyWDVEM3o5?=
 =?utf-8?B?akM1RE1KRGdyN1poUklLekNqU0IybXZFV1pWaFVNdE5xWUNDL21JOFVTNzBH?=
 =?utf-8?B?cGpBaXd5SjRwam1xYXQyRzlxcXgzOXFzYkNIWVRBaWVNaC9tNHM3dU9VbDh3?=
 =?utf-8?B?VGpJSEpjdlhINDVCWExYaFdjb3ZHamUwM2tkckp0Ynk5ODJ0TTZwcy9Oa3A0?=
 =?utf-8?B?MG1hM0FsK0EwcXB6bmZEQnI4NVlFMktacldWWDJHcUk3d0pCc2RwNkFqeHVO?=
 =?utf-8?B?aEdDL3Z6YXFsb2grTWt2R01hc1NUQnZBOWFLNEtLM09XNmkzM09uZmtBSTVz?=
 =?utf-8?B?OUxDVHNQaVhveDBLL0JVWkJURXN5M09JMVppbi9NdkJRUXQrOWN5cFFzTDRB?=
 =?utf-8?B?MHlmdjN1Q1AwRFhxSjJQOVFEQjNUREFlWXNTbnZHcHRYOXFmRHlSaUh2MFkr?=
 =?utf-8?B?SFR3S0FDWitnVGVxTXJ1UENKc2hlQWQ4L25FYWFJUXY4YzJucFJ1aXZDTXV6?=
 =?utf-8?B?LzVQVW5LdmRWY0VmSmpXRnlMTkVkZjlkemNUQUtETnI4NG9wWERvZWNyREdR?=
 =?utf-8?B?ak1rdUtSVDdBQzhET2hZbVBlNzhqcjVNTXI2UHRtaFc4VFZLSXhuVXNOTXh0?=
 =?utf-8?B?cWJBR3dQd25KakNFckJ6bHFRRnRzcmtJMEZ3aTcyZExWN2o3LysrTEt2ZXph?=
 =?utf-8?B?NEdJejBnQXgralhvWHVJM09ndFNEd2VNTkp2MDhsWnVuM3h6dDhlVXN3bXp6?=
 =?utf-8?B?bXRWTEVDVTgzcHdCZkgxQ1A0dFcwOVRHaFFWbjhHcHBEZTVzL1RLZEJ5NGcw?=
 =?utf-8?B?dG5uYzdZME5qK2ZwUWxmS2VsdHhnblcrQmZERWhDZ1dRNjhHZFI0WFlabFdZ?=
 =?utf-8?B?TFdpRmVDc0Fab2lvVGVlZlN2TVY1WTl0d2FuWnA1N0dHQU4ya1pZWVRUSVFQ?=
 =?utf-8?B?SkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c13b4-055f-4526-7091-08ddbe5d2610
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 20:22:23.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PEx6MychNONY6JtB8aKOot9S/tofm3kprkNoj3mZlXVVxWusf/hmk2JbmUSSgaAfS0MxXw4bnG2jbjYuSGj5i4jFNjsXPID6FttuusJI3ow3sFrPkWVvVMbD5Ujw3YM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR07MB10671

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDgsIDIwMjUgMTI6MjkgUE0NCj4g
VG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMu
Y29tPjsgYWxvay5hLnRpd2FyaUBvcmFjbGUuY29tOyBwY3RhbW1lbGFAbW9qYXRhdHUuY29tOyBo
b3Jtc0BrZXJuZWwub3JnOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsgeGFuZGZ1cnlAZ21haWwu
Y29tOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9q
YXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4
aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9m
dC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsgYXN0QGZp
YmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhAa2VybmVsLm9yZzsgbGludXgt
a3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9yZzsgbmNhcmR3ZWxsQGdvb2ds
ZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1i
ZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29u
QGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlQGFw
cGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgdmlk
aGlfZ29lbEBhcHBsZS5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MjEgbmV0LW5leHQgMS82
XSBzY2hlZDogU3RydWN0IGRlZmluaXRpb24gYW5kIHBhcnNpbmcgb2YgZHVhbHBpMiBxZGlzYw0K
PiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2
ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBT
ZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4g
DQo+IA0KPiBPbiA3LzIvMjUgNToyOCBBTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMu
Y29tIHdyb3RlOg0KPiA+ICtzdGF0aWMgaW50IGR1YWxwaTJfY2hhbmdlKHN0cnVjdCBRZGlzYyAq
c2NoLCBzdHJ1Y3QgbmxhdHRyICpvcHQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IG5ldGxpbmtfZXh0X2FjayAqZXh0YWNrKSB7DQo+ID4gKyAgICAgc3RydWN0IG5sYXR0ciAq
dGJbVENBX0RVQUxQSTJfTUFYICsgMV07DQo+ID4gKyAgICAgc3RydWN0IGR1YWxwaTJfc2NoZWRf
ZGF0YSAqcTsNCj4gPiArICAgICBpbnQgb2xkX2JhY2tsb2c7DQo+ID4gKyAgICAgaW50IG9sZF9x
bGVuOw0KPiA+ICsgICAgIGludCBlcnI7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghb3B0KSB7DQo+
ID4gKyAgICAgICAgICAgICBOTF9TRVRfRVJSX01TR19NT0QoZXh0YWNrLCAiRHVhbHBpMiBvcHRp
b25zIGFyZSANCj4gPiArIHJldXFpcmVkIik7DQo+IA0KPiBNaW5vciBub3RlOiB0eXBvIGFib3Zl
ICgicmV1cWlyZWQiIC0+ICJyZXF1aXJlZCIpDQo+IA0KPiBNb3JlIGltcG9ydGFudGx5OiB0aGUg
YWJvdmUgaXMgaW5jb25zaXN0ZW50IHdpdGggdGhlIGJlbG93IGNvZGUsIHdoZXJlIEFGQUlDUyBp
dCdzIG5vdCBlbmZvcmNlZC9tYW5kYXRlZCB0aGUgcHJlc2VuY2Ugb2YgYW55IER1YWxwaTIgb3B0
aW9uLg0KPiANCj4gaS5lLiBVc2VyIHNwYWNlIGNvdWxkIHN1Y2Nlc3NmdWxseSBwcm92aWRlIGEg
VENBX09QVElPTlMgd2l0aCBubyBuZXN0ZWQgYXR0cmlidXRlcy4NCj4gDQo+IEFtIEkgbWlzc2lu
ZyBzb21ldGhpbmc/DQo+IA0KPiBUaGFua3MsDQo+IA0KPiBQYW9sbw0KDQpIaSBQYW9sbywNCg0K
VGhlIG9yaWdpbmFsIHBhdGNoIGxvb2tzIGxpa2UgYmVsb3csIGFuZCBJIHNlZSB0aGUgb3B0aW9u
IGlzIG1hbmRhdG9yeSBvdGhlcndpc2UgaXQgd2lsbCByZXR1cm4gLUVJTlZBTC4NCg0KSXMgdGhp
cyB3aGF0IHlvdSBtZWFuIGluIHlvdXIgY29tbWVudHMgb3IgeW91IG1lYW4gb3RoZXIgdGhpbmdz
Pw0KDQorICAgICAgIGlmICghb3B0KSB7DQorICAgICAgICAgICAgICAgTkxfU0VUX0VSUl9NU0df
TU9EKGV4dGFjaywgIkR1YWxwaTIgb3B0aW9ucyBhcmUgcmV1cWlyZWQiKTsNCisgICAgICAgICAg
ICAgICByZXR1cm4gLUVJTlZBTDsNCisgICAgICAgfQ0KDQoNCkJlc3QgcmVnYXJkcywNCkNoaWEt
WXUNCg==

