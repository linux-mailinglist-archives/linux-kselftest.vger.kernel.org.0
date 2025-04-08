Return-Path: <linux-kselftest+bounces-30345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3599A7F972
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DEB189E2A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FD2264FA9;
	Tue,  8 Apr 2025 09:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fnSm476X";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="kko18Hfl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DC12641E7;
	Tue,  8 Apr 2025 09:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744104376; cv=fail; b=MRhK2H4rjI5xuv6jwIGDYkIUUxWoGoeq6Ssu5Uc9HtIf/sy+D4EptGUiCxHtRzM+ym8ajnRxVcKEA8TW4/fuBV3N1wdM3dZVkrmhYd2WTu77AlIAU7Vc6vMyqOkLPlekBQplPbeyRAx2ulmDl6UJ1vUU2TIw1UEvm0v2FEYFCJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744104376; c=relaxed/simple;
	bh=O8wyE09c6jOhnpf67ppRUvOtfn4wouOcGHga/Ur3LlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HdNu2cWInuJt5T/194hcNBTgPhCEJgPgkl6BwkWTQByRb3mJZnEwDqrzUxv2TjasmMMrEyf1S6sknbaYZll8iMg6kpxZWJE6pfDiQb54890Z4ft/oNepkfcF2g9ZDy8uzJGK+fNQu1E6MZ0C2VDtTl53WGkyGNSbpQ+jC1+rtuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fnSm476X; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=kko18Hfl; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5385decr006814;
	Tue, 8 Apr 2025 04:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=EM+UDYMizLvy8tOvFReu3FlvsM7shKLBEpV1KgpbL40=; b=
	fnSm476XwQRLL0FsS1lf4lq+JqWLdlnrfn9TVg18MMi0sKWpc09beoHJAzfzFB1c
	lLKvkd2MPAUavHak1MC5tDQWNbhqUNmBcEy1SClNm2cikALXAV0Lro9UZS46QfMP
	lwAIQ2iH/X77kMmiRWAONGBf/RdIAJxz8jZdPv0McouUOW9/vcqnjQpws5oNjip+
	fS4nKpKVh0V8zcXauLXbCNv+4BxlqtNenVHqPl4HlS9ptHVZL/zBqp3+WLhut87H
	Pha9KWNDqvAt2qPQiQnXOOezzmvUEhxiAcDnx3sJH/N8OsqZdPbHslFsFthj7HYw
	x7SVB/NsrGMYKjTP+CD4ew==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45u0xgkxry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Apr 2025 04:25:55 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vsi3Ub7Yrkh1pHq+FRbcX+rhd791QnphLHVW0jYpC2TxJjPmSvgvjmjNdYSk5WY6RZ/w5eGb6T47xhO5CQsLPkzP8NhvA0CtnS2xKZZM1UZkEAE6FpkjYFQ7somlmLoZ8lgIneNp/gaC73MsnkzHGkIqDo0rRHjR+9TiJGCuD5tepcOIgZG2UPOYTrNfZLUUua/SXe922tS6p+dw7ymfo7xayXibEqPiYwsiVaugncfwzP63qLDgfNNpnfaGsGWLpapvQ5wIz6CBZEb4cQ9uTwsz6qvpDGceJazCmQdk8yMDNbfX22V4e5LwiEszUwVlaCbuPsFC7DGE2gneEFXlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EM+UDYMizLvy8tOvFReu3FlvsM7shKLBEpV1KgpbL40=;
 b=dEZEjctdyATRrOoiAoPMQyl3ey9tUoqulwk0WR7eLED5ATW9SzewZ95Nxjh9T9dnO1Y2DL5PA60x6xIrWt6fN5G0Ov6x+6N37EhWTFwbetYt8/njI2kybvdgdyvH/XvZSDot1u/lghSenutGq8mMMXAYvOKfZFWjGAoZaaGvkLwqhjR1nv1npK/ML+imWKGCwNGWoefHLy4Chse/a1PWFAgJ8jHPC/WJLfP+rO2+XaRDAp4V6XzITeqDojTj6CClq657sJ6NVXMvDtbkiP+CZXz6Dh5B+SdONf5XQriMkIV2+UTm1v6F/gAVuEFHavRoUK1XAlf+bgxkg9OcMAXWag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM+UDYMizLvy8tOvFReu3FlvsM7shKLBEpV1KgpbL40=;
 b=kko18HflRSvbOnjhPdoRWeEkTB1HVR6guNwXMw0LQVji/8Kld08gJ2bM+WE5OtrlTI9Ug88BtbFAJeOPNPvTMoLZH48auZiTgZ/OZSUubEsF6GRbf1nWQHKS/dJG9Xzb1jT2kRD8dYf6V2bGpYUfW5FMvUpH2x8jbqoags9luW0=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by PH0PR19MB4890.namprd19.prod.outlook.com (2603:10b6:510:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 09:25:49 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::af) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.11 via Frontend Transport; Tue,
 8 Apr 2025 09:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Tue, 8 Apr 2025 09:25:48 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CE608406544;
	Tue,  8 Apr 2025 09:25:46 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id C3944820259;
	Tue,  8 Apr 2025 09:25:46 +0000 (UTC)
