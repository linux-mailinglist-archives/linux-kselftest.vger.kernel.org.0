Return-Path: <linux-kselftest+bounces-9615-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 860418BE8AD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A670C1C2121D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C39816C84C;
	Tue,  7 May 2024 16:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8WcM/1N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2079.outbound.protection.outlook.com [40.107.102.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F1016C843;
	Tue,  7 May 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098797; cv=fail; b=JfdpnxjjdkuNr3G0WDxs+jiKn4Dex6vPhAd47FaFm62GK+oISadiSmQNsLjIkaGmGU7okQMJTqS6sXNo8Ey/nlA8fG4rBA1hem7lGu8gMfPmlr5//1/FWbYs9PsKAAddof0scHKLnafDTafRrR7SWc66s9QHVrPVxT+3jk3r9iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098797; c=relaxed/simple;
	bh=cbT9YIm0HQalxjXmQUbLcAFYCR5dfqdcQynNJJUDV3k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Hi2PkrKoFBWyqfVyeNU8R3UVdwLEe0JcqKgtz8aMXGG+wYTBFEP17rr4sDGme78cxw4Ge9A8w02RCioiZgVeexSPUt1RnuVbCKtHMVDC/ECDQP18lVeGiMhfyi6RGSfTVfe8k69YmoYexuzdjSnppaJD2HApPXVgXT5YRdAPvcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8WcM/1N; arc=fail smtp.client-ip=40.107.102.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AN9O297Blh6JJWPTtajE15V9gixrofRteRFPgfWv3xVDFhv1mSkItTKN7HmZdJSG4A4iAEz45AFa88k6X5BF+4F/fotGHJxAvnEgXHkgCZxfsogjLnPmIEsFyFoYs6lbKsoipvmSBPaj0MFDKWs2MX5NBj0bA6GSkPJl9CIZj8EsZ5ELiDEWnSShJDJSHuEGwN05uNhvCHtn31+8jdaSYwa+OtJZW0CcBizIF9cfknGMfWTs6LjicxkwGl9x1COfQS0PlFMEkKwML/N8s8Z2oCza08vttjjOjduosF0Kv50iAGxAxlb2G7uX4BhmtUaK5Tfd4CSgAY5WE4a63580zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oN1SacdIHWuy2qXLjIhJuAJybor3QNlM8i1KUAPmeg=;
 b=C0TkZcj3sjMSyftl5c2OhxQhA5ccQq9HWJKwiYDUhK7YURBZiGlPVJIn5WcCUQBDv93mxX1crMJ1B+zPhk+R2SzFAKVzhvtGLO5+lzmd5N72teb9Y39B5MOyuYBYsrxCUWTxN1fD1HVBiBZjOb547JrPOmv+UOdUmkvXKd4zHly7buLiSoqOivUwZDNly01AK8xeFZA4PNVrUg/wOc1NVyfY0+vSb3vRMC3TwyPYjwz4rZFGmQnBVADPRm/7qWBVlFWN7inw826pLJtzxFd0YrBmhCsBrgdMAYxaLhKeGcvooFtqtBW1BoCsk6n7pmkHG2x3w6L1qHXGz6NPO6eBww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oN1SacdIHWuy2qXLjIhJuAJybor3QNlM8i1KUAPmeg=;
 b=I8WcM/1NMS3bAcUwTnHyPzAwmEreBglGfwT4sWOXObCHc8yM9igaorQOqnHWlKcnXXCQVwgt7CHaXFBExbayD1huS56L1sQN2H5CRUpNs/xny4HNkqT7Nwb9pKiXxMvQNwTAq7U1UFc3zVyu4sGLjXLVFs6GttU6t+W1Vxq5DiarjyQhF9IWq4Vkybf2D+23qB0t5DwzKVEyipvLt1tvoyWZdtq3MeNlUvHBMt5a0qQu8FLgaDWWYkDNYMZae6vJpThXuEqBndjqbbDnapJ4hCnWaxp5Kwdm38zxRAUPIVMlMaJKJuxqCcTPp4WYVIi/0v1tyqoHwIE5Dac8QAs4Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by SN7PR12MB6887.namprd12.prod.outlook.com (2603:10b6:806:261::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 16:19:50 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 16:19:50 +0000
Message-ID: <9e346b64-0a7c-4eb9-88c4-8fb6cf65b33f@nvidia.com>
Date: Tue, 7 May 2024 09:19:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] selftests/openat2: fix clang build failures:
 -static-libasan, LOCAL_HDRS
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
 Christian Brauner <brauner@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Alexey Gladkov <legion@kernel.org>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240504044336.14411-1-jhubbard@nvidia.com>
 <8fdefaa9-675e-4b37-9456-896b9989d18f@arm.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <8fdefaa9-675e-4b37-9456-896b9989d18f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0012.namprd07.prod.outlook.com
 (2603:10b6:a03:505::13) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|SN7PR12MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 171f36dd-b66c-433c-3f50-08dc6eb18511
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEJFRjBRbG0vUjRuQUgvd0h6MTVtNlVScjVUdXdrNWcyTDJNODhTRUZuaThB?=
 =?utf-8?B?Q3lQRC9rN09NWW1oNzZ0amdqVkpER1FUTnFGU1RNSHA5QUo3OXp5OWhkWlR6?=
 =?utf-8?B?azJiRjFhRFlrQ2dURlJkd3drL0F2VW9ya0NvVmpmOURuSFFyZDYrdUtQTklX?=
 =?utf-8?B?TFI5clIxQ2ZGZitCb2k1NFZiWTlxbTM0ZHJNazNkcVVjdUlVczJ3OHUyRFVB?=
 =?utf-8?B?aS9jRi80eUloMk9mampGZ1RsODRLRUpBUVEvSmFBYW1udWdoYXRBcHZnVW10?=
 =?utf-8?B?Sk04czhMWnNFcG9PM09ERnNmRWpSc3drQkZXOS9ubHNBVE1MTEhCV1ZBZGIr?=
 =?utf-8?B?S2NNREU4UWk5MkwvQ3c2OHJqQ3ZySGV6Ym41c003ZFFVY1dGNGZCUCtZeko4?=
 =?utf-8?B?Yi9QeHdaQnQwTEdRMC9xQnFCclVsc2Vxd1ZmRnpvUEV5bitFamVqVmRMQm01?=
 =?utf-8?B?djlMWjBCcHFoQVFhNFJMRzYzTjRPWU9tRzBwVnJoMGl5RHVIeWpsQzBmTFJR?=
 =?utf-8?B?NUZJenRkRzcxeEZNZVkxVlVpaXBpNmZPMVJFdThuUm1Hamt6cDlIUkJ1aVYr?=
 =?utf-8?B?K2FNVkxGQTNkaU5XMEZrRVN2aDFvaTF0QXJROGJLNU9JYnNaSTJleVdkNFFh?=
 =?utf-8?B?enZYTmIzQ1NTZHpkY0lxcUdkenB0WCtyZlBQbW9pMVRzWnZ4NmRndGFuRGJE?=
 =?utf-8?B?ZGJQb2wwYTBkUTNROVM2Z0ZmUW5jRkp6U28vem9oWjErb2dtTmZoWEMxaFFW?=
 =?utf-8?B?U21lUGpkMFI4MTg4ODJGVUJvSWVkSlJaeEU3bnhNZ2xKemRmbStHUUdFMlhX?=
 =?utf-8?B?bDhJSExwRW0yaEp5MldaRnE0bWNYWTFOeTUyQWRUdTl1ODBRTmwzdU9ob2tB?=
 =?utf-8?B?YzlUUjNQSXZuOXJXZkcyQ1R4ZW41L3hOKzhRaHRKV2tDWDdBR1RqRnZad3cw?=
 =?utf-8?B?WkNWWlA2OThBRnFmYUxWOERvZHdMNXJkNmllVFRodXNOQU9DdENkYlFtRzJy?=
 =?utf-8?B?ajQ0cHBDcDE4THFpazFQeDVzWnhOK05sRFZCNFVxL2V2L0EzR01BcUdDcjhB?=
 =?utf-8?B?WENXcnpGVE1rcCtsL3ZidFJqSlJvSHc2RTl4VmhKY0NkNzJZTUplb01ESHgx?=
 =?utf-8?B?cnFiWW56Y3NPZTFUOENoU1pvSjZwNS94MHh5K0U2Q1RqUjlSUFVDTjgvem1S?=
 =?utf-8?B?dUNMNzIzL0pSUlVEeG1aNTNZeXdVUFdlWjVxSkJMTGNMejczcGd2ek5vUThV?=
 =?utf-8?B?MWxIZFRUSnY5dlFoK2ZkM2pmdUJYUDA4cXNtYVVIRitzYUhVYkxNUlpSTmw1?=
 =?utf-8?B?Qmx0bGZSQWhtMHQya1ZXV3dQRndFWFVkY1RUUjV5d1Q5SXI0bjM0MUJNeHdS?=
 =?utf-8?B?V3dmdVdnRGdRcGkzWGk4c3hlRC95MDc2OVJUWnAxT3Y2cTNmREk3YmVjZGFJ?=
 =?utf-8?B?RTNPZGp3L2dKMmY4VzIweFBSMGd4ZTJITk02eXRXMStOOTZxc1VOTXVBdE5C?=
 =?utf-8?B?VmZ0dHJ2dkFTT2p1L1A4RmgramxlK0oxaG9mc3k0STllVGdqVUNkbmtJNnB5?=
 =?utf-8?B?OU9VRXJEdnpvTnNTQkExNms3aUVFMHk1L09kTFpYNGZMTnVLM0h6NnZ1Q3oz?=
 =?utf-8?B?V2Q3dENXMVZUY29hSXMwMHU4cTBPTmVFOU9CQTYzWG9WQjY1QS9lMGZ2aFNp?=
 =?utf-8?B?ZVFjVWgzV283RHJRZ2h6dHVJb0VxeFBNeTZsZHJzM1V4b0xGWjBkUGw5anZT?=
 =?utf-8?Q?0BovV4+v1dQy907BlA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzhvTnFLbndJNnI5OFNJOFhRNldsaTJnWFU3MUZZOU55M0Y5ZGN3Q3FZb0V6?=
 =?utf-8?B?TktOZnVHeGxycGRhRXZUSzJ5eTVQdDZmNjJyT1ZNcit3OVZmNlV0eTk3Mndl?=
 =?utf-8?B?Z3F4czRDc1FSa3RSbWpUUDVVeVVSdm5tVTc5VSsxbERGVDgvK1lwZ1R1MEYz?=
 =?utf-8?B?OTdtdFhYMXhpY3E4MGRlYmV0UjcyOUdSTnNyNkw3am8yT1Qvd0thTVF0eE00?=
 =?utf-8?B?TXdxMWZzdzYza0gyU2xkS2xraUlMbDI1YUJiSHRLMFBJTytQM2lUWnk4Qkg0?=
 =?utf-8?B?b3R5YXU3dDM1K1NUMUZ4cmlvK252TWdKa3pzTFBQVlFtT3E5RjdsZmxrSEhV?=
 =?utf-8?B?WmhuSDBiWmRWNXpuaFBFRUV3YTNwQjJQSWF2YmxiVmw0bi9abm8xd3p5bHlW?=
 =?utf-8?B?eTRLL2hlQlNaTE1yNUR5OUdsQTcrN3o3djVTaEdNTlFaYXJxYm1aUVU5UUJE?=
 =?utf-8?B?NFJQaXpuZ2JVSFVsVDhGbGM4dWVYN2g4SnBucHU1dGptOElZclRleXg3ZW1i?=
 =?utf-8?B?YjFsaXBzWTFyM2lJVDlWbHVSNXpoKzVZTVFRRG1zTzBLQlFReGZwQ1JZWC9M?=
 =?utf-8?B?U0l1bkpYV21LTVVZZFZXdy9OZEIvaUQ1ZnJObDExeUUzUnczdGpBM0dYNnlS?=
 =?utf-8?B?bXJwamZzTmNmZDZZdzU5dUp2OWE4bW4zdjNuSU9vMCtPYzlHcFRhSURzNVp4?=
 =?utf-8?B?Z3gxRTg1K0FoZ05UdnVyeW1XNjlpVnQ1T2tva3BnR0tQMGhFQTFRQmtadkRM?=
 =?utf-8?B?OFIvRXpibVV5anRaL3JndVpHUzZWQWJEdkV2d0x0c1lEanFYTFJoMXNSZnV1?=
 =?utf-8?B?RG9SdGJRRDZEUVJ0cWRyV0w4aVJncCtUNVJsWlBOc1JmYlVpRmpGSkRZUWdt?=
 =?utf-8?B?eFZCOWZSQ2lmRnB1NkNXaDhaWTFiTWxFRG91Ny9Hb3J6WFppT3hIMUVodERs?=
 =?utf-8?B?eDJ3MFRLSGVVV3UyTG9qS1FYRG1KS3JCdDB3WlNDNHFTcGdKR0hwRDg2SlBv?=
 =?utf-8?B?OU5ybG4vRVgxdTl3a0JnU2hQa1dMMDlkZDArc0RLdFJOOG4wTTBXbVNRYzJv?=
 =?utf-8?B?elJrQXQzV283ejMrOVhab0YzOEN6aUZaZjVPT1N6TVNRT3VSMlpmaTc0YkJF?=
 =?utf-8?B?eDBOTXdYam85QXNRNTRRQzZIRWgxTVdNbGlWN2s4Y0ZmQjNtVStST0JlMnE1?=
 =?utf-8?B?Q2NsNmoxL0thY2JnUExSbGJGWjh3VytNai85UFUzN0FDekFpeFhiVkI2UXQr?=
 =?utf-8?B?SUJOWUhzdnpQa2FKRmxrMzYwS1FsbjJsMDFXYzMxYnFvNkVmdWZHWFVEWDhD?=
 =?utf-8?B?eDFvZHo5V2pHN3J4ckFBNzNZSnh3Sytwc25PWVVQYjBGbmhxZkZnYkh1MmdC?=
 =?utf-8?B?V3hzRTFpK0MrbGkzT3RoREhET1NRNDk2cS9mQjRGc2tRbjFzYWtGai9ITkYz?=
 =?utf-8?B?MHpwdVZqdjVwb3dOVG5Rb3h2MnlUMk9OYlVUYUFHV2Q5aTNxUXBoM0ZYYVg3?=
 =?utf-8?B?c2NMbG9FeStoU3MrZFcvRjYrYzNiUno5RHc1ZlEreGhtdU5RZldVbzcrRlUr?=
 =?utf-8?B?dVhJc3JuRmYySitlVVJnNEsrbVlDZ1F4YjJ1YzhNQ2ZrTlUwTDRKVXZORnBm?=
 =?utf-8?B?VGw0UGx0VklmL0VNbmYrOVlEWUFETnlsT2crS01ldjJKOVljc3ozMVB5TFA5?=
 =?utf-8?B?TWszSW1Mc1B5c1ZoR21MNTA5RGhIZ25JR3c4cnlWVnJaampxSEY0eW9QV3lS?=
 =?utf-8?B?MTdmUnN2VkFpMkxLZWpVNGM0c2ZpVnVwNXdyMU1uUHlMRzdoRXZoNllDR2xn?=
 =?utf-8?B?T2dPWW45ZzVCRzZNbkRiOXNYY1phUk1JSTlUZGxmNWN0c3pQL2ZndXV1OXp3?=
 =?utf-8?B?dldJa29CdXRZcjRXOGhvSUxUNmcvWGcreGpCV1NVay91blY2WE1sbDhXT0pT?=
 =?utf-8?B?cVJZaEZUZlhRMEw0cDJQdG5wLzhnSlU0MllGL0pjWkZEM0xBREtBUHFrait5?=
 =?utf-8?B?Ri96MDJZdDREN3AzRE5xM1htK05RazFaS1lkWFVGMHFTakQvcTdrb0x0LzFJ?=
 =?utf-8?B?Vndib0o3ZmRVdG9zRktBRWNmakRlNGROZndPQ2JJTjRIVUYycVZmK2RUV25l?=
 =?utf-8?B?dE5Ba1RoOUpORFhIbDRFNk5TeXhSOHJIVEdpcWJOMDFZL3Rmbmt3eG10NEh2?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 171f36dd-b66c-433c-3f50-08dc6eb18511
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 16:19:50.2367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 59vC3Wn8chM0lf0p1qGnBMfFKxTteNHg+1tKPiENtiEgaCwF/3wacTH+6F0M4zeakmLFditMm4Ch2RJiDX45KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6887

On 5/7/24 12:45 AM, Ryan Roberts wrote:
> On 04/05/2024 05:43, John Hubbard wrote:
...
> Hi John,
> 
> I sent out a similar fix a couple of weeks ago, see [1]. I don't think it got
> picked up though. It takes a slightly different approach, explicitly adding
> -static-libsan (note no 'a') for clang, instead of relying on its default.
> 
> And it just drops helpers.h from the makefile altogether, on the assumption that
> it was a mistake; its just a header and shouldn't be compiled directly. I'm not
> exactly sure what the benefit of adding it to LOCAL_HDRS is?

Ah no, you must not drop headers.h. That's a mistake itself, because
LOCAL_HDRS adds a Make dependency; that's its purpose. If you touch
helpers.h it should cause a rebuild, which won't happen if you remove it
from LOCAL_HDRS.

The way it works is that lib.mk adds $(LOCAL_HDRS) to the dependencies list,
but then filters precisely that same set *out* of the list that it provides
to the compile invocation.

The other way to implement this requirement of "some things need to be
Make dependencies, and some need to be both dependencies and compilation
inputs", is to add everything to the dependency list, but then use a
separate list of files to pass to the compiler. For an example of that,
see $(EXTRA_FILES) in patch 1/7 [1] of my selftests/x86 cleanup.

[1] https://lore.kernel.org/all/20240503030214.86681-2-jhubbard@nvidia.com/

thanks,
John Hubbard

> 
> [1]
> https://lore.kernel.org/linux-kselftest/20240417160740.2019530-1-ryan.roberts@arm.com/
> 
> Thanks,
> Ryan
> 
> 
>> ---
>>   tools/testing/selftests/openat2/Makefile | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/openat2/Makefile b/tools/testing/selftests/openat2/Makefile
>> index 254d676a2689..185dc76ebb5f 100644
>> --- a/tools/testing/selftests/openat2/Makefile
>> +++ b/tools/testing/selftests/openat2/Makefile
>> @@ -1,8 +1,18 @@
>>   # SPDX-License-Identifier: GPL-2.0-or-later
>>   
>> -CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan
>> +CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined
>>   TEST_GEN_PROGS := openat2_test resolve_test rename_attack_test
>>   
>> +# gcc requires -static-libasan in order to ensure that Address Sanitizer's
>> +# library is the first one loaded. However, clang already statically links the
>> +# Address Sanitizer if -fsanitize is specified. Therefore, simply omit
>> +# -static-libasan for clang builds.
>> +ifeq ($(LLVM),)
>> +    CFLAGS += -static-libasan
>> +endif
>> +
>> +LOCAL_HDRS += helpers.h
>> +
>>   include ../lib.mk
>>   
>> -$(TEST_GEN_PROGS): helpers.c helpers.h
>> +$(TEST_GEN_PROGS): helpers.c
>>
>> base-commit: ddb4c3f25b7b95df3d6932db0b379d768a6ebdf7
>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> 

thanks,
-- 
John Hubbard
NVIDIA


