Return-Path: <linux-kselftest+bounces-44514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A37BC243B3
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D6CF54E3C93
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Oct 2025 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF22F332EC7;
	Fri, 31 Oct 2025 09:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZVafpi60"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41651E260C;
	Fri, 31 Oct 2025 09:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761903899; cv=fail; b=pI+HfgL452lEQRsj/bXoL6wUUYS7tl9MRmyMcJdaFpzZrj/ePffCwEu/ClqCMvAAsF0hCouJf5FanR43R5xZGNECdXnFWmxqyVoXEATcjMsqYag1YKOeSTJJFLq1n6HhIR3T2co+Wp58vHWSExASzaGb8ZuSHRaH+JTyBqGQvMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761903899; c=relaxed/simple;
	bh=1E+wRzDxrmvuzZjnibVGxD2k4nSs9zvJZqp4yuIOXWg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHeo10A1uq1pAavi6ZliusU0QJh4XA2faAGt7EbQeP01fQJ3ajtsrqrR1L7nekUOqqBaRCCEVyF/Q90HfRyu2DRvUXRI0KCGbg5tVGPV9bh/453DiR2aIlWhiNXEqFV7lkGSTuL6YBsemUNrCJeqwCLkm5db7H4sb4gL2J9SaFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZVafpi60; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXIYUIM9PwFbwW2PSOLn6zOu3OLZLJ43D74Vfgv4PaGxkmiF/uA1jHvMq0E+bPnAT9FjSSBiCEqehRBX2mLcnFD9qO6NAo8/1neQLI0VFwYwax/ZGHic3RJBwSJ93qv5wsuUTEt9/fh8Mgar7ffPKZYlgMb876nZ49Lmq0/hdrY+3ktTnOuPbeC9JyglfuW4nvNJrhEqiyCC2lLoYGl/QMkuNMfYcH8IQMab2U/eBXj99FKaTF9CdMAusdBQgdbaJrIgZmr3jwSNv72H3u95oLXu0RFzwUBQFJjkN6azD+k9O1s6yZ+FCFKN+kpA/K4CQu+80dXcFpl7xb6AqgNQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4+1O8TpScKMM+dW2m1M4VgGiQd8ZI+WoV9OHYsRKgI=;
 b=TM78ze7CtuyQsewDF1xz8ULADezjMlAiyk/T0B2IpmwE+QYeHGSAWDC1tQzCAjNdbtlX87hV9l2++TLYaPmRxr4eF9ALl3uwJAlj7cGAcYOu8b6oPfahPk8Cr96hGFCkmTaYHTg93981p5IlCOVhjoMBPNb4+uAxncoQwkvzR4pLR2pOaQA1GkRtE3yGYtOAGlBflT59NadR2uqFkErIsW2+yAWdlrPlliDeMtpzQOr3JiSQWTAPs6yqCagnGSyOj4gqijmdfldwqX4SsMkBSlmGbHaeES7Vuc8/+dC/AMAdmSGrsMa4FAy1+TfQ2HiN50e2y/zqBOr4OjYpKQGQIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T4+1O8TpScKMM+dW2m1M4VgGiQd8ZI+WoV9OHYsRKgI=;
 b=ZVafpi60qC9lu43up1pY9kDLiBYzCfCWFVtmanuObquQbJL51Kfvgcudx4SyKXi4cb+j8jl8cLKuqYiZFi6nlrRXoOnOCItFZih8IfHioH/aQKFc5Ss5ZYd9jlphXB0cDPDCkd0AkU8SmcF5uz0yu8rw7TEm7BZ3GneyVBhUnzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Fri, 31 Oct
 2025 09:44:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 09:44:54 +0000
