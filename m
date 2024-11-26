Return-Path: <linux-kselftest+bounces-22544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 935969D9E32
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 21:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52507283CCF
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 20:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604791DE8AC;
	Tue, 26 Nov 2024 20:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f7ZfgLte";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FDZPvFve"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727FB1D5AC6;
	Tue, 26 Nov 2024 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651489; cv=fail; b=ksfYcpEKO19tHH0HhjLlJOG0ni4DNmiNkXIQrCNLdchw7+xuv7yxXjXTqiR8+uN4j+bbOCot870h3whU8S8ojhGHhNBn7bp3hDCYdB7nysMdy928S/4yTPZMcOvU607mxjI6++qPbc/AEn746AgcFs2Qb0SlqYM0TTpaGBmhZUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651489; c=relaxed/simple;
	bh=RaWLCgcYxZqLDm2egAetq8TjsOU25Q91EfeQ9l2gvyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JGnfAbQ13PgiVNXDR3Z4Z547X7kZkK4LFv8EHRW3/Zk42pWs61qR7zOPliGQb75pmjRg/ubr946ZsAs3PgsCfZfOZNc5o3LcBgEGC//obDEDWgGf6IYS2E54sOp0bn/DfpOYRbqxhbjKsqti7b33fmScO+gSrJZnftNFDSneSL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f7ZfgLte; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FDZPvFve; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQK1bhP007387;
	Tue, 26 Nov 2024 20:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RaWLCgcYxZqLDm2egAetq8TjsOU25Q91EfeQ9l2gvyY=; b=
	f7ZfgLteKauJDgQg02xjNjx3niQLt03c2QfhUyg4dga+UJhs11o/JT0Tqf0unyvt
	G6LX58qedZ4VsOFcqP3FCrq1gZmCl7fxwHzXWfO0fXG2KVo3+v9G7Acwpix44tCj
	R5AvCtKMuRSZWzl88p6Eep2S/OiDnkVX7tMjP3X244ECW6MGwvQvtMxrpRYgWlUl
	cXpJEV6PaHhr+feauc/3zZzMdyLUzzgb2x/ZSEjLT8DcXn8aXWm2RAALYVbunOgI
	G+Km0HJIVd8/+tbyG+lRF6uwsylGY3OhD70lmgu344Vy8r+HtEZKwcGO9uznRmMJ
	go/SfFm4BSYYUSrN+AyZHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43385upc8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 20:04:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQISZwP027042;
	Tue, 26 Nov 2024 20:04:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gfwxn4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Nov 2024 20:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ICiCiaQL3EVgYWyQdwiIU4ezfWrxnX0jD/zSauk9q1uPtwfBfw2p+GM+Ro+FKFSceTVSxk5cVOMxYew4Hav5vR0lZxGOdqRALEqp4kGUwBg6VHe+f3BTK4l2EQp6LQMnSPXwK+Bu6bCkvJaAnynnpFndmi1z4xO1+vRSX5Nuz01aZux+eIIENM89Bvu86wdAKVPE/x4F87ydHY2FqcKkDogTAK6Uq8+3aaskF7mIGgJcTCyDG6rUyfxjeqDCYqEaMyLC0UrKk+OG1TCJKr4JX/k+nBwNO0W7nsG8olmZVoGwnlBaaOFkamW1c5dIuC5hy3M35QfGrrpYo3Jg2Ds4uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaWLCgcYxZqLDm2egAetq8TjsOU25Q91EfeQ9l2gvyY=;
 b=jhmatIXOj3DAthzmmyWn6Ape7IG8gKW2W+g6m6QLbszlCtBFzMDaQly3USp8TEojc3BNvICvh7Rf0RD5XDcy+vZ6Zt3fc0VW/JYUa0nm20hZKuI8pjfYCAhAJJCLTOw3tvO4T/hipKtmMTUx85qXGpiiDlgzja1VdywUKez1+pQIvbatgei5BoMb6lTPzTb+FqdW8gurDkMDv/MKTO7H5SZ0RlA+afUr94OasL63+cnWHP3hapHCL6uO7/RuXMRVQj8fcC7YN8T3VaBA0p1QVPFE1G8n1Zx2pKwOJ+LTZGoiEyPDITXI4EYZXZHpn9xaf6N8WqqVvhz6gvoHLIdDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaWLCgcYxZqLDm2egAetq8TjsOU25Q91EfeQ9l2gvyY=;
 b=FDZPvFve/41zWenIOEDVoJ44s9LHgD8MkPIV7o9NsNzMujimQ3jxsj7rMBsue2JuYaljPX4t+wadQy1AVIJCBNzl4kYJuVV7KaGusHVFNs0JPtX1IEb0ex2PV78pTIb6JszbLyB4oSyLCDZdN55yJchoViOrJHJo1s9H0N37I04=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by SA1PR10MB7753.namprd10.prod.outlook.com (2603:10b6:806:3a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 20:04:32 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%2]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 20:04:32 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>
