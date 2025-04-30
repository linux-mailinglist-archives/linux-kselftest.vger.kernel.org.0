Return-Path: <linux-kselftest+bounces-32025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594EDAA482D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 12:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4420179C7A
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B0623815D;
	Wed, 30 Apr 2025 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f9g8/DN5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AC3230BE2;
	Wed, 30 Apr 2025 10:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746008502; cv=fail; b=MRM5OAKBTkJjobq8jRCdXt73djXoJdddN9KQsv8EWci7PEARJ1Us0gufa+ZZC+7WNwD7G4ywrt3sm5mVE+BuSHT3yJtqmcI544AGbfXc4ZHgqu4mliItKvzIVagI0agXYrvjJwuHEOZxgEHZ74xTBMZI0LbREjIQAiKcG6DERMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746008502; c=relaxed/simple;
	bh=4Yk56KgQVnnlhFek1f/1YVvlq69mR3iX7OjNV9JXcwY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAlfGHJKWgf7xRbNoO1QigBkOVRLFDIjkqkxtONz/xFYyDjeUlo6rB0M3fRh19Vu9sblE7s1dagjZdKWmaI00fo4sQWHQdh2klNYpwr4s1H1IOxRvB0fU7q1CAgny8IklBP97WNFyPOzwRIdRo7AXzjbyRyr/oztOJ2OwiQq65I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f9g8/DN5; arc=fail smtp.client-ip=40.107.223.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AnJhqNxeGNX9bAGuazsIDLoXXVhcuy0I7x+iiavHK5K7+SQ8+pGkDR5YAdkrZUkOcCOIirdI5/pZbxB3oVjtx0U/3Ok0tRf8t+JyQFnkKh6OT5TCpMTTgpGbmNc3yVH4/yyxa5pgFbIszUjIcqsrJf7K4VA6kaaXy0jFyotCms0hWtIikpUf1zqRj41/MJ1a3aa8O8JKzpmhy5H81TJBTLe5VTsBS1lroDg9w6ccugMCeaUiFAOhdDNo7T4mKy/AOvsyVJikfEJSUS9AJGwutwD5HtYFcCujuqxJNruPT6gMzgny/DYMbhloudLMgl3Tnq2s3wXEq/L+ysDCaLivzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZHRKRQv42WFAxuLlKP7nxFLBp2cVWMhnA3LCgC8tN4=;
 b=R1Yjh4O73Ayu3HpGBHfQuGrzvDGAG+i0nqNlVpYAYWSx9QicnDDGKBwmYvyXh5sDSsZJoZook2S+FSKiUaBPZcdI9X00lq4Ops3QPu5zcl6dGz0zhWl1pvailYQj5aI29jC6CZ+UG1CyezD6/FRQv2unikIGk6OqN4eq0oS0DYIIquhK0uqpHgc7Bb8X1V8mIP0mIiOTOJYymESVjsRwJ8etWFcCL00qHDgqWg2r3I1eOrT+YVSmuhoWNx9qUWn38yiL2nP/ldAqLBJfGeYDdr+ulRUwwD3gXQXwrlax2TSyhqLopZg+IIVKBFw6jB/Kz1PqMOpGH/rFc7V7Cw3N0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZHRKRQv42WFAxuLlKP7nxFLBp2cVWMhnA3LCgC8tN4=;
 b=f9g8/DN5C6TtZvOlc5+NcmfbUtmjynuvkqwAzEjFU2LLFlV88Sok77PbPzNIdQAWCeG7M4so39NDm8l6cODreTdJZMwWWcMn+2Ekc0KvTWhQ1VG9tQtQE4get1kY+niVlZmE7ah4VL1WwWsy9fC7mwfAp9WQNeH8s6OPNf6Ayg4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Wed, 30 Apr
 2025 10:21:37 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 10:21:37 +0000
