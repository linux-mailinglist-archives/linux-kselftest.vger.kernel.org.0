Return-Path: <linux-kselftest+bounces-10934-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FFE8D4FA0
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 18:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 525D2B26B5A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 16:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2220B3E;
	Thu, 30 May 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uSJaxOIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8528208A9;
	Thu, 30 May 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717085328; cv=fail; b=VlV8bkdOPRit0yr0ws0NwFIAkQeIdFdC+I/OZFQKMo9NlwJRIkWm9Cj0JRB3OvxBnijr/qBeJUtjY7uMl8YXeUTcyQmSBJATq4radi/SFu3WZNc+BZau2/9c41eXN0vhxdiwRia3J0yuZozUxAi1s8Xx2zrGN7I9DXaz/gIUv1A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717085328; c=relaxed/simple;
	bh=Xm8vLJJta54g85waPhQv2vwPWywbf3nAeYTMTn9mqlM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EoOv/SwbQ8GtsZ+jufCY01Z4ntv8z/FjB+9sNodNPw25B0vVC82mgr/X68OAjz+ZLPZhDDfHTzuoUyG+V45YTWp059qXIeVpAVfpiu8IwD+ct0GQ+vKWPzXxi4K/3GHw5LZZQg3sHP7i6nm5AQLSkkCpw2Lcxd/Xoye+yInce3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uSJaxOIz; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdhQkWjtVt091gx2KwtGPWQW+0rwtWmVgIG4G5Bm9w2p0FK+s6OIY0mRtWkXt2ryNorr8yhhNWjG4WIgYmRHtie9mOmz/MCwBIwwTg/cCU7k4fT9h33nss9/acE/pJYysMROdXCYX5EiVhSK3YG3OYIMwUlezDoxsV5MRFEzJqEnjozc0uI0b+3lGvn5wa1yXxUUm2wJeQfaKI5anIztn46f86rTiCQtgPz53yczvGDvi0Y4VYM+VnfOV50JthzKNmFVyjOrIn548MRMa/Y/BF8vveml2+gT6bR6u03n0Z94mWp9hgEybSuUebV6UfIGYeeA5Y0/Wy4dbTIwuatRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPRZF9czqzM6yv9Pd7tGpbWGhiungS94x7GsGOZoZoo=;
 b=Glta6ytMzJWDeocMJ4JYvJqZeIWkTWcr/tLvjkpa0VWQPTiqwISL8Gd/wOOgONseoeHp3+mKV6xAjiFguqgZWcuWcLmkP+yIqPJMT4p/RLXujMwkXWpIPeWANnR86aErOecmZe5Yen8xmnpQODVWEx9Eqb6nZYWy0XBlxBb4Nf+ebSTVKaSXMwTYnuOr2FRaV5jYQfpXmeDtLEA7wJ5E4YyDY3Lop2d3oOKqeeC4Fld8TSqg81FbWGSv63gVwxYeZIL2Gzi6jrabm4rU9MTWBJpsjSzeFIL4aYZf9Pv4Z+aN3gFqMRGCCTAx6Yybfkcmkp2dHAorxTrOtvXROj5oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vPRZF9czqzM6yv9Pd7tGpbWGhiungS94x7GsGOZoZoo=;
 b=uSJaxOIzImy88zZZl5cQ3UCL2a88K/LmEM83Kld/BHfoEBV1SMyxLYhzjaoyj/TvJwewb+7w8DXnEWBzOr/BIFvv77DQAwYhWsHkRCdL1nSch6LhQj/hqJ1NVc/mCOFNvO/f+RbemgEbNNjKvRWXZqZoZz9N89D81Kzsl1CUcCw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Thu, 30 May
 2024 16:08:44 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7633.021; Thu, 30 May 2024
 16:08:44 +0000
Message-ID: <76bd2937-4f47-4203-97c8-517c337014a4@amd.com>
Date: Thu, 30 May 2024 11:08:40 -0500
User-Agent: Mozilla Thunderbird
From: "Moger, Babu" <babu.moger@amd.com>
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
Reply-To: babu.moger@amd.com
To: Reinette Chatre <reinette.chatre@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: fenghua.yu@intel.com, shuah@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org,
 =?UTF-8?Q?Maciej_Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
 peternewman@google.com, eranian@google.com
References: <cover.1708637563.git.babu.moger@amd.com>
 <cover.1714073751.git.babu.moger@amd.com>
 <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
 <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
 <b5b081a1-9e80-4173-8449-36d5c93185a6@intel.com>
