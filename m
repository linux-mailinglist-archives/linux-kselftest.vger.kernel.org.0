Return-Path: <linux-kselftest+bounces-31381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C7EA980D5
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 09:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF98188D53F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Apr 2025 07:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEE226989B;
	Wed, 23 Apr 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EBmODrpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC241DEFE7;
	Wed, 23 Apr 2025 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745393318; cv=fail; b=YpHJJSrL8MmPHjqlS+z+/kYH+2bxj3RDQeOyDreDRi86e2Owlq/5sjrd5dxHYVbY3N5lQWzlWexlLcL6vqc5PvSTCEFeDETp9dshxTTQ78zmjSMsCyv5KogxJBJQHbzHyUD3qf7yEU5BIWWb/Sd9N6cdNEfoE6tjciv5IdWUthk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745393318; c=relaxed/simple;
	bh=4Dpc/xqBoHhS/1bBumSdYhd3LN3wn87wVM9r5nuSdaA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+Hk3AAwZ2MQyxuLNgy8AZQptrJ1u8Zt0bdj2Pv8ua+W7dxj9PSvLIsnqBmBCLYxSSPItYM82NmND8Nad+1n8+sI/ZAyZvOdgLMabThij8+QGdsGxGnH7tbjEizF2xFZe0IZhd1ZtzI7rd+xS67xrl1jzrOb/MWKVJuEQUQr7v4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EBmODrpN; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awYoRaxB28Br2zv6Gt5eHE+dYfYL1BkygSbGCn6+hq1mpBzshA6A47zt8iWxKS9eqXt357nTGSbvvXkvG1bymfkRw2iMqYXQL4RAAx8GMe05ADQQBoL62DWp0OMTCbRtABLo6Rz7E/XD8MYG0yFoSYajxanWQeKuB0za6wIVRfC9H9cx/rvWES7oFtxwKCy1LWGHbvUoXMrCyK27Sw0q/ASOIgllhRNQVqC4hBWvcwjAVwIxQVu7Xz4tRHYHZFxBPvc8Ya2IK6+uaXDYXS0hkKwozc2QOQOMiaLA/UlCWcZ0G87+p0Geg+6QWtimnLz7q685l1Nj69EEjw1hLgO/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bdhh5JefwpRcfi6y+kOaF7PRXXMg4siUZ75Q4XkyPNc=;
 b=eFmANI1UKA0ANnSck5hnRD/i7dJHBMuzyUsBjqG4OaAGW1JohUvKDcd07lcV+D6WUbXr7rYOmFufEYR5R/GQjZH2bXACdJUwIYILxgcbcreK3dbkeTQHJQhpkgz383VEKMU66bEkEVKiDcm/fJbqs/nKKYAq/pEaRWPiedhq2hfVOci2iw46zEFx+Jz7y7TECI8yyEOd2eBkNhCXYsWlhiyovkSy6BusTpayUXJXbERo7oOnDqTSOKqzaK5Vc4Fcn84g9mX6dKgIH1ZSf+fJHHOwjTwS/3SUyE7OnmRlT3dvM9alGO1DOIDmACMzFePBx10qnOGdvqcGFIB3lh6nHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bdhh5JefwpRcfi6y+kOaF7PRXXMg4siUZ75Q4XkyPNc=;
 b=EBmODrpNnZwDdGyIAjnzryggT9Tv+rYmCDMvGvE8VLiJheUiEFxumE9dhQ0g0pjitIQKkYE0Ismyl8NftJjpHjbuuXpopIhAsL5sEZZEDNnq4CCdwkYCaeotP7YP2yFy47F7zRdXJYo4P6KW7quJj9yEMRG0ZZx9788zBrp3eHw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 07:28:33 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 07:28:33 +0000
