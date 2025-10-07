Return-Path: <linux-kselftest+bounces-42827-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F58BC14FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 14:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 69B3934E86A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 12:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF102D9EE4;
	Tue,  7 Oct 2025 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XuIALKwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4FA23AD;
	Tue,  7 Oct 2025 12:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838951; cv=fail; b=bWc6pInLStJpnqd04Oe74KgvUMb+35tGa4ZIbicgLaZs9uLTCWMyessew+ARK6KCHRTfFate1NymTyEYEzxBjgTZt3LhfECgnWzDZe0eaopnuGQAIcJoFKUtXnscQkhyX/LMwVWUN5WO/jwZRQPPVAdCriJwQIzi0hKjGBp5pA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838951; c=relaxed/simple;
	bh=DQQ1rhTwS1MRI+dUIh71XMTFvyikJn30cTiEs19FC6A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jdt/1t6ISJ+JpKB5PYr2UygPLLkjfXkPfb/eGoEWl1dtzbLR8gVD7JUOvaD/LGeuebbk3WqcNqHy+W/93PtK7yagyk8QaB6KUYNYTIBXaIvyZWLbWaZXRkG2qY9RykLroPNCVsV3RU8j6uHqqBnsbBA/A2Q/72yHRCMTaYweeVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XuIALKwU; arc=fail smtp.client-ip=40.93.198.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKyWXkT4WknMeSDmM/tlvPbp3dXxMYV8lgAOf+RKQ5VfLsm347RYWi7DjQ1VkUrkNaMudMkMcpxr6GHU1ovNTFG3+zSs19OAcPCej46u3tjh1wLCfdcKGCLHMpmiBKGzWJrFpt7eJ2ATfCgiwPsIqweLHMtNUXkba32NtvsFDMNMrJrTg7bjzPBn38PslEaIhSScrHsDSuPnVesWsbalJ9t67FfF31HQzp3wZ+IbSXvjABdIheZSP8/3nyaS95+Dk5EUJ2e+poxFn7IYaqfAotodSGRP9WaHTg0hRT+qGL1FpXimrn1S8AzaNkQSXhg1O+vIEGXv2Kc94rshRMMoqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0blDehEd4PCTyJZxzra6CGJcbAT0Xw2TMbXytrotzGA=;
 b=vZOHS00QdSxdm/LmQvXcWQ42bzlJccDGzjTOci4vaIxx97/xaW+Y7SRT5xjDu8K29f5jeIKpx5xFf8qoN8Rcv6PAvqHcotzYxsi+ITG6Kx0BXBpKEk5CMxWmbVYZfylScmetGep2TkyHTkILSvUdaGs3dRATFeph8suXXukRh7aHaLrSiJNnze9v7JcCSqzUlDoq0elEbCMMJS4c5zJNo2+6Thz5zfywp2m4nsSQA6QTVLckBowj73ez66pej4+voKNhqO06lVgOQ4Gc5uftROF+o+1TkSb0DR4NO0jWetDWRjKzQQ4EMDY5cBbx7xPPPL2VvHbZW13Wm/cNKOUeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0blDehEd4PCTyJZxzra6CGJcbAT0Xw2TMbXytrotzGA=;
 b=XuIALKwUj8O0uVGDISJ30XvREcXB0dQScRdgmkjUXB2Fu903/cfZvDna0yFLUeyHNrho/6nHicLttLTNceK/C+yWNlwQ2x6ELFGgOCcveavVNaGA2QE3uB7BE4PSv8OO8wAt1bTfrnhzEa6hkjdN6M1KMbJHgIzeAkaOC0DBjFY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7222.namprd12.prod.outlook.com (2603:10b6:806:2bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 12:09:01 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 12:09:01 +0000
Message-ID: <b9b18a03-63a2-4065-a27e-d92dd5c860bc@amd.com>
Date: Tue, 7 Oct 2025 17:38:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/15] iommupt: Add map_pages op
To: Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
 iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Justin Stitt <justinstitt@google.com>, Kevin Tian <kevin.tian@intel.com>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 llvm@lists.linux.dev, Bill Wendling <morbo@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Shuah Khan <shuah@kernel.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 James Gowans <jgowans@amazon.com>, Michael Roth <michael.roth@amd.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
