Return-Path: <linux-kselftest+bounces-11981-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E80790945D
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jun 2024 00:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B701F2206C
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jun 2024 22:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43631186E47;
	Fri, 14 Jun 2024 22:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwWgrCTM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E98137905;
	Fri, 14 Jun 2024 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718405785; cv=fail; b=Z5xnESa4auI1NMiR3K7reiTxc1OGZm/px4FJG+f8KivCK1DQlMPOCh9cPrudD/D+sAPLmcaMhC5yTZ6Z7a2/svTxTRZnVA9xKE1bs78Seg0IXlm0KW3lyFPFKdALJ/LWdPYQ7ND5WfHe2mRN6fRPqxkjbsmPIOStWU3V4q99rVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718405785; c=relaxed/simple;
	bh=f1bRlqNtv+zaOOf2KlFNpCKz50RfeoHz1Isxyl7iYVI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=WWA3ogDGQbb/7x4ST9quxwSK8xwnKKZukGeb3eFDKih/ix9gTPwCjzKej8OMWs3KVH3W0d4C6VVosAAT4W38IyX1jtB/f3COD/hPguFSczOogdnm8C04N1hT6jDa/JBarVpmvcPydopBy+uSe9TZ6zircb1Hn2W0KmwPpBmnNKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwWgrCTM; arc=fail smtp.client-ip=40.107.237.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dn+jV5I72gfwcW+eGeLaNk2l2TTbJ2NvPGS3NvWW9J+cFAg5prE1YMVlS/cv6KjSceNB/uZqdhsT2rIaJuh0MiUn3+aeV9hqYKyoSZinpjeZPROFZZZqmK4fj9Lj/y8MG4fn5zxbMEfLJmStM5Vytgqb0xfzeta7y5PqPIMQGyY+DJvFB+6bp7pr+bt6/ajrCJOnWz30efwHhs9d0JQ6QuP33uvikWY7GEnJIynW0YputDj5RPTJMu6hJDMWOuEBV8fb5JsRuRbBOyBu+tneYHmly4LMnCDiRALd3U4m/Cs4KbtIROOuX3GKB9fLinS7DrT9n5SyNgV06AuWBzho8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/mLViYzOuOo53p0Gv0D1VQ0Lvpip8wXc7g6Uue1WEdw=;
 b=h3CTbfTUmbQd5rXaT3WAe+WmLOH0yjxY/Fiihww3UbseVLg6SZTP8h1w5bLgXGHLPWXFh1XAUCLCRtb6ADJMqR4B+eIerEEweUt2cx+EE5ttDdH1t09rT/wU5Nas1FbffRrp5AJo4JNzO5ChScz2Ghnmn53vAWqoKkHRkK5BU/A1lwQPEXRkykm+aear1PtojvAXnDZAbbDOIONo79uH2Pw5pKetNStnIK9m56rEx5kDTlhT1bPOEpsmaBl20lFvCXEUNKeIIF0/r5+IFXJl9kATpx+AUuliBUPHpqaxmbsfsgvRAsItCvLMaFfN8SNy1bcjViugz6m1TA5rXQ3vJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/mLViYzOuOo53p0Gv0D1VQ0Lvpip8wXc7g6Uue1WEdw=;
 b=NwWgrCTM7FPNQoZpwOLnTeRaIbaV8DH71B7vSBIuuWepRNycpGFhfvFGz7X7wdpgNAdgUfG2PSRLmsmR5nmT+fWlMfSYMmYtvqO8t/V09UFeOC5SufM1J/XzM9xcBxftim5ad8x9h4P5RQe5ls0gd1ydDm+dpp06dRsoFPWXOUY9w8R1SU8idKBorwWGKguZEZ5bP9CrejPeTj2TjORfwpZcvP4EDVT3GpuH40wwzSesgZoq0NyeXvuCMGRCXRWWNARVcIcj9LTYzgcw8I82I33Rq0Eem3ozbos7yvInUplR+QLjO7c13LnEz0deCH+NyZyxgwzW/VohXNrU1YKt7w==
