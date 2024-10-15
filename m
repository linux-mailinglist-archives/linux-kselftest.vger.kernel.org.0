Return-Path: <linux-kselftest+bounces-19754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8599F36F
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 18:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5BC12846CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 16:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816041FAEF5;
	Tue, 15 Oct 2024 16:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQXaqIjO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZrKclY8O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD56A1F9ECF;
	Tue, 15 Oct 2024 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011237; cv=fail; b=XA1sNBWwPv9x4fpb9RSqspNizZPgRrsC9XBJieq+/utKGPS8NeF2Q8AkQHvMyIjSy0VEFcZEIcpfu9NR2cGILhky7hKo21wFaVgBYiJGc1eyoyPgTEkFqE5Bl4Qz9lLEz4Mr6uG/+r1y/mprg3c0kyDim8LzqPKNZvI4s79FhrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011237; c=relaxed/simple;
	bh=HKtLtoKNS3w3OjgCf/comFRSZqAgPK2uwc2r6tAe1S8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H64/cqyvmquUrIFinl3Ls1AWtNMhHjCxQj0e245VMxLa7wNicz1DT9UH5AA0AH2PBJZraOwXer2G5qDbwCDx81SntmEvoqsoZBB9tbps808oyMv0SUFnyir6gMVMHCCBASkE56lZA5K4cjsYbVX8HILvyXkQ6glnAYlHVpNl30I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQXaqIjO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZrKclY8O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FF0cAu003919;
	Tue, 15 Oct 2024 16:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HKtLtoKNS3w3OjgCf/comFRSZqAgPK2uwc2r6tAe1S8=; b=
	cQXaqIjOzsRBrOB+cUtFTnoulUqxNiKSDh2Sav46fFDtRBM/QYqk2HELknLpdGc3
	l2Ydlj21EiYfbARYygyHhKIRflZwMq/mkPsDiPvSLmTloXF9iKob8TZ2rokIHlSh
	wQsH1cmL2FVEIpVirvL99kO/V7m99luRpeNa7MThh43zwg8v3xPuYOIn9vWugjgu
	g5GXIbJQ6yklElbGQSWSsMdJb57KCY+9FQUC+pqIqdIqkCmLRT/pVEJiMWT37NH5
	Xp5f7goG2s3HUoqkIZeXsqYzj9BT2VNLYiAoNUgw/XXqNzFw/QSP29sD64J5Qjkt
	ei7wk9qmGcbhJtdHbj9F9g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gqt1kmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:53:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49FFrrCH019899;
	Tue, 15 Oct 2024 16:53:34 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fj7qtse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 16:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/7QHCswG6azjO9p9A8Oz4UIWNL8yVSmInEPzAmNpz+yeTy4u2yD0u1IG/7sgmWeolmCkHlgNiwT/CRuCwguwDWHPlP2yCYhf1ry9nPL77bxZ2dS+tgVAHSq4kIx3GOR3qQQ1iY8GUZ6qKkZ2FhC5sAVDvGojz82aE7kcTH+/eLntWFd/94Rw7E2VTuumwdy8cWQGMDGwmv++e8GpGmQx4spaO5DYynI08ARrJeb3YTO5a9frjlAUeZuIJOkB0FpgjonnMewGNPSizE5hEzhJMsKme4wrapGv2z2ZdU5WHh1F1etJJjxmWv5tH9PRGO1KRM+FyI9R52xS67MqBvFFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKtLtoKNS3w3OjgCf/comFRSZqAgPK2uwc2r6tAe1S8=;
 b=lmJ65mHKEpIm68TFhlzMc3CtnERzsG4pUFunxIDscZwq8OJcy6cRE+zBJ5fvPsVuqMthvgceC2zPV5uOvC5M4X1UIFpOXu1yf1u9l1UNUatD/zn6vrWXzK9xuyMuSLXFRoeno/lB7+yeKmA7lQZORSJ/MNPP3uGGO1XQ/ihrvLkIz0Ja+1zve17QvDAS5hlf9MxwyHMrOEPJPNAJH1wi/cK+BBRVH+jUUZT3CBfYDDhhIm8OX1a3/uDx7Y01oYopi0mdfgy5ot0S0E00jl9cE/5nH3ro9eXc5yhHb0Wryy38pANGL66zyiiilfq/CfyAL6QMLZ4VKYF7w4KOpqdYQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKtLtoKNS3w3OjgCf/comFRSZqAgPK2uwc2r6tAe1S8=;
 b=ZrKclY8OPWVbRK8BWVRi4/rLxK1cHqxcsDKlVflecBBuA5FTS0ryIK7c8je1ZGSnsZVAt0SeBp+LZLGe9INNF0cTcnoUwRsVdkRAwWDMXyLnc/5QkvJWVKUodJ6lVZNHSPhhlh0L48rO2L1O/Owu0ywNJAhBsx2gyhEPNxTsqfw=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by SN4PR10MB5589.namprd10.prod.outlook.com (2603:10b6:806:204::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 16:53:18 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::3c5e:9043:1ca9:4c60%3]) with mapi id 15.20.8048.029; Tue, 15 Oct 2024
 16:53:18 +0000
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
Thread-Index: AQHbHZI9arudTUFlxEOVE5hfsdtRbrKH++8A//+QaICAAHyygP//i/CA
Date: Tue, 15 Oct 2024 16:53:18 +0000
Message-ID: <30659D9C-882E-4275-BF92-A70503BBFBD4@oracle.com>
References: <20241013170617.2139204-1-anjali.k.kulkarni@oracle.com>
 <20241015090148.72e83f7f@kernel.org>
 <1CCDA7B3-F43B-485A-9950-85AA272D79B1@oracle.com>
 <20241015094841.2acd5a50@kernel.org>
