Return-Path: <linux-kselftest+bounces-47205-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0530CA9157
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 20:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 584E8309CC4E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945AB242D91;
	Fri,  5 Dec 2025 19:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dKvzWp7O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6CF244670;
	Fri,  5 Dec 2025 19:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764962938; cv=fail; b=X6vC7RJHRlMN75O85u0c4kSzXXjYVo/Ori+X7Rx1sUtr8ST3XWQSj5a2Wtts5pHycHfTISGUtUhaux2MNl2Al3AZvhL/0sL292xuYEL3YfqX6c14im/XlAJQy+xj65n66jB1hPQDjxcFeiwBpNksHXGRmD1A0wKWtUUSsPER6vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764962938; c=relaxed/simple;
	bh=AKBnt4S47pTQ0KTNDtqeMnlXUm4LWNFNdrnRw9QzTUQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mTsik1v4ohP4OT8stmEA6zggtsmlUQg2XmBSjmDOCQehal3Kah0CDmWhhzF9x21hLRIN1Dq1WCkzZNiXzdbsdfpoYNbgQ+I87QyEGNWEhbtbPcdvhMUMvnm3HsoGyWjR3VvUY/+dllghHuHNqhw0aTN4noj7isVBjsUMA+zt8cY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dKvzWp7O; arc=fail smtp.client-ip=40.107.209.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8tu5mz/J7V3ETYfLFjA0GVwYMpqDn7FmoHTaUNxIYTg29xSy2+oF/q+c1m1jx9S11y7U5pJZQJrktxvc2KS6b3sVebcaI8yk8LOek8KZb7IdqjPW7H3Tc2N0jf28qsk9RiXqrB0ZFMHqTaQos40xtLbnJ8Qvw89Fov+n855jFCfPEHJ6Lr5zAyeCP/H+w9/TvwUxFoQHH3PM5G1RyQDiOooZMaJCIfywrYzoGMxmgWSJ3et2lxbWRMPkZgE8gq+p+IGMSOnIV4TMvZ5m0AQXez33LOxeb4IeiaFXOkIclOh4KRnczFQKSyOCEFfAeUcjm7nbMjpRD/gwY6sulJB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HttZE29SDdHuYbV4ha23D+o68GP75cKXJ00rc7mPCRg=;
 b=NaxMdb1i8I+oipP2isHcoLkWL3iD1Zm40bsmzij8KTYUIjbiScow82C1zqG7xThI3X5jVm03iRoAwYW11C5YGCMLLGoElAU3BO0zw1AUqqmNmkWn9PaiMGopvauPaiTXvgx7wiq2JweUNYtjhrVaQs5s3zdluLsn7qMibqYKgkW8MUp/YeVAcvvl9R/gECztudzt0qKI5lPAnb0K0t16Jie+8g/h1kFd0syqVcbD3HegW6TbNjtPOryxLkS/XO4PKdRhTTpr8umHjLK9Q0j0Uq1deBDZIPdS3Q4jlTgF0JVuu/0sqnZX8W5ftJOJ8T56mpFV9gLGX6qMIw197pzhuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HttZE29SDdHuYbV4ha23D+o68GP75cKXJ00rc7mPCRg=;
 b=dKvzWp7OcCVBs9kLVv0LSaRUN3O3dGmBpPVswelnUpwrzHv9p2i2ZGRFERVHYbs3CuY+DDyGUPH7Fa00q4zkQdQXdh5JeGo4yasunZ+LkU7bMUbBb1pLyH0YYhBF/UQ7JHSPgwFjWY4OBRHtpawx/KLUiFGD/kiKslg+6G0N3jl9U5r4ap9MqeIqm8jRWliTUOsf9QXYoNmPk+nFYxdgVu1KQ5PY1XVwSCyrDnU/ktVgMhqO2PmK+wuAKBjLsZLUJsi/1mFXA0uKesRfqX/jwV5IkcSHDgdGbvE3Z3EpQa/KsIfAUVZMTVytX/iPEJfj9sXl+XCG5Z2wbwFvgFQHSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 MW3PR12MB4347.namprd12.prod.outlook.com (2603:10b6:303:2e::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Fri, 5 Dec 2025 19:28:53 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 19:28:53 +0000
Message-ID: <6d68f2c5-4011-4188-bdb4-27f0e6a4d13e@nvidia.com>
Date: Fri, 5 Dec 2025 11:28:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] selftests/resctrl: Add CPU vendor detection for
 Hygon
