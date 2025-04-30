Return-Path: <linux-kselftest+bounces-32032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AE3AA4F59
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 17:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25A7B3A9DC8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264FF2620FC;
	Wed, 30 Apr 2025 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JVWSgwzB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G1+CwNZa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414CF2609FA;
	Wed, 30 Apr 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025145; cv=fail; b=GH+hus3zM2F6VjOxpMwb5WAtcFfYg2GzFKhDPlLDVk0T8sWTNUKuk70PnvsPg8945cgKscM6rdLWujuI+wzx0yfsx4z9Q8hbOTXat82OKbo3aR+PuvDaJDvMMTXprPreQk/AHSrQokTivbKkcyfpviUILvVj/qvRZ8j+gK89pwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025145; c=relaxed/simple;
	bh=1Gk+wAI+WaRVP6TKIufZYRyR3A+P53eCA3ayumbb+7I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j4mDXbnJOTdMD36DMpwAD8ug58MAO4YabYdplLKbI/g2BSNyXy4qcjjvdrSx6VHicsoyQTldPzANx25+hQTyoZ4B47EUElrxlRSEBg3dXzDkutnfHKlJB+3bgbA8Y+FA4oIpeuCUGfi8CKmtziCtyX8a2ziyNHSyh5H0fPjmJi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JVWSgwzB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G1+CwNZa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UDae1i004588;
	Wed, 30 Apr 2025 14:58:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=58IRZ/Jwzngceo1xjlA5AEhf2d1D4BiNgN/qhOjfpWs=; b=
	JVWSgwzBCeW9WIoZPbQg6yFrF1Ue2ojHg1vcaaILLfaVgY2YqB6oeWYtXVuxk+xO
	9KftJJR7+eDbXzRB6q8vVAO2KC050mZ5fLoTGoSl/s+1tT0Wbk/DMC2PmcYOMP/e
	q86QnxcigQpLHqs1YsTAKTuEpjp7kIAvifQHbD9SFjGwmdmV1b4eagzulzAyHjTU
	FZt/SW3cJidvHhamvsem4k/46NeOyhBGsU79Vt8qTT+9o4WB6F6cMFk7lZda5qOq
	Ji1T/8ElQyMAx+f6ELOEBr6hqQPYCjrSyIL6sTSBqZGHWt+R9he4H3kdiOEdc1ak
	cAK3dG7gbr7rYyQmbrv2qA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uksdm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:58:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UEVSJE033369;
	Wed, 30 Apr 2025 14:58:33 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbe6e5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 14:58:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=og4KQWOaBZcOmkaj6aM1f2mynOnNfNX31Rap+zMmGFrKQ+eh2SEiI/jNZPHrC5O96qqyOQKdii/a0sRH8vFTjbcVJQWtUenh9rNnm6tlLqGX4yfNPlEyx5RJh02WaohvU/cgu4rcZ+wsLa2/CWhTwnp6nunhU3OlbbiAUxhSDRpJ7v5DE5g2aqXeIOLt3FUfnkvXPITEjHcq1fcGSJ6h1KisgtS+y+wAJQqP31KZSHwTWOG+5HEwNpSGkXypbOj4b2kagaKfp6CMybt6mQZa5IBiJ4LqOVi4Xhj5C1aKfKLf0puZSqKE+gENRdKn9AHchHXYxlqwxLW4mZUAnpXuKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=58IRZ/Jwzngceo1xjlA5AEhf2d1D4BiNgN/qhOjfpWs=;
 b=LfvEuUX376ooGuQTfH03o6wztnFnJFIg5R3+9AEtDZCBMQiQ0JphBfhD2XZdN1pyKCAgZKeILh7/t4llF3e3GV+PgBXi33aA+wOjjRaZexmlfvruZG4PvckUgtYnM12Y3aZvYk4CqC1tMncF/vi48GVhxkBwtwk6GxoQtMxYfIG8jmulGqEM34EQWTZU8ZqQRmtZLiCwXitJkaJIJbyvs0g5pGdFT9wliuq5xs6aEglSWoofck7Q1MsLJxvNkxLY5IhvGVI/o02AyjZBRy9IBLJOZhAR6Ca7efsSZFX0LTW4yNFJ3kBNnV2jNqyZl9/lkXXkJf+RX8WZQMkb66qk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=58IRZ/Jwzngceo1xjlA5AEhf2d1D4BiNgN/qhOjfpWs=;
 b=G1+CwNZaMWNYRXUoe44Nv0WxpUWF+c8iVC445jY1i/0ZhOlC4kha24Qh9087TMq+UswzSI+erqS/PYXq9FmgMyPuaNRl9Ae+KfYkVQZKDHDNzFKWXvJwABXWSYC6oDVM3AFkHAh30HWOPgM20qXA+vwVW5M117B0Lc0HwrrQKZ0=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SJ2PR10MB7112.namprd10.prod.outlook.com (2603:10b6:a03:4c6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 14:58:29 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 14:58:29 +0000
Message-ID: <9be4ac89-6177-4222-8721-0b882041e905@oracle.com>
Date: Wed, 30 Apr 2025 20:28:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/22] iommufd/viommu: Allow driver-specific user data
 for a vIOMMU object
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
        corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
        thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
        shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
        peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
        praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
        mochs@nvidia.com, vasant.hegde@amd.com
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <7031ae5ab6f625e73dbd51b074c2ff8a9923c731.1745646960.git.nicolinc@nvidia.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <7031ae5ab6f625e73dbd51b074c2ff8a9923c731.1745646960.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0225.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::21) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SJ2PR10MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f7d7c0f-6632-4c40-e281-08dd87f777b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d3hMdjhxVjFjNmgxV3VrdktJZWN6WHphbGhjaElYVXFqZVczSjl5Y2YrWGNu?=
 =?utf-8?B?bHRRY09IRGVmTGREV3RIeWJjcm9OdjRmRnRFeGxKUkRWL1duOFdlTTB2Qm1a?=
 =?utf-8?B?am15OHZ2K3hGZVQ4dWEvTm5xbHcxZnA2MW51R0pyY2lZblhHamZBanNVY0FW?=
 =?utf-8?B?Y0Y3Z3RtYUhWOGtWNnMvckRXQkRScGJkeGFLcWhOYm9iNU82M1plZWVoZ0Ju?=
 =?utf-8?B?OGJWbTNZcUwvUk9tN0h3c3BQc05PSjI3bnAwNXdzVytsaXoxYVRPNTBEQ2Nj?=
 =?utf-8?B?ZE52Z0t0L3JsRlZhL3YxZERTWGlnZEVGekU3ZytQOWhUb2dYOGJUcEtKRU1u?=
 =?utf-8?B?VjBJT0QyckluWHFaVkk1S3BJbFlEckwvdjJJem1ra00xb3VDendCU2x0cXN5?=
 =?utf-8?B?MmpTQ08yczhtaDUrenpCV2RJeDR5YytYNDMvTWFHaEltMzZGZXVGaUZYUkhx?=
 =?utf-8?B?TDlQUlJkRmxZTWRuV3l5bmRGMCtSTHBZbVNTVGdrbFNRd1BRMEdjVjZiamJl?=
 =?utf-8?B?WHl4V0hvR2xVV05JVklGcHVqcm9WYmFrZnNSWExJNi9obnozYTIwaHkzODZv?=
 =?utf-8?B?V2VVQnljeGpMUURvR0pPUlJ2ZWdKSXlmVDNscENwRUd5ZDJjQ0p2eFJVVURJ?=
 =?utf-8?B?eEVoN0FyakczT2xhT2hiSmQvWDAzL3lVZm1IQm85Q2lWL0ZudFpjcmE2aGpZ?=
 =?utf-8?B?UkRhN2xqc0U1NE16Kzd2WnFYVTJKNVRwdkF5MjZwcHEwS3p3Ly9lWHEzN0pa?=
 =?utf-8?B?WnBwekF3K2pLcFQvZ3lvZWpXUUQrd29aclorcWsxK0ZPL3h3cHZaU3BiSS9S?=
 =?utf-8?B?d0ZZaTdRY1Y5YlpSZkVCVUlGQkVzMXMrL1VQdVhIUEZtSUt0bitQTW8wS1V6?=
 =?utf-8?B?d0JhVHM3eDlKWm5uRnZwYkRheUFKbVhQbmpXM21HU3B4UXBld1VXckpRWWpH?=
 =?utf-8?B?b0YzcGdSZmh6eGxhMzlNMlBOQlRobTZ6cUowZk1IeE1GNHJjNTNMcXYzTi8r?=
 =?utf-8?B?SDdGc2pjOTBJU09xM05rT3dMMVliYVcrS1JmSGNDTFVQSENWZ1NmL0ZvVDN2?=
 =?utf-8?B?dnBlKyt1cCtLMmdZOW5ObVJLRVFOWld3S1g1cU9hWVlkSlE0N1FTRTVvazg1?=
 =?utf-8?B?alE1QzRBNHdxTy84NkhybmxkaE1nNUk2OVdHZGQ5Z2FVMGdJYkh4dk1qaVND?=
 =?utf-8?B?d2JacTFEZ0QwZC9WekV0ZDNNZ0xWQUwxL1pyaVR0Y01sZDlnV0tPOTZPdk5Z?=
 =?utf-8?B?djM0VTlRZjFWdloyZlhwTHRwcHlmYzZ4eE1BNVUwRW83SE43RWdRQXo4aEhB?=
 =?utf-8?B?RG1YME1LdkNiZmFvZ3RUZnp3ZjRTcVhsV2tId1N1emFTSkc3MWhjYXR6bTBt?=
 =?utf-8?B?TUMrQnZSc3h1NHU4TDQ4R2h1S2lacEhSNTBQZ0NkTWtTcTlpSkRobTJSMFZ4?=
 =?utf-8?B?UElHUVhmcnBBUVVONkR4VEwvOWcxWlJBMnN4ZXgzais3RjE5UG9iVzF4Vm1i?=
 =?utf-8?B?dFZBVnN1cnFPcHVpVjdKOTMwNWRFRGJOMnBKZ1VVYXI2dWs2a0dtMHJvRm5T?=
 =?utf-8?B?TUc1NUFsQUZmbXNZREh3ay9kS3NJOHlvMmJsaWFFblRnU01halVMNk8zSDRu?=
 =?utf-8?B?S2YxMEJORTRvTHJVNllFMjh5UzZGTGNQQUJVSUJTeFVzdVZFeURTMDNValFq?=
 =?utf-8?B?WUFwckZidW5SWDFBcmw4OEVNSSt0SVNzSUxsWXlDMzZReXJkM0YwQXA1RzE1?=
 =?utf-8?B?T2w1ZEtIVk9CSStmRzdoN1N4dGhkbjVwZUlLMXNSbFpjQWhuRlVxeWNFMlFZ?=
 =?utf-8?B?WUh4RGNJbW9RM1Q3dG01ZnNucDhWUW1JYjU2Mks2REo5LzhzU0w4R3dIRVpn?=
 =?utf-8?B?T1lhVFRLUXJiblBjQnlzTTZvMmh2WDFOQkpXdWkyMTIzZ3ZKVVJRL0NXNjJ3?=
 =?utf-8?Q?mrDVlc2fp0E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajc4aStZcmRhdlk0OHJtRGhMUlpNZWRkZTNOL05FRGhPNFN5M3lpRm9ueTVr?=
 =?utf-8?B?blo3b1lteXd3b1dPQ0hiak5Fc3lmU2hIVnpRWGtldTRDYndOVDdTRVMxaGpC?=
 =?utf-8?B?Ly95Y0lSYkMydGkxdFFNU0luRi9zenF6WkxzVEd3RjJybWxLZURRREVzWHU5?=
 =?utf-8?B?VklzUzdCdFF4c0JGR3drczByYXRPZytmeTBQK1hSRlBLdUZueTYxVmREQy9O?=
 =?utf-8?B?NjVwb0F2V0o3Z04yYnlmcmtLSHdZbFdtTjl4c1N6U2dTQUdNRTh0aSt4SjRZ?=
 =?utf-8?B?QTFHaUQ3dDgrRTVyUzh4WkJqdGhOTDc4UldnQmV6bmFXMitWV1RPbHcyRnFJ?=
 =?utf-8?B?OW5vNW5va0FzRmQ3VVJrYm5nTWdvdTVaZjMrblJkSXEzamtXaTV4SG16Zk5F?=
 =?utf-8?B?bTFUV1B0OVRCbzR4K3Rka2lkVmJTZE4xQVN0aFRGeUtyS1JaMUxrQWhSV1c0?=
 =?utf-8?B?VUd5aGlQbEh6UFlhUkE5djlWZmdwSmZHc3ZYMlB2bnlmQUFEc3EzSGh0RWpT?=
 =?utf-8?B?ZHdCS0xGUk1KTm9HMExENWtCZlhTRlMxL3doZFIrUnQyUjcyMUo0ZVZldHl5?=
 =?utf-8?B?Qzd1TlN1KzRIcGVPY2JZMi9rVko2K0pENGxtVzFXcE0wM3NDVkJlNk1zdWRh?=
 =?utf-8?B?bE9IOXZOeTdsWWdVRDFOVi9wT2EyRklSbWltYlM2U2l5Mi9Ib1NSVmlCY054?=
 =?utf-8?B?NzJNU1pGdWYxeGZmZEFzREFRQjA1RkYra0YxNkgrRS82VURBUDA5NEtWazRJ?=
 =?utf-8?B?WFZPc0NKQ0o3NDB1TWV1RDloWkhINXdYZUt0eU5mTTdIV0J4UTlqcU5OQTJD?=
 =?utf-8?B?dVpHdjNJQVdFRGx6amVjWnZBMGRROThVMVRlR01nZ2FLOEV1NGNmWk5yT0x0?=
 =?utf-8?B?ZVFpUmhLTjdlcnRrdVgrdzNpVUk4TGRVQU9sVk92UUc4bldwclNITjVpa0Vo?=
 =?utf-8?B?RU55S2RodmVkU0Fzc1R1OW4vNjZXTCs1TmdTcG5vM0M4LzdZM084ZGwvbFEx?=
 =?utf-8?B?YjhjZUdjb2JpYzUzeG5PNTBwUXpoNVV0cVdUSHljVWltNU9QOHRFRWlBaXkx?=
 =?utf-8?B?RFVjeEJzZjhOVHhmeG9SM2Vvc2ZhVUxKeW5HMWsrS2p1alQ0b25XbjlaMWo5?=
 =?utf-8?B?ekJmQllFRWVwMW5MUkwxa2VaMDRyaEZWSWlNazU0VFlsbmRFeTl5bmlabC90?=
 =?utf-8?B?VWdxMUpkaEw3K0JFMmsxTWgzdkQ1SEROTlUwR1VMUGQ2S2w0cmpHL3ppdFFR?=
 =?utf-8?B?d0hTUEF5MTVkYjNOQURTYm9qSlE3dkhCWlhhWUh4UWZlZzljWjI3QVpHMlpY?=
 =?utf-8?B?bVNab2F3c1diK04xZEk5YlBDeTF0MjI1dDBGRHFwZVJRLzBvWjRGYmpXTnFT?=
 =?utf-8?B?QS81ekp4Zy9VWUtER1BJRUQyM1c3L1REd1M1VjVoL21yZFN1RDJqNmhsMUIy?=
 =?utf-8?B?SGRqYUh3UmxwbytGdmdZYlR0S0doM2EyZDZsbGtORXJxNEI1RlBCMjh0TU5X?=
 =?utf-8?B?QURkMEJLYmk3bkc3TnBtdElFQnJQc0NmR3BHMjBoNEZDYzVMcmt1azIxUlVT?=
 =?utf-8?B?dUdvc1p1RGRva0tXd1d5R0FNZ0NCRXFOdW5ldVlBdTVJd1kvWVMzMEhlNEY0?=
 =?utf-8?B?S3QwOTdPS3JGSUp2eTVWcllxY3JtdGFNSmZPenJSY0EyaXVsQ1N6cXNpRVhJ?=
 =?utf-8?B?am84Yi9lTVFyUFNqZVBVbldMcGVBaHdXOTRlVS9JSk50cjdJdndmNDJITHkv?=
 =?utf-8?B?UkVoZWVpMi9aV0R5a09TcER4bjRUSGtzN0FlUEFpZ2hkZ2xOYzh5ZldIMGFM?=
 =?utf-8?B?d1JpRTZYQ0ZrdURhZjV3ME9jQ3lHdjJhU0I5NGxKYjBCM1VWUEJXaGV6M1hl?=
 =?utf-8?B?dGNGZHcxTXgzc2ZZcFNtdDVsaVJwMCtQNitRZXhFTmgzRTdlS0xQNmNuRGZ6?=
 =?utf-8?B?M3FZemF0TmxuOFozYVE4dHhTVnQrNG93T1B3SHc3d0FNeWZtVGJBTlNnZEky?=
 =?utf-8?B?NlpsQ3RETTNBZExhSUZTVXVsek5CengwV0xhMjFMZVE1Wjk3RFNoUHVncVYz?=
 =?utf-8?B?K1pWbVp5RlhMMGlNcnczMTJNMEJwUDl2M3JUa25zOVNUbkRjSTNxMC83Rys5?=
 =?utf-8?B?cG5qWEVnSyszVDgwb1g5NTVUVEFVdEVsbjR0TXNHbnhSSWpxR1RVZDl1U0ll?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nre3dr5+5D7h85cUQA/+krPZI+xByMHiYG5Ed2pyZw0cRxVDCEi6nWGqua86zgYbVF/GPOMDN7dnl4e5SelVYldB0ZrBsVKN142asXQ365zq5Wgsan6+8fND8z8JQLz8PsazmFV5FfVeNuG57ln7Pa0MGT7L1jZSy/mh+yPi6vxZAiaKgbZMs0+FnnROuJIs9p2o9FwWBEEprxPlm/CFL9SwPJ1FFez90nKwDiuucmiZNrDHI7rMpj6/ZEcXZlgQxAZxtyIZ5WoepQQX3wCOfwLynr+mulgY5L2xn2l9WLlCUJ+IgWYR51QwDRc8909srM++eqhvtMm+c10xqJq8TU5n/9rbpfRZelvZywe7VI3nQEw/enfA6rFxIGnq6XvaYd26X4ZFmdMfPF15KmUsNe8gXIVjrHBShoOib0+kU/TT2wFfToVRPepRwFttkkfHp+pVoObOzDosW2MD38DT0Ktnevu7nFhDr2L6nZAnDZx50a2lATLR+0v3CRhARLYNmrLJt+0mOqMsubt3zxGv9HqQuBQARZgoNkUuKC/f829sTLCQ1tIgwPu+1yXGuaZO6FPTp5ygyubeNO1sH9NFJ1iwwiCZh50eX8/6+RQw2UY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7d7c0f-6632-4c40-e281-08dd87f777b7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 14:58:29.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WeuAX150GyqqjhsF5Qrd336+OUpI4AbYhTZOYBP2rL3g741xP4y2J0Az1B+q12Pntm327dseUJrdgvrUxZScSRQHtQLMagUZv0jjTBTbaCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7112
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300106
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEwNiBTYWx0ZWRfXyHrOh+FAO+5F hIRomC1iZzVvSJ/TOouH8JWM8XKOs7M6f57XPACPRiWrK/mdhMf7LAHe3s6KeqpAY8uS3/aygAQ mXj+KMoiwr34QRVmCS+kf5+279eeqVYXhQ870DfhHpIxZ9EgHumNZ+L2qqUUe7XvWEmt+pWw/1/
 dKDs+pVK9QTMEiUMclSww7druTVJcv0hqsbQFlNCmRj+jC+YxA7JIw+hWpW/rc6tF26iMfKk6hL Y3WwB2abEhkpm6xCqEcvLwJ4JWEFyGBv+927W0xv+QAQan76nPtTQbhJnbH/3Ft116lJdYA/3d8 QZ/upz0lvqo1rYMs94choEu+6s0CoAUiqPQgjbmmUvOapLMSPvCwjE3DPq/vTe0TGRfuo8eULxv
 wrNp+YjGxZ/6zx+xs95NP0irKecpi5zkFJssaIseN4x4qLR0Edvt4p2YPqOooGktQDZQboHb
X-Proofpoint-GUID: Mrcv43q4WO_7ItRs_mVusHAouqwUjRi4
X-Authority-Analysis: v=2.4 cv=A5VsP7WG c=1 sm=1 tr=0 ts=68123a9a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=ZInSrLUAKAF9lBDWOMYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mrcv43q4WO_7ItRs_mVusHAouqwUjRi4



On 26-04-2025 11:27, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
> user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
> it in via the viommu_alloc iommu op.
> 
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>

LGTM.

Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>


Thanks,
Alok

