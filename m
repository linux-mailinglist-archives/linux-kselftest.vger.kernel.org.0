Return-Path: <linux-kselftest+bounces-34058-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C3EAC901C
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 15:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B46417FD00
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 May 2025 13:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8241494A8;
	Fri, 30 May 2025 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="h+jbPAg6";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Qn2xfal6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AA41E515;
	Fri, 30 May 2025 13:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748611459; cv=fail; b=R45/rySfghDUxvzIL3S7/ueNy3vML3c7SAYH0y56C69u/EUF7DvF7wYc6xB+URMgzqaKwd1S40fucJ1fXfsa5NVmhIQcVzZlFJASSXJkgxIU6uPHf7T4gttnqw51yYI2ZgsK2dz/OkSeBvAycqG39D28zeAfJXSN2L77m2BX7l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748611459; c=relaxed/simple;
	bh=7HRF+PUorsgSSdOumetgp6bK4NH5r6YDRe8ZI+6Hkq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TiVDG1wA1V1jC2JiEz32wYsp9t4Lk5rqsY/4QKMdnsjrye5XmI/xQuAx+EZTFuCMQswhEeitip3C9KvMIoijUQIU0VoI+I3w6F81LpIH5yNrQKwnR8QsO6qepJg4imEYuzWdQnSZMjPF1VTV3hiVTLbpGcRoSQp2V+gEZSW7RzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=h+jbPAg6; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Qn2xfal6; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54U7Oxxm004760;
	Fri, 30 May 2025 08:23:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=BraL+uiPimIcl44K91VdSp7ntXPCQx03rpkbFIGvAvM=; b=
	h+jbPAg6Fuu1v7Qf9BjYRhgR7Q0DBTSwqLhL2V4+eUAN9gIQE9kYDb8MaQf/or0d
	/zSHGgnqA5UlvGeuYtVpZQXuqNjXFtX1Rt/ZFG2tP/bKBIQ4mvFzyxi8h+zbK1Bi
	59/7Z8oSFb4THKsmIjWWALy9A66mGaoI885Il5KgF/DUDxHXaGE7/bjI5LAJ/vXl
	uuDTMcWkAPTq47MQ37ZQa34lFUlaRdAj7gYjx2A/jBWvON+Kdw9lK5cOu20exxqD
	vEDGZ173fkRjZ2ZWO+wy4JKnMq6cntjBt+YTKOD0afJd1wOOoBbkaFyOx1/VCJyq
	jTYQw/sc45VXDSvnu18wFQ==
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2118.outbound.protection.outlook.com [40.107.236.118])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 46x3msugw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 May 2025 08:23:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wp0xM0JWNR1YxkDz4ftG6afieCr7b2sgM4gvr5UdMDMLAFki/iUjTbqO1PziFeQEW6TQIsI4JxpTbJRReZxvm8/+4aXcHOXteuBpcQtODfYdO+uEUo37Q1fCNbYOabeuGyyYHRKZsbtXvxvmjbJ8L7DQDaNcqoQ5cdPsaHv0uRl8mJsEiLTeATfHsIl1t6jKMrjQmEKlUVUlQ0OHGP4+uZ8xJl8sncejFtU9HThU7CjFl82cc86dohKREugp8mDL3knndTDXZtOJSvI94dyqSsW+DiBykwzhCybo3ds5aK+VF26O77i1TEAtukUHzVbbabIrjOftdBKBU8YkFOJgyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BraL+uiPimIcl44K91VdSp7ntXPCQx03rpkbFIGvAvM=;
 b=lWrP/s1WWJoezi0sja6c13sWpF2yqseVGZrV7q0GIF+2oU0nDFvGJIOhIA8mbBtBEBHsrHEYN6NZ6lXeMozunx2SpnXWBSqnLa7XxkX8OfhM62a873t8rOPraeAeW2j9k53chqvP2/U2XyZbZrW8iDiMWnkfZPfFeqFLUK8Nh+7NlkHoqLQw3vNEtfi5WElCGg/fFSDe96Q1AnS+g9qmKIorQwK0J62SUsj7qwtWJCw1flFtgXCpj5WCRWAGI6vl+xtNRAChhUffAmM/DDcXDHd3MOPPSu+ohhbf7jY9Qr+L/2dl5ebt7qcI3FUiSMXT4Y0yRMyN3nwQqp734ilA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BraL+uiPimIcl44K91VdSp7ntXPCQx03rpkbFIGvAvM=;
 b=Qn2xfal6lZ75x/g+GlBwALwqFTRouAnZmXb3trcYDczPhoirg0u+NK4aNAQEERZMY/fcVAaS0QmMgnMDsszD8DLjVih1EaETJApKzZjxhlWxiPfx7UwKJm5v7lYFJPgG48jH2sNC4FJD0s/zgNR+fevwIZ1XHdZDxeF6USUecDQ=
