Return-Path: <linux-kselftest+bounces-26208-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1960BA2F7A2
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D231655FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 18:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC4257AEA;
	Mon, 10 Feb 2025 18:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NxvnFuTs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q8vvz7My"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F776257AD0;
	Mon, 10 Feb 2025 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213042; cv=fail; b=MVThqRnzqWtbnK+pHOTwE/ahyOoHEC1nMRgJ8ctxP4WS3yTqIvecywvc/kn007uZ7RHUrw7XorV+whp+f4qbfbj+7IaaPigrrggGHTwHWF4rIbAUv6qog1rkdgMvWJoM0cc0MNnZnNeCogocLEonAOE0dLCx1alY7JaoHUcx1oM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213042; c=relaxed/simple;
	bh=zUGUcwgocTv6PZT+KxNDFYYGZURMZBhCv7ayaxmFr0M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O6tEFrcXuSOd0+LS9PJ5dYvUcXmS0if97woPG7gN5LlTpGGL3qoZwop+Vm7rQ42jJEUoZqYPAq3du0RmXtbWnxzx+9l+T1qgxbutcqEuybBN3rseuXswxulyJ/Xaf5tU3FboKmTN+YPkEN/U6OQzTki0UpNc+GqRpk+YzTep27E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NxvnFuTs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q8vvz7My; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51AHMVLZ000794;
	Mon, 10 Feb 2025 18:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=zUGUcwgocTv6PZT+KxNDFYYGZURMZBhCv7ayaxmFr0M=; b=
	NxvnFuTsx6MUt3jvvn8wxh/SOv7PO+izzGGScOwIX9ixFB0pjHwvQ6YNQatI34yV
	nfAdfJWErUlZ76qfkHvI1NIWJHimMqgQJI9h+TXh7Xn2F2fFy86Cq2gw2O2JCKEM
	69FqI3QjGbYOnYjZf80PAfMp04B1nKQEE6UGKD5zP1ZZQkky4mIFtQcJUcKrqYd7
	l7EtWFpFDwIBmq6KZyZd4wrB6lIolmo+TI+2LE7t2fz2Os6CsCMomcybl5Fr8kNw
	CuAoOyuW86h6/fj7cNV7j5MdUUoG1T80UjbE0jEXSR/THnGHXSFO2Px2H/nmq+4r
	wElOzOk7l1BEob7/4x11pQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2bmr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 18:43:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51AIa9tI026926;
	Mon, 10 Feb 2025 18:43:52 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq7sjta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 18:43:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAwOceuzveNRRsfx9gUsawuBMleyietCxBKSxz71tabKtZZVABflA0f045IYIplN7nDF4bFG3swMg5fqhdDSmr2OfLBnPQXqpzVv1GsMewP8MupimLanNElI47zG015GLwnCpEYcs91Dd237UQZjOnMn2qmciv2EgqGlGXr0kyYuzJDY2Je6QYYoeJ8prAaZAqTcsioQAylG3SaU3Vxs6A8TIkz7jwgsg1OeqnxIbEF1OcWr+R5NCnLWITjM9pSBskY127JKXEeUzLavBZWTtBMvBivZyDPtGwV3VHUxmrNx9+1joMgPU6AKc840cGlalVJ4IwXDX1YvncOfMkeLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUGUcwgocTv6PZT+KxNDFYYGZURMZBhCv7ayaxmFr0M=;
 b=mWBdnNtL/v1RBnirw/eSYuenI/y4/0dlzSvGO7P3fxDwr+jcGPlfAjWMCVAeXQTh4qLSJTKd2NnirNp9Hm4Yth1KMNMaCzzVa20UXgxZqrAV5NELMXiILJrgpylcqbqro3OiA5TcP+2Kr1+XnrxqnoxxBG8ZLaWdaN+Feiw0RvZ0ooXZto242DCHPTgVlHyup+kTcd12ep2LB7SYWvCGEV7QD+YDVp8btIUObdfIutKtGBZcfy4OcQVsaif3TqdiWjYGd2BxlKeukiIUUZxacdQ9bFCs6QrZNTRpxgk4wxVogUv9poKzG5Fjxeu4fVRMz7R93F7qIpA3Axr4ZCBURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUGUcwgocTv6PZT+KxNDFYYGZURMZBhCv7ayaxmFr0M=;
 b=q8vvz7My6NUPqwk/aN6IlnKuBE9ubnHotMCsFT7UCyYBR8B4f45PVry2CCC+Kp5L6sQLG5rPXBP+KIcHt0G3Qesn74HVGfWN1cTooVmm3yFG07rQlECxd5cmJuT0BSP/M5pUGYzTgugKYAZW9bvi0KcFjfRx808fT6TAHoyRFIU=
