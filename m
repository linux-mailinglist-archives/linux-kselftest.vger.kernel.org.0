Return-Path: <linux-kselftest+bounces-20371-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD1B9A98F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 07:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177181C2326E
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 05:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91BF135A79;
	Tue, 22 Oct 2024 05:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YojrQgVM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BB1E529;
	Tue, 22 Oct 2024 05:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729576190; cv=fail; b=bD+wjhDdokDaIxnx/VA0qBjuPAGUqOP1GgpYxxhPntdAXxGkm47xRNSW4qraFR6Pi2NZjLObDGZVRZr2q2724y/uB6DIyYI+gYbuq/PyZd9to5JWOUfsED9i19NRoVop20zp8RyqrtewrkgueBrnUH8ol2Y7ygQWuUUAcPKOhPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729576190; c=relaxed/simple;
	bh=Nq93z/UxITtDRM9IuW2VDkYvNAxWa4IaXhjW8WuqZOg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ncqt9vzBni0OPqlAY7+rMmmByk+bjNw1cioJwjw3qQYXB+G4uk1SUZe7+596O1KRCRFmTnOTpHrwN0/c04gZ2JS7R4kRtNd2f79FHwE2F3OdmKCq/hCAVL/7h6dFxhm2OHw6ifxh9Jy6k2MJbVeVoh2K7obLkxmMlIVsufFpvSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YojrQgVM; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VaM71Z4zfWo/9cb/Lvfvh1D6wjuifQiERWHy3ExEVhLQ7ippdm2VngHW45KuV+MJVA7BWaCXvjCy8EllfKCjCD6nYp7am5JhOzwnEYDWU3ADoOBjrynGYT1G0/wo4ddtCGkRHWaUnuFrDDf1LegbYF5WXUbOb3bm7iSzHN8N1Eg35aKeLG0opSS96o0E7cnq4XzZa+DECrJKqqN8DJ6dcLodjPEAejnEyUv4YpO212exaGp8mYKGf/WDipjAHHl+wsDrHZLvIsVVx5CkrleLb4N+BOhkpg7mGsEQWK23Qn4fGHrnVuJq6YF9x5IQ2fuN3G9fevHZ5syExTaAh/yG8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKm0WqgCwU6u51u5KggH6iPrSdecl7wVvrMspTIUVio=;
 b=ryob7rgQd5TAVIa1IK0Zpcyt4uyTSSX4jn47JEdGJVY/D7mcWQY5oJj1SmEMcq7bNXb19D9jsz6P5ZkGIz0VCaUvcO9d4czg7wvAfVM1Vrv/feIHuwJNCNTFV4Cc/4qgn5K8rMQn9KQ2OES+xf9DCQdxxVuHUV57kUMS5uccKFk0+73dF9gT/SWGhsukjz4X7A1BeROg0y2enDtgmznpf2m/a1Df2OeB4VYPeIIf0RjSHPunwYtAKFJnFBWkEb43m3Gu/EZqXQ8rODcSJI3oo48XiVHMheHGEr/wnvx0mBo4Thk639GbfUJNDqaE0R1XCvbbo+kdNUx+dgAvTF00tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKm0WqgCwU6u51u5KggH6iPrSdecl7wVvrMspTIUVio=;
 b=YojrQgVMM72nGKzTz+np1/99QPnhL27PC55latP7zFMxdflvQJYfRH+6zU3kUrqY4IsP+aZveCpqjh0QrbuZIYdhyDyboVylIWXBs8BEe4oA4A0a86ABvhzJJxINFS9LwVqbDsMNCo9GKT6XmoiOTJwAkP7awX007ZNAiEr1/vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.29; Tue, 22 Oct 2024 05:49:45 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%7]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 05:49:45 +0000
Message-ID: <9d7c43a6-b385-4ec7-b8bd-5378e43a6aaf@amd.com>
Date: Tue, 22 Oct 2024 11:19:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] KVM: selftests: Add an interface to read the data
 of named vcpu stat
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, shuah@kernel.org, nikunj@amd.com,
 thomas.lendacky@amd.com, vkuznets@redhat.com, bp@alien8.de,
 ajones@ventanamicro.com
