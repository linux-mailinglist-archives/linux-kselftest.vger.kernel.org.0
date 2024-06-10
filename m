Return-Path: <linux-kselftest+bounces-11598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0419F902971
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 21:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319A028299F
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 19:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9175714D2AB;
	Mon, 10 Jun 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mwwj7+Av";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CV6a/I2/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A32C1EB5B;
	Mon, 10 Jun 2024 19:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718048515; cv=fail; b=eMsxDnb/vy1um5VO7cKFiV/E/mQ7EkPtsArIO1yV78oPnEja2XpL0SOShWTIayR8fSA4bKeWit4TiwuUriAQJ0lWAhekh3T9QmKjLZ09XOAfdqad0F3Yar40ov2SrTp9C6Se8Th7kKqYchr4WZFNIGnq4audOxMIGQpBOuKeYhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718048515; c=relaxed/simple;
	bh=8rBqjw75NWWBNVFhZ8qrTggKRolKEGgbjpxJCeji1QE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmdBcy4Ql0xZPVWlWxLST9Om8b/WoZTwaZuOmtwwHNeTZVjiCNU7JfosPzDChF+W8EeFMvnPJJ2nFahf1z4B7zShMnBbmMTmndU1y9fbkQZVUB+uvAf3ITO2S4ebhiFlpGbo9JtjqfrFcUoh38yAt2WnWDCi8bL4UFoB3U4aLvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mwwj7+Av; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CV6a/I2/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEMPqs000357;
	Mon, 10 Jun 2024 19:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=KtyAUu61yVqq/ZS9JrQa7uk3L/U+1TpvxmxNLLDaCtI=; b=
	mwwj7+Av/BEWATGn1gLcrMbC/+1rDnRi/MO5gTmK5u+B5qEXX8GKOYgh2f7AOD0x
	VV1UKwcFjf9SY7m0Hxv/kn6a+HGNwCDzA6XA3pliYB6Ni3Dw9uhzgPuCpqJMe+UG
	ancvaWtvIv2NtPPi72VTILKymEPavZA/5yutXhTMZ/i5HZJkQeP5uHtubmmZFiKZ
	fb/el4RVvNuCtXrm7hD1QdDlGS5oK3/61TpQkvTmTmSuqGpSAR4sgoOUcZ/3gJ44
	LkrjP6BsKdhWOMPKVxdRWGqy7aK/c86sub72/Paj+ozhIrU3IWw1n+KDGOx4N1Le
	eFDJfem7mSxMwl45L2qO7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj3d3e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 19:41:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45AHvoci020130;
	Mon, 10 Jun 2024 19:41:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync8w86h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 19:41:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRXL28kDh0JsqFf6GFndiQ3Zu5Xdx8TpEWU7Lh+sQ9qgrAG9g2o0I1xMHk2AIEi6xfEzRv5LNSPDkKWNS3arGAVIDGC9QBgZnGFABS9nyNgYBhJABVOeAr6+k4nnu4l7acHygLnOgtG6xolK0OESgdongEZZxRGYS3hGdAq2M94amm4kH+L9T5XcshfYz1wFbZVVcz2gq3f88CaLsowcbFIW/ciwh/Tp7TbN428FXUCIgY7wLgfB/SuCHsta6CaUj+AAtMa2i5MfXVmG2gqTw9EK9DEL9HRnpVBHpeuzoYaxAg1+2WMSMewzalbxYdsDF4bE+pB+ZKvpGWJ43+HyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtyAUu61yVqq/ZS9JrQa7uk3L/U+1TpvxmxNLLDaCtI=;
 b=can5CsHS4EqbF6Mg/7Wvv96kMh+Hqn8kDRCXx55ObJZMPuOaHOKL93pD4k15RE4H/vA6Q9ou29Gr4T1sCXrOuRMLRTy9qKvuMI6gFQHPKtqUjUT90jUeWWMDq9aSV1jZ7dQOJH36RGhGQbqyVFl0niaWplltmo21GSteWiHhahTtaPDImwAahMtVbAJN5MtVxi8AXGoxxOMyzBYXPJWAGrvOpyvp2ZvqdrWVwrf/7L7oblJ7CywoiRXRIj+Y/XzRx2fPA36ZU1tUkMwWqq8LYMBXTXrlvZydrZJ/ejgxHvT7b/MsC1HW6cVRrA6zW4M9vuZSXGECgX1lRLkdMVgIpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtyAUu61yVqq/ZS9JrQa7uk3L/U+1TpvxmxNLLDaCtI=;
 b=CV6a/I2/UsNbd7idTcVTlLsN0WeU0H3RiJHX0oASq1E6WUiQ+gVKrATLmLHAz5pXKF+/HnL70bGLCDaveFZM49PdYUmNHX2BfRfQqDBJhYlfjxJ1fqq8z7PknWQJSbcO6imldy9yr2ldoqWxW/rezlaUNbxrv00pvbBjrX+bFvs=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by MN6PR10MB8144.namprd10.prod.outlook.com (2603:10b6:208:4fa::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 19:41:23 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 19:41:23 +0000
Message-ID: <2738aa0e-99d8-44d7-ac81-e38fd64591b7@oracle.com>
Date: Mon, 10 Jun 2024 12:41:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] Userspace controls soft-offline HugeTLB pages
To: Jiaqi Yan <jiaqiyan@google.com>, Miaohe Lin <linmiaohe@huawei.com>
Cc: naoya.horiguchi@nec.com, akpm@linux-foundation.org, shuah@kernel.org,
        corbet@lwn.net, osalvador@suse.de, rientjes@google.com,
        duenwen@google.com, fvdl@google.com, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        muchun.song@linux.dev
