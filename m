Return-Path: <linux-kselftest+bounces-28219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18036A4E665
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 17:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3634F7A113C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 16:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F227F4F8;
	Tue,  4 Mar 2025 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C834TS54"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E435D27F4F0;
	Tue,  4 Mar 2025 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741105263; cv=fail; b=S7sUCkYXWK5b9WYS3otvOuoovB4+w/LG/aDY0tBjA1DDxCAZO5XOTdDu2p1viYlfu+z5I3hqN/tweZOznLpPTw900bOaxfv8/lsi/cP3T2G4stNYkkbbrB5RyjEeyJtYLnMyl6bCqKA/4Dt/Mxgy02QivYQ80UZyO69YoTIn25A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741105263; c=relaxed/simple;
	bh=o8o8qa59fMhgaq9klPi5iBFpHWXNtCscIKHOh0ZLV6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lYBcazDL4DsqCpFkI094XBt5s7nM8K36C9E1RzeGcR5/EpM/iT7GxZljlwjq8MZZUfu6SKSIhH8EYCSUQkPURlPGzfrywYxuw2LIBlDxDkcftm5ZDiQHPoGyCa87SJn+m5+OnpPyQMGCfEGX3ZYqabRoEVZV3CVSq1YskiQFESQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C834TS54; arc=fail smtp.client-ip=40.107.93.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWVXFNhpCbq8hOeT+kdUY34U6Yp4h0vpZiE0g1Lv6sfsnXfXahTW/sT33jVdsy4cGRZTg2a4djUlRG2VqN8ug5ZvVqWvYUw61u2mD7BUScPl2B6m4pI2P5vQMdRVK0nW5zyNl7Dr251wNRyty+QdMIAvT01QV0Nyq4W/Ctt4+bHuRiOWL/N1ZxoWo86vhVezF2dsQl02FtHvLx3ibiUlTtAbv+j31iC4l2+F/oH3M/lxgSzNA2+IbaepWFbh89TqbmagkRodITvLj9vzHenSl5Y8YjPhKAboCXllBSbdMA12dSh2uiUXXBDO9cZhMqCC68OVPMEQKTkHyZcoX0nWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/Pf2frN/N7QoGJtTvo7FdJar8vdpCISa68glX6p/OI=;
 b=tv08O8yrFNKA6sqPz4BZA3Etvc8x3F/NNWXF7kHdtPSpXEhElXAuq7a7AdPWgza2fGLut/OD5hDz3CQdLwco1xLEBjlEgi/EPbn+hAlR6cVKLCkNjBvbu1pbfmjFckqmip4UA7tFP8qDT7GEyn0i9BiSKAsevWepN5oIn9+ZzY9INMjMgWhYb6XgVxvNbo63gfrWXkVu3Fnrk9XQS7HC1iJcNETLFduh87DtYbtZZjMdJVfedJ+u0PuhbS2Kn3QtoNthxyxFv6aRC7hnq5tRJt8hKZwvyy2ZjjRkEpfci8TQkHmjZoG48YIk+sz0PCkzKs8G7AC5gg+bW4dDupGj0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/Pf2frN/N7QoGJtTvo7FdJar8vdpCISa68glX6p/OI=;
 b=C834TS54HmLsssZtWUOaUNfyC5yszdZahhZ9OXDi5ba4L0xRL7ogxuCbG0f4hGMNV2DU7q6SBijegdj59DBYQg1a4U637hnE8aYid6F/Jc+8adJvBK3W6EpHIBl0CDd6+i4pActHR34TLDSZiIsPJsaXs0CvkkvQJQcbmu029vhJEP6jfYgyxgT+kG6JUGdYcR1W5XciKVKDsozxnEfWAad1uvw824gH6qarkWGNKiWM+lvkyHJBNuup2rEqPjuzERo2OiyfqBhdy/ZgeofYZAGwJs8Q7bTaB4Z7bovrq0/Eh+VeWbEsg58JL6uPezHAdGdm+ecAi0O8/sqh6cgsDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN2PR12MB4285.namprd12.prod.outlook.com (2603:10b6:208:1d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Tue, 4 Mar
 2025 16:20:57 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8489.025; Tue, 4 Mar 2025
 16:20:57 +0000
From: Zi Yan <ziy@nvidia.com>
To: Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>,
 Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v9 2/8] mm/huge_memory: add two new (not yet used)
 functions for folio_split()