Message-ID: <a0c248f0-71ff-4477-98ec-1bbd52eda566@amd.com>
Date: Wed, 23 Apr 2025 12:58:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/16] iommufd: Add vIOMMU infrastructure (Part-4
 vCMDQ)
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, kevin.tian@intel.com,
 corbet@lwn.net, will@kernel.org
Cc: robin.murphy@arm.com, joro@8bytes.org, thierry.reding@gmail.com,
 vdumpa@nvidia.com, jonathanh@nvidia.com, shuah@kernel.org, praan@google.com,
 nathan@kernel.org, peterz@infradead.org, yi.l.liu@intel.com,
 jsnitsel@redhat.com, mshavit@google.com, zhangzekun11@huawei.com,
 iommu@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-kselftest@vger.kernel.org,
 patches@lists.linux.dev
References: <cover.1744353300.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <cover.1744353300.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0210.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c285b28-dca7-467c-8296-08dd823873a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TnZhOCt3M2VWOFJQbzF1a3FZRC8yS2lQa0R4QWhmbDNMcXRWRkJHV1hSTU1Q?=
 =?utf-8?B?U2Y0L0k4enRpb24xcDVOZjh5ZUdidXRUMEx6TjBHUnk2bzgzRGE3Vk9HZlU4?=
 =?utf-8?B?eFBOUlcvOFFQY0tRdkJ6S1Z4Z05jVDZTaDM3Vit6Y25lVzFSVjFtMFROTi9U?=
 =?utf-8?B?MnI0MkgxeDV6WEtQVFg1akwwSTlma0dZd1NlMlJoZExOQng1TlI0SGxPMkJ3?=
 =?utf-8?B?cTlKU09UazczcWNUcW13Uktwb0pHZ1d1WmVzdng3Tk9iUTVISCtrSEQvMXcy?=
 =?utf-8?B?YjUvQURKNkwvbUsvQWRwclNNTmwrWnBIS0FjVU04c0kyTmFPeEZKbUZIcXFk?=
 =?utf-8?B?UTMraE5uUVcxN3pwVHNFTk5lRTR4NFNWZzA0T0tBZUhBNjBiK2lkNCsrT2FN?=
 =?utf-8?B?L3VsV3pzQXFqVStKU3QzZlY1Y29QQllCaVhUaTNaSnF6TUVVbHNzTlhGeHMv?=
 =?utf-8?B?bHNyRHJNTnhlSURkTE9VY1ZxQmU5TTVaSFpFMDYyT1BrRXdURFNFQ2xCY3pw?=
 =?utf-8?B?QXlwUnFQSGQwcXFPNDJqeGRaK2xyUmxNRUpac1lPY1h0VzBTeDJqMWhHc0Fo?=
 =?utf-8?B?clFRU3d3enM2K01kOXRpUkUwRm9Jejk2UUtsYTV0VWZVTW95eHp4NHZPTSsx?=
 =?utf-8?B?RTI5a0RNenVwNjNWVThoZG5Kb29jT2x6c2xJZ2NtNlJtL1NPMWhrTDh2bnFW?=
 =?utf-8?B?aGFGRWFkRmh3dDFvN2UwbytBTFMxMFlvMmFRc3RvTEVPUG9RenlWbVBWMm04?=
 =?utf-8?B?WVdJUXo2dUYzZE5KWUlBSWt2VzMrWXBZdm1jUXFwTVFWOGlwNC8rMTVyUkFh?=
 =?utf-8?B?QnFvdzd4ZHpPNTJDd0pRb0xLbkVDd1RGRzdxbjVQRE03TCs0UXd1TkV4eC9Y?=
 =?utf-8?B?dGEySk5pNjNqL1ZBM0RvM1BtMEs3SHJLRGJSZ3dZa0plMExzaVN3NDdDWWR0?=
 =?utf-8?B?QU1CMFVOSFhYbFl4UHpiQk0wZ3I0QWl4SXJMOWhQWGNUYWE1VGlaSnlOUDFU?=
 =?utf-8?B?bUx0ZTVjWFgrTGk2NjhJR3lhekk3bWlpNzFobjk5QU9vcU15K0tpNW1RMVVG?=
 =?utf-8?B?RmJzTC92NE1BMUpyY1RGTW5PYTVwK3lJZ2swOWFaNFo0ZmF3akI4WW1oY0ZO?=
 =?utf-8?B?VlVoeGxMYnRrRXJUU1FFRHIwLzVBUmZqUHF4a09pZFZneW90SzkxZUF6cWtZ?=
 =?utf-8?B?ZVV6TzJ6aHJqdEh0MGNCQTEzRlhKTDFzOXFhcVlRWFpuMk5KNXd0bStvMGRa?=
 =?utf-8?B?TmV5dWMveGZ6SExuK3dySTNjUGVTbnFqMjY4YWZnOTd1U0FsRDhjS2dQMHlT?=
 =?utf-8?B?QVFDc1lqV0JOSHhyWFJ1YTJqRUZDUEVPSjVmRGpiMDFXck5IZWQ2OVJPcTM2?=
 =?utf-8?B?UXNibzNyMVN4MFNMOXdMejY2TFFmdEx6OU5JaUVaOGZUQUpvVWNmQ3BJTVIx?=
 =?utf-8?B?QXBTcnBIYW5SUW40cS8yNTlMWVFzRGl2WENwSk9HaTB4aWlSUnVaOHVUY3Qw?=
 =?utf-8?B?cE9xZDRhbXhBQXROSFhBSXNSNStmbkJDL1FwUTh0RDJvd2E5cFFFS2VjSzNp?=
 =?utf-8?B?RVNFNUxqQ3h2QXNpOHBicVlYdXlBWkRWRlE1eHQycTdNTkpiV0NUL0JlUFB5?=
 =?utf-8?B?WVJ5ZnpIdXNpRjgyK3FIa1B3Qkh2Y2hWbk9xMmlZMzAvbFFMM09CTEhROW50?=
 =?utf-8?B?OVNLTkZuejN4YS9rYW1GdTYwRDFrcXJISDIrWTQxSkt4ekVNMU9kQVpTRnhp?=
 =?utf-8?B?a0JIN0txNi9iUGFnSFZlSUU0T2cxcXJ1TElJT3JLckpPS0RGVXJnNEFxa3dm?=
 =?utf-8?B?R3RZTFUwM2d6RjNZVWdxMnk2YUlaU2FoQXFoQmhXWDd6cVQxbWV4U2NDem4v?=
 =?utf-8?B?MytyZU54N05JbWtDbE1EMG5rR1crRFp3bGlYeU9zZ2FFRWJJdUV6aTNEdGoz?=
 =?utf-8?Q?8fY2LwnOkZA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDgyYmJZR3NVV01VVjhaczNQN045OGlZQUZvdTF1SHYrNXZyYWtWelFwVytP?=
 =?utf-8?B?dUZObE5velozTjRmK0hXcFYxWmlxa2ovbHIzeGd1V1hNQW5PelFPM3ZwOVpM?=
 =?utf-8?B?ZkhOMGswQUEvYk8walhNTGIwL1JpNGNYNS9Ea3JGVDdJOUVSSm9ITDAxbmdM?=
 =?utf-8?B?YXFHd0hLNnFmcmozdGY2SlR1ZlBrcWdMbE12cC9DWitLQUI3M1hMQ0J3QW5S?=
 =?utf-8?B?Y0psRnlrNjVwR0g2NGhCZ2lMcTlOblpsM1RiK0VzaGRLaEdQQjA4VGI5czQ2?=
 =?utf-8?B?WFFrOUxhdG1TL0h1TXBRRkw5TDBKUkdVOXhZM3QxREdXS1N0MmNPWHJzNXM5?=
 =?utf-8?B?MHQxWWFWTi9MaWFIVmxQVGp1S2VxOWVOMEpTeDdsYzNsMm8xTWo3YnRNakh5?=
 =?utf-8?B?RGM0NFYweEUzNEdHbFRVbkhkQnltWjNaTlZ6RWxSS0tWZ2I2eVgzZWYwYXhJ?=
 =?utf-8?B?TWJWYzEremc5OEx0MmlxQ25OSVBTUnJmdnlURkdzTTM0ZzF6enc5Rmt4aGlj?=
 =?utf-8?B?SGJvY3pRcFJ6blBrWE1CVDVKYVlmZXI1aER5eXVZNGEvNU5JQWtFbEgySUpz?=
 =?utf-8?B?MnphQmY2SzluNU5LdUxLekRYT01HaFdQeFVJL0N3aTdSa3FvaFl2dWZycFEz?=
 =?utf-8?B?N0FIZ3AxWnRVMC9oa3B2RUxwejJPTkFlL1pZSzlWd3V4UEYvYkRaQStBWm9s?=
 =?utf-8?B?S3RybUcwZWV0QnlZZG1Eb1pwS3NoUzFGa1FPTDlDQVV3bEVWeDBaemxORzlU?=
 =?utf-8?B?bnVLbVVITUgxVVdBMTYvTUZZcXRMTDhVSHVJKzJlbDY2a1ZnL3VHQWljM3JT?=
 =?utf-8?B?VnJpbHhiV3RlNHBUVHR5b29veURZdGJzN1JERDNNdnUxVnpNVGZqTW9URTVT?=
 =?utf-8?B?dFdYdWN0QkFEVEhPcDR1VmN2SjdEZmVyZ0RGdHFhTUhzTFdIYzNyRERoSFUv?=
 =?utf-8?B?Y2FwWFlZd3VIR3NmZGNZT2pPZ0hxWmxTcTZQM1JvM1ZLb2ZFZzF2YVdLcjhO?=
 =?utf-8?B?VHU0Rm5kUThxc1J2dGUrVXR3RWhiSzA5MWRYaTJqeDU1cktTMmFTZDBLbDRU?=
 =?utf-8?B?cDVPN0hWVGtlU3BiTkNyWHROS2p6ZnBxMW9ibWJYYmxnaC9UaGs1cklYZnk0?=
 =?utf-8?B?K0Q2a0RLZlh5d3hsYXVCdDA3TmxHc1JiVDZmL2diMDdDalM2dVFCQlh6OGpu?=
 =?utf-8?B?MHJDdHpIQ3pGck0zSjFZbHBGa0NYcXloRG1GL1owY0ZBOURQdksxOEhxR0hW?=
 =?utf-8?B?am1jSTI3ZCtWVGdDajB2RGhTZmpma0hEbWhqY3BnMlE5cWlBLzVYdWd3S0Mv?=
 =?utf-8?B?WlNRU1VSeHR5VEhqUjhHSkdpc3p4d1pBaGg3RU9vVWJCWkhiZzF2U1luZnpi?=
 =?utf-8?B?Sk1Lb2E1OVY1RStVM1ZGcjV5K3NSL055MDZLcXNFbU0zaTBEQkYyNko2VkRS?=
 =?utf-8?B?bmlVL2JPSEZDOGFuZHAzSlpodW5wM0VUZXVpOWlXVmg3cUZ3algvbjhyQUta?=
 =?utf-8?B?SjQyUjdkaWlXejY0dVpEOFlMWG9qK2JkckNEaVdwd29ZOE03SXJyY09TR3VL?=
 =?utf-8?B?YkZJWkZsMzI1azZQZ0tDQy82OUdzZ0J3NDJrVVhab1VTazBNblVaaEZsT29X?=
 =?utf-8?B?RUxIRmQyVGlrSXpEU1J3SENzbmR3dmNqZElnZGVIbjlVaWNaZDNjQnJVNy9P?=
 =?utf-8?B?a1NkSUNHdk1PMnYzNTdIS2djcHk0Y3oxNU5NUWU4Q3FVcW4vbE5zNnlrb0c3?=
 =?utf-8?B?OGVoRGN4YkdjcDkzQWpQZW9TTDV3NFozOURlNjJuYUIrdmlkQlRPR3BtdWoz?=
 =?utf-8?B?QXR5V3NmNDkzUThPNzNQWXhtN2NrMUJRVUgrZUV0RE9DRGY4Vml5b29sUFNj?=
 =?utf-8?B?THg5ZFpYWU1GZWlJNFY2VFFRUW1nMDlWTUl6ajlML2s5dHVKRGNGbk15NkZJ?=
 =?utf-8?B?dmJwci9hWGk5QjYwTzlyS3VYWTNkNCt3MXA4cUhiRDQzOHlCYUpiV1pFVVl5?=
 =?utf-8?B?dFVJWU1CN2M5ODROV3VPWkJoV0RaV2x5NlNCTDlzM0QxVkxTUGhMdERwQ1BG?=
 =?utf-8?B?Uk1ObXZYRmdxUTN6d2ZPbzg1T0ZsNkJJMU9vQ3k5ZzBuakNNS09qQnNESEt5?=
 =?utf-8?Q?/pQ9hmMQbDXksKuSaPIpgsH6U?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c285b28-dca7-467c-8296-08dd823873a7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:28:33.1288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5zfOXiRMB8a3Wo8EkXZA3n1eF2Jj4OMXYCeSKAJTBlyvauFQ10Pb8oTzoKtqutb5wcJfAmqD9zyjSv8o7xJ1YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201

