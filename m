Return-Path: <linux-kselftest+bounces-10941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 710718D523D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D97BCB23C0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F2E12F592;
	Thu, 30 May 2024 19:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FLuxf6BO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491D2E657;
	Thu, 30 May 2024 19:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096929; cv=fail; b=IYxHiW1caeSQLG540+XhELBawMvWkCVuj0o/TiaNr9xCB6tP4a2uCrhIcvLlCvaMtxu57S/yXdMx90haoV3UXFEK5a8CS0e5Tp7w9bgjgN4wCglN9opZNLjFAPFNYSZ/Gk9rUYm0+5Dv2CFNA9LtQ2Zzi/bZVdF5OdTrmGUQkJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096929; c=relaxed/simple;
	bh=xhv4awS35iB22WjWS4jjiliaMiZ+NyJBZQ+yTGF9izU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kEuMgRHm5pONX67wneddjwbQv5Odk/vbvoVnn4AEOIV6DE+JhUOrTSjsj2Uqvffj9lo2WCINI10IsdbIL0eqJFTsk6+X9qrN7QgkueMxKXkjot9G5YwCjC7ZzQZgeh+7jqgsIz9y2NY2i9yT9A6FHZsaYB9IzItgiVE7lZBxpLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FLuxf6BO; arc=fail smtp.client-ip=40.107.101.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EOV27HZGCLG/6ka2zd0vUxg0U01MI1UG0/hplOcyBIe7zlGeDR3ATiOf+tjelHDqsgxAYJ74oWd7lWNromT7yzixQ5aHlvFj803gLKQhNEg4usgpJum+XpijmiunTCymq56RgWBSTX7qf2APM43bl27r/E2IK0npyZ3kA6zOvCye2Wvbb3SMvHwz9OJIdt250vVc6bfkBlZrTXQ1oV7WR3HzljO8i0fTVpFdy37PRwpTyLx54p6Zg28ib1eYv4j5Q2f4g/L7nP6G5j49QVE1zOSRCCweannrHjPY8yCXheYphuZYjodIVi7DaeyY87j2CO+BtaFVDfjas3qEGFXnhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFXuCv2UXGJaWbxtF/OfRAG8IR2cR0yn3XaQEFVFPxw=;
 b=F60+o2MKkTDpJ8auV8tDKWnsIoSjyzAbRcrFCguwyYpYVgdYCHyS30D4yb+FfiKcKX2LQuAP7iScOX9YN+cH0ylPzeHQVOHyA64baDhzKyoarh/C9N6Dg6QEyExXx3rGJwEqveNTi5t/PsECDIyz9BG+5htKIQCRYna51Tmg+wpW8+6hFrsmNRENiOlzGRW9OOKfMndXGwZP2I+MxhbHcDV/Et3Ek2XaDPEMnPErmKtw8/94hBZ7rRAky7t81QohrrWpJuuBf1ClTXYqPYt/SBToLaGqj0/lLWVHAosSS70hU5ZloDRMXhVUeLEAR+UU06usLG/MkkmTpIBsf49ZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFXuCv2UXGJaWbxtF/OfRAG8IR2cR0yn3XaQEFVFPxw=;
 b=FLuxf6BO2oekpKNv49grj/E7E0XxbgMqQyzlUfykP4SLrm6vOIMbEI6FvLfqIWQJZXET7eH4YqYedLKCzqDpJtMGViEOmmWQ/0nXkZ5p1B+bVchZyJPXstTDLwUQAnrIhZxCTN4mgdLndIIcfW+jC1SuF/kjWA67RJtG4WgTkbYx2YFHS9Df0+DttI1oDm/l9RJDCjAKv+pjf1H3/iqEtYKk8QGUUVNoQOIS5J9gXxz/9+VBJuI5xOaEV0fe5HRJe+08jed5MpGT6GrCQ8V0RLDp8cloYrJOLKvklKvP3BY5JWqNv8g6sEuSQjzeUxLhnj6RqXrDhMSA3HpMG9bjZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Thu, 30 May
 2024 19:22:05 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 19:22:05 +0000