Date: Tue, 04 Mar 2025 11:20:53 -0500
X-Mailer: MailMate (2.0r6233)
Message-ID: <408B0C17-E144-4729-9461-80E8B5D1360C@nvidia.com>
In-Reply-To: <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
References: <20250226210032.2044041-1-ziy@nvidia.com>
 <20250226210032.2044041-3-ziy@nvidia.com>
 <2fae27fe-6e2e-3587-4b68-072118d80cf8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN2PR12MB4285:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a05dc9-a8b6-40e4-5533-08dd5b388bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0poUTI1SjIyMmRvR05JR2FudHVTQ2tBbDRjR2VaUUN6R2NNamdqMmlFbzZt?=
 =?utf-8?B?NHZpSE54dVVOcG1aNzlRTFhGTGdtRUd5TkRJU1ErTmt2TDFrd0RXRzlNLzRM?=
 =?utf-8?B?ekhGdkhDN3RaWGZoMXZ4QWNBbWpYc3V0Ty9ZdHRjcVoxSXhxRmE2eW9zeXFR?=
 =?utf-8?B?Lzk2L0Q2WWxINkhiaVlrMkdxa3dOUnVRK1VaRUNxZldocVEySktVM0JWZmZh?=
 =?utf-8?B?OXQzZ1Z5TGpmWkdJam9NYkhqTGI2UkJNN1VQNnV3UFN2RFBYb09HMEJGcmV2?=
 =?utf-8?B?THZMVEpxMUdRM2o5NHlMNnFkYnZnRWFGd053Q0l1Q2wxbDVLVjNQMWpjM1Bv?=
 =?utf-8?B?eTJSejdWRTlVaDgwZU5KMlpYNWhUQXhZWmZES294SVdkako4dWhQTTBEK2JP?=
 =?utf-8?B?S21NeTlFclJvUkdDdTh3cWpZUm5YWHAyU1l0TjUwN1V3eFZxRjVOZUdoNnNv?=
 =?utf-8?B?MlNyd0Y0Z0FvbC9LU25MOUtNNGhNRzBPNlRSMVRvOUxMTzMyWVoxQWpzdjcw?=
 =?utf-8?B?cWNBc2l4RmF5ekZQWmRxUFdDNTFqbFRzVDJ4aW5wOExuQUVQVXhZeldyTnBK?=
 =?utf-8?B?S0JwQUU0ajdodTBWSnpBQmcvQ2tndjlkQ1pMdGs5RUgxMERQaDdjb1JtZDFM?=
 =?utf-8?B?NXQ1RlZ2aDdzd3d3UU1ubWhWaEZXVW15TjZOdTRNTm11VUdyUjdRS2ppTW1r?=
 =?utf-8?B?R20vd1lOYjBtb3YyVnBaT0RBazdtdWNsVWRRR0g0Vk1OS21JcDVtczJCdkJq?=
 =?utf-8?B?ZkhCUlA4VmptOGdjZlZDYjA4clphbGY4NTJ4WlNIUWFUNFpqN2lqdm13cWw5?=
 =?utf-8?B?MVd5TGt4SzJFdWhYc2lRd3ZEM1h0U0hqaTVvWjY2V3d4U1NBYlgycU96cjVn?=
 =?utf-8?B?TURKMHRpb1ptTk1uVWJRR2VteGFiWkJrbmFZNFlHVHB0Vnh0WG9PbjUwWG9u?=
 =?utf-8?B?UGVxR0VtNC9ITHVWS1c3TkRLU2NsaEFLeUplM0lXZ0MvYnpuMkUwUHgrZjlI?=
 =?utf-8?B?SFFxSmVna1J1azRxR1RMN3hud2k3MjgzUnloUWwxSDlsaWhqcHFvNmxXaGxD?=
 =?utf-8?B?Ym8vQ0xWcjZ4VGJLUUdWNEVBVmhSK1picDlXUXB2OGg1ZWtKWDlqRUtZWmhY?=
 =?utf-8?B?ZWNMdk5kYk5rRnNEd0ZTK0FRdEhraC9zSGlLakZxTDZlLzBCR3d5eExzWkF6?=
 =?utf-8?B?RlZnNndmZEFnMjNFQVRXNzBQcjJNM29FWi9CalVwS01rS3pKR0dpZEJ1blR5?=
 =?utf-8?B?MVJhZElzRG1UTlg0Znpmc1M3VTQ3WHhjT0tDWklxK3ZaaGpmS0lUSk4vWWJt?=
 =?utf-8?B?ajJMZ0ZST0R4Z21KUVI4Z2d0U25iU3FMUDB6TXlKclByRGNlTlBLb0pObm41?=
 =?utf-8?B?YktQdUNGZ0NVUU80SkNvUm9jQzBCdmIwU3Y2WVN6ZW9PaW5IeGJTUWQ1cXhJ?=
 =?utf-8?B?VHFDOWgxQndRTkdaYzRtT0JLb0FJSDJFUFNlWVVmU2daNzNRNTVrQjhMMjFo?=
 =?utf-8?B?bWY3SldyMXA1ZFlnWS9FaE1ISlpoWi8zVUt6OG5EU2ZYWENaUndWamJJR0s3?=
 =?utf-8?B?ekU2bVlsMEc1Zmpqa1VNSXJsb3VPejNTUmREVnpUNU05Ykl4ZER2SmlRbjU2?=
 =?utf-8?B?Mnp4bVFkTWFBZWZQeUJESUJNUVZvcUk3ZEFqVzk2KzBENXQyVTVnSHJxL2JR?=
 =?utf-8?B?OEdmcmtHcEtGaFlHTXNhM29pa3RqYkUzL2tHVlhpWks2WUtGQithK2YyTFB1?=
 =?utf-8?B?Zzd0ZVdWaWdUSU5rSDlUUXVpRk1HbFhTcGU2dWlKWlgwb0RHZ3RyNkpOWDkz?=
 =?utf-8?B?ZVQxUXJOV0xUczJLNUxmL3NlRjVGRG9TdElXMzJCQnJhOUl4cEJVYU9hVE9J?=
 =?utf-8?Q?+Ejwj50sguypw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWlOQVgrQlcvSVBEMUt4MmRJZWY1K3N4Rm9IK1dteS8yM3Q5WDhXNXRobVdO?=
 =?utf-8?B?dy9INU8rMVU0NkRtUStKUUJwVlJsTHNUS2h1OEdYTmJHTzNUY25OY0pQREtH?=
 =?utf-8?B?Rzg5cGtKbWZvNUwyeGFhVEVmZGVzZlN2Vm8zRGpxaENONmJsQjhIYnNZNVNn?=
 =?utf-8?B?a3FDMHNEby82SzR3eHRzRko5NE5acUVzc0FxejUzTFRORTJOK3JtTithbldv?=
 =?utf-8?B?bUYxZk5DTXBDRDBCTVorUXM0azFhbU9JS1NVRmtuNUE1b3FNSUJwYkhXQ0tH?=
 =?utf-8?B?L2RiMU42OTBVQ2JXc0hSRUp1M2VJeURwaDN4K1BxVTBGaTFuNk5ydWhTYkxj?=
 =?utf-8?B?dkkzRjdPZDlYNFF5QWhOc0w1cm1qVytPZEdLZXJNVS9YcEpxRkNabjl0Tmg4?=
 =?utf-8?B?Z0lNT0NUaUFBUnpTVnI3amRJTitlNlNNVXo4aVNhYUhRKytnMVJVamxpVDQz?=
 =?utf-8?B?eUJ1NUUzQjFkdjZ1bzJYVVowTzREVTA5WTZMcGhMYjJHOStVbVdvcWZVeHZv?=
 =?utf-8?B?ek02L1F1dzhMRXdsa2ZNL0JwMWFuVVhNaU9sUlhMdjkwSHFFVTl1RlY0TGdD?=
 =?utf-8?B?TjJQUGdqS0twWm5mV2kzbjRRYy9qMXZwN1JhaE5Dem9GZ2ZWaklwZVJCdWd2?=
 =?utf-8?B?SzdaRSs4TGdaM3IxV25TWFlHMnB5LzhQMkh4a3RiQTQ3OHV3QVVLbjQvdDVm?=
 =?utf-8?B?V0xsS21IMmFWU3JGR2x1d3lRNFVzZ2R2WkRZM3JZWjRhV3ZDYnpBVlZHeHRi?=
 =?utf-8?B?NWxCcndmTjFxNXdsWjkyNUJSTWhvRlF2QmgrbXQ2NG9nNm5DTnFlNFpzRGJW?=
 =?utf-8?B?M0VlRHpQUDRXM0duc1AzUzhBczl5Q3JuajM0OFZBWEpESE1VQnpSdkYzdFRr?=
 =?utf-8?B?eHY3d2NjazlXQ2QveEQxR0VkSmFuOHZQNG9uQTAzdzkya3ZWMW53dDVKV0pM?=
 =?utf-8?B?bHlmRFNiYjR4TCtncHRxalBwcXlxck9yZXpwb2tJQnFMY2VsY3J5WEJkd2o1?=
 =?utf-8?B?U3NHSExVcmVQYmgxVkJTTzRlcTdzUVFEYjFKUVhEZjhWTnpUN2FJNkhXbnBr?=
 =?utf-8?B?aVRPdzM3eW4vWVNmYTdxQmVwbi9XTWRNNm5LWFlOZmltZWlLdnhlaERCTS83?=
 =?utf-8?B?RjhzdE9odk44SmRSREhjdElMTEsrQ2J2b3dONUVBRTZtK2NRRXNjazBUYURj?=
 =?utf-8?B?cE1meXptRXZkdG5hYzNHZmxwc1hUb0llK1FKdk1PRFhueWRNOHBia1lkOGFl?=
 =?utf-8?B?QTh1bk1UU2RTQUpJbUVXMzZwaForTy9Dck5DK3FHbUYvaWJKUVlxYUJqS09F?=
 =?utf-8?B?TlJQb2xYL3Rlb1QzVitJMUxFQk5pZ25POE4vTmdIWmJpc0NjcmdPd0s4a2NK?=
 =?utf-8?B?UWMwb2RqaXVIMW56ak45eDFqRCt3NUFsZ01MK25QQ1ZVQjZtT2xZL0tZRHhK?=
 =?utf-8?B?UmJIUjZLRkVYOHo5ZGxkWGcvRzlqVnJNLytlaGVNYnc3NzQ4VFlSVlNhdjJD?=
 =?utf-8?B?bk04KzFXM1d4UGlQTHp4MmRwd055bEZzWXBRbW1lODJhY1ErTHN4WmFOeXJh?=
 =?utf-8?B?UGxsejIzUjhIZ2kvZ2pGaHcwN1cyY3VXYk1NVXVHU3NBRVJsMTc3VWlYdEtH?=
 =?utf-8?B?TEJhbjBhU1R3Qm0wd0RUODFpbWFPdnRTQ3YySUhaNyttc0szR2pxZ2RhM0py?=
 =?utf-8?B?dXZ5QzlGUlBMVG5vVTUxZFkyR2FMaE5xRE5Wdm0vTHhzZ1daZUNJQVluOTN3?=
 =?utf-8?B?NlYwaWZYNUYwc1RabG9ncGdOZkIwT3JLWjVGS3JhMnFrVFhzcFNLZmE2UHFu?=
 =?utf-8?B?OW1KaGdZU3RxN0J3NlVYN2NvTUVBdHMwZ2d0RTRkK2hiUU5yZjJON3hnM1pz?=
 =?utf-8?B?QUpVTWRxb2pxMk50UlgxOUc0MFVrb3N2MkRGRHo3NTh5MkQzRkJ2MFNGNW9Q?=
 =?utf-8?B?ajNxNGVjK1QxeW8xY3dwZWIzTTF6U2tiNEo0REtnNjJWRVZ0ZmxPOHNmZnla?=
 =?utf-8?B?M2s0SnJ3UTRNVDg5K2JtaFVuTUZjVnhiaHFyV083WU1DaWNxVTNNbEp6cTha?=
 =?utf-8?B?T1FNd2czMVBVaEVFWlpxdHdoK2ZzVVdadVdUNDZrOU51bXRta0xKUjRab1ht?=
 =?utf-8?Q?eLHM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a05dc9-a8b6-40e4-5533-08dd5b388bb7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:20:57.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNCqQEb2YzJPCWlX5QWK4cJMkmr4UGhBOw5dLcX4fdI6koQnGme0GeEcGobQMc53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4285

