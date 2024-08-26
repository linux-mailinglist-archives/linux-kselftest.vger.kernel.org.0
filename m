Return-Path: <linux-kselftest+bounces-16259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CEE95EE76
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 12:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 501EAB2011B
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 10:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4441C1487C8;
	Mon, 26 Aug 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JI3GEcfZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F827142E67;
	Mon, 26 Aug 2024 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724668190; cv=fail; b=usKofnsfOnZmWeFWprkRC1FQAABMTn3IKaCLO1khBOP9yCKoW2Gr0dEzNxu+3bOotW9eTSSbxXwczTOtdEnxOkQW0QSZypLY6uzXXrX5X39Pnsgs+jEJHMRktqdgI/kDuCHP8tFzYCu6ivVRVj3zsWaaxbmugsrV+j2bGsROIUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724668190; c=relaxed/simple;
	bh=4w0hYZRrCakRsirYeh1SDMtfavqBYAS60uK/coygvLs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RwK+pQ0rFPzRSPZ9R4uDyBCAHIcx0TWBQrCgeP8ei12gcoQH9UA1nOc/ciwSuWz+UcR3XigdeEVWXVC8ntrKf6Xq+HkIfYLl3YZzIDBZ1RSOJrH+cz0gjhAa46igjYB8mR+3XjKjUiVbsV30vh5Zwu24SyM8mBSHf2x2b6j/b2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JI3GEcfZ; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5lpf67zQTYFfrYFkrwgiT33zXn6CYXDO5jgI+31boZzMpp8fqAvwDHMplJ5QVYwxUeqrsQZGNYmib9CHCFsJZaDE4UXd9KE16s/fnui2ZawCIqyjWtl78UQniBomKfQE3LUKNJLDYKIw5HdYADVxeAdkipaHRgZxKLow/lDYdAvX73mYhjg025maTwX40HPJW4bffULsZxXJD2S1njvxnrLntnopBvomCSbHCca4HePdomtxqT1VeCP2ElA20Q5kUdWE6+Z51iikTEcwwoW+rHfyG99h8HZ1RadilUIPOfO0Vpm9VxRQg68mOXJ1ODslyKXM4irEMCybhEY+Hk3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hERvPhBXoW3pfBgov8CwUiFuZmsPBRN3/1N8Y40sGAg=;
 b=nYIiBuKIUCfmgl42tPbDmnWpZLu+blNZCDc1+b8/liFe3IVyPdzCfMmu7jXvszJ+G8bLu/0vI/1UOs+LXt46ROVeE5EqVF10chRgUOperbGWxzGit77eedDkGunC5yKh/VugNly2728PDBWOxfG5KeK3E8swtOo+SYTf0yiQgl88z/ugq3epH2lNKUpaxf/lZ3kV7Ntf6klKXDtnj5WN3HFFXohlDz7O3hF6XPbiKapVB5GKahA6TGtKYJP6qw+siR+YOuqxwmSQMgzo0O7qWNZiT3Z+oUDCukbYSQFSVvkRMmCl0tZ0SPjQVVKUmTWmELpaxmSv8CGFDLueUceuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hERvPhBXoW3pfBgov8CwUiFuZmsPBRN3/1N8Y40sGAg=;
 b=JI3GEcfZsrPucJ3ruQQa+fwrddLdChSXAC95bFql2B32AFlme2yYukqlo5Qx1xVppAlwUqh9QcfQ0VBT4fgHSB64BwT6xbtOQGgAG8giz25PzjmzdJe6wOrRHVafmDX8ft8/SFoiq95MbbqdWfmYUvE8EeztIzvwKCYKMlNneSg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 CY8PR12MB7170.namprd12.prod.outlook.com (2603:10b6:930:5a::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.25; Mon, 26 Aug 2024 10:29:45 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 10:29:45 +0000
Message-ID: <002c7137-427e-4bd8-ae9e-04aab3995087@amd.com>
Date: Mon, 26 Aug 2024 15:59:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/4] KVM: selftests: Add bus lock exit test
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 babu.moger@amd.com, Manali Shukla <manali.shukla@amd.com>
References: <20240709175145.9986-1-manali.shukla@amd.com>
 <20240709175145.9986-5-manali.shukla@amd.com> <Zr-0vX9rZDY2qSwl@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <Zr-0vX9rZDY2qSwl@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0116.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::6) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|CY8PR12MB7170:EE_