CC: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Vegard Nossum
	<vegard.nossum@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "rds-devel@oss.oracle.com"
	<rds-devel@oss.oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "mheyne@amazon.de" <mheyne@amazon.de>
Subject: Re: [PATCH net] selftests: rds: move test.py to TEST_FILES
Thread-Topic: [PATCH net] selftests: rds: move test.py to TEST_FILES
Thread-Index: AQHbPkMaLRwqBMJl4kuzWiTQdRloWLLKAEmA
Date: Tue, 26 Nov 2024 20:04:32 +0000
Message-ID: <0648385f8654381778b2ceaefe3204d2726f439b.camel@oracle.com>
References: <20241124073243.847932-1-liuhangbin@gmail.com>
In-Reply-To: <20241124073243.847932-1-liuhangbin@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|SA1PR10MB7753:EE_
x-ms-office365-filtering-correlation-id: f9d63d5f-998d-41ca-d695-08dd0e558afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?L3Q1WWR2TlhDSGVDYzAzRmpZQk1IRVluK3JiOEcyaW9Yd01VRWZPMEtmbGR3?=
 =?utf-8?B?M04xM1hpN285WUxNU0hXRy9tOVpzeTdndXo5Q1lvamx4TElWYzZ2bEY0STIv?=
 =?utf-8?B?Q21ZVXF6SHRUUlVCUGVyTjNUckp0dFlYRkVLYzJGb2d5dnJMMHlJNkNjRkgv?=
 =?utf-8?B?K282eG4xQ2lkdnFpdGdLTHpqbTdGSDN6RU9CWHVMdzBoSitJVDF6WExBb2Fs?=
 =?utf-8?B?Wi9RSEprd0lOcGo2OXY5MUpDaEhtS29mTFA3MExzTEZxR1RyR3gxckpYaEx0?=
 =?utf-8?B?dzVWQWxCNFA4SjAvN3k4NWlDUEo4MndBN25aRzdFSmZmK3lHdkZyaEIrK0ZU?=
 =?utf-8?B?cXM3L25kOXpwVHdCK1VHeW84RktYanRuaU42SVdZczJZTWNFdUJoMExDLys1?=
 =?utf-8?B?Y1pTaWNUeEh2WEdyWjNsM0ozbURLRXN4SFBIYUd3TzdobUZ4Q2hXZXdKclht?=
 =?utf-8?B?SFBwdmkvWHp1cW1mMnlzbkdwUitwRE1zZFcrQTQwYmt2SURMQlVhWWVZME92?=
 =?utf-8?B?M3I0VG9YQVRGUjR1YmRWR0ZqRlhnRy9HZEZIbWlGZ0VVQ0xwQVMzeDcrSFpV?=
 =?utf-8?B?dUM1RnlFc1ZHY3NrZXBqZ2dRK0E0OGV1aHhLTjA4VXZXRXh4a2lXUGlLOXRw?=
 =?utf-8?B?SHhXY3c1bWZER3ZXRmVMMmw3Q1F2dG9neUJ6Z2JXZGVyd2tUSlMyaFI3ZzJO?=
 =?utf-8?B?L0dYVjNmdWl0YUJhTVN0Z09SellmNHpYak1kZzNuaWVZUHRWUzJjQTd5N0VY?=
 =?utf-8?B?dWl6Z0Z3cXQ4djUvSG5QcFQ0MGJZb2Zhamw5RFVhaFE0RHR5MkphaWpBeEN3?=
 =?utf-8?B?RVJNUSs1L3dibDhLRmNKNXl2WXoyRVdiNWJoWHp2ZHptdUJvWGtCNHZ1Z2dL?=
 =?utf-8?B?Sms0R3RMMmpmcnJ1MlF0cWY1THJMWVRxR1BsK0lmNXF1NmVMd1hBWUNMWHpF?=
 =?utf-8?B?dkxsenRIVDNkU2lkNFJkOHlkdnpNMTFjY2ZkalUzU2R5QzY0T1J0aTdhOEpi?=
 =?utf-8?B?Wm9FaTAzeXhMV21vWWRBWUo5cEVXaXNNd2J5Yjc1ME5wTzNHK1hyRWJjNFpR?=
 =?utf-8?B?U0xGMGN0VmZEeDZjQU11dDB3UFBtRytwUGV4QVNBRWRIaUw4eUIxZDA3MkFG?=
 =?utf-8?B?TDlPWXZENmZCZGMwT1VVYitxd3Y0UlZZbjNzSExOcU1hWjV1NGE1OE5BRVdY?=
 =?utf-8?B?N3BLY1NYTThVbW5RUGFOT0pUdzFRVHFFeGxVTFM3QUQxRll5YitkcjBQOERs?=
 =?utf-8?B?SFQ3cXE2bkh0azVvRTVPaTJDYVMySytacWJvYnNOUWlLU1RJUTN2RFNjayt1?=
 =?utf-8?B?SEdnVENZUTVBZ1NpZ3lUTkFJN0ZRQnZWTFo1VWRuQllFYk9JQUt2VURDOWd3?=
 =?utf-8?B?Mmd2TlEwbkZCOSs1L0FOM0FxTGlHZGdZdlhlb3djREptcXZlcjVvbkN2clRV?=
 =?utf-8?B?N2pDVHA3N3JZTWY0VFJCZllUdi9oUUNhL2xUMVNRMTVUbDVZMDE0MnFBaFNi?=
 =?utf-8?B?Y2lsMytuUWM1NlJ1a2kxMjJ3QytNRTkzdWVDMTQ2SndzalZ6aGtMdnAxV2c5?=
 =?utf-8?B?ejZDaWhmbVlaRzFJcGlxckc0elNjdEtQUDcyTmhjRTVrQUtaR05IaGxoUjJz?=
 =?utf-8?B?OG1HQ3MvdXVianZXeVJWMitxNjBBeTdTRkhQdXJVSUUvMnRkNUpBZmQvRzVU?=
 =?utf-8?B?WmhqeTlBTStDQ2QzMXZvelFLYWlta0h3NHI4WTI1K0RUVjhwcjVFWEZaLzdn?=
 =?utf-8?B?MjVuUnE4SE5nVVZ2R1R4UzdFZ3ZXQnU1TEV5a05GTUlkclkrUnE4Nm1FUW45?=
 =?utf-8?Q?VBxcNIpm3g0ISJ7i9dI4PMLaGKxD3Pe8a5Kqc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TlJudmNITjFlWVRyN3hobFRhdnJ6dVI1NGNCUG5OeTlRRUNKelM4NEdUSUxo?=
 =?utf-8?B?djNmV0tzeDJQZGE3dXV4ck1ZakZBNU8zWEphNG9CbldKUmp0c0s3VXN2U1R0?=
 =?utf-8?B?c2dYVzg3WjREVGoxTUJIK01jV1VDaXhlcTNjWVhBdG04MXY2SzlvbE0zL01Q?=
 =?utf-8?B?ay9XeXZhRHN1cGg3VXpkNE1RTTFsY1B1SW5pUjR0TmQ3QWlRZUhGK3U2M0VW?=
 =?utf-8?B?WnB6MWdZVTRtbHc0YjFnSFhJRnU4NXQ5NExBSWlPV3llY2o3Yk1SYitEanV0?=
 =?utf-8?B?bWhFb0dOQWV4RWZRaXdJaWZJZVRROExiYm95T2RJcWdRdHlBWkswU2NlRmRx?=
 =?utf-8?B?ZE5VMHRYNUw5RzRyUkI1dUQ4VFN5Wk1ZMTBRUW9paGFpREFJRm91bjQ2eG9m?=
 =?utf-8?B?ZlF2THltWjhyUU11WEZ5MVBoT2krWU5xYkRvb1VaOXBzY0RaKzJ2WUVvZGFt?=
 =?utf-8?B?bFZEZDFaQXdWZmZHTlgvZ2Jqd3JPcGJJWlphY2lCTUR2MUlVdlJkNG1HSWVT?=
 =?utf-8?B?czlYejJaWGVPd3haMkF1V1N5K25BOEFsSXNBOUdRMXNZaFArMzBERy9ST0dD?=
 =?utf-8?B?VG9pL2ZpOVhqTVE0cmEwelNFYjREbk56clVWOTVXUmJldDRBOWI4bkdLdGJJ?=
 =?utf-8?B?R1lTeWVqRnZvWG1TYkpxaFJtMC9jTU1mUlhUT2Z4bjJNRkxqdXJScG1nbGJF?=
 =?utf-8?B?MEZROXhQYnppWG5TV3EvdzFvSGZzdmNMbkl4ME12Y3J5QndPTFpMbW5vMEgv?=
 =?utf-8?B?ZTkwQlVOTzZWdi9uZWdaQlBzKzM2VGYxVGU3aGc5N2JQbHk2TlVkSFhWeUxo?=
 =?utf-8?B?N1RGVnhqVTQrUWgzTGlDbmpaNndFZmZ4OWRNdzJRVHdibWVoVnNFbHpBbGhI?=
 =?utf-8?B?T01GUHp5a0gvbEdiYTV0b0FnSDBUbEhpZ2FzQnRiTVB4WHFjYTRac0tVcE1w?=
 =?utf-8?B?ZHREd0pEd0w4akJrWVVyV2Y5TW45aE14VXQxMlJQMlJUeVAvZHlEVVdGenN5?=
 =?utf-8?B?TnNzQitzSjVXZW1mbThKVXhyNURtZFNzZkpneW0wRnJEWDRqSitIYmF0RVlU?=
 =?utf-8?B?VmE0ZGxlUW9BSHFMNkZVSERMZXN3WlpIdXlkZC8yWmlkTk1SVDBzR1hLR1Rp?=
 =?utf-8?B?Q09lNU5SU3IzZmVMcnRuZjBiK0o0REpHcTBJb0RYUnNORlVwci9Bei9keFBD?=
 =?utf-8?B?OVUxNG4yZWc1SEZ2TjZYKzJmZ3BpWE10OGVXRmY0VDRkcVZHd1dlOVpjazZH?=
 =?utf-8?B?cUV6ZlIyVUc5VmwyMUE3VHZhbHgranRNVXkvOWZKemI2VXloQ0dva1lsOUJB?=
 =?utf-8?B?bFhSM3Z5RUdtZGxhcVYzZEZWalV0NklsUjRhNzdWcUkwdXAxUjlRdzYzb0R4?=
 =?utf-8?B?R0FHd0JMRUpYdVdWSFpsUC82dXU0TUtTMmE5WFJCdHV5QlN4OFlyV1VkZEJD?=
 =?utf-8?B?SXRXcVZaUGV0YnZmbWFkOGF4VkVab0hxUVlOd2ZmNjEramlKeXJpck4yN3Fn?=
 =?utf-8?B?aUZYaUNmTk9SUGVHMHozU1crSDR4QkFJY0pTUjYzN3ZlcXZRTldOZkhXVmFH?=
 =?utf-8?B?emRKWitWWmFtSVpvUlN6Nk1GT2c0TlV4UXdUcTJuUzI1VEJDcE1zc0tzNlNM?=
 =?utf-8?B?d3V4bEtZM2ZJdkMxL3g1c2FkTzJTRENLWWgvVmlXbDltS0VmUGdOWUZMN1Fq?=
 =?utf-8?B?U1VheXpkSW1KNmVmWWZZclBGNXdMWlM1ZVZNQUtMeVVLOWIyai9GT1FPSjRU?=
 =?utf-8?B?SVA4bUpxbWROa3NUajlIc2pmTzM0ckx3Mit6YWNqTWJLV09udmUyNEo0Zzd1?=
 =?utf-8?B?N0FqdDdnb0wzY0hwWE9lRUhYK0lPR1F4U0FBcnBsVTNNSCtsdmllbWpETitw?=
 =?utf-8?B?OEh0dE9BdEFwbjloQkN4NVdlUXRuSXNHdTZkSjllTzJjYnhsZUxlTHh5SG1S?=
 =?utf-8?B?VEUwNE9Vb3gyMGMvZnJrUnVZOUxVNCs5SlY2MXBYdm80T21jVFpHNExvVjFT?=
 =?utf-8?B?eURFOU1Bc3Rxdmdib01VeFFqaldJZHJGYXlzc2syOXlLeGgwSEF4RE02MlNB?=
 =?utf-8?B?L2EzQUM2THd1SnFDWFBIbmJ0MTNSeFFOWEVaV2hzMjlpbjg1djQ0VXRRamtt?=
 =?utf-8?B?UWtPRWkwNUxnaDF2cUlxWWdiN21pUGorWlJxU3Q1Y3crSlFkVmN2WkwwWGQ4?=
 =?utf-8?B?VDFoeDJ0ekRDMmxlTXI2azI2NUZmaWpWai9nRWNEWitsNis0NThGMVpFUUg1?=
 =?utf-8?Q?TKoybw2fk9cuGd17o/5wY5jhAM1arbGvABfKKZglW0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D8FD98E53D2D804D809BE5DDD23F1DE1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pbeQUQYPLvNj3yfcf+4Ahg6kmMOtWQ9mm+JmHP4L6Gsi4iJXnDs3yTPO5j/1qAQqs1hIcEqGnF+9F1XOrmU0v65JDFc9VKAa5QgA0jkmOoYq8tzEFE0ww1ECQkM3gbP0jp6XsoWREC1YY5UIBO7D4UzGrOXlN9QGb3vFeTHEVgZGkKMh4XZj9GYw1Hqf2EQbxE6wLEDULOFJDz4JZ8nJ/psCEXBlM6PP2ay228fDQ8UGRL6IfFTBhQsRbh06Sz/h7JFUqbZcxN4pPTEzejF3pCWTte4ddCFLS1MkQ70czUPTBWjhYTKtS8B0HxlOkL/MGEy5ke6d6QBiku+dGR7Rv2UI9MFmSgPvn7ri7c0rrTntrpK2WOsrrhLerzI+nI5unu358WX6J0JSbuEtsFJuJ8APLCJovxZu1aHVZF2o5Tt8KIJMmH7PzqTd9ZVT95ow6o1xFiXJClJsu8+uUvpXyOFw2oWEYsrW35CkDS8Q8mtZha0I9oNLtwk6uVzI6EsOIqySNecKt0Dgl3LZYkdMAZq3QdUklc+T7O4iZPCHWLyE/QfIhGIKnyKySjvtQwJ87bCs3fFHx1iKsXLDTPXuKH84u3eMTzmegOddFgJTqLw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d63d5f-998d-41ca-d695-08dd0e558afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 20:04:32.3340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wItwyL6HsQTg22yeaOxU0gquN7IdSdtRehS7hKP1//JdXYmxJc7aohEe3QRKy0OCaSUePBivqQSBT659/F5OxxgZCPqV/tcazK0Ok4mIX1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7753
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-26_14,2024-11-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411260160
X-Proofpoint-GUID: ChNWdBlBu18E47iRMeMx7UNjZbfJoEyM
X-Proofpoint-ORIG-GUID: ChNWdBlBu18E47iRMeMx7UNjZbfJoEyM