References: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <7-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0011.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7222:EE_
X-MS-Office365-Filtering-Correlation-Id: db55e11e-9bb3-4104-646e-08de059a4d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlJBQnEvak9hZnVxT1grQTJvbkVJaDlCNC9WZVliU0FzR0JsZHdCUlZZM0o5?=
 =?utf-8?B?dXdod21rbTZhYmxGZDZVZmc1Z2hha3dobGtrQWZ5OFBrcTkra0grMXhaaU9Y?=
 =?utf-8?B?emVOOWNPb2luR2RGai85RGM0U3BpNDdxNER1eWU2cnh3NFZ6a0d2QXNhSWVE?=
 =?utf-8?B?RmkvbHVmSUljWmxjZERqQlRFQzdxeHdUc2xSMG9lRWpFSkZuUDd6VlE0TlJL?=
 =?utf-8?B?clhHTDJ2UExZaXROVE9DNHFhMDdERkhZYTVDSW1JbE5nZGRERGtuQ0c5dXpM?=
 =?utf-8?B?LzFZcWlTUHh5UFYvVTRqQVZnVTJYcUFxN2tLaW0xR1pwWDRHVlZocjQ2M1Nj?=
 =?utf-8?B?TzRpSmF3Z1NnT2t6Y0tUc0Z5Z24xQnF6NWI3Rk9uWmF2NVZFeU84OVk2VFVI?=
 =?utf-8?B?enBBbTlra2V2U04zZW95ZFVxbEJOcmdJRWpjbkJqc3NVYVZBOGhjTUgrYzZv?=
 =?utf-8?B?UDgzaGNBUFhpbVF5bUUxUVY0SWQvZ1lTOHVxbHFteTduUGI4VkRVV0VzTWt6?=
 =?utf-8?B?SG9uVVFWL0lSUy84NitUR3hheDNQWUhJSHloQnlhZm9ONFpaWHovOEtQS1Bi?=
 =?utf-8?B?RXhxSFJSTG8wVEg3SHdsT2o0bGhydC9hUksvaG9jUmdQSWVvWmxIY2lZVUl4?=
 =?utf-8?B?K0NycWZtUENhK3hhSm5PUWE4aVNHTkRXSTh0NmVUNEZRL25yZlExVkxDSCtF?=
 =?utf-8?B?eXNLWVlNNWRQTkkwbXg3aGdOZjJOODM2Wk52aGxGeUxyOGMxUUJvK05UblZT?=
 =?utf-8?B?TUIxWlVCOVhqSGZxS3RyQkRrUjl1dEVIdGZKT1RJeHJBVUdVaWVvdlZ6NWJD?=
 =?utf-8?B?R2oxYldtL0pVaGxVTmhWaDNVSnRheUlkNXByRUdvVXhrSDhNNUtmU2JLY1NR?=
 =?utf-8?B?UEQ2Y1J0R2hpVG5FcnJyVFVUR080R3Jlam9NV3NTdnJpRVltSExtVVRHLzNw?=
 =?utf-8?B?YVNxbzE4TndzckQ2VytZQXRjWENYNTNHejY4L0Q3eE5Bc1FwaHJjTFhua2I4?=
 =?utf-8?B?eVNreXdFaDhRdlIra2tDMVpmZXV2RDNER21GbTdkQjRDVXY2S1I2cDlXMnNz?=
 =?utf-8?B?LzYwWm9EbU9LeFFFbU9FZmtSVEJ2YURTR1BmbGRQRGZoTWRKdlBpWGV3MWZM?=
 =?utf-8?B?VmJ0NkhPWkM4UnZXY0haQjlEMWZCMmQ0Tkp3UmluVUFRRkxqcFpUOVZ5ZXlF?=
 =?utf-8?B?OUZYV3NJK29VSDZ3Sys5QitIQkVXNHlmMi9PakF3WGk3eWJ2OHQzWStCYUFV?=
 =?utf-8?B?VTdBeHUzTWFmUEE5NE9pbjV2VjRTOGh4T3VreFFXSGdldE5FOHNIMmQyTzd6?=
 =?utf-8?B?R0VsU0F5aU9Lalh6NWg2N0RtcVNpcFc2M0F4WHpDdmJ6cVdQSEtMWnI1TW84?=
 =?utf-8?B?QitNMTk5dlJka2g0Sm14cWxqeXpCeUpkM21UUm5XQi9ZQnFnaUJMM2pldUNy?=
 =?utf-8?B?cFV6Zk9nQmZmV3g2UHRDeE1XYXNVZllra0J0cHNoK3d3RHdRenEvdDZoZkF4?=
 =?utf-8?B?OTVHUGZpckNya2E5Q2xiaXV5NHI2Q2dCQ005dFlXMDFwclcxK3BjQzk1VGhQ?=
 =?utf-8?B?OWNCQ0RGMklNb2dxTVpRRmJTazl1T2tIeWNZeFFLTFZwR1Z4QWxzd1dTcVY5?=
 =?utf-8?B?eEloQUVCTGpwbWhBYkR5ZS9FUU9lMGQ0WXh4UUxqTmN5YzhsdUFZUFlGMFBK?=
 =?utf-8?B?dnFVYXNQcUJhWlhNdU5EcnRYNi95bVlzSDQ3Vkl2YnpucEt2NjRKT1A0SkpR?=
 =?utf-8?B?dkdyRDF1eUJOZml6UnlxSmhyNkVUOEc4MzkvVmNrN1dIMWhsVy90VUtjSFV6?=
 =?utf-8?B?eXd1aXF1dm1udmE4T0trVGRtSzIzQzVyS0VobDJoRVB2U0IzeTI4TUNaWUc2?=
 =?utf-8?B?WGRGWXY0YUJ4RFZ5YUFuMytSMUx4WG1YNllBR0JxTGNtMGcxdktueHM3NFNr?=
 =?utf-8?B?dVQvNzFKa1Z6aFVFdCtCUjhZd3FjbmhGUEw2dU80SmxJejVrekZxc0JwZ3hq?=
 =?utf-8?Q?SAwWupC4T/DZYHsYXbUE3dMe5SK8KY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TnF4dGxHb0R0RGVYeWx0MnRNYnBlNjZsTHovSHdFOW1hS2QxN0lKYldWcU9n?=
 =?utf-8?B?S3RDNU9NWmFuVFlBODY2SjRDanpyWjIyS1gza1ZCZWpialE2cVIwd3JvZ1RI?=
 =?utf-8?B?MWFOdVNlNWdiSm9FOWMybUhNcEdCUFVab2Naak5adVlCbG1wWXpOTWlPdlRZ?=
 =?utf-8?B?SW1xdUxUTk9vVGVWK2VnemN3WXlaa01RdkxxTXAxbFUxREtPdGd2K2g5bUVP?=
 =?utf-8?B?Nm1aRnZPK3lGNWV4aU1SS0RHM2hRUmdXMHBYYzFJamVjeVhuOTY2d3lkTUV3?=
 =?utf-8?B?TjBvRzdZLzZrLzBDTDQ1bVdCMjlnNkMvSS9NbXJJaElKNVduNVFYY0hQWnpl?=
 =?utf-8?B?NnAzVzNpMDdxdXdpbTk0WGVEdHkxMTVKSUlKN1FrMFZMNmJOU0pkUUpaOUdi?=
 =?utf-8?B?Q3lSQ09WdlptWmhaTHlVSFVUOHI5R2JTeWJ5WC9wTkdxKzhmN2ZSL216RHBF?=
 =?utf-8?B?M21RMGpWOTFiOFdobFVPeE9ya0p4enZ1SnMySzl3SDZhOXpFcUFmUFpEOEx3?=
 =?utf-8?B?VkxrdHdXVlJjcGt2SGlPOHBqd0oyL2ZIbUNXVmozT1Rremd5QjVOK3NNNzEz?=
 =?utf-8?B?Z2trdGMybU1VcFU2R0U4T3N0NUsxMmtBaDc1T1AzMW9yd2RBQm5Jem9GMHdR?=
 =?utf-8?B?L2NuNkNwZElBMmN2ZTREekpaaGNHRzRVUHZkYjF6VldmSjQ3RlJ1eWtVcE1T?=
 =?utf-8?B?NUxhcVVEOEt3VkhvZFhpeEN5ZWFhd05RNERiSjdQWWxoU0N1cGdRVnpIMUN2?=
 =?utf-8?B?bzU3am1iczhlSmNYeDA4SHIyK0NFcVNjTUgxNkxyT09wMmE4dU9HMFJkcnJW?=
 =?utf-8?B?dVBVbC9HTjZqejBXYmtnVHc2STAzUml4UFFESWRnZUxqdWd4TFN1M2NhTHcv?=
 =?utf-8?B?UUkvL0l2SDJKOU1OWVlQMGxoY3dCdnZwd2ZlYmh1T0xwc1djMWY0ZHMyTGdJ?=
 =?utf-8?B?dFAzdEJpYzVOOW9wa0FqN29pZWkvZVI3SjNzWXlLaGNmWnJZQWFsQ3R5V2RP?=
 =?utf-8?B?MFMwaUNBd3ZtUUF5aFE5dlZMcDZFalhpNk9ieFRhRndYcHJ2WXh2SHN4aDF1?=
 =?utf-8?B?Sk1yS3VxcFJZYUxuZ1B0clRBdFRXUHlhYmp6OHE3MlA0NUNIamxKUUNqSXhB?=
 =?utf-8?B?Z210VnJLSGN6aGhVVWhkdHpGOXF1UkMwVml1QmdrZlVsdkhMTTVDU1BSaUFT?=
 =?utf-8?B?YmkwMG9iWGQ5T3U1SGlMbmpjNGdaVVowcSs5K1M1OWFCVmxMSVJCY25CN0tv?=
 =?utf-8?B?OFhHUlhob3c2OXFwcGJrL0JjWmZBU3RtUUY3RGNzeDRhMVRIV1MxNEZvQXkw?=
 =?utf-8?B?QnNnTW1mQm5lek91S2taUEd0cnNjOGhZdUZTbEpoS2VVSG12UHVoc3BTbGNh?=
 =?utf-8?B?VURrOHpId0MwVHl1eS9kRDF2NnZ5UFZTSVBpWFJZNEVXaVozSzl1YTNnWkd1?=
 =?utf-8?B?OWd6TWpLZ2o4MUdFTFl2bmZXSm5XbVpjby9jcTFMdFdoSVhvVG5iVVJIL2JQ?=
 =?utf-8?B?VXJHWktxTFRqV2xqOTJqWlZPRU54QzE4cm5ST0RVZkZnajU4MnJuMU9HZE0y?=
 =?utf-8?B?bEQvNGdFQlkzZEY3YUtnUDBRVEtINlFmSkdjRzFQckJiaUZqMjltQk9hTVhj?=
 =?utf-8?B?elBsMm9DNFRxdi9TWWRHOWNpeEhudUZuVUsvTGt4SGRQMTZ1b2pOQmpQMTFq?=
 =?utf-8?B?M0hjc1lGZWdmcUphNVkzbXRlWWJXemk3SGt5MGUweUwzQk45M2xsTEFjNmxt?=
 =?utf-8?B?STIrakd1UEYyWFhhakhFeFUxZGp1ZmFZYlBMeW9rUzdSaWx3V0VWcE03WURQ?=
 =?utf-8?B?OXBzS1BZM1MwOUEvcTZFTUl0a3Q1MndjVm4xckNOM3FYcGM3bWhuSUgzZzhN?=
 =?utf-8?B?TFNmZlhnZXBaeERFcENVeXJEYU9RRTFKRzE5ZjFkRTgxRGNqZjc4aWI5bm5r?=
 =?utf-8?B?RHRrNnJtbFk4ZW1hUXNKZEkxd0ZVYUgzZU9jYXRKMGJQd3Z3QVo0OGxMSmJF?=
 =?utf-8?B?alhNQnNLSnFnUEROV0VIN1Q2UGhuNlFNSnRMSWxzNGRkNjBTZit0RVlqM3NN?=
 =?utf-8?B?U243K0g3K0VFdGFGNStjdWhUd2ZyamhzUWg5aUZLNzduMk8ycHQrSWVwSkZY?=
 =?utf-8?Q?2+sRZ6DnURaXRp1DxI0RXtTzH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db55e11e-9bb3-4104-646e-08de059a4d28
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 12:09:01.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mehCYUKRvUoUhNEFOnejk2l6gHjqKFyRnK30u/rh+e3LT+3SNCgkban3TJEuxtSfwutduO7v1vgKYL5ytJKwng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7222

