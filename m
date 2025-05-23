Return-Path: <linux-kselftest+bounces-33666-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AE3AC2916
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 19:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A08601C04D49
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 17:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89DB298988;
	Fri, 23 May 2025 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="MWUCrrDr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010046.outbound.protection.outlook.com [52.101.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553BD22338;
	Fri, 23 May 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748022635; cv=fail; b=LqZJmOLshqCiHO6FsMmXRsMQITuq+5QL9fuEiJYuW6/X/8uTlMspKA6aJD/XN9ACaQpYwA/OMVkyiZz3sXlPU0MxRB01W3qmcwmj4v7kJtsw7JCovGy+vSu5rLDMDDAYhTmO6g8RPbqbIeNK2sXNvx/BIQqWUy10Spel54wl29c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748022635; c=relaxed/simple;
	bh=IVPn25mfsX/IrC4g9BUjk1/30dvjvJod7r0UITnNrCc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uT0eSJtgVQImU64sRIB7oyIyjNpIYkAP4so/mwz4yq1s+IB2a0pVoYk/cdW0bA0WiUADMKRnXBHPKHbrHAwscv5cW2HiFd8VuzTIwWFsJOlfs4m7+1jUvELqw0St22YpapHBuqbvmj0rFS2+BJfzXSFViJRHPfWhFGqq+RORryo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=MWUCrrDr; arc=fail smtp.client-ip=52.101.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CTyxf5qEHktFypK+2l1Gb/OvcX5WXqleLGR04jwk2jXIUjGYw9iId9L3lHjJ8iZZHTbMRJdN3eOqIBAKc4wrQs3hJ6xNvA3tj/gdDEySXOfSY65MYYY02KP9qhrhLKOVR1qS8xKOZADByWbq/xJGJGIUjd1Tmm7ZZznXOsJeGsRpqwUoOXufnGzu+RtM2aJ2DwBMgoLUhxNDlSQR23hja/D8j4W5jaO2XBibRWs09f1zTfoXHozcVj9+o6GY4/lw8fObcoKhRVlP90Rge8w455OWBq6ISLfnBLNtUAM7/S10hJvKHB1zPELq2GwRKt9i9dE7Uq5VmXLrvSZ4h65w7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVPn25mfsX/IrC4g9BUjk1/30dvjvJod7r0UITnNrCc=;
 b=WB3gM19E2sqJ2rDgbJzCIz+0nwqJErTyn0cCVc+uLVdaiYs72lTy99jaqMFGb2eO9xI38B/gn59ELnVMm4JLIDMg/QuPJf78wR672uaYuL5LpYRO/XXXZAmXU6yuu7L5TG+yLwlTiebd/AE3CAT23PjzmTBrs/jSOlAYE3XZatNQzDid97WyENS32LoeDydSMhGk53tFckLhnmSUa+9lhK3aoySr9APmjMEwr6YAkhlg/6lkiXb2FNJJM78JANCHE/eHnwWi4+x1zYMnHfXdXEMFhyu7bXBa4V1e7RJ5fgNcET3Lgv4UB9sxfuNzZVCtxooEZ1HbgsZe34pnEWx5GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVPn25mfsX/IrC4g9BUjk1/30dvjvJod7r0UITnNrCc=;
 b=MWUCrrDrX8n/IdNOBGUiB1XgGumeMeFQLcVyip0feV1Cg3whCBLhAC1O3fD1codo2+gyCNhVqXyJdPyleceXSJBlPCeq8KKxMzYy/xtJyxs1g52FxzgwV1mQp/QM63hmHKU2yvHvLOWitbQADboInT1hf5ff3ScrM3lOMb/fY87FrZT5659dt/jaLJ+GnLyHDKXQ/5rJUNiWZy6drnP1bSp+gNp7T38n9v/ajGHphnpwWtGp6CO7WYOvX/Va3bBZDGjmyRes5MIZ/mm/vOqCbacEjSQB+/1plPCEwUEfyGjdHbop2dQSnK0Zpo2xh3HOSvIUHEshtLDH5ejSyVkK/Q==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by PA4PR07MB8792.eurprd07.prod.outlook.com (2603:10a6:102:266::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 23 May
 2025 17:50:30 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8699.022; Fri, 23 May 2025
 17:50:29 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "kuniyu@amazon.com" <kuniyu@amazon.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us"
	<jiri@resnulli.us>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"ast@fiberby.net" <ast@fiberby.net>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 14/15] tcp: accecn: try to fit AccECN option
 with SACK