Received: from SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17)
 by CY8PR10MB7145.namprd10.prod.outlook.com (2603:10b6:930:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.15; Mon, 10 Feb
 2025 18:43:49 +0000
Received: from SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b]) by SA1PR10MB7634.namprd10.prod.outlook.com
 ([fe80::5d7d:6585:d28f:3d9b%4]) with mapi id 15.20.8422.011; Mon, 10 Feb 2025
 18:43:49 +0000
From: Yifei Liu <yifei.l.liu@oracle.com>
To: Greg KH <greg@kroah.com>
CC: "shuah@kernel.org" <shuah@kernel.org>,
        "kevin.brodsky@arm.com"
	<kevin.brodsky@arm.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Topic: [External] : Re: [PATCH v2 Linux-6.12.y Linux-6.13.y 1/1]
 selftests/mm: build with -O2
Thread-Index: AQHbd1CzXVXDkvdxj0SWfa9FkUurILM4oICAgAhIQoA=
Date: Mon, 10 Feb 2025 18:43:49 +0000
Message-ID: <C8A5840D-B312-40DC-A75D-3BA14614F8C4@oracle.com>
References: <20250204214723.1991309-1-yifei.l.liu@oracle.com>
 <2025020544-preview-worshiper-8539@gregkh>
In-Reply-To: <2025020544-preview-worshiper-8539@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR10MB7634:EE_|CY8PR10MB7145:EE_
x-ms-office365-filtering-correlation-id: e079c152-33a3-4bd7-9f12-08dd4a02dbb3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RlJhaGxqSHFoNGFHWXZlbnlDdW9ES082Zk1oMGxreWNDUDNObXgvY0VvZC9u?=
 =?utf-8?B?TVhuTGtwaE5RV2dOYWdEQmthZ0ZUeTc5NTR1c2JqREFMZFlqS2hmWlA2c20x?=
 =?utf-8?B?TzFTV3pzeVQzQk5YcEdUY2QwK3d4YzZhdzdyVm0vQmM2bmFUMGxZeEJSaUQw?=
 =?utf-8?B?UEthaHpmNVpURnZxa25zdS9EVUhyQnJYK0ZQYXNEYmx3dStGd095eW0vaFJG?=
 =?utf-8?B?NHJyVCtRM00ybEJTYy9LT3RFcmNORkNhTFA3a0hKc1J3ajZ4TkhTN01FbDI4?=
 =?utf-8?B?NVl5UVJUaWMyMkFGMVpJNlgxMnB3c0xkM01pbUE1bUxOZlZSbzZQWm1pdHhL?=
 =?utf-8?B?aUFZNEZ4Z2YwMG8rL3hTaHM1bU04aVJkcjR4Tm5KL3JRckRjaGloNUU1NDZV?=
 =?utf-8?B?VTZkbGFWeStwdkszM2ROVkc3THlYSzFGUUJ6K2hXZ05lRXo0dGE5VFVXd3VB?=
 =?utf-8?B?NFdmSUMxQVBOeXpOcXNGTm1qWnRSNUZzQzNsTExUT09tVkFyVE1xU0pZcTB3?=
 =?utf-8?B?YTZrZFhtUXA0TjlreDRzcWVlQ1pZdTc5UHhyaC9vRjJUWXZncHFSZWpoQ0ZZ?=
 =?utf-8?B?a3N3OEtLblYvNkFGZHdXNlJUeFJFYXA3eC94MElJeFBQdHgxZHpROStDaGEw?=
 =?utf-8?B?anlsV2srVW1Ra1F1ZElra2VCRVp6clJOTnYvVnIrTGNNdjZYdnE5OHl6K2Nw?=
 =?utf-8?B?ajRSUHNpTkU0Z3Z5Q0FxcVZ0UTBHMytPYXk3eXZNUDJIQm84MUMycHZHbHZu?=
 =?utf-8?B?RTZiK3VFd3hhWkUwV0xvWUdnWk9EaUNVUTRxV1BPKzEwSERRV01VVHluT1hq?=
 =?utf-8?B?aFZpeDZxSFo3WnpUUUJ4cGRsVTl5Q3FYa0NBbldwNE1qOCticDBHbW9kbWI2?=
 =?utf-8?B?ZnU4aFJUWFFQQXpxUWh0T1F3SmhPMDlCWDk1ZUFmNkc3NG5yNDJzTnIrc3hp?=
 =?utf-8?B?L1RDUjJzWVRJdzgxYVA1Y2JTTDVkdFUrbkQ0L1JKYXlkVDFLS0VJcmprTkZ6?=
 =?utf-8?B?UnNQTCsxb3hBT1NaUzhybmxuRS9JOGoxaFhLQ1ZTSWxsRWh2bXNJOVlXSEZo?=
 =?utf-8?B?VkNFcWhGYTExWGRsay9ibFZFa1hhVjRDaU9zczQzeTRqS3ltelNMbU14YmJm?=
 =?utf-8?B?QmJZcmJqQ0ZjQnhpdmxZbDdLb2QzK3RYTVpHV2RNaEpuTVgyUWZGVmthd1dK?=
 =?utf-8?B?ZU9mb0l2aE81L1MwTkFqZngwMXVpbzhnbzAvSWVnb1JTNGd2bkRLeGxXKzZG?=
 =?utf-8?B?NWVJTyszT3pUYm5oVnZXUW9tWWhwUjdkUTllWWlaN1hsZ1dqeUNzRnZxRmkx?=
 =?utf-8?B?cFJRZ0xYeDFhSy82ZE5wTXpxM2tmYkFucUlPVjArc29VVndiZUd2WU5YZEZq?=
 =?utf-8?B?eTlDZStJMTdhOUFiWG5yT1ZsNUt5ZzVUTWUxVTFidDZHWlBZTDc4MkdBOGls?=
 =?utf-8?B?VjZUbHo3c1ozVWU5ZFJlTENYeURWVmo2YkFkc21Mc1FuWkM4S1k4aFVkd2xm?=
 =?utf-8?B?T2hYSDRNNzNMZUk0QitRTXFmcmNVZEdqYnJsMnBtM24zWVJDckpZd0taMVVD?=
 =?utf-8?B?bUJOZzQ2T0hJM0M2WmUzenNjS2RibjJzOUI0NGI4UG8relJHdCtOL2JxL2Rk?=
 =?utf-8?B?Tm9UM2VieDF2bGF1RnlZeE1PS2hjbjVkM0x5anNmZk1mb1huNEw1Njk1aURY?=
 =?utf-8?B?WVhEQXhUb2JvTVhwMmkwUVJ0bkJWOHk1L2p6WU9OZVh3dGgvd2JEc3pLNjNU?=
 =?utf-8?B?MkdETERXS1NBc3lndVZqeCttNUJCcU05UHlRb2IvaCtXbFY4bytyR1hhR0x3?=
 =?utf-8?B?SExqcWRKMkQzeFRyTDg2WlNNSDFFY09iMlJmMGp3SXVaNzNjcm1WVTVObk00?=
 =?utf-8?B?ZXk0REc0eTJVTTBSelkzL081SFJHN2pHK0hKTm1rM1JheHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR10MB7634.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1BLRGlackFWVm03aXN6SmJrRVhrM2F2bzAzckZoSENYWXJ5Z1Y3ZC9oQ1F5?=
 =?utf-8?B?TGhFYklFbUllRzVDUDNKbENBNk9xd2FabWpQYUNKL0VVZ1ArRDNGclF3Zlkx?=
 =?utf-8?B?R3pJRVZtV0ZlZTdONVJya0pHVHZMeWtJbVlCRUx3dG5tODhKeENWVVVZZDVQ?=
 =?utf-8?B?RllaVmVFTm8yb2pIU09EeTZrQjBqR01vR0VJOXRtb3RSTXpjdU5SL1ozT1Rt?=
 =?utf-8?B?UVo5NUFIK24za1JWdEtOc1NsUjZMUUNhSlJOem5MYTg4SXBybm5mRHAzWkps?=
 =?utf-8?B?WUk0V1ZyWUlBNEI2bk9XSUlxQStxaGYzYjN0bmJFYWE0TzVLZlB2cTV5MU42?=
 =?utf-8?B?dEg4aFJ2UjBuK05FYldqZUJWQmRNNzVKZEpnVE9McEJINVRHYmw2N29yclox?=
 =?utf-8?B?WVBxVmU5RG8wMmVlcVdOMlh3YXVQaTMxWndSQ0lrL25QZXU3ZkNaQlhtcFl0?=
 =?utf-8?B?emoyY1RkdWN0L3ByTUY5K0oya0U4cmtkVHlBZk93ajNjbnVjMjZES0ZaYytB?=
 =?utf-8?B?ZGlmYllkeVB5WldrNnZBaHVKOXZLcm0xUUNuMk10K1FzQTcvSGQ2bHZobjc2?=
 =?utf-8?B?TllHMitaUGZ6dkd4OWM1V0l4SGpkN2RwR1dTbVdyS2hsVnVseXZDckI2NmUz?=
 =?utf-8?B?YzFqbERUMjNDeU1FZ0w0UTRRRklmQ2trUFZ2Slc1ZVpic3RXT1drZ0k3UUti?=
 =?utf-8?B?UDEvT29vR2ZCMW1aMFMxR0FwdS9NREhjNXBFVmwvMG9RUXd3YVliR1RrS3lu?=
 =?utf-8?B?dGlIdTFUcHQreld3YU51V0xPcy9JM0UrSmdralBOdFBycmtYbUdJaUNjZW5k?=
 =?utf-8?B?YW0rV29Tbm1iWDUxdVBXWWd1dTV6MGtwL2dQYVlBazk3QjFxUW14TDRUcWpj?=
 =?utf-8?B?dHBYMUVQMVNrMTRldUJzeHo4N1pvOWdVY3hNUkkxSWJsTzZySkpSSnpUaGt3?=
 =?utf-8?B?SkFHN0t2ZVV6UGduZFJKanB0a0FhOER1QVZoOEF6b2RoRjFhN0hGVU12MWN1?=
 =?utf-8?B?eDVTRmpMWnpxOFR6ZmxPYndNSnZHOFNFUWNNSXQ2bHprbFcwOFRhcGM0OWZ5?=
 =?utf-8?B?bFp6NFhnT3dGNXNIK1ZpY0o2VlBBNDBJSmNvM0JjeHBYR3VlT00rTk5ZQ2R4?=
 =?utf-8?B?bVhpLy9zcmNTUlJSSkZJWFllOXNHWlRXcXVwMGY5b3FQUzFoa1hzeVBWYVlC?=
 =?utf-8?B?ZFBjeDBOQzRhbm1sVlZPeEs1UnJWMTlEUHBENTc1STFZcHIwWGw4QzlJeVJP?=
 =?utf-8?B?eDJHMGR4QTVwVmU3VzFMd3lIdWMxM0k5QnJHTTVQYWwxSjNCTkNmNjhCWkE0?=
 =?utf-8?B?UUFKMUFPTTZUaml2YWdObVk5TXJHekNkUlRRTGM4ZU5IM3NseUkyU0lmZWdj?=
 =?utf-8?B?dzFyMlV5Um5PV0dwQTVjSUc1bTQydklIaEV2bURjai9hZFpVQWFIRi91aTYw?=
 =?utf-8?B?Qk0xUFZpK2tVd0NxUGJqeHc4dDlmTWk1UExqZEp6SUxURVA3U3pJalRQc2pz?=
 =?utf-8?B?WExOcUgycFh3NFl6UnF2Z2g2bzRJaGJjQkJIbXVDOEtUM0ZoeVZOWXBERU9z?=
 =?utf-8?B?Vko2NnJ5aDBoQldSMlZNRDV1RllaYytubklQOW8xbVdiK01lWU40OEgvaTBJ?=
 =?utf-8?B?czJBaVB2WVMxTDBHREpCRXppU0JWV0Vzb3BkM05TWXdQSGQ4S2krWGk1djln?=
 =?utf-8?B?WVpMbC92MXpaWDNtZ0dkMnNFMWROT2t0K2pNRmFUdjcxT2c2Y0lhcFJrTXdr?=
 =?utf-8?B?SmdUa2hIOW8zMi9xQXk2MGw5elFIRFlxUjJLVjZWbUJmUUlyVnBzaXBSR3Ru?=
 =?utf-8?B?RXNsQVFsTHU3V3E3SGtUblRsdXdxZ0pIVHVDVmk0dDlsQWZzaWluMGFWZFV0?=
 =?utf-8?B?OCtZMGgrRmh2NWx2RkpQNlc1QzFiZ0VWUFZFbTJDcWptYnMveW02T0w3ZHJ3?=
 =?utf-8?B?cXFIQXpnWThlWFlDNkNyUmhwZVRjMnl3c2tRZ0JuUjFLV2xuNWJVOUJSaDZw?=
 =?utf-8?B?OG5FUHc4c3JDVWNXVTJuNzZqOG55MEM1S3V1Q3JrQzlQYWJReU9pZlUrWGVO?=
 =?utf-8?B?ME05QXhVdWZKN3dqNnI2cmVCUFNvZHBmZHRYazMxVUdzdzJ5eUJYci8raTc2?=
 =?utf-8?B?TWRJZ1prbnFDQWZRdTF1ZFpPRDR0WXlZUklBWkltcklmZUt3RGwzQytiMTF2?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1502E7A520FC9F428C095A5866758C0C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rNoTw86rntWrL+cPsKv8TavSKIao5DNzaGPVWixYrJEzxG22fMf8yF9V6n7dnefMtR6BONikNVTmFALx0hiNRNDYYy2QLdxXwmDhTvJX6DQLU/TrgJ2HEUIOHQktAyokNRS4tIMeGr8tCsJZds/1GJXsSjvPIarsuU06S2x+gZMf5lUb3lwNUhSgv3ZRwbBtxxu2A8n/NqUX5RsT6/jcrpnRDMbfrdRrIgI8HVzUpf7WRSBIjluiKNkWDHE/LPYt0a77uxxsIQN2yZ/IZ9AzRhYlnIB5I90FAzvErQHCRNuBS+EicpmdtrzefT0P9ptujTs281QrTfz9wQUWBoMYvRir60RMcmH4Fl4tqMmZGXEqQGSOiPOsm6bbM9RmvEp/xke8DMRD94u7TM7heISvtE8DKJV33wJL0oMiLM8t4uxDg55eX9ImOXWn9jXpi2oxc74vbDjJ/iS/QbjT9yCh3Lc5RReeKxnXx9FvhLEocRmTHcYIlz0ZZJ5lGB8rQFzg285UFCZ6upQJD/3AgQ2+/kJQkFGMEZNJFzRW5ItnIilLJ51c3crMU5bkWzmPKfQsBo0XNY8bHz4TNktjl9n81eL4+b6z66t4k6tVRM+tQNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR10MB7634.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e079c152-33a3-4bd7-9f12-08dd4a02dbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 18:43:49.2336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH1l2xfEbLZ6ckkwNoNfOK6vH5s/GTJvk/q9iRH3WjxFnU0ONcosNR+tFHKJidE2PNjPse+IxJd/20rwTnV4mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_10,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502100150
