Return-Path: <linux-kselftest+bounces-37364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE5BB06298
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92A23AAE87
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 15:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2129E214811;
	Tue, 15 Jul 2025 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="BHoyKigj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012048.outbound.protection.outlook.com [52.101.71.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28D1E1C36;
	Tue, 15 Jul 2025 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592458; cv=fail; b=qHJuy7sS3w+r694lOCz+ZPaj6SnM4djbfWOa7OYGMuyguZNwd5ptNd/1R30o7gYm2o39wmMeJeak7U0T6joair2RfOmXz6kDqeJhjwFSbGtfPeVJ6BwEUCeaVKXuRX0mUqGEJj5v/RXxdJ7qsv2t29Q9hCRjBr0Ho7Ec4IjKv24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592458; c=relaxed/simple;
	bh=CAB6daWfq+hGpSDCmcjrvsRLiUmFDKZDEGdvbB5z/MU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X1mFw5enOINEdWrjgTp08gXuRSIM0c5lPkB3ACpmaQJAK2nNhallgaG4QQGBTfDThFuIXOZqGtpIFdVwgJSeJjEkQnjmhn+TqjLatMlUXz5FeZkeeLwsTUc+HbRRqcGvO/HuGbAcaUayM6QjvTyJQ6ZlPgLCSoV41eoasWCsgMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=BHoyKigj; arc=fail smtp.client-ip=52.101.71.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzSWn113iC0kOxlMWTNuH0F4mqcM+6zQxohyd9HbGJvv5FaC/GmNs7GwWH+mw1tnVy/9HadMWNEABYo6LE/EkOCIaF+SxaVbSM7aAIleXLkJL+8M2dbdE0t1/WIU7V1ZK3384krmrkXPw4coicsU32f8pZ1G4Whwb+jaqGyWMrrN6bhew13LHzSYUKxU7RHp67gMcNo6+bKf9PY+8fRiRD8hSc72ajk23AJjgUZ16UE4iSh+2L9qDx+P5/Rh+uETEap84r4DzDIai8UL5qGpz8CfLeoIrUEGISWCJkyxAPwSCVxgdSFvQAxfqGzLWmCUe5MEyrD7FusUsNb4Av76+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAB6daWfq+hGpSDCmcjrvsRLiUmFDKZDEGdvbB5z/MU=;
 b=xDCiSBtM9MmnKPBKPo7KczNi1aX2QUlrrdk/qYT6SLqBoPv31yrP7WyZLHbBkuL3/4+qESvzEM8rMArqnET1TLOpKk535taI4GmfGzE+17YE/J05++HaKjDT0eQgRSnd/8gerxeQkyFJnDQJeT8WeKNmffcNPM4KP3hZm1SItMveTue2RhIPJlPN98tBlOHq/5muEqrWmmOwClyv5VIP83SgfhFdtCNIVMCbR4BEeiE9BACM45w8e3w8D8DsXnV54YIP9l3fs9tZ7Npf6Y6ZP5FjiOZo/Lc37XQJBm8mMhEGyKbb+7hTvBYeUPX93XltLXOvJxW5EhA0b6hlmMVk8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAB6daWfq+hGpSDCmcjrvsRLiUmFDKZDEGdvbB5z/MU=;
 b=BHoyKigjjMzN2OHr6GDBdMr7lQP5FCH2uabgU7nYBHRrYN7PPXLIgjh3ObDMjD7soxh1+Cr+EIHNFyEOmZ1dFL4JAhsnmOUm0hCZoaf/NMn1F3cd/O0E0GD7Sxfwhts1/fLbOj2/o5JmnYGDIfpPj0gI8eWWFqv8LwRKb5IKe94iNmb3hEjsU0ZNO8JHUCc6TJJUrdRPc4dvt73Immn/opLx4jlxkhA7lQ1nii6CTIx9fwpLzhGbny2bjr744QUtuKPIEJt6QgtzmgqWko3Lm/FPDPYLKqSVGTxiBlRdqmN+JgoiayLMklKaJgl9nyPzsKbYsQno20JzRm65464HZA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PAWPR07MB9928.eurprd07.prod.outlook.com (2603:10a6:102:38f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 15:14:12 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 15:14:11 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "linux-doc@vger.kernel.org"
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
Subject: RE: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
Thread-Topic: [PATCH v12 net-next 12/15] tcp: accecn: AccECN option send
 control
Thread-Index: AQHb7MFma+VjHWM6Vk+TnZlrvuwkPLQxxQeAgAGXUHA=
Date: Tue, 15 Jul 2025 15:14:11 +0000
Message-ID:
 <PAXPR07MB7984D6FA40FF000E51F694F3A357A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250704085345.46530-1-chia-yu.chang@nokia-bell-labs.com>
 <20250704085345.46530-13-chia-yu.chang@nokia-bell-labs.com>
 <b2c0653e-077f-4609-922e-777f1d868dd0@redhat.com>
In-Reply-To: <b2c0653e-077f-4609-922e-777f1d868dd0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PAWPR07MB9928:EE_
x-ms-office365-filtering-correlation-id: e6a410ff-6d64-4f1b-2809-08ddc3b2410c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q21MTVpHU1FkUFpOck1QU1Q2NzdJcElWK0t0V3AxZDI3R2F4ZmdVOHV2MjRZ?=
 =?utf-8?B?c2lSNXJsSldxa1VHeFByeVRjZkp0V2oxUXg2T2JtNCtqVEVwYnBCdkZreVNO?=
 =?utf-8?B?eENUZVp3cFJYOU1RdWJULzhjdmxIdnFGb2RMVHU3OFhIMXlxQ2Z0cDdSMlpT?=
 =?utf-8?B?Y2E2SGpqOTlBTzdWbWhVa1I1eFpHbWE5NnpNOW4yWTJhSzVZNXdRRVR0SFg2?=
 =?utf-8?B?NXo2RW1hSHNZcU0yR3RCZStpS0x6eGlObGoySUMxSUdYay9MTUR6T2Q2bjhD?=
 =?utf-8?B?aDJ1TGN2Q1oyQk4veFdWdlhjMlNqcFhyU1JUV1Z5UndpQ1NPeEtkZlk0dnJU?=
 =?utf-8?B?RXlKNzFOMTc1VkFtcjJPNVVnYXFZVUt1U0QwQVk5eHNIWGl5TUIyWUlpT1ZH?=
 =?utf-8?B?KzU4VUx1dStaSVpBM2pKVjB0N282UzE5ZFhRY0JJRlhoRUdjVEhRbXkya01C?=
 =?utf-8?B?N1NoSkdQci9zTU9VQWc4OE9vbElVWW1ONFE2a0wreFNqaTN0MDl4ODNRSThR?=
 =?utf-8?B?VjBaeG9zaldDOGMzNks0My9DdDZEY2hoNjdhZzM5bVg0Mmg0UzhHaHpjN04v?=
 =?utf-8?B?OU1WbFM0WGtiZEVPb3RtVjRpY0FpTFZIdlFJTHlEM1JjeDBiVlFLaktEQjND?=
 =?utf-8?B?YzUyN3RhTmFPS2hrb2swN0x2aGY2cnhJT2ZFQ2c0TTNHZmdZYU5RZmdOeEV1?=
 =?utf-8?B?eHQyeVlOM3VsamFsK0QyaU4rSVVJTm5RNVdNdWFOSEF4OWpnTEVIaFkxNThs?=
 =?utf-8?B?azh2L2p5MG1JL1BPclRJMDZPQmkrY0FZanBnTm5VRUpKR3gwRldzdnBlUEhn?=
 =?utf-8?B?b3hQMTVOV2NVWEFNSVZSenVyRmducXNHalZGaXBWNGNjc2c1b0VHYnJtZmRs?=
 =?utf-8?B?MDEzRytnR0NlL1VUTUkrZXdBbHkycWZQOUY2YStvZVRzMUdaQWtZM3RVQ1Jk?=
 =?utf-8?B?ako4V0tMS1hZSlM0bzRKTDZFMWRkZ1BRM1F4ZnN2MzZlK0t1bjlwZHNHdXJV?=
 =?utf-8?B?SUhHcGpjcWtJcjlJclZTbmpxQ3h5RFhXNEY0aElMVnRIOFo5VmYrakNiY0FC?=
 =?utf-8?B?ZjJHZjNBcngrVG5Mcnh3VFlwZ3pmWEV5TDhxZGIwemEwZUZyeVBvUGdTK3BO?=
 =?utf-8?B?aW1ORUZrYkUyUmVTdVUwZXF0V290TGFlYVVkakxPU3dDOFBqZGszeGJ5VHNY?=
 =?utf-8?B?MW1qcUJNOXdNUzJqZGg3UVpiR1l6UVBEWWo0Y2V3aUovNzg2c3dDRmNRVldU?=
 =?utf-8?B?YlJOQ1RhVGQ0dm9kV1NaNVhuSjBCRDh1NVprZ25zRzlCRkN1REkwcDAycElo?=
 =?utf-8?B?TmZxd0VwZ2N6U3ZMQzBrSHIwVEtLb2RESkFCSnphZkxNMXJzOUI2cDdtKzBO?=
 =?utf-8?B?YjFZSGh3NUw0QVhxajZTQ2QxQm1SMFdFZXJvTEVMTU9vd3NWcXJXeHU0elU5?=
 =?utf-8?B?RnphSUFIY2MwK3pMUUhobmhJNkJpcjBSOVB4bUVEby9FZm9xYi9meGpURVNy?=
 =?utf-8?B?bW0xOUFJMm1wVS94RCtNSnplWmplN3hpSzFUK3prOVlKUS8vMTkvMG5TQzBU?=
 =?utf-8?B?MFY3YnQ2Q3pNK01TT0xXT250ZTZ3ek0wVnhwNUwwOGdOV1hLWU9OaGM5SWNi?=
 =?utf-8?B?RTRqcTkxU3dzU25yZHFrZTRwaVRHeWFDZDFja09KWGRsOWsyYU1KYVNJcloz?=
 =?utf-8?B?Y1JQNGxUdkRRVEQ2V3JEVWxid0F2WlRsYy82dDIxdTBKeDNTYVN6Vnl5MHND?=
 =?utf-8?B?RGxhV3laWUh3ZExYL2VrNGVFQzVWSFhOMGlRUUtuRVBRNDhVb0xjWURNb05X?=
 =?utf-8?B?QjlobGVFUHVzZjJzS09tbHFEMzM0OEl0b3BDMEh6b0VMNDZkbEExMXRKSTNV?=
 =?utf-8?B?MzFobzdOWitreDhHTWdJN0gzc1NZMmY2a2J1dDhaYytJSHFCck5sc0Z6algx?=
 =?utf-8?B?KzBTTnZXWWpScXQwbVFaWHFSRWZQYzh1cWh0RitDRHhoZlY1VXBtMXhFdzlx?=
 =?utf-8?B?b0l1ZDROOTVZWFFjaG5MQ1Q0N2ZrM3RMOXJReVVyOURLRkh0NnRWYzgyQ1py?=
 =?utf-8?Q?5NGgG1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZytQTmxnR1Zna0l4ajBHd0FDZk5Dc3F2RXd6MCtMeEFBU0FaVnIwYVgwUXZ6?=
 =?utf-8?B?THMzRXRMb2xaWUQ4SkpPaXRlRCtFK2pxTi83OXBXYW5zMDlqRjQ4UFZlSCt3?=
 =?utf-8?B?WFhEaVd2V0RTNzFBQmhaRWltcmE3SFFTaGNmbEl3WUhGeU5FYW9XVUhsWDFF?=
 =?utf-8?B?a2ZrN2VzYnBUV1VNTzBCUmpreThDSTQ3UzgwNVNhYzRDekprYXhORno2R0wr?=
 =?utf-8?B?d3BsUEFLSVFOaFJDVXNSdUIwQ2NOMk1uOWd4US9IMW5nbW1MZytXNnMwSjdQ?=
 =?utf-8?B?WUZNcS9YbUIvV1krck5hVTFjeFlvdEdZRTdQRXlwMEtBWS9HZU5xVGd1QTBv?=
 =?utf-8?B?MmNSTEh2b2xBMk0wdzUrQVhtQnF5V2UzWkJ2blRoaHB0Z2xWOVBHa2s4RlRC?=
 =?utf-8?B?OHp5YlBiUGZXSFRlN3VWUlVFOXNqa0w4ZmJRdjN0Nnl5Mko2cUxrSCsyUmN6?=
 =?utf-8?B?RzkxQ01pM0s3b1IxcStwdTZLRHZqRjMwdVpRV3hackluOWNLVCszQ0dYT0hN?=
 =?utf-8?B?WDNSSWtNREU4bjhEckZhMXFQK2JwZ1FJczV0UklEK2NMV0JYS2plZWRDcy9N?=
 =?utf-8?B?ays2aXpHeTFHeGdxbSsrZUh6M2JBakJaa1czY0ViRDdNeVNFQnBlVUJLSGVP?=
 =?utf-8?B?VHhSMzRKRkE5VVJVTDRpSHlOU3pSS0h5VktpMlNkeVZXTkZRT1B0MUF1VUpC?=
 =?utf-8?B?Z09GSUtUK3VJb3BlQlYzUHc3RGFqcUNvdklVMmZqWjFnN201WHJTOTluZWQz?=
 =?utf-8?B?M2QwWWorMkROUWxTcVBacWx4WVM0a3hOa08rWjZ4a3V4c0Q4OWdzMGJYdCsx?=
 =?utf-8?B?dTR2WE9sajJ5VVBycDA0LzhMOUJiV3d0bWdLMlZzV3U3SWI2VDNjd0NxcVV3?=
 =?utf-8?B?WWQ4eGFBKzNVTTQybm9ISE84QTgycXhZM0s1RFlBR3RjRkQyd3crd0N1emo0?=
 =?utf-8?B?WmxJbXhSdlI3T044cXhyMXBDcTI3Wk9vMDltU01hS0p4K1E4c055T0dPU2FJ?=
 =?utf-8?B?S2R4OGorR0ZnZWdhSXRZUjNYMHVLVk9nNHRUWFREQ1lvQWw0TU9vQnlFemR3?=
 =?utf-8?B?T2pCUVBMSzJ5emhmeklpVlg0QU12djVZV0Q5b0FwcXBlUWNjUHFwRDVoZzRB?=
 =?utf-8?B?N2dSdEFXdTliTFJiTk1hYXlGdFY5aGNyT3B5U2FNMUVUS2xVL2RpUHJVTGQ1?=
 =?utf-8?B?cldZUXhiUVpxRjhRcUxPWkNHbmduTk02ZDNYenRuaDFtbXhTNDVPc2c1dG5Q?=
 =?utf-8?B?RDV1VkVlaXBkYlZMY0lOZGk0bzEvS0cveS9TUk92dCtxOENIVFNEQk9zeHdE?=
 =?utf-8?B?ZmE1bnBUREtHWEZyaFg0ejFvNGdIR09mZ2Jla3Q0M3lZbkU4M2VDUGdXTHQ5?=
 =?utf-8?B?U2NoZUMwWkpjREpDSkszQjdzVUl0ZThaWVpkUi9keVJnOXZRNDRoQkM0V2xv?=
 =?utf-8?B?NzVUWGJ5elRRdUNqQXZyeWhGbHBONmROdmd4K1p4b0krYWZvM3Zsdm5JUjRB?=
 =?utf-8?B?cGJFWTAwT2UveXN1NkFxeDRHZVdvMkN6S2Z5ZVlaclNxNDVaRitKcm5Hc2lw?=
 =?utf-8?B?Mm1RY3dFNnJDZ0phS0Q0Zml2RTQ5VXNwb2d2bWthNlFKcWlkT09YV05yZGtK?=
 =?utf-8?B?cEY5MjZhd3Bxa2QwQ2tEZU1PSVdibE9VWFBKWGRxMFhQbUpMZzRES2xzNXNk?=
 =?utf-8?B?RkVERlpLUzdFK0tRSThqckc1bDBHZ2s0TGRFWVZpZDBtUzc1Wm9laEIwb2ZO?=
 =?utf-8?B?ZkFPYlUweTRGYVZjcE52U3R2RWtjR2x6NFB4aEthSDkyZmRwRUZ5WFkrSWVx?=
 =?utf-8?B?VUNGQk9ZZjA4RWZGdXlOcUZPZTBkTzg3QVIvR3owRDNkVHBXRVVpbU1ndTlD?=
 =?utf-8?B?QmI0SkE0YzcwVmM3OHZXcUYwNDlxUER4Zis1UkxaMzluR0lUZzBUc1FwLzRt?=
 =?utf-8?B?ZkFXQVpVSGRsWG0vMHErUHVMMHhxaUxDQlk4SXE5QkxRcFlQSG5Iak11aWcy?=
 =?utf-8?B?WU05VnFTMGFNZlhjNnJQMlBibGZGbk9IQXlpWFlDSHh6NUF3L2V1VjZNNmtS?=
 =?utf-8?B?OG5ESmc3dFhYaFlPcEYvWHJHQWpyQUtGaTIzSnlVMm83SkJZeW9mNmJHRVp2?=
 =?utf-8?B?WXEvaHRxQjFRU09IbXZtNU53S2RkUS9QTFdUNGU1d085eFdYVHVyZ3pKN1ls?=
 =?utf-8?Q?4dhMTRhSzxxrztzmqMlOhP8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e6a410ff-6d64-4f1b-2809-08ddc3b2410c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 15:14:11.9166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3q/H7Pas7vs3uvU4qyKY3LHAT4fm8hlYWLKVqgqRuMQ/DZDjzgxy7UfWFfFG0eXouT7ZlcUuMGfUWFJPg0AxwtKIJ6FnDNdwR2IX1X25eFjHqZaVwHEfFgG1xywVrnHy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9928

PiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJl
ZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBV
Ukwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4g
T24gNy80LzI1IDEwOjUzIEFNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20gd3Jv
dGU6DQo+ID4gQEAgLTI4NSw5ICsyOTcsMzMgQEAgc3RhdGljIGlubGluZSB2b2lkIA0KPiA+IHRj
cF9lY25fcmVjZWl2ZWRfY291bnRlcnMoc3RydWN0IHNvY2sgKnNrLA0KPiA+DQo+ID4gICAgICAg
ICAgICAgICBpZiAobGVuID4gMCkgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICB1OCBtaW5s
ZW4gPSANCj4gPiB0Y3BfZWNuZmllbGRfdG9fYWNjZWNuX29wdGZpZWxkKGVjbmZpZWxkKTsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgdTMyIG9sZGJ5dGVzID0gdHAtPnJlY2VpdmVkX2Vjbl9i
eXRlc1tlY25maWVsZCAtIA0KPiA+ICsgMV07DQo+ID4gKw0KPiA+ICAgICAgICAgICAgICAgICAg
ICAgICB0cC0+cmVjZWl2ZWRfZWNuX2J5dGVzW2VjbmZpZWxkIC0gMV0gKz0gbGVuOw0KPiA+ICAg
ICAgICAgICAgICAgICAgICAgICB0cC0+YWNjZWNuX21pbmxlbiA9IG1heF90KHU4LCB0cC0+YWNj
ZWNuX21pbmxlbiwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBtaW5sZW4pOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgLyogRGVt
YW5kIEFjY0VDTiBvcHRpb24gYXQgbGVhc3QgZXZlcnkgMl4yMiBieXRlcyB0bw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgKiBhdm9pZCBvdmVyZmxvd2luZyB0aGUgRUNOIGJ5dGUgY291bnRl
cnMuDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAqLw0KPiA+ICsgICAgICAgICAgICAgICAg
ICAgICBpZiAoKHRwLT5yZWNlaXZlZF9lY25fYnl0ZXNbZWNuZmllbGQgLSAxXSBeIG9sZGJ5dGVz
KSAmDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICB+KCgxIDw8IDIyKSAtIDEpKSB7DQo+
IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIGFib3ZlIHN0YXRlbWVudCwgSSBkb24ndCB0aGlu
ayBpdCB5aWVsZCB0aGUgcmVzdWx0IGV4cGVjdGVkIGFjY29yZGluZyB0byB0aGUgYWJvdmUgY29t
bWVudC4NCg0KSGkgUGFvbG8sDQoNCkkgd2FzIHRoaW5raW5nIHRvIGNoYW5nZSBpdCBpbnRvIEdF
Tk1BU0tfVTMyKCkgYW5kIGNvbW1lbnRzIGxpa2UgYmVsb3cuDQoNCkl0IGlzIGludGVuZGVkIHRv
IHNlbmQgQWNjRUNOIG9wdGlvbiBhdCBsZWFzdCBvbmNlIHBlciAyXjIyLWJ5dGUgaW5jcmVhc2Ug
aW4gdGhlIGNvdW50ZXIuDQoNCkJ1dCB0aGlzIGlzIGRvbmUgYnkgY2hlY2tpbmcgdGhlIGJpdCBl
ZGdlcyAoZnJvbSBiaXQgMjIpIG9mIHRoZSBieXRlIGNvdW50ZXJzIHRvIGF2b2lkIGV4dHJhIHZh
cmlhYmxlcy4NCg0KdTMyIG9sZGJ5dGVzID0gdHAtPnJlY2VpdmVkX2Vjbl9ieXRlc1tlY25maWVs
ZCAtIDFdOw0KdTMyIGJ5dGVzX21hc2sgPSBHRU5NQVNLX1UzMigzMSwgMjIpOw0KDQp0cC0+cmVj
ZWl2ZWRfZWNuX2J5dGVzW2VjbmZpZWxkIC0gMV0gKz0gbGVuOw0KdHAtPmFjY2Vjbl9taW5sZW4g
PSBtYXhfdCh1OCwgdHAtPmFjY2Vjbl9taW5sZW4sDQogICAgICAgICAgICAgICAgICAgICAgICAg
IG1pbmxlbik7DQoNCi8qIFNlbmQgQWNjRUNOIG9wdGlvbiBpZiBhbnkgRUNOIGJ5dGUgY291bnRl
ciBpcw0KICogaW5jcmVhc2VkIGJ5IGF0IGxlYXN0IDJeMjIgYnl0ZXMuDQogKi8NCmlmICgodHAt
PnJlY2VpdmVkX2Vjbl9ieXRlc1tlY25maWVsZCAtIDFdIF4gb2xkYnl0ZXMpICYNCiAgICBieXRl
c19tYXNrKSB7DQogICAgICAgIHRjcF9hY2NlY25fb3B0X2RlbWFuZF9taW4oc2ssIDEpOw0KfQ0K
DQpXb3VsZCBpdCBtYWtlIG1vcmUgc2Vuc2UgdG8geW91Pw0K