On 4 Mar 2025, at 6:49, Hugh Dickins wrote:

> On Wed, 26 Feb 2025, Zi Yan wrote:
>
>> This is a preparation patch, both added functions are not used yet.
>>
>> The added __split_unmapped_folio() is able to split a folio with its
>> mapping removed in two manners: 1) uniform split (the existing way), and
>> 2) buddy allocator like split.
>>
>> The added __split_folio_to_order() can split a folio into any lower orde=
r.
>> For uniform split, __split_unmapped_folio() calls it once to split the
>> given folio to the new order.  For buddy allocator split,
>> __split_unmapped_folio() calls it (folio_order - new_order) times and ea=
ch
>> time splits the folio containing the given page to one lower order.
>>
>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>
> Sorry, I'm tired and don't really want to be writing this yet, but the
> migrate "hotfix" has tipped my hand, and I need to get this out to you
> before more days pass.

Thank you for taking the time to test my patches. I really appreciate it.

>
> I'd been unable to complete even a single iteration of my "kernel builds
> on huge tmpfs while swapping to SSD" testing during this current 6.14-rc
> mm.git cycle (6.14-rc itself fine) - until the last week, when some
> important fixes have come in, so I'm no longer getting I/O errors from
> ext4-on-loop0-on-huge-tmpfs, and "Huh VM_FAULT_OOM leaked" warnings: good=
.

