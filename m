Return-Path: <linux-kselftest+bounces-31937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 101BEAA1C5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 22:44:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4131BC4093
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 20:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890D268C6F;
	Tue, 29 Apr 2025 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OuKCGtDj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C+3gbhNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9672F259CA0;
	Tue, 29 Apr 2025 20:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959445; cv=fail; b=FGTGZHIjamTMX4ik4AROQGEMYn1k1uVj/HCOBpmstZpX/O84gaJ6AyRAGMF26vA2sR04ao31Szhyh/N+3Pz2eDIra2qEjLMrLheLAQJNN47F/Z1w67i151BlI9n3Cgmjt1xueBE7m67cHhrgiJKFHeDHn+xRQ7Wl/wqDzqdD/hk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959445; c=relaxed/simple;
	bh=XmRcx9rn+fuvEnQ0vaeT3jhJwPdK4yCs7Ad33CeFEjQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ON0Y6pPqOzWv68yNrda8iQ6Zcl3wKgXfSGprqiVd4H2nOpZ4vGbjOBVZQ6iN3K8W4FrCEPY8QVBaA3j28yVIw6oEJW11jNc8D9Pjlc9dfZ80dd5VEBk27emAK2mttGMFXxE1EFbp/5JbWz+HAc/ZRcENDQYxWU2PzyWoeaGVGPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OuKCGtDj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C+3gbhNw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TICT5v014917;
	Tue, 29 Apr 2025 20:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y5I0jYNxWALyP2swo1yzwIG/OD4Qf/mxamsboZZ2r9E=; b=
	OuKCGtDjdF8+bnlskjTLXSYUxKA8F/xBJw2BpzELfQuYsIGCnn9/STlNz/RnBUba
	45qjJGfTiQcjA21HC30PjDhSwK0HXTL8VUKCv+eQDKNtmzTW4GV663B2sNWPBx/r
	j+6AIb3BUK52mgvGdJV/OhWRjEiA0MV6EEYYbTLUXvQYDBg7IGHzZUts7H1oILh6
	24N2/d8E8Fn6CJaPqgAXZOAvxYvdbzzsYUTBOcDMYV/rkqjLp7OwhNMZRvTMTSGJ
	3Gv9LVek66EqeMifmBc2odE5pQnS6sTzmYePtRoXypX7SB30NPdr4EzjJFZ46YqD
	HDILPpZXKeI+I0sqbDixAw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b3ubra1h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 20:43:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53TKa5Af001466;
	Tue, 29 Apr 2025 20:43:35 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012036.outbound.protection.outlook.com [40.93.6.36])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxadrt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 20:43:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kfY/4/vgYsUWbE6/0FMRdNbDXtkQGAtbenzH1qjVL23Ws8Yi8SuDYhuT7OYlhjczaWfuuWTWHxFQb0jTUFYf5mPebUtqrAbUXTalyqLuiycyOCC7CWVvbIjYhBll4sTxzp0kGYzcUP8AZc7J/eBP22rA9CcjQSoxMtwbkd0k1zsq510U+53fcLFSCV/bq5UroTPgWjj5VzS54f05jJugYuFX6xZEOOllMSoSS1idmYqnqB7xszgm3SWL3AhtLqCT+SDseO+75EW9IvC8hzYFbSvY6gth5gcjZcyWEqi3whNL7bU/y9RBO1d9BeVcq5vXuRpsa3VPiceAhrGxLNshWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5I0jYNxWALyP2swo1yzwIG/OD4Qf/mxamsboZZ2r9E=;
 b=SFzCVY9G1Sas9W0fUuyezkFkBKFH9X6x3RKw62lbhl0j0o+lvQHv3c5GDPbfzkE2+gMjVWoet3oIunNcG1d81kEN5nykDc6pqpQ09G3Pbvh3ZINYSfggoQN6CS7d8abfJOs2/rW0YiAYh/ohpmX3AopCpbfpMngMq0XLg9IUwfLLXELmUxbDSYWnR6l7L7RBgI96attF57t4UthYpsP4IfTDn89ummzol48gG+ZX+LR7H9x7IO/n9RWoGoYvHncli39cdVV30cH0zrmyfCUnQfcDLlQa+z9urOHn98SG3TuqIax9KzFWOE2gU6ndXTfGGylYvWLC9ne0b+Uy3hpaIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5I0jYNxWALyP2swo1yzwIG/OD4Qf/mxamsboZZ2r9E=;
 b=C+3gbhNwN/yOAcO1hIwS3PTbNSQOY29GzpgZDsIzYtUDBbtl/GQi/X7StMCY/ZK85fG123SCBo1QWDMAPSUdkuf8gv8MkOllOmDfJY5tdAyoxf2SKAIHfo90ATsA+8FdS2XM8TvGwGXzURweHkRoeDuOyc7sVN+AVxdY/NAPsjU=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS7PR10MB5166.namprd10.prod.outlook.com (2603:10b6:5:3a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 20:43:19 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 20:43:19 +0000
Message-ID: <8a21f8b0-b67d-4484-8a47-1d68129b54dc@oracle.com>
Date: Wed, 30 Apr 2025 02:13:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/22] iommu/tegra241-cmdqv: Do not statically map
 LVCMDQs
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
        corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
        peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
        praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
        mochs@nvidia.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <3981a819a4714b21d11d5c6de561a2d0c6411947.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS7PR10MB5166:EE_