To: Xiaochen Shen <shenxiaochen@open-hieco.net>, tony.luck@intel.com,
 reinette.chatre@intel.com, bp@alien8.de, shuah@kernel.org,
 skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <20251205092544.2685728-2-shenxiaochen@open-hieco.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0112.namprd07.prod.outlook.com
 (2603:10b6:510:4::27) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|MW3PR12MB4347:EE_
X-MS-Office365-Filtering-Correlation-Id: 13169190-9173-40e6-7060-08de34348669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dldoaUpDTURMOURXWkRub0JOVkVUckU1OGlaNXgwUlBKVDJJVVROZmpVZTBz?=
 =?utf-8?B?UElrNDhOVHd6Z1psTVl0dE9UbnlZbDVvREdyVDYyY0M4NWlZV3NxWWZpOUlB?=
 =?utf-8?B?Njk5bFBnS2ZnUVQvcVpnTFNSbFNRcCsxaUNVcUR5bXB2c25FR2tRR2NYbjFk?=
 =?utf-8?B?dEl4bzVNYjA3WmpZdndhalY4UzJrZ1FaR2NmL25CQWROdkVRdEpldVJPRlJZ?=
 =?utf-8?B?bURsc3VUNU5tNGVxWWdwcmlhMVo2dk0vR3NYdkZ3b05hbS9CVG4yeGlQTkMr?=
 =?utf-8?B?c1ZQQnBEd2t5WDQ5UjU3R0xRMDFUZ3NpR1NVWWc1VmdNeDZQbDNSRTFURklP?=
 =?utf-8?B?dmZHM2hWRnlVdmxITWpmeVRIbHc2elBkSldlbDFBLyt5NlBhWXNVckFINXIv?=
 =?utf-8?B?cDlBVFpoT1g3S3pFLzZMRGFiOUpzdU1lcnA4SlFieTNNVkRwQnZEY2hWcTBG?=
 =?utf-8?B?S0xKZ285OWt5RUJuRjFleW5QT25aSmRzY2FwdzBQTEZFdWlGOExzZEtmN1hG?=
 =?utf-8?B?eXN0aWtxVXliczJrYkNybU8zTDRoSldQbGcwL2IyWWU0RHlXaUpUSitvZXNT?=
 =?utf-8?B?NTJjbHJ5UURSeERpSUJXSC9CRTY5a3FFVFVNakpEWGxqVmVoYjhDdE9FdnBu?=
 =?utf-8?B?WFNCcWJiSnR4cnBZeS8yYlk2TlZTenFYbk5obklqS0c5d1dLamFjUW1yY056?=
 =?utf-8?B?VW1rcUdMRks1U3E0WkZZNi9VTTYweHlFV21TRlc5OHdDZlZIeGtZRCszdVRH?=
 =?utf-8?B?YmM5bmNLbkEvY1RWN3hRYVFXYnlNSW9ob2Izb0E0RXF2VHpSc2ZmY1dYak00?=
 =?utf-8?B?ZS8vK3g5bUlDS2M3L3ZoVGtBb1pXRFNnV2ZoTGU3RmRWQjArWThyUXRJVEhR?=
 =?utf-8?B?RUVXWURWODc0S1lRdmJaZjlqTzNZeUNUQXNtYm83VE0vWEdEbVljSG5YQ3RT?=
 =?utf-8?B?U0draHF3dkxsNjVyNlBMdk5HdE5xQWdYZUNjenp1Vk8ydEdJbFZtQmZGcUNv?=
 =?utf-8?B?eWNtaldML1JxS1dmdCthcmV0ek4vTEYyNWpoRFIyMUJTb3k3cHRqa2VYSGtQ?=
 =?utf-8?B?OU1oT1IrQnAwQlUwb3NpOCt6L25FeThodUJoeFFiN2hwSlhPWXUwRzNxUU11?=
 =?utf-8?B?Qzc3MmNoTXNUOGpPQUlROG13NjJZN2w3N1ZFTW1Wc2RHYXJlU2pYNTJnZzA3?=
 =?utf-8?B?ajVWSWpjQ3J0K3M1V0lSZ1NuSTF1elVKRVNZUHQyblA4MWtXZm1JdTRCbS9p?=
 =?utf-8?B?TEpJSVBWOVZLTHhvUWNZVGNBK2dVUzlPRzlMYWpMWHoyMStTdEcwaDVabFBx?=
 =?utf-8?B?M0lnVEorRnhwRnhNWTJnb0pMQlR0QnZidk54NEkvSHF6SEZFaEdqOGxjbkpP?=
 =?utf-8?B?c3ppUEROYWRERURybldZem1FcmZrTUptQnNBL1lUUjZYdWVQSzVWUVJhZDJM?=
 =?utf-8?B?Yk1Fa3JiQXM1UGhFT2pHeDVqZ2xXN0FCZk55UDc0a3NxM3B2OUZ0NW5ma1lp?=
 =?utf-8?B?Rk9QVXVSZTM0TlVkSUVlSEVRT1l6dEswS1daVkkxVDZBM2dub1lvMWtPWHI3?=
 =?utf-8?B?RWltTnhCOExvaU5PZUdsV25wUmJnSlBRN1BCQkxSNVhuUktmWmxOQU5OTS8v?=
 =?utf-8?B?SmltRldwcWdzdmJIdUxUYVJzcEhYWE83MFpoQVdVbTlzRUZabEJaMmNVL0FE?=
 =?utf-8?B?S2hEeFArSUxNTnNCM3FzZEp3OTlKZTlSR1drNi9VaFlBQU5sYk1nN0MwVFdR?=
 =?utf-8?B?M2xtZWRVVWR4a1crWllVZDlBb0ErTk53Nm5uNFBUcUdsUzNSL1pQckpEUm4y?=
 =?utf-8?B?Z3VSci84bjdrTEo1b21GSFNBWEtoUnhSVmJGOW9XY3RZdmZna1FSSUJnRGg1?=
 =?utf-8?B?Zlh1UVJ6akgrZHlnOURuVWJHc09SQTRnQ0d6Y0QwSkdZN1dqcWJlTGVTYlAz?=
 =?utf-8?Q?exjHK53B6BvIaYkU7v356Hn6SNIPMtwe?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnErZGd0M05XL2g4STV4anJ0WWI5ODA0ZU5EL054RFlmclpmK0tQb3E0Nnpp?=
 =?utf-8?B?enRJVmlIb2lQUmFpNTYvdENtbGJ4VHc2aCtaNmQ3SVpNTmh4Si9QVnY5SjJN?=
 =?utf-8?B?d29hRnRtZjloa1lYaGdScWxReHRNN1lWL2I4K1RnTnJyMEgxWS9HU0J1QTRK?=
 =?utf-8?B?bWhBSjB6Z2htOWV1anM3MzdiZGZyTDN4dTc4QnpkNnptUUtoM0YwbXRtQzlE?=
 =?utf-8?B?bzlDUlhrczJLOWdCWFpOaXJiZGdVUkhYRWRjRDB3dVJzNlY5SjJ4Z08wSUlL?=
 =?utf-8?B?dzJsenkyZG4yS043ZTF5dmZldzlqQ0crZmNjdkZ3Z2VmNFJMamk3aE82VUZT?=
 =?utf-8?B?MTJ3RkN1WFR5ejBuRmcxYnZzc3FHYWlMYU5zYTZzTFZEUWlPSnl2RkIvaUkw?=
 =?utf-8?B?NG1ta3M2YVpoYUVkRHk5RUVUdm4va25vQ3ZuaVR6NDlpRUhJajY1MVVUSEha?=
 =?utf-8?B?Y3ZMZW9qdElZSnhGNkZHSGVSYVBCdFhCV3M3WlF1SU0xSyt0b25lS2tJWDRF?=
 =?utf-8?B?ZGJSMHZNTHdyVmYrWHF1cHJVVUw5N3NNTXJDaDdKOUpXRE05aXFHS1U3Vmsx?=
 =?utf-8?B?MGdEem9qbkErMzJaNm1hZi9LUDFwTlludnBWWmY1UnN2bTlKY2l5bnRmQWZW?=
 =?utf-8?B?MTY3U2YrMDJHMzdoVkhtc05PMHBlZGwyNWNDU203U2d4d3Z4eHZXM3U2SnBj?=
 =?utf-8?B?QzNCRW1NTzFHOVgvZnlwQVdjbExFYnQ4THREMk9wTzVxS0JNZW93OGcvWnN6?=
 =?utf-8?B?UGdqWDFXa0ZyUk4rdVNLZmxBenpQcVlkeG1zMW5uZ2s3Y3doYklyTms3Ukhq?=
 =?utf-8?B?eXpPWTFBZ1h4WDVHMnJlYXhxOHgxYm5WR2VFSUh4a1hEWVc1emExTExObGxH?=
 =?utf-8?B?dlkzeWxzK2lQWkVRajVqY3NMZkxGRU9weUhvRk9IT21JZXY2TnpLaWJuL3dQ?=
 =?utf-8?B?eFU3clBYcTdOMGRJWlJtaDF6K0ZJSFdrclErdk4yOUVkMHlMa0VONFhwcGZm?=
 =?utf-8?B?ejRZdjBPdzBIeDFaUnJPYmdhU1MwN213alB3aXh3WEJWYjQxQTJqdUk1OVBW?=
 =?utf-8?B?Qk00Sk5GTmt5dTZha0kxRytFbXpvTktiM3g0Y2hhZEZEcExqcVB4K0ZSdUZk?=
 =?utf-8?B?Vk80RmNsdnRIVDIvSXlvVW5zam5RZndJRnl1R08xb2dqKzNpR1pyZUFZUVB6?=
 =?utf-8?B?enFNN2laYkd5djRkVXA3M0x2bnpwRktlWXhod0hoY1I3QlJsQmpuZTZPL1Y1?=
 =?utf-8?B?dHY5OFVGUTZ1Z3JIYXdGTnZKT3ZldWZpWDJhWUxyYnZYWWh2WmIwamJNT25j?=
 =?utf-8?B?bnpvMmQ3K1Y4Z3k3L2FuZzlOaXdyaGtNdXBFak9rSHhTZy9rUGNEcEN2RnNL?=
 =?utf-8?B?WkZGZzBrSFJXNCtFUUNtbld5ZEVxSjBuZzN0SmR2Ry9oaG56K1pERWdtM3Ez?=
 =?utf-8?B?QzExd1h2bkFZVVQ4T2NFM09XOXQxam1iWlBpZ2tIbTdvTnVJeGJKMXhyR2ow?=
 =?utf-8?B?M1AwSDZkTjQzRFovdE5aR3ltWlpsYW94ckE4Z0d6NzJTZUppVkV3TXp1QTBO?=
 =?utf-8?B?ZUlSYkV6ZHJhR2xjZ29kbUdlQ3JHR25UNFUxZzVVZHRDWElLV2ZHY3hKWloy?=
 =?utf-8?B?L2JGeFRGbkJJTzBDeXdURDg3SjN1MUd1SzYwbkxaK1hsQXdMemVBaWI2amhq?=
 =?utf-8?B?amdOYjJPQXlpaXUxVnMyWkZXL1hkZldvcnovWngzWXE4clA2TmMxekVrMmJI?=
 =?utf-8?B?ZFFtS1N4OHY4MHVBMitOZmFBMHArTkZGaEIxeEJOMXdrT1ZmYTNhb0tnTHVT?=
 =?utf-8?B?UXdhYVFzTm1SM0hJSlhRQkJ5US9JclRiZGZKcVVpVGh4R09HNXZsVjRaS0lm?=
 =?utf-8?B?bEo0cGU3VkU0SWlRSFQvSGNTNlZ1T0N0V1Z4RDFMS1dNVndCd1dFVEJtZTVW?=
 =?utf-8?B?ZkVoWHp2d3Q5NXZaZW80Skl6dXNiQm5ROW9oTW94QS84NmpZYkttNnhSREV3?=
 =?utf-8?B?RTNkZm1aOVVIbTM4SjFuSW9HWGxYaHpkL1kzRXR3RTBuUDBsV05aUTZOVHBi?=
 =?utf-8?B?WlhxZVlManYvK2hiQk1TMmlFUXp6T0ZubXREdk5FUDR0NVJ0T0tWWFNDa0dC?=
 =?utf-8?Q?cf00QfaN+ZTn1+zIJuWRTWIu7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13169190-9173-40e6-7060-08de34348669
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 19:28:53.2617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ncs8rmYJyw73LA0i8oIiCEomwGIfe5RjzYx+u38KNo8cKRUbU++4mvEVw+2narcVmkAgObbb54ncSWz1bEnJqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4347

