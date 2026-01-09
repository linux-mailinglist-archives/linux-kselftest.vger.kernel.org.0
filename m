Return-Path: <linux-kselftest+bounces-48589-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFA3D07FF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 09:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C89DC3065161
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E7352FA3;
	Fri,  9 Jan 2026 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="WIb3DLBr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010018.outbound.protection.outlook.com [52.101.84.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6C4352C57;
	Fri,  9 Jan 2026 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767948803; cv=fail; b=Eh4oiVpCJQtruOgGrArRijnr22U+9gouPLPnXua3pHpjIH2+DWGq/JweajAv6gMDDISt0WTMfxGSpplTv03FUVHiyj3S4uqWgZ5BgUn3NYBf+n1qe9K1W/L5wEnkQeOgh7imUvXuC6jwgyNRm9OzYn+G8Jj0mtjJys1uv1mIJec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767948803; c=relaxed/simple;
	bh=2x3NzT22tzlY9tt34TwI55ae2v9WVPFAyjbOP1CoUuo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JK3GWg4Z09/mcSK3a9OVG2T/hO0IrxBz87izufRrCjqcog2dVhPsMRLHnf1OYERgPf1rb8A+FmXhbcwDsWGft6PGiaFEa6OmrFEyTQB6Ww8FbHOrW+eyJkhDtyr5km7P8+dw3zGpz3x6+Yjz93qFbHz1kHW4xeH3bRETHnWC6do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=WIb3DLBr; arc=fail smtp.client-ip=52.101.84.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=agoRPRhfN1oGQRQx1i7F45ueOa7L5wuPy/BXx+qWzuuQoYjn+Giqq+kEDkjNKQMLadU4wj3O6Pp7gSRY1sGfCSxTzKJ4WRnmWIeYS13hIZNNeOvNmkesbwF6Hlk8gzglByNUR4zZLsL3ahKToiNEStWcjJ8FlYZOnj+IToFe1i9vo+ID7atvmlaHIbww99/oUKMXZXL86tFOp4mTdSebOoO+u0l64PDyjct++tEPLzhRSeCk868JO9lRVsB4L83XU2KhAar1DUq3B4MeIVGZpcrhw2QmsXZdxwEBh4BsXP5R8E+JjacCS2WKEDpalzGm2UWeQy8+OAqyaQ4RENlP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x3NzT22tzlY9tt34TwI55ae2v9WVPFAyjbOP1CoUuo=;
 b=Jjqk7dqZ9irFLPOUZZ1lJOk2OU19dd+PCN8+A2SWc45Ay3NXKvyDfT1YxEE4UZr4MGu0XjMvIOFeN7mdD0CWlwqrFVHqeBKqpu+rmOBGVkHnEgxI86zoXDb887/f3xJC9Lbzeaptudo7/zN5/RYv100oZhcGA7+OCFrWFSbD1reIAeMADAr++eKPUE7zhkIWlX8i+VAyrSjjMvOpMGi0uH4qV9QohPsUNGhcEJehQ6/wP7d2vSpltohxtMqxXPO/m7yggYVp+6BzRiTg0zBp6mszu6S9vOKWvUib4Mhl2OcZWcD2Ku+9F1kKIXbJ65jLcoEVIh7UdwYjbFYduv6PEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x3NzT22tzlY9tt34TwI55ae2v9WVPFAyjbOP1CoUuo=;
 b=WIb3DLBrh5u2CVHdkJpz/AkmajqWn0sHtD+0lmrzrfiR1/TzLKSZ23FM39itZt2Z68d6yixdDCg4iM9iSvuMP0/FxZsrt1lpfpHlxf0C3aetufNP0xjwbUGFq+qZvKEYDdmw0rhwSI3UMCd5akKiY2MTCq6I3dKYVdf7B//6HlVYfyAJ5YOq+cFPn4NeIo2Au1W8FrrR78JjpT2bV38WLSngqHibejy3pvlv0La9zDq611BPNmlhUUBK+qtrU2sboC8mnGJW4tuHxymO9rcyExy+871i8pNdt30D3WBWVH/U5mXNfTVKrsfw5At/Af81hWInDyJhjytpsSvhty0Xew==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAXPR07MB8698.eurprd07.prod.outlook.com (2603:10a6:102:244::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 08:53:14 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 08:53:14 +0000
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
Thread-Index: AQHcgLegOXymg0Ec9k+0aqtx9yIf/LVI3+eAgAAJeACAAJ7fsA==
Date: Fri, 9 Jan 2026 08:53:14 +0000
Message-ID:
 <PAXPR07MB79841834F7C029BFA3D77717A382A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260108155816.36001-1-chia-yu.chang@nokia-bell-labs.com>
 <20260108155816.36001-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykTJWJf7kjxWrdYMYaeamo20JDbd_SijTejLj1ES37j7Q@mail.gmail.com>
 <CADVnQynohH4UyvyKm9rUNcCMbnepJKMwhOCPRFzM5wTvpDR1ZA@mail.gmail.com>
