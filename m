Return-Path: <linux-kselftest+bounces-35206-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0F4ADCA50
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 14:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D22B7A8FE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618DA2E06FA;
	Tue, 17 Jun 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NZu+bvPO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DDF2E06C8;
	Tue, 17 Jun 2025 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750161594; cv=fail; b=JCRuOy1AkOflQNLhZPzWCp6g30k+8bdBHH1bBxQ0a2DmDMdSgyMZ6IAsJgcWIHCVB7D/CwPRSLriOUaKwl0WCIrPbhEQD5e0baI4SQjyOS8t9NO1fs9WuVo2F3xlWgBd7t1KO7mhBuYTFC1UGVa/Voyl/4QTcZy0dCPk2SnLsE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750161594; c=relaxed/simple;
	bh=H3kSNJ8022yx/ltMSwm82qCjeXksWQwu+cAsnC8SfFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sKLl0cdQsybQIPa1ILc6WIWsGSghF7hfMeZ+dkEwQ26PPbJNNXaNRAER/909qM6YW69tXMGIrqJ20VQj+GV/um2p3iA0GhhlKCxdfLkhgeMdFryZnxxRXYvBX04Lh0ijniBoF5ypBwJTjqBu1CMQy1lUS/zrb2JXQRz/Ep/cCHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NZu+bvPO; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZF/DhnVh9cKvLeF6qdqc0iE4cS5O37kt2fdOzO6coQeiwRWsSqhfoHwmTgkkIQ3pTQl63LDFP6ETPeBrBAy6ztHlfJXDm1rpZ1T2jRd6SlLhvb9q9zzLsg2kNz/E67FW1HZiY/awnuZkgD6Vkln3zwJklETxJ3r26VLgNLW+ZyQnKl/SGqvL7cxnARb9Q6Vk3tmbuBqGd8/De5y2XkGN99kEtRzu00BeaSeZWg2xeLYmGrf3nGNZ+V8xrFge5kmxLXGJm55THoHiNIKDOFGAa/KzJnascQI//PoP7ZTelHb4ZH8vm1vDj50dn3Nj8x3xLuoiNcJwQ6hzxdjbJFqtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dX+e8fBz6wNU4+sZu7h41JuiAF0gpFoLGe12JqE769g=;
 b=jaJQTdsJ3GwtJmFNZ3txMU5ZZNWj3n4myWa6vzijccz7wU1H2w9TpTokFYEOnEbsoO0ZYbbVYh4z7D+krKUF1Xr7YgbIaxLAYnAZRRmg9zMp3rj8MdnyKbrLPBeT7FK28hcs0VUD3yVo3dUgnQ5a2LTbjEziwrMDuC8Yn4vdvMAIJe+gIIWX+94clDsu+/dyg2NicMSvMDVX+CTDZwST+Xq3D08jmW3LkPWVmqnn516pID86J63KaeX/ruArKHY74H8RLMRCEqa7RuY3DZ2vJ3eiHov+XFrpjXLrRQX7P7CMMvz903nkhK2NgqmORfs6wytksUPqziLrp5vJpYjkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dX+e8fBz6wNU4+sZu7h41JuiAF0gpFoLGe12JqE769g=;
 b=NZu+bvPOuHFSXnd9uTeBWMbi7pTlNHCw/Rg0Udc3pGV1WZRkKi0Ein8STUbnyhOL4oDH2ZorfCkX3wYJ93ee84uJ2ci4KaFcMxPzhWRgrCiAhD5sTEUdXbqkmSXZZIQhw2Q4K3Zj3VM7B0OxVrb77fN7VZhbZYo5qJwoHDOAHMnYF9ZUHa7hr5sK5dkRhgi84JnVlJ92hTUkvdufEy++6YyUdvZbAo/361//qlPMlxBnQFRtQoVyljCbmQcAj7y2ih9ZmwrzvxJICzRomNd1XNWctdmifyb6CdCVUqeQtTuFNrbW1xP8GSRU8XrApbLklbCQDrf56vgqQrrzibz2yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB7583.namprd12.prod.outlook.com (2603:10b6:8:13f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 11:59:50 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8835.023; Tue, 17 Jun 2025
 11:59:50 +0000
Date: Tue, 17 Jun 2025 08:59:48 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, shuah@kernel.org, joao.m.martins@oracle.com,
	steven.sistare@oracle.com, iommu@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de