In-Reply-To: <20241015094841.2acd5a50@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|SN4PR10MB5589:EE_
x-ms-office365-filtering-correlation-id: faa8e418-344b-4812-0ed2-08dced39de75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3dmOVV5MWJicnp6UC9EclY0c0lxaHJpREp0Z0xFbVA0ZkVMLzkrd1RUY2N3?=
 =?utf-8?B?Sk5ta2w0aFJFdjNCUExjV0tJMExFWkhNUS9SeTRrTXp3YU9QNSsvZnhlVnRi?=
 =?utf-8?B?b2VRZjI5YVp2UDBLVDE3RlJDeDJzVVA2S3pzZnZoMHRoRS82MFIwbWNYaHlV?=
 =?utf-8?B?bVVIbnRadEVxWHZJZ1JyZzc4VUcyRC9YZzNVNTIzbVJOclFySE1HWWU3TUNL?=
 =?utf-8?B?cXhnbWVvNlRBcUVIQUU1VlMraVg0eUZjdk92OHYzZnhtYkhubDN3aGs0czJV?=
 =?utf-8?B?djhLQTZsdDl4WFBlRnArTEFyRHBKUXFOajhnRjBlS3lKLzE4ZHpSaUJJSE84?=
 =?utf-8?B?R3hiVGE1VkQ5aVI1TGJnMUl2SnlXeGtaSFI5L1JwdUI5L29ob215eVpQb0Nr?=
 =?utf-8?B?RFZUNVhhUW1LeGhLZkQzK2xyd0pxRlRHdE1RSFpYdXRUWlIvYU9WUXIvQXhi?=
 =?utf-8?B?TGtRQnU3a1BlZmxDV3VyNWFtcEE4NXd5cGRJRElaTk1Ic2ZBODVFS2o5YkdH?=
 =?utf-8?B?bTFOS2ZLWTdsNkdLcjhCcXlCWnBnOFozYVVGNU5zT0ZqZG5sUGdad3o2YjFr?=
 =?utf-8?B?cDR6RE9DQVo2bnpnbWNiQlNpcW8rOUc3QW92TWhHMkN6ZXB1ZjZZWWtYS1BO?=
 =?utf-8?B?UFJEbDVSMGJnSkNaT2F3bU9lNm1xYm5vNEtabWNFcUdUb1JLU3ZkTXZIdFND?=
 =?utf-8?B?MjJJRm0xK0JueDErQ21HSmUyNVdVY2x2UmhzSUJPUUJsWnVUMVhaMG5aQ1Fy?=
 =?utf-8?B?bWN2amNiWHZHNmFiVk40OGh5aFhiNU5UTHN4Y3FRb01YRHpzcFR1T0RIWjkv?=
 =?utf-8?B?eFJhMUpNZ291QndFWTlKNGdOakpPVm4vSWc2bFkwMlBPam8rSzRhS2hNeGV5?=
 =?utf-8?B?bVl6ZEMzbjBTYXdKY3dCK01INkR1bEk4dEVDdHFuTHo5eGoxZFBUSUpaSUhL?=
 =?utf-8?B?RzdDT0tRWEtvK2hISXl5L3pRWG54dDRkOTZGOUxQeSthVEpSRytWcnJwMUhL?=
 =?utf-8?B?NWJjb3g5bGVPdW1EWmxlY1ZlY2Qxd1k2dmJRdmpZRE9NYXdBYmFsRmVNYXhx?=
 =?utf-8?B?SkJFNGtQcW1EaHR5K0xyLzFVcG1PeXdsUnlOZ09sYnlpcmhLMHhZY1JSKzJj?=
 =?utf-8?B?b0tqNFBTZEFxdE1mbmIvNmkvTFJOS1BoWnFNajBTdis3OUxnaFNrVHpIZSs3?=
 =?utf-8?B?Vy9RR2JzQ29mTEpDSVh2eEp6cG43SVovSmNxcDZrYmc4MitEN1NabmdiMFNZ?=
 =?utf-8?B?cFFIeFJHOUptMHRicHBjM0pETzA1RC9MQ2kweXdRMHo1RmhZKzRKWW1MbzlW?=
 =?utf-8?B?SDl6VCs1OFZxWk93dTByZjFjS2F5NXhTd2JTQjNibi95MDdteEdOOW5HZDBF?=
 =?utf-8?B?SitLR2ZpT0hsejN4YzFJQmhxM2pVK24xTmo1NENSZVpwMU5DOStOQmw3NW4v?=
 =?utf-8?B?NjZWaW1KNy85dTRUMWhMNC8veHN0TnA2SWNzdkpGSXR4TytnWm1rMUN6Vk4r?=
 =?utf-8?B?OHlQRTRPVlQxaEs3T3AyNXVqVGU4VUcyNkFLTkdJR2RGU1RNN1hxdCtrUUQ2?=
 =?utf-8?B?RHJCamZrd01YV0s2c29PbDZvaEJQM3NyeHV0OUh3Q2c4Q24wR1JXVk9jZ1Y4?=
 =?utf-8?B?YlRvYmRKQ20rdDRJYXZXUjFpL1lGelJwS1VxN2lJYytYYkIvN2xGTU1LcXFS?=
 =?utf-8?B?NnhKTldnR25iM0xwaG1iSnlnQUYzN2JXREVsb2dacXJTRDRCVVMxb0JIZUVV?=
 =?utf-8?B?Njh5cTFaZ3BubXJhRW9ReHNKREg5VGFlM2dXdkVONWFCYnNKMVY4dytFQklG?=
 =?utf-8?B?UTNwNjYrczNKdUJFV01JQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2g4MFhRYXZ6Z0NiV3dRWktpSlU5TnluZnd2OUhQdGU4NFc0dnBkZjVNRFdO?=
 =?utf-8?B?ZkNvdGhKLy9vR2tJRGV4Q0tiYk5LM0NRUDRhRkJvOS9ISEdFZndGZkt3V1py?=
 =?utf-8?B?Nlg4K3F6TzFkTmljRFZha3kzS2FOMXhqbHcyY1d6eXdlV1NKNjhWSXI0N2ZI?=
 =?utf-8?B?U3FrMW0xdGd6bmpmWnROQjhJei9mTUZnbytVNzZZRE5CZkFOd0QvSUZLY3Nm?=
 =?utf-8?B?ZEh2QlNFK1M2M1dFTjRuSWMzS3IvU2s1ckVrMW4yM2pUM3ZiUVhDZGZ1NmpN?=
 =?utf-8?B?Q25LWkk5RVJaK3FkV3lxM2tVTjN4SjdWVjFYdDlBdndkdDl4NTNFckdPVysw?=
 =?utf-8?B?YjdYRUNlRjV3aFNPRzFvSzhaN2krOEVnVFI5QUV2ODUxa3gweDZGZGFTTy9B?=
 =?utf-8?B?M2wraWF1ZnJIZndCK1NvdTBlQkFqbVZFYUM4UkNxaEFWa0hJSDBWLy9mN3Zw?=
 =?utf-8?B?dVdWK1FiK1lIS011RHhER2xXbGlzN09kKzltRTQ5SzhBV1lNVld4SnZjRk5Q?=
 =?utf-8?B?ekdmMUtwdkdnZi8zbUgrdSt0SDN2bFQra09KZWFUYmR2RkVWRmcrOEZDbVAx?=
 =?utf-8?B?ZjFDaDE0aktWU0w2SFJDRnNQRy9UaGZpUU81ZG9xMUlVWTh1NExFSVBGbjJW?=
 =?utf-8?B?bnB0ajNEMkg3S05zOHloOEp3RERDZGdTcEtkMXhyTDJmM3lHK01XQXVvMGpi?=
 =?utf-8?B?YzRvTytYVzIwa1N3L0g2Nk1zZU44ekdNd3h6aTNsbWxQK05DWDMyTE55RTZZ?=
 =?utf-8?B?amRxbnQwVnRCcFJJeUJiODVxOU1Uc0RZOUY3KzlBYWdiZ2NFTUd0ZHA3dnND?=
 =?utf-8?B?VE42SlFGRURlR1NYdmNWbHE5dHNsd1NQOXhtbzB3QW1RRDd2SmcrdHdYU05r?=
 =?utf-8?B?QStYejlJQkE3TTNTQ3hhUUk5bmlNMzRVR3l0ZUhzbzlrMGlmV1RxNnBwYnpR?=
 =?utf-8?B?Mi9VbHpzN3RxY2xoemNKS1A1bnp3eGcwMXVreDNEcHllY0ZqUWtubk9aZmNw?=
 =?utf-8?B?SmNJZTZNOTlSRWE2NGpjclRRMzlndGVqZ2pYT1Z5RXRTU1NtdzRoSStoaXJK?=
 =?utf-8?B?ZjhjTFFqYXk5U3Z3eHpsbEYwb0d2ZzNJYUY2QWdZcHoxZVBvMERLaEdpeEJi?=
 =?utf-8?B?aGFGdkk1ZStwWUpQM043SERQcmhlRlJzcllWT1lnR01ISWFYSUtkWWtDZnRz?=
 =?utf-8?B?bWo1eFcvZTkxU05lZG9pTi9ISlJGRnRISG01TXVCdldZZGo3VlRzV0VjeWlu?=
 =?utf-8?B?bDQyYjdienc4bFowbjY4OE44ZlNVU3NXclppaGh6NERlZVVKcFViWWhNNXNC?=
 =?utf-8?B?TGowd01pNDRYZ0hIalpUaXREZUhQdVJCMU1hNGpKZUV5UjA2emdoR1BTV3Z0?=
 =?utf-8?B?bmNOUnJpNGR2S05EaEhLN1IwNStIWkJ3V1MvVnFuUVRmMWc4Ry85R3NZRW44?=
 =?utf-8?B?M2FrcnVIK0F5R2JCNWFGZ1gxT3lBWkxlbnpEZzc5QkFrNTkrNmVOQzhwMWVp?=
 =?utf-8?B?VXZqYkRvN1RUbDlrc1NBRXJGV1YzS3hZcWw3a1p5SVI3cmMyY0ZqZHdsRGQ2?=
 =?utf-8?B?Tmpabjd4cFBkTG9wU1VnR0pGbTBNTTUzSmt6VGg4SmZ6VE5Ed0VicGJNUjVp?=
 =?utf-8?B?ejVFRjBnMFlmWTF0TDRrY05lVVBycjd1dWhEZ2RneHFRcGFCV1BnOGxtTVZ0?=
 =?utf-8?B?NExsbFNnZFZnSXprVUdBemloeUtkOGg1WGV2WFlieG5hYkl0cjU3UkkvYkdS?=
 =?utf-8?B?SGY2MHhXekVMMjA3Wk45WUFzdkZRNHZmQUpMYXlaQjlvVlVjUTFkQWtWY1NQ?=
 =?utf-8?B?V1M1a05sRU85ZlY2Ym8vUnRaUU5OQjJtZGswOTl6WXZ3NWZDamFjN1lpTS9E?=
 =?utf-8?B?elZVZ3gzQ0NMaGFWTHEzVXhpSzFxQk51S2dLNXhGRFJxVGtFQTEwYzE5UkpS?=
 =?utf-8?B?My9jS1BjeGJsRlhBeGFEVnZPRjRkZVZFQTl5aEN4M0paMkhxL1Q4bzIvTmZU?=
 =?utf-8?B?cExrVzVLbnBWN1NWWlBFRDErckR5RzNOaEI3Ry9jVWtnVW02dzI1Q0xVd2FQ?=
 =?utf-8?B?aExDMnNDVDB3Ukx1b1ZMWGFyWmNhVTh5ZXJJOVpQb1U3Q1h3bERrOWk4RXlw?=
 =?utf-8?B?NzY4MWZGNnJPcHhhdUdGMFdxUDBOS2NSNGdCZnROdUJ3a25sMzE2WVlZV1dR?=
 =?utf-8?B?MXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ABBDE7256B886945B40B3BEFD57BEDEC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Q1PF5NBAx97iym3pa3COaCwCh+yL+Wk64K8oYPOIr0H43v6bePtnbW5G0oOOIProh/KiMpe2/rOjSZPLP5Ml29yWpcfE0X3ikRoMze6G0JU2sT1AnoF967DpykqulR3+wcy+Sl52CsOXXlM2Bw/JWtpH+XSZqxvUL4PHT9+Ui+wxUFHfEwg9OCrYU5ys5bxzZ7ljfLRVDBlqQ/FhdfWUplwYW8Zrvbk9Xhbrd+b5gwfT6kRYUKz/DPzRiysh0+c0F/7HcSGtbepYV637ttAe2csS147Mn42WWJNGkouRMsLwlW1Ig9Im9goA3aNClWIRh/r4b7MCxNClrQYFC4j3nPjfX5c+U+l406DRKvLzlYKlF1XlNUdEeEV2SAFR2Q+8pNYFcMdgnwzj57a5SV82hJ062RDEfDMEchqfPFSUB9aXvkNICJg961x0OnLvmsCAoZ7cNsg+CUJxtGxyT4Y+Uy/7O+lI/TpibNKY63GQcW1kFcMK6vjiKBwqA9JUN8qM2B/aOHEAlnkBUC/bA2jwbh5aobaDyBlgadAQqioedwW5JffdZ7NZIfHor6Xaba+x99BPNEF2D1WRem03NEzDLlqJiH/oYZZQpHu3usqaPeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa8e418-344b-4812-0ed2-08dced39de75
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 16:53:18.0403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUV2Kla3xF/POQ6bnlxFwcnOt3T558utLOgENqj6ClvNDiVL6VenKX3hvvImPrqlEBqGaNOQLSpb6l06TY11G+69aUfYK2CJuBC1TMzRB1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_12,2024-10-15_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410150116
X-Proofpoint-GUID: 3hRP0IYaqkkultK5rlyDKeRCROmGMCQF
X-Proofpoint-ORIG-GUID: 3hRP0IYaqkkultK5rlyDKeRCROmGMCQF