Message-ID: <9a9a82c3-04b1-4a0e-b7aa-098e36155bdc@amd.com>
Date: Fri, 31 Oct 2025 15:14:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 04/15] iommupt: Add the AMD IOMMU v1 page table format
To: Jason Gunthorpe <jgg@nvidia.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
 Joerg Roedel <joro@8bytes.org>, Justin Stitt <justinstitt@google.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-riscv@lists.infradead.org, llvm@lists.linux.dev,
 Bill Wendling <morbo@google.com>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <pjw@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Kevin Tian <kevin.tian@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <4-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4-v7-ab019a8791e2+175b8-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0144.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f6c3d4e-8a83-44dc-016f-08de18622536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXUwVWN1TnJnMEQrejU1cFp4c2diditSVmx1MU9lKzdZYVlFdjZKRHFjaU1z?=
 =?utf-8?B?V2NPd0lMVHZ0STlzbTJhRm5STkNHVmg3UjhVVmdhRnB4TVNBcFlUSGp6REdk?=
 =?utf-8?B?SFQyaFFUdnc1WXpORXVmai82VU1hc2NHcXhaY2V3OWFFbXJUTWV1d2xGd2VI?=
 =?utf-8?B?WTIwTWRKNWMweUJlaTRCTGl5NWZrczViSnJPREkyVFJYVXg1RUpaWE0xTlBC?=
 =?utf-8?B?ZC8reExKRThHbTE4azFybUpsUWlEbUpiOFp4aENMbUdmUXVnenJBT0thRklY?=
 =?utf-8?B?R3hraE5mZmpKby9saWdFMTBuejE0R3dQaWQwV2lWNTluM2tjM1VwZ0Z5dzFk?=
 =?utf-8?B?S2tnYzQyK2lCb2dQOC9ZRlJ2N2dRNFoyZlRjalpTTUNKRFpiTFNzKzloek9M?=
 =?utf-8?B?RnNCaEtTUjFvOUNQenNqR0JpNTUvMjY2dVduQTIrR2dFblA0bHdTY1dBWFZN?=
 =?utf-8?B?V3pCSVJSUVhKMVA0bnZIcTNKMjNSdVF2cUoyMDNXTEk5M3E1WkliRnZ1a3FS?=
 =?utf-8?B?Q1oyeUpKNGJtdStEdVArb0ZBWjhZc0VWbzBTVXZTQ0hUNjNqV3A0YmlsMENM?=
 =?utf-8?B?UEE0VDFsV3hCbDc2cFBqNU1oY1lZM1p5eldFbFFxbWtUbTA5MXdmZjNKVXJM?=
 =?utf-8?B?a1hnQUJsTXBxZ0VxYktzTmovdDdrRm41SCtxNUpwb010QW5TVzZZT29ORXJv?=
 =?utf-8?B?dGE1eWl0TVFLbWtsRHIvQ05vaEFGVUo2cjVoVWhlZGhuZHIrMmNzNTNqaEgz?=
 =?utf-8?B?UUkrYkhBZmplTWg0NU95dmQ1aEI4WGxmeEhsZ1NDWmMxTVpCcG50ZVZJV0pu?=
 =?utf-8?B?R3g5Q3BRRWk1UzBPUTFHNEIwQXVldTZTNHFVS0NYWVd0bW5MUFJvSFk0NkdY?=
 =?utf-8?B?aXlObjFLdzMwUmVrdUYwRlhNTkNWNXZpUGVzWjl4VFIyQmp2ZVNlTWk1ZTY5?=
 =?utf-8?B?YXhOVlI4aVZjOThYbG0vcS85UGtGWkZwZ05oZTZEM24vT1d2RlMxTzRBM3M1?=
 =?utf-8?B?WnovbHhHSVpoVjIvUkN0Wlc5K0xPNG5lWlJqSzBqU3hmNVNVZEVENmVpNXBV?=
 =?utf-8?B?RG96UXZINVhhVjJPeHNmaXRBeTJGUUZwWkJiY0RuSHAwV25sUTFCSi9qQ3R0?=
 =?utf-8?B?SGV3WS9maElCY1lSK1BFSy9vS0VmdTNEYUwvUi9pZHZsbFgzTWlldWNQOFl2?=
 =?utf-8?B?clIrNlZlTkh1SjJWblZsVjVJa3k3TGMzUUdvRzNNNzl2MHZneFQ4ejZ2Z3pB?=
 =?utf-8?B?bHBURDJVdGloMkRIQmRuZ3hmR3pIYlB4UGJhd3J0UzB1S3NweGZjaWxoV21D?=
 =?utf-8?B?RXVSemFyUjZBQ0ptcUNReVdaSVEwanl6N1dRZDgzYVNrUFhOZjNFSFRURjdr?=
 =?utf-8?B?SkVVMEVoeVZyeVRNcFFvMVRNck9Zc3BmV0N0YzFOZ3Job2k4VXE0KzI2ZFcz?=
 =?utf-8?B?bkRieHN2cG9OZy90cU1ubEloVnhDdnMrUlcvM1JhRG5MUzdlbWF2elZqckVW?=
 =?utf-8?B?N2dzYUg0WS8yZTdtT2l4OWRGaGxjalNWSS8yb1lHSi9PUFgzT2JXVmxnUnRy?=
 =?utf-8?B?SDdUSlljbVVTU1oyU2UyWXdZZUU3dGdCUWMwWDBadFhLN1BRWUE0ZS9lblVV?=
 =?utf-8?B?ZU8xcXhTaWV2MjJQYS9DbVpQZkNSYjQrVUg1enlFci9EeVJUdzV5NUoxcW1K?=
 =?utf-8?B?dHBFTm15dUNSalhicFR2YzJrNWNCcnM2SkxoSm9TTDFaOTVWeWU0ZzBVVFRt?=
 =?utf-8?B?R3A3T3QrSXZYZ1p2WUE5NGgzT3VlSWhjeWJnUmVWekRhT1dNNUJJa0F2QzNJ?=
 =?utf-8?B?WXJmaEVxUEQ5M08yTW9GcDZLMDZrZEErTXRXcDhma1N4Mk1JL3c1M2ZIeW1S?=
 =?utf-8?B?Z2xyeStIZy9rMmxJNS9kY3RScDVxTmRucGlNdWZwTTd2Vzh4eDhpOVg5Q05m?=
 =?utf-8?B?YUJXTjJIcmhreVowZjh3M1BueUR1YnVJbFl1R0MxN3h5V0lmOWZQbUd5eldq?=
 =?utf-8?Q?UwDXpwWfVSD6IbC9wntRevzIeQ7pgM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d3YwYVpISUtla0d4M0hqMXlTWlJCczVuNnVTTDVPWmtIa1kzL3ZqNWdtNUJl?=
 =?utf-8?B?d0xqZVBKMG9ldXlwNWlRWUUrSnptTkRQUzBCYTRUbFVBVFQ2RmN3eHV5Zm51?=
 =?utf-8?B?dWtCK1h6MFYrc1VxaE1Cbjl5d3FCTVdrM1NJK0NidTcrR0RXbGZGcmxNZlFD?=
 =?utf-8?B?UUtOZ212MVZZakk0Q3lHK3Y0dmdYVXhzMjcyUWxKaStjL0hQR2l3NmxRMlU5?=
 =?utf-8?B?ZEZiNmZWZTRBNWRtV1R6cjBVYmdpYWRrMFhFOXpOVXlGdkUwQUFnMEFYUnh0?=
 =?utf-8?B?aFAyN1lOY3gyMjkybFp1cXJ5RWZxN1VtQmJuMUR2VGlhTUpoRjJyNEtxejdB?=
 =?utf-8?B?MnhmZklpZnRURUVsc3I3SzFhWlB4dzNJNkdWbWpEV0haWmZ0NjRreVRiN2ZI?=
 =?utf-8?B?clQyZktNczJHNENhaDUzMmVVcEg2YndzMllnL0NwS1phTGIxRDNWWjY1SWJu?=
 =?utf-8?B?cStvYWptYVBic3ZmYlFiRFdqRnVDdS80NG14ek1RR296MkJGd0c0b2J3UkU2?=
 =?utf-8?B?N3h3ZnBxNWtGNjlMTzR0Yk1SWE9ndnFWQUozY1JhNWtCeEFScmRXZXdWK2p6?=
 =?utf-8?B?RG1pMW4wZmo0d0ZUV0djNGlYcjRyUFRVRzdlR1BVb1VkZGFFOWFra2Y0TTdG?=
 =?utf-8?B?RzdDdllITFo0cy81V3V6YnZCVFpTbHc5M3JrVXZBYnJ1UHdBUktBRExUOXNq?=
 =?utf-8?B?eDMydVpXdXkvSFkvVHkzK3dncnkzM0x1VzRnU2RQOUN4b2taWUcxdFl0Y29j?=
 =?utf-8?B?SjRmRWZWbjg4N09YQlNPOXlvVnhKbTZIbmh3MTkveGFvV2M1WnphK0NlUEJo?=
 =?utf-8?B?Y3pCeGJTK3N3Z1JsdnFkbkZ4R0piTnB3OGgvODFzUHFPOStJZm16d0xOcTd2?=
 =?utf-8?B?ZFIyeG5qdDZvVldMWUZhbysyR0VrbUkyUlhPTDdOeWI0a2s4L1hHNEhMa1dl?=
 =?utf-8?B?QUwranpTTUJsa3MzOFk2cGVGZjFlRzhGcW81RUp0bnpIZ1poY3NOWmNNQmV3?=
 =?utf-8?B?VFFMeWxJbFBINElwZjROV0xkcFp2M2x2NzRRSE5FVmRQQTRicGhzR01uaUl3?=
 =?utf-8?B?Z3AwS2thY1IvVVd4NlZoV1dHVkRyVWhlbHhpQkJyUEJHa0Jkb1dVSGJBSFN0?=
 =?utf-8?B?WkY2cGIxcG5XRUY2RzAwWUJrL0ZUQmVUN243N1VUSUg2R1hnU0xjdllvK01O?=
 =?utf-8?B?VytpNE9pd2RGbWR1S0wxclFpUnI4WGp4cm1mdnZ2QVJ5cEJUdHg1V1A5dVEy?=
 =?utf-8?B?WWFJNEh2RUlEMHFTclJlZ2JMdU5yWHVBZjNwWUw4MUxVdGlJRVo2N0NjVUxD?=
 =?utf-8?B?N2lLNDZhVWkzVEQ2cVR0aEhsazZmOWJNRHVuQkV6cm44ZFRUNUVyZXRJMEhq?=
 =?utf-8?B?NlBoLzJUeDNVOUpsMGZVZ0lVRUdLeEZpK1RxRS9nYmMyTE5tMHFvakxWT3Yv?=
 =?utf-8?B?Uy9GTG1hWTdkeWdjTzNjNW1zY3h1L05YK3UwemdwakVyRnhrNHdLUSt1NTAz?=
 =?utf-8?B?ZWNNamRYVFRvU0hhRXo0M2FndW5aZk5yVi9HODBUbkFnMktqVmN4TlhaK3ZS?=
 =?utf-8?B?bm94YTBJMXpEWnh0TTJNRnZuTVhpSmhxZUZnckNvOUhGY1N3ZUtHNG1pczhX?=
 =?utf-8?B?SzR0UDAxWmNvM3hWbi9Jb3JWakFId3pDY3hxK2lKTkNBV1o4Zk9xR2YyekFQ?=
 =?utf-8?B?Rlh5N0NERUpDM1E3eWVDNjlEaUxYWklkTll6OC9ZQWRkT21maVVTZHhic3FU?=
 =?utf-8?B?dllsNGwxQUM4R3hzck9EVWY0a2YxSFl2SkpMclN6dWo2ejFGWEU0Vmd6blpM?=
 =?utf-8?B?Nk1DMFR0cUdZelRDVDl1Yk1UZG1reEUvNWh3NXptdU9vMy9JcUZDT042S2xh?=
 =?utf-8?B?SWswbG0xQnBLbU5UaGRZemRwUFdYYkhrUkVEYTA2d3BGOWVhRkpMQXhmVFpw?=
 =?utf-8?B?ZFN2SkpPTmVZWmt4dDhTRUhRTXcwOGhmalEwak5WTFNiRytIb0dheFA4cWNv?=
 =?utf-8?B?Z0dadU9MUVFPRGlPTk1QejlPZ1JxT3JiK214QkovM1d4WGw3eXpUc1dUTjRj?=
 =?utf-8?B?MjlZbFlYVys3OGhDSDNoVUtESjVVTEpwYUY1VTV1MUdHV0JyczFYY1BnSVdC?=
 =?utf-8?Q?cGU2arj6wUlFYlBcmzWhJ9QuV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f6c3d4e-8a83-44dc-016f-08de18622536
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 09:44:54.7843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1AhcSTlVB4Sk0SjnYsdkm7I87F/j69XwXQ9ukbsr6o41uJeeQV6bK3yLA4OUybd7pM9ffd4xQtrxr2nq3h7yVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB

On 10/23/2025 11:50 PM, Jason Gunthorpe wrote:
> AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
> and it can decode the full 64 bit VA space. Unlike other x86 page tables
> this explicitly does not do sign extension as part of allowing the entire
> 64 bit VA space to be supported.
> 
> The general design is quite similar to the x86 PAE format, except with a
> 6th level and quite different PTE encoding.
> 
> This format is the only one that uses the PT_FEAT_DYNAMIC_TOP feature in
> the existing code as the existing AMDv1 code starts out with a 3 level
> table and adds levels on the fly if more IOVA is needed.
> 
> Comparing the performance of several operations to the existing version:
> 
> iommu_map()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     65,64    ,      62,61      ,  -1.01
>      2^13,     70,66    ,      67,62      ,  -8.08
>      2^14,     73,69    ,      71,65      ,  -9.09
>      2^15,     78,75    ,      75,71      ,  -5.05
>      2^16,     89,89    ,      86,84      ,  -2.02
>      2^17,    128,121   ,     124,112     , -10.10
>      2^18,    175,175   ,     170,163     ,  -4.04
>      2^19,    264,306   ,     261,279     ,   6.06
>      2^20,    444,525   ,     438,489     ,  10.10
>      2^21,     60,62    ,      58,59      ,   1.01
>  256*2^12,    381,1833  ,     367,1795    ,  79.79
>  256*2^21,    375,1623  ,     356,1555    ,  77.77
>  256*2^30,    356,1338  ,     349,1277    ,  72.72
> 
> iommu_unmap()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     76,89    ,      71,86      ,  17.17
>      2^13,     79,89    ,      75,86      ,  12.12
>      2^14,     78,90    ,      74,86      ,  13.13
>      2^15,     82,89    ,      74,86      ,  13.13
>      2^16,     79,89    ,      74,86      ,  13.13
>      2^17,     81,89    ,      77,87      ,  11.11
>      2^18,     90,92    ,      87,89      ,   2.02
>      2^19,     91,93    ,      88,90      ,   2.02
>      2^20,     96,95    ,      91,92      ,   1.01
>      2^21,     72,88    ,      68,85      ,  20.20
>  256*2^12,    372,6583  ,     364,6251    ,  94.94
>  256*2^21,    398,6032  ,     392,5758    ,  93.93
>  256*2^30,    396,5665  ,     389,5258    ,  92.92
> 
> The ~5-17x speedup when working with mutli-PTE map/unmaps is because the
> AMD implementation rewalks the entire table on every new PTE while this
> version retains its position. The same speedup will be seen with dirtys as
> well.
> 
> The old implementation triggers a compiler optimization that ends up
> generating a "rep stos" memset for contiguous PTEs. Since AMD can have
> contiguous PTEs that span 2Kbytes of table this is a huge win compared to
> a normal movq loop. It is why the unmap side has a fairly flat runtime as
> the contiguous PTE sides increases. This version makes it explicit with a
> memset64() call.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

