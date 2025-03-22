Return-Path: <linux-kselftest+bounces-29604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 525EEA6C934
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 11:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 418063B10E3
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 10:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28166183CD9;
	Sat, 22 Mar 2025 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="GlBJ4GCg";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="or0Zwvaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96A1F4627;
	Sat, 22 Mar 2025 10:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742639050; cv=fail; b=WRs+2TdyXh40kFyqCXSb1/as1f5WkT7UcVpTQBmnXcsGNd3OUJy9f87gJy8cHRbwGjl3fJMvzhqLmYGv/zp25i6OI2vmsg0iZJAA9m0jCLkfrD+ss0uh1mv/GRHFFNiItRe33Rcyn/+PzbR5rNj057AsbL1zMuFV0e/S2NXWMis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742639050; c=relaxed/simple;
	bh=AxKA9CHcCYCE/52YB5s5t+cA/IFwrd18DCSjr4ox8dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kRCqYGLO2endJRbV55psGpM20Mi2VgFoI7XVw3bPeRPy2KlqFl2EueLKdnX1HpvOhIHeNck3Og2fPrvKckFrTfm7t3/6RR+kD4lbz0ASVg86iruwF+zXiu63BhCzz6VaXW5d78+o4cfSk45gaJ+WFJMzqUP77NUzQ/8omIORmxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=GlBJ4GCg; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=or0Zwvaa; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M9wZKG028825;
	Sat, 22 Mar 2025 05:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=pK9KdlW1QVpNdlpBoFhuAscxpRrPOzMHNH0I4hTTzW8=; b=
	GlBJ4GCg2A1lNNalzPVivY3ERszxAXd2Pw6XzSvUosVvY/00HZwa/rn17915e0Eq
	18PCm2OIrz2vwc9SwGe0uVb+MfiVwG7aNReG7MWUMFgGGv1M8uTPbB1nfmgviffl
	J5q2pLqoTil6lni/EGnsFoDOcq6Y64G4twvPX2UytoXPjY+XqJQ6Pj5JtX2WVbXh
	ClHNuP9GS8X3hDOJfUQROjW2MbXnDuYPDVZhYaoiZuKYzDWPiE26RPDLXlJwK+Vk
	ZLiiD+kIRT4/3Yw/pZyxYa2phZLV+xFwIhuQOKHxRqh2ZNW5C2TIKo4rPAj16ZZf
	Ah1qoJTH5gMm1xYtV3E3Lw==
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2049.outbound.protection.outlook.com [104.47.57.49])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45htm1g1kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 05:23:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVfANWBjVxLyiEhdITVL29DLhXloNDIJqzP7KY0VJA5Au0Gxvjdo/AZlvtqXCsAzmFldqGleAFNClqB+fJ2iG2gB7R+HJSCDuDcDg8uYxRxqzKJ/LWKRW6YaBPgESZSz0lnENIIMQac8NUTSMkF2Z7RnjeTWfysyPxNdOaeR1SRnSz5YuyPPGI5OxF39Rr87wc5IObo1FKkRfaVeExVw9arFy0J51j37k8B6NCOb+bLiZx/rrOeEax5Qw/uUk7fxtPCXRtpAQobiAcsIoNDCf+NI/cudeJ6UmpzHELVfBIhOxm3HoqnUABPOGjh9kVstqenFPSrhnsPI+kOCxq5kXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pK9KdlW1QVpNdlpBoFhuAscxpRrPOzMHNH0I4hTTzW8=;
 b=MLvSyr2JmIdc9XjFnztwla9Ykwk8eX+0/83G3sWFRdhIKuIZRWfHZWEA9QZod9jOhCAEQ5pufVArloGHzBzRM6nUG4u4sWGBnO2IKvmNGewG/xqxBApcWS0p2w70pjuTIIake1CS/tXwj8vkG6JpBCZclldPuWjxts6B8neLEvnuAKDkrKaiBxl688/fgb+FoR+F5AM5PiB3xWvQZNMQVMDgfBu6Mc+gFU66F8Nl7YUmHfnTN85ggQA0k6lzYmkerCkwVV7U80c7ONxvJVF3IGN8mpsBlTAkrLegQl73N8T6MoImuIYx+9ea1VxMB4QII8KCtTI071+GrQEgYD4jqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pK9KdlW1QVpNdlpBoFhuAscxpRrPOzMHNH0I4hTTzW8=;
 b=or0ZwvaaFuQyI5lwvw9reDRxOnIEUprAU7xvAGYJB7B7GgO4ZtI5EtT6VVoTiQBljHNwP1e0Zb2rUfgojFUz+vcnyR8rARBe29ME/PrLPHCUx0gMULTUY1UeDS/krjy3C24L3+rHOlO8gmd5li8fP7LJcOWjm3HFV8FPAwOiuQc=