Subject: Re: [PATCH rc 1/4] iommufd/selftest: Fix iommufd_dirty_tracking with
 large hugepage sizes
Message-ID: <20250617115948.GV1174925@nvidia.com>
References: <cover.1750049883.git.nicolinc@nvidia.com>
 <9515eb5cb58bc8dfec083df51550bd9ae6d60da9.1750049883.git.nicolinc@nvidia.com>
 <20250616162501.GN1174925@nvidia.com>
 <aFDMoMX8eL7azoUL@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFDMoMX8eL7azoUL@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0410.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::16) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB7583:EE_
X-MS-Office365-Filtering-Correlation-Id: b900efcc-3dc8-4150-fe73-08ddad967641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bC9BWFlEMUw3OENnb1NybXRjWXFHWTZqMFR2Sk42dlNLL0YzaU1RRms2a254?=
 =?utf-8?B?UGdTMEk2eUVEb1dsaXVnempNMTVXRCtFaWhNVXE2L0c1NEFMQUlsczFDK3Bn?=
 =?utf-8?B?WGtlOXJubGZNQzd2Z3pMMERkbnFhdHNOZVpHMUh5cFV0SHh3TS9CVUZ0SWNI?=
 =?utf-8?B?bVRUUVYyNUo1eVdYVDdBeHppdkpHeHZ0RzNBSXhVdWFETTd0bGlOSTJla2Ro?=
 =?utf-8?B?aFAwV1llK3g1QkZhTXFQdS91cnJrbHZtWVk0UXFhTmo5N3NaSGtrczhCc0FF?=
 =?utf-8?B?R3M5N1JYaXh3UDByK25nS2FnZTZLMHpEQlg2SzNuemZ6MFB6NG5xaFg3elpX?=
 =?utf-8?B?dUFEQkRzQTdqTy9rWmhMSjV3RUpzYVAxLzkyRkt0UXljS2tDTDNhYjRGTDVQ?=
 =?utf-8?B?ZjFMQUxhVHJUaGhJOUVHUWVld25yV3NFK081OU5KYVdwREZOSmxTaHN0TWc1?=
 =?utf-8?B?ZWRicVQxdHlBaEkxcFpWZnVhVEV3RjNTOFZ4RWU4aFU5UkVEQzBSamxRNE9y?=
 =?utf-8?B?VzdEOGk5SUZhZ1hwUzhNYnpxVVh4N29OK1pYVlg4QkxUbHdJaGxOQ05aKzBD?=
 =?utf-8?B?QlViQndvMlI1N3Z5eWN3YzMzMmVSRkprR1NKOXMyeDFtSXgySW10Q1ppRnN2?=
 =?utf-8?B?cnFNTlBPRWRNaG41MXM2S0FIYnY3TTJMSU1TK3dFQVhLOHcvV3JXRFN6SWhl?=
 =?utf-8?B?UlhPUnRJelE5ZVpMaVZVS0IwUkZGbXFDeEpqSGVQTFVMUWNBbWtyaFVteUNO?=
 =?utf-8?B?d3IzcXJMUVlROURsMTBFK291RjMycktJaWtXVm13eDBINDFCQWk2cHU5OFR6?=
 =?utf-8?B?THBpclNQU1VkNnVqaEttNG9oekpFTGo4OG9ZOXJPZ3JTSUNLa3l0TXA3dVhU?=
 =?utf-8?B?TU9NMHZGYXpuWittby9ESVZUM3pvakRUWUMrdlRCbW9JWXh1aUJ6cnhYbEpj?=
 =?utf-8?B?STVPUzRraEFvdkVkZmorUWtBOEVVSWU0WmwyRU15T2tWM2JXbHkzb1pGV2Nx?=
 =?utf-8?B?aEJDcWRUbVZuaXlnQlNKN0VVS3pUeGxRM0Rxb0NUaFpUSStidTJReE14VVh2?=
 =?utf-8?B?YXNPUUt4bVdmcmlDNGpVTXRzRXRIUHdMQ2taVDV6UkpoL1VzRlFXc2d0NEF2?=
 =?utf-8?B?UWRpc1ZXQ0xOSFJFNE92UFpsLzJQR3ptNG5zdHB0SUVZWTJEQ3B2N1NRY3dh?=
 =?utf-8?B?U2ZEODZLZXFHRGR1cnErZG1oMXV6Ky9KUnF5VWhwSmNFYkU4akowZDNaT0d1?=
 =?utf-8?B?a3ZpNCtUSGo1R2tuaHJjc1RiSGQyQnJqZUNaMkVBOWtuaXRQbE9zV3lXNHhG?=
 =?utf-8?B?MlpPNEhrZ3AzQTBhblBDSkIvN3FtYVZlSjliZkF5NStmRTZlQ2xKTXIvRHM3?=
 =?utf-8?B?WXBBK0hHMTgrZ0dyN3JreHIvZDg4SlVCODdBdnhQOUhYNityL0Q4bmxuVWpS?=
 =?utf-8?B?Sk1xeElaU05SMW5Kb3lPdFpmRndXcUtXc2FWNk5GUlVpOWpud3o2UDI5Zk9L?=
 =?utf-8?B?cG9uc0Vubk1pZjJvTWhRd2ZZaVpkWVc4a0cyTVR4VGsyaEJQUGZiL041bS8w?=
 =?utf-8?B?Mnl6bjA1T0ZEaXlzbUp3eGhWSmkvbmtDak5aZVJPS1JxRnhQQjZqeU0zUHNu?=
 =?utf-8?B?UWxoenpJTVpKRTZTWHpEdzhtUjZYRFRVQjBvbTVXNzRtWk0yb09DUytPcGtq?=
 =?utf-8?B?SmtPbGdwVGlvZ2szQld6amtjbkxqK05acTVQeGFpTklJSGpsYzcxbmt2c21n?=
 =?utf-8?B?VUdJNmE0NzdvTlhJY0dTTUJRSWJ1M1V0SFBhUUNLY29oWlVBSXBkaGxxQzNU?=
 =?utf-8?B?RDBodWsxaUZhdzFOc0VCaFVORGN2VG9BR1B4akhkb0FJVWlRUXQrMFRwRXlt?=
 =?utf-8?B?V09SUUpiR2dPaVZ4WmgrOGswNUV2eU1Dakhwem5oR1JpRHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDhIRVc5SDlmeHhNLzBhZkR6Z1ZVYWxob2ZyUVVoSFR3Ull4WWdvUGxMbDRM?=
 =?utf-8?B?YmwwV1BraFFXVzFnajhCQ0tiQ0F1U3R1dURweWtLUFpwbmg2YSthUHlPd2h2?=
 =?utf-8?B?VXpOd1lMb1o5blM4bi9RaUloT1NsMjlaT0FJMmt5S0lrVS9xNW5nWUtKVEdE?=
 =?utf-8?B?MTRYeHdmOHJ0MUZ5aWZDaEhuQkphbnlmSDhvMVhZSHV6TFNLR1hoazU3aTRh?=
 =?utf-8?B?aWdHbktNWEVuWnJLTXZTSG9SMFRUNGtmSnB0ZWE1Rk1wT0N6US8xQkRmZzNM?=
 =?utf-8?B?emswL29VZGNzSWloOGJzRDJiWWZjb0xoSVNtRDNPUGRBWFkxUlZKWnBkUzR2?=
 =?utf-8?B?dnU5SHBBNm1XV3NXRHpiK0liNjBhYUk0bmpVUXNTbGlnWGozb011QllDWHk1?=
 =?utf-8?B?ckVub2d3Q09NQy90RFdVUUpRQmxRNW9ZOENBWDE4R01FSHgzWjJGTzJBYkN4?=
 =?utf-8?B?UHhITS82K1FlNkh1dkdaR25wLzFlQktpc0hYZ2hvb3R2dnBQT2RlWUNLeDBN?=
 =?utf-8?B?S2dsUVZBTzIwVjFRNFR1MFdPVDdoOUxnak1vcTZYZE92RnZFa2grZCtleTNS?=
 =?utf-8?B?ZE92bUg2Zkhma3J6eGxDLzlKWlE4OXJvVmhwcG1SOHhoVkVSU3B6c1FFOFVG?=
 =?utf-8?B?ZTIrdGQ3NDZ1K3VEM3FrM2NmaFB6V2Y5NVFkazVIaklVZ3UwK0RlK3BUNTFi?=
 =?utf-8?B?UEFxWnhNUFNhc283MjNRWE5SSmNwSlhQeDFrK3IzZ1BianFOckdiNnJYd3Nj?=
 =?utf-8?B?dHQ0dXdIbFZ5VDBhVzJEaml5Vi9qNC9ISkw3NUJ3SmFDWkF0SW91TzBocmlz?=
 =?utf-8?B?QzhzVkVXdDNWUGYzNEtrY2gyL1RoWG9kaFRYVWZoOEJpb1NMTFFSNTRWcXRO?=
 =?utf-8?B?Ym9LRzR3ZnNIRkZGUWY5ekI3b0ljWE8yYStpb1M0NG9VWFM2TjFvNmJ3bll5?=
 =?utf-8?B?SmI3dGM1a0cvb2VrcmdUcG1wdUcyem1TbHcyUEhXa0J2UVVYQW1yMWJncWwy?=
 =?utf-8?B?UlZPbXdhbFNxQS80U3BpVDVicDN2eEE3dklYdlNEZVhCUm9adWRqQi9iZmM3?=
 =?utf-8?B?QzVsOTZhSitQQ05vdUdkbitaQWc5RzZvRnJvT0s3L04vTDFUa3FOV0pOQnNs?=
 =?utf-8?B?YlZBbGFlV2p5REhQWEVKTGIyd1NQaEg3KzQremJONE52SCt2Y3hSUTZTMFlz?=
 =?utf-8?B?bWtGa3JKZ3E4Q2FJUjc5em9KbHJiYUpzbzgzSlUvVGpFQkRBa1V1MmMvSzYw?=
 =?utf-8?B?czY2bTYwa0s4bVpkVmx1amFmQ0NKY25zdmplMTRBOEI2aFlYaWpVclNHVW94?=
 =?utf-8?B?T2VWREhjQVNCNDVkYXpBMzVuWjd3YXVDdUkxSGNJWjJZcFNKeWUyVUIzS1Q2?=
 =?utf-8?B?dkVCaC96cXQ5RERyWHp3d2pudlhKTkRXaldYZWUvek1ndnBmS2R0RFMrMkZ2?=
 =?utf-8?B?U2kzemhHNjdmUnkvT1hMVUd4dlVBaXVMNHVPWUJXbGpKblFDUDVpbXBieVlQ?=
 =?utf-8?B?Z1ZLKzRzdWJlQURlSHBldi92bDhLenl1VlR2ZDBVVXJKVW03SjFUdnlTdFNU?=
 =?utf-8?B?cVh0alNZeUU3dDEzWHpiMWZrNnVkMi9VSmFrbEVWU1IrTzJ0ZWVhVnc1aUp6?=
 =?utf-8?B?RUhNVmc4amtWSERlUnE3TEpWem1yVDlIdDdqdWZDMjlFRlJKSG5YTXVlWGxF?=
 =?utf-8?B?amRGdUt4QjBuc2VWbTZNZHpabkZMckQzRGxVSmRhazlhSnlneDNRRmVIMUVQ?=
 =?utf-8?B?ZDBOUWV0VjVuaHRkTlhEMzU2RjNSandSUWt4Y0JURTlmeWpkRk9xbHk5K1VX?=
 =?utf-8?B?TElMRTIvNHZuanVvdmVVdjdrYUNUOGxranpxdDRaS0gxT0F1S0ZLRm41Q1Jq?=
 =?utf-8?B?RndxTHNMWnVxbDZmN2hzbTJSQ3pUQ0drZkI1VmRMRWxQSzZxR04rREJFTkp5?=
 =?utf-8?B?YU1Qa3VEN0NIRXNZa21TZ29oSUV2UHlzdGx4eWpXemFtQVhNbVluL1BOVHp3?=
 =?utf-8?B?aG84OHBtbm91OHZEbG1WWFRRUCtrMXNpM2V6TnBtZ09uUnJpbEdtWCtJR2xQ?=
 =?utf-8?B?aGxTT3V5cUg2QVVEYmxsaFBaTFdiN1BJU3h3bDVVVEdNSXJIeUl6SzBiaCtC?=
 =?utf-8?Q?oyTbykD2lo9XgWamPffMwkJOu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b900efcc-3dc8-4150-fe73-08ddad967641
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 11:59:50.0385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KNj6mOzIxC3TA64vMHHjZqtECEFZLtycwoTdeN13mnNOuDNqYso3Xyqgt5FZBpmq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7583

