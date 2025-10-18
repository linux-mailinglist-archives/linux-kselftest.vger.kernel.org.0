Return-Path: <linux-kselftest+bounces-43489-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4A4BED36B
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 18:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1878C586AEB
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Oct 2025 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D508D22E3F0;
	Sat, 18 Oct 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="JNBpkUef"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4319ACA52;
	Sat, 18 Oct 2025 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803624; cv=fail; b=NL7VVahVqQ+Kz+V/qGUKgAwfJ0ybDNsDYZe0aLm3ffQHxVkSff5TnuoLvTQEG3+Xd8ZM5mcA0X2g+bD5r8Rd+Zex3tt9cxgGrY0XZiLZZrqsIPISDsOovrasW9dxgoU0xWIrEBREm7j7//+6I8H7G+dhTU9eHcf7Xojb7/R3gLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803624; c=relaxed/simple;
	bh=fCa9CxqHhlkqCC/1FW1LJr3lbCz6DVbCzzkaylNBRPI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M+Xu1AWf7b20CEi7FqM4OLCrE9IsXsoRjJLbhsuuHzlm/yE9EraT+A0VR43llmU0VK081Td19ew7/SnatIGYZ4KFYIHzYW517+5H0qv2svyWx4rhcJ40PiIz/MR97ihjdz4EnIgGTZljaUtbacAQy3ZpljV07iSeQ3zjyuVUhr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=JNBpkUef; arc=fail smtp.client-ip=40.107.159.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8yExcGl9vYmmwJr+Amsyrjv3Anf4EsffgXQAOFUKXTgXyIX4EN+9dB+/guVBBsDGtgMMAu1IB39//eGHUvAJ3bcAf+GiqIYv/u0BgB2pzBXTdP++mzcsc6mGmTy7pxVzXzlo45sanuJgd/QPnvntcBXo6Qbqyp87ASK6xFIGLdVZ2aP/2XQNZ6uQjfKUymwtC2Yz7bvuzEN6OTWBoqeGpOP8aeEZYmWd5xEPbYHecZtBc5+LQ2m8MfIJFE+A/KogmaTLEjYDvuUrL6oiGrbqIMPc29DJka80znLRXflkBPUrDd2R37mdj+Gv+aKEE8sKr2LwkqvOSjyK9y3bEQyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCa9CxqHhlkqCC/1FW1LJr3lbCz6DVbCzzkaylNBRPI=;
 b=WbLYPrXlDxDu9V4pZSL9wI4xL+R4G7PiFmD6shiTDlcnqlqos7uStvGL7hlCwa+AVVjhZLg4wrWZYy9DZ33L+lS78Ghz5UrCsMLPIByu7sJDU8W9Am/xP20Hu1/SDk6+9micJc6jOmfdbJ1pqDfaFRUtHyCe3zOTBmWmcDzGQlagzB+wZJWJfpPbgT2pZf90UNUcm1MBAygwmwsJtSdu7YzpdKNMm2wdEkoQHdoNTDrqatpRv6WW24PBBqkAZfmZksn42RnU5jgJjjy8nUMDcGannf7dW61qOGktF8NEiHxaRW61PbmSEqi+0OLiuAAdMSjacNe1TxgQ8Krm1b82Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fCa9CxqHhlkqCC/1FW1LJr3lbCz6DVbCzzkaylNBRPI=;
 b=JNBpkUefwS9IPwRyHnXJZf+Xgmk4RBABZxfSBLGoy9/lWfb6LYtLDwd2Hy8M+4RcbMajhmk5QnAjAyAABU9OtbFL/GrYUAMmcc9Y877s+meiLNxF/tHktT0F6M340hDsgP882xdLTd0vgDGLIOCFKIWCHj7QWwJx875uW/iecMi3x5LYrbx4hOihPTAM7wVtB4M77D0B9W8y0t/RoMSZ0Lr6sqPGQlGzuBfIMykA5R4RxNuAGvSmtHgSh4qX2HaTibg3XXj3WlZZy/z/ZtQag/vdJg7hlvzGpCKsrKUZx37P2geKRO5nvDb7vmHnk0aqFytfsem9Rvhkr0nU9DnhDg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB9422.eurprd07.prod.outlook.com (2603:10a6:800:1c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 16:06:58 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 16:06:58 +0000
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
	<mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v4 net-next 08/13] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
