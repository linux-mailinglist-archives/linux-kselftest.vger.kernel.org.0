Return-Path: <linux-kselftest+bounces-39670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96196B31485
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 12:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6863516427B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B878F2C028E;
	Fri, 22 Aug 2025 10:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="W1T1nwsH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013065.outbound.protection.outlook.com [40.107.162.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B24C278E67;
	Fri, 22 Aug 2025 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856847; cv=fail; b=EXlF1P2NX4G3SO21Oc7TocvlrTgFGBVfFH0E3DRMBkwELLVJNjDr7FDIefyI1axHVK71Pg3j7JLhgIQiqh2vHQoVGBYI70ozysClvVtV+oqBF7WOZHujnybK+bsZnE8iU+jcbtfzDruEJRIeJO3vBOiY6lFFAJ3+4/8kGN0iKVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856847; c=relaxed/simple;
	bh=QlRTiPFwWKngqS+zT1me6fOihKlyznYDMykjhb4OacI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ttMSfvQHOaPtpWkPAkKZ74VzctjJw8h50pYlHUqppcNuYENruGVC1BgeP0muH8w527ZHfm9sbBex0iRVsNNoYIMdX3KbCGatDIxVYroiXfGBhXNfnsjSnFgO44ZMJYocBeFvdklCRQJXA4UkmWTWZN7/yVLcur3StALBYTJTMCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=W1T1nwsH; arc=fail smtp.client-ip=40.107.162.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QywKDTSZTQqjM0+NED8Berp/HjeJXip+0xDrFk/YEg+V8dZeY2Mi2UX796M4U8+npSEUoq8DFeUj8qZB7j4gRK+SDJdFgYcYY9Pw1dEhFshbvkg0fBPJbu8muNjTBkyEBELC5i/utFBKnRNpA95m7bbv2lOHiHO7oa+gUPLsavycj9BydX0br3qvLNAhrQimk5KpRlLG2tFua8RPLElTvcl04xpdPiPmhoX96kSNAff4d2dk+HpvyBIDkr/JQJ2UdNSvLHebsrTWcVbRDwgkv5dRqTVpVl3hqmFs/VqRTA5lla7Cf5/4Ba3ZeT2Xn1AZS/8EJRO0TQhrkqLKw/0Arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlRTiPFwWKngqS+zT1me6fOihKlyznYDMykjhb4OacI=;
 b=ArGEx2KSwZwgodDX+IU5MHjgA6HoeGhi8Y5It4auqcpKVDtgy0NWcryeZFiBp6zlQr8Ei5bjoNXj3UbNwYwGAhetlM+U97sBayLJmcQn435VIfrWhNAmMmyH2fcfJPZ/bktJK6FmGpq2bhPhoDo9jM2w7kyBKeim6BzqveskcRLrHBmxbB+bsIwQAssHQ48G36f1tS96y/f0WAQEa488+nn48Z/CECrOZxWVXH/d1kVXGZzbPQowEn7DiPDpo5EzVLw2YHOgJCUa+V2vCPlgMGHZ3+2KJds0bsBfo8F3T90MLpJ+ITQMtNifLbODFZDA3yZuDuHPbTtcuUjMHzKSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlRTiPFwWKngqS+zT1me6fOihKlyznYDMykjhb4OacI=;
 b=W1T1nwsHUg1e3rZk98Ak3UwnIq5/PC/QOlKQpfoWIAsyEPiMaj1t3iQRHbFsdF1EqHbHYoGytS+GwTILBGyybSTtIykGosKgM7kzZmn7EuW10lCBmlgYRbk9VzDjJ5K91rzyQhvcOQz98RHg8xx49f3o1Bs8+0ZLGuoexyv9KWMMj6ifTVwSjh2Xka/A9NiTjjT01yEp4ytoEaDG87ONirHqGUF2ElRNCDlvksMi923M3zKujO2ulmNEJvX/8s+2hsAPPqoXdVs2tvaF9IXYA3BVxHv9t3XJd9POiBuAEDu+RnrW6jbdGmoUkFwe+P2GBXaMZuCV4ucLmtjEh804Mg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by PA4PR07MB8463.eurprd07.prod.outlook.com (2603:10a6:102:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Fri, 22 Aug
 2025 10:00:41 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::b7f8:dc0a:7e8d:56%2]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 10:00:41 +0000
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
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v15 net-next 12/14] tcp: accecn: AccECN option failure
 handling
