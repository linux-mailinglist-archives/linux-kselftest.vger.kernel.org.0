Return-Path: <linux-kselftest+bounces-29603-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E95A6C8F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 11:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EBEA3B015B
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EE81F463B;
	Sat, 22 Mar 2025 10:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="PGiNChNm";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="FjneXVQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172361F4624;
	Sat, 22 Mar 2025 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742638290; cv=fail; b=Cn+ebuSGfpdx+/eVpc09dnR/W7q6f1sJ/znAFoeKsx0wORCO9lwUTlxv3g8TPapTxqtLOp2TlQEjkSPWaGZVkjsm0KDWTG2qT8pxQ8lktAFfvQGBpyoYx9g0zZQmK0eHXhaanJGdmoeEns0kReeI0g6bvLOe+KLTt4CM8ZSJZP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742638290; c=relaxed/simple;
	bh=3IVFPln2S1nyaiB2liwFzmVFiiOyL/z7rfJPK3bQGyA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KR4ztgbCsSrXyeNOVguJQ+kBfivmbkIMBJdFbHf54Vxri09fmz8MN2eADKDrbYYUDg5n64/v7tLt6qKsay+/BVgirkkRyjbr1T7pROxXwhHbBZa0GAOp7HkRkFnBZctcBd7ag7ljpgfIp3RcyW7TavNx0TDwOfOXi3LgA9udZts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=PGiNChNm; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=FjneXVQF; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52M9wbxl028862;
	Sat, 22 Mar 2025 05:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=Ifxn2fUhDu+EQmTq18C19C402G8HVbD9p9jvmJ5LmqA=; b=
	PGiNChNmWhMnm3YtsWbFTHHhZpW84FfAX10QEzU9+hr2+I7Wga98wKZKZBCa8fEW
	uWVxYjv09QY7MExDspQM/T2p0GUbGfP0rY5ED/sqS6W0Kryhl2trnPEoiuzO2Hb8
	NnV3y03UlvqRuIZn7JKSqs0jbnOAWXlVe4o6QN/rTP/S6dYWHABY7UXaQGQW7V6V
	Oh/nkvYwAQeFExEqaFt69PCE+3hWrRLefLuILiQo/zsEc9GlckrAde5AYkqvccrs
	2fGhwtotyq2tE8/sI4TKhn9z4EF3SyR0pKFGhEwuU7DA0Ofn55JwpZIDrGGgf5GY
	wrq3m64geRwxt5mAUJMJrw==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45htm1g186-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 22 Mar 2025 05:11:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLsv0JMtfB9wOQg9sZ/VjL3IW+aMOnR9ZAMInVRiZYphABZnfsKyljqvY8jxPxfOeafiDBRaeb+gXOMgJ2msRDWANKnN04ICcSEPs29qBHJnj7EbUKVGl+hmCA01wmX6juvVR3AdaVozcQldQCaSFkgywg+jJFCN62hwFNR6qpLQJJIT8yw3wFZO/Bohso/IlUX0Oqh9/44rOefkqjrT4f1rgSuTqzrJnhvtME6fgIG9CWaN9xs0wvCaQlP0xSB0Bc0mEnyfO4LT4ZMhkU1j0/up+2oiqkxlruUIoIVjh4JvAG+7AlmqGpaqPA4G+3wikbHfiErsXUuonH77DO1bBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ifxn2fUhDu+EQmTq18C19C402G8HVbD9p9jvmJ5LmqA=;
 b=TN8VYv3DVd65I9moNEhxvzj5eoLuUib2g4uEjEvcxjyY43S0z7IiNYFvLflDMYVPcUdMD8/DOSHw7nlBYKWGVwlwozJ5uyvePkJzmyxkaU2uXIaR+7PmkVs+rjrac/PaiTvvocOyEebtJdbKTTk9olpvyn3i3cKtFppHyv/h/NL/44SLePjSU40gILXL9eXBBsZXDhshhOiKFVQif3sYYnHWeOLNFvE8A58jVHppJrIfetltlVLuq6Ntl8vUQrqS7Hzy5/Vg4ROIBvT5fIpuitFJjDEtcg7FznE4h6Sv9ZWRLBfOf+R7BmyaafIXxjDkezD7PjO1ceom00kh4sEBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ifxn2fUhDu+EQmTq18C19C402G8HVbD9p9jvmJ5LmqA=;
 b=FjneXVQF3/SHh2P/5N454c81O9aFoZUEWlYTO82QDCNZDyer//fk0Ouvz7MEURAbi0VCIO6LqgntVf8z+fawWnO2jVMePUg55q/tFVAlC5JfMQCm/w9mM33poB4VcmXXEJnvevB8CwmduY/M7ciYypQut7StmT+yBnYYR3doGC4=