Hi Nicolin,


On 4/11/2025 12:07 PM, Nicolin Chen wrote:
> The vIOMMU object is designed to represent a slice of an IOMMU HW for its
> virtualization features shared with or passed to user space (a VM mostly)
> in a way of HW acceleration. This extended the HWPT-based design for more
> advanced virtualization feature.
> 
> A vCMDQ introduced by this series as a part of the vIOMMU infrastructure
> represents a HW supported queue/buffer for VM to use exclusively, e.g.
>   - NVIDIA's virtual command queue
>   - AMD vIOMMU's command buffer

I assume we can pass multiple buffer details (like GPA, size) from guest to
hypervisor. Is that correct understanding?


> either of which is an IOMMU HW feature to directly load and execute cache
> invalidation commands issued by a guest kernel, to shoot down TLB entries
> that HW cached for guest-owned stage-1 page table entries. This is a big
> improvement since there is no VM Exit during an invalidation, compared to
> the traditional invalidation pathway by trapping a guest-own invalidation
> queue and forwarding those commands/requests to the host kernel that will
> eventually fill a HW-owned queue to execute those commands.
> 
> Thus, a vCMDQ object, as an initial use case, is all about a guest-owned
> HW command queue that VMM can allocate/configure depending on the request
> from a guest kernel. Introduce a new IOMMUFD_OBJ_VCMDQ and its allocator
> IOMMUFD_CMD_VCMDQ_ALLOC allowing VMM to forward the IOMMU-specific queue
> info, such as queue base address, size, and etc.
> > Meanwhile, a guest-owned command queue needs the kernel (a command queue
> driver) to control the queue by reading/writing its consumer and producer
> indexes, which means the command queue HW allows the guest kernel to get
> a direct R/W access to those registers. Introduce an mmap infrastructure
> to the iommufd core so as to support pass through a piece of MMIO region
> from the host physical address space to the guest physical address space.
> The VMA info (vm_pgoff/size) used by an mmap must be pre-allocated during
> the IOMMUFD_CMD_VCMDQ_ALLOC and given those info to the user space as an
> output driver-data by the IOMMUFD_CMD_VCMDQ_ALLOC. So, this requires a
> driver-specific user data support by a vIOMMU object.

Nice! Thanks.

-Vasant