T24gU3VuLCAyMDI0LTExLTI0IGF0IDA3OjMyICswMDAwLCBIYW5nYmluIExpdSB3cm90ZToNCj4g
VGhlIHRlc3QucHkgc2hvdWxkIG5vdCBiZSBydW4gc2VwYXJhdGVseS4gSXQgc2hvdWxkIGJlIHJ1
biB2aWEgcnVuLnNoLA0KPiB3aGljaCB3aWxsIGRvIHNvbWUgc2FuaXR5IGNoZWNrcyBmaXJzdC4g
TW92ZSB0aGUgdGVzdC5weSBmcm9tIFRFU1RfUFJPR1MNCj4gdG8gVEVTVF9GSUxFUy4NCg0KVGhp
cyBsb29rcyBmaW5lIHRvIG1lLiAgVGhhbmtzIGZvciB0aGUgY2F0Y2ghDQpSZXZpZXdlZC1ieTog
QWxsaXNvbiBIZW5kZXJzb24gPGFsbGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQoNCj4gDQo+
IFJlcG9ydGVkLWJ5OiBNYXhpbWlsaWFuIEhleW5lIDxtaGV5bmVAYW1hem9uLmRlPg0KPiBDbG9z
ZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL25ldGRldi8yMDI0MTEyMjE1MDEyOS5HQjE4ODg3
QGRldi1kc2stbWhleW5lLTFiLTU1Njc2ZTZhLmV1LXdlc3QtMS5hbWF6b24uY29tDQo+IEZpeGVz
OiAzYWRlNmNlMTI1NWUgKCJzZWxmdGVzdHM6IHJkczogYWRkIHRlc3RpbmcgaW5mcmFzdHJ1Y3R1
cmUiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBIYW5nYmluIExpdSA8bGl1aGFuZ2JpbkBnbWFpbC5jb20+
DQo+IC0tLQ0KPiAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtlZmlsZSB8IDUg
KystLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy9NYWtl
ZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9yZHMvTWFrZWZpbGUNCj4gaW5kZXgg
MTgwM2MzOWRiYWNiLi42MTJhNzIxOTk5MGUgMTAwNjQ0DQo+IC0tLSBhL3Rvb2xzL3Rlc3Rpbmcv
c2VsZnRlc3RzL25ldC9yZHMvTWFrZWZpbGUNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVz
dHMvbmV0L3Jkcy9NYWtlZmlsZQ0KPiBAQCAtMywxMCArMyw5IEBADQo+ICBhbGw6DQo+ICAJQGVj
aG8gbWtfYnVpbGRfZGlyPSIkKHNoZWxsIHB3ZCkiID4gaW5jbHVkZS5zaA0KPiAgDQo+IC1URVNU
X1BST0dTIDo9IHJ1bi5zaCBcDQo+IC0JdGVzdC5weQ0KPiArVEVTVF9QUk9HUyA6PSBydW4uc2gN
Cj4gIA0KPiAtVEVTVF9GSUxFUyA6PSBpbmNsdWRlLnNoDQo+ICtURVNUX0ZJTEVTIDo9IGluY2x1
ZGUuc2ggdGVzdC5weQ0KPiAgDQo+ICBFWFRSQV9DTEVBTiA6PSAvdG1wL3Jkc19sb2dzIGluY2x1
ZGUuc2gNCj4gIA0KDQo=