Message-ID: <3a67e1db-0945-4f68-948f-02fadfd6d25a@nvidia.com>
Date: Thu, 30 May 2024 12:21:40 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] selftests/x86: fix build errors and warnings found
 via clang
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: angquan yu <angquan21@gmail.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Binbin Wu <binbin.wu@linux.intel.com>, Alexey Dobriyan
 <adobriyan@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Yu-cheng Yu <yu-cheng.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev, x86@kernel.org
References: <20240527210042.220315-1-jhubbard@nvidia.com>
 <f4877afd-dc2c-4e54-8b53-c681d3eed045@linuxfoundation.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <f4877afd-dc2c-4e54-8b53-c681d3eed045@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: a34dbb88-2574-42e7-55fd-08dc80ddcaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWFmcUdiWWR1VVBaVEkyT2dkQmVqUXRQelQ4KzMrYTl6VW0yOE9iWUt3RWJE?=
 =?utf-8?B?Q0hTc3IyQjdGRThseHQ2WUU3cUlxUVQvOVBuVnFob3FlaWJIa1NGYk1VK3FE?=
 =?utf-8?B?SHprSDRsSWxpaGI3ekEzUC94N2JaVDExME9qUFVrT0YrWWxITzRZdjk2NklR?=
 =?utf-8?B?YnRDanVvSlQzZkgrbC9lTDlNSEt3bnJZNkQ4aWRsVmUrMDNZQjJMMVlwMTJu?=
 =?utf-8?B?SE04cUFUT1lRNGM5M0txMS9zSmx5T1hiOHV0bHZ4bWpuRTZ2dStKLytDUWI0?=
 =?utf-8?B?SFNLaHEvVzVBU3NoZ2ZRYm02Zy9xd3VFbGtaSlNQR2hidnlkWXRBME1PdldV?=
 =?utf-8?B?ck9Cb0x0eDNlMDdIQVY3SVYzOG9LK2R3SG4yL0gyd1phcU9wU3dRK0ZlbWg1?=
 =?utf-8?B?T3RzNHRhQysvVWg3NlQzb25nSSt0Q3A2Q0IvZW5Cc00vMjhPRnBKV1NIa3FI?=
 =?utf-8?B?WGpIUjE1enVxOUZmcWwyeDlPcmdtazk2azl3cFB0cVNibVRmZ2FMR3VlcDdu?=
 =?utf-8?B?TmZGb0p3amlRbUpuSFRnKzB0a1NCQTB0VlNuQ2NzaEtDSlNxTWtSRm1PRHFa?=
 =?utf-8?B?UjE3U0JWSG91d2ROai9jcGpwYU9OeDdNMDZUTmRaa2EvK014VnNIZ1ZPbFQ1?=
 =?utf-8?B?aHI0N1kxYkJ3dUliVGlWQXRtSzE4OVhtMGVBQUFENHpIbTJ4bEFUbmY5Y1M5?=
 =?utf-8?B?YTR2OFdQWjh6WThVUGUyYTNCbFg0THkxUmxEUHBRNGpyUXBmOFlUMTBhQ2ZD?=
 =?utf-8?B?ZG1McWFaRDFLWjh3V3BrMlh5SStjeGlodjhXb3dXSEViQ1kyMEZsZ05uUits?=
 =?utf-8?B?QUxpZ1o0bnVtNk5GRTkzbzkzK2FFSDRFK2ptNnZ5TTJEMi9Vc240cFRQUXBJ?=
 =?utf-8?B?OXh0VkJ5NW93RllYc0x3TkNnSFlabWxUSVB0VlRiTC84K3BOVmMyUUxlVmtH?=
 =?utf-8?B?bTlqZVllcU1FZDF1cFlPaFMxcDFkVmRCcllGQnM2RDI1VUFNTDVSbEFPbE9Z?=
 =?utf-8?B?T21BeXdPYUFocFp5R3NoRWNhUDFrQS9sUm5tb1ZxUTllYTZmSFVuYUlDZTlM?=
 =?utf-8?B?LzBiSi94NFZSM051b0NRUW5Od0lyMktZOHFxRjZnek1JOEVGRHE2NzkyQ3Ru?=
 =?utf-8?B?Z1VFT2hwem0xNnV0R0JKRjRFUDl6bEFRYnJBanE5UmJ4MENCOHMvdXRtd2xD?=
 =?utf-8?B?SWVFYnZlMGtPRzRWeGJyWU5ZWmZvcUl2dWY4SnM4RVVlUFg2cmo2ZmplejBM?=
 =?utf-8?B?T1RmQVlkbXlHVTNHdHVINm5ZS2wyS0VwcjhXWUxUQWFQdm41dmRqVHhJcUcz?=
 =?utf-8?B?Y0RvZnh5TE5lVGY0djRsWDdPQzlKSTNqU3IwQmE1bVVUZzVyL1Ewb1pnWG5E?=
 =?utf-8?B?NjNidzl0WXFSYzFibndLRHZERjcrU1dmSGlBdU1KdGl4ODVjR2JhSE5TNlF1?=
 =?utf-8?B?RGlvT0w1MUtiV2s3MWcrY1Vjd3BxVHRkL2FCMVlLQURlSFdKOHF2NTVoWmRN?=
 =?utf-8?B?bC9OaCsrVDJ2RnlkWHptWDBITWJ6aFp1NlFQRmpLWnp0b1RSbUNQTkFkblFi?=
 =?utf-8?B?MGhEUldtMkZCQThuUERPZkM4TXZEMGFDRlNuSlhqQlBzUWFYYWFXZXFWY2Jv?=
 =?utf-8?B?bUFpM21uWTI4blFnQkk4K0M4bHBodERRSyt1TGxyWjkreFJJT1MxTFZrQmR6?=
 =?utf-8?B?TmdSNTRLRENoQXkyanA5ZDZFQnMvRlZsOVBaVmc3byt6bEJ1clJzODhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHZRY243TXVYTHZtRmVkVG9BRmdWR0dLcGdISmJpMmhFOUdLQ1hmVVpGWEU5?=
 =?utf-8?B?dUhpTEZucEpwYnVycXJCVGNjY3MrZVBTWkVWQUZrbFFpK1p2OEdLOVRsTDly?=
 =?utf-8?B?Z283c3V2cTA0Y0cwdkUrd1FaQllmWjg3ckZTdTY2Z0tkK1JaOVVQazJpc2Q4?=
 =?utf-8?B?TUE5c3F4YUMxc1VEc1NPNEd2Z2ZJUlI1c1dIYXN0Y0RacWVuVDV5VEtnNW9w?=
 =?utf-8?B?NnFTanQrdm9KT3hyRmUxcC9lQjZtalNOSzZmM3hzaE8rTGdlN3BieFNnOTgx?=
 =?utf-8?B?QXJHZDV2Zmt4S1RyRmQybHlzRFBPaklsVmV6a1N1QTZSUURPQWRhNWRCcllZ?=
 =?utf-8?B?WWtFcVJVVk4xOVZPVklqTXpucGhReW1GaEFhcmNHY3NnNHljaUtzQjh4NDVW?=
 =?utf-8?B?cVVvVTV6ZEJKUzhKeUNZb0Era1k2a2NrVGtZQnptaUFJdVErU3VJRmtBcCtD?=
 =?utf-8?B?TXYweVFsdFhTdkJZRGdJWnl6SkwvNmdwbTN2VlZ3MnlRaWkrN0llUS9qcG45?=
 =?utf-8?B?UzZkdmxRMitOa2xaSXJTOGJGZ1lCZG4wRExKY3dIeUVCZnNrRm14M2dIQkxv?=
 =?utf-8?B?WU4rWHQ1Z1FhRTlobjdjS1lsSW1sUGlZenMvZ090Zy9mUllVMDNERzgveTlj?=
 =?utf-8?B?MEtpU0xSM2ZiYkRvbDZTR0piUDIxVFk3NytjNnllZzVDc2xLVWhjaHA5MWc5?=
 =?utf-8?B?U0UySUl4aFZldkRVSXRRVmRNV3ZoS2JvTGp3R1JXb0FrSEYvT01DYVBDcHBx?=
 =?utf-8?B?NGhZR0p2YUVyZmN2cCtLUk1hRmd6Q3RzRzdPL2FRTUxTZnV2K29LQytGRUhF?=
 =?utf-8?B?a3R6NEtkbk5pZmdJNE5NemZrKzZIYTVtSVFXc2JjYlJ4MnVHVEtqd2N4ZVRI?=
 =?utf-8?B?ZmVoVmVnYkFicm9OZVlYSWhSckZMUDZ0UXFiemhERFVNY210Zm9vT2V2MzEx?=
 =?utf-8?B?VXhsamFoMDVZbmdSMmIwNmR2RlZ6WXZOWXR5WXpuRFRsVzhhRCtSdHZqSEFz?=
 =?utf-8?B?TmVWMUYrdnRzeHdacEpoUCtPZmcvV0JEQVd0NitESXJsYUY2V3grUU9DOUtj?=
 =?utf-8?B?QVFWckl2b3B3cG5MK0p0aUpyZlhaaHN4TjF1a1Z0NndoTjlyd1ovSDNlRW8v?=
 =?utf-8?B?TDdiUzZpanNSQU1IaGJmRHZnV1E5MWRTM0dBdkYzNHVrL3RFY2lPdzNIemRH?=
 =?utf-8?B?N3U1SVlLUEx0OFpMN2hsMm5MdjJvd0lmWnhva25PbGpGL3VHNnZSRi8wRFpR?=
 =?utf-8?B?L05YVmlGaTlSblVEYVlZNGRJdnIzWHpvQ2NlTzFmRHlWejBEOEJXMUFCRUsw?=
 =?utf-8?B?QVNUakJ4a1NhbjZRRlBmRmJhTWtRYi81S0FKaE9ZdTNkZEdpKzgyVmMvck9x?=
 =?utf-8?B?d3NMZHhGVU12emhvc2piS1h4SUNFL1R2NzRvWjhxZktpTTZPSTFsYlV4MWdq?=
 =?utf-8?B?dmxkRytmNm9ldTViditINE5RelFseTJnV2J4ZTdON0p5RkhiTW9SeVQ1OWR2?=
 =?utf-8?B?dlBBVGZKOTFmeWhkVDR5czRDOEE4TUFQcVkxVURyeEhSSmpxWEJLM0V5dHlm?=
 =?utf-8?B?YXZXeXZpdHh1bGFMUjkvSyt4YzdrK3pkNVVVUjZMUGVMZy9POWZ6Sy9LMlEx?=
 =?utf-8?B?Rllwc0IyODhheGhzZVN2SVBtUzhxL2RVdmk4cXkxb3JIVU4yRHBlTVl3ank0?=
 =?utf-8?B?ZDFlZUxLQmtZc3NTZEJXcVdlcUREcDdSbTB4em5tNHBmQ0wydW5POVdrZDRE?=
 =?utf-8?B?M0dBTHZ1NEtFRExUUkZpNzFxaWk4NTRBOHE4UXJac1R4aWFQeUVrUmpVVW9Y?=
 =?utf-8?B?RnNLeWV1MWp2MDFqOXlQZ0tRQ0VydVhRR1RFM203QzdEUUxPZ1E4eVJYcDVS?=
 =?utf-8?B?RzdzSERYZVN5a1l4em84b1AxaGZ5UVNrVUh2TVlHRksvR20yUDFtSXVPd1Iv?=
 =?utf-8?B?T2pGbFgxcGd5a0FWT2Z1WG1McUFXOHF2VmxHYk9PangyUUtWUExvaE5pOEEr?=
 =?utf-8?B?eDBXMUZqK3Q2cXFMK1Rib2JNRDdJaEhRWDNIbUxSMW1FL0Y0VWZkNEpaVU41?=
 =?utf-8?B?eTNZSXpOcWJ0YUV0aVpkczlYd0FPZDF6a1ovZnd6eGRITWJrNGZSWCtmQkds?=
 =?utf-8?B?VDBPRENmSTdrVklXOVgxL1E1UHpUOFd6OHpZQ1N1YWg4dEY1U3JDQnlTUFlq?=
 =?utf-8?B?NlE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a34dbb88-2574-42e7-55fd-08dc80ddcaa7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 19:22:05.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln45qFHZ4N8cc22VAwvgwq2/k1ePFjXhEcw+w5RMORoHObizTsVkZk7lTXc2PB/mTa+JaJIGjJtM/L6ywn9nfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848