X-MS-Office365-Filtering-Correlation-Id: d065bd9c-3cb5-4e91-a482-08dcc5ba00cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YldTRFhza0prNVNvWkljTEV2bFRqUzgyMlUwNlNyQXd3cGV2dnZhU3IreUUv?=
 =?utf-8?B?cDdFc2xBWXhBSUJHWFRyMlBMd0hocktqU0ZPOFhUSUhVN3BvS3F3QTl4WUZl?=
 =?utf-8?B?ZUUzSDRkMjNPejUvZGtKZlk5MGRyQU54MWE1ZVJic2FlK1hQaGxTVnk1VlRH?=
 =?utf-8?B?THIvK240dkdHTS9xaFdiUzAyNzBoUGhlbWdQdDJ2OUJhYjQyYy82cFR2SkFx?=
 =?utf-8?B?T0laWmdUR3AzZ2lQalpsL0pFOHJHc29GV2JsMTAyUlNvZ3dBL0JwYklFbHFi?=
 =?utf-8?B?bHRkWjRDb3JPakhla28xOTl0QTNBd00yVnR6ZGVTYjY5Ly93NEt6NndjRkRo?=
 =?utf-8?B?MEFnWW5qTlZSbDVvTWpWS1E4NjMxRGFzYlk4ZmNnVm1nTjFNYnBHL1lKMHpD?=
 =?utf-8?B?ZlI0RkhyaXl1ZUpFUi8veVR3TFBvdkEzdzZlUk5DSlV5VmNXSXhnc2RoY2xQ?=
 =?utf-8?B?YzNiekE5WW9TTmlYT1VXa3lVSnhpYm1qVGJYVVBZMjVlL2FsdUM5ZzBEMHQ1?=
 =?utf-8?B?UzFud1JQQXlQZHFzYzJ3V1R1VElOQU5IaWZ5RXRnaDY4akZDSmN0MDhnaGc3?=
 =?utf-8?B?Zi92T0N3ZmRIWmtJeTZIWE9UY3dpU0RIN1NvWWc0UWRwQWlRMG13dHp3OERR?=
 =?utf-8?B?Q3RRcGhVdWhhVUNucGRpbmRwQTB2dHFLL2ZEMytkbHRSZHRZUDd2QkZUWUg1?=
 =?utf-8?B?cS95a3hieTJQNUpuZlgrUTVrVDNKd0sydkxQYlRXNnlNWlpyTTJweURwZ0Fx?=
 =?utf-8?B?VXN0SjFKSjNHR25UWEVVSlJPTFdJQU1VSy9xY01ZWHl3RzJ6a1g4aW5WK3h6?=
 =?utf-8?B?ZUlQbkU1bUNKODE4Q1FhN0NqNGEyWXlJUVNNUG1hWDV4Sm5jZ0JrNjVwbXU1?=
 =?utf-8?B?QTNFcGE1b0E2cWkvTVZlV1ZaTVU2NDVrSitDOEtLdDNMd21RbUV4UDJwSlVD?=
 =?utf-8?B?emZyaW1qU2Q5YzZkS2ViNHFiUHplTWIwS2NWbjFNS2dCR0ZHUFRQSTdiZ0FI?=
 =?utf-8?B?Z1NxNkRFQmlKcmNFR1NDZjJ2WW55MU45UXgvaWw1bGJRcEcvbHJHQzN6OXU1?=
 =?utf-8?B?YXZDdXYzU2lzNVRHOFpzNXRwWG1PaXc0QkRaenNhU1BoUDNBdnVoZDlrWk5s?=
 =?utf-8?B?bTBsWXR4NUN5bVBIWlphZG9oNU04cTBhSmJ1c01NbVlDdFpRTjVJWkhWTjBD?=
 =?utf-8?B?VEJFNkJuQkZZU01hUE5hQzRDbHJWNEJIUmFSMnVIQnZaOFFPMXF5S0pyMVJp?=
 =?utf-8?B?Q3dCQjVHYnVOdHpRcmtwRUEzWVNMMEZQUUhDQTBubGh5dHpQdkwwS3oxZ0py?=
 =?utf-8?B?dUpxc05sclBWL1ZodXVtYm1wV0k4SE5PVlBuT29mMkVvUzlPbEF2WHk3dEFz?=
 =?utf-8?B?RmJyTGlVUzQ4TWgrWWs1NFN1a2xtcEtTZ2trYTdpVWhuUHArTmxOWlNnZkhG?=
 =?utf-8?B?RkFNVyszc1FnZEZ2L1ZzUm9ZMlNSemRMUGxkZVR5REltUkYzdEZZRW9nZG5H?=
 =?utf-8?B?QmZFNEdGK29ycCtobDdvdlpaamhid0xzckFSc1pUNjZETk9GMk9LTmVSa1Zn?=
 =?utf-8?B?clByK0VSZEVYOE5qU3ZremRmZFpGM2dFamlIVVJ6cjZ2M1ZINVJOekZsT3o3?=
 =?utf-8?B?Mm9JWnlVSVdiN2lTOG14YTkxbTVhdm5iNEtyYktUQ2tML0xrNmZZU0FqT3N3?=
 =?utf-8?B?SFpOamJtS0ZUazRla2hhVXNCaGxRTUhyQWZKYUI5eUtWUzZzOHFqeVQvUmQr?=
 =?utf-8?B?RG9OdmMwblU3MGlmcmlvc1pzQ1U4N2NuUkdWYlZjU1Jud0hhazlzdGlGNzFu?=
 =?utf-8?B?dHhUa0RmZ3hWeVp6UGxzZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1lKZ2t0MFZXUXhlWTBzbU9WSE13a1NnKzVQb0pYMmpMV0szUWp5R0s2RllC?=
 =?utf-8?B?Yy9EMFJDVWptR1JtdTdVNE9HUUhUODhEdTgxWEMwN2g4QmZBZE0wZVprR2R3?=
 =?utf-8?B?cjdkUzNXSTQvSGlXVXdTS0d3UmVteVBLVzhXMndLVlVDTmNJSGlQd1FuMHk5?=
 =?utf-8?B?UDY5N1FQa2QwRWZrZ1R2anlxSDVGdDhhdFlSbGpkbFk0WE9xeFFyTTZGUFU2?=
 =?utf-8?B?TkdiRlByRUVuaU5RV1FYSFJueHc1d3hqaWVCRGtUZ2E0NWUyM2JSU0NtOFRU?=
 =?utf-8?B?VE1PZWVZQm8yRzgyQ05vcHNaanQ4QUVpRGFPQWFoK2lTdUNpYnBxdURiZ0Za?=
 =?utf-8?B?RGF4NzJUMFQvcG9LWkw2OUhjTTVOcS94MFVUVFlqTTcrWXpvZG1XQitPV25X?=
 =?utf-8?B?K3A1ZitZUkxGUmkrYWVKT3JmU1h5Y0hlMkhMSExvSW1JaXNKVGQ3V2xWQWp1?=
 =?utf-8?B?UlRXVDdWVVNzcjJGenIwM3VIb0tuWlZMNENXM3hidDdXVmpaOGNVTkxqY3NS?=
 =?utf-8?B?dk9YaHBsUFI0M3JLTHpJRWUxMDZnNzljUnI4c2JnZC9GRjdIVjVBbWlmZkRl?=
 =?utf-8?B?ZEtRUG1CZlhVaWFOTWR3cHcxRlNCMTZwRUdMUlVFYitwTXRweWtsQk5LRGR4?=
 =?utf-8?B?RVdCRFIyNjZwZk00ZFBNaGJ1SWp2L3I1bG5Kem85TXkzYk96dWlFWUFGcHJy?=
 =?utf-8?B?SElrWDRjcGlGSGlTOEJJQm9NVkgrMytPd2dJS0xOMFMrTzlHb3RpS3pqOXdY?=
 =?utf-8?B?Q0F6OWh6WFRER3MzTlljQ29iVDYrRW9va1FNc2syQWxHWk1weXpWRmwrOVVs?=
 =?utf-8?B?eGR0TzVwT2k5Rnk3azFOVUVKMUl1Vkg1cTVMT214ZEg0SDJOWUJxRTJMbEVa?=
 =?utf-8?B?ejNLbFc3OXZHY1JXZ2syN08rcXR5eG9RZzBHTHozSWN6VS8yeUJGMC8yK2Rq?=
 =?utf-8?B?QVJuTkg2d1Z0aVY0eTBzTjZtbXB2SC8wZjF1UG9OVzFhSHRvbmJYYjNvMW1r?=
 =?utf-8?B?cVgzcnEvNHUxYS9ZUjFxL2FXR2NxZnJNSVZFcVNpR2FoVDBYeW1lSHNsakdL?=
 =?utf-8?B?L2x5b0dCd2NlWm1oaHlTVHh0UkFpdXdtcmFJYWdKTVNGeDRhTitNVFc4WGJX?=
 =?utf-8?B?Y09rWDdEdEhmUWllN3NmYmRxcjdxdFZqNDdnejVETzROK1EvYnNTSUVZTDJS?=
 =?utf-8?B?RVppWlc3d3E0M3BYM0VXaFZSZXFNaERqRHhQVjdZWWgvdGRicWJENXpDRm1D?=
 =?utf-8?B?SzJVMDgwVVBYZDlFU2ZTOHhPRmhBeTNWM3ByamJ1elZwV3p5OTYwb3FJbFhC?=
 =?utf-8?B?WTluNlJiOHM2Mzl5U0V0M2I1dHB1OWNKaTdyeE1RbE1GNXVWdGNDbmErdU9p?=
 =?utf-8?B?VUtKZHJzckxFbEFCdFVDYVlnTHUxY1AyWTRHSEc1RzhMQ2w1UWlpM0gxRHRs?=
 =?utf-8?B?eGFjZG9qbkZoMjJJMVFpZXhJaTJUdEs0NXBQTXJrR1R1MU9hek0rSmxaajJM?=
 =?utf-8?B?ekR6R25zOHR4bVhTODcwZGtXc2xwYktmL1dpT29JR2k0aTF1NTFRK1hPUzZh?=
 =?utf-8?B?a3hDd25MSHlIRHE4aEF3YzNObmJDZ2s5VVFZWHdZOXN0UUI1ZmJ0VGtuSWxu?=
 =?utf-8?B?T0l5RUpWN3VpTlRHSk5xTWlSbTlraDRYOVdjeU1ERUcyUG9vSU5KLzNqREgz?=
 =?utf-8?B?TkxNVk9HYjhKOGtJRHpXQWR3dTdrMURHeGY0eWIrZXpBcXBZL0xZbGt1d2ty?=
 =?utf-8?B?eERDNDZCUm1RWGlwcUcxbEoxbmhvRkdKYWhKTmswMDBId2xCeDJKMTJTeVUx?=
 =?utf-8?B?MVZmQ2M5VDBaNFpyWm0wWkNHbkNlSXFXWWZ2UGNUNy9vc0tGbWNOQnNCRjM2?=
 =?utf-8?B?YjZaeCtUdklNcFVVbHd4U1NZNE9oYmFpVnVOZzYxbXR3VGRoYmxHYlo0NzZj?=
 =?utf-8?B?aTJJTDVYbGh5dnBWWHhUcHB1dXpPMkQ1dXNia1M0MEhXcUFBT2dGNlFteDlK?=
 =?utf-8?B?eDR4anpYdkhvNVFlL3diYTNnM1NsendtYWt6K3Ziek9OZzVTUThSK0RUcU5U?=
 =?utf-8?B?ZW40U2NOTG8wMWZSSCtCNnlZa1R2TmM5VXlBbzhxcEU3UjJXcGV6bDNyU3E1?=
 =?utf-8?Q?fAxzqtGfiN6U6h0RjPCsAGThx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d065bd9c-3cb5-4e91-a482-08dcc5ba00cb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 10:29:45.1006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fKU0rD/C9kPQZ56YQfOF5wKcqBFc07pF+hfnf/3/1XGYbqr6GopsVoOQOZAs4FBZI2yXKktUOy44X3kaG/7qvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7170

