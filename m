Return-Path: <linux-kselftest+bounces-30599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29464A85D80
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 14:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B228719E7E13
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Apr 2025 12:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B42BD59C;
	Fri, 11 Apr 2025 12:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IhNm7VQN";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="ClE7JOhb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F88F29C34C;
	Fri, 11 Apr 2025 12:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375172; cv=fail; b=QJuMUC+Ms6rgXhS1B9tBQRsK9Mp8+KpexanaHK0E9kmYb4dfyKMovdei8hazCbaYSVpXjoN8PaKPzCE3o1wSddv6tHwaevpy8oFkKHRHIU/ccmWKD3mc2Q9Q0Hs7qAfI5IQCugbcpKaZF1zToFeyc8vnWEv7gazJN1K3PZEcwTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375172; c=relaxed/simple;
	bh=YBcR7QE2FM4Cyh2ixm1CO5GIRW+9QR58cksNNMYdiZM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ADnDAd7hMeGRYbvXAId8Wulsc7wakNeMU5XOBMmwC9FX6PGj4UTlkFwqxfLbhLs+GTyO6Hr0A3TDsAFjOl7wI5p7Y7MnWUe4vpRQGs+6QG0+ICM1RsZn043/QFRIIQu/Fy6LlgWPWV4+hT4cV8sD9sjNfDhae3BXeYn38hdG934=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IhNm7VQN; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=ClE7JOhb; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B40Dlv011308;
	Fri, 11 Apr 2025 07:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=nZZeqDUEZGWKAaIED8VVkyKzFA45do+r2YM/I0Hdu8E=; b=
	IhNm7VQNUVnAxZr88mC6bs/eiws08QwdB9vPBxe3HW3CpYkT9so3L/6nRYLNhql1
	eYzRks45cZ55l7+EsUgBqqwv3FGJECjGGn3fp5MMdfj01Z5IFxswl/v7h0+x3gLQ
	SROwSo9z5hwnICJ8sC+ktZeI2Y+C6iDQYwoaQfZAVVJn14GYEwgfYAwZq9stAJdK
	8Od+pqtxG3g5HkjGWoucZwjnkac7ARPcVWHM2ROvWwV3wvnyEkXReYWVr65ICSIy
	ZBJoEgww4hGN/KY4U3GAHm/6IoSuGExuh8XJ0tl4962MJ8Wtq5S3QNVq6qkYNwPs
	ZtHF9Gvqr+7UAP463jryzg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 45xa4bhsgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 07:39:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBrJGV3XJJ7hrtaBZsaZapmaRW3OCEV+X4QiUsiSJ1NQY2JT/hamT7ZkjsqzFDaif3JonSLd07egDDv5EHme5jltyuim2D8n+EYeufdTeMghDvP/WcTAH6rqawVDc4pGua4e/MLYJacok1XGH5QcpqzIthiPhoJwPsmQabXUgScRQn5gp353ziFrFRpQZTogZlYRCHMz57hvxc0849PmVTBTj2WgskFK15do+IhmpXAs9xvzw7oyXMpnQU+qvf87ON0+CbSv3kN1vR6X86YwsRjHxZkYn/enGwMkQynHjqN+Cvd8JvaTK3hAEpDrU47V86h44tsbGbqWjH7MwoDbUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZZeqDUEZGWKAaIED8VVkyKzFA45do+r2YM/I0Hdu8E=;
 b=WljHelNzyTeeEjQuCN+rSwknsVdQd/16/k/zsEKdWsQ+GUbb4zEIu+g3A+j/So7MOoxVLklxiuUellg+fv3DsKyKn4eJvwocan9E+er+7BMncCm3z2HZTn3fW0LnFpNTR9Twoh8PzkA9o7LpxYCm9XOQLT1FDT3SI3hsuJCtNcsXT/T1AStim9DMVHeHOGH0jHENqJTXt3X5lJVeLCoT+VEus0l9ue9ZFdVotbrNKNqNYPp3Gynbj1ZkkrT65lhNiwdXkdr+7+yv/zlkolJ4M1ocIk5AuEBpdIpDZMscWTUTbuyu9g2QY/IrhQKwZoy93mL65Q9/dsKo+LOyXk7v8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 84.19.233.75) smtp.rcpttodomain=cirrus.com smtp.mailfrom=cirrus.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=opensource.cirrus.com; dkim=none (message not signed); arc=none
 (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZZeqDUEZGWKAaIED8VVkyKzFA45do+r2YM/I0Hdu8E=;
 b=ClE7JOhbes3yxoE9RS5LhYVuTbX4nyqDPVaPwm96mDXI38TvVdn4up9dVGDPzVj/NgUSWLylkHlORA1xO3BAFGGOLcErLNviY2CKdtHQ1ScqxL0Pf0InwHPYtitZ5NbaDS/64JAZXRplk6gU+SjyC5Se7C+QsTV20DlwgONBzUY=
Received: from BYAPR05CA0068.namprd05.prod.outlook.com (2603:10b6:a03:74::45)
 by CH3PR19MB7236.namprd19.prod.outlook.com (2603:10b6:610:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 12:39:12 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::12) by BYAPR05CA0068.outlook.office365.com
 (2603:10b6:a03:74::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Fri,
 11 Apr 2025 12:39:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 84.19.233.75)
 smtp.mailfrom=cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: Fail (protection.outlook.com: domain of cirrus.com does not
 designate 84.19.233.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=84.19.233.75; helo=edirelay1.ad.cirrus.com;
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.13
 via Frontend Transport; Fri, 11 Apr 2025 12:39:11 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 79CFB406540;
	Fri, 11 Apr 2025 12:39:09 +0000 (UTC)
Received: from [198.90.208.23] (ediswws06.ad.cirrus.com [198.90.208.23])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 613C6820259;
	Fri, 11 Apr 2025 12:39:09 +0000 (UTC)
Message-ID: <c559ae66-745e-4403-9b6f-ebc8cf85d2aa@opensource.cirrus.com>
Date: Fri, 11 Apr 2025 13:39:09 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kunit: cs_dsp: Depend on FW_CS_DSP rather then enabling
 it
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: Nico Pache <npache@redhat.com>, broonie@kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc: simont@opensource.cirrus.com, ckeepax@opensource.cirrus.com,
        brendan.higgins@linux.dev, davidgow@google.com, rmoar@google.com,
        johannes.berg@intel.com, sj@kernel.org
References: <20250319230539.140869-1-npache@redhat.com>
 <9024776c-7028-4522-a773-8d53d233dabf@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <9024776c-7028-4522-a773-8d53d233dabf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|CH3PR19MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: a4b53b4b-695f-4278-3a60-08dd78f5dc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|7416014|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vy9mMWIwd2JrNVB3WmFsM09JVlVmbk1QTHRtc01YYlVHanZBL3ZucHE5UXM3?=
 =?utf-8?B?M2NkS2JXUjhXQlo3ejN0Ky9hMmJtTWtXNkNyL3JZMWFEalA3MGR1VUtMbFM2?=
 =?utf-8?B?Y2NRcElSZlpKa1dxOXl5WHcwc0h5S1dYOU96VFdUSCtNTW82akQ1cUMyM1VM?=
 =?utf-8?B?RE4zbmgrRVR0cWxFV2x6TE8yQVJWVUJXWEVjd3F3MGpUQ0FjQU9QeFN3SzhY?=
 =?utf-8?B?aExBNm9XSnRPdER4UTNtanB6R2ZDZWRpbDFiQkJydXYyNVU4MVhsaXl5VXpM?=
 =?utf-8?B?cW9ad3d5ajFFa0FraU16S3lQaVRnZE4xRm5OaFU0a2preWtEam9oenBoOVRG?=
 =?utf-8?B?SE1sZFg5SVlHaXVZcCtVdWVyMEd6eTAzaURkbmdXMXZqejNDbmhMWnZqcmZJ?=
 =?utf-8?B?Nm5YK3NadllOY3d3SFNHbll1WGFVZ0lOc0FxNHVTZXpvbitvN0VtbGFmd3VG?=
 =?utf-8?B?MXhhOGt6eDhRcnBIdVlxazFMT29VRGNIMUJia1B2bEdyTGFJeHFMVDdOclF0?=
 =?utf-8?B?bG4zQ001UGV6NVFnRXFVdDBzS00yTGw2cFB4V2xJVGRoQ0hyTThmbTNsZEpD?=
 =?utf-8?B?cGpyb3FESlR1bm5JeVJTeVMweURZL1QrbDlYYWhTMU9ydTFQS1VFcnRNM2RL?=
 =?utf-8?B?THR5UGl2bG4vS3gwZ08xOUlLVFc2TEd5NTQ1dDRoeW9UbHNUdnQrT3o1RnN2?=
 =?utf-8?B?RjFPV1Rxb3J4emZ3TjdaNXpQdGRDNFJpL2VQdDFnWkpLa21tUkI1K1UvTFAz?=
 =?utf-8?B?bHVDaGYvMkxKK3FsOFBCZktXMUNTRG41WEpwaXc1ZTQ3djlFRDE2YmllNTVz?=
 =?utf-8?B?M3dOaU4zYThiSmVTc2lHK3ZqcGlHdjBwc2c1aXVwd3dEQmZLY1Y2RXphVjU3?=
 =?utf-8?B?NjlsTDF2N1JsWkFDL3R2MVRQbFZNZWw3ZkxIcVlPbGVWTTVTM0J1YzA5T1Mw?=
 =?utf-8?B?NWxCYWV6ZjF1RU1DMzVvY29CNFZScThUakpXVEtEUEZOZmxVWGNEdjg2em5E?=
 =?utf-8?B?cFg4REM5SCt0WEg4ZEFUOXZnb1BxUW0xZm96Y1NrZlhjdGRremdYaEpVUUJT?=
 =?utf-8?B?eUExcVZSdFpTQnlzaWJhWTdwY0N2Q082R084bFU1bmcyaC9kSCtHMlpoVHpN?=
 =?utf-8?B?UXRGZDlwek1zYmdjTk9UVXpBNEFOVlVqVjNTMk82TkhxN0NtYjM0Rys5aVVV?=
 =?utf-8?B?YUFLVkcxSUtDZHpQWmgwOVlZTi9pOTZRUlVvTEx2MnhseW0rSGpuTWYzRWdH?=
 =?utf-8?B?QkZHTjA0Sk94V3B1UU92d25hNkx6ZnJUU1JWQVJqTWlKRDk4S1ZjU3lhbVJJ?=
 =?utf-8?B?SEoyUWRuNldHb0ZEeWxvZnZsV0J5T3Bwemd2eHdHZFpjY2RCWURURUtnSmpD?=
 =?utf-8?B?RFh4MzRNYkFQZFB5MStucktyN0l5T2huR0lYU21ONGo2VDBMeXRwM0xHU1gz?=
 =?utf-8?B?VmtIcFh2TEo2QkpLQ3hUdFIrWGZMQktqend5MHRGMEZPMTlTeklhdWNOUTgv?=
 =?utf-8?B?cVRYaG9xcGJ0Z2g1L3dQNXh2c0tQRVZDRW1xN1kyTE84V0tWckRRd2tXRk5m?=
 =?utf-8?B?bmM2dk40V3RqSXhvMUVYWU9VOEJ6UE9RK2FXajBtQ293cDFrQjZiTXJic3Ro?=
 =?utf-8?B?Y2htRmRiMDFlWmRGQ3lMS2VXcGU4L2p0a2hFeFZCNDU2S0lwWHNPNGpkTHVT?=
 =?utf-8?B?dkdpdXpVOWd5SXlBRnNDeS9pYnVXb1ZYSExlRlFSaWE3MHlJdUlnWXp6OTEy?=
 =?utf-8?B?eWlQdVZpdnRzc0lNdWxBVHp0ZVM1bGpQZXhoc2RxbFB4dFp0SXpaTGVSWTNh?=
 =?utf-8?B?VTdQeUZ2aTgvV2M0R3BZM3dOUWlXNGNOK2lOS0F4TEJNcmVIOHBXeDJuYk41?=
 =?utf-8?B?SWtsZVhRanM2cHFaUG51TVRkMnUzdm90d0syT0ZkK2Ntamk3SUVaMWFGUXdw?=
 =?utf-8?B?M1JpcEZaNDhMZFpSQXZvSHc4Vk9kaW90V2FBNVJpL3FTOGpmQnl0ZnRGMG1k?=
 =?utf-8?B?SHE0QUx6Z1FnPT0=?=
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(7416014)(36860700013)(13003099007);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2025 12:39:11.1042
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b53b4b-695f-4278-3a60-08dd78f5dc45
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR19MB7236
X-Proofpoint-ORIG-GUID: Mzo8Gy5zfZdM_QyeguJSoEF67y4o4nxU
X-Proofpoint-GUID: Mzo8Gy5zfZdM_QyeguJSoEF67y4o4nxU
X-Authority-Analysis: v=2.4 cv=B6W50PtM c=1 sm=1 tr=0 ts=67f90d76 cx=c_pps a=98TgpmV4a5moxWevO5qy4g==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10
 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=20KFwNOVAAAA:8 a=50kEoTg9bBTm9TY1MkMA:9 a=QEXdDO2ut3YA:10 a=BGLuxUZjE2igh1l4FkT-:22
X-Proofpoint-Spam-Reason: safe

On 08/04/2025 10:25 am, Richard Fitzgerald wrote:
> On 19/03/2025 11:05 pm, Nico Pache wrote:
>> FW_CS_DSP gets enabled if KUNIT is enabled. The test should rather
>> depend on if the feature is enabled. Fix this by moving FW_CS_DSP to the
>> depends on clause, and set CONFIG_FW_CS_DSP=y in the kunit tooling.
>>
>> Fixes: dd0b6b1f29b9 ("firmware: cs_dsp: Add KUnit testing of bin file 
>> download")
>> Signed-off-by: Nico Pache <npache@redhat.com>
> 
> This patch doesn't actually work and breaks kunit.py.
> 

I was working on a series to make the same fixes to another Cirrus
KUnit test. That series makes the necessary changes to all_tests.config
so I took the liberty of fixing your patch and including it in
my series.

https://lore.kernel.org/linux-kselftest/20250411123608.1676462-1-rf@opensource.cirrus.com/T/#t

