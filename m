Return-Path: <linux-kselftest+bounces-32493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA3AAABEF7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C87873B7D91
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929462741AB;
	Tue,  6 May 2025 09:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rAheDo5C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2061.outbound.protection.outlook.com [40.107.212.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D1266B65;
	Tue,  6 May 2025 09:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522925; cv=fail; b=WQJP0IZ0CTs5yEKhg9lcxACH9/zdXBbpGd7XdJPbr7juWhphcKKWMryQvM1JcTkbZOcE6ZyHfNJZwF9AoYEbDb3k7lkft3Mw75cPvk7s3J8+AcziF36V13dL8J6sQNgrqaoFfr3xKgYzl6amX9FB2JEJhSh8fabxvYz3VFLhQTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522925; c=relaxed/simple;
	bh=HHbqG9yHv+M+OQeazMBcILw3NylTSRFBXzUTd6YLhOk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dDlWk5BC08ILWHfuvImYflCADREACJUf24MSA6nPqvey99bs3YStWm45ljM/+5+zlCcZA9qcWVInDChcXSUSOzC/ggF4sg5iMJPJIaH9ZZ/UGcjXKEuHe8vWQyaBzTP92mZLpRgyDkQW+blTd/B8DYi2whzgcv8JZ+HRBiLrN00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rAheDo5C; arc=fail smtp.client-ip=40.107.212.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c5ZBA5rHKI8+tSE3oh7RcIjury1Z11CVBFPpUcvUBlInfscZkoJVmYb/aQYfDppXvBHHz3X2ujfeEl2bXzQGTdZzR/v+DgTadVPv+ZDpBgvhucqSyoI3QhopMKYDlLtXTlVXoC0xnxUJZA9mmwVwJp34oVdbLYodikZODkrPTiW+P1D24s5WS6aJU+0dmS1psrZKZQKD+N/eAXiImcvxFkMjF30Nb+lh6CsabbfEbLJtrRFq6qEHT5vTnyd1KX4G3U6MI6Pjp9Sp80b1RGA66URhSCRQyuAZ+tjEv7mJWJivU14Rh3XxED5se2OtUY2oq8NvhuahnX75J+v6rJSI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq20y2nrejaOAkIDUCbu/CjgSaW0xQeDQAkBCO7Zl3Q=;
 b=vhSQmxzyl5oMNFHHapt2IT7sLSy06WgicMDQ5To3pnEB26yPGAoku+xcSyoyfkoQPOEvFDzbwlVAOcNF1OrF3iaGtkwtMNJRmirAw5Oa6C+wlxXrCIBva4C19E3Fd9/BceWA5HNoI4RX6eFey4Ivu+W5Kr1IN/B6EjpaGhuq2amKJyCW4Jiwdf4k6vRjN4JhAVdz4oIKVMDFdnPAujX/IMyEerwgYZxA9g5s+wCM06SqwgvZ1ALvzvUYSyTif6OP3Rp03KLnU7/O212z0FeBmK9CWdj49MdTX2GI52BLPg/gIpePRr5pycD3rMqM33otLZmhjjOeX7/36CHiP+PUPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq20y2nrejaOAkIDUCbu/CjgSaW0xQeDQAkBCO7Zl3Q=;
 b=rAheDo5CIiNPqx3YHk+8pmS3GjwC9qK05ZpuR5m7s8MenzKdWweU3L3c6q+EtnqQDNINq4f54NW1OGfQug9uqmaEP/YwZAQ4gmomTifSTJbGocj+zdQHbSoAK0B1X3/UWydGWFoFNeHPbP0xMJjB7I0L4nKjkyQXQ0CtECx6bag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Tue, 6 May
 2025 09:15:16 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 09:15:16 +0000
Message-ID: <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
Date: Tue, 6 May 2025 14:45:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::18) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: e2806eef-b75e-4726-c64a-08dd8c7e83bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TEFiU1h2WVlxUTFCaVJ3aWdmRS9uZGx2OUd4YVVETEJ5NXoyWG9XOU5oRUZP?=
 =?utf-8?B?SnBCcWt6dHlPRTdNRHhiaUoyc2VlZTFJNTF6d0xnSytqUG1XczA1WmZ5RXd2?=
 =?utf-8?B?L0VuS3hZZ3FuWWprMzErK2xuS0dpbzZWYTRNYUFVVlhwT2JiNkNXUzhqODBy?=
 =?utf-8?B?KzBsQ0psSHhzTTYrUkpWUTFMTWpwNksxNXJDWG9pM2FHdk1MZzhCTitmby9B?=
 =?utf-8?B?dWJ1dC9CSDNXVGxoSWx1dlRldmI2TjBWdk4wYkFQR25DUlRyNGY1Um1OSjVM?=
 =?utf-8?B?dzZSZVdLUkxrUStTWjMwTjlvTVZnKzJsTUw2U1ltSndPbzhxN3dqL3pURG5D?=
 =?utf-8?B?NFhES2Vyb1FEMENadnhpYjM4cVk5emlndmVDVXRpVlNaeUVXbmlSL1ZzYlMz?=
 =?utf-8?B?bUZSakNid1dXbkVnMzJYMFlYNDV5eHVEZFNYQ2w5WW80ajY2UGJHVjlsWlEr?=
 =?utf-8?B?d2dXZEl0cHlnYnJhVEV5Tk1kY2xXcTBjN2ttb2o5VWYxdGJTeGI0ckN1ZnBn?=
 =?utf-8?B?QkMxMURoaUljSFRERmlmSnB6QU1jeEdFMG1rVHB2Sm5kaEIxYXdvdk5JVVhu?=
 =?utf-8?B?a01qdWI1Z3o5WEhNS2RaR0hybXlicHY4aGZIU1BKSEpVSGN3SGMrUVVsUzJv?=
 =?utf-8?B?UElMditKQ09pYmJ0WTZxdEVZTlpvTVk1ZnNPVVBMSjhLLytnTUJyRDJ4UG93?=
 =?utf-8?B?QlpKcFl4N0tzM1pBUFFsN09xbFJsaTliSkR3dWhweGpIU0lhazJ4eGJEcWx1?=
 =?utf-8?B?RVJndnVLSFA3bmx4SVlhdWpYWXhYWi90T1FjVEl4ak85d0djdkpwL1lDdSt2?=
 =?utf-8?B?bjEvamV0TTc0UU1xVVg2a2dHUWNITUIrRVd6bk8xTkpRRmdOYmVkWFYraUZD?=
 =?utf-8?B?N3JsRFVsbG0wL01Mc1ZIcjVra0R5SXFYamg5ZmVUeHlyUE9YcjdHV25iOVAv?=
 =?utf-8?B?Z2ZFVlBhWWJ2M2VrNUU5SDlBRE1DMW11RXphVDNNY2I3aUN0NVA0eGtZbUMr?=
 =?utf-8?B?bEpkMGFkOXdqaDN3VXE2SDdWUEgzVTRGMUM2VG9HY3hxckd2OUVwM0ZGY29k?=
 =?utf-8?B?d2R0TXE3RmdMUktSVCtZc01NUFNzRlNpYXBXWUJZMnROYVRMaUdXbjhMMXls?=
 =?utf-8?B?RTJkdGJSbjFMM29ENVJRem1RK21aM3ZJajVGbGdkYTJ5WGtPc3c2QnNRajJ2?=
 =?utf-8?B?cVRvbEJ2R2tyYTErYytWZFRXc3RrYUJGRHBjV0F0RzRTVjNzSldNSDFnc3Jz?=
 =?utf-8?B?WmxTZHovQmd5SFdqOGhuZkxHdkVHd0hqb2VxL0dhaXFYVlcwQTg2MFdyYVVN?=
 =?utf-8?B?U20raDlGS2tVS0I5ZzluZnJyTm1iK0VRc0pra3MyNmhlYktHcG9XR210cE5H?=
 =?utf-8?B?Y05uRXZ4MlZvZjNmVjRLaWM1S1A3NnVKNG81dDFvc2dPSG1MbjhWNk9weWto?=
 =?utf-8?B?UFNIdURXbEFtTVFEQlFXdkQ2WDZnamorcDdRSGpYblFsVmhwSzJEaVFFdFZr?=
 =?utf-8?B?T09HV2pERDk0NXZCZVc2MUtpcml2a0dsVEVhYzNTck1pSklFUVVvUmpaVG0x?=
 =?utf-8?B?aVpZZTdPNkZMbHhXeEV0SU02M09KUFRHTlU1VXFwOENBMFdxalQ5dHBheWlz?=
 =?utf-8?B?NzBhQ1JEMExsb1FuUVNXdmNLNjBaWkJPT0NaTW43WjNOaFdTRmE0cDRLRzRy?=
 =?utf-8?B?Ym1YeEdwd2o0dFNmUTkzZEtVRXFuUGYzdlc0OS84WHloUi9ZOVFYWVY4ZEM2?=
 =?utf-8?B?NDM4M2UvS1g1bWRlTUVwNlVRb09HQjJOY1V1aWRMZXRSSnMvZHVnb1ZsdG9z?=
 =?utf-8?B?RkE2Y21ZZ0dxcjNCVnRvQUc5Y25nd29ETjJGZUdVV09KY0docFlNSGE3WnI2?=
 =?utf-8?B?ZXptSEJMenZ1TUZTWlFBTDkrajZDdjlYVmZWc0YxR1JEdlZqQnJvSFphTXRu?=
 =?utf-8?Q?2D5RyKYwEJM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVFrbFJSTktHdHNua2xRUmxIL0J6bDM4SmtaSGFacUZua1RxSTBFamI5WlYr?=
 =?utf-8?B?ZnpKcTMwdmxLY2VHVGhiN2tYZHNBdXpHamhDZjlhZlZwRGxOdEFMR2RQMFo0?=
 =?utf-8?B?SXBsK2ZYNWIxcVd6S09DcTZ4S2xxcEtzRytFbGlYdXFocXlHNDBhUGwvR0h4?=
 =?utf-8?B?S1h5ODZMTFVrTlM1czI3L0tSQ2QxY2N0ZVlMVURqUStmNUIzOUFINGhhT0lU?=
 =?utf-8?B?NkV3VStiZFlheGplaGF2L2NOeXpuL3VQTDJEcEtjTHdDSklxbG9PWjA0RzhD?=
 =?utf-8?B?VWcyY1pyb1RVZzRrbXVLakRRcXRBUEY3bjZ0ZGFqK2dhanAxTmJOMmkzRFpy?=
 =?utf-8?B?ZEIxOHJvWW41eVBaT2RtTUcxZEJGdFkzUVFtYkhPL3RKbFJBRHg5K1NyRlQ4?=
 =?utf-8?B?MUdGT2FVRVdCWFp1WDN4dzRrUThpNnJxNHF1SnhWRFZXdDBQZzNYbGgxenRD?=
 =?utf-8?B?UktIYkhzL0h4djFQaU5IRVAvdkRKdGsyR1BKYWp3VnpFV2N0YkpydCtSVkRH?=
 =?utf-8?B?Y0tzUUpZYUdHTXJ5V09yV3I5d3RCSnNxWVl6T0VGK29IVHV3WWZUYTVYbzlT?=
 =?utf-8?B?cWI0ankwMlhUUDNqODgvQ05LRzlBbWFlNU9ER1lFdXYxZ29tSXk4L3RhbElM?=
 =?utf-8?B?em1DbEpNeVJrREJiNExSQml6WHpMSHpqcnZZUXRaRElDU2JIL0FmcmNCNm0w?=
 =?utf-8?B?Z2tvM012b2dMdDFTa09ObWRJQ00wSThSZXg4WHNDVTNySDBYWDd6MG9vcDFX?=
 =?utf-8?B?RmNzVWtEYmZmclIyQXkwTFhPd092d2REV2RVRnBzWWxmd1J0VWwzQTBIRlV5?=
 =?utf-8?B?V1ZQRjBuakJwcU1tYkRRRlFCTUlYR3dXQ0dtVGlySnpONDRCSEd3ZXFHUEdi?=
 =?utf-8?B?WlZyS2NydStFY0thNVZ2ME5lRGxyTHlRdENyTVBOQ1g2YWpsb0pQd1dZOW9y?=
 =?utf-8?B?dHBvNUlzeU9uTHVESlFJaFdGQTNQVGdFV3F6OTd5YTIrNjgwNjBPQU5XWW9m?=
 =?utf-8?B?bjNlT25mb0YxQWNvT1V6S1lLcGhQc2FIQi9yZ0ZqdnBHbmJhOWVOb21BVW1X?=
 =?utf-8?B?RlYxRS95ckdCOEh1ckxUUk5ITXhWaTEzanA1alN2dG9CTTR4THFsdjNENG1F?=
 =?utf-8?B?ZE5nQnNHWThQZHNVTFVQQ0VIRTNFZGdHSVZlbXZjbnQwK3Y5V250M3EzWHU5?=
 =?utf-8?B?OFVjMEw1b3dkNC9hME1JaHY3Z3g4aWxMU3haQ3IvcjRram1JME02Zk1DdTBG?=
 =?utf-8?B?MFNSTW51VVNiRnA5eC9tcVFCalRCLy9QLzhtcVRSRzVHc1gya3NWeWxJdXNX?=
 =?utf-8?B?cFU5VlIxV2JiREUwVVFYYkdyWVZ0blROMUVrOFdlUWtJMXVVdVp2ZmxPYkJq?=
 =?utf-8?B?QjZWVUJ5WE8zTGpRY0IxejI3M0poWGhzVmk2ZnArUEZSTFJraTlUYm0wcVIy?=
 =?utf-8?B?S3Blcmt3VnJQbjVrOEpBVUIvdTU4bGxadlZRY2tYako0ZDNoWUd4OCtlOEY5?=
 =?utf-8?B?dmpucHBtQTgyQ2oyakZJRnVEaU94aC9CN3hSa2pIZzJkTmlsTkgvV3pnaUp6?=
 =?utf-8?B?RVNqbWt5Q0JYQTRXeGpYNCsxblg1aTA1RXB4NXZJQ0JvcjVycTNqaHdwanpa?=
 =?utf-8?B?d1dxRUZRZEU1RkRWUUxvelJBWHJ1M1ptSkhpdkw3UC95WUs0K0dYbkNuejgz?=
 =?utf-8?B?R0hDRlFaa3h5Ny9QVXpoRytyZjdnMWtkZVFSakRVSzROKzYyVmZVTXlpY0p4?=
 =?utf-8?B?YmRyRytxcEhxRjVrMlV1d3E2azRHT1BGaTVhaklZZ0grOXNYUDFQc25GK1Zn?=
 =?utf-8?B?MW40YW4xelYvUThNSTFkYUs5eU4vOXU0OEZ0UW83Rlcza3BWcHFHbTdWZEw3?=
 =?utf-8?B?ZTMyMTFHQmtjNmx6Y0NESWM1MWUvVm4xQktvcDMwUGJiaS9HSDVoS0NPcldG?=
 =?utf-8?B?UFJia1ZyeW5HYWc1VnU2dktYYk9PRnBwT0g1blZEOEFiT0VVb3l5eWRybWxK?=
 =?utf-8?B?aWlyaFFEY0dzYnkzUWhCZDdMYmJpNEhJbyt2a0hnVitwRlNkT0JMek5XR1pJ?=
 =?utf-8?B?TnFlRTJneU9EcGtHNEZabTRHUnhKTzlyMmowWkRsWXIrMzR6Njluc3RwMGho?=
 =?utf-8?Q?+whQQGCXJ1zLzrRVT8pM0XvPv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2806eef-b75e-4726-c64a-08dd8c7e83bd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:15:16.4393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5ChaMc5aThU8gFYkFelBEsUG44KobRq5cth6IDqdcAQF/gN9U3bbL54D4RSZEXQQF2yOmyui3Q1suREHJF8pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Hi Nicolin,