References: <20240531213439.2958891-1-jiaqiyan@google.com>
 <21841726-6427-5a92-a3d1-8aac2687c01a@huawei.com>
 <CACw3F52Ws2R-7kBbo29==tU=FOV=8aiWFZH2aL2DS_5nuTGO=w@mail.gmail.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <CACw3F52Ws2R-7kBbo29==tU=FOV=8aiWFZH2aL2DS_5nuTGO=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0033.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::46) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|MN6PR10MB8144:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1f7188-6dd8-4ff5-7de3-08dc89854f20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?b2tyQnFrVlk2SXRxNWZDSzFObXJnOG5pQ0tOby84NjQzQW9xVUp2KzIvMGNQ?=
 =?utf-8?B?Q1dlU2hkczZlT21oTnVpcVhDb2p0b0FZUVhnSFY3b1ROZ3A5d21tWVdiejFL?=
 =?utf-8?B?cWJIOXZqOXJMSnV6QzJqVEpBa05KclFVT2F2bC94SGRpN0pvRWxKZFdNZmk4?=
 =?utf-8?B?OHdMNVB4N09ieGVLVHBQbDhqU1hXNUhqWFFVUVRpNHdCUmF2QWRDbVo0THM2?=
 =?utf-8?B?YUFkeHBhTVpBelRtUmM5TGVEV05ZT25KR1owT1lBLysrb1k1WVBXZGVCU1dZ?=
 =?utf-8?B?eFFrd3g2S2h5KzZZYVpubTdBOVNEWFNSYmFBN2lhckhXR0RPQ0ZTdWN2OVZy?=
 =?utf-8?B?ZEVXVXkvK3orM0UwVXA0b1ZYWStuQjE2YmF1TmhYL3lTc1JIbUt4RlZTcE50?=
 =?utf-8?B?S2JzcnRlZmlJUUovTC9Lakhnd3JtNWFqSytKZDJFbVlPRmR4MHhjTE5EZEdE?=
 =?utf-8?B?bEUzUy94Ukp1eVc4czBLSis1TVJUVnQxMzlBR0xTTks2MTltcG5FMmYxcWd0?=
 =?utf-8?B?WGRZaXRyZXBsTkFZRlFIM3pSYzY3UTh3ZDF6R1VVWTRIbzkzcTJzTmYrbTQ4?=
 =?utf-8?B?TTBVVFhCd3VtRytrU2VUc3Nrc3phWkVRT3A5OW5WTmZNTnFCb2xkTEtvL25F?=
 =?utf-8?B?SmFQOERBQU9TVWkyeU9LemExRUdZNDZCTUVSam9IdklNSWt0UTcwRzFpcktK?=
 =?utf-8?B?Qm9Ib3RXQ3FCby9UTnpKZW1EVXdManRGLzd4Yk1PTVpobW5qa1RuQk1FbEt0?=
 =?utf-8?B?aVUxM0VjUnQ4WkZSZG16SDFMeFVnVEdFQ1hZVzc1WE0vb0dKUG1FYXJ2UUdh?=
 =?utf-8?B?YkFzdEtzUFlnMW1yNmFZa2pROG1FUXN5ZWY3UkMzRitrK0dkMnNSTXpsQjB2?=
 =?utf-8?B?YUFLcXNjalovUWJuc2JMazVxTnBCM1VLbnB5QXR2WVNreE1qYkQ4TVA5SFhT?=
 =?utf-8?B?QXE4dUgxUGZHeUM1UVM4VmhiYmNpeTVCY24xWTdPYlk5cVdnOXJibVNkeTlE?=
 =?utf-8?B?cmwyZVJ3czlZR1ZEQjBkZHB3dy9ENU52ZDcxTlFxellpeDVVVUwvUW83V2FY?=
 =?utf-8?B?UllURXNWNERvZlZjbVE3TEREU0NsQzE1SUlLcEh4U1lwNHVzN3VWSXRqbWpo?=
 =?utf-8?B?a2g1WWpJdUNMM01GOVM4QWhWSnFvZGtXQ0d1dmc4L2c3ZW9YOCtsamVDcm1K?=
 =?utf-8?B?dVJZR1R1bzZPU2hHU0xudnZ5Wmg1TVlwR0xubDdwS3NQTXVJM3RvMUM1V2tm?=
 =?utf-8?B?ZkVkMDdxT0VuNENNTUJaOGFzRHVUTSs2L1J1bXFETE16V3Q2enduME1XOXl1?=
 =?utf-8?B?REVSMUhlRjFMSXVtb09pYWJjTGZ4MGdkZm9DditBanFQUFhrd21iRkhLa25T?=
 =?utf-8?B?MnBZamtqZHNWSnFRaXlFYU1UOHJmNEpKQnNOMUgwREUvcDVrSllKRzFUc25o?=
 =?utf-8?B?enJUeWFFRHRZaEkzRk51QUpYa2RJUVNkc1hOTUl4MDBsZ2FwZVRvSnBXTVAz?=
 =?utf-8?B?djFWRmQ1bDZ2TlEvK08yV0pmc1BxNXZCWWxVSUVta0x1QkVBS2RzMmhaZm11?=
 =?utf-8?B?dHVYWGcvZEt4Y21CVSt4RnA5NEZwdndNeS9xTU1vM2RIZTRGM0FEeHp2V3Mr?=
 =?utf-8?B?dENJVUxlMzk5SjlNTWlCKzV4cDQvbGhteXFQOWhGRkdQcmppMktuRWcrTE5N?=
 =?utf-8?B?alpHUU5kU28waWFCNGtCZ3AydXZWNFdOU3NvcUJ5N21BUEtnaWo3cDJyRk1D?=
 =?utf-8?Q?LTtghUqZR8li0Zr0ltLlBRVXnQb/hELeNAHjhBy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c3kyQUxSZUpYbVhBeXVwWHhMMGgxdFFDdTJhQ2F3L0ZSOUIwMHdGcDNYWE04?=
 =?utf-8?B?TCtNSnhhZUJRZzg0SzRidnBNTStoeUt0TlhzK0ZLSFo2aElQNHVwYVJCY2pG?=
 =?utf-8?B?Yld3NEFyMjBrRExtTnJkOGtwS2tKY1k1Njl1RXc2MjI5T0NVNEZpOENIeVZO?=
 =?utf-8?B?Sy9qaWx3M1d5NjE1cmJobGdLUUVRbVRoQ3VRSVpQNnV6VkRzeHZ3eVZRSGVi?=
 =?utf-8?B?SkpqUnZmMzNqZWFpYkVBblpzQit0WS94QTMyWGxlT1UvdHQ0MXZ2ZkdiOFFP?=
 =?utf-8?B?c1JRWnpOSTRLTm9DbnkxQ3FjdUdDMDFtVEpSNGN3cVc0UFhaVEhiU1p6L1Ur?=
 =?utf-8?B?em50U0NDbkx5c0dQWStTVExaaElyS1k2dDN3SVVpODlGY2w2YUltemNucXdW?=
 =?utf-8?B?bVY5YW5McURONTYvOENYR0JSangvdDRlVGZTNHpHSGcwR0tiVXV2ZHQ4ZC9D?=
 =?utf-8?B?VTJxVU56bmNzQVhIMHZiTUNQSTdpN3pXVS9OMlVYMTN0NXZHS01XckNsMkRU?=
 =?utf-8?B?VXVJbVNDZEhLYmM3Slp0ZUtDOTNzRERiNllOYXlOQjVwOEZMdWVwcXFqUTQ4?=
 =?utf-8?B?ZmxxYWsxYWVEMVFhYVA3SkxYK2FBKzRwTm9rQlN1UWl2ZDhOV0hGZkYvdXpE?=
 =?utf-8?B?blI4d1BlU1VBUzlOa3UvcTJVRUZZRFgxQllvV1pYVTZyOFQvckxNL3A2M2JF?=
 =?utf-8?B?YU1RZEllajg3eENvYVorMkhLVjlWYml4ZGZnMTBZb1IvT282cjlwMnNaT21R?=
 =?utf-8?B?aDJ6ZUhUR0xEdkV1d0VVQVY4YTFVdEFIQTFhZGZrS3dIa05UNkNUUmkzVXpl?=
 =?utf-8?B?Q05wMjF4MGpueWM2ZTBSMVgxQVdWdDNxZm9yOFJQelVJQzFqd3l6UUJ6Z0ZR?=
 =?utf-8?B?T21OWVZ1WmhKNkdKcFE0b0o0M0lLVSsvZ2YwTjQrOUg3c0hWSWV0YWk2ZGEy?=
 =?utf-8?B?ZUtpNTdaK1MzL2E2bnQwUG9NYjNKVkhoZUdWSkdxUjVLRWVsb0V2bmVtbWpD?=
 =?utf-8?B?SDNGaDJzRGQ2UWxIYjJiN1k1cklINVY0S1EreW9mYjU4TW4xUDgxZnpwdm1G?=
 =?utf-8?B?TGlUOWVmTlZQUzByTUVuUlBXd3Exb3A2MzI1ZXNPOHpKRWxEcHJ2aVk4U1hO?=
 =?utf-8?B?NlMybXRmUEYxVTFIYm95VWZGbm1UR2NSU014d1FISVRhNWRkZklSK0J0ZGNG?=
 =?utf-8?B?K25QTVVDTCt6b2NCd29GZmVTWVRZZ0Q2Z2xyNUYzeU9UbDNqMGFrdGl5Ynl1?=
 =?utf-8?B?dTJhdzhPa0cvTUlpQmtDVVJzNGJSSDVPNlU5QUh6bGQxSy9QYUFvcUREWE0w?=
 =?utf-8?B?Tm9zRWVVT3hYeXEva3E4L1ZEbFJ3NDJCM3YxSWJXaFNFN2dmWksvZjhXMlVp?=
 =?utf-8?B?NnNxZzRtLzRJOHIxZ2NQcnZFYUhjYW5UT295QjRqRC9WWWRrOUpUS2F2Tk1G?=
 =?utf-8?B?akJ1UFZlRmxIK0l3ZkxKaTdyMjZhL0I3Vm9XMGEycnNUOVFyalduaDljRjhw?=
 =?utf-8?B?SEtWQUJWRU9JdGZlaStVTXlTK2VvUGMzY2F5TDhhTjhreXJLdUIwL0xKV3dZ?=
 =?utf-8?B?cU1yK0tVYmlFZURNOVFlUSsyWi9UNjV6Y0tiSDhYMm55SjdhcGEzTkNvSWJK?=
 =?utf-8?B?SGMvNGtTbHBPam9tUlJOdEx3c3JYWEtlUmpDVGxwRXJYY2F3YTlmcGx3TUtJ?=
 =?utf-8?B?Y3lHN0NJeTBtcSticC9SMVd0SkM0bU5TUnYzeWpwNFdyZWVVY3ZJdWt4S1VN?=
 =?utf-8?B?MlJLTWNpaTNsUW5VblNrcXBCbWZiSzNNVkMwU0p3NmpBVHE1eU9md0NWZHRJ?=
 =?utf-8?B?MEl0V1hUSzluRmxGT3JidDBjdFVHazYxUHM2M1BHeE5iS3pCNFRIVDBhQ0lt?=
 =?utf-8?B?NXVMcmNyTGRFRjBtMWx1Q1N0WWpDSjJoQTVyUy9UaTlibjZVZVhRVVhBVkRQ?=
 =?utf-8?B?VGFRMXZRdVRIVlYrcHdpTUNsSEIxbk1uVER0ZWJFN3A3eWlpaG9IUXpBUVYv?=
 =?utf-8?B?Y09BVlNqcUlCUk5UL2tGVUs1VmhuSVBtVmdFSzRxVGFpa2ExNUU3OUNhaUpi?=
 =?utf-8?B?WFRiK2pVYlhZL3EwSWZiYnl3UjFNcS9MalM5ZkhsQ1BBS1laNGlVWkxJNDlM?=
 =?utf-8?Q?WoloXkWVjROUOvFLuepPu/B7i?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	SOEkQfqauKDEYxgePcW+0DerTl7rmGpPth3UjWaWFInNE54ZmktMiVpnP8uhGiaizzqKt159eZ9sKtvGTNRbQyHZVyMvnnzGWGS+zYVAJWO7sNJBQLbLQCXPq67nwGRQwnge8Nkj28OmdYA2jSKT7itN6FHhTAyEGV7XpIzQX3u3oJUy08s4fMGgXKydQ13LgcFgb9RSQqxDmasSB4Y9Jl/9Is9YMz48jbWX5kYrUpdbkVw5dngLyLstj2286f6FC25QQbXuj+t4mz4lmCS7+T3ofD2mTpHEBre/zlKXGZsvukJBYoj1iYzH2LrjDhZ6v6oA5DSjf3wI1MbWRAa1heX4f9joEf58V3ocMxzLGTjT+yt01ZXayMu8x8nN4M5xnsEouboAp8Tr8VTEDbQUm23+FgkJhwjyQq6U7idnY5wVWppEDt7689CB2HuHpux3+N3kZmVB0PQaOMqg+MHdO8uNN7jv7s5lJO4jobVHMzc1DnMm6stVr6TFAS9ay50XdW67pWCRXmPKf0AbEwgI+Zh60E/Z98qv4/V2nzNmIHpajnpLb0Z0CiplkBhO6hjancruYXI6esbNxsCla9Ou7tZSvX/31EOpVMjRm5S5ZTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1f7188-6dd8-4ff5-7de3-08dc89854f20
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 19:41:23.2066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L1q9Kc5yTJZp+DufXQMR21z/gpjQPJ4RQSWNIESXpsGHMEYbwlLBf8TPF5rYQZDGYzK8dBXBAckIImNSWwNzQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8144
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_05,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100148
X-Proofpoint-GUID: PFWRupz6sv_opArklK71VFNK34SPQJLE
X-Proofpoint-ORIG-GUID: PFWRupz6sv_opArklK71VFNK34SPQJLE

