Return-Path: <linux-kselftest+bounces-20376-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E6A9A9FA5
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 12:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F49E284026
	for <lists+linux-kselftest@lfdr.de>; Tue, 22 Oct 2024 10:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF27C1991B5;
	Tue, 22 Oct 2024 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QLeo2YYd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A0B19005D;
	Tue, 22 Oct 2024 10:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729591710; cv=fail; b=gsF5ldeUQHrtByFjOz9qYFTh3B3Ot+8g74VuHLqD3zhjk2aQybLhtyx0btd0i/U+1bEHEY0iP0aQOnII/nB2PanGxc7K8IQcJo6IrFFH1DmKdSn3SEgZ9tDUn430yCKogwBpny3aCo3U2Bv8xJb45eHHtQXXIueRRMMabJ5Y6xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729591710; c=relaxed/simple;
	bh=1PARjlBvH7AvtMC6JMwKNXlDop+5gUXA9ht1xy8syrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T5wji59UoxUVsiegaNHTQxYYcqFIbTnsQWhawTR116BaEtTQmIU7HDa8o4Emr/DD3u35g6AKWaqns1Z38tx0kZgiXbTBki+5aanuEd6U8bhiykhXQqQBqrk5q1KayGdJ/TddXpiX4lqyEMalci4gmvioPuMlm3Cn44aBSRTWR3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QLeo2YYd; arc=fail smtp.client-ip=40.107.220.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eApVx/XpCfJz+i2sT2kY3bP4n2IjYcPGpO3oxLAyKQIcg9qV1b3DoZ2Nv8/2XyWLmVUQ3RCi0JYnsPK+We94Q9ljgEJ8S+eqSV2H5L/ghZhZn+asbz/B4eD7JSSdKHBNg2nT/10UJLI1ec8EciwsXexdm1FQAYJVhDKH1FKyaHIj8KUD6JTKHejL+7JcpXgSjc7QP/tWL5PuJhDz4uFFHzbX6zkokDhttI3o0U7TVk0GDgRaTJka3oPyocDjn153KoVzywMPi8/sYvwZ8o6HbzfoPWVyo9Nin9aBjkPqxywxynJsJHHjmCThHDqRcJsZ2lDiK3IzQaD5tYNE8IDVOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXPp9jAa+41ixeCqpHxf6tF7BlTESGUOEP2cPL+u9gI=;
 b=J8+jr5FZz/VeXiPDh1HbMiHtIJFLNSHw+phFwIBzKUbPdT1O92QNpJgyKo82jvWiVgmK8d5Xij9CfKJUpqD3bOeme5l94DyGAlZeCzW26ArmC1qgGw7AdN/ppxaAh1jQhR84I8odc68PBOXIEAZZeoSGHm6g3scrvPlyQ8mx2k7gw8My8MUHI1j1aRCNL53wRSex+EkSuMh5uK8le3W6O41af+EUeOtzpmJgXTK2j2L76SqENdbAUO+eLXGXrE0cieUUy6Bgx1QX83PpxC2uKJNmyf83tzhNk8hyQh3nKoEk+0W0EXVlc+SFfgqHa+IjCbRwzKTT3wVB3n1MVml6Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXPp9jAa+41ixeCqpHxf6tF7BlTESGUOEP2cPL+u9gI=;
 b=QLeo2YYd+btTBFb3RdlI/++dKODIEdVaI+OEDaBBqBziaarofEqh7vFeA9KsOLZ4BYjFq6hPbnbmddwwxLw8go6oNdqeCciaA8X2SqHIZox7rOsyr3cv3xFnvY4ZEry/o/kup4GFGBJJNIiGzer6DUGVeJ3fffX9BdBSKexabWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 10:08:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 10:08:25 +0000
Message-ID: <94b67623-17a4-412b-959b-a1d3c50190bf@amd.com>
Date: Tue, 22 Oct 2024 15:38:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] iommufd: Extend IOMMU_GET_HW_INFO to report PASID
 capability
