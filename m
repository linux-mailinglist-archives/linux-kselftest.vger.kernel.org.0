Return-Path: <linux-kselftest+bounces-18306-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A098489C
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A793285364
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Sep 2024 15:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7B1AB512;
	Tue, 24 Sep 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GWOR75Hl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Mej/JKLb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84FE1FDD;
	Tue, 24 Sep 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727191623; cv=fail; b=L4Kg+FasXWTDfBVWEBNyc5glmbgVvolL1V/xXCa+u+xOEWccvF3qHD273bmaDrg1lPjmPedvJv0AXqIQPwdtDyhOfol/ofMr+7I5SXd5mYeFJsQF6uNRi993iM3YDzwH3q/NXKYbYVRczP7TR1NSI74SM+UCgpUxTmlRvYJeJHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727191623; c=relaxed/simple;
	bh=wdH3zuJ75GSzWG22nOYs+nyrRWRwmRJvrSDuJ6++Cuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hbifif17fo2FPeEAhn6Qe32onbxuNlcLEyxa4xUTd63l0w7P3ms6QbCaYzSWhQQznXFsvz1ESE6oE8zLsRQz37yytYdEdeBl/eY+gD4Ptpj6tlwtEj2rRLCurxpxzR5gB2EyRZUHLd797lpryyf1sBvFeNvZASt/xvNW//rsCrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GWOR75Hl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Mej/JKLb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48OEQZ54032420;
	Tue, 24 Sep 2024 15:26:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=wdH3zuJ75GSzWG22nOYs+nyrRWRwmRJvrSDuJ6++C
	uc=; b=GWOR75HlD2TJaqlbiXQ7JH6FlJiYPjByNmNe7YADTZT8+r+kB2QO75vw6
	nHgQ4swPNFfs1yD/zjmeIKE0rss1cSJOnG9bTG/VKIE2YkqG4E7Oq6XyqsZWin0r
	H7lwEvIymsHXp0x1RylthbsCWQDkqpfXU5WwgoiS8G6rJxMHfleKmczO+Gjt/u7q
	4zcwbtIrIcPzZOLi5gChce2Vy7fKbDVCu3mMlVG1bFrB4sIJivwVM9j6UkYCPWQL
	1blGqwMBmhgW8ss/37pVN5Wyuc8+SFr/p99ag+vkapOuv08WiqDipVbio10b0CPH
	P69h1dKelwiSg2ndH6elXMQppHI/Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41sppu7sa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:26:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48OFIxjb038194;
	Tue, 24 Sep 2024 15:26:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41tkc5ykc1-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Sep 2024 15:26:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr2rv74HqIq+4rALpoWKdLGnJygcEqHXccc40LuE8omiMdSiX8AwA66/i2mx8MpjlLn+SA2YZ0GT16nPNJgtxaxacnoVpOv28qNnCcuUyBT2jDRGtHsWowdSEPdvSF9wiRnN9rQm+OT4Lqu4TNWrdBWHEdoeV8s4PVbPe8pqSpNejAIEJxz9Sd66t9J5CexD+OFNPvR44xgxYTWtyegGMTXD2x1qegY+OZqoSWJI3/qa6fOP7lWslTMaGlqz4WIxnFqNNU1qHGcbFkUJ9dpmtu59p7t1DgaG9B5Qs9QJrf2aYyiaPWt+eUVPYmWOYhDugrpiv9HqHzDu9g+jXTpbUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdH3zuJ75GSzWG22nOYs+nyrRWRwmRJvrSDuJ6++Cuc=;
 b=zPQx3Zb7AkbzjyGWJN5qUpjWwTocNsbuVUje8hTd+4ikKOQ6qcm7v2ZsFFqHtu670AKhRVZJ7izp2gW5thvp3J2UepBgbe3QSknX9Wjdwg848xlySQhiV7QhaVpW7CF9W9nCkRzEcdbiiGWnaxlzxz5nLC0OEUEQX2blQU1xbhgX7M5HoQDAVMLNkjL6J7wC3Ta6w9f1Imo0m1MHiAtTBqrdT4SHun+SLt3Dbc7vvUXpQYRCGSFP51ZUJBsXTWYMuQ3+hEo/CQ3kJX/M1o1OVzPzIz39fxEYP88ovn9Ba8QMVMdaQQwAcAvYpeB0uuwquGZ++dK3NhhW0TFC7/U6uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdH3zuJ75GSzWG22nOYs+nyrRWRwmRJvrSDuJ6++Cuc=;
 b=Mej/JKLbD8RrE7W3schPVaaDxZrkfkcfF0JZvNGYeOnj2Qkdnfclq8Y+w8bAl8cRvbUH7MIYP88L5mCS+JFJqWv0uGyzRbbCGCcXja2/5TTGC3NMAXL7BKMFNDLmEmUSam8gKCMbP/KcbQAOOMBS+YB0NtTZ+k2Gv32gydcz3Nw=
