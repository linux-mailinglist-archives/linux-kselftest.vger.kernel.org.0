Return-Path: <linux-kselftest+bounces-32499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173CAABF96
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7444E7A38
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35C326F463;
	Tue,  6 May 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5YCowtLl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC326C3A2;
	Tue,  6 May 2025 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746523977; cv=fail; b=IPmRe9s/Ww8HF541YSZ0PJoslsIeljp1QcU46U3dHr/yFWxSYz2vFaXSNl2Ft2ec9Vn3dZAl60WSkVzHeFMyUAj0vb1sJ7PTxXq6jq/hQ4MCjh6RSnOnyZONg7CrsRj44etFmh6kOEUCO0+yGPud2pu2WNfT8cz8vywwQyU95u0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746523977; c=relaxed/simple;
	bh=D/LbJA8OAFNd/Mzp23J0HZLySZezCucWA+TRfkjdmYs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SEn43WtCIJrSQ3pZNdlLCzSRMjSW1acQ20WXEs4CBS1Gj7+spXJzGA91hnvq5pqmCSveRUaqlFescQw88BpsjsRZVHm9lidHwv3Fk3d+jQ19F4FcZxz/Du2q1qZ5kA+7F5XasSO0NPtI4BCA+6kjCwsqUlxdPUyVzYEBvF9LMco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5YCowtLl; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D9o+GTQ0bqBcMiMCln3/Z9GzYSB1nL8NS9JQgue6iU8ZvYJUI74068KUyp51fRyzv+A7T8S02jcp01ECcSYjdvwYfVS6fp3olblMQZejsFWlxju6zltIgvuf2FZrlmJw/uJt+yY7H0Y4m+7v4Q95OAX7D3DIEyahIN5HdcRVk5m0DrNpqivJdaMRDCvgC2Bhcwk8ZkbVRgSOUxN7hyNilYSAqWOtOErjDmhnYKi0EJ3UOmQ0+075mrM5yxnL83ggyxvgjvtHPNF+luJv2yb2oxrPlQt4DMnTHnnAw8horI5TggJqmy8iq+VnHtWwQPuA/Ps7N0ioxcePZGORWfiM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLMbZRN+jspK/+jzNnJtLPTLKpcJObGErGnlBEUJluo=;
 b=kS87ct3qmwJAIVTGOEzg5xFOjAmUaWVD0I0oR8rczQQ1kDNHsJh2aNjnCNVGKOWBdSnxt4wpyG0BOA0YjavMLVpgl3EcP63lMsPVOOPM62RDCTlY28ZNh1VudG1fkpf+MWXVW+23mJ0dTgsvUe+jBz8I3O8Gbd51aPBW5s3MfmIJhIt24oFX9yreiHgsU2YZGHZVqNUNrqha2H1ntOZfC426dcdGqH6b71wpL/urTt16nm9A5VDemfx88p9Z2ap3EFqG6pf5mZJoSfw3955rMqztSUffuabm9xiQxLGZKxuiSeS4zAISrniOpnG1YwWZltEK7jTOPo0ex4EGnyCXhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLMbZRN+jspK/+jzNnJtLPTLKpcJObGErGnlBEUJluo=;
 b=5YCowtLlgrP+vOZAiTvvgv1syE4K4FK1KOdh4M19EiIaGxXLqg4YNa4KecBmle65qQRMMHSIOQ4C3xYMRg/GOF5Df4LMGIL2jZC2mqfo2Hgbra0BhnZMEY2yNTGBqL6KnblT5iaW4/Js6L0el4eyo3ptzc0ykBNfL6y5Ux2n+mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.26; Tue, 6 May 2025 09:32:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8699.019; Tue, 6 May 2025
 09:32:49 +0000
