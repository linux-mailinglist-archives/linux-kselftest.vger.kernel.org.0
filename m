Return-Path: <linux-kselftest+bounces-13796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8C0932FA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 20:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB88D1C2292F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 18:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AA31A01A7;
	Tue, 16 Jul 2024 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mhJ4/Yhs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619F11A00EF;
	Tue, 16 Jul 2024 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153114; cv=fail; b=KBQqeLFVWezzTDp02FFpb30RZkgrnksusQbgaXGaHA5Za2CB8TnvhmaC0MQtgiGXGzBr0EgAD9eWGvuy2i7TBEbSphWzrrR5IQl6H3ND3jbVOsL1o/D/XI8H7wUslJ0D0og4A7xOiqFkNNt3SWcHEhnVm659Nh8ynWl817LPPzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153114; c=relaxed/simple;
	bh=s5d3uEgRBeTOrpV/b8AGtQe9qC236JZTx3Qjjonspqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D7Vs/gMWXCqE+4DCqb21XBCDJ8PvX8+KiydaKVkkqKXMOh7Cwtd0lo7Rn4ELwRRZKRXKKmLVUAF1uAMpmtB7o8QyHcXggVyFySjy01tUQORDjTWn+ABWBXqyEXWAbRdwaF5kuNWV4h9A1eRzQI1PqgUEVkBlFnLue/8LDcC0ZZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mhJ4/Yhs; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jREGfE3fJhrURyKLEcWcB1uF+exNkJpw0TKH7Qgz6puxiY4B4UIhrpgztBogTRObqfBAXvXTaToXjlM1S1iHvZDjFsRChhsKdu450mfdhO2clak1JbHtbdpnNA7Z8BqxlcupuoHM81gUJ4+Ih/bGii6m2mByqTctMR6URvWfrR9jP7EBfjqaJk71kpp3+8Z/nZ9kHbEkDpC9WxmwuAhrtX0EPP5RpuIyR1MaNhY+HrSODISSYEhWozzsfQwdYTzQFUbiJOA4VjrWTQioktanY5jdBMxNPqkUExd5ueRibkgDmy8Ihc4DL21GWu+fUGFFEMLTMU992nda2MJBMpfeZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsD8HH8MREuEOI9MdtYJkayJqiHYLJH7WGmzUSZhcbA=;
 b=QIgmr4LiYL9YCcFjZ5KNycRNvsR2T5tEh/K2L8AlrH2zU+YaHHpDPOYXwRYEcajDPYoNtIMlYK1/h4lkzJcFkd64eniFDEJ3TNebbB/yuusaUsACtMWTe1Z75e5Jo1vl2azSxK+atAqdA4gXbZZlrX4nH38OmwQ3jW9VdKx6RZQjBhEwheE5TKTseKAEpVOdLyvSsLJ6c3mMT2wTqEF6i7tg8QuB8iZq5S/7yoiV81HEDWuuOC7Seh1g8Rzmv/hV21BxQI29vzScq8+lLnZKxZm1Csg3w2rF9Ln9kHES9HKGBvI0IAYmTKngJoiax5hFKqKhfzujQ8v+rRCmCSVUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsD8HH8MREuEOI9MdtYJkayJqiHYLJH7WGmzUSZhcbA=;
 b=mhJ4/YhslltW5GyKAAot+DPjNhwoWpAc3YKU3Wm3U2TJtS+vFG5RT2+gmwEwWAI83J14Ly3qQgJdFPf9h74nvtY3AlQBvx3SVlhYCv6XiF2wSGGHFnQ6hhXBCG6Fc/W1oBSt0drHb5xifx+sfmmxBqvuVaFxCgBm4qgiaSH8GaTpwCpgyxCDgM0NBLewGhIIYi5FVTQRMFlIj39uuimB+ohMAwTvJQJdq3Q4aJ3WnXHvHfaTxMaeatxgn04Jbm/ff2TXu3dnI3Z8H3XaahIw6BCzyGPvY0CigXN77vK02UBbwrNoNwJ2rHmYzeotdtRnH7fSaFJajIbDDqLuZ/ydNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by IA0PR12MB8747.namprd12.prod.outlook.com (2603:10b6:208:48b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 16 Jul
 2024 18:05:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%2]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 18:05:06 +0000
