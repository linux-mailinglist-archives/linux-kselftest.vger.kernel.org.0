Return-Path: <linux-kselftest+bounces-32818-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A68FAB23DF
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 14:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC93A9E50F8
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67808257438;
	Sat, 10 May 2025 12:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y45UpuRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2080.outbound.protection.outlook.com [40.107.96.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965451A83F9;
	Sat, 10 May 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746881532; cv=fail; b=VOVg/RLPZEG7ckEQxNALjRCYAPHANoaud/qymaE+gKFaiF2d1891ejYG95DZyCWaUrWCUA1QQIBZgSNOzhpCAlcmwIQ5AAyk4+UAZyUCJPAEY0C93tkvOZDjrlOvQ1WhH6yvm5Xsdo8gnUx1vzl5scZUH8/yWMtjX1flq7wvJVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746881532; c=relaxed/simple;
	bh=GssX6BRqjCBbg9xyVL/yKBpil81neAPsc/xTlGx4f4A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QoC2Qs1k51QL0I+r7mjgMimwmstRCyg1hon4g1I1jFlTYUUmPoSBQUahyRp/jbXIPY4EfT70OxEbqfZg3Onmc7xfAQtVphxymR81uG8NkDdavbDw04+6YBwv+9oXFhbJW2DTjZFQ609a4LH3JpNhuvUi2O5DFYfTIeg+WjBZ85E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y45UpuRM; arc=fail smtp.client-ip=40.107.96.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OVbNmM0nAUNYdwq9jhYs1oW63BGsrfYeXZd6lhmijikgBqBmSp6cieGCGR3u0kq162wfS2FPTN6CGPaU5rd055JXP7yHgafwYKsXJ1998DEpBghYYQg0iogOggcrlLvMCn0PxjRHRbKcbVsErAzoc8vWKktUk3Z1vHDX+FDhbHQcTOSnUuXRBCqIr2OBeIEAhpIfSxEHaw7rSl2tbfCDl8vAH36cuaA0HPuonzevSCNxYACfZPz7j/W4nwILTrtysXjjDeyEQ+9wJFp4ejCoMgq62IGNPR0mcM4BVUc/pFmUpzaX30dGumFOrKGr/22PVmVGXywXsvOY5MYQZP52QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYR40e5pLexCThCphO/uZN4O2c8r5btNU/drngop+yA=;
 b=UWHf5C1w2BYd+Hbb+JJ6+eWk8/xfFG3Rt0nUfOUATqeaucme12RjBy5eITakOSpwCo+h8TqR1NQ4L1kJyBK+6pAAyQ3ydDXBLiWqVKTWuLaBl8fUxw6t47fzyNyUAj9ZpJl4SWas7+y4ZDIcz8gBdzWdfKRXTtBDe1bu4Bt7rls/i0ooC47pcElXnkVRNzqDq0B09pnbqU4OGs7zJexyFjH8qwQEzH+67mHZENiBjSIyN1AxPplfNKYyeLS2NU4rdXPdJ8D9DmLEmc3lcD7vmK3XIDEb2PxJcwAujGOoZ1lGswOD8DXAYcIDsJbdNdTYTQ2QyaYnzy2/49RJCtbGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYR40e5pLexCThCphO/uZN4O2c8r5btNU/drngop+yA=;
 b=y45UpuRMbCe5oWPZBV5oBnoxMoz/vayGS7ICpsiC0AASrzj1wcbSvxU8In41xtXROMhtw3ClMfHzh7uvDZ1+6oraH68sn8msLLcYkFPDitkx0JFyM9AUzR0lUQZrTLNai23ThXnm//bu9w7qVsOB9mMlZ68iOEHdpHU7Add39Pk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by SA3PR12MB7921.namprd12.prod.outlook.com (2603:10b6:806:320::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Sat, 10 May
 2025 12:52:06 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%5]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 12:52:06 +0000
Message-ID: <e574e1d0-b003-462d-9a59-ef16e95b7766@amd.com>
Date: Sat, 10 May 2025 22:51:58 +1000
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
References: <35701c5e-030a-4f52-b6f6-ed18368fb2cd@amd.com>
 <20241004114147.GF1365916@nvidia.com>
 <95ab62fa-bb1c-4e4a-a210-b0bdba0d4ad2@amd.com>
 <aBHYN39FcH+NG5Ab@Asurada-Nvidia> <20250505170807.GP2260709@nvidia.com>
 <aBl5uLOFCntuIYYz@nvidia.com> <20250506125847.GA2260709@nvidia.com>
 <8e0182b9-7a8b-4388-9f22-c39bfbaf3df1@amd.com>
 <20250507122411.GA90261@nvidia.com>
 <76ac7908-45d7-4821-b34c-a5d2ee49c7d7@amd.com>
 <20250509220717.GE5657@nvidia.com>
