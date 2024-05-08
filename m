Return-Path: <linux-kselftest+bounces-9722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B29EC8C0316
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 19:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54511C21AF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 May 2024 17:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FED2E3E8;
	Wed,  8 May 2024 17:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bdrA3YL9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EB010A28;
	Wed,  8 May 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189421; cv=fail; b=mcgzNlNFdVFjQahlm39UlFKR+aquOEETn6D3BM+7aZIU0w3NuJGFo+1+A6SdCxrI3LelHW4GiCjiKfMVllK5VlVlVq5nG0/ZLpuPy2ncuI6nvmyCIMARmoBuNkTADUrWtX1362l1cHtA3izjBPyhmJEK71NRAI76UBrEyNG9uQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189421; c=relaxed/simple;
	bh=E4SAh5rPUVIM608r/V1EyQOAGQwBbZGDrDL8Xq5S90A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AmfNRxyH/aH9VaiIqUZIqgNpcnbS8FJti3vp+v7m1QomPx9L/KhIc9i3k5uDTgsvAHNvzC4s9jsdOMjmpWo6vYf3yAN1hWshzwybjCCQ4w13E1O543bR+SBDHLUSCfadPzhopv+updAd+qHZzs5EFdvHijhkkqttsZaXN2yDsIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bdrA3YL9; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NPiCW2z5AgyAtpqhbgRvIvXF5l6dJM0axKuMe8975fOhA+Q6TF3tumI6JxMdWvkGV5uCzztWAOkS8/kRSlbsoteX5tSQ/NW6XehfHWmhvj3JXr8ZyYV0+yjawDxF7rIwJV3EYbhi0lYhj0Hsm/upcBuXZAKxOyiuvLgHYigrWUSFx1T83Ry7SXi1M7G3/lf2uSpXV7hAVT1bibrsD6EQbuEBaFBf4Pfsa8TIuWsVOpD3QYlYtkPERWbrRlxge0Dg2eXmEycYcZtH3pJF02t3hcFHNoSFMNqqW3n+8ogRpmcUi0/2qxTC+m1J5k4gbMxtcf+fkKBOj5oNYrEcMAFKvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PgeNSzM6jOyLbybH1I5XpbPmWefl4AH7Gw0S7IZcuY=;
 b=jvPCtxNtRlmW3UP2QBs1LqiMOcUbJNgh34l5xxkUpcyi/qjPCM0HGHmhOl2DW6yHNG5lU82gZ89OKD+NaK3zraMCDNLGbdHjs40jvIEVGdkAuj8eoET41/KADzYw8SP1bnOvt4SZHUDhjdNjzJuQYapa4kRVKnwu7/QdV15fCEx517SEUIrNQYTQJGkoEosaniHX6GbURsuQ/25RuJQHvgjHW5E0Vdn9jKnQV/WI968aPExIz0C9YUcYzUdBp6VgkLDKh7jdhufZRwxTvIc+vZbpXaxkilLNaBnZR1r1NmZfSbGvrdMYrefxfVROZins/81NDPKP4mkq2zL/aCdQzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9PgeNSzM6jOyLbybH1I5XpbPmWefl4AH7Gw0S7IZcuY=;
 b=bdrA3YL9pk1yY1bX81mUxBd+6dRjXAvJlKERgBwKclGbYTOOflgpuxHTPuIwjBhzqdACFBCzhVyiT3T4N9eejpZv7chSFIVyrJLmYHzeexBE9EuNFEEzUUC3pidDP3SJoR73R8Ee+TMeaZ00uIYCk5tfXIykMPeiGnmMcPDropXfqr9/t7LZmZMJR5dLX6hP+QFAwodTpwha/n1SlsTFiBlUFisqNdc4k2x9nd1Ni0dH/fYm567dYYC311WmUDZdDwhDnFXS/MFTmBXs+OCGQNnxf8qrMTsW4MTvbU7TugoUPd0ujWmUgLPfj5rrZEu5IC1c6Gb3R3/JM6HwRc3kTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB8413.namprd12.prod.outlook.com (2603:10b6:8:f9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.39; Wed, 8 May 2024 17:30:07 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 17:30:04 +0000
Message-ID: <f4d66d0b-ac3a-416b-ad47-3869e84a03fd@nvidia.com>
Date: Wed, 8 May 2024 10:29:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/resctrl: fix clang build warnings related to
 abs(), labs() calls
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Valentin Obst <kernel@valentinobst.de>,
 linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 llvm@lists.linux.dev
References: <20240503234051.21217-1-jhubbard@nvidia.com>
 <9ae11dcb-62e8-4361-9f78-971d4c6e6054@intel.com>
 <997d7fe0-46c8-4b38-824d-083ab29f54ce@nvidia.com>
 <d67f4f57-4e9a-4715-b6dd-7b83a240b7dd@intel.com>
 <7dd4b09e-b9ba-459d-bfa4-150e712f54bc@nvidia.com>
 <076d9990-6253-438d-bc92-70eba6dfbca9@intel.com>
 <7d4d8a31-00db-c7ba-aa8f-0483c8d93700@linux.intel.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <7d4d8a31-00db-c7ba-aa8f-0483c8d93700@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:a03:114::30) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|DS0PR12MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6bb58f-a72f-4965-39bb-08dc6f847f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REtLMktjRmpadUFoc3RrbmRBWkRST3BjQ3FweW5NT0wzNHcrL0xtYzI0NG56?=
 =?utf-8?B?SmJpRTh3NlhHTUdEVkFGcWE2R2oxVE9rc0FBQUlIQlBIRkVoLzQweGFyQlJN?=
 =?utf-8?B?Y0dHSktZTDcxUEl2SEcrRkJZTnd4bXpTTnQ1YnZSNnZGYldTYzk2NzYxRUNx?=
 =?utf-8?B?WlNSZW0yV3F3MVFQN2JQVXBuRlcrL3FPcWRLQUhaa3ZqUnZJS1hUWkJRdGpD?=
 =?utf-8?B?MXhTUVJmR0h3RVFOVzE4aGxOQktiVUdza21wd0dDMEg4dHUvWmxPcWY2aGp4?=
 =?utf-8?B?RE1rTEJtZGxlS3JDTi9qQXRSY09zSDVSUG5rRDRjaUVvK052enFyNndjMEV0?=
 =?utf-8?B?anRoTzNpR3NXRlN3clRLUXFVU1E4RUhsMDNDdkh1RVVtZ2xmMFBJZUQveXh0?=
 =?utf-8?B?MHMyNzdPbEhWdDhqYUtsUUF2NmVqdkljMkhlMXFGVEZGL0E1UG9GMnZQclZ6?=
 =?utf-8?B?TzFGendLUkloUGdnMG5CV0N1eEpEVStjQWJvR2l6YU01NUtVVzVWbjhPd2Ix?=
 =?utf-8?B?MFpvTXphVkhyOWxXaU1MMUo1NFhNT2JnOExJZm1KcGJHNS9HNzBMRVczc04z?=
 =?utf-8?B?THZaZmorMUF0dFVYOWJRYmFuWWkrall1Z1EzdWt2YWhCNVZjbUlXRmkrWGF4?=
 =?utf-8?B?VDFKU2J5dXgwVkswTFpiZGVBY3NHWTNvbXVNandWckNCRWxmdUdLbUdFRVhK?=
 =?utf-8?B?NzZNcis2TEVTeENaYmVZYVN4dDVMRlhQM3BPQTFZYWlrZWJOMXU5clloWVVU?=
 =?utf-8?B?MEF4S2lVa3YwUFBQeDdta3dra016d0J6cWRpZlRYSVEvVDRab3NsV0VqZU8x?=
 =?utf-8?B?YVFBR2RGN1dTaGJRdXdDcndsamhIdndrbU9yQ3YrekNQTFcxRy9IY28vclNP?=
 =?utf-8?B?UWdDK1ByTWN6eURhRDNsUFg2TC9tUW1TcjM4QUFWSlB3TGFwMFdqbVhJcHdt?=
 =?utf-8?B?YTNaRlBiZGt2T3daQy9vUmRCU0dIamQ0WWtMSWlyNU52TE5jRlpIU2Z0YXZh?=
 =?utf-8?B?Q0ZFVHFOQUMxR2JsSzVmL3I2VHkyK3N5NWxkTUVQeXZLVXNXRk5MdWQ1VDNR?=
 =?utf-8?B?K2NZcEpTRlpNbDZoaDN1Z2kydjdDdVZqNVJUakYra1ovZTVkZzhYSjMxN0VK?=
 =?utf-8?B?V1RDYTBacDF0ZTZMd3ZLRk5Rc005SXVrZWhvbkYvSU5vSCsvcnk0NVUvdmpO?=
 =?utf-8?B?b1NaSHBXaDRyWXM2NFVGajVvNDNMMjYzR0t5TjVUekVyamNDeER0NGU0eld4?=
 =?utf-8?B?dllKUzVpdXFnSXI5bjdMNDJVM21sdFJXbXhNZzE3aTdtZ1hnMHlFZVp0UDlz?=
 =?utf-8?B?bGYveDBJaEliQUpvKzVud3YrYldtZGZqRmRPUHdQYkJaOXZOallXZzVvRnU0?=
 =?utf-8?B?YWx0OStrZ3hQWlp2NEVtT0s5WUl2NXhid3hIbG5YSmkrK0gxM3dwOTFBKzNl?=
 =?utf-8?B?bjFuKzNGbVhhUHJhVS9IZWJjQVpsVW1ISENFYnV1UUVRNXZSS1NCdEFaN3Zj?=
 =?utf-8?B?eDBLcVRRSlRpRVZ2MlQyaGw3RUE1aTFJa25HbWlhN2Z4OTlyWFlPVTFOOUpC?=
 =?utf-8?B?OUNqcUxqR1hjSk9ZU3d5K2ppejZNSnVtKzEzVGluVXBLbFF0K1dLL0xFbEFR?=
 =?utf-8?B?dnJGNGJpTXFmVUp4QzBDNEFSSFFuclgyN0R3K3dqelJ6NkZiaHpSajFNZjRa?=
 =?utf-8?B?d1pBR0Z5eHZuZi9ESHVXaTc3b0NnRmdtYmg2VGFPVHZ6a0JKL0p3U0ZBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cHYzVUhvZTV2dVhqQXRTbStwYWdNTkVHbGFFYVdxMzJwMGF0Wllva3Y2VHVD?=
 =?utf-8?B?QVdGSnlPdXFJMVJob1BCS1h3N1NiVVlVUVNYU3E4MWRYN3NIR0dudUZMWjVY?=
 =?utf-8?B?M1RicHFkVklTVmdrbVluS1hUT1NUWjBkNWlnenUwZVFHWTZDZkJPQmlvVUZR?=
 =?utf-8?B?MUZtUTJqRlJ4ZUZDUm1GT3Jra0xVSFViRDhhN0JjNHNMSk53cy8xSFVXMGVP?=
 =?utf-8?B?OVFrVk5vYlBJR1U0dTNSQlEwb3B5ZjRKNUtvaHQ0dXpjS1EwdXZjZHIxVmxP?=
 =?utf-8?B?WnpNZFoxa3UvUDJwMFFrMkNlekVQYTBtR3Nsa1pLM3BBRmg1NW1TeUxIN05h?=
 =?utf-8?B?WDdCcFpZdEJsQWRSWXB2T0tQLys4dC9mVFpZQnNyMFFTWHN2UHIyZGFDWVhn?=
 =?utf-8?B?djUvSTYyd1JvNHVGS0x0eFhjOHorWXZIQnh2aXNucjlLWllicVJiVnp1Rmdt?=
 =?utf-8?B?Rk5kSFQ0U09NNFRZRXh6UUFVc2tPdEtpc3U1eXZzNWsxZWF1Tk0rN0hkcnl3?=
 =?utf-8?B?blQ1eDNiQVowR045NmNIeUFuZzJZT2hXMDdZOWRLMGVWT2pZNi9IQ3oveVlQ?=
 =?utf-8?B?YUVRc3lVUlkyZzdOVXp1eDFpQnpKMGgzdjBQM01JaWNucTUwN1VhQld0clUv?=
 =?utf-8?B?ZnNOazlkK2M4L1RJR3ZZUmplWWFwMUkwR05FaVhYSnFuaHpseERIcTFrS0ht?=
 =?utf-8?B?MDV5dGptdFkwS3g5YXlpSFF2cEYvR3BwbkJOV3FTTDdkZjErZUNJY0FrSXhj?=
 =?utf-8?B?TFpnaFRjNjhhOEpDWEY2VEplWFNBcjJCZjQ0VEQ2NmhzNW53a085S1NtMldG?=
 =?utf-8?B?TFFuT25NVk5WMFcxL0puT1pOejE2ZWNlZ29vYU5XanZBTFpSQ0tkQmt2YkM1?=
 =?utf-8?B?cUdHSjJBUlU1ZDlLVkhzdjB6S1NoS25wWUtKYXR1aWY4TG0wWFpVeVJJVC9j?=
 =?utf-8?B?N0pNZEg3VVZJSkJHeWRwc3FOUy9TSWREZFloRkNIcU5HbU9XNWZYVjNGanli?=
 =?utf-8?B?N25kUWFDSUVVSytrSTJ3QjZXSGl4MlFDMGVodkF4SXBGbE1QbDNBWjVZc3BB?=
 =?utf-8?B?UkNMUWRZTlVTVXBZUktGN2RJWElFQ0thK2VpbUlmbGFlMEZpaVhoemFuYit5?=
 =?utf-8?B?NzAxSWdXLzJ5VGlnTE9paDE5WGtBY29XVzhHaEo3d1JaZmcrSWYxY3RTVklO?=
 =?utf-8?B?dTZkb293WGs5L244TW1QeGV5Z0V2VWJnRGJOUTJxQWdSUFJnYWFtL1hZQnpZ?=
 =?utf-8?B?UDJpa0taSkdQdjNBcHhpRUtrcmpSeWplTGpSRWtVNnVDY2R1ejZodlpNclg1?=
 =?utf-8?B?bU9STnZyMDJHNzlVV3BEUm9QYmFnaFgzTTZ3SFNKUGZZc2JwdXJuWFEzRG1D?=
 =?utf-8?B?aCs0ZVBTS0RyQmxGN3ZOU015UHplQ0g2TVpNY2lvRG5TVTRKa01ZbjRzSWNu?=
 =?utf-8?B?M09jSTB3K3I5ZktPOVlsdytnSmRVVzdTS2tsNXJLTlZLVzhIc2p1NmNlbWZP?=
 =?utf-8?B?aXdsK2VVQ09JRmdXd0MzZXF4cjk1QVFEdWlDRlJCVCs4L2pLVloyVWs3UEds?=
 =?utf-8?B?d2orNzU1UnV5MnFsL1BabXJwT0Y3RFJ2dDhlSjh2aEY5cHRLUnJ1eGRrNmRB?=
 =?utf-8?B?YTdJODA3d3FqNEtSMDkrTm5LOThreEZPNCtDc05QdFB4QTJadFJENFhFZHFT?=
 =?utf-8?B?LzNJVEp2YUt1SDRMMzhrTXhFOTBDWUVZVTBkYTFLRE5sbG94cHQrRFR6RVk4?=
 =?utf-8?B?KzNmUnBxeU00VEtxUjRoTXBvRXlYT1FMVnNzVFRkWjZHbVZ5V00zUklvd1Jo?=
 =?utf-8?B?OVZIVjNDZ0FHQi9Ba3pEV1dEV3dVdDBHblpYSm5kUUVCTDBRZ3FuMC83Yjdk?=
 =?utf-8?B?MXlBeHVXSHI0K0NSdG9aWEJrU2d3SGp5ekxSOEgvODZ3blExdHIvaFBTbHZP?=
 =?utf-8?B?aDkrSEZXK2lNMFR4MWFwakFGdkdoYzNwUkJSWUtYamx1MG9TVjRzYnBzQkt0?=
 =?utf-8?B?ZmRxRDVZR1VSNUN2aGM5TXZCTjZFOUd4QUNQUWFkOWVHWHozd0pqNTNqZWJW?=
 =?utf-8?B?OHdqdGVsQ0tKa2FCSklseHlLV3ZIVVNrcDV0d0J0RGFYbTYrK3Vnb3NEd2xR?=
 =?utf-8?B?dEZDQkVxbGkvUENyR0VPVmFWdzJSbnlYSDNEZkp2aGZkRWFyUEhTYSt5Z3lo?=
 =?utf-8?B?NGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6bb58f-a72f-4965-39bb-08dc6f847f7a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:30:04.5917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zi11+TrFHOCyNvkVLkApjAmTM3/DYHKg+FVrR2dELcZpM3zvNd4WhzmQGBb8ClJNH35U6zjOZbkaP4JvvMqcdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8413

On 5/8/24 1:00 AM, Ilpo Järvinen wrote:
> On Tue, 7 May 2024, Reinette Chatre wrote:
> 
>> Hi John,
>>
>> On 5/7/2024 6:25 PM, John Hubbard wrote:
>>> On 5/7/24 6:21 PM, Reinette Chatre wrote:
>>>> Hi John,
>>> ...
> Yes, there are two *abs() calls in this function.
> 
> In this case is okay to remove the first one since it didn't remove
> absolute value completely, whereas in the MBA/MBM cases v1 removed *abs()
> call entirely which was wrong thing to do.
> 
> I explicitly noted in my v1 comment that this CMT change is okay but the
> other two were not.
> 

Got it, thanks Ilpo (and Reinette), I'll send a v3 with it fixed up
accordingly, appreciate your patience here. :)


thanks,
-- 
John Hubbard
NVIDIA


