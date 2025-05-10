Return-Path: <linux-kselftest+bounces-32810-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C8D7AB20E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 03:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 912C41BA4795
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 May 2025 01:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468812676E3;
	Sat, 10 May 2025 01:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QolCKBTf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6092673BA;
	Sat, 10 May 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746842291; cv=fail; b=Hlj5REY8r7jYjO52P9TKKbTOVOYxbYAC5RAowERXHrgE0Hn8sQ5QRwkKzy3q990i9lMGwcsFXlsgQpfbPuvZRhLzAmp3y+6HYYZmJwxpy+cWmlWEGZ7CPS6omt+RYPEn4o/+M3pV4noVqTI/hDsrs7A3bGtLUoFtkkRKvt/aa+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746842291; c=relaxed/simple;
	bh=BXHKRyzp7CS1ZFTLEp2rb48+BvueXHtHTCf6oYvrkjc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CphTkXdnr+wLl93SGCkltIyrt0M+zYlYE+kSMYnCUglU4d0tVJ81o128dz62uNcOTqtqsZTBpUqZo0yLCwNkL21hdoDhKJZabUVggymQMEws11Y6OqpwjyHC4mWoJtovSD1KlUPkNVyzX626B9/uYnMJwDnrfNP7SSh3kbosOSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QolCKBTf; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gg9SvMbG7JeMgRp5poyU4mG4bVpSkV2yUej9zci2YsCFkcSOfojp4Ct9ilVJQIOIZioic4ULLFgRVmousMLEG45VzM2lMXyM5Pak38I9OwIOH9mBzyeuScufQzU9nsd+1rqrZb3ML2fz/sxUiP65x8JH9Tm4AEBzd+joLQvuZyAtu7tppHgjS1op5vpmdOotswNG7VOWZCab0ZFwTGjHEEGAVvVAs5vLQ5cpCDk+T/6bQxe2zEqgyoD90GI4SATLg1jgsh7oCAaglikpIy02HGBktrrIIfLFqjO+mOc/UmJyEWEKmYGXD5kp6ZtpT09zFvMb0/kwpKlV4lCTSWW32A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MmqSQFeVKvovC/gfeByyWWx7Ewi+xa6pa5cU1y8SOPU=;
 b=MSdTK3w9x9nvQ0IIcohNPmTfuCFrJpDnFIO8s4tQEyr3vcJnSmxB1hAV/98Y3FPNCqBPU/9eGFFoaJ1uPuMq0S5up2x7EvnaDGCgcapwjTSfyWdjup7++t53lAxbLwYdsNharZg5XPTjRiGzrTKT6FbJJN1PqwYNZ8wayIuQTE12JaJ16fwYfx0LmHNDYsp+mkUPSdmiVjNAxUuTSJ7gDLfRiRgChqCkd9K8jvamVZk217BjBkXWwecG1rOOD+WX/o4K7L9qnmo3UHvPjtAzh2ecGSYRKwSbSJ1/iigm8PZppdzvZIW+21WVis9gERDScafJtZjOljTQTLcil1Yz9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MmqSQFeVKvovC/gfeByyWWx7Ewi+xa6pa5cU1y8SOPU=;
 b=QolCKBTfnqOiVp1xnmaelgkFW6SJaWBl12jexW5wY+iGsOg0B1r5SRevQrMXmfyH8/Y5pVPW/GL5yjjghYNrUTcjDOJD4lgd544O08wWjmnYVzWNRMp+5xfneXt9W1Ygv5ne3PZacS/P6NfyTrFQDFIPxTlsIfXR0UGdBrc+/JLZmsF9Bqi642lqFjesh+yOWa7SUKYTE2Nd/lygg7G9onUKwSKiC71NEoMDHQ0cTcE2FFdTU2zrPB8zGDfz0gZB/WPiwB+rtgwQF37yhMqusb5mXfFO6ko/rnFbQOLckXEom0xl23YTGfImu3VeZ5AiPf720JmiG8b3hFiuVRBu9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5968.namprd12.prod.outlook.com (2603:10b6:408:14f::7)
 by DM6PR12MB4252.namprd12.prod.outlook.com (2603:10b6:5:211::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Sat, 10 May
 2025 01:58:05 +0000
Received: from LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4]) by LV2PR12MB5968.namprd12.prod.outlook.com
 ([fe80::e6dd:1206:6677:f9c4%7]) with mapi id 15.20.8722.021; Sat, 10 May 2025
 01:58:05 +0000
