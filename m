Return-Path: <linux-kselftest+bounces-24948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D03CBA19584
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AAAA16043D
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BE32144DC;
	Wed, 22 Jan 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OyI+5Bk5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E5187553;
	Wed, 22 Jan 2025 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737560561; cv=fail; b=DqScPcdwUaF939lGISS2n20WadH3Or+v1gDTgr5zOsIFVQgcPQ2Ptx20jNaarrQ08OA/vOTLZBv55VYmjIz2V6Xv09Q1i1HmRQ5W3lWrq2yybKsVLnUS8Jlotx93QfjdsAN/N8XUJ0belY3KXislOuGXgjhEGCphJxJkEDaoXV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737560561; c=relaxed/simple;
	bh=KqFGnR44RDXIKEUJGs+oMlNwSnY05FctYTn05NwC68w=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=LD8TZ4iUAossUrspaBL409J+95p7yUE65agFzqCIq6k8gSegKkmHFBPcpfC7x6FbwzmMjBZApu1ATQ7RiPz0ePaZIuR1AnH8LzxDRY3SfrBEIU6xgdUUqd1Krfs5m/nr7/x6G3FrdsQSG2YqoQgYnDFJmhGEBr3eMRMrQUNl/7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OyI+5Bk5; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5edQBSOoIP5KtuM198Jai9dBUL+fPwC0yqyOHqc9Rud0Xv85+qQmrzsQ+dPVMlrr7/G6HfMgLnQdTw2S0LE5REaJ9vlHB112VaEnKRhjSbdLrq2UJIvBFFuzNP3h3GM8xzsigoJFFcboNt3hFQkcpzLDxgkaNV2nHdjPlnnODxhKiqcAKVKjZEqtG98/fMbXfKjAw1Dy8yIJsRwMbKj8sDzKnPjFscj0BT0ry9W6wie50RrH4LTwauWDOzqK7A4fcFlUuqWBTbP30vLjpC/yQcU+1hM+EIM2JOds5/Ita6AYLqoh1tliY85jz0mXZelnuyGs6HhYaJ5jfCqjPTpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KqFGnR44RDXIKEUJGs+oMlNwSnY05FctYTn05NwC68w=;
 b=dtjTs5LrnlDdI61pM+iWKc7/p1gpzeNFAo/PU/vhokbK5k1O5En097Q5VqlHWm/gnNL+POLYUIilr3Wzu7BgSRcWY06JIlL3QtD27J75ZM1WNDcJeUzyf2sENEmsQQTHRVp2pIj5Bs6LHrJ+TDTUpCe4xTaPMVSFbufGA4EW+loEUnBjwxledgWscldCMdxGtX2fmBnxZIovN20ILu3F+blZP1Sb6WmNnmR0pNEPC1GqPBSfYclQrD/7BjPih1v2dCyMxQ9TZGRWQqrQi3mmCbivxVMFSdU7hJeGHcE720qZh5BNJddys1Gt3e0bPC2wuiHmyZd6IH5j1G9ILifXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqFGnR44RDXIKEUJGs+oMlNwSnY05FctYTn05NwC68w=;
 b=OyI+5Bk5hSgxOZyr2ZqTvr/Yx2+sd+jx2xli7oL3KIuQYYynfBhBntCOcsWLvPflrj1OeXSgxG32dr4elC1hiL0lgu4jZBjkwXEBVrJIiSj5mMfytxdaiBa7bvG4G7Gwxek3K/KzxUyZlH3PmEfqQEFSlP/c/40pnI9g5YeZtMckJrBVfW9cWa1HBdAFYaWnVc7bocQYGW/pAlvPEEcThKr2K9JiohgFE93L8bGFEsEqeRhWdVTTjt+EZEpmUcL+zxD4MuhZ8ztOF2kEmoG0g/md522ua9D6dB02aoXVKS1KPD2uRSbATQJY0jQJoKBjDUQdycqvSaVH3jAVQyyE4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYXPR12MB9277.namprd12.prod.outlook.com (2603:10b6:930:d8::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.21; Wed, 22 Jan 2025 15:42:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:42:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 Jan 2025 10:42:33 -0500
Message-Id: <D78PT6GILTYB.2QVXGSIG7YO9Y@nvidia.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, "Ryan Roberts" <ryan.roberts@arm.com>,
 "Hugh Dickins" <hughd@google.com>, "Yang Shi"
 <yang@os.amperecomputing.com>, "Miaohe Lin" <linmiaohe@huawei.com>, "Kefeng
 Wang" <wangkefeng.wang@huawei.com>, "Yu Zhao" <yuzhao@google.com>, "John
 Hubbard" <jhubbard@nvidia.com>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "David Hildenbrand" <david@redhat.com>, <linux-mm@kvack.org>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Baolin Wang"
 <baolin.wang@linux.alibaba.com>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH 1/3] selftests/mm: make file-backed THP split work by
 setting force option
