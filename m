Return-Path: <linux-kselftest+bounces-30399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBACA81C8B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 08:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3E71BA306B
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 06:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAF11DF270;
	Wed,  9 Apr 2025 06:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xKSpLSH3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2044.outbound.protection.outlook.com [40.107.237.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56F1DDA0E;
	Wed,  9 Apr 2025 06:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744178469; cv=fail; b=iAGQO/W0TK9GlSf/DiuaizhPsUUIvz+MyaruJfPm+7xz8YZggsk4tYUgCKpTaF0cS8R56hYqOmK2mGxJTaKZXcO/vKXs5PINxcGQEwU9XSG+p0xUA95nVzi+tE+O0KKOvwo3qLzaULADa01D/m9Obm+/qAGFkGecpCMETXZf8Q0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744178469; c=relaxed/simple;
	bh=SJzuHIGx2vcQp4Fao5iu2eNg9mHIc1ETZ4JOu/TcOWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jFZtatyHdLd0L9u9y4clY2IvPJCA2CCKQ8YEeDXQW/9bHBUQbm7UnEq8ylNCnmWJELkEdf6aUWf+b4/y1sSJbsLzgKA5aY+ZXGP3xxUuIo1LHcXC/xsYaRDPMh0XHfERblWdcizr3ROcexsHPPctlP/VUNRHiZGTz5ECvF3HQPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xKSpLSH3; arc=fail smtp.client-ip=40.107.237.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+giOyRybKgL8X6ODDnT0MPigX7jgHHwaTbgsaVa3kLflXv/BsTugNrNCVlXgbG3gmEMpmmk9mKtxLaGgkQbiuFfBZXeBRWlE8JEHhDE5muH4hQ3kzbrxScy+VUht2E4HBicLRGqU9DN1+O4Ge0HuytOqzaj2LR3l8plv1U6dJ29aL1BIiO9R7KfxD7Vq0dkkG8vroZ4zHl2eGs6L28QhAX6Qn4Vdah/yjUOXYHMDOfB+RRgeorPQdmSIwsz6h2quiYCiiSMdv6wX9kBCMOtbTqSzOlfOY1NmeZfi9fyOsjpqWsC4jzMF9NTtnOQcs8n7mU/GLA31GwqI9hlbH6eXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elMNPYefKQUyrJO8yp702ClACDRdPrndx0n5yRREdTk=;
 b=jAgh+2nIn3E187HLnVFEAQKMAftusDV0Y93n2ClgbIUneJnl9ZW1sggdrcI8vHEgNbJ85hhhDwugtihxGP+9GkiasQ77PYbLAzcWTEUKV2sxuIpglVM7vUzMj1vrPgDAMOzdPC7qF/MWtOpiadgV7p1Q+oomvGURW7EvxxIpPYexijVZDXo67Y51x6JaQUc6MCFkNTwHfSHvWWGNMRE0mnI3rxWzEAA7ZdeSta3HdI+JKwRzcX0GXdqL/UszRKaE+ed/scUVjK+E+seZY3+jzm9ptSJ6m3dibkWBGVIvITfu8xGqlhuFcUib9xUbx7yCQ79jLc1K9rY8ANwP9eLZ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=elMNPYefKQUyrJO8yp702ClACDRdPrndx0n5yRREdTk=;
 b=xKSpLSH3PHsjRzb+lxNGz9p/8PpFRbhxcHF1Zj7JlJdRUZJbldFv7EWgrr4Wb5L7/raTTnQTT8d5d9k8Sogbt96AebhuuvYYJ+jmgX2GWs5Gxc1lPkMFzygalxAjoaXtEdnkW2OAoyaJRwYzZRqLaFesJO41tKeJ7J9vUXFeHN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) by
 IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 06:01:03 +0000
Received: from DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb]) by DS7PR12MB6214.namprd12.prod.outlook.com
 ([fe80::17e6:16c7:6bc1:26fb%3]) with mapi id 15.20.8632.017; Wed, 9 Apr 2025
 06:01:03 +0000
Message-ID: <55986a72-1be4-4e96-809c-dd004291df2e@amd.com>
Date: Wed, 9 Apr 2025 11:30:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] x86/cpufeatures: Add CPUID feature bit for the Bus
 Lock Threshold
To: Borislav Petkov <bp@alien8.de>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, seanjc@google.com,
 pbonzini@redhat.com, nikunj@amd.com, thomas.lendacky@amd.com
References: <20250324130248.126036-1-manali.shukla@amd.com>
 <20250324130248.126036-3-manali.shukla@amd.com>
 <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