Message-ID: <b324b13d-8891-4f39-ba61-94cc727e2cd0@amd.com>
Date: Tue, 6 May 2025 15:02:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/23] iommufd/viommu: Allow driver-specific user data
 for a vIOMMU object
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com
References: <cover.1746139811.git.nicolinc@nvidia.com>
 <254637ea8929f57b9f89aa7aa1432671c5a554d4.1746139811.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <254637ea8929f57b9f89aa7aa1432671c5a554d4.1746139811.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:274::12) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf44067-2a54-4f2e-2b14-08dd8c80f792
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWZVNEY0Uk5zRWZGb01Qb3dMM013YkVRd2Q2aWNYSHRjeHhKVENzd2lOaDhB?=
 =?utf-8?B?Snp4b2JaeWMvTmZ0U2RqZWkxdkgwQnBsNUlMeUlOcHVSN3I3dURFZC9JLzY2?=
 =?utf-8?B?SnYraWluMjZEeDlEanNrYXcxWTdSaWVSSitzeU5WL2lhWWszZXlDRGtQNXZC?=
 =?utf-8?B?QTFZZDdzQXA1cUtaazZYSzl3NHMzSC9ENDVwVDRSL2NycHQvZlYyVitjcUYw?=
 =?utf-8?B?ZGZVM1YxN20xWFA5aFRnOTVGUktKdm5rR1BqL2s4ME5SOXE0ZFNKUHBPei9D?=
 =?utf-8?B?anNaZFVTM0xmczFRNGRsSlVDRVk5OU94bXRzdDVqRGNWWHRFZmJjaDNjNzZ6?=
 =?utf-8?B?Qi9IdnFTL3JPam95VjB3eFhNaWtTMGV0anJBTnRQYVdmQnJaUHlRa1h6T2Nl?=
 =?utf-8?B?UTNNdGRTRUxXTzN1dnJBM2lhUklNVnJkenBxT1ZlNUw0NFBFVmhsZWRQdFgy?=
 =?utf-8?B?VWR6S2s2Z0VpMlAxL3I0VlM4QlY5Wm5VR2V6OXcxcHRQcSt2QlNTNHh5blhy?=
 =?utf-8?B?TlFMcmtwZXhPWmZwSnhJN2ZVQUFVRm1nZTVPdnVFNDFhU0x1ZHRKYmFGV3dq?=
 =?utf-8?B?ZDl5SUFWYjRuSk1PaHVZVGJnZTBPOWd2Y3lvM21oOFpVaXY2M1E1M294aDFE?=
 =?utf-8?B?VmxNVnRRV0tqdmdxdENoMEdybS8rajFtZUxaOTRTUG1ObXpTUEJjVEFHNkM2?=
 =?utf-8?B?VXY1bkhySllkWDYwYnZYTjhJRXJxOUkyOVpvLzBZelZYQkpvNHJBM3BJLzc0?=
 =?utf-8?B?TGRCMk51czFKd2RnV1k5MklGcDIzNWNWT2dCY1J6R2hiVU5CblpkemZYdTdC?=
 =?utf-8?B?ZXo4cVJVMGhyV0dhTnNkTk04YWhNRzR1U0V4V1dUT3p2ZXVGQnlGRS9oeGda?=
 =?utf-8?B?cFBqaWhKQTJsd3NSTmJqbm9wV1hPSlBzTUpYT21HaHdIVjNuOVNreU03N3dR?=
 =?utf-8?B?d1dOb2h4T0JoSHQyc3RZbmJEbm40OEk5djJZT3J0ZFh4VnVKaDJzdWliYkNF?=
 =?utf-8?B?d1hiWDhqRVViRFRnNElNc3lhV0U4M1NtMFdNYndZVFY4WEFGeU1ZcnRiVnR6?=
 =?utf-8?B?Yno4aDVINWhZTi8xK3d0bVdYVEFrZStrYnc3YS9hcXpxRExZM1UybWkvTFBF?=
 =?utf-8?B?amtWWVpEelBVc3dBOGlhSmtGQlBIeU1leUtjQktueE9WMnlBMjgwQkt4SmV0?=
 =?utf-8?B?Z1dLaDZMeDFxQU9abHhaTyt6dDBFbDUwYkt3Zm9BcEdZbHFGOEdITzdvcFZw?=
 =?utf-8?B?OWtNQno1TFB2MFloVHMxM21LWmxTNmQyVzBhcCs1a2s1SjBtODhjMVo4bUUw?=
 =?utf-8?B?SkZJVGVYck9DRnF1QzMxU3ZwRzVCb29yTnRJRnhQQWNwdnpJSVJ5QmdQM0tN?=
 =?utf-8?B?QllRM0tLRTE5Y080TlNkcDZuWlVDV0prSTR4SmpJZEdwUmpFZEd2c0h1NEg1?=
 =?utf-8?B?Wm94YS9RZzIrVHZRVU1ubXRYc3k5OWc2WEpQYlcyTjRzNWlNUXk1QWxBdUtr?=
 =?utf-8?B?cmRMMUg4cEN1SDkyOVg3Q3c4V25LZzJpU0hGSkJUTXhCSU1EcnA3NWJ3VWNp?=
 =?utf-8?B?TFIwZ3Y0R0Y1NWxxSlBHTmRjRGFQWEFZSG01Ym5TS2t3Q1pXNGJNOUt3cGpp?=
 =?utf-8?B?ZEppOFRPV1pjNysyT1NnaFoxZG8zYWw3WnIxcHhqd0d0azJsaFIrYVEvbWZO?=
 =?utf-8?B?bmtIL240VjVUZlplRXVadUR2T3dicGlTUlJ4WUJ4ZGVKQlRic3NyQmlKWVpU?=
 =?utf-8?B?T09ybXVIdmY2SnQ3RHVIUngvajNTRjlYWFpRS0llcHYxVGFTMEtsZDF6T3VC?=
 =?utf-8?B?SGExZENuZ0tvcUVpMkNGWk5kRzE4dkpCRzkxREtvaHhhN1I1QjBXTnkwZlA0?=
 =?utf-8?B?ZkJuS3ZJdVVmcnhzZ3lpSzZ6dklzREtjTHgwOVg3THRBYzJDbXJ4YVUxYU96?=
 =?utf-8?Q?niP7ym9oVlo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDZ3TCtONE9IWUNxcFIyZDdmTVBSbXg4cUIyaVlCQWJndjZWZzdLbzAySm5F?=
 =?utf-8?B?K1VteVViR3NWVzVueTBTc01reWdBUTZIM3VXa3M1WmJPVWd1RWNrZWJra3FL?=
 =?utf-8?B?dDdVVVRCYkFUb0hyN1lGOGd6bHZZUjFrMS9Menlwa1VlTkxmdEdQN0FxdlVO?=
 =?utf-8?B?cjhIYWowNDFvRjBqckcycm1PU01ReTE3aFhyYjVWaktQTTVXYmkwYWFZdXpj?=
 =?utf-8?B?ZTY1UmhhWkhvbnVCMlJoMVkySStKZkNXR0I1ZEszcUtDYmhZVzIzd2EvN2pn?=
 =?utf-8?B?UWthdkQwU0Y0WnlKNWIvSFpXNkdBd0Zva2JYQWp0ZHJldFltanhhQmVYbDh6?=
 =?utf-8?B?ZmZ4TEhvSXpRcXhLc0U1TmdIK1hlTWZySHpPbGtDQkpnbW02TUljem42bXd5?=
 =?utf-8?B?ZHQrWHdxcVNObS9vZVZ2eWRueXYzaDZzTXpuSy96VXhFT3FTZ2NTR3FBSURw?=
 =?utf-8?B?SnVCS2NTSGY5cDQvbjhHYStHU25Bajl4dkJmQ3loZkRHQjg1a2Uzdks4S0kx?=
 =?utf-8?B?d2ZGTWd1RVZ3ZjRheXlNa2lvOTQrWjJHWHlHZktXNnhTMW9vL2V4cERScWM4?=
 =?utf-8?B?QkNIYUpicmI0a1JaUHZ5WlhFazdoQ2hoY0NOVXVxOUc4TUN0b0lkUjZERFhG?=
 =?utf-8?B?Z2h3Qk02RFl1Y1NGZWxGQmRDSEV4UFN0RWJEQmVkNjlBc0NocEZEZDhoUmVN?=
 =?utf-8?B?dWVrK1lJdkR4RUhaMkJjR252bU5mNFdKa0hGcmhzOWJJdENkaHNMOEZYcVJs?=
 =?utf-8?B?alRFTUZCWTNiUjREL3Z6RENoUE9yNjZWZ0NTN1lMeWZnYXF4Q3hTOTl3M3BD?=
 =?utf-8?B?RjY5VEFCaTF6NXd5NGxLdndSd2creWtuTTA5aTVpRldaK0RoRHFpeXN2WDhX?=
 =?utf-8?B?N1pmdzRieG5SS01qY25UdlZXdWM2MGxaL0VkL2VDNEJYZWVEcDZsNWFpMXg4?=
 =?utf-8?B?dWtxWnJTUHhMdUdEQ281c1RWTHlBZUJiVm5CWktjTFQya29wQlZHTmpienUr?=
 =?utf-8?B?cVo1L0RUaGtTdHBEb1d0K0dHUmJHRHRWOXY2VDUrVHBpR1BsTEI4N0xqSjl3?=
 =?utf-8?B?UWFKdGNuOWdFUjNnOE95eUpvdlBnMWJKQmRNc1Vva2dSN3FZd0ZhcW9oM1Nj?=
 =?utf-8?B?UWJCWm1pWENua1MwN3lEQUlIdythQVIzTGgzbG9GcTkzSXpNOGlNd0xJUEdV?=
 =?utf-8?B?ck1ZZmVoVFpGT1l4Rjh2eGJmUHJxd0VLY3hBVW5ZS3VsZlF2dHM1N1h6V0ow?=
 =?utf-8?B?ZUVYQkVZaXlTOTgxOHp6Sy91a1lvbmNVaXpxalR3bis0VHdBRjVUTXdIem4v?=
 =?utf-8?B?bWxXNzVVZ3NhbkFyanRBY0srUXYwOEN2ZGV1TzNDYTBnTVcxa3hEWUJtZlJG?=
 =?utf-8?B?WU80YTI1UkFQdzFkZnNnOUlieWdWOVFlandmWXoyV0pvV1htcVVZUG4xSEhq?=
 =?utf-8?B?VGhoREErbXgzUnN0Z0F2bGYvTGt6TmxQTzljS24xOHFybzZkVEdjaElUVjdJ?=
 =?utf-8?B?dGN4S3c0em1wM1B3M1dTeXRDNk45dExrMFFoMzVhRFVweWFmMFkrVGh1M0RB?=
 =?utf-8?B?RW9ZdWxyc2FVSUIrVXp3UDBrNUVCb1FaZ29HSkRJTmdjZnNHdDBSdGcwa1lS?=
 =?utf-8?B?RGU1RXV2a3JLem1nT3MzOWcyeW9UWWJFdG5LN1BSTFFuZ1RuZ3ZrZ1ZnSTVF?=
 =?utf-8?B?WHl6OTlaY2FLdWRPcUt3ZnhoY0h3M212U3F1MzFOV0t1MTRKQWdPaUlXMUh2?=
 =?utf-8?B?dHZFM0cwVmkwTVlINzN5VWVjOStxbUREa2grbzJEQU9zK3MwakJNM3lONVVB?=
 =?utf-8?B?YXd4b3M0dHpBcXhzR3MwYkU4bVYvTnRpazlJaDJWWEtUTnNuTGg4d1dwWEt1?=
 =?utf-8?B?cU4zb2M3bmhHSnZiSm40TWR6QWdzZFBLNFZlQU1vYkV1ZUNCaUNlOWVwQ1Zy?=
 =?utf-8?B?MVo3Y1orTHhGdG5RVit6NDlmNDROYVYvMTVpSVczWVE3emEzZEZZQ1MxU05X?=
 =?utf-8?B?ZzlkMU9lQlVERWhxak5qV1Y5WWpKcFRQTlFLc1pScWExbUtSbU9IemZlK1lL?=
 =?utf-8?B?U1VBenpoYlpjQy83L0FRTVdpeDZvZFZIc2JIVFlSL0hoUHJaN3NKVDBsc25I?=
 =?utf-8?Q?Y+4QGcAGh4DdFCfUL4Q9GrgFR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf44067-2a54-4f2e-2b14-08dd8c80f792
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 09:32:49.7786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s9wlUPIIMdtBF+D+Yv3oG9xMtHpTOM1+Iy/GJrJcNNHCn8GYGL4ybTv39OcumiYepL0n620wi94OPh4PG6s6ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600



