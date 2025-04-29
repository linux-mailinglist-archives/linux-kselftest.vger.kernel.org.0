Return-Path: <linux-kselftest+bounces-31855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB5AA01DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 363F37A4D45
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Apr 2025 05:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13E4270EAD;
	Tue, 29 Apr 2025 05:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jMv9MsxE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2FC254B0F;
	Tue, 29 Apr 2025 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745904866; cv=fail; b=ZlLty341Ml6Cr6K2Uyege7QFtrX7GZ0y+Wzjy6OSby0zj2NcZQXeUpbeQXo2WGiMeCIQrpmwcnbxTZebNSK0Ph2yYzbg6E0xIDSDqWk82aiU2aFT8K/1uuKRmuZXmWprSj1v7sqDtOITgMWR8hN4Fu9UT5y3Vl5tg02nB4b1BWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745904866; c=relaxed/simple;
	bh=aEtoTwIPBYTIvC+J0uKQCKz/3JQgwBO1xPP++wqoTNQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dOjPCVHhBNQXsC4pUyl867LiZkaX4FhFRXwjfVi8FODRhO3b9xqhBuX3zakP7udFn+z7cq/jnkQ/oGIJrggKV8cfVeS0X9RJuRjXivybt1GP+E21Ny3Z2NTssDepekCW6Nso8LX9EvbH0uEvq7ygliOaGw0TB7mOmlc9vevRCk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jMv9MsxE; arc=fail smtp.client-ip=40.107.223.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmpGirKq/vfRSPjSIL68uqB664sO6SISNm5kie8dxif7Hf0LnWeZFFf3Ri4C3BOoje6WHfNStflFTPEXwuVrzUBq00RuF+H8EF4v+v4W9eDxhs2l9DU4TbDywELT+G6DUEt0A1EmVUtUZjAIFfbb8q//0YgzVK4rakhZWQ4qUktauRqKArGubBu5b2j2xlX1tNxTMuigZQYfGlqcs1ia74VRl50zk4diQaPO9tQFrR35mG7L3X/aX2VfXnZmAlosuVKu0sqNly2717B2XiiBx7/O0775xuSFyCThK5tFJNMJpb1+rvZ2X3UU//78lmcUpH66Utr4YDx83ngFS8tfGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcXeFCJONENngrk/2rs7ObHW+W/WZF7lIqyvwOCXLRU=;
 b=rAdDfgd3b7P3s+WTudud2WFzuKx3EYJP3XMgueLqfTLM/cAg6obdnaPKxUixmJmRcMS+QZVFhWajpGpRBfVlBKKllxnMPvHtulJ7FI8xf2JCJS8HBI+WfqrCypkVvavrdOtFUsU4OYb2kkjjwLBdFt1o5YF/G1Vqr4FaoL+NZ08Qq7FwZa2kMkoYZDtprswLHRDy+hiajfUuiTznfvm2JA28OpuVY1AakUm3Hp8Xjp6SixGzvRIAj1kvIcW/r2lp9oL4lK9i9PtO1yUt3CNRQGsBSHuU1GR7gjd95LMQxTZw9iKZEZafh/BLKA3nPDilk/tbGtU017x0wC8DcGGJ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcXeFCJONENngrk/2rs7ObHW+W/WZF7lIqyvwOCXLRU=;
 b=jMv9MsxEHzQtBcxMUMHIUHy3GMt6eBY/1h1gob/+VyZFCvCziAHQBibJJrqMUYyVGNp8M+e4ZiX5PQ0ELILqDyVmAgDRKaJu27chHSjc1JEsUAV2sQv4PqpdPn/UdUz8WZnB2JcqXNqAEPl4RKV5cRO2UpfRa7NvOSjTE6smZkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB6937.namprd12.prod.outlook.com (2603:10b6:510:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Tue, 29 Apr
 2025 05:34:19 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Tue, 29 Apr 2025
 05:34:19 +0000
Message-ID: <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
Date: Tue, 29 Apr 2025 11:04:06 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aA/exylmYJhIhEVL@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0086.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:23::31) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB6937:EE_
X-MS-Office365-Filtering-Correlation-Id: c4dd6f30-de15-4bdf-3ac2-08dd86df7d00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2ViODhwbEk5ZnVtZHNlMkhUQkpGMDBlUlFwcFp1OXFsRGdHL295aW9pTVBX?=
 =?utf-8?B?RGFtK3VKaGNKakx2WTkrbkorM0NBVlRla0IxQUFScDgzRkZxdFhJM0xNaW5I?=
 =?utf-8?B?MHRPVzFESXhqV0NaS0g1Ym9kLzJZczRBS29HMFBqRmJQTVFHMkVZVFRoM0tY?=
 =?utf-8?B?Z3RpdHIya255Vm9SMTJmRVRoOVpEdVRxbTh1am9Nc2oyRGptQWhVTmtOMU5D?=
 =?utf-8?B?VEsva3dqek9YVmZIMFZaNVBnUmM2RytvNG5hSHE0ZWt5Yk1CdGY4d0w4RFRk?=
 =?utf-8?B?MUgxeXhHLzNKUXV3K3JaVmMvYUE0MU5tTGJGSFFTUmVKZnhhMmFVQkdyZ2Mv?=
 =?utf-8?B?RGdHSCt5dGtaTFhVNzBDN1ZRQkt5UTU4MnVjVXMyN1I3T2wxZHZ4cUZnOHdo?=
 =?utf-8?B?TjdIYnJhcnVXTlp4blJHaUhHRVRkcEk4emgyb24zaWlGSGxWZmpRcmFXVkxQ?=
 =?utf-8?B?UlN3TjNWcmlpSEtFQW9kQ01ZOERMbmNpaUJJOVNsdVJPbllBOVNEdXJEVHpN?=
 =?utf-8?B?RXBubkQ1U3NJN1NDUG80RTczWHAvSXRoOVdMQ3JpT1VhamxaYzdiZG56M2N4?=
 =?utf-8?B?MFN6Q0g2c3B4djhOaEh3YW5xTHNVU21Pa1B3UUloSHBmVFk0UTVvYktHVDY0?=
 =?utf-8?B?d0c4TWNKYjNjam56VjdiVUFTVkhoendUTldHRG9YQzgyMWI0anI1ZGF0cDRO?=
 =?utf-8?B?SWU2enpoSGtOSmUwdW9Kc0NnckVMeDhreHBITTNtcjRrU1d1YkM5VEZoNUMx?=
 =?utf-8?B?UDBUWlpJMU90RVQ0RnhvUWpKUEJMajk1QXFXck5GMUlkRjNUbzM5cGxNdndE?=
 =?utf-8?B?d3NRQ2x6aTUyWGd2RU52SU1rQU82NjNLc0xreDZLQ0dlOVZwa3F5QVBxdWE5?=
 =?utf-8?B?WWp1MmNnZW5wTWRJL2lzWm5ISGZqSDhLZGdBbStrN0ZoWnA1U2NlZjJ2YkZw?=
 =?utf-8?B?MUpEaTlXcnhpUzZOMVZLU0lURksvSWsrZGZ3Vnp0M2tkalVaN2xoZW83V3dk?=
 =?utf-8?B?bVIveFRPZ1dKLy9GMHMzOVQrdVFUYzBZTjhUemViRld1Yk41QjJxYUxTNi9K?=
 =?utf-8?B?aDhjalk0Sit4NmNRdFR2NnlCSHE0WjNhSWtDOTVsODU0ejFPUFg2S0dreFUz?=
 =?utf-8?B?dW5IaVRNTWVucVRaTFZiWVRKdUxRSHREajA5NEdJazRLTEErMGxBWW44amJn?=
 =?utf-8?B?QTBaYk1kSThnemoycWtWdkhheXJ1UUJxZkk5RTZ6dVpWcmhOazdTL0NWQkVI?=
 =?utf-8?B?b2xFdklwMUpsRVhVUTMwZlVzTGdWUEhzZUdkWFlKdmlSU2N3M2wxenlsZzE5?=
 =?utf-8?B?MitiaUQ3VjRCR1ZOQ2REUzZkYmJyVDJWdXpxdzNBdHZTSnE5bDF5enhkS0dO?=
 =?utf-8?B?ZkYwc2JPbXBsSHJqeUVwbUowa0ZxWlUvaXNqVkFjcUpHaDBWc1NocFhCMUZF?=
 =?utf-8?B?dGRObFJaR0JKNkxoT29USUh0QUh6bGxEZFUvY0dsRGxKRmxFd2RQaGVHSVlo?=
 =?utf-8?B?aU40U0w2ZTJUa3lqL0Y5Q2NRN3hDNmRIM2hVcGN6K0haaXdrT2VLTHRKV0Z6?=
 =?utf-8?B?Tm9wZHQ1YVlTYXZMQTlvTjlVdmgwMDdFOXl6d0tOZExrdUdQUVd0MlhtL2xK?=
 =?utf-8?B?Q0hLWEdBZ2ZRcDBMVENrb3ZKZkwzUmxlbGRvTEZxQXBZaWRKVThHamlGK1Vw?=
 =?utf-8?B?b0dQSHQ0aDBFdkdTTEtjeVo2MWJCMUhsTWU4clY2NFR5Q21kU0lHRXF3T2U0?=
 =?utf-8?B?cDBvQnMzN3JFc1lPLy9JVlVmdHZXZUdhZ3lDTXppZjgrSEt4VkF3YUdldVJz?=
 =?utf-8?B?by90RFRrNis5MkZXVGpCc0dLdHZpNTNzd2NtNHQ3TGgvUkFRZGU3UHVsY0hz?=
 =?utf-8?B?ckN6dHFIbDdwa2VnWTFZUVZLR3ZmRmZCTzFDN3QvTm5zaEkxSTc1dnBOdWxi?=
 =?utf-8?Q?mYXjhTri7Xw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d09rMjFLc0poWnh2aE8zTGZZOG40SVJONmpXQklBbHVHVFRjTXRxeFFXWGdB?=
 =?utf-8?B?V3ZyT0puQmFRc2MrNGlPWDZGWjdTdXdOM3YxUm1zMms3RFp1a1lvRnpJaTBN?=
 =?utf-8?B?YnI1eHBXcXlDK1hIeE1Yak9qVG5rc3c4R0IxRlVoa1VpeitrbHlEVnhnNlln?=
 =?utf-8?B?REY2M2pvc3hidUNsZWJySlU4a2ZIRStRWUs1L3AxazIyek9rdDd0eWNTYkh0?=
 =?utf-8?B?YktSNHlTRUF3SEk2SHNnUkhPblBlZVJ0bzZJZG1UL3cwalpPU1hLWDB2Qjhq?=
 =?utf-8?B?b2VUTDNtUGNWN2hBc3ZqSXgwU3Z6NWRDSTlwclovdVp2MkJocTMxUG4wSzg1?=
 =?utf-8?B?VDhadUdyVG9ETGNYWmh2N0pCSWNpQnliNS91VXp4QWdLdFRRaEt6WjdHbTc2?=
 =?utf-8?B?bW5iM2MwU1A2SlNPbUdkQVRDcDNJY0NHUW56blJQOG5LdEM0RnNtb29YWWcv?=
 =?utf-8?B?THJnaG1NZEFJWnFPaTM4R3U5U3F1Z1h4T2hJMEFldlpMWWg2L1daQmtpVm9q?=
 =?utf-8?B?TytZYmwyc2lDRk10OHkyQnVuQXRiT0FDdlFRN2dRK1ZYODBMZTAvVDgvbXZI?=
 =?utf-8?B?YmxjQmdOc2ZxdzkyV0tLbEZrZHdmbTk1RUs4eXU5d3JsTUgvZldyWlFIbFdQ?=
 =?utf-8?B?UDZVbjhlREtkS3dqOVhHZGQwZ3JMMlNtM08xZUtxTlRRcmlrOUVISG4rS1dl?=
 =?utf-8?B?MzNUeXlVYk5xYVF4QjJNT1ZvSTlteHVLR3Q4b0VBdENWUGhFemIxYWFlTTJ3?=
 =?utf-8?B?WXk5MXpKQWpBYzgzWnZEWXpmODlTMVkycjk3ZEMya3ZBbGRmcG1WWUJkK1ds?=
 =?utf-8?B?Vk1lTlVTallaOEx4OE5uNS9kV0FMT1JpUTBweVRvNUMyMFJXRTdhZWVTRGpx?=
 =?utf-8?B?YnBqVzg4SXVOYXNSRklXS3ZoditmYXcxbnhOOHBtRWdjS1ZhbHVBT3htbTNa?=
 =?utf-8?B?cjEyV29tSjQ2UHgxdENuMlBiM3l4TVhMWU1uV0RKekFBV1pQYkYzUjZ4WlFq?=
 =?utf-8?B?b252TGtoWjE2dTN3NFduRlM5Zm14TTV2bFZEaDJUOVNCNGc2TTg5dlhoZzBm?=
 =?utf-8?B?Q0xsRWI2OU9ESjMrRndVbnl1a1ZXUVNYSm9Bd2JKbFBGeDBLUzBkeFFjOWhZ?=
 =?utf-8?B?VmMyRDJkcmowaVdmdlUrRmRWZzVucWpDS0lWMUVWL1A0Mjl0dHM5aDdJaTdy?=
 =?utf-8?B?Q09VVzdXM2FoOS9NWGgvTjBtb3pYKzdMU1B0OVp0N3NjYm5MV3NaajFuWnlj?=
 =?utf-8?B?QVJaTXNHWStLRVVKTFg1RkF3bUpPN1ZTYkphdzNkRVpjYzRMbU5xbFplUUZI?=
 =?utf-8?B?UUFiY3AvTkY2UU8yZGRwdTU0Y1kzQUVpY1p1dlhQSktpZmNXbUxVZHdHNUh6?=
 =?utf-8?B?R3pnNE9FY3BKVFNIVGEwUzV3Q2h6QStJSEVySjB6UjFScE1oZHp0KzR3QTNK?=
 =?utf-8?B?dUh2SDlvbGtFT2M2ODdJMGZSVWwwS0RVeVJCdEpyT2lVeFZLTnBpTnFIVm91?=
 =?utf-8?B?V2xOVFQxUkVQWDd2bkxGS2dwZnF3NWlaMXFjcEE4V2tLK3g3VjZZWVdYMGtH?=
 =?utf-8?B?cjMrSm42dUgrUWZ2dTIxQnRIaWc2d2NoOW02VjZSRVZGMTFwLzVLNFEvU1Ir?=
 =?utf-8?B?OVdUUFJWZllvR2wzRWE2THIwak1KUUc0bU9IbThQTTZoM1IzTDhGQVllUnVv?=
 =?utf-8?B?WlhmczFkR05LMnZJUlpRYm05MnNvUmRiUnR1ZXhSckZ6ckJJQksvb3lzc1R5?=
 =?utf-8?B?ZGpzV0g4RTcrbndRS2FIenRXUkU2TXNHZC9zQXhQUTEwM1FobmRIOHh3ZTRH?=
 =?utf-8?B?d2FyMmF6WDF4V1BIRkk0NjdqWDNjV1dSUnJ4Y0dOekhIRHMxQkF0YUlFQ3pt?=
 =?utf-8?B?L1M0VFJreWVkZUFyK2dPcmdnSHpsOWZUcWNuZjdVS29xVU5SY1VtZjZuNlJZ?=
 =?utf-8?B?RmhwN2U5b2Q2ekIwZGxjeEJ0QVVoYktPUGYxQ01BRmI5eVlwaC8zOWRtdjB5?=
 =?utf-8?B?M3Z1ZVpvWWtpWUxuckFoUHd0T1BVRFJlQVdjR0tQN0VMWUZWRFBxZk93aXI0?=
 =?utf-8?B?Wi9TNmxPa2tSMjhUVTRSZzhOOVJseXlTZ0w1QjZkL0s3WUZ3eFRCMWtqOXI4?=
 =?utf-8?Q?Ms+LqQP7r4ayWaoOZlTqBkfQZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dd6f30-de15-4bdf-3ac2-08dd86df7d00
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 05:34:19.3773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfHOmLUdbuCjjweFfAKOphiMfrIwebVG/JyiAZgRpwaFz/toca7OvHmps8TMxFMqJiIQg4/9yxczmYnhZPisPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6937