Thread-Topic: [PATCH v15 net-next 12/14] tcp: accecn: AccECN option failure
 handling
Thread-Index: AQHcDcAzCQzkVlqqBUGZgjIbRsg/17RtGkuAgAFJr8A=
Date: Fri, 22 Aug 2025 10:00:41 +0000
Message-ID:
 <PAXPR07MB798409A944ED834962D5CED0A33DA@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com>
 <20250815083930.10547-13-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+xNs7jfc3OF42J0jat=-ivrQgTfycJPyKW28yTJPaaDg@mail.gmail.com>
In-Reply-To:
 <CANn89i+xNs7jfc3OF42J0jat=-ivrQgTfycJPyKW28yTJPaaDg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|PA4PR07MB8463:EE_
x-ms-office365-filtering-correlation-id: 1b6dbd2e-1e17-46ce-c87a-08dde162c0bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW5aMTJDZ3lOZERUbDRrTWU1OEYxeEdmWklIaUllSW5sYUNydHBCakJiSnBK?=
 =?utf-8?B?MXlpQWRlRjhLM1RtM1E0Z3BvS2ZycHFER0pkU1ZoWkhPYk91TC9RSld3elll?=
 =?utf-8?B?aFF1VkZoUnVhV1lXVzhKTCtQMUoySEQvRVdqaVRaWXYya3lpZVREQ05ncFNs?=
 =?utf-8?B?c2EyRnI4TCswRzdrMHc5VWZDc2ZIRkhrTi85eEd5d1hRNHNualErNkRYVHdh?=
 =?utf-8?B?WjB5RW0vamw5aEFaQmliaE40TDVlYkFNUWlpc3dRQzJsaXJObEUzSElWRi82?=
 =?utf-8?B?Ykd2cWhBZFh1Z1BmbzNEUVdHVnZDL0w2UW9GRUhwWUFMVmZ2b216UlNpLzVO?=
 =?utf-8?B?alc5TEFSQ2RUeUlzMmNBZGo2U2VHcGE0aFpJRFdxUTVHN3JOOVdDdzlpNktH?=
 =?utf-8?B?d2FjbFRzR0R6K3QvaEVvT01yWGUwLzNvTVNMUWk3NlZNVEJ5OWpleXZOMm1l?=
 =?utf-8?B?TXl0aFBycE9HSG9YakxBcWNUYmJUV3M1aHRpcU5hQVFwZk04bzBVaDhINEUx?=
 =?utf-8?B?RjA0cjhYMDNMb1dhekVqSkdlRVBPUkZCM0FjRDEwQjUrbFNSRG9mOWdncGZk?=
 =?utf-8?B?dU5MOUFad0FLSDgzc0lpbUxmS3lZM0Q0M0g2SStWaWRoaVdyNjlNTzJMQ3lu?=
 =?utf-8?B?UXAzZzJoQmNXTDNvMllpSC94djhJMDRtMS84d3YrUnczWjkzSWVwMjdmdll2?=
 =?utf-8?B?WHdLVmx5elRtR1kzZHE2aUh3ZzVXY0tqUHRUVWZCRHNWTEZQcGI2ZHlya2xi?=
 =?utf-8?B?THNrcFVYR2xwL0EzeW9qbHl0bytUSC9DUnNpLy93cE1FcWQyZGlQTU1JNXdS?=
 =?utf-8?B?RmFGNHd5bnJPR2xiREc3QVRtZzUwOHkwcEZBRHQ5em9ENFd0UmFNU2JkVklG?=
 =?utf-8?B?NzFaUEtEYW5EU1g2VHloa0hRQnJXVVU5OWhBblU2bWJzV04yeldBbVBXYUNu?=
 =?utf-8?B?cVo2ZlZHM1Vnenl3dmRUTWhyRXJROEdIbjVVcWMyUGVlVUExeVhObzFad0JT?=
 =?utf-8?B?ZjlBNUEzM21RdFRMWGJXd1cwYUt6Qk0vOWt2elk3U1c4SW9ZTGRXWU52THFR?=
 =?utf-8?B?Ym0xVzdJelNVUjBEVVBKOEhkUlFPQWtoR3VKNjZKb01EU1A1U21GSnZxSCsv?=
 =?utf-8?B?b3JGTEJ3Q3RXSzBlV29IVXhnQUhtWTZwT2hhZFpVL1o2K3R6Q0pLTm14TzBs?=
 =?utf-8?B?M3o5R0VUaW9UNGM2azFIcWdSVnBGN3F1cUdGRFBpQ0Fzc1BheXpiNERNSFl5?=
 =?utf-8?B?SDdhcitOcitwa3JsZlNPeUd4ODJhVEdGdmVhblJtWENSWFBvb2VqMjREN1ZP?=
 =?utf-8?B?K3FQMm9tSFFmNHQraGVYOXB4SkZHNHJVcFgrcXpwWlhKa3NzblpKeVl2L3NI?=
 =?utf-8?B?cVZHa2Q3NHUxcWY0TDMvbmVhRm9CaEVUREU0eFVhaTJxdXpvT1BlZTNtNlYz?=
 =?utf-8?B?Y0RuRkJHenBxZmdrWStvU3ZjQXpWMnJQOUIzK3cwU1JIMjBDbHpTajBPVVVa?=
 =?utf-8?B?S3ZtSU9KYmJxRjR3anlxeTF0V1NQOXFHQ25FTlYvZWZ5V04zSytUUHExV3N0?=
 =?utf-8?B?MDNRSllBMVNEQmJoRWJjOVN4ZjdEMkRGYU5CdUZLdXpwM0dQbEI3T3ZMWDdz?=
 =?utf-8?B?TXM0OHQxZWpXRlVPajdiSmM4N05ZbG1zQThtQTdPNU8xUHhXZDJKR1h4Z0hy?=
 =?utf-8?B?eWZDdXgrcFlhU3dVNFQ4ZmkxdjJHb1hESXRYb0pRdnErT0cvRzQ5enhaSlk3?=
 =?utf-8?B?VjZBVEZualc3ZkdYVUNTcW1HamJvVzZjeXlNNFkwTDBjejhjaGYzWUJZTUpa?=
 =?utf-8?B?cjJIMzF4aEFQZWp4ZVdXSStSNWpKY2JRRjJjK1gzbjNVdHJzMVlURS9uQTY4?=
 =?utf-8?B?M0FlVStGWVQvM1V0cnNFNmRWbkt1ZU1NWkVnR01qVTR2Q2VGWlZCaUp3VGtx?=
 =?utf-8?B?TXJqMVdOa1dJWXd3Z2tsZlNaakhWYnRyWVgwcmJ3SkdvcStHYmZERTd5WjlJ?=
 =?utf-8?Q?6LRWTOjHELDKERzxR0ywoYvNH/8H6g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?akJVdFJiU0ZpclVhUG9VMWhmc2pvUlpYbTFpbURQMmlocWxCSndUL3UwSFZ2?=
 =?utf-8?B?VXpTc1h1ZVpqNWluSjI1ek1Qd3EyeHpkZWp2bENndllFdENnSy9qU3V5Wm1J?=
 =?utf-8?B?cEtVSlVURDd2VTl1L2tkd2N0d0c5OGt3M3F5cGNNWEQwSlJRem1VL3N2K0xZ?=
 =?utf-8?B?eGRsZVdMUUthd1dEUFhnMnAxa0JXR09LaG13NmhydTQ4NTdVQXBRZVF1ckRt?=
 =?utf-8?B?NndaY1VYMURJQmxNak5pbW1WMTFCWTdZZXc1WUJoVkhXSTFxRlNYMGJZclRx?=
 =?utf-8?B?dVkydnYvc0xhanpyeG9rMTQ3SGszY2xsenZqTlpGRlRHR1pJbWswL2d4THN4?=
 =?utf-8?B?WG5nNzg3UDFkbjI1UGxCNlhUenp5OXFJSkpQTEEwWE9ZRHV6SytWckpyMHY5?=
 =?utf-8?B?eER0TmlrTThxVnFLUzhQN0hzcmJCM29vSjE1VjNLSGgrNkpPZjZyMmJJRDZ2?=
 =?utf-8?B?VmdnQTdlT3FwZWNRL1dndndxZWVTQ2hyQUpjakhNV0Z5RnE3ellCL2FsN1B1?=
 =?utf-8?B?c28rSG01UnAyWWl0eGdRdUdDOTlqbVZjMDlTT0ZGUnlyZmx5SXlKRkMwaWxF?=
 =?utf-8?B?cG81OFZHMmU4bENySXFtYXZsalJuVllrY1ByWlo4K05KSTRmM0pMdHhEZUVI?=
 =?utf-8?B?VkRKTWpFYTFWYWlRaHRzcnpOZEp0aWo2b3JjSndkSlB2d1B6OER4clpWRVMr?=
 =?utf-8?B?RUJYUnlabDBrVVBLYUg0TEQwWjFId3U5WkJ2UVhIVnkyTGtwT0NTamNlMUpD?=
 =?utf-8?B?K1liL0oyclFwUVNKMmMwZW8zbGJmNWxiS3ozOXpoa3FxU0gwZ25EOURvTjYr?=
 =?utf-8?B?WnhZdldZemhWaDA4bEZWUTVuY1VONDVoK3hOcmdUTWhOdEVSNi8xNUNaK09I?=
 =?utf-8?B?c1prVHNQenl2bjk2VjduYWY3UzBTVjR5RTZ0TWdRQjNxZDBqVmNuSFludzIv?=
 =?utf-8?B?b0VQV3VLRUx6dVMxWG81eC9kZWlGc1RSVUt4cnBVZ0ZCWUFrU0RFRVBGZGdY?=
 =?utf-8?B?Y3ZHTXNCYTgvVC9FUG5iT0dRUjUyTHltZGVxVC9ZNmF5Mi9RMjljUmNTNWV6?=
 =?utf-8?B?eTFndWFnWW5CR2UrNHRaSko2cnQ4YVlXS3Y1RnFkQmQrN09VdlRtbituZFYx?=
 =?utf-8?B?dGZ2UGl4b1F3d1lza21meWxhaGRYWUZld1dBcFVkYTdUK2tiVmd4dmlRa1JP?=
 =?utf-8?B?YnFXcHZuUEF2QWR6emRNd1ljVWljZVhyY0RaMTY5SzdtU05ZMFkvNTlnSDlt?=
 =?utf-8?B?OFJlMDc5eXczaHJyVDNUUlhIcTQyOVpZd0o0cUJTcm5MaVR4TEtQaDFUM3Mw?=
 =?utf-8?B?WE1CbTVSMXRjZEh4TXJPNnNGMml4ZlVqMmhYZ1VXS2NvbWFvbjlVekMzMFVF?=
 =?utf-8?B?dEFKeFY3R1JJQ09BbERHOHpiYWVtdS9uTXpEdkh1U3JGaWZSb091ZDlUUEF1?=
 =?utf-8?B?VTJ3N1A2NXduS0FWZVB3b0VJcndlQllLTzZXYUlZVy9IZnJBdHZsczBuZ21Z?=
 =?utf-8?B?eERUcy90amtGeUNReDNiZkhWWGZjdFpWV3NIUzZuYjE4MGQ3bnllRWx0a1JH?=
 =?utf-8?B?dXZkT1FHK3lld1R2aHNwZ0Rka3dSUWRSWldrZzFyQ0IvQVZkOHk5OFhQOHhM?=
 =?utf-8?B?OXFoaE0zbzdaZjlzV0YzQVdTMUN2WGltbWxlYlFqVVFPUW0xMzVQakdFNmNH?=
 =?utf-8?B?WXhoWmo0cVdzcXh5QWl6YlU1cXNGam1oMVVwWVlFL0lVR2NSUnl5NFZaS2VD?=
 =?utf-8?B?WDViQ0NqdWVFRXFEakRoVmFVdFNHYXkvbksvMHZ2TDdacnBqMnVyQzdmbnpj?=
 =?utf-8?B?RVVwTlE1Tmx1SFR4Z1lKMUFKZmpJT3VPYWxXWU1LK1NoTXBTbWxzbkJScHhs?=
 =?utf-8?B?SDFvUXpqKytzdUp6WWVGd1U0TlRZVklrMjc1eG5iaEErUGhPc2phWURBQkFs?=
 =?utf-8?B?b1VwK1ZJMWw4dzQraGJYeml2VEVXY1hvQXRlbVd3N3JOKy9hcjQwckJHOHBH?=
 =?utf-8?B?ZlowdEJ1elZHWjdkeS91VmhpZjhZS1FUZ3ppdFFRK2ErQkFtU1UyUnZMZEJ0?=
 =?utf-8?B?d1JrZUtvbFFKQWwzSnhiVm5rODNsSjlWWW5MWW5HNWE4N0FneUJCcU1sdXNU?=
 =?utf-8?B?aUdqbFVncEZNeGhzODhiQkg1ckhINm5hcXQ4TWxCb1MwNWFzYkZ0UWVDZXdE?=
 =?utf-8?B?UlE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b6dbd2e-1e17-46ce-c87a-08dde162c0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 10:00:41.3071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JqbN4haJXmnsLc5x1yBYlt0aD94B7fXa36zpDGltiYzxo6ohnre+b9ITsLfD7CkEyUlJaolCLU4YOqV1dacdVomkHJQ9qsKOwnn+/rQPMazfv+dBsTPhfdMU5bEgtt5T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB8463

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGdvb2dsZS5jb20+IA0KPiBTZW50OiBUaHVyc2RheSwgQXVndXN0IDIxLCAyMDI1IDI6NTYg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiBDYzogcGFiZW5pQHJlZGhhdC5jb207IGxpbnV4LWRvY0B2Z2VyLmtlcm5l
bC5vcmc7IGNvcmJldEBsd24ubmV0OyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5v
cmc7IGt1bml5dUBhbWF6b24uY29tOyBicGZAdmdlci5rZXJuZWwub3JnOyBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnOyBqaHNAbW9qYXRhdHUuY29tOyBrdWJhQGtlcm5lbC5vcmc7IHN0ZXBoZW5AbmV0
d29ya3BsdW1iZXIub3JnOyB4aXlvdS53YW5nY29uZ0BnbWFpbC5jb207IGppcmlAcmVzbnVsbGku
dXM7IGRhdmVtQGRhdmVtbG9mdC5uZXQ7IGFuZHJldytuZXRkZXZAbHVubi5jaDsgZG9uYWxkLmh1
bnRlckBnbWFpbC5jb207IGFzdEBmaWJlcmJ5Lm5ldDsgbGl1aGFuZ2JpbkBnbWFpbC5jb207IHNo
dWFoQGtlcm5lbC5vcmc7IGxpbnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IGlqQGtlcm5l
bC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtv
ZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNv
bTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJp
Y3Nzb24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZp
bmdvb2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjE1IG5ldC1uZXh0IDEyLzE0XSB0Y3A6IGFjY2VjbjogQWNjRUNOIG9wdGlvbiBmYWls
dXJlIGhhbmRsaW5nDQo+IA0KPiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFp
bC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcg
YXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3Jt
YXRpb24uDQo+IA0KPiANCj4gDQo+IE9uIEZyaSwgQXVnIDE1LCAyMDI1IGF0IDE6NDDigK9BTSA8
Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPg0K
PiA+IEFjY0VDTiBvcHRpb24gbWF5IGZhaWwgaW4gdmFyaW91cyB3YXksIGhhbmRsZSB0aGVzZToN
Cj4gPiAtIEF0dGVtcHQgdG8gbmVnb3RpYXRlIHRoZSB1c2Ugb2YgQWNjRUNOIG9uIHRoZSAxc3Qg
cmV0cmFuc21pdHRlZCBTWU4NCj4gPiAgICAgICAgIC0gRnJvbSB0aGUgMm5kIHJldHJhbnNtaXR0
ZWQgU1lOLCBzdG9wIEFjY0VDTiBuZWdvdGlhdGlvbg0KPiA+IC0gUmVtb3ZlIG9wdGlvbiBmcm9t
IFNZTi9BQ0sgcmV4bWl0cyB0byBoYW5kbGUgYmxhY2tob2xlcw0KPiA+IC0gSWYgbm8gb3B0aW9u
IGFycml2ZXMgaW4gU1lOL0FDSywgYXNzdW1lIE9wdGlvbiBpcyBub3QgdXNhYmxlDQo+ID4gICAg
ICAgICAtIElmIGFuIG9wdGlvbiBhcnJpdmVzIGxhdGVyLCByZS1lbmFibGVkDQo+ID4gLSBJZiBv
cHRpb24gaXMgemVyb2VkLCBkaXNhYmxlIEFjY0VDTiBvcHRpb24gcHJvY2Vzc2luZw0KPiA+DQo+
ID4gVGhpcyBwYXRjaCB1c2UgZXhpc3RpbmcgcGFkZGluZyBiaXRzIGluIHRjcF9yZXF1ZXN0X3Nv
Y2sgYW5kIGhvbGVzIGluIA0KPiA+IHRjcF9zb2NrIHdpdGhvdXQgaW5jcmVhc2luZyB0aGUgc2l6
ZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3Jn
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IENoaWEtWXUgQ2hhbmcgPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4NCj4gDQo+IFRydWx5IGludmFzaXZlIGNoYW5nZXMsIHdoYXQgY2FuIEkg
c2F5Li4uLg0KPiANCj4gTm90IHN1cmUgd2h5IHlvdSBDQyBzbyBtYW55IGZvbGtzIHdoaWNoIHdp
bGwgdmVyeSB1bmxpa2VseSBnaXZlIGFueSBmZWVkYmFjay4NCj4gDQo+IFdoYXQgaXMgdGhlIHB1
cnBvc2Ugb2YgV0FSTl9PTl9PTkNFKCkgaW4gdGNwX2FjY2Vjbl9vcHRpb25faW5pdCgpID8NCj4g
DQo+IEp1c3QgdG8gZmVlZCBzeXpib3QgPw0KDQpIaSBFcmljLA0KDQpXQVJOX09OX09OQ0UoKSBl
eGlzdHMgaW4gYm90aCB0Y3BfYWNjZWNuX29wdGlvbl9pbml0KCkgYW5kIHRjcF9hY2NlY25fcHJv
Y2Vzc19vcHRpb24oKS4NCg0KQW5kIHRoZSBvbmUgaW4gdGNwX2FjY2Vjbl9vcHRpb25faW5pdCgp
IGlzIGZvciBBY2NFQ04gb3B0aW9uIGhhbmRsaW5nIGR1cmluZyB0aGUgaGFuZHNoYWtlLg0KDQpP
ciBpcyBpdCBub3QgcHJlZmVycmVkIHRvIHB1dCBXQVJOX09OX09OQ0UoKSBkdXJpbmcgVENQIGhh
bmRzaGFrZT8NCg0KQ2hpYS1ZdQ0K