Hi Sean,
Thank you for reviewing my changes.

On 8/17/2024 1:51 AM, Sean Christopherson wrote:
> On Tue, Jul 09, 2024, Manali Shukla wrote:
>> From: Nikunj A Dadhania <nikunj@amd.com>
>>
>> Malicious guests can cause bus locks to degrade the performance of
>> a system.  The Bus Lock Threshold feature is beneficial for
>> hypervisors aiming to restrict the ability of the guests to perform
>> excessive bus locks and slow down the system for all the tenants.
>>
>> Add a test case to verify the Bus Lock Threshold feature for SVM.
>>
>> [Manali:
>>   - The KVM_CAP_X86_BUS_LOCK_EXIT capability is not enabled while
>>     vcpus are created, changed the VM and vCPU creation logic to
>>     resolve the mentioned issue.
>>   - Added nested guest test case for bus lock exit.
>>   - massage commit message.
>>   - misc cleanups. ]
> 
> Again, 99% of the changelog is boilerplate that does nothing to help me
> understand what the test actually does.
> 

Sure. I will rewrite the commit messages for all the patches.

>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> Co-developed-by: Manali Shukla <manali.shukla@amd.com>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  tools/testing/selftests/kvm/Makefile          |   1 +
>>  .../selftests/kvm/x86_64/svm_buslock_test.c   | 114 ++++++++++++++++++
>>  2 files changed, 115 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
>>
>> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
>> index ce8ff8e8ce3a..711ec195e386 100644
>> --- a/tools/testing/selftests/kvm/Makefile
>> +++ b/tools/testing/selftests/kvm/Makefile
>> @@ -94,6 +94,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/smaller_maxphyaddr_emulation_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/smm_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/state_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/vmx_preemption_timer_test
>> +TEST_GEN_PROGS_x86_64 += x86_64/svm_buslock_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_int_ctl_test
>>  TEST_GEN_PROGS_x86_64 += x86_64/svm_nested_shutdown_test
>> diff --git a/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
>> new file mode 100644
>> index 000000000000..dcb595999046
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/x86_64/svm_buslock_test.c
> 
> I would *very* strongly prefer to have a bus lock test that is comment to VMX
> and SVM.  For L1, there's no unique behavior.  And for L2, assuming we don't
> support nested bus lock enabling, the only vendor specific bits are launching
> L2.
> 
> I.e. writing this so it works on both VMX and SVM should be quite straightforward.
> 