Message-ID: <7507ab0b-7b18-4a99-a284-3dd5553a7669@nvidia.com>
Date: Fri, 9 May 2025 18:58:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] rust: str: convert `rusttest` tests into KUnit
To: Miguel Ojeda <ojeda@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Alex Gaynor <alex.gaynor@gmail.com>
Cc: Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev
References: <20250502215133.1923676-1-ojeda@kernel.org>
 <20250502215133.1923676-5-ojeda@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20250502215133.1923676-5-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To LV2PR12MB5968.namprd12.prod.outlook.com
 (2603:10b6:408:14f::7)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5968:EE_|DM6PR12MB4252:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f81a321-9888-405f-618a-08dd8f661a64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NGU5RzlLUkZqdlpPQlpGTkFZMndvVk8zNTdtdWhZSERMTnd0QUl5L3pHbVRk?=
 =?utf-8?B?aWV1RlUraVBhRlFSeTVHSEVYSnpCUHE3eDNQWHNRb0gxK2hINHJuKytxSmN6?=
 =?utf-8?B?eWhnTWYrc3hJNCtIWStiWkFlbWcwUkR1d2JQWldlZ1QyTUsrN0J0MjlIRVVS?=
 =?utf-8?B?cU03amsrdWs3LzdXU2ZFeTVBNkRxUlBSV3hRc0taWDJPUi94Tk84VHJvRHVx?=
 =?utf-8?B?aVIwTEwzUUIxckZEa1BmOU5sMGtDRm9scWxWMi9uN0RZQmVwL1o3Yi9zaGZt?=
 =?utf-8?B?ZkhNVU1kcHlKR3FtQlFWSzIwUmRXM1dBaXdPVWUvQ0xlcy9YL2dMeGV4bXV4?=
 =?utf-8?B?ZTBqYm90cDB1KzMveFN4RW9rN2JoQ0NwTzVBZ2JBU1k3QjdqenlnOUQzNllV?=
 =?utf-8?B?MHZlT3UvYk5RK1FWNVFub29ZYzk4blgvSmRsSFFmTDBHK2N5VXV6dGJtditY?=
 =?utf-8?B?RWtrb3FxR1NYSCtqODZlS1VqVURRTzBZcHZrMkszdDl0NHd4OHI4S3Z5blNC?=
 =?utf-8?B?b1ZkbFd6Y29rNnZYOEdxMkRSZG1nWWZ5dVF5dWh5NXBqb3dCL1ZKTTNQc0VV?=
 =?utf-8?B?RkRNcDhwZzR6NlkvYTkxR1dZVmJ4MGFyVUQvT1NMZUxUSE5vK0M4VzNnMG04?=
 =?utf-8?B?SDhTQjlLcW95QUM3dXcxRDFkM1VFQU5XV3JHWmoxakdPUkFxRWh0a1QzbVhP?=
 =?utf-8?B?Sm03N0dOT1FTWnBCOHRDaDhpazdGWW5KdHFUQ0tHM3J1My9GK01ZQ2w4THpv?=
 =?utf-8?B?NFl5amhLbVpNd20vWTJUczFvOFlsZkcvQ1IzS2FSWUJBdWdNVExrT2s0Tkc5?=
 =?utf-8?B?aUowS1hvN1FaWjM0dmR1QzVvK1l2UndyVFRqS1Y3NXl1UG9ZbGtLVGd3QTJu?=
 =?utf-8?B?bHZPd0RmWEJPbEgyY05QSjNWemFSWUcrSlJJZmxtdE5nRDhYOGVYVXpCR3RM?=
 =?utf-8?B?WGxOYWVMaFZyUmFBSTV1UHNtNE1tdmVoaVFpL2h3N2hJeGRNSUZWU1FVVUdj?=
 =?utf-8?B?NU5yYUQ2SzhZaHFjcEw3ZXRqamgrZW4xN3ByMjlKNTFGaTI4UUtRNU0rcEFN?=
 =?utf-8?B?dmthdDdWc3VLcVNVekp1aTNqK0JIMmtNVjdpRFBWUWZnUDNHclN0VXJGQ0Ey?=
 =?utf-8?B?Sks5RWN4aXV5U1cwb2Y1dXc3QlBGUmdtaTA2S2EwR0ZhSWEyaGhrb2ZDTnFT?=
 =?utf-8?B?OTRDL1paV3lNK05FUDZiRDdlM0FlVC9kQzVxZzdKSVpsUUVvcHpCWkRZZWRV?=
 =?utf-8?B?OWhOeStvellTblRINk1VWU12bE1IM1M5UUhHRjNtaGNMMktnUmdyZnhreDRY?=
 =?utf-8?B?REExYjFmZXpnam1WTmtDazFjNTdUcnFrSHpzaW84VnNveFc0UlFSMTV5YVVN?=
 =?utf-8?B?VmM2KzNwc0J4eWRVL1BjeTBBTm8yM1R1OWc2S21MVTZFSlFTa1NKaU5OU05T?=
 =?utf-8?B?VFVhZjNVb2NLOGFadDlXTExhdWVhUnowMmRPSTQ1THQvVTRuZHl2SHEvSnZn?=
 =?utf-8?B?TWQ3akdnR3djRURjT0FkajZUbXdXblZickhWTThHRVJpQVJ0VnU1Q2MwQTFD?=
 =?utf-8?B?ZzlnK3NwcFdMYUV1dWRVS3FDbFhIV0M4WVVEUEdyZ2NMU0wvWmxGcktZaUM4?=
 =?utf-8?B?dThNU0NvdGNRNTlLZGdlWDd2Q1QwcldTTFR1L0NCTlBXRXpESjRZUnIxdDZ4?=
 =?utf-8?B?NnlOQksvRk1JS1MyNVRRbGxYWVVpeHpsOE9RN293Zmd4WkZnTTZuWnlXVFVs?=
 =?utf-8?B?RmN3SlRkV2VrdmRsYWZSWkJOc0FmYzlHckorS0JQMGdhOGczL1ZZK0lUb3Zq?=
 =?utf-8?B?NUhIMGNYSXNiVjNhMTM2NFNISjBYSHN1aWM2NldZWFdjQmdETkt5WjBIMDlO?=
 =?utf-8?B?ZFpQK0tDOXFxU3c4amI4SXdySVQ0K0xRK3RDMElOb0trOGFVSjVBY0RxSlpr?=
 =?utf-8?Q?Iop6X3tUkEg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eXpmYXpsdXMydTFHbU1nR3RDQTlBY2RaNngzcHV3TGo4L2N4Q3BnUEtMSERH?=
 =?utf-8?B?SEJ0TjZibktVVFJvODl5RXkwdFdqTFJndEh0SU5qcmFVaWNTTjE5TGJYOFgy?=
 =?utf-8?B?Lys1SXdxRzM4TmpPU0h1Nk04N1ZqMUdoZTU0Ky9OYkdJSUJocS9xWGs3V0R6?=
 =?utf-8?B?anRDTTltczlDdzZ6dkNEM0xTcWcxS1hQMkhNMEdCbEE3QVpOSGErMUdrWVYv?=
 =?utf-8?B?OFRReTNYbVovWkZTVVBjNlp0ejZaNXZCQWZFZnlkNDRCeXFZT1NuR21CZSs0?=
 =?utf-8?B?WWluQ1BPc0VKenNEcUpUMlozSXZTeE1nbzRaNTN0K2QwemdRcHpTVEVJczll?=
 =?utf-8?B?NFphNDc5MkJyd1hyc2JKNmhXZDlLT0RRM3l6UFhpVU5YMGs2bk9QQXdubXl2?=
 =?utf-8?B?eXB4QTF2eXN6Ti8xV0ZtSG1HeU82VGRpUTJiU08vOEN4VkRQOHNCV2dCeDFK?=
 =?utf-8?B?eHZ2SWRlQ0VoNmJWclhEMzROWmJzOEwzc1o4am91SU16WWx6QlVmRmhjWTk4?=
 =?utf-8?B?RGlpU2pWa05QREJRc2owaWRiOXc1bzR6YWpFaUc1ckxaMTU5SkFmSE1hbkRG?=
 =?utf-8?B?SHZjZUx2VC9uOEFMeHU5c21jVnhNd0p5V0hMVFFIRXpyQ2FFUGVuZ0o5VkpU?=
 =?utf-8?B?aFU0Y2lTV1paTkFBQWlKZEs1UHJIYmFJVkFjbGpPNVBZSjNYcGw1bmFjZE1x?=
 =?utf-8?B?aVhKNE11VVZJL0VYTmlLZWhqY2pLb004Z0ZPbEtzWENXeXRoQitDa2xyS0FC?=
 =?utf-8?B?MnFCMzRhYWVmenNUcDR0WU1pcm84OFJPUWpWdXYvWVB2bktZQ1l5cXE5V1U4?=
 =?utf-8?B?YmRDOUZjZHh6RVRLZzdqOXlYSm1yNjE0WWRyc1RWR2w4NWFoTnd3STB5UmZB?=
 =?utf-8?B?Ym8zUEZZLzlEaVdGRXRzS3lmOG9TNVF5SUliNmxzQ01XN3h0eVZlaHVaMHpO?=
 =?utf-8?B?bExqQUlCNmNJaTZSY3NxTWtpUGRiSFBINDdYTnREMmtFSnJ0SnI5VkRvZ1FV?=
 =?utf-8?B?UG8vaVloSFZNMXZFdTVDblZWMlpiazB3VDJoa0NSVGpPcVN2T2ljRGRiN1p0?=
 =?utf-8?B?Rk4zeHliUzdndTYzR2dldU9XWllSRm9pSXcyYkdNV1hhNTV2NVFMQm1UK3JM?=
 =?utf-8?B?WTZOWUxpbnVrY0x5ZzJNN2tyT0Z0OVk1UlhGL0d3SGZqYVBpc25JSFNLZUp6?=
 =?utf-8?B?bEp6aE1adFBXd0RSdXZaNUI2SUVKaWpBL0tGVU9UNXVKaTJUUGFTVjV6Y0VR?=
 =?utf-8?B?cW9lZDJzM0pON0xZRmpwSjhpZTBjMDhTY1BPNE1KSWZSVHdQNzRDeVhiTXp2?=
 =?utf-8?B?Y3lqb0VKSkFnT21jL0d1aEhRNkxFR0paMWFpc1VmTVpOVjZSdDdFY2V1ZStE?=
 =?utf-8?B?TTgwZVIzZVBzWld0ZFhzZGdrcmc3aEM4NnE1SXpZWGoxQ1lwVldEUEdMYTJ5?=
 =?utf-8?B?WDgrY29ZWS9lUjJwTEM3YnJLRmNiOHprOVkycHZXTk9SV0QvdjdENW8zakti?=
 =?utf-8?B?U3diUjgxTGp2V2VIL3dNbXI0MkdGbHpKdHdNeTREWEpmWXBqMHRCN2R6QTJp?=
 =?utf-8?B?V01vNDQ4SkZDWHMvWVJEU0Fib1VXbWJMWHFiajFtZnh6eFdtRk1oZVdqYjU0?=
 =?utf-8?B?aG95YnFBcW1BbmpGMzhqWC9JNlhKcmlRVzY0eXBYR2c5eXpUTGZSbXFIVGto?=
 =?utf-8?B?Zlk0czRmMEFyY1lPNm83UHk1TVJ6cmkzWXdabDZsbm1rbHorN1pyQWRDaGl4?=
 =?utf-8?B?eEt1Z1BRa3lwSW5VSVpuYkpLMms3dThoN0liNDdjV0NqZWlhb2NHb2ZUaDdm?=
 =?utf-8?B?TCs1VWI1MWdTQ25MYmJJMndTVGF2QVp5SGNVUm5KQUduMVI4RGQ1NSs5U2Fw?=
 =?utf-8?B?akVFS0JPaXQ5UzJndmNvcnZjYVB2T05uYXlCWStkeEFtNC9iaVViaHBxSVE4?=
 =?utf-8?B?NllCV1EyY2RWMGh6Y3h5T1Q4ZjFBcmlLZms4UnQ5TVdxMDNRS3JnZ25ieTFW?=
 =?utf-8?B?NFcxbHBrSDNVVzJjNkc0em5MdmtzblExRW5CM05VTVl0c1h4UmNJSUxKbDFI?=
 =?utf-8?B?Zkp5em03OG1sMFl0U0hyZGxxUmx6Y0h5cmloS1VtSVkzb0d5Syt6SnBpekZm?=
 =?utf-8?Q?BWKPkIUZnfhWOLuOM1dTeOE0H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f81a321-9888-405f-618a-08dd8f661a64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2025 01:58:05.0444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPJsHJtMU5cXSx+0r0XU4yRbhQySl2BqM2Tk7XkT1+px7lRrJSG8XcAWpSGuB0q6mxGX/injGkcqC683NQwGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4252

