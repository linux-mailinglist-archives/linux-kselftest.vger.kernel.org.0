Return-Path: <linux-kselftest+bounces-45963-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85175C6E043
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 11:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 296E84EAEAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25DB34B1A0;
	Wed, 19 Nov 2025 10:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="KIU2FZRc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013069.outbound.protection.outlook.com [40.107.162.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88971FECB0;
	Wed, 19 Nov 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548371; cv=fail; b=oXMSrTjyEuBHM7f22nVEnCnWQYWjAIf44G8DztKrr1CGT67jrvxj7VcVs4uYLsmcYAjPxgLGcPdOz+YGvpW1mftzpIZozAB9/Jm4dzNIioWxOjTVPlDasjwBFQyK4DsXCxzGsIgU11xM6VFbD40ZTcs3CjuIxUlFWuj/TpQWzSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548371; c=relaxed/simple;
	bh=HELud/ZfnXnovV988tCVFHeXAM+oNY5tudcymsNi2JE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yq1JyjJ4jPXgejMC/70KpuRWq4vKtKC9BRW9FCqAWPRTU6Cilwc1/Q7jOPf2vYlGUeFouRoqOVHUwcf3vzcPBy2KsMhO9rc8P1VojASymWEEAvDbOQ+NDC13Zg2xPvdJuExEND16l5nMER5/iJoj6cLaNSnOlge27m48UaWnY1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=KIU2FZRc; arc=fail smtp.client-ip=40.107.162.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jsxLonXwJwxSZNBHqkfbZQwdqpLTIn/CKZkrkKG51cC0pj72OzLkJOix10iDzq2bvE83jsPPJR0V7u/KyAv5vrqjyRXaG7UFFFn0R2FZPMBWAnnU3B6pQHIjla7zc1S1xaGv2GC9aR1lwMIVGO+fuqnhCVCu3RhoEhyp1D1tdIPJIedobPVVUGwmce0l5/i205OOwTwTr/J/+3mCQ0HgC/vdqTUE41IAgAz4qf0KOPm0+t5IiG1ZdAAVjV0mSliJToiMVecgSIjI1mLsfJGnu0aCW8CeMcxkNxdgEOvm8BEnOPLu5mR3uQG6UflxfrtJkm/Nmb4gggxMMp0tyMo1Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HELud/ZfnXnovV988tCVFHeXAM+oNY5tudcymsNi2JE=;
 b=AZ3f9GwbL7d6LHqbF0OlPFp8ahk/BVv8FAbfQD06kUFnEASjTdiNx/P7UREurLuoJRtxhfAQUc3r91e2YbAcoszYH9gsqVmMgR9nxox55RV6Oq8m1GhIUwaDYLLHIwf4Alj1ngVXy+G2tbp2yQKsFhF8GmJYK0FYy8iJD6mmb5NyUubuAcJEjvzS8AELS4ieohk/hq3bpSZ7YMU7w424Mvs5rf0wTnYcs/0VM6zrAoacnBQuV6ucYNdwwfKhQNhLyGZItgHK+1hyYH6hPG6si87X2q829HRyijs0PKUkcYBAcy4FseqGmjUWOKfPIy7QxArQS1p3SYl1VnTKxIABVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HELud/ZfnXnovV988tCVFHeXAM+oNY5tudcymsNi2JE=;
 b=KIU2FZRcQ5cqOIpmG9kCTZo0O0xBFemwJT/vLQfQL55KXHXYWMnXy3CA1vZU3y5x0Tta8UXk4MzILAB7Up9y2/G+wGGqgYRoFP3UQTGmcSy6xUICxaKVAgBm/HmQCdhiReEKRE1QX/GPSRWxFzqSKv2FvraemGzfZc9xQqB1qp0tGnvvhZQewWmTsWo3kN5DcQlP/XpygqAAbu5lsVNLB6PzoR3oPvgxIi4WmMjT/XkuN0h9DHEV+vSXXBfnO0mfwm0Q+d7F3fReo75BNXquj3dCR1qDcvRUlrCgE0glPF/fXpI4p1TcAr70QolM2JgQhq7nRmADQfqhGMtBxzSD3Q==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB9050.eurprd07.prod.outlook.com (2603:10a6:10:3da::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 10:32:43 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 10:32:43 +0000
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
Subject: RE: [PATCH v6 net-next 10/14] tcp: accecn: retransmit SYN/ACK without
 AccECN option or non-AccECN SYN/ACK
Thread-Topic: [PATCH v6 net-next 10/14] tcp: accecn: retransmit SYN/ACK
 without AccECN option or non-AccECN SYN/ACK
Thread-Index: AQHcVTZJT6OEOQ8vjESoTea5L/tTTbT4fIkAgAFWdhA=
Date: Wed, 19 Nov 2025 10:32:42 +0000
Message-ID:
 <PAXPR07MB798462C646FC75E9AB54E666A3D7A@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20251114071345.10769-1-chia-yu.chang@nokia-bell-labs.com>
 <20251114071345.10769-11-chia-yu.chang@nokia-bell-labs.com>
 <769c1ba6-b622-402e-a615-dffa6f3d640c@redhat.com>
In-Reply-To: <769c1ba6-b622-402e-a615-dffa6f3d640c@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB9050:EE_
x-ms-office365-filtering-correlation-id: 007ee02f-44b4-4c94-5e34-08de2756f8e4
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?Ymx4VkhxaURPU2FIeVdYdklMck9xWWZNMFpNd1JETHBJMjdLUVYxaCt0dDdR?=
 =?utf-8?B?Ri9hV0I2azRwaHVNL2xRVTVSdyt4aFVUTWNjb1JpbjNHR296azk0YzZNOG1C?=
 =?utf-8?B?VjRycnY4NWdJdWI0VHpqdVRDR0dmdWtOQTNLd3IzaWErN3dhYmhUbzhjNlNB?=
 =?utf-8?B?TjNYRWFaZllSWnp3RHFRZDR5TE5mVE1iRVNiZ25scGZadEtMMjlhcEsrSXNz?=
 =?utf-8?B?anlZTHhFYlBJMm56SWZ2SDhRSTFTQktWYkRTLzEvTkNybjJYaUdXMVIxczdh?=
 =?utf-8?B?dXdWeUdXS09hdExrb1dLdU1HcXhGNjNwVSsvRzczSEJWUks5OGhuN2NWcjEy?=
 =?utf-8?B?UDJTNVQrd2dVaWdrbWN2dTAyRHJIbUNBaEE4MVN1TDVqU1RHcVF6dm5OVXlr?=
 =?utf-8?B?YndCa1BUbThDZ3NBQ3ljTkpTZzJEU1lPeVhBREZQSWRNNmRyZXAwQ0xBZ2xY?=
 =?utf-8?B?MjVVWWUvUlRoR2ExYTFqOVF3K0U1VU9FbktHS2FyVnF1TlkrOFphb2g4d2FY?=
 =?utf-8?B?NnVjeGZhTEJJeFFVK2VGWGlpaDhtREdJYTd0TEl1MnhlTUFsT24wcnpRQnNj?=
 =?utf-8?B?eEs4Q0x2WUFlM2diV0JpNlczMld2TU5OcjdBY2h5OVpkT01CVWhrYW1YVWc2?=
 =?utf-8?B?ZWJoNXk5RUdmTGxxcmhsUG41RFZPUk5RK2lGN1c1aTJyd1Yzei82ZWxXbkdQ?=
 =?utf-8?B?LythZ05OcEpGd3VwcWtPY0RRRnNqOGtKc28zOVN5dlR5ZGZoT3IzVTZ1TFMr?=
 =?utf-8?B?anFjQ1hPelhqWldxYkxDL0RKTHNZT0E3cnhLQlVmSmIzS1ZZWmxCdjkrQjQ3?=
 =?utf-8?B?eHdNdGl4MjdWa2ZFUVZ5MUZCbzVReUd5d3ZuUUYrbWZKaTY5d2ZiRENxckx1?=
 =?utf-8?B?QmpycGZJSlVQRUEzT2czb1BGWTA3UTRqd0xFcjREdjBCY1hFeEFyVWpVYVBx?=
 =?utf-8?B?R29SSkpHRGRUeUVkVm5kaXB5ZUpHellMbCs0ZHNWdndUSUgrMjRnR1p6eHNX?=
 =?utf-8?B?Q256WUQvK1BkRHVPSzJhME1YdThudWlCZElEazY4NUVMUjZ0eUxjZ1lQWTY1?=
 =?utf-8?B?N25aVGRvaWhnQkpRdk1jWTY2NUcvcmN6RXUwQkhRQmlYU0t3NDJIWTVBd0ln?=
 =?utf-8?B?NU03VC84M3RSaXJzck1meVlMM2x5SnIveWo4OXF4b0VlWlcvTkVMRzNqYWZw?=
 =?utf-8?B?dXI5WG42UmpSM0hQVXVOMk1CdFZ6RkQ1K2dsRDhMU05mY3hUeEVFeHJuM2JN?=
 =?utf-8?B?OHpNTWhaRGdRdmpkUmJ5aVFNaVRhUUh3aDJ0aWNFeUttcVlzNVk0QzZESTlG?=
 =?utf-8?B?aHg2ZHFrZHhKbnlMR1JmdHFncEZFemMxSnhqdzVUM2RsK2dTMWE0SkRUZ1Ro?=
 =?utf-8?B?Q3NabHZFWFJuZ3l0TldGeG9ZTkpKVTlwaDRIRjBXNytubXYxaTZjYUpsamlt?=
 =?utf-8?B?aXAxV2F6L1g3SkhBb3N4cytpZUxaRFl2YW1sdHRwLzJhN1ZsMGJQbVBlUTQz?=
 =?utf-8?B?R2liTndwUEIyeXFhK2dienM4a01RekkvU0R5cEdqYWlqcUE5bTBVTkN1Ujl5?=
 =?utf-8?B?emMxUlFYVVZ3UUlzVWhxbWtja1FEOXhmbnR5RVl2ajZRVUZNV1hXWmsvUjE2?=
 =?utf-8?B?NEFBWHk0ZktiekNkQ0UzYSs0MnphZy9ZOFpKOHo1d0JRQ0RoQnh4Ym9KbWVj?=
 =?utf-8?B?Nitpek9IaWpQcVFUMENqalpJYU9XMldWdlBwZjFDWDJoV2FqZnhLczlubFVt?=
 =?utf-8?B?L1NqSUNxVEFMaVZERTRGSkpZaWNqUGxXTEF3MWJmWWwyZ1FLcFhNcDZiQldr?=
 =?utf-8?B?S1RqL1pwRU11SGh1a1lwK3IzOTVFTlgrdW5ycmlzZ1FjZFdLZ3dJd3A4N3Mv?=
 =?utf-8?B?ZUI3WWNmNHhZenJlZFJvbTMwYWJkWC9kT0JRbDBrQ1QzbktudlNNTWVIdmhz?=
 =?utf-8?B?UmNYV24rZFlDNk0yak1aZFlTUE9qR3MyZDNrdy80eE82d1IvUzJMMVZ1eVlo?=
 =?utf-8?B?YU8vMW9wUkxpeXZWT2RvTXJKZFNlOXN0SHByM2UvcWtESkVMeVQ3cExydkN2?=
 =?utf-8?B?U3NFYk5yWk5hSnZ3R1FTRTh0ZjhmVXErOHpZZz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDJJbEI4ekl1MUozTXUrMXArT0tock1NRlh6QTcyY3I5bGh0N2ppZ295VEpk?=
 =?utf-8?B?UUttSDJwS0dxUUhNOXg0ZWM2dW1lSytLdlBkV0JHOERIMWFEUnJua1U3OWl2?=
 =?utf-8?B?SktNeDJMTVh4WWhaR2F1MzZmMHVqSlYrWEtpZHdmWU9zRlB3MFdyTUc3VVlu?=
 =?utf-8?B?eUlSUnc1WlFBa0R6V1dBb1h2VW5UNTVteWRVZTk4a3hSSjNXWTNpL0N1NzFY?=
 =?utf-8?B?bjNWazBXRjhSUXBkTmNSdGh6TFlCcEwyZERpcXNJOVRjVTd1OHc4MExDak1O?=
 =?utf-8?B?UG1qRURmcDhBcTFUNzlBcnZDTFlhSldrZmdsdGYwUGRCWk9yOCtqTWlRaElE?=
 =?utf-8?B?Szh5azc5SUlIQ3U4OUsvTFhaZC9uVFBMSzFoVG54THI2aVFoTTR0L3I2RTVN?=
 =?utf-8?B?U3JlbDd1MEhiY01aeDhBWHNDRU1YL2xENjVnQ3ZGVGFZSUx1UEJXTXdyd24r?=
 =?utf-8?B?TzhET3d4eHVQN0RwT08vN3VhK0hoV1ZnaGxaTWJUd3NJb1FzU1hEb2l3d0NL?=
 =?utf-8?B?OVNYS1ZFYktyVm1aa2NRT3l4NXRYM0VvcEhXalJLbStKdkFJUWc0Z09hclJW?=
 =?utf-8?B?STJCenJLZkhoOFNqV2V4ZFphSmlRcVJwUmpUMWFxWUttTDRWU1hMQ1AwOG45?=
 =?utf-8?B?UGhYa0o0SXMrZjlKTUNMcTE3clVjTmxhdHl0VTJvQUM4ekd3MjI0eG5BM1NU?=
 =?utf-8?B?b3VDcEFZK1JmckdZdExhN3d1VlVOakxpci9HYVBKajRLL1RRZm1BV2cxM1l5?=
 =?utf-8?B?Q1JWL1FoRzhIalhMT05SREk0TTJqb2xBN1lBODkxT1dzQkM1endUaVJRdXZE?=
 =?utf-8?B?SkJNN2tQV0NHNEVodlZ5Z0tTM2c4R1FBMGZNUEFWM2F1ZUJpSnV1Smo1eEdn?=
 =?utf-8?B?R3ZxcGU4Q1MzdjNxTGVtTGxZWk4xWjhRVy9ScVg2QjFPOTFlRHhVYkhRRHBP?=
 =?utf-8?B?VkQ5aExuRnFwOWJuNUtvWXpzRjRvZXNZeFNXUjlPMWpvaUtad0hJKzZmTDZR?=
 =?utf-8?B?cTVEQjBSMGJ3REZXMENwWHZiMWFCWVFJM1VxYk1yelJZc2tJMGpGZkE3R2Zt?=
 =?utf-8?B?N2t6UGozcWFvb2dldENKYnVLL21hSXlSZXV1eEVwZyt4cHB4SmI1NU9oWWQ0?=
 =?utf-8?B?c2g4VS9lUjRZTm84MCtMYVN5OS8rQ1QxS1BpVVJLSm15UGcwY1M2SDZmSXNM?=
 =?utf-8?B?ZHBzSy9RVDJReWthekxUMUZadmk4R2UwOTJHSmJYYlRvZmhzZ0pTMlV2R1R2?=
 =?utf-8?B?N05kaUhVMnJ3SlJuK0lSTFFCay96RXYwd1hpKzZJVmJoWlBLTVFjTnZQZi84?=
 =?utf-8?B?cVhsa2p2VlJ1OW5lSGJRN1prMUI4ME1DbnVCL0tnSHdWN2xDU1QvYTNrVEFh?=
 =?utf-8?B?Z1ZaQXdXOTNiUUhCeElpc0JIL1kwaTdqbERoZDJxdVBCOFBIQ05FQkVyUWI2?=
 =?utf-8?B?QVF5aVJ4Q1FvdDYwb2RtNVFPSmhpQzlqUWVYZ0ZCQzlodURYaXZkYnFkTXZ3?=
 =?utf-8?B?MFNWTmI2cE9wV3hhN3c4M1VOajNmYnJESzVscHV1YnlIaER1TlRPNFFDK0Mr?=
 =?utf-8?B?NVFCSXp5bUl6cm5lZmd2SWJHMmVoazlDYjM3REVteFZublluSlZUM3pCUTB4?=
 =?utf-8?B?OTFuQmJock5WMTc1SFdUbnJaT0J4MG80R0dyQmJvVWVwQkl2SmxDaWtDMVNo?=
 =?utf-8?B?T29xMmxPRXZMajNOWno1cC82OTByR3VPbWcwZzJ3blZXZ0djT1FUVTVUUlFl?=
 =?utf-8?B?cHV0SkdzUUNvNCtYbzc0NlNhWkVxQnR6alE2blpsQXVZOWNTWDN2WXloR20r?=
 =?utf-8?B?V1MxUzZFSEliMU5QYXRqeDhHYXlMV1pxNVVHOENvcWR3SnVOUlllK1JiUDJt?=
 =?utf-8?B?cXdtaGNLZEFIejN1RkRrMFR6RmdOaTdHWUlHM0Y3ejRybW82K2tmcytKV0U1?=
 =?utf-8?B?OWp2Uzc3aEhLUG51VWlzMUhNTy9tMkhhaC91eE9UUWE1R0ZlM3gvMFVPTGIy?=
 =?utf-8?B?YzVXd0xudmtQQXZ4ZlF4Z3o1WHlUTkErZ2hadGhDeHk3ZC9zRkxUTVNaOGYy?=
 =?utf-8?B?a1JBenpXWWJzU2pGT2hrZlJDdWJDUWlxUEVVd2tYcnBQWVgrbWEvYmo4RENn?=
 =?utf-8?B?TEFGQno3UktwNXYwbHRVUHpFTiszdUQvQlU5KzYvcHdydk55T1NwRWN4MS9r?=
 =?utf-8?B?RXc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 007ee02f-44b4-4c94-5e34-08de2756f8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 10:32:42.9472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dMRhH/rzY0oHm+9dF/Ms+91KIBSwEPptVRzHkeG+55WIrBcgBOJAXhs40mwxzoeDjiuKEtH6TrIsyWdovUY4tr2glmZr8mytRqhesACD1Tf4Nr6cZArZbrCuaDPrjDrW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9050

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAxOCwgMjAyNSAyOjU5IFBN
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
UEFUQ0ggdjYgbmV0LW5leHQgMTAvMTRdIHRjcDogYWNjZWNuOiByZXRyYW5zbWl0IFNZTi9BQ0sg
d2l0aG91dCBBY2NFQ04gb3B0aW9uIG9yIG5vbi1BY2NFQ04gU1lOL0FDSw0KPiANCj4gDQo+IENB
VVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwg
d2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBu
b2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiAx
MS8xNC8yNSA4OjEzIEFNLCBjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20gd3JvdGU6
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
aGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiB2NjoN
Cj4gPiAtIFVzZSBuZXcgc3luYWNrX3R5cGUgVENQX1NZTkFDS19SRVRSQU5TIGFuZCBudW1fcmV0
cmFucy4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIHwgMjAgKysrKysrKysr
KysrKystLS0tLS0gIA0KPiA+IG5ldC9pcHY0L3RjcF9vdXRwdXQuYyB8ICA0ICsrLS0NCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L3RjcF9lY24uaCBiL2luY2x1ZGUvbmV0L3RjcF9l
Y24uaCBpbmRleCANCj4gPiBhNzA5ZmIxNzU2ZWIuLjU3ODQxZGZhNjcwNSAxMDA2NDQNCj4gPiAt
LS0gYS9pbmNsdWRlL25ldC90Y3BfZWNuLmgNCj4gPiArKysgYi9pbmNsdWRlL25ldC90Y3BfZWNu
LmgNCj4gPiBAQCAtNjQ5LDEyICs2NDksMjAgQEAgc3RhdGljIGlubGluZSB2b2lkIHRjcF9lY25f
Y2xlYXJfc3luKHN0cnVjdCBzb2NrIA0KPiA+ICpzaywgc3RydWN0IHNrX2J1ZmYgKnNrYikgIH0N
Cj4gPg0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQNCj4gPiAtdGNwX2Vjbl9tYWtlX3N5bmFjayhj
b25zdCBzdHJ1Y3QgcmVxdWVzdF9zb2NrICpyZXEsIHN0cnVjdCB0Y3BoZHIgDQo+ID4gKnRoKSAt
ew0KPiA+IC0gICAgIGlmICh0Y3BfcnNrKHJlcSktPmFjY2Vjbl9vaykNCj4gPiAtICAgICAgICAg
ICAgIHRjcF9hY2NlY25fZWNob19zeW5fZWN0KHRoLCB0Y3BfcnNrKHJlcSktPnN5bl9lY3RfcmN2
KTsNCj4gPiAtICAgICBlbHNlIGlmIChpbmV0X3JzayhyZXEpLT5lY25fb2spDQo+ID4gLSAgICAg
ICAgICAgICB0aC0+ZWNlID0gMTsNCj4gPiArdGNwX2Vjbl9tYWtlX3N5bmFjayhjb25zdCBzdHJ1
Y3QgcmVxdWVzdF9zb2NrICpyZXEsIHN0cnVjdCB0Y3BoZHIgKnRoLA0KPiA+ICsgICAgICAgICAg
ICAgICAgIGVudW0gdGNwX3N5bmFja190eXBlIHN5bmFja190eXBlKSB7DQo+ID4gKyAgICAgLy8g
bnVtX3JldHJhbnMgd2lsbCBiZSBpbmNyZXNhZWQgYWZ0ZXIgdGNwX2Vjbl9tYWtlX3N5bmFjaygp
DQo+IA0KPiBQbGVhc2UgdXNlIC8qICovIGZvciBjb21tZW50cw0KPiANCj4gPiArICAgICBpZiAo
IXJlcS0+bnVtX3JldHJhbnMpIHsNCj4gDQo+IEl0J3MgdW5jbGVhciB5b3UgdGhpcyBmdW5jdGlv
biByZWNlaXZlcyBhIGBzeW5hY2tfdHlwZWAgYXJndW1lbnQgYW5kIGRvbid0IHVzZSBpdC4gU2hv
dWxkIHRoZSBhYm92ZSBiZQ0KPiANCj4gICAgICAgICBpZiAoc3luYWNrX3R5cGUgIT0gVENQX1NZ
TkFDS19SRVRSQU5TKSB7DQo+IA0KPiA/DQo+IA0KPiBPciBqdXN0IHJlbW92ZSBzdWNoIGFyZ3Vt
ZW50Lg0KPiANCj4gL1ANCkhpIFBhb2xvLA0KDQpZb3UgYXJlIHJpZ2h0LCBhbmQgSSB3aWxsIHVz
ZSBib3RoICJzeW5hY2tfdHlwZSAhPSBUQ1BfU1lOQUNLX1JFVFJBTlMiIHx8ICIhcmVxLT5udW1f
cmV0cmFucyIuDQoNCkJlY2F1c2UgdGhpcyBBQ0UgZmllbGQgZmFsbGJhY2sgd2lsbCBvbmx5IGhh
cHBlbiBmcm9tIHRoZSAybmQgcmV0YW5zbWl0dGVkIFNZTi9BQ0suDQoNCkNoaWEtWXUNCg==