Thread-Topic: [PATCH v4 net-next 08/13] tcp: accecn: retransmit SYN/ACK
 without AccECN option or non-AccECN SYN/ACK
Thread-Index: AQHcPGNeRToEcMsOS02zUrddw3q5grTEgaEAgAOUmgA=
Date: Sat, 18 Oct 2025 16:06:58 +0000
Message-ID:
 <PAXPR07MB7984E7A69169F81508384928A3F7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com>
 <20251013170331.63539-9-chia-yu.chang@nokia-bell-labs.com>
 <705f02b2-44c6-4012-a1f3-0040652acc36@redhat.com>
In-Reply-To: <705f02b2-44c6-4012-a1f3-0040652acc36@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB9422:EE_
x-ms-office365-filtering-correlation-id: 8eddda4a-0b8d-4d10-11c0-08de0e605da3
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzZCVTVsSHBvbXliNllYZXBBWS9jTFNabnExQlZrMnBRRXorc1NpRzZrQkY2?=
 =?utf-8?B?d0JPSzI1UGoyaUhsM1U2V2FtT3J5cG5HcldZbnFnTmVBVitBNjhTcmUxR2RF?=
 =?utf-8?B?K0s1elpXUUJQdVk2b3NZMzNJcmw3OEJIN1BaaWx3UWM3YmJhK1pia0U2NVJC?=
 =?utf-8?B?Q1ZxMXlOcW9tMWMyUnhoejRvU282VGVkQndZQUt2VDVNMXYxNENPVzlxSzlE?=
 =?utf-8?B?YkVUbU1HNEQzVmNhOGxlL0RpRzJwR3V0YmRrV1ZBRlRlVDBVM2dscENhMmho?=
 =?utf-8?B?cU5VVHFNNXc1NGZKNkE1LzRETy8xdSt6QzBJWmQxQVRZYXQ1dUJkb2tqR3pq?=
 =?utf-8?B?WmdiVzhmVjlFOU94U1dCSHBYZkFQQ3lOUll5M3NqRm1sa0s4Tlhqd1dQMkJU?=
 =?utf-8?B?YXo1eFduK0xCcjUxOGtjZ0drODFycWp3OUhRbmxDQ3krQjVSbjRaVWI1TDNo?=
 =?utf-8?B?Rnp0RWNHZlhSZUJYRzJuSmNyTGMxeE40UzdkbzFqR3Nia2xDcThJSGVmTXlP?=
 =?utf-8?B?SHBiMjJBQ1ZFRXRMN1d5MzFUb0Q4M0IyOFhMWkxWa3VDT0g3YWlwL0NuNEt3?=
 =?utf-8?B?SHBXQzNQVnQ1cCtTWFYzMXFkc2NlQVlLeG1ZZDFEL01FRjA3VmZJYXdNVmVp?=
 =?utf-8?B?V0NrV3g2eWxkWjNhdVRjS2RlOXdxOXQ4eXBqTDdJWHVaK0J2N0ExcUlNVit0?=
 =?utf-8?B?TlkrV1NPRkZBQktEcWlMeVFoYzNjZUtCbStjUTBWVUZ5MDhLekRDQU15NmMr?=
 =?utf-8?B?OWtmVm51azBnMEtxVUp3V2RscUU2R1VpbFpkVER6ZER5TXFGTTlxQnk0OWFy?=
 =?utf-8?B?YjdMdjg1SXg5MlNwcDdyeXJKK2VraFpMaVExVzZTRzlmNzk2RFU4WnVoLytN?=
 =?utf-8?B?THNNcHpXcUJlRDZhNHIxYkJoQmVlMTdoNi80cDU5b2J5RDg4NWRnNGY4eXgr?=
 =?utf-8?B?eE1VVHdzaTFicXpRTUtZWU5Hcm56blByOW1LYVQ0WnJ6OXh4aXV0NG9RSnZ0?=
 =?utf-8?B?d3h0SlRCVDlqYS9Xc3phZjEzcU5uUVczTGJST1JZc0FYR2IwN25rb2dkeVd6?=
 =?utf-8?B?VTBuUGJhRlFXVzAzOUV3VURhNFBiRzcwODBWR0NzazN5WUR2M1JwNkZzaVBZ?=
 =?utf-8?B?RmFQSmM4MWtWZ0x3ZHNjcU9ZdnR3TUV2SkRZa3VDSzlCZGUwaHBNY1dOKzhY?=
 =?utf-8?B?Tkw4THVJbFVrS0RzNWhhWjI5R1dFdnQ5bGE5dFg1RFNjTkhlbGM1MURHanhU?=
 =?utf-8?B?bGJCeWhoQ3pHWVlOblhCS2NHTXdJQkMyRTZsUmdZZzF1N1c4N1JpbnZld2d4?=
 =?utf-8?B?TkhzS1h3Tk4vZFFFZU85eGlpb3NBUG9IVCt4MlgxVDU0dXpKeFBIazdWczl4?=
 =?utf-8?B?bHVjSk9TM1d6RGxGWERhZTdTemFITXR4dFBnTmR6TSswMlYxMjhma0dVaFVJ?=
 =?utf-8?B?NUlkRDh6NmRuZFJzMEFFVDdQdkFNZWtaOW4ydkYyeDJESFR2OUh5dDRXY2RI?=
 =?utf-8?B?aVNVdUZ5V0tja1pUZmwwN2NId0M4SjN6bGFGWVEybWRzZ05NdHl2VkhFN0k5?=
 =?utf-8?B?RU96Q0x6QVEwcmFZcmVNY0g1U3VoNnVFVUtwMjF3OWtBdXYvRE5sMmRFWFp0?=
 =?utf-8?B?c0dNWWljb3BBYytXVjlET2Q5c1c4ZUUyN3dLbWd3ZGFmZDFlekpqVzMzQlo3?=
 =?utf-8?B?RHozZ25HV01sb3JxQ3g4eVVLSnR3QkwzNmljSTJJSWRTQXZSS2lJOUpSRHZi?=
 =?utf-8?B?U3QrbElLbWRZQy94eVpEUStkcUFJR3JXdFlheERhUUIxT1FTcmtlKys0TENH?=
 =?utf-8?B?MVd0QTN4U2tyS0w5cFpOSjZrSjVKWGltWUFRVUpia1hFMEdDM3JSS0RVaXFQ?=
 =?utf-8?B?UmN2dzYrNjRnWG9MUWZLcGtXZXlxS3BCaFBOMVFTa3d4Ry8rd1hqMytkK29I?=
 =?utf-8?B?SzU1alJRSEhNL2oyQmpva3pCRG9tUWx2Z2ZZWVF6WElKSjcrL1ZNSEd2LzdT?=
 =?utf-8?B?SnkxTHhXdGxlUjQzUXpwejVrbFMySVBVQzY1SGdBZGZ2UkpxMnBiNy95VU9m?=
 =?utf-8?B?OGFYYkcraG9BRWFDZWlPY3dYa0UvVk1zM1lWdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnYveUQ2MTZ4RG9YYjhLM2tpRXd2bmxkWkdGeUVTT29TMUI2elBFQXIxVkw3?=
 =?utf-8?B?Uno1V1pESCtzZVlvY09aU05DOURDa1p2ZEYrNzhBVnFoSEVUa0VOeC9Pem1F?=
 =?utf-8?B?SmxGcXVmdzBKOHNhZytuQmNhREtjWERHdmVwUmxTWDhvbVJITmI5Z1BzN2Fu?=
 =?utf-8?B?S3BjeXBBMjk4cmVFUGx5Ny9FeWNQdGlmM21mVEd4WVBZZThsWnI0TEc2SWtT?=
 =?utf-8?B?bGJCaVJmV2drOGNybnpHa3MvemVIdVR6NCtvalM1bEdEazVqanliVjBpbC9B?=
 =?utf-8?B?cmc2NHdTdXRDSHp6YkpKWVlxOTNGSXQwNVpTbEtzYlVJZ0RIeTZBcFF0Y3Rl?=
 =?utf-8?B?RmxNcXhhT2JVeDhja2hnazM1Tkx1bnBOOGljV01GSk1YYm9BeURvaWtLSFpO?=
 =?utf-8?B?VGh2a0JQYVdUV1U4NVJEL3A5aStGK3Zkei9pdjF4ZTJQZTJzQ3JETFJZNjQr?=
 =?utf-8?B?b0FCczRzWEdTNThXOUd4Z0FuK3ptL1h3bkR1RWZjSU9MZ3MwMHNPRDMrTjJB?=
 =?utf-8?B?VTVGK1FjdnFqclZLWE5NU1gweFljVGpmV2RpemViMXVtZFRad2xUd1htUGdr?=
 =?utf-8?B?STQ5bUNHZUxDcEQ0dVB3azBRU3Z2d1B6TU9CYS9xUlRZSTF3MmVBcWVRK2RS?=
 =?utf-8?B?TDU2UktiYjM4cTd0NFRCTncwWGdTU0VRSUMyYVByUGs0TkZTVTBieWpnNEhG?=
 =?utf-8?B?R3plODVrOVBYTllPUHRyYmt5QmljV1Y1aW1uLzdteHplaXIrdDVSQTVQUXdl?=
 =?utf-8?B?TDZmL3kxUDJMakRoMUdlU3VGMC9CVGl6L3Nxc3lzN1RaMkFmMk5xUnRha0U5?=
 =?utf-8?B?ejNPNHpIK1dhVkR4VitGTjBTaTBaWWcrdWFNbEhXMVZhdFhYdDJVMy82VkYz?=
 =?utf-8?B?NEZoR2NaOWVJREdiRktLREhSbWgrbVQwZEliaXJZSWZEMjIyaUZ4VlRmWmNq?=
 =?utf-8?B?MkRZOEhIS0NMQ3FNQWhKdW10RmIreUJZeXh0Q3FaL20zckFkeUZaSnBqcVE3?=
 =?utf-8?B?L1RxK2lYRmo4Z0JxQUJCdjRJMlVKRGJrYWgrYVpQSUN5SWZzOU8xbkExK0J1?=
 =?utf-8?B?b0ZXTHNCSGpCZG44K2RORVZYd2s0QmlPWG5VL0FiWVpPbkprSFI1SGdZUXZp?=
 =?utf-8?B?L01jaXZ5RmdGcVVzMzNQSThQU2NuczJCei9LQWhjVEVyQWVRaEdqQ0N2eXc0?=
 =?utf-8?B?azNTRkFMWG5BNU51bFkrNzg5SW9ZNzlKYzFpRGJoSUpUY1lMaFkrOGVwSHRm?=
 =?utf-8?B?NHA1VHlZTVoxb2N1REpWTXpEaE8yZE9adjRMcnVmWUhBcy91K25MWWFOZ0RP?=
 =?utf-8?B?TWd5eE1aeGZiTVJkWVhyVGNyZ1czRnVLWTdJZmtSSk5KTEdDUE9HTGxPcjUw?=
 =?utf-8?B?K3JDUUgvQ3JyOXlqeWhJemFxaXlnV3hrZGZPbW5WYjRmeXJXdUx2cGdGcDdI?=
 =?utf-8?B?TzYxVDIxYmpVcnBiUUFrK1N3YUJFNGgwYzVFbW5yN3dDaWJzR3dqWmplSFg2?=
 =?utf-8?B?dXc5Um5vbTIxVE1hUDk3eithNjBOYnowc3YvNjhBSWFVaUhtSU1sdGoxMWtM?=
 =?utf-8?B?WSs3VzUxakduQlY3bnU2MERyam1TQk84czRWRVAxbTVXcXloMFlLNTM4WDlw?=
 =?utf-8?B?bGpvWmltZUwzRmRxdGJDcmVjY0JraXIyWlZEaGZFREpRL29EdEFTd0JDTThh?=
 =?utf-8?B?VW9ZN1ZUWmJCMEs5RWx5TVlpek5IYjRWTVV6QWQ1Q3hzalQzRFcyVFl6Rmht?=
 =?utf-8?B?T3Myb3hWU1VOaFRoRzhZYmR1aSt5UTYyNk5ZRFFVOGxDWjR5Q2kxM0NvclBr?=
 =?utf-8?B?RkxZZWpVVE95OGMwQXFZaTZKRUtPRlNLTmdoZVM2OGtmaGcwbit1V1FxWDMr?=
 =?utf-8?B?WTZ1TStxbGlUYzlGcmRpQXZVTlR0OGRSRGQwWmdZVGZhdmExcnBZbFlWNkhT?=
 =?utf-8?B?dkFGbDg4WWIzbHk1UitIR2M2b2haWVMwU3dTZjY2SFhnTEcwZHhpeldqVlpI?=
 =?utf-8?B?TWdrSnVSQ1lWWDNzcmZDUGw5cjQrT1N5a2Vqa2d2MFhlYkI4c3B6aFFwVWFT?=
 =?utf-8?B?aXRiRVcrNmtsSDRoYzh4Y05vMUtJYi9WbC9qRXdKS3p3bGx4ZFhaQWNmQyts?=
 =?utf-8?B?dEhobjl2VThwUk9GSEEzUHJsMWhXSTdBRlAzWXQ5YVdqbTg1WUZEelVRR1ls?=
 =?utf-8?B?aUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eddda4a-0b8d-4d10-11c0-08de0e605da3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 16:06:58.3543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5N3lEdEM0f4f9iWhL1nqXmTQn+0OH6SZziSlQLe5O9D3cjTjOKpwT8EzuQpR58l/29m59Q5th95goUj2RiRjLim9UFIIiQOs0/GL9aZTgRyATyezicPUqgvrIRGxfZkC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB9422

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxNiwgMjAyNSAxMToxNCBB
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+OyBlZHVtYXpldEBnb29nbGUuY29tOyBsaW51eC1kb2NAdmdlci5rZXJuZWwub3Jn
OyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVybkBrZXJuZWwub3JnOyBr
dW5peXVAYW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0ZGV2QHZnZXIua2VybmVs
Lm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwu
b3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2FuZ2NvbmdAZ21haWwuY29t
OyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdi
aW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJu
ZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hl
cHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndo
aXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBtaXJq
YS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmUgPGNoZXNoaXJlQGFwcGxlLmNvbT47
IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZpbmdvb2RAY29tY2FzdC5jb207IFZpZGhpIEdvZWwg
PHZpZGhpX2dvZWxAYXBwbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IG5ldC1uZXh0
IDA4LzEzXSB0Y3A6IGFjY2VjbjogcmV0cmFuc21pdCBTWU4vQUNLIHdpdGhvdXQgQWNjRUNOIG9w
dGlvbiBvciBub24tQWNjRUNOIFNZTi9BQ0sNCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFu
IGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlu
a3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRk
aXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4gT24gMTAvMTMvMjUgNzowMyBQTSwg
Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tIHdyb3RlOg0KPiA+IEZyb206IENoaWEt
WXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPg0KPiA+IElm
IHRoZSBUQ1AgU2VydmVyIGhhcyBub3QgcmVjZWl2ZWQgYW4gQUNLIHRvIGFja25vd2xlZGdlIGl0
cyBTWU4vQUNLIA0KPiA+IGFmdGVyIHRoZSBub3JtYWwgVENQIHRpbWVvdXQgb3IgaXQgcmVjZWl2
ZXMgYSBzZWNvbmQgU1lOIHdpdGggYSANCj4gPiByZXF1ZXN0IGZvciBBY2NFQ04gc3VwcG9ydCwg
dGhlbiBlaXRoZXIgdGhlIFNZTi9BQ0sgbWlnaHQganVzdCBoYXZlIA0KPiA+IGJlZW4gbG9zdCwg
ZS5nLiBkdWUgdG8gY29uZ2VzdGlvbiwgb3IgYSBtaWRkbGVib3ggbWlnaHQgYmUgYmxvY2tpbmcg
DQo+ID4gQWNjRUNOIE9wdGlvbnMuIFRvIGV4cGVkaXRlIGNvbm5lY3Rpb24gc2V0dXAgaW4gZGVw
bG95bWVudCBzY2VuYXJpb3MgDQo+ID4gd2hlcmUgQWNjRUNOIHBhdGggdHJhdmVyc2FsIG1pZ2h0
IGJlIHByb2JsZW1hdGljLCB0aGUgVENQIFNlcnZlciANCj4gPiBTSE9VTEQgcmV0cmFuc21pdCB0
aGUgU1lOL0FDSywgYnV0IHdpdGggbm8gQWNjRUNOIE9wdGlvbi4NCj4gPg0KPiA+IElmIHRoaXMg
cmV0cmFuc21pc3Npb24gdGltZXMgb3V0LCB0byBleHBlZGl0ZSBjb25uZWN0aW9uIHNldHVwLCB0
aGUgDQo+ID4gVENQIFNlcnZlciBTSE9VTEQgcmV0cmFuc21pdCB0aGUgU1lOL0FDSyB3aXRoIChB
RSxDV1IsRUNFKSA9ICgwLDAsMCkgDQo+ID4gYW5kIG5vIEFjY0VDTiBPcHRpb24sIGJ1dCBpdCBy
ZW1haW5zIGluIEFjY0VDTiBmZWVkYmFjayBtb2RlLg0KPiA+DQo+ID4gVGhpcyBmb2xsb3dzIFNl
Y3Rpb24gMy4yLjMuMi4yIG9mIEFjY0VDTiBzcGVjIChSRkM5NzY4KS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIHwgMTQgKysrKysrKysrKy0t
LS0gIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8ICAyIA0KPiA+ICstDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1n
aXQgYS9pbmNsdWRlL25ldC90Y3BfZWNuLmggYi9pbmNsdWRlL25ldC90Y3BfZWNuLmggaW5kZXgg
DQo+ID4gYzY2ZjBkOTQ0ZTFjLi45N2EzYTdmMzZhZmYgMTAwNjQ0DQo+ID4gLS0tIGEvaW5jbHVk
ZS9uZXQvdGNwX2Vjbi5oDQo+ID4gKysrIGIvaW5jbHVkZS9uZXQvdGNwX2Vjbi5oDQo+ID4gQEAg
LTY1MSwxMCArNjUxLDE2IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0Y3BfZWNuX2NsZWFyX3N5bihz
dHJ1Y3Qgc29jayANCj4gPiAqc2ssIHN0cnVjdCBza19idWZmICpza2IpICBzdGF0aWMgaW5saW5l
IHZvaWQgIA0KPiA+IHRjcF9lY25fbWFrZV9zeW5hY2soY29uc3Qgc3RydWN0IHJlcXVlc3Rfc29j
ayAqcmVxLCBzdHJ1Y3QgdGNwaGRyICp0aCkgIA0KPiA+IHsNCj4gPiAtICAgICBpZiAodGNwX3Jz
ayhyZXEpLT5hY2NlY25fb2spDQo+ID4gLSAgICAgICAgICAgICB0Y3BfYWNjZWNuX2VjaG9fc3lu
X2VjdCh0aCwgdGNwX3JzayhyZXEpLT5zeW5fZWN0X3Jjdik7DQo+ID4gLSAgICAgZWxzZSBpZiAo
aW5ldF9yc2socmVxKS0+ZWNuX29rKQ0KPiA+IC0gICAgICAgICAgICAgdGgtPmVjZSA9IDE7DQo+
ID4gKyAgICAgaWYgKHJlcS0+bnVtX3JldHJhbnMgPCAxIHx8IHJlcS0+bnVtX3RpbWVvdXQgPCAx
KSB7DQo+IA0KPiBJIHRoaW5rIHRoZSBhYm92ZSBjb25kaXRpb24gZG9lcyBub3QgbWF0Y2ggdGhl
IGNvbW1pdCBtZXNzYWdlLiBTaG91bGQgYmU6DQo+ICAgICAgICAgaWYgKCFyZXEtPm51bV9yZXRy
YW5zICYmICFyZXEtPm51bV90aW1lb3V0KSB7DQo+DQo+IC9QDQoNCkhpIFBhb2xvLA0KDQpUaGlz
IHBhdGNoIGluY2x1ZGVzIHR3byBkaWZmZXJldG4gU1lOL0FDSyByZXRyYW5zbWlzc2lvbnM6DQpJ
biB0aGUgZmlyc3QgcmV0cmFuc21pdGVkIFNZTi9BQ0ssIHRoZSByZXRyYW5zbWl0dGVkIFNZTi9B
Q0sgd2lsbCBub3QgaW5jbHVkZSBBY2NFQ04gb3B0aW9uLg0KVGhpcyB1c2VzIHRoZSBjb25kaXRp
b24gb2YgInJlcS0+bnVtX3JldHJhbnMgPjEiIGluIHRjcF9zeW5hY2tfb3B0aW9ucygpLg0KDQpJ
biB0aGUgc2Vjb25kIHJldHJhbnNtaXR0ZWQgU1lOL0FDSywgdGhlIHJldHJhbnNtaXR0ZWQgU1lO
L0FDSyB3aWxsIGZ1cnRoZXIgc2V0IEFDRT0wLg0KVGhpcyB1c2VzIHRoZSBjb25kaXRpb24gb2Yg
InJlcS0+bnVtX3JldHJhbnM+MSAmJiByZXEtPm51bV90aW1lb3V0PjEiIGluIHRjcF9lY25fbWFr
ZV9zeW5hY2soKS4NCg0KSSB3YXMgdGhpbmtpbmcsIGluIHRoZSBuZXh0IHZlcnNpb24sIEkgY291
bGQgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byBjbGFyaWZ5IGl0Lg0KDQpDaGlhLVl1DQo=

