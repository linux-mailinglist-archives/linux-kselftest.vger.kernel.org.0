Return-Path: <linux-kselftest+bounces-17148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 519B996C3B7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 18:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B7F2827E7
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2024 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6E11E0B9D;
	Wed,  4 Sep 2024 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aRcCklOQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD1E1E0B8F;
	Wed,  4 Sep 2024 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466529; cv=fail; b=TpbiwoW6cNvvoMMPQNG0U8RTJTpSfPUlVD4ujBvLbFvCSQuxkyzTXa80oF3GVOFsm3cR5O8t+ublncQvDgC8yfG0DcTqE7e6iYsDEnuwJlgC2TQHqbqqKcDRKig4vc0AZs8dCSX2TEzdsKA8t4hZQGGiFRAe/2qzaOXH4SuLv3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466529; c=relaxed/simple;
	bh=e1JXhpM0lezL033jWa0o/O8lbyCLkSveJ1essR2xqTA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JEVct0r2Bpkr8eY1E4Whdb813sODwTF075C2YblCeoOduskk3MSSpsiJPKDz8jSbyFPVnLwAITbjyKYopgT17fB7lJ5l0as+qhVw+HT1TKQWqOXyOlqLRT8vo1TUw0In7L49DmJ1jY9ABnFxMg70eImslRN0LD1hLBQUxZjJHWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aRcCklOQ; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNSEKbxgK5vCfH3+UFp47q9KQIiD46SYUs9DBKIpotUBlvp0PKC9AtA8BSAQy3zgAD+P/lUM8s7Xl/NSgiIamQtWyYqcKOzAky5jhBbL7mUpNuHwXfg8FFfFi48LnxEYtuzlzEm7AncDTAMR5jdYeDHjdxBI2cSdPHeZzrTjToOyKv3E0JZu5pjVD2/nMqTjUv8H1Ph1A41J+zL9/zKTiCZWGVr9QLZZbYTmt53CBClmVJS0P5+juRPvhPqHAadODymZ8fA9ZohtMgm5KSwaDCn3HNYtiI///LK6mOh97Zq3hkpkqvgp4mAIp3a+7+tED8z00OFdK/gw74jjo3D0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9W/LRR4xZOP/3kSFRcg5XRHBhtcNeXdrtkFDlnwb4A=;
 b=E6jj1pApTHjEEOZUDNlsXrS1NrmUrr8+oI38ww6s8JRi0l7I9V6bFHc6tx1mWxMTzf/2DuzyoHPGk9in26kXMvSCCCj+MboLnqUqsO2vjY8qlD7uzo/z5QLOCoLeXrOlRRmzd/ocl0VkrxSWLowNSlwavby8NBrr2mzkNeF5pbaTvqq2uswtMw7RLwwQdpBcuQvC4V8u7TgX5aB9KYDZTQWVNDUQXkfMPR1rzWxAh7NmQGPUHBRnJ1u0w/Ofz2ENbuGf4Qhj72WVDQ2eIHUYj6UfX2vb4DwX/TSRGrzRIpiL4YnMZDhnGH0IEVPVlql85oDbCelEhQ7h4pFjw0/Pjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9W/LRR4xZOP/3kSFRcg5XRHBhtcNeXdrtkFDlnwb4A=;
 b=aRcCklOQ+zN680A5GQbUg8EF91/bEHacX/xXbkU+4OapECHtccD/3vdAzCD5OGr/w0Ia119RxU/BeQHJGOmmN+yEhmMH2WmdxS1OLLVIaF71UsJynJC/g+A98D28ox2eOILH0UtHwGADpxKnfrUCo6u3vbCD0mxN+Gt/Z01rrHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by IA1PR12MB6185.namprd12.prod.outlook.com (2603:10b6:208:3e7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 16:15:25 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%3]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 16:15:25 +0000
Message-ID: <09a5c481-883d-48f4-81d4-1028f7cd72d7@amd.com>
Date: Wed, 4 Sep 2024 09:15:22 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] selftests: lan743x: Add testcase to check
 throughput of lan743x