On 6/7/2024 3:22 PM, Jiaqi Yan wrote:

> On Tue, Jun 4, 2024 at 12:19 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>> On 2024/6/1 5:34, Jiaqi Yan wrote:
>>> Correctable memory errors are very common on servers with large
>>> amount of memory, and are corrected by ECC, but with two
>>> pain points to users:
>>> 1. Correction usually happens on the fly and adds latency overhead
>>> 2. Not-fully-proved theory states excessive correctable memory
>>>     errors can develop into uncorrectable memory error.
>> Thanks for your patch.
> Thanks Miaohe, sorry I missed your message (Gmail mistakenly put it in
> my spam folder).
>
>>> Soft offline is kernel's additional solution for memory pages
>>> having (excessive) corrected memory errors. Impacted page is migrated
>>> to healthy page if it is in use, then the original page is discarded
>>> for any future use.
>>>
>>> The actual policy on whether (and when) to soft offline should be
>>> maintained by userspace, especially in case of HugeTLB hugepages.
>>> Soft-offline dissolves a hugepage, either in-use or free, into
>>> chunks of 4K pages, reducing HugeTLB pool capacity by 1 hugepage.
>>> If userspace has not acknowledged such behavior, it may be surprised
>>> when later mmap hugepages MAP_FAILED due to lack of hugepages.
>> For in use hugetlb folio case, migrate_pages() is called. The hugetlb pool
>> capacity won't be modified in that case. So I assume you're referring to the
> I don't think so.
>
> For in-use hugetlb folio case, after migrate_pages, kernel will
> dissolve_free_hugetlb_folio the src hugetlb folio. At this point
> refcount of src hugetlb folio should be zero already, and
> remove_hugetlb_folio will reduce the hugetlb pool capacity (both
> nr_hugepages and free_hugepages) accordingly.
>
> For the free hugetlb folio case, dissolving also happens. But CE on
> free pages should be very rare (since no one is accessing except
> patrol scrubber).
>
> One of my test cases in patch 2/3 validates my point: the test case
> MADV_SOFT_OFFLINE a mapped page and at the point soft offline
> succeeds, both nr_hugepages and nr_freepages are reduced by 1.
>
>> free hugetlb folio case? The Hugetlb pool capacity is reduced in that case.
>> But if we don't do that, we might encounter uncorrectable memory error later
> If your concern is more correctable error will develop into more
> severe uncorrectable, your concern is absolutely valid. There is a
> tradeoff between reliability vs performance (availability of hugetlb
> pages), but IMO should be decided by userspace.
>
>> which will be more severe? Will it be better to add a way to compensate the
>> capacity?
> Corner cases: What if finding physically contiguous memory takes too
> long? What if we can't find any physically contiguous memory to
> compensate? (then hugetlb pool will still need to be reduced).
>
> If we treat "compensate" as an improvement to the overall soft offline
> process, it is something we can do in future and it is something
> orthogonal to this control API, right? I think if userspace explicitly
> tells kernel to soft offline, then they are also well-prepared for the
> corner cases above.
>
>>> In addition, discarding the entire 1G memory page only because of
>>> corrected memory errors sounds very costly and kernel better not
>>> doing under the hood. But today there are at least 2 such cases:
>>> 1. GHES driver sees both GHES_SEV_CORRECTED and
>>>     CPER_SEC_ERROR_THRESHOLD_EXCEEDED after parsing CPER.
>>> 2. RAS Correctable Errors Collector counts correctable errors per
>>>     PFN and when the counter for a PFN reaches threshold
>>> In both cases, userspace has no control of the soft offline performed
>>> by kernel's memory failure recovery.
>> Userspace can figure out the hugetlb folio pfn range by using `page-types -b huge
>> -rlN` and then decide whether to soft offline the page according to it. But for
>> GHES driver, I think it has to be done in the kernel. So add a control in /sys/
>> seems like a good idea.
> Thanks.
>
>>> This patch series give userspace the control of soft-offlining
>>> HugeTLB pages: kernel only soft offlines hugepage if userspace has
>>> opt-ed in for that specific hugepage size, and exposed to userspace
>>> by a new sysfs entry called softoffline_corrected_errors under
>>> /sys/kernel/mm/hugepages/hugepages-${size}kB directory:
>>> * When softoffline_corrected_errors=0, skip soft offlining for all
>>>    hugepages of size ${size}kB.
>>> * When softoffline_corrected_errors=1, soft offline as before this
>> Will it be better to be called as "soft_offline_corrected_errors" or simplify "soft_offline_enabled"?
> "soft_offline_enabled" is less optimal as it can't be extended to
> support something like "soft offline this PFN if something repeatedly
> requested soft offline this exact PFN x times". (although I don't
> think we need it).

The "x time" thing is a threshold thing, and if your typical application 
needs to have a say about performance(and maintaining physically 
contiguous memory) over RAS, shouldn't that be baked into the driver 
rather than hugetlbfs ?

Also, I am not comfortable with this being hugetlbfs specific. What is 
the objection to creating a "soft_offline_enabled" switch that is 
applicable to any user page size?

thanks,

-jane

>
> softoffline_corrected_errors is one char less, but if you insist,
> soft_offline_corrected_errors also works for me.
>
>> Thanks.
>> .
>>

