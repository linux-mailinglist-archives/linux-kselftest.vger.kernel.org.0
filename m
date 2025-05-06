Return-Path: <linux-kselftest+bounces-32485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2741AABAF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA1116DD08
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE443293B7A;
	Tue,  6 May 2025 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XzAtmtrc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A97293B46;
	Tue,  6 May 2025 05:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746510218; cv=fail; b=beeHuDs8ODlOQC5QK1ebM0+wlx/dV05NwnWcvOvlJYfXr1Epvm1ROnUZG9AyEth5asAjntOq0k46A4Sy7DhVFYRiCx8PYjGSNA/Ur9jeVbMgsmuq2l9oMAY3hgYm9rpoFLDscJrCFfU7DjNiYgRramIdiZyM6dmLMKRVOb0yKUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746510218; c=relaxed/simple;
	bh=zJEN4VSYlYSJz9ae6/kU64j4YXUvPnFZ9P/aRXhMSTQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ij719kVZVmOtJXVb+WQfi/ADLk2LxgemNLUbHb2aML1G4ygra0dnT/E0O/xElWiJLh+rmP+VXcopnq0feQTzzzWdjsDvdMvAjcJ3DaajdE3gkLGK8Z7JAofdL1PTRxJzJKBeQvBs9dfXXJ5LG7DA/48Tfx3JzWNp4IgPOfW7gZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XzAtmtrc; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LEJv4SpFtymIAn8AS4jRxzpG+XlQDk3xZqPkgBGRPiV3QY/bK6IoV4eLHdUENtlay191dvQrD4wiu6ng3Z+/HroI8RafjrtS0ycTZsFkDnXLLhSAg/+LXdiU2F4H4MMTJBrGPiIoujEpP8J7zRAKkmEFTkC3/539H4Cs8CZs3w66NHxRYZOYu3cJmuR0EwFQC+dfeBUBvlv0mpWLoWG+9OPYrEuz46OrwjtZjvBhWi0/rEab1PmFB1N+eOCJsLgWGyD+wZlUlNEt90JR7ovn85nLLIM/73b94WVkU6NwLKRK/jhHekQKtcplVqkC8a8/+McA32eHTUDIzho7TZRS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TWDYD3YAsYVgm/TgQCHdIyQnrhhQOVzwJrqm08xSTc=;
 b=L+21Z48PADzNfUQkQ8SE311E2K58zQZX7wplrYDR6Vrllddc0hPAtng/9h4qYL1WPB7uXZarA7vvfppj82xrC3rX84d4caSccC2+nNgmJq5XRNOCUEqclnG1an+ENk9E5/gpuEDR8946hhLGcQHFHwTSSHV7wSgKHjOX1HzIZvA/HkhKYcgGIDvV5Jomdfk5mC0+/oK3fNxHbal70h6BWa1qg5xDZzcCAR7AwbKO90RaJ2ZxxvDs08EstV+rsWikcW5x61t/VfkSstTXl5es1569PwZ4CtQsXc0iKPVIKUbozmEvbjvqkuEROPn3XYEPASpwI5p/VY2casti5aqk9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TWDYD3YAsYVgm/TgQCHdIyQnrhhQOVzwJrqm08xSTc=;
 b=XzAtmtrcXyhMXGDxSBsp4BvLrG7XirQhwc5+nHwLqedxqHyRCE6rEtecNPDiOa17a6JjWNnG5/jF6ILEH0uEv/fLw1bDIdZKNoMaLJtWHsjqleCepaZ1jQLaONoBoUqw4zBdI009ZZoCkLZmZvMGA4xKLx1ATZEGBc+QPZzm1jQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 LV3PR12MB9187.namprd12.prod.outlook.com (2603:10b6:408:194::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Tue, 6 May
 2025 05:43:30 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 05:43:29 +0000
Message-ID: <1d77be4f-4fea-477c-b09a-7f4fd5708cb0@amd.com>
Date: Tue, 6 May 2025 11:13:14 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/23] iommu: Pass in a driver-level user data
 structure to viommu_alloc op
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
 alok.a.tiwari@oracle.com
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <832c4116fde833ce36b3e6fd23f6bb98197a9996.1746139811.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <832c4116fde833ce36b3e6fd23f6bb98197a9996.1746139811.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ae::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|LV3PR12MB9187:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4900ce-9e3b-482a-92cf-08dd8c60ee05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NXpPQk5MVnBBZUd4OWpGbURSb01VSEJHZ3V5Q3orUWtIaUwvV1YxdVBIb2lr?=
 =?utf-8?B?TFl5UzdyN0cwU3B3T2x5b3JJZlFmNTJrMkRxanIxQUFqOXY4QUFSRGdSNDl2?=
 =?utf-8?B?TGMyQXY5Mm9HeE9DL1dhS1NpSGpaNUFjM0NybFBhOFN3YytpWVRXbVY2ZlJq?=
 =?utf-8?B?ek9rUk93aW5aZ0hkUUNpWXMreUtFVW5PT1duTmxZcnNJQmRkem9PWHBOYjBJ?=
 =?utf-8?B?eEQ3Q1F5eXRUenBZMEtWRzg3cVJnN01QUDdmeXlqL0puK3UzNFdpQmY0aEU0?=
 =?utf-8?B?MmZlcU1WdHpqbmFiU3N4eUcwN3pJMkcrak1GS2RsMDR2RjFtZEdMeTN3ZGlZ?=
 =?utf-8?B?RGZ5OUwvNXJJVlJtVWhlSUI5UWV4Q0wrNWhvbkw5amRKdGVsMXVkYUNzbmxw?=
 =?utf-8?B?eTVUMWRva2hKY0lta3ZSa1Fuek5NMUJRUXpXSHZwc1pldWdaYWVRZ293R25t?=
 =?utf-8?B?SWlKMytNTVk1MG1ENmVKeFBsOTVWZzI4Ui9kc3RGQ2xEb3E3MVFJSDB4d1JM?=
 =?utf-8?B?RU03K3hLc1h2Smx2ejQvM2MrNDNSQlVWZFR4d3R4enJzcXkyK3pjUDZKSE8v?=
 =?utf-8?B?Z3Y0WW5NWmwrM0lMaEFveUhCT29HWng0YnJMaE1NdUJ2UDYyK1k5bjE5S01v?=
 =?utf-8?B?cW1LTXkvNVpheERQT3RnR0N3UGx1ekgyQTJKMFF1OEMxNGRmbHVRYzQrN2Y1?=
 =?utf-8?B?dHJHS3FXUlJrNjZ4RFE4bUI2eVIrSVluVWo2ZHBseU5SOWh1QlhkTnY3aHlm?=
 =?utf-8?B?U2RJZFJCRmxiYkxhZitOQkdkK2lheWZPTTJpRk04UktjemxsUlRIOFdkKytY?=
 =?utf-8?B?V0IxVVBmT1dSR1lXa3JZQ3d3Uk1xRlI1YWxuK2hZRTBlaUhDNlJIaHFUZFdE?=
 =?utf-8?B?Yy9vV28xT3hRK0NTQ000OEQ2allQR3VIZnprQVU1NUJoYmRWNFhQN21UM3Mx?=
 =?utf-8?B?bnBaZkNsa2Ewa1FYdlhyQlZiL3Z3YW5XdUJMR0Z5VExBNW1pc3IrWTBhcnR3?=
 =?utf-8?B?dWJyM1ZEbGppdTcvajRRWEtZZXVHQUJGYTZMOFprcEorNEdrZFgrK0FmM2Rs?=
 =?utf-8?B?dVNnVTc5cWdBL1FoWEg0NWk2WkNKZnRkaXp6cjdseVl3ejVFbmpFbEZ3YXor?=
 =?utf-8?B?YlRtdzc3cytHaVpqVk9IVU5TeXRWMnVhODAwY3d2SXo4bkhtM29aVkIwdjdU?=
 =?utf-8?B?eGZjNFNMbGZsTERySzFCanRWb1p0WFdKQzFvbXA0ZklFM3d5aVVoQWZvc2ts?=
 =?utf-8?B?V2ZFdnp3cGxtTE1ZSkhJR3lqNlpJUFk4K0RJdmM4SmM0aHN3MXh6Z0RQR2gw?=
 =?utf-8?B?Z01jblZxMzFnbHQ1WCtlbU5Jb3lBdnBEdHRyM0JZVUdxNUFlM010MjMzVDhp?=
 =?utf-8?B?WXB5MTNQeWFnQ3JDQm9wcjQ4TzBGSVJvZVVwclplWlJNUG9rU2tISnJGdXZY?=
 =?utf-8?B?MkhBNUNMTS9KdzF2V2tZS3k2eGdJWEE0akFadCtGQUdhMVFwZEJvQmgrNUNi?=
 =?utf-8?B?MUJDd1Fud1czRXBVMWN5V2V5dE1pY25LTy9ueS8vMDVPUzB0TWF0SDBPL0tp?=
 =?utf-8?B?TFJHdCtleit6dHJhdXJnUENDZkowK2VkYVpXMTFGZ21xbFplM2Q4TXZzRDVT?=
 =?utf-8?B?M04vclAwTUNJajJDT1FHLzRUMDJBcFhnb0hiYk5PaHkycmFhcmJwejNwaVFr?=
 =?utf-8?B?RTdVWU1VRi8wcUxWLzJKZUN5YnB1TDJWcVNnaEpwdThzWHlUVVM3MUJVRzZw?=
 =?utf-8?B?ZUxDYzd3SkdYQVFRUHpoR3MzZVE3ZE9jMmpqdUJYOVV0T3ZCQXJzKzFzTVd6?=
 =?utf-8?B?VEdQRytxK0dlT005b1N1cDgwMWNaUVh5L1lsYmtjLzdrTmpxTXl2TWliY29x?=
 =?utf-8?B?UWZKM1pkeDA2K3FoclNkQWtvMVAwVkxGZW80VkxkSFVTaGwwcnJucSt0dExQ?=
 =?utf-8?Q?+DfOfdtABbQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dU1mUHBEeWY2ckVPaXBsR3J6d1hNcTlYc3pNNXBVczJ4M3N3d2xkN1ZIYyth?=
 =?utf-8?B?dkltVGxVaGl5SzgvWHZSTUlIenVMUEZiTEVZZDZCOHpjMmVsOW1Ib2lUR1gy?=
 =?utf-8?B?dklrR0ZmbTNaTDBOdEM0OTNETVY0bG9UUWk5T3V0UkplNWNTM0lFekpjbDVI?=
 =?utf-8?B?RWtVYllmWWRJME5XK3JNTDhNc0dHMUNIZjV6Slo1eXhNMEsvMDBXeFN6Qk84?=
 =?utf-8?B?aWtjSzJWNkZiRVBLamN5ZFBuMEtqU3R5QnJZbHE2R3BtSHNkUllqOFZldzlG?=
 =?utf-8?B?czNBK3lRMXNBMC9tUDgwU2ZsM3NUb3Z2ODBmR3V5UVV6ZjFxQmI1aFc5MjRV?=
 =?utf-8?B?TEhRbGFrcHIwMlBQRVRIb1UwRzBmdTczVlVqQnMwUGFUckRqVmV1Rnp3Y3cv?=
 =?utf-8?B?YkNUdktzMFl1Y0JSYUF2VkptZFBNWmlKbUpCUjhyeVpsVXltVm43NmE2RERR?=
 =?utf-8?B?c2ZUMXQ0VUcxUklyblo3T2hTV3BVb2RxZlFEVFY4RFZRZU9LdHFhMWlUOGVl?=
 =?utf-8?B?OXV5dU9aaU9GbVlBSWVWZTFaemdYeU40Ym1nb1E4UmZvN2RYUkJFVC9JOHA1?=
 =?utf-8?B?M0Zlcy9SUUVhM1RETjVXQUVDeisyL2p6VVY1WGNQd0dLOHcvZFRxUVdlSmFp?=
 =?utf-8?B?TEpsbGNuZkNaaVFNbXd4UFpkVHB6STVmQitCZmNOMVRoUjBZYTA2b3pQdis3?=
 =?utf-8?B?ejVEVWkvOFZwc0ZYWExLa1FjY1F0SzA3bWIrNHZuWHBrNDZ6aXQ5Y3ljN1hq?=
 =?utf-8?B?SGNCTHZHMXZ4ZHpGVy9XTXpvSlFNMm80WDluV0pRQURoWDNSa2tCWVJYTk9y?=
 =?utf-8?B?WkJHOUdKT1VjK2k4LzZ0K1ZhdWgwWkxGZHZmenlLUUdNWEZaNkd3VTB5eVBa?=
 =?utf-8?B?MnBzV3RVZHJ0RkJiMTlkTCtSMjRuQ3l0RjM1TFpVQlNOVFAyK1Q5OGlwUWpB?=
 =?utf-8?B?WithSUk1anp5Z3Bmekl0c3A4Tjk3UDZ3dEsvUlhVOGsvM1RTS3RmNzJad1g3?=
 =?utf-8?B?K3Yyc0VuSkxxSXJhdVYzQUREYkdzTlhZaFh0SDNIbGVCRVFNa3B5KzhhQ3Nx?=
 =?utf-8?B?My9hS1BWUmJxNG5mNGI0ZWZGemhqMGdMU084K1E2dzlnVy9SL205YS8yYmQr?=
 =?utf-8?B?dGROSk8xMTBka3ZFdWI4ZjF0eDkydU9saXdNaTBpTzhGZUJXZ3BUV0hRTGIy?=
 =?utf-8?B?Y0k1cHNIa21kb0JORERnZWhPNXdkKzJGbDlZUXB2eGFmS3dJUEErd3pDUXZo?=
 =?utf-8?B?b0F2eUFhZzZYQXZ2R3JxN1QzektXTldXYytBRDVwSkVkZVVLOGxsVnpLWG9P?=
 =?utf-8?B?MHhrY0hiUkc4Q29URUsrK1Z1WHZUSVJqcWs0SUQxdzloVkpmb1dWWGx5QVRv?=
 =?utf-8?B?SGs5K2lteDlNNDkrUWJ4S3lYcFlRNndWYXdVOXhsTHV2b1g5eFJBUk1JTDdZ?=
 =?utf-8?B?L2lJSy9Mai84enBaVmJtNlpjbmRiMU9DelorZGVrbER1YXZZRnA0emt6UzVC?=
 =?utf-8?B?K3diT2k0bWc3OTFjVnpIdmwxeHVFeVczNlZnNjJ6U2FsUG9hcHQvcXFrZm8w?=
 =?utf-8?B?bkgrYUZHTjAzRVFDR0FnbGlndjFsalp0aGtMb1J0VWVFdmg1TnlhMmRLb3Ra?=
 =?utf-8?B?K3NKYmdFM2lka0dKNW9pcU1ab0dUQmZ6dFZ6NUtpa0tITExJU25Uekw3ODhv?=
 =?utf-8?B?VFhWZTR5TmpDYm40dWlKUmpBaFhmNEtBT1lrVlQvT3VjUUw0RTA1dUZCZVdD?=
 =?utf-8?B?b2pLUVd4N3NHWldMa245dmg2VDdIZUFLSmZxU3JWZG9pKy9FejB1Q25FSFhn?=
 =?utf-8?B?Z3lFYjlQUnp0dE0yU1QvMUhPOFpGcS96U0cvSnpGV0V4RnJjZ3hwckovdzlq?=
 =?utf-8?B?MUt6cUZHRE0zR0ZCQU1TR0JzT0hyRW92aDVXeUtwYXlWOWpzZmErNWk0bzM4?=
 =?utf-8?B?TWFQQnZxRk9SVkd5QjZNU2hKQS9qd0w3Sm0rL21DaWE4YmR1dkJreHNxZmNy?=
 =?utf-8?B?bWkzcXpHNU9xUk5wUEZhc3FCZGhaQStSTVBXSjVGeDZvV3BjdEY1S3lEZTZo?=
 =?utf-8?B?QWxiUnNicjRkTXYybnVMS25HQ1BhNTdIYVFXNVlzV1Fhb1E0VGJ0U3BZcDR6?=
 =?utf-8?Q?NhpuPvRTPuCZCQXi2oPrOilLw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4900ce-9e3b-482a-92cf-08dd8c60ee05
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 05:43:29.8325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rwup4K4Ziw9P7DnFvvM7cs0DPhffBU7ct4qOl0/hmphCGDyq4tL7HLBvJqRKtq+FhJntmBvsECICeBEp7nfvUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9187