To: Mohan Prasad J <mohan.prasad@microchip.com>, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org
Cc: shuah@kernel.org, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, edumazet@google.com, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 horms@kernel.org, brett.creeley@amd.com, rosenp@gmail.com
References: <20240903221549.1215842-1-mohan.prasad@microchip.com>
 <20240903221549.1215842-4-mohan.prasad@microchip.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <20240903221549.1215842-4-mohan.prasad@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0196.namprd05.prod.outlook.com
 (2603:10b6:a03:330::21) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|IA1PR12MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d9bd41d-e06f-4ffd-1069-08dcccfcc89c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzhreEY0NUpqZEJCcm1xQmg1Wnhjb25rQXJub1hoSE0zTlJ1bWdpdG5ESlUx?=
 =?utf-8?B?ZThJaGFIU0JiZjdrUWx2Q3l3ZWxEaVlEanJZeFlLdXg4S3VjbXgxbWhUYXRv?=
 =?utf-8?B?MGVZemFyZFRoS2NXS29mVDFidEpQam9nVVo1aWcxWUhzc0dseHNvSkxyc3gw?=
 =?utf-8?B?VWVXSXV6MS9YSTRjYmVQUVhZeHVxNk5YZjFJQ2F0T0w4MzIyeVM1bnppVWto?=
 =?utf-8?B?UXVmdXB2R0ZBRXZpS3Y0Zk5tc09vU1hIRnZEd2dVM2xLUzRsd0tWd3R6cHh3?=
 =?utf-8?B?dndSWDY2aEltSDQrUFJYM2ZJUGRRT1Q1NW5mVk84ekk3d3cyd0MzdzQ0NXNz?=
 =?utf-8?B?U2p2UHVWOTZvVUFnRitnOWx0OUdBRXFHdGFsOXpGWnR1V0JjTWdtSEU2Nm15?=
 =?utf-8?B?SDFSUnhoMlByUndBeDlWaEtTM1M3dVFXd2R0WWZ2M1daTTM5OG52TnY3LzJn?=
 =?utf-8?B?UlJLL0JtUS9wWGtXRjBvU1cyQkI4UVc2ZVlTem03Nks4eURBVnNIcEZZSzFk?=
 =?utf-8?B?czkzeWRNSFZlRDlKYTBvOTRESDk2ZERxS2xFcG91Yys2cm5ueWJCbHFEd0VF?=
 =?utf-8?B?cHBBdERBcFRkSHhyZWpQcExRTWcweWtaU0MwTFdlUlA3dC82SE9RYVRLaXNC?=
 =?utf-8?B?OTJCNnNHMzlGbW5lTUxGay9pUElhbHZNQ1Z4V3dBWE5BS3M0dlY2K0pCYXRL?=
 =?utf-8?B?Z294SFVoVnIwak1GdDBrNE5qL096NVQ1TDIzTXZmZkFaVlhLdzhGNmRUYmsx?=
 =?utf-8?B?RW4yckh3RnY3bnNDSDlEVzNnSFhDOHdWczM1VHhtOUtON0w1anBTdndVVDJN?=
 =?utf-8?B?NWlNaU9ZR0VUS09KL3Rlc09BWEhackUzMy9EV3hNU1NDZlFmQnRSaVJzTWc0?=
 =?utf-8?B?VVpEK0ZvTDZPRTI2M1N4YXJFcDVkYVRzelk4UlowUFJiSzZwRnBkcjB2RzE3?=
 =?utf-8?B?dHhZMFpJRW1RY1NKUWltNnhsWVRZd1pBbmNWQklqOTdZZElGaTNkWm41SklH?=
 =?utf-8?B?ekQ2YmRML296eU5KM2l2aXJXTGx3Rmw2TE4xZSthaTFSbzRpbjhZSUFWQlFs?=
 =?utf-8?B?amxKajhXdXFUNFdVZUIzWEo2emp6aGkyZEY3VDRya1NVU21SUkVKNjR4WDZ3?=
 =?utf-8?B?U0cxZ1ZFM29aMzRWQ3hadXpSeHBMYm43OGFORksxbzhaYU9qWmxBa3VFT2Yv?=
 =?utf-8?B?YmNzUTdnS0VST3d1QlhraFBXR2hkYlQwVmkvRm9ibVBHbk5GOE1keW9nM0tX?=
 =?utf-8?B?WWRjU3c2YkNuNmpaTFM3WWwzNW5MMUIrTHREUjJRY1F3eVNGb0NwSlJCNWk5?=
 =?utf-8?B?OFBCNzRZUnBXcHZzN1dqZ0locWJlOXNDYXMwR0s2T1RRSmp0OFpOUjR3elZK?=
 =?utf-8?B?WWRGaVJZeTdyZHd6VS9UbWVOQ1VONVV0a24rWEQzQ1lVL3hIQnovVWJreGtZ?=
 =?utf-8?B?SlplWGg4SDE3aStxRzU1aTJrTDA1RGZVdkZZMmg5Y0NBNGwycVhVRWM3dlQ0?=
 =?utf-8?B?aGQwNkgxWDZ4Z2g1NHFaeWxXcFh3ejdHM2oyRnRyYVRFTXpiSVg1UDM1VUg4?=
 =?utf-8?B?dUxpS3puczdFK1RrcWNsOTZjd3ExYUV4SjZuYkFmSnV0cFoyUG4rY292TVh4?=
 =?utf-8?B?d2xGY29EM2cweEdwazZ4VVNFa3JXVnVSOHluazE4WWpDc290TXMvUWFROVZs?=
 =?utf-8?B?M2tkNkFkMUgySm1SRzJBRWtqSDVGTnRkRUpkWEF6ZHZrSitsRWtLNTVvalVZ?=
 =?utf-8?B?Z0ZHMmQvNUhSb1VtY0xBS1Y5dTcwYkpVaDU5UTNFTmlBSDh1ZzREK0xMVGxi?=
 =?utf-8?B?Zm1KSHlobTd1MXlqR3BZdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZC8xOTIzaGs5NnA5VVlnWVB0TGVnMjlWVVpadi9Pa3VHcWNSNFhQaTV5dWFi?=
 =?utf-8?B?eElDdmY4SmtycWVIM3hVVnlUZkRiRTN2SzZmUGlaQmtublIvUFRYd1p0MVlh?=
 =?utf-8?B?N1JQS3V6NmthVHhOS1pCWVZKbkErd2JKYU5nUVU3ME00WXBlMk1kL2hwc0ZK?=
 =?utf-8?B?YzVXWGhISDA2aE4zNTg2ZFBNdVk5N0RzanNGTzNTUGdHdjdBTkdYa3BPa0to?=
 =?utf-8?B?bVBrY0dJclNuVHpCOTk1TVRhQmxObEtWRHNqa2NDYTRrWncrL2lBSmpUa2Rl?=
 =?utf-8?B?NVVaMm44VDkyb2JzNmNWdUF3U0xhN0JvQmxGT2JKU2Q4QjJmMm9za1dwYTRW?=
 =?utf-8?B?TkhDNWhuZUkzbzZVOEJjWnNOMWYrQmg1NkZkOFJibVFRc0doS05WSHhMTytr?=
 =?utf-8?B?WElZS3hCZ2FvVUtWUDVtc2FvZ0xaRHF1dVl3VVkrekQvckZMWEthOFh5ODln?=
 =?utf-8?B?T1BBYS91cExjbjRSUEcxN0dGeGdjUEIxYXRURnBSL1J0NG9ESDJkL3h0MXg2?=
 =?utf-8?B?dTJadzBaaXNGRDVuSHpkOEdFTHdlZE5DaEQ5dnBiQk9DM0UzY1hWTThidHlp?=
 =?utf-8?B?cno4MFFiRlZTZEQ1RW9ubEZOSTlGOW9IOW1ObTIrUFdDZVVTRTRrRkVpbTJB?=
 =?utf-8?B?TjM1RjlwQTNPRUZlZlVRTE9hZG40M25BZ0ljZWQvZzhaL2RyTS9kWFR1ZlhY?=
 =?utf-8?B?ZWQzcEVCeVoyRExVNlBmYVJaQmNyL1MvK1dRMkFhK3BJYk1CWHVQRk00amUw?=
 =?utf-8?B?RHlPZlBneCtVQ3lvZTlMTzBEOXp5R1hhbElqT0FneStDZWVVNWJqSER3UW5V?=
 =?utf-8?B?ZmxTMXlXK1RTK0kvN05MZmVUbi91WnRTa21UR1AxSkRkZFVTWEpKazdHMlB0?=
 =?utf-8?B?SDNVek40YVVqUGFoMllQVThLOFV1TlFnbnNvR2oySVhXQjlOWjIydUJuOWEz?=
 =?utf-8?B?WnQwcHNjQjlsS2U3bnN0dG5CL3R0SnV5QVJtdlBBcU9GMys0VWw5Y2FvRld5?=
 =?utf-8?B?aXZIWXdsdkJCenNmVVk4YkpPalg2Y2ltQjR3Q2xZbStyMnZSTVFyTEpaaHpY?=
 =?utf-8?B?ZnM1NTZiTHRHcmJXMFBibWpEZ0pRWHBCcVNTb2ZYa0NEdWpKYk1pTFBBdzZN?=
 =?utf-8?B?cFA5ZWRYTWR1bmZzZUhKamNHZjdmT3pGU3JJdUNsNllHdXpOL1kzS0RZYnVz?=
 =?utf-8?B?dWRNMW1BVDVkbi9MUUxuMDNUVkNJbmdHYXk1MmZTZXlLZDU2VkQ5cG9CQmZM?=
 =?utf-8?B?M09ERW41VS9vL1VIK3E2MHQ2aW5GeW9mREtvYTlhcUo0YWZvQVAzblgrS1JV?=
 =?utf-8?B?STdydXp2Wmp0bi9td0JpZnFIWFYzUTJtTHdpMmxvZ2dJZGxYeTJQZnpNcG8v?=
 =?utf-8?B?M3puZm9tNnRuNlFKOWlodmVsVmd2MEFGYXVDUFBzaDFVRVZYMUo3NHArWGUx?=
 =?utf-8?B?TVlWQlJwbWFCUURtWUtOSzk5b1dQNXJkMmRZNHc5ZjZUK2czQkg2RHl3S2pM?=
 =?utf-8?B?S2NGZTZlajA2aU9BVXhRWEhqKy8zZ2FweER3bnVBQVJGT1AvZ202dFRHRVJ4?=
 =?utf-8?B?NVUyQ2V1Vis0Tms2ZDhiNlUzWFN1UTlYV24yRFpvbmo4T2lUMUZmcDNOMHVG?=
 =?utf-8?B?emIvbHZpOVl1RGRFcWVTVTRFallpeXdINmowR3BlZmtrS2ErR0RweHhMV2pF?=
 =?utf-8?B?WTY1K2lDZmNSQmhyVVZ4a2JQcFdMUDVrVHVDQXkyMFkvNHZUT2JmTHJlRW1S?=
 =?utf-8?B?WjRxT1dWWisrc3RVbnMrKzBtZFJFOXE1S1BZYjRLQjdlVHBONGNzZGdCYjZr?=
 =?utf-8?B?akc2TFc5Sk5WUjBkV3JsSlg4eC80TWdKY0NxelZaNGc4U0ZUUVFwVnVJNXNl?=
 =?utf-8?B?VktpTlNVc2ZpTVRXaE40V1ZEZjJiTTBwMjdIYkxtc2R6b2ZYRUVucjNybzZB?=
 =?utf-8?B?ZW1xKzhRU3NPMWUrelRacEJleWNES1FFandjTWFUbCtFRXFVeUFVVkZFL3I5?=
 =?utf-8?B?WjZ4SG5TOXU5UkhDYlFiMXlXcWo5TUhIOFU0dmdBc3E0eDIydE5DbWFRaTEx?=
 =?utf-8?B?TnJ0RTFNQ0tzWGxjNkVtcG8zR1JsWUVWMXZ4a2FxcTFUKzZOUjlpdU1QRjll?=
 =?utf-8?Q?/OUmvc+wpJQF6J3pHGLgpIgO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d9bd41d-e06f-4ffd-1069-08dcccfcc89c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 16:15:25.0692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGl0Xryr1h95LvQkd0APXVS0Sr7PRifHIw5S37Cxnyk7Rm93zJp1fEa51u2NrkDaDCs3Dp66SB8Xv5llEHY4VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6185



