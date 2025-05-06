Return-Path: <linux-kselftest+bounces-32491-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E57B3AABDD1
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 10:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C73B87A6C4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 08:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC1D24A04F;
	Tue,  6 May 2025 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="YNblkEdF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85F53595A;
	Tue,  6 May 2025 08:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521602; cv=fail; b=u0CzlKVrogGBIRok4bVz6NiChNyi+lXQYzcrynAuLaMJbsl8icqoE5TdlYnADsHIj2fLm106rfP6eFWP6Nf3KdCiSRLr4ghT9ATFOmHJWfK0IqwFUHnYVf2j6zPdf/jrAGiWhmyYKFiyXpTAJBj01ZNU5cf91XH9C708OKQZSs0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521602; c=relaxed/simple;
	bh=UaQ7/fuBs84K6H3p3eYGw79OvKm1TeReIwtb+49ibJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ld9vCIi7w7sDyDYPj4njDcUo6Hz3TpKR/36c/hJEluIJdzhcVgowToipWp5QwRK14vtr3HtLmo4LfCNWe+eaFSzrxmJXqXu8xWuuGnO0y2xlLHJkchloTXdqIDF/nmbKumurWMWIOtqwNOeE7ZjaKP14Xj9q+uP3ZdokjMyJ+ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=YNblkEdF; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S/OnC0PrFkFi+rSakwD7b0u5Dc9oWeqgZAcNf2r//p6634NkoIH23OBNv+hiXULxncFjsFtS9dia23kFP6Btiq4BVlLTuO11ZMfO6SpVT/FhGi7g0gGIUZfEUeVYPJMyenNdPKD0WHSRhD9l3yNQ9lF+vF9e1aiN5nw2GsFcFDqMhyH8bSpqQUYer0OOCu3Wfy4JhFwDvFtHE4Tp1DpQFcrolHCZBNDx3yZ0Tu6qsWMLA6GiSpds/pQbw1OG0Ox+WXPTgo3196OcUG1LXyDYuZxVEnDeHK1fpo35VZAz/AzgYReVb1JWz+g1pthg5FuQkP7H1LOniKRB1rBo/OoU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaQ7/fuBs84K6H3p3eYGw79OvKm1TeReIwtb+49ibJE=;
 b=uEc0oyK5PRGmWKskIP33vBc1SacavuVk9rXVsN093wvauHXFnQ9mOdE4D3G5DCkoJhcIoHWHcgAlHvUvzlfDphFVQ1AyFwos5VfS0JfokfgJ2G3U3ywa8wg0P2H3ty9ygt3Fd91PDj9JrA0Rar4PCVgpvZ9EfpWg7XhSrCA/X0hxoPjWMcaWQ2WxHRmiP7/dEVQR3RrW3rT+40iJx/w69AG7sj5tQ8kJOfowCkeIkjLClpPwFRDM1Y9lSSnKippH0tHEfefRyzHGSGzASQ+PBInPmCUoPZ5hGlb3IlpDSlK5ZQG5uXtoQ0DZUzjYAMwFQ52a6H4lFSy4S+2xKPozBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaQ7/fuBs84K6H3p3eYGw79OvKm1TeReIwtb+49ibJE=;
 b=YNblkEdFiK9m3oKzzzh4dKJpv6deKAqfh/QBCPcz86afYYMosgpzDEUp3T2Z7b1AqLAk+XaRmw7JJtiv75PyKhD/Vmva8KJy8rts4a/hOJQCe68X8vpmV0l+7zBQEg/yAA0AOLcO82O6zwYIWUIlkiPGPZTfVjx1eMaYF1lSUVLasnaiGZLQ269IhiIdLAduticzwa1OyWoJIqyAdmSkew8EXbmL+9Ty5FyOSERCFG9xGAzS7qT9ejd9GnWQO7w199XBpfA91P6UmeQ5QiikC8BGXEpEkUpl/YkrNp0wpSaop75OClJAH+lXRf72Qi5lI6mgYEVpJxcVZiAKIgYFqw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by AS2PR07MB9492.eurprd07.prod.outlook.com (2603:10a6:20b:644::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:53:16 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.8699.022; Tue, 6 May 2025
 08:53:16 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ij@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
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
	<linux-kselftest@vger.kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send control
Thread-Topic: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send
 control
Thread-Index: AQHbs5yhYBNq0obf+kSooJOXCggc+7O6mBIAgAoPfkCAABuGgIAAmB6Q
Date: Tue, 6 May 2025 08:53:16 +0000
Message-ID:
 <PAXPR07MB7984AF8DDBDD9B646C899E07A3892@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com>
 <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com>
 <0a5c7897-ed95-4198-9896-ddae64335083@redhat.com>
  <PAXPR07MB79845AAB1468B67FE9BD2EDCA38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <9d741b0d-fff8-5565-f6e7-491a1d0928f7@kernel.org>
In-Reply-To: <9d741b0d-fff8-5565-f6e7-491a1d0928f7@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|AS2PR07MB9492:EE_
x-ms-office365-filtering-correlation-id: 968690d1-e612-4854-9d7d-08dd8c7b7124
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|13003099007|38070700018|7053199007;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGZtaGluVUtyWDU5MkZMaTFYeVhXdG1OMlRVRGdwZnlUd0pVcVlueTB2Sk5h?=
 =?utf-8?B?QWpQSTVBTytNNTdXMnB0eURuTGNLSEtWVDFZVGNuc0paOU5LV2xoR09KTC9Q?=
 =?utf-8?B?SDN2QXBwVzh2cFBibWFPcTBObkFkTnErZmc2RnNrRE1GNHZSKy9Tb1YyaUNS?=
 =?utf-8?B?SjBrRFVDNUdKd1BGNG9sNXBnU2dhVjhxVGc3eFFEbnVwU214L2dJVUJ6aU5u?=
 =?utf-8?B?SW1GelRSaWdiYTlNYjd6ekxYNHhkWTZvTkR6QmtMUlJpbXdkMjdMUjMxTXYr?=
 =?utf-8?B?Ly9Dc2pWOEdEeDl1am9vb1ZlU3Z1M3d2Qy9BbndqdHRhMDdBWDdZL1dKV1Zq?=
 =?utf-8?B?K0lnc1dodEt5dURzQzJPaXBxVzQ1YmFhVXV3WUM2L05kWUpoYnEybUpvMGNx?=
 =?utf-8?B?VGZraDB3NGFBSlFpeWNmRnBHUEZBTGNaN0tLZlBVWERHUi9iMmJsYTg0L1Na?=
 =?utf-8?B?ODBXWUkxQTQ1dXJtQWgyYUhIN2QwbS9ZWXo3RWU1NTJwaGZUT2hOL0NXMjJw?=
 =?utf-8?B?SWNFK3V6V0NsaUI1ZlpJQmlRWEh6eXVvOGhYWGdWdzJIbkVNWEtwWUVFVXFB?=
 =?utf-8?B?ck1OSlUzN0tPWlJCTno1eURuSXBkODVSOFRWaUpZYlRCQUZFSmcrR2JCeXdo?=
 =?utf-8?B?QzJYWEs5Q040T3E3Z0hEUUdhelIrQkJzWS9PL1crTE9ZUnozWEs0emxzU3Br?=
 =?utf-8?B?bkV0dnRFNDJOSUNLQ1E2cWh4dnphYjd6OXV2aVYrTFphd0NBL0JOMGNaTzJZ?=
 =?utf-8?B?azVsS3lPMTJUWE4rY3djUE4wTERlTXRRanhjRnl5RlhGc0tlbzlBTFYxWXZE?=
 =?utf-8?B?cFVZT3lqUXdYYzJhREpuTnYxNnZGYzRGYkxKTUxHU1ZRWmFuVDhZSHkvWDZ1?=
 =?utf-8?B?SUwzdS84K0FxVWJqMTZsSCt0SHFKS3dTNkYzcmk1QkdwaHZ4VGI3QUpkQ3hz?=
 =?utf-8?B?dnd3bUxveHZRSml5N0MxQUoyaWtUUUF2SDVxTkFiU08zeUJHbGVsYXhHWWtM?=
 =?utf-8?B?WXNPcFI5TGJZWktyclg4MlA4NnZ1MGRmdUVMMjAwUStzb1FjdjZxN0tRR1Nv?=
 =?utf-8?B?Nm02dGEvMGpYNXVjRHZrWlZqYkVQaTdCbStIZm9GbU8vdUhzTkhZQmN3UW5X?=
 =?utf-8?B?K2U1WW1xTlJaOFVRTXVoQ2FCWndrWWdGckpJeXVEUzAyTmk3QWcrUTFvY3Vn?=
 =?utf-8?B?MldxVmh2NnlHSXdQVTNzN1liSytZNzBCMWJqaTNXSTVaTDJFblU3YTRqMDgy?=
 =?utf-8?B?RnBHN0ZrUkcxanZQeTNmcDBKcDZ6UFpFYnBZSTN1U2lHQ0lvZFB0RWxCc3ov?=
 =?utf-8?B?Z2RzNlhVV2xlQ04zcTAxMnd5RjZxYzA4NW1saXhEbGhRSlVaaXprWFlXUTBW?=
 =?utf-8?B?anJVVmcxckh0YlF5Q3d5SENxTEZYOWNFbG4rZklXNW1DMllza3U5UG1GbXF0?=
 =?utf-8?B?eHE1dGt4b1VJckxyc1UyTzV3M0tpdUsxK3oyZ016aCtYdE9QSDV5SU5DOXFS?=
 =?utf-8?B?UjV1RTlJdVoyMlFVL3BLVUZNWDM0NENScUtZNUpWOUttemtqZGwzNWY1TW1Z?=
 =?utf-8?B?TXNFVitEWVpncGtUSElrS0xnSHRTK1kvTk5GcU1KZDdxRjVLVXA2aXlXbnFI?=
 =?utf-8?B?bnNpYkp6R1dzQngrZ1RwZGJtT3libWwvK001alNVUFpLUGFINWNQVVUwYUFW?=
 =?utf-8?B?V1djSmtJMlNmcDFYK2JhR0djUmxYeENEci80M1MvUndjWHJaZ3Y2TndzeHZI?=
 =?utf-8?B?K2t1Z1E2N1ptRDFZT1ZXWE5FYXBoVmxSVEVFZ0p6NHhsQml3TFZIR29jaXVS?=
 =?utf-8?B?Nm9RSkcyeVRLTnRKRUFjMk1DclNNUkxvM0NLUXB0SSs5SjJXMkoxeUJQaEpM?=
 =?utf-8?B?SGpweGJ1SWI2RmtyQ1ZuZGczelBDbnJJSUQxOHVRSU5nQnRqcGlOVU02aWVp?=
 =?utf-8?B?Y2xxdHY2ZmtvdlBIM2J3QXVzNXlEaWdVeXlMOW0wR3BSenBnNW41UkZzYUhG?=
 =?utf-8?Q?ouHjEO/9ohsYXy6pYKQ7yD5hEqDh9U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(13003099007)(38070700018)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDdadFR4OGZGbzdCTmxLM3BYMTgvZHhQQTVmdyt2blkwOTJyYUxOUEdQS3Rn?=
 =?utf-8?B?L0lxOU1mKzRpZmRLTW9IbXY4eEsySXRCTUwreXk0Z3hQajRlTEFzTnhDNU1h?=
 =?utf-8?B?b3A1MHN3VEdtTXYzcHZUVmxqeUxHZnVjRzJWQlQxbVNPUWYzcWNRbTVScGcr?=
 =?utf-8?B?dXdkRHM5U0xtcCtsUXRlMlByVE1kTjBtU2l1aGx1L3NYeVVSaFZ0MURrL1Rk?=
 =?utf-8?B?R1JPam8zVEZqdUZUS2RsTThYOFk0VnVsZHVjc21vUVB1TFo5WlNzcnhKRDA3?=
 =?utf-8?B?Tm84eFVPZjU4Tkp0OFVLQy9ydUpUQU1rVzJMYzFveEkvVkEyY3ZaalFNQjgz?=
 =?utf-8?B?L1dUc21CNFIvd0pJeVhZSUx1SCs4Q1VHdnVHZjVtNEVBK3kvam9CN3pqQzFt?=
 =?utf-8?B?T0RRalQrNTJEYTVBZzQvUDFkOGFQSzl3Tm9xcjZTOFp4Y3F4ek53TXNQcXBV?=
 =?utf-8?B?N2FUTmpLc01TcGVwdEJQVXoxK1J4T1lFeFRkZWxFVjZRWEM2SVZjUFR2Q3JL?=
 =?utf-8?B?a1J2eXJZNkZ5eGRjeXV5M2tmMVVnV2pDMGdnS05ydTZya0c4VjZtUlAyREth?=
 =?utf-8?B?aXNJWml4NVZ4MUJYSTc4M0VOWGU4TDJMN0RPcEJUUjdZeXZta0VZVEc4K3M5?=
 =?utf-8?B?RENVQlBjUlJpblNoallobFpQM0JtSTZEOWIxcGdYTlB0MkhQWWVZR1czQWlG?=
 =?utf-8?B?R2tGSXVMUjNSVzBpOE9hY2o5amVoZGcwZHU0NnFQU2crOCtKT2FRdmFlQXdk?=
 =?utf-8?B?WitVV2JGa0YrSTJKSlQ5c3gyRm5BRjg2RXhWbTRRLzNaT1ZuNnhmdlFPQ0k2?=
 =?utf-8?B?UFZmbGR3ZEJYLzhnTlplNEdlVTJ0ZURQT0dIemRpOU1KU0F4OVlVZFVCdFhr?=
 =?utf-8?B?Z0xoRlFGZms2VlRxWk1VakJSc1FHbnBmRkt2L1RhZWxvRkdaYSt6VnQ0S3ht?=
 =?utf-8?B?Nk5nd0NHUjFhc0k2OEFKa0pVajJ0Sk1NZWxxUEhKUGhML1p1MTdva3ZxSWNp?=
 =?utf-8?B?cnJIV1BYZUVEdDZtQTZMVkNIVkNtN1lLNDBqK3AyaHYrWXN4VzlhY0ZpMkRQ?=
 =?utf-8?B?N2JxMzlLZ1R6UXdMR3JtQ0xuQnQ4d1ZtRTdyclFSdm9VN0FWZWlWeWQ4VDJL?=
 =?utf-8?B?dys2cEJ6ejBKbkhpbldWVCt6Y3Q3Y054OEFrdnYrMkRNZ2tYMXJiMnp4TXZv?=
 =?utf-8?B?U0xEWUFocU9BekloeUpUblhleUZybWFhWTNrcEtLWkkzZlh1N25ndStudk5Z?=
 =?utf-8?B?SXhSSDYyQmFzYjJsb09hYW1FVkQ4eGtHd2t3Vko0YVpqVzdjOGdTTnU2WVcv?=
 =?utf-8?B?VCt3SGlkUkY3RXI5bDIrVHE5UUtWeE42UExPYjBOU0Q3WEh3NUw5amtwMkxF?=
 =?utf-8?B?NTVuNkRXOGVNbVhYU01EZkdiVDdtcnppTHZSeHJLOVlDWTRRcUJqbFB3RXVy?=
 =?utf-8?B?c0NaVnR2QnpYV1NnU3JTOGh1czdUVHk2M29WUVF0cFZBSGFaVjVYR2x3OXcw?=
 =?utf-8?B?SVF0b0VsSTc2TWdJN3VWM05ZWUk1Mm4rOC9tYk0zcTBqcnJ3ZmJHejFoeDZ2?=
 =?utf-8?B?UWNQTGxRbHkyRDhqNE4reWRPVXBhOWFOdW9aSkpnK1duczdVU1kyUnRvNGF2?=
 =?utf-8?B?ZGFsWWFvclJpR2xUa0o1a1JWMEwwRjlhTVo5MG9CbTVDWFdxczA2NVEya2gz?=
 =?utf-8?B?Wmp2Z3J2VE5rTTNocDFZYk5GTWF6QXQxeUh0RDhnNEF5SzBPQXEzbWk5L2lu?=
 =?utf-8?B?MlZSNUhTMERYTENwNkZpZWxTZGdDc1lBZkZOMmJoWnVtSm93dUpKVGRrM1Zj?=
 =?utf-8?B?RWZUclNqWFl2RDVUYTV1aTVOWFNXT1JVaEEyS2ZzSDQ0d1VqWHhUTm01VnhM?=
 =?utf-8?B?ckNQVnN6UEdjMGlBYzM3aFFidHNyVitCTlZ5RVNVU2F0YXM4R28rKzlDa1g4?=
 =?utf-8?B?M2IreGNOcGd4SWNVdGFCUHhab29TMUFvQ2NMZlVyWE8rV0VTK3YrRzNNTU9Y?=
 =?utf-8?B?WE9sb205YTFmRytYTW9GOW9EY2UwdnZxMDQydjhSb05XZFJmR2hXWUg1TmxR?=
 =?utf-8?B?ZFlBNytJbTl5UFQxaHV5M01zYmZ6L3hTUlp1YklxNUZ4K3hiZU5Pbm9EcHNp?=
 =?utf-8?B?SHM2Vi9QeEMwUHdWUW9NVzF0d0VyOS9SQ2RydS9uTllOZDNaNnZQeW5jUVBy?=
 =?utf-8?Q?xbjyeDg60HM65jslirdPpMI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 968690d1-e612-4854-9d7d-08dd8c7b7124
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2025 08:53:16.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KR0loJ2tRF6q/y2gaNmlfFpLKz3aFKoR3H1IdBJcQqODG/SQSt0QOIaSF1mL6v43RvDHG1MkXh7fRjYU4+PQJv+YRDYSlw3P7SEk64TYxCGWo9aCr5ZLnwjmOmGf0Ics
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR07MB9492

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWpA
a2VybmVsLm9yZz4gDQo+IFNlbnQ6IFR1ZXNkYXksIE1heSA2LCAyMDI1IDE6MjcgQU0NCj4gVG86
IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29t
Pg0KPiBDYzogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPjsgaG9ybXNAa2VybmVsLm9y
ZzsgZHNhaGVybkBrZXJuZWwub3JnOyBrdW5peXVAYW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVs
Lm9yZzsgbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1v
amF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsg
eGl5b3Uud2FuZ2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxv
ZnQubmV0OyBlZHVtYXpldEBnb29nbGUuY29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFs
ZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29t
OyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVw
cGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBnLndoaXRlIDxnLndoaXRlQGNhYmxlbGFicy5jb20+
OyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmlj
c3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmlu
Z29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1
YmplY3Q6IFJFOiBbUEFUQ0ggdjUgbmV0LW5leHQgMTAvMTVdIHRjcDogYWNjZWNuOiBBY2NFQ04g
b3B0aW9uIHNlbmQgY29udHJvbA0KPiANCj4gDQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJu
YWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBv
cGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFs
IGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBNb24sIDUgTWF5IDIwMjUsIENoaWEtWXUg
Q2hhbmcgKE5va2lhKSB3cm90ZToNCj4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+ID4gRnJvbTogUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPg0KPiA+ID4gU2Vu
dDogVHVlc2RheSwgQXByaWwgMjksIDIwMjUgMjoxMCBQTQ0KPiA+ID4gVG86IENoaWEtWXUgQ2hh
bmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPjsgDQo+ID4gPiBo
b3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IGt1bml5dUBhbWF6b24uY29tOyAN
Cj4gPiA+IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGRhdmUu
dGFodEBnbWFpbC5jb207IA0KPiA+ID4gamhzQG1vamF0YXR1LmNvbTsga3ViYUBrZXJuZWwub3Jn
OyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgDQo+ID4gPiB4aXlvdS53YW5nY29uZ0BnbWFp
bC5jb207IGppcmlAcmVzbnVsbGkudXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IA0KPiA+ID4gZWR1
bWF6ZXRAZ29vZ2xlLmNvbTsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdt
YWlsLmNvbTsgDQo+ID4gPiBhc3RAZmliZXJieS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBz
aHVhaEBrZXJuZWwub3JnOyANCj4gPiA+IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7
IGlqQGtlcm5lbC5vcmc7IA0KPiA+ID4gbmNhcmR3ZWxsQGdvb2dsZS5jb207IEtvZW4gRGUgU2No
ZXBwZXIgKE5va2lhKSANCj4gPiA+IDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5j
b20+OyBnLndoaXRlIA0KPiA+ID4gPGcud2hpdGVAY2FibGVsYWJzLmNvbT47IGluZ2VtYXIucy5q
b2hhbnNzb25AZXJpY3Nzb24uY29tOyANCj4gPiA+IG1pcmphLmt1ZWhsZXdpbmRAZXJpY3Nzb24u
Y29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmlldGZAZ214LmF0OyANCj4gPiA+IEphc29uX0xp
dmluZ29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IG5ldC1uZXh0IDEwLzE1XSB0Y3A6IGFjY2Vjbjog
QWNjRUNOIG9wdGlvbiANCj4gPiA+IHNlbmQgY29udHJvbA0KPiA+ID4NCj4gPiA+DQo+ID4gPiBD
QVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgYmUgdmVyeSBjYXJlZnVs
IHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gU2VlIHRoZSBVUkwg
bm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+IE9uIDQvMjIvMjUgNTozNSBQTSwgY2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxh
YnMuY29tIHdyb3RlOg0KPiA+ID4gPiBGcm9tOiBJbHBvIErDpHJ2aW5lbiA8aWpAa2VybmVsLm9y
Zz4NCj4gPiA+ID4NCj4gPiA+ID4gSW5zdGVhZCBvZiBzZW5kaW5nIHRoZSBvcHRpb24gaW4gZXZl
cnkgQUNLLCBsaW1pdCBzZW5kaW5nIHRvIHRob3NlIA0KPiA+ID4gPiBBQ0tzIHdoZXJlIHRoZSBv
cHRpb24gaXMgbmVjZXNzYXJ5Og0KPiA+ID4gPiAtIEhhbmRzaGFrZQ0KPiA+ID4gPiAtICJDaGFu
Z2UtdHJpZ2dlcmVkIEFDSyIgKyB0aGUgQUNLIGZvbGxvd2luZyBpdC4gVGhlDQo+ID4gPiA+ICAg
Mm5kIEFDSyBpcyBuZWNlc3NhcnkgdG8gdW5hbWJpZ3VvdXNseSBpbmRpY2F0ZSB3aGljaA0KPiA+
ID4gPiAgIG9mIHRoZSBFQ04gYnl0ZSBjb3VudGVycyBpbiBpbmNyZWFzaW5nLiBUaGUgZmlyc3QN
Cj4gPiA+ID4gICBBQ0sgaGFzIHR3byBjb3VudGVycyBpbmNyZWFzaW5nIGR1ZSB0byB0aGUgZWNu
ZmllbGQNCj4gPiA+ID4gICBlZGdlLg0KPiA+ID4gPiAtIEFDS3Mgd2l0aCBDRSB0byBhbGxvdyBD
RVAgZGVsdGEgdmFsaWRhdGlvbnMgdG8gdGFrZQ0KPiA+ID4gPiAgIGFkdmFudGFnZSBvZiB0aGUg
b3B0aW9uLg0KPiA+ID4gPiAtIEZvcmNlIG9wdGlvbiB0byBiZSBzZW50IGV2ZXJ5IGF0IGxlYXN0
IG9uY2UgcGVyIDJeMjINCj4gPiA+ID4gICBieXRlcy4gVGhlIGNoZWNrIGlzIGRvbmUgdXNpbmcg
dGhlIGJpdCBlZGdlcyBvZiB0aGUNCj4gPiA+ID4gICBieXRlIGNvdW50ZXJzIChhdm9pZHMgbmVl
ZCBmb3IgZXh0cmEgdmFyaWFibGVzKS4NCj4gPiA+ID4gLSBBY2NFQ04gb3B0aW9uIGJlYWNvbiB0
byBzZW5kIGEgZmV3IHRpbWVzIHBlciBSVFQgZXZlbiBpZg0KPiA+ID4gPiAgIG5vdGhpbmcgaW4g
dGhlIEVDTiBzdGF0ZSByZXF1aXJlcyB0aGF0LiBUaGUgZGVmYXVsdCBpcyAzDQo+ID4gPiA+ICAg
dGltZXMgcGVyIFJUVCwgYW5kIGl0cyBwZXJpb2QgY2FuIGJlIHNldCB2aWENCj4gPiA+ID4gICBz
eXNjdGxfdGNwX2Vjbl9vcHRpb25fYmVhY29uLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBJbHBvIErDpHJ2aW5lbiA8aWpAa2VybmVsLm9yZz4NCj4gPiA+ID4gQ28tZGV2ZWxvcGVk
LWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L3RjcC5o
ICAgICAgICB8ICAzICsrKw0KPiA+ID4gPiAgaW5jbHVkZS9uZXQvbmV0bnMvaXB2NC5oICAgfCAg
MSArDQo+ID4gPiA+ICBpbmNsdWRlL25ldC90Y3AuaCAgICAgICAgICB8ICAxICsNCj4gPiA+ID4g
IG5ldC9pcHY0L3N5c2N0bF9uZXRfaXB2NC5jIHwgIDkgKysrKysrKysNCj4gPiA+ID4gIG5ldC9p
cHY0L3RjcC5jICAgICAgICAgICAgIHwgIDUgKysrKy0NCj4gPiA+ID4gIG5ldC9pcHY0L3RjcF9p
bnB1dC5jICAgICAgIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gPiA+
ID4gIG5ldC9pcHY0L3RjcF9pcHY0LmMgICAgICAgIHwgIDEgKw0KPiA+ID4gPiAgbmV0L2lwdjQv
dGNwX21pbmlzb2Nrcy5jICAgfCAgMiArKw0KPiA+ID4gPiAgbmV0L2lwdjQvdGNwX291dHB1dC5j
ICAgICAgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPiA+ID4g
PiAgOSBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfaXB2NC5jIGIvbmV0L2lwdjQvdGNw
X2lwdjQuYyBpbmRleA0KPiA+ID4gPiAzZjNlMjg1ZmM5NzMuLjJlOTVkYWQ2NmZlMyAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lwdjQuYw0KPiA+ID4gPiArKysgYi9uZXQvaXB2
NC90Y3BfaXB2NC5jDQo+ID4gPiA+IEBAIC0zNDUxLDYgKzM0NTEsNyBAQCBzdGF0aWMgaW50IF9f
bmV0X2luaXQgdGNwX3NrX2luaXQoc3RydWN0IG5ldA0KPiA+ID4gPiAqbmV0KSAgew0KPiA+ID4g
PiAgICAgICBuZXQtPmlwdjQuc3lzY3RsX3RjcF9lY24gPSAyOw0KPiA+ID4gPiAgICAgICBuZXQt
PmlwdjQuc3lzY3RsX3RjcF9lY25fb3B0aW9uID0gMjsNCj4gPiA+ID4gKyAgICAgbmV0LT5pcHY0
LnN5c2N0bF90Y3BfZWNuX29wdGlvbl9iZWFjb24gPSAzOw0KPiA+ID4gPiAgICAgICBuZXQtPmlw
djQuc3lzY3RsX3RjcF9lY25fZmFsbGJhY2sgPSAxOw0KPiA+ID4NCj4gPiA+IEh1bWFuIHJlYWRh
YmxlIG1hY3JvcyBpbnN0ZWFkIG9mIG1hZ2ljIG51bWJlcnMgY291bGQgaGVscC4NCj4gPg0KPiA+
IE9LLCBjb21tbWVudHMgd2lsbCBiZSBhZGRlZCBoZXJlLg0KPiANCj4gSGksDQo+IA0KPiBVc2lu
ZyBuYW1lZCBkZWZpbmVzIHRvIHJlcGxhY2UgbGl0ZXJhbHMgd291bGQgYmUgbW9yZSB1c2VmdWwg
dGhhbiBjb21tZW50cyAobmFtZXMgY2FuIGJlIGdyZXBwZWQgZm9yLCBkbyBub3QgZmFsbCBvdXQt
b2Ytc3luYyB3aXRoIGNvZGUsIGV0Yy4pLg0KPiANCj4gPiA+ID4gQEAgLTEyMzcsMTMgKzEyNTMs
MTggQEAgc3RhdGljIHVuc2lnbmVkIGludCANCj4gPiA+ID4gdGNwX2VzdGFibGlzaGVkX29wdGlv
bnMoc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiDQo+ID4gPiA+DQo+ID4gPiA+
ICAgICAgIGlmICh0Y3BfZWNuX21vZGVfYWNjZWNuKHRwKSAmJg0KPiA+ID4gPiAgICAgICAgICAg
c29ja19uZXQoc2spLT5pcHY0LnN5c2N0bF90Y3BfZWNuX29wdGlvbikgew0KPiA+ID4gPiAtICAg
ICAgICAgICAgIGludCBzYXZpbmcgPSBvcHRzLT5udW1fc2Fja19ibG9ja3MgPiAwID8gMiA6IDA7
DQo+ID4gPiA+IC0gICAgICAgICAgICAgaW50IHJlbWFpbmluZyA9IE1BWF9UQ1BfT1BUSU9OX1NQ
QUNFIC0gc2l6ZTsNCj4gPiA+ID4gLQ0KPiA+ID4gPiAtICAgICAgICAgICAgIG9wdHMtPmVjbl9i
eXRlcyA9IHRwLT5yZWNlaXZlZF9lY25fYnl0ZXM7DQo+ID4gPiA+IC0gICAgICAgICAgICAgc2l6
ZSArPSB0Y3Bfb3B0aW9uc19maXRfYWNjZWNuKG9wdHMsIHRwLT5hY2NlY25fbWlubGVuLA0KPiA+
ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZW1haW5p
bmcsDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNhdmluZyk7DQo+ID4gPiA+ICsgICAgICAgICAgICAgaWYgKHNvY2tfbmV0KHNrKS0+aXB2NC5z
eXNjdGxfdGNwX2Vjbl9vcHRpb24gPj0gMiB8fA0KPiA+ID4gPiArICAgICAgICAgICAgICAgICB0
cC0+YWNjZWNuX29wdF9kZW1hbmQgfHwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgdGNwX2Fj
Y2Vjbl9vcHRpb25fYmVhY29uX2NoZWNrKHNrKSkgew0KPiA+ID4NCj4gPiA+IFdoeSBhIG5lc3Rl
ZCBpZiBoZXJlIGFuZCBqdXN0IG5vdCBleHBhbmRpbmcgdGhlIGV4aXN0aW5nIG9uZT8NCj4gPg0K
PiA+IFN1cmUsIHdpbGwgbWVyZ2UgdGhlbS4NCj4gDQo+IFdoaWxlIEkgZG9uJ3QgcmVtZW1iZXIg
ZXZlcnl0aGluZyB0aGF0IHdlbGwgYW55bW9yZSwgdGhpcyBtaWdodCBoYXZlIGJlZW4gdG8gcmVk
dWNlIGNvZGUgY2h1cm4gaW4gc29tZSBsYXRlciBwYXRjaCwgc28gaXQgbWlnaHQgYmUgd29ydGgg
dG8gY2hlY2sgaXQgZmlyc3QgKHRoYXQgcGF0Y2ggbWlnaHQgZXZlbiBmYWxsIG91dHNpZGUgb2Yg
dGhpcyBzZXJpZXMgbm93IHRoYXQgdGhlc2UgYXJlIHNwbGl0IGludG8gbXVsdGlwbGUgY2h1bmtz
KS4NCj4gDQo+IC0tDQo+ICBpLg0KDQoNCkhpIElscG8sDQoNClRoYW5rcyBmb3IgdGhpcyByYWlz
ZWQgcG9pbnQuDQpBbmQgSSd2ZSBjaGVja2VkIHRoYXQgdGhlIGNvbmRpdGlvbiBpcyBjaGFuZ2Vk
IGF0IHRoZSBsYXR0ZXIgcGF0Y2hlcyAoInRjcDogYWNjZWNuOiBBY2NFQ04gb3B0aW9uIGZhaWx1
cmUgaGFuZGxpbmciKSwgYnV0IHdpdGggdGhlIHNpbWlsYXIgbmVzdGVkIGlmLg0KU28sIEkgd291
bGQgdHJ5IHRvIG1lcmdlIGl0IGF0IHRoZSBuZXh0IHZlcnNpb24sIGFuZCB3aWxsIGNoZWNrIHBh
Y2tldGRyaWxsIGZvciBzdXJlLg0KDQpDaGlhLVl1DQo=