X-Proofpoint-GUID: 4u2EIqdGxkW-bQZgEd3dNeI-WCRWUJzx
X-Proofpoint-ORIG-GUID: 4u2EIqdGxkW-bQZgEd3dNeI-WCRWUJzx

SGkgR3JlZywgDQpZZXMsIGxvb2tzIHdlIG9ubHkgbmVlZCB0aGlzIGZvciBsaW51eC02LjEyLnku
IE1heWJlIHdlIGNvdWxkIHVzZSB0aGUgdjEgdmVyc2lvbiB3aGljaCBkb2VzIG5vdCBpbmNsdWRl
IHRoZSBsaW51eC02LjEzLnkgdGFnLiBPciBJIGNhbiBzZW5kIGEgdjMgd2l0aCB0aGUgbGludXgt
Ni4xMi55IG9ubHkuIA0KVGhhbmsgeW91DQpZaWZlaQ0KDQo+IE9uIEZlYiA1LCAyMDI1LCBhdCA0
OjE04oCvQU0sIEdyZWcgS0ggPGdyZWdAa3JvYWguY29tPiB3cm90ZToNCj4gDQo+IE9uIFR1ZSwg
RmViIDA0LCAyMDI1IGF0IDAxOjQ3OjIzUE0gLTA4MDAsIFlpZmVpIExpdSB3cm90ZToNCj4+IEZy
b206IEtldmluIEJyb2Rza3kgPGtldmluLmJyb2Rza3lAYXJtLmNvbT4NCj4+IA0KPj4gWyBVcHN0
cmVhbSBjb21taXQgNDYwMzYxODhlYTFmNTI2NmRmMjNhNjE0OWRlYTBkZjFjNzdjZDFjNyBdDQo+
PiANCj4+IFRoZSBtbSBrc2VsZnRlc3RzIGFyZSBjdXJyZW50bHkgYnVpbHQgd2l0aCBubyBvcHRp
bWlzYXRpb24gKC1PMCkuICBJdCdzDQo+PiB1bmNsZWFyIHdoeSwgYW5kIGJlc2lkZXMgYmVpbmcg
b2J2aW91c2x5IHN1Ym9wdGltYWwsIHRoaXMgYWxzbyBwcmV2ZW50cw0KPj4gdGhlIHBrZXlzIHRl
c3RzIGZyb20gd29ya2luZyBhcyBpbnRlbmRlZC4gIExldCdzIGJ1aWxkIGFsbCB0aGUgdGVzdHMg
d2l0aA0KPj4gLU8yLg0KPj4gDQo+PiBba2V2aW4uYnJvZHNreUBhcm0uY29tOiBzaWxlbmNlIHVu
dXNlZC1yZXN1bHQgd2FybmluZ3NdDQo+PiAgTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92
My9fX2h0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNTAxMDcxNzAxMTAuMjgxOTY4NS0xLWtl
dmluLmJyb2Rza3lAYXJtLmNvbV9fOyEhQUNXVjVOOU0yUlY5OWhRIUpJeHBiM19SVmNpYmhucnp0
bGZHYVZlUlVJbEw3ZnREYS1ob0lNVlliM0l6SlNoSl82QnFxMHFOb18tTEl3RlNiYkZ3X1VnVTNC
WTAkIA0KPj4gTGluazogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGttbC5r
ZXJuZWwub3JnL3IvMjAyNDEyMDkwOTUwMTkuMTczMjEyMC02LWtldmluLmJyb2Rza3lAYXJtLmNv
bV9fOyEhQUNXVjVOOU0yUlY5OWhRIUpJeHBiM19SVmNpYmhucnp0bGZHYVZlUlVJbEw3ZnREYS1o
b0lNVlliM0l6SlNoSl82QnFxMHFOb18tTEl3RlNiYkZ3X2NLd0dIZmwkIA0KPj4gU2lnbmVkLW9m
Zi1ieTogS2V2aW4gQnJvZHNreSA8a2V2aW4uYnJvZHNreUBhcm0uY29tPg0KPj4gQ2M6IEFydW5h
IFJhbWFrcmlzaG5hIDxhcnVuYS5yYW1ha3Jpc2huYUBvcmFjbGUuY29tPg0KPj4gQ2M6IENhdGFs
aW4gTWFyaW5hcyA8Y2F0YWxpbi5tYXJpbmFzQGFybS5jb20+DQo+PiBDYzogRGF2ZSBIYW5zZW4g
PGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4+IENjOiBKb2V5IEdvdWx5IDxqb2V5Lmdv
dWx5QGFybS5jb20+DQo+PiBDYzogS2VpdGggTHVjYXMgPGtlaXRoLmx1Y2FzQG9yYWNsZS5jb20+
DQo+PiBDYzogUnlhbiBSb2JlcnRzIDxyeWFuLnJvYmVydHNAYXJtLmNvbT4NCj4+IENjOiBTaHVh
aCBLaGFuIDxzaHVhaEBrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogQW5kcmV3IE1vcnRv
biA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4NCj4+IChjaGVycnkgcGlja2VkIGZyb20gY29t
bWl0IDQ2MDM2MTg4ZWExZjUyNjZkZjIzYTYxNDlkZWEwZGYxYzc3Y2QxYzcpDQo+PiBbWWlmZWk6
IFRoaXMgY29tbWl0IGFsc28gZml4IHRoZSBmYWlsdXJlIG9mIHBrZXlfc2lnaGFuZGxlcl90ZXN0
c182NCwNCj4+IHdoaWNoIGlzIGFsc28gaW4gbGludXgtNi4xMi55IGFuZCBsaW51eC02LjEzLnks
IHRodXMgYmFja3BvcnQgdGhpcyBjb21taXRdDQo+PiBTaWduZWQtb2ZmLWJ5OiBZaWZlaSBMaXUg
PHlpZmVpLmwubGl1QG9yYWNsZS5jb20+DQo+PiAtLS0NCj4+IHRvb2xzL3Rlc3Rpbmcvc2VsZnRl
c3RzL21tL01ha2VmaWxlIHwgOSArKysrKysrKy0NCj4+IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL21tL01ha2VmaWxlIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vTWFr
ZWZpbGUNCj4+IGluZGV4IDAyZTEyMDQ5NzFiMC4uYzAxMzhjYjE5NzA1IDEwMDY0NA0KPj4gLS0t
IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbW0vTWFrZWZpbGUNCj4+ICsrKyBiL3Rvb2xzL3Rl
c3Rpbmcvc2VsZnRlc3RzL21tL01ha2VmaWxlDQo+PiBAQCAtMzMsOSArMzMsMTYgQEAgZW5kaWYN
Cj4+ICMgTERMSUJTLg0KPj4gTUFLRUZMQUdTICs9IC0tbm8tYnVpbHRpbi1ydWxlcw0KPj4gDQo+
PiAtQ0ZMQUdTID0gLVdhbGwgLUkgJCh0b3Bfc3JjZGlyKSAkKEVYVFJBX0NGTEFHUykgJChLSERS
X0lOQ0xVREVTKSAkKFRPT0xTX0lOQ0xVREVTKQ0KPj4gK0NGTEFHUyA9IC1XYWxsIC1PMiAtSSAk
KHRvcF9zcmNkaXIpICQoRVhUUkFfQ0ZMQUdTKSAkKEtIRFJfSU5DTFVERVMpICQoVE9PTFNfSU5D
TFVERVMpDQo+PiBMRExJQlMgPSAtbHJ0IC1scHRocmVhZCAtbG0NCj4+IA0KPj4gKyMgU29tZSBk
aXN0cmlidXRpb25zIChzdWNoIGFzIFVidW50dSkgY29uZmlndXJlIEdDQyBzbyB0aGF0IF9GT1JU
SUZZX1NPVVJDRSBpcw0KPj4gKyMgYXV0b21hdGljYWxseSBlbmFibGVkIGF0IC1PMSBvciBhYm92
ZS4gVGhpcyB0cmlnZ2VycyB2YXJpb3VzIHVudXNlZC1yZXN1bHQNCj4+ICsjIHdhcm5pbmdzIHdo
ZXJlIGZ1bmN0aW9ucyBzdWNoIGFzIHJlYWQoKSBvciB3cml0ZSgpIGFyZSBjYWxsZWQgYW5kIHRo
ZWlyDQo+PiArIyByZXR1cm4gdmFsdWUgaXMgbm90IGNoZWNrZWQuIERpc2FibGUgX0ZPUlRJRllf
U09VUkNFIHRvIHNpbGVuY2UgdGhvc2UNCj4+ICsjIHdhcm5pbmdzLg0KPj4gK0NGTEFHUyArPSAt
VV9GT1JUSUZZX1NPVVJDRQ0KPj4gKw0KPj4gVEVTVF9HRU5fRklMRVMgPSBjb3cNCj4+IFRFU1Rf
R0VOX0ZJTEVTICs9IGNvbXBhY3Rpb25fdGVzdA0KPj4gVEVTVF9HRU5fRklMRVMgKz0gZ3VwX2xv
bmd0ZXJtDQo+IA0KPiBUaGlzIGRvZXMgbm90IGFwcGx5IHRvIDYuMTMgOigNCj4gDQoNCg==