Content-Language: en-US
From: Manali Shukla <manali.shukla@amd.com>
In-Reply-To: <20250324215627.GBZ-HVC-KmZiTMxPr3@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::24) To DS7PR12MB6214.namprd12.prod.outlook.com
 (2603:10b6:8:96::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6214:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ad83ffb-16b0-4874-fe9e-08dd772be885
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2w3OENDOGY3cjlYZUp6YzVQaUJYV3FmNktxVG9lQWhPVDRxaVg2aXhGUGEw?=
 =?utf-8?B?SzQ1czVBVHdSVjZjdTB4djN6RkxDSUpxZWtkVmluaFk0MDNZRWxFRGRKS1JC?=
 =?utf-8?B?TTE5dTlCOE95czlqUUNWVHJ1V0Y4NzdJWUNkbEVSb2p3SFJTRjBGUjh1THJH?=
 =?utf-8?B?Zmo3ZXArLzExc3ljeVViSm1ORjQ3OWVXalcyUXY0RVNGalVWQUd2bDFVRkZK?=
 =?utf-8?B?elQ5T3UwN1pFVlFlZUY3cmlWUmRZZ215ZUxKVHU4d1hWOVpFb2xLTzE4a2Fp?=
 =?utf-8?B?UjFUT2N1MkRWdElLdE54anBLb0hhbTAzMEhTZUFNMTlVMFVYTlYwSy9rN2k5?=
 =?utf-8?B?ckUwZVpUMHRSVXlPRHcyUGtGbzllYXMxY2dOYjkvL2F1akZzcXkraUlTS2h2?=
 =?utf-8?B?M1F4YW05aWxlYm9UM3M2OTkyUi9yTWVKaDk3ejVDWWNWQ1g0VlRLUUhuTldP?=
 =?utf-8?B?S0pxRjRmVEFJMG9HWHI5ZHp1blpvM2M0V2tZeWpyeTJBL0liSXc0T2pyVHEv?=
 =?utf-8?B?NnFXbWlWL1hxVU8vUDNnK1F6VDBzTmRSSzBiTjNTRjB5cmsyb1Bpc3lBMEVW?=
 =?utf-8?B?dFd1TmtidHpqaDlQSnc3TklOcVFVazZqcVcyK2hNL2xDbE0zNlg3dVlnclBM?=
 =?utf-8?B?QVBUSzlmdldweXFTeGhRbXVEVlNVYTN2MG1pWU9MODNwL1NmTmZ2WDEvTlVm?=
 =?utf-8?B?czZhZTFwd29kOVM4R2FqREo2K21xNVlDaVpnR3h2c3ZhRmpWb0ZhMFlsN0Jo?=
 =?utf-8?B?bnNqSmNKNVNNZ2VvNVhETDdjUFlMd0xNSWo3WWNGa3VQcWREVG1zbkhFSnZ2?=
 =?utf-8?B?RytVb0kvOWpkS0g1dnlpMHhCWU5xbThjaW9DSGRZQnVySEN4NC9VOXk2Y0dX?=
 =?utf-8?B?dWRUSk80RkNNNWtMZ2tMR1hwR204Z21udVVyZ09meXp0QWt5L0w0bU1MMkZP?=
 =?utf-8?B?QzBUempLWDU2UXR3WVI5K3FONHdOOE9RQTBwOGd1T2dDY3VQdTBLaDR2ZE1J?=
 =?utf-8?B?ZWZTU1lKc2JnRWV6ZStraU9RRnVwcUs3cUorZGxBSnozM1VRTnVKMEp2SFI2?=
 =?utf-8?B?ejNycHFtbmUwMFUvQU40d0NIUXNUYlFvSndwa2JpeWRRdzUzUVRNYnJkOVdB?=
 =?utf-8?B?U2FPN2E0NUo5ckNZaGxmc1VSbG1qVS9KUGROdG41WGJ6OWozRUVMcXVjUGN3?=
 =?utf-8?B?Z01LWnJiU3pPU1ZTcGppeHlFOGlkYUFWdkFJTThJc2JpZjVZZTRrN2h6Unk5?=
 =?utf-8?B?TStGWC9iMkFYNWR3MzZzaS96ZWZNNmVsVVhCY1c2WUFaanUwZmREK2krbXlQ?=
 =?utf-8?B?ODN1UFNEMTVwVTZqZS9ZelVkdmF0Qzd2THB2bjFwSkJIREtnb1ZnNnhCTEpi?=
 =?utf-8?B?bm9zUGJpTjlvZG9pTHNxRy9iZmg1d0JiSmg0VlZHUWdyVGpzNGFnZFVyeEN3?=
 =?utf-8?B?M3phcWhjd2VUYVlGVUVPTGc3QmRndW9kOEpTN3g4c3Z6R3VObW42MHRpVzgy?=
 =?utf-8?B?c0VVTjdUb1RIOGVlVjJNWHNBU01yYjl6aEhhT1BlUUp0clJ2R0c2ZDJhTHFx?=
 =?utf-8?B?WGQwSVB6QnJyeGFiTXBkUFRpa2dwK1R0MnJKbjUyTG1RR3M2S1Z4NXlHVDlP?=
 =?utf-8?B?T2hycThSNXkrME54S0tKdkxIeWtkR2VkVXBqcWx6bWtuRmVWK1RrYy9MNWM3?=
 =?utf-8?B?aWsza3M3KzQ1WHdaRE8xcnpUS0c0N2JzMXNKR285UW5jRDZ2MGorM1d3bE84?=
 =?utf-8?B?MlRoTWZjeGkvMkUwUE9INUJ3ZHFpVHVRUC9JMG5BZVFPNnhxb1hWVVpaeFJG?=
 =?utf-8?B?UGVCcnFMb2dQVWVENExvUXM4elNVamxZYm4zQ2xQNGJDS1habi9YNlJwMzEx?=
 =?utf-8?Q?NLTYsOAqHxe5V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6214.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dExOSkN2d0tUYzlEOTdkU0l0czBpeC9weVpGK29WQjFKWkl1N0JwN0xBSUYy?=
 =?utf-8?B?d3BYK1F4bU1tTWZId1pudklURjVrN09mZG5YemRsOE9kQ1pzVnRZNUpsTzYv?=
 =?utf-8?B?R2w3R0Y4YktHeFpkMmVhbmlNTVRKOHlPSkJaOXZQNmNDaEZUcy9iWVRJeTVG?=
 =?utf-8?B?Yzc4T3BsYmJjQnBuWmpFUFFuS0JEN3M3RkplSlJDRFZFenl6OEREYU1GV0hG?=
 =?utf-8?B?dXd0aElTNjBLaTA2MnRWQ2Rtdm90L3NlcWswZnhEY3lEbWtURXhvQ3ZYWUFK?=
 =?utf-8?B?MTBlcU9VM0cxT21aQUl4Tkppc1ZIWk9VaHE5YjgrRy9VNEV3MVR3WTRjc1Ry?=
 =?utf-8?B?UTF2YUNQTUcrVjFSV3hmSXIza09JdHprK0FnSE1qWCs4SWJHaUtCYTB5UHAv?=
 =?utf-8?B?L3hZQVQwcUg3SjYxQnZhQTVMdEZnV3VKWUNWaXV3TzFlVStBWU01WDdOT1Bn?=
 =?utf-8?B?THJ5MU5ZZmZiUXNPT3N6cVZzWVMyVUVWMDNUUzlTNGRNTll5REdmZlZFM0Vq?=
 =?utf-8?B?aU1sWDNwbGNvcUlSQnlYWSt0TENWdTVWSW50aXR4VG9Ca1EvdVlzQW0rUU1x?=
 =?utf-8?B?OUFMd2NDQU9VV2N5N1QwTG0yemJZSlBxM0J0dzNSbTBTVnIxY1kvamt6M3FZ?=
 =?utf-8?B?U3UzZ3lJclBRT3VDaGFNQXhhNGg2ZFpxallPOVhWLytLcmNYN01weDZSZUt3?=
 =?utf-8?B?L2RpWjU0WFBvQVVmYkZrL2xYN1YyZktwbFk0NWFSdysxcDBSWXRxdGRVVERR?=
 =?utf-8?B?MmpNREN4K0dEODROM3JubGJ3c2p4WkJkdllHUmthTDA3dml2V3hGLzhPTEc0?=
 =?utf-8?B?UzVJa3RBR294SlYxL2d2RzI1N1hiRmtHSTlxOVYxS2lyWXVtTlNMQWwzNTRy?=
 =?utf-8?B?ZXVyd0hVNC90ZGR2WVZyc0xEY2FZY3FJSFpESlNPdy82UmVqZ1duajQwVkpS?=
 =?utf-8?B?T3BsN3QvQWNkcnhYYWR3eStvMWhBVUhaQ2R5T2hJdzB1Uisxc0o5OFd4V1hB?=
 =?utf-8?B?Q0l3UEFKLzB3QmQ4WC83OWEzV1BHREtLdlZiZ2gvOVJzcUoyT0FyWnR1RklP?=
 =?utf-8?B?Y0NZS1BLZWI0VjVwVXJzWEplRmZCdkcyYTI5OHJkQnl2WHVRZGZlR3VmdWpK?=
 =?utf-8?B?WituRlF6VWtNU3c3ODY1dWhtOVo4QzRDS0xvZ1ZKeGxXU1lPZ2oyclI3MHZx?=
 =?utf-8?B?bVQ2K0R5TzRSYlNVOEV4T2ozNGdzalk2RnIreURGeit5Q3V4NFZibkYxSkhj?=
 =?utf-8?B?a0pTbXdKNThFbkpyeVY4NmZaOGhUQ1JYbU5EYXF1TmtpUlJ6bUYySGVuc1F0?=
 =?utf-8?B?Y3pKSE5uNXA1c3pWbHNPSXUwQkRZVTVENTErSmdraVdiSG5qb3VlNzJha3Bm?=
 =?utf-8?B?bVZqdjY2cCtNWjgrcEpsUElUSnd6TzVsQXlZWlAyOGUwYjBzQmJXVTJJNHJU?=
 =?utf-8?B?M0pxYUJ1Z3RVZmszNEdleTE2ZVl3bCtlck1NdEhXbHRVUk1obktvQXlWYy93?=
 =?utf-8?B?ZHNDL2pTYyt5WjF2eHlpZTlvYnpsV1lTWXFRa3B6SzBnbDBaS0g1M2dBTXkr?=
 =?utf-8?B?NXNLcWxxK2lzenlqZ1lJaUQ5NHg5MDBGYThjVSsxdXM2b0JlOTdQbXpZSGVI?=
 =?utf-8?B?QXA3Qzc4aXJMSWk2cWp1TExHQlBlYmtBbW1TTS9IVDMxMVZoK1NoNi9XL0lR?=
 =?utf-8?B?YnBXTVRXMGIxSlQ4aTBYQXR6NlhqZEl3NjZhbjVQRUFHYVJrRGF1a0E4c25x?=
 =?utf-8?B?cmFFeTBGTUFQcUN0USt3bHdMTm16NjZDeXhRRHgwTnpUeVowdFUrOC95Z3c4?=
 =?utf-8?B?REUxQ0NsbUFFRmFWcDVVMGxzQitxSEZkSGlSSGFMSmYrUHJITjVFMzhIWjhN?=
 =?utf-8?B?cFkwczBwQlQxVUhQVmEzTkRuMzl0R2YyNytlTk95S3VyaTd0NTZhK2dGZHZM?=
 =?utf-8?B?V2RPL21VeUp0Wnh5WEpUc01qUUp2R0EwcE9HVVAzdjBjNGdBQ2pSMGY4aCtq?=
 =?utf-8?B?VzU3WjBGa0ErRTlFOTRqTlIxMmhRRzRaS1NEcGF0WkcxRERTditVdkF1WHBu?=
 =?utf-8?B?S0ZMUHNxYlhlcFRqMUZuT05mRmdWMnFJTmxleHJUbmc0aGNNR2lUeWFUdUFP?=
 =?utf-8?Q?03dlTjP1PcZTLB4zSgFocr68N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad83ffb-16b0-4874-fe9e-08dd772be885
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6214.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 06:01:02.8937
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xXZTXhlaD2phj5AVMH16ozAovGE0YdT40jCVmvz+CWPqaE8ZDiNk2tmlRrrByH8KnspCmgKjrUZr+v8fD8UsIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301

Hi Boris,

On 3/25/2025 3:26 AM, Borislav Petkov wrote:
> On Mon, Mar 24, 2025 at 01:02:45PM +0000, Manali Shukla wrote:
>> Misbehaving guests can cause bus locks to degrade the performance of
>> the system. The Bus Lock Threshold feature can be used to address this
>> issue by providing capability to the hypervisor to limit guest's
>> ability to generate bus lock, thereby preventing system slowdown due
>> to performance penalities.
>>
>> When the Bus Lock Threshold feature is enabled, the processor checks
>> the bus lock threshold count before executing the buslock and decides
>> whether to trigger bus lock exit or not.
>>
>> The value of the bus lock threshold count '0' generates bus lock
>> exits, and if the value is greater than '0', the bus lock is executed
>> successfully and the bus lock threshold count is decremented.
>>
>> Presence of the Bus Lock threshold feature is indicated via CPUID
>> function 0x8000000A_EDX[29].
>>
>> Signed-off-by: Manali Shukla <manali.shukla@amd.com>
>> ---
>>  arch/x86/include/asm/cpufeatures.h | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
>> index 8f8aaf94dc00..a3ab8d1f5c17 100644
>> --- a/arch/x86/include/asm/cpufeatures.h
>> +++ b/arch/x86/include/asm/cpufeatures.h
>> @@ -386,6 +386,7 @@
>>  #define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
>>  #define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
>>  #define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
>> +#define X86_FEATURE_BUS_LOCK_THRESHOLD	(15*32+29) /* "buslock" Bus lock threshold */
> 							      ^^^^^^^^^
> 
> Please read this before you do stuff like that:
> 
> Documentation/arch/x86/cpuinfo.rst
> 
> Thx.
> 

Do you have concern with the decision to expose the flag to /proc/cpuinfo?

The decision to expose the flag to /proc/cpuinfo was already discussed in 
[v1]. As suggested in the discussion [v1], I have added "buslock" to be
enumerated in /proc/cpuinfo.

However, if your concern is with the name, I can change the exposed name from
"buslock" to "bus_lock_threshold".

- Manali

 