> ---
>  drivers/iommu/Makefile                     |   1 +
>  drivers/iommu/generic_pt/Kconfig           |  12 +
>  drivers/iommu/generic_pt/fmt/Makefile      |  11 +
>  drivers/iommu/generic_pt/fmt/amdv1.h       | 391 +++++++++++++++++++++
>  drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
>  drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
>  include/linux/generic_pt/common.h          |  19 +
>  include/linux/generic_pt/iommu.h           |  12 +
>  8 files changed, 482 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
>  create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
> 

.../...

> +$(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
> diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
> new file mode 100644
> index 00000000000000..1f46e4ab4aea51
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> @@ -0,0 +1,391 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * AMD IOMMU v1 page table
> + *
> + * This is described in Section "2.2.3 I/O Page Tables for Host Translations"
> + * of the "AMD I/O Virtualization Technology (IOMMU) Specification"
> + *
> + * Note the level numbering here matches the core code, so level 0 is the same
> + * as mode 1.
> + *
> + */
> +#ifndef __GENERIC_PT_FMT_AMDV1_H
> +#define __GENERIC_PT_FMT_AMDV1_H
> +
> +#include "defs_amdv1.h"
> +#include "../pt_defs.h"
> +
> +#include <asm/page.h>
> +#include <linux/bitfield.h>
> +#include <linux/container_of.h>
> +#include <linux/mem_encrypt.h>
> +#include <linux/minmax.h>
> +#include <linux/sizes.h>
> +#include <linux/string.h>
> +
> +enum {
> +	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
> +	PT_MAX_VA_ADDRESS_LG2 = 64,
> +	PT_ITEM_WORD_SIZE = sizeof(u64),
> +	PT_MAX_TOP_LEVEL = 5,
> +	PT_GRANULE_LG2SZ = 12,
> +	PT_TABLEMEM_LG2SZ = 12,
> +
> +	/* The DTE only has these bits for the top phyiscal address */
> +	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
> +};
> +
> +/* PTE bits */
> +enum {
> +	AMDV1PT_FMT_PR = BIT(0),
> +	AMDV1PT_FMT_D = BIT(6),
> +	AMDV1PT_FMT_NEXT_LEVEL = GENMASK_ULL(11, 9),
> +	AMDV1PT_FMT_OA = GENMASK_ULL(51, 12),
> +	AMDV1PT_FMT_FC = BIT_ULL(60),
> +	AMDV1PT_FMT_IR = BIT_ULL(61),
> +	AMDV1PT_FMT_IW = BIT_ULL(62),
> +};
> +
> +/*
> + * gcc 13 has a bug where it thinks the output of FIELD_GET() is an enum, make
> + * these defines to avoid it.
> + */
> +#define AMDV1PT_FMT_NL_DEFAULT 0
> +#define AMDV1PT_FMT_NL_SIZE 7
> +
> +#define common_to_amdv1pt(common_ptr) \
> +	container_of_const(common_ptr, struct pt_amdv1, common)
> +#define to_amdv1pt(pts) common_to_amdv1pt((pts)->range->common)

Unused macros?

-Vasant