References: <20240528041926.3989-1-manali.shukla@amd.com>
 <20240528041926.3989-5-manali.shukla@amd.com> <ZruLwp54itwpCPk-@google.com>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <ZruLwp54itwpCPk-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::7) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|BL3PR12MB6425:EE_
X-MS-Office365-Filtering-Correlation-Id: 72f8a787-710f-485b-92aa-08dcf25d54fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1R2WmZBdjl3bWhhWHpjdlRmK1B2NW0reVluY080SkFRZUxETDdkOHNXUDFB?=
 =?utf-8?B?SkR6OG1xQ1V1R3kwOFI5K096bU1PVUZRMmNHUjRpeEROYXVERFludGZEVnNn?=
 =?utf-8?B?cnFuZ0liamg4cGdrcktzOUVZMHlqMlp1UE9vc1daKzNPMFBhQWdpY1FPV0Vp?=
 =?utf-8?B?djNYQjRPbjhDV2cxRHdXdkp0ZXMyY1B1QnlWSHlraUlidDdNTzJ5RzBpNWt4?=
 =?utf-8?B?aG14eTh2K0pYVHpxZWJOQW84c0ZiclpIRXNBY2hIOU1vdWQ4K0l4ZDBpVVFJ?=
 =?utf-8?B?ZEVkOHErL1dtdzhNN2FkNnFoNzJPdHZWMmhicytJSVZvdU5HV2ZjZlArUy9S?=
 =?utf-8?B?SlZGWnhYUUFTZHpuTU45aHExR0p0OXdqNUFBMVJiTTFKeUpPbWJxM29NM2w4?=
 =?utf-8?B?U3pieDFGS1JUYlNmSXArWE41YmV3aTh2cW9ud1BoNisramxrUGpiVTkzcEcr?=
 =?utf-8?B?em9Pa09HWXd0bGhaaG9EdXlKb1JuZWpGTVI4RUkwQ3QyTEpRWVZFaVZFdFJt?=
 =?utf-8?B?NGVwYkFGRDd2aXFuYlBzM2dmUElUbmVWTldWNWV0aU9pbS9QSjRJWW1la0hn?=
 =?utf-8?B?aXVkY1ZsRnM3Ymt4NFJWUFQ3RkNSdnlOcXZpbUp4VjNaUk5UYjZQRURVRnM3?=
 =?utf-8?B?TUZCMGIwTnhlM2FnZ0FtK3FnTFJvTjBqVUwvQkRINzZqcnVsazFjbUZlZERk?=
 =?utf-8?B?YWFpTGE2VVRobHVLQ1ZWdHB2djA0UVVvN3dNS0hJMU8xRExoZHZweE9QODU4?=
 =?utf-8?B?c2JiZm4xamRScHFsS0lEOERTN0ZMaS9ic2xGd1lGNXFjSUNNbjNHdG9tZjAr?=
 =?utf-8?B?UUpscnptOEw0VklsVnVOUFFxRUg4TmE1QXhxSzhnRTh5ZVNmSzFNNWZSeTd6?=
 =?utf-8?B?YXFXUVEzWXp5S0NCdnhOQXhvRWJWLzFDRS8xTC90SkNWVHl4ZjJmOHdkZWtt?=
 =?utf-8?B?MWJYNUJPbWt6WFd0S2VweGZ5S3V2REoyOGpKME9rRUVmSXA5eTlKaTNWTy9M?=
 =?utf-8?B?L2YxK0RJcXJFUndnTi9IcDUxTlZXMVZGY0lyT2t3MTJVbkpQZ3JqNjRyR0R1?=
 =?utf-8?B?T3VFd3pLNGEycXcxUmkxVmQvRExBNldFQUdpanRISlFhOWZjVStpcGlwTXND?=
 =?utf-8?B?dmRhSWZQNjA0MFE0MGVBTE8xblJmU0liaWVSRkpMb1pla1dqQ2hHSWg1Nmpm?=
 =?utf-8?B?WGxHY2E5bmVzMkRSSkN3My9LTytoYkJDY3A2YlIrUXBoRnE2cEdhMVVjWFNs?=
 =?utf-8?B?clozY3U4MUpNek1pelZ4ZnZFWHltMjFXMmtxUGpYeVQrbVMrOENOa0taWGN1?=
 =?utf-8?B?QWNCanJKMFd5Mnc4VC9PQVN6S1F0bGhuWDNuZS9UTEFweVVJOTg4anAvUmpF?=
 =?utf-8?B?Z3oxSXYvN2w3ZFAzRHMreXBoMkpFOWtmSVpRSWxKbnRWWGs1NWp4UTdFKzJB?=
 =?utf-8?B?VDIzYXRTM2RYc0lRcktQREM3TkJ6NzRjUTNJTkJ1cStNbkl2ZVpWZjJYT09C?=
 =?utf-8?B?YlZFblVLNHUxNzU0eXQ0QUcyMnhiRjRWSGpZbGZ6NTB1Y2h3RGRiaEt3UG1o?=
 =?utf-8?B?cHBKN0gyQm8ySEZTYXIwWHVWdGxIeHhJTzNMUWVSdE5QaWJkbFM1a21teEYz?=
 =?utf-8?B?d21YcnNYTElZOTBoZ3QxL3ltT1lGbzlnTVk0c2dSVERQcm1uRDV6Y0htQjJs?=
 =?utf-8?B?dUQ2VzVobVdsNkxmZ2tneTFKT3ZWWEhDYTZ2QzZsZWN1YURQbXRTZERMd3Ri?=
 =?utf-8?Q?QWy3lrPLodsy/MQNa76mnTktTYinRdUYCqw6sca?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vk9VSlEyRzQyMkVtK0dYdUtvZXBxVGl3d3UxL2tySGdDdkFpbDRGbVNmU0tM?=
 =?utf-8?B?WHk3R2E4SlQ2YkFPeWRlVUkvdExBY0N2T2xueVQzek50alRhYnR1WU1VWHJV?=
 =?utf-8?B?S1NaaExUYWk4UEFjbHdDTThBekpRTFVvUlBYb3NpTUI1N01VTDd0R1RYMFFu?=
 =?utf-8?B?Rkt6K0FUa3IvejJTdEdFa0JXM0QyTDRyZ1NuM1AxSjNvdzN3RDJDSDc3OUlp?=
 =?utf-8?B?bVhaL1Zmam93RFBVUkxQVEpNSC96M3pyTm1ROGp0U2pHWVVMQVpxRHlzSHoy?=
 =?utf-8?B?OGtacVk2MXhSTFBTbWNnclVmQ3A4eU1iMi8yU2F5VnUwRlNGczhJWVJCTGpX?=
 =?utf-8?B?eS91RTVyWFd5MlBxYXpNeDNQRnFtWmIrblBsY2JOSGxkQzQrVDcrQjlveER1?=
 =?utf-8?B?dmxRL3RDRkpmYlY4ek1RQzE2TFhnSlBPU3pWN0xXemZpRGRIWFd5b2k0WVVY?=
 =?utf-8?B?VStLYm5ibVJLalQ4dExXaEd1dDR1R2JQeksrMzE2ZUpldmJqcU1RQnc1RGZh?=
 =?utf-8?B?d3VHc25JT2JHNFlDNHNZMy9hY21MMTVXQk5GS2ZuSnhVZDcwSnNjRWpzSDlh?=
 =?utf-8?B?c1p5TGF1RjNnQmprazhuNHhzc0tkZm5kSk85aEdVQURFTDN1UENObE1sSldS?=
 =?utf-8?B?SEFDVUxmSDJSZUhodzBIcGhzckQyaHE3cnhvS3JSZkp2bURxRTZTeFo1K0Z4?=
 =?utf-8?B?WkV0YkJCK09EQ1Y4SUo4bkZxY2dPakZTbXkzamZ1MjhRQkFwL1Ywa3hQemIy?=
 =?utf-8?B?YmtyaS9CSVpEZzNyYVZIQkFKd3FLcUlUUUZvSGwrZUFXQityTWsvRWpvL3FF?=
 =?utf-8?B?U1AyY3hVanU3cS9wNWR5elIybEtsMitMNWR0dWNtOUx6V1dKSVJiU0laRUho?=
 =?utf-8?B?aitiTzBRRzl2bWdDUk5kZEk4ZUMxQ1F6MHdmcEdpZkVqZnVTTjJMWURQTmlo?=
 =?utf-8?B?OFNnWE9uSXNIcS9OSFN3V3BINzNQOE5JbWtRZmdLWXYydklLRU1Lczg0UDY5?=
 =?utf-8?B?N3RyS3FhTEV4cVJ1WkFEZEhMTTZITGpBZkY3SXdDaDZnWi9ZWFpuN0psSFBm?=
 =?utf-8?B?V3pnK214VzZEMDkrLzNXdy9vZUhIa3JlQWd6VEM3U1pKYU9KeWRvd1NWMVNr?=
 =?utf-8?B?cm5NT1ZKZ3RRSVpkV2s2cU5DRmdFekNSUlVmNVgyTnJXUGhQRUU3alBtNHhL?=
 =?utf-8?B?VkFaL2xJeWN3VmU0N2MvTXJwd09BMHdMWDR2S25PZmkzbGlHYXhWVmdIeHND?=
 =?utf-8?B?Mk5oUWk0cHE4TWhvL2dJU2cwc01kY0JJa1h2ODFJUHVMbzJCbXRJeVhFaVE3?=
 =?utf-8?B?U1pLa3lLY3VmMnVhTXhBdXArUzJRS21Cc1hwdmhVb1NhYk1nUE9raTNsc0JW?=
 =?utf-8?B?Q214VVlRdUovT3M3WjAwWUlsMmNpZkh2Mis1YkZnb3dSRjhmR1RjTEVSc3c3?=
 =?utf-8?B?b0E2OUNlTVJZWW1IbzJHWTV0cUROdFhncTMrTTdIUmo4dFBLb3hmbE82WkRY?=
 =?utf-8?B?TlEydUdmN3czVmNCa2FIbm14NnJWVWhKY0VWMUk5c0FuNHdTcjFYOUZETkVv?=
 =?utf-8?B?aTNXV1hJaFJ2c0xnZ1drUHQ3bGxpeFFoM3hZNUhyRGJubENsay9IRzkxcElq?=
 =?utf-8?B?RTE3WUNDdDFiWjJpRWI5SE5rekhxRmdKQ25oOVE2Q1NsR0xmQ2J6VzNxM1V4?=
 =?utf-8?B?aVU3SUllWWNRa1FQWWwxTUlwZ1crSzNFTDR5akxNcTV5K0czeTdOblFuekds?=
 =?utf-8?B?WGE5cUhLb1BRbFZLSFlDNit3VnNkNXBMc1FaS2xoWDZKRVpiRENIWEIwUm5q?=
 =?utf-8?B?ZXJOL1crMmpoaWJYckRyVTVydzlHekNGMTVFUnV5WnVTL0xHcThIbjV0OFlG?=
 =?utf-8?B?NkZqRkgyaW1hUVVGMGpHaThCMDF5RDlrTHBSamhBcU00V0hUYzF5T3cvdk1M?=
 =?utf-8?B?ci9iZUd1MDl6OUcyTGpJZUtGZE1IeE00bnBlbm8yTkdXVlI0MC9OZlVXOTBk?=
 =?utf-8?B?MDlkd3hVR2RJM3hoVlNmZmdUUlFQcmV5UTFnUjdmSUhORXh0ZitmcXNiY3dr?=
 =?utf-8?B?RmMyTDF6MnNNU1hDVDJnMkNtcGhWY1IrZFBpRGdXM1BQS0RqRmVhallZVHhE?=
 =?utf-8?Q?kun8Ee6QFJkH3SEAnrHWwqrJA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72f8a787-710f-485b-92aa-08dcf25d54fa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:49:45.5487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pmx3NMhAfDvNtXozdxPZXa+ZAx0GY+is6TCVjnCyxgOsknH5UUrFvMOCkFEfcQNHlpaTjQ0apguzI7+bVHiWDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6425

