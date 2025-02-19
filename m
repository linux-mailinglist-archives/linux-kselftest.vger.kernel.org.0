Return-Path: <linux-kselftest+bounces-26952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E54A3B8BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 10:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9F9189F957
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Feb 2025 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F151DE4F1;
	Wed, 19 Feb 2025 09:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RvmU39g6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CuWQD6gW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74E21B4F0C;
	Wed, 19 Feb 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956689; cv=fail; b=Jgei6s/HqVeHuILZdek6pDIeRswo7BhFuYT96UyzmHtE8zH+5AY+3MdCzhFrJHaPNQV/JJPj/IigSBhXAb5kwrrFXLq84rDYeN9PBJ17hY0Jl2oCPjV2GP68ifoCkDemxYCx1Zzrmnd+VXuilKx0GozqRpag85S4jllallmSSiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956689; c=relaxed/simple;
	bh=eH0LmM8R0NLrb/dKm4SzbTzfhkdBgM/XNteLMIyeMhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TVNLixIk5J4GXxR5ujNnDajqE11SpvK2elHjwOpAEWklf9D+EGEp9vT31++vrOoDLmD5J39ZP+bME4CTxARltAf509JMnpF0+Ajv1J1AIvWkTzmdaabrnVT9GkkbikxT7ahsCnX2EyzZn860sOKVao/6IfhP4iDi2C/vLpPV0ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RvmU39g6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CuWQD6gW; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J1v1ol019291;
	Wed, 19 Feb 2025 09:17:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=eH0LmM8R0NLrb/dKm4SzbTzfhkdBgM/XNteLMIyeMhg=; b=
	RvmU39g6dLn6KLs/sdClTFWfFu0n9RuvytQQsJKd6XxKABNc+QEuyWyo11PS/FIA
	KFRkek/a5jFzEnnzvrpHsbO90zP8FIox3uOMsw8NuR4U14W2NFV0sKVD3Ag/CCGs
	VzgF97AY7UWnN+hOQaXaOErKd2gCS09fnTUffJhj7UDvRFw3NyXZmF08mIcaEX0W
	uH7v7YpvVD+YUj/fa314vHxr659iGOopYmhUrzABA13Nzh3IOHI2qURznVWCd+X8
	izAtZPk/mv+Qi1kSRu7wobMDk1iqrZeT1Kba0Yzb1TYJKLpGg/6H/NN9JOZMZp1k
	RX5TzTOE0RPo5aEIkmKeVQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00ms6n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:17:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7kqjV025217;
	Wed, 19 Feb 2025 09:17:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w08w7rh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 09:17:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S8mMKucLLO7AKeqdLeRpDyQ6f4Ovytu+7A/GqssYG0uw/Z87Qkvw0PxDTyCxp6ZXlgLk1guap2X9u1s/yE5NNthwr7iwaREs3jha+W84C2jlybijW6ofU24KDO8O1drs6kEXBgNV+Ma2Z6uDMCfN9wPf/nZBJ/yNXUnkOvgm1UaPrIUXS46bnqdBA+7ZLDp3KdSZfOiVaEpDIPJp4/LDw8nGn2A0+yTSN1w0WWLpUty61Bmr0dSL8eu+PRntlbIMVo5J+bX2dFrA6KdnvYq+Ky6b6mh6Y1TwIkVDMmRIdbD/0WdHcHJksrzf68YoBJQWqhclx1gFYLxcrEkfNAH8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eH0LmM8R0NLrb/dKm4SzbTzfhkdBgM/XNteLMIyeMhg=;
 b=Chz6vyWP7u5BnR64Os/BCarxWA1xQRLEmkcGvL2m1Hx0fKjYG8uhbAStI0EtNQq30DPob1mJrgXdVS7jCqvffUj9eOKVk+tqjD/gWqWG4Nqu9FJd58bLKLbqC4KnDTolXjxD8t8NCqVDxuNQlb0dM4ZLz8sLUOLkQO+YL0dB28iIdhYM3FFmtRYP/fxKnSwUaP0mycIJrGWE2q0RrnLUWj7uVDSyekemEv6hGZrAlEf5N9N6JXscUhNeokQF6vpogEb18HhQWBMvR2kzpfCLBPlQ595/mHf6xKMxHHvaG8w8mgAbJnD6gsZ+lI1b5+g8EsKEANFI4CA4XNQ4Tv2nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eH0LmM8R0NLrb/dKm4SzbTzfhkdBgM/XNteLMIyeMhg=;
 b=CuWQD6gWB1/RHsTQpHy106bjrxIEoUFMaQwhDWTZtsgiAXfLalhRXgl7dlytZZX43eg8AIzyGyY5hF+rnAASsm69BWsraKBbw0maoUfQg6iik44MtD11YEhPY43UbPqmSC3Mbog1LNe8/+rPow4fuzdDmXrjV/Tmsvt/orvWCIA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by MN6PR10MB8000.namprd10.prod.outlook.com (2603:10b6:208:4f5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 09:17:46 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 09:17:46 +0000
Date: Wed, 19 Feb 2025 09:17:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Juan Yescas <jyescas@google.com>
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
Message-ID: <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <CAC_TJveMB1_iAUt81D5-+z8gArbVcbfDM=djCZG_bRVaCEMRmg@mail.gmail.com>
 <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
X-ClientProxiedBy: LNXP265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|MN6PR10MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 559686b9-c82d-4a18-cb9d-08dd50c645c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtCYUFHWEZNTkRobXFzYzlLbzlHQ2xDK0tPY3Y4ejJkcXd2NXlaWGlvRUVK?=
 =?utf-8?B?QUE2dlg4VTgwVkthSHdPcVZhTTgrVitTajc3TCtWZWYxdStKMzIrV3I5d3dE?=
 =?utf-8?B?eWJFTTduS1ErVXkzZ3JJYWVZTXFCK05MOXBIL2w5cjBJei9XRXpvWHgyem1N?=
 =?utf-8?B?VTVNbmVCY0todkRUYXJ0RHJjV0hYc0VRRHZTQnFQRjZiZXpob242ZkdwMDcy?=
 =?utf-8?B?R0x2Slh3OUV6Vks1bVgzSnl5TzM3TGRmZU02UXpOWFA5UW1wMEVXVzdPQzJW?=
 =?utf-8?B?cFJ6YnJycEN5TlIvRDM1Q3FuMWtmWmNSWVVZajRoNVJwL0NDZVMyV1JVSnc1?=
 =?utf-8?B?djg5N2RRVjhvMjdMcHJ2YUozRHNVeWE5aTJBMURoOUI4TzBoT1ovRlV3RU5T?=
 =?utf-8?B?YkxUQ3BlUVNvNmlLVmcwbzA1TzZWOFZNbUtQbWRQS09VUzR2Sy9wU1J0cTlY?=
 =?utf-8?B?ajNKUGNWY0JBL3ZrU29tcEtwZHJZajEvUzgxbVpDU0xjTHkwNTFIZ2ozdUZT?=
 =?utf-8?B?RWhWVVpONDJFcGRwWEUvZ1dhY3RlR1dSVFVPNGZoZ2NMdTZDekVBUFdyZ0l5?=
 =?utf-8?B?MStjeWhTdUlONnh1OEp6Y293cExCemc2OXFMdU5BazRaWnVIN1lINTlkNER4?=
 =?utf-8?B?TU1LNkdZSkRTWThaeXQrdklYOVNOaGg0dDRvbFNWNWNxMkFnWDhGbzVNMS9K?=
 =?utf-8?B?a1YvNGVLdkl4OUpsSUwyMllDNkorcHJxcEZ4R3YrdFRmNFdrZUpEcnlqcXV3?=
 =?utf-8?B?RzhVeXczRkhZRk1WY3JGSDdRS3RVMVI5TzB4VUZYWXpWd3NEVVdhY2ZjRngw?=
 =?utf-8?B?TjVrUEJxRWxwL0xvcHM0TjBTQVVjZW5lR1h3elpBUkY0d2I0a1M2aGVSV2JV?=
 =?utf-8?B?WFNvTzFWQzVyNkpyOXp5MlY4V3ZzMG9KdG5SL0NKcVJhZ3RyL2xxdE5VZE9R?=
 =?utf-8?B?aUlZSnl0RlFiV2xOUWxUSEc1N1pxZUcydVdUckZrdTkvaEYrRXVNUzhLRFd0?=
 =?utf-8?B?TGZva3RGUHNKY3pNNHZmSzBpa0liVmtGa1dVZ2tZQ3A3eU4yYzVFL29xRGZa?=
 =?utf-8?B?ZzZXaWtrbXIxbzdENDVRTnNpN2pEY3hUZlhJY0EyaHZaTDI3VENRbEhaMnRu?=
 =?utf-8?B?azI3clRXVlVPNTNzMjNZaEFFcHllVFRwV2dWZUdqMXhTL1Yya09ldE9jZVp6?=
 =?utf-8?B?cUZPU0twRU51TStpNEUvZVM2QTBNdU5qTkt3TTduNVU2M0hicUY0UGJIMHhh?=
 =?utf-8?B?MDhWVG1ybEM5S1lyN2JpbFFJVk5UYkRnaVNpaDl2OWpxOFJoem4yRXBZT1A1?=
 =?utf-8?B?SXhvKzBUREJubnhNbTl2bjFiNzRqRnZJbDlvR09zR2hCUWF0QTdEYUZlSFlt?=
 =?utf-8?B?T1lUZVhjZ20vZkgycG5UWmVkQzFwNHF5dmRSZkNWMDAvWWwrVkFOcnA4OGZz?=
 =?utf-8?B?dUx0N1RkL3hYTStiSzBCcDdxaUZrcEt1c1Z0WVllQzlmYTU4QVE0VVluU1R3?=
 =?utf-8?B?V1VCOUlkdUZlRGsrOWJEYUNLRVdrTStMZDlUZWpmNUM1WjZneWdWUjd2VVZ4?=
 =?utf-8?B?RUt6eDJoV2ZYUFpRc1JoNXREUFQwNFJTNEsyUFR1dFY5R3RtMTZ0VGN4T2E0?=
 =?utf-8?B?OE5vSVF3MDltODVPeUhVSFNyeXMwQmQrT1ZEejhKZ1d5ZDhNQTZkUUFNbFJR?=
 =?utf-8?B?Vnh3bFU4dG1rN2haVzNibmFQRDJMUGt6R0Q1bFRXVFZqUUdWV1JKZ1RKYUxX?=
 =?utf-8?B?djc1MjNFM1RBMGtrYmVHWWxoQkt1VTZsMEx3TWp6MnkvOTZGMFFTOEhwb2pC?=
 =?utf-8?B?RExnMzZsRGNPUzMzTTFiMExJeHh4ZUFQVXBPaUpicHdPRXFKOTNhcFVvQjhh?=
 =?utf-8?Q?GDEfFlCRBw55L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFNmZVdVaUMrUnRWVlA1bXRrRm9CMXNHRlNUblZCZkxmMHBSSFNhdnp3UGZj?=
 =?utf-8?B?R28yNzJwOUExT1phS0twVnI4NGVoZ3pMc2hhKzFJdmNXcFlqVnBSVnZNaklk?=
 =?utf-8?B?WTN0QWZIZE1uMjZEWHViRk5DY0l5VzlhVXRIZEJaK1VqcTU3aXJPTXFYdkZV?=
 =?utf-8?B?ZFVxc2VrRnVucUhIRFJkRjNKRHBhLy9Pb1oyckRWMU1KcWxHUXlpVzJob1I4?=
 =?utf-8?B?Q1lzVk14WmJncndUQ3ViNzB4K3ZkY1VXTkUrQnhkWGhkbEFZLzd6K2dUSkZP?=
 =?utf-8?B?bFVlejcrd2R0NkJGVTZjMSs0U0UvN2FXampKMU15ZEVRODQ3YWRVNUhob1Nh?=
 =?utf-8?B?Ukcycmp0N1ByY2FBRFZNY1puSElPVEc0VS9UYXJ1UGZDSFN1SnNsRlhwMFp6?=
 =?utf-8?B?M3QrNWxJc052aUpyVnN0bnc0RWNMd054c29LRjc2eTU3ZitQSW5MeWh1cEJl?=
 =?utf-8?B?cmFNcytKN3dsRkZ3OTJsZ0g3S2FnSGhxZERkZEZObVFkL3BxUXplRUFSWVZ3?=
 =?utf-8?B?eXAwTE16bURWSkprQnA2TGxzQkNQRkFkN2F6cURTOURaa21zV0RzRGtqdGxS?=
 =?utf-8?B?VEFScHllVnVCZXlBYnkycEJqS003ME9RV0FnNktTVjNJSFF0NlNZZS9xb3VC?=
 =?utf-8?B?elRJYkZSUlNISWZzcTBzbGZSZ0MweHNhdWZ1cGczbkZnZ1BMRi9tNXJ3dkNC?=
 =?utf-8?B?RjkvTUFKWW5oNjJwamFmdVlMMHd5aEpuZm5rS0phSjRDMjNrVXA5UnRXelFn?=
 =?utf-8?B?YnVibDRLWXRYQlM1cEwxaGJUaFdBNFdFSFpQMXhOVzZDOHpmYVI0YkVPTlZL?=
 =?utf-8?B?WExKU3QyMzE5L1ZYMFc3YXFleC9HWHAwek8vMno2dGNPcHc3SlZOejU3QktE?=
 =?utf-8?B?bGhyWGY1eGZ3Vkt6MVhSWEtwbDdiQW1UREI0cVpWRmJZOWgxemd3UFFrYzhh?=
 =?utf-8?B?VkpoekVKUFE2OEltS3o2MUJSRnVuNG9mZjIwUEdzRmVvZUk2d0NPRXhxZThG?=
 =?utf-8?B?QUNvb1hjN2tPaWlJVzdVZG5pTUNGTE93eWRYanRzaGpjU0xEblRQdjQzOEJz?=
 =?utf-8?B?ZFBBQmZZYU9QRDhzTzNuSHIydlZFSEZYRk52L1hpdUhQcXZFczBkVVVlanpv?=
 =?utf-8?B?MEhseDJvSkJRd2crS2VsbEF6dTI2T1A4UGdweW8rUWJXcnR0NW40aE1qT2pW?=
 =?utf-8?B?Wi9MVkRCRVZWOEpYeWh0T3pGNVNtVWhPS0lGSklwZFVmT1NUb0gxTU53T2lZ?=
 =?utf-8?B?dWNKNnJLWEVOcDJJeFJxWUlpVmdPR3l3bG5OcTAvTVlRTHdSRTJsMkFSemNT?=
 =?utf-8?B?SUZJdHdLYU1RT3dUdWE4TG1ZQ1dwMmNiTW15a1RoQkNMUWRMcHhIODNJZkxu?=
 =?utf-8?B?aGREbEVhTGh2VmNaaG5Ya21CRUNkTzNCZnFUajNDRnkvR0dvaVJ6Zk1IYTZm?=
 =?utf-8?B?MGRSeVNYN2lENXR4WWZORzlPajIySitTbTJvYVB6enlIYTlkSXdUbDh5WUxq?=
 =?utf-8?B?dzM1QWUvK2ZjSnJCWlZnYzg0dk11RVJ4WmZnNXo4V1JkUm5jdmFJbE40RlpL?=
 =?utf-8?B?LzVheTFjQnAyemJzTmhaSUNrTW01enNPUmMyNkdqU3VJZzJUQnB0Z3JPNmxX?=
 =?utf-8?B?MkpqZ3ErVGVqeWc1dE1vMFhNUG1DSEhmakxlZWtxQzRqTE14TVJMU3pvZFVZ?=
 =?utf-8?B?WlJkWWdtUFN0a0l3SE9qWFBoTUdXdVJjZ1VxY3VnbHNaY2NjajlheVFsb1hW?=
 =?utf-8?B?WERmZm9yUE1sNXBTNC9IeldET0tFeFJzRFAwNFpJMTZXMHJCVng1N2NCVHBB?=
 =?utf-8?B?L1NnWS9FbFVTYVl1RVphUDBGTnAzTGxxK3JxWXlqdkFpaW5UL1Y1NVZUamJC?=
 =?utf-8?B?MFNpcWxTbkRsUzRKbXBsREM2anJ5U3hZYStsZWNVMThOQ0tzWmlwRmhoZ3c1?=
 =?utf-8?B?MzlXNlIrSFAyWG95Y1NYa05OS2Y3QlBvRmFFMmowL09pV09WVEdLU1VpVlpq?=
 =?utf-8?B?d2RxZXpPZEo4Zk5FeUxUa2JMbTlvTzJSWUpSZlN2bnZGRHRJVWROYnIyYnhF?=
 =?utf-8?B?bUZGZnlHRk54ZEgrd3ZBb0JyaXo2OEMrUDUzQUtqUmJFelUzY1pRdWVKeCtH?=
 =?utf-8?B?UUdjV1JjaVVRczBoQzFVZnE0OGhiZGljZExEWVd6QnhyaXk4U2pxVGE5VDRk?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Edn6UbirIuIxP/mDzxmycDKaAL7Vcm6uka4avZBwZljt4z4eFEGPCvhX2SMm0PeQhnCV3Hj3UvWCzoTD1e1plluDXwSovNdrnZO8ktSPzabvzeBOPlFFSXsO7lQpJJ/a4RvRrigkI6qVHWCzAbLR9SO3ukTnLc0ao440cfnkfx8vRiJNJ7iFt4aDS8g16/EiCebo75jzi828zmaRKr5XzvyyvJWBPydcPmehRdhOEGDwe6x/Yp15BF3Ek5QV3WW/AvGE9OmW8dTV8gaoaShsFi1ZCbI7HDVl4BrKgms2BQNgbqMZAMI76zpV5Sl2WKIOvjIzedlW78MBJoGZQ+w0kahKXoEVi03f3xmnxAHCZ9BTh/3boeSDe6/HAXiWt8nqy/1hEhW2r9MwrfsYNuOZuEUZf5ndQHB2C77Q10/UaSw3nrSIWiQAmW6VzjjC80mYJGu5Xr4AgQjoZSSUIKsvNAseAEJtARCKpoxhhYn/j2qBWtUfGkiidzJWIwPaKD7kZqLuiimETg5W/SzZg5Rv6O3gSQ/oN7L2/vFx9cKkqkFF5be4Gsrb4K7KKbjcEUhatM7XEGXsLF1yr/1b6wqO/IwkMltIn1deU2Cxc+uW97I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559686b9-c82d-4a18-cb9d-08dd50c645c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 09:17:46.1661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /5XoVbU7ISRsl/NzmzWBd+fOs1ajbusXG8FWxpExWeRIwZVR+xI6vntJZU5oVcAbOFLL1ER+XqLSllPX+QfpwOhGN+4NXLg2fvuqZ8wLTqk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_04,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502190073
X-Proofpoint-ORIG-GUID: 7NA4n9kehChZHDL-BVcqgngFALeieI8m
X-Proofpoint-GUID: 7NA4n9kehChZHDL-BVcqgngFALeieI8m

On Wed, Feb 19, 2025 at 10:15:47AM +0100, David Hildenbrand wrote:
> On 19.02.25 10:03, Lorenzo Stoakes wrote:
> > On Wed, Feb 19, 2025 at 12:25:51AM -0800, Kalesh Singh wrote:
> > > On Thu, Feb 13, 2025 at 10:18 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > >
> > > > The guard regions feature was initially implemented to support anonymous
> > > > mappings only, excluding shmem.
> > > >
> > > > This was done such as to introduce the feature carefully and incrementally
> > > > and to be conservative when considering the various caveats and corner
> > > > cases that are applicable to file-backed mappings but not to anonymous
> > > > ones.
> > > >
> > > > Now this feature has landed in 6.13, it is time to revisit this and to
> > > > extend this functionality to file-backed and shmem mappings.
> > > >
> > > > In order to make this maximally useful, and since one may map file-backed
> > > > mappings read-only (for instance ELF images), we also remove the
> > > > restriction on read-only mappings and permit the establishment of guard
> > > > regions in any non-hugetlb, non-mlock()'d mapping.
> > >
> > > Hi Lorenzo,
> > >
> > > Thank you for your work on this.
> >
> > You're welcome.
> >
> > >
> > > Have we thought about how guard regions are represented in /proc/*/[s]maps?
> >
> > This is off-topic here but... Yes, extensively. No they do not appear
> > there.
> >
> > I thought you had attended LPC and my talk where I mentioned this
> > purposefully as a drawback?
> >
> > I went out of my way to advertise this limitation at the LPC talk, in the
> > original series, etc. so it's a little disappointing that this is being
> > brought up so late, but nobody else has raised objections to this issue so
> > I think in general it's not a limitation that matters in practice.
> >
> > >
> > > In the field, I've found that many applications read the ranges from
> > > /proc/self/[s]maps to determine what they can access (usually related
> > > to obfuscation techniques). If they don't know of the guard regions it
> > > would cause them to crash; I think that we'll need similar entries to
> > > PROT_NONE (---p) for these, and generally to maintain consistency
> > > between the behavior and what is being said from /proc/*/[s]maps.
> >
> > No, we cannot have these, sorry.
> >
> > Firstly /proc/$pid/[s]maps describes VMAs. The entire purpose of this
> > feature is to avoid having to accumulate VMAs for regions which are not
> > intended to be accessible.
> >
> > Secondly, there is no practical means for this to be accomplished in
> > /proc/$pid/maps in _any_ way - as no metadata relating to a VMA indicates
> > they have guard regions.
> >
> > This is intentional, because setting such metadata is simply not practical
> > - why? Because when you try to split the VMA, how do you know which bit
> > gets the metadata and which doesn't? You can't without _reading page
> > tables_.
> >
> > /proc/$pid/smaps _does_ read page tables, but we can't start pretending
> > VMAs exist when they don't, this would be completely inaccurate, would
> > break assumptions for things like mremap (which require a single VMA) and
> > would be unworkable.
> >
> > The best that _could_ be achieved is to have a marker in /proc/$pid/smaps
> > saying 'hey this region has guard regions somewhere'.
>
> And then simply expose it in /proc/$pid/pagemap, which is a better interface
> for this pte-level information inside of VMAs. We should still have a spare
> bit for that purpose in the pagemap entries.

Ah yeah thanks David forgot about that!

This is also a possibility if that'd solve your problems Kalesh?

This bit will be fought over haha

>
> --
> Cheers,
>
> David / dhildenb
>

