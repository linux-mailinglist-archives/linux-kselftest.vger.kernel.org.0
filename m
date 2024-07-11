Return-Path: <linux-kselftest+bounces-13613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB30192EEED
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 20:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FBEC1F21883
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 18:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A516D4FA;
	Thu, 11 Jul 2024 18:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hcdGKo5O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBE54657;
	Thu, 11 Jul 2024 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720722850; cv=fail; b=N+U7JDrkmHvl7vu6BvG9g7swhjFPkPFlhZYuFYmd0A0R0eUGbODezgDN5Nmc111R3IM/3WpzMxqWh+FYeu6Eg/mWl5iSNGl03NF66CyzM6Yc7aBIcgxewsxih/oLdtVxrm63tMYrqC+pW7kJEFZt55YdDDmZpN4mnW80NY2OoJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720722850; c=relaxed/simple;
	bh=JL+DXfyA4huJiPIIFHop8Gwcpv50KVdd7658E4BdS/0=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=rYV2fjFvJMQoBIw51PYKNrzNQKFJT8RXL89rmi94SAOChoKxm0emAzw9puaiK8PLmQtoJRtrh4MmgmuVvYDfo1oUbCzNJ274RsIGUG1nOkuzI4UAdFHwO97MCxhR4wYpnaCL6hVfrQ5MMSMxv9gweX8Hwle0fTBZJN+1GuaEdaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hcdGKo5O; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhtR0KbOFOzYjy7D87yJ6ExZwwoOQPYxIr8kWaq+Yw0xpW7fjfB+RVFwRz2BuwwgvKHhbQRmQv37c4TEGV6+fWecgTiacMQlouWUo2rYEgiGjh/aSBFiQClvm/1soqxEk5TxIcs1feqjZtcFiYrLflBmoG/KWeyb3EMH8RqArayi6BaYer4Cf92SMrAS3kjy3Recm9L5UCGPOawuYbH1j7i/rE4n53/V7calxuusE/wKSOb6dKxP77RDazkQPcE5jxnJHd/d8pvdfOpmNXegw/dQUn4wx5p4l2ctUYkLBRlxVfoZFJCvWeF2TYty2tlqrleFrTec1TrcBIL40LiZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9CXBSDTWGXzotAbofLRBo7ifBZ7eZmQUmnx7y64Uqw=;
 b=VWorAgY079dd82K5OJHjHdvCS4gEG/dKFCqVntW6aMnXyY8XujvBKNc7/v+1P7TVkHAit/0QLiU1jipmXgLiLLXAgENfvSq9wAopR7DI7pvGyQ0onnSqPi1X6AR4TdszP044H3I9ZSC2B1YmIm9gCBE2ka8QWD83FMZpmIfy5o+ezA04m7KjRAY/9YwmAbMyzzGCFZJ5BFlvPVb9zmOkJl5xCgWRKFf8pHxNvRCgYUb6Ci8o4m0S099niGxeGKwAYXfI/J4NRk5bzR9RQ6zAK31edLPqFQETZ/VlS4GjxFefL1ZeT1/InGnxzwFlKsvFZSqAaofvMab+HNY0BVe6LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9CXBSDTWGXzotAbofLRBo7ifBZ7eZmQUmnx7y64Uqw=;
 b=hcdGKo5OMEF6Fghv6EPM1AybIV0ww655nkenSs0iLq1Q5k8BpDDRD3vLhSzR2SplYdOTTEuwQv2o1hyQ5gf0JRW0azmpziZeJeCmBhtXBQITv7bQeYMBS87bqrUdz+4AIBdKpjzbB8S99RzZOdadgWlwjXsVXTA32DNgYgi4xrc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW4PR12MB6828.namprd12.prod.outlook.com (2603:10b6:303:209::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 18:34:05 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7762.020; Thu, 11 Jul 2024
 18:34:05 +0000
Message-ID: <8870ca39-f5a9-8d33-3372-77a6693ad739@amd.com>
Date: Thu, 11 Jul 2024 13:34:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, kvm@vger.kernel.org
Cc: shuah@kernel.org, michael.roth@amd.com, seanjc@google.com,
 pbonzini@redhat.com, pgonda@google.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240710220540.188239-1-pratikrajesh.sampat@amd.com>
 <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [RFC 3/5] selftests: KVM: SEV IOCTL test
In-Reply-To: <20240710220540.188239-4-pratikrajesh.sampat@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0176.namprd05.prod.outlook.com
 (2603:10b6:a03:339::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW4PR12MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: 967f62f2-1cb3-4bf4-c2ab-08dca1d80ad3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzBmL0JhTWI3TVhya1ZjNmVRRVRHd0RmakQ0RkdqdXJsMlg4MENpNFU1UC9l?=
 =?utf-8?B?SXlJZUFDK2lrUHUwbzZaWDJNZkdkR1hCWUNQQ1ArOWlnRnRDQTR0YUZ5ZGVK?=
 =?utf-8?B?dGxNSGxoN0NudWxSQzdrRnp1Zkgya1oxQWFRWmFIem8wRUNTK0JRaTg1Mitx?=
 =?utf-8?B?QWpYNmptZTJQVnp3QW56NGhoMGNiT29HT1VyYjdObFBnbmZ1dlFSR3l6QU1w?=
 =?utf-8?B?RGRkeS9SMnM4REtydzRXREF5M2szZFVSejNoSDRmZTNHR3drNkRZaHozZGdq?=
 =?utf-8?B?bkZFSFpRM3k3b0FFRzZNRWlyZ3JPLzVJdWpXaE1yTjUxd0NTOUZoODk4ejY0?=
 =?utf-8?B?TDBlU3VrQUpiQUZHRThxTHNqaDduY1NKRWMvWjlsU1ZQdUk0d21ENVdwazN5?=
 =?utf-8?B?N1ZDNlpadFN0YTRNbkRuN1BTWDFTYVpOQ1BDaXlyb09jc05JanNiY0FZemQ1?=
 =?utf-8?B?UmY5elNmTDNlOWZ5RE5qT0JGcVd4NllBdmtvblMzYkIxNTJLVnArZmlZb3N3?=
 =?utf-8?B?NFlwV2g4T3hZYWsxS04yWUVJN2YyS1FFWFpDMW5SNnRwam1ZdW00aDRzQTBM?=
 =?utf-8?B?K3Y5dVN5Nk5GM1hPSFBBWkVPa3AxYzRDandwekMvOHNHRUVWbjlzZEF2bCtH?=
 =?utf-8?B?VlowdlEzNnYxL2JiNVlUZG1EMmp3TVY1K3JRcHgzcGVEaGpCQmh1bUt3MVEz?=
 =?utf-8?B?MTJ1MmdncHdGL00wVVc1U0NLTW5ETTJNTmUydHNpNzcxUzZmUHhHL0J4L254?=
 =?utf-8?B?emtpVXNFR3k4WFdhejNsUVduYXZtWTRQc1N5WFVRUnY4Q1p3eGswdWYzZHVt?=
 =?utf-8?B?RFhicmJCOGZQVTMvS0h3ZzJSc0txby82NG12VFk1bHJGbHNxZmw0MlIvRDJq?=
 =?utf-8?B?Rk8xTEptWTV1eXQ4TERxRG5VYXhiaFkwQ0Q3eURrT3FVWkh0MythWXIyQUxS?=
 =?utf-8?B?NmVNK21nMXVKMHNLV2M4T0ZPcUVBUE9Ic3Y3VXYxNGVwYVJoc3dzSUluTS9n?=
 =?utf-8?B?b2hqOWNTK0NZZVJUOUdYOWJIVXFaNityaXBlSFl3ejRCTmdmeUZLV0pBMGJY?=
 =?utf-8?B?ejlxSGtNT2RXZ0h0SmJwQ3RzV1VMMy9XN2tQSkZ1Q0NwcXp1Rnk2c001Z0t0?=
 =?utf-8?B?S3lMaHVvZnFZbUxjYTIrOXdIUmw1dW13clIrd1ZjT3d3QUxkQXhKVnh6TzZr?=
 =?utf-8?B?SzRxeTZtWjVXTFI2MFJmTFE3aC8ySXdVcDFHaWg5TTNMdldaK00rYTJnRzJz?=
 =?utf-8?B?d3ZnSnJPc3k4WTBDdURtK0dRSmVyTnZHSUtCL2pwSG5rbUptc1FOUlMveUhQ?=
 =?utf-8?B?bXdvbWRqeVlTZEY1bVZiTWhDMFVORWNtb1VuZDR6MVRNcm1OSTllMnFUdHdB?=
 =?utf-8?B?Z3VtQVlHZjd0cm5uanF2TlRxT1J5WnZ3VS9WTWxPclhla1pBeEJDS2E4WEdj?=
 =?utf-8?B?blhaaTRBSEl5Ym9YcDlGVURqOEN1WXhCaWROam5aaVVNeFRWMGpBcHRvbG1Y?=
 =?utf-8?B?bW84dFFMMFdQMy9rY25FdGU1N3ROMko5K0pLcXFHb2dkSnVFdWdKdndCSzMy?=
 =?utf-8?B?STlsRDBBZUNraHhPK1lFT2JXQ1dHWDJkSGtycGdDMEJadWEwQm5zNHhWekRC?=
 =?utf-8?B?cWRWY0U5ZXVHNVpRRGRMaXZKamQvdWRzeVNwUm1oVDd3dm1VdzBIWWxaMUx6?=
 =?utf-8?B?dytaNVpxbjlWM0JrSjlRWEpHbDhSV2U5bTJSblJwUHFYTFFVWUs0SUErU2V5?=
 =?utf-8?B?Mmg1cmpjVThqNm0yR2kydXFLMVYxdEVNQitmUmpaTG9ZL2w1UkVmVkFweVFj?=
 =?utf-8?B?NnA1cVo3ZFl6RCs2bWZwQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OGd3b1crcmZpMlZpc2hsSG50M2VYRHdLQTBqTEVZYmZKUTBuU3dVcmNTc2U4?=
 =?utf-8?B?VzVCVmFxUTBRN3RQQlZ5aEx1WGszR05YRFM0UEVMZE1CZVIxSUtqQU9ENWQ2?=
 =?utf-8?B?dDVCakh0NXRRRmpDUndNcEpSeFFRelRnUFVXVDRNa3hmZVgvbUlKQzM0ZWp3?=
 =?utf-8?B?TSsrYmdJVmRITGoyaWpIQkJTV2Y1Y2pjQ1NOVnBCNVZXM0VwZUtDVWcxMmp1?=
 =?utf-8?B?L0MvaXVRdGN5SXFnQUJFMmZnSFgzcjlDVVo1ckxnQUljZVNNNnRYeUlKRmZI?=
 =?utf-8?B?cFAzYWdRZllGckgwVDJJL2tQQXBvTVBOYUJZRjZrZXhUcWxDbmRhdUV0M3oz?=
 =?utf-8?B?czBzN1pDL0ozTXVHWXhXT2VabVFMWVNjQk9iQTEycnRYdE9BVUwrQmRnN1ZR?=
 =?utf-8?B?Qkt1VDVma25ZOUZRRFlXU21XN0ZyZVJNU2NDMDcvREU4TDdBMzAvd2FmQXU3?=
 =?utf-8?B?b0dBTGQzMXZuQXFtZDBqd1hINk85NTFJcXl4MU56TEp5a1plTlNkeU9jVG1M?=
 =?utf-8?B?c2RXVjErMVplZWljb2pBTVZQMjVVK2szalpUekxrVDQzVGs0S1dDZnlFZnpW?=
 =?utf-8?B?ZjA3ZHdLYXRpOTBxejdWNGR1UUFNZDhpcU9zUVNqcE5sQ3dZYjJKb0wxUTZR?=
 =?utf-8?B?cDVyZ3VtMlo3MUhzNUVUbVVXNVE4VlBoT1pNM1AzQS8yWkJ6MmtoN2cwY1di?=
 =?utf-8?B?Z0pjbFBvcG1vL09nZTcrSXp1K2pHSi8yRjJDSVpWTGsvNHl3SUFLRmdpUXBX?=
 =?utf-8?B?UTByeEQxSUNPczVPRXpLWG9CelBHTDN6R1NhT1ZtTFlQdTJUT0hUNFlHU2d6?=
 =?utf-8?B?RHpKTi93Z3J4MkFDRnhDaEJiUHpCQjBjTlQzamVIbjA1VkxZdVF1MkRJTkhW?=
 =?utf-8?B?YVhqYWxaM1gwbHVJcDVrVVpNMzhzQ0l3TXpnZW1DVlI3bWdRTXF1cFBobTYw?=
 =?utf-8?B?R2N2ZWxhem5JVEY1R2RPcWpxWm5keXpqK2dXazhtZjExVE96VXFVS2R2eUla?=
 =?utf-8?B?RFR5M1Q4bVNLa0UzZWVMeXhWN0wyN1NoTDRqZlg3VWNUdXhaT3c5aXNkUmJ0?=
 =?utf-8?B?WDk2d3JwZmdsOHM4N09aN1JEQUliOXlTUzN4cy81MW5nT2lBbyt4dmhqcStl?=
 =?utf-8?B?SGhWMEhkR2cxeXU5eHdOMWxmejNySkJjTjF2RHk1eHliMlU0RzBZK2NlRkts?=
 =?utf-8?B?NmRyT3ljb3FXYnRGZjdndWJiWFNLYURVY3hxQk45NjNvdkdRR1Q1Nks0ZmVD?=
 =?utf-8?B?WjlRblRVM2t6NnZwZmNoQXRoMHA5eHFCSFNsZU81eEI4MzRES0JYdUlPQjgv?=
 =?utf-8?B?YkUxTmVQbjVRWWVBQmFnOEVtWnRLZDNHc0dZYkhvdGlBMXV2T2pieldCSW42?=
 =?utf-8?B?cDc0b3VDWktSbHBzakZ5TlJmNUlya1dLZS9RM3lxdFJzZnlhak54Mmd0NmRQ?=
 =?utf-8?B?NUcrRFlKL1ZJd3VQc1JIYUh6L0dBdk56ZDdvRk1BMDhnc1ZQMVRxTFZGTTJE?=
 =?utf-8?B?VGhRT3hHa0tSZm84TUk1bnVjUkdRMWRob0F5TURKS2ZtclZkSG9IazArdEV3?=
 =?utf-8?B?dWVmODg5bExiOG8zb2VWWGpaV2s0aVczb01xMjZ1aEtkRDgxMWo2OG42dUht?=
 =?utf-8?B?eEpLZVZodzVJZEFMK2s2d3piOVYzNWpaeVpndFlvSy83a3FSRWZCZVNYMmlS?=
 =?utf-8?B?WkhuSm5iRHloYU5wNW5QVkQ4ZDZFNHJxZk9BSFYwWXo1Q205WU5mayt5eTVC?=
 =?utf-8?B?ZnhscEVtQXA5WmNBeHg4eTM4ekFWd3Y2c21iSWZRbVZYK2gybm9ZQmRiNXJw?=
 =?utf-8?B?QjUwUFNvREF6b29CbWtiSDdBMWoza0dsNmtCOGVlV2hDZ2pUbzFXNzlvdW1P?=
 =?utf-8?B?dGZ3YUFVb1lxdktmejZjQnM5ZmFoaUdUNGxjUHVFYWU3Wk1pODhRODVRcFov?=
 =?utf-8?B?bGx5cG9ucTZNa1A3aUJBQ0pTUnRLQlE1UTZoaEpFMVpWdDNhYWRHREtwS1JS?=
 =?utf-8?B?bW1RR3ViZEgxZUxkY01Ed1FqalBTUkRXTjI0K0FkVGlOMnNvbnk3N0I0eEZ5?=
 =?utf-8?B?TTRIcVptSm5CeGhOUzU5MkJ4L0VzMnl0c1B6RWNqRURzelFsL2lMbWppR1lS?=
 =?utf-8?Q?xdi2hO221BebPlo2rIHOW+IeW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967f62f2-1cb3-4bf4-c2ab-08dca1d80ad3
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 18:34:04.9278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vcz4EB+nFXVzNR0rRllKaugjfydVyKl6ktgLJIh9tHKs7YgwzJdY3+WQuacRvYrIQzZP6pX8UCTBTxz/NNnqbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6828

On 7/10/24 17:05, Pratik R. Sampat wrote:
> Introduce tests for sev and sev-es ioctl that exercises the boot path
> of launch, update and finish on an invalid policy.
> 
> Signed-off-by: Pratik R. Sampat <pratikrajesh.sampat@amd.com>
> ---
>  .../selftests/kvm/x86_64/sev_smoke_test.c     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> index 1a50a280173c..500c67b3793b 100644
> --- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
> @@ -131,12 +131,69 @@ static void test_sync_vmsa(uint32_t type, uint32_t policy)
>  	kvm_vm_free(vm);
>  }
>  
> +static void sev_guest_status_assert(struct kvm_vm *vm, uint32_t type)
> +{
> +	struct kvm_sev_guest_status status;
> +	bool cond;
> +	int ret;
> +
> +	ret = __vm_sev_ioctl(vm, KVM_SEV_GUEST_STATUS, &status);
> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +	TEST_ASSERT(cond,
> +		    "KVM_SEV_GUEST_STATUS should fail, invalid VM Type.");
> +}
> +
> +static void test_sev_launch(void *guest_code, uint32_t type, uint64_t policy)
> +{
> +	struct kvm_vcpu *vcpu;
> +	struct kvm_vm *vm;
> +	struct ucall uc;
> +	bool cond;
> +	int ret;
> +

Maybe a block comment here indicating what you're actually doing would
be good, because I'm a bit confused.

A policy value of 0 is valid for SEV, so you expect each call to
succeed, right? And, actually, for SEV-ES the launch start will succeed,
too, but the launch update will fail because LAUNCH_UPDATE_VMSA is not
valid for SEV, but then the launch measure should succeed. Is that
right? What about the other calls?

Thanks,
Tom

> +	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
> +	ret = sev_vm_launch_start(vm, 0);
> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +	TEST_ASSERT(cond,
> +		    "KVM_SEV_LAUNCH_START should fail, invalid policy.");
> +
> +	ret = sev_vm_launch_update(vm, policy);
> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +	TEST_ASSERT(cond,
> +		    "KVM_SEV_LAUNCH_UPDATE should fail, invalid policy.");
> +	sev_guest_status_assert(vm, type);
> +
> +	ret = sev_vm_launch_measure(vm, alloca(256));
> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +	TEST_ASSERT(cond,
> +		    "KVM_SEV_LAUNCH_MEASURE should fail, invalid policy.");
> +	sev_guest_status_assert(vm, type);
> +
> +	ret = sev_vm_launch_finish(vm);
> +	cond = type == KVM_X86_SEV_VM ? !ret : ret;
> +	TEST_ASSERT(cond,
> +		    "KVM_SEV_LAUNCH_FINISH should fail, invalid policy.");
> +	sev_guest_status_assert(vm, type);
> +
> +	vcpu_run(vcpu);
> +	get_ucall(vcpu, &uc);
> +	cond = type == KVM_X86_SEV_VM ?
> +		vcpu->run->exit_reason == KVM_EXIT_IO :
> +		vcpu->run->exit_reason == KVM_EXIT_FAIL_ENTRY;
> +	TEST_ASSERT(cond,
> +		    "vcpu_run should fail, invalid policy.");
> +
> +	kvm_vm_free(vm);
> +}
> +
>  static void test_sev(void *guest_code, uint32_t type, uint64_t policy)
>  {
>  	struct kvm_vcpu *vcpu;
>  	struct kvm_vm *vm;
>  	struct ucall uc;
>  
> +	test_sev_launch(guest_code, type, policy);
> +
>  	vm = vm_sev_create_with_one_vcpu(type, guest_code, &vcpu);
>  
>  	/* TODO: Validate the measurement is as expected. */