Message-ID: <9024776c-7028-4522-a773-8d53d233dabf@opensource.cirrus.com>
Date: Tue, 8 Apr 2025 10:25:46 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
To: Nico Pache <npache@redhat.com>, broonie@kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: simont@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        johannes.berg@intel.com, sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
Content-Language: en-GB
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250319230539.140869-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH0PR19MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 24026865-2386-4a32-170e-08dd767f58fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eTJ0NGxzdnVkQ3o5R3pMejg3SVlBMis1YmdPdHJOTExlcVhtakExNlo0QUlS?=
 =?utf-8?B?ZzFOLzJndWxEQkxSUm8yVE02d2YwNFo0ajd0MEZoRGlza0VmblJ3WmUxc01m?=
 =?utf-8?B?ejhrUFd4TnFaZ0ovWXpMWm9qNjUrMzMrTWFSV01DUURlQlE1VUsrUmVpNjJs?=
 =?utf-8?B?V3pDaThJYVVRQStsTlJqNCtkOE14bVZUU0RMZXVzMmVmbHN0SU92OXlraWNF?=
 =?utf-8?B?cDQ3RE5aazc1VmFmOERLVjIvVTVjNzJ4dnNRck5OR2p4NlhTanNWbmdXNWdF?=
 =?utf-8?B?VjdMZnhCRjZhOHVvL2tqWEJsOG5LYWwzeFdzSEFneTVId2JPZkFBVWN5Skw5?=
 =?utf-8?B?NEcrT2lGekJXZEtXTWh5OWFkRnNZSXhmV1plTVNNT1hIREY3YW94bEZsR2Rn?=
 =?utf-8?B?bGErSGd0V3hQaUF3c3puTU1OQ25YL0FVd2VVaCt3d0tSOSs4UG92Z2p3SGNu?=
 =?utf-8?B?aElmYlE0NmF2aDhkUkNCNE9Bd0xEMUdDUUMwWmpZQ3UxRDhpQ1hzc3FYMW02?=
 =?utf-8?B?YjRvMnpkQ0JXT3BKNGxHakhzc1YwQWxKQzRlaFpCVVlwZUQ3SC9QMUxXbjJl?=
 =?utf-8?B?ekVyaWZ4czR5NDZGaEdLckpPOXZmamdHVWtzc2Y1U1Y4aFdIZUtSSUtTOXlh?=
 =?utf-8?B?T3E0clRtbWYvcHRhSU5nMisrY2lKVVZTRzV3c1JyWjRZQXV3dXN1eHFsSmc0?=
 =?utf-8?B?bGd1aDdKWEtodFlHWGt6NjIxN0owZ09wcVludkFndUJGWmJYL2UwaENzQm53?=
 =?utf-8?B?YlgzMjdtNWoreTNYNU5QN281VWw0Q05wTzY2dmZReG83V2ZLWVlyeHVUUEp4?=
 =?utf-8?B?Nmh2UGI0WUxGSXBzcllrN2JPa0RVOXlCd1pSOUxTWnI3VnY0Wk1Rd2FxY3Y3?=
 =?utf-8?B?WURTakhoSEUrdGRUeTB2bFIveDFDU2VTNGFaMjJVTi85NytOclhUSmQwOTJW?=
 =?utf-8?B?VkZRWlRFTVlObnJmT0dmWlFuKzBCbkEySzN1eXJCS1JBUjdybi9GRWh0aC9O?=
 =?utf-8?B?NHRoODYvY3dzZGdYVXFMZWsrSm9tYmRoOXRsRFRDVDZERXlIZyszZ0hQd2Vw?=
 =?utf-8?B?azliV1pkd1pEZjlEMnJyaVpyYjF6UGt5ZlJlK1Zvb0FxdkptWUh1eWRwR2FQ?=
 =?utf-8?B?aEQ1eWw2QjI5VmQ5dlRPS1hJRGtFWElWUGhDcy94ZlN1T2FGL3cwZGpIMllZ?=
 =?utf-8?B?OGFwZERWbE1EU21pL0xqL0dUS042djJhNzNyR01KNmVFNnZrTDJLdG1MTHd3?=
 =?utf-8?B?T2lBclpGSWpNV0Q0bWlzTjhIckViYzMzZFlxOWoyTTJSbWpURW5Gei9zOFo4?=
 =?utf-8?B?L2E2bGRDWU9TQVA2YURnMzdsbXFPZEJaWENCdGFiMk0zVjNPbkxnTXNTd2FF?=
 =?utf-8?B?RkF0NlF3VUxFRHNCcXFiSnBmbFNKQ0RDLzFTWDYrdnUycWxIOHlTOEhXYzk0?=
 =?utf-8?B?Z2RqY1lhNE9kKzRkbEVCNXVHU2d0MkM0d1lIbEdXZTlRc1lFQVBzNTZFSnF0?=
 =?utf-8?B?U2xmNy8xcTBjVisrclRNaEtSRHdSVmZYMkFIS3A3VnpCS2NUU2xaUzByUTRj?=
 =?utf-8?B?QTVQQjhJcERWSU5vellJRXRpSnpXRWQ0dWx3akRqS1RMb2p0cXdKWWF5eERU?=
 =?utf-8?B?Yjgwd09MSlF0eDczYnR0aC95Y05jbW5EUHYyQnNrVUsvZ3NMM2VPVDVPMXFn?=
 =?utf-8?B?YnJ0UEovai9NbWkybkFEL2Q0Y2theW9Eb3htMm5IZUFUb001b2x2NERxa0ZW?=
 =?utf-8?B?R29ySUw4cmZoQ1owNUgwbFQzN1o2c01RVUROMU1xUjk2cjYwVCt2b0R1YjVa?=
 =?utf-8?B?OG5kbnFZZzlBaDN3bk42TEpsL3NJblh5LzF5MHlodUhpY2ppaEtUKzA2c3Bp?=
 =?utf-8?B?dUYzb0pmYTZTOWhEVjF5ZHBmY0tOaCs3RUtveGM5Z2VQWTVFcElWZEZqSzNn?=
 =?utf-8?B?clhlZ2crYTFwdkRUM0NZSWlPUmpKNVppMDRNRmp3aS9uQUdUV0VjQmNtSEJz?=
 =?utf-8?Q?r3IgtHyC7Rv/un5pYGApf+bAmr+akY=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 09:25:48.0262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24026865-2386-4a32-170e-08dd767f58fe
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4890
X-Proofpoint-GUID: BwvrG7j4sbiHjmLVSJ2gpxMSRZxUNRRg
X-Authority-Analysis: v=2.4 cv=bOIWIO+Z c=1 sm=1 tr=0 ts=67f4eba3 cx=c_pps a=Odf1NfffwWNqZHMsEJ1rEg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=RWc_ulEos4gA:10 a=20KFwNOVAAAA:8 a=t4myKOGuHus48l1THl4A:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-ORIG-GUID: BwvrG7j4sbiHjmLVSJ2gpxMSRZxUNRRg
X-Proofpoint-Spam-Reason: safe

