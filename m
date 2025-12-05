Return-Path: <linux-kselftest+bounces-47213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3DCCA96DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 05 Dec 2025 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BD83018B55
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Dec 2025 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953FF2236FD;
	Fri,  5 Dec 2025 21:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hC1d/Hpw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010035.outbound.protection.outlook.com [52.101.193.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC5B1C3BEB;
	Fri,  5 Dec 2025 21:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764971483; cv=fail; b=tSs5k0EEJUUrobv40Br1fB3GFT6FXX2T4zkx9LwgywtVB1h/i9PLFYTtekQ3t59WUPBhdJDgmC5XBkztMZMGs33MUSVE0C/tKwIQOEM9QlC2U7M/cMFU4wX/CnhC0yBy0xoD16xrZttCpHiVp4dB4l0sNbxpeWFQfKnnBN9p75c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764971483; c=relaxed/simple;
	bh=Nw8LDS4pYoXkTQvOC6l7K3J+FniwBeeSK1JN6JugCxY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G1QsgpK+u3Zd41tIdCINeqMpFHwwwf2PaTdGJYsJdkmqyCrgzxsQ5Qw5iHYEweAZkCNdi2hD9gVyHC/oRlQa4Fgh8AAW8kZd7u4wWTgf9b7zYXN891fgK4gHVkTIfYYvqw3mW6MKOOdFC9fCj5B9x5ElVnIM667v2QXUW2d7NuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hC1d/Hpw; arc=fail smtp.client-ip=52.101.193.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNk5Ev0sA0raQxvBUEXGgqi6Ziqy9xspJyIXE9zsdkOVMjHAa2FpAjLGwIybufGp9rv6gX0zavGS7FWiuhF2crNggzh88eD8JbAkMppBB5ATZyRIBceiRDmeHn23LTDkm459UuVEYrdYdtWr9OvqYEtrU5fJ6us78rF1pVfiwc7vEG4zu/j2mI5xvIJWvVWAXB925abXnzHEGOM5ve34Y+/+ytLieQ1vuH78nTJaTesH3nAb15N66l15AsvwhzYuX57YM/51I9VhKZZjy058o9uKH403I7cdX4GZ9f05AStpK8TsJI2VL9wkcO8+4G0y1o6PAdyYdIUd4Fk/xRji5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nOX/u6/fkarSBRP6sSx/HPK2SCyYvjRV1Gi8FTmbYM=;
 b=VPlEs2iZCGcYx+SLysLIjpFBemuoAHRRMK+GNnmnxAvbERP+r4e+Bft0wLf1jaJAG0et26VM5lJiV1PZrTlLhzwgR4gmWxh5I9ZJ1PFSLZ8IWPJhKbrAhb8U35f8kom5ST1gl9KTHWdWrEaavE3k1x2hwE31H3ruPc73j8dSw3mHiPjXGnK2MwjrYNIL72yVIhWXtLAPDfQYMC4ictaZjLGs/9QZVHQFc5+Jq8xQJT+FkICS07kwX21JGtkejuyr++MNIbi6s+QNn+6KH1C68RI3FfeX9uxxWd7K2SvnL0REe/J7k2mx/6c0wUTRiuM/GDpBNBxv+NhNqIXjSdivYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nOX/u6/fkarSBRP6sSx/HPK2SCyYvjRV1Gi8FTmbYM=;
 b=hC1d/HpwoZck4xnNfYUwQONhiUYvmmTnQC3NHZITCDw21n87HMjdSvEFxw28T5ud0eWAlc1V42MkxNVGC03hS/pvbNCy16MTjXXUhARlgPyPr+IQ6c2n89THQISnnY2xLDT74Ykidhpea86Xukgpmii9dUfrryWfwSH9XrYWYUwdeHeqLhrLno1u0UHB9OrJSbuOZXaYObwCBxATf2GxDibJmp0xPO9dV23ZC7IUhkw99/k8ZfR7FNrmQmBreUKRpkZ8PcATs3C/Bq66j3SMXygD55g/KS9o9u48DvRG3rnOYggpBMZVebzlP2/zeo1StwIAJGmiNzzMxeexzFEyng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB2667.namprd12.prod.outlook.com (2603:10b6:5:42::28) by
 PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.11; Fri, 5 Dec 2025 21:51:18 +0000
Received: from DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2]) by DM6PR12MB2667.namprd12.prod.outlook.com
 ([fe80::bd88:b883:813d:54a2%6]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 21:51:18 +0000
Message-ID: <0ceb405c-2f68-4aba-b146-333123e4d084@nvidia.com>
Date: Fri, 5 Dec 2025 13:51:16 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/resctrl: Fix non-contiguous CBM check
 for Hygon
To: Reinette Chatre <reinette.chatre@intel.com>,
 Xiaochen Shen <shenxiaochen@open-hieco.net>, tony.luck@intel.com,
 bp@alien8.de, shuah@kernel.org, skhan@linuxfoundation.org
Cc: babu.moger@amd.com, james.morse@arm.com, Dave.Martin@arm.com,
 x86@kernel.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251205092544.2685728-1-shenxiaochen@open-hieco.net>
 <20251205092544.2685728-4-shenxiaochen@open-hieco.net>
 <86ee2c6d-476e-495d-b36a-6a72a1c98b69@nvidia.com>
 <8ae52291-27e8-4614-9d27-b497ec22574d@intel.com>
Content-Language: en-US
From: Fenghua Yu <fenghuay@nvidia.com>
In-Reply-To: <8ae52291-27e8-4614-9d27-b497ec22574d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0010.namprd04.prod.outlook.com
 (2603:10b6:a03:40::23) To DM6PR12MB2667.namprd12.prod.outlook.com
 (2603:10b6:5:42::28)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB2667:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: 241c23a9-3aa9-463b-ad22-08de34486b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUJYT3pxRDgweUpQdzdUKzk3WEdwS09SUEdnTUhtckF4c3diMGM0ZUEzMm83?=
 =?utf-8?B?UzNRV3l2SnlKOTVTK2JnVGZISS9QSUVrUEhUMEtvL1NSZXlDbjlITzhLejlH?=
 =?utf-8?B?eEVPaVdtTFM2eUFDc2RaL2VTN1dDSFVrYitkWDJ3NWJGR3A3czE1L2dvQklU?=
 =?utf-8?B?Nkg0QXBESUN4QlkzdnZNN2pvUnRXYXBrL0ZlTmVkbUxZWmdnOWxoUFdGUlI1?=
 =?utf-8?B?Ny94TENoQjIrUlZqcU12akcrNDlvZnJaN0xOSE1rbUhNM3RQcUFXRDhseTJN?=
 =?utf-8?B?eEUyelpTQnM2dWMrYktETE55RkJkSjZHd3NCQ0VxVjJIZEZjb1hNTUExUzdB?=
 =?utf-8?B?OWQxck11OElYR3I1Qk1EcURqK0ZlRUllbitNRDJpeXQxSWtydUx4M0dSeEw1?=
 =?utf-8?B?eXhoUGxFbldFaVgrT3BGYjJ5VUN1dDEyQ09ROUV2UFpGU3RJTjBLeFVLOTBQ?=
 =?utf-8?B?MkdURUFNL2ZBczVtZktyL3BNZmJvM1N1OU5aMTI3ZlZGRnJxYW9RMzNEQXFw?=
 =?utf-8?B?ZkVsMUlWN0tIYzhWSncrQ0xvajZ5QlpUS0htT1NqODNxVTUzUk5GdlpFV01B?=
 =?utf-8?B?VkZNZnJTbDZFbmc3RjVxaEZyelJVczZmVG5iRW81VUR5K1lDYjc5Z2RDendh?=
 =?utf-8?B?cnhGTFIrSis1Rm1OeXg0YnlOZlRtd2tSczF2TnFUNzNQMk55TXl1RGZDcDFI?=
 =?utf-8?B?ZUdrdG03TXpNZnowaUEzUGpxY3d0Sk9WVmNHRzVpbm1ZSEsrdE9uMEZ6VVVh?=
 =?utf-8?B?cTBqTkRQd2lGZEVmQlBWOGpHa1E0d2xuRmtIWnZVdWtBZjZ3NThuQmRHL2cy?=
 =?utf-8?B?L3RMaXg0WmJobE1TZWgwRFFmeDJLcTBvSXh2VGZaTmhtbWNybmRLN3ZlMGR2?=
 =?utf-8?B?NEhOZTVHbDkxU3luWE9oa0N3ZXVYKy9JaXRtYVJCKzRCU3BVYmh2bHRTSm5r?=
 =?utf-8?B?T1hJdUd2SG4rbk4zQjV4Ri9GVVlaUFdsYmQ1Qkg0UjRMVThZWEo4aTBDcGtW?=
 =?utf-8?B?ZGxoY0xiU29CQUNveStKL2NObEpyWXl2aHJMZG5qVGx3WlhPYm5RK2JCVWgy?=
 =?utf-8?B?WlRyY1VST2ZremVMd1hDcEpramQzODU4VjhQM2lVVGR0SkxETTlMamFRR3lU?=
 =?utf-8?B?Z1ErbXFjNnY0bm5hOG5SMlVLemtVYkFzai9VMzkveUIwQXRTWjdvSEJZayt4?=
 =?utf-8?B?aGsvSkpkSWhQTzZsZSt0a0JDamIyKzl0Nk8wUG5IWUtRR3k4dFdBTTZHVSti?=
 =?utf-8?B?MUdMcnJkblpqMUVadXRKQUFjejFuVEVVaTBRTXkvZ0t2NEIxUzgvWDNIMWw4?=
 =?utf-8?B?cmtvOHZXeXFqZjFyZ1R5SHNuVXlhVWNtMStRMFplbmtoaFVudEFKNC9rTCtW?=
 =?utf-8?B?K1RQZVN4Yy9SZ3ZYN25LNjAxc3EycUo1aldtKzFubEkvYXB3UUUweWVIM05U?=
 =?utf-8?B?RWcreFduaFlucW5PTThMaEMxRzBZZ1ZWeFkrSStGTmtYdzM5VTZrY25tUmxB?=
 =?utf-8?B?QUtpaWhVUnZVMDNHR20rMUxGdEJHYzlrbnk0SXZhR2tCZjZBV1lOYlY5OTlB?=
 =?utf-8?B?dUh6K1hINXpWZW1zcEplcnV1aHdUNUF1WkdJbG9qREk0OUg2eHBpbmhWUFRy?=
 =?utf-8?B?WnJPMkwzQUUva1JCZis2WHRqNGJKN0x1YmRVZnVqQVBPL3IrbUMzSmQzYWsr?=
 =?utf-8?B?ZlZqYTd3QVpvMkI2cU5lQ3lOc3VtS2F0ZVZ4SitLb25OV0krVVFsSi92NW9Q?=
 =?utf-8?B?OXFZeENRNWt1T1ZjakxlN01LUEQyUlpZY3FGeHNTTHFmUWNBUW8zekJ1OFVJ?=
 =?utf-8?B?TnRYb3lTVm44RGdtckQrTEpLcmdQN2o1TDlFU0VxdlNnZjdKelMrMXJTNVpC?=
 =?utf-8?B?VXlaU2g5UFphM1lIU3FvY25JcjJpbGJBRWhPcjdsZVliWjFtNXFVSkJLZml1?=
 =?utf-8?Q?lmOqXFZ00dDWIyO9tbG9V8hYibTm/Kmg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cndYZFBUS1N0ZXBXQVFXMXBPeDFEUjA0NjJLWTJFV1pTSFhEakNFSlhXRXI5?=
 =?utf-8?B?dHBVZ3ZkdjJ5QXJjSEpqK1BXMEE5YzdvRCtOdFZTcUMxemNXakR3bmtqaWl6?=
 =?utf-8?B?b2ZsRUl1OFhDbkVxemRCV204czE1bUw5WVp1VFBFbnZPVWEwZjZodEhuZFNK?=
 =?utf-8?B?b1RlR080bk1pZGFjZGsvY2pMYlZzckNKMWZJTUpJV2xHQXlUQjB6TGN1b244?=
 =?utf-8?B?WHRvdSthZFFFZDFtVVRCdVYyL1kzNjVreVRIS2N3YWpUY2FGOUZHNytnOVZw?=
 =?utf-8?B?YlNwanhtY0JycjdPckI5WFkvQ29OVTdGaUMxYndRclZBTURpd0lMd3dHWmVC?=
 =?utf-8?B?UENhOXQrNnQ1eHVtdGo2aWtMeitLbzdXNjN4Q3diSmhPNmVRU2FyNkFQQXRH?=
 =?utf-8?B?K25GS3N4MlJNRENKZFhvQmhJYjRReHhXbng0OCsxWlY0ODRkNDJHeXVMbUhK?=
 =?utf-8?B?S1hvV2ZmNU5EMVk3dGErLytvNHQ1dXpHY002aVQ5VEg1THFLd2hCSms2c2tC?=
 =?utf-8?B?WW1IT2I3QjFRTUV4QVo4eFVKb1lFb051UHVDYlJ4ZUJ3ZnhDdExmTWk1T05U?=
 =?utf-8?B?Z3NZNlduSDdZaVgzYm8va1ZTMk1IUzBRRUZJWjJTVDBiNGo0a1RIdnFid0hF?=
 =?utf-8?B?SURwcjErOHk0NGVTQ01DWXROZE43dGRtbHp1WGJPeVpHTmE2Rk9ySnpLSHp2?=
 =?utf-8?B?MGRmbW1za3hDOWMyNnFSQUhpcVcrZlQvYm1EbmJHVk1pVEpwU2U0c1N1UWhq?=
 =?utf-8?B?VjJRa2UwRkMwQTdFZllXZDRyS0gwOHdyMnEwdWE2VHBPdFFwcElrVXQzUXJh?=
 =?utf-8?B?Z2t5U0hybmhtbktHcXUxblRFOG9KT2hPd1AwajFkMFlVUjhmLy83Q3pvUDd1?=
 =?utf-8?B?ZTV2ODhvNWRJUW12ZTRGNEQ3L21xd2t4RFBGdEFBWWVhOGFONzUrdjhseEZJ?=
 =?utf-8?B?REU1MTUxNnErdUR4bjRydWEyeUMwVDFTakVNTHQ4ZUxLdk14dnBPUE9pZ2hN?=
 =?utf-8?B?MlVIaWpTZkZBdWF1UVVyVHFXeXNEcDArM05BNzVyRzU1YXljT2ZQQ2FSbU9Q?=
 =?utf-8?B?TGQ2M2hDU09KYzBZcndUQnVjWUhiNFJDYmZVVmJtS0FQdXRDQ2ZmOGNKa3Y5?=
 =?utf-8?B?ZDdaaWpPVHd5RW93NjNKclRMYlFhMzkwQlpRU3V4ZlNVM1JYUk5vaFFyMFZt?=
 =?utf-8?B?aDRUQitxRncwSzd2WmdsQUZKUjZEY0txaXp5SmRUd01sTThDbFVXUGl0dTlN?=
 =?utf-8?B?YkdIeFNodEd2VU13MEhiZEdBcVcvdzBUTzFrM1FWblc0anVuVmgwNEl3SG5W?=
 =?utf-8?B?TFA3SEluK3J6ZE96aktEamZnK2xRekJhTU1ZRm5sMkVvM2lPTkhsV3dqRmsw?=
 =?utf-8?B?TWhFV3oyTUR4cGI0dzNQM1czMFdTQmszQUVIa1QzN0JnTDB0SWIxbTdKQ294?=
 =?utf-8?B?aEpyTGpiaG1TY2NBV3VKUUp2VnZCQVJyRFloVDR0cVJLNzJKVU1UemI1WjVZ?=
 =?utf-8?B?RE9BK09EL1h4NXFkVXlVUGhUL1B5NUd4ZW1CdFFZT1NEZE9tZUI3d2d2RG5v?=
 =?utf-8?B?VDl3YnQ5ajA5bTJIaWtCWTJ2TmlTWng2VkV3ZEVqUFh6L0U5S1lrZnJDUlhj?=
 =?utf-8?B?L2JucWpDWjhsMzk0alhFcEpMRkRVcmhvR2tSS21yKzNUVVdDTW9CQ1BTRWtK?=
 =?utf-8?B?ZWdoSnhQTjhOaExiRVdWRkVMSHI2aEZueW1ITjc3cjFSbmtQNFNSeGhsZ0FN?=
 =?utf-8?B?U3ZTT1FTemFlSUgvVmlnZkdwNG1LTUZScnlia2dRbnlldmZBRXUwZ0ZxcnV4?=
 =?utf-8?B?WWJEb21QcXdkaVUzdG53TDBxNTVFUXBQQlNwWXFSWFZZMjNvTWRTZnh1UzRE?=
 =?utf-8?B?RnpjNzcxOTRHZ0hyZzllZC80dTlESjNScE5nSEZtQTJUL1pZaXJTYUZkdnpl?=
 =?utf-8?B?SWUyUWFlYTB5N2duNFZhSHBad1grNGoxREc0UFU5cXZGL0lkSTVQNjM0a0N3?=
 =?utf-8?B?bTQ5V2YwK2I1MUxmN1JFUzN6MzNVY04xV3RqY2dDdGtYcDNXNHkwQ25rNkxa?=
 =?utf-8?B?djA1VnZ4bHVjamtlcjQ5UjcrTVdqYS9KOTgvZmNJbm5QWlJBdlltUTR0Szdh?=
 =?utf-8?Q?wVRlSpzWVASsboK69tdEFzO7/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 241c23a9-3aa9-463b-ad22-08de34486b98
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:51:18.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRmzsFb12D8lyZRU9TuZfS3K6R80wNDw7EchraFH+P/h0rF2hAVEVJDgxAZoI151qeTY/BNrrJcrIPwmR35mAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111

Hi, Reinette,

On 12/5/25 13:30, Reinette Chatre wrote:
> Hi Fenghua,
> 
> On 12/5/25 11:39 AM, Fenghua Yu wrote:
>>
>>
>> On 12/5/25 01:25, Xiaochen Shen wrote:
>>> The resctrl selftest currently fails on Hygon CPUs that always supports
>>> non-contiguous CBM, printing the error:
>>>
>>>     "# Hardware and kernel differ on non-contiguous CBM support!"
>>>
>>> This occurs because the arch_supports_noncont_cat() function lacks
>>> vendor detection for Hygon CPUs, preventing proper identification of
>>> their non-contiguous CBM capability.
>>>
>>> Fix this by adding Hygon vendor ID detection to
>>> arch_supports_noncont_cat().
>>>
>>> Signed-off-by: Xiaochen Shen <shenxiaochen@open-hieco.net>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>> ---
>>> Maintainer note:
>>> Even though this is a fix it is not a candidate for backport since it is
>>> based on another patch series (x86/resctrl: Fix Platform QoS issues for
>>> Hygon) which is in process of being added to resctrl.
>>>
>>>    tools/testing/selftests/resctrl/cat_test.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
>>> index 94cfdba5308d..59a0f80fdc5a 100644
>>> --- a/tools/testing/selftests/resctrl/cat_test.c
>>> +++ b/tools/testing/selftests/resctrl/cat_test.c
>>> @@ -290,8 +290,8 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>>>      static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>>>    {
>>> -    /* AMD always supports non-contiguous CBM. */
>>> -    if (get_vendor() == ARCH_AMD)
>>> +    /* AMD and Hygon always supports non-contiguous CBM. */
>>> +    if (get_vendor() == ARCH_AMD || get_vendor() == ARCH_HYGON)
>>
>> nit. Better to avoid call get_vendor() twice (or even more in the future)?
> 
> Are you perhaps referring to detect_vendor()? detect_vendor() does the actual digging to
> determine the vendor ID and is indeed called just once by get_vendor(). In subsequent calls
> get_vendor() just returns the static ID.

There is still cost to call get_vendor() (call, push, cmp, pop, ret, 
etc) in subsequent calls. I just feel it's redundant to call it multiple 
times in just one sentence.

Thanks.

-Fenghua

