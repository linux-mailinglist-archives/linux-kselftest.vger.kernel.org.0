Return-Path: <linux-kselftest+bounces-33915-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A99AC62F2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 09:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8717B0DE2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 May 2025 07:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6162459E7;
	Wed, 28 May 2025 07:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="nfIyHQHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013054.outbound.protection.outlook.com [40.107.162.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A1E2459C5;
	Wed, 28 May 2025 07:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748417215; cv=fail; b=dCAcd5eqc8QjxIclLFOTSVShF5Qo7Ivkre636SN6gMcMxmOr0B1KVXCrILC0vsdO3aJdJAqJ8JN5Ui4xZ5i3JmR2b1y3WEZhbkFHl6flnpor8P11YUS+gj+C3mAIFIsX7KCDvTszu/jVJPrCU5i/GdWKlmxK3cNL6nMxiNoJnHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748417215; c=relaxed/simple;
	bh=ZkC8ttmKixJZ0of1L5ibSkRXda/WUtk9CZ8WJcPrKSw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=peau2ustYpLHywcYrP284p4uVx30ucXN+cPduVt+cxgGYePA/PL6mk9WlK/MwP2NyVM5Dw2ls0DYGoramEGdaig31x5MWYCgokvVQQHdk9sux+mhkngr+LlYubLkWAU2k9T6jPGxqYWgGJEZ6PPq8MjgxOJKd39T14O8Kp/NF88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=nfIyHQHV; arc=fail smtp.client-ip=40.107.162.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cjpIx7bwQAtT8DFAVQzrZvgjMpCfg8vChpHpoki4CAmPLlLvu+L/vkudFBXeES07G0cOo87POhrfwah5LT+4KtpZia+T47Xqi7fIF1yXt1+63RYBPU26hqProJ05MIBzUTdhPKegba8PFHduC4CL/vPXt+yxJGjl2v0iU7PNyD1Xs3SAll7Ed5sIQNI20hyhTkAnQQN9YE4M1Rgp6XfktIg1KG4DasvbWQR7YuXe7x7ncQMfR3zvnt9zC7A6LffY0Rt9yHsKP5zVH8r58jFwvgoZzdT3QvRm8E5j2hJ2WDfZWARFOIAp+U5wjuJMuKCuQE41wQE8S7y/TFSCRhvebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZkC8ttmKixJZ0of1L5ibSkRXda/WUtk9CZ8WJcPrKSw=;
 b=yh1mma+6ms4CxjA5dprKBxRMAqrpIPKr6U+6MMYJ+IxhNvpmdbxEgzPjWW+jA6aT3qHVialvdKnP/m55azHk16Y74mEnIvyY3T4n+peXf/cK717rjrmd8kztJsz5syFpM9YuOAxqLRvJeFzjQS7lZxloRuLI2yT7c8BIAA9hXoUf1diXiE/+T5wNWVi9lr/JbWyr1DEAGTI+BC5LrdYelHBu2J8L3c7TA7xrp/3tugHyQtZPmXBKLhp1tRhRdg1MBSUWFSOvPkV8VXSLvvWnwIYMQ2F3uy/0P6YC6UKDCBTi7Ut7WWWR4OcuVhp3hp4W23HwENxWbx0CeRxViiK6qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZkC8ttmKixJZ0of1L5ibSkRXda/WUtk9CZ8WJcPrKSw=;
 b=nfIyHQHV9uqM5yJBOcdzlrF6TjlBBpEizxXYLZnOM2bv9AIbTwDPdE4kSza90IyODbdMrWivpECVUDztWgBMwaKOkCSyNDU6qllDgeXoT6g5GY3Nle/O37jeOcVkxgDlIwWv7IUi2sNi39gx/rhr09Qfh8YOmEPbivpIFCPUp3frFgxhaUlN//fqbR+JKU2BEvUokAWVZTBUpH6Nk7hgoxvC4uEUs/d89HmqGUYqWkMkdjr2rqPuMjykkETlCkVdHY5rA7W9IiGvDiFxpzeSzrGTaXNplceyhZ5CVa883FDjlObAAzHUT9EiRyP2RrwRBxg+yNcWqZFfmOAPulD38Q==
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com (2603:10a6:20b:396::12)
 by GV1PR07MB9142.eurprd07.prod.outlook.com (2603:10a6:150:8a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.29; Wed, 28 May
 2025 07:26:48 +0000
Received: from AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692]) by AS8PR07MB7973.eurprd07.prod.outlook.com
 ([fe80::c87:78c7:2c44:6692%7]) with mapi id 15.20.8699.022; Wed, 28 May 2025
 07:26:48 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net"
	<corbet@lwn.net>, "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
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
	<koen.de_schepper@nokia-bell-labs.com>, g.white <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, vidhi_goel
	<vidhi_goel@apple.com>
