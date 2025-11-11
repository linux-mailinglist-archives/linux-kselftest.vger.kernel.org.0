Return-Path: <linux-kselftest+bounces-45308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 44633C4D55E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEBE94EF4ED
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C2335470F;
	Tue, 11 Nov 2025 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="I3LDVrbK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9280E2FF658;
	Tue, 11 Nov 2025 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858981; cv=fail; b=Ab+L4Qp0QbU6s1VSjhUudwDpPZIiaYfhgSAxguKlJyVqGiRhGVA0XiUm9Perbya1775qVThB7L5hxgvbR3SjaGdehqiwMj9oYYHCvcoBKFlNdLM0IQshxOk0vsr2f5zRNuesZnPDzZnVzYF2BkBcy879TidQbVsN4rmVzMvKU5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858981; c=relaxed/simple;
	bh=k4eNhtTve3Wg3rKFkH2gHqUHTwqC1xIXg58p9jRCISY=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SIS4KN5xbNajSC0BNDra5tB6SvvkjlumO14nNpySefP/+BHHoYxX87IDnXy0DonmqobUA5so0PhIzCtC6I3N99uuCH67xDeE1551X5rXL5MTGP6ZAqItt2XZzWO2jIbXGEr0Utp9VinFE8dOl+wrlkBUGKTFWk0csrdFUioq2uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=I3LDVrbK; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asreWRWC2U7xnC4uUPdeV2yfF6OTxp5ht7PS1UM+ezy50/dMxk1AtroM2wh3TL3w+jEcnqPivix9gH5XaPbZrfKvasAN2v35tLPq8K8majNUpJKfOUI2wEfB+pqt6WNUUjvlS9psyaloVzGfdIWPRWYCPP4QRx9QEFvtPL69olajFffDXankKHf4WGQaMIF+W7WmduUfo2i/gJpaqDhTYiPlpSUEIkDkOOS35Lo/BRjBOv6gVoaJN8VUdGYZgM6QwCzDuDjPisJqaGfZU84Gr0ehs5TyZDdWtpHeEkhJnOSFEYMn+/nFo0/ihgJvnGk/exDosUUMFa+k4ky7Pqf6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4eNhtTve3Wg3rKFkH2gHqUHTwqC1xIXg58p9jRCISY=;
 b=L+ln1zvkqITjOEUVkGFH6r9Dh70bY5dpr/nlSJFIrm1EgUkZdXiJPTH6M+FvjpGxDJRONWa3EAqcgbq0YpxAQYtdwKhsUaj+UYuREzG01QmRT3vkGzXh95hObWylc7m/ff5KmtgsfO9abiVV3Cpo99zH8hMLu/A14M2ULaOdXdKCS4Z7XYomCp7mPTrKhvi2WvCjD3rMxZNLdNhUDtjmVUgWMLFSFpgxcTJVeJOLqlh3yXrpzMJIAwfdj3ZzjMKlthe6Jgj+trG5Z0xmvCwG5dNTrT2e9cMNY+XBtn1pv+82yOFwaXdt7Hc2JGdFptbd1Jpw/Zw9s21SeWBE6e0DHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k4eNhtTve3Wg3rKFkH2gHqUHTwqC1xIXg58p9jRCISY=;
 b=I3LDVrbKhpnjzmUfQ2cX1XCos1Et9+JD5LruNQ8s6Z73PlOX8LUUG5x1EeL211lI2G5VglN1Zd/hj9ngHHjj+wQaiB6+thC/LWFFKCnyHz2h9sAGOtWMj9R99ClIirTUyflbqIUmb3wIOrs9lBm8MU1u1NS06JBauuuHXu4/pVaDomtjQwU4HSUlr6xlxRGFsm0awm9YHePPApctucOHrBTByL3Cu0ATEJHUtRhkVbSmEqCbYNP6XVMoBVBxWo1GtLzaA7syfQKbnumgN9IANEfRtyqGN0ErUkWjpWnanXB64s+GncWW7/iXWN+qlc7W77ENqbOc6+ME5GJ7W7qRBA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB6335.eurprd07.prod.outlook.com (2603:10a6:800:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:02:53 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:02:53 +0000
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
Subject: RE: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Topic: [PATCH v5 net-next 03/14] net: update commnets for
 SKB_GSO_TCP_ECN and SKB_GSO_TCP_ACCECN
Thread-Index: AQHcSapXFyEaLMm3EUKrDJ2TZ4xHDrTlh10AgAAFsACABIrHsA==
Date: Tue, 11 Nov 2025 11:02:53 +0000
Message-ID:
 <PAXPR07MB79841174CD4D56F50A947286A3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-4-chia-yu.chang@nokia-bell-labs.com>
 <f98d3cab-7668-4cf0-87bf-cd96ca5f7a5b@redhat.com>
 <1c79daaf-c092-4c49-a715-52aeb9688b48@redhat.com>
In-Reply-To: <1c79daaf-c092-4c49-a715-52aeb9688b48@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB6335:EE_
x-ms-office365-filtering-correlation-id: 8ab60a5b-6a87-4073-bf43-08de2111dcc4
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?VU40NGt2NUhKcEFoYnBKS1VIdDd6dE4waXc3ek5nK2xsWFJ6WkRNdGFjV0ds?=
 =?utf-8?B?RVpURWRQVTdsS2FKaGV3dy9kTW5IU1ZnZHU1WFM1SG53WWYvM0NSdk40cFpj?=
 =?utf-8?B?NHRDano3cVdhVlJXZ09MSXdEZHNTMVJiOFpVQ3JuYnFuQUQrNHBSZDdWU01X?=
 =?utf-8?B?R1Q5djRGalE2Q01aWkxzOWlCUWxmaTZXSytlK1d6NU5XUURRWFRqUGpVcmp3?=
 =?utf-8?B?QmNOUm0xeGV5Zzg1N2tmYVZ6dzlXdCtqZ0oyMVlLSmp3emlvOGREamJDcVl1?=
 =?utf-8?B?UXdkdjFlNmROK1FQMGdWMjh3QTdHYkFEeEJ4UDJGckJEbWpGVUpHUk11Skw1?=
 =?utf-8?B?d1FJQldNVmoyV3dGR1d4dGtBYk9XcWVhMFlnTVNjNllKbndvUHU3TkNDUk53?=
 =?utf-8?B?cy92MEFUMDNvRHA4VFVmVWo4SUUxWksvU1kwV2lyeVZMVjBTb3cwRVo4U1FG?=
 =?utf-8?B?NGZUeUFSK1BxV3J2Rk9QVWtUQ29WaUdra1kwL3Zsam5yT29SWmZsTWNRQVBk?=
 =?utf-8?B?bVQ3ZXRFa1ZMdThwQW9kTXE4UXZLRzBiY1Q5VXhGenNuaWtoMms0bW9QSnFR?=
 =?utf-8?B?cExCK0tUcGZ4ekFneTZYVW0rbVhqUkFtK1VBTU9yTWpNTzBnUjBmRkVoNWdZ?=
 =?utf-8?B?eFVaanExQS9STnNYbnFidVFFaTZLZm9FcG1FVkdaclhwU1NWWkxTSW1NL2Vo?=
 =?utf-8?B?c0sxRGtQb2taQXBsWU9KWDJjUkJJQmhlR1lmdlRkWE1NZGF4WEI5T0NQVmFQ?=
 =?utf-8?B?Y1lXM0F0TDZvMS81UDVzUlB6UXZFaDVVcjcxZElQSWpZblVuTEVLN3hia2NV?=
 =?utf-8?B?VWhpSjBzWVl6NTFTNUtmYTE3Y1I1UG1vZzlVRG4vemFoV21ma1B0aVUvM3lH?=
 =?utf-8?B?OVFpU0tia0UyTm5zSzBEdnc2Yk5zSWpiSTRZYkd6SDNQWVlsM1FlWFFCTVRv?=
 =?utf-8?B?SHBpcEtLYkNydmNYMjhpRklCMmNUd3RnVHNkYlRnUzlEdjVKLzczTlNLNUdV?=
 =?utf-8?B?WGtwbkltOXVtb0R5YURtcW1hVDZHOFpHVEcvSzlIV2dxT0M3ZW13UW0ybVhw?=
 =?utf-8?B?WVJmZFludUdJK0J4WVUrMzJILzJGVjVJa21YdjdpaDBHNDdoalg4a2diakR0?=
 =?utf-8?B?UmU4SnF4WE1zS3dlUGljSUc1cE5iK1psVzFZMzlsYnVGQTVJNGxaNDJneW9y?=
 =?utf-8?B?SGl1SDl3b2ZFTng0dlg2QkFDeEx3TTdRaHhpK3FMNitUNU9wdEtMcjhlbHlV?=
 =?utf-8?B?eXJIY3VCZmlLNEpzSU0rSDNLYngyRWF3eTBnZWpQeVV3djZWNmZ6d2ZaQXhZ?=
 =?utf-8?B?NWx5YU9wOVZvZ1lhajFBTmc3Z0JOUXBEWGVBWmVqck85dVJrTVBrL2FYcXZC?=
 =?utf-8?B?eDY3Z1cyQmI0bU84UUJMdEpkYldSQitFYnR2M1duWWJ2bkwwZWxJQnQ2S3RQ?=
 =?utf-8?B?ZEg5OFllTzZqTFhVVVBSckhnelpYcmNpcEsxSWNOeVVZUzBHMWplS1h3SWVT?=
 =?utf-8?B?d1NwUW1EZnVvMVZhcFNkNVo1aUhrY3ZUaWVnMUppTklCNlUyVGZiU3ZTVE5h?=
 =?utf-8?B?eG1wd3pFcnVWTnN0SlBYVlcrM2hUMmNCOGFZNGhNWWRackdJYmxTc0JWeHNY?=
 =?utf-8?B?SnFVVEVXMVhxTzYzMzJvSVgzbS9KSHBwNXQrL2ZOeWlZcmVRWHp0Z2tKZW9y?=
 =?utf-8?B?c3oxa2JTcEZOb2hrWVF1Q2FtMVNFaW81RUFMZmNVaS9zMmplYWQ0RGlOd3dC?=
 =?utf-8?B?alJJcHlBajNKWUZ3c1dmS2hUaTZiV1JRbVV1ZDYxQ3B5MVFhREU1UWJhKy95?=
 =?utf-8?B?T2szZkdiT2t5UkJIaWVGQ0VzeTI3WE5tVXVPa0JnOCs3eUVhWnQ0Y2NsYzc1?=
 =?utf-8?B?UHk3dzAxZFVWc2JIenJ2UTE2M2tBUXhKd21SQ0hsSnZsVGNHeHR0RG83K3oy?=
 =?utf-8?B?NmdsNmFYbkdBRXJMU1dOV2ZxcU9qY3dudkNVb2N3TmxmZTJyQ3NuSmVxUCtx?=
 =?utf-8?B?TUs1eFRZVlhxVGhnRzRlVE55S3U5TXFtc0k0T3Z1cmlSWVliYnFaTXFLZThu?=
 =?utf-8?B?Zm5vditxaGZuU0xGTjZhMUJqWitOL0luWjhMUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHZLTGxFMEtpSFVDZ3VnRTA4MGdyd3dCMHpxVXp1QWhCVlgwN2xyVjl1Yk0v?=
 =?utf-8?B?ZEY2Y1dOVld6OG54TG0yUVhyZjdFTFFUWlVMUUdJQVpQUVJReGIvRitwMmlY?=
 =?utf-8?B?Y2h4eGExSitrM0sxc0dIc2VrUjIyM04xU2JOdXBDMjRzK2hUTFVuV2laa0xG?=
 =?utf-8?B?cG1lTXFGanNIQnhFb3VZNGhCM0Y0b2loWVIrcHEwMFBmWVBtWG04Ym1SMkJK?=
 =?utf-8?B?YnBUMlpFN01nelZTQ25qd0puQnRGSEh4cGtrdlFMY1A2QmpQekM4cGRnVnN0?=
 =?utf-8?B?OUlzVHltU3NlcnpBN3lnTTNOSTFiRVpTcEJzdU9FMU1wOCt3VWFBcEZSak5m?=
 =?utf-8?B?Tmtjd2Yxc0w5Ymx2YXZqVWZXR21Ec2xJTFpFZHN6QkFRa01FNUh5TlhIK3ZJ?=
 =?utf-8?B?eGdZMXBUVWlYaFJJazBGN2VRRUNLQ0dPSHpKZXN6MXlVck1NRnVkTWJqU2lv?=
 =?utf-8?B?bGFKRzRrWlJTdUN4dUNYb0VHOVlyOFNReW8wdkRvRnM4ck5hemtqR0lzM2NS?=
 =?utf-8?B?QUgxTlVyYjREWmR0OEtlUU55KzBUZDFST1NBZ0pyOGorMFJKbm9yS0ZuTUlk?=
 =?utf-8?B?SmgwTndpRFhGZ052R2VaNXN1a0hDSWFKWER0cnhWanN4LzNBMHNnalgzeDlF?=
 =?utf-8?B?eU82QWVvcXFHSWpKQmM4VFJZeWpyejNDeG45akRmQ2FtVGNqWFU0MFhhN2xP?=
 =?utf-8?B?aEZadTdnVGZwN0hHWXkrVUt5VHQ0cnN4UmJIU3VlRldMVmRicUVyZUM5RUxt?=
 =?utf-8?B?OTlESHR2OXlyUUk2dXJEa2ZUanY4TjhGTEYvQzBHdERPdDRmL1IwcmlkZldR?=
 =?utf-8?B?RVRQR3Z1eXRQQlF0c3E4SWE1TTV1UGl1R0d1VkxQazRMdTJEa2JYeHc0dVVw?=
 =?utf-8?B?WVRGbWJGU2JxUnQ0eGh2eGZucUl5QWZNWG81bjBFOSs5QjF3SkxxNHN5eHBo?=
 =?utf-8?B?SVlHanVNRDR2aDRqcGx3VEo1Q256OFhvZk9kNFVoM0JjVU5BNDNGRzBnQjRj?=
 =?utf-8?B?NXdwU0pTSXd0MXR4MVZKMW5OZ25jVHhyMmx4ZCtEMTBnNkNIdDhqa1UxUFBk?=
 =?utf-8?B?MTNjRTh3aVo2UUhNTUxvUHBqRExYUThZT0xhTUJqc2ZISkVXRXhuZkd3cE1N?=
 =?utf-8?B?YnhpZEd2Y3lHNHB1TEFWcndIemFWSDRFRVoyTFBhTndxdytNVlpIK2syT240?=
 =?utf-8?B?MzdJa1NvMUx0Q3Y4KzhTRVhFZmxuTmtVNFh5c2dDUnh6ZnRzeUI5MGc5ZkR1?=
 =?utf-8?B?c2NjZndKdDF0RXJrcGZQckVrUXJaMnduNStZZ25Tc1N1TXk5QW9GYit1Zmgr?=
 =?utf-8?B?c0x0TTF6cEVqSFozb3k4UWRPeDZERlB0bjQ3Nk81anpBUElzMGxPQnZCVkFI?=
 =?utf-8?B?cWptQzhEbHZjVU1BeVkzZ0lUY3dpNk5uSEhlWjdkTURuUmUvMzJCQUZwZExl?=
 =?utf-8?B?RFNHL2xNVExSMWpDdlluTVMrRFA5WXRHS0tnL0JIMnVNM1VBK3h2TjdsQ2FI?=
 =?utf-8?B?NGY2VlROK1pjdXBBRDJvcUpBN3l6WUdGbEpZSklwTElvdTVjRUdWUm1ZZlBn?=
 =?utf-8?B?VFIxejhObnNzVkVXVStGT09NM2k3L0hIalhrN2ZWRGV6U2IyQ0pOOVVQTmQx?=
 =?utf-8?B?S201TU8yZXdIcjdBUDBwdjdTWFlWbzd4WVFZSEVyT3lDakhLcjA3Z0Vydm0z?=
 =?utf-8?B?byt2eWV6cFluQUdONmxaamZFSXV5UTJ6bU5HcEEvTkYzM0dmUzNENW9TbUNW?=
 =?utf-8?B?UWg3dzRPQy96RW52eXVnbVhMYzJ3NWFTWDVPNDNpRVhGSVNUUnZ5Y0praG91?=
 =?utf-8?B?MDVsUXl4U3diMk1BWU5CczZrT1dlMmxzOWY3K3pWNkM1UTl3R3NmaVJVazEx?=
 =?utf-8?B?RjJIM1hWVXo1ZHRSSWNuTlVPS2F5bCtHMTRLYkVXL2xXakJja0dZa0lPdHUx?=
 =?utf-8?B?QlJvYWZvU0ZQSEp6bXlNVjBrelZEVXlWUHQxK2lZNXhFb01kOThwYjFLNlRT?=
 =?utf-8?B?STZibWdENkQ3cTRPeG5vaFR1dFlLRDdwMDFiR2VpVnozb29LUVFMdnBxU2J6?=
 =?utf-8?B?Z3R5bHdUbTFFRC9qYUJwcHhSNnZHSXE2NjNqcVZ2aDQ3RHB1aXU2Nm1jZklB?=
 =?utf-8?B?WTZWU2I0MXdrd0NUY3NHTUMwcmRuajIwWXl6bGQyeVU0QXNwZmdSQVdUUHcw?=
 =?utf-8?B?MGc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab60a5b-6a87-4073-bf43-08de2111dcc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:02:53.5064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHR1+BoXbZ94ypfRK7N5nvvrHnD/+RG00jBiiorxr7w09djUG+G0vje33y6zPuy/pN9kkfDXodEWB0du0lGgSXeFV/OrrAW7yxu6GbqAK2mv5Ce+hh1tguMLjjQyJ5UK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6335

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNiwgMjAyNSAxMjoyNiBQ
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBlZHVtYXpldEBnb29nbGUuY29tOyBwYXJhdkBudmlkaWEuY29tOyBsaW51eC1k
b2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNh
aGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsg
bmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1
LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uu
d2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmli
ZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1r
c2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xl
LmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJl
bGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25A
ZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmUgPGNo
ZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2Fz
dC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY1IG5ldC1uZXh0IDAzLzE0XSBuZXQ6IHVwZGF0ZSBjb21tbmV0cyBmb3IgU0tCX0dT
T19UQ1BfRUNOIGFuZCBTS0JfR1NPX1RDUF9BQ0NFQ04NCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlz
IGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tp
bmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBm
b3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gMTEvNi8yNSAxMjow
NiBQTSwgUGFvbG8gQWJlbmkgd3JvdGU6DQo+ID4gT24gMTAvMzAvMjUgMzozNCBQTSwgY2hpYS15
dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+PiBGcm9tOiBDaGlhLVl1IENo
YW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4+DQo+ID4+IE5vIGZ1
bmN0aW9uYWwgY2hhbmdlcy4NCj4gPj4NCj4gPj4gQ28tZGV2ZWxvcGVkLWJ5OiBJbHBvIErDpHJ2
aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPj4gU2lnbmVkLW9mZi1ieTogSWxwbyBKw6RydmluZW4g
PGlqQGtlcm5lbC5vcmc+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEt
eXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBpbmNsdWRlL2xp
bnV4L3NrYnVmZi5oIHwgMTMgKysrKysrKysrKysrLQ0KPiA+PiAgMSBmaWxlIGNoYW5nZWQsIDEy
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvbGludXgvc2tidWZmLmggYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oIGluZGV4IA0KPiA+
PiBhN2NjM2QxZjRmZDEuLjc0ZDZhMjA5ZTIwMyAxMDA2NDQNCj4gPj4gLS0tIGEvaW5jbHVkZS9s
aW51eC9za2J1ZmYuaA0KPiA+PiArKysgYi9pbmNsdWRlL2xpbnV4L3NrYnVmZi5oDQo+ID4+IEBA
IC02NzEsNyArNjcxLDEyIEBAIGVudW0gew0KPiA+PiAgICAgIC8qIFRoaXMgaW5kaWNhdGVzIHRo
ZSBza2IgaXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLiAqLw0KPiA+PiAgICAgIFNLQl9HU09f
RE9ER1kgPSAxIDw8IDEsDQo+ID4+DQo+ID4+IC0gICAgLyogVGhpcyBpbmRpY2F0ZXMgdGhlIHRj
cCBzZWdtZW50IGhhcyBDV1Igc2V0LiAqLw0KPiA+PiArICAgIC8qIEZvciBUeCwgdGhpcyBpbmRp
Y2F0ZXMgdGhlIGZpcnN0IFRDUCBzZWdtZW50IGhhcyBDV1Igc2V0LCBhbmQgYW55DQo+ID4+ICsg
ICAgICogc3Vic2VxdWVudCBzZWdtZW50IGluIHRoZSBzYW1lIHNrYiBoYXMgQ1dSIGNsZWFyZWQu
IFRoaXMgY2Fubm90IGJlDQo+ID4+ICsgICAgICogdXNlZCBvbiBSeCwgYmVjYXVzZSB0aGUgY29u
bmVjdGlvbiB0byB3aGljaCB0aGUgc2VnbWVudCBiZWxvbmdzIGlzDQo+ID4+ICsgICAgICogbm90
IHRyYWNrZWQgdG8gdXNlIFJGQzMxNjggb3IgQWNjdXJhdGUgRUNOLCBhbmQgdXNpbmcgUkZDMzE2
OCBFQ04NCj4gPj4gKyAgICAgKiBvZmZsb2FkIG1heSBjb3JydXB0IEFjY0VDTiBzaWduYWwgb2Yg
QWNjRUNOIHNlZ21lbnRzLg0KPiA+PiArICAgICAqLw0KPiA+DQo+ID4gVGhlIGludGVuZGVkIGRp
ZmZlcmVuY2UgYmV0d2VlbiBSWCBhbmQgVFggc291bmRzIGJhZCB0byBtZTsgSSB0aGluayBpdCAN
Cj4gPiBjb25mbGljdHMgd2l0aCB0aGUgYmFzaWMgR1JPIGRlc2lnbiBnb2FsIG9mIG1ha2luZyBh
Z2dyZWdhdGVkIGFuZCANCj4gPiByZS1zZWdtZW50ZWQgdHJhZmZpYyBpbmRpc3Rpbmd1aXNoYWJs
ZSBmcm9tIHRoZSBvcmlnaW5hbCBzdHJlYW0uIEFsc28gDQo+ID4gd2hhdCBhYm91dCBmb3J3YXJk
ZWQgcGFja2V0Pw0KPiANCj4gVWhtLi4uIEkgbWlzc2VkIGNvbXBsZXRlbHkgdGhlIHBvaW50IHRo
YXQgU0tCX0dTT19UQ1BfRUNOIGlzIFRYIHBhdGggb25seSwgaS5lLiBHUk8gbmV2ZXIgcHJvZHVj
ZXMgYWdncmVnYXRlZCBTS0JfR1NPX1RDUF9FQ04gcGFja2V0cy4gRXhjZXB0IHZpcnRpb19uZXQg
dXNlcyBpdCBpbiB0aGUgUlggcGF0aCAoIHZpcnRpb19uZXRfaGRyX3RvX3NrYiApLiBQbGVhc2Ug
Y2xhcmlmeSB0aGUgc3RhdGVtZW50IGFjY29yZGluZ2x5Lg0KPiANCj4gL1ANCkhpIFBhb2xvLA0K
DQpZZXMsIFNLQl9HU09fRUNOIHdhcyBzZXQgaW4gUlggcGF0aCBmcm9tIHBhdGNoIGJmMjk2YjEy
NWIyMWI4ZDU1OGNlYjZlYzMwYmI0ZWJhMjczMGNkNmIgaW4gdGNwX2dyb19jb21wbGV0ZSgpLg0K
SW4gcGF0Y2ggNGU0ZjdjZWZiMTMwYWY2YWJhNmEzOTNiMmQxMzkzMGI0OTM5MGRmOSAocGFydCBv
ZiBvdXIgZmlyc3QgQWNjRUNOIHByZXBhcmF0aW9uIHBhdGNoIHNlcmllcyksIGl0IHdhcyBjaGFu
Z2VkIGludG8gQUNDRUNOIHRvIGF2b2lkIGNvcnJ1cHRpbmcgQ1dSIGZsYWcgZWxzZXdoZXJlLg0K
DQpBbmQgeW91IGFyZSByaWdodCB0aGF0IFNLQl9HU09fRUNOIGlzIHN0aWxsIGJlZW4gdXNlZCBm
b3IgdmlydGlvIGFuZCBzb21lIGRyaXZlcnMgKGRyaXZlcnMvbmV0L2V0aGVybmV0L21lbGxhbm94
L21seDUvY29yZS9lbl9yeC5jLCAuL2RyaXZlcnMvbmV0L2V0aGVybmV0L2hpc2lsaWNvbi9obnMz
L2huczNfZW5ldC5jKS4NClRoZXJlZm9yZSwgd2UgcGxhbiB0byByZXBsYWNlIFNLQl9HU09fRUNO
IHdpdGggU0tCX0dTT19BQ0NFQ04gaW4gdGhlIHR3byB1cGNvbWluZyBwYXRjaGVzIGZvbGxvd2lu
ZyB0aGlzIHBhdGNoIHNlcmllcy4NCkZvbGxvd2luZyBkaXNjdXNzaW9ucyB3aXRoIHZpcnRpby1z
cGVjIGNvbGxlYWd1ZSAoUGFyYXYgUGFuZGl0IGluIGNjKSwgaXQgaXMgc3VnZ2VzdGVkIHRvIGZp
eCB0aGlzIHRleHQgZmlyc3QgaGVyZSBiZWZvcmUgY2hhbmdpbmcgdmlydGlvLXNwZWMuDQoNClRv
IGNsYXJpZnkgaXQsIEkgd291bGQgcHJvcG9zZSB0aGUgZm9sbG93aW5nIHRleHRzIGluIG5leHQg
dmVyc2lvbiBmb3IgU0tCX0dTT19UQ1BfRUNOIGFuZCBTS0JfR1NPX1RDUF9BQ0NFQ046DQoNCi8q
IEZvciBUeCwgdGhpcyBpbmRpY2F0ZXMgdGhlIGZpcnN0IFRDUCBzZWdtZW50IGhhcyBDV1Igc2V0
LCBhbmQgYW55DQogKiBzdWJzZXF1ZW50IHNlZ21lbnQgaW4gdGhlIHNhbWUgc2tiIGhhcyBDV1Ig
Y2xlYXJlZC4gVGhpcyBpcyBub3QNCiAqIHVzZWQgb24gUnggZXhjZXB0IGZvciB2aXJ0aW9fbmV0
LiBIb3dldmVyLCBiZWNhdXNlIHRoZSBjb25uZWN0aW9uDQogKiB0byB3aGljaCB0aGUgc2VnbWVu
dCBiZWxvbmdzIGlzIG5vdCB0cmFja2VkIHRvIHVzZSBSRkMzMTY4IG9yDQogKiBBY2N1cmF0ZSBF
Q04sIGFuZCB1c2luZyBSRkMzMTY4IEVDTiBvZmZsb2FkIG1heSBjb3JydXB0IEFjY0VDTg0KICog
c2lnbmFsIG9mIEFjY0VDTiBzZWdtZW50cy4gVGhlcmVmb3JlLCB0aGlzIGNhbm5vdCBiZSB1c2Vk
IG9uIFJ4Lg0KICovDQoNCg0KLyogRm9yIFRYLCB0aGlzIGluZGljYXRlcyB0aGUgVENQIHNlZ21l
bnQgdXNlcyB0aGUgQ1dSIGZsYWcgYXMgcGFydCBvZg0KICogQWNjRUNOIHNpZ25hbCwgYW5kIHRo
ZSBDV1IgZmxhZyBpcyBub3QgbW9kaWZpZWQgaW4gdGhlIHNrYi4gVGhpcyBpcw0KICogbm90IHVz
ZWQgb24gUnggZXhjZXB0IGZvciB2aXJ0aW9fbmV0LiBGb3IgUlgsIGFueSBDV1IgZmxhZ2dlZCBz
ZWdtZW50DQogKiBtdXN0IHVzZSBTS0JfR1NPX1RDUF9BQ0NFQ04gdG8gZW5zdXJlIHRoZSBDV1Ig
ZmxhZyBpcyBub3QgY2xlYXJlZCBieQ0KICogYW55IFJGQzMxNjggRUNOIG9mZmxvYWQsIGFuZCB0
aHVzIGtlZXBpbmcgQWNjRUNOIHNpZ25hbCBvZiBUQ1Agc2VnbWVudHMuDQogKi8NCg0KDQpDaGlh
LVl1DQoNCg==