Message-ID: <91d1df7e-b136-4024-a1f2-20b1374ede40@amd.com>
Date: Wed, 30 Apr 2025 15:51:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/22] iommufd/viommmu: Add IOMMUFD_CMD_VCMDQ_ALLOC
 ioctl
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
 bagasdotme@gmail.com, robin.murphy@arm.com, joro@8bytes.org,
 thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
 shuah@kernel.org, jsnitsel@redhat.com, nathan@kernel.org,
 peterz@infradead.org, yi.l.liu@intel.com, mshavit@google.com,
 praan@google.com, zhangzekun11@huawei.com, iommu@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev, mochs@nvidia.com,
 alok.a.tiwari@oracle.com,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
References: <cover.1745646960.git.nicolinc@nvidia.com>
 <094992b874190ffdcf6012104b419c8649b5e4b4.1745646960.git.nicolinc@nvidia.com>
 <b0d01609-bdda-49a3-af0c-ca828a9c4cea@amd.com>
 <aA/exylmYJhIhEVL@Asurada-Nvidia>
 <b8338b47-6fbf-44ac-9b99-3555997c9f36@amd.com>
 <aBB1gLfahnLmn0N1@Asurada-Nvidia>
 <a3860aed-5b6b-4e68-a8fd-1a6ee28ba022@amd.com>
 <aBEI+T7P+hV8Y6tU@Asurada-Nvidia>
 <7c813df6-e37d-47ae-9b5a-b8735c865626@amd.com>
 <aBHY8wOmpMOxelE/@Asurada-Nvidia>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <aBHY8wOmpMOxelE/@Asurada-Nvidia>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a002af8-39e3-44c5-f30a-08dd87d0ca39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHRDaHNSQ1RKc2dLaUI0Q01iNS9neERESGhWYXFNSU5VM20ydEZxU0JNcnh6?=
 =?utf-8?B?c0hwUHZMSmZGQjVCR3BFa0IzRk51V0doRXVkU1h6UUpjdnIvQ3VCcjNwLzd3?=
 =?utf-8?B?c3FmN0MrY3l2aXQ5a3UvMTNXY0NiVmtLSXJLUTNnU0RCSmRoc2hxT3VnSEo0?=
 =?utf-8?B?OU1XV2R6amgwY3dmRW5JR1gwZXE0UERZVjlVN0ZxOW5BWXJhZ3ZjTEYzMjNn?=
 =?utf-8?B?c0xLaS9iNEZhUVcvN3RneUV4ZmxkOER6OFdrRnVkUDgyaEFoU2VDcWZTRHV2?=
 =?utf-8?B?dXdwSHRLdzd6WkVtS21uUFA1ZTl5WFF5bTV0ZmI5MktQRkZsd2QxanBHV0Iv?=
 =?utf-8?B?VmJhdXNDdTA3ZEREcTlBYUlyYk1TdzdZSXo1UENzOERBbFByT2RlL1g1SEwy?=
 =?utf-8?B?WDlXRE11T2tRUFdBRG8zbGZnaWdzRUhkYUp2RWswd3B4d2kveVpWVmxteXZL?=
 =?utf-8?B?QkhWV1k4MGdRZmRpanVoS2NuNm5ETUlUTmRFOGFpc2ZRbSsvNzFKQm5jdFBp?=
 =?utf-8?B?R0xnR29xSXdSNjdVdkhpcWlBM0h4Y1dmSFYwdzNwSkRPR1ExSGFzU28ramtz?=
 =?utf-8?B?NUxvSG44Rll5LzZxclhRejNMbUVCR24xWm9EVFpVWlJpeWFhWkFObWxSMllm?=
 =?utf-8?B?TXpETmM3Zm5lMTBuZmc0K2htY1A5dk40RWFuRmJ0U0F2N2FUUGRobm5tN3Rt?=
 =?utf-8?B?ZWYrUHpjTE0rdm5nZCtKeEdLajR6d2hDR0NXOTEzcHdWcHdKb29CR1BVS2hq?=
 =?utf-8?B?Znk4YUY0cms1SmZTUzgwKzNNODd2a3EwNzVjVEtVUzFVMUlVcjBmRHB5ODJT?=
 =?utf-8?B?VUEvZWJpZU03U3V4MmJ1em8vN01RV0R6eXV3eC9JRHlHdGpoMUZNbnJhb0cw?=
 =?utf-8?B?UjBEY0NlL2dGb3dEbm1FdE53NXozc3A1R0ltQ2JXNUdDWmNPcTNFajBQQTIv?=
 =?utf-8?B?aXNwYXd0dm01MktPVm41QnBIVE5CVXl6aGxQMXFPVWNnVURZQVU4dVlVdjhR?=
 =?utf-8?B?MkNGY3ZDeHltdGRVa1VKNGp6TnBldVEwMXNSVUtrUUNUQkhtb0QrOG5MS0VW?=
 =?utf-8?B?WWUweTYrYUFMWUlxM2pEYVFYZEE3aDJTNzZYZ0N1WjB2TllQaU1NdFFCRDc4?=
 =?utf-8?B?NUFMS21GTFZSYjgvRDhBQThLd2QrQWVPa3BuNjZ4MXFqMCtOSTQyQlhHUWlY?=
 =?utf-8?B?ZHpDV3l6UXA4YVVERWRzOUVhNlBCVVl2NE5PM0FPUjZZdkwzZWk5LzBUd3Qr?=
 =?utf-8?B?WTcxOUo2b0I1UFJYUHp5RXpTM0dkd1planBzTmJoZ3dVbFhQZEY3N282ZUpS?=
 =?utf-8?B?U3RJcU9rU3RtbndNbW1VcFV3NkVSODhLdUt1VTVuekJRZy9BY1FhME1tQlZU?=
 =?utf-8?B?amtzQmplcjVmRHF3Q1FaWHQxK3BqY3VnNXpmTmJUTW5tMng3eTBlM2FSRG1Y?=
 =?utf-8?B?Q29tOXFjWVRoVVNLSWhiNmVwRTJibU5Na3lKYVhXNWp1REpDdVMvblB5Skh3?=
 =?utf-8?B?RjVYaTRycDJCblVPVEk2K2o1aGpZRHNTOUxtUHdKWmtXS082Tkc0SmZPNS9r?=
 =?utf-8?B?R0xYUUlsVUJZaDAyeWorR09WTjJGUENBcVZOV1Z0MGkzbDhnWDFodUR6WWJL?=
 =?utf-8?B?d2lrVlNFMGhid011K3RZckc4VC9PSzNWdjhLUjVoV2t2QmZHMWN3TWhVblNR?=
 =?utf-8?B?UTM5TUtybXQ0OUhqUW5tZ1ljRENlYWtjRXdUK1RRSHg2ZEFNcGZOZnFPdHND?=
 =?utf-8?B?SEVQV004VW04R0RNZm9lRnNwbngzRFpmQUVPUW9yZ3dlUGdVVUZYU0xNL0hB?=
 =?utf-8?B?bmpnamd0WGxjYi9Sc1FPUkZIcUdaemsrVysxTHJNZXIrVW5FcW1hdmxGZkR4?=
 =?utf-8?B?SktDemt1ajYzb1ZGcVBqeGNJTFJkYXQ5MXFxMEtQTTU5anlzamVQdlk2WGJN?=
 =?utf-8?Q?9OQnVvqfZHI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk5KZFozNjR3bURLL29odk8zTitFSFFBazF0RGVuYUJ6SXNuRGljU3ZsaDNU?=
 =?utf-8?B?OUxKY1drbVlIVnBaWGczNEc4Q2d3RTZiaHo2U3FEQzlKaFBBQ3h5NS9qOFU2?=
 =?utf-8?B?Uk9Zdmp0VmN5ZXhRUUR6N29wWXlURzNhRTFnSERQbWpTbElxYW0zRmxVVDRl?=
 =?utf-8?B?VW91K2dtYmhBN3RTWUF4TVYvK3h0M2RjTXNWdXp2eUQ0MHF3R1dFQ1NIaTNP?=
 =?utf-8?B?ZEVuTVk2cHQ2eG1BWWRKSVRPczZ4RHkxcCtuQ2p1WHJkdEsrYzYxWnp4RjBC?=
 =?utf-8?B?K1kycmFwbVkydGhySnYyeGtXdGo5bERlZHBYWThjOVN0ZkNvd3FXa1YrTDVV?=
 =?utf-8?B?YWdTbkJxbnZvZXJHZWljWWNuYm9kbUo1ZWxWK2lMc3BIc1AvUWJndHNNeEhY?=
 =?utf-8?B?Qnp0NmtpQXhINGJIeXJJNkVVWXNySnpYRlhnSGt0aWhuZHFNbHVsNzJnVExG?=
 =?utf-8?B?blJxb2lweFlrWGtyT3N1cDhIRVFQb2ovYk1WNURxdnpwbjg3WlZveDBRZkR4?=
 =?utf-8?B?b1d4dEE3cnpSTFVFcFZ5ZGlsdTdiMUJUc3NsbEdMMWFDb2MvWlhmODBpOE5P?=
 =?utf-8?B?QzlIZ3FuekVLNGN0UnByb1M3WHhSeGxDRHJhMEl2R25NdUo4bndUNGZOMndv?=
 =?utf-8?B?NHZMQUt4cXJYRHpKSkUyREdGc3FOTUIyNEE3U0JlMEl2NDRLVEp0YXVQVEJq?=
 =?utf-8?B?ZnZqM2h6b0JPTjMza3YxN2ZLeDRzOXlKK2tTbjlxaEQ0N1Rqa01LYlk4eWEz?=
 =?utf-8?B?R2hNZWN2UDFaMThIUlllT3ArSG5FV2FSNERIVGM0RzVyZGljNnMzd2YwT3dT?=
 =?utf-8?B?RzRoY3pGRTE0Tmx5WXk0VEVZS3FCbjN6ODdycUJnV2EyNzZ2N2RrM1F2b1Vo?=
 =?utf-8?B?MGRHQ013NTVISlFaOUlvNkJ4K1lBN2xyMWxENlpZY01qSnpkWU5EWmF0RWZw?=
 =?utf-8?B?dDNVNWt1dDFJQ2ZWcURmTi8zYmpETmVMNmRjd21FQVpZT2JTaGVwL2ZHUWpG?=
 =?utf-8?B?V3B1M0tZZjhwa1RWVEkvSjBaY2taUFcwbHBVbWo2ME9SODJqNTdGcnl5VE5W?=
 =?utf-8?B?TTI3L3IxaS93OHJMV2xvR1RnMUQya3VvRkNUOTBISjFJNUZlaUxpbTQxLzhD?=
 =?utf-8?B?UEVlTW1CYUoyWExxWGN1MnF0b0VWcWdQTHcvM1BnUHFFdEJEbXNoTm82V29G?=
 =?utf-8?B?cVFwWVU3V3BjcVhIZGo2dG9GelF0VkFYYnh2UjdYcVN3UXhDeU1CakcyK2hT?=
 =?utf-8?B?YlBJZUZxTjdsWCtBczBkTEx1UmJEc2Q2eGFoOXFhekJtdTlsRDl6YUNqZEly?=
 =?utf-8?B?VVFRRkpaS1o1Qk96Wkk3anR5anFaaDBpV1dKN0w2QzUzZFkyNzdKTFNZbmZi?=
 =?utf-8?B?dC8wZzJuVXJrcS9CTFhRUGl3U2tkNWpYNVB6bUxYNGg2M0ppbUpDTStJYWty?=
 =?utf-8?B?V0E0VXY0S29OZmRRQU1hbGdhVXA5dWI4MmpWRzcraGNJY3U0T01xQzBIZW12?=
 =?utf-8?B?SjhwVzErSThGTXg5TlVDdE1TYlhvYWs4dG5FencxY3dFT2U1TVFhcnB5R0V2?=
 =?utf-8?B?WWUwanpualNhVTI0aks2Z1FmdlBVWElaNTJJOS9PYWM5aWxxcEdRN3AyOXpL?=
 =?utf-8?B?ak82aGNmeklyNmUzN3dLOWFpb3ZBS3QxN0RDeGpwSUN5akVBSUYyenZNQ3FZ?=
 =?utf-8?B?VEJKdGp6SS9CUHZWSlBhRUVDLzg5aGJhcWlWREtWemhiK2ltY1pTeVpqMnhk?=
 =?utf-8?B?WGtETllFaWZtQVJyekRJQ3VBY1JvSW1vWHZjSllFQys0M0Z5N2szcmpWdGs2?=
 =?utf-8?B?bjNoN0tFVjYwZG0wMDBhbkJDRWF1MzUxK213eHp6K1pYVFphNGt0RzhHbnlV?=
 =?utf-8?B?a1FwUVI1SGJNMWV2ek9GKzE0SzljMTY5NSswRHhRVFQ3U3dRQ2xNWXBZRGJG?=
 =?utf-8?B?QTRBSlR3TDA2THBURlpWTE1hWU5ZNmgxcmZLc3ovTERZckl5eXJxMHRIY2dQ?=
 =?utf-8?B?em1ZNS9aN3A4bnFWK3B2ZDNyZ1BISloyWktnRmtmalpmWHA2N3ZpTzFaL1dJ?=
 =?utf-8?B?eWpvNVpOWFpKb1RvaHBRRTlIODloS3kwdHpiNTM2dnQ0T0pkcm9YajRoZnc1?=
 =?utf-8?Q?752ONNIncED7tmUmldOCIN56s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a002af8-39e3-44c5-f30a-08dd87d0ca39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 10:21:37.5702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7CGghJgdYT0+JG+V097ft0mKSYqr589tg96ZrMGzsiTHLuklNaOjYAvjsT9ttuyF78pRtIVKhXLrfqCrVpZijw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277



