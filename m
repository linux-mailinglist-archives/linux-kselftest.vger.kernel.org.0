Return-Path: <linux-kselftest+bounces-32557-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DECAAD8E9
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D439E3A481D
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 07:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9FD22D7BC;
	Wed,  7 May 2025 07:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nl4DgQbw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1844222D780;
	Wed,  7 May 2025 07:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603730; cv=fail; b=MLNtBmpK1p2CnpIphAsLBuq49hlzpzp3rMr3Mvl9ZLX9qlNNGipwdQym287Dawd5jxq6SsCGaBPe4Ezw4YvQWhUDYMOiRAVQZNQPjbKZ0qPQ0GiSmZizkzmLXRfSQF5YRwAO8oxPATuywL9rzueEiiJiM2Dtg34ajm/BAOLy2eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603730; c=relaxed/simple;
	bh=os3Is8MChh0V6GJttrY3/WVs1LO7eNDjZkRUyuBpu58=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qhuEHUHV20tEVbpNkJVU90Gw88q+8Q425K7U/KRdXK25uzSHyMlG7slK67Ne9Q0FGqccOwHD4raTzy7+myoM7h6QanzK+IjgMQrezLmL8m9XXDDvg8WYXHL8Zrbsm9HhV5XXg8relboA7jvIoNwcP5DSvr7bCB7iow9rPt0e9b4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nl4DgQbw; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mycv2iQnS0HIoPzFQozYvtAVKXgY8xyNXZuh61qmFbT6shYFljuzdlrFEMNa5Ugn2ur2JFDgZSc5ztzO3B7kcFQzwLnk1QwKstozS36kTBkmORuRZMmrvcc3UP3UWJIqOWkO1zYAqtbfLReJJSqE49SrKvNyvzsF7wWeZa9NxAb7qMcBRkIA9HlG969JSdmE8HKDpKCiz2KTPovmp7CCzV3yoZ4JX/nfMUTlAdmDAzs7D0OjJNOHBvpZFepsswSrxYH17xouayvIpDRJeVHi/DiMXfsW8gAY2zKB4zao08KC2557hMSUbOK5k9tBrGDIFEKGyHAeC6/xNJUGMwdQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFmAdaqUJDVR9Ju5NFWxBHBuqOnnWh8nZe4rQupz6Zs=;
 b=YaLTKKC7ZqkRhQqA+a+gaOeI5k2Qew/h41vSrrRZnRZsOmYQft1IaL9MW14ClDkHcw/+Npvam4K1EVYasZCaAjWGuqOKJSNhSecrdvb6MsAxGf1nRfRWvs9ZFhHHJ1TJ7/h17hqgT8bYnmy/2ZtJoC8QacBxSZWWsQ5ExtkyNp4x5E8GVwwnP2uiGI7Oqaxew2aj8BhxZzfCD12OH5VhYAXJR0RKUCrdEfldGuWBV3jn3/ezKukwxDxR9+cARLSIlkda2LUq1t5JzSOFU2jNyAEARugYYQJ7uODqUAJtKBONveNfe2GqfSlvTVZtlxjGn97YYW3msrw69eYobz9XbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFmAdaqUJDVR9Ju5NFWxBHBuqOnnWh8nZe4rQupz6Zs=;
 b=Nl4DgQbwoSGafJjy1knjXi+c4/frssBJ/tF4eMekSQf2M9jEQtCCuQBLxVq5QcAeaPRAovDTOUNSQSjXixID9H2r+T4sZA7HqcGY23L6KgLCS6+JLk9iBq1au7+uTBMvBUgZ8lmD52TRij0frlbxlvix6uwPK5026M8rZTas2H0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DM4PR12MB6469.namprd12.prod.outlook.com (2603:10b6:8:b6::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Wed, 7 May 2025 07:41:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Wed, 7 May 2025
 07:41:59 +0000
Message-ID: <eb0d3629-8663-45e9-b929-0c6edff31291@amd.com>
Date: Wed, 7 May 2025 13:11:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/23] iommufd/viommu: Add IOMMUFD_CMD_VQUEUE_ALLOC
 ioctl
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com, corbet@lwn.net,
 will@kernel.org, bagasdotme@gmail.com, robin.murphy@arm.com,
 joro@8bytes.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
 jonathanh@nvidia.com, shuah@kernel.org, jsnitsel@redhat.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 mshavit@google.com, praan@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev, mochs@nvidia.com, alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <1ef2e242ee1d844f823581a5365823d78c67ec6a.1746139811.git.nicolinc@nvidia.com>
 <6ffe5249-b429-435e-a780-ee90aeb3f0da@amd.com>
 <20250506120114.GV2260709@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20250506120114.GV2260709@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DM4PR12MB6469:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ae513f0-67b3-4fc2-026b-08dd8d3aa5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3RBYkVhM2MxVHRrYWh5dndTVWZIZ2tpbkhXNVNDc3FUUE5iZ0pYOVZSUkUr?=
 =?utf-8?B?WFJmTE9KcHBjNXMvQWVVY21STkcrQXhFbTNqWHFaU0I4ZzF5OFJsb2xrS2Rm?=
 =?utf-8?B?eEt0Sm1SRXNDck8zWlNFL1hBMHpSZDF0bnZEMXV1LzVzaTRVVzlrMTBiNmF5?=
 =?utf-8?B?SVFSQ3hrU05tbHh3V1d1TXNJYjZUS1FqNDJGNzZldlNiZTJYQjZyQWp2R0Vq?=
 =?utf-8?B?NHM3cDFzc3c4YXp0UUtqRy9BNFZoMGtVRVEvWWFoZHlKU1A1VzVDTit1c08y?=
 =?utf-8?B?MWVZWlJZK0ROU2NpcFU0RzFyRmw5Z2doSDE2a1E1TVl4YkNhU0dZeTdJS1JC?=
 =?utf-8?B?TEhDbG83bGx1Uk03UG9ITmMvRHorYkpIbUZwaU9BazA1NFlPWWN0OTNBRW5p?=
 =?utf-8?B?aU1qTWF5L0lRc2YvVEppK1VaTkxMaWxIOE01MlJOTVhOdVVRVlJHam1RbW43?=
 =?utf-8?B?TTg1ZGRUb1M3MjI5RFVGQVBIWTB1NFRmNHYwckNDR1NjWmpSdzBKR1dtU25U?=
 =?utf-8?B?TnN6Ylk1TlZHTWJkenRiTHRzV3MxNlpvSnF5UWV3c0lMTEc1WnF6a0d5N0hs?=
 =?utf-8?B?TjJnWXJwVnNUZUlLMVRRaDBFeEpJa2ZsdncwOWVkNEw4cDZpS25yaDdXaVFM?=
 =?utf-8?B?emJaU0lGbUJFbnQ0cXVYNWR4Y0RRSi83V1EwbzlYMHQ3S0VRTUxYOHd2N1BE?=
 =?utf-8?B?WW5hdjkzSGNoNGM5aVkzYjlpV20wVFg5UDJXTm9YRG5IVzV0OUJJb3QzemtD?=
 =?utf-8?B?VGJHaHlmcEUwNENDYnBRZTVPdzhYNmhrNHpLcXliYkNpL29DL0ZUU3dWNkJS?=
 =?utf-8?B?VDNDN1dJQUJQRlNVUGdMbFVRLzMvRUpoWHV6N1FmN3p3UlZqc2xldjk3WTk4?=
 =?utf-8?B?N2VteW9YODhWam94UnROZlVaYkJEUVUwcmVlN2JDRjlMMUlVNXZUL1BHMkx1?=
 =?utf-8?B?WWlrNnpPQmFmT05WdGJTQ05FT3gvN3dFaXdqTnRVa2lEajhzcVZPQWxBenda?=
 =?utf-8?B?eWZobmF1NGhzQjFiNzFHY0FHdEZ2Yjh4MldFNTQwN1NIQ0RjQW1hZDRTZUh1?=
 =?utf-8?B?RVd3dlhCaUwvN0F0NG4rN3MvelN4QXlFTVk0b2NEb1Q5TXJxK1pmSmtVeElJ?=
 =?utf-8?B?Ykw1akQwVlZKREpQZTZFd0t3dlpkV0VmczJzOEk4RFEwWm1JMVZtcTFlcGlC?=
 =?utf-8?B?cm9rbTZzbThJVFBzcUFWRmk0U2tTcVdpZDBXVjRYOWRzR1dtRVRMZy9WZGRU?=
 =?utf-8?B?L3g3dlJQbEt0TnMwS2J0aVZRWkdGNEc5aGZUYitHMFM1L21CU3dXMXRzNzMz?=
 =?utf-8?B?NVdJcy9RUy9HVGtFcXdvd3pFcHVTZjZXaFVpUnJYT3RVTklJdmlOSVZ4NHVH?=
 =?utf-8?B?NGRrc1hYTjB0YnhYRDN4U0VQcE9VYXUraEp6OVRQTjRJV1Y3WkVaN1NXbVc5?=
 =?utf-8?B?aGZ2QVRUOXZiMHZxWSthUFc0Mzg4aXlxYUFDd3Mza1N1cWZNUG5HVkl1UTIw?=
 =?utf-8?B?SGRTUnZZbXYwQjRsbW1ia2FEaUNEcEdWdUlNcTN0RHZHS0RaOUVMZWJ1Q0RU?=
 =?utf-8?B?WGtXK0FTVGRwWEVqSUFFTUV3Vk8yQ0lwMm85eWxGZUJJbkpIVllxRy9VN0VE?=
 =?utf-8?B?NmEwaWt0QVZ4VTlielhWK3k5b1ExYTEvN2NsSHlhdGcyOHord1NIQk9DN0FI?=
 =?utf-8?B?L1R4RTJyanRMUzA3STlMSFJ3ZFl2bnVBdWJtVENHbE1CSlRHN3N1TzB2ZjZ1?=
 =?utf-8?B?b2UyUTlWQXZZWUxJa2RKejE5YzJWRUVMUURuR2xWbGRTWi90YWJ2b0o0Skdt?=
 =?utf-8?B?Qi9FbWU0U2M4Y2xxY2krSkNtZFJrK3BJbjFHaUlWNVZiZ0hsSndrNFRDdlVG?=
 =?utf-8?B?cXQyV3QzZ0FyTWErUW5lRUxiTnQ0MDFadnFVekY4b0xpSUNBV2xBYS9BaDA3?=
 =?utf-8?Q?9HV+wPhXXr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjZaT0ZlSys0ZzlYYmRVMXlVdmpMcW1lWm90Y24wWnZpS0h1YUdLb0IxYjRj?=
 =?utf-8?B?NUIrTDV5aDhCZlFFdUFrR0djRzNYWTFVNjhEM0dUOGM0M1FMeHlibGtBOTA0?=
 =?utf-8?B?VTB6dHRGblZidlJDQnBTTzRTdDNwdWlzV0U3dm1FNnlvYmZBK0UwRXhLMjVs?=
 =?utf-8?B?MGE3Nm5NbEYvcERUR2h1bmVnRnprWmhrT2hQeDB3eHlPN0FmQW1vQWpsN1JJ?=
 =?utf-8?B?SEg3dTkxdTA2dUE3YnlqdWFGOG15bWpNWHNwdnppaURGdlAraFBjMWhJdzNG?=
 =?utf-8?B?V1Iwb2E3Y3oyck5mT21WMDN4di92L3duYjNIMTVQTWU1U3Y5RVMrMThGOEpw?=
 =?utf-8?B?M1FudWY3QnRickpaRE1yR0hBT1c0U0ZwUjdIU2hkMHpKZXdCTVNyWHRJUVBt?=
 =?utf-8?B?a0V0SW53NW04dWVsSlpCb3Jwcm1JNm8xSDBDQmh1RlNqU2Z1eE5EUVF0VlVN?=
 =?utf-8?B?Y1F4K1ZOZUxOTjM0ZGpOL2RaZEw2UW8zeTdRNjQxVGtlQ1h3elVyZFdOSWZ1?=
 =?utf-8?B?U2p4ZTB4aXgyVnBUb3RBMmNVSnF3MkMyRzc1SHZ4M2dxSTY5ZXZtNndTeFRO?=
 =?utf-8?B?bWtNbklEc2NETmduaS9EdEJ0ZG56QTN3Um1NV0lKK2phbGJNbzVZczZnYjVW?=
 =?utf-8?B?dmJKNlBwR3hRaXlaVGFBcmphVmRIMFJKNllYclM4dGk2NVVvVzhiMG9lUXlu?=
 =?utf-8?B?cEk3UGVPTnBKSVZGcmlUempMY0V1SzZYZ3pxKzNCbjYwdnNSSzdjSFd6Q3JJ?=
 =?utf-8?B?ZGp5ZzNMTmpuQXFCUlBWYUNYUkNYaS9HRXAzMmU5MlJQeGlBZFNEd2tsdTVp?=
 =?utf-8?B?KzBKSlMzQnBrTUZHYmt5WDBGYjBWS0lRcTJiRGFQUzU3ck9rbkJRNnFDNE5T?=
 =?utf-8?B?ZS9tRmVFTzYrRFUyTlc4MmZCaFN0VGo3OHpDWldYSFlaRWZFZFRQYlhyNUwx?=
 =?utf-8?B?ZTBMb1BaWUhBSHBCMDhFV1FnWTR1NDFTaGR6cW54eTRhZnpFVjFvZm1wTjFN?=
 =?utf-8?B?NjJabUhob0RtQmVyeDlMcU5reUtVeUJ2RFBhYUpHcWVtaUYwdkpmbytJdjVj?=
 =?utf-8?B?bk9sWlJ6d3hSK0pFUVRxVCtDRUF5bGhndDgxdmthQkpFRmJ5YkJCUGVjUFdB?=
 =?utf-8?B?SEN6Z3BiREVZcFV2SDc4V2FGR2RMK1hucWRoTGplM2ZDTThMNXhMQnQrVUFa?=
 =?utf-8?B?U1pqYVoxUzl0OGxDa1NhTjl3aEdxMUxMTUtNYXJqRzd4cnhuMjFYbHlEOEl5?=
 =?utf-8?B?V2s4TmVWTmJTT1d0bzJwNEZVNVh5dDM3UE9acGE3NXBZTk1MWVdpNTdiUC8w?=
 =?utf-8?B?Qm04WjZ6SXJVNEtUdnpQSTA1elkvb2loODh1akQwcjNxYjVEcFp0QW1CWkQ1?=
 =?utf-8?B?YVpUeHhnNE5KTVR6ZWRsK1NHeVVYN3hGWHdTV1o5SkZuK3hFOCtFKzZuUmVE?=
 =?utf-8?B?cmRxVVpieVJlTFprUWdHL0wwUncxM21KZE5JZzJSMEprNEtWZlRBMXllNWpF?=
 =?utf-8?B?eGNJbExLK3RMZjVKMmZrejBXbDR5VktReldlVURjYmxCbEplOE1OWUJkS2o0?=
 =?utf-8?B?TGl3SjMwejlYMEI3eEFIclpjS09IejFyK0UvQTVJWnluVE55TzNrVDhhcERn?=
 =?utf-8?B?ZzNqajYrUkNtR1RqUGV6YURaMUNqd3lwUDl4b1FnTUhsUWdLSjdZQXFWVlIr?=
 =?utf-8?B?elVtMHprb0hqWjBwR1NDbkUvc2VMUHpidGhLN3dwWFdOdE1Senk0OGNqamQx?=
 =?utf-8?B?R1N0alAvTVdSd0xVSHpHbkFYQmtNdlhIOFFtYlBIVzNRTW9HM0M4RzJLV1dC?=
 =?utf-8?B?OVVDblFxWnV4dndWOVpqaDd1MWNjR3pBTk4rNUhlUkMxQU9BN0Q1QXBqdVFh?=
 =?utf-8?B?RUNWVXh6TjFwREdnYkVBdENWa211ZUkzYktDMmlTL2hYa05FMUo2endzSU1j?=
 =?utf-8?B?alRzSmppYURUS0t2dXFWVEZtemdzWkpEMlI3Y3Evb0h3NGZSMkJkL3UvNzFy?=
 =?utf-8?B?b1ZlSWhBQUVnMFNqUlUwZjRhRHN4YjJkNGVxUDJrQ2lLQ0F2ekhpeTJwdWVp?=
 =?utf-8?B?TTI5TFFuYUlzS0JXYWRXdExtcnprNmMzTlNVQ2FGK1lSNXEza1JLSEsxNVNI?=
 =?utf-8?Q?19x3pQ+FmJGxqmQRgCotQ0Bdb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ae513f0-67b3-4fc2-026b-08dd8d3aa5cc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:41:58.9777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5brLI0CWAgwTSlhr/t09SzcSmXNftQ4lIXrdFyO0guoRzT4fXAOHsMZmbY/sinZrVLUrJ4Z7xGrnyCPqylhBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6469