On 5/2/2025 4:31 AM, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv allows user space VM to use one
> of its virtual command queue HW resources exclusively. This requires user
> space to mmap the corresponding MMIO page from kernel space for direct HW
> control.
> 
> To forward the mmap info (vm_pgoff and size), iommufd should add a driver
> specific data structure to the IOMMUFD_CMD_VIOMMU_ALLOC ioctl, for driver
> to output the info (during the allocation) back to user space.

Thanks! AMD vIOMMU has similar requirement.  3rd 4K of IOMMU MMIO space is
accelerated. We need to map VF MMIO BAR to guest. So this change is useful for
AMD driver as well.

-Vasant


> 
> Similar to the existing ioctls and their IOMMU handlers, add a user_data
> to viommu_alloc op to bridge between iommufd and drivers.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h         | 3 ++-
>  include/linux/iommu.h                               | 3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 3 ++-
>  drivers/iommu/iommufd/selftest.c                    | 8 ++++----
>  drivers/iommu/iommufd/viommu.c                      | 2 +-
>  5 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index dd1ad56ce863..6b8f0d20dac3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -1062,7 +1062,8 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type);
>  struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  				       struct iommu_domain *parent,
>  				       struct iommufd_ctx *ictx,
> -				       unsigned int viommu_type);
> +				       unsigned int viommu_type,
> +				       const struct iommu_user_data *user_data);
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain);
>  void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state);
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3a8d35d41fda..ba7add27e9a0 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -662,7 +662,8 @@ struct iommu_ops {
>  
>  	struct iommufd_viommu *(*viommu_alloc)(
>  		struct device *dev, struct iommu_domain *parent_domain,
> -		struct iommufd_ctx *ictx, unsigned int viommu_type);
> +		struct iommufd_ctx *ictx, unsigned int viommu_type,
> +		const struct iommu_user_data *user_data);
>  
>  	const struct iommu_domain_ops *default_domain_ops;
>  	unsigned long pgsize_bitmap;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index e4fd8d522af8..66855cae775e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -385,7 +385,8 @@ static const struct iommufd_viommu_ops arm_vsmmu_ops = {
>  struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  				       struct iommu_domain *parent,
>  				       struct iommufd_ctx *ictx,
> -				       unsigned int viommu_type)
> +				       unsigned int viommu_type,
> +				       const struct iommu_user_data *user_data)
>  {
>  	struct arm_smmu_device *smmu =
>  		iommu_get_iommu_dev(dev, struct arm_smmu_device, iommu);
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 18d9a216eb30..8b8ba4fb91cd 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -733,10 +733,10 @@ static struct iommufd_viommu_ops mock_viommu_ops = {
>  	.cache_invalidate = mock_viommu_cache_invalidate,
>  };
>  
> -static struct iommufd_viommu *mock_viommu_alloc(struct device *dev,
> -						struct iommu_domain *domain,
> -						struct iommufd_ctx *ictx,
> -						unsigned int viommu_type)
> +static struct iommufd_viommu *
> +mock_viommu_alloc(struct device *dev, struct iommu_domain *domain,
> +		  struct iommufd_ctx *ictx, unsigned int viommu_type,
> +		  const struct iommu_user_data *user_data)
>  {
>  	struct mock_iommu_device *mock_iommu =
>  		iommu_get_iommu_dev(dev, struct mock_iommu_device, iommu_dev);
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index d4c7c5072e42..fffa57063c60 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -48,7 +48,7 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	}
>  
>  	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
> -				   ucmd->ictx, cmd->type);
> +				   ucmd->ictx, cmd->type, NULL);
>  	if (IS_ERR(viommu)) {
>  		rc = PTR_ERR(viommu);
>  		goto out_put_hwpt;