Hi, Xiaochen,

On 12/5/25 01:25, Xiaochen Shen wrote:
> The resctrl selftest currently fails on Hygon CPUs that support Platform
> QoS features, printing the error:
> 
>    "# Can not get vendor info..."
> 
> This occurs because vendor detection is missing for Hygon CPUs.
> 
> Fix this by extending the CPU vendor detection logic to include
> Hygon's vendor ID.
> 
> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
> ---
>   tools/testing/selftests/resctrl/resctrl.h       | 6 ++++--
>   tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
>   2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index cd3adfc14969..411ee10380a5 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -23,6 +23,7 @@
>   #include <asm/unistd.h>
>   #include <linux/perf_event.h>
>   #include <linux/compiler.h>
> +#include <linux/bits.h>
>   #include "../kselftest.h"
>   
>   #define MB			(1024 * 1024)
> @@ -36,8 +37,9 @@
>    * Define as bits because they're used for vendor_specific bitmask in
>    * the struct resctrl_test.
>    */
> -#define ARCH_INTEL     1
> -#define ARCH_AMD       2
> +#define ARCH_INTEL	BIT(0)
> +#define ARCH_AMD	BIT(1)
> +#define ARCH_HYGON	BIT(2)
>   
>   #define END_OF_TESTS	1
>   
> diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
> index 5154ffd821c4..9bf35f3beb6b 100644
> --- a/tools/testing/selftests/resctrl/resctrl_tests.c
> +++ b/tools/testing/selftests/resctrl/resctrl_tests.c
> @@ -42,6 +42,8 @@ static int detect_vendor(void)
>   		vendor_id = ARCH_INTEL;
>   	else if (s && !strcmp(s, ": AuthenticAMD\n"))
>   		vendor_id = ARCH_AMD;
> +	else if (s && !strcmp(s, ": HygonGenuine\n"))
> +		vendor_id = ARCH_HYGON;
>   
Since vendor_id is bitmask now and BIT() is a UL value, it's better to 
define it as "unsigned int" (unsigned long is a bit overkill). 
Otherwise, type conversion may be risky.

Is it better to change vendor_id as "unsigned int", static unsigned int 
detect_vendor(), and a couple of other places?


>   	fclose(inf);
>   	free(res);
Thanks.
-Fenghua