Hi Sean,

Thank you for reviewing my patches. Sorry for the delay in response.

On 8/13/2024 10:07 PM, Sean Christopherson wrote:
> On Tue, May 28, 2024, Manali Shukla wrote:
>> From: Manali Shukla <Manali.Shukla@amd.com>
>>
>> The interface is used to read the data values of a specified vcpu stat
>> from the currenly available binary stats interface.
>>
>> Signed-off-by: Manali Shukla <Manali.Shukla@amd.com>
>> ---
>>  .../kvm/include/kvm_arch_vcpu_states.h        | 49 +++++++++++++++++++
>>  .../testing/selftests/kvm/include/kvm_util.h  | 34 +++++++++++++
>>  tools/testing/selftests/kvm/lib/kvm_util.c    | 32 ++++++++++++
>>  3 files changed, 115 insertions(+)
>>  create mode 100644 tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
>>
>> diff --git a/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
>> new file mode 100644
>> index 000000000000..755ff7de53d9
>> --- /dev/null
>> +++ b/tools/testing/selftests/kvm/include/kvm_arch_vcpu_states.h
>> @@ -0,0 +1,49 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +/*
>> + * Arch-specific stats are added to the kvm_arch_vcpu_states.h. Sequence
>> + * of arch-specific vcpu_stat_type should be same as they are declared in
>> + * arch-specific kvm_vcpu_stat.
>> + */
>> +#ifdef __x86_64__
> 
> This is backwards.  If you want arch specific stats, put it them in an arch specific
> header.
> 
>> +#define KVM_X86_VCPU_STATE(x) KVM_VCPU_STATE(x)
>> +
>> +KVM_X86_VCPU_STATE(PF_TAKEN)
> 
> I'm pretty sure you want KVM_VCPU_STAT, KVM_X86_VCPU_STAT, kvm_arch_vcpu_states.h,
> etc.
> 
>> +KVM_X86_VCPU_STATE(PF_FIXED)
> 
> ...
> 
>> +/*
>> + * Ensure that the sequence of the enum vcpu_stat_types matches the order of
>> + * kvm_vcpu_stats_desc[].  Otherwise, vcpu_get_stat() may return incorrect data
>> + * because __vcpu_get_stat() uses the enum type as an index to get the
>> + * descriptor for a given stat and then uses read_stat_data() to get the stats
>> + * from the descriptor.
> 
> This isn't maintainable.  Unless I'm missing something, the _order_ of KVM's stats
> isn't ABI, and blindly reading an entry and hoping its the right one is doomed to
> fail.
> 
> I don't see any reason whatsoever to diverge from the core functionality of
> __vm_get_stat().  The only difference should be the origin of the stats file and
> header.
> 
> I do see a lot of room for improvement, but that can and should be done for both
> VM and vCPU stats.  E.g. provide an API (and a container/struct?) to get a direct
> pointer to stat so that selftests don't have to walk all descriptors when they're
> reading the same stat over and over.
> 
> And to detect typos at compile time, {vcpu,vm}_get_stat() could either play macro
> games or use enums and array to detect usage of a stat that doesn't exist.  E.g.
> 
> static inline uint64_t vm_get_stat(struct kvm_vm *vm, int stat)
> {
> 	uint64_t data;
> 
> 	__vm_get_stat(vm, kvm_vm_stats[stat], &data, 1);
> 	return data;
> }
> 
> or 
> 
> #define vm_get_stat(vm, stat)			\
> ({						\
> 	uin64_t __data;				\
> 						\
> 	<concatenation trickery to trigger compiler error if the stat doesn't exit>
> 	__vm_get_stat(vm, #stat, &data, 1);	\
> 	data;					\
> })
> 
> I'd probably vote for macro games, e.g. so that it's all but impossible to pass
> a per-VM stat into vcpu_get_stat(), and vice versa.

All the review comments from this patch are taken care in [1].

[1] https://lore.kernel.org/kvm/20241021062226.108657-1-manali.shukla@amd.com/T/#t

- Manali

