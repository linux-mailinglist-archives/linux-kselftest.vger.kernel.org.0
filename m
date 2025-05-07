Return-Path: <linux-kselftest+bounces-32563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A7AADD22
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A8B7A0353
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 11:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E682233144;
	Wed,  7 May 2025 11:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HLIoBrMV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A80A231C9F;
	Wed,  7 May 2025 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746616726; cv=fail; b=keh0BDqm07HvOOfBDPiGMgSjsTN//4rwzZ/49OC0b40QahZkF4R4/5+MW2+i9l8NGDVru7kOe7ktplzkYhh9x5K0zYgsGl6FoMuUsVqlEOQyQ/meCNkjdzq+fDUx7vmAKaAPRnp4pfFAF1w122MJZHZqaoLktIAVkxn/pOY+UWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746616726; c=relaxed/simple;
	bh=EmMsSLFeBdLB8uj4ARuf7VaxHd+mFzEfVMfJRAasrz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mD6Dd7dbeF8pEA8aJV1kojHC0H/q9VZn5I0gh0pF3X7eVOD/oSyzB7Nwn7Tz6bQgeggcjIkqf+NVTNM/JUooYDtbxtTh6KBp3C5KJ6aq8F2C7gH5z002IkSbzSvPxQVlpnYe/HpH/7kYUbrYBHlMVliAq3qUqE5pIZmIKGhbVOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HLIoBrMV; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U41eYQzZhRXL6OLIn5jNeRitlLpAI/1aOaTx5I6UAogGPYQzuMkDvlU1NnlGC1GYnUIm8n/ZPhutGmIxaxoCe84OyB3uVjOVWsexor+N4Rr6krKLMnmUs90Ct/bm6YU8JZd6x7SHRk9I1EIt2Ht5hyQNBgPoN6u3S/IVp33b1TJ6zIYEv8cTJ+ZM4d+N5rMPGViB8MiabpoAYOgT3mU+r8VqmfWFlbNzFfx8JHII4t0R7kgU3mgJMEbAi09hu4O18HTP93PwZIF43GC3IGmPivDRTGTdopNI9aaO/QaftDPiyw3IAJRwVhMXiTHPcd9AfZJj6CAeACsOeByiBSaX+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRWt4qGqm3LOo4wTLpi4IEFMbt2Ib75vT+K9Ct8cZeE=;
 b=WkCejsy9e+vsCOMzJg49ZPEQOQ5gMnEPUz9YDZXuto9Gg+pKfKt4/tYEG+/NvzPQ0SF2YO0dzrtOh9yfJayAl3qlN4rrdSPS9Dn8Z5hEfcELRNRZ/kwopFanv7t443evzQaNQpboqIKJvNJAxkwPDw8UOB+EYm/B8phlHnVaKOW69LGATIYPvV84EAAlph2vYUcjr+AfjOpCNib/k7e5Ob4mvaGtIYxkrGW5cUS0qeQEU7a0gTu8MWsrl5xOIE6NyFa3gb4hLy4bRvT8hBYqenVXl9y4W3sfS3FeKvL1Df281cbKVMIhgRi8BJd86OOsE2W+mbmjaTMCk/5HMlNnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRWt4qGqm3LOo4wTLpi4IEFMbt2Ib75vT+K9Ct8cZeE=;
 b=HLIoBrMVUCLjL30VAXWP4X88IK63KuT5HcljskOacEc7UlIQwGD28qSAv1P+9+NZNyMpVoFDJ0AglTdAAuS0kWM9GPGrCMIoN7UWnyJ2V5VmDT813jJOW4jba6eAIiPqN2hC0/PHoc7hJIBb/flT/F7ILNSlMJ3xebs9jqQohmc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SN7PR12MB6790.namprd12.prod.outlook.com (2603:10b6:806:269::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 11:18:38 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 11:18:38 +0000
Message-ID: <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
Date: Wed, 7 May 2025 21:18:29 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, yi.l.liu@intel.com
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
 <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia> <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com> <20250506125847.GA2260709@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250506125847.GA2260709@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5PR01CA0086.ausprd01.prod.outlook.com
 (2603:10c6:10:1f5::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SN7PR12MB6790:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ec3a0d-f2da-4ee6-8d73-08dd8d58e9ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WWFRTmpmMGhLb3NtdW82a3NOaC9uUHVhRVh4ZXNlM1BiNUpmMDd3cFd2SVZ5?=
 =?utf-8?B?UCs5cmxDSHU0UW5lNmhjOW9sTWl6WE9uSVFKcVIyelFGSlVOV1hxa0xlMFlZ?=
 =?utf-8?B?VnExNjNpUmNWdzJ6MWx4eGNmOHlaaVhsa3F3cHg5dmk5ZXg1UTdkS2FPRFoy?=
 =?utf-8?B?VnExK2Y2N0d1OWpOQ3BDbmJPM2xzOG1OdW1OczQ4Qzl6akd0V3V0c0RUSTNQ?=
 =?utf-8?B?V2RQWXJOTjJZVnhSdWRNNTNEYm5FYzlHWTJXRURibXZpTVgwQUxTck9NQVJx?=
 =?utf-8?B?cXlLbWJoalR6bXVQTFJWSk04eWJFa2FwK29tWDE4V0dzVlpNL2JzVlVmSTdp?=
 =?utf-8?B?V3ZFMzVaQS8xTXoybXIxMnFTdXNFS0FXZzkrTDRKeUYzSTVHMnN1YjVXdFI5?=
 =?utf-8?B?TnJTT1JUY0t2cy9zSkg2ZTFrcU8vamN2eDJhRWpjUnQzcGVyWVpEc2t5OXFr?=
 =?utf-8?B?MHRuRE1rMXNhNzlxVWlLRFVwL0pSTDBXUGx3ZkV0VTZxNm5HRWpxS1FiVEZU?=
 =?utf-8?B?WGVia2luZTVPTXdFNVBtNzMvMGx0blNKbzlZbkFiTGdRc2t0MG5NRGNwM21x?=
 =?utf-8?B?bFowaCtPVnZCU3dOank3VEZrLzRKbDliR1RXc0NHbnJveW9kZ3h3TTZvYzht?=
 =?utf-8?B?anlyckI2UkJJUHRZMG44SHJCcGN2QmgrR1N2VGhFU2x4eW03bGlwMmlyVVNp?=
 =?utf-8?B?T0xKdFY2L3I0cHVzY0ZPanhMWkxwV0tnUCtVZWdFZndCbDFTUk5IanNIMlUw?=
 =?utf-8?B?d09UcXRBWUU2RStkTStJTldLM1dreDVwNUhZQWZTV3NWYVdsVUcvZ1N2VW1O?=
 =?utf-8?B?Ty95VjBYQ2ZhSnBVRVlVdExZNUs5UW1NUTB5c0xjVTBmQURkVktNU2RtcDBD?=
 =?utf-8?B?NTlMaml6V2VZV3JIMmFmM1FNYjAybVkrL0U4bDA2OXJDNjhIbTQ1Z3YyeGN0?=
 =?utf-8?B?WFo0alFGV3J3ZE5DaG1ncjVYTjVFcjA5TGRLSXNXZklaTk1IZ1JIdy9KL0lD?=
 =?utf-8?B?OTFkeEJJdTNPZ3RabENRNGRrZHNSTW0yUndUKzUwaFlVdm5VbldLVnpMS2c3?=
 =?utf-8?B?UEhUNkM0ZHFTSy80RFl2TjJLenN3TndiM0NOSVBjbm1aeTNrc2xQR2l3UVJw?=
 =?utf-8?B?cHovUWxhaEJZRDE1bWg1djRGU1pQazQraWN6MDNNUGV3dTRsNXdtejVqLzZB?=
 =?utf-8?B?cDh1NEEvbDlpTDlsNGQrY3hjU1JxZ09pWnduTWZ2WlJXTlRmNU5EMUZzMmJo?=
 =?utf-8?B?Z3VlTnozK3RqcHREQXNTY1VUUVlxR0o3cmg1a3VuSU0xS0srb0F3cHJhL1RT?=
 =?utf-8?B?VlZtOWlmQjlLTnlPNzdLWXNQQW1KSDBXZ0NKZFp5QjV2YTJjNVBxRCtRYVZC?=
 =?utf-8?B?TkF3M3dmOC9hUktqb1hySHRMbmt3Y3Zwc1g5U092YVIzWWdtbFcydkVzVjAr?=
 =?utf-8?B?UGZTbVNxNEd6Q0lGek9EVVNHZmprbXZJRTl4YzVEaS9qaVlhV01DRC9kY1Zm?=
 =?utf-8?B?c0V0Vy90Z1J1Z3hCblp2Y0Nvc1lCdVN0TUdTYkVRcDhoU01zT0hjMXJvTlNh?=
 =?utf-8?B?a1l5QXA5KzRaemVyaVlYcUM4aEhtWnJMSXRCWXJwUmZ4MlVaU2FRcDBEWjhK?=
 =?utf-8?B?Q0VVUE1OcVpCMHNHa0JjWHlCd055d0ZOeHlIaXpkbHNrY1AwWlcrM213Tm5a?=
 =?utf-8?B?dFc0VHh5L3M2eU5ManZJWGZvblp2NFZ2bXo1a2t0S0VFYng2TnhqaDRqb2s1?=
 =?utf-8?B?a3dKMUhhT3ZCWmJvaEU2K0NyOHJXaDlBS2pld2crRmdXRzdjcjc1cHIrMUdu?=
 =?utf-8?B?TFZJSVFjTFJTNlFyZGFaUnFJeFJ5MnloaDBXVUFIcVpaeHc1UVQ3QmdzTjd6?=
 =?utf-8?B?TjdBZHBlNWt0VlYyVDN0cnR5UDlzajNobksvM3dZSzhvZ25Gb0lXd2FieWRP?=
 =?utf-8?Q?KsYeEqPeATs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUk3NXp2U0laZkNodkhZbktja0h2akZBdUMyRXlRbEg4ZUZaZ2JyUlN3R2pQ?=
 =?utf-8?B?c2o4YVpMZXRkNzg2dEk4WGZhVkYvM0ljQktoVDBHSXlDSExSZEJpT05DdkVJ?=
 =?utf-8?B?c3MrbTNTRnZ4T3YrbkRBd3EwZk41OTE3VUFxbXZ0WDBnNzFROW85cldKMjVu?=
 =?utf-8?B?MkllcDZjcFNkNTlMV0kwMDJvLzNNYVBjQjF2NU8wS2o2UmQzeG1JWFB5ejZk?=
 =?utf-8?B?UU40cXk1anFob2g2S0t1Zmt2WUZMeGkvVDd2UTlrcFhYcGV4VlRoMXVaRXJY?=
 =?utf-8?B?NFlySUJvdlEyUDhONUtYOTk5WXNXZytWL3BZNjUrTk56OXhsem1qNklRU09H?=
 =?utf-8?B?R2dNUGUxY2xDNmtSbnIxNXJDTysraklEMjl5NVpqZmtENVZiMEJ4dStEbzBt?=
 =?utf-8?B?Z2hvYnNRMjRCVEgzTTJYYWxNUWpTUlZVRlY3LytYVUl3dXlCQmdxTlk3SW9Z?=
 =?utf-8?B?ZlhXdnc0Zk02Zm5wY0VVUXhLbjhWN1ZieHNTZXZyVmFvcSs4QlZFaDdaMWEz?=
 =?utf-8?B?ZC85dzZXMk5yQVkrZ2ZNaTkvN1B2dG5aSDUyOXh2TGdtQSt5Q3FiaFBsYStB?=
 =?utf-8?B?elByWlEyTW5zcDFCWFdWU0kwUWpLaVhJNmNLR1RDUnFzUkh3cFBBMlR2ZndK?=
 =?utf-8?B?RWtITXpKdlRQRkNJMER0TWxOUlpLeGZkS3lsRWV1ZGRXK2NvSXBjTHFnREdK?=
 =?utf-8?B?U2dOTmo3MkJXZlczeWk4U3JrdzUxdFUzTi96Z0JHMmZiaWNvTWh1L212ZTBm?=
 =?utf-8?B?TSttdWpUZWNSYmFteWxPREkyd1UxQW5ESjU2MnRuT0NRZ0FqRlRqM2JqbzJr?=
 =?utf-8?B?YzRiR2QwVy92NUtGb2JDS2FDNStUSExTTFI5VHhQRFRrNy9oaWxZUTIrcGNq?=
 =?utf-8?B?NSsxbHlMTE1vNDNTaTRpZGJnb1ZuMTlScVR0UnFNMjM3T2ROcC9tY1llVS9B?=
 =?utf-8?B?M0l1UTdTTDRtbUhIZEgxOXY2N3VVWDZmSFkvMDNVYWczN09FMm1iSU5LbjNv?=
 =?utf-8?B?VTNSYWhaRVFvdVRJQ2xFQmtNV3daQ3ltWTdxdlFnY29YSWg0KzhTVWVnelA3?=
 =?utf-8?B?SUJ2dC9uR3JBam04VU16WTBtaGorVDkzWmRnOXlKVGdDRFJmTlNybWJxL0Nu?=
 =?utf-8?B?YUxZTmN5QVlTb2lMY2JsbHVHK3ZmdVVlMGxpYzZoeVlrMFFicTl5cXgvSHpS?=
 =?utf-8?B?TkFmSUhDNERUU21oeDBvc3B0RC9XVjd6OWtRWEtrK0djY09JTlQvd1lyNzEz?=
 =?utf-8?B?czhwdVYybVBxOGcxdTdMa1BXdHdzZ1BYZ1ZvSEp6aW8zTjB2QnI1ajBuNmlN?=
 =?utf-8?B?N2VmeUU3M0syQUNuczFwd05ETGQza21MZ2lsQnEzaDgxZGFuRDlFQml0elJW?=
 =?utf-8?B?T2ozTmFpUmV2U2EwM0N6T21xZlBCYk5aWTBMSGJDNkt2ODhVRVRCc3QvaEl1?=
 =?utf-8?B?ckhpV2IrajdyUnNnNEp0K0JuZ3o3cmdXT3licGMzejRBeUJxWWZDVzlRTmha?=
 =?utf-8?B?eG1MaVVSbEQxVUwvZngrS0RqMWZzTTFZbDJGK05ReHNDNm1zSmthcm01OVBw?=
 =?utf-8?B?VjBSeEVJd3RpcHdYcmxpNkpJbkhnMmtpTUhuN3g4L1haVmVYcXBPb3UrWjA5?=
 =?utf-8?B?TlFpOXVLc2Z2OXVidk1abnljanU0UTduU2dHQy8zTHNnQ281TnBXWitHb3g4?=
 =?utf-8?B?RnhMQnBzUStrVU83aGFKU0xFUjJZNjExeld6R0MvUkp1VlpEUG1qNWJjVG1L?=
 =?utf-8?B?eUdONHVIR2lyTldwTjVFb1lNVStRK2p0SHZ1Rmp3MktYSlhvcFd1UnNiOCtE?=
 =?utf-8?B?elhHOVZiRklNVlNLRWl5c0RROWdjTVR4OWVxTm85N1BZVmtuYk1mSVExQlY4?=
 =?utf-8?B?UWVTSVY5RVhXekpsREZ6djZvZC9sUUQrOGEvbTJ5Z2xhaFI1MXFYUkNJeTN5?=
 =?utf-8?B?ODFWWnk5YitySHg0bDBYb1Nia2dsK2JpTi9GSlRUYXMwenBWQ0VvbjYvUUZ2?=
 =?utf-8?B?OHRSTjBlYnNxNXpHWjdQRFhzZDI3SFVUUEowbGJzZmVBNFJ1RXZLUXZsWWk4?=
 =?utf-8?B?VjJQQ2pHY2toWUg3MmUyWjNhclZ6eUFTUDVrY2JFTytHRTNHMlEvbmRTY2p6?=
 =?utf-8?Q?VTFqMNA/AdAw3/8xwMnGAUPoe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ec3a0d-f2da-4ee6-8d73-08dd8d58e9ed
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:18:37.9810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3D1DAxII26oQwNtltkCuC1odgsu34UbRuZuirFIDWf6MAbjLPb2h+AQJc5oLDf/bCYe4MNycHp9P8zTc5SZ7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6790



On 6/5/25 22:58, Jason Gunthorpe wrote:
> On Mon, May 05, 2025 at 07:53:44PM -0700, Nicolin Chen wrote:
>> On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
>>> On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
>>>
>>>>> ... and I just hit a problem with it - this is basically guest BDFn
>>>>> and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM
>>>>> but does not when I pass through via the QEMU cmdline - bus numbers
>>>>> are not assigned yet. So I have to postpone the vdevice allocation
>>>>> till run time, did I miss something here? Thanks,
>>>>
>>>> I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
>>>> allocated at runtime as well because the BDF number isn't ready
>>>> at the boot time.
>>>
>>> Oh that's ugly then.. So you'll need to add some kind of 'modify
>>> sid/bdf' operation I think.
>>
>> But the initial vDEVICE would be still unusable. Its BDF number is
>> literally 0 in my case. It can't be used for SID-based invalidation
>> nor the reverse vSID lookup for fault injection..
> 
> That's fine, that is actually what it is in the vPCI topology. Until
> the bus numbers are assigned at least.
> 
> So you'd have SID conflicts in the kernel, just pick the first one or
> something until it gets sorted out.
> 
>>> The bus numbers can be reassigned at any time on the fly by the guest
>>> by reprogramming the PCI hierarchy.
>>
>> Yes. If we take some aggressive use case into account, where its
>> BDF number could change multiple times, I think it's natural for
>> VMM to simply destroy the previous vDEVICE and allocate a new one
>> with a new BDF number, right?
> 
> We should not destroy the vdevice for something like that. In a CC
> case that would unplug it from the VM which is not right.

vdevice is not directly seen by the guest, is not it? The guest will see, for example, an "AMD IOMMU" and assume there is device table for all 64K devices, and so on, it is QEMU which will be reallocating vdevice in the host's IOMMUFD. Did I miss something here? Thanks,



-- 
Alexey


