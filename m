Return-Path: <linux-kselftest+bounces-32698-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD731AB081B
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 04:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24E51BA1E2C
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 May 2025 02:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D4C230BD6;
	Fri,  9 May 2025 02:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4LPDxxJG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B787E230BC7;
	Fri,  9 May 2025 02:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746759455; cv=fail; b=rYULaZoCTjaNuIr0ijMpXnH24hKwx9EVvq1Ah0zk36eypYh5pt66Q6MQPFdsZ5EoFrU5yvEdaLfZoFmTKPK0yida34CFhXzt29dV0KhD+HU3/FyPpK8qH0ngDtloxTTCvWoFJiHArnHbjrZfNZCx0Zyb7BMS/Gg8TmUz3qOYO+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746759455; c=relaxed/simple;
	bh=bSSoT6yyOyFIwj3QcEjAtFiXaCcwSX45Xb4wWtSlpv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qMkhNWJzzAxU9D10aL+pGxesNmOoyUL1S6WpdPakfISjV65Yn0zjB2oGtfDd4+o6Y1Ot1S4SRU3rviEgfrJZw14G7bhHrVr1yzryYfpAcUsquBvr3aWl5+a0zAt59hLUTiaPxO7vTcgKgcm47geDdI9D3CCKHRkR04KKQLPYC14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4LPDxxJG; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DJgcp4Q4mpQ9zZu0YptUD6ydDMHLLLvd7/qbzrTbr3Cmtljri2joKD4QH0HXg2pr30OM0CzzPw/YeUeKFaAF9HE34dlUJnvdScOVjZ5QAop1X/+HtkJfDlkcRXZ4+FYyHKRD+o/qAFahggrOgvjU3RuuMOMdNirrwQmDzJzMWKfkd0f4uA/vc8h5IO1U0GSwLtyT6R8i9VbPM/XSYDFVlUiB2GYcCuwZiS2h9SRStWfh62rcG8kiqnQjsx+KlFbrkOes53fZBoI9QtkjutTGzfEu56a0tLnYp+WzZPLbUwcNZ4Fsf+SShlbPgWEESHXy8fwAI0ONGkP621Ng+VF20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ax5aZo5QvRMAVZzUl06/QJIgZJqREZfPDMCVI30Iamg=;
 b=YF3Lop2KF/131ZiQCetLj+91lOTOjL3nwaqBNJmVPd19qr/q0dWaUMooJtBqXuNC2CjymROC/i80umtdaHFR1ApHwTflmljpy2IptgU20HordCKj3jy47gkOYweF62f9/QsN7EKXxNXNWwdHtbQVMxxAKmHlS0+e9wLb5N/BZmrRaDzwmb3z4lz4dNVI1mj2+tgV9nOVgaHHf9GVunTgefm3CYNJkC3FXoBdhxqhBL6jCpHHEhdRvp1jR2pwxAj4jQvma167WaaSrNVTs/KISFMGnhISKXGreJxZ0eM/PK2BAmXRlFUrwMtOgQzmYEo7w4nY6lg5N0O2Yu+DwXkksw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ax5aZo5QvRMAVZzUl06/QJIgZJqREZfPDMCVI30Iamg=;
 b=4LPDxxJGG0nBjVl0s9o+NplYCD2IjF3VFGodrwMo8u8V5KjRbb66t4IdTHa18udriqcW5O4JmZibya+MVZv2ljLUqVimqLjpnHxOboxGUeZt8ooakzJBqKTrv3p2mt85/lg8N9QITxXY/LcMtnB4MfkSD6Xrx1wZvdk6BlEcats=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 9 May
 2025 02:57:27 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 02:57:27 +0000
