Return-Path: <linux-kselftest+bounces-45306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D11C4D552
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 12:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B2984F54F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 11:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1771034A782;
	Tue, 11 Nov 2025 11:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="SeIq6w5u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013013.outbound.protection.outlook.com [40.107.162.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4A82EAB61;
	Tue, 11 Nov 2025 11:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762858974; cv=fail; b=S7lH3dBITkTw/5auu3XkfMk2EC/vfxf6rflhvYSDGWIDLCa429MfdlLceIk3RJfvUokWVBE0jxyXJrirdcOQR/XyFXKwJ2Q5YiqZGXM6Ly7Gf1Gs305CnptmqKRI8xkRGiwSQKfHa6NVErzDIrk2POqK217bMSeEEdsPx9/axvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762858974; c=relaxed/simple;
	bh=97rB6o63dt3y79G+ucbUVg6Ch7U1knynuWb4k8FfkAk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=u8WkNBTOZHNWS9pP6gnrd9Au0NIyzpCu5Uv6JOACmMaitJjH+ZNYqVk8kc1Nfa7zQfvhfxWDQnT0GugewMRw0CDGvokM6LjzkyDcKxv4UjjN5A3IWBTmI36mRUZqgquaB3HpSMCaqVRHnA91ex5LJyvZudQlWjXSpfzGFEhWTRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=SeIq6w5u; arc=fail smtp.client-ip=40.107.162.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyeFzosXQLQKV6ZBXqMt5p3HTf4B+Jj7nGfeswTrLlrT/x3g0FGYuj8Kb0YmxN2nmcp9iEHq1TtCJiQ0SFq1tILkWV4TJVZZNVIL8odik0u5Kp6b0wf7tT7+7BXChFhM5Oibp26V5RTa0J/odrmt8yNxmdiIj0ITyS9nJsloEN9pCazYThTu3Imk3nih0C9e719ebGKePdltDKtOOwG1gR4qzVrM/UaSWr97PyEBd+FEBtshnzdxizGnhwccHkPlmIfWXdJ0xU9fYqyJwswyWApRCGE7Spi7BG7Coiv2h6k7Zd20t7GPBMsgUcPP0aVwpC77OucssnNepEEvnrCRCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97rB6o63dt3y79G+ucbUVg6Ch7U1knynuWb4k8FfkAk=;
 b=nJkz8riapdT52MJkDDXflS6SHwE2rfUuhzbcH0NsGu88we/arcDWKfIhvJtLPzciPc8QcLPT3a99qI9WRa24Yx69flNuGrEsJfWQAmqzJwWUZK+QlRaA0NO8IkGu5BTFnN5aUR0gUduypZOQEQOHDNMBSCRwO2Hb4b2nonvCe1KA+ziNjNawPgO6v7zRB1cyBoYFRnEcorajNl6adXJ9g/KpgTXdk4LCoUu84kE57oKbSReTPiWwkoSf21Gak3Xc0CO4DwerEESP+/7x5mrTh1twrjj4wOWhUbrNsmAkTiqpGHQutfVAic1nm1MDkbdZlrJ/57OLN06TlhXlcBD9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97rB6o63dt3y79G+ucbUVg6Ch7U1knynuWb4k8FfkAk=;
 b=SeIq6w5uzaf0EdjR8XZas5fCs1v+NPpsv9rFhkii4fu0S2lcYP/BYkadjhsKVt4JXj4fXKbuom7OGw/F62Pu7LvVjjREqh2JK1T2lX/sJI1ZQ7vw7/49814AMp/JgCA20amKmAC5MCyuRuw2yE1M04tpTC9a8oWEh+YJELUqZe6h5Ppqe3p4yXeWw1UNc7u5Ih/FXNlgQgC4PiuIXIsSdRJcOcZaGpeXyF5239FNq4bJ2B7s4UijBwuxKQjv47fN6UaBj1R5Xg+Qym9fJzZRbyGGU/YgI2btSn1/pWdVwk/ZYMIsgqflkAKM48DqtAAhy8FcxDt/FE23J8gILMGZNw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB6335.eurprd07.prod.outlook.com (2603:10a6:800:136::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 11:02:47 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 11:02:47 +0000
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
Subject: RE: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
Thread-Topic: [PATCH v5 net-next 10/14] tcp: accecn: retransmit SYN/ACK
 without AccECN option or non-AccECN SYN/ACK
Thread-Index: AQHcSapcgflniMzwkEOUH36l3bIQK7TlmHeAgAS10oA=
Date: Tue, 11 Nov 2025 11:02:47 +0000
Message-ID:
 <PAXPR07MB7984CE5A8244BCE2D4911A0CA3CFA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-11-chia-yu.chang@nokia-bell-labs.com>
 <d1045b08-2cc9-42c7-816b-ba467c27086c@redhat.com>
In-Reply-To: <d1045b08-2cc9-42c7-816b-ba467c27086c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB6335:EE_
x-ms-office365-filtering-correlation-id: 9d753ff7-1ba2-4557-fc54-08de2111d967
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MGxXUStLU05JYktncm1uVnBzeHg2TExMMWM4Y0pTSEZ5dFVOdTNRdmJvNlhW?=
 =?utf-8?B?ZE9UcFZoek5jYW9ldHF5VFl0dmlHRXFqNWp3eFNvZlg0SFlCUHpTbk1tUEdT?=
 =?utf-8?B?bUhZYW5kdE02c1A3YlF0WlVxQzBNTUJZZlk0SkN0bTVHZi9jMEYrbmhKWHNh?=
 =?utf-8?B?Y1JKMG1FSU5WZFF5QTlKOHFUWk9BeE94WnZrWERIZUhoSGc1aU5UVGdacEdO?=
 =?utf-8?B?SzRubWlIVTlzSXozbmRWVDJsby9Wbkl2NEtkVWtnRlFxN2NWVGd4bDA0c1VE?=
 =?utf-8?B?bEt3NzVGbDNXVitYTkVxOWdHWGtUU2JPdDZXNUp5QlgwQ0NpbDRLSVJYWElO?=
 =?utf-8?B?bE9RRzhHZ3ZMS205RzdNQ3A0SEV5ZU9kUGFpSUxta1RoZTZoTEtoRE1hdEpV?=
 =?utf-8?B?TGIrSG9iOG5HSXZhemF5QzNhMG1hc0Fkem03blBkSWt6c3ZmbTFod1hsVGh1?=
 =?utf-8?B?ZnpTZVU4K2wzQm1wZWlVLys1c2VHVG5RVTM3c0FBSXlmcnFGM3lCMVM2RlhH?=
 =?utf-8?B?NU9RQXZkNVZ4bHd1dHFHSklnams4dDlqb1ViMjBObkFkQmQrcmVNUlUvakZS?=
 =?utf-8?B?eld6M1dMQjBOanEyLy81clJiaGZGUlBaTmY4OWtsTGk5M3dpUnhOUW82ZmhB?=
 =?utf-8?B?eFRHZVVaSlZnUjViVEUrK3NQbk9BQUV6U0tSZjdBUFgzWFQ0N00xbjh1MXpx?=
 =?utf-8?B?bTAzeWQwa2JDMk5XTm9ETTNiYU1QREVNbWpRSEZXZllzSnROdWNuZnB4RTRu?=
 =?utf-8?B?enNDVExmN2JLMmFJR3QvZlVFOEl6SDZBZTQ2YURqTzdsTmlkUnpDMWYyT1Jr?=
 =?utf-8?B?Q1NYRDM3bitjS0RKdjNMVnRBUUV0QXIvdzlpcGpuZWVnR3QzQ0dGSXFoaWww?=
 =?utf-8?B?ZEx3ZktKelptLzM2OERiWFRpd2tsV3U1MVNNTGNHd0FzczJZbWcrN0pwNTgw?=
 =?utf-8?B?L1Z3UkVMVXNnS25WaWhPOHVyK2Z5NnJPM0kvUFBtT2Q0QjB1b3VwTXhHOXJo?=
 =?utf-8?B?NUo2NEp3azRxZVdHMnUrVTRoaWtnVVE5QUFYYzhFcXlscXoxZGpjWVBwdGNv?=
 =?utf-8?B?U0w4REZFYURESmVuSVZmbWJpV01ONEFIL2ZGNlJOTTBtWk91WTJBU3JTQlNO?=
 =?utf-8?B?Y2hRaHByL1R4UUMyR3JCeU5LNzM3YVBCRm9OVUw3ME9MVGlxN3Z0QkV5YVEr?=
 =?utf-8?B?VEo2d2ZtdWRHdkl6cWN0cXdENy9Oa2hZNWYvWG9hRXI4SUZUeWJQaTdDUzVx?=
 =?utf-8?B?NFU2OFl1K1dXeFV2L2ZSTm1rWjMvaWN1K25VemVsQ0hOK3dEeXROWTBOTER1?=
 =?utf-8?B?UElPT01aSXFZMkxyWUJwQjVzeW40N2NvdkxUcGRuSm9WbnpVMnpYaDNCUmxF?=
 =?utf-8?B?MFdnU1lINUlQRCs4NE1LOVgzRnlYakJUUGlOaFZFN1V3ZmVvaWpGbFJUeE0r?=
 =?utf-8?B?V0locnVJcEhxV095V0t4SzF4L0NMemc4N1BxUWcxeGl4ZWd5eTh4QU9GZHVY?=
 =?utf-8?B?TUZoUElPcVRoV3I1Uzlob2JWOWMvSGJxWjl2WWt0K2hVRW9xQXgweVBlWk1r?=
 =?utf-8?B?NzlzWjhkZEx2dkM5OXJnSldQdGVQVVRBdEhpZGhHOU5UUURjaGsyai9DYVJp?=
 =?utf-8?B?OG9yOWlLRnJEUWpxbFJieE54bnJwVVV5Wkd3ZU0yNU5CeEorZEZGcXVPczhp?=
 =?utf-8?B?WWJqbm9UZjFaTURiSkIybkhjR3FkbDF6b2E3bnJkWWRUMDNwSXlSYkY1ajlZ?=
 =?utf-8?B?T0QyeUk0Tml3OXpHa0ExZXp3S2lIRWhrZk13NmZQVjhPdFk5YWZzNzZuRDJI?=
 =?utf-8?B?ck1KbTNuWklOSERNL1YvY20zWExET2JpbjUzOGJoMzR5b1h2S2ROYTcybE5z?=
 =?utf-8?B?dHlQd0NlM21NVkhYcVBkYjQwdDVCWkEvanpNV1RrZC83MlE3bW1VNGdEOXcw?=
 =?utf-8?B?QW4yc1ZVaDhYSEpjaVRyMk1MWVdQbC9PZXpWMXFVU0Z2anBkQXpOU1lGUUNS?=
 =?utf-8?B?cy9PaWs0cjRMdHMzaHZXaFd4K3llVDB6a1J4c1FvUU9oUnlkRnRHcmJYM0k5?=
 =?utf-8?B?Y0FmZGRLS1FnckczanRSRnY2aUVxM3FvQy9BZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VFNTNElKakJkZUdjL2xPRFZRRWs4ODZFb3loSVpJMUZIK2c2SXk3Q3hBaGZH?=
 =?utf-8?B?WmJxNnVhaktNdXF0aWNheUkwM0Fzamx6dlY2VC83eUtITlNaa2tzVW9WdXIy?=
 =?utf-8?B?UGFyWjNqSzE4RXBjWWhDUUJjQmpMdXU3aStwQzdxcHRmT29haXZiZGVNWno1?=
 =?utf-8?B?TGxIdFppUUtnQ1IwRXBWQnZpNlI5aUZHODF5M25QTmo2and0eHBuakpVSVho?=
 =?utf-8?B?dGNvYVBoUVdQUENoSjdqZ0QzRG1TdDNnYUgxRmh1NUc3c0RYRnBLNkdkSzA1?=
 =?utf-8?B?VjY1SDRtb0FBYTdpVlhkSkE3ZTJOOG5KTmhWM1VkNEJtVkZabTJkTXRDcVI4?=
 =?utf-8?B?WjF0Y3A2QlNyKy9LZS9WNFZiL2xzZE4yNzhXckUzaUEvanMrQkc2Nkp0ZWxa?=
 =?utf-8?B?UTdqNUxyQkxVQW16MHNIZTJSdHpWMmRHeVJzcFNLRmNiMHBObHJrSzJ5VDRH?=
 =?utf-8?B?bmxHMXQ3cmk5ZEI5T0U0ajdvNWYrbnZ2MzFGdEYva1hBNDA4NjVGbytBdFIz?=
 =?utf-8?B?R2FZU0kyYytrM2JmZkJ3MmVKNFFXY3hWMHJ5TzRZUVQ2N1V3SmF2VE1xZlBm?=
 =?utf-8?B?T2RzTlRrbWM3QWxPNFljcU1vc2JPdTNESUNtQndCRHpFcEszOGg1U0pJNGY2?=
 =?utf-8?B?aC9MRDd0cEdHZmVJckhmS3hlc0VpT1FLamdTUU1mYVRDQ0N6enFkb25ac0JK?=
 =?utf-8?B?ZHQvRS9pVWVxbkdGRlRwbmxkNXR4bG5IZy9aMW9DdllIVDZwS2NRdG1UZTFK?=
 =?utf-8?B?T3JwMHRYWGtRUzE0dzB2LzY1NXltQmp4Q2VWdzh3NEZMUFlic3pSQlBvRG80?=
 =?utf-8?B?Y09nYWd4NXIrd1B2bWVnSTRsbEVxdWhTbFdFNHBTZXE4bnlaYUYwc0w5dnZh?=
 =?utf-8?B?Y1Q0UGZEcUtpYzk2TVBldFpvQnB2YWNRSFcvQ2l2RzVKbEhkdGVyTDNWcnJF?=
 =?utf-8?B?Vk9zQkRkVGxsckd0ei9MN1ZaaWUyYnZLNHZseHdPbDFyUytVWHRGL1hpTGNL?=
 =?utf-8?B?anljOHBZZDNHSko5NnVrWDI2TGs3aGFWMVB4RlFtNll1RFp3NmpycWszQm1w?=
 =?utf-8?B?SmFad1RlNS9QSW8zaU04dnEvL0I4WnNyaU9GU2pYU3NSMWVCbXpha0c3dDFL?=
 =?utf-8?B?ZG9uOHVoS3hQOFlwNnoyY0N3T245ZjkyWi92UWFHOEQwNGlBZm9UaGx2STBn?=
 =?utf-8?B?emV2QllNSEZiOVJVTklyVmNVTHhQNjRYS3JDemlydXNER252ZFZHQXJWTlNL?=
 =?utf-8?B?VGVhOUxnQ3hLbnZhdDFza2s0eW1WYXlLS1dsQ01MeS9PSlYvNXFBSUJmcVpH?=
 =?utf-8?B?NTZPMFRRQUJVcFZCcWJsY285MjlLTFdGaUJHekZ3VTVKOUEyRldlYldYQnpD?=
 =?utf-8?B?WFBBRUxsMUNua0prZ3FKVy9oMVBNbDB1RTRKT1BWSkFtQUU5VWliZHJyb05N?=
 =?utf-8?B?WkFTKzBreVo5L1lpYUNOdTNxSjBjV3R0SGNSOEVhMjZFNkg2U21lTEFmRU92?=
 =?utf-8?B?R2FxUFQycTM1eVV5RkNmUFNTV0x4QnZFbXp6M2RNZTUvaGlTdnVaMWhhMlN2?=
 =?utf-8?B?Z2ZKVEU3SktVTjNJNkdQckprWXB0ZzVTdjdIam1HenhYZ2taRytNSFB3Y1dK?=
 =?utf-8?B?UVc1VTg5YVZrQW5mQXp6R0lHWkYwR3RtT21YSFNLdDJYVWpXMExhS1Z6d0l4?=
 =?utf-8?B?eVVxV2pDK1l2ditJY2hLYzVFYTc5TlU0QlYzRFA1ZlZGMktnaGZzMkxzT3cv?=
 =?utf-8?B?b042NnBsdnR4V3A1aTRwWmEvTXBGUEp3QndhOW9aNGVTckpqNEVUWmwvaERU?=
 =?utf-8?B?UFhXWkNVRWZIaEdLU2hnOFY1ZGczSmx0aWtZeWVZVW45NGdBYURSWDN1WGtk?=
 =?utf-8?B?L3JYSEFpbEpaeEt5NmpTamlaZ2liNFFtVmt4Ujk4QnBwbTdKcHVDZFdiUVNP?=
 =?utf-8?B?L3B5R3k4RDFVMkRaVi9OZlZyYWQveFo4a2xUajAxRzdocXJGVjVYdHpkOEFs?=
 =?utf-8?B?QjB5VVB4VTBsR3dESWhiZ0N1SUlnL2tGTk0wTk82bTZlMkFhT0d4WnBlVlFP?=
 =?utf-8?B?SE9XalNWb2p2UTJzQ0tyekFhdENwWkRDcGFTa0k3MFJZVHJkbGI3a0prTHJz?=
 =?utf-8?B?MmF6c04yWmh1VzBWZHRVa0U2NDg2eUJXcUhQbUo5Y1VETEU3d014RVJvdWdC?=
 =?utf-8?B?elE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d753ff7-1ba2-4557-fc54-08de2111d967
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 11:02:47.8434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbUsWPcoeXtg5ajvq0xm4vje9N6DR3Qx9Q/h3r25sLUG6ELlma00SRO4phRLhjcXI6P+1gsUl4eVaJpW1Zsymxxvra9Bdc+KL62al4cvB8H1YMRzuZ9W34Xo8AOumIwa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6335

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgNiwgMjAyNSAxOjA3IFBN
DQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1s
YWJzLmNvbT47IGVkdW1hemV0QGdvb2dsZS5jb207IHBhcmF2QG52aWRpYS5jb207IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2Fo
ZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBnb29nbGUuY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUu
Y29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53
YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7
IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJl
cmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtz
ZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUu
Y29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVs
bC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNvbTsgaW5nZW1hci5zLmpvaGFuc3NvbkBl
cmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24uY29tOyBjaGVzaGlyZSA8Y2hl
c2hpcmVAYXBwbGUuY29tPjsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0
LmNvbTsgVmlkaGkgR29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgbmV0LW5leHQgMTAvMTRdIHRjcDogYWNjZWNuOiByZXRyYW5zbWl0IFNZTi9BQ0sg
d2l0aG91dCBBY2NFQ04gb3B0aW9uIG9yIG5vbi1BY2NFQ04gU1lOL0FDSw0KPiANCj4gDQo+IENB
VVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwg
d2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBu
b2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiAx
MC8zMC8yNSAzOjM0IFBNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20gd3JvdGU6
DQo+ID4gRnJvbTogQ2hpYS1ZdSBDaGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMu
Y29tPg0KPiA+DQo+ID4gRm9yIEFjY3VyYXRlIEVDTiwgdGhlIGZpcnN0IFNZTi9BQ0sgc2VudCBi
eSB0aGUgVENQIHNlcnZlciBzaGFsbCBzZXQgDQo+ID4gdGhlIEFDRSBmbGFnIChzZWUgVGFibGUg
MSBvZiBSRkM5NzY4KSBhbmQgdGhlIEFjY0VDTiBvcHRpb24gdG8gDQo+ID4gY29tcGxldGUgdGhl
IGNhcGFiaWxpdHkgbmVnb3RpYXRpb24uIEhvd2V2ZXIsIGlmIHRoZSBUQ1Agc2VydmVyIG5lZWRz
IA0KPiA+IHRvIHJldHJhbnNtaXQgc3VjaCBhIFNZTi9BQ0sgKGZvciBleGFtcGxlLCBiZWNhdXNl
IGl0IGRpZCBub3QgcmVjZWl2ZSANCj4gPiBhbiBBQ0sgYWNrbm93bGVkZ2luZyBpdHMgU1lOL0FD
Sywgb3IgcmVjZWl2ZWQgYSBzZWNvbmQgU1lOIHJlcXVlc3RpbmcgDQo+ID4gQWNjRUNOIHN1cHBv
cnQpLCB0aGUgVENQIHNlcnZlciByZXRyYW5zbWl0cyB0aGUgU1lOL0FDSyB3aXRob3V0IHRoZSAN
Cj4gPiBBY2NFQ04gb3B0aW9uLiBUaGlzIGlzIGJlY2F1c2UgdGhlIFNZTi9BQ0sgbWF5IGJlIGxv
c3QgZHVlIHRvIA0KPiA+IGNvbmdlc3Rpb24sIG9yIGEgbWlkZGxlYm94IG1heSBibG9jayB0aGUg
QWNjRUNOIG9wdGlvbi4gRnVydGhlcm1vcmUsIA0KPiA+IGlmIHRoaXMgcmV0cmFuc21pc3Npb24g
YWxzbyB0aW1lcyBvdXQsIHRvIGV4cGVkaXRlIGNvbm5lY3Rpb24gDQo+ID4gZXN0YWJsaXNobWVu
dCwgdGhlIFRDUCBzZXJ2ZXIgc2hvdWxkIHJldHJhbnNtaXQgdGhlIFNZTi9BQ0sgd2l0aA0KPiA+
IChBRSxDV1IsRUNFKSA9ICgwLDAsMCkgYW5kIHdpdGhvdXQgdGhlIEFjY0VDTiBvcHRpb24sIHdo
aWxlIA0KPiA+IG1haW50YWluaW5nIEFjY0VDTiBmZWVkYmFjayBtb2RlLg0KPiA+DQo+ID4gVGhp
cyBjb21wbGllcyB3aXRoIFNlY3Rpb24gMy4yLjMuMi4yIG9mIHRoZSBBY2NFQ04gc3BlY2lmaWNh
dGlvbiAoUkZDOTc2OCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxj
aGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUv
bmV0L3RjcF9lY24uaCB8IDE0ICsrKysrKysrKystLS0tICBuZXQvaXB2NC90Y3Bfb3V0cHV0LmMg
fCAgMiANCj4gPiArLQ0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvdGNwX2Vjbi5o
IGIvaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIGluZGV4IA0KPiA+IGM2NmYwZDk0NGUxYy4uOTlkMDk1
ZWQwMWIzIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L3RjcF9lY24uaA0KPiA+ICsrKyBi
L2luY2x1ZGUvbmV0L3RjcF9lY24uaA0KPiA+IEBAIC02NTEsMTAgKzY1MSwxNiBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgdGNwX2Vjbl9jbGVhcl9zeW4oc3RydWN0IHNvY2sgDQo+ID4gKnNrLCBzdHJ1
Y3Qgc2tfYnVmZiAqc2tiKSAgc3RhdGljIGlubGluZSB2b2lkICANCj4gPiB0Y3BfZWNuX21ha2Vf
c3luYWNrKGNvbnN0IHN0cnVjdCByZXF1ZXN0X3NvY2sgKnJlcSwgc3RydWN0IHRjcGhkciAqdGgp
ICANCj4gPiB7DQo+ID4gLSAgICAgaWYgKHRjcF9yc2socmVxKS0+YWNjZWNuX29rKQ0KPiA+IC0g
ICAgICAgICAgICAgdGNwX2FjY2Vjbl9lY2hvX3N5bl9lY3QodGgsIHRjcF9yc2socmVxKS0+c3lu
X2VjdF9yY3YpOw0KPiA+IC0gICAgIGVsc2UgaWYgKGluZXRfcnNrKHJlcSktPmVjbl9vaykNCj4g
PiAtICAgICAgICAgICAgIHRoLT5lY2UgPSAxOw0KPiA+ICsgICAgIGlmICghcmVxLT5udW1fcmV0
cmFucyB8fCAhcmVxLT5udW1fdGltZW91dCkgew0KPiANCj4gV2h5IGBpZiAoIXJlcS0+bnVtX3Rp
bWVvdXQpYCBpcyBub3QgYSBzdWZmaWNpZW50IGNvbmRpdGlvbiBoZXJlPw0KPiANCj4gU2ltcGxp
ZnlpbmcgdGhlIGFib3ZlIGNvbmRpdGlvbiB3aWxsIG1ha2UgdGhlIFRDUF9TWU5BQ0tfUkVUUkFO
UyBhbHRlcm5hdGl2ZSBzaW1wbGVyLCBJIHRoaW5rLg0KPiANCj4gL1ANCg0KSGkgUGFvbG8sDQoN
CkFGQUlLLCByZXEtPm51bV90aW1lb3V0IHdpbGwgYmUgaW5jcmVhc2VkIGFmdGVyIHRjcF9ydHhf
c3luYWNrKCkgaXMgZG9uZSBkdWUgdG8gdGltZW91dCwgYWJ1dCBpdCBkb2VzIG5vdCBjb3ZlciB0
aGUgY2FzZSB3aGVuIDJuZCBTWU4gaXMgcmVjZWl2ZWQuDQoNCkJ1dCBzbyBmYXIgdGhlIEFjY0VD
TiBzcGVjIHJlcXVlc3RzIHRvIGRvIHRoZSBzYW1lIGZhbGxiYWNrIGluIGJvdGggY2FzZXMgKGku
ZS4sIGVpdGhlciB0aW1lb3V0IG9yIHJlY2VpdmUgMm5kIFNZTikuDQoNClNvLCBoZXJlIEkgd291
bGQgc3RpbGwgdGhpbmsgdG8gdXNlIGVpdGhlciBudW1fcmV0cmFucyAob3IgbGlrZSB5b3Ugc3Vn
Z2VzdGVkIHRvIHVzZSBkaWZmZXJlbnQgU1lOX0FDSyB0eXBlcz8pDQoNCkNoaWEtWXUNCg==