On 5/30/24 7:58 AM, Shuah Khan wrote:
> On 5/27/24 15:00, John Hubbard wrote:
>> Hi,
>>
>> Just a bunch of build and warnings fixes that show up when
>> building with clang. Some of these depend on each other, so
>> I'm sending them as a series.
>>
>> Changes since the first version:
>>
>> 1) Rebased onto Linux 6.10-rc1
> 
> x86 test patches usually go through x86 tree.
> 
> This series requires x86 maintainer review and ack for me
> to take this through kselftest tree.

Hi Shuah,

Yes. I'm having some difficulty getting anyone from x86 to respond to
these. Let me add a few more x86 maintainers to this thread in hopes
of hearing something.

thanks,
-- 
John Hubbard
NVIDIA

...
>> John Hubbard (6):
>>    selftests/x86: build test_FISTTP.c with clang
>>    selftests/x86: build fsgsbase_restore.c with clang
>>    selftests/x86: build sysret_rip.c with clang
>>    selftests/x86: avoid -no-pie warnings from clang during compilation
>>    selftests/x86: remove (or use) unused variables and functions
>>    selftests/x86: fix printk warnings reported by clang
>>
>>   tools/testing/selftests/x86/Makefile          | 10 +++++++
>>   tools/testing/selftests/x86/amx.c             | 16 -----------
>>   .../testing/selftests/x86/clang_helpers_32.S  | 11 ++++++++
>>   .../testing/selftests/x86/clang_helpers_64.S  | 28 +++++++++++++++++++
>>   tools/testing/selftests/x86/fsgsbase.c        |  6 ----
>>   .../testing/selftests/x86/fsgsbase_restore.c  | 11 ++++----
>>   tools/testing/selftests/x86/sigreturn.c       |  2 +-
>>   .../testing/selftests/x86/syscall_arg_fault.c |  1 -
>>   tools/testing/selftests/x86/sysret_rip.c      | 20 ++++---------
>>   tools/testing/selftests/x86/test_FISTTP.c     |  8 +++---
>>   tools/testing/selftests/x86/test_vsyscall.c   | 15 ++++------
>>   tools/testing/selftests/x86/vdso_restorer.c   |  2 ++
>>   12 files changed, 72 insertions(+), 58 deletions(-)
>>   create mode 100644 tools/testing/selftests/x86/clang_helpers_32.S
>>   create mode 100644 tools/testing/selftests/x86/clang_helpers_64.S
>>
>>
>> base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
>> prerequisite-patch-id: 39d606b9b165077aa1a3a3b0a3b396dba0c20070
> 
> thanks,
> -- Shuah
> 