Hi Jason,


On 5/6/2025 5:31 PM, Jason Gunthorpe wrote:
> On Tue, May 06, 2025 at 02:45:00PM +0530, Vasant Hegde wrote:
>>> +/**
>>> + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
>>> + * @size: sizeof(struct iommu_vqueue_alloc)
>>> + * @flags: Must be 0
>>> + * @viommu_id: Virtual IOMMU ID to associate the virtual queue with
>>> + * @type: One of enum iommu_vqueue_type
>>> + * @index: The logical index to the virtual queue per virtual IOMMU, for a multi
>>> + *         queue model
>>> + * @out_vqueue_id: The ID of the new virtual queue
>>> + * @addr: Base address of the queue memory in the guest physical address space
>>> + * @length: Length of the queue memory in the guest physical address space
>>> + *
>>> + * Allocate a virtual queue object for a vIOMMU-specific HW-acceleration feature
>>> + * that allows HW to access a guest queue memory described by @addr and @length.
>>> + * It's suggested for VMM to back the queue memory using a single huge page with
>>> + * a proper alignment for its contiguity in the host physical address space. The
>>> + * call will fail, if the queue memory is not contiguous in the physical address
>>> + * space. Upon success, its underlying physical pages will be pinned to prevent
>>> + * VMM from unmapping them in the IOAS, until the virtual queue gets destroyed.
>>> + *
>>> + * A vIOMMU can allocate multiple queues, but it must use a different @index to
>>> + * separate each allocation, e.g. VCMDQ0, VCMDQ1, ...
>>
>> This will handle multiple queues. But AMD vIOMMU needs to comunicate certain
>> control bit setting which is not related to buffers like "Completion wait
>> interrupt".
>>
>> How do we handle that? extend iommu_queue_alloc() or have different interface?
> 
> Do you need a modify queue operation?

We have two types of operations. One that impacts the queue, other set of bits
which doesn't operate on qeueue.

ex: Event log buffer
  - We configure "MMIO Offset 0010h Event Log Base Address Register" with Base
address and size

  -  MMIO Offset 0018h IOMMU Control Register
     EventLogEn: Event log enable
       * When guest sets this bit, qemu will trap and will send queue_alloc
       * When guest disables this bit, qemu will trap and send vqueue_destroy

     This part is fine.

     EventIntEn: Event log interrupt enable
       * When guest sets this bit, qemu will trap
       * this needs to be communicated to Host so that we can program VF Control
BAR and enable the interrupt

  - There is other bit "Completion wait interrupt enable"
    This doesn't related to any buffer. Instead if we configure this for
completion wait command it will generate interrupt.

I am asking how do we handle above two steps? Should it be part of queue IOCTL
or may be some other IOCTL which just passes these info to HW driver?

-Vasant