Received: from MN2PR05CA0050.namprd05.prod.outlook.com (2603:10b6:208:236::19)
 by LV3PR19MB8443.namprd19.prod.outlook.com (2603:10b6:408:20c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 13:23:49 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:236:cafe::cf) by MN2PR05CA0050.outlook.office365.com
 (2603:10b6:208:236::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.15 via Frontend Transport; Fri,
 30 May 2025 13:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of opensource.cirrus.com
 does not designate 84.19.233.75 as permitted sender)
 receiver=protection.outlook.com; client-ip=84.19.233.75;
 helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18
 via Frontend Transport; Fri, 30 May 2025 13:23:49 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CFC32406547;
	Fri, 30 May 2025 13:23:47 +0000 (UTC)
Received: from [198.90.194.24] (EDIN4L06LR3.ad.cirrus.com [198.90.194.24])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 1A3C9820258;
	Fri, 30 May 2025 13:23:47 +0000 (UTC)
Message-ID: <1f131def-8ae4-42ab-8c4c-b3489515e6fd@opensource.cirrus.com>
Date: Fri, 30 May 2025 14:23:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: configs: Enable CONFIG_INIT_STACK_ALL_PATTERN in
 all_tests
To: Jakub Kicinski <kuba@kernel.org>
Cc: brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20250411095904.1593224-1-rf@opensource.cirrus.com>
 <20250529083811.778bc31b@kernel.org>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250529083811.778bc31b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|LV3PR19MB8443:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ed2870a-4fce-45e1-c035-08dd9f7d36ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|61400799027;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2hGMCtUWXF0YWNFYko4MXNjTTVOTTZZWGdLQ0ViZVl0bkM1V1h1YUVUTkk4?=
 =?utf-8?B?T1R6UStXYjl0eit6MTZROHRSMG5sbVh2MHI2NWpuTGNMM25SUmZrNHA4K0VP?=
 =?utf-8?B?bmJNNHdQdVZxeXVKTGtwcFkxWEZXenJjR2V5ZTBxeTVoSURHSDdseEZTVlUx?=
 =?utf-8?B?a3ptbGpEVjQ2ams2aWg3THJ6SWJqT0l5UXhVRzJrV2l5VGJkU0FWL3dHUnVv?=
 =?utf-8?B?UUZ5VkczZEtzR25vMmJUb2diYStHSE1aeFZXZmIySTlTMm8zOWswQWdqNXpi?=
 =?utf-8?B?NXNDeDY3WWFUdnkydGJpMkgvYXpxM2wvbmJLOHdKdHkzYldQRHgyZUlOV3lK?=
 =?utf-8?B?LytqWkxZN0JtWE9OM2s3MUFZWTdYUW5rVXBzdVpQa21zaEE0UTMxOFpUcWJr?=
 =?utf-8?B?QVZRbEJvY0xsVG42YUh1VmVYRHJLYWx2YmdmekJBZUNXVzZVU2JEZngwcCt0?=
 =?utf-8?B?eE5mcDBXcDhpcnRERXkxTjVENC8zS0Rad3I5MnU4SUJtRkNUM29yN1RPQkxG?=
 =?utf-8?B?VUVoa3QwMVpSd29rblpuaGIxYjdDZ2JwYkZFNGlIQTJJS3J1Kyt0RUVwMGtu?=
 =?utf-8?B?OTBVVlczWUpDRWFHVkpTeml4YTNlN0R1UllMRzJGZXFvV0NESEZBVllNVzM3?=
 =?utf-8?B?Ykg1T3ZKaWlQVTdFaXpLRi8ycHpKdXIvVzh1YTB1cGtnVzIwMVVrM2dFcVls?=
 =?utf-8?B?RE1HZ3d0V1dDK2p5YXM2SkdkMWptTEUvNmxDTmdOWERaOStsMjBCSGVoTmJ1?=
 =?utf-8?B?a1MvcTNYM2kydjFUQkJpTEQ0dkR4VmJqY2grUkd5S3p4ZWpHWFROQ0lranV3?=
 =?utf-8?B?TnQ1Mm80U29ONTZla3BmQUhoaWpEUy9OTVZudWU4UFBoMndudEEzZ00yS1JV?=
 =?utf-8?B?aUM5eUJjY1Y5bFl5enJaZGhZQ3gvZUVDZ2NzZnRDT0pLYTVmaXZXci9RSjlz?=
 =?utf-8?B?dGl0bXViR0VuaHRmZXd3OXFsclFiSmZlVzlZa3NqVEY4aFVEYW9ZazBOY1Q0?=
 =?utf-8?B?OEM4MTVCV0xEb0pXN01OYzR6aHkyRFE4Z3h0WllUWElOSkF5dE45S3BDZjFN?=
 =?utf-8?B?d2JKdTNjRW1JUkxrRHZJdS9HTjRzWkdaWXV1VE9zenBFNGhWTDFTMkxnZld2?=
 =?utf-8?B?R2xUZENVLzd6L09XOG9XdkY1Q3FmU2NiZXZNSDRodHowY2E0RUFBYU9yUWpF?=
 =?utf-8?B?LzdKZUVacDc0MWI1dGVGRG1jL1NZTlJZWnVGT0tOd0ljK3NyRUdFYmlJRGd4?=
 =?utf-8?B?V0F6VEduYlNIMUJ5TzlGbEJKdmZWeDFkRlZmL1M1MUFNUlBURzZZL2dyTk90?=
 =?utf-8?B?aUZjSTNCblBaSmtFeTlUdUo0T3ZmOXI1Q0w1TitJK0JVeTRuS01Lclg0MHZN?=
 =?utf-8?B?d2RDOUNnb0tPTzdmVGRCdTMxTm1Fa2RvY05lQXgyNFVUMVR1VGlod0ZoTVhU?=
 =?utf-8?B?bWJPWUlUaEt2anFsSFNIWnZmMm9VTXhKTXBlYXVyS0xkL2VxTjUrdkhBTUJT?=
 =?utf-8?B?bVFiczc2TnhrUFo0MEFETDVkZk5qVklLMEY3ZU9PQUVzOVBudHl5c0I3M2hO?=
 =?utf-8?B?RnFjYUl4Q3BUMkFzWnJtSXlzcm1DVDFaSmI3VE4yNEFDd25lTHlrTm4xRnNG?=
 =?utf-8?B?Z2NycmRST2NwTTA5RnhiR2hFYmg1eW43d1R3cnM2VCtCa211SHdoclkySVA4?=
 =?utf-8?B?VnZJOFlINk1yYkhibUFSVExmMWoxbGgwRVFpZk1HWUVKRHZJNjFpa2NNeFpV?=
 =?utf-8?B?TWd5a1NUVm8xUTVnanU2akFxZGNIRnF2NC9weVNnM201WUVuaHgvbE1QUlNC?=
 =?utf-8?B?K3lKZTh1K0V5SDc2NUJFaDd0QW15T2ZQRkJhWlJqY1ljSTVGd1JGZ0dYSDYw?=
 =?utf-8?B?R0luRjJuS0s3akNwRmZ2QndZWnBXQWVBMmxyNFJKQ1BkOHVQM3AyMTdKeDg3?=
 =?utf-8?B?cXVNSmowSXIzeVFxblR6NHdobmFsRWVCNUtaaEkvN1dpQXRkRVYxT0dCWmhw?=
 =?utf-8?B?L0JuYnF6SDl0MzBBSW9FZ3k3d3Z1RklyY2pQbE9zRnpVejI0d0pFWkVhdXA5?=
 =?utf-8?Q?FQYXni?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(61400799027);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:23:49.1479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed2870a-4fce-45e1-c035-08dd9f7d36ad
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR19MB8443
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDExNyBTYWx0ZWRfX7MQXs4Z1GiPo uumJBmT4KWjkLia9eDd/S4q3fLn0CYW0CQx8vlc0MvmzmfyED7s/bfVa4r10WtTT8pzH65lGzYh rWe/T2xV1l1cac4Y7UqMju8ySKh52nh6S05Pr4urtuYvpzwa1xJ3moVqZbN5/Ro+XXKPFHsY3m4
 ZlXOAmTyQJhHVTgqDlaUniRUE5Eh+ubSTxFWynsZhVs+A2B5Vf9duTTbeBRNBac+CtKHR8Octpv sGW4FRkrDG4Exbh3kW489Wy1rq6hewMdPfeevXn0/AZuWFr1VKou2a56nK3/ZKdI8JftQ/DJlpj ewmdE8BiD+/UQfLxtbb3VVkfFNZkyYHVx7nlZ377bSIzoz6t0Mp6xTsGoWQtky6W4nVl1ztixuj
 4o75RpYlDevF/O1vQBIJr0qy6cIAFDf8NCIxpfLKB37fNq2qu8yvxUxmIqGBr/2xOOYfvqe3