Received: from BY5PR10MB4306.namprd10.prod.outlook.com (2603:10b6:a03:211::7)
 by CH3PR10MB7211.namprd10.prod.outlook.com (2603:10b6:610:125::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.7; Tue, 24 Sep
 2024 15:26:21 +0000
Received: from BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b]) by BY5PR10MB4306.namprd10.prod.outlook.com
 ([fe80::b78:9645:2435:cf1b%7]) with mapi id 15.20.8005.010; Tue, 24 Sep 2024
 15:26:21 +0000
From: Allison Henderson <allison.henderson@oracle.com>
To: "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "kees@kernel.org"
	<kees@kernel.org>,
        "javier.carrasco.cruz@gmail.com"
	<javier.carrasco.cruz@gmail.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuba@kernel.org"
	<kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>
CC: "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH 3/4] selftests: rds: add gitignore file for include.sh
Thread-Topic: [PATCH 3/4] selftests: rds: add gitignore file for include.sh
Thread-Index: AQHbDoAuBW8C4C9yNEKJjjcSYvp9r7JnDzUA
Date: Tue, 24 Sep 2024 15:26:21 +0000
Message-ID: <8907d44e8e72be7c027a39ca8b2612d0dcb791ae.camel@oracle.com>
References: <20240924-selftests-gitignore-v1-0-9755ac883388@gmail.com>
	 <20240924-selftests-gitignore-v1-3-9755ac883388@gmail.com>