This error should be related to the other patch I sent out on using
xas_try_split() in shmem_large_entry_split(). Great to have you confirm
it fixed some of the bugs.

>
> But I still can't get beyond a few iterations, a few minutes: there's
> some corruption of user data, which usually manifests as a kernel build
> failing because fixdep couldn't find some truncated-on-the-left pathname.

It is likely that this patch might fix it (partially):
https://lore.kernel.org/linux-mm/56EBE3B6-99EA-470E-B2B3-92C9C13032DF@nvidi=
a.com/.
Andrew has picked it yesterday.

>
> While it definitely bisected to your folio_split() series, it's quite
> possible that you're merely exposing an existing bug to wider use.
>
> I've spent the last few days trying to track this down, but still not
> succeeded: I'm still getting much the same corruption.  But have been
> folding in various fixes as I found them, even though they have not
> solved the main problem at all.  I'll return to trying to debug the
> corruption "tomorrow".

Thank you very much. This patchset has not got much review yet, your
help is really appreciated.

>
> I think (might be wrong, I'm in a rush) my mods are all to this
> "add two new (not yet used) functions for folio_split()" patch:
> please merge them in if you agree.
>
> 1. From source inspection, it looks like a folio_set_order() was missed.
>
> 2. Why is swapcache only checked when folio_test_anon? I can see that
>    you've just copied that over from the old __split_huge_page(), but
>    it seems wrong to me here and there - I guess a relic from before
>    shmem could swap out a huge page.
>
> 3. Doing folio_next() inside the for(;;) is unsafe in those configs
>    which have to look up zone etc, I got an oops from the "new_folio"
>    loop; didn't hit an oops from the "release" loop but fixed that too.
>
> 4. While correcting anon versus mapping versus swap_cache, shortened
>    the lines by avoiding origin_folio->mapping and &release->page.

All these fixes make sense to me. Thanks again for your effort.

Hi Andrew,

Do you mind folding Hugh=E2=80=99s fixes to this patch? Let me know if you =
prefer
a V10. Thanks.

>
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  mm/huge_memory.c | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0e45937c0d91..9ce3906672b9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3612,7 +3612,9 @@ static void __split_folio_to_order(struct folio *fo=
lio, int new_order)
>  		folio_xchg_last_cpupid(new_folio, folio_last_cpupid(folio));
>  	}
>
> -	if (!new_order)
> +	if (new_order)
> +		folio_set_order(folio, new_order);
> +	else
>  		ClearPageCompound(&folio->page);
>  }
>
> @@ -3682,7 +3684,9 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  	int ret =3D 0;
>  	bool stop_split =3D false;
>
> -	if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> +	if (folio_test_swapcache(folio)) {
> +		VM_BUG_ON(mapping);
> +
>  		/* a swapcache folio can only be uniformly split to order-0 */
>  		if (!uniform_split || new_order !=3D 0)
>  			return -EINVAL;
> @@ -3750,9 +3754,8 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  		 * is new_order, since the folio will be worked on in next
>  		 * iteration.
>  		 */
> -		for (release =3D folio, next =3D folio_next(folio);
> -		     release !=3D end_folio;
> -		     release =3D next, next =3D folio_next(next)) {
> +		for (release =3D folio; release !=3D end_folio; release =3D next) {
> +			next =3D folio_next(release);
>  			/*
>  			 * for buddy allocator like split, the folio containing
>  			 * page will be split next and should not be released,
> @@ -3784,32 +3787,31 @@ static int __split_unmapped_folio(struct folio *f=
olio, int new_order,
>  			lru_add_page_tail(origin_folio, &release->page,
>  						lruvec, list);
>
> -			/* Some pages can be beyond EOF: drop them from page cache */
> +			/* Some pages can be beyond EOF: drop them from cache */
>  			if (release->index >=3D end) {
> -				if (shmem_mapping(origin_folio->mapping))
> +				if (shmem_mapping(mapping))
>  					nr_dropped +=3D folio_nr_pages(release);
>  				else if (folio_test_clear_dirty(release))
>  					folio_account_cleaned(release,
> -						inode_to_wb(origin_folio->mapping->host));
> +						inode_to_wb(mapping->host));
>  				__filemap_remove_folio(release, NULL);
>  				folio_put(release);
> -			} else if (!folio_test_anon(release)) {
> -				__xa_store(&origin_folio->mapping->i_pages,
> -						release->index, &release->page, 0);
> +			} else if (mapping) {
> +				__xa_store(&mapping->i_pages,
> +						release->index, release, 0);
>  			} else if (swap_cache) {
>  				__xa_store(&swap_cache->i_pages,
>  						swap_cache_index(release->swap),
> -						&release->page, 0);
> +						release, 0);
>  			}
>  		}
>  	}
>
>  	unlock_page_lruvec(lruvec);
>
> -	if (folio_test_anon(origin_folio)) {
> -		if (folio_test_swapcache(origin_folio))
> -			xa_unlock(&swap_cache->i_pages);
> -	} else
> +	if (swap_cache)
> +		xa_unlock(&swap_cache->i_pages);
> +	if (mapping)
>  		xa_unlock(&mapping->i_pages);
>
>  	/* Caller disabled irqs, so they are still disabled here */
> @@ -3828,9 +3830,8 @@ static int __split_unmapped_folio(struct folio *fol=
io, int new_order,
>  	 * For buddy allocator like split, the first after-split folio is left
>  	 * for caller to unlock.
>  	 */
> -	for (new_folio =3D origin_folio, next =3D folio_next(origin_folio);
> -	     new_folio !=3D next_folio;
> -	     new_folio =3D next, next =3D folio_next(next)) {
> +	for (new_folio =3D origin_folio; new_folio !=3D next_folio; new_folio =
=3D next) {
> +		next =3D folio_next(new_folio);
>  		if (new_folio =3D=3D page_folio(lock_at))
>  			continue;
>
> --=20
> 2.43.0


Best Regards,
Yan, Zi

