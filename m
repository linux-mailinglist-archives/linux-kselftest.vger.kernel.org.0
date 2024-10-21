Return-Path: <linux-kselftest+bounces-20228-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DDE9A5884
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 03:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CAE2282419
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 01:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD00EAE7;
	Mon, 21 Oct 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IfQAn55z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2074.outbound.protection.outlook.com [40.107.236.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB4ADDCD;
	Mon, 21 Oct 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729474031; cv=fail; b=ujianW0oYAWE/XPYPRkMGCEP+4qUW7sTpET09ofAmY82w6CPkhkL4G+ApaKMUn/Hl/1mvpKU3+up83KGHh2licj1h8aANWVY5cmR7rvLp7BxTvG1162Cszbj5JYG/ziDmE40P+lBFutCBbYaZl0g2ArKONC8xsdFzkXmjX0xz/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729474031; c=relaxed/simple;
	bh=fqNSzURX+L41UUR5LEMj26m10dmyPJHPT4nmjwwOLzs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s97kTvUAc7Y62Nm48d+zEwM9+QLFaJjTwb6q0fjbTgVT6vZ4RrZhC76m/AvwxZ4UDfCY1tCWtSnlBtPJojqgGVz6rU+BB/y+kDFRRuAwtu+wZ5qa1PfNDvmLiOFt6oYeQwOGI+N8WqIMusmSDBMHT/QLtB2yzERR68G4qufj+6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IfQAn55z; arc=fail smtp.client-ip=40.107.236.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBbJDqcWxrS845g5gBs82z+O+HgzdKZAxyuthdh54PcOO+PBZMGn8J3lyJGlc+yp86voQLjWnA0UR2595pi1fNaRZcva0+JMAWbdP4iZodYp/0My9nwON8Q1R/UiAHBtdJlCdiAEw/NN4WDEihPiymQk1E0D2g2fsnw9HETy0RUDHoiQ4nOI3BhP5UP5ZKfcEZ0SD9A/jokKrmFg8RjwILOUomOLEFw7VwFhcuuFi/Wtu0lNFr+4jDaaS6Y3QwoQYIVi21qzbkfMQcC867napVNd5bU32aZpbzCLkdP/kffvrH0ZXgF/+b+LG4kg14TrVG+i8W+OO15w05C/tQgzgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TqgDopbLdlc3ZRNbpb7Z5ZOG06RkWhOOCT2wdL4KZ7M=;
 b=Zivo25MPU9VAJMQI7mLMEXMauLZo+pFRmbUzBY0G1/W6jz0zXdEFDtPDk7L4aBJgx6TfGTlYnNejWcfi4CAj8m7aoLiKKDT4FGo9BjQxRJRcn/gW4QS1vDY7OqSfhmmypLw2eXfzvvR0Qxs8NgSqc7wBgT/Ru+YoPTqzP5YCoCTAL6/+xuFKlsgOYEdBVfFJAgIo9eB8eeDyu5t2QadzcV7ha/X9mYIk+kFrDW4P8h4BMZ+yiv57zmnKt0rdRDJYQDoho81lLppeIAKurYJQYpd9Ety4rEW9Hey3QT4PTHpBseyhVpbyuw+Ku1ighlir729+NYCY2g5tw5ov0HOC5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqgDopbLdlc3ZRNbpb7Z5ZOG06RkWhOOCT2wdL4KZ7M=;
 b=IfQAn55zPlf3gU5ynG0HT+3iWixcw9RcTxuhoRZ6vPqELX345pk3nX/h+6fJNs9MaOQ2dZB4MTERzFujy8v2mqZYyIzFiqYNFOrqfUPFanQ7FBcT7s1SJI/080OYzOfaxz1vqEAmgYeTWCUbZkuZ/ZP22o65Fb7MYo3H0WWXsnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by DS7PR12MB9475.namprd12.prod.outlook.com (2603:10b6:8:251::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 01:27:05 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Mon, 21 Oct 2024
 01:27:04 +0000
Message-ID: <7c5fc87d-0025-4770-86f6-8b48ebfd817e@amd.com>
Date: Mon, 21 Oct 2024 12:26:54 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v3 02/11] iommufd: Rename _iommufd_object_alloc to
 iommufd_object_alloc_elm
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
 suravee.suthikulpanit@amd.com, robin.murphy@arm.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, shuah@kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
 yi.l.liu@intel.com, patches@lists.linux.dev
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <dbfc718cd3200071765007c7ca0a2ba242181d05.1728491453.git.nicolinc@nvidia.com>
 <20241017141416.GZ3559746@nvidia.com> <20241017153749.GA3559746@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20241017153749.GA3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY0PR01CA0018.ausprd01.prod.outlook.com
 (2603:10c6:10:1bb::12) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|DS7PR12MB9475:EE_
X-MS-Office365-Filtering-Correlation-Id: 073d333e-34f1-4e93-02ff-08dcf16f782e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R2l5SWptdzZBNnJpd3lid2FPQlJuRFVycklhMVBQV1pndTNHOU9SWTIvaUhT?=
 =?utf-8?B?RFQwanpZQk84dUdzOUtUd2JQaFNlUDFZOFlKWHFvQVBZWlpSM0hoOUFpSDZu?=
 =?utf-8?B?Y1d1c1dLemZaaDJHS0I4SWxEMlFBOXZITFRra0hzRU80QlBENmY5d3FYOURM?=
 =?utf-8?B?WnM5YWE2WlIyZ0FvQ0RKTDJNRmhMT25jSWtZTGhCMUtqK0NCcFljdlh5QjRa?=
 =?utf-8?B?dG9nb1VWcnBtN1lxNTZNZGZ4eFRDQUJ2NGtmVkFDMkxUS3Q0SkpqdkRRK2ww?=
 =?utf-8?B?dG5wUTk3dDJJclA1Wi9oTEZGc0VtY0FraFVnaER2UkpaOEovM0E3T0N0V29a?=
 =?utf-8?B?V0xBcHlhUXd2a0RmS0NoWGlDbmZ5WmV0bHBLR0JLeHpzT2tCYXQ5K1NXL2ZV?=
 =?utf-8?B?dmRYMmdxZHp1blZoU2xpWHMzRm13dURFZmFNd0J2cytGMVNoSDdsNU1lZlRH?=
 =?utf-8?B?Vjk3VkZXcnhlZ2ZuZyt5NTJONW9VdHA3cXJJMWVJRjRaNWxhR3JrYm1qbi9T?=
 =?utf-8?B?K2xYKzJhOHFUUGZsdGZCaU1GNVBlSlUzZkR4d3JYVjhJV3VjaVBHQVlPV0Jm?=
 =?utf-8?B?VFhlQXB4amFIcSsrd2hwcU1IeE0xZUh2Rk1uVVpoTyszSnlabjNieXkxeG1M?=
 =?utf-8?B?T2VkTTRxTEFPMFdOQTdYYXFNRm1iUWo3akNzVDdjQ01Ic2wyVzBNMkpyQit0?=
 =?utf-8?B?NlcyVkd0SlR3YldReHRrQjd1clhtTlZRQlJEek5pVWF1S3h5YXhvYkNNNllS?=
 =?utf-8?B?MFRtbTZPWG5hUmFoUGxiMUxwL0dFSVVkejlNYnRGTUxQY0xpUDVtbEtJNkZ0?=
 =?utf-8?B?dHhnamtmZnkrM3VobDNLb0txcUlPcnV5ZE54cnA2dFdURjBYMmhnZDkrckhX?=
 =?utf-8?B?UFNUZEl2U1owMWhiRFc0anJnOEk0dG1hUXNoQ1llWXNjeVkwWVJMTGhyT0Y4?=
 =?utf-8?B?SWc0L2FTaU84c3VieDZ1ZS9mbFNldEFqcExOcURvS3g1S3lzSFVYdG1udVF6?=
 =?utf-8?B?ZmVhWEw5SVVkd2F6bnNZZUp5Y05rQm0rTHZMWXdJN3owcEhPcFg3M01UQ1g2?=
 =?utf-8?B?UExCRG9SVUY0RC9lcUxxMHh5VzB1UjJTbmF3YXRJR05SazM5Qng0dXVsSVNB?=
 =?utf-8?B?YXlKaGkwNmJZaFl5TStxZ3pDSEtYdjhCMmUyY3RMd3hEZGRwbXM2VnlPRWEv?=
 =?utf-8?B?Q2pkWGpETHBsQ1krWjVFRWtOenNwdjdjWU5sZ2hOandQYmZ3ZnRXVXhOemJw?=
 =?utf-8?B?V2w1a0FRRDJIazlCR0NXOGlNZ0VjY2pZbmdiUlY4WkdkRm9JLzkvWUptTThw?=
 =?utf-8?B?dGRTVHBDUUdOVVlONzA1VXNNcTFsVTBtNTRTTUFrSkxxUS9TSXl4RzNHZVFP?=
 =?utf-8?B?OVlCM0RLcW9oVjU5Nk1oOGVFUFNnMnpMNE1XR0tndjlpQldsU283Z1EyYTg5?=
 =?utf-8?B?NkpjT1UwcDZhQW5uNVNkeFNmVEFxcWhURGxpZm5yUGQ4TXB1eTlGVzJDSHlr?=
 =?utf-8?B?REptMnJURDJiTVJIVW9ib1RlRWpmc0VkMkt2eGZabURjY1JsQXRseHBPaEta?=
 =?utf-8?B?bWlPSVdvRWZFQ2k5elhTV2VnaWp5b215Qmh1Um1zak10YmJEWldSOUxSVkJo?=
 =?utf-8?B?TjA4UHVNSWd5RER3VGNmVmVDYU5VZC9adnNLd05aaHovNnBPZmlBVW9LT21S?=
 =?utf-8?B?bmJWa2JwRjdEOXh2TGNEaWltMGphalZWNlBhM1E3TnduQjlKT0U4YlFqc1FD?=
 =?utf-8?Q?R3Ee5TqHVgeLycR+4M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YllVSnMvSFluZmxva0haRDdBc1BFZWcwRFhMVC9aYlFDbU91N0hiSEZTcFM0?=
 =?utf-8?B?Z1NncDdaWDI5Myt4UXJIS3NzVmVYQjBDYzBWVERrUklXZ2YvbGlwZWtYQ1cv?=
 =?utf-8?B?eXZ2TFVHUEJUYW1nY3FOckhJT0N3NGFIcjA1djdYc0s2bXFmZExpcmNoL3Bx?=
 =?utf-8?B?eFRGODZTcERERzJjWTEzOU93bU4zMGVKZHNlSFZFcW91NHZRT2NUT2pHa213?=
 =?utf-8?B?ZC9WNmZ3dThjb2kzbFdnWmJQOTNlNjR4WldWRDk0MnQ3NlZpY0pCL1BzYjJ5?=
 =?utf-8?B?WDh1RzV6MGkvdlg1MEwyRzY2WFN1ZWZrUFZKWXdKTXJMT3BDWVNQMWQ4VUt2?=
 =?utf-8?B?c21GQjlIL3h1VklycmtxamVhLzJIWFZBMUZKa3NDeUc1d3h0ZGZwMkwzVFRy?=
 =?utf-8?B?MTFObkFkbWtvc01ZZ0RIcEdvTExwdEhPYjRNRkxOeWR3RHNxVnVDemVndmVR?=
 =?utf-8?B?ZFdPWXVPK2hDMjhnUUROOEFxQVNXU243Z0gydmpidDFaMHA5L0ZvbE5FaVlB?=
 =?utf-8?B?dXhzL1FXQmw1c29qdGpxeW9EM09vN3VmM2dSS2w2MHlJUVJSRm1CZmNDWWIr?=
 =?utf-8?B?MmdhUWpRTEpMRFV5blhVN0MxcWcvVHVMQW1ySFVoQnRlZ2Zzckw1TlVrdExn?=
 =?utf-8?B?NndpYmttMk1lVXBsbkpaZnhEekJVT0hCNEwxSzlkTStPNWxzNmFSNHVxM2RR?=
 =?utf-8?B?aXpHRUFPMUVBdlpaVnhuK253UlhJNk93VlkzZW9mTmhKUVFTZkwyTlBWQ0cz?=
 =?utf-8?B?aFVsZngxOENzWmd4dkoxUmZldlFFN2tFQUhvZkZuNHFYTkFycWJucU5scEN2?=
 =?utf-8?B?dkwvZUg0ZnJOYVRSeHdFZkxWU3hsQVVkUXIvZzczUEh0WE00bG5SdzZZY3M1?=
 =?utf-8?B?UHMrYkZrclN0NytMRGJrM3doMFpiTWY1aG5rcW01QTBqSllXRkFiaTlxV3Zr?=
 =?utf-8?B?M3FYeFFMZFNnd2tvN0EycnJtaTRMWHBFUEdWRE0zMmRaOCtjaXBRanFZUC81?=
 =?utf-8?B?ejRCLzhaNzhlbzlXNXRDWW5WR1Qrb0FJUmJpdDRiZC9nTUVrOEUwVkJYNlVq?=
 =?utf-8?B?YXpBUllRQ3lSVGxyMFk3Y0lvNWdzdzE2L29uVDg3TitFQnZzbUgyZ3ZxUDZQ?=
 =?utf-8?B?TDNzT0UzREw5eXFWOU11RzAwVmt5dXBLVnU1b0lFV29tc29XL0pQZ3FwaFdH?=
 =?utf-8?B?MEl5bjJ5T0RIVFVIWm0vTFVaaUx6SkpYZDJoOUxDMkxUWkdoYXY1RjlDazlv?=
 =?utf-8?B?d1FvZUdGUkhETUxjbnZDWExTZE8zUDZzNkptSDlrWE9xSWJINzY4U1k1V2Rx?=
 =?utf-8?B?UjErd1pjZWo3QS9OU1RsYXAxenNIUzlNdjlKSlJFWnI0SC9DbVBjbEhVZElH?=
 =?utf-8?B?NHh3REZUYVBTUjg0Q2tHRy9nTjEyNjVYYjhSU0l2eDVWV3VOL2tWcytZQTlP?=
 =?utf-8?B?Q0Fyc2V2NTI4Y3AzUTd5MDlBZmpOT2tGbXdGQmg2U1FQdk8xYW1qdDlQWUEr?=
 =?utf-8?B?UFZ3S2xhemFpeTBkdmFlcTI0Qnpmc0lyVGdiNFFvTGFQbUZNbkxYUGlmcnVE?=
 =?utf-8?B?MXIzSEF6RVhXdVNZR0dRRFh0eWtBUkdOemJmeWcvdTVmdG9KaUpPMXVacnMw?=
 =?utf-8?B?cmNRR2J2SlJFUTNGK3hjdjFFU0J2RmNXZWtoV3JCZnZaRWplQ3lMS21GbUxz?=
 =?utf-8?B?dzRlTU9QdmRZdWtEZU5wa0NHOFh2Z1QxeitzbGtGODdoVGFuZ2tnSXNYVUZM?=
 =?utf-8?B?ZVFTZzZKS21YZGNRNk9rczBWMjFwTm9SRnlzcnJQVVVlVzNzb3ZBOXZrRnZH?=
 =?utf-8?B?aDRRZk9jRkppM1FqdUtQbkZHZjVudkw0c3NKSlltSmFyOTRKYmppWHNDVzNQ?=
 =?utf-8?B?MHY3UnV4RUtUSmgrKzVpYzJBY0VxblAvM210VW16UDlOeWhmcFQzbWJWVy9Z?=
 =?utf-8?B?UFlyU3JpbVltY2xSR1NWWnNXc3E0RERNVUdJbjNrQS9pT1NlaFZ2eGN1MS9k?=
 =?utf-8?B?KytYWHEwQnFnak91NTREKzVFdHZWNGFudE96YzdXc2x5dXByWVBWMlYzYkRQ?=
 =?utf-8?B?dmRQRVpJbVNaTnBCUlBiWFgyR0xXbE9pVFMrenpVUy9taFo2NTI0UzZFZlR5?=
 =?utf-8?Q?sBu53uWFEkTF7Q7i0YR6KfIxG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073d333e-34f1-4e93-02ff-08dcf16f782e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 01:27:04.3356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mVSNXhlVbCfwB4qIrDKSol/ESXUxHy493ouHVqVcpm4kVj7idwuG7PPJY2WrxIhzNhJLgzCn0GpFYDrZzJIrqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9475

On 18/10/24 02:37, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 11:14:16AM -0300, Jason Gunthorpe wrote:
>> On Wed, Oct 09, 2024 at 09:38:02AM -0700, Nicolin Chen wrote:
>>
>>> @@ -217,12 +217,12 @@ iommufd_object_put_and_try_destroy(struct iommufd_ctx *ictx,
>>>   	iommufd_object_remove(ictx, obj, obj->id, 0);
>>>   }
>>>   
>>> -struct iommufd_object *_iommufd_object_alloc(struct iommufd_ctx *ictx,
>>> -					     size_t size,
>>> -					     enum iommufd_object_type type);
>>> +struct iommufd_object *iommufd_object_alloc_elm(struct iommufd_ctx *ictx,
>>> +						size_t size,
>>> +						enum iommufd_object_type type);
>>
>> Maybe call it raw instead of elm? elm suggests it is an item in an
>> array or likewise
> 
> Or keep this as the __ and rename
> 
> #define __iommufd_object_alloc(ictx, ptr, type, obj)                           \
> 
> That one to _elm like this:
> 
> #define iommufd_object_alloc_elm(ictx, ptr, type, elm)                           \
> 	container_of(_iommufd_object_alloc(                                    \
> 			     ictx,                                             \
> 			     sizeof(*(ptr)) + BUILD_BUG_ON_ZERO(               \
> 						      offsetof(typeof(*(ptr)), \
> 							       obj) != 0),     \
> 			     type),                                            \
> 		     typeof(*(ptr)), elm)
> 
> #define iommufd_object_alloc(ictx, ptr, type) \
> 	iommufd_object_alloc_elm(ictx, ptr, type, obj)


Bikeshedding, yay :)

After starring at it for 10min - honestly - ditch 
iommufd_object_alloc_elm() and just pass "obj" (or "common.obj" in that 
single other occasion) to iommufd_object_alloc().

__iommufd_object_alloc() - a function - will the actual alloc, 
iommufd_object_alloc() - a macro - will do the types + call the __ 
variant, simple and no naming issues.

And it would be real nice if it was "iobj" not this "obj" which is way 
too generic. Thanks,



> Then you can keep the pattern of _ being the allocation function of
> the macro
> 
> Jason

-- 
Alexey