In-Reply-To: <20240924-selftests-gitignore-v1-3-9755ac883388@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4306:EE_|CH3PR10MB7211:EE_
x-ms-office365-filtering-correlation-id: 06fb3b8b-48ad-416a-689e-08dcdcad3e82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?czdRNEJlaTRQTDZ5LytwQTBKanQrRm51a3BJWUY0cWl1SmlSREQvT2k0Y2Zt?=
 =?utf-8?B?S2pPYUtnS3pkNHVqOUxaQzFPMmhOQUpPYU5QbVRxeW1qdFJtZ0pyUmw1T0hJ?=
 =?utf-8?B?UWJlNTh6L0R6dklSYk5iZmwxMjhiVzRBcjd2YTEvVnVMYXRjWTF2b1VwQzNt?=
 =?utf-8?B?R0R4QW5LZzhrcWkrYUpzMHVPdmI1a0lJNFlXY1JZR0MzNjd6c09UMEZBMWdq?=
 =?utf-8?B?bW5wbmNSOHpQWk42dGlrNkI5VG5nNHZKeWNDMUd4RTBJZjVDc0VkbDVYNmxN?=
 =?utf-8?B?cTBMOFNzanBiYjk0RTVFQXZOeTBBMkhGaCt2Ynk4ZG96bHAvanY4V3RBeDlE?=
 =?utf-8?B?ZVF2RWNYa2JkeTNaa0RJLzIrTElzZXBYdW9yeVJ1VjVDeXdZOFYwODVQQmgx?=
 =?utf-8?B?b0x4c3F4MnJWejZiMjNZSmxOeG4xNHNRU0JLOWdHYUx5SjFPYXNNU2toaWZz?=
 =?utf-8?B?bnhZTUFhQ2lkNW1EajFOb1VDZHlQSDMzRlg4WitzTmo2UEhyUU4ybzE2THlv?=
 =?utf-8?B?cU5taUk2QlhXZUc4MG9mUFJPaVFGV2pxWFJoTUZobFJ1WHB4d01NaHE0aVJx?=
 =?utf-8?B?d29POU8ybWxldHZuRytCWW9Ca0ZhZGt1ZjR1OGpZckgwNHpMZTN0N2Rvcklp?=
 =?utf-8?B?dmVjclo4cGs0L3hQVnNsZ3lBall6b3ZwaDR2M25zM05UcXMvam9XWU1HT0s4?=
 =?utf-8?B?aklQSDM4bmpIMXZJLzZHQVZDenNSMU5iK0h2NlpNdzJBUDUvempxQlFOYzY1?=
 =?utf-8?B?VVZIVmVQQzdFZkszeG1tcXZQSnh3U1d6dGdyS1ZXY2lUK3lpWGtwLytwa3FO?=
 =?utf-8?B?VWp2R3JJWWxXN2RPOHd1eW9EZU1iSk50NksyWnd3Q1ZIRVQvSytuMzhPYjVB?=
 =?utf-8?B?YzJSN01VRmJMcXFkSDJuUWEzd0d1U1J1MjBIU1BmYk1SZVBveWJma0hIVmxh?=
 =?utf-8?B?Q2dKNlFZUUJpM0ZXOFlFK2RaeUZFQ0RJRUVWbmdyenpZaGU5dUV3Y2pvSGQ5?=
 =?utf-8?B?cHczK1VQdVdkbkFxa1BQWmRPVzgvNjZNUHpTQ1ZNZGFEYlhDVWg4dDM4RmNC?=
 =?utf-8?B?MGwxSE1XeGU5eFYxanlPKzRkTURnTGcxVmNzam8zTHZ2T2crUUxZdDcyaXA5?=
 =?utf-8?B?THBsNWJHN3Jrb09uM1J0dmNjdkZRL08yTUxGTTc2ZmtEOFJqUkUxVEd1T3Fp?=
 =?utf-8?B?VHZURkRiR3BnaWFra3U0MFoxVjVtdVdlOUdPcU9samt5YlIyZGhwUkhvSWVi?=
 =?utf-8?B?N3VMd0lETmlkckljODZpWmtPZzBoaFFKNVJ4YkRKRm1MdUNUME9NYmdaNXN2?=
 =?utf-8?B?cXZ5UmFDWXMxRHFyamNud1lZRnFZY1ZmWkdlbmI0QTJBTWp2SFM5a0FUbDFJ?=
 =?utf-8?B?d3ZtVmFpMyt3U3UrOWNiZUZaeVo0SUo1aGxxdGFxdHZlRDRvOWhSRWdRVXNN?=
 =?utf-8?B?MXFVSndWa1MrK2FheE9hYW4yWENSZjg3c2I1SDdjQ3NhemlDelVZalRyZDdD?=
 =?utf-8?B?dTRYR1hFZXFGOGNmcTlsdXhBT3k1dnNwWTlJdE9PWE5ubXAzVEJKNVpBK2cz?=
 =?utf-8?B?MGZGNkZBWGx1bTBWdUpKRmhRbFl1Z0pyc1hLaFJtT3pTT2dOTCthaCtWd3ph?=
 =?utf-8?B?dCtkMkptMnliN3Y1c2YwME5NTkxtRHlQbm9EYlNCcGdCSVhUaWN4Q0ZwSHND?=
 =?utf-8?B?K3ErdThvZ0Zja0ZCQ3R6RlpiZ2lDbTUzcFMrV0llOGdtOFovOGZEd2xMTkFv?=
 =?utf-8?B?Q1RIU1dGL25OeVE1WXpOaXNRbTkwNU84S2l3eVZRUXdBemd1WCtmKzRkVVFN?=
 =?utf-8?B?OFhraEh3Zk1lb1kvVk56cThKSW9LVS8rU3ZXQitYVmxxbXN2amJUM2NuUWkv?=
 =?utf-8?B?aDFIcnNiUStvK3RCdGVuclZwR2t2ZFo4dUFXZWkyQ0ZqNkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4306.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXdYVWlpZjUyRW1EcTM4MWkrQU1vLzJ0Vy9GR0lrRGRzTnJlNlhJR2MwVXBa?=
 =?utf-8?B?TmcrTFdSNW12emRMU05DZGZ2U0hQbzNyanEyektBM1o5MlN5a25HdmpndTl4?=
 =?utf-8?B?ZkN6VFg3NEVaZE94R2k4QmRUOTBKK0NEWUhyaEEwOCsyVXRoK1g0aVd0Wndx?=
 =?utf-8?B?TUNDM3c5TkFlSmlmN0NUanVxamx6KzFBWEhXaWllZ3hhaGFiNDZCM0pzc0dW?=
 =?utf-8?B?ZWRmbkRPNW5mUldjeklSbXZFd0pPOXpNSXhEdlJYVjdDTTI2ejVCbEk5dS9z?=
 =?utf-8?B?a1JSNGIvVVBTVm00SzQ3Y1VuRURzQUlBSE5GSVI0Z1dGOEoxTGFOSnJEcmZl?=
 =?utf-8?B?RHUrZWpMUklEQy9aTTlxSXZHZklhbE1ibUNLeTR2Zm55RmRudC9lcDJtRHBp?=
 =?utf-8?B?aFJWUXNldE5ZdUNJaVhMRWpSNDUxNCtxRGhSY0d4MEZZY2xxZFdiRG1LQU1N?=
 =?utf-8?B?a3FRcitzOStoNUtDenFuSXhFenZIRXpZVUdpRnhnbDJNSC9vcEZlakRYVEVm?=
 =?utf-8?B?TWloQ00vMGZjN3RBV0szbG1KSG5jRU83bGVSQ2dXdC9FU2RiOGFaMklvU1B4?=
 =?utf-8?B?bnREMmNnUURmQmNYUDVOVENocDRDWDFMNXNCZGtiWVREMzZRVThacGloL01j?=
 =?utf-8?B?azhuZmhhRkpaNEZQRWhIQnREMEVvWGljMjRpYnB6WVdhZDVwcTFsSnVtNGRR?=
 =?utf-8?B?UUhwcGFEREV3RWlIcVFSN0xhc3hFRlUyK2FrWGNhNTZwV3JBQVI3NVF1ZCtj?=
 =?utf-8?B?aE53enNSODZ0MTIxd0JSdEx2R1RKdXBqY3NKdjIzSm5DdzAwKzFvN0dZYytH?=
 =?utf-8?B?ZEVjYUR6WDk2ZDlNeG5kNXJhcXZQM1poMUhydlZCWDVBTERTRHllWERDeGo3?=
 =?utf-8?B?UFg0cW1YNTNub1dNamhIVnNzejcxNUJZTE1hVlJXT0NSNS9PcWxqald5NFdY?=
 =?utf-8?B?UXpvMUJpZHdQd2NjM3NhcWFCb0NLWDdhdGhRbXZmbldSRUM5UnFXM3J6N00r?=
 =?utf-8?B?Y1NMejlFVEhnMWZxRGkrQmV1Tmo2d1VGNGFVaWMwYnh2dkFvNUtoUGlSTnVO?=
 =?utf-8?B?N3dhOXpLbVJ5OU5OZGJxZHJ0T1dNOE1nMU5QZ3QzeGhnVXMzMmdMRFVraE1L?=
 =?utf-8?B?Wm80NDh5TGs3RWdjRXBWd0pML3ZoSnZIR01WVXFLWWFKd1Q1TjkwdnhQWHph?=
 =?utf-8?B?NEIydk1BY0hTV2lQUVljaUFMMUZwdk84YWgwVThmOVpsTHVtSjhORG1JVTJy?=
 =?utf-8?B?MjNXUUtjUlYxaHpMSzY3NDdqOHljOVU2R0ZncjRHbEI2aXJVazk5eWFZelli?=
 =?utf-8?B?ejJ2OEhPRmJWeWJGZktyVnIrVXBDd2ZBUnh0NkZRbkg1ZytIUmEzcFlMM2RM?=
 =?utf-8?B?YVBhejFJcnBpcm8yYnZ2QWRONnlQSVQ3SUp3K2F4aUFFY1F1UStsV0IxaWwv?=
 =?utf-8?B?akZVblVvZzF2OFA3YW5tdmh4REREVXkxVTVxSE1ZUEI5MXhzSitPTHR3emZk?=
 =?utf-8?B?c2ZYQ0QyTnRiUmVJWEYySFlSenFCRE1FQ2lBRkUwUG5aZHRSeStGajF0YWVY?=
 =?utf-8?B?ZWJUWHNwRGd0TFZBVXB1SVFKK1VBd1dub3Q3elFJd0xiU01TVlhWL1BtMkgr?=
 =?utf-8?B?N3VCK2FoOWQ4UzdOOG54RjUxVzljbEhwL25KckVjVzZ5bFpva0VOamc1dmZI?=
 =?utf-8?B?cmc0MVpIbndPTGpjaEsvZnlBaDR3RXhsOHVRZENDbVJSYUc2My9FWnJINjFE?=
 =?utf-8?B?b3BQZ1oyYkJWeTlnbHVDZVJjcUh1VnRwWkN2T21HOVZtUzd2aGN1TlZXY3VU?=
 =?utf-8?B?VndWOWlJQjZ5QmRXQkJIb1Y4Y2wwa0tjVzUxZkpHS0Rwc1FySDZpY0R2S0R3?=
 =?utf-8?B?Mytmc0huZEVQMmNwb0VTeGlPNXhjVW90aUpZejNDbmRjbHRITDNMd0JYRk5t?=
 =?utf-8?B?b05IYlBuV3lUd1BKTTE5bkh2dWVzdEpmZll1VC9ZUFVEeXAxVUFGZ2JaRUps?=
 =?utf-8?B?OU1rUDZZbXE3RkdCVS9ldGhXcVNjYlFSbDQrYUJweGxiQ2dOM0xRMDVqSXhr?=
 =?utf-8?B?Zk1HZXRJWUR2T2RBUy9SNU0wL1hjWVdONUcvVzZNc1FBTjdaUmhhUTBCNTJo?=
 =?utf-8?B?ZDJEaVdSZ0xCSlRuODFNVHYwR0FnVFpHNjczZnU5dWZsdmxMZmJQczdMdTV6?=
 =?utf-8?B?aUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <843891EE7C41B1478AE90D0EBBDDCD04@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6Tsg/dWyyTjWp9o+d/aDO7dswBCQGbM8pV4d4JG/GO1I7xaGEjTtod7cYsui+oVX6En1EWF4rbtoO/0Dwkzr56PqSdZXdcXkYq+uP8GcWdEPxem+6ck+DU/6+YNytRW7iBdRHs7DcROlvOsg2/aEoIOKwK6N6NKOBZRYmPRUTSBkMuYtCM6161L7nD9Nu5ZYpuYZZaVJ/0xpGUhN0Br0ON19jl022qLkNrb4vDJYOkQEvwzupnuAirl0H4E2egsCJ9BRIVquYSuiIRZgJcFFUOCIcMNYkOSDJFz5GOJrAb1+ZrNraJJVpVSZfToW+zjA/2sydMSdS2HaEfNbhtizo2Vb25zZW5ZUt/45pArR33uyfHr7vq4xWGl+fD1XWSC2dJJcJfW1ZojUGGXj9DZ/qoZfxtQdFieQr8kJaZjfVMm4CetPEAuEOGzcQaomyk6SdnN8wTu7M/yZ6ru6xYl7U91b5sq2ywqLetpk2/PJdn+RI1roJDrl8zrNU47FWVkOzL76HkzVaCoDf2lbS4kXP3zkhJyDDoyNp14Y3uvpOObX8KQJjmYf8qDTFcTaQ+vQUgAPh8/ZqzVo3ACfgGpY9AW/+d+Vsc/mnwnYLZO0I/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4306.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fb3b8b-48ad-416a-689e-08dcdcad3e82
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 15:26:21.5781
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/ZQwxDw710vzzutoMWIyPOW1zp0M4Ol4V1vBn1tC/bkNN2lPWPchhkZvz44LVQ4lfq50dy5sKt1KHnSCH68Q17SsOLy4nRtOCtGU60J0t0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409240110
X-Proofpoint-GUID: HI50aH0F2k12znxyj-gCQS0Zl8FuzW9l
X-Proofpoint-ORIG-GUID: HI50aH0F2k12znxyj-gCQS0Zl8FuzW9l

