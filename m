Return-Path: <linux-kselftest+bounces-18999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFE98FCBB
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 06:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B53A1C2152B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 04:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF526281;
	Fri,  4 Oct 2024 04:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ecUV7iGy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9D21A1C;
	Fri,  4 Oct 2024 04:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728016363; cv=fail; b=LaEIgNWlMm4cSz5fkSdbX58BQWqNS9/yW73WEPQNWCmfTnXhRa29CNLaKPKtU+n51vTvuMHu/mJ2XQlISpdrwxKRCvXZyJPE6UlcdT0ZZlRMvI9udull8sjTZEbPST1GTl8Vbpt7eEfuM/GdVsqEqqX+wiyAdUrgyz1OIUqVg4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728016363; c=relaxed/simple;
	bh=/I2mhGzXcZn4SuP9lnWIgFwnQgcAzSgbkRcoN8y1+gg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LbM2X6QX8mhUtLV1wKmrv8dJfrUkhoO3Cr+3COYXKuyW2y2n1/K/8WB+CN2oDCRdMe0eA3/rfJiTn1DNVrg6iIrgq9XaOHXj8VQ2SuhI96UdWw1mflRFI7/VNiWiDKfkwbFrcxZO4yC8gf9TOQYlpvgyuBXZtkajLIbHJVNR0ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ecUV7iGy; arc=fail smtp.client-ip=40.107.223.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4eyErojHrakWvSv9uA7UVQXz5L9JgkzlCLy3DxVmzH0aJlD8g4zFXnC79dDe2F3Wv4kns4gRNNE/t/hmASrwFIIERz1GwxcPYF8KuVXvZVH4k43pda+efF+jWWT4znkJOn6CHnveCokzib2z9NwHsbtv6zlHJQ9I0E5d98/yPgnJpp+YxpccYtHY+47cudgdoT+pHK1Hzj4SLjCR9RW1PCYUnFKCdySD+h8J2pldsDgH41vDmq9ozv7wx7I21qgzKPkQgtaIoeIRMSGk9elZGRNP7m1L88b4B8L5q8MhXK5wRjvp3yPZrV86tLvyezDe3G9nxJseuWv7wHFeNs6Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hj7vuXPMreC0oTR1y5WISo+wdfZnBK2OSEyhr826jX0=;
 b=Wmy7aKu/qNkFFkoxa5G37vZellrIi2/UCm+azWie5SEIRrjovrADsQmmJdXuOk56gff3GflK/Ps8ntHbrMtBgT2Ekx9A9oQzWgFCAzwBcCNs5UtfpKD4SysiCeHfrXWhQHsUXMW07WZQxQhytvtXxrgl6A6IQ9ahBQacFbiIEQY+rhzUS60ELzPxarXex5o2LayQL0f6kvLIZEurCqPCPjHtal0NOI4IwzzBFeCJJTv0EW2iWIxiJH/9lX8b5ZzBfS9XA3X/xOMI37jG5jPrecQrcSiFa3sTqQ5Y2JkhNVd7sgPH4IwtVShN1jyUap3+1f2Itgvrt6wkIskEsn6tiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hj7vuXPMreC0oTR1y5WISo+wdfZnBK2OSEyhr826jX0=;
 b=ecUV7iGyHEqOWRI65OjwAkr1CYiXWTHX3SedfxG5xx0sVglzAUbz3lLiEECUuZJzbszr8i7RqB1X4AS2gBSQ69bX74BUFHSaVU43zQb3nahMeK8Daoz/ElpSKrKosKq7U23SP0ZSZX4L+a8V5TR5z2u3KyE0YDSC+CmEBYJ5vzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 04:32:39 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 04:32:38 +0000