Received: from SA1P222CA0194.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::19)
 by SN7PR19MB8003.namprd19.prod.outlook.com (2603:10b6:806:2e7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Sat, 22 Mar
 2025 10:23:52 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:3c4:cafe::68) by SA1P222CA0194.outlook.office365.com
 (2603:10b6:806:3c4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.37 via Frontend Transport; Sat,
 22 Mar 2025 10:23:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 22 Mar 2025 10:23:51 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id F1A87406540;
	Sat, 22 Mar 2025 10:23:49 +0000 (UTC)
Received: from [198.90.194.24] (EDIN4L06LR3.ad.cirrus.com [198.90.194.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id D7C76822562;
	Sat, 22 Mar 2025 10:23:47 +0000 (UTC)
Message-ID: <7978f070-25b7-44c0-a110-c759551a2567@opensource.cirrus.com>
Date: Sat, 22 Mar 2025 10:23:46 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
To: Nico Pache <npache@redhat.com>, Mark Brown <broonie@kernel.org>
Cc: patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        simont@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        johannes.berg@intel.com, sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
 <618b8578-1897-45e4-83eb-b725102ab27d@sirena.org.uk>
 <CAA1CXcD4dOUWOXp0ODSEo4+g9_QQkJe1tmX3bVdcs3N_PPdSHQ@mail.gmail.com>
 <a0fdd818-a4be-446e-b18e-0c655bc94c9a@sirena.org.uk>
 <CAA1CXcDPg7Na9biCMOx4i_xwXZ5Y_qq-7SiYEU82v2a6TFpMJA@mail.gmail.com>
 <Z918-4psPV3j9c-d@finisterre.sirena.org.uk>
 <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAA1CXcD4GRQhUf6BZ+STdKTpvzGKTA-kVidbcGZsKabu=_y6Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SN7PR19MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: f4ea423d-f604-48a2-2b9a-08dd692ba436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|61400799027|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UGU1b2tTOGdrbFdvN0hoMnNGRnRkN0hGL0k0MnE2ajNlWThlczVwTW8wS1ZG?=
 =?utf-8?B?RE9ESVZsNi9wekx1QU9lelQ4Wmt5U2h5cE11OFVzd0hTeHMzZS8yUCtOaDdT?=
 =?utf-8?B?cXVqQ1hZNGM1SnY5bTdJUE50Y1Bza2RBRVBXVnZ5b1Z1eVlPWWJEekgrRUVq?=
 =?utf-8?B?Vy9ZeW9LZFZYTjFBMnJkMFZUNGlvYWp3SEgxaW1FTlFlNG5rdXUra2x6dysz?=
 =?utf-8?B?N0x6UUxmN0EwQXhmQTFETkw2amVwTTI1L2t2b3hHaG5rS1hvRXc0VUNEUTNV?=
 =?utf-8?B?S3pjTnJ4ZVZFekFoNDF6NTY0OFhac1F4eXhNaFdXNlFFT2syUkN5bDFTVngr?=
 =?utf-8?B?dUpEWlExTVphWHlNZlhFUFdPb1dCQU1TY2JrTWRwTFNaWmhOazdaL3Rwd21j?=
 =?utf-8?B?RHVuNjJ5dWhlaWkzZWppeUVWbWZpZVhWRUdHdFU5a3ZlN1dwekNLUndzbzdP?=
 =?utf-8?B?S3oyL0hSampLMjlBUGpVTjFXTzNPdTYwSDU4dkdGZGE5NUFCSHpLT3ZRNkNZ?=
 =?utf-8?B?a1BnNDlOS3l4QS8vcWcyNSs1cWlPZmROVHFxdDQrSU1ZanF5K2lDeWhXaEFi?=
 =?utf-8?B?T3dEaitYWkxra2lCaHppb0NRc2ZKNEl1MVA1VW54ZlVub1J1WWlOaTZGcGt5?=
 =?utf-8?B?VDhVQVp2WGt5L0wveURNeW1vQ2JDdXNJdE4rQ1pRWFRhMUp5MUU0cTZJUG9a?=
 =?utf-8?B?RjJja3dERUw5elBRaDlKc09xVk9jSFFTU0N4bFFCNHdCTWE1ZkplM1EwWmxt?=
 =?utf-8?B?T1paZ0gwdUhXV0tqRW9tMm9XSlZNd01sOHNSUzgwMUk0b2JSNS9IS2pxUHd6?=
 =?utf-8?B?ZmlFYlhWNnI1dVNMNGh1ZHc3eXFMTDI3cWpkeHFSdGVqRng0clZGL0I5dEEr?=
 =?utf-8?B?ck15ZkpETVlINXJkWEszaVhxWE9MZUgzMHpvWmU2b2FRWjFHNW55VHI4NUw1?=
 =?utf-8?B?cEF1VjNtWGkxWUxOT1dZOUJwMCtDKzZpREFmcFBtTlJkRFBRV3J2dDV3RFBL?=
 =?utf-8?B?VHRVejhwQjFPVGFmcy83akJNOHNZUElHMGszYWVidU0rVWplbDFmMzN2S2NY?=
 =?utf-8?B?anZKeFM0VjcxVWlrdjkxWWRvbThZU3lHMnFUUlQzYVo1MVJQZldTeXpxMzln?=
 =?utf-8?B?WnViVDhkYmtKbWxXMDVKVEdRM0w0Y1BMME41clJ1N294czdDd2pMNXNIRE5l?=
 =?utf-8?B?NzNiakdsYm96blNMOUoveXZuL1pkeWdodXdWMHVXSG8zdlpmdlU5TjZ0U2hv?=
 =?utf-8?B?MFhudDQvbmRkSHVBRTl1SGlXdG9GeEpMUFFRRFhvdWFDeExQQk5CYXMvWWFt?=
 =?utf-8?B?N0RUWkRiYlFoTFRyQXY1Vm5QQy9rYzVxSCtFY3o1TXJTVkNZb0RwV3Z2MTVa?=
 =?utf-8?B?NHVtUm9nS1RmbzlscnZtL0k4U0dIQzhIQ1kzV1lzS2RnSzE4MjZKdFcwM3JG?=
 =?utf-8?B?Wmx0ZmN2dlk1akhzbk1Ld2xOYUtPMmV0MVZVckRjMUtac3dZUHJyelVzL1Vp?=
 =?utf-8?B?TnA3bllKS0plNGNMTzVaM0d0OXk5NytRL294cGp1ZGJRcXcrTG5wU1RDZ2d1?=
 =?utf-8?B?Ull3N0N0VnpacXdNSUF3cDBRdDMwQTlJNjIxL2pKa1AwMDFTNUF1VW84MjBj?=
 =?utf-8?B?TlNJMDEzVXJkb3E4dXl3VG9GYnlkcThaTzBvTzRldFF3ZHV0VDlaNlArcjhy?=
 =?utf-8?B?bm9LM2JSZldPNUtaeUNZWUNDalIveTJBU1A1dHlLaWtiZzJ6ZFpFalUreWI4?=
 =?utf-8?B?ZmFvTVpxVVFPWThQUXpma1FoYVRzL0U2K1FGUWVObFlaYWtCVWJLVmhYUUpm?=
 =?utf-8?B?VkNCQnZjVWQ1czFFUXh0Yy90RzV2KzlXNGxxWkhjZzBvcGg3STY0NUFJZG1z?=
 =?utf-8?B?eEdpRHNPcTRCK1E1eDM5UiszUFdUUjZKWUJTbFczRlFVK3NuMmZVK0pxV3V1?=
 =?utf-8?B?MzJ4QTRydFp5SlB6aTBjRjdVbVZob0dSWU9iUHdWa0ZScmdkUTRoaFh2c2d1?=
 =?utf-8?Q?05OG8QDVral2nzdd6c8g1Whb7p3ZrI=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(61400799027)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 10:23:51.3345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4ea423d-f604-48a2-2b9a-08dd692ba436
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB8003
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=67de8fbe cx=c_pps a=HKd0dofMVZNDIjQNdCpHRg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=2S2m59LItnUluiu_aVAA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: 0zhZztXgk91c_lAWBU8tX6NqmsVtAAPY
X-Proofpoint-ORIG-GUID: 0zhZztXgk91c_lAWBU8tX6NqmsVtAAPY
X-Proofpoint-Spam-Reason: safe

On 21/3/25 15:01, Nico Pache wrote:
> I'm a little confused how the FW_CS_DSP config which was added in
> v5.16 is reliant (library code that is only used by KUNIT) on a config
> that was added in v6.14. Presumably the library is not just for the
> KUNIT test. What was the purpose of this config before the
> introduction of the KUNIT test. Im guessing it was not user selectable
> back then too.
> 
All this cs_dsp code was originally in sound/soc/codecs/wm_adsp.c.
The main DSP support was moved out into the generic cs_dsp library
so we can support using the DSP with non-ASoC drivers, and on devices
that are not sound chips. The drivers that use the cs_dsp library
select the Kconfig.
(ISTR that the config option may have been renamed to FW_CS_DSP at some
point, so could have a different name in older kernels.)

>>
>>> It also looks like FW_CS_DSP_KUNIT_TEST_UTILS and FW_CS_DSP_KUNIT_TEST
>>> are redundant.
>>
>> Possibly there's more tests to come that'll use them?
> 
Yes, that is explained in the commit message that added this config
symbol. As this has been split out of wm_adsp, we still need to test
the functionality that was left in wm_adsp. I wrote the test utils
functions as a library so that a wm_adsp kunit test can re-use it.
I am still working on the wm_adsp kunit test.

