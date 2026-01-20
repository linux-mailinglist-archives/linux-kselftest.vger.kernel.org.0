Return-Path: <linux-kselftest+bounces-49488-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2FDD3C57A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 11:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2CBC72966B
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Jan 2026 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC053D647C;
	Tue, 20 Jan 2026 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="eo7s+tYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013002.outbound.protection.outlook.com [40.107.162.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60A02E7635;
	Tue, 20 Jan 2026 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903838; cv=fail; b=iy+RCQM0rTB6xViii1wJPrlmIRMq4iBpzWzHM893NxI1L5c6igu98qs12DqpWihxUuiHxyGxYImJ73ox/xcPE3twNnxD1a0IHRezShNnlABBLbAylX9N8WS5Gzmrc0lWRq3n741t6c9PIx1TOl27DFqLTQVraVVP9v53C540lpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903838; c=relaxed/simple;
	bh=Iqbz8402X4rMMPjA/M9x0JbnqGB710sCzzgV3M1QlMA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=btZhw/Zw2m21nWRx9VEL1otC6nXExBPbdOIaARGkleTivvV3zLfPz1Cl1o83rN8T86gGUprt9Md9IxVBhxA6DIAFZespUMkYiCHq+p1GP9vdGGVCqGFHfwW8FkO748KCP8e8Yi3e57TEsqo+t+hYihZAWt9PnqAgol8XyHYJorU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=eo7s+tYd; arc=fail smtp.client-ip=40.107.162.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sfc1OX7oG8gy340xOvtta+QIagGYTdDWZqGdviJ0u5mNCocQuvxnLQAF0srMlvEHBv1LDmXlC1u9VyOCQNxJCCpo5xIg1EluFw1MkwvaujiCk+TNslta1HjrMDz3PNL0PokaOlGXY633oMCKEYAScX/hF6NYdTq1F7p5IVexmuccUeivzxspi0Cmi0ftvTTkWR8Pz6ZACPCFV7c3trFRz+2N0AEaWigvjapfAiQRDNbWmEo5Trj2N2rrRjE0+mzrqSF2RwM/hX3OiTj0l8Skx/P2OycqgpDQKvy88RQIjBJmfSltG0N6EJobk+IwH40h+KdRCUtIBY+Z6cT+W/Kqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iqbz8402X4rMMPjA/M9x0JbnqGB710sCzzgV3M1QlMA=;
 b=I9Cs/t4YxbygcmUd9GnvkD0pc4zhJS9uzjWKz/k4NO3uegF/oTR3c5eOvxHuadnOJYLFDN15jOg4Dvmacz4LL/7n+xcqE21X0C9rDuSJLufZ4ZzzF/V6Lg6FfW/oPA/9Z3ScxwcvotnWPc9qoLMNZaSbQWg3YxV2knuwB1IrbzrtdKUVGcs+XA0aA9+ee7+2e6kS7wnqO9mX+5qKoJKOFwonaNGh0wGjUuyTNK198YD9fcTHftNgZ8lVBUOZzm5zK0EQov2YILkIFUb47ZADLs/N/WJZqM0oAQKBN8UmItxRIj5fP51S20Gqx30zPK8zi9HyI3RJdJeJa5qUTz8cdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iqbz8402X4rMMPjA/M9x0JbnqGB710sCzzgV3M1QlMA=;
 b=eo7s+tYd5UH3a47kaWoUNnYU/ju/BKeUcOe6uzr0l+2RQ4Xhz9XR378c4JqPD+TLeGnfDVgT93G9v8Y3eOYsVm4v20xeAJDXcmOWfZyIB8RYU0upsGcKPLY5HSKhdnL9BOxYIY+CRXzDMUJSQdCga90cBL3vcLc22ow20X6KGuVNA7KbsXJgEDaTSiZR5+gUKXyZ2LZb6nrjJtHAOmqkng+I4CoG3LSG0IZKONM5TXtfgxrMM/91XTSpQ2CdjX504zioWUqzefcY95sOcZ7Du6qVHIFUUrwQD/DAZw43saa34CqFQ5IkWy0AzZStcAa21/YIbPgylCHjWRkUvz2Uug==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PR3PR07MB6779.eurprd07.prod.outlook.com (2603:10a6:102:75::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 10:10:32 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9520.005; Tue, 20 Jan 2026
 10:10:32 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com"
	<parav@nvidia.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@google.com"
	<kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>, "Olivier
 Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and NEEDS_ACCECN
 identifiers
Thread-Topic: [PATCH v9 net-next 04/15] tcp: ECT_1_NEGOTIATION and
 NEEDS_ACCECN identifiers
Thread-Index: AQHciXWvj7UB7ca7zUGYSIAOtFn3orVa0myAgAAEV2A=
Date: Tue, 20 Jan 2026 10:10:32 +0000
Message-ID:
 <PAXPR07MB79847F5AFB420A3B92DB65DDA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-5-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iLzynvieqZUVK3NqaSpMT=-toZ1M4QHvQin5gHQM7T8yA@mail.gmail.com>
In-Reply-To:
 <CANn89iLzynvieqZUVK3NqaSpMT=-toZ1M4QHvQin5gHQM7T8yA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PR3PR07MB6779:EE_
x-ms-office365-filtering-correlation-id: 01b4e3e0-5ac4-4d1f-aaa5-08de580c2558
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zld5V1RzSjh2bFhJRiszNTJRaWVGN2Nwd0x6dnNhWjJLTXJzOGR0NlVtWGMz?=
 =?utf-8?B?ZXNxV2toOW1NN1VuanQydG1pOVcwNStvbG9QL1o0NUU5aVppWE9mMmhtd1NM?=
 =?utf-8?B?ZTdqSXYxeUt0SzRXQ1BkdkxoMzU3OEtZbHhIY0lRRWViT21PVkozcDc4dytj?=
 =?utf-8?B?TjgzQ0h5ZG85RDBncGRiWDlaRFJmNUtIWGhJa3ROa3g3ZVVycnVTYUhJZDBP?=
 =?utf-8?B?ZHRwQXdtZWl1VlBnT1Zudm4wc3NjTC9jYWw3azlaVnIrUmhXQ0FIaUpDa3Mz?=
 =?utf-8?B?cUFKK0N2MXdwdUprdGZIbzh5TVJHblZQOCtUVFlGK0NRTTN4d00vbGlEUmNw?=
 =?utf-8?B?cGlRemd2bmUxMnQ2ZWU5ZDBESDc5WTMremNMeXFXSyt2MEZDMDAxcUo1NnJr?=
 =?utf-8?B?em1xTjdkUGlUQ0cyTStpYXRUZWgzUkkyVXFiQ2R3MEl0N1dxZkxIdzkvSUtS?=
 =?utf-8?B?NGZWVDg4N0dxVEM3dTlzVGxQKzFHTFVVNjVQL2JFVzFaWWdPZnB1RDhrWTA4?=
 =?utf-8?B?ZlovdGRXbWQ2OG9Ic3Z1UWpTdk5USEZTZDY2Q1M0VHVkWWxFbGtVS2krVkFK?=
 =?utf-8?B?Mk5VRDkzSlRnQzBIYVNnTGplOFpaQlRnWEI0UlozSG43bkkwSktBZ2RDa0V3?=
 =?utf-8?B?WVk3WVBUdzlOOWhLdm9oWHRKUmpuWTh2dEp1TmplQjFSbHY1c2V6WThjWmk5?=
 =?utf-8?B?Q0xqOWVNOUduM1RWUlRkU0kzclFwQkpsYkFoSXlYYXFkNnZSdWRrQkErVTJs?=
 =?utf-8?B?Wk1pQXcxV3ZpRjlCa3NUUWorUXNvUS9Qbk9PUmw5d25CdHZSUk82MFk0MmZq?=
 =?utf-8?B?aW1xRmVjU2hHbmFXb3VQRTJvbGU4YkcvRnlWQVNVU0ZFc1h6VjIyZkIxc1lL?=
 =?utf-8?B?ZjZpMVRlMFNDNUQrNkswZzc2cTIvVUh5YnBTbUNQOHZsREpaYko0cThubWRB?=
 =?utf-8?B?RjV6a244U045UU1sZmQvdno1VmlqcGowb2lja3Ftd2lyYUQxcjZpRjc0bXYx?=
 =?utf-8?B?YksrOGhHNEJIS01qK2R1SVEwSVIrZWtYZTV5Qnkzd2RqRDgwaDVXTjh4NEh1?=
 =?utf-8?B?UkxhU0ZORTZDeUxXUkFFNnh4Sm5RUXd4a3JNbVU5YmZSeXJWT0lCclFuYW5K?=
 =?utf-8?B?VmNYajBsMkFWUENDeEl2TFdiR1lwRE9yVlZOTkwrYWJPYll3MlhHVHhMcWNI?=
 =?utf-8?B?anc2RVVRMStybWdPWWNRSzZJNFp5SW5sOHpiZnQrM1daMXQ0VHVkRE1JN05O?=
 =?utf-8?B?SHpBUWp4NWhJcklVT1ZzSlpyKzRyVmdETy9HcUgxVDhOaWVoemN5ZUY4ZXZJ?=
 =?utf-8?B?VGpJQ2lOTVB4SitMdXlvWDVBUWFIcHdEeWlRcElKTnZtTzZpS3A1eHk4emZ1?=
 =?utf-8?B?OXovakg4Y3I4aEZPNFFWalpPdU85YmZuaUZQWi9uSnY1OEVZNGNySkoxOG1u?=
 =?utf-8?B?YjZGck1XWmQ0RXZIWEw3eVdZS0ZSbFUvL3ZHekdlUm5JMzJmc0g4eVhkR3ZM?=
 =?utf-8?B?bmlBNDhQNVlkMlJ5ZGpWM29rbWhWa1hSV0Q4YlFjQ1NMSkczNEtCREErMWJa?=
 =?utf-8?B?dW5sQ3hPMzl2akI4dDMyYzA5WFBldERObUp3WHpEMWNJbEsyUUZySXhqZHFZ?=
 =?utf-8?B?dCtuVXI1dDhNY0ZyT0ZaK3FwOXdSSlBoRGFQYXNvR3JZVVk4OGxVbVlicUZB?=
 =?utf-8?B?Nk5ac3R4M3J3aitEVGE3eU5WTm9qWUQramNxQTNieEFnVmpnaHR2SmZ3REs1?=
 =?utf-8?B?aGpMZ3AxeHhadlB3TndTK3Q0S29TNGJXR3B3aFFGS0FaeTRyeGIzTWNyTjJJ?=
 =?utf-8?B?SHZnRXROVGtyZUVsY040U1BHa0JuNzE2MUFRZlFzMXVEeWdCSTV3UERWTlVo?=
 =?utf-8?B?MnlQV09JdmI5Z29wUGtoOWdCeFFDSmcySzdyc3RYVHoyOGdyZGZ1RzY3MUdl?=
 =?utf-8?B?MHZOa25aMmZiaHZZVWFUTTJ2QmhKZW8yMUowSkY5UG5VSVdjWUY0aGNwcGpP?=
 =?utf-8?B?ZkpNRnFnL2V6SXBIdEl4K2YwOVpLRHlaNWZLSk5nbTVQSkJqcTRBWVFQZW05?=
 =?utf-8?B?N3NmeDRmT2ovOHFBRGE0MEV2c3ByVk5NR2JoaUk2MlE4c05COE5TdmdwRXNB?=
 =?utf-8?B?d1VHd0VUSlZZQVV2OFI5bThTU0QrZGhIc2ZOQU5Vdm12MEhLdEp2dUZ5R1ZQ?=
 =?utf-8?Q?YUU9URqLzDHTSp7XIIQ3W38=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXlDZ0VLQmp2OUUvRkVWSUVMWkkwdVlVdStZSklCNnBqUXkyV1IwQ3NBbmVE?=
 =?utf-8?B?eithVTNxbEl0Q2Z6Qit0KyswQlQ0d0gycEFQb28xUFdMUXdzNmtQK2tvYlF0?=
 =?utf-8?B?c0l3MUZYbEVKZ2QwOUF1dytMOERMOElRemJsNTg5TlV5YzZSc0hReWJBSzBB?=
 =?utf-8?B?NUVWekZaajhKblAzQjVjMklxaytuRmgxYXFiSHlRYVBTZkhUTk05MlRVQ0FS?=
 =?utf-8?B?VHQxY3BaL1JwYWVXZEpicGFZbGNjZy90d2F5blpDQ2JHU3V3OXkzclpBU3hV?=
 =?utf-8?B?Wlc2UVdsWjV0d21xZUFKNEZsZjViWC9yWVhZdElSOTkzL1o1Z3BkNVBzTFVv?=
 =?utf-8?B?MStoMmtTbHFDcEFsNjB6ZGFtYjhGS2JDMTZ4RXEyTVVQTzJuTUxKcDBXcjgw?=
 =?utf-8?B?djNET3h0K3lnSlNEUkpwaFdZRHJ4MXdmb1Fmamd5SjZlMjFrYW44WHkrcDRP?=
 =?utf-8?B?L3lmOXRONDVEb1R4ZC9zN1NTc0g4cjIyYTdRSitGNWZsdDlHS2lZeFI1Ui83?=
 =?utf-8?B?L3RsMHg5V1VjRVVEMUhMUk5qVkpYMkFwYlU5NldvRjlyaisxQzlvRzFUT0Zp?=
 =?utf-8?B?NVpmSGNNTmp2VGxaSTNXV1h2Mmpoci96TWdsbm15bUc5dmF3emRHRFpnOCtm?=
 =?utf-8?B?Y2VlRFRtcEpYVzdkUFNURFNjYnliT1RnNCtyaEdaNnJvYXk0RkFYeXk5eHJm?=
 =?utf-8?B?bDJUUmRKc3hSd295Uy95bUJpOTNWeFBxU0VxWVFJN1ptTGZnV255dE1lRkxs?=
 =?utf-8?B?MExINEdPQXppQjk2Z3dFSmE1OUNVODBEY0c2T0d0VG54YnpRRTNzVVpMYklL?=
 =?utf-8?B?dmJmeFVhYzJCWkNMRDZlVmlWbGpka0g2WnMyZ2xyNVhJT1hQTEpKcHhNM2tl?=
 =?utf-8?B?NDNYVitLa2dWSzZNVitIYU5ITnNpdVhaYXFGN3hUZ3YxZjdUSDZTOG1jSm0x?=
 =?utf-8?B?Qjl1SUhaN0R4N2l5bjMrL0NuN3p6NkYzUGFGMVhPMExyL2tUcU9oTldWWmxO?=
 =?utf-8?B?eit5Q2NUQUw2QXBuWTFFcDYyMEhJYmhKUGNnR2duS05VMElYaWVjME9tcHdN?=
 =?utf-8?B?aVkrTStJM1hSeVdNMVphZXY4di82WnQ4V0hHc0hUTmZYL0VrRGZOdXIvYnlJ?=
 =?utf-8?B?TUF5ZHh5YWJmTnU3bGtSTUNDTi9jRytiMU8wb25WdGE2eW56Mm0xRkNSeFRt?=
 =?utf-8?B?TGZmN0poOEpQNzMxcHIrbjNjR3hFYmppeDVUK013UXVzWTEyMEE4NnY2UzMw?=
 =?utf-8?B?cFpraUxDNWM5bzZIQXNTVGFQRWkrd3p5cjZULzFnTEpNV2VFVWhsUjhhekVO?=
 =?utf-8?B?WEtuUWFTUXlnTWc2NmZPTFpFb1pUK3dOdk1zclBzWFA4K1YyWmN0Zk9aWHdZ?=
 =?utf-8?B?VWNoYmxXMEk5SlE2K0hicU8yNk9sWHZFR1UvTEwrSG1HZmpRQm9lK2RoTUkr?=
 =?utf-8?B?RnNqb2lyOWtNWnIxazQzdWdnQWhkcHF5OWRxUDlYZEFvRnhsSFhUUDRhWFNp?=
 =?utf-8?B?M2lLWHJzS0tUSzZwWFJhVVM0SFcvUVJWbHNSZ2o2d2tGdU5QUWVLK2wwWVVp?=
 =?utf-8?B?NDdLdWlQVVFYWWZNOEU0bThEbWNkWmJuRmtRaWlTOXR4QU5HZ0Ewa0R4YXFs?=
 =?utf-8?B?MWpzOVpOdDFQcGl5aTdoODltOW5PbU5XeGZxdWV0UW9CblB5VWN5Qk1jaExs?=
 =?utf-8?B?Z2RuSSsvandMSzdsaEpQYVRMRWxpTDZ1UUdMZWlFWHJJU2F3QUlmaFlkNDRv?=
 =?utf-8?B?eHNFWGtFWXQ5L21yajIzSjRuRkc1U0NPb0o2c0J5ejNLODJFL1pDcVArcUJo?=
 =?utf-8?B?WVJHY09aenJLVTA2VFYzeElrTFlMVUdFSmZDV2w2R2UwTlZsV3pPMjRiQVdF?=
 =?utf-8?B?R3E3QjdCWXlCMHRubE1VT0pFbjZRSjdPQW0rVHY3dko0UmdDQ3pWS3BOb2xS?=
 =?utf-8?B?MDRZU2xwNFYzbnJycUpwa2l5eUJScTd0aDlFMHN4aktkMmtlS3ltR28rSTVL?=
 =?utf-8?B?U0ZqQ2xNZU9FdjRiVnNtNVNLS3h0UDllK2gxSWRJRjdETEFlTXVJVDJHSDdF?=
 =?utf-8?B?b2l6TVRzLyt1OEsxLzcxTmZoc0RqNDJrMWd2UmsyRGlzeitwNXQ3N1ZCQmRI?=
 =?utf-8?B?MFRiR3R3T200ZU5jK2dtb0xzcjhLN0Jzc0l5TUFKOUJRSm93ZTRZWEY3MzJI?=
 =?utf-8?B?Tm8wWmhUeW1FNWU5cWpjZWswSExIb29ZZXNIVjlUVmtRNGEwV1VtUHRwK05P?=
 =?utf-8?B?K3Q2Y0JRQ2loK3FuMHViZGJ5enRpM05ZaVd5S3dMQVVLSzRBQzhhOFJZVmI4?=
 =?utf-8?B?RHhzaXR1aktOZEJaRGQ3V3NKcEhsMkozMmtLUzRnMkJrTHdKRnFKQkVYSU5j?=
 =?utf-8?Q?9ZGIx3uvc//8BxK8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b4e3e0-5ac4-4d1f-aaa5-08de580c2558
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 10:10:32.2503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0Cxk+MqXRvcweJ7EvdBgrfo8xzMXsD/5ym4haqGeuXnYzy/WXf622FxXpuV1i+yCGVsrry4DU0bMgCco5iDJXY1UiMKU+lvbMaLsYWZvnVRr3wPcZhG4TenTXHzK/O3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR07MB6779

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBKYW51YXJ5IDIwLCAyMDI2IDEwOjU0
IEFNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVs
bC1sYWJzLmNvbT4NCj4gQ2M6IHBhYmVuaUByZWRoYXQuY29tOyBwYXJhdkBudmlkaWEuY29tOyBs
aW51eC1kb2NAdmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9y
ZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAZ29vZ2xlLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1v
amF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsg
eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBh
c3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBs
aW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxA
Z29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5v
a2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hh
bnNzb25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hp
cmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RA
Y29tY2FzdC5jb207IFZpZGhpIEdvZWwgPHZpZGhpX2dvZWxAYXBwbGUuY29tPjsgT2xpdmllciBU
aWxtYW5zIChOb2tpYSkgPG9saXZpZXIudGlsbWFuc0Bub2tpYS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjkgbmV0LW5leHQgMDQvMTVdIHRjcDogRUNUXzFfTkVHT1RJQVRJT04gYW5kIE5F
RURTX0FDQ0VDTiBpZGVudGlmaWVycw0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0
ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBv
ciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlv
bmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBNb24sIEphbiAxOSwgMjAyNiBhdCA3
OjU54oCvUE0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4N
Cj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5j
b20+DQo+ID4NCj4gPiBUd28gQ0EgbW9kdWxlIGZsYWdzIGFyZSBhZGRlZCBpbiB0aGlzIHBhdGNo
IHJlbGF0ZWQgdG8gQWNjRUNOIG5lZ290aWF0aW9uLg0KPiA+IEZpcnN0LCBhIG5ldyBDQSBtb2R1
bGUgZmxhZyAoVENQX0NPTkdfTkVFRFNfQUNDRUNOKSBkZWZpbmVzIHRoYXQgdGhlIA0KPiA+IENB
IGV4cGVjdHMgdG8gbmVnb3RpYXRlIEFjY0VDTiBmdW5jdGlvbmFsaXR5IHVzaW5nIHRoZSBFQ0Us
IENXUiBhbmQgQUUgDQo+ID4gZmxhZ3MgaW4gdGhlIFRDUCBoZWFkZXIuDQo+ID4NCj4gPiBTZWNv
bmQsIGR1cmluZyBFQ04gbmVnb3RpYXRpb24sIEVDVCgwKSBpbiB0aGUgSVAgaGVhZGVyIGlzIHVz
ZWQuIFRoaXMgDQo+ID4gcGF0Y2ggZW5hYmxlcyBDQSB0byBjb250cm9sIHdoZXRoZXIgRUNUKDAp
IG9yIEVDVCgxKSBzaG91bGQgYmUgdXNlZCBvbiANCj4gPiBhIHBlci1zZWdtZW50IGJhc2lzLiBB
IG5ldyBmbGFnIChUQ1BfQ09OR19FQ1RfMV9ORUdPVElBVElPTikgZGVmaW5lcyANCj4gPiB0aGUg
ZXhwZWN0ZWQgRUNUIHZhbHVlIGluIHRoZSBJUCBoZWFkZXIgYnkgdGhlIENBIHdoZW4gbm90LXll
dCBpbml0aWFsaXplZCBmb3IgdGhlIGNvbm5lY3Rpb24uDQo+ID4NCj4gPiBUaGUgZGV0YWlsZWQg
QWNjRUNOIG5lZ290aWFvdG4gZHVyaW5nIHRoZSAzV0hTIGNhbiBiZSBmb3VuZCBpbiB0aGUgQWNj
RUNOIHNwZWM6DQo+ID4gICBodHRwczovL3Rvb2xzLmlldGYub3JnL2lkL2RyYWZ0LWlldGYtdGNw
bS1hY2N1cmF0ZS1lY24tMjgudHh0DQo+IA0KPiBXaGlsZSBmb3Igc29tZSByZWFzb24gbGludXgg
dXNlcyBpY3NrX2NhX29wcywgSSB0aGluayB0aGUgdGVybWlub2xvZ3kgaXMgYWJvdXQgIkNDIDog
Q29uZ2VzdGlvbiBDb250cm9sIg0KPiANCj4gTm90IHN1cmUgd2hhdCBDQSBtZWFucy4uLg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IEVyaWMgRHVtYXpldCA8ZWR1bWF6ZXRAZ29vZ2xlLmNvbT4NCg0KVGhh
bmtzIGZvciBmZWVkYmFjaywgSSB3aWxsIGNoYW5nZSBpbnRvIENDIGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNCkNoaWEtWXUNCg==

