Return-Path: <linux-kselftest+bounces-19751-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A876D99F29E
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67B102831D0
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BE1EBA0A;
	Tue, 15 Oct 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PQriDUIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ouEpbiDB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01D613B284;
	Tue, 15 Oct 2024 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729009400; cv=fail; b=G7ugnp+WrlxPIS3zvIlbjGD8ttCbbH6oeaUtA6sCTCeOx6HdXsXHqAxAbcJUn6hyMgcUp5Lel2a1RBFY6gDaRwB4eY7BUGrQkFPN6UTRZCufvLPKjkwlALxoAegF09f7G0CiD1s5AyCLVVxn5xqktt75cTA0rQp5OldoKEOozeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729009400; c=relaxed/simple;
	bh=Zs56j2kBQS4skFDnxfe7iq+X+GhZME+fkSFw+blRZo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOQOk2n37LK/VHw91OrKCflnCuiHpqQuYPk/3t4H1bjFsj4sWAdI6S6n9l2vZ6GaIqeXKCRu4d5wRVYWfMu28Cci6DeEITRnWFsJ8+ac5PVdJDVwOGJZwi6J8AIzLm+F3IU2DJXOhg9mx5S2sBXOzbMtqPzNfTHr81xHB/2mrl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PQriDUIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ouEpbiDB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FF0aGM005033;
	Tue, 15 Oct 2024 16:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Zs56j2kBQS4skFDnxfe7iq+X+GhZME+fkSFw+blRZo4=; b=
	PQriDUIP7iBDxwHrRigL4FQ32ErYx86h12+bQBDrydfqDiRbvqzd+WXetQ76kOUF
	zub3bPov0ODRkmDpMEQxeWOXj7KDmGsKqOGTSkSilXpXr1oe1o5yfwJ+HQSt6g1n
	RDD6qTAZun9GoOL5OTB9Jk/4EpB+m6S09U0XH8ijpTJLAg/+ouRVDWzUmHz/iSQP
	xA/eMtMUAPZi29xtkPmUglUBbj8cyddPJSPVJoygsDU4RItGx/qOHgLQSI8q5LLp
	VOyuByCQnt63Wk4rFVO9m3EsuebcYfpQlasiosV2+pWMc93tartb0Id7kSQTc2er
	qDLepGBMBu0YRi1kyFBUQQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5chuua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:22:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FFWMTC010979;
	Tue, 15 Oct 2024 16:22:29 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjdytrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:22:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rST+yC0FNlYkYEE4SkNIMHqJtogdm7gwhPYwKk/+EwD4c5hzifVYm/39jkE+xUzRtMM0Sx7w3uARGZTpdQHQbSkzjgmx2ABO9eWDOQ8I0CbKEzWW1gobWcq/dVe0CZWN2nxG2C1uUwpRIGuRFEP6Xahh2PUiMq5etsso+sSHHX6RIp+drXfGa+4OTDzrEuEi10/++KFcB0V4BcsdxoFLVb3joD1Ll4LYCe7i8ou8gYZeVG122HYR/Ady1raKga0fhJFYhRIkYRMNmipGNUCmFakrLEFJ0jKsiWxv7Irf99DH2RAJ2I4htmXG/30vDGJtfztegRd0AHtWBgCEvdCtsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zs56j2kBQS4skFDnxfe7iq+X+GhZME+fkSFw+blRZo4=;
 b=pFenfkeORNK9X7Anq87hkABjk9IqMvr9MkL1UqfigkivfNsBwCBBAzBobXEVdzf5Dj1fDUQlxwjLvnowaOCev96F3kdGBFImNBK4j3BP/5HSX+7NuVG4OeQgynCE8Wy1bH+fKXSPxd+xestLs0FiQg82lRq2cVrCQLIACwIPAKLYtQwCTlFEIyKqttthPGxcCQO1ci5s9Y+fTanb9PXCFzpbmcA5XqzcDJVJXv/uM465Ft62KYW9dJ7aZpeDgO3PzWbDyiM6ePMworRgWg//j8iOTlo+pyJND0k/54r9+bRQrTfS/NeqyQsJk0j42zQtj1tzQfAU8Kc+gEcejO4EPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zs56j2kBQS4skFDnxfe7iq+X+GhZME+fkSFw+blRZo4=;
 b=ouEpbiDBXrzpXs+cKpuB9+GYyKDg8pzIVdd8DxaekbSQwBc0Fsy45pODD/mr2ClpT2zpTh8zM4VBNz6mpiAjHD1WQ6LDmUrczdLtWD+Er5bv9jUkvyKJQX4RQWDvzaO+TuH2H2Y+qDeom4lRFGZzLHjKUjmzPasOxwGXd1aycc4=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by PH0PR10MB4437.namprd10.prod.outlook.com (2603:10b6:510:3a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 16:22:24 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 16:22:24 +0000
From: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "davem@davemloft.net" <davem@davemloft.net>,
        Liam Howlett
	<liam.howlett@oracle.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mingo@redhat.com"
	<mingo@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de"
	<mgorman@suse.de>,
        "vschneid@redhat.com" <vschneid@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Pei Li
	<peili.io@oracle.com>
Subject: Re: [PATCH net-next v1 0/3] Threads support in proc connector
Thread-Topic: [PATCH net-next v1 0/3] Threads support in proc connector
Thread-Index: AQHbHZI9arudTUFlxEOVE5hfsdtRbrKH++8A//+QaIA=
Date: Tue, 15 Oct 2024 16:22:24 +0000
Message-ID: <1CCDA7B3-F43B-485A-9950-85AA272D79B1@oracle.com>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
 <20241015090148.72e83f7f@kernel.org>
In-Reply-To: <20241015090148.72e83f7f@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|PH0PR10MB4437:EE_
x-ms-office365-filtering-correlation-id: 029f70f6-71c1-4187-7dda-08dced358d84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?TXd2SS85Q2FIYWd0ZzJUaFA2aW1GM3dmbjlNcFBBdTlCSW1FbnJNZ1BVSlJE?=
 =?utf-8?B?M1pyZHBKdGtCSkozMnZzRjNJQnl3WElVSXgzSkovU3dMQnY2dWU2NHd0blFP?=
 =?utf-8?B?T0JSYkQ2MHJ6QTNlR1hMeGJoakUzS1lmWlNTMUFnOUlCUkt5TnVVWVlWVFVi?=
 =?utf-8?B?UmFreEpVeFNuZm5YTmtGaitvMldCd09lTGVaL2lQU2dyNUdkcnordHlRME5R?=
 =?utf-8?B?T0w5RXZXODlwaUlKRzE0d1NCQjQxTSthc21EY1lURVZJZmhQenNYb1A2b0d6?=
 =?utf-8?B?bFpkNnhKY2pKMkV4dFRyQVBPT3o5ZHdnNnU5cmRQenVGRUV1dmg0NXFNc2Fa?=
 =?utf-8?B?NEdna3l3WTFxL0lUOEx1VkdUNmFlUEM4cTBzSnMrcXlOWXoyM094eU15Ry9M?=
 =?utf-8?B?SlZPMmNzejZJRVhYQTRvUlBiRGRFS3ZRNnhqMDNMcEhQSHkvQ2tjVnlBOEVS?=
 =?utf-8?B?c3ovd2FSSlVnZzh0ak1uZ1V3Yk5IdVg5WlRFOVA4Qjlpb0wvODNZZUt2UXpC?=
 =?utf-8?B?U0JLK0JCK3ZoK1Y3SmJxeUZ1OG9lalNyd1NzM2FqZW9CcWdVYkxHZFVpN2Nz?=
 =?utf-8?B?TFh2OTVwak11VkFyOXozZE9IZlk1NTNJbGF0YVNoWndLRkNOQm5ab0hYVlk3?=
 =?utf-8?B?VGZObUZVU0RaV1FtbUlmM3B4eWlndHdEdlVsbnErOXVlcDY0YU1YWVZQU1lN?=
 =?utf-8?B?SXRzSTVIVEV5REJvZ1J1WmRHQy9Sa3VtcW1mYkRoSGpkRTZSYmJ3RG9CcHZw?=
 =?utf-8?B?WDliTmQrNUdXbHNtdm12TUc1ZzZodU5UMVF6azV0Nnk5aFRqQzBVN1ZZMkNx?=
 =?utf-8?B?OEp5UjVJVnZSY3M3UlV0WEZFVTVqV0JzdDV5czU1WkQ5eHlmcmo5SCs1OFJp?=
 =?utf-8?B?YURKR3V5TDB3ck9rTGx1U0k3MlZQS1RuQzF0K0lLZTZnZnUrQW5vbUh2dXdl?=
 =?utf-8?B?OXlvVllIY1ZObXZ6N2NsdXR4Nk9FRDhlZHRFZ0Jzc2h4OU1FS20xTEhDeWsr?=
 =?utf-8?B?QU9xc2ZYcmFNYVp5SEVlT1hqbkF5Y1Z5Y0ptQmVWY2RROGxqZUlBOEZENkxx?=
 =?utf-8?B?RUZMMHk3MXV6Qm9OSjc3S2VLVWpVQzhiQzAwTkxaT0VUQncxYlhFTlFGYUhR?=
 =?utf-8?B?d2VpS2laQXlQWCs2RFNYMVJFNWc3ZnF1Q2pOUHdHLzZsMy9DaGdheTFwZk9E?=
 =?utf-8?B?eEhnVmYyNEZLblBTVEx3RjQ5V1I5c0djWDM2UXNYN2N0aGpNOEFxMEs3WmVK?=
 =?utf-8?B?SzllbjVaNnFvYmZOenRvU25BK3hVbGNWaWw1SDlDTkNxRnFHaGU4Q2FlcFZw?=
 =?utf-8?B?OXAzTExGWHZpNmRZZ3lqUU5GbXFTODBFa0tZNU9adEdOaVk4UlBObkdXQkRj?=
 =?utf-8?B?UHpaYUdqUStZWFlnQ1IvRHBVV3BpWDJlN00yVXJwRWdMd2JObDFRdFprRmN2?=
 =?utf-8?B?d1BwRGJXNnVGMG1jbDY1SmZjZWZIeUpkMHk3MnpiNjhUQkJ4V2V1T0NydmVU?=
 =?utf-8?B?QTdwaStuWFhvZVRsdHNNSzU2aklxRjJiQVpzN0xTc3hqUkJZRGYwNS9ZUXp6?=
 =?utf-8?B?dUJsa3dLSnRHZjdsbUt3a2s2dC8vYUhiN1pCSklPNTdWTFNHZFBhQzJzMjhs?=
 =?utf-8?B?Yy9BUzJySUIvMjd2VFVRRUxUbXFEa0dqeHI1OXFVeHp1ZVk5a0lpckdpRUF6?=
 =?utf-8?B?TnpucjZmb3Y5OVh0NU9ialBqUWVJNFlwSGZ5MXJXdlFDaFRZN25DOE1TK1dz?=
 =?utf-8?Q?p+KNQ929FB+WjVSr78OHsqxQkr10kiv8SK3wvtQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dzZXYUszRUYwTXY0QzRtSVQxSTBFZmQ5S0ZwK1phczd3VUdhbWRyRTRraEpP?=
 =?utf-8?B?MDBXUFNCdkJjb1k4K0dWK2g0S3pvRVM0dC93NzJMWWl0RVdIbGtSeGxyZjF3?=
 =?utf-8?B?cURWZENXNFU4RHl2b3BTWTN0ZU5NUTd4NTJnOThOMWJtYTVGVmFBUjNvZ0JQ?=
 =?utf-8?B?aFU0ekdVbzczcjNpeE12U1pDZW9CUWtKRXlVSUphVllnMERqZG1rS0pCK01j?=
 =?utf-8?B?YUdrWVhwWFI4TW5jeE5BQTBuZks3c1ZUUWdNODdKUWJpLzJSODRVRHo5bHBt?=
 =?utf-8?B?T2RWRVg1YnpObXN0VDd4cUtTNUlzbGFoekQzdU5mc3pHcm1uQ3lEeTdnSGU4?=
 =?utf-8?B?RWl2cVJ5cmhsM1Nhc2VHSDRsY1UyaWllSG53Z2dqaitncmVMUkZsSUFCZm1u?=
 =?utf-8?B?ZEoxSzFnTHM1RVlmNlUxbXZseis5N2lwbnNtdU1kSElUR1l6R09mYUt6STNv?=
 =?utf-8?B?cDhaMFFqY2IzYW9XemVJR3E0dzhuckpTRXphaFJpL1pZaHQwalRhZWdHaVJF?=
 =?utf-8?B?d1dPNWo2MWlqeEpVMjByenpXd3JjOTRvUE16OGc0ZFFQUG5lajJNQ01iTnlH?=
 =?utf-8?B?ZUMzbUhmT3luRGk5dFFoZDJxZjY1MWtKUC9UQWpPUE0wMFpiVDVtemNGeWFE?=
 =?utf-8?B?N0c5MEhUNkVuU2ZCdmpTK2VjSENjekdtSHJFS0xyYmFoZ2tvdUV5dk1kVy9s?=
 =?utf-8?B?QjkvdUJBL1BNTHVKUDdRcGxZMm0zZFhWa1hNZk5rT3RrYW94aUhCbS93M3h5?=
 =?utf-8?B?MCtMOGpPcW10L0dDUG5oWUE2MVVhcGFCb3ZvSEIxMHhnVXo0eml2UGVuMmFY?=
 =?utf-8?B?eDgycHVuUDJaYkFlNU5ZQ0xsZWU2Z3B4VHNCRE9mRVllbWdLSHZxY0xpUmdZ?=
 =?utf-8?B?aDhlYmhpNk9vL3R3MFNIenRiWlJWSTdnaDgwRW45ZjRyKzFIWXJpSllRYzhU?=
 =?utf-8?B?V2dWVXJLcTBCenhmKzd0NSt5Z0paT0Y2QUZZOVZsYUh6TG1qMG5NaXpDM1pj?=
 =?utf-8?B?K1crUEdmQ0VRUS9jcENzMW5oMG43STJIaWVCdWhqNWg2bXU2RjJuWVErUnlS?=
 =?utf-8?B?ZG1GeHo0eHpSbUdqZVcvMk1lTzJtNmc0c2V0ejU0ZVYwQ1lEZFh1Y2RCQm5w?=
 =?utf-8?B?cGRLOWtrL2c0N1NhNk1KK1BIUjJLSFczNFg1T3dMTUhGREU0dkpwM2toL3Fv?=
 =?utf-8?B?NjBtWTlCUlVNT2wrb0I4WitoQi83Rm9xTkJNS3FCQUl0U3djb0p3dUZGZVlQ?=
 =?utf-8?B?ckw5UlM2WFI2dFJUT3ExV1UvcUQrUUNQeVZJaGVDaHA5azBSM0g5dUhTblVw?=
 =?utf-8?B?dkhCUEpVc3VQZVF6RTVrWWRuVGRLZVhxV2Z1dCtic29zazVhSzBObWcxSzRj?=
 =?utf-8?B?OC9RcXgvTGRIWFNWQWRqUTdkWTd6K0U4NVNKbTVaQlFDcEVCbDAwb2RnbG9O?=
 =?utf-8?B?NnVpY0w1VlZVZmFBYjRMVjNYci9SM3NnaFFlQjVVeVcrL3JPSTZZOG5BRHht?=
 =?utf-8?B?L2prdVZMaTJPbUNvZDBQcEdad0E0aUNLR2pwenY3bEw5eVQ0dy84VTN2Yy85?=
 =?utf-8?B?MW53dHhzYnZGRml4VWN4RnkvY3BHeStHRmdjcCtjZnpmSDNUTS9CRncwQmkr?=
 =?utf-8?B?aHRpaDVxbjJYMXNGV0FWSVJ1RUdWYjFFNFYrb3hBNXQwNG5udmdHZnFtZkcv?=
 =?utf-8?B?N1VIcUhCZVNEWXU4TC96Q2ppY3BaeU1oTEpzM2VVakRYWldROFVFKyt2QU51?=
 =?utf-8?B?NmhySmxQOUVrcjRHcVZpemtheWFyTWNYMnhuNkRQcEN3bzBGTWJUV0NtYzVB?=
 =?utf-8?B?T0RNQWRBajIyU09rZVNVOWpFOFB0WUhLQkhXbWRqeTdKd0l2WS8rUVVObFRw?=
 =?utf-8?B?QWdBcExqVlFpM2hrM01kRkdHVGhKWWNXcC9pY0hUYS8zQks5bVdKa3JHcXMv?=
 =?utf-8?B?N0YzTHRuUHpGVU1kR2pUOXM3aWRFcFovaS9DWXB2clc1V0lVaTZKdUtBUW5L?=
 =?utf-8?B?WHhnSEoyNC9leHNxWERmRy9PamhIVDArTk5ka0hjalQwMEJJV0lnUEhpemxh?=
 =?utf-8?B?TTdCQXE5MStQQzhvamVycmQ5TWNRRTVpQnJzNExaUUVIOTY4WkRVaFI0c2N6?=
 =?utf-8?B?a25XVjBoZ2N5TGhVOXlGS24reFR0K21kV1pjMHdCSVBpZ1NwODRvaGo2MXd6?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7C2D0B285FD1E4FAC69F876847E245A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hWLQhtpNeG3ZSXxrVF70XHz36wl/Zqi09qaylZSBfGl9qgBwJaz6Oh1BDPNQDnkgiF9evlOXnL3Bsb9Gaia3sbCHSm8JgS/wQRV+XMDxHmfNWm0LMae+qu/CvbOm2UF406Y5MeWnYIxuX2d2GKDrOpow4X8EL4GJIw4ApzaW8+NJSdXFl0qJbG/lksuMcyC3KC0p3Han7TrvvcLxM2JrCsQ/IPTNZ4RAjwBdxmK+piwU36dzjH9jbcI8KFFTEMP5+iawqwpB9thrTtw09sAXOpw20OpFmAMoSI+ftvMtGLhfzlMfxEs+1MS5l2j2ZSF3zt9xRtAjedb7cQzo6HLub/6oJKXb7ZLkVQ8hrnsxYU4hQf8L8KvgjAFGHRFLdlH4yccZTV2rTyCvne5DoI2Hv6I9AK//rjoZoN+4bmEWcI9oZLaK55XvVyE7CJB0rHEs/pTSL5683QqwGNfOvbdWxggjhoRm51bEtzWZnNVWT0TBP5Sp3z240moBUETTBizlW4bFTgGhIsLJsWLJKlv6W5yxrU9Zh23tXBUrhkwROYIrh2QWFFoIBmQnu0O0S8q9pkCRx7n27JZy+gcfetF1JePikvKGNEeXaqfxD9K19oo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029f70f6-71c1-4187-7dda-08dced358d84
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:22:24.2954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8F8Y6hpJm6jf62Vk2743/C5BSX39lBm+enWjarrtsIdOUc6w2hc0J/JdjoHM+ZSFVpHOX/9Geka2q8pDOV3D9+D8gzsPC58uqyRkQHGB0mU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4437
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_11,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410150111
X-Proofpoint-ORIG-GUID: qY6hK5bxBq2v0ZD2Yiw2f_PQlKG0D1Wi
X-Proofpoint-GUID: qY6hK5bxBq2v0ZD2Yiw2f_PQlKG0D1Wi

DQoNCu+7v09uIDEwLzE1LzI0LCA5OjAyIEFNLCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5l
bC5vcmcgPG1haWx0bzprdWJhQGtlcm5lbC5vcmc+PiB3cm90ZToNCg0KDQpPbiBTdW4sIDEzIE9j
dCAyMDI0IDEwOjA2OjE0IC0wNzAwIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4gSG93ZXZlciwg
Zm9yIHRocmVhZHMsIHdoZW4gaXQgZG9lcyBhIHB0aHJlYWRfZXhpdCgmZXhpdF9zdGF0dXMpIGNh
bGwsIHRoZQ0KPiBrZXJuZWwgaXMgbm90IGF3YXJlIG9mIHRoZSBleGl0IHN0YXR1cyB3aXRoIHdo
aWNoIHB0aHJlYWRfZXhpdCBpcyBjYWxsZWQuDQo+IEl0IGlzIHNlbnQgYnkgY2hpbGQgdGhyZWFk
IHRvIHRoZSBwYXJlbnQgcHJvY2VzcywgaWYgaXQgaXMgd2FpdGluZyBpbg0KPiBwdGhyZWFkX2pv
aW4oKS4gSGVuY2UsIGZvciBhIHRocmVhZCBleGl0aW5nIGFibm9ybWFsbHksIGtlcm5lbCBjYW5u
b3QNCj4gc2VuZCBub3RpZmljYXRpb25zIHRvIGFueSBsaXN0ZW5pbmcgcHJvY2Vzc2VzLg0KDQoN
CkkgcmVhbGx5IGRvbid0IHRoaW5rIHRoaXMgc2hvdWxkIGJlIGdvaW5nIHZpYSBuZXR3b3JraW5n
Lg0KV2UgY2FuIGhlbHAgcmV2aWV3IHRoZSBuZXRsaW5rIGJpdHMsIGlmIGFueSwgYnV0IG90aGVy
d2lzZSB3ZSBhcmUgZmFyDQpvdXRzaWRlIG9mIG91ciBjb21mb3J0IHpvbmUuIA0KDQoNCklPVyB3
aGVuIHlvdSByZXBvc3QgcGxlYXNlIGRyb3AgdGhlIG5ldC1uZXh0IGRlc2lnbmF0aW9uIGFuZCB5
b3UnbGwNCm5lZWQgdG8gZmluZCBzb21lb25lIGVsc2UgdG8gbWVyZ2UgdGhlc2UgcGF0Y2hlcywg
b3Igc2VuZCBhIFBSIGRpcmVjdGx5DQp0byBMaW51cyBoaW1zZWxmIGR1cmluZyB0aGUgbWVyZ2Ug
d2luZG93Lg0KDQpBTkpBTEk+IFRoYW5rIHlvdSEgSG93ZXZlciwgbG9va2luZyBhdCB0aGUgTUFJ
TlRBSU5FUlMgZmlsZSwgZHJpdmVycy9jb25uZWN0b3IvIGlzIGxpc3RlZCB1bmRlciBORVRXT1JL
SU5HIERSSVZFUlMuIEhlbmNlIHNlbmRpbmcgb24gbmV0LW5leHQgaXMgdGhlIG1vc3QgYXBwcm9w
cmlhdGUgcGxhY2U/IA0KLS0gDQpwdy1ib3Q6IG5hcA0KDQoNCg0K