Message-ID: <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
Date: Fri, 4 Oct 2024 14:32:28 +1000
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 06/19] iommufd/viommu: Add
 IOMMU_VIOMMU_SET/UNSET_VDEV_ID ioctl
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <6348cc7a72ce9f2ac0e9caf9737e70177a01eb74.1724776335.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SY5P282CA0034.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:206::14) To LV3PR12MB9213.namprd12.prod.outlook.com
 (2603:10b6:408:1a6::20)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: 76722a70-d938-4b72-b155-08dce42d9323
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZUtuK0ZPTElKa0pCWlJReEl2bkczRjM2QTlnNSsyZDFQZ1JBSStWdXlBbXBK?=
 =?utf-8?B?NDFCS1YzZXFVdmt2WVhycWdOMVFEQ05qRmdDV2htb3FweVdaVkVJTVhIMDhw?=
 =?utf-8?B?cXFXWklSSjJrdEpCVGVFblVVc0tUSjlXYUJCSEJXZUh1bWR5VE05azZQRjJX?=
 =?utf-8?B?d3VCR3pRam8wY3BFMHdyNEhqN2I1UEtUL1NhZU5GOHVwYy92RkJpcHJyQkEv?=
 =?utf-8?B?bGpqTHNHWCt2L1F3elJXU3FBdmVzS0RBOFlwbVhjNWluL2NmdDd4d0s1WnQw?=
 =?utf-8?B?L0VSZ0l3b3pGS001cjV1SlJxRE5PbFpWandhRDJXY2JUeHJ0anB5YVBYK1la?=
 =?utf-8?B?N1NleTNnUEcwKzdiZGRsSTlPclVYcXlRek5WNHBIbnBsRldrOXhLU3NRT0NQ?=
 =?utf-8?B?Z0ZQQUE0ODRteEQ3dUdzWnd2bGFhaDNyOUJNNmVaOXVzZ1BScHRDZU5TeE8w?=
 =?utf-8?B?NmxMK1NnZ0IvQ20zZ3g3VmdzWEx5cnVEanV4b3NaNk1tNTBvdy9DSnNhR0Zr?=
 =?utf-8?B?eG83Mm9KOVdWaEU0WENROU14cHZFeDR2MFVuM0VJU2U1YVhqcUpwanh1cjZH?=
 =?utf-8?B?czBxc1d0dXR6aFJCR0I0dUQxbDVFNzE0ZTVGTDltaFZOVFc2cDB5QTN0d0F5?=
 =?utf-8?B?QUxLYldMTldEeGNhQ25HTEJRR3dhMTdnQkZIUHg5TWVDZEpBZ1ZpQUlyR2dP?=
 =?utf-8?B?RXo3SEVWTWVIQmd4cmoxTzRaSkVMOGExcHNuSWlZU0FrUzVXRDBIODdER1Bi?=
 =?utf-8?B?VHdtU0U0c0RVV2R6SVdDUHh5VjFOTC92MVpGeFFqZmUyWGpDZmJtT2tiQnE0?=
 =?utf-8?B?ZDA5VWFFSWVCSDVHaXZGSGJVQzNIYVVPVkVjWXlwb1hNdjgrcHJRaE5TTlJs?=
 =?utf-8?B?MWRjay9MTGd1OWxZbTZWT29ZZTRPL29FNUdqcTZzbE9GazlwdCt5R1E3dC8w?=
 =?utf-8?B?TGZQaXdrOGV4Nm9mQnRGejl3aURQaGF2SHkwcGp1WVNEOEVaN2hNaERHcWFt?=
 =?utf-8?B?aHpkZXBIam5JNjhtd1pGK1hRSWNMMDRaNVhGeS9XT3JXUnExaUNvSFNSMXMz?=
 =?utf-8?B?TmVDKzNCYzdNUS9hNlpIN09oRGdYYUcxUXdFeXE4eUZLdm9hYjV6THNsOHFs?=
 =?utf-8?B?RXp0M2JmYk1wZytjOGh2aVVtU0JTZVE5THZteWhVTjROTENvQ2w1cWNPa2Nm?=
 =?utf-8?B?YTQyYUtqMzh3WXhIZnMrMGhUYno1MmJoTGhVeDE4VUVsdnNtZ3FLRUw4aDkw?=
 =?utf-8?B?YmNUbkFTRG9PbG1mQ0JJRzYyLzFwalFCQ3hLYk9MVlNqZVZRNk04UEJ2Unhm?=
 =?utf-8?B?S1JnOXpZNkxiYVB5cFZlcWtXOUpOTFE0dXVYSzI1Vk1BRXU0b3hIUkFzanN4?=
 =?utf-8?B?eURHUWNYcFpOdDIrWXRXNTB1N3NLeThOTDRRbE9lMTRmTFpHWGtPNXRRaWMx?=
 =?utf-8?B?QlJIcXdPNDJqOTd1UVdYZVYzK2lUQzVZbGNJVml5NnN6TGpJcDNCQjVmMG0r?=
 =?utf-8?B?NVhkdFlWc29nbGJPWFNhM0xJUVFncVZuV0VySHJNKzdjYW84V2tVTkliRGJ2?=
 =?utf-8?B?R3hzL2xEejJ6cVRhV2E4TndHeHJldUxpUWdSeW91OGpBSVB1OGhnb3d0eDNj?=
 =?utf-8?B?dU9KRnplM0V4VzhuWUZkV005eFM0b21XMTR2SE1md1FNWDZ3eFRLS05BbkJv?=
 =?utf-8?B?OWhhQ25aRWxOcktlQ0RZTTVIenBPcTBWUkIyd1kyVEgzMFo4akhTWkRnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THVJeStoc1RZdkk4OWNEWXR5dFF0N2dUNzg1SjcvSXB6STVBd3FaSXNNMVJ0?=
 =?utf-8?B?L0QzTFpWb3gyVXJLUXpJbWp5emxaWkF6MVI2aTVnY1VINndOY1lqeTExamVH?=
 =?utf-8?B?UXBML2NoUXJrbWtNVHN0K2lRZUFvV0EwYWVaNHBCUjF4ZjBiYUZiNkVDT25W?=
 =?utf-8?B?TEpjVmFFNjhTQkdUM05XNmduSXpMNzN0K29qc1ArMk9qV1pFN0QzUkY0TENz?=
 =?utf-8?B?anVtbUJTSDAwQXM4UEpwZnBQLzVHNDZ2YkJWQmk2dDg4SmtTMWM3MlFOWFo1?=
 =?utf-8?B?VWE3d0pQVStoVm5Kcks0dkdOTTU4bmhKUW5VMTcvRVhXaWtVMlhhanlSMU1U?=
 =?utf-8?B?SkdkRVNoN2JlaTB2SkZwWEhITjRiSUhwUjBJNDB3Uk5Cc2laSERUQU9LeThS?=
 =?utf-8?B?aGtjaXd4Z1hkbkNWN2lNWm4xN2c5Vk5ESWsrSWt6aXovSjV1VWt6ckNZR2dn?=
 =?utf-8?B?NXdqMk9oUXUxa2tXVUViMkJoRlk0ZkVtejFjRFNwcml4Z2NaQjFjZElYVWtj?=
 =?utf-8?B?b3hZeFA5S0NXNDFmRm5sbVZHZmE1TFpIeEFLQWd5ZHJ1OFRxbncySlpTVXRE?=
 =?utf-8?B?NnlvYzR2OU9jdXFDcnRjMzluOGp4eHdHRm5OTy82MUZqVmMwbGs5bE56eHkx?=
 =?utf-8?B?Z3NXN2ZBcnZ3R3lGZnYySmswU3Yxc0p2R0lYNVFRamc4V3I4L0orU3M4QzlH?=
 =?utf-8?B?NTg4ZEFVaVpkZnRtMTNQUWlGb3RqeW1SRWVacmR2YWs2Y3c4M2kxU29TS0Rv?=
 =?utf-8?B?UDBCVStSV0hGUU9MN1ltTXRTNzJUdW9jTytoZVRDaWRtdW9VeUZGVW9WNTRi?=
 =?utf-8?B?c3RwRlQvSEU0dGxQZnIyb2lDUUdMVUZPM0kvY2I0SEhDUEp0STVSU0lwL1ph?=
 =?utf-8?B?TGV6SnZSRlF2Skhja3luS3NET2lqc2xNM1k5am5yaTdDa3Q0WE9mR25lMllW?=
 =?utf-8?B?S3BxeHN5ck1sR0ZrOUpmakVjaWVlRW9LOFJ6U0NSaHVaRUlESjg0M1p4WUxR?=
 =?utf-8?B?Ym5FdFVZS1ZadHRZQ25NZHFxV0xsMTR4M25UQVprMEQvK2huanRJdVZlOTVE?=
 =?utf-8?B?Z3lYZGY4RWlIMS9QTWdYNnlWazQ1NHliWnh3eDd3QTdCUEZmOFBZZlN0RXIv?=
 =?utf-8?B?TEVIZ2RpQlgrcXlJWm1Ha1MrK1kzTzZjTDR1R0RDcTVUTUFHdHZUZnJIangw?=
 =?utf-8?B?c1RwZUJ6NFBpcTg5Z1dSRHNJT2R6WDdnVGlaT1R0UWJmbDR1cENRZkdxWmoy?=
 =?utf-8?B?OUVsdFhiY3U2by9KU1MvNWw3c2J1SFFLSjd4alV3NUNGcmFYVURvR2xkTTJr?=
 =?utf-8?B?V2NNbFB4cDh5OFVkUDlxWm1aVldhUWtuaHgyMURjQmZ3ekRRN2JsZ2VyS1gv?=
 =?utf-8?B?UW1FQ0hadDlQd3FYTHRpMndUM2oyNlZzaDNXTDN6UW8xZ043ajA0L3JzdVhl?=
 =?utf-8?B?UkxmN0JJQ3dtekJURGhZWFZEMTg3NjI0d2RRYnhma29Zbi8zclNjSlpZcXFJ?=
 =?utf-8?B?RnJpbWZLclpCY0lqR0I0Z0NyYVdDTVp1TXZZdXVmTFFXSTlucjdVOFNnL1dO?=
 =?utf-8?B?Mm5KUzJtb0drbmR5ZTlXM21MWWRZcFdWRzYzb0phdDJLRkFNZDFOOVNZRDk1?=
 =?utf-8?B?REVhVDN4MkQ4YWV0VDdwN2RqWjdBZTBjWDAydUxjb3d3eDNpekxZcnM3aGVF?=
 =?utf-8?B?Z0ZGL0dRRlhXak9ORmRMQVB2NnMyb0tiUjBoV2NoRGNKeWJoTy9pR1dRRkhm?=
 =?utf-8?B?anZMK1V0cUJMd3o2dGVIZkoyaTZNeUNnbUFrenY2MFRiMnJNZFBQWGdKVUNq?=
 =?utf-8?B?SzFPQ0N0azgxeFZVVnlnUzZLbnlGbDdjaE1TRXYxZ0dJMTE2K2phVmw4RERR?=
 =?utf-8?B?M0RubnBvUGFMbTAzakpGTWFhYkk0azZuRFRXWkNtS0U0RmpNZTlhTHUyWTdy?=
 =?utf-8?B?QzNwcVJEZC9aNE16eWZEZU5TcExKcktCRHdTRnBHeGVUczhaNHVodVJST09I?=
 =?utf-8?B?VC9YQzhpYkI0MmVPU0tDUWdTczI5RVFMSXo0OGRTZUFhWDVETTNINElldW1V?=
 =?utf-8?B?UmoxdFBiTG1yV3RFQm1Fdnc5citZeG1BYWQ0RUUxK1lqS1pZc1BSU2FaR0tj?=
 =?utf-8?Q?E+rN/6XsQihnggIyv9PhHyM9e?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76722a70-d938-4b72-b155-08dce42d9323
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9213.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 04:32:38.6942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSShWA0ke0jTgJji8J4+KHV0ghJCUEMS4VGxe1GtYYOEQWul5udzQ3JnXuZFcfOaX8AwJl+NnYKEOz1XmNnCiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222