DQoNCu+7v09uIDEwLzE1LzI0LCA5OjQ4IEFNLCAiSmFrdWIgS2ljaW5za2kiIDxrdWJhQGtlcm5l
bC5vcmcgPG1haWx0bzprdWJhQGtlcm5lbC5vcmc+PiB3cm90ZToNCg0KDQpPbiBUdWUsIDE1IE9j
dCAyMDI0IDE2OjIyOjI0ICswMDAwIEFuamFsaSBLdWxrYXJuaSB3cm90ZToNCj4gVGhhbmsgeW91
ISBIb3dldmVyLCBsb29raW5nIGF0IHRoZSBNQUlOVEFJTkVSUyBmaWxlLA0KPiBkcml2ZXJzL2Nv
bm5lY3Rvci8gaXMgbGlzdGVkIHVuZGVyIE5FVFdPUktJTkcgRFJJVkVSUy4NCj4gSGVuY2Ugc2Vu
ZGluZyBvbiBuZXQtbmV4dCBpcyB0aGUgbW9zdCBhcHByb3ByaWF0ZSBwbGFjZT8gDQoNCg0KSG0u
IEl0IHdhcyBkb25lIHJlbGF0aXZlbHkgcmVjZW50bHkgaW4NCg0KDQpjb21taXQgNDZjZjc4OWI2
OGIyNTc0NGJlM2RjOTllZmQ0YWZjZTRhNTM4MWI1Yw0KQXV0aG9yOiBEYXZpZCBTLiBNaWxsZXIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQgPG1haWx0bzpkYXZlbUBkYXZlbWxvZnQubmV0Pj4NCkRhdGU6
IFRodSBTZXAgMTAgMDg6NDA6MTMgMjAyMCAtMDcwMA0KDQoNCmNvbm5lY3RvcjogTW92ZSBtYWlu
dGFpbmVuY2UgdW5kZXIgbmV0d29ya2luZyBkcml2ZXJzIHVtYnJlbGxhLg0KDQoNCkV2Z2VuaXkg
ZG9lcyBub3QgaGF2ZSB0aGUgdGltZSBub3IgY2FwYWNpdHkgdG8gbWFpbnRhaW4gdGhlDQpjb25u
ZWN0b3Igc3Vic3lzdGVtIGFueSBsb25nZXIsIHNvIGp1c3QgbW92ZSBpdCB1bmRlciBuZXR3b3Jr
aW5nDQphcyB0aGF0IGlzIGVmZmVjdGl2ZWx5IHdoYXQgaGFzIGJlZW4gaGFwcGVuaW5nIGxhdGVs
eS4NCg0KDQpTaWduZWQtb2ZmLWJ5OiBEYXZpZCBTLiBNaWxsZXIgPGRhdmVtQGRhdmVtbG9mdC5u
ZXQgPG1haWx0bzpkYXZlbUBkYXZlbWxvZnQubmV0Pj4NCg0KDQpUaGVyZSB3YXNuJ3QgbXVjaCBk
ZXZlbG9wbWVudCBpbiB0aGlzIGNvZGUgZm9yIGEgbG9uZyB3aGlsZSwNCnNvIEkgZ3Vlc3MgaXQg
d2FzIGRvbmUganVzdCB0byBtYWtlIHN1cmUgcGF0Y2hlcyBkb24ndCBmYWxsDQp0aHJ1IHRoZSBj
cmFja3MuIEJ1dCB5b3Ugc2VlbSB0byBiZSB0cnlpbmcgdG8gZGV2ZWxvcCBpdCBtb3JlDQphY3Rp
dmVseS4NCg0KDQpPa2F5LCBpZiBub2JvZHkgZWxzZSB3aG8gd2FudCB0byB0YWtlIHRoZXNlIHBh
dGNoZXMgaW50byB0aGVpciB0cmVlDQpyYWlzZXMgdGhlaXIgaGFuZCAtIHdlIGNhbiB0cnkgdG8g
Y29udGludWUgdG8gcHJvY2VzcyB0aGUgcGF0Y2hlcywNCmFzIGxvbmcgYXMgUGV0ZXIgb3Igc29t
ZW9uZSBlbHNlIHdpdGggdGhlIGV4cGVydGlzZSBhY2tzIHRoZW0uDQoNCkFOSkFMST4gT2ssIHRo
YW5rcyB2ZXJ5IG11Y2ghDQoNCkFuamFsaQ0KDQoNCg0K

