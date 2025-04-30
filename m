Return-Path: <linux-kselftest+bounces-32017-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB956AA447F
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 09:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D1F3ADB83
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 07:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551A220C489;
	Wed, 30 Apr 2025 07:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YV4H0ZWC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F79D19048A;
	Wed, 30 Apr 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999708; cv=fail; b=s0+O8oVYg2I7shPpP9PBbCKBpL3VFxXNYPPx2OceaC+vtH9b68m3vgUqXeo5sS85FIsR4t69ePmCtb3fcQ7XK7mRaQ0KZ91HPoP4x0apGWuKYX9fgBST+W/n1gs5cyOxlNuhb6wPtgZ8aadZWCn42O6O/WG82Or57KN4XY9njnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999708; c=relaxed/simple;
	bh=vPaT9OEK7P9njr9xBwuXGLY0GZAWWD+ET2NoqihgEho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L6hXKgCxykjE1cu3HI5r+z7P5F/jZS5fS5lL7ck9oI3gGR4sY9Ox8tFClibw3E9iqANsl+rpRsY7YdlE+5lscCF1p6EdrinW3kwO/YzJlaoMm2oblohGF2C5Zj8NPmUoGJfWXo7i4G4X/ommJgaB0tSJolnDbQnyRlC2vwDWYE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YV4H0ZWC; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PARqKZ8Vcw44QT9KZ2norJJNWKaYnoYo7TJGVY00VAq/fRiAfCF+SU1yGGFxWX8+qKOguOSWgzh5pUoFD2dtcZW+X/LebKRrtdwBUhvNiAJRQTlOcfLF24DxyjV1zkOw918MAHpLo8ergGw+410HNa0vkncaWhi2kIcAI03VEoKiAiOKctyssaXM797NkmHfTO5Vm6bQRK+Q7RZ5TrGd5fJwfWZx50nIjnK4bhGhGz49USjejsB7ymjHY0+Tb8AzenDG9r55NIPT6S4YKueUlSlw1MoqaHTIqTnAogwfgOf7kyvDkg0Elae+duV3/UJ7DWsz0yA5y7O32TPB+oh35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grf77TLB/dtmnhrt7yNZcC7yXgJ65g6nJf0TU3AzOVI=;
 b=ybmDre0A6++xWH7q1tAqwOVobdRugESlzZ2xbkN0fodj0u2fHsigFLogx0HEgBxyRu9aP3jUXQo40CG2bx4pcVRHfGASH0n3X3mYtlAaW4pZnn1SgI0nAO8BMxF9I7Q7O9GNHnFL/AiV2ZcqE5YjieFXtmBEL+5WyMywvx6Wo8/HQPrx1N7HL1uDMlYvCeiaDmXiYGMuRYAXjaT+bqoOo6b3R3i0D4w80KLXuLTPTFBvohew2LY0IbX4NzCzhdXUbxtjx1Fp3Ck26fIwu+UwDtR8SO1MG7e0JRiyUEAbY1sip5hAHyua+LxQTFMahNMOH9flCYvuOfvfyYZt0sgdPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grf77TLB/dtmnhrt7yNZcC7yXgJ65g6nJf0TU3AzOVI=;
 b=YV4H0ZWCDdRmDcM2tTR+Vf363LWVi6lWfqRG3G7bY7XvyEvkAdZAnkyszOEwZjKAYK/4GD63eYT7ia2vg9qqFpnWsCVMrWqI5fzyd6spkTNG2l654eRdpAj/2/glvzWj94t4/B6dV6eZLOhA8e78u+v2cYodBIu4HJRQ1XN1szE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB8762.namprd12.prod.outlook.com (2603:10b6:806:31f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 07:55:04 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 07:55:02 +0000
Message-ID: <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
Date: Wed, 30 Apr 2025 17:54:53 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
 will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 shuah@kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241004114147.GF1365916@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0078.ausprd01.prod.outlook.com
 (2603:10c6:10:3::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB8762:EE_
X-MS-Office365-Filtering-Correlation-Id: 56e26ecf-3f4c-4292-1064-08dd87bc503e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnhJV3RtK1hUMXZHeEE4ZS9SeDcxSTcwRUxrNWJFUmIyZ0ZFbDhucEtDUmRM?=
 =?utf-8?B?T0dtV3FSYzRMMjlCaUJhWTFkdDhIVklvOGZ2cUlZazVPY0E2NUk1VWIrYnlE?=
 =?utf-8?B?UW44VUlyWTVsY2piYmJxdTNrRWY2eUQ2cVliZDBFc1JoTTE3NWYwU05SZ1BI?=
 =?utf-8?B?NHp6alhmYy9iYzJNczR1ZlBKcEQ2Q0d4YkZVbzM1aGZqb3h4WFRkYTdQUHlw?=
 =?utf-8?B?Vkp6Um9IV1VTMy9OT3l2QmJYZWVJTWVaR3g1SWErd2oxMkdqTVZkS1J4OGNP?=
 =?utf-8?B?Snlwa1RyK216VGR2UTE2RzdreG5lbnM2Q01XT1g0T2x6T2dSeTFYRFVEWmQw?=
 =?utf-8?B?dVAwZVJQbkh1TWdWZFZZR2QzelFaYlJUVlFaSE91c0VXa1djbzZDK0hScEtM?=
 =?utf-8?B?YU5KaXF5bFN4dm9nczc2cjBwUDFrRXNzVU9jNVgyMEtDRytJWE9hT2VnajY4?=
 =?utf-8?B?a3cvb0lLdGdNaDhmK3Y5Y3BxZk9yTldzeFZBNUYwdFZhUnc5eXoyaklhR2RV?=
 =?utf-8?B?ZCtGd0grVlVzWkJ4UUZLMUtrQ2MyYk54QWZrbkthR1NkM29EZVh6ZUkraEJ5?=
 =?utf-8?B?bUx3WnB3cU1ReUZQWnFkYW1ISTJNSzBRSnZ6aEtDaUJ6aE9kY0tFaVNXSmQ1?=
 =?utf-8?B?WVQ0NE5BbnY5NnRleVo2MG5aMllNTzI4QzIxd3pjdTA4SDIxdTBHOS9TNlps?=
 =?utf-8?B?STNHRm4vc3U3QldFd1d5VkR4akZ3Ykcvc2h4MDNkQzhydzNsdmFoSnlMNFhl?=
 =?utf-8?B?REFxR2ZqbU1YSWgwSmNMWVZrYTRxS3BXa2wwYVdvMVZWbnliclM4RW9NSXJl?=
 =?utf-8?B?MFdLOUJ0d3JQN2dvT0cxL052bFhFRGJnT3ZpYmlyeUZxOERucEtlVkU5Qnh1?=
 =?utf-8?B?NUprNEozdk8rT01Jc2JaL1VTU3l5NWo5NERNRDFFM1lSRjRaNUZmUDZHZVp6?=
 =?utf-8?B?T3BZeDBBbXc2WXc1em5BZHV3WnprVW5lWkRyV3V0WjNQRlZsZmFGWVpMT2w4?=
 =?utf-8?B?YU1WbmUyNC9aT09rYU9iYXg5UHRXd2J2clBaL1VmTEFxNjgzNmlGQVNRRUxm?=
 =?utf-8?B?TjM5Q3ZQZlM1dzcwaEVwY29xMm8zWGQvekluUld5SHN0SWxBcDB0ZHh4bmN3?=
 =?utf-8?B?eCtIczFvRFF6SkhvNHp2T09IOVRocGQvL3c2N1pnUTNwd1haZzB6a2tFY1Br?=
 =?utf-8?B?SmtNQm1FR3ZjRkNjZmlLVFdxYnIyTXZFemJrWUtIOUE5bzgrUXpRbFhyMGtj?=
 =?utf-8?B?TWJGU1JxRFlGeHdoR3ErbDVVL1NQdklia2VtYWprVk5pOXhGVWU3YU53bVl4?=
 =?utf-8?B?ZzFPTGJrRklrbU00eUNKUGJacEx3akdMdE5sU2JlbDlCZXdQN1BPdUtLZlFD?=
 =?utf-8?B?UCtNNW4xLzJ4L3JWSC84TWhuR1dMOTZMbHllTjE0VmN2Skhaa1ZGYWVGcjJq?=
 =?utf-8?B?dk1oRjJubGp4WTROZVlTenVjNTdnUXpGYThtVWpZZTB6VFJYMzIyVEo0dVcv?=
 =?utf-8?B?UGlkVW45YjFyUWt0a3l6N2ZzeGtpc1lJcy92VXpoZTFYRWtpWHdvSGloK1Yx?=
 =?utf-8?B?Q0FhNnpwOGRTNFJwb1o0SElEbCt5c2dSUzZaa2NkWUptZElWdFpGUTN3Y2Mv?=
 =?utf-8?B?RE5ueUp1R0liZHNkMmJyS2Q2ZU5DdVlNY2Q4dDZqdTFKeVpZWUtyMDJ2UEkx?=
 =?utf-8?B?cXoyNjlOTFJCay9XN1lmbHJtWmN1SWtabVhJOVJJeXE1VmRzZEkwejY5WEd2?=
 =?utf-8?B?TG1uSTRJU0FaUTRMSEF6MHQwL2IwS0I4N3pqWmNXYm1mQW5wRVZPWHR1MGZl?=
 =?utf-8?B?VWhwNGNGZmJjZk54anQvRVRIdHI3dHZQeXJYV0l4dUZsU256R1hpWlNyT3JT?=
 =?utf-8?B?NjZwWjZXY1pQQ1F2azhlbmhFaXdJeTRUbkpIVHgvWGFrQlB0NjNSeWZCUW1J?=
 =?utf-8?Q?4ez4+AHMRTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmJiYmp4bTZXYUhoQUtJY0tkSndkSjFFc0hsYkhiL2tMcGUxUkFaYllpeGVE?=
 =?utf-8?B?ZFd4OFFyemdDWVpwa3dNMHc5VnR6YlB4TGhHL3hyRnQvSi8yR055RndCYU9w?=
 =?utf-8?B?d0g5WWdOSkdFeHZpa3lmMHVkaFNHdkI5SGZWeGZTbFRlTnNWZG9lekxGZEJl?=
 =?utf-8?B?eCtMblN1RStUeTdtMXh2Z0x6UWdsMWdKOE81M2NOZlhYeUVKcWE4YWUvVWFa?=
 =?utf-8?B?Y056WHovT2tOcXVCZmdHS1FlYTB5VUNyWDF1UkhqbzJ3TjhpZC85Q25od1hs?=
 =?utf-8?B?b3dwaUlrTklLQTUvRzc0M1JjZTI5Wm1VbER2MTEvWmFIbldXOW9nc2VCZHA5?=
 =?utf-8?B?aHYvbVVxTnZhNmR0Q2pEVlJ6VktHMTVqVHExMlZaMmM0eTFzNEc1MGJiWERh?=
 =?utf-8?B?MmJBZ1BpRkRETk1QV043RWk3a2NVZnRrZmxqOWVtV3pHVzR0cXhETjB1NXB0?=
 =?utf-8?B?c3pMRjQ3cmphU21qNjdRSno0UkNmY0wxLzZCdjBLZEUyQjZFeG4xUnNJNjBo?=
 =?utf-8?B?NEZJazlhYnNOTzA2Rm1vazFldWcwMUx0QVZNdnNhMlZzYlJqNWt3TmFmdVAz?=
 =?utf-8?B?MmNoZHZXNDFhd3VoNStwT1dodytrTnZMWGtiYk5ZekI3eW9FRmg0YmtTYktV?=
 =?utf-8?B?RzIydUNBS0xCMzR1N2VKM3d1T0pRK2gyM0RWUHhXZnlvdy9nT0FJc0lBaklw?=
 =?utf-8?B?KzRvWFozbHpXeVM5Z2swVmtrVHp1a3J5NHRkc1FmNGZ4bHlLTHpYS1pYN01B?=
 =?utf-8?B?ZmpINVNXNFl5Q04zcWtTeWViVUpFcTd0Z1B5RU92OW1zMk1zUmcxaUd3NCt1?=
 =?utf-8?B?ZDR1cUhwUTJ6QUFjaDg4OUgxV3AzT25HOStKbjBmYnZiTkVNZklGYVVRQ3Ar?=
 =?utf-8?B?c244OUQ5eWkxWGt2c3gyb2RzcGhSN0F5VktlcWgyNzJ2ajJ5dnJwbjhrVit2?=
 =?utf-8?B?VFdMQU41MTJmM3ZkU2E5MDJwTmJCMFNiaFZKU3h0Z0JxVFF6SUJYWjlVR0Jz?=
 =?utf-8?B?a1JBWXhUd09IZ0piTy9XdnRPM1FyVnlqTGZtOWNFNlgvSTVBOVRMWXhSYWdZ?=
 =?utf-8?B?b0tRVUhzRENORy95WjZwcDVCT3BSZlRxVWxzS1RDVlBJK1hNTmRTS0tLNGRI?=
 =?utf-8?B?MzJGY1JHV1o0anZYUG5KakJsRDEvR2NTZHFSTXQ0Z3ozWHFUVGMrSm4xM29o?=
 =?utf-8?B?QXplY1NXclQ2RFVIUThISCtBT084TWFyY01HWnRnY1pmZHk5TWYxRTBQaHRs?=
 =?utf-8?B?TmVYajlPMlQwQ2IwL0l5Zk43eWpwZDV3V3NHUDhTeXUzOGF2MDdrbVY2K3J0?=
 =?utf-8?B?cjNoOVhVenlERlpWTkJRTDgreXlRNU5vSzRMWVVHRDlhWmVOcHVGUEZGZkh5?=
 =?utf-8?B?T1dTZmFEcjNMa2EwZnIxeDdlLzBhRllyNW9rdUJJVktUbUJtOERVUmJueEhZ?=
 =?utf-8?B?bjVxcGNvS0p5WUQzZGpjSDgxMzgyWnJFNll4QTluRUp1VWVVNFkxelhuYlJW?=
 =?utf-8?B?S0xLV2YyRWhPNlFzU2o5aFdXRE5jRkI5S1VtaTQ1YmJRbXZRNm9hSUtlTVNi?=
 =?utf-8?B?bkxEWkNjUVhla2hxM0Rac1NxVlpLeEE5SUdTSjdWc2FqMjRydURKU2JnWlk0?=
 =?utf-8?B?REJHS3U3RVVLLzkraG9uOCtzZG1qY1pNYUdwM0NDYXBIOGpKaW8za0pWYlhO?=
 =?utf-8?B?eFhpSmRBN2g4L0R4SUtuemtNOGo1VEhXaHh1dWRESTltZDQwUEJWVEVmdnJJ?=
 =?utf-8?B?aUg3cTNWQ0R2cDJ6YWFqZVQzMGd4RWQ0WkRtZWFhNTdHbUwvTjB5QWxlaFM3?=
 =?utf-8?B?clJDUUlXSjIyOGU3RGRrVmwxcEFRamJqeGZSeGpjR1NLMjd1dFVoK1NOOXpK?=
 =?utf-8?B?bE4zZHA4cjVJZkpVb1R1V0xRYzB5VUg3a1JBd2M1Y2NoU1NFMXVmUzVRZURt?=
 =?utf-8?B?NmU4R0o0cXVUeThDNHUzeHRZWHZ6VzFFakR0RzFEM0w2Z3BybXdjMHhTY3Zx?=
 =?utf-8?B?UkZKdnJqaDZCaHFObWQzNFZTN0VyRXZSaXlKZnV6K1JRZVJseU95VWRISnZB?=
 =?utf-8?B?eXRBNXB2d3lQTEM4UURQeFpWZllkMHd0aHZUQXVYMjJ0bkNlK0JncnN2UXRw?=
 =?utf-8?Q?DWHf2IxdseFUc5lndRj8xKIqx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56e26ecf-3f4c-4292-1064-08dd87bc503e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 07:55:02.7839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOINNu0Q+UPzmIvxB64+kLQBuUTG3VTbUpMNUPvqwi5fNIwFDrr8bHBkDw8fllw6bvc1ioYbRP0Sm6iih6hAWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8762



On 4/10/24 21:41, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 02:32:28PM +1000, Alexey Kardashevskiy wrote:
> 
>>> +	__u32 __reserved;
>>> +	__aligned_u64 vdev_id;

I believe this ended up being "virt_id"...

>>
>> What is the nature of this id?
> 
> It should be the vIOMMU's HW representation for the virtual device.
> 
> On ARM it is the stream id, the index into the Stream Table
> 
> On AMD it would be the "DeviceID" the index in the Device Table


... and I just hit a problem with it - this is basically guest BDFn and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM but does not when I pass through via the QEMU cmdline - bus numbers are not assigned yet. So I have to postpone the vdevice allocation till run time, did I miss something here? Thanks,


> On Intel it is an index into the context table
> 
> The primary usage is to transform virtual invalidations from the guest
> into physical invalidations.
> 
>> For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel interface
>> to pass the guest's BDFs for a specific host device (which is passed
>> through) and nothing in the kernel has any knowledge of it atm, is this the
>> right place, or another ioctl() is needed here?
> 
> We probably need to add the vRID as well to this struct for that
> reason.
> 
> The vdev_id is the iommu handle, and there is a platform specific
> transformation between Bus/Device/Function and the iommu handle. In
> some cases this is math, in some cases it is ACPI/DT tables or
> something.
> 
> So I think the kernel should not make an assumption about the
> relationship.
> 
> Jason

-- 
Alexey