On 28/8/24 02:59, Nicolin Chen wrote:
> Introduce a pair of new ioctls to set/unset a per-viommu virtual device id
> that should be linked to a physical device id via an idev pointer.
> 
> Continue the support IOMMU_VIOMMU_TYPE_DEFAULT for a core-managed viommu.
> Provide a lookup function for drivers to load device pointer by a virtual
> device id.
> 
> Add a rw_semaphore protection around the vdev_id list. Any future ioctl
> handlers that potentially access the list must grab the lock too.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>   drivers/iommu/iommufd/device.c          |  12 +++
>   drivers/iommu/iommufd/iommufd_private.h |  21 ++++
>   drivers/iommu/iommufd/main.c            |   6 ++
>   drivers/iommu/iommufd/viommu.c          | 121 ++++++++++++++++++++++++
>   include/uapi/linux/iommufd.h            |  40 ++++++++
>   5 files changed, 200 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 5fd3dd420290..3ad759971b32 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -136,6 +136,18 @@ void iommufd_device_destroy(struct iommufd_object *obj)
>   	struct iommufd_device *idev =
>   		container_of(obj, struct iommufd_device, obj);
>   
> +	/* Unlocked since there should be no race in a destroy() */
> +	if (idev->vdev_id) {
> +		struct iommufd_vdev_id *vdev_id = idev->vdev_id;
> +		struct iommufd_viommu *viommu = vdev_id->viommu;
> +		struct iommufd_vdev_id *old;
> +
> +		old = xa_cmpxchg(&viommu->vdev_ids, vdev_id->id, vdev_id, NULL,
> +				 GFP_KERNEL);
> +		WARN_ON(old != vdev_id);
> +		kfree(vdev_id);
> +		idev->vdev_id = NULL;
> +	}
>   	iommu_device_release_dma_owner(idev->dev);
>   	iommufd_put_group(idev->igroup);
>   	if (!iommufd_selftest_is_mock_dev(idev->dev))
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 1f2a1c133b9a..2c6e168c5300 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -416,6 +416,7 @@ struct iommufd_device {
>   	struct iommufd_object obj;
>   	struct iommufd_ctx *ictx;
>   	struct iommufd_group *igroup;
> +	struct iommufd_vdev_id *vdev_id;
>   	struct list_head group_item;
>   	/* always the physical device */
>   	struct device *dev;
> @@ -533,11 +534,31 @@ struct iommufd_viommu {
>   	struct iommufd_ctx *ictx;
>   	struct iommufd_hwpt_paging *hwpt;
>   
> +	/* The locking order is vdev_ids_rwsem -> igroup::lock */
> +	struct rw_semaphore vdev_ids_rwsem;
> +	struct xarray vdev_ids;
> +
>   	unsigned int type;
>   };
>   
> +struct iommufd_vdev_id {
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	u64 id;
> +};
> +
> +static inline struct iommufd_viommu *
> +iommufd_get_viommu(struct iommufd_ucmd *ucmd, u32 id)
> +{
> +	return container_of(iommufd_get_object(ucmd->ictx, id,
> +					       IOMMUFD_OBJ_VIOMMU),
> +			    struct iommufd_viommu, obj);
> +}
> +
>   int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd);
>   void iommufd_viommu_destroy(struct iommufd_object *obj);
> +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd);
> +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd);
>   
>   #ifdef CONFIG_IOMMUFD_TEST
>   int iommufd_test(struct iommufd_ucmd *ucmd);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 288ee51b6829..199ad90fa36b 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -334,6 +334,8 @@ union ucmd_buffer {
>   	struct iommu_option option;
>   	struct iommu_vfio_ioas vfio_ioas;
>   	struct iommu_viommu_alloc viommu;
> +	struct iommu_viommu_set_vdev_id set_vdev_id;
> +	struct iommu_viommu_unset_vdev_id unset_vdev_id;
>   #ifdef CONFIG_IOMMUFD_TEST
>   	struct iommu_test_cmd test;
>   #endif
> @@ -387,6 +389,10 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   		 __reserved),
>   	IOCTL_OP(IOMMU_VIOMMU_ALLOC, iommufd_viommu_alloc_ioctl,
>   		 struct iommu_viommu_alloc, out_viommu_id),
> +	IOCTL_OP(IOMMU_VIOMMU_SET_VDEV_ID, iommufd_viommu_set_vdev_id,
> +		 struct iommu_viommu_set_vdev_id, vdev_id),
> +	IOCTL_OP(IOMMU_VIOMMU_UNSET_VDEV_ID, iommufd_viommu_unset_vdev_id,
> +		 struct iommu_viommu_unset_vdev_id, vdev_id),
>   #ifdef CONFIG_IOMMUFD_TEST
>   	IOCTL_OP(IOMMU_TEST_CMD, iommufd_test, struct iommu_test_cmd, last),
>   #endif
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index 200653a4bf57..8ffcd72b16b8 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -8,6 +8,15 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>   {
>   	struct iommufd_viommu *viommu =
>   		container_of(obj, struct iommufd_viommu, obj);
> +	struct iommufd_vdev_id *vdev_id;
> +	unsigned long index;
> +
> +	xa_for_each(&viommu->vdev_ids, index, vdev_id) {
> +		/* Unlocked since there should be no race in a destroy() */
> +		vdev_id->idev->vdev_id = NULL;
> +		kfree(vdev_id);
> +	}
> +	xa_destroy(&viommu->vdev_ids);
>   
>   	refcount_dec(&viommu->hwpt->common.obj.users);
>   }
> @@ -53,6 +62,9 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	viommu->ictx = ucmd->ictx;
>   	viommu->hwpt = hwpt_paging;
>   
> +	xa_init(&viommu->vdev_ids);
> +	init_rwsem(&viommu->vdev_ids_rwsem);
> +
>   	refcount_inc(&viommu->hwpt->common.obj.users);
>   
>   	cmd->out_viommu_id = viommu->obj.id;
> @@ -70,3 +82,112 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &idev->obj);
>   	return rc;
>   }
> +
> +int iommufd_viommu_set_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_set_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_vdev_id *vdev_id, *curr;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	if (cmd->vdev_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	down_write(&viommu->vdev_ids_rwsem);
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev_id) {
> +		rc = -EEXIST;
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev_id = kzalloc(sizeof(*vdev_id), GFP_KERNEL);
> +	if (!vdev_id) {
> +		rc = -ENOMEM;
> +		goto out_unlock_igroup;
> +	}
> +
> +	vdev_id->idev = idev;
> +	vdev_id->viommu = viommu;
> +	vdev_id->id = cmd->vdev_id;
> +
> +	curr = xa_cmpxchg(&viommu->vdev_ids, cmd->vdev_id, NULL, vdev_id,
> +			  GFP_KERNEL);
> +	if (curr) {
> +		rc = xa_err(curr) ? : -EBUSY;
> +		goto out_free;
> +	}
> +
> +	idev->vdev_id = vdev_id;
> +	goto out_unlock_igroup;
> +
> +out_free:
> +	kfree(vdev_id);
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);
> +	up_write(&viommu->vdev_ids_rwsem);
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}
> +
> +int iommufd_viommu_unset_vdev_id(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_viommu_unset_vdev_id *cmd = ucmd->cmd;
> +	struct iommufd_viommu *viommu;
> +	struct iommufd_vdev_id *old;
> +	struct iommufd_device *idev;
> +	int rc = 0;
> +
> +	if (cmd->vdev_id > ULONG_MAX)
> +		return -EINVAL;
> +
> +	viommu = iommufd_get_viommu(ucmd, cmd->viommu_id);
> +	if (IS_ERR(viommu))
> +		return PTR_ERR(viommu);
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev)) {
> +		rc = PTR_ERR(idev);
> +		goto out_put_viommu;
> +	}
> +
> +	down_write(&viommu->vdev_ids_rwsem);
> +	mutex_lock(&idev->igroup->lock);
> +	if (!idev->vdev_id) {
> +		rc = -ENOENT;
> +		goto out_unlock_igroup;
> +	}
> +	if (idev->vdev_id->id != cmd->vdev_id) {
> +		rc = -EINVAL;
> +		goto out_unlock_igroup;
> +	}
> +
> +	old = xa_cmpxchg(&viommu->vdev_ids, idev->vdev_id->id,
> +			 idev->vdev_id, NULL, GFP_KERNEL);
> +	if (xa_is_err(old)) {
> +		rc = xa_err(old);
> +		goto out_unlock_igroup;
> +	}
> +	kfree(old);
> +	idev->vdev_id = NULL;
> +
> +out_unlock_igroup:
> +	mutex_unlock(&idev->igroup->lock);
> +	up_write(&viommu->vdev_ids_rwsem);
> +	iommufd_put_object(ucmd->ictx, &idev->obj);
> +out_put_viommu:
> +	iommufd_put_object(ucmd->ictx, &viommu->obj);
> +	return rc;
> +}
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 51ce6a019c34..1816e89c922d 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -52,6 +52,8 @@ enum {
>   	IOMMUFD_CMD_HWPT_INVALIDATE = 0x8d,
>   	IOMMUFD_CMD_FAULT_QUEUE_ALLOC = 0x8e,
>   	IOMMUFD_CMD_VIOMMU_ALLOC = 0x8f,
> +	IOMMUFD_CMD_VIOMMU_SET_VDEV_ID = 0x90,
> +	IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID = 0x91,
>   };
>   
>   /**
> @@ -882,4 +884,42 @@ struct iommu_viommu_alloc {
>   	__u32 out_viommu_id;
>   };
>   #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
> +
> +/**
> + * struct iommu_viommu_set_vdev_id - ioctl(IOMMU_VIOMMU_SET_VDEV_ID)
> + * @size: sizeof(struct iommu_viommu_set_vdev_id)
> + * @viommu_id: viommu ID to associate with the device to store its virtual ID
> + * @dev_id: device ID to set its virtual ID
> + * @__reserved: Must be 0
> + * @vdev_id: Virtual device ID
> + *
> + * Set a viommu-specific virtual ID of a device
> + */
> +struct iommu_viommu_set_vdev_id {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;

Is this ID from vfio_device_bind_iommufd.out_devid?

> +	__u32 __reserved;
> +	__aligned_u64 vdev_id;

What is the nature of this id? It is not the guest's BDFn, is it? The 
code suggests it is ARM's "SID" == "stream ID" and "a device might be 
able to generate multiple StreamIDs" (how, why?) 🤯 And these streams 
seem to have nothing to do with PCIe IDE streams, right?

For my SEV-TIO exercise ("trusted IO"), I am looking for a kernel 
interface to pass the guest's BDFs for a specific host device (which is 
passed through) and nothing in the kernel has any knowledge of it atm, 
is this the right place, or another ioctl() is needed here?