T24gVHVlLCAyMDI0LTA5LTI0IGF0IDE0OjQ5ICswMjAwLCBKYXZpZXIgQ2FycmFzY28gd3JvdGU6
DQo+IFRoZSBnZW5lcmF0ZWQgaW5jbHVkZS5zaCBzaG91bGQgYmUgaWdub3JlZCBieSBnaXQuIENy
ZWF0ZSBhIG5ldw0KPiBnaXRpZ25vcmUgYW5kIGFkZCB0aGUgZmlsZSB0byB0aGUgbGlzdC4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEphdmllciBDYXJyYXNjbyA8amF2aWVyLmNhcnJhc2NvLmNydXpA
Z21haWwuY29tPg0KDQpUaGFua3MhDQpSZXZpZXdlZC1ieTogQWxsaXNvbiBIZW5kZXJzb24gPGFs
bGlzb24uaGVuZGVyc29uQG9yYWNsZS5jb20+DQoNCj4gLS0tDQo+IMKgdG9vbHMvdGVzdGluZy9z
ZWxmdGVzdHMvbmV0L3Jkcy8uZ2l0aWdub3JlIHwgMSArDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEg
aW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMv
bmV0L3Jkcy8uZ2l0aWdub3JlDQo+IGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L3Jkcy8u
Z2l0aWdub3JlDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4u
MWM2ZjA0ZTJhYTExDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdG9vbHMvdGVzdGluZy9zZWxm
dGVzdHMvbmV0L3Jkcy8uZ2l0aWdub3JlDQo+IEBAIC0wLDAgKzEgQEANCj4gK2luY2x1ZGUuc2gN
Cj4gDQoNCg==