Hi Nicolin,


On 4/29/2025 1:32 AM, Nicolin Chen wrote:
> On Mon, Apr 28, 2025 at 05:42:27PM +0530, Vasant Hegde wrote:
>>> +/**
>>> + * struct iommu_vcmdq_alloc - ioctl(IOMMU_VCMDQ_ALLOC)
>>> + * @size: sizeof(struct iommu_vcmdq_alloc)
>>> + * @flags: Must be 0
>>> + * @viommu_id: Virtual IOMMU ID to associate the virtual command queue with
>>> + * @type: One of enum iommu_vcmdq_type
>>> + * @index: The logical index to the virtual command queue per virtual IOMMU, for
>>> + *         a multi-queue model
>>> + * @out_vcmdq_id: The ID of the new virtual command queue
>>> + * @addr: Base address of the queue memory in the guest physical address space
>>
>> Sorry. I didn't get this part.
>>
>> So here `addr` is command queue base address like
>>  - NVIDIA's virtual command queue
>>  - AMD vIOMMU's command buffer
>>
>> .. and it will allocate vcmdq for each buffer type. Is that the correct
>> understanding?
> 
> Yes. For AMD "vIOMMU", it needs a new type for iommufd vIOMMU:
> 	IOMMU_VIOMMU_TYPE_AMD_VIOMMU,
> 
> For AMD "vIOMMU" command buffer, it needs a new type too:
> 	IOMMU_VCMDQ_TYPE_AMD_VIOMMU, /* Kdoc it to be Command Buffer */