Message-ID: <76ac7908-45d7-4821-b34c-a5d2ee49c7d7@amd.com>
Date: Fri, 9 May 2025 12:57:18 +1000
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
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia> <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com> <20250506125847.GA2260709@nvidia.com>
 <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
 <20250507122411.GA90261@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250507122411.GA90261@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0107.namprd11.prod.outlook.com
 (2603:10b6:806:d1::22) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: ab32da3d-abcc-4ad1-bf97-08dd8ea53b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eUNNd1JwTlpUNjlEdTZRTWNyMGdveVA3Z2wydExMbHZWVmhtWC9wKzRmanZU?=
 =?utf-8?B?NUJ3dGsvQmdsUE9SOG9RVFJsaUpZY3VkWTFkY2JJVFFESG9EOFBodG5ObnNG?=
 =?utf-8?B?TDVNWFo5cUxnN1A5bDdNek40MFoxbk12dDBGSDdhU285ajdOQm93NTR6WFp1?=
 =?utf-8?B?MVZ0R3dNc29haWVuVzJPcTJRbmtPVEtrMFYxdkpGN04zSG5jcEFlWDJ1S1BU?=
 =?utf-8?B?SitLTUlRL0NQc1o2aTY0aE5tazNEeTFndXhWVnZiMnFCL0tQM2s4WGF4dlFy?=
 =?utf-8?B?cW1tRWdYTFlaVlpQUDc0Q2c4MXVJaXdVODV0TllzaEdNTnZ4UC9RWkVGMjB6?=
 =?utf-8?B?bXJlRXY5YlZqWlBSOE81R3RwajlRR2JOT3JYOGNFYlJuOTQxbHMxT2dUUlgr?=
 =?utf-8?B?WDl1NkhmQ2JHWnRIRmIrcnV4MjNOdnJWUWNGZEprbGFMTjdkNmwyV1hyRVdt?=
 =?utf-8?B?dG91RDNxTEhwWHZ1TXdtWm4zcVdQVjl0U2syaWZOcUw4VG9pWGdMTWwxK01F?=
 =?utf-8?B?OXVPZ3BCNjI1YkdHZUlYVDFCRStKeTBOaGpkeHBYYTBITWpIZU5IYWlEWnZ0?=
 =?utf-8?B?RFk1eUlhbXR6TnZLaUlmT2w1VmoxK0drSVFEbmkwTnRkRmUvRTJPckJoelox?=
 =?utf-8?B?Vy9RRDZUSkFwNHVWeGxyM0JiQTR6eEJTdlBaT3FUWVJaVXRiMkJ4ZjVhSS9s?=
 =?utf-8?B?MU9hbTJET3YxcTVMdVh3UUdhWVRIV2RzUmlYRzNNQndRNFR6UXoyQ1didUl4?=
 =?utf-8?B?ZUxpaGtBRUFNMXBUZVN5WW90aHhpRWdFMWtWTjd1MUlnR3YvMys1TVlRaGxv?=
 =?utf-8?B?MENOQ0srOWI5dmlqUXZoYjNtQkQ2UWNHSnhTd3lBVUkvTWd2RlAvOGdadWp3?=
 =?utf-8?B?dGlnTTl3QXo3dmZzTkU5UzdZU3NrdGRzZlNoRjdJL2JGYzBhVmFMK0FCbTBQ?=
 =?utf-8?B?djVuSEgvNjhoUWZwMnNiTjJKeFRmU0lZRnpsc090eHRHbzMza0hBYmkxRUJQ?=
 =?utf-8?B?ZmJVTTg5VVpQdWF0UDViMitRTnlhb3RHS005eXNablVXemUvUmlPanFUMWpX?=
 =?utf-8?B?eFZET0xLUmNUZjVvUjRwd2thNUhNN1NrcExYWjBhRE15bWpUNThiV2g1SmlJ?=
 =?utf-8?B?cjdyclFxZ0Q5SjlKSXUremw2dUNZNjV6Z2ZVUHkxMFBwaGxpVnMzM3U3cUZK?=
 =?utf-8?B?YW0vcXRnRUxlbUYwYnRHMlpBWVhBMzlFTGxXQWk2Y1JoRllRbGt3NzNKK1Nt?=
 =?utf-8?B?RkJFdGhVMHl5R2phZGd2cUs5UXlUSWFnOFRGeFpTbzZFamk4TGY4Z2hPRkcw?=
 =?utf-8?B?L3k2SWc0b0g1WXVKNm5OT3REK1p3UWl5aUdXY2xHSnpaQlM3QktNbGJNWWdJ?=
 =?utf-8?B?MDljcVAwRGhvTFVrTDd2bmpMMXJ4ZjNzWXRUZFBxWkp5bkQwa1RWZy9oVGR2?=
 =?utf-8?B?RFBzSGcxQ3ZPZjRiM0d1UXcxMklLVk1wSmVMcWxIcmFCY2xWdEFPUDQvWjJj?=
 =?utf-8?B?YzdOZ2FlbE1NeURjQWVjSDJaRU1RK2luSkg1TEZwZUoxbnZ0NitBdkRsRHFX?=
 =?utf-8?B?UThkL1d1WXV6WDhjQmVCYnQveDBtZDliZE1UN0JhNXFMVlcyTTJCbFVQK0xl?=
 =?utf-8?B?NE9iOHBlY1oxTFpuaFI4d3pPODNPQWZ2OVRrMjRFcXp5U1J0UmtzbjhVdDdY?=
 =?utf-8?B?UXhEL3NxWG5QcVdSaUllOUdiZ250RGMvT2x1QjFUVVlodVRObUcyQStyZkJE?=
 =?utf-8?B?bHlVM2ZqWEhrbVRFNjd5cUI1dUNzMTBpcDFnaHJDeFFqQVYvdkNxUlFXc1cv?=
 =?utf-8?B?bmRseFVoN3ArdWE0eUI4TXU5ZTVMbHNKN3FIM3NkaGV0dVo0Mkpqa0pZaUpM?=
 =?utf-8?B?VjFSVlgyeEErVWNKQ29pQzFpM1Naa1oreEpLVzY2bGg4WmloM1gybnBuUTZ6?=
 =?utf-8?Q?vYWdllGbeeU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWJyalNBNWMyMi9jWVY4aStZcitPaHZ5WmhMOXoyL2U2dUptY1NiMnQ2aVVr?=
 =?utf-8?B?eGRyT3pXejdwYkE3emlWQTcrd0szbHN6S0RMd3RTTXdFaW41WUJNU1RiTVZI?=
 =?utf-8?B?ZWExMEtwc0VmVEF1Q040aVQxZzJCR3VjM0gzaml3dXp3aHVEeG9aYlZ5SDNB?=
 =?utf-8?B?VXc5NUJLdUlOdi9RekkxclVLU28zQVJwZ2l0eE1zKzhsSnlWSGora3dOWkp3?=
 =?utf-8?B?dWNFWmlvRjAyR05MTUpTdFFKc0N4bXQxNHkxVloxZmJmMGRadUV0SW1xS0ZB?=
 =?utf-8?B?TXFtK3lubG5CdXRYK1RpNVEyTEFscWlJSkdGYWtiandwUnE4LzZ1Y2svK01z?=
 =?utf-8?B?cUZMV0UxM3V6eUxkSFB2RjJab1RhU3UzMVRNTG4waHJ6RlpJL3BReFFTR3dZ?=
 =?utf-8?B?N1NFQnFJYjBGWDR0eDJsalB2NVltSWNHbU40eTIwd0VYTSt0RDl0S3c2TkRB?=
 =?utf-8?B?dWVRQjhLZTlyRWliQjJMS1BGNVAzUTF6TmxPSjIrNmJoWVorMXBqM21ReEJK?=
 =?utf-8?B?N2JXVFlVbDh0WHE2VzJkamRpSkpEN3FkYWJjRlhQamFuZ3haNk9TZFJDZ3F2?=
 =?utf-8?B?Tm5QZUhPMGhaR0puZWp1K21WVFl4S2hDL2lkQW5MTXRIWFNRLzNRTzFJajgy?=
 =?utf-8?B?ZThMZU56WEZuZm5ZRjdnT211QkJIUEtGdW51UkViSmFtckQvV2ZnUEx4QTMr?=
 =?utf-8?B?Y0ZFTGhSUUxJeHFZRjlxc1BCSk45MjlpT05LODB5dndwZE9YSVNJZUFrRXNV?=
 =?utf-8?B?Nno0TFp6eXBxeXV0cWxyVlltQmsvTVh2d2NvU3F5eExnSUFESkpNUFgvRnov?=
 =?utf-8?B?RUdFcmgyNUw1akNrYTc1bCtFdGJmMmN6R09PWEZqOW16UG1Nd3RoYTd3bHRk?=
 =?utf-8?B?YXFCeFhjdHREZEdmczRYeHphckpCbi9Hc1BYT0RhZTdDVVZTdU1YRWNxQzhU?=
 =?utf-8?B?cW9KZU5qVmo3VUp6c1ZYKzlCTnNCWno5cWd3a1VZSXU3NFF1TmdTajVpTFRD?=
 =?utf-8?B?UFppdEtXZWNhUUp4VGlYdjQwRGF3bFdhU1AxcFBKS0hQMTlQU0szNUpmOWNK?=
 =?utf-8?B?Q2tKNzMzUjVjSDFKd1c3OEJmVHNyT1ZWeGNqaFFoZ0JvYlJrNysrSVZDdFo4?=
 =?utf-8?B?YVFFRlFFaG5lQ1g3Zm5PU3dlS0VJK2UySHFDTE10OHY1UVBUTmZnMTNidjRD?=
 =?utf-8?B?VVBzMllZMEZrVFExaHRXUWxwRmc1WGlFZHdkV2RXcHAwdHk3dXlvOXhUVStL?=
 =?utf-8?B?TE50L2VKYnFnbG5sODE5WVJwRU03QlBLa0liZWJINHIvUE5wckplbExoZ3dT?=
 =?utf-8?B?YjA0TzdQNDJxd3l5cnczSUZUVnNFSmFKOWZObHpJZHpaVWU4TGFSSVVNUnE0?=
 =?utf-8?B?bHVXbHB6aHB4ZktQaGJFM1g5RSt6Vm9QRjlEOWRGUEhYKy9rcDFUd0UwMWMy?=
 =?utf-8?B?TXE4cTBNRkdsTUUxNXMrb1A4bDJmYlcwMFRmVXZYQ3M5MFVjeXZXbWs3SFFK?=
 =?utf-8?B?YXJpbzJIdk1rQ1oxQlhYb3dEb2ViN3Y4dWkwL2wwRm9YclVPUitmVWFuSUlx?=
 =?utf-8?B?eWtZTWdBRVh2TjdKV0QzWVZSRTU2Vk0xd3FvLzQ5R2FiaUdoRmc2NDlvMWhY?=
 =?utf-8?B?ak1JaUgwRG5mY05CV2tWNVpBQXRvLzBiaVdBcWlIYnYwb1FocTRxZ1hNMmdP?=
 =?utf-8?B?d3RiMXR0SzljWG9XZllMbHJ2dDduYlAyaGFFTFZMdEdvbitBTjMyUEhEcERl?=
 =?utf-8?B?ekpMOVB5Q1AzcTdFbE4xY3ZCNXRqREdmRS9MUmN5Y1BsOVgrNWowSnpvU1l6?=
 =?utf-8?B?Z1Zxd0xYcEhobHRScE10Ly9VZi9WYk1EV2JlQnlzMTVpcWkwTUF0N01zQ01R?=
 =?utf-8?B?UnFyOFpWT2xZbTdMS1VwWGU5WXB4MXNyTjYvWUM4QUM5NENkSjFGOGthc0pY?=
 =?utf-8?B?MkhkU2t1Kzh2VC9GMDRHWTIvYTZ5OEkyOTVhM2tJNDNVWGZhcEoxRlA2Qy9I?=
 =?utf-8?B?ZkJpZGVQUzNJa3hmYzN0SkVVSHVhdjFjd05Ta3B4NEZtYTRZUWVFemxOZTlq?=
 =?utf-8?B?SDlEcTF2S0NBM1d5Qk5UdWR1anNTYmVmZ2NhdW9ONjM3Y2FnNVBXUjhuVURk?=
 =?utf-8?Q?hiUJmNRAnqmiw5biNY3e4jAe+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab32da3d-abcc-4ad1-bf97-08dd8ea53b28
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 02:57:27.1919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WbwnxCg/UCtajkLnvYHDMMbNldQRTKL/058yIG4RRqxbkhmJ02Sr7bNNRO/aq19tc7WLNkbiCca/s2gs9qd+tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673



On 7/5/25 22:24, Jason Gunthorpe wrote:
> On Wed, May 07, 2025 at 09:18:29PM +1000, Alexey Kardashevskiy wrote:
> 
>>> We should not destroy the vdevice for something like that. In a CC
>>> case that would unplug it from the VM which is not right.
>>
>> vdevice is not directly seen by the guest, is not it? The guest will
>> see, for example, an "AMD IOMMU" and assume there is device table
>> for all 64K devices, and so on, it is QEMU which will be
>> reallocating vdevice in the host's IOMMUFD. Did I miss something
>> here? Thanks,
> 
> I imagined the vdevice would trigger the CC call to create the vPCI
> function in the guest attached to the secure iommu.

What is this vPCI going to look like inside the guest? There still be AMD IOMMU PCI function and passed through to-be-trusted PCI function.

> At least some
> arches will need something like that.
> 
> The "AMD IOMMU" I expected to be created by the viommu object.

Right.

-- 
Alexey


