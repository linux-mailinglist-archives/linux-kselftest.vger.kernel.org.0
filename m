Return-Path: <linux-kselftest+bounces-20482-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 121B09ACF8F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E7A282726
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBAE1BFE0D;
	Wed, 23 Oct 2024 15:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfhsfuhm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CPSp54Og"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0E9211C;
	Wed, 23 Oct 2024 15:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729699143; cv=fail; b=S4fVQ2GPFMyEu419SiIiAgLbrezPs9v8bTtVqb76iWgqjhXyuV+vnkvhwZIyOoPeWt1yw9SCTmEiwFxupiv9ye+NYXU6ezJeT5vnrwPYNpqsn4XAybLEQ/clKkYMYGRXNI/SAmGY9eFBBD8xzCInrsUDSf1/KuWnKP2l5GtR3k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729699143; c=relaxed/simple;
	bh=aavvceEzSRHHue7KcEQXdy/b4/RjBoxiB/glWTbLmdE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SX1Q0bSCHoqDeCzTOI7BUMecFhyqvs9kiJ+gqSRf/pCCm/5O76EAsDh4TSmX8BPFDnXzaK9aSCyVanGRm7bt0qOn4llXmE9xOnGpiunJ66I0knyYdgwk7RgiUi/j3PM9BfljwHM3VOFDBQEnFnNbVSmQNRPuXCTIrAwY6R0NiSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfhsfuhm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CPSp54Og; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFfdLo013938;
	Wed, 23 Oct 2024 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aavvceEzSRHHue7KcEQXdy/b4/RjBoxiB/glWTbLmdE=; b=
	jfhsfuhmrACa5CBu968rwLYH8wWgMy8eDBVXOUiRG1F66GoEpZOkMTSJleGdCUkQ
	ggV2AfghouL+RK5H7XDGcNUSnNVXBWqMio+YIbUllqCbN9xXZqIQSOKXkSdmbXx+
	PsoTnjWM2pAo5QiqQZCBG0VbROz/hO9+PyyQUI69rbZ74Ax8rXLN+0+773mGo3oL
	jpie/oyuv0mFA3frdcKqvooGXYuRIx7p3TfaS42fvbWkqjPr/Cq+gn4ARDetqMLa
	aw9VbCxGip2QOQsqByexzsiLbSlAecTjlJu0dP98Iz7lro5gWWks5xFvSTUggIyx
	COdOlURRiPVxplJONTc1FQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v0ftp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:58:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49NFrEeS027525;
	Wed, 23 Oct 2024 15:58:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emh312nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 15:58:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=erzQ3jzeOJWbZ6A0/+hR8kJpq5ZEkGCYGpb6cPBKm+RqNEhAUxYqmxX28BoIsi/YouEz+hMOWbyc3FOPAErVodegnBYpct1QcF59UgFPSXwjrwF1Bi+Sk6Y1o9SaNZu7bkgmIteH4JV/S9P2AV1fB0MCeKIWgUMJl8QfF7EdmqoOyocNDqWpGwtO5sW2p5QKMEQS7VcgbPejJS+nUDy5iDW/eET8DD7T6iVO/62B6MbZIYX7Z425VDKTOeTMYxOQbjwx6rtTo1p/tp/FF42gRO08QOqloLiUk2oBytzd9tLuNZ5U9TqQeaFxBLKTQnAr6LzrEXCIiVwFMXWE645DDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aavvceEzSRHHue7KcEQXdy/b4/RjBoxiB/glWTbLmdE=;
 b=usWQBAHQSGDmu82TNjfo2wVrPRleXXFQk61fzcCcZn5np1pfOMz3S0924dp5ZCvUlB7QK1OtkeL8ibzF1Jw77XeCu1q+EYUOQqKViemmrYzKrEmt2senuK+z46/uqhiaU9ijDUJtKDEed0RBwIuMPYdQ07OV0qBR13ZSuDwIWo6x1m+sSzCXTHM/WL2uddSsp2slzG3//xnlQIoeYm2W8eX1uRizcyz0ygXYBZOsyFpB8/X4pgQeN7Fupn+3/xpdSnd/b9sTCNOOKUWrLOK7IFh3yEdgD71zs6S2Ho+N5IBn3GTWPIKmtcg5FSqNJTsAb5qFYp2WCapbxgZnayHgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aavvceEzSRHHue7KcEQXdy/b4/RjBoxiB/glWTbLmdE=;
 b=CPSp54OgWzTL5kmnuan/cBAIrTm5Xfv6/E9cG4WfX3nZeqtjPG8WudZe7c1AH7NkZEPNjyLMxm8G1SY+/v/affLFahYN90PrsQzWxaLPiRHACI3pJrteEXqw2A1gyDYwkaQKpy4fmR2O52iZ2ehcMT6hITse002sCbRI96jKSNc=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 23 Oct
 2024 15:58:30 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%5]) with mapi id 15.20.8093.018; Wed, 23 Oct 2024
 15:58:30 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "peterz@infradead.org"
	<peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org"
	<rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "vschneid@redhat.com"
	<vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "shuah@kernel.org"
	<shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        Pei Li <peili.io@oracle.com>