On 5/2/25 2:51 PM, Miguel Ojeda wrote:
> In general, we should aim to test as much as possible within the actual
> kernel, and not in the build host.
> 
> Thus convert these `rusttest` tests into KUnit tests.

yes yes yes! :)

Like many, many kernel developers, I've been using separate development
and test machines, and so "make test" approaches are broken by
design.

In other works, launching tests from make(1) usually includes the
fatal flaw of leaving all the dependencies connected. And so when
you try to run on your test machine, it tries to rebuild, but the
kernel was build on the development machine...

It's just a constraint that should not be imposed on developers.

thanks,
-- 
John Hubbard

> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/str.rs | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index 878111cb77bc..cf2caa2db168 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -6,7 +6,7 @@
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, DerefMut, Index};
>  
> -use crate::error::{code::*, Error};
> +use crate::prelude::*;
>  
>  /// Byte string without UTF-8 validity guarantee.
>  #[repr(transparent)]
> @@ -572,8 +572,7 @@ macro_rules! c_str {
>      }};
>  }
>  
> -#[cfg(test)]
> -#[expect(clippy::items_after_test_module)]
> +#[kunit_tests(rust_kernel_str)]
>  mod tests {
>      use super::*;
>  
> @@ -622,11 +621,10 @@ fn test_cstr_to_str() {
>      }
>  
>      #[test]
> -    #[should_panic]
> -    fn test_cstr_to_str_panic() {
> +    fn test_cstr_to_str_invalid_utf8() {
>          let bad_bytes = b"\xc3\x28\0";
>          let checked_cstr = CStr::from_bytes_with_nul(bad_bytes).unwrap();
> -        checked_cstr.to_str().unwrap();
> +        assert!(checked_cstr.to_str().is_err());
>      }
>  
>      #[test]