Sure I will try to write a common test for SVM and VMX.

>> @@ -0,0 +1,114 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * svm_buslock_test
>> + *
>> + * Copyright (C) 2024 Advanced Micro Devices, Inc.
>> + *
>> + * SVM testing: Buslock exit
> 
> Keep the Copyright, ditch everything else.

Sure.

> 
>> + */
>> +
>> +#include "test_util.h"
>> +#include "kvm_util.h"
>> +#include "processor.h"
>> +#include "svm_util.h"
>> +
>> +#define NO_ITERATIONS 100
> 
> Heh, NR_ITERATIONS.

Ack.

> 
>> +#define __cacheline_aligned __aligned(128)
> 
> Eh, I would just split a page, that's about as future proof as we can get in
> terms of cache line sizes.
> 

Sure.

>> +
>> +struct buslock_test {
>> +	unsigned char pad[126];
>> +	atomic_long_t val;
>> +} __packed;
>> +
>> +struct buslock_test test __cacheline_aligned;
>> +
>> +static __always_inline void buslock_atomic_add(int i, atomic_long_t *v)
>> +{
>> +	asm volatile(LOCK_PREFIX "addl %1,%0"
>> +		     : "+m" (v->counter)
>> +		     : "ir" (i) : "memory");
>> +}
>> +
>> +static void buslock_add(void)
>> +{
>> +	/*
>> +	 * Increment a cache unaligned variable atomically.
>> +	 * This should generate a bus lock exit.
> 
> So... this test doesn't actually verify that a bus lock exit occurs.  The userspace
> side will eat an exit if one occurs, but there's literally not a single TEST_ASSERT()
> in here.

Agreed, How about doing following?

+       for (;;) {
+               struct ucall uc;
+
+               vcpu_run(vcpu);
+
+               if (run->exit_reason == KVM_EXIT_IO) {
+                       switch (get_ucall(vcpu, &uc)) {
+                       case UCALL_ABORT:
+                               REPORT_GUEST_ASSERT(uc);
+                               /* NOT REACHED */
+                       case UCALL_SYNC:
+                               break;
+                       case UCALL_DONE:
+                               goto done;
+                       default:
+                               TEST_FAIL("Unknown ucall 0x%lx.", uc.cmd);
+                       }
+               }
+
+               TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_BUS_LOCK);
+               TEST_ASSERT_EQ(run->flags, KVM_RUN_X86_BUS_LOCK);
+               run->flags &= ~KVM_RUN_X86_BUS_LOCK;
+               run->exit_reason = 0;
+       }

- Manali



