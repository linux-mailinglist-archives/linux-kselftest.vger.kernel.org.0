Return-Path: <linux-kselftest+bounces-32388-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAB8AA9824
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818163B3AAE
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 15:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09430265CBD;
	Mon,  5 May 2025 15:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="LhaN9xYT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2059.outbound.protection.outlook.com [40.107.104.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DEF266594;
	Mon,  5 May 2025 15:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746460774; cv=fail; b=aEA5Ww8vtwqT5Kr9pYvkh4QJqBkq/U6z5WmdseLQoyYH1iILRy0kxTPphxnjJSOm1aHJYbA6wnNHSJY2sSsQCYULi0p4u7ikRlZ/dnkfWjVfVQsNnX+sPuiCzdmqd82Gn1zJrhuGMmizD0RuKi32ejOOIaFAL0ebwg56WCxHbs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746460774; c=relaxed/simple;
	bh=BxmX8LbVy+VNsv2qdQcPIgsQb9Ttuxoh2WyK4pqGMo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EPp/wYwkCFVcBrGmrnVz+HoJafZ6g292nSvmgthlSOvu2smP8kR3AzXsVV0ZUk1qiydfuMlU0AlLpnCaimk/er/AJ30hr24JfmYOVMXxOLMsi8seSwkSKiUBaAAsDEDseqG7ljN53LhSumHsU6haogRA3YQOnRU/K7PXjwGxKuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=LhaN9xYT; arc=fail smtp.client-ip=40.107.104.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLMmBmaqsk9Ap/2QWfVk1Fg49tQqr4VEG2QbYuUdcMyszAqHt05JQvTaeNColJSfHtt6Ztu9IvdKlHDIG8cwb9yuvF2vNyM7QbHQpy9XY+S1z7D5niPmLxb6Mn3Ch46FX5OroEKVaTnTjYnNH3KIQzw7FhvDlEEwBeqZIuuXKS054gWaGJrGvBJVGmY/g4aBOrOY5vzMC7QFrK59b/MvO3gAL7kQvWl+fUmpDGCuTnjxSWNqpreUxIQvM0fXmtaIN8JK6h6ftI7FsKkpuTAcYfGAUlBe3eNe15aD9h50hxy/0S+emTUmzon/AoxVW7nqr1u2jTfQR886GtiUZ9e8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxmX8LbVy+VNsv2qdQcPIgsQb9Ttuxoh2WyK4pqGMo8=;
 b=FXY2V3Pld9LmsGWVX0js9cqKHr2lptWLKoSUNC8OSFvRPWMRo2EesLOo9V9abfcbT4oo5OYC9w6dTmiB16U+YyhIn70Sa9JvS6QLDmuuqjwI1nMYF+0LnKKsD+cFH4BTuRwzGgl9j/RR3jjso5ktwtQJBAI8NLv8pnC+KZJkj0IRMoE3F7HibsfOVYYfsT6gYS64XK9E0gEf8ueIGijpPEidVxj1YofFGLnPul/6/I/WW4nnO9q6fRINFu9/yD2qlserTPsKamC7no7Mac5WBrXXDDrNHr+CyLFimd9tSHmfCB/PWs9/kbjFKMHnFL+YX0QzOqkG5wrLPhO+/h9OVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxmX8LbVy+VNsv2qdQcPIgsQb9Ttuxoh2WyK4pqGMo8=;
 b=LhaN9xYTdVv2bsVJ+EGhb8/PYJ3bEZsm7EfTqmywvWP8iHJ917Iz275POb94mb3znaesAzjGU5bvmvFchJQq8g7NkCXPHx9VL3soEuL8ASKgoGeqSO9RdJNegQMV3fwCifvwfGo+6PY49IUFhVYQkJAbHv/xCIHHv5wq9NId1JJbdow7+zm5uDErXFJG2sHvN5/g1sSg+cQWb2zwo5nOkuyrDhI/RjmeMJhbx+Mv4y6FeFdyjks2SEV9JPhebFvPxr+FjL1gXjmVc5+/cURy5gzsivt1nIpDOoQLCcpbRrFou3CsHPsHwWy6nqkEEGUYQfqjHJLt0yWHs+3w4upnZA==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB5PR07MB9454.eurprd07.prod.outlook.com (2603:10a6:10:48e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Mon, 5 May
 2025 15:59:29 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 15:59:29 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuniyu@amazon.com"
	<kuniyu@amazon.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com"
	<dave.taht@gmail.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "xiyou.wangcong@gmail.com"
	<xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net"
	<ast@fiberby.net>, "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>,
	"ncardwell@google.com" <ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
CC: "Olivier Tilmans (Nokia)" <olivier.tilmans@nokia.com>
Subject: RE: [PATCH v5 net-next 04/15] tcp: accecn: AccECN negotiation
Thread-Topic: [PATCH v5 net-next 04/15] tcp: accecn: AccECN negotiation
Thread-Index: AQHbs5yZP57BZpujLUuY48JEWb5ORbO6fe+AgAnEQ1A=
Date: Mon, 5 May 2025 15:59:29 +0000
Message-ID:
 <PAXPR07MB7984688FF29BFA328D0640B6A38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-5-chia-yu.chang@nokia-bell-labs.com>
 <4124e050-5614-424c-969c-9521ff02bee3@redhat.com>
In-Reply-To: <4124e050-5614-424c-969c-9521ff02bee3@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB5PR07MB9454:EE_
x-ms-office365-filtering-correlation-id: 93dd3f2f-a617-43b4-48c8-08dd8bedd148
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NkhaeFJVZlRDZVhmMGtQNTB0dUFmaldyUWpZVytTVStpbEVpTzkxbkQ2bHhL?=
 =?utf-8?B?d0FWNlNUMm5nQUUwZXZ4T0x2NXZQMVNoR2w1NEdIQllwSUVyR0RFbWRXWElz?=
 =?utf-8?B?RVBDeWFOOHdnZFpGaktZQVQ1VnBUaU40OTRZV1cvdzcwL1UxUUM4MWhzUHd5?=
 =?utf-8?B?REUwRWlyQWdsbGo0SUF0eUVTa2dtSkthUnF5ZThndXFQNlZjS0NHejNJQ1Bt?=
 =?utf-8?B?ZkV0T3FqcHA4a3RjNjVLSE5RNlh1Yk0vZ08xcFpXNmxhd2xsMjc5OVVvTXhN?=
 =?utf-8?B?QnU5NFhnRVNqYkd3b1VtUmNEVTcyNFExSHl1ZkdzNUZTY1E5cTlNSmk5bEMx?=
 =?utf-8?B?NDdNaXdPc2FBUHgvNGhFNU4vNmR0ZDVzRGZSY2ZHZ3lyR21qR1YxMG5SdHg0?=
 =?utf-8?B?TjhXSzJwVUhnVS9ieExJdkFXNG9QNVNuL3d5WVkxV2lyR2VvM3lTU0VNbVEx?=
 =?utf-8?B?YmlQdm0ydnBCZDcxOVhFYlZWWGFodW14cFhxL2gvYjJCa0c0Y01nd0ZBNEF5?=
 =?utf-8?B?ZEVGS2lPMEF5NHVjcXJXbVVyTUd1MGYyY2I0UU5KZzFVZHNyV1M1bDZBVTA1?=
 =?utf-8?B?eWNSZ2ozNit5enRNRkd0cTUrVEtlaHhFS2RzanlXV0FUU1EyMzUrRlNUdlBh?=
 =?utf-8?B?dmx0Wk5SWEluZi9RejZJWG9EL0JVOW1Kd1MzdkxIQmNhYTY0ajVvLzk4RDZn?=
 =?utf-8?B?QUc2NWtWbk5DSytLS0ZPbG5vOWVENWhZUHIwWjBIWm1CM2RnZzBBalNLaW1I?=
 =?utf-8?B?ZnZnanExeVBhWFhiVGYzWE8vS256MWRoMG8raFFBTXY5eFprUXBSbTNUZ2RX?=
 =?utf-8?B?V2RUYVY2dlk2N2RXWHVEcUJ5QWtURks5OWFnYVMvS1FWbkJ1L3BUTDFtUElw?=
 =?utf-8?B?NzlwUVBMRXVNdnR4LytnL0pNOEhrYldoS2FHZmJIeWhzOWxPdlorNytVR1g1?=
 =?utf-8?B?UnRVbGFJUVVSbXY5eW9OMWY2YjVlOUJVZnMyZDVhRS9hbWhsSlNwcFNQeWpl?=
 =?utf-8?B?RnIwR2krUnhNYVM3YjJSM2VKVDFCNS9GYkVNMnE3YkcxSHQ2RU5UblRMbE1E?=
 =?utf-8?B?cTB2R0JqQkpFRjdhbTlOMS9FQ0VxZDRwSTYxQ3FPRW42UHRVQ0taL3p2eTdV?=
 =?utf-8?B?NXZXSEtiZjBaYjloYW0xa3lLTjI4UkRpakp3WkIzejdVQkJ5MkljZEQyZmNT?=
 =?utf-8?B?N1ZOMUEvSGlJTy8rQXBickRRTDNERWovZEd0TUFNdk9SUmZLcmdRTGwwdUFT?=
 =?utf-8?B?Sit5NEgxOUVtSnRSeEVQQUtYVS8yc3RLa1U4czBMaXhMMFJBblVxVlVHSFpM?=
 =?utf-8?B?QkxZbHVybWlVMXVQTS9PTEFCbUdGdTZMMHhrckVBNjIrT0hDc0x4RTZSTTNh?=
 =?utf-8?B?QnA3azh2SWF2YjBkYU92REZyZkdmbWh4K3JuZjQwMHlvMkdNekYyN21mZ2VX?=
 =?utf-8?B?cHBXc2RuMHNSbUhRM3l6TUM0cXJYc3h2cUZkTkJ0TEFqMWpiZjQxcFJHWkpz?=
 =?utf-8?B?am8rSlpJQjlsY21DZ3d4bWhLbytNR0c4b3Q5em5xOCtTWjNJS2JDdDZ1clQr?=
 =?utf-8?B?SzNCZjJLVUxPZWhkTGNLWTlxSGVuRk90eksvcllmT29sQ3ZYOXdNQ1VQb0tu?=
 =?utf-8?B?RDFydXdyaEhadEtNTzlSUG4xMVBpQmZKYzRIRmFnbWN6eEErbXB1RUt5aUYr?=
 =?utf-8?B?SjcrNEMzakducTcxa2lEY1VkcWZ2ZUl6dnNVN1ZraEU3NnRyRXVyTTNNNXk0?=
 =?utf-8?B?Ly8rcDNNR1JnR2RYZ2k5ZENMcVRDMmNsUnRoNEFrc3hJSVk0VXN4NmdnMU1S?=
 =?utf-8?B?UWVrYUdOTkg0VVFQd2llRlFxLzZCT24zNEVvZFVqUHZkbmdKZVRiN3gwREUw?=
 =?utf-8?B?TGtyVmJrUUNRNkNPeGpDYWw0eDJMbjR0Q3ZRdVM1YnFCbHl3MmplZGtiWGJw?=
 =?utf-8?B?TlZoeENKNjFWdHhLejMyWVZnRjdEclVyY3p1bnliUGx2cFl4SHg1djZnN3Jp?=
 =?utf-8?B?TzM0VzZnaVVPK2R3ZmNUdjJUaGRPelBCRjdJZldyVmR6Vk9RS2dMYktzRElG?=
 =?utf-8?Q?kW1jmi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZytCOGdpcjN1eCtNWVJxSGtLQWtYcTN3V2tsaVJ0c0xzL1YzNVdwa05XbUk5?=
 =?utf-8?B?aVZHaFJuWk5tTlhsbXpGM1Aybk96UkhBc3hsbGlFcHg0cXhQK0owalRPUC85?=
 =?utf-8?B?bHRja2Zhb2FWYW9Qb3MzUFVRcjh5bkpxaHYzdlRPa3lNR1ZRRzRMQTJnM3p1?=
 =?utf-8?B?TVZQNnlQcGpFUm5EVFh2WktUTmVYVlBha0Nnb2xYUWNOL3psdFkyQVVoMUds?=
 =?utf-8?B?QXVVai9ZMlR3dGI2b1U2VzJVcExtTEFsdjlBWnE1VHF3YnU5NHFGRk9vLyth?=
 =?utf-8?B?Wkg4SFhkTUZuSUhyd29qUUFldWdnUHYydXAycnFTTkE3VlEycnp5Tkk2Q05C?=
 =?utf-8?B?VUpzVXB4QmxGejRZNVArTDhwdWI3UnJnSnMvNXh3SnI5RjhUTlFkWDA1UDRF?=
 =?utf-8?B?MEw0L2xiNElCOVRoK1ZRNy9wNFR0TDlycHIyMmVrMUVub2VFTEZaS0I0dDlV?=
 =?utf-8?B?OFZpaWNiRmlxRzNFMkFpWjFvU05jNS83bUFDMjRxVlB0c09HU01IMys3TGdo?=
 =?utf-8?B?SWcwWGJ2a1JCRFZySWoyZUFTa2pkOVhPOGI3RHBrUzd4T1VpekF2UmpKM2hZ?=
 =?utf-8?B?aFFPKzc0RU1GQnBoQmVxdVVLNGVQbGJOMmYxWEdlaG55TDVUT25jMDZOTjFB?=
 =?utf-8?B?aWJaTFBwLzE1K29NZHY4WWVNUkloT0hNYkQ5dU4xQkViTGVQb2Q5QmNmZVJV?=
 =?utf-8?B?VmpKQkJ0ekNiRE5vUDdvWnhxYVJ3Tkkwck5jbU9CSjlINzc2WU1Fbm5HcFZB?=
 =?utf-8?B?VTVuOEY0ZG5KeXNkRnJKMFY0OUtROVhuVjZVd092NnVrQitlUDVsOWhyTkEy?=
 =?utf-8?B?ajgxSDhIeGVSZGZkRlNLMk85MXVZTC92d1V4YWdYWk5ad0ZIdGJDNVlkM0ZL?=
 =?utf-8?B?bmIzRDE5Q09vcVViRVVKT0lzd2x5cnoyaXdnMGtaUWlCNWpaV2kxcDh5UFhS?=
 =?utf-8?B?czU3eDRoc1cvZjdkVE1aUHJGWGQ0b2ZReDZBYTFLd3dzQ2Y4YnNHNjJxY2tt?=
 =?utf-8?B?d0svWUIzSjY5a0xsTDZPaDBKdnY1blF5RUxtYkI4MjVUNXg4UGxUVzhyQkpE?=
 =?utf-8?B?emJnTkx2eEZJMjJBZVdXMDdqYnJlUnd3UEdxcWtIUE9TekRnY1J5elQwNDZ2?=
 =?utf-8?B?ZmR0U1hEa3FpckhtNzVYeGNCUnBLWmxMQm9yZHJuY2lRYXAxYUJKNGNBUVJk?=
 =?utf-8?B?V3J2TlhBMTdOVHZyVzd6ejdVREc4RXliY0tmUnRxdXEyQURWa0F4RXlyZVVZ?=
 =?utf-8?B?Y0FmaGR1dStLaVN1RTR1VTVPaFgwdk5PREZsbTc1aVdWUjZrUDdaZWlRdnMr?=
 =?utf-8?B?K3VJSCtoK25NVVVNQmJON2JwRXhGUHpiQjUzNVBSWG9EeS9lNWN6OEtHN1dn?=
 =?utf-8?B?Z2JEUWtORVhGaWlTdGY3UzhXRWJxd2s1aExySllabWRQKzNKMXpnaVBpRlNJ?=
 =?utf-8?B?b1hWVjlJcFg4NnhJYnBubWRTaUVmbDlZMnMzSS9LZEwydU1wSWw5a3IrNXh0?=
 =?utf-8?B?VjJHU3hUV25sbG5OcnBhNkRsZmRWMjhiM21jNGNQOXBZaWhtb3prZnYvdVNE?=
 =?utf-8?B?Tzk4WjJxbkFHek11OElERWdiV3lNM3kzYmRSbUcrbjh5bTFtSUROWWt4K25r?=
 =?utf-8?B?UzdOa0N0SXVyelJNWjlST0NVUlliWENZSktCdzNvaXgwaFZpQWVzZmhnS3Fr?=
 =?utf-8?B?S3F5NXcyZE94MkdPTUdIcDJkUFJnVzVTM2kwdzJNeEcwd3Y1c2h3WnBKRkIw?=
 =?utf-8?B?MTBrTWpsenlvckN1STRkZlgrdXFVUTRiOEhNSlJQZkYwZDhBWnFZVmRvdW1r?=
 =?utf-8?B?anpZVXJGaEE3ZnU1MXJlcFIyellMNWpjT3FQS082UlljNUhYTGdMZmdxeEUr?=
 =?utf-8?B?T2hhNTdWTEx4MzErR1BoYUVSL1Jqa0hQQUJxWkErRUxqZXlpaEJlQXlUUy9B?=
 =?utf-8?B?OVAzWGFsc2c2dUhQSjYyQUpJdzJ0LzFPZ2xycUNQSlRwMFVLNCtsekFXSitB?=
 =?utf-8?B?QUNDNWsrTGwvK3IycjlCK3VWTjlia1dnUUQwVDVVK3dFMjJadmExdXJWY091?=
 =?utf-8?B?ZStLS041bHZ4R0YrRy9zRE5mYW1wak5lWWUxT0F3bHRpTnR4TURXWnE1TVZO?=
 =?utf-8?B?dzlhSkR6cENXMXQzYUZROHhNQU9rSWdDTlFqSEtzNGN6QldWZFVQMFpxeDR0?=
 =?utf-8?B?YkE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93dd3f2f-a617-43b4-48c8-08dd8bedd148
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2025 15:59:29.0750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6hxOi7HoFCkVWGgD/BegHI1hgoJo5O4HcDlwSpcBAFN9UoJIZJ+WbMGTXiVSZXl9HAWWMC2k1cDRmFy2h8n7CFGIudVoGNxhJo39HCg2hZwQqZPtbe7VJ+1+HNA9vxR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9454

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBBcHJpbCAyOSwgMjAyNSAxMjozNyBQTQ0K
PiBUbzogQ2hpYS1ZdSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFi
cy5jb20+OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6
b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBkYXZl
LnRhaHRAZ21haWwuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBo
ZW5AbmV0d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVz
bnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGVkdW1hemV0QGdvb2dsZS5jb207IGFuZHJl
dytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5l
dDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNodWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVz
dEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5lbC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBL
b2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtvZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJz
LmNvbT47IGcud2hpdGUgPGcud2hpdGVAY2FibGVsYWJzLmNvbT47IGluZ2VtYXIucy5qb2hhbnNz
b25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVA
YXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2
aWRoaV9nb2VsIDx2aWRoaV9nb2VsQGFwcGxlLmNvbT4NCj4gQ2M6IE9saXZpZXIgVGlsbWFucyAo
Tm9raWEpIDxvbGl2aWVyLnRpbG1hbnNAbm9raWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHY1IG5ldC1uZXh0IDA0LzE1XSB0Y3A6IGFjY2VjbjogQWNjRUNOIG5lZ290aWF0aW9uDQo+IA0K
PiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkg
Y2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0
aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4g
DQo+IE9uIDQvMjIvMjUgNTozNSBQTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29t
IHdyb3RlOg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3RjcC5oIGIvaW5jbHVkZS9s
aW51eC90Y3AuaCBpbmRleCANCj4gPiBlMzYwMTgyMDNiZDAuLmFmMzhmZmYyNGFhNCAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3RjcC5oDQo+ID4gKysrIGIvaW5jbHVkZS9saW51eC90
Y3AuaA0KPiA+IEBAIC0xNTYsNiArMTU2LDEwIEBAIHN0cnVjdCB0Y3BfcmVxdWVzdF9zb2NrIHsg
ICNpZiANCj4gPiBJU19FTkFCTEVEKENPTkZJR19NUFRDUCkNCj4gPiAgICAgICBib29sICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGRyb3BfcmVxOw0KPiA+ICAjZW5kaWYNCj4gPiArICAgICB1
OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFjY2Vjbl9vayAgOiAxLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3luX2VjdF9zbnQ6IDIsDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzeW5fZWN0X3JjdjogMjsNCj4gPiAr
ICAgICB1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFjY2Vjbl9mYWlsX21vZGU6NDsN
Cj4gDQo+IEFGQUlDUyB0aGlzIHdpbGwgY3JlYXRlIGEgMyBieXRlcyBob2xlLiBUaGF0IGNvdWxk
IGJlIGJhZCBpZiBpdCB3aWxsIGFsc28gaW5jcmVhc2UgdGhlIG51bWJlciBvZiBjYWNoZWxpbmVz
IHVzZWQgYnkgc3RydWN0IHRjcF9yZXF1ZXN0X3NvY2suDQo+IFBsZWFzZSBpbmNsdWRlIHRoZSBw
YWhvbGUgaW5mbyBhbmQgc3RydWN0IHNpemUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KPiANCj4g
SWYgdGhlcmUgaXMgbm8gc2l6ZSBwcm9ibGVtIEkgZ3Vlc3MgeW91IGFyZSBiZXR0ZXIgb2ZmIHVz
aW5nIGEgJ2Jvb2wnDQo+IGZvciAnYWNjZWNuX29rJw0KDQpIaSBQYW9sbywNCg0KVGhhbmtzIGZv
ciB0aGUgZmVlZGJhY2sNCkkgd2lsbCBpbmNsdWRlIHRoZSBwYWhvbGUgaW4gdGhlIG1lc3NhZ2Ug
YW5kIHNlZSB3aGV0aGVyIEkgY2FuIG1vdmUgdG8gcmVkdWNlIHRoZSBzaXplIG9mIGhvbGVzLg0K
DQo+IA0KPiA+ICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHhoYXNoOw0K
PiA+ICAgICAgIHUzMiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmN2X2lzbjsNCj4gPiAg
ICAgICB1MzIgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNudF9pc247DQo+ID4gQEAgLTM3
Niw3ICszODAsMTAgQEAgc3RydWN0IHRjcF9zb2NrIHsNCj4gPiAgICAgICB1OCAgICAgIGNvbXBy
ZXNzZWRfYWNrOw0KPiA+ICAgICAgIHU4ICAgICAgZHVwX2Fja19jb3VudGVyOjIsDQo+ID4gICAg
ICAgICAgICAgICB0bHBfcmV0cmFuczoxLCAgLyogVExQIGlzIGEgcmV0cmFuc21pc3Npb24gKi8N
Cj4gPiAtICAgICAgICAgICAgIHVudXNlZDo1Ow0KPiA+ICsgICAgICAgICAgICAgc3luX2VjdF9z
bnQ6MiwgIC8qIEFjY0VDTiBFQ1QgbWVtb3J5LCBvbmx5ICovDQo+ID4gKyAgICAgICAgICAgICBz
eW5fZWN0X3JjdjoyLCAgLyogLi4uIG5lZWRlZCBkdXJpZ24gM1dIUyArIGZpcnN0IHNlcW5vICov
DQo+ID4gKyAgICAgICAgICAgICB3YWl0X3RoaXJkX2FjazoxOyAvKiBXYWl0IDNyZCBBQ0sgaW4g
c2ltdWx0YW5lb3VzIG9wZW4gDQo+ID4gKyAqLw0KPiANCj4gQSBnb29kIGJ1bmNoIG9mIGNvbmRp
dGlvbmFscyB3aWxsIGJlIGFkZGVkIHRvIHRoZSBmYXN0IHBhdGggY2hlY2tpbmcgdGhpcyBmbGFn
LiBJcyBzaW11bHQgb3BlbiByZWFsbHkgYSB0aGluZyBmb3IgQWNjRUNOPyBDYW4gd2Ugc2ltcGxl
IGRpc2FibGUgQWNjRUNOIGluIHN1Y2ggc2NlbmFyaW9zIGFuZCBzaW1wbGlmeSB0aGUgY29kZSBh
IGJpdD8gSW4gbXkgbGltaXRlZCBleHBlcmllbmNlIG9ubHkgc3l6a2FsbGVyIHJlbGlhYmx5IHVz
ZSBpdC4NCg0KVGhlcmUgYXJlIGZldyBzaW11bGF0ZW5lb3VzIG9wZW4gdGVzdGNhc2UgZm9yIEFj
Y0VDTiBpbiBwYWNrdGV0ZHJpbGw6IGh0dHBzOi8vZ2l0aHViLmNvbS9taW51c2NhdC9wYWNrZXRk
cmlsbF9hY2NlY24vdHJlZS9tYWluL2d0ZXN0cy9uZXQvdGNwL2FjY2Vjbi9zaW11bHRhbmVvdXNf
b3Blbg0KDQo+IA0KPiA+ICsgICAgIHU4ICAgICAgYWNjZWNuX2ZhaWxfbW9kZTo0OyAgICAgLyog
QWNjRUNOIGZhaWx1cmUgaGFuZGxpbmcgKi8NCj4gDQo+IFRoaXMgaXMgb3V0c2lkZSB0aGUgZmFz
dHBhdGggYXJlYSwgc28gcG9zc2libHkgdGhlIHN0cnVjdCBzaXplIGluY3JlYXNlIGlzIGxlc3Mg
Y3JpdGljYWwsIGJ1dCBBRkFJQ1MgdGhpcyB3aWxsIGNyZWF0ZSBhIDZiaXRzIGhvbGUgKGFzIHRo
ZSBuZXh0DQo+IHU4IGhhcyBvbmx5IDZiaXQgdXNlZCkuIEkgdGhpbmsgaXQncyBiZXR0ZXIgdG8g
cmVhZCB0aGUgJ3VudXNlZCcgZmllbGQgdG8gbWFyayBzdWNoIGhvbGUuDQoNClN1cmUsIHdpbGwg
dGFrZSBhY3Rpb24gaW4gdGhlIG5leHQgdmVyc2lvbiwgZWl0aGVyIHByb3ZpZGUgcGFob2xlIGlu
IGNvbW1pdCBtZXNzYWdlIG9yIHJlYWQgdGhlIHVuc3VlZCBmaWVsZCB0byBtYWtlIHN1Y2ggaG9s
ZS4NCg0KPiA+ICAgICAgIHU4ICAgICAgdGhpbl9sdG8gICAgOiAxLC8qIFVzZSBsaW5lYXIgdGlt
ZW91dHMgZm9yIHRoaW4gc3RyZWFtcyAqLw0KPiA+ICAgICAgICAgICAgICAgZmFzdG9wZW5fY29u
bmVjdDoxLCAvKiBGQVNUT1BFTl9DT05ORUNUIHNvY2tvcHQgKi8NCj4gPiAgICAgICAgICAgICAg
IGZhc3RvcGVuX25vX2Nvb2tpZToxLCAvKiBBbGxvdyBzZW5kL3JlY3YgU1lOK2RhdGEgDQo+ID4g
d2l0aG91dCBhIGNvb2tpZSAqLw0KPiANCj4gWy4uLl0NCj4gPiArLyogU2VlIFRhYmxlIDIgb2Yg
dGhlIEFjY0VDTiBkcmFmdCAqLyBzdGF0aWMgdm9pZCANCj4gPiArdGNwX2Vjbl9yY3Zfc3luYWNr
KHN0cnVjdCBzb2NrICpzaywgY29uc3Qgc3RydWN0IHRjcGhkciAqdGgsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1OCBpcF9kc2ZpZWxkKSB7DQo+ID4gKyAgICAgc3RydWN0IHRj
cF9zb2NrICp0cCA9IHRjcF9zayhzayk7DQo+ID4gKyAgICAgdTggYWNlID0gdGNwX2FjY2Vjbl9h
Y2UodGgpOw0KPiA+ICsNCj4gPiArICAgICBzd2l0Y2ggKGFjZSkgew0KPiA+ICsgICAgIGNhc2Ug
MHgwOg0KPiA+ICsgICAgIGNhc2UgMHg3Og0KPiA+ICAgICAgICAgICAgICAgdGNwX2Vjbl9tb2Rl
X3NldCh0cCwgVENQX0VDTl9ESVNBQkxFRCk7DQo+ID4gKyAgICAgICAgICAgICBicmVhazsNCj4g
PiArICAgICBjYXNlIDB4MToNCj4gPiArICAgICBjYXNlIDB4NToNCj4gDQo+IFBvc3NpYmx5IHNv
bWUgaHVtYW4gcmVhZGFibGUgZGVmaW5lcyBjb3VsZCBoZWxwIGluc3RlYWQgb2YgbWFnaWMgbnVt
YmVycyBoZXJlLg0KDQpTdXJlLCBJIHdpbGwgYWRkIGNvbW1lbnRzIGhlcmUuDQoNCj4gDQo+IFsu
Li5dDQo+ID4gQEAgLTYxNzEsMTYgKzYyNTIsMjcgQEAgc3RhdGljIGJvb2wgdGNwX3ZhbGlkYXRl
X2luY29taW5nKHN0cnVjdCBzb2NrICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCj4gPiAgICAg
ICAgKiBSRkMgNTk2MSA0LjIgOiBTZW5kIGEgY2hhbGxlbmdlIGFjaw0KPiA+ICAgICAgICAqLw0K
PiA+ICAgICAgIGlmICh0aC0+c3luKSB7DQo+ID4gKyAgICAgICAgICAgICBpZiAodGNwX2Vjbl9t
b2RlX2FjY2Vjbih0cCkpDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHNlbmRfYWNjZWNuX3Jl
ZmxlY3RvciA9IHRydWU7DQo+ID4gICAgICAgICAgICAgICBpZiAoc2stPnNrX3N0YXRlID09IFRD
UF9TWU5fUkVDViAmJiBzay0+c2tfc29ja2V0ICYmIHRoLT5hY2sgJiYNCj4gPiAgICAgICAgICAg
ICAgICAgICBUQ1BfU0tCX0NCKHNrYiktPnNlcSArIDEgPT0gVENQX1NLQl9DQihza2IpLT5lbmRf
c2VxICYmDQo+ID4gICAgICAgICAgICAgICAgICAgVENQX1NLQl9DQihza2IpLT5zZXEgKyAxID09
IHRwLT5yY3Zfbnh0ICYmDQo+ID4gLSAgICAgICAgICAgICAgICAgVENQX1NLQl9DQihza2IpLT5h
Y2tfc2VxID09IHRwLT5zbmRfbnh0KQ0KPiA+ICsgICAgICAgICAgICAgICAgIFRDUF9TS0JfQ0Io
c2tiKS0+YWNrX3NlcSA9PSB0cC0+c25kX254dCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBpZiAoIXRjcF9lY25fZGlzYWJsZWQodHApKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdTggZWN0ID0gdHAtPnN5bl9lY3RfcmN2Ow0KPiA+ICsNCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB0cC0+d2FpdF90aGlyZF9hY2sgPSB0cnVlOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF9fdGNwX3NlbmRfYWNrKHNrLCB0cC0+cmN2X254dCwN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAhc2VuZF9h
Y2NlY25fcmVmbGVjdG9yID8gMCA6DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgDQo+ID4gKyB0Y3BfYWNjZWNuX3JlZmxlY3Rvcl9mbGFncyhlY3QpKTsN
Cj4gDQo+IFRoZSBzYW1lIGV4cHJlc3Npb24gaXMgdXNlZCBhYm92ZSBwb3NzaWJseSB5b3UgY2Fu
IGNyZWF0ZSBhIG5ldyBoZWxwZXIgZm9yIHRoaXMgc3RhdGVtZW50Lg0KDQpPSywgd2lsbCBkbyB0
aGF0Lg0KDQo+IA0KPiAuLi4NCj4gDQo+IFRoaXMgcGF0Y2ggaXMgcXVpdGUgaHVnZS4gQW55IGhv
cGUgdG8gYnJlYWsgaWQgZG93biB0byBhIG1vcmUgcGFsYXRhYmxlIHNpemU/IGkuZS4gbW92aW5n
IHRoZSAzcmQgYWNrL3NlbGYgY29ubmVjdCBoYW5kbGluZyB0byBhIHNlcGFyYXRlIHBhdGNoIChp
ZiB0aGF0IHRoaW5nIGlzIHJlYWxseSBuZWVkZWQpLg0KDQpJIGFtIG9rIHRvIG1ha2UgYSBwcmFj
dGNlIG9uIHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgcGF0Y2ggaW4gdGhpcyBzZXJpZXMsIGJ1dCB0
aGlzIHNlcmllcyBzaGFsbCBiZSB0aGUga2V5IGZvciBBY2NFQ046IEFDRSBiaXRmaWVsZCwgVENQ
IG9wdGlvbiwgZmFsbGJhY2ssIGVycm9yIGhhbmRsaW5nLCBldGMuDQpPciBpZiB5b3UgaGF2ZSBh
bnkgc3VnZ2VzdGlvbnMsIEkgYW0gZmluZCB0byB0YWtlIGFjdGlvbnMuDQpBbmQgYWZ0ZXIgdGhp
cyBzZXJpZXMsIHdlIHN0aWxsIGhhdmUgMTUgcGF0Y2hlcyBpbmNsdWRpbmcgc2V2ZXJhbCBjb3Ju
ZXIgY2FzZSBoYW5kbGluZyBpbiBSRkMsIGRvdWNtZW50YXRpb24sIGV0Yy4NCg0KQ2hpYS1ZdQ0K
DQo+IA0KPiAvUA0KDQo=