X-Authority-Analysis: v=2.4 cv=Qohe3Uyd c=1 sm=1 tr=0 ts=6839b16a cx=c_pps a=KnCRqBS1W09bL7b8BvnpRQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10
 a=dt9VzEwgFbYA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=w1d2syhTAAAA:8 a=umfE2JSC5LyJRm4ppqEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: CseGHcp_nDp1toFcbz0zEJ-gnHwkJWS0
X-Proofpoint-ORIG-GUID: CseGHcp_nDp1toFcbz0zEJ-gnHwkJWS0
X-Proofpoint-Spam-Reason: safe

On 29/5/25 16:38, Jakub Kicinski wrote:
> On Fri, 11 Apr 2025 10:59:04 +0100 Richard Fitzgerald wrote:
>> Enable CONFIG_INIT_STACK_ALL_PATTERN in all_tests.config. This helps
>> to detect use of uninitialized local variables.
>>
>> This option found an uninitialized data bug in the cs_dsp test.
>>
>> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
>> ---
>>   tools/testing/kunit/configs/all_tests.config | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
>> index cdd9782f9646..4a60bb71fe72 100644
>> --- a/tools/testing/kunit/configs/all_tests.config
>> +++ b/tools/testing/kunit/configs/all_tests.config
>> @@ -10,6 +10,7 @@ CONFIG_KUNIT_EXAMPLE_TEST=y
>>   CONFIG_KUNIT_ALL_TESTS=y
>>   
>>   CONFIG_FORTIFY_SOURCE=y
>> +CONFIG_INIT_STACK_ALL_PATTERN=y
> 
> This breaks kunit for older compilers:

Drop it then.
It's not essential. Just something that showed a bug in a test so I
thought would be useful to test always. But if there are compatibility
problems it would be better not to have it in all_tests.