On 5/2/2025 4:31 AM, Nicolin Chen wrote:
> The new type of vIOMMU for tegra241-cmdqv driver needs a driver-specific
> user data. So, add data_len/uptr to the iommu_viommu_alloc uAPI and pass
> it in via the viommu_alloc iommu op.



Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant


> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Pranjal Shrivastava <praan@google.com>
> Acked-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/uapi/linux/iommufd.h   | 6 ++++++
>  drivers/iommu/iommufd/viommu.c | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f29b6c44655e..cc90299a08d9 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -965,6 +965,9 @@ enum iommu_viommu_type {
>   * @dev_id: The device's physical IOMMU will be used to back the virtual IOMMU
>   * @hwpt_id: ID of a nesting parent HWPT to associate to
>   * @out_viommu_id: Output virtual IOMMU ID for the allocated object
> + * @data_len: Length of the type specific data
> + * @__reserved: Must be 0
> + * @data_uptr: User pointer to an array of driver-specific virtual IOMMU data
>   *
>   * Allocate a virtual IOMMU object, representing the underlying physical IOMMU's
>   * virtualization support that is a security-isolated slice of the real IOMMU HW
> @@ -985,6 +988,9 @@ struct iommu_viommu_alloc {
>  	__u32 dev_id;
>  	__u32 hwpt_id;
>  	__u32 out_viommu_id;
> +	__u32 data_len;
> +	__u32 __reserved;
> +	__aligned_u64 data_uptr;
>  };
>  #define IOMMU_VIOMMU_ALLOC _IO(IOMMUFD_TYPE, IOMMUFD_CMD_VIOMMU_ALLOC)
>  
> diff --git a/drivers/iommu/iommufd/viommu.c b/drivers/iommu/iommufd/viommu.c
> index fffa57063c60..a65153458a26 100644
> --- a/drivers/iommu/iommufd/viommu.c
> +++ b/drivers/iommu/iommufd/viommu.c
> @@ -17,6 +17,11 @@ void iommufd_viommu_destroy(struct iommufd_object *obj)
>  int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  {
>  	struct iommu_viommu_alloc *cmd = ucmd->cmd;
> +	const struct iommu_user_data user_data = {
> +		.type = cmd->type,
> +		.uptr = u64_to_user_ptr(cmd->data_uptr),
> +		.len = cmd->data_len,
> +	};
>  	struct iommufd_hwpt_paging *hwpt_paging;
>  	struct iommufd_viommu *viommu;
>  	struct iommufd_device *idev;
> @@ -48,7 +53,8 @@ int iommufd_viommu_alloc_ioctl(struct iommufd_ucmd *ucmd)
>  	}
>  
>  	viommu = ops->viommu_alloc(idev->dev, hwpt_paging->common.domain,
> -				   ucmd->ictx, cmd->type, NULL);
> +				   ucmd->ictx, cmd->type,
> +				   user_data.len ? &user_data : NULL);
>  	if (IS_ERR(viommu)) {
>  		rc = PTR_ERR(viommu);
>  		goto out_put_hwpt;