To: Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, jgg@nvidia.com,
 kevin.tian@intel.com, baolu.lu@linux.intel.com
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, nicolinc@nvidia.com,
 kvm@vger.kernel.org, chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
 zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-5-yi.l.liu@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240912131729.14951-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::8) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: ea1737aa-f600-4b10-07ca-08dcf2817795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enFESjRUazBYNU90YUozelIvMElEM0xFdzJ0UWNJNXJZellWNWwrOUJhTEY3?=
 =?utf-8?B?MEw3R3NtTjhJOTdGWTRHemVDRWlNYVVMN1U5WXNEMEdSYWVoSnp3eHVPVkVE?=
 =?utf-8?B?SFpGaEpMVDJFUU5uOXJNanlwL0xBRnhCeE9hL2VCS2RLVVFpZnpRcGluL1RU?=
 =?utf-8?B?SlBpZk1EMkhrb29tbHpORTBnK2pZeEE3b3QzRGZqRkhnVXBGaUdEK2gwUi9X?=
 =?utf-8?B?RHV5QWh1azI1dmg2aFlEVW52ZFAyK1lpbUVSL3VyTGZmQU9QU0I5WURYTmpJ?=
 =?utf-8?B?Y1N5V0YvdG16V1hqdnZUVUpnWWNUVjJBTm9uMFAwR0gycFJySFRrbWUwc1l4?=
 =?utf-8?B?WU92L2hyWGlvWk90U2N6d0R1T0RnOHc5Q0huY1IrblFWenJmY3B4bFBuamdL?=
 =?utf-8?B?bkYvMUhua1JKSUtublVkcjR6TXlTakJKZmwrdW16dFo2TGgzS0NYbG1wT2x4?=
 =?utf-8?B?NHlkMm5aajVDeW0vbWRTSW9ZNVJKRTRDd3E3akRZNWg3SCsvOHozYXI3Vkhk?=
 =?utf-8?B?TjcyQkkrNGM1alZkZmJ4VDJnMEo0ODV6VXl2eTBiZnlZMHFVZCtpdUwxVWRv?=
 =?utf-8?B?SXFwYlBkN2ZSM0ZSWmk4MzB1aW40YVhPQVNYUGpEQWRHR1dwT2FYL1ZiTTNa?=
 =?utf-8?B?UU90b0loN3ZQcDRSWStkcHN4S0xsb0NxOU1BYUZCOTRaeFZwZis0TExrQU51?=
 =?utf-8?B?bDZleW1Wd3hPWGs5QWJmNVgrZE13N3EyUEVQbTREV3Rnb0RIcWE4dUN5ditG?=
 =?utf-8?B?V1lyMjc4cmpPNjZRd0ZpS0dmd2wzWG40YktaVHJxTDlQckNSanVYSmp1N3g2?=
 =?utf-8?B?QU9TVEEwQmlzZzQxN3Z2QmJ2WmozN3VDSmR5c2VMYlJ0eE1ZV3A4bDE4Tktn?=
 =?utf-8?B?TmppYVNHZVlGT1BqRWpUenBMVUp5c3orWGxWNDVvR2NRZ1hxeU5wQnUyQ0Yv?=
 =?utf-8?B?UDM0WjVnSVBiZW9scUc3TXA5YXdiYU44d2VVWUtRTk9aZnE3Z29DSjhGVCtS?=
 =?utf-8?B?eEpjd0ZJZ3dHVnV6aTM0cDNLY1lYd2lONXJZNVBLUzZ4cTcvVlJoY3BLR0Iv?=
 =?utf-8?B?K3kvQU1BZVRQTC9xQUpOcnpzZk5IazlDTnFORWVQUklzbXdPZzRFdFhUV1Q4?=
 =?utf-8?B?SlJoa25pQkh6aWlTY08yMTR5dldBalhBSDcvTXZVOFJlYnFIS0ltVkpOaWl4?=
 =?utf-8?B?OHdmSk9EWEJTL1lPamU0Ulhhdmx5d3pjU1V3TEpEYnAxWXFNaFdZTCs3bDFZ?=
 =?utf-8?B?dHIyZURsbzMrejExUTdoTnBYUGU4bmxlV2lDbFBIM2RZQUpzcDQwbVBzSmtR?=
 =?utf-8?B?TWxrNDdLczhDTElWYVFIVlpHWDVhK01CamRJU0pYY1puazlOczR5YzExK3k0?=
 =?utf-8?B?d0lIdWFxYUFETk4xd084eFJ4bU81UXpCUm94UVNFWWl1cEV0ZklqNTJQWi9L?=
 =?utf-8?B?TXEvZnF1MkZGc3l0c0s4TWxuRHA0VlRNelE0ajFrM1EzMWlaL3B3Y1drR0tN?=
 =?utf-8?B?c2ZnQnpVM0FuNEcyeUhlL2ZYMU1SdSsvMmFxQzZjaENRWFBwU1hkWjFPMWxT?=
 =?utf-8?B?Q2pEbU8rZmtYRGcxRTBJWDB5WVRNT3lmWVVHU2xyVncwTFpNWVpVcWo5V0px?=
 =?utf-8?B?Ti8xUitZUUhRV0NRNmViY1ZXbkNUYWUzVzFoZHA4K3Z3L2lVSUtFR3VCbTYz?=
 =?utf-8?B?c2J3MmZ3dmdnVkUvaVZwaFJKRTJycmFXVkpNdTg5K0dYRnh5RDNlYUVnWDQw?=
 =?utf-8?Q?HMygd2Ph8fER7imgkskVSHMwAhOtwK4yv9INB2S?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnFzWFlrTm0wUEpOajg3RU9YU2xMekRNWW93QTZabmFUcHcxcnFGYXNSeU9p?=
 =?utf-8?B?NTc4Q1lLbjFaaGlNSFhyRmdjdU8wakw3TmF6QzdQdnhxamhkRHJzWmttMStK?=
 =?utf-8?B?djROUGloRktSdjJzYXR6Mm92RlBJYU51UjduNE5ZOFJBS2NVQVB4VGk1U01D?=
 =?utf-8?B?Q1dwOUtRemhTTFhaUkdyTTJiMmRkMlJTQ0NtSHRoS2VlTlphM0N5MzNYK3pV?=
 =?utf-8?B?ZWpNd3BxbG96amgyaWlKZUNsMllqcWJ6ZkI3dFp3MEgvaWIxQTF3WS9wM3ZK?=
 =?utf-8?B?aWpUanJ3SFMyY3B1T3BqbWpFQWN5UnNuZTRmc0ZjdDJtckptT2JxMmJEcDRt?=
 =?utf-8?B?djBKKy8rWEdxdFg0QWtNZ0svcDdubTlQT2F1K3A4UnkwTmdGYVZ3MjB0eFBq?=
 =?utf-8?B?cjJma0x4U0dldUNmZzRacHpvZFNrLzViN1JPMXZaNXA0cGY3UHdjZmMwZ0pn?=
 =?utf-8?B?NWdwZEVTM1p2UzN0MzZEZG9jdjlXYWR3Unl6aXp1UFhkM3l3ZEIyaVN0UzdF?=
 =?utf-8?B?aDVhRkIxbEErNERqYWFQY3FGVjN6a0VtMGJSblR4LzhiRHllOFBvZG9kM01Q?=
 =?utf-8?B?cEtDNWdLWVJiZXE3ejV0YzdhMTJnblVzcUZsdWFqTFBIY3FvaGYyTXM3TVFh?=
 =?utf-8?B?RW84UndGM0FPb3pEMWVTQlk2Y0pIeEZvOEtMU0dsNVhBK2hJMCtBNkFmUWZi?=
 =?utf-8?B?b1VxYWJaRER0YzhFVUMxUWl5REdnWWZMN2I4TWw1cDJjc3F1TWl6Wk5GTVpt?=
 =?utf-8?B?aTBjcGlGcXh2aGl5cTFuUUNENVFkUmVNQklvb1RPKzZ0czFha3FkTkhrUjhV?=
 =?utf-8?B?c213bnFSKzlTRHNsZGp4N1NCVm5WZFdaMGljaHM3dXRLYWFzVnRJMU5kUUR6?=
 =?utf-8?B?TmxITFFGRnlFeDhRK1hZZVpTWFZGQnhoTVVHVmZ6OVI5Ni9tMmRlYXRlT0N2?=
 =?utf-8?B?Tm5ZNHkvUjBVUGxNWWhVNE5CYzVteHpCUW9sUEtHREQ5U1VYVVNIZUVkdFhu?=
 =?utf-8?B?RHRLbGh1OFpLMEZZMkRVZ1dCQVZzemh5eWdvSitEL2ZsY2lrSWxLTEdKVkJh?=
 =?utf-8?B?ME5TZUlLQkVoY2FyNnVLTDBsM2tTdWI0L0VjMHpXd3ZQMGUwQlhaNFNJa0V2?=
 =?utf-8?B?a0xKcDA3MzNHd0JXLzI2QTZVMFVRVE9TYzRseElnLzlWLy9oVWZtTGkyck9N?=
 =?utf-8?B?bjdKLy9mTGt1b1ZCRUZINDVHUWRWNFhMWmdJT29QaThkVWxXc0RxckZkUUph?=
 =?utf-8?B?bmJpcTMwUXh3Y0dPdTNtdXV0MUVic3hqK3dKWWQ0S3VoMGcrN0lldFVzYzVx?=
 =?utf-8?B?SytKN1o2Z1JxL1U0eWdUczNLN0ZMbFMyYzNmcFgwdlhtU0EvS1hGQm9TUDVI?=
 =?utf-8?B?TnVXR1A1Z08rUlExUnhrV0lUdlJVTWlWVVlCVmJSdjVienRHT3JWVEtuTE95?=
 =?utf-8?B?T2FtU0krQnloUGJiN0lLUzlnMDN2MXNZeThFazMzREhianJGRHNiRmJDM2xU?=
 =?utf-8?B?dnAxbGtoUWlzL0N4Yy9MY3dvc0x5dnBTVGtESm9Mc2R3MWdOMDFmTEk4aEhN?=
 =?utf-8?B?bE1DQXE3UW8vQWJ2eXNmVHJEbWdXSWNGTm5JdXFIQ09PSHF6aWdocEcybXNE?=
 =?utf-8?B?RDZQTEw0TlhweExkcU5zellrZUlCY1NuN3JmK203R2xDb0x4a0xCNUJsUzk0?=
 =?utf-8?B?eWM0NEEyS1l4SVlxMmRpTkFYWk9qNk1NNHRYMWIyMWZBZXVUZzgrTzRyNG5m?=
 =?utf-8?B?OW1oYmJrNi9iQXMzTHdsRzd0ckhURndtOGZmSHk0dkpTdndueE1BTWFpQ2pC?=
 =?utf-8?B?c2lwNzNkWnVUZmtEc0l3VU1EWFFJbmtITTFuSW9qQ3VobVAvMEJ3VzlQNU1s?=
 =?utf-8?B?TUVBMlBsNjNaNUVQYWd6V1k5V2JGRkdUNVQwUGxoamdzSVhjaGxaeEx6Rlp0?=
 =?utf-8?B?aTlsU0dVK25oSmZFbjdoTStmN0dybm9McVpyTUhLbzJnTFRjelFzWkhLYTQy?=
 =?utf-8?B?VGxBQ01NNHZSSytYcjhWVi8rV2FqS2QyT1ZvR3NTbEtkNVg5N1V2dXRZclND?=
 =?utf-8?B?OVNqbUdVajFIZE84c2J3enlnSWFqekEveGRjSkEzNlVtY2pzS1RZWEltanFY?=
 =?utf-8?Q?cA4Iwz8Lj2NOtXYVrmSbXF8p1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1737aa-f600-4b10-07ca-08dcf2817795
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 10:08:25.4044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNFudN7h5FRsYeWBXPXjybpu9cO2lI/ehlTrl1t0hiojxkVeIE9bclItfi/uYf16B/PbnhXkNmisRslEBOY71A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