Received: from BLAPR03CA0029.namprd03.prod.outlook.com (2603:10b6:208:32b::34)
 by SA1PR19MB7088.namprd19.prod.outlook.com (2603:10b6:806:2b6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Sat, 22 Mar
 2025 10:11:10 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::ad) by BLAPR03CA0029.outlook.office365.com
 (2603:10b6:208:32b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Sat,
 22 Mar 2025 10:11:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20
 via Frontend Transport; Sat, 22 Mar 2025 10:11:09 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 65C1F406540;
	Sat, 22 Mar 2025 10:11:08 +0000 (UTC)
Received: from [198.90.194.24] (EDIN4L06LR3.ad.cirrus.com [198.90.194.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1C691822562;
	Sat, 22 Mar 2025 10:11:07 +0000 (UTC)
Message-ID: <4cc16ecf-d498-44a6-99b2-eee840cff63d@opensource.cirrus.com>
Date: Sat, 22 Mar 2025 10:11:08 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
To: Nico Pache <npache@redhat.com>
Cc: broonie@kernel.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, simont@opensource.cirrus.com,
        ckeepax@opensource.cirrus.com, brendan.higgins@linux.dev,
        davidgow@google.com, rmoar@google.com, johannes.berg@intel.com,
        sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
 <CAA1CXcD2g=sRRwgLSudiOAqWXq3sCj+NPuE1ju7B2gFXXefjXA@mail.gmail.com>
 <d8fc1f66-f220-42fb-b58f-f5f9c7d30100@opensource.cirrus.com>
 <CAA1CXcA460xfy48JMNeX5rNTfUqsahER8SDF6tWu82V35ripLg@mail.gmail.com>
 <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <CAA1CXcD2RF6aXNH0ix=GN1+LTR9+dV7yRz-HGKZfUbSu+8ZM_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|SA1PR19MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: eefaabe0-f874-4705-44e4-08dd6929de19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|30052699003|36860700013|82310400026|376014|61400799027|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SDVtQnBZYmlHVThVUHhOQ3JTRFRucjJ4T1dua2NkSGJQbGRLdlNtZDNKK1Ns?=
 =?utf-8?B?Zlh5L2VZdjFycnlhcGRFaW5UclZKWTNTc1N1Q0F2SGUyNTBMREsvb3FqcDJt?=
 =?utf-8?B?UGxuWlAxQ0Jmelc1U0NTZmJFQkNpUCtwZ3ZWSVR4NDA5Mlc1YzVHbmt4VHdL?=
 =?utf-8?B?SUtZR3Jzd3ZSS1VyNHJENU50Q2hud3NuRFRNN0lrdDJWMzBwMTR2aWU1U1pl?=
 =?utf-8?B?UTk3UkJocHllWHRXenJpQlFIWWd5TjJXMUNHcW4vQUVrWWduNmh4bnFVOWR4?=
 =?utf-8?B?M2NBQ0piUkhPYWxuS1ZZeXh4ZGtyVDJlaVBLWUFIeEJkSDNrbVdOZ29QTnhs?=
 =?utf-8?B?dEE1T25aVzlHZWhCVXVKOWR1QWY2YUtuSjRYLzU5aWpwUEkvVGVkYTI3U2lm?=
 =?utf-8?B?bTJmUU10dCtibVZONzdYWklQTG9DNjFMb2ZRTkhlS3MwaW80WExtazA4Q2s3?=
 =?utf-8?B?MXNtTnNaOWxZQ1puOW9wQXZtazl3QnBMb1l2M1BHalJiV0duN1BxbjNROHd6?=
 =?utf-8?B?RFZneHY1NlFVWlhJY0FldFhxSUFaQllyRHFVaTg1T0RBK2pnVHVwdnNIY2to?=
 =?utf-8?B?NmYyZW4vSHZKUWZpSEd0bUJLOTNNeWUzVW51cEVXc010R0V4MzI0ajFKc1ly?=
 =?utf-8?B?a2FwT0ZGNC9kVXQxclFSUXRCODVVZnFBVittY0hxVk9jSXp6Ym5LZDRyeDFn?=
 =?utf-8?B?RHNUZDlVVElDWnJWeXprWWxqUzB6QVViU0w2T1dNUWttSUdFR1Z5VWJ5dy82?=
 =?utf-8?B?Q1ZMbDhobHpqMFkrajcxdWtNeTlOSW83Vk9UZURoVDlha1EySWYzVmxVY2FL?=
 =?utf-8?B?OHZlQ0YrN2wrdW1zS3dDOWVRaWZiZFNmYitGQXJsR3M0U0ZhZzdWSjQzTGxx?=
 =?utf-8?B?cU9KR2ZlVVVwTGdvY3RiVklCbVpGSFhyRHhUanYyU2NNMGJiLzIxSi96NVJr?=
 =?utf-8?B?SWgwdTdNQWZjREF5ajF4aXVPK3MydFhiRmRYZTR1MnJpOU8ydkErNjZ6Wk1l?=
 =?utf-8?B?ZjBvL0hlc01Fd1g3VW1BTE82RTJwNS9IdGxHSmNGYmFLU1hJV2RtMGwwbFBm?=
 =?utf-8?B?TW1teElzMlprWXZsOGNXNXQ5VmlmRHRwbE9Ha3BGb0Nrek5GYmZhdThORnp2?=
 =?utf-8?B?cEt1NTN0SU9YYW9GazdTTDBDUUFiNjRRL21laWlrZHpreG9kTEV4M0pSSUpj?=
 =?utf-8?B?NDhSK3Nna29NalVmbC8vcklpMy9CbnYzTzB2Q3pOR0FqTUpaZlNYb0dkUDUr?=
 =?utf-8?B?TStGL24xUS9PcDlvOTE0OHdEQnUweDMwUWJNSjhDcll1blZ2dE8wOHA3RjR3?=
 =?utf-8?B?N2ZhRlNaT3BVNE54Ui9LdXVQK2x2L2ZPMjVUOFVCcGVMYWRiclFub2IwbWRV?=
 =?utf-8?B?MVFpVnR1RFJFZG52L1JXdkdVOWRzU1FkMW85NWhsUzRGT0dZc2Y0MWdJQS93?=
 =?utf-8?B?SFloV3NRYUtaM1lWamlxSm02dFpaZmtiR1Q5ajBlMkYwaFlqVGY2MmtzRzE0?=
 =?utf-8?B?MkJOaGt2VkZyTDhqVzRadTJISDJoTUZxakRUaUg5OFhTVVRpeVUzSzUxUjA4?=
 =?utf-8?B?RzlFTkdOY1dsU09SVW5LNVlpNlhhRW5Nb1pta05Hb3FaYW8vWVZKekszODN1?=
 =?utf-8?B?VHJScWlZRHU5UHZGV051MlBPWEZCSms0cVRFYjltTkJkNlg5Z1pjRGd2NzVl?=
 =?utf-8?B?enh3My8vbi9uL1ZRNHZHd2xjTlBkWVRVUERycXYwKytRdG1aY25xM1V5cGVu?=
 =?utf-8?B?RlIyY2ZXMW9DMnpzVnR0UXNxRUVaa08xUHFIM1Y5ZFZwZEgrRGVrcjREaU1u?=
 =?utf-8?B?OC9UTkdZK1krS0xEVDZsT0NlTE9pSWYxZnZMUmo2NWFucDUvUkw4dERFeXBP?=
 =?utf-8?B?Sjk1VXdEQ3AvbCtkTGdNQm9iQ1VZRk4vSERrVitINlJ6QmswTS9XZXhPWGl4?=
 =?utf-8?B?a2NjOE5oUzFtTzFnUVJZMnhLM2N2VGZQbVR3Q1A0Tmt3azQ0WHNFZlltNC9k?=
 =?utf-8?Q?C44onQCkHQZEf077/mfRLHkm2scWF0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(30052699003)(36860700013)(82310400026)(376014)(61400799027)(7416014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2025 10:11:09.5064
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefaabe0-f874-4705-44e4-08dd6929de19
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR19MB7088
X-Authority-Analysis: v=2.4 cv=WvwrMcfv c=1 sm=1 tr=0 ts=67de8cc2 cx=c_pps a=Bc47kgIQ+uE7vzpOcRUeGA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=2pFSGazEy1rrxoDnEKsA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10 a=y9bjgA0s-ko5vcjcBae2:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-GUID: x--Y00Uxp9B5WXzXDvjg6xPrAi1cN0r_
X-Proofpoint-ORIG-GUID: x--Y00Uxp9B5WXzXDvjg6xPrAi1cN0r_
X-Proofpoint-Spam-Reason: safe

On 20/3/25 17:35, Nico Pache wrote:
> Sorry links got mangled
> 
Thanks. I'm on vacation right now but I'll take a look through
all those when I have time.

The unterminated string bugfix is this:
https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de/

I got lucky on all the UM, X86 and ARM builds I tested.