In-Reply-To:
 <CADVnQynohH4UyvyKm9rUNcCMbnepJKMwhOCPRFzM5wTvpDR1ZA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAXPR07MB8698:EE_
x-ms-office365-filtering-correlation-id: c759baee-6bab-4bb1-f28c-08de4f5c8644
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDdrWGNNajhEK2NGRmlHeDJNVW1iR1I5djRBSG43QUU2OFA5Ti9IbDErbXMr?=
 =?utf-8?B?RHNHKzJIazVHRkx2cHZ1S25Jd0NQL3BnRWN5cUVsdldMZmUwWnkvdElLMUhk?=
 =?utf-8?B?QkF1SEQ2cEVCWCt5Q0xDTndKY2hpT2VFYmtLcExmKzFKNGtEU2pzd1dCQ00v?=
 =?utf-8?B?TkdLY1k3Z0lKRTNaUzNDczJla2xqMEEydnQ2L3Z2RGJ5NW9MZnV3aC9ZRTFE?=
 =?utf-8?B?L290ZjZ3MVYwUHRNQy9KcGZiKzdwZFp4UzFud1ZYSTFoUmxSR0lhalBNbFV2?=
 =?utf-8?B?dGdhbkVoZEpBU1B6Y1g1SkMzWldWQkhxcWQ3ZkNIOTVOanhoZDgxMzRwbG5D?=
 =?utf-8?B?am1zckF4TE9kU0kxdjVlOFhpblBleVJHRTZqbHl0K0pNcGI1c0FNNzJaYmtN?=
 =?utf-8?B?OFdMQm9WVUg4NEtVODh4QTdZS21INjBCMC8wcHdCUGJsQUx0ZFYvK29OMktL?=
 =?utf-8?B?NXJBVnJUdDFSa2JPRDNsSzU5WGY0aEk3NnJVTitTU2pxNGFEbVAyZUZQcHl5?=
 =?utf-8?B?Y0FkeUd5VHh1NlN4Q0tXNzRkQWtlRWVEYVpubWNmNlU2R0VZVjgycS9OLzBY?=
 =?utf-8?B?bldqTXo2Y2MrNGt2bmxKRHRHVUdITGVBTEkzdDRaRTNCQWJFeEJFQWJnVzZ5?=
 =?utf-8?B?MUlkTzdPN21ROGVORzhlZTVDSHNSR2c5SUg1RlN0SXhnbllETW9NWHF2R1dV?=
 =?utf-8?B?K1lVaXhDT0hPWDJwMnE2TnMyTUZaQWw1T2hCT3YrakcvQ1BMc3lPSmhxeXdz?=
 =?utf-8?B?OUVCdDNjaVNMTk80Zk0zOVZLQStNVk5pWk5OR0NEeVp5TzEyZHlnQ1p6UktW?=
 =?utf-8?B?ZTA4YmNKQzlSaE5YWXNOMXVvSXBwU3Y2bjFCU0RvaGxQV092THI1Q0Rrdjdt?=
 =?utf-8?B?T3ZTMzI2U2ROSmNBUjcrRDZXK0VHVWdXN3JmaEg1dXl6N29oZE5hV2d0eHNB?=
 =?utf-8?B?bjNHU0I3L0VQZ1BVdTM4MmtXWDAvODU3YzhoRWZaYTZMOWcwanA5WGh2a2dw?=
 =?utf-8?B?WlBpRkJiT0ErbldodHM5YkN0SWJDQkgvcDhyZHpxWHZZZXZXUzFUQWRQYkNk?=
 =?utf-8?B?dGlzMnVDYXQzM0hFc0s3RzBkVGxoRUVYbkFJb3QyUU9YTGhqcTkvU3NRbFB4?=
 =?utf-8?B?a2gyejlzeEZCbGR3cEFsUGNvTHhzTTFyNS9ycCtMMEFmRnNJUm1sV3c2MzhG?=
 =?utf-8?B?MG4rUnhFRFRhM3p1SytXNUFLYTBnOFkvKzA4OFZBR3pScyt5b2JFWjRsMmlW?=
 =?utf-8?B?N0l5S2srcC9ENDJqQWVibkhodzM0U0xFWG1LZFVONkZpY0UxdjhObk5QZmNi?=
 =?utf-8?B?cHkwZzRMUjQxZ1NhVCs1dXJrc3hheE4zZW1MMy91MlUvb0dpVDBIY2FnU2FR?=
 =?utf-8?B?WG5oZFFWZm9YbVZxUFZjZ3VSc2lRZEpOYWhsMVNsUkxaRFdjVEY5cEdpWlJK?=
 =?utf-8?B?dEw2eWRnOUZ6R3h5amkxN3hRUlVsQXZYRUgzRERxWnpEWVVobDlSYlhEVzBv?=
 =?utf-8?B?eDBXNCtjY3I3TUUwaVZ1THJEdVdZMzNHNm5tRmEybGVIUFcyQmJWTVhTeUtw?=
 =?utf-8?B?WW9vUW91bnNoS2FLcXpCaWRLQm5XdHZ1WEFIWlNwd20wem93azMwc3ZHWWcr?=
 =?utf-8?B?enMzZTlRSmh5VXFIZG93TWRGMHJNM3dvbUk0cTJaQ3FMcDVpL0FkUkZBZXNp?=
 =?utf-8?B?RHFWZEhvVUROWW9DbjN2dXRPelRmSzMvNGdOYm9OMmUwK21xaUJTNE0yVFQz?=
 =?utf-8?B?aVRsdEh3MzlMblVMMGY1VTlJK01UbUFub0poRThaa3dhMnFxTFR0eTN4SVlh?=
 =?utf-8?B?QThLOXZkSHFSV3AzMHplT0hJU2JsRkhyL0cwU1ovZlo4c0t1dVJMM05LYkpJ?=
 =?utf-8?B?bnl2TXBIOW5QbWh1dG0xbGJSVFlKTHdMaFYrQmF0WGZFUDdLZzliRXJheHVi?=
 =?utf-8?B?ZWxNU1dMb1FWcElPUm1YR2RlTjJVN05obkJpdVN0eUgvM3NMTWw0b2NCblor?=
 =?utf-8?B?Wnd2SVdoR3UxSlVqa3lEMVI0Sm5xNkFFMFZPbnJnTTU3Ry9yYTV5S0xHUEh5?=
 =?utf-8?Q?+K1AaJ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUlabnZjOUtLdmVzcnBwYnBXYzVpMmJRNDZsNGg2M1JaTU5OZEJ5bEVEYmNz?=
 =?utf-8?B?ZDRZSU41aFNaYnZkaDlBTFdFWnVOZ2FUYlBsWTRIVWZiZDNBdVlQK1Z4M3E3?=
 =?utf-8?B?MjFPOFhHdnFySFE4TUQ2Q1BLV09XdDY3YW00cVVrWWpteE1OOGEzUEQ0Z2M4?=
 =?utf-8?B?cjN4NGNSOFIzd0YrT25LUmNYSWRsR2xZMjZadUErbmY1NXdITHJlZ3JoUi9n?=
 =?utf-8?B?TEpFMWRkT2pBWVZDak13clAzM2cvU3JUR0QzTGxCYy8yM1J3Tlp0VWZxeTFu?=
 =?utf-8?B?eWtEeFhmbUpYWnBGZ2R2YkNSRlJMMVpOWWk0V1lHTnRFd2VORnFBRDNQS2cz?=
 =?utf-8?B?K2szODh5b3I1MUdhc2kxYlp4b2dHQ3pLdTBMRHRERWg5Nmd1UmFHa2tqNGZI?=
 =?utf-8?B?SXJ4dmdnNFFOcmpvd1AwUUgzeUZTczIvSmlRclFYSlBrVmI2Wm1TU0dLWW9Y?=
 =?utf-8?B?QmpPQmZ5RG5pb0ZVVE5veE9HRDE4R25PZUpqdy9CVlJ5VVRKR1FWVFlaZ2FC?=
 =?utf-8?B?UHJ1dy92ZEpmM2RqcUFHMFpsU3ozYlByZFNzZ0RpR1ZYRk9MY2s1TjhoVDFC?=
 =?utf-8?B?cjRuRHFIb2pSRkxHampYSjRLajhGRXI1K3FKbyswUnNTa3RyNmpUSzVZR01s?=
 =?utf-8?B?SnZHb280ZXBuMXNySGIwUy9DNmNIb21MUjBDS1VaekFYM000ZDRzb29KMmxV?=
 =?utf-8?B?eXA5VXMyMHpDZjZDVk4wemhiQ2JSL211YWU0dXNkdStsQ0liNlNJZ3czM1hh?=
 =?utf-8?B?TUh4WHhEYm9RMmUzZGRpRjZUWnZ4QWhhOEFzL2QvZ0JOYUtRa1F0S3c1NWtW?=
 =?utf-8?B?T1lCcEhSKzBGL0lZdEljdVVFWGdVMzRlYU1qNzFJbFVLQXRQZDZLeXVYa1Fq?=
 =?utf-8?B?SklhMDJiVkx4bWRhNzZ4bXdNcnF6ZGVURnVwTURlTWJybituREdwZVE5WVlX?=
 =?utf-8?B?UmcrZ0dwTGVBZENWdVRFZUVaUUpUM01OdTE0SXUwY2lpRFI0WnpTNzhqcFFq?=
 =?utf-8?B?RGlaaGxwRnVWUFd1N0FWRTl0MHdiVlVEUW9DLy9uQ3daYlBBOUViS1YyWGhq?=
 =?utf-8?B?U3VUOHBjc2FoUDdndkg4bEhERmpTTEtkTUNNdWFLSmc5akk4YmdIZ3JJOUVn?=
 =?utf-8?B?SHZ0L0lQQWhlU25rUFAwNVVXbWVvRm93ckMvc1lXVnRqb2xqYmRPM25XZXV3?=
 =?utf-8?B?YlEySGF1VjRjbWR1TkZvOUJudzBHejl1ZHpPNzFPVnNucGx6U0drR2p4Qjk4?=
 =?utf-8?B?WWlRaElqZ2l6M1YzRDdSZEZpclRHTmU1enRUQkFWTFppQ1gwbXNEdHV2TktJ?=
 =?utf-8?B?WHk4bnpVQ2gvSGRrL2VWTzFFVFhyZWFCWHBoVENMQ0p6NVd6UElxMXdGSVVT?=
 =?utf-8?B?YlI3Z1R6ZUxHS1RMTEVYMzJLRmppZzZHSk1rMFZYOG1YNHhDblVIVEI3Vkxm?=
 =?utf-8?B?RnZmRlBUZWgyK3lsZFBRcmVxRUlEMkVtamtGTmozeGFvTG1Ma3VyazI2aStx?=
 =?utf-8?B?TE0yejVJRGtKV0RlR213cS9IeTA1V0dtVDhhQzc4cTlHcTk5MTk5TUxQQ1JC?=
 =?utf-8?B?b3dYNVFUNmlDdHJGM1RLdG1NNG9LYm1scUJpTlV5d0x1MXlJMVBvYVVLNms1?=
 =?utf-8?B?RlZoZEVTWldrZmRLSHZCL0gxc1NyTlZHcUIrRzZya3FyWUhYVFB3MWVzNU1i?=
 =?utf-8?B?NlVEbVlIa0l4cTVTQ2VjaCtRRysreVdVNkd0d1A5eTVaZTJNNHRZVnZGWWxB?=
 =?utf-8?B?VDdKcTNsWUtRWkt2dmpNZm9ab2E0T0lHdVIrWVR5MVV2TS9qYlpWcWZuazJV?=
 =?utf-8?B?RWNKdDhySlRzVTN0V2I3VkdRaUk4djY5ZkFjM2JjYnlkN1VKS1NaT2RsY3Ro?=
 =?utf-8?B?Y3dsMGVKUkNPK3pXZDZCRS9LK3psRHRkb1ZNVEduRms5MnFXSzE2TjJsVmlF?=
 =?utf-8?B?anpCalRSbzlWZW9kUllEa2p5YmF5MDV0eXNUWUQ4TEFhcE4xUEVpNjA0U0Fn?=
 =?utf-8?B?c0ZDTi9uZXM5TDZ2eVFaSTEwaGRhTVZPd3lEMFVIZENxREJDa0s1Tkt3Q1Fi?=
 =?utf-8?B?cmR4dGF6TUxkcGdFSFlWYW41NVVmTTgraTIzYTZ3akhTMFdLQ1pZbnNocmRX?=
 =?utf-8?B?bDI3SVgyNnI3YSt6ZXcrUzdncy9XcGVrTjF3eFNrZmFUcm80ZmZOTEM4cGgv?=
 =?utf-8?B?ZU9teFFHZS92R1VwM0xDbGxyYW0yQnM0ejg2eUdEZDVJYkp4bjFjSUxCZDFG?=
 =?utf-8?B?N2NJY0tUcG12S1lmaGRLUDhSakR3TWZ4Uk5aUnJSN1RIVC9LR0xGUGM2Y3pD?=
 =?utf-8?B?ZFAyTXpTK1ZSSlVlMjFYQUJFSDBhNTE0TVNuZ1V2bTh0aTJoRitieDRFeGw4?=
 =?utf-8?Q?zSPZNXfguzphUMMM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c759baee-6bab-4bb1-f28c-08de4f5c8644
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 08:53:14.1123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fSFJZZoJEyuvE/YN5Haii2Zrfks518jyyYZFFbP94Ammudf8beoOXveDHehdXnCVxqO8WU2IpxHAJBtZWzXIRvJNfNFd3MgKcjJItSeODu50eBVJluk4kGT5NMJFjNxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR07MB8698

LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE5lYWwgQ2FyZHdlbGwgPG5jYXJkd2Vs
bEBnb29nbGUuY29tPg0KPiBTZW50OiBGcmlkYXksIEphbnVhcnkgOSwgMjAyNiAxMjoyMSBBTQ0K
PiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFi
cy5jb20+DQo+IENjOiBwYWJlbmlAcmVkaGF0LmNvbTsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgcGFy
YXZAbnZpZGlhLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7
IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGdvb2dsZS5jb207
IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBn
bWFpbC5jb207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3
b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51
czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVu
dGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1
YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVs
Lm9yZzsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJl
bGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25A
ZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmUgPGNo
ZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2Fz
dC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPjsgV2lsbGVtIGRlIEJydWlq
biA8d2lsbGVtYkBnb29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IDEv
MV0gc2VsZnRlc3RzL25ldDogQWRkIHBhY2tldGRyaWxsIHBhY2tldGRyaWxsIGNhc2VzDQo+DQo+
DQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNh
cmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhl
IFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPg0KPg0KPg0KPiBP
biBUaHUsIEphbiA4LCAyMDI2IGF0IDU6NDbigK9QTSBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxA
Z29vZ2xlLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBUaHUsIEphbiA4LCAyMDI2IGF0IDEwOjU4
4oCvQU0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4gPg0K
PiA+ID4gRnJvbTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMu
Y29tPg0KPiA+ID4NCj4gPiA+IExpbnV4IEFjY3VyYXRlIEVDTiB0ZXN0IHNldHMgdXNpbmcgQUNF
IGNvdW50ZXJzIGFuZCBBY2NFQ04gb3B0aW9ucw0KPiA+ID4gdG8gY292ZXIgc2V2ZXJhbCBzY2Vu
YXJpb3M6IENvbm5lY3Rpb24gdGVhcmRvd24sIGRpZmZlcmVudCBBQ0sNCj4gPiA+IGNvbmRpdGlv
bnMsIGNvdW50ZXIgd3JhcHBpbmcsIFNBQ0sgc3BhY2UgZ3JhYmJpbmcsIGZhbGxiYWNrIHNjaGVt
ZXMsDQo+ID4gPiBuZWdvdGlhdGlvbiByZXRyYW5zbWlzc2lvbi9yZW9yZGVyL2xvc3MsIEFjY0VD
TiBvcHRpb24gZHJvcC9sb3NzLA0KPiA+ID4gZGlmZmVyZW50IGhhbmRzaGFrZSByZWZsZWN0b3Jz
LCBkYXRhIHdpdGggbWFya2luZywgYW5kIGRpZmZlcmVudCBzeXNjdGwgdmFsdWVzLg0KPiA+ID4N
Cj4gPiA+IENvLWRldmVsb3BlZC1ieTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5lbC5vcmc+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPiA+
IENvLWRldmVsb3BlZC1ieTogTmVhbCBDYXJkd2VsbCA8bmNhcmR3ZWxsQGdvb2dsZS5jb20+DQo+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4N
Cj4gPiA+IC0tLQ0KPiA+DQo+ID4gQ2hpYS1ZdSwgdGhhbmsgeW91IGZvciBwb3N0aW5nIHRoZSBw
YWNrZXRkcmlsbCB0ZXN0cy4NCj4gPg0KPiA+IEEgY291cGxlIHRob3VnaHRzOg0KPiA+DQo+ID4g
KDEpIFRoZXNlIHRlc3RzIGFyZSB1c2luZyB0aGUgZXhwZXJpbWVudGFsIEFjY0VDTiBwYWNrZXRk
cmlsbCBzdXBwb3J0DQo+ID4gdGhhdCBpcyBub3QgaW4gbWFpbmxpbmUgcGFja2V0ZHJpbGwgeWV0
LiBDYW4geW91IHBsZWFzZSBzaGFyZSB0aGUNCj4gPiBnaXRodWIgVVJMIGZvciB0aGUgdmVyc2lv
biBvZiBwYWNrZXRkcmlsbCB5b3UgdXNlZD8gSSB3aWxsIHdvcmsgb24NCj4gPiBtZXJnaW5nIHRo
ZSBhcHByb3ByaWF0ZSBleHBlcmltZW50YWwgQWNjRUNOIHBhY2tldGRyaWxsIHN1cHBvcnQgaW50
bw0KPiA+IHRoZSBHb29nbGUgcGFja2V0ZHJpbGwgbWFpbmxpbmUgYnJhbmNoLg0KPg0KPiBPaCwg
Zm9yIHRoYXQgcGFydCBJIHNlZSB5b3UgbWVudGlvbmVkIHRoaXMgYWxyZWFkeSBpbiB0aGUgY292
ZXIgbGV0dGVyOg0KPg0KPiAgIFRoZSB1c2VkIHBhY2tldGRyaWxsIGlzIGNvbW1pdCA2ZjIxMTZh
ZjZiN2UxOTM2YTUzZTgwYWIzMWI3N2Y3NGFiZGExYWFhDQo+ICAgb2YgdGhlIGJyYW5jaDogaHR0
cHM6Ly9naXRodWIuY29tL21pbnVzY2F0L3BhY2tldGRyaWxsX2FjY2Vjbg0KPg0KPiBUaGFua3Mh
DQo+IG5lYWwNCg0KSGkgTmVhbCwNCg0KWW91J3JlIHJpZ2h0LCBJIHdpbGwgY2hhbmdlIHRoZSB0
aWxlIGludG8gInNlbGZ0ZXN0cy9uZXQ6IEFkZCBBY2NFQ04gcGFja2V0ZHJpbGwgY2FzZXMiDQpB
bmQgdGhpcyBwYWNrZXRkcmlsbCBpcyBmb3JrZWQgZnJvbSBicmFuY2ggImw0cy1wYWNrZXRkcmls
bC0yMDIyLTA4LTIxLXYxIiAgb2YgaHR0cHM6Ly9naXRodWIuY29tL2dvb2dsZS9iYnIuZ2l0DQoN
CklmIHlvdSB3b3VsZCBsaWtlIG1lIHRvIHRlc3Qgb24gbmV3ZXIgcGFja2V0ZHJpbGwsIGZlZWwg
ZnJlZSB0byBsZXQgbWUga25vdy4NCg0KVGhhbmtzLg0KQ2hpYS1ZdQ0K