X-MS-Office365-Filtering-Correlation-Id: ad4939b2-8604-49f3-aebf-08dd875e7936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGNQK3pNMzlLM2pJcTZWN2E4NXAwT3AzK1oxZmtoZllXLy90d2xNVENrbU1Y?=
 =?utf-8?B?bkMrcC9xcDZKYWY3YkJFQXEvcW9FSHQ2Z2pDQ2h6b0JsUSt1bEtqTGtlR0Zp?=
 =?utf-8?B?WURGRWZYUTdEcytsUHUvRUFpbDZEaXI3ZTlxbi8raGlXYW9kMlZrRzczaHVt?=
 =?utf-8?B?ckRtMGRjcW5XOWNQNHJWcmN6Z1VEVVFxdmpHOS9KOVVCUFd4cHdoMEcrSG1p?=
 =?utf-8?B?eVlwTmUzYTNMQWQraUg1dlJSZGt0eUIwWlBTTFBBMWd5d3RyK0Vqd2RqQjNN?=
 =?utf-8?B?dktHYTVuUnQzS3ZXWTVkS3VleDZvRmJ0UDdOZkNncnlFQ3N4eURxRlBnNTlr?=
 =?utf-8?B?WGdjNFloU0dPOU9LS3FXVm5wVDJjQWZhemhCNlpnZ2dmVDBZMkErU25qUVU0?=
 =?utf-8?B?T1NIQXBUcXhiZ3V3MzgvNU1JWTJZR1RhcWRieU52ZlA2dk5BMUdCdmZTcmRI?=
 =?utf-8?B?aHRTbG1EbDQ1amxyUnpveGdQOHdVNDFURWJVMCt4K213aGdZR1Axbm1TdVpu?=
 =?utf-8?B?eVVkWnQvcGkvYzFrek1YOUlKcnJVbWp6YmdNRXYzb0hVZXF0VVA0QzVWa0ZN?=
 =?utf-8?B?c3dnNmpFRUFrTGF3enVUTEsvNE5JNGRDL1VGWmZ4K0d1cDJzSEdKR0p1R3hY?=
 =?utf-8?B?ems5SklhZC91azFLTkQ4MHd5MGVjNE1YTDZBbVh2LzcvbE9iRDJnMExVOXVk?=
 =?utf-8?B?dU5sSGg0S3BTaGlDM1pDckJ1c3dSOE1QSHJuQ2lWT29KNlM3QkR1dWwwSzhC?=
 =?utf-8?B?SU1jN09TUnN6SEZSdnJ0VC9OVzd6Sk1PVWNSQTl3djVMOFpDVHpZaTVGeVpu?=
 =?utf-8?B?ZW5KeVNLL0h4V0l5QzBibDZpellXc0pyUC80alhNU3JuUzk3QnA5MVZ3Zkc2?=
 =?utf-8?B?MnNsdWVEOCtsTjFud3BQSWI2M05oajcwVXpqRXR1dzF1Qzg1RWtsL3NSaDdV?=
 =?utf-8?B?MWVTMUhnYmUzanhRcDJyd21OZnA5SkdZWnJoVmhPdkVEc3dqSGdKWlBWU3hp?=
 =?utf-8?B?Ni9ockkvTk9kNExYcEpOVEcwZEkzRDJvWGlpZkwxa1kxWndmODRQUnF5M0o0?=
 =?utf-8?B?YVFEYjJ3ZGU0Z0p2NkNYRHg3ZU1pMG1KVjdMTlpZbFYrdFF5eGxyazVLSUdo?=
 =?utf-8?B?K0hicnlTT0FXZksvZkRpby9EaWN4UjA1NVhuTFN1Z0MzTi8va2w3RTdFbEVz?=
 =?utf-8?B?amdjN2EzSGdZOHV5RDYyR0JRbW14K0ZLVDN4S1ZITFEwMXlGWW9GYmVYSXVk?=
 =?utf-8?B?N3c1VnJaZ3pMcEVKLytTeHJvSVEzb3h6UmFTZVpweEtWbUxxbkxlaHJ1QW9q?=
 =?utf-8?B?dnd0bksxMlNvWEtwNnZMY0JJN0Y3WlVBdHhEYXhvK3lkbXZ4YVRzRjgxejNV?=
 =?utf-8?B?blhzWTZDWkxwZko2MlJRUkQ4dnFuOHJ2anhUNVkwNXRDcjd4QUVFSmI5a0kv?=
 =?utf-8?B?MU93RGxJSTBrOWVQWXZHT1lDdHlrK0QxbzZtaEhaclRGT3V4NXFBdEg3ekhv?=
 =?utf-8?B?eEYrS0U1OEpsMU9TUVNjdVhKSUVtOXcwMlA2TjE4NUh4UXhZdGhXN1FTNzM3?=
 =?utf-8?B?Z2hwQk5EMDVqQWdWY2xYYnFLVnAzbFFBdTZKZFpNbG9hVW9zaWNwbVJrZ2xw?=
 =?utf-8?B?RDRLSDNYcnhMMHpwZHBvYWE3ZHpKWm9qdnlhSTVpc256L0pPSzdnK25JbkVD?=
 =?utf-8?B?UTlOWkgrZVlIV2QyS0h3UExTWjQvZFg4MkEvSTJubE10cHJrSVlTL1g2TGhu?=
 =?utf-8?B?aXhVRytkVVdxOTVsaG02cGdUTTY5SEFuckRDUEZMM0RVbURkemhKOXpXQVUr?=
 =?utf-8?B?T01tMTdMbmFPZ0U1SW12REU3b2YwU2FDdExUa3piZk9CTHk5dHhtNmZwQ1Rx?=
 =?utf-8?B?NFZENjJ3L21YZTdVQ2JLaG1iL05aTnZmWURJOWxHUi91a3hkOVhqL3JKTkZi?=
 =?utf-8?Q?oORIDYz2+Bk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHZSV0lRQ2pWeDBKZlcyK3k5WDZkSE1qMDJPUTBvV3ZDeFBSOVRlUERWZ0Vn?=
 =?utf-8?B?NEo1OVFwUnF2WG1GUVErZ3dEdjVKdU02cUdQTVQvNXZab2ltNXBRWTc2VVp3?=
 =?utf-8?B?bkhMWlc3WTdoSEdQVkRJckFzTENxMzkyNnI4ZW5KL1AyZzNHYXVJdForcWpO?=
 =?utf-8?B?aU5sVHR2V2NvUUFNTmcxRkFSU29adFRxOFQ3OVhsdm4wQWFYZ3lUcTh0WHRm?=
 =?utf-8?B?U05WVE5SdElyUDh6SkI4d3RRSkhZNkRYUTZnKzljUWFhdGk3TjNNS1V1dmgw?=
 =?utf-8?B?UXljMEc3WUMxTzVtQ2NWZmpqSkQ3SXBPSGJUWmUxMlJxQ3VhMU85TTZESkhW?=
 =?utf-8?B?RHk1bWJ1OXo0K2tLSDh4MXN1ZUZESXJyRi9abWZGSHJxSUYxcGZtVXdYR1VL?=
 =?utf-8?B?enBaNzVUejJXd0JObm9nTlduYVEvNm5CdTdSNlFlMTlsVVF2THllZG5Cb08y?=
 =?utf-8?B?N0toTXh4a1FxWFErMWV4dmZVdEVUb05xUUNtRENFUDM2b3hvYkllcXZaSGlN?=
 =?utf-8?B?MWk5dDNQQ2VmNllOZ0tNZDdSdU0yUTVnWkZlTG5adTRodzNucGRVVHY4S3Vj?=
 =?utf-8?B?NHhqVGpiVWlnYmxaVHRuL1dGZWFJazhpRkZHUVM4NHU3U2lGay9NOEJqanZR?=
 =?utf-8?B?c0JySXFZSmxnd0ZhWjF6L0VJT1hKTXlRcHVnQ2E5TE55dVI3V1p2QXFPVGtK?=
 =?utf-8?B?cGJVdzhhREMxQjlWQnhRMDJ3NlFMbFJZTEIyR1l3dUVXbDl0L0Z5SlRBaU9k?=
 =?utf-8?B?ZHdBVVN0WmhXMUJaL081NXNkV3BRYUYzdDhOL1lFdGpHMFpMRVpudGNhMXlL?=
 =?utf-8?B?TXI2cGRUUE9xWUJSOVpzM015cEdncFR4RXIzZkJzQnZDZVU0dVJTVm51MkJu?=
 =?utf-8?B?T0VOWk11NkVHbDQvV1FFVkFyZ2NBend6VDBWY0twdjlYOUJZOFZwWXd4OHBM?=
 =?utf-8?B?d0YyYlZCQWFvcDVTZmxBVHpUdkdBMS9OeDVRVFBFUC9hWW5COGM4d0ZJNUI0?=
 =?utf-8?B?K0tmNkQ3bjRVTk9PcEc3S0h0UUV3YTFUaGUyMG12MGVMYnlkYkIyZlhMR2x1?=
 =?utf-8?B?UnVjU09DWDg2eFdGcWgvU0dnVDZtMFZEM2VSMUI3SGhVclZDTHRoUm44OThL?=
 =?utf-8?B?TWRDMG1pVjd2TkJuSlVoNkdkSjYrRXBTaHl2Z0IwMllPQW02ZnNubmNnWmhQ?=
 =?utf-8?B?T3pBMUMwL3RYMUZ1L091NTNsYVRMZGZZdTFnTjJaZmh2WmovSlFjUnAyVTNi?=
 =?utf-8?B?M2FkTk1QWUpJRDdkWlZvZGxxNUR4QUxWNTFlWnhnZzZoSitadjBJL0xRZU5O?=
 =?utf-8?B?QkliemlKbkEwbWEvSDdmV3RnT2ViZFlIc1pMWkd2WDdMMGFHY0JEN0tZNjlE?=
 =?utf-8?B?c0RFNTBNOTQzdDlEcExKUVFRdkVMVklVZmJOSVpXUm8xelZWMmhOZ0Iwc0dT?=
 =?utf-8?B?UjZSOHJlUmtBL1BIWm43emNRUU56YWxDMEFidWJ1VWhsTm5zenNleE4xNUYy?=
 =?utf-8?B?VmJmTlVpekoyMDFLVXdMOG1LRllXZHpzY2R6dmxHTW45aDdFMGRRdFdRSFd6?=
 =?utf-8?B?Z1pYSFZicGJiYlhtNGRSOHdXZytpdVMrR1hsMktJenVCMEY1MmNiMkxHTkdL?=
 =?utf-8?B?MHQ4WmhweUdjd0RiM0FYT1gyTnFvN3RpczBoekcrejNNY0p2YnBERXNSS3Fj?=
 =?utf-8?B?RXI5aEg2WWJvMWUrYnRSd1g2VkJ0RUszdHlHNElPVzVtM3ZidmlIcDA2dUVN?=
 =?utf-8?B?NTJkajNZdFJ6TUhMTk1zQmlzeGlwMHppcVdKd0VySGJnRmFyK01CZVNLc2ww?=
 =?utf-8?B?SEJ3MzBGKzJVTDBXQ1BXYnpxbTBiZ3ZNNnpXOXJPaW5kMlBJalpOSlEyOC8v?=
 =?utf-8?B?WW5zRVB2QUhuZGZLZ1BudUc3bkxNNmFHNTA3SW9kOTh3YzhHZXdrQVFZY1F0?=
 =?utf-8?B?bU9pbCt0dlBSSGtUdVVMSXI2RG5uNjBIaHZWNitmaFduMTBESHRnN0xTSFhw?=
 =?utf-8?B?Qmc0eU5PSDZycG42ZHcvNlM5ZlRpNnJ2ZlVTMUwyQTJBWWFQL2FEVUNJNlBa?=
 =?utf-8?B?QnZkZVdaK1c3a2FxS2NGQ25jbnhsMS8xcG1KL1VVQ095aktaTXhrNlkzQW1V?=
 =?utf-8?B?d2Y2Zm93VjEwWTRHbDBoZkFkRGRoQkFHTlB2ck5OVVlwVk9xS1JWWmtPY0wx?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y6FdjuhAFs8j8P4No4EgQyYv/t5QSNaQwn+1oJSPUEef5aAcYtJb9Z5uoWCEQWOZLuAmwhKtWw0lHjZ9RLE2/LSBYQbwlK1MC2blrmWlj2I6a6KwP5nA8VEI8dFJ7Pv5BZEiMSh8psiMgdSmNGAaXhQOqYS6Q+/hrxzB+bpD5f38qDRlzKpMaN45rwQS6AuNcx6t7cpMEebqDhkKcKpWER/8/3oinTFFMJ6WXV9DLbhywECdo9j8M+tPOBDu9HVZIqGavpieJtdbMQyIe9CDaI0fGlIDvV5ntaNyqd824GLdRjcEZcCzNk9H9flDqJDETlLNu4Jk+EoYoDTw0NUxMZ4yS4nsFzriNGGke3LoZkymwOKtmDaaxs0MNCW/BUnXMmFqZzyCErsShsH1QwfRKXDzBSWGya6ubvgJ4I86L8+UNMzU3zc0NSO0rmbYOhd1DX5B8y+ILQER9V9G3EMvduE0DEtsreMoJPB/OiAVAW2IQG7fPv//MaitNGEq3kI6pAA1KlPnQ5GAb45dQMNp1ZzEiEJK3ZC0ayCkxCM5fGtslPjlwt6JciZoFHlW32eR/kKtofzaRRtKwGKDIDaeIwfaju8YfxEvV0+zn/PKF4s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad4939b2-8604-49f3-aebf-08dd875e7936
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 20:43:19.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CwHs5j4p8Qwu6a9A4v9a/Turg3cOLoGFCR0odzDZGZqZ5NXaviFjoG7lwpM4xU2MlJ5TyFZOcfwQLKkkxnEaLni7qJP6VqPjZXofw3OcdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504290153
X-Authority-Analysis: v=2.4 cv=NObV+16g c=1 sm=1 tr=0 ts=681139f8 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=EV3XLQGZA2RDp2AoBrwA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 cc=ntf awl=host:13129
X-Proofpoint-GUID: PyWQfnqklMVqAjTSXXKOWcHSUjNZkWOC
X-Proofpoint-ORIG-GUID: PyWQfnqklMVqAjTSXXKOWcHSUjNZkWOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDE1MyBTYWx0ZWRfXyVwCsH7sV9rd z/ZcJTyFmB51FNUzGKUwvuSUYkrlhHNnN3QZgD08I9LeBT6jfc4rO/BxGNCfYey/ZReyY24YAXS ppO/vQCPMJ5avFvSZqREsBn5I8yp7udHUxgOZ/6gDy6zPupbnHx8LBRERHBOIRS92s8Gi3nfwce
 yVkZaP56CUb8Rd4DiSCDBai5tFyu625vzTxEuxOPRoSQ96IliE2Bljfmv/YJJrcLBFzjrp1xG+w LG3+GAqYmmgEO74QuYzYugps0OcFIG2mAtKaoI6GIDVfna+Wgq1BLs11sqmjlz+pnGJYOiG5Xxl PRLI4CsVkRexdc33ehHVtNJ7riqI2+qCP9y/AofxC/7qUXivEL3sRZAtO2qQOcET4afbpzwvg8o Z4jPhrlV



On 26-04-2025 11:28, Nicolin Chen wrote:
> However, with the user-owned VINTF support, it exposes a security concern:
> if user space VM only wants one LVCMDQ for a VINTF, statically mapping two
> LVCMDQs creates a hidden VCMDQ that user space could DoS attack by writing
> ramdon stuff to overwhelm the kernel with unhandleable IRQs.

typo ramdon -> random

> 
> Thus, to support the user-owned VINTF feature, a LVCMDQ mapping has to be
> done dynamically.

Thanks,
Alok

