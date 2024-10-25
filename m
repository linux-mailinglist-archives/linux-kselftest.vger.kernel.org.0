Return-Path: <linux-kselftest+bounces-20604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B7C9AF900
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 06:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33202282F0F
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Oct 2024 04:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5800E18C93E;
	Fri, 25 Oct 2024 04:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hLBQygVx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C362618C030;
	Fri, 25 Oct 2024 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729832102; cv=fail; b=ErYFVfQcXGfPSO6h1Q1Ug0uukhKvxUnkNafrZ4Wiki3zs+NkqhcGocsyWw/0JSBGc9PHfjGQ5/PzyVwHgpxzQjbh7k9O9j7481rz4lRrZ4gxlKBJQvxbDEvH+QTPn4WmP5r78c4o12cPvYnfjX/e8R0m/bTmcr/gDYReHwTRb0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729832102; c=relaxed/simple;
	bh=xLdGwg2JiztaLoAc4BiS41BzxjTNB9U6k7490CYrIwE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=arH2TwWbY7rpL42shL1F5bLyLiVl/nhBruF/ROYid1rCTzl+aSAxmKDyavUjoKM4iUcRsjJrIF9ay9EnaSZm9K8G4H6aJMbM3XF6TNDRCW4CfuaTgVFKgDgmH56pKZ5G/CNMx34KPLJcx63bIHBFPcUb+sEGJn9mNGV0Oa1vDlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hLBQygVx; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkqj8/0an+uQ/4RYcs2PwEJbrCrn9HCW4MWGkwUZgEPL6QAm3BfwV1WfdAGmyrdjHqq43z912Xos6ROj5IVOA2XofAOHkG0sIgksqaHsU7lbpr8j7wzVYSK+8xQvGCYvTLN1+n93Ta/qX1fYIvTRmaFY0jnfCdhvMLbCoeC9SHG5ivZj/ngIc5DFJuG5HxpleRJx1GvzcGzfSjDdHvppgAF5zQ7shxl0IxWaLOX8UGCj4q7qwAdpRIuo6WEu5sHEJfhRrT3cvapODpvpByLNF9RQMBgAvL1X1xSIUxMhNEIQ7gVX+WOCNAwwSxnDDNRuZjEMH2PCI63k3fnrS02qNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UN1mgpZoBuTAcRco+EKhHGYcU2cSRZtPtxGVgeq5oqQ=;
 b=sw1Pi0JlpYZdm4F+9mbExrmGtCICMr9vOokz20r7XmCbp7PzzCJ5BXhlq/bRX7+rHRyJvzMR6VsTYA2goYrrGEbEFkdOhCVw21TpAQEpEuayPy2GlEmPQEI3tjpSFfDiZAjGbD0U1/8I1y8/b1yAsPxVVSyjIPu6i6cmM2RX2rjMAzCXGPvc+4wteprJemevtwME93rC92r2yJXEOUGrF/jJUAKR/sF+Qc8XTzcCR0AfZw0gO8MvQSQtA60jWoX2TguD+Gqwt+ulHxhd8f0h79ndJPMfThepKBvY1N8dnoiFgskUdNiwTFjGy6Sis3O4oEH8ul3r0rD5DQqecBIhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UN1mgpZoBuTAcRco+EKhHGYcU2cSRZtPtxGVgeq5oqQ=;
 b=hLBQygVxKW8I/KJZclL63Bm5g73r5iYXWHdZjjbdJg7XiA1k/1tl7kPJfQGsJby+wlE4J8bNnG/4Zn2uzaM1E4vHsbi03RHpFNStTSMkq0lC1agQIj9lsa4ByaPTJzC0S5sRO5Bkl/rgftVP56u+ttnz5c2x4bvJQJ93A2lXJU8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 by PH7PR12MB5735.namprd12.prod.outlook.com (2603:10b6:510:1e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 04:54:56 +0000
Received: from CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f]) by CH3PR12MB9194.namprd12.prod.outlook.com
 ([fe80::53fb:bf76:727f:d00f%4]) with mapi id 15.20.8069.020; Fri, 25 Oct 2024
 04:54:56 +0000
