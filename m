Return-Path: <linux-kselftest+bounces-31598-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8FAA9B617
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B1D4649F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 18:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81A928F501;
	Thu, 24 Apr 2025 18:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QAHMX0Pa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TB5fvRB5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC88E28EA4C;
	Thu, 24 Apr 2025 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518749; cv=fail; b=TZd+46Lui4lZEr0td7SXBrwZ6GfHFA9JTYDSywWr+41s+bmmG+EZrwm6Oyva5jxM6AWY+QWOhgVtpt8PrZvJON5BZouK5IELqIaioBHFLSQrqZmZbVNfzypdlPyO5HbXMU/d39IwcpmlgEQMNuNr/oUufC9aK6XyAUidqJ0g9/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518749; c=relaxed/simple;
	bh=Azrp6/1uQ/dR6e4spJP6bH8SzeS7Lcx8nJfWb47HcgM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j8m9qc4rcAauswjHbZnFF8PmS5DB0ahtyMKyIPggV/Fuaty1u96nXoVtcvz/wiBKM4Ey0mRZCHvufY+yLgwKuVsaK6iQRoAr+V4Xd1sBkblcFMgDAB2p+T7RM33p8Vu3Vi0FqVvWLv1zjCHjEdTeXPJ46zuJSe/gcgLAOzJKKmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QAHMX0Pa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TB5fvRB5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OFq3dc010539;
	Thu, 24 Apr 2025 18:18:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=j2OdulWl4Er2PMCZ5oIIwuNQgAoIDpsOP7E3ch9ZzwQ=; b=
	QAHMX0PaMa79lWYx0mTmT/Q9yIog36797RaGP7UqP52ZPYDWVhRGmCIoWbXPw27l
	BKoWPl/wAmCW3uOmZSyFg9G7Z90uQmDGzMEnOVo+dbtrRDT/LRva9GCOJq1IyKVl
	+U3P560ZXxh/PjSBn+iSnOMKrYbhTdxKFbfQz+dOyySPojuloLxcs7MX3LTw286f
	dIYM9etXSGczY6OQ2Patq7vf0k7GZ5vZZkjfX6r55BTBbySm7608I2dJ15e4gu6c
	OLJH5X3LQBUjRmz9Md9H4COBkL4CRjQAfDeFomoMDaAbPoNt7uX8aH0EU5MH8h59
	9EwNC2yG6u7NmORMfDDbYw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467rajrmd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:18:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OI9lgK013894;
	Thu, 24 Apr 2025 18:18:56 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013075.outbound.protection.outlook.com [40.93.6.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxqnh9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 18:18:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHBaUZvzqu4eXqjv0xjUO1x6oUqilqZAOTO195+0otrD+hg1/oRQV6DhgNWWq/2YyuQwDnejgKkWGzgS9+/eUpMOmwJi0eol1SEt60RlegsdwnfcriNDWxz73oaR6Bu2q7LzWTnx9Xn9BAUELDgCp/JOWHejKHVIuib49kVPrko0h0A4T72TVlX1swPfVX9hbirqIfoZKK48Bp7O8I25mjw/NTrtaPqNOcVQX8J05CAqRhB/ASB5BD4YQJnSrPFYjNtm9qQM2CFPEvlUika9DbKukkODwrVj/8pWVrZ8QsTqF8RDu/UriTfEvL1xWBRn1pp/NukgoEBvgsoKZjVk1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j2OdulWl4Er2PMCZ5oIIwuNQgAoIDpsOP7E3ch9ZzwQ=;
 b=W2dcvqFz0YX2skb/4oTwGpvxZaFJn+3o9X0dji3rrauw1sn3i1+t+UU6QyNrRnaqH9dWAs7YUfm6epA8D91oSZQFEpTsNyiX9iTFnLsrjyZBSmujynHE9Pabwq9GHtB4WmQ2KeMM5s07ZBap0nvMOlsbkxuZpDEdeuMxtruvsvGk7yiXRL6CYweyRRQfCfeEugOU73OMb7qtQO8OGvwtEA1cO2XBV+x/7VlPWkLOxzZNS4/d2OkT77gw87RnhAD7z0lFysvPIiJslNPdLCQNR4+z+gG2j0w8K5+TqygokYg7aTHo1XBX8YNtOcWcg6JB9ShCZn0BV9LbsPO2lqbrcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2OdulWl4Er2PMCZ5oIIwuNQgAoIDpsOP7E3ch9ZzwQ=;
 b=TB5fvRB59XiTF4ggjeVhAU6CPg6giJm8hOcrX/1FlqkqTjxklK0N0FqEbfaro9eAncM0gr6oIppc/5n+G1DJu7+J3bArjG9oSxfTVTIx37vIQPcOYw9PgC8Y6vx/2sAYCnv9Om29CFuKResCbZsUmX90TP62NQdep1n2TMhN9kA=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by DS0PR10MB7399.namprd10.prod.outlook.com (2603:10b6:8:11c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 18:18:54 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 18:18:54 +0000
Message-ID: <2f8ce63d-f201-4ff9-a983-c300d10cecf5@oracle.com>
Date: Thu, 24 Apr 2025 23:48:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/14] riscv: misaligned: add a function to check
 misalign trap delegability
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
 <palmer@dabbelt.com>, Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>, Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Cc: Samuel Holland <samuel.holland@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Deepak Gupta <debug@rivosinc.com>
References: <20250424173204.1948385-1-cleger@rivosinc.com>
 <20250424173204.1948385-11-cleger@rivosinc.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250424173204.1948385-11-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|DS0PR10MB7399:EE_
X-MS-Office365-Filtering-Correlation-Id: f8f7debb-1f5e-49e0-b1de-08dd835c7870
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFdHdTNmUnRkTlZBY3Zxb0IwYWlhOWxmNlZ1Wi9tdzRoWHhsUm05c0M1Y01F?=
 =?utf-8?B?eEdlR0E4TUFUaVg2bDdhQjk2L244clJaYnVzclB0UC9Yb0ZkY0szUW1BbU96?=
 =?utf-8?B?WGpkMUxSdHlIU2t1NVlRU3JveGZWdDM3L0lFbWV6ZEhsNEV1RGlpbllObmtw?=
 =?utf-8?B?T2FjTjNqSnVKaGlKeDhOQkVqWDlhcmpoMnM4OVpuMS9VZk9HQWpRUUp6VEhX?=
 =?utf-8?B?NlcrcTJnbWE4V3pqa1lScnlDM2Q5L1JvVFkvdHB2OWhTOVNYR3NuU0k2NDhj?=
 =?utf-8?B?QzViVEN1akRHN1hWME9BT0VwT3VQb3QzQUZGR3g0SHh0bXVqOFlEKzdRV1di?=
 =?utf-8?B?b3l4SVI1dGtsblY5b3JWZy9NMWxIUllzM0R5Ymp4bDlBQ3cvZS9tK1paTUpW?=
 =?utf-8?B?amo3Y3NoeTk0M255NTY3WHVza3dOaHdESnh1eVlsWUpBWml1d1AwOFJXWVg1?=
 =?utf-8?B?SkpLckRZQ1BRbUordVM5TTVMbGtzUGVBT2RaT2FIbitwdnNNQUJBcEZjYndn?=
 =?utf-8?B?b1lWd3I1eXZ0Z0lya3lQQVg5cStES252dlRIbjdUeTF3a2NPMEpBWjdsOXUx?=
 =?utf-8?B?ZThwRHhKSzN5Z2pFcHhQYjZ1TzdMU25aVzA0L0pZdTVWZkQ0aWc1TjdWMUxp?=
 =?utf-8?B?eU1rTmJyNGVyTk1OY1J4SEliR3MrNy9aTW5XMkNVa3VPUWZ6T3d0MzJwVlNM?=
 =?utf-8?B?c3g4NHZBRzArakZzc2FyNFNlZTd0LzBiVzZVb2hmUHVxZ1d6ODM5UXphUVpq?=
 =?utf-8?B?Mk9hN1RuTkk0aFdZYng2TWFlQXZiemduYXhqblgzRko3SkdHYTRyamFDSXF1?=
 =?utf-8?B?NHNWUnVaU2JEWjRJNldJbVBPRjdNZTg2YjdubndZVVd2dXVHOTVvcTlETlor?=
 =?utf-8?B?TWJHeVVEeTExenVTZzJJVHpGaTBWbVJvek0vUEZJQjVTSXlPYWpsNFBTZjJQ?=
 =?utf-8?B?U0kyMzBtbVBYVHgvSW41cE1YeUdlLzF1MGJmTEtDWTNwR1lLVk5pd0VManZN?=
 =?utf-8?B?WEtXZ2JXRDRCbnkydE1PUDVIZTZhMFAzMzdUZFVzYmtHd3VGdEFPdkl1UTNE?=
 =?utf-8?B?b1dFRzB0M3N0M1UzTXplRW5wOWZSUUxKOHYvOFRhSGQxWGx3Q2tLZVlMeDgw?=
 =?utf-8?B?Y3NMTnlGTHg1UjJhQVp6NCtTa1FyMHI2eGh3d1J6aFhnK1FZdUVPRStNLzI3?=
 =?utf-8?B?VEpTVURkTG1UVG1pZDh1bE8vVDFCbW1HV2o2ZXNmaWFpM2dhOHNFVGE4L1Vs?=
 =?utf-8?B?ZThGNnowdzlkczc4VnovYW5VZzQvRk9saHcwOE1mV2V6d3UvK1ZDYTRkOE5z?=
 =?utf-8?B?SGp0bGtYSCttaWtwc0JRQ01mVWNzNVFiQlBnSFpRVTNKd2J0TGpvSDZUL0Nu?=
 =?utf-8?B?cG9ueGEwYlBSYndETmdweDBONTNYT1hsWHdGSC96ZzV0RWRMN29pZlpyUStq?=
 =?utf-8?B?YWNTaWpha2lFaW9HcEpLYTlpY0tIcFhIc1c0QUF2cWhvVFp5RGNWRmlDNkJH?=
 =?utf-8?B?bGxHQTAweC91S1U2Q1EreUxVL3RHSHUxRkYxZGhDWCttVlljZUZNS1YzRDFo?=
 =?utf-8?B?aXlHVS9wN2NkL2kveU94QlpaanI4d0dCOWhDdkUzYjgrOWZac2YyZFM3Y0dO?=
 =?utf-8?B?S3VVUnhEOUxXd0FLMWVhOUF2am5Ka0F5ODZLOG1acjZHUTRsaWJRLzZZY1Ri?=
 =?utf-8?B?VjMwdENiNG0yOThDYjNvekVpVmpGY3V1NVVFcVpBTXdkaXVCNVd1clE4UCtj?=
 =?utf-8?B?WkVSS2pudXVlYllGc3lDVXJuWkdmanBhOHUwelhvWk9HcEZUNHphcGNUYXNV?=
 =?utf-8?B?ZWZaMkMxbEJTQ0RqeGZabjcxVkg5OW1vZTFra2VHZnZzTXBFUy9RN1dNMGhQ?=
 =?utf-8?B?SXJuM04vMmhXVUNMZ3FPUTdhLzlqRzh6aHNTb1R0eXRHYy9RUlVlVDl3TE1E?=
 =?utf-8?B?bkdvSW0waUhObE9yYlNHSXI3dE5peHVzb3NWVVhmV2dhR0Y2MkRaTGZRYVE3?=
 =?utf-8?B?bEUrRVlBNEJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aDdtWGxnZkQ3aWVXNkpnNGhoSmxWTFFCUWJoRGRmdW90R2oraHhCMHF2c2FI?=
 =?utf-8?B?SGVoVmpCbkRXbWZkcERvVmx2QlUzcXVNanZYc0F1WnIrMUdJZWd6TnhqdTM0?=
 =?utf-8?B?ZGhIWkc4K0ZpZ015OTFOUUYrdTIvbFVydFB5MitqZEJLR3JxNi9jVUFEcGJ4?=
 =?utf-8?B?eGcyc0o0N21NZ0Mzd1g4QjdFTE00YWV5QWpwdVZvR1FzLy9SMVlGK2ZMR2lY?=
 =?utf-8?B?MXkxS1BpVnZCMS9JVG9VY2paV3Q1WnNYdmN3UXYzcHltZnV0WHNVMWYzN2F3?=
 =?utf-8?B?dEkxdFFwc2VsZy8xOFk1dmRob1lHWXd3Nnk5aE0yM0RKbm1Vb0Q2YUJKVHhE?=
 =?utf-8?B?ZmFzOG5Pc2V1VkJLQ2V0dEZ6RWdSOWpEcUg1ZGdyeWhwOUlZckdXYTV5b3hD?=
 =?utf-8?B?YnZvajJrYUIvQzJiQTZCTktkSWs0VUlUVHl2VTA3eXNUNWJsOXdPdEpxNk5K?=
 =?utf-8?B?ZFBRNjFMSnBQU1MxRW9PQ3NnTVVXTmt1aFpSZzRBV1RCcGplLzNuQUxDa29E?=
 =?utf-8?B?aHRjSDFzaG5qNzYxdjM4V2ZmS1BnUzZaMHlsanZVTGh2MWxyVlNCKzQ5SmtL?=
 =?utf-8?B?S2x2dkpaSElheGc3cXp6UFpVSGpDY0krM1hRMTlXTFVXUzhIVXdmQWZjUVdp?=
 =?utf-8?B?Qm5FeFJJNlh5dmtWOEdCTDJrdUd4RWc1OU91V3JQL0d4WXpTNnl2R29EWk1y?=
 =?utf-8?B?YW1BNDliL1JGdU9BTkZwcmhYd1c2b2ZxQTNkaUxqek1heXVYQ0U5NDMxMWd4?=
 =?utf-8?B?VlFmZ2QrV0pxWTU1UFhGSGpFT0xQYzRieFJnZzFIU2NpbW5nLzNJMmlOVmc4?=
 =?utf-8?B?L0pGQ1Vqb0ZDMDFwWExNeC9CMEZQc3FMamsrV3FrNGdQU09xMUc3eHBSbFg0?=
 =?utf-8?B?NTROVzVROHA1aWVvYk5wcXdOdi9UL2docWFZaHVTUU5NQ3UweWI4bkhPSkcy?=
 =?utf-8?B?Q3EwcE1uZUMxT3JJS2lXL1V2QytXK1ZiN2JLdzVJd0ZFb2hrcG1yUzdzRGdZ?=
 =?utf-8?B?N28rbEdHUUE1RzZHSjh0WTdBN3ZwcHhxMFdrOVc4b1JscDhDYzlHcVB6QzV3?=
 =?utf-8?B?SGlJODlyc2FVME9PQUxPUFg4c0tsZnNqVmN3UFVRQUVERHZab3dpSCtyL1dH?=
 =?utf-8?B?aGhQSm9BbGpBZXpHRlE0bnhzOHdXRGJDMVd4WU12NWFvNllUVmpoQnhrbTFY?=
 =?utf-8?B?VGlWZjJCQnRYOU1PUkZZQXZPUXZRRWhWUm1rbk9lRVZEUmZrR0dxQmR5WGNs?=
 =?utf-8?B?RDdGUCtCUkxaUlVOaCtZTS9YN2F6VXl4bGk4K01EeGo4MCtzMDZiNGd5d1h2?=
 =?utf-8?B?L1BSOXV4dVI0V256SHBTZDFKK0JOMFU3UXVpUmR4ZEN3QjVTd09oNFM3ay95?=
 =?utf-8?B?Q01DNi9NL0lmNU4xZzBJTzh6RC93bHZnOThjRWlEN2pKTm5nQ1Uwb2NKZUx5?=
 =?utf-8?B?bmFiTFBlYTBKcG13Zlp0WjZqMlRVZnpMUUVvSmNBZzV2blFqenZkeloydlRH?=
 =?utf-8?B?bnU1TFJSbk9PL3dxV0E2QWpaZVZTQ1FVb0ZseS96bkgzV3d1RnVYMm9tYzBj?=
 =?utf-8?B?d3VHNGdIOUFXbm4zVldOOXZZUmVLaEJCNFF5QzhtWStEaTMwS2Q0RjFEVGZI?=
 =?utf-8?B?cXBlTFRMbGk5Y0hMRWhOZFMyaEtFUzNhVm9FNC8rMWpDSzBWTnN5SW04eGhE?=
 =?utf-8?B?UDFvUmxrWHhPMDlNaWJTbStEdmc5NGk3SlAxNkFwaVdwY3h5TjAya3AwRnFq?=
 =?utf-8?B?a1RQOG82N29ZTTg5Nzh4UEFYOHdUbjI4WHBTV1BnZ2tHWnV2QkljdUVpS2JF?=
 =?utf-8?B?MlkyTDJrMzVBSUV6QzYxbHRXd3BVeFVKYWhaVTV3dGxnSCtWNDNkM3VNdG5x?=
 =?utf-8?B?SXovSkZNNGVYbUd3OW8wVngxVVk4OUJqendEWGJtMVFHaCtpa2dmc1JCQmNn?=
 =?utf-8?B?aCtNZC94VExaOTJJTnVxUG91dVE0c2RmV0EwNHdNbm1OS0ZNM0JvWitYUTZa?=
 =?utf-8?B?SWdkb3RPK1d5bVRVei9tYzFYYkZNTGFlak1XcFRRL1VpaE1JNS95MjFmSDlo?=
 =?utf-8?B?RzZkbWRIbHVQcHhFd3Vqd0QvUUEwaTBOSTk4MUdFTkozOXNObWxQeHo0dkNT?=
 =?utf-8?B?cFhkTksyT1BSMjdpYzU1UFJ1WkM3TzhibXludDk2M1drbG4xMExvU3c5bFZV?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xLT/VNLKEjEsj/UICKT/qgB+r3EwRBFkfB2nvOOHmhlESfW+yQh6DdspG2AoqDKQ/xdoF7BTH1kX4hWguweG8NEwywg/4HoWgx0TsjkHsxemxMUXtueRg8deUf+L0ATNDXZVCsvuhKMTcYxFI0efuLg8wcuSHfHLc4Xbfr0hvujT9FiRQtIf++oZJU/Nvg/hpUgbXjP8D/pntqHXLfoVveKCKyTmTpuDUtvuuVom9/OpCN1qUi+Pr+wjDqYwWnXp0bUJYcyYKWoyPv/rqXJa9k0G+uAXAWkkpXFwCxlB3sqBlPIMsbcjTEtmEFD+pqYTnI5g4Eu22Jykz7zq0QAGwHVrqB9gOMLFneTbR8LndY7bzIkq2eXrc7IiA9x0yV1h3f20AeJr8ubYiwJHfowAS3uVCEB7HpIUSgN3bMlyXtfwdJc/6Qj52w6zvqqYAPy+9iRUKVIrn+tp3fEynPRY952Ugip6UPOhxcfkQIVVosYWzDMeopH1HJqFlr75uzs4WWPwFNfLcM3uuSL57YsOeGwEipAIwQ7u2RQBbqopR5vf25OnXzyrnUZdpUM2oAR4cwO3OvzkBYfUaKm2MVEDIVjTVhBmcRqwIPSv109/4uc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8f7debb-1f5e-49e0-b1de-08dd835c7870
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 18:18:54.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urhTciehQWdTQKMvi67rapQqg/sL8QvICKtjfSmtDbMhGCbc4rgYpsRFQIaA/+zonDY+kZkxEWj4Y7B0114kZgv/DWy0uBSlt5CWOhZXnMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_08,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504240126
X-Proofpoint-GUID: cGhQMuLh4agEjLVwuQD3rgERAxFb7Gi6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDEyNiBTYWx0ZWRfX1N4+9SuywpJO AfaxCA1qW7zMFwlp5U1lSZs808PQANvGSPB/rEKJWa0ycvPH3hlbWv8eEg73GuIICz/fyipXLcW Nr/bgET8xD4F3FNwWDOqctXCRDjtg3TqbhFB3rrnZzPEHciAc6TBYf/vH0vIqQJi/tZh3gC63iJ
 75c8LDJrSMFj0nDI0tw8IbWvdpOqrb/byiW6BK7WC8qrNWAyR2BRV9KJoKnmAthACNfsM9VLXlQ cuQB7AUorN2ixJyyN5iadi4Hl+9rwJHXLvTFnnDLQXv8iOtw+YpuxnNaPWTAWS3ouxGJlnavCJB 0xwNm0R98HyM966BvRhKMoUhWh17dmlU/EgjsarGDVQSUUKB0PWYwKJ6JYovoRwSUtf1S0fDmbI SWU6KftY
X-Proofpoint-ORIG-GUID: cGhQMuLh4agEjLVwuQD3rgERAxFb7Gi6



On 24-04-2025 23:01, Clément Léger wrote:
> +	/*
> +	 * Either we successfully requested misaligned traps delegation for all
> +	 * CPUS or the SBI does not implemented FWFT extension but delegated the


"CPUS" -> corrected to "CPUs" (case and plural form).
"does not implemented" -> corrected to "does not implement"
"CPUs, or the SBI does not implement the FWFT extension"

> +	 * exception by default.
> +	 */
> +	return misaligned_traps_delegated ||
> +	       all_cpus_unaligned_scalar_access_emulated();
> +}


Thanks,
Alok