Hi Yi,


On 9/12/2024 6:47 PM, Yi Liu wrote:
> PASID usage requires PASID support in both device and IOMMU. Since the
> iommu drivers always enable the PASID capability for the device if it
> is supported, so it is reasonable to extend the IOMMU_GET_HW_INFO to
> report the PASID capability to userspace.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/iommufd/device.c | 27 ++++++++++++++++++++++++++-
>  drivers/pci/ats.c              | 32 ++++++++++++++++++++++++++++++++
>  include/linux/pci-ats.h        |  3 +++
>  include/uapi/linux/iommufd.h   | 14 +++++++++++++-
>  4 files changed, 74 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index 18f94aa462ea..6b7e3e5f4598 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -4,6 +4,8 @@
>  #include <linux/iommufd.h>
>  #include <linux/slab.h>
>  #include <linux/iommu.h>
> +#include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <uapi/linux/iommufd.h>
>  #include "../iommu-priv.h"
>  
> @@ -1185,7 +1187,8 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	void *data;
>  	int rc;
>  
> -	if (cmd->flags || cmd->__reserved)
> +	if (cmd->flags || cmd->__reserved[0] || cmd->__reserved[1] ||
> +	    cmd->__reserved[2])
>  		return -EOPNOTSUPP;
>  
>  	idev = iommufd_get_device(ucmd, cmd->dev_id);
> @@ -1242,6 +1245,28 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>  	if (device_iommu_capable(idev->dev, IOMMU_CAP_DIRTY_TRACKING))
>  		cmd->out_capabilities |= IOMMU_HW_CAP_DIRTY_TRACKING;
>  
> +	cmd->out_max_pasid_log2 = 0;
> +
> +	if (dev_is_pci(idev->dev)) {
> +		struct pci_dev *pdev = to_pci_dev(idev->dev);
> +		int ctrl;
> +
> +		if (pdev->is_virtfn)
> +			pdev = pci_physfn(pdev);
> +
> +		ctrl = pci_pasid_ctrl_status(pdev);
> +		if (ctrl >= 0 && (ctrl & PCI_PASID_CTRL_ENABLE)) {
> +			cmd->out_max_pasid_log2 =
> +					ilog2(idev->dev->iommu->max_pasids);
> +			if (ctrl & PCI_PASID_CTRL_EXEC)
> +				cmd->out_capabilities |=
> +						IOMMU_HW_CAP_PCI_PASID_EXEC;
> +			if (ctrl & PCI_PASID_CTRL_PRIV)
> +				cmd->out_capabilities |=
> +						IOMMU_HW_CAP_PCI_PASID_PRIV;
> +		}
> +	}
> +
>  	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>  out_free:
>  	kfree(data);
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index c570892b2090..886f24e3999f 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -505,4 +505,36 @@ int pci_max_pasids(struct pci_dev *pdev)
>  	return (1 << FIELD_GET(PCI_PASID_CAP_WIDTH, supported));
>  }
>  EXPORT_SYMBOL_GPL(pci_max_pasids);
> +
> +/**
> + * pci_pasid_ctrl_status - Check the PASID status
> + * @pdev: PCI device structure
> + *
> + * Returns a negative value when no PASI capability is present.

s/PASI/PASID/


> + * Otherwise the value of the control register is returned.
> + * Status reported are:
> + *
> + * PCI_PASID_CTRL_ENABLE - PASID enabled
> + * PCI_PASID_CTRL_EXEC - Execute permission enabled
> + * PCI_PASID_CTRL_PRIV - Privileged mode enabled
> + */
> +int pci_pasid_ctrl_status(struct pci_dev *pdev)
> +{
> +	u16 ctrl = 0;

No need to initialize ctrl.

-Vasant

