Return-Path: <linux-kselftest+bounces-48541-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E16B6D04542
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 17:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AAF91302FCC2
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 16:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61EC7261E;
	Thu,  8 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="ljdXLEqs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011020.outbound.protection.outlook.com [52.101.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13292BB13;
	Thu,  8 Jan 2026 16:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888090; cv=fail; b=a98Xlc2iEyD0LBWWRYNE3MCHvvTHb8lvaZvCqc81YbcXUi9HOY/ygpnROpqfwJy8BjIYl0yzq7mOPCMfxeR/YNAokdVrdEookb51prxdh7Yc10prKSZsH7dj/JJdzb0nb2iI6KkkCXaLlIwiJENuLASPBAOpDzWucr7PAmx7XvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888090; c=relaxed/simple;
	bh=z3CNVDXv5vNCrkBPgPXGFCgKIwojJf5d3cN08QEy/HU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyxb+AUTvD4Q1V4KvxLvHX+wKywjRe8QCTnwyENcKsAaOWFofipffXI5sB9vWlDIKwZxRAQPMiy8JeDIIt7d+rsVxepplNmFUJ6XwYqLIWnl31hPcrPKD7HVh+Lr2vL/z4VWe6D1K8yL+Gd2iLaJpRW50KiVVhiqqg9e0JzmK9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=ljdXLEqs; arc=fail smtp.client-ip=52.101.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnLarqp4iyAxOmO1RngpawfVIVXR8ie4JUeFHdbg7J2nAbvkJRi+k7DW4xSSzTrrULyxtEsRVcp7ixQRY4QrmokgUG3uk+iGsbJ9ItchZPwYZKRKmuHk5k515RERSnLEv3jV0xhwTZWPxfrpQ3NhizSJsfT/bhZ6fASLBQ6IMO8/7pC1LyIbFAm9m4vgwX5sDqS3mhPVFBKUmfBDvz9sM8N+mS19UDKopstOeL4us6bKMLMWl5U7wErkAl7jS6nHRtvJc6OhMZRbb1WZ4W1bsd0Zi3JDltsgltQgh1KlrnRElOZwr0iOxz7RORS7RutWOnY0ChGE1ZvoG0Okhu5fmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3CNVDXv5vNCrkBPgPXGFCgKIwojJf5d3cN08QEy/HU=;
 b=BfO2/07rkGyee8t/dVXA/MwLnX9XtCyIkyv9XSFI+VZETSBNFS4a/e62zCtQQRmb+v5/aBFFwXnJqVmdBpj1jO6MP3pNOzM5xV71xvjrTdCi7AZLOGhbrF1+DD5L55nmAX7Dn9SdM6shSCFFDceNflrrDnKkKI7foW9KsqqDagcEWUgFYCQTBekIhPc95gA+qvlVumBlpSdFzXtnicwsNQw1XNawfv/xI4ohOVcawEL2zTn34BF+J+vcoYCuJZ+9/ZlQEf902ym3JmnH8u4u0jSt0+GLg8fGV7+2Y2esXWyXe7CCVhUkyzi9BDIXjACIK3PQspbdSzs2VirMACm5wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3CNVDXv5vNCrkBPgPXGFCgKIwojJf5d3cN08QEy/HU=;
 b=ljdXLEqsFpTPwkR0jIRG4p7fkHc1aC9AmCpoBx0ejjXFSmZs6tPHHOYvK53yIVjI60WRHP5AGoUNjw9ILOc7clHeh3Jfd91KsXQy+OW81cgxK/oniMKTxDNlBY70kzk3AciGQerF+CVZOFpTTWs2YoDJOcbcuQajdQDGBb+bpUu8/2iWSM6MzdjxJTfaC/prctgUbKETCT2EKywZSI5330vrWip2ro6WEB6nTTa18TmOjVxs195iNHkbk6MXIb68TQYRAxmpxw0gxanzfzCgzbwtDPGElnelPMn7IjzIoPgqkry+WxBe7NYku7XNH8/1Q69Hgt7StQ+jvRFIu1a6/A==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA1PR07MB10163.eurprd07.prod.outlook.com (2603:10a6:102:48d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 16:01:24 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 16:01:24 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Neal
 Cardwell <ncardwell@google.com>
CC: "parav@nvidia.com" <parav@nvidia.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
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
Subject: RE: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Topic: [PATCH v7 net-next 00/13] AccECN protocol case handling series
Thread-Index: AQHcfLJYfp0P5qIzmUSdgLUUXjW7nLVH+8+AgAABAQCAADfSAIAAA+IAgAA9laA=
Date: Thu, 8 Jan 2026 16:01:24 +0000
Message-ID:
 <PAXPR07MB79845267EDCDAF9FA379B139A385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260103131028.10708-1-chia-yu.chang@nokia-bell-labs.com>
 <56f6f3dd-14a8-44e9-a13d-eeb0a27d81d2@redhat.com>
 <PAXPR07MB798456B62DBAC92A9F5915DAA385A@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9d64dd7e-273b-4627-ba0c-a3c8aab2dcb1@redhat.com>
 <CANn89iKRAs86PVNAGKMUgE49phgZ2zpZU99rRkJq=cc_kNYf=Q@mail.gmail.com>
In-Reply-To:
 <CANn89iKRAs86PVNAGKMUgE49phgZ2zpZU99rRkJq=cc_kNYf=Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA1PR07MB10163:EE_
x-ms-office365-filtering-correlation-id: d71600bc-923c-4418-620a-08de4ecf2c88
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1lqOFZDZDNaVW1ZYlVhM1ljQ3QwVmhIdlR1YXltcmREV1BVNkRNMVJuMkcy?=
 =?utf-8?B?NHNMMXljcHRIYnNiZVdwZXVVQmxVYXh2ZE9vU3ZLL2NWUTNENytxQUx5L0Ru?=
 =?utf-8?B?OTRZUzdQWVZickorTnRRNnFXdzZsSVVHMVgwVmFkdm04RGZEanVZLzAvRC9m?=
 =?utf-8?B?OXdtNnlsREMvQllkRWVnMjAyTy9pSDdKSEM5UHpKL04yclhDa2VEMzVrNTdT?=
 =?utf-8?B?VmJ2S3VEUTFxcGFrNlRqTHBXZDh3dE52SGpRUzkzMVBrVG9Td2hKMjN1T1Jo?=
 =?utf-8?B?K1FNdmFXYUcxUGJKR3lwVHFmcU5sT3k5bmdSTU5TM1BoYkdiY29NZmdmM3pO?=
 =?utf-8?B?R1ZGMjVsNGNMeXNudTk2dHdRVTYvZ3Z2RmdUMEJoQU15RHQ1TVk2NVZueFd4?=
 =?utf-8?B?L0N0MDJNd1NMS1pzYnVJanJ5WUlVWDBRUE9CYnlhdVZmc3cwVE5vN1p0MnZu?=
 =?utf-8?B?aHlGUDFpdjkrQmFJd25DaTlUMGcrdEhnZ1NxYklCQTU2QW9hOEppUjd2YTJ2?=
 =?utf-8?B?bHhvRGJkSnZGRXovSFJzRG8zdDhRbjJPM3VCY2sxUlFwclVxUnhXZ0psakpi?=
 =?utf-8?B?ZmxYK3hVeHBTQ3EzM0hlT3pIOHRESzJKU0Z6Q1BPWjUyRGdBc2pZR0xsdCtn?=
 =?utf-8?B?eGJOeFZXbTFxdXhaL1BOcy8zak1aTmlSQ3BaR3ZzVjRMbkU2OE0ycDNtL0Nj?=
 =?utf-8?B?bDhTdDNNTkZtMXU0RGJ4Y2VBQ0I5MTRYRU1iY3VmSUl2WkZNbXg1L1NCVWph?=
 =?utf-8?B?OGFPNTFreHlGQkRvcEVjY0FEOFNwVXJheUFyVnYwMmxidzhVQUJEUmdSZ2ZS?=
 =?utf-8?B?MGU3M245TlZoQ0R1QkdvMGRkWXdIbFpta2lqVmhLZXZaK1EwL0FIdFJXTVBn?=
 =?utf-8?B?dXd5dU5SSXFYNGFQbkNPWFZqbGJsTHpVYWpJb1pnbEdWQ2R6NVdpVTltM2xz?=
 =?utf-8?B?aVNMNzBKWTRDM21XSkViREhYVTdrUXl1MXBCZXNjN3J1c1VGQjJXdjk0R0o4?=
 =?utf-8?B?cm5hZHEvNlYrTlFJaS8zalFmZTd3ZUtJV1NybGRhbDRIQ1NVditaT1NCZXFk?=
 =?utf-8?B?WHo5dWJ0aFNabXI1SGNnRFNNVDdOK0tnOEwrbGhiSjE5cHRzR0VZQW03a3B0?=
 =?utf-8?B?RHMxZVA1QlVpV3dEakpTRGhDRGw4NHdEVEdDWmt0ZDNTZTRxN2pCRitPeWcx?=
 =?utf-8?B?ZDZMSXJMZkpCNDlMdnkvRzhkcTkralhja1V5NlhweG1PQUN1QWI0a0crOFJS?=
 =?utf-8?B?VUptZVhEYWhCUzQ0NGZSSlUwOXhRS1BQd3J6cWhrKzYyVklwSlZra013MHpS?=
 =?utf-8?B?UWxFWGNib3FKNUxRaFpPL3FQWVFERXZpdktDM1dkVFgrcTV5MmhSR3NmdTNQ?=
 =?utf-8?B?cFdCTWVqZlJiekI5dU9RYVlQNHhvaWlCVmNNdFU0dEJqL1RTUXZtRHhIY0Y0?=
 =?utf-8?B?b2lueTI1WWNmd2VzMjZJRi9lQi9GOXh1OVR6MFQ2UC9hckxOcDUyRG01WnFQ?=
 =?utf-8?B?Tllza1FFVkV2VEdvODdoclo0TDdXRFlIZ1dkSE9aVlpFUmM1Uy8yNDRER1NY?=
 =?utf-8?B?eGJWcnZ2Y0NvdEt3eE1JcE1VMWRieUptV3F1eFBlcWFpakRDbmZjWXVPSWtx?=
 =?utf-8?B?VkFHRzRmeHA2ZFdmN09uZjA2b3VpaFRnSUlaT011aEdxYytmWDBNNGdMSG5X?=
 =?utf-8?B?MzB0UEJsMWROUGpiOWtRbVRMWGM3ZXgreTZaa3V5U3dzWUpqaTIzK1pyMWZZ?=
 =?utf-8?B?alh0TUNyYmlFTDgyY0tyWmJ4OEVDS3c2eEEzV21qeEl5WUk2RVV4dUNYTnQ4?=
 =?utf-8?B?SVFXMDF1Vm1hbzBpQVNLellRYlBXM2ZYcXZNSDRCdW1tb09Dcmd4aGhiVGNY?=
 =?utf-8?B?dDFuRFg4c0JBWEw1WUZTZko3Mm56TWJLcGhxUUVvS1U3em90MTVtYU9ndlpu?=
 =?utf-8?B?YnJuc1kyTm9WTUllUWRObmd4bGtQRXYxTTA2SkVRNlMydlBZUmlxTklZT3c1?=
 =?utf-8?B?bkVVQitpeUdZbVByTXhDYi9GWitVdUUxT2kxVGNGYmRpNlNkMGFkaSt5Undt?=
 =?utf-8?Q?VxQ6lI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGVQdlM4cGNuUTFiVDF6RHZqd2gweldnSWtVRjBYdjhFR1VHWEE4MjUvT1dB?=
 =?utf-8?B?OE9URTc5aitMQjJ3cmhBSDdSS252UnI4OXZtMEIzNTZ3TTNmZDBlMzBOdWp1?=
 =?utf-8?B?MkRlMUJPMktSMHBJcUt3eGZwZ1RjQzRvd3dxYTdYNEp6bVVaenJTR1p4TDVx?=
 =?utf-8?B?TC9zUXczYW9BVlhodVVkL2hhZ1NvNDFybGJnTkJRdWpJNEMzMXJrTVA1MzhI?=
 =?utf-8?B?ZklBaXMrK2dZc09URXdZZkpadGpmNGF2dFpaK0t3cE81MEVKbFVUaDBUREFj?=
 =?utf-8?B?RzlZVHlFcWFOYjlpWXZQZU9JUmpydlB3bWpBbnpTUllkN2FlR3dCaU8wTXhR?=
 =?utf-8?B?Y0NGNUI3NkpvcjFCaVFMS0s5cGw2Z1ZIQTdSSjZrNGpVUWNQRjl2RjF4bCtj?=
 =?utf-8?B?dnkweVZMMmhUTEw3SVo4WjRBaWhuNFlSd2dadXV1c085SG9iKzFhSVlpR3ND?=
 =?utf-8?B?M1ZSbFE0bXZOSy9MSmNDVGltcFBwMEwzQzVGR2hpWHVxdGMzQVVmMDdkTHNN?=
 =?utf-8?B?M3ZKWXJSdEIrM1hZRzJPMjJzbzc2dy81MGpaeWVyZHJHTDJ2aDR3OE1LSnFI?=
 =?utf-8?B?UUtqZG15ZFgyMGtEbEtVU09GKzZRRklhK0JCaCtISlk2bmtWYWhGRUhySUdo?=
 =?utf-8?B?eEkwcVNXMHJ1Y1VORHFtTS9uNGsyUE1kaW5UQ1dUclZaWTBrRjB4bVVrMzZk?=
 =?utf-8?B?bVFIWUt1R0N0MEJwczU2b3h5N0xKUkNUanBNUWZhRGxRTTFtbHo0MU92Y2hu?=
 =?utf-8?B?VlUvVlRqU2NEQVM4THJualMwcDNoNzAzTkNhR0dBdE1PNDZ5N2VvakhEOVNE?=
 =?utf-8?B?OW1Fem9mVktlTllsajZNV1RraXlZaVdhZ2hFSHlqcWhlM0dyNTA4MEZLM2lt?=
 =?utf-8?B?c3dwSWtQM3M2MUl3cGdycFY2cy82STBaQUxYWXdJT1lMZUZjL1VPRnlrZ3Va?=
 =?utf-8?B?dm54c1BNdGVYQVBiT1Fka1dEVzBEUW1FK25UM1NJTXdSeUNIOGNrdXp2Qnd2?=
 =?utf-8?B?NndiTysySHRKSXUwZytGdkM0NjVQVEk1K25lZEtBSDJYTExWQktaSjlab1ov?=
 =?utf-8?B?a3lGbnBiTGhISW40ZTJKRWxVSmpQUlVXQS9TZlBpczBpazUvNHVzQjhGOXNT?=
 =?utf-8?B?TnZiR1dnZ3kwczNQODlDOGRyZFBhdDY2WkxVaWVMOGxEVVpOWnMrYUdyMXdF?=
 =?utf-8?B?RmhWaklKVWMzdTRSNERKZ1NkYTNnR05HWG1MQzJWbmhaUHFxL0VwalpWdC9I?=
 =?utf-8?B?bHVUUURGQWFKeUJKRHdnZEVJcWZIYTZ4alAxY2FObmhWQjQ1azhrQUJzY2JD?=
 =?utf-8?B?SG9ydmdwWU9qUFUzY29MdkZJMGNlYVh0RmphWFYzVEs1OUtzYzYzRGczZkhH?=
 =?utf-8?B?aGVYWW9FUU5xdFFTWlRYNXN6ZWRHQ3dmQUJoa29SR2hnZGpJMWtydTdBYnlU?=
 =?utf-8?B?ZUs0RzFNdmc5NlBBbGFxRmlYMEc3RjFkZkhmM1ZydDFYRXEya3Z6R2toeWJS?=
 =?utf-8?B?WDN4L2xSTVVLQ2toYlRSaUc2anlONGtaVFlOYzludnZxYUNOMUwwaW9nZzRr?=
 =?utf-8?B?Mm40cDhQUjRzSGRUUmtHWFZkUUtER2FEK05sZTJnSDRsSElWSHNPWHJKM2E0?=
 =?utf-8?B?dEswVHFqaUxTemR0ZmVlNTJTV2NXaEp0Q0t2MjRabTZWZW1TdEZseGw1N0NK?=
 =?utf-8?B?WDhMY1lFc2RlalkyeHZ6TG1nNFNxQkkwVkJONXh5UVMzV2t5NTFkU2k1MzNX?=
 =?utf-8?B?SGlRRXRCclR2OGNuMk5GWFlQOVgzUGZ1ZlVOMFR0ZU9FMDRZWXFlanpYMkFD?=
 =?utf-8?B?VGhRS0VodERrYmxvSDZteUF3aFZNRDRjMURZUVdvSTAzbFFVSU8zcVNTeSsw?=
 =?utf-8?B?YkpOeEVvYXBBcFFKZGJWYy9XenNTVUlML1psL3lNQkRaS29uVmE1ZXdiU1Av?=
 =?utf-8?B?STRSZllHMzRXamR0TzVPZW1aell6dUpPbDgzR1dMV3pXMFdyNWI2NWVFUklI?=
 =?utf-8?B?bUt3RXJoa3h2Qnl5clNzeVFUR3JRNDVudHFxNGxxRjJ0SmhtcG9KL284QmhG?=
 =?utf-8?B?ODJ3Q0E3WjFpQlB5d0s1Rm5RNzl6TVVmRWZQR2J5VGV1cnA3NERLMk41RTFj?=
 =?utf-8?B?WFJ4Q2hkVEFWamx2Yi9EaGRYR01jeWlRRjZIeG9NWWZjNnM2d2pHVkpoa0dj?=
 =?utf-8?B?SGhmUWU4VGpTYmtWNW5hWUdWLzJUOStEbnpFRW9HT2J5VVZ0cmd6SjlOZkhD?=
 =?utf-8?B?eHNMVytKOG1UZlZLSktDZ0IxTFFPQ0J1d2lHWGxxa2hXS1hyK0k4SmNmRnc3?=
 =?utf-8?B?QSs2N2xmZmVCNDhseEhORHR4bTJkaC9jM0gzM0FaQ09rVUhmVUNmcTA2cmlw?=
 =?utf-8?Q?IBEoxOOZKPTn4FgY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d71600bc-923c-4418-620a-08de4ecf2c88
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 16:01:24.5334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ut891l5/FhGn0e8BjDePX/N9T9sV492GXnMaDHN+ii6zP7s4kjVb5BevYdeTSTGDZQqJ1ddO9BbT1RLq/Rg2zE5nN4K7jSMgjG0toeqjZWMDjORheU0v8SUmkLLK1sUC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR07MB10163

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgSmFudWFyeSA4LCAyMDI2IDE6MTkg
UE0NCj4gVG86IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4NCj4gQ2M6IENoaWEtWXUg
Q2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPjsgcGFyYXZA
bnZpZGlhLmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVsLm9yZzsgY29yYmV0QGx3bi5uZXQ7IGhv
cm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsga3VuaXl1QGdvb2dsZS5jb207IGJw
ZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUudGFodEBnbWFp
bC5jb207IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3b3Jr
cGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51czsg
ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVy
QGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1YWhA
a2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVsLm9y
ZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29lbi5k
ZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29tOyBp
bmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nv
bi5jb207IGNoZXNoaXJlIDxjaGVzaGlyZUBhcHBsZS5jb20+OyBycy5pZXRmQGdteC5hdDsgSmFz
b25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyBWaWRoaSBHb2VsIDx2aWRoaV9nb2VsQGFwcGxlLmNv
bT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyBuZXQtbmV4dCAwMC8xM10gQWNjRUNOIHByb3Rv
Y29sIGNhc2UgaGFuZGxpbmcgc2VyaWVzDQo+IA0KPiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBl
eHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtz
IG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0
aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIFRodSwgSmFuIDgsIDIwMjYgYXQg
MTowNeKAr1BNIFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBPbiAxLzgvMjYgOTo0NyBBTSwgQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIHdyb3RlOg0KPiA+ID4g
UmVnYXJkaW5nIHRoZSBwYWNrZXRkcmlsbCBjYXNlcyBmb3IgQWNjRUNOLCBzaGFsbCBJIGNhbiBp
bmNsdWRlIGluIHRoaXMgcGF0Y2ggc2VyaWVzICh2OCkgb3IgaXMgaXQgc3VnZ2VzdGVkIHRvIHN1
Ym1pdCB0aGVtIGluIGEgc3RhbmRhbG9uZSBzZXJpZXM/DQo+ID4NCj4gPiBJTUhPIGNhbiBiZSBp
biBhIHNlcGFyYXRlIHNlcmllcywgbWFpbmx5IGJlY2F1c2UgdGhpcyBvbmUgaXMgYWxyZWFkeSAN
Cj4gPiBxdWl0ZSBiaWcuDQo+ID4NCj4gPiAvUA0KPiA+DQo+IA0KPiBJZiBwb3NzaWJsZSwgcGxl
YXNlIHNlbmQgYSBwYWNrZXRkcmlsbCBzZXJpZXMgX2JlZm9yZV8gYWRkaW5nIG1vcmUgY29kZS4N
Cj4gDQo+IEkgaGF2ZSBiZWVuIHJlbHVjdGFudCB0byByZXZpZXcgeW91ciBjaGFuZ2VzLCBiZWNh
dXNlIHRoZXJlIGlzIG5vIHRlc3QuDQoNCkhpIEVyaWMgYW5kIE5lYWwsDQoNCkEgc2VwYXJhdGVk
IEFjY0VDTiBzZWxmdGVzdCBwYXRjaCBzZXJpZXMgaGFzIGJlZW4gc3VibWl0dGVkLg0KWW91IGNh
biBmaW5kIHRoZSB1c2VkIHBhY2tldGRyaWxsIGNvbW1pdCBhbmQgZ2l0aHViIGxpbmsgaW4gdGhl
IGNvdmVyIGxldHRlci4NCg0KVGhhbmtzLg0KDQpDaGlhLVl1DQo=