Message-ID: <11359c6a-9863-4ffd-8fe4-04b777c72c9f@nvidia.com>
Date: Tue, 16 Jul 2024 11:04:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: Kees Cook <kees@kernel.org>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, davidgow@google.com,
 "open list : KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, kunit-dev@googlegroups.com,
 "kernel@collabora.com" <kernel@collabora.com>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <202407150936.C32FE24CA@keescook>
 <8412a936-b202-4313-b5b4-ce6e72a3392f@collabora.com>
 <202407161005.CACE2E355@keescook>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <202407161005.CACE2E355@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0016.namprd10.prod.outlook.com
 (2603:10b6:a03:255::21) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|IA0PR12MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 26d314d7-61ca-4aae-ef71-08dca5c1d298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWM0T2JiZ3VOaC9nYzUzTm9PUkZHbTJoSmRZNmhrd0pWOFg1SnlrWjgvN1BH?=
 =?utf-8?B?ZGk5cGhXcjhaQXNhRGVHdU0xNnVwSXplWXJmeEdaTlgwWU16TkFaaDdjUUFI?=
 =?utf-8?B?QUVXMkttWldJV2daRmRJcVZvOHEwYUNuSmhneDNla2M5OXdRRFlEQ29ZSnNM?=
 =?utf-8?B?Qmt1Nllxd0hsTGFTS0svM3Y3bnFsRDd3dzZKcnZrZW9Ud2UyQjZUTEhDZWdO?=
 =?utf-8?B?dnlnV1VYSVlpY1RGQjlkcUVGMEIrQlZRRW42ayt0TCtxVkdaanQzTjRiRVdq?=
 =?utf-8?B?MlRYc3hmNmV4SER4WWJKTHY4KzVNZUxVMllIWVF6VDFWRitPdktGUUw3eGJv?=
 =?utf-8?B?WVlnVGErNEpzMEszc1I3NGs4eUlUQWw4ZE9RaTMyQnFrNFJSc0ZxVXBFTncv?=
 =?utf-8?B?MEhzTldWODN2ajhVenZuREhhdUw2SXBqd0tMdkQrNHZEbHNjWHdhOXAwSnBE?=
 =?utf-8?B?SDd4dlQ3YnlzNXZ4Nit6ZGNQSmFOK1Q4V2E2M2x3V2ZsbUd6ME1tblFub3k1?=
 =?utf-8?B?T2YyenMvb2todzFkTFFJRUl6NVhtRTBxSmp4SHJreVZld1N2VnJvNE1Zelhr?=
 =?utf-8?B?dTY4SS8zbWJvZzROekpMTGEwVSsydkdrN3Exb3hJemZZMWlDWjRUdGkwMjFY?=
 =?utf-8?B?cHhhZVpJMUFHOFNlSFNtWW9hdU1DTHRYbWoyMjl6UWE5Mkl0Y2I4T1ZZUURS?=
 =?utf-8?B?aFRLUmVtSFk1ZHBKSmFIZlZqcTh5RVA4Sk42azhsZkNORlNWTjFHN2N0R3c5?=
 =?utf-8?B?eXdzU0RmekFLZ2pDbWZjZjExT01KUEplSGJwOENYZWdIMDFIRGYzMDVoVzZk?=
 =?utf-8?B?dG8weGxhYVFiVkN6dEh0Z1llMk50dExGQ09HWkdzRGk0VGhDRlU1Mm11dnhH?=
 =?utf-8?B?dC81bjEzTXhJM28yTnVucGVlZ0h1Qk9mSjdaeGpLWkc4WjRudFpBMnkydDlR?=
 =?utf-8?B?UzgrcEhvdVRJUTIvcVdKdjRQQ2xLcnhubG1OeTE4MkZwK1ZoSWhYR0QrbExh?=
 =?utf-8?B?WTN3SVdoWVhRc1VtMnhITzE3RElONWtZenMxMnl0OWp1ekFzcnB6aGFoaDZS?=
 =?utf-8?B?bVVuR0JiYWNGQTNERHVQZ3U5L0lxdWx1WGoxU1dxL1RjSVMwSlFjSlhXOWtJ?=
 =?utf-8?B?RlVWOEQyQmRaK3R6WjNDRXRzSEw1M25oQkN3M1lITlVpWWNuVW1mSy9SMTJp?=
 =?utf-8?B?Y1MxSGRzSXZzUW9hbm1rZkxCc28zc1pUOUFWVlRzVi9DaWtJY1dLb0ljNGZa?=
 =?utf-8?B?Z1B1VFRpRzNJWG5NeHRrWTRVTkw5Y25QajRjQWk0K1FncFRPUHBibDVTL0VF?=
 =?utf-8?B?eFIzRnlmNjNCLzJJMEtVdFlBYjN2SG1WcTJudEhKbThpVFBhSmhVVkxjQmZi?=
 =?utf-8?B?RmFnUnJOSFcvcFdHVFFzYVhieVZFV29HYkVzTWtCYnRIa1RyTm9JK0lQMFNV?=
 =?utf-8?B?eXkxL1pOQnNzNlc3UXhpUG13K3lTT2tFQWMxdzduVjNic2VwbWVEYjl1MDhh?=
 =?utf-8?B?V0hwVEpWNXFsampQemhPS1VDWFF3ek42UW0xanV2dlk4TlZUVU90Zm5jcTRz?=
 =?utf-8?B?ci8zakZEeEZJVUdYdGQzKzN2MVJHYnZHYmxGejNzbVlTQnZocnphbDN2cXRh?=
 =?utf-8?B?Q2kxQlh2WEkvVHNVWnhyWW5Ybm12Y2dyTW5lSVEyN0k4bkhLWEZBaHZscG5y?=
 =?utf-8?B?R08vNnJvekZhS1NPVU5UbkR1S2FQMk90MnJqQ1ZCcXJoT1k2YzVOYjV5ci8v?=
 =?utf-8?B?T1JJZVJ5ckhhMXgrS0h5ckYxRTRpN2FONmpIcmkxS2JTL2YzK3RtOEw4a1Yw?=
 =?utf-8?B?aTRsd2c0RzMwclJZenpydz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YitxOEc2Z1U0Y29LWlZRWDJRN3g1YlZDYVVpcTFDL3k3YXVHbHd1Y1hsdDQw?=
 =?utf-8?B?aTZOR0kvWkdTazdvbDMvUjExbzF5QXNjcDBHdUdBcUNxSnUvQWEwc2tvSkUv?=
 =?utf-8?B?aXk2R3V1c1c5aGNXcGtoV1RiSjBIOVJTU0lER2VsRDRGY2xhZGNqbGdJU3Bk?=
 =?utf-8?B?akpQWlF5WCtIOGphN0d4ejZJMnRlLzR4ak5PSFUvSlFzaElNZTczc0hXc1M5?=
 =?utf-8?B?emNTRG9xZURjaldUWk5kU3p2VG5zcEJreXNDZFRzVEYvTzk5VWpUZnJ6ekt2?=
 =?utf-8?B?SXFSMGhrclpuc0dkUXp3a2Y4WW5zWE01cW5xQTRlQUg2OFBLRHcwU0JBN1o4?=
 =?utf-8?B?NC81Zm9YeU81Y0VWUHBGQnd0VXpkYlZQMjNLa2toc21vSXd5OUpDdUE5cmts?=
 =?utf-8?B?R2dHRC82L0RvM2VYUk9GaWw1aEJPb0l5eU9mOUZqeTIreGVOZUh6MFA0bDdn?=
 =?utf-8?B?RFpZZTQyRVpBRm1XQW1RWGgwR21pbHpkWHE2Kzd0b1lESEt6ckdZUkIwQ2tZ?=
 =?utf-8?B?cTluVE9yNlhuSWkxcVpLMm1NQk00MUtUV3V0M01wYloyR2YrVHhLdGVUNlI3?=
 =?utf-8?B?OTQ5OHBmNXJLSnFCYzRYU1lPM0dJQkRMakwza2xtRjhPYnEvRnk4UmI4eHZW?=
 =?utf-8?B?SFdoWUtDVUZUdkxxdmNKSmhkQlJOVlUyYmVJNkcrZWhQZ0taWFNCSFlZRXE5?=
 =?utf-8?B?MG1GaWRMTlI0VGtlQzFYVHlOUWlmSWs1UW1LVUd3b1ZXZFdaM3VzcG4yNTdE?=
 =?utf-8?B?d3ZtTkd2WFlXSExQOXlFKzFUdzl2a0NmdzJLT1hIeDRxdWE5TXh4ZmlhNGtF?=
 =?utf-8?B?blFYYTE0ZWwvd2w3Q3FyRXp6V2JUd0RRWWtBRndiRk44bEpXNEYySzU5aVZD?=
 =?utf-8?B?b01DUWZKUlVOVlhSeUgrTGJaZlNCZnFTVVRtbFk5TmRVQ2dzKzdCellYK0Uy?=
 =?utf-8?B?TnlqUUNMbDdLSUwxYTgrVHVteXhlY1pjNDZ3QWdzTnR6bzN3V3BBYnpvZDRJ?=
 =?utf-8?B?SENtYlJ3R2U1a1pXb3lhQTdYaVJrZktpY28vaUdkcHd3MFNDY3pHZUdPU2Mr?=
 =?utf-8?B?bjNJSSsxbE45RklPam1vUkZSM2k0d1hMbytPU2M4ait1M3lkRndmZmxaNEdw?=
 =?utf-8?B?SXVGcU5FSDdkTzZENFF6OFREamdsbi9zZE4xV2lPck1KZXFvTnlKQ0lNTVdu?=
 =?utf-8?B?YUE1TkNQYUlYUUVTLzdGakloMlRIZlhTNnhianRpWE9xaXJJYS9VS1FOZ0Er?=
 =?utf-8?B?M0lWbXlXSXpISndoYUM2TUZMN0JjbjVFS0RwYWVXaXJTaHBuTHJEUVNiZ0dq?=
 =?utf-8?B?cDFzcFVGZVhHZitodTFHWmMrTXpsRUtpaWhiSHgreWxTdmlPQSs5OEJIbUdu?=
 =?utf-8?B?eDlZcmwzYzBNa0ExOFhJSUNJL0M1dnBpY2RlNXRvTEh3RWNWdlBZWUQ4Z2Ni?=
 =?utf-8?B?TXJBQW9rNGdZOEtOOU5CbzhuRG1XN1RXYk5VaFF3OHUySVp0anVvTUVFQU0w?=
 =?utf-8?B?UENXTFVkMlcvZTQrUExBZkY0UFVBejZIZUlsaHN5NTl2dnQ0TFdMRytMb3Za?=
 =?utf-8?B?ZnJuYnV0eXRrc2t6TGpDRGJPV3BVUkJBL2JTekVVK0NnMjBoL0xibE5hOU1l?=
 =?utf-8?B?VXJBMWtmbVZZSGtrR2g0WVA2MFYxbGJtYlV4L3hDLzdoYXRlSzdvZHdmMGNY?=
 =?utf-8?B?NXFHdXhjeWRNbGcwcHZkaHRNc0doYXBvWUVtcmNDTURQTFFHLzhNOHRaTGtq?=
 =?utf-8?B?Q2cvWThwSjhjZG54cnU1a3pGbUZIRUdSREx5azk4b0M1bzhoN2NQSHFRQjZJ?=
 =?utf-8?B?MVdlWmkxVzFkT1h1MHlnUGQ5WGRLckp6Y0Y0d2dSbnZWOGIzTy9TRHZqalAw?=
 =?utf-8?B?VzlTbU9ndThYVlE5UGl1S1ZldldpMEt0VlBPNDNlNG5aZEtJR0h2S0R3NUhj?=
 =?utf-8?B?bEpBMEFCSWZWcVRWMGsxNjZvRHZsVkNUK3FOYzMycUcxdUYwNDZWTC9EQURj?=
 =?utf-8?B?TXdKNjdJQUtGbGMxLzMrR29wR3RvTmQrS3RVOGhwTVdrZGVQVklSTXpjVVBZ?=
 =?utf-8?B?ZU1CUWNJZ2VvSmVtOHVaYnhTQ0x5TU9ZUVA0ekk0cW04RnVxdjZQRmxGVFZ1?=
 =?utf-8?B?NVJoTUNCaUN3VzYzSWRxMkdKeW9IOENydU1sODdxWm1PZ3BPUjJ5UHhLRXdj?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26d314d7-61ca-4aae-ef71-08dca5c1d298
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 18:05:06.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3heRtmJ41aX+q7VIc8oiQDOd/9qU1wfwakm8HWFBHXtyUZVwtdJ/NX0Ufgzeq1hGRLLEpvXlfCJcXIB1QcNg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8747