X-Mailer: aerc 0.19.0
References: <20250122124047.1216024-1-ziy@nvidia.com>
 <04002289-c78f-4e1d-b242-144dd53a62f8@redhat.com>
 <D78P942WWF1O.IKY64R8JAIJG@nvidia.com>
 <d66cea11-9522-43f4-8590-2e11ed43a8e5@redhat.com>
In-Reply-To: <d66cea11-9522-43f4-8590-2e11ed43a8e5@redhat.com>
X-ClientProxiedBy: BN0PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:408:e7::8) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYXPR12MB9277:EE_
X-MS-Office365-Filtering-Correlation-Id: 8441295c-3460-4315-c2c7-08dd3afb643a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BjcU1FekhiYWhBWExzUkJZbWF5TW1xblFZUlN0d1RnVGFWamJLbEliZy9S?=
 =?utf-8?B?M0p4VTRGNU05QXE2cEphVXFabWM5blVZSGJXdHcvbFplWmZaaHIzcFl5czJj?=
 =?utf-8?B?NjZSZ0RyUXhRSnpGWjhkbTBuTHhvN1VoZXA0Rk5VYWZxcEtVUUxMbGtmVWk1?=
 =?utf-8?B?Um5DR2pCK2FuUWtNdHgwTERLTU4vZFNBWHdNTlVSdFg3bjlCYXFRRTJmQkRP?=
 =?utf-8?B?bDZqVEpSRWMvZUsralozNVU3VDMweUg1KzFjc094STlySG5ZK3hPR1FYMlFy?=
 =?utf-8?B?NnBRR2pUanJqRVVCaUJ3a3MzY1p5bXlXWUc1WUdad3E3MWp1YW5CREV2SnNG?=
 =?utf-8?B?ZWVGUVpoWjdNbmxZYVI3STlYSWllWlZ2ZmMvUjdiOEJLNllEN2VTSmpqZjI1?=
 =?utf-8?B?THhzVk05TzFqM1RnTkdTcE5uY1J2R01NMmk2SHVYaTVJNEhkZlVJbkV6bjNa?=
 =?utf-8?B?eE9GRmhTRWtGaHdYODJDQVdtd25Za0thRnVSL1VvVURGb2VFZzRydnpzaHdi?=
 =?utf-8?B?SlZKK1FNSEt6L01vLzZSaE9HUUJkNm9XVGFZOFhhSnJTUm9zQ1N6NEtibXBj?=
 =?utf-8?B?SGF1TkRDOE0zOXRxdHpUdTBWM2ZSV3VtV1BtbmdXRk9UN0NIQ3gycmttL2xl?=
 =?utf-8?B?WmwzVmdSZUhtRmNNTEF0dS9EcmtaR2ZOZEtSZFpiV0JvM3RuU01GbnQ4UzZa?=
 =?utf-8?B?V0ZzRUpHZDlNbmphY29YdmFKaUM0NEFCV3psMngrYXZXVWhackRnQjVyN3E4?=
 =?utf-8?B?STJadnRsU0cza1NwcUlJa3cxUVBUc0d0NlFScGJkVlpjREZqaytMRm9OVG5s?=
 =?utf-8?B?NjFINTBUY3I2cjFPNy9YN3paVjFUcWk2OVdjVEZETWNiZkVjVEpwNXRySUhI?=
 =?utf-8?B?ZVZsbVNud1pIOUdzT0kxY285Q3Rxajk3ZldEWU8yZkR4bG1wMkhtVlFlTDVa?=
 =?utf-8?B?Y1pPeEpwTHRGODZva3VNRHJQY2lNWktVMC9rKzJ1MTF0QUFmNzBkWmgxRGpB?=
 =?utf-8?B?dUsvTHU0bGdZcUJnZWY1K1VObVJmTWJkV3BCK3lPakRRKzZ6Y0NuZXpSemUx?=
 =?utf-8?B?UGJHNnBVVnc1a3BUWVpZWWVsY3VIajhPWC9uR0JLZHZNUUNXTVVhaHlEK3g1?=
 =?utf-8?B?MjRyaWhod0lwUWJvNEFEM29FVFNwbXVSa1BYOWlmb3BjRGV4aXlOdXJNdWR5?=
 =?utf-8?B?Q1ppRkNHZHA4Tk1FdElKMkhzZzRIYXFwMWtPZFVDWXhLTU5YK0J3RXVxQkRq?=
 =?utf-8?B?RlpyN21aZ09sZlR6eS9aNHRrL1lMdFJOOGl6Z2hSbndMQU4vNXRHZE5SRlV6?=
 =?utf-8?B?dWFaWmVHTkxCdHBZaFNwUXNDVlpEU3lrdWVpV1VTRmZrR2Qyb0FyaEZXMWM0?=
 =?utf-8?B?MG1XdjMwT0hRMDByR3YrRlg4OXBGazBmU3B5Wks4K25wQ0JQWi9ERWVhc0cw?=
 =?utf-8?B?ajAvWmhYcHhTTHhpOGR2Q05GWloraHZQcjJJNCt6aE5QTng0YTdiNk5aSGYw?=
 =?utf-8?B?MWw0TUhVQ3FRbERHazJkZnJ0cUQycFZqSnRSS041UXNlUS9BcEl5TXlGSGFU?=
 =?utf-8?B?U005WEpsTGVlaVBwSHZLdUVRMC94Rm0wallPdDlVOGY3S0h0T0ZwRm5xNmxu?=
 =?utf-8?B?ZFBLWmd1MUttYXNnVmNKVDZTc1AxMlErNWtxb21VejE2ZTdxNUpuSk1wdDFL?=
 =?utf-8?B?ODl2OUdOMkN0MGIxZ2tyaFVvbW1nRkt1UmwxdkJ2L0JpT1V3UWJWS3FyaVhJ?=
 =?utf-8?B?ZWR3OWJXNmRnSjd2TzBxY3AzUWFvZzdrYk0wQ25hRTNJeXBKUVVwcWhXOGJk?=
 =?utf-8?B?RU9KNGNCQk1lbit2YS82TDl0ay9CZm80T1RTdEY1UDFlTDR4a3htWnVSRWwr?=
 =?utf-8?Q?EsGoJ50U9KLtT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VW4yRC9ncXlSOHd1MHRsK096TWVRSVJKQnUrRjJnNWdFNEE3QVFaenBiV2cw?=
 =?utf-8?B?TVZNcVhFSmgvMG9iZlFFTUozTFNwaTRmZjJJOUlONHUxeEJaenRNdFhrSmNY?=
 =?utf-8?B?M0taSGNPa3dvV0pmcVpXL24vRi90RzVZVzQwM0RVZVV4eWdZYjlsVmFDY0x0?=
 =?utf-8?B?cjY3TFpqZElzNk5HYlpVWTN2Y2EzOEtKeGhFSmo5SWNJR2VZb2lmY0ZjNWlp?=
 =?utf-8?B?aENEMHB4S2dSbmhIdlBkbit3T3lUdmdUUXpsdHhEY243dHBiRTg0SExhWmJs?=
 =?utf-8?B?UDVKNGJjQnhiK0lDenRoTjZBTlFpV3A3UkNrZERuODRlSk1RV2hLWGxpMlVV?=
 =?utf-8?B?M3FpeWVBa2JpVG81eHhJd0dITTZGMjBVUXpMUlRXa2tnL1ZpVW80M3d3akQ1?=
 =?utf-8?B?R04zRFpvdzMrZjYwcll5TzBxU1pYNlREMTNZWnNKb085U21YaGNqeTg0TWxm?=
 =?utf-8?B?dk1VVTNibGVYOFNzUUdha1hQdUdJMEtjWHRuUFlWOUFRNkkvWEdlMlZoTWNM?=
 =?utf-8?B?ejlTSGJqOFBPVVRsT3lrK1Q0eUpzOGJKdXNPTUpmeWxoTFpPellSeHgreDJ6?=
 =?utf-8?B?TkNzM3dwbkZaWm93dTU1eVYwN2RJL0FCRmF3dStkZTlIMmUxakM5Wjk1dGgr?=
 =?utf-8?B?Szc5K0g2UHUyNnRyZkVVRlUwOTM0L0RBN1pUeDZtWVM0RmxWTzBuOXhyT3BE?=
 =?utf-8?B?SldGR2tBRzFZc0pEQ3l1NXBmeEVOME55Vkx6eUJCbjVjK2dFelNHeEpQbUd5?=
 =?utf-8?B?WDUydytsYlB0cmJlaHpQSTBhbGxvQTdURUN2M1gvK3luUGthWXpNTng1d3dm?=
 =?utf-8?B?eTF2V2VreW8vVU5SR3ptdG52SFZMV3hTdFFpTXRWc1E3dTA3MHpJVDM4RXdm?=
 =?utf-8?B?cmx4R2FJZEM4VDFnYVVhQ05reEt1OGphVndnRWlSVk81OEV4bEpNOGY2SHc4?=
 =?utf-8?B?eldEMWdmM3NGZURpaWJ2RFYrd2tFTFpaZnkzMldvVVYwSVo2UnRIMXNoNWpq?=
 =?utf-8?B?QU9mMDkyN004RWg1dDM1bE1tN3ZRQTBDaVpSUmJVTDBlWDdOVlVkL3ducHc3?=
 =?utf-8?B?aXhnUmhRc3FzMmJ6dmQ2RnREekw4Zi82bGZNZU5vWWlyNlRxb2ZhbVhXVHFW?=
 =?utf-8?B?czY5aE5JQTBEaWJhWFowRHQzTkNCWjU1UDE5OVI3TVFKODdmSXpZZGljOE4r?=
 =?utf-8?B?VlZ3YjdiRXI3cThnVmZwQU1HMjh4eXdNY2ZXQUY5OUFaa1V5YzA5R2RLSEl6?=
 =?utf-8?B?SWFzSFhsUThnczZVSEE5Z1BEN1h3UU9FbUpOQTVZSWE0b2xab1dtK2RJVmFK?=
 =?utf-8?B?SjViTTYwd1Zybit2ajJjSWJOQUl5YTArT2FlSU95US91TWRoTzZwM0x2bWNN?=
 =?utf-8?B?Q0t2K2FQTFpmbGozQTJWbmJmclhESnA3YWQyVEd3NHZpVGRpVUN2UndkSWxG?=
 =?utf-8?B?TDVlb1NTNmFHWi9MSkQ3ZW1QQkVCRWp1UzlZZHlPOHpySnJLNnlnNTRVSzhS?=
 =?utf-8?B?MmFYbzh3L1k5bTZsZVVDQUl2RGZGNVdCc01vcHk5MkFIdm0ra3pkckE3ai9z?=
 =?utf-8?B?UVNnMlI3N01IU0kwNFhsVExDR3c4a2ZmTXdETVMxQk9sYmxtbHZ2WE1yNGcr?=
 =?utf-8?B?R0tYWUZadXNPb3FHV3I2bDRqd1pSdmh1Y2pBUWtzZDRjNElhZXY5VWZZbjJa?=
 =?utf-8?B?TkVrQ0JqRkNtVkxnRXExalJmYmdaWEtQQWRDK1hTb3RsRG1KRVk0SWM0QkpY?=
 =?utf-8?B?MTV0RlllcTRNcndJVW5QVlRMTFZTU2NrYVo4VFpkRzBmVkE1U3B1Z21BM0Fw?=
 =?utf-8?B?cnM0QzZIUEV0NUovOUR6bE82cndrMVlXU3NNdXN3WHh4cWVXa2RSNmt4OFZ2?=
 =?utf-8?B?VnV4Yi9HSVo2K2ErZk52MnlNby9SVFNWcWwwcXB1bTJXdXhIV0FOSThzckxY?=
 =?utf-8?B?WGhtMGF3MGRkTDBwVjFvdzl0anorYW9wYXZaVzRlc0Vlc2piUkVuNS9YSnRu?=
 =?utf-8?B?emYrT3d3Y2kxTTdWS0ZLQUdrSGxvT1UzWllHRzJDbm0wWXdweFJGMVViMFRs?=
 =?utf-8?B?SHFsTytPMmhVUkpRYWs5UDJHVCtZVXhzbXVFK1hkeVdPczEvVDFWbXZRZXlB?=
 =?utf-8?Q?xK8QjA4377mWZmYcxeQEHMNWc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8441295c-3460-4315-c2c7-08dd3afb643a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:42:35.0160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaBDxKCRU1qwU6HEi0kcQrpsk5KYkYA32LGCsxWJnozu4dyKFrGMEmRRt1yKLTL5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9277

On Wed Jan 22, 2025 at 10:27 AM EST, David Hildenbrand wrote:
> On 22.01.25 16:16, Zi Yan wrote:
>> On Wed Jan 22, 2025 at 9:26 AM EST, David Hildenbrand wrote:
>>> On 22.01.25 13:40, Zi Yan wrote:
>>>> Commit acd7ccb284b8 ("mm: shmem: add large folio support for tmpfs")
>>>> changes huge=3Dalways to allocate THP/mTHP based on write size and
>>>> split_huge_page_test does not write PMD size data, so file-back THP is=
 not
>>>> created during the test.
>>>
>>> Just curious, why can't we write PMD size data instead, to avoid messin=
g
>>> with the "force" option?
>>=20
>> It also works. I used "force", because I notice that it is intended for
>> testing. Using it might be more future proof, in case huge=3Dalways chan=
ges
>> its semantics again in the future.
>
> I recall discussing with Hugh in an upstream call that "force" is a=20
> relict from older times, so naturally I would have just adjusted the=20
> test case to trigger the PMD scenario. No strong opinion, though, was=20
> just wondering.

Got it. Let me change it and resend. Thank you for the feedback.



--=20
Best Regards,
Yan, Zi


