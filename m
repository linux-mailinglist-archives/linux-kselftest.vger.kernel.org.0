Return-Path: <linux-kselftest+bounces-30076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D40A7A869
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 19:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4F97A5B37
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 17:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D078E251783;
	Thu,  3 Apr 2025 17:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hTgNR2iM";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ESAdcIrW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70382512C6
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Apr 2025 17:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743700132; cv=fail; b=orO74lGXwH2RVpPNove0xM+91TK40t/fdbRgxPeyK1GLzMeEMt2pOzlBAQCTdU46IpQ4N8+YBQGb/S00vYJzGfft2Rq9baYRpRLU7uWscfcIsUTDSL3zt5wrnPWBb9M1GnY1zzf6DIEQvkOikC1VY0gLGkefYFfccQM05c2bQKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743700132; c=relaxed/simple;
	bh=u5JDehWVQo644zAZ3MA9QMsPFOUqxCFa8yZeGYBjBV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VY2qTHIwsFdlcKMb5YgjQN7iWmIkf8pZm39TzFR2tZQRR6A/o6GV99UoYqVdxS6aRmTiyZ+7PgPxMHg1mc2DO4SRSnZAYr0Ja9OQB5UooFqOWXzy1lbrQspXq4QskNRrvcN2lySEpPiDjahAjc9hiP4m7PfyoOW04hA/uUbZ0rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hTgNR2iM; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ESAdcIrW; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5337QWQ1001668;
	Thu, 3 Apr 2025 11:52:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=QokirswjJ71ZP6QMvhiAlYNeMDsMB/kwaIDgWcjC3PM=; b=
	hTgNR2iM6LLl64QC6tSTiD5KWJ9GKj+rQKIoeIDcY9+P0fmrWouNL/9qJedS6i8j
	IYhbrXoOJmX5zFyRipCMvr5fUhgl4Cw6nSy/+zllvDhpisXQvL1kLJ1oWmT1CW/y
	v+JbVZSWXgH1+fLBYEb/nb8TDfkA010cjICXkotWI0s7Dqw2fyVhLvPkNax3pIfa
	PE8tpdQV5BI6Rj8YExQEf1FKx07FdKwKw3hyfODa5aZ4GE+HQLQkT4kHPZxgInNI
	6WbEf0qsDAvumKF+Gtrm9x8yt2BcGqnctHorOWH8+BJCaoc8a/qoNoayoe44+3ld
	hXxEbP8fl+3jvAHZmtne2Q==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 45rw3yu64x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Apr 2025 11:52:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeY43rvXQI4j0ln1E4c6uEcVM1H9jQxctTLugSDQ9dUB/eagJ3IL9txE4FkicAj/H/g6gUrikOfzhxdZqAybje8GOdKiKSfnqsAq5gKyKBdbKA6vRj04vVUB/qN9XZPGuGsEpyK4ZYWJnfNFaeGaFm3V+5TmIP4gis55BR1QiUw89rk+rWVcI266qzhcNaCRYN0lT9Pzu27QgqIF/pgorOcE9I2OhkiyIXd0loSPQ4xGhUX2blKTJ0L0oj+EO19jcQMTqnlqB8ZGr+CJE+RbocgAfZlHCWFwIR+l4+4NsKePIdmcs0MzDmQSIaki7uDzuR3jdc9ei1ewNgxUrgJoRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QokirswjJ71ZP6QMvhiAlYNeMDsMB/kwaIDgWcjC3PM=;
 b=MYejz3j1h7dlFZE09lgo/Szkntv5s4ESLAa3Yez78gT8lCEQ/5o65gPu3pO4mUFrWsRBa+/x3TTkvJ3Idy2H4jZI0/3eQ2TZLspLZfQgbC00uKoqt8WmxzVfMONYICe5gEUPHxxGgmAEPDE3/5ky9pZ6O2Y4qwbSkgzM4dBXTMlHxsSg2nsFgGItee4Yz8aWBD/vgGZSV8ajtASI7/zLZBLlwNNisBAMLgPHTKp75ZqVscUHkFyb1APku+6Q83LoAGQU/cVBAv4OAqDVHmUMTetOBfoH92ED2eHvVv0OR6Du7TeldS47QcaQd5hyV0k/ovnLb4F3D90eC7n0KMaSDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=temperror (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=temperror action=none header.from=opensource.cirrus.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QokirswjJ71ZP6QMvhiAlYNeMDsMB/kwaIDgWcjC3PM=;
 b=ESAdcIrW2+yfqsUmMu7YJJDJaQrAA6AyJHGCEDNOtM3++6dOUeLE0tXM2EltUCouizn6PKw7MJrn1By/rRQ0roUL6NKuM57eYsB+3KoNnnP9JXWwXspfTM9YmDTHWLJMaLosKPwcENQdSQY1hWcrW0Ddzy4XI6nHpjhMSurQAww=
Received: from BL1PR13CA0408.namprd13.prod.outlook.com (2603:10b6:208:2c2::23)
 by DS1PR19MB8579.namprd19.prod.outlook.com (2603:10b6:8:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.47; Thu, 3 Apr
 2025 16:52:25 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d8) by BL1PR13CA0408.outlook.office365.com
 (2603:10b6:208:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.9 via Frontend Transport; Thu, 3
 Apr 2025 16:52:22 +0000
X-MS-Exchange-Authentication-Results: spf=temperror (sender IP is
 84.19.233.75) smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=temperror action=none header.from=opensource.cirrus.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of cirrus.com: DNS Timeout)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.22
 via Frontend Transport; Thu, 3 Apr 2025 16:52:20 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 0453E406544;
	Thu,  3 Apr 2025 16:52:19 +0000 (UTC)
Received: from [198.61.68.186] (EDIN4L06LR3.ad.cirrus.com [198.61.68.186])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 3ADCF820248;
	Thu,  3 Apr 2025 16:52:18 +0000 (UTC)
Message-ID: <9e29bfbd-b2ee-4a41-a383-49202dd257da@opensource.cirrus.com>
Date: Thu, 3 Apr 2025 17:52:17 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exclude cirrus FW tests from KUNIT_ALL_TESTS
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org
References: <20250402103655.3e0c62d7@kernel.org>
Content-Language: en-US
From: Richard Fitzgerald <rf@opensource.cirrus.com>
In-Reply-To: <20250402103655.3e0c62d7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS1PR19MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: a69b3e5b-cdbc-418a-37f0-08dd72cfe652
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|36860700013|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmI3akZtYlpkN2NKNTBudllqOEJITXVOSGJhVGoybVl3R0ZKTUg5eE5od2t4?=
 =?utf-8?B?RGNGZmplTzNhbTA0N1pKRnlrOFcybGh4ZzFXcEpKUklJclViSkdNQnUzRUlF?=
 =?utf-8?B?OUQzOGJJNGszNjk2R2Q0UTFxQWVDNlBCQVk4dUltNEl0YXd1R3RxUHc1QWhl?=
 =?utf-8?B?MGF1RDdzME9qcFNNQ3ZPcmxXc0pVbGNXTi9Pb1lrb2pDYThIVkZka2VJS2I2?=
 =?utf-8?B?a3dIeEF6WW9sQ3VUSThPdXhrcy9iNk1heTdXY2ZKYmZGVkRTdllBYlF5T1E5?=
 =?utf-8?B?cmZ4ZytpSHJFakNvQjNsMGlCTlZUTHUxaWJQbWhUWXUwenFWaW1xZTNwdzh6?=
 =?utf-8?B?SWVCZ0ZoeGY0YXVrQWF3czZaOVRseEorZ0tKcVk0YlBnTlZabUlERkMzMU5E?=
 =?utf-8?B?MDNZRG00TW81S3Z2TTVobUgzOS9qQzBJNmxWOWZ2TlZWdStlR0N5T09qUy9q?=
 =?utf-8?B?clR4RUZ2aW9FbkRldUdwdUE2OE42MGluelhpYjJhZEhkU1Y0UGVhZnl5dURv?=
 =?utf-8?B?REFuVUdnZ25lanN1b0htRFVMeUlNWjdhQmgrbytVdWx3UGN5ak1PUGNaK2hp?=
 =?utf-8?B?djBXUWpPanJKSVJkdHI2NFJrTUNkN21wV00rV1dVNFUxRTlNaERNRnViQTVy?=
 =?utf-8?B?aGFtRW00YStDbkVISUNQUm9LYXArL2NxQVpEdmhmQmwza04yWjdqdjBGUkl3?=
 =?utf-8?B?YVcwR21RK3ZTZytKSmJMdXpDdmxmbCtNZFVac3hrcHM4ZEhrbklQc281V04y?=
 =?utf-8?B?R2Nkc1daT2I2M3UvM2kwWHU3YW9DamE5dk9DYno3aUt5T1pLYnJtOXJYNEFH?=
 =?utf-8?B?ZGlpOW5LakdodW5oQ25QWEhtV1pTbnNEc3pkUVhldEt0TkN4MVAvOERJSW51?=
 =?utf-8?B?N1NtT1BncW1wTTRkWEhwSHNGUUtDVDZ3NzkvNmc5djlXMU9Ock8yRkNKcEVU?=
 =?utf-8?B?U0xFM2pSM2pSTzRHTmV1a3FRTGN0SnFMaDIwYkxWQXJQYkpyb2hwdElnMUdP?=
 =?utf-8?B?aEJqdUx0Rnl0RW9JaDR4UDVXb29zNXNMaTQyNWFDYUNlN3hLSUYwLzByOUpB?=
 =?utf-8?B?ZkpoeHNMZ0ZMN25qQUQwM0g0bGgxNXh5WXFrYWZUUWlZd1gwOGlzaWh2eDd6?=
 =?utf-8?B?RVNmdC9INTV4N1NleHZFay83NDcrVDROdHdOWm96RjFwckhMQjBQOFRBL01P?=
 =?utf-8?B?cFpYZ2FCMmlpU2liMnMybzRtSGQ1U2tNU1MxSXpaKytYYkVaLzNUQ0NuMVJY?=
 =?utf-8?B?c0tlUkE0Q2xvSDY5aWNIYUhnYWwxZDljM0lydC9pbmhYdnJKSGtQZVBJbjht?=
 =?utf-8?B?TzFhSFVMdy9URWt5QkFlU25GM1Z4eUdnU2U1YmUvb0hSNEo2NnlPKy9JWDZn?=
 =?utf-8?B?QXNqd3FRZTZOTHF3VDllUG9LbnlxclVwaDczR0pZcXVuRXYxdGdoSCtuM1B6?=
 =?utf-8?B?Zmd5YVM4U1JpNGRFeGtSOTduaitRWi94UkFxaElPamRQa1piUS9ydjR6anVS?=
 =?utf-8?B?SEN5YU9iL0daT2ttaFVrc0RaL0FhSm9DY3ZBWWcrZjQ3SnJiWnJCb2VqZzFD?=
 =?utf-8?B?WVQ3MW1rUjV4bjFNN3RnWHJGZ3pjVzdwZDlFczRiVkcxTGRMYUNRZFZHRXFI?=
 =?utf-8?B?b3J4dFV0dmVwODJhalZnMk9DRTdvbWNsREhUcDJRWk1LeDFGSGFSY0xLaFEz?=
 =?utf-8?B?bTFmY0pQZW4xRnhhTTBDbVpUOHRqTUlGR1l0RkJmSDNIZWlwUW1IM21kdnI1?=
 =?utf-8?B?VkluVk9EeCtoaXlCYi9JcXV3UldIcmU1ekJiZDNoNFVkSVNUWnpyVEpZSTMy?=
 =?utf-8?B?bTZjUkJHZFpxWW9icy91TEwxSGx4M2dHK3AvNmhYdVZITWNxeWZubUxRd2FD?=
 =?utf-8?B?TWtFZjRCQmxEWWRRbWF5OThGQVVtenRpVXRLQVRnSWl4MzZKM0liMXc1aUIr?=
 =?utf-8?Q?OAUK1F2+Qy0=3D?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(36860700013)(376014)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 16:52:20.2235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a69b3e5b-cdbc-418a-37f0-08dd72cfe652
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR19MB8579
X-Proofpoint-GUID: o5hmiYidzM6eyxZDC3rY2QIzoFvEGP2P
X-Proofpoint-ORIG-GUID: o5hmiYidzM6eyxZDC3rY2QIzoFvEGP2P
X-Authority-Analysis: v=2.4 cv=Qdpmvtbv c=1 sm=1 tr=0 ts=67eebcd0 cx=c_pps a=bqH6H/OQt14Rv/FmpY1ebg==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=9R54UkLUAAAA:8 a=VwQbUJbxAAAA:8 a=tobVxQRiopyZW3AchqQA:9 a=QEXdDO2ut3YA:10 a=YTcpBFlVQWkNscrzJ_Dz:22 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

On 2/4/25 18:36, Jakub Kicinski wrote:
> Hi!
> 
> The Cirrus tests keep failing for me when run on x86
> 
>   ./tools/testing/kunit/kunit.py run --alltests --json --arch=x86_64
> 
> https://netdev-3.bots.linux.dev/kunit/results/60103/stdout
> 
> It seems like new cases continue to appear and we have to keep adding
> them to the local ignored list. Is it possible to get these fixed or
> can we exclude the cirrus tests from KUNIT_ALL_TESTS?

Please report the errors so we can investigate. "tests keep failing"
isn't telling me anything I need to know to be able to investigate what
the problem is. They all pass for me on x86_64. I ran them a few days
ago when I submitted a fix for a bug that the test had found.

Have you got the latest bugfixes?

https://lore.kernel.org/all/20250211-cs_dsp-kunit-strings-v1-1- 
d9bc2035d154@linutronix.de/

https://lore.kernel.org/all/174291786934.56229.8841259212687977896.b4-ty@kernel.org/

If you haven't got the bugfixes, then it's expected that the test fails,
because it's telling you there is a bug.

If you just add failures to a ignore list instead of reporting them,
you might just be helping to ensure real bugs in production code
don't get fixed.

