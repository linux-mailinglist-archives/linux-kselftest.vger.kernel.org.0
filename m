Return-Path: <linux-kselftest+bounces-35282-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60533ADEA86
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 13:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3083A80CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Jun 2025 11:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DB12868B2;
	Wed, 18 Jun 2025 11:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LuDjsGgW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E826120297C;
	Wed, 18 Jun 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750246737; cv=fail; b=VIAYfYduJIBr6KgmMrX4ldqFj3MgttVIPw5d4+YQ+ERMI2ntit6XaQ4AjneE+54OJZclUbzOzdGDthKt4p7cN4eJsiokqMARuIAYuLQiMwt/JcX9hg323hBxiDye08YyQwFYTi832ghaZ4AyTYh0D0xrK7aLJit0EIbIIp5tB+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750246737; c=relaxed/simple;
	bh=8/XROG8FCMcY5Ws4TRe3AwZqA5bIHs9UG8m0dYoXA90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t/g/Ep6+H7MigUjeuSywGpKuUWPHpS2MbPg6w03pO7Nev9mPM39Lu4AStevsNf7esGUeRYGt/m+7FnxjpfyOE6DDyvWyLxLqTYj+qi7xJjz3rHZED/zPB7m1ZUIG5S/YViI/doTsCdN5Wxq1fh73AnjcooUAzhDCMCGTAD8CJ1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LuDjsGgW; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFD7Y4OVPvT3nxyZfDI0ElTF2elwtx8YIMCIJf6S9cBEy675JwAP/WlaRO0u2dIQdwVC9uPVXceiKTd/kIgfoghuDMpAyqzD52K0numGkdPNu/wC7lrh+NMm0U9QiWviUzDSMXyURy7ZtPGocrk/l+TxteQ2P7w9mP3sgMU/VFldlO3jYEsB+t2F3OBzCGcC4b0mnNF4fNY8Id3lGM4DvLQKaP/k2VFWxR+xJ4UHaSlVIj5OLAGtgH68bzZf7kRrCEkma1Mkm6djuWZQbPO/1vd2RGsxaDLRm5T+JmxPU/MWVEltF7fDxkaODT9jhApbQEtu8hIxhbLOjwBNeHULfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyK7aFbfIJmxRJ74o7lPPPsZYDMJKVCK3kWM5kvTckU=;
 b=wtPQRcTyhN+LCIO5VZKw7uTJGLcGKrwfnc4yGeTdxfk1unhljqti0yZ6pP7nxkvJTGdKywtKNyzLBXI/QzS0ZpuBlJGYndxTn5L13sn3GG6uHp9Zfg5QliOMCAz8yuG1bH5eXfbGlqDCyzcEx/z8M1XyfHLsG/PiCYY+SzsonuO/Kz1heshbRfumIJLuxlv9722qJD879hftM534k78TgL4A1PYUxZV1pj28EOsPzl2LjCFiWtzW58GK2M+vXFAF8PW1fmnGUY8JhVKqVpRhH5Ygjq5bDX44nd8N2SnbaBCHo0TIeAqGS2AX09f0M6S2ugInTWqS1jfOphDYhPa5MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyK7aFbfIJmxRJ74o7lPPPsZYDMJKVCK3kWM5kvTckU=;
 b=LuDjsGgWbpUxXkyJ6KtyQ0LM0fK5dKEH36guRx0bd47F7aw92bIESXqQr9to11RxAmXXFbnkoQXj/nKJ7BzWdDdAwZpieGmxizrs8+Wx6uRWAKV9x8ezSLA6aelfys8xnQg6bqxfY8bGFrZP4ShhYqEzcezAACj6rvw+MjPXWSoOpj54iPdnxMuco4GZIe8vxSPOSLfyfgzUrGEUN8EFKN8Dx2I0UT4DsEklvt1Qvp9junV2yglr1I/Uh6boRd0gBzDjcPTdWjvKdkgToB+KRE0M+xNWvOOubM3/8JJVjDfPELcPg7ZjZmv6v9VZjeF29g0pquuDoC8Q96R4A+RQAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.32; Wed, 18 Jun
 2025 11:38:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 11:38:52 +0000
Date: Wed, 18 Jun 2025 08:38:50 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <20250618113850.GE1575786@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
 <aFDMoMX8eL7azoUL@nvidia.com>
 <20250617115948.GV1174925@nvidia.com>
 <aFHc3UujzDIfmKeT@nvidia.com>
 <20250617230136.GC1575786@nvidia.com>
 <aFH+cUSi1GITvF3F@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFH+cUSi1GITvF3F@nvidia.com>