Subject: RE: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
Thread-Topic: [PATCH v7 net-next 09/15] tcp: accecn: AccECN option
Thread-Index: AQHbxNgUpAYfc+YJEEqYWFlMJ4UNqrPbSikAgAARLACAADOxAIAMKkIQ
Date: Wed, 28 May 2025 07:26:48 +0000
Message-ID:
 <AS8PR07MB7973CF0C34C90A2A91C36A80A367A@AS8PR07MB7973.eurprd07.prod.outlook.com>
References: <20250514135642.11203-1-chia-yu.chang@nokia-bell-labs.com>
 <20250514135642.11203-10-chia-yu.chang@nokia-bell-labs.com>
 <ba1b1b36-cd7f-4b36-9cee-7444c219b4f5@redhat.com>
 <CANn89iLkyC-MfGUTvcV=zr+LYKzMsyv1im1Oft6EAXYb2x0jGw@mail.gmail.com>
 <c9465324-b2df-4507-8d17-7cdda55a60f0@redhat.com>
In-Reply-To: <c9465324-b2df-4507-8d17-7cdda55a60f0@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR07MB7973:EE_|GV1PR07MB9142:EE_
x-ms-office365-filtering-correlation-id: de43389c-7e11-4ec3-1615-08dd9db901d7
x-ld-processed: 5d471751-9675-428d-917b-70f44f9630b0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnhjVGE4SXdzcUJuelBlaDdSQU5VVGpVMUVBVkREWSsxQU1qck81eHFzVXl5?=
 =?utf-8?B?TFFQQVRnaFhKNm01cjJzUjhqMmVyeTFwNmtRTjJFV3F1SjVVWFd3T2d0SHFO?=
 =?utf-8?B?aDA0K3hMQnNTcHBZeTNKeCswVWZqb2d3bnRQc2ZqL1V0SVZPM0Y4bkZ1U1Ux?=
 =?utf-8?B?UzhzVVBCa0RyWEZ0TCtGYVJ2UE02WWk5eGxYVVJ0cTNvYjhmS056SU9BTjZB?=
 =?utf-8?B?eS9TWWs4eEpVZ2ZxVkZJU2FDdmhiWnkrZGc3WFo5ZGtmc2lPRVZnK2Z3T3Ur?=
 =?utf-8?B?U1Bzck1iYXhGLzBVRlVUdE95R3JDejZwUWlLY1lTblhoRm5ReU9OekFNckdG?=
 =?utf-8?B?RzZIVUwzSnJVVm1PMWlGY2RQY2kwWU9Yb0c5aE5QNlFUcm1vYzhkV2kzWlpG?=
 =?utf-8?B?QTNWNy82ejBrKy8zYWZhbTVseDI1bk9RQmhtS1FWZ0NhMUp4YUxYQzF0ZXVz?=
 =?utf-8?B?dWg1cTZ2NkJ5M1VqdFpXWG1ZMDE4UE5pNnpVSXNBQ2lnZm56MkRBL2dhMlMw?=
 =?utf-8?B?a0ZSKzBscVlhcEVtOUlseldpRkVjUVczMURKbnlXUmxsVFYrNFowRC95Mlky?=
 =?utf-8?B?QmNDb1JadFdlYy9IMjFBNE5HbHZ4M2xUVXc4T1FwL09aY28rUXdSTmpEZ0Zo?=
 =?utf-8?B?TWhHWFVEVG11WnpTcmlTaFlVa3Y1RnRLQ2xGWXNrK3k2YVdOdWF0YkEvYUFh?=
 =?utf-8?B?cTM0R0paTm8zemlaOXVkZEdjaURLaytqeDRTM1JhZWp4T3RidHdSOGtpSmxi?=
 =?utf-8?B?clRMTTNGMzQ4dVVpMktlcGpPT0lzUVhGcTVkUkZ3S3NYbXU5MEM0ZkhKL0xi?=
 =?utf-8?B?RWJCVm1IeGxrVHVPMUVUUllMUENoT3gyT05RcDhMdmE5WXhWVG0xeDF5NndI?=
 =?utf-8?B?RXNvcmZhK1QxdXAraEdvbklXcmpqZkpMajR2aTE0c0ozSWZkdzFzRnpyTVFS?=
 =?utf-8?B?QVZYOUZyTWVmeUNsaFhTMXlGRjZZZVZkaXUwTDRvWlo0UTFBaGp3bWlTc3p2?=
 =?utf-8?B?WG96M3JxbzdpV2xVQ1lYUGJHWndtQkR6VmE2QnVVMC9GazRzRGcxVElaZXlY?=
 =?utf-8?B?RVU4d3V6ZWVEUVZaV0o3TmRubTJ1Mm5tU1ZSZGJiN1dVZ1ZrSTU1T2g4SEhT?=
 =?utf-8?B?Tk9sSmxZKzV5aEJYbzZyMHdCOTZ6alpoSXF6dlc0Z1g2ZG5ybE5rdWFOSHZK?=
 =?utf-8?B?eU1LZEx6WjRHOWg4R3c5TkhtcGdlZFZpVVBZeHM2ZklmS2tTd3FoM29sbnNh?=
 =?utf-8?B?dEdKa0V3Wm9UeDYzNkMxV0lEcXVOdEZMRy9nV281MWpSMVFWbWxkdC9xb1V2?=
 =?utf-8?B?TzIyczd6MnBFSGRjL1pNR0REbU14MlB5Qmw4SHFpKzhMd2ZlbkNBZmVrNFlT?=
 =?utf-8?B?dURGWWwxVERyMTRHUVJxbjNHaXpCNWNkVGpvdGM3cElEaHYxVFVNZFpGd2ky?=
 =?utf-8?B?eFd1NHlVbnc0ZHN2amNYRmVsMFRYcCt6UXJkWnZ6SmdiczhhS2UyT0cyVDE5?=
 =?utf-8?B?dUlLeTJpZC9lMnpMakI2ZHZ2MnRzRnhEcmVLcEtxNVVrN3dXTHh6clZUeTVG?=
 =?utf-8?B?VW1GcFUySytZTUZ4T2lhZy9JcHluSkhmOVlJbVNCMWFIOUFwSjF0Q2U1elpI?=
 =?utf-8?B?L1lPMU1kTzZjZTZhVTBOWm9LMktNKzhhRVBpMTlNekhpR285UE1RNkk2UXh5?=
 =?utf-8?B?Vms5QkM4L0JIY2NRRzZrcU1pbklZeUFXTDBab0xtWlJqTC9xUFlVNVNZVkFt?=
 =?utf-8?B?VThYWkxoQ3prVnhDUk5qNU1YL1MvbnZIT01ySWI3d2w3UEtKdmMyc2ZrN3l4?=
 =?utf-8?B?djZYYjdIbDdhU2dsRFFGQVUxRnRZbzk4V0JGZVI0WlNHcy9tRkRFLzRUOWYy?=
 =?utf-8?B?d29KQzUvUVFoYTE5aHdJbTB0OHoxMmM0MFBEQnFJSkU0MG5TQXRSdytLa3dv?=
 =?utf-8?B?a2dnNDk5TW4xNzFuS0JNUWpEZlROV2VRNUR3OXJkdnl2MnRvRnIwTFZRbkQ2?=
 =?utf-8?Q?+qFjj0U5woVQnb0SGED3PRpSqMoeJo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR07MB7973.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2Z6ZVhNcHFiOGNBczJRRmdlSWxzbExTMUZtU3UvZS9jTUFqKzc1aGZYQ1Fh?=
 =?utf-8?B?RkltRmxTVHVYTm5ISEltdHRNRzRJNmhoUTUzd2lERHVwSENuWFlQdk1KUWU0?=
 =?utf-8?B?bUxiVU9UeW5TT2FhMEZzYndjL3RpaGFEd1B6aCtGNXZIejQwMXlZeVh5S3hZ?=
 =?utf-8?B?NEhjRFBXQnFyR0JkMDZUempTRjZ2UjIzZ3YrSVpEVVZoUm5OVWJUWE4rc0Fa?=
 =?utf-8?B?SXRWYU9udzhkWjlobVBnaVZCVUJZTlIrVE1SZG00ME4yckN1ZmpqdHR1c01B?=
 =?utf-8?B?M0lKdU1NNUNneFRuZ2VkYXNUaW9ubkUzdm00WlE4V1VXcHdDSXUyNlZWa2R0?=
 =?utf-8?B?eDh3Sjd4Z3dPNkJJeGFhUVRNT1R5WnVaSWhOaEZLSFRoQXhSTmVJa0JiSS9D?=
 =?utf-8?B?V3BRcEFMcnZrZUh2Z0wrZEFaVWp5MzZoRnNvMFdFdzZRb3FvRC9Eay9BRGdt?=
 =?utf-8?B?SUs4Wkx5WG1PVXRyVWY1QVJrcU5xdm1IQW5ueTFxM3ZBSnlMK2xJaVZEc1Fq?=
 =?utf-8?B?REJPRyswVE1WVnhNVDJwSDEyWnNEakdaTyt5WVg2bExFOVNaV1JUaHJQRzRH?=
 =?utf-8?B?akhkUmtsN3NEUXA5SURxZnMzVWJnMGF1anc3bS9WK2NFdTdxcWQvUEZxa1gy?=
 =?utf-8?B?Q0RiQ0V2MTF5enBOVzcwVUhMS2tkcVh0d0RyeEM4TTRDRzlXTVRwVnI4MjJs?=
 =?utf-8?B?aVZ1S3hBMEFScGNJOG5sd0FXY25ueTdSaGhxZjl0blBJS3J0dGxlRnV0ajQx?=
 =?utf-8?B?YXRidFdRSzR6MkRURmhCbXZRMXJQVktaOVMzZGZZd3dMRmZvVSsrODNHaGVy?=
 =?utf-8?B?cVNseG9nYkEzQVRtUTZBNEZJRXFrWXQwTW1SaXNlYnYzWXhVN2lQU24rOFlE?=
 =?utf-8?B?ekpyZERoYnJrbnVjdEM2U2lPM00rUHJxVWVvcDU0Q0JQVUg5T0NDMGN0c1Bi?=
 =?utf-8?B?eFpVeTBScEhGdjJIUXoyQXpjMVlpSzdQa0NlQXlTRkhCdGJVWktPb2cwVXN0?=
 =?utf-8?B?SXRsZW96TW05K29ua29HZm5uMkRtRmk2QURYU0VGV3pzUldJWTJhc0NIMEZD?=
 =?utf-8?B?THhFWUNvWmRkL0J3VlphSXZuVXdGUmRoSkxidXRiTStQN2JUdEwxZkVHeTVH?=
 =?utf-8?B?UTRodFNWQ2NtRm85UktTcG5WaS8veHo2bWpDWHNDZVhBaUlkbXMvRTZEak9m?=
 =?utf-8?B?ME5jWStIYTdnM3F3alZ3RTl5RkttV0FjNmovK1RzR2dDRTR4Z0taMENXT2Ny?=
 =?utf-8?B?Ymg4eDJpU2FTdzY4TW9TVld1RG5vaUlsdlNuOUE3QVR1N0ZCUndRMDM2TXBm?=
 =?utf-8?B?T0xUM1I0aExPR3dqWmlXa3RmUlhXck5FTmEwY3ZBK3FLeFM2SHhqUjlhK2s2?=
 =?utf-8?B?c1lOd0Z2bk5YQnhVdHNzTnA2ZS9tSnRvVzJzRElKSHRua0E3QWNTek4wYjds?=
 =?utf-8?B?T0NoeWFmWXVLUUlmdS9Xd1RrY3dBbGtFaDdNYksvQ2lRYkFYemRNWUJ5Rkho?=
 =?utf-8?B?UFdjRUwwY2huMXB5eitINzhTQWY1cXBiQXBDNUpSVUcxZ3RkaVlVN29KbnhP?=
 =?utf-8?B?TGxJRUR5VTQvK05RVmJpTmhUc0dOS0lVV3U0MjJxaXJuL2o0c0gwemNVTEJZ?=
 =?utf-8?B?cCtobk5RRHlxYWZlN0FlYXJXRjlBTWp5ZlUzTG8wZ1krZ25VNHk5VUt1TTEv?=
 =?utf-8?B?UUpaVE5MZWpKbC9BdXhTcmJtanNoaDBWZ1dJaVVjdVU5YzQ5UklVUWNmcE5F?=
 =?utf-8?B?bUc1c0dMK0g4YnBZUUgyZU1oQnY4ZmY3VFF5SEU2UmV2U2JJYXZCNDJmMUla?=
 =?utf-8?B?Z2VPcm9MRVNadmp0Vm43VHVDdWRVNnoxNnhmTy9FNFlKdDRqZ3NMckw1SGQ1?=
 =?utf-8?B?c1VGTmY2Zlc5dUpCV0tjL1dVT29VTFBtcG13ZU04anRCVkRhdGlmZDBqczYx?=
 =?utf-8?B?RVRVc1ZpdFVseXNreHplSTFXYVBISTlMakZHcUR5Z0VJMnp3QzFxdk9uRi9o?=
 =?utf-8?B?OTJUdFI2VXVWSkkxdXArVjd5d1B5TGFtb3l0TGc5UmJCd0tZM21JWmJWK2Rk?=
 =?utf-8?B?M3hIYitEK2lINzRGZi8wQzhreFVlaXBTTUV5WENsNXZzWWUyd2oxaktpbk9q?=
 =?utf-8?B?OGowU0ZmYy9HV0VzbnEyR1FoMkVnOW9lUHdwaE1qOHJ2azRnQThQVmJyMFpo?=
 =?utf-8?B?SUE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de43389c-7e11-4ec3-1615-08dd9db901d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 07:26:48.1580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NF1UXmYFTM7+IyG3tI8cUjelPxfcuUIXsCnj55ZbWrldeFZtFCtcRs3I+gvupdXsMYjuoEiFzCQIdI0YWLZ95E0kCYY2/JWw1d2IWIzxJRj5XeKWrPZrJ0KP4J5WnmBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9142

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYW9sbyBBYmVuaSA8cGFiZW5p
QHJlZGhhdC5jb20+IA0KPiBTZW50OiBUdWVzZGF5LCBNYXkgMjAsIDIwMjUgMzozOCBQTQ0KPiBU
bzogRXJpYyBEdW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPjsgQ2hpYS1ZdSBDaGFuZyAoTm9r
aWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+IENjOiBsaW51eC1kb2NA
dmdlci5rZXJuZWwub3JnOyBjb3JiZXRAbHduLm5ldDsgaG9ybXNAa2VybmVsLm9yZzsgZHNhaGVy
bkBrZXJuZWwub3JnOyBrdW5peXVAYW1hem9uLmNvbTsgYnBmQHZnZXIua2VybmVsLm9yZzsgbmV0
ZGV2QHZnZXIua2VybmVsLm9yZzsgZGF2ZS50YWh0QGdtYWlsLmNvbTsgamhzQG1vamF0YXR1LmNv
bTsga3ViYUBrZXJuZWwub3JnOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgeGl5b3Uud2Fu
Z2NvbmdAZ21haWwuY29tOyBqaXJpQHJlc251bGxpLnVzOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBh
bmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBhc3RAZmliZXJi
eS5uZXQ7IGxpdWhhbmdiaW5AZ21haWwuY29tOyBzaHVhaEBrZXJuZWwub3JnOyBsaW51eC1rc2Vs
ZnRlc3RAdmdlci5rZXJuZWwub3JnOyBpakBrZXJuZWwub3JnOyBuY2FyZHdlbGxAZ29vZ2xlLmNv
bTsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwt
bGFicy5jb20+OyBnLndoaXRlIDxnLndoaXRlQGNhYmxlbGFicy5jb20+OyBpbmdlbWFyLnMuam9o
YW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNo
aXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNv
bTsgdmlkaGlfZ29lbCA8dmlkaGlfZ29lbEBhcHBsZS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjcgbmV0LW5leHQgMDkvMTVdIHRjcDogYWNjZWNuOiBBY2NFQ04gb3B0aW9uDQo+IA0KPiAN
Cj4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2Fy
ZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUg
VVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+IA0KPiANCj4gDQo+
IE9uIDUvMjAvMjUgMTI6MzIgUE0sIEVyaWMgRHVtYXpldCB3cm90ZToNCj4gPiBPbiBUdWUsIE1h
eSAyMCwgMjAyNSBhdCAyOjMx4oCvQU0gUGFvbG8gQWJlbmkgPHBhYmVuaUByZWRoYXQuY29tPiB3
cm90ZToNCj4gPj4NCj4gPj4gT24gNS8xNC8yNSAzOjU2IFBNLCBjaGlhLXl1LmNoYW5nQG5va2lh
LWJlbGwtbGFicy5jb20gd3JvdGU6DQo+ID4+PiBUaGlzIHBhdGNoIHVzZXMgdGhlIGV4aXN0aW5n
IDEtYnl0ZSBob2xlcyBpbiB0aGUgdGNwX3NvY2tfd3JpdGVfdHhyeCANCj4gPj4+IGdyb3VwIGZv
ciBuZXcgdTggbWVtYmVycywgYnV0IGFkZHMgYSA0LWJ5dGUgaG9sZSBpbiANCj4gPj4+IHRjcF9z
b2NrX3dyaXRlX3J4IGdyb3VwIGFmdGVyIHRoZSBuZXcgdTMyIGRlbGl2ZXJlZF9lY25fYnl0ZXNb
M10gDQo+ID4+PiBtZW1iZXIuIFRoZXJlZm9yZSwgdGhlIGdyb3VwIHNpemUgb2YgdGNwX3NvY2tf
d3JpdGVfcnggaXMgaW5jcmVhc2VkIGZyb20gOTYgdG8gMTEyLg0KPiA+Pg0KPiA+PiBOb3RlIHRo
YXQgSSdtIHN0aWxsIGNvbmNlcm5lZCBieSB0aGUgcmVsZXZhbnQgaW5jcmVhc2Ugb2YgdGhlIA0K
PiA+PiBjYWNoZWxpbmUgZ3JvdXBzIHNpemUuIE15IGZlYXIgaXMgdGhhdCB0aGlzIGNoYW5nZSBj
b3VsZCBkZWZlYXQgDQo+ID4+IHNvbWUvbW9zdCBvZiB0aGUgYmVuZWZpc3QgZnJvbSB0aGUgY2Fj
aGVsaW5lIHJlb3JnIGZvciBhbGwgdGNwIHVzZXJzLg0KPiA+Pg0KPiA+PiBTb21lIGFkZGl0aW9u
YWwgZmVlZGJhY2sgZnJvbSBFcmljIGFuZC9vciBOZWFsIG1vcmUgdGhhbiB3ZWxjb21lIQ0KPiA+
DQo+ID4gSSBoYXZlIGJlZW4gdHJhcHBlZCBsYXRlbHkgd2l0aCBwcm9kdWN0aW9uIGlzc3Vlcywg
c29ycnkgZm9yIHRoZSBkZWxheS4NCj4gPg0KPiA+IEkgYW0gc3RpbGwgd29ya2luZyBvbiBhbiBp
ZHBmIGJ1ZywgaG9wZWZ1bGx5IGRvbmUgdG9kYXkuDQo+ID4NCj4gPiBUaGVuLCBJIGFtIE9PTyB0
b21vcnJvdywgYW5kIGNhbiBoYXZlIGEgbG9vayBhdCB0aGUgd2hvbGUgc2VyaWVzIG9uIFRodXJz
ZGF5Lg0KPiANCj4gVGhhbmtzIEVyaWMhDQo+IA0KPiBAQ2hpYS1ZdTogcGxlYXNlIGNvbnNpZGVy
IHRoZSBhYm92ZSB0aW1lbGluZSBiZWZvcmUgcG9zdGluZyBhIG5ldyByZXZpc2lvbi4gaS5lLiBp
dCB3b3VsZCBiZSBsaWtlbHkgd2lzZSB0byB3YWl0IGZvciB0aGUgYWRkaXRpb25hbCByZXZpZXcu
DQo+DQo+IC9QDQoNCkhpIEVyaWMgYW5kIFBhb2xvLA0KDQpBcyB5b3Uga25vdyB0aGF0IHRoZSBt
ZXJnZSB3aW5kb3cgZm9yIHY2LjE2IGlzIGJlZ3VuIGFuZCBuZXQtbmV4dCBpcyBjbG9zZWQgZm9y
IG5ldyBmZWF0dXJlcyB0aWxsIDl0aCBvZiBKdW5lLg0KDQpNYXkgSSBhc2sgZGlkIHlvdSBtYW5h
Z2UgeW8gcmV2aWV3IHRoZSBwYXRjaGVzIHdlIHNlbnQgdHdvIHdlZWtzIGFnbz8gDQoNClRoYW5r
cy4NCg0KQmVzdCBSZWdhcmRzLA0KQ2hpYS1ZdQ0K