You are suggesting we define one type for AMD and use it for all buffers like
command buffer, event log, PPR buffet etc? and use iommu_vcmdq_alloc->index to
identity different buffer type?


> 
> Then, use IOMMUFD_CMD_VIOMMU_ALLOC ioctl to allocate an vIOMMU
> obj, and use IOMMUFD_CMD_VCMDQ_ALLOC ioctl(s) to allocate vCMDQ
> objs.
> 
>> In case of AMD vIOMMU, buffer base address is programmed in different register
>> (ex: MMIO Offset 0008h Command Buffer Base Address Register) and buffer
>> enable/disable is done via different register (ex: MMIO Offset 0018h IOMMU
>> Control Register). And we need to communicate both to hypervisor. Not sure this
>> API can accommodate this as addr seems to be mandatory.
> 
> NVIDIA's CMDQV has all three of them too. What we do here is to
> let VMM trap the buffer base address (in guest physical address
> space) and forward it to kernel using this @addr. Then, kernel
> will translate this @addr to host physical address space, and
> program the physical address and size to the register.

Right. For AMD IOMMU 1st 4K of MMIO space (which contains all buffer base
address registers) is not accelerated. So we can trap it and pass GPA, size to
iommufd.

.. but programming base register (like Command buffer base addr) is not
sufficient. We have to enable the command buffer by setting particular bit in
Control register.  So at high level flow is something like below (@Suravee,
correct me if I missed something here).