On 7/16/24 10:59 AM, Kees Cook wrote:
> On Tue, Jul 16, 2024 at 01:11:14PM +0500, Muhammad Usama Anjum wrote:
>> On 7/15/24 9:40 PM, Kees Cook wrote:
>>> On Mon, Jul 15, 2024 at 03:09:24PM +0500, Muhammad Usama Anjum wrote:
>>>> Hi Kees and All,
>>>>
>>>> There are several tests in kselftest subsystem which load modules to tests
>>>> the internals of the kernel. Most of these test modules are just loaded by
>>>> the kselftest, their status isn't read and reported to the user logs. Hence
>>>> they don't provide benefit of executing those tests.
>>>>
>>>> I've found patches from Kees where he has been converting such kselftests
>>>> to kunit tests [1]. The probable motivation is to move tests output of
>>>> kselftest subsystem which only triggers tests without correctly reporting
>>>> the results. On the other hand, kunit is there to test the kernel's
>>>> internal functions which can't be done by userspace.
>>>>
>>>> Kselftest:	Test user facing APIs from userspace
>>>> Kunit:		Test kernel's internal functions from kernelspace
>>>
>>> I would say this is a reasonable guide to how these things should
>>> be separated, yes. That said, much of what was kind of ad-hoc kernel
>>> internals testing that was triggered via kselftests is better done via
>>> KUnit these days, but not everything.
>> I started investigated when I found that kselftest doesn't parse the kernel
>> logs to mark these tests pass/fail. (kselftest/lib is good example of it)
>>
>>>
>>>> This brings me to conclusion that kselftest which are loading modules to
>>>> test kernelspace should be converted to kunit tests. I've noted several
>>>> such kselftests.
>>>
>>> I would tend to agree, yes. Which stand out to you? I've mainly been
>>> doing the conversions when I find myself wanting to add new tests, etc.
>> lib
>> 	test_bitmap
>> 	prime_numbers
>> 	test_printf
>> 	test_scanf
> 
> Yeah, these would be nice to convert.
> 
>> 	test_strscpy (already converted, need to remove this test)
> 
> Yup, converted in bb8d9b742aa7 ("string: Merge strscpy KUnit tests into string_kunit.c")
> 
>> lock
>> 	test-ww_mutex module
>> net
>> 	test_blackhole_dev
> 
> I don't know these very well, but yeah worth looking into.
> 
>> user
>> 	test_user_copy (probably already converted, need to remove this test)
> 
> This is done in -next via cf6219ee889f ("usercopy: Convert test_user_copy to KUnit test")
> 
>> firmware
>> 	test_firmware
> 
> This might not work to convert: there's a userspace half for testing
> firmware loading (see the kselftest side...)
> 
>> fpu
>> 	test_fpu
> 
> Seems reasonable.
> 
>> Most of these modules are found in lib/*.
>>
>> Would it be desired to move these to kunit?
> 
> Checking with the authors/maintainer is probably the first thing to do;
> check the git history to see who has been working on them.
> 

Also maybe:

mm
	gup_test

This is a classic case of testing a kernel API via ioctl into the
kernel, so I think it meets your criteria for moving to KUnit.
Having said that, I must now go try out KUnit in a bit more depth
before I'm sure that this will work out. But it should.

thanks,
-- 
John Hubbard
NVIDIA


