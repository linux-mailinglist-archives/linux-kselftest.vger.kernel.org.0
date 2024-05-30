Return-Path: <linux-kselftest+bounces-10965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 855AE8D547A
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 23:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A561C20E6C
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C130158871;
	Thu, 30 May 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d/DI52eO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2A145B3C;
	Thu, 30 May 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717103750; cv=fail; b=Ohk/8nPrbIc4CvW4ZEMoe2Dj2ODXh0uRruONBPuv4TL7lfOYh1MOq64HmP/R6DEtKlJQOb5ItvQ4TvHWLn2O+wNDuYcWrxF+/n0P8j5uks1GHZLElDb7mKQ+A8hxH/KF83v1yMhN3F878VjZO4/FZBvKrbPbxPRejkFjBVKqGKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717103750; c=relaxed/simple;
	bh=M7rgBXFMOk9qYEfIxFYreDET75QQR97+ZhlQQ/cn+X4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uaTS/CNy15Olo+fWbEFTBtmp+SYr6kq4HaXvBUlDo1l36O0U+fsnFEybmBOvLdc7sBjeYC1uT7Us9fnMR6N56CdefLYcN/Jw2K4xiMHiGoyfhW7FNmxO87S+FHDAt0vWV+0N2Vyp1YBKXjQJzmqqFh5405y7RtC4gyJsVdW27Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d/DI52eO; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=An/FumOW71a9kfCNye3xVcIMWzRUIhvyEATzujaOmp7X1ul641CZLC83RQp530f9R9Wn1QG+Du2785HY2ys4UVc+lOCTNxEv6If2qi83F2YzIW92/1AnzeXiVTiF5gmVquHNgPcf+YFzR1s1Hofq1s8tEgz9WL6W7x/Gd4nyjG4yFPfbjFMNllRx9L/4l93UqHACp624HQ3IMFAHJe+wFo19nLW8wbLPiLT817Y7R9lnEG6gGH6Co3sSYh35T7FD8840HbbKvs73m32HbvggUbStRVDkD5pHgorKgjfau1LqQnYprMHQsBmiXiGymq39jmgMxKYjKgG3gQ3wpVmVgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q+5UvBVB1eD9bhmerAtHJ/+4AtKC462leU9LRas/f4A=;
 b=MstGjyAMH7SIe4B/1fMFTJmAC6QbuOVzV5WV5SokfLZKEwrqrAu+ZMx3qtSYCUexqtZBrA6pmpJyvHSU47oKqOs4FEyDe5XM8bKDWjALPdIN8yBFjM0mCwl86PPH5Qj4YY+zMMDc9uHxWtSGKdJ5StGBVgqsgMZF8LvshoyQuTE2S2Y2z8zkPjvwvKKWM9CfurpCdguWLN0GFuJP/DsjGgIIMu0Wj54h4ac2bhmTmUzM/tmW1QFM62b+fQ6rx0fRe8Gds96wMXmoOSlSw0P9QxDeYs7JiRD/LBgN6GZQz61ItVoewtD/zLOAe0FjzriK9sy4thrI9G0J2AmOSXybDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q+5UvBVB1eD9bhmerAtHJ/+4AtKC462leU9LRas/f4A=;
 b=d/DI52eOUn63v874pcqlhOaA/gQHHbjuL5jaG4QgUoeDmoEfRwbegRMPDaT9qYv6b1mOhOxr3ZJE2389WVUhj+4MD0x0k7Hfx4RxtF0Y6AGSSlyOQhnt3pYcvqGYj9JXhHGdR8/MYof/QPJyuyxtxediL1BSSUCSh+Hv/AxrslpWl5RzSJvztCry/cR+n4MLeR3f90KVvmbAhEVmC0NPmOEpMzSVOaIRKFd6Xdy+sz19si+U5yHGp5m4gnBIn8d42WwnZpqsQPAO45FriIT5uIVZ3elkP9D/UXEpP3z4TfcXIjAVIco0PvjDC8z3R0kKKsnJWSkrsjs5+RGxxR0XgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by PH0PR12MB7906.namprd12.prod.outlook.com (2603:10b6:510:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 21:15:45 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 21:15:43 +0000
Message-ID: <b65059db-a8b8-4801-a4db-6a2edfd18d12@nvidia.com>
Date: Thu, 30 May 2024 14:15:21 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] selftests/futex: don't pass a const char* to
 asprintf(3)
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-3-jhubbard@nvidia.com>
 <94fe2649-8def-4f2a-ba5f-19ae8a4226bf@linuxfoundation.org>
 <f0a1ca78-f94e-4f02-a5e0-ef9d610fac07@nvidia.com>
 <b245cd0a-8a87-4169-b0de-e4f6ce6984c6@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <b245cd0a-8a87-4169-b0de-e4f6ce6984c6@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|PH0PR12MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: be3959d6-2cf6-430f-1db3-08dc80edaaa1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnhqeGd5YW5SWUlyWmFRUTBocUt4MFFaQWZCTTdKTS9PNlRjNyt6VGo5Mi9R?=
 =?utf-8?B?bXV4N08xaVV1TThWeDZ2TXVXOVFKblhJcmNRSGdZUDVEVFdZL1BweWNzL2xF?=
 =?utf-8?B?NVAzZ3RXU0NtMCtuZ2NmeWJmV1RTV2IydXZ6SmlGOVdrQnFmQzRIQ3kzNFI0?=
 =?utf-8?B?OGoydjVHV2NQWm5ZNFhqYU5FNFI1aVJrd0NtK1VIam9COUUxQjdUREhvNERo?=
 =?utf-8?B?eFY0NTJSd21PUGlyQk9OSnFaRE1kTnNnVld0TW5HWEdPZzRMdXdjdjYvb2lv?=
 =?utf-8?B?alZQS2xMOWw3a0xsUDZsdDVpYktONUNtSzl4VmhCNmR2aXJwaFR4cGh5SVRS?=
 =?utf-8?B?bkJwdG55N1FSZ1JiSVRFN1BWN2ZZWVh4K0pIUXpQRjJRdExCSUsyQ0hKSU0w?=
 =?utf-8?B?N2x2aS9DUDVXVDBYWFhUQ29BN21sQU4wVDdFa1ZzNjRwUDI3TnlOTW5ueW1p?=
 =?utf-8?B?VzJ6ODFBVjRwdlFoanY5MW8xRlpnSEpKQnd6SUpPUGVvVU5XajYzVUxUcDJt?=
 =?utf-8?B?Wm9iVlpkeEs4U0FpR3Q2SFJhMFh4TDBZRlZJQmphV0Q2clhISGdYNW5RZmo5?=
 =?utf-8?B?b3E4YVVITVFjTTlIdW11UW04MmdiTVVEQ0ZoWS9wck1PK21YdHdMWHVZUCs3?=
 =?utf-8?B?NUZqTmVCYnJRS0E0ZVBiSkwreitscGs2WkZoYXBYL2FyVVFsOGpaUmNyalZw?=
 =?utf-8?B?c0JrS2F4VzJJNkZOc2pIVmxNMmluellzUC9ML0JiNWJsVjdLdC9QaFMybTV3?=
 =?utf-8?B?S1NWTXEvU0RvN1dxL3FubWk5YTNqbk1zNG5Fb3F4Q25JR3JTbjlGOWpxd0pk?=
 =?utf-8?B?VnU5Ykt0Z3RyYmNnRHBZb1BEYzJueHdCdCs3Mm83S1djcmJEVm81TzFFcHY4?=
 =?utf-8?B?MThWd3l0YysvcWhzeHByLzY1OWN6aHNzZDVQZXRQeitqY1A0TEdzTUV4aXN4?=
 =?utf-8?B?SE1IUlUzRGMwUGJYdmYrVWM5ZGVzc00vU294MHFPYWFFdG55cnpNUmtnZnY0?=
 =?utf-8?B?TFl2aW40N29zMlV0T0FmNTBHUE5DTC85WHplL3p5VnkxSGVhQnNKQkJINVp3?=
 =?utf-8?B?d1RGSndFRytCbFBqMm9wYkl1TmZSK1UvRUVyRGg0dDRzS1hkZDRNeFVuY2s5?=
 =?utf-8?B?WkVhZnBoLzFpMFB6WFNZZjVVd3JHeVMvN0FYMFltSUtxbFhRVTBtUklTWDB4?=
 =?utf-8?B?dzFhbWVGQXBGb3Y5anNlT25mY3VVaWU4Z1BYMlFBSFVZSXkvY3ZHRGVsMUJP?=
 =?utf-8?B?ZnViejFzeHdCQmpTc0lmSzl6QmlxL0p2MHdjeEFXZHlqVC9xUENJbkJHSzhI?=
 =?utf-8?B?WWd6cUpQM1AreGw2ekxmRm41eGlDdkFGbWhiS1poY0EvT21lS3phL2E2VnUr?=
 =?utf-8?B?SklBYmhrVVBpaisyZmhEU2VYQU9CNS9jOW9Zc1pKLzlSc0NjaHhId2VLOU15?=
 =?utf-8?B?RjRPUjZMdStOWTFodVZKeHVmVHZraEh3aXVlQytvQUJLZ0VBTnovdGVkNjJN?=
 =?utf-8?B?NWM0OXZnNnlvdTNPSXpUV2tGZy9GNGZWb29SR0hZMDVhN2M5bGluUU9BQmpF?=
 =?utf-8?B?NlhyMXFBNGJ6SEJMajNVb0FvMlh4OXc0d3ZuY1hBeEtKS29Qd2xPTzN3WHF1?=
 =?utf-8?B?UlBqWk9YbXVQNmVBMEVOYXlDWGhFR3RvbVlMUUJISEVmdmQ4S3Budy9hMlR1?=
 =?utf-8?B?ODFWbElvNlM0NGJGY0FVdXQ3UERleTk1Um1VTzRST2k1aEJIbGt4OVlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVhPSFFiVUFsTm9jSHprVDZZd2V2OU5pc2xaNW4ybW1sMVVtR2RhaGVZTVI0?=
 =?utf-8?B?VXZWUWpMbVJxQUtYbkFXRmJsd2hEQUl6cjRvb1lQak05TGcvYW1ad1A4TlVk?=
 =?utf-8?B?QWpGRU5JMS9ScjdSSW40T3RRU3UyenIrTWJGTWNmU0RHQWU5anFwVHQ3RGJx?=
 =?utf-8?B?NFpuNDY5TXNuMXExYU1Bc3NzbkcvMnNLZ3B2eU91VWhJUzMydkJMY0lSdWdB?=
 =?utf-8?B?WkJiVkVwQk8yZEs0eUtrRU5YREp4T3hCRGlJcmtia2p3aktjYXJSVVFNK0lT?=
 =?utf-8?B?KzRGdG16L0oyQTNITDdxUmZTa3BjWU40SjY2bDVtRU5GNUxoS3hiYjZwdjFX?=
 =?utf-8?B?MzRKdXpoVHltTm0rSk5BUDhHRnRpNlk1anFYbVZxWDFoMGxTRmpWMnU5OHNS?=
 =?utf-8?B?REplUWViRm9yNGlYWm1RV2IzOFd2TVRlektWRy9QYmtGMmZDYVVZK3dlS3Y4?=
 =?utf-8?B?aWFHQzN5UzlMWW80dVRkclZLclhCdStUaFZnRTVWL3Q1dDl2cndHQ09pUElx?=
 =?utf-8?B?WmFqeW45TVNaelZ3Z2ZDZmpkYVNvV2paaEZqNnUwYkF6eFAwSHlDUGpwVWV3?=
 =?utf-8?B?dXZhTDRDRWpvL0RYaUZWN1NocTFiYkR5U3k2NUx4aVVaTVU3V2ZRV3Nuekkr?=
 =?utf-8?B?cmc4RUQ0dWEzZ0V6aGt0QkxDa0VRVVpMZjg4WndPQ25ISjlVS0xGVVhyZjhz?=
 =?utf-8?B?N2dqSndFdEpaeGhWbU1rQTlyeS9vZlhnMzJ5T1ZkME96NlRvbG8wOTFJVkZC?=
 =?utf-8?B?Wmo4UjVaMWVrRlQrZkErSGJXd0swYmlUanpCTTJ5bEFXbkRvZlc0VjM3V1hT?=
 =?utf-8?B?WjZUN2ZWR2ZSL09PMU1EemlpcnZSVjhtZ0gwQlVlSEJ6blJ3WWZqbXk1VCtM?=
 =?utf-8?B?RGlyU3BxdlBxbUlvZzZWenNHaS9IZkFEUndwTkxmNSswM2dsSWY0cmdhempy?=
 =?utf-8?B?eVlDblYrNDlnWGdPdUVFeENZczdZU1F5ZmNnbks2eXVaOEU2enhsM2ZpNlA1?=
 =?utf-8?B?d1pUbXNLSWpoeUxYUG5nWE5xQlJtNHhTa0ZIYnVMK090aGlVa0hyQ01jS3N1?=
 =?utf-8?B?c2l0aFovdkJwSE5ZUkRReW44Ynk1Q2Q3ZCs1Q1lTZzZrbHh6ditzNlB0M2ZW?=
 =?utf-8?B?M1Vibmd2dmVadUJUWTlKM3lUTG1xNm9abG9iQXBxcE1kRVBwaUdsZzM4U3Fh?=
 =?utf-8?B?RGRDUVhTN1cvL3N3TkJuRFFoMGYvaTZOemJET080VXA3T0d6eHBtZEpoWkZT?=
 =?utf-8?B?VkpoUXdKeGhJbHJBSFpWTkYrdG5LTGxYbXJZUjdhcXV6TjZ0cCtwa1BvL0dG?=
 =?utf-8?B?dlRZaE1uSmorT0hBQjl6RFZkamxSWXFYVEk3MlFYUHkwMzRNZ3Z5VDg5QXNN?=
 =?utf-8?B?MTgxK1l5U0draEJEbVZwRUdGSERvWGpDR0daT1d3ZmVNL21DT0NjcW1tai9E?=
 =?utf-8?B?Q0JEY0dkMUZLRDVDSE1wVGdtSDhkVDFzbmpBME1DWjI1MGJGbE16WUdmaWU2?=
 =?utf-8?B?UjlQdzNrM0ljN05lRzlxTjdFY1p6WUdTYW1LbXhnZzhjd09GY2I5K3NDNzNv?=
 =?utf-8?B?OThwczdTSXE4MUZYUU5HakNTbmxiNmlGb0dnM1dORzdXZ2o2S3NHTTQrQXB2?=
 =?utf-8?B?TEdjVWw1cEYvVEFsTTVxSllORXVodlJGbEsyU2FpZ3NCRmNtN2s0Y2VhTVQ3?=
 =?utf-8?B?cGN0Sy9HTHF1N2h0UlZVcTZ3YmR6S0l1eWlzemZ5SGorQlVTeitWSmtER282?=
 =?utf-8?B?NVRtM3NRVUlFR0tzOE96RzlWWUcrY0JEN1V4ZUF6TVJiemlzT05lbzJyRmNS?=
 =?utf-8?B?dHVkWVUwUW1LcTNoTHFoVUtodGhwTHo0N0RhVmdVZjA2OTlzWlZqUVhEMjVw?=
 =?utf-8?B?WUlXQkRONkcrMHZ5ZzRlTE93OTZoVFE1MW56OHd3UkUxTGxXVW5yOUJUVXdi?=
 =?utf-8?B?NDFmNy91VUNiLzViOG9FdWQvNWlaYmg1YkszelljYUxNNmpEdVF6NmN4L29I?=
 =?utf-8?B?UnZIcGJ0ZWZUdWFXOXBweDk4SEZsWDB0ZWowcHRoY1BQOVAvZWdzbXc2U1FN?=
 =?utf-8?B?RExiTjR1cDlWeU14b3N2M0FTa0JZNDVESUxXamR1Q3NvbS9IMm5DY0NadXEx?=
 =?utf-8?B?VG5LVC9YWmlvR25mb1diMjdRS05DdGFRV24wOU5ZbG9pL0tDZG01aUxpVWpH?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be3959d6-2cf6-430f-1db3-08dc80edaaa1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 21:15:43.9221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbpIOp9nNakf7MwOx7PMNxfp32yrr4Z2EMEKysPIDXXnw+csishfySY2GlyRnda27lBxjiMoZwwNooRiv6TNmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7906

On 5/30/24 2:13 PM, Shuah Khan wrote:
> On 5/30/24 13:16, John Hubbard wrote:
>> On 5/30/24 12:04 PM, Shuah Khan wrote:
>>> On 5/28/24 20:29, John Hubbard wrote:
>>>> When building with clang, via:
>>>>
>>>>      make LLVM=1 -C tools/testing/selftests
>>>>
>>>> ...clang issues a warning, because test_name is passed into 
>>>> asprintf(3),
>>>> which then changes it.
>>>
>>> Please include the warning in the commit log.
>>
>> Ah, OK, the warning is:
>>
>> futex_requeue_pi.c:403:17: warning: passing 'const char **' to parameter
>> of type 'char **' discards qualifiers in nested pointer types
>> [-Wincompatible-pointer-types-discards-qualifiers]
>>
>>
>> Please let me know if you'd prefer a v3, or if you'd rather fix it
>> up, whatever seems easiest for you.
>>
> 
> Yes please send me v3.
> 

OK, coming soon, hopefully a bit later today, in fact.

thanks,
-- 
John Hubbard
NVIDIA


