Return-Path: <linux-kselftest+bounces-9629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E168BEA53
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 19:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B698DB21F6B
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 17:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DD15491A;
	Tue,  7 May 2024 17:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ADO+WV8b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C803B672;
	Tue,  7 May 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101470; cv=fail; b=KxvwoeyYGUCLImVB1CKDREeS1TfXgkvYGmkh99BM7JIM2HWHpN4qQxmcAGM9+9Ss4aUbLununPImls1dWMjNiygch5jho+mfQG6RRXFBdL6gxJogqje9G27r3TlkGU6y/XWlTt/cF4PUvg4j81jlLlR2D7CvPXXbg8do6+e1F2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101470; c=relaxed/simple;
	bh=uZTasxfg0RP5WaNTZV1N0tX9cTfjcKCdyyDCRBEf7ls=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R4nqysbmiZJqp65u3Jpyq3eX4bpPg0/khKvnSlPneUF5LFyqh0eSyPGKOlSWWcN7TPM1rDaDQreJOBGTaTjtdhFddMJrebC4omuugKTQbpKtDwwJUqHU6Zc6uPhy60B406TwphXz71I5pmKFBM/V5mHtpbxXd8p7vXUHS33F8ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ADO+WV8b; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VHw8NMiyZj8I97mg3N2WuZXXNv2J3nGVCPeRJAzik+8JZQJzLX7ZCurrmGZOinJQQjXaTpmpQhIXmrctyJTuGcQV/tpwoKrhZWDR6bLmql9YVROQ1u+2kRo9Uq16kLVINaXDr2P/aeBqWI/lBS4Tl/K3IJRlWY1JsQAw2R7zxDHk0LbrUW9S5miggzhw6G6Ouwi/zlJ9HrFm6+XSIbKh8Zkqr0iBF4IRjogw803u299/r8LCehkv4EIjLwUhcqwQWYkPC8h1ml8qSxBIQCDJggZYKRAWht23uV89DPdk/3ddHWyccMs3eaXpnN/m7gPn6qKySh04DerXsAo+yN1Bqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbEIKAvp0y4BNQ6+a2w9tZn4eng9cCKYikTnwbAd6dM=;
 b=TU8VF8WBP/QHV/vyf0eoA1aVHR2ilMlIZ04bQmivwwL590D/nnXljE4RwN77rwTQ3rEzCTNEedEbbPaxWqAEQaseHV+Kw78lA7T/r2Dv+JGtfks3+LI0CufWuWPl3Z/eMgy43W/uuO5bL+T5wurwtTQr1XhgE5re5c+eWfR67f03VbwjyCdjB/Pl+6LhQw7c7ybAkBKpTQoTDXi8aKzCp1K7jl5ftVRva8sN2Z3k7iP6F/nvOA7qnJ17lVgFu3uwpn7jq7R+3Y8BfBal8LLf0D+ybXV5uDBJGbKblI7YoemlUODjzGYRDhZ7+jMDNcu0TzxONfoHL7XC8M8yxcSncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbEIKAvp0y4BNQ6+a2w9tZn4eng9cCKYikTnwbAd6dM=;
 b=ADO+WV8bGv1psceFn3xsQs/9dqcH3ZB5fVR9BGhrotBGF2fj9p6NQ+DM+tvY7akJcZmv/6aHnBupAAzORxt9/QQrC3r1kjWRT1XG4n08pVWcGIgfHl/r+0T4GtdygxFtVCGHyhkVKjjwn6JwxJt8jrIhXeSihzq+OxTHPGCwTv8/gDAowHYm/JUwNBp5FygQRyjFm2S65/q+2JbcgaU2sz4RYlp20Ci2jEhfr00InNOtRMkW14kIwJL0I7SGloc+JoEjykIZYZPHDplHHhfS2Tt7MCxjrUJ7cRJEcsggVSH7U3MiNZoAjaboe9ELqCBlyVJhsUiSJ+zq94b1rS3G7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13)
 by CY8PR12MB7220.namprd12.prod.outlook.com (2603:10b6:930:58::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Tue, 7 May
 2024 17:04:24 +0000
Received: from DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac]) by DM6PR12MB4140.namprd12.prod.outlook.com
 ([fe80::5b0:8154:dfef:2cac%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 17:04:23 +0000
Message-ID: <c8dd4b34-f49a-4929-9b14-d2cc17e0edd8@nvidia.com>
Date: Tue, 7 May 2024 10:04:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mqueue: fix 5 warnings about signed/unsigned
 mismatches
To: Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, SeongJae Park <sj@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20240505221359.65258-1-jhubbard@nvidia.com>
 <a340524c-15c1-4b8e-b7a9-1fad52e97f69@arm.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <a340524c-15c1-4b8e-b7a9-1fad52e97f69@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0046.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::21) To DM6PR12MB4140.namprd12.prod.outlook.com
 (2603:10b6:5:221::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4140:EE_|CY8PR12MB7220:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adb216d-7469-4fb0-b33d-08dc6eb7beb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTB6L1krdXFTR0k3UjJQdE4zQklCaGNndUFIUVhiM083clhESklGUnlISVJB?=
 =?utf-8?B?SDlldFB4RkZlcXl6Sm56cUgrOXpubzYvNUljU1V5dlZnOGpiZ3Y5OVhHbWh1?=
 =?utf-8?B?dU9HUk9YeUZKR21MTjV6QWQ1NHpIRnpGTXluQ0VzblRQWnV1ck0zWDhoaUgw?=
 =?utf-8?B?VlF2eU9pWElJSW56QiszZ2RZZlR5a0cyZHhoWFVBSllPZXFUK2NEUWQ4bnF1?=
 =?utf-8?B?dVV5bG5BQkNRTlRhcTlhNmhZUkpNeXhjaVJ6Q041ajFCVm5weEs0UXZDbGpt?=
 =?utf-8?B?Rys5SXA5VUI5TU4xaEdmYnoyaEZ4U01ibHYrV2owK0hDOHU5N0xSYzZWOFZt?=
 =?utf-8?B?VWJOdzBnTXJjT2tTbVB4bjRvY1QrcnNpUVNYc1lHR0NoTUZxNFc4YkJTTlhQ?=
 =?utf-8?B?RjE2M1p3ZXlEZC84czJYUFJtQk1tbFczdmVGak1pZnVzanZhcWZRMnZ6NVZm?=
 =?utf-8?B?bWpnaU5vRHhtUFpJUVAyZW92YVAwYnNEbEMreWZHU1lmOEI1SUttZnM3S3JF?=
 =?utf-8?B?UlBOUk1rczlzdmk2c1AxN0hJSERNM0k4eHIyc1hlYXdZR0ZDeGY1R1V3b09t?=
 =?utf-8?B?UVgzSW02NXNKc3oySHZoSFZzZXpxbWgzSzBibVlUWlFDaGljcGE2UVJ2K1Bu?=
 =?utf-8?B?dXZHWDhpV1ZGTkVQOG42YS9aR1FZZ2FYRHl4dmFYc0dLWVlwOEs3bXpEblBo?=
 =?utf-8?B?bXRzdjhSR2lZK0NMRHNTUnRaOHB5OTlEQ1JhV3I4VlBTSVhYYUE0MUVEZk9i?=
 =?utf-8?B?R0psMHNKSW5xN3VsemtsdVd3ZVhhQlc1Qk1KUVFQV2VodElPbGVaTmsvdzUw?=
 =?utf-8?B?SjZ4bGNhYjNUcnFDNDJDODRLTkpObjFCRFNFcFlzTnlyQnVuYVVJTGE5ODdL?=
 =?utf-8?B?dUIzc3YwVGxuLyt3ZmRFa1g0UHd6TENjbTRtYnoyMnFXbzJWbWN3ek9ETFJa?=
 =?utf-8?B?NzMxNllzeWx0a3VrS0VCSE9NY29rVlh2TlBKbjIxVS95M1paM1FIVUJLdWRq?=
 =?utf-8?B?K2ZVTC8rTFlXTG1WRnZQTld4b2NrRGIrTis4VXpzZ3QvUmhSM0pmYXgyYVF6?=
 =?utf-8?B?ekI5SjkreGg3Yll3Znd6K0JrUktjZWZQdkdKZFhBeFlxaXViMm5qanRnUU95?=
 =?utf-8?B?UUpheVdNMENuSFhiZDJjU0o4QXdoWkYwMXdKMzQycEFlQVU5WVV6L2twVHNm?=
 =?utf-8?B?alBMWXAyVGZ2RE9xUW9Bc0dER05TVzlDL0Y5azRnbXl6WlRoK2J5Szh6ek1M?=
 =?utf-8?B?UnhRUDdWZHZwU2xVbVBHbzRNUy8zMWRXVVU5d29uMGNQU2dxcDNidVVxQWRl?=
 =?utf-8?B?cGlCTEpudHh3OFlKc1hnKzdQNDZuS013am1BU3QvZklSU2xHRVgvR2hiVS93?=
 =?utf-8?B?M2ZGWGJJNm1xSTVWRkU3ck9keUdhRDVJMkNxVDNPb25RbnVMbXJRN2xncVNw?=
 =?utf-8?B?Z3VnZmU3S3JKckV3cGJWNk00Z0N1dk4vanA2QThGNllUQWpsSTVKNWxpOUc5?=
 =?utf-8?B?eDI0L1JLM0F6dnVOb29GM2dFMlJHUDFyYUlKc1dhZGlBS0pPbHE4OUhEYzJi?=
 =?utf-8?B?WjgyUFVYZVRVUTRNRElUeDUzcDJENGNUaHJISEw1eS9FL0piMm9PNnFBNEFo?=
 =?utf-8?B?dlNQdndmUmIwNHNRV2J2WkVJanNjTTZWN1ZHMDNGN0xJQzI1aElqdXdYV3Uw?=
 =?utf-8?B?MFNNckI0TTZVNTQrdGQ1eEdXY05jNlJkVkE1akpHcGY2bGptLzluMUtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4140.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDJYSFZaUFVXQUlRSGd3bnZUNGo0a05wYnJ5a3ljVVpjUHNzOXkwenMxVDJt?=
 =?utf-8?B?eElHVFk2RXpQNHdKck5uRGVhMWc5SEJ4aTJvNWZlSlExNWs4eXB1OEJNeVBL?=
 =?utf-8?B?enVUR1BYTFhVeHZhZ25qUmpQYjlTMW5EMitUQmt5TnpPT0FmbGhPdXcyR3Z0?=
 =?utf-8?B?SjVNbHdUdVBxNkhiNDhUM2N0LzU3eFVnaEpZT2ZIaTZQR0p6TkxjSitwK2d4?=
 =?utf-8?B?Y1BkcVMxT2lXTU9Ebk9TOTJoejJrU0xtUStZQ0Jzb1J5MXBIVFBzaUJpZ3Zj?=
 =?utf-8?B?SlRVYlRzeWM4SDF1dmI5dFNYOWhpMVhqM2R2U0prWk94anFnandvL2Z0cE5X?=
 =?utf-8?B?NURjcnJ0bktYZ2w0ZG82d3hvNnNmQnZHWkFxMVpxQ1lSaldmWTIwS2ZyZ1Fo?=
 =?utf-8?B?TE9PVnNNbUROUUgvQ0VBU1NBZkhZT1ZYdittVHlIblJYdE5YeG9Gd3BxSndS?=
 =?utf-8?B?b3dUbGdGTi96OVFiWFlWNnNKV3NmVXdLZ0xoQ08vVlpsSXcvN3VDKzF3emhl?=
 =?utf-8?B?UnhBa3dYWmFDOGJxVFJNWnVNNFZUY3RiTld2NTZrNDI5bW5jcXRNMUV1K2lP?=
 =?utf-8?B?ZVlJWWFpcjc5ZDRKdUVEVG9mQ3FUL1dJSnNBaUk5UERLNm9EeHdMQVRCb0xS?=
 =?utf-8?B?UGM2VncxOEpCNVBYTmwzdjUwYmRpYUVGRUhFRFhSUUErNjVUTm5wZU41TE5v?=
 =?utf-8?B?SkJJSWJicWhBZTMvYlI3TFQvZzhEdjk4TVhWdzhrOHQrTG5YTkU2d1JiazQ2?=
 =?utf-8?B?ZnV5S1lDa29zcWNCZFhBTTc1bjFMOFNWMG5zeDlpUVVMWW1aQzRlRDB4VHdr?=
 =?utf-8?B?cmNDYU1ISGNwTFk2Zk4xWlFCZ0VhcXhDQmNRLzFVRmxoVkF4d2pLbTJjUUdu?=
 =?utf-8?B?RXo5NGhoanpLWC9xWnFMSGhIaFY1RkFsTmRyZFVTdm9XeEMzM2hmMndkQzcr?=
 =?utf-8?B?aVZXNC9GMUZXaFRFK0dkZzdPVnQwbTR1NW5hMDdxWGo0ejJ2bGdPam1UbkJM?=
 =?utf-8?B?UjNlZmZVTlRjcXlQOE1ycm0zUmY4TkhZZmNBMXlablFyYmRjZDhHQXh1VDFm?=
 =?utf-8?B?Rlc4OTM2aUNMTHFKeVp2SWlZRHRuQUo3Vk5Zd1l5amZHUVdHNkltTjJkV2Zq?=
 =?utf-8?B?N1RldVliM2pGTWhQQWxPcXZIUlNLcTNLQ0pjd0JHZ0wrU05CMDA1UzFLWVBj?=
 =?utf-8?B?QmVwYjFSRmdnVW0ra3RucUQ0Z214UWhVem9FUGtYL3g5K0FHeEJYNHltVE8y?=
 =?utf-8?B?UnJHYUk1SWRSU0tSOXZDOEltV0lLd1ViVDJoVVNqeml1MXJqcVZFTmdHVmhI?=
 =?utf-8?B?ZDNYOUFCYm1ISG9GVjlCdmwvRThJRzZFOVpEdURYSlM4UkpZYTV2bmxQRnJo?=
 =?utf-8?B?Sm8ra1krdkt6L21OQndWdkQzQys0R3U4NVhjTDBPbE11alpLeFdnU2c2RS9o?=
 =?utf-8?B?OVJpdCsrVFNDNE9TNGdQSFVNbWZDaGlZbjJ1cHdxTUdiVkZSYzYza1dINGx1?=
 =?utf-8?B?WWlUaWJsZHBkSXlMblprWDFBWjFFRVQvUkd4ekVrbGlLV3IybzgrRjNWK2Nl?=
 =?utf-8?B?SndsT0loejVYR0tLSW9sMVM4cUVQWkl1bnhpazdQOHQzK2V3MEFCdGxocmdC?=
 =?utf-8?B?dU1BR3M1TzdXQ3FpM1FmL1RlTlFYdDdxaE45QVNBaWU1K2lXaEI5T2xXYSt0?=
 =?utf-8?B?OUlBZlZrY0xXang2QWI0cEtncnU4Lzd1UjNWTHJDcFo5R3JFemhMUklVemhh?=
 =?utf-8?B?a3VWUlNYWHl2OEdkQndDOVN2SWNzN2JZYUJ3MkhhVVVDTWJhU1FBQkhFK3c0?=
 =?utf-8?B?NENCZXNUM29jKzZMQlZXczB3aC9teG1LejF2UmZoeGlwcmlqNUdrdTRNaU10?=
 =?utf-8?B?c3RXN1NHQUdSMm91c0hxVHM2cjJab0wwRGJ0ZGRsaGhrcWJobkRUeEt2ZEVa?=
 =?utf-8?B?U29xWVhwZ1J6czN5TzFaOU9lM2IrZHBPdXpwTnVWaW80cW9ubnlybHgyYjNN?=
 =?utf-8?B?SjloaDhTaER1eXZXbWR0VDhCZDRBU2RFQlFvanRuRDlqbTB3cDB2Z2ZMUE1M?=
 =?utf-8?B?bjExeUJETU9LWEtCUHFVWlFPZEVKQjNrNE11SXI5bzAyOXMwbWtESjZsV3dG?=
 =?utf-8?B?eUtWZjJpQ3dMbVY5RWIyK3pwNHAzMTdRSk1FdjRnYzNmZ3J3VkkxR3A2S0Fy?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adb216d-7469-4fb0-b33d-08dc6eb7beb7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4140.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 17:04:23.8899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Syl1slM7dbVaU/KQA3w1+3zYj/59ylznWdU+kfja8VwsARuLiUYFzi/dq28gbkfuWkBr750KMpklN65JdlDbRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7220

On 5/7/24 12:54 AM, Ryan Roberts wrote:
> On 05/05/2024 23:13, John Hubbard wrote:
...
>> diff --git a/tools/testing/selftests/mqueue/mq_perf_tests.c b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> index 5c16159d0bcd..fb898850867c 100644
>> --- a/tools/testing/selftests/mqueue/mq_perf_tests.c
>> +++ b/tools/testing/selftests/mqueue/mq_perf_tests.c
>> @@ -323,7 +323,8 @@ void *fake_cont_thread(void *arg)
>>   void *cont_thread(void *arg)
>>   {
>>   	char buff[MSG_SIZE];
>> -	int i, priority;
>> +	int i;
>> +	unsigned int priority;
>>   
>>   	for (i = 0; i < num_cpus_to_pin; i++)
>>   		if (cpu_threads[i] == pthread_self())
>> @@ -425,7 +426,8 @@ struct test test2[] = {
>>   void *perf_test_thread(void *arg)
>>   {
>>   	char buff[MSG_SIZE];
>> -	int prio_out, prio_in;
>> +	int prio_out;
> 
> It feels a bit odd for prio_out and prio_in to have different types. I don't
> have any prior familiararity with these tests but looks like they are ultimately
> the parameters of mq_send() and mq_receive() which both define them as unsigned
> ints. Perhaps both should be converted?


This makes sense, and I recall wondering about it. Looking at it again,
I see why didn't go that far: there is a mini-unit test manager inside,
passing around priorities that are signed, throughout:

         struct test {
         	char *desc; void (*func)(int *);
         };

         ...

         void inc_prio(int *prio) {
         	if (++*prio == mq_prio_max)
         		*prio = 0;
         }

However, I can probably fix up everything to match up. Given that you've
called it out, I'll go ahead with that approach. Iit will be quite a few
changes but they will all be trivial too.		


thanks,
-- 
John Hubbard
NVIDIA

> 
>> +	unsigned int prio_in;
>>   	int i;
>>   	clockid_t clock;
>>   	pthread_t *t;
>>
>> base-commit: f462ae0edd3703edd6f22fe41d336369c38b884b
>> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27
> 