Thread-Topic: [PATCH v7 net-next 14/15] tcp: accecn: try to fit AccECN option
 with SACK
Thread-Index: AQHbxNgbhyBQLG6OxkyMUqbRZDdnsLPbU0SAgAU3PcA=
Date: Fri, 23 May 2025 17:50:29 +0000
Message-ID:
 <AS8PR07MB7973548F209E86B95C4DA53EA398A@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-15-chia-yu.chang@nokia-bell-labs.com>
 <5cd44751-19df-4356-a485-a7ba18a05482@redhat.com>
In-Reply-To: <5cd44751-19df-4356-a485-a7ba18a05482@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|PA4PR07MB8792:EE_
x-ms-office365-filtering-correlation-id: 0a3544c4-608c-457d-3512-08dd9a224e92
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Tjg2Rzg1aFAzM2RQd2pnTkhEYmxTc1IrVnRGWklRSWxBYVdUTEtidWhJU0dR?=
 =?utf-8?B?UHlxOFhOdGVGR1p0b2t2b1UzVHNXUE9wYUdBc3FONUkzYjdPRHBvVGRmcG0y?=
 =?utf-8?B?NHg4K2pVWmVxNVNsdkFyc0pzQVZ6NTl4eG5YUXUvNnNMblhXcCs4azhMRnZE?=
 =?utf-8?B?SWZrZGcvR0RYNkQ5UkFzM01FVVNpL2pqbzR6MHRrUVRpZUFSYlpVVWUwSnJh?=
 =?utf-8?B?d0dJd1BIR3BhWUQ0RFZ1S1I4TlBrZGkzUlFpZzZoeHFZLzYzaVRSZ0V5dDBR?=
 =?utf-8?B?allveU9jNHpwaEg5ek5DSlJINE9aK0Q2SG5OUGdubk5jNnh6cWJFZWNoUEdK?=
 =?utf-8?B?MVFuUWRYODVCK2RSclJEZWdtVTkya0hUZUREMzYxVFIzYzhNSTh2R0wwQW9M?=
 =?utf-8?B?aXNyNHNZRFZENUErbitPRzAyOTBtcnFuK2J1dnVxWEI2a2JFRzNSaWxnZDFC?=
 =?utf-8?B?OU4wQnYrOWY0L2hkV2ZNSVNURkVBOTBGRjRmK3pnOW5uREVobVdjUnBONWxN?=
 =?utf-8?B?a1c3WCtLRjhGbC9jR1RGVnZLRTc1eU15QWIvdWZvbHY1VmpsSEZhQS9oNHNM?=
 =?utf-8?B?WHF6VzNkRFlaV0xCak1QZFEydVJaQno4eTNJaWZ1YUVtdkNqQXhobFBzR0JP?=
 =?utf-8?B?ZWpZYkoyeC9iT09KNkUvNjVtcGhCMkhCcFhBSWVHQzN5RDBHVk9RTlM1Yklj?=
 =?utf-8?B?aDl2UmFKb0pnckVTTTZCK2phUmpKL1FqQ0puSmt3TzFXdzlrK3pLM1B1TXU5?=
 =?utf-8?B?VXFhSjdRejNFZ1k3bFhsNURCVk1uNzZvTERUc3BWR1p4NmpWZEQ0cVExZ3Qv?=
 =?utf-8?B?bWsrNVlkb25XZ0lNdDZmTkxjUDV1ejFVYVhGdUdIMU84ZUMzOVdmYXpMUWRS?=
 =?utf-8?B?SU8zT25QdjcwUzBpb1BQVmRqUVVXcVk5YlgwSi8yT3QrR0x5eG9uUmg0T1VY?=
 =?utf-8?B?RXNwdkw4aktxWDhsNWNyd1JQYUZ6TCtuY3NjaE1kZDFURVZzRkVOQ0JTeHk2?=
 =?utf-8?B?SHpJNHgveFUxeWdsdWtBTjl2QmdKRmNLMUd5WGRyQnh1Y2k0ZjVSdm00WHpS?=
 =?utf-8?B?OUdwa0pXV3lzMHRFK0t0OEVveTRXVFRrbXRVOCtUeWlwb0pIQ2RWTmlzb25m?=
 =?utf-8?B?UGpCRWFZeGdYOFJzcEpkcEdXaTcxZG9kL21wSW9HYnJlTkgxSWNsaW1HRVdZ?=
 =?utf-8?B?Nk1aL2ZRY1c4bW9oempUU3NxUWd3UkxTYUR3SEhWeE1wR09weStFZlJRc1ZL?=
 =?utf-8?B?b09VWE5KK1BUTjB5STQ4TVkzcmx4SytWVktXcCtSKzl6NHpvTWVOb0pUaDBO?=
 =?utf-8?B?S05EV0o5SXNtNUlvd3RVa3RkUmpFNEpwWWpMbDYrMm5aVlFCcElheUZ5Sm5H?=
 =?utf-8?B?cFRWVmpjU2VUOHZNOTRYY0UxcFp3NnJlcU50VmttRzR2RG41NXBjRXMzRFpo?=
 =?utf-8?B?SUY3ZXJNRC9qSmJ3eFFUNzZBYmlWSEs2SHh6Vm43RVhKK3JkTmVneHczd1Ri?=
 =?utf-8?B?VlpoVU9JaWlNNjF4YWtvZW91L2h4NTlOY2FqUFJGVDZTaXBzUzFqVDJuTVVi?=
 =?utf-8?B?UkF6MWtBdC8xUjMvdXVPbjBxTjhVYW51ZVFPbk16dnhhcTBwODN0VmF3VXRx?=
 =?utf-8?B?Mlk3YUdEREk3blYvTTh1TlNIMHA1d1Ywa3RKUXdTK3ZNUEkxUnJBaG9xYUJS?=
 =?utf-8?B?S3hDS0Z4QmFEa2V5Z3BDTVZmZVViSDJVQmQxLzgrNng1ZStPS3Z5NzRsZGhB?=
 =?utf-8?B?K3pNZFQ2UUt5TWtLUExDemdKaWhuaSt2ZExTblVxekFLaE9kVDlQQmd6Q1d2?=
 =?utf-8?B?eVNwbDkzWDhuUzRyVFpzd293RFlBbGtmZ0VVMnM3V3cxYmozVFE4TGlKR09i?=
 =?utf-8?B?ZXJBZGtQc29kMDZVbmpobzNpbGExbmlNNVJNaUxmRlRrWmFIRGJCVUtETW9p?=
 =?utf-8?Q?KgDggQt/C6M3U6Zcg/4EDBC63b4oXt+G?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzlidzM2TWkyNC8zT0JuaitYb3V0cUtkUEU4OGpqR0dIak96NFRiNHV1QjBu?=
 =?utf-8?B?dUpWT1BvRDR0WnIzWEdDdDFRaGd5QXNoTXo2NE9ybDh4SkZOdUxwVDQ0QkFV?=
 =?utf-8?B?QnFTKzUxT1d2TjlEc253U0hDcmVQdUIxQlRsdEw2MTVibUFNbDcwZHRvM0tH?=
 =?utf-8?B?dVJyK2czUTRHSm85b2FlN3QycXNaelVINFk0eVplYkEwS015ZG85VlA4NTY4?=
 =?utf-8?B?d3l5YVJvSDFBaWl4bXNHd1JncjNzcW9GTHhlZlZ4aUlsbVhLL210SENzWUht?=
 =?utf-8?B?TERjQTZyaVJIZEdzRlViODZuOFcyK3VLWDZwVGkyTm1ScHZxaU45ejR3bFJ2?=
 =?utf-8?B?VUtVdEJJWVkwc1pKN1MwaDd4RkphRFQ3aTBZWEVzRHlOZVlZcXJLVDlQWU43?=
 =?utf-8?B?elQ5M2tVWUFOb05mM0hhL1AzQ3YrcWF3RjhYTlFUbVFWTC9jaVpvdlh6UHky?=
 =?utf-8?B?Zi9nOXczS1ExSTg3cXEwL0FETkRxdlozOXRLYU13c3VtQVY5ZGhSTEt6QTh1?=
 =?utf-8?B?UnVhSXM4SDd2RFFvSzJ3RXdBMTQ2R2pYUldQRjNwMmNhdTZpenBFYm1neVJo?=
 =?utf-8?B?MUNyeUxyb2pWRU82cDNvRUdFTXpFNnhVa3lIclB4S3pGYkFUdlFhQ0RXUEV3?=
 =?utf-8?B?SkxBaEkvajJSa0plc1BzVmhUMmVoUzNabjhoZHE1N3Y2d2lNR1VsSUNwU3lL?=
 =?utf-8?B?Mys4dmQ5elM1MUprRUlqaUs2QnBYV00vZU9XcHRma2lIMUlJWTRsaUNGRVRP?=
 =?utf-8?B?N05TWXc4bFhkNitKS1ZxR1dYS1IwM2YwYWt5YXFxejJKL0lSL2NLbVRvb0xR?=
 =?utf-8?B?N0hob2FsTCtzU0NTNDRKeWpYTnlJOWFxME0reGhhTERQK0ZBWTVwVmFqbXN5?=
 =?utf-8?B?MVpDbUpiNE01Mis5UThGa255bDh0MGJueXY2cmlHZXNOZFZaS2gvZW8zUEho?=
 =?utf-8?B?KzlCK0N0Z2hqTzVkeW81eWdQeUVXSVRhbkJQZURtL3ZleHE3ZmxJOXd6NmZn?=
 =?utf-8?B?ZTdpMjJieHJUTVJ5Q0VDejlXZnlKMm1pNlN5WmY3d0t1aU1UaUlhS1g1Y1h6?=
 =?utf-8?B?R1hJS3B0T3lBbHM1ck5qc29kT0hFMnR1UWZaelRpOXQvY3AzWHVyOG1Rci9K?=
 =?utf-8?B?TXpJODRwdGY2dm5BSG1JNkVVa1FVVFI2bkpqeXBLbnZWRHJvWTc2dFNaYWNU?=
 =?utf-8?B?cWZVYjhIeWZqK1Qwck8rSlF5cFdha3grMmxIVTFHRDl0OCtxamFRNitraW9F?=
 =?utf-8?B?OUZaQjFaYnMzQnlVR1IxS1pVUGdzUzdJNWRUWkd4WTJsNkMxdU9ScXZwS0Y2?=
 =?utf-8?B?SWpxNEQveDJZZFE2aEpOeWV1eHQ0WktZUTZMR3FlQmJxOWVZUkhxV1RZdjVk?=
 =?utf-8?B?endwWElEa0hRRy9BTnNmOGIrWlZ5enN1ei9WQXAvbEFva0E1SlYzTnpFMER2?=
 =?utf-8?B?djdFVkZSbFhOcThCOXNNcWZjMVNWL01JYzZtK0J4VTZ2NVNIZWt2ZXVIajlT?=
 =?utf-8?B?bHJRM1pSbHI1dEgrNUI5Y0FnNzkzdmlpc3d1aFNDWTREZU1kUGM4aFMybGxJ?=
 =?utf-8?B?cXBMWHFXeVFzV0doa0dpV01UR2c1aCtUTGoyOU1YQUNWVTFBaGE0U3VXMjhQ?=
 =?utf-8?B?U3hlSjV3N016aitUMmhsUGdhRVpjYUw4U3cxMFdqSW5Wa3NWbm4vZU40dk05?=
 =?utf-8?B?M3JzVjdkcXZRZTRKN096Z3doaS9kVTJIUDZBOHVWN1FQenNTZ2xkZ1l3OFpr?=
 =?utf-8?B?bVFCbFNMbEUvOHRwbDdUaFp5cnpzWnl0UU1XOEdMMjY5UUt0eXl0R3VmUE0r?=
 =?utf-8?B?dTBaa2VyTWxBdTB4ZUtoY0ZuU0VUNFVRaXdhcitibmlPcEtDczNheXRLS21Y?=
 =?utf-8?B?bi9SOG0vRjNEUXplSGZSQXZ1U3k3ZWlLQXlUeWFxa2kvcEozWUwrSEZkNVVN?=
 =?utf-8?B?UWl3bkk5VEJRVHBmZ1RTSnVTY1VOT3pGUG1PL2hyZFl2eWFYWVBvUlVUZTVs?=
 =?utf-8?B?bENPT1dGZ2NpeHdqdG5vRTkvVlBpdUx0N0xTN1E3YmVncGFneTBoQUZoYm13?=
 =?utf-8?B?NHowU0JuWUJGeXZzWEtFRmhRNnBaK1docFlFdlR5YW9weWZnVHpKaXpRU0N3?=
 =?utf-8?B?Vm93TCtDYXJTZkJDa0xNVWt3S0VzV3VNS2JsVnVqL0t3NGVKbFA5bWZKUThl?=
 =?utf-8?B?R0E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7973.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a3544c4-608c-457d-3512-08dd9a224e92
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 17:50:29.3993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1zkt5n7xtGL4JE01UOyZa3Ru75O/6cIajqp1MU7eHpILPSX1uQv/12DS0ww83tklXYWkA3LmTXoDO1QYde5a9at4Nh7faAod3PKY+a5tLlneciaQ6YdzOitG9dorxk9o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8792

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUBy
ZWRoYXQuY29tPiANCj4gU2VudDogVHVlc2RheSwgTWF5IDIwLCAyMDI1IDEyOjA0IFBNDQo+IFRv
OiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT47IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJu
ZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6b24uY29tOyBicGZAdmdlci5r
ZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZlLnRhaHRAZ21haWwuY29tOyBq
aHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIu
b3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRh
dmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGFuZHJldytuZXRkZXZAbHVubi5jaDsg
ZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFp
bC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7
IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChO
b2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGUgPGcu
d2hpdGVAY2FibGVsYWJzLmNvbT47IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBt
aXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRm
QGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsIDx2aWRoaV9n
b2VsQGFwcGxlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NyBuZXQtbmV4dCAxNC8xNV0g
dGNwOiBhY2NlY246IHRyeSB0byBmaXQgQWNjRUNOIG9wdGlvbiB3aXRoIFNBQ0sNCj4gDQo+IA0K
PiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJl
ZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBV
Ukwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gDQo+IA0KPiANCj4g
T24gNS8xNC8yNSAzOjU2IFBNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20gd3Jv
dGU6DQo+ID4gRnJvbTogSWxwbyBKw6RydmluZW4gPGlqQGtlcm5lbC5vcmc+DQo+ID4NCj4gPiBB
cyBTQUNLIGJsb2NrcyB0ZW5kIHRvIGVhdCBhbGwgb3B0aW9uIHNwYWNlIHdoZW4gdGhlcmUgYXJl
IG1hbnkgaG9sZXMsIA0KPiA+IGl0IGlzIHVzZWZ1bCB0byBjb21wcm9taXNlIG9uIHNlbmRpbmcg
bWFueSBTQUNLIGJsb2NrcyBpbiBldmVyeSBBQ0sgDQo+ID4gYW5kIHRyeSB0byBmaXQgQWNjRUNO
IG9wdGlvbiB0aGVyZSBieSByZWR1Y3Rpb24gdGhlIG51bWJlciBvZiBTQUNLIA0KPiA+IGJsb2Nr
cy4gQnV0IG5ldmVyIGdvIGJlbG93IHR3byBTQUNLIGJsb2NrcyBiZWNhdXNlIG9mIEFjY0VDTiBv
cHRpb24uDQo+ID4NCj4gPiBBcyBBY2NFQ04gb3B0aW9uIGlzIG9mdGVuIG5vdCBwdXQgdG8gZXZl
cnkgQUNLLCB0aGUgc3BhY2UgaGlqYWNrIGlzIA0KPiA+IHVzdWFsbHkgb25seSB0ZW1wb3Jhcnku
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20+DQo+ID4gLS0tDQo+ID4gIG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8IDE1ICsr
KysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY0L3RjcF9vdXRwdXQuYyBi
L25ldC9pcHY0L3RjcF9vdXRwdXQuYyBpbmRleCANCj4gPiBiNjMwOTIzYzRjZWYuLmQ5ZDNjYzhk
YmI1YiAxMDA2NDQNCj4gPiAtLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiArKysgYi9u
ZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4gPiBAQCAtOTgyLDggKzk4MiwyMSBAQCBzdGF0aWMgaW50
IHRjcF9vcHRpb25zX2ZpdF9hY2NlY24oc3RydWN0IHRjcF9vdXRfb3B0aW9ucyAqb3B0cywgaW50
IHJlcXVpcmVkLA0KPiA+ICAgICAgICAgICAgICAgb3B0cy0+bnVtX2FjY2Vjbl9maWVsZHMtLTsN
Cj4gPiAgICAgICAgICAgICAgIHNpemUgLT0gVENQT0xFTl9BQ0NFQ05fUEVSRklFTEQ7DQo+ID4g
ICAgICAgfQ0KPiA+IC0gICAgIGlmIChvcHRzLT5udW1fYWNjZWNuX2ZpZWxkcyA8IHJlcXVpcmVk
KQ0KPiA+ICsgICAgIGlmIChvcHRzLT5udW1fYWNjZWNuX2ZpZWxkcyA8IHJlcXVpcmVkKSB7DQo+
ID4gKyAgICAgICAgICAgICBpZiAob3B0cy0+bnVtX3NhY2tfYmxvY2tzID4gMikgew0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAvKiBUcnkgdG8gZml0IHRoZSBvcHRpb24gYnkgcmVtb3Zpbmcg
b25lIFNBQ0sgYmxvY2sgKi8NCj4gPiArICAgICAgICAgICAgICAgICAgICAgb3B0cy0+bnVtX3Nh
Y2tfYmxvY2tzLS07DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNpemUgPSB0Y3Bfb3B0aW9u
c19maXRfYWNjZWNuKG9wdHMsIHJlcXVpcmVkLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW1haW5pbmcgKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBUQ1BPTEVOX1NBQ0tfUEVS
QkxPQ0ssDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIA0KPiA+ICsgbWF4X2NvbWJpbmVfc2F2aW5nKTsNCj4gDQo+IEhvdyBkZWVwIGlzIHRo
ZSByZWN1cnNpb24gbGV2ZWwsIHdvcnN0IGNhc2U/IEluIGFueSBjYXNlIHBsZWFzZSB0cnkgdG8g
YXZvaWQgcmVjdXJzaW9uIGVudGlyZWx5LiBQb3NzaWJseSBhICdnb3RvJyBzdGF0ZW1lbnQgd291
bGQgaGVscC4NCj4gDQo+IC9QDQoNCkhpIFBhb2xvLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFj
aywgaW4gdGhpcyBjYXNlIHVwIHRvIDIgZXh0cmEgbGV2ZWxzIHdpbGwgYmUgbmVlZGVkLg0KQW5k
IHRoZSByZWN1cnNpb24gd2lsbCBiZSBhdm9pZGVkIGluIHRoZSBuZXh0IHZlcnNpb24uDQoNCkJS
cywNCkNoaWEtWXUNCg==