Content-Language: en-US
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <20250509220717.GE5657@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:806:122::18) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|SA3PR12MB7921:EE_
X-MS-Office365-Filtering-Correlation-Id: d84f9feb-6e6c-4d55-3720-08dd8fc177e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NjRCdlhkTWxONXVQOVhJdlE5bENSUnljYzNSckZiMEdLRGpsbjZ1amNoNXNa?=
 =?utf-8?B?Q0tVNzBPMjJ1OGo5NnlNUVBDL0I2Q21SY1MvTHJKd3IvT1NYdVhtRVlKdG1h?=
 =?utf-8?B?UmtpZkVIYWpGamI1dEkyUWprWXhFelBFYUg3MG9uNEM4NTdyQXlJc0pIeGNs?=
 =?utf-8?B?dDV0YmVCS0ZqblhPS0lTRVo1VVBQdEE1L1k0a3VaYUJQanNQa3FvVWoyNzV4?=
 =?utf-8?B?MkhjU2k3MGhkSXloV2Z6cjh5czhEeUMreEJ5YWNrR1NEUWxZckRpWXBwSE4x?=
 =?utf-8?B?WFQyY1BNT0pseGhDWkorU1F1b2pnUWJycWJvenFMdUpRQXZnaXg0cWJQVUtJ?=
 =?utf-8?B?U2lpWG5IY0xoT09lWVNyZ3FvdVRCT1o0dUhEajFrRUVUZVN2ZGV4RElYKzdO?=
 =?utf-8?B?NTdDWjYrbllWZjFTMHdGOHdlYTdtUDZrUnJ5U2RrYXI4ZmRVdE03WE1MdHNV?=
 =?utf-8?B?RUxaUnM5N2JCZjBtTTZJaktnR3FHVERlTXB4SklveS81M1ZCek5XK0I1TkE4?=
 =?utf-8?B?Qk95cFltcWFVYW9HRUFmTFpzRFhvbzBXb0puaG5NZ0tCbVBsMytPa3Y2bGU2?=
 =?utf-8?B?anJSWUJ0TEswbC9weHNrVkR1dG5SZUY4TUpFaS9pWEwwekdKdHMyYkxJVUdY?=
 =?utf-8?B?ell4ZEtBejVkU0dqaTdoRGxUTEdiOWRHTkhCVlJRRHJuN3FUbTY1a1RjczZB?=
 =?utf-8?B?MWNoS0tFTXFTWGl2OFVGUU52UG1SSXg4di9jNTA0OVp3UkVXcXE2cFBaRmtM?=
 =?utf-8?B?Sll6UDZJanVKT0NqZGNDVUpqRVR2R1Vwcnhjc1hyOEhSVXJXcEJRQ3JhMHhF?=
 =?utf-8?B?TkwvY0ZDMVpuTEFESngwcDVDdFdVaUUxeU9Nd1FtWmMyWm54Q01DVUdPbWlU?=
 =?utf-8?B?R0dPQTc4M2ZhM0VtbHphbkpocUNLTkRRTVczZHVySjNmWkNWRy9NeTNoQnNO?=
 =?utf-8?B?SVh6WSs4cnhzcVdxdExsb08xQkdWbm9DRFJxS2dQZU50VFNmNXNMRTlqV1RX?=
 =?utf-8?B?d0xldXptRUs0NVkxVGxmV1pDS2pyVTVBSjZmaUVPNmY1QW02eHZxSzVra3lN?=
 =?utf-8?B?YjduRmFsS3NVcjVlcXk4dktqMTJYcnBpUzYzZUhhcm1nbUYxMG91Q0UyMnpm?=
 =?utf-8?B?YUNRRFNCRzJKVzM5RW1jWkhKWVU2WnJhWVJHenVhUlpjSnIvNm1CYzhnMjRn?=
 =?utf-8?B?eEJ0U1YrUTI5SUdzY3hkUkVZNGczVmRXbmc4TnJTV1FBdHhUZldiUkc1ZW01?=
 =?utf-8?B?eVdRdTVVZThWaGxjTHc0SFhESnc5VE1aSG5GeG16TDZPRThuMXlJdWRHVGtN?=
 =?utf-8?B?VFlhclg5THowY1NKUW5tUlMxQklBSEY5cHJFVXNmR2RYbXRWbmM5ekdsdlFL?=
 =?utf-8?B?UXM4ck1OcFJQSzV3YUdVQ2dETWFDY2VLdnBsaWYrbHJSQXNodjJpMk9WS2tM?=
 =?utf-8?B?UXBMczU4Y1Q4ZmdWaEJHTDgrUDF4dmNaRFN2VUtoRTdudE1hZHp4QjNCV2FC?=
 =?utf-8?B?S0J6amQrdGcvcVptNGh2aXdjSVUvTHNvM0ZPSWVrdjZNSVJhbzNrZWZtbk0y?=
 =?utf-8?B?cjZaVHpDTGlSMnAyU1V2ZW5UYzNNQ1RsanFMQXhVYXRzM3g4Q1NwZG9yZGJz?=
 =?utf-8?B?WitRMjlWajhsMWorY0d6RzhFM2hXMnp2QWM0dWdYMFQzS0h1ZmlNa1F2RFNC?=
 =?utf-8?B?K0ZLSEk2TG9qSmg3ei9BZXM1eU16a0p6bUo4Y2UxVjVOdEFwUS82NjUyYUcz?=
 =?utf-8?B?WGtzaE51MWpKVjhocEt4Uy9BbEtaM1llRUhlOEQyRGFpWHhFWFdBUm83dHRS?=
 =?utf-8?B?WUdORkFMTzdiRTB4QXdQR3VNbUhmaGx2VzhZdHdQZlNBM0F4UHYyQldYL0lE?=
 =?utf-8?B?V1NXSnJmOFRBdzlTNW9HUEx2RStEUXg4UFZVM1dYR2RwZ05aRERkeHJaR1Zk?=
 =?utf-8?Q?IDKkNQ/FXFY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHMrWlJweHhaWlcvRkdXMDcxcUxPTUdPYllZd3ZMeE91cVJlTHZUbzlpUlJY?=
 =?utf-8?B?SW1rMU12dE9CTVdxSWhEWEZ5TG5MblZ5MkJvL1lUak4rcEV3WG1HTjM4OFNl?=
 =?utf-8?B?VEkraFg3TjMrUU11aTNObFlCaDhBQ1VDVlpQU0FUa3d4bnByV29HeWRkZzMv?=
 =?utf-8?B?eElYRnVybEJUMG1rU1k0OEQrKzk0alBBcXl4ejdzNXR6aHVHVDRGbjFHTUZG?=
 =?utf-8?B?WisxajFyR0RCU2szUnJlYzgzdGtpMytTbXRPQmUyQUlPaThCZ2JTb2tRcC9w?=
 =?utf-8?B?V3l1T2xaU0VjOFV1WU8vZGh1TUtMY3c1Y01Ock8zMUw5SjlYUExUWEM0bTF2?=
 =?utf-8?B?c0lMN1dVQml1V2pVL2FwTVlQWkZjbkxQbkwwUVJmTE5IUnVhaHBOQ1NUQms1?=
 =?utf-8?B?VnJKNnZ4dmVwUm43UVdoUHBDa3JKNmsxME1PSUVRR3dlNC92eFBsMDBiU0VU?=
 =?utf-8?B?QUlmWCtyRm9tcndqNWdFVzdXaWtCWG1aVzZUSjM2QlFjaU9BV3AyZHZob2po?=
 =?utf-8?B?NVZwRzVCMDI5NXU3a3JGTllINGs4TjY4WkNUaE1xeEIzU3YzMXN1TUkzcjVF?=
 =?utf-8?B?WUMvc25oeWp1NEt0d3ozN25YdHV0eGdEYzlqL280MWlueXF2SVQ3QVF5QU9U?=
 =?utf-8?B?azdFbGhwUE1CWHVxL0UyYmUwc2JEVWZsc0hZREdvbWZoVmEwdERZTzllMVA1?=
 =?utf-8?B?VmFqOHQwR2JrVG9WQ0JiM0lXVElPTDJKT21iaWV6cDZxTHhJNUdwT25LU2FF?=
 =?utf-8?B?QTk4TFV1SnFKZ1NvK2s4UXVMUm1GNGh3NnduRkROSXRoN0JHNEovRWVURThC?=
 =?utf-8?B?OHdwR2Y3VmJCaFBkMW1EUDZTVm44MTFGQlRJVWRkNGdsbkNGQ2t5bk9wUmpq?=
 =?utf-8?B?OXNMSzJFY3RzTGl0ekdTQmdrMEk0aGRtUS9Vcy9KbDhwdUVHQU9PdUR6K3dU?=
 =?utf-8?B?ZUIwbGsxRnNrMFJwQVZZR25FWDZvNHhTRlo0ZkFkTEJ0bVBqTWFRclBVREgv?=
 =?utf-8?B?dzQwRHB2NE1xRWdGSEpCVzBmdVRodTVaYm91K2w4U3Z5VEFzZVhqM3BYT3NU?=
 =?utf-8?B?QlFCSisvM3hKSXpFdVhnSDF6dUo3Q2hSeWNNaC9ESzFIbkZIdVV3YTFuRFlz?=
 =?utf-8?B?blg0K2NVc1NNejJVRXFwU0NoN0NoUklvK0czK24zQmEydy9ZNnNzSkZwMEU5?=
 =?utf-8?B?ZHBsVmtGN1l4QXRUZnlXcjIvMzNyTERYZ0dzb1d3UU50TlQvWkpUV2NZNmR3?=
 =?utf-8?B?b2ZtWXdhT2JmbjFEemdBR0RoLzZndzJRM1dPWENZa0V3WldhckVDdWsxV3dT?=
 =?utf-8?B?QXZNUWYxS2ZMc0ZySGt6czd4dW9ZalB6Yy83LzdVK1VRZExoZThhWW9halMv?=
 =?utf-8?B?TEhLalhNcnkrbUMvSmRXc2c2S3laV2VFVEVmdzZMeWR4L0FVb2szWUNiT1VF?=
 =?utf-8?B?MitkNXFiU3hkSkl4OThFOVpleVFVdEQxOFpIT0FmUDhhY2N3TWhkbE1vc282?=
 =?utf-8?B?d2llVUo4K0dzVGdKODV2UE5MeEkxMlFIUjgwMmZYWjN5eUFDVHJIaXZzOGFM?=
 =?utf-8?B?cmNTUW1DMGNVVnZUajRCc2RXVTd4ZndaUktMNCtEQUk0c0RnNVdveWRXR0Q0?=
 =?utf-8?B?UW45a25qaTkrRWgvQTNIYkpoajRWbGhkSVluZGFSQko4Sm9DWW5KMnp0cUVC?=
 =?utf-8?B?TkNRUldFSUlFTEtBWmZEcG9SWjBMZFVFSTYrV1ZEdG9mb3Flek5RTThsQy9U?=
 =?utf-8?B?VFhERlU1bHR6OXVENU1CMlh6NVZZYzhHNFArTTJuM2JEbkhZcFEyZC85dmxt?=
 =?utf-8?B?MWxzK1ZIZk0yalBFT0VKanJZT1BoTXFldGhZbSthcHQrUXMwWVEwL1IzQmEw?=
 =?utf-8?B?WldISmlPaVFzUjJqSDVXSHNTT0QzbXVVb0ZGWWpxNmtWWWozM0tXZ29Jd0lZ?=
 =?utf-8?B?T1I3V29Wc3EwSER0TXpSSkFxOHppWmhhRzZoWXFCaEV6UXo1U2lPUDdFMVdv?=
 =?utf-8?B?ZmJla2FxeTZrVUVhdU9BdlN2N2dOc2JiSGNPeUM1Rk1JMEhQYzZtL291TUNF?=
 =?utf-8?B?REdJdlYzOXNKSHkyU1pHZUpHUmpFSjdDb1dQWm8waDBJNWVpdDRXT2hJWUpO?=
 =?utf-8?Q?dE+e+zr824pSQLC3MaFZMyhoC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84f9feb-6e6c-4d55-3720-08dd8fc177e4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 12:52:06.1616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8jn53Dhl0S/HT7OCxrj1+JpysBw7yJ0u9nQcveN7/e9E8LN9FBkV0lWYYsjUMFP4Mz8y36ZVBn3JIc7l8FwmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7921