On 19/03/2025 11:05 pm, Nico Pache wrote:
> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
> depends on clause, and set CONFIG_FW_CS_DSP=y in the kunit tooling.
> 
> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file download")
> Signed-off-by: Nico Pache <npache@redhat.com>

This patch doesn't actually work and breaks kunit.py.

> ---
>   drivers/firmware/cirrus/Kconfig              | 3 +--
>   tools/testing/kunit/configs/all_tests.config | 2 ++
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/cirrus/Kconfig b/drivers/firmware/cirrus/Kconfig
> index 0a883091259a..989568ab5712 100644
> --- a/drivers/firmware/cirrus/Kconfig
> +++ b/drivers/firmware/cirrus/Kconfig
> @@ -11,9 +11,8 @@ config FW_CS_DSP_KUNIT_TEST_UTILS
>   
>   config FW_CS_DSP_KUNIT_TEST
>   	tristate "KUnit tests for Cirrus Logic cs_dsp" if !KUNIT_ALL_TESTS
> -	depends on KUNIT && REGMAP
> +	depends on KUNIT && REGMAP && FW_CS_DSP
>   	default KUNIT_ALL_TESTS
> -	select FW_CS_DSP

These changes result in a circular reference:

error: recursive dependency detected!
	symbol FW_CS_DSP is selected by FW_CS_DSP_KUNIT_TEST_UTILS
	symbol FW_CS_DSP_KUNIT_TEST_UTILS is selected by
FW_CS_DSP_KUNIT_TEST
	symbol FW_CS_DSP_KUNIT_TEST depends on FW_CS_DSP

>   	select FW_CS_DSP_KUNIT_TEST_UTILS
>   	help
>   	  This builds KUnit tests for cs_dsp.
> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
> index b0049be00c70..96c6b4aca87d 100644
> --- a/tools/testing/kunit/configs/all_tests.config
> +++ b/tools/testing/kunit/configs/all_tests.config
> @@ -49,3 +49,5 @@ CONFIG_SOUND=y
>   CONFIG_SND=y
>   CONFIG_SND_SOC=y
>   CONFIG_SND_SOC_TOPOLOGY_BUILD=y
> +
> +CONFIG_FW_CS_DSP=y

This won't work because CONFIG_FW_CS_DSP isn't a visible option so it
breaks kunit.py:

ERROR:root:Not all Kconfig options selected in kunitconfig were in the
generated .config.
This is probably due to unsatisfied dependencies.
Missing: CONFIG_FW_CS_DSP=y

I suggest dropping this change to all_tests.config and only fixing
the Kconfig so that CONFIG_KUNIT_ALL_TESTS doesn't force
CONFIG_FW_CS_DSP.

