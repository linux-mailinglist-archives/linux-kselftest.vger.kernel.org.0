Return-Path: <linux-kselftest+bounces-32431-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BBFAA9BE2
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 20:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DEC3BEC33
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBBC01C4A10;
	Mon,  5 May 2025 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X4MkqfY8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Brc7CboD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3A525D53B;
	Mon,  5 May 2025 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746470947; cv=fail; b=ROAov+BsGRU6vL3SkmTgLMNSbDToGVd7r7bIbQ3T6lLyRtjCECJWoEb0ITjAHGVPwcRTW1ZsZXqPhDhgtU456ctebhAtzXXAO6chTdPbGEJ6jEXTILrPvfTvVzsl/VuOC99Yapy50vBJSjqQasz4FTcHtaqri2gqn0AfHy0dfDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746470947; c=relaxed/simple;
	bh=8mT8e3lz0kH4bnTRJGNdn3NhWCc9p2Cr+G2pAcXKnOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CbOFdTBhnpW+k0oM0+XI35yob5UxD5jHe//d+acZv6ntocKzuUkqq5Y2LqHFD5VS5FJlFyLh4brOriZVd/FBYwe2E6ss/ZYeyCfSKWSMmYkiiCFk8sckvsGqlz7pvdVUNMNy0moT+L59WM6Yr/3RRhkrclRB7wGG5UY3YcmK0ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X4MkqfY8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Brc7CboD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 545HXo2a012878;
	Mon, 5 May 2025 18:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=P1H+4kb4+SsgcNro19V4aa1ER+Wk4w9PiwS1tbuupCA=; b=
	X4MkqfY8vx63PMyVmnyPQ9tFb/ZW4Yx7z62il3klSBXxTyj/FhqbVe4qtB//Fgr8
	z8Ux6+iMmPuOMRhCq1i26TmVkaJJCrt7NYa8BHN6BsTK/YO2SVRzebIR49FRSwzH
	KrQy5WN5tLOCwwF8mCy9nJHG6ix+K1OeX4XbVltu8PDLuVs0a1qxEELAb6EQw9rF
	e0D1hooF424GaPNWpT8l3RKfcaYDfY3Wt3JzLBUVdTd4s/9YXImz9EClDU6d+sNd
	InVzE/dbUdDw/WLcbyiZySR72PMVOyyK3ZY8we1x1+oFsQ5G8BaQ1mUp2pIzCfYQ
	eYcaq91XGvQA1MVGE3pFcw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46f1u305dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:48:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 545I9X8d035580;
	Mon, 5 May 2025 18:48:37 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ke9u7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 May 2025 18:48:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMXQ/Eitk3LTpnYyWBTqqGFqWE2XEBRAIQhoLqykhDyg4y3QeCFFnLXS8BKPk1O5LRSNa28xxsCpFGNhurHxfA2J5u6rbVFPN/Y96J65oixFYFKNMScXu0uNZAeWOeK4gPEFUTbUbme5mLixzeRKE3LFmfrcdhToCyYP7BJseh4GvaN1s7qDf/i+ZJvSsgL1W3trBLS+w/MSyaSts/4TEym3jS0ZxzN70bMGGUCUbe64wKV1VUrGinyTH9playbc84OeN97RL1A64ZvAuDpYpDAPggc/PaSB2mtAkKAjPnM+BOYZczG/Dqef7yh0iIvxENjbQZXvMF4VVlCnDZervg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P1H+4kb4+SsgcNro19V4aa1ER+Wk4w9PiwS1tbuupCA=;
 b=q0JQ39wDBGVYOsUWuCbqnsW6aigDIMHu8ucfXDP/Jq+7KlHfOpns3wY7Z+TTjwhDgpY5S7rxAtrq4sMYpllqm+oicAmGdvAfL+skha7f4QiZJ/ekgX5UijQJxtwEXMcT7AyI/lbHO/EcMaLrKkimaf8uXsbtsN1H2EZWIQQs/t4OgwCDXB9KxFBi6yTvYvFyU198jkKtlrf+6Ux9htVN76N8r17btCnksbe9uzCNWR3rDX187/+hfecabyyKTgn4Tje/SikULveu8ApMIDkGp2SXebGqLzVZwlZSxYXK+J6wDUFbXDL684x9EjI+zh0BuWnIlQGe82I2cDing0iIww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P1H+4kb4+SsgcNro19V4aa1ER+Wk4w9PiwS1tbuupCA=;
 b=Brc7CboDMoMCt+Of5ANauV9Sc7ct6V5DAPvYTmO3AjYp4vzJh9RHpo/O9zRquZkck55tTYqwUDs83oirig71WoGLm5IbF9Sd/LJruMtCKMlX691WnBJBbfzG6w6KSw/gUzn+UTtp02i6APCK3+Q5US41iSvQn8+2Zk7KM+ZnLh4=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Mon, 5 May
 2025 18:48:30 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Mon, 5 May 2025
 18:48:30 +0000