On 10/5/25 08:07, Jason Gunthorpe wrote:
> On Fri, May 09, 2025 at 12:57:18PM +1000, Alexey Kardashevskiy wrote:
>>
>>
>> On 7/5/25 22:24, Jason Gunthorpe wrote:
>>> On Wed, May 07, 2025 at 09:18:29PM +1000, Alexey Kardashevskiy wrote:
>>>
>>>>> We should not destroy the vdevice for something like that. In a CC
>>>>> case that would unplug it from the VM which is not right.
>>>>
>>>> vdevice is not directly seen by the guest, is not it? The guest will
>>>> see, for example, an "AMD IOMMU" and assume there is device table
>>>> for all 64K devices, and so on, it is QEMU which will be
>>>> reallocating vdevice in the host's IOMMUFD. Did I miss something
>>>> here? Thanks,
>>>
>>> I imagined the vdevice would trigger the CC call to create the vPCI
>>> function in the guest attached to the secure iommu.
>>
>> What is this vPCI going to look like inside the guest? There still
>> be AMD IOMMU PCI function and passed through to-be-trusted PCI
>> function.
> 
> However the VMM tells it to look using the arguments to the create
> vdevice ioctl?
> 
> I don't understand the question?

"We should not destroy the vdevice" confused me. It is not a device which a VM would see (or is it?), it is a QEMU/IOMMUFD object which we can create/destroy at any time (well, may be not, but the VM does not have a say in this). And then this vPCI thing - what is it, synonym to "vdevice" or a different thing?


-- 
Alexey