Content-Language: en-US
In-Reply-To: <b5b081a1-9e80-4173-8449-36d5c93185a6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN1PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:408:e2::32) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4220a2-34c9-47f8-8c9a-08dc80c2c7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azNJaFcwcE83bFJvcXE0blE0NnJDbmhOUGhjNzV5a1RpZWo1NEphYWFaUWRC?=
 =?utf-8?B?azBGYjJ2dzAwQ3ZZekQxalBkaVBvbzd4dU51clB6b1RQM0NuRVZWVjFUMURF?=
 =?utf-8?B?ZjZKVmd0MUFiZkV0WG1IZEdkbmdpeHVpRXBKY0ZVQTRKQmk4K2g3bXk3TnZw?=
 =?utf-8?B?UzFCSTZ4SDhZT0ZKTjFqRnBRc0pFUkk0NE1idk5aZld4a3pUR1g4djBZMEpj?=
 =?utf-8?B?Tm5OUFVZMXVSV2RmUUJsaWlmbXIwYUlRVDVYTHhuZktDYzR0eDBzY3NKTlV4?=
 =?utf-8?B?UHJGUEpmalRRa2kzMHRHUzNuNXllYlV1RE01SmptS0ttbXo3MGtrUXpUT3FR?=
 =?utf-8?B?M2RaSFNaZ1FKOUZzcExHOHVPOHMvQkVpZkMvc3A2Y0N6YUErYTZRalQ2QlRj?=
 =?utf-8?B?M1ladzV4VkhJWVBjQjh0NmxoTkJneTduejhjMG9KZkRQZW8rMmZUQXhvT2Zq?=
 =?utf-8?B?NDNYSXE2b3ArSkxYMzFPRjlKMndLcTM2Nk8rVDF5TzNMMzAzdSthWDVaRVBC?=
 =?utf-8?B?WEIwTEZyOGxZWHlWNTdNL2xKakF0OVpuSXN2VjA2OVkwZ2ZSeEcyVmM0UGs5?=
 =?utf-8?B?QnFKc1psZDg3cVJUM2l1d0ZGZVNObVVBTGZrVE12c0Q5S1ZTSFg0V1o5cWlU?=
 =?utf-8?B?SGtieGtRdkxuaEdsaUhadmJHRDVuRXdRaEY4MDlFaEIxRVN0c3lNTGVmUVNy?=
 =?utf-8?B?akUvOTdBR2s2dHZ4TmdzVHcyUFhnTlpZakdTL1F2UlBTNjY1cXM4aVBIRERR?=
 =?utf-8?B?ZVdMVWtJNkVzMkZSQUVXZmc4THFwb2w1L3BKaWRDMTdOMXAxUDgvbFpsRUZJ?=
 =?utf-8?B?NGhNcUxmMnJOY21obkxxV0RBd0ZIVXZsUWsrcGVhQ1RoUlp1bXB3cXRmOEpI?=
 =?utf-8?B?QzVPNmhUbktycHRRZWRWUjFvS3lZZWhaWlZMWmpSTU5YdzMwYU5UVzhVeDZT?=
 =?utf-8?B?T3lMSy91TlRBempMTFRDLzBIM3psbW1kd09Fbm9kWkJlWUtUK01pN3kyOE1N?=
 =?utf-8?B?ZjhBeWJtQTkrOE5XdXU2bCtRdFE0ZWNCbmFkVm1vV3VTRlhoUUpqR0JIeWxM?=
 =?utf-8?B?VjdqYXliZTlwZ2ZGTi92aTBJcUlFOVAwMUZuR1lOOUo0WDU0ZGRwK3JwQWsy?=
 =?utf-8?B?MzQvVHcwcFcyY3VSV2I2SHRKVDU3ZE92cnBrTlhoQSs3RjhRKytZcmpnK1dw?=
 =?utf-8?B?UFVKcUJxRlNKL0NWTFFsbnFCOS8wVkRHdVErbklRR1pCRWxrTlRTY2lyb0U4?=
 =?utf-8?B?QzFac3BMdjRMalkrZ05zczh2cjBUbmRodldCUDZYSks4UWM2Z0E2dzd1bXJl?=
 =?utf-8?B?cWF5c3ZBSFVRVkZYM25NbTNHV2dSbklwQTBCSkdtQzRXaFpaRzAvMlU5dnBX?=
 =?utf-8?B?Q1RzcVo2cG8vNHpkUXV4WUhtN1UvNHZzV2QvRTRHaVNCWVBLSmVsRCtYenEy?=
 =?utf-8?B?UDk1OEJyZnBSNmhkb3ZiRDJoR1Qza2phVms1YnI1SGFJUnhtb0Y4aG9yOHd0?=
 =?utf-8?B?WHIxSThKY29zeVNBVkM1TVpseXZla0RkZ2ZMRVllQUlOWFZ5U005VUQ4RE10?=
 =?utf-8?B?dHlPR2Y2V3VIMTNWZEo3NGZFQmlLZVVmY1JBZTBUVmNUYzY0OEhQMkpGdEV0?=
 =?utf-8?B?TCsvdG1kNG5Ga2lSNk9YeGt4WndBTlE0N1VMK0dhVDV4YldEOVpqajJXMTlO?=
 =?utf-8?B?TitjOW9xaGg1eEF6UU1sZ1hzS01sNEdLWnNEL3ZBTSswNm5IQklFdG1nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmFOdUw0akFab1hoLzNIYTZ1d1VtajdvSTRER3lnRGx1U0h4RzlPTkVPNXN1?=
 =?utf-8?B?eTBNU3JhSTVYQjRnQ1VmQmtvbmZMNHZEaE9yWlFHTS8zeE1aME5kdXhuU0Yx?=
 =?utf-8?B?OTRMYTBBa2o2TW9DSEtudSsrenhwNUVNTFF1TFBGcllrZ0dINTloUG1CU0Vm?=
 =?utf-8?B?YXNUQWtFWEVHbm5XMHFVVTJ5MytWRjloVkN3RUJ1T2ZMYzNPOWxWZVI3aU1q?=
 =?utf-8?B?WmszdGcxMEFqb3lwTnJiNzdlNEUzM0drd1BSak1Lb1h5Mzd0UkdCYlg3M0NK?=
 =?utf-8?B?ZHZZN0wydnhFSjlYK0kxQktkNHY5WGZxbWt5ck8zMW1PZThjbiszNk50NXdJ?=
 =?utf-8?B?VzFCcHgyOFdwNHhBZStVVWpkUGdaOFI5T28vbFkyWVhiNDJpTnRkaVVSbXFR?=
 =?utf-8?B?Y0tNV0s1b2hwZmM5eDFQbFBvdXBGb1NGM1VoRFQ5OC92cGF1dTU5c2tBVytj?=
 =?utf-8?B?U0FrMENnQWZlczVyU2U2SGY4YXdEcGE2YVU3ekJOd3RvbzJ3ZzRyRnZhWTJy?=
 =?utf-8?B?SUFZZEUzSlBsWk9wdS83UWRINVRlN1hHRW9rcjFLa3pPVUppNmVDQTZ2RWF3?=
 =?utf-8?B?bnFaRXFKclFLSGNsZWRSZFlaQWoyUzhQRlIyTDlpOWdJRTVFSzVzSUhURFFY?=
 =?utf-8?B?aHhLNUhDUUV6NDJnQ3hKYWVlZ3dwaEJ1ZitBVkZVRkdwQmlCWmZxelF4d25i?=
 =?utf-8?B?bjR0RUFDY2I1UE5pVk5xY3h4aTRRRUFuR0ljd0pGQUtqelhUY1V3ZkpSMmlH?=
 =?utf-8?B?TlplMzMxNGtQeE5iaGtscStvU1FyTDIvSmJYODBndlRvM1dURmJ1REMwalZn?=
 =?utf-8?B?TWdQUkJySnJaOUloWDdCbExNSm5tZ1hNL09KWFhKZ1d2akc3UXErZUlyWlE1?=
 =?utf-8?B?bFdjZElVQ2JyNzRLc3JxVTV4aThsOUlaNTlheHBXZksxWGJ5REdFaGJYSWhR?=
 =?utf-8?B?ZmJlbEU4TFlJWVRacU1CbmFOUUl3RUhHdGpteDhxcDdvaWhZbFMvZkJrZWJi?=
 =?utf-8?B?UFdtdnNORG5MZjZ1U3N0Y2N6bTNObGRkMkx5cW0yQ25zakFvalVVMDNDK3Rt?=
 =?utf-8?B?cm03R2RxaEZRSmh3Q1ppQmdBazFmazFwenZ6dzRWU3RUUU8ybHRBaFBYYXhh?=
 =?utf-8?B?NnRueEZocjFNTVZXZUVvOFM3bVpyQjUxM2x0R2NoZWJzMkQzYXlvQk1ldCsx?=
 =?utf-8?B?UVBFcVJpTldxUHNKa3FoSFZkTGF5eUtDbkZQMHorN0kzaUQzUjAyamVkY2Zk?=
 =?utf-8?B?VFhJdWZ0VzE2a3hXRDdIbDNyb1BsakN6TWdkS2c1MmpMQjNYSnpYSTdFdDVh?=
 =?utf-8?B?M1FGZXRFMDFFQmJRTlhaNFpKbmJlM0p5cWtvRFZpcGFxcVFJZ0h2VWJjb1Rz?=
 =?utf-8?B?dzdXUUd4YU5xTldMYXM0dFB5ajFuSVRwTDE2NjhsbUh6R0wxMXk3QVRxR0N1?=
 =?utf-8?B?YWxhTjhEL2tEZFhtUDhydERXL1U5aGhXaFA2SFd3NCtIbTJQR0t6amUrQ1RB?=
 =?utf-8?B?c2NtQnNxSE5TUWE2bHYyL21HbEN1LzQ4UlA0OFVud0dDd1JTOWpVLzZFajI3?=
 =?utf-8?B?NC9vQUU0ejJ6QXllMjNzVEs4U05mQXBjd2Ura3A4d2l0Um5LUGZBWUJDZ0ZO?=
 =?utf-8?B?TzNKaGZ0UWFaY2pMbXl0WkY1VjR4aHErbCs1MkpPdHFDQm5UVmRzcWJ5cjFH?=
 =?utf-8?B?M0pBR0YzYVQ5aG8vT1BDcCsrRzM4WVVaMjE1NXUwYThleFJkZWUrT3pBeEo1?=
 =?utf-8?B?ZXBOMHRmN1RUODVHOTBFdTFqenhHNmxZNkh5UFRmM1A3Q2Y2UWF6VUpBMG44?=
 =?utf-8?B?VTZEWk5pZWwzMi9CQVd0TUdHZGI4MHBGYy85T2loaldVZ2pRb1dWcVFiMGpD?=
 =?utf-8?B?S1FmVmFzRVZudDhWSzZTTVFON2hFaDRQcUxWNE5YZDhxNlZENW1wVSsrZG0y?=
 =?utf-8?B?L0NOdUd4bmxPZnhVdVRmN3pGYStkQnFWQmcybUh1ZmJtODMyRUNPUUtDd1ZD?=
 =?utf-8?B?NVdqdzZ4Zk10ejh2UWRjN2psUGR5SDRYbndqWEpIR0Z1SmlhWEpmKzZFWmJ6?=
 =?utf-8?B?U0VPR1Q1aGwxSXZScWtWeUE1dUkvWG90cStSbkFLRHo4d1VaOVZMYk1XSjBy?=
 =?utf-8?Q?oBeQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4220a2-34c9-47f8-8c9a-08dc80c2c7ac
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 16:08:44.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMSEqy2jPt+o+m8ZRHL0o6/ciRYIGRpRMQ9dXYnrwddMDfU51wBgYlIEUC2bbRvv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

Hi Reinette,

On 5/9/24 16:11, Reinette Chatre wrote:
> 
> 
> On 4/26/2024 12:06 AM, Ilpo Järvinen wrote:
>> On Thu, 25 Apr 2024, Babu Moger wrote:
>>
>>> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
>>> available on the system. Tests will be skipped otherwise.
>>>
>>> Update noncont_cat_run_test to check for vendor. AMD supports
>>> non contiguous CBM masks but does not report it via CPUID.
>>>
>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>> ---
>>>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>>>  tools/testing/selftests/resctrl/mba_test.c | 1 -
>>>  tools/testing/selftests/resctrl/mbm_test.c | 1 -
>>>  3 files changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 4cb991be8e31..b682eaf65bfd 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -314,7 +314,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>>>  	else
>>>  		return -EINVAL;
>>>  
>>> -	if (sparse_masks != ((ecx >> 3) & 1)) {
>>> +	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {
>>
>> This looks independent change to me which should be put into own patch.
>>
> 
> Own patch that is separate from this series. This should go in
> as a fix with
> Fixes: ae638551ab64 ("selftests/resctrl: Add non-contiguous CBMs CAT test")
> 

Sure. Will do.

-- 
Thanks
Babu Moger