Subject: Re: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Topic: [PATCH net-next v5 2/3] connector/cn_proc: Kunit tests for
 threads hash table
Thread-Index:
 AQHbIMB0xnnjqPmQVEKeaxqXStpTkLKLo7gAgAAFlYCAAAXwAIAHk0YAgAA2NACAACUtgIAABfcAgADUp4CAAA6+gA==
Date: Wed, 23 Oct 2024 15:58:29 +0000
Message-ID: <C2B410EA-830B-46BD-8520-7C93E130C070@oracle.com>
References: <08EFFA25-7C8F-444A-B229-2A9F99B0C028@oracle.com>
 <Zxg6KhhpCGc-5Mw0@mini-arch>
 <39B736F3-F7E1-420C-9567-0447464A95BA@oracle.com>
 <CDE1D110-A3F5-4BB7-A8DF-4D24E2AC98B0@oracle.com>
 <ZxkQvYNVGA90srE7@mini-arch>
In-Reply-To: <ZxkQvYNVGA90srE7@mini-arch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SA1PR10MB7634:EE_
x-ms-office365-filtering-correlation-id: 2ed797e5-9c69-4436-804f-08dcf37b89e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzR0Um5hRE9QRHpJcTJ5bmJOKzNGcFhDVGZkcHd5ZnEwMW9ZYU01MTI4WDJj?=
 =?utf-8?B?MDFLZ0dQUG9MRDFRTGgvUEJHUG5pZWIzMzlCbzZxZys3T0ZGTWVaVkxaZ3py?=
 =?utf-8?B?UFlERXg5L05mMTYrUUJ3aDJNaXFWaWU4SGhxWXJFM2ozS3liRzcrTE5hanlj?=
 =?utf-8?B?OU11V3lIQ3NKazBuWHc4R1pWQ0tXd3RIa1FHK1B1OE11c3lENkpSZEpucmVP?=
 =?utf-8?B?aHNNOSt1dXdiOEJ4eVZQbVFONFM5MGxaZzlHNHJyN1BERUF4OWgwMGhZWFVB?=
 =?utf-8?B?bW5EdmRHNkJUMGRidk9MUFFuZlNoL3k0YndZWUJmdkN1SFdaSVVzUkc1RVNL?=
 =?utf-8?B?emcvN2s0ZEJxeGZlVTlRNVlKUXIyeWErU29IVitKRCt4YnZnenVTN2sxNEk4?=
 =?utf-8?B?ckUwYWQ1QTF4UTg4VnAzT3BQMTlQL1dSRjA2Ylo1dTB6ZnJpeDdJaXdxM1N1?=
 =?utf-8?B?SVFsSlJSZ2NpY0VuTjlrRUJqbnFqblppSXhIUDd4azEvZXQ2eW1RT3pZTjI5?=
 =?utf-8?B?RzNocUZjY1M3UUIvZDFSa05JWnFzY0ZDNkc4WmhkTTg1NGdkVGZWbk0yRlJ6?=
 =?utf-8?B?aEt2WmZqQUpuRnVqbk5pblFvL3AvaDZVaC9lMUtwaGxsa3V3UDRBRjNkTDh2?=
 =?utf-8?B?d3ZJVlNpVjhwaldQS0krLzNvV3gvZEM0STBUOE03MjU0akl6bmVRek42VjV1?=
 =?utf-8?B?VldRUkRsWHpySWFQaUJkRWtTamhSR0Y5blcrc1ZpV3hIWjhOQm1FZzJ0MzNw?=
 =?utf-8?B?UEJuVGJLYy9KM1dCWjRjZ2kvcWwyNzlrcTBRdEhHMWxpV1NTbHBKMFUxUGti?=
 =?utf-8?B?RmNFUDNuUkhyclA5bHppbC9icVRRRVZGcEpLTXR4eEJVQllPdDU0ekdycEt0?=
 =?utf-8?B?a003cGM2MTQxYlBGTG1CQmJYOXBMZ1NvYU4wL004QkZIeUtwSzUvVVdLTEkz?=
 =?utf-8?B?RU5HZEl0Y1pLMlc5TzNLSzQzd3A2SndjS2dLWlJCR2YrRTdaa2hFYWVveldh?=
 =?utf-8?B?dGgrMENGL0h4dEE3ZHJnY2NXMmhDcFlGYllHNHE2dFJ6L0ZzcStDWDV2L3M3?=
 =?utf-8?B?NVVNWG1FbGd3b2JjZ2dLK2pGeW81SHFMbWpsbzY4ZzlrQjNNVzlaMU1GWEtM?=
 =?utf-8?B?ZjNsSDNjQ3hRdktQTEFJMjRaQ1VWZlN1OUdmaGNqdlkwZ0xnUUNTR29jcGgz?=
 =?utf-8?B?SnRpbU9hbms0NU5ST0RCZTRNOVAxZitKSW9udHVYQTZCeXVBN3hXanFLYkkz?=
 =?utf-8?B?U21QU0N3V04xeUd0aGtURzJvNG16dVptTGVVYjQ4VVFFNWJBS3VsQXVqZXZn?=
 =?utf-8?B?UjYwMWhWaHFESHNPbElIQjIwZmNGTHl2SVU3Z1Z6VTZkcE1TSExrODdITDhs?=
 =?utf-8?B?NXZTMmdHTzhYKzdsN2huUmFHb2JxSFl0aVJ5SmZuRWxyZUdxTld1ZWpVRFpZ?=
 =?utf-8?B?WTF4Sy9ZVjk5TGhycHRzRE1JdjRyNHdlL3RTQU45WXpKb3laM0x4WitIbjRX?=
 =?utf-8?B?R001Q0NOaGw4SGNPengxdDNlNDNaRlBacXFnLzlJSitCMU9xclZNWE1MOWc1?=
 =?utf-8?B?NkpmdzhEM21FSTlCeEpKY2c5TFNZTGMvbWp1a0JVZ1ZOTGR4dlZzNE9DTlZr?=
 =?utf-8?B?ZTZiZ0FucUhMd2xuYVd5UENTQ0pRbGo4bnV6UkI4c3NsYldGY1RyTUNDTXNO?=
 =?utf-8?B?SFRMMW14dzJoQkdTc1d4R2Z6TXRFR3JMRFUxYys5cytsamMrRWJVMlI2T25N?=
 =?utf-8?B?Ulk3bW5sYVFkRVB5OGw4eldpRjdHcTVCNDlZNHRIMC9Db24xN3ZYK2RONGNE?=
 =?utf-8?Q?UCJN7hsIxNA7jMEmWWQgeqxBtyWjX+a5cCqlQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEY1d1dFTzZQNnFuK3Z2Z08zSlE1YWtLenZ5M1ZWTkdnZEdMZ2xVQ1FsTjJt?=
 =?utf-8?B?NVhYWlRsOG5jMUJJSHNmRFhNd09RYWdZQzhXRTJjRWdPUDJ3alJ3V0FRTHEz?=
 =?utf-8?B?WllDYXZVNUJDWWNJOWdtdzlJS083TGJjRGp4VVdWdXR4L3pPT01wcHVJWlVz?=
 =?utf-8?B?a2ozQVQ2RVFGMmF3cXFQWks0NkdJRnBmdEJMZHp3ZGhXWUhta0V0VUlvQnhp?=
 =?utf-8?B?RHB3UEpWZFRmQ0tpMy94aEdsM0tWVlM3OFR0WE1mSHV4Q3gwOVQwMG5BcEg2?=
 =?utf-8?B?WnFlOHo5TThQbFVpYUVzTVJFY1lnb3NTbktibE5heVp6UEhUWDRkN2pKL0Yw?=
 =?utf-8?B?Z0toVHd2MUdEbjVVVTRYRktESGl6QTl2anNYS2svV2JyTDg3YkJIYjcvNEZV?=
 =?utf-8?B?VE5rejFTdUplZDBRTHpNM2w3dzFiOUYrdVlWZENCV3p5dFZUZ0xrMUVNcHNE?=
 =?utf-8?B?U0U0QUtieXVsUzZrZUJxWFJOOE96akZHWnorWUdGMHJwb3owdmlrbGdpRDlv?=
 =?utf-8?B?Um5ucW9nbmNweVNqN2tpbUpjQzdrcDlUMWRpRjdTWldpYzVUa1lmQTBVdjZW?=
 =?utf-8?B?elN1RnU0ZDdqUGFrR3Y2S2FXR2s0b1lvRjhOWW9Kd0ZhaXBpVjNIZnZsUnJY?=
 =?utf-8?B?MGFiejMxNklBVG8xaTUxV2FQSmlITG5qcWJ5c1c0UXpWbzVOYUI2dXVYSDYv?=
 =?utf-8?B?MUViZzQrc21GKzVRQXZ0Yzc1M3p0dFJ5dHoyeUxkNWMvQitUdWowQml0eEQy?=
 =?utf-8?B?QnBHUG5tM2orUGxmRXJCQ3FQUllKamVHZ1ZJdzF3NUxFd2YrVGR3aHBtU3Bs?=
 =?utf-8?B?NFVSVTlRazFtQTVCU04zTzdpRzg5MThGRjZNYmROc1dFQW1BK2o2cEg1VHQ5?=
 =?utf-8?B?OS9SM3h6TXo3cEdiWGh4VWhpWmU2NW54dUdrYU53Sm9vWG1LejY5S0hycEY4?=
 =?utf-8?B?MFVzc3RSODg3aUNlcmcydnE1OVdQMm1vVWJkcU04MTQydkNZMndGbGpFc1l0?=
 =?utf-8?B?bkx4aFFodlM1VFp0VTBLcVEvd0NqVmdpZFBLQ1VlVzN2aHUxOGY4SU5uenQ3?=
 =?utf-8?B?dm51SEh2REZwMlNPcTJ5WnB4dHZwd3laUG9iOWwvdHRBRWdaWm1oVVcrVXZt?=
 =?utf-8?B?Nk5jN1BvcDBSRldRZThQWmR3bjFZU0Zacm1EdDFXYmY2S0tBMFhkQi9KTnRa?=
 =?utf-8?B?TzQxTVpiY0pEVC9lZUpVak00RnBPQm1xZVRNVUQ0b3dJNzgycmYzTXdyRnBv?=
 =?utf-8?B?UjR5a215Z2IySFVNSHpJdlA3WFNEbDlKa2xnQ1BWNDBQQm5zN0MyUWMxM2tI?=
 =?utf-8?B?c1lyYmIraENGV0d4ZkdWRm9ncFFUSExnbDZnUVRpWWFXTU0xZzhFdURodTFG?=
 =?utf-8?B?UDY4VE4zaVZzdlNTS3NBNWd0eVlId0VGZUp3c2VQaCtSZnowZi84bnRDTTVH?=
 =?utf-8?B?TXBITDlqVHdTUy9oQyticFdGUXBLdUJaN25aUHdJa3R2RGs3R0ZENGREVG5J?=
 =?utf-8?B?bXJaTGM5eGpVU1ZRTWwzYVlCSk9nOCtVU0NmUUhuc2FJaEF0NFpqcDM0SFdK?=
 =?utf-8?B?TjhqU1gzM3FaNE1Nc2lYazJmWjV2LzFNRU05OHZsU3BQMnhnQWk0Y2NxeEk3?=
 =?utf-8?B?YTZHUmtVV1JLVTlNeHFPZnh3aHlneWR5SlVFOFY2VmwzUFdRaHl3NzJaR2RK?=
 =?utf-8?B?YW51VXdaVXlHdHBvTGEwUFgyZCsrVkhvbXRvWVJHNTc2eE9acHBXbkV0bCt0?=
 =?utf-8?B?M3doREU3RkUwZTQ5Mnc3a0hFalArYm1vS1g3WEZHMEZKS0ZJTWIrOUw2MXNx?=
 =?utf-8?B?Nk1yTU4vWmxjbnNJdS9vVG0rMDNuSmlqMmE4MmFZRmN2MkQ4bHlVNlp2TWp1?=
 =?utf-8?B?VlMvUU1HTXVMVFZlVDBwVHNhelpTcGFRRWVvSHIzQVh4YXQxc3FEdFZJZ3dj?=
 =?utf-8?B?NGlWdmtIUXMyKzJVUWw0MnpLcldaaytYUHRuZmt0eFFub05WR3RJc0RjcGNs?=
 =?utf-8?B?eGRzaitpa1FDdFZVLzZUektncVF1S3VpZXJCeEF6b0lQNUdVZldZcDB4YXN0?=
 =?utf-8?B?VW5jejNaaWF5OEZhdERtT0hRMjllQzEzQ1FnU1VFUUJnbXRYWCtlcDlyQ2pU?=
 =?utf-8?B?UTgxRnMxNEJWZkVBVDFveU56cHd4STh3Y2cyQVNjQVlIbFhUQkNERHQ2Wmd0?=
 =?utf-8?Q?N6kBAXRjBpFRFA0JTyBMhsvOu44bbFOPy2AHenIpujmQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EAA999EDCC76554CBC670C2546327050@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DGdIEcH8o9DcM2HlWOoUM5HAo7RW+4gASxZ4xXC2dmo1Sa/ilBGvbZraHZGiJFj+uhlclu8RVKunGU3y/sQJtVsj5kh4InheocCd1Np2G2Dslla3jYH5noPnkW99hceuuBeSpzIiHXO/Lj/5fVM8GVJcHpRvB2jJyd2/QKO5WtyYoB31VVFvFVljQ4A6ziqM3qUc46J+HzoY649uinq5WNJXFY62G7ANe6TaR05tKBv5wTn55WFo1MbcbnoIJoCoeTKalQbgnS1iywepT4jMTz5tnvI+Sc6YWIEvS0aKlVo24N0KZDHko0G97Gb+6Xc5x3xCYTWPcC3xfvCf8TpIQlyGULzhDLZuyNObMRgSQaaqTZSEmMtwBPQB1mF1bHABEvMu0aU2NU2Ra+Vx+hii6/GZgmpDz9V44wqKKre3HHzE/HfEk3UyLAG0S1J+v3lOsgeeoLCgG3LH9wZUiDLDTxp6ILkesV5hJU1syg/qP0NM/aU8I4EB0BX+asEDWhxkpUQ4KzgsRuuQ6ohJU79iRGcb+zczgKV/Gz+P1XJZIVPWMPdCRljeOZibtwOobxYUGIzk/xWzOQ303RlwECwqkc49iqY9dYvcrVPFC/CKQvY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed797e5-9c69-4436-804f-08dcf37b89e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 15:58:29.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ivc9Ioq+jiWfi4gbXoZhDw2vsEQ+Fy9cCzQ633oo+swVpNlMY82dBFA/yFZZB8x8JZU0Dxcq1fTxuL1xFVO5QGQ4bwGN3N4WPSXgLy7K9yM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_13,2024-10-23_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410230095