On 5/2/2025 4:31 AM, Nicolin Chen wrote:
> Introduce a new IOMMUFD_CMD_VQUEUE_ALLOC ioctl for user space to allocate
> a vQUEUE object for a vIOMMU specific HW-accelerated virtual queue, e.g.:
>  - NVIDIA's Virtual Command Queue
>  - AMD vIOMMU's Command Buffer, Event Log Buffer, and PPR Log Buffer
> 
> This is a vIOMMU based ioctl. Simply increase the refcount of the vIOMMU.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_private.h |  2 +
>  include/uapi/linux/iommufd.h            | 44 +++++++++++
>  drivers/iommu/iommufd/main.c            |  6 ++
>  drivers/iommu/iommufd/viommu.c          | 99 +++++++++++++++++++++++++
>  4 files changed, 151 insertions(+)
> 


.../...


> +
> +/**
> + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> + * @size: sizeof(struct iommu_vqueue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: Virtual IOMMU ID to associate the virtual queue with
> + * @type: One of enum iommu_vqueue_type
> + * @index: The logical index to the virtual queue per virtual IOMMU, for a multi
> + *         queue model
> + * @out_vqueue_id: The ID of the new virtual queue
> + * @addr: Base address of the queue memory in the guest physical address space
> + * @length: Length of the queue memory in the guest physical address space
> + *
> + * Allocate a virtual queue object for a vIOMMU-specific HW-acceleration feature
> + * that allows HW to access a guest queue memory described by @addr and @length.
> + * It's suggested for VMM to back the queue memory using a single huge page with
> + * a proper alignment for its contiguity in the host physical address space. The
> + * call will fail, if the queue memory is not contiguous in the physical address
> + * space. Upon success, its underlying physical pages will be pinned to prevent
> + * VMM from unmapping them in the IOAS, until the virtual queue gets destroyed.
> + *
> + * A vIOMMU can allocate multiple queues, but it must use a different @index to
> + * separate each allocation, e.g. VCMDQ0, VCMDQ1, ...

This will handle multiple queues. But AMD vIOMMU needs to comunicate certain
control bit setting which is not related to buffers like "Completion wait
interrupt".

How do we handle that? extend iommu_queue_alloc() or have different interface?

-Vasant