From guest side :
  Write command bufer base addr, size (MMIO offset 0x08)
  Set MMIO Offset 0x18[bit 12]
    Also we need to program few other bits that are not related to these buffers
    like `Completion wait interrupt enable`.


From VMM side:
  We need to trap both register and pass it to iommufd

From Host AMD IOMMU driver:
  We have to program VFCntlMMIO Offset {16’b[GuestID], 6’b10_0000}


We need a way to pass Control register details to iommufd -> AMD driver so that
we can program the VF control MMIO register.

Since iommu_vcmdq_alloc structure doesn't have user_data, how do we communicate
control register?




> 
>> [1]
>> https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/specifications/48882_IOMMU.pdf
> 
> Thanks for the doc. So, AMD has:
> 
> Command Buffer Base Address Register [MMIO Offset 0008h]
> "used to program the system physical base address and size of the
>  command buffer. The command buffer occupies contiguous physical
>  memory starting at the programmed base address, up to the
>  programmed size."
> Command Buffer Head Pointer Register [MMIO Offset 2000h]
> Command Buffer Tail Pointer Register [MMIO Offset 2008h]
> 
> IIUIC, AMD should do the same: VMM traps VM's Command Buffer Base
> Address register when the guest kernel allocates a command buffer
> by programming the VM's Command Buffer Base Address register, to
> capture the guest PA and size. Then, VMM allocates a vCMDQ object
> (for this command buffer) forwarding its buffer address and size
> via @addr and @length to the host kernel. Then, the kernel should
> translate the guest PA to host PA to program the HW.
> 
> We can see that the Head/Tail registers are in a different MMIO
> page (offset by two 4K pages), which is very like NVIDIA CMDQV
> that allows VMM to mmap that MMIO page of the Head/Tail registers
> for guest OS to directly control the HW (i.e. VMM doesn't trap
> these two registers.
> 
> When guest OS wants to issue a new command, the guest kernel can
> just fill the guest command buffer at the entry that the Head
> register points to, and program the Tail register (backed by an
> mmap'd MMIO page), then the HW will read the programmed physical
> address from the entry (Head) till the entry (Tail) in the guest
> command buffer.


Right.


> 
>>> @@ -170,3 +170,97 @@ int iommufd_vdevice_alloc_ioctl(struct iommufd_ucmd *ucmd)
>>>  	iommufd_put_object(ucmd->ictx, &viommu->obj);
>>>  	return rc;
>>>  }
>>> +
>>> +void iommufd_vcmdq_destroy(struct iommufd_object *obj)
>>> +{
>>
>> I didn't understood destroy flow in general. Can you please help me to understand:
>>
>> VMM is expected to track all buffers and call this interface?  OR iommufd will
>> take care of it? What happens if VM crashes ?
> 
> In a normal routine, VMM gets a vCMDQ object ID for each vCMDQ
> object it allocated. So, it should track all the IDs and release
> them when VM shuts down.
> 
> The iommufd core does track all the objects that belong to an
> iommufd context (ictx), and automatically release them. But, it
> can't resolve certain dependency on other FD, e.g. vEVENTQ and
> FAULT QUEUE would return another FD that user space listens to
> and must be closed properly to destroy the QUEUE object.

Got it.

> 
>>> +	/* The underlying physical pages must be pinned in the IOAS */
>>> +	rc = iopt_pin_pages(&viommu->hwpt->ioas->iopt, cmd->addr, cmd->length,
>>> +			    pages, 0);
>>
>> Why do we need this? is it not pinned already as part of vfio binding?
> 
> I think this could be clearer:
> 	/*
> 	 * The underlying physical pages must be pinned to prevent them from
> 	 * being unmapped (via IOMMUFD_CMD_IOAS_UNMAP) during the life cycle
> 	 * of the vCMDQ object.
> 	 */

Understood.

Thanks
-Vasant