On Mon, Jun 16, 2025 at 07:02:08PM -0700, Nicolin Chen wrote:
> On Mon, Jun 16, 2025 at 01:25:01PM -0300, Jason Gunthorpe wrote:
> > On Sun, Jun 15, 2025 at 10:02:03PM -0700, Nicolin Chen wrote:
> > >  FIXTURE_TEARDOWN(iommufd_dirty_tracking)
> > >  {
> > > -	munmap(self->buffer, variant->buffer_size);
> > > -	munmap(self->bitmap, DIV_ROUND_UP(self->bitmap_size, BITS_PER_BYTE));
> > > +	unsigned long size = variant->buffer_size;
> > > +
> > > +	if (variant->hugepages)
> > > +		size = __ALIGN_KERNEL(variant->buffer_size, HUGEPAGE_SIZE);
> > > +	munmap(self->buffer, size);
> > > +	free(self->buffer);
> > > +	free(self->bitmap);
> > >  	teardown_iommufd(self->fd, _metadata);
> > 
> > munmap followed by free isn't right..
> 
> You are right. I re-checked with Copilot. It says the same thing.
> I think the whole posix_memalign() + mmap() confuses me..
> 
> Yet, should the bitmap pair with free() since it's allocated by a
> posix_memalign() call?
> 
> > This code is using the glibc allocator to get a bunch of pages mmap'd
> > to an aligned location then replacing the pages with MAP_SHARED and
> > maybe HAP_HUGETLB versions.
> 
> And I studied some use cases from Copilot. It says that, to use
> the combination of posix_memalign+mmap, we should do:
> 	aligned_ptr = posix_memalign(pagesize, pagesize);
> 	unmap(aligned_ptr, pagesize);
> 	mapped = mmap(aligned_ptr, pagesize, PROT_READ | PROT_WRITE,
> 		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> 	munmap(mapped, pagesize);
> 	// No free() after munmap().

> ---breakdown---
> Before `posix_memalign()`:
>   [ heap memory unused ]
> 
> After `posix_memalign()`:
>   [ posix_memalign() memory ]  ← managed by malloc/free
>   ↑ aligned_ptr
> 
> After `munmap(aligned_ptr)`:
>   [ unmapped memory ]          ← allocator no longer owns it

Incorrect. The allocator has no idea about the munmap and munmap
doesn't disturb any of the allocator tracking structures.

> After `mmap(aligned_ptr, ..., MAP_FIXED)`:
>   [ anonymous mmap region ]    ← fully remapped, under your control
>   ↑ mapped
> ---end---

No, this is wrong.

> It points out that the heap bookkeeping will be silently clobbered
> without the munmap() in-between (like we are doing):

Nope, doesn't work like that.

> ---breakdown---
> After `posix_memalign()`:
>   [ posix_memalign() memory ]  ← malloc thinks it owns this
> 
> Then `mmap(aligned_ptr, ..., MAP_FIXED)`:
>   [ anonymous mmap region ]    ← malloc still thinks it owns this (!)
>   ↑ mapped
> ---end---

Yes, this is correct and what we are doing here. The allocator always
owns it and we are just replacing the memory with a different mmap.

> It also gives a simpler solution for a memory that is not huge
> page backed but huge page aligned (our !variant->hugepage case):
> ---code---
> void *ptr;
> size_t alignment = 2 * 1024 * 1024; // or whatever HUGEPAGE_SIZE was
> size_t size = variant->buffer_size;
> 
> // Step 1: Use posix_memalign to get an aligned pointer
> if (posix_memalign(&ptr, alignment, size) != 0) {
>     perror("posix_memalign");
>     return -1;
> }

Also no, the main point of this is to inject MAP_SHARED which
posix_memalign cannot not do.

> Also, for a huge page case, there is no need of posix_memalign():
> "Hugepages are not part of the standard heap, so allocator functions
>  like posix_memalign() or malloc() don't help and can even get in the
>  way."

> Instead, it suggests a cleaner version without posix_memalign():
> ---code---
> void *addr = mmap(NULL, variant->buffer_size, PROT_READ | PROT_WRITE,
>                   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE,
> 		  -1, 0);
> if (addr == MAP_FAILED) { perror("mmap"); return -1; }
> ---end---

Yes, we could do this only for MAP_HUGETLB, but it doesn't help the
normal case with MAP_SHARED.

So I would leave it alone, use the version I showed.

Jason