Message-ID: <98a0e135-4f9b-4a2e-94b5-f1a830a49f19@amd.com>
Date: Fri, 25 Oct 2024 15:54:44 +1100
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 00/14] iommufd: Add vIOMMU infrastructure (Part-2:
 vDEVICE)
Content-Language: en-US
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 will@kernel.org
Cc: joro@8bytes.org, suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
 mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
 smostafa@google.com, yi.l.liu@intel.com, zhangfei.gao@linaro.org,
 patches@lists.linux.dev
References: <cover.1729555967.git.nicolinc@nvidia.com>
From: Alexey Kardashevskiy <aik@amd.com>
In-Reply-To: <cover.1729555967.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0115.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:20b::20) To CH3PR12MB9194.namprd12.prod.outlook.com
 (2603:10b6:610:19f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9194:EE_|PH7PR12MB5735:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c3a9d36-367e-40f5-63cc-08dcf4b12bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1YxYkVzYkVqdnloL2FmRHF2UTRBQkJhSU9HZDQwaURJdGZkajB6TjhiK2M2?=
 =?utf-8?B?MnlyQURQOHVrbTZrTk1iN0xkcytxcjZaZVJMMnE5aVloVS9ZRFhaL0FIcHpp?=
 =?utf-8?B?Q21FTitudzlVK0NQVTFmYU84OGNsdkdUUk1zTlhiT2dmT2g0bEpvQ2pwT3ll?=
 =?utf-8?B?ZUlWTXNLWmhVWGtYODVkTGdJRlord0NpY2RnTHJjc2pYMW0yaEU1UmJESmV1?=
 =?utf-8?B?VHk3bURpcm5hMzJ0RXhvQkw0RnlBZUFMOWI2OUxSUkNwd2hkbVFSZy96MTcy?=
 =?utf-8?B?MktjeElzS3NHRE5Yc2thajd4bkRzMi9lYTM4b2tnTEMwRHJFdlUyNXJDOXBx?=
 =?utf-8?B?RlQ2ZnR5OUlQd1ErVWZTdTZxaVgyOXFOMUN6VktjbjRodUpWU0dzT2NYMkpM?=
 =?utf-8?B?Kyt1ckY5bzl2MGdIbE1zcXZ0bGYwb05WK25xNjhOdHNmdU11NFVKVHdOcHNM?=
 =?utf-8?B?SHV1RlJBdituR1QzMW51WTFZNFFDczBVN3FOTUNMM2loeWMvUk5vc3NnK1NE?=
 =?utf-8?B?SFllVVZMbTl2ZHRhNm5qcEUzWEtJeURSSkJCUlIya2duS1F2YTV3QjVUMXBN?=
 =?utf-8?B?dktxWWttKzdrU3VtR2ZnWGx4OENqTU1QdDFrVW5zTWVwSnZSeTJNQjMyNjF6?=
 =?utf-8?B?cUcva2xjcVhhWXI1anVNTDB5bmRpTXlsMkVWclZILyt6WVRqV3YxVDRKNXho?=
 =?utf-8?B?Z3pXZUVwUkpxYlR0VVhybzRzU0ZTbytpUWwrVHptVUVOT2FZdWhadWpYaHpv?=
 =?utf-8?B?UU94RDM3d1MxZnpGN21GQy9KWlFteHZWWjBQZWtBMkVRQmlWb0Rwb2VzeTYz?=
 =?utf-8?B?aFBqTTZ1NmtpbHhIY2xiN3J0ZS8xZmRRYVhOYmRDS2RlMjRvdUVzV1lmNmky?=
 =?utf-8?B?K0hkRWIxbTB3NWFBUXZheVd6dXhFTnNDcTdVUStScFY3SWdyaURORGw3VndQ?=
 =?utf-8?B?QTdMQ00zTWk3d2N1ZElqNmJUR09BS3B1WjFQNUh5TXhiaGtwVTMxeTltUnhO?=
 =?utf-8?B?SlpIeHRtV3o4Z0VmVlVDL3lMY1NEYzBtcnJDVjJVS2lIWXNkUmZVaDVNWHJr?=
 =?utf-8?B?cjZycHhBZWIzMEl3UE1ZdHNhNy9IUWNCMEtFYXNmcUx2by90c01VSGNNVE9I?=
 =?utf-8?B?SjFWMndFSlk3SlYrVjB0MDBLK3NncnlDK2E5YkNWcnFDaERlT1JvcXo5THhi?=
 =?utf-8?B?N0ZUU2sxcWdIMjcwVzZYREdpQjBJcjdIVVEwV0V5cTQ3SjQ1VXZpTDBTeWR5?=
 =?utf-8?B?OHVPLzZCcUdhVEMyekZTcmlnVk9Zam9xYktIVngwN2RTUUxNYktPdVNpcEdu?=
 =?utf-8?B?ZHBFQ1VjdU5EcmVVdEQrOVZ1QkptUEFudVQvRW9GSndzaytDbjU3azlNVDA2?=
 =?utf-8?B?VVRyVER6MkE1N2hkMnZ6b0hvMXRLcGJ1UTlCbkVqcmZFaXlSVllYL0V0Q2hI?=
 =?utf-8?B?STI4VDc5QkNod05GVzdZUi9yR3U1ZnlNU2RiektoaFFqSzdMWnRlbnJtOXNz?=
 =?utf-8?B?TlRUeTJ4alJGaXdCTGpvM3diZ2tTYTk5Skk3dUlaMzlaZExHVWxqRUFvejhR?=
 =?utf-8?B?QjAxVmJIai92Y1ZMOGVpTjVqVytNUlJKNHVXNmFmdFJNMjhuYjNHK3ZaWTZp?=
 =?utf-8?B?ZlFKbDNQbVYyZnpNNmdjOGJ2WTkvUEU1ZGFDamxlaVlTRG0ySHNmMnBDa2JP?=
 =?utf-8?B?M0VIdlFuYmxFUk80MTZIY0drMEFvWTJ6QUxWeXVEcG92WlB0WnFDM2t3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9194.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFBbEhReUpERzZNT2JPYm5ESEtJaG51MkdKQVFadlV5c25mUnFUZXl0VWdV?=
 =?utf-8?B?RWlsM0lWd3NPOUxPeDZVeFcxa2Nub3JMQ2pkQm9CUEdsaFF4bUZxeGUwNmM0?=
 =?utf-8?B?eldSd2FIei9adkxyWFlDZVBTLzROeGFtbUVJeXpCSDNIT3pleU1KdDBXUGVh?=
 =?utf-8?B?V3pRajlLOGdORFNJS3BJbWMzdWlTUTd3cG10eTRXREpsSmJSVmRhamZNaGRt?=
 =?utf-8?B?K2ZBeVRWaEVIVm84bW8xZzh5U3pmK3RFU0pyVWw3WndxMENaSzUyTG1HTzRK?=
 =?utf-8?B?ZXdOYUxteC80R3ppNGdTbWNoUjNQaS9LN1d2cEJSV3FNek1uUzFzV001Z2Nn?=
 =?utf-8?B?aFo4dmZoNUJOMDJ6OXRWdEVZV1hnM2hZT3JISUlRa3o3d1Btc045NlZ4VjNp?=
 =?utf-8?B?M0FYMDl0WS9zU2U3RnRqWjdIU3BZeVY3QXFyZzVlR2VHamF4MmwyRlY1Vkgw?=
 =?utf-8?B?aUxiOGlBYXplTEVhdHVNMndlRlhhTVoxTVRjbm5CM2ZqR21FNFpiYkJ0aWRW?=
 =?utf-8?B?a3N1WTJ1VmhsNk5kRFQwdEpacEFibGE3WE9BL2VNY1hJbTM1M1Ywd1ZzRWZO?=
 =?utf-8?B?MGdkWFRvR05hczYrVUdHT2JYOHQzN2V2UEk5Nk9qVWVTU0wrVXJPZy95U1Qz?=
 =?utf-8?B?RW1tYnNPZDE3THdkRWJlaklkb2FlZjNZNGdCOTJsUHh5eStBbWNidXBlZWIz?=
 =?utf-8?B?bElReFBQYmp3NThlMjZaMTdEQ0RqNzBBL2JtaXpFaVdQU1FqV2pjaDc0QnJS?=
 =?utf-8?B?Q0paeDZqbGNibnhjTTRCc2QyTmJXSlVDUlJ3UnBOcExlaHFSTkZ6ZGJ5Nmdi?=
 =?utf-8?B?bStMY0IxelhyMmJZd3JTeWszUmk1a1dOeHRPNXZ4WC9MeGxRQlV0YlVwRW5X?=
 =?utf-8?B?Y01XZFFtU2JIQlFad2MxTFBDVHRQejRMcnNSNUxYUW1lbXJOVmhGdGpRNllW?=
 =?utf-8?B?dGdzV3AyTFdLZ3RxWS9kUmRVN2RzSVRoWnhOQngyZzhNOGpSd1dvUHJWY0RK?=
 =?utf-8?B?bzZ0bjk5Z3RaOERzdi9NY0tqNFRTQWhYZW0xTldFNUhGWTBUeStmN1BpSzBo?=
 =?utf-8?B?bTBaS1E2MktnRlpoaDgvdklGMm00VGN1L2dROU5VdVZXVjFsTC9xVHk0c3du?=
 =?utf-8?B?N0xuOEZBb0hzTVBpUENQdk94ZHBrbXZ4cGt3clFzc0dXYUZrVEc4WXNFTDYw?=
 =?utf-8?B?bjRmN1UzeThhemJwMnJvdEwxZzNpZnBBamd1Z1FMdnJlN3B2aHJjR1REaVI4?=
 =?utf-8?B?TXJoNUpLZDFBSklDY0RlRm9TOFF5b3BicDFldXFKVEFPTEcyangrS0dOZGE3?=
 =?utf-8?B?dlBQTlYxRmYvWVl4YllPaXRLZHB1N3grZ2JNNFRwdXllNFBGYmlWWFdVV3NX?=
 =?utf-8?B?b2xuS0JaZHVvMGsrRTJORHQ5NWY1WnM4MGdlWVJHOWY3UGkxamN2cyt4eTE3?=
 =?utf-8?B?T04rTDZVMWI2NU9WMkRISkpKbW5kUDJPNnljcHpYbVpQQjlXN3BxaHdONDdv?=
 =?utf-8?B?T0pDbjJLNFNvdmgrQ1YyZFlvc2pLYnRlRlZZenZjdDFFSXE5MEUyUXFFemg4?=
 =?utf-8?B?ejgyRXl6VFkrYnpiSXM1b0cyVzVVcUo3YTdNWWR1SUlPTENGLzI1cWR4OU9V?=
 =?utf-8?B?bHZ2WHJIMkg2VmtObkphc1ZIUDAzdmtKNEs2TnArdlBKQmh5MVBhaVdaSmJG?=
 =?utf-8?B?eUJoSU45Q2QzS0g3VzFuL3VOeHMxMG8vRTRTM016ejJ2OGZhM0R2Q25YYXo5?=
 =?utf-8?B?T2tBS2ZGRlQ2S3prektuUU9JYThOQUNSMmViUUlFOHBDZm1ORlQ0TndQaFZD?=
 =?utf-8?B?UzQwRldwNzlFNTRrb2MzTzlERW15OUZ4R0ErWTVzWUowUnQzNzFQbENnUURB?=
 =?utf-8?B?eWxKbUM4blZrdGZVanFBNkQ1bGhzUjAzYk8vTWhwc0xZdGRLVURiMGxxM2t0?=
 =?utf-8?B?amhxV3lTWHdOcUdsV2FKREFKcDZodys4UjNNZzNhaUptelFRSm9BWnZmbzZq?=
 =?utf-8?B?aUlNc05TU05PVWk3WnJQTm9hQkZ5SkQ0WGlHVHpIZFZsSEluanFUNDNGQ1kx?=
 =?utf-8?B?cFJLVVdRVHV4NzlVeEU4TysyTDkvWWlLV0NjazRXRzN6YWxudmorZkhtUkha?=
 =?utf-8?Q?CdciHSPuL6fPTXFK8pjd2w5vR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3a9d36-367e-40f5-63cc-08dcf4b12bc4
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9194.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 04:54:56.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ju3VqB/MgriZn3fLpFcBueen1B+j0t/T/vRTMTB3pEZp+vrpau9aSHBkum0IruUbQyjHbVzO9ph+Gkmxw0LWcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5735



On 22/10/24 11:20, Nicolin Chen wrote:
> Following the previous vIOMMU series, this adds another vDEVICE structure,
> representing the association from an iommufd_device to an iommufd_viommu.
> This gives the whole architecture a new "v" layer:
>    _______________________________________________________________________
>   |                      iommufd (with vIOMMU/vDEVICE)                    |
>   |                        _____________      _____________               |
>   |                       |             |    |             |              |
>   |      |----------------|    vIOMMU   |<---|   vDEVICE   |<------|      |
>   |      |                |             |    |_____________|       |      |
>   |      |     ______     |             |     _____________     ___|____  |
>   |      |    |      |    |             |    |             |   |        | |
>   |      |    | IOAS |<---|(HWPT_PAGING)|<---| HWPT_NESTED |<--| DEVICE | |
>   |      |    |______|    |_____________|    |_____________|   |________| |
>   |______|________|______________|__________________|_______________|_____|
>          |        |              |                  |               |
>    ______v_____   |        ______v_____       ______v_____       ___v__
>   |   struct   |  |  PFN  |  (paging)  |     |  (nested)  |     |struct|
>   |iommu_device|  |------>|iommu_domain|<----|iommu_domain|<----|device|
>   |____________|   storage|____________|     |____________|     |______|
> 
> This vDEVICE object is used to collect and store all vIOMMU-related device
> information/attributes in a VM. As an initial series for vDEVICE, add only
> the virt_id to the vDEVICE, which is a vIOMMU specific device ID in a VM:
> e.g. vSID of ARM SMMUv3, vDeviceID of AMD IOMMU, and vID of Intel VT-d to
> a Context Table. This virt_id helps IOMMU drivers to link the vID to a pID
> of the device against the physical IOMMU instance. This is essential for a
> vIOMMU-based invalidation, where the request contains a device's vID for a
> device cache flush, e.g. ATC invalidation.
> 
> Therefore, with this vDEVICE object, support a vIOMMU-based invalidation,
> by reusing IOMMUFD_CMD_HWPT_INVALIDATE for a vIOMMU object to flush cache
> with a given driver data.
> 
> As for the implementation of the series, add driver support in ARM SMMUv3
> for a real world use case.
> 
> This series is on Github:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4
> 
> For testing, try this "with-rmr" branch:
> https://github.com/nicolinc/iommufd/commits/iommufd_viommu_p2-v4-with-rmr

Is there any real example of a .vdevice_alloc hook, besides the 
selftests? It is not in iommufd_viommu_p2-v4-with-rmr, hence the 
question. I am trying to sketch something with this new machinery and 
less guessing would be nice. Thanks,


> Paring QEMU branch for testing:
> https://github.com/nicolinc/qemu/commits/wip/for_iommufd_viommu_p2-v4
> 
> Changelog
> v4
>   * Added missing brackets in switch-case
>   * Fixed the unreleased idev refcount issue
>   * Reworked the iommufd_vdevice_alloc allocator
>   * Dropped support for IOMMU_VIOMMU_TYPE_DEFAULT
>   * Added missing TEST_LENGTH and fail_nth coverages
>   * Added a verification to the driver-allocated vDEVICE object
>   * Added an iommufd_vdevice_abort for a missing mutex protection
>   * Added a u64 structure arm_vsmmu_invalidation_cmd for user command
>     conversion
> v3
>   https://lore.kernel.org/all/cover.1728491532.git.nicolinc@nvidia.com/
>   * Added Jason's Reviewed-by
>   * Split this invalidation part out of the part-1 series
>   * Repurposed VDEV_ID ioctl to a wider vDEVICE structure and ioctl
>   * Reduced viommu_api functions by allowing drivers to access viommu
>     and vdevice structure directly
>   * Dropped vdevs_rwsem by using xa_lock instead
>   * Dropped arm_smmu_cache_invalidate_user
> v2
>   https://lore.kernel.org/all/cover.1724776335.git.nicolinc@nvidia.com/
>   * Limited vdev_id to one per idev
>   * Added a rw_sem to protect the vdev_id list
>   * Reworked driver-level APIs with proper lockings
>   * Added a new viommu_api file for IOMMUFD_DRIVER config
>   * Dropped useless iommu_dev point from the viommu structure
>   * Added missing index numnbers to new types in the uAPI header
>   * Dropped IOMMU_VIOMMU_INVALIDATE uAPI; Instead, reuse the HWPT one
>   * Reworked mock_viommu_cache_invalidate() using the new iommu helper
>   * Reordered details of set/unset_vdev_id handlers for proper lockings
> v1
>   https://lore.kernel.org/all/cover.1723061377.git.nicolinc@nvidia.com/
> 
> Thanks!
> Nicolin
> 
> Jason Gunthorpe (2):
>    iommu: Add iommu_copy_struct_from_full_user_array helper
>    iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED
> 
> Nicolin Chen (12):
>    iommufd/viommu: Introduce IOMMUFD_OBJ_VDEVICE and its related struct
>    iommufd/viommu: Add IOMMU_VDEVICE_ALLOC ioctl
>    iommufd/selftest: Add IOMMU_VDEVICE_ALLOC test coverage
>    iommu/viommu: Add cache_invalidate to iommufd_viommu_ops
>    iommufd/hw_pagetable: Enforce cache invalidation op on vIOMMU-based
>      hwpt_nested
>    iommufd: Allow hwpt_id to carry viommu_id for IOMMU_HWPT_INVALIDATE
>    iommufd/viommu: Add vdev_to_dev helper
>    iommufd/selftest: Add mock_viommu_cache_invalidate
>    iommufd/selftest: Add IOMMU_TEST_OP_DEV_CHECK_CACHE test command
>    iommufd/selftest: Add vIOMMU coverage for IOMMU_HWPT_INVALIDATE ioctl
>    Documentation: userspace-api: iommufd: Update vDEVICE
>    iommu/arm-smmu-v3: Add arm_vsmmu_cache_invalidate
> 
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   9 +-
>   drivers/iommu/iommufd/iommufd_private.h       |  12 ++
>   drivers/iommu/iommufd/iommufd_test.h          |  30 +++
>   include/linux/iommu.h                         |  49 ++++-
>   include/linux/iommufd.h                       |  50 +++++
>   include/uapi/linux/iommufd.h                  |  61 +++++-
>   tools/testing/selftests/iommu/iommufd_utils.h |  83 +++++++
>   .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 162 +++++++++++++-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  32 ++-
>   drivers/iommu/iommufd/device.c                |  11 +
>   drivers/iommu/iommufd/driver.c                |   7 +
>   drivers/iommu/iommufd/hw_pagetable.c          |  36 +++-
>   drivers/iommu/iommufd/main.c                  |   7 +
>   drivers/iommu/iommufd/selftest.c              | 115 +++++++++-
>   drivers/iommu/iommufd/viommu.c                | 108 ++++++++++
>   tools/testing/selftests/iommu/iommufd.c       | 204 +++++++++++++++++-
>   .../selftests/iommu/iommufd_fail_nth.c        |   4 +
>   Documentation/userspace-api/iommufd.rst       |  41 +++-
>   18 files changed, 983 insertions(+), 38 deletions(-)
> 

-- 
Alexey