Message-ID: <bf4766b4-ac4a-45d9-ada2-4b409ba2f0a0@oracle.com>
Date: Tue, 6 May 2025 00:18:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/15] iommupt: Add the AMD IOMMU v1 page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
        iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
        Justin Stitt <justinstitt@google.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Bill Wendling <morbo@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
        Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
        James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0101.jpnprd01.prod.outlook.com
 (2603:1096:405:4::17) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: d03b5c90-e081-4121-ecc6-08dd8c056df3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YzVxRDJyRnk3VDZkT2Y1SWJBU3E3d2hqM2kvNU9IQ0R3QmVUN1lsQmp4TTRh?=
 =?utf-8?B?V0R1MlVIVjl3ald6QzY3NWlRdkNwd1RPZ1EwMkJHYVd0R3lEZzdrUWplTk1G?=
 =?utf-8?B?WXFFU0VyR3hDempxcVBGTDU2SFJQbllwUjVIV2dKU2FPc2FjNmtCNHlsTHBx?=
 =?utf-8?B?cGJEWlJXa0J5WS80azFtOXZBVisvL0daRkp0UE1Iekh6K21sTmFYWkMvVUhZ?=
 =?utf-8?B?eWZYMDFJWHA0azhPb2Q1UGR6V29wNXo2RGlqajRjcXE2WkNpVjZtT0NjY1F0?=
 =?utf-8?B?dUt5bzJ1TjhFazFoTUhBUTNGeXVzaXFSUEpBOUpreWFmUkV4NHA1L3pQYTRT?=
 =?utf-8?B?RG1NRXozaWRmS0dTVjN1dll2SXRlTGZDRGVvOUJqc1ZRVGRGdWN3QS9tdlNh?=
 =?utf-8?B?WXR5WVdNTERINnFUbUFLUFhON0w3ckVzWkhlcDhkWmxqcjQ2YWI0TThqZStQ?=
 =?utf-8?B?bXVRRFRpallBUzVLcWVjdGRTVW8vemdFQllWaW1wOER6RFRxUmRlUWdHM3V2?=
 =?utf-8?B?SXlPcEhBWC9tblExSnk2bXVPa3pzK2N0Vk5KWnE3RjdwalAvMkVhRFFHWWts?=
 =?utf-8?B?YmplSnUyVEZMcjdLODFMeVVEeEQ1YTZYVFg1dm1iTVEvOVpVR3FCRkdQTDJo?=
 =?utf-8?B?RG9oNFBGU3RBekxCK045NVB4LzVFQUJVdlIyS2N2U0dLRSs5bURPN0d1RnI1?=
 =?utf-8?B?bldvUy9pQ3FNRitOOGFzdUE5OGJLcmxWK3B5VWlQMUw1dGs0cERDakZsai91?=
 =?utf-8?B?SDVlTFJOSCtpVCtQR1pVVUw0Yk9uNHBJYmJhZWJrV2NFOGRJMkNuNFA4a0Y4?=
 =?utf-8?B?MEdhdXgzUXdOVFRaZTB3blhMZmd3bWg4aDZhdTFpSGJpNllvTGZjZ3Q2ZkUv?=
 =?utf-8?B?bXBpcS9WbmRCSnhOZkw1VTUzNk1ocktZRjZ6MDdSWjNhdmxWaVJ3YXU4akw3?=
 =?utf-8?B?SVZNdG1XTElZUjlsNVFvTkUyUmM5TnE2elU1U2xUUkR2Y3Nvc2Y2ZWh6cW1F?=
 =?utf-8?B?aktPUHFhSFlIYllVR25PMmZtc3FCTG9FcjNQeGpmTjhXUG1VQlFUd1h6bEpZ?=
 =?utf-8?B?NjBGZnVEQUMvNXlVYmxTU1hORlBGbEQ5ZGRnZGd1Q2ovV2hZVzROdW1yZXBk?=
 =?utf-8?B?QmNNcURFem11d1M0VUVNb0szcHBkcnc4YVBPczVwemZ2WkMyV09oZjM5UXBF?=
 =?utf-8?B?WXNQYnBIZ1BhMUp2T1NNeUprdFJOcnpuTU01c0dzT1hDeGZJaXprRFlCMm0r?=
 =?utf-8?B?M3NReW5RcUt4eEZkWkxKdjNrd243Y2JLSGFGVWw5SVZ1VjZSVllKTHhzbitv?=
 =?utf-8?B?amlWUStyV2dBSzJCTVRHVVUzUUZHdmxkaFdXNTdrb1F2cmdmZE1HbE1BdURp?=
 =?utf-8?B?ZzhTbXJmcUJ6K3oydllER2RFUThLR083SzhpeXJ2SkpaWC8zY0hob2I3SjNL?=
 =?utf-8?B?VDludDYxOFBuQi9GeEhuZnFQNnl2ZkhKVUUyY1BLYnQxSFEreHhNOUhZZExs?=
 =?utf-8?B?NTdBc1grdXlocFpjVEZneXUraXFkOEJyNm5mQzMzbHpIL3E5YVBvVHA3eVAw?=
 =?utf-8?B?WG1nTDZxUWFvYllycnVlSnJkWFRWVkdSNGpDMXhGcjRUZ3k5dzV6RWROd2pm?=
 =?utf-8?B?a2JJMW1Zc0gxbXM0L1M1N2htK0NXVlFhZ2k2MXk2T1JQTVI5Z3lYMlIwdjdq?=
 =?utf-8?B?TGVMd0E5c2tUNGhIam1FOFB0S1R1Y21qdnZ3akNUWTRMSUQwYjRtTExoaGxw?=
 =?utf-8?B?OXZWbWhQcU1JemlpZkl0QjQycDlFai9Nb2FKYUhPenliZWFMQ3g5TmpyTWtM?=
 =?utf-8?B?NU80UEExMFZ6MkxtSXVhRGxWTm5LRlBUZm5sNnNRanRLK09rZzBXMjRKVEZI?=
 =?utf-8?B?dUdCN0ZNcHhOK2Z3SWxyN3NSUHM0L1orK1hDNTN6YklEbVZjS20ycWh5bS83?=
 =?utf-8?B?aXp4QlJuVG9RclR0TlVVK2VFL3dSemd5RU9WaTJFWUhNQVQzRG5nRWJKSEdw?=
 =?utf-8?B?dDBBbVVGR01RPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTdRNTNVc01XL01uR0hhSTBpem1ISUkwU1JkcDV0aG13T1A2aEZMTGxXQ0lJ?=
 =?utf-8?B?dkh6VzlmSlMvSHd4aDI2aktXM2l1MXkvZVdwZnJuZnlLRzRkbGRieXhOL0tJ?=
 =?utf-8?B?bHc2WWRBNk5ONEZmYlhwdFBEU1ZJWVRCQUFpQjlnaHQyVzdxZmlPMHI4Vzh2?=
 =?utf-8?B?ei85dGlqbWpuNUlKOVFYbC9EQ1lMQ0x0cUd4clVYRGpMbmwzdjZJZFZQOHdU?=
 =?utf-8?B?cXZqRHpUbFB2NHNVNTZHaWo5dXNqU1poQkJWTEtBWDRMRGI0TUV0M1Y0VU1h?=
 =?utf-8?B?NkhlZHNaSm9ubFhjc3FwN1hFZ2pCeWRORnZNVWFmMXA4bzE1MWJWR1VVYnNH?=
 =?utf-8?B?YWFkRWZMdW5WdzdSZzNZaUY0TE9tMzJ5QWlyVXhvYUJoUFI0dVZvSXhvQUtB?=
 =?utf-8?B?bTFwbURBVnl0R3R2MFRpVVNzZjJ2MjBNME5WMnhieG9JdGJJYXNqM0E5bHpy?=
 =?utf-8?B?Zk5aREp5Q3JsTGJLMGxSSHEydTNHenRMWEF0WS81ckdWbTBIYURCL1NkQTBQ?=
 =?utf-8?B?dlB4UE9EUW1iVFQxZHZ0TXdHUnMyMEVlWG5MZ3FxenBuUkd4NzRZaTUwZ01r?=
 =?utf-8?B?a3lKS1ZCdnJwNTRZWVYxWDBIaTR2MHNmV2JLbms4RlZlRlZJTTg2QkJ3QUlS?=
 =?utf-8?B?bU95aHJOSlZ5RGxISVZTbFVIYWh5Wit4dXBPbU56RDRJTS9wcEpZTmtjbGw0?=
 =?utf-8?B?bFNmRlNFd2owdE1IK2g2UVlPMytpUHJKanpZMW1vRFI2amkraEIxdjBSa0JS?=
 =?utf-8?B?aUNtQWJVc1R4WWR1TVNmODc3TkRWcUtKTkRwOWQ3OGlHd2sxcm9JeUxRRWxD?=
 =?utf-8?B?UmpOVm1GREJiaWZuTlp5Q3ozamVYZy9sand1RkdsQit0TWRyamNURzJSWE1F?=
 =?utf-8?B?YlE1NTZyQUNIMHhRbFBMSSthZXZiMm9DN1hEcVFPMWJrOWF0d2l3biswKzB2?=
 =?utf-8?B?T0QrbXNuSXZrWmw3bjQ3OTR1TTdnREVHUTB4MXhOZStMVE1lbXlwckp2dm4r?=
 =?utf-8?B?OVlxbUJUZ1R4VGs1K3B1c0U1cEIzTWd6cUUyQVNsYnEwZEZzZkEzN1AzZWZ4?=
 =?utf-8?B?Nnh3SlJzOXNWN08yT2tJSEFFdnZGei9iMTJkV0NBT25vWkRjcXNEbXBHMVF2?=
 =?utf-8?B?bU55RUUyVk1RRVRSb0gzUUlMWWwzUUF0MmdMK25XVEh0cFpZa0I2ZzU0bkpy?=
 =?utf-8?B?elo0aUVJSUtxdkNZMkoxVkFXOVZMTk9rRTNPa1RSeHlCOERTMWxnM3l0Sy9H?=
 =?utf-8?B?S3VlQXJLTy9CWWMxMDZaWXBHbjI2ZUdZaERtTU5WaTQxWm8vWVRBSEJVVnE0?=
 =?utf-8?B?QlBiWGR5UTREeHl3SHV2b2F5NWdPeiswcE5nTlh2YUI1TURhUFB1bXhPdERh?=
 =?utf-8?B?RVNrajhvL0VBa2plMlJUNEhZamhHWTNiazFqa0hoMmpySXJEbmIwaTRCYlFO?=
 =?utf-8?B?OHdQaFRXeW4rYWRtNUZGWXRzWjB2T2ZYUmtCd0E0NHZsN2xia0lLbGFmVVQ0?=
 =?utf-8?B?VWY2MHNnWFRjNEZwNDlRdHpoZjBqV1BHNjM3MFp2MnpwZjVHQU9VbDJFcjZF?=
 =?utf-8?B?R2Rma0Q1c3ZHajI5WWhORzROMk9XSGpCOTJQVXUwZmJRMlhoRXY3bHJ2L1JH?=
 =?utf-8?B?RWl0ak5JbjVVamJRL1BNY3Vob3dGOEZJemVJMzZqVVNmOGxwRnNmcVJMVHpE?=
 =?utf-8?B?TG5xeWlFcS91MHFybjh0VWYxVVJBdXZCWmNxRWNLL2ZYaENaREZyZ3hORnlB?=
 =?utf-8?B?Y3FkN2Jzc1JTcTRoV0lGam1ZR3pjYyttRE5mUmV2cVBxR1pZQVEzcFhUSVNr?=
 =?utf-8?B?eHJXejhzRUtjakc5OWVwL1c4bFdMNDVrcFpwRlN4bEptT3pkMXZLdGdjTXB1?=
 =?utf-8?B?Y1F2Nlh4RHYxK3NrbWxhb1F4VXhYcEpWa0k2N0J4NFJmZnZYQmJxYWpyVmNu?=
 =?utf-8?B?M0ZBMWZHSXExbzNPRTEyR1h3RlArYnYvcmlzNC9FZ29MN0U3ck9kcUJRdStG?=
 =?utf-8?B?VUpVbmIzWVN5aUJxbHBoSmxrZ2xKakJLdjhNRW5KM0xuSjA3Rk5HdFlaRG1y?=
 =?utf-8?B?REFKU3VnTVUrcFRRV2RCRmJlZ1l3VUhKNWN5YXFTRHBZbng0TWRpcWEzZ21G?=
 =?utf-8?B?bTFySGd4dlpKSWt1QWZRVjdCaUtZRTF0cEVtSUFxNSs3aTVMSTZyV0JhRENt?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r6kSb7fXkDpndRP+iYk9nkTa3TxSRspzfrNn2Opm+uJstJXp1ZYUWoa1jb5YbFopd495+TtEd6TYwG18Z4d9+jp9bLbAUXK/0bRITY25aRl8uiUSeg6HKP1z0VviHKA+0XqWnXtjiLR6V6g42/Z+A3cYTbj04wOeUYttsQ2nq1FZIZ/HbuxjYaTQQl7CGYJmFDf7cHr8qcMAv1BjFvpvz/VmIfBpmR2oZr3TFD34FhSdUs8s4n8djLi/MQCLuD1ZH1vw1lreTuGgkZxe30hWyPlvQOSt6ZZxW1XTiA+DVlLjiBwUHOO7HidHCc/zMAyxeXWUpd60gjgBSm8AyZTWW4a0JuGt/00kVkWHcfVIDkSs9DJkN+9CtfHW1LBf29EgBUFrz4NyZ6Lc4+QLBnjeLuvkWxP2oG9KATjD6Cd9k490M0kYywuXtpOSU983Ur7lww/sOJ9a0cfLqirGemfgFGYC9mmDhZxl697Rd8gr9SMjqfPuD/0EBpxQZXsJZ4E2Fb6lngeYN3BfdfYfHB8rD9BHSn7IZ+9KWInjm707uSwODc0i9zMML2IHBv8uOwdivSzkE9kPpUc4XCtPZ1y764nlcmZsMMsmrgEsaJkk4Rw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d03b5c90-e081-4121-ecc6-08dd8c056df3
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 18:48:30.6952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NkRpphdM2Fz+RZgujPbMkovYUMBeq1De0K62QsC0s37J4AXvHXQyUQjKCF1QaPUCmhXSYdhNvGHqoawwSHT85i1x7Lg778jHL4Xya3/BoOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-05_08,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505050176
X-Proofpoint-ORIG-GUID: GklK6nx-iU2P8u0sIvLIqqAJ0Nj-XdWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA1MDE3NiBTYWx0ZWRfX7lVFpIIj0kto 2Dg4xol7yEwUNeBwSA0kJqWUPMdwBoHMmErbdzQIE9tjo3GY6nrOZ5u8nKNTjy8UnvWWN/xOfTc Z0lmKFy6b0d5G46DHTghFh3W1tey15fQySC7rvGa+nwlh5y17ksCP/0NUBHoZ56DwIduA87TsZD
 1PpiZsN3lS7mUTT36yu4IIHeaA9xLv3hk0CQ9IYF1JZjNOEb9XJGJCef+e/0qJpE8wUPAiZMUPW m/+j5KqrbLdg1rKA4BsYT0thscHxJWxQuNd/VqnmXUfE0sh+GKOochkADFysoHmWXs+3RB+jlVi qxw5DCCQVuC217hzHnCkTYOIpQoNzVuQAmvCVGsfYSC5GCMNMXuH+yXo6YdmUo01u2HOENzEGDN
 45xjTomc86QPSKccRjgLkxwXkGEOoPNzsmTVrmUID0nsBGtL7gTKqj/k6QVAtbgFLOYUQW2g
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=68190806 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=k5rVGWi42yueYYax4WQA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13130
X-Proofpoint-GUID: GklK6nx-iU2P8u0sIvLIqqAJ0Nj-XdWi



On 05-05-2025 19:48, Jason Gunthorpe wrote:
> +	/*
> +	 * Table 14: Example Page Size Encodings
> +	 * Address bits 51:32 can be used to encode page sizes greater that 4
> +	 * Gbytes. Address bits 63:52 are zero-extended.
> +	 *

typo, greater that 4 Gbytes -> greater than 4 Gbytes

> +	 * 512GB Pages are not supported due to a hardware bug.
> +	 * Otherwise every power of two size is supported.
> +	 */
> +	return GENMASK_ULL(min(51, isz_lg2 + amdv1pt_num_items_lg2(pts) - 1),
> +			   isz_lg2) & ~SZ_512G;


Thanks,
Alok