Jason,

On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
> map is slightly complicated because it has to handle a number of special
> edge cases:
>  - Overmapping a previously shared table with an OA - requries validating
>    and freeing the possibly empty tables
>  - Doing the above across an entire to-be-created contiguous entry
>  - Installing a new shared table level concurrently with another thread
>  - Expanding the table by adding more top levels
> 
> Table expansion is a unique feature of AMDv1, this version is quite
> similar except we handle racing concurrent lockless map. The table top
> pointer and starting level are encoded in a single uintptr_t which ensures
> we can READ_ONCE() without tearing. Any op will do the READ_ONCE() and use
> that fixed point as its starting point. Concurrent expansion is handled
> with a table global spinlock.
> 
> When inserting a new table entry map checks that the entire portion of the
> table is empty. This includes freeing any empty lower tables that will be
> overwritten by an OA. A separate free list is used while checking and
> collecting all the empty lower tables so that writing the new entry is
> uninterrupted, either the new entry fully writes or nothing changes.
> 
> A special fast path for PAGE_SIZE is implemented that does a direct walk
> to the leaf level and installs a single entry. This gives ~15% improvement
> for iommu_map() when mapping lists of single pages.
> 
> This version sits under the iommu_domain_ops as map_pages() but does not
> require the external page size calculation. The implementation is actually
> map_range() and can do arbitrary ranges, internally handling all the
> validation and supporting any arrangment of page sizes. A future series
> can optimize iommu_map() to take advantage of this.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/generic_pt/iommu_pt.h | 481 ++++++++++++++++++++++++++++
>  include/linux/generic_pt/iommu.h    |  58 ++++
>  2 files changed, 539 insertions(+)
> 