Received: from BN9PR03CA0959.namprd03.prod.outlook.com (2603:10b6:408:108::34)
 by PH8PR12MB6940.namprd12.prod.outlook.com (2603:10b6:510:1bf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 22:56:19 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:408:108:cafe::dc) by BN9PR03CA0959.outlook.office365.com
 (2603:10b6:408:108::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.26 via Frontend
 Transport; Fri, 14 Jun 2024 22:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:56:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 15:56:07 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 14 Jun
 2024 15:56:06 -0700
Message-ID: <8a6f384f-02b7-4a0b-90dd-e6843909e8a9@nvidia.com>
Date: Fri, 14 Jun 2024 15:56:01 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/vDSO: fix clang build errors and warnings
From: John Hubbard <jhubbard@nvidia.com>
To: Carlos Llamas <cmllamas@google.com>
CC: Shuah Khan <shuah@kernel.org>, Mark Brown <broonie@kernel.org>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, Colin Ian King
	<colin.i.king@gmail.com>, Valentin Obst <kernel@valentinobst.de>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	<llvm@lists.linux.dev>
References: <20240527211622.290635-1-jhubbard@nvidia.com>
 <ZmiXqOHYaLLX557z@google.com>
 <2461f002-fdd4-4bf5-b797-827069cafc4b@nvidia.com>
Content-Language: en-US
In-Reply-To: <2461f002-fdd4-4bf5-b797-827069cafc4b@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|PH8PR12MB6940:EE_
X-MS-Office365-Filtering-Correlation-Id: 05424379-3eab-4a55-3a4d-08dc8cc5345e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVpBOVRHZ2l1cUk0L2xqTGFNK09veUZaem9nOTlDcVV3d0pDTit5MHpIN3Ar?=
 =?utf-8?B?Ymg3ZFhlaFgvczBYaHR1aExhbjgyS2cyQ1U2WXBhNm1DSmxsbjJQM0JvUmtx?=
 =?utf-8?B?OXR6aEI0dXVRRWRCdGtzTEN2eExBaHgreW9iY09zdU5ta0xWU0NVQ2VWMFJl?=
 =?utf-8?B?QnNwOEtSOXhDZjVsMjljZmEyWUNCR0V6T1ZjNXY2cFFpSVNZZlNpM09DQ2JY?=
 =?utf-8?B?WnhKM0llV0pRcDhCQU12T0NVY1cycWw2YVh5QURwdUJPa0Nmd0RXbUtxaStN?=
 =?utf-8?B?UzJMeWFpT05tbHdadVJTakh6TllTc3BFelBBSERVS2hsMG5lU2oxSUNEWjRs?=
 =?utf-8?B?K1dGcFpvZm85d29kSjQyRUFRaCtMN1ZiYVVtN3RESVNnWXhBcURHTXlyQjAw?=
 =?utf-8?B?b0FiOGJYKzYySitoOHR2TTlQTkNCRmdlb0plYTVGTzUrTkJkTVJ1Vmlac0Jy?=
 =?utf-8?B?MWZiY3RUbnhOeTc1aVFmMkV5bTR2bjJvOGhxNkVTMDVpR1NkOTJhbXdPcGVK?=
 =?utf-8?B?ZGNqSGpjSG9ZcTUxSGs1MHZ3a25IWHBjbHBCdlFtc1JIZy9ZdEwrcm9IUVc3?=
 =?utf-8?B?MEJRNlM5VW1EWEFTTURzcFdwTGdmWUJEdEFqOEV5c2tZN003Vkk4dk52SVpx?=
 =?utf-8?B?bXQ1ODVITzZUR3BLYk5XUGNCSDJxUlE4QmM4VFZXU0Irc2lLMGVUdTRwaXhk?=
 =?utf-8?B?eDh4REJMQmFKaGZQOGFYb3VNK1Iyb3VLWFRkZm01em5MUHZ2Q1NTMDVOYWM2?=
 =?utf-8?B?OHVoNFppUHloVEViRVdhQkVsU0tURTB6NEZIQ0VkVFdndmdwNklIalpqY3hR?=
 =?utf-8?B?SCtYbzZscE1yaFFqNUpXT1J2U1lORnNiclAzcXNDbWlwQW91Z21RdnVNc09H?=
 =?utf-8?B?RVNqdXZHZDljeXB1dWdrYy8wa2IyRGt2YkNFV1gwVGhnQTg5R203S09NUjUy?=
 =?utf-8?B?RjZ4eWFEN3o0Rm5uYjRJbWdFZXpkNzREQ1NES29mbXVEd2ZFTS9zY0lHYnJG?=
 =?utf-8?B?eC9OZllBbHl4bWc5OCtkV0RBWUlCWHUra1VuVHhyUWRTZjFmY29IWVFHbmpD?=
 =?utf-8?B?dXM0TE14MThVdHNZLzlqbThRM0NCZm8xUjY2SGZTRnVwR2JDTlovbFdNbFZ3?=
 =?utf-8?B?RHo1dHNMRzNrbmlab3NXQTREVUZPZFdvYy83b21KU2dEQ2RvUThaNFA2OE9P?=
 =?utf-8?B?eE03enJlVDJObXlaVEo2ZEszTi82Q3kzNlJrUW81ZDhkZFpGTE5tc0M1ZWNO?=
 =?utf-8?B?V2wrOGJJZ0gyZlVvQ0hJTHEzVWQvRHkvdURIeW94ekdZK3pCRWVWaFRlYXhG?=
 =?utf-8?B?QjNWYnRmc1Z5Rytia1JyS2UxeWxISHBVWFRCYUh6cWxJZzZoMWp6aG1mbFBj?=
 =?utf-8?B?bFd2aU0rM2ZpRzVqRDJ1emdhUUlWMGM4bU16MlZkZ3A4QmQyQkhOakR0Rzl0?=
 =?utf-8?B?aTZRRFJTNVdFaUozd1BlL0FMWnFYMGxQcWZnTndUaDF1NE9MOU5zemZXcGdE?=
 =?utf-8?B?aWdHTWdwMW5kVE8vUVFBQ29TWnVtVURGekROMW5mUlFuVng3VlVMVmF2VkZY?=
 =?utf-8?B?QUpkdTFtanZWVXA4NDc5QUJpZlVtaHAzUXVZZWpFY0hUOHA0SW50MWg0dWh4?=
 =?utf-8?B?czh4cDBYQzI2amJaYTczNW1jcHNLUUlWNWNscm4xUk1WcUJuUFBPT05CUXpO?=
 =?utf-8?B?dU9SK21WK2ZqUWFicmgwTlpXQ0pGa2NEa1RzRVQvUWJxWEdPcE1KdkZRczJM?=
 =?utf-8?B?Tmk3bzFXUEZOZ0hwNWNXdGVlckgwb0g4U1BVcWdqWjJnV0tzcVM0VTQ4Mk9U?=
 =?utf-8?B?VzRWQ3RYMTZMZ3hOeDRMbXI1SUllcWhPay9VY2N1YUVQNnU3QXA3N3ZoODVQ?=
 =?utf-8?B?eGxXL2FGSW1IVXJLZmNISnZTUWJ5WVVWeVd4VEZrV3hXV2c9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:56:19.2773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05424379-3eab-4a55-3a4d-08dc8cc5345e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6940

On 6/14/24 3:51 PM, John Hubbard wrote:
> On 6/11/24 11:30 AM, Carlos Llamas wrote:
>> On Mon, May 27, 2024 at 02:16:22PM -0700, John Hubbard wrote:
...
>> Reviewed-by: Carlos Llamas <cmllamas@google.com>
> 
> Thanks for the review! I have no earthly idea what will happen next.
> I'd like to hear at least something from the maintainers about their
> intentions here.
> 

In fact, I have two more patches for vDSO (these are separate issues,
for the Makefile), and I just noticed that there are several accumulated
Reviewed-by and Tested-by tags on this patch here. So I think the way
forward is this:

I'll post a v3, with three patches for vDSO selftests, and the latest
tags. And let's see how that fares.

thanks,
-- 
John Hubbard
NVIDIA


