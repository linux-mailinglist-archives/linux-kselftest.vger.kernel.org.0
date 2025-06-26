Return-Path: <linux-kselftest+bounces-35833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D46AE977B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63CDF3A6558
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D9C25B30F;
	Thu, 26 Jun 2025 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Sip4cZp5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012012.outbound.protection.outlook.com [52.101.71.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFF20013A;
	Thu, 26 Jun 2025 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925170; cv=fail; b=W167OzthRdXYiTVHpG3kkTuljT0CpJ2kxOHE8z8uCBXCJjoedft2d7mQ7XQA6gj2E/Id6F8eIF++mFx3UT72CRiqMD85T55XeBiYoSiRuRsokVqwvmBjTZOTEFQHjni/TxZ9agcwvRjY3SX+YPorEy2dVX1lgvRDjrvJDySrMhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925170; c=relaxed/simple;
	bh=yHF6nK6LXNhTMbdLJfgKfjJTweMj5j7i6eXBCWOTvbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RJVNhyeMJAvRW+m5zRqR2ThvORNdWA4o99qCb1hhPK0sbxxGS8Wl4AxbWYlJ+v/UZ71sibvxaBWwma6/ElUSurBx3WjozUYeA15Nm1rnjdbzWCSVLMcBBsaAsgV1v+RCq9V4o4YXHVixJLRe5z18mBPTe7D2JyyzZ7xejNWfYME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Sip4cZp5; arc=fail smtp.client-ip=52.101.71.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzPVYwogL8Ql47FZIg1NgqaYV+NAauH4mQs7Fe/SwxRMgt4wNgkqZeOo7ZmB1WklFqbXzXpZeuw1gVbbf7nf2r4Adjgq1wvRuQzivPUHeSGQWfA1gJ2SWMJCwNlF5nl7IPa94zgKXAMnFCbK5jctmiiC7MTZrSrSDj5DnADjpG7Ylp6rsqIm4mZ7kvBngqTyGYLRsOe3X+yFRVDuG8pvgcBkDmUB12smCFdnqRWUV46lRE1qduN5tZa9rObXHXtTdfUq1Kf2DPj20iGs6x1CjATwx92gOsrXecMd+tBe+BJ6YH4SeDMSFAdA5OfKD/CgTH7tC/kWRcPlgRhSjK/CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHF6nK6LXNhTMbdLJfgKfjJTweMj5j7i6eXBCWOTvbg=;
 b=Bd+FespJEy0HZ93N3Yf5o5/iLQEebwAwEKE3/oEwsemnqpQWA3Dss2A5cOL7vrKI+obMI7MmaitUpvz4U35OaMLq8WJPPnbnIuZXDa7KfLUIV1XKPnGXwSU6o1r/Yve/VVyhgWfsHWeqfyRVh/0Fn8GQdOZx3JYB1YTaqEqS5sYY7KgLXcxYiuVttxDmgZu3/zM4GZwZFB6R+e9MZmT5AW4lKpwz27ehD3yEKn0qyN756mLt/3QrPM/zqgCntix6PaOes5JR2LM9BPhA9gvSPF9lPmGnS64wuYJ6rs6PeP6pTSy/WEM9Nk/jqWhkyQByMCPf0xSx+L5t8VLWC4B+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHF6nK6LXNhTMbdLJfgKfjJTweMj5j7i6eXBCWOTvbg=;
 b=Sip4cZp5uFBKxkcbf5mKtUJ2V8deVHtsJ/9CO+8tKYnpBtQaEclPmAvkGYzTBFiLpn1AFjGZX5cOpsj8A/F6sO/R9tDrJD5GH5xFl2KOYjJyTrqZXpA/gTi1WTOQPJRTyfFoXA+tdNVo02fxPZ5dNFYgarpxhupLZjQ2+Ven0YKxDZgnkFPrOVDfI/dQjUEmpZtoV5EhPl6HTdnQiQY+GPn4PVU2gVqC5HhFBI2lkLyanE/0Ns9wuaL2/jPEoGwqNY7Bg8y9r82jKoGwRybKHpxvq28qhLbvUrUICE36Gf4/zrU9MuMQTBwWamhrkiD0iHQfP+xi4b2C+//WIYnHgQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB10043.eurprd07.prod.outlook.com (2603:10a6:800:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 08:06:03 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%6]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 08:06:03 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@google.com>
CC: "pabeni@redhat.com" <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
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
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	"Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v9 net-next 05/15] tcp: accecn: AccECN negotiation
Thread-Topic: [PATCH v9 net-next 05/15] tcp: accecn: AccECN negotiation
Thread-Index: AQHb4uP+gZGxoMvnTEiRRZLAeJpFUbQTh+OAgAGQ6/A=
Date: Thu, 26 Jun 2025 08:06:03 +0000
Message-ID:
 <PAXPR07MB7984D9FE47565621DA52E377A37AA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com>
 <20250621193737.16593-6-chia-yu.chang@nokia-bell-labs.com>
 <CANn89iKX+DxvcM6t8KjanRofdz8ksMkcHj_V0w_LAoredq2gZw@mail.gmail.com>
In-Reply-To:
 <CANn89iKX+DxvcM6t8KjanRofdz8ksMkcHj_V0w_LAoredq2gZw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB10043:EE_
x-ms-office365-filtering-correlation-id: 0eda356e-2888-4151-6e55-08ddb4884b87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?elQzWXc3eHJqOGtWV1drTmtIUVV5L2JlYkprWUk3RmtGRVBUYi9CR0xEc3RP?=
 =?utf-8?B?WGNPZ01wSE8xTEtJL09kdVJ2UFcvQXVBbHpMOHhqU3RoUGExRW1VQ1dodnJ6?=
 =?utf-8?B?aVc3cXR4NzNpeEtYaFhFZDhUb0NOb3o1Yyt3MzVVOWJ1R0wrakNDdURSNUZB?=
 =?utf-8?B?UFJMZ1VaQk91N25iYUkxVEhueE0vVXdtT3JtUDA0NmJMV1RUZGljM09UNi8w?=
 =?utf-8?B?Q0xPSHVqMVRGVDloOWFFbmxGeElVaUV1WVhuMnU1WmxWV2tGQkdJZmZtMVNT?=
 =?utf-8?B?OWxiTmRMTGxQR3VuVE5VN016a1FBKy9GTmt3OWdGZ0xFWTh3M3lUQ0xpZUxR?=
 =?utf-8?B?K0NJTlhzLzVrSzgxdWFUT05MME1kQ01TeXJZMnBXdzZEOTV6Rm1KeFVxMFNq?=
 =?utf-8?B?ajkrT0tsRW5Lbys4dVI2M2x0ZGtuQzFhR0hPeWd6bEZZeTA0VVRvUDU5UGJZ?=
 =?utf-8?B?UWxiTGtBK0VLL1NXd0IxZlRRVzFLcnJPcGpaMHE0M3REb3hvYkZ6M3NkbVo2?=
 =?utf-8?B?OXZORmdDTE9xSVJOMG5JUU4zeGhwUnk1TDVsanZNak5ybS95SEtFY2xpYUNw?=
 =?utf-8?B?TmduVTlabytEdkxFYkVJeTVxTHVhb3FDWVY3UmFUZitPWTFJVnE2MWl2MUhN?=
 =?utf-8?B?T1MrSEs3SDJKemhVUTQ4bTJtVUlUdVNEUVg0T3lydjljSXdNMmRNdWNxZ1gr?=
 =?utf-8?B?MHF3L1JPQUdDR0xSY1ZRRHhmQmEzbzV1VmRSMk9sQTBTK3ZYNlIzVHFzUWFh?=
 =?utf-8?B?anFGc2xqODdYNldsL3RsZzBUVCtRdzlSWXcrM2RaRjFmRTYralo4SWVXNGFQ?=
 =?utf-8?B?RXZpNHB6OTdvWC9VbjIrMS8xSEpRdkx6cWJ4bDdVUStsOHlUL2lzR0U3UTRq?=
 =?utf-8?B?OEFrQXY4a2N0cWp5cnVydlB2aTdVY1hESTYxaGwzb0hoSEhBTkN6NmdRWHk2?=
 =?utf-8?B?d3RZeThielFpbnl2L3lrRnBUcW5tb2g2MHArZHJlK1pXemZMenZMdC9FOWZV?=
 =?utf-8?B?clhwaU8wOGJNeGVBV1dGUDRESUVIdGdPek1CYlhzL2NYZTZ0akcrZnQvVEFK?=
 =?utf-8?B?RXRVSFRQc3hiaW0zeE9jalZJRHQyM0J4N3N0NzRYQk5mYndqVXNySlhSRTFL?=
 =?utf-8?B?My9WUmcyVDFTOENRd2Eyc3NKVVdXRXk1dkI3SDhybGpkRmgzVlYzckNsOG9N?=
 =?utf-8?B?cHVpUFlBa3BRZS9jQkJYNnFvOXExTnZ1UFFoN2xZVVR0UmJ2ZnRLMTNsTnh3?=
 =?utf-8?B?WGd2RlhPeTVMcHE2QUVpb2ZKT25iejRyN3VOcGt6YitZVGM5a3gzZ1dYb0tR?=
 =?utf-8?B?S2hMKzA4eTRLb1JFbk1GdFc1MXh0ajlSYmlYWlhlK0VFVEpEdndRUlZ5YlNE?=
 =?utf-8?B?aUNraFJVZjZOeU0xQXY0U1NYM2k5YnhjTWFUR0tscFQrajFEZWt0WXdRdUhp?=
 =?utf-8?B?WVFXYXlMRHg0SEZ2dE5jcmpJM2pvY1k3b2xtZE5yYi9DQlNyUVA5Q21BMTBZ?=
 =?utf-8?B?Nk0zZmRqN2NDcjFxbXI3RnplWmtyV0Q5cUR1UERTVjI4TEwrcnFaK0dadjNq?=
 =?utf-8?B?UzZ6WGl2WDh5Yy9wYVhBczJkL0tOdXZQOGsvVVF2ZGluWXRtMmlkcWRySUln?=
 =?utf-8?B?RGR5NnhwdE5GOGRRZENab2V0SjVpUHd1SG40M0hLWFBtc0hRejRIM0NzZ1ZS?=
 =?utf-8?B?bnRnUHVSTTBZNzV6dE5IRjl5MlJoaHRkYUJoa0ZiQWtOZU9vbWRVdmNoUGxi?=
 =?utf-8?B?Ymxib3Z6VzE0U0JieTZOMTY5NWNNcjJVRGEwNnJzZ1pFbTZBVnB4bW5PUmtT?=
 =?utf-8?B?aTRpTlVDbVpVRDdCVEwxYjhVNTAxWmp2aDN4S20vTk1VOVhaMFNRek9VbjVi?=
 =?utf-8?B?NkJwdFV1cjZhRHFMVFh5cnI3TjV3anFLZ0k2RXJlOTVVVXJEbTV2L1VjVG8w?=
 =?utf-8?B?N2xWWjByRFc3WGU5aVhNT2p1a2pGRHM5Q2FJNytSV2hQNER0cjROL3pXOGE5?=
 =?utf-8?Q?u7FLwgNIeu72Yp2JBCWZoBhnMVuRoQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnR0N2ZocjN6ZjZ2QzlhSjVpT3BlL2cxdEx4UHlWOGI0MFE2aXJ0R2cyVndQ?=
 =?utf-8?B?dW9QMnJUT1JWODZ3UDFMMGp4NnNybC9kUEFlblBjTjdCUlFyLzRYd3k2VCsw?=
 =?utf-8?B?NU5lN3l4SFpBL2dyVitFTmJRdDd1MVBNRmN2eUs5WFg2dTNNbjlLdU45a2ts?=
 =?utf-8?B?WUVWMU91S1NsN3NDSVpTSlhqeHh5NFJSUmZNWldQSmZLUlE2UGRLVTF5MU5S?=
 =?utf-8?B?ZmRYWTNNSEZjaFpkVnpmMllOdG9waDVPeE1ZSkl2czMyaUtDTm1WTjdTVFg1?=
 =?utf-8?B?U2NwV0dkT012VWExcmI3WVUyM3RSdjlaT2RnVk44YmRnTXg4RkE0Vm9MRkV1?=
 =?utf-8?B?dWVSbnhqOFRCSmg2dzJUdlNxYUt3c0MyUS9vWlhmMjZ4ODF6RGlmMVdDM3RM?=
 =?utf-8?B?MjZXSnMyZzZTdnNuRXFpNUR6RFZGRkV3ODZWU2M0Q2JOQlpHVERKMFBJc0sw?=
 =?utf-8?B?NWd3Umo5blJFTmMvVFZGdncrOVQ4bGpOUk1MNFZ1NEs5NnRyb0ZhcTExSFoy?=
 =?utf-8?B?ZDZHd050SWZSZjV3ZVhpNjNnSHl6a2RDSGlqMXdFTGZmc0FZOEN1OE1kZnly?=
 =?utf-8?B?KzRNZG5sTlFkc1JrR25ydmJNUFBpaDdDdVVGeTZHeGxTUzVGSkJnZC8wcWZy?=
 =?utf-8?B?cFNwVUFEMzd6Z2VQK1JITjBJQlI0REtvQkx1R0svVWlLUG5ic3JqQlEvY0dW?=
 =?utf-8?B?dHM0eGZqZUVRVXJTazRMbGUrU1VWSGF0dVRSeFIvNklsSFByaDk3cGJOY3RF?=
 =?utf-8?B?dzhKVGJpMjJJaDF6aTNvQmRWQlRwRG94VmRmVGRXTWhUdjVMNG5nMmZDSzda?=
 =?utf-8?B?NEk2RlBINWFhNGs5b2J0WlVleUw2VVJ6cTFIYjVtVjNYNW4zbnFCVW1wRVFN?=
 =?utf-8?B?TnN5b0xqUHNxVGIzWGt4RTVJaHNIZlRuTS9qd05nczVHVUl2QnBqdHpiRmZx?=
 =?utf-8?B?aFd1UlluZFVtZm53R0ltL21OdklpN3oweTUxUFVtdmsrWld6aWp5T1NNUkFJ?=
 =?utf-8?B?UVIwdXNJOGFJRjBueFRhWHNZcHpVczdUWjl4OFNOSzE0aVJQSGU5Z1BIMUtr?=
 =?utf-8?B?dVM1UlorZTRCaUdHMVI4TFlVcFVSSWhCS2EzOE04SU9sV1Y0cDU3ZGsrUUR4?=
 =?utf-8?B?UlpUbmVlOGE5QUIxNkp3NU9lRHFSL3F4dUN0a21FOGZaZTBKYXRYN2NpSTBJ?=
 =?utf-8?B?elFlTmVISGx3OTBRMkxTb2xJN28xRWdwUDZkRTVycVJlTWd1RlFYMVNvaHQy?=
 =?utf-8?B?bDltQ25HaXNvZWE2cGdUT0hNQnFpNzVQa21NTjl3NEhYek9pWndiTy9MT2ZT?=
 =?utf-8?B?SVF1TWltNVhQNkhoMzFDNWJvd2s1SGQxczFYNTQ5QVNaRnRYMTJIdkxFZE1F?=
 =?utf-8?B?c3VRRHZZTG5tejdqV1czVTVVMUN5dGxtbyt6Z0lsdThtV1pZN1ZMQWNhdmlJ?=
 =?utf-8?B?aUxyNmZldWdHeXZlV2tiTDZTUThZSmcwR3BGZ0JKTGF2ZVB3MW9DeUVlRGQ4?=
 =?utf-8?B?UjVYM3J1MFFkdFBOdmxYQXNGeHkrQjhEVUhvbzd1cDRaSUxMSWpPY3RteGc5?=
 =?utf-8?B?dkRoVmRzdmlhbHhUTVB2VWxZdmg5NHJFWm8zUFhHMG90OWx0b1E1VDVwSkxy?=
 =?utf-8?B?dnVaRnQ4QmNCSjlOdFRENkxnRlU3SzI2Q0h2K0k5NWhjT3lqcm5UMGVkbUJH?=
 =?utf-8?B?OFlBQnFTVFdzQk1EeEdhY0lKNnlnTmkvbDAzWThCK1VYbUhmRnUrMmw2VGZ0?=
 =?utf-8?B?UXNZZ0N1YjUzUERuQnRabHhVVGJJTFZ5Y2dicGowUHFRRWxwZHBFR0REMlhr?=
 =?utf-8?B?SGMzT1ZsNk5XbEZLU0FDUEpjVDdubmsyNU5yVXpXS0ppallQc1d6OEc0UVhq?=
 =?utf-8?B?MFBLa1lWcWpBOVQ4ekJyWWlQTlUyY3V3N2xtaUJwS3RFR3padEpvb0F0c3Ns?=
 =?utf-8?B?ZWlmQVRXbS9rVDZyNjk4WGM0OEYxU0hLd0RMVTVWTUM0cVZFNk9PQTkzV1Rr?=
 =?utf-8?B?ejV3ODNac0preDh2N2tOSnU2bzJyRVRuOWFFOWlNNjFrU0pOL1lpT1dHUWha?=
 =?utf-8?B?MkJRYnRjS20rNi9iSmxBMDBUQlBLeWNmbGdkWVNMNWNOWkFmVFVITHFsQWc5?=
 =?utf-8?B?Y21hcCtLMUsxNCtieHNic2ZXelFxN2xlM3doN0htTUxMUEdVTUxLbVIxZEty?=
 =?utf-8?B?YXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eda356e-2888-4151-6e55-08ddb4884b87
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:06:03.1974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cuvR7DM1ziCwOznPKXNuelYqEEkaXITKOZLY/cfzBcphURrshLWjvyPsZxIMO/8IEVWAHwnTHb4VotxrN8OM5vA5SLTjWvajs5ydhtqqViJ3yV02r57GlGePUXjEJ4j6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10043

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBXZWRuZXNkYXksIEp1bmUgMjUsIDIwMjUgOTo1OCBB
TQ0KPiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwt
bGFicy5jb20+DQo+IENjOiBwYWJlbmlAcmVkaGF0LmNvbTsgbGludXgtZG9jQHZnZXIua2VybmVs
Lm9yZzsgY29yYmV0QGx3bi5uZXQ7IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9y
Zzsga3VuaXl1QGFtYXpvbi5jb207IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtl
cm5lbC5vcmc7IGpoc0Btb2phdGF0dS5jb207IGt1YmFAa2VybmVsLm9yZzsgc3RlcGhlbkBuZXR3
b3JrcGx1bWJlci5vcmc7IHhpeW91Lndhbmdjb25nQGdtYWlsLmNvbTsgamlyaUByZXNudWxsaS51
czsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVu
dGVyQGdtYWlsLmNvbTsgYXN0QGZpYmVyYnkubmV0OyBsaXVoYW5nYmluQGdtYWlsLmNvbTsgc2h1
YWhAa2VybmVsLm9yZzsgbGludXgta3NlbGZ0ZXN0QHZnZXIua2VybmVsLm9yZzsgaWpAa2VybmVs
Lm9yZzsgbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29l
bi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29t
OyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmlj
c3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmlu
Z29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb207IE9saXZpZXIgVGlsbWFucyAo
Tm9raWEpIDxvbGl2aWVyLnRpbG1hbnNAbm9raWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY5IG5ldC1uZXh0IDA1LzE1XSB0Y3A6IGFjY2VjbjogQWNjRUNOIG5lZ290aWF0aW9uDQo+IA0K
PiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkg
Y2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0
aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4g
DQo+IE9uIFNhdCwgSnVuIDIxLCAyMDI1IGF0IDEyOjM34oCvUE0gPGNoaWEteXUuY2hhbmdAbm9r
aWEtYmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8
aWpAa2VybmVsLm9yZz4NCj4gPg0KPiA+IEFjY3VyYXRlIEVDTiBuZWdvdGlhdGlvbiBwYXJ0cyBi
YXNlZCBvbiB0aGUgc3BlY2lmaWNhdGlvbjoNCj4gPiAgIGh0dHBzOi8vdG9vbHMuaWV0Zi5vcmcv
aWQvZHJhZnQtaWV0Zi10Y3BtLWFjY3VyYXRlLWVjbi0yOC50eHQNCj4gPg0KWy4uLl0NCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC90Y3AuaCBiL2luY2x1ZGUvbmV0L3RjcC5oIGlu
ZGV4IA0KPiA+IDZjZjVjZWE5OTJlMy4uNGQ2MzI1ZmEzZjY3IDEwMDY0NA0KPiA+IC0tLSBhL2lu
Y2x1ZGUvbmV0L3RjcC5oDQo+ID4gKysrIGIvaW5jbHVkZS9uZXQvdGNwLmgNClsuLi5dDQo+ID4g
QEAgLTEwNTEsNiArMTEyMywxNSBAQCBzdHJ1Y3QgdGNwX3NrYl9jYiB7DQo+ID4NCj4gPiAgI2Rl
ZmluZSBUQ1BfU0tCX0NCKF9fc2tiKSAgICAgICgoc3RydWN0IHRjcF9za2JfY2IgKikmKChfX3Nr
YiktPmNiWzBdKSkNCj4gPg0KPiA+ICtzdGF0aWMgaW5saW5lIHUxNiB0Y3BfYWNjZWNuX3JlZmxl
Y3Rvcl9mbGFncyh1OCBlY3QpDQo+ID4gK3sNCj4gPiArICAgICAgIHUzMiBmbGFncyA9IGVjdCAr
IDI7DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKGVjdCA9PSAzKQ0KPiA+ICsgICAgICAgICAgICAg
ICBmbGFncysrOw0KPiANCj4gQSBjb21tZW50IG1pZ2h0IGhlbHAsIEkgaGF2ZSBubyBpZGVhIG9m
IHdoYXQgaXMgZ29pbmcgb24gaGVyZS4NCg0KSGkgRXJpYywNCg0KU3VyZSwgY29tbWVudHMgd2ls
bCBiZSBhZGRlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+ICsgICAgICAgcmV0dXJu
IEZJRUxEX1BSRVAoVENQSERSX0FDRSwgZmxhZ3MpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBleHRl
cm4gY29uc3Qgc3RydWN0IGluZXRfY29ubmVjdGlvbl9zb2NrX2FmX29wcyBpcHY0X3NwZWNpZmlj
Ow0KPiA+DQo+ID4gICNpZiBJU19FTkFCTEVEKENPTkZJR19JUFY2KQ0KWy4uLl0NCj4gPiBkaWZm
IC0tZ2l0IGEvbmV0L2lwdjQvc3lzY3RsX25ldF9pcHY0LmMgYi9uZXQvaXB2NC9zeXNjdGxfbmV0
X2lwdjQuYw0KPiA+IGluZGV4IDNhNDMwMTBkNzI2Zi4uNzVlYzFhNTk5YjUyIDEwMDY0NA0KPiA+
IC0tLSBhL25ldC9pcHY0L3N5c2N0bF9uZXRfaXB2NC5jDQo+ID4gKysrIGIvbmV0L2lwdjQvc3lz
Y3RsX25ldF9pcHY0LmMNCj4gPiBAQCAtNDcsNiArNDcsNyBAQCBzdGF0aWMgdW5zaWduZWQgaW50
IHVkcF9jaGlsZF9oYXNoX2VudHJpZXNfbWF4ID0gVURQX0hUQUJMRV9TSVpFX01BWDsNCj4gPiAg
c3RhdGljIGludCB0Y3BfcGxiX21heF9yb3VuZHMgPSAzMTsNCj4gPiAgc3RhdGljIGludCB0Y3Bf
cGxiX21heF9jb25nX3RocmVzaCA9IDI1NjsNCj4gPiAgc3RhdGljIHVuc2lnbmVkIGludCB0Y3Bf
dHdfcmV1c2VfZGVsYXlfbWF4ID0gVENQX1BBV1NfTVNMICogTVNFQ19QRVJfU0VDOw0KPiA+ICtz
dGF0aWMgaW50IHRjcF9lY25fbW9kZV9tYXggPSA1Ow0KPiA+DQo+ID4gIC8qIG9ic29sZXRlICov
DQo+ID4gIHN0YXRpYyBpbnQgc3lzY3RsX3RjcF9sb3dfbGF0ZW5jeSBfX3JlYWRfbW9zdGx5Ow0K
PiA+IEBAIC03MjgsNyArNzI5LDcgQEAgc3RhdGljIHN0cnVjdCBjdGxfdGFibGUgaXB2NF9uZXRf
dGFibGVbXSA9IHsNCj4gPiAgICAgICAgICAgICAgICAgLm1vZGUgICAgICAgICAgID0gMDY0NCwN
Cj4gPiAgICAgICAgICAgICAgICAgLnByb2NfaGFuZGxlciAgID0gcHJvY19kb3U4dmVjX21pbm1h
eCwNCj4gPiAgICAgICAgICAgICAgICAgLmV4dHJhMSAgICAgICAgID0gU1lTQ1RMX1pFUk8sDQo+
ID4gLSAgICAgICAgICAgICAgIC5leHRyYTIgICAgICAgICA9IFNZU0NUTF9UV08sDQo+ID4gKyAg
ICAgICAgICAgICAgIC5leHRyYTIgICAgICAgICA9ICZ0Y3BfZWNuX21vZGVfbWF4LA0KPiANCj4g
UGxlYXNlIGNoYW5nZSBEb2N1bWVudGF0aW9uL25ldHdvcmtpbmcvaXAtc3lzY3RsLnJzdCB0Y3Bf
ZWNuIGFjY29yZGluZ2x5ID8NCj4gDQoNCk9LLCBJIHdpbGwgYnJlYWsgdGhlIHBhdGNoIG9mIERv
Y3VtZW50YXRpb24vbmV0d29ya2luZy9pcC1zeXNjdGwucnN0IGluIHRoaXMgcGF0Y2guDQoNCj4g
PiAgICAgICAgIH0sDQo+ID4gICAgICAgICB7DQo+ID4gICAgICAgICAgICAgICAgIC5wcm9jbmFt
ZSAgICAgICA9ICJ0Y3BfZWNuX2ZhbGxiYWNrIiwNCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQv
dGNwLmMgYi9uZXQvaXB2NC90Y3AuYw0KPiA+IGluZGV4IDhlMGU4ZDc4NGIxYy4uZTZkN2I1NDIw
Yzg4IDEwMDY0NA0KPiA+IC0tLSBhL25ldC9pcHY0L3RjcC5jDQo+ID4gKysrIGIvbmV0L2lwdjQv
dGNwLmMNCj4gPiBAQCAtMzM5Miw2ICszMzkyLDggQEAgaW50IHRjcF9kaXNjb25uZWN0KHN0cnVj
dCBzb2NrICpzaywgaW50IGZsYWdzKQ0KPiA+ICAgICAgICAgdHAtPndpbmRvd19jbGFtcCA9IDA7
DQo+ID4gICAgICAgICB0cC0+ZGVsaXZlcmVkID0gMDsNCj4gPiAgICAgICAgIHRwLT5kZWxpdmVy
ZWRfY2UgPSAwOw0KPiA+ICsgICAgICAgdHAtPndhaXRfdGhpcmRfYWNrID0gMDsNCj4gPiArICAg
ICAgIHRwLT5hY2NlY25fZmFpbF9tb2RlID0gMDsNCj4gPiAgICAgICAgIHRjcF9hY2NlY25faW5p
dF9jb3VudGVycyh0cCk7DQo+ID4gICAgICAgICBpZiAoaWNzay0+aWNza19jYV9pbml0aWFsaXpl
ZCAmJiBpY3NrLT5pY3NrX2NhX29wcy0+cmVsZWFzZSkNCj4gPiAgICAgICAgICAgICAgICAgaWNz
ay0+aWNza19jYV9vcHMtPnJlbGVhc2Uoc2spOw0KPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90
Y3BfaW5wdXQuYyBiL25ldC9pcHY0L3RjcF9pbnB1dC5jDQo+ID4gaW5kZXggMGZhMzgwM2IzNTNk
Li5jOTg2NDUyMzAyY2IgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lucHV0LmMNCj4g
PiArKysgYi9uZXQvaXB2NC90Y3BfaW5wdXQuYw0KPiA+IEBAIC00MTEsMTQgKzQxMSwxMTQgQEAg
c3RhdGljIHZvaWQgdGNwX2RhdGFfZWNuX2NoZWNrKHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3Ry
dWN0IHNrX2J1ZmYgKnNrYikNCj4gPiAgICAgICAgIH0NCj4gPiAgfQ0KPiANCj4gSSBkbyB0aGlu
ayB0aGlzIHBhdGNoIGlzIHRvbyBiaWcgYW5kIHNob3VsZCBiZSBzcGxpdC4NCg0KSSB3aWxsIHJl
bW92ZSB0aGUgZm9sbG93aW5nIHR3byBwYXJ0cyBmcm9tIHRoaXMgcGF0Y2ggaW50byBvdGhlciBw
YXRjaGVzOg0KKDEpIEVDTiBuZWdvdGlhdGlvbiBpbiBzaW11bHRhbmVvdXMgY29ubmVjdCwgYW5k
DQooMikgQ0EgbW9kdWxlIGZsYWcgKFRDUF9DT05HX05FRURTX0FDQ0VDTikgZGVmaW5lcyB0aGF0
IHRoZSBDQSBleHBlY3RzIHRvIG5lZ290aWF0ZSBBY2NFQ04gZnVuY3Rpb25hbGl0eS4NCg0KQmVz
dCByZWdhcmRzLA0KQ2hpYS1ZdQ0K

