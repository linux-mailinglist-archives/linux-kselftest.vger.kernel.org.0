Return-Path: <linux-kselftest+bounces-32483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34733AABA41
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAE91C2657F
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773D820A5EA;
	Tue,  6 May 2025 04:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NM1uCVYB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2054.outbound.protection.outlook.com [40.107.100.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712620FA94;
	Tue,  6 May 2025 04:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746506125; cv=fail; b=l9ns+gze7O7rOQqaEOWfVX9Pq63iMPMhwRH076cp4FxhN3qHHePNwd1ZA8kh1y+yQ0pEWt6vx7R3vEDuPi/EHZolvVr+/jH80iNKMFZQcbEF4yoXVT76lp7DI89soAGaKd5YvNcbLiGCHhk9Gfzhm3EX/odrPbORDb/cEcOwrZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746506125; c=relaxed/simple;
	bh=89Ie2/FRgLnDnJ76TbReRHj3wXpfsDq5lXN07QJ50Q4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ug6rLUTUkbpi+RYcs/F8rLWRcNBG53mVp1feuso7pKiz2Cqa4Tm63TkANy+O6FEhnicOrKC0U4DLeVpIGlSfHnKSgxvG80rP0L8S8cb0DPyPT2rICr+yu7dLCj+aJvqUUO/E5gwWrM1i0OqfPJjudaGY24HY6R47bmt+3dv+ei8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NM1uCVYB; arc=fail smtp.client-ip=40.107.100.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HkTpN7J6FgNEYI1PDd+O1OQPCgKj5GcJXBjDc37Kjk2j63AHnSymF5uVQhAVILnj64NS5UDk7Q4LeIRwQ3dyqvxzVJSUy5IQieHPRoZzkumBfRBLuTWBhTMsPCgGunkiTDUaInY+pY5zFmk4Ahn/KY8KAvygUaL30w3UxHQbrN3RKqHn36ScnNYa78iJCytbdFw9A1nTHOXlGZbbyKYGrR/rSorvW5n5zw2R1Ic6Re64CMRrAiNNQ6MENPXVMfnhNqR3YpzvDCGB+GBc+fXDFeouR0Vr8GAqKPyRXjWphq1KepEBomv4bFFWDvo33WC9tqWkKlNzGcD/QFYq16rJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cN5KvWUpB3A17ShSO0h0rLuAaDexnBhZx6mZhKdUYb0=;
 b=l09P5xzV5HgD/Gs+bCib/+OF0L76nZxi4yCOl6w2yklXiYYh2Tct6Cxl4NtlOhOVrhYIduOTaRu+oS/YeLpLZh7kz0XRFaMpJtegtn8GBVlN/Rw4Lv2jKUGcbPF6HIT98qG/sNfwB8nnRoRx2iOcNST0ecxQGx+7pozhRuI1+hRibylTQdJ5+iOCEoXb7CybLE+4fx/7Z50agcy1IIoOsdF/5ilvwEc3MT78aH2MIM2GdeXlAhz6TTmVSwJbbYRUBSURPp3wMjbM5muymh5pe4Od7D6VnVTpK17+6ZPQ/Kdu6H1qZj5xT8HCqWFbWmLHAwYUUXDwaOIMb0w6A6iVzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cN5KvWUpB3A17ShSO0h0rLuAaDexnBhZx6mZhKdUYb0=;
 b=NM1uCVYBMz4eq/unsTmxu5b5IZ/5uqqwk67tlUQhuprKgM2r0qO3q6vv636oSPun0hmZDcpDO40M6AnbTnOlTlBkNylcDupkEMxo5jkIu9sCei67abYGRHfYvAqgpmh0upF3QkLqf3M6JBtQXIrm5W23M2KBRoIWK6CfHXeutb0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CH3PR12MB9121.namprd12.prod.outlook.com (2603:10b6:610:1a1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 04:35:16 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 04:35:16 +0000
Message-ID: <c6a011c4-e3d7-4f6a-a3bc-2000e415db74@amd.com>
Date: Tue, 6 May 2025 14:35:07 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
To: Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
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
 <aBl5uLOFCntuIYYz@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <aBl5uLOFCntuIYYz@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SYBPR01CA0111.ausprd01.prod.outlook.com
 (2603:10c6:10:1::27) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CH3PR12MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f33a095-df82-4a44-584b-08dd8c576640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SU50OGx4bFcraUUxNHh4ZXpjV09Uc216UFJTQlI1TG1zajFZRGxHNTlxR3lH?=
 =?utf-8?B?THJNcHQvWFdYbmlrM1RJb3Exb0JQL2tPVXdKTVJaU1cwUWRFQ29Icm4vWkU0?=
 =?utf-8?B?UThGWjNUZHlCR1hLelg0NU9HRENvZndEQzlDUnFCaTJTTHpEK2NqK3lCVnJk?=
 =?utf-8?B?LytUeXgrR1FqQzVpY1J1YVg0NnVFcm9mZmtGSmNST1NPMXY5MDQyS2ZVZEFS?=
 =?utf-8?B?emJkZE1rb0ViSnpqR3JLLzJDRmNmaHZDUjNBclk4S2NsZ0dMQm1OYkduZXJk?=
 =?utf-8?B?cjhYRzg1Zm5YZkdaR2VaenJ4NVpPY1Y4ZXk2bkFDWmFzKysrZVZDSmdENGxs?=
 =?utf-8?B?M0x4cXZySkkrMmF4OWdkTWVhcW81M0EzY0lYeWljTnZEZGxLMVVwQXhXb0Yv?=
 =?utf-8?B?VEJRTW1KQk1QeXhlREh0dC9Pb21PNFJ0Q1AvVXBnaVpBV295M0F2NFp6eGR6?=
 =?utf-8?B?M1ZwbXFVdFVHYUtFOFZFM2haajZEeG9uRW9zTXRhdHJiY2JJQ1dBVDBCMExV?=
 =?utf-8?B?czdwMEtCcm9GQyt0YTdrOTJlcDNUcW5Hb0JKd0VFekxWaWU5MHc2Yk9VY0Fn?=
 =?utf-8?B?RVExN1RjaU1wdmZjNzNVV09DUzhrWFI2QmI4TEV4Y2RGWWd5U2RZNHMyOU1h?=
 =?utf-8?B?VldvRmViSVFSM29vVUorRTNoeS8rZE01UklFeWhwaG00RjJPN3poV3F3ZGhE?=
 =?utf-8?B?QXNjZU0vMTgzK0ZlaWw2YWxkTzJYbC9GU1d4TmdJZ3FOUzUxZ01xRHVtSDRt?=
 =?utf-8?B?N0Vja1NBQjlvT3UySFhDN1plbXFkZFdoUnpWTDc1bWVSUmI5NnEzazZsMVZp?=
 =?utf-8?B?MEFRODhFNGh5WWY2eGlHQ25aZzk4ZjdwM2F3cE91SUdWb2dJSGcvV1BaekRH?=
 =?utf-8?B?NER5cDNzR3BlbE1mcGdvMVNabU1HY091a3hYSi9ZVWNIWTNQUnR4N2F2WnVw?=
 =?utf-8?B?elN1ckVabjUxRkJjRzRrQTRSTXJzek9hdWNYK0xTNWdjQktsOUpFODhieERr?=
 =?utf-8?B?S2pRODh0MnNpcUR3SWNkbnV5SXVlZ3h4cElTQlZtZGlGdlgvYkQ4THg5SXB6?=
 =?utf-8?B?aXZXd1BwZG5PbmxVeUlCaTFtUGlaQ21ZdHZPQjZkNDNZUUVVSmgrbmNVV2kx?=
 =?utf-8?B?ZUt1KzBpRGtRM2FjMlZSaUhIR3VWVVplVWljM2JEMWtKeDNMa0lMSjFDZHpa?=
 =?utf-8?B?cTZsbGFXTWhLVGN6Q0pVT3lBQmVWYnA4V243Rm9PbnVFOGp1aDFOSUVCZmtj?=
 =?utf-8?B?TzNaUkhEd1BqZUdtcWQvSTZuZ0N6enJrazNGaUhQRHloV2dxRmFsNW01MXFT?=
 =?utf-8?B?N0JPWkZVcGxaZXhmNzdkK1BzTUljTVlTUmRpSEF1dXZCTGl5Yjk1WTNycEhT?=
 =?utf-8?B?T3N0NkRYd2dDMlc1TkVETTlnVXYzem9sTitrRlY0NWRWYmpBUjhIc3JFUFBk?=
 =?utf-8?B?L1dYL2pJNWJzcWV0ZHNiZUluU2RsbTNqY2FQcmM2VFFWMW1tczUyZS9WbHZI?=
 =?utf-8?B?WnJyc2NnOUN3S3FDMklHOERSbVBXSmswc3NpWjg1Vm1iczErNWMrZitsZjRq?=
 =?utf-8?B?aTFhRDg3YTR2eGROdng1NlhQR3g2YnU1NnMvK1MvVDNRYnRJWUdjSW5FdStF?=
 =?utf-8?B?OGh4MHI4Yi9oMTlXTGFLaFhoaW9odzJ6TVZ2d0htTjZxOTVGWmFBV3VmUVZi?=
 =?utf-8?B?akJleG9Ld2pIa1ZMV1FYaUxub0JQd0ZxTU91ai9TMERsMUlZWjB2S1J3cmFa?=
 =?utf-8?B?UTBCNmRGSzgwMVI2QkhIZlg2RmwxS29nTDVXZTlkQW44Smo4UTBjeTVJSWQ2?=
 =?utf-8?B?VkYwNHQ2NXNzVk4yREt3TDhRLzRNZE52dXpuRmVkM0V3SHNmRERhYXIvYmZK?=
 =?utf-8?B?d29OdmQ2NG92UTV3TmlLUU5rVFNUdExQV2RBSDJHbzRPRTd5K3FiOVVSN1pO?=
 =?utf-8?Q?kdx14GLBrAM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGQ1YXM2R0lXelNWQi9XeS9ydVd0OXk5ZlRsYlU5alI5VG94dk9PRGQzNHFj?=
 =?utf-8?B?SkdsZnBwcG1FdTVrQ0tVTGtpZmE5b1YyZXNidWU5bnJQak5BR3E0RGNKZFFt?=
 =?utf-8?B?NWw4WmNHQVRjaXI3MlNHZU9wbjRJc0VuTkpJcVE2dENTeUp2VnBESW5XVUh5?=
 =?utf-8?B?QnFuN0E5SnRNbVdKVEk4a2RsUXRxNVRrdWpwR3o0aDJjSUVsdnRoc0NPSUhC?=
 =?utf-8?B?bnNIN1ZEQ3JhOXlUMkFPUC9NUENESHZzdDZnS3NJWXNiaTZ2bkJ4UFU1ZUNO?=
 =?utf-8?B?QlhiT3VXTXp5SzJHZkNiVmhNUTlKS21hVS9RMk13alBIUDFpQlkrTC9abnN0?=
 =?utf-8?B?MWt6R2NQMmxmMm9RZWpWVGE1bVhrQ2JpdFdxRm9DNWdwVHFpeEFvK1gwK1Vh?=
 =?utf-8?B?VWFaaGlRNlNOM0FjQkpKWWRPa2Mxa1NkK1lEWUF1QjVxcFJ6aks0QlRkZ0ZM?=
 =?utf-8?B?ZW1EaU1zSU95aklyb2crWlRoZVZtQmF3S0F3L2dTVzBxUkxVcVJRK016blV6?=
 =?utf-8?B?Y0k5ZjRCbnkxbmNhZldtZmdZK095ODNpemdDdDNQQ0Nla1lKTnp3czA3R3FN?=
 =?utf-8?B?RUM3SVM5NHdKNlAxQjFNU2g0RUU5VWdHMFMwZ1BQZ0swT3JSa25reUh4Z045?=
 =?utf-8?B?VkNDaXBQQVBuanhuemIzbGd1bklURlZEb0tUaFhRNnpDWE5kd3BVL0dsajUz?=
 =?utf-8?B?SjNEQWxQTmhOZlg4NTNMNElEOFVhY0Q5K0hBSmJtQzc4ekhHNk5vN3plem4r?=
 =?utf-8?B?WGIwRk9oQS9zNkZzWWtEaTlNSmV0QnpDOHBHQlgxMDlnUjdRdnBGYVU5VGUr?=
 =?utf-8?B?RnhTL3JsUThHYnNISnpxQzk2RmVzSGZwU0ovb0J1L2VKaHVJUTM4dmFrQjc4?=
 =?utf-8?B?SGRlejN5cHZkVEtTOTdHRjM1Q1dZdFN6cmo3d1A1RnFHRWx6Y1VzUnd0K0p3?=
 =?utf-8?B?MWdLNlRMN3FCYnN0VCtpSkxoQkY3RWtURkZTRko3VDBjeWJMUGlzVUJPMzgr?=
 =?utf-8?B?MDVEdlBST1Nobk5lc1dlbENFcDNpK1pOK09VL21UYkVqd2dLejk0bDBqaURF?=
 =?utf-8?B?UlFhQXBQbmlNSUp1OUlnVUw4TGpMZ0hTSkNCdGRSZkNwdTNQS3Z0VlJ4N2lZ?=
 =?utf-8?B?NFd5Vk4rWDFJTEhjSVY3VlJzbzQvaUlLdGFOYVdhT2lpVUFUbmx0cTk2Z1NN?=
 =?utf-8?B?SjFqS3pzdXQvNVpwK0ZuY2k5cVB4QnR4TzhNRHNad1hYSXQxNTFnUStVcWp6?=
 =?utf-8?B?bVYwaVBrd2tONkI4eU9GM1U2c28vYnVwS0lta2JaTmR6VTJWUjYvN0hjQVI2?=
 =?utf-8?B?KzZpL0Fla09raVhBbWxrbG04bzZsV3puL2NRUndnVmN1YWdrU2V2cUlLOWor?=
 =?utf-8?B?Z0VOeVo5M0x2TVFpQzF5RzF4VU1wK3FXUndGZ04wU3ZOWjJQWlpvam56NUxM?=
 =?utf-8?B?ZmEwbldHSGc5YUhkQWhtTzJUZVE1L0xZZmRKcW5Ia2orKzJGZ24zRHBhamQw?=
 =?utf-8?B?VlpGdTBWNDZMbmR5WlhQcUZ1VzI1ZVpZZGlTZS9PWVFQWE1TQThpeTZvZytX?=
 =?utf-8?B?VTZHZ1g3YjNkQVdndHUzUnVaNWNRU3JhdDhDaEljUThkL0lWb0ozZTN1ZGQx?=
 =?utf-8?B?K1YxdDFTaDh4OENUV3ZsOEtwQUpiVklyWjhzazArb0V3d0hjNExMN2M1djlo?=
 =?utf-8?B?b2UxV0hxZmJUSzY4L3ROWjFUM1ZKRDgxeEYzNC9MamhxQnhGVEQyREZBSW9J?=
 =?utf-8?B?dEtmVlNrVDVUOWhvdk5mRnBPRDhxQTdSbzl0aXZEd2piaWZja2Jad3FqMlEz?=
 =?utf-8?B?bTJGQTl3NXRTR2FqUTFpdWk1Y2p6Nkh3akdCUEhPYmNsalB4QTNRd2ljQTRK?=
 =?utf-8?B?ZXVFUFljWVFRK3VMbDhBTmZRS01HdDNJdHE3M1Z1a1YvaGs2R0twOGNENnNn?=
 =?utf-8?B?Q2JFOFU2Z1YvRDVOVzl0Y3lxdDdNRktxNytVdFJYT1dyV1pVNlRLeEpxNUhG?=
 =?utf-8?B?RGpkS1NOaU02U0RtK3k2RXBQUGpObHFQaEtCYktSblA4M3F0UnVpTm9KT2ts?=
 =?utf-8?B?SjRtY3hqcHdZVnBJSmQvSHVyc0hTQjJ5dks2N2ZoTUpqT2dLZG13SUZDN1dE?=
 =?utf-8?Q?s1iRnVdAa7vUAlRXfhg2/HOz4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f33a095-df82-4a44-584b-08dd8c576640
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 04:35:16.6088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpCpxtsjr8vwW89D4FH8R6iYeuF00m7Wzd2FP7vKeC94C9NCx/Ivn0QF4fzbQNTo/M905Wmmspn33kguwYWkzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9121



On 6/5/25 12:53, Nicolin Chen wrote:
> On Mon, May 05, 2025 at 02:08:07PM -0300, Jason Gunthorpe wrote:
>> On Wed, Apr 30, 2025 at 12:58:47AM -0700, Nicolin Chen wrote:
>>
>>>> ... and I just hit a problem with it - this is basically guest BDFn
>>>> and it works as long as I'm hotplugging the TEE-IO VF into an SNP VM
>>>> but does not when I pass through via the QEMU cmdline - bus numbers
>>>> are not assigned yet. So I have to postpone the vdevice allocation
>>>> till run time, did I miss something here? Thanks,
>>>
>>> I have a similar case with QEMU ARM64's VM: so vDEVICE on ARM is
>>> allocated at runtime as well because the BDF number isn't ready
>>> at the boot time.
>>
>> Oh that's ugly then.. So you'll need to add some kind of 'modify
>> sid/bdf' operation I think.
> 
> But the initial vDEVICE would be still unusable. Its BDF number is
> literally 0 in my case. It can't be used for SID-based invalidation
> nor the reverse vSID lookup for fault injection..
> 
>> The bus numbers can be reassigned at any time on the fly by the guest
>> by reprogramming the PCI hierarchy.
> 
> Yes. If we take some aggressive use case into account, where its
> BDF number could change multiple times, I think it's natural for
> VMM to simply destroy the previous vDEVICE and allocate a new one
> with a new BDF number, right?

Yup, this sounds about right, recreate on the bus number change.

> 
> Thanks
> Nicolin

-- 
Alexey