On 4/30/2025 1:31 PM, Nicolin Chen wrote:
> On Wed, Apr 30, 2025 at 09:52:09AM +0530, Vasant Hegde wrote:
>>>>> Will the hardware replace the physical device ID in the event with
>>>>> the virtual device ID when injecting the event to a guest event/PPR
>>>>> queue? 
>>>>> If so, yea, I think you can define them separately using the> vCMDQ
>>>> infrastructures:
>>>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_CMDBUF
>>>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_EVENTLOG
>>>>>  - IOMMU_VCMDQ_TYPE_AMD_VIOMMU_PPRLOG
>>>>> (@Kevin @Jason Hmm, in this case we might want to revert the naming
>>>>>  "vCMDQ" back to "vQEUEUE", once Vasant confirms.)
>>>
>>> I think I should rename IOMMUFD_OBJ_VCMDQ back to IOMMUFD_OBJ_VQUEUE
>>> since the same object fits three types of queue now in the AMD case.
>>
>> Makes sense.
>>
>> AMD architecture supports 5 buffers. In practice we have not implemented event
>> log  B / PPR Log B in Linux.
>>   Command buffer
>>   Event Log A / B
>>   PPR Log A / B
> 
> I think those A/B should be dual buffers of the same type?

Yes.



> 
> Anyway, I have renamed all the core "vCMDQ" back to "vQUEUE" in my
> local branch. Will send v3 in the next days.

Sure thanks.

-Vasant