On 9/3/2024 3:15 PM, Mohan Prasad J wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> Add testcase to check TCP throughput of lan743x network driver.
> Test uses iperf3 to do performance testing of the driver.
> TCP data at different speeds is sent, received and verified.
> 
> Signed-off-by: Mohan Prasad J <mohan.prasad@microchip.com>
> ---
>   .../net/hw/microchip/lan743x/lan743x.py       | 33 +++++++++++++++++++
>   1 file changed, 33 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> index 59f0be2a7..a3dcf7896 100755
> --- a/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> +++ b/tools/testing/selftests/drivers/net/hw/microchip/lan743x/lan743x.py
> @@ -3,6 +3,7 @@
> 
>   import time
>   import re
> +import json
>   from lib.py import ksft_run, ksft_exit, ksft_pr, ksft_eq
>   from lib.py import KsftFailEx, KsftSkipEx
>   from lib.py import NetDrvEpEnv
> @@ -75,6 +76,38 @@ def test_network_speed(cfg) -> None:
>               time.sleep(5)
>               verify_speed_and_duplex(cfg.ifname, speed, duplex)
> 
> +def test_tcp_throughput(cfg) -> None:
> +    speeds = ["10", "100", "1000"]
> +    """Test duration in seconds"""
> +    test_duration = 5
> +    target_ip = cfg.remote_addr
> +
> +    for speed in speeds:
> +        set_speed_and_duplex(cfg.ifname, speed, 'full')
> +        time.sleep(5)
> +        verify_link_up(cfg.ifname)
> +        send_command=f"iperf3 -c {target_ip} -t {test_duration} --json"
> +        receive_command=f"iperf3 -c {target_ip} -t {test_duration} --reverse --json"
> +        send_result = cmd(send_command)
> +        receive_result = cmd(receive_command)
> +        if send_result.ret != 0 or receive_result.ret != 0:
> +            raise KsftSkipEx("No server is running")
> +
> +        send_output = send_result.stdout
> +        receive_output = receive_result.stdout
> +
> +        send_data = json.loads(send_output)
> +        receive_data = json.loads(receive_output)
> +        """Convert throughput to Mbps"""
> +        send_throughput = round(send_data['end']['sum_sent']['bits_per_second'] / 1e6, 2)
> +        receive_throughput = round(receive_data['end']['sum_received']['bits_per_second'] / 1e6, 2)
> +
> +        ksft_pr(f"Send throughput: {send_throughput} Mbps, Receive throughput: {receive_throughput} Mbps")
> +        """Check whether throughput is not below 0.9 times the set speed"""
> +        threshold = float(speed) * 0.9
> +        if send_throughput < threshold or receive_throughput < threshold:
> +            raise KsftFailEx("Throughput is below threshold")

IMO it would be best to do these checks separately so the failure is 
immediately obvious.

Thanks,

Brett
> +
>   def main() -> None:
>       with NetDrvEpEnv(__file__) as cfg:
>           ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg,))
> --
> 2.43.0
> 

