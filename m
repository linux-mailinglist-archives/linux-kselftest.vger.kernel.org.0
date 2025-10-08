Return-Path: <linux-kselftest+bounces-42864-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608FBBC42EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 11:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4DF189E5F7
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 09:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09122ECD3A;
	Wed,  8 Oct 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2UVqKqtq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011056.outbound.protection.outlook.com [40.93.194.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F932ECEA8;
	Wed,  8 Oct 2025 09:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759916629; cv=fail; b=dBNSyTuiG8rfcZNwsXHKk352UaqQKcH7O/Iq2zsheprRNg5HGUdgTbzjFr2pd+CJqBlclyjDGO8I2jrMq3holiVLf4npnvmz1N2zz1q/WdhpNcg1NCoq6IoTvKEznyxt/ilKGoKALxl8hfVIO05BG2xVvxvE2iDC2QHLbwJkIl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759916629; c=relaxed/simple;
	bh=7Ds7C/PRtZQwUHruMBfFAJIZg+dTlrT4bJ9tb+n1hpI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SlsaT7aLfNgJNtP+BAG6gpG31H49Zup5MWPi4085MbCB6zdqa9iVwkFeL1hMkrYEb0/c6YHz/PaJyrg+snn0laTSFgwn+IrQ5gxL/jgfPHDVyjdlnjwuFgoNE3f7tZtc5HznSrO3G+AoY1BrKvt2xI7KUHl7kWbloUawSoFbJEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2UVqKqtq; arc=fail smtp.client-ip=40.93.194.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgpCvXXhrivocZFs5hIGxGlw7T2mX5VzmlHGsY7BP0iUrBKh5YGjE1nlQI8l+fhBKt0WNv/B5/lwElsb/29npME3v/maar+Ke4ZGB8viiAzvOcmcqGRXlQaMF0La3Z49S7+6hag72o1CeprRo/lCKUjlT6Xb7WLan8q/F/ulpdpI92dRHqIw/OXqYoCkk55Jz7nn1yhnlChIf6/F4/MaIGkIdEFOpHC4eGkXaYi6puoDZYRDnLPZnOWJSMK3Wi99dgHPhz3Jq3e0OoBDOM4/TFSD2emo8jxGjQN+nnyabm+uXsn85yTAkAVFbRP2jrK58tnor37aNHsay5+iO5gUXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JltlMgfYJAzIFRA2hD2nv6hdnfdAIOoHmY3c5GqUNIw=;
 b=cJ94SuOP2sFQ/suOnKsWjFjitZ+RS1pbeTVzEEjk8FUKa4kSJBjOeFQtn1ECNeyLh3sgiCH5VVkHOJJGFMvjp5HjyMDmdfBiHllsQzntvWgNwZhsfbfo2M3Ei5o9IdDmLjRV6EbJrH+xzW0kMoF40XoAywDaRW80BHxMONi4vsRR/WjjJn48LR1s9Czg+OmFcT6Saox1ZivT5hm65stFM7co4LIHWLbForUXiJZL2R51/8za7MohL8n0wL4FC9OmNxH7k5S770WLcZqR6lkS0TBLpUgDvTVuHGLRqfJA1WiptlDbglxoD+0x/oEPkzlMYanRQei2VwRGOcrPfBHWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JltlMgfYJAzIFRA2hD2nv6hdnfdAIOoHmY3c5GqUNIw=;
 b=2UVqKqtqIcZLMIPJRN/+bfaDN14u5H6VIhhvbAOsMLA60Ebm5WKvVKvT6k6Dj4NTwCfAW7UCoqPxZT9OUVuF4s8np2jNsuURuINkElIzzP3M2bKAoq8pKcX0R8Wte9aUEMkt05B8Oo2GSYhHH+7tiuioYCwVjtlXELQ9XliqTWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 09:43:45 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 09:43:44 +0000
Message-ID: <4f50b0f3-c62d-452d-9a39-5c47ac201d01@amd.com>
Date: Wed, 8 Oct 2025 15:13:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
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
References: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0093.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:27::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8357ac17-6578-45ea-6779-08de064f2bd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eEdiMFV2QVQxQVV6VG42M0lkNTE3Q3ljelFRRFJzbmM1NGNQbUVRZEFXcjZT?=
 =?utf-8?B?TnNwZFdyVEUvaE5KMGsyNjVRWlVLQzhENGx3VFRLSkYxdmZNa1hML25QN0U2?=
 =?utf-8?B?Szc5Y0RleFcxUENVajRnTkNJZ0FBNDBva0tZdGRhYlA3NlhOSVVXdjJldU5m?=
 =?utf-8?B?czdNT3A0dFg4VjhDdXVCdlplVjZkTmVDaXArR0F0bXMwUkF5bGVEUk54alhZ?=
 =?utf-8?B?NzdHZ3JpM3RncGowaHo5MFMvc0dud3RMckdUQ1VQMS9MejdOL3hWRUNsOUV6?=
 =?utf-8?B?dHRkM1J6TFMxL1JOaTlVL3RmUytnSGcweTNSc3kvcmV0WkF6cll0bURiMGs3?=
 =?utf-8?B?RlZwcFk3TTJMZDE2Tnc2eFFLdU52TUR6TjR2K3hLWmtUM0lXRzZwYStpblhM?=
 =?utf-8?B?RHhvV1lnRCtLVDNheFE0cnUrT0NuRWFEalkvSTcyekk0bWpldEI5Qyt6dnNX?=
 =?utf-8?B?TDJIeTlQSUl4QUZ6QUdBdjUxbzlsUG5SYXhVSFQ4MEdQaWUyTkgyTmNUTndI?=
 =?utf-8?B?TEpvb1A1QkwvK3BHVzkxMS8yeFVROE13bS8ybkpSc2JqcVJ4NlBBQjhzNHdM?=
 =?utf-8?B?Z0ZaZUw0Y3htQXFGZWpCclc2VGhWSktYK0JRY0hDT040UW1MbGhadEZPMEtI?=
 =?utf-8?B?SkVQdzMvalRsRzluMm91L0dtQlJUMGtSR0F5SFo5aWwzYzJPN0hlL1Vrakkr?=
 =?utf-8?B?UnAwZGh3L0JCQ1Rqb2lVM2RRMUhtajBhRmMxaWFBL2R3TDkyR2JDOTVKM25v?=
 =?utf-8?B?L0VKWDJyUk1UZThsZ1hTM3MzdlMzSG4yM3lVcGphN2RBeTg0TXZjcVB5djFl?=
 =?utf-8?B?L3FyODZsOGgyaEVJdXVjRFZnaE5WSGRJMEl2NzRwTndDWUZ3eWN6T2ZFOTNp?=
 =?utf-8?B?UFlrQ0cxbEVvNEVoVDRRRU1LUUhwOU1BYUxuSVd4Y0lzZ0NzWm8xbjlaWDhY?=
 =?utf-8?B?Sk1uSzJ5VGF2dWg2RHEzcjFZTVdlLzhuNVpBcjdMN0NYTEhvemJocWJZQmFx?=
 =?utf-8?B?NnJiNGNmNEoxSjdLZEVSaVVxQTN4VjF5ZFZDMWJoZFV2NzVXdTZ1SFJrYnJS?=
 =?utf-8?B?dTNJZk9iU1hOVFNIV0E2OE9TWUtMQlovbmwzODR4cjY4dzBsbHJOcnMvUE1P?=
 =?utf-8?B?NEIzaXZpbWNiMlJzUEtQMkVxVkIxbHBmQWNKM1pOZlhZcGozRFhmdzRSZkhv?=
 =?utf-8?B?L0ZRMGZWSWpkbWxidzFKZnJ4aUdYVWxsdEw4UkVLTkZQSHcyQWhIUmpTMUhJ?=
 =?utf-8?B?SnlaZGJmZ3RxelZYUnlDL3ErL1QvL1F6dERiN2JJTWxXRnNIczFzbThKbUg3?=
 =?utf-8?B?VEVHc09VT2RjU2YvRTlNckVqNXdvTkd5SjM0R2x3dURUQjNrdUhGOE5jc0xY?=
 =?utf-8?B?ZUpMbVRFMGlncnhndDl1RlJTczB4NG1nZjQxOWVhcXp1Z3VRNDM0MDZPTmY5?=
 =?utf-8?B?VmtrS28wM1k1YVNncmpRdnJDbGRVdTJFOUlEOUl2VTllTnk5VFVnUzlBYkxx?=
 =?utf-8?B?bytyOXEvS1pVcjlyeFhvTGNWMVpTQzcyYlJrT1hGTWJ4RzNtREcybFl4S293?=
 =?utf-8?B?VWN6YnNIM2NVOXJXZkR4OS9BQmQwM3QwUk1CVjEzVDMrdkp1R09OUytKd0h1?=
 =?utf-8?B?OExiOVNjS3hNTjVYWUZwWkZHOE4vK0R3UGNkQkk0VkdDeXhzcEg0cUlwNWtB?=
 =?utf-8?B?a1ZzZ0JPOE51MjJLbWUvZVNicUoyVkVlL2krc1U2N2FYR1ZyN2drMVVKbHVt?=
 =?utf-8?B?NVhYRFFuSkRFN1ZCSU9rS2FnNkpIaTRSMThwMEJLRWs3UHA4N3RoOWJmQ1Bl?=
 =?utf-8?B?Qm5RTldmUnRXRDNTRGRaRjhvK2JzVlBKeGhFOW91SzJ6aVZldDE3Y1RwdFc4?=
 =?utf-8?B?eTdQcUNkdWNvVGk2Y1ljVWE5bVg1Y3V0TGFnbnMvMXljSk5jckF5UmpFeG85?=
 =?utf-8?B?emFjOEFGOUFheVI0UzlUTWswMUxadVNyTzdNUTNqbEhpTi9vVytKeDRTa0JK?=
 =?utf-8?Q?nLbSbBm3pnzSL7U3aS102+OrPk9bnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z01qYjNtUjVoYUtrR0lUOVU5cmJUbmlXNW5RZUIvZCtRRE9lbFV4c1dLaHNO?=
 =?utf-8?B?TU9rdVZ5U2hhR0ZkUi9BWHU0SUxJT3UwU090cm9GamdpaXcwc0FIdy95aE1Y?=
 =?utf-8?B?cGUwZmwrbUJiZFpNa2xqUHJHa0FTS2RXT3BHMmYySFFSSHRVSk5EdG5jcjNJ?=
 =?utf-8?B?Q3BsSzBiUWorVGJoQjdwbXVLanE1dk9Nc2hGbTJ3UkRqNjh1dU56YkZpaWV3?=
 =?utf-8?B?eXpLZTBxUlRyTTFkQmVNSTA0bGNLc3U2YndVVElHZzUwa0c3bjZGUENYQzZv?=
 =?utf-8?B?eVRjaCtOTUU1KzZBS1lFZkFQODdlU1dUdVhyWUgvMWpyaUpSeXBYRHVsUUNY?=
 =?utf-8?B?eCs4Nk93bndrSzExbDk1YmxsMGtpNVhna3FYTjVIUHR0dzZMMGt5QUdhcG00?=
 =?utf-8?B?Y2JTaS85T0x2bnpGcEVMM1g4THJTdEx0OC95R1lQNk1vS3FwN1VXODR5V2M5?=
 =?utf-8?B?R2s0N1F1WDdtVVVVaUlYRFJrZ01INzc5VjRhcE4zZThmVU1PUThKQWRjK2J6?=
 =?utf-8?B?Z1IvM1hpbHp5dkRQZGVQNTBvNmhvWEJhaTNNK3BjS3dhZVFTejFsa2NJOXJo?=
 =?utf-8?B?UVBWR0EzbnAzbnFzZ3NvcElOMjhVVDQ5SjYwVTZ1bXEyL1BvckIzWlhQVUM5?=
 =?utf-8?B?aG1nalVjYnJSVU1VaE5QL2g2RHZpaHc1ZFNSMXBFcHNmQzJzbXBXOFhvU2ZT?=
 =?utf-8?B?S3Zibzd3MENiUnZJWXBEa3VMRy90clg2SkQxa1FzaTZ3SFBBeTlUaklZaW1z?=
 =?utf-8?B?Zyt3STZLZTNZOHdQdE1tNXRqS0dldlVZQk8rSmhWeERiQ3FWejFtUFo3amhk?=
 =?utf-8?B?eVhSYXBPdWtSZFJkV0hIbkhKTVlxOTB6eUFDODFSY09Ta0pOZW9VTWE0dHhE?=
 =?utf-8?B?bjNUWkcwR2U2L1AreEZadEF6NUxhdG92ODBudDNtUlpXeFJidDF0c1FOVHZK?=
 =?utf-8?B?dm1VamlaZi83NUpuZjZJbTVESitmcFBYSkxob1ZqL2RJMTdkOEFBQ1JkeDd6?=
 =?utf-8?B?bC95UlN1bVUvLzdKVzRwMG45V0g3cjlDWnk3ZU9qRTZpT29oZ3pXSTZvRDJI?=
 =?utf-8?B?d1lKbWswWXh6SElhcTczNXZjcEN4TVkrQm9WclBrbDd5RFh0VEhEQ2lmNjNM?=
 =?utf-8?B?Sk9WUFcvaStZMWUyanJhaytVc3A1eWZjK09wdlFMRjRvUXlDK085YUlGMnlu?=
 =?utf-8?B?K0txMkExeG9jUFdzOVZ6dEdtNmRINlB3TVlNSGR6cXJFdktGYmpsMDVMNHZ3?=
 =?utf-8?B?RWRmR1VVSjdJLzhHeE9oa1Evb3lVVExKRy8yVXJmOVhMYTBocmVCeUNhd0d3?=
 =?utf-8?B?djIyZnZtN0dpSXdGd2NxS3I3WFNLLzhyVnNmditlbU9QT3dYcXY0c1ZNY09V?=
 =?utf-8?B?QXdQcXhtcGZUUndsQmJaamhCaVk0OFVTbFpPcFBGSWhsOEo0cUoxNStqNXdE?=
 =?utf-8?B?YStNYUFxSklPYzNqYTl0YURsWklhcG0yTUhVV2V1RVRsWU9EeXBVSnlHdFNa?=
 =?utf-8?B?dEZxeDczQUlpb05aQjRRQkc1d1lwamVvampuTEVtNmJhb0pWcnRIUnpGQ0VI?=
 =?utf-8?B?YU9iSm1xSVRRb2V6SmNXV2dXb0Nub3BabzY3cFJ4bXIrUDZRYVptd0hXdE93?=
 =?utf-8?B?OUovVnlaelNDUEF0cnIxUHUyNUlNYlFFRDR0dVJUem91UTR4UDFDOWIyUWM3?=
 =?utf-8?B?cWxORzA1VVNNdDFqS0JYSlNjSm5LL1k0NFpmVThvZElhT2pyQlp5MStDMy9C?=
 =?utf-8?B?UWhSRFVCdHFpMnlqaUt6c21kY01qK1NDSVJ2MG9tcU4vN0t6aEFrUlpWQzRp?=
 =?utf-8?B?NWNiRzQ4akJBVGIxRk1OaVRtMjNsNnpna3ZqeDRscUw3YlRveEFBL29ybmkz?=
 =?utf-8?B?NzhPNk5iNERBeU8vSlRwRThTZG5MRFFybjRSaElQQUZBTExTdzFTV2dZLzdO?=
 =?utf-8?B?T0w4clJyOG9uU3JCSmc4d3ZCbjdTVHg1eEhZTTR5SHRBZFVSdUt1ZHcxSkla?=
 =?utf-8?B?U0JzYkVTT2FjWWt0MjhlZFAxVW9MRlNTQzl0WFJlRXJKSEV1YWdqQUswV1Bj?=
 =?utf-8?B?eHZJTk90M0JmQUJmcUlIK1E3MzhaSU0veXRuVHRQMFpBV2k2MjZTSEJHcHdM?=
 =?utf-8?Q?kxxjWXbeHhUiFZMZY/NJLu81n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8357ac17-6578-45ea-6779-08de064f2bd2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 09:43:44.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FhoSfX0LbOYlGUzR6imh0QgqcpFJ/nCFspm/XqCh9yQFyVaKrT+58eJc2oS2YAurKzybsEgetoO8ojwxZJkfvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

Jason,

On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
> AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
> and it can decode the full 64 bit VA space. Unlike other x86 page tables
> this explicitly does not do sign extension as part of allowing the entire
> 64 bit VA space to be supported.

I am still catching up w/ entire series.. But here is few fixes needed to boot
this series w/ SME.

> 
> The general design is quite similar to the x86 PAE format, except with a
> 6th level and quite different PTE encoding.
> 
> This format is the only one that uses the PT_FEAT_DYNAMIC_TOP feature in
> the existing code as the existing AMDv1 code starts out with a 3 level
> table and adds levels on the fly if more IOVA is needed.
> 
> Comparing the performance of several operations to the existing version:
> 
> iommu_map()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     65,64    ,      62,61      ,  -1.01
>      2^13,     70,66    ,      67,62      ,  -8.08
>      2^14,     73,69    ,      71,65      ,  -9.09
>      2^15,     78,75    ,      75,71      ,  -5.05
>      2^16,     89,89    ,      86,84      ,  -2.02
>      2^17,    128,121   ,     124,112     , -10.10
>      2^18,    175,175   ,     170,163     ,  -4.04
>      2^19,    264,306   ,     261,279     ,   6.06
>      2^20,    444,525   ,     438,489     ,  10.10
>      2^21,     60,62    ,      58,59      ,   1.01
>  256*2^12,    381,1833  ,     367,1795    ,  79.79
>  256*2^21,    375,1623  ,     356,1555    ,  77.77
>  256*2^30,    356,1338  ,     349,1277    ,  72.72
> 
> iommu_unmap()
>    pgsz  ,avg new,old ns, min new,old ns  , min % (+ve is better)
>      2^12,     76,89    ,      71,86      ,  17.17
>      2^13,     79,89    ,      75,86      ,  12.12
>      2^14,     78,90    ,      74,86      ,  13.13
>      2^15,     82,89    ,      74,86      ,  13.13
>      2^16,     79,89    ,      74,86      ,  13.13
>      2^17,     81,89    ,      77,87      ,  11.11
>      2^18,     90,92    ,      87,89      ,   2.02
>      2^19,     91,93    ,      88,90      ,   2.02
>      2^20,     96,95    ,      91,92      ,   1.01
>      2^21,     72,88    ,      68,85      ,  20.20
>  256*2^12,    372,6583  ,     364,6251    ,  94.94
>  256*2^21,    398,6032  ,     392,5758    ,  93.93
>  256*2^30,    396,5665  ,     389,5258    ,  92.92
> 
> The ~5-17x speedup when working with mutli-PTE map/unmaps is because the
> AMD implementation rewalks the entire table on every new PTE while this
> version retains its position. The same speedup will be seen with dirtys as
> well.
> 
> The old implementation triggers a compiler optimization that ends up
> generating a "rep stos" memset for contiguous PTEs. Since AMD can have
> contiguous PTEs that span 2Kbytes of table this is a huge win compared to
> a normal movq loop. It is why the unmap side has a fairly flat runtime as
> the contiguous PTE sides increases. This version makes it explicit with a
> memset64() call.
> 
> Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/Makefile                     |   1 +
>  drivers/iommu/generic_pt/Kconfig           |  12 +
>  drivers/iommu/generic_pt/fmt/Makefile      |  11 +
>  drivers/iommu/generic_pt/fmt/amdv1.h       | 385 +++++++++++++++++++++
>  drivers/iommu/generic_pt/fmt/defs_amdv1.h  |  21 ++
>  drivers/iommu/generic_pt/fmt/iommu_amdv1.c |  15 +
>  include/linux/generic_pt/common.h          |  19 +
>  include/linux/generic_pt/iommu.h           |  29 ++
>  8 files changed, 493 insertions(+)
>  create mode 100644 drivers/iommu/generic_pt/fmt/Makefile
>  create mode 100644 drivers/iommu/generic_pt/fmt/amdv1.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/defs_amdv1.h
>  create mode 100644 drivers/iommu/generic_pt/fmt/iommu_amdv1.c
> 
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 355294fa9033f3..b17ef9818759be 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -3,6 +3,7 @@ obj-y += arm/ iommufd/
>  obj-$(CONFIG_AMD_IOMMU) += amd/
>  obj-$(CONFIG_INTEL_IOMMU) += intel/
>  obj-$(CONFIG_RISCV_IOMMU) += riscv/
> +obj-$(CONFIG_GENERIC_PT) += generic_pt/fmt/
>  obj-$(CONFIG_IOMMU_API) += iommu.o
>  obj-$(CONFIG_IOMMU_SUPPORT) += iommu-pages.o
>  obj-$(CONFIG_IOMMU_API) += iommu-traces.o
> diff --git a/drivers/iommu/generic_pt/Kconfig b/drivers/iommu/generic_pt/Kconfig
> index c35ddc7c827e92..208c8178d5dbd2 100644
> --- a/drivers/iommu/generic_pt/Kconfig
> +++ b/drivers/iommu/generic_pt/Kconfig
> @@ -29,4 +29,16 @@ config IOMMU_PT
>  	  IOMMU_PT provides an implementation of the page table operations
>  	  related struct iommu_domain using GENERIC_PT to abstract the page
>  	  table format.
> +
> +if IOMMU_PT
> +config IOMMU_PT_AMDV1
> +	tristate "IOMMU page table for 64-bit AMD IOMMU v1"
> +	depends on !GENERIC_ATOMIC64 # for cmpxchg64
> +	help
> +	  iommu_domain implementation for the AMD v1 page table. AMDv1 is the
> +	  "host" page table. It supports granular page sizes of almost every
> +	  power of 2 and decodes an full 64-bit IOVA space.
> +
> +	  Selected automatically by an IOMMU driver that uses this format.
> +endif
>  endif
> diff --git a/drivers/iommu/generic_pt/fmt/Makefile b/drivers/iommu/generic_pt/fmt/Makefile
> new file mode 100644
> index 00000000000000..a4d83b7e0cf691
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/Makefile
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +iommu_pt_fmt-$(CONFIG_IOMMU_PT_AMDV1) += amdv1
> +
> +define create_format
> +obj-$(2) += iommu_$(1).o
> +
> +endef
> +
> +$(eval $(foreach fmt,$(iommu_pt_fmt-y),$(call create_format,$(fmt),y)))
> +$(eval $(foreach fmt,$(iommu_pt_fmt-m),$(call create_format,$(fmt),m)))
> diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
> new file mode 100644
> index 00000000000000..901fc4a80e9a83
> --- /dev/null
> +++ b/drivers/iommu/generic_pt/fmt/amdv1.h
> @@ -0,0 +1,385 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2024-2025, NVIDIA CORPORATION & AFFILIATES
> + *
> + * AMD IOMMU v1 page table
> + *
> + * This is described in Section "2.2.3 I/O Page Tables for Host Translations"
> + * of the "AMD I/O Virtualization Technology (IOMMU) Specification"
> + *
> + * Note the level numbering here matches the core code, so level 0 is the same
> + * as mode 1.
> + *
> + */
> +#ifndef __GENERIC_PT_FMT_AMDV1_H
> +#define __GENERIC_PT_FMT_AMDV1_H
> +
> +#include "defs_amdv1.h"
> +#include "../pt_defs.h"
> +
> +#include <asm/page.h>
> +#include <linux/bitfield.h>
> +#include <linux/container_of.h>
> +#include <linux/mem_encrypt.h>
> +#include <linux/minmax.h>
> +#include <linux/sizes.h>
> +#include <linux/string.h>
> +
> +enum {
> +	PT_MAX_OUTPUT_ADDRESS_LG2 = 52,
> +	PT_MAX_VA_ADDRESS_LG2 = 64,
> +	PT_ITEM_WORD_SIZE = sizeof(u64),
> +	PT_MAX_TOP_LEVEL = 5,
> +	PT_GRANULE_LG2SZ = 12,
> +	PT_TABLEMEM_LG2SZ = 12,
> +
> +	/* The DTE only has these bits for the top phyiscal address */
> +	PT_TOP_PHYS_MASK = GENMASK_ULL(51, 12),
> +};
> +
> +/* PTE bits */
> +enum {
> +	AMDV1PT_FMT_PR = BIT(0),
> +	AMDV1PT_FMT_D = BIT(6),
> +	AMDV1PT_FMT_NEXT_LEVEL = GENMASK_ULL(11, 9),
> +	AMDV1PT_FMT_OA = GENMASK_ULL(51, 12),
> +	AMDV1PT_FMT_FC = BIT_ULL(60),
> +	AMDV1PT_FMT_IR = BIT_ULL(61),
> +	AMDV1PT_FMT_IW = BIT_ULL(62),
> +};
> +
> +/*
> + * gcc 13 has a bug where it thinks the output of FIELD_GET() is an enum, make
> + * these defines to avoid it.
> + */
> +#define AMDV1PT_FMT_NL_DEFAULT 0
> +#define AMDV1PT_FMT_NL_SIZE 7
> +
> +#define common_to_amdv1pt(common_ptr) \
> +	container_of_const(common_ptr, struct pt_amdv1, common)
> +#define to_amdv1pt(pts) common_to_amdv1pt((pts)->range->common)
> +
> +static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
> +{
> +	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),

we need to clear SME bit here. (__sme_clr(pts->entry)).

> +			  PT_GRANULE_LG2SZ);
> +}
> +#define pt_table_pa amdv1pt_table_pa
> +
> +/* Returns the oa for the start of the contiguous entry */
> +static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
> +{
> +	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);

we need to clear SME bit here. (__sme_clr(pts->entry)).

-Vasant