X-Proofpoint-GUID: rV1VLrPq6ciQ_giecbA5KCqJyvUlqng_
X-Proofpoint-ORIG-GUID: rV1VLrPq6ciQ_giecbA5KCqJyvUlqng_

DQoNCj4gT24gT2N0IDIzLCAyMDI0LCBhdCA4OjA14oCvQU0sIFN0YW5pc2xhdiBGb21pY2hldiA8
c3Rmb21pY2hldkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gT24gMTAvMjMsIEFuamFsaSBLdWxr
YXJuaSB3cm90ZToNCj4+IFvigKZzbmlw4oCmXQ0KPj4gDQo+Pj4+Pj4gDQo+Pj4+Pj4gWWVzLCBt
YWtlIHN1cmUgYWxsIHJlcXVpcmVkIG9wdGlvbnMgYXJlIHBpY2tlZCB1cCBieQ0KPj4+Pj4+ICIu
L3Rvb2xzL3Rlc3Rpbmcva3VuaXQva3VuaXQucHkgcnVuIiBpbnN0ZWFkIG9mIG1hbnVhbGx5IGFk
ZGluZyBvcHRpb25zDQo+Pj4+Pj4gYW5kIGRvaW5nIG1vZHByb2JlLg0KPj4+Pj4gDQo+Pj4+PiBU
aGUgZW52aXJvbm1lbnQgaXNzdWVzIGFyZSByZXNvbHZlZCBhbmQgSSBhbSBhYmxlIHRvIHJ1biBr
dW5pdC5weSwgYnV0IG15IHRlc3RzDQo+Pj4+PiBhcmUgbm90IGludm9rZWQgd2l0aG91dCBnaXZp
bmcgb3B0aW9ucyB2aWEg4oCUa2NvbmZpZy1hZGQuIE90aGVyIHRlc3RzIGFyZSBhbHNvIG5vdA0K
Pj4+Pj4gaW52b2tlZC4gUnVubmluZyB3aXRoIHRoZSBtYW51YWwgb3B0aW9ucyBydW5zIDQxMyB0
ZXN0cywgYW5kIHdpdGgganVzdCBrdW5pdC5weQ0KPj4+Pj4gcnVucyAzODkgdGVzdHMuIChJIGhh
dmUgYWRkZWQgNikuIEFueSBpZGVhIGhvdyBJIGNhbiBtYWtlIGl0IHJ1biBteSB0ZXN0cz8NCj4+
Pj4gDQo+Pj4+IFRoZSBydW5uZXIgZG9lczogLi90b29scy90ZXN0aW5nL2t1bml0L2t1bml0LnB5
IHJ1biAtLWFsbHRlc3RzDQo+Pj4+IElzIGl0IG5vdCBlbm91Z2ggaW4geW91ciBjYXNlPyBXaGF0
IG9wdGlvbnMgZG8geW91IHBhc3MgdmlhDQo+Pj4+IC0ta2NvbmZpZy1hZGQ/IElzIGl0IGJlY2F1
c2UgQ09OTkVDVE9SIHN0dWZmIGlzIGRpc2FibGVkIGJ5IGRlZmF1bHQ/DQo+Pj4gDQo+Pj4gTm8s
IGl0IHN0aWxsIGRvZXMgbm90IHJ1bi4NCj4+PiBIb3dldmVyLCBJIGFkZGVkIHRvIHRvb2xzL3Rl
c3Rpbmcva3VuaXQvY29uZmlncy9hbGxfdGVzdHMuY29uZmlnOg0KPj4+IA0KPj4+IENPTkZJR19D
T05ORUNUT1I9eQ0KPj4+IENPTkZJR19QUk9DX0VWRU5UUz15DQo+Pj4gQ09ORklHX05FVD15DQo+
Pj4gQ09ORklHX0NOX0hBU0hfS1VOSVRfVEVTVD15DQo+Pj4gDQo+Pj4gQW5kIG5vdyBpdCBkb2Vz
IHJ1bi4NCj4+PiBTaG91bGQgSSBtYWtlIHRoZSBjaGFuZ2UgYWJvdmU/IEkgd2lsbCBhbHNvIGNo
ZWNrIHdpdGggdGhlIGt1bml0IGd1eXMuDQo+Pj4gQnV0IEkgZG8gbm90IHVuZGVyc3RhbmQgaG93
IGl0IHJhbiBmb3IgeW91KGFuZCBydW4gaW50byB0aGUgZXJyb3IpLCBvciBkaWQNCj4+PiBpdCBq
dXN0IHRyeSB0byBjb21waWxlPw0KPj4gDQo+PiBJIHNlZSB0aGlzIGluIGNvbW1lbnRzIG9uIHRv
cCBvZiBhbGxfdGVzdHMuY29uZmlnLg0KPj4gDQo+PiAjIFRoZSBjb25maWcgaXMgbWFudWFsbHkg
bWFpbnRhaW5lZCwgdGhvdWdoIGl0IHVzZXMgS1VOSVRfQUxMX1RFU1RTPXkgdG8gZW5hYmxlDQo+
PiAjIGFueSB0ZXN0cyB3aG9zZSBkZXBlbmRlbmNpZXMgYXJlIGFscmVhZHkgc2F0aXNmaWVkLiBQ
bGVhc2UgZmVlbCBmcmVlIHRvIGFkZA0KPj4gIyBtb3JlIG9wdGlvbnMgaWYgdGhleSBhbnkgbmV3
IHRlc3RzLg0KPj4gDQo+PiBTbyBJIHN1cHBvc2UgaWYgYSB0ZXN0IG5lZWRzIG1vcmUgZGVwZW5k
ZW5jaWVzLCBpdCBuZWVkcyB0byBiZSBhZGRlZCBoZXJlLg0KPiANCj4gTGV0J3MgdHJ5IGFuZCBD
QyBhIGJ1bmNoIG9mIGt1bml0IHBlb3BsZSB0byBjb25maXJtIDotKQ0KDQpPayEgV2lsbCBzZW5k
IG91dCBhIG5ldyBwYXRjaCBhbmQgY2MgdGhlIGt1bml0IGZvbGtzIG9uIGl0LiBIb3BlZnVsbHkg
aXQgd29ya3M6KQ0KDQoNCg==