.../...

> +static int __map_range_leaf(struct pt_range *range, void *arg,
> +			    unsigned int level, struct pt_table_p *table)
> +{
> +	struct pt_state pts = pt_init(range, level, table);
> +	struct pt_iommu_map_args *map = arg;
> +	unsigned int leaf_pgsize_lg2 = map->leaf_pgsize_lg2;
> +	unsigned int start_index;
> +	pt_oaddr_t oa = map->oa;
> +	unsigned int step;
> +	bool need_contig;
> +	int ret = 0;
> +
> +	PT_WARN_ON(map->leaf_level != level);
> +	PT_WARN_ON(!pt_can_have_leaf(&pts));
> +
> +	step = log2_to_int_t(unsigned int,
> +			     leaf_pgsize_lg2 - pt_table_item_lg2sz(&pts));
> +	need_contig = leaf_pgsize_lg2 != pt_table_item_lg2sz(&pts);
> +
> +	_pt_iter_first(&pts);
> +	start_index = pts.index;
> +	do {
> +		pts.type = pt_load_entry_raw(&pts);
> +		if (pts.type != PT_ENTRY_EMPTY || need_contig) {
> +			if (pts.index != start_index)
> +				pt_index_to_va(&pts);
> +			ret = clear_contig(&pts, map->iotlb_gather, step,
> +					   leaf_pgsize_lg2);
> +			if (ret)
> +				break;
> +		}
> +
> +		PT_WARN_ON(compute_best_pgsize(&pts, oa) != leaf_pgsize_lg2);


If I select CONFIG_DEBUG_GENERIC_PT=y and boot AMD system with V1 (Host page
table), in some cases we hit this warning. Code path looks ok. may be silence
these warning?


[   31.985383] pt_iommu_amdv1_map_pages : oa 0x208b95d000 va 0xfef80000 last_va
0xfef9ffff pgsz_lg 0xc pgsize 0x1000 pgcount 0x20
[   31.985384] __map_range_leaf oa 0x208b95e000 va 0xfef80000 last_va 0xfef9ffff
pgsize 0xd leaf_pgsize 0xc possible_sz 0x1ff000
[   31.985391] ------------[ cut here ]------------
[   31.985392] WARNING: CPU: 359 PID: 2540 at
drivers/iommu/generic_pt/fmt/../iommu_pt.h:493 __map_range_leaf+0x636/0x860
[   31.985399] Modules linked in:
[   31.985402] CPU: 359 UID: 0 PID: 2540 Comm: systemd-udevd Not tainted
6.17.0-rc3-genricpt+ #444 VOLUNTARY
[   31.985405] Hardware name: AMD Corporation Titanite_4G/Titanite_4G, BIOS
RTI100EB 12/05/2024
[   31.985406] RIP: 0010:__map_range_leaf+0x636/0x860
[   31.985409] Code: 49 89 6e 18 48 8b 54 24 58 65 48 2b 15 6b 4d b8 01 0f 85 2a
02 00 00 48 83 c4 60 5b 5d 41 5c 41 5d 41 5e 41 5f e9 55 2e 67 ff <0f> 0b e9 07
fe ff ff 0f b6 48 21 e9 e5 fb ff ff 48 8b 7c 24 18 44
[   31.985411] RSP: 0018:ff78b42ad7063558 EFLAGS: 00010297
[   31.985413] RAX: 0000000000000000 RBX: ff453e2c423cdc08 RCX: 000000000000000d
[   31.985414] RDX: 0000000000000000 RSI: 0000000000002000 RDI: ffffff7fffffffff
[   31.985415] RBP: 000000208b95e000 R08: 00000000fef9ffff R09: 00000000fffeffff
[   31.985416] R10: 000000000000000c R11: ff453e6b4c696000 R12: 0000000000003000
[   31.985417] R13: ff78b42ad7063770 R14: ff78b42ad7063748 R15: 000000000000000c
[   31.985418] FS:  00007f46c7e888c0(0000) GS:ff453e6aabbc2000(0000)
knlGS:0000000000000000
[   31.985420] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.985421] CR2: 00007f46c7e03000 CR3: 0000000141f6b002 CR4: 0000000000771ef0
[   31.985422] PKRU: 55555554
[   31.985423] Call Trace:
[   31.985424]  <TASK>
[   31.985426]  __map_range+0x399/0x5a0
[   31.985429]  ? down_trylock+0x20/0x30
[   31.985434]  __map_range+0x1af/0x5a0
[   31.985436]  ? _printk+0x52/0x70
[   31.985441]  pt_iommu_amdv1_map_pages+0x6e6/0xca0
[   31.985444]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985448]  ? iommu_map_nosync+0x129/0x230
[   31.985451]  iommu_map_nosync+0x129/0x230
[   31.985454]  blk_rq_dma_map_iter_start+0x186/0x1c0
[   31.985458]  nvme_prep_rq+0x4ff/0x8b0
[   31.985461]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985463]  nvme_queue_rqs+0xc0/0x1d0
[   31.985466]  blk_mq_dispatch_queue_requests+0xf2/0x140
[   31.985469]  blk_mq_flush_plug_list+0x71/0x170
[   31.985472]  __blk_flush_plug+0xcc/0x120
[   31.985476]  blk_finish_plug+0x1f/0x30
[   31.985478]  read_pages+0x1a8/0x260
[   31.985483]  ? filemap_add_folio+0xae/0xd0
[   31.985485]  page_cache_ra_unbounded+0x174/0x230
[   31.985488]  force_page_cache_ra+0x89/0xb0
[   31.985491]  filemap_get_pages+0x12a/0x720
[   31.985494]  filemap_read+0xda/0x3e0
[   31.985497]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985499]  ? alloc_pages_mpol+0x76/0x140
[   31.985502]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985504]  ? mod_memcg_lruvec_state+0x96/0x1a0
[   31.985507]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985509]  ? __lruvec_stat_mod_folio+0x6d/0xa0
[   31.985511]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985512]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985514]  ? set_ptes.constprop.0+0x36/0x80
[   31.985517]  ? srso_alias_return_thunk+0x5/0xfbef5
[   31.985519]  ? __handle_mm_fault+0xa2c/0x14d0
[   31.985522]  blkdev_read_iter+0x6f/0x140
[   31.985525]  vfs_read+0x207/0x330
[   31.985528]  ksys_read+0x5c/0xd0
[   31.985530]  do_syscall_64+0x50/0x1e0
[   31.985533]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   31.985535] RIP: 0033:0x7f46c8576852
[   31.985537] Code: c0 e9 b2 fe ff ff 50 48 8d 3d 1a b4 0c 00 e8 a5 1d 02 00 0f
1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0
ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[   31.985538] RSP: 002b:00007ffc06f9c638 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[   31.985540] RAX: ffffffffffffffda RBX: 00007f46c7e02028 RCX: 00007f46c8576852
[   31.985541] RDX: 0000000000040000 RSI: 00007f46c7e02038 RDI: 000000000000000c
[   31.985542] RBP: 0000555f80925280 R08: 00007f46c7e02010 R09: 00007f46c7e02010
[   31.985543] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000040000
[   31.985544] R13: 0000000000040000 R14: 00007f46c7e02010 R15: 0000555f809252d0
[   31.985546]  </TASK>
[   31.985547] ---[ end trace 0000000000000000 ]---


-Vasant