X-ClientProxiedBy: MN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:208:52f::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b5b7d2-879e-4a31-9972-08ddae5cb2c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z3h4cXZDN0FFUEpITUhNUi9tdGo0Q3VUOHNVZ1RjYy9GZy85OTJBQVZtNGN1?=
 =?utf-8?B?V1BXbmhIeFFvWjRDWmZqY2xLR3dwOUlMQ1FyNWVuQ09ERUEyQ1ZZZmtYTDg2?=
 =?utf-8?B?K2pTRzhhdGZNb2FPMUllMkRRdDZHVEY3amV0NWwreTE0NGlaNkN5Tjh2S3V1?=
 =?utf-8?B?TExJUjI0WldFbjd6UmxsOTZnQkxjMGVobkdxdTFOUzhOdkdhTXl4ZFY4bHVl?=
 =?utf-8?B?SGVmOVRMR1ZFeDVSZFMzRmRkUUtLdDV3NG5XRm9kcmp0RnlzYlUva3ViRkFY?=
 =?utf-8?B?TkFrVTB4MFREd2dQWWFBemtwZmVjcFdKS25wRDdDTWE4RC9FcjNpVjlFcTJZ?=
 =?utf-8?B?L2F1dzBaT2E2cmVQMGE2eGkrYmxLWEV0akpBbHB2elg3VlN4clZRVFA0ZG5B?=
 =?utf-8?B?ajdycWlENnNGc0tPSkhaQTVjVlV0WTIzN3A5SXdjYTNyV2JaanBNS0ZCSmJp?=
 =?utf-8?B?TWtHZS9OWHNlTlFQbUpodDNpRVUyWVVEbjhRZ2NEVW5uVXpNc0JZQ3JRQkxJ?=
 =?utf-8?B?U3hNYnA1T0RzWjNKUWxxelpwSlA3SVYvRGEwN0RUYW4xUlY1eXlzREl4aEFK?=
 =?utf-8?B?dVl0dXlKakRRY2REbExOVGxuWkxDbzFMREtGOWdsc0RyZFVaWG9OU29iaEpN?=
 =?utf-8?B?bkFkeGRRekxCaDgxVlV1a3g2WmYzcUM1ZnovQ05SNS8zVFBrU1RXSkY0ZVpP?=
 =?utf-8?B?Wnc0NnFTUWtWWllzWk42WmdwRlNwQnVZdVpBb290YkFYZlpiZE1rd0l6SERM?=
 =?utf-8?B?WDBGVmk4bmxYSXhSRlpvSWxxK29aREZOM2FRRUkrUTN5WlptSlBZNHBFTFRz?=
 =?utf-8?B?VDNVb2x1cG5leThzTkk4eEl2SFlWdW94U2JvdHJWdXFKbG5uYTJVV0hVYTdN?=
 =?utf-8?B?eWQ4Snk3a0F3MUV4aDcvZjF0RU1EQ2NYck5IeGRaOExHVEJNVDYxMXpZZE9L?=
 =?utf-8?B?VG13VWNjVUdVZHRKMjVFaXcxMUtaM2c1MzFKS3hZbTkweGFiZ2FxNnZ1Rnkv?=
 =?utf-8?B?M3lUUVVBQXhkMUZUSHl1aEVoUDZDY3hnaWY4Q3VGN0drSnY5K1EzQVpmbWtM?=
 =?utf-8?B?aGtLaWxONHNXbExxMk5hcVdicVNkdmdxK0ljdmM0bms5ckdtT3FkVTYzcnNl?=
 =?utf-8?B?STM0citCOTJoTmRlSTZRVy9qSGVvN2EwdFNtOWg1WWhHVUVSTWovMVpObXlw?=
 =?utf-8?B?UDZTYlh2QmlZbXFhZnF6Q01hTzMyL3FiOGhPZ09qOVVBeFhkWDRoODJoVU1C?=
 =?utf-8?B?UlVpTXp2MGxEZDRFbmE2cnRsZTJlWDNGTUpQZGNrVzVYWS9IWHdtTmtkci95?=
 =?utf-8?B?NjYwOUJ0b21MeVB6U1JlMkdmL3hmUHNRai9Gd2FlMitGSXNmL00xbkt3czVY?=
 =?utf-8?B?TWo4WCtRVTc3L1VITWlDZUxIblN4TlJOOUVpTms2NVBCNER2amRqV21sUzBF?=
 =?utf-8?B?dFpKWWRidWUyb1Y0NmxKalVpbDBMOUhUeDBINnNINENxWk5VSjlHeE10NTEw?=
 =?utf-8?B?SjlIbFpWVlFCL3dzbzhUWW9OSDRvYUtDbHVqZFFPcGk1WGtCcVlDRXNYL3Jx?=
 =?utf-8?B?WVlYSnNvandkNGRHVE8vOTQ5VDI3amNGeDdxMzY1aFFNbE9XTy9VK0NSZXlT?=
 =?utf-8?B?L3QvYjhlQi8yeWxTQjljeE1tQlZUUWpmRDlidFRTUzFrWVRRc2VkU0FweWRH?=
 =?utf-8?B?ZTdqcEx3dEVVc2grRC9iSEtXNmJRZlhUa0wyQUVuNVNDTmhJdDhjcnVCNkxO?=
 =?utf-8?B?dHJLU1FDTnpQbFcyTmJ5bngxRlMwK3Zobk1neElZRzVjdWZiTm1ZTE5nLzk4?=
 =?utf-8?B?Z0VsaDV6ZmJiMk5NVHk1c0dudU41OGNiekdwdE9xaDJnU1V6bCtkNmc4YU9S?=
 =?utf-8?B?Q01aZmY1TVZhS3NneVJXWGNhY3p6VFpuYnZNemZocW5Vbnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0RwUFdSSGpXS2JKR2tzOWRyTWdZWVk3SGNPNjdSNFFIQmdJR09vUnpOVEhs?=
 =?utf-8?B?VC92UEx1VkowL2E5eVBPNEd5ZEc2aGVjVUxwdXc3ZS9DU2huamN1Q3dxTDZ4?=
 =?utf-8?B?eU1RZW41cTFEVUVpWkdkaXZSOE1DZmVXTzF4K0cyeTRNa2lRaTJ4TXdkWXM5?=
 =?utf-8?B?VHZsS2ZhR3U1UWgvQ1pta09uK1R4SEJtdm5YVVJoY2F4aVhuajZzejZtdzV4?=
 =?utf-8?B?STN1M0xEZ0QvUG1oN2VDWXRiOWVZUDEwbkU1UEFWT0JXT3VqQ1I5aWlBUWdp?=
 =?utf-8?B?WEo4MkpSUVBLN3Y5RGRraDViak9wOHJPYVZVeHE1OGlZUld3YXZDaFhlTUZT?=
 =?utf-8?B?Zm12Sm5rYnZzU0txTCtNQVVaRHRDN3VUNkVjVEhNMFNacTB1OUx4LzZiN2RC?=
 =?utf-8?B?M0ZPNFd2YXRxZ2FwMFZoYXlwUURBd0lRSE5pMmFKakEvV1VCNnM4QjFJTFVr?=
 =?utf-8?B?WVliNG5xZnFWWGltUnNuNVRXQi8yQ0RKR2JLMEsrSHR5UVFEVi9XWTdjQzZK?=
 =?utf-8?B?bmFUT2J2R00xb1JUWXJhYUFGS1RqQkRRYzZ4VnVlNWg3S2JpQnRkUlBuclJW?=
 =?utf-8?B?UTFiRHpFZElJMWZ4UEFPMzZ4V1NNMFBBSlZYblMwdWJ3S1k4QklORmhFNEdN?=
 =?utf-8?B?V0FWb09EQnhYdHFQdVA2bTFxNXVFWUQ1cW40TzArdy9MQzErQzdybnJJNXVy?=
 =?utf-8?B?Tlhsb2hzY1Z4T3Q1dFcxeGlibWc2VENmcy9BWENZbnNUMnRUakRScTRjZ0U5?=
 =?utf-8?B?aGdlUW8zMklWL1ZtdHdUSXhiU3dvYU5IcGV5ZFIwOUJMcVM1bVNiRjQ1aXdG?=
 =?utf-8?B?d0djekQra1dOS29EVnVSeDY1akNPWmxUeFhRem5rR1JNT0RURFlSaS9VaFQ2?=
 =?utf-8?B?cW9Rcndxd1AyWjR5UEZRUjJoRG54YjlnMWN0OE5IUk94MXBZMi8xWHBpa09j?=
 =?utf-8?B?cWtOOUJkdmFmSUNGYVJaLzk2bXZUbkROT0NUMFBjMlhZNzFuUHJGQXFaOHV0?=
 =?utf-8?B?VEg5WWs3STJsc1VFUExjQUV1TVRTWTBGZDZMM2lSMW9LbElva1p1cWw2QkhW?=
 =?utf-8?B?RGZkZUFqUEM2eUFTNWlVdTJPUmJVS2h5RXl0R1VhWW05T0tPbGZhVSsyZkQx?=
 =?utf-8?B?a2w5Z3hweEtDK09zY20xVVlyQ3g1UmtQOFJxSXdTcnpKOUM4SFF4MU9aaHB2?=
 =?utf-8?B?QlNWempzd3I0UTd6OUlVcy9KUTRRMCsrOWNicmFScG1yYlBKK0ZDZm43S3Rp?=
 =?utf-8?B?YXJBRzZLdVkra2FiU0YyK1hnYWF0d1lSTUJqNnJjN25YQWxuNFE0ajRPa1V1?=
 =?utf-8?B?VlgrMlVReFRiOXUvZWdzZXMzY0c5YVNjbFhIUHZFbFVsQzl1YmNVWkxBUmZ5?=
 =?utf-8?B?M1dCVS9tRFpDbXVqNkNpRHg2QWJTa1NNZ09hNDZ1VktaWGRKc0xCM0lNZXVP?=
 =?utf-8?B?R2txZWUzVGs5OEh5cmJkeFYvVmNTRmlOdCtSSmhzRnJFZlU4eFg5Mm5oVUVP?=
 =?utf-8?B?cDRUWGMreTYvUmRZT0dCcnMwcCswYnBaRnl0alFTaVBBeHp0aUlWRGtCMFBB?=
 =?utf-8?B?UDNZcWp1MFo1b2hIaGtZVmZlZytOM0t2alpOTERUREhGQmY1d2xaNVJKb2No?=
 =?utf-8?B?bm1aY2RMb0U4QTAvdWdBaWwvTzRqT1RGMEg3cWtvSHBFdmJyRHo5emllcDdS?=
 =?utf-8?B?TFRra1VtWEsvMjJ1b0xWUFdsNjgxMXpoV2NpMjBWRHFFWXBLVDZtN0dSL3ZH?=
 =?utf-8?B?MW1rdVpBdFJwcHllbGQ5Z1F1bkcvMi9EajRwOEdWOUZJSHJRRzdTbStlYUdX?=
 =?utf-8?B?S3ZvVko1WUZhdzRWcmxaT0l0SDZOKysvYkFHN0Zac2QrS3ZIMHVESEk2VlFE?=
 =?utf-8?B?VHhIVFY4WHpIT1c1c2ZNWDY3UHg0ZFdaMUltRHpjaWMxeEQrSGFJMDdWTzdK?=
 =?utf-8?B?WmVzMnNlRHFuaEI3NUpyNmdBa2lZQmR3RVNhZUdxNTZHZS9GSTJRZEdMd2g4?=
 =?utf-8?B?K0NjUk80ZGdjc2l5bElDUlI1V3kwVTlibm1mNy9FbzliMzhVU0pLWUNNUnZK?=
 =?utf-8?B?MTFRVi9wZFRtVVlxbDc3bDZ1RGFSalhPQk5aWTd0ZElmV1BzTkNibTdyK2F2?=
 =?utf-8?Q?hJHi8+e5mwDwV78GwVpwRZCxG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b5b7d2-879e-4a31-9972-08ddae5cb2c8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 11:38:52.0109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2ADaXKbyN8RLM+lSaZVsdHqKS5KtBHFo4YFIswGyRQnHJgElOB1O8e9a0Qe0Lda
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007

On Tue, Jun 17, 2025 at 04:46:57PM -0700, Nicolin Chen wrote:
> On Tue, Jun 17, 2025 at 08:01:36PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jun 17, 2025 at 02:23:41PM -0700, Nicolin Chen wrote:
> > > On Tue, Jun 17, 2025 at 08:59:48AM -0300, Jason Gunthorpe wrote:
> > > > On Mon, Jun 16, 2025 at 07:02:08PM -0700, Nicolin Chen wrote:
> > > > > ---breakdown---
> > > > > After `posix_memalign()`:
> > > > >   [ posix_memalign() memory ]  ← malloc thinks it owns this
> > > > > 
> > > > > Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
> > > > >   [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
> > > > >   ↑ mapped
> > > > > ---end---
> > > > 
> > > > Yes, this is correct and what we are doing here. The allocator always
> > > > owns it and we are just replacing the memory with a different mmap.
> > > 
> > > Hmm, if allocator always owns it. Does that mean the munmap() [3]
> > > will release what [1] and [2] do (allocating and replacing)?
> > 
> > No, munmap doesn't destroy the allocator meta data.
> 
> Should we do something to that meta data?

My patch calls free on it which removes the metadata and might munmap
the range (or re-use it, but that doesn't matter)

Jason