Sorry, I am too ignorant about ARM :)


> +};
> +#define IOMMU_VIOMMU_SET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_SET_VDEV_ID)
> +
> +/**
> + * struct iommu_viommu_unset_vdev_id - ioctl(IOMMU_VIOMMU_UNSET_VDEV_ID)
> + * @size: sizeof(struct iommu_viommu_unset_vdev_id)
> + * @viommu_id: viommu ID associated with the device to delete its virtual ID
> + * @dev_id: device ID to unset its virtual ID
> + * @__reserved: Must be 0
> + * @vdev_id: Virtual device ID (for verification)
> + *
> + * Unset a viommu-specific virtual ID of a device
> + */
> +struct iommu_viommu_unset_vdev_id {
> +	__u32 size;
> +	__u32 viommu_id;
> +	__u32 dev_id;
> +	__u32 __reserved;
> +	__aligned_u64 vdev_id;
> +};
> +#define IOMMU_VIOMMU_UNSET_VDEV_ID _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_UNSET_VDEV_ID)
>   #endif

Nit: "git format-patch -O orderfile" makes patches nicer by putting the 
documentation first (.h before .c, in this case) with the "ordefile" 
looking like this:

===
*.txt
configure
*Makefile*
*.json
*.h
*.c
===

Thanks,

-- 
Alexey


